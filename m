Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31926800AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378864AbjLAMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378862AbjLAMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:35:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3D1728;
        Fri,  1 Dec 2023 04:35:07 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9c30c7eafso25883291fa.0;
        Fri, 01 Dec 2023 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701434106; x=1702038906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAJ12ZP/6sikIFKSSmQlShHQawFcbI6eeUcRDaDj6EQ=;
        b=PYFM/DuKm0NGrhD23v+U3Uk4EpSo/F7LSCjilX4k8ZJDwaFSjGeVLOXW2JwtO5N5jk
         IdCyiPtcOki98odsR/tZmdkDNhkOtA4j2Z1B+7maDm6f9fe/KCR4hZxmROgdrSiuXpBz
         9rtC9Tyyl1qiI6pYDP2yz5PYqx+vzAhHCjCXnOxriimgfyc1e1pCtFnhor8v9e3ua/7w
         GB0ZAa9cMIizwgvQeR4Bt/hy1r7E3IEXEW/SV/k2PB5ieNBy7ByVc8qcfcpZAyshvwZp
         YXcIwA5p2B9tVu1xs7wlW6Ch8Co/nsI86T7G4s213OM2XSyfDIwzy1UcyhnzVw7JCpWf
         C9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701434106; x=1702038906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAJ12ZP/6sikIFKSSmQlShHQawFcbI6eeUcRDaDj6EQ=;
        b=TP2QdNGZswOK9xCXcatwvw2uMPshYc0/DYZ2wzCWPTWbPyHsrkhW/RRfT/EwVUGpUI
         54+mCQFmCarrMnTh+nf2MQ/igFaMYJdwXEKhsU3oaUyMiIGabTEHGG2o45DsynHRG6+K
         g8947ZFW2dU1peyXV1AiGJwFjqFxg3verygshwKd5lkRrEk/pb1RH7+6IUfgdPm2oa1S
         Wdc0ix15zL3kmN0JhDrV5kHS6lBMryeDxlTbWsMsAA4fjCvn6G5bifJwuY64msDlgx6b
         eyoBtPnJ742L+fxmynzsoCBEek1X1DANjkmGSsEwgadWVNl7YGtQOeJzpH5XZIFwN3FI
         E5lg==
X-Gm-Message-State: AOJu0Ywyjr0gnz5Ga6eDXWB7LFxGA+K8juhqBT/CBqTAA9oqwDCvBJNq
        kWk/CjBusfPiQcdhGwlkTzs=
X-Google-Smtp-Source: AGHT+IFWvGMZWlpeLzOqlvxU4Iovm3Lrni2kgJ/FhveV1eY9wgfEIZEwE7tYYQ2Va/X639zttJ8beg==
X-Received: by 2002:a2e:8895:0:b0:2c9:d874:6efc with SMTP id k21-20020a2e8895000000b002c9d8746efcmr818380lji.89.1701434105454;
        Fri, 01 Dec 2023 04:35:05 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i21-20020a2e8655000000b002c9b873270asm408702ljj.123.2023.12.01.04.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:35:05 -0800 (PST)
Date:   Fri, 1 Dec 2023 15:35:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <mfcvaq2n2lzsg47nzgk25n5fpmii2ftbx6gkrmz7pkxv6mq4w6@eia6ymhx3wff>
References: <20231201100548.12994-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201100548.12994-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:35:48PM +0530, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.

> [PATCH v2] net: stmmac: update Rx clk divider for 10M SGMII

It would be better to add "dwmac-qcom-ethqos" prefix to the subject
since the patch concerns the Qualcomm Eth MAC only. 

-Serge(y)

> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
> v2 changelog:
> - Use FIELD_PREP to prepare bifield values in place of GENMASK
> - Add fixes tag
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..df6ff8bcdb5c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -34,6 +34,7 @@
>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
>  
>  /* SDCC_HC_REG_DLL_CONFIG fields */
>  #define SDCC_DLL_CONFIG_DLL_RST			BIT(30)
> @@ -617,6 +618,9 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
> +			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31),
> +			      RGMII_IO_MACRO_CONFIG);
>  		break;
>  	}
>  
> -- 
> 2.17.1
> 
> 
