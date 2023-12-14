Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD06812E04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443843AbjLNLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443832AbjLNLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:02:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10F11B;
        Thu, 14 Dec 2023 03:03:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso9287074e87.0;
        Thu, 14 Dec 2023 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702551782; x=1703156582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wu2c3DwVvYEQBllF+/J+S28oH/5LztrNNWHtWraW0sc=;
        b=UeNfZ/sjAcHJwE47q13oEhNa/P1qRCcN5zfyQMKC6CQV3p8qL5aDiaLeWywD7vB5Bv
         n5W+at9asoyRx0ncRDqrNvAkotWsvks9N6ETxWiyMZMr5RKiaH4KZi5WAAKkhdGXTT9J
         tML7SDpaCgYD+y7qVP0+eU65tHVj1BqbDDldyxqAcQTW1ECshRAbTzw3+rpdB5o3IQlT
         lI09BzNezUDvC4bTTbGMsOVkWxy2HWDs9nBpLbzAwHnYkjAoJajFB6+KQs41JRvrQYT8
         f/SMWM0RIFk2Yy8zvydFWARD0T3EoKA/hLtW1SqmHOicAJAmppbwKykC2ao0Cowcp/5K
         NA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551782; x=1703156582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wu2c3DwVvYEQBllF+/J+S28oH/5LztrNNWHtWraW0sc=;
        b=pukQQBoUdarLuqRiLUXlskQ63rls/As9kkhHA5YK9bKRHlO5vbbUD6TRKwy37j//5R
         N2iTWqeb785le7WHdJY8wrKKr4vrEW/RqD29Nb5sGY4G13FKi1OlwtxJ7AqWlmo+42Db
         NiwM+tjLEpQDOPEFZnjjcmtkS4cHRo1AUn+oujto2fbbHEhvEK7QgUIprXpuUe7G7ywX
         oVgF2ItOOPTwUsa0KIkdN5pr5ieNdw9R3/3REfd5T+6a8Vv2JxszjVaS97RTbkqAsrrH
         XM0yRHj9eAMCtTmykXWfAJOKqCQHiKNLMi7Psu8b1DnwKFaFG5bRJCrBP3pz+JRptm7r
         02NA==
X-Gm-Message-State: AOJu0YxmBOqD8lhsab7i0/HGNBAGu/iAffcpN3ccKjgFEXM2XwaOMHxM
        mDtn7fqrqWt5A/ImPn07ynU=
X-Google-Smtp-Source: AGHT+IGkA/6XtvCqg7LSR6AbDUensyCKLPT5PPoyzAFxddrwL2e8LOG9GSSHWOPFrBJSfpn7oxdjnQ==
X-Received: by 2002:a05:6512:11c2:b0:50b:e790:e96c with SMTP id h2-20020a05651211c200b0050be790e96cmr3522017lfr.30.1702551781616;
        Thu, 14 Dec 2023 03:03:01 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1b6d503e7esm9152162ejc.157.2023.12.14.03.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:03:01 -0800 (PST)
Message-ID: <fd9f6465-fd72-401e-bcc2-59f775a43d9b@gmail.com>
Date:   Thu, 14 Dec 2023 13:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <20231212104451.22522-2-mitrutzceclan@gmail.com>
 <ZXm-hf8UQ3VEyP-2@smile.fi.intel.com>
Content-Language: en-US
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <ZXm-hf8UQ3VEyP-2@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 16:24, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 12:44:36PM +0200, Dumitru Ceclan wrote:
> ...
> 
>> +		if (chan->type == IIO_TEMP) {
>> +			temp = ((u32)AD7173_VOLTAGE_INT_REF_uV) * MILLI;
> 
> Hmm... Is the casting mandatory here?
> 

Yep, not really needed as MILLI is already declared as unsigned and it
will promote the _INT_REF as well. On signed32 it would have overflowed.

Are there any cases where this would not be alright?
