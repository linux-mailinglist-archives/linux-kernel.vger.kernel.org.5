Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1047E616D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjKIAce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIAcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:32:33 -0500
X-Greylist: delayed 7422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 16:32:30 PST
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF12588
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699489947; x=1699749147;
        bh=mbas3qgCafFlNKUOVoJnFndc2NTEFuTXuNWWCAWewGw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=osEayDi40a1PpKI5GROe9OK93e5Z3KR4XCK17f3deHnxeOLldFdgW98EYp21q2pBk
         8kEhzHGSEgeoqe1CsC/tauam4Rn1d2cnF6zLJpXc4bK76gagstKIoCojOyQey3yfex
         5Avu07OkSdfq5ogas6PEeZ0vikUOeq9rwn1/PPwTaFY+niVuE4COfAFyniVDzA9871
         DstDV26bwvi5YGeuAQH+57sWGcTPKRawhqItZrOKdUA/V59coiblPm8hJnXHbXchrM
         oQtZywOjbJuZXRZthLWtF187k/t/Dn9p1zy/O1KEoi9d6m21fJANKcUAb1MIXucdWa
         tx4FFwiZAaXmw==
Date:   Thu, 09 Nov 2023 00:32:12 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
In-Reply-To: <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com> <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de> <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com> <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com> <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com> <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> Alright, I made quite some progress so far:
> - regressions tests have been written (branch wip/xp-pen of my fork on
> freedesktop[0])
> that branch can not go in directly as it just adds the tests, and
> thus is failing
> - I made the fixes through HID-BPF[1]
>=20
> Anyone using those 2 tablets and using Fedora should be able to just
> grab the artifact at [2], uncompress it and run `sudo ./install.sh --verb=
ose`.
> This will install the bpf programs in /lib/firmware/hid/bpf/ and will
> automatically load them when the device is connected.
>=20
> For those not using Fedora, the binary might work (or not, not sure),
> but you can always decompress it, and check if running
> `udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
> version or just fails. If you get "udev-hid-bpf 0.1.0", then running
> `sudo ./install.sh --verbose` should work, as long as the kernel has
> CONFIG_HID_BPF set to 'Y'.
> [...]
> [0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_type=
=3Dheads
> [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests=
/27
> [2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/51350589/a=
rtifacts/raw/udev-hid-bpf_0.1.0.tar.xz

Thank you for this package.=20

I was able to test it even though the link in (2) at the bottom of your ema=
il returned a blank page. I was able to find my way after manually visiting=
 gitlab.freedesktop.org [1] and then manually downloading the article from =
51350589. I unzipped it and ran `sudo ./install.sh --verbose`. Everything l=
ooks like it was successful [2]. I then rebooted my Fedora 38 'Linux workst=
ation 6.5.8-200.fc38.x86_64' kernel (the one I blamed in my post) and teste=
d both tablets.=20

Here are my observation:

XPPEN Artist Pro 24
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nothing changed for this device (it's the one with two buttons and no 'eras=
er tip'). Nor my hwdb/udev rules or `xsetwacom set "UGTABLET 24 inch PenDis=
play eraser" button 1 3` affects the upper button of the stylus: if I hold =
it hover the canvas, Krita switch the tool and cursor for an eraser. If I c=
lick on the canvas with the pen tip while holding the upper button pressed,=
 I get the right-click Pop-up Palette (but not all the time, probably Krita=
 has hard time to triage Eraser or Right-click).

XPPEN Artist Pro 16 (Gen2)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Something changed. `xsetwacom set "UGTABLET Artist Pro 16 (Gen2) eraser" bu=
tton 1 3` successfully affected the upper button of the stylus. Now if I cl=
ick it while hovering the canvas, Krita shows the right click Pop-up Palett=
e.
On the downside; the real eraser tip when I flip the stylus bugs. When I fl=
ip the stylus on eraser hovering the canvas, Krita shows the Eraser icon an=
d switch tool. As soon as I draw with the eraser tip, Krita will also show =
a right-click color palette and with also not a 100% consistency, as if the=
 event were mixed.

[1] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/artifacts =20
[2] https://www.peppercarrot.com/extras/temp/2023-11-09_screenshot_005214_n=
et.jpg


