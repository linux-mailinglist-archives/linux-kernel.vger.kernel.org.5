Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD707F2DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKUNGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjKUNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:06:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A246D52;
        Tue, 21 Nov 2023 05:06:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA9EFEC;
        Tue, 21 Nov 2023 05:06:57 -0800 (PST)
Received: from [10.57.2.14] (unknown [10.57.2.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC39C3F7A6;
        Tue, 21 Nov 2023 05:06:08 -0800 (PST)
Message-ID: <64d598b7-cff3-4036-8b6b-dea3083dd716@arm.com>
Date:   Tue, 21 Nov 2023 13:07:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] thermal: exynos: use BIT wherever possible
Content-Language: en-US
To:     m.majewski2@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <96565d08-8d6b-4a37-8a83-90bdd53ba89a@arm.com>
 <20231120145049.310509-1-m.majewski2@samsung.com>
 <20231120145049.310509-9-m.majewski2@samsung.com>
 <CGME20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a@eucms1p4>
 <20231121125400eucms1p40c19eedff56881e1a1a9f1560ac9a2d9@eucms1p4>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231121125400eucms1p40c19eedff56881e1a1a9f1560ac9a2d9@eucms1p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 12:54, Mateusz Majewski wrote:
> Hi,
> 
>>> @@ -590,15 +590,15 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
>>>                                     continue;
>>>     
>>>                             interrupt_en |=
>>> -                                (1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
>>> +                                BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
>>>                     }
>>>     
>>>                     interrupt_en |=
>>>                             interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>>>     
>>> -                con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
>>> +                con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
>>>             } else
>>
>> Minor issue: the if-else segment here. When the 'if' has the
>> brackets, then the 'else' should have them as well,
>> even if there is only a single line under 'else'.
>> It's not strictly to this patch, but you can address that
>> later somewhere (just saw it here).
> 
> For what it's worth, this issue disappears after the final patch of this series,
> because the other branch reduces to a single line too (all the interrupt_en
> operations are done in the tmu_set_*_temp functions).

That sounds perfect.

I'm planning to build&run the patch set today evening, so I will finish
the review of the patch 9/9.
