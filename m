Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F07D840B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbjJZN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZN5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:57:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB48196
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:57:32 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231026135728epoutp0211fe6bb6e1924db035d18a14cc8bdd63~RrOhfny2q1356113561epoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231026135728epoutp0211fe6bb6e1924db035d18a14cc8bdd63~RrOhfny2q1356113561epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698328648;
        bh=MdmirowD58CoPKSMUS/Cs8WZUs4Y/X2+s8TFqx+fLBk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OkblbULPy8GLTSdd49k6HALI8MkL4wogVA9psz7nQTCTCOJpGUOR5H8eQUtEnRkJY
         zAi29Uo+EWLz+ZCQj/+NYAUN0vqnQ9sRm4TL2SF+fPTS9HDgmB7pwOrW43/6Avx/BC
         yeXS4y3YxqICL0+2De7Q6iE0qKAS9V95Nnl4f83M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231026135727epcas5p2a70dd974423bbd0c8bb4cf1510c17281~RrOgmxWZ72108821088epcas5p2u;
        Thu, 26 Oct 2023 13:57:27 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SGS6F6HGTz4x9Pt; Thu, 26 Oct
        2023 13:57:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.7F.09672.5407A356; Thu, 26 Oct 2023 22:57:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231026133144epcas5p2d6d3f2ab7b6a127966a600667db20661~Rq4DZUd5E2488324883epcas5p2j;
        Thu, 26 Oct 2023 13:31:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231026133144epsmtrp1e1494dd6e89ff77410bb882a8b738afd~Rq4DXzM520340903409epsmtrp17;
        Thu, 26 Oct 2023 13:31:44 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-80-653a704517d7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.C6.07368.04A6A356; Thu, 26 Oct 2023 22:31:44 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231026133141epsmtip2433727e4bcf6c2c1ebd2d8999758ecc4~Rq4AV4oFA0888008880epsmtip2b;
        Thu, 26 Oct 2023 13:31:40 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <krzysztof.kozlowski+dt@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <ajaykumar.rs@samsung.com>, <linux-fsd@tesla.com>
In-Reply-To: <948af111-e7a1-4757-a784-b4256657abd6@linaro.org>
Subject: RE: [Patch v4 01/11] dt-bindings: media: s5p-mfc: Add mfcv12
 variant
Date:   Thu, 26 Oct 2023 19:01:31 +0530
Message-ID: <000001da0810$c2b17680$48146380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLm4twfZx4yvmLB3iF6RxvUJv+HzQK0rOY9AbqXOzoB/yYnBa4Oc9rw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTH895r+wqh7PEr3AFu3Vvm+BEKnW13QXHOOfYy3IpbFN2MXYU3
        YJT2rQV0ZBOjwYgijDg2rICjIDgov2kFBCwFRkaiSHAwDL9lU2SEAboUkGUtLRv/fc6533O/
        59ybw8XcL+E+3ERlCq1WyhUkx5ll7Ap4PfhdJpwOzesKgqaFThacLDZyYKnlEQonSpdZ0Nxo
        wKG+/S4KK3pNbHit+y4b3uycZsERUwsKB66MsWDO4ykMts9ZdQ0Ph9hw6kkMHGwt5MDsOgMb
        FvR3oLC6ewyH14cHUFje8ByFOsNTHGa2d+N7vCl9sR6hhsuWMKpFO4ZTpW2zKNVQmcWhRofa
        OFRjWQaV2bPKonKaKhHqnzNFOLXc8BLV92wZj3b5JGlXAi2Po9V8WhmriktUxkeQUR/L3pGJ
        JaHCYGEYfJPkK+XJdAS5b390cGSiwjo3yU+TK1KtqWi5RkOG7N6lVqWm0PwElSYlgqSZOAUj
        YgQaebImVRkvUNIp4cLQ0DfEVuFnSQlVd0bYzG3+yZ9aavHTiAlcQJy4gBCBqsY1/ALizHUn
        biGgytzPtgdLCBgvyUHtwd8IKMwfxDZLHjRZOPaDdgTM3Zx1qB4h4OnVEcSm4hAhYKIve+Mu
        T6IHAZNNU5gtwAgLBpbrhzdUTsRu0L5isNpzuR6EFPxR6m9DFvEa0K/H2BQ8IgzU1few7ewG
        frkyw7IxRgSB8pI5R0d8sPJ7+YbGk4gEhi4jx67xBj0r2Ru2gLjlBMymP1F7wT4wXbHItrMH
        eNLbhNvZB8zmnnNwLHiom3UYKEBt23csO78FTPcLWbY+MSIA1LaG2NPbQH5fDWr3dQWX1mYc
        VjzQXLzJ20HhqMVh6we6qq4j3yKkdsto2i2jabeMoP3f7UeEVYm8SDOa5HhaI2Z2KOkT//14
        rCq5AdnYi8CoZmR68i+BGUG5iBkBXIz05B3ZD2l3Xpz8q3RarZKpUxW0xoyIrc+dh/l4xaqs
        i6VMkQlFYaEiiUQiCtshEZLevLnMojh3Il6eQifRNEOrN+tQrpPPafTVq8ya+Fffj8heRjoj
        HVMIjvqh87+1Bh00es1Xj+ffOee/cnj2a5nvUgs67+12aDF3feTae6eqpaKFFxpl2+6dutDv
        hEYeG/resDPrvLn+i6PluZEnbleIWgcP63Uek59Hvdw8sV6yuhP4fsmra37uovvmmGyxyTWd
        WT3bv3cRWMLPLCWmKS7KpHvomF5/8aFAAn1lIvt4kTGtruqHIcF62cm9wwfAlLQjseZAxg3f
        Ii9mUtttPNKPB+LPBv2dx1bvObcUmPQf8Mrel/QlZNVEfjr/4cGzD45DJGwgaXz7sovuxtsF
        JkHzY13e4nlLx8LlBUtdxs+dl+/7uaaPuge4tZIsTYJcGIipNfJ/AZAMzdqgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLcRzHfZ/n2fM8i+6eWnf7NiV25zhURsfXr3Tu5LkTwrnJnR9TjzSt
        H5shDnEWknDXHxn6IYasZLUkTbNW6BKhIiZJRiFMURTacP33/nxe7/f7Pn98aNyzlxDRMXFb
        OWWcLFZMuhGlVWI//xD5bG5qT8ZIZO6+RaCXWaUkyvtux1BrnoNAlmIjhfSmegxduG3moWxr
        PQ9du/WKQE/N1zHUcNJGoPS3bTgydf3xGdqbeKitU4oelZ8mUVqRkYcy79/EUIHVRqHzzQ0Y
        0hl+Yuis8SuFNCYrFSJk9Vl6wDaf+4Kz17U2is2reIexhvzDJPu8qYJki8/tZTXV/QSbXpIP
        2MH9ZyjWYRjD1vY4qPBRa9zmRnGxMds4ZWDwBrfNR7JPkAmf/HbY68xYMugSpgI+DZkg2FLy
        nUwFbrQncwPAZ4/TSRfwgb9SaiiXFsBLg3bKZeoAsOGF1QlIJhC21qbxhoAXcxfAY3UHnAPO
        pBKwuLD2b68DwMZLz/ChCJ8JhqY+ozMuYJbAH49z/iRommDGQ/2AdGjtzsyCRVereS7tAe+e
        fE0MaZyZDDuedvzXutwu3HXeWNjXoXP6vZhQaKwqJV0eIazuS8OPA4F2WJV2WJV2WJV2WCQH
        EPnAm0tQKaIVkZIESRy3PUAlU6jUcdEBkfEKA3C+xqSJZeBF9mCABWA0sABI42Iv94gwxHm6
        R8mSdnLK+PVKdSynsoDRNCEWuksyT0V5MtGyrdwWjkvglP8oRvNFyZhV36imRrSpN2UclcnP
        6BYzD0KmZeyct2Jtz+opy27YfaZDH2miR4U4ieetx2cbPu7feOhDoofiWMtuXFqTuXzc2D2L
        xM+b/SX5hYI624X5ofzIkfzy1MAUTRfZUjkhYs40UdC9yO7FMVdWNHmRlZ8fWfx2FXz9peu9
        KHeML+l/T8pjgquSW0V3ZMAfX7LUtCr052pfaXtv3TfzZd/OfeJPiWFlveEHdxSH5eo0R2a+
        YrYXZdX3r5x7/0lT0uebiQs6i1LCF4p8y3Tv9u7yL1BeqwzN8Z5hT+seUJ/4wH9YHqTyzrXa
        Q3J/tL3ZKNBo1+ltLQOFNcJV1XLw9n1788w5EWJCtVkmmYQrVbLf9t35kYkDAAA=
