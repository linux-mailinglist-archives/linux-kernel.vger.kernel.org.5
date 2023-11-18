Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4757EFE54
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKRHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjKRHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:46:23 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E8D5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:46:18 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231118074615epoutp0413efb68728ebe402c040a01d3e89feb0~Yp-_mLm7E2316923169epoutp04T
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:46:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231118074615epoutp0413efb68728ebe402c040a01d3e89feb0~Yp-_mLm7E2316923169epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700293575;
        bh=vxlFjRpQHG/9qO2SmYUUMv1L/YanqCR+lSiJehcyrD4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=vhGEcGX6mcyzUnuY+s3bpRiVQ3+jHYQ0QNCIeNuXd77t2huVm+sHnFXZCVFejDYtT
         P4j9PjmbE40H4v9C05W4bivsVciGIKu6kOv55gixk28uhQhSKyxNQJRc3o3HO+CquL
         8FZrCVIQKcfrGEvRcre8+ImayGmPDVpimta5/nlc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231118074614epcas2p151f840ee664d3130848da3fd7faf9105~Yp-9f4f6g3120531205epcas2p1L;
        Sat, 18 Nov 2023 07:46:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SXQnL22K3z4x9Pr; Sat, 18 Nov
        2023 07:46:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.09.09622.6CB68556; Sat, 18 Nov 2023 16:46:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231118074613epcas2p422f7c882546ce89461420d92a70f5ee3~Yp-8qrZNr1418714187epcas2p4R;
        Sat, 18 Nov 2023 07:46:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231118074613epsmtrp282137b87c7e7ca89811fd3644159abc4~Yp-8pDwxC2675426754epsmtrp2J;
        Sat, 18 Nov 2023 07:46:13 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-c8-65586bc6b895
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.C8.07368.5CB68556; Sat, 18 Nov 2023 16:46:13 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231118074613epsmtip2454513e84a2a41152fd3a056707b3d5d~Yp-8PetGS1672716727epsmtip2N;
        Sat, 18 Nov 2023 07:46:13 +0000 (GMT)
