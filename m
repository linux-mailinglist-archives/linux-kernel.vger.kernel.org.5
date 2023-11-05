Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C524D7E15C9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKESZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:25:19 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E0BE;
        Sun,  5 Nov 2023 10:25:16 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2c71c61fso1975863a34.1;
        Sun, 05 Nov 2023 10:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699208716; x=1699813516;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4y1IraQYh3H6lxTiJ29Tx+EfGHZDN1CM++p6MjOMyQ=;
        b=ubA1qNkcrr1oXVt2WZhldHJLVKrbrRSbYkJ56wLf2VE/zfVNvDJYeLsEPT9wtMPWnW
         BVBrt4jYmkGNbSeWAHO2tRZj1gAosR/Qf2FhW627W9m3e/JdkW4XD10U1CiL63//N44z
         nKxsLWBnaHoeYuXmUET6EfwuD802EKApm/o3Mj5t6Xs0iS+tPBVdD5sxB1BdDsOY93D5
         5+RQl0Ixmj3NtpCe94mru3AegkXQS7xFJq/gEON6vzJ0aVNpMBHF18rEnT/byA1wtpvr
         dZKDVGY1seLAqT8ZmyxxOPe+Y1947zV97344XujyfcPxXqhvKCVzjplAXcSr1B8SaG1W
         udog==
X-Gm-Message-State: AOJu0Yws2LITbaXQRxHeQ9BzPZlG1DdF5CRdjggGMeQvUYGuJ0WCUCS4
        Y1oDqtdc6n/Cfjl8vxjCGQ==
X-Google-Smtp-Source: AGHT+IF3HbEEGHEXV5dgj5RM8rXJl21RMytOnVR9czMyioFRoUl0OUSu2mcz4KNZRXxseJD3Iy+jGQ==
X-Received: by 2002:a9d:7d8c:0:b0:6b9:9bcd:32fe with SMTP id j12-20020a9d7d8c000000b006b99bcd32femr23214919otn.17.1699208715753;
        Sun, 05 Nov 2023 10:25:15 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r9-20020a9d7cc9000000b006b96384ba1csm992643otn.77.2023.11.05.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:25:15 -0800 (PST)
Received: (nullmailer pid 1778778 invoked by uid 1000);
        Sun, 05 Nov 2023 18:25:13 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Todor Tomov <todor.too@gmail.com>, Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Andy Gross <agross@kernel.org>, hverkuil-cisco@xs4all.nl,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        laurent.pinchart@ideasonboard.com, vincent.knecht@mailoo.org,
        devicetree@vger.kernel.org, quic_grosikop@quicinc.com,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-1-4b3c372ff0f4@linaro.org>
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
 <20231105-b4-camss-sc8280xp-v3-1-4b3c372ff0f4@linaro.org>
Message-Id: <169920871369.1778750.12101674904903495174.robh@kernel.org>
Subject: Re: [PATCH v3 1/6] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Date:   Sun, 05 Nov 2023 12:25:13 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 05 Nov 2023 17:45:00 +0000, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231105-b4-camss-sc8280xp-v3-1-4b3c372ff0f4@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

