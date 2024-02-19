Return-Path: <linux-kernel+bounces-71587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292E85A767
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18FE1F21DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5E38DC7;
	Mon, 19 Feb 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tDnUWiLd";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AjyHJO2/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43133C46F;
	Mon, 19 Feb 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356679; cv=fail; b=hJ9NuzvB1JTq3+pCbajqySKpT236npHOkx0e3La7IXtzF3cXhF8y2boqjZNw8/cnMUXeoxx23tKAmwS9rhhmo79wKT4RxBdJXpBt3UVPaYQEcY9zls2LYbgLOzh8vsM1NaLNuPco9QPencY0Ze25xQSLQdS16IMtx2UjMEwAjzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356679; c=relaxed/simple;
	bh=eYGBi19fbrqGQLaMyOH1mhO2Zu7LQACbQ6qtJUPMNLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RusJkmd3C+RVBdPBgm09Zjf/TOF75rijtD2DCywIVUhMPnMcWType1gChP0FZonzBOTqzX5fa+HqMM3CsjBI4+iISW4RTUcYn+flLKJQr2SQrhTWRcl0C9K0DA5ibfM+du+E6jjAYkyHtYyHweE/TIgef6FecqQ7XJALn5QdvNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tDnUWiLd; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AjyHJO2/; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708356677; x=1739892677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eYGBi19fbrqGQLaMyOH1mhO2Zu7LQACbQ6qtJUPMNLo=;
  b=tDnUWiLdO3Dz3UciuYbekEeJQp4XiuLC5cynYK4dyIMkqYlS/rX+h9zE
   yF0GHNY3D2BS9rXylVgDVoxg8v2pNynM7n9A8Rs3zrPCErWGD16cELea5
   F/W4xSL9NsJKnSNGBwgAqYwIv4mScIY5CftJ3UJ/vvQD0aDa/4kRBgECN
   Bwn2KlP5j6wjXHiwG9gP/nIsiSiKeoxOe/vXjSVeCNDrkelnzbTaxO/L5
   t8vt9IUFsC1qXNqq7g6rV5h1m34BiT3m/BnXuyhnD6XIotXghi3Ff/E7h
   Ot/fyEVnnEKPxHMqO5SGgOLLPTscTXPXfSUZxF5eW+Js3Zzmluh4vPURn
   w==;
