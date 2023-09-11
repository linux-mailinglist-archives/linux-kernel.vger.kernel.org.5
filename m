Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA979BB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378611AbjIKWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbjIKOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:53:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB4125;
        Mon, 11 Sep 2023 07:53:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F83AC433C9;
        Mon, 11 Sep 2023 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443993;
        bh=r9uAvsPMKBSoSZ444LBXcq13Ir5ZTBEHNT1xJjzBGFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiv8gQ/ZYufnMz2KaRZus5/1orM/jtGnWu5LVFSbHJ954tPfsmPbHTIMqpgUuiugV
         qF5A8hVnABogiH+bNSNyzHV8LnEF6gR9EkVqyAZpMaR/lYUBzHjliH1npBvhJbJim2
         DZeKzgrqAFjbhE3r8UkoDZ4lsv68/b2nJXLBqQWhHTitFZsZrKRN1kEZIJK4MrfxcM
         8/OLxe6fzLQgqDvTDTGxachfQjgs7QryIGdbkwum6FKbjosVVH6D8ygk+bDwEGVenu
         OcFovyIxw403Mr+x5YiqRhr/g7zdmjPbbFkam8H25zwVDnU+XDVxIxxmhvGb6sN/Gv
         52z0vfn5QJROQ==
Received: (nullmailer pid 1240952 invoked by uid 1000);
        Mon, 11 Sep 2023 14:53:10 -0000
Date:   Mon, 11 Sep 2023 09:53:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, Eric Dumazet <edumazet@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        devicetree@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next v3 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Message-ID: <169444399004.1240880.4980375902161136424.robh@kernel.org>
References: <20230907090943.2385053-1-o.rempel@pengutronix.de>
 <20230907090943.2385053-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907090943.2385053-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Sep 2023 11:09:42 +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> - microchip,io-drive-strength-microamp: Controls the drive strength for
>   for undocumented Pads on KSZ88xx variants.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

