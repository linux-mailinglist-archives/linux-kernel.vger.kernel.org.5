Return-Path: <linux-kernel+bounces-94745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC378744AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73AF1F2A0EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795921CABF;
	Wed,  6 Mar 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jMphSLv8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="avKLTLYi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3063C8;
	Wed,  6 Mar 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768734; cv=fail; b=hfzp34Uxby6gNacUIzGnLDNBRFmK1kMcpnIZG77NriJtotv2adTOlglOSZ8DLuw2lvykutDeT8uhGuXFl1sCn/Bq+I+ULaMR2J60aKdXQ1EDGPKJGLFk3amizelD6QJwq+ByxdSftiE0sYq/5uDhhhG8gsOeoYV9JASeQ9lBD9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768734; c=relaxed/simple;
	bh=tE5OHsiFMsbLNYwzG4ej22HirXLHUdBuWSXLZ1mJGHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cbCaR/mlnDNW/bsFilpYO9qQMGOJreR1qoTfa7w9Rz7QK08cfd7qFwMDzv3noxQNpham/dc9yu1U1bDHs9S/P19dzYs6ApJqdtviiheInSYZtfcMRoyL0DUAIXfPObJHa2gwyVArTtscQZ8Z7QkevO4sdU9J8VdKkbxjPFp8zXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jMphSLv8; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=avKLTLYi; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709768732; x=1741304732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tE5OHsiFMsbLNYwzG4ej22HirXLHUdBuWSXLZ1mJGHY=;
  b=jMphSLv8DPVRiie2loBvu9iOsndqiazRzgTUmmtmJsi5dZOh6F+G9t45
   F3/iPXhjRAgH1mZscRbrC0LQ2HrgkgSmSh6wCB69eEPXOSKknxx388fEa
   4E6HQ349QSDdP5p3EVnfLfJNISxDrZppY5aS7ZOzIsQ3WLlivKV843Y+K
   /OFxVJilwchyQvt0Bd1E0LpcxqhKJnO6fevBo/r2RGHvzsqzpAjgvkD88
   5FAHdaZB53M//l5mnm29hvHXREGa0Kg7PeEh36QHPMx9mS8ZTVjfujapx
   bOO4Pl0TEN/GDUII6F94Krca68YJICV3z9S/7xeCQLixq6XjDqjWOiQCo
   w==;
