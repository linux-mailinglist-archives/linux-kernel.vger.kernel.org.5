Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAB7D3822
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjJWNeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:34:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E30E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:33:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231023133356euoutp01137e872b551bc05458ce69562e5bfa09~Qv_H_miX62280222802euoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:33:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231023133356euoutp01137e872b551bc05458ce69562e5bfa09~Qv_H_miX62280222802euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698068036;
        bh=evxQ8tCyzH/t/91UbRlG74iJQWJWA/MZI+8ig+JYy5Y=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=cT+vLaELTJJBSQLatNdzUz2WJig6HLJ0ZgGimfEebPLhAqLThfCxvGG5D2GEP9hSA
         ax8Nksw88fnEz2GPzeoSNsgI+wYK3hXT4qSUWRgzA2t/i6y+hCRQbduWQvT+3yP1bh
         d5EuqZyO1l9WRi3Wykx+XOzwIgEHuxyhkbiN2peo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231023133356eucas1p1e8dc3a6ba3739aa70b16bf98b20995ed~Qv_Hq0Mb00344203442eucas1p1t;
        Mon, 23 Oct 2023 13:33:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.5A.42423.44676356; Mon, 23
        Oct 2023 14:33:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231023133356eucas1p211feaced9ffd0a158c3fcf3146c05f8f~Qv_HMJP9E2004320043eucas1p2B;
        Mon, 23 Oct 2023 13:33:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231023133356eusmtrp1360c760c3d6a5837abaf0742febfb6f9~Qv_HLOESI2193521935eusmtrp1D;
        Mon, 23 Oct 2023 13:33:56 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-33-6536764474d9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.69.25043.34676356; Mon, 23
        Oct 2023 14:33:55 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231023133355eusmtip1909ee50239ea01d4845738bb4610f654~Qv_GPM10Q2355723557eusmtip1Z;
        Mon, 23 Oct 2023 13:33:54 +0000 (GMT)
Message-ID: <fa7f1b3e-eb85-4b6d-b8e3-f26efa059748@samsung.com>
Date:   Mon, 23 Oct 2023 15:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] thermal: exynos: split initialization of TMU and
 the thermal zone
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <91b3ff5a-cfdf-4bba-806e-093a90746d86@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7ouZWapBmf2Sls8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2mPtlKrPFk4d9bA78HmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxenze
        JBfAEcVlk5Kak1mWWqRvl8CVsfHmYtaCmwoVry/dYGlgPCvdxcjJISFgInG78x4biC0ksIJR
        ov9ZQBcjF5D9hVFiyemXrBDOZ0aJaYtPsMB0zO9oZYFILGeUWHVxA5TzkVGie+JzVpAqXgE7
        iaOvWxm7GDk4WARUJW7uLYcIC0qcnPkEbJCogLzE/Vsz2EFsYYF4ie0n14K1MguIS9x6Mp8J
        xBYRCJaY9mYB2HxmgT/MEhe/PQJrZhMwlOh62wV2N6eAtcSN5wvZIJrlJZq3zmYGaZAQWM8p
        cePsPHaIs10kdp34D/WCsMSr41ug4jISpyf3sEA0tDNKLPh9nwnCmcAo0fD8FiNElbXEnXO/
        2EDeYRbQlFi/Sx8i7Cix7vQMJpCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUH
        L1xinsCoNAspXGYh+X8WkndmIexdwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDZ
        nf53/NMOxrmvPuodYmTiYDzEKMHBrCTCOzvcJFWINyWxsiq1KD++qDQntfgQozQHi5I4r2qK
        fKqQQHpiSWp2ampBahFMlomDU6qByYAztO3TszetHzN21jIytf44GD3poMJXNnbZrxZ7Tyxu
        uuMnMYN18hzuo3132U5GG/t2/1pZIsbxS8LBRft4wYXVP8INv+zf4DStt8zMRPPHylnFmlVC
        N2dPWDW7TNf9rm/ipgq3XLWXf4snhO2Qjj6Qf2yOZbfcplNHGvkf7bHhYXfz7F3ztbnCI+6p
        ZEdfn+SLwMiF+w7WObBeFxEoNd1o9tLs68e3BladX1syXYuvGEg4d34wc/3wasHSt7Oc1oua
        VibrGX4RClWWOvLX8labnr/vu73fFrvHypS8KDuy2/BXoWKZ8OKE/Ly/6W5ezxLv5B1lYb/r
        cN1fz8+dVbTP8vDT2Besc3wfrBRTYinOSDTUYi4qTgQAgK5GWeUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7rOZWapBr0rLS0ezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbzP0yldniycM+Ngd+jzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo++LasYPT5v
        kgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
        2HhzMWvBTYWK15dusDQwnpXuYuTkkBAwkZjf0crSxcjFISSwlFHiftd3RoiEjMTJaQ2sELaw
        xJ9rXWwQRe8ZJV6dfMIMkuAVsJM4+roVqIGDg0VAVeLm3nKIsKDEyZlPWEBsUQF5ifu3ZrCD
        2MIC8RLbT64Fm8ksIC5x68l8JhBbRCBYounxY0aQ+cwC/5glVv84AHXRN0aJCxsXg01iEzCU
        6HoLcgUnB6eAtcSN5wvZICaZSXRt7WKEsOUlmrfOZp7AKDQLySGzkCychaRlFpKWBYwsqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQLje9uxn1t2MK589VHvECMTB+MhRgkOZiUR3tnhJqlC
        vCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR+YYPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTS
        E0tSs1NTC1KLYPqYODilGph6WAySs+JWt92fV6co3XF4qcJ/l5Ivy4uLjVQvsf3qC+O883yG
        8uO9e186VHbtdd4vzPCn75vub+ejBrmb2sxnv9nf/fFEwdSrW1a1Jq3JUWHnshQLnBR82kB/
        Trjf/ojk5NdvdfuWTTRzW/l8Sc9rN+t6jc/Nb5aYLOaovHT/Cu+FdxNqqhgf7d7NJfBvwzyV
        MKPteQmWX0LPpN3sOTq//oPEwksyFzZbq0opzJzKomVr7X5gbyTHE+d9f7d3zr97/EJKoVb0
        Jgtzv5ZrtR2bbxtXba3d+TcnLG7ayZ2X7j9KF/V+sVJuXWHfpq9bYg7oKOr9/zQ9JO3pZ9/b
        Skuu/FLqfDdFcsJXdonjmrOnKrEUZyQaajEXFScCAAJIAkR4AwAA
