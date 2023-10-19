Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE27CF8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjJSM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbjJSM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:27:59 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC14B106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:27:57 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019122756epoutp036730cb5ba62fe5236141fa6abc332d1d~PgfWR4hYX1163111631epoutp03W
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019122756epoutp036730cb5ba62fe5236141fa6abc332d1d~PgfWR4hYX1163111631epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697718476;
        bh=688aE9Nws9c3dOqWnubX6ii4EGimkiuoUkLhVlItdCw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=EDuPrposR5Fsn5z1Be4bmR5cMG3M3eB2wUr0S2nFO02721uH9DR9eat97uE0LQVNV
         2yeyMq28PiwxYCZqhailFMoHQSZMRV93yBU97xPdg3TMNju6IQ8lbkm7ehzrvlvglq
         SoD7Ep9rYqjISEvgox9UpR9NTX7oC2YxmoCQgkls=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231019122755epcas1p462d597be8e20db6a99da22334ea5b2e6~PgfVqx5_Y0183701837epcas1p4U;
        Thu, 19 Oct 2023 12:27:55 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SB6SB1cPyz4x9Q4; Thu, 19 Oct
        2023 12:27:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.A4.10025.AC021356; Thu, 19 Oct 2023 21:27:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019122753epcas1p47b1f94030df303ec4c8671843e7ef2a6~PgfTjGt_10389603896epcas1p4L;
        Thu, 19 Oct 2023 12:27:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019122753epsmtrp2cfb01ee11788989ab379d9a2d7f0136f~PgfTg7yGD2736227362epsmtrp23;
        Thu, 19 Oct 2023 12:27:53 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-79-653120cae5d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.F9.07368.9C021356; Thu, 19 Oct 2023 21:27:53 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019122752epsmtip2d637103c556584527077c54b09501bc7~PgfTJWNdP2311623116epsmtip2y;
        Thu, 19 Oct 2023 12:27:52 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <kernel@pengutronix.de>,
        "'Michael Riesch'" <michael.riesch@wolfvision.net>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Vincent Legoll'" <vincent.legoll@gmail.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Sebastian Reichel'" <sebastian.reichel@collabora.com>,
        "'Conor Dooley'" <conor.dooley@microchip.com>
