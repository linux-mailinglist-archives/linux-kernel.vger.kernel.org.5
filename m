Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AF798339
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjIHHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIHHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:22:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACC1BD3;
        Fri,  8 Sep 2023 00:22:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D766C433C7;
        Fri,  8 Sep 2023 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694157744;
        bh=ajqiSrKMjBT7jAGty2zzZBU2SB/Pp/XM2gFx0FcYSbc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UghCpV0FxxG9K6hv2KDF1Vay/eYbhUuvA/c6F4vStszwirS5d/xIwgSU3gE0jLv27
         MHaD+196Shljztbjm6Dv5yJe7iNCRpmwl5w1iPzpkjgfhKhEbTgqbybMXrCudGmmG8
         CRP0wlDn6XqEuxONJLe51s9nKnuD6IsdWzlok+DeKsOeG8N/bzAI4SxokyLenOpjYu
         ClPPeHK9Ak1p1LW4RAsc55OswYdia1qsCiFOf6o0Zm0891OMkXbErWfPSY9XC5Pbif
         II7gT/Ml87wD6gLO3POcdNmbZAUD735v2Cj/YdFVx3cIlO6yyY2BkdwOYvokDJ1pD3
         kCcRp04Wz4RHg==
Received: (nullmailer pid 3172383 invoked by uid 1000);
        Fri, 08 Sep 2023 07:22:20 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     quic_tingweiz@quicinc.com, linux-arm-kernel@lists.infradead.org,
        rafal@milecki.pl, conor+dt@kernel.org, nfraprado@collabora.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        quic_kaushalk@quicinc.com, andersson@kernel.org,
        quic_shashim@quicinc.com, linus.walleij@linaro.org,
        quic_tsoni@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        peng.fan@nxp.com, quic_tdas@quicinc.com, konrad.dybcio@linaro.org,
        arnd@arndb.de, will@kernel.org, robh+dt@kernel.org,
        agross@kernel.org, quic_aiquny@quicinc.com, kernel@quicinc.com
In-Reply-To: <20230908063843.26835-2-quic_tengfan@quicinc.com>
References: <20230908063843.26835-1-quic_tengfan@quicinc.com>
 <20230908063843.26835-2-quic_tengfan@quicinc.com>
Message-Id: <169415774033.3172287.2910545525997528344.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Date:   Fri, 08 Sep 2023 02:22:20 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Sep 2023 14:38:41 +0800, Tengfei Fan wrote:
> Add device tree binding Documentation details for Qualcomm SM4450
> TLMM device.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/pinctrl/qcom,tlmm-common.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908063843.26835-2-quic_tengfan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

