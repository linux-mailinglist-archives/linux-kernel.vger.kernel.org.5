Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34676C442
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHBEs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHBEsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:48:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51391715
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:48:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3175f17a7baso5701462f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690951732; x=1691556532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjJtCSIaE4z1gTBV3LmLSA+S7jFNaTKZVUgbR4zn4AE=;
        b=gZ9cAemM/LAnnoTYDQzju9TbrdrKGShsctOXqB38YdhBBc/oO99pGXEJ5LD5t+7DzF
         dxVYcxkRjWUnPzHqQpS2IqMWHHWS1w/NWvEyBESaHuMQsa43dxDBRhbwoVwHr8EDztW/
         KWz6bj8m7Nx5ODWiZD/pB83aUkPt2HbAKqkSl5JEwuAW98gmEgYEb+aUL8bIs7p82Vuf
         /InMPxWzYmVpy9E91fXgev+I6pf1WVaeCqupwMvl24TGUooTQ+ksR1ijlSfXoYzlBNWd
         HnE948d83SJ29qlN7eXmiMENccr3hp97L4TMa423NzhBN9WpQ4lfQKh6NRHfdq5yn1cM
         zWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690951732; x=1691556532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjJtCSIaE4z1gTBV3LmLSA+S7jFNaTKZVUgbR4zn4AE=;
        b=diVdWPeug6R+y9tubu7TgOHqBfiZlTBa5aT08X4NJijli6cq9Ch2e4i6yk6Z4mp4cq
         47JD/B3rORbzkKpiS5P/GzDnBo3NpsK6DohQTWGcREKUd5mhPaAXN8IBH+SRVBAG/0J1
         KYs8OhUK4VrU4xzlx878QiDPhU0HfOCA5FGJLlD1c2JptEkqcfhM7ypI4FLb2K0aCf85
         LeBN5V8h8nZWtdlQCFbc89QbtjF7PpLaQ80LRW4FcKZ63arRju1QoFxmzzok2ZlsRsKW
         CJNbV3xnalZZSUcxILXfMuRO1TAkO2wWjqBZOdRochjVy/ZWj/Qq8QS4eO/FyWtveQfg
         Cwug==
X-Gm-Message-State: ABy/qLakk+Fidh0GLCoUYFVX9tXprDuopd8mAsHb0n6TIo0usvpTAEXc
        hUTjXnVOuZjCLCnroTRQoKh1OA==
X-Google-Smtp-Source: APBJJlEFC4p/oFNc/0dVuSSAFXjiCLCfa4XcSsdjyRjRBHYW42+kBjPNFCiWPYXWMKwwsMMRhnsIog==
X-Received: by 2002:adf:d08f:0:b0:314:2ba3:15dd with SMTP id y15-20020adfd08f000000b003142ba315ddmr3286827wrh.16.1690951732341;
        Tue, 01 Aug 2023 21:48:52 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b003143867d2ebsm17809975wrn.63.2023.08.01.21.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:48:51 -0700 (PDT)
Message-ID: <d0943633-6463-0f29-55f1-8af895a50e21@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:48:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91-vinco: Fix "status" values
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230626221010.3946263-1-robh@kernel.org>
 <31e4da6a-44ab-5c0a-ae32-c0fcf09d7cb8@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <31e4da6a-44ab-5c0a-ae32-c0fcf09d7cb8@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.2023 19:37, Nicolas Ferre wrote:
> On 27/06/2023 at 00:10, Rob Herring wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> The defined value for "status" is "disabled", not "disable".
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> We'll queue the patch in our tree (and linux-next) soon (tm).
> Best regards,
>   Nicolas

Applied to at91-dt, thanks!
