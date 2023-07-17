Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC013756195
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGQL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGQL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:29:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB455E52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:29:28 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230717112924epoutp020640177628aea1e3362de00de10bcec2~ypDaOTy4S0662206622epoutp02P
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:29:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230717112924epoutp020640177628aea1e3362de00de10bcec2~ypDaOTy4S0662206622epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689593364;
        bh=H2KX3xxqbjqVVqfxb+F/mTUgcUDaR1aEJF+PWgOAHCs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=VxOX6K0il6r+bFHxEey+vDmIvpa+23qRqbi34jQwIgS0NHPcLRqoYtUwxWoI6Cl5n
         z2ckqXMbYt7W0HkEWlwyMgZw7tZlVxmjpMYiWC0zo4XPONKd6oZwJgKoFg+Dkkcj32
         KFmryEhcsv1dhaMNx8sSfIQQccyCr26hlHr2Vn28=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230717112923epcas2p3a41493ec521d76b7fecbeab6e36eb6b8~ypDY6Pabi1217512175epcas2p3T;
        Mon, 17 Jul 2023 11:29:23 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4Kc2536Kz4x9Pw; Mon, 17 Jul
        2023 11:29:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.65.32393.21625B46; Mon, 17 Jul 2023 20:29:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230717112922epcas2p3dab51c237946b72f45579b982607a624~ypDYKtt4Q0748707487epcas2p3A;
        Mon, 17 Jul 2023 11:29:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717112922epsmtrp1b2b77a121268c9f0ec4e7294705673af~ypDYJ9Oo32008320083epsmtrp1n;
        Mon, 17 Jul 2023 11:29:22 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-12-64b526120d67
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.27.64355.21625B46; Mon, 17 Jul 2023 20:29:22 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230717112921epsmtip11f71a721ab1f8ba35168e37640dc1bf4~ypDX56Dz_0385703857epsmtip1d;
        Mon, 17 Jul 2023 11:29:21 +0000 (GMT)
