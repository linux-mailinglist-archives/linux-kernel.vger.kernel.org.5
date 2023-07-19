Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A82758BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGSC54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:57:54 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0E1BCF;
        Tue, 18 Jul 2023 19:57:52 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-634efb81e8dso33941026d6.1;
        Tue, 18 Jul 2023 19:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735472; x=1692327472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgN/aEbIJaGus3lBLTP5nBiUgj+1ZX+5gW3DRu+sR3I=;
        b=sxSrI5kMOGCJckd0BBwvprSpVjbMU/pOn0TPNIabswECHB3+GHnOp+Li3BHu/cN8Rp
         6VoddgtKCK41cH2zMJRO9jAopn1pt5RDZ0Y5ncwXuX4ilagid2fcrggac6kwNFuolaIC
         VaFLwiG+GPGAF+yDWhzlkFagpv2I1ef90qh5DdIyfHYHtd7zLt0NLXNsqWHH6KNeTbJW
         2hlWe0P8wjqvGgFwaFPv8gwE573TmF7Grc1tkAg/fH+IgGvoCtdplK+YSTXCRP3XEcLn
         VtabR+FPJQcWvBBa+YCT/EnRt2OxCxSZ2tYZeHCUZ7kwUg80l4yq5oJj6GcLttVBQras
         Xscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735472; x=1692327472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgN/aEbIJaGus3lBLTP5nBiUgj+1ZX+5gW3DRu+sR3I=;
        b=IdJBD9IlQTEKEtywXGfPBeyv1z8IqGR3dWPr8VvAWrMxkYp5GC/P59DGzYeKmnXACv
         LnyYn21uZFwphoTZGoIdP3xeR1Q8IMM7ZqWFUzqVytVfonjhs9bYe6IUBtw2LBHCyQpB
         fjcBfmeh9p7YxFxeZ7PB4nIfkR4nH1xKzS3ZdbonD90UoOzyxc/gXZynZJddJUZJOK5B
         9ID6hwEebO657gg+HLdKFzIkv95EiCasBIBxOTqhLUTTCq15oqbYPihz7iE0B3/IpOfr
         ZXcxUqGq8QsPbUE9oIw7PExBgDWOyHmq47/6SrVldzwJq1BrvFD9XAX/lb+sw88nHgSd
         Kcpw==
X-Gm-Message-State: ABy/qLaX1B21VT3Untb86BTEuJqIWCbEW/lSBD1vtTQ4+i6QWaBg8m0e
        OAQtEPKbLAPEMJJJU5jwudqPuWYUxJjWiHdvqSgtaThXLG4=
X-Google-Smtp-Source: APBJJlFGCN14Vr/H5OtafTTqphtohQEnGpnKlgVlChnM0dCOQeUXJ7EHvwwZSEAz07sy+h5hCSCMHYnakBPLsM/+/Rk=
X-Received: by 2002:a0c:aa95:0:b0:626:38cc:6497 with SMTP id
 f21-20020a0caa95000000b0062638cc6497mr14323566qvb.5.1689735471930; Tue, 18
 Jul 2023 19:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
 <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com> <DM6PR04MB65753E95C58554A9BD01C3FEFC38A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65753E95C58554A9BD01C3FEFC38A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Wed, 19 Jul 2023 10:57:40 +0800
Message-ID: <CA+Da2qyq4jrzOpVJJXOO6mp2sHgoV-cg2OqQqeNZ0pG87XxCtA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove FW revision from CID check
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "chunyan.zhang@unisoc.com" <chunyan.zhang@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
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

On Tue, Jul 18, 2023 at 8:32=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> >
> > On 18/07/23 04:15, Wenchao Chen wrote:
> > > When the card is reset, mmc_card_init() will check if this
> > > card is the previous card by comparing the CID.
> > >
> > > If the firmware is upgraded, the product version may change,
> > > so we remove the product version from the CID check.
> >
> > What is the use-case for this?  I would have thought it is safer
> > not to assume anything about the card after the firmware has been
> > upgraded.
> Ack on that.
>
> Regardless, the PRV CID-slice is [48:55]  and CRC [1:7]?
>
> Thanks,
> Avri
>
Yes, JESD84-B51 7.2 CID register
Table 75 -- CID Fields
Manufacturer ID     MID    8   [127:120]
...
Product revision     RPV    8   [55:48]
...
CRC7 checksum    CRC   7    [7:1]
not used, always =E2=80=9C1=E2=80=9D  -      1    [0:0]

> >
> > >
> > > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > > ---
> > >  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 89cd48fcec79..32a73378d5c3 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -32,6 +32,9 @@
> > >  #define MIN_CACHE_EN_TIMEOUT_MS 1600
> > >  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
> > >
> > > +#define MMC_CID_PRV_MASK GENMASK(23, 16)
> > > +#define MMC_CID_CRC_MASK GENMASK(7, 0)
> > > +
> > >  static const unsigned int tran_exp[] =3D {
> > >       10000,          100000,         1000000,        10000000,
> > >       0,              0,              0,              0
> > > @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
> > >       return 0;
> > >  }
> > >
> > > +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
> > > +{
> > > +     /*
> > > +      * When comparing CID, we need to remove the product
> > > +      * version (Field PRV, offset 55:48) and CRC. Because
> > > +      * the product version will change when the firmware
> > > +      * is upgraded. Also, the new CRC is different.
> > > +      */
> > > +     return cid[0] !=3D raw_cid[0] || cid[1] !=3D raw_cid[1] ||
> > > +             (cid[2] & ~MMC_CID_PRV_MASK) !=3D (raw_cid[2] &
> > ~MMC_CID_PRV_MASK) ||
> > > +             (cid[3] & ~MMC_CID_CRC_MASK) !=3D (raw_cid[3] &
> > ~MMC_CID_CRC_MASK);
> > > +}
> > > +
> > >  static void mmc_set_erase_size(struct mmc_card *card)
> > >  {
> > >       if (card->ext_csd.erase_group_def & 1)
> > > @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host,
> > u32 ocr,
> > >               goto err;
> > >
> > >       if (oldcard) {
> > > -             if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) =
{
> > > +             if (mmc_check_cid(cid, oldcard->raw_cid)) {
> > >                       pr_debug("%s: Perhaps the card was replaced\n",
> > >                               mmc_hostname(host));
> > >                       err =3D -ENOENT;
>
