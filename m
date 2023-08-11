Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E045177913C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjHKOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjHKOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BEFE65;
        Fri, 11 Aug 2023 07:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A5763CF7;
        Fri, 11 Aug 2023 14:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABBC433C7;
        Fri, 11 Aug 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762466;
        bh=XQpneWVvWk2NOHnRa+vY4LR8Zcr+OGOZVwODnJ1i17k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nsQQcZaGgmksE7zQ0lXKCDC0SZLKPrj+hsg2+cQsNX7QCvviTR+jT6dxP1xZB1Ea2
         y+TnaCmiSbX619c0Hv3ApHPgtiQoIQUkdzTn7ZVDQTp8C/sfzB5JACbsLF22IH0Adk
         Oe/H2Wo1t+ZwJ/YOJnM302o481xtGXdwkAs7J+Z0ZDj2iyz8BWsNy2SEOvAXmvBMOI
         MSRv3z/fPeCDXFGx1Qg+hZqS4xw1xbKgIqVQCUEqcEQVCeY4cw3WUERZLpQqiC5h5R
         QHMpb1BVaY3qRPt7ysY12jwUtHTfFkmYb8APNJSwv2Xye24AGNOGbOpix3uBN4dGcS
         aLVsTCW0Yum5g==
Received: (nullmailer pid 3323009 invoked by uid 1000);
        Fri, 11 Aug 2023 14:00:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20230811110432.3968-1-tony@atomide.com>
References: <20230811110432.3968-1-tony@atomide.com>
Message-Id: <169176235974.3320042.17857123175585954059.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Date:   Fri, 11 Aug 2023 08:00:55 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 14:04:31 +0300, Tony Lindgren wrote:
> Allow configuring optional dedicated wakeirq that some SoCs have.
> Let's use the interrupt naming "irq" and "wakeup" that we already have
> in use for some drivers and subsystems like i2c.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml      | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/gpio-keys.yaml:40:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/input/gpio-keys.example.dts'
Documentation/devicetree/bindings/input/gpio-keys.yaml:40:1: found character '\t' that cannot start any token
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/input/gpio-keys.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/input/gpio-keys.yaml:40:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/gpio-keys.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230811110432.3968-1-tony@atomide.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

