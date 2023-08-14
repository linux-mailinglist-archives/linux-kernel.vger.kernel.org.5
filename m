Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59677C084
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjHNTOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjHNTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814751718;
        Mon, 14 Aug 2023 12:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 150E36590E;
        Mon, 14 Aug 2023 19:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D6C433C8;
        Mon, 14 Aug 2023 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692040426;
        bh=4ubrGLmGSx7H43yd+PH1NyQQgBnfT7v8sS8kCQs0wVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B3B+DQj3kfBiGKdRaK5GD0wepAt7TaPdfTZAOz4WsukYx/W5Ud7NEeowzA+u62CaR
         IGt6tYO7RCDKJKOg/W25v8gv85IUJWPpScRfgW1PpzAwGpmktHB7hC1ETycp2EU+Iz
         IGxlwDlMne53EtIVba+bFXJhNZlaB9D/kcbIBaUmTwFffLVFiP2+BKbkiDys37jGtf
         +QWxWmp7h6dmRnR2U9YsKRIpewPmBS7b8C2zuVTcZ7YembgJzhTnjH7PoNzom9msVh
         9DSdiSHynk1xTBjp5e1CbSJaoFhFX+krXpR2i0U8x3BPJ41MiV18Cy3kPPlH78qsti
         rbBnw9i6up4Tw==
Received: (nullmailer pid 2797875 invoked by uid 1000);
        Mon, 14 Aug 2023 19:13:44 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     linux-usb@vger.kernel.org, rogerq@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230814185043.9252-3-quic_eserrao@quicinc.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
Message-Id: <169204042460.2797841.11924261705709074920.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Date:   Mon, 14 Aug 2023 13:13:44 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 11:50:42 -0700, Elson Roy Serrao wrote:
> This property allows dwc3 runtime suspend when bus suspend interrupt
> is received even with cable connected. This would allow the dwc3
> controller to enter low power mode during bus suspend scenario.
> 
> This property would particularly benefit dwc3 IPs where hibernation is
> not enabled and the dwc3 low power mode entry/exit is handled by the
> glue driver. The assumption here is that the platform using this dt
> property is capable of detecting resume events to bring the controller
> out of suspend.
> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,runtime-suspend-on-usb-suspend: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,runtime-suspend-on-usb-suspend: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,runtime-suspend-on-usb-suspend: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230814185043.9252-3-quic_eserrao@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

