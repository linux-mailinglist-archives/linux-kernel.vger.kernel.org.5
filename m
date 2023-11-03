Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933947E0759
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377348AbjKCRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjKCRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:25:43 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B768713E;
        Fri,  3 Nov 2023 10:25:37 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b3ec45d6e9so1375650b6e.0;
        Fri, 03 Nov 2023 10:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032337; x=1699637137;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQjjfhlnmzRDjE/9MY7CPSCRY6bOaSf38w1z3/ED/wE=;
        b=f6q+l2SElQVk7tA5l5ddTHiSiEnhZmbM0CoJMU5SOxIlSQDA7A3MZjZrIKRxzt5LOc
         KrVlQNeYrBJaCH/5qQWxNncpa1RyT5Qn/qBb8J4HztMut8ZeBTJr6wz4TY498Hv1QFKD
         sg2sDLkwRbZKoFQLwtvs1F6f6N0Xk5/hkQR6rxc+02Iwy5FJ+APjPF4OYsa6a5+BGUQx
         H05RwCgt2PKzE5DGGqTJVZJWu6NTiCOEJNNZtV6hIddJnZpJ69d5EIqmo797zY1nicVl
         tG86RX0wXsl1iYnVFWsbbu+wkhK/O1B6OKK9LQaFFYHRyWkQv5XVcqq19BvCiO8G+lE9
         ddSw==
X-Gm-Message-State: AOJu0Yz2VJvlRtXpWh5es5XMLaaacMruRtZlyUrqb3miyKIKslAv/DtR
        4IC8aENaq4aLSOB5fBwKIw==
X-Google-Smtp-Source: AGHT+IEn/XQUwpNA3WOf8aGalFihRK9hfZ7HarRN/GOuhh8KZILh/0W541V6OttK/nZwQh1czqr5zA==
X-Received: by 2002:a05:6870:169a:b0:1e9:9e04:1d1e with SMTP id j26-20020a056870169a00b001e99e041d1emr26781631oae.48.1699032336788;
        Fri, 03 Nov 2023 10:25:36 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e5-20020a056870450500b001e12bb81363sm367717oao.35.2023.11.03.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:25:36 -0700 (PDT)
Received: (nullmailer pid 1588221 invoked by uid 1000);
        Fri, 03 Nov 2023 17:25:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Foss <rfoss@kernel.org>, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        vincent.knecht@mailoo.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com,
        laurent.pinchart@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        hverkuil-cisco@xs4all.nl, Todor Tomov <todor.too@gmail.com>
In-Reply-To: <20231103-b4-camss-sc8280xp-v2-1-b7af4d253a20@linaro.org>
References: <20231103-b4-camss-sc8280xp-v2-0-b7af4d253a20@linaro.org>
 <20231103-b4-camss-sc8280xp-v2-1-b7af4d253a20@linaro.org>
Message-Id: <169903233490.1588205.2821182125390694665.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date:   Fri, 03 Nov 2023 12:25:34 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Nov 2023 16:25:04 +0000, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> This patch depends on:
> https://lore.kernel.org/linux-arm-msm/20231026105345.3376-2-bryan.odonoghue@linaro.org/
> https://lore.kernel.org/linux-arm-msm/20231026105345.3376-3-bryan.odonoghue@linaro.org/
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/qcom,sc8280xp-camss.yaml        | 581 +++++++++++++++++++++
>  1 file changed, 581 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dts:26:18: fatal error: dt-bindings/clock/qcom,sc8280xp-camcc.h: No such file or directory
   26 |         #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231103-b4-camss-sc8280xp-v2-1-b7af4d253a20@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

