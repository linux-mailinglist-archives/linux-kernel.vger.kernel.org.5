Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9838C810D55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378822AbjLMIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378781AbjLMIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:10:37 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFAF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:10:42 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213081040epoutp024ec2e7b64d4ce0b70c3aecf0576ab361~gVdbwA_JB1658616586epoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213081040epoutp024ec2e7b64d4ce0b70c3aecf0576ab361~gVdbwA_JB1658616586epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702455040;
        bh=PdS2y8Co78/Fv1mYnqiLVsgstnUodpEglwoVK3SJid0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fRcovOwJsTHZFRhLPuLh6R8WT98nYam3zbIb+PxQ2d2sA+28Ge+2bS7j6k0Ad2mE9
         mnXqr22bKUYgABa5R2LZaeif12N9c6OtExh1m937tzBWgnlgzxmjN0GqGZ4+IV7Zva
         up1Ry7/PBIXqQqWF/z3IJGk/cRH6Gs5rGVTr7QTU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231213081040epcas2p493e0b33864a0d883c67bf2083174dec9~gVdbMt9mf2574525745epcas2p4G;
        Wed, 13 Dec 2023 08:10:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sqp7z4m1Lz4x9Q8; Wed, 13 Dec
        2023 08:10:39 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.DE.10006.FF669756; Wed, 13 Dec 2023 17:10:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231213081039epcas2p3cbe854e785e78a1a650b29fcb24ddc23~gVdaQApBI1435014350epcas2p3S;
        Wed, 13 Dec 2023 08:10:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081039epsmtrp291dfabcc572bf9c164ecc3a49596b3cc~gVdaPCzTk2160121601epsmtrp2B;
        Wed, 13 Dec 2023 08:10:39 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-f3-657966fffc7f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.86.18939.EF669756; Wed, 13 Dec 2023 17:10:39 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081038epsmtip20f8466aadc95bdb0b5a3cb4b7954ac2f~gVdZ5UpuW1538115381epsmtip2V;
        Wed, 13 Dec 2023 08:10:38 +0000 (GMT)
Message-ID: <2b72464e-d60a-6adc-0ef7-ed92ff495859@samsung.com>
Date:   Wed, 13 Dec 2023 17:10:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] pinctrl: samsung: add exynosautov920 pinctrl
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
In-Reply-To: <68a36910-e528-45ff-8b59-e7cd95aaef0b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmme7/tMpUgxvPVCwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfH24GLmgv3CFdtPsDQwdgp0MXJySAiYSDw73cfSxcjFISSw
        g1HiUcccJgjnE6PE/Y1/WOGccz9vssC0/Jw6C6plJ6PEq0fzoZzXjBKnty9jA6niFbCTWHf+
        KFgHi4CqxOqF51gg4oISJ2c+AbNFBaIlWpfdB6rn4BAW8JA4u98BJMwsIC5x68l8JhBbROA+
        s8TrtmqQ+cwCDxgl5p77ygiSYBPQlvi+fjEriM0JtOvPoWUsEM3yEtvfzmEGaZAQeMEh8Xvl
        f2aIs10kWh7vhXpBWOLV8S3sELaUxOd3e9kg7HyJtitnoOI1EhsXXGKEsO0lFp35yQ5yKLOA
        psT6XfogpoSAssSRW1Br+SQ6Dv9lhwjzSnS0CUE0qkncn3oOariMxKQjK5kgbA+JXb13WSYw
        Ks5CCpRZSL6fheSZWQh7FzCyrGIUSy0ozk1PLTYqMITHdXJ+7iZGcBrXct3BOPntB71DjEwc
        jIcYJTiYlUR4T+4oTxXiTUmsrEotyo8vKs1JLT7EaAqMmonMUqLJ+cBMklcSb2hiaWBiZmZo
        bmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA5Oyegd72szj+w65rtdc/eWt/a/9Llck
        nz2s3hm+Z48in2mw/T696hMGm+9vWiYkYnNpypL3xXMTG6ou31RKC39/9u66oKw8romT3wqI
        LXxy/Vtzbd3CY3NqviZ+arRNMCgIWXVn79SLS9ec4bl7Td5vllrBym17Tpfdrl95zm/NkzzW
        8kliZu82T1Le2bxIgde0qaaZwy3+2GymWt5Q/xzlpzN6TkiryPyLn1Pwodhyc4utSMnusPh/
        K6UOcz0/+SGhm+99k6BSQ9TSoB2cZ7QU/x9xOSHNs3Tbovx98ueUHcJDYxo9189cJmg9zaZp
        L79T1pnbt1R2Wi26H/uj7teVX7yHSnc7SzJ/7mMXm9yvxFKckWioxVxUnAgAQklvHmwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSvO7/tMpUg88zmSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeHtwMXPBfuGK7SdYGhg7BboYOTkk
        BEwkfk6dxdLFyMUhJLCdUWLKv3+sEAkZieXP+tggbGGJ+y1HWCGKXjJKbGvayAiS4BWwk1h3
        /igLiM0ioCqxeuE5Foi4oMTJmU/AbFGBaInVny8ANXNwCAt4SJzd7wASZhYQl7j1ZD4TyEwR
        gcfMEg+n/mcGcZgFHjBKLJ/0CGrbb0aJ481H2UFa2AS0Jb6vXwx2HifQ5j+HlrFAjDKT6Nra
        xQhhy0tsfzuHeQKj0Cwkh8xCsnEWkpZZSFoWMLKsYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/d
        xAiOW62gHYzL1v/VO8TIxMF4iFGCg1lJhPfkjvJUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzK
        OZ0pQgLpiSWp2ampBalFMFkmDk6pBiZBge+/Hj1foMcRqpLQdic58kvUp1oZ9ew9y59FzLg7
        O+lPYpblwdtZC+1K6rz+ry5rfKHzefkG2cgUa0VD9QDVBeHRvNnaxc8DZoXd2lCx/OCjPZFH
        p8llT78++XzpUmsZzTP8DZMYH86tY+R8c1z/UXPhzUyGzxw5v/cJnX72qoVTRIVxdjWr+gmZ
        XdxHe6uDNTq/rG8snMJ4Od122kantjftpTcbVs9luVOWk9+S1MSu/u3f1HnhN/vn2SqvmMzJ
        JnlznTO33f/ssxmXNEy38Cxunep7K3+qYZ3r0/THP18s8Qv/FvyrIPJesayD3hXBb3WK2zlc
        HRSSVG8adlZ7THJ3itthkFj18elREyWW4oxEQy3mouJEAHwSZJBKAwAA