On Wednesday, November 8th, 2023 at 19:21, Benjamin Tissoires <benjamin.tis=
soires@redhat.com> wrote:


> On Wed, Nov 8, 2023 at 10:34=E2=80=AFAM Benjamin Tissoires
> benjamin.tissoires@redhat.com wrote:
>=20
> > On Wed, Nov 8, 2023 at 10:23=E2=80=AFAM Jos=C3=A9 Exp=C3=B3sito jose.ex=
posito89@gmail.com wrote:
> >=20
> > > Hi Benjamin,
> > >=20
> > > On Wed, Nov 08, 2023 at 10:04:30AM +0100, Benjamin Tissoires wrote:
> > > [...]
> > >=20
> > > > > So, the behavior probably breaks the specs, but sincerely I'm hap=
py to
> > > > > have the "eraser" button independent of the "rubber eraser", whic=
h
> > > > > makes the stylus a somewhat 4-buttons stylus (tip, button1, butto=
n2,
> > > > > rubber), and I would like to keep this.
> > > >=20
> > > > Yes, and I'd like to keep it that way, even if 6.6 and 6.5.8
> > > > apparently broke it.
> > > >=20
> > > > So, to me:
> > > > - 276e14e6c3993317257e1787e93b7166fbc30905 is wrong: this is a
> > > > firmware bug (reporting invert through eraser) and should not be
> > > > tackled at the generic level, thus it should be reverted
> > > > - both of these tablets are forwarding the useful information, but =
not
> > > > correctly, which confuses the kernel
> > > > - I should now be able to write regression tests
> > > > - I should be able to provide HID-BPF fixes for those tablets so th=
at
> > > > we can keep them working with or without
> > > > 276e14e6c3993317257e1787e93b7166fbc30905
> > > > reverted (hopefully)
> > > > - problem is I still don't have the mechanics to integrate the HID-=
BPF
> > > > fixes directly in the kernel tree, so maybe I'll have to write a
> > > > driver for XP-Pen while these internals are set (it shouldn't
> > > > interfere with the HID-BPF out of the tree).
> > >=20
> > > I already added support for a few XP-Pen devices on the UCLogic drive=
r
> > > and I was planning to start working on this one during the weekend in
> > > my DIGImend fork (to simplify testing).
> > >=20
> > > Let me know if you prefer to add it yourself or if you want me to pin=
g
> > > you in the DIGImend discussion.
> >=20
> > So far, I really have to work on this now. It's a good use case for
> > HID-BPF and it's a regression that I'd like to be fixed ASAP.
> > I'd appreciate any reviews :)
>=20
>=20
> Alright, I made quite some progress so far:
> - regressions tests have been written (branch wip/xp-pen of my fork on
> freedesktop[0])
> that branch can not go in directly as it just adds the tests, and
> thus is failing
> - I made the fixes through HID-BPF[1]
>=20
> Anyone using those 2 tablets and using Fedora should be able to just
> grab the artifact at [2], uncompress it and run `sudo ./install.sh --verb=
ose`.
> This will install the bpf programs in /lib/firmware/hid/bpf/ and will
> automatically load them when the device is connected.
>=20
> For those not using Fedora, the binary might work (or not, not sure),
> but you can always decompress it, and check if running
> `udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
> version or just fails. If you get "udev-hid-bpf 0.1.0", then running
> `sudo ./install.sh --verbose` should work, as long as the kernel has
> CONFIG_HID_BPF set to 'Y'.
>=20
> > Also, good to know that I can probably piggyback on hid-uclogic for
> > fixing those 2 devices in the kernel.
>=20
>=20
> Next step will be to fix them using a kernel driver, but it seems that
> the uclogic driver is doing more than just report descriptor fixups,
> so maybe I'll have to use a different driver.
> But the point is, in theory, if you are affected by those bugs, using
> the udev-hid-bpf should fix the issue, and this should also be
> resilient to further kernel updates.
>=20
> I'd appreciate testing when I got the full kernel series up and ready,
> of course.
>=20
> Cheers,
> Benjamin
>=20
> [0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_type=
=3Dheads
> [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests=
/27
> [2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/51350589/a=
rtifacts/raw/udev-hid-bpf_0.1.0.tar.xz
