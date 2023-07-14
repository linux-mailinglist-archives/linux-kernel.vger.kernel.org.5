Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C575314E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjGNFcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjGNFbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:31:41 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667923A8E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:31:18 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230714053115epoutp03f911e8ab575adb053b38f57388badb5a~xpO2WpucW0270602706epoutp03s
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:31:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230714053115epoutp03f911e8ab575adb053b38f57388badb5a~xpO2WpucW0270602706epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689312675;
        bh=FH9ncGZNeuvXThGojUuRBNFIVkXtbRJVe1BwpUu+UwE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=bqM9DdJjGi3oZwRqTqqPGyIVusfLot9dqS6t9EyP/DNAUbnht6B9pG0LfZtsQUR6+
         5c6KUHlPcrqmDiLQyTJWnjJ7PiQDsIJw5AbL5M0QfvXtZm26Hkf65QcGKjJ4Ij9MtF
         YnpQmtc9Z7oGp7V2MYRxcOj9pVynugAy+oJPiVXw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230714053115epcas2p2df39db9341dc7fb4d19e2cacf18fa7de~xpO18GDGp1685916859epcas2p2l;
        Fri, 14 Jul 2023 05:31:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R2KpB633fz4x9Py; Fri, 14 Jul
        2023 05:31:14 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.E4.32393.2ADD0B46; Fri, 14 Jul 2023 14:31:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230714053114epcas2p1ebc203b5522cc05c984a55b30bdbcd1b~xpO1Q82Ar3185131851epcas2p1E;
        Fri, 14 Jul 2023 05:31:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714053114epsmtrp2f7630b7f688b759da530ab3deca8f76e~xpO1P3dSl0594005940epsmtrp27;
        Fri, 14 Jul 2023 05:31:14 +0000 (GMT)
X-AuditID: b6c32a48-0fa7ca8000007e89-b8-64b0dda2df51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.08.64355.2ADD0B46; Fri, 14 Jul 2023 14:31:14 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230714053114epsmtip29085bfc1299f6034c1ceadf41cdf3ec9~xpO09a-5i2248122481epsmtip25;
        Fri, 14 Jul 2023 05:31:14 +0000 (GMT)
