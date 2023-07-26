Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EB7632E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGZJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjGZJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:54:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599594498
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:53:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bccc9ec02so33859266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690365193; x=1690969993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDfJrRlEZ4V1vWpDr71CzAPwfG2N8C7OoZPxnrIGDN0=;
        b=IaAsaLHEIl1jINRpLGgf37bvPj0OhxGvcXq9DwyzQSBkydRzH5grsNjq0neOZXIqCi
         02grZlYS52Z5tDXdSiXwyUYTJ3T5S9nC6/Ffg3/i84jYAaDenx3FUW8oJTawgaeKKM8F
         7mkwViX0ouNy/3caNJJrSGreeJ3yWM+yE0usZTUzW6O1TQGF5weyf4rpIyoorSlA/nHx
         WmIFAj+P+hZ8VAsLk3+SOaZtYBoFPqemLkt6oY+en+JsLwZVYHc+SjzQQfTDaQU9I6RA
         TzF3rDwMGnOAPHxpZbMxSx6rtxD3QySheRW4JhZpRVU8i0tZmtBgwYuhBR7J0yAxodJQ
         lasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365193; x=1690969993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDfJrRlEZ4V1vWpDr71CzAPwfG2N8C7OoZPxnrIGDN0=;
        b=EEdmt3gQQRt+WEmc6XuCR/0+/pTm1XdgtXPYO0FdVbqA4hjt3QxjSbCiDPD+R8CVtP
         N7Npus7hn8UPr/xarSQiQPIXJbhE2WsKkEkudEvqDdZEsK4yGrY7NlMMahTufXfb0wAD
         3jez9lPBf37sL5l3FR3k4cEEi900qiiAHwQUlTawAvnFvniYv7qP72B+ZFg/05YM4RFx
         AkqUMDYsWDYUk+YFTXJR1BfuxcpWxv5p10Yw671UBCRG5Y7TGz/+gdFZpWp4ya4KsDYl
         4nhjtk++lklGB3qE8+Z1K6/WpNPKntDFhEIg3J3Uabyi5YqcjiY1heUHcsTwRrECbfdc
         Dnkg==
X-Gm-Message-State: ABy/qLZTkqZIWlpCd4E2hwVvXc3B+lCMFluxit4/x6soe5JNcSGtB/iI
        N8ds0y3h5yW6hhTxz5Osbm+lEg==
X-Google-Smtp-Source: APBJJlFRNf4dsFC6kPOurV5xtM2BXphDVp0mTKZCHvbqZVI5fzzMQUwmOKozZvFQpIkMBFiDSN17XA==
X-Received: by 2002:a17:906:74d4:b0:992:a31f:f584 with SMTP id z20-20020a17090674d400b00992a31ff584mr1291707ejl.31.1690365193171;
        Wed, 26 Jul 2023 02:53:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090611cf00b0098963eb0c3dsm9269836eja.26.2023.07.26.02.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:53:12 -0700 (PDT)
Message-ID: <dca2c683-0049-4bd2-3780-37f334ba6b03@linaro.org>
Date:   Wed, 26 Jul 2023 11:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1690355592-10920-1-git-send-email-alina_yu@richtek.com>
 <1690355592-10920-2-git-send-email-alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1690355592-10920-2-git-send-email-alina_yu@richtek.com>
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

On 26/07/2023 09:13, Alina Yu wrote:
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>

Thank you for your patch. There is something to discuss/improve.

> +    
> +  richtek,mtp-sel-high:
> +    type: boolean
> +    description:
> +      vout register selection based on this boolean value.
> +      false - Using DVS0 register setting to adjust vout
> +      true - Using DVS1 register setting to adjust vout
> +
> +  regulators:
> +    type: object
> +

On this level of indentation:

    additionalProperties: false

I think I missed this in previous versions. I am sorry.

Rest looks good to me, but this needs to be fixed.

Best regards,
Krzysztof

