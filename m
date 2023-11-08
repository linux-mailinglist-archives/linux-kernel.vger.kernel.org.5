Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D007E5C56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjKHRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKHRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:25:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FCE8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:25:05 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231108172503epoutp024447108345c5ac9bebc6adbc88891a8d~VtcedmjyV3239732397epoutp02n
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:25:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231108172503epoutp024447108345c5ac9bebc6adbc88891a8d~VtcedmjyV3239732397epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699464303;
        bh=KazPsK4ueHTWHKpdtvqL1KTLHLtjIKrzUv4nkVxxV5I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Fjgwbg/smn4CyAfJkM36DTopkGXcEhDDOo1NQPvxVuu3qGrW44cPc0iDRjTETyaRr
         t/XKSPUhTgf869FJkx11/AZOTROuuBKTG1nnBoC8pyytNZi8cNmB4vdp6U7SS9WrLc
         DVC1ZwT+ZUJ+7kMKd6IL9EAJ0UIX5ZD+GMJGWfPo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231108172501epcas5p3bf95080b44478555384070bd3514cc3b~Vtcc9rSrx0784407844epcas5p3R;
        Wed,  8 Nov 2023 17:25:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SQX5m1GB6z4x9Pt; Wed,  8 Nov
        2023 17:25:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.11.09634.B64CB456; Thu,  9 Nov 2023 02:25:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231108172459epcas5p2254e6f36e6a4826d486246c9c236ea19~Vtca5cScu0241402414epcas5p2s;
        Wed,  8 Nov 2023 17:24:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231108172459epsmtrp129a231134b107b286a53b4ea7550d7c2~Vtca4dndR1062710627epsmtrp1G;
        Wed,  8 Nov 2023 17:24:59 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-b4-654bc46b2256
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.6B.08817.B64CB456; Thu,  9 Nov 2023 02:24:59 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231108172456epsmtip2ede42aa2a600b1bb560cec077d771672~VtcX3e2V92569525695epsmtip2N;
        Wed,  8 Nov 2023 17:24:56 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Aakarsh Jain'" <aakarsh.jain@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <krzysztof.kozlowski+dt@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <ajaykumar.rs@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <630d58e0-589e-4411-905a-2514048e6ec4@linaro.org>
Subject: RE: [Patch v4 01/11] dt-bindings: media: s5p-mfc: Add mfcv12
 variant
