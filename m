Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE3480E711
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjLLJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjLLJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:08:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ECAC7;
        Tue, 12 Dec 2023 01:08:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bce78f145so6232279e87.0;
        Tue, 12 Dec 2023 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702372091; x=1702976891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIjPBVeqkpjJISDqusXw3EmS1YdMB1wPejTAPOdPhFM=;
        b=Zglibz5F1zOHeXpIe8espdYCHfBuyKlW4/fsq5XL8o3Fc4XiNRqrNroNkvItm/DJXo
         IGeRiACqfirCe0tyCQC0z8N0t0X47vnus4zWv+yu7fLor4hewtbrjw4TVnBBahVsvyZE
         MLQuxcvvO6CTL4UhS3KOsCLv8dPTRdslPjEG50xD0MRct+6i/dsTJe8WzAJMxoTxkary
         pAuHCIyKdNrz7nb4grYDB6Z/p7xZIeA5d7UKhaUXm+OKrAQsEsLV2w1vD8+u6Lv4JCYC
         XiSGIjMZvh7yerZz0kurkUgyzs/1eGAdvSQLSTOwIaxulSacCiicsxoq9L+ojgvckycm
         gg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372091; x=1702976891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIjPBVeqkpjJISDqusXw3EmS1YdMB1wPejTAPOdPhFM=;
        b=Vz8nzPZ0X5h1QZ4XnzAXS7NwTR1tM27AYBMvB9xoNzPVSzPE0Ht8SVQKeh/ZvFu7O0
         bm804aeH9xscKKytmL9GmKscOQC3Q2R6wHTzcDPO88UMEqOYqQeJ+c8N2M5I1N716GGb
         qGPxH+AyH7a67fbiYY2muZW6mn5Jxz0j3Wft67Pe1mqA/erkUk5hH2ukl2g6eMgdh3rN
         4AWoN4mxzHAAelV66GX7LIRaOJlh8SodsoZKAHZm/tGVYZOiwF6GhQ+SPIWLMijyIdy9
         BuE/2Gi7aj5ERzlyPrbL4xeL5CG+ozhfoULUJr91xsjT/QrnonNH5YePJfrHSwo6V+4f
         gqsw==
X-Gm-Message-State: AOJu0Yyuj6wDUFTS/w/8yl7Yv0rkKUp9GenrmHenAcKb9tUQ9c0JidBR
        U/NeOZPkVw/X7ryqSJNjYuA=
X-Google-Smtp-Source: AGHT+IHt99lcd5IUKs49PKtCTF0cKUj5I2Ik89wnLq7Asjoik1V8IuHwNphFLryPGu803yiXf3w+fw==
X-Received: by 2002:a05:6512:46f:b0:50b:ed48:247a with SMTP id x15-20020a056512046f00b0050bed48247amr1240510lfd.246.1702372091059;
        Tue, 12 Dec 2023 01:08:11 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t8-20020a19ad08000000b0050c0f5ce8c2sm1290876lfc.124.2023.12.12.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:08:10 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:08:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <ulsdbn3iqzyokqbfejp5krrpbkzz3rqpxfw53m2rfm2ouzs2bz@ys4ynwqwewjo>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <d202770a-3a3a-4ee2-b0de-b86e2f3e83ce@lunn.ch>
 <CY5PR12MB6372C8770900AFF821325400BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6372C8770900AFF821325400BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:22:24AM +0000, Jianheng Zhang wrote:
> Hi Andrew,  
> 
> > > +static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> > > +{
> > > +	u32 value;
> > > +	int status;
> > >
> > > -		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
> > > -		return;
> > > +	status = FPE_EVENT_UNKNOWN;
> > > +
> > > +	/* Reads from the XGMAC_FPE_CTRL_STS register should only be performed
> > > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
> > > +	 */
> > > +	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
> > > +
> > > +	if (value & XGMAC_TRSP) {
> > > +		status |= FPE_EVENT_TRSP;
> > > +		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
> > 
> > netdev_info()?  Is this going to spam the logs? Should it be netdev_dbg()
> 
> Yes, netdev_dbg() should be better, let me fix it in the next patch.

Please do not forget to keep this change in the refactoring patch (if
one will be introduced). So instead of preserving the DW QoS Eth FPE
code snipped with netdev_info() utilized, the common FPE
implementation would have the netdev_dbg() calls.

-Serge(y)

> 
> Jianheng
> > 
> > 	Andrew
> 
