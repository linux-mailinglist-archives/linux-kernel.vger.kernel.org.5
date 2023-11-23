Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34857F58DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbjKWHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:08:48 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECCCB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:08:54 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231123070850epoutp0391550e27ebd7ff6bae03229331a7275b~aLtu2DsY-0427704277epoutp03C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:08:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231123070850epoutp0391550e27ebd7ff6bae03229331a7275b~aLtu2DsY-0427704277epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700723330;
        bh=UlOYtqsg8VMxZjHuFShtASMAUieEGsDmiXuu5nvaCBE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=DbrZOEfwVXiW3t8kiHJ0Ir3nOvhOgGfsOrPRAk3MGgchpoEuXwrSwUstvflCFNzDH
         eCn/tT4vNC5XpdqWPXdyivQ3zYDIRpS30dNB/DhFvM0rgh8tW3bryCPo+iN4gk1B6T
         DMDrXEwImF4jsXJqbiEQJpJ+e9MERIe6bjCG0Hos=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231123070849epcas2p4e8ae1cbfb86050455bc92f169aa21d64~aLtuOFxJw2905729057epcas2p4G;
        Thu, 23 Nov 2023 07:08:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SbTjs2Kyzz4x9Pw; Thu, 23 Nov
        2023 07:08:49 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.F2.10006.18AFE556; Thu, 23 Nov 2023 16:08:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231123070848epcas2p13b713349f30d3cfe72b3e343ab8cc90b~aLttLcVqm0047900479epcas2p1O;
        Thu, 23 Nov 2023 07:08:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231123070848epsmtrp1a819f9d784eb01230de11b0b817e7cab~aLttKZ7vZ2630226302epsmtrp1S;
        Thu, 23 Nov 2023 07:08:48 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-05-655efa81e90a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.8C.08755.08AFE556; Thu, 23 Nov 2023 16:08:48 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231123070848epsmtip22a7d454dc0fdf545d76c49c97aca6629~aLts8Nhwj1175411754epsmtip2S;
        Thu, 23 Nov 2023 07:08:48 +0000 (GMT)
Message-ID: <45b0f9e2-f97a-1b60-b40f-d84831027d00@samsung.com>
Date:   Thu, 23 Nov 2023 16:06:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: samsung: use Exynos7
 fallbacks for newer wake-up controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        semen.protsenko@linaro.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmqW7jr7hUg0s3OS0ezNvGZrFm7zkm
        i/lHzrFa7H29ld1iyp/lTBabHl9jtdg8/w+jxeVdc9gsZpzfx2SxYcY/FovWvUfYLQ6/aWe1
        eN4HFFu16w+jA5/Hzll32T02repk87hzbQ+bx+Yl9R59W1YxenzeJBfAFpVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rZJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Psun62gmMyFXMb
        ljM2ML4Q6WLk5JAQMJHo/dTF3MXIxSEksINRYtf9VUwQzidGiUkbnkBlvjFKTJx/jLGLkQOs
        5c4cqPheRolLCx+zQDivGSVWPH/BBDKXV8BO4tPKecwgNouAqsTurU8ZIeKCEidnPmEBsUUF
        oiVal91nA7GFBXIlls1rB6thFhCXuPVkPtgZIgJnmCVmrbsNlfCQWPWmF8xmE9CW+L5+MSuI
        zSngKrGl/ywTRI28xPa3EOdJCJzgkHi65QUjxKcuEhd/zYeyhSVeHd/CDmFLSbzsb4OysyXa
        p/9hhbArJC5umM0GYRtLzHrWDvY+s4CmxPpd+pCQUJY4cosFYi2fRMfhv+wQYV6JjjYhiEY1
        iftTz0ENkZGYdGQlE4TtITHv4GK2CYyKs5BCZRaS72cheWYWwt4FjCyrGMVSC4pz01OLjQoM
        4ZGdnJ+7iRGckLVcdzBOfvtB7xAjEwfjIUYJDmYlEd4t7DGpQrwpiZVVqUX58UWlOanFhxhN
        gXEzkVlKNDkfmBPySuINTSwNTMzMDM2NTA3MlcR577XOTRESSE8sSc1OTS1ILYLpY+LglGpg
        YtgzY9dFp75IqRpWxjyThs1HPxbU/PIPWaWl4TqhxZ1ZefkWUxkfL5mWecfV5xedmfor1SD7
        vULIxf5WLqk3JyWf36qfVCJSsnzHsrlW05n0tH4X2hkuqk/8dej1jzl2x63ut1pcMLnwd/ZU
        yTqZI5JWAidFqk5Nev+dJelfTlC1bFuWp33qI96NBQ59aSe79CJuM80UalD2vFB0XXOOr8yL
        yNL9nDf7pR8d2vYmyTRX/xBzdpWPJ6O1Cqtk5SqWLNXABT6qnIxis6s2vTgV8Wf21pf68zYf
        NX+oLL9V8dD+m23iOdsPbOPf+KLt2qoJTSHPFjV5H7N6vLJ1+qq+wt3z+lZzHtnusSw2Kfus
        EktxRqKhFnNRcSIAKo57nlEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvG7Dr7hUg0VNqhYP5m1js1iz9xyT
        xfwj51gt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7LYMOMfi0Xr3iPsFofftLNa
        PO8Diq3a9YfRgc9j56y77B6bVnWyedy5tofNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3
        S+DKOLuun63gmEzF3IbljA2ML0S6GDk4JARMJO7MYe5i5OIQEtjNKLHkQiNbFyMnUFxGYvmz
        PihbWOJ+yxFWiKKXjBJXtj5nAknwCthJfFo5jxnEZhFQldi99SkjRFxQ4uTMJywgtqhAtMTq
        zxdYQWxhgVyJp+3dYPXMAuISt57MZwIZKiJwjlli+4Qv7BAJD4lVb3oZIbbNYJRYMeUcWAeb
        gLbE9/WLwSZxCrhKbOk/ywTRYCbRtbWLEcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxgZFnF
        KJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREch1qaOxi3r/qgd4iRiYPxEKMEB7OSCO8W
        9phUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUzzTQzf
        /5MT9zgduOCdSiT7uRVHzQOtDm5dcaBqlvH79EMqDfNeLjpTwWc3vfbL20Os2RZrane82rgk
        vf+l14KyyacaZm3U2vbS/W6RgZh/25pew3ANGfaQHYe6nrddvrFQ5paFTFTdtY2bH/TPD1Rr
        7HFos3z/ccaKGUV7784+7OS6gKk+9tnMm6pPVi+Zpb3QUXrK/Pk73LndhU74fxV43XZht5yG
        d/XyHZ/Dwi9ttA30dI5+/C3UzutR/bKnh0oXGZ2YfrQrXUZH53LfKwnNdKbEA9ElEtcsqw5M
        MDF2eeT9Q0delvNe2ZSH10Ji/1esD+Jb6B1hZCn8MnN+8qx9Ypt3HLJUm1c153l9R4OJEktx
        RqKhFnNRcSIA16p7uTIDAAA=
