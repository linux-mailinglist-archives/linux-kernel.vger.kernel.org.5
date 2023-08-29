Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C178CB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjH2RXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbjH2RXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:23:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78164CF4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:23:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso988119866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693329705; x=1693934505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONMdNT0qe15nFMdXWcs/Q8c5HCoTBwiBJLGrnRV1nw0=;
        b=Gwbtl59Ozws7A43XKoko9bI1D1pTZ3OnbnsOGDkgIRUyySm4oZWSvHs36ncqLnqGbU
         4FGsoze/LmTh+1TAzllaMearohpyBGQpCJQotGWsOL3NwlhVlNJNbJ5N9SmcV2um53Mi
         tolvCX7EzDAMX6Svp4+rag+l/DHBPPPNGshq9QN0Nre+FRIj/UJ2klIr2S3XizBdwlw3
         U4paYwxH7i8W78bsQw52vga5T0AWeMX5Dyfoaaa2Qz98lwMQDHiK9iqxclKV+grXT4wV
         ps2FSfBWz1O38Q6TWZlW+cMNacZ+t94spYnip1dSlz0NUFmoaLwFF6nTIDnb5rljLBWS
         kGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329705; x=1693934505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONMdNT0qe15nFMdXWcs/Q8c5HCoTBwiBJLGrnRV1nw0=;
        b=cmaRbWN/BEvXpaWxobobkJq5MPdNcek3wcnujghObbyb0E2o23mGnqAGa+u+U4udJf
         bUtM9Z2vmGGuMw5Lrx0haV1HgtYmzLd8OdD+vwZCBKWxLzbyE/KMGHmy14L+fcKtpxJL
         CDpDj/KwjDQGr6zw0OKjqNcbPlTJJdLuM68WiqRX4R1D97KgGJ5W+oikxnfqDNwfwJvr
         Jb+v/k4DyACVvKLJ7Zp9rfPTiyiAYmOH2aCGgdBAkbajITgw/bdKdTb0TUTHAEEgQp27
         NnJHHIo/jOHOMTDRVpQvcAX+O7VRpMzZ5+EwvnnfUCsP3bE7Hsa6UtNwiqI25PQ6cFNC
         895g==
X-Gm-Message-State: AOJu0YwWjNsaKxfkZUUmqWmKQLLKjNxD7rMsMY8MnZUr66PErwBKQxUP
        czylhXgKj14sBqfGfay0m9l9qg==
X-Google-Smtp-Source: AGHT+IEC28zmPiIgJmKgcQJmlnUeRmPValFdXqSMVRYqh4YR7AT6QaS02hhHQPZGW4brxIj/NspEyA==
X-Received: by 2002:a17:907:1614:b0:9a5:c2c0:1d0f with SMTP id hb20-20020a170907161400b009a5c2c01d0fmr3407559ejc.12.1693329704763;
        Tue, 29 Aug 2023 10:21:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0097073f1ed84sm6161481ejw.4.2023.08.29.10.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:21:44 -0700 (PDT)
Message-ID: <ea386a28-841d-0e76-cb1b-735b630001ba@linaro.org>
Date:   Tue, 29 Aug 2023 19:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 03/31] dt-bindings: ASoC: rockchip: Add compatible for
 RK3128 spdif
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-4-knaerzche@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829171647.187787-4-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 19:16, Alex Bee wrote:
> Add compatible for RK3128's S/PDIF.
> 

Subject: ASoC: dt-bindings: rockchip,spdif:

> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof

