Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A080C56C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjLKKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLKKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:00:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523E0B7;
        Mon, 11 Dec 2023 02:00:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50c05ea5805so4955479e87.0;
        Mon, 11 Dec 2023 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702288822; x=1702893622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGMaAvNkf13KTNtEI35Ww6Ch0iXZrDDVN4YHlrZP/Rs=;
        b=IElQ2OjfXuPDAeGOMZ/EjnU4S7AWtOwqIGT66jNwoiiWeDjeLJdZFjD02yJlhw5r4U
         kUGB6YDTpTCwCu3ZdZh1jH8QbWh5KZjNHr7IOp4qRv/NXpYhIhYyKbvrSPM/zwlkiCbJ
         lA9mF1usqnY2IJoofJsb2prLqrzsaXMqHMivdSsBN0VYpFkqXvqvv5fhUq/4hOJvOp1e
         UTiQbQEgOO5iUg3zBmWJRqfl9wRKh+py2zRXz0sL5WhCv7wtYHn7yZDB1Q+0krOKVsI5
         RDwJr1vGychsEnmVI0tJYX44xz35/M3dAK3IHoYjrwyLDhFQZI2pc5LOR7b5rck0gSgx
         pctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288822; x=1702893622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGMaAvNkf13KTNtEI35Ww6Ch0iXZrDDVN4YHlrZP/Rs=;
        b=UGY7Ug33pEF5XYf3llA48m0K+/evE6G7D6qwtj9XEtKq8f2NckrV4+NHDTRp8286ag
         1VExxR//IoQdPFfFK+/QM/dTkyVH4LLUYG/hjb11Ugs7Jwe2z5AdREEqtVhbjCJn30Z6
         VuLAa4/x6KfHGExOVx9Y07YQDDz/+f1wC3u1koeeL1rsrT3NptdamcaOqpVEeMDGmEIu
         39RBHwCoZ3+9ms77CRFC6HvR7BFto94TK9mTnq8mvuLTTZeu06twh4rq2rmdOBzgONOe
         VDQ6mAJNkiCj0vz/PiN2GrSPwg4NxDAf5/2tH2/ea//t2CvcIcznFviwI3HRHm2qfTRE
         hDVw==
X-Gm-Message-State: AOJu0YwGtp2jVxnV3RKcfYI96/VHRdN7AMCJ866th5/G1hJawl6JRLh1
        tC3khC9YbNu+gVzqxF07wmk=
X-Google-Smtp-Source: AGHT+IErNr5wT1OqJdBAWPwdSo/P2wNmv6BuRcCssiJsnTb1QT67Tto3UHYRZ37cvI4cE2N9nqUJaQ==
X-Received: by 2002:ac2:47ee:0:b0:50c:a39:ee20 with SMTP id b14-20020ac247ee000000b0050c0a39ee20mr1781746lfp.103.1702288822181;
        Mon, 11 Dec 2023 02:00:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id dx5-20020a0565122c0500b0050bfb2d3ab8sm1049986lfb.305.2023.12.11.02.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:00:21 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:00:18 +0300
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
Subject: Re: [PATCH net v3] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <3bwuo4lpo5h75wbscsgi2jtn5ex45vx5fvezocwjbetnbwriyr@ltdd5axuri6e>
References: <20231208062502.13124-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208062502.13124-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:55:02AM +0530, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.

One more time:

> [PATCH v3] net: stmmac: update Rx clk divider for 10M SGMII

It would be better to add "dwmac-qcom-ethqos" prefix to the subject
since the patch concerns the Qualcomm Eth MAC only. This time don't
forget to do that on v4.

-Serge(y)

> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
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
> 
