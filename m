Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AFA7697A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjGaNcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGaNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D210E3;
        Mon, 31 Jul 2023 06:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D926114E;
        Mon, 31 Jul 2023 13:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B793C433C7;
        Mon, 31 Jul 2023 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690810337;
        bh=z+uAjZVNhz3LyIsdekBiHKjrJt8GwMtkgIpTiC3PAhA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kB01tzMRm0xGd46a/lcgXTdh7oLikepiXWJAdD8VSwE9ZBAEkWDo+TYXbogvXBgP9
         AJ23A5d3Fq/rXkUPkZCk5FG6x+6wOgw05LSZhm/8oVNWbI1jQroLbsuHh3cscmQdt2
         uRVnuLARcsiT1T1ydr16yNHdd7BwJUtENHPlZzBTzf+vtIX1GV9NmaO/ARfykaAFGt
         m2NUtScqaxIMg7yiLb5xXR8tVV9P70OWi+gKX9fUuwToBmzCpKqv5jLqJNaDZsSM6U
         O1ANB4DWnkC/flvt651yNsmqv6JmkQRc6yEgpwoXoHL+DKrdzi9C8ZtxDg1smtXDqI
         ZhypNn1sURM7Q==
Received: (nullmailer pid 2855850 invoked by uid 1000);
        Mon, 31 Jul 2023 13:32:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     conor+dt@kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, benjaminfair@google.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        yuenn@google.com, linux-kernel@vger.kernel.org, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        venture@google.com, avifishman70@gmail.com
In-Reply-To: <20230731122323.172834-2-tmaimon77@gmail.com>
References: <20230731122323.172834-1-tmaimon77@gmail.com>
 <20230731122323.172834-2-tmaimon77@gmail.com>
Message-Id: <169081033533.2855823.7340412529584491141.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and
 GPIO documentation
Date:   Mon, 31 Jul 2023 07:32:15 -0600
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 15:23:22 +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 215 ++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml:77:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml: patternProperties: '-mux' does not match '[\\^$()*@]'
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731122323.172834-2-tmaimon77@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

