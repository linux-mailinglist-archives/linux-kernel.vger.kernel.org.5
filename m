Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3877DB8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjJ3LD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjJ3LDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:03:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A6C5;
        Mon, 30 Oct 2023 04:03:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c6b5841f61so17483831fa.0;
        Mon, 30 Oct 2023 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698663830; x=1699268630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dP22ExIhwcZf4zvM/nB/XRRRBv2PXkjeYmhWWHNWxWc=;
        b=lhWg30Z+YhvkrOEec4aTKBM6Gvju6qyYF5i6/+xkXgM3xlJ4HVbl5gQPOOe5mqRuI1
         ew/EtNb0kbHObrQLPBiwVb0091NzMcBNL6r61sI01r6s0DwNVYKPeagljCX93hz7RgS0
         hOvjxR9dptABQE5ul8h4YCxiD1AitsjzA5QWL7sCsv1xXgO1giIzM0lIuEPaRFbASbv8
         g9jXNeXEgMlp7VPo+5UiQFy5NPGuoLCSFK4CCDzZwdaQezcQiVwbEuqn7ST2Tw4fPGh4
         UbkVx/iDaZH5LtrhuwEvyHzmadHQxR+W3RJ+D1CNC2gq60iJGkLZpD5bfQCOasALo0SU
         mZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698663830; x=1699268630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP22ExIhwcZf4zvM/nB/XRRRBv2PXkjeYmhWWHNWxWc=;
        b=M1vPfBCkCr/CQxH/pI/enRTMlLQwhak0Hccvz8cR6nL1cavSKsUcT51F1no+Y5LWzL
         J4IH73Wu4m3NUPUXYyC8JmnG+BAN6AjVTWj8gWBzrliXzMWtjg/Gi7t8e7GAaxup02Xq
         YgkLUCuI0EjGJ+h55y3OOhvgU/2Rx0v5pbs1rICKRYBXA4mZHpsnD0JbDhGu6NMWNpXV
         KeRaiaASolFxSnkVSZNSJN2GuBkNzQuCowmU+MBvXYq8vln3jGljpHHwQAnvPDWwa3HQ
         peftlsSwyVtPDY3QlzsUn6nGG3w/jMUstBRYTDDHfudO0HYIYL9r5JtsZExZlYz8JFht
         opRw==
X-Gm-Message-State: AOJu0YzgnmGr8ZbSfIVi7eoeDJ9xs4bp0y0WH3NUNKPk9vToBKwmR3ST
        yOTgru1+CtqFa2LthHUEMgE=
X-Google-Smtp-Source: AGHT+IHRnkYjUtR8YX6ha89b5TfCd6r0X4MdBYCPEfAfKiXbEl1zEKmaXeRNF5HkMmOrJ40Heesb4w==
X-Received: by 2002:a2e:a309:0:b0:2c4:e5d4:d246 with SMTP id l9-20020a2ea309000000b002c4e5d4d246mr4581245lje.7.1698663829773;
        Mon, 30 Oct 2023 04:03:49 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id a27-20020a2eb17b000000b002bcc303bbffsm1181498ljm.104.2023.10.30.04.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:03:49 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:03:47 +0300
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
Subject: Re: [PATCH net] net: stmmac: xgmac: Fix support for multiple
 Flexible PPS outputs
Message-ID: <bayygz3wn6toglzzfdy7ygzs3bhenlrs2y4jjkat54tr3pvxbt@gligw4c4umbe>
References: <20231027025603.1035668-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027025603.1035668-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:56:03AM +0800, Furong Xu wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
> always set PPSEN do not make things worse ;)
> 
> Fixes: 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add Flexible PPS support")
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Please don't forget to add the already got tags shall you need more
patch revisions.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

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
>  
>  	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
>  
> -- 
> 2.34.1
> 
> 
