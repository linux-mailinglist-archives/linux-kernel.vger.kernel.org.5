Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43E7D4BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJXJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:21:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF61EC2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:21:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f61322fso33413305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698139303; x=1698744103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHLz8PPjT5hmB2yN6aVrR9CV+tu/9PbMfn39Dru7aRI=;
        b=oH2tmN+uFbi4r5EtEV87Eap4fiKhWjYbRAF7+0kFVPe/cUeb2GtJIZg0Crx/2PFHbN
         i6LWRpAATzjIkw2Se1FPiaG7ioGTCnWPGxCMCiHRB1hGBeWXUhFOx8nsUDdfgugubr07
         2EcjCDX3z469k6OQMJcEQJPPSLvwrzJxYNG8ZiZpy9DCTgO3O9usaWhLyhTr9vuOKZcs
         2ssB5MFqo4JiKn4nkGhJnGzfqSuNbajnPIIM+A4ZSbbS8l2N/YafJzYZJKPImcQIMFAA
         sPvxWhdb7w+3RV5YtaCinuasqTvvNWFi6qnBz6K8GDZJAC6QIjyGoVngTemWZEJwverC
         hx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139303; x=1698744103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHLz8PPjT5hmB2yN6aVrR9CV+tu/9PbMfn39Dru7aRI=;
        b=gW4bfm1zMopEDD9bzUj9fV8BBz02k/PqiLL1YkufIWnAQbCElfMvANkmFmH3lk5ove
         A4TcpRPpwv2qv+LUqFWX6RkZOgHBa1oqNsMQuBhXWjU9+Qs/7wOlFjNIjXPIHqgcKF4/
         eN0AUOYzjC0a4koqSUc4YByQdFyK9Uw3A4mEHhJyBgoSjszkLkgN2Dlz9gnhqKclKWPc
         YCNTwDeEn0XMoOY6oJKlbTbrAJcQyomf/Cw8QV6AyTX3zdYEui6QlCAqG5Xrqoxud/99
         IeiUzUjO8FijetnvXjeXY1LCzASUIQR4t/SP0ze6a408hOqHvHNgeVqIrQ/JyZu95UBK
         WaXw==
X-Gm-Message-State: AOJu0YyDB0U2mylU30B50gIf6tYCRiRJlUnLiTRR5IDJ3ATVCXh8kcqZ
        bfEbUxHPqYiuDOLXvL6V85FEUw==
X-Google-Smtp-Source: AGHT+IGmTE7S8Bn22t6axk51MnY+srHjcF3lXhxJM8aBvQIoNaSPW1U6i8mvZVzOD+mypNBfwpseVw==
X-Received: by 2002:a05:600c:3b99:b0:407:5ad0:ab5b with SMTP id n25-20020a05600c3b9900b004075ad0ab5bmr9181918wms.8.1698139303217;
        Tue, 24 Oct 2023 02:21:43 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040836519dd9sm11523045wmo.25.2023.10.24.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:21:42 -0700 (PDT)
Message-ID: <ec7c16ef-5878-488c-af7e-10138783f726@baylibre.com>
Date:   Tue, 24 Oct 2023 11:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] dt-bindings: pwm: add power-domains property
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-11-5c860ed5c33b@baylibre.com>
 <20231023-oppose-tamper-36d526ece102@spud>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231023-oppose-tamper-36d526ece102@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor

On 23/10/2023 19:38, Conor Dooley wrote:
> Yo,
> 
> On Mon, Oct 23, 2023 at 04:40:11PM +0200, Alexandre Mergnat wrote:
>> According to the Mediatek datasheet, the display PWM block has a power
>> domain.
> 
> Datasheet for which soc? The mt8173? Is it valid for all devices in this
> binding?

I can't verify for other SoC. Then, I fix the commit message
and remove the example changes.

> 
> Cheers,
> Conor.
> 
>>

..snip..

>> -- 
>> 2.25.1
>>

-- 
Regards,
Alexandre
