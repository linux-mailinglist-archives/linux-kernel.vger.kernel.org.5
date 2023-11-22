Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB727F50FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjKVUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:00:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FEF1B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:00:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso125370e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683229; x=1701288029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxfRjeO+6//AOclod090Pxu/HWOvIlUw5wFHoylvtIk=;
        b=XGRwIQ+fASZfv7LFvEsnHiwQ9WpBsbhqcfZ2SEb7Aj9/LMDMAKVBq/COEYttBBfdLV
         e0HU79mcWMkkZG+jQw5Tj3Gex4hkJ+QeLk4cyj588/YQC/LEDJi/zy36viqHtzbIMI9p
         nbvl944/IHKmFzqvtE0um4eGoOG+NIy2Zr8qyfSQXqKZYjIKm77XQxEsQlLYbWxsG6jF
         f6iIVVT3XYOmvOJh40m7EiRhlhMOrWce7pZcJJKwXgXhb+sIHvJ6m90DlhrHtpNAaXHg
         BMJU1M7NHT9nrsj/hdl0UsdzdFIZyx7cULOs73YVFAUXawojjrjYodYB2qiYWKwFw+lN
         Gj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683229; x=1701288029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxfRjeO+6//AOclod090Pxu/HWOvIlUw5wFHoylvtIk=;
        b=nW/WIWTOue5s8ghxahekoqQXdcws6Mos4NbcHcBGJL172agwgmB2Sef3apxeooQd3c
         F3q23/02whZDAKuQZwE6uhtTgViDKq64OcaotP+98lQtXEFIhuf674Ld+OZLz/k3yLyG
         Gdtfgneen+DD/OvDwrM+Hg0q4Hv++VcnB+1h6e3qfu1Fl4huDHkWEnbPgnB4Jc8AY80F
         o5cF68sjMNonHueZ61aIvva+aarhQZhyxZK4awi5lHGDfY5Af+s9ZHVrIglVZYsKIcVJ
         ZkvAxPq25po1LvRlXVAnrrcgIrxQ2eTCTTMBTVbBW6hf5QI3nNFDRuUVMFJYQ3jWDZUM
         Favg==
X-Gm-Message-State: AOJu0YwAabSsMHEndc5/yUzJqBJgTUDwJZX5CdAOy/IzGElyhqEuUaAB
        jssdVYi7GENDRPOInZZnNbaqJg==
X-Google-Smtp-Source: AGHT+IHls7EBe3OVOnCOlDbggJ1Qx2xgrsuzrL7blYXiBFq2rwRUccQYEutyTOVUmFTHhfaIkcAJyA==
X-Received: by 2002:a19:674a:0:b0:50a:a720:141b with SMTP id e10-20020a19674a000000b0050aa720141bmr948095lfj.31.1700683228703;
        Wed, 22 Nov 2023 12:00:28 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0050300e013f3sm1935876lfr.254.2023.11.22.12.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:00:28 -0800 (PST)
Message-ID: <d867be91-38ae-406e-89eb-accdfe85be71@linaro.org>
Date:   Wed, 22 Nov 2023 21:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: videocc-sm8150: Update the videocc
 resets
Content-Language: en-US
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
 <20231118123944.2202630-3-quic_skakitap@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231118123944.2202630-3-quic_skakitap@quicinc.com>
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



On 11/18/23 13:39, Satya Priya Kakitapalli wrote:
> Add all the available resets for the video clock controller
> on sm8150.
> 
> Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
> Changes since v1:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
