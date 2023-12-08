Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0380ADB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjLHUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6910DE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702066832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FTOMdJpRPbHn3vU2n7KIGDnUrhFTCYmrUCTOtwVngI=;
        b=cs6SIN5CJCz/XVfYUqt6W3ikgzWUwKWFMfTPRXBUzw+9b9DH/cmdUOyCJwrrtEgABSgAI7
        vx5fqix0eSngmTstqqLL2Ud6/OPmbd8U+XSxcaIZbCNTNasw3mxQRjbuFlTX9O/P5ZdHbs
        Qs6Ehm2l0wp0l1ClmaBgN74IIxep1p4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-aQhax1o0OKCudPqc9tEJCw-1; Fri, 08 Dec 2023 15:20:31 -0500
X-MC-Unique: aQhax1o0OKCudPqc9tEJCw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb33566583so4843907fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702066830; x=1702671630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FTOMdJpRPbHn3vU2n7KIGDnUrhFTCYmrUCTOtwVngI=;
        b=UjrBgtnXkCgwFdpqMW9CgfiCzL2mnNCMRxkcRml2CohbZYomlbC+AdZbFqCDD8ZgTw
         CPy/Yv2pEuhDqERCxBSYHc37Gp/FdpUPAZqHyVJKBx8EZ0D2xet+N71GKWD/+KIcaw4x
         AGr9xVI7hvaGYVLQyc7CIVP4SdjGph3MegMr43+E4gvNybFdqM9vUrwAF+GRMUw7MNTm
         twWmLv5+6i0apMGfVWBDvHiX2YbfVuUvkz8TN3sfiOcxzYBknoHfas02u+oypw4NWMyg
         joBY6gpoFAj8eLpfCDfxIRKCZqzMJzW04z0EwbCu1inHoi2LlrMrIf2j8OU34f/Dn++K
         7chQ==
X-Gm-Message-State: AOJu0YxrCoeh8yRo6gGeWo13D4JeVqjOHvh7H28jEaFQb/FsdSlYDRB8
        pGRYRRIWPqhvHRfeUYu1UydfE6X4zjGCHWft7wXG9gkr+FMuKYHVOL34ChHFOdTX6Zn7M5YrSQ5
        HTqylypPRgdE7ODoLQj6vTqvM
X-Received: by 2002:a05:6359:4585:b0:170:17eb:9c51 with SMTP id no5-20020a056359458500b0017017eb9c51mr481917rwb.50.1702066830542;
        Fri, 08 Dec 2023 12:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWmk2lhCMiTr98WkK9KeFFVT1gu2su5EkI3YZa49gE9uU8KYl5h62TvxFqSxd5sJ7laeJbw==
X-Received: by 2002:a05:6359:4585:b0:170:17eb:9c51 with SMTP id no5-20020a056359458500b0017017eb9c51mr481899rwb.50.1702066830252;
        Fri, 08 Dec 2023 12:20:30 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id po8-20020a05620a384800b0077f0a9ec24bsm927364qkn.105.2023.12.08.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:20:29 -0800 (PST)
Date:   Fri, 8 Dec 2023 14:20:27 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
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
        kernel@quicinc.com
Subject: Re: [PATCH net v3] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <2yx7snbvbvjycuszzonmwxokr4pvqslz2bpy4eoyrri5tzlymb@t3t23x7eeknq>
References: <20231208062502.13124-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208062502.13124-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:55:02AM +0530, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.
> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")

You didn't add my:

    Tested-by: Andrew Halaney <ahalaney@redhat.com>

from the last version. Typically that's fine to do even if you post a
new version as long as the changes are minor (in your case it's just the
comment that was added since I tested, so definitely fine to do).

> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
> v3 changelog:
> - Added comment to explain why MAC needs to be reconfigured for SGMII
> v2 changelog:
> - Use FIELD_PREP to prepare bifield values in place of GENMASK
> - Add fixes tag
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..ab2245995bc6 100644
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
> @@ -598,6 +599,9 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
>  	return 0;
>  }
>  
> +/* On interface toggle MAC registetrs gets reset.
> + * Configure MAC block for SGMII on ethernet phy link up
> + */

s/registetrs/registers/

>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  {
>  	int val;
> @@ -617,6 +621,9 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
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

