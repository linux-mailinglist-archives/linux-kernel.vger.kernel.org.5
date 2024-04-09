Return-Path: <linux-kernel+bounces-136536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5C89D546
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4259D2824C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2317F496;
	Tue,  9 Apr 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="w5Swh4rm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523757F46E;
	Tue,  9 Apr 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654401; cv=none; b=X8NuQxuusoPyforH2/rVl/2c4/UUE5JIqPM41uvTBMKxWvX0zZNSJHjqvO41l63yYr0/ZGwQe2RztlZbqcSpEF0ItnYwYpv5b+o2wh3S0DDSWMf3SOW6h+GYrnvt1bGAvJb54GASFR2uWOXGUnZ6YdBaiPlWFI0q3urD9jqKL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654401; c=relaxed/simple;
	bh=UvnpeLfv6qvxi5trkED6daMBTrkc1vacVdc014meKms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuvbWTAA8QtHaZy9Ec2EYS4nOtDaye+aCt0cGAFbB8PP8fA3zXq4BDmuelG+YITAkptSklMXAHZFBhfYyfG+Dj78b+hDE8TAjV2KNbpkJfVzrv83Q/hnS1TbBaUHpj8iyQTBGJnQMFPb6h/OE8IGA2iLvQiY+2GZxhNI0MZf0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=w5Swh4rm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=6tTAHEHjz/yf4536kj2DKyb7ca5ho3bhK7fTycMl0W0=;
	t=1712654399; x=1713086399; b=w5Swh4rmWpjUGixaL6ECf0MWo1pj7MuseOnAgmM4/+1ZhXq
	ugFosSWVqLQ3GAuuhWAoLt/ty3aQOPbQGe+xvCKmcETPjFa+cDWgHlsW4WacmtQT0bCa2biCMleQS
	cPffCWzHRdS4Tg2D8PDABm3AbdaiApvhHfVybjnwMnBe03atn0hKcl5pVznysIReRrOd7x08kGHQw
	x5lexHVIWQDrBQDbVkEjpM35vKeRx3nSjlJ4xOBSFJzKJm+7aNLkOGvwlsb0aYTLR6QXnXNuqPCIo
	L5UB9kqDVYPqk0krSxzNkj+FQuyh+M/kszlZNtPLpX+QFTQdb/qikkrZZ/z60DNA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ru7e0-0004Z7-2g; Tue, 09 Apr 2024 11:19:56 +0200
Message-ID: <fa076f6f-5a19-4a6a-aaf4-8d9e36df8fea@leemhuis.info>
Date: Tue, 9 Apr 2024 11:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
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
 <41b7170d-65b8-4d64-a1d3-7a0d09d79c45@collabora.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <41b7170d-65b8-4d64-a1d3-7a0d09d79c45@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712654399;dd17c2de;
X-HE-SMSGID: 1ru7e0-0004Z7-2g

On 09.04.24 10:47, Cristian Ciocaltea wrote:
> On 4/9/24 11:04 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 09.04.24 09:42, Cristian Ciocaltea wrote:
>>> On 4/9/24 7:44 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 09.04.24 01:44, Cristian Ciocaltea wrote:
>>>>> On 4/7/24 10:47 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>> On 06.04.24 15:08, Bagas Sanjaya wrote:
>>>>>>> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
>>>>>>> on Steam Deck OLED [1]. He wrote:
>>>>>
>>>>>>>> I'm adding this here, I hope it's the correct place.
>>>>>>>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
>>>>>>>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
>>>>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677
>>>>>> A quick search made me find these posts/threads that foreshadow the problem:
>>>>>>
>>>>>> https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
>>>>>> https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/
>>>>>>
>>>>>> From a quick look at the second discussion it seems a bit like we are
>>>>>> screwed, as iiutc topology files are out in the wild for one or the
>>>>>> other approach. So we might have to bite a bullet there and accept the
>>>>>> regression -- but I might easily be totally mistaken here. Would be good
>>>>>> in one of the experts (Venkata Prasad Potturu maybe?) could quickly
>>>>>> explain what's up here.
>>>>>
>>>>> The problem here is that Steam Deck OLED provides a topology file which
>>>>> uses an incorrect DAI link ID for BT codec. 
>>>>>
>>>>> Patch [1] moves BT_BE_ID to position 2 in the enum, as expected by the
>>>>> topology, but this is not a change that can be accepted upstream as it
>>>>> would break other devices which rely on BT_BE_ID set to 3.  
>>>>>
>>>>> The proper solution would be to update the topology file on Steam Deck,
>>>>> but this is probably not straightforward to be accomplished as it would
>>>>> break the compatibility with the currently released (downstream)
>>>>> kernels.
>>>>>
>>>>> Hopefully, this sheds some more light on the matter.
>>>>>
>>>>> [1]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/
>>>>
>>>> Many thx, yes, this sheds some light on the matter. But there is one
>>>> remaining question: can we make both camps happy somehow? E.g. something
>>>> along the lines of "first detect if the topology file has BT_BE_ID in
>>>> position 2 or 3 and then act accordingly?
>>>
>>> Right, I have this on my TODOs list but haven't managed to dig into it
>>> yet. However, that would be most likely just another hack to be carried
>>> on until the transition to a fixed topology is completed.
>>
>> Well, sure it's a hack, but the thing is, our number one rule is "no
>> regressions" and the reporter apparently faces one (see start of the
>> thread). So to fulfill this rule it would be ideal to have a fix
>> available soonish or revert the culprit and reply it later together with
>> the fix.
> 
> Hmm, unless I'm missing something, this shouldn't been considered a
> regression.  As I explained previously, the OLED model was launched with
>  a downstream implementation of the Vangogh SOF drivers on top of v6.1,
> as there was no upstream support back then.
> 
> When AMD eventually completed the upstreaming process of their SOF
> drivers in v6.6, we ended up with this unfortunate ID assignments
> incompatibility.  Hence I cannot see how the mainline kernel would have
> worked without applying patch [1] above, unless the reporter
> experimented with a different topology (which is not the case if I got
> this right).
> 
>> Do we know which change that went into 6.8 caused this? Or is a revert
>> out-of-the question as it will likely break things for other users that
>> already upgraded to 6.8 and have a matching topology file? (/me fears
>> the answer to the latter question is "yes", but I have to ask :-/)
> 
> We need to understand how the reporter got this working with mainline
> kernels without applying any out-of-tree patches.

Ahh, okay, thx, now I understand this better. You are most likely
correct. It also made me look at the initial report again where I
noticed "When *I manually patched support* for the 6.6 or 6.7 mainline
kernel it worked fine.", so yes, this likely is not a regression.

Thx for your help and sorry for the trouble I caused!

Ciao, Thorsten

