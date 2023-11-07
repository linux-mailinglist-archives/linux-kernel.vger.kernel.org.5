Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C144E7E3FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjKGNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjKGNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:12:14 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65281997
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:10:22 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5b31c5143a0so67468997b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362622; x=1699967422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wm1Mb5/Vjq9aMkJlsrjTa8/I47O6pvYgHKx9Bcn4a/Q=;
        b=GMhePyp1xSjoCtMzDE13LEVP1aNRD09yC5boje5juuXie05U1E7JcwHAuYp6cMJIEQ
         O58QaTxVxhwvfh3deAsZBik+Et4fRdy+WnI2yMVNtYlgscFkRWkr94NxIaUWTHKqr+bh
         jwR6jv4pqvYaM9ZwKZ3QZSJJoTGlr50iTsx9zicd0otcH+abyYyO9U6b29x3+Df94zQw
         hkMYFAd4dJxHRmTCe5cR3TWrpBrEshrQOUSE9rakadtSUilUEUftY9EGx+h0nVeMvxqf
         3Y1X4kSdPffdpC3CzTPrEHxbDb5Yu+n20XNBl2VZpErC4KjvJHS26c8TLSefY/Yrn+sS
         lHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362622; x=1699967422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wm1Mb5/Vjq9aMkJlsrjTa8/I47O6pvYgHKx9Bcn4a/Q=;
        b=HfNiGocz8Xj1Fz7XmDJBpb/mKgK5y4hSjLUBJ7FbP6ddP60AH4LqZ2UcVcpeS1DOmL
         KtmVgerLJcUaMGOEVgRIds141lvGvvQ9HjBo4LCf/k1s/70xbwsqmKhKkmA3lkPatBOR
         Lppj1FIfcMdTQYOFjtR7/tEOBaGz4MbQCXhawd0CNLVyQE4WKCwmK3UceN8xnoFuwu/4
         yEzijFQeCUwKGBC2reOzTnJT8cEL3UCvUkXIKPxj3Jhc9izqch5MBenykx0FM8SMKhq4
         snx708aCr2C95VhwjT/aLa0Cb6AJHqt1BaXM6XVDCYnDEXVONr726EE84RC25yXP9qhh
         z0Pg==
X-Gm-Message-State: AOJu0Yxi6Ax0rdftOecyMDXBQhd8y+EyM+S90kmMJx2LV7c1VOoColFM
        W7plazBcpCQ6eSqk4cD45EQ/ksbcgLN98aK22eyQTw==
X-Google-Smtp-Source: AGHT+IF5Y2PdTK3EgzgxLoQDJvc7JWtJeaqzhWMhuNj03yIKxJpo/mL6Uhb0mf5EVPARRWo8zNGIUpAEY6Ec32rjXXY=
X-Received: by 2002:a0d:d48a:0:b0:5ad:4975:c860 with SMTP id
 w132-20020a0dd48a000000b005ad4975c860mr13979075ywd.39.1699362621854; Tue, 07
 Nov 2023 05:10:21 -0800 (PST)
MIME-Version: 1.0
References: <1699362294-15558-1-git-send-email-quic_msarkar@quicinc.com> <1699362294-15558-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1699362294-15558-2-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 15:10:09 +0200
Message-ID: <CAA8EJpp4E7L0JZjj3mT_2SQHeA6az9uwtaF3_diZ_McpGRg-Jg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] phy: qcom-qmp-pcie: add x4 lane EP support for sa8775p
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 15:05, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> Add support for x4 lane end point mode PHY found on sa8755p platform.
> Reusing existing serdes and pcs_misc table for EP and moved
> BIAS_EN_CLKBUFLR_EN register from RC serdes table to common serdes
> table as this register is part of both RC and EP.
>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index b64598a..7114b4e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2099,6 +2099,7 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_pcs_alt_tbl[] = {
>  };
>
>  static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_serdes_alt_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
> @@ -2125,7 +2126,6 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[]
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
> -       QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
> @@ -3114,6 +3114,13 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x4_pciephy_cfg = {
>                 .pcs_misc_num   = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
>         },
>
> +       .tbls_ep = &(const struct qmp_phy_cfg_tbls) {
> +               .serdes         = sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl,
> +               .serdes_num     = ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl),
> +               .pcs_misc       = sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl,
> +               .pcs_misc_num   = ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl),
> +       },
> +
>         .reset_list             = sdm845_pciephy_reset_l,
>         .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
