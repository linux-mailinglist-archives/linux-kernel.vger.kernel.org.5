Return-Path: <linux-kernel+bounces-94741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A688744A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301B71F292E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11FA1CF8F;
	Wed,  6 Mar 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nTQiMvLI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5gsk486y"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF11CD05;
	Wed,  6 Mar 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768555; cv=fail; b=V1kjlMU37sgNq59o/JdRqZ0Oz7wmnSp18CoIJ9CTUPw7eTMwMDzuNVHL8q0f2FGl+SOsE+/DhmWz/UggBxe0FYW8HohYOJEaF6bkGMZRyuJYyeOF9QCUv0FTVuLRShajAsFia+lSmZXxCZII4YSLgYNtAzGLDtv6459Ll1QewI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768555; c=relaxed/simple;
	bh=qeQJWO2G8/QCKH+z70nTXhj0ecRsQT6f8dSQ1h6/CJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDIcKsZfj3B+A4p3XZnlGgWIcg0Kma6w0pQgTaYbmc78TstKdg/98Mqmka7w0Hfpy2Ltucgn7njlIwF3AEr4+GgiTXXeuK0WxDseWf+vfouC5ujKwLMIbRle2jhQSknitrfJ2lnb6CY3J4Pr97gRpdEHKpCCXord0WA8mum3nKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nTQiMvLI; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5gsk486y; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709768553; x=1741304553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qeQJWO2G8/QCKH+z70nTXhj0ecRsQT6f8dSQ1h6/CJY=;
  b=nTQiMvLI3lGyZjOwGuwcpIV+irnYfzynG3zoo/N3Ys4G3vqR3QOVhb28
   EVZM7TyvX/JbyXd5/iy+Q+YQNlD6b84S7PSYz1iWRqdbR2YC/KfRE4Zop
   MYREKpcrsLuieu/8TY+ugcsJCbceuDFqqDFf+o2zHwyRm/joBE7FV2Bt9
   AdP29FHzJeH2NZ4DbSrg9wgDu4mzA5x7+YmNTNzZ6H+tVuyl23EoHC3tJ
   GWCX4+dgpGD4VwSaEwFLbJEY/Q8N4aU3mChWQNLqn2PvfOuXSizFI5TVb
   SEaKBzJAA/FuQEtd2QTm42WgiF9ri9vYNTmBH05ubOwxZF3eQxu0djNDN
   A==;
X-CSE-ConnectionGUID: dbnFdkp6ShCuS/nAFeXjpA==
X-CSE-MsgGUID: mdYaFwf3SGaA1UYCA2kZeA==
X-IronPort-AV: E=Sophos;i="6.06,209,1705388400"; 
   d="scan'208";a="17317514"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 16:42:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 16:42:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 16:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnseMIR7sqt7BTOn2NK7jd3ysC/XUy0vD+Y8nkwcmLJRGULNQSAWHUzq8TIuRj1YbCjzLrS+299mdaAlXoxhvXW9KTDT0Pi1z9kpdZCN0lwM+sT4Gfnkr/xswFjrD9/b8sy+sSgYEKoA+IeI79Yqc256Zbp0yFhbno7hI7mGvGNP3u8fx9oeD0ZljQtOMj2FvKbgnSw2uWHMuJLeQXjHDwo+8HS12NyKafJW/q9SNWuPolR0q/0HWUgAY6NN8E7o3LZ5r5NGxQq63oGE9B3NE2WsTilHK8ATQ13537b9tcWdZUueg44LYnbJ0J8a5HBCAYCDbgNITR9GJWA7/k3Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKnBnr4q43eTYbi5DRUeoElN8Gt/yKq7V51HN6YRaNU=;
 b=NItiMwTaXHLOb1WEZWc9XswFDn0DtFtY/+SWqSFh/ClgMml2WZOp90f95V0dYFAbatLP868Igue67XvSIgfObuKOjP1NmOBdcqo0lb1Qt3rcm0Bp62OOGsZE02qLyNK/CQXFQPorEuaY+U/EuGN7L5c0N5dGhduotl4g/Cwx/WSn3fn4VCGWh71IQc9c1zaLnULFwER9qN1SRJwaDOGPDeG0PY+NHJqkmWPEyUCB4D9ODPCt/X63KOFTJiljOKAS4WLxnXd4WH5CFwJbDhsSVFhgfL4mcPVYPk9alDRYy2yGOw1FFm+xuBygNVqndOW+R8naWHrOalSb4dSDVt0MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKnBnr4q43eTYbi5DRUeoElN8Gt/yKq7V51HN6YRaNU=;
 b=5gsk486yGq7ld+iHfZKxe30MbMj+h0IfRQejbiG2WzuWc3Qcfx9nr2syo1YmPSZqE3LjMRpCB4NK13f5kKfBFlgBfpE81u6eYaktACjPCmdF9pCqGLJgdZLunDJuDgg+iJR4nWYHnXN5hGizhn2l2rIiGHIKek0RbakHw6D5zUODyow4/XtiR5SqL2aBRd/BmaLIwj1lT3/0wmJHNeIqB/N4APJ85DYWNPQMp7bzJfiG2/zArZGZlqkCmVJv/dF2WHlxyyVcr5LDqcR77SkJPEm75XtiFNAHMvrdH/LohGR6AmDLThLXPr2nrul1YAOryGPhzSkxcjUWdu4llm6qXw==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 23:42:16 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::dc78:62a2:5ccf:6248]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::dc78:62a2:5ccf:6248%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:42:16 +0000
