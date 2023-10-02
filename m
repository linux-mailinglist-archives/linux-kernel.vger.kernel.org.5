Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB47B4AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjJBD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjJBD0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF59B9B;
        Sun,  1 Oct 2023 20:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2662DC433C8;
        Mon,  2 Oct 2023 03:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696217160;
        bh=umloP2u3BJXv1acMbzuV5GBFTBo+KeGBE1l6rpSfUeM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u2NmWl0nM6Ihm3xQ6tQjXnrZrtSv2wHtRKftlfOGdvGA3/ycoKXKG7jvwJ1ow9F3D
         Serd7VIa38vz+CjFwGuj8YZTuBu/S4WNSRL4VxeD09evxEGc3mOWtaA311ZKqjwb3L
         up83tQK2CuPHPtCGIU8lXQmEdSWT8SlOUOrlC+oWUuXqAHm3YTnUJMVIOUN8FRa/X0
         WxgSvPNHrDoN/33O7DXSMsN/IxVZjslyLUtriuerQ0ficJglLNX2uOtv+DawVHkS13
         hwBZdZmiFlu3U1Uy1swgEPuriHz8jtwtMsiiJc86O1XrphDf2e3HvsTs7a/mjS9eAv
         q9Z5A0Q/XjAFw==
Received: (nullmailer pid 690411 invoked by uid 1000);
        Mon, 02 Oct 2023 03:25:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Oleksii_Moisieiev@epam.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        conor+dt@kernel.org, robh+dt@kernel.org
In-Reply-To: <20231002021602.260100-5-takahiro.akashi@linaro.org>
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
Message-Id: <169621715805.690395.8010550700107076644.robh@kernel.org>
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl
 based gpio
Date:   Sun, 01 Oct 2023 22:25:58 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Oct 2023 11:16:02 +0900, AKASHI Takahiro wrote:
> A dt binding for SCMI pinctrl based gpio driver is defined in this
> commit. It basically conforms to generic pinctrl-gpio mapping framework.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  .../bindings/gpio/arm,scmi-gpio.yaml          | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/arm,scmi-gpio.example.dts:20.34-28.11: Warning (unit_address_vs_reg): /example-0/scmi_gpio@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/gpio/arm,scmi-gpio.example.dtb: /example-0/scmi_gpio@0: failed to match any schema with compatible: ['arm,scmi-gpio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231002021602.260100-5-takahiro.akashi@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

