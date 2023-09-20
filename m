Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34467A8FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjITXNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjITXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:13:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC88A3;
        Wed, 20 Sep 2023 16:13:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F65C433C7;
        Wed, 20 Sep 2023 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695251592;
        bh=ZEI4SVLYeit9sUP9UceEuIC9X68j7JR0VvUzYcFHvME=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PFGN6D4oIABqPzWAYWdJodphvnoW5Z5oqIO32HPOb7Wsww0jfjDnaFqG2xzrMI7Yo
         HmT8BRQIVzz1PORN9IjaZhI7rVALAXByEMUe+IrqHXyru02mmYXsSdnJp+2LtGOs7r
         t/ENeLheHudxN6Ws/TTjM7Rnp6HpHoAmt2fUBKiotYVlt+opqAc8GmDugLCj2SE9M1
         jFeziWFi1brvoYzlcSPospd02P0p2U+yq5dMqD3N1NdANo9vqV3zAWxFdRqHLp6YM1
         Zrqup/gPAbqHwVuog1N8ZcgHmT4iC5aLe0n1ZQuS/IdVhn0akN5zYdliqkE9BZAHBd
         p5X1QbATOLGPw==
Received: (nullmailer pid 3189600 invoked by uid 1000);
        Wed, 20 Sep 2023 23:13:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     jirislaby@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        hvilleneuve@dimonoff.com
In-Reply-To: <20230920152015.1376838-5-hugo@hugovil.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-5-hugo@hugovil.com>
Message-Id: <169525159032.3189577.8595445478621843850.robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
Date:   Wed, 20 Sep 2023 18:13:10 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2023 11:20:15 -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Convert binding from text format to YAML.
> 
> Additions to original text binding:
>   - add rs485 reference.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
>  .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dts:27.13-26: Warning (reg_format): /example-0/serial@51:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dts:37.13-26: Warning (reg_format): /example-0/serial@53:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dts:48.13-26: Warning (reg_format): /example-0/serial@54:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/serial/nxp,sc16is7xx.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230920152015.1376838-5-hugo@hugovil.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

