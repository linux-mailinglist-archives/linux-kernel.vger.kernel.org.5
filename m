Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA17F72AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjKXL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:26:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD710CA;
        Fri, 24 Nov 2023 03:26:29 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5071165d5so23323971fa.0;
        Fri, 24 Nov 2023 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700825186; x=1701429986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ir6TR92WrZFP7jtZUKNRYDhTU7odG92PJmsNlmFJ8Zs=;
        b=W09DZz2QYxXXw9MpKs8gZKi20f33CUG0gqo1RszwnMgbwxK//7lHCvg51s3oXxZKC2
         HYuAHCx9cCvhghsAFSTezbGPU0tZ6EsIaP17VZAEFYDVfhDnRuLWv38VkUGTV3oG2YST
         BF5IloOjn/ZSgzy8M2PdIq865inMVXQIyukW44ByQEVYJL5l4gSVcTaR6vOD3nsztvrq
         dEa7gBTXNMt30oENnFTomawa64kfyyEZPgwXnEmRRDzYrV//gdLooBrdpFov4hGu590Q
         yMdPrafNAiQb2OcYi82aPBQOEHytFUX0WuoBdO2IoLNGmr3WAZjLXjXnT2f0fUqxeQYF
         eWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825186; x=1701429986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir6TR92WrZFP7jtZUKNRYDhTU7odG92PJmsNlmFJ8Zs=;
        b=Us178sv7eSM5VUJz7MgnI/LUo9Ss3zFEubnRmYVa8jfq/WTuF39H7fnDjHgE1CyydA
         oo1RJd3L4puG4u6c44XbVcs3Gj8aMH/GNKG6fzdudjCPcubJh1bIVtbDxlRjXLLXaMmf
         e/8/fgpqDop6iK4wfMBsx9uI+4kzgVa9IQhDriHXuCE7kg8T7mOXR0KFyZzssDh58YM/
         2EawZadwfxr12Mh+HOfQ/r7FmK+vDhLGhjG3WViMY0c0c2oCwtMW7B+T8kR7yNKK04Sl
         dufPYNtPfwHMSzB8JBr5RsX8G8RDgB73rX6UJNqO6N7undixfEa1uuTFsPCb1L5Rn92H
         URNQ==
X-Gm-Message-State: AOJu0YzAtQiOnVR3QMY1VnuZoFYTGUFFyngM29gESos3541XmkOw25i2
        RfmPpWfpp1JMPxQrlgYSTb0YwNy+UkoizA==
X-Google-Smtp-Source: AGHT+IEG5Ovpo/Uuwz70BzaG1l/kQbi1AoCwd15kNa1jKJpgkfGly9hQpWNOZ6J/kGdjidEV4QsRkQ==
X-Received: by 2002:a2e:8ed5:0:b0:2c8:3951:81c with SMTP id e21-20020a2e8ed5000000b002c83951081cmr1789583ljl.12.1700825185733;
        Fri, 24 Nov 2023 03:26:25 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n17-20020a2e86d1000000b002b836d8c839sm458360ljj.40.2023.11.24.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:26:25 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:26:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Russell King <linux@armlinux.org.uk>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH] net: stmmac: fix FPE events losing
