Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1ED755AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGQErj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQErh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:47:37 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A9E52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:47:32 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230717044727epoutp03376aafc092c93bf0fbad04c492a4fe49~yjkdghdEe1198411984epoutp03U
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:47:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230717044727epoutp03376aafc092c93bf0fbad04c492a4fe49~yjkdghdEe1198411984epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689569247;
        bh=s0aIP7eq2+shllEHO2v+rEDaAu63Qjj2b7EetgnQbPk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Gv+nMTYBXFWgcDASd8OtHrdqVBWsI2yIG4eji0danZLor0j2lXPX5ckil/MYGm35t
         Cm59cNb8F9BP0t0j44uJqJkmiID6q8+OxaWDv0t9NtBOo76XzPGPCJpPm4EDI2Ff6n
         7raaBVBlIEfIMMVWW+o3jn6vEzCErGvQmM/3/YN8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230717044726epcas2p4a4c6d4267b55a4e852756fd1a1db1596~yjkcZUp2F3089930899epcas2p4J;
        Mon, 17 Jul 2023 04:47:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R48hF5Gmrz4x9QD; Mon, 17 Jul
        2023 04:47:25 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.34.32606.DD7C4B46; Mon, 17 Jul 2023 13:47:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230717044725epcas2p1d4c5ff831ec6de5d53600a595b1d68f0~yjkbh1ooC2360423604epcas2p1V;
        Mon, 17 Jul 2023 04:47:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230717044725epsmtrp2723f77300b0360fe2b9751c00198f75f~yjkbg1A9z1719217192epsmtrp2L;
        Mon, 17 Jul 2023 04:47:25 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-c3-64b4c7dd7dd6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.79.30535.DD7C4B46; Mon, 17 Jul 2023 13:47:25 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717044724epsmtip276bed577e8f137c2e8eb8ff408add66d~yjkbObyVt2206022060epsmtip2d;
        Mon, 17 Jul 2023 04:47:24 +0000 (GMT)
