Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1E79E827
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbjIMMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbjIMMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:36:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7719B4;
        Wed, 13 Sep 2023 05:36:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25713C433C8;
        Wed, 13 Sep 2023 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694608613;
        bh=9elooBvdUre19hw6hhl5TUjtNpfBJuWPJGdA3PSQOPk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=agk5wuvYe4eXdvQP2/ZI92WDyKAW1ArMiActdlzr0IZA/ohh3j3AVRiiJ5E2+FgWs
         cCm27CBwuBysFObzN8Dw98uvJTI/JswJziqobQaI5dd4N46lmaNNGw/4S3M2iYs43l
         txeo0KTT18iqwnMQdRcO8jv0F7IOuk+yuhulmz+1k2fEpgX6frZtWzbc4G3Ap6fn47
         8CCNniKF3Zgr80FbAyzrnrqAxWnbEXhFwVvQzYD10m63vQANkRJVz5YaygaLQlsoO2
         qxosIo3SOJ1iN0BXgWu7UFo7Bjp2NyDWKTu0oFEHZqGrM6yet4akd/sThGxz9YMcas
         ObjMBTd/XLAYw==
Received: (nullmailer pid 2790031 invoked by uid 1000);
        Wed, 13 Sep 2023 12:36:51 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-kernel@vger.kernel.org, martyn.welch@collabora.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        linux-remoteproc@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230913111644.29889-2-hnagalla@ti.com>
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-2-hnagalla@ti.com>
Message-Id: <169460861100.2790015.8526656812110915165.robh@kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x
 SoCs
Date:   Wed, 13 Sep 2023 07:36:51 -0500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 06:16:41 -0500, Hari Nagalla wrote:
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
> Changes since v5:
>  - None
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230913111644.29889-2-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

