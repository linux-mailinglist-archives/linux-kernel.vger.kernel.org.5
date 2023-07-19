Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82A759C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGSRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGSRKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:10:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1181BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:10:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f943383eso108206541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689786643; x=1692378643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9fgt2KGcRUVdeDNFEB9QhU3B6RPAni2b92fxJRERKI=;
        b=m0odFjE/t7Carm6qsKat9e6zZDr8tYvaRgRy2/qHKfwYwKm1AvHRlknqHd/u7GwZxI
         3ey46dEGwU4FY9K2iy0cklzhtq5bTwH14i7a3qjPzE47bWff0v38f/AfPPy5dhin1hBg
         eSARqihMXjiC1EBgosuzxmOqrDHTAAuXBiR7O4m3JRucAHuz5cE/MQshpQeeXgNr5uY2
         D6iU+8ejr5Cr31sIwCyuKwpHQC6lExfEMcVshRHYkSNrPVdXjs2K/5Z9slMw+YUxqgIc
         Ha1meyFn1RsT43yAMeh8KgQw5KmFQ8jK14vS02YMPw2AVvvL4l3exGwuVVs/622OLNO2
         XJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786643; x=1692378643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9fgt2KGcRUVdeDNFEB9QhU3B6RPAni2b92fxJRERKI=;
        b=f8lNSm7nBFvscLZV9EfSSM+HwkX66leUpPvVElmJNm0zvja5g9JC/vMVcTsJEzlaNW
         nBYj/z3MLJ7uFJmAhQaOPVWsSZjWf128vBszLOWy38nQWHNpf5eBWpAnMSLZBFphjJeT
         vNt4dLjm4dCoou7J2ZD0OZrpQEvQt+7Gh+niJygFiwWgalWA6r8P1kVjLFlX4Pd211nt
         e0W5+jZ8i2Y84+crnotOz93bRPDm3lX1n4/+2F9fy26CM57x1JuUote/0hObbNtLkatP
         /XZ2JzaySSFxW/PCQYCMbTRDyr645ArRlesIX4cPuH2UunMV8Hb1arq8URJww8Kk9rO8
         I9Ig==
X-Gm-Message-State: ABy/qLaXGYm7EuVzLoxnKqsLvG7OxWMe5SdDfCmeT+zqY68/3eRby7E9
        0HTqyCmXIMvNxq87rTaLklGS3g==
X-Google-Smtp-Source: APBJJlHT3RjczWqeN0o1AVJznQrcW55dSevRN/ebSN67gRx9wtPP9BGZUIn6GNvldWh6cg1TX2YZWA==
X-Received: by 2002:a2e:984d:0:b0:2b7:2f2:231d with SMTP id e13-20020a2e984d000000b002b702f2231dmr410408ljj.27.1689786643328;
        Wed, 19 Jul 2023 10:10:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c378100b003fbd9e390e1sm2083821wmr.47.2023.07.19.10.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:10:42 -0700 (PDT)
Message-ID: <53e7df75-afdd-9bb0-aa45-f39d0756b139@linaro.org>
Date:   Wed, 19 Jul 2023 19:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: add bindings for pcd8544 displays
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719154450.620410-1-viteosen@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719154450.620410-1-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 17:44, Viktar Simanenka wrote:
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>

You still miss commit msg.

> 
> V2: deleted oneOf property from compatible
> changed prefix from 'philips' to existing vendor prefix 'nxp'
> placed `reg = <0>` right after `compatible`

That's not where the changelog is put. Please read again the patch, I
gave you link to.

> 
> About parameters exposed for controller:
> inverted - I had an unbranded display that after reset had all pixels black,
> while register was in 'normal operation'. The display I have now is opposite:
> all white after reset in normal mode. This parameter should help user keep
> same settings in KMS(?) for diverse displays;

OK, it was enough to respond to my comment.

> voltage-op & temperature-coeff - adjusts contrast for display. voltage-op
> cannot be expressed in real units, because resulting equation looks like
> V = a + Vop * b, where a and b varies with ambient temperature. Vop is a
> coefficient. same story for temperature-coeff - it shifts resulting voltage
> curve depending on display usage invironment;
> bias - relates to waveforms for LCD segments. default is 4 and should be
> changed only if you use external oscillator for display.

Most of this could be in property description, not here.

Best regards,
Krzysztof

