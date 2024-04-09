Return-Path: <linux-kernel+bounces-136446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544189D424
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DB21F24B61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7E7EF1F;
	Tue,  9 Apr 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjUiSCmn"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856D7E57F;
	Tue,  9 Apr 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650954; cv=none; b=dG4otlNn2a7i+1xUgfSZCRLB5s/jFXbtSEDpKGHXgBJSAyJb08wJvUZ7x0Zfj3ItyYkpZ3FyVee+gbYg5T4fvzDdj3jKRMu+H1hrpqcfEvQSBCKC6qZaLg3B/TdWJA8MpyiK1vsmW405YCFAvdbrrT9va7rDitN7tgNeJRq1vP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650954; c=relaxed/simple;
	bh=02WUFrx8t5EsWL9w0cHfygMeVm1mY4daZbgs0WPNPNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvxZvvKwWzzTobV1EzwWsMjxdInTomwbB+0BFshGnE5YYKLnjq75Mxe/FsePJgi+kmfpnyjeuJ7A6ERiDSw6VGII0WNWgPz/JyDjvdbV4mk795k+JFp12nyJ1wrgHEWjZtADzSulybLoy3n0nSF+bqqNMLY5/3xcbUsL1KZg1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjUiSCmn; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5451554276.3;
        Tue, 09 Apr 2024 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712650950; x=1713255750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbQ7XvxzNdGeggq9DT3eg+0bgBZN6IC7RUGuFWpooO4=;
        b=cjUiSCmns4rfO6/qH5XSMtC5cp3Vy1BYLT9fPK3W0banxgiJWFg/IlrO/bECeCs7BI
         jN2rRsrtMXku+ZUJPYOgJBHyNK5s/iDNShMjArVjS3xfbN3jBc9P0m2+XTyhZmYKoUqv
         rke7ErM3pqfTACSaymmUtMh6jOEqhluQyfsexenS+3t91sBXJ3cetegih7Gg53XhKzuB
         o6Q3Fgc8+4PlCfbRTTrX40WGIvyT/3SOEtgGtWIK7IclTWKrI/4BUnl1F5JHYKf/Em1W
         mtC8hnkZRH6MHpoSfE+H4jYuYfwfK3iQtH8nY4DteVFlWqhf6cHmHitex61cJBj2vb7v
         ywcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650950; x=1713255750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbQ7XvxzNdGeggq9DT3eg+0bgBZN6IC7RUGuFWpooO4=;
        b=gBdOqMUtM/ywLWCONhRAvyjtxXrx6dqXRSgEGz4MV5t0wJOU4RFodz0he4qWdRtPpP
         qr/YB677webEa1waPnm2oH9tsVsGKeatObzjbvTMz+4OI9+z+1kYlcLXlHi8KyC4cqD/
         ZO/hmhrYG5p4fsXNSoNP4cmEj5lSJz426o32fIzjq4aoGGwDxkMtaHjd7NWwjfgNH/ft
         +SHCrzksvF3HX1hSy7Uj9qP5IgFa091w5r/3RkLY9SaoHN0p7fGWVkpbub1u1D/VIAiA
         0lXtYYEXGwJUq1y0AXbROhZnCFLruRJrIR2drTjbyQr8cG5rPfWRrUZW7pvxbldgKuI9
         gXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUeyWnxoDP7YFA3TxHj/yDhHcIHXx+wDY4g0iyeYbouH8RkqpoUFywGrJ5RFDSpB197VF9ztBmgMGnJ/c8BZsjWKQD5s5vBMm/BQ6MtFcHH+mZExLym3QRv9eVUSxpcsLjxd9tgBtCTP/0=
X-Gm-Message-State: AOJu0Yw8+l4fcFqNXeUvKP+3WMUOK1WC2wYIarlf1OvvHSVfqbntU8fi
	i80dcVUQWOnbuoUg25wczcCrzIeRzhh9BYOPSGCTdGN27tQEGf4YEBhWmf/8Tap+AXvjO7XpEEm
	KbdbNwGFFfWF843UlTVqY5bZ/EMc=
