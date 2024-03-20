Return-Path: <linux-kernel+bounces-108274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689748808A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BBB1F20F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFDF15A5;
	Wed, 20 Mar 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="ClXqmgXg"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E91A35;
	Wed, 20 Mar 2024 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895319; cv=fail; b=fs1kBd1TbAorRhKEWs05xThSI034A2lhqeBOm2HxTF4Jnsv/0fS2hNJIhZNZYtr0UYjrNJcbCXJAC7RMb8RZ5Nkijiwud1hib1DOJmYaLsaJ2tax9F+wZImZpcZwLDP/rnOh46Jq78u01Ih75LxYvGlcTT6MtM5Y3v/OwezrqfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895319; c=relaxed/simple;
	bh=dEhqYYOPJzSsozbLts8sb+8ogzbqmrtLgscrcsjbWl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGClAfTxAROqjpHR7n1NRHVm4dZ2+Wkm+rZ9OaXXMcdqISULmGJgMYObkE1KqKrrJb8NR9eQWzCTxTMrl0vcNlfKecYYZKJRsHsIiSgz1PMmW4U8NzZw7Sz2HD0gtkPT46h4HCAMgkF8LTvudDID/mDekiZhWj+yVocF6tL4Q9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=ClXqmgXg; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNeJD0iZQqnriJ5+9czNmWrK7FYlNZurDsLafkAvUmJFrwjrHgFxO0cSa0uU0Jpq26QZBwsbVuGJf/adxIWVi4YT6nLY1aaBn6xXjjfKcP41snpW4/Xkw/C5QHVt+23mswnygQoFxlpMw11EjplFigpdBuDiguN13wqs9/konF/fN5elep21cbnzAVVwqAyM7uyX+vi63onkUuSl3SuW+I8PxlfdE2ORRWarPI2SqaQD+PH3lGRnrdVQj4jFerOni0Q5N+Nx4ADOpSfKlMVOVBzsiW8WOt1sF7i5vuQP1qFpp2tDmkyul7g82+CXIcR9Kly1MX/rv7fHpcCblWH9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ovm0+1JVZGkZBLHdkAwvoLnkoKwd6Q15/4is6rl2fc=;
 b=UUMxSmVcsC1AS6rosNV3LwjOTo88zhBp+3atD9u9CFuUBC8QOJQRriovyisVaYehKBt3yju12eoGku70XwnJZODplqP6ep8AqITPZMJEOwFHG4mAGpwND4PwKsjw2pGBQ1MV3eJ3CZA3Hk1AI1oim4VJkQlzqTLvPRZNOL/MOD1Zy5qgT1xznoeaiHRbUZJ15faUUxTrdffwsuo//Xv68imgrQCBpDTguv0s3JfFvexxNkf+mz/QS6oJXKkFFxj90BFlp3QeYui0Jbk7e1dVEtMJs27yI/NzYtQFklFbb/jEbKc9cow6vpQXdxBcl30jOFU4j01ahGKQJSDB1l0yRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ovm0+1JVZGkZBLHdkAwvoLnkoKwd6Q15/4is6rl2fc=;
 b=ClXqmgXgEsSI46Q2hgilLYlA06qVdp8jMky+NHFCEVWLrKw+IJAODjrWcJOsKY4y6RAGLGJe3IX6986K6gkQyF+uQhneccPC9JXHkbyVNmumZoekYh5hizeJk00ZsaSNlMBN2yqWUO11xy9a+yRIMAM8+rq1AVJnRrs5aXATWno=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE1P216MB1672.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.31; Wed, 20 Mar 2024 00:41:52 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 00:41:52 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>, "nicolas@ndufresne.ca"
	<nicolas@ndufresne.ca>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR                   
Thread-Topic: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR                   
Thread-Index: AQHac6LGzHawQ158fESNuZ0k+bm+6bE/1uzA
Date: Wed, 20 Mar 2024 00:41:52 +0000
Message-ID:
 <SE1P216MB1303A87C78CAD6C8A6D55EDEED332@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
