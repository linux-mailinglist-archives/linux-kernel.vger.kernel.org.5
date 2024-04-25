Return-Path: <linux-kernel+bounces-158873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473568B2611
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E0DB249F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CA14D28C;
	Thu, 25 Apr 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5/K6bIR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6914C58E;
	Thu, 25 Apr 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061559; cv=none; b=EqH5u8dpd6TDMyZMVVsVlb/mg1vf8rl1y5wnYxnHoOSz6/pbsWKJ1Lf9AVS1Egf5cKtTjv9bvwBbI/zcSJTBosvAnOsTrqd5Oqa1Uk3zWcW27Lj5ViLZ/XqaVLO8HnFmjxYXQPbP1g2ECcRYmcEqTAnf3nz2LK1rSnGVhcqAMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061559; c=relaxed/simple;
	bh=5NE/lyOaUfLlW/OASHe3DgI9W5o4P0QFA65CKeaSAiM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gFxfAEow8uxDRR402JXvdHNcoVriCX80pAVaDmijKPseYDm3CxgF35ouUfkQGWPjxNNPXTmkCD+c8Lz3yU3VdmSKjcAY3/cJWi+sqt3dTPrHQg4Vut/LkpSRoOsMoTZV7vuSrWhHH33CnXAA07CCUjabD2yKnW2syjJGKcYYk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5/K6bIR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714061557; x=1745597557;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5NE/lyOaUfLlW/OASHe3DgI9W5o4P0QFA65CKeaSAiM=;
  b=g5/K6bIRKrGeq7LymE/tnim8X81Rp7a8IYeaNsldawIEWaiHj256paxo
   dByl3UATZowu1RcoaosdbzsPNrRuMSWPP0RvxAkOs4W0PFjHNn+coT36y
   995gkT52hH84oMdTxa+3oBaDA/Fl1i7Y7ORjxDtxqQI7590LlMPVA8XF7
   laCTYY9uAIjMy23Sf/iV5PMuFRiy2r7Tg2j1C46a7SoZQjJfI/TNXja3w
   RmOgxo1PzTTPgOVaxaU7ORFcx3sasypAG6SIWcPBbcNPdlFXDYXXjwFOg
   7AFQJrqU3VVzmBeLtIlOnhSTF5TelebnZtmJru1kfwaaNLdfiJib5k1Vp
   g==;
X-CSE-ConnectionGUID: aWI2pbaNRriy95fzpqz8Lw==
X-CSE-MsgGUID: vscR/ERlTXKA4RAyTWFVMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20376425"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="20376425"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:12:36 -0700
X-CSE-ConnectionGUID: 55tzMgBXTLCWFo6GfzAnFw==
X-CSE-MsgGUID: 1uyU9cEuQeOv5TAheGc1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="62607732"
Received: from mhillikx-mobl.amr.corp.intel.com (HELO [10.212.81.51]) ([10.212.81.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:12:34 -0700
Message-ID: <2f7f0dd1-14de-428f-94ce-fa03cce313fd@linux.intel.com>
Date: Thu, 25 Apr 2024 11:12:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
 <735d6dbc-86e4-4747-9bd9-2574ead7d039@linux.intel.com>
 <65a5837d-36b3-41bd-b03f-d4f93b30d5c8@kernel.org>
Content-Language: en-US
In-Reply-To: <65a5837d-36b3-41bd-b03f-d4f93b30d5c8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/24 11:06, Krzysztof Kozlowski wrote:
> On 23/04/2024 17:57, Pierre-Louis Bossart wrote:
>>
>>> Are we talking about basic C now? Of course it does not mean that and I
>>> already explained what is the goal of this - the static or global memory
>>> in the driver can be moved to rodata.
>>
>> the dsp_ops used by the Intel drivers cannot be moved to rodata in all
>> cases. the baseline is constant, all extensions for TGL+ are dynamically
>> allocated and modified.
> 
> Yes and these drivers will not benefit. Did I changed them here? I think
> I didn't, because then it would not compile.

So we do agree that's there's no benefit on any Intel platform released
in the last 4 years...

The CI tests [1] don't show any regression, nothing was broken on our
devices so I guess there's no further objection.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[1] https://github.com/thesofproject/linux/pull/4949

