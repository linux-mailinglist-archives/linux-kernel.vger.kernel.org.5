Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2A7E943F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjKMBqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMBqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:46:50 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80096186;
        Sun, 12 Nov 2023 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699840004; x=1700099204;
        bh=THFQ3yAN+2XQGRTQW6HAEb4TgFT3tfm71ToDb/vXCcU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wcEqnwuy87Su9rCXUS/dawhIFtPXHRo8bFbsa+3+xUcdNKoU+IwK/g3uFEx35Lz3t
         8PT0rBgYFX9IrYzpRbrKhuVpZsv5w6pWfHzwLwSwP4wI4xPXyT7SiiF4WvqxZQ8TRp
         IxI4UuOCeGmnKqH7XysPInZKG87wCeQh1/w2S1lYcWPqOoh/Ce2jUd9NT854R0fapr
         n+dVPQTQcIi5TAFY6uWZmURxmGvuuOJLiVJOZ4b8PAuaCc0Fz8cXsTkkXuRXfpeZ8a
         071oHGO6VsGtaRq9HOQ9Gu9ExVTDzlWL2FxpcF3xdD7RmeRCq37iq17voTSZjEvANC
         RJzo0iBS67y6g==
Date:   Mon, 13 Nov 2023 01:46:25 +0000
To:     Yihong Cao <caoyihong4@outlook.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
Message-ID: <87o7fy77de.fsf@protonmail.com>
In-Reply-To: <MEYP282MB210374CF33FEABA6231FACB19BA9A@MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM>
References: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM> <87a5rr1sqf.fsf@protonmail.com> <MEYP282MB210374CF33FEABA6231FACB19BA9A@MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov, 2023 00:08:31 +0800 "Yihong Cao" <caoyihong4@outlook.com> w=
rote:
> On Mon, Nov 06, 2023 at 03:11:09AM +0000, Rahul Rameshbabu wrote:
>> On Mon, 30 Oct, 2023 01:05:38 +0800 "Yihong Cao" <caoyihong4@outlook.com=
> wrote:
>> > Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
>> > mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding the=
m
>> > to non-apple keyboards fixes function key.
>> >
>> > Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
>> > ---
>> >  drivers/hid/hid-apple.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
>> > index 3ca45975c686..d9e9829b2200 100644
>> > --- a/drivers/hid/hid-apple.c
>> > +++ b/drivers/hid/hid-apple.c
>> > @@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_a=
pple_keyboards[] =3D {
>> >  =09{ "AONE" },
>> >  =09{ "GANSS" },
>> >  =09{ "Hailuck" },
>> > +=09{ "Jamesdonkey" },
>>
>> Sorry, maybe I misunderstood the commit message. In wired mode, if the
>> keyboard is identified as "Jamesdonkey A3R", shouldn't this value be
>> "Jamesdonkey A3R" instead of "Jamesdonkey"?
>>
>
> Hi!
>
> "Jamesdonkey" is the manufacturer and "A3R" is the model. I think adding
> manufacturer to non-apple list is suggested, just like commit
> c4444d8749f696384947192b602718fa310c1caf,
> 20afcc462579c0bd79a59ab2b87b82ffa833d118, and
> a0a05054583fed17f522172e101594f1ff265463 did.
>

  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
  {
    int i;

    for (i =3D 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
      char *non_apple =3D non_apple_keyboards[i].name;

      if (strncmp(hdev->name, non_apple, strlen(non_apple)) =3D=3D 0)
        return true;
    }

    return false;
  }

Looking at the code where non_apple_keyboards is used, the values in the
array are compared against the hid device name attribute. This name will
be same as iManufacturer + iProduct output you shared with lsusb (thank
you for doing this).

> However, my keyboard's hardware is buggy, in wireless and wired mode, the
> manufacturer is empty, only model name exists. For your reference, the
> result of `lsusb -v` is pasted below.
>
> In wired mode, `lsusb -v` shows:
>
> Bus 003 Device 002: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x05ac Apple, Inc.
>   idProduct          0x024f Aluminium Keyboard (ANSI)
>   bcdDevice            1.26
>   iManufacturer           1 Jamesdonkey
>   iProduct                2 A3R
>   iSerial                 0
>   bNumConfigurations      1

=09if (dev->manufacturer)
=09=09strscpy(hid->name, dev->manufacturer, sizeof(hid->name));

=09if (dev->product) {
=09=09if (dev->manufacturer)
=09=09=09strlcat(hid->name, " ", sizeof(hid->name));
=09=09strlcat(hid->name, dev->product, sizeof(hid->name));
=09}

The above is from hid-core which indicates the name is Manufacturer +
Product separated by a single space character.

Ok, so in wired mode, one of the entries should be "Jamesdonkey A3R",
rather than just Jamesdonkey.

>
> In wireless mode:
>
> Bus 001 Device 003: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x05ac Apple, Inc.
>   idProduct          0x024f Aluminium Keyboard (ANSI)
>   bcdDevice            2.00
>   iManufacturer           0
>   iProduct                1 A3R-U
>
> And `dmesg` shows:
>
> [ 1779.692121] input: A3R-U as /devices/pci0000:00/0000:00:08.1/0000:06:0=
0.3/usb1/1-2/1-2:1.0/0003:05AC:024F.0008/input/input35
> [ 1779.749037] apple 0003:05AC:024F.0008: input,hidraw2: USB HID v1.10 Ke=
yboard [A3R-U] on usb-0000:06:00.3-2/input0
>
> In bluetooth mode, the iProduct is "A3R".
>
> Adding "A3R" to non-apple list makes keyboard to work in both wireless
> and bluetooth mode.

Are you sure that works? I am pretty sure this value needs to be "A3R-U"
because of the conditional, at least from reading the code. Would you
mind adding a print for hdev->name in the driver right before
apple_is_non_apple_keyboard is called in apple_input_configured to
confirm that the values printed do match up (feel free to share the
dmesg in your reply).

>
> Best wishes,
>
> Yihong Cao
>
>> > +=09{ "A3R" },
>> >  };
>> >
>> >  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

To me, it seems this patch needs to be changed to use "Jamesdonkey A3R"
for wired and "A3R-U" for wireless. Keep in mind, all this function is
used for is adding a special quirk where you see the following
information. Aside from that, Apple vendor keyboards from different
manufacturers will work as expected without any change.

=09if (apple_is_non_apple_keyboard(hdev)) {
=09=09hid_info(hdev, "Non-apple keyboard detected; function keys will defau=
lt to fnmode=3D2 behavior\n");
=09=09asc->quirks |=3D APPLE_IS_NON_APPLE;
=09}

--
Thanks for the patch,

Rahul Rameshbabu

