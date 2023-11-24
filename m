Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDA7F7A03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjKXRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:03:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE203D59;
        Fri, 24 Nov 2023 09:03:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cd62472dso3291345e87.0;
        Fri, 24 Nov 2023 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700845427; x=1701450227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKb6+bJzwF1yVBhWWW80XyJQx4h4KUg59OSYpW9sau0=;
        b=WjoEaUZ4wJ73dYA0hN85Q5UYN4itlCaXUo50E7ES5M8trOlAkLha2Cq3BgRFqu+SBy
         +K+lTTn7Q5aEqRT2hZUH341Tw3AUJ+KJxRSBQrShjIxTQnZ/CvZ0Te/l/R9UwhRYczPH
         DHtXYHe8ThwoOgLPCgAM+Ly/93Kqn/lffSJ6x7lz2U7VxmKzbksTTy7/WqLlpnPVqgRN
         rCILhfNtduSxfR8KTeVTTbnr8CB8krA1A1XknffSW8CQboqvL0RuMKjLuKaaShkarKlQ
         Uw/EPySeH1y70xxWTNSs7iKXafCjBJlY9gyD9/BxTpuWSiJWzBLCzoxbpWiFqcZ4rGrV
         WLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845427; x=1701450227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKb6+bJzwF1yVBhWWW80XyJQx4h4KUg59OSYpW9sau0=;
        b=fQw9WlS/qsP+iR4+ns+nfrU7/KpeqQcxUKq5FwT20DidGpq96/vvnt3+U0F1l7AAG8
         5tkBB83EMEq8JEPxhCHND7D/dyWy3fjIHLyjfn3FSGsVcJ4utdRUtcG+Z+lP4XPLe5uz
         zGVNxj9eDKuatNCOJ4Ad7Y78Uc3Fcml0kfyYfcfhZaeVpQyfhdbDzfXwGDQAYgeiS+KP
         rSrar1UNSmcuopPw3tm8tp8/G4DrfSHZOjrk9BCmTkKhbIrlSJW/hX6uBHHn4Lor8aMi
         tBgvP0bVnWCDt2bv98wKIAXSv2R7P8gq8yyYam+yVLYYl5wAiROzp1aMY71Tl05gXXAz
         GG0w==
X-Gm-Message-State: AOJu0YzuAR6wVx7Z8h9eKRZJ68hPbnQWaMmx7P+quZ3jMkR4pOkRXlpB
        Oh8tmZ7FASNr5N6fWPm6OkQ=
X-Google-Smtp-Source: AGHT+IEtnKziwkAifA6Pi4ayVnqNFBNuXRhrHhPsgP/A1MkmG9je86T4pW16Mqx5OkVnvjGwh+QKVQ==
X-Received: by 2002:ac2:43a6:0:b0:50a:a8d4:25f9 with SMTP id t6-20020ac243a6000000b0050aa8d425f9mr2118002lfl.12.1700845426591;
        Fri, 24 Nov 2023 09:03:46 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id be7-20020a056512250700b005094928cf75sm556137lfb.142.2023.11.24.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:03:46 -0800 (PST)
Date:   Fri, 24 Nov 2023 20:03:43 +0300
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
Subject: Re: [PATCH net v2 1/1] net: stmmac: xgmac: Disable FPE MMC interrupts
Message-ID: <b5f6l7oovk67efxeo4pyxg5kx3we4jcemmrakat5dypec4rav2@l3bvlos5rred>
References: <20231124015433.2223696-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124015433.2223696-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:54:33AM +0800, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled.
> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Update commit message, thanks Wojciech and Andrew.
> ---
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index ea4910ae0921..cdd7fbde2bfa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -177,8 +177,10 @@
>  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
>  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
>  

> +#define MMC_XGMAC_FPE_TX_INTR_MASK	0x204
>  #define MMC_XGMAC_TX_FPE_FRAG		0x208
>  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> +#define MMC_XGMAC_FPE_RX_INTR_MASK	0x224

Could you please preserve the local implicit naming convention of
having the Tx_ and RX_ prefixes being placed before the rest of
CSR-specific name part:
#define MMC_XGMAC_TX_FPE_INTR_MASK
instead of
#define MMC_XGMAC_FPE_TX_INTR_MASK
and
#define MMC_XGMAC_RX_FPE_INTR_MASK
instead of
#define MMC_XGMAC_FPE_RX_INTR_MASK

Your macros will then look similar to MMC_XGMAC_TX_*, MMC_XGMAC_RX_*
and finally MMC_XGMAC_RX_IPC_INTR_MASK macros.

-Serge(y)

>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
>  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
>  {
>  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
>  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_RX_INTR_MASK);
>  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
>  }
>  
> -- 
> 2.34.1
> 
> 