Message-ID: <d5148039-e3f4-b9ca-d7e9-19d64ecc1445@samsung.com>
Date:   Fri, 14 Jul 2023 14:28:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: exynos: add pwm node for exynosautov9-sadk
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <3bc9c34a-ba55-61c5-87ea-80b369841873@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmme6iuxtSDJ73GVo8mLeNzeLyfm2L
        NXvPMVnMP3KO1aLvxUNmi72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgctj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjPufL3BVHBJsOLVzessDYyr+boYOTkkBEwkphx+zNbFyMUhJLCD
        UeLw7C5GCOcTo8S/h18QnEfnnjPCtMw88I0dIrGTUWJm9xuo/teMEl3brrGAVPEK2Emcu7gc
        zGYRUJX4tXU6M0RcUOLkzCdgcVGBaInWZffZQGxhAW+JBasaWUAGiQg8YZRYtK4BbDezwCZG
        iV9dd8G6mQXEJW49mc8EYrMJaEt8X7+YFcTmBNq2+SrEVGYBeYntb+cwgzRLCMzkkJg78TMz
        xOEuEg1tX5kgbGGJV8e3sEPYUhKf3+1lg7CzJdqn/2GFsCskLm6YDRU3lpj1rB3oIg6gBZoS
        63fpg5gSAsoSR25BreWT6Dj8lx0izCvR0SYE0agmcX/qOaghMhKTjqyEOsBD4nHfU8YJjIqz
        kIJlFpInZyF5ZhbC3gWMLKsYxVILinPTU4uNCkzg0Z2cn7uJEZxgtTx2MM5++0HvECMTB+Mh
        RgkOZiURXpVt61KEeFMSK6tSi/Lji0pzUosPMZoCI2cis5Rocj4wxeeVxBuaWBqYmJkZmhuZ
        GpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cDkUZ18WUCii11wWnjSRKnc/RzTJ/mxrDpb
        zWFo5JLvH5RbMN/xWP47sSwlXvnqiCc8PmttfYva479zhx9ccurkHJdz+2xKBed8FDF/ppWh
        mZ8lEuaanyqzwuuTz/2jLQcO9Xjap1y8eLAteNGCYPdlRpe28DGy7J2+cwfr9rkSK44/VZxb
        WZrnHiCXJh+75I7By8+dlTLWEwRKHjZ6aD3Y9/KGSckrlbq/dTY7zybqe3ievSC2Pzb/3Iqg
        q3sFzW4ffbaRQ/TFg8tn797mkdpyhvX5Yx2x8/dfrbx8OsMxzPpPRlyLryjLs/3SLq+fGm0S
        59g1U+KrwuP8gw9yNtgv/S7y/JwuA4upgU6+S4QSS3FGoqEWc1FxIgA89uLoOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXnfR3Q0pBh2dghYP5m1js7i8X9ti
        zd5zTBbzj5xjteh78ZDZYu/rrewWmx5fY7W4vGsOm8WM8/uYLFr3HmF34PLYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxp2vN5gKLglWvLp5naWBcTVfFyMnh4SA
        icTMA9/Yuxi5OIQEtjNKzLi5kBEiISOx/FkfG4QtLHG/5QgrRNFLRomXB04zgyR4Bewkzl1c
        zgJiswioSvzaOh0qLihxcuYTsLioQLTE6s8XWEFsYQFviQWrGllABokIPGGUmD1vBxOIwyyw
        iVHizOWnUHccZZS4vusDWAuzgLjErSfzmUBsNgFtie/rF4PFOYFWb74KsYJZwEyia2sXI4Qt
        L7H97RzmCYxCs5BcMgvJqFlIWmYhaVnAyLKKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzie
        tIJ2MC5b/1fvECMTB+MhRgkOZiURXpVt61KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYI
        CaQnlqRmp6YWpBbBZJk4OKUamFQvluUtv1/JrbnqouChl7OE3gbHrQo75ZqQOtmdO6zgsERj
        2dWFcw+/Zzt7XfTg868NL39xbXyX+81A2vPMqyiZWLkrvNM0nIN/nf3XMlU+1FH5jjGjS6vg
        lqI2q8qF61QDbNS1vvBcPhFg62v5SrrdleVycsC/q3G9n++5Rq7zkZ96VfvGoRgP9o74QGub
        5gPu1lfn/SyQsklIj9ke1ZgsdG2n+a3T7cbnOR1Y33EL+9ouPC/Ofuj5l6Qr1bm7Px6fOzdj
        +ktJ9QOCsYsmBfTL/Ly2t0uHYeWfx5pBt97O/L3cKO1ZOe/TBaG7jyQUsr1X9rj+odTiut2s
        x5JiahoWr7ZtjbvEyrXlyEMDUSWW4oxEQy3mouJEAOTok90WAwAA
X-CMS-MailID: 20230714053114epcas2p1ebc203b5522cc05c984a55b30bdbcd1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8
References: <CGME20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8@epcas2p4.samsung.com>
        <20230714051521.22720-1-jaewon02.kim@samsung.com>
        <3bc9c34a-ba55-61c5-87ea-80b369841873@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof


On 23. 7. 14. 14:26, Krzysztof Kozlowski wrote:
> On 14/07/2023 07:15, Jaewon Kim wrote:
>> Add pwm node to support fan on exynosautov9-sadk board.
>> PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
>> in SADK board.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts | 6 ++++++
>>   arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 9 +++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> index 898c2fc345ed..e717bb1cad81 100644
>> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> @@ -50,6 +50,12 @@
>>   	};
>>   };
>>   
>> +&pwm {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pwm_tout3>;
>> +	status = "okay";
>> +};
>> +
>>   &serial_0 {
>>   	pinctrl-0 = <&uart0_bus_dual>;
>>   	status = "okay";
>> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>> index d3c5cdeff47f..e8860b03fe89 100644
>> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>> @@ -1560,6 +1560,15 @@
>>   			samsung,syscon-phandle = <&pmu_system_controller>;
>>   			samsung,cluster-index = <1>;
>>   		};
>> +
>> +		pwm: pwm@103f0000 {
>> +			compatible = "samsung,exynos4210-pwm";
> Thanks for the patch. I think we should change existing practice for
> Samsung SoC and start adding dedicated specific compatible for such
> blocks. It's the same practice we follow in other SoCs. It's also
> recommendation I give to other platforms.
>
> Therefore this should be "samsung,exynosautov9-pwm",
> "samsung,exynos4210-pwm". Feel free to update other DTS as well.

Okay, I will update "samsung,exynosautov9-pwm" compatible in next version.


>
>> +			reg = <0x103f0000 0x100>;
>> +			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>> +			#pwm-cells = <3>;
>> +			clocks = <&xtcxo>;
> This does not look like correct clock. Are you sure XTCXO goes to PWM?
>
>
>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

