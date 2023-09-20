Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D97A8226
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjITM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjITM5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:57:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A383;
        Wed, 20 Sep 2023 05:57:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542B4C433C7;
        Wed, 20 Sep 2023 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695214661;
        bh=BEisPBW1KmRtjT0oASI8wcLRc3DN9B2NAkRyypriO4c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=epCiZInOoCbpxjCdjLMW2InMLbNS+gI1bdgkUZm6GNs5MUjUeXpqAh6I1m3ZEe4lh
         VGqMvfAxWlROij4oB6Irk1fEbrtp//aeUmw3bSdQEXfrE6qiZ06Wb4472o3AZN78CT
         Q/4ELlqfcVoBmMWwJdRjTys1eLuU4i5jOWfnfKf6AfoKVFmF4eX33lwm3KnOSMz746
         KS0kXiKmJ5ORY5R/qYSdu1HdePrPRkBqUtNehb/r69reG8bM6Y/HfML5UM06vRHvvq
         jmAz/slVpAgad01z2H/w79rcPLPGpoxn488UjfAzR/d5dBwSFJCM8F9RRJ0RfixCJW
         h8sXuXece5RoQ==
Received: (nullmailer pid 2032568 invoked by uid 1000);
        Wed, 20 Sep 2023 12:57:39 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230920115044.53098-1-tony@atomide.com>
References: <20230920115044.53098-1-tony@atomide.com>
Message-Id: <169521465924.2032537.6288372017884083091.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Date:   Wed, 20 Sep 2023 07:57:39 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2023 14:50:43 +0300, Tony Lindgren wrote:
> Allow configuring an optional dedicated wakeirq for gpio-keys that
> some SoCs have.
> 
> Let's use the common interrupt naming "irq" and "wakeup" that we already
> have in use for some drivers and subsystems like i2c framework.
> 
> Note that the gpio-keys interrupt property is optional. If only a gpio
> property is specified, the driver tries to translate the gpio into an
> interrupt.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Run make dt_binding_check on the binding
> 
> - Add better checks for interrupt-names as suggested by Rob, it is
>   now required if two interrupts are configured
> 
> - Add more decription entries
> 
> - Add a new example for key-wakeup
> 
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 41 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/gpio-keys.yaml:36:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/input/gpio-keys.yaml:38:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/input/gpio-keys.yaml:47:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/input/gpio-keys.yaml:49:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230920115044.53098-1-tony@atomide.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

