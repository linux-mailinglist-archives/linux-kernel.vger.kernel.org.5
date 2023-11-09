Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCD7E6912
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjKILBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjKILBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:01:06 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB722D6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:01:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7afd45199so9176627b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699527663; x=1700132463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6CGmYpbigBpQcTXgZJXSntlu3088yybfPsyLil/vfk=;
        b=awi1D4+00NOuu6zkGrifGXrQx3UTKuIZB7hVotbz2YrcqwuILJfnax/C9Qrb6MJY5Y
         MdvqG0jISOg6fnbYAxlqmtePGnCFjGx3DUotfDfnl0AWZqTxvW4yMykZo3p/PqYhZKFe
         f5yBw2pRClZzLJ3IJcVOnPVnMN298FrqL9USL79YHju0UgUz2ikc3xoOmn9iviF/C7uC
         CZkJqxHV7tX1qWP2jv5+1CW+mJqRSHmVCMxLO70KwAgygFuQIaIQiydAZPHUa0S7nwft
         DosEDGF/p8bQwG4FEIJq1fscErsf69nRpmUgJxQyYdDIMXkAyMrs7LN/KAulWV48Wgkm
         ODiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527663; x=1700132463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6CGmYpbigBpQcTXgZJXSntlu3088yybfPsyLil/vfk=;
        b=w/lHhRQf8kcDxNwNQGvi1R9k37tK1DjmDaJFhvyzih9o2XiHGVS3qUOtrBGv0tJD/D
         5mV4eVeIutOAnxoUy8fvbrL0ZFKkLAxjNmvGpJ9y2XBZHvIF2Hp8qMIGWl+aPLvoYgTA
         0S4aJxRbRGL+hNWrcAB1LGDoef0gi+DkbtdBBaGRthU+Bio09fl9kKITfzNEsWm7HC+k
         OlT5AI0mw10NEUN18BUyDYxTAMA+EQ5dLsEpjnZtsVUQXojCo8vxKOKHU6SXxxDnFLmM
         cqup4zlRf/oFyVI3oD5OSLhSNv3bCrMB5A3RZF/a3hyx1nzgHbv+M8/sbq2jCIRb8Bpx
         NgIg==
X-Gm-Message-State: AOJu0Yw7coz8H9vL2wVu9MSqKpZJxW66Rr8dLsrOrDANJbUwiaHafH75
        WLbhjRgDtdMGgvyR0pXJAZ4aEwNKm1JJmAmP7r05Hw==
X-Google-Smtp-Source: AGHT+IF/tERN+nzjkwFTDurrJVmKBF72AC5NNifmoGAPqKcOyULyIYvpi7mLMRf3djYyzjqUUGXtR+bQsEY0lOmGAcY=
X-Received: by 2002:a0d:d2c3:0:b0:5a8:960d:9aef with SMTP id
 u186-20020a0dd2c3000000b005a8960d9aefmr4299329ywd.49.1699527662757; Thu, 09
 Nov 2023 03:01:02 -0800 (PST)
MIME-Version: 1.0
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com> <CAA8EJpqEkkEoQ9vncNJU1t=mKbvBXKk1FUxnmGTE0Q++sf=oXA@mail.gmail.com>
 <20231108054942.GF3296@thinkpad> <CAA8EJpoCZChHDQLF0QHN0PkRUWV20thXMQvK-sH2fpYaC1zcvg@mail.gmail.com>
 <20231109032418.GA3752@thinkpad> <CAA8EJpoZUf9Ku5meH5VAcSkCbna__5LdPi8rgnN0tyBc-UzzWw@mail.gmail.com>
 <20231109104250.GF3752@thinkpad>
In-Reply-To: <20231109104250.GF3752@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Nov 2023 13:00:51 +0200
Message-ID: <CAA8EJpp+wfe5wUj0FAMY2g3J8v7F8DVf8Bi3BwrAuCp-n=PFJg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Can Guo <cang@qti.qualcomm.com>, quic_cang@quicinc.com,
        bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 at 12:43, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Thu, Nov 09, 2023 at 11:40:51AM +0200, Dmitry Baryshkov wrote:
