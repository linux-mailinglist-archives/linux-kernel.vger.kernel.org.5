Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B427D7F0B31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKTD7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:59:24 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878ABB5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:59:17 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231120035913epoutp01cbaf0b349bde0d4710ba7b49bb9908b3~ZOMUqQlO52204822048epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:59:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231120035913epoutp01cbaf0b349bde0d4710ba7b49bb9908b3~ZOMUqQlO52204822048epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700452753;
        bh=e/r4T6+J+NztW1lw5Z7d9TAjNgjFzE5kWGNT4prYIFE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hQWAk5tHI6xQbgbfjaJ8R32i/pw1Xgvl+uMLukTyGWAfs/ftjyeyT5GRMjPd3fo0u
         E+W9AhsPU8BaK7LdkRP9ZEUrFusO63VBKfJ7//HZXqcUKQxhoOV+v2wqsveY48y7fI
         TrR5iLmsuyMHxInoFi0PS8GYVQjpS/FBfzl9RBKs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231120035913epcas5p281cb1d5894ed77513f46640e701da810~ZOMUU_bhe1718617186epcas5p2e;
        Mon, 20 Nov 2023 03:59:13 +0000 (GMT)
X-AuditID: b6c32a49-75a53a80000025a2-18-655ad991d706
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.6E.09634.199DA556; Mon, 20 Nov 2023 12:59:13 +0900 (KST)
Mime-Version: 1.0
Subject: Re[3]: [PATCH] input: gpio-keys - optimize wakeup sequence.
Reply-To: abhi1.singh@samsung.com
Sender: Abhishek Kumar Singh <abhi1.singh@samsung.com>
From:   Abhishek Kumar Singh <abhi1.singh@samsung.com>
To:     Abhishek Kumar Singh <abhi1.singh@samsung.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231107082901epcms5p80c830aecfe50bfb12b661defad701149@epcms5p8>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231120035913epcms5p4be3a2881d9c18362e534c1cc75dbc097@epcms5p4>
Date:   Mon, 20 Nov 2023 09:29:13 +0530
X-CMS-MailID: 20231120035913epcms5p4be3a2881d9c18362e534c1cc75dbc097
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmuu7Em1GpBvNfC1gsXPOX0eLwoheM
        Fjc/fWO1uLxrDpvF/z072C1O/NnE7MDmsXPWXXaPTas62Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoEr49kzj4I/ARWX2j4yNjC+9+ti5OSQEDCR2Ng7hbWLkYtDSGA3o8ShpctYuhg5OHgF
        BCX+7hAGqREWcJFYcmo7K4gtJKAosWhOBzNE3Exi8913jCDlbEBzVmznATFFBHIllq4qAZnI
        LHCFUaL56gUmiFW8EjPan7JA2NIS25dvZQSxOQX8JI5sbGOFiItK3Fz9lh3Gfn9sPiOELSLR
        eu8sM4QtKPHg525GmDnfD9xig7DrJU59n8ACslhCoIdRYt7cT1DLzCXO/OoBs3kFfCXa+maz
        gxzKIqAqcfhUAESJi8T5myvBbmAW0JZYtvA1M0gJs4CmxPpd+hBhPone30/gXtkxD8ZWldh/
        9h8zzDk7Jq2COt9D4t/To2yQkJ3OJHG5pYFlAqP8LETgzkKybRbCtgWMzKsYJVMLinPTU4tN
        CwzzUsv1ihNzi0vz0vWS83M3MYLThpbnDsa7Dz7oHWJk4mA8xCjBwawkwvtNKCJViDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/r1rkpQgLpiSWp2ampBalFMFkmDk6pBiZepudv5aY+e+a/KukX
        s6rHEpP6Z4zBNarPeLycj9hXq2f1vTn1u7DGubQnbXLUYmtNg8/We1seHcn4VOfY6vbbcq+m
        xa9ber7/dQRuGEs2zp5tEn3/bdgU2eCZ2cnz4xynLP5w60ubSs8dRp+j036o1tyZ+Wf5pW3T
        whqSpTISa6Z232h1UGeNe23LXz05NHxZ/p5zp5/PE8uw/G42IeuJ/JKgSDWJo9nxXL47v/BF
        3Xyv/nRlkHmj+ZkPkTOVLi/ttM0L3fSnauHMKxLHzazuLhDssX+8ZM+N4pZdXm/VJ7ysz7Jx
        vfSm6RQ32/w1udVRGlk9jzeUPnzA7fM2dK1cBUfa0+6uDY+bLs//MkWJpTgj0VCLuag4EQBc
        Pzh9igMAAA==
