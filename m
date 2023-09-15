Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0B7A1CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjIOKrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjIOKrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:47:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BD118
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:47:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf3f59905so260140166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774826; x=1695379626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/o4N+rJdDvPOkHZP4rGeji09Be+GMTp3ncXx+q6uC0=;
        b=icG5iIDZbs+c41vEqRqwJCd2yZhBnHjuWRpAGvFzCVGt1LybTXZIJnG5IyVWedUCsu
         A3l1kbET70LN0DcPv7u97MkPJ0KjmsN1D92X47rb49tnmWT37ByXSlP1BbtSM11JInTX
         MF1K6rnHPcFuaOHkHVxUNQBe8PhUFCL6L/HL0cCcJGshExeIFsP95CeWS/Fqv5FClh2S
         fIW3/iGywh+JEf9gZ/Z82dEjqNHyuDq4MFTUOssybK8sgixh/1G1b0wbGL82rK5rwDcg
         NqVmKnqSct8EXVgxB7XGHWt4/5EFN3boSG/cVCx8mDnWQUQi8w4gElQCiT7E8HrqZL0k
         vUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774826; x=1695379626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/o4N+rJdDvPOkHZP4rGeji09Be+GMTp3ncXx+q6uC0=;
        b=LMFjoEzyWV4StELaQlUa0EYjdrwdrM4M4wimBkIQYf/rHKH8m3j6EvfAW6PsvpGCOx
         2bd1BHS+caV4CiSWQPTFCY8VCC8cam9DyoWrdGFtSXWVLmNQmTzIp4A+WAyDPFP5WZeo
         LCy6Kx8mTP18m3LPmlCi/3tnpIgvehqT1T/gqv+ljWU6p+pBPrddL/mH1eQO2ugdYKrY
         SBWH8rDQVst7ng0k2dwbqczwNwXT1t+2l7o5Ves25vWrq/X904UvtbQQ4yjx0DL++5qa
         zNFAmeqkz3Dz4HOCdnMf4WOGWwjLV2i3ziFAfLHP14u6os2U6OEhHCfWTAwKRiCthqtE
         zeGA==
X-Gm-Message-State: AOJu0Ywl6of58Ig2PlbFrUmS5u0Ou1O4kQP6U7pv8wmZBxEVj1Xjpg+a
        gALD+dAEbcNztC2xQJ/sRfbXqw==
X-Google-Smtp-Source: AGHT+IHVOd/ddryjn2v0lhERAAcKk6mQCZCf4sdk9KrpW6+CUqWi6F4ZfilyAWQn9jSB9zOV0NnX8g==
X-Received: by 2002:a17:906:311b:b0:9a1:c352:b6a5 with SMTP id 27-20020a170906311b00b009a1c352b6a5mr1069106ejx.69.1694774826009;
        Fri, 15 Sep 2023 03:47:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm2224043eje.176.2023.09.15.03.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:47:05 -0700 (PDT)
Message-ID: <d334267f-38dd-bf70-4246-263de1a4747f@linaro.org>
Date:   Fri, 15 Sep 2023 12:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 19/42] dt-bindings: spi: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-19-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-19-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC SPI.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

