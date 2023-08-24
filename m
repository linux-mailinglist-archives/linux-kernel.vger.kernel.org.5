Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F23786C84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjHXKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbjHXKA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:00:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7C1BFB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:00:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bed101b70so851509666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1692871227; x=1693476027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKnkFU4cj38+MIuwqAfBBskvg69vCe9QhbSaiCRs2HU=;
        b=h0qusRSUEEBdiAvR19pmhPN+SinHeiZYOO2HIusQEtVd79XJFkjK+KZeFVIk9vOtdE
         hlC/04bo/wXq3/zz0iXhkz0YzS0CWf3K8hRrwsfbHkZKCDlPEhcFM0x3LG7ziq9hf320
         06jSMwrsJNKwEdEBPqGp2i0iELy+/E5MZCjw/VZz7SsV/INm0vJ1fIjEqMaNxvi2kVTU
         QqxnpYVw9G9Z6f5q5vbFXfCPAxYjBYVF/pODRbI93uqkzQDohL26YZLjojQB7SEypJpj
         eHIKwOPrVHJtjrMZYvH8zBA1PvgWWq/FgeZHnhWqO8hST4hHY/dSVWXVarU+eYAyPV66
         muHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871227; x=1693476027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKnkFU4cj38+MIuwqAfBBskvg69vCe9QhbSaiCRs2HU=;
        b=J08maEzF2cLFFhxgmUwiay5tqW1Ejo5U8kC4W7OoWnkYyODt11mG+5pNYpqiap20R8
         XOQq5QYazcwxggwti72bdP+vT7z6uHMik9Yt3den9KILinnAS8LwPNMAUJHEcKnxnBxs
         CUHZnXA5zLrdY9eoQ+bqgPq2JJQTWTFbOy3WsYG4iyNQOGe4YeqjD6LR0md76WG822jI
         GWCWsp5TSzqjyWJPNJffUpkZDSAfncuOnAoZZ0rCNiScWyiADg2DzTYGSggM/HFlu4xh
         iJsbBIlpdWszXy+6A9x8OaGdF6mvhZ2ICKBkyqcUJm2JJ/YJWrjT0S5m0EMweMJ622bt
         U73A==
X-Gm-Message-State: AOJu0YzP5Bwwbpx9tO5KaZ8aNJ8hnQY6t4GX+gLgLdP1akBalCqkVPJE
        u5DGaUyQUcK9JiVHMgcNpY1OIQ==
X-Google-Smtp-Source: AGHT+IHic+3v6nUdmcVlrJmXtfk1We8CUWU7iAskZC7w3ZUBrxa0tjb2FB9LW8Wm7Y5LO8bBnF9xyA==
X-Received: by 2002:a17:907:7617:b0:9a1:d79a:4193 with SMTP id jx23-20020a170907761700b009a1d79a4193mr3425473ejc.23.1692871227483;
        Thu, 24 Aug 2023 03:00:27 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.1])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b0099d0a8ccb5fsm10754605ejc.152.2023.08.24.03.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 03:00:27 -0700 (PDT)
Message-ID: <e7136b58-f48b-ff9a-8831-57a905bc0465@tuxon.dev>
Date:   Thu, 24 Aug 2023 13:00:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add tx-internal-delay-ps
 property for port5
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230727080656.3828397-1-lukma@denx.de>
 <20230824111702.1a034801@wsk>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230824111702.1a034801@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lukasz,

On 8/24/23 12:17, Lukasz Majewski wrote:
> Dear Community,
> 
>> Without this change the KSZ9477 Evaluation board's Linux (v6.5-rc1)
>> shows following device warning:
>>
>> 'ksz-switch spi1.0: Port 5 interpreting RGMII delay settings based on
>> "phy-mode" property, please update device tree to specify
>> "rx-internal-delay-ps" and "tx-internal-delay-ps"'
>>
>> This is not critical, as KSZ driver by itself assigns default value of
>> tx delay to 2000 ps (as 'rgmii-txid' is set as PHY mode).
>>
>> However, to avoid extra warnings in logs - the missing
>> 'tx-internal-delay-ps' has been specified with the default value of
>> 2000 ps.
>>
> 
> Gentle ping on this patch.
> 
> Claudiu, could you pick it as well?

It's already in arm-soc:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/arch/arm/boot/dts/microchip?h=for-next