Date:   Wed, 8 Nov 2023 22:54:55 +0530
Message-ID: <000101da1268$7fdb2ce0$7f9186a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQK0rOY9AbqXOzoB/yYnBQI39X9KAMF2lI+uC8rFYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxz23HvbW4w1dwXCocsYdGwMGY+yUg+LgMnccolmkrE5R+K6Su+A
        UdqmD4ZzEwajbiAiTtRWmOPZhKAuVd52KdjKRhSCD0oTCSLoeIg6QDOY4loubvz3/X6/7zvf
        7zsnh4cLSkkhL0ulZ7QquVLEXU+0XgoPi1Q6tjMxvW4C3W03cZD9YTeB6v7+E0OjdfME6jnf
        QqJmWz+GLL12Djrt6Oegtu47BHLbOzA0aBoh0OHJMRzZZjw86/gQB41Nf4Kud1Zx0aFfWzjo
        5MBvGDrjGCFRg2sQQ43WpxiqbVkgUbHNQW4NoJt/bga0q34OpzvMIyRdd3EKo61NP3LpW0MX
        ufT5+ny62LlE0IcvNAF6ubCapOetQXTf43kyZUNa9pZMRq5gtMGMKl2tyFJlJIi2p8relcVJ
        Y8SR4ni0WRSskucwCaJtO1Ii389SenKLgnPlSoOnlSLX6UTRiVu0aoOeCc5U6/QJIkajUGok
        miidPEdnUGVEqRj9O+KYmNg4D/Hz7MxbrTe4mmcRedUdBwrAwddKgA8PUhK4eHWcLAHreQKq
        C8CWLhtgizkAC/scHLZ4AuDwbD3+QjLaW7o6sAF43d6KscUkgDXTzVwvi0tFwvY6I9c78KMW
        AOy0O1dccGoEhzNlZ4CX5UMlwoHBGg+Lx/OldsJ7dW962wQVCge6bSsH8al4aBmqBCx+Cf5h
        miC8GKciYGPNzOpKwXDxbiPHi/2oXbB8dJHLcgLglNOx4gupNh84abxNsoJt8Mjv9zEW+8Lp
        3gurfSGcKjeS3n0gRcPap0K2nQlnLecAi5Og/UYV4aXgVDg81xnNWm2EZf9MYKySD38wClj2
        67DowU2CxS/DitJSDotpOGkrBkdAiHlNMPOaYOY1Acz/m/0CiCYQyGh0ORmMLk4jVjFf/ffe
        6eocK1j5FZuS28HI7UdRPQDjgR4AebjIj/8siWYEfIV839eMVi3TGpSMrgfEeW67Ahf6p6s9
        30qll4kl8TESqVQqiX9bKhYF8GeKqxUCKkOuZ7IZRsNoX+gwno+wACP5YevCpI7kA6PtoW7D
        xMdvzUvIU1+YuhdMHz3aY7oiuCNNana6SrD8gOHUGs535rhZtb3kmj32lYwTxjIgO348f4rY
        vDdsIWgH77lQ0XvW1bdv54ZL8cfcAw1Z/ql+p0P6WgoLQq8eAiFDS64Q4/73zub135c1tI9+
        uzUi7/L448G47vLwmzn66ImpJtNuyzUrf9jyk3+Q+wNLUVrxKe3YJFPRde+KIflJ3qu7ltr2
        fpZr2Ji4vI6a2083Hs0vcjzw/XBpzL3sbzw4hJx6V+WxxDcCqcqjtV9OO3MDNWlVD9MKx7Xp
        z0WfVsDLY7uth/7y47e59+SdpBeEJ/Tfx36Diwhdply8Cdfq5P8C0BYFLZ4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVDLcRzHfX8P+23T+LXm+npmHo5ihDvfcNHp3O+OPJw7jpxM/a5crbqt
        PF3okYnKiTtbYulhTBybCK2rmacdS1e3LkyKNZmHaHVGdbTh+u9176f7/PHh4sJ+YgJ3T1Iq
        K0+SJoo5fOL2A/HU+QnmtezCR3XjkKNGRaL6rw0EKvvhxFB7WS+BTIZqClUZrRjSPq4n0UWz
        lUR3GjoJ1FZ/F0NNKjuBCj504Mjo+pPTv7ORqOPjVtR87zwHnbxRTaJzjXUYuma2U6iitQlD
        lfoBDF2qdlMo12imVgUyVReqANNa/h1n7qrtFFNW240xet1xDvPaVsthDOVHmNyHPwmm4JYO
        MENZJRTTq5/CWPp6qY1+2/krYtnEPXtZ+YKwXfx4+wsnmZIRvP+1/SbIABniPMDjQnoJbH98
        gswDfK6Qvg9gnqcZ+IyJsPXmKcrHAfDKkJPyhboAfJL9nRw2OPR8WFN2lDPMIvoHgPmdi4dD
        OP0Zhz32939nmzHY9qHE2+DRYbCxqdTbCKAj4a8WjVcn6JmwscHo1QV0KNTazgIf+8OnqvfE
        MON0MHS0Of5zZakL9503DXoclaTvii2wsN3D8WUCYfdDM3UKBKhHTKlHTKlHTKlHVDSA0IHx
        bIpCFidThKQsSmL3SRRSmSItKU4SkyzTA+9rBAXVgFpdj8QEMC4wAcjFxSLB4EqGFQpipQcO
        svLkaHlaIqswgYlcQhwo6HflxwrpOGkqm8CyKaz8n4txeRMysPWnW7oE2nGeV3NDivOV7tXL
        oy/9zAxPj4o3+PGvxHQfelAfOVrz3CTSkmeCihWygU3TBmc1X3v2xhW3dMyo/Ol+6TkBMevW
        jL182qN2Rt6xzl1vyVQlzwjf/pLaUD7+k+GpRXNV+ajlTc+xUHu6bDLPHZHWZMwLDN7SIQp1
        R4Zcj4rd5Fw8doFtwH9h9smc8wlFSuxbQcQgmxU10+IKHZUqefbq3IovZ7ZN8ptNLbWXzMnR
        ZserooWbd77b/8LaVZd5j5eg9DitUZ1Km6Mu0eAQHH5rWcZfzoqHxJKswuID1f2iMSrdVP8S
        w9mIz8SFit1FmhNwXl+pu8LU51myw7laTCjipSFBuFwh/Q0aE08SiQMAAA==
