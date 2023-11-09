Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC57E6233
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjKIC1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKIC1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:27:14 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D01F2107
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:27:12 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231109022709epoutp014c6575c27353044f4ef8312a47f55263~V01y8goTR2052920529epoutp01C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:27:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231109022709epoutp014c6575c27353044f4ef8312a47f55263~V01y8goTR2052920529epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699496829;
        bh=148Nv/R4xwfaYgfoa7b3vLotGrSIrZ1xQmCOnQQG5Ao=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=QurT08xgTLvQdNRx8r2uVm/3QL3o/ZG5iICSQScEculVTUTs+XBQSM8RWSyAPcBmK
         u6q7UDHqbaP9rCTy70Qg2rifgpxW2BNPxvTxHaqw4JhouEvdgjdAnksLlYh2JC5Fso
         /1/PtP5RnRuUB72Bknp3/G2Fnh1F86+qSyd5WgsE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231109022709epcas2p1c5a0c7eeec3875f66893ac8f6b648a55~V01yb7oK42415624156epcas2p13;
        Thu,  9 Nov 2023 02:27:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SQm7J5Pjvz4x9Pr; Thu,  9 Nov
        2023 02:27:08 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.72.10006.C734C456; Thu,  9 Nov 2023 11:27:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231109022708epcas2p48a9e11286802937ba44d7ad1b59c2e8f~V01xo268e0369203692epcas2p4B;
        Thu,  9 Nov 2023 02:27:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231109022708epsmtrp2f90620f162c54647dd49f0736fff0366~V01xn4ke31230912309epsmtrp2D;
        Thu,  9 Nov 2023 02:27:08 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-3b-654c437ccd85
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.51.08755.C734C456; Thu,  9 Nov 2023 11:27:08 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231109022707epsmtip240febc3b2a9842745fc59ebaf8ffdadd~V01xTrzlC1363213632epsmtip2Q;
        Thu,  9 Nov 2023 02:27:07 +0000 (GMT)
