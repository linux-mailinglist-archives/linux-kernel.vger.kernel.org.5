Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA627BB8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjJFNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJFNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:18:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619483;
        Fri,  6 Oct 2023 06:18:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F85C433C7;
        Fri,  6 Oct 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696598326;
        bh=t5ARPJAi2ZOUMZALtc2xCSh/huEsxLMt7Ehm+RTiBAs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dUL+Mg0D3X2BTRDPZgGw1VyWx9Kz+W5i+mUkXP8CH+bQZvKxeJC7wl4Q4KDjN18uP
         ZsEaOuI7Mq/P4sho67CCeoTs85GApeQM89Jhljx4hsmChrXsWx0GGduVbsUgZsaCTC
         JhexH+gAwpBSlLHgAD+y+Yh31/ruLPrhhtF/CftYqMs4+q4c2x1rkWBLm92a7K69qN
         8PCBaOcV6s4YbzWNyl6pPaRTsNPb+aJhVfy+7Gz1dJNjriYHpCLAL4HpRxiYdk+EUI
         5yjM2wjYoraeHpRZAkK4G4tS9w2EoNWTCsXtndVWCLlGiodoZlz3gIHftFKZn90sjV
         yORXNHAEfB6Sw==
Received: (nullmailer pid 3410056 invoked by uid 1000);
        Fri, 06 Oct 2023 13:18:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cristian.marussi@arm.com
In-Reply-To: <20231005025843.508689-6-takahiro.akashi@linaro.org>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
Message-Id: <169659832273.3409847.15694416126257533842.robh@kernel.org>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Date:   Fri, 06 Oct 2023 08:18:43 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Oct 2023 11:58:43 +0900, AKASHI Takahiro wrote:
> A dt binding for pin controller based generic gpio driver is defined in
> this commit. One usable device is Arm's SCMI.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> RFC v2 (Oct 5, 2023)
> * rename the binding to pin-control-gpio
> * add the "description"
> * remove nodename, hog properties, and a consumer example
> RFC (Oct 2, 2023)
> ---
>  .../bindings/gpio/pin-control-gpio.yaml       | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/pin-control-gpio.example.dts:18.23-26.11: Warning (unit_address_vs_reg): /example-0/gpio@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231005025843.508689-6-takahiro.akashi@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