In-Reply-To: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SE1P216MB1672:EE_
x-ms-office365-filtering-correlation-id: 87f37420-c0bb-4afa-f7c5-08dc4876895e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6Glz11Aqu5UoUDrI9ZgRtFnfrmNNVD+sMhN6AFibFMtd8+QR4N1nbxi/1hJheTN3mmfVEaY284Ub66OXKUHA2Hp8FANB77me1YqQllisROGNKAEuX8Hq7HqoKWx83wAPNgtuNEd4C3UmXFXyFOLs2v8dlfSHEN9PTbxj53bTgTTg6QuoKR6HOmrBk/z0tyi820AAagY30SgBStgqkD3n2AMDGAs5YGGsGwB6ccbSlgv5WRml0hKp0OsUET24ngo40Qw9SLBpcGPaXWRtqCftGmQ5MVp1OF+3La1axxyzyxQjEqm4zvIQLn/D6dtD8Cr2PoaAXFDYUB8nh+bIVb2bXvB+vJUcST1MuW7cUFpU2s/zFYVqYRb4zingt4ihgPsPkqHiv6ok8WNKzEQQ2Y61I50iwD82lPKeUohs8VYOm5OmEe2TW0YgwzZD9iLD5bHc9ELE/rPpKMBWBsSf9VzNvQtzY7RKueblUSHbbT3BBG7TxpckJjciVAzCAqZGSI8NlG/UHxQ5cPCgwsQKYgcdRPgs/1/UlQ87drS77o9dtD/A9WaydKXsVu4HRdkLsF7JYIF4C9zlp4DmdCcvUfDq5jis4tMnR4TWXoGites+QFLCzhnmYvHQUejJ8mnEcXxHQBx8o/sLwvMrILp+Qw7f+YDWmoCGO8U0+yT8qUpk1pU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hBcX8+YQ2dd+dP3CFQjezCyoDvuobBEFopBvSTizFhNYPNSfSrlKQ2jS+uWi?=
 =?us-ascii?Q?9veWQCyQW19VCUHVC5Ru0VjeciaOMB87jfWNvmhT+hJcxF553g2hajJukaCH?=
 =?us-ascii?Q?gOOY2kjh3bgN4jKpw8El+XUfFqoXgrV3n2/RkbF/P4JL3ffWiIeG35EnONLs?=
 =?us-ascii?Q?7bVSVDueZiGLiReAhrOt8p7kxMAEz0QMh60iepOFJuxirluKoj1ZzsorNNij?=
 =?us-ascii?Q?aoSguPCSoOf38OtzIZei+Y+lzg15ExK9F7nzNqOrC5YT8YzM9KoUJW8GN/Rd?=
 =?us-ascii?Q?tsRSAni4cLaB20EG9b3cod2ktlNTVlbFAwXjCJ/bUHSOyjbv+5MjNb8jlUvI?=
 =?us-ascii?Q?DSiSaW69PcyR8oSWIjR1ylEcOdEvX/id1A/aUljcTRqmtXyAA75BUDSe7gTi?=
 =?us-ascii?Q?q87ORYoOH32/uHjNllJdKC84pe7t1CiZF1CaY7VyQlCIipw6Q7KnPyb+wrhD?=
 =?us-ascii?Q?XGEpsNsS40huGj3+J+N+muh4PD5iXYtAETzeFM7nJsMWOLOK7ZgdEwVHrljh?=
 =?us-ascii?Q?XtS81iMSB9VWIIqMzDxduXkgwWrsGl30qR+NYK9QYNgULuhqhdsTg6aNQnPe?=
 =?us-ascii?Q?CUWQhN2Pk9wCWer1tRH/wU/UM13AN7iA4+nUhixByilPyCnLL50aBe1WURXm?=
 =?us-ascii?Q?VgUR8xrC+7IKLqBjHou5tLQQUZKD/Dxvr616ONBn8VfybPrkokUdgwNxLAw0?=
 =?us-ascii?Q?Z0JYXpNqOeOAhAiECenxg5XauAjVtJTgOFxSA3YlyGgTi4IYAAPKztOJP0pt?=
 =?us-ascii?Q?hAdhnh56vYeHHA+deghsSf7R3kYvk0+tMCbkx8q1a8qDnkGfgKzc44DraMiZ?=
 =?us-ascii?Q?vdfTHGSuzwpO5uzHPM/LaGgBBcCOwsdgk41DgCgxgc1pq05F/4MS1l8oAwFS?=
 =?us-ascii?Q?CjbINHocTTV1ZYGyVFtNaoSK+VEnE/GbD3rYNAHJDtLHEzWYuvM/euZqt+A2?=
 =?us-ascii?Q?wo1zg4dOfIMsd30Wb/TJ8RtgyVgt/TcOTwWJbB3pY13uTRW9/XfkusjOUt4h?=
 =?us-ascii?Q?BYAZUFspTlzP9ezpNSFFC0o2+SU2WGeJTKf+EUj7kDXKxZdWFTyBdsq3aPGK?=
 =?us-ascii?Q?H0bexpoxWbj+YH+Lv7gMASYL9mYkEz9+5Dytj3ZhL9UxjEXh+HOQwxjLrpTi?=
 =?us-ascii?Q?E+l93FPFib3SxyBU9Z+IcMdt79HcAP2gYCGT8UM2Qq9lQqzmgjPuNpphuTK+?=
 =?us-ascii?Q?eDtMWjLq5m9//04/hkoERei01Wcir6dYEtPIs3ZxhDxdFfqiYGEzxt2Xrlan?=
 =?us-ascii?Q?a/sJSlczZDK4RVP8to9TE4QesQ+P0EcixPz43uC2k9DooUUcCkEknnx8dZQx?=
 =?us-ascii?Q?nSCZDW2B52ve7AIr+4GH3wVr0RRzMkw4/GrhELC+VnTLA/7c5ZoGtyaYnnAB?=
 =?us-ascii?Q?8PN4fKufYN2EvH9wf9NnRfW90lxGWe84vFJEqi3loTy5yPyOjrTX7HMKC/MO?=
 =?us-ascii?Q?mfgydSn4pJzZRKDnIlCVyxVHPfBpSHjOidz/55gmx7+c0pZEArMra6PfNadK?=
 =?us-ascii?Q?4TYcaLyhjqdtNTnBFd8M4mVza56I/w+FZG+IQv3jAydvM6qwQR3JqilW0ulj?=
 =?us-ascii?Q?OniCIwKbSpZPjudExEkHemmoZ9Fqa6UQ6yMBeC2pPeCHjDUKRxjjGe2maJEj?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f37420-c0bb-4afa-f7c5-08dc4876895e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 00:41:52.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfAjAaY4OVDo/GO167+iHhc56Re0/DYmYEKxldnISlqrKztqVDkmd7qmoggk+UYtw4q/J23mPaUNxnz8fSgAUixBAYseSOEvtjgje9usGKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1672

