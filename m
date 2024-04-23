Return-Path: <linux-kernel+bounces-155345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9E8AE92D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956C51C21C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729A13B5AC;
	Tue, 23 Apr 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="N4BlnqDk";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="UosnqRpV"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E513B286;
	Tue, 23 Apr 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881370; cv=fail; b=AxbGSwx4Ch9Rv9rUb4OeXW75OK9uMidCnDEg9wKegvHnWrYNOCq3uR/BvN2gx6GsDHq7haD+Llx5+XINViusJs/OLPSgaIh9YEGLJAFBxJdmUjP7FsDki7u0dicnpkfbOXnFruxhQQkPgNpiVsHw9pM3v7C9N1sqnEJalss26wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881370; c=relaxed/simple;
	bh=JuIcPNGY3IvgTKmRNI0Se1MfHDRkx9DjI2G9vLjlLIU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qvnWdSiV0drBd7YQyB1YuqQX798HFZBJ0EYheWfgqitwPbqLvBsVPTz9A3admtecHJv+5sO6hZa1CUITRuktMf6hTeKsqnroamDoGRL+jtuHdAYYyqHB3Gf+efN5GY9Mdn555PXdGqDEtE4aTwsj6CPiWshs/0AIXSLUSwPH2M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=N4BlnqDk; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=UosnqRpV; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NAP1Tm018143;
	Tue, 23 Apr 2024 07:09:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=GcCShT
	tiynSN9CqavKOToS9NhpGDUVS7zrnrDe1ZuA0=; b=N4BlnqDkDpvGiHpwGsKQPJ
	6W0GHv0L80oeHuraNS86eaqdKEv4h6WUuDbsUtBVSGNOYnKnMqPFLaLn4y4uLGxr
	ucCZLCSFxeS36aNNCkLW67eGzpcDjhihh9f58A3jlcEHN/dP8kiCVDffxcYVumNw
	D0/VoO/5O5rzMRdF4Jurqghjx8j0m4Yflsdcz8t/THIg92V88FXChoHcO4zpqhZk
	b7aNA6FBqY/OXDzIEcf3Y3aZRBarIVNgGkNOPhnDi3tPMjpq2EEXp7oV0A25XHsW
	hmxRKV8p6eALj5kB/Dq685Af3Y8zK0QBNihMvbMhyK1HSTnjBuWslio+844NDdAw
	==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmadvj0ve-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 07:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZuaJX/0nIPOBCpZVXGI8nkG2GED4m1MdfXrLfxsP9tE0flK3GknZwIoT7aWcQVh0s6J2+5euD+rM6F1KJfTAq0sZeE5F1fmHaTGLfd87OTYPZXSQ4hN7qUVIqCPuffsPpQm0Ujy0xYhmxE5HMb9uA3ajDIKr+yAv/j5Bz67VO/XwkPIq7SQPxVWxXJ2/yNncnsPvC7+Msl/Q4lrctI+SD1zgygEGyF6mxk0HEKHqLnGJrSWDsqz1mJ//D4EqdOTtR0wX9V0oiB+YFpMN7j7yz/y3UMnJY6TXLKXikvTli4+xvrs83p+hir2r+hRfWU46G2RjNHGXpLQUM52R+FY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcCShTtiynSN9CqavKOToS9NhpGDUVS7zrnrDe1ZuA0=;
 b=DL34iwBzFqq6jsZzknqXq7UB1hr0D+lnjzWq1qaHE2x9pETSEybsUiJ1zBCJDIuK4Q2toHhOZQq4W2v7rDJIs2TF23bAACDDAPLOjjNYX9Nh2WPHJX+WrqvwoEnrSOsa2A2sv1WibCy25uhhOjthpZS1iI/H1LBqvZjqJtnLSOKMomGHxr3mOYodGtyL8yxAk8Tu/Z3l6IJavMoS7MBLi7zoK7kVaN1FqoMHuX+jgu/+54Tu1/ZKBHgZtKX5HjPx6yTTDA042odAWyefk5HwdJcyqjHCWMGOO+wAtwa/8u3AAwiVSHa4Q3u2sS9GV7TujeenjEOSMwE/efrl7DNB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcCShTtiynSN9CqavKOToS9NhpGDUVS7zrnrDe1ZuA0=;
 b=UosnqRpVofBgVyK/Bz846t2PLaP7d8ThwHozcjUQ84cXEGt8POjvCdECy5XcvoL3DK7uovr1mLDRI7DvZE9qhz4XcEPWWaMVQY5MEfmraVbEegzZjJSxFKF+XL55lPZW1/hWkfz6Dpfe5JVQ0pckFBc5h58u9nJeCnArnBYZphrS4z+DhPFAd6Yvv5rACnO7XMPgrpqktN/ORvLJNpxzXbzJMK8s0SOnyhr/8Y/wVOuHVDkvfIlqOwuaC9qrBTBhGJl8hkIEMkXXe0B1neJvG5kSHgZa/8KtNKua17EXrZtNOiIFJwvqj2Cs6czjto9osl1KU6TLDaVZ8dYjQQPk2Q==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by CO6PR17MB4945.namprd17.prod.outlook.com (2603:10b6:5:35a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:09:07 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:09:07 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Gruber
	<jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Chris Wulff
	<chris.wulff@biamp.com>
Subject: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors through
 configfs.
Thread-Topic: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Index: AQHalYdWgtu02BG/fUykcYHBF1kPmA==
Date: Tue, 23 Apr 2024 14:09:07 +0000
Message-ID: 
 <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|CO6PR17MB4945:EE_
x-ms-office365-filtering-correlation-id: d3ab91fb-2273-4295-974e-08dc639ef09c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?nYAce6earo2hy2ft9YZquuR8Mo7zwf5CV8YfF8cgmC157MxmRZCzhqcvKK?=
 =?iso-8859-1?Q?J92LwdeX8OKeWI7FLiErzFmVfsfkklUiO9yZnuSutvjfu84SkVBr0VrqPQ?=
 =?iso-8859-1?Q?ZX63SCvFF+R0yf94pfCnG+euTeFB+H7yUQh1U4k3WTe8dCZORj6zTRt4vq?=
 =?iso-8859-1?Q?MSR406D0txt9KHwMt+khF/CyILVsHahx21Do40LFeXyP64+qTKZYzlSi39?=
 =?iso-8859-1?Q?yQZ1tZubmG51e2r4xAaEsrtLZsyTPB2BYUe2aGRoz/epRDrTTzjQyncbmN?=
 =?iso-8859-1?Q?7ShgWEQ3HGQQ91bFaHNUS89wdMC7v7Kvoa7W4JkJbZoPlvV6XVhQa765LO?=
 =?iso-8859-1?Q?7mVMNu9PGJ2fx49aTZryRN8TNxvo7iQlRy/DhMdO+xjN/IuTWh6hRjn0jh?=
 =?iso-8859-1?Q?O5qwWxTlp5h0YsHth6fvECrau4JNzpRUdc41c+MvLFTsMzkKx14iWUb+Nh?=
 =?iso-8859-1?Q?+sVI4QcDBwmV9X8dfCcr0BNTnAp2DL90EttrsN8haTF84+01n6qcDtoO7u?=
 =?iso-8859-1?Q?56dcC2RXVPjDwC+u7UvWwtJJk9AkKqKcqHt8XgdJ53+bcYdw7xeOn81eeN?=
 =?iso-8859-1?Q?0ZqlEESOCqYYi6bXeHKeXfpd0zCfYCcTSjxU1KmOQr4LjZUdDvBnWCz0y7?=
 =?iso-8859-1?Q?xKrgSh/BN6e3G2/RvFml/fnuu+kOun2ZNwgHkw9vCHK+lCHtmFO4cQ/6M2?=
 =?iso-8859-1?Q?fVhWji9IlPDel17dT5BHeVagXo+RxXGxOIl7Dg74qYJWXdTQuHokiDkLJl?=
 =?iso-8859-1?Q?C8tD+lJEkm077r6zOawGEWYh8CfcfgPu45GAx0Z/Jw5TFej+v0hGksauho?=
 =?iso-8859-1?Q?bc4RWg4Z5+JQBP4/vkZj5jEcYEVr3hybQNPBryr5rfDovwL//8Ri7ilPCn?=
 =?iso-8859-1?Q?2n6fYZfVk4ykObhKrK9R58XrJkJtCFR3ruKfLL5h7IOx8L2k/2E6IesJ0j?=
 =?iso-8859-1?Q?JpyOiHb3v2xrc46Mu0w4anfMwmil/XtNAsWS1+Rl4il2lz9RCbx+l51LGF?=
 =?iso-8859-1?Q?MiMtT0KbkVT30XSNn1wfAM1hmReG7NAU6u7CNDmxYH0GpYmh29IOzpdrDF?=
 =?iso-8859-1?Q?2W/Rkfxbp5+ey0rHpfqxJz6QfRpKbRHa5MnsEbfSSviCd1ruCXof7+w4nU?=
 =?iso-8859-1?Q?VYT/aZfA7QAAvIWXIxgQ3AX2T5ciw5Barthkay7rTwQGEp3wh31/tD+1OJ?=
 =?iso-8859-1?Q?XYG3Og53XSvhcuHYCN1ZPgUledfms4j+WizEC2KwuaEAuGTwnYCFi7GAGN?=
 =?iso-8859-1?Q?sNtqt83Lt8ZDcitV06LzU3JH+XnkAZM+Q30w/zeLZK3vb2/vyJgi8D1R3Z?=
 =?iso-8859-1?Q?LK3zq9wG7j+E1xm6xJPyHu12X3sAUJ9GinZcr2aCOESwz7Pki4ObsKxIW8?=
 =?iso-8859-1?Q?BTIL4QjZ9tRckD8vegnSHGVfA4Y2m5jQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2E9DXaM4GLnW4awmO1gv4egQuYHEWf7XX08k6maYI8pap+pu0urq4+9AtZ?=
 =?iso-8859-1?Q?WoPf+wcPU8tKt3eIq/Zibano4Is/QPeiNYubScklta6Ui/50tdklJqWcbE?=
 =?iso-8859-1?Q?CSpDg33c2dJBw0To9nC3F9bDSIseX8SkMUow/SLMONKb1IlKLHjVdcCwZ2?=
 =?iso-8859-1?Q?1IpD3I+CP9lYXwCPv5kBhFlYEQJPU6DRKGNrgSxzww1F1QlQ5XKomM11gr?=
 =?iso-8859-1?Q?UFgRcb/xNA16R51TGn2nYF4ap+FyOzp3xdd/rdvN53YWqtRcDJYWh0Vd5C?=
 =?iso-8859-1?Q?uXfbjKHh9ry+9v9scrtwI/q4wk70d3y1CzeDEa40vxcDbCytwIMC/Owv/k?=
 =?iso-8859-1?Q?wMtSryKxabphtJj7EpqRvMd1zqlv796XVKmKX1Y4DYV/r0tyjIL3Xr+FWj?=
 =?iso-8859-1?Q?yo4FWVfbkCT7zsKdNgWkKkyLPWTGpLJ13v1cWTIa12BpRduVa2rToT2gFT?=
 =?iso-8859-1?Q?5P0p9EfZj0UmcFcNwz3fNyRI9wFzcWpPad94tBh9abmdf/wAPUYpBu/9OQ?=
 =?iso-8859-1?Q?VLHZV/23cSmr/IzRlLg27Wm6CJp7p4UEeS8SSyRZyYxCYZ9rpwF9t7upPy?=
 =?iso-8859-1?Q?UwJfL3DNoajInaFg4mCrN2y7ydlgFGY0GTAHu3d3qQjGKEr5fKmqBgkV2H?=
 =?iso-8859-1?Q?Mw7rJbGe84J7dlN14O+T659xHx/L+S85yUgMyJW9tg9ubOlLdVr6768r8b?=
 =?iso-8859-1?Q?8JTN3W86s4OmLE606ZHgv8OigoMT9g+YKHUdpBLXLAugt/Dx/BcQz9lyoa?=
 =?iso-8859-1?Q?V/bqK5YZAQp/TiREhJMzO/43gSlnUIVVKnq6Q+FGO/+t2xbHKXpm+EW2As?=
 =?iso-8859-1?Q?n+P8eLsvUB/k8BcCwqGK8ahIyiRyot0h7mrq/5lmf4zjphfk9ui/GWp87s?=
 =?iso-8859-1?Q?1KsezGZeHhuJN/sD5uY3CFXDAk/crwA/vThcpBE+VWOSJo+dscAUhQZxhq?=
 =?iso-8859-1?Q?tZ+q8ZqgNk60J4GZ7KT6XjoXS7JR9EgxAAe9WcfjxaozYAZ8OVUATAsOki?=
 =?iso-8859-1?Q?vkVFlnPEjN2HQhDQcjvDRwv7fP3v/i7zT0Wo9In4/WiPDlPHYQoNcQPD54?=
 =?iso-8859-1?Q?y+chq8YE0VS2D8pX01wYvS+5fZD6KVoOOkdz0jPX0EWEcjMcI1x75sNCWD?=
 =?iso-8859-1?Q?nbLGV1k/XTLBeroTLQC2qdk93MJdudw40hVTcYBi4//1jUEHq6ccWk2go8?=
 =?iso-8859-1?Q?kbp4wO8BXXddMDJA2ii6JaUFUHyz+Z4t31Erb38NAw/GCdxvATJV8XLZoo?=
 =?iso-8859-1?Q?CzcCUOhvaibFRCfF8rm2eCDUtlPKblmw+S/xSLK5jGUmAhckEOFfSsVgyU?=
 =?iso-8859-1?Q?BsSXjptp8+ZxXr0wtyZ+7KCnvtO/rDQ2Qob1aOA3J/XPtKyxahdOnc7HiI?=
 =?iso-8859-1?Q?sajxZjrziP8ZbjChO3imXJw+6UP9H5MStEPHrVpoEmGOBTWUeuRcEhZdEe?=
 =?iso-8859-1?Q?QU5gJVNz5zNp/pdCUTs6J4zU2QXgN5tDtfpGtq05j2QsvQ6wI1FYGNFnL9?=
 =?iso-8859-1?Q?ncebcvXGp5uhLvf3tPSBzxvC8JIUWwVZ7Cm+AXMjyuLP+4OdKzmqKy5FkG?=
 =?iso-8859-1?Q?Ryyahrdf7mVG8m8ZjmZnu8mYGpHrWZY+Fc7IJNUB1qv3ZUMPAT0Q+yihlc?=
 =?iso-8859-1?Q?AdJW+bcMJUzBa0UqWEDRYlG9Gu5BtmSVSX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ab91fb-2273-4295-974e-08dc639ef09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 14:09:07.2186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ2gwEkBO4uOiKY0LceKXtwRpNuP5OJgBK+DIobFex6vnotuMu52gJqy+yUv+/5QU3lXxEN8VeynmYybBWe/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB4945
X-Proofpoint-GUID: DIJidrXfjun4MtvnGtwCwFaA3X0Ed4j3
X-Proofpoint-ORIG-GUID: DIJidrXfjun4MtvnGtwCwFaA3X0Ed4j3

This makes all string descriptors configurable for the UAC2 gadget=0A=
so the user can configure names of terminals/controls/alt modes.=0A=
=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v2: Improved naming of parameters to be mode user friendly. Added documenta=
tion.=0A=
v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419B50F94A0014647542931E10D=
2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
=0A=
 .../ABI/testing/configfs-usb-gadget-uac2      | 13 +++=0A=
 Documentation/usb/gadget-testing.rst          | 13 +++=0A=
 drivers/usb/gadget/function/f_uac2.c          | 80 +++++++++++++++----=0A=
 drivers/usb/gadget/function/u_uac2.h          | 17 +++-=0A=
 4 files changed, 105 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documenta=
tion/ABI/testing/configfs-usb-gadget-uac2=0A=
index a2bf4fd82a5b..250f8eeb8eab 100644=0A=
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2=0A=
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2=0A=
@@ -35,6 +35,19 @@ Description:=0A=
 		req_number		the number of pre-allocated requests=0A=
 					for both capture and playback=0A=
 		function_name		name of the interface=0A=
+		if_ctrl_name		topology control name=0A=
+		clksrc_in_name		input clock name=0A=
+		clksrc_out_name		output clock name=0A=
+		p_it_name		playback input terminal name=0A=
+		p_ot_name		playback output terminal name=0A=
+		p_fu_name		playback function unit name=0A=
+		p_alt0_name		playback alt mode 0 name=0A=
+		p_alt1_name		playback alt mode 1 name=0A=
+		c_it_name		capture input terminal name=0A=
+		c_ot_name		capture output terminal name=0A=
+		c_fu_name		capture functional unit name=0A=
+		c_alt0_name		capture alt mode 0 name=0A=
+		c_alt1_name		capture alt mode 1 name=0A=
 		c_terminal_type		code of the capture terminal type=0A=
 		p_terminal_type		code of the playback terminal type=0A=
 		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadge=
t-testing.rst=0A=
index b086c7ab72f0..1a11d3b3bb88 100644=0A=
--- a/Documentation/usb/gadget-testing.rst=0A=
+++ b/Documentation/usb/gadget-testing.rst=0A=
@@ -765,6 +765,19 @@ The uac2 function provides these attributes in its fun=
ction directory:=0A=
 	req_number       the number of pre-allocated request for both capture=0A=
 	                 and playback=0A=
 	function_name    name of the interface=0A=
+	if_ctrl_name     topology control name=0A=
+	clksrc_in_name   input clock name=0A=
+	clksrc_out_name  output clock name=0A=
+	p_it_name        playback input terminal name=0A=
+	p_ot_name        playback output terminal name=0A=
+	p_fu_name        playback function unit name=0A=
+	p_alt0_name      playback alt mode 0 name=0A=
+	p_alt1_name      playback alt mode 1 name=0A=
+	c_it_name        capture input terminal name=0A=
+	c_ot_name        capture output terminal name=0A=
+	c_fu_name        capture functional unit name=0A=
+	c_alt0_name      capture alt mode 0 name=0A=
+	c_alt1_name      capture alt mode 1 name=0A=
 	c_terminal_type  code of the capture terminal type=0A=
 	p_terminal_type  code of the playback terminal type=0A=
 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/func=
tion/f_uac2.c=0A=
index 383f6854cfec..5ca7ecdb6e60 100644=0A=
--- a/drivers/usb/gadget/function/f_uac2.c=0A=
+++ b/drivers/usb/gadget/function/f_uac2.c=0A=
@@ -104,25 +104,10 @@ enum {=0A=
 	STR_AS_OUT_ALT1,=0A=
 	STR_AS_IN_ALT0,=0A=
 	STR_AS_IN_ALT1,=0A=
+	NUM_STR_DESCRIPTORS,=0A=
 };=0A=
 =0A=
-static struct usb_string strings_fn[] =3D {=0A=
-	/* [STR_ASSOC].s =3D DYNAMIC, */=0A=
-	[STR_IF_CTRL].s =3D "Topology Control",=0A=
-	[STR_CLKSRC_IN].s =3D "Input Clock",=0A=
-	[STR_CLKSRC_OUT].s =3D "Output Clock",=0A=
-	[STR_USB_IT].s =3D "USBH Out",=0A=
-	[STR_IO_IT].s =3D "USBD Out",=0A=
-	[STR_USB_OT].s =3D "USBH In",=0A=
-	[STR_IO_OT].s =3D "USBD In",=0A=
-	[STR_FU_IN].s =3D "Capture Volume",=0A=
-	[STR_FU_OUT].s =3D "Playback Volume",=0A=
-	[STR_AS_OUT_ALT0].s =3D "Playback Inactive",=0A=
-	[STR_AS_OUT_ALT1].s =3D "Playback Active",=0A=
-	[STR_AS_IN_ALT0].s =3D "Capture Inactive",=0A=
-	[STR_AS_IN_ALT1].s =3D "Capture Active",=0A=
-	{ },=0A=
-};=0A=
+static struct usb_string strings_fn[NUM_STR_DESCRIPTORS + 1] =3D {};=0A=
 =0A=
 static const char *const speed_names[] =3D {=0A=
 	[USB_SPEED_UNKNOWN] =3D "UNKNOWN",=0A=
@@ -1049,6 +1034,21 @@ afunc_bind(struct usb_configuration *cfg, struct usb=
_function *fn)=0A=
 		return ret;=0A=
 =0A=
 	strings_fn[STR_ASSOC].s =3D uac2_opts->function_name;=0A=
+	strings_fn[STR_IF_CTRL].s =3D uac2_opts->if_ctrl_name;=0A=
+	strings_fn[STR_CLKSRC_IN].s =3D uac2_opts->clksrc_in_name;=0A=
+	strings_fn[STR_CLKSRC_OUT].s =3D uac2_opts->clksrc_out_name;=0A=
+=0A=
+	strings_fn[STR_USB_IT].s =3D uac2_opts->p_it_name;=0A=
+	strings_fn[STR_IO_OT].s =3D uac2_opts->p_ot_name;=0A=
+	strings_fn[STR_FU_OUT].s =3D uac2_opts->p_fu_name;=0A=
+	strings_fn[STR_AS_OUT_ALT0].s =3D uac2_opts->p_alt0_name;=0A=
+	strings_fn[STR_AS_OUT_ALT1].s =3D uac2_opts->p_alt1_name;=0A=
+=0A=
+	strings_fn[STR_IO_IT].s =3D uac2_opts->c_it_name;=0A=
+	strings_fn[STR_USB_OT].s =3D uac2_opts->c_ot_name;=0A=
+	strings_fn[STR_FU_IN].s =3D uac2_opts->c_fu_name;=0A=
+	strings_fn[STR_AS_IN_ALT0].s =3D uac2_opts->c_alt0_name;=0A=
+	strings_fn[STR_AS_IN_ALT1].s =3D uac2_opts->c_alt1_name;=0A=
 =0A=
 	us =3D usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));=0A=
 	if (IS_ERR(us))=0A=