From: <Woojung.Huh@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v3 10/12] net: ethernet: oa_tc6: implement
 mac-phy interrupt
Thread-Topic: [PATCH net-next v3 10/12] net: ethernet: oa_tc6: implement
 mac-phy interrupt
Thread-Index: AQHab6Ob/tWfers5YEGx5SyM6BefPLErX8qw
Date: Wed, 6 Mar 2024 23:42:16 +0000
Message-ID: <BL0PR11MB2913A429E53B85ABC67F9657E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-11-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240306085017.21731-11-Parthiban.Veerasooran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|MN2PR11MB4598:EE_
x-ms-office365-filtering-correlation-id: 60f7df91-5319-4fb0-ef20-08dc3e370e4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5+3JEukKXmqqRl0GhGdTxIwBko2Wk4/vsMloKSWK6rbdwVnkO+mBvJEc0LUTLkHJXhncInqE7HPBLaan8fXOSMMP4aaQHAhFr+NZL7CqE2312DorRB8DsOAF8PRrA+uX4jWo9nArnpfdB+Wzan2aMUB7etivSSdLH5xEvn4tJTIJhGO6YtbMOZWuG1AXRiq565fBX3rPNrkWU39Tz9WjdAcESvw9KQ7pN/T7wWshTLt09+OBMlHuVClcNbYow9qbTJVjgxAOtQYN7lBppewe1L/vw4T4afpjdfAppP4ywgRn50iAQDyekQlvmHRd4TbVtBcPIZelTv8t8f+22+MsJqvaqxzkTxNcY0JpdBQgU8iD+NQPQpFmsmwiBET8O3J5vb3k5YCszgzDLs1pHZ5U6tudGxpObdpkah3uSS19ezIRfDHWhaz6HoG+Llq46nv6hhSH5nPBKbPmLqUSmE1Wx30lFkPmgLAy1xVDDY5G2vPGr00ZrdaDJ+Qo2VxbxImxLvRxTSTl00w//e/wWSI6JIl3Xmn01Bvr4+F/6pHe6a2/GZDxog9Gd01I6zwIyvPVnNz/x9vBmRnhjjp1Wq6zjweZNBRv62ByQ9w0wpqK7ED4eb5TSJsOy+jkpCtoqkp8WrWVPSSbHrWmy3pw8YBwOqNAuuv7y6eReKZQKa2FoJMy/FCnjO1u5YHrRjyKHZ1PxWYGGZbkvcGZumXJKALn9frlpMaapRqNFCMX/DZOSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5wttjtQUtZvFN9CJMF/TaQBx+u+Y1azyP7qOPrljaexQ6DETwlEE3JFHkw9+?=
 =?us-ascii?Q?P1Km0uj5uPWCmbVvfaJU+UfUXWZWe1BkEqJbVwOOcTLfVQ1uTIykW2WYnBPl?=
 =?us-ascii?Q?K/ryQC+uskY566gK+tms1EouAF7gtIxTfy4q9ugmli0dnIW3lH0la+QU2gKA?=
 =?us-ascii?Q?qvTYM/1rhnWqYQArHzrdz1ROnpis4p5uj8J6ejVXrnH0h0BzLIfxk2MWaYmr?=
 =?us-ascii?Q?aPOSkyNpVxC/wtf9gAr9yQvKGJNBQg2kVYhtRWlyvpqqI+ou8wEudp0tmSmJ?=
 =?us-ascii?Q?kUZQ+qU3VsBi7k3zOXjqgKqCpDNAoy88OZtRfQVMXmVqDYs2wxgw0/1PNW89?=
 =?us-ascii?Q?69VWTORVpwLFm+XB6DWZqYomoux9Crg0V8XT/xeEg730xEK7ino1gpOEBwQE?=
 =?us-ascii?Q?UJCaDCkitoic7vL6bNv1oDVGp4dkBz1msf3Ry785ZDHxLAh2fa/uocNbGJCf?=
 =?us-ascii?Q?l9+oL+i7UIUlvw/3BSdsmMvUhc0HXgaX3YPIRuvVRmjIwBIx/srZsFZ1kxcC?=
 =?us-ascii?Q?LQog5N1uX6BZ7ISAKk4nx11TFz012QDdW2XTn1v46kjqSQkRQkmap5FCV7jB?=
 =?us-ascii?Q?8wHGjpeZyKUvaeihnl6IKiyFBqGHCX84leXeq/D+gU/WeOxVSGiKbsm+I6AL?=
 =?us-ascii?Q?D0k0yiCKhZYwD/nRGGJ0I2IutJLWBFlL4yKMHfcIjVGxscJFXTIG00h+QmSv?=
 =?us-ascii?Q?G+M2vBtk496o3o379HNnMx2e+VunXEBtEC6C22ofF6a71agpahQrVT914fOM?=
 =?us-ascii?Q?q3Nwf6yp3YVoqJQkllDWttnzQXT+dlepS3em3WdA2qWKaqNQW4F6tLtuIFnB?=
 =?us-ascii?Q?njP8t2il7l1S8lU/KW61WHZmCkZoFFTqjPd9+IPlmZmGBi4jY31l/FnVdUic?=
 =?us-ascii?Q?BBlT77zDJhxpBYx6FXCq0pMdQ0KNICRgMZtrnZZNez3XzmRecLwAF6T6i+KT?=
 =?us-ascii?Q?7RvmIodFqy7ayqHXAemx13WXfSljaT4AFNKleTc5MH6vn1q4IJ36OBz/Fa4A?=
 =?us-ascii?Q?cyfQK8BwOALyR3OsSIqX7NZPNgYtbnyPa9NLQCr4Vwe5qtwyAZBBYxj27k+p?=
 =?us-ascii?Q?yelaFw8p7KqqilQDs+hGGrIC9DxVv1NwhhA7edeMJ5FMLORvVu06xSTEBTBf?=
 =?us-ascii?Q?mZN0Vz1BaD2q7KRu1ZzcVCFqeL1qaqJB9w104T2KGMFICOXOQeey6DZtVYBJ?=
 =?us-ascii?Q?R+4FLYA1W/+WewIqsctrDVxydd4G+xV51s0FvLPtrYp18CCeveHDP8ASJWV9?=
 =?us-ascii?Q?Im7JoVfFWwKn9+b19wHCZndr2SiusCnguKz4eiOX8GOHu7QkMhKBVGQ62JGW?=
 =?us-ascii?Q?GWqE4XN3BtyOcei4qs2UIjIzcCs9EbhstNyiOZ9DJgCHYtYQDI67uESUMuI1?=
 =?us-ascii?Q?ShHFQ6MgMYYBN2YHDST9wLkxPub8PDywq3mdt1bOWXKWdO3x5CskhC7Hzfyx?=
 =?us-ascii?Q?eTOtvm0ORgGLl/0Yi4uFIEsvgzslcgldJiQnKB4rsN8DQG69bKPCf3fwWWkn?=
 =?us-ascii?Q?JKaI3lFHHAvrIkkgJotqLRUNsLz/8Or10ava+x5cHYGnOdpkczjONKHlJp4r?=
 =?us-ascii?Q?h6yTPTUI9VKSJ3b6GthFWQGg/zNt1p4D+9Yu2m+f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f7df91-5319-4fb0-ef20-08dc3e370e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 23:42:16.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnX9L5d5tHHiaWgtz/WQw9o4IA0xoY1jLoEgTq1qC3pGKXB+EOtOjuU/kW2mYrVS+a5au9T7lwygPyXK6IjQQjJwix4U/lgpQ5yhChN3+AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598

Hi Parthiban,

..

> +static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
> +{
> +	struct oa_tc6 *tc6 =3D data;
> +
> +	/* MAC-PHY interrupt can occur for the following reasons.
> +	 * - availability of tx credits if it was 0 before and not reported
> in
> +	 *   the previous rx footer.

Per description above, it may be typo of "the previous rx footer"

> +	 * - availability of rx chunks if it was 0 before and not reported
> in
> +	 *   the previous rx footer.
> +	 * - extended status event not reported in the previous rx footer.
> +	 */
> +	tc6->int_flag =3D true;
> +	/* Wake spi kthread to perform spi transfer */
> +	wake_up_interruptible(&tc6->spi_wq);
> +
> +	return IRQ_HANDLED;
> +}
> +


