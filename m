Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E011789868
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHZR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHZR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:26:39 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AE3C9;
        Sat, 26 Aug 2023 10:26:36 -0700 (PDT)
Date:   Sat, 26 Aug 2023 17:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693070794; x=1693329994;
        bh=7wJ8lq2xm7o0s1nME9SzF3V5RE5Cx/GeX7k1EuBkiIg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Pqduiu65E39WMk6Btn6X7x752u6YvNf0ohXjLeEqaZLoFS8SAAN0WLElDJU6VGgYz
         HY8aR7lzQY+CH8DhE0/I1RG8qnMdRFWLg17HWNp8CNy6/syETgoCnx3sRztFPdMb8B
         2KBUWLF3rFMHUUm//b57BYGO8tgWhCxNcbg2aCnnT10Of2QvEuRtQaDAslmBgp1VUe
         Vt65kAGhzvA5y7JYoJsBScyBzS4/3a3HYQr9vGERAkv1FAhS4YzJD5Y3cMPpjn4n4b
         RfbULetZKAkmt4GCY65qWwTBEX9f6bUDmFme91jydqEoQplAP27pW+vJtgRlrpSiAD
         bgedKGK51F9Fg==
To:     Riwen Lu <luriwen@hotmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Message-ID: <87bketu33z.fsf@protonmail.com>
In-Reply-To: <TYCP286MB2607279A11E7F97D249FD4CCB11CA@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM> <OS3P286MB259916DCE3D992135FF05F4CB115A@OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM> <87msyq5m7y.fsf@protonmail.com> <TYCP286MB2607279A11E7F97D249FD4CCB11CA@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug, 2023 16:03:46 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
> =E5=9C=A8 2023/8/17 12:25, Rahul Rameshbabu =E5=86=99=E9=81=93:
>>
>> On Wed, 16 Aug, 2023 16:38:19 +0800 "Riwen Lu" <luriwen@hotmail.com> wro=
te:
>>> From: Riwen Lu <luriwen@kylinos.cn>
>>>
>>> The format '%*ph' print up to 64 bytes long as a hex string with ' '

Cosmetic but if you are sending a v3 anyways, s/print/prints.

>>> sepatator. Usually the size of report descriptor is larger than 64

s/sepatator/separator

>>> bytes, so consider using print_hex_dump_debug to print out all of it fo=
r
>>> better debugging.
>>>
>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>>
>>> ---
>>> v1->v2:
>>>   - Add a prefix for the hex dump.
>>> ---
>>>   drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i=
2c-hid-core.c
>>> index efbba0465eef..fd82e9042da5 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>>>   =09=09}
>>>   =09}
>>>
>>> -=09i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
>>> +=09i2c_hid_dbg(ihid, "Report Descriptor\n");
>>
>> Instead of just indicating that the report descriptor dump begins with
>> the above print, I think it makes more sense for the print to be changed
>> to a pair of begin/end or "cut here" prints similar to what you see in
>> oops messages. This will help individuals reading reports copied by bug
>> reporters validate that the complete descriptor dump is present.
>>
>> Something along the lines of what is done in sound/soc/sof/debug.c.
>>
> I don't think it's necessary to add a pair of begin/end prints like
> that. However, I can print out the size of the report descriptor through
> i2c_hid_dbg. And print_hex_dump_debug prints each line with a "Report
> Descriptor" prefix and an offset, so it's easy to know if the descriptor
> dump is complete.
> The dump message is similar to the following.

Yeah, I agree with this. My main concern was the fact that the
i2c_hid_dbg was not adding any value as-is aside from indicating what
driver is causing the dump (which could be appended to
print_hex_dump_debug). I like adding the size in the print.

> i2c_hid i2c-PNP0C50:00: Report Descriptor size: 0x144
> Report Descriptor: 00000000: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19=
 01
> Report Descriptor: 00000010: 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81=
 03
> Report Descriptor: 00000020: 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 95=
 03
> Report Descriptor: 00000030: 81 06 c0 c0 05 0d 09 05 a1 01 85 04 09 22 a1=
 02
> Report Descriptor: 00000040: 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95=
 01
> Report Descriptor: 00000050: 75 03 25 02 09 51 81 02 75 01 95 03 81 03 05=
 01
> Report Descriptor: 00000060: 15 00 26 5b 05 75 10 55 0d 65 11 09 30 35 00=
 46
> Report Descriptor: 00000070: 46 2a 95 01 81 02 46 59 17 26 f4 02 09 31 81=
 02
> Report Descriptor: 00000080: 05 0d 15 00 25 64 95 03 c0 55 0c 66 01 10 47=
 ff
> Report Descriptor: 00000090: ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81=
 02
> Report Descriptor: 000000a0: 09 54 25 7f 95 01 75 08 81 02 05 09 09 01 25=
 01
> Report Descriptor: 000000b0: 75 01 95 01 81 02 95 07 81 03 09 c5 75 20 95=
 01
> Report Descriptor: 000000c0: 81 03 05 0d 85 02 09 55 09 59 75 04 95 02 25=
 0f
> Report Descriptor: 000000d0: b1 02 85 07 09 60 75 01 95 01 15 00 25 01 b1=
 02
> Report Descriptor: 000000e0: 95 07 b1 03 06 00 ff 85 08 09 c5 15 00 26 ff=
 00
> Report Descriptor: 000000f0: 75 08 96 00 01 b1 02 c0 05 0d 09 0e a1 01 85=
 03
> Report Descriptor: 00000100: 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1=
 02
> Report Descriptor: 00000110: c0 09 22 a1 00 85 05 09 57 09 58 75 01 95 02=
 25
> Report Descriptor: 00000120: 03 b1 02 95 06 b1 03 c0 c0 06 00 ff 09 01 a1=
 01
> Report Descriptor: 00000130: 15 00 26 ff 00 75 08 85 06 95 3f 09 01 81 02=
 09
> Report Descriptor: 00000140: 01 91 02 c0
>
> Thanks.
>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/sound/soc/sof/debug.c?id=3D4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6#n407
>>
>>> +=09print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16,=
 1,
>>> +=09=09=09rdesc, rsize, false);
>>>
>>
--
Thanks,

Rahul Rameshbabu



