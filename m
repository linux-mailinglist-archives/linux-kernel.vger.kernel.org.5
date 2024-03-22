Return-Path: <linux-kernel+bounces-111222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F39886957
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFB1F21641
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7A20DD2;
	Fri, 22 Mar 2024 09:34:40 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2137.outbound.protection.partner.outlook.cn [139.219.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10F1BC3B;
	Fri, 22 Mar 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100079; cv=fail; b=nbTNpAeCSFxtULs6FVfrIR8c5xBEqTPhOXGbbBzuchoEQPX28rpPYiBmeqiURY3cPx0mqlyptYa8ta58CP2Cpb+PLuf4AtFowf9GRNNCQtPg9e3bkSKEANTVqr/MukkLwSUKIrVNLUu1L6Jz12Z/v0/lENyKdGYSw6+wDyT4E1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100079; c=relaxed/simple;
	bh=j93IPEKqGhjc6EFWEH3oXRRq1HQzmGMpwQOIkUekOks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0COthIb9I3vet7XLK7nbuDYk74l3zbtF25SAO0mkGupFGiNMNMHRZu1ISKYmy+Rte1RY313HYh8sZHW2M78Ed+4unUJtxs7UgnnDVRIsq8K8lqRvqF8weYXT2Y37YSYP8YLiJgEJAUzRSZGB6J67Aa90K1agFEqCuxdDJDLxnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+imbVZcyvjZZdL9gtCmjtlnmLq+/wN1ECV+Lsf+lLGfVtMSFiT0PgpmAAA+llhLKL7P+I0QZ93ked/LTKu6x7PS4/Llim5F5nWTZI/v+M5kJr1R2GopRImR1l7lq1tGlHkxGeWRNgtSkP+blDF4ZjQb9aYKNUxMdF7mbBVhJfU4+VHq4WESIAkGKiFhHYiBkz56Vq1kskPxbZYZ6+cWnlRZL9Ce2HA9WatfQtDqJn5hk3Qt5ucn70mIM7ymb+FjMw95fasVzhFUS9RfK6YRGZSWzVp8gVO+s0vvatlWZlP/K2strsWm7YUeq+oVyxWk8UKTSeVMZf0ZvLtNF4Lekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j93IPEKqGhjc6EFWEH3oXRRq1HQzmGMpwQOIkUekOks=;
 b=aWDdUpLL2pboIlpTU4vRgX9grsSmWciKUtUuoiTjuVNRkU95HJ0NHkKP3h6bnFGqdgSSVcEbgFu94wsqO9mKXaNwlfQIo9xMxznz1ztwVSuK5Wtj0ZDvdRfkHO+hNOaBd3mM7Nitxg/eP2oHYPPS53xMvxnTtYeoQBLt6Dpn3vyU+sbnkt+NbMqkVfLRLFwadHCssc3PSgS86JVfQdmmaawjNHZVhvJ5q62LocPxXGLpx4zPR1OH1qkaYgfR6/5F40e0+OxEImP5XYCch19PAVfDzcxA/RpOtSlQzf3EoexxKcaCEhJAVX4TjlvF3wo3WqeGDoMwUbmyjS/c5DSo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Fri, 22 Mar
 2024 09:34:29 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 09:34:29 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>, "kernel@esmil.dk"
	<kernel@esmil.dk>, "conor@kernel.org" <conor@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [RFC v3 03/16] clk: starfive: Rename file name "jh71x0" to
 "common"
Thread-Topic: [RFC v3 03/16] clk: starfive: Rename file name "jh71x0" to
 "common"
Thread-Index: AQHaQ8lgYs0tSHJyj0yeEJAi/63/9LFD8GLg
Date: Fri, 22 Mar 2024 09:34:29 +0000
Message-ID:
 <ZQ2PR01MB1307A1672BDEED56E208421CE631A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
 <20240110133128.286657-4-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240110133128.286657-4-jeeheng.sia@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
x-ms-office365-filtering-correlation-id: 8c08ac08-78b0-4f76-0d33-08dc4a5345b0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nua4JUfxiF3k4aPxErPcP+DVDx+K/rnQx5qQ7WuAZS2q5sfmdRKqgm1ofIgpNC+z9pWauBKGRwfhEmS1xCwqIsIAzDCrz/Y1b9w9UJl2sAccsZ1XXN40YaxQIwdIsr6pftCV14LuLI6fbrqZ4kltfP2nwskAlDZ+5z+OmwF6WTs/9xSYq1WyRsmo8nodu1SSctJlQDwUYmHv4HGirDuIvn0j1RDrWUH5TP0gI7m43QxgBYhZbQZtXzTSbJhx3jiUE1N0UQjK71IMUdbCrm6fesg9nbtYMwVhAFh0lhJkM4PH74uyHv/SZhMJFouy+eoHJ4mx1t8FXhl2CM/RSBIrMdspQjQISR3+eYrR7kVQRedcKN/zAWmjwiVWt4txjMlyxwhMh2X6lqlZ/if+M5PwsUleBAMKYs+8SzcXNj7lBHiNMp68FDIHwAACgjt+l+djHdv4r9/c0aL85mHji2gFYW0TKsvkwx6INAm3lME4hWt9bKXBKMZn3jtUJrHBfr+guJXoIrTn0HnfJhKf6hqyAr9NG7zIJlj8i+zu9/xKBHlbgi460I2nl5EiKHZtWVz/ieJixZxrt8vxyY0hCC4NKPHc+xns8X4lxUJ6wr0Zp5Wni1c/dK9NElrlEwt9iDWT1C8dhu4VZMWi+Cg4r8Vcnw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cyAia0YxK2DpTNqaYwe/ICoA02qf1ohJWdlf6zdcS4tAo1aBwS1Xnbcn0sn2?=
 =?us-ascii?Q?VnDo6HuU06yObcESBHcQisHEKVG6bGLSkivbtaaPiREbzDB6qLrcyTwgK4ex?=
 =?us-ascii?Q?uNPSS2SM0DoE0htdn2Ah/4nTAZZOBq/dc4aoQZG2VqW38e/cosP7VhgQHOv5?=
 =?us-ascii?Q?ixaD6OM3fPUnbez8SwF8ElzptvD2mCZusOXBa4KRl/1JFxLfIlouzTP9pnSB?=
 =?us-ascii?Q?Tjns/5JOw/wbqL7/H4mHqToHs2r0FD8iWIU0VRueRfVl2wAFghY/wQGiZiJy?=
 =?us-ascii?Q?JwBt8sRkCbwCEvSX8tF8QtmeYnXfLKDaS5tKll7lpNuwMcxAP/a5to34aaUA?=
 =?us-ascii?Q?YQN6Le5QRTKIVUVeXnYf1Feu0EUzlyF7I314lWFjevbh2J33cI9pO1oTyNht?=
 =?us-ascii?Q?lR9FPI14ZhiUzc63Ffn6AkYmlot5CwwC5B20AA3o6WcdZo1726irYu4Fsg2m?=
 =?us-ascii?Q?VwfJRPKt+rdyRqwk9spnJdiDMVBK/lWQaDea9JB35AZxICxjxhghNAKt3MJv?=
 =?us-ascii?Q?qZiO1aTchSZh0PVCSQuYrA182JSK2Et6bJSkff/rSC063NXmnKA3g3ek/F10?=
 =?us-ascii?Q?c2jacfalZw+UEBz8OOxqU4qTCHUgwigGxVuNzFmzGI3BP5eQRTaAXNOz/tap?=
 =?us-ascii?Q?YY2kx4hajjvRGAcMOPyviybYsXlOnvDK6B+Mftna2fdXmZ0IsYg82FYzI5Fd?=
 =?us-ascii?Q?vzUleFBI9wHWnzHXSxZXESkRr+Gvuld3BmMKND1W+bScfQMxEU5ob/86BptR?=
 =?us-ascii?Q?ISpX35/Cyq5/zytRvjt3WWVCucA6asOEUcyGhUiFATf8SU4YuF1WCInsSigL?=
 =?us-ascii?Q?ffUfn84TZav4coME+06o2p+ID+GAfV6PJepLej8wfKaHzWrdhYU7sZz8SNuc?=
 =?us-ascii?Q?IoR5S7LPhxnA1trjwbMcOcltH99Ai4NTvSw0J50FhkzCUt5bQpRKCG4aLK9T?=
 =?us-ascii?Q?od4SbkNy+7lB1r7lTAq8RA4duRzs+dl3VAXJ9i0YqGxR3eKdLNIHy5nRYhlG?=
 =?us-ascii?Q?sOXmNkuSWr2o1wztOVU/ITh/b1gKahQ/ELQh8Y7XOUIb1WpBDErDjWmuGxUL?=
 =?us-ascii?Q?OgiUMqYxFONAaOH/bFBLxC+/9sGIcvI8UgD3aVXrQ6oze9Upe352VWJNjxWT?=
 =?us-ascii?Q?Mbp1UNIqoLFLGYMk5IjlaFw2b1ivzRGCkjjKLVLofjPvS0X2BBlrKkhYDf6W?=
 =?us-ascii?Q?+4uWpYFtOM15JuF1wFJnbD4Hb4sC+liptDJ1RUl7kdk7A6WWFrLQL/KXlqKi?=
 =?us-ascii?Q?GcVKMBpqhbAxj6b+AnLkPd/kGSxX0+MplHYGFsAa8HL2lkeX98ywLWd7XQwc?=
 =?us-ascii?Q?BM1UD65gKAmnZMEwac8RJ9uI5uq2FYA0CyGcUg5umvRhQUPHpwEC+jieiBwB?=
 =?us-ascii?Q?IEy3H1XcQyAIaf7uXfU7pixMUO9NVcmixJ/MLdjMmr+tzIV5MA8OyiEnqM4l?=
 =?us-ascii?Q?le09ygGvy7y7acbkhUkBnzumKRhKGOpcqH8aeD7IZ0A8DpShGbNB0cgsQV6b?=
 =?us-ascii?Q?vIMKzgz6ek8F/7rtkwyJCSL9N9sXlX2FQxVedV7FnHFLmQ1GMjxoEEyASR8b?=
 =?us-ascii?Q?caUb1Sw0LVHRn/uFbEBLSCm6V/x2okreqQdl8zDV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c08ac08-78b0-4f76-0d33-08dc4a5345b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:34:29.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jqt6Y/wlUPsnTjWXyPGvCOWQTDvk5ZedLu+gSggykAeC8rCnlRfPIHGmrvsOfLE8ur52pl6o97RaQ8AvergX9Y8dQOwiVaVdb3FuQ0efqwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

> On 10.01.24 21:31, JeeHeng Sia wrote:
>=20
> StarFive JH8100 shares a similar clock and reset design with JH7110.
> To facilitate the reuse of the file and its functionalities, files contai=
ning the
> "jh71x0" naming convention are renamed to use the "common" wording.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>


