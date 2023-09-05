Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88903792CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjIESBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjIER43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:56:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B583EA5E;
        Tue,  5 Sep 2023 10:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E9F1CE1286;
        Tue,  5 Sep 2023 17:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF86DC43397;
        Tue,  5 Sep 2023 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936133;
        bh=RBAG8ZYYuvEXmzdeIKhCe4dQDTnUdRpxhlaQhZKuHLI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qjC562cgkOdXqEWXTtWkaQcHbRLvNVIaRWHl9pW6MecM9dh7mA7zhrIFGV9l/WCEe
         XLvL6fira6Dj/9h7l8280L9aHBNuNqS2DUxNNb2cRBuXygxA2pydOC7Sogz+y4jlQA
         qk2S8Ej+u5Rla1Oa4oMQUMycVx1w324CD/lFf/PpxUw3B9Xk2fnZzH6bao3FKWvVBF
         6rrjVfRaEe1n5FAFeisVcdTGWJzrBr/arxb9nWcTehN/CXW2ya+7rVVi5gixa9qP2L
         ytecjGb7MxI9p5jocvg8CcRTpXAIVKWUoZiNfW/Rua5A8KaiPs54zJzYO+mll4HR5m
         LGh/6PDH/OECw==
Received: (nullmailer pid 3654274 invoked by uid 1000);
        Tue, 05 Sep 2023 17:48:50 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, quic_wcheng@quicinc.com,
        linux-usb@vger.kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-phy@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, kishon@kernel.org, kernel@quicinc.com,
        conor+dt@kernel.org, agross@kernel.org, abel.vesa@linaro.org,
        vkoul@kernel.org
In-Reply-To: <1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com>
Message-Id: <169393613081.3654258.4653148258731976775.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add qcom,sdx75-qmp-usb3-uni
 schema file
Date:   Tue, 05 Sep 2023 12:48:50 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 10:13:45 +0530, Rohit Agarwal wrote:
> Add a dt-binding schema for SDX75 SoC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  .../bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml  | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sdx75.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,gcc-sdx75.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

