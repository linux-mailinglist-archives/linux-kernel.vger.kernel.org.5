Return-Path: <linux-kernel+bounces-11593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAB81E8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796D41F21E87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BB4F8B5;
	Tue, 26 Dec 2023 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vbjh+6Jg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8C4F892
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231226172244epoutp04975420c38f9101facdfcea05fc4a23d0~kcYKDAs-B2152621526epoutp04h
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:22:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231226172244epoutp04975420c38f9101facdfcea05fc4a23d0~kcYKDAs-B2152621526epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703611364;
	bh=aaKnFjErDRwPo8xwraoeFxPD1Aq9gkcKBsNh5h9LLCM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=vbjh+6Jgt/PQcJl7p30N2Oj6+xIlQcGLxpUTAeqbjhFiCxCNDMjSrB993D8iFuLZ2
	 Pg0KHMCgMnqVgIMD+dv1LsVWmE7AjzW8pO+A4z98kdezqi8Gw8F0j/oQASVBap41bv
	 wLkX+/D+Ab4GQEoAH9uq+SCC+S61vSJwgjmbOJvI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231226172243epcas5p4e7158081ccb8296a8c5ea88215061f21~kcYJiZXj12557625576epcas5p43;
	Tue, 26 Dec 2023 17:22:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T01my28X9z4x9Pp; Tue, 26 Dec
	2023 17:22:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.BF.10009.2EB0B856; Wed, 27 Dec 2023 02:22:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231226165709epcas5p4294e1ad972e355d0a4bab6d2593a8c2e~kcB085LaY1187911879epcas5p4H;
	Tue, 26 Dec 2023 16:57:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226165709epsmtrp13d63feb8ab858af68ae549208503adb8~kcB0723PF1935419354epsmtrp1I;
	Tue, 26 Dec 2023 16:57:09 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-d9-658b0be2c75d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.0D.18939.5E50B856; Wed, 27 Dec 2023 01:57:09 +0900 (KST)
