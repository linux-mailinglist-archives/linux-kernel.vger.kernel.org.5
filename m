Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F410F763ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGZSqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGZSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:46:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679B2125
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:46:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3110ab7110aso109278f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690397173; x=1691001973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIA6tFVPEntX943eMtnDQw8/WnIhuSeyz957fgQQqX8=;
        b=lX6sERAD4wcvWMyA4J84ZRhjADmLtuE5k4rBD1HZHR8UkmkzFNXEXEOKg3v5e9r7yh
         jD+SFFs3nkGh6U1m8v45pXXwbGnw2qhn35drwAtJ7P9pOb29VJU3GtNWbPUtywIMY7R0
         trHwx+XMi8Spz+Z/IWMM3vkhtP63zxmHpnMdk+4ahFhh/sgTmN2C5mh44YyMXCJUrx/7
         MFa6xFvsEsO/A4e3rmRkH5khO09hPbQQOPSJg1bW/6jrMglV3BRqrJZc3P1VlO1bCZ1p
         Q8hePQg3KBY8QWvDUcMti8L7y1mEPZ9eVFK8wcOc3i9Xo4EKR3KNVPFxa+ak9PxmEuR4
         FNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397173; x=1691001973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIA6tFVPEntX943eMtnDQw8/WnIhuSeyz957fgQQqX8=;
        b=EnfYC4jsUIPeQnLiPWvqmoNgwRrQPKPJZ+2AX0bOyWapMuOSz+0wGRER8E+8oeRW+4
         Xwa3OTtJwU3CtMb0X8GcWOL1BFjDckrZSQe5EWJOqqsmg7KLVMfdKU1dwkKb8phO0YMA
         0MUWyjrCJWtzK80NlaZLIAp2E7Mz9P3D0MedHwT/oRoaSVWWHsi8cCq91wGtoW8ehprz
         etM00QJHOC9MmjjFAEyvvPqrgXq7qeXO2IXhiaPXX7+7ZO+5RSiw/7INBWXShhRzPDx6
         v4+DUpkDmTUi5y+NwTvIU6o5H3LnbrG/1qkWz5AAHOdxIhdk1PyeBFTn7oIDxcLDPf4p
         Ogdw==
X-Gm-Message-State: ABy/qLZubX6cSB03nScMNlHIAtHHrXQpKSURLiTJBYxMlqtyXhOmgki3
        QXoQX8v/xUQXFCCdHZ8+UJcpbg==
X-Google-Smtp-Source: APBJJlGW4bH5/K7JaooshRZKm4IUB76EFrDboLrwrdIOUTH+aSUijKHPgZDjSB07D7Aki8ddkV1S+Q==
X-Received: by 2002:a5d:6184:0:b0:317:6220:ac13 with SMTP id j4-20020a5d6184000000b003176220ac13mr1005wru.32.1690397173194;
        Wed, 26 Jul 2023 11:46:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906a08400b00992d0de8762sm9921111ejy.216.2023.07.26.11.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:46:12 -0700 (PDT)
Message-ID: <8bd8fa38-551b-35dc-cb6b-7c5fd79dc0a0@linaro.org>
Date:   Wed, 26 Jul 2023 20:46:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Content-Language: en-US
To:     qaz6750 lzy <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <SY7P282MB378740C6070900BEBF5D0D7CB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SY7P282MB378740C6070900BEBF5D0D7CB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 10:42, qaz6750 lzy wrote:
> I2C6 and I2C7 use the same interrupts, which is incorrect.
> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.
> 
> Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>
> ---
>  [v2] Fixed issue of not using full name

You mentioned your full name as a bit different, so I am not sure what
improved here.

Best regards,
Krzysztof