Message-ID: <ab17d61e-f645-9b76-962c-4ba2849c5f42@samsung.com>
Date:   Sat, 18 Nov 2023 16:43:26 +0900
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
In-Reply-To: <0fdb7bec-9ea4-454f-a0fb-d450f27ebc6b@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmue6x7IhUg4VP2C0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfH+03+Wgn08FSvunmJqYLzM2cXIySEhYCJxe9cz1i5GLg4h
        gR2MEpfebGGEcD4xSiz7+JkZwvnGKHG55QcrTEv3jbfsEIm9jBKTv99mgXBeM0qcmLCIGaSK
        V8BO4tiKGewgNouAqsSJm39ZIOKCEidnPgGzRQWiJVqX3WcDsYUFvCRO7dwDtoFZQFzi1pP5
        TCC2iMB9ZonXbdUgC5gFHjBKzD33lREkwSagLfF9/WKwBk6gZQePvGWGaJaXaN46G+xuCYE3
        HBIXV05mg7jbReL7sU6oH4QlXh3fwg5hS0l8frcXqiZbon36H6iaComLG2ZDxY0lZj1rB1rM
        AbRAU2L9Ln0QU0JAWeLILRaItXwSHYf/skOEeSU62oQgGtUk7k89BzVERmLSkZVMELaHRPPk
        6WwTGBVnIYXKLCTfz0LyzCyEvQsYWVYxiqUWFOempxYbFRjBYzs5P3cTIziVa7ntYJzy9oPe
        IUYmDsZDjBIczEoivN+EIlKFeFMSK6tSi/Lji0pzUosPMZoC42Yis5Rocj4wm+SVxBuaWBqY
        mJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cBkdDZiq4kNR2FVr5x8VrAta79o
        qdCW4kszNLY+/ruGjSG0aFnA/V/F2wTU74WJB31ZxG3rIBLDK7Vso+/0n8sdu7dFXtBX2xV9
        VebS9zXTAh37GQ2eznqY9pp//p3aMu8w5kfC1UIfpy/MMJu2+FTCQuOwJ+G/Tr/gMI2pqMib
        MeedhuvaEzOYY5jFTpQYL72T47D70BIv46x3Z5RiIr3j/ic7bF70vvzfXQ+DRec/yzgLerTy
        5DlNvfR9h04nz3zr6w+/S/7+yhmqI+bac+7fmhqp9ovxt2VfPF7yL7BOe79Vb53u7cJVT4+w
        Xzm7ct96BivljAKNoOu5Gj7b1zLtndx+/v6XU8uZjNdVfrqnxFKckWioxVxUnAgAduB9v24E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO7R7IhUg9WT5C0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeP/pP0vBPp6KFXdPMTUwXubsYuTk
        kBAwkei+8Za9i5GLQ0hgN6PEze5eRoiEjMTyZ31sELawxP2WI6wQRS8ZJS4tewpWxCtgJ3Fs
        xQx2EJtFQFXixM2/LBBxQYmTM5+A2aIC0RKrP19gBbGFBbwkTu3cA2YzC4hL3HoynwlkqIjA
        Y2aJh1P/M4M4zAIPGCWWT3oEte4Ms8TlG01g69gEtCW+r18M1s4JtPrgkbfMEKPMJLq2djFC
        2PISzVtnM09gFJqF5JJZSDbOQtIyC0nLAkaWVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5
        uZsYwTGspbGD8d78f3qHGJk4GA8xSnAwK4nwfhOKSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        azhjdoqQQHpiSWp2ampBahFMlomDU6qByY7ndO2ulclNgdJdMQli2j7tllfOP5slxmC4+mvp
        5JTALTcmfGM2Oa6+c9LjQ7ETWmf5x7sZHUhve2TduL/o49K55+8etotP+um+oPyJmYqXc6eq
        HqOO377zLxczcgRKsEgvkTycGGlj1j+F9Z071w3uiKr92mZsZe8vvrmu+7Kg9Y8Od9eSkumH
        SssWNn6vzYkxb7A0at3mmqlgXXdZXT6T7eCUCY2sJWfqDySeWGQdLZ2pFp+3y4e16mBQxq+z
        lVvXVlfpfs/2VWzezhqmvSV0vo3+lq8f2gX2GTZay7wS5w75Xvjz2oSzvSYFbEWrxcwseR94
        fIiS75vifMaGMf3dLTZZzlnTd/+uPqrEUpyRaKjFXFScCAB1RboDUAMAAA==
X-CMS-MailID: 20231118074613epcas2p422f7c882546ce89461420d92a70f5ee3
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
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 17. 19:48, Krzysztof Kozlowski wrote:
> On 17/11/2023 08:36, Jaewon Kim wrote:
>>>> The reason why I chose variable name 'combine' is that EINT registers was
>>>> separated from gpio control address. However, in exynosautov920 EINT
>>>> registers combined with GPx group. So I chose "combine" word.
>>> What does it mean "the GPx group"? Combined means the same place, the
>>> same register. I could imagine offset is 0x4, what I wrote last time.
>>>
>>> Is the offset 0x4?

If you are asking about the offset of GPIO control register and EINT 
control register, 0x4 is correct.

There is no empty space between the two register.


0x0 CON

0x4 DAT

0x8 PUD

0xc DRV

0x10 CONPDN

0x14 PUDPDN

0x18 EINT_CON

0x1c EINT_FLTCON

0x20 or 0x24 EINT_MASK (The size of FLTCON register depending on the 
number of gpio)

0x24 or 0x28 EINT_PEND


>>>
>>>
>>>> Is another reasonable word, I will change it.
>>> Why you cannot store the offset?
>>>
>>>> EINT registers related to the entire group(e.g SVC) were at the end of
>>>> the GPIO block and are now moved to 0xf000.
>>> So not in the same register, not combined?
>>>
>> Okay,
>>
>> Instead of the word combine, I will think of a better word in next version.
> I want to know answer to:
>
> "Why you cannot store the offset?"
>
I did not understand exactly what you said, but if i guess,,

you want to get rid of the offs because the value of the offs is always 
the same?

#define EXYNOSV920_PIN_BANK_EINTG(pins, reg, id, offs, mask_offs, pend_offs)


Thanks

Jaewon Kim

