Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E97B30FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjI2LDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2LDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:03:10 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE70199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:03:07 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230929110303euoutp027e51d1affea0497ab1452a0f3f4fe66e~JWbiDLLxb2334423344euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230929110303euoutp027e51d1affea0497ab1452a0f3f4fe66e~JWbiDLLxb2334423344euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695985383;
        bh=D19NFYq3++rlITnbWR8zHW53drieAG+GCYTTtnsygtU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=CT+Fwaz0UpbF8dc9zBZkM5YBBguctM6Baeo4UuRtFZXM+u+Sj+It8xxLsVCYRX3aw
         qwCkNMMhCfE85PGB7nqjWYxbs/gQiPtOUpds3R7ejC8aq/oChTnvIOGU/wECLd8YOz
         ovBE0DLVIog8vUgLpaLItOMBViDUuZOPig1H7DGg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230929110303eucas1p151c1e03d7af82aa08292f4b170c1a907~JWbhjhKl83253032530eucas1p1w;
        Fri, 29 Sep 2023 11:03:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.DD.37758.6EEA6156; Fri, 29
        Sep 2023 12:03:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230929110302eucas1p277c1af9650c46aa7fb2248063bc2058c~JWbhCJkII1266112661eucas1p2m;
        Fri, 29 Sep 2023 11:03:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230929110302eusmtrp1fabbcf32103508664753dfc7bbd09636~JWbhBdl2N0423404234eusmtrp1L;
        Fri, 29 Sep 2023 11:03:02 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-83-6516aee60cd6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.36.10549.6EEA6156; Fri, 29
        Sep 2023 12:03:02 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230929110301eusmtip1970b4027ab237c393ac5dc1ee74dada8~JWbgHztH90710207102eusmtip1d;
        Fri, 29 Sep 2023 11:03:01 +0000 (GMT)
