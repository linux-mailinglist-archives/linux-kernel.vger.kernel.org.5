Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13DB7AD1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIYH0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjIYH0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:26:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67544C0;
        Mon, 25 Sep 2023 00:26:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB83C433C9;
        Mon, 25 Sep 2023 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695626801;
        bh=I4CNi9Q/JBftF6qP99taJllMHcyGXlOe1VzUdcgnrWs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j+Zfq8JXfDD5lGXmuBZtgQo6VKdWDgPUMBpj0dWZTupcXLhcRTmXkeMs0Aaq5G26L
         V11jhZjeoSR/2Ug+4fLlfnYLPrwtA+Ut8zH5BsrVHn2sPozS3nVjGObrxPDRZCH2nj
         ZJvDqOTOgG4Cj75dOue7ZRUwHO8JKVsYtlVQwcgXkkmsMMUgX9P1B1owgk3fb398so
         4Gqq6PYbts8Qk1xJbO33NbU/jGpLMHs2Q2SbeFaaj9WJoUJk6oHYg7//E9mWLtYYqJ
         dFL3W9Iz2L1ruJQHkyd/1V8r6MOoPuFbwmMNlh/mMJcfDkZOH+h7BTZoCNvHrwLig5
         L/MAWdDlIjFug==
Received: (nullmailer pid 286711 invoked by uid 1000);
        Mon, 25 Sep 2023 07:26:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        andersson@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, ndesaulniers@google.com,
        nathan@kernel.org, konrad.dybcio@linaro.org, conor+dt@kernel.org,
        baruch@tkos.co.il, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, llvm@lists.linux.dev
In-Reply-To: <20230925065915.3467964-3-quic_devipriy@quicinc.com>
References: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
 <20230925065915.3467964-3-quic_devipriy@quicinc.com>
Message-Id: <169562679800.286677.6236841313565579111.robh@kernel.org>
Subject: Re: [PATCH V12 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Mon, 25 Sep 2023 02:26:38 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 12:29:14 +0530, Devi Priya wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
> v12:
> 
>   Picked up the R-b tag
> 
> v11:
> 
>   No change
> 
> v10:
> 
>   No change
> 
> v9:
> 
>   Add 'ranges' property to example (Rob)
> 
>   Drop label in example (Rob)
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> 
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/ipq-pwm.example.dtb: syscon@1937000: compatible: ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd'] is too long
	from schema $id: http://devicetree.org/schemas/mfd/qcom,tcsr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/ipq-pwm.example.dtb: syscon@1937000: '#address-cells', '#size-cells', 'pwm@a010', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,tcsr.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230925065915.3467964-3-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

