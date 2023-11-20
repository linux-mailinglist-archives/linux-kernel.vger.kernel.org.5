Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB47F1132
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjKTLCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjKTLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:02:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363AC9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:02:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f78dcf036so3157550f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700478130; x=1701082930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HytwA7HVysgBJScXXutqEK+0fdWB/b6Ao+3Wu2cMOOA=;
        b=m/MfN+qUw+jY1BHl2iTTNPAMTu0rRc0v5pv/LSGhhCpeleb5remyCa3E4Ak/ehmbW0
         yP9QC3LF96IhNCyt8ynBv41oF0Elwan441L/+nrUdPxB8B4sGF5aZDiqa1CxxcPk5s2y
         XMTfY3Ujq++rkVrj5wnQ/mEbtE9LdkVojdpFqdYRqtx7axhkq/f0jQnu7fjIPFHsBUn2
         rO729TEJnyeLxzZ0RODEADAzUhnSR50bQwHMukUm/vJlW2FVvBPqmXe2zdW8C7zHL9nv
         2NO3afsY07pTOCtnoD/+lmocm+YULns9WCCW7hghto9DiCUGO4zvudknTqy329U/y9GU
         vkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478130; x=1701082930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HytwA7HVysgBJScXXutqEK+0fdWB/b6Ao+3Wu2cMOOA=;
        b=txEH6674LIq7NZgvaxB5BIDo/H8Wn4TcPLBcAGjocyHpr7BJToJTQDzmUsm8ablN8l
         j0Dbm9TjOOm7rltc2qHZRMBOVqGX5dSV2QdHUTtIIpQB44wOZ6ZsgWw6k8slMd37IDQZ
         AJCyVYtdt0+4a+jpxhbeV0cffQ6ttr8GUlrToCvLt5I9XoFK4bl2xzPyctKd4xcYw4Qd
         Qan38Yy/ua0MH3MR6RdfoKVa2bTd3fi9k8QkOZ9hgyjXgKh3TqxtgcebTwa8z1Iyrcnc
         +Yr6yQj0XTeeL1mYb9iRynpFbHZ6CDK1r05tmzZCJZohrYzh4Q1uFQZ2ttrUUSLTZpT/
         tl6w==
X-Gm-Message-State: AOJu0YyIGLHzLfHD4wyD4i86rDeNigiF7kqCqZgeXaVuIq5inzPsr/xX
        NvRHN8l/1Xh8WRrrLXbmBqeEUQ==
X-Google-Smtp-Source: AGHT+IFu3vVwHKbXDD1C9QxIgvpCTCFkU5meq1IURj2o2nkB8wQpPG9Pphbrie1MH1TmSnRBN58iLw==
X-Received: by 2002:a5d:6d86:0:b0:32f:7a22:8b42 with SMTP id l6-20020a5d6d86000000b0032f7a228b42mr11134783wrs.23.1700478129621;
        Mon, 20 Nov 2023 03:02:09 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600010cb00b00332c0d256c5sm5916490wrx.80.2023.11.20.03.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 03:02:08 -0800 (PST)
Message-ID: <567a0eeb-3116-4103-b61f-5d8e7ab1f768@linaro.org>
Date:   Mon, 20 Nov 2023 11:02:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
 <20231117092737.28362-3-quic_sibis@quicinc.com>
 <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
 <2e0d2c55-fb2f-4903-a555-f51019942c6e@linaro.org>
 <c8cf229b-4d15-4eca-bc4b-61dc67d63e91@linaro.org>
 <4af8e7a4-0506-a08c-f294-d055fb463af8@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <4af8e7a4-0506-a08c-f294-d055fb463af8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 06:42, Sibi Sankar wrote:
> Bryan,
> 
> 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use floor ops for sdcc clks")
> 
> The floor_ops was introduced in sdm845 ^^ and later propagated to all
> other QC SoCs later on. It makes sense to do the same for sc8280xp as
> well.

OK good enough.
