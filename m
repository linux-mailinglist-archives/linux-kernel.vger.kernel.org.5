Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA67E2A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjKFRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjKFRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1774D67
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699289989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnEe3obE9Slno+EoWn5RaqEd5AWSblLM5ZXIy5ySlG0=;
        b=KIBxhzETffWO/BmcfC67b8Zf5PpRYChVJIeBC+y3BFOrP8jzBhmqPqwro3OKlRzBVE+oN9
        sb5O5kcQIsxbViJp+IG1SZe5Mu+0p9jutmExF5Efomk8Ii2HnVHE2b4Fs0bGm40JQ+gJlb
        9TzbCcisZcbgcbzFMPBoq3jBpzkRFwM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-57sF7kOjOMyMfXggk-kmaw-1; Mon, 06 Nov 2023 11:59:47 -0500
X-MC-Unique: 57sF7kOjOMyMfXggk-kmaw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso335299666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289986; x=1699894786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnEe3obE9Slno+EoWn5RaqEd5AWSblLM5ZXIy5ySlG0=;
        b=A5mxNiqQj3ziZ8UcFjEaeHMp2O5/tDJnQRHVniR80MN9zw7Lbcet/TKIQvlSVennIN
         d7kEAY1FJc4a78EQ+TaU/s7w/mw02obUsp2lEBPO9LBtLJ5JfZeTalFljEUayqAcI4ZE
         tVnZrAvLO90+F6hUbz+Lw+cPKcHq/jgttnNbM7azP6MMYFZiod6AWTLkUx86ePY9ClPw
         mDiE1Uu9oWD7eDywL4wFY4yTHPKA48Aeuq+erx0gKJb3pPSgedWiEz0eGmN9nrnAREJ0
         8w+av6PeZ61a/5tZGZhizJIxYp0QSrLDanWurHJBp7AZwYH+/NDDEOC5M7aJBYhAad93
         k7gQ==
X-Gm-Message-State: AOJu0YzuZR6cs6lE/ZF7G3RM3j1wgIRPBE10/1+1u6H6GszQI9HV8qYK
        zqTDhDf0f+dAp7Bo4CA8jWLzNMUHUou60yrmAe0K82Guqb9SlGJdcyMncIX4s4sekvOAgp6ea3e
        MsRtUrFTqQq3yUA1bG4jZoRdxhrS/twgkqT1g4AM9
X-Received: by 2002:a17:907:3f0d:b0:9ae:6a8b:f8aa with SMTP id hq13-20020a1709073f0d00b009ae6a8bf8aamr16598431ejc.26.1699289986203;
        Mon, 06 Nov 2023 08:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+GcWgc5JZgj2v/3nu12tgR3ByrR/XQLRRHiL2fdkmZXxUk5EgZ0kDmpFbmj2FKkTzlU7kdnIasw9A1lKBZv4=
X-Received: by 2002:a17:907:3f0d:b0:9ae:6a8b:f8aa with SMTP id
 hq13-20020a1709073f0d00b009ae6a8bf8aamr16598401ejc.26.1699289985765; Mon, 06
 Nov 2023 08:59:45 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
In-Reply-To: <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 6 Nov 2023 17:59:33 +0100
Message-ID: <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Nov 6, 2023 at 2:18=E2=80=AFPM David Revoy <davidrevoy@protonmail.c=
om> wrote:
>
> Hi Illia, Jiri, Bagas,
>
> Thanks to Jiri for forwarding my request for help to this mailing list.
>
> I apologise in advance to Bagas and you all for not being able to properl=
y configure my email client to follow the correct etiquette (Protonmail, un=
suitable for kernel development, but we've made some progress with them on =
Mastodon on the encryption issue [1]).

Hopefully you'll be able to figure out a way to have your emails
posted to the lkml soon. It's very valuable to have them in
lore.kernel.org to get the thread context.

>
> Thanks to Illia for the detailed explanation. Thanks also for fixing it, =
and for explaining how the fix broke my workflow, and for your kind words a=
bout the situation. I appreciate it.
>
> However, after reading your reply, I still have my doubts about the prefe=
rence to put an eraser on the top button of the pen by default. But after a=
 few days and re-reading your first sentence "The XP-Pen hardware reports t=
he Eraser usage for the upper stylus button.", I *think* I understood it: t=
his is an internal signal that is sent by the device itself, and is therefo=
re a specification that has to be followed, right? In this case, it makes s=
ense for a generic driver to follow such a signal if it is sent by the hard=
ware.