Message-ID: <jl4f2ytl5dtclhaj46qt4xe6x75cxqbk4o2ei4a7djhrjpxbt5@lfjbph55y7ku>
References: <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
 <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB637235F27E5114CFB4DE1AD3BFBBA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <aicr2gv4aqsgam4nc4wahacyakwn744xx52uojfkn7fjtd26pt@6lxmiizwkrqk>
 <CY5PR12MB637274F20E0AE776A315A79FBFBAA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <j5i4j343zqsuyubexjj4gqsz4ol3c7wmjpnsbxg5x4vzvtk7ni@uta6ssp4oj2a>
 <CY5PR12MB63729B1EE424490BE0410664BFB9A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <n6znly3wbe2eqljkr7yypliixxdarohjqkegvqrjorrxmbotnp@rpi6wwkagiy3>
 <CY5PR12MB637238DE62179A4B919AF2F4BFB9A@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY5PR12MB637238DE62179A4B919AF2F4BFB9A@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:46:11PM +0000, Jianheng Zhang wrote:
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Thursday, November 23, 2023 6:58 PM
> > To: Jianheng Zhang <jianheng@synopsys.com>
> > Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong Boon
> > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mohammad Athari Bin
> > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>; Martin McKenny
> > <mmckenny@synopsys.com>
> > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > 
> > On Thu, Nov 23, 2023 at 09:44:07AM +0000, Jianheng Zhang wrote:
> > > > From: Serge Semin <fancer.lancer@gmail.com>
> > > > Sent: Wednesday, November 22, 2023 11:07 PM
> > > > To: Jianheng Zhang <jianheng@synopsys.com>
> > > > Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> > > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong
> > Boon
> > > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mohammad Athari
> > Bin
> > > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>; Martin McKenny
> > > > <mmckenny@synopsys.com>
> > > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > > >
> > > > On Wed, Nov 22, 2023 at 07:37:51AM +0000, Jianheng Zhang wrote:
> > > > > > From: Serge Semin <fancer.lancer@gmail.com>
> > > > > > Sent: Tuesday, November 21, 2023 8:09 PM
> > > > > > To: Jianheng Zhang <jianheng@synopsys.com>
> > > > > > Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
> > Jose
> > > > > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > > > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>;
> > > > > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong
> > > > Boon
> > > > > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mohammad
> > Athari
> > > > Bin
> > > > > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>
> > > > > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > > > > >
> > > > > > On Tue, Nov 21, 2023 at 09:31:31AM +0000, Jianheng Zhang wrote:
> > > > > > > > From: Jianheng Zhang
> > > > > > > > Sent: Thursday, November 16, 2023 12:01 AM
> > > > > > > > To: Russell King <linux@armlinux.org.uk>; Serge Semin <fancer.lancer@gmail.com>
> > > > > > > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> > <joabreu@synopsys.com>;
> > > > David
> > > > > > S.
> > > > > > > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> > > > > > > > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> > > > > > > > <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong Boon Leong
> > > > > > > > <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mohammad Athari
> > Bin
> > > > > > Ismail
> > > > > > > > <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > > > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > > > > > > > linux-kernel@vger.kernel.org
> > > > > > > > Subject: RE: [PATCH] net: stmmac: fix FPE events losing
> > > > > > > >
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Russell King <linux@armlinux.org.uk>
> > > > > > > > > Sent: Wednesday, November 15, 2023 10:26 PM
> > > > > > > > > To: Serge Semin <fancer.lancer@gmail.com>
> > > > > > > > > Cc: Jianheng Zhang <jianheng@synopsys.com>; Alexandre Torgue
> > > > > > <alexandre.torgue@foss.st.com>;
> > > > > > > > Jose
> > > > > > > > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > > > > > > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > > > <pabeni@redhat.com>;
> > > > > > > > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>;
> > Ong
> > > > > > Boon
> > > > > > > > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>;
> > Mohammad
> > > > > > Athari
> > > > > > > > Bin
> > > > > > > > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > > > > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > > > > > > > > linux-kernel@vger.kernel.org
> > > > > > > > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > > > > > > > >
> > > > > > > > > On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > > > > > > > > > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> > > > > > > > > > > The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
> > > > > > > > > > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
> > > > > > > > > > > avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
> > > > > > > > > > > the FPE handshake retries.
> > > > > > > > > > >
> > > > > > > > > > > The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> > > > > > > > > > > Those bits are clear on read (or write of 1 when RCWE bit in
> > > > > > > > > > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > > > > > > > > > MAC_FPE_CTRL_STS control bits makes side effects that clear the status
> > > > > > > > > > > bits. Then the stmmac interrupt handler missing FPE event status and
> > > > > > > > > > > leads to FPE handshake failure and retries.
> > > > > > > > > > >
> > > > > > > > > > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reserved
> > > > > > > > > > > that have no access side effects, so can use 8-bit access for
> > > > > > > > > > > MAC_FPE_CTRL_STS control bits.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> > > > > > > > > > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
> > > > > > > > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > > > > index e95d35f..7333995 100644
> > > > > > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > > > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32
> > > > num_txq,
> > > > > > u32
> > > > > > > > > num_rxq,
> > > > > > > > > > >  	u32 value;
> > > > > > > > > > >
> > > > > > > > > > >  	if (!enable) {
> > > > > > > > > >
> > > > > > > > > > > -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > > > > > +		value = readb(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > > > >
> > > > > > > > > > Note this may break the platforms which don't support non-32 MMIOs for
> > > > > > > > > > some devices. None of the currently supported glue-drivers explicitly
> > > > > > > > > > state they have such peculiarity, but at the same time the STMMAC-core
> > > > > > > > > > driver at the present state uses the dword IO ops only. For instance
> > > > > > > > > > the PCIe subsystem has the special accessors for such cases:
> > > > > > > > > > pci_generic_config_read32()
> > > > > > > > > > pci_generic_config_write32()
> > > > > > > > > > which at the very least are utilized on the Tegra and Loongson
> > > > > > > > > > platforms to access the host CSR spaces. These platforms are also
> > > > > > > > > > equipped with the DW MACs. The problem might be irrelevant for all the
> > > > > > > > > > currently supported DW MAC controllers implementations though, but
> > > > > > > > > > still it worth to draw an attention to the problem possibility and in
> > > > > > > > > > order to prevent it before ahead it would be better to just avoid
> > > > > > > > > > using the byte-/word- IOs if it's possible.
> > > > > > > > >
> > > > > > > > > Yes, this exists for configuration accesses, and is damn annoying
> > > > > > > > > because the read-modify-write of these can end up clearing PCI
> > > > > > > > > status register bits that are W1C.
> > > > > > > > >
> > > > > > > > > I've never heard of that problem with MMIO though.
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > RMK's Patch system:
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> > https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!A4F2R9G_pg!ZnsQc
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> > 7LKbdCiIj_nLBkt44MRSL8W8YD4WvMmPNkHFlDMrjrVqEVOVA1-P-9BVE3Oa5bC1ymKXLNV5C9mJ_rfFtLW
> > > > > > > > > Fg$
> > > > > > > > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > > > > > > > Thanks for all your mention about the potential risks of using readb and suggestions, I'll
> > consider a
> > > > > > new
> > > > > > > > solution and update the patch.
> > > > > > > >
> > > > > > > > Best Regards,
> > > > > > > > Jianheng
> > > > > > >
> > > > > > > Thanks for Andrew's suggestion. I consider the solution of set
> > > > > > > MAC_CSR_SW_Ctrl.RCWE carefully and found that the MAC_CSR_SW_Ctrl.RCWE
> > > > > > > is efficient for many other interrupt status registers, and some are used
> > > > > > > in current stmmac driver (LPI PMT MMC etc). Those registers work fine in
> > > > > > > clear on read mode with current code. So, I think there is no need to
> > > > > > > set MAC_CSR_SW_Ctrl.RCWE that will make a large impact to current
> > > > > > > interrupt handler.
> > > > > > >
> > > > > > > I try adding a new member variable(staged_fpe_state) to stmmac_fpe_cfg
> > > > > > > that is used to stage the MAC_FPE_CTRL_STS value read in
> > > > > > > dwmac5_fpe_send_mpacket(). And in dwmac5_fpe_irq_status(), use this staged
> > > > > > > value and current value of MAC_FPE_CTRL_STS to check FPE status. The
> > > > > > > draft patch is below.
> > > > > >
> > > > > > Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> > > > > > _writes_? (I am asking because for some reason my DW QoS Eth v5.10a HW
> > > > > > manual has the status MAC_FPE_CTRL_STS flags marked as R/W, which is
> > > > > > weird access mode for the status flags.) If they turn to be _not_
> > > > > > changeable on writes, then what about just converting the
> > > > > > dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to always
> > > > > > writing to the MAC_FPE_CTRL_STS register, and if required preserve the
> > > > > > shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure?
> > > > > > AFAICS the only flag which needs to be preserved is EFPE - "enable
> > > > > > FPE" flag.
> > > > > >
> > > > > > Such implementation (if it's possible) shall be free from the _status_
> > > > > > flags race condition and won't require additional serializations. On
> > > > > > the contrary your suggestion AFAICS causes unresolved race condition
> > > > > > in here
> > > > > >
> > > > > > > +	value = readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_state;
> > > > > > > +	fpe_cfg->staged_fpe_state = 0x0;
> > > > > >
> > > > > > and here
> > > > > >
> > > > > > >  	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > +	cfg->staged_fpe_state = value;
> > > > > >
> > > > > > Depending on the IRQ handling and the task scheduling timing you may
> > > > > > end up with loosing the status flags anyway.
> > > > > >
> > > > > > * Note I am not concerning here the MAC_FPE_CTRL_STS control flags
> > > > > > * race condition which AFAICS already exist in the current frame
> > > > > > * preemption code. See the configs performed in the open/close/suspend
> > > > > > * methods, in the link state change callbacks, in the worker task and
> > > > > > * in the FPE status IRQ handler. Control flag accesses don't look
> > > > > > * coherent there.
> > > > > >
> > > > > > -Serge(y)
> > > > > >
> > > > > > >
> > > > > > > Best Regards,
> > > > > > > Jianheng
> > > > > > >
> > > > > > > [PATCH v2] net: stmmac: fix FPE events losing
> > > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 9 +++++++--
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h      | 1 +
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 1 +
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
> > > > > > >  include/linux/stmmac.h                            | 1 +
> > > > > > >  5 files changed, 15 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > index e95d35f..8917fd0 100644
> > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > @@ -736,12 +736,15 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> > u32
> > > > > > num_rxq,
> > > > > > >
> > > > > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> > > > > > >  {
> > > > > > > +	struct stmmac_priv *priv = netdev_priv(dev);
> > > > > > > +	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
> > > > > > >  	u32 value;
> > > > > > >  	int status;
> > > > > > >
> > > > > > >  	status = FPE_EVENT_UNKNOWN;
> > > > > > >
> > > > > > > -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > +	value = readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_state;
> > > > > > > +	fpe_cfg->staged_fpe_state = 0x0;
> > > > > > >
> > > > > > >  	if (value & TRSP) {
> > > > > > >  		status |= FPE_EVENT_TRSP;
> > > > > > > @@ -766,11 +769,13 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device
> > > > *dev)
> > > > > > >  	return status;
> > > > > > >  }
> > > > > > >
> > > > > > > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
> > > > > > > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > > > +			     enum stmmac_mpacket_type type)
> > > > > > >  {
> > > > > > >  	u32 value;
> > > > > > >
> > > > > > >  	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > +	cfg->staged_fpe_state = value;
> > > > > > >
> > > > > > >  	if (type == MPACKET_VERIFY) {
> > > > > > >  		value &= ~SRSP;
> > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > > > index 53c138d..022c1a2 100644
> > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > > > @@ -156,6 +156,7 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device
> > > > *dev,
> > > > > > >  void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > > > > > >  			  bool enable);
> > > > > > >  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> > > > > > > +				 struct stmmac_fpe_cfg *cfg,
> > > > > > >  			     enum stmmac_mpacket_type type);
> > > > > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
> > > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > > > index b95d3e1..5496781 100644
> > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > > > @@ -415,6 +415,7 @@ struct stmmac_ops {
> > > > > > >  	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > > > > > >  			      bool enable);
> > > > > > >  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> > > > > > > +				 struct stmmac_fpe_cfg *cfg,
> > > > > > >  				 enum stmmac_mpacket_type type);
> > > > > > >  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
> > > > > > >  };
> > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > > index 3e50fd5..6a29f55 100644
> > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > > @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv,
> > bool
> > > > > > is_up)
> > > > > > >  	bool *hs_enable = &fpe_cfg->hs_enable;
> > > > > > >
> > > > > > >  	if (is_up && *hs_enable) {
> > > > > > > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> > > > > > > +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > > > > > > +					MPACKET_VERIFY);
> > > > > > >  	} else {
> > > > > > >  		*lo_state = FPE_STATE_OFF;
> > > > > > >  		*lp_state = FPE_STATE_OFF;
> > > > > > > @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int
> > > > status)
> > > > > > >  		/* If user has requested FPE enable, quickly response */
> > > > > > >  		if (*hs_enable)
> > > > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > > > +						fpe_cfg,
> > > > > > >  						MPACKET_RESPONSE);
> > > > > > >  	}
> > > > > > >
> > > > > > > @@ -7280,6 +7282,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
> > > > > > >  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> > > > > > >  				    *lo_state, *lp_state);
> > > > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > > > +						fpe_cfg,
> > > > > > >  						MPACKET_VERIFY);
> > > > > > >  		}
> > > > > > >  		/* Sleep then retry */
> > > > > > > @@ -7294,6 +7297,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
> > > > > > >  	if (priv->plat->fpe_cfg->hs_enable != enable) {
> > > > > > >  		if (enable) {
> > > > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > > > +						priv->plat->fpe_cfg,
> > > > > > >  						MPACKET_VERIFY);
> > > > > > >  		} else {
> > > > > > >  			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
> > > > > > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > > > > index 0b4658a..1322c78 100644
> > > > > > > --- a/include/linux/stmmac.h
> > > > > > > +++ b/include/linux/stmmac.h
> > > > > > > @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
> > > > > > >  	bool hs_enable;				/* FPE handshake enable */
> > > > > > >  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> > > > > > >  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> > > > > > > +	u32 staged_fpe_state; /* Staged FPE state when read MAC_FPE_CTRL_STS */
> > > > > > >  };
> > > > > > >
> > > > > > >  struct stmmac_safety_feature_cfg {
> > > > > > > --
> > > > > > > 1.8.3.1
> > > > > > >
> > > > >
> > > > > Hi Serge,
> > > > >
> > > > > Thanks for your suggestion.
> > > > >
> > > > > > Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> > > > > > _writes_?
> > > >
> > > > > A write of 0 has no impact irrespective of the value programmed in RCWE bit.
> > > > > This is safe option when writing the MAC_FPE_CTRL_STS register, which will
> > > > > ensure that bits[19:16] are not modified unintentionally.
> > > > > When RCWE bit is 0 and status bits[19:16] are read, those will be cleared, a write
> > > > > of 0 or 1 do not have any impact in this mode.
> > > >
> > > > Great! Than always writing shall do the trick.
> > > >
> > > > >
> > > > > > then what about just converting the
> > > > > > dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to always
> > > > > > writing to the MAC_FPE_CTRL_STS register, and if required preserve the
> > > > > > shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure?
> > > > > > AFAICS the only flag which needs to be preserved is EFPE - "enable
> > > > > > FPE" flag.
> > > >
> > > > > I think this is a good solution, pls check my draft patch below.
> > > >
> > > > Some comments are below.
> > > >
> > > > >
> > > > > -Jianheng
> > > > >
> > > > > [PATCH v2] net: stmmac: fix FPE events losing
> > > > >
> > > > > ---
> > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 26 +++++++++-------------
> > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +++-
> > > > >  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 ++-
> > > > >  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +++-
> > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 ++++++-
> > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
> > > > >  include/linux/stmmac.h                             |  1 +
> > > > >  7 files changed, 28 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > index e95d35f..9575e84 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > @@ -710,17 +710,15 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device
> > *dev,
> > > > >  	}
> > > > >  }
> > > > >
> > > > > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > > > > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > +			  u32 num_txq, u32 num_rxq,
> > > > >  			  bool enable)
> > > > >  {
> > > >
> > > > >  	u32 value;
> > > > >
> > > > >  	if (!enable) {
> > > > > -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > -
> > > > > -		value &= ~EFPE;
> > > > > -
> > > > > -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > > > +		writel(0x0, ioaddr + MAC_FPE_CTRL_STS);
> > > > > +		cfg->fpe_ctrl_sts_shadow = 0x0;
> > > > >  		return;
> > > > >  	}
> > > > >
> > > > > @@ -729,9 +727,9 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32
> > > > num_rxq,
> > > > >  	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > > > >  	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > > > >
> > > > > -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > -	value |= EFPE;
> > > >
> > > > > +	value = EFPE;
> > > > >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > > > +	cfg->fpe_ctrl_sts_shadow = EFPE;
> > > >
> > > > What about just:
> > > > 	if (enable)
> > > > 		cfg->fpe_csr = EFPE;
> > > > 	else
> > > > 		cfg->fpe_csr = 0;
> > > >
> > > > 	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
> > > >
> > > > then ...
> > > >
> > > > >  }
> > > > >
> > > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> > > > > @@ -766,19 +764,17 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device
> > *dev)
> > > > >  	return status;
> > > > >  }
> > > > >
> > > > > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
> > > > > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > +			     enum stmmac_mpacket_type type)
> > > > >  {
> > > >
> > > > >  	u32 value;
> > > > >
> > > > > -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > +	value = cfg->fpe_ctrl_sts_shadow;
> > > > >
> > > > > -	if (type == MPACKET_VERIFY) {
> > > > > -		value &= ~SRSP;
> > > > > +	if (type == MPACKET_VERIFY)
> > > > >  		value |= SVER;
> > > > > -	} else {
> > > > > -		value &= ~SVER;
> > > > > +	else
> > > > >  		value |= SRSP;
> > > > > -	}
> > > > >
> > > > >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > >
> > > > this can be replaced with
> > > >
> > > > 	u32 value = cfg->fpe_csr;
> > > >
> > > > 	if (type == MPACKET_VERIFY)
> > > > 		value |= SVER;
> > > > 	else if (type == MPACKET_RESPONSE)
> > > > 		value |= SRSP;
> > > >
> > > > 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > >
> > > > >  }
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > index 53c138d..aca846d 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > > @@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est
> > *cfg,
> > > > >  			 unsigned int ptp_rate);
> > > > >  void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
> > > > >  			   struct stmmac_extra_stats *x, u32 txqcnt);
> > > > > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > > > > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > +			  u32 num_txq, u32 num_rxq,
> > > > >  			  bool enable);
> > > > >  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> > > > > +			     struct stmmac_fpe_cfg *cfg,
> > > > >  			     enum stmmac_mpacket_type type);
> > > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
> > > > >
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > > index 453e88b..a74e71d 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > > @@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct
> > > > stmmac_est *cfg,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> > > > > +static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > +				   u32 num_txq,
> > > > >  				   u32 num_rxq, bool enable)
> > > > >  {
> > > > >  	u32 value;
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > index b95d3e1..68aa2d5 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > > @@ -412,9 +412,11 @@ struct stmmac_ops {
> > > > >  			     unsigned int ptp_rate);
> > > > >  	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
> > > > >  			       struct stmmac_extra_stats *x, u32 txqcnt);
> > > > > -	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > > > > +	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > > > > +			      u32 num_txq, u32 num_rxq,
> > > > >  			      bool enable);
> > > > >  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> > > > > +				 struct stmmac_fpe_cfg *cfg,
> > > > >  				 enum stmmac_mpacket_type type);
> > > > >  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
> > > > >  };
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > index 3e50fd5..7791e9b 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool
> > > > is_up)
> > > > >  	bool *hs_enable = &fpe_cfg->hs_enable;
> > > > >
> > > > >  	if (is_up && *hs_enable) {
> > > > > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> > > > > +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > > > > +					MPACKET_VERIFY);
> > > > >  	} else {
> > > > >  		*lo_state = FPE_STATE_OFF;
> > > > >  		*lp_state = FPE_STATE_OFF;
> > > > > @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int
> > status)
> > > > >  		/* If user has requested FPE enable, quickly response */
> > > > >  		if (*hs_enable)
> > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > +						fpe_cfg,
> > > > >  						MPACKET_RESPONSE);
> > > > >  	}
> > > > >
> > > > > @@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
> > > > >  		if (*lo_state == FPE_STATE_ENTERING_ON &&
> > > > >  		    *lp_state == FPE_STATE_ENTERING_ON) {
> > > > >  			stmmac_fpe_configure(priv, priv->ioaddr,
> > > > > +					     fpe_cfg,
> > > > >  					     priv->plat->tx_queues_to_use,
> > > > >  					     priv->plat->rx_queues_to_use,
> > > > >  					     *enable);
> > > > > @@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
> > > > >  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> > > > >  				    *lo_state, *lp_state);
> > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > +						fpe_cfg,
> > > > >  						MPACKET_VERIFY);
> > > > >  		}
> > > > >  		/* Sleep then retry */
> > > > > @@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
> > > > >  	if (priv->plat->fpe_cfg->hs_enable != enable) {
> > > > >  		if (enable) {
> > > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > > +						priv->plat->fpe_cfg,
> > > > >  						MPACKET_VERIFY);
> > > > >  		} else {
> > > > >  			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
> > > > > @@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
> > > > >  	if (priv->dma_cap.fpesel) {
> > > > >  		/* Disable FPE */
> > > > >  		stmmac_fpe_configure(priv, priv->ioaddr,
> > > > > +				     priv->plat->fpe_cfg,
> > > > >  				     priv->plat->tx_queues_to_use,
> > > > >  				     priv->plat->rx_queues_to_use, false);
> > > > >
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > > index ac41ef4..6ad3e0a 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > > @@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
> > > > >
> > > > >  	priv->plat->fpe_cfg->enable = false;
> > > > >  	stmmac_fpe_configure(priv, priv->ioaddr,
> > > > > +			     priv->plat->fpe_cfg,
> > > > >  			     priv->plat->tx_queues_to_use,
> > > > >  			     priv->plat->rx_queues_to_use,
> > > > >  			     false);
> > > > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > > index 0b4658a..48385c7 100644
> > > > > --- a/include/linux/stmmac.h
> > > > > +++ b/include/linux/stmmac.h
> > > > > @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
> > > > >  	bool hs_enable;				/* FPE handshake enable */
> > > > >  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> > > > >  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> > > >
> > > > > +	u32 fpe_ctrl_sts_shadow;		/* shadow of MAC_FPE_CTRL_STS */
> > > >
> > > >   +	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> > > >
> > > > I would have had it named as "fpe_csr" - short and well readable
> > > > especially seeing CSR is a well known abbreviation for Control and
> > > > Status register, which the MAC_FPE_CTRL_STS register actually is.
> > > >
> > > > * Note one more time: current FPE handshaking implementation is vastly
> > > > clumsy, needlessly overcomplicated and prone to races. I would have
> > > > seriously considered having it refactored.
> > > >
> > > > -Serge(y)
> > > >
> > > > >  };
> > > > >
> > > > >  struct stmmac_safety_feature_cfg {
> > > > > --
> > > > > 1.8.3.1
> > > > >
> > >
> > > Hi Serge，
> > >
> > 
> > > Thanks for your comments and for pointing out the defects of the current FPE
> > > handshaking implementation. I know that my patch cannot solve all the
> > > defects of the current FPE handshaking. So, I want to know if it is necessary
> > > that I continue submitting this patch if you want to refactor the FPE
> > > handshaking further.
> > 
> > Your patch solves one of the issues the FPE code has. So please feel
> > free to submit it.
> > 
> > Regarding the FPE handshaking refactoring. I would have been glad to
> > do that if I had an FPE-capable device (alas my DW XGMAC device is of
> > v2.10a revision and couldn't have been even possibly equipped with
> > FPE), otherwise providing a not properly debugged/tested patch(es) we
> > may end up with just not working feature. In anyway it's not a reason
> > for you to stop fixing some other issues in the implementation. I just
> > noted that the current code has some other ones, which may bite the
> > users very hard in very unexpected points.
> > 
> > > Moreover, I want to add FPE handshaking support for DW
> > > XGMAC (add fpe_send_mpacket() & fpe_irq_status() to dwxlgmac2_core.c) after
> > > fixing this MAC_FPE_CTRL_STS register read issue.
> > 
> > Why not. Got ahead please. We'll have it reviewed.
> > 
> > -Serge(y)
> > 
> > >
> > > -Jianheng
> 
> Hi Serge,
> 

> That is great, pls help to check my patch update below.
> Thanks,

Please submit v2 patch in a normal way already. I'll give you my
comments there, if any.

One more note regarding the change. Please add a comment to the
dwmac5_fpe_irq_status() method above the readl() line that it's the
only place eligible to perform the reads from the MAC_FPE_CTRL_STS
register due to the problem you discovered.

-Serge(y)

> 
> -Jianheng
> 
> [PATCH v2] net: stmmac: fix FPE events losing
> 
> The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
> handler missing FPE event status and leads to FPE handshaking failure and
> retries.
> To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> MAC_FPE_CTRL_STS in those methods.
> 
> Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> Signed-off-by: jianheng <jianheng@synopsys.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 42 +++++++++-------------
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 ++-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 ++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 ++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
>  include/linux/stmmac.h                             |  1 +
>  7 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index e95d35f..53909dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
>  	}
>  }
>  
> -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			  u32 num_txq, u32 num_rxq,
>  			  bool enable)
>  {
>  	u32 value;
>  
> -	if (!enable) {
> -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -		value &= ~EFPE;
> -
> -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> -		return;
> +	if (enable) {
> +		cfg->fpe_csr = EFPE;
> +		value = readl(ioaddr + GMAC_RXQ_CTRL1);
> +		value &= ~GMAC_RXQCTRL_FPRQ;
> +		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> +	} else {
> +		cfg->fpe_csr = 0;
>  	}
> -
> -	value = readl(ioaddr + GMAC_RXQ_CTRL1);
> -	value &= ~GMAC_RXQCTRL_FPRQ;
> -	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> -
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -	value |= EFPE;
> -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
>  }
>  
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> @@ -766,19 +760,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
>  	return status;
>  }
>  
> -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
> +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			     enum stmmac_mpacket_type type)
>  {
> -	u32 value;
> +	u32 value = cfg->fpe_csr;
>  
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -	if (type == MPACKET_VERIFY) {
> -		value &= ~SRSP;
> +	if (type == MPACKET_VERIFY)
>  		value |= SVER;
> -	} else {
> -		value &= ~SVER;
> +	else if (type == MPACKET_RESPONSE)
>  		value |= SRSP;
> -	}
>  
>  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> index 53c138d..34e6207 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> @@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
>  			 unsigned int ptp_rate);
>  void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt);
> -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			  u32 num_txq, u32 num_rxq,
>  			  bool enable);
>  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> +			     struct stmmac_fpe_cfg *cfg,
>  			     enum stmmac_mpacket_type type);
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 453e88b..a74e71d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> -static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> +static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +				   u32 num_txq,
>  				   u32 num_rxq, bool enable)
>  {
>  	u32 value;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index b95d3e1..68aa2d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -412,9 +412,11 @@ struct stmmac_ops {
>  			     unsigned int ptp_rate);
>  	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
>  			       struct stmmac_extra_stats *x, u32 txqcnt);
> -	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			      u32 num_txq, u32 num_rxq,
>  			      bool enable);
>  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> +				 struct stmmac_fpe_cfg *cfg,
>  				 enum stmmac_mpacket_type type);
>  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
>  };
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3e50fd5..7791e9b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  	bool *hs_enable = &fpe_cfg->hs_enable;
>  
>  	if (is_up && *hs_enable) {
> -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> +					MPACKET_VERIFY);
>  	} else {
>  		*lo_state = FPE_STATE_OFF;
>  		*lp_state = FPE_STATE_OFF;
> @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  		/* If user has requested FPE enable, quickly response */
>  		if (*hs_enable)
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						fpe_cfg,
>  						MPACKET_RESPONSE);
>  	}
>  
> @@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  		if (*lo_state == FPE_STATE_ENTERING_ON &&
>  		    *lp_state == FPE_STATE_ENTERING_ON) {
>  			stmmac_fpe_configure(priv, priv->ioaddr,
> +					     fpe_cfg,
>  					     priv->plat->tx_queues_to_use,
>  					     priv->plat->rx_queues_to_use,
>  					     *enable);
> @@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
>  				    *lo_state, *lp_state);
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						fpe_cfg,
>  						MPACKET_VERIFY);
>  		}
>  		/* Sleep then retry */
> @@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
>  	if (priv->plat->fpe_cfg->hs_enable != enable) {
>  		if (enable) {
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						priv->plat->fpe_cfg,
>  						MPACKET_VERIFY);
>  		} else {
>  			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
> @@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
>  	if (priv->dma_cap.fpesel) {
>  		/* Disable FPE */
>  		stmmac_fpe_configure(priv, priv->ioaddr,
> +				     priv->plat->fpe_cfg,
>  				     priv->plat->tx_queues_to_use,
>  				     priv->plat->rx_queues_to_use, false);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac41ef4..6ad3e0a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
>  
>  	priv->plat->fpe_cfg->enable = false;
>  	stmmac_fpe_configure(priv, priv->ioaddr,
> +			     priv->plat->fpe_cfg,
>  			     priv->plat->tx_queues_to_use,
>  			     priv->plat->rx_queues_to_use,
>  			     false);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 0b4658a..dee5ad6 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
>  	bool hs_enable;				/* FPE handshake enable */
>  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
>  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
>  };
>  
>  struct stmmac_safety_feature_cfg {
> -- 
> 1.8.3.1
> 
> 
