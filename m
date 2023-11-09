Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31A7E6E63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjKIQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjKIQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:14:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A43272
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699546447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRbyLc/2EfGb6Ms93DwiyFkj3WWvI48paLLsUDFKqtk=;
        b=STbBkCXbxzlyDJespty43XFMw39t/iA4xTibFLsskiMZR2+gOwvnVrfwt2NtNp2CnPLDbi
        lds5ZMAYtLWrTghHUIbFNv4A6PreGAyPxd4PrVD2X4eIuUPdg4j/mIl1HEGHcAhAO+red8
        z3/gL+R8mCYesgEKwVRqprUFPHV4k7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-34WajkX9NNuDYr-Kcmyj5A-1; Thu, 09 Nov 2023 11:14:05 -0500
X-MC-Unique: 34WajkX9NNuDYr-Kcmyj5A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d4b8735f48so88257966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546444; x=1700151244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRbyLc/2EfGb6Ms93DwiyFkj3WWvI48paLLsUDFKqtk=;
        b=Mm3FHRVqKzOadfkAMkYmQX4H0QX/9jsGCEvxFOrYiqnKPhPcozY3oochtorYBF/3iQ
         YCnODDqiT0skr5EauKE/o+2C9/Lu7OLY/Da+jxIZ4rY7srDjs7Q9mS30aALH548ccKk5
         G7b5HByp65NvEDLHc+LUaHHvPKvBb2yaNiEIOlhidBDlUw+scMU9s4OpcSTfA2Zev/tv
         QX5LnBICJEFQMuSyMP30lW52K0oKiQLeJ4nU0ykoSFEZYU8DRi4mF4xM+LTMB2f58IQ+
         kz7p1bp5OZR7x2QtL0HfhR2ux3sRorGpplksTOkq0ST22pt+gSXqbYNcIIfAa8hTV7Tk
         1VIA==
X-Gm-Message-State: AOJu0YzTa36OLyeS1cXxQsfMjdb4Vh4HjktLse4Hn25HRsxxba1DML0a
        D9/qBIdfNKrX7R14ObJ42xwqv9AT53lNauFdabDgl+JGhYm10O0rCfrXqKjzuqd6FLjahRjIpbd
        IJwDA4KTGsIcTNf+QtfJx4UwETrokgNIZ2MVVKDeb
X-Received: by 2002:a17:907:934b:b0:9c4:67f:3ef5 with SMTP id bv11-20020a170907934b00b009c4067f3ef5mr4707299ejc.50.1699546444072;
        Thu, 09 Nov 2023 08:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH/vCdBTb9AR1h3trZVPI9wHo8Q1qKaGn2f+LOy8onw/MVVLaTHPDLDFgIsp2l0Y0B2mIG+C8w+Mo9JQ7YH10=
X-Received: by 2002:a17:907:934b:b0:9c4:67f:3ef5 with SMTP id
 bv11-20020a170907934b00b009c4067f3ef5mr4707283ejc.50.1699546443745; Thu, 09
 Nov 2023 08:14:03 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
 <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
 <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
 <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
 <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
