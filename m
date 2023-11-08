Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A147E5D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6FD4F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699467701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nM25pz9FDJ2xEFXEWA0rCb20z2Slt1QqjiMFrxf2tbc=;
        b=gB8hBnTJWciF4RuzKN0xB+JyS4+cXiQYK7j1P4UIMTrAqaOhRooJtyixe0fZ5d/w3xjOHT
        DQoijqMCFtAUY0+ijX1EIawBo17F0BFNe/uWxm+qzmkuX9iBNVXRO4uA/+XfqgD+0YjwWp
        PTKPLalZO9xRwRJSxW4IEou/82XZNrU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FMnJueiLNXWNtilnaXv7Xw-1; Wed, 08 Nov 2023 13:21:40 -0500
X-MC-Unique: FMnJueiLNXWNtilnaXv7Xw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c749c28651so2312666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467698; x=1700072498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM25pz9FDJ2xEFXEWA0rCb20z2Slt1QqjiMFrxf2tbc=;
        b=BS8IYUyMQJUXA146/d+jI1UZQh1N4CBBmQKnMU14QOZam7oNGT2OyQa4kA1chWQk64
         D/S3fx5rhcCFiOCbaVAa6iRWBUxdlODPD1slNS2w/a0TpQoot1MQ0SQ+rJ5LzyqPXljc
         BqthPyJVtP8/1wGhO+H8twwQMkPQj6MrsYt6FtIPeBdX2+bmrXqIjYjAQIX4l4tz6Efj
         V3JALldOQhT3F+9AjbjD9O7mbwyhhpYHrlNdzcJJAI9o1CgMjEo1ftIoUn3MLIITTd+T
         Qa62JuQViV8vXK446L/lnzesbVj3rp7WdopwqXS5CAfrfVRHYvsb9HcSthjbsHWh+zg2
         24+w==
X-Gm-Message-State: AOJu0YzRomr1PaFecHVTgkgPfLFwdBwpq0QWKe8G442PMzDK1gqsYPMU
        BFG78SIQp8Ry6hPYOHxQw2J+AUeagzJskbZPnCxy8/LrwTl8878zbHsMLWepsPyJjiWTyex3nfg
        973gT1bvOx98yIQ7rfi0jdrTWaqg6g9WI/VAHnx9pZIhU4bN5ZTQ=
X-Received: by 2002:a17:906:dc92:b0:9ae:420e:739b with SMTP id cs18-20020a170906dc9200b009ae420e739bmr1666257ejc.46.1699467698299;
        Wed, 08 Nov 2023 10:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJlPNVhDtklUG03CTF6jBxy5u25hWVE1q1Iuj+GVBqlz7cdAhD+ekN0tD/nC9WkOEIuafaTQ8CTj9itlB+8OI=
X-Received: by 2002:a17:906:dc92:b0:9ae:420e:739b with SMTP id
 cs18-20020a170906dc9200b009ae420e739bmr1666238ejc.46.1699467698013; Wed, 08
 Nov 2023 10:21:38 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
 <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
In-Reply-To: <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Nov 2023 19:21:25 +0100
Message-ID: <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        David Revoy <davidrevoy@protonmail.com>, jkosina@suse.cz,
        jason.gerecke@wacom.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 10:34=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Nov 8, 2023 at 10:23=E2=80=AFAM Jos=C3=A9 Exp=C3=B3sito <jose.exp=
osito89@gmail.com> wrote:
> >
> > Hi Benjamin,
> >
> > On Wed, Nov 08, 2023 at 10:04:30AM +0100, Benjamin Tissoires wrote:
> [...]
> > >
> > > >
> > > > So, the behavior probably breaks the specs, but sincerely I'm happy=
 to
> > > > have the "eraser" button independent of the "rubber eraser", which
> > > > makes the stylus a somewhat 4-buttons stylus (tip, button1, button2=
,
> > > > rubber), and I would like to keep this.
> > >
> > > Yes, and I'd like to keep it that way, even if 6.6 and 6.5.8
> > > apparently broke it.
> > >
> > > So, to me:
> > > - 276e14e6c3993317257e1787e93b7166fbc30905 is wrong: this is a
> > > firmware bug (reporting invert through eraser) and should not be
> > > tackled at the generic level, thus it should be reverted
> > > - both of these tablets are forwarding the useful information, but no=
t
> > > correctly, which confuses the kernel
> > > - I should now be able to write regression tests
> > > - I should be able to provide HID-BPF fixes for those tablets so that
> > > we can keep them working with or without
> > > 276e14e6c3993317257e1787e93b7166fbc30905
> > > reverted (hopefully)
> > > - problem is I still don't have the mechanics to integrate the HID-BP=
F
> > > fixes directly in the kernel tree, so maybe I'll have to write a
> > > driver for XP-Pen while these internals are set (it shouldn't
> > > interfere with the HID-BPF out of the tree).
> >
> > I already added support for a few XP-Pen devices on the UCLogic driver
> > and I was planning to start working on this one during the weekend in
> > my DIGImend fork (to simplify testing).
> >
> > Let me know if you prefer to add it yourself or if you want me to ping
> > you in the DIGImend discussion.
> >
>
> So far, I really have to work on this now. It's a good use case for
> HID-BPF and it's a regression that I'd like to be fixed ASAP.
> I'd appreciate any reviews :)

Alright, I made quite some progress so far:
- regressions tests have been written (branch wip/xp-pen of my fork on
freedesktop[0])
  that branch can not go in directly as it just adds the tests, and
thus is failing
- I made the fixes through HID-BPF[1]

Anyone using those 2 tablets and using Fedora should be able to just
grab the artifact at [2], uncompress it and run `sudo ./install.sh
--verbose`.
This will install the bpf programs in /lib/firmware/hid/bpf/ and will
automatically load them when the device is connected.

For those not using Fedora, the binary might work (or not, not sure),
but you can always decompress it, and check if running
`udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
version or just fails. If you get "udev-hid-bpf 0.1.0", then running
`sudo ./install.sh --verbose` should work, as long as the kernel has
CONFIG_HID_BPF set to 'Y'.

>
> Also, good to know that I can probably piggyback on hid-uclogic for
> fixing those 2 devices in the kernel.
>

Next step will be to fix them using a kernel driver, but it seems that
the uclogic driver is doing more than just report descriptor fixups,
so maybe I'll have to use a different driver.
But the point is, in theory, if you are affected by those bugs, using
the udev-hid-bpf should fix the issue, and this should also be
resilient to further kernel updates.

I'd appreciate testing when I got the full kernel series up and ready,
of course.

Cheers,
Benjamin

[0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_type=
=3Dheads
[1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/2=
7
[2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/51350589/art=
ifacts/raw/udev-hid-bpf_0.1.0.tar.xz

