Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09407E60EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjKHXTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjKHXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:19:07 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4125AC;
        Wed,  8 Nov 2023 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699485542; x=1699744742;
        bh=hN30IFJMwV4b16wG99QQ/b37xa97AkoHDNZUAeUXi6I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jAKKk1fO7Z32QI95W1pmOjJxG7RUH2S4ZqpcoTjYMFOUtHJW2h3Y7P75yNz+AcSfL
         hOKDD+S3jnRWn0oq8KToBStUFsoqu33XteGL1dg5DljTBR9xjCVCfuWW6YLd/ytrmN
         17XnilEUwjLU7uzDVoyMRAnwQgYsLRYC8HY7u45K0aG36AFaE5MuQQUlBMnuAIwOdu
         whg7mNuIQ9D3isIOxIK8BTSDWOb0CTegIZEmkWphvmAG6AaFl3xNxgxbhd/Zom+MCA
         6Hse2Rd8WWBmKslIEOsve03U2YPW4SyZglvHWqID3O6wgZVw+lkoeqAhbbm7q3wAc6
         zzq+6sic5d98g==
Date:   Wed, 08 Nov 2023 23:18:48 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <A01KgwZWh8vP1ux3J92E572eCVMfYPzBcHLuuGfSTYntQMVErkqIcPhJtWRxJsinbI_AfHvD_GcnGvQ1kFtxR36ozCPj_VH8Ys8OlA02MZQ=@protonmail.com>
In-Reply-To: <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de> <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com> <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com> <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de> <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, David, were you able to do a revert of 276e14e6c3?

I'm sorry Benjamin: I did some research on how to build a kernel [1], on ho=
w to revert a commit (easy, I know a bit of Git), and started following it =
step by step. Result: I failed and concluded that it probably requires too =
much computer knowledge compared to what I can do now. I'm afraid I won't b=
e able to build a custom kernel for testing.

[1] https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/#_b=
uilding_a_vanilla_upstream_kernel


On Tuesday, November 7th, 2023 at 08:59, Benjamin Tissoires <benjamin.tisso=
ires@redhat.com> wrote:


> On Mon, Nov 6, 2023 at 9:06=E2=80=AFPM Illia Ostapyshyn
> ostapyshyn@sra.uni-hannover.de wrote:
>=20
> > On 11/6/23 17:59, Benjamin Tissoires wrote:
> >=20
> > > If the pen has 2 buttons, and an eraser side, it would be a serious
> > > design flow for XPPEN to report both as eraser.
> > >=20
> > > Could you please use sudo hid-recorder from hid-tools[1] on any kerne=
l
> > > version and send us the logs here?
> > > I'll be able to replay the events locally, and understand why the
> > > kernel doesn't work properly.
> > >=20
> > > And if there is a design flaw that can be fixed, we might even be abl=
e
> > > to use hid-bpf to change it :)
> >=20
> > My wild guess is that XP-Pen 16 Artist Pro reports an Eraser usage
> > without Invert for the upper button and Eraser with Invert for the
> > eraser tip. A device-specific driver could work with that, but there
> > seems to be no way to incorporate two different erasers (thus, allowing
> > userspace to map them to different actions arbitrarily) in the generic
> > driver currently.
>=20
>=20
> That's exactly why I want to see the exact event flow. We can not do
> "wild guesses" unfortunately (not meaning any offenses).
> And I am very suspicious about the fact that the stylus reports 2
> identical erasers. Because in the past David seemed to be able to have
> 2 distincts behaviors for the 2 "buttons" (physical button and eraser
> tail).
>=20
> > > Generally speaking, relying on X to fix your hardware is going to be =
a
> > > dead end. When you switch to wayland, you'll lose all of your fixes,
> > > which isn't great.
> >=20
> > > AFAIU, the kernel now "merges" both buttons, which is a problem. It
> > > seems to be a serious regression. This case is also worrying because =
I
> > > added regression tests on hid, but I don't have access to all of the
> > > various tablets, so I implemented them from the Microsoft
> > > specification[0]. We need a special case for you here.
> >=20
> > The issue preventing David from mapping HID_DG_ERASER to BTN_STYLUS2 is
> > that the hidinput_hid_event is not compatible with hidinput_setkeycode.
> > If usage->code is no longer BTN_TOUCH after remapping, it won't be
> > released when Eraser reports 0. A simple fix is:
>=20
>=20
> I must confess, being the one who refactored everything, I still don't
> believe this is as simple as it may seem. I paged out all of the
> special cases, and now, without seeing the event flow I just can not
> understand why this would fix the situation.
>=20
> And BTW, if you have a tool affected by 276e14e6c3, I'd be curious to
> get a hid-recorder sample for it so I can get regression tests for it.
>=20
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1589,7 +1589,7 @@ void hidinput_hid_event(struct hid_device *hid,
> > struct hid_field field, struct
> > / value is off, tool is not rubber, ignore */
> > return;
> > else if (*quirks & HID_QUIRK_NOINVERT &&
> > - !test_bit(BTN_TOUCH, input->key)) {
> > + !test_bit(usage->code, input->key)) {
>=20
>=20
> I don't want to be rude, but this feels very much like black magic,
> especially because there is a comment just below and it is not
> updated. So either the explanation was wrong, or it's not explaining
> the situation (I also understand that this is not a formal submission,
> so maybe that's the reason why the comment is not updated).
>=20
> > /*
> > * There is no invert to release the tool, let hid_input
> > * send BTN_TOUCH with scancode and release the tool after.
> >=20
> > This change alone fixes David's problem and the right-click mapping in
> > hwdb works again. However, the tool switches to rubber for the remapped
> > eraser (here BTN_STYLUS2) events, both for devices with and without
> > Invert. This does no harm but is not useful either. A cleaner solution
> > for devices without Invert would be to omit the whole tool switching
> > logic in this case:
> >=20
> > @@ -1577,6 +1577,9 @@ void hidinput_hid_event(struct hid_device *hid,
> > struct hid_field *field, struct
> >=20
> > switch (usage->hid) {
> > case HID_DG_ERASER:
> > + if (*quirks & HID_QUIRK_NOINVERT && usage->code !=3D BTN_TOUCH)
> > + break;
> > +
> > report->tool_active |=3D !!value;
> >=20
> > Remapping Invert does not work anyway as the Invert tool is hardcoded i=
n
> > hidinput_hid_event. Even worse, I guess (not tested) trying to do so
> > would mask BTN_TOOL_RUBBER from dev->keybit and could cause weird
> > behavior similar to one between 87562fcd1342 and 276e14e6c3. This
> > raises the question: should users be able to remap Invert after all?
>=20
>=20
> The kernel is supposed to transfer what the device is. So if it says
> this is an eraser, we should not try to change it. Users can then
> tweak their own device if they wish through hid-bpf or through
> libinput quirks, but when you install a fresh kernel without tweaks,
> we should be as accurate as possible.
>=20
> My main concern is that now we have a device which exports 2 different
> interactions as being the same. So either the firmware is wrong, and
> we need to quirk it, or the kernel is wrong and merges both, and this
> needs fixes as well.
>=20
> Once every interaction on the device gets its own behavior, userspace
> can do whatever they want. It's not the kernel's concern anymore.
>=20
> BTW, David, were you able to do a revert of 276e14e6c3?
>=20
> Cheers,
> Benjamin
