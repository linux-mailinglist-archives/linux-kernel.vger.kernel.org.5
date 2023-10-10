Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803867BFD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjJJNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjJJNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:25:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC65C4;
        Tue, 10 Oct 2023 06:25:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C2AC433C7;
        Tue, 10 Oct 2023 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696944335;
        bh=CjZnlq6PzXFC5yUfCHTOpCZbP5ACEIMB0ADocMWjz+4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WkmlMgVhyK4Z5ScLp/rxBvroVpyPiPi6jgW6x26BZjj0OEp32n5JneyAUoDv3/UEi
         UDxopoID5WnVuDh7FMjZf4KiVVWg2FJzuJYaRLbZm9YSz4gpt8PMxcQnFt7qVP72D8
         IeKVCuVzxFA3MvJrUL217toLRGYnaa2v8qFC+rZb2U0RWPne91dlZm2V42PXURK42m
         0JeT4vo1lqC7HtZFiK0H0JzGYacy7Hbu6yakmBxUTbC0KGi+fxcnmlVYg/8aQ6bf3g
         XRrIIw8aIQlrs/+UEAOv8TfEVL2PAxRVAzMBPo5lyDReR30YTnM2v4UrMXQZhKd52n
         S1WPZb87bI3ug==
Received: (nullmailer pid 625805 invoked by uid 1000);
        Tue, 10 Oct 2023 13:25:33 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, jonathan@marek.ca, andersson@kernel.org,
        quic_tdas@quicinc.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vladimir.zapolskiy@linaro.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        mturquette@baylibre.com
In-Reply-To: <20231010122539.1768825-3-bryan.odonoghue@linaro.org>
References: <20231010122539.1768825-1-bryan.odonoghue@linaro.org>
 <20231010122539.1768825-3-bryan.odonoghue@linaro.org>
Message-Id: <169694433325.625737.10533845261157845416.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date:   Tue, 10 Oct 2023 08:25:33 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 13:25:38 +0100, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231010122539.1768825-3-bryan.odonoghue@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

