Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898676405B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGZUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGZUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511CAE64;
        Wed, 26 Jul 2023 13:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A9061CBA;
        Wed, 26 Jul 2023 20:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32403C433C8;
        Wed, 26 Jul 2023 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690402444;
        bh=V0dsiba/e/EnWiicMuiFyHjsCtALuYmHLxQ6ywscESg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k3OGYtf9ftfUYzRIhz7LE0jPUBbksDpL2oAA9F3Y328+aQMLfAJk3MTaoZ8VgoKvm
         RpgFMB0xJ6nJZSWY0HzIql3URUNjzSBmy1FdKj5vbBWezH3VTNdapSyPeh98amhN3m
         sDsh5fI7X7YQk67e/GqDw+s9FP3QpM9Ghh+iI/9sTUlF4PhoxS5//f3+wO7415jK6Z
         EfavjH31WWGmW/X/0rKa78m4P1TqgqDexoJLUS20k4Hv8V7RcWTZFccizLr00qe8n9
         89BxjKkzLxEUmtoa+kWmpbDRCwwDicB2tW0Jn0qqane79xoyWaampPKLPWQS6CiAm1
         Ow/rH+mQAsizw==
Received: (nullmailer pid 1980658 invoked by uid 1000);
        Wed, 26 Jul 2023 20:14:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     openbmc@lists.ozlabs.org, Avi Fishman <avifishman70@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tyrone Ting <warp5tw@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>
In-Reply-To: <20230726192740.1383740-2-iwona.winiarska@intel.com>
References: <20230726192740.1383740-1-iwona.winiarska@intel.com>
 <20230726192740.1383740-2-iwona.winiarska@intel.com>
Message-Id: <169040244201.1980325.11685396975848728495.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add bindings for peci-npcm
Date:   Wed, 26 Jul 2023 14:14:02 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2023 21:27:37 +0200, Iwona Winiarska wrote:
> From: Tomer Maimon <tmaimon77@gmail.com>
> 
> Add device tree bindings for the peci-npcm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
> Changes v1 -> v2:
> 
> * Renamed binding filename to match compatible (Krzysztof)
> ---
>  .../bindings/peci/nuvoton,npcm-peci.yaml      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/peci/peci-npcm.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230726192740.1383740-2-iwona.winiarska@intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

