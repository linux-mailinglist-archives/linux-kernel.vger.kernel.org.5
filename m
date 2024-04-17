Return-Path: <linux-kernel+bounces-148095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911038A7DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A1F1F2335C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559C7BAEE;
	Wed, 17 Apr 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzMNYHiF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320E6F068;
	Wed, 17 Apr 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340890; cv=none; b=MG14JFPgRQgoW1/GDeEkxmQrhN9CeOqx+JrEytkGl+DQem98ebJDx3NjbCfnMhufemmsS1rOQ8soRb0USAIY9sWffsx4L8VYECAygZMgROgqs6mYUMluqW3yA3Dzd0eksN8qd4PmDCWaTdz7tFzLSZhEFx+KvlH3dV4fBMozy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340890; c=relaxed/simple;
	bh=+AHxkBxgK0JVVQSGYJS1zewwUaQq0VBfzWVYWCsdqJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTNgYcrgbbxGDYJdhI2j2cy7Z2Jje+n/oWEZ+rQe5hppXZ8cTdvRQqqh+LGsTFPJ5dlRHGWbWfHCmixIREVidxAKfI8GkB0yB4hBYchBbYYlXnOpp0+2KezdmWVQUGuu5O+S1S435AfiiLHVu86CUmLk6mcTrkG01BuoFqFonOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzMNYHiF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713340889; x=1744876889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+AHxkBxgK0JVVQSGYJS1zewwUaQq0VBfzWVYWCsdqJ0=;
  b=mzMNYHiFIB3UQWJPN3grGTiBRUcZaBshJGEpUNghduJHcpM79o2+8HrO
   W1Kp8Dw6K756ATSyTEsqweliioO5z8imzs0ZbBu7XPuYwBzHKBkK3M4rQ
   C70tZXZCSTSQRzi/6r/Z+GCpXxVmJzT/Bf75bQxTv42ZIqKCbVe/CYeJW
   OJTUfvHkKBWfIxZLLEPt8Oe+ex6/hYkA++t+xFh225+fISJxFJmcOUSEX
   CDCVvPZOxbjJlOxM3Etyfz8laiNKNZGMttu4hB6HUKR2jOrR7K33X4Mec
   slsgiQEKZsPA0tVw0IcGbpOGRxFCV5SfyeNXQqwksUTKFeBJN3XEItKf2
   g==;
X-CSE-ConnectionGUID: FdCnuTpwQjSxuXsnHN0EQg==
X-CSE-MsgGUID: pNXAYMt6QLKuwpksWjFJiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8645469"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8645469"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:01:29 -0700
X-CSE-ConnectionGUID: B+QfucwGScGx7lVtv3A5OA==
X-CSE-MsgGUID: Fe65QYkKT6Cu91ekTALwTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22619310"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:01:23 -0700
Message-ID: <f75809bb-1594-4bcd-9362-5aee8df04375@linux.intel.com>
Date: Wed, 17 Apr 2024 10:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 71/74] x86/cpu/vfm: Update
 sound/soc/intel/avs/boards/es8336.c
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212257.10009-1-tony.luck@intel.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240416212257.10009-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/2024 11:22 PM, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   sound/soc/intel/avs/boards/es8336.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
> index 5c90a6007577..6c86c581877e 100644
> --- a/sound/soc/intel/avs/boards/es8336.c
> +++ b/sound/soc/intel/avs/boards/es8336.c
> @@ -18,6 +18,7 @@
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
>   #include <sound/soc-acpi.h>
> +#include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
>   #include "../utils.h"
>   
> @@ -153,9 +154,9 @@ static int avs_es8336_hw_params(struct snd_pcm_substream *substream,
>   	int clk_freq;
>   	int ret;
>   
> -	switch (boot_cpu_data.x86_model) {
> -	case INTEL_FAM6_KABYLAKE_L:
> -	case INTEL_FAM6_KABYLAKE:
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_KABYLAKE_L:
> +	case INTEL_KABYLAKE:
>   		clk_freq = 24000000;
>   		break;
>   	default:

Any chance we could adjust topic to follow subsystem rules?
Something like:
ASoC: Intel: avs: boards: Update defines used in es8336
or something like that?

