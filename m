Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C77A9D05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjIUT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIUT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C313A1505;
        Thu, 21 Sep 2023 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CC2gkTGhITx2Tkn4hzBnyxcQlVD3H0K9p7hCx7iKc0I=; b=RX/Dh/JlHN7+Dr2mKIx1OHw08j
        abawgMlrvxjDlsbIPFGzplofhq7VcEHhhGFZr5v8TUs2rmkpzNCwTdiU/ex1Izqw2rmGLteOf6T3b
        rafTyBkIl6Vl7p+9BVOfWbBV6ztXErezBRlJ0k1UNn9OTHkTcAr7tQi0CZZ2getl6yCEM4qAHxcUF
        0KrBEHNL0Z7sRA9uEwAO55WvgagpdOLapZsmOUsOq3ojQ/D5eDQ9JBA++gwR1mHYPfVN/hpVeI3CF
        AADotTfqbGiEqrhzLlKFo3aGvIzijqZ5x69wIwORuvfZRHh61rlcTaxBdznV8HpM6ZdVxWJ73Kr2f
        hqa/s60A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56250)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qjJk4-0004de-0F;
        Thu, 21 Sep 2023 14:29:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qjJjc-0003ZN-MP; Thu, 21 Sep 2023 14:28:48 +0100
Date:   Thu, 21 Sep 2023 14:28:48 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        David E Box <david.e.box@intel.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: enable Intel mGbE 1G/2.5G
 auto-negotiation support
Message-ID: <ZQxFEChbKJtsGm2w@shell.armlinux.org.uk>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-5-yong.liang.choong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921121946.3025771-5-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 08:19:45PM +0800, Choong Yong Liang wrote:
> +#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)

There shouldn't be any need to make this conditional.

> +static int stmmac_mac_prepare(struct phylink_config *config, unsigned int mode,
> +			      phy_interface_t interface)
> +{
> +	struct net_device *ndev = to_net_dev(config->dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret = 0;
> +
> +	priv->plat->phy_interface = interface;
> +
> +	if (priv->plat->config_serdes)
> +		ret = priv->plat->config_serdes(ndev, priv->plat->bsp_priv);

Please call this "phylink_mac_prepare" and pass the parameters that
phylink passes you to this function, so we don't end up at a later
date with people needing to extend this function to do other stuff,
thus repeating mistakes from earlier.

This is what has led to some very yucky code in all those
"fix_mac_speed" implementations, with duplicated data in the BSPs
to get the PHY mode and store it separately, etc.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
