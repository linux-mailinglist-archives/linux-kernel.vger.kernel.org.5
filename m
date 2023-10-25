Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F77D6213
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJYHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJYHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:04:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19080CE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:04:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso777528466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698217451; x=1698822251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISx9XF0jymKJbKBV7VQC9cj9x5oOl7s9JRVjqaQ3WiA=;
        b=hOSlbCHg2gQRWRlb8LnsRu9j7r5uKTSOvVvhw4bjIpxnAuX+GWvGzyu4BzhU8sGUCg
         fWAwemftRa1EjjUQmQTaJeGLifAq5AAWhdbik7lJx8vqVua2G9gIvUu5aSKXSjsrK6OI
         x6atel5BXlil0vDha+qzohA+lx8s6F+VZAJrjIeBWhctwWnox+jLHwXctXtERDk7mPAS
         o4/wqUN3o2n9P0LGFAXRJHZqiEOOUGRLz2Xa8CrJJeA5ax6F6U5mljJkoXwFv+1R/Nlf
         tLiXHKD2fwOLU934asZdYSqiLWouyR+oAbiG7EXiVd+1o4LXUIXgRZ4T8HGHWaToQXsW
         3Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217451; x=1698822251;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISx9XF0jymKJbKBV7VQC9cj9x5oOl7s9JRVjqaQ3WiA=;
        b=hbAJMv9c2S6KX+TUwzTiW1u5oKpBbbegww6zwcnTqvnmU8oUIlkv/3nY6LCinmq6zq
         iXPOLYEXMdHQ+OV16D+/nT5Ixi3TFCmLOYxnWUiGaZo/46TiOzh3pJxug9BABkiWD4R2
         n5Tu+fTF1Ok043PAZMgpo7tYr3W+db6tpXPKmlnohC62YH3RBJ2TcrvFO1U7V8tSwcU9
         Sz0aZOpXQp9AkrhK1A7pIxpYSsY4xNxFLzDkHWXdaWNVo9i3BBxWGVce5oJ8cjjZtobC
         SjZ68OCNUblguqsWGgYwth7BN5LYCEctej3wb4sjGrotD4BPH3H1M8yIYsxhGxeWKOpF
         1M5A==
X-Gm-Message-State: AOJu0YzI3/B+zlASByWRiC3SlmwDGjKOHYY0RnH3WnLCeqTwhNHjRmxU
        K+cZbCCciLUKlSNZzTAKzMQGeg==
X-Google-Smtp-Source: AGHT+IHl7TXiNgbxL/lFXemZ/HH/QB5tELiJpzblrf3+E9x+fD02+qxXiz919I3FzUwr8d30ZQD50w==
X-Received: by 2002:a17:906:4784:b0:9ae:4f9e:7813 with SMTP id cw4-20020a170906478400b009ae4f9e7813mr10078085ejc.73.1698217451553;
        Wed, 25 Oct 2023 00:04:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b009786c8249d6sm9576921ejq.175.2023.10.25.00.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:04:10 -0700 (PDT)
Message-ID: <2a715a8a-c4c1-42ea-9159-15f25338d36c@linaro.org>
Date:   Wed, 25 Oct 2023 09:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c
 codec IP support
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
 <b94e3561-f5ef-443f-98c7-9b79a8bbceec@linaro.org>
 <20231016134720.GA2650973-robh@kernel.org>
 <20231021120526.eqe3esyxyi5b3e5d@basti-XPS-13-9310>
 <3d465d3c-386d-467b-87e9-806962464ac5@linaro.org>
 <20231024051745.d663ekj7klrl4yzj@basti-XPS-13-9310>
 <7240fa39-1a8f-4338-b5ae-b469dfaeb7e1@linaro.org>
 <20231025061713.kmmu432q76t32iv6@basti-XPS-13-9310>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025061713.kmmu432q76t32iv6@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 08:17, Sebastian Fricke wrote:
> Hey Krzysztof,
> 
> On 24.10.2023 09:24, Krzysztof Kozlowski wrote:
>> On 24/10/2023 07:17, Sebastian Fricke wrote:
>>
>>>>>> It needs an SoC specific compatible (TI something...) as well (or
>>>>>> instead). Unless there's a public spec with details on how many
>>>>>> clocks, resets, interrupts, etc. there are.
>>>>>
>>>>> Okay so how about this, a bit similar to the Coda driver supplying both
>>>>> a general option and a SoC specific version:
>>>>
>>>> Can generic compatible be used alone in board designs? If it is licensed
>>>> block, then most likely you want a fallback.
>>>
>>> Alright, so a fallback seems appropriate, how do you like this?
>>>
>>> properties:
>>>    compatible:
>>>      items:
>>>        - enum:
>>>            - const: ti,k3-j721sX-wave521c
>>>        - const: cnm,wave521c
>>>
>>> Providing a fallback and adding a enum which can be extended later on.
>>
>> This looks almost good. I wonder what is "j721sX" - Google does not find
>> it. There is thouhg j721se.
> 
> Well that was a misunderstanding from my side I thought that both j721se
> and j721s2 have the Wave5 IP block and wanted to describe both with
> j721sX. But as it turns out the IP block isn't present on j721se.

It does not matter. You must not have wildcards in compatibles.

> Additionally, I was only able to test the codec on j721s2 for now and so
> I would opt for calling it: `ti,k3-j721s2-wave521c`


Best regards,
Krzysztof

