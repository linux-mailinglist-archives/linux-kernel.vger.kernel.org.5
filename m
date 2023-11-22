Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACA7F4C14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjKVQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKVQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:13:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0CBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:13:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50aa8c0af41so1082209e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700669621; x=1701274421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63C0tA6VUDFssxzahNxzAEpcgZHhsFJpENPr7LEnrCo=;
        b=tc5/2/Fa1CxUxRNyR85sbPivvg2Jkdl4AAqKLy38JG61xtJQQRaYDi8/0E4mrpOMhl
         wmLeYSWnuTJ0kp51RYwucU8jn2ZeJIXcV+khFJzG2tLO5qMfrjbqS3C1ynYGSXFwo+P/
         Yw58mhu3a6vl/6gUO5ZkeLiKaYI2rYZ8LK3T4GRI5mM1AE0tO3RFWmT8tkjDRt2HZ4RG
         6mdAm8lSZLVvev49jMtDPl4Ld2BSleXSq95rFfV+xnCkmH00FynnVhKHD61dxK3aT39m
         CLvqkqWe85wP+Yb5qXFO1PQRErlfbQUgIVzDriOMhWVW6fNlQZGukSQYBa+OWUxVEcze
         G+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669621; x=1701274421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63C0tA6VUDFssxzahNxzAEpcgZHhsFJpENPr7LEnrCo=;
        b=PmCUtmyQzciA+LVnS5S4jjvOd58JG5/HGjvWsawNWgmAHvdn2piyZfYyZYPH1epCet
         e+jeFhUKWUgJ3igd0l3LVcHPwUEsgBZI0qZP//RgOKhJT5bHtGIzJAYrKBClC0rDaaRE
         NXQrQrt52WmuypxXzNittsZXRq8VK+1j1+hgfKr2sIzYVEMV9jM8LSFUIz6rDbvwTSas
         c/oFOMgolY/BAH+HWbIxH3brAk5YPhr/B6hIPQZbG9AQ3HSUwTLmtBqHs9ayVh+qZOpb
         UmKKQ99FG9gMlKUPdAzJhvv5DvJm47bo31UjGIOBfgZripuIX/Z9M5luaEdIvbwxAcar
         soCg==
X-Gm-Message-State: AOJu0YzG6ImIR7ASiYENQmy3O1xB8+1THcBPnojjbptODnAFnlsFWuRd
        hb1tIDRP7T9ivmGdotx5AybORw==
X-Google-Smtp-Source: AGHT+IFA7F5yavPPFK+duxLNncV9DIMf4kjfUVwLpHh37aK0OUYwnOVPaDl2Xm2PA8R9dLlFKPv65w==
X-Received: by 2002:a05:6512:1243:b0:500:d96e:f6eb with SMTP id fb3-20020a056512124300b00500d96ef6ebmr2584849lfb.19.1700669620818;
        Wed, 22 Nov 2023 08:13:40 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id br20-20020a056512401400b0050aaa64cd0dsm1297322lfb.13.2023.11.22.08.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:13:40 -0800 (PST)
Message-ID: <a255f8b0-2f1a-4f0a-8eaf-28bde7616929@linaro.org>
Date:   Wed, 22 Nov 2023 17:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: deconfig: enable Qualcomm SM8650 SoC drivers
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 10:51, Neil Armstrong wrote:
> Enable Clocks, Pinctrl and Interconnect drivers in the ARM64
> defconfig for the Qualcomm SM8650 SoC to boot the SM8650 MTP
> (Mobile Test Platform) and QRD (Qualcomm Reference Device) boards.
> 
> TCSRCC, GCC, Interconnect, and Pinctrl config are marked as builtin and
> not modules due to boot dependencies.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