@@ -2097,10 +2097,26 @@ UAC2_ATTRIBUTE(s16, c_volume_max);=0A=
 UAC2_ATTRIBUTE(s16, c_volume_res);=0A=
 UAC2_ATTRIBUTE(u32, fb_max);=0A=
 UAC2_ATTRIBUTE_STRING(function_name);=0A=
+UAC2_ATTRIBUTE_STRING(if_ctrl_name);=0A=
+UAC2_ATTRIBUTE_STRING(clksrc_in_name);=0A=
+UAC2_ATTRIBUTE_STRING(clksrc_out_name);=0A=
+=0A=
+UAC2_ATTRIBUTE_STRING(p_it_name);=0A=
+UAC2_ATTRIBUTE_STRING(p_ot_name);=0A=
+UAC2_ATTRIBUTE_STRING(p_fu_name);=0A=
+UAC2_ATTRIBUTE_STRING(p_alt0_name);=0A=
+UAC2_ATTRIBUTE_STRING(p_alt1_name);=0A=
+=0A=
+UAC2_ATTRIBUTE_STRING(c_it_name);=0A=
+UAC2_ATTRIBUTE_STRING(c_ot_name);=0A=
+UAC2_ATTRIBUTE_STRING(c_fu_name);=0A=
+UAC2_ATTRIBUTE_STRING(c_alt0_name);=0A=
+UAC2_ATTRIBUTE_STRING(c_alt1_name);=0A=
 =0A=
 UAC2_ATTRIBUTE(s16, p_terminal_type);=0A=
 UAC2_ATTRIBUTE(s16, c_terminal_type);=0A=
 =0A=
