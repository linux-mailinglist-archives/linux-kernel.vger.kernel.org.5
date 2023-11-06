Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514E7E1915
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjKFDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFDL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:11:27 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314AFB;
        Sun,  5 Nov 2023 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699240281; x=1699499481;
        bh=idQ3IqidFdyHsoQsdHKBLqOmv9RIswPb409eAI7L+Vk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hGeRn9u8PIG9NW10GF2zaushzJcWTrhTK+dEXyRSMDMIgE7dfPSJx6UnUyG98kLuS
         439HKtzT7U+jWzZyGeQx7oINFRo62WbGROeAq10VQV4gjeSeVyTrJExxOHVf9Ohuw7
         yOisfDu8zp6U4dv2EQhD1A72uc2Nfex+EXE2O1flRsdcMUkgXoojfjHxeHRBqoC+L4
         NGuFAy/OoW9zzgm52ESzKngo1ftDREbXwDCL4k84Qhmxhz3Yv8SRzNKV2T8NULqEaC
         q7YTHLjJVFnjl6IyruWdcZJiMgHa0ZB3z6Kc86BqiyoZcv7GSMYHIHU7STPfnk0V40
         86DHBbJAClU1g==
Date:   Mon, 06 Nov 2023 03:11:09 +0000
To:     Yihong Cao <caoyihong4@outlook.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
Message-ID: <87a5rr1sqf.fsf@protonmail.com>
In-Reply-To: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
References: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
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

On Mon, 30 Oct, 2023 01:05:38 +0800 "Yihong Cao" <caoyihong4@outlook.com> w=
rote:
> Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
> mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding them
> to non-apple keyboards fixes function key.
>
> Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
> ---
>  drivers/hid/hid-apple.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 3ca45975c686..d9e9829b2200 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_appl=
e_keyboards[] =3D {
>  =09{ "AONE" },
>  =09{ "GANSS" },
>  =09{ "Hailuck" },
> +=09{ "Jamesdonkey" },

Sorry, maybe I misunderstood the commit message. In wired mode, if the
keyboard is identified as "Jamesdonkey A3R", shouldn't this value be
"Jamesdonkey A3R" instead of "Jamesdonkey"?

> +=09{ "A3R" },
>  };
>
>  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

--
Thanks,

Rahul Rameshbabu

