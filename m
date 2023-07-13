Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3D7527D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjGMP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjGMP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:57:58 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3965D19BE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:57:57 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689263874; x=1689523074;
        bh=vwCAgBsZZAf07UrdEz9QUmDLy3L2iHx6cWDHOTWjKs4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=JBwNUpLapWP1mw0frnXIABg59OKWc4yq0vKvOtUwGoc0Ch9Rtnq0166DXsBRkHgDT
         9WvUOVV0EYySPV1XRapLTElK7YJX5MWkcpuGD0VZFvoIcVKHWRqgEayVP/N6zMktDt
         wChJ3QDL2GELEfR+CIAtzylrAtcSgR0Hnd8MuugUEBFNFbnUYgivinORGxy5ektZbU
         dr5qnfAaH3iRIc93o/IHYtZrpX/vMVhCblnibAkI4hRFE9e+wbKDJhtm3nycUwOlQA
         XRDIlIkkZzv9duqoNq3RyzUGK8m79gXjefMj5Aqi9qInzQfy8FUUX7PAGJgQFz1gVg
         9imeT+7jylhEQ==
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Message-ID: <iR-OgwSOdjaDu3xi2tiwcpNPEvvY8LEz5xjFHDdMEkHljZcdhnKWPIcPNBdT7hIMcIzZsWd6EoWHiREOd7lnWWaK-sUX4mT8l4M6GhkxgRU=@protonmail.com>
In-Reply-To: <0b506574-6ce7-3aa9-f582-bf05ddc97699@redhat.com>
References: <20230630041743.911303-1-luke@ljones.dev> <20230630041743.911303-2-luke@ljones.dev> <974093b4-5dac-dc29-8f86-304eb5c6c19b@redhat.com> <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev> <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com> <MFcnkX194DPlx9DJUNWx43ia7ew825I6K1k8hOoUYImBv390MzOdWngMLTzr5g4iv_9o9x8qE2FqoVcKUcN6s6lHdbIzfj3eDXQLgtU3w9o=@protonmail.com> <0b506574-6ce7-3aa9-f582-bf05ddc97699@redhat.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. j=C3=BAlius 12., szerda 20:44 keltez=C3=A9ssel, Hans de Goede <hdegoe=
de@redhat.com> =C3=ADrta:

> Hi,
>=20
> On 7/12/23 03:07, Barnab=C3=A1s P=C5=91cze wrote:
> > Hi
> >
> >
> > 2023. j=C3=BAlius 11., kedd 11:42 keltez=C3=A9ssel, Hans de Goede <hdeg=
oede@redhat.com> =C3=ADrta:
> >
> >> [...]
> >>>>
> >>>> If settings below 60 are no good, then the correct way to handle
> >>>> this is to limit the range to 0 - (255-60) and add / substract
> >>>> 60 when setting / getting the brightness.
> >>>>
> >>>> E.g. do something like this:
> >>>>
> >>>> #define SCREENPAD_MIN_BRIGHTNESS        60
> >>>> #define SCREENPAD_MAX_BRIGHTNESS        255
> >>>>
> >>>>         props.max_brightness =3D SCREENPAD_MAX_BRIGHTNESS -
> >>>> SCREENPAD_MIN_BRIGHTNESS;
> >>>>
> >>>> And in update_screenpad_bl_status() do:
> >>>>
> >>>>         ctrl_param =3D bd->props.brightness + SCREENPAD_MIN_BRIGHTNE=
SS;
> >>>>
> >>>> And when reading the brightness substract SCREENPAD_MIN_BRIGHTNESS,
> >>>> clamping to a minimum value of 0.
> >>>>
> >>>> This avoids a dead-zone in the brightness range between 0-60 .
> >>>
> >>> Hi Hans, I think this is the wrong thing to do.
> >>>
> >>> The initial point of that first `brightness =3D 60;` is only to set i=
t to
> >>> an acceptable brightness on boot. We don't want to prevent the user
> >>> from going below that brightness at all - this is just to ensure the
> >>> screen is visible on boot if the brightness was under that value, and
> >>> it is usually only under that value if it was set to off before
> >>> shutdown/reboot.
> >>>
> >>> It's not to try and put the range between 60-255, it's just to make t=
he
> >>> screen visible on boot if it was off previously. The folks who have
> >>> tested this have found that this is the desired behaviour they expect=
.
> >>
> >> I see.
> >>
> >> So if I understand things correctly then 60 is a good default,
> >> but the screen can go darker and still be usable.
> >>
> >> But 1 leads to an unusable screen, so we still need
> >> a SCREENPAD_MIN_BRIGHTNESS to avoid the screen being able
> >> to go so dark that it is no longer usable and then still
> >> move the range a bit, but just not by 60, but by some
> >> other number (something in the 10-30 range I guess?)
> >>
> >> Combined with adding a:
> >>
> >> #define SCREENPAD_DEFAULT_BRIGHTNESS        60
> >>
> >> And at boot when the read back brightness <
> >> SCREENPAD_MIN_BRIGHTNESS set it to SCREENPAD_DEFAULT_BRIGHTNESS.
> >>
> >> We really want to avoid users to be able to set an unusable
> >> low brightness level. As mentioned in the new panel brightness
> >> API proposal:
> >>
> >> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e=
@redhat.com/
> >>
> >> "3. The meaning of 0 is not clearly defined, it can be either off,
> >>    or minimum brightness at which the display is still readable
> >>   (in a low light environment)"
> >>
> >> and the plan going forward is to:
> >>
> >> "Unlike the /sys/class/backlight/foo/brightness this brightness proper=
ty
> >> has a clear definition for the value 0. The kernel must ensure that 0
> >> means minimum brightness (so 0 should _never_ turn the backlight off).
> >> If necessary the kernel must enforce a minimum value by adding
> >> an offset to the value seen in the property to ensure this behavior."
> >>
> >> So I really want to see this new backlight driver implement the
> >> new planned behavior for 0 from the start, with 0 meaning minimum
> >> *usable* brightness.
> >>
> >> Regards,
> >>
> >> Hans
> >
> >
> > Sorry for hijacking this thread, but then how can I turn backlight off?
>=20
> Documentation/ABI/stable/sysfs-class-backlight
>=20
> What:           /sys/class/backlight/<backlight>/bl_power
> Date:           April 2005
> KernelVersion:  2.6.12
> Contact:        Richard Purdie <rpurdie@rpsys.net>
> Description:
>                 Control BACKLIGHT power, values are FB_BLANK_* from fb.h
>=20
>                  - FB_BLANK_UNBLANK (0)   : power on.
>                  - FB_BLANK_POWERDOWN (4) : power off
>=20
> Although it is better to actually disable video output on the connector,
> this leads to much bigger power savings. Under X, this can typically be
> done by hitting the lock-screen option, e.g. "Windows-logo-key + L" under
> GNOME.

