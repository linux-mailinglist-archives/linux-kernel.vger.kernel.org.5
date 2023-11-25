Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F467F887F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjKYF21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 00:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 00:28:24 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E01B5;
        Fri, 24 Nov 2023 21:28:26 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cd0af4a7d3so25080907b3.0;
        Fri, 24 Nov 2023 21:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700890106; x=1701494906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00zNmrmz8VCMGnwTQFhbmVp+ehsjjW8N/XcmWDXSbx8=;
        b=Z0kufec5qdA/5YN2gF5lJRWU8dZ7KwchLYf4Yfr0F7VMCxW7n87mm3g6m+Prx06XLL
         0UBuHAIjWtNSAFvabqBAqzhoMcPKvYF+Z87kWnRwThPKaaSkf/RID+YpBxhKzvVoQJCx
         vXnK86nNPcYaeOqqosxoL6iPaEZCg/e2i08eN+Xja+bLDH1W10H97B7M6xU48N6Way+5
         NUALEEY6omo6/+hnh9KUSt39oalITAIoN1EILkUGYOeMrez9qBp4XpZDYrrl8ZKHEO5S
         h0MVKqwIOm05Y6I2/Uvh62dwhszzHmc3AbqOxvBiisAFDiEVw2n1yvGCBUCJ6+a4G8Ct
         OCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700890106; x=1701494906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00zNmrmz8VCMGnwTQFhbmVp+ehsjjW8N/XcmWDXSbx8=;
        b=GrVrUyANU8MLoKbs0wHTKHN+RoLroA9Zu4fWsrfXXl8fOp1UTpgsTdKwS204ZitPqj
         xBFxCFSxnPmTn07m9XXEWmcM8mGMsn/7mACcQk5zLzA4k1nB6ZiFAd9jsVgfh1y3aAeV
         4+T8myNk6zeaT+jpQEDs1jilgd2Wsjz2dcOoB8Mb6feHD3xkrMJF9B+ALfuypfN76aDC
         9WwJfUcJDV5+DyIFt+NrI7Ya4SrWZ+durOn82eK7rZbZ3nlbl2EYKeJ7Wb/45byQF/hq
         MCSs1/8ZNjBH44QEOWBHoOzY9ztAn/eTvrDhcYeGJ+EkGQSrAokvu++ymoH+UUMNBZ1x
         4+Mw==
X-Gm-Message-State: AOJu0Yx8Ri/NmcB0pXAcYfclGKYpjNUZmSCs8uoi7HpLBU1rvbjPNKU3
        Z32S9NubYt5KzIorkYU4PHg=
X-Google-Smtp-Source: AGHT+IEBqW2rZ9W4gTax6+1ZGLMqaSNMwq7hQ9LOiEHY5GwRTDONyL78C07sKevDT9PmhnHjh/SXVw==
X-Received: by 2002:a0d:f2c7:0:b0:5cd:3d82:1ac6 with SMTP id b190-20020a0df2c7000000b005cd3d821ac6mr4837287ywf.42.1700890105921;
        Fri, 24 Nov 2023 21:28:25 -0800 (PST)
Received: from localhost ([74.48.130.204])
        by smtp.gmail.com with ESMTPSA id i7-20020a81d507000000b005cbc182523esm1441160ywj.49.2023.11.24.21.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 21:28:25 -0800 (PST)
Date:   Sat, 25 Nov 2023 13:28:14 +0800
From:   Furong Xu <0x1207@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Subject: Re: [PATCH net v2 1/1] net: stmmac: xgmac: Disable FPE MMC
 interrupts
Message-ID: <20231125132814.00001482@gmail.com>
In-Reply-To: <b5f6l7oovk67efxeo4pyxg5kx3we4jcemmrakat5dypec4rav2@l3bvlos5rred>
References: <20231124015433.2223696-1-0x1207@gmail.com>
        <b5f6l7oovk67efxeo4pyxg5kx3we4jcemmrakat5dypec4rav2@l3bvlos5rred>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 20:03:43 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Fri, Nov 24, 2023 at 09:54:33AM +0800, Furong Xu wrote:
> > Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> > by default") tries to disable MMC interrupts to avoid a storm of
> > unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> > interrupts enabled.
> > Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> > 
> > Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> > Changes in v2:
> >   - Update commit message, thanks Wojciech and Andrew.
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > index ea4910ae0921..cdd7fbde2bfa 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > @@ -177,8 +177,10 @@
> >  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
> >  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
> >    
> 
> > +#define MMC_XGMAC_FPE_TX_INTR_MASK	0x204
> >  #define MMC_XGMAC_TX_FPE_FRAG		0x208
> >  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> > +#define MMC_XGMAC_FPE_RX_INTR_MASK	0x224  
> 
> Could you please preserve the local implicit naming convention of
> having the Tx_ and RX_ prefixes being placed before the rest of
> CSR-specific name part:
> #define MMC_XGMAC_TX_FPE_INTR_MASK
> instead of
> #define MMC_XGMAC_FPE_TX_INTR_MASK
> and
> #define MMC_XGMAC_RX_FPE_INTR_MASK
> instead of
> #define MMC_XGMAC_FPE_RX_INTR_MASK
> 
> Your macros will then look similar to MMC_XGMAC_TX_*, MMC_XGMAC_RX_*
> and finally MMC_XGMAC_RX_IPC_INTR_MASK macros.
> 
> -Serge(y)
> 

Hi Serge,

Thanks for your advice, I copied these register names from Synopsys Databook, and
forgot to preserve the local implicit naming convention, I will send a new patch.

> >  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
> >  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
> >  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> > @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
> >  {
> >  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
> >  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> > +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_TX_INTR_MASK);
> > +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_RX_INTR_MASK);
> >  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
> >  }
> >  
> > -- 
> > 2.34.1
> > 
> >   

