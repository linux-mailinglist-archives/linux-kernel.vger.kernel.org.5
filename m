Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D6771204
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjHEUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:11:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168F1BCA
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:11:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso49855971fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691266316; x=1691871116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2ABq7soEfcbzHdPT9arw7cMpjAK4IN+Eyp4A0dUI/U=;
        b=HoR/nLDavuW0gB2idqwPMUgM1t1WzAMxrioNKmwuSyRcrmKwW9PNfnSJwGv3nyJnx7
         eZszcQTK/CRPTEkZr9PmqrZbJYmLsk08GE+1nouEDvOUruwvRAqikZTZswkfiQ0t+DTg
         i0D2VAPVMTw+5v6ZPztCJfyg3BAErRDV530yziAZNgzh4K5kbdjUaofQyRJr6Z3+oExs
         yctGRioQ5pvXfPZrpJtzeR2zxSdmhf6EOVvA3qcFSFsBpqyB5kWAacXpLYaKT+TwUPbv
         il8WIxY8pWIHaBxkQYq9l3XbS9myQd0eqJMUYheP72XHlDLUElHAJLrOhzFBBdZ39Aeg
         fjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691266316; x=1691871116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2ABq7soEfcbzHdPT9arw7cMpjAK4IN+Eyp4A0dUI/U=;
        b=Ujtiy4rTZ2W4nToz8ak40+QzkkeW9S8OLYhxO0jnxs1io5OWvc+7whE/VjeArwToja
         2sR2N7TQCAPztsTJhArXV09i9LnkPOodw/IE/0Xk2v5+9NLwgpUS4vRr3xINeGf+eUS4
         ZOsDEMTHPHCK/p/1Sri3zzgVqde/GX4KorXvbDfFPWqt3PGmwgQTTfaBW8Z+LpPwpBSH
         XVAYX6BmBFCMOIyelYnFMWXhsX1oG1k4kgTOsB+qKI1q+ghxRHRYcKQDheFwsGn6E6Co
         +VhLcAAXetVyjJtEKXlVmRBr/a+OTnXlP/cK4x1fd9Xwh9MueYnP7hjj0TiNeN7rNKls
         M3xA==
X-Gm-Message-State: AOJu0Yz60TEFgxexWU28P0OixVnXIQxPkKx7ZfLflhRwc+s9V8I8AtKZ
        qHStUnkserSJyZrsu2pSLjXq4Q==
X-Google-Smtp-Source: AGHT+IGZBQamrq2g/vboZDdDwmt/aYwpvvbRQcmvT4wHhuH2EcX3D/i/qjrkbMJp+e/RZiMFgnA+LA==
X-Received: by 2002:a2e:7c15:0:b0:2b9:aa4d:3719 with SMTP id x21-20020a2e7c15000000b002b9aa4d3719mr4280750ljc.12.1691266315928;
        Sat, 05 Aug 2023 13:11:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b0099bc5e5742asm3082024ejg.70.2023.08.05.13.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 13:11:55 -0700 (PDT)
Message-ID: <3f3f7d1b-d850-7d93-6f92-f16797f5b081@linaro.org>
Date:   Sat, 5 Aug 2023 22:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add Xiaomi Mi 11 Ultra
Content-Language: en-US
To:     wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-2-0c384e8b5737@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230806-xiaomi-star-v1-2-0c384e8b5737@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 19:03, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add a compatible for Xiaomi Mi 11 Ultra (xiaomi,star).
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

