Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FCA75C667
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGUMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGUMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:03:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8130FE;
        Fri, 21 Jul 2023 05:02:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992ca792065so289145366b.2;
        Fri, 21 Jul 2023 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689940976; x=1690545776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZbhI1GsoZTB2+aN1G2ZV5zP+f/AEA/3Rk3e5+ibM3M=;
        b=WHLqxQ2tBj1HtoiIAGozmWDT3pqwSI9ZPscV/yqHqeBXBIGaISoHyLGFTKuSEpdiEd
         xSPqEz34k2bXn/H7zIxNpbN/+VVVVEa6NFRNJ914Fojd7p5VpnlgQGAZXYsU6LCcB5RV
         GhZf76mfDR7L9BP2SkEQ+BDHl6T/jGEuwRNLZku72obWaa33d1HUa4kFqzN7PNfTyOcx
         Inqe9ENg5IcJNWExgvkDtOfcvquQHXMGR63VI+kDRkqkC/8xYY1G7ycyEiBObUfN1/Rg
         KlRdH0W7v6Z/Q7VS+mt3lqQ8yHzQraCkf6dd6vUcsZcbrmY/kg3LqCpfJRWdWpbtKdrU
         04Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689940976; x=1690545776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZbhI1GsoZTB2+aN1G2ZV5zP+f/AEA/3Rk3e5+ibM3M=;
        b=CkzoV5e3ZJAiQtaIXMRjhw0gL5zxNsn+eb7u/YzV01GFFXfOYQq4HVFd2SNHt1M5Q2
         EBGajOXreLtxvJOlsfUDJdtEJjr/8RfDPtzcwTYkuHxVz83I90w4XiXejN4xPUumnisV
         kAJKwwhQEp+elZzsiP0zHpovjipZEPYUPhYtAyPBOFBxOcxYMZOqhkZpVZTTiM47vCWU
         gbk8bc7IflHW0hUzem2kkLwM+fuZ8zTLx9dHXs1kO5FaX2tnjsFHj7OoAzWmD492I3y1
         p0K6bCdp1LPnpdgRW440WLbk3xGHNgjiyEXUPV95/PMtUGrj5MrFXckIKv0r89kxV6QB
         +6Ew==
X-Gm-Message-State: ABy/qLapZDGu2SjDBViyYfPgQC+AgMdONMH30ymb6NZhDkHN4uzimQj2
        uXWN2De/m4LbqBDoFcX65YLy431VApgZSw==
X-Google-Smtp-Source: APBJJlFny/ksTXS0O2BmWy/enOxjFw5piUqacW0n6DyYKDvgKP9UnsPG+vv+keFxVcLC62ObkajTKA==
X-Received: by 2002:a17:906:304f:b0:98e:1156:1a35 with SMTP id d15-20020a170906304f00b0098e11561a35mr1501029ejd.74.1689940975947;
        Fri, 21 Jul 2023 05:02:55 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id i25-20020a17090671d900b009937dbabbdasm2065864ejk.217.2023.07.21.05.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:02:55 -0700 (PDT)
Message-ID: <3a1bd6c6-7b4b-6528-ba93-d05fd0e0e906@gmail.com>
Date:   Fri, 21 Jul 2023 14:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <9816cd272d19802ec6eeff0c7c29e85d4a0ade88.1689857295.git.andrea.collamati@gmail.com>
 <4898bc33-5245-8fb2-e5e6-8ea1a8f32e1e@linaro.org>
 <fe062725-e9b5-bcc6-d515-8e2d4989301a@linaro.org>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <fe062725-e9b5-bcc6-d515-8e2d4989301a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 10:22, Krzysztof Kozlowski wrote:
> On 21/07/2023 10:21, Krzysztof Kozlowski wrote:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        mcp4728@60 {
>> The same... Probably more comments were ignored, so:
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.

Sorry, you are right. I missed to change the node name.

{

        #address-cells = <1>;
        #size-cells = <0>;

        dac@60 {

could be ok?


Thank you

       Andrea


