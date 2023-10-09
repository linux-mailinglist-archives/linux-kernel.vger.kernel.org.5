Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8E7BD7B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbjJIJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbjJIJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:52:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABCC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:52:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231009095230euoutp0273c0be32f4bdf69115f5407087e820c0~MZ6x2s8_c1131111311euoutp02p
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:52:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231009095230euoutp0273c0be32f4bdf69115f5407087e820c0~MZ6x2s8_c1131111311euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696845150;
        bh=2rBYQLGrtHKz4XvyeLH/M1hAAzls0bhQW/62YMnQ7vk=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=nTumuSuMIOKmlU4XPJgCKSAxVFh9UoX1Ux/bcmpypARDpZKAdVwjbiWMGEskAdK/O
         FX5YRXoMrtMcUPE3c+0Rkf71FQsdOKQeiby+KQTTOgs/1LGsgjoRdVl5fFSTzpZwhD
         vnppy91DjQf00cFEwZCGAY9oknvIOHePeB9PgFk0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231009095229eucas1p27fc38e9971fc230a55fc031569fd128f~MZ6xhMO2K1563915639eucas1p2d;
        Mon,  9 Oct 2023 09:52:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.CA.11320.D5DC3256; Mon,  9
        Oct 2023 10:52:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231009095229eucas1p291ff3de0cbe84165800414ab24819d93~MZ6xCLBNz1307113071eucas1p2j;
        Mon,  9 Oct 2023 09:52:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231009095229eusmtrp137bf3c76c92fc79dedd114ddd673fab2~MZ6xAZjSr1702717027eusmtrp1O;
        Mon,  9 Oct 2023 09:52:29 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-3a-6523cd5dfee5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.B3.25043.D5DC3256; Mon,  9
        Oct 2023 10:52:29 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231009095228eusmtip21e7c48f6cb6bfad4bea478d1116fdabf~MZ6wTRvWf0538005380eusmtip2_;
        Mon,  9 Oct 2023 09:52:28 +0000 (GMT)
Message-ID: <c5efd5a6-561c-49a8-b1ee-82997192b030@samsung.com>
Date:   Mon, 9 Oct 2023 11:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of
 GPIO base warning
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Language: en-US
In-Reply-To: <82e30bd1-b7b4-4d95-9f13-008398082ca0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87qxZ5VTDRbvVLJ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2OPymndXieR+Qu2rXH0YHbo+ds+6y
        e9y5tofNY/OSeo++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKmD3/L1vBV6mKb4uuMTUwzhPt
        YuTkkBAwkdj8ZiVTFyMXh5DACkaJhSfmMkI4XxglTt96C5X5zChx7VY/O0zLlkWb2CESyxkl
        lu+YyQzhfGSUOLn9HDNIFa+AncSSDX+BbA4OFgEVicb7ShBhQYmTM5+wgNiiAvIS92/NABvK
        JmAo0fW2iw3EFhaIkfgwaRvYGBGBNInj16aygMxnFrjDJHFm0RZGkASzgLjErSfzmUDmcwLt
        2rU2AiIsL7H97RxmiEN/cEjsvFwDUiIh4CLRfs4VIiws8er4FqhfZCROT+4BGy8h0M4oseD3
        fSYIZwKjRMPzW4wQVdYSd879YgMZxCygKbF+lz7ETEeJro/mECafxI23ghAX8ElM2jadGSLM
        K9HRJgQxQ01i1vF1cFsPXrjEPIFRaRZSmMxC8tYsJL/MQli7gJFlFaN4amlxbnpqsVFearle
        cWJucWleul5yfu4mRmCSOv3v+JcdjMtffdQ7xMjEwXiIUYKDWUmEV7dUIVWINyWxsiq1KD++
        qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qBifHJ7pnLucUMP7IcN3tyVeJq
        b8h09++zw68WeOSkh85LTv+y6PasCT90130MDT0nxH3l5629+9vVf1qJM5Vtea68fRFvyesw
        xX5nzW37/l+1rrD+aLxoi+r18pWu+grXHqS/j2x6IdsadnFD5lRL3R2yDGd81prOenvi0fkP
        m0zXydTU6hj9VdMR9bq4QGZS1IL7V/4qtBksunTtjjcDX+Z3h3+ZjuVbV1ycN2HxyuxZv3iO
        yUZrrlmRHrLqXW0Ao6han4uz5LYJF2Tfq22Tlswo/qDJ8c7wsNdDBYUv95mfTiz1Ymiacl1g
        5twfYnPP7Y4wfflakXF13DmTrp1e0y9HvT9tUqWx+W1/1c1HWjVKLMUZiYZazEXFiQAyZ2KE
        wQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7qxZ5VTDb58YbZ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2OPymndXieR+Qu2rXH0YHbo+ds+6y
        e9y5tofNY/OSeo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLmD3/L1vBV6mKb4uuMTUwzhPtYuTkkBAwkdiyaBN7FyMXh5DA
        UkaJKx8nMkEkZCROTmtghbCFJf5c62KDKHrPKPF/xilmkASvgJ3Ekg1/gWwODhYBFYnG+0oQ
        YUGJkzOfsIDYogLyEvdvzWAHsdkEDCW63oLM4eQQFoiR6F8wDaxGRCBN4l7bCyaQ+cwCD5gk
        Xt7+AHVRO7PEjY59YB3MAuISt57MZwJZxgm0eNfaCIiwmUTX1i5GCFteYvvbOcwTGIVmIblj
        FpLuWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwNrcd+7llB+PKVx/1DjEy
        cTAeYpTgYFYS4dUtVUgV4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnA5JBXEm9oZmBqaGJm
        aWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAkEpE31VV13XzRyMQHPMLTjD7wnJh3
        SK596RRunodXBMT95NNVK89tmb9bbd+kRefa9A1UDI/+vLiTIUuba05Y36unjxREPlt+u2JR
        qqX/YoLplCt5Fnt9/HfuWNH69aGO6e7rU8Jqzl7t+RO9bhZfTVbOo471tzJi3s/Yb610WM7W
        StOq+lLZn7pMDb3Wf/JTl8QZJF+2c6/aY1l3MVXOsXfuwXtiC8S4Vef7mU2U47mzw9ZLdZXc
        rBatt2u5tjuIPDRI/rrTr3mW1L5/21ROSH2e/S3jDivPlvC1iVK7b+//XPNMpePmq9cruk9q
        C9on8S37ea113seft+4LpBQ1PZuZXpz52PD6gk01bN/DlFiKMxINtZiLihMBUs1av1YDAAA=
