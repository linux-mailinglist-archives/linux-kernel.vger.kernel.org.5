Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78E75AA43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGTI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGTIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:38:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43F269D;
        Thu, 20 Jul 2023 01:38:43 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6355e774d0aso4742086d6.1;
        Thu, 20 Jul 2023 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689842323; x=1690447123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zoTQ5d78kRlUlSdOrNN6oeSCbtSit7Vz7DB8FGSlg=;
        b=dbEqJ0dkZvIEDMAnoLM4eaPEPNk40OoPGiKL5dBvoqWgEDZifa+YNuzIV6Pex7WsSJ
         jDwOH/420m52SQuCPD8eda+8fwtWXqnTw+Ia9C6dSgvpxvh0I2sCmGtC/OLrWnKYlXpC
         S1Qd4DYZkyNPec9X6WtVBav6ESp3QRiOUSYPFWlqx6l1gdhI9KkxfsS1+a26MQz+Ju0p
         tr212L8CuY4a9VKrceCAeK2vVQwjnTv80m7HlCeAdJE4pDKp/TBBMYI75KvSDaPxQyBg
         NDW7H57CL+X+H6qX+j/IeZ6EB36+KvVDq4rRIb4yW8/4xGZLf5xO9dDTXXYF+1YmizM8
         9lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842323; x=1690447123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98zoTQ5d78kRlUlSdOrNN6oeSCbtSit7Vz7DB8FGSlg=;
        b=Zo+3QhxhjfIhfu+AqxmzdA7A8OMewPogIkA94UAe/rd8DmFlox0CRFylIB4DiqQiZe
         KsEXkxQJ3e+5pOZVDmF5l46b6zw+NIK8SaxUO9QUMDta0TiWeWQ4Rw9nvYTWCetR35oc
         k3Jvi4V3CWVrzDqDXLOYLkmPCNnJPXexo/BDaSjBsOb+ARyFnFDmRO8i1y51DQBfHxNd
         3EXfzWAIJ98XxDTQ4tMPA07wsGb51EfS21849jWdyxyjV7wW1Fv0pz5+lWCDIgmW0wDe
         0PNRdLL8M7iB07kFws2pekIpdZYVAFmxs2WgenVgbY4SKkBZ7/ih6X7+5OUz0rRfWVIB
         WIWQ==
X-Gm-Message-State: ABy/qLZsfBf4Cut5HvvY2DZAOl9ektmKYiglEGt6AREOG3cN4eCMQIce
        CLJv1vrz/GNfsj4gT8jCYmENLPlgiq0ImpN4Joo=
X-Google-Smtp-Source: APBJJlHq1SeqRhLXIpHON4RyHUs6qSukliilePjXfmKvZPx7KDuQwShLuCWSEUEaG6G6FNMM9sTuJ+cisl/9i4TpIFQ=
X-Received: by 2002:a0c:d641:0:b0:637:3ca5:cc55 with SMTP id
 e1-20020a0cd641000000b006373ca5cc55mr6802304qvj.41.1689842322750; Thu, 20 Jul
 2023 01:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
 <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com> <CA+Da2qxOhK7Uc8_ONVgkR=3pTnTo7KgcJi-yS3Cv730+J0pAxA@mail.gmail.com>
 <ff06bd46-bf43-d2dc-751f-47f41ccc1821@intel.com>
In-Reply-To: <ff06bd46-bf43-d2dc-751f-47f41ccc1821@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 20 Jul 2023 16:38:31 +0800
Message-ID: <CA+Da2qx+mQ1N-7OnQh0ed6_diXgTadKMzJ+9rkqVZv0rhXYTFQ@mail.gmail.com>
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

On Thu, Jul 20, 2023 at 2:45=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 19/07/23 05:46, Wenchao Chen wrote:
> > On Tue, Jul 18, 2023 at 2:13=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 18/07/23 04:15, Wenchao Chen wrote:
> >>> When the card is reset, mmc_card_init() will check if this
> >>> card is the previous card by comparing the CID.
> >>>
> >>> If the firmware is upgraded, the product version may change,
> >>> so we remove the product version from the CID check.
> >>
> >> What is the use-case for this?  I would have thought it is safer
> >> not to assume anything about the card after the firmware has been
> >> upgraded.
> >>
> > Hi adrian
> >     Understood, but we have case:
> >     1.Before the firmware upgrade
> >         [T5745@C0] mmc0 oldcard raw->cid[2]: 32691160, raw->cid[3]: d92=
41800
> >         PRV=3D69
> >     2.After the firmware upgrade
> >         [T5745@C0] mmc0 cid[2]: 32011160 cid[3]: d9241800
> >         PRV=3D01
> >     If the PRV is not excluded in the CID check, then the mmc
> > initialization will fail after the mmc reset.
> >     In addition, CRC is excluded because some controllers support
> > SDHCI_QUIRK2_RSP_136_HAS_CRC.
>
> I do not know what others are doing in this regard, nor what
> circumstances are leading to the re-initialization.
>
There is a way: reboot the machine, but we don't want to do that.

When the firmware is upgraded, we need to complete the firmware
update by reset card, and the card will be initialized by mmc_init_card
after mmc reset.

> Presumably a clean re-initialization could be done by
> unbinding and rebinding the host controller.
>
Could you tell me how to do that?
Thanks.

> >
> >>>
> >>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> >>> ---
> >>>  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
> >>>  1 file changed, 17 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>> index 89cd48fcec79..32a73378d5c3 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -32,6 +32,9 @@
> >>>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
> >>>  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
> >>>
> >>> +#define MMC_CID_PRV_MASK GENMASK(23, 16)
> >>> +#define MMC_CID_CRC_MASK GENMASK(7, 0)
> >>> +
> >>>  static const unsigned int tran_exp[] =3D {
> >>>       10000,          100000,         1000000,        10000000,
> >>>       0,              0,              0,              0
> >>> @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
> >>>       return 0;
> >>>  }
> >>>
> >>> +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
> >>> +{
> >>> +     /*
> >>> +      * When comparing CID, we need to remove the product
> >>> +      * version (Field PRV, offset 55:48) and CRC. Because
> >>> +      * the product version will change when the firmware
> >>> +      * is upgraded. Also, the new CRC is different.
> >>> +      */
> >>> +     return cid[0] !=3D raw_cid[0] || cid[1] !=3D raw_cid[1] ||
> >>> +             (cid[2] & ~MMC_CID_PRV_MASK) !=3D (raw_cid[2] & ~MMC_CI=
D_PRV_MASK) ||
> >>> +             (cid[3] & ~MMC_CID_CRC_MASK) !=3D (raw_cid[3] & ~MMC_CI=
D_CRC_MASK);
> >>> +}
> >>> +
> >>>  static void mmc_set_erase_size(struct mmc_card *card)
> >>>  {
> >>>       if (card->ext_csd.erase_group_def & 1)
> >>> @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> >>>               goto err;
> >>>
> >>>       if (oldcard) {
> >>> -             if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) =
{
> >>> +             if (mmc_check_cid(cid, oldcard->raw_cid)) {
> >>>                       pr_debug("%s: Perhaps the card was replaced\n",
> >>>                               mmc_hostname(host));
> >>>                       err =3D -ENOENT;
> >>
>
