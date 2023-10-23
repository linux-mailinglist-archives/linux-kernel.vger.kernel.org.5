Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68567D2B39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjJWHYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:24:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE65BD5B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:24:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507cb194e30so1062238e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698045872; x=1698650672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKdg99eVmqTJQsPp1Hlo5pZF0dZtBhRpT+d6cOzhUQw=;
        b=XK2+j12iVOVvOJqay9FxrDRRWUbdJ8DQkgG5UNq9NpI+2PNK8vKQJ1/at7cMXtTDWI
         a4pSZij/gemzMZt7w+coDCTV4wvoBCzTIOVseryEA2n6eXC1wg1isAlJDpg1wthCXyFr
         V3ov1V5yyNRgK2L9IsDk99bcx8//C2NuXNNS9EXPCbkcbLslwnttowcR1bOXTYCojj9P
         dXAS2I3lRTq1ozeEbqRjVV6NYRdt1c2MqM+X70RkAk3qyjYSRExXBdzE8wr3xbTmnLJf
         DQv23HdHKg3RfDr1dpHt6luN+WTKPChmaXHAnlZAFxHI1QTtu1JyjdZijEeJ7cyZaZol
         /4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045872; x=1698650672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKdg99eVmqTJQsPp1Hlo5pZF0dZtBhRpT+d6cOzhUQw=;
        b=F3+Eln0FYRSFdNatdpgK8M6jGi6VRCj0/kB55PLKmmJf6K/FNBdRXzl1K5xH0y8gHH
         EtoNCOtQlZyjbaTTTWgqZit4+qE3QnGP5eHTvM2gFx9vOqnu0n+v9Cbx6DbophlWho59
         D/SduTD0/lk+hDnn+F4I9IF7pbMITo530VP4XzXDsWKJ66yZkhRL1na9SWRmP1ZhxI60
         p45r6XXSuNSXnnaf6Nw/snyJU9D8+s0/bnaB7ZFzWL+Ku5Tk23UOgjrYGKLUnYNfDr1q
         HJs5V7O9dKsUti+LbUrKb1rmnbOGUTmUQ1w/Sls/khMQ9CC0TxTCzKRaGoLV6kZse1Ce
         RSpg==
X-Gm-Message-State: AOJu0YykPQecQ40djjp+wufiLewWu82Qa8QTEY1mnc7W+jjTgg2B0V4m
        mMc6TQZruAQZOBW3XC3ElQTZiQ==
X-Google-Smtp-Source: AGHT+IHeLcw0Gv1b3ochJlwAxOBaEeux/G3ce+Ey9OlLNTwkHWbN+mde2nshq6mVDd2Bj3+G98CePg==
X-Received: by 2002:a2e:a179:0:b0:2bc:d505:2bf3 with SMTP id u25-20020a2ea179000000b002bcd5052bf3mr5395573ljl.1.1698045871829;
        Mon, 23 Oct 2023 00:24:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:17bb:4fd9:531:a7cc? ([2a01:e0a:999:a3a0:17bb:4fd9:531:a7cc])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c189600b004083a105f27sm13228369wmp.26.2023.10.23.00.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:24:31 -0700 (PDT)
Message-ID: <3f383b96-87ae-4580-a23d-0196bbd8ec91@rivosinc.com>
Date:   Mon, 23 Oct 2023 09:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc:     Jerry Shih <jerry.shih@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com>
 <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
 <20231019-nuclear-vista-ef3e0b9bef71@spud>
 <CALs-HssWZyhnbo=ErH+LEfMi4m04i39Cw3PGXP1WhCFfSP8G=A@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HssWZyhnbo=ErH+LEfMi4m04i39Cw3PGXP1WhCFfSP8G=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/2023 18:19, Evan Green wrote:
