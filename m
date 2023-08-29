Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF078CC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjH2Sgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbjH2Sgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:36:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8CCD9;
        Tue, 29 Aug 2023 11:36:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007616b756so7584954e87.3;
        Tue, 29 Aug 2023 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693334187; x=1693938987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7WlyYzqen5MI4P1iAbKBmvgwbKop0nGPA7AULKnw6o=;
        b=M7jKN5n3mbxOj6lToXlIBhPfrGvC6yd0H/btRqbTG5GN77QQEHXEnWUgB/u9h37HEM
         aQ3Yh0h+zDVLmyJK1+FIDzgTteH8rmbZviHp/ff61hTQgrTcyy0nUiodskPcy/wcBh5n
         NIuaedyS4vgw2lhchhMUJW5L3lUOqkq8ajWK5jlq3m2SAdam1bwzA4e90x5TL4aZpkSM
         YWobFR2JHrACTFmlppIlFi7ZjN29jj0Mal8JFRUSPqudgAs54EYml17nc/0bF0TlJu6K
         124Lf8rCO4uKn9XVkhJWCryQagTVCb81ZFN8UFsc7Vzw1IrjJXssjEykqsPrreIM0fBF
         8CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334187; x=1693938987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7WlyYzqen5MI4P1iAbKBmvgwbKop0nGPA7AULKnw6o=;
        b=TpBXUAm6W10bFjIyBTWNd3Wg9Cgb0BhS65WOVB433Epm59dWVJxKuMgh13FQ4ykg3+
         lprOU7Y2oFJF3ZvaTwMI8xAKq21CfkpoqKhWgcFKL/k4oCn/SIY7CPDGK9fS5Cf7jMM9
         IKwWqLgNOihk7f1VwC2Ukz3K6YtMTB+xg6Nb1f06HiuIbjGt+4kmH6GsjGrvGAhdO2Cu
         qcEyBBe8Lp/wOckL/TRg7pKYO961qGttiww78cWYhxiO/b30H7eVC0OxMkrwkhLCoK9M
         k5e0gyoUgss/qGGbNOYz6XGYude77gWHm77lYyARmf9r2cGgoyXCUXjK8LNrUb+HTbB+
         1wXg==
X-Gm-Message-State: AOJu0Yy1EcFvx6p3Q+Qr3u5F5mC2H3Gg4cFjXWNus7pZZV+O0BtrAnUy
        I5eFaGtEMiy6aqqpuufcUA==
X-Google-Smtp-Source: AGHT+IEjZeDr07xYkGFW1xI0KR3jmlLbN0sEkoa4/s1YsvQ7klaZ7CTwLESdDc6wxza92JGAV/2Zkg==
X-Received: by 2002:a05:6512:282c:b0:4ff:8f29:4411 with SMTP id cf44-20020a056512282c00b004ff8f294411mr23976106lfb.9.1693334186618;
        Tue, 29 Aug 2023 11:36:26 -0700 (PDT)
Received: from ?IPV6:2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8? ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00525683f9b2fsm5961948edu.5.2023.08.29.11.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:36:25 -0700 (PDT)
Message-ID: <9954d57c-d864-0215-2efc-67440ce86563@gmail.com>
Date:   Tue, 29 Aug 2023 20:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/31] clk: rockchip: rk3128: Fix aclk_peri_src parent
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Lee Jones <lee@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-6-knaerzche@gmail.com>
 <dc2f32d3-001c-746f-6dc5-58a2a6a4a8e6@linaro.org>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <dc2f32d3-001c-746f-6dc5-58a2a6a4a8e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

thanks for your quick feedback.

You're right: This series mixes up too many things. I'll split up and 
re-send.

(And fix my typos, indeed)

Best Regards,

Alex

Am 29.08.23 um 19:40 schrieb Krzysztof Kozlowski:
> On 29/08/2023 19:16, Alex Bee wrote:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> According to the TRM there are no specific cpll_peri, gpll_div2_peri or
>> gpll_div3_peri gates, but a single clk_peri_src gate and the peri mux
>> directly connects to the plls respectivly the pll divider clocks.
>> Fix this by creating a single gated composite.
>>
>> Also rename all occurrences of "aclk_peri_src*" to clk_peri_src, since it
>> is the parent for both peri aclks and hclks and that also matches the
>> naming in the TRM.
>>
>> Fixes: f6022e88faca ("clk: rockchip: add clock controller for rk3128")
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> [renamed aclk_peri_src -> clk_peri_src and added commit message]
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Please send fixes as separate patchset. Don't mix it with other work and
> definitely it should not be in the middle of the patchset.
>
> Best regards,
> Krzysztof
>
