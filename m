Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B980BF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjLKC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKC3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:29:22 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE16E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:29:26 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231211022925epoutp03f82c9276e6b2383ed216c8e913187a34~fpg5sQ0I51817518175epoutp031
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231211022925epoutp03f82c9276e6b2383ed216c8e913187a34~fpg5sQ0I51817518175epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702261765;
        bh=9PZVF+Izd/fOscHxPgBInDtGjFKMvs6YTcTU/inrFa4=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=sfdCbo4MtCPRblJ/9jt2GCLxDEW96f8kJp9jq5EAB9FCjvFKtW34JVaO191dNUzWF
         xeAYjA15ES6iqRGmekXgujpIcd3O4DEmpkLS6SQR/g6FUiYSWA3kkxX5Bb/wFJDOPL
         mhBcnmUTPQ4w7H1EIVGUC81ECzQKUG1rXkPiQaus=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231211022924epcas2p1381bb2c10e34ff95d5d9a9a677bdf61f~fpg5a_D7x1667216672epcas2p1-;
        Mon, 11 Dec 2023 02:29:24 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SpQg81jPsz4x9QF; Mon, 11 Dec
        2023 02:29:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.95.08648.40476756; Mon, 11 Dec 2023 11:29:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231211022923epcas2p39263deafcd69ab8a00cae7c851bd4d81~fpg4dvKMh2462424624epcas2p3j;
        Mon, 11 Dec 2023 02:29:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231211022923epsmtrp2042e9716f8f9b573c1ef099ec722a5c7~fpg4c_XSy1413214132epsmtrp2j;
        Mon, 11 Dec 2023 02:29:23 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-12-657674046aeb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.FA.08755.30476756; Mon, 11 Dec 2023 11:29:23 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231211022923epsmtip1df473844cd00b069666697ad1500d674~fpg4KnSPk1130311303epsmtip1h;
        Mon, 11 Dec 2023 02:29:23 +0000 (GMT)
