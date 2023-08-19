Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5EF781833
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbjHSIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344702AbjHSIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4A1BD4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:04:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so342943666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692432247; x=1693037047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deRfy4MmWhNo/qJGo68CHwTkl2+R+5alRlJweBHZEfs=;
        b=aCgvU0CiVM/aEDBPDLFu+sF3l8qpjC4PkigK2hLvR3K7RKhfJxz3HS/75ABvsvSWoN
         3rs+wNfGBianQpt1CpPz2wuk0SMhpaO4hNJVHxGUWCddxhtAjqehLYh2eeF6Cd2gfprt
         u99N5o2xA+OV9mkJEvHL8v9Sml9QxHE5RSYlEoG19qytqLjYIQrrBy0qzFM2unicwyLa
         mN/wOmmb8gJoRVSAd/vndrNCjmRKhfuPY1Oj6vJIcmhGH8NULGtsPXJiRwsfqQijm+12
         V21avF6ka3kRNfArK+MavM1X5UQ8aoJ14k4YvOe8lMxAi1ufEq9rfBchTMt6jERjp1tv
         sIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692432247; x=1693037047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deRfy4MmWhNo/qJGo68CHwTkl2+R+5alRlJweBHZEfs=;
        b=eeCLEawUWE8JjnwlfoWqLwRay9qHw4GqBG9n4LRc2ZWsDLUGkjFt4AL7ttjgh4lsWP
         umENavVVWjAZiETEaAZ4oeWaacEn3E0Sd9MeFQSL0bnl9cci6t+oeaJoctmJGHDXBzI/
         u/t+GjQut7FhmN58dfG3xrDmKbNSf2u4sYQ1eywP91WOdr/Z3vN7ZgiBNsehSQhyXswy
         B9FWaeKvk5LbXqtIbLoRlHOQeLcRfdHlxvi+I/hSbDL6aE2F/cQMhNk1IZXM25KnSlBn
         CFearvaY0nLHOxnxm9BPE0g6V7c73OhuULlkXHA4P0ppyyMQ6WO22NQOXgaztYEnuzL6
         cRKA==
X-Gm-Message-State: AOJu0Ywq8G0fMYJJRKcWmFcRTepccKsPlGuT5ny8qswgOGu4jIPnZi03
        tvOloCBwUcx+qp/PpGrELBmvyiiRbGZlSqQGN/Y=
X-Google-Smtp-Source: AGHT+IHBzvmTwnBZ67sD/6WjMdA5xmu96I7L2+RI5CGp7G/r5zU7hudwu/IAczFJtEBUGVFcm5NiSw==
X-Received: by 2002:a17:906:8a73:b0:99d:e417:d6fb with SMTP id hy19-20020a1709068a7300b0099de417d6fbmr1522299ejc.25.1692432247428;
        Sat, 19 Aug 2023 01:04:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906409600b009929ab17be0sm2265161ejj.162.2023.08.19.01.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 01:04:06 -0700 (PDT)
Message-ID: <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
Date:   Sat, 19 Aug 2023 10:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 23:06, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Rob Herring <robh+dt@kernel.org>
>> Sent: Friday, August 18, 2023 3:52 PM
>> To: Shenwei Wang <shenwei.wang@nxp.com>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Liam Girdwood
>> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
>>>
>>> Documenting the regulator power domain properties and usage examples.
>>
>> This needs to answer why we need this.
>>
>> It looks like just an abstraction layer to make regulators look like a power
>> domain.
>>
> 
> Yes, it is a wrapper that allows using regulators as a power domain. This removes 
> the need to add regulator operating code in each consumer device driver. As a power 
> domain, the regulator will be managed automatically by the device driver framework 
> and PM subsystem.
> 
> This is very useful when a device's power is controlled by a GPIO pin, which currently 
> requires using the fixed-regulator to achieve the same purpose. However, the 
> fixed-regulator approach may have to add code in the driver in order to use it.

Why do you start discussion from zero ignoring all previous history of
this patchset?

https://lore.kernel.org/all/20220609150851.23084-1-max.oss.09@gmail.com/

Best regards,
Krzysztof

