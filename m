Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EDE7F2D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjKUM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjKUM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:27:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2D1AA;
        Tue, 21 Nov 2023 04:27:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507975d34e8so7720073e87.1;
        Tue, 21 Nov 2023 04:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700569668; x=1701174468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOcAOBX2xiKh29AKg54qGZlhZDJq8h/h+dA5La5VZhs=;
        b=mibGE+siWTdCNeALN1joHNEQyxAxaHVvxdpfOdEtStj8VN7GcWZcAgK/FSCcwoaLYP
         rqc2QQcGewHSM485eJOd0b4qLCQ5vAAgqsZ/XLtwNwB7pT9rVyiv3fsv+lvUOwskuqBR
         49Wi1E4pFxcKhAzFfLzGy+NRdUkUbkOnjx3eq4XwofS0efQbyUlKlkCkafLqgPjI3wZW
         qGQPqHyFqVmC+HCzz14pNYaH6ANd9Wh2zalynjCLiHQ+MwEDOvAY8gTtXjACQHfEiVYG
         bTM1g9qsWOgsK/VzIbAmi7TOIlp2PaRX2xtOKl/YnNF6jndRCBEeT9tnuTEo3/YUx/U5
         wRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700569668; x=1701174468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOcAOBX2xiKh29AKg54qGZlhZDJq8h/h+dA5La5VZhs=;
        b=jPiKN/GulKAXV63E7X0Fut1de65AI1NpTi6xagRY9JPcVuNZKQ9AoJ1w6R6o9kp7aC
         u9JnOVdUyT/N8jpqczj7RAw1cTuYtHHw9W66bulL0gQ4nv9DR+dbJczsy7SGtkX+S136
         juehN0EA719MgJnOP9e/KuJqfW70NSvOYSTLN9ylmSRMc3DjiiSTDv/+5OvnHqEhUHJK
         czp0TEhXPH9yTSFYgbi4ejzJsFDpLuggjIMtSkjVOUr9R9wGIHX1M+1hQuQ2E/bHcshB
         8WlBuKngalMoiHlaE1t+uJh9RsnDh646OTE9ucV21fr+rSklQbxI/2zSBcjvz7RGbLXe
         9mUg==
X-Gm-Message-State: AOJu0YzTfAEWpfygg0gOGPBfjD//3olEJcuMhnYtAyQzsuWFAHvbwqCs
        JsD5ZLB4jAviyN3+vvRe9c8=
X-Google-Smtp-Source: AGHT+IGghZAk29coi15eVyquX/1EvGd6TGCrazur79yUOTEDV8cYJkDsvdQsN9n2vQuk8yRsGn9KEw==
X-Received: by 2002:a05:6512:31c9:b0:50a:a97d:f13d with SMTP id j9-20020a05651231c900b0050aa97df13dmr8326258lfe.65.1700569667873;
        Tue, 21 Nov 2023 04:27:47 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c6-20020ac24146000000b005042ae2baf8sm1489692lfi.258.2023.11.21.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:27:47 -0800 (PST)
Date:   Tue, 21 Nov 2023 15:27:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: fix FPE events losing
Message-ID: <er4vp42libh5kqo45puunsiejmkuy2cr42l2oggdgv2u6fluj5@wiedy3cr6ssg>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:25:37PM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> > > The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
> > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
> > > avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
> > > the FPE handshake retries.
> > > 
> > > The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> > > Those bits are clear on read (or write of 1 when RCWE bit in
> > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > MAC_FPE_CTRL_STS control bits makes side effects that clear the status
> > > bits. Then the stmmac interrupt handler missing FPE event status and
> > > leads to FPE handshake failure and retries.
> > > 
> > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reserved
> > > that have no access side effects, so can use 8-bit access for
> > > MAC_FPE_CTRL_STS control bits.
> > > 
> > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > index e95d35f..7333995 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > >  	u32 value;
> > >  
> > >  	if (!enable) {
> > 
> > > -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > +		value = readb(ioaddr + MAC_FPE_CTRL_STS);
> > 
> > Note this may break the platforms which don't support non-32 MMIOs for
> > some devices. None of the currently supported glue-drivers explicitly
> > state they have such peculiarity, but at the same time the STMMAC-core
> > driver at the present state uses the dword IO ops only. For instance
> > the PCIe subsystem has the special accessors for such cases:
> > pci_generic_config_read32()
> > pci_generic_config_write32()
> > which at the very least are utilized on the Tegra and Loongson
> > platforms to access the host CSR spaces. These platforms are also
> > equipped with the DW MACs. The problem might be irrelevant for all the
> > currently supported DW MAC controllers implementations though, but
> > still it worth to draw an attention to the problem possibility and in
> > order to prevent it before ahead it would be better to just avoid
> > using the byte-/word- IOs if it's possible.
> 

> Yes, this exists for configuration accesses, and is damn annoying
> because the read-modify-write of these can end up clearing PCI
> status register bits that are W1C.
> 

Right, but at least on Tegra these accessors are utilized to reach the
Root Port config space only, which is basically the normal memory
mapped CSRs. No PCIe bus transfers is performed for it, just normal
AHB/AXI/etc bus IOs passed directly to the DW PCIe CDM (Configuration
Dependent Module, that is generic PCIe config-space and
Synopsys-specific CSRs).

> I've never heard of that problem with MMIO though.

I was working with such platform and it was indeed tricky to have linux
working there well for all such peculiar SoC devices. Some drivers had the
"reg-io-width"/"reg-shift" DT-properties supported, which helped very
much in that matter since it tweaked the respective drivers to using
the allowed on my platform instructions only.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
