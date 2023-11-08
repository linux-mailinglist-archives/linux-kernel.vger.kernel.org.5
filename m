Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8A7E606D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjKHW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjKHW2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:28:53 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94CE1FE4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699482526; x=1699741726;
        bh=U7ZfHbuy2XuB6AdK5CHfodNg1KEIGRsOqXNAnIelIbM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VkPubs2j+p8cFX/syxNZz1wRgLLDTrgGjGnPHLMWE5qBQVv3rHoKvNb2YQlMZsRXq
         jizWA9wioJDsxgQ4F5cg0NC7Rqciu1RkUyr40xkDG6tmOs/kcr4qjljSlkhcX7pEXv
         SQbdakyVrfQ2S40pugBKjmqBDdzC0dFxJBr2bsqKgv1F1TWn+vrNXdlDQtGUPHoCq6
         VCsGNCJ8SuTxKm3Cu5I0ykccGZRHWCMrvpHDxKvPmYYsbWbYdCk3czt6m1QkzsLlSE
         Bxg9DbMuhpmR9W+0Tivl2axT2oRh026/ImWxlRhOFk0sfx7K6kIoh/lsn9VC/aI9uJ
         jbSXy9zrvsPyw==
Date:   Wed, 08 Nov 2023 22:28:34 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <YgtRvJkeHI3493pGQnmMOLAPdgI9i00TeGk9R6bWe2TZ6IIIeEuqFIbC9faeazMYo-6l1c4wGz2lne5QTs12l2QtoIYW3t3R8GC-hp5lKYk=@protonmail.com>
In-Reply-To: <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com> <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for all the information.

> Could you please use sudo hid-recorder from hid-tools[1] on any kernel
> version and send us the logs here?
> I'll be able to replay the events locally, and understand why the
> kernel doesn't work properly.
> [1] https://gitlab.freedesktop.org/libevdev/hid-tools

Yes, I can. I've done it for the two tablets and you can find the file outp=
ut hosted here:
https://www.peppercarrot.com/extras/?dir=3Dmailing-list/hid-records

I followed the diagnostic method (for gestures) and file naming suggested i=
n the short videos on this page:
https://digimend.github.io/support/howto/trbl/diagnostics/

I hope that it will be useful, even after the detailed feedback from Eric G=
ouyer (folays@gmail.com) on the ML (thank you).

> Generally speaking, relying on X to fix your hardware is going to be a
> dead end. When you switch to wayland, you'll lose all of your fixes,
> which isn't great.

You are right. I hope that the Wayland session will offer possible command =
line tools to customise devices. But that's another topic. :)


On Monday, November 6th, 2023 at 17:59, Benjamin Tissoires <benjamin.tissoi=
res@redhat.com> wrote:


> Hi David,
>=20
> On Mon, Nov 6, 2023 at 2:18=E2=80=AFPM David Revoy davidrevoy@protonmail.=
com wrote:
>=20
> > Hi Illia, Jiri, Bagas,
> >=20
> > Thanks to Jiri for forwarding my request for help to this mailing list.
> >=20
> > I apologise in advance to Bagas and you all for not being able to prope=
rly configure my email client to follow the correct etiquette (Protonmail, =
unsuitable for kernel development, but we've made some progress with them o=
n Mastodon on the encryption issue 1).
>=20
>=20
> Hopefully you'll be able to figure out a way to have your emails
> posted to the lkml soon. It's very valuable to have them in
> lore.kernel.org to get the thread context.
>=20
> > Thanks to Illia for the detailed explanation. Thanks also for fixing it=
, and for explaining how the fix broke my workflow, and for your kind words=
 about the situation. I appreciate it.
> >=20
> > However, after reading your reply, I still have my doubts about the pre=
ference to put an eraser on the top button of the pen by default. But after=
 a few days and re-reading your first sentence "The XP-Pen hardware reports=
 the Eraser usage for the upper stylus button.", I think I understood it: t=
his is an internal signal that is sent by the device itself, and is therefo=
re a specification that has to be followed, right? In this case, it makes s=
ense for a generic driver to follow such a signal if it is sent by the hard=
ware.
>=20
>=20
> Yes, you are correct. The device talks a given protocol (HID) and is
> supposed to use the specification from Microsoft[0] on how to behave
> properly. As such, it has to convey the "eraser" state by adding
> dedicated information in the event stream.
>=20
> In your case, I think we (the kernel and your stylus) simply talk past
> each other and we lose information.
>=20
> > Having said that, behaving like this still makes no sense in one case: =
I'm thinking of my other display tablet, the XPPEN 16 Artist Pro (Gen2). In=
 this case, the stylus has the top button as an eraser, and an eraser tip a=