X-CMS-RootMailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
References: <20231107082901epcms5p80c830aecfe50bfb12b661defad701149@epcms5p8>
        <ZT2_XI-6D24gjbrO@google.com>
        <899376598.3134980.1698299600677@mail-kr5-0.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
        <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry,=C2=A0=0D=0A=0D=0AGreetings=21=21=0D=0A=0D=0ACould=20you=20plea=
se=20help=20to=20review=20and=20update=20on=20this?=0D=0A=0D=0A=0D=0AThanks=
=20and=20Regards,=0D=0AAbhishek=20Kumar=20Singh=0D=0ASr.=20Chief=20Engineer=
,=20=0D=0ASamsung=20Electronics,=20Noida-India=0D=0A=0D=0A=C2=A0=0D=0A-----=
----=C2=A0Original=20Message=C2=A0---------=0D=0ASender=C2=A0:=20Abhishek=
=20Kumar=20Singh=20<abhi1.singh=40samsung.com>System=20Power=20Part=20/SRI-=
Noida/Samsung=20Electronics=0D=0ADate=C2=A0=20=C2=A0:=202023-11-07=2013:59=
=20(GMT+5:30)=0D=0ATitle=C2=A0=20:=20Re=5B2=5D:=20=5BPATCH=5D=20input:=20gp=
io-keys=20-=20optimize=20wakeup=20sequence.=0D=0A=C2=A0=0D=0ADear=20Dmitry,=
=C2=A0=0D=0A=0D=0AGreetings=21=21=21=0D=0A=0D=0AThank=20you=20so=20much=20f=
or=20your=20response.=0D=0A=0D=0AI=20checked=20in=20detailed=20again=20and=
=20observed=20the=20below=20points,=20please=20help=20to=20review=C2=A0=0D=
=0Aand=20approve=20it.=0D=0A=0D=0A=0D=0A=0D=0AThere=20is=20ISR=20=22gpio_ke=
ys_gpio_isr=22=20which=20is=20called=20when=20the=20key=20state=20is=201=20=
i.e.=C2=A0=0D=0Akey=20pressed.=0D=0ATherefore=20modified=20code=20will=20no=
t=20impact=20on=20the=20existing=20driver=20code.=0D=0A=0D=0A//For=20key=20=
pressed=20event:=0D=0A<3>=5B=C2=A0=20549.180072=5D=20I=5B0:=C2=A0=20=C2=A0=
=20=C2=A0=20swapper/0:=C2=A0=20=C2=A0=200=5D=20gpio_keys_gpio_isr=0D=0A<3>=
=5B=C2=A0=20549.196126=5D=C2=A0=20=5B1:=C2=A0=20=C2=A0=20kworker/1:1:=C2=A0=
=20=C2=A078=5D=20gpio_keys_gpio_work_func=0D=0A<3>=5B=C2=A0=20549.196198=5D=
=C2=A0=20=5B1:=C2=A0=20=C2=A0=20kworker/1:1:=C2=A0=20=C2=A078=5D=20gpio-key=
s=20soc:gpio_keys:=20gpio_keys_gpio_report_event=20key=20=3D=20115,=20value=
=20=3D=201=0D=0A=0D=0A=0D=0A=0D=0APerformance:=0D=0A=0D=0AI=20have=20calcul=
ated=20the=20differece=20between=20entry=20&=20exit=20time=C2=A0=0D=0Awith=
=20modified=20and=20without=20modified=20code=20and=20observed=20that=C2=A0=
=0D=0A0.3ms=20extra=20computation=20time=20in=20current=20scenario=20in=20e=
ach=20entry/exit=20time.=0D=0A=0D=0ABecause=20below=20APIs=20will=20not=20b=
e=20called=20in=20every=20resume=20functions:=0D=0A=0D=0A1.=20static=20void=
=20gpio_keys_report_state(struct=20gpio_keys_drvdata=20*ddata)=0D=0A2.=20st=
atic=20void=20gpio_keys_gpio_report_event(struct=20gpio_button_data=20*bdat=
a)=0D=0A3.=20gpiod_get_value_cansleep(bdata->gpiod);=0D=0A4.=20input_event(=
input,=20type,=20*bdata->code,=20state);=0D=0A5.=20input_sync(input)=0D=0A=
=0D=0ASo=20we=20can=20save=200.3ms=20computation=20time,=20resume=20operati=
ons=20will=20faster=20and=20save=20battery=20as=20well.=0D=0A=0D=0A=0D=0A=
=0D=0AWith=20changes:=0D=0A=0D=0ALine=C2=A0=20=C2=A0311960:=2007-18=2016:50=
:09.359=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=
=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=
=20exit=202023-07-18=2011:20:37.573207725=20UTC=0D=0ALine=C2=A0=20=C2=A0312=
626:=2007-18=2016:50:42.123=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=
=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gp=
io_keys_report_state=20enrty=202023-07-18=2011:22:20.503579404=20UTC=0D=0AL=
ine=C2=A0=20=C2=A0312627:=2007-18=2016:50:42.123=C2=A0=20root=C2=A0=20=C2=
=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699=
_1:20972=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2011:22:20.5=
03656644=20UTC=0D=0ALine=C2=A0=20=C2=A0313301:=2007-18=2016:52:24.182=C2=A0=
=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=
=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20enrty=20202=
3-07-18=2011:22:33.865626325=20UTC=0D=0ALine=C2=A0=20=C2=A0313302:=2007-18=
=2016:52:24.182=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=
=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_repo=
rt_state=20exit=202023-07-18=2011:22:33.865724502=20UTC=0D=0ALine=C2=A0=20=
=C2=A0313572:=2007-18=2016:52:35.111=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=
=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:699_1:20972=5D=
=20PM:=20gpio_keys_report_state=20enrty=202023-07-18=2011:22:37.678468979=
=20UTC=0D=0ALine=C2=A0=20=C2=A0313573:=2007-18=2016:52:35.111=C2=A0=20root=
=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=
=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=
=2011:22:37.678566167=20UTC=0D=0ALine=C2=A0=20=C2=A0314209:=2007-18=2016:52=
:43.598=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=
=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gpio_keys_report_state=
=20enrty=202023-07-18=2011:23:05.925340634=20UTC=0D=0ALine=C2=A0=20=C2=A031=
4210:=2007-18=2016:52:43.598=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=
=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:699_1:20972=5D=20PM:=20gp=
io_keys_report_state=20exit=202023-07-18=2011:23:05.925439384=20UTC=0D=0A=
=0D=0A=0D=0AWithout=20changes:=0D=0A=0D=0ALine=C2=A0=20=C2=A0372095:=2007-1=
8=2016:10:24.250=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=
=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_repo=
rt_state=20exit=202023-07-18=2010:43:38.592548979=20UTC=0D=0ALine=C2=A0=20=
=C2=A0372344:=2007-18=2016:13:45.439=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=
=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=
=20PM:=20gpio_keys_report_state=20enrty=202023-07-18=2010:44:11.589164226=
=20UTC=0D=0ALine=C2=A0=20=C2=A0372346:=2007-18=2016:13:45.439=C2=A0=20root=
=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=
=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=20exit=202023-07-18=
=2010:44:11.589514955=20UTC=0D=0ALine=C2=A0=20=C2=A0372573:=2007-18=2016:14=
:13.414=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=
=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=
=20enrty=202023-07-18=2010:44:22.606227138=20UTC=0D=0ALine=C2=A0=20=C2=A037=
2575:=2007-18=2016:14:13.414=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=
=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gp=
io_keys_report_state=20exit=202023-07-18=2010:44:22.606490107=20UTC=0D=0ALi=
ne=C2=A0=20=C2=A0372944:=2007-18=2016:14:26.732=C2=A0=20root=C2=A0=20=C2=A0=
=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=20=C2=A0Binder:702_2:=
18137=5D=20PM:=20gpio_keys_report_state=20enrty=202023-07-18=2010:44:29.024=
121927=20UTC=0D=0ALine=C2=A0=20=C2=A0372946:=2007-18=2016:14:26.732=C2=A0=
=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B1:=C2=A0=
=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_report_state=20exit=202023=
-07-18=2010:44:29.024528958=20UTC=0D=0ALine=C2=A0=20=C2=A0373181:=2007-18=
=2016:14:30.790=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=C2=A0=20=C2=A0=20=C2=
=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=20PM:=20gpio_keys_repo=
rt_state=20enrty=202023-07-18=2010:44:30.904866770=20UTC=0D=0ALine=C2=A0=20=
=C2=A0373183:=2007-18=2016:14:30.790=C2=A0=20root=C2=A0=20=C2=A0=20=C2=A00=
=C2=A0=20=C2=A0=20=C2=A00=20I=20=5B0:=C2=A0=20=C2=A0Binder:702_2:18137=5D=
=20PM:=20gpio_keys_report_state=20exit=202023-07-18=2010:44:30.905126353=20=
UTC=0D=0A=0D=0A=0D=0A=0D=0A=0D=0AThanks=20and=20Regards,=0D=0AAbhishek=20Ku=
mar=20Singh=0D=0ASr.=20Chief=20Engineer,=20Samsung=20Electronics,=20Noida-I=
ndia=0D=0A=0D=0A=0D=0A=C2=A0=0D=0A---------=20Original=20Message=20--------=
-=0D=0ASender=20:=20dmitry.torokhov=40gmail.com=20<dmitry.torokhov=40gmail.=
com>=0D=0ADate=C2=A0=20=C2=A0:=202023-10-29=2007:42=20(GMT+5:30)=0D=0ATitle=
=C2=A0=20:=20Re:=20=5BPATCH=5D=20input:=20gpio-keys=20-=20optimize=20wakeup=
=20sequence.=0D=0ATo=20:=20Abhishek=20Kumar=20Singh<abhi1.singh=40samsung.c=
om>=0D=0ACC=20:=20robh=40kernel.org<robh=40kernel.org>,=20linux-input=40vge=
r.kernel.org<linux-input=40vger.kernel.org>,=20linux-kernel=40vger.kernel.o=
rg<linux-kernel=40vger.kernel.org>,=20SRI-N=20IT=20Security<sri-n.itsec=40s=
amsung.com>=0D=0A=C2=A0=0D=0AHi=20Abhishek,=0D=0A=0D=0AOn=20Thu,=20Oct=2026=
,=202023=20at=2011:23:20AM=20+0530,=20Abhishek=20Kumar=20Singh=20wrote:=0D=
=0A>=20Dear=20Mr.=20Dmitry,=0D=0A>=20Greetings=21=0D=0A>=C2=A0=0D=0A>=C2=A0=
=0D=0A>=20The=20patch=20removes=20unused=20many=20APIs=20call=20chain=20for=
=20every=20suspend/resume=20of=20the=20device=C2=A0=0D=0A>=20if=20no=20key=
=20press=20event=20triggered.=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=20There=20is=
=20a=20call=20back=20function=20gpio_keys_resume()=20called=20for=0D=0A>=20=
every=20suspend/resume=20of=20the=20device.=20and=20whenever=20this=20funct=
ion=20called,=20it=20is=0D=0A>=20reading=20the=20status=20of=20the=20key.=
=20And=20gpio_keys_resume()=20API=20further=20calls=20the=0D=0A>=20below=20=
chain=20of=20API=20irrespective=20of=20key=20press=20event=0D=0A>=C2=A0=0D=
=0A>=C2=A0=0D=0A>=20APIs=20call=20chain:=0D=0A>=20static=20void=20gpio_keys=
_report_state(struct=20gpio_keys_drvdata=20*ddata)=0D=0A>=20static=20void=
=20gpio_keys_gpio_report_event(struct=20gpio_button_data=20*bdata)=0D=0A>=
=20gpiod_get_value_cansleep(bdata->gpiod);=0D=0A>=20input_event(input,=20ty=
pe,=20*bdata->code,=20state);=0D=0A>=20input_sync(input);=0D=0A>=C2=A0=0D=
=0A>=C2=A0=0D=0A>=20The=20patch=20avoid=20the=20above=20APIs=20call=20chain=
=20if=20there=20is=20no=20key=20press=20event=20triggered.=0D=0A>=20It=20wi=
ll=20save=20the=20device=20computational=20resources,=20power=20resources=
=20and=20optimize=20the=20suspend/resume=20time=0D=0A=0D=0AUnfortunately=20=
it=20also=20breaks=20the=20driver=20as=20button->value=20does=20not=20hold=
=0D=0Athe=20current=20state=20of=20the=20GPIO=20but=20rather=20set=20one=20=
via=20device=20tree=20so=20that=0D=0Athe=20driver=20can=20use=20that=20valu=
e=20when=20sending=20EV_ABS=20events.=20So=20with=0D=0Atypical=20GPIO-backe=
d=20keys=20or=20buttons=20you=20change=20results=20in=20no=20events=0D=0Are=
ported=20on=20resume.=0D=0A=0D=0AI=20also=20wonder=20what=20kind=20of=20mea=
surements=20you=20did=20on=20improvements=20to=0D=0Asuspend/resume=20time=
=20with=20your=20change.=0D=0A=0D=0AThanks.=0D=0A=0D=0A--=C2=A0=0D=0ADmitry=
=0D=0A=0D=0A=C2=A0=0D=0AThanks=20and=20Regards,=0D=0A=C2=A0=C2=A0=0D=0A=C2=
=A0=0D=0AThanks=20and=20Regards,=0D=0A=C2=A0=C2=A0
