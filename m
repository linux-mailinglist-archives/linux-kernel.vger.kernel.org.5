Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56397E6674
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjKIJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjKIJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:16:24 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745A268D;
        Thu,  9 Nov 2023 01:16:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B80460009;
        Thu,  9 Nov 2023 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699521380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3yh8PqTdV++lp9Hlak0Ojq8NdsXQDIGt0OtBSub/wI=;
        b=bk/jsVoPypHHxC762ajM6+kby/KFGKqJPJCv+Zh6Alhuvow3sYqqCnsqeNm+PR/poNdoIs
        FeplkxDXwNN6TBKqr2X2Jw7eKESVdroWDH/kw059/rSzHZvZcof50gyCsHih4H33DwZNNG
        ji+AVRBQTBELapFe4/QfUBjLyntZybveTS9Qj3+cQxOkf5MT2Vk+dYkOqkGJXKwNFII4LU
        FPjvO8Y0y0CgarKViiKki8CgWm/Cxc2dxVevPFfNUjLOBHF0uTHRa21oK6OqPoeZ4FQwmd
        3Cmybvpdr4gMqwtJIujNGE9qrNcBgkNRhAt6uM/A9SykbDZgDZK9xHCC2o4rYQ==
Date:   Thu, 9 Nov 2023 10:16:18 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231109101618.009efb45@fedora>
In-Reply-To: <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
        <20231108113445.24825-2-quic_luoj@quicinc.com>
        <20231108131250.66d1c236@fedora>
        <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 9 Nov 2023 16:32:36 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

[...]

> > What I understand from this is that this PHY can be used either as a
> > switch, in which case port 4 would be connected to the host interface
> > at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> > speed would be limited to 1G per-port, is that correct ?  
> 
> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> PHYs can support to the max link speed 2.5G, actually the PHY can
> support to max link speed 2.5G for all supported interface modes
> including qusgmii and sgmii.

I'm a bit confused then, as the USGMII spec says that Quad USGMII really
is for quad 10/100/1000 speeds, using 10b/8b encoding.

Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
 with 66b/64b encoding ?

Thanks,

Maxime
