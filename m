Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598FB779F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjHLKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHLKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:48:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3F62D54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:47:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so4186586e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691837278; x=1692442078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGcrVf003yK2erEWEoiIkw0tjzg3iatGlyB30FwyTjw=;
        b=Xobh+OykBF6XBlMT3nEpKT52NjlOvlbQuCzXw9dSJq1LCsStcp8V/jMkVABlrvq1EL
         BSZvnLKdZfvjjMgOgXmtUaL+O5CN+A9RrJkCkmfzsF+vXN/jnLNMmLKGjUjEiIL1nA9O
         APeM6ft6yYrp1X3JF5Ug9sLNBRRQiaXMfxyDB4LwasBZnDIds9UsfsUQ3hmaEzPH6m2S
         t72u+kJg+FnH5cGgzzlFArZ49ymjLWzAkya/a+PHRXAUcbVGFh6Svedp0aV2+EDa9sEb
         3cN+DaTelz9YQ0oQPf7j0vohxTvfoeDjh60/VyBJVVgQaYIzzMdWvCIw2awtIxzt5kZQ
         yJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691837278; x=1692442078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGcrVf003yK2erEWEoiIkw0tjzg3iatGlyB30FwyTjw=;
        b=dFKnsLmLSXZOfvd+IE5LWv9WzNYb36ypIxTH8lQ6A3qOV9xJK08gAXW8YlG+hQiWxf
         Le/z8zKkMJ2WEAWYxxpq0Gvfmsh2dy7R2J1bEOk4RtOfhDff/UU26MfTLOLEk9euxW06
         sYu539/b6fS3voWsU3LqfA905Sibg1NgpamoXjP8XV27ygU2a/S/Bvo4L23R0x24MbJT
         zlj/yePJuu84w53OZJERToYRLQL0zb2w/XzZpF1v+SykSC6AWD5ijluDYsDaPQIW7O1A
         P6eqW9Wp9+7Pt6dZnLT/J68LZvGfHv0i9WQOD5Jpzn8iZlHLON4NzfFR9HYIN4o1owMT
         kh6w==
X-Gm-Message-State: AOJu0YwXLzIFuRef0UzzJCf7dMZGupSK4fff1LnI3npQ2sb9xzV1N1Mr
        bKLNqNShXmcUOgcwcIlvPDciYw==
X-Google-Smtp-Source: AGHT+IF+TI4Q250JYkV7gz7PaIqFFpXovCnn6y2ru/ac9wJEvLFdV3dA7igEiIMqIrdc9Cx1Z+/QhQ==
X-Received: by 2002:a05:6512:2202:b0:4f8:72b6:eae with SMTP id h2-20020a056512220200b004f872b60eaemr3998046lfu.40.1691837277677;
        Sat, 12 Aug 2023 03:47:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id h9-20020a197009000000b004fdd6c37e9asm1076108lfc.112.2023.08.12.03.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 03:47:57 -0700 (PDT)
Message-ID: <e784f70f-3232-42e6-bf4c-67075abd210a@linaro.org>
Date:   Sat, 12 Aug 2023 12:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811210142.403160-1-robimarko@gmail.com>
 <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org>
 <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
 <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org>
 <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2023 11:55, Robert Marko wrote:
> On Sat, 12 Aug 2023 at 00:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 11.08.2023 23:35, Robert Marko wrote:
>>> On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> On 11.08.2023 23:01, Robert Marko wrote:
>>>>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
>>>>> as they should be under the partitions subnode and use the generic
>>>>> jedec,spi-nor compatible.
>>>>>
>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>> ---
>>>> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
>>>
>>> Hi,
>>> I grepped the vendor U-Boot to make sure it's not being triggered off
>>> the mx25l25635e
>>> compatible but the only hit is the IC support itself.
>>> MX25L25635 was just the original NOR IC Qualcomm used on the board so
>>> to me it made
>>> most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
>>> compatible.
>> OK if dynamic identification works fine
> 
> It should work fine, datasheet is clear that its JEDEC compatible.
> That being said, I dont actually have the board, just figured it was
> time for a cleanup as
> OpenWrt has been patching DK01 and DK04 for ages.
Hm. Do we know whether there are still users of this boards?

Konrad
