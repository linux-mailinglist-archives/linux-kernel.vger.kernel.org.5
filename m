Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46F7DB9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjJ3MQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:16:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A975A2;
        Mon, 30 Oct 2023 05:16:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507e85ebf50so6115429e87.1;
        Mon, 30 Oct 2023 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698668211; x=1699273011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbm5lTXBFVIsSs+1ANa7wn2CrqJ6D0ati494gyw8FFM=;
        b=ebosuiKT12gVLtSyNgY6F1P2yZzM2MPDv07yAI3jhA7gr7KX5PzvuMUIZn7ZXJiw9B
         GxHgpv9e24gIB9tLRE+V9Y7/latOs5CYfBx9n9YV7CGl5wicwA9dmkeZx46IOB3IwRNw
         z3fEgbcl9oq9TE9v9G645ev/lviqvDUwbT12r0CTGnGaswauRVvy2RtR7lGEI/+jzy+Z
         ikvrexRu6J9PVqZcx80aTfrLHcnech9xgxZyvFiwBOSsPuTO8zS0eIDhB14Qq+WjLWIa
         e2I4GeTsNjOEZQimSfJCWSZhQwGbp546prv9eS0uqrh8kZZtaMoBcuacc3jbH20s2T88
         /haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698668211; x=1699273011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbm5lTXBFVIsSs+1ANa7wn2CrqJ6D0ati494gyw8FFM=;
        b=dsPESA8mwPALnsqRJsmwRLfJzC2S6MupWzNkSuebGyDgjjLHDFkJDG8E353Fnxa2pk
         x1P80Jf1Ql3KhOYweq7PVRNLk7BJuKYXGsdF9K7f0rkfjsxxRoo8gS9xwxSXLVK5vdtX
         eni0Y6nU4AKXB3NA3fA7mxCwHGyBmRQL/HhymKjuVxBNJDey5CC0jt/AbjPXVwiUQtiB
         XvSA/jGg/l3JMRCkSLCtvdapi1zS4MQqrbI2oBBaUASHdZvr6l2rk+Ap/wDLuwy/oDH7
         la8SrUNC5KOR6rSVu2qOfuTbf/BbQM4DWO76Q7rLY+nCHP30v84GBlG0YzyCeUP3RJH6
         V1NA==
X-Gm-Message-State: AOJu0YwKEWBaH6UdBE1tPswgSndTT3ALQTOEOOIVO6eLnVAdyrrOUfDO
        dE9pOSuHk8VyQKLKM1lBn6g=
X-Google-Smtp-Source: AGHT+IEOLthbp7Tfp6EdgCrBQvhiY+rzXkU8whMbq+0zowLUHkcytR2z5F8TiLx8t1G9VqSpCIIewg==
X-Received: by 2002:ac2:43bc:0:b0:508:1a4c:b9b8 with SMTP id t28-20020ac243bc000000b005081a4cb9b8mr5907776lfl.36.1698668210756;
        Mon, 30 Oct 2023 05:16:50 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id f22-20020ac251b6000000b005007e7211f7sm1432686lfk.21.2023.10.30.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:16:50 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:16:48 +0300
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
Message-ID: <ek3edupo2ve2puzee7376ugjwpuimz3pipf5m2naulmi4ghefr@qgz5g6vitblx>
References: <20231027025603.1035668-1-0x1207@gmail.com>
 <bayygz3wn6toglzzfdy7ygzs3bhenlrs2y4jjkat54tr3pvxbt@gligw4c4umbe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bayygz3wn6toglzzfdy7ygzs3bhenlrs2y4jjkat54tr3pvxbt@gligw4c4umbe>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:03:50PM +0300, Serge Semin wrote:
> On Fri, Oct 27, 2023 at 10:56:03AM +0800, Furong Xu wrote:
> > From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> > to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> > in Fixed PPS mode by default.
> > XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
> > always set PPSEN do not make things worse ;)
> > 
> > Fixes: 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add Flexible PPS support")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> 
> Please don't forget to add the already got tags shall you need more
> patch revisions.
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Ops, this was intended to be sent for v2... I'll send a copy there.

-Serge(y)

> 
> -Serge(y)
> 
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 7a8f47e7b728..a4e8b498dea9 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -259,7 +259,7 @@
> >  	((val) << XGMAC_PPS_MINIDX(x))
> >  #define XGMAC_PPSCMD_START		0x2
> >  #define XGMAC_PPSCMD_STOP		0x5
> > -#define XGMAC_PPSEN0			BIT(4)
> > +#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
> >  #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
> >  #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
> >  #define XGMAC_TRGTBUSY0			BIT(31)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index f352be269deb..53bb8f16c481 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -1178,7 +1178,7 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
> >  
> >  	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
> >  	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
> > -	val |= XGMAC_PPSEN0;
> > +	val |= XGMAC_PPSENx(index);
> >  
> >  	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
> >  
> > -- 
> > 2.34.1
> > 
> > 
