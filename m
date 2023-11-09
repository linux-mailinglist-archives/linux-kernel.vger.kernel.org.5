Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57057E656E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjKIIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjKIIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:39:04 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA88270E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:39:02 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231109083900epoutp03ebc00c8f7c0110e71194e39e91574e69~V56dgilam1357013570epoutp03L
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:39:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231109083900epoutp03ebc00c8f7c0110e71194e39e91574e69~V56dgilam1357013570epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699519140;
        bh=IA8tVDEiR3OUTboPQ/PY/TxTQuBZRkJALEc43ISnuNw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=efnhyxMsGaqfr7z8Na7Z/qh30v8tBNgLijusUHWi6q01cSuhLt5yQfssJqyr41RTt
         rkbNP6cuPL/vDT3c54BV7m2c40IFjc/WQw7UkpjxXS3bvVSq8iwGEqmI/AYo78B6bt
         YoJJjPNED8O6l2y74/vmFNrRIUK1dURpFcBpJ1rI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231109083900epcas2p39eed51ad7909b12b62e08be1ac5800ee~V56dJWP7F1153011530epcas2p3N;
        Thu,  9 Nov 2023 08:39:00 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SQwNM3dj6z4x9Pp; Thu,  9 Nov
        2023 08:38:59 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.23.10006.3AA9C456; Thu,  9 Nov 2023 17:38:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231109083858epcas2p48cae9d866b6b51405c76b01156b4ce95~V56cIIqxB0079200792epcas2p4z;
        Thu,  9 Nov 2023 08:38:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231109083858epsmtrp2538ba1605409bc6c9cca25c453e2662c~V56cHPEKs2879728797epsmtrp24;
        Thu,  9 Nov 2023 08:38:58 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-20-654c9aa3d2f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.56.08817.2AA9C456; Thu,  9 Nov 2023 17:38:58 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231109083858epsmtip151265ef90607b87f0931ae4cf9ce8288~V56bwhdvF0398903989epsmtip16;
        Thu,  9 Nov 2023 08:38:58 +0000 (GMT)
