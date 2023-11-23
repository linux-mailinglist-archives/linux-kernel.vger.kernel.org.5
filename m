Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161B7F582A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjKWGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:25:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C496191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:25:38 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231123062535epoutp0162b13c4344425f05d473927e4db01971~aLH_DbJ0m0911109111epoutp01O
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231123062535epoutp0162b13c4344425f05d473927e4db01971~aLH_DbJ0m0911109111epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700720735;
        bh=GJrAs6iFIsJav6Xylce3kT+oM93Qos0V4uOMkTsSCdA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Ht+Cbf1iKdsmQaLbD7RXNn7W3cUgIasWpnot6p4mxK/5oc18Og0YWHb8YfQdZgTiN
         XpbGr8J9bJ4Rs5bMZJsqajLY8weB7WMP78YNHHzg5Gjq0KbuLXKeAQs2cQLWB5MgGt
         CY9jbr+WvrpMoXPIU3j7DY1HfSI3mJ5QCUp2Tw48=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231123062534epcas2p422dbbbed9578619788f36e5a0efffc59~aLH9bCXFg2378423784epcas2p4o;
        Thu, 23 Nov 2023 06:25:34 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SbSly3PCKz4x9QD; Thu, 23 Nov
        2023 06:25:34 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.BB.10006.E50FE556; Thu, 23 Nov 2023 15:25:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231123062533epcas2p3e00ede8234985d615fce4f8b45885baa~aLH8l9aD80915409154epcas2p34;
        Thu, 23 Nov 2023 06:25:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231123062533epsmtrp1928ccc5fd83dee38d191caa3ab27b711~aLH8k5CLi3275132751epsmtrp1n;
        Thu, 23 Nov 2023 06:25:33 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-ee-655ef05eed1a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.33.08817.D50FE556; Thu, 23 Nov 2023 15:25:33 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231123062533epsmtip160917009d955fe1deb7cb493968c99e3~aLH8PutH70841408414epsmtip15;
        Thu, 23 Nov 2023 06:25:33 +0000 (GMT)
Message-ID: <f49b77f8-a30d-0923-feba-07c8945f334e@samsung.com>
Date:   Thu, 23 Nov 2023 15:22:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/12] pinctrl: samsung: add exynosautov920 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <8d4e3fcb-2e4a-4580-9aa2-5acbed961c3f@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmuW7ch7hUgyc9EhYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp
        5CXmptoqufgE6Lpl5gB9oqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07M
        LS7NS9fLSy2xMjQwMDIFKkzIzti0+x57wT6BinvzH7I0MH7i6WLk5JAQMJHYMnsfWxcjF4eQ
        wA5Giearr5kgnE+MEu3nrkI53xglns1fwAzT0rjlGTtEYi+jxOKNB5khnNeMEj3vehlBqngF
        7CQufQCZxcnBIqAqsWfLLmaIuKDEyZlPWEBsUYFoidZl99lAbGEBL4lTO/ewgtgiAveZJV63
        VYMMZRZ4wCgx99xXsKHMAuISt57MBxvKJqAt8X39YqAGDg5OoGU3pthBlMhLNG+dDXaQhMAb
        Doknj26yQ5ztIrFl83kmCFtY4tXxLVBxKYmX/W1QdrZE+/Q/rBB2hcTFDbPZIGxjiVnP2hlB
        djELaEqs36UPYkoIKEscucUCsZZPouPwX3aIMK9ER5sQRKOaxP2p56CGyEhMOrIS6gAPiebJ
        09kmMCrOQgqUWUh+nIXkmVkIexcwsqxiFEstKM5NTy02KjCER3Zyfu4mRnAi13LdwTj57Qe9
        Q4xMHIyHGCU4mJVEeLewx6QK8aYkVlalFuXHF5XmpBYfYjQFRs1EZinR5HxgLskriTc0sTQw
        MTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoEpptzhwovlbj8NQ78VvpjVwG7i
        /H6hqfyvZVMC2DZe/Xj7gU8Dcwh/87pY523P/9W58vJVLmzecE9C5ZSna8Chiv0tQTxeM84p
        97+Ovnhy0waHHOEHZsqBbfXqsbx+Fkqf/0W6+e/5dGBOqXmk+MG/B2ex109VlnZ+9CD/3oLT
        UTGbLp/mub46pviL1WuuTftcN+y+yliQ2p3Unn/c1DHJ2cV5l++k/v/HtuoVXpDynbL26OZF
        28o2rZ7j3mm9fpN1IVe5x0+Vkp+MDzoyOK3d+Ar31St9YFzHc7RrR5HwyQUvPl185Oe69/Ws
        OI7rpefDjzzdF5Vn+sbbv7nzvuivcxrzU1zmPhGeMv3/u8/rlFiKMxINtZiLihMBr0wwjW0E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnG7sh7hUg+7fuhYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRHHZpKTmZJalFunbJXBlbNp9j71gn0DFvfkPWRoYP/F0MXJy
        SAiYSDRuecbexcjFISSwm1Hi6owzjBAJGYnlz/rYIGxhifstR1ghil4yShxYf4gFJMErYCdx
        6cNrJhCbRUBVYs+WXcwQcUGJkzOfgNWICkRLrP58gRXEFhbwkji1cw/YIBGBx8wSD6f+ZwZx
        mAUeMEosn/QIasVWFonJF7aD3cEsIC5x68l8sBVsAtoS39cvBiri4OAEWn1jih1EiZlE19Yu
        qHJ5ieats5knMArNQnLILCSTZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOAI1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeLewx6QK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwOTAzLfy2O0zdnNtn1efzJtzzkLIb4WN9x+5Aw2f
        r3N/S1v94B5v+aHtH/8d9swVPnmm3lrxxqUtdzwtqxmP1VtFlIbGe2+8YixjIzp9261N+pNf
        Off4q+1eH71ptdDSPAcBN+mHH45MiukSyd5aMJ/dRih/5+VJz7VeO9We0vPi2vZgitWf7zPz
        y9TXqjD/nCy576njcfGjYisnqXNzhi91r7Sw14rsZPFkyl3588a6sFMqsXsVUn0qijJY9Wdd
        kX298CH//b6VFTWZHP3pBauNJOJ9tKZ4rq3RYNLx5Jv42DhZrSRgmt3jzoqJ9v5zhb6wr+L4
        IHLszo3E/r8Mpe29xwTr7Fekp90/uepBthJLcUaioRZzUXEiACeeSixPAwAA
