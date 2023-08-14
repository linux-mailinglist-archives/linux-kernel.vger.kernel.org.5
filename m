Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD777BA17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjHNNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjHNNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C418B;
        Mon, 14 Aug 2023 06:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D53B63A51;
        Mon, 14 Aug 2023 13:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B28C433C7;
        Mon, 14 Aug 2023 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692019985;
        bh=l2pqgmH/iXu/AHzuckN0N3T97huLLoFc5gSrbjRBGgQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=djFKH6exoViDcFtdywnv3Vjz+UqKxiUBC5nPgeQnBtcq8gKx8sFJjmSh/65ZicXiK
         1M3iXpZPPlGN/4M6KOWfOpDTzXaIjyfWHXrdA48J6xic5cuko9TfjybFWMeOfJahhn
         /Ekt6oppBXwqEde02oFdrAaU9+ys2/XGqFryE5yWnutSQgs2Gro7OxyClB/8yaa/Ue
         vWPF5E67hkvaqQnk4EZsA+G6WXTLGEoB9yQZGuzbqFX9Rll4PrxCz1t9d1L3kFJrIC
         CeA8lNN5TpnVyrY1fx5oGcHaggSRUxY2Mq+M14L88XkE9VB04o7mfBG5XeE/Fnw6w6
         5HBSR400Wf/EA==
Received: (nullmailer pid 2086712 invoked by uid 1000);
        Mon, 14 Aug 2023 13:33:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     edumazet@google.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com, ravi.patel@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-fsd@tesla.com, conor+dt@kernel.org,
        mcoquelin.stm32@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pabeni@redhat.com,
        robh+dt@kernel.org, pankaj.dubey@samsung.com,
        richardcochran@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        joabreu@synopsys.com, devicetree@vger.kernel.org,
        davem@davemloft.net, swathi.ks@samsung.com
In-Reply-To: <20230814112539.70453-2-sriranjani.p@samsung.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
 <20230814112539.70453-2-sriranjani.p@samsung.com>
Message-Id: <169201998303.2086680.8457687937999615543.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date:   Mon, 14 Aug 2023 07:33:03 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 16:55:36 +0530, Sriranjani P wrote:
> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> Ethernet YAML schema to enable the DT validation.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
>  .../devicetree/bindings/net/tesla,ethqos.yaml | 114 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/tesla,ethqos.yaml: properties:clock-names: {'minItems': 5, 'maxItems': 10, 'items': [{'const': 'ptp_ref'}, {'const': 'master_bus'}, {'const': 'slave_bus'}, {'const': 'tx'}, {'const': 'rx'}, {'const': 'master2_bus'}, {'const': 'slave2_bus'}, {'const': 'eqos_rxclk_mux'}, {'const': 'eqos_phyrxclk'}, {'const': 'dout_peric_rgmii_clk'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
Documentation/devicetree/bindings/net/tesla,ethqos.example.dtb: /example-0/ethernet@14300000: failed to match any schema with compatible: ['tesla,dwc-qos-ethernet-4.21']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230814112539.70453-2-sriranjani.p@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

