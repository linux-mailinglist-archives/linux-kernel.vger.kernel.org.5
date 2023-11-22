Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49BB7F50DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjKVTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:41:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561BF18E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:41:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507e85ebf50so101635e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700682109; x=1701286909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIV3JPWp9LtCID8UlZm8kAzAEy5+PM3LIH4NQyYQfiI=;
        b=GXL6uAcWjwj38/nPdYssXNQVhT5FPzGFtQYgn9k1+csK9TEYnWSb/et+YlMEDYuJyl
         W9xZMuWsH/VNR10bwV4tPtefbScsEtXSSakeQdKhOynOBhNKvwinZLOxg4bA28kEIk/K
         q/CtRfK/gFxFhjyC7tl75hI0ho+Kj3R4ywSve7bHLF+OIMbnOAgBINJiE4HX4RAnedzO
         bWBQAjQ2HLMIMT6XADSo0liVJLroVF2ksY4H/YsPoY02TEMJzhzKmpbhLHxXkqewSHf+
         QDrhMFuY800Ab+tc3Z89KaQPYw9DP5tjiOrZcBvLWyL58BSY4Y7UrbtkoPgmc/FYz5A/
         ed8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682109; x=1701286909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIV3JPWp9LtCID8UlZm8kAzAEy5+PM3LIH4NQyYQfiI=;
        b=aP9J2OJdOrf/t9UkbZUHnMgHZRzF+yMcVGWaLqWklOtdtmGklwKrbxzebfmS5Fln9A
         UVpxOPpoE62ZJDpVkynWMWpPRK58Xak1WVGTpDiJc4hUzpms/W8eI30ErwVps4Ms9qHp
         9ekpC+VyRX/3v82XOiQWp8W91Sy/gQgO/jbZ4XrmcAXDsg/qgC5PlvXkIw2veg/x6Ez4
         N9WFXxuQoYx5XSMA3zu/2j0738j/ihNJTb/iVY6mlkfF0qRK6Stoewnqd6A561IxFWy/
         2FlSRinH5UuoHDeNc4Qb/hYtZqpOj5CIXNLyK0Vxj/2lIEpIu4NpY+skhGQeFf7a+FqI
         NpKg==
X-Gm-Message-State: AOJu0YyqhnIygVPrjKfPV+7CW7M0Fa4TmZ6JKVGthGtLjM+7fFEDscYG
        hyGWswhKrtZvpR8T+oRggoaHfg==
X-Google-Smtp-Source: AGHT+IEwT5V0ItU0AkSUZ7Zesjege/w1DM0cQu0GPXPXvXQonpCQEcCEv2CBBINZXD2uuRXp+mGLDQ==
X-Received: by 2002:a05:6512:3b12:b0:509:8e9e:a416 with SMTP id f18-20020a0565123b1200b005098e9ea416mr3019479lfv.47.1700682109592;
        Wed, 22 Nov 2023 11:41:49 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d19-20020a196b13000000b00505723e56acsm1945164lfa.273.2023.11.22.11.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:41:49 -0800 (PST)
Message-ID: <3865aefe-fb55-4f43-8f6f-30a1ecd5babe@linaro.org>
Date:   Wed, 22 Nov 2023 20:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sm8650-mtp: add interconnect
 dependent device nodes
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
 <20231121-topic-sm8650-upstream-dt-v3-7-db9d0507ffd3@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-topic-sm8650-upstream-dt-v3-7-db9d0507ffd3@linaro.org>
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



On 11/21/23 12:00, Neil Armstrong wrote:
> Now interconnect dependent devices are added in sm8650 DTSI,
> now enable more devices for the Qualcomm SM8650 MTP board:
> - PCIe
> - Display
> - DSPs
> - SDCard
> - UFS
> - USB role switch with PMIC Glink
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

If you're going to resend:

>   &tlmm {
>   	gpio-reserved-ranges = <32 8>;
Forgot to ask.. would it be possible to add a comment with
what these pins are for?

e.g.

gpio-reserved-ranges = <32 8>; /* printer serial conenction */
> +
> +	disp0_resetn_active: disp0-resetn-active-state {
..-reset-n-..

and I guess same for p8

Konrad
