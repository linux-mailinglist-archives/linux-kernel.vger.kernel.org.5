Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6620A7E241C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjKFNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjKFNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:18:16 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69A94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699276688; x=1699535888;
        bh=Qce+NXcR0WEFtdebmxK3+wRRvCHgzx7u8rrkCxFYjdQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wuoc3Z2uCFapBLdbquIuTiN8Z7rfSic93z5LqzbE+mRm9sndSXn5EyCiWHUJ+sB0u
         jmTbcZyrvYHbbqWvuu1YbHYVM8NwMXqI2Xm1XXYodF6uInoX1x6oFSxzGMImrKNCeJ
         LwfegvQ8GBMS9jSezQvyX8ge3yElXNq947m5deT1r7FwcM3bnFhliI9Odxcp+N8ciT
         m7ovh0CTnyE3NzkG9duKbIqwWuFaydPryuM5ZyjhWNJHVTpOv6rFNLSjlOINl/ZlEP
         mMi/Bk1T6ArSLhv6eICtcriWQtB14pYdJacJiZxA15yAA7fIYf/1jAoFxH8Ys48wiX
         aIEFtakTmbFyg==
Date:   Mon, 06 Nov 2023 13:17:55 +0000
To:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
In-Reply-To: <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Illia, Jiri, Bagas,=20

Thanks to Jiri for forwarding my request for help to this mailing list.

I apologise in advance to Bagas and you all for not being able to properly =
configure my email client to follow the correct etiquette (Protonmail, unsu=
itable for kernel development, but we've made some progress with them on Ma=
stodon on the encryption issue [1]).

Thanks to Illia for the detailed explanation. Thanks also for fixing it, an=
d for explaining how the fix broke my workflow, and for your kind words abo=
ut the situation. I appreciate it.

However, after reading your reply, I still have my doubts about the prefere=
nce to put an eraser on the top button of the pen by default. But after a f=
ew days and re-reading your first sentence "The XP-Pen hardware reports the=
 Eraser usage for the upper stylus button.", I *think* I understood it: thi=
s is an internal signal that is sent by the device itself, and is therefore=
 a specification that has to be followed, right? In this case, it makes sen=
se for a generic driver to follow such a signal if it is sent by the hardwa=
re.

Having said that, behaving like this still makes no sense in one case: I'm =
thinking of my other display tablet, the XPPEN 16 Artist Pro (Gen2). In thi=
s case, the stylus has the top button as an eraser, and an eraser tip as we=
ll, as you can see in this photo [2]. Was it also a decision by XPPEN to in=
clude this signal in the hardware, knowing that they already had an eraser =
tip? In this case, please let me know, as it sounds like a hardware problem=
 at the design stage and I have probably a way of passing on the informatio=
n to their technical team.

> You can still remap the eraser button to a right click using xsetwacom:
> xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"

Unfortunately, it doesn't work.=20

Firstly, such tablets are often connected to a computer that already has a =
display. So each device (pen/eraser) needs to be mapped to the correct disp=
lay and set to the correct 'Area' for calibration. A better syntax in my ca=
se to test your workaround is written like this:

tableteraser=3D"UGTABLET 24 inch PenDisplay eraser"
xsetwacom set "$tableteraser" MapToOutput "DisplayPort-2"
xsetwacom set "$tableteraser" Area 100 120 32794 32797
xsetwacom set "$tableteraser" "Button" "1" "3"

Secondly, forwarding the eraser button 1 to button 3 (a right click) in xse=
twacom doesn't work.=20

Pressing the button switches the device to an eraser and no right click hap=
pens. You'll need to hold down the button and click with the tip of the pen=
 to create a right-click event.=20

In a digital painting session in Krita, the software will switch your devic=
e to an eraser tool preset while you hold down the button, and the feedback=
 on the canvas will be the eraser cursor. You'll then have to click "with t=
he eraser" to get the right-click that triggers the pop-up palette [3].

I'd also like to mention that if you haven't correctly mapped and calibrate=
d your eraser device with xsetwacom, as I did in the code snippet above, th=
e cursor will by default jump to a different location when you hold down th=
e eraser button. It can be on a different display.

Finally, in the case of the XPPEN 16 Artist Pro (Gen2) with a real eraser d=
evice (Photo, [2]), the setting 'xsetwacom set "$tableteraser" "Button" "1"=
 "3"' will affect both erasers. Flipping the stylus on the eraser side and =
