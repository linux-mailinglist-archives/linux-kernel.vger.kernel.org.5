Return-Path: <linux-kernel+bounces-59918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABB84FD51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466128688F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237686126;
	Fri,  9 Feb 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rrT5F68j"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713E7FBBC;
	Fri,  9 Feb 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509110; cv=none; b=WAh3Ry6Tv9s1CxUIYZ25Sjt3RpB7eq32bHuzw9KfFDT3QLeMBPONsRGfT11GdQy6j5lGp9ZZfYLXj5I6oTgBaBkv06LO96q8WY0ic8ApfG7vLvDM7No7LALMhCCgfakXlKbJJBE53jR3JoWV3ndaXroXRXuyrcGK/rOLB/oC6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509110; c=relaxed/simple;
	bh=PdP7RDXlYkTsPbDHl2LkBqe7dqJfRcj2pQrAYr7vqTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPFpCkPPMLOxESyme6Z8SoJZVFJsJ37RLmxTi8eA84aoAo/zMJpX/kWvPOqxJggZ10Lghegxu/O6uQYcWOr0iLcRdhemmQMB5KyFDZLEa5aT5gmGajazMLocXUma5RVRY1awm0Yi6IoyPZUETB2WNS92A4A14Frn54wXWN10CPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rrT5F68j; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707509101;
	bh=PdP7RDXlYkTsPbDHl2LkBqe7dqJfRcj2pQrAYr7vqTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rrT5F68j04JiYo4o7NeGlwhfkcOQWxDNCNbJvnZ0+8MoC0Y9hlsVQm5w+/tX7ZaIT
	 +xAwx03LNBnJDQLFLTyS5/qYKRu1Gg/rKyXCdmlX2Z1ExxweiG3MweFNRasHZsXH8G
	 r6E3JHNAhxxZi9zO7oLCKqam/GVqzMIE+13lpfy/SQqMEPyPmyTsm+beDgjH3NNzc7
	 EaoxWT4/4ZxBq4YYEV4aCrRBTwTwXMgHjCqHfZ7txEElunB8Cxhz7n4j+zMLbohCHI
	 3BnZ16L01J8MuXL6zDqM0BXHZY3lo48CgH7NRA/zXymzoofFx5y2a2c+T/i6wvd/YV
	 xQ50M2W3finDw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79DCF37813FD;
	Fri,  9 Feb 2024 20:05:00 +0000 (UTC)
Message-ID: <d9e6ba68-180d-4ac7-9aa9-b9972e1e9f71@collabora.com>
Date: Fri, 9 Feb 2024 22:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: Skip IRAM/DRAM size modification for
 Steam Deck OLED
Content-Language: en-US
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240209122810.2258042-1-cristian.ciocaltea@collabora.com>
 <f4b87510-4f55-4364-960f-5870c4d86874@amd.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <f4b87510-4f55-4364-960f-5870c4d86874@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 14:49, Venkata Prasad Potturu wrote:
> 
> On 2/9/24 17:58, Cristian Ciocaltea wrote:
>> The recent introduction of the ACP/PSP communication for IRAM/DRAM fence
>> register modification breaks the audio support on Valve's Steam Deck
>> OLED device.
>>
>> It causes IPC timeout errors when trying to load DSP topology during
>> probing:

[...]

> Programming ACP_IRAM_DRAM_FENCE register to modify the size of IRAM and
> DRAM and it's noting related to signed or unsigned fw_image.
> 
> This ACP_IRAM_DRAM_FENCE register writing need to do before starting sha
> dma. 

Unfortunately it doesn't fix the issue - I tested with the psp_send_cmd()
calls moved to various positions before the line

  snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RUN);

and I keep getting the IPC timeouts.

However, if I simply comment out the second psp_send_cmd() line

  psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | MBOX_ISREADY_FLAG);

the problem is solved, even when the first psp_send_cmd() is kept in the
original position.

Anything else worth trying?

Otherwise I would rework the patch to add a dedicated quirk for getting
this ACP_IRAM_DRAM_FENCE processing skipped for Steam Deck OLED.

Thanks,
Cristian

