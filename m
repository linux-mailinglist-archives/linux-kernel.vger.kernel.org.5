Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BAC760090
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGXUgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGXUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:36:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0F8AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:36:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f954d7309fso5998474e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690230964; x=1690835764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLdFsPRAS8xCwJorGH97RJOgCVh7iDyyrluQEQtwOCQ=;
        b=Fk1dzY+FjjjXjhSvAzTq8uOpc7/d9zhEn/iO551BOTW8UZ7DlvgjxeCh7oT1mb97zV
         iRXi0GFupN7gJ5MOC8STPPHwXjtmDUEVhflKuxICKFPaUHHz0n3bEb2AOhSNxP+gvBNp
         9YH4//F9blipEA/m+kX+f8pZK8saHoEWxYATAGsCD7XIbHcMYOn5vIAU5dXDPpW7Doeh
         oK6+8xVvV2bM5vaWoaXqZygdIfzOYJoVxG6nyaEonutrzoX/lTRGr4lW4tg4K/cN9B6R
         xnkfW+FmKBTOKbSPPT6rykCxbAB748baF/O3Bp89oODerJAbf0Q+MvNRsSRbixRSpjlP
         FEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690230964; x=1690835764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLdFsPRAS8xCwJorGH97RJOgCVh7iDyyrluQEQtwOCQ=;
        b=XzIhfnnY1yzvxVwurATHHLqlluUJSE/uiKc0BUbSW33W05p9gE9GPGbCZVWUHUUpng
         nFqjKgMwQZXmlShnm8OCfxVwvXCE1B4ALCZyCyhTukFsNlgoP4IiLf/kbXd/qUKigG1e
         0t0oJNmdZ/oK4Y9G8C9KjKo480cWcOrxkbXwdsy5YSoMt52GgJyzvvMnJViE+41x500D
         e+4A9kE8fvRCuVf1JYqBiI8vdUAjNoC/EZXNO9GHIKgJe5PhUIW/J+9fcoc5u/QEeOs7
         lElsY06arKxUcoR1pI5PDNX2j0vf3cFmZaoOtEvzldMeVxbA9eEQGvQK4OE7T181+TdB
         D3DQ==
X-Gm-Message-State: ABy/qLYmsAnElNi6gzUl+l+5aHGB17sI9MRdNBnLkVNWREOA37r/AUI7
        BnjPtFQow4OQXBi2Q7mj+N1rfg==
X-Google-Smtp-Source: APBJJlGAyvOSXg9MYrlihpCf1WwARrBoed9/YAGHC1BuEiH2ayUiymDgCEUM4mEOC+/YhSVqhqrW6Q==
X-Received: by 2002:a05:6512:ac5:b0:4f8:4b19:9533 with SMTP id n5-20020a0565120ac500b004f84b199533mr106930lfu.19.1690230963879;
        Mon, 24 Jul 2023 13:36:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j14-20020ac253ae000000b004fb757bd429sm2414910lfh.96.2023.07.24.13.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 13:36:03 -0700 (PDT)
Message-ID: <d1951f5d-d3d9-f04d-7b76-38d8a0e27c56@linaro.org>
Date:   Mon, 24 Jul 2023 23:36:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/7] drivers: soc: qcom: rpmpd: Fix MSM8976 power
 domains setup
Content-Language: en-GB
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723160827.22660-1-a39.skl@gmail.com>
 <20230723160827.22660-2-a39.skl@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230723160827.22660-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 19:08, Adam Skladowski wrote:
> Downstream kernel parses resource names based on pm8950-rpm-regulator.dtsi
> in such file qcom,resource-name takes three values: smpa,ldoa and clk0.
> First appearance of RWSC/RWSM point to msm-4.4 kernel
> which is way newer than what this platform was shipped with (msm-3.10).
> For the max_state downstream code limit value to TURBO inside dts
> with only one turbo_high being placed in msm-thermal bindings.
> One of effects of requesting TURBO_HIGH vote is rebooting of device
> which happens during voting inside WCNSS/IRIS,
> this behavior was observed on LeEco S2 smartphone.
> Fix regulator setup and drop unused resources.
> 
> Fixes: b1d522443b4b ("soc: qcom: rpmpd: Add rpm power domains for msm8976")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