Message-ID: <ef5341dc-3539-ef20-84bb-b32c0b76be2b@samsung.com>
Date:   Mon, 17 Jul 2023 13:44:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9
 SoC
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20230715072203.ecz7wg4novvhpyuj@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmue7d41tSDH490LB4MG8bm8Xl/doW
        a/aeY7KYf+Qcq0Xfi4fMFpseX2O1uLxrDpvF3burGC1mnN/HZNG69wi7xc9d81gsbk+czOjA
        47Fz1l12j02rOtk87lzbw+axeUm9R/9fA4++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH73SfWgo8sFVc2HmBuYHzE
        3MXIySEhYCJxZnozexcjF4eQwA5Gidn/ZzBDOJ8YJZacWcIC4XxjlHjQsZYNpmX/ixdMEIm9
        jBKH759ig3BeM0r0PHnAClLFK2Ancar7IhOIzSKgKnH48UU2iLigxMmZT1hAbFGBaInWZffB
        4sIC/hITb60CqufgEBFwk/i4ThJkJrPAMmaJZSfvg81hFhCXuPVkPpjNJqAt8X39YrBdnAK2
        EhMP9DFD1MhLNG+dDfaDhMABDomONedYIM52kTi/dxnU18ISr45vYYewpSQ+v9sL9Vq2RPv0
        P6wQdoXExQ2zoeLGErOetTOCHMcsoCmxfpc+iCkhoCxx5BYLxFo+iY7Df9khwrwSHW1CEI1q
        EvennoMaIiMx6chKJgjbQ+LEgTusExgVZyEFyiwkT85C8swshL0LGFlWMYqlFhTnpqcWGxUY
        wyM7OT93EyM4BWu572Cc8faD3iFGJg7GQ4wSHMxKIrzfV21KEeJNSaysSi3Kjy8qzUktPsRo
        CoyaicxSosn5wCyQVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QD
        0z7fiTaGWxs/zQqRarxkFPnI83PbgpurDDdsj+pqs1a3vB3Gt+jKChuWHVX8nQuDXKX9FdTr
        XT/M5dvLeKio42r09phDnAaxZ1f7PLpx8mWLNsdOp+YC+zVrii6+4ObzyWWdl7Fblpd3dtmi
        FTFbuBs8Zz0pFa9tSjRTE7OvadrlkCNy3rpmxlX12W1a+2Y2hF2z2OlWX/L9vynvGcFz/UfS
        OhsclF+pXejZyXhVyflc97eHf/Mjk3+ePJJTW19x+8eqEob35yaYc56/delQ71V/z+c8zYyM
        AiuiFRUe6zJtVBP/M8Xl07+sN7InnNQy9OYv5Zp5l1N5TadWy4o/8bqKZYxXyrg+BJsVfTiv
        xFKckWioxVxUnAgAOYUNNEoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvO7d41tSDNqf8Vo8mLeNzeLyfm2L
        NXvPMVnMP3KO1aLvxUNmi02Pr7FaXN41h83i7t1VjBYzzu9jsmjde4Td4ueueSwWtydOZnTg
        8dg56y67x6ZVnWwed67tYfPYvKTeo/+vgUffllWMHp83yQWwR3HZpKTmZJalFunbJXBl7H73
        ibXgI0vFlY0HmBsYHzF3MXJySAiYSOx/8YKpi5GLQ0hgN6PEqUm32CESMhLLn/WxQdjCEvdb
        jrBCFL1klLi6ZgMrSIJXwE7iVPdFJhCbRUBV4vDji2wQcUGJkzOfsIDYogLREqs/XwCq5+AQ
        FvCVmLGPG8QUEXCT+LhOEmQks8AyZonvX/eCjRQS+MEocekeL4jNLCAucevJfLDxbALaEt/X
        Lwar4RSwlZh4oI8ZosZMomtrFyOELS/RvHU28wRGoVlIrpiFZNQsJC2zkLQsYGRZxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHHVaWjsY96z6oHeIkYmD8RCjBAezkgjv91WbUoR4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg2p94MrOlMGbR
        HFPlwryKN2+0NawEry1jnfz0lLvxjZyjX7eda41e731gR8Q08cZsTyUd8e3u+57M6X7RNGvm
        rzN2T/99LTtfqZQRxPVZjq/+nndOALfjzB/d3gr1f+fNia/Jjq/3m29Vc3DhVi/5PNMlKdeO
        S9j+eX/VooKJ9dxvzv0y7X6zvVlkp95lFmuPfqBzr36/XJLF1h+L7h2deJiv5yNHvnLNhmmz
        nv1n2n7v7tZyvklVXE29j33myS6Rc7L8zm/v//W3S/ELkb6l9l7/jF0vO3C7bk/5oLI3odPt
        +jEJloJ0/UoueQ8u6SYRFmO2s6ZCxlaT/3SIXtshYLGeIUnBTKP6ncZxjxIlluKMREMt5qLi
        RAD4fQK8KQMAAA==
X-CMS-MailID: 20230717044725epcas2p1d4c5ff831ec6de5d53600a595b1d68f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714101434epcas2p3e2475698c527ca72dee797225d3dad37
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
        <CGME20230714101434epcas2p3e2475698c527ca72dee797225d3dad37@epcas2p3.samsung.com>
        <20230714100929.94563-3-jaewon02.kim@samsung.com>
        <20230715072203.ecz7wg4novvhpyuj@pengutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On 23. 7. 15. 16:22, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Jul 14, 2023 at 07:09:28PM +0900, Jaewon Kim wrote:
>> Add new compatible string to support ExynosAutov9 SoC.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Looks good to me:
>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> What are the merge plans here? The whole series via pwm or a samsung
> tree? Or a mixture?

It would be nice to be merged whole series in the samsung tree.

Krzysztof could you apply all patch after your review?


>
> Best regards
> Uwe
>

Thanks

Jaewon Kim

