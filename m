Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312DC798358
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjIHHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjIHHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:42:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C31BDA;
        Fri,  8 Sep 2023 00:42:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64EDC433C9;
        Fri,  8 Sep 2023 07:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694158947;
        bh=b0W2vlY4CgJqt1HiR9SSVt08ChzyrdUmrFpWJeUBUwM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L2sgO/dmZOmaI8oqFoM6BaTr5d0fzf1dPzytCdMuvjy8V/VC4BL6pmIp9QMF6gflO
         0ymS9cWGMvPZRSX18OEYIXpgKPbFBm7Hl9BuIl5fVjMeqBisKBcU22HG100iVGzyrT
         O9TNntRVx4P4BenWtUL9OuByx2xYdye4ypd4ZtcfgmnydTZhmTq5sBzpk5riywP/hQ
         lAnWp68ECQkc2R6mj90YJMLG23wNCuEqN7tRWJx2F1e75hTgKrZBR8M8KA6niEUugG
         Gclmw1wpEuHOFxfLcL7Lq7Em0TB6o7EnXnqvlTmep4jbysPj1sbe9F9EzG4HTmTgTr
         H4COtm0l2yWyw==
Received: (nullmailer pid 3239586 invoked by uid 1000);
        Fri, 08 Sep 2023 07:42:23 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     will@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_kaushalk@quicinc.com,
        peng.fan@nxp.com, kernel@quicinc.com, catalin.marinas@arm.com,
        rafal@milecki.pl, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, quic_shashim@quicinc.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-pm@vger.kernel.org, quic_tsoni@quicinc.com,
        geert+renesas@glider.be, andersson@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, agross@kernel.org,
        quic_tdas@quicinc.com, djakov@kernel.org, konrad.dybcio@linaro.org
In-Reply-To: <20230908064427.26999-2-quic_tengfan@quicinc.com>
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-2-quic_tengfan@quicinc.com>
Message-Id: <169415894359.3239551.14338430937225080028.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
Date:   Fri, 08 Sep 2023 02:42:23 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Sep 2023 14:44:25 +0800, Tengfei Fan wrote:
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
Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm4450.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,gcc-sm4450.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908064427.26999-2-quic_tengfan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

