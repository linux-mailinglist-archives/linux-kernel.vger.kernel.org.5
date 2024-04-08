Return-Path: <linux-kernel+bounces-136024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07989CF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C252845D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1C1494B8;
	Mon,  8 Apr 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n3xQE403"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1718C05;
	Mon,  8 Apr 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619860; cv=none; b=rw7iVRgMthZfuIHrb57M1U9BT9KiN9ijkwpOUh45bBxKlGCJQkN8uQRm4SdQ8qbSdTaduqnVLlroUObqoFk+kWq3lfHW9+VJ48QROv55t75VPspLdWtsqoWmb6QudKcAvpQosZUz6QiKSv3S4WNaaEFS8xhI5qi5gJMhG42F1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619860; c=relaxed/simple;
	bh=9v+/+KHAGA01kkiMa2qAh1zC5zHXgmpHxJ+Jd2ebixs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJkDncnOVk1DTpmrzsckQMEFro+juqqJvWN8HkSaCgEVgkbaQvmbZH1xfTq/WkZBkE7nQ9MTNMD8jEpsleFyx8tDfhDtO1n/xkVia3A6wCw2udVlKDFN8S36vGlay1DX41wW+BcTFO8MABTvKXTPoWC1oxJvG0BXPptEpkAculU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n3xQE403; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712619856;
	bh=9v+/+KHAGA01kkiMa2qAh1zC5zHXgmpHxJ+Jd2ebixs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n3xQE403gyfiyrWVcY5h3QGFR8w37IqKfBbPLnpxgJ4Ju5j+lDF6mR+WZQytR7YpZ
	 qtYPW6khkoHdA2HCWO3GsYS2LJySKOtxFkLUpvP9IwIVHKmSEkq07lVH2wGt1ReR5s
	 b89F/Y1tG4dxzR95c3loshe8OMDNXwDGgawFoTAWFKcIHAC2PGCt4XPlUxST0c6ml/
	 mCjLvLTz9P8S36wFY1bWzePJmYoXynxCjRK/6dB5pErn7YCEaRVKsHjQeiBXzlh2z/
	 qvFtFsq1WbDWt8xPImQ/HiGm3GNelNOOc5f6U8C9trPipdzai3z4W0MUVN+p7Or+Cg
	 avfIjoGpsptMA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AF36E37813CA;
	Mon,  8 Apr 2024 23:44:15 +0000 (UTC)
Message-ID: <904ffa11-592a-4336-aed2-d6370bb01896@collabora.com>
Date: Tue, 9 Apr 2024 02:44:15 +0300
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/24 10:47 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.04.24 15:08, Bagas Sanjaya wrote:
>>
>> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
>> on Steam Deck OLED [1]. He wrote:
> 
> Bagas, why didn't you forward this to me in private first, as we agreed
> on as general procedure for cases like this?
> 
> Anyway:
> 
>>> I'm adding this here, I hope it's the correct place.
>>>
>>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
>>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
>>
>> See Bugzilla for the full thread.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677
> 
> A quick search made me find these posts/threads that foreshadow the problem:
> 
> https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
> https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/
> 
> From a quick look at the second discussion it seems a bit like we are
> screwed, as iiutc topology files are out in the wild for one or the
> other approach. So we might have to bite a bullet there and accept the
> regression -- but I might easily be totally mistaken here. Would be good
> in one of the experts (Venkata Prasad Potturu maybe?) could quickly
> explain what's up here.

The problem here is that Steam Deck OLED provides a topology file which
uses an incorrect DAI link ID for BT codec. 

Patch [1] moves BT_BE_ID to position 2 in the enum, as expected by the
topology, but this is not a change that can be accepted upstream as it
would break other devices which rely on BT_BE_ID set to 3.  

The proper solution would be to update the topology file on Steam Deck,
but this is probably not straightforward to be accomplished as it would
break the compatibility with the currently released (downstream)
kernels.

Hopefully, this sheds some more light on the matter.

Regards,
Cristian

[1]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/

