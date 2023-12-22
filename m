Return-Path: <linux-kernel+bounces-9699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3181C9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF0F1C2282D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA551805F;
	Fri, 22 Dec 2023 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8awk124"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF869179B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703247967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+0hAFQoNGhjkC4iJFy3Bycv+540PspoS2JpzLVmy1I=;
	b=T8awk124O9pPeAMh1rjDZ8Iq9r53s8u9A7+svoxf6TSAjwC8TM9hG+ghuTTrgXoTVpFGYJ
	VtYV3k2v506+zS7LwJIW/YTy5cuEAx1bkxnMIl8sz9g+dKR707hIaY1aveHu/FENexphy8
	S6fywYjlA+SgcU/OolPpPKagOJVdFK8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-l9NJIVuoMuS7OoHALUNOfw-1; Fri, 22 Dec 2023 07:26:06 -0500
X-MC-Unique: l9NJIVuoMuS7OoHALUNOfw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d82e9a60f6so1400762b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703247965; x=1703852765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+0hAFQoNGhjkC4iJFy3Bycv+540PspoS2JpzLVmy1I=;
        b=nfgU7Hq1pvyFLkxK3m2OvJESvuyk8zAGCiWjTiHTqNcIAgA8LqS8XKAvqaQFVsVCaM
         5SScuLn+eIEkr3bc5Tp7tGfc1n4Uvh8o50cpxEZBaGRGnNsRhmKDjdWWF3M/y6JGnsMo
         /I1aoLkXwvCz/MkwNSELYmTlh9M1GjyMaVOgA+qwO1Ma31U2AFONVXTuUOJQohk1jNRL
         qzh9kjkQZmo4YCZTcIbuSoC/hRPeiMsAuZQWxT7rkgy7YWuAqF8tHXMK2Rq6X18H+EgZ
         APcUD5Gj4OUgnXFkx15uDjRC/ZLinXAEWrz7wBe3Evy2Svg+nx9k6+8a5JvDo+l6j5x4
         UGbQ==
X-Gm-Message-State: AOJu0YxWn4RAS4bJwjJKg9TgDnOMvnNW4054R6mfiZewkjXNs/VGx332
	QkK7LJtAhQ4ndZjuMzOaHv1k8VBnRUW/X/mU7sR9eEDH6PTveHCRvQvvsG3L46ZQbCPXe4BWy7b
	i0OyKEYlz6AJAnEgdg70Z+hmLi7efmu8UgVbgF6PS19r97qgp
X-Received: by 2002:a05:6a21:194:b0:195:4744:20ca with SMTP id le20-20020a056a21019400b00195474420camr207636pzb.60.1703247964731;
        Fri, 22 Dec 2023 04:26:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzHElDkJAQblkzKA51PWs9j3gE5oL7guxFvxkZsOrdWTU8pSAwm/O7EcrvYE9E/82xJ1beWCcAKPM052io4aM=
X-Received: by 2002:a05:6a21:194:b0:195:4744:20ca with SMTP id
 le20-20020a056a21019400b00195474420camr207616pzb.60.1703247964290; Fri, 22
 Dec 2023 04:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st> <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
 <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com> <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
 <31292508-f881-4457-a4bf-2ca0b8e8f435@broadcom.com> <37bd3f8a-1000-4d74-8909-5e821cb5c1dc@marcan.st>
In-Reply-To: <37bd3f8a-1000-4d74-8909-5e821cb5c1dc@marcan.st>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 22 Dec 2023 12:25:27 +0000
Message-ID: <CAOgh=FxsMMbp1Pyg7GSNmwNvfeX+7JDibQbMbx-hdLsCQz5qYA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Hector Martin <marcan@marcan.st>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daniel Berlin <dberlin@dberlin.org>, 
	Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, asahi@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 at 05:19, Hector Martin <marcan@marcan.st> wrote:
>
>
>
> On 2023/12/21 18:57, Arend van Spriel wrote:
> > - SHA-cyfmac-dev-list@infineon.com
> >
> > On 12/21/2023 1:49 AM, Hector Martin wrote:
> >>
> >>
> >> On 2023/12/21 4:36, Arend van Spriel wrote:
> >>> On 12/20/2023 7:14 PM, Hector Martin wrote:
> >>>>
> >>>>
> >>>> On 2023/12/20 19:20, Kalle Valo wrote:
> >>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >>>>>
> >>>>>>> Just recently a patch was posted to remove the Infineon list from
> >>>>>>> MAINTAINERS because that company cares so little they have litera=
lly
> >>>>>>> stopped accepting emails from us. Meanwhile they are telling thei=
r
> >>>>>>> customers that they do not recommend upstream brcmfmac and they s=
hould
> >>>>>>> use their downstream driver [1].
> >>>>>>
> >>>>>> Unquestionably broadcom is not helping maintain things, and I thin=
k it
> >>>>>> should matter.
> >>>>>>
> >>>>>> As Hector says, they point to their random driver dumps on their s=
ite
> >>>>>> that you can't even download unless you are a "Broadcom community
> >>>>>> member" or whatever, and hey - any company that works that way sho=
uld
> >>>>>> be seen as pretty much hostile to any actual maintenance and prope=
r
> >>>>>> development.
> >>>>>
> >>>>> Sadly this is the normal in the wireless world. All vendors focus o=
n the
> >>>>> latest generation, currently it's Wi-Fi 7, and lose interest on old=
er
> >>>>> generations. And vendors lose focus on the upstream drivers even fa=
ster,
> >>>>> usually after a customer project ends.
> >>>>>
> >>>>> So in practise what we try to do is keep the drivers working someho=
w on
> >>>>> our own, even after the vendors are long gone. If we would delibera=
tely
> >>>>> allow breaking drivers because vendor/corporations don't support us=
, I
> >>>>> suspect we would have sevaral broken drivers in upstream.
> >>>>>
> >>>>>> If Daniel and Hector are responsive to actual problem reports for =
the
> >>>>>> changes they cause, I do think that should count a lot.
> >>>>>
> >>>>> Sure, but they could also respect to the review comments. I find Ar=
end's
> >>>>> proposal is reasonable and that's what I would implement in v2. We
> >>>>> (linux-wireless) make abstractions to workaround firmware problems =
or
> >>>>> interface conflicts all the time, just look at ath10k for example. =
I
> >>>>> would not be surprised if we need to add even more abstractions to
> >>>>> brcmfmac in the future. And Arend is the expert here, he has best
> >>>>> knowledge of Broadcom devices and I trust him.
> >>>>>
> >>>>> Has anyone even investigated what it would need to implement Arend'=
s
> >>>>> proposal? At least I don't see any indication of that.
> >>>>
> >>>> Of course we can implement it (and we will as we actually got a repo=
rt
> >>>> of this patch breaking Cypress now, finally).
> >>>>
> >>>> The question was never whether it could be done, we're already doing=
 a
> >>>> bunch of abstractions to deal with just the Broadcom-only side of th=
ings
> >>>> too. The point I was trying to make is that we need to *know* what
> >>>> firmware abstractions we need and *why* they are needed. We can't ju=
st
> >>>> say, for every change, "well, nobody knows if the existing code work=
s or
> >>>> not, so let's just add an abstraction just in case the change breaks
> >>>> something". As far as anyone involved in the discussions until now c=
ould
> >>>> tell, this code was just something some Cypress person dumped upstre=
am,
> >>>> and nobody involved was being responsive to any of our inquiries, so
> >>>> there was no way to be certain it worked at all, whether it was
> >>>> supported in public firmware, or anything else.
> >>>>
> >>>> *Now* that we know the existing code is actually functional and not =
just
> >>>> dead/broken, and that the WSEC approach is conversely not functional=
 on
> >>>> the Cypress firmwares, it makes sense to introduce an abstraction.
> >>>
> >>> Just a quick look in the git history could have told you that it was =
not
> >>> just dumped upstream and at least one person was using it and extende=
d
> >>> it for 802.11r support (fast-roaming):
> >>>
> >>>
> >>> author      Pawe=C5=82 Drewniak <czajernia@gmail.com>    2021-08-24 2=
3:13:30 +0100
> >>> committer   Kalle Valo <kvalo@codeaurora.org>       2021-08-29 11:33:=
07 +0300
> >>> commit      4b51de063d5310f1fb297388b7955926e63e45c9 (patch)
> >>> tree        ba2ccb5cbd055d482a8daa263f5e53531c07667f
> >>> /drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >>> parent      81f9ebd43659320a88cae8ed5124c50b4d47ab66 (diff)
> >>> download    wireless-4b51de063d5310f1fb297388b7955926e63e45c9.tar.gz
> >>> brcmfmac: Add WPA3 Personal with FT to supported cipher suites
> >>> This allows the driver to connect to BSSIDs supporting SAE with 802.1=
1r.
> >>> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-=
rc2.
> >>> AP was set to 'sae-mixed' (WPA2/3 Personal).
> >>>
> >>> Signed-off-by: Pawe=C5=82 Drewniak <czajernia@gmail.com>
> >>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >>> Link: https://lore.kernel.org/r/20210824221330.3847139-1-czajernia@gm=
ail.com
> >>
> >> Sure, but we also had user reports of it *not* actually working (maybe
> >> it regressed?). We didn't know whether it was functional with the
> >> linux-firmware blobs in any way, I wanted confirmation of that. And we
> >> also didn't know that the patch *would* break it at all; perhaps the
> >> Cypress firmware had also grown support for the WSEC mechanism.
> >>
> >> That's why I wanted someone to actually confirm the code worked (in so=
me
> >> subset of cases) and the patch didn't, before starting to introduce
> >> conditionals. There is, of course, also the element that the Cypress
> >> side has been long unmaintained, and if nobody is testing/giving
> >> feedback/complaining, perhaps it's better to err on the side of maybe
> >> breaking something and see if that gets someone to come out of the
> >> woodwork if it really breaks, rather than tiptoeing around the code
> >> without knowing what's going on and without anyone actually testing th=
ings.
> >
> > That is because you distrust the intent that Cypress was really
> > contributing. They were and I trusted them to not just throw in a
> > feature like WPA3. When Infineon took over they went mute. Upon
> > reviewing your patch (again) I also sent an email to them asking
> > specifically about the status of the sae_password interface. I did not
> > use the mailing list which indeed bounces these days (hence removed
> > them) but the last living soul that I had contact with about a year ago
> > whether they were still comitted to be involved. I guess out of
> > politeness or embarrassment I got confirmation they were and never hear=
d
> > from him again. The query about the sae_password interface is still pen=
ding.
>
> If only corporate acquisition politics didn't repeatedly throw a wrench
> into this one... :/
>
> This is where we are though, Infineon clearly doesn't care, so it's time
> to move on.
>
> >> It's not about this *specific* patch, it's about the general situation
> >> of not being able to touch firmware interfaces "just in case Cypress
> >> breaks" being unsustainable in the long term. I wasn't pushing back
> >> because I think this particular one will be hard, I was pushing back
> >> because I can read the tea leaves and see this is not going to end wel=
l
> >> if it's the approach we start taking for everything. We *need* someone
> >> to be testing patches on Cypress, we can't just "try not to touch it"
> >> and cross our fingers. That just ends in disaster, we are not going to
> >> succeed in not breaking it either way and it's going to make the drive=
r
> >> worse.
> >
> > I admire you ability of reading tea leaves. You saw the Grim I reckon.
> > Admittedly your responses on every comment from my side (or Kalle for
> > that matter) was polarizing every discussion. That is common way people
> > treat each other nowadays especially online where a conversation is jus=
t
> > a pile of text going shit. It does not bring out the best in me either,
> > but it was draining every ounce of energy from me so better end it by
> > stepping out.
>
> The hilariously outdated kernel development model surely doesn't help
> either (I've stated my opinion on this quite a few times if you've
> followed around) ;)
>
> This stuff gets *really* frustrating when you're trying to improve what
> is, I hope we can all admit, an undermaintained driver (that is not to
> say it's anyone's fault personally), and end up getting held back due to
> everything from coding style nitpicks to people not having the time to
> be responsive. It's just not helpful. It's important to know when to
> step aside and let people actually get stuff done.
>
> When Daniel started sending me brcmfmac patches downstream, I took a
> look at a few of them, decided he knew what he was doing, and just
> started pulling in his branches wholesale. Was it perfect? No, I had to
> debug at least one regression at one point. But it took me less time to
> do that than it would've to go through the commits with a fine toothed
> comb, so it was clearly the right decision.
>
> That is not to say that should be the standard upstream (we make a point
> of moving fast and breaking things more downstream, since it's a proving
> ground for what eventually will be upstreamed), but I think it does
> demonstrate the kind of delegation ability that is sorely lacking in
> many drivers and subsystems in the kernel these days. Maintainers become
> entrenched in their position, long beyond the point where they have the
> time/motivation/ability to drive the code forward, and end up in the way
> of new people who are trying to make a difference. I think Linus knows
> full well the kernel maintainer community is stagnating.
>
> That doesn't mean people should step down entirely. But it does mean
> they need to recognize when this is happening and, at least, proactively
> try to bring new people in, instead of just continuing to play a
> gatekeeping role. The role of maintainers should not be that of a wall
> people have to climb over to get their changes in, it should be to guide
> new contributors and help onboard people who can contribute, as peers
> and eventually as future maintainers.
>
> Kalle, in the other thread you said "this is not fun anymore, this is
> more like a business with requirements and demands coming from
> everywhere.". That's what it feels like to us when our changes get
> rejected because the local vars aren't in reverse Christmas tree order,
> or because our commit messages have "v2:" in them. It feels like some
> manager is trying to justify their position by creating busywork for
> everyone else. Nobody should actually care about any of those things,
> and if they do, they need to step back and really ask themselves how
> they ended up believing that. If the goal is to enforce a reasonable
> shared coding style so things don't spiral into chaos, FFS, let's just
> do what every other project does these days and adopt clang-format. Then
> *all* of us can stop wasting time on these trivialities and go back to
> getting stuff done. And really, nobody cares about commit messages as
> long as the tags are right, the subject line is succinct, and the
> important information is in there. Extra stuff never hurt anyone.
>
> > I added the ground work for multi-vendor support, but have not decided
> > on the approach to take. Abstract per firmware interface primitive or
> > simply have a cfg80211.c and fwil_types.h per vendor OR implement a
> > vendor-specific cfg80211 callback and override the default callback
> > during the driver attach, ie. in brcmf_fwvid_wcc_attach(). The latter
> > duplicates things, but lean towards that as it may be easier on the
> > long-term. What do your tea leaves tell you ;-)
>
> FWIW, I was hoping you'd stay on at least as a reviewer. Your
> contributions are valuable. You obviously know the driver and hardware
> much better than most people. I encourage you to, at least, post a v2 of
> the MAINTAINERS patch with yourself as an R: line.

I generally agree with this email, especially that Arend should stay
on as a reviewer/maintainer.

We need more people as either maintainers/contributors/reviewers/code
writers/testers, not less, to delegate, co-maintain, test, merge, make
the code more portable to many wifi devices, etc.

What really matters at the end of the day I guess is writing the code
that works across all the devices and testing it.

Which is why I spread awareness about this area, got 100s of
responses, especially on Linkedin, there's at least a portion of these
that want to help, in good spirits.

Is mise le meas/Regards,

Eric Curtin

>
> As far as the actual driver abstraction architecture, I'm going to leave
> it to Daniel to decide what makes the most sense, since he's the one
> introducing new mechanisms for that already. There's always room for
> refactoring later though, depending on the direction things take with
> the vendor split. BTW, clang-format also makes refactoring a lot less
> painful ;)
>
> - Hector
>


