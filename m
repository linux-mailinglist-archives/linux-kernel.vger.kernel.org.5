Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA77D6FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjJYOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJYOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:47:37 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD9B0;
        Wed, 25 Oct 2023 07:47:35 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2e44c7941so3966883b6e.2;
        Wed, 25 Oct 2023 07:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245255; x=1698850055;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eU9dcz1YGa9iU8LlGA/PhULWkXEMb0rfxCJT61Ovfuc=;
        b=m8e1sfrhXtPvOoE1xxgYXZByt7tKA0HZt9rcv5lMdIcHX0Y1VPf90UVm1tbUga+En1
         wlpVRksokoYHJQ8vqs86EdJmCorAhm0uJaKdGMoo01jpypUnM/IR+8QHoZPrjgHWxGZ1
         mD/cVavHM6nUP7Dq+vF/r4bRi+Z0dAeZT/P7ViC17rlgZC9MmTLPO7SkR24W3UtFiSlo
         TimjA6aUpjZ2X7ynaVPghhcVoFcRLBFmm7BZqKs2iKu1NK3Y+QteBAqLLZm6nJuE2zLz
         62xMz8N8TIbzN9iCLFuN19foV/fCcCz8jMMc0DuJswe2rFo48BCLC+iLUMBIx/Zs/42C
         fswg==
X-Gm-Message-State: AOJu0YwpBfRfCCMb448Wii9QZcRuoRx7ozi22Z/zGown7hWmrFBFcPos
        DeJDnbalb7W8+hia1d+aMa1432xR9w==
X-Google-Smtp-Source: AGHT+IGHO+eEDenRbvjdxLALO/vIF1UN+JMcjErf2td8FFO4465DCrb+T8KVr5y3/DBabI3sw0GQiQ==
X-Received: by 2002:a54:448f:0:b0:3ae:5743:533a with SMTP id v15-20020a54448f000000b003ae5743533amr17400033oiv.47.1698245254994;
        Wed, 25 Oct 2023 07:47:34 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a056808000c00b003af6eeed9b6sm2387440oic.27.2023.10.25.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:47:34 -0700 (PDT)
Received: (nullmailer pid 259082 invoked by uid 1000);
        Wed, 25 Oct 2023 14:47:33 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-3-c89b59594caf@linaro.org>
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-3-c89b59594caf@linaro.org>
Message-Id: <169824516120.243773.546101172844888564.robh@kernel.org>
Subject: Re: [PATCH 03/10] dt-bindings: clock: qcom: document the SM8650
 Display Clock Controller
Date:   Wed, 25 Oct 2023 09:47:33 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 09:32:40 +0200, Neil Armstrong wrote:
> Add bindings documentation for the SM8650 Display Clock Controller.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8650-dispcc.yaml         | 106 +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8650-dispcc.h     | 101 ++++++++++++++++++++
>  2 files changed, 207 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm8650-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,sm8650-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231025-topic-sm8650-upstream-clocks-v1-3-c89b59594caf@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

