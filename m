Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF877F9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbjHQOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352340AbjHQOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837210E;
        Thu, 17 Aug 2023 07:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 985D863B7A;
        Thu, 17 Aug 2023 14:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9331C433C9;
        Thu, 17 Aug 2023 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284052;
        bh=AOOfVg3e/s3+25cWM9lAvk/yXFSa41SxrSYIyPfpKsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QONEdwsnLM4PXR3bR+xS8DLGGKgA7FynsruyB0XiC7/1c/s9XEsYLfzu1X8TzCbNw
         mXQONNYTId8rBay+2R3kWHTDRneI2XRZLFOV9TjkYEW31r9096XZyJkociObSomsJZ
         2zhCTUZapAMLXZRdigseJzQEQQY6pJHzmDGHHmiHNIxcVXlEpm/IhB2WqsHzNAWNXN
         u4PNAedFOjOxgpx5p2yr2Kuj9sCIfhNYllkyn/6HFmOdhm1RNJzRY1V39X+xIuEvrC
         AKqoiyIdcc9cd53kpB/3BnE4DiNPbVTxDXI/jN8l37/tiWiwG34eJOfm5ZCNPpW0zd
         Z2sRcSe3S4YAg==
Received: (nullmailer pid 958974 invoked by uid 1000);
        Thu, 17 Aug 2023 14:54:08 -0000
Date:   Thu, 17 Aug 2023 09:54:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     edumazet@google.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com, ravi.patel@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-fsd@tesla.com, conor+dt@kernel.org,
        mcoquelin.stm32@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pabeni@redhat.com,
        pankaj.dubey@samsung.com, richardcochran@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, joabreu@synopsys.com,
        devicetree@vger.kernel.org, davem@davemloft.net,
        swathi.ks@samsung.com
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <20230817145408.GA953517-robh@kernel.org>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
 <20230814112539.70453-2-sriranjani.p@samsung.com>
 <169201998303.2086680.8457687937999615543.robh@kernel.org>
 <000001d9d003$b3a9a8a0$1afcf9e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d9d003$b3a9a8a0$1afcf9e0$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:06:51AM +0530, Sriranjani P wrote:
> 
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 14 August 2023 19:03
> > To: Sriranjani P <sriranjani.p@samsung.com>
> > Cc: edumazet@google.com; linux-kernel@vger.kernel.org;
> > alexandre.torgue@foss.st.com; ravi.patel@samsung.com;
> > alim.akhtar@samsung.com; linux-samsung-soc@vger.kernel.org; linux-
> > fsd@tesla.com; conor+dt@kernel.org; mcoquelin.stm32@gmail.com;
> > kuba@kernel.org; netdev@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; pabeni@redhat.com; robh+dt@kernel.org;
> > pankaj.dubey@samsung.com; richardcochran@gmail.com;
> > krzysztof.kozlowski+dt@linaro.org; joabreu@synopsys.com;
> > devicetree@vger.kernel.org; davem@davemloft.net;
> > swathi.ks@samsung.com
> > Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
> > bindings
> > 
> > 
> > On Mon, 14 Aug 2023 16:55:36 +0530, Sriranjani P wrote:
> > > Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> > > Ethernet YAML schema to enable the DT validation.
> > >
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> > > Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> > > Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> > > ---
> > >  .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
> > >  .../devicetree/bindings/net/tesla,ethqos.yaml | 114
> > > ++++++++++++++++++
> > >  2 files changed, 117 insertions(+), 2 deletions(-)  create mode
> > > 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> > >
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m
> > dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-
> > ci/linux/Documentation/devicetree/bindings/net/tesla,ethqos.yaml:
> > properties:clock-names: {'minItems': 5, 'maxItems': 10, 'items': [{'const':
> > 'ptp_ref'}, {'const': 'master_bus'}, {'const': 'slave_bus'}, {'const': 'tx'}, {'const':
> > 'rx'}, {'const': 'master2_bus'}, {'const': 'slave2_bus'}, {'const':
> > 'eqos_rxclk_mux'}, {'const': 'eqos_phyrxclk'}, {'const':
> > 'dout_peric_rgmii_clk'}]} should not be valid under {'required': ['maxItems']}
> > 	hint: "maxItems" is not needed with an "items" list
> > 	from schema $id: https://protect2.fireeye.com/v1/url?k=f50e335d-
> > aa950a44-f50fb812-000babff3793-de26ea17ef025418&q=1&e=897786e4-
> > 5f9b-40d8-8a7f-399cb69c7ee8&u=http%3A%2F%2Fdevicetree.org%2Fmeta-
> > schemas%2Fitems.yaml%23
> > Documentation/devicetree/bindings/net/tesla,ethqos.example.dtb:
> > /example-0/ethernet@14300000: failed to match any schema with
> > compatible: ['tesla,dwc-qos-ethernet-4.21']
> > 
> 
> Thanks for review. Will fix this in v4.

It's not a review. It's an automated reply running what you should have 
run yourself...

> 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://protect2.fireeye.com/v1/url?k=ccb7f6d0-932ccfc9-ccb67d9f-
> > 000babff3793-2137ac63fe6ddef8&q=1&e=897786e4-5f9b-40d8-8a7f-
> > 399cb69c7ee8&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fdev
> > icetree-bindings%2Fpatch%2F20230814112539.70453-2-
> > sriranjani.p%40samsung.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> 
> Sorry, I could not get this comment, can you elaborate this. 

The automated tests apply patches to the latest rc1 tag. Patches which 
apply, but have some other dependency may have warnings. If you have 
such a dependency, you should note it in the patch (below the '---').

Rob
