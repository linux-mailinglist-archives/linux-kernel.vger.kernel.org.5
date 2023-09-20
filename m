Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65EC7A7C15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjITL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjITL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:57:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A2CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:57:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9338e4695so108954011fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695211057; x=1695815857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1DviYvLqEA/sZL5Xm7Eug1cL8OIq39bt8izdUeklRY=;
        b=qOExDvC2m+AG5X4z8cSJxMjs9+Cq+RBI6LIIEAE7zGGcu8xz4mMWMQZVLJ59RvC004
         vt4pzrNziRUAm/ZcKZPS1b2w09xQCKBQ5rWxlNVcD2zxn5L9idy/+mQbfG8k1gMJKIf2
         Fc601MB/PngswpawwwBlI68JYR8vC14eJifb1mEQNsSIEAiyUADgigJgY8jOk+PzVIl0
         To0Fx1H6f17MIy7zRnF/pT6tMCBvkwR9omAJ8xXLVxeTSbW2GEO2J9hGmLsNBnObd/na
         Wsvv+ZJoZ/NdA2BSHrKORpn2OEEOViKSSM2QAPnAR5Z4sBO+aLGGhDwIrFyFNklsGBVY
         rWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211057; x=1695815857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1DviYvLqEA/sZL5Xm7Eug1cL8OIq39bt8izdUeklRY=;
        b=jnalhgg9vM6aLmgoZRcHqW3e9OHhhWIBLiQ3oa5YBVtCaLQEFjuG3juRJAYNBMAfb4
         FVOCHJfpF8ai5jEi/dLDvTJmEVGSD3094mLiTzU6re1jgvP/1eNZ1FvS7kL+dBDQ0ziT
         P1HpMmdH0r0imd43Y8Of+k5JYjWCouDyasl/L+Fvk54p6oJQmzwbeQkSh5S1ve7M1+kQ
         EzEayZUhq1dBwxJqsl/vvLCwvf8/Yy09LGA5O9VBGBlY3HaXiyjf6mpMnhAKs9E4FyWR
         s0KIjvENle3A5OWHA4bdqB/jgDn1ayQF2uyj/Ip/evdKbCzTlT7C6s4sWqH/H+yfX/Eg
         H2xQ==
X-Gm-Message-State: AOJu0Yw6IkqYk4hCJj5YSzuaZxnQ91II8l0DcQ5TROC6/g1xdLYaViqq
        aFBhvpsUcccnxt2n7zTqD52New==
X-Google-Smtp-Source: AGHT+IHi2kpY9k3ikgCwNoko87/nzsnTiOCoDw3bl/xpeTq0iM230cVrxJbvaiXRPxFgp6S5vX6VBw==
X-Received: by 2002:a2e:2c12:0:b0:2bd:1f83:8d4 with SMTP id s18-20020a2e2c12000000b002bd1f8308d4mr2147021ljs.22.1695211057552;
        Wed, 20 Sep 2023 04:57:37 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709064ac100b009934855d8f1sm9177212ejt.34.2023.09.20.04.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:57:37 -0700 (PDT)
Message-ID: <0b84ef92-f6b7-f3bc-fd51-8f61cbc91ff8@linaro.org>
Date:   Wed, 20 Sep 2023 13:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Content-Language: en-US
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <55865e1ce40d2017f047d3a9e1a9ee30043b271f.1695189879.git.wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <55865e1ce40d2017f047d3a9e1a9ee30043b271f.1695189879.git.wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 08:39, Chen Wang wrote:
> From: Inochi Amaoto <inochiama@outlook.com>
> 
> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
> the timer and ipi device separately, and do not allow c900-clint as the

Why?

You received comment about it, so please provide proper explanation in
the commit msg.

Same device does not get two different compatibles.

You also did not respond to my comments, so you basically ignored it and
send the same.

NAK

Best regards,
Krzysztof