X-CMS-MailID: 20231009095229eucas1p291ff3de0cbe84165800414ab24819d93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
        <20231006125557.212681-1-m.majewski2@samsung.com>
        <CAPLW+4kmA6iYDPFxyASHLJifz63DRxT9gqQ-AsMAVy0RzoaFRw@mail.gmail.com>
        <04260159-f5a8-47f7-b267-33f4ea19b8a6@linaro.org>
        <CAPLW+4nyLunQw+wCxQmw9VDCGx2ECeAhUzjKRCBeHW7fGS1dFA@mail.gmail.com>
        <82e30bd1-b7b4-4d95-9f13-008398082ca0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.2023 11:42, Krzysztof Kozlowski wrote:
> On 08/10/2023 20:45, Sam Protsenko wrote:
>>>> Thank you for handling this! Those deprecation warnings have been
>>>> bugging me for some time :) While testing this series on my E850-96
>>>> board (Exynos850 based), I noticed some changes in
>>>> /sys/kernel/debug/gpio file, like these:
>>>>
>>>> 8<------------------------------------------------------------------------------------------>8
>>>> -gpiochip0: GPIOs 0-7, parent: platform/11850000.pinctrl, gpa0:
>>>> - gpio-7   (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
>>>> +gpiochip0: GPIOs 512-519, parent: platform/11850000.pinctrl, gpa0:
>>>> + gpio-519 (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
>>>>
>>>> -gpiochip1: GPIOs 8-15, parent: platform/11850000.pinctrl, gpa1:
>>>> - gpio-8   (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
>>>> +gpiochip1: GPIOs 520-527, parent: platform/11850000.pinctrl, gpa1:
>>>> + gpio-520 (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
>>>>
>>>> -gpiochip2: GPIOs 16-23, parent: platform/11850000.pinctrl, gpa2:
>>>> +gpiochip2: GPIOs 528-535, parent: platform/11850000.pinctrl, gpa2:
>>>>
>>>> ...
>>>> 8<------------------------------------------------------------------------------------------>8
>>>>
>>>> So basically it looks like all line numbers were offset by 512. Can
>>>> you please comment on this? Is it an intentional change, and why it's
>>>> happening?
>>>>
>>>> Despite of that change, everything seems to be working fine. But I
>>>> kinda liked the numeration starting from 0 better :)
>>> Could it be the reason of dynamic allocation?
>>>
>> I just asked because I didn't know :) But ok, if you want me to do
>> some digging... It seems like having GPIO_DYNAMIC_BASE=512 is not
>> necessarily the reason of dynamic allocation, but instead just a way
>> to keep 0-512 range for legacy GPIO drivers which might use that area
>> to allocate GPIO numbers statically. It's mentioned here:
>>
>>      /*
>>       * At the end we want all GPIOs to be dynamically allocated from 0.
>>       * However, some legacy drivers still perform fixed allocation.
>>       * Until they are all fixed, leave 0-512 space for them.
>>       */
>>      #define GPIO_DYNAMIC_BASE    512
>>
>> As mentioned in another comment in gpiochip_add_data_with_key(), that
>> numberspace shouldn't matter and in the end should go away, as GPIO
>> sysfs interface is pretty much deprecated at this point, and everybody
>> should stick to GPIO descriptors.
>>
>> Anyway, now that it's clear that the base number change was intended
>> and shouldn't matter, for all patches in the series:
>>
>> Reviewed-by: Sam Protsenko<semen.protsenko@linaro.org>
>> Tested-by: Sam Protsenko<semen.protsenko@linaro.org>
> If all the GPIOs changed due to switch to dynamic allocation, aren't we
> breaking all user-space users?

This /sys based GPIO interface is deprecated, so I don't think that 
stable numbers is something that we should care.

Userspace, if still uses /sys interface, should depend on the GPIO bank 
name. I remember that the GPIO numbers varied between different kernel 
versions (also compared to the 'vendor kernels'), although I don't 
remember if this was Exynos related case or other.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

