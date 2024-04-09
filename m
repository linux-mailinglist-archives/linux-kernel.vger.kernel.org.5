Return-Path: <linux-kernel+bounces-136497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51D89D4D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62416283480
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01E757EE;
	Tue,  9 Apr 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eNPOB0Lf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6E3BBD8;
	Tue,  9 Apr 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652440; cv=none; b=pJKVZI+Nw0RTCzHHyURpc9FuMB2CzrDlHulzJ/53yklA9AtCOH6S8cjdD3/nGo/bp8SgM0rA8Ljr3kcS7uomscpIp0fDrECwtkgGD+8NBT/nvQ4Ig3xCQtaBSDfXvxlpobPBZtk9u/ie7QqqmI7p7V0otX6XdazDx+hV9KwxtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652440; c=relaxed/simple;
	bh=zNYeRwmbY9ibM/E/WdKyfRjakHbPxIdF+O+2VcWRU2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhhcCFHihG7Tkx4nNPn3BP1xKpQIg8zoFIdQ6ldugUjvDIJ4C90bLucQsl3CvU6RqEVFv0Yg4jADfCUL13OGexphlPD3xt6GE7+lFp6c4HCNWXSMcALb6BTE964h6yivRWmXJRUyFFxe5aSHfYDKP5tJM7cKf/EhsuxFFugO1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eNPOB0Lf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712652436;
	bh=zNYeRwmbY9ibM/E/WdKyfRjakHbPxIdF+O+2VcWRU2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eNPOB0Lf5y31e5BZq9VuxBvLcBz0E+mr1TTF3gdqEBeUdeOvZtdf6kOye/HJxvv4O
	 nqxy+USLJFrMjF8HvZfrLABGJSZyBw3bEG/qUUIfuIu8szxmTd8Hrnfgt6dwCKaxTR
	 QX0bPtKJGc3ivsdNkGkc/Bi18Tqvl3gp3lb7jtf3y+16A3fw/vfU5Cz3+u3DPh6s0e
	 z1zzybNZ2inPN4Y6Ejz8oYKglkIHYcFapV02MPjunhbdHCMl3G44wRMufCgR7xVdnz
	 uFerMa93434KEQat/p6HL1Agho76oJ1fihkYO1tNaM/LKrLCelBiLP6V+dxsea2373
	 M0napoSFU0nOQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 81CF637820EE;
	Tue,  9 Apr 2024 08:47:15 +0000 (UTC)
Message-ID: <41b7170d-65b8-4d64-a1d3-7a0d09d79c45@collabora.com>
Date: Tue, 9 Apr 2024 11:47:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Daniel <dmanlfc@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Sound System <linux-sound@vger.kernel.org>
References: <ZhFJZoful6nEFskW@archie.me>
 <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
 <904ffa11-592a-4336-aed2-d6370bb01896@collabora.com>
 <b99e51de-3622-4360-b69d-0fd911ea2a7d@leemhuis.info>
 <9012f8d5-302a-4840-815a-22b1e85fda5c@collabora.com>
 <c0193bca-ea80-49eb-ab26-8256d07078df@leemhuis.info>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <c0193bca-ea80-49eb-ab26-8256d07078df@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 11:04 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 09.04.24 09:42, Cristian Ciocaltea wrote:
>> On 4/9/24 7:44 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 09.04.24 01:44, Cristian Ciocaltea wrote:
>>>> On 4/7/24 10:47 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 06.04.24 15:08, Bagas Sanjaya wrote:
>>>>>> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
>>>>>> on Steam Deck OLED [1]. He wrote:
>>>>
>>>>>>> I'm adding this here, I hope it's the correct place.
>>>>>>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
>>>>>>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
>>>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677
>>>>> A quick search made me find these posts/threads that foreshadow the problem:
>>>>>
>>>>> https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
>>>>> https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/
>>>>>
>>>>> From a quick look at the second discussion it seems a bit like we are
>>>>> screwed, as iiutc topology files are out in the wild for one or the
>>>>> other approach. So we might have to bite a bullet there and accept the
>>>>> regression -- but I might easily be totally mistaken here. Would be good
>>>>> in one of the experts (Venkata Prasad Potturu maybe?) could quickly
>>>>> explain what's up here.
>>>>
>>>> The problem here is that Steam Deck OLED provides a topology file which
>>>> uses an incorrect DAI link ID for BT codec. 
>>>>
>>>> Patch [1] moves BT_BE_ID to position 2 in the enum, as expected by the
>>>> topology, but this is not a change that can be accepted upstream as it
>>>> would break other devices which rely on BT_BE_ID set to 3.  
>>>>
>>>> The proper solution would be to update the topology file on Steam Deck,
>>>> but this is probably not straightforward to be accomplished as it would
>>>> break the compatibility with the currently released (downstream)
>>>> kernels.
>>>>
>>>> Hopefully, this sheds some more light on the matter.
>>>>
>>>> [1]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/
>>>
>>> Many thx, yes, this sheds some light on the matter. But there is one
>>> remaining question: can we make both camps happy somehow? E.g. something
>>> along the lines of "first detect if the topology file has BT_BE_ID in
>>> position 2 or 3 and then act accordingly?
>>
>> Right, I have this on my TODOs list but haven't managed to dig into it
>> yet. However, that would be most likely just another hack to be carried
>> on until the transition to a fixed topology is completed.
> 
> Well, sure it's a hack, but the thing is, our number one rule is "no
> regressions" and the reporter apparently faces one (see start of the
> thread). So to fulfill this rule it would be ideal to have a fix
> available soonish or revert the culprit and reply it later together with
> the fix.

Hmm, unless I'm missing something, this shouldn't been considered a
regression.  As I explained previously, the OLED model was launched with
 a downstream implementation of the Vangogh SOF drivers on top of v6.1,
as there was no upstream support back then.

When AMD eventually completed the upstreaming process of their SOF
drivers in v6.6, we ended up with this unfortunate ID assignments
incompatibility.  Hence I cannot see how the mainline kernel would have
worked without applying patch [1] above, unless the reporter
experimented with a different topology (which is not the case if I got
this right).

> Do we know which change that went into 6.8 caused this? Or is a revert
> out-of-the question as it will likely break things for other users that
> already upgraded to 6.8 and have a matching topology file? (/me fears
> the answer to the latter question is "yes", but I have to ask :-/)

We need to understand how the reporter got this working with mainline
kernels without applying any out-of-tree patches.

Regards,
Cristian