Message-ID: <37c352a0-56ba-8c20-9d0c-01062a72beb5@samsung.com>
Date:   Thu, 9 Nov 2023 11:24:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH 01/10] dt-bindings: soc: samsung: exynos-sysreg: add
 exynosautov920 sysreg
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <41036a02-1ae6-44c5-a0b4-a5d3a33cdce4@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmhW6Ns0+qweJvmhYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp
        5CXmptoqufgE6Lpl5gB9oqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07M
        LS7NS9fLSy2xMjQwMDIFKkzIzniwcgljwUreij/fGlgaGD9xdjFyckgImEgsn9XG1MXIxSEk
        sINRYk7vDzYI5xOjRNf9y+wQzjdGiR2Pb7PBtJx/8RuqZS+jxNWGbmYI5zWjxNH2T6xdjBwc
        vAJ2Eo1XuUEaWARUJObt/sEIYvMKCEqcnPmEBcQWFYiWaF12H2yosECCxM8J+5hBbBGBD8wS
        L69ng8xkFnjAKDH33FewZmYBcYlbT+YzgdhsAtoS39cvZgWxOYF23Wp4wARRIy+x/e0cZohL
        P3BIbP9sCmG7SEzo3gz1gbDEq+Nb2CFsKYnP7/ZCxbMl2qf/YYWwKyQubpgNFTeWmPWsnRHk
        L2YBTYn1u/RBTAkBZYkjt1ggtvJJdBz+yw4R5pXoaBOCaFSTuD/1HNQQGYlJR1YyQdgeEj0z
        +pgnMCrOQgqUWUh+nIXkl1kIexcwsqxiFEstKM5NTy02KjCEx3Vyfu4mRnAa13LdwTj57Qe9
        Q4xMHIyHGCU4mJVEeC+Y+KQK8aYkVlalFuXHF5XmpBYfYjQFRs1EZinR5HxgJskriTc0sTQw
        MTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoGp1Ln+c6vW0u5qKdvOmh3rGpTD
        Ilg3XVeZL/Uqp+r48QPxt3visutvJH04vS66YYarv0R6t074YrbmM9d2TY+ZVxWROaN0Hv9s
        gXK9sHsxE+c3T/HTEkqbsW+DT3DidYn5i5q411mzBjvOYqtf99V1ksO511efx9n0f17yd/Pm
        3BOxP/yshX78tqjUK/i9P9KV4byzyXo/b6Ol57K9du8u/WYjunHVxzkRd3fVXf7e3l4YzdHs
        veZH8OoE6YuS9z1mOqXMcVzDWeb1LHSHvHhxUF1tVrlbkVRnQr/977N/bQ9fygvJvLZ3Y4Lk
        isjD04zm3W+0tzYXWH4lodP5mYuW08fVzWyqT7nvPmz4fk2JpTgj0VCLuag4EQDIUi6dbAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHeXcuOyqr03T4pl1saKiZORJ7s6ygqFMI6SdBP+hqJ7PcPO54
        KyqtDNHSyiJ06FZNE6dkOS/lrdIlXZ0VrlBHosNLaqXdvBU5LfDbD/63Bx4KEzfhblScKolV
        q+TxUtIRr2uTrt14ancoGzBuwVGfto5Elc0dAqQzdRDovL6KRJ+LV6Hm0Vohuj5XJkDVAxYC
        GXVzAL1rKCKR1WoAqMDcIkCv9LlCdKHZJERtY1kEmm7Q4sjQMO/ruXoN7BIzDzVWIVNtyCaZ
        XksTyTwqrhQyxpJ05vLvACavxgCYb9VrwqhIx+0KNj4uhVVv2hHjeLSvvARw5aK0uZ8ZeAaY
        dMgBDhSkA6F5eFaQAxwpMd0IYG53i3BRWAXLBvPIRXaGHzNNxKJpBMA7z9rnBYoS0Tvg2S4n
        uwenPaG2cQrYWUSvgM8LbbidJXQUrPjWSdjZmY6B01daMHuPC/0dgxMv3y4sY3QfgGX5/f8W
        ZgHUD04I7BGMdoXdNt0Ck/QG+KtKv1DlML/cndH3zxMEc2pzwCKvhfXjRdgVINYsuUSzpEqz
        JKJZErkJcANYyXK8MlbJyziZik315+VKPlkV6384QVkNFh7s6/MA1Bu++rcCAQVaAaQwqYuo
        MzCUFYsU8hMnWXVCtDo5nuVbgTuFS11FrsO5CjEdK09ij7Msx6r/qwLKwS1DIA7iTrN7QrGB
        iqjylJ2lfl8ys7zcB1IKR/ZWRqhuZD+m8kTexlOvf0Z9veTk2R9uqz+2f+tg7axHe6FWccN5
        NB1wM6V1iZJRNXErLLWr+9Mx78OyofueYQfa12s3eyide8aeJNTcvut15J7MKpFozuEREsu+
        pIvRVSpjODdRQbQxByXnRiPzw4OIZZ9/cWnS84ozU4otsbaqzm0jfLY5X+s6uU7/YWrNG9J9
        aMY3Lvh012RB0Y9nHrzPga6n6cE9vqWGiAerrTdDzKkWp8g/ISYUudxkjm9g3hsJJrGxd+f4
        TH9ugc3bjWsJHi7T+b1w6jl09s2PckulSwd3mZPi/FG5zBdT8/K/Fsn3+U8DAAA=
X-CMS-MailID: 20231109022708epcas2p48a9e11286802937ba44d7ad1b59c2e8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9@epcas2p3.samsung.com>
        <20231031094852.118677-2-jaewon02.kim@samsung.com>
        <41036a02-1ae6-44c5-a0b4-a5d3a33cdce4@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,


Thanks for reviewing these patches.


On 23. 11. 8. 16:41, Krzysztof Kozlowski wrote:
> On 31/10/2023 10:47, Jaewon Kim wrote:
>> Add compatible for ExynosAutov920 sysreg controllers.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   .../bindings/soc/samsung/samsung,exynos-sysreg.yaml        | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
>> index 163e912e9cad..aa2a29ec6072 100644
>> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
>> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
>> @@ -35,6 +35,7 @@ properties:
>>                 - samsung,exynos5433-sysreg
>>                 - samsung,exynos850-sysreg
>>                 - samsung,exynosautov9-sysreg
>> +              - samsung,exynosautov920-sysreg
> New devices should not be deprecated by default. Drop.
Okay, I will remove this line.
>
>>             - const: syscon
>>           deprecated: true
>>         - items:
>> @@ -50,6 +51,12 @@ properties:
>>                 - samsung,exynosautov9-peric1-sysreg
>>             - const: samsung,exynosautov9-sysreg
>>             - const: syscon
>> +      - items:
>> +          - enum:
>> +              - samsung,exynosautov920-peric0-sysreg
>> +              - samsung,exynosautov920-peric1-sysreg
>> +          - const: samsung,exynosautov920-sysreg
>> +          - const: syscon
>>   
>>     reg:
>>       maxItems: 1
> Best regards,
> Krzysztof
>
>
Thanks

Jaewon Kim

