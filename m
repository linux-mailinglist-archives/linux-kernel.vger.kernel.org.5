Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B397C6DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbjJLMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJLMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:24:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50096B7;
        Thu, 12 Oct 2023 05:24:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703CCC433C7;
        Thu, 12 Oct 2023 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697113492;
        bh=1GyAZLXBp65moRKSORYgOCHrvhgp+SxDzz7EnfVjVUk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aXAo4H2341hCLiNHeYtUIkEE8BIZpaaoCB0X8Xl5ewS0BVCn69f7haypyvkcPPIu4
         dB6E8XstAvbZpOkfhtmE0cs5tYGcQbfxg/TmwlpmB23wZaLx9vvbNVIEHgRh3ZzLrA
         LheqF5JlnNNk3/7I5cgbUtpdrbP39NRSk6KK+8zvmGu1h0YbRRmBzSpdGAd+RJhkGC
         twuAC/6CQJqWhDw2PHPz47IjC1LuELgfbCstxM9EktBRM0dWvahPGzF9wU3fJZuxK7
         +aM4/Nx2RV/KIhiOEhUp5fRCTzdo/dn6DsPnzUNWF7+YqDG/PbbWQRGm4WWDVCpgwp
         bNmqclV3cVCrQ==
Received: (nullmailer pid 393373 invoked by uid 1000);
        Thu, 12 Oct 2023 12:24:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, vladimir.zapolskiy@linaro.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, jonathan@marek.ca,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        conor+dt@kernel.org
In-Reply-To: <20231012113100.3656480-4-bryan.odonoghue@linaro.org>
References: <20231012113100.3656480-1-bryan.odonoghue@linaro.org>
 <20231012113100.3656480-4-bryan.odonoghue@linaro.org>
Message-Id: <169711348945.393357.13855655138263608622.robh@kernel.org>
Subject: Re: [PATCH v4 3/4] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date:   Thu, 12 Oct 2023 07:24:49 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Oct 2023 12:30:59 +0100, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> This patch depends-on:
> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T
>  .../bindings/media/qcom,sc8280xp-camss.yaml   | 581 ++++++++++++++++++
>  1 file changed, 581 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dts:26:18: fatal error: dt-bindings/clock/qcom,sc8280xp-camcc.h: No such file or directory
   26 |         #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231012113100.3656480-4-bryan.odonoghue@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

