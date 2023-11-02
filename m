Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E77DF055
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346874AbjKBKfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbjKBKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:35:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F3131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:35:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231102103508euoutp02de8f5d30775b0dd43b92c8ac732f7356~Tx_3LPY4Q2454724547euoutp02g
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:35:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231102103508euoutp02de8f5d30775b0dd43b92c8ac732f7356~Tx_3LPY4Q2454724547euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698921308;
        bh=Jq2CkGwzkZthS/INfqDfza5GmIinX06fg7ozai2WyPg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uCtUEatTc7cb1m5tRmMz81U6kR31b4LAz/jJ5jrSuIJZ8VU8jFBo22cPiomAI4otF
         N0Z3o40NkikNftfudJqFVOClzC6k1A+UEVK2Iz1eGYdocFMhfvmAg9MTnON4IK+xwG
         /fy+P64f2gzgdyCJsdfgcmwrHwenYpKPsDulw7Yo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231102103508eucas1p1d660b46f2f487811bb5162191beb3b4f~Tx_20XxLE2095820958eucas1p12;
        Thu,  2 Nov 2023 10:35:08 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-4d-65437b5c055d
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DC.8F.11320.C5B73456; Thu,  2
        Nov 2023 10:35:08 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4 8/8] thermal: exynos: use set_trips
Reply-To: m.majewski2@samsung.com
Sender: Mateusz Majewski <m.majewski2@samsung.com>
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <2c4b6c1b-b9e7-42b2-8f7b-446ebe9d15ac@arm.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231102103507eucms1p4aea91982ebcc4a9a6314d9c4e03050fc@eucms1p4>
Date:   Thu, 02 Nov 2023 11:35:07 +0100
X-CMS-MailID: 20231102103507eucms1p4aea91982ebcc4a9a6314d9c4e03050fc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133100eucas1p14e6de58e52560d165bdb8b809e406278
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7ox1c6pBov/Mls8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFmuP
        3GW3mPtlKrPFk4d9bA78HmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxenze
        JBfAEcVlk5Kak1mWWqRvl8CVcfzEfPaCN24Vd7f9YGpg/OXSxcjJISFgIvH0cztTFyMXh5DA
        CkaJBb2/GbsYOTh4BQQl/u4QBjGFBewkLnxLASkXElCU6Nz+hg3EFhYwkjj0YheYzSZgIPHg
        zTJ2EFtEQFXi2oW7LCAjmQX2sEqcu7KOCWIXr8SM9qcsELa0xPblWxlBbE4Ba4lLf26yQ8RF
        JW6ufgtnvz82nxHCFpFovXeWGcIWlHjwczdUXEbi5IJlUHaxxMu1l6BqKiSOL5kONcdcYtPc
        NawgNq+Ar8Sc41PBbBagQxf0XoWqcZF40vIKrJdZQFti2cLXzCC/MwtoSqzfpQ9R4iixYVI/
        K4QtILHmxByoVRISW1uesEK08klM2jadGebdHfOeQL2uKnF8zyRmmNeftNxmmsCoNAsR0LOQ
        LJ6FsHgBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwER2+t/xLzsYl7/6qHeIkYmD
        8RCjBAezkgjvYVOHVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZ
        Jg5OqQamfjmpXbIP3tx/c/pf6vX1/4XXP09qEwr80ffPS7486SLzd/ucHtumSQUNk63TIx0k
        mNI+Lv7gsFRvT9AXsayzT27rXxY52jLPMP5f1Gq2EK7cpfUpjfsen5zzfgqvTuH5hyu2XQr0
        3HWn8NdZ5fiNzVkvDbn3nWpsMoy85zfNa0OOaMfRbyuWCra2rt1avuHHmw5RJh7v21fCn8qs
        c7t4uvLHTpu6Kw/eNEXqTw+R87qz6tOGijU6ci2TJklfOzZz/vaWp8eqFl/+6l+++YjGgS/2
        X3d4367TWNV3f13siWdOl9aFOUu6hF/ce5z5OEuC42y9yWnVBbfKrJ3LRFKEeNbfLsszLHrN
        rB2dvemirhJLcUaioRZzUXEiANz728/TAwAA
X-CMS-RootMailID: 20231025133100eucas1p14e6de58e52560d165bdb8b809e406278
References: <2c4b6c1b-b9e7-42b2-8f7b-446ebe9d15ac@arm.com>
        <20231025133027.524152-1-m.majewski2@samsung.com>
        <20231025133027.524152-9-m.majewski2@samsung.com>
        <CGME20231025133100eucas1p14e6de58e52560d165bdb8b809e406278@eucms1p4>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > +=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20th=20&=3D=20=7E(0xff=20<<=200);=0D=
=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20th=20=7C=3D=20temp_to_code(=
data,=20temp)=20<<=200;=0D=0A>=C2=A0=0D=0A>=20This=202-line=20pattern=20rep=
eats=20a=20few=20times.=20It=20looks=20like=20a=20nice=20cadidate=0D=0A>=20=
for=20an=20inline=20function=20which=20can=20abstract=20that.=20Something=
=20like:=0D=0A>=C2=A0=0D=0A>=20val=20=3D=20update_temp_value(data,=20temp,=
=20threshold,=20LOW_TEMP_SHIFT)=0D=0A>=C2=A0=0D=0A>=20Assisted=20with=20the=
=20macros=20=7BLOW=7CHIGH=7CCRIT=7D_TEMP_SHIFT,=20the=20code=0D=0A>=20would=
=20look=20less=20convoluted=20IMO.=0D=0A>=20(The=20old=20code=20with=20the=
=20multiplication=20for=20the=20shift=20value=20wasn't=0D=0A>=20cleaner=20n=
or=20faster).=0D=0A=0D=0AWhat=20would=20you=20think=20about=20something=20l=
ike=20this?=0D=0A=0D=0Astatic=20void=20exynos_tmu_update_temp(struct=20exyn=
os_tmu_data=20*data,=20int=20reg_off,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20bit_off,=20u8=
=20temp)=0D=0A=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20u32=20th;=0D=0A=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20th=20=3D=20readl(data->base=20+=
=20reg_off);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20th=20&=3D=20=7E(0xff=
=20<<=20bit_off);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20th=20=7C=3D=20te=
mp_to_code(data,=20temp)=20<<=20bit_off;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20writel(th,=20data->base=20+=20reg_off);=0D=0A=7D=0D=0A=0D=0AAnd=20=
then,=20it=20would=20be=20used=20like=20this:=0D=0A=0D=0Astatic=20void=20ex=
ynos4412_tmu_set_crit_temp(struct=20exynos_tmu_data=20*data,=20u8=20temp)=
=0D=0A=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20exynos_tmu_update_temp(d=
ata,=20EXYNOS_THD_TEMP_RISE,=2024,=20temp);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20exynos_tmu_update_bit(data,=20EXYNOS_TMU_REG_CONTROL,=0D=0A=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20EXYNOS_TMU_THERM_T=
RIP_EN_SHIFT,=20true);=0D=0A=7D=0D=0A=0D=0AGranted=20it's=20not=20as=20clea=
r=20as=20if=20we=20had=20some=20macro=20like=20CRIT_TEMP_SHIFT,=20but=0D=0A=
we=20would=20need=20more=20than=20one=20variant=20anyway,=20as=20Exynos=205=
433=20uses=20different=0D=0Avalues=20of=20reg_off,=20and=20the=20new=20func=
tion=20looks=20short=20and=20inviting=20IMHO.=0D=0A=0D=0A>=20>=20-static=20=
void=20exynos7_tmu_set_trip_temp(struct=20exynos_tmu_data=20*data,=0D=0A>=
=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20int=20trip,=20u8=20temp)=0D=0A>=20>=20+static=
=20void=20exynos7_tmu_update_temp(struct=20exynos_tmu_data=20*data,=20u8=20=
temp,=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20idx,=20bool=20rise)=0D=0A>=20>=C2=A0=
=20=C2=A0=7B=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0u=
nsigned=20int=20reg_off,=20bit_off;=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0u32=20th;=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20void=20__iomem=20*reg;=0D=0A>=20>=C2=A0=20=C2=A0=0D=0A>=20>=20-=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20reg_off=20=3D=20((7=20-=20trip)=20/=202)=
=20*=204;=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bit_off=20=3D=
=20((8=20-=20trip)=20%=202);=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20reg_off=20=3D=20((7=20-=20idx)=20/=202)=20*=204;=0D=0A>=C2=A0=0D=0A>=
=20Why=20can't=20we=20just=20have=20a=20set=20of=20defined=20register=20mac=
ros=20and=20pick=20one=0D=0A>=20in=20some=20small=20function?=0D=0A>=20A=20=
lot=20of=20operations=20here,=20also=20some=20assumption.=0D=0A>=C2=A0=0D=
=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bit_off=20=3D=20((8=20-=20i=
dx)=20%=202);=0D=0A>=C2=A0=0D=0A>=20So=20this=20can=20only=20be=200=20or=20=
1=20and=20than=20it's=20used=20for=20the=20shift=0D=0A>=20multiplication.=
=20Also=20I=20don't=20know=20the=20history=20of=20older=20code=20and=0D=0A>=
=20if=20it=20was=20missed=20after=20some=20cleaning,=20but=20'idx=20%=202'=
=20gives=0D=0A>=20equal=20values=20but=20w/o=20subtraction.=0D=0A>=C2=A0=0D=
=0A>=20BTW,=20the=20code=20assumes=20the=20'idx'=20values=20are=20under=20c=
ontrol=20somewhere=20else.=0D=0A>=20Is=20that=20because=20the=20DT=20make=
=20sure=20in=20the=20schema=20that=20the=20range=20cannot=20be=0D=0A>=20too=
=20big?=0D=0A>=20What=20are=20the=20possible=20values=20for=20'idx'?=0D=0A=
=0D=0AIn=20the=20old=20code,=20the=20values=20of=20trip=20(which=20is=20the=
=20same=20thing,=20I=20will=0D=0Achange=20the=20name=20back=20from=20idx)=
=20were=20limited=20by=20the=20value=20of=20data->ntrip,=0D=0Awhich=20was=
=20always=208=20(value=20is=20per=20SoC).=20In=20the=20new=20code,=20there=
=20are=20only=20three=0D=0Avariants:=0D=0A=0D=0Astatic=20void=20exynos7_tmu=
_set_low_temp(struct=20exynos_tmu_data=20*data,=20u8=20temp)=0D=0A=7B=0D=0A=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20exynos7_tmu_update_temp(data,=20temp,=
=200,=20false);=0D=0A=7D=0D=0A=0D=0Astatic=20void=20exynos7_tmu_set_high_te=
mp(struct=20exynos_tmu_data=20*data,=20u8=20temp)=0D=0A=7B=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20exynos7_tmu_update_temp(data,=20temp,=201,=20tru=
e);=0D=0A=7D=0D=0A=0D=0Astatic=20void=20exynos7_tmu_set_crit_temp(struct=20=
exynos_tmu_data=20*data,=20u8=20temp)=0D=0A=7B=0D=0A=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20/*=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*=20Like=
=20Exynos=204210,=20Exynos=207=20does=20not=20seem=20to=20support=20critica=
l=20temperature=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*=20handling=
=20in=20hardware.=20Again,=20we=20still=20set=20a=20separate=20interrupt=20=
for=20it.=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*/=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20exynos7_tmu_update_temp(data,=20temp,=207,=20tru=
e);=0D=0A=7D=0D=0A=0D=0ATo=20be=20fair,=20considering=20the=20values=20are=
=20constant=20like=20this,=20I=20should=20probably=0D=0Ajust=20do=20the=20c=
alculations=20myself=20and=20then=20in=20code=20just=20call=20exynos_tmu_up=
date_temp=0D=0A(from=20above)=20and=20exynos_tmu_update_bit,=20like=20on=20=
all=20other=20SoCs.=20I=20guess=20I=20were=0D=0Aa=20bit=20too=20scared=20to=
=20touch=20Exynos=207=20code...=0D=0A=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20if=20(on)=20=7B=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20for=20(i=20=3D=200;=20i=20<=20dat=
a->ntrip;=20i++)=20=7B=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(thermal_zone_get_trip(tz,=20i,=20&trip))=0D=0A>=20>=20-=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20continue;=0D=0A>=20>=
=20-=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20interrupt_en=20=7C=3D=
=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20(1=20<<=20(EXYNOS_TMU_INTEN_RISE0_SHIFT=20+=20i=20*=204));=0D=0A>=
=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=7D=0D=0A>=20>=20-=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(data->soc=20=21=3D=20SOC_ARCH_EXY=
NOS4210)=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20interrupt_en=20=7C=
=3D=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20interrupt_en=20<<=20EXYNOS_TMU_INTEN_FALL0_SHIFT;=0D=0A>=20>=20=
-=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(on)=0D=0A>=20>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0con=20=7C=3D=20(1=20<<=20EXYNOS_TMU_CORE_EN_SHIFT);=0D=0A>=20>=20-=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=20else=20=7B=0D=0A>=20>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20else=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0con=20&=3D=20=7E(1=
=20<<=20EXYNOS_TMU_CORE_EN_SHIFT);=0D=0A>=C2=A0=0D=0A>=20Please=20also=20co=
nsider=20the=20BIT()=20helper=20here=20and=20above...=0D=0A=0D=0AWill=20do,=
=20but=20should=20I=20do=20this=20in=20a=20separate=20patch=20in=20these=20=
cases?=20I=20don't=20touch=0D=0Athe=20con=20lines=20otherwise,=20and=20this=
=20patch=20is=20already=20humongous.=0D=0A=0D=0AThank=20you=20:)=0D=0AMateu=
sz
