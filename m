Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F978CB73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjH2RlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjH2Rky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:40:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4801AC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:40:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c136ee106so610171366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693330850; x=1693935650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YNG7LD4K4KMxQp5UZSaL2MeLl8EFjm+UQ/TTjynihU=;
        b=KmEE7T5sialkQHA7uBm2PpWGs/ZGGqTq02s3Yw33ntN7nH7hF0rgTi6bhJcVRe0gUe
         n+7sXgY6R0X4sM3t9RrhSbtnj1wj7FIQhMmE+9XbqiOINprzleLlQnHZZBesnITHn/JB
         pvbJMvr+iOoS1qtKvP5amQio1ol8/VZSIUFHmJha+u/9YBBRjtawNb1iBqmCZTAI9U+6
         /EGo39TLk1NruxXYkr9na91s/mrhZkDa+aQcVrmEyH+0M/gX2m6YCGUWPJwRwuTNSud8
         Bh8WoteBLNLZbk9XMXJiCy0flgPIvNhFeKY9LCrheun1P9+mVwI9w0rCyGS3G9dzmVcQ
         dW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693330850; x=1693935650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YNG7LD4K4KMxQp5UZSaL2MeLl8EFjm+UQ/TTjynihU=;
        b=Mz6XKxYn2X63402Z4jRKFe8jP0wFUXns3So9VG79V9DhtddqcfEW5N0/e7pblkkGpa
         QCk98R5Mc8OH6elNK+wpxBbhR6S9VPVvatiknsl3QYqVEyWs4MTjYMrAUYy+QBKZ+O3D
         P/fHQN7DuaV2uDQstybQcTVtwF5Ic0ilBYkH+oVOQVPJtPiiX3e8PWYaAGavBUJWjC5H
         wKy6XnQx8TEVA2KF78ZVkNe48ViXQx9Tp9n3ifxBAqsf4HpMbdH7LL70bMLY3JLO5D+E
         csk4h1ID0n+AL/TFyZd0IWt1xo3UZGuDBf6bv7jiaMVu9uklCE5RVnd+ylV7q1uKzPX5
         AFPw==
X-Gm-Message-State: AOJu0YwuPZRgRWfPOtJXse56oZHYvoAapQ12+KZcL1zKwwBOktOJ3RUl
        0JcCkDKWvZYQNJPC+fhk8RowUQ==
X-Google-Smtp-Source: AGHT+IEitwmwVk9+KoKIBEHpiME/Abb3aHzRC9tehqbQ93vUndcYPbpMcUZcdG971B60lRyMIL5+mA==
X-Received: by 2002:a17:906:256:b0:9a1:cccb:5429 with SMTP id 22-20020a170906025600b009a1cccb5429mr17132480ejl.15.1693330849791;
        Tue, 29 Aug 2023 10:40:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090624d100b0099cb0a7098dsm6285502ejb.19.2023.08.29.10.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:40:49 -0700 (PDT)
Message-ID: <dc2f32d3-001c-746f-6dc5-58a2a6a4a8e6@linaro.org>
Date:   Tue, 29 Aug 2023 19:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 05/31] clk: rockchip: rk3128: Fix aclk_peri_src parent
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
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Finley Xiao <finley.xiao@rock-chips.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-6-knaerzche@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829171647.187787-6-knaerzche@gmail.com>
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
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> According to the TRM there are no specific cpll_peri, gpll_div2_peri or
> gpll_div3_peri gates, but a single clk_peri_src gate and the peri mux
> directly connects to the plls respectivly the pll divider clocks.
> Fix this by creating a single gated composite.
> 
> Also rename all occurrences of "aclk_peri_src*" to clk_peri_src, since it
> is the parent for both peri aclks and hclks and that also matches the
> naming in the TRM.
> 
> Fixes: f6022e88faca ("clk: rockchip: add clock controller for rk3128")
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [renamed aclk_peri_src -> clk_peri_src and added commit message]
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Please send fixes as separate patchset. Don't mix it with other work and
definitely it should not be in the middle of the patchset.

Best regards,
Krzysztof