Message-ID: <df677a28-284f-4f80-afa7-9bf71bc8ce2e@samsung.com>
Date:   Mon, 11 Dec 2023 11:26:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: samsung: exynos-sysreg: combine
 exynosautov920 with other enum
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmuS5LSVmqwbwzXBYP5m1js1iz9xyT
        xfwj51gt+l48ZLbY+3oru8Wmx9dYLS7vmsNmMeP8PiaL1r1H2B04PTat6mTzuHNtD5vH5iX1
        Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE7Y+7UlcwFs3gqtu3sZ2xg/MPRxcjJISFgIrF83jO2LkYuDiGBHYwSTRde
        MEI4nxglHt69C5X5xijR0/mTDaZlWs8GqKq9jBKvvm6Ecl4zSkxsns0CUsUrYCfxds1lJhCb
        RUBV4u31x8wQcUGJkzOfgNWICkRLtC67DzZVWCBJ4v/MCawgNrOAuMStJ/OZQIaKCLxmkvh2
        +xRYgk1AW+L7+sVgNqeAi0TD9WNMEA3yEtvfzmEGaZAQ6OWQmH/6KtStLhJ3fk9mhLCFJV4d
        38IOYUtJfH63F6omX6LtyhmoeI3ExgWXoOrtJWb93gK0jANogabE+l36IKaEgLLEkVssEGv5
        JDoO/2WHCPNKdLQJQTSqSdyfeg5quIzEpCMrmSBsD4lD7Z9YIGE1nVFi/a+fTBMYFWYhBcss
        JO/PQvLZLIQjFjCyrGIUSy0ozk1PTTYqMIRHd3J+7iZGcGLVct7BeGX+P71DjEwcjIcYJTiY
        lUR4ZY4UpwrxpiRWVqUW5ccXleakFh9iNAVGzkRmKdHkfGBqzyuJNzSxNDAxMzM0NzI1MFcS
        573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgWmp76Ybbi1pC7asO6HVFFgoqxykOUF5l/ehY8mf
        LNJuVxw5smva4xN5XOU6r/ckp+fM81gZOF98ybzDHg45h3yXncpf1dJyz0Hu8k3JBc/MM856
        s+5b/1/6YO30aQKfezuC/IR0C70fPjxz0llh34RDplzHfjYv1vXraZt2eI2hysxMw1vy8ump
        rEWctevvhU/2e89ozHQru7Vp4csDLS1XSyTZ+CepMnvlNh2/lWNv89f8/I/LcxiuuZxTXrF+
        18OJXMk3bn37E6Hsl73yud15vi3biqbMNS/JVnR8+PfG7R05us8/ci19p3O3MMLHYt71Z709
        P1bv39PL8aJ/UW2uk9H7RfP13Y8/3PBoU5mrEktxRqKhFnNRcSIAte9CWDUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnC5zSVmqwZNbShYP5m1js1iz9xyT
        xfwj51gt+l48ZLbY+3oru8Wmx9dYLS7vmsNmMeP8PiaL1r1H2B04PTat6mTzuHNtD5vH5iX1
        Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJUxd+pK5oJZPBXbdvYzNjD+4ehi5OSQEDCRmNaz
        gbGLkYtDSGA3o8SR5h52iISMxPJnfWwQtrDE/ZYjrBBFLxklntxezgyS4BWwk3i75jITiM0i
        oCrx9vpjqLigxMmZT1hAbFGBaInVny+wgtjCAkkS/2dOALOZBcQlbj2ZzwQyVETgNZPEpL3t
        7BAbpjNKdP74zwhSxSagLfF9/WKwDk4BF4mG68eYILrNJLq2djFC2PIS29/OYZ7AKDgLyfJZ
        SJbMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwVGjpbmDcfuqD3qH
        GJk4GA8xSnAwK4nwyhwpThXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUg
        tQgmy8TBKdXAlMKYemkOm7tQ58kneRZZ6zz3L3a9cJfB3vGU8VvfrBTBbNc5T2ZKLCg15Zru
        d4LvNgeb3cmalcn1Me5zTERmdGZ5mzh9LD2gMsX340oehvUHzuW773gy44yr86rAEzKFy7mm
        nsh+N9tObmL5zxNZHlMlTm0XSelKLewI49oYwK+xLtFdaM6iT7c+3Jgu86jN/D3b1g5Z9rP7
        dzjPcF4SoZs137r8jXZsVfSMbennt3DEH7R/efPZ/pJJbg/zXz12+J/Hd2pqrNGHsJs/LA2V
        p/hz26xuy3lz8brpC42ju1PWGf++mLkgPoT9T0bW4+Pf3pwWkjjkWJ7RFFC+4EGBZtzk0v4F
        Pxd3HzHzrq1eqsRSnJFoqMVcVJwIABBTUhkJAwAA
X-CMS-MailID: 20231211022923epcas2p39263deafcd69ab8a00cae7c851bd4d81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231210134852epcas2p4166a413502a742b6f558d7b55bd36ae6
References: <CGME20231210134852epcas2p4166a413502a742b6f558d7b55bd36ae6@epcas2p4.samsung.com>
        <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 12. 10. 22:48, Krzysztof Kozlowski wrote:
> No need to create a new enum every time we bring-up new SoC.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Jaewon Kim <jaewon02.kim@samsung.com>


>   .../bindings/soc/samsung/samsung,exynos-sysreg.yaml        | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 2de4301a467d..b00f25482fec 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,6 +17,8 @@ properties:
>                 - samsung,exynos3-sysreg
>                 - samsung,exynos4-sysreg
>                 - samsung,exynos5-sysreg
> +              - samsung,exynosautov920-peric0-sysreg
> +              - samsung,exynosautov920-peric1-sysreg
>                 - tesla,fsd-cam-sysreg
>                 - tesla,fsd-fsys0-sysreg
>                 - tesla,fsd-fsys1-sysreg
> @@ -50,11 +52,6 @@ properties:
>                 - samsung,exynosautov9-peric1-sysreg
>             - const: samsung,exynosautov9-sysreg
>             - const: syscon
> -      - items:
> -          - enum:
> -              - samsung,exynosautov920-peric0-sysreg
> -              - samsung,exynosautov920-peric1-sysreg
> -          - const: syscon
>   
>     reg:
>       maxItems: 1
