Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1777EDC88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjKPICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjKPICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:02:00 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2931B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:01:52 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231116080149epoutp011d2c24317deb8f9aa9596332585e2122~YC6-RDIUU1433814338epoutp01h
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:01:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231116080149epoutp011d2c24317deb8f9aa9596332585e2122~YC6-RDIUU1433814338epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700121709;
        bh=TBbO7iBclxfuW4EBG0I88RBSDHlp7OHLhY3ApZFcSmY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nNLbm/msH7xKjpP354n2yLw8qhoOakGpiQPRc24OKJB7XpafyRDPratyaEImCSQHn
         ZkvRhXrJqOwjbKqbG69bqlsjEqpcTBAegRg8LFjoGoxOzs5m9EkBY9paXLnjij+vo4
         hLPegzXwEi82ktc8gisci+G7RmNZ1LDVWqWnJeVw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231116080148epcas2p2a21f6ecb885d3377882c2f1343c4a987~YC6_uNipo1423114231epcas2p2V;
        Thu, 16 Nov 2023 08:01:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SWCDC6rvkz4x9Pw; Thu, 16 Nov
        2023 08:01:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.FF.09622.B6CC5556; Thu, 16 Nov 2023 17:01:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231116080147epcas2p1211d42721f485b617fec2ff11102726c~YC69yMOGa1989619896epcas2p1U;
        Thu, 16 Nov 2023 08:01:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231116080147epsmtrp23ccd4b9684f7e196a25ae91c02f57525~YC69xKMV52973929739epsmtrp27;
        Thu, 16 Nov 2023 08:01:47 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-5a-6555cc6b1135
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.83.07368.B6CC5556; Thu, 16 Nov 2023 17:01:47 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231116080147epsmtip2751449db92a1db80522202c924313615~YC69aPBUy2106821068epsmtip2f;
        Thu, 16 Nov 2023 08:01:47 +0000 (GMT)
Message-ID: <87f3616f-42e4-3713-e5ce-6c3a1914c565@samsung.com>
Date:   Thu, 16 Nov 2023 16:59:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20231116075635.onolshbu4waqsqag@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmuW72mdBUg/9XTC0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQndFyZCtLwQr2itltX1gaGBvZuhg5OSQETCSWNV9h7GLk4hAS
        2MEoMX/RPTYI5xOjxK1DE6Gcb4wSDWcXMsK0HLzygh0isZdR4v7/fVD9r4Favv9jBaniFbCT
        mL1vDwuIzSKgKnH27DF2iLigxMmZT8DiogLREq3L7oMdIizgKTF5/1/mLkYODhEBN4mP6yRB
        wswCXawS0zYyQtjiEreezGcCsdkEtCW+r18MtopTwFbi0Mr1zBA18hLNW2czg9wjIfCBQ+LL
        nyPMEFe7SPzbA9EgISAs8er4FnYIW0ri87u90MDIlmif/geqpkLi4obZUHFjiVnP2hlBbmMW
        0JRYv0sfxJQQUJY4cosFYi2fRMfhv+wQYV6JjjYhiEY1iftTz0ENkZGYdGQlE4TtIXGyYx/r
        BEbFWUhhMgvJk7OQPDMLYe8CRpZVjGKpBcW56anFRgVG8LhOzs/dxAhO41puOxinvP2gd4iR
        iYPxEKMEB7OSCK+5XEiqEG9KYmVValF+fFFpTmrxIUZTYMxMZJYSTc4HZpK8knhDE0sDEzMz
        Q3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqYIhc/uC8eFJ7urag/I0f52upwveIg
        I9up860z/hcE3avJiOb7va9emGmCxbw1j+5IbS68YHlHtPywxrXd8z3Zfn+IMrvxbuorK0WH
        KGFFXfYp9rYLrqb+e6e2ro9Hu9vh71d9AQeJW4cDBe/WfeKUPHXErzJpV4eET1raTPPFj+7K
        NDF2W9/IEnqYr3/NbsstRaaDK36wGcdeuvnvcO35OQpmcve/c7zWuCkqHN5u8kF47Vnb5esO
        fV9pw6Tw/LKv7OmH+m+ETi6V7kwM2/OzW/kId/gtK6UPEydfMZHy5S33ulQ079UypbQHKlpr
        uv7qXZy4wNSxN13Kf//pRdez1746Mjkl85XO4v6w90utlViKMxINtZiLihMBz6vvH2wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvG72mdBUg+6pohYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRHHZpKTmZJalFunbJXBltBzZylKwgr1idtsXlgbGRrYuRk4O
        CQETiYNXXrCD2EICuxklpn1ygojLSCx/1gdVIyxxv+UIaxcjF1DNS0aJr3e+MYEkeAXsJGbv
        28MCYrMIqEqcPXuMHSIuKHFy5hOwuKhAtMTqzxdYQWxhAU+Jyfv/MncxcnCICLhJfFwnCTKT
        WaCHVeJV3yWoBXOZJT5OPs0I0sAsIC5x68l8sGVsAtoS39cvBhvEKWArcWjlemaIGjOJrq1d
        UPXyEs1bZzNPYBSaheSOWUhGzULSMgtJywJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ
        +bmbGMHRq6Wxg/He/H96hxiZOBgPMUpwMCuJ8JrLhaQK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwLRDc/GzJyr5608psLKvj+T935N7LGjT1l6PyYeu
        995Zzb/Y547u9lUH5nLe8PHcrrQ58fZL63hF8bKf2371sZ7bkmMeJFosMHWBwdPVN/Pm6Gmm
        +2x48/Dd+xLlhrQ8C71qG2WvPRkH5z5TLewM3qE7ceYbrllfpii92PZpTR2z95k7dy4+8g2o
        PWZylcHXwPGH/LXnvwtZjdT2/d2mn7svlHuSV3bEURN/2W0dbi5xU7j6snL/Ta6YEx7qVvCi
        anED86byHbNUTT5JrK/05zdfuIthhcD3lcd/nt7mkvO/M2LNngPfqtjmWUcrrZlbtFquSMBD
        9UGnzfH/qdH7Vdfu38bKVWJ4JaXVaXF5p64SS3FGoqEWc1FxIgCQx9C0TQMAAA==
X-CMS-MailID: 20231116080147epcas2p1211d42721f485b617fec2ff11102726c
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
        <20231116075635.onolshbu4waqsqag@pengutronix.de>
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

Hello,


On 23. 11. 16. 16:56, Uwe Kleine-König wrote:
> Hello,
>
> On Thu, Nov 16, 2023 at 12:32:30PM +0900, Jaewon Kim wrote:
>> I already checked and there were no warnings or errors as shown below.
>>
>> Did I miss something??
>>
>>
>> $ make CHECK_DTBS=y ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>> exynos/exynosautov920-sadk.dtb
>>     LINT    Documentation/devicetree/bindings
>>     CHKDT Documentation/devicetree/bindings/processed-schema.json
>>     SCHEMA Documentation/devicetree/bindings/processed-schema.json
>>     UPD     include/config/kernel.release
>>     DTC_CHK arch/arm64/boot/dts/exynos/exynosautov920-sadk.dtb
> https://www.kernel.org/doc/html/latest/process/maintainer-soc-clean-dts.html
> also talks about W=1 that you didn't pass.

Thanks Uwe,

I found Warning when I add W=1.

I will fix it in next version.

>
> Best regards
> Uwe
>

Thanks

Jaewon Kim

