Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D275194F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGMHGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjGMHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:06:37 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8E119;
        Thu, 13 Jul 2023 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eQ/LFkDYElioH91NZhzdrHW+i+w8b59jw0PilkxQn5U=; b=lok/Ty9gc+9ceqLx7wvXtFv4rj
        NcCmCJexavQzqRQK1jk3M91UyOXRxJAb0t31cX5gxm9+VTka2hy5fwCxh+9Qs0XFK2G2hBbxShT53
        1JiywOFMbtrTNXjEOy1slQBlPx0/HI+GLzjK9nosTOaESycmRTBqtKLvIMxzl0qKjfcwLspvQDnhD
        htd+j4B4ffQbhTi/TP+yiUK8VfC8IMr3KXkuQs2SYaGPICq4x/Na1ZIiceeB0wbtuvNADSzAVl6My
        gtENuGSPDHKsR+sLiwU67Abe+AN0ooXMTV2NGFV6utVKMcfcwJI+0V/FI4ks4yrIfb6kEbu4hmXaj
        x1YVl2ZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60704)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qJqPE-0005oa-06;
        Thu, 13 Jul 2023 08:06:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qJqP6-0005us-Ga; Thu, 13 Jul 2023 08:06:20 +0100
Date:   Thu, 13 Jul 2023 08:06:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: Re: [PATCH v2 net-next 3/9] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V1 capability bit
Message-ID: <ZK+ibBKWFRniQ8rK@shell.armlinux.org.uk>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <a2022fd2db0f7ed54ab07bb93b04aa9fc59033b5.1689012506.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2022fd2db0f7ed54ab07bb93b04aa9fc59033b5.1689012506.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:18:23AM +0100, Daniel Golle wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Introduce MTK_NETSYS_V1 bit in the device capabilities for
> MT7621/MT7622/MT7623/MT7628/MT7629 SoCs.
> Use !MTK_NETSYS_V1 instead of MTK_NETSYS_V2 in the driver codebase.
> This is a preliminary patch to introduce support for MT7988 SoC.

Rather than using capability bits for versions, would it make more
sense to use an integer for this, so you can do:

	if (eth->soc->netsys_version >= 2) {
		version 2 and later stuff
	} else {
		previous version stuff
	}

?

I'm just thinking ahead to when we end up with stuff that v1 and v2
need but v3 and later don't.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
