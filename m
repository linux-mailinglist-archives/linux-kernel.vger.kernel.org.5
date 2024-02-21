Return-Path: <linux-kernel+bounces-74528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939BF85D586
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EC11F23A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B63DBBF;
	Wed, 21 Feb 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ngDaHeMX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8D3DB8C;
	Wed, 21 Feb 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511357; cv=none; b=IPxlvrUjHY9orKbnt3+eLbdDyzk3jvdvZ9/DNWC7T1vX2s0fsJhKl0ycAaKMO5OjhVs0c66v8sMu6wF7TW/SKX+KrDz1DyNJggangE4BSrPhcDoptRW46ExgkE9RClcM2+LBzwkfzF4KTcW4RPr+tUbcAKmEyHkljp3ORX78ESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511357; c=relaxed/simple;
	bh=b/vayIWLDtsUmI8fXxNGlG6nYPoITUw0CH4bXSObJPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BX12jvXvcYF/SEeQySr03RpUSe9prVDHnFE5dwxa5/MQCXcLeCLEji1qbMJ2uGO/60b8qxkFcJxobbfMjoQMtuL+kbr7Z12H6MIGW/w0FMobGS3BnaFLbKi8uyZX3+w1PFUVS3l+Vyg4T0rT5HDfTLuu7VdvjmiArRu2Mxb6N+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ngDaHeMX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708511354;
	bh=b/vayIWLDtsUmI8fXxNGlG6nYPoITUw0CH4bXSObJPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ngDaHeMXU2ybbKxtZzbZtmSibm8ifD7uFaPpAQcwEtJK4YBWIy5fNCr8iq5SVZw2l
	 2DL3mHWHJnE/SR34ywYw2rylhYIGsDNQRMyT73OkoTwpsqAavlsdjPS+etCKSs2Qwj
	 H+Ymaky4PyAlfn070DMAbiNnDZzSRHzsohMg0QR+vXmnGEzqYiZq3lyITnmg+xAqSU
	 NA7brFSDNtqfXeHOHl0O4YjEb+AOcSq/6qhXDRwOpVgQoBYHNq24GoLwJIw3yncWcw
	 4mnsbGclBfcVZviv5CgJOMyUIw1mQaCWXqfCMqC1DotYUwfSeYD7EFcZWlJbKgqrL/
	 9vy5V4CGMsjWQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3ED1E3781FE6;
	Wed, 21 Feb 2024 10:29:13 +0000 (UTC)
Message-ID: <dfea1acd-8cca-4840-b1d2-1891a15c8d5a@collabora.com>
Date: Wed, 21 Feb 2024 12:29:12 +0200
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <54c35628-9897-4415-86c0-cf81c897840e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 11:35, AngeloGioacchino Del Regno wrote:
> Il 20/02/24 21:16, Cristian Ciocaltea ha scritto:
>> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
>> signed firmware support in the driver via the acp_sof_quirk_table.
>>
>> In preparation to support additional use cases of the quirk table (i.e.
>> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
>> and update all references to it accordingly.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/sof/amd/acp-loader.c |  2 +-
>>   sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
>>   sound/soc/sof/amd/acp.h        |  6 ++++-
>>   sound/soc/sof/amd/vangogh.c    |  9 +++++--
>>   4 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/sound/soc/sof/amd/acp-loader.c
>> b/sound/soc/sof/amd/acp-loader.c
>> index d2d21478399e..aad904839b81 100644
>> --- a/sound/soc/sof/amd/acp-loader.c
>> +++ b/sound/soc/sof/amd/acp-loader.c
>> @@ -173,7 +173,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
>>         adata = sdev->pdata->hw_pdata;
>>   -    if (adata->signed_fw_image)
>> +    if (adata->quirks && adata->quirks->signed_fw_image)
>>           size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
>>       else
>>           size_fw = adata->fw_bin_size;
>> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
>> index 9b3c26210db3..9d9197fa83ed 100644
>> --- a/sound/soc/sof/amd/acp.c
>> +++ b/sound/soc/sof/amd/acp.c
>> @@ -20,12 +20,14 @@
>>   #include "acp.h"
>>   #include "acp-dsp-offset.h"
>>   -#define SECURED_FIRMWARE 1
>> -
>>   static bool enable_fw_debug;
>>   module_param(enable_fw_debug, bool, 0444);
>>   MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
>>   +static struct acp_quirk_entry quirk_valve_galileo = {
>> +    .signed_fw_image = true,
> 
> Hello Cristian,
> 
> are you sure that a structure holding "quirks" is the right choice here?
> 
> That probably comes as a personal preference, but I would simply pass a
> `u32 flags`
> and structure the quirks as bits.
> 
> #define ACP_SIGNED_FW_IMAGE    BIT(0)
> #define ACP_SOMETHING_ELSE    BIT(1)
> 
> flags = BIT(SIGNED_FW_IMAGE) | BIT(SOMETHING_ELSE);
> 
> if (flags & BIT(SIGNED_FW_IMAGE))
>    do_something()
> 
> What do you think?

Hi Angelo,

The flags approach was actually my first thought and I think that would
have been the best choice if the quirks usage was limited to a single
file (acp.c).

Since they need to be exposed externally as well (acp-loader.c,
vangogh.c) and already using a dedicated member in struct
sof_amd_acp_desc related to the existing quirk, I found the "quirks"
struct solution a bit more natural/convenient to follow (I've done a bit
of research before and noticed other drivers having similar handling).

However, as you already pointed out, it may also come down to individual
preferences, so I'm open to using the flags if there is not enough
reasoning to stick with the current implementation.

Thanks,
Cristian

