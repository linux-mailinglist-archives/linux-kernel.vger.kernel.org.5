Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5747FF70B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjK3QvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjK3QvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:51:06 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81010FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:51:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cd97d7272so6738601cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701363071; x=1701967871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utw4KTuk3SE3y1D2yo/rUQfAbbyptZOivZr+Lu23J1Q=;
        b=s3lDIpU4ZslyYJA40bcye3JGJKwYGx+ApO2ie7Ij+OqFR2hRvCZlyw0n6oOaHuT0HG
         +g84gB8DNbYhRXaxzO0+4gFvpUSmWljw3tD0j7ITPTgKg6yJMNWaGsU9nApr651dIjfo
         dnPaAzZsUsgUuXt2++RKiUOumuoKb40qN1TGRw3FY3/hYeshf0FllcdSAw4pxaYdOML4
         CTD1ovhh11v0rO+uOKRfiOC+qTmudiqhT9u7+LXLzUBhJVEqQ+OiDQYKTvgM+QR7irJY
         1SNEbnv5q+ZFRSaHmPdhbwCNKEayL99h4HQGTFajaMl++vO2Wqoj//o90Cw+9ZXh8knN
         H2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363071; x=1701967871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utw4KTuk3SE3y1D2yo/rUQfAbbyptZOivZr+Lu23J1Q=;
        b=lgW8DYbStPMMk9h4kG5LHQRJT+66pbF9uKvCxYoWo6i54ob5N4oo/XpspjB2vWtJS/
         8x9CdRCwo4KDeq+HYTTkucxYYasPr8iwbVsQGNEOtHnWXgyT4qfNVAqas6egUTuodkV7
         UE+6YtQcDRx8hE+tCIznQiUJd1o6D4Oc6VAnSEn/RrrSKHKipX3hUY2tYVwSD/t+1T81
         cy6kxKgtlkqgvgg78cA5fvbJT0ypohhS4Qd64mVo/vQ2wjeXoMwuwBS8qafB8ItpzrN7
         gG9tSXN4qOYP8nnQBm0dDTFAKEWiiqOELKFX2JVaHMXipKIUX7Zo3qxrLTsEqjFH31kY
         7yPA==
X-Gm-Message-State: AOJu0YwJ5HgIxPw4OHOBFx09qkq3iqfxJcTuGzPyaJGJNhVvBglbFbQ+
        2jKb8MSRJIz7qUPS1hOK/VdL
X-Google-Smtp-Source: AGHT+IERXWT08jVAe9ZbWDR/pNrAJrgo4gr7lr9NP15/wA+iYSlr52t4YrQ+Anua7VoZTtf/uwzbgA==
X-Received: by 2002:ad4:4c07:0:b0:67a:2bbe:a02a with SMTP id bz7-20020ad44c07000000b0067a2bbea02amr18478142qvb.57.1701363071661;
        Thu, 30 Nov 2023 08:51:11 -0800 (PST)
Received: from thinkpad ([117.213.102.92])
        by smtp.gmail.com with ESMTPSA id y2-20020a0cd982000000b0067a34deb15asm649952qvj.9.2023.11.30.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:51:11 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:21:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v4 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Message-ID: <20231130165100.GV3043@thinkpad>
References: <20231129214412.327633-1-Frank.Li@nxp.com>
 <20231129214412.327633-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129214412.327633-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:44:12PM -0500, Frank Li wrote:
> In the suspend path, PME_Turn_Off message is sent to the endpoint to
> transition the link to L2/L3_Ready state. In this SoC, there is no way to
> check if the controller has received the PME_To_Ack from the endpoint or
> not. So to be on the safer side, the driver just waits for
> PCIE_PME_TO_L2_TIMEOUT_US before asserting the SoC specific PMXMTTURNOFF
> bit to complete the PME_Turn_Off handshake. This link would then enter
> L2/L3 state depending on the VAUX supply.
> 
> In the resume path, the link is brought back from L2 to L0 by doing a
> software reset.
> 

Same comment on the patch description as on patch 2/4.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v3 to v4
>     - Call scfg_pcie_send_turnoff_msg() shared with ls1021a
>     - update commit message
>     
>     Change from v2 to v3
>     - Remove ls_pcie_lut_readl(writel) function
>     
>     Change from v1 to v2
>     - Update subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 63 ++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 590e07bb27002..d39700b3afaaa 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -41,6 +41,15 @@
>  #define SCFG_PEXSFTRSTCR	0x190
>  #define PEXSR(idx)		BIT(idx)
>  
> +/* LS1043A PEX PME control register */
> +#define SCFG_PEXPMECR		0x144
> +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> +
> +/* LS1043A PEX LUT debug register */
> +#define LS_PCIE_LDBG	0x7fc
> +#define LDBG_SR		BIT(30)
> +#define LDBG_WE		BIT(31)
> +
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
> @@ -225,6 +234,45 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
>  }
>  
> +static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
> +}
> +
> +static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +
> +	/*
> +	 * Only way let PEX module exit L2 is do a software reset.

Can you expand PEX? What is it used for?

Also if the reset is only for the PEX module, please use the same comment in
both patches 2 and 4. Patch 2 doesn't mention PEX in the comment.

- Mani

> +	 * LDBG_WE: allows the user to have write access to the PEXDBG[SR] for both setting and
> +	 *	    clearing the soft reset on the PEX module.
> +	 * LDBG_SR: When SR is set to 1, the PEX module enters soft reset.
> +	 */
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_WE;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_SR;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_SR;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_WE;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	return 0;
> +}
> +
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
>  	.pme_turn_off = ls_pcie_send_turnoff_msg,
> @@ -242,6 +290,19 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
>  };
>  
> +static const struct dw_pcie_host_ops ls1043a_pcie_host_ops = {
> +	.host_init = ls_pcie_host_init,
> +	.pme_turn_off = ls1043a_pcie_send_turnoff_msg,
> +};
> +
> +static const struct ls_pcie_drvdata ls1043a_drvdata = {
> +	.pf_lut_off = 0x10000,
> +	.pm_support = true,
> +	.scfg_support = true,
> +	.ops = &ls1043a_pcie_host_ops,
> +	.exit_from_l2 = ls1043a_pcie_exit_from_l2,
> +};
> +
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
>  	.pf_lut_off = 0xc0000,
>  	.pm_support = true,
> @@ -252,7 +313,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>  	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
>  	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> -	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
>  	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
