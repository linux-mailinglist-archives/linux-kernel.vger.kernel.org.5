Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567177654C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjG0NRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjG0NRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3974271B;
        Thu, 27 Jul 2023 06:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8006D61E77;
        Thu, 27 Jul 2023 13:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069B3C433C9;
        Thu, 27 Jul 2023 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690463818;
        bh=DUlLuWL4cE5am5s9QK+fFshV+j9iTbP7jA5deX6kjTs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AFf47cE1LQhpwJRelzAV0a/V4s5bbicoushv8cjJw/luJEv4giXHlRWecPmsEJA0/
         KnV36cP0ASblrAOaCu+7P//cqsn/ro7m/wo4b8mWOzEF3iWoH3Uuc3QjmRNuzkKPCw
         CymVnlaBP2D81Dc5uAcTohwZXHIkdunCZgLGmZKCIxYbJpmcwvgcAZVTYJuaIT07px
         KwWMvDOBmzvhdZZqM5SMc7umTjVmTwIdIlYICgroOSI1S3flF00xjkJZt6MWV6g0t5
         uvIMDSHFSTx21w2LzS8iH1SyVbl4VzIRFVCTkK840ezWoEQVbi15e2d2DBy1fJsdPE
         MxsnA0AvFR5bw==
Received: (nullmailer pid 1270046 invoked by uid 1000);
        Thu, 27 Jul 2023 13:16:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     robh+dt@kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, mathieu.poirier@linaro.org,
        quic_tdas@quicinc.com, mchehab@kernel.org, agross@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel@ffwll.ch, linux-media@vger.kernel.org,
        dmitry.baryshkov@linaro.org, vladimir.zapolskiy@linaro.org,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        linux-mmc@vger.kernel.org, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, jonathan@marek.ca,
        devicetree@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        airlied@gmail.com, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, rfoss@kernel.org, mani@kernel.org,
        dri-devel@lists.freedesktop.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, bhupesh.sharma@linaro.org,
        linux-clk@vger.kernel.org, sean@poorly.run, ulf.hansson@linaro.org,
        robdclark@gmail.com, sboyd@kernel.org, quic_vgarodia@quicinc.com
In-Reply-To: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
Message-Id: <169046381501.1270011.10571652656239031435.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some
 SoCs
Date:   Thu, 27 Jul 2023 07:16:55 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 18:13:33 +0530, Rohit Agarwal wrote:
> Update the RPMHPD references with new bindings defined in rpmhpd.h
> for Qualcomm SoCs SM8[2345]50.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
> 
> Changes in v2:
>  - Removed the unnecessary inclusion of header rpmpd.h.
> 
> This patch is dependent on the series that includes the new rpmhpd.h header
> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
> 
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