s well, as you can see in this photo 2. Was it also a decision by XPPEN to =
include this signal in the hardware, knowing that they already had an erase=
r tip? In this case, please let me know, as it sounds like a hardware probl=
em at the design stage and I have probably a way of passing on the informat=
ion to their technical team.
>=20
>=20
> If the pen has 2 buttons, and an eraser side, it would be a serious
> design flow for XPPEN to report both as eraser.
>=20
> Could you please use sudo hid-recorder from hid-tools1 on any kernel
> version and send us the logs here?
> I'll be able to replay the events locally, and understand why the
> kernel doesn't work properly.
>=20
> And if there is a design flaw that can be fixed, we might even be able
> to use hid-bpf to change it :)
>=20
> > > You can still remap the eraser button to a right click using xsetwaco=
m:
> > > xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
> >=20
> > Unfortunately, it doesn't work.
> >=20
> > Firstly, such tablets are often connected to a computer that already ha=
s a display. So each device (pen/eraser) needs to be mapped to the correct =
display and set to the correct 'Area' for calibration. A better syntax in m=
y case to test your workaround is written like this:
> >=20
> > tableteraser=3D"UGTABLET 24 inch PenDisplay eraser"
> > xsetwacom set "$tableteraser" MapToOutput "DisplayPort-2"
> > xsetwacom set "$tableteraser" Area 100 120 32794 32797
> > xsetwacom set "$tableteraser" "Button" "1" "3"
> >=20
> > Secondly, forwarding the eraser button 1 to button 3 (a right click) in=
 xsetwacom doesn't work.
> >=20
> > Pressing the button switches the device to an eraser and no right click=
 happens. You'll need to hold down the button and click with the tip of the=
 pen to create a right-click event.
> >=20
> > In a digital painting session in Krita, the software will switch your d=
evice to an eraser tool preset while you hold down the button, and the feed=
back on the canvas will be the eraser cursor. You'll then have to click "wi=
th the eraser" to get the right-click that triggers the pop-up palette 3.
> >=20
> > I'd also like to mention that if you haven't correctly mapped and calib=
rated your eraser device with xsetwacom, as I did in the code snippet above=
, the cursor will by default jump to a different location when you hold dow=
n the eraser button. It can be on a different display.
> >=20
> > Finally, in the case of the XPPEN 16 Artist Pro (Gen2) with a real eras=
er device (Photo, 2), the setting 'xsetwacom set "$tableteraser" "Button" "=
1" "3"' will affect both erasers. Flipping the stylus on the eraser side an=
d entering in 'hover' mode will return a correct eraser, but as soon as you=
 start erasing with the tip, a right click will also be entered.
> >=20
> > > You can also do this with "xinput set-button-map", which works for li=
binput as well.
> >=20
> > $ xinput list
> > =E2=8E=A1 Virtual core pointer
> > =E2=8E=9C =E2=86=B3 UGTABLET 24 inch PenDisplay Mouse id=3D8 [slave poi=
nter (2)]
> > =E2=8E=9C =E2=86=B3 UGTABLET 24 inch PenDisplay stylus id=3D10 [slave p=
ointer (2)]
> > =E2=8E=9C =E2=86=B3 UGTABLET 24 inch PenDisplay eraser id=3D17 [slave p=
ointer (2)]
> > [...]
> > $ xinput get-button-map 17
> > 1 2 3 4 5 6 7 8
> > $ xinput set-button-map 17 3 3 3 3 3 3 3 3
> > $ xinput get-button-map 17
> > 3 3 3 3 3 3 3 3
> >=20
> > Even after that, it doesn't work. My original article 4 mentions in the=
 last paragraph that I have tested almost all methods, and this was one of =
them. Even a udev rule doesn't fix it. For reference, xinput produces the s=
ame behaviour as xsetwacom: you have to hold the button (it triggers an era=
ser device switch) then click with the tip to get a right-click...
>=20
>=20
> Generally speaking, relying on X to fix your hardware is going to be a
> dead end. When you switch to wayland, you'll lose all of your fixes,
> which isn't great.
>=20
> > > We have tested this with several XP-Pen devices, including Artist 24.
> >=20
> > Sorry if my tests show something different. Maybe there is something wr=
ong with my GNU/Linux operating system (Fedora 38 KDE spin). Let me know if=
 you have any idea why I get these results and guide me with what distro I =
