Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D77F5091
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjKVTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:31:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4AA18E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:31:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507bd64814fso95056e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700681481; x=1701286281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3Hb4WPhSaSPAUoOT6lB75q1bgT44dZFwIpXm+KkGko=;
        b=nkGHURidAIDei8O3E5usUyMd4izr+Y45af4dYisXNK5Ucfn1/gj6m+kdZVLFBqLXWe
         5F6EZVtNzFR7Q8QeYQ/vSBLeWGv6rhy+C4DPUdL6VEqi/QKyQ4MKO1fcDsOTPCuTf866
         hJHkBREZxUS68gI+vKa9XtEeVPuRjt7B6qBmoECCD3Zg3i3i3arYJ+hbo7+ilGWu07s6
         7YomS69xxuAa9u+YWGY9wTze5n35lwPRo/jhZg27Dr806SafNOGSG+DEXpf0rcCnZoGU
         Y8S1zBSyhuyd9KA/+FjyggmHwgk3VF/kEFbwmvuHWFRE6D1ctZZkEEpE/7AvVedZEDng
         mLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681481; x=1701286281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Hb4WPhSaSPAUoOT6lB75q1bgT44dZFwIpXm+KkGko=;
        b=DCxMlggzE/dVkSkiRU7GOcpq5t+NGbEMHn5qh7tiKjKyqUwqWDQ418MBTjdGCFJcK3
         MAodRjEvkP63YebZ0h3X/raKILHIK40gCK75U+kmDBHNf1ZgBQv5RFXqYZJzUdolBFXW
         ZhAVVyyZCBUo1YKZy4L54Dk1zZS+5cDy3UpJI163KYbsmDynh1aakYpx02IjQo+y9E47
         ZLaRrHWwdjds/V/qqjzr2m2bqCv0lVZ/qaF4c/e8SKEPwD5mShqgktNKkIk/r9XhhhYE
         3PAQqOzlm3T/fzC7KuJ7oEm7BV+/V2NKSS62Cw+112zRpmhsX3EgjaM2w8DRVjFOmtdE
         JaPw==
X-Gm-Message-State: AOJu0Yxf+jOa5712FSRZofgTsSCtJYBRqqqr76G4cpfHM30MNZIKiaFW
        i55XSuG9fe4ZD0RyhkBgyH132g==
X-Google-Smtp-Source: AGHT+IG9PnDXoY4hN8COg/8KM91F4QysmaB1ycYccER3JxluzECblJt0qpgWnFM6mx7ZjbgcZ5+Ohg==
X-Received: by 2002:a05:6512:3b9c:b0:503:261d:eab8 with SMTP id g28-20020a0565123b9c00b00503261deab8mr2918554lfv.28.1700681481136;
        Wed, 22 Nov 2023 11:31:21 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i4-20020a056512318400b005007e7211f7sm1938041lfe.21.2023.11.22.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:31:20 -0800 (PST)
Message-ID: <675bce4e-1270-4e9e-b520-f3f4c1c5ee8a@linaro.org>
Date:   Wed, 22 Nov 2023 20:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
 <20231120-pm8916-dtsi-bms-lbc-v4-2-4f91056c8252@trvn.ru>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231120-pm8916-dtsi-bms-lbc-v4-2-4f91056c8252@trvn.ru>
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



On 11/20/23 15:03, Nikita Travkin wrote:
> pm8916 contains some hardware blocks for battery powered devices:
> 
> - VM-BMS: Battery voltage monitoring block.
> - LBC: Linear battery charger.
> 
> Add them to the pmic dtsi so the devices that make use of those blocks
> can enable them.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
