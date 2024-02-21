Return-Path: <linux-kernel+bounces-74579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB985D64B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539391F22BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD43EA89;
	Wed, 21 Feb 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i6pUQvx8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3733EA8C;
	Wed, 21 Feb 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513198; cv=none; b=ROf/DmQDx7WqBTnRqgZIVidxhZHWOcmRaUxqhk/Q9KOwcOuV4DiTG4+MjLzA1K2mBI7lJkArfjTPbDHnFk0walcP8B5KvLanv0BQrEkygOfmNa8F+HALq7ZNJCf6pXXntLX+qU8HdFib940Ip0IqSExXHU3BlgJpKDSlT9mXVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513198; c=relaxed/simple;
	bh=uy1rf0Pr28+uTu06AdVEPbjpIBBStpPPM0xFtbokN88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUWx00F2wzwRn1FLVfRpfsvn240QnWeComZcE8YoiTdoqtTv9wgpOgCrMryeGyPu6LjubxJFRwQ0k2VuxdX/0CTymTSysoXblC3tjHLArTprrn7cgCYIBA2jMUKW+9KKr3aq62NR8V1gOI+E02Sy9h2IeHp4aQC0KxogYtytn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i6pUQvx8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708513195;
	bh=uy1rf0Pr28+uTu06AdVEPbjpIBBStpPPM0xFtbokN88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i6pUQvx8rbN/trz0JN2PmNQX/vzgBUc+9+YFjze2aO+unN+G9BAAMa+17yaJlMHWp
	 e6pgzhPZe/1DVEec0HV1h2/lNsaIH881XtehfbAAz6j8fU8rKIIjbZ7Dej8OlQtWNK
	 Z9LaNZbhrEjp54H4lphfXTrHlq0NImnq4xWOZ0rKv6Ad7BOiWr6u7Fv2v6dAW1wLUI
	 wWPyeAN/7oPrmwAZ1L8OKU7s7pPveRQIn7cz+NuNCflTpi0C5Td6BC3qQa3L0xrPIv
	 MeejfsrRMdQRlktFwTY09VXXL4/LZd3u0wMqOgWUrPQHO3DWrPZwBRFIHXfTBngPgX
	 TX2mpEo73QGKQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0F9A93781FE6;
	Wed, 21 Feb 2024 10:59:54 +0000 (UTC)
Message-ID: <cd3fe134-1df6-4a6a-96f5-1ab91c7bf5a8@collabora.com>
Date: Wed, 21 Feb 2024 12:59:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: SOF: amd: Move signed_fw_image to struct
 acp_quirk_entry
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
 <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
 <54c35628-9897-4415-86c0-cf81c897840e@collabora.com>
 <dfea1acd-8cca-4840-b1d2-1891a15c8d5a@collabora.com>
 <9bac55ff-0720-4ecb-9dcb-59a5397c7077@collabora.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <9bac55ff-0720-4ecb-9dcb-59a5397c7077@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 12:35, AngeloGioacchino Del Regno wrote:
> Il 21/02/24 11:29, Cristian Ciocaltea ha scritto:
>> On 2/21/24 11:35, AngeloGioacchino Del Regno wrote:
>>> Il 20/02/24 21:16, Cristian Ciocaltea ha scritto:
>>>> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
>>>> signed firmware support in the driver via the acp_sof_quirk_table.
>>>>
>>>> In preparation to support additional use cases of the quirk table (i.e.
>>>> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
>>>> and update all references to it accordingly.
>>>>

[...]

>>> are you sure that a structure holding "quirks" is the right choice here?
>>>
>>> That probably comes as a personal preference, but I would simply pass a
>>> `u32 flags`
>>> and structure the quirks as bits.
>>>
>>> #define ACP_SIGNED_FW_IMAGE    BIT(0)
>>> #define ACP_SOMETHING_ELSE    BIT(1)
>>>
>>> flags = BIT(SIGNED_FW_IMAGE) | BIT(SOMETHING_ELSE);
> 
> That should've been
>   flags = SIGNED_FW_IMAGE | SOMETHING_ELSE;
> 
>>>
>>> if (flags & BIT(SIGNED_FW_IMAGE))
> 
> and this
>    if (flags & SIGNED_FW_IMAGE)
> 
> ... I have no idea why I added a nested BIT(BIT()) in there, something in
> my brain started ticking sideways, lol.

Yeah, don't worry about that, it's perfectly clear what you initially
meant.. :-)

>>>     do_something()
>>>
>>> What do you think?
>>
>> Hi Angelo,
>>
>> The flags approach was actually my first thought and I think that would
>> have been the best choice if the quirks usage was limited to a single
>> file (acp.c).
>>
>> Since they need to be exposed externally as well (acp-loader.c,
>> vangogh.c) and already using a dedicated member in struct
>> sof_amd_acp_desc related to the existing quirk, I found the "quirks"
>> struct solution a bit more natural/convenient to follow (I've done a bit
>> of research before and noticed other drivers having similar handling).
>>
>> However, as you already pointed out, it may also come down to individual
>> preferences, so I'm open to using the flags if there is not enough
>> reasoning to stick with the current implementation.
> 
> Of course the definitions should be put in a "common header" for that to
> actually work in your described situation, but it's not a big deal.
> 
> Mine wasn't a strong opinion: that does actually matter in case you expect
> more quirks (or something that is not a quirk, but a functional flag
> instead)
> to eventually get there... but otherwise, it's actually the same.
> 
> It's your choice in the end, I'm fine with both anyway :-)

Great, thanks! :-)

