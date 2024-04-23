Return-Path: <linux-kernel+bounces-155508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35B8AF32A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E611F24FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE813CA81;
	Tue, 23 Apr 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTvvMcLM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43913CA82;
	Tue, 23 Apr 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887825; cv=none; b=ovDgBoHHI0u1xcib87u0oVtpZaKc7du6D1VjG6orAfAF9fUvuEEdzLlmyPxEwcyLg+JnJhaJ059MybusoihooDwFYinOKQSFkiI8SVbHglYwLs0fRYTTMioPqD7qeFI+O8M4tKvgcncTowc6c9ARyVY4TOrDC3Inb2af/9qJQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887825; c=relaxed/simple;
	bh=Ao7OtFR6Y/gnMao2EDCJiWEcU30WgANyFzpo/uxrtFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coiHfoBgCrd36QBESezXw7WF+Pm9uwiYnzd8ZX4wWnsLhntiehoXoDGdx0XL6mdT3nftXMB+D1gptqn28hq9YIUCCVfRzOKjehkJ2WfPwFJLu+iz+7tUauENiX6X4Do1xRRsTG/v8m/+BNnE5zSH2EbM/U4Aw3io4oSBjmCRhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTvvMcLM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713887824; x=1745423824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ao7OtFR6Y/gnMao2EDCJiWEcU30WgANyFzpo/uxrtFM=;
  b=HTvvMcLMVuSg6mpKJlEsThpGUuovfAZ9kWbOLHF4WTv3ecgBOinKz8X4
   Jgl9n3jPGgqmUzw5kC+qmrPsw7aK2cMEIbcwBAZN0IB6EQ8AcrNOKWYPB
   +wzeWbObw5MEceBITnkkzc0m7i9ziJjpl2MZ9L5MgrXgksVn+P5Q3Mety
   Df3vY0Il6VWOyBvYd8u9LNYj6gRe1ligOdcKdoahLXW2UJW+Dy6NJB+CF
   ZMoh66b3plPDgbTjis5WQLjgUQYYD9Ez3LYKHrm2qWdqez9WWn3dqnxUU
   rtn1uBLqBWUYDeiQWt9c7IM8FVJ5H0UAH+Hap3u9z2LVZkZB6P9zoY+rw
   A==;
X-CSE-ConnectionGUID: E3M+VWHfT8SLsFy2odAaPg==
X-CSE-MsgGUID: JNvgenu4Rqm6xITzb/MmHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12415285"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="12415285"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:57:03 -0700
X-CSE-ConnectionGUID: vO5xSsY6RmKdl51eWK21mg==
X-CSE-MsgGUID: en4GCTrdSViTMNvF3cDOIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28865302"
Received: from alexkiru-mobl.amr.corp.intel.com (HELO [10.212.38.129]) ([10.212.38.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:57:03 -0700
Message-ID: <735d6dbc-86e4-4747-9bd9-2574ead7d039@linux.intel.com>
Date: Tue, 23 Apr 2024 10:57:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] ASoC: Constify local snd_sof_dsp_ops
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
 <89f8f0be-2534-46c8-9058-cabea4f68568@linux.intel.com>
 <9d1eda85-32a0-4e53-86ca-ce3137439bd7@kernel.org>
 <d046d195-6fa3-4c52-bc5f-3e5e763bc692@linux.intel.com>
 <138ac465-1576-4e86-a05d-63f8acc6fb70@kernel.org>
 <3acfbe3c-8b83-4c40-83c2-437f963fd25a@linux.intel.com>
 <7490bce3-3bd6-4beb-b8be-d47a6b0a30f0@kernel.org>
 <eaa0c99a-3b41-4444-906c-d2f005d326b9@linux.intel.com>
 <aef907ab-1087-4f49-bea4-d43ee6cebb73@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <aef907ab-1087-4f49-bea4-d43ee6cebb73@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Are we talking about basic C now? Of course it does not mean that and I
> already explained what is the goal of this - the static or global memory
> in the driver can be moved to rodata.

the dsp_ops used by the Intel drivers cannot be moved to rodata in all
cases. the baseline is constant, all extensions for TGL+ are dynamically
allocated and modified.



