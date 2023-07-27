Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDA76468F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjG0GPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0GPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD61731;
        Wed, 26 Jul 2023 23:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126C161D2B;
        Thu, 27 Jul 2023 06:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA23C433C9;
        Thu, 27 Jul 2023 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690438530;
        bh=0avH5gvbw67Ci8LFP+nYOnJ5qQ+S+HY6Dkvu0dVqhts=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rMJhdGGgF+AI7bDWkmjrp93bwc1Je+98YwrKdWl1osVO+ouwoXUVtMpb+en7J+nmd
         lh97XOr+1GWPY+h5JkBnHn2sz00vpvPrltwh6tAGUugdtaSiUGIDGmKjxg7HiLRi6K
         ADw5OHFKYNkGGL12mdbNZtlfk8GvTHvRSee+yEAa3syZK0DHjXD0Zfr2Fc3M/ZCnku
         TlnjLYh42zSExLCFsaedek+FU6Ap7Q0WTqvwBidnRs2XTfnWnvM6uKHNGPLnZ1EmAv
         qAH+KIXBx0Pe5XZxLF34wUhJgnJymfXBOS18NG1x+zmNrIh+45+R+gqYZ/eVlhyMOc
         OFXnuVSONyurg==
Received: (nullmailer pid 389051 invoked by uid 1000);
        Thu, 27 Jul 2023 06:15:20 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     bhupesh.sharma@linaro.org, quic_tdas@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        rfoss@kernel.org, daniel@ffwll.ch, stanimir.k.varbanov@gmail.com,
        mani@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, airlied@gmail.com,
        linux-media@vger.kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, sean@poorly.run, konrad.dybcio@linaro.org,
        freedreno@lists.freedesktop.org, linux-remoteproc@vger.kernel.org,
        agross@kernel.org, quic_vgarodia@quicinc.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, marijn.suijten@somainline.org,
        linux-mmc@vger.kernel.org, mathieu.poirier@linaro.org,
        mchehab@kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        jonathan@marek.ca, andersson@kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org
In-Reply-To: <1690433470-24102-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1690433470-24102-1-git-send-email-quic_rohiagar@quicinc.com>
Message-Id: <169043852071.389034.2408155277675671058.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Date:   Thu, 27 Jul 2023 00:15:20 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 10:21:10 +0530, Rohit Agarwal wrote:
> Update the RPMHPD references with new bindings defined in rpmhpd.h
> for Qualcomm SoCs SM8[2345]50.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml    | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml   | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml     | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml    | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml   | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml    | 3 ++-
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml          | 3 ++-
>  Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml | 3 ++-
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml          | 7 ++++---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml | 3 ++-
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml          | 5 +++--
>  Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml | 3 ++-
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml          | 7 ++++---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml | 3 ++-
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml          | 7 ++++---
>  Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml     | 3 ++-
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml               | 3 ++-
>  Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml  | 5 +++--
>  18 files changed, 44 insertions(+), 26 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dts:22:18: fatal error: dt-bindings/power/qcom,rpmhpd.h: No such file or directory
   22 |         #include <dt-bindings/power/qcom,rpmhpd.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1690433470-24102-1-git-send-email-quic_rohiagar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

