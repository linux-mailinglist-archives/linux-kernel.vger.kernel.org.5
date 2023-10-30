Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF37DB9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjJ3M0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJ3M0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:26:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460FF5;
        Mon, 30 Oct 2023 05:26:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd644a96so6336009e87.3;
        Mon, 30 Oct 2023 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698668784; x=1699273584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8RFmRMPaCavpWEVO+hqLK8PHwyFGH3KHrLeyNssBXM=;
        b=UdKyJ+rsudAa7WW1rfYRih6IN3RfAwHjhb8AXPmnIH6D54PWYc9vd6no9ScvBrlqvi
         BtmzQmfhAQysmxUTwBij2iawOabo8J0cyIuyjHZMmhqOLsAaEzPJCoLgVHNOGUZnG7p3
         qHnLY9EpqCRJvdWavk+ZM+nklseFyl1RCeZUb2iGhRe9g9on/Q5Qxm8qsyXH1Y/qZZEi
         SXNS0iS7z0cfpZaq0Rl2+IkNPRdKIOt4X4JJMBZT6r3BYoAHwE5oeVO00uFflvCaV+Bf
         /d7MX8ROm9KGw0HpoyqRA1E9RH4X+SwluhIJhe4hjF8pXhpBclDSujbfBVZHriq/iU4H
         orlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698668784; x=1699273584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8RFmRMPaCavpWEVO+hqLK8PHwyFGH3KHrLeyNssBXM=;
        b=acg4RxoprEh+l3tZkHDp2xCJWC8Z1dYiEsCyC1E7seW5GZzFkzD+HTY342qyvLXDSw
         dW1eK3TEJeTtaMRE45ZI+Hw0zs1Uo7iGVNHTInie1bou2VSCNs6CTEHEaagZT5EOkf5K
         2SzMmsGxJ+CIFAcYevA8pU6WJzD+xN9OLX1IpD6OpAjBbphYgH2drrL2mooxkoPd/wcM
         anZIOqjW/DjQeB5J3JmHtkMHwfTMlI5dhxVA5wVgCddn6Rg3YNGGUg+TZkdpKdxQZii6
         +JXTHtsAMlyZcAr1gnFNeICwCt/pEbvvso9cfho9mhPfEtQ/pC6xSw3n3qSogQvMQT3A
         My4Q==
X-Gm-Message-State: AOJu0YwF5ODWL1+X80yptVIEHtnimNITSfsRk5prwzYpMbqtMv/UNnDg
        EYqBZbM8s6K71m5OyINetK0=
X-Google-Smtp-Source: AGHT+IFg9cpzQXCYcHL4V6vW7U7XlYIDrLSpu4W2WLWjccR6BSlhTXw8Kl384Nxe+59YUTZpJQER+A==
X-Received: by 2002:a05:6512:10d6:b0:4fb:9168:1fce with SMTP id k22-20020a05651210d600b004fb91681fcemr8970346lfg.59.1698668783553;
        Mon, 30 Oct 2023 05:26:23 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id w10-20020ac254aa000000b00507a387c4c4sm1421843lfk.229.2023.10.30.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:26:23 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:26:21 +0300
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
        Simon Horman <horms@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2] net: stmmac: xgmac: Enable support for
 multiple Flexible PPS outputs
Message-ID: <ayttoykypfn6obrysve6ivdom7it3wdyexeawoucekeivx236t@o7rljbjrofiz>
References: <20231030035550.2340514-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030035550.2340514-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:55:50AM +0800, Furong Xu wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
> read-only reserved, and they are already in Flexible mode by default, our
> new code always set PPSEN{1,2,3} do not make things worse ;-)
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Please don't forget to add the already got tags shall you need more
patch revisions.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> ---
> Changes in v2:
>   - Add comment for XGMAC_PPSEN description among different XGMAC core versions.
>   - Update commit message, thanks Serge Semin and Jacob Keller for your advices.

BTW Why have you dropped the Fixes tag? Moreover you didn't address
Jacob' comment regarding the actual problematic commit. This isn't the
way the review process normally goes. I'll copy what Jacob said in v1
so to restore the discussion here:

On Mon, Oct 27, 2023 at 2:15:50AM +0800, Jacob Keller  wrote:
> The original code was added in 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add
> Flexible PPS support"), which landed in v5.4
> 
> It looks like XGMAC Core 3.20 support was not added until possibly
> commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
> Core 3.20") which appears to be new enough that its not in any official
> Linux release, though it looks like it was already in net.
> 
> Perhaps this should be tagged Fixes: and sent through net, hopefully to
> try and hit 6.6 or at least a stable release shortly after?
> 

Regards
-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
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
> index f352be269deb..453e88b75be0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1178,7 +1178,19 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
>  
>  	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
>  	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
> -	val |= XGMAC_PPSEN0;
> +
> +	/* XGMAC Core has 4 PPS outputs at most.
> +	 *
> +	 * Prior XGMAC Core 3.20, Fixed mode or Flexible mode are selectable for
> +	 * PPS0 only via PPSEN0. PPS{1,2,3} are in Flexible mode by default,
> +	 * and can not be switched to Fixed mode, since PPSEN{1,2,3} are
> +	 * read-only reserved to 0.
> +	 * But we always set PPSEN{1,2,3} do not make things worse ;-)
> +	 *
> +	 * From XGMAC Core 3.20 and later, PPSEN{0,1,2,3} are writable and must
> +	 * be set, or the PPS outputs stay in Fixed PPS mode by default.
> +	 */
> +	val |= XGMAC_PPSENx(index);
>  
>  	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
>  
> -- 
> 2.34.1
> 