+=0A=
 static struct configfs_attribute *f_uac2_attrs[] =3D {=0A=
 	&f_uac2_opts_attr_p_chmask,=0A=
 	&f_uac2_opts_attr_p_srate,=0A=
@@ -2127,6 +2143,21 @@ static struct configfs_attribute *f_uac2_attrs[] =3D=
 {=0A=
 	&f_uac2_opts_attr_c_volume_res,=0A=
 =0A=
 	&f_uac2_opts_attr_function_name,=0A=
+	&f_uac2_opts_attr_if_ctrl_name,=0A=
+	&f_uac2_opts_attr_clksrc_in_name,=0A=
+	&f_uac2_opts_attr_clksrc_out_name,=0A=
+=0A=
+	&f_uac2_opts_attr_p_it_name,=0A=
+	&f_uac2_opts_attr_p_ot_name,=0A=
+	&f_uac2_opts_attr_p_fu_name,=0A=
+	&f_uac2_opts_attr_p_alt0_name,=0A=
+	&f_uac2_opts_attr_p_alt1_name,=0A=
+=0A=
+	&f_uac2_opts_attr_c_it_name,=0A=
+	&f_uac2_opts_attr_c_ot_name,=0A=
+	&f_uac2_opts_attr_c_fu_name,=0A=
+	&f_uac2_opts_attr_c_alt0_name,=0A=
+	&f_uac2_opts_attr_c_alt1_name,=0A=
 =0A=
 	&f_uac2_opts_attr_p_terminal_type,=0A=
 	&f_uac2_opts_attr_c_terminal_type,=0A=
@@ -2188,6 +2219,21 @@ static struct usb_function_instance *afunc_alloc_ins=
t(void)=0A=
 	opts->fb_max =3D FBACK_FAST_MAX;=0A=
 =0A=
 	scnprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink"=
);=0A=
+	scnprintf(opts->if_ctrl_name, sizeof(opts->if_ctrl_name), "Topology Contr=
ol");=0A=
+	scnprintf(opts->clksrc_in_name, sizeof(opts->clksrc_in_name), "Input Cloc=
k");=0A=
+	scnprintf(opts->clksrc_out_name, sizeof(opts->clksrc_out_name), "Output C=
lock");=0A=
+=0A=
+	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "USBH Out");=0A=
+	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "USBD In");=0A=
+	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");=
=0A=
+	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactiv=
e");=0A=
+	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active"=
);=0A=
+=0A=
+	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "USBD Out");=0A=
+	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "USBH In");=0A=
+	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");=0A=
+	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive=
");=0A=
+	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active")=
;=0A=
 =0A=
 	opts->p_terminal_type =3D UAC2_DEF_P_TERM_TYPE;=0A=
 	opts->c_terminal_type =3D UAC2_DEF_C_TERM_TYPE;=0A=
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/func=
tion/u_uac2.h=0A=
index 5e81bdd6c5fb..e697d35a1759 100644=0A=
--- a/drivers/usb/gadget/function/u_uac2.h=0A=
+++ b/drivers/usb/gadget/function/u_uac2.h=0A=
@@ -68,7 +68,22 @@ struct f_uac2_opts {=0A=
 	int				fb_max;=0A=
 	bool			bound;=0A=
 =0A=
-	char			function_name[32];=0A=
+	char			function_name[USB_MAX_STRING_LEN];=0A=
+	char			if_ctrl_name[USB_MAX_STRING_LEN];=0A=
+	char			clksrc_in_name[USB_MAX_STRING_LEN];=0A=
+	char			clksrc_out_name[USB_MAX_STRING_LEN];=0A=
+=0A=
+	char			p_it_name[USB_MAX_STRING_LEN];=0A=
+	char			p_ot_name[USB_MAX_STRING_LEN];=0A=
+	char			p_fu_name[USB_MAX_STRING_LEN];=0A=
+	char			p_alt0_name[USB_MAX_STRING_LEN];=0A=
+	char			p_alt1_name[USB_MAX_STRING_LEN];=0A=
+=0A=
+	char			c_it_name[USB_MAX_STRING_LEN];=0A=
+	char			c_ot_name[USB_MAX_STRING_LEN];=0A=
+	char			c_fu_name[USB_MAX_STRING_LEN];=0A=
+	char			c_alt0_name[USB_MAX_STRING_LEN];=0A=
+	char			c_alt1_name[USB_MAX_STRING_LEN];=0A=
 =0A=
 	s16				p_terminal_type;=0A=
 	s16				c_terminal_type;=0A=
-- =0A=
2.34.1=0A=
=0A=

