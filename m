Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E416779243
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHKOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHKOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD22D69;
        Fri, 11 Aug 2023 07:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F0D673EC;
        Fri, 11 Aug 2023 14:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D78C433C9;
        Fri, 11 Aug 2023 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691765670;
        bh=foe2c5qeLBZfF9kPLzo5bA1hDk2swX/qOQZkOg+VLwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxHEjJf1QZUAwPTs48D7L5QlxyMb8Aj/uu98hV+zg1+i9ofxJjmxNJ3lBBu52KjHD
         V+UgQzevJb4qI3755N8rSJGoIIcTiMh0WkZbfBLa0qBtvpQmc+ARbyVtUrSH1Ir2v3
         VfPfLqPIJW7dGyciJElqFhVhvhVtXxtysxIxEsuBNzBQLLrGdDAoXlKCrHIw84QLhE
         8CkOgapqIsvB9o1QV1EgH7MBwo+gAamMOw/SKfMzYgQk2mhaB+uaKKe7tFoo1WcwEy
         eIqVKzGMTtY2kcMajxPMOuWXYzEbAYy3mSczPLfAuHbbXIi+CCz4PO4Wn40ppFY7Nf
         hgIaBxyAsTSUg==
Received: (nullmailer pid 3452681 invoked by uid 1000);
        Fri, 11 Aug 2023 14:54:27 -0000
Date:   Fri, 11 Aug 2023 08:54:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        nm@ti.com, Martyn Welch <martyn.welch@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, a-bhatia1@ti.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Julien Massot <julien.massot@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se, linux-media@vger.kernel.org,
        Benoit Parrot <bparrot@ti.com>, devarsht@ti.com
Subject: Re: [PATCH v9 12/13] media: dt-bindings: Add TI J721E CSI2RX
Message-ID: <20230811145427.GA3452223-robh@kernel.org>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-12-8943f7a68a81@ti.com>
 <169176235886.3320008.7630750130843547331.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169176235886.3320008.7630750130843547331.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:00:55AM -0600, Rob Herring wrote:
> 
> On Fri, 11 Aug 2023 16:17:34 +0530, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> > 
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> > parts together.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> > NOTE:
> > 
> > This patch depends on
> > 9536cc949235 ("media: dt-bindings: cadence-csi2rx: Convert to DT schema")
> > which is part of linux-next.
> > 
> >  .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 100 +++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: ticsi2rx@4500000: csi-bridge@4504000: False schema does not allow {'compatible': ['ti,j721e-csi2rx', 'cdns,csi2rx'], 'reg': [[72368128, 4096]], 'clocks': [[4294967295, 26, 2], [4294967295, 26, 0], [4294967295, 26, 2], [4294967295, 26, 2], [4294967295, 26, 3], [4294967295, 26, 3]], 'clock-names': ['sys_clk', 'p_clk', 'pixel_if0_clk', 'pixel_if1_clk', 'pixel_if2_clk', 'pixel_if3_clk'], 'phys': [[4294967295]], 'phy-names': ['dphy'], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]], 'bus-type': [[4]], 'clock-lanes': [[0]], 'data-lanes': [[1, 2]]}}}}
> 	from schema $id: http://devicetree.org/schemas/media/ti,j721e-csi2rx-shim.yaml#
> Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']
> Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']

As noted, this can be ignored.

Rob