X-CMS-MailID: 20231108172459epcas5p2254e6f36e6a4826d486246c9c236ea19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d@epcas5p1.samsung.com>
        <20231025102216.50480-2-aakarsh.jain@samsung.com>
        <948af111-e7a1-4757-a784-b4256657abd6@linaro.org>
        <000001da0810$c2b17680$48146380$@samsung.com>
        <630d58e0-589e-4411-905a-2514048e6ec4@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aakarsh

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Wednesday, November 1, 2023 1:54 PM
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> krzysztof.kozlowski+dt=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; conor+dt=40kernel.org; linux-samsung-
> soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com; linux-
> fsd=40tesla.com
> Subject: Re: =5BPatch v4 01/11=5D dt-bindings: media: s5p-mfc: Add mfcv12
> variant
>=20
> On 26/10/2023 15:31, Aakarsh Jain wrote:
> > Hello Krzysztof
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> >> Sent: 25 October 2023 18:30
> >> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> >> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> >> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> >> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> >> krzysztof.kozlowski+dt=40linaro.org; dillon.minfei=40gmail.com;
> >> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> >> robh+dt=40kernel.org; conor+dt=40kernel.org; linux-samsung-
> >> soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com;
> >> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> >> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com; linux-
> >> fsd=40tesla.com
> >> Subject: Re: =5BPatch v4 01/11=5D dt-bindings: media: s5p-mfc: Add mfc=
v12
> >> variant
> >>
> >> On 25/10/2023 12:22, Aakarsh Jain wrote:
> >>> Add Tesla FSD MFC(MFC v12) compatible.
> >>>
> >>> Cc: linux-fsd=40tesla.com
> >>> Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> >>> ---
> >>
> >> No changelog and your cover letter does not explain what happened
> here.
> >> Specifically, why did you decide to ignore received tag.
> >>
> > Last patch series we had two different patches for schema which was one
> for adding MFCv12 compatible string and other for adding its HW propertie=
s.
> > In one of the patches you gave reviewed-by tag. Since mfc dt_schema got
> merged already, and this is relatively  new patch so thought of getting
> reviewed again.
> >
> > Link to those patches:
> > https://patchwork.kernel.org/project/linux-
> media/patch/20221011122516.32135-2-aakarsh.jain=40samsung.com/
> > https://patchwork.kernel.org/project/linux-
> media/patch/20221011122516.32135-3-aakarsh.jain=40samsung.com/
> >
> > if you are ok, I will add your reviewed-by in next patch series.
>=20
> It is okay to drop Reviewed-by tag, but this should be explicitly mention=
ed in
> the changelog with a reason.
>=20
> >
> >>>  .../bindings/media/samsung,s5p-mfc.yaml          =7C 16
> ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
> >> mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
> >> mfc.yaml
> >>> index 084b44582a43..c30eb309f670 100644
> >>> --- a/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> >>> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> >>> =40=40 -24,6 +24,7 =40=40 properties:
> >>>            - samsung,mfc-v7                =23 Exynos5420
> >>>            - samsung,mfc-v8                =23 Exynos5800
> >>>            - samsung,mfc-v10               =23 Exynos7880
> >>> +          - tesla,fsd-mfc                 =23 Tesla FSD
> >>>        - items:
> >>>            - enum:
> >>>                - samsung,exynos3250-mfc    =23 Exynos3250
> >>> =40=40 -165,6 +166,21 =40=40 allOf:
> >>>            minItems: 1
> >>>            maxItems: 2
> >>>
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - tesla,fsd-mfc
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          maxItems: 1
> >>> +        clock-names:
> >>> +          items:
> >>> +            - const: mfc
> >>> +        iommus: false
> >>
> >> That's odd. How so? MFC v12 does not support IOMMU?
> >>
> > MFC v12 do support IOMMU. But currently it is not enabled in SW (has
> dependencies on some of the floating dma-mapping patches) and not tested
> on upstream kernel.
>=20
> Bindings describe hardware, not software.
>=20
> > Current patch sets intend to add support for MFCv12 using reserve
> memory and later patches related to enable iommu will be posted (after
> resolving the dependencies). So I marked iommu property as false.
> > Now what is your suggestion here? Should I keep iommu as false or add
> memory-region as below?
>=20
> I expect complete picture of the hardware, not something limited to curre=
nt
> driver, so for sure iommus must be there.
>=20
As Krzysztof mentioned, DT binding should explain all the hardware features=
 supported by SoC / IPs.=20
Incase a feature is not enabled for some reason, that need to be handled in=
 the dts file.

> Please wrap your emails according to mailing lists rules.
>=20
> Best regards,
> Krzysztof