Message-ID: <a6f943be-a92f-f9ec-4103-7edc70a2c9a8@samsung.com>
Date:   Fri, 29 Sep 2023 13:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        m.majewski2@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <67a7d507-7025-ee3e-f388-0a96e11eae41@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7rP14mlGvywt3gwbxubxeH5FRZT
        Hz5hs/i+5TqTxbzPshZ7X29lt/h2pYPJYtPja6wWl3fNYbP43HuE0WLG+X1MFhOPTWa2mPtl
        KrPFk4d9bA58Hjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6jb8sqRo/Pm+QC2KO4bFJSczLL
        Uov07RK4Mr7c2cBSsJ6r4s/jXcwNjOs4uhg5OSQETCSuTXvJ3sXIxSEksIJRYveyBijnC6PE
        uZ9boZzPjBKfr/xmgmlZ83UfO4gtJLCcUeLtFF2Ioo+MEm2rXzCDJHgF7CTeT77GBmKzCKhK
        nFraBhUXlDg58wkLiC0qkCrR/OY82CBhgRCJScvmgtUwC4hL3HoynwlkqIjAdGaJKRsngJ3B
        LDCRSeLP0bNgVWwChhJdb7vANnACbWt6cIcRolteonnrbGaQBgmB2ZwSnw5MZIO420Vi6b+P
        zBC2sMSr41vYIWwZidOTe1ggGtoZJRb8vs8E4UxglGh4fosRospa4s65X0CTOIBWaEqs36UP
        EXaU2LDhPztIWEKAT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuMU9gVJqFFDCz
        kAJgFpJ3ZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwtZ3+d/zrDsYVrz7q
        HWJk4mA8xCjBwawkwvvwtlCqEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2amp
        BalFMFkmDk6pBibNvy90hDca/Go/OMejge9gkufborOpMbXM4vc8X01gTje8LLdB7vknlaJP
        gbxyVxZ27FN/IKK2x/GrXnqdtvKEo8/fyuqdZTKJ8lj4YevDJyl6gXtsrl8pfLB7f04oS7CI
        7R6uy97iCpVp3ednzzRMfcB08OKKOC3j/0fXz/64dFHGatYrn0QPy0q6zFjoX2yimLVL5oci
        v5oPr1jxl9iyE1UyTy0rjb5crUzwv6pwWf5AcI2YhUby4hT/s6ytroub/czu8pZWLL9yZdXP
        PZMZlF7tWnvU8lB+avpBrXybGLs1Vzqu5EgLPBJI29LXsGTaVPczPTYTBDjjyx5Evmta08QV
        ZBLbwRASzrfSTYmlOCPRUIu5qDgRAETN2nzcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7rP1omlGjw5rmDxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbDH3
        y1RmiycP+9gc+Dx2zrrL7rF4z0smj02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBH6dkU5ZeW
        pCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8ubOBpWA9V8Wf
        x7uYGxjXcXQxcnJICJhIrPm6jx3EFhJYyijx/b8GRFxG4uS0BlYIW1jiz7UuNoia94wSvzuF
        QWxeATuJ95OvgcVZBFQlTi1tY4aIC0qcnPmEBcQWFUiVOD1tEyOILSwQIjFp2VywGmYBcYlb
        T+YzdTFycYgITGeWeLPoMZjDLDCRSeLVpcvMII6QwGMmiX1zpoGtYBMwlOh6C3EGJ9Dqpgd3
        GCFGmUl0be2CsuUlmrfOZp7AKDQLySWzkGychaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz
        0vWS83M3MQJjeduxn5t3MM579VHvECMTB+MhRgkOZiUR3oe3hVKFeFMSK6tSi/Lji0pzUosP
        MZoCg2Mis5Rocj4wmeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTA1ixufL4tl2jlh+bf9Vhey1J4r+IjN5iyZuEtg6VQ+puK4LNMN5+PY4iefkXPydd+lkjdz
        8uYAjfCmK3vSEzd/Eiu9cyZKn/XY0Ve2JYfXtCvu2eF25vrtDU6d87aoTHH/28TDOc1LwXBq
        hvj5Q077v9wS9+978+6gVs0xk1vhPuEN+ZHsDfsFlnpfPaETmKr9aPZfgaJnRxzKA/jT/tzo
        fhtittur4PfNM0Hpm6X+9EUuT36fkzdbt0ZXp3rVvv0J+6ovWQpt3Hlqwtmv7MKNv+UX/l4T
        0XDc2fajv1bFt5ULf51402M2cZbLjzOJy9N2iCxWmN7+23Cq/fPLUz3V576fYMscVRztIiDE
        8PG1EktxRqKhFnNRcSIAtswO2G4DAAA=
X-CMS-MailID: 20230929110302eucas1p277c1af9650c46aa7fb2248063bc2058c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
References: <bf9a07ff-5628-05ab-2362-a917d3d38313@linaro.org>
        <20230911133435.14061-1-m.majewski2@samsung.com>
        <20230911133435.14061-5-m.majewski2@samsung.com>
        <CGME20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311@eucms1p2>
        <20230926110239eucms1p2b539245c5b10591def4cd15f14896ad6@eucms1p2>
        <67a7d507-7025-ee3e-f388-0a96e11eae41@linaro.org>
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.2023 12:46, Daniel Lezcano wrote:
> On 26/09/2023 13:02, Mateusz Majewski wrote:
>> Hi,
>>
>>> This is not equivalent. If regulator is provided and enable fails, the
>>> old code is nicely returning error. Now, it will print misleading
>>> message - failed to get regulator - and continue.
>>>
>>> While this simplifies the code, it ignores important running 
>>> condition -
>>> having regulator enabled.
>>
>> Would doing this be correct?
>>
>> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
>> switch (ret) {
>> case 0:
>> case -ENODEV:
>
> Not sure to understand why -NODEV is not an error


Because this what devm_regulator_get_enable_optional() returns if no 
regulator is defined. I also got confused by this a few times.


>
>>     break;
>> case -EPROBE_DEFER:
>>     return -EPROBE_DEFER;
>> default:
>>     dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n",
>>         ret);
>>     return ret;
>> }
>
> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
> if (ret < 0) {
>     if (ret != EPROBE_DEFER)
>         dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n", 
> ret);
>     return ret;
> }
>
> ??
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

