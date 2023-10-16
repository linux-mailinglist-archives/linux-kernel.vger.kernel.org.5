Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5917CB4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjJPUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:43:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5289B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:43:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4494036f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697489011; x=1698093811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fevs8BaTUhicnuhgMWvL8W6tYhBEVRYenndQa8o+8OQ=;
        b=SU2DNDwsbk2BrA+02VSwkRnIcHckNyY9fT9q5VH54QbrDvM+O8Ev2LDbVmwFRFo6Dx
         fmRwsCembGMm3M45BA5QnOPNw0iCN+KiWDdBTKU0TqYhFBUAbqc/LdrNFv3OvAuXZvTY
         90VD6u7X7I6BISQNcRIQRVk/gtt4jhbR0GOg6yxHO+2Kh8D3SkLNkwshklYQmV5Yv62T
         qh9NO6r1YLEvHyajXRwmNb02ou6OLUjTh54QPzetZ5u8ZMbRR+aPPnMBO9Ltsn3otN+u
         Y5BrbLoJuDBXT077KaKMZQDb+WLGRaZnIIRO3W25j3c0Yh+OBqjvvTS+Wtpaa3uXHz4h
         Cs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489011; x=1698093811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fevs8BaTUhicnuhgMWvL8W6tYhBEVRYenndQa8o+8OQ=;
        b=Z3up81HzOrdlkZTTiR5dF2cSpfD3bEeRrsbrzsikTIGcBcjzelPrQEgGI88tpk51ZS
         nPAnXFmwcXFZLhGwBHabRLy9n1MTBsO9l28C7mQtjnoFkjlNZokM3J4DEVD6n1vVriV7
         7ZTjwB9CZVm/pQMu+kqiRpnKkOoPOLbLqxdiT4ksAE38myZyfbpmJTbJ0F70Bgbdih/K
         HW2emSO1Odw4p34k32XnjGBXpWm/Ipu3C+rVU/d6rgp1tSWNVWBGdgeZAkP8d0CQQg3q
         WFTob9f+7h+jiRnj1eRhJQSU5BPEWLwSp6LEBIPPcXneJ1W6xBiaKqKeRB8Xfb7r8Y1j
         YDbA==
X-Gm-Message-State: AOJu0YxT6i7UB8UABPOlPKtewlfKdcudjlc0AD7tezwaj0HYSRLTlsVt
        codL0L3KFDxMfpHOWjSWVTTLDQ==
X-Google-Smtp-Source: AGHT+IHALU/OrOrRzIG4eX7sHgu3cnTrX+LATpL8rpcRy8i9fKR9N3T53+IuWU8XxZY1N6EZ1bx8yQ==
X-Received: by 2002:adf:f40d:0:b0:32d:a2c4:18bf with SMTP id g13-20020adff40d000000b0032da2c418bfmr371254wro.59.1697489010947;
        Mon, 16 Oct 2023 13:43:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d6388000000b003247d3e5d99sm114174wru.55.2023.10.16.13.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:43:30 -0700 (PDT)
Message-ID: <b5d3b52f-f551-483c-a4d4-763130b48fe3@linaro.org>
Date:   Mon, 16 Oct 2023 22:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Fix silvaco,i3c-master compatible
 string
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     Conor Dooley <conor@kernel.org>, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        joe@perches.com, peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        sherry.sun@nxp.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
 <20231016-chatroom-regulator-a75f1d8be809@spud>
 <ZS2Pz1HxUgrx4+0R@lizhi-Precision-Tower-5810>
 <6110c58a-8003-4889-9a4b-6a7d1821c00e@linaro.org>
 <ZS2Y0YRPItYhUBXE@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZS2Y0YRPItYhUBXE@lizhi-Precision-Tower-5810>
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

On 16/10/2023 22:10, Frank Li wrote:
> On Mon, Oct 16, 2023 at 09:57:18PM +0200, Krzysztof Kozlowski wrote:
>> On 16/10/2023 21:32, Frank Li wrote:
>>> On Mon, Oct 16, 2023 at 06:30:11PM +0100, Conor Dooley wrote:
>>>> On Mon, Oct 16, 2023 at 11:24:49AM -0400, Frank Li wrote:
>>>>> In driver, compatible string is silvaco,i3c-master instead of
>>>>> silvaco,i3c-master-v1.
>>>>
>>>> And what makes the driver right & the binding wrong? AFAICT, this is an
>>>> IP sold by silvaco & the -v1 suffix was explicitly requested during
>>>> review of the binding.
>>>
>>> The driver existed for the long time. DTS files already use
>>> silvaco,i3c-master.
>>>
>>> There are two options, one change doc, the other change dts and drivers.
>>> I think change doc is easiest ways.
>>>
>>> If there are v2 in future, we can added silvaco,i3c-master-v2 in future.
>>>
>>> If everyone prefer change drivers and dts, I can work on new patch. Just
>>> break back compatiblity.
>>
>> No, because Rob explicitly pointed out too generic name.
>> https://lore.kernel.org/all/20210111200821.GA2978830@robh.at.kernel.org/
>>
>> Is it some way to avoid implementing feedback or how does it work?
> 
> Downstream use silvaco,i3c-master to match driver. Anyways, miss match

Too bad for downstream.

> happened.
> 
> option 1: fix doc
> option 2: fix driver and dts
> 
> what do you perfer? 

Fix driver and dts, keep existing compatible as deprecated.

Best regards,
Krzysztof

