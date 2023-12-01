Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F205800A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378731AbjLAMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378681AbjLAMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:12:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C6A103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:12:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00cbb83c80so293437066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701432760; x=1702037560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elxv3lTJW8D4+Mj9XKImFIdtqE5ajcp6kHSasoKUYrw=;
        b=eHwXw4YM2wTeHw3qBsWUAANRkLjaXD7mrBaAWR6kyFROGvdpPx3cNztQ/rBKi/0kcm
         U4EbYVHoJU/Y1Lk0W3a/Xnbx27kzl6SVNPi0d64fO2vEfIKgKCZhWLR3ytvTM/+5XJdy
         +dT+tWvSPJu9jlDkA+IyMdgwNuKs/vnlOYuO5ss1ub+aTmGHoqJnBOn8xnkOARIn9hX/
         G2dy4tWTmBR2/iWsQfPkxXrKsFh2nSkBTKPZ2NLMbaOUwfiuorfoL8Py/YfsZNNwYo4N
         zsEh8gW+KTcQPigqilqJe2YxX3YlyzXtFAwXYsFMbJu18pRAwIdZudex76TOgWwyKzDP
         wXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432760; x=1702037560;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elxv3lTJW8D4+Mj9XKImFIdtqE5ajcp6kHSasoKUYrw=;
        b=ink91D1V7TkZzue3O9JSbftAWYe3oNraBtIUYnj0gLU23SnnAdfv0OenNspBXsf0Dq
         eiJ2h9+qRaMUX5zNSRK3fiLxIvhKxryzBIeRBE/Xu2uvmhBNvIA6mdy5oEP/wYj0BJUk
         TbzBzdP74O3JxSu7lp1c3+cnx8BMGGCHbljUc6ZVG9PFJA6gnWe5K5Nhx8fQI6JHhkW3
         0vk3Wxy754wR/aq6L4Gi9G7ry91S40xL2T42YMk/B/llAgg703QOA5ovVV1khfUFhhno
         vFwgETp4LiF2K8sbNV7ap1mMnhwkTF7ZnGWubjDSGrAhSclnk/I4BWJcU1D5XmL/Dvqf
         aArA==
X-Gm-Message-State: AOJu0YyTbgipxjXGn4siUW3Ijm4dB3dipe8Gr5MALs/a8aUw8c+XZZ1a
        wLV1DuBqs2zZWgd74X6lcOnYbg==
X-Google-Smtp-Source: AGHT+IG6K1LKQfvVGGJzsHpnDnlJY0Qg0R2GO2J6XFLCT2ebTzKDDa97z0J6Hxm2tfR/LLTtvwIsIg==
X-Received: by 2002:a17:906:738d:b0:a19:a19a:ea97 with SMTP id f13-20020a170906738d00b00a19a19aea97mr827630ejl.80.1701432760061;
        Fri, 01 Dec 2023 04:12:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709061f4800b00a0435148ed7sm1873850ejk.17.2023.12.01.04.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 04:12:39 -0800 (PST)
Message-ID: <b2b774fb-d252-4e5b-a6b7-1e5e92955a8f@linaro.org>
Date:   Fri, 1 Dec 2023 13:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to identify
 devices
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Alexandru Ardelean <alex@shruggie.ro>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        a-govindraju@ti.com, trix@redhat.com, abdelalkuor@geotab.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20231123210021.463122-1-alex@shruggie.ro>
 <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
 <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
 <ZWhp9M8165DiTNTd@kuha.fi.intel.com>
 <292f5d48-8567-4b60-ad03-6cf70f71bacc@kernel.org>
 <ZWmVA9KTVhZ4YCPO@kuha.fi.intel.com>
 <019c84e6-2e77-4b76-b105-fc9ff678c058@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <019c84e6-2e77-4b76-b105-fc9ff678c058@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 11:57, Roger Quadros wrote:
> +Rob & Krzysztof
> 
> On 01/12/2023 10:10, Heikki Krogerus wrote:
>> Hi Roger,
>>
>> On Thu, Nov 30, 2023 at 03:30:54PM +0200, Roger Quadros wrote:
>>> Hi Heikki,
>>>
>>> On 30/11/2023 12:54, Heikki Krogerus wrote:
>>>> Hi Roger,
>>>>
>>>>>> Why not just match against the structures themselves?
>>>>>>
>>>>>>         if (tps->data == &tps25750_data)
>>>>>>                 ...
>>>>>
>>>>> Then you need to declare tps25750_data and friends at the top of the file?
>>>>>
>>>>> A better approach might be to have type agnostic quirk flags for the special
>>>>> behavior required for different types. This way, multiple devices can share
>>>>> the same quirk if needed.
>>>>>
>>>>> e.g.
>>>>> NEEDS_POWER_UP instead of TIPD_TYPE_APPLE_CD321X
>>>>> SKIP_VID_READ instead of TIPD_TYPE_TI_TPS25750X
>>>>> INIT_ON_RESUME instead of TIPD_TYPE_TI_TPS25750X
>>>>>
>>>>> Also rename cd321x_switch_power_state() to tps6598x_switch_power_state().
>>>>
>>>> No. Functions like that isolate cd321x specific functionality into an
>>>> actual "function" just like they should.
>>>>
>>>> Quirk flags mean that if something breaks, it will almost always break
>>>> for everybody (there is no real isolation with quirk flags), and when
>>>> things are fixed and when features are added, we are forced to always
>>>> "dance" around those quirk flags - you always have to consider them.
>>>>
>>>> Platform/device type checks are just as bad IMO, but in one way they
>>>> are better than quirk flags. There is no question about what a
>>>> platform check is checking, but quirk flags can so easily become
>>>> incomprehensible (just what exactly does it mean when you say
>>>> NEEDS_POWER_UP, SKIP_VID_READ and so on (you would need to document
>>>> those quirks, which is waste of effort, and in reality nobody will do).
>>>>
>>>> In case of tipd/code.c, it should be converted into a library that
>>>> only has the common/shared functionality. CD321, TPS2579x, TPS6598x
>>>> and what ever there is, then will have a glue driver that handles
>>>> everything that specific for their controller type.
>>>
>>> Do you mean that you want to treat the 3 devices as different incompatible devices
>>> so each one has a separate driver which warrants for a different DT binding
>>> for each and also Kconfig symbol?
>>
>> I did not consider that, I was thinking that we would still continue
>> with just one probe driver for all of these, but now that you
>> mentioned this, maybe it would actually make sense to have separate
>> full fledged probing drivers for all of these. Do you think it would
>> be better like that? Would it be a problem to split the bindings?
> 
> I'm no DT expert but looks like an overkill to me.

Splitting or not splitting drivers has nothing to do with bindings. Does
the hardware suddenly change if you decide to do something with drivers?
No, it does not.

Best regards,
Krzysztof

