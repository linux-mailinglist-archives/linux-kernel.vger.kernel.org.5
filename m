Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001517A1C97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjIOKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjIOKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:44:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55B195
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:43:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso2269677a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774633; x=1695379433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M7jImr0368A70YQQszh5LOxstTT1SILzvUBwptdLHc=;
        b=UJz6nrosxEJom9sB9Jsi2RbVICWlXgDOIHCu3ktFvcI8gVwaRlIyG8sTyRz5+Vt606
         JxXGE84U2lCtjHjvkQCzefnCuaf2RVe5isq4RWcOsUGwCkZHNKJXlM/FC8cRIrw+LVLJ
         Hb+rNzl4bCTr8WYX17V7sJPubfl4EwSE3hvsg6rA/XfmiTVABzaOs8V2dfGZ6SZBx1ed
         PakOerEL+2eKOMWmAPgwRh2j2bt6B2EnAVoIkYMpeJT599EYg/QBlu8dQjeDi+GdzsaW
         3iUOnZ/cpOxo9bC8sOrx0jnzJQSl9GnaIFXP7maYfT2I1Ium4ECARYkTpdGWDlDNzLmv
         Ku5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774633; x=1695379433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M7jImr0368A70YQQszh5LOxstTT1SILzvUBwptdLHc=;
        b=uyqOCU4ovvsBxd1mcS+isaHOvH3zuiUkFj8F3qWfZBFnyxSIimYubA+EkEkq3Ra+VY
         TIa7Viwe6X3hc0CbTGFNdO28VrjjotKCYSv6eRVpA7HRaecySUGIUlDoDtik77QXVhma
         yIhRNltgB4GbiLFmNWKCJ7z4GAyFdWWYuWF5S+LedbpyDOeUabg0bN8RG2pm5DUfEa39
         +Jam9z3XrrgoMBOvQWtp2c3yHcSMrtSSnIsnFSLgcb6bxWunwogdxmOoLUDcXjm5FmWo
         8x7Yr3/iA5r7fu6ajFdB3LLkUYQAI/QNCzM1VhIkgva8rAl2W4VEVYaynlhJGs1iIAMA
         fnHQ==
X-Gm-Message-State: AOJu0YwJ2FenSr8uu9ljm/Pcr4rji65VKlSiEvjN68Eq2NRvpdzCGe2O
        yYYvaKkcz+DgjEUzjHUBC2nJxA==
X-Google-Smtp-Source: AGHT+IHD5rk99z53pFttp4V9rDWOcHo0Y2Qnz1sa9CSaFR46gEwDitvybqOIt5Refxj1ZhWvIeY9rw==
X-Received: by 2002:a17:907:77c3:b0:9a9:fc14:abec with SMTP id kz3-20020a17090777c300b009a9fc14abecmr965415ejc.50.1694774632931;
        Fri, 15 Sep 2023 03:43:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b009a2235ed496sm2277713ejx.141.2023.09.15.03.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:43:52 -0700 (PDT)
Message-ID: <d7d718ab-09a6-ed17-34ac-8eb571260be4@linaro.org>
Date:   Fri, 15 Sep 2023 12:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 15/42] dt-bindings: watchdog: Add Cirrus EP93x
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-15-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-15-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add device tree bindings for the Cirrus Logic EP93xx watchdog block
> used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

