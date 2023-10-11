Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335077C5D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjJKTOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJKTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:14:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450FA4;
        Wed, 11 Oct 2023 12:14:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33C7C433C7;
        Wed, 11 Oct 2023 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697051674;
        bh=fiAK9g87Vz98ytokGLJJe4d+TJ34yfcDzT+bs6nScOI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NkMMmg7Tvq8YNnI2Ymlv97+QC2ZVEs0V4cO7h//tDlJMkh8/oCV0mroqx8+ju8bK+
         R+be2T7O4knF2nKxq44B4KndhAGZTRB5PIkdYy5Y3uK9hy5C0SR6XcL7+w086rWjpR
         yri0ADeQCZpnyr28kFuB3dTDIy5AsgwRxD1pzIo14KY3OgtouCD+h+49em6VUJFFBr
         y4Aw8axW+SJGj5+TqCI10CqElw7VsQo1I+G+K+965iy/fGfDK1eHlpIweeBbY4WwLr
         GEjw4vj5df3eZAdadiimx2sBIUDHbTq0UV+jggO6bM3L4YgFtknYY4ly2yhLAcqjbV
         uOMW6w/pmXVjA==
Received: (nullmailer pid 1840053 invoked by uid 1000);
        Wed, 11 Oct 2023 19:14:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        jonathan@marek.ca, quic_tdas@quicinc.com, sboyd@kernel.org,
        vladimir.zapolskiy@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20231011185540.2282975-4-bryan.odonoghue@linaro.org>
References: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
 <20231011185540.2282975-4-bryan.odonoghue@linaro.org>
Message-Id: <169705167192.1839996.9701202822807464812.robh@kernel.org>
Subject: Re: [PATCH v3 3/4] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date:   Wed, 11 Oct 2023 14:14:31 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Oct 2023 19:55:39 +0100, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> This patch depends-on:
> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/media/qcom,sc8280xp-camss.yaml   | 582 ++++++++++++++++++
>  1 file changed, 582 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231011185540.2282975-4-bryan.odonoghue@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

