Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6A811D82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjLMSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:53:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7FB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:53:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso5207772e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493598; x=1703098398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ku/fxQddbUsXkZWqNsVN6BsYEZ9IGNwS0N2UBJzX60=;
        b=xWszgZu+Vm/C9K/hBngjvPCRxwLc0rJaz4zwxi2wOVarZKtt446oQrjru+LR3w5ynb
         R8kmoZRdYPtzk9sBnJWJgqy/RwXFz+Wuj5x94R+z67Zwf4THcoV+KeAhNp3TKgCVKqiL
         tyD0644N3IeI33VGtLS55cZ+Mbw5832PWzkOmplZ8ZUGlpvIIEt6ENRpDfgCbWVu3Ueq
         NIsoK9qlsWjoEP3vGBL6o/dZZ99u2YkNoviM+zMohYF1IbHeHpr7FhtQhtlU2DZTWzlG
         db24Z4O5v7pahatAGE4kbCgThjJO02faI0BTTl4Leb7K7MI3Xs9MUobkjSEslHmo0GOf
         cyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493598; x=1703098398;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ku/fxQddbUsXkZWqNsVN6BsYEZ9IGNwS0N2UBJzX60=;
        b=ok/JwEUnLYvYXNTrjw60Znzvs1VLKs9ih5mreVl24WikSsD5PAglaLhwgYNTdUcFRd
         vjq0SpRBuoh8ivOGO5FujT96Rr6la/x+lzMW5P/47D1ULK3NEbAa2u2Y6/1ClIgRgTu5
         PqcnlmeXrzPs35AiyCd/FBdDDRr5S2/+aPDnzlCUr8Bpe+X/TyM91SFW4P0F+JKAPw+4
         OGHv6APX2yujU5p/3cx+Pjc5QlCwtMjueFg8iRkE6jl851FliThgQ1zetojQI0JyeyFg
         D65dQkPqAmSVwDeliK0LGgFW/bUDVLYpdUpPC4h7j89tz2CDKQO/d1iPqe+9FMYKOb9/
         HLbA==
X-Gm-Message-State: AOJu0YxJwebmb6an6nBZYRlhRAsAPj1hWAD2zkO1coPgNv5YwCNTTxEv
        9FV4FAS6DVo2UOOPlEfsDEXydQ==
X-Google-Smtp-Source: AGHT+IH0bW4AvMCjtk+XJm9PdTEIKUL3n1iUt8XkWJ1rYOdghnW2zZH3zuCvd8eROOa1wcRaHZ77xA==
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr5430181lfb.87.1702493598296;
        Wed, 13 Dec 2023 10:53:18 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p12-20020ac246cc000000b0050bfe926aa0sm1684135lfo.253.2023.12.13.10.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:53:18 -0800 (PST)
Message-ID: <a1ba5894-89d3-49a2-bb52-6599274c00c5@linaro.org>
Date:   Wed, 13 Dec 2023 19:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8450: move Soundwire pinctrl to
 its nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 17:25, Krzysztof Kozlowski wrote:
> Pin configuration for Soundwire bus should be set in Soundwire
> controller nodes, not in the associated macro codec node.  This
> placement change should not have big impact in general,
It did ensure correct timing for rb2 so YMMV :D

> because macro
> codec is a clock provider for Soundwire controller, thus its devices is
> probed first.  However it will have impact for disabled Soundwire buses,
> e.g. WSA2, because after this change the pins will be left in default
> state.
> 
> We also follow similar approach in newer SoCs, like Qualcomm SM8650.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
