Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E8763D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGZRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjGZRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:18:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6F1739;
        Wed, 26 Jul 2023 10:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690391909; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LmoBsfkprok2JdskejKv8QNRAuiOGUxv4wVVG8V36mVIS9AqZIMiHEhLUZnAebj0+P
    ikBDu3dGq03dcFE7lIlPLyrIMtQKatC+hGIuXxmn/AIjxbHTy0PR+3Us9owUfE+/YMgW
    anywCoec386orfpFprDnt+cpkSBaRyMlleFasJob7G4zhO56rkKlfXWyGHmyEIeSs92f
    sZO70yXi0Yje0m5n8Yst7QW4qOHxxe23aaCsI5vsFrq5UGQdANvXYGrE+yAOmmmxOqju
    E+GI3lRRGfLeWvKg5Rq+jh/ZF20D/JLl/7Ao/9VJQuLnW8h44qO+Aw3RSgLJn/Qc55vg
    9Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690391909;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=r9XmkMSBZZnfjPZy2JUQN2IdCnIr83J3mJ8F/eSuAWA=;
    b=PCrtK4fbSLoltux5qZhSncEERwEuNeuF0upof29rzs6WtdgurQAySWfAPpX03jFURD
    1gpZ1C2yJmZFOl4hnhOyUTyGwYsYcUpSRLrNFR4/3MA81QBAe5jCYNWnMiRi/eIet0ph
    3Pr95qQXRhvU8wpgdM+8NkqBhT8JtnFc8Vkt9pOXAv+yFgSy7oh0//+t4Lz1gtWua2gt
    /M77PVoiMbCd7u00Ew3VmYCwyTb68D+pkTVBaqjSrvHogW86tNO1sdIxmgHF5LWV5NBp
    e7exEpADvnMSiKskfUYuDE1Zk52eRydgbw0vDwn1BMx8UmJF+I9M65kHWOasya8lfeLJ
    g7gw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690391909;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=r9XmkMSBZZnfjPZy2JUQN2IdCnIr83J3mJ8F/eSuAWA=;
    b=B9xdC13OLl1hA8/L46POHzmKE/CBz7QReg3y6HQ6USUYX2E10z6tkVXIrudIxvYyQw
    3TshDP3RxKfGduh118V7FCJuXMtA+eFmHriVp7U3KlJgwEYYWdzlx8K7pPIckpbcaZxU
    9bxFKxHnFNIuoBNJ2dd7XRdvXm1uNWOpSIuv53SjS/HABOtbwPj8aX5dhTHYIF8nfYQ9
    SrZV4VfibXdqBbTx6eesv13doNk1mX0viF6hcKdg0ONgzjeCcyfV543wd9VfaV1w6d4E
    OXu8ZY5vUPm5O2mc97MQKNQyh1OKtYh6pMBOF7O7VlB4v+g5E620/YGSXQD0Y73LGraa
    ++Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690391909;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=r9XmkMSBZZnfjPZy2JUQN2IdCnIr83J3mJ8F/eSuAWA=;
    b=9MSTBmmsVO5k3GG845I22dBGqIesjpzQmXM5U8Vc0dpxWlnS37uUqjZLR5srCaDnYA
    eRRjrZ5g/EP18XR9lAAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QHIT8Er
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 19:18:29 +0200 (CEST)
Date:   Wed, 26 Jul 2023 19:18:28 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Set AB coefficients
Message-ID: <ZMFVZJa647SNwrJX@gerhold.net>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:25:44PM +0200, Konrad Dybcio wrote:
> Some buses need additional manual adjustments atop the usual
> calculations. Fill in the missing coefficients.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

What about the funny util-fact/vrail-comp on the mas-apps-proc node
downstream?

Thanks,
Stephan

> ---
>  drivers/interconnect/qcom/qcm2290.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
> index 3c3b24264a5b..457e5713ae43 100644
> --- a/drivers/interconnect/qcom/qcm2290.c
> +++ b/drivers/interconnect/qcom/qcm2290.c
> @@ -1198,6 +1198,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
>  	.regmap_cfg = &qcm2290_bimc_regmap_config,
>  	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
>  	.qos_offset = 0x8000,
> +	.ab_percent = 153,
>  };
>  
>  static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
> @@ -1324,6 +1325,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
>  	.bus_clk_desc = &mmaxi_0_clk,
>  	.regmap_cfg = &qcm2290_snoc_regmap_config,
>  	.qos_offset = 0x15000,
> +	.ab_percent = 142,
>  };
>  
>  static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
> @@ -1339,6 +1341,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
>  	.bus_clk_desc = &mmaxi_1_clk,
>  	.regmap_cfg = &qcm2290_snoc_regmap_config,
>  	.qos_offset = 0x15000,
> +	.ab_percent = 139,
>  };
>  
>  static const struct of_device_id qcm2290_noc_of_match[] = {
> 
> -- 
> 2.41.0
> 
