Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B497A213E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjIOOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjIOOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:43:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2273C1BE6;
        Fri, 15 Sep 2023 07:43:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so298024366b.3;
        Fri, 15 Sep 2023 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694789016; x=1695393816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4v+k4iIOLRA11slfCdOqaI7i0UaMHyxjjtS6ZrpJ86g=;
        b=XdAaHq4oJ0oRKmOqlGMHlZw0voyyXWnFE35T9tdQfmzKRLzuU/p0tji8iJabcQ752H
         smDdWY5zBNgLOI9fbmkJ1dnwx1YyaX8KohglUr/tfF4I5bbEE7KEj4ZWoOAjs3thMYHE
         1ERhwP1ZouhbSQthSN1sQmIiUJM1kfgNwEAiw+uRQTgXKuE1+s4Yiz+ClyEwocxZB43X
         eDEytNmEmiCJqbdZJgbQ2yi6d9BCUY5ljzLuCapB/B9usdKfuUUnnqWEst9OabD/DGc2
         lYy4F/sQSXWUaav38ClUeksipekqRpi+4stvqG8nd/mafFoaOmrKmQK6SO78mseJbT5e
         2aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694789016; x=1695393816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v+k4iIOLRA11slfCdOqaI7i0UaMHyxjjtS6ZrpJ86g=;
        b=guEX697M4/vL4Zi4BctYJnBlv7leSq3IkN0kTJTKal8+3bk/ywtchy4SGSfYVOOBir
         sW+LX7GNmc1sh8gUCZiYHMvUuIgAfLqTnAOpEsmnTx4ALNSfbXyh8tJYMUJ+5YuBeAk0
         AXXvWFDIDcwOyMAB/Z5D694eeIs/+1wVkHorhEgeJNm8T4sKtEHxwdq9Rxt7RgiIxFgl
         ba0YqVTxKB1itQ4jkSTrKuxq093iSDDUt5ckCx8XxdXEe6+DAXil7v2pnzSV53O6bWv+
         9OUbLdns2JCv9wv9Fg8i4jpqhqBJ/OkTDsxgzvyAX9yh31AfoIFWVVdCI1GMHUJiRFLC
         4G1A==
X-Gm-Message-State: AOJu0YwMeUmWvyekrJWdqsEdLf6KcSQL/YQudMx3dW9vbxGrv8nraJH/
        4snKfYJ8ojIE3GzbRhi1FR09nIpgKqcZmw==
X-Google-Smtp-Source: AGHT+IGADNU8LriUdPkveoqZ6kGPTfZELrBXIpf1W/4OA+1Lv7BZl2faW4IoQ4vDbdcJb+EmbhEQQg==
X-Received: by 2002:a17:906:30c2:b0:9a9:f2fd:2a2b with SMTP id b2-20020a17090630c200b009a9f2fd2a2bmr1582575ejb.73.1694789016335;
        Fri, 15 Sep 2023 07:43:36 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id bq14-20020a170906d0ce00b0099ddc81903asm2497650ejb.221.2023.09.15.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:43:36 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:43:33 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <20230915144333.2rfp33pujgacsjie@skbuf>
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-2-o.rempel@pengutronix.de>
 <20230914131145.23336-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914131145.23336-2-o.rempel@pengutronix.de>
 <20230914131145.23336-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:11:45PM +0200, Oleksij Rempel wrote:
> This patch adds partial Access Control List (ACL) support for the
> ksz9477 family of switches. ACLs enable filtering of incoming layer 2
> MAC, layer 3 IP, and layer 4 TCP/UDP packets on each port. They provide
> additional capabilities for filtering routed network protocols and can
> take precedence over other forwarding functions.
> 
> ACLs can filter ingress traffic based on header fields such as
> source/destination MAC address, EtherType, IPv4 address, IPv4 protocol,
> UDP/TCP ports, and TCP flags. The ACL is an ordered list of up to 16
> access control rules programmed into the ACL Table. Each entry specifies
> a set of matching conditions and action rules for controlling packet
> forwarding and priority.
> 
> The ACL also implements a count function, generating an interrupt
> instead of a forwarding action. It can be used as a watchdog timer or an
> event counter. The ACL consists of three parts: matching rules, action
> rules, and processing entries. Multiple match conditions can be either
> AND'ed or OR'ed together.
> 
> This patch introduces support for a subset of the available ACL
> functionality, specifically layer 2 matching and prioritization of
> matched packets. For example:
> 
> tc qdisc add dev lan2 clsact
> tc filter add dev lan2 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> tc qdisc add dev lan1 clsact
> tc filter add dev lan1 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> The hardware offloading implementation was benchmarked against a
> configuration without hardware offloading. This latter setup relied on a
> software-based Linux bridge. No noticeable differences were observed
> between the two configurations. Here is an example of software-based
> test:
> 
> ip l s dev enu1u1 up
> ip l s dev enu1u2 up
> ip l s dev enu1u4 up
> ethtool -A enu1u1 autoneg off rx off tx off
> ethtool -A enu1u2 autoneg off rx off tx off
> ethtool -A enu1u4 autoneg off rx off tx off
> ip l a name br0 type bridge
> ip l s dev br0 up
> ip l s enu1u1 master br0
> ip l s enu1u2 master br0
> ip l s enu1u4 master br0
> 
> tc qdisc add dev enu1u1 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u4 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u2 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> 
> tc qdisc add dev enu1u1 clsact
> tc filter add dev enu1u1 ingress protocol ipv4  flower action skbedit prio 7
> 
> tc qdisc add dev enu1u4 clsact
> tc filter add dev enu1u4 ingress protocol ipv4  flower action skbedit prio 0
> 
> On a system attached to the port enu1u2 I run two iperf3 server
> instances:
> iperf3 -s -p 5210 &
> iperf3 -s -p 5211 &
> 
> On systems attached to enu1u4 and enu1u1 I run:
> iperf3 -u -c  172.17.0.1 -p 5210 -b100M  -l1472 -t100
> and
> iperf3 -u -c  172.17.0.1 -p 5211 -b100M  -l1472 -t100
> 
> As a result, IP traffic on port enu1u1 will be prioritized and take
> precedence over IP traffic on port enu1u4
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

I think it is an inconsistent style decision for ksz9477_port_acl_init()
to be called from ksz_port_setup() -> dev->dev_ops->port_setup() while
ksz9477_port_acl_free() is called directly from ksz_port_teardown()
without an intermediary (and similar) dev->dev_ops->port_teardown(),
but that is only a style nitpick and should not block the merging of
this patch.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
