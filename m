Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9D7DA28D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbjJ0Vge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjJ0Vgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:36:32 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC91B5;
        Fri, 27 Oct 2023 14:36:30 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6c4a25f6390so1662410a34.2;
        Fri, 27 Oct 2023 14:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442589; x=1699047389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOW1gEyiWmEb/ezKdyTSa7aCrvLtzejrHPgIEGPvmy0=;
        b=jpfDoL2cTkyHz5rWEBU3ywhoBa9r4fkAO0Qy2gAgOJ6TRf7+qzGo7Y//i6TyIyvOMq
         f+rQQb03PMaDbqW5kwpvMI8pOhtETPT2FCnyPcMDH8lKlnhOnu9taQL/YU6WoN4ReAYp
         k2LLQYoc9+iKvSRbOOL+kHJDWB7w539mHIHNnqWXiLj75795K1G6Oor1oXHu+yA7vq8y
         qP4HofdYGxcwM4g7cHoi9FlcqfrhlIAakGmhAxq4M3CHi9J5MpOMj6hqzA7TbGzHKdCY
         Fu72jE7+6SAW5B46t9D6owvfsQ9M4M613JMPOm3RQ5J5UtzY6cr0mmjQp5f3AFDqUi4B
         UtPQ==
X-Gm-Message-State: AOJu0YxCna6n3v9c+MK7C1xZFihCtEVFeJNRO7xxwRx9uMQJO707vOBX
        7fWbq0NDcmRhbD+5obnkuw==
X-Google-Smtp-Source: AGHT+IFip7ODb1zb61QmrdBN36ulxahgE6GgTEI4aD6ID2yrNuo5bR0hxSJHwxDIywoUx9LZKxej8A==
X-Received: by 2002:a05:6830:2b23:b0:6b4:5ed3:8246 with SMTP id l35-20020a0568302b2300b006b45ed38246mr5754653otv.2.1698442589625;
        Fri, 27 Oct 2023 14:36:29 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a05683026c600b006b9e872c0a0sm411926otu.68.2023.10.27.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:36:28 -0700 (PDT)
Received: (nullmailer pid 3413620 invoked by uid 1000);
        Fri, 27 Oct 2023 21:36:27 -0000
Date:   Fri, 27 Oct 2023 16:36:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl:
 add SM8650 LPASS
Message-ID: <169844258726.3413571.7068196166115912913.robh@kernel.org>
References: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org>
 <20231027093615.140656-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027093615.140656-2-krzysztof.kozlowski@linaro.org>
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


On Fri, 27 Oct 2023 11:36:14 +0200, Krzysztof Kozlowski wrote:
> Add bindings for the pin controller in Low Power Audio SubSystem (LPASS)
> of Qualcomm SM8650 SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../qcom,sm8650-lpass-lpi-pinctrl.yaml        | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

