Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A475D8BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGVBfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVBfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54879E65;
        Fri, 21 Jul 2023 18:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E656161DB2;
        Sat, 22 Jul 2023 01:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FEDC433C8;
        Sat, 22 Jul 2023 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689989742;
        bh=r/Nk9KN99l0Bag1DYaQNMy0EOSREbOkqIPysbMSeM9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmYbFR9pF9sEDMNWKL+Q6r4JZjbAqEaHypjjlSQSLrwFpJxTqfq3orkC7ZjVfgj0S
         sdyo2CC8VRU2GY1kSSVTDMEnRCIPpNzsRQhYn8fnXZPngUwZTDWWc+INr817r7NCi3
         9Z572b3JG2Fv3dKtlirbcsWT6WEu1MP39udseiqIYxgl7W/fTCGB4bC7YWVH1ybpiH
         136HTC47aCgA1f284UQwjEWfPYTrv0zlhd7LKHfEt54cNSvVYhlvd7XqsfGTKZRsOB
         Egi/wdUDInVu8dRXWsOLbQFIoCPRZnIj1m7wBwh5+wQnEEHllW7Gyz6MBOJvdbfhFb
         34wBEg8kYlW+w==
Date:   Fri, 21 Jul 2023 18:35:40 -0700
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
Subject: Re: [PATCH net-next v2 0/6] net: dsa: microchip: provide Wake on
 LAN support
Message-ID: <20230721183540.1fb66025@kernel.org>
In-Reply-To: <20230721135501.1464455-1-o.rempel@pengutronix.de>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 15:54:55 +0200 Oleksij Rempel wrote:
> - rebase against latest next

Wrong next? IDK. Still doesn't apply :S
-- 
pw-bot: cr
