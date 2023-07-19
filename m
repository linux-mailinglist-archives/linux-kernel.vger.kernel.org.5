Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C59759362
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGSKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGSKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201DE5;
        Wed, 19 Jul 2023 03:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C6F61360;
        Wed, 19 Jul 2023 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260E2C433C8;
        Wed, 19 Jul 2023 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689763396;
        bh=br46QkmTNt3+VHJVYXSge2TlS0ttyZLHlsyInTBZc4A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KNF1LmWzs+Q+N7isstGcC7//Niph6wVE5o/qh9d++aU9HtvVmV/gH5swAdxGMALQg
         qgtxcwcZUrujUrLBupBo7iNOp/h9vpmG2/kJVQ71AxLzeVdMXgDI7eeaU4t6AHDMmP
         WHGfaKigkGM/1YnDAEH4W95qVdFH+OQ5jKAfgabhZXS53mqbiHpNchTmMuqY6Ce/Ur
         z7hXw96uN4QgZpCCzQ5keWSqKXigAnlTeGjt+E0DD0gkQXxFbVRsoZuoVajSUR+CCh
         sbh71HV4n+Nm+irFY/qJeIL1zjIh4+9JKf8JMXLYY85CiRXe+TYYbhRnouaCaWev+2
         Hkm96V3+YQceA==
Received: (nullmailer pid 3538823 invoked by uid 1000);
        Wed, 19 Jul 2023 10:43:15 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     alina_yu@richtek.com
Cc:     conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
Message-Id: <168976339514.3538796.12110287172780904275.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Date:   Wed, 19 Jul 2023 04:43:15 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 17:24:45 +0800, alina_yu@richtek.com wrote:
> From: alinayu <alina_yu@richtek.com>
> 
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
> v4
> - Modify filename to "richtek,rtq2208"
> - Add more desciptions for "regulator-allowed-modes"
> ---
>  .../bindings/regulator/richtek,rtq2208.yaml        | 208 +++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/regulator/richtek,rtq2208-regulator.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1689758686-14409-2-git-send-email-alina_yu@richtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