X-CSE-ConnectionGUID: LrB6sQdSRuOd1ilnNsz2LA==
X-CSE-MsgGUID: ZXCmMjvOQmKohYO28xWeTg==
X-IronPort-AV: E=Sophos;i="6.06,170,1705388400"; 
   d="scan'208";a="183737061"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2024 08:31:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 08:30:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 08:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9UO1h0eEvuHpOFjEtYcmGzdvpAZUv9T3Ni9PmYoUYOSvKHCHX0tP/RcVNdL+R/Gq8FUmO8FmAvxpCttSOlBpy/jtolmswigXAhM64JfX36g4o0yJQzqrR/Tubng5EE5PO8sxA7wKe58FxwsS3DEfjCtj4FI/kzLDQcoLCJQt5v6PHUibdxbtv1VVj+A2lDXZFSWvIXtA5JxgrJ1M9yvtxCuigb8ptN3nnoyXe844qTqSc1D5HE9q79v9pzwM3jF2UxbtaElZXk0GdZQ4yA3vq5VAL2J2yItwkYLbpCUPpTEZSNuy7XkoHdQ72VFkA0z1lZBYRhpxlgjwF8ccWzJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYGBi19fbrqGQLaMyOH1mhO2Zu7LQACbQ6qtJUPMNLo=;
 b=DoncXxJpXC34mVq1u31/x3ZTBBj5koGU8MWB17bn9xAikRYvrm3u7CzYBB7EIJ/Jx9CllYh74xN3BV8vwYkg0jNNxhYmmjl9LYhXV/v+TKEqiT2uYUjXsMhLTt9cJePiSwWkAqxgCHFF6z1Tff8hT6apvcryI5hgqV19o0FS9tbJoUkNspL7eJTqV26Le+eCh4BHAoGOE4FYNFFHqHHx+7Xy6Jl98VNxFLv+MjXdV4uaDlJIrmXTvwDFQ/a2i0IG+HO6SkEPl3kz6JzjQELDo/cRuy83CHg25gVBpRks6W/sCehploJf7ICZZT5GasxO4MigPU8DoW8Yot8Zpu49mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYGBi19fbrqGQLaMyOH1mhO2Zu7LQACbQ6qtJUPMNLo=;
 b=AjyHJO2/V6btsUS/Tlym7EzjS8BIYycCMuEfVh8d8s3bg9iKoLQ3GKgtFNT8f/KOgLJqI1J0cZDN+DIIDECio23DAbUoLyAoVokYvwEzNrrtG0/kut0uPG2talgoCAvILe2b/Cslp0U25XkDMP48MTL8cFqQSUB30Zt2gs5K88z6Pk2emcZ5nzCnUrblm4ctJPfJYV++wE2xTvi7JXL0nEg3jyxCjDcecsMmI/Lvj97SeSK+AIL+68ZBa0NzT+7Q70dZlySFPGWC+AF2WSfSDAE4+nvKPcOW8aCkCh5862Uam0KJIInSCY12iSySPW7Yr+bIuFJg3C+Ccns79NFV7g==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH7PR11MB6556.namprd11.prod.outlook.com (2603:10b6:510:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 15:30:52 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.036; Mon, 19 Feb 2024
 15:30:52 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <robh@kernel.org>, <tglx@linutronix.de>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Topic: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Index: AQHaWz8HvDl6LGSGcE+Fqy+8rXoJf7EGw2QAgADu8ACAAPjDgIAJL6qA
Date: Mon, 19 Feb 2024 15:30:52 +0000
Message-ID: <a97650cd-8e06-4df6-9757-826c00a4d7cc@microchip.com>
References: <20240209100122.61335-1-dharma.b@microchip.com>
 <20240212140824.GA107736-robh@kernel.org>
 <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>
 <20240213-estranged-charger-bf0372f367e0@spud>
In-Reply-To: <20240213-estranged-charger-bf0372f367e0@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH7PR11MB6556:EE_
x-ms-office365-filtering-correlation-id: f4fec9b1-be70-4e03-26e4-08dc315fc1c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+ozB52knJYq3J9iYc/c9+6QOzBGfgrl3wbAAWTxDGcbKCJjUg7wrGgZFJVZb+54mo+7WIDUBeH1VfIA6HvTLrvmF49MRN75BGXNFnu2rrSLC9r2TeFm9NYD792hv+YaVjfnj7sVUDFG0cFnIKMpn8XwOqD+0aIN55vMnCntzDRbhK5JjH5OJp1zhC0zg4M2jCyrKDfniKPjxsMimwoCuFN/AUEPFG4VWBMgw/lqkaDT42xCx1mmVTHXeUc2gf/hD+CinDXR3xMYNV7XSsUJVOt2iE/UkS30PSNPiRWhpBKwzK+h8xa7n8752xhcM5ruH0qVye0cP4Q+ZC1b8AuhXHAAt7MHM8yWHcYmNSOTeKciW8hvo/Yuk3N4mUbuY1D2qUtoy56HAWm/hKNzpNQpPRF9KmOHMlLTIY1w/Fr9s7ROzdsBSEk+Flx7/dqWw4/UFY1+V9CZ6I+FBm42S7myW/uXIzwH/hWcjdZkUSIbOqBIEify+g4rl3t2m6fpFDvr1Z+4A/fdxS2N/rNE+IsieKmO2nYYhxbaqaNHziP3UWdRejwQbF+F8I1VafMv19iR6wxyRjQHMDLz9y0a66hSxZMCht0EgevB2JYeaicy2c6Obw6B7V2HHNhBLDJ8MCUn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU1IdS9FT3BHaWVTbFhZcXVxakZiQkpCRUhZL2owUzBRZWJBYVExcCs2Z0d5?=
 =?utf-8?B?RHZ1UUVsd1VhZVVFMjJDSWt3cHE0RTJLUUE1d0lKdEFjbFVreTF3T0p6YWlZ?=
 =?utf-8?B?dGtSODRHSjV0NmlnQ1VndG4yanhXZVN0bGRXM1lqY1F3NXRiTDI2cmtjZ1Vp?=
 =?utf-8?B?QTd0Q0RWWlExQ0FCTldkekpPUFJhUW1nRW84c3ZFemR3MXpodkFvVEZxMmlC?=
 =?utf-8?B?SGRKamZNbW5sMEd2NnFWQm5OYkRkU3FPUm5DSGtmVWJCL1hUaVNFTFB6M3po?=
 =?utf-8?B?NmY5NzI3aUZ1VFdPUXJmOUI4ejd2SmNnamNRd1JLcjZQKzN6b0EzMWVUNy93?=
 =?utf-8?B?SVU1OXpxd2U0bG01V0dpbXBJanJlZ2cyMDNocFFRYkN2enE4WFJqbmtvaE9N?=
 =?utf-8?B?Y3dQL0lEV1NrZDNBV2RIdm9udmNCZ2FReUc5WW9pSyt0RmhkNTBjaUZCSWNX?=
 =?utf-8?B?YzRYRDBMMWdRT1pVWDFjZnE3clFVVVRRQXN2Q1lNTmR0eTFiU0x0c0pESWh2?=
 =?utf-8?B?eXJMamxWdEN0c1dZM2M3a2VNL24xMjJTTnV1eEc3TDRGM0xObG0wYW9jSVBa?=
 =?utf-8?B?OGRRdG9qS3lBZXE3OFNOa2VLcG15dExVNDlIR3FSRXF2WDh2cVN4bUdUZW5Y?=
 =?utf-8?B?OE5wOTV2aUxOVXhyOWRTWlZ5bzhjeFNTVlVERFN1SWFjUTRJNm8vLzNyWmVl?=
 =?utf-8?B?TzRHemJjVVVPRXlPYkdRMURSSmNmUWkzcUFJaUJzMElsckxoU2R0MTVMKzlI?=
 =?utf-8?B?NStXRUxuZW5iKzZoenc0c25VM2MxM0oyNUNPbVBtZTN5OEc1Y3JkM0hpQXJB?=
 =?utf-8?B?YXI3ZjFmeXc0MUtvN3RybFNMSHBGSk1McFRYM1RvVXlyaCtCWjV2NU8vU2s1?=
 =?utf-8?B?RncvODV4M1JUY3BrQStRK1RTam5PL1h4eU9JYXkwcW1LOUYyTjBjUW9QVE44?=
 =?utf-8?B?eEF2c3p1SFlBSy9NVGlISGY0TTRURW5PTVUxUXlPUDNrK0VHM3luUzgwRzlO?=
 =?utf-8?B?YWttWHFtMFlIN21UcVFZcEhvWVlvc05xZmFkZjJxY3ZBRCtQcWtqNTZpRWwv?=
 =?utf-8?B?amw4ampSWTVKL2tuNVlPZ3pmQjBqenYxR0VBYVJUVk83ZDlRVUtCWlBKUk1B?=
 =?utf-8?B?aXI0aGsvWUVOaDZHSGJhSVNjaUFYZ3BWNmVLWFRYQlI1aEh4eXkzS3l4cGZE?=
 =?utf-8?B?VEJqYXhQeWFTVmtRVlJaUzIzR3lvZDNPWlZOMnhVZ0RoUFJIVnNaMmxHYlB3?=
 =?utf-8?B?U2ZkMWFtdWFkdzV3SmNXT0NwU3BaMzBHc1BvWlRFMGllVVlReURTWWM4VVU1?=
 =?utf-8?B?RUxuTzRJc1V1V1A2c2RMNHZMVHhwMkE0eDFyc2Q2YVlqQUpRRFlMalQwNDBv?=
 =?utf-8?B?MWNtUXBQQ0I2QkM3Y1RKUmVSU2pWMWdBR3hMUHNYRDJCdGxvdENpd1R2VEdR?=
 =?utf-8?B?NVduWUJ4YURuT1RadENYYjdmay9EWi9JVDhtcWEyV1FhT2h6L0JvbHpDK2Zv?=
 =?utf-8?B?NkJCYVJoblFCSGdZeGJTOGFvckVnL1JNNmdzTDcxTnMrQkp0WHk1aVJIeEw4?=
 =?utf-8?B?a1dVeEFBM3RsUHRQMkhIWCtoQTl6SytyelNFekJyalpjckt3RC91dTN2b3Ey?=
 =?utf-8?B?c1U4Q1JYL1lsSGRicmZmQlVCQUplSzFibDRueU5oTlZTaTVFOEVGWmVQaWN2?=
 =?utf-8?B?bXk2bmZIQytNNEZOUWswUkhiWDI3YWlBWm1ycnIrMlR6UkpGRXpOZ2dBWGNM?=
 =?utf-8?B?YnpLMXFuU0k1Mm5IM1daUGFZM0c4bVBRMnFFOHdrMDZCWkM4L0xuNTlDTWhu?=
 =?utf-8?B?TDltWDFTMHV1WmJtaVFjdnVDMitKVVhoSnEzb3ErQkVxeFh5M2doSzhBcndn?=
 =?utf-8?B?NVcxYkNxRmRnSElWOHpVaVJQRFNuK29uZ2RKbytTcjIrM05nd2g3bmJESkFs?=
 =?utf-8?B?WEpDbGVkamdYZXBsQ1NPMWZUbEw0MkRPRGZEOUdaTVZIRWMrbC9NOFZLQnAr?=
 =?utf-8?B?L01tb016Q3F3VXM2d3dpdXlnTndjRHIzU1N2cXpUVUFudEJ2QXBWZGxzL29m?=
 =?utf-8?B?ZkEzbDc3QWR5M2FKTGplVFRNOC9yZ2hWV05zaDRPaW82clZEb05pSnRuMVdq?=
 =?utf-8?Q?TosKnnTmuHnACFcfGmcJRgqJH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE986879E38964458DCB1A20C4C73189@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fec9b1-be70-4e03-26e4-08dc315fc1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 15:30:52.2034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ/dX/aksHk7o0MNhUl3mj+VYkzEuIo1S3wd3G3uHz/gPw0WHTnrAMTuhfQ2mByOiE4+ITVpbZGLaQlE2wQBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6556

SGkgUm9iIGFuZCBDb25vciwNCg0KT24gMTQvMDIvMjQgMTI6NDMgYW0sIENvbm9yIERvb2xleSB3
cm90ZToNCj4gT24gVHVlLCBGZWIgMTMsIDIwMjQgYXQgMDQ6MjM6MzZBTSArMDAwMCxEaGFybWEu
QkBtaWNyb2NoaXAuY29tICB3cm90ZToNCj4+IE9uIDEyLzAyLzI0IDc6MzggcG0sIFJvYiBIZXJy
aW5nIHdyb3RlOg0KPj4+IE9uIEZyaSwgRmViIDA5LCAyMDI0IGF0IDAzOjMxOjIyUE0gKzA1MzAs
IERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+Pj4gKyAgYXRtZWwsZXh0ZXJuYWwtaXJx
czoNCj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzItYXJyYXkNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogdTMyIGFycmF5IG9mIGV4dGVybmFsIGly
cXMuDQo+Pj4gQ29uc3RyYWludHMgb24gdGhlIGFycmF5IHNpemUgYW5kL29yIGVudHJ5IHZhbHVl
cz8NCj4+IFRoZSBoYXJkd2FyZSdzIHN1cHBvcnQgZm9yIGV4dGVybmFsIElSUXMgbWF5IGRpZmZl
ciwgd2hpY2ggaXMgd2h5IGEgdTMyDQo+PiBhcnJheSBpcyB1dGlsaXplZC4gVGhpcyBjaG9pY2Ug
aXMgYmFzZWQgb24gdGhlIGZhY3QgdGhhdCBJUlEgbnVtYmVycyBhcmUNCj4+IGNvbW1vbmx5IGV4
cHJlc3NlZCBhcyBpbnRlZ2VycywgYW5kIGEgMzItYml0IHVuc2lnbmVkIGludGVnZXIgcHJvdmlk
ZXMgYQ0KPj4gc3RhbmRhcmRpemVkIHNpemUgY2FwYWJsZSBvZiByZXByZXNlbnRpbmcgYSBicm9h
ZCByYW5nZSBvZiBudW1iZXJzLiBUaGlzDQo+PiBzaXplIGlzIG1vcmUgdGhhbiBhZGVxdWF0ZSBm
b3IgYWNjb21tb2RhdGluZyBJUlEgbnVtYmVyaW5nLg0KPiBJIGRvbid0IHRoaW5rIFJvYiB3YXMg
cXVlc3Rpb25pbmcgeW91ciB1c2Ugb2YgdTMycywgYnV0IHJhdGhlciB0aGUgZmFjdA0KPiB0aGF0
IHlvdSBkbyBub3QgbGltaXQgdGhlIHZhbHVlcyBhdCBhbGwgbm9yIHRoZSBudW1iZXIgb2YgdmFs
dWVzLg0KDQpUaGUgcGVyaXBoZXJhbCBpZGVudGlmaWNhdGlvbiBkZWZpbmVkIGF0IHRoZSBwcm9k
dWN0IGxldmVsIGNvcnJlc3BvbmRzIA0KdG8gdGhlIGludGVycnVwdCBzb3VyY2UgbnVtYmVyLg0K
DQpTb0MgICAgICAgICAgIEV4dGVybmFsIEludGVycnVwdHMgICAgUGVyaXBoZXJhbCBJRA0KQVQ5
MVJNOTIwMCAgICAtIElSUTDigJNJUlE2ICAgICAgICAgICAgMjUgLSAzMQ0KU0FNQTVEMiAgICAg
ICAtIElSUTDigJNJUlFuICAgICAgICAgICAgNDkNClNBTUE1RDMgICAgICAgLSBJUlEw4oCTSVJR
biAgICAgICAgICAgIDQ3DQpTQU1BNUQ0ICAgICAgIC0gSVJRMOKAk0lSUW4gICAgICAgICAgICA1
Ng0KU0FNOXg2MCAgICAgICAtIElSUTDigJNJUlFuICAgICAgICAgICAgMzENCg0KVG8gcmVmbGVj
dCB0aGVzZSBjb25zdHJhaW50cyBpbiBiaW5kaW5ncywgSSBpbnRlbmQgdG8gbWFrZSB0aGUgZm9s
bG93aW5nIA0KY2hhbmdlcy4NCg0KICAgYXRtZWwsZXh0ZXJuYWwtaXJxczoNCiAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQogICAgIGRlc2Ny
aXB0aW9uOiB1MzIgYXJyYXkgb2YgZXh0ZXJuYWwgaXJxcy4NCiAgICAgaWY6DQogICAgICAgcHJv
cGVydGllczoNCiAgICAgICAgIGNvbXBhdGlibGU6DQogICAgICAgICAgIGNvbnRhaW5zOg0KICAg
ICAgICAgICAgIGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLWFpYw0KICAgICB0aGVuOg0KICAgICAg
IG1pbkl0ZW1zOiAxDQogICAgICAgbWF4SXRlbXM6IDcNCiAgICAgZWxzZToNCiAgICAgICBtaW5J
dGVtczogMQ0KICAgICAgIG1heEl0ZW1zOiAxDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywN
CkRoYXJtYSBCLg0KDQo=