Super+L locks the screen for me on GNOME, which is decidedly *not* what I w=
ant
to achieve. I just want to disable the backlight on the laptop panel withou=
t
any other changes whatsoever. Writing 4 to /sys/class/backlight/<backlight>=
/bl_power
does essentially what I want.


>=20
> On the console you can do:
>=20
> echo 1 > /sys/class/graphics/fb0/blank
>=20
> To really put the panel in low power mode.

I never doubted it could still be done. I guess what I wanted to say is "co=
nvenience".
Using the brightness slider / hotkeys is very convenient, much more conveni=
ent than
messing with getting the right permissions to be able to write to
/sys/class/backlight/<backlight>/bl_power or /sys/class/graphics/fb0/blank.


>=20
>=20
>=20
> > I quite liked how I was able to turn my laptop display (almost) complet=
ely off
> > with the brightness hotkeys / brightness slider in gnome-shell, and I w=
as quite
> > annoyed when this was changed in gnome-settings-daemon and forced the m=
inimum
> > brightness to be 1% of max_brightness.
>=20
> Right, there are 2 problems with this:
>=20
> 1. Using brightness control to disable the backlight is not reliabl. Many
> backlight control methods only go to some low setting not to completely o=
ff.
> This differs from model laptop to model laptop. Also e.g. amdgpu and rade=
onhd
> have always ensured that brightness never completely turns of the backlig=
ht.
>=20
> The plan going forward is to try and consistently have 0 mean minimum
> backlight and not backlight off, instead of the current some models 0 =3D=
 off,
> some models 0 is works fine in a not too brightly lit room.

That is good to know, I did not realize that was the case thanks to my inte=
l_backlight
bias...


>=20
> 2. Users sometimes turn of the backlight through e.g. the GNOME system me=
nu
> slider and then have no way to turn it back on (on devices without (worki=
ng)
> brightness hotkeys (they cannot use the slider since they can no longer s=
ee it)
> This scenario is a real problem which used to result in quite a few bug r=
eports.

Of course I understand why that change was made in e.g. gnome-settings-daem=
on.
However, the same way gnome-tweaks has a switch for enabling volume levels =
greater
than 100%, there could be a switch for enabling the full brightness scale.


>=20
> > Also, "minimum brightness at which the display is still readable" is no=
t really
> > well-defined
>=20
> True, as mentioned above the minimum might only be good enough to
> e.g. read text in a somewhat low lit room, but typically it at
> least leaves things visible enough to allow a user to change
> the brightness to a better setting.
>=20
> What we don't want is brightness settings so low that the backlight is
> essentially off (does not even show any light in a fully dark room).
>=20
> > so it can (will) happen that the minimum brightness values don't match,
> > so it is theoretically possible that I cannot set both my laptop panel =
and external
> > monitor to the same desired brightness level. Or am I missing something=
?
>=20
> This already is the case, some monitors may not go as low (or high) as yo=
u want,
> some laptops also already don't go as low as you want.

Fair point, but restricting the range decreases the chances even more.


>=20
> Expecting to be able to match monitor and laptop panel brightness at both
> ends of the brightness range simply is not realistic.
> [...]


In conclusion, I appreciate your answer, there were some things I did not k=
now.
I suppose, after all, it might indeed not be a wise idea to shoehorn turnin=
g off
backlight into brightness control.


Regards,
Barnab=C3=A1s P=C5=91cze
