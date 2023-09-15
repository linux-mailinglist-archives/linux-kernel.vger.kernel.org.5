Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D477A1438
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIODNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIODNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:13:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65026A4;
        Thu, 14 Sep 2023 20:13:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AF7C433C7;
        Fri, 15 Sep 2023 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694747590;
        bh=MRLY/Pl/eLwnX0CaZBab5UXCKw2GHtlqTye/6yyHbYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S2avqbfAFFj/0yAUNOdtRzi69JobiJqSSBhfUHp9nMhRu5vNVdfL4D28rr4M8mL0n
         7AbrT9Tu1ruh92N8N2rkqeF1Th43PfIqZ3GuFiKVQq0E981ez/IW4a7aqpsxWkbYCT
         7Z2vof3pbBLrIQW6jRVQOBCfp2L+c7Xv7+4DYSc/2oSzbr+nF2ADQYIFv3RHx2Lh9j
         bgMBPsq8aBDKBBHhP5lKsnpdIs3z21bPdDQCO1xk4gwaAEGUM7hI7/KcFy9dLNcVgK
         QstxOBlPAPnkFZAxsVjzjIKE/yybHe91Xo9hsDBhxtzJeZTVG7ZukolLnuEtpcXPh1
         /XlTm3P2J7+5Q==
Received: (nullmailer pid 2399767 invoked by uid 1000);
        Fri, 15 Sep 2023 03:13:07 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     quic_tdas@quicinc.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        konrad.dybcio@linaro.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com,
        quic_shashim@quicinc.com, quic_aiquny@quicinc.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org, quic_tsoni@quicinc.com
In-Reply-To: <20230915020129.19611-2-quic_tengfan@quicinc.com>
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-2-quic_tengfan@quicinc.com>
Message-Id: <169474758717.2399747.7717873447401503497.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM4450
Date:   Thu, 14 Sep 2023 22:13:07 -0500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 10:01:28 +0800, Tengfei Fan wrote:
> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
> and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../interconnect/qcom,sm4450-rpmh.yaml        | 133 ++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm4450.h    | 163 ++++++++++++++++++
>  2 files changed, 296 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm4450.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm4450-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,sm4450-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230915020129.19611-2-quic_tengfan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