> > On Thu, 9 Nov 2023 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
> > >
> > > On Wed, Nov 08, 2023 at 08:56:16AM +0200, Dmitry Baryshkov wrote:
> > > > On Wed, 8 Nov 2023 at 07:49, Manivannan Sadhasivam <mani@kernel.org=
> wrote:
> > > > >
> > > > > On Tue, Nov 07, 2023 at 03:18:09PM +0200, Dmitry Baryshkov wrote:
> > > > > > On Tue, 7 Nov 2023 at 06:47, Can Guo <cang@qti.qualcomm.com> wr=
ote:
> > > > > > >
> > > > > > > From: Can Guo <quic_cang@quicinc.com>
> > > > > > >
> > > > > > > On SM8550, two sets of UFS PHY settings are provided, one set=
 is to support
> > > > > > > HS-G5, another set is to support HS-G4 and lower gears. The t=
wo sets of PHY
> > > > > > > settings are programming different values to different regist=
ers, mixing
> > > > > > > the two sets and/or overwriting one set with another set is d=
efinitely not
> > > > > > > blessed by UFS PHY designers. In order to add HS-G5 support f=
or SM8550, we
> > > > > > > need to split the two sets into their dedicated tables, and l=
eave only the
> > > > > > > common settings in the .tlbs. To have the PHY programmed with=
 the correct
> > > > > > > set of PHY settings, the submode passed to PHY driver must be=
 either HS-G4
> > > > > > > or HS-G5.
> > > > > > >
> > > > >
> > > > > You should also mention that this issue is also present in G4 sup=
ported targets.
> > > > > And a note that it will get fixed later.
> > > > >
> > > > > > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > > > > > ---
> > > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
> > > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
> > > > > > >  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
> > > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 +++=
+++++++++++++++---
> > > > > > >  4 files changed, 115 insertions(+), 13 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b=
/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > > index c23d5e4..e563af5 100644
> > > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > > @@ -18,6 +18,7 @@
> > > > > > >  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
> > > > > > >  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
> > > > > > >  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
> > > > > > > +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY     =
   0x12c
> > > > > > >  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
> > > > > > >  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                     =
   0x17c
> > > > > > >  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
> > > > > > > @@ -27,5 +28,6 @@
> > > > > > >  #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
> > > > > > >  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
> > > > > > >  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
> > > > > > > +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
> > > > > > >
> > > > > > >  #endif
> > > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6=
.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > > index f420f8f..ef392ce 100644
> > > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > > @@ -56,6 +56,8 @@
> > > > > > >  #define QSERDES_V6_COM_SYS_CLK_CTRL                         =
   0xe4
> > > > > > >  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                    =
   0xe8
> > > > > > >  #define QSERDES_V6_COM_PLL_IVCO                             =
           0xf4
> > > > > > > +#define QSERDES_V6_COM_CMN_IETRIM                           =
   0xfc
> > > > > > > +#define QSERDES_V6_COM_CMN_IPTRIM                           =
   0x100
> > > > > > >  #define QSERDES_V6_COM_SYSCLK_EN_SEL                        =
   0x110
> > > > > > >  #define QSERDES_V6_COM_RESETSM_CNTRL                        =
   0x118
> > > > > > >  #define QSERDES_V6_COM_LOCK_CMP_EN                          =
   0x120
> > > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-u=
fs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > > index 15bcb4b..48f31c8 100644
> > > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > > @@ -10,10 +10,20 @@
> > > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX                  =
   0x2c
> > > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX           =
   0x30
> > > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX           =
   0x34
> > > > > > > +#define QSERDES_UFS_V6_TX_LANE_MODE_1                       =
   0x7c
> > > > > > > +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL                       =
   0x108
> > > > > > >
> > > > > > >  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2       =
   0x08
> > > > > > >  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4       =
   0x10
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4       =
   0x24
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4    =
   0x54
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                =
   0xd4
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                =
   0xdc
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                =
   0xf0
> > > > > > > +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                  =
   0xf4
> > > > > > >  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                   =
   0x178
> > > > > > > +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1          =
   0x1bc
> > > > > > > +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3             =
           0x1c4
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                  =
   0x208
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                  =
   0x20c
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                  =
   0x214
