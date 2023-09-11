Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF779C038
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbjIKVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbjIKRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:02:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F7A123;
        Mon, 11 Sep 2023 10:02:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so6135845a12.2;
        Mon, 11 Sep 2023 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694451747; x=1695056547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx7Z3G6TG2avGQh5qW28D9cnQGBkHNI8APKRcgvj8pQ=;
        b=nzuNuEfgJoaZ8ctfulG9O+a/kGh8zC6E9VJUaiPDATak0p9ytn7SKAFK8xH8pkpGUD
         Ca+U21EH4GczWFII6EUbOH3DluQoVgEBjeyqMpV3Lxh3A29C6O6F7rrvsJKjrOx42s/g
         gvCPYS5tkrAVqofszHR1y+UwLWz+q+54ofzcc9BA7VzgUa2sx9EpcilPQ/TuvhLa3NUD
         l4SKENpu2UUw8uftvPk2ZQY/lnKhdkAe83MB1WxHYElekbOIyWvb5mN9y+72BI8wUnKs
         vExRWHvfYzjFvszEOUJQHvOtQaCiPg5cV1o1Er+pBnmpsAyxBosgZ/H8PQkHce+N12Xl
         Zq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451747; x=1695056547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx7Z3G6TG2avGQh5qW28D9cnQGBkHNI8APKRcgvj8pQ=;
        b=WIQfsHcVkN3VTZECugZFar3+5VceFekPx1yWowjZ+OzP2gINwzB6xYt01bBHFFTC3z
         SC5TwNOdgmsT10kgkhHC3jpwX2SYHdLyd68kgbJsDD1fHsJ6qvXGgHt3GBwRhTdwwLew
         Pt/uqaMBhi0+zTh+XkVkdNYz9bJtlxuxgovRQEF4krIZh1MFT9LcLIMqsC8Aavd2irHH
         TFmzGa7tjH3xkAMi7mQica/6fIoN/GGjyX5JqeYbmy0pTPktrkiKfgqoYZ92MSGbDezf
         5np7jcGESja+izxuL1guvkv3tx7E6zCb/EMliPykrvAIp9VBd2Y4ZmDn3eXruwZ30rkT
         GlJA==
X-Gm-Message-State: AOJu0YyenXBsUkfD8cvrPKN2JCaXxMLNGn8iD2c5fKdrfD823Y2dCsax
        r6shksHHISnfgKITbul9pbY=
X-Google-Smtp-Source: AGHT+IFdN1FH5jz8hi8cj7z87DfB50l9K9XRcmjaFnVCZO7Htji79T4QMjFEDfv19+SOFie1FB70MA==
X-Received: by 2002:a17:906:8475:b0:9a1:b5fc:8c56 with SMTP id hx21-20020a170906847500b009a1b5fc8c56mr8914915ejc.55.1694451746889;
        Mon, 11 Sep 2023 10:02:26 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id se22-20020a170906ce5600b009920e9a3a73sm5674085ejb.115.2023.09.11.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:02:24 -0700 (PDT)
Date:   Mon, 11 Sep 2023 20:02:22 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230911170222.hip2pcyzbfu3olau@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911160501.5vc4nttz6fnww56h@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:05:01PM +0300, Vladimir Oltean wrote:
> Actually, the reason why I haven't yet said anything is because it made
> me realize that there is a pre-existing bug in net/dsa/slave.c where we
> have this pattern:
> 
> 	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
> 		dev_uc_add(master, dev->dev_addr);
> 
> but there is no replay of the dev_uc_add() call when the master->dev_addr
> changes. This really results in RX packet loss, as I have tested. I don't
> know what is the best way to solve it.

Hi @Jakub, I remember you fixed some issues with the dev->dev_addr writes,
after dev_addr_lists.c was changed to a rbtree. Is it easy for you to
tell if the change below is safe from an API perspective?

Is the answer "yes, because dev_uc_add() uses an addr_type of NETDEV_HW_ADDR_T_UNICAST,
and dev->dev_addr uses NETDEV_HW_ADDR_T_LAN, so they never share a struct netdev_hw_addr
for the same MAC address, and thus, they never collide"?

The DSA and 8021q drivers currently have this pattern, from around 2008.
But 8021q also tracks NETDEV_CHANGEADDR events on the real_dev, which is
absent in DSA. If the change below is safe, it would be a simpler solution.

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 48db91b33390..e40474e13660 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -374,11 +374,9 @@ static int dsa_slave_open(struct net_device *dev)
 			goto out;
 	}

-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr)) {
-		err = dev_uc_add(master, dev->dev_addr);
-		if (err < 0)
-			goto del_host_addr;
-	}
+	err = dev_uc_add(master, dev->dev_addr);
+	if (err < 0)
+		goto del_host_addr;

 	err = dsa_port_enable_rt(dp, dev->phydev);
 	if (err)
@@ -387,8 +385,7 @@ static int dsa_slave_open(struct net_device *dev)
 	return 0;

 del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	dev_uc_del(master, dev->dev_addr);
 del_host_addr:
 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
@@ -404,8 +401,7 @@ static int dsa_slave_close(struct net_device *dev)

 	dsa_port_disable_rt(dp);

-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	dev_uc_del(master, dev->dev_addr);

 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
@@ -469,14 +465,11 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 			return err;
 	}

-	if (!ether_addr_equal(addr->sa_data, master->dev_addr)) {
-		err = dev_uc_add(master, addr->sa_data);
-		if (err < 0)
-			goto del_unicast;
-	}
+	err = dev_uc_add(master, addr->sa_data);
+	if (err < 0)
+		goto del_unicast;

-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	dev_uc_del(master, dev->dev_addr);

 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