In-Reply-To: <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Nov 2023 17:13:51 +0100
Message-ID: <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 12:56=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi David,
>
> On Thu, Nov 9, 2023 at 1:32=E2=80=AFAM David Revoy <davidrevoy@protonmail=
.com> wrote:
> >
> > Hi Benjamin,
> >
> > > Alright, I made quite some progress so far:
> > > - regressions tests have been written (branch wip/xp-pen of my fork o=
n
> > > freedesktop[0])
> > > that branch can not go in directly as it just adds the tests, and
> > > thus is failing
> > > - I made the fixes through HID-BPF[1]
> > >
> > > Anyone using those 2 tablets and using Fedora should be able to just
> > > grab the artifact at [2], uncompress it and run `sudo ./install.sh --=
verbose`.
> > > This will install the bpf programs in /lib/firmware/hid/bpf/ and will
> > > automatically load them when the device is connected.
> > >
> > > For those not using Fedora, the binary might work (or not, not sure),
> > > but you can always decompress it, and check if running
> > > `udev-hid-bpf_0.1.0/bin/udev-hid-bpf --version` returns the correct
> > > version or just fails. If you get "udev-hid-bpf 0.1.0", then running
> > > `sudo ./install.sh --verbose` should work, as long as the kernel has
> > > CONFIG_HID_BPF set to 'Y'.
> > > [...]
> > > [0] https://gitlab.freedesktop.org/bentiss/hid/-/tree/wip/xp-pen?ref_=
type=3Dheads
> > > [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requ=
ests/27
> > > [2] https://gitlab.freedesktop.org/bentiss/udev-hid-bpf/-/jobs/513505=
89/artifacts/raw/udev-hid-bpf_0.1.0.tar.xz
> >
> > Thank you for this package.
> >
> > I was able to test it even though the link in (2) at the bottom of your=
 email returned a blank page. I was able to find my way after manually visi=
ting gitlab.freedesktop.org [1] and then manually downloading the article f=
rom 51350589. I unzipped it and ran `sudo ./install.sh --verbose`. Everythi=
ng looks like it was successful [2]. I then rebooted my Fedora 38 'Linux wo=
rkstation 6.5.8-200.fc38.x86_64' kernel (the one I blamed in my post) and t=
ested both tablets.
>
> Weird that you had to manually retrieve it. It works here, but maybe
> because I am logged in on gitlab.fd.o.
>
> Also, just FYI, you shouldn't have to reboot. Just unplug/replug and
> you are good. In the same way, if you uninstall the package, you can
> just unplug/replug to not have the programs loaded.

I've pushed an update of the file[0], turns out I made several mistakes.
As a general rule of thumb, you can follow the MR I've opened at [1],
click on the pipeline, open the last job ("make release"), then browse
the artifacts and pull the file from there.

>
> >
> > Here are my observation:
> >
> > XPPEN Artist Pro 24
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Nothing changed for this device (it's the one with two buttons and no '=
eraser tip'). Nor my hwdb/udev rules or `xsetwacom set "UGTABLET 24 inch Pe=
nDisplay eraser" button 1 3` affects the upper button of the stylus: if I h=
old it hover the canvas, Krita switch the tool and cursor for an eraser. If=
 I click on the canvas with the pen tip while holding the upper button pres=
sed, I get the right-click Pop-up Palette (but not all the time, probably K=
rita has hard time to triage Eraser or Right-click).
>
> As I mentioned in another reply, the more I think of it, the more I
> think I should get rid of the "eraser mode". In that Artist Pro 24 I
> can detect it through the same mechanics as the HID_QUIRK_NOINVERT
> from Illia's patch. But instead of trying to force the device into the
> eraser mode, we should just say "this is actually BUTTON_STYLUS_2".
>
> So I'm going to amend the bpf program to do this and hopefully you
> won't need the hwdb/udev rule at all.

I've fixed that one normally. There were a couple of issues:
- the PID in use was the one from the pro 16 gen2, which explained why
no change was appearing
- I've now decided to not export the second button as an eraser, as
mentioned above.

>
> >
> > XPPEN Artist Pro 16 (Gen2)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > Something changed. `xsetwacom set "UGTABLET Artist Pro 16 (Gen2) eraser=
" button 1 3` successfully affected the upper button of the stylus. Now if =
I click it while hovering the canvas, Krita shows the right click Pop-up Pa=
lette.
>
> I'm surprised you need to teach the wacom driver that BTN_STYLUS_2 is
> the right click.
>
> > On the downside; the real eraser tip when I flip the stylus bugs. When =
I flip the stylus on eraser hovering the canvas, Krita shows the Eraser ico=
n and switch tool. As soon as I draw with the eraser tip, Krita will also s=
how a right-click color palette and with also not a 100% consistency, as if=
 the event were mixed.
>
> I'll investigate. Maybe I messed up with my event flow patch.

Definitely my mistake: both the bpf programs I wrote were attached to
the same device. Thus, the 2 fixes were stacking on each other,
leading to some interesting side effects.

You can check that the bpf are properly loaded by having a look at the
report descriptor when you replug the device:
if you see "Secondary Barrel Switch" at offset 16 instead of "Eraser"
on both of your tablets (with hid-recorder), you should have
successfully patched your devices.

Cheers,
Benjamin

>
> But just to be sure, you don't have a custom configuration in place
> for that tablet device?
>

[0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/51399392/ar=
tifacts/file/udev-hid-bpf_0.1.0.tar.xz
[1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/2=
7

