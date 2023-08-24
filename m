Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1578716B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbjHXOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjHXOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:23:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43510DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:23:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so536962866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692887032; x=1693491832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuxAuWjJoFzHyHwLtGA2ahqwav7/CRPlP+G3HiORR1A=;
        b=FTQbhWX8F7N/uTWx1BuFgwF6dhko2L1mpXn/rJEJPPIl8cBmgKDnrfFNRT/vT0nC4w
         /jYjy3pWzei1e/kelGu29pgALVfTfNdvAdEln9bZl0uWP1i9l6fiNKL/eBh0F+ACuIXY
         U9L+DwT/v/WQTTPi5IdflHxUM6GFZccw1XkvsQvK0Ky9tvuExhabELim7WyHcX88ms3c
         D2HEZ149Jn1iVFN7H0hTNJaytZ0T5C/K2t/pZvH1m9Y56Er3eYnst3yReWKrc4wWZPyS
         0kuiFQ6cZafMdGAkfyLVJF4s9E2TZN2xXZEM1Qg737b1GI4NAqgFWtciL6m0bP02sa0z
         MQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887032; x=1693491832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuxAuWjJoFzHyHwLtGA2ahqwav7/CRPlP+G3HiORR1A=;
        b=QkCe7bVQMgY54kptOZL6hamOEJDgZpcoJqDoN2r6Jpt/sZB4Pfnsgm2ADljCef3de+
         0dJRB1pNHrcxGB0B65AffShBNelfXtAeNZH0iKFaGAuwfRk8nEOwNeP7sN22Xj3gneIV
         U813rXc36UXx0gn8kc+nUQYygAj1iaI8t8WrULn/+nfTg2N5Ql1g0lstGZ7vQU+JkrqV
         o4zduE+Y0kG/8n+4I8UdcoN2diQmI/Dyuhl5LvUC1n3ml85Aam7vIGP7310Amb6UnrNj
         qK8oN6OWApnRPbnNp748OvIwCdoQ/THPTv/pKT/nNfWA/3lgO0G5JjXHi+zK4x8CUaNw
         Maig==
X-Gm-Message-State: AOJu0Yww+MoY3yF8PQD9q6fuoAid1yP8V5VCA/x1DQYnw95GnJiSBGr1
        rPe6gE78WT8zCbFxIHAaJbEVNQ==
X-Google-Smtp-Source: AGHT+IEepB2N6hNtiK+GYtT41ZScTWazTZoNCpADIDbfsAnN2NhrjHJJI1Q/Kj9lkatdazmjfl16Bg==
X-Received: by 2002:a17:906:5dd9:b0:99d:ec81:df58 with SMTP id p25-20020a1709065dd900b0099dec81df58mr11734518ejv.19.1692887032595;
        Thu, 24 Aug 2023 07:23:52 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709061ed200b00988dbbd1f7esm10954016ejj.213.2023.08.24.07.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:23:52 -0700 (PDT)
Message-ID: <c271ac74-04b5-03b3-8e97-5c3e04472cfe@linaro.org>
Date:   Thu, 24 Aug 2023 16:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: tsens: Add sa8775p
 compatible
Content-Language: en-US
To:     Priyansh Jain <quic_priyjain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com
References: <20230824123001.26778-1-quic_priyjain@quicinc.com>
 <20230824123001.26778-2-quic_priyjain@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824123001.26778-2-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 14:30, Priyansh Jain wrote:
> Add compatibility string for the thermal sensors on sa8775p platform.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

