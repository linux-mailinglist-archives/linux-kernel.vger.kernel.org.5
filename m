Return-Path: <linux-kernel+bounces-158140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFEB8B1C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF01C23F03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85066EB51;
	Thu, 25 Apr 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGlez0nR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E46D1A3;
	Thu, 25 Apr 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030786; cv=none; b=RWnDkyO6nVmfauppAlE19War5Gu2CwF9M+CzM1JTl6Zyn0YNMvFXs5tzzC8I0oVOwF5t9vDWxV0E00io4mFGomBrcy41tD8C5Slq/7ixN5IL1/tkg63cUaiV6p7RIiWCtlwpEMqIvg1ON0C1XSOP6JotS3vwnsm+qCnZsB6GC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030786; c=relaxed/simple;
	bh=5PBcStouiAL0LL01bVFaRv1aQRBdnBtOYC7EAUalJIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcorYYHYMsX3Fm3wna/9Xfn6QdBoDumcePptUB8RE/7Fj+YjddDYdMJvHd9wkViZMviW2q5Q6KmxFBcUtg4rkqyngZZYyD8XRwW7gGWQrft/GCUgPjf6T8E5JRcGJjUZN/K0W5fo+7wJqf8jdfVX5iQzgOKJn/3q1/D1dRzpUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGlez0nR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714030784; x=1745566784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5PBcStouiAL0LL01bVFaRv1aQRBdnBtOYC7EAUalJIs=;
  b=ZGlez0nRdLGzuIiHFuriZVQnAlKcbNU0AXTK5I6dhQfXaPdCu9q9e+am
   3kYjxbn9pN4rmhLl1I19NYm3sxykpV2kv8L12FLQtIljoOow91f7dtQ/4
   M+2HjeaxNiNWyqEJpM+sGSaI3e4xFIk6Qx4OOLwGENJTJ/fKsGwW4dfL/
   EqYNEp48NufyTbWTUK+aoATZyXOOji2CdsdN3j5P1TGmfoJqf19rYvXWd
   4AiqyYu1Et8pNUsaZ+8ZD1SJbaT7/9t5nyL9s3s0UpZ2eJ2gG9dwW0Zo7
   Q5EEdql6NkQqN1eq1fh3AkflyzKSs8yeogVxyOMBoo+pb0NIRizwKR7mP
   g==;
X-CSE-ConnectionGUID: DX0rT5GhSH6ZTfmBDoimMQ==
X-CSE-MsgGUID: M5FAfVIzTW+yCzoxDnoMtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13483131"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="13483131"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 00:39:43 -0700
X-CSE-ConnectionGUID: H8E5lNTsSWaGPcjdPXBkEw==
X-CSE-MsgGUID: Bp1BJxZUTxCddboCRR0itA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29614232"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 00:39:38 -0700
Message-ID: <cf878edb-2e99-4e21-9ccb-a1867b37feaf@linux.intel.com>
Date: Thu, 25 Apr 2024 09:39:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 68/71] ASoC: Intel: avs: es8336: Switch to new Intel
 CPU model defines
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181550.42466-1-tony.luck@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240424181550.42466-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/2024 8:15 PM, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Thanks!

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>