X-CMS-MailID: 20231023133356eucas1p211feaced9ffd0a158c3fcf3146c05f8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a@eucas1p2.samsung.com>
        <20231003111638.241542-8-m.majewski2@samsung.com>
        <91b3ff5a-cfdf-4bba-806e-093a90746d86@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2023 14:59, Lukasz Luba wrote:
> On 10/3/23 12:16, Mateusz Majewski wrote:
>> This will be needed in the future, as the thermal zone subsystem might
>> call our callbacks right after devm_thermal_of_zone_register. Currently
>> we just make get_temp return EAGAIN in such case, but this will not be
>> possible with state-modifying callbacks, for instance set_trips.
>>
>> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
>> ---
>> v1 -> v2: We take clocks into account; exynos_tmu_initialize needs both
>>    clocks, as tmu_initialize might use the base_second registers. 
>> However,
>>    exynos_thermal_zone_configure only needs clk.
>>
>>   drivers/thermal/samsung/exynos_tmu.c | 104 +++++++++++++++------------
>>   1 file changed, 60 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c 
>> b/drivers/thermal/samsung/exynos_tmu.c
>> index 7138e001fa5a..343e27c61528 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -251,25 +251,8 @@ static void sanitize_temp_error(struct 
>> exynos_tmu_data *data, u32 trim_info)
>>   static int exynos_tmu_initialize(struct platform_device *pdev)
>>   {
>>       struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>> -    struct thermal_zone_device *tzd = data->tzd;
>> -    int num_trips = thermal_zone_get_num_trips(tzd);
>>       unsigned int status;
>> -    int ret = 0, temp;
>> -
>> -    ret = thermal_zone_get_crit_temp(tzd, &temp);
>> -    if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
>> -        dev_err(&pdev->dev,
>> -            "No CRITICAL trip point defined in device tree!\n");
>> -        goto out;
>> -    }
>> -
>> -    if (num_trips > data->ntrip) {
>> -        dev_info(&pdev->dev,
>> -             "More trip points than supported by this TMU.\n");
>> -        dev_info(&pdev->dev,
>> -             "%d trip points should be configured in polling mode.\n",
>> -             num_trips - data->ntrip);
>> -    }
>> +    int ret = 0;
>>         mutex_lock(&data->lock);
>>       clk_enable(data->clk);
>> @@ -280,32 +263,63 @@ static int exynos_tmu_initialize(struct 
>> platform_device *pdev)
>>       if (!status) {
>>           ret = -EBUSY;
>>       } else {
>> -        int i, ntrips =
>> -            min_t(int, num_trips, data->ntrip);
>> -
>>           data->tmu_initialize(pdev);
>> -
>> -        /* Write temperature code for rising and falling threshold */
>> -        for (i = 0; i < ntrips; i++) {
>> -
>> -            struct thermal_trip trip;
>> -
>> -            ret = thermal_zone_get_trip(tzd, i, &trip);
>> -            if (ret)
>> -                goto err;
>> -
>> -            data->tmu_set_trip_temp(data, i, trip.temperature / 
>> MCELSIUS);
>> -            data->tmu_set_trip_hyst(data, i, trip.temperature / 
>> MCELSIUS,
>> -                        trip.hysteresis / MCELSIUS);
>> -        }
>> -
>>           data->tmu_clear_irqs(data);
>>       }
>> +
>> +    mutex_unlock(&data->lock);
>> +    clk_disable(data->clk);
>> +    if (!IS_ERR(data->clk_sec))
>> +        clk_disable(data->clk_sec);
>
> In all other places the clock is strictly protected inside the critical
> section, but not here. In this code in theory on SMP (especially with
> big.LITTLE system with different speeds of CPUs) this could lead to
> disabling the clocks just after other CPU acquired the mutex and enabled
> them (in order to use the HW regs).


Clocks have internal atomic counters, so it is safe to disable them 
after leaving critical section. The clock would still be enabled in the 
mentioned case.


> Please put those two clocks before the mutex_unlock() and in the
> reverse order.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