Received: from FDSFTE353 (unknown [107.122.81.138]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226165707epsmtip24e332aa274a047d0aa8963be24c3e8f9~kcBy7iRSy1432914329epsmtip2k;
	Tue, 26 Dec 2023 16:57:07 +0000 (GMT)
From: "Varada Pavani" <v.pavani@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <s.nawrocki@samsung.com>,
	<tomasz.figa@gmail.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <cb9a6bd4-6c99-4409-9cc7-73b600eb8fce@linaro.org>
Subject: RE: [PATCH 1/2] dt-bindings: clock: Fix spelling mistake in
 'tesla,fsd-clock.yaml'
Date: Tue, 26 Dec 2023 22:27:06 +0530
Message-ID: <003d01da381c$908906f0$b19b14d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIfKK3XePgr9siDWfg9PTfJIXwAgwFsxK7RAliZkDKwE7uEIA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmhu4j7u5Ug9ZrnBYP5m1jszi0eSu7
	xZq955gs5h85x2rR9+Ihs8Xe10Cxjz33WC0u75rDZjHj/D4mi4unXC0Wbf3CbnH4TTurxb9r
	G1ksVu36w+jA5/H+Riu7x85Zd9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwRWXbZKQmpqQWKaTm
	JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdq6RQlphTChQKSCwuVtK3
	synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmg+3cRWcJSr4tTz
	HsYGxt2cXYycHBICJhLPep8ydTFycQgJ7GaUmHr8OyuE84lR4vTOpcxwzoEtIA5Ey8W5k1hA
	bCGBnYwST1Z7QRS9ALKn/WADSbAJ6EjsfrkcbJSIwH4miTuvjzKBJJgFaiROr30BVMTBwSlg
	JzHpfgZIWFggVuLZuVfsIDaLgKrEo5XHwMp5BSwlFrc3M0LYghInZz5hgRijLbFs4WuogxQk
	fj5dxgpiiwg4Saw8PZ0NokZc4ujPHrAPJATOcEj8fN7JDtHgIvH2xSYWCFtY4tXxLVBxKYmX
	/W3sILdJCCRLtH/ihgjnSFzavYoJwraXOHBlDgtICbOApsT6XfoQYVmJqafWQX3IJ9H7+wlU
	Oa/EjnkwtpLEzh0ToGwJiaer17BNYFSaheSzWUg+m4Xkg1kI2xYwsqxilEwtKM5NTy02LTDK
	Sy2Hx3dyfu4mRnBa1vLawfjwwQe9Q4xMHIyHGCU4mJVEeGUVO1KFeFMSK6tSi/Lji0pzUosP
	MZoCg3sis5Rocj4wM+SVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp
	1cBUOUlW772wASPD0xWJUgEXUiM4Z1u8XXci83h25+XvSjbx85kXnWk+46ab/2o1U+JXm6dz
	HaZLvpR+pPz8odWZjutZMduy35zZu8g556vlBrH2P6++cQeWHdzidFYyxavzgfmc21OZdzyZ
	wmN+duKlDQfiVVbLnLzzcNWGKy2nph69VvWnUupYltVG77tzUxZXv7C/Jlh763mA/H+9tYqy
	iSsPxPE9F5KZ7/jAYdvFYBnWpJN/WWSP+WS9s9BekR3NP+NrZTbLw9hvn95npshP2fxU/Ihk
	0xqm50921LifnpjHe+6Xc73Tk5In89K+r2kWFNk68cbahVGzF3A8ecTEt2dn1vcWcWaxK2tU
	J90KnazEUpyRaKjFXFScCADqkrblVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvO5T1u5Ug+8X9CwezNvGZnFo81Z2
	izV7zzFZzD9yjtWi78VDZou9r4FiH3vusVpc3jWHzWLG+X1MFhdPuVos2vqF3eLwm3ZWi3/X
	NrJYrNr1h9GBz+P9jVZ2j52z7rJ7bFrVyeZx59oeNo++LasYPT5vkgtgi+KySUnNySxLLdK3
	S+DKmHdmP1PBZc6Ki7v72BsYV3J0MXJySAiYSFycO4mli5GLQ0hgO6PEpmPbWSASEhI7v7Uy
	Q9jCEiv/PWeHKHrGKHHz1CFGkASbgI7E7pfLWUESIgLHmSTWHG8EG8Us0MAoMfn+N2aIlr2M
	EpcePQEq4+DgFLCTmHQ/A6RbWCBaovXvTrAVLAKqEo9WHmMCsXkFLCUWtzczQtiCEidnPgE7
	iVlAW6L3YSsjjL1s4Wuo8xQkfj5dxgpiiwg4Saw8PZ0NokZc4ujPHuYJjMKzkIyahWTULCSj
	ZiFpWcDIsopRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjODK1gnYwLlv/V+8QIxMH4yFGCQ5m
	JRFeWcWOVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQam
	HX84Yqxe3Vrz682dpydyVvUXXt9VkmVfvXDtAhVz1p6Osqsb37L7r4r14f6zslTfnHXuTLX5
	DKWTQy0Se0MKDERWWH2tjrn31nWTgMap7XKmPzN75YWUKpwluMtf+H1Pjrhe++qAS+SDqica
	rWcnxzycsyQ9N/3ttRsH/d42lsQtXrH9jM/a3uWh01rK/rvZFmwvOXkgU7BBNupXz3lL4fVB
	HY+q3l7ublIqj9XprSjdIjBv5uPzeZNXnxIXaC++HHvasaKjZP18jbDQpH+T53v1H6zcZnsg
	SYZ3SSPnFh1buYmKn682bHoe8e61umKgVtDtcoErMQ2S72cfF5G5umFK+dUHopef/rBzZe9T
	YinOSDTUYi4qTgQA6sG/UDsDAAA=
X-CMS-MailID: 20231226165709epcas5p4294e1ad972e355d0a4bab6d2593a8c2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219115856epcas5p371abeb4264f60309e597b90954e6d58c
References: <CGME20231219115856epcas5p371abeb4264f60309e597b90954e6d58c@epcas5p3.samsung.com>
	<20231219115834.65720-1-v.pavani@samsung.com>
	<cb9a6bd4-6c99-4409-9cc7-73b600eb8fce@linaro.org>

Hi Krzysztof,

-----Original Message-----
From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D=20
Sent: 19 December 2023 17:37
To: Varada Pavani <v.pavani=40samsung.com>; mturquette=40baylibre.com; sboy=
d=40kernel.org; krzysztof.kozlowski+dt=40linaro.org; conor+dt=40kernel.org;=
 linux-clk=40vger.kernel.org; devicetree=40vger.kernel.org; linux-kernel=40=
vger.kernel.org; s.nawrocki=40samsung.com; tomasz.figa=40gmail.com
Cc: linux-samsung-soc=40vger.kernel.org; alim.akhtar=40samsung.com; aswani.=
reddy=40samsung.com; pankaj.dubey=40samsung.com
Subject: Re: =5BPATCH 1/2=5D dt-bindings: clock: Fix spelling mistake in 't=
esla,fsd-clock.yaml'

On 19/12/2023 12:58, Varada Pavani wrote:
> Fix typo 'inteernal' to 'internal' in 'Documentation/devicetree/=20
> bindings/clock/tesla,fsd-clock.yaml'.
>=20
> Signed-off-by: Varada Pavani <v.pavani=40samsung.com>
> ---
>  Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml =7C 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Are there any other typos in that file or in other Samsung clock bindings?

I couldn=E2=80=99t=20find=20any=20other=20typos=20in=20current=20file=20and=
=20also=20in=20other=20Samsung=20clock=20bindings.=0D=0A=0D=0AThanks=20for=
=20the=20review=21=0D=0A=0D=0ABest=20regards,=0D=0AKrzysztof=0D=0A=0D=0A=0D=
=0A