should switch to get a similar observation than you do (and also to report =
the issue to the Fedora team).
> >=20
> > ---
> >=20
> > All in all (and in the case that my observations and tests are correct)=
, I still stand by the points that I made in my blog post:
> >=20
> > - I don't have any way to customise the hardcoded eraser buttons in use=
rspace and it is a problem: for devices without a touchscreen or mouse, not=
 having access to a right-click by default on the device is a handicap. Man=
y actions on the D.E. and applications use the right click. The preference =
to replace it with an 'eraser switch' action by default is IMHO highly deba=
table here.
>=20
>=20
> AFAIU, the kernel now "merges" both buttons, which is a problem. It
> seems to be a serious regression. This case is also worrying because I
> added regression tests on hid, but I don't have access to all of the
> various tablets, so I implemented them from the Microsoft
> specification[0]. We need a special case for you here.
>=20
> > - In the case of a pen that already has an eraser tip on the other side=
 of the device 2, it makes no sense to exchange the right-click top button =
for another way to erase. Also in userspace, there seems to be no way to di=
stinguish between the two buttons (the eraser tip and the eraser button). A=
ll actions from xsetwacom, xinput/libinput target the two eraser devices, a=
nd they target them unsuccessfully too.
>=20
>=20
> Again, we can't do more than what the device reports. Well, we can
> always quirk it in some cases, but ideally we don't have to do
> anything. MS spec [0], only shows a single button pen with an eraser
> tail or a pen with 2 buttons, one of them being the eraser one. I'm
> not sure if they decided to prevent dual button pens with eraser tail,
> but Wacom definitely has some, and they work.
>=20
> Without the actual data from your pen, I can not tell much, because I
> don't follow which path we are taking on the kernel side. Please
> report with your hid-recorder logs, so I can understand why this is
> happening and how we can fix it.
>=20
> > ------- Original Message -------
> > On Friday, November 3rd, 2023 at 21:05, Illia Ostapyshyn ostapyshyn@sra=
.uni-hannover.de wrote:
> >=20
> > > Hello David, Hello Jiri,
> > >=20
> > > The XP-Pen hardware reports the Eraser usage for the upper stylus but=
ton.
> > > Generally, styli report Invert usages when erasing, as described in 1=
.
> > > XP-Pen digitizers, however, tend to omit them.
> > >=20
> > > The generic driver maps the Eraser usage to BTN_TOUCH and the Invert
> > > usage to BTN_TOOL_RUBBER. Pens conforming to 1 send the Invert usage
> > > first (switching the tool to BTN_TOOL_RUBBER) followed by Eraser, whi=
ch
> > > appears in userspace as a BTN_TOUCH event with the rubber tool set.
> > >=20
> > > Due to an oversight, devices not reporting Invert had the BTN_TOOL_RU=
BBER
> > > event masked. This has caused the kernel to send only BTN_TOUCH event=
s
> > > without the tool switch when erasing.
> > >=20
> > > The situation got worse with refactoring done in 87562fcd1342. An era=
ser
> > > without Invert caused the hidinput_hid_event state machine to get stu=
ck
> > > with BTN_TOOL_RUBBER internally (due to it being masked). For the
> > > userspace, this looked as if the pen was never hovering again, render=
ing
> > > it unusable until the next reset. 276e14e6c3 fixes this by adding
> > > support for digitizers that do not report Invert usages when erasing.
>=20
>=20
> AFAICT 276e14e6c3 already had the hid tests integrated at
> tools/testing/selftests/hid/tests/test_tablet.py
>=20
> It would have been great to add the cases you are mentioning here,
> because there is a strong chance I'll break things once again when we
> try to fix that regression.
>=20
> > > ---
> > >=20
> > > David, we are sorry that our patch broke your workflow. However,
> > > forwarding hardware events as-is to the userspace has always been the
> > > intended behavior, with a kernel bug preventing it so far. You can st=
ill
> > > remap the eraser button to a right click using xsetwacom:
> > >=20
> > > xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
> > >=20
> > > Replace the device name with the corresponding eraser device from
> > > "xsetwacom list devices". You can also do this with "xinput set-butto=
n-map",
> > > which works for libinput as well. We have tested this with several
> > > XP-Pen devices, including Artist 24.
> > >=20
> > > 1 https://learn.microsoft.com/en-us/windows-hardware/design/component=
-guidelines/windows-pen-states
>=20
>=20
> Cheers,
> Benjamin
>=20
> [0] https://learn.microsoft.com/en-us/windows-hardware/design/component-g=
uidelines/windows-pen-states
> 1 https://gitlab.freedesktop.org/libevdev/hid-tools
