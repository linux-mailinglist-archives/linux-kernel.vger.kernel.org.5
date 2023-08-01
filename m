Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F876B4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHAMbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHAMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:31:21 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF091FC8;
        Tue,  1 Aug 2023 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bzAyDaYKheMlsEXYtFHUp4oTpXTxaVR8hJ5XqEVy6bs=; b=T8N80gOQyDEqe6GTu5TM/vjPkK
        fPVcsGnPoGUrVfE+mqYNwpkz4dBH2kdKiq+43vgbRIstMoKw949841Gx/8AresWQldkOytqbsiA0G
        Q4N7SjEQeFDZSsGeUKLDj0dIC0EVyYouLMVEbwBIqWPep157qJpiTjbVk1SD8rPvBLmAi2EGLeza4
        w1+orDVNenjbr7/6T+i7BGfgdV0V0tt+ZIBFLCJsr3ZO4zhOtKnRIdWDLkBOqOfL3+5T9c2S1ciYT
        CSr0Y6+CtbcXMAgHMRoq/Hx/Z1LseEAmPAF/6KUZhoCshi4tx1VHgusSc/Enaj0+TnC5kKjdBwBde
        P9XNzCFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52012)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQoWq-000449-1e;
        Tue, 01 Aug 2023 13:31:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQoWo-0000gh-I9; Tue, 01 Aug 2023 13:31:06 +0100
Date:   Tue, 1 Aug 2023 13:31:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] net-next: mvpp2: relax return value check for IRQ
 get
Message-ID: <ZMj7Cp3fhN7GmCZp@shell.armlinux.org.uk>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
 <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:04:24PM +0300, Matti Vaittinen wrote:
> fwnode_irq_get[_byname]() were changed to not return 0 anymore.
> 
> Drop check for return value 0.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Sorry, but I don't think you've properly considered the effects of your
patch.

> @@ -5833,7 +5833,7 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
>  			v->irq = of_irq_get_byname(port_node, irqname);
>  		else
>  			v->irq = fwnode_irq_get(port->fwnode, i);
> -		if (v->irq <= 0) {
> +		if (v->irq < 0) {

You're making this change based on the assumption that fwnode_irq_get()
has changed its return values, but I really don't think you've looked
at the code and considered the return value behaviour of the DT function
above. Reading it's documentation, it states that of_irq_get_byname()
may return 0 on IRQ mapping failure.

So, by making this change, you are allowing IRQ mapping failure in the
DT path to succeed rather than fail.

>  			ret = -EINVAL;
>  			goto err;
>  		}
> @@ -6764,7 +6764,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  		err = -EPROBE_DEFER;
>  		goto err_deinit_qvecs;
>  	}
> -	if (port->port_irq <= 0)
> +	if (port->port_irq < 0)

Exactly the same problem here, but...

>  		/* the link irq is optional */
>  		port->port_irq = 0;

this is less critical... but still wrong.

So, given that this patch is basically incorrect...

NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
