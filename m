Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8B784A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjHVThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjHVThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:37:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD31B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:37:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so1106112a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692733034; x=1693337834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaXLuaQsLsLn1fI/Z5qiRRQya9b8DYm/ma/PDKi8BUA=;
        b=waXr5YRjxLCJ4DuKTagGAPB8uYsMyWMtAkZ0dOWMgVTpoIL/D8gyCURlAwzCU0xtqR
         LkwKf7YZDPV1I/AvYLLWpSDWK+M0d0KSIRG9Wdy6Y4ZGnF2fRAiSz2NgQLw4T+9x0Po6
         lbOfvQhDm4EyMQqhZt8So5FEzl2r8kjN+Q8YmK2aa3lU60nfPSRBYf6KDr0TTjNrz7Dp
         WBGwpRK6mPl9kxJIziQDVq9S5Rzj6XGUIlYm8sWl9XCBJiI/147GMNrf7MvGj8Zs4nGS
         dz9C7n9XGWE7o/8hNJiWJg3FNswb7tvu5LoHAjUyYIRb4bfThtQIa5NljtMGvbeiK3NJ
         m1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733034; x=1693337834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaXLuaQsLsLn1fI/Z5qiRRQya9b8DYm/ma/PDKi8BUA=;
        b=kuq/nEHrncfM03f3JGGX97uUy0CWaF4pIKuFJ0eTOcMWsEvSL20Ug2JnXF04wSCK7M
         mZwoqcmuSALNbRUlAQSsidqRwngrqzUO+u78quGVcUfJOFWVAUuEOdtna8eF0kaNlldZ
         ocX1k9/L9nXEEKZdoAYCcz8ZyNFWL/+hDLB/IXnKTnetP1AfR5mrn4UsNMCE8nL6wauV
         qgl8DPHkwY7/R3Rzht7fPR4TP2MIeQvE6Cd3cUxqMaWTWR2NeKuUZCJxPw/Pta6BtP5L
         hEnFHoPJeBI12AgN1BNOEgWRGowd/sCxFUpygZdAH0hMPAchBLL+LD9HIX2KMeBmPPqu
         xzTw==
X-Gm-Message-State: AOJu0Yyimvb0BnIjUWKEa1IJwz49O0wvR7mj/POyjbMZUrgUQXAHgXmI
        NU5i7m8iHqCIRfgNrexyhEpNNA==
X-Google-Smtp-Source: AGHT+IHVRDr/DoYKAhd5b7mN6cX8JmGPhZhnUhp3v75kVNz5lbWCQBjSJ5EaHTl3ael1rocmrA1+iQ==
X-Received: by 2002:aa7:da18:0:b0:523:1901:d19c with SMTP id r24-20020aa7da18000000b005231901d19cmr8652948eds.24.1692733033996;
        Tue, 22 Aug 2023 12:37:13 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c15-20020a056402100f00b0052545dbfdbasm8043271edu.48.2023.08.22.12.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:37:13 -0700 (PDT)
Message-ID: <7fc1f405-a026-deff-18bd-308dae393542@linaro.org>
Date:   Tue, 22 Aug 2023 21:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/11] mfd: mt6358: Add registers for MT6366 specific
 regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-3-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822084520.564937-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:45, Chen-Yu Tsai wrote:
> The MT6366 PMIC, compared to the MT6358, does away with the VCAM*
> regulators. Two regulators VM18 and VMDDR reuse their register space.
> There's also a VSRAM type regulator VSRAM_CORE thats' split between
> the VCAM* register space and other parts.
> 
> Add register address macros for these MT6366 specific regulators.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  include/linux/mfd/mt6358/registers.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Adding few defines without any code using it barely fits one logical
change. It's just not a change, even if AMD tells you otherwise with
their autogenerated headers. I think this should be squashed with its user.

Best regards,
Krzysztof