X-CMS-MailID: 20231123062533epcas2p3e00ede8234985d615fce4f8b45885baa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28@epcas2p1.samsung.com>
        <20231115095609.39883-11-jaewon02.kim@samsung.com>
        <62b7176d-f99c-49f6-a287-17a6b3604c1c@linaro.org>
        <f0f6a7af-2170-89a2-1eea-dfb9d8440321@samsung.com>
        <6a5610e0-e60d-4ab7-8708-6f77a38527b7@linaro.org>
        <926ea5c5-20ac-5e63-16ea-6f0c20e2db0a@samsung.com>
        <0fdb7bec-9ea4-454f-a0fb-d450f27ebc6b@linaro.org>
        <ab17d61e-f645-9b76-962c-4ba2849c5f42@samsung.com>
        <8d4e3fcb-2e4a-4580-9aa2-5acbed961c3f@linaro.org>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 21. 22:51, Krzysztof Kozlowski wrote:
> On 18/11/2023 08:43, Jaewon Kim wrote:
>> On 23. 11. 17. 19:48, Krzysztof Kozlowski wrote:
>>> On 17/11/2023 08:36, Jaewon Kim wrote:
>>>>>> The reason why I chose variable name 'combine' is that EINT registers was
>>>>>> separated from gpio control address. However, in exynosautov920 EINT
>>>>>> registers combined with GPx group. So I chose "combine" word.
>>>>> What does it mean "the GPx group"? Combined means the same place, the
>>>>> same register. I could imagine offset is 0x4, what I wrote last time.
>>>>>
>>>>> Is the offset 0x4?
>> If you are asking about the offset of GPIO control register and EINT
>> control register, 0x4 is correct.
>>
>> There is no empty space between the two register.
>>
>>
>> 0x0 CON
>>
>> 0x4 DAT
>>
>> 0x8 PUD
>>
>> 0xc DRV
>>
>> 0x10 CONPDN
>>
>> 0x14 PUDPDN
>>
>> 0x18 EINT_CON
>>
>> 0x1c EINT_FLTCON
>>
>> 0x20 or 0x24 EINT_MASK (The size of FLTCON register depending on the
>> number of gpio)
>>
>> 0x24 or 0x28 EINT_PEND
>>
>>
>>>>>
>>>>>> Is another reasonable word, I will change it.
>>>>> Why you cannot store the offset?
>>>>>
>>>>>> EINT registers related to the entire group(e.g SVC) were at the end of
>>>>>> the GPIO block and are now moved to 0xf000.
>>>>> So not in the same register, not combined?
>>>>>
>>>> Okay,
>>>>
>>>> Instead of the word combine, I will think of a better word in next version.
>>> I want to know answer to:
>>>
>>> "Why you cannot store the offset?"
>>>
>> I did not understand exactly what you said, but if i guess,,
>>
>> you want to get rid of the offs because the value of the offs is always
>> the same?
>>
>> #define EXYNOSV920_PIN_BANK_EINTG(pins, reg, id, offs, mask_offs, pend_offs)
> I meant that it looks possible to store the offset and use it directly,
> instead of storing bool telling that offset is different.

Thanks for your feedback. We can use offset instead of bool.

I will make v3 patch using new variable 'eint_con_offset' instead of 
'combine'.


Thanks

Jaewon Kim






