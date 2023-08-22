Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC667843B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjHVOQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjHVOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:16:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C2CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:15:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso605088266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692713701; x=1693318501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4DLw6XTDNAFhNatfRk3x0GOB+7FFuPg6TdBFTu2R8A=;
        b=cDXis1/9H6ga7sfX51c8LBRsidPkDZkz1BEcyY8+qJTAK9S3d4wKzr4/c0cy/vz0OK
         iEznciWJg79AlOYok0rFH+OJGQFoKVgsEnQN3ARU0z20D88z2342aIk1EmlbEW1SwyoN
         bykzjZHwR4b/pOhGqUpcr4oc6QBqkFg7r5haNdmvKg0Vn/NZBZNa6a1jDyk+a9yUyxzq
         ULV+8Eb2nvIxVqujpO75IZlmRsEPuBI/3fupDYmyZmnCULz9zcRnLcjyZZ/zwXjTr1GR
         0sr7nhxBF/5hvEnVdQKSD/2nWm6K12Op6xvTJTIb9vOLD5JXqJYzKhqsG6ApXn913yys
         VgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713701; x=1693318501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4DLw6XTDNAFhNatfRk3x0GOB+7FFuPg6TdBFTu2R8A=;
        b=AFRzZq+8x0QhF4UDnUp9WQ/7Gz7oqe6mNSfdFNW+V0PsscLyrM/A1CBCCogugW0V4n
         YxPzLg1/qxQrdQJVvtNGqPXimL8/hXySqsf6UhRBlDOV1gXS9Se33x/dJtM6aSRvyMQn
         Hp6+KHcIGO+N32hawwqNE+UDBsCguglK/LOyWQaIvrVcaoyzBLPsqacH2MeQcAA4xKGI
         OiDg7USf8FOy321dCSqDD48ec01R2lMyGvKQYaSlwbhDi9cBXzwGyZ9PLUu60+kZY2qf
         Y0kqHux/Jj3oLF/pv2gbwdnJbq4dkmPXY26KBN0l5CLTQnP2xJvjjkYGD86o8Dz1SgbO
         F1+g==
X-Gm-Message-State: AOJu0YxYTTgD0Z6NVHFNU0HfJtROM/KTcFjyeAqWH+ovl3//YVcDiwh/
        QhALMwiDGr7aTiR/BE3BEBZ9rw==
X-Google-Smtp-Source: AGHT+IFpvCuJdRyZJXLEO9jFQ8C+LPqwdFfkcO2XBT81TVq+cEzqj96fiZjcq1dGZMebinCHVXfnjA==
X-Received: by 2002:a17:906:8477:b0:993:dcca:9607 with SMTP id hx23-20020a170906847700b00993dcca9607mr7851132ejc.2.1692713700828;
        Tue, 22 Aug 2023 07:15:00 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906b19400b0098f33157e7dsm8246078ejy.82.2023.08.22.07.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:15:00 -0700 (PDT)
Message-ID: <96750636-9159-5104-894a-8894a5f70b7a@linaro.org>
Date:   Tue, 22 Aug 2023 16:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
 <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 16:11, Neil Armstrong wrote:
> Document SM8550 compatible for Pseudo Random Generator,
> like SM8450 doesn't require clocks setup done by the secure
> firmware.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

