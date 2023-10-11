Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901EB7C5B52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbjJKS33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjJKS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:29:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A259E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:29:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5041cc983f9so225758e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697048963; x=1697653763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eejRC5jkkP9a/cnnUiuXlShL9G58ptQE16Rjy2o31Kc=;
        b=l34vBeqbHEJoZnXc39NmqowIFcSAYkwnXNfrs3eKZSehQL8dUP2dGuy6TPHXypCwju
         xdHKIb+KkKitz+04WtiZAmG7dLJoEA1Z4q0nue/pgt4KQYRglENVQcd0lSy5htF0K2pP
         Mb+MEqyM+AwsMePnzjISyu/ujYj/xvMNJ9uEVgUTw6MJLdmHUzwJffaP6YoZtOcDeXKX
         xgYRq9TD2TsH99Q8scVFw5pmVFCKBnR4nBjP+OWyf4r1jEzQU9njy1D2oPFbe+jD35q7
         J8zLBoMssjLXJoIiA4iwXPhEZ6DrmQCTiL+oUO4JbwIvK+6o8bW/6B3x/ESp69ZnNiQo
         cupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048963; x=1697653763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eejRC5jkkP9a/cnnUiuXlShL9G58ptQE16Rjy2o31Kc=;
        b=U8140XvWyrD4hdOqsmmxufMXfakSdOsJml2GXPQou3Dj+mrAufcR3OMxqXWuWwrJBg
         Cp1qIe2ZnwXFvBWWMytT2TUTBeQnrw/rhhX56SePG8o2n0juA9ufJ7oenNJpDcvM5K7Z
         fta/ucgGs3vFzcKCQAhW5SO3FZhPWlReOtLdsjyRdA2rGWyxcvfJx86wNCcqVPos/4Nr
         oU4Zqqwc3P3acPoQ+pj5u3GTeRgMZqMT2X5G82VKMXvfRT3GfcRvf8bOY6+BfP6B8YSV
         N+fpwHEux6wR9wwkdspDkilLyxIQ7OVgAPKmwb0ERhrRJ/CXhjQ2d8SdsIc35ekv4xBo
         Yi7Q==
X-Gm-Message-State: AOJu0Yxm6D/q99LxNpAIw+Xiiwi2qRBrwRqQzynbr+q4zzxRTFr13R1I
        olBk5trVxeQl6WSCGh+84JFZIg==
X-Google-Smtp-Source: AGHT+IGMLQlG/2YqVwq9AN9IBYY2DekPXLj3trGyLQFjz0c/WVT0DhBhXpaKl81zyKyxcOyvuuabeg==
X-Received: by 2002:a19:7917:0:b0:503:c51:74d7 with SMTP id u23-20020a197917000000b005030c5174d7mr15013587lfc.17.1697048963200;
        Wed, 11 Oct 2023 11:29:23 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b21-20020ac25635000000b00503fe93fb56sm2368604lff.228.2023.10.11.11.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:29:22 -0700 (PDT)
Message-ID: <9e781059-bc86-4485-a9e5-80fcd14113fc@linaro.org>
Date:   Wed, 11 Oct 2023 20:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: qcom: msm8226: Add watchdog node
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
 <20231011-msm8226-msm8974-watchdog-v1-2-2c472818fbce@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231011-msm8226-msm8974-watchdog-v1-2-2c472818fbce@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 18:33, Luca Weiss wrote:
> From: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> 
> Add watchdog for MSM8226 platform.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
