Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6431E7EECA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjKQHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjKQHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:22:42 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E9D56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:22:35 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231117072231epoutp01909f7474685322d2d7cf3662374f18e8~YWB98tri12897928979epoutp01K
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:22:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231117072231epoutp01909f7474685322d2d7cf3662374f18e8~YWB98tri12897928979epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700205751;
        bh=nuKoc41/Xq57xqzk4CX3/OUT0Nfb5VpmaXRO3fmAdEE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YEfux1A0iwVWjvs7WRLSFgBmCSPKm/+hs6mBUVsl7relmUyHSUXq2H73kEx0HwfSx
         j70/N5ixlCIrcua8wqWWy+uT6t3ryGvadzK5qMPZUsJkYYo0K4TuoHSzyhtTUFj9dl
         uxaOAs4o6WZWmGYrsDyJnSvuV4FcUXzcNhQlr2Vs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231117072230epcas2p1f863d5b0f520ed28155b4d0c45e1429f~YWB9XYYOM1711117111epcas2p1J;
        Fri, 17 Nov 2023 07:22:30 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SWpJQ1Xr5z4x9Px; Fri, 17 Nov
        2023 07:22:30 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.EA.09622.6B417556; Fri, 17 Nov 2023 16:22:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231117072229epcas2p3c414169b8fa8149dd2b74679d7325bda~YWB74Cnp81759617596epcas2p33;
        Fri, 17 Nov 2023 07:22:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231117072229epsmtrp2580b1bb3b22f0d2f0cfb6d8d5d4ef47c~YWB73I7111221912219epsmtrp2K;
        Fri, 17 Nov 2023 07:22:29 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-0a-655714b66111
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.A7.18939.5B417556; Fri, 17 Nov 2023 16:22:29 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231117072228epsmtip10dc61d154637b301fca9e4f789cb67bb~YWB7hKoUo0271802718epsmtip1Q;
        Fri, 17 Nov 2023 07:22:28 +0000 (GMT)
Message-ID: <af102ef7-aa34-1b9d-c39c-228729fef015@samsung.com>
Date:   Fri, 17 Nov 2023 16:19:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Content-Language: en-US
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
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <d8fbd100-2351-4dbe-ae7f-d98a84432589@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmqe42kfBUg7+XWS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfGooZ+14BBfRcuz56wNjC+5uxg5OSQETCS+3pvP3MXIxSEk
        sINR4uj+Y2wQzidGicdXOhjhnLUbbzHCtBw+8oEVIrGTUaL73CRWkISQwGtGiWs97CA2r4Cd
        xKn5m5hBbBYBVYk1f2czQcQFJU7OfMICYosKREu0LrvPBmILC3hKTN7/F6yeWUBc4taT+WD1
        IgL3mSVet1WDLGMWeMAoMffcV7Ar2AS0Jb6vXwy2mBNo2ba199ggmuUltr+dA/aQhMAbDonW
        fQuYIc52kZjXdgbKFpZ4dXwLO4QtJfH53V42CDtbon36H1YIu0Li4obZUHFjiVnP2oEWcwAt
        0JRYv0sfxJQQUJY4cosFYi2fRMfhv+wQYV6JjjYhiEY1iftTz0ENkZGYdGQlE4TtIXGyYx/r
        BEbFWUihMgvJ97OQPDMLYe8CRpZVjGKpBcW56anFRgVG8MhOzs/dxAhO5FpuOxinvP2gd4iR
        iYPxEKMEB7OSCK+5XEiqEG9KYmVValF+fFFpTmrxIUZTYNxMZJYSTc4H5pK8knhDE0sDEzMz
        Q3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqYXFtmszAs/mfScHGecd7LZVpusiz8
        Bkmn83+Ltimf7lnGM2vBlP5Cq+svDwVfKOVlPv9jS6ePnYP1HpfroXM43iQ+WMQWliaivi3q
        2oSrT68kr5aKz21Ytr9h+ZNz/Qc27P0yU1udUS2v7pH9dSWDZ1e/+D39bHpxx/pJe4+98Mku
        Yeqf7RFY7u9z+1Z7kKG62tWvPz/evvv2xpTeSSIVCUsy9a/FTEpb7S/fp3145Y696XtXrxM7
        0v3S8Z/fM5dnSqyiinpVT9oOKP08ufRs1p6bW5kaDwksPj7ZRYJBmTE3c6b2CaaztjxrVy6V
        eDp17sunCQ5nfe8tlT3eqaAZOPnydJmqBCYlSblTdgurLimxFGckGmoxFxUnAgAcHPfWbQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO5WkfBUg1tdPBYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRHHZpKTmZJalFunbJXBlPGroZy04xFfR8uw5awPjS+4uRk4O
        CQETicNHPrB2MXJxCAlsZ5RYsHo9I0RCRmL5sz42CFtY4n7LEaiil4wSn1e/ZAdJ8ArYSZya
        v4kZxGYRUJVY83c2E0RcUOLkzCcsILaoQLTE6s8XWEFsYQFPicn7/4LVMwuIS9x6Mp8JZKiI
        wGNmiYdT/zODOMwCDxgllk96BLVuHrPEy1vLwcayCWhLfF+/GGwUJ9DqbWvvsUGMMpPo2trF
        CGHLS2x/O4d5AqPQLCSXzEKycRaSlllIWhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L10vOz93E
        CI5draAdjMvW/9U7xMjEwXiIUYKDWUmE11wuJFWINyWxsiq1KD++qDQntfgQozQHi5I4r3JO
        Z4qQQHpiSWp2ampBahFMlomDU6qBaVrRvk283beE2Pv/8+5s3e5puWV/e9SlnZFzrjj2ede5
        CZinXm29fMOL93f5k70XKt6vCi37+DFvcaTry9cN27nfhxUXTfi/kulrw7+r94wZf0zK2XLS
        +U+sONP566Z5fsV/9CcEVvJsSf3HzBD01CDeLudUUvN+o7cMQdYfah4p272SYjI6HbtRsf/H
        TaEX2uwHe45+vS584WDh4R23TZYezRGNP1uldPykj/ubN552Bbddbu72m2Z9ZmWkuuautkB1
        5gmbzhyROKkg2nZ6nZA+73eVJX9W7nt3dFqdN4/q3VsNQp89AmfOaOvW9lq4YfHGlOfzfu4U
        21I01dggLeNd65RshSjLuhueR87nViixFGckGmoxFxUnAgAgBulJTAMAAA==
