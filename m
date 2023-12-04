Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111E802982
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjLDAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 19:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLDAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 19:32:42 -0500
Received: from ar2.dbzero.it (unknown [IPv6:2a00:6d41:10:195b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C096DB;
        Sun,  3 Dec 2023 16:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dividebyzero.it; s=20160415; h=Message-ID:References:In-Reply-To:Cc:To:
        Subject:From:Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KCX/z8/d+lmUhr6gwHmo5sCy0U2X1rU51q6fT7ETS9k=; b=ijkYWrEDezvvp14LvOzLBVn5kt
        CO+UYeKqtibIo/ynFbkDYNNuCP5F3lPtPPrTkAf/+MtCc422J35WJmIoJ28sYkQgLs3PmEIuDsk1S
        yNQP1uWYgJh+84ujIpeVPyNijpb/OxXITHTtrr0E94lgeTOg2aHE6mO+HQfJWeloAYPg=;
Received:  by ar2.dbzero.it with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (Authenticated user: juri@dividebyzero.it)
        (envelope-from <juri@dividebyzero.it>)
        id 1r9wsq-0002ZB-8X; Mon, 04 Dec 2023 01:32:24 +0100
MIME-Version: 1.0
Date:   Mon, 04 Dec 2023 00:32:22 +0000
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
In-Reply-To: <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
 <024c4ad4-1a73-8c24-5e6f-f8c9f2f7b98f@redhat.com>
 <1884918.tdWV9SEqCh@dividebyzero.it>
 <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
Message-ID: <29cfa375a005b4f3d695815d845c0406cc34845f@dividebyzero.it>
X-Original-Message-ID: <29cfa375a005b4f3d695815d845c0406cc34845f@dividebyzero.it>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply, and sorry for the delay.

As I was gathering the information you asked for I realized that the beha=
vior has changed in the meantime, and I am not sure of the reason why (bu=
t I guess due to some package update, possibly unrelated to this).

If I understand correctly, now the events are no longer reported by the A=
sus WMI driver, but by the Intel backlight driver. Because of this the ba=
cklight variations are once again reported by the DM (KDE Plasma 5, on Ar=
ch Linux) in 5% increments, and no longer seem to be under EC control (i.=
e. the backlight is no longer adjustable during boot, before the DE is up=
).
The new behavior persist even downgrading the kernel and the firmware pac=
kage, so I'm not sure which package may be responsible for the change.

Booting into Debian Bookworm (v6.1.0-13) the old behavior is restored (i.=
e. the one before the previous patches), with Asus-WMI once again in cont=
rol (so I guess that at least the change do not persist across reboots).

November 25, 2023 at 15:25, "Hans de Goede" <hdegoede@redhat.com> wrote:
>=20
>=20Hi Juri,
>=20=20
>=20On 11/24/23 16:54, Juri Vitali wrote:
>>=20=20
>>=20=20
>>=20 Hi,
>>  Unfortunately those patches have broken the backlight reporting on ol=
der=20
>>=20 laptops, which do rely on the old mechanism.
>>=20=20
>=20=20
>=20 Thank you for reporting this and sorry about the regression.
>=20=20
>=20 And thank you for writing a good bug report with as much info
>  included as possible, that is much appreciated.
>=20=20
>>=20=20
>>=20 For instance, on my Asus UX32A/VD when pressing the backlight up/do=
wn button=20
>>=20 the backlight changes accordingly,
>>=20=20
>=20=20
>=20 Ok, so the embedded-controller (EC) is adjusting the brightness
>  itself in reaction to the key presses, which means that
>  the old behavior of sending KEY_BRIGHTNESSDOWN /=20
>=20 KEY_BRIGHTNESSUP was not really correct because that will
>  cause e.g. GNOME to then increase the brightness itself
>  which means that if the new brightness is correctly reflected
>  when reading it GNOME may increase the brightness an
>  additional step on top of the step it has already been
>  increased by the EC itself.
>=20=20
>=20 Which makes me wonder how to properly solve this,
>  so I have a bunch of questions:
>=20=20
>=20 1. What desktop environment are you using ?
>=20=20
>=20 2. Assuming you are using GNOME (for now) I guess that with older
>  kernels you got an on-screen-display (OSD) notification about
>  the brightness changing? Do you notice any difference in how
>  many total steps you have going from min to max with older
>  kernels vs the new kernel ? If the double increase problem
>  happens I guess you only get 5 brightness levels in GNOME /
>  4 steps from going from minimal to maximum ?
>=20

For=20the aforementioned reasons I can no longer reproduce the issue on t=
he original environment (KDE Plasma 5 on Arch Linux) but the behavior on =
Gnome on Debian is basically the same as before, so I'll be using that.
In both cases (now on Debian, and previously on Arch) the brightness has =
a granularity on 10-ish steps (0-100% in increments of 10% for KDE Plasma=
 on Arch, and 9 unnamed steps on Gnome on Debian), and no "double-change"=
 seem to be occurring.

>=20
>=20Note below questions should all be answered with the new kernel
>  with the unknown key messages in dmesg.
>=20=20
>=20 3. Can you do:
>=20=20
>=20 ls /sys/class/backlight
>=20

On=20Debian:=20
>=20
> $ ls -l /sys/class/backlight/
>  total 0
>  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video0 -> ../../devices/pci0=
000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
>  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video1 -> ../../devices/pci0=
000:00/0000:00:02.0/backlight/acpi_video1

On Arch:
> ls -l /sys/class/backlight/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>=20totale 0
> lrwxrwxrwx 1 root root 0  4 dic 00.43 intel_backlight -> ../../devices/=
pci0000:00/0000:00:02.0/drm/card1/card1-eDP-1/intel_backlight

>=20
>=20 And let me know the output, I wonder what method is being
>  used to control backlight on your machine.
>=20=20
>=20 4. Can you do:
>=20=20
>=20 cat /sys/class/backlight/$name/max_brightness
>=20=20
>=20 What does this say?
>=20=20
>=20 With $name being the name from 3.
>=20=20
>=20 5. Can you do:
>=20=20
>=20 cat /sys/class/backlight/$name/brightness
>=20=20
>=20 And then change the brightness using the keys, and then
>  again do:
>=20=20
>=20 cat /sys/class/backlight/$name/brightness
>=20=20
>=20 What are the values shown before / after changing it ?
>=20=20
>=20 6. Can you repeat 5 but then do:
>=20=20
>=20 cat /sys/class/backlight/$name/actual_brightness
>=20

On=20Debian:
* `max_brightness` is `10` on both devices;
* `brightness` goes from 1 to 10 following the screen brighness only for =
`acpi_video0`, while in `acpi_video1` it is stuck at `10`;=20
*=20`actual_brightness` follows the screen brightness on both devices.

On Arch:
* `max_brighness` is 4296;
* `brightness` changes in steps of 215 units for each 5% reported increme=
nt;
* `actual_brightness` is the same as `brighness`.

Notice that before the latest change in behavior the output on Arch was I=
IRC the same as now on Debian, but unfortunately I haven't recorded it so=
 I cannot say with absolute certainty.

>=20
>=207. Can you run:
>=20=20
>=20 sudo acpidump -o acpidump.txt
>=20=20
>=20 And then email me the generated acpidump.txt file
>  in a private email ?
>=20=20

I'll=20send you a mail with the output on both Debian and Arch, in case t=
here should be any significant differences.

>=20=20
>=20 Thanks, that (the codes not overlapping with newer models codes) is
>  useful information to have. With that it should be easy to restore
>  the old behavior of sending KEY_BRIGHTNESSDOWN / UP, my questions
>  above are mainly because I wonder if that is the right thing to do
>  taking into account that the EC already adjusts the brightness itself.
>=20=20
>>=20=20
>>=20 By the way, I only found those codes to be reported by asus-wmi, wh=
ile other=20
>>=20 inputs remain silent while pressing those keys.
>>=20
>=20=20
>=20 Yes that is expected, for unknown asus-wmi events no events
>  are send to userspace.
>=20=20
>=20 Regards,
>=20=20
>=20 Hans
>

Thank you again, and let me know if there is anything missing!

Juri
