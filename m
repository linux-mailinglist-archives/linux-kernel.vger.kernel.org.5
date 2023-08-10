Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30B777828
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHJMVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjHJMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A43E54;
        Thu, 10 Aug 2023 05:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F07B65B17;
        Thu, 10 Aug 2023 12:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82B7C433C9;
        Thu, 10 Aug 2023 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670107;
        bh=PTNG+5DeJA1v36JVvtNwJ4YPtGxvB/i4i1Aaf+jHBro=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BaUJbzp/D1kkg7XQZSlUbLQLly7dOjGHCzK0mFcaTKEpvKRKdxJ+zo6ay2XLr5rzf
         lNy6VHcD/wmZigPfZJ6P3bbtDMTvWzNwPIKkst7B8LBfGX/iCbGtRMU/dHacVjYggv
         cgmMiyDMRpajNeZubKsVInRpmbi9XKtveOfAbP7yBdE/E82OtonFP5KuEJiGOv/RJd
         34ZpTG99O+XYfrGK5Mx+QCtuWhCtM3ROb8JuQ6nhYQzgYSY7L+pgL5GPZIyjuNh76Z
         AfPE5T3I9aeIB4nVnGL7J+t7PNFlmsEijE8cnV4EBrgFRuhgYP4vKX75qy+HCVLVB0
         UMEz1FUPoXjCA==
Received: (nullmailer pid 172516 invoked by uid 1000);
        Thu, 10 Aug 2023 12:21:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     will@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srichara@quicinc.com, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, catalin.marinas@arm.com,
        linux-arm-msm@vger.kernel.org, p.zabel@pengutronix.de,
        sboyd@kernel.org, robh+dt@kernel.org, agross@kernel.org
In-Reply-To: <20230810115419.25539-3-quic_luoj@quicinc.com>
References: <20230810115419.25539-1-quic_luoj@quicinc.com>
 <20230810115419.25539-3-quic_luoj@quicinc.com>
Message-Id: <169167010382.172482.17724566948717998889.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: add qca8386/qca8084 clock
 and reset definitions
Date:   Thu, 10 Aug 2023 06:21:43 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 19:54:18 +0800, Luo Jie wrote:
> QCA8386/QCA8084 includes the clock & reset controller that is
> accessed by MDIO bus. Two work modes are supported, qca8386 works
> as switch mode, qca8084 works as PHY mode.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,qca8k-nsscc.yaml      |  79 ++++++++++++++
>  include/dt-bindings/clock/qcom,qca8k-nsscc.h  | 101 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,qca8k-nsscc.h  |  75 +++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
>  create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810115419.25539-3-quic_luoj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

