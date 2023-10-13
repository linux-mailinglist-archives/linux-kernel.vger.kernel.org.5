Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381077C7EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjJMHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJMHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:44:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A8BF;
        Fri, 13 Oct 2023 00:44:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so490218b3a.1;
        Fri, 13 Oct 2023 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697183087; x=1697787887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqBTcnUOXt5OHFJjY+Q7SG+N2WHaqyyhi4YSnip+8v0=;
        b=Qn5oCKsmnr6SHYEFlZVy2naSYslWXccXiq1+0zLs0ppcEo/g6dSTuucH0S+m+OjaNz
         HBCr74uviX3Zmkq/igIPTD946LeIQB5a0qyS5GXZm2M1Dvpene/YnN5/+sgVDRrYYI4G
         mYa9tW9YWXsd6YHXzyLpOx85vZjOfIop4bjtVXSUuGxabZ20HJDIr7PVZnIGCY5rhOcv
         neYGkiKkB7grhYJTcw6OuIAdWsRtNR0kNu3N+yY9dWN1Lwnyb9sPGkGA10DqF2cywOf0
         8HYWIgGA7rw8VO6LJUXuglkfHX2kqvb8QTU1Dm/pIm2GPjgUsMG43LJytPwpkcJWNSEL
         38Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183087; x=1697787887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqBTcnUOXt5OHFJjY+Q7SG+N2WHaqyyhi4YSnip+8v0=;
        b=lbVbpaRYFTGwmhI/XwTu8zmki283YzuoEPhWqeL5XKYWzt0FAIZM/rYkUhIr76XI5/
         dYNCcncnltDDgrgQrUR58rZVCxjAVuJq/d2u6ao0+y9BRny/51Jh2irpBy/GPL+Ly2zz
         EzfzGzNbTb/1P+SvGeySjbgRYJA++C3alyae0KT3W1MtQOvKMJeegJIm0v7EY3qEFwHN
         MAQMqeeJE9bqh0+QDL7dFFwX+B258BZilKX2cJyRYFzYQW1hG/5bKo+Pg2NiEiri/9JK
         u/onj4Qm14fhpSvrUN1S+cOKHeSnm6U/9REG2fUwqObPqGPDok0an91XbWyjfY/qFLPE
         3QLA==
X-Gm-Message-State: AOJu0Yz7D9Vi5sbePORWRTDmyvnFZIjuAjXcP/dJRKnaES0BO+BjC1m8
        1uJDKctbsNrXN4Es9/embmnjD6QYHPk=
X-Google-Smtp-Source: AGHT+IHWWgk1zmQhykDCekt0aGL7OS4rB/SGDK7iEV5xnq7IIWvi8IxXalAeKUjv5J2lc05leLCvKA==
X-Received: by 2002:a05:6a00:9a2:b0:68a:3ba3:e249 with SMTP id u34-20020a056a0009a200b0068a3ba3e249mr31611101pfg.16.1697183087186;
        Fri, 13 Oct 2023 00:44:47 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z125-20020a633383000000b0058a381de499sm2839266pgz.77.2023.10.13.00.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 00:44:46 -0700 (PDT)
Message-ID: <c7419e6e-d53e-4820-83da-3ddf188e8fd7@gmail.com>
Date:   Fri, 13 Oct 2023 15:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-4-ychuang570808@gmail.com>
 <9a831a6e-ab5e-4911-8011-f6eb82dd3d6a@linaro.org>
 <507e491a-e40f-47e2-8e11-5a7886a8c2ab@gmail.com>
 <420f9132-b277-4476-bd74-9cc4cd87456f@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <420f9132-b277-4476-bd74-9cc4cd87456f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/13 下午 03:06, Krzysztof Kozlowski wrote:
> On 13/10/2023 08:52, Jacky Huang wrote:
>>>> +
>>>> +&pinctrl {
>>>> +	uart0 {
>>>> +		pinctrl_uart0: uart0grp {
>>>> +			nuvoton,pins =
>>>> +				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
>>>> +				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
>>> This does not look like generic pinctrl bindings. Looks
>>> over-complicated. From where did you get it? Which recent bindings and
>>> drivers where used as an example? Register addresses should be in the
>>> driver. Bit offsets as well. "multi-pin-function-value" confuses me. All
>>> this is not really suitable for DTS.
>> Okay, I will update the first and second items to 'pin bank' and 'pin
>> bank index,
>> just as others have done, and leave the driver to handle the conversion into
>> registers and offsets.
> Instead use existing common properties, like "pins" and "groups" (or
> pinmux).

I will reference how others have done it to make the changes.

>> The term "multi-pin-function-value" is used to specify the device function.
>> I will use the name "device function" instead of "multi-pin-function-value.
> Use existing common properties, like "function". Do not reinvent the
> bindings.
>

Okay, I got it. Thank you.

>
> Best regards,
> Krzysztof
>


Best Regards,
Jacky Huang

