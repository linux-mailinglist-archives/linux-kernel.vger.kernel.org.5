Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F427F2DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKUMy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjKUMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:54:14 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3312D63
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:54:03 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231121125401euoutp01fe1df873a8c50077d425599819ffc0e9~ZpIiftnJs2639426394euoutp018
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:54:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231121125401euoutp01fe1df873a8c50077d425599819ffc0e9~ZpIiftnJs2639426394euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700571241;
        bh=/RR37xrrSNj8iFkQHAHyLk3LkJuohJb8fMlvgFB2uZo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=SjKujYeaNAz4/scTi1Jge5JP8XT21rc7BdI1CNCKox4+kXHvnmVumfJcAWzT+w7MD
         UxsGu/HIS3ubV6pby7Uw8i0lykeDtWGGxQYMFYwbNv2BdFqmZEkPFkQx+NIhBcc7X8
         D+aiZtA3EfytzWts6X/G5hzdflkvUsYSeTuKL8Hk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231121125400eucas1p1dd5586b9b196195765e9e3ba8997e390~ZpIiEjmvR3153731537eucas1p1J;
        Tue, 21 Nov 2023 12:54:00 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-be-655ca8684175
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.4E.09552.868AC556; Tue, 21
        Nov 2023 12:54:00 +0000 (GMT)
Mime-Version: 1.0
Subject: Re: [PATCH v5 8/9] thermal: exynos: use BIT wherever possible
Reply-To: m.majewski2@samsung.com
Sender: Mateusz Majewski <m.majewski2@samsung.com>
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <96565d08-8d6b-4a37-8a83-90bdd53ba89a@arm.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231121125400eucms1p40c19eedff56881e1a1a9f1560ac9a2d9@eucms1p4>
Date:   Tue, 21 Nov 2023 13:54:00 +0100
X-CMS-MailID: 20231121125400eucms1p40c19eedff56881e1a1a9f1560ac9a2d9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87oZK2JSDbZPkbN4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYLm1rYLdYe
        uctuMffLVGaLJw/72Bz4PdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9Pi8
        SS6AI4rLJiU1J7MstUjfLoErY+ecuawFp4Qrzs1fz9jA+F2oi5GTQ0LAROLwtblMXYxcHEIC
        Kxglun9NYu1i5ODgFRCU+LtDGKRGWMBNYmHLMnYQW0hAUaJz+xs2iLiRxKEXu8BsNgEDiQdv
        IGpEBFQlrl24ywIyk1lgD6vEhW//mCGW8UrMaH/KAmFLS2xfvpURxOYUsJZ4tHI/O0RcVOLm
        6rdw9vtj8xkhbBGJ1ntnoeYISjz4uRsqLiNxcsEyKLtY4uXaS1A1FRLHl0yHmmMusWnuGlYQ
        m1fAV+L8/nnMID+yAB06f0EpiCkh4CJx8m0SSAWzgLbEsoWvwSqYBTQl1u/ShxjiKDHp+Akm
        CFtAYs2JOVCLJCS2tjxhhWjlk5i0bTrcszvmPYGqV5U4vmcSM8zjT1puM01gVJqFCOdZSBbP
        Qli8gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmAaO/3v+NcdjCtefdQ7xMjEwXiI
        UYKDWUmEdwt7TKoQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMH
        p1QDU/7b3Cgf8YipzI67RP6V+UkoPbxiGPGxXlqyKyyxrpbluuKjsE3fL6et4necr+fQyGLg
        oTuFtXH30Vut2//v/z7H73AE9+4fV9PqfBdmzFy3Y/pCtt6jsusrs+STvj698s7k3LT4nkm7
        Pfti/rjYXJ3bslOqr+i1r//K7G/GvCuvpuzSUGPdsmEeexnz6ao6br6J2wRf7b1rmzNvSuXc
        r5sOmfSUWD4UOx5zWnBKSGW//6elHxO9/35YmR1ywtjFJy9076W5TlekBYsm9e6slNhvLv/l
        fvEf2W/2lwuWWZnflKjbdPz3YWvu4r+BD9ZpSq1fESf7yMT1y7S6r6vOnnv1NodBo+StfbyO
        /5zL6kosxRmJhlrMRcWJAO2MdeLSAwAA
X-CMS-RootMailID: 20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a
References: <96565d08-8d6b-4a37-8a83-90bdd53ba89a@arm.com>
        <20231120145049.310509-1-m.majewski2@samsung.com>
        <20231120145049.310509-9-m.majewski2@samsung.com>
        <CGME20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a@eucms1p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > =40=40 -590,15 +590,15 =40=40 static void exynos5433_tmu_control(struct=
 platform_device *pdev, bool on)
> >=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0continue;=0D=0A>=20>=C2=A0=20=C2=A0=0D=0A>=20>=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0interrupt_en=20=7C=3D=0D=0A>=20>=20-=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20(1=20<<=20(E=
XYNOS7_TMU_INTEN_RISE0_SHIFT=20+=20i));=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20BIT(EXYNOS7_TMU_INTEN_RISE0=
_SHIFT=20+=20i);=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=C2=A0=20=C2=A0=0D=0A>=
=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0interrupt_en=20=7C=3D=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0interrupt_en=20<<=20EXYNOS_TMU_INTEN_FALL0_SHIFT;=
=0D=0A>=20>=C2=A0=20=C2=A0=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20con=20=7C=3D=20(1=20<<=20EXYNOS_TMU_=
CORE_EN_SHIFT);=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20con=20=7C=3D=20BIT(EXYNOS_TMU_CORE_EN_SHIFT);=0D=
=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=0D=0A=
>=0D=0A>=20Minor=20issue:=20the=20if-else=20segment=20here.=20When=20the=20=
'if'=20has=20the=0D=0A>=20brackets,=20then=20the=20'else'=20should=20have=
=20them=20as=20well,=0D=0A>=20even=20if=20there=20is=20only=20a=20single=20=
line=20under=20'else'.=0D=0A>=20It's=20not=20strictly=20to=20this=20patch,=
=20but=20you=20can=20address=20that=0D=0A>=20later=20somewhere=20(just=20sa=
w=20it=20here).=0D=0A=0D=0AFor=20what=20it's=20worth,=20this=20issue=20disa=
ppears=20after=20the=20final=20patch=20of=20this=20series,=0D=0Abecause=20t=
he=20other=20branch=20reduces=20to=20a=20single=20line=20too=20(all=20the=
=20interrupt_en=0D=0Aoperations=20are=20done=20in=20the=20tmu_set_*_temp=20=
functions).=0D=0A=0D=0AThank=20you=20:)=0D=0AMateusz=0D=0A
