Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB87C52D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjJKMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjJKMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:00:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D1A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:00:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1161831a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697025642; x=1697630442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aVTN0BqqtO5MKlfxI7sXoH95j77MBJ0QiNgQ07twsNg=;
        b=juCqbqQItQ0Mvjrv5Ps0hBNTLHa6owH9cKZzz8o5R7WO8hLuj2aLKWr5zCepXUxi2h
         eMBi47RNxYZq+FeZ38rVJHtBBJ/RDVRdZIV5qXHJU4n1CDdyUpNnYQaRhzUf5ShJ+VlR
         tJL0G7iYlsC2dzQyA27+8FGO/4mUV+iQGgSn0GHjmYoQpkuT/Gz3ccgDwGpm6C3+bz02
         shrR5+FuqsSc7L123q0ucyPxZ9v5m/du25OeG8PbFwsW/VkbUq6pJFbQ7Sq7ilhfgv8D
         /ho8iV8NMQARmP/wxwOEEmFKQDO3GAV+yV+JcmP4OUwzFwwYpqmfj91wpXhKvdBYT3Qh
         1tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025642; x=1697630442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVTN0BqqtO5MKlfxI7sXoH95j77MBJ0QiNgQ07twsNg=;
        b=RlLT3WtVM+4q2y6JQYgwu5OqtuHHkrvJHWpKvVY/cLMOI7kXPTWSOsm003U1y4z7gg
         0M+BdSFQGVpp7h2cA1787LEkpr/A405sFCgU4LCMt6us12XDszoepX+fFbv8h1SgfLTL
         hPmDGWVfTTqY17YAHVHotc5QhvYd/PLJKqhdROkejfzyMv2LeHf0v915DZNrcboYEFaK
         aA5P5TntCpeAKKCkLlnNAUUaO18aJA/acvJ5jG10GGAWEpSunLXs9dX1npmWY46rOxRb
         5YiuQEwUoKUoj0ZsZYFueCGGXAFkukFYG7TH/uk9EP9rLy5u6G5pvPTe8SQAv/4F00CN
         Sf3A==
X-Gm-Message-State: AOJu0YzlPsdLOh/XsjUMCCjn3MfibXUukx07uzzuguJxeomQwDO97qXu
        fijVFEBwDMNrOJZ3UfMnifMfnlckxidRx/fgRgkysg==
X-Google-Smtp-Source: AGHT+IFKnbdS+liyq5BOO9m8ERjMSQL8biVjydd35Z2zaMUPssKf5QQkaQtgJ+ughRnn6bk/oM/oer9yveoYwYchCJs=
X-Received: by 2002:a17:906:19b:b0:9b6:e6ff:b20b with SMTP id
 27-20020a170906019b00b009b6e6ffb20bmr17472854ejb.8.1697025642572; Wed, 11 Oct
 2023 05:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <1697023109-23671-1-git-send-email-quic_msarkar@quicinc.com>
 <1697023109-23671-3-git-send-email-quic_msarkar@quicinc.com>
 <CAA8EJpoLxeSvxjcyq1BMR9XuAffrxLmO-eaBYJ+Fhnb4zYmxUQ@mail.gmail.com> <6531b333-b978-6b97-5cb4-59562d775ac3@quicinc.com>
In-Reply-To: <6531b333-b978-6b97-5cb4-59562d775ac3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 15:00:29 +0300
Message-ID: <CAA8EJpoidaW8x3CAwNLWGcq2fz+x49kQWan2GXkgODUUypzKOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] phy: qcom-qmp-pcie: add endpoint support for sa8775p
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 14:56, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
>
> On 10/11/2023 5:06 PM, Dmitry Baryshkov wrote:
> > On Wed, 11 Oct 2023 at 14:19, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
> >> Add support for dual lane end point mode PHY found on sa8755p platform.
> >>
> >> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 41 ++++++++++++++++++++++++++++++
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h |  2 ++
> >>   2 files changed, 43 insertions(+)
> > Two minor questions.
> >
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> index a63ca74..962b4a1 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> @@ -2147,6 +2147,38 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[]
> >>          QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
> >>   };
> >>
> >> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl[] = {
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_BG_TIMER, 0x02),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYS_CLK_CTRL, 0x07),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x27),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x0a),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x17),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x19),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x00),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x03),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x00),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
> > I should check whether we miss QSERDES_V5_COM_CMN_MODE in
> > sm8450_qmp_gen4x2_pcie_ep_serdes_tbl, which is otherwise nearly
> > identical.
> > Also do you need to set QSERDES_V5_COM_CORE_CLK_EN here?
> QSERDES_V5_COM_CORE_CLK_EN is common for both RC and EP
> so we are using it in sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl
>
> -Mrinmay
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x04),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0xff),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x09),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x19),
> >> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x28),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl[] = {
> >> +       QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> >> +};
> > This is the same as sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl
>
> so you want me to use sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl
> instead of creating new one for sa8775?

If you don't see a problem with that, yes.

>
> -Mrinmay
>
> >> +
> >> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl[] = {
> >> +       QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_MX_CTRL7, 0x00),
> >> +       QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_SW_CTRL7, 0x00),
> >> +};
> > Could you please confirm that these registers belong to the V5
> > namespace rather than V5_20 one?
> may I know difference between V5 and V5_20 namespace
> can't we use V5 namespace here?

Register names are different, see existing v5 vs v5.20 and v4 vs v4.20
headers. So, I'd kindly ask to use the appropriate namespace.

>
> -Mrinmay
> >> +
> >>   struct qmp_pcie_offsets {
> >>          u16 serdes;
> >>          u16 pcs;
> >> @@ -3043,6 +3075,15 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
> >>                  .pcs_misc_num   = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
> >>          },
> >>
> >> +       .tbls_ep = &(const struct qmp_phy_cfg_tbls) {
> >> +               .serdes         = sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl,
> >> +               .serdes_num     = ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl),
> >> +               .pcs_misc       = sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl,
> >> +               .pcs_misc_num   = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl),
> >> +               .pcs            = sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl,
> >> +               .pcs_num        = ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl),
> >> +       },
> >> +
> >>          .reset_list             = sdm845_pciephy_reset_l,
> >>          .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >>          .vreg_list              = qmp_phy_vreg_l,
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> >> index 36cc80b..6ee1c33 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> >> @@ -11,6 +11,8 @@
> >>   #define QPHY_V5_PCS_PCS_STATUS1                                0x014
> >>   #define QPHY_V5_PCS_POWER_DOWN_CONTROL                 0x040
> >>   #define QPHY_V5_PCS_START_CONTROL                      0x044
> >> +#define QPHY_V5_PCS_INSIG_SW_CTRL7                     0x060
> >> +#define QPHY_V5_PCS_INSIG_MX_CTRL7                     0x07c
> >>   #define QPHY_V5_PCS_LOCK_DETECT_CONFIG1                        0x0c4
> >>   #define QPHY_V5_PCS_LOCK_DETECT_CONFIG2                        0x0c8
> >>   #define QPHY_V5_PCS_LOCK_DETECT_CONFIG3                        0x0cc
> >> --
> >> 2.7.4
> >>
> >



-- 
With best wishes
Dmitry
