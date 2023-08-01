Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9A76AE80
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjHAJj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjHAJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F844B5;
        Tue,  1 Aug 2023 02:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A796151A;
        Tue,  1 Aug 2023 09:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB59C433C8;
        Tue,  1 Aug 2023 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690882617;
        bh=bIbnAIV9LSgAjMhFNe8KGtjVPP3OHk1T9jk268LsK2g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hK3eWABuYlGQAcZLf9jiilYQuXlQlCOSOY8k25Qzu5b4FoeDtlJqZMdD4Zdvoj4BH
         xUMmVlqi8pkwaqNQTlBtauaWF/xlXj+NMvsxjJlNBqpcdCLk/itpbPFJRa9aO9cSmM
         QjGPBfNAwLc4xEaBxuXmBWJwWQJ+yBCIwRYHHfwWAccBlvLEOaQQfHOaFOKuI12uOR
         Sh9vIOPpwuhKsdLm3TzFb2qz7UyeXh40sDZSzfSNoIq+GIwGJbP7E5t+9+kzT2ZkGG
         snSj1RNcKQHBJlM/JsRSO1T4sMiy6GVwhpniE6n2SLbEqMiUKlDIa8GbVa7dqQV+Rh
         joaPtNImr0miw==
Received: (nullmailer pid 966827 invoked by uid 1000);
        Tue, 01 Aug 2023 09:36:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     linux-clk@vger.kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_srichara@quicinc.com, p.zabel@pengutronix.de,
        konrad.dybcio@linaro.org, conor+dt@kernel.org
In-Reply-To: <20230801085352.22873-3-quic_luoj@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
Message-Id: <169088261501.966799.11880171949914344373.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Date:   Tue, 01 Aug 2023 03:36:55 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 16:53:51 +0800, Luo Jie wrote:
> QCA8386/QCA8084 includes the clock & reset controller that is
> accessed by MDIO bus. Two work modes are supported, qca8386 works
> as switch mode, qca8084 works as PHY mode.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,nsscc-qca8k.yaml      |  59 ++++++++++
>  include/dt-bindings/clock/qcom,nsscc-qca8k.h  | 102 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,nsscc-qca8k.h  |  76 +++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,nsscc-qca8k.h
>  create mode 100644 include/dt-bindings/reset/qcom,nsscc-qca8k.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dts:22.11-22: Warning (reg_format): /example-0/clock-controller@24:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: clock-controller@24: '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/qcom,nsscc-qca8k.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.example.dtb: clock-controller@24: Unevaluated properties are not allowed ('#clock-cells', '#reset-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/clock/qcom,nsscc-qca8k.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230801085352.22873-3-quic_luoj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

