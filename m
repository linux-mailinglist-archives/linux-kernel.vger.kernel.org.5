Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249287D96D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjJ0Lnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0Lno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:43:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A0129;
        Fri, 27 Oct 2023 04:43:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5720a321aso26167461fa.1;
        Fri, 27 Oct 2023 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698407020; x=1699011820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FxTvodzs+sXyw4G+vyKIEx0C/eMaA77aXx03U9uf0M=;
        b=EHWOkbCK+BwcZVovzxCt+nJEU3LQ3KM8eR5+u/7pf34L4fsKXmOieM0vszRwPx7vlK
         CSom9hGqys18QC47N7KOvlnF4ldxqmtFNUgz9+qLQXoVju8aC/rerveRA+vf9/ief8Jn
         R6j1c3WL84zQD79Ja+DpughczNP9OKbQsmkxUNsoiS+w04hGT8Cm2xraRRI3Hlkzpwl7
         LPOG8hE7AoNGbTGp7pYbUuLNP1iocnKWtOW136bhZz6sCZJiJbMJ52Pxp1OMQ3L+9jab
         wWwMMMh+ZznzJHAcz0vdGHp3pe47DTLTo+iucKRkWFZ/8tWXFgBxoXjCfa5p2rqMrb2N
         1PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407020; x=1699011820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FxTvodzs+sXyw4G+vyKIEx0C/eMaA77aXx03U9uf0M=;
        b=W9VtBKH6SMhL/fDTZ007ixaMWQ8AD5bsqSrY0/5Viy2jO8PuPrD4avqPhXBKetlCnb
         3gqSOBjqIdU4DDEvTXXxpWoVU6eoeMadf2ZOadgRWxViQ/+vclWIKFFxzHGAgEGq1dGw
         a8ugLQfcdz0nvsC/I0B8B41RdDIvavgXBpLWSlE/SaSd2nGjbcq4ARHYdi4HrvHde4+D
         tbkMbmBg7q11EEp/oYN+oPks2pdACT+KZuesuoO5vgQ6eKZFvG+bHPfubArUHMcodwZN
         gxrflY0kG62Q9aFCZhQ/LdGqlmkwo7j+RQKg3hyVpR+AqpdwC31LM7Dj6SfTyLBqLGx4
         c2rA==
X-Gm-Message-State: AOJu0YwiwpcRlmvgz+VhxyZI93XLVfdUVAtijMEGVFI2JVr8ljoqekpT
        boiD4NbN9pHfRdeXpXLSs0I=
X-Google-Smtp-Source: AGHT+IEKGBDUbCDFRGX1kdv/8N+AISeFx74HIk/UjgqrccXfV5jnOCN8ZLdnx0Gcf7r1wAxUT8Mhwg==
X-Received: by 2002:a2e:7c15:0:b0:2c5:5926:de52 with SMTP id x21-20020a2e7c15000000b002c55926de52mr1804330ljc.53.1698407019812;
        Fri, 27 Oct 2023 04:43:39 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s7-20020a05651c200700b002c09602150asm255875ljo.27.2023.10.27.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:43:39 -0700 (PDT)
Date:   Fri, 27 Oct 2023 14:43:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 1/1] net: stmmac: xgmac: Enable support for
 multiple Flexible PPS outputs
Message-ID: <gz5iglkftvoisrpmp2wtglctiddnfwopjo2ozedtlas3yg5vnp@bdgsrbzmmeud>
References: <20231026094856.986796-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026094856.986796-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 05:48:56PM +0800, Furong Xu wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.

Are you sure 3.10a don't have the PPSEN flag available for all
outputs too?

> XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
> always set PPSEN do not make things worse ;)
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 7a8f47e7b728..a4e8b498dea9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -259,7 +259,7 @@
>  	((val) << XGMAC_PPS_MINIDX(x))
>  #define XGMAC_PPSCMD_START		0x2
>  #define XGMAC_PPSCMD_STOP		0x5
> -#define XGMAC_PPSEN0			BIT(4)
> +#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
>  #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
>  #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
>  #define XGMAC_TRGTBUSY0			BIT(31)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index f352be269deb..53bb8f16c481 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1178,7 +1178,7 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
>  
>  	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
>  	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
> -	val |= XGMAC_PPSEN0;

> +	val |= XGMAC_PPSENx(index);

At the very least it would be nice to have a comment here that the
mode selection was available for the output #0 only in the IP-cores
prior v3.20a with the outputs 1-3 always working as flexible PPS
outputs.

Other than that no more comments:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  
>  	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
>  
> -- 
> 2.34.1
> 
> 
