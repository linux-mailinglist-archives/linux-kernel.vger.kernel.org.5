Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD82769AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjGaPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGaPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:40:08 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DAA1713;
        Mon, 31 Jul 2023 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M7bzdQSRGVpDVr3CMEAqQUVUanffXqBwkJftx8SZ7Bc=; b=0xRtmmCs2S3Ooou5AhnJSgbCxl
        sGNMPkdFcml+cmxF036cHSY9wkSGVo/9sKJKol2rMPqebpHh+5D/7YJxjGhuVQGDYqyBKWugvbBdF
        5IqTvgceGfqkZ7A8+93tycJ8SwP8xLfMXox01P7tt4Uqnb7FwpkRong7c8C5RGBM1QONIZt1gWdz6
        b2zNG5GvQvXxwMvEIXQrVWSNuhfoMFWVWeRwxkpa4148T4ZO4HSqN7sBorgcUidAfxtlXyEXweevy
        2CwIpqt6KrAScTSHFzPVOfPN7OrE08oN3f3JmlBR6wMcTLEG7+urR4YgQvzqyIEBTDbdScKJ1TjmT
        UErXI09w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45756)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQUzy-0002n5-1m;
        Mon, 31 Jul 2023 16:39:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQUzx-0008Aw-4m; Mon, 31 Jul 2023 16:39:53 +0100
Date:   Mon, 31 Jul 2023 16:39:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ZMfVyT1QEFad1iOn@shell.armlinux.org.uk>
References: <20230731102254.2c9868ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731102254.2c9868ca@canb.auug.org.au>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:22:54AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   net/dsa/port.c
> 
> between commit:
> 
>   9945c1fb03a3 ("net: dsa: fix older DSA drivers using phylink")
> 
> from the net tree and commit:
> 
>   a88dd7538461 ("net: dsa: remove legacy_pre_march2020 detection")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc net/dsa/port.c
> index 2f6195d7b741,c63cbfbe6489..000000000000
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@@ -1720,22 -1686,8 +1686,15 @@@ int dsa_port_phylink_create(struct dsa_
>   	if (err)
>   		mode = PHY_INTERFACE_MODE_NA;
>   
> - 	/* Presence of phylink_mac_link_state or phylink_mac_an_restart is
> - 	 * an indicator of a legacy phylink driver.
> - 	 */
> - 	if (ds->ops->phylink_mac_link_state ||
> - 	    ds->ops->phylink_mac_an_restart)
> - 		dp->pl_config.legacy_pre_march2020 = true;
> - 
>  -	if (ds->ops->phylink_get_caps)
>  +	if (ds->ops->phylink_get_caps) {
>   		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
>  +	} else {
>  +		/* For legacy drivers */
>  +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
>  +			  dp->pl_config.supported_interfaces);
>  +		__set_bit(PHY_INTERFACE_MODE_GMII,
>  +			  dp->pl_config.supported_interfaces);
>  +	}
>   
>   	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
>   			    mode, &dsa_port_phylink_mac_ops);

LGTM, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
