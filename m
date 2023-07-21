Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE975BCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGUDSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGUDR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C9270F;
        Thu, 20 Jul 2023 20:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB09061CE6;
        Fri, 21 Jul 2023 03:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E8FC433C7;
        Fri, 21 Jul 2023 03:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689909475;
        bh=lZCRel7jgN9X7NBylu6tXAt5SKl31rc26PRheAuhhVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H3vMtko7PATu6lT20kSpEDEMRsJ/nLxpR29nAIJjFi3Ua7RR2i7ZQVAj4wqxohJx3
         aV1WQkgIZASjKisP7u1jLt7xRhfNVz9cuPm0t1qndRabVCvHI30/upQ9mxDz/D0XDe
         qGhy7VfDJviQ8S2yB5bEKCLRlezi1WSiEOcqT2hzN8Jgq/rGMkmTNwO7xsH3Kpq8g8
         WIHSmW048I7og4nJWLahYZYscdzGkOWAb1AmTGdKb0bTuPbYkOO02a8y6iJ8RtKbwQ
         a/P0M7ch5gw7VmlK3r8K76ZZvmqieLvYGDRgUIRZpazzAIQNFitw9w0swmihvA+Vwg
         bK2G4S8cemYPg==
Date:   Thu, 20 Jul 2023 20:17:53 -0700
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
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/6] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20230720201753.27563c1e@kernel.org>
In-Reply-To: <20230720132556.57562-4-o.rempel@pengutronix.de>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
        <20230720132556.57562-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 15:25:53 +0200 Oleksij Rempel wrote:
> Add WoL support for KSZ9477 family of switches. This code was tested on
> KSZ8563 chip and supports only wake on Magic Packet for now.
> Other parts needed for fully operational WoL support are in the followup
> patches.

This one doesn't apply on net-next/main.
-- 
pw-bot: cr