X-CSE-ConnectionGUID: zUgBQRS/RJ2NzHjj2oSmAQ==
X-CSE-MsgGUID: FWPgOI+oRoiTcUu+rKvd6g==
X-IronPort-AV: E=Sophos;i="6.06,209,1705388400"; 
   d="scan'208";a="18967338"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 16:45:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 16:45:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 16:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeGZf2uA+WP4zsv3YB9BMY15JetPRJ6VWSef3BDqzOQbJE4zE85EhPBwfXD23hcNudfBw/RE3nbKVm7rDOFNZudxGeYPMmagYoQ34WeR/rKw8YhhGI3DEoaRH5yK9IMceKZHla2bueVEnULOcrTosafrnVkiSZp4AQDh9m9bWOVaf+NdFlfTqyW7n4dV7yLWg4fpH+5OmYelEp4srRYzP9jTMhJ1wORkJUb6wHsTtZd2sy14a+AcgaH/KoJfR6ik3Ck3B3BEDOaxrsZBgvp61wNg1UY63QNpZLvHAo6kp/tF99kOUETe10T3hOJPaX21VZ/hPoMrtH0fooKyvxkmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D/pKyx4irqtNRremVdUAz26Ax5gi4d27bbf7dGJSw0=;
 b=M8dYgt0ajkiwMtU5ETGtXUAq/nKumIl/Ium4hb4BaAvmv7PUQZHIkN0jNzeYAIVsjTOR7Ez2Qc7GG87alJwDeGZU9fIrkwxqkJDN1esIrD6sg38g/YPIJx8wFRr8gnGx0L0v57FmEpbexw5JNWZvGGFPWrZV/oHRXUQy8LjeKqWkOy6FCt5InyyL9ibUCqyLJ8WGUSrthaxgJROMmfLS1YyHYUQtgS4i/r9ynywk6gsA/5MMeKtyhTiYUyF0Lxirlor6AxnGwL/K8V0+yV0chVwFoSkjk4w24eUOn+39aSqM2BYKnKIc/iME8hlx5A2m0wj9VEBCr8paRB+QHnOBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D/pKyx4irqtNRremVdUAz26Ax5gi4d27bbf7dGJSw0=;
 b=avKLTLYiA0sbHw0+ie0MpF5mBp6vQUbqt/XYiKLrGRCvG+M3EHh/7szuaO3ccJ+hYhVMIGL/CGWZgQdeARzTXAdd4madwFv+FG4LR9/waSsxKlJf9HRyJ9x/RM8uJc3HtXo1lxSoM9Wt1hFk5FN9KIrXHikamqdB/CfDUjh0zCuLTxzlYalmrmeqdugItHfsGwuoYdrjDb/rzXwsnePSGK3v0Kl6sKYBRVIaLGObAINcOZZo7vf9pykQkmXRFt+l2VhhqYmQ1HMDRl7ttrdTrlbWKVijcDWuefGjKBOie89QaCYim17NYDYyljdx/waIejlFKYnEONazcQ8J9EoTVA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 23:44:58 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::dc78:62a2:5ccf:6248]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::dc78:62a2:5ccf:6248%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:44:58 +0000
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
Subject: RE: [PATCH net-next v3 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v3 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHab6OpOH9fv+fH6UiUBHGHSCgdN7ErYJiQ
Date: Wed, 6 Mar 2024 23:44:58 +0000
Message-ID: <BL0PR11MB29133BBDC826A8B79F59FEB1E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-12-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240306085017.21731-12-Parthiban.Veerasooran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|MN2PR11MB4598:EE_
x-ms-office365-filtering-correlation-id: 1702a8b2-357e-4854-1489-08dc3e376f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +BjkhxTUZC71ACJAZBJbToXJThA18hDULbm+/MKtGv308OxDeaPbi2Jump8/IpCZwSm2oJUTWtq/MXv0tmLzsv2mJHQScEiVbnOHHr5BpzAAftPqyFcKzfJ1P+/GAYDvT2OGT7AWPOUxRDVUJEuvuU3iY1Nx6hIqUGjQ6s8l5n8BI6/te2EpW4FetwPq4ln+iZlxT67hXTppgAOMFD6PjZtEgEdndj7dvE0WKbQ+DznKXHSz1hxsgOMv2kZrQlGoe1euawVyoAstxUeZwsDswQcCn/tv1JYutbJEnO0cLVK0Qer/wVJr+hbNA8/TlgQ09llXW+Jm+F8dKH0hwKkJJqOFwqVSSf04MEY6QaKjang/wBFq2q55AXCWklzPt6ufyRbz2mcuT4qtaZDkaOuwv6zhbizOteUCnLU8aJdm8gLCboCmxmFL81mGExWFhuLjY1+GM+KBLgGnTUQ37FDJlXTqoAhPZdPqKxB755CUByinxl7UEoug+MrxU9+0Itj6Ao/MjIqdo8wOa7DU4CtZIXvb71lJJBCmIcG93hMNZI45/bGnSB7z53F4iQjGZeoqxZzECJ2LgaNL7bz+nNWHyRJJoca8dBR2HSgkVWb2GsAupvo3f89NbAM4qRYxh/nqTg6iALzn6r0zBguDuHIPYeQB41bX+Dhdgj9yZbew03ibZOibM3Br+7UGDrNpq1f6MQCFom3hjzetBKKbMPepuRw9ZI93Ri8xZQR+Z/CPP/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pMJZZl0Gr/7q60cfczeb7Qh+CWNvv6mBs+jScAbHNV018mh4ekG1qZpwJIeU?=
 =?us-ascii?Q?kwCXjHuX3WHn8qY3/S+Km+t7ePvAWWupYdNvWC4A8wEg0ykO2rj/uposi12/?=
 =?us-ascii?Q?qCEu+CUadDMaWisc4zhy4Rhx5LrTwjJ5eRkonUVb6IiIiBTQ8KtPGCF8vLn6?=
 =?us-ascii?Q?X4SMMQ2djzRDwNNGX2coVeEX8SjwBQMoJiNNb/L/SleBS36oUWz1zrwYJ5mX?=
 =?us-ascii?Q?dY57Pb6eNKokAxMtX6h1UzPG3aaTE3qwy/wjZ5o6/UOclCypm+PLmml4F2oB?=
 =?us-ascii?Q?NXZotfzfqkaWN1RQHUJduxSs284TS92wo0bhIAViMjPXkRjPWSBWUeSIhNG5?=
 =?us-ascii?Q?Pcqs7GdwyQpIqEC7dt57WdVzahaFoNOQP6U5aJh15EtErst3uhLXK3tAjkVz?=
 =?us-ascii?Q?Ur9lIA1TbATbEAw9lFsUgYpiM8stDGHy8IS0HXYxUruxwlch9Di/U+/bJ+Jk?=
 =?us-ascii?Q?kJYC9gTCal606QnzddgUntmfw3i+ppufo/0yqaFUbFAKF4aLg0wdVT0EGAQN?=
 =?us-ascii?Q?QB7SOaTbqvL6KqZ/wZ/f84gpDFTds3RWCyGsXjMsR3EnS++VCM3EmUk+NdJw?=
 =?us-ascii?Q?Bdz07T+3e32+ehIqZCp48NCFPye+mO1aaS6xrCSdqAqunP5ukdvI2oiTv9DJ?=
 =?us-ascii?Q?pYRA0QQ+W41IkD7Z7D3oFIQr6sihJsim8/u70E4AlU7cpZOS1m6d4UMg91hB?=
 =?us-ascii?Q?p5k68zj+1Yq2lJgr10rJV+kYTWiI48guidur/GAQ0exJpvzGToST8OXqw23V?=
 =?us-ascii?Q?vHdoxWYswM23baSu+JRhjtzqCN16Vx0OSrsezwTw9lhhyZL14nUd5CfqGxQz?=
 =?us-ascii?Q?UyfaBKGm5iA/WIS3Tblzqyr3cp+xjL6urk3o6hiidxGu7lFpIr3t0VV+ssXY?=
 =?us-ascii?Q?maJbVmaaRnaWGjiCO7iPvUoCf+KR6+fPcT7tF+pDAom0Gx99MP5ti0ta54Iw?=
 =?us-ascii?Q?gPl+jZbIkc7gulZdOO2uzx8YQyWv01xZqAzUPIqhP1BwOxfkWpdBh3Hth/uK?=
 =?us-ascii?Q?jmati4Nb1zvoogD041NEfTNf/4Xyjs7No32N8j9mYUaeF+ASHQWRpJ3XZdya?=
 =?us-ascii?Q?x4sbS6x2gAdQh4s8aqftDWJtzzzJGlTO/IPMFq0Bx0XRR/beNXuOXKARJ4vn?=
 =?us-ascii?Q?yQTaabFMNJBqnkVkrxu4hgwVfiDUdRHco+BFFhKXxO22mBM40o14f/WqTKUB?=
 =?us-ascii?Q?4sL6Cc4yLKleSWnSY0NiSXJiugphIP6GHTllvNmauFWxszATNH13cGv/87m7?=
 =?us-ascii?Q?vOh6gjeJ/V4odsfjmSZjWJcnVQ/lrRLBryl/Qv5zZ01clU866QCg2/+TAsO7?=
 =?us-ascii?Q?RuNgUS+66xgdB0cZ/kytRMxVX/QX88pVgeV0V0KWUZJ8WCmg8QzB7B8vP6e/?=
 =?us-ascii?Q?tITw8/xrMjLg6HOdOR/7WTudY0kIaUakYkydhMHBp5DZw2hCXyh8cD3oUDzg?=
 =?us-ascii?Q?Y0NKy6foaZ4JEc8vHUnnXLo7kOG0p/UL+I84MTB3/rj5egXCYX9N0iamKaUN?=
 =?us-ascii?Q?sRCC0LhSO+b7aDa5+2RjLph1w6xkClcEGNZ5ydBYbRxDOaC0h0t0G4WgRXbk?=
 =?us-ascii?Q?YxMr7NbKr1E6amC4Mu/F5lDA38mgZ1Y1eT/0KUCO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1702a8b2-357e-4854-1489-08dc3e376f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 23:44:58.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeRyZ77ZV57Hn244y1QBakrwHT8bbdcmsbf6FWKCA9U1MEzxA/DPH0guOHfkKF3bE2/aGl/jlfIaag+1Owgm2nYxRz0gwKNSNDX+30S+l+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598

Hi Parthiban,

> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> b/drivers/net/ethernet/microchip/lan865x/lan865x.c
..
> +static void lan865x_multicast_work_handler(struct work_struct *work)
> +{
> +	struct lan865x_priv *priv =3D container_of(work, struct lan865x_priv,
> +						 multicast_work);
> +	u32 regval =3D 0;
> +
> +	if (priv->netdev->flags & IFF_PROMISC) {
> +		/* Enabling promiscuous mode */
> +		regval |=3D MAC_NET_CFG_PROMISCUOUS_MODE;
> +		regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +		regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +	} else if (priv->netdev->flags & IFF_ALLMULTI) {
> +		/* Enabling all multicast mode */
> +		regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +		regval |=3D MAC_NET_CFG_MULTICAST_MODE;
> +		regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +	} else if (!netdev_mc_empty(priv->netdev)) {
> +		lan865x_set_specific_multicast_addr(priv->netdev);
> +		regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +		regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +		regval |=3D MAC_NET_CFG_UNICAST_MODE;
> +	} else {
> +		/* enabling local mac address only */
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
> +					  regval)) {

Your intention to write 0 into LAN865X_REG_MAC_H_HASH?
If then, using 0 than regval makes more clear.

> +			netdev_err(priv->netdev, "Failed to write reg_hashh");
> +			return;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
> +					  regval)) {

Same here.

> +			netdev_err(priv->netdev, "Failed to write reg_hashl");
> +			return;
> +		}
> +	}
> +	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG,
> regval))
> +		netdev_err(priv->netdev,
> +			   "Failed to enable promiscuous/multicast/normal mode");
> +}
> +


