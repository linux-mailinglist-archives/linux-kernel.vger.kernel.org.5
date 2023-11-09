Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF37E6D40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjKIPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:21:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40B530E5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:21:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809414efa9so935470a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699543312; x=1700148112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ9Bh/qtHtUkkuu0G+Utf6YgDe/OtifeHbsd9UTxGpg=;
        b=BibmXFKLqYj9LR1+TYCjig/18B3oiX+/Osm5mJrRXHBSAGlDWfV2z05K2AMNvMpY67
         w7zjAKpFBAcS67N5H6B4XEkMaiBHoKsgFtkN0oM5qo7qws4ewjwvWx8e7+Aao6WOcl8B
         zPXyAb4FhM4A8KYyxHtpzl+IHdsV48D/1qG9exb/BoZ+9ssHs9EGpIhdE/9Q8A4aQIMY
         UE38JIK3XQTcwpaXV6LinrrME/z4IWkvexB66yzPc2nPXRYrixb08SxZD74XTWsV1CkD
         9zzTd6QZ5cwE/HlW3G36EFzqOIKEY8EFULe320swO47096SA4orBoV7EzTVBWr8PktvV
         0sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543312; x=1700148112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ9Bh/qtHtUkkuu0G+Utf6YgDe/OtifeHbsd9UTxGpg=;
        b=R5RbAYfFnJbQlK213gMyqYZt2o7y+1qUpVv9xjfbMYLc+MBe1Bp6WLoZoKwNL6Hv45
         RWWUfBRnt0L1j2w/wKcF5M2UBMdyf/VemU5m4Iv+BPA9qBQHImeic4FOIjZWVLGvx9Fd
         Cjy02TNexCy4vO81SBMEIvPLftHjt8UIO8ST2cu7/0wcdReaaSwxyXq5MFG9xLe7NCxL
         gGnlTrIc3q5HGYCQTEL+wNx1Agd19U20NFujPjivA3nRo256eam7W0S1+mAC5ECCTm0M
         JwHyR8GkScj3iSPCkcWZfLoQ0NnObgzLHRv6BIr/9z7dNHVDm1auprrlHSnH8U8W+v22
         BreA==
X-Gm-Message-State: AOJu0YzRstTEfBOIsPQLyDIz/5vcGaffW4Q5+3qgoxx7EhVeO2sU8LpN
        gZ61ADE0EBiCgRAwBZ3r/0qIc1hdNHaSjddYK1VLwg==
X-Google-Smtp-Source: AGHT+IFgFpuFFhL3c+CMYySOWybfBziKPtmgOPjan0yH/1wmtzPs6sm3AbQBhfov98QDk6aA0Pa8Aw7oLG7mtbRW1lk=
X-Received: by 2002:a17:90a:8045:b0:280:c576:31bc with SMTP id
 e5-20020a17090a804500b00280c57631bcmr1939418pjw.32.1699543312193; Thu, 09 Nov
 2023 07:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk> <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk> <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk> <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
 <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk> <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
 <ZUzDBCaqR9Ui4j71@finisterre.sirena.org.uk> <CABqG17gc40_z4FWSwnqUwnXGKZzGAHs6zD7br03chcT_+bGWLw@mail.gmail.com>
In-Reply-To: <CABqG17gc40_z4FWSwnqUwnXGKZzGAHs6zD7br03chcT_+bGWLw@mail.gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 9 Nov 2023 20:51:40 +0530
Message-ID: <CABqG17gXKGSSqjxYKomJKnYAZ6Q3P7+OXMo3=HD=QySuaqU=4Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 9 Nov 2023 at 20:41, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> Hi Mark,
>
>
> On Thu, 9 Nov 2023 at 17:01, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Nov 09, 2023 at 04:08:06PM +0530, Naresh Solanki wrote:
> > > On Thu, 2 Nov 2023 at 22:20, Mark Brown <broonie@kernel.org> wrote:
> >
> > > > Ah, right.  Everything except for the enable and disable there look=
s
> > > > like it should be OK since they should normally just not happen but=
 the
> > > > enables and disables might get a bit frequent with runtime PM - not
> > > > *super* frequent like voltage scaling but enough that people could =
have
> > > > an issue with it.
> >
> > > I aim for a straightforward implementation.
> > > Using attributes such as status or state seems ideal for receiving
> > > notifications.
> > > In my case, the application focuses on status changes=E2=80=94whether=
 it's on, off,
> > > or encountering an error.
> > > These changes are driven by events originating from the regulator.
> > > So below change is what I see fit well.
> > >
> > >         status_events =3D REGULATOR_EVENT_DISABLE;
> > >         status_events |=3D REGULATOR_EVENT_ENABLE;
> > >         status_events |=3D REGULATOR_EVENT_FAIL;
> > >         status_events |=3D REGULATOR_EVENT_FORCE_DISABLE;
> > >         status_events |=3D REGULATOR_EVENT_ABORT_DISABLE;
> >
> > In terms of the implementation for delivering uevents this looks fine,
> > my concern here is that for some systems the enable and disable events
> > might happen more often than is really a good fir for delivering via
> > uevents, if a device like say a SD card is getting powered up and down
> > via runtime PM that might happen relatively often and then the system
> > would get a lot of uevents which it would most likely end up ignoring.
> > That could have a noticable impact on power or performance.
>
> May be in that case should we consider adding a kernel parameter or
> some property in sysfs attribute to allow getting events ?
Or may be even Kconfig option ?
>
> Regards,
> Naresh