X-CMS-MailID: 20231213081039epcas2p3cbe854e785e78a1a650b29fcb24ddc23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85
References: <20231211114145.106255-1-jaewon02.kim@samsung.com>
        <CGME20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85@epcas2p3.samsung.com>
        <20231211114145.106255-3-jaewon02.kim@samsung.com>
        <68a36910-e528-45ff-8b59-e7cd95aaef0b@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 12. 13. 16:52, Krzysztof Kozlowski wrote:
> On 11/12/2023 12:41, Jaewon Kim wrote:
>> Add pinctrl data for ExynosAutov920 SoC.
>> It has a newly applied pinctrl register layer for ExynosAuto series.
>>
>> Pinctrl data for ExynosAutoV920 SoC.
>>   - GPA0,GPA1 (10): External wake up interrupt
>>   - GPQ0 (2): SPMI (PMIC I/F)
>>   - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>   - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>   - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>   - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
>>   drivers/pinctrl/samsung/pinctrl-exynos.c      |  23 ++-
>>   drivers/pinctrl/samsung/pinctrl-exynos.h      |  25 ++++
>>   drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
>>   drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
>>   5 files changed, 190 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> index cb965cf93705..a998c296dd05 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> @@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
>>   	.ctrl		= fsd_pin_ctrl,
>>   	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
>>   };
>> +
>> +/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
>> +static const struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
>> +	EXYNOSV920_PIN_BANK_EINTW(8, 0x0000, "gpa0", 0x18, 0x24, 0x28),
>> +	EXYNOSV920_PIN_BANK_EINTW(2, 0x1000, "gpa1", 0x18, 0x20, 0x24),
>> +	EXYNOS850_PIN_BANK_EINTN(2, 0x2000, "gpq0"),
>> +};e
> Applied with re-ordering it, to keep it after ExynosAutov9. For the
> future: don't add entries to the end of lists because it causes exactly
> this issue we have here: unnecessary conflicts. Please keep this rule
> for entire development, not only pinctrl.
>
> If both you and Peter were observing this basic rule, I would not have
> work of reshuffling and fixing conflicts.
>
> Please check the result if I reshuffled/solved conflicts correctly.
>

I thought the new SoC should go to the end, but I was wrong.

I will follow your comments in alphabetical order.

Thanks you sincerely.


Thanks

Jaewon Kim


