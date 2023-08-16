Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C577D863
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbjHPCXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbjHPCXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:23:18 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F75EE5;
        Tue, 15 Aug 2023 19:23:17 -0700 (PDT)
Date:   Wed, 16 Aug 2023 02:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692152592; x=1692411792;
        bh=p+kWhC1mkvADWQXIvJr5BP8Kw+G4C7jb3LAs6yzPGm4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dfUaRshru4XG0C11u7WZ+F14RPGtGn8354Baw2Nl08h5WZbXQEbELX3V5k7unOaIq
         7tx/tYqJnJrl/vEDznd7r28v7LkVT4D1TqBP5WY9mP/QLRCA1MVPhw9f9B+cM9gx4L
         TH7DmXi8x57uum+amCGmQoZfVoMY2s9UwmtmxoNExAgCueDbDAZ9KnjXSSlMFd7Cdm
         PBXXbxxBu4UVtSSLl316ftRgTsIrJS/7pFykcPHafkod19rmY4jcEqRVFxltZePaHV
         KcntdJK8DX61k+t3aA+hhDBagi7BnDwBTpXw7nmac1/UGaSp73QAkkKNpUNB1+2o9q
         Cl9dgmmqzDhlg==
To:     Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: apple: Add "Hailuck" to the list of non-apple keyboards
Message-ID: <87h6ozafpb.fsf@protonmail.com>
In-Reply-To: <20230815201959.17569-1-ntonnatt@ccrma.stanford.edu>
References: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu> <20230815201959.17569-1-ntonnatt@ccrma.stanford.edu>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug, 2023 13:19:59 -0700 "Nils Tonnaett" <ntonnatt@ccrma.Stanfor=
d.EDU> wrote:
> Powzan keyboards KB750 and KB770 identify as
> "Hailuck Co.,Ltd USB Keyboard". Adding "Hailuck" to the list
> of non-apple keyboards fixes function keys for these models.
>
> Signed-off-by: Nils Tonnaett <ntonnatt@ccrma.stanford.edu>
> ---
> V1 -> V2:
> =09- Start commit message subject with HID: apple: instead of hid:
> =09- Comma terminate last member of array
>
>  drivers/hid/hid-apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index d7b932925730..3ca45975c686 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -343,7 +343,8 @@ static const struct apple_non_apple_keyboard non_appl=
e_keyboards[] =3D {
>  =09{ "SONiX USB DEVICE" },
>  =09{ "Keychron" },
>  =09{ "AONE" },
> -=09{ "GANSS" }
> +=09{ "GANSS" },
> +=09{ "Hailuck" },
>  };
>
>  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

