Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8AC78104E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378620AbjHRQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378704AbjHRQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:25:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC1422A;
        Fri, 18 Aug 2023 09:25:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so1644072e87.1;
        Fri, 18 Aug 2023 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692375922; x=1692980722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8pEiMFERjLgVh4C9AUlgVVF/u9ST2sS9FY068sp55M=;
        b=FprSxqxmAgSGctTLQ28PwyU5HnddBxkUcfvSL95K4ZhhU1gqy2dwN+G6F/1E3tV5/d
         spD0XxDeF6i75U5RD/9vNC2bpwikfuivVB0ej4qHJaCrsmKcmGmL1vREhUEExLZLBp20
         CYJoZ6hfW5cihsut2AYrThepT8/JJ1MI6ij4NeXFP2J1RKqTRjiR97UWj9rXOaq4FeFU
         mzcW1F5w7dLB3D2L0DWFT26Vz6UVm0r/gH3gUWXGrRUJ8QtPTk3vv2jRhZ1Bvh+816iz
         IYyMvy7eQHlLTA7KLinypQwOv1J+aTczBxfI4KaxTHUE4wP+0I3ujUurxoIZfvhJV4z8
         7jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375922; x=1692980722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8pEiMFERjLgVh4C9AUlgVVF/u9ST2sS9FY068sp55M=;
        b=CcO850ymmteobB7qO2COaA9cU4ljpz8+zRVTehpNzXRdMEYzG0uz1hotImFuMbBIo2
         0J+m+dCzY/hd4AY1KAY8s6mu6FPlvBNw/qiPqciI4NYYoJjAAHJLjtZMykDyX/a2P1KU
         PZa6tjLE20BUj8V5Az+vikUgxqDzG1h3XiiThum13X+3S5CSN0cGiG4hgyM0dTSwyiI3
         goOxCm9MY4RwXU9nS98YSyATI/ajMXeiHj/WotXB5yik/HTko7qtroemZVmtHfDpoPuS
         12637gTHT/m1U1gxHeyWmLThc7HIJMRCZw4uQH1t0sIlGKf4x11tU6RR2UhjfXktiHih
         61LA==
X-Gm-Message-State: AOJu0YxazF9OeGCRMbPfwfU94KKHG0NeW+/CnIfE9IAdYFTamhLmTvOX
        8EUpjbBdAYrEJhy6ciNmwdk=
X-Google-Smtp-Source: AGHT+IHHD2GbCfI74fDNGo4DfOBaJf7xvPPj6QcGsKYq2G/vvkEdZSQJ6smybkTbm7yqRPhd6BjRvw==
X-Received: by 2002:a05:6512:2822:b0:4f6:2317:f387 with SMTP id cf34-20020a056512282200b004f62317f387mr2462526lfb.35.1692375921947;
        Fri, 18 Aug 2023 09:25:21 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id eq19-20020a056512489300b004fe1bc7e4acsm395877lfb.131.2023.08.18.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:25:21 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:25:19 +0300
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
Subject: Re: [PATCH net-next v5 2/9] net: stmmac: xgmac: add more feature
 parsing from hw cap
Message-ID: <ytrtxlidqp4blp5gfrgnnirtosjes7mcjkbdvcm7lmvnpkm7ut@e5tuy3bx2cd5>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817165749.672-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:57:42AM +0800, Jisheng Zhang wrote:
> The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> or not.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3aacf791efeb..1ef8fc132c2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -410,6 +410,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>  	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
>  	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
>  
>  	/* MAC HW feature 1 */
>  	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
> -- 
> 2.40.1
> 
> 
