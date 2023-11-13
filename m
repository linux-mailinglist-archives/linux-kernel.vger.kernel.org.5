Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE37E945F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjKMCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjKMCI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:08:58 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38D1735;
        Sun, 12 Nov 2023 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699841328; x=1700100528;
        bh=KVsl/FDYxgLBMYuSnBmP709gUyQZ2vIzfl59/vhyfQU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=VQCjcPAX64n6lh4+oidN9/GFJE3tQY92xkTVzNhDQRLUy8Cmo5ewExVny+/MAoGBk
         Nw42O+x8+hFdAY3xYSFrSE5u10JN5UmcVQgb+Xxt46j+8LaOWPVReXs99ZzTfvJWip
         EeFyiygpkMSTzCmDgbs3q9G3dnmwQKrWPP/Dyga7keBvejpjWuPvqGrSnDCK2jqE1s
         xT3Ry4IxpwtXd4/BIEiBMTvdJ7Lo0IlbYvkslU6FHrsKaG20M+r9CU1yGbVWedpL2L
         nxfAoUgCQT1M2llTPH3u7+lL93c17u24U8szxHZUrHis7iphLinfBUjzsjo+BLvcRt
         xaP74TYoMWmng==
Date:   Mon, 13 Nov 2023 02:08:32 +0000
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Yihong Cao <caoyihong4@outlook.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
Message-ID: <87fs1a76cj.fsf@protonmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Nov, 2023 01:46:25 +0000 "Rahul Rameshbabu" <sergeantsagara@prot=
onmail.com> wrote:
> On Wed, 08 Nov, 2023 00:08:31 +0800 "Yihong Cao" <caoyihong4@outlook.com>=
 wrote:
>> On Mon, Nov 06, 2023 at 03:11:09AM +0000, Rahul Rameshbabu wrote:
>>> On Mon, 30 Oct, 2023 01:05:38 +0800 "Yihong Cao" <caoyihong4@outlook.co=
m> wrote:
>>> > Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
>>> > mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding th=
em
>>> > to non-apple keyboards fixes function key.
>>> >
>>> > Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
>>> > ---
>>> >  drivers/hid/hid-apple.c | 2 ++
>>> >  1 file changed, 2 insertions(+)
>>> >
>>> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
>>> > index 3ca45975c686..d9e9829b2200 100644
>>> > --- a/drivers/hid/hid-apple.c
>>> > +++ b/drivers/hid/hid-apple.c
>>> > @@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_=
apple_keyboards[] =3D {
>>> >  =09{ "AONE" },
>>> >  =09{ "GANSS" },
>>> >  =09{ "Hailuck" },
>>> > +=09{ "Jamesdonkey" },
>>>
>>> Sorry, maybe I misunderstood the commit message. In wired mode, if the
>>> keyboard is identified as "Jamesdonkey A3R", shouldn't this value be
>>> "Jamesdonkey A3R" instead of "Jamesdonkey"?
>>>
>>
>> Hi!
>>
>> "Jamesdonkey" is the manufacturer and "A3R" is the model. I think adding
>> manufacturer to non-apple list is suggested, just like commit
>> c4444d8749f696384947192b602718fa310c1caf,
>> 20afcc462579c0bd79a59ab2b87b82ffa833d118, and
>> a0a05054583fed17f522172e101594f1ff265463 did.
>>
>
>   static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
>   {
>     int i;
>
>     for (i =3D 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
>       char *non_apple =3D non_apple_keyboards[i].name;
>
>       if (strncmp(hdev->name, non_apple, strlen(non_apple)) =3D=3D 0)

Sorry, my brain slipped here. This is essentially a prefix check. Your
commit works fine :). I consider this patch reviewed. Sorry about that
confusion.

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

