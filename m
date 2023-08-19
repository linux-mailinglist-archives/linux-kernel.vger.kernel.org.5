Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A978182D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbjHSICK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjHSIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:01:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68F3C35
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:01:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso25912591fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692432113; x=1693036913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3tAtsLI5s7m9t2MiJZTTVjgQTSIULjZIhCpwhV7cIA=;
        b=XNHfAfYmCzvVRA8YoZrkhI7yXULzKeAGwu3fpaguHZWgbvPjej1avmavJvxX0Q5wOM
         gE+sZbSIHp4L9fgUdsSHLOeQoIYvzZXQv6CNczaRF+VYcv6UG/NrZ7zu0dgrHyTW02Qi
         TYCglKP6b8xz8lwC3KE8NB1mi7/QGHdbthwZYKE37w6Hsz/qFdlLSEsWa8W0Vs01L/LA
         rP9GCp+p1xOy2l+6wSUoMoYbCIZl0BJngpdDatoXtZSByobg0TDM05l8z61vt1B/I2aC
         bVTwKGZ8a3c1i6nMJo2m73jwc8JBlcqNaXYrblneTuTIf+lEfg2XGNDAOyzSx+s76Lu5
         IQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692432113; x=1693036913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3tAtsLI5s7m9t2MiJZTTVjgQTSIULjZIhCpwhV7cIA=;
        b=fV1ex/mbt0IpT2uVPJRbTZK2HroMvHddN86OZDFcf5D1+K94S8WyxGVg1oHKibYR3M
         /vAo4AWazg5mOR9SWIpbchAr5/ZdgdsGmGRIOL7fmW8U7bPieXuTN48EWEzSez6BcmJc
         Q4orQe9tsHEUnP39UsXZk+jDXVm3r7ffuxCyPnas9tWVbQeRrvHJQhHHQqeCr68TwZAX
         kbtFjfrAxw1RBL23fsWpNWyWzDAMBVk43GD42hScgJwgmm27OzSBgsFZekIwbbWrIV/x
         5g1Q26rbz5c0chuBtWo23pkpEukGe0L/HvQzJMgpNpiTU0qoOGx6U5RCh0y81lpQnCw+
         eJxw==
X-Gm-Message-State: AOJu0YwhJpm+plDI0Ba7TN/0F+n8Nv8WQy5pq3XtqhjClTnb8xdqgPZi
        lOfdmC484VnbGIcWH1MKXe6ObQ==
X-Google-Smtp-Source: AGHT+IEsr2eSWNVpGQ7n93iLTcHZOT5L/UgXbAMJ9cTee7SCL/mCY004HJsoEq4z92AdNcbqyPGMyw==
X-Received: by 2002:a05:6512:128c:b0:4ff:9aaa:6e3e with SMTP id u12-20020a056512128c00b004ff9aaa6e3emr1260440lfs.41.1692432113351;
        Sat, 19 Aug 2023 01:01:53 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id s11-20020a056402164b00b00528922bb53bsm1654511edx.76.2023.08.19.01.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 01:01:52 -0700 (PDT)
Message-ID: <952dd160-b913-1484-c682-b5ad0f1a3743@linaro.org>
Date:   Sat, 19 Aug 2023 10:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: pinctrl: Drop 'phandle' properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230819010946.916772-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819010946.916772-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 03:09, Rob Herring wrote:
> 'phandle' properties are implicitly supported on all nodes, so it
> shouldn't be listed in schemas.
> 
> dtschema had a bug where 'phandle' and other implicit properties weren't
> being added under 'additionalProperties' schemas. That was fixed in
> v2023.07 release.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

