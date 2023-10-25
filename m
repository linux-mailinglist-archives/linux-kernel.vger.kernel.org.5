Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3F7D773F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJYV7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjJYV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:59:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A39B9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:59:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA9C433C8;
        Wed, 25 Oct 2023 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698271176;
        bh=FXh3Ybrebr/+Js1FhuGaszskuuHKYGlgnfDkMM4tAAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KhHLXM4cfTGTGeGv8+z8igpASojb9gPJgkmfMKtp47yAVdGZw17msJeGgO+gI5/4Q
         4EmzQ55ic/XC+B/n/rb5p8oep/6uFopul3g9fgraBCeWg9AE9UkTEUnVyJ9DtuUP9q
         1r3JkwBXgQ+tg/QW20O09brzuHKkg5QfeH9x3nNF/F4hQV+NuURuqE9/j5kLhBBYUE
         Yu/ygR31OhHL/MRzVdpsXMdMBTI8t+h5IR2tcJzRjkdS9Wp8tURVRRpwPY2gO7wu7X
         KkKOdi8HpeUDIpHxXXA7R0g0uzJzzi6ztvoBVK2it5EXbM3Ee5Hk8rgdpWysZW4kxK
         D2m1tWZ2Odapw==
Date:   Wed, 25 Oct 2023 14:59:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231025145934.22218b3e@kernel.org>
In-Reply-To: <20231023093343.2370248-6-o.rempel@pengutronix.de>
References: <20231023093343.2370248-1-o.rempel@pengutronix.de>
        <20231023093343.2370248-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 11:33:39 +0200 Oleksij Rempel wrote:
> +	struct net_device *slave = dsa_to_port(ds, port)->slave;
> +	const unsigned char *addr = slave->dev_addr;

Doesn't apply any more, after Florian's slave -> user rename.
Please rebase and s/slave/user/ as needed.
