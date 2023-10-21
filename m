Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD57D1EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjJURev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJURet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:34:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64797119
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:34:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d569e73acso1356041f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697909683; x=1698514483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAD8koNag2d2JiuZzDEdme1uco389oMcfmj0tVw3ir0=;
        b=YalzfpQGXQ6NOgnlTaIEwX1Dc12UFy6oBKITgvJ5jET9H9W+K+PlYjIhhFI3BOT3JT
         C7jBJV6SyQOR/5+Fq98faQXj7og1xxv8jEqjCJNoQy0Nlq+7Ilwc5KYs1e3eHyvUMY+H
         KpTiqcqPlZHHgAK2UInrlKlRWQku3YrFHvVENDTOO4klmJ9+GoD5WnNjQ2pXpQ4N4rsR
         1HPjEHUXZWxEjGg/WvVyMy4M6Ej5kjuHJIIIKmvkjXbRme9Mv+I4tLwrjEHjbgMZM73L
         kLW6xZFNSBdi/xoZ6s4+os6E2VM+k9DSFDt7BFVNmFlvK/ZRDLO2VyXLjhtJW+pin/dA
         REpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697909683; x=1698514483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAD8koNag2d2JiuZzDEdme1uco389oMcfmj0tVw3ir0=;
        b=FxOiB3YWWlldD7qiMTw7zhE6ASp8aYh4wsT6LciKwdWyLBZ06uY9oFP3+ivWu9wSvh
         ZXn6r6/efWXnN8sD128KHnU/QeVf2D40T+RdeCZoyAz1sPfGo0I0sq086ctmcO4d4p90
         vhNloNgMnFEh8Jeh1StYBRF2QPfNtumIIvrHI7WSpjQFDj/Y9a52IkMLt1AaQmG91iQb
         EVA+cPPb6LZdpyawGQK6wFfSxjk8Eq1EAd43QswkP2ThrdrPLbtkOxovqbRDu1Xc+yLI
         4gwoY1+EgY8i1d6T+tmHZ/a88oQEycuAdvpxSuPB6gcG1H/cGJ7nhy3/lICmA3GR0Cs6
         64zg==
X-Gm-Message-State: AOJu0YzXHYePqW0ib3lPjaBkJ3kwavvO08ZJZi/pk4Lmt1dKx/3gur+O
        z5sZ6ZnlGWFAOTluOxS99nF3lw==
X-Google-Smtp-Source: AGHT+IEdWOZfR7p1w9Gb6XxLwAdNTGUgNWToaW2hfYQYWWvy8WPkZ2M5RTmKk2TbFj+qKJVFImmR2w==
X-Received: by 2002:a5d:5691:0:b0:314:dc0:2fca with SMTP id f17-20020a5d5691000000b003140dc02fcamr3367064wrv.29.1697909682769;
        Sat, 21 Oct 2023 10:34:42 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id h12-20020adff18c000000b0032d402f816csm4019129wro.98.2023.10.21.10.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:34:42 -0700 (PDT)
Message-ID: <5e148fb1-c04c-4dd1-bcbf-27c7475d4f01@linaro.org>
Date:   Sat, 21 Oct 2023 19:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial
 device tree
Content-Language: en-US
To:     Lukas Walter <lukas.walter@aceart.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Raymond Hackley <raymondhackley@protonmail.com>
References: <20231021143025.77088-1-lukas.walter@aceart.de>
 <20231021143025.77088-2-lukas.walter@aceart.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231021143025.77088-2-lukas.walter@aceart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/23 16:30, Lukas Walter wrote:
> This dts adds support for Huawei Honor 5X / GR5 (2016) smartphone
> released in 2015.
> 
> Add device tree with initial support for:
> 
> - GPIO keys
> - Hall sensor
> - SDHCI (internal and external storage)
> - WCNSS (BT/WIFI)
> - Sensors (accelerometer and proximity)
> - Vibrator
> - Touchscreen
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
