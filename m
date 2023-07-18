Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7047573DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGRGOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjGRGNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:13:49 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135421987
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:12:54 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230718061220epoutp03a3f0a2be630a49354bb4bc865f8d3c22~y4X3LsH140996309963epoutp035
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230718061220epoutp03a3f0a2be630a49354bb4bc865f8d3c22~y4X3LsH140996309963epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689660740;
        bh=Y/wzcR7s5qCopfeO/Ag6FN6ivBN2LtWwQIy9dVWDhhk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Ghja705irJkG0QlNxN16PDyAE6/IWOcsaabQFr32w9wu2HjGwNBOWhUIIlt73CPXw
         uq3ow+K+wJM492E7G5O5gChKRgy0GNhYUEKZw4OpZGttMWgWnJEhxVqLC9mKEJlqK1
         X26NOqoospBBQoEudSlyu2IJbVctIhB0tHumF+zo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230718061220epcas2p3c4a85610e552f307b13b451805090624~y4X273NPJ2078620786epcas2p3t;
        Tue, 18 Jul 2023 06:12:20 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4pWl5MHTz4x9Q3; Tue, 18 Jul
        2023 06:12:19 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.DF.40133.34D26B46; Tue, 18 Jul 2023 15:12:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230718061219epcas2p3aafee94f0fe9814e86df51b376d344ab~y4X1_rU4m2078620786epcas2p3l;
        Tue, 18 Jul 2023 06:12:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718061219epsmtrp18ab4f4087fc6b7ee5b037cd459996fc4~y4X19jHqF1534515345epsmtrp1e;
        Tue, 18 Jul 2023 06:12:19 +0000 (GMT)
X-AuditID: b6c32a46-4edb870000009cc5-27-64b62d43c4db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.D4.34491.34D26B46; Tue, 18 Jul 2023 15:12:19 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230718061219epsmtip163613637a041e812304a261368d1af5b~y4X1tGY080862508625epsmtip1U;
        Tue, 18 Jul 2023 06:12:19 +0000 (GMT)
Message-ID: <1ea9eb53-8c7d-dd64-a93f-8bcfae51b65f@samsung.com>
Date:   Tue, 18 Jul 2023 15:09:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/2] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <a62141a9-a2c0-6568-cb05-5ef59250e10f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmma6z7rYUgzMd2hYP5m1js1iz9xyT
        xfwj51gt+l48ZLbY+3oru8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGecu21RsI2j4vqVxywNjK/Y
        uhg5OCQETCSmnLLpYuTiEBLYwSixetVCFgjnE6PE7d8PWbsYOYGcb4wS9x/Wg9ggDc97ZjND
        FO1llNh3YyoThPOaUeL6zCZWkLG8AnYST68VgjSwCKhKtC5+yAxi8woISpyc+YQFxBYViJZo
        XXafDcQWFgiRmHTtHCPIHBGBq0wShzdvAtvALLCEUeLB4mfsIFXMAuISt57MZwKx2QS0Jb6v
        Xwx2HifQsk1fbrFB1MhLbH87B6xZQuAIh0TH5KfMEHe7SFz7tQ7KFpZ4dXwLO4QtJfGyvw3K
        zpZon/6HFcKukLi4YTYbhG0sMetZOyPIZ8wCmhLrd+lDwk5Z4sgtFoi1fBIdh/+yQ4R5JTra
        hCAa1STuTz0HNURGYtKRlUwQtofEyavdrBMYFWchBcssJE/OQvLMLIS9CxhZVjGKpRYU56an
        FhsVGMGjOjk/dxMjOAFrue1gnPL2g94hRiYOxkOMEhzMSiK831dtShHiTUmsrEotyo8vKs1J
        LT7EaAqMnInMUqLJ+cAckFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8T
        B6dUA9O0vWvvJDoKbTUpiUmzvn11KdOOcwfXakbyrT77aaeuokdJvuOTNVvO5T1mLt7kWqjk
        tmOSTmZAdIlwjmjTqUd3d6tWtBr1nty12IqlIPXAvO3Pr2qmN8wsmPxL5/DWCpYn8/Vmz2Xc
        uGa9UVm0wwnez2+mM/uIvm8qv2YZZ7Gs033N4ukTo2/pT7ec4VS3apGBwfYFjmaJwi2nare7
        AiMpNn1ejEzPLDejNd3XJNtF+M9ndyz4faT8iFutI7/Jx62mCRXzHrd/D0yyE3nU9ZP16bp9
        ZZMLJkacuGGcUTO/Unva5yvJ7ArfDzRlf57kO8Mm25qtyHPKLZ1z6TsjmJfZLs0q5LfWcOSI
        WGL4SomlOCPRUIu5qDgRAM9NroVJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK6z7rYUg8MbuC0ezNvGZrFm7zkm
        i/lHzrFa9L14yGyx9/VWdotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZZy7
        bVGwjaPi+pXHLA2Mr9i6GDk5JARMJJ73zGYGsYUEdjNKTOoqg4jLSCx/1gdVIyxxv+UIaxcj
        F1DNS0aJhjsXmLoYOTh4Bewknl4rBKlhEVCVaF38EGwOr4CgxMmZT1hAbFGBaInVny+wgtjC
        AiESk66dYwSZIyJwnUni3JnbYA6zwBJGicuvQTpANvxmlPh/4TXYamYBcYlbT+YzgdhsAtoS
        39cvBhvFCbR505dbUDVmEl1buxghbHmJ7W/nME9gFJqF5JJZSEbNQtIyC0nLAkaWVYySqQXF
        uem5xYYFhnmp5XrFibnFpXnpesn5uZsYwZGnpbmDcfuqD3qHGJk4GA8xSnAwK4nwfl+1KUWI
        NyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDk3jVmeb5vPt2
        1E5Wymie+sku/vj2DzsW7PjXsTqN59snnSNnrYqcqzUZav5O5P/ssFXbMCfxlKyLQqD8RU2b
        JwXuN/I/OW9mvLcyKjPCjOng1MvT6gQ/yrSkcRWLv9w4kSlsUoHejsKl8zvauZbZ7dmx6WCR
        tOf3Fx8nBuqU7JXZ+/pisPh8bbsHAo+nqnyuW3Xz24LlM0qabu57sDTL7vivW4sm9lwpqSuf
        82j9tctd3++/C4rV01l9UtjztXa5uujd3E6HRxvyG7u/lrrKxM+JOHk29sfDHS9W6+R6XQnJ
        lO7YH/VR1iH/wovSVXMu/rPXayyYpb7zoqTHZNUj4gv+capsE+IUffr4ZPztWSlKLMUZiYZa
        zEXFiQDcSctuKwMAAA==
X-CMS-MailID: 20230718061219epcas2p3aafee94f0fe9814e86df51b376d344ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
        <CGME20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a@epcas2p3.samsung.com>
        <20230718034201.136800-3-jaewon02.kim@samsung.com>
        <a62141a9-a2c0-6568-cb05-5ef59250e10f@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 7. 18. 15:06, Krzysztof Kozlowski wrote:
> On 18/07/2023 05:42, Jaewon Kim wrote:
>> Add pwm node to support fan on exynosautov9-sadk board.
>> PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
>> in SADK board.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
>>   arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> index 101f51bf565a..bc1815f6ada2 100644
>> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
>> @@ -49,6 +49,12 @@
>>   	};
>>   };
>>   
>> +&pwm {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pwm_tout3>;
>> +	status = "okay";
> I think you miss disabling it.

Okay, I will add disable status to soc dtsi.


>
>> +};
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

