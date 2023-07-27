Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680F7652D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjG0LrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjG0LrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:47:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E92127
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:47:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99454855de1so107717866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690458431; x=1691063231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gqSRYXyIiQxJrNLAqE8d2UZxktKUrnnw3/Y1qTE4og=;
        b=Xz7ibKY7UnAcjypV7aAgcV9oAS2BidIzlerD9Fro2fqZCVHnnBIyTSbS7Pdhfy2rrU
         2cLTNtZabSg5eRH78cKBg5luY5OsfVjOPtsno7fWxmyjp6Kghy5byuWms19dL7I1Gr6e
         H/zo2p3Jxjovdpl304/je5rJ7rfk/ZjQt0u5zpMJ95TOCkx86hfVYWiWSbhWJuKChfnR
         2QaQ1OFrB4khiZxIdNx10KZWfxpuEnCFWzPosCjyOIzDB+x2PInqx0PBu/I4Ry3eg5DA
         csJcIoPENrjhYnHDzN8j0DqDYsZs+M4lRkYWzebYa82mTMuWaeKa81MTy64A2iLvn6GF
         tQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458431; x=1691063231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gqSRYXyIiQxJrNLAqE8d2UZxktKUrnnw3/Y1qTE4og=;
        b=YiE/ddupnc6JcpGdLFazl8zufVaZuVJG5rIQkmks7pSA+VVq987PG78Mayzwm6jWnR
         FlE09q395oixabYQCMqOBCqvCfx3fwHoEIKTmWGBPWklqT6R27sLUiHCJtS9dnMADh/D
         dqiBhdlyDY01JxUkiTbI068O2AOslhZJ12aujtdVcgSvRH548AQxkzPDmBpe3PhoLPg1
         20qnRDCEEXE7UHLr0isImYIANkhZkDPzzo+sfEEH5yHpdhiWyDd2WbFd1ciuwR6aPeoE
         yDt+8LkRdok6ikdK8IqK7vRiizJ3bOWitAK8tFTfoHiG93nZiCUYcn9ULPBCN+zROAFK
         LYWw==
X-Gm-Message-State: ABy/qLbGcoiHndbBxAjrYIsyWs42CAqH84BNrrMA3YhUk2mkl5ClAT28
        otwQLS43mz7zr0ZpEvHMMRToag==
X-Google-Smtp-Source: APBJJlHc02BBYqqYKQubEhzgD06aEdh4kXzo48JCdj+2N3cMsM0ox7BZSV7xs9qUUHBQfaGEhn+9Ng==
X-Received: by 2002:a17:907:a04d:b0:993:f349:c98c with SMTP id gz13-20020a170907a04d00b00993f349c98cmr1502329ejc.4.1690458431574;
        Thu, 27 Jul 2023 04:47:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id pw3-20020a17090720a300b00987e2f84768sm696396ejb.0.2023.07.27.04.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:47:11 -0700 (PDT)
Message-ID: <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
Date:   Thu, 27 Jul 2023 13:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727113136.98037-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 13:31, Antoniu Miclaus wrote:
> Since the regulators are required in the driver implementation, make
> them required also in the bindings.
> 

The true reason should be whether the hardware requires them. Because if
hardware does not need some, the driver should be fixed.

Best regards,
Krzysztof