> > > > > > > @@ -25,6 +35,8 @@
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                     =
           0x264
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                     =
           0x270
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                     =
           0x280
> > > > > > > +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                     =
           0x284
> > > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                     =
           0x28c
> > > > > > > +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                   =
   0x2f8
> > > > > > >
> > > > > > >  #endif
> > > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/driver=
s/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > > index 3927eba..e0a01497 100644
> > > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > > @@ -649,32 +649,51 @@ static const struct qmp_phy_init_tbl sm=
8550_ufsphy_serdes[] =3D {
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1=
, 0x00),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> > > > > > > +
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x=
00),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41=
),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18=
),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14=
),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f=
),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06=
),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c=
),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serd=
es[] =3D {
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes=
[] =3D {
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> > > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18=
),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14=
),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99=
),
> > > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07=
),
> > > > > >
> > > > > > Aside from moving these registers to the HS_G4 table, you are a=
lso
> > > > > > changing these registers. It makes me think that there was an e=
rror in
> > > > > > the original programming sequence.
> > > > > > If that is correct, could you please split the patch into two p=
ieces:
> > > > > > - Fix programming sequence (add proper Fixes tags)
> > > > > > - Split G4 and G5 tables.
> > > > >
> > > > > Ack
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c=
),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18=
),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14=
),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99=
),
> > > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07=
),
> > > > > >
> > > > > > I see all the MODE1 registers being only present in G4 and G5 t=
ables.
> > > > > > Should they be programmed for the modes lower than G4?
> > > > > >
> > > > >
> > > > > We use G4 table for all the modes <=3D G4.
> > > >
> > > > Could you please point me how it's handled?
> > > > In the patch I see just:
> > > >
> > > >        if (qmp->submode =3D=3D UFS_HS_G4)
> > > >                qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
> > > >        else if (qmp->submode =3D=3D UFS_HS_G5)
> > > >                qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g5);
> > > >
> > > > Which looks like two special cases (HS_G4 and HS_G5) and nothing fo=
r
> > > > anything else.
> > > >
> > >
> > > Yes, and the UFS driver passes only G4/G5. For all the gears <=3DG4, =
G4 init
> > > sequence will be used and for G5, G5 sequence will be used.
> > >
> >
> > That's what I could not find in the UFS driver. I see a call to
> > `phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);` and
> > host->phy_gear is initialised to UFS_HS_G2.
> >
>
> You need to check the UFS driver changes in this series to get the comple=
te
> picture as the logic is getting changed.
>
> It is common to get confused because of the way the UFS driver (qcom most=
ly)
> handles the PHY init sequence programming. We used to have only one init
> sequence for older targets and life was easy. But when I wanted to add G4
> support for SM8250, I learned that there are 2 separate init sequences. O=
ne for
> non-G4 and other for G4. So I used the phy_sub_mode property to pass the
> relevant mode from the UFS driver to the PHY driver and programmed the se=
quence
> accordingly. This got extended to non-G5 and G5 now.
>
> Now, the UFS driver will start probing from a low gear for older targets =
(G2)
> and G4/G5 for newer ones then scale up based on the device and host capab=
ility.
> For older targets, the common table (tbls) will be used if the submode do=
esn't
> match G4/G5. But for newer targets, the UFS driver will _only_ pass G4 or=
 G5 as
> the phy_gear, so those specific sequence will only be used.
>
> Hope I'm clear.

Yes, it is now clear, thank you!

Would it be possible / feasible / logical to maintain this idea even
for newer platforms (leaving the HS_A  / HS_B aside)?

tbls - works for HS_G2
tbls + tbls_g4 - works for HS_G4
tbls + tbls_g5 - works for HS_G5

I mean here that the PHY driver should not depend on the knowledge
that the UFS driver will not be setting HS_G2 for some particular
platform and ideally it should continue working if at some point we
change the UFS driver to set HS_G2.


>
> - Mani
>
> > Maybe we should change the condition here (in the PHY driver) to:
> >
> > if (qmp->submode <=3D UFS_HS_G4)
> >
> > ?
> > --
> > With best wishes
> > Dmitry
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--
With best wishes
Dmitry
