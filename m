Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA517EC95A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjKORH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKORH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:07:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD201FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:07:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso6722385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700068042; x=1700672842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dB7xh8nk+eJb46EfbGktKWpgeMyfJEH/xs3+rQACfvE=;
        b=OAgleNmMysI+4IjxXxJVUMH7eSNNsmyVkMwS3VPHg3pS3EIUBuZH2NmtJLC+S1+29F
         cUn0KUXKNSgxx9MQoUQqWn/5Iq1G8df6UQ1tlNEdB7huWHDzzZFG7iD5apcRj2llu3rZ
         u6JPY3bQl7z1SYUQnVf45nS2eljK+SiXJn4YLKnp1xdGHCRdYI84ivW2JCoFghvSDYZ9
         1ahHIg94ZEmTgxnOpln0wxPK2bQejmIf9vekZvwN9MQmMlkqW2sKsuFA/NEVjhDKR96i
         aMUl/D7y/Pi+GTkZkBmca32OZUOU0DwyzakIfbBrly8h3FDt2G8DmirewIlOOkas1U4f
         mC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068042; x=1700672842;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB7xh8nk+eJb46EfbGktKWpgeMyfJEH/xs3+rQACfvE=;
        b=safqMbPv6su26gnbvJz8+ROaXfvlWTt+sFxxU7u1sT+7N6wUBzZfTixWbbm11CDI9Y
         Uc4f64L8OOmKTugWFOuw/+x68Go9TglPN/qbeuoMls0A35TXogV+xLxhUH1pXZr6EPjM
         QpxnZLN5zag4d7jGKBetjxrzybVDQ3SpzPZVtKZIu+53NqdkCtmt9bO8t10jgifopWM4
         edG4nAkFyDagUxppalOSXZ3KWnwNmigK5REJLdYCBj/iGi3/SwD/zl8m9oRnRZ6YZWF9
         KKH0RVryiL26hP5dHOR2ZETmF/qc7XAmnsjfQ2+9XTwNjgaoJSCIz/Bo0KQymeZczpiI
         TBbA==
X-Gm-Message-State: AOJu0YxEDwBAWn33zKco2wxaVP0+Ie9TpZfMQDo+A0LBfstTadhQcYzT
        cWWdbCcNFCA/ringKeyYJ2PTlvGdTE0qxLq7zcoMPlZm
X-Google-Smtp-Source: AGHT+IGbUGtVGH7+Z3tfhZqIZqoIY32UXp082s8ffs6m2y9YdKNUEMx2b6pMMRQr9j+dTdTEFGsGpA==
X-Received: by 2002:a5d:5983:0:b0:32f:7eb0:2ed3 with SMTP id n3-20020a5d5983000000b0032f7eb02ed3mr5362719wri.5.1700068042339;
        Wed, 15 Nov 2023 09:07:22 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600010cb00b0032f9688ea48sm11078327wrx.10.2023.11.15.09.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:07:21 -0800 (PST)
Message-ID: <ab2c54fc-6557-4c21-9f51-761e8491f4fe@linaro.org>
Date:   Wed, 15 Nov 2023 17:07:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq6018: add QUP5 I2C node
Content-Language: en-US
To:     Isaev Ruslan <legale.legale@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 15:38, Isaev Ruslan wrote:
> v1 -> v2: fix clocks typo; fix reg size warning. 
> arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++ 1 file 
> changed, 15 insertions(+) diff --git 
> a/arch/arm64/boot/dts/qcom/ipq6018.dtsi 
> b/arch/arm64/boot/dts/qcom/ipq6018.dtsi

When you added the v1 -> v2 to the patch you also caused a newline which 
prevents patch application.

Try

"git format-patch HEAD~"

then

git reset --hard HEAD~

then

git am < your-patch.patch

Resend when that works

---
bod

