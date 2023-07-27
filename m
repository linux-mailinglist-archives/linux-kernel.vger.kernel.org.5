Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449B765214
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjG0LQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG0LQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585C106;
        Thu, 27 Jul 2023 04:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A8861E36;
        Thu, 27 Jul 2023 11:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7892C433C9;
        Thu, 27 Jul 2023 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690456601;
        bh=cZkz1oo7ETQltYgDElF9VKUnqpQf2BVJHGb003Z9HnI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ABZFhD2nUoRyN8felpz/f4jZtwY2dEKPrcqpX+SpvDEi9T+KMEq4fAV1/EWh2YcE7
         sVX5Ar5i0P+GGmXCR3c5nfO0z/1IbXIAzv8OWZSVIxzy45OO2IabEYS9LCzl9121/R
         E8R38PAc4WWHKdhX5GaKLCa4SQAdfkf9nDXuNaqrlNJE+IgyuJxHf4iJMiZyFFN5+t
         D4kiTzTnVgoOsAg+SzxangBo+WmsjrDZUdSNipY2GEv7jkZpIfL7ZrsL4BB17a0+fD
         N4TiERBxuHwF5f4F5E+Qd3QAmeGFKWh6/j9VuTPSnONEFm9bIlm7wTiVy5mS7sPpOU
         kCB/ymedX3baQ==
Received: (nullmailer pid 1058759 invoked by uid 1000);
        Thu, 27 Jul 2023 11:16:37 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     mathieu.poirier@linaro.org, mchehab@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_vgarodia@quicinc.com,
        konrad.dybcio@linaro.org, agross@kernel.org,
        freedreno@lists.freedesktop.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jonathan@marek.ca,
        conor+dt@kernel.org, robh+dt@kernel.org, airlied@gmail.com,
        linux-mmc@vger.kernel.org, quic_tdas@quicinc.com,
        stanimir.k.varbanov@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, dmitry.baryshkov@linaro.org,
        linux-remoteproc@vger.kernel.org, sean@poorly.run,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org, mani@kernel.org,
        linux-media@vger.kernel.org, sboyd@kernel.org,
        quic_abhinavk@quicinc.com, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, marijn.suijten@somainline.org,
        neil.armstrong@linaro.org, robdclark@gmail.com
In-Reply-To: <1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com>
Message-Id: <169045659774.1058731.6391693092002547810.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some
 SoCs
Date:   Thu, 27 Jul 2023 05:16:37 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 14:39:13 +0530, Rohit Agarwal wrote:
> Update the RPMHPD references with new bindings defined in rpmhpd.h
> for Qualcomm SoCs SM8[2345]50.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml  | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml    | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml  | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 8 ++++----
>  .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 +++---
>  .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++----
>  .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++----
>  Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml    | 4 ++--
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml              | 4 ++--
>  Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 6 +++---
>  18 files changed, 44 insertions(+), 44 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dts:21:18: fatal error: dt-bindings/power/qcom,rpmhpd.h: No such file or directory
   21 |         #include <dt-bindings/power/qcom,rpmhpd.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