X-Google-Smtp-Source: AGHT+IHDLhkxY099pQiSSrdAQNO5+/2n82WSIr06Sh1Xo/e7Ky8qfSTSFXwriFmftoLdkS4bEyY5Nh4agSQZCtagC9A=
X-Received: by 2002:a25:f627:0:b0:dc2:48af:bf09 with SMTP id
 t39-20020a25f627000000b00dc248afbf09mr9273528ybd.62.1712650949989; Tue, 09
 Apr 2024 01:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhFJZoful6nEFskW@archie.me> <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
 <904ffa11-592a-4336-aed2-d6370bb01896@collabora.com> <b99e51de-3622-4360-b69d-0fd911ea2a7d@leemhuis.info>
 <9012f8d5-302a-4840-815a-22b1e85fda5c@collabora.com> <c0193bca-ea80-49eb-ab26-8256d07078df@leemhuis.info>
In-Reply-To: <c0193bca-ea80-49eb-ab26-8256d07078df@leemhuis.info>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Tue, 9 Apr 2024 18:22:18 +1000
Message-ID: <CAOyTmd2w+si-3OEyc4TGCn7ntiPyLGwBB6pswwcfDenj6BZSvg@mail.gmail.com>
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Sound System <linux-sound@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Why this was changed in the first place could do with some explaining,
as Valve had this implemented first in the SteamDeck (probably
collabora dev).
There were no other implementations out in the wild AFAIK & now with
the 6.8.x kernel, this issue has manifested because of an enum change.
I cannot for the life of me find an alternative topology file. Where
are the other implementations? Therefore it makes sense aligning to
what was done before on the Steam Deck OLED.
Alternatively, if Valve could provide an updated topology file for
6.8+ kernels, that would be great too.
Just my two cents from a humble OS dev, trying to make stuff work.


On Tue, 9 Apr 2024 at 18:04, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 09.04.24 09:42, Cristian Ciocaltea wrote:
> > On 4/9/24 7:44 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 09.04.24 01:44, Cristian Ciocaltea wrote:
> >>> On 4/7/24 10:47 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>> On 06.04.24 15:08, Bagas Sanjaya wrote:
> >>>>> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
> >>>>> on Steam Deck OLED [1]. He wrote:
> >>>
> >>>>>> I'm adding this here, I hope it's the correct place.
> >>>>>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
> >>>>>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
> >>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677
> >>>> A quick search made me find these posts/threads that foreshadow the problem:
> >>>>
> >>>> https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
> >>>> https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/
> >>>>
> >>>> From a quick look at the second discussion it seems a bit like we are
> >>>> screwed, as iiutc topology files are out in the wild for one or the
> >>>> other approach. So we might have to bite a bullet there and accept the
> >>>> regression -- but I might easily be totally mistaken here. Would be good
> >>>> in one of the experts (Venkata Prasad Potturu maybe?) could quickly
> >>>> explain what's up here.
> >>>
> >>> The problem here is that Steam Deck OLED provides a topology file which
> >>> uses an incorrect DAI link ID for BT codec.
> >>>
> >>> Patch [1] moves BT_BE_ID to position 2 in the enum, as expected by the
> >>> topology, but this is not a change that can be accepted upstream as it
> >>> would break other devices which rely on BT_BE_ID set to 3.
> >>>
> >>> The proper solution would be to update the topology file on Steam Deck,
> >>> but this is probably not straightforward to be accomplished as it would
> >>> break the compatibility with the currently released (downstream)
> >>> kernels.
> >>>
> >>> Hopefully, this sheds some more light on the matter.
> >>>
> >>> [1]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/
> >>
> >> Many thx, yes, this sheds some light on the matter. But there is one
> >> remaining question: can we make both camps happy somehow? E.g. something
> >> along the lines of "first detect if the topology file has BT_BE_ID in
> >> position 2 or 3 and then act accordingly?
> >
> > Right, I have this on my TODOs list but haven't managed to dig into it
> > yet. However, that would be most likely just another hack to be carried
> > on until the transition to a fixed topology is completed.
>
> Well, sure it's a hack, but the thing is, our number one rule is "no
> regressions" and the reporter apparently faces one (see start of the
> thread). So to fulfill this rule it would be ideal to have a fix
> available soonish or revert the culprit and reply it later together with
> the fix.
>
> Do we know which change that went into 6.8 caused this? Or is a revert
> out-of-the question as it will likely break things for other users that
> already upgraded to 6.8 and have a matching topology file? (/me fears
> the answer to the latter question is "yes", but I have to ask :-/)
>
> Ciao, Thorsten



-- 

Kind Regards,

Daniel
+61 (0)409611884

