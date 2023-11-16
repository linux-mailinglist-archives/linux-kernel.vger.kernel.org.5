Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52E7EDA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjKPDxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjKPDxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:53:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C78196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:53:12 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231116035310epoutp01baaacbcd500568334d68e5e90395afd8~X-h442vRb0543405434epoutp016
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:53:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231116035310epoutp01baaacbcd500568334d68e5e90395afd8~X-h442vRb0543405434epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700106790;
        bh=pIIlFTM4Wlq3IT9Jc9JjGxdZxFss84n5wkN7Qu/QvFI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HnGZdjSOmujFeu4XRtAKsWniNwYc8x3dy1r58F81UDg5uOM3Btl4b7BD+ULnciTi1
         aTdRlxPowcp96/V/NJbnvqSrGXohaz+YPWA2zvs3agxU7cPV+U3RkSSfWNxl5SsPbG
         ydbE/mAIS2fxnoqyCNqlLmEqaQdLE8R1HP7fQcMU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231116035309epcas2p12d3044f1a97efee4b72c81479cb7508d~X-h4WphoS1017910179epcas2p1u;
        Thu, 16 Nov 2023 03:53:09 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SW5jK1W4Nz4x9Pw; Thu, 16 Nov
        2023 03:53:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.F7.08648.52295556; Thu, 16 Nov 2023 12:53:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231116035308epcas2p2ccabb652c85571f3a2697deabd317169~X-h3g6DfU0293602936epcas2p2w;
        Thu, 16 Nov 2023 03:53:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231116035308epsmtrp1fd1f12486541cd5bdbd67a98dbb86a74~X-h3gATok2054420544epsmtrp1d;
        Thu, 16 Nov 2023 03:53:08 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-e2-6555922511a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.97.08755.42295556; Thu, 16 Nov 2023 12:53:08 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231116035308epsmtip1df9058ed61801aa00b83f8201c9303dc~X-h3LSI891299512995epsmtip18;
        Thu, 16 Nov 2023 03:53:08 +0000 (GMT)
Message-ID: <221efdec-4940-031c-73b1-30aed96c76b0@samsung.com>
Date:   Thu, 16 Nov 2023 12:50:21 +0900
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
In-Reply-To: <ae03b902-fa12-4a33-9a4f-ab3a5956ea5c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmua7qpNBUgwev2S0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnXFq5y/2gtmcFWd3bmVuYNzN3sXIySEhYCLxe81TRhBbSGAH
        o8TJtWxdjFxA9idGiad33jFDJL4xStz5XQ7T8O7hKaiivYwSp5ousEIUvWaUmHFPAcTmFbCT
        mDHhPxuIzSKgKjFn43EmiLigxMmZT1hAbFGBaInWZffBaoQFvCRO7dwDNodZQFzi1pP5YPUi
        AveZJV63VYMsYxZ4wCgx99xXsFPZBLQlvq9fDNbACbSs589lqGZ5ie1v5zCDNEgIvOCQuLrr
        NDPE2S4SfzpbGCFsYYlXx7dA/S8l8bK/DcrOlmif/ocVwq6QuLhhNhuEbSwx61k7UC8H0AJN
        ifW79EFMCQFliSO3WCDW8kl0HP7LDhHmlehoE4JoVJO4P/Uc1BAZiUlHVjJB2B4SzZOns01g
        VJyFFCqzkHw/C8kzsxD2LmBkWcUollpQnJuemmxUYAiP6uT83E2M4CSu5byD8cr8f3qHGJk4
        GA8xSnAwK4nwmsuFpArxpiRWVqUW5ccXleakFh9iNAXGzURmKdHkfGAeySuJNzSxNDAxMzM0
        NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgYln0+XSy8vj30zXWv510WZv80TXBcXP
        22+m8jXMK1j7+VDPnVfr73vcuOWtWt387Bj7UsaTx3OKalXsr0Y/dzqzIX9iwwqzmM0yN6+x
        +fuu+yh32Y+p+dHuGQrhP0TCzlXpPv9SuGNu+c6ihgXRVsF7CkRTpfMn/TL4l3JwVsaUhbWm
        WQ+u7xB4dkjl2zrbN6FXz+b1fYnN57e+H7BZ3kxH7+L+P1/4tpzSaHt13ebj3JBXuz3v/nbc
        W8BdUvggdFHIU0Pv2RmTE/rZvboP3NC7FjJ3L0fX9K2N3tPt7x/6LyP+5a3GhvUicT6f7jG4
        z3nrHLj8xu2dxTw7K3Ukyp789ni5LfJ4TYJ+XpxflWCXEktxRqKhFnNRcSIAv3fkCGsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnK7KpNBUg0l35S0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOLXzF3vBbM6Kszu3Mjcw7mbvYuTk
        kBAwkXj38BRbFyMXh5DAbkaJWzu3QiVkJJY/62ODsIUl7rccYYUoesko8XDvYbAiXgE7iRkT
        /oMVsQioSszZeJwJIi4ocXLmExYQW1QgWmL15wusILawgJfEqZ17wGxmAXGJW0/mM4EMFRF4
        zCzxcOp/ZhCHWeABo8TySY+g1v1ilJjfPR9sLJuAtsT39YvB2jmBVvf8uQw1ykyia2sXI4Qt
        L7H97RzmCYxCs5BcMgvJxllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
        EyM4hrU0dzBuX/VB7xAjEwfjIUYJDmYlEV5zuZBUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzi
        L3pThATSE0tSs1NTC1KLYLJMHJxSDUxL7xjP2r/72OztVlGrmU1vnSu9Ps85W6ggd8mDbRda
        InTmJhpOsNZon2D67/JC/SWT9/qw2MeUlbgtdK14Kze9zCPynMnJxDwDzh3++6OEPNxNmYu4
        Imqfehz86PP01h2Gr5+YbiT5xm+85qc0MXTtn7zPX2q4RIuqtwovStOxOP1D2cZOYvWsmhOx
        USoMW9rdm9ijzuecDv14oc9tzj0rGU+LSP/XC6TW9L+7+TLmCoO46ft7bXI2tXfW7+fYucbL
        vyi36nfvD01T25zs6pYrYqU890o3FBYv05qz4cpD06Mf5B9pewQomxanpXJd2Mf3+MOqwhtH
        j98NY/ZmldTRY/E+k3dkucYD/tpObSWW4oxEQy3mouJEAKXl4UxQAwAA
X-CMS-MailID: 20231116035308epcas2p2ccabb652c85571f3a2697deabd317169
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
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 15. 21:42, Krzysztof Kozlowski wrote:
> On 15/11/2023 10:56, Jaewon Kim wrote:
>> ExynosAutov920 GPIO has a different register structure.
>> In the existing Exynos series, EINT control register enumerated after
>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
>> However, in ExynosAutov920 SoC, the register that controls EINT belongs
>> to each GPIO group, and each GPIO group has 0x1000 align.
>>
>> This is a structure to protect the GPIO group with S2MPU in VM environment,
>> and will only be applied in ExynosAuto series SoCs.
> Checkpatch points some warnings:
>
> CHECK: Alignment should match open parenthesis
> CHECK: Lines should not end with a '('
> CHECK: Macro argument reuse 'reg' - possible side-effects?

I don`t know this happens.

When I did the checkpatch, there were no problems as shown below.

---

./scripts/checkpatch.pl 
0010-pinctrl-samsung-add-exynosautov920-pinctrl.patch
total: 0 errors, 0 warnings, 416 lines checked

0010-pinctrl-samsung-add-exynosautov920-pinctrl.patch has no obvious 
style problems and is ready for submission.

---

>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

