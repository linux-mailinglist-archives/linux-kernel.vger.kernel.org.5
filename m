Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5A8033CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjLDNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:06:42 -0500
Received: from ar2.dbzero.it (unknown [IPv6:2a00:6d41:10:195b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F55AC;
        Mon,  4 Dec 2023 05:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dividebyzero.it; s=20160415; h=Message-ID:References:In-Reply-To:Cc:To:
        Subject:From:Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H9qOdYHXaG2ckz2DXF1ecUOZ9PWA/zAmLuKTDwEbDSM=; b=tDNxfPi/IWgAEvC7ElWwUAJ3Xg
        FBn7AOFt2hxqsLd7Cp/w1svATqrHst7XijVUdfJ5rMDeHdnklnNCPOdtZxPx0Bf676g10LPU/H58n
        +hwU7zC+8w98eSU8zlJzJOf5FU5+tn54SMQQavWcjre9KcODnfodyx7G9rSEq1vGwJyY=;
Received:  by ar2.dbzero.it with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (Authenticated user: juri@dividebyzero.it)
        (envelope-from <juri@dividebyzero.it>)
        id 1rA8eU-0004PB-3k; Mon, 04 Dec 2023 14:06:22 +0100
MIME-Version: 1.0
Date:   Mon, 04 Dec 2023 13:06:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   juri@dividebyzero.it
TLS-Required: No
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "James John" <me@donjajo.com>,
        "Corentin Chary" <corentin.chary@gmail.com>,
        "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <07b057618b72f301142585844ccdcaab75a716fe@dividebyzero.it>
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
 <024c4ad4-1a73-8c24-5e6f-f8c9f2f7b98f@redhat.com>
 <1884918.tdWV9SEqCh@dividebyzero.it>
 <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
 <07b057618b72f301142585844ccdcaab75a716fe@dividebyzero.it>
Message-ID: <f656f81bb288e69878ca001ec3e27c3ad647e7ea@dividebyzero.it>
X-Original-Message-ID: <f656f81bb288e69878ca001ec3e27c3ad647e7ea@dividebyzero.it>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 4, 2023 at 01:32, juri@dividebyzero.it wrote:
>=20
>=20Thank you for the reply, and sorry for the delay.
>=20
>=20As I was gathering the information you asked for I realized that the =
behavior has changed in the meantime, and I am not sure of the reason why=
 (but I guess due to some package update, possibly unrelated to this).
>=20
>=20If I understand correctly, now the events are no longer reported by t=
he Asus WMI driver, but by the Intel backlight driver. Because of this th=
e backlight variations are once again reported by the DM (KDE Plasma 5, o=
n Arch Linux) in 5% increments, and no longer seem to be under EC control=
 (i.e. the backlight is no longer adjustable during boot, before the DE i=
s up).
> The new behavior persist even downgrading the kernel and the firmware p=
ackage, so I'm not sure which package may be responsible for the change.
>=20

Investigating=20further I found that that the change was not due to an up=
dated package, but because I mistakenly removed a kernel cmdline argument=
, i.e. `"acpi_osi=3D!Windows 2012"`. Restoring it the behavior returns to=
 the same as before.=20

>=20Booting into Debian Bookworm (v6.1.0-13) the old behavior is restored=
 (i.e. the one before the previous patches), with Asus-WMI once again in =
control (so I guess that at least the change do not persist across reboot=
s).
>=20
>=20For the aforementioned reasons I can no longer reproduce the issue on=
 the original environment (KDE Plasma 5 on Arch Linux) but the behavior o=
n Gnome on Debian is basically the same as before, so I'll be using that.
> In both cases (now on Debian, and previously on Arch) the brightness ha=
s a granularity on 10-ish steps (0-100% in increments of 10% for KDE Plas=
ma on Arch, and 9 unnamed steps on Gnome on Debian), and no "double-chang=
e" seem to be occurring.

> On Debian:=20
>=20>=20
>=20> $ ls -l /sys/class/backlight/
> >  total 0
> >  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video0 -> ../../devices/pc=
i0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
> >  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video1 -> ../../devices/pc=
i0000:00/0000:00:02.0/backlight/acpi_video1
> >=20
>=20
> On Arch:
> >=20
>=20> ls -l /sys/class/backlight/=20
>=20>  totale 0
> >  lrwxrwxrwx 1 root root 0 4 dic 00.43 intel_backlight -> ../../device=
s/pci0000:00/0000:00:02.0/drm/card1/card1-eDP-1/intel_backlight
> >=20
>=20
> On Debian:
> * `max_brightness` is `10` on both devices;
> * `brightness` goes from 1 to 10 following the screen brighness only fo=
r `acpi_video0`, while in `acpi_video1` it is stuck at `10`;=20
>=20* `actual_brightness` follows the screen brightness on both devices.
>=20
>=20On Arch:
> * `max_brighness` is 4296;
> * `brightness` changes in steps of 215 units for each 5% reported incre=
ment;
> * `actual_brightness` is the same as `brighness`.
>=20
>=20Notice that before the latest change in behavior the output on Arch w=
as IIRC the same as now on Debian, but unfortunately I haven't recorded i=
t so I cannot say with absolute certainty.

Restoring `"acpi_osi=3D!Windows 2012"`, on Arch Linux the result is:
> % uname -a=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>=20Linux Arch-Zenbook 6.1.64-1-lts #1 SMP PREEMPT_DYNAMIC Tue, 28 Nov 20=
23 19:37:35 +0000 x86_64 GNU/Linux
> % ls -l /sys/class/backlight=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>=20totale 0
> lrwxrwxrwx 1 root root 0  4 dic 13.41 acpi_video0 -> ../../devices/pci0=
000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
> lrwxrwxrwx 1 root root 0  4 dic 13.41 acpi_video1 -> ../../devices/pci0=
000:00/0000:00:02.0/backlight/acpi_video1

* `max_brightness` is `10` on both devices;
* `brighness` is stuck at `10` on both;
* `actual_brightness` goes from 0 to 10 only on `acpi_video1`, while is s=
tuck at 10 on `acpi_video0`.

Notice that with this kernel and configuration I again have the `unknown =
key code` messages and no OSD feedback, which I wasn't able to replicate =
in the previous message.

Regards,

Juri
