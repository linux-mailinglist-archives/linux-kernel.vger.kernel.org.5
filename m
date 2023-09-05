Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A32B792F83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbjIEUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjIEUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:39 -0400
X-Greylist: delayed 5118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:08:36 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453499C;
        Tue,  5 Sep 2023 13:08:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B80C433B9;
        Tue,  5 Sep 2023 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693938541;
        bh=HNwxnqVLcUvUgsEtkMxU0rL9+To5Mqbb2eXIaUG0S38=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SfuVpe78aghB8DPNWXGfrTge0/smtp+UAk6OB8SWplYFRWLrpZ99hOBugQ0RDLIq6
         toGyXtbytFqoZdQw5T0141yeHnGPx9trJQkZCK+hZpuZDalw0hnVwJ2ZKTz7Tj/b63
         c1+bhVdRVswJzrOozTovGu0SEBDV82uuGQToq5iyz/QQEwsq7iCDR/kqTpcpsLtr1i
         oPUhcJtpd+WUb8Zh0wnR0CYwyPxRoKFukWkvQJBgUlYwcLzoaGUVjC2kxX2vbuUsvU
         ScCC0dtYeY2S2RtT0fQIN//Wf4EzSx2AIQlEdwCCqd5PN98sGa5NWDguDFrzGjRMHF
         NQwv2PC9gln8g==
Received: (nullmailer pid 3757330 invoked by uid 1000);
        Tue, 05 Sep 2023 18:28:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        UNGLinuxDriver@microchip.com, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20230905124340.4116542-1-o.rempel@pengutronix.de>
References: <20230905124340.4116542-1-o.rempel@pengutronix.de>
Message-Id: <169393853820.3757299.10173163628142492519.robh@kernel.org>
Subject: Re: [RFC net-next v1 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Date:   Tue, 05 Sep 2023 13:28:58 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 14:43:39 +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:54:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:62:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230905124340.4116542-1-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

