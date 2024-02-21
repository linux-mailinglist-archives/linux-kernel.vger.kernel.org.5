Return-Path: <linux-kernel+bounces-74540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C685D5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E7E1F23EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05065C8D6;
	Wed, 21 Feb 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WC0slFZn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E8538B;
	Wed, 21 Feb 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511752; cv=none; b=KtXMEB1aDSj7ZE2qbk/JJ252gfCZ6QybE3dUE1nmyAB143aloxpdB6TWLbpc1Ys6WAmvKVC4KR2UVdPcfDWJSnrmCGCA56KuQdKNC9oALJvXW7S7htRsFYU7BvTKNXtxmELghPxG14gr97sE3sYLXfnGxEMrx82zWWirvaPhwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511752; c=relaxed/simple;
	bh=PjUHked8cWHLy9MvDKP400/CDn1KGE4in0sdTF/YIvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ao1we2zLmmelb5Gz2zJkT9x4w7zntVh8HzWeyE/TycAn7D+oJMeg6+eIqSUH1asO3sRtrIg/cGgajaFX4sOxbHZ7BfNUVsMr/n/LEHLPdFEwMZzHZrhiNRvT7M9d7cgzKsnyHOAivMH98FjW/oGTWocJE9Ia4N+62C9nDRw95xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WC0slFZn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708511748;
	bh=PjUHked8cWHLy9MvDKP400/CDn1KGE4in0sdTF/YIvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WC0slFZnBgnncGPptOUfTU/cKaIODo0FVg7dviCVi8OCy2x8/F8P9M06X7llVWa3/
	 8zH0VwZFnaG1+d0qFvL7mW/bj5sUxpWLCJl0CBWPBRYdKZCw63ctZafIDbMGasSThC
	 Lz9Vo91IxB6UoTyMXwbRK7COtX9a3sNAzytEn8mB7sCgVtqSQaL6tPN8VkXMFF4fkC
	 VdfGi+zD2zIBrW6xP2j2XrYqPLOeQ9L8/HT4k1QZh5czG5RYIBASCyQ/0eq2IG/5RP
	 hKGJxzGPFAVxhPDaqFy3ssFKtFaUUgvnjpCm24zLpv+KrUoMpiiYw4KPQwJPYZL5I5
	 nBUdriVoB9Trw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A213E3781FE6;
	Wed, 21 Feb 2024 10:35:47 +0000 (UTC)
Message-ID: <9bac55ff-0720-4ecb-9dcb-59a5397c7077@collabora.com>
Date: Wed, 21 Feb 2024 11:35:41 +0100
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
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dfea1acd-8cca-4840-b1d2-1891a15c8d5a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/24 11:29, Cristian Ciocaltea ha scritto:
> On 2/21/24 11:35, AngeloGioacchino Del Regno wrote:
>> Il 20/02/24 21:16, Cristian Ciocaltea ha scritto:
>>> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
>>> signed firmware support in the driver via the acp_sof_quirk_table.
>>>
>>> In preparation to support additional use cases of the quirk table (i.e.
>>> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
>>> and update all references to it accordingly.
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>    sound/soc/sof/amd/acp-loader.c |  2 +-
>>>    sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
>>>    sound/soc/sof/amd/acp.h        |  6 ++++-
>>>    sound/soc/sof/amd/vangogh.c    |  9 +++++--
>>>    4 files changed, 38 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/sound/soc/sof/amd/acp-loader.c
>>> b/sound/soc/sof/amd/acp-loader.c
>>> index d2d21478399e..aad904839b81 100644
>>> --- a/sound/soc/sof/amd/acp-loader.c
>>> +++ b/sound/soc/sof/amd/acp-loader.c
>>> @@ -173,7 +173,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
>>>          adata = sdev->pdata->hw_pdata;
>>>    -    if (adata->signed_fw_image)
>>> +    if (adata->quirks && adata->quirks->signed_fw_image)
>>>            size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
>>>        else
>>>            size_fw = adata->fw_bin_size;
>>> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
>>> index 9b3c26210db3..9d9197fa83ed 100644
>>> --- a/sound/soc/sof/amd/acp.c
>>> +++ b/sound/soc/sof/amd/acp.c
>>> @@ -20,12 +20,14 @@
>>>    #include "acp.h"
>>>    #include "acp-dsp-offset.h"
>>>    -#define SECURED_FIRMWARE 1
>>> -
>>>    static bool enable_fw_debug;
>>>    module_param(enable_fw_debug, bool, 0444);
>>>    MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
>>>    +static struct acp_quirk_entry quirk_valve_galileo = {
>>> +    .signed_fw_image = true,
>>
>> Hello Cristian,
>>
>> are you sure that a structure holding "quirks" is the right choice here?
>>
>> That probably comes as a personal preference, but I would simply pass a
>> `u32 flags`
>> and structure the quirks as bits.
>>
>> #define ACP_SIGNED_FW_IMAGE    BIT(0)
>> #define ACP_SOMETHING_ELSE    BIT(1)
>>
>> flags = BIT(SIGNED_FW_IMAGE) | BIT(SOMETHING_ELSE);

That should've been
   flags = SIGNED_FW_IMAGE | SOMETHING_ELSE;

>>
>> if (flags & BIT(SIGNED_FW_IMAGE))

and this
    if (flags & SIGNED_FW_IMAGE)

.. I have no idea why I added a nested BIT(BIT()) in there, something in
my brain started ticking sideways, lol.

>>     do_something()
>>
>> What do you think?
> 
> Hi Angelo,
> 
> The flags approach was actually my first thought and I think that would
> have been the best choice if the quirks usage was limited to a single
> file (acp.c).
> 
> Since they need to be exposed externally as well (acp-loader.c,
> vangogh.c) and already using a dedicated member in struct
> sof_amd_acp_desc related to the existing quirk, I found the "quirks"
> struct solution a bit more natural/convenient to follow (I've done a bit
> of research before and noticed other drivers having similar handling).
> 
> However, as you already pointed out, it may also come down to individual
> preferences, so I'm open to using the flags if there is not enough
> reasoning to stick with the current implementation.

Of course the definitions should be put in a "common header" for that to
actually work in your described situation, but it's not a big deal.

Mine wasn't a strong opinion: that does actually matter in case you expect
more quirks (or something that is not a quirk, but a functional flag instead)
to eventually get there... but otherwise, it's actually the same.

It's your choice in the end, I'm fine with both anyway :-)

Cheers,
Angelo



