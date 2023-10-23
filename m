Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C57D3DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjJWRk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjJWRky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:40:54 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D6C5;
        Mon, 23 Oct 2023 10:40:52 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce2cc39d12so2432576a34.1;
        Mon, 23 Oct 2023 10:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082851; x=1698687651;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ci20MeXAaJovlWs32J4lQ2AOh7wVQ5T3pLsa9J8Ay3o=;
        b=KsBGxYy7s00yZBPtCryBg0UJ8IA6gfTsCm8avo2UM1QLeMHmAcW9gPH14KW4r7AoON
         vTx1eFh6JE3YjNn1jNXqFs+2eTsMYX7fqu+9249lt+2MWtBFzeG58CorgZPNYpZmkvBq
         MxdK+U5LeyzIO0IO78vB5zx2XvXIBKewisR4Yz3LlmAjUA4hJUIiy25pZBClueCcUBTb
         J9pUP8FtsSz0HeQ0/KQmiARdyJ0qmy3hNE5bk+c9VF4Rj/A3lmo/yGbeIwSpZ3wEKLu2
         L9bhb6arxzP5LjW98ZkppDLxxu+kdjaCro0wajXVSkAx9BMvgB7H7SjCG42znKEn+TMS
         Vl7A==
X-Gm-Message-State: AOJu0YxVy/m6T6V0UA+rPYEMFMLn+PpZcqeXagTL0taue3Oiii+2QM/n
        uod9ILj87/udA5yP867sfg==
X-Google-Smtp-Source: AGHT+IG9RRIIApJVrYk+XEij6WOv/Dl0c/S+lWqfznYF8ZkbRj8yAI1ZaacK6GpVmpiljJ7E0ZLZOA==
X-Received: by 2002:a05:6830:16c9:b0:6c4:8441:f90 with SMTP id l9-20020a05683016c900b006c484410f90mr10480313otr.24.1698082851524;
        Mon, 23 Oct 2023 10:40:51 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6e0:8169:8cd7:6070:de02:c079])
        by smtp.gmail.com with ESMTPSA id c23-20020a9d6c97000000b006c619f17669sm1491924otr.74.2023.10.23.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:40:50 -0700 (PDT)
Received: (nullmailer pid 864623 invoked by uid 1000);
        Mon, 23 Oct 2023 17:40:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
Message-Id: <169808265626.861066.13083505051202182067.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916
 vm-bms and lbc
Date:   Mon, 23 Oct 2023 12:40:49 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
> PM8916 (and probably some other similar pmics) have hardware blocks for
> battery monitoring and charging. Add patterns for respecive nodes so the
> devicetree for those blocks can be validated properly.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

