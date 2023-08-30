Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27AC78E16E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbjH3V3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241359AbjH3V3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63396E0;
        Wed, 30 Aug 2023 14:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361BC62D93;
        Wed, 30 Aug 2023 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72343C433C8;
        Wed, 30 Aug 2023 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693430752;
        bh=+mDkuW/MIw8WBjTJ9g/SOzGF+Aw/uNNBqJqpovDuV9w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KvrffPKHEwHjbZQu3EWrZJHZIuWxYSEtYs3DYFHmESMMl3JRDUXIdrzs6m2sbOwEP
         L6Pa3JgwPVb0BzPzIqFpn6mymPqMN8udtu6a5WiW5/jTr9nSX1tvBKS6w8cKiyL6Le
         FX5vXXw+GCzj2YIz/Us6/zDBL/FH5UsM/hmURhe+199abC/Y4fHUWcx8GdgxgomROX
         sp84v5fW7gfzyI9Ne9uCnNk+Ji32LBkGNtUXIv4lIfBngr8tgz90yt2fh1WXPDntjD
         wLHcGST/mvSnAesbos628TVJQqSCgU17ubu/a7414cqV/FbRgnb4J0lqHO7UA5FY70
         vONsv/LGh05tw==
Received: (nullmailer pid 936566 invoked by uid 1000);
        Wed, 30 Aug 2023 21:25:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, sboyd@kernel.org, conor+dt@kernel.org,
        bcousson@baylibre.com, lee@kernel.org, robh+dt@kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230830182038.878265-2-andreas@kemnade.info>
References: <20230830182038.878265-1-andreas@kemnade.info>
 <20230830182038.878265-2-andreas@kemnade.info>
Message-Id: <169343075032.936550.16324295263542888896.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: convert twl-family.tx to
 json-schema
Date:   Wed, 30 Aug 2023 16:25:50 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 20:20:34 +0200, Andreas Kemnade wrote:
> Convert the TWL[46]030 binding to DT schema format. To do it as a step by
> step work, do not include / handle nodes for subdevices yet, just convert
> things with minimal corrections. There are already some bindings for its
> subdevices in the tree.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 69 +++++++++++++++++++
>  .../devicetree/bindings/mfd/twl-family.txt    | 46 -------------
>  2 files changed, 69 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/ti,twl.example.dtb: /example-0/i2c/pmic@48/rtc: failed to match any schema with compatible: ['ti,twl4030-rtc']

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt: Documentation/devicetree/bindings/mfd/twl-family.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230830182038.878265-2-andreas@kemnade.info

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

