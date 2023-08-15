Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F277C6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjHOFJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjHOFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:08:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38451171F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:08:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99cce6f7de2so682473566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692076106; x=1692680906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RtZ3qk8KDKAyM7uZ723VgsO7ZDljAE8bUmfZOovcVo=;
        b=sTZl+F97t7YyvAewnlM00xqrYjUFSyHwBOdsZ9fZeLUUSF0ZbNjPiebYsCeXNOux5L
         Om0GcWypAhk/8WoE3iP5TCdCujKevLy/0tw/nHuWkNCBZRs3la0CT1cxH9wyhfsAx4f0
         lcCHRRtXl5rj+3oq8hMMxDMK30KAxWoSaQW+QntiRB3+839SOSY8LtnCGqL7o2OQc4Gw
         NTwf3aJg1nhDJ3jSNY0ylXCTsG6xCCcvfgmBdKk9iwFEO0JS0gmfwxPFqg0YwCRmTcKe
         H53CJMmuTAgGGGw7MN36x3QKlDJ8RROukHZNovnd04tkhYkR4FicRyzRG0IThK/qdAvc
         WTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076106; x=1692680906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RtZ3qk8KDKAyM7uZ723VgsO7ZDljAE8bUmfZOovcVo=;
        b=lU+5Cv/Vd26ns65bgDKee/4XODfU1eas/A6cX/8MH2bRR/4TPqsLuqU8/dvHuplTla
         sHa38yfvbFO2yCu1fg43qYIJ9GPqz6GfRCj12H8T3YmeMCgj/FjtMsMlb5srExpIa2tS
         kZAabYhyurib+A3VizYYRaTXTnPU1iq1WHcfKJZUJztgYGIaxaJ4+77OcJfOGZw/x6BV
         H/2VhG7/wKTBl0qK479b9301p4PYd/Zg44y2rmvZg1XdWFjzMXbplwErr682zbeZ0qpm
         4W43rxmTfbzBEpJ9VI99uE9ziYmpJHPn/cMMKTX5yMjMEQ8DgwK5mczcJWQC2PrnkEU0
         5pMg==
X-Gm-Message-State: AOJu0YzefIqhTA0NjeGCyPqu5JQl8KYgLTZuv9Vs7QxUd1zCmctL/UBH
        D0wpa2IO1sZaBie5YgM+Y1hXOg==
X-Google-Smtp-Source: AGHT+IEHl+XQA70lMQvfpN0fpkw+dM2wsdNQNUQCh6s7LR/jIakD6PWpTcV4OEOZuywWquixGwOmGg==
X-Received: by 2002:a17:907:2c74:b0:99d:b9d6:6011 with SMTP id ib20-20020a1709072c7400b0099db9d66011mr2031715ejc.55.1692076106060;
        Mon, 14 Aug 2023 22:08:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id mb25-20020a170906eb1900b0099ce025f8ccsm6514364ejb.186.2023.08.14.22.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:08:25 -0700 (PDT)
Message-ID: <ba958196-fb2d-f7ba-46cd-6a3cb40f21bd@linaro.org>
Date:   Tue, 15 Aug 2023 07:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <20230808172511.665787-2-james.ogletree@cirrus.com>
 <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
 <ADCCD2C5-B79B-4C50-B3CE-007B1FBF5A5E@cirrus.com>
 <3f406442-d46e-7f9e-426d-22a96f893103@linaro.org>
 <E3A9D2CF-333D-4238-8013-346135AC001B@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <E3A9D2CF-333D-4238-8013-346135AC001B@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 23:44, James Ogletree wrote:

>>>> I don't think this is a module.
>>>
>>> It can be compiled as a module with CONFIG_INPUT_CS40L50=m. However, there is a
>>> typo in the Kconfig entry description: the module will be called “cs40l50” not “cs40l50-core”.
>>> That will be fixed. 
>>
>> Really, *this* unit file can be compiled as module? Where is the
>> module_xxx_driver() then?
>>
> 
> As I understand it, the “module_XXX_driver()” has nothing to do with whether or not the file is built as a module, rather it just provides code to attach the driver to a bus. But this is a bus-agnostic, separate module (not a driver in itself) that provides implementation to cs40l26-i2c or cs40l26-spi drivers, which do contain that macro as they should. This doesn’t appear to be an uncommon pattern.


I see now in the Makefile that it can be indeed built as module and
compiled on its own. It's fine then.

Best regards,
Krzysztof

