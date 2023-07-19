Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04267758B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGSCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGSCqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:46:31 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30693FC;
        Tue, 18 Jul 2023 19:46:30 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63719ad32e7so38054596d6.1;
        Tue, 18 Jul 2023 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689734789; x=1692326789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alrunddGyr7n1O6dTU2394duvap6e5CEXKLxFMKdcbQ=;
        b=F+9xO7EHDJJtK+PpR7Mqu0aMYjSiAtGBIIg9T9AY9eIPoeu3iY2VrUPbPHDMt4BEMQ
         OM1HeTcAf8slfv2WNu4347kqsqqbdZA1L37hiZ+WBIWBc3rS92XGUf5YJsaHJFiaGhn7
         fYUuW24LjTBvwoWRzJBXl7BlgEf9GkGyEbWj/5VXav9t952p488jO08EjO4WpAL9I75y
         4R5k3HTsJr9/Vkj0xTaoR+TCW3q/T3HO7JKqoYEwkhaGH0oiSz5eMs8v0G5l3C6fbkBN
         A0ZVDy3KaS8F9iVRDnhpbxZtU4+Wce1JLfhCmrq1RtoMYm7wtniGLkUacQliqdEl47fr
         GUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689734789; x=1692326789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alrunddGyr7n1O6dTU2394duvap6e5CEXKLxFMKdcbQ=;
        b=BJtCWmrSxU6XclCZc/by1QUPFpz8JMjlb9HSi2rTIQdlGF8Mcdrqa8xgQ/y1P0C6tH
         /RrCRVy+jcBpgcrch0htcWe1KlwmylGp7Le9f42lsnHCCG6nhpeJSq+ywt9nsotGU5Nk
         lKvhDZmWWQ2bixVDnd+MfAC0mmiizmWZbHXlz2grPRSxuEyZtvon94PXSlFUW32thNIQ
         U4mRAN54WFrPqmumPf6pllqtMZfLMDydkIdEDNRcmU8zcTjRHN1jisn1KYQ1rnIN4RaL
         g6TnfYStqBHoU/bLVF3IlU/VFhg5KtNOx+nctqIbJiIh5Khy+EL++x/NAPMGAvuk4XrB
         l/7A==
X-Gm-Message-State: ABy/qLbMSrRkgxE6Xs/YbTsJ14zQ6x8hadX2iZPL1uNlIa+08C1+iZVi
        s0u0NB9e99UpG8iijF4qNuUHncEHhjgZ3pkDd47GlZXAeSc=
X-Google-Smtp-Source: APBJJlHi9YcS6cywR3cItNs1XzS1rLPuLzN8PYhyxlhuSUkUpuIsrGfYwCyNRf06QQAVdPowvZCsaCnt0ylprKjIWMw=
X-Received: by 2002:a0c:b394:0:b0:635:e303:ed6d with SMTP id
 t20-20020a0cb394000000b00635e303ed6dmr15390732qve.52.1689734789236; Tue, 18
 Jul 2023 19:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230718011504.10947-1-wenchao.chen@unisoc.com> <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
In-Reply-To: <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Wed, 19 Jul 2023 10:46:18 +0800
Message-ID: <CA+Da2qxOhK7Uc8_ONVgkR=3pTnTo7KgcJi-yS3Cv730+J0pAxA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove FW revision from CID check
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 2:13=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/07/23 04:15, Wenchao Chen wrote:
> > When the card is reset, mmc_card_init() will check if this
> > card is the previous card by comparing the CID.
> >
> > If the firmware is upgraded, the product version may change,
> > so we remove the product version from the CID check.
>
> What is the use-case for this?  I would have thought it is safer
> not to assume anything about the card after the firmware has been
> upgraded.
>
Hi adrian
    Understood, but we have case:
    1.Before the firmware upgrade
        [T5745@C0] mmc0 oldcard raw->cid[2]: 32691160, raw->cid[3]: d924180=
0
        PRV=3D69
    2.After the firmware upgrade
        [T5745@C0] mmc0 cid[2]: 32011160 cid[3]: d9241800
        PRV=3D01
    If the PRV is not excluded in the CID check, then the mmc
initialization will fail after the mmc reset.
    In addition, CRC is excluded because some controllers support
SDHCI_QUIRK2_RSP_136_HAS_CRC.

> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 89cd48fcec79..32a73378d5c3 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -32,6 +32,9 @@
> >  #define MIN_CACHE_EN_TIMEOUT_MS 1600
> >  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
> >
> > +#define MMC_CID_PRV_MASK GENMASK(23, 16)
> > +#define MMC_CID_CRC_MASK GENMASK(7, 0)
> > +
> >  static const unsigned int tran_exp[] =3D {
> >       10000,          100000,         1000000,        10000000,
> >       0,              0,              0,              0
> > @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
> >       return 0;
> >  }
> >
> > +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
> > +{
> > +     /*
> > +      * When comparing CID, we need to remove the product
> > +      * version (Field PRV, offset 55:48) and CRC. Because
> > +      * the product version will change when the firmware
> > +      * is upgraded. Also, the new CRC is different.
> > +      */
> > +     return cid[0] !=3D raw_cid[0] || cid[1] !=3D raw_cid[1] ||
> > +             (cid[2] & ~MMC_CID_PRV_MASK) !=3D (raw_cid[2] & ~MMC_CID_=
PRV_MASK) ||
> > +             (cid[3] & ~MMC_CID_CRC_MASK) !=3D (raw_cid[3] & ~MMC_CID_=
CRC_MASK);
> > +}
> > +
> >  static void mmc_set_erase_size(struct mmc_card *card)
> >  {
> >       if (card->ext_csd.erase_group_def & 1)
> > @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> >               goto err;
> >
> >       if (oldcard) {
> > -             if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) {
> > +             if (mmc_check_cid(cid, oldcard->raw_cid)) {
> >                       pr_debug("%s: Perhaps the card was replaced\n",
> >                               mmc_hostname(host));
> >                       err =3D -ENOENT;
>