X-CMS-MailID: 20231123070848epcas2p13b713349f30d3cfe72b3e343ab8cc90b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231122200609epcas2p1da5f138359da3a0be4af4fbc25f2a8f5
References: <CGME20231122200609epcas2p1da5f138359da3a0be4af4fbc25f2a8f5@epcas2p1.samsung.com>
        <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 23. 05:04, Krzysztof Kozlowski wrote:
> Older ARM8 SoCs like Exynos5433, Exynos7 and Exynos7885 have the pin
> controller with wake-up interrupts muxed, thus the wake-up interrupt
> controller device node has interrupts property, while its pin banks
> might not (because they are muxed by the wake-up controller).
>
> Newer SoCs like Exynos850 and ExynosAutov9 do not used muxed wake-up
> interrupts:
> 1. Wake-up interrupt controller device node has no interrupts,
> 2. Its pin banks have interrupts (since there is no muxing).
>
> Their programming interface is however still compatible with Exynos7,
> thus change the bindings to express this: retain compatibility with
> Exynos7 and add new compatibility fallback of Exynos850 in newer
> designs.
>
> No driver changes are needed.  This is necessary only to properly
> describe DTS.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jaewon Kim <jaewon02.kim@samsung.com>


I will also apply it to ExynosAutov920 DT patch.


Thanks

Jaewon Kim


>
> ---
>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: semen.protsenko@linaro.org
> Cc: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>   .../samsung,pinctrl-wakeup-interrupt.yaml     | 25 +++++++++++--------
>   1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> index 1b75abebb953..2bafa867aea2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> @@ -36,13 +36,17 @@ properties:
>             - samsung,s5pv210-wakeup-eint
>             - samsung,exynos4210-wakeup-eint
>             - samsung,exynos7-wakeup-eint
> -          - samsung,exynos850-wakeup-eint
> -          - samsung,exynosautov9-wakeup-eint
> -          - samsung,exynosautov920-wakeup-eint
>         - items:
>             - enum:
>                 - samsung,exynos5433-wakeup-eint
>                 - samsung,exynos7885-wakeup-eint
> +              - samsung,exynos850-wakeup-eint
> +          - const: samsung,exynos7-wakeup-eint
> +      - items:
> +          - enum:
> +              - samsung,exynosautov9-wakeup-eint
> +              - samsung,exynosautov920-wakeup-eint
> +          - const: samsung,exynos850-wakeup-eint
>             - const: samsung,exynos7-wakeup-eint
>   
>     interrupts:
> @@ -86,11 +90,14 @@ allOf:
>     - if:
>         properties:
>           compatible:
> -          contains:
> -            enum:
> -              - samsung,s5pv210-wakeup-eint
> -              - samsung,exynos4210-wakeup-eint
> -              - samsung,exynos7-wakeup-eint
> +          # Match without "contains", to skip newer variants which are still
> +          # compatible with samsung,exynos7-wakeup-eint
> +          enum:
> +            - samsung,s5pv210-wakeup-eint
> +            - samsung,exynos4210-wakeup-eint
> +            - samsung,exynos5433-wakeup-eint
> +            - samsung,exynos7-wakeup-eint
> +            - samsung,exynos7885-wakeup-eint
>       then:
>         properties:
>           interrupts:
> @@ -105,8 +112,6 @@ allOf:
>             contains:
>               enum:
>                 - samsung,exynos850-wakeup-eint
> -              - samsung,exynosautov9-wakeup-eint
> -              - samsung,exynosautov920-wakeup-eint
>       then:
>         properties:
>           interrupts: false
