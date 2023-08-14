Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051DB77B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjHNGnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjHNGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:42:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C610C1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:42:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5233deb7cb9so4886191a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691995364; x=1692600164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uQPBosJnF8JMaIESUn9a6pEN4H6O/rDfv1IpFvV4gc=;
        b=tCoxS5U0erBg8aQ3By2RPQE84+vufddgYKijftwkGVSGsVzTYcPFNLxyOeofyJhWF4
         LM+p5gKf6L0jaMAC/4beqCAWtzf38W1CwOHdq3oeweXeUIP/8F7hUusY85mrD4yekN7/
         jdm58kDbLQ3BM/fFIFK9vv+rFKCTlS1Odiz1dRO0RYGNglpFNBFkPFjon0FLLpIsJhLT
         RrTOFErAuNTQJaYVqJBQWrKA9K9AvS6PAvDuCBxPqo3OOkGeM52Jh+22ez8hSVJMH3rl
         ZK6JrA1ZJSfYiE0h30PMLDZoFJzPy6kbsymT2kIPGzJznLONZJ4lJ169phMBH6cuigVS
         t1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691995364; x=1692600164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uQPBosJnF8JMaIESUn9a6pEN4H6O/rDfv1IpFvV4gc=;
        b=Q8X+702fq6x0h6ttxLxBwYD+1K3Eo8ubj6Wpnh+3j6xQD1mzGDFmqsbDDPorAhQnz+
         pQYDNbnfvXj5bRrK1TanVlxC/MZP+moF4ArfMthrkFmhxqAxTf7wQeBXpHttZ/o8aaFJ
         /Ee7w/hLckhcpnkYptuoG98N0bC/4u77a+uBb1vIDcTDXNGpkXLejYtO8+u3jUPaw1ut
         E5AeLxH6ydhGY/TKB3aBAxWMYEDTQRnK8G/S5OZY46hiHMnK1JYx6Zjqw8E0e/8u6DHr
         cF8yjGwKgYjUqAyclPqGOtT051opa4E18ROXbnLGbMoNz7601P601E4zLQv7IK/VFjTT
         NUvQ==
X-Gm-Message-State: AOJu0YzU0tjGK2y9qB3yxl0tzSdf94zzuYGZgHF/fdD4nYjFTGpJI+wW
        rAksKJ1tpodSXlrRxHdvF45XOg==
X-Google-Smtp-Source: AGHT+IHL3BrYT9hcbD2l+kSKHckU3vNj9ruviF7zZUQH0dXomzUWO4qL/t94DJ4ctl56KfSdWTvUsA==
X-Received: by 2002:a17:906:538d:b0:99b:ce19:b69a with SMTP id g13-20020a170906538d00b0099bce19b69amr7087659ejo.53.1691995363867;
        Sun, 13 Aug 2023 23:42:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099bcbaa242asm5328164ejw.9.2023.08.13.23.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:42:43 -0700 (PDT)
Message-ID: <484fe3d7-210f-4d70-b387-3455ec4ad9f0@linaro.org>
Date:   Mon, 14 Aug 2023 08:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: qcom: Document MSM8x26-based
 Lumia phones
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20230813152623.64989-1-rayyan@ansari.sh>
 <20230813152623.64989-2-rayyan@ansari.sh>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230813152623.64989-2-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2023 17:23, Rayyan Ansari wrote:
> Document MSM8226 and MSM8926 Lumias.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