entering in 'hover' mode will return a correct eraser, but as soon as you s=
tart erasing with the tip, a right click will also be entered.

> You can also do this with "xinput set-button-map", which works for libinp=
ut as well.

$ xinput list
=E2=8E=A1 Virtual core pointer   =20
=E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay Mouse         id=3D8    [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay stylus        id=3D10   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay eraser        id=3D17   [=
slave  pointer  (2)]
[...]
$ xinput get-button-map 17
1 2 3 4 5 6 7 8
$ xinput set-button-map 17 3 3 3 3 3 3 3 3
$ xinput get-button-map 17
3 3 3 3 3 3 3 3

Even after that, it doesn't work. My original article [4] mentions in the l=
ast paragraph that I have tested almost all methods, and this was one of th=
em. Even a udev rule doesn't fix it. For reference, xinput produces the sam=
e behaviour as xsetwacom: you have to hold the button (it triggers an erase=
r device switch) then click with the tip to get a right-click...

> We have tested this with several XP-Pen devices, including Artist 24.

Sorry if my tests show something different. Maybe there is something wrong =
with my GNU/Linux operating system (Fedora 38 KDE spin). Let me know if you=
 have any idea why I get these results and guide me with what distro I shou=
ld switch to get a similar obsevation than you do (and also to report the i=
ssue to the Fedora team).

---

All in all (and in the case that my observations and tests are correct), I =
still stand by the points that I made in my blog post:

- I don't have any way to customise the hardcoded eraser buttons in userspa=
ce and **it is a problem**: for devices without a touchscreen or mouse, not=
 having access to a right-click by default on the device is a handicap. Man=
y actions on the D.E. and applications use the right click. The preference =
to replace it with an 'eraser switch' action by default is IMHO highly deba=
table here.
- In the case of a pen that already has an eraser tip on the other side of =
the device [2], it makes no sense to exchange the right-click top button fo=
r another way to erase. Also in userspace, there seems to be no way to dist=
inguish between the two buttons (the eraser tip and the eraser button). All=
 actions from xsetwacom, xinput/libinput target the two eraser devices, and=
 they target them unsuccessfully too.

[1]: https://mastodon.social/@protonmail/111346195283677411
[2]: https://www.davidrevoy.com/data/images/blog/2023/2023-11-01_linux-kern=
el-broke-my-stylus_xp-pen-artist-pro-16-gen2_net.jpg
[3]: https://docs.krita.org/en/reference_manual/popup-palette.html
[4]: https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-sty=
lus-need-help


------- Original Message -------
On Friday, November 3rd, 2023 at 21:05, Illia Ostapyshyn <ostapyshyn@sra.un=
i-hannover.de> wrote:


> Hello David, Hello Jiri,
>=20
> The XP-Pen hardware reports the Eraser usage for the upper stylus button.
> Generally, styli report Invert usages when erasing, as described in [1].
> XP-Pen digitizers, however, tend to omit them.
>=20
> The generic driver maps the Eraser usage to BTN_TOUCH and the Invert
> usage to BTN_TOOL_RUBBER. Pens conforming to [1] send the Invert usage
> first (switching the tool to BTN_TOOL_RUBBER) followed by Eraser, which
> appears in userspace as a BTN_TOUCH event with the rubber tool set.
>=20
> Due to an oversight, devices not reporting Invert had the BTN_TOOL_RUBBER
> event masked. This has caused the kernel to send only BTN_TOUCH events
> without the tool switch when erasing.
>=20
> The situation got worse with refactoring done in 87562fcd1342. An eraser
> without Invert caused the hidinput_hid_event state machine to get stuck
> with BTN_TOOL_RUBBER internally (due to it being masked). For the
> userspace, this looked as if the pen was never hovering again, rendering
> it unusable until the next reset. 276e14e6c3 fixes this by adding
> support for digitizers that do not report Invert usages when erasing.
>=20
> ---
>=20
> David, we are sorry that our patch broke your workflow. However,
> forwarding hardware events as-is to the userspace has always been the
> intended behavior, with a kernel bug preventing it so far. You can still
> remap the eraser button to a right click using xsetwacom:
>=20
> xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
>=20
> Replace the device name with the corresponding eraser device from
> "xsetwacom list devices". You can also do this with "xinput set-button-ma=
p",
> which works for libinput as well. We have tested this with several
> XP-Pen devices, including Artist 24.
>=20
> [1] https://learn.microsoft.com/en-us/windows-hardware/design/component-g=
uidelines/windows-pen-states
