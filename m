Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620CB755B97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGQG0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGQGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:25:52 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F2170C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:25:30 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230717062439epoutp01e14578fe33e7d7b348d32d649954d9e4~yk5VFziEp2401024010epoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:24:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230717062439epoutp01e14578fe33e7d7b348d32d649954d9e4~yk5VFziEp2401024010epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689575079;
        bh=EVI2S727mJ4PMA5lU03bgnJnLMSMGGnnOXiGWXlih98=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=XHJTZZHUEIQsv4LRbioTKathlmoxAm08fXqTpSgT8Bne03cP2w/sxfBWsNpN0frIf
         414FdMJkmFt3ay7kPCTzL8MDrl+zJ8uFtpaTafNjt9+DenOfIi8Bu3gWQjCAasyS/S
         84MfvIoqWWPqJ87QW+pIOztoV9AaAVPevcW34ZXQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230717062438epcas2p156365b4166d8172d70ed84a913c3abef~yk5UjQHuv2022020220epcas2p1c;
        Mon, 17 Jul 2023 06:24:38 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4BrQ4TTjz4x9QH; Mon, 17 Jul
        2023 06:24:38 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.DE.32393.6AED4B46; Mon, 17 Jul 2023 15:24:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230717062438epcas2p1846e5f0b23af60d2cd2cea9dd349f056~yk5TzYX8U0894908949epcas2p1u;
        Mon, 17 Jul 2023 06:24:38 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717062438epsmtrp1e44239a2e2aaaff00037086ad20b27e2~yk5TynO_S0786807868epsmtrp1k;
        Mon, 17 Jul 2023 06:24:38 +0000 (GMT)
X-AuditID: b6c32a48-adffa70000007e89-10-64b4dea6dfc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.75.64355.6AED4B46; Mon, 17 Jul 2023 15:24:38 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717062437epsmtip28e6e659cc949c8d2b82b7abd7893f8b0~yk5ThGKPO1750017500epsmtip2O;
        Mon, 17 Jul 2023 06:24:37 +0000 (GMT)
