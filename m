Return-Path: <linux-kernel+bounces-14168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B668218AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA7F1F22147
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F8611E;
	Tue,  2 Jan 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxvC1E0L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BFCA64;
	Tue,  2 Jan 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704186479; x=1735722479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ilO5IzhQ3Hwvx3JB2WQjM6kgLpNd1YFCiNdkM3lmNDU=;
  b=VxvC1E0LDFpmnAAo975IjzJ+4JWxPweMKF1a5zAKP8nY/vBjFAR78/dz
   hYxYo59mNqz4mtPUmo5Te4wBaReUmAlD5Rh4iYbyGRvSPUen5kt2lffnG
   5tYCgxfq3AXAJlCcSDgYqoZpmFcMfWBErGeg21DvlfpeaoX+sTWtXYrps
   6z+ExnV0JOos/ykCbA4AD6LoyQ9jpxqGmHF/X9RrHI7aSmb4/Wdf2O6Gl
   1b5izKSUfbxhu35YZcQPpN2q9/ni/mKBMMr1aWzGD4whfXU1o/xaALCHk
   0GBYuIMboarg4sGlDZBPquqfrLWzDYe7jSHPw6HgxX+0KVnftVoGI8xr+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4192271"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="4192271"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="772784129"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="772784129"
Received: from jomolloy-mobl.ger.corp.intel.com (HELO [10.252.51.93]) ([10.252.51.93])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:07:54 -0800
Message-ID: <3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>
Date: Tue, 2 Jan 2024 11:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
 <87sf3lxiet.wl-tiwai@suse.de> <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
 <874jg1x7ao.wl-tiwai@suse.de> <ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
 <87plyovwg7.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87plyovwg7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/12/2023 12:03, Takashi Iwai wrote:
> On Sat, 30 Dec 2023 08:27:43 +0100,
> Dominik Brodowski wrote:
>>
>> Am Fri, Dec 29, 2023 at 06:11:43PM +0100 schrieb Takashi Iwai:
>>> On Fri, 29 Dec 2023 16:24:18 +0100,
>>> Dominik Brodowski wrote:
>>>>
>>>> Hi Takashi,
>>>>
>>>> many thanks for your response. Your patch helps half-way: the oops goes
>>>> away, but so does the sound... With your patch, the decisive lines in dmesg
>>>> are:
>>>>
>>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
>>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
>>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
>>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
>>>> 	platform sof_sdw: deferred probe pending
>>>>
>>>> With a revert of the a0575b4add21, it is:
>>>>
>>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
>>>> 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
>>>> 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
>>>> 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
>>>> 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
>>>> 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
>>>>
>>>> Maybe this helps a bit further?
>>>
>>> Thanks for quick testing.
>>> It shows at least that my guess wasn't wrong.
>>>
>>> The problem could be the initialization order in the caller side.
>>> Can the patch below work instead?
>>
>> Unfortunately, no:
>>
>> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
>> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
>> sof_sdw sof_sdw: snd_soc_register_card failed -517
>> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
>> sof_sdw sof_sdw: snd_soc_register_card failed -517
>> platform sof_sdw: deferred probe pending
> 
> Hm, then it might be the logical failure of that commit.
> Peter?
> 
> Without a fix in the next few days, we'll have to revert it before
> 6.7.

The fix for this was sent early December:
https://lore.kernel.org/linux-sound/20231207095425.19597-1-peter.ujfalusi@linux.intel.com/

It had the correct Fixes tag but it did not made it to 6.7-rc while
a0575b4add21 did made it.

Mark, Takashi, can you pick the fix for 6.7 (it is in -next)? I think we
might have time for it to land?

-- 
Péter