Yes, you are correct. The device talks a given protocol (HID) and is
supposed to use the specification from Microsoft[0] on how to behave
properly. As such, it has to convey the "eraser" state by adding
dedicated information in the event stream.

In your case, I think we (the kernel and your stylus) simply talk past
each other and we lose information.

>
> Having said that, behaving like this still makes no sense in one case: I'=
m thinking of my other display tablet, the XPPEN 16 Artist Pro (Gen2). In t=
his case, the stylus has the top button as an eraser, and an eraser tip as =
well, as you can see in this photo [2]. Was it also a decision by XPPEN to =
include this signal in the hardware, knowing that they already had an erase=
r tip? In this case, please let me know, as it sounds like a hardware probl=
em at the design stage and I have probably a way of passing on the informat=
ion to their technical team.

If the pen has 2 buttons, and an eraser side, it would be a serious
design flow for XPPEN to report both as eraser.

Could you please use sudo hid-recorder from hid-tools[1] on any kernel
version and send us the logs here?
I'll be able to replay the events locally, and understand why the
kernel doesn't work properly.

And if there is a design flaw that can be fixed, we might even be able
to use hid-bpf to change it :)

>
> > You can still remap the eraser button to a right click using xsetwacom:
> > xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
>
> Unfortunately, it doesn't work.
>
> Firstly, such tablets are often connected to a computer that already has =
a display. So each device (pen/eraser) needs to be mapped to the correct di=
splay and set to the correct 'Area' for calibration. A better syntax in my =
case to test your workaround is written like this:
>
> tableteraser=3D"UGTABLET 24 inch PenDisplay eraser"
> xsetwacom set "$tableteraser" MapToOutput "DisplayPort-2"
> xsetwacom set "$tableteraser" Area 100 120 32794 32797
> xsetwacom set "$tableteraser" "Button" "1" "3"
>
> Secondly, forwarding the eraser button 1 to button 3 (a right click) in x=
setwacom doesn't work.
>
> Pressing the button switches the device to an eraser and no right click h=
appens. You'll need to hold down the button and click with the tip of the p=
en to create a right-click event.
>
> In a digital painting session in Krita, the software will switch your dev=
ice to an eraser tool preset while you hold down the button, and the feedba=
ck on the canvas will be the eraser cursor. You'll then have to click "with=
 the eraser" to get the right-click that triggers the pop-up palette [3].
>
> I'd also like to mention that if you haven't correctly mapped and calibra=
ted your eraser device with xsetwacom, as I did in the code snippet above, =
the cursor will by default jump to a different location when you hold down =
the eraser button. It can be on a different display.
>
> Finally, in the case of the XPPEN 16 Artist Pro (Gen2) with a real eraser=
 device (Photo, [2]), the setting 'xsetwacom set "$tableteraser" "Button" "=
1" "3"' will affect both erasers. Flipping the stylus on the eraser side an=
d entering in 'hover' mode will return a correct eraser, but as soon as you=
 start erasing with the tip, a right click will also be entered.
>
> > You can also do this with "xinput set-button-map", which works for libi=
nput as well.
>
> $ xinput list
> =E2=8E=A1 Virtual core pointer
> =E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay Mouse         id=3D8   =
 [slave  pointer  (2)]
> =E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay stylus        id=3D10  =
 [slave  pointer  (2)]
> =E2=8E=9C   =E2=86=B3 UGTABLET 24 inch PenDisplay eraser        id=3D17  =
 [slave  pointer  (2)]
> [...]
> $ xinput get-button-map 17
> 1 2 3 4 5 6 7 8
> $ xinput set-button-map 17 3 3 3 3 3 3 3 3
> $ xinput get-button-map 17
> 3 3 3 3 3 3 3 3
>
> Even after that, it doesn't work. My original article [4] mentions in the=
 last paragraph that I have tested almost all methods, and this was one of =
them. Even a udev rule doesn't fix it. For reference, xinput produces the s=
ame behaviour as xsetwacom: you have to hold the button (it triggers an era=
ser device switch) then click with the tip to get a right-click...

Generally speaking, relying on X to fix your hardware is going to be a
dead end. When you switch to wayland, you'll lose all of your fixes,
which isn't great.

