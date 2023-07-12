Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684AA750F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGLRHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGLRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:07:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA911BDA;
        Wed, 12 Jul 2023 10:07:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso116067631fa.1;
        Wed, 12 Jul 2023 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689181655; x=1691773655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kGZAsS5tdS9F94ItFKNfVexTBZCEL2rOdXGVzff/yw=;
        b=famkSt2h8qbAvE/NS2WqmLgJF1OkPIdLmXKD8pw6+jHshf4+/HNM+heWulsZbw9MUm
         fqTWq98/azcYeaisWcbYblyj5tbOh+wfSgnSBdCs+T9Clf3nL6DZbm62f8GnneQcs2sd
         5d7zHArYX+H72UvGSwLH/pCnm+G9YvekaKN9bzgu0KCKihwiU7gukkaMvvRiA9PvLbYv
         YclwbPIjjfq/JJUaa6CSQ9gBKmKtb5muDA6VjH9aaCgni2C1AaA7GcA1ARuQI+FEsEvw
         YsC9TcXNBFT6+yCmZfaJLAXmuItkdM5/EL5QO6kAKVUQG3aPVjo8hwVle8yYzfxnqJLk
         K2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181655; x=1691773655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kGZAsS5tdS9F94ItFKNfVexTBZCEL2rOdXGVzff/yw=;
        b=VZtfDoEapZNRXfuKInos2Pe44PW5SEQhGatKBWq5hRaydM8h27A6A+qQzdHSR7Zxmo
         xQY0ApWGbWQ3C9yKc7VEHPWB7D38ejIuT5/ILuGcHj7pfmKsryER1kpDQQOGnCdoS0Kx
         08dYi0r0et32pltFCe7v4HR9t6OHAIaeZAWE5D7L1seETPCV4XBJ/aoXQrAlWUj7YNEV
         RJEfbQcnBh6HmiZMVVBj5lsOOLH+Ld+e/QwM58BxrS7klueo0gtnCsnntsIhNYNgeoQ3
         tdZsAoL0oUAeDPiF6h+HgMQRmQsEVFotMn9+3QRytup7tnb4wJGp5zeRBGRTQn9Jpc1U
         pzKg==
X-Gm-Message-State: ABy/qLZzMOIRvrTuuwzBLSBiQMFwmSe07ytU7YBI7oQxYwpUMbRR3ucb
        CUCcMTD+PFXYjnlS3yH6Rnk=
X-Google-Smtp-Source: APBJJlGae7fMG6xizH4RsZOs7h+VNE0AgS8JP+FhantZZgaGEOgZGw9k8uuWSoLCKdsoHlJbotquTA==
X-Received: by 2002:a2e:7c1a:0:b0:2b6:fc88:3ee7 with SMTP id x26-20020a2e7c1a000000b002b6fc883ee7mr18945683ljc.13.1689181655034;
        Wed, 12 Jul 2023 10:07:35 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id f3-20020a2e3803000000b002b6ca539d92sm1046161lja.138.2023.07.12.10.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:07:34 -0700 (PDT)
Message-ID: <dbe04626-303f-3f4d-ad93-782b5e5128c9@gmail.com>
Date:   Wed, 12 Jul 2023 19:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys
 EA6500 V2
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Kjellerup?= <rk.katana.steel@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Aleksey Nasibulin <alealexpro100@ya.ru>, stable@vger.kernel.org
References: <20230712014017.28123-1-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230712014017.28123-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 03:40, Christian Marangi wrote:
> From: Aleksey Nasibulin <alealexpro100@ya.ru>
> 
> Linksys ea6500-v2 have 256MB of ram. Currently we only use 128MB.
> Expand the definition to use all the available RAM.
> 
> Fixes: 03e96644d7a8 ("ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2")
> Signed-off-by: Aleksey Nasibulin <alealexpro100@ya.ru>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Cc: stable@vger.kernel.org

Acked-by: Rafał Miłecki <rafal@milecki.pl>

