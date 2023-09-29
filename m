Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72847B31F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjI2MBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2MA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:00:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97734193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:00:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230929120056euoutp0113ed526f68e0451378d4876768e901fc~JXOEGvFAN2462624626euoutp018
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230929120056euoutp0113ed526f68e0451378d4876768e901fc~JXOEGvFAN2462624626euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695988856;
        bh=fzvHSn0K/vvih3FBWJPttdyUhHofQi37Qv2N4vHM+dc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YlAOE6KO39foXMczY0kuWg1q53nHq8+xhwyxePHjbf1IP43e5kLL8/elaJulkhFmx
         f0/G4UrzntWIQ5IuVqo29pIrsXtNQ+czkuVs4VLUGE+gTKyI8uLdX/h3RIV/lf/KJ2
         zE5BuRFctAj365LUiKgccjEtn86AguLjbkegudFo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230929120055eucas1p23557fafbd1fad7c23d4016d660b62deb~JXODvNdFe0038200382eucas1p2d;
        Fri, 29 Sep 2023 12:00:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.7A.37758.77CB6156; Fri, 29
        Sep 2023 13:00:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230929120055eucas1p2393f113d877b1c7055439992f9fa9771~JXODSzeMx1799717997eucas1p2P;
        Fri, 29 Sep 2023 12:00:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230929120055eusmtrp1cbf9f790a06b73df4b66710388f0ce74~JXODR0de60425004250eusmtrp1J;
        Fri, 29 Sep 2023 12:00:55 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ea-6516bc77d5cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.FC.25043.77CB6156; Fri, 29
        Sep 2023 13:00:55 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230929120054eusmtip12edfc5cbaef7cbc98f335181d3e0ba70~JXOCV8Ods1347113471eusmtip1K;
        Fri, 29 Sep 2023 12:00:54 +0000 (GMT)