> On Thu, Oct 19, 2023 at 8:33 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Thu, Oct 19, 2023 at 11:35:59AM +0200, Clément Léger wrote:
>>>
>>>
>>> On 18/10/2023 19:26, Evan Green wrote:
>>>> On Wed, Oct 18, 2023 at 5:53 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 18/10/2023 03:45, Jerry Shih wrote:
>>>>>> On Oct 17, 2023, at 21:14, Clément Léger <cleger@rivosinc.com> wrote:
>>>>>>> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>>>>>      __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
>>>>>>>      __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
>>>>>>>      __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
>>>>>>> +    __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
>>>>>>> +    __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
>>>>>>> +    __RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
>>>>>>
>>>>>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bundled with `Zvbb`.
>>>>>
>>>>> Hi Jerry,
>>>>>
>>>>> Thanks for catching this, I think some other extensions will fall in
>>>>> this category as well then (Zvknha/Zvknhb). I will verify that.
>>>>
>>>> The bundling mechanism works well when an extension is a pure lasso
>>>> around other extensions. We'd have to tweak that code if we wanted to
>>>> support cases like this, where the extension is a superset of others,
>>>> but also contains loose change not present anywhere else (and
>>>> therefore also needs to stand as a separate bit).
>>>
>>> For Zvbb and Zvknhb, I used the following code:
>>>
>>> static const unsigned int riscv_zvbb_bundled_exts[] = {
>>>       RISCV_ISA_EXT_ZVKB,
>>>       RISCV_ISA_EXT_ZVBB
>>> };
>>>
>>> static const unsigned int riscv_zvknhb_bundled_exts[] = {
>>>       RISCV_ISA_EXT_ZVKNHA,
>>>       RISCV_ISA_EXT_ZVKNHB
>>> };
>>>
>>> Which correctly results in both extension (superset + base set) being
>>> enabled when only one is set. Is there something that I'm missing ?
>>>
>>>>
>>>> IMO, decomposing "pure" bundles makes sense since otherwise usermode
>>>> would have to query multiple distinct bitmaps that meant the same
>>>> thing (eg check the Zk bit, or maybe check the Zkn/Zkr/Zkt bits, or
>>>> maybe check the Zbkb/Zbkc... bits, and they're all equivalent). But
>>>> when an extension is a superset that also contains loose change, there
>>>> really aren't two equivalent bitmasks, each bit adds something new.
>>>
>>> Agreed but if a system only report ZVBB for instance and the user wants
>>> ZVKB, then it is clear that ZVKB should be reported as well I guess. So
>>> in the end, it works much like "bundle" extension, just that the bundle
>>> is actually a "real" ISA extension by itself.
>>>
>>> Clément
>>>
>>>>
>>>> There's an argument to be made for still turning on the containing
>>>> extensions to cover for silly ISA strings (eg ISA strings that
>>>> advertise the superset but fail to advertise the containing
>>>> extensions). We can decide if we want to work that hard to cover
>>>> hypothetical broken ISA strings now, or wait until they show up.
>>>> Personally I would wait until something broken shows up. But others
>>>> may feel differently.
>>
>> I'm not really sure that those are "silly" ISA strings. People are going
>> to do it that way because it is much easier than spelling out 5 dozen
>> sub-components, and it is pretty inevitable that subsets will be
>> introduced in the future for extensions we currently have.
>>
>> IMO, it's perfectly valid to say you have the supersets and not spell
>> out all the subcomponents.
> 
> Hm, ok. If ISA strings are likely to be written that way, then I agree
> having the kernel flip on all the contained extensions is a good idea.
> We can tweak patch 2 to support the parsing of struct
> riscv_isa_ext_data with both .id and .bundle_size set (instead of only
> one or the other as it is now). Looking back at that patch, it looks
> quite doable. Alright!

Hey Evan,

do you have anything against using this code:

static const unsigned int riscv_zvbb_bundled_exts[] = {
	RISCV_ISA_EXT_ZVKB,
	RISCV_ISA_EXT_ZVBB
};

...

Then declaring zvbb like that:

__RISCV_ISA_EXT_BUNDLE(zvbb, riscv_zvbb_bundled_exts),

I agree that it is *not* a bundled extension but it actually already
works with Conor's code. Not sure that adding more code is needed to
handle that case.

Clément


> 
> -Evan