Message-ID: <68aacadd-f27d-76d3-36a1-78f5662ecb97@samsung.com>
Date:   Mon, 17 Jul 2023 20:26:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
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
        linux-samsung-soc@vger.kernel.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <9b09afec-4e0e-a600-92e1-2104a1b2e36e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmma6Q2tYUg8031SwezNvGZrFm7zkm
        i/lHzrFa9L14yGyx9/VWdotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2Tm
        pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3amkUJaYUwoUCkgsLlbSt7Mpyi8t
        SVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Y/3k5W8F7vooTHYsYGxi7
        uLsYOTkkBEwkbsycwNrFyMUhJLCDUeLkjs2sIAkhgU+MEr/uykAkQOzpPYwwHS/WTGaESOxk
        lPgwbzVU+2tGiZ1HXjGDVPEK2EncPzWdDcRmEVCVaJwynwkiLihxcuYTFhBbVCBaonXZfbAa
        YYEQiXPd28F6mQXEJW49Aann4hARuMokcXjzJmYQh1lgCaPEg8XP2EGq2AS0Jb6vXwy0moOD
        E2jb+RYviGZ5ie1v54DVSwjs4ZCY9/AFO8TdLhJXr31nhbCFJV4d3wIVl5J42d8GZWdLtE//
        A1VTIXFxw2w2CNtYYtazdkaQXcwCmhLrd+mDmBICyhJHbrFArOWT6Dj8lx0izCvR0SYE0agm
        cX/qOaghMhKTjqxkgrA9JA6t7WWZwKg4CylUZiH5fhaSZ2Yh7F3AyLKKUSy1oDg3PbXYqMAE
        HtnJ+bmbGMFJWMtjB+Pstx/0DjEycTAeYpTgYFYS4f2+alOKEG9KYmVValF+fFFpTmrxIUZT
        YNxMZJYSTc4H5oG8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY
        ds16VOAf/H5Hv5bmDZENkkvFr7k/Lbw69WPunwPunlOTfA7JT5sXlBY5bdGsM8dLlq/xtfpY
        cHfGo/Upj85tXPzb+0GqB7eI827ftf/EqlwWuD/OnBjPW+c2MXQll9GCjC0e/wL15L8821E0
        9+yNd/wMHIKZTTzlbh6uiWWGu5gju2cwH5rrYLrqU/7t51mv7zp/3FMRdo2R7/9FM/lFJcmL
        DwSYLDJzf6wmK/qxhnNzxW6vI6xJUv9tLuxxeXtN/ttJCy+fR0Gc+0Wbq475Vr284LhmXniN
        Qar6hOn/K1XZwu/qzPz/+cmGk1d9luiw7u6Rb/u+pDlj19m7eXkpZUF+fO+3s3mn+Vx5cc3C
        R4mlOCPRUIu5qDgRAHNHUnJLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnK6Q2tYUgxezOSwezNvGZrFm7zkm
        i/lHzrFa9L14yGyx9/VWdotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZez/
        vJyt4D1fxYmORYwNjF3cXYycHBICJhIv1kxmBLGFBLYzSnw7EAgRl5FY/qyPDcIWlrjfcoS1
        i5ELqOYlo0Tvzx6wBl4BO4n7p6aDFbEIqEo0TpnPBBEXlDg58wkLiC0qEC2x+vMFVhBbWCBE
        4lz3dmYQm1lAXOLWE5B6Lg4RgetMEufO3GYEcZgFljBKXH4N0g2y7iejRPvtk+wgLWwC2hLf
        1y8GGsXBwQm0+nyLF8QkM4murV2MELa8xPa3c5gnMArNQnLILCQLZyFpmYWkZQEjyypG0dSC
        4tz03OQCQ73ixNzi0rx0veT83E2M4JjTCtrBuGz9X71DjEwcjIcYJTiYlUR4v6/alCLEm5JY
        WZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAxNofK+9cxGDa29C2
        r+/Fcy2rC6EPevWKOM+emPrF3mrTw2sPGXNYjN/1fak1iRBpWJF9/SOXWr3ZXw292aLGj7vr
        LNMfJ5r+WrPp+GcODR1BUX7+3DMzYs5t9j899QT7utb06acy2j2PBNxd7jRjf6DimT+CUyzm
        x6RGX3Z9mPX426X1r/g1Yudv2dj8e2N7dWjPNi6z/64vGaZmH691Zvj16r/9jsoDCtMYEqw7
        278UfH+4p8eMWY1xv7d8Ec9JnuIsLknpzTs+lNhvYlFd8Yv3n/b/Dade8y/jNJrPqL/IWONh
        ppn4nhqnjcveSkor2exi++H7Kbz7YHCMufH8ntzzZ8Sv9C2TzI8Sc0hQYinOSDTUYi4qTgQA
        ayMlCCgDAAA=
X-CMS-MailID: 20230717112922epcas2p3dab51c237946b72f45579b982607a624
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536
References: <20230717094202.18296-1-jaewon02.kim@samsung.com>
        <CGME20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536@epcas2p1.samsung.com>
        <20230717094202.18296-2-jaewon02.kim@samsung.com>
        <9b09afec-4e0e-a600-92e1-2104a1b2e36e@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 7. 17. 19:59, Krzysztof Kozlowski wrote:
> On 17/07/2023 11:42, Jaewon Kim wrote:
>> Add samsung,exynosautov9-pwm compatible string to binding document.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-samsung.yaml     | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>> index fe603fb1b2cc..6f65e2b52f52 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>> @@ -20,12 +20,16 @@ description: |+
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
>> -      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
>> -      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
>> -      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
>> -      - samsung,exynos4210-pwm          # 32-bit, Exynos
>> +    oneOf:
>> +      - const: samsung,s3c2410-pwm        # 16-bit
>> +      - const: samsung,s3c6400-pwm        # 32-bit, S3C64xx
>> +      - const: samsung,s5p6440-pwm        # 32-bit, S5P64x0
>> +      - const: samsung,s5pc100-pwm        # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
>> +      - const: samsung,exynos4210-pwm     # 32-bit, Exynos
> These are still an enum.
Okay I will change const to enum.
>
>> +      - items:
>> +          - enum:
>> +              - samsung,exynosautov9-pwm  # 32-bit, ExynosAutov9
> Let's drop the comment?

Should I just delete this comment or delete all comments in the 
enum(16-bit,S3C24xx, .....).

>
>> +          - const: samsung,exynos4210-pwm
>>   
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