Hello Hans, Sebastian, and Nicolas

Can you please review the following patch for the V2 ?

https://www.spinics.net/lists/kernel/msg5136434.html


thanks.
Jackson

> -----Original Message-----
> From: jackson.lee
> Sent: Monday, March 11, 2024 7:57 PM
> To: mchehab@kernel.org; nicolas@ndufresne.ca;
> sebastian.fricke@collabora.com
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> hverkuil@xs4all.nl; Nas Chung <nas.chung@chipsnmedia.com>; lafley.kim
> <lafley.kim@chipsnmedia.com>; b-brnich@ti.com; jackson.lee
> <jackson.lee@chipsnmedia.com>
> Subject: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
> format,SPS/PPS generation for each IDR
>=20
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> The wave5 codec driver is a stateful encoder/decoder.
> The following patches is for supporting yuv422 inpuy format, supporting
> runtime suspend/resume feature and extra things.
>=20
> v4l2-compliance results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>=20
> Buffer ioctls:
>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
> supported
>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
> supported
>     test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>     test VIDIOC_EXPBUF: OK
>     test Requests: OK (Not Supported)
>=20
> Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0,
> Warnings: 2 Total for wave5-enc device /dev/video1: 45, Succeeded: 45,
> Failed: 0, Warnings: 0
>=20
> Fluster test results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.=
0
> Using 1 parallel job(s)
> Ran 132/147 tests successfully               in 94.782 secs
>=20
> (1 test fails because of not supporting to parse multi frames, 1 test
> fails because of a missing frame and slight corruption, 2 tests fail
> because of sizes which are incompatible with the IP, 11 tests fail becaus=
e
> of unsupported 10 bit format)
>=20
> Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0
> Using 1 parallel job(s)
> Ran 77/135 tests successfully               in 37.364 secs
>=20
> (58 fail because the hardware is unable to decode  MBAFF / FMO / Field /
> Extended profile streams.)
>=20
>=20
> Chnage since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generatio=
n
> for each IDR
>  - define a macro for register addresses
>=20
> * For [PATCH v2 1/4] media: chips-media: wave5: Support runtime
> suspend/resume
>  - add auto suspend/resume
>=20
> * For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate
> bytesperline and sizeimage
>  - use helper functions to calculate bytesperline and sizeimage
>=20
> * For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-
> formats on the encoder
>  - remove unnecessary codes
>=20
> Change since v0:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The DEFAULT_SRC_SIZE macro was defined using multiple lines, To make a
> simple define, tab and multiple lines has been removed, The macro is
> defined using one line.
>=20
> Jackson.lee (4):
>   media: chips-media: wave5: Support SPS/PPS generation for each IDR
>   media: chips-media: wave5: Support runtime suspend/resume
>   media: chips-media: wave5: Use helpers to calculate bytesperline and
>     sizeimage.
>   media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>     encoder.
>=20
>  .../platform/chips-media/wave5/wave5-helper.c |  24 ++
>  .../platform/chips-media/wave5/wave5-helper.h |   4 +
>  .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
>  .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
>  .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
>  .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>  .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
>  .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
>  .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>  .../media/platform/chips-media/wave5/wave5.h  |   3 +
>  11 files changed, 329 insertions(+), 333 deletions(-)
>=20
> --
> 2.43.0


