Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD977D41E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbjHOUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjHOUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:31:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B71BF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:31:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c8so42836755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692131467; x=1692736267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPkucb8eDhS4EQOsVKiEyG5iEoUjpanM1Rn3+s2iurY=;
        b=Z6DUqHW+sMPrT0LeS6Km/PZyRkUqlEgFHgN9K6DozAppi0f2cnLhUJIpEBu3nx7qBb
         A2Mukl7Bz4fGiDSSi5gBqMjvmA2CjiXx7gwzR3YusogaRZGCn3UfYvXGN5y7dFa5CT+w
         6HliZlx8cmZERFRf+JvGQwPERDErcgopPDGjLtTh/FChO9NmKNd6ijpcD6jacEHq98nw
         gsT9DvDfXZPLM/GTbKdBThQxNOX+zSIpQ2995qlLu6oAe9ZecD34OXTKiHzwO9RbOyog
         S2hef2Mw+h6E3fYoloOre0IlVCYqZG/nfYaJ/o7OQdRZ9e3dq0y9sIaLSTodqGD4KfYX
         kt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131467; x=1692736267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPkucb8eDhS4EQOsVKiEyG5iEoUjpanM1Rn3+s2iurY=;
        b=L9N3Niw/Xn/00J5WU99tBkIXU8Ok81EjeHRm4XHA7nTrd6oovnQ4vEVqfD0CmfDirI
         MDMvxtMDS2OBqtAvwDqIOIMYpI2yTfvxzyqRyMSH71jTW+qH1EcKFqiRuRxV0HQ/Z7/5
         TbCL8unEuZj525u7C9LvTmCFJ20jHjmxtOhuqxhctxZqkVRh3VpOBchXG5ld3RAdwwQA
         qNULgpKzbm4SyOIb/Sqnf889p8xB6UPw9Tp7zfqdE/MYD6xIzeUbTcoCao/Liha7XtEY
         gMXPEOhaxHdS0h0PNKjsXEoK9RHEw6QeHWVtXFl3LPJ7Innm+rmg9koegJZWbF7U80Ev
         5YYQ==
X-Gm-Message-State: AOJu0YwvWI1MwjrJ5rY/vqyAm3chws7KHfvP7zXWWCYK/jaWJiQ1NOg1
        IsaRVaalnGBHMs9apqK5erBXIQ==
X-Google-Smtp-Source: AGHT+IHoUjJZshomlKAVo+zZzSVfwj2oWSovdFIH5SwrSkWxE+CGl4DjaPILVirJDXOOyjhzKYQV6w==
X-Received: by 2002:a05:600c:2058:b0:3fe:ba7:f1ed with SMTP id p24-20020a05600c205800b003fe0ba7f1edmr10668870wmg.25.1692131466760;
        Tue, 15 Aug 2023 13:31:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003fbb346279dsm18971048wmr.38.2023.08.15.13.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:31:06 -0700 (PDT)
Message-ID: <ced3e7fd-dca2-0ea7-8847-54c3efbe3165@linaro.org>
Date:   Tue, 15 Aug 2023 22:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: leds: aw2013: Document interrupt
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
 <20230815-aw2013-vio-v3-1-2505296b0856@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815-aw2013-vio-v3-1-2505296b0856@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 19:21, Stephan Gerhold wrote:
> AW2013 has an optional interrupt pin "INTN" which is used to report
> completion of started operations (e.g. power up or LED breath effects).
> The driver does not use it (yet) but it should be described for
> completeness inside the DT schema.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

