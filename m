Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EFE7E3FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjKGNMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjKGNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:11:50 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380242D67
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:08:54 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5b3b17d36d5so56495717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362533; x=1699967333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbx/UynaS38IRg6RqSnz8/nqPOY3sS3Z4B+scjr8meY=;
        b=LK8RdlK423GlR5d0BTGiAE8B4nNIW6ouR/poIYvanbD3Iv9jr0lMBxoctpS6i4Bw1O
         z1qppQoekziHWvOlvOlBOAex5MfIyJY6LN6Wr1pmB/i5kerVYgVwhdl6CJx1wtAjH8Lj
         NKYVT4YH0vZYekiyCkll0LyqV1unmZ6pYVkjnXNg8oWzH4QsoeiuhLGMiSRf3dzQLp3X
         uomRfSY4dqYO5sdU69jb4OrsYQ58ZUMSqhIBgaK9lYd/VVQXzDd4T7MKdHyVrnPUZjlA
         MF//5Qz7EQqBCwONAzrzdbB4FqqEMdyYmIhYWivDlPqKKlEsptb2nACJ5y6GWzGSIERu
         dZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362533; x=1699967333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbx/UynaS38IRg6RqSnz8/nqPOY3sS3Z4B+scjr8meY=;
        b=Eqv5kBHX/rGAUuvQz1hdTU0DPfNk1uD1H9vhUhc2yuLZHisHw+3/D6fyiKAJZ3Vc/l
         BbdcZyFug/5GFITxBFCJaiLG0VK36wlDe42FD1BWXRLpeH2Ld5Q301I2zipjqQXO5gwx
         cFI/UXRrb9dIyKMbCIiwA7SWDIqJXzYNkW9Ym821JWpEqd2uf4kZG4K73pevMrJYcouf
         FpaNRNkKvJOEM1UGsXniJhcCFR/NcTjEH9lO6Py/40uZ+wqz9WcNEwaWfuTMO5d74ggM
         gWEE23vWer5EcZR3N9jhlkkIJ2pKK8TehStfI1+3yD16fP3A8ujoRL8heES6CjtwGzRX
         PyRw==
X-Gm-Message-State: AOJu0YzUaqcnhpt/P7l9IxiG1IIQ32eBOkIt0vGFxF4lgRuwym161jzZ
        5qGp2WkenJ9ffS2GTa8Q+8d1U0ExqPspiNs7JQUOWA==
X-Google-Smtp-Source: AGHT+IELQi9sG90iFpA9loHvBjUJx0r9EJFbAMFv8Z46iVDiHRl4G0EmCSSc86dZtYBzCJ5XkBrXYS2Xo1C3aXEOwXs=
X-Received: by 2002:a81:9846:0:b0:5b3:4c7e:7473 with SMTP id
 p67-20020a819846000000b005b34c7e7473mr1656944ywg.17.1699362533189; Tue, 07
 Nov 2023 05:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com> <20231107-refclk_always_on-v2-3-de23962fc4b3@quicinc.com>
In-Reply-To: <20231107-refclk_always_on-v2-3-de23962fc4b3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 15:08:41 +0200
Message-ID: <CAA8EJpp1ObZjmX65TctoPo7ywvFBguFND2LcmTq3Dhcj=3vstg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] phy: qcom-qmp-pcie: Add support for keeping refclk
 always on
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 14:26, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> In PCIe low power states like L1.1 or L1.2 the phy will stop
> supplying refclk to endpoint. If endpoint asserts clkreq to bring
> back link L0, then RC needs to provide refclk to endpoint.
>
> If there is some issues in platform with clkreq signal propagation

Nit: there are

I'd rephrase this in the following way:

Some platforms (e.g. ABC DEF) fail to drive the clkreq signal to the
host (because it is unconnected ?). Due to that...

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> to host and due to that host will not send refclk which results PCIe link
> down. For those platforms phy needs to provide refclk even in low power
> states.
>
> Add a flag to keep refclk always supplied to endpoint.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 74d03d217ff2..a8d6d69e3f74 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -43,6 +43,8 @@
>  /* QPHY_PCS_STATUS bit */
>  #define PHYSTATUS                              BIT(6)
>  #define PHYSTATUS_4_20                         BIT(7)
> +/* PCS_PCIE_ENDPOINT_REFCLK_CNTRL */
> +#define EPCLK_ALWAYS_ON_EN                     BIT(6)
>
>  #define PHY_INIT_COMPLETE_TIMEOUT              10000
>
> @@ -2264,6 +2266,8 @@ struct qmp_pcie {
>         struct phy *phy;
>         int mode;
>
> +       bool refclk_always_on;
> +
>         struct clk_fixed_rate pipe_clk_fixed;
>  };
>
> @@ -3179,6 +3183,10 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>         qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
>         qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
>
> +       if (qmp->refclk_always_on && cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL])
> +               qphy_setbits(pcs_misc, cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL],
> +                            EPCLK_ALWAYS_ON_EN);
> +
>         if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
>                 qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
>                 qmp_pcie_init_port_b(qmp, tbls);
> @@ -3701,6 +3709,12 @@ static int qmp_pcie_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_node_put;
>
> +       qmp->refclk_always_on = of_property_read_bool(dev->of_node, "qcom,refclk-always-on");
> +       if (qmp->refclk_always_on && !qmp->cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]) {
> +               dev_err(dev, "refclk is always on is present but refclk cntrl offset is not present\n");
> +               goto err_node_put;
> +       }
> +
>         ret = phy_pipe_clk_register(qmp, np);
>         if (ret)
>                 goto err_node_put;
>
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry
