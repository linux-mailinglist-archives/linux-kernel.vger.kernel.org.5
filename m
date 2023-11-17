Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165787EED6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjKQIQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjKQIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:10:46 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B714131
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:10:42 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231117081040epoutp01993c972a497b5718b245a9785fee4eeb~YWsAVELeK0969309693epoutp01v
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231117081040epoutp01993c972a497b5718b245a9785fee4eeb~YWsAVELeK0969309693epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700208640;
        bh=tRpB3896SyLcsMUDCM2XhWVI5aC9qRKxa02VqHFlm78=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=LGyeX04RSXWnCyBe83k77kUq039TI5CNuC8hVzUfrVc0zvqMlY3XEMP6qag9lvXAl
         Wi+uf6bX+11tVIwT1dwoPqDt6wPqS/d+bRZ146uOh3hDfBtbrSJakL1ELDKKCsK8US
         HYoYJCpPTRB6JUUvXSX/r+fPj7CFveEZ8aH+I6KA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231117081039epcas2p2693a4a160cf4d199d4979939608cbb66~YWr-06B793164431644epcas2p2_;
        Fri, 17 Nov 2023 08:10:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SWqMz2CwPz4x9Q2; Fri, 17 Nov
        2023 08:10:39 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.20.10022.FFF17556; Fri, 17 Nov 2023 17:10:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231117081038epcas2p2d3ee4bdc76859faa8776384aa89d92e5~YWr_5CSwq3164431644epcas2p24;
        Fri, 17 Nov 2023 08:10:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231117081038epsmtrp2e2713eb9e7350efb20c9e41d20ec7116~YWr_2YkS50744607446epsmtrp2u;
        Fri, 17 Nov 2023 08:10:38 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-cc-65571fff5626
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.FA.08817.EFF17556; Fri, 17 Nov 2023 17:10:38 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231117081038epsmtip1e87c5a0eb9614993019dcedd14b5da20~YWr_e0FI_2924529245epsmtip19;
        Fri, 17 Nov 2023 08:10:38 +0000 (GMT)
Message-ID: <8326bf22-f19f-6268-961a-41528ae7a0c2@samsung.com>
Date:   Fri, 17 Nov 2023 17:07:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/12] pinctrl: samsung: add exynosautov920 pinctrl
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
In-Reply-To: <b25df5a4-d426-418c-b8da-cc92f441f2bf@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmhe5/+fBUgxN7eSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfF6ykbGgvccFdPv9jM1ME5l72Lk5JAQMJH49nszcxcjF4eQ
        wA5Gib0btrBAOJ8YJQ6v38AG4XxjlFiy5hRQhgOs5WK/NUR8L6PEg/MrGSGc14wSsxdPZwSZ
        yytgJ9F77jcziM0ioCqxe+sfNoi4oMTJmU9YQGxRgWiJ1mX3weLCAl4Sp3buYQWxmQXEJW49
        mc8EYosI3GeWeN1WDbKAWeABo8Tcc1/BFrAJaEt8X78YrIETaNmVHXfZIJrlJba/nQP2kITA
        Fw6Js8ua2SA+dZH4+AVis4SAsMSr41ugISAl8fndXqiabIn26X9YIewKiYsbZkPFjSVmPWtn
        BHmfWUBTYv0ufUhIKEscucUCsZZPouPwX3aIMK9ER5sQRKOaxP2p56CGyEhMOrKSCcL2kGie
        PJ1tAqPiLKRQmYXk+1lInpmFsHcBI8sqRrHUguLc9NRiowJjeGQn5+duYgQnci33HYwz3n7Q
        O8TIxMF4iFGCg1lJhNdcLiRViDclsbIqtSg/vqg0J7X4EKMpMG4mMkuJJucDc0leSbyhiaWB
        iZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MhoEHb24QNis/W7/Ac4m9k3m7
        6aNJn/flrTt30Koi/wTzuj8nD/EyiPqbLDtUwRsubcc2M6vU1nJrJ4PWbrV7QtzrBAMmdD1m
        3ffW906v0p0vR2alTvdtqFI/vfm/1Iky7lURu65vNozmnsNnZ81V3qxjLpjlufKPwGSOD5LW
        3gZhtofzHiTO7WrbfMa6YtWxpy8yJthVZ1/SaGXZHcO4yM7upY6E4M4XpxsrRc3+bWw/9vVU
        dHlw00KBFfk+LYYmAgWfH+xlr9jdt5d33jH5jZaXE+Znh15/uG/aH+Wcj1JtX2VVla9FSfnM
        vzOFkVuj5p9oZMnkp4VXz4i0nt21Pqbx+HHtu1Fma09f2vdDiaU4I9FQi7moOBEA4dcBu20E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnO4/+fBUg9831SwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeD1lI2PBe46K6Xf7mRoYp7J3MXJw
        SAiYSFzst+5i5OQQEtjNKLHrlDeILSEgI7H8WR8bhC0scb/lCGsXIxdQzUtGiTPfX7CCJHgF
        7CR6z/1mBrFZBFQldm/9wwYRF5Q4OfMJC4gtKhAtsfrzBbB6YQEviVM794DZzALiEreezGcC
        GSoi8JhZ4uHU/8wgDrPAA0aJ5ZMeQa17zCTxeuIxJpAWNgFtie/rF4O1cwKtvrLjLhvEKDOJ
        rq1djBC2vMT2t3OYJzAKzUJyySwkG2chaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLS
        vHS95PzcTYzg+NXS2sG4Z9UHvUOMTByMhxglOJiVRHjN5UJShXhTEiurUovy44tKc1KLDzFK
        c7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBK139zaf4z32k2TzMcX9+Y8e/D0R+Lr63K
        rnIJSdDz3eIb0Wq/bkX/kg3BTv/LWw2PNPjdP3Zj4jLJU8kWwkZX/2903K4ey3DkyATWrVIN
        V3oD11Usyl/i4z3392Kj64tt2XSPzBW8Wp9U9sAo+bNRWF2U8QG2F39/nSm8rnTiMM8VpqiL
        n5JU5zQw5Kr0ZXp2t3yaen8Cl7f+lhtsuwIzzjWcznp1nOlBOTP/+8LwU+vVLpyPrmvT5fvI
        7feJn83htfeBybqzbWzm5ydlb/qh7bPrMpsA+/F/S0WNvht/bHL8HXWgcZPser3I/481Zlwt
        VYqI+M4au8Lvm5GSlwv3Xo1/9qe62i54RstP+XpGiaU4I9FQi7moOBEAEdAk6k4DAAA=
X-CMS-MailID: 20231117081038epcas2p2d3ee4bdc76859faa8776384aa89d92e5
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
        <ae03b902-fa12-4a33-9a4f-ab3a5956ea5c@linaro.org>
        <221efdec-4940-031c-73b1-30aed96c76b0@samsung.com>
        <b25df5a4-d426-418c-b8da-cc92f441f2bf@linaro.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> On 16/11/2023 04:50, Jaewon Kim wrote:
>> On 23. 11. 15. 21:42, Krzysztof Kozlowski wrote:
>>> On 15/11/2023 10:56, Jaewon Kim wrote:
>>>> ExynosAutov920 GPIO has a different register structure.
>>>> In the existing Exynos series, EINT control register enumerated after
>>>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
>>>> However, in ExynosAutov920 SoC, the register that controls EINT belongs
>>>> to each GPIO group, and each GPIO group has 0x1000 align.
>>>>
>>>> This is a structure to protect the GPIO group with S2MPU in VM environment,
>>>> and will only be applied in ExynosAuto series SoCs.
>>> Checkpatch points some warnings:
>>>
>>> CHECK: Alignment should match open parenthesis
>>> CHECK: Lines should not end with a '('
>>> CHECK: Macro argument reuse 'reg' - possible side-effects?
>> I don`t know this happens.
>>
>> When I did the checkpatch, there were no problems as shown below.
> Didn't you miss some arguments? Lime --strict?
>
 From next time, I will check with --strict option.

Thanks Krzysztof.


Thanks

Jaewon Kim