In-Reply-To: <20231018061714.3553817-23-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 22/26] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3588 support
Date:   Thu, 19 Oct 2023 21:27:52 +0900
Message-ID: <003001da0287$ae6b2970$0b417c50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwLNIYk4A0SM3OyxJB2SoA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjd7WtfC676hoBXnLM8ZhaMYKstXBA2I8he1DgWAsscGzb02RKg
        7fpjE+didYC2QQSZUysoTDtdV0ZWEApbJQIRcROHP8o2wDCFxVJpGI0KOsJaHm78d873ne9+
        59yby8NCZvAIXp5SR2uU0gISD2Y3d0YLY64LRLSw1sRDlb/dYSObs5eFvrQ7uOhsVy8Hzd73
        cJD1eCsblT/8E0M3Dj7iIvsDFwfdbqvGke9IF0CTw7MYsvT3sdCVutfRwIGLOCpxdnHRlYkR
        DpppsbPRkGcH6q7/C0fFg5JNYZTtjA1QjqHzgGo1D3Epu9WIU4Oun3Cq8fx+anDKAqijM0Kq
        vMkKqBbXGYzy2V+jzj5/ANJf3pmfpKClMlojoJW5KlmeUp5MbsvIScmRxAlFMaIEFE8KlNJC
        OplM3Z4ek5ZX4I9KCj6RFuj9pXSpVkuuezNJo9LraIFCpdUlk7RaVqCWqGO10kKtXimPVdK6
        RJFQuF7iF+7KVwzYuoH6ROie0aYBrgFcJUwgiAcJMez2GFgmEMwLIRwAflX7xTyZ9JPLjYAh
        TwAc6fKxX4yYTjVgTMMJYFfbJQ5D3ADeb6jjmgCPhxNrYe1UZmAglMiER6855o7FiAs4/Ofw
        SVagEUS8BW/eG8YCeCnxIbxlOTxXZxOr4dhUHzeA+UQC7HC6OQx+BfacGplzgRGrYMt4NcY4
        EsDp0W84TD0UnjaWYszizdBcdpnFaL4LgvbpNAanwnMVbsDgpXCsu4nL4Ajo8zrxgFFIVAHY
        5/FgDGkA8Idvi+e3bYDtlipWICVGRMOGtnVMORK2Pq8BjInF0Pu4jBOQQIIPD5eGMJIoeHt4
        aN7PcnjukBGvAKR5QTTzgmjmBXHM/y+rBWwrCKfV2kI5rRWpJf89d66q0A7m/sGaBAc4MT4R
        2wFYPNABIA8jQ/mrKSEdwpdJi/bSGlWORl9AazuAxH/ZlVhEWK7K/5GUuhyROEEojlu/QYxE
        cSJyGb93/IgshJBLdXQ+TatpzYs5Fi8owsCq0hcW8Z17Nt090Jqd70uK6FTs3pa4xLwq6uFN
        W+RKo9eebvDGPxXkTMftX3Q8bK3lkfyZwbe3ovPkMn09/dnWyBsxyRn41L3Td6811it4WVFj
        P5f5at5/FxvZEq/cOL0vxfQeKXpW43S+Qeq/li2K/r2n4cdJY5s7zB2+L8tjxsM+7i+NefWP
        p5+3B/fccVlfYt26ZHM9vvBB2TuV7WnOjd4lzbssrkQpX7wy7QkNhqpXfMraEl70/d+LBzT6
        8UODNVeX1w03Jjs6dl6MWvHrLxkZYzP9qaQo3LA7250yKs/OR9c3u3eMbLe+PYEyi7eWlDfT
        JUmzWR8dFHtzj+kFPLeRZGsVUtEaTKOV/gt/B+BbkAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt/vYdWhcN62fGimrkYktVym/nmph3EikPzIoIx16ceZr7Wpm
        JNlDw0dalprz1csea2ZNa1Oz0Gm1sIdY5mtmqVlpGUVgxTTniPzvcM75znc++ChMOIK7UjEJ
        SawqQR4nJgX4PaPYfbnJQ8b6FLXz0ZnuVzjSNj3noXM6Ax9Vtj4n0PT7MQJpCutxlPfxHYae
        HRvnI91QF4E6G8pI9ONUK0DfB6cxVPWmg4eaLy5BfUevkyijqZWPmr8NE8ii1+HIPBaCHld/
        INGJft8AZ0ZboQWMwXwFMPVqM5/RabJIpr/rPsnUXjnC9E9WASbf4sPk1WkAo++qwJgfukVM
        5Z8hsN1+t2B9FBsXc4BVrdgYIVD0aR8DZbHTwZG6Pn46eERnAzsK0qthdkkNlg0ElJBuBDCj
        4CthE1xgUUfbjEDNYBE0GjmbZxTA2jw9YeVJ2htemAy12p3oUJj/xMCzejD6LgkLjD+BbaAF
        wKleM2l12dH+8MXAIGbFIjoMVlUPz/I4LYGfJzv4VuxAr4EtTZ8IG3aEppJh3LoMo6Uw8w6w
        0hjtDvVfyjBbTw/4a+QqYeOdYGlWJmYrtAmqcx/wTgORek6S+n+Sek6Ses70BYBrgAur5OKj
        4yNlSlkCmyLl5PFcckK0NDIxXgdmP8HL0wAGKqekLYBHgZkTKUzs5CBhfFihQ5Q89RCrSgxX
        JcexXAtwo3DxAgfZ+dIoIR0tT2JjWVbJqv6pPMrONZ0XnMMl3Y5UOd9wEXo91dS1R7+OLHKr
        fXM5GD971G8LWih41asIu5UmsrT/Htzz7I55+Vr/kZTx8MINQ/u4L7HCFDsPSZAlaE/uxjHv
        zd65zrWoMvahQrDSz81xMJN08yh0jzh2N3QiZAHYMDEaSBxeFX78pd9JfGLnuh6d/qvOX51k
        NpLZlrSYrd6+kpzi9xY8tiCL3/T9pmbdkLCuQJkaLmnwL7vsueznwMr0MNOubeXl466dHUGL
        /+w19FpMnX3XTpnkrGOKfeM47upYc7YtbWlPmjb57aWa4ttk6v6eA/YRosCgxOD13fkT86XQ
        r97eU6JXB8yjp3fsq5aMFinEOKeQy7wwFSf/C4n2qKR4AwAA
X-CMS-MailID: 20231019122753epcas1p47b1f94030df303ec4c8671843e7ef2a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063745epcas1p4de8a7797491a4c207f9cfbf8f1182f6a
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063745epcas1p4de8a7797491a4c207f9cfbf8f1182f6a@epcas1p4.samsung.com>
        <20231018061714.3553817-23-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Wednesday, October 18, 2023 3:17 PM
> To: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Chanwoo Choi
> <chanwoo@kernel.org>; Kyungmin Park <kyungmin.park@samsung.com>; MyungJoo
> Ham <myungjoo.ham@samsung.com>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; kernel@pengutronix.de; Michael Riesch
> <michael.riesch@wolfvision.net>; Robin Murphy <robin.murphy@arm.com>;
> Vincent Legoll <vincent.legoll@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Conor Dooley <conor.dooley@microchip.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Subject: [PATCH v8 22/26] dt-bindings: devfreq: event: rockchip,dfi: Add
> rk3588 support
> 
> This adds rockchip,rk3588-dfi to the list of compatibles. Unlike ealier
> SoCs the rk3588 has four interrupts (one for each channel) instead of only
> one, so increase the number of allowed interrupts to four.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>      - new patch
> 
>     Changes since v5:
>      - drop interrupt-names property
> 
>     Changes since v4:
>      - new patch
> 
>  .../devicetree/bindings/devfreq/event/rockchip,dfi.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index e8b64494ee8bd..50d3fabe958d5 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,rk3399-dfi
>        - rockchip,rk3568-dfi
> +      - rockchip,rk3588-dfi
> 
>    clocks:
>      maxItems: 1
> @@ -23,7 +24,8 @@ properties:
>        - const: pclk_ddr_mon
> 
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> 
>    reg:
>      maxItems: 1
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi

