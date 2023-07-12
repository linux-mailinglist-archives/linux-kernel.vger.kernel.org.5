Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE597751178
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjGLTnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGLTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:43:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E921FEC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:43:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e590a8d0bso4958713a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689191025; x=1691783025;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8+vjNobIMWMrzf0FKkwYNB3OzBHSpvmANZBPCBUHmE=;
        b=pdfCW/mCYx8e/bNU5tSwbVHysL9r7MaYQ3GWxA3ZjoM8HBsBPEdG8Uzb7WHqaB88dj
         qx8zPsQWxHc2xee5MeLdt8GB//cj2+1XYL02hnXd0Sz9rp5sK5FQPClYFKQeHO0INPNC
         JbdBeVRyvb7URnTv6hL12GYaYV3T5oPc5j4zf+SC65dr/M+o54ZZneX4ykFFiaUlopZG
         dakQgMgQ3TOxYpOB/UuRUkYGa2hp+LVjgiDScZAV7izpHUn5tpGaQoPID9fFYauGpfGy
         XXAQyHwZfc5haFPJj9kAGX1WIWZuBUrvAda2gLByE5bLyH94eaYAaocOIFtfl7g6huIT
         keVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191025; x=1691783025;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8+vjNobIMWMrzf0FKkwYNB3OzBHSpvmANZBPCBUHmE=;
        b=IBb7aLPK6Cxd+UMTjNG5SMJ0FZLmahEeG5q9xLT8jwg7uFsk5RWZv+JzCHn4GvaIxu
         WbJxvyHJOYxXAkuQyMb/kk/k9qOfjkezf3mVI5f04MiaWx88ZP6Ez6LqtU2LffcMkwXj
         0uNHLXa+cPX8VbN2QuJOjgqOgMnJDL+Cbw1cJ72DLwjP/XxQDBucj7dzBtEsBG4TCpBJ
         c6eJUsEU4CB5Q8f5H7uBqAHszLMYWMiNdUVO+S3Cok0FgVeQU4CjFUGJZsa59iwRbJee
         SB/UvmIJsuKWmiE0ZL+yDXKL3oFBX72AQ6hgSSxdaCmx+VAyjnVaBaky1fi6BnAAqhXw
         VH0w==
X-Gm-Message-State: ABy/qLbkppwTrXVnwbfX5JTKLjLq9zhoZfDF1UF/m21rRBZFWBWMuWNF
        BGwuWeOE6LJqkWsSRgqx8rvYsA==
X-Google-Smtp-Source: APBJJlGYvDj0/4R+xQD2mNLvCqsxd9qJdifuFvM8ZCbtFnkv2PeqjmsrKw+1CBv3KCAf73/r+NieFg==
X-Received: by 2002:aa7:d302:0:b0:51d:d1af:df15 with SMTP id p2-20020aa7d302000000b0051dd1afdf15mr21184971edq.23.1689191025310;
        Wed, 12 Jul 2023 12:43:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7cd46000000b0051e3385a395sm3237965edw.3.2023.07.12.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:43:44 -0700 (PDT)
Message-ID: <673c5cc4-fc93-ccba-ac32-6e97db34718d@linaro.org>
Date:   Wed, 12 Jul 2023 21:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <e3a6e5cf68d67637fa541f6dc690dbcabd5e3fec.1689160067.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3a6e5cf68d67637fa541f6dc690dbcabd5e3fec.1689160067.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:38, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

