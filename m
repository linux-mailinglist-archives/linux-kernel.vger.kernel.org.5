Return-Path: <linux-kernel+bounces-153878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515478AD467
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0F1C20999
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E2154C12;
	Mon, 22 Apr 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FF+OoRLd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA611154430;
	Mon, 22 Apr 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812027; cv=none; b=CSmEUoh0wgtbamWYcXAK8eKQsqXTtsl4qqnbFWQRMiQqv+oaL9o/cRALXpNVV1UOdawJovO1cUu7GSd1JmZOpHfj3heT0KBqvdr69LQ8Ug8MRZhUtKSpqAki5baDZH7Z0cttxSDt/CcILQr+Lzef4R0qcNZWF2MKilcfCAqfkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812027; c=relaxed/simple;
	bh=KdeYjdGtcF1JNqWj59Djb+4HReLocTqors5w6qaChgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bndTInB1gttlnzPkeMY9b10AYVK+huf1aDzgmhVxmO4gB7HL9vx93mrYxzeXVCOH/dxMLftVTeNthXftPaGrZQcf6KRzz9NWjZU9uHiR8JMorE+NULuM/OxlMfE+R7/yAkkWYFIh7obESGnjIM8folcwZpyNlEdWV+HDwsqBeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FF+OoRLd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713812026; x=1745348026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KdeYjdGtcF1JNqWj59Djb+4HReLocTqors5w6qaChgk=;
  b=FF+OoRLd1cwzMOBvP9UouXojG9MOaIF24OceqMWfiEdps6gz3MEX+VJb
   ip1Sb8ZTPtYMLBtaWen4xQYvlvEJNQxvW53/nf/6lgxGPn8aWgQ8nUQ7f
   4r3308M6EEAohSJzxw9LoALVeSOZmhs89zqsSTSIrjzSdAsXNkWYDML1d
   PKhIeusoV+eMZObEaj7ehaqNqA9NoijMHNF66nMwFptzkO6jECaqHgAah
   irHhZzt1i9bY3BtJezvmYLCRrSGIH2o3fmbIfYNE7JbFSAdHcW3M3iVhH
   wAKgIHt6nYzXYEie0SvZLCWv9kK0++kPXJZsyOgQmoMZ0X84GAwr+Hm+f
   A==;
X-CSE-ConnectionGUID: 6In1p2+MQcSRvkzw3d1WKA==
X-CSE-MsgGUID: EkAYlep3TrWxFBXQTC3jFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19977729"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19977729"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:53:45 -0700
X-CSE-ConnectionGUID: tFsgZtNdQGydqYsVjb23aA==
X-CSE-MsgGUID: /jA5vIZxQ96OJPcbpGXLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24621373"
Received: from leozhang-mobl.amr.corp.intel.com (HELO [10.212.37.174]) ([10.212.37.174])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:53:44 -0700
Message-ID: <d046d195-6fa3-4c52-bc5f-3e5e763bc692@linux.intel.com>
Date: Mon, 22 Apr 2024 10:52:17 -0500
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9d1eda85-32a0-4e53-86ca-ce3137439bd7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/24 00:43, Krzysztof Kozlowski wrote:
> On 15/04/2024 16:19, Pierre-Louis Bossart wrote:
>>
>>> The core code does not modify the 'struct snd_sof_dsp_ops' passed via
>>> pointer in various places, so this can be made pointer to const.
>>
>> The structure itself is NOT always const - the initialization itself
>> does have platform-specific changes, so what do we really gain from all
>> this?
> 
> In the context of these patches, the structure is *always* const. In
> other drivers, it is not, but they are not really relevant here.
> 
>>
>> some commit messages say the code is "a bit safer", but I personally
>> find the 'const' more confusing since the information that the structure
>> can be modified during initialization is lost.
> 
> Functions which take some data and do not modify it are easier to read
> if the pointed data is marked as const. Then it is obvious that
> functions for example is re-entrant. Or that it does not affect the
> state of other devices/core structures.
> 
> Additionally, the static data is safer when is const, because it cannot
> be used in some attacks.

agree, but here you are marking as 'const' non-static data.

> I really do not understand which information you lost here? Core does
> not change the ops, so the data should be passed as const as often as
> possible. If anyone wants to write a driver which does not use static
> ops, but somehow dynamically allocated and changed, nothing stops him.
> This patch did not make it less readable/doable.
> 
> The point is that these ops do not differ from other ops or some other
> driver-passed structures, which we have around 100 already in checkpatch.

I am so old that I remember times where we had to put things in ROM.
That's what 'const' means to me: a dedicated memory space for immutable
values.

that's a different interpretation to the 'software' view you're
describing. "this structure will not modified by this function" is not
the same thing as "this structure CANNOT be modified".

I am not going to lay on the tracks, if Mark wants to apply the patches
that's fine. I just wanted to highlight that the reason we did not use
'const' was that the data is dynamically allocated/modified and not
constant at all.