X-CMS-MailID: 20231117072229epcas2p3c414169b8fa8149dd2b74679d7325bda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com>
        <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <170005362858.21132.4200897251821879805.b4-ty@linaro.org>
        <6e69df6c-10fa-404a-ac02-4880723b8c50@linaro.org>
        <55a0f27c-ea46-40ae-b1e5-e650802b89a8@linaro.org>
        <d6f3d451-6a53-46b6-2263-cc071a9dc44c@samsung.com>
        <d8fbd100-2351-4dbe-ae7f-d98a84432589@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 16. 20:17, Krzysztof Kozlowski wrote:
> On 16/11/2023 04:32, Jaewon Kim wrote:
>> On 23. 11. 16. 06:17, Krzysztof Kozlowski wrote:
>>> On 15/11/2023 22:11, Krzysztof Kozlowski wrote:
>>>> On 15/11/2023 14:08, Krzysztof Kozlowski wrote:
>>>>> On Wed, 15 Nov 2023 18:55:56 +0900, Jaewon Kim wrote:
>>>>>> ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
>>>>>> This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
>>>>>> IPs are used for safety.
>>>>>>
>>>>>> This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
>>>>>> Currently, ramdisk console is available and Clock, UFS, and USI will be
>>>>>> added after this patchset.
>>>>>>
>>>>>> [...]
>>>>> Applied, thanks!
>>>>>
>>>> And dropped. You did not test it. Please read Samsung SoC maintainer
>>>> profile:
>>>> https://www.kernel.org/doc/html/latest/process/maintainers.html#arm-samsung-s3c-s5p-and-exynos-arm-architectures
>>>>
>>>> I also made announcements on the lists and on social.kernel.org. I don't
>>>> know where to announce it more...
>>>>
>>> To clarify, I dropped only DTS and kept bindings. Let me know if
>>> bindings are problematic here...
>>>
>>> I also repeated the announcement:
>>> https://social.kernel.org/notice/AbqJkj9gOZJ3sG8eCu
>>> Please share internally within Samsung, so there will be no surprises.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>> I already checked and there were no warnings or errors as shown below.
>>
>> Did I miss something??
> It's not what is written in maintainer profile. Where do you see the
> result of dtc W=1?
>

Sorry, Krzysztof I miss W=1.

I haven`t been active in mainline for a long time, so I`m missing out on 
a lot of things.

Thanks you for letting us know one by one.

I will catch up quickly.


Thanks

Jaewon Kim

