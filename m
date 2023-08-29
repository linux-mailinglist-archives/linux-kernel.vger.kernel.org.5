Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8922178CB63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjH2RgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjH2RgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:36:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD111B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:35:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so629479266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693330534; x=1693935334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tJx1LZA2LjgFtn73CfwP5M/IqTnK+MwGx8w31m75yU=;
        b=Da/IkmIK0JYUxFKjSEblVY+mXHIgArGHnKXd1PdkWfrrNl3vmvqsuHhOpmi75l8HOZ
         r5bqLihmTGzQfWbYyIPTfZ4HZv8V5wGw5tpJ5L+d7GF/lI3ZbBgWHw3t919cHC70b78M
         uKhylQ1QyYvaQ4bGKIu7GBQCYmitcl9ALibpvikrDxqytoM8uHZWTgQ5FNEVZBhMEoxN
         nyy6IRVD1OX3V062KZ7hJLyM67CMUViq3vhVi5qalF3II+kDxnlzdxrNpGs+1pfhdP5Y
         Nj78XsJkLIjOogPn70oVPiEWAp52zoMFyRnbFWOygh9ECYyw0zYFIGaYC7383BQY3qi6
         FXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693330534; x=1693935334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tJx1LZA2LjgFtn73CfwP5M/IqTnK+MwGx8w31m75yU=;
        b=kW4eC73fQdv6Td8JuoKlFeglWsI0Ya4n5yXIsLRkwWcwCKSTflYCZ6MSidOls/8/YI
         K6bpTptEMiMwoNk17M2dqC/ivAPn53wtp2Y/0f6gYdSG02EpYmo6WAud+Iyl9lLbH7qu
         b+KMlVwAu1YRUHHlhf10MwBKZy2hsN8df16rLMN1QnpjfjmrXecq+EVl6iqVQZ9u1Uxs
         zpB67lBdfXQhGbykpq1ujO7p/fXdX5PKk2BJ/b8GaPe5oVuvRaluqbQB8bm8M4c+vkkZ
         KlOL3PhNzYMse9ANGSHSD6tdEOw5emlpqYNDvQrXQkfPGFTOZyhEwiRbYRaFr3QxrphO
         HyeQ==
X-Gm-Message-State: AOJu0YzHomDbo4OSI8TflgMYIMEtRWN/WkoQbbeBqN89NcD46Zdfn9b/
        fOXUoYELGqk10Lb+iGpphOHRK9guChjtTF51dxE=
X-Google-Smtp-Source: AGHT+IEkfyuO10UaoAlJW/IYUjOxaNUiUgX99OtB+CD8vi2Z/YeQChXUrbKkNwIR57XqpbHKCgrV0w==
X-Received: by 2002:a17:906:51d6:b0:9a1:d087:e0bf with SMTP id v22-20020a17090651d600b009a1d087e0bfmr15768869ejk.43.1693329730572;
        Tue, 29 Aug 2023 10:22:10 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090606d800b0099364d9f0e2sm6189666ejb.98.2023.08.29.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:22:10 -0700 (PDT)
Message-ID: <92b8261b-420e-d96a-ba77-9abe7d53b427@linaro.org>
Date:   Tue, 29 Aug 2023 19:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/31] dt-bindings: arm: rockchip: Add Geniatech XPI-3128
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
 <20230829171647.187787-5-knaerzche@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829171647.187787-5-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 19:16, Alex Bee wrote:
> Add Geniatech XPI-3128, a RK3128 based single board computer.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

