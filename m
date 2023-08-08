Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08886774B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjHHUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjHHUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173F7AB6;
        Tue,  8 Aug 2023 13:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC13762C74;
        Tue,  8 Aug 2023 20:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A4C433C8;
        Tue,  8 Aug 2023 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691526702;
        bh=Hn9mNFdS9H/jjeLOgpbGHT61hv6DZ1X5BjlZ+cnfyWY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NiWa4a3pnvcBdxVZdv4h/X6SFQV8kAICgWYmBYrKYr57ZycQfI8dRZTj+M+6nzqcG
         Xb3xpqokXG3Kt/jDLw4hXEcnfvPvFMaha+4vyhAOV8+yaKF5JVwS+Q+cs8JqxxdWTg
         GvSOTbdi3rOiT3kMkOMVRCG3jRVeJpWgeRDodLqzcNr1ntKpaFNESDZYeobiVcvuzp
         stK6jJfwkUKAuxpdt9Mxt5hUUMMu5icWVYyWncXQp3t9hmx9S9amdKNh7KI8xFMw+x
         Im25soeE3mBZqYjjLji7TEhHsDLuNK0a5gTv35Ge/TmDUrcqxJme7qTURh9D0XPb2c
         3jGy1C3ian2qw==
Received: (nullmailer pid 4174907 invoked by uid 1000);
        Tue, 08 Aug 2023 20:31:39 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, martyn.welch@collabora.com,
        mathieu.poirier@linaro.org, vigneshr@ti.com, andersson@kernel.org,
        linux-remoteproc@vger.kernel.org, p.zabel@pengutronix.de,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        nm@ti.com, linux-kernel@vger.kernel.org, kristo@kernel.org
In-Reply-To: <20230808044529.25925-2-hnagalla@ti.com>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-2-hnagalla@ti.com>
Message-Id: <169152669984.4174873.13897253372545928644.robh@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x
 SoCs
Date:   Tue, 08 Aug 2023 14:31:39 -0600
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 07 Aug 2023 23:45:25 -0500, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Changes since v3:
>  - Removed unnecessary descriptions and used generic memory region names
>  - Made mboxes and memory-region optional
>  - Removed unrelated items from examples
> 
> Changes since v4:
>  - Rebased to the latest kernel-next tree
>  - Added optional sram memory region for m4f device node
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/stericsson,dma40.example.dtb: dma-controller@801c0000: sram:0: [4294967295, 4294967295] is too long
	from schema $id: http://devicetree.org/schemas/dma/stericsson,dma40.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230808044529.25925-2-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

