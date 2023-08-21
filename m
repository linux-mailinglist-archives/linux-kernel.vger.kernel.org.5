Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D297828A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjHUMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjHUMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:10:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A39CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:10:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99df11828c6so910633166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692619841; x=1693224641;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zgyeh0+BcUge5Xs63pWfi9O1N4Lce2BqQDTQMQGycQw=;
        b=B0GwywUNYS15b3HQ2ymhth8kUdVhCPXuyCmtNZUxA7cramZcMK/2vk7d8xemy3q6C9
         LkKCsGSh/nanX9sIAq9A6aDDRmcYQ+ZiZZ72jY3XRqem20g+fohKDAR53SkZmTdpTETI
         yt4EZDUDBUDRA5p2Q4meK1kRn1+yL7Phcd9v8isWLQbIBZue1HySGtOeytToomljLH3O
         rnNgybGAFii3GR/L00LxeML+1FEP6RL2eudxY1Qnbx3FdpK86XgQiqFb6fnrlC2H/DTa
         xw46kUplNsaudcK8M8qE09E0OTTFq5MxqVnywRzGWlu7lub4QB9vlxx4Yy42hVM74dlg
         gMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619841; x=1693224641;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgyeh0+BcUge5Xs63pWfi9O1N4Lce2BqQDTQMQGycQw=;
        b=fFvVINsKUoTU/37w56+fwOC8y3u9d4Iri0vMumcm0n6ApZNzl2QqKcn9mPIt214ndy
         tcRyMlEemRR0fL9XUsscoQRB9O8tfEpTuh/sni5wuQ+UnQd8kBKGowTZCDkLQVAEHpvx
         UVyAFdO/EQFrdGCMmmIOADVOSKKsIbeOYc8ya8Cw1JozG8mFV2g9PuJOdzcpj8Sdjc+l
         aXWG0k05hWMpxiTz9GhAi5aN/ePhVeBIM1srFuGUXtvGQKvBWZsuN6tuFrWBc0+xLXyK
         ks3IRosr802lJCunAPdNb57/sQZKu3l93yBqtXctmj7dHHN8y5uMs7e2IFYAA0mBWWFA
         qT7A==
X-Gm-Message-State: AOJu0Yx3EKwUMzkhR31Az5gl3zjTt+i+Nn8Fg0V3fMegSWui6u3nKvq/
        4BrftZJxxZ4eC1ICqwUY6YNgkaMW2V9ORHvdsig=
X-Google-Smtp-Source: AGHT+IFiIFBmq8AqPH6QBF89FGM9mWhy/gEiTsM/x/nlMwGx0Frl4eRYT5aqAu1p1vTLC9KY6xwPXA==
X-Received: by 2002:a17:907:3f93:b0:99c:572:c0e4 with SMTP id hr19-20020a1709073f9300b0099c0572c0e4mr6492758ejc.7.1692619841399;
        Mon, 21 Aug 2023 05:10:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906134600b00992d70f8078sm6487484ejb.106.2023.08.21.05.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:10:40 -0700 (PDT)
Message-ID: <5235260c-8fd6-2b2a-58b9-703191fff526@linaro.org>
Date:   Mon, 21 Aug 2023 14:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Varshini.Rajendran@microchip.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
 <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
 <37782447-43c7-50f9-b9b4-5fbca94ce8c6@linaro.org>
 <96033a59-a2ea-c906-a033-84119c5783d7@linaro.org>
 <adeed0b2-e09b-78cf-ebfd-08d3949ca9ea@microchip.com>
 <57e9a9ff-26ed-62d1-91f8-cd5596f1c308@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <57e9a9ff-26ed-62d1-91f8-cd5596f1c308@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 11:54, Tudor Ambarus wrote:
>>>>> I am aware that there is no change in the crypto IP used. This patch is
>>
>> Actually, recent history showed us that it's not only the IP itself but
>> its integration into final product that could have an influence on the
>> behavior.
>>
>>>>> to add a SoC specific compatible as expected by writing-bindings
>>>>> guideline. Maybe a bit more explanation in the commit description might
>>>>> do the trick.
>>>>>
>>>>
>>>> So you add a compatible that will never be used just to comply with
>>>> the writing bindings guideline?
>>>
>>> How do you know that it is never going to be used? The guideline asks
> 
> See
> https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/tree/drivers/crypto/atmel-tdes.c?h=at91-dt#n1120

What's there? One compatible? How does it prove that it will not be
used? It only proves that currently it is not used... And anyway this is
just one implementation in one system. How can you possibly know all
other possible implementations (other bootloaders/firmwares/systems)?
One cannot. The guideline is there for specific reason.



> 
>>> for this on purpose, so any future quirks or incompatibilities can be
>>> easily addressed.
>>
>> In this recent case, having a an adapted compatibility string is an
>> added value.
>>
>> And yes, I changed my mind and would like to be systematic now with
>> at91/microchip DT compatibility strings. Our long history and big legacy
>> in arm-soc is sometimes difficult to handle, but we're moving little by
>> little to comply with guidelines.
>>
>> My conclusion is that Varshini's addition is the way to go.
> 
> Ok, fine by me. Then it would be good if one adds compatibles for the
> previous SoCs as well and add a comment in the drivers that inform
> readers that the atmel_*_get_cap() methods are used as backup where
> "atmel,at91sam9g46-" compatibles are used. You'll then have all the
> previous SoCs have their own dedicated compatibles which will have
> "atmel,at91sam9g46-" compatible as backup, and "sam9x7" will be the
> first that will not need the "atmel,at91sam9g46-" backup compatible.
> In the drivers you'll have 2 flavors of identifying the IP caps, the
> first one that backups to atmel_*_get_cap(), and a second one where
> of_device_id data will suffice.
> 
> If the commit message described how the driver will handle the new
> compatible, Varshini would have spared us of all these emails exchanged.

The driver does not have to handle the new compatible, because it is
independent question. Although if you meant to explicitly say that
device is compatible in commit msg, although it is obvious from the
patch, then sure.

> Varshini, please update the commit message in the next iteration and
> describe how the driver will handle the new compatible.

Best regards,
Krzysztof

