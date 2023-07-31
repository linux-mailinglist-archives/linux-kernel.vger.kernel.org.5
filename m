Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D317691CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGaJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGaJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0B10C7;
        Mon, 31 Jul 2023 02:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB2C460FC9;
        Mon, 31 Jul 2023 09:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC62BC433C7;
        Mon, 31 Jul 2023 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690795883;
        bh=zYigZsP8fdIjtW7KGQQk4Oz0hhJCFy2GrbtMAsuaLbo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KJBv/vNCAhFIChIedfaFYMFRDRtEHGnQOutW74PrtN0yINRx9sesgfEIPA76BUurZ
         2BxelLvPyRG/U2veoAgfBjHzsNLb/CVVUpco2AcA+H5LTVkJe5CMkdaXVxe3bTf1EJ
         w+9d9ZvuC/76p0wTadBFDg/7BdPgzKtGTM76hNwigrWHgpuGOKif79TmYVf06C/yxs
         18OqWtVwiimBfyvoi+G8p9vAbgqmIYHxMwzj3vDqBHiG0UPWjAt6mzOjHwGugNKbAQ
         um6BkRFzBvFr7UKsKOd/Cs/T7Tb1QkLV7FiRYeJ6Ldl9KtlMWrG+Yg4vbayFUt0HdP
         Uspvuiox1tjZw==
Received: (nullmailer pid 2176699 invoked by uid 1000);
        Mon, 31 Jul 2023 09:31:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, nm@ti.com, devarsht@ti.com,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com>
Message-Id: <169079588075.2176682.10224087620577481487.robh@kernel.org>
Subject: Re: [PATCH v8 15/16] media: dt-bindings: Add TI J721E CSI2RX
Date:   Mon, 31 Jul 2023 03:31:20 -0600
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 13:59:33 +0530, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v7->v8:
> - Drop "Device Tree Bindings" from title
> - Rename "Wrapper" to "Shim" in title as that is the name referred in
>   the TRM and other places
> - Update maintainer to myself
> - Drop items from compatible as only a single element is present
> - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
>   SoC-specific CSI2RX bridge compatible
> 
>  .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: ticsi2rx@4500000: csi-bridge@4504000: False schema does not allow {'compatible': ['ti,j721e-csi2rx', 'cdns,csi2rx'], 'reg': [[72368128, 4096]], 'clocks': [[4294967295, 26, 2], [4294967295, 26, 0], [4294967295, 26, 2], [4294967295, 26, 2], [4294967295, 26, 3], [4294967295, 26, 3]], 'clock-names': ['sys_clk', 'p_clk', 'pixel_if0_clk', 'pixel_if1_clk', 'pixel_if2_clk', 'pixel_if3_clk'], 'phys': [[4294967295]], 'phy-names': ['dphy'], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]], 'bus-type': [[4]], 'clock-lanes': [[0]], 'data-lanes': [[1, 2]]}}}}
	from schema $id: http://devicetree.org/schemas/media/ti,j721e-csi2rx-shim.yaml#
Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']
Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