X-CMS-MailID: 20231026133144epcas5p2d6d3f2ab7b6a127966a600667db20661
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d@epcas5p1.samsung.com>
        <20231025102216.50480-2-aakarsh.jain@samsung.com>
        <948af111-e7a1-4757-a784-b4256657abd6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: 25 October 2023 18:30
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
> On 25/10/2023 12:22, Aakarsh Jain wrote:
> > Add Tesla FSD MFC(MFC v12) compatible.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
>=20
> No changelog and your cover letter does not explain what happened here.
> Specifically, why did you decide to ignore received tag.
>=20
Last patch series we had two different patches for schema which was one for=
 adding MFCv12 compatible string and other for adding its HW properties.
In one of the patches you gave reviewed-by tag. Since mfc dt_schema got mer=
ged already, and this is relatively  new patch so thought of getting review=
ed again.

Link to those patches:
https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135=
-2-aakarsh.jain=40samsung.com/
https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135=
-3-aakarsh.jain=40samsung.com/   =20

if you are ok, I will add your reviewed-by in next patch series.

> >  .../bindings/media/samsung,s5p-mfc.yaml          =7C 16 ++++++++++++++=
++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> > index 084b44582a43..c30eb309f670 100644
> > --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > =40=40 -24,6 +24,7 =40=40 properties:
> >            - samsung,mfc-v7                =23 Exynos5420
> >            - samsung,mfc-v8                =23 Exynos5800
> >            - samsung,mfc-v10               =23 Exynos7880
> > +          - tesla,fsd-mfc                 =23 Tesla FSD
> >        - items:
> >            - enum:
> >                - samsung,exynos3250-mfc    =23 Exynos3250
> > =40=40 -165,6 +166,21 =40=40 allOf:
> >            minItems: 1
> >            maxItems: 2
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - tesla,fsd-mfc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names:
> > +          items:
> > +            - const: mfc
> > +        iommus: false
>=20
> That's odd. How so? MFC v12 does not support IOMMU?
>=20
MFC v12 do support IOMMU. But currently it is not enabled in SW (has depend=
encies on some of the floating dma-mapping patches) and not tested on upstr=
eam kernel. Current patch sets intend to add support for MFCv12 using reser=
ve memory and later patches related to enable iommu will be posted (after r=
esolving the dependencies). So I marked iommu property as false.=20
Now what is your suggestion here? Should I keep iommu as false or add memor=
y-region as below?
Ex-
  - if:
      properties:
        compatible:
          contains:
            enum:
              - tesla,fsd-mfc
    then:
      properties:
        clocks:
          maxItems: 1
        clock-names:
          items:
            - const: mfc
        memory-region:
          maxItems: 1


> Best regards,
> Krzysztof

Thanks for review.

