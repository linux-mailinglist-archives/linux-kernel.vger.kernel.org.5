Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5487A3176
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjIPQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIPQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:38:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245ECCF;
        Sat, 16 Sep 2023 09:38:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8BCC433C7;
        Sat, 16 Sep 2023 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694882322;
        bh=6SPj+HdHBFzYMOMmUZucBRA7B/JCBx1i85djDAa249Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CP6pXwtMal2ssNHOgotH69SEARQaIw2JS32NemWhEb0DF1XrOEA8rnGBbtsL3oT2n
         VrHrVnunzEx7P45Yd58EXmq3x4q0N/Xnz2PoGJR92kvYweQCn5buavpjjQjCXKPWbR
         59j+SbTbYeXB7eNGmUq0xJzr58BqUoYH6TPzsS5oVayv4bqIGs1L/EUe/HfhVRKi2Y
         AmgI0JojDIAQe8GhqERl2r5usKYhSa4oi0mRMnQMi4BJNAK7DdGxgEdKodhL7yFzKK
         hbYog2AnwMSG7rnK2RMVqvCWyvp1196qdiXOpyh4jOSZHtWeD2V+SuLg9fRtvIO5p5
         Fc68HlaDFcGOA==
Received: (nullmailer pid 1755274 invoked by uid 1000);
        Sat, 16 Sep 2023 16:38:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nik Bune <n3q5u8@yahoo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nicolas.ferre@microchip.com,
        conor+dt@kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, wim@linux-watchdog.org,
        krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@microchip.com
In-Reply-To: <20230916154826.84925-1-n3q5u8@yahoo.com>
References: <20230916154826.84925-1-n3q5u8.ref@yahoo.com>
 <20230916154826.84925-1-n3q5u8@yahoo.com>
Message-Id: <169488232023.1755258.3313315475687372959.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 txt to yaml
Date:   Sat, 16 Sep 2023 11:38:40 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Sep 2023 17:48:26 +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add reg to the list of required properties.
> Add mainteiners from ./scripts/get_maintainer.pl output.
> 
> Signed-off-by: Nik Bune <n3q5u8@yahoo.com>
> ---
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 31 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  2 files changed, 31 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.example.dtb: watchdog@fffffd40: Unevaluated properties are not allowed ('atmel,dbg-halt', 'atmel,idle-halt', 'atmel,max-heartbeat-sec', 'atmel,min-heartbeat-sec', 'atmel,reset-type', 'atmel,watchdog-type', 'clocks', 'interrupts', 'timeout-sec' were unexpected)
	from schema $id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.example.dtb: /example-0/watchdog@fffffd00: failed to match any schema with compatible: ['atmel,at91rm9200-wdt']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916154826.84925-1-n3q5u8@yahoo.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