Message-ID: <2e688177-7a69-051f-2d2c-c8067c38f3be@samsung.com>
Date:   Fri, 29 Sep 2023 14:00:54 +0200
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
In-Reply-To: <10e6377e-ab3f-c318-9860-56ff3b8aed92@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87rle8RSDc52GVg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouJxyYzW8z9
        MpXZ4snDPjYHPo+ds+6yeyze85LJY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAexRXDYpqTmZ
        ZalF+nYJXBmLZ/1lLZjFXbHqxmemBsYezi5GTg4JAROJTd+/MHYxcnEICaxglDh3qYUNwvnC
        KPFh1TlGkCohgc+MEo9XG8B03G9ugOpYziix9N9sZoiij4wSb07ygNi8AnYSPQ9WgjWzCKhK
        fP12iR0iLihxcuYTFhBbVCBVovnNebC4sECIxKRlc8HmMAuIS9x6Mp8JZIGIwHRmiSkbJ7CD
        OMwCE5kk/hw9C1bFJmAo0fW2iw3E5gTaNudKAztEt7zE9rdzmEEaJARmc0osu7yZBeJuF4mj
        6w8wQdjCEq+Ob2GHsGUkTk/uYYFoaGeUWPD7PhOEM4FRouH5LUaIKmuJO+d+Aa3jAFqhKbF+
        lz5E2FFiw4b/7CBhCQE+iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRZS
        wMxCCoBZSN6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMDUdvrf8a87GFe8
        +qh3iJGJg/EQowQHs5II78PbQqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRm
        p6YWpBbBZJk4OKUamLolp4Z1B//ILU5kPSYVeEt9y90nG3k3fnbeeH2zw9b9db99UhnXGS9b
        ZBmrf3FpxMYyhWV76ppP7soSO5zNvaX5zY49FzJm3lLarWvUIvurY8aC6It2t5q2TWH0kFjW
        a1Pt+LAnldfQ7lz2aSPu5oudTDrqa45M+9Sx9E7lcqtL5+Vl1Pau2eMn4H3Wesbds2x8v0Q+
        tRTunXbNTOG5SbvJvxUXbhytescp8PjLRfHbS6df/NL+tbZyxYkL7SzRIY8eKalOjG14tCb5
        uO65Pfm/loY9+pl6yXj77f/feBMnMJyevnZ9nIgL5wzF8NtJjpJ9YlOsSvcpyUjL/fBx+PLk
        QEzETg39j6Wb0m7/PNmpxFKckWioxVxUnAgA4l4CrdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7rle8RSDZ485rN4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtpj7
        ZSqzxZOHfWwOfB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtij9GyK8ktL
        UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIWz/rLWjCLu2LV
        jc9MDYw9nF2MnBwSAiYS95sbGLsYuTiEBJYySuxd/pkVIiEjcXJaA5QtLPHnWhcbRNF7Rond
        /U/AErwCdhI9D1YygtgsAqoSX79dYoeIC0qcnPmEBcQWFUiVOD1tE1iNsECIxKRlc5lBbGYB
        cYlbT+YzgQwVEZjOLPFm0WMwh1lgIpPEq0uXmSHWnWGWOL9mI9goNgFDia63IHdwcnACrZ5z
        pYEdYpSZRNfWLkYIW15i+9s5zBMYhWYhuWQWko2zkLTMQtKygJFlFaNIamlxbnpusZFecWJu
        cWleul5yfu4mRmA8bzv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+/C2UKoQb0piZVVqUX58UWlO
        avEhRlNgcExklhJNzgcmlLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4m
        Dk6pBqbAqh8KLS2Gnt5nNqgc1//Hall7kCmmdnPkTjOtZPVzKUrvnzlLx/SHLUtQb/aO8Pn/
        M1HnjYhh0KvyG5+Xa/8VUY9f1OWtV7kq96+DE48So6Fls75v/TzD1yc9Op4deTBrj+H5xyfO
        Jz/6b/8kY77J+mfn7VkyT97ucl7KvbG47vz2WJH+kH8fzkwRMvKfWcQUJV8eIGI0Q7f+998Y
        Dn8VPw+L4O/+Lv0+x9k2XLT9b2Qf92X68ajKTTG25SX2+1YvTXef6Ka64dJLuwmFC8+4/zJP
        ka3riHbk42n6xF66af+y+Lnvprz+HfLu6XHFh48j45tF4y3d9LUNVlwxXXPCP5J929wX1kKJ
        1jKBSizFGYmGWsxFxYkA08m5unADAAA=
X-CMS-MailID: 20230929120055eucas1p2393f113d877b1c7055439992f9fa9771
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
        <a6f943be-a92f-f9ec-4103-7edc70a2c9a8@samsung.com>
        <10e6377e-ab3f-c318-9860-56ff3b8aed92@linaro.org>
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.2023 13:45, Daniel Lezcano wrote:
> On 29/09/2023 13:03, Marek Szyprowski wrote:
>> On 29.09.2023 12:46, Daniel Lezcano wrote:
>>> On 26/09/2023 13:02, Mateusz Majewski wrote:
>>>> Hi,
>>>>
>>>>> This is not equivalent. If regulator is provided and enable fails, 
>>>>> the
>>>>> old code is nicely returning error. Now, it will print misleading
>>>>> message - failed to get regulator - and continue.
>>>>>
>>>>> While this simplifies the code, it ignores important running
>>>>> condition -
>>>>> having regulator enabled.
>>>>
>>>> Would doing this be correct?
>>>>
>>>> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
>>>> switch (ret) {
>>>> case 0:
>>>> case -ENODEV:
>>>
>>> Not sure to understand why -NODEV is not an error
>>
>>
>> Because this what devm_regulator_get_enable_optional() returns if no
>> regulator is defined. I also got confused by this a few times.
>
> The code before this change calls devm_regulator_get_optional() which 
> returns -ENODEV too, right ? But there is no special case for this error.
>
> So this change uses devm_regulator_get_enable_optional() and handle 
> the ENODEV as a non-error, so there is a change in the behavior.


It looks that the original code ignores any non-EPROBE_DEFER errors from 
devm_regulator_get_optional(). That's a bug, indeed.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