Message-ID: <2615b892-bbe1-240e-6717-0bde8f3dd4c8@samsung.com>
Date:   Mon, 17 Jul 2023 15:22:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9
 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <31af3a96-7e98-8bb1-f9e9-53ccb0441310@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmhe6ye1tSDF5PUbZ4MG8bm8Xl/doW
        a/aeY7KYf+Qcq0Xfi4fMFntfb2W32PT4GqvF5V1z2Czu3l3FaDHj/D4mi9a9R9gtfu6ax2Jx
        e+JkRgdej52z7rJ7bFrVyeZx59oeNo/NS+o9+v8aePRtWcXo8XmTXAB7VLZNRmpiSmqRQmpe
        cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCtSgpliTmlQKGAxOJiJX07
        m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjKV9z1kLXnBUvH/0
        mrWBcSZ7FyMnh4SAicSFvp/MXYxcHEICOxglTv3ezQLhfGKUOHTpLRucc/X4U7iW/febmCAS
        OxklWk++gep/zSgx9ewvNpAqXgE7iaMT/zCD2CwCqhI/1m5ngYgLSpyc+QTMFhWIlmhddh+s
        XljAX2LirVVMIDazgLjErSfzwTaICFxlkji8eRPYBmaBs4wSDyfcZQWpYhPQlvi+fjGYzQm0
        beK5e1Dd8hLb384Ba5AQOMIhcWLHDGaIw10k+vveskHYwhKvjm+BekhK4mV/G5SdLdE+/Q8r
        hF0hcXHDbKh6Y4lZz9oZuxg5gBZoSqzfpQ9iSggoSxy5xQKxlk+i4/Bfdogwr0RHmxBEo5rE
        /annoIbISEw6spIJwvaQOHHgDusERsVZSMEyC8n7s5A8Mwth7wJGllWMYqkFxbnpqcVGBSbw
        6E7Oz93ECE7IWh47GGe//aB3iJGJg/EQowQHs5II7/dVm1KEeFMSK6tSi/Lji0pzUosPMZoC
        I2cis5Rocj4wJ+SVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cBU
        /pPlyf7lu1dzb+TLFfftXPhSfOZ8ndL43IiVOzwFbsf+C3zrmcK1Vc7YM6Dy735PWYOMsIOr
        spQPuO15l6M6e2PG1msPfsqzOYfNnuF0y6Z10q6b06sE1EyOq17I/Lzw7lPna7oFb3IEt6y4
        7/xge++JuHn5P3eGLpGY9PMcD8uCrafV1UtWbuMQ3bujp6B41vJv0w1DWpjPNdjK1fQvvvRx
        9a6TKn7T5V1npMYeynioeqbj3gu2mwFHfKTunbb8nKphsPNE2te88JBShllrq76qmKxVWZZe
        nvRlu/uSL6/3r992fMev2RpXZoRclDrVfLyQR33hkhshcrPKm5o1Zimsl+ALrUs8YDAhLSPn
        phJLcUaioRZzUXEiAD0tvuZRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO6ye1tSDL6/ZbZ4MG8bm8Xl/doW
        a/aeY7KYf+Qcq0Xfi4fMFntfb2W32PT4GqvF5V1z2Czu3l3FaDHj/D4mi9a9R9gtfu6ax2Jx
        e+JkRgdej52z7rJ7bFrVyeZx59oeNo/NS+o9+v8aePRtWcXo8XmTXAB7FJdNSmpOZllqkb5d
        AlfG0r7nrAUvOCreP3rN2sA4k72LkZNDQsBEYv/9JqYuRi4OIYHtjBI7Lh5lhUjISCx/1scG
        YQtL3G85AhYXEnjJKDFpciyIzStgJ3F04h9mEJtFQFXix9rtLBBxQYmTM5+A2aIC0RKrP18A
        6uXgEBbwlZixjxskzCwgLnHryXywvSIC15kkzp25zQjiMAucZZR42PMd6qKfjBLrLu5kBGlh
        E9CW+L5+MdgVnECbJ567xwQxykyia2sXI4QtL7H97RzmCYxCs5AcMgvJxllIWmYhaVnAyLKK
        UTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzj2tIJ2MC5b/1fvECMTB+MhRgkOZiUR3u+rNqUI
        8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1ME39KsS+asu2
        KU+atCYpMtY8NBWc98B8m/XFqbvCff3endVPEKqxX+Vq1sDm4DyL+VNdRPbGMwvtembvuXs+
        xOJmqIhf1aRtOXWvDU4v91obkSjgrDWnabag/sQg6RsPTkrtX8PxZYnTYtabHRZNDhzmC7c+
        4J/zZkkSt7fO3a8HS9JOnH7BcnKrirLT09ZUFec707eaNHzvfhz4//U547hMo5bVcbe3JXBd
        7bZUmJi1h+vs5UNMBy7cmeGftJezNLq4asfyhNqL8ttWP7+yutCRYfttI6cHX37KF/Xm1BwL
        f6pkFXS7mfngbw67tK9OXNr35+0J3XtqRvLeipUuRqvOKGi2fmlep/JDvN7p430lluKMREMt
        5qLiRACYGzbuLAMAAA==
X-CMS-MailID: 20230717062438epcas2p1846e5f0b23af60d2cd2cea9dd349f056
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
        <31af3a96-7e98-8bb1-f9e9-53ccb0441310@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 7. 17. 14:58, Krzysztof Kozlowski wrote:
> On 14/07/2023 12:09, Jaewon Kim wrote:
>> Add new compatible string to support ExynosAutov9 SoC.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/pwm/pwm-samsung.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
>> index e8828f57ab15..50a88565c440 100644
>> --- a/drivers/pwm/pwm-samsung.c
>> +++ b/drivers/pwm/pwm-samsung.c
>> @@ -513,6 +513,7 @@ static const struct of_device_id samsung_pwm_matches[] = {
>>   	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
>>   	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
>>   	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant },
>> +	{ .compatible = "samsung,exynosautov9-pwm", .data = &s5p64x0_variant },
> That's not what I asked for. You do not need entry here. Devices are
> compatible.

I misunderstood your intent.

I will add only this compatible to DT and send it again with v3 patch.

> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

