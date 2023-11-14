Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACE7EAF91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjKNMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjKNMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:00:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F6F1;
        Tue, 14 Nov 2023 04:00:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso75280441fa.2;
        Tue, 14 Nov 2023 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699963200; x=1700568000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6KJAeM0fgwzrataiQJvaJXR0VKO4m2xUhSp/qxzWEU=;
        b=Ck8s53FbMCarzT+7VjnwgMYBHVYsiOEQqKIMKU6p5v2Y2xa6+AZ1tjGoaEO/hzdsNT
         cWE8ShUiMqIMtNi4bC/UEgbTxvfMreDMxVsniv/PQ4NUE54hZ1VAz0BRoMPEorlH23pP
         VfmBKIk8GXaNKRzwvK//H6kJukBxO8GJIRM3B+z14XaOwklyH8QGevoopexQpEY2qQl+
         +Fbs55V7spWKJC2/f69qgp/Uuoi+6sIvkrvxr9GsmLy707Qk+NzGH9lkrNzK9q+MuFYo
         x/7oHsafeUmpHYkQzLNynG9EUUPZFZ1zzhTxBCHF7lKTAIpZjEXzg8KYW6ezfdNqNqJT
         KfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699963200; x=1700568000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6KJAeM0fgwzrataiQJvaJXR0VKO4m2xUhSp/qxzWEU=;
        b=c6m6bGXwC14AFA4+aJ0hq0mqcNxtFkjH1wBEV4X5vlUv9foaEl0CsaOO6gSFjzAmD5
         ++OJGjlacozr4w8SjpD0Glsd8H9tnMXgamWzf11+T/SgOTqVGL+L3yiLFzIrW8uKrJs/
         JNWiIArOt4hNUXettlwMizhTfQNlQJQj1a+fSJi8q721LCl+5TPTiDArttm6ikf024nu
         goe3DliRjmzV5PSr03girFjap/C86NiG9ZW7Y1IjqHyX4MMTd8FAjEmxfHpDJ/NCGGef
         aJd5/HUJ2lVuLcd3CTf+JdhyHFr1lb7LXqRZNGvCaf2LBbXg46kQ0UILKcd/5iWeQjpv
         /KmA==
X-Gm-Message-State: AOJu0Yzj1VNetkLLA9XghKN+mZeU9FhpibFrscoS0Xtu9CV00RP2wsAH
        QJ2Uj6pxy4GsaUoTZDSV6hQ=
X-Google-Smtp-Source: AGHT+IGkg/dZ2j3ZhRtPnnWF3nQd6Z1yanz+Og6hQVCouER01/X1PxmY2rEi6+qInKZZQyQytLevyw==
X-Received: by 2002:a05:651c:1055:b0:2c5:3139:2d04 with SMTP id x21-20020a05651c105500b002c531392d04mr1494405ljm.47.1699963200069;
        Tue, 14 Nov 2023 04:00:00 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w21-20020a05651c119500b002c847782e14sm590774ljo.95.2023.11.14.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:59:59 -0800 (PST)
Date:   Tue, 14 Nov 2023 14:59:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
Message-ID: <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
> bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
> avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
> the FPE handshake retries.
> 
> The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> Those bits are clear on read (or write of 1 when RCWE bit in
> MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> MAC_FPE_CTRL_STS control bits makes side effects that clear the status
> bits. Then the stmmac interrupt handler missing FPE event status and
> leads to FPE handshake failure and retries.
> 
> The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reserved
> that have no access side effects, so can use 8-bit access for
> MAC_FPE_CTRL_STS control bits.
> 
> Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> Signed-off-by: jianheng <jianheng@synopsys.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index e95d35f..7333995 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
>  	u32 value;
>  
>  	if (!enable) {

> -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> +		value = readb(ioaddr + MAC_FPE_CTRL_STS);

Note this may break the platforms which don't support non-32 MMIOs for
some devices. None of the currently supported glue-drivers explicitly
state they have such peculiarity, but at the same time the STMMAC-core
driver at the present state uses the dword IO ops only. For instance
the PCIe subsystem has the special accessors for such cases:
pci_generic_config_read32()
pci_generic_config_write32()
which at the very least are utilized on the Tegra and Loongson
platforms to access the host CSR spaces. These platforms are also
equipped with the DW MACs. The problem might be irrelevant for all the
currently supported DW MAC controllers implementations though, but
still it worth to draw an attention to the problem possibility and in
order to prevent it before ahead it would be better to just avoid
using the byte-/word- IOs if it's possible.

-Serge(y)

>  
>  		value &= ~EFPE;
>  
> -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +		writeb(value, ioaddr + MAC_FPE_CTRL_STS);
>  		return;
>  	}
>  
> @@ -729,9 +729,9 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
>  	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
>  	writel(value, ioaddr + GMAC_RXQ_CTRL1);
>  
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> +	value = readb(ioaddr + MAC_FPE_CTRL_STS);
>  	value |= EFPE;
> -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +	writeb(value, ioaddr + MAC_FPE_CTRL_STS);
>  }
>  
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> @@ -770,7 +770,7 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type
>  {
>  	u32 value;
>  
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> +	value = readb(ioaddr + MAC_FPE_CTRL_STS);
>  
>  	if (type == MPACKET_VERIFY) {
>  		value &= ~SRSP;
> @@ -780,5 +780,5 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type
>  		value |= SRSP;
>  	}
>  
> -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +	writeb(value, ioaddr + MAC_FPE_CTRL_STS);
>  }
> -- 
> 1.8.3.1
> 
> 
