Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C57847B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjHVQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjHVQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:33:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DFCE52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:33:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so7132496e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692722001; x=1693326801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xSrhz5Us97Qf9+7A783D7YhpLpwN4x1lqakquu3VGg=;
        b=tiEBp3JL4YsbBo0QBtgI3BmQCPsYGmzCdpu19U5Nd41sv+ssgGLIFtY5a1xz0xtsP/
         BKPV24/E5/rZr1hm9Q31b6qODcKiXkchKBWAx4wxEzP+sIwra+poInZczv74sJUEnrvW
         suDXeUnVmclfMTBeErpwG3IQKd89egEpnhRv8CuJBKLaiW+YaczEgROWpPB8YPuczdGt
         Cd1gB5TRwa48+WR33V341n6aJiGfIUhWkWOCEHwSlblbZkDmMzV4ork+r5tBySfvhwbY
         kKuuBtulfExcTuvOKdTUoQgBewgcUPZUDiJ9ofZhY0gNyPk+XIYeRlet7T3VAfOD3z35
         X/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722001; x=1693326801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xSrhz5Us97Qf9+7A783D7YhpLpwN4x1lqakquu3VGg=;
        b=R+NlTt910v8Z6xqKleoACAbZXr0kXyoOXI4D01Q8L40yTBV/GWVfqhnPElKsD/dufI
         sX7pfjNK4OJTaeI0JpimIOfdoaMw+2ZyDTAhuBnyLAepLocPxdV10tQPSxcgrQ7Gc2Kp
         CTdJd+KyEqHndEINfqNoI6SSSLW3kriBVcIITDGLWfAf+s49T26BspwhnKAO/D6dE4GU
         fj6XMiDaj8ZPgJSyYShtEEoByL2+1qtYlC7h0dRzdJLL3QoVhYJLUsBi1oqot50Ah5OI
         hOlPtGFRsHpG41wIo6vDhvh1n5NJ8YDezeJ7vrGngfQ1UZuPmO0k0S/XHc/Zi6Qaioo6
         go1g==
X-Gm-Message-State: AOJu0Yw1BClwM5JniuUrQXiKc+K2sZUSf53Asu3aG5uD0hjOccr389Qh
        jAyrnRef12uTui1TySrGQKPrtg==
X-Google-Smtp-Source: AGHT+IFS5+pN89cVqDrLU2XMxBLLm1IgGNr/2RbOgFBpign6kDrEGDdwUp0uhR5vmCE6wdyEgQI7Kw==
X-Received: by 2002:a05:6512:1584:b0:4f8:711b:18b0 with SMTP id bp4-20020a056512158400b004f8711b18b0mr8883753lfb.3.1692722000583;
        Tue, 22 Aug 2023 09:33:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7d291000000b0050488d1d376sm7750157edq.0.2023.08.22.09.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 09:33:20 -0700 (PDT)
Message-ID: <1c812715-731e-18fe-e431-311f18af1bb5@linaro.org>
Date:   Tue, 22 Aug 2023 18:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V10 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-3-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822082750.27633-3-yu.tu@amlogic.com>
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

On 22/08/2023 10:27, Yu Tu wrote:
> Add the S4 peripherals clock controller dt-bindings in the S4 SoC
> family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---

As well ignored email from v8 and v7 and earlier versions.

Best regards,
Krzysztof

