Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B07531D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjGNGNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjGNGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:13:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79472680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:13:26 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714061324epoutp018ee1a6ea65ea1d65c6b52ecece936c78~xpzqA-3Jf1139511395epoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714061324epoutp018ee1a6ea65ea1d65c6b52ecece936c78~xpzqA-3Jf1139511395epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689315204;
        bh=azLmA+oEU0Tyzhclaxzw2p+bZdMaW0V0aaD5/qMcV8M=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fTODH7czn0vecZ9fy4yEMnEM9BJBoagaIYNay7JmYvsi5eZM4QSdGglmPZHORxJ+s
         iSmG+UUuZq1zDf8RdTT5V5B/zdZWph4SVgklA+vLdJgIajyQaP/ca6uKmEzsNVoIdI
         Eb2AAzBDCkcesJXvU/9l6U9CAQfyMjmMWNAoKU5Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230714061324epcas2p184cb966d0072272800b674f6a38d848d~xpzpZ2p5g2011120111epcas2p1r;
        Fri, 14 Jul 2023 06:13:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R2Lkq5N3Dz4x9Q2; Fri, 14 Jul
        2023 06:13:23 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.6A.32393.387E0B46; Fri, 14 Jul 2023 15:13:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230714061323epcas2p11c4689adee180698c083d96879141175~xpzofHq1s2261622616epcas2p1T;
        Fri, 14 Jul 2023 06:13:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714061323epsmtrp2b9f835b1351a4b876b98b61158a550c4~xpzoeTcsX2960329603epsmtrp2M;
        Fri, 14 Jul 2023 06:13:23 +0000 (GMT)
X-AuditID: b6c32a48-adffa70000007e89-de-64b0e7832370
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.E5.30535.387E0B46; Fri, 14 Jul 2023 15:13:23 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230714061322epsmtip2184eb180a288744a183882b4b7226d89~xpzoK2ge31244412444epsmtip2Z;
        Fri, 14 Jul 2023 06:13:22 +0000 (GMT)
Message-ID: <b737369d-b443-26dd-e4a4-b5906b70ec71@samsung.com>
Date:   Fri, 14 Jul 2023 15:10:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Conor Dooley' <conor+dt@kernel.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <000401d9b618$59a29d80$0ce7d880$@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmmW7z8w0pBtPXq1s8mLeNzeLyfm2L
        NXvPMVnMP3KO1aLvxUNmi72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgctj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjNmPNvMUrCCpWLpnfnsDYxzmbsYOTkkBEwk7s/ZxwRiCwnsYJS4
        vp+1i5ELyP7EKNGy6BA7hPONUWLC0z1MMB0zWrcxQ3TsZZR4/FEToug1o8TUezdYQBK8AnYS
        n6YsYwOxWQRUJX6unAgVF5Q4OfMJmC0qEC3Ruuw+WI2wgLfEglWNYHFmAXGJW0/mM4EMFRGY
        ziRx4ko/G4jDLNDOKHFqzg12kCo2AW2J7+sXs4LYnAJWEpe/nmCH6JaX2P52DtRzCzkkZm0z
        h7BdJH7df8cCYQtLvDq+hR3ClpL4/G4vG4SdLdE+/Q8rhF0hcXHDbKi4scSsZ+2MXYwcQPM1
        Jdbv0gcxJQSUJY7cgrqZT6Lj8F92iDCvREebEESjmsT9qeeghshITDqyEhqGHhKP+54yTmBU
        nIUUKrOQfD8LyS+zEPYuYGRZxSiWWlCcm55abFRgAo/r5PzcTYzg1KrlsYNx9tsPeocYmTgY
        DzFKcDArifCqbFuXIsSbklhZlVqUH19UmpNafIjRFBg3E5mlRJPzgck9ryTe0MTSwMTMzNDc
        yNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGJt1v+7cKrXl+aWmViq7inPvPJ+99OZ9n
        +4m6NQ8lWRet/r43qIuJe4L1ymN2K2f/zNW/ZjfzSdzrNwuUC9j+fj6ZviI77OfhXsEUtu96
        yWpLj92Vunxuy8rJCfJGckHh3alfH77vvrjUWHBpwh1JmRi5iywmGnnJrslXTjf5XWg4eu05
        7/Fv9ziaVxmkG3x8c2xNHuua8jkTj+6t+v57TbFpcqNeJ0vy3qvWxw5v3qh9XOt8jbH/s5wS
        L9/iPY721Z+LgqUYGmedOdYyUT18p96RTtMtU6c+mdPo9fvjhdhjJu+mn/m2vXe5+YzC3Z/O
        MYeqfrz/WO238s/nH76+fVn23j7yZe5XnU2NXQmzS1dMUGIpzkg01GIuKk4EABeh0lo2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXrf5+YYUg2u3uC0ezNvGZnF5v7bF
        mr3nmCzmHznHatH34iGzxd7XW9ktNj2+xmpxedccNosZ5/cxWbTuPcLuwOWxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujBnPNrMUrGCpWHpnPnsD41zmLkZODgkB
        E4kZrduAbC4OIYHdjBJP7j9jh0jISCx/1scGYQtL3G85wgpR9JJRYvmuS2BFvAJ2Ep+mLAMr
        YhFQlfi5ciILRFxQ4uTMJ2C2qEC0xOrPF1hBbGEBb4kFqxrB4swC4hK3nsxnAhkqIjCTSeLt
        zr/sIA6zQDujxJ23s9kg1n1llFj3/hPYCjYBbYnv6xeDjeIUsJK4/PUEO8QoM4murV2MELa8
        xPa3c5gnMArNQnLJLCQbZyFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxN
        jOC40tLawbhn1Qe9Q4xMHIyHGCU4mJVEeFW2rUsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvt
        dW+KkEB6YklqdmpqQWoRTJaJg1OqgclnUsuX3NPnD97vOXF3AvPma9cl7qn2/vnBr+Eoq/fx
        e5um9QKbaxKXzz7xWxkW8cL3wfpOrgTPgl93JpRv2vmtrmfL9E+MSy0LbpgJtFkfjN7Omf6N
        7Z/ronovdafmQxc2nbgs3Cr12/d8fFSLj1prfY7U2RSz+yE5Dzl6uyvrylds43Gu/Du17ald
        gVWRTXObkZDIbr0Jl5pYGjqenlzMfMj5Y/xO8fIjTSEcp7nsuWUWlh/+lJQf8L/ExDnj7dOV
        0WKfbsdOapW56/fAUjUh6m3Wj/dnlmp+cH6yb5f8X98Ktrkmqnsqwlb26T0X9Or5WP/B8Nat
        ExusPq2Rbpr1/NnK9e8fZDFqqC4Lu6XEUpyRaKjFXFScCADaQ3xvGgMAAA==
X-CMS-MailID: 20230714061323epcas2p11c4689adee180698c083d96879141175
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
        <000401d9b618$59a29d80$0ce7d880$@samsung.com>
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


On 23. 7. 14. 14:59, Chanho Park wrote:
>>> +			reg = <0x103f0000 0x100>;
>>> +			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>>> +			#pwm-cells = <3>;
>>> +			clocks = <&xtcxo>;
>> This does not look like correct clock. Are you sure XTCXO goes to PWM?
> Yes. XTXCO is the source clock of the pwm. Unlike any other exynos SoCs, the clock is directly derived from the external OSC.
> Thus, it cannot be controllable such as gating.


Thanks Chanho.

I miss this comment.


>
> Best Regards,
> Chanho Park
>
>

Thanks

Jaewon Kim