Message-ID: <7c98023e-9207-c6fe-8a98-c8277c6d2c1a@samsung.com>
Date:   Thu, 9 Nov 2023 17:36:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH 04/10] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
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
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <545b681e-2da7-4adf-9c3c-0d292951ef94@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmqe7iWT6pBs+Wi1o8mLeNzWLN3nNM
        FvOPnGO1aF68ns3i3VwZi72vt7JbTPmznMli0+NrrBab5/9htLi8aw6bxd27qxgtZpzfx2Rx
        ZnEvu0Xr3iPsFofftLNa/Nw1j8Vi1S6gutsTJzM6CHnsnHWX3WPTqk42jzvX9rB57J+7ht1j
        85J6j/6/Bh59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQP0iZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgx
        t7g0L10vL7XEytDAwMgUqDAhO+Nq4wf2go3cFTMWnmdvYOzl7GLk5JAQMJHYcOY1SxcjF4eQ
        wA5GiY71n9ggnE+MEkceH2OFcL4xSpw9P58VpuXykutQLXsZJSbfW8YE4bxmlDj09Dc7SBWv
        gJ3E41d9YDaLgIrE8gkHmSHighInZz5hAbFFBaIlWpfdZwOxhQWCJaYvnQZmMwuIS9x6Mp8J
        xBYRqJP4Pukj2DZmgUssEksWvgMbxCagLfF9/WKwkziBlq2/3wXVLC/RvHU2M8Spbzgkft1O
        gLBdJI68bGCEsIUlXh3fwg5hS0l8freXDcLOlmif/gfqzQqJixtmQ8WNJWY9awfq5QCarymx
        fpc+iCkhoCxx5BYLxFY+iY7Df9khwrwSHW1CEI1qEvennoMaIiMx6chKJgjbQ2LyzVamCYyK
        s5ACZRaS52ch+WUWwt4FjCyrGMVSC4pz01OLjQoM4ZGdnJ+7iRGcyLVcdzBOfvtB7xAjEwfj
        IUYJDmYlEd4LJj6pQrwpiZVVqUX58UWlOanFhxhNgVEzkVlKNDkfmEvySuINTSwNTMzMDM2N
        TA3MlcR577XOTRESSE8sSc1OTS1ILYLpY+LglGpgWr1/zu/j8Y5rtfs1NT6XP/VqZ5rf/GbW
        /Mxz6yblPfv2+Zrg4T9brYr0JnUUSj48kLJjxY9ZfDXF04QSJ7h8dRY02x97z822eOnPTZFv
        K0y3/xLLnlwby/69ZqZ39j1FIZ3dGywS5spvMooVXblnRW3d08lBLXJrqwTynC66m1bsX5i2
        SPt7yukn7LotLv+y3LVlK1bb8KRunqGjl3HxoF/AkayDPgcn1iXqzWJ5c+z59VNSz65umT5t
        /gft26bpzBcCbic63+jfM+dCTodf1WKj1fwRd926RNe/ivy+h8tM31rmy62y/PmfWIqv7ZjO
        vursOVl+/pka1aWWspwlfcFTDRd6LTul6Xhyul2RqRJLcUaioRZzUXEiAGma4ohtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO6iWT6pBpceG1s8mLeNzWLN3nNM
        FvOPnGO1aF68ns3i3VwZi72vt7JbTPmznMli0+NrrBab5/9htLi8aw6bxd27qxgtZpzfx2Rx
        ZnEvu0Xr3iPsFofftLNa/Nw1j8Vi1S6gutsTJzM6CHnsnHWX3WPTqk42jzvX9rB57J+7ht1j
        85J6j/6/Bh59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcbXxA3vBRu6KGQvPszcw9nJ2MXJy
        SAiYSFxecp0FxBYS2M0o8WlrCERcRmL5sz42CFtY4n7LEVaImpeMErPf64DYvAJ2Eo9f9bGD
        2CwCKhLLJxxkhogLSpyc+QRspqhAtMTqzxfAeoUFgiWmL50GNpNZQFzi1pP5TCC2iECdxKqX
        f4HmcAHFr7BIvHr8hgnEERJYxyTReG47WAebgLbE9/WLwSZxAm1ef78LapKZRNfWLkYIW16i
        eets5gmMQrOQHDILycJZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMj
        OHq1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeCyY+qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5v73u
        TRESSE8sSc1OTS1ILYLJMnFwSjUwWa58IjpNT8dJ4+jmWU3b+Z0PJt959vhV4+LD2fluel53
        jqwyfvzv5eSMRWdSHxiF79zMO0mghoHP5MGFQqu4sMX/fl9bVxCUvJJZrCziNde1txZnYiId
        k7iTv54/cNuhebJmWZam6oEVfzrmvM2327d4X86UbL4/kz8I/fmwuOFcuqnQA/XTjz+9nxh4
        ZHvC2zTp7q+T77NHR3R9T2KaH8XTs/1kWsd1IWevJZ/dbv5bZjjvu9O8TR9Mti2Vubfy0P50
        0ZjGGyGM8tYzfWf8WlB/RDCwbdu5qk3/WSeWXu5mv2Gy2tNqWdfrshUTDt7wbPP/87pngmB0
        0LOGKJ6I3bGtt09dKp144Kiq/vq+L5uVWIozEg21mIuKEwFVLcuKTQMAAA==
X-CMS-MailID: 20231109083858epcas2p48cae9d866b6b51405c76b01156b4ce95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095017epcas2p306a504619cbaf1fc260f6c46f8b75dd8
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095017epcas2p306a504619cbaf1fc260f6c46f8b75dd8@epcas2p3.samsung.com>
        <20231031094852.118677-5-jaewon02.kim@samsung.com>
        <20231109062807.ko53f63arpxgigd5@pengutronix.de>
        <545b681e-2da7-4adf-9c3c-0d292951ef94@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 9. 17:23, Krzysztof Kozlowski wrote:
> On 09/11/2023 07:28, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Tue, Oct 31, 2023 at 06:47:46PM +0900, Jaewon Kim wrote:
>>> Add samsung,exynosautov920-pwm compatible string to binding document.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> ---
>>>   Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> index 2162f661ed5a..b6beca2ae81e 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> @@ -30,6 +30,7 @@ properties:
>>>         - items:
>>>             - enum:
>>>                 - samsung,exynosautov9-pwm
>>> +              - samsung,exynosautov920-pwm
>>>             - const: samsung,exynos4210-pwm
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> What is the merge plan here? Should this go via the pwm tree, or can it
>> better go via some exynos tree together with the dts files?
> I propose I will take it. I will have conflicting change and keeping
> bindings with DTS together allows smooth dtbs_check.
>
> Best regards,
> Krzysztof
>
>

I also agree it would be better to enter the exynos tree.

Thanks Krzysztof.


Thanks,

Jaewon Kim