>
> > We have tested this with several XP-Pen devices, including Artist 24.
>
> Sorry if my tests show something different. Maybe there is something wron=
g with my GNU/Linux operating system (Fedora 38 KDE spin). Let me know if y=
ou have any idea why I get these results and guide me with what distro I sh=
ould switch to get a similar observation than you do (and also to report th=
e issue to the Fedora team).
>
> ---
>
> All in all (and in the case that my observations and tests are correct), =
I still stand by the points that I made in my blog post:
>
> - I don't have any way to customise the hardcoded eraser buttons in users=
pace and **it is a problem**: for devices without a touchscreen or mouse, n=
ot having access to a right-click by default on the device is a handicap. M=
any actions on the D.E. and applications use the right click. The preferenc=
e to replace it with an 'eraser switch' action by default is IMHO highly de=
batable here.

AFAIU, the kernel now "merges" both buttons, which is a problem. It
seems to be a serious regression. This case is also worrying because I
added regression tests on hid, but I don't have access to all of the
various tablets, so I implemented them from the Microsoft
specification[0]. We need a special case for you here.

> - In the case of a pen that already has an eraser tip on the other side o=
f the device [2], it makes no sense to exchange the right-click top button =
for another way to erase. Also in userspace, there seems to be no way to di=
stinguish between the two buttons (the eraser tip and the eraser button). A=
ll actions from xsetwacom, xinput/libinput target the two eraser devices, a=
nd they target them unsuccessfully too.

Again, we can't do more than what the device reports. Well, we can
always quirk it in some cases, but ideally we don't have to do
anything. MS spec [0], only shows a single button pen with an eraser
tail or a pen with 2 buttons, one of them being the eraser one. I'm
not sure if they decided to prevent dual button pens with eraser tail,
but Wacom definitely has some, and they work.

Without the actual data from your pen, I can not tell much, because I
don't follow which path we are taking on the kernel side. Please
report with your hid-recorder logs, so I can understand why this is
happening and how we can fix it.

>
> [1]: https://mastodon.social/@protonmail/111346195283677411
> [2]: https://www.davidrevoy.com/data/images/blog/2023/2023-11-01_linux-ke=
rnel-broke-my-stylus_xp-pen-artist-pro-16-gen2_net.jpg
> [3]: https://docs.krita.org/en/reference_manual/popup-palette.html
> [4]: https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-s=
tylus-need-help
>
>
> ------- Original Message -------
> On Friday, November 3rd, 2023 at 21:05, Illia Ostapyshyn <ostapyshyn@sra.=
uni-hannover.de> wrote:
>
>
> > Hello David, Hello Jiri,
> >
> > The XP-Pen hardware reports the Eraser usage for the upper stylus butto=
n.
> > Generally, styli report Invert usages when erasing, as described in [1]=
.
> > XP-Pen digitizers, however, tend to omit them.
> >
> > The generic driver maps the Eraser usage to BTN_TOUCH and the Invert
> > usage to BTN_TOOL_RUBBER. Pens conforming to [1] send the Invert usage
> > first (switching the tool to BTN_TOOL_RUBBER) followed by Eraser, which
> > appears in userspace as a BTN_TOUCH event with the rubber tool set.
> >
> > Due to an oversight, devices not reporting Invert had the BTN_TOOL_RUBB=
ER
> > event masked. This has caused the kernel to send only BTN_TOUCH events
> > without the tool switch when erasing.
> >
> > The situation got worse with refactoring done in 87562fcd1342. An erase=
r
> > without Invert caused the hidinput_hid_event state machine to get stuck
> > with BTN_TOOL_RUBBER internally (due to it being masked). For the
> > userspace, this looked as if the pen was never hovering again, renderin=
g
> > it unusable until the next reset. 276e14e6c3 fixes this by adding
> > support for digitizers that do not report Invert usages when erasing.

AFAICT 276e14e6c3 already had the hid tests integrated at
tools/testing/selftests/hid/tests/test_tablet.py

It would have been great to add the cases you are mentioning here,
because there is a strong chance I'll break things once again when we
try to fix that regression.


> >
> > ---
> >
> > David, we are sorry that our patch broke your workflow. However,
> > forwarding hardware events as-is to the userspace has always been the
> > intended behavior, with a kernel bug preventing it so far. You can stil=
l
> > remap the eraser button to a right click using xsetwacom:
> >
> > xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
> >
> > Replace the device name with the corresponding eraser device from
> > "xsetwacom list devices". You can also do this with "xinput set-button-=
map",
> > which works for libinput as well. We have tested this with several
> > XP-Pen devices, including Artist 24.
> >
> > [1] https://learn.microsoft.com/en-us/windows-hardware/design/component=
-guidelines/windows-pen-states
>

Cheers,
Benjamin

[0] https://learn.microsoft.com/en-us/windows-hardware/design/component-gui=
delines/windows-pen-states
[1] https://gitlab.freedesktop.org/libevdev/hid-tools

