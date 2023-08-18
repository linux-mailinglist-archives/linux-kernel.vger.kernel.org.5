Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490AC781064
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378650AbjHRQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378686AbjHRQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:30:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782343C04;
        Fri, 18 Aug 2023 09:30:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso17065431fa.1;
        Fri, 18 Aug 2023 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692376218; x=1692981018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eheCIS04D13KaOD9ehF57VdxTh/Aid9micuha4mFfwI=;
        b=bm1OIoZF+N/0pR6uhBIgHqro1wEgHCwG2roK5pR+7dvPY86+5o1oF8rjLSgg3/v3pf
         K3GLdutOTTmZd4FaPgmqs/4n9Ryh5afHlID53jO++DSexu0EslNuobTXBj1bBRHyoKve
         fkao5T/UFNqSh19HRJDYUzBtec189sgfQht37m6dg4EE53v8qeGgdva7ZSjRzwyguUbA
         UUvEil4x4+eTJpPBp1yAEEDUucHylIcpICsHNCl76+Hh+ZsDOwvryUV3scQScnglKzNw
         Z7JG9wRc7UAR1XiPInkdB5JU5SRNSDXqke50RyjZ2Smet/p6rl1cRUH6ie0uVsPuaGF/
         dn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376218; x=1692981018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eheCIS04D13KaOD9ehF57VdxTh/Aid9micuha4mFfwI=;
        b=YBWIMAsi/q0zGjUP8wFcrAsAJwp0raZFeYmvrBuxz4hxMN100O7BmbmAOHfTOkGwl3
         uV4I9FKK5ngearqg1BEbWejQaWayBNt0ABoLyST4qNipI1kCXebWhra3h2x/WIzlRqNd
         RvAX9ECGnsd4J6xMn4/X+5hFypZdYSO9yFSF2CjxSLH9IejXfOaR94T2afHtaZhTR2mN
         uTr1v3R46a9BPINUDPymTRIroljgNzbDyc6QRUFFbz5SdKYrein9UN+bOlpWngkr8Prr
         Vh4eq8YP3OfzLY846afVTMVRtmUpLMlMVghRiE4cQvi5+7s2TkrNBO/sXUwEajsukD7/
         p78A==
X-Gm-Message-State: AOJu0YzYmnJ5pEJb937cYJqmYsHirVShl+/VFGNU6AZr9qbjvuLB61e5
        Ep2fbKouApGYbnetDgg6FTc=
X-Google-Smtp-Source: AGHT+IE3GZW+T8zAUVoDtd05y8Z1fKjILRcAs0GZ+hu92/OvbJyo77ITTd/bg0dRfdqbJsDjJhPL3A==
X-Received: by 2002:a2e:3012:0:b0:2b9:44c5:ac15 with SMTP id w18-20020a2e3012000000b002b944c5ac15mr2353531ljw.41.1692376217611;
        Fri, 18 Aug 2023 09:30:17 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id u13-20020a2e9b0d000000b002b836d8c839sm518099lji.40.2023.08.18.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:30:17 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:30:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 3/9] net: stmmac: enlarge max rx/tx queues
 and channels to 16
Message-ID: <xuy7jenzuseth4rwbvqbpb4db3r6ynzagpcrt37kcme7r4izqq@wltdeqwmybpw>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817165749.672-4-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:57:43AM +0800, Jisheng Zhang wrote:
> xgmac supports up to 16 rx/tx queues and up to 16 channels.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 ++---
>  include/linux/stmmac.h                              | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 38782662ff98..8ac994553bc1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -232,9 +232,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
>  	void __iomem *ioaddr = hw->pcsr;
>  	u32 value, reg;
>  
> -	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
> -	if (queue >= 4)
> -		queue -= 4;
> +	reg = XGMAC_MTL_RXQ_DMA_MAP0 + (queue & ~0x3);
> +	queue &= 0x3;
>  
>  	value = readl(ioaddr + reg);
>  	value &= ~XGMAC_QxMDMACH(queue);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 784277d666eb..9c90e2e295d4 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -15,9 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  
> -#define MTL_MAX_RX_QUEUES	8
> -#define MTL_MAX_TX_QUEUES	8
> -#define STMMAC_CH_MAX		8

> +#define MTL_MAX_RX_QUEUES	16

In DW XGMAC 2.11a (Databook from 9.2015) number of MTL Rx queues is
limited with 12:
Number of Receive Queues	Description: Specifies the number of receive queues.
				Value Range: 1–12
				Default Value: 1
				Dependencies: This option is not available in XGMAC-CORE configurations.
				HDL Parameter Name: DWCXG_NUM_RXQ

Are you sure it's different in your case? Do you have a Synopsys HW
manual with the DWCXG_NUM_RXQ parameter range limited to 16? What
IP-core version is it about?

-Serge(y)

> +#define MTL_MAX_TX_QUEUES	16
> +#define STMMAC_CH_MAX		16
>  
>  #define STMMAC_RX_COE_NONE	0
>  #define STMMAC_RX_COE_TYPE1	1
> -- 
> 2.40.1
> 
> 
