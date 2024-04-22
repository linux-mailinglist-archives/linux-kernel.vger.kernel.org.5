Return-Path: <linux-kernel+bounces-154043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620128AD681
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1663D1F21E69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D71CD0C;
	Mon, 22 Apr 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gc3VZ3EH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEB18EA1;
	Mon, 22 Apr 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821081; cv=none; b=nQGtMBwfJje025ZdIwuHA3Gbj71zGfOMpXqcwvLLg7G7+kS0ynUjSxiOH2OSYL07l0/IkSHPgZH6bxmTs/TAhoZGV7bFf3IGL8hnU6goquTPDxqLhYlIk0owoTrmmhwpJ3im3WwyvSvU3QtawOAkEH3dG7lUCP/MpPj8i8SDM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821081; c=relaxed/simple;
	bh=KeQhQEZ8pRcakTBQ9PKDBftDt52xxSsucNhl6xG9XeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5AQUTFnRs6wC5HPKEhOHSd+se99J1SianRBhX0Z52VbBLCnJvp58hQsAoFjDNM4fRJKgqXqkQgu4cX1327yxlOh9lwOz9p+MQ9vR4NPzSD1rsRxXhcgW7Vir09HgFyADhLM0bzPTsojocveDbu6sJZIl9IG0GCSpyQ68Zbk7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gc3VZ3EH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713821080; x=1745357080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KeQhQEZ8pRcakTBQ9PKDBftDt52xxSsucNhl6xG9XeA=;
  b=gc3VZ3EHil+uqRi111FQRIHbchAgKAkUTtdUrQ8w7vo2fwdnRvYAbrvt
   vOD+cbP1bYa7W/WonbHxmvXrpizdb/WGT9o5ESN8OsP/CAYIoWzQ0eRY5
   9QYub9CbGy2NjOvAfCUMzL3Nr5sHYfdV1+6Gp84BxHVsktVAGOtYBRjwp
   Q8HY4rf8dr2g/8M0HRNlVNGnfTehaDrrfaRkiZ9mQxCiDfKhMFhxjwiiT
   P4btRI77ic95a8cE7oqVbKQ1n4zRxrSQjk89Xva9DIMSbNAeq1bnSIAOg
   SKGBrCbCZddiHnF5K98XQUHZr4Y7HL/JaOkr5sXUBAw7lwTw0fayfw1kn
   w==;
X-CSE-ConnectionGUID: 4wS88JDaS/Kf2/VEkscUCQ==
X-CSE-MsgGUID: Y3Wfka8TQbKC6zLHtFyRFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9491469"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9491469"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:24:39 -0700
X-CSE-ConnectionGUID: wTTDihldRN6BR80zwReOvg==
X-CSE-MsgGUID: fSmU2ufDRNW71eOumkykEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24764444"
Received: from leozhang-mobl.amr.corp.intel.com (HELO [10.212.37.174]) ([10.212.37.174])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:24:37 -0700
Message-ID: <eaa0c99a-3b41-4444-906c-d2f005d326b9@linux.intel.com>
Date: Mon, 22 Apr 2024 16:24:36 -0500
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7490bce3-3bd6-4beb-b8be-d47a6b0a30f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>>> There are multiple reasons and benefits for const, like compiler
>>> optimization, code readability (meaning) up to security improvements,
>>> e.g. by some GCC plugins or marking rodata as really non-writeable, so
>>> closing some ways of exploits. There are many opportunities here, even
>>> if they are not yet enabled.
>>
>> Possibly, but the SOF core does not know if the structure it uses is
>> rodata or not. Using the 'const' identifier would be misleading.
> 
> How so? If core does not modify structure, it should take it via ops,
> just like 100 other widely known structures (see checkpatch). Why is
> this different?

I don't understand "it should take it via ops"

We are already fetching the structure with private_data.

>>>> that's a different interpretation to the 'software' view you're
>>>> describing. "this structure will not modified by this function" is not
>>>> the same thing as "this structure CANNOT be modified".
>>>
>>> Yes, but can we please discuss specific patchset then? Patches which
>>> change pointers to const have one "interpretation". Patches which modify
>>> static or global data have another.
>>
>> Just look at sound/soc/sof/intel/mtl.c... The core will sometimes use a
> 
> That's a driver (or specific implementation), not core.

You are making an assumption on what the SOF core is. The core is used
by ACPI or PCI drivers as a library. The structures are all allocated in
ACPI/PCI drivers and passed to the core library.

>> constant structure and sometimes not, depending on the PCI ID reported
>> by hardware. This was intentional to override common defaults and make
>> the differences limited in scope between hardware generations.
> 
> 
>>
>> int sof_mtl_ops_init(struct snd_sof_dev *sdev)
>> {
>> 	struct sof_ipc4_fw_data *ipc4_data;
>>
>> 	/* common defaults */
>> 	memcpy(&sof_mtl_ops, &sof_hda_common_ops, sizeof(struct
>> snd_sof_dsp_ops)); <<<< THE BASELINE IS CONSTANT
> 
> Yes, I saw it and such users are not changed. They won't receive any
> safety. But all others are getting safer.


Maybe there's a misunderstanding on what the 'SOF core' is. This is just
a helper library that are used by the PCI drivers. The core has zero
knowledge on anything really.

> I really do not understand what is the problem here. In entire Linux all
> of such changes are welcomed with open arms. So what is different here?
Adding 'const' at the SOF core level does not mean that we can treat
structures as rodata. It only means that the structure is not modified
by the core library. Not the same thing.




