Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BA7CF8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjJSM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjJSM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:27:14 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16321184
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:27:12 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019122709epoutp036229b2dbb4f042bc98b39425c9efe7db~PgeqtLC2R1314213142epoutp03l
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:27:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019122709epoutp036229b2dbb4f042bc98b39425c9efe7db~PgeqtLC2R1314213142epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697718429;
        bh=dN+zGFcdP9br6hD3NpsfnvsXV48m9TbzD1vcRMr23po=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jwaw2hj+BCXWoaAD7E/h9b6EbEp9KuOS1J2iUf8qfj0P8zyBisUYODwCmoMQggS4q
         Ks0U//9bL1VEeDW0rPxLTgUcp4L6S/fSqD7fBMHuV14RGZK9IqhvaYS+jGgtKM4XSl
         IfEc2Ke+ogrRNjvi6azeGNEUIJbYggGMKCHXpWoY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231019122708epcas1p3be3f84be9daa7d1eded5f19370e2fbf8~Pgep0Mw-a1072910729epcas1p3l;
        Thu, 19 Oct 2023 12:27:08 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.144]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB6RH1MNXz4x9Q7; Thu, 19 Oct
        2023 12:27:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.10.19104.A9021356; Thu, 19 Oct 2023 21:27:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231019122706epcas1p37194d4e0e8ee7cf441922f367e4fdb7e~PgeoDdeuh1081010810epcas1p3Z;
        Thu, 19 Oct 2023 12:27:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019122706epsmtrp11aa5dc35d1ca13919594ac2a0b2cab8c~PgeoBUfQL0593505935epsmtrp1d;
        Thu, 19 Oct 2023 12:27:06 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-14-6531209a77f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.FA.08817.A9021356; Thu, 19 Oct 2023 21:27:06 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019122706epsmtip1bf2880a4a4a116a9c9e27e969088f164~Pgenr4gdo1757917579epsmtip1s;
        Thu, 19 Oct 2023 12:27:06 +0000 (GMT)
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
In-Reply-To: <20231018061714.3553817-22-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 21/26] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3568 support
Date:   Thu, 19 Oct 2023 21:27:06 +0900
Message-ID: <002f01da0287$929b1b10$b7d15130$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwJUatcTAX/BZO6xNglxEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1CUZRT23W9vOC59LDC+bU0ua5hSi/vJ7cXAmDD5NAwa9U9JsC1fQCy7
        y14wHSbQAHe9gAQpLCRUQMggOy6MsNsyzBKDUiMFNKsUjATWcDFISO6Xdvmw+Pecc57nPec5
        7xwuxl9jC7gpCi2lVkjlIvZW5u3v9/iLy4QEJSluA6jwwS9MVN/azUDF5hYOqujoZqG14QkW
        qvvCwkT5o79j6N65xxxkHnGwUJ+1nI1mLncAND20hqHq+z0MZP/qZfTb2Vo2ym3t4CD7349Y
        aKXZzESDE++gOzf/ZKOcgaAIb7L+ej0gWwarAGkxDnJIc52BTQ44bGyysSqLHJivBmTBioTM
        b6oDZLPjOkbOmF8iK5ZGQOy291LDkilpIqUWUgqZMjFFkRQuevtYfGR8ULCEEBOhKEQkVEjT
        qHDRwehY8aEUudOqSJghleucqVipRiPaeyBMrdRpKWGyUqMNF1GqRLkqSOWvkaZpdIokfwWl
        3U9IJPuCnMSE1OQ8fS5DNen5SY+jlpMNTPgFwOVCPBA2LLx/AWzl8nEbgEuLdg4dTAM4+fAW
        kw5mAXzSUOusuK0rlj+bZ9GFVgBLDZWYq8DHxwBcyw5wPcvGX4OV8ydcaS/8BCy428Jw8TH8
        WzZc1pcwXBw3/A1YP3PKxfHE4+Bw1bn195m4LxyrusdyYR4eCi/O5gIae8Cu0kdMF8bwHbD5
        r3KMnkcIF/6oYdF5L1hmyMPovm9Ce9Uo5uoLcZMbLC5Z3hAchAudN9k09oTjd5o2jAngWEEe
        hxYUAdgzMfFMDeCtGzkb6gDYVl207gDD90CTdS+d9oGWpS8BPYU7nHx6iUXvlwf1eXyashP2
        DQ0yaPw8/Oa8gX0FiIybvBk3eTNu8mP8v1klYNYBAaXSpCVRMkJFiBXUqf8+XKZMM4P1S/CL
        bgFzphX/dsDggnYAuZjIi+dLSig+L1F6+gylVsardXJK0w6CnBsvxATeMqXzlBTaeCIwVBIY
        vC8gEBHBhGg77+T0+UQ+niTVUqkUpaLUz3QMrpsgm1Gk//Chx8yktzXrg7Pp313hxsk6EtxP
        Q2NXCOcVrJlI72XcLdYvWVbHty82HInQxgzsWpSqF18YiszI2dY9F0PNLld83BalH9UYpl4s
        7Jw+Pmsdt+VHRoH0pU/n4sTz7Rk/J5l2HrWWXvu6q8H60dUtgY5+YRPP58xb//BXI3dEe7tH
        pb06lSm3PDHU9HWk2/JqyqJ1Ww7NltQmlKa8ax/J1EdEz/WGLTaOmTJbwo/7GUKe65/qnL+0
        n3vSZ7fYI+bHxzE2fuPrXKI/4r5gl+z206M/xDMelGfmHLg6dizrc7tvPefyjUxeNcfmMZx9
        +OJqbzM/5adKXXafJWDIof1192ERU5MsJfwwtUb6L55RNzuSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSnO4sBcNUg18NMhYTb1xhsViz9xyT
        xZRNO9gt5h85x2rx/9FrVotVU3eyWPS9eMhscbbpDbvFpsfXWC0u75rDZvG59wijxacH/5kt
        ll6/yGRxcKGKxe3GFWwWrXuPsFsc/PCE1eLv9k0sFndf+1kcX/uMzaLljqmDqMeaeWsYPXbc
        XcLosXPWXXaPTas62TzuXNvD5rF5Sb3HnR9LGT36/xp49G1Zxeix/do8Zo/Pm+Q85v9+zBjA
        E8Vlk5Kak1mWWqRvl8CV0dbRylTwTrji4rUV7A2M6wW6GDk5JARMJP40/2AFsYUEdjNK9Cy0
        gohLSky7eJS5i5EDyBaWOHy4uIuRC6jkOaPEppcb2EHibAI6Egt+hIKUiwiESvSf2MEEUsMs
        sJVNYtLhr4wQDYcYJe6d280E0sApYC+x5nM5SIOwQLTE6j3TWEBsFgFViZdLzoLdwCtgKdH9
        rZURwhaUODnzCQtIK7OAnkTbRrAws4C8xPa3c5ghzlSQ+Pl0GStEXERidmcbM8Q9ThIHl7xg
        nsAoPAvJpFkIk2YhmTQLSfcCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB6UBL
        awfjnlUf9A4xMnEwAn3IwawkwqvqYZAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0
        xJLU7NTUgtQimCwTB6dUA9NqqWUHvlydNOWujUtpi4Bc8ITAc+tsU7KXHXo8Ke+90Y/Xq/9W
        H/jy5P3ST9Fbay+vX7tF0GGfT92b7GOXj3Wfir48dcbZtWe3sJz5dPnEtd0JdYzestPtVTuq
        g6J2hlWur2Bi0ZjbNKeXg+mgYueU1kcKq+MN0goNFa+G/rFQ2c+sPP/WvdYz9vz8NUX+k62e
        8Amn1AlHroy5caHeI707dxLPJ2d/jZ8MGb23JP63rZ+buDeY6T3b9EPLJKe8+TNpYco8semr
        9dtaM2acYP6+TtNp0i1Pq6JAIeOwsKUF/lFagRzJqy90GvkfcOv7n/A8/jq3wzz+QxNeaNUt
        OrVWdZuHatsrdqNTdg9FyoSUWIozEg21mIuKEwFMpQeWdgMAAA==
X-CMS-MailID: 20231019122706epcas1p37194d4e0e8ee7cf441922f367e4fdb7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063804epcas1p15faa4554f249a484ffb8ca8f3433daf3
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063804epcas1p15faa4554f249a484ffb8ca8f3433daf3@epcas1p1.samsung.com>
        <20231018061714.3553817-22-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> Subject: [PATCH v8 21/26] dt-bindings: devfreq: event: rockchip,dfi: Add
> rk3568 support
> 
> This adds the rockchip,rk3568-dfi compatible to the binding. Make clocks
> optional for this SoC as the RK3568 doesn't have a kernel controllable
> PCLK.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml      | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index 7a82f6ae0701e..e8b64494ee8bd 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3399-dfi
> +      - rockchip,rk3568-dfi
> 
>    clocks:
>      maxItems: 1
> @@ -34,11 +35,21 @@ properties:
> 
>  required:
>    - compatible
> -  - clocks
> -  - clock-names
>    - interrupts
>    - reg
> 
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,rk3399-dfi
> +
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +
>  additionalProperties: false
> 
>  examples:
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi

