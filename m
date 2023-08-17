Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA677F1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348792AbjHQILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348874AbjHQILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:11:37 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60742D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:11:08 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79a2216a22fso1981597241.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692259863; x=1692864663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnhnXpfMXVOkUdJ8XTjqlG22FaxEQYoj9IS672h/7bM=;
        b=VamYqVM5YtUAB1bPNlGnv50ns9In+OK4nsXx1TvaHbtNVOerYEcmISzAKjpCgptdZ5
         Z7/ONLchmQ2mERNnLJtZmUryheCtJA4k2G1TquEt2U4PU+nytlBWDnL73rM+/xqi3Iut
         SyHaRPwV5vobvIwfAyQymJoDRGzeX2h2vib9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692259863; x=1692864663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnhnXpfMXVOkUdJ8XTjqlG22FaxEQYoj9IS672h/7bM=;
        b=TMyFruV+WnJogE7EbxNxTs3srIU7lhV7va1AjiND0cBKYrdfxrOAOeRrbKlJEi1gO5
         08M/ZcLoBIKkiDHNDy3bmYAh5GNICtequycH6lgoiL3dn5fVBJ/fxz3/x7sxTa2AdnkR
         o2DAj/94EJzyxieznpMnRDIQqZzdMyqES52fU1AHS2A/Pfh6AJ2n8ZMv4NS3G4bNY6m9
         reukCIyK89R2fymzFmgiXQ9TZuTTiYeRdBd3HYWWVoRasUNIa0eHNl8K/iv5RRpVbOs6
         its79dCqyS2EGAnLR/luVO0xxJNIAFQy0/iwFzGhk/sOASJv0j9eZ7hd/F/4sZ8nZBdU
         lnRg==
X-Gm-Message-State: AOJu0YyeDlcrTZ+F8uyhqBNqdO8PP4pwbjWaLS/wQr2EMOYKpoyHhbuJ
        2CukLXmpaUTOiyy1aY/2v6B2e8iN0drwoRZNo6Edag==
X-Google-Smtp-Source: AGHT+IFMsqL3pFYM3QtwPqpO5LX2pHlaj7if/3HlFso69UDgkdRzVb32750YVOtroJzIB9qxeEO7OeSMQcZ129EchfA=
X-Received: by 2002:a67:f150:0:b0:445:209:cac7 with SMTP id
 t16-20020a67f150000000b004450209cac7mr3439728vsm.27.1692259863374; Thu, 17
 Aug 2023 01:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230602090227.7264-1-yong.wu@mediatek.com> <20230602090227.7264-6-yong.wu@mediatek.com>
 <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
 <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
 <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com>
 <810a3cbca7e837925b5750fd2eb1d1a261e865dc.camel@mediatek.com>
 <CAGXv+5G=CM9203GR42szWXx8K7F+swkvKJ_M3ev5_bGTk_zjGg@mail.gmail.com> <2607586420f4c81a2e2fd9f3395263e85d1f83ef.camel@mediatek.com>
In-Reply-To: <2607586420f4c81a2e2fd9f3395263e85d1f83ef.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 17 Aug 2023 16:10:52 +0800
Message-ID: <CAGXv+5E13wFUPH9yw+JeP6-=O6ta51shUGsCH1o5Pvsd5W3h2w@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 4:03=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=87) <Yong.=
Wu@mediatek.com> wrote:
>
> On Mon, 2023-08-14 at 16:21 +0800, Chen-Yu Tsai wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Mon, Aug 14, 2023 at 3:14=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=87) <=
Yong.Wu@mediatek.com>
> > wrote:
> > >
> > > On Fri, 2023-08-11 at 11:30 +0800, Chen-Yu Tsai wrote:
> > > >
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  On Thu, Aug 10, 2023 at 8:23=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=
=87) <
> > Yong.Wu@mediatek.com>
> > > > wrote:
> > > > >
> > > > > On Tue, 2023-08-08 at 17:53 +0800, Chen-Yu Tsai wrote:
> > > > > >
> > > > > > External email : Please do not click links or open
> > attachments
> > > > until
> > > > > > you have verified the sender or the content.
> > > > > >  On Fri, Jun 2, 2023 at 5:04=E2=80=AFPM Yong Wu <yong.wu@mediat=
ek.com
> > >
> > > > wrote:
> > > > > > >
> > > > > > > From: "Chengci.Xu" <chengci.xu@mediatek.com>
> > > > > > >
> > > > > > > MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo,
> > the
> > > > > > other
> > > > > > > is for vpp. and 1 INFRA IOMMU.
> > > > > > >
> > > > > > > Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > > > angelogioacchino.delregno@collabora.com>
> > > > > > > ---
> > > > > > >  drivers/iommu/mtk_iommu.c | 49
> > > > > > +++++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 49 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/iommu/mtk_iommu.c
> > > > b/drivers/iommu/mtk_iommu.c
> > > > > > > index 9c89cf894a4d..5c66af0c45a8 100644
> > > > > > > --- a/drivers/iommu/mtk_iommu.c
> > > > > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > > > > @@ -170,6 +170,7 @@ enum mtk_iommu_plat {
> > > > > > >         M4U_MT8173,
> > > > > > >         M4U_MT8183,
> > > > > > >         M4U_MT8186,
> > > > > > > +       M4U_MT8188,
> > > > > > >         M4U_MT8192,
> > > > > > >         M4U_MT8195,
> > > > > > >         M4U_MT8365,
> > > > > > > @@ -1593,6 +1594,51 @@ static const struct
> > mtk_iommu_plat_data
> > > > > > mt8186_data_mm =3D {
> > > > > > >         .iova_region_larb_msk =3D mt8186_larb_region_msk,
> > > > > > >  };
> > > > > > >
> > > > > > > +static const struct mtk_iommu_plat_data mt8188_data_infra
> > =3D {
> > > > > > > +       .m4u_plat         =3D M4U_MT8188,
> > > > > > > +       .flags            =3D WR_THROT_EN | DCM_DISABLE |
> > > > > > STD_AXI_MODE | PM_CLK_AO |
> > > > > > > +                           MTK_IOMMU_TYPE_INFRA |
> > > > > > IFA_IOMMU_PCIE_SUPPORT |
> > > > > > > +                           PGTABLE_PA_35_EN |
> > > > > > CFG_IFA_MASTER_IN_ATF,
> > > > > >
> > > > > > FWIW, CFG_IFA_MASTER_IN_ATF should not be tied to the
> > compatible
> > > > > > string,
> > > > > > but set via a DT property. The IOMMU controls are secured by
> > > > > > firmware.
> > > > > > It is not a property intrinsically tied to the hardware.
> > > > >
> > > > > The flag CFG_IFA_MASTER_IN_ATF means the registers which
> > > > enable/disable
> > > > > iommu are in the secure world. If the master like pcie want to
> > > > enable
> > > > > iommu, we have to enter secure world to configure it. It should
> > be
> > > > HW
> > > > > intrinsical, right?
> > > >
> > > > If I understand correctly, this is forced by setting some
> > registers.
> > > > The registers are set by the firmware at boot time.
> > >
> > > The register will be set before the masters that have the "iommus=3D"
> > > property probe. If the master doesn't have "iommus=3D" property in
> > its
> > > dtsi node, this register won't be set, then its iommu will be
> > disabled
> > > and it has to access continuous buffer.
> > >
> > > >
> > > > So if a different firmware that doesn't set the registers is
> > used,
> > > > then the IOMMU is available to non-secure kernel, correct?
> > >
> > > No. The meaning of this register is whether to enable iommu. If the
> > > register are not set, the IOMMU for that master is disabled.
> >
> > For clarity, I'm referring to PERI_MST_PROT [1], not the registers in
> > the
> > IOMMU or LARBs. So not any of the registers used in this patch.
> >
> > If that register doesn't restrict access to IOMMU register space to
> > secure
> > only, then I assume it is controlled by fuses?
>
> Thanks for the clarification. Understand this now. If that register
> doesn't restrict this, the register for enabling the iommu could be
> accessed in normal world.
>
> > [1]
> > https://review.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmwar=
e-a/+/be457248c6b0a7f3c61bd95af58372938d13decd/plat/mediatek/drivers/iommu/=
mt8188/mtk_iommu_plat.c#93
> >
> > > >
> > > > That's why I said that it should not be tied to a particular
> > hardware
> > > > platform, but set using a boolean device tree property.
> > > >
> > > > > >
> > > > > > If on some other project there is no such security
> > requirement
> > > > and
> > > > > > the
> > > > > > IOMMU is opened up to non-secure world, and ATF not even
> > having
> > > > > > support
> > > > > > for the SMC call, this becomes unusable and hard to rectify
> > > > without
> > > > > > introducing a new compatible string.
>
> Then this make sense. Sorry, I don't know if such project exist, I
> guess no, right? we could add it when necessary?

I guess that works. It would be a negative property, such as
"mediatek,iommu-is-non-secure". However, since this lock down is orthogonal
to the SoC model, it would be better to model it as such from the beginning=
.

ChenYu
