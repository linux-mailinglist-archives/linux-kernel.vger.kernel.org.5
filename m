Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D578848C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjHYKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbjHYKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D0D26BB;
        Fri, 25 Aug 2023 03:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B7661659;
        Fri, 25 Aug 2023 10:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E1CC433C8;
        Fri, 25 Aug 2023 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692958490;
        bh=F8oKNVTy6rC98/+pAVZNa2M+atmjLnnbW393Y6FNBxo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A8sw7xFVWcXBro5K9uPJOpgpgU7sA3zf9EWvvip2RG0ctsGSI70mxoQyHoBDNaVf/
         NMTZlY8a3pXOfwJLZjwS6YO/Vhp9A1m5XG9tOSJnRpZbvovGknzdF8MvzalNXFKttE
         G2TBUN7jNzf0UpoJxCWpTddFNy+ShUOkokH5Vv+cK/ad9fjrimWOtYzuH01UvqJTSM
         9ZUqZG4fz+8luaaZ5tywnaNWMRdbXznrKlrSG4cpvysgMw4gaNDrsRftoN9iCLuQMi
         qhkGjZc3UIf3oX8UkwuXG7tnB+/AYOOsW0j8kGmnic/eQKI2jwLvW84bWQYhpQ4Uxb
         Lbn1BqYsXKFcg==
Received: (nullmailer pid 2559857 invoked by uid 1000);
        Fri, 25 Aug 2023 10:14:46 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     rafal@milecki.pl, agross@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org,
        conor+dt@kernel.org, nfraprado@collabora.com,
        quic_saahtoma@quicinc.com, sboyd@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-clk@vger.kernel.org, arnd@arndb.de,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com, netdev@vger.kernel.org, geert+renesas@glider.be
In-Reply-To: <20230825091234.32713-5-quic_devipriy@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-5-quic_devipriy@quicinc.com>
Message-Id: <169295848663.2559800.3580053610150304724.robh@kernel.org>
Subject: Re: [PATCH V2 4/7] dt-bindings: clock: Add ipq9574 NSSCC clock and
 reset definitions
Date:   Fri, 25 Aug 2023 05:14:46 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 14:42:31 +0530, Devi Priya wrote:
> Add NSSCC clock and reset definitions for ipq9574.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Referenced gcc.yaml and dropped the duplicate properties from
> 	  the binding
> 	- Updated Uniphy clock names
> 	- Added nssnoc clocks and clock-names
> 
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml    | 107 ++++++++++++
>  .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>  .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>  3 files changed, 393 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>  create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.example.dts:28.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230825091234.32713-5-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

