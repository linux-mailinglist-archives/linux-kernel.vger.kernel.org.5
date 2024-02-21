Return-Path: <linux-kernel+bounces-74825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30285DC31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DBF285549
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4F7BB0C;
	Wed, 21 Feb 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SUygNOrc";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1xYeH+7Q"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4C38398
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523405; cv=fail; b=k2I74KynssHYfrAg56O8alSfS11bGCBCngMrGtuYxjOpkcb6+W8h1bordyGnOcQK8+MKt9fgC7trh4i6woXVdv6pFWTolRB+nApqaWnd0I5yFDcMZfW5qWj7nLSHxNfQ62rZlFJNnnAIkXKli6KqET/J4xrTqQXBEtMDOmi9Pqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523405; c=relaxed/simple;
	bh=2yLCo6zSJNyQI/Rb6+OXfpSAida7/Eqa3rAFJIZpjDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uef25jGUHtEiIapGrYStQb23NMnilGifWwChhpP5IOFiP9GRB2NPMXWi0gEdBakez1XmzqFb5/oDaW/9PWtR/ShCq6tIt9aCfZbseCGmF4s/gNV84PSXnQ1/yiCqkjuqe8J+/JNH5AA67Ldcb0devLG9aIpUZgdAxgtJLTDZRpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SUygNOrc; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1xYeH+7Q; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708523402; x=1740059402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2yLCo6zSJNyQI/Rb6+OXfpSAida7/Eqa3rAFJIZpjDk=;
  b=SUygNOrc6MeNnIO+sL5H6xjLsz7YkHlmmwCBm4+2TTQpCknWVEMVwdPF
   4t9Z9Io9/H6XA7RKFLXXuI16xYhPqxrs2xXQHsk4c9aA3wngRrI6HkEkl
   /4bZ8BVa/ulvqS+BUI63M+5y3DmPI+j8xdvyvHqblB1IVYQvycY239Twt
   SmaZFlS3VdtUGXKbnIWSYvMbYTk9Tggm5wXwlq3Mj255vu1qAuaGhGIjr
   OOvKqaNeLYSyNC8Xbf1RMoJQq7lH8zJIh8xbJx3wjf5sDRPsrM+6ntT7R
   twPbDYR8a0oQEUTacDEgRSuB5DGkXxbMkB5j2Nd459eOmMyHMIgxSDoWH
   Q==;
X-CSE-ConnectionGUID: J4Dtn7ggRJmE6wmmU6czdQ==
X-CSE-MsgGUID: fgYe1KWVTMi3bNsh9YLARQ==
X-IronPort-AV: E=Sophos;i="6.06,175,1705388400"; 
   d="scan'208";a="16591703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2024 06:50:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 06:49:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 06:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQIiKTxn6yBw++gve03CNQYI8XkvAm7YQoL1qC5PxVhFy7LoWOucYxh8Pkcb0enNKmnBX45cIPwAB8qoJl/ZaVh3UWYg5fwmoYjKXkvcRcXX3Sa4+Sij3RCrNqQkburMcoFMqiAxu+iJQ8D2F0pHVMoKLs1Re90yEw4cIiS9yqos8bovN+R0NtVk2FjGAiKyYUVJsG9QMSI6OZ4zM6dDleoEiDajyKYUBXzzs3LrHN1SYtqU7ew6Sp/dR9OOshAqOMw547cYia408IFE5KgNon9Ha1+/lAK37SpbgB+Etqs47rlG9wkzJHTDjIYG4TKvrNT6UDF4klYg3aevi/u0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yLCo6zSJNyQI/Rb6+OXfpSAida7/Eqa3rAFJIZpjDk=;
 b=X204gX/n2/BFHL9jBaTRJInqY7JY5x+1kxfuB8tlSwSvH05RSdl/Oiiko85ZrSbkRXEVKR8Rbg/8VyYX1YpR+Nt6mUZeqEXTGDlSgNIVw6rd+cQoTbLLP204xut0caKiI2PEswSwWtkt8uOux9xdsovAtSzTCDAJF6txvZC4KInC5a/WQMvK6LeU6BqpAWkJikIqCr+1PnFEsPSCiLR/asjhZBCn2O9kzhqQtYiRNG43zHnz2Z3MX1hz7S1ei2xLO2n1FGnaYUoECrABX717DGzrLEB3VmpokY/ABmQsDGIGdSbZRgBOOhak19z+f0K7XmKA49ZzGxHH1X/k/I/UjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yLCo6zSJNyQI/Rb6+OXfpSAida7/Eqa3rAFJIZpjDk=;
 b=1xYeH+7Q+F/77/EQLOWGOH1vbQCUZYESPOIhn76yLaeWHXBwdldjCBoKFiMOPd+Dxf2msPzAjeuWXjRgG9WqEti63rKIl0UsLS4YniDtrm9Aqwr82u9M8WRgsW1EbrBpZOHByfQyxs9W9vHTZHXXadnmDz/EDJaVPmysaHOktMttSEttGOi7qiNA9glL3m2OniSDjCpGDjRr3hWHtrISmSJNAjeppDIqKkpfJsqqkIeCIepvybsbgAdmz+4t2jhsTqBCHZI8oEANXpqOSgqrPutisHZjSOUzbQ6VlGNx8H1YRsfSalNM7DrdLHD3Q4Mk+H/4yVH801qcea6fGmFAxQ==
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9)
 by SA1PR11MB5898.namprd11.prod.outlook.com (2603:10b6:806:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 13:49:18 +0000
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::718a:9815:fe54:b6d6]) by SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::718a:9815:fe54:b6d6%3]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 13:49:18 +0000
From: <Nicolas.Ferre@microchip.com>
To: <u.kleine-koenig@pengutronix.de>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>
CC: <kernel@pengutronix.de>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] misc: atmel-ssc: Convert to platform remove
 callback returning void
Thread-Topic: [PATCH 01/11] misc: atmel-ssc: Convert to platform remove
 callback returning void
Thread-Index: AQHaZMzDs00l5s93Rkegy48WqR2JNw==
Date: Wed, 21 Feb 2024 13:49:18 +0000
Message-ID: <aa1338c9-0880-45fb-9ba0-9ce2025b1018@microchip.com>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
 <45719fc31bb893bb9ab1450057e9cb7f399e9ee2.1708508896.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <45719fc31bb893bb9ab1450057e9cb7f399e9ee2.1708508896.git.u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7154:EE_|SA1PR11MB5898:EE_
x-ms-office365-filtering-correlation-id: 9c2679eb-164c-424a-f2f1-08dc32e3e633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXEtVcCh0W3IbtV+e9hTnyZeNUuxjv5WhJCKrGT1xknCdUB4BXH28otzrQZ30riLvNnuEbE/N2T+3ZrOZcwSn82Pof12TGhFnceNr1xR88rWaCAm/V/pdE2Eekg3uBiCKvaShnkBXNYf2qcAKSsXGSqvrcN+j24/sTzSUBufDW8tsAGnVGtEJMrmF51zbI8/5m6yEY+1czPH2BGhtPWMUGM/W2okDAAc6Rgaph5VYaMYJ+T4ciBTStt8qR72rFynsIODO6aUVg2kvY1Nw4gfkzfNXcCUvpHNYmRQScSnxOJD5v3oVNi4PKe1zWRcSvDBZD2yYkcVWd1P3xX1OKNGj/KQkz2+JxztptFQQv629VdDveDhc6vcK1tNXQHkax6G/psyRD8seGOjT8kkmPR902gPuW8S+Nfal41xYHkUOUGZzrSK00dI7h7p1VgheeKWgNrAofeCnq4Yd7W4ZeXpJmU0oZ32hNyszaFKD7M2dDUuCV87sWmhM+Vx4a7h/aS1QOqIdAfHFUq6kOEuMjgMxhb+6zS2o2jXWRcDX5UMNawu/rbJfVAqa1PmixwCocAYO1Qrf5VmDu0gK0HJwRNctDSN8ksr/35OFNzChFX0VUWbOSCU/pvkR5hYaVi7AjhD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTVPZk1YckNUM3UrSjFyL2svZis1LytrOERpakxxUktNQXlDU1dFMS8zMk5R?=
 =?utf-8?B?OW5uTEg0dHRYM05yS1dwWHlOWDk0d1pSSTZhTlAyKzREaFdLaVZoWDA3emxz?=
 =?utf-8?B?N3JSajJQYmI0MXQ2cjJpTUU0N1E5UTNrYTNiZ2V3cDV5SGQ5NjJHVlhFRjFr?=
 =?utf-8?B?dTdyckNwYldGVXUrT2MzMDZtVzM4NVRCN1RXWS9ZeUVtanlKeVBmRS9iSGIx?=
 =?utf-8?B?SXZtQzVLWWRsYTBUT0U0RWNEcHIwY2xOU1hrRThrT2hTZUN3RjNZV2xhdFhi?=
 =?utf-8?B?UDM0dktXRWc5VStmN0pTSjZuU00xcDU1ZFRrY01UL0ZtZHp2TTN6WEFwaGwr?=
 =?utf-8?B?U3F2RithV0VXSnRQMzNKYVNkWXlCbjB3dDZTdERHWW05cGx5RVRjaGJDbnJO?=
 =?utf-8?B?cEp2Y2F0dXBnY1pwRmgrOXQrTW1WQVBLQnhjSUx1cFF6V3AzS3d5bDNTeXh1?=
 =?utf-8?B?cEw4cUN4ZlhxRXNiZDVPZzVFNGxPTTlkWHNLOWhEWCtUVXBPT2JYcFdONGJP?=
 =?utf-8?B?d1JUdE03bkc3aXFYYlhBeU1YRW41aW1FYnlpZ2phZ1QzalpxRllYRlA5N2R4?=
 =?utf-8?B?M3c1WmRjL2tvSVlUSXQ2S3BCUjdIQzczMTBRaUNrcC9VWitpSnVZcVZ2V1JJ?=
 =?utf-8?B?dk5qcmk2WHF6ZEVxM2trcDdRZnQzenZZUjdraFk3dlBuL2pIeGdUWGw0UC96?=
 =?utf-8?B?QmtNZG05UmpES1NIQkNlM2xSaTY2a29FSEcvaFNBb0xqUmlVc0VXSXJEUXJz?=
 =?utf-8?B?WEVXK3R6akxKRndYZ0RPR3JQN2FwaGVmR2pwUGNzUE01bmFpdE9iL0hXemZy?=
 =?utf-8?B?WDZTdTJGdjNoSVk5UUlKeWQ1bVR0MGVSS1dFVTNDMVd2bzhUbk0wTkZwR2k2?=
 =?utf-8?B?cllvc0VUMmJ5R2xNYng4YjhTSzhLbitpaTdzUVlkS2x1MWRuRUNIS3FKaEZz?=
 =?utf-8?B?d1BIVkhvRDAvK3QyM2dnY2oxbU9wTlNJbC9hMFNHak1xazNBTTBubCtCNkVs?=
 =?utf-8?B?dG1sb2pMeTlKckZrWUpXcEdUK1NpRDc1S1hLTm4zdjBvOVdsMnZRUG5kdjBO?=
 =?utf-8?B?TEpjSFlJa3hsTkoxUjRUV0pJekVlakFVRnRINVhjTy9xZ2FEbnh0MlFKSHp4?=
 =?utf-8?B?cFdIakRiekxxQUxzc3lyOWhnb3hYNzUreXM4RUpUYitFbmhlSElhdkpYS0NO?=
 =?utf-8?B?dXZTanAzY2FoZjRhcUVYS3NXOEV2U1BxVGhySTBLU2RNdi9POFI2blM3Myt0?=
 =?utf-8?B?a2haNmFMMy9YQ1l3RGxIdTN0N3l5a0RDd1BSdWFxeGxsS3cxV1IyNGVsbHYv?=
 =?utf-8?B?SG5sWURvMUlPaXVLd0tacmh4ZlZ4L293OFliMzc3OGNkamtubWxvWmVjbFM2?=
 =?utf-8?B?eXJJMDg4UnNNSDU1Rk0yV2lKeWw1MG5KWThjKzdLK1lCRXowNTAyRm5BWUxu?=
 =?utf-8?B?NHdldlZ2dXpFTXNkRFBDbmxIMjBtYStNUS9XMENKLytJWE5uTWdZOE1LYUk0?=
 =?utf-8?B?L25yeWNXKy9RelhQN0pXb1VmRVVyaVg2czJmOTN3TWhlcy84Q0twcEdrVHRQ?=
 =?utf-8?B?bjhaeEdXWnAzVGJWNXg0bEZSUnNPQkZDZC9mbEcvWVBjYUxiVkk5ZHJlZHA4?=
 =?utf-8?B?OG1oOC94MGJNWHZwbG9xK296TGdKNm45bTdUbjNYaGpRZGVaQWRxTTZZMXll?=
 =?utf-8?B?QWYwMkc4L0hlSS9CemlSYnJ4ZnVRTzI2aHNKQzcxLy8xcHp0Qy9lb2FFaVFw?=
 =?utf-8?B?eGY4bHdOVHhDSGhNa3JqekxnaVp3M0hES1BxbWlLbEU3cnFsbE9HT1Vhcjkv?=
 =?utf-8?B?UEtoZDMwVnA0dmxac2hFWktnQjg5T0NSNXpiNktMQUh1UGl3QS92clJxdmpr?=
 =?utf-8?B?V3czQ3htamlqcVR5TkttSjU3cDN6Q2lhUXp2RWM3dEs0TEV3bzhiVmloMDZC?=
 =?utf-8?B?WlJ3bTZURnV2SUxVY0tYc0dPcjd5SGgvV3dWbktPSnRyd3Jud3RVTnNHbjU2?=
 =?utf-8?B?eDQwVTdTeXU2aE9mV1JWckR2bWpVamV1Q2Rqc0h0ZkExUjJ2dmwxRm9ObGZ4?=
 =?utf-8?B?R3d6cmJtYzRnWXVGK3B6ak9YV1dodVJvL2QrNS9IM3BvbDkzRGlKSmtqOWFM?=
 =?utf-8?B?dC9kN0t5a21OcWt0R0psWUlnTHFXamw5WUtIakxpM2FGWWZuMFlObFQzYndn?=
 =?utf-8?B?L2FPZ1A1NVVFL0FBVG9IM3hqSXpNMHRyeWxMTjd1dkZPaisyWmpKbDgvQmgy?=
 =?utf-8?B?WnJLc01FQWJGTXdCUnV0OURkcGVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10CC223F7D5CD345870DD0DDCD32B370@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2679eb-164c-424a-f2f1-08dc32e3e633
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 13:49:18.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYnFrQ0RQIHWawKfWBBqw9QmhxRH+55pEuM4BGrI6h4u1y5Avme9VqHUj+wmSqZmXQmUt0UMpAFey4yjwhqjavLDjbp0Yzg9tu8HJ0vY8/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5898

T24gMjEvMDIvMjAyNCBhdCAxMDo1MywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IFRoZSAu
cmVtb3ZlKCkgY2FsbGJhY2sgZm9yIGEgcGxhdGZvcm0gZHJpdmVyIHJldHVybnMgYW4gaW50IHdo
aWNoIG1ha2VzDQo+IG1hbnkgZHJpdmVyIGF1dGhvcnMgd3JvbmdseSBhc3N1bWUgaXQncyBwb3Nz
aWJsZSB0byBkbyBlcnJvciBoYW5kbGluZyBieQ0KPiByZXR1cm5pbmcgYW4gZXJyb3IgY29kZS4g
SG93ZXZlciB0aGUgdmFsdWUgcmV0dXJuZWQgaXMgaWdub3JlZCAoYXBhcnQNCj4gZnJvbSBlbWl0
dGluZyBhIHdhcm5pbmcpIGFuZCB0aGlzIHR5cGljYWxseSByZXN1bHRzIGluIHJlc291cmNlIGxl
YWtzLg0KPiANCj4gVG8gaW1wcm92ZSBoZXJlIHRoZXJlIGlzIGEgcXVlc3QgdG8gbWFrZSB0aGUg
cmVtb3ZlIGNhbGxiYWNrIHJldHVybg0KPiB2b2lkLiBJbiB0aGUgZmlyc3Qgc3RlcCBvZiB0aGlz
IHF1ZXN0IGFsbCBkcml2ZXJzIGFyZSBjb252ZXJ0ZWQgdG8NCj4gLnJlbW92ZV9uZXcoKSwgd2hp
Y2ggYWxyZWFkeSByZXR1cm5zIHZvaWQuIEV2ZW50dWFsbHkgYWZ0ZXIgYWxsIGRyaXZlcnMNCj4g
YXJlIGNvbnZlcnRlZCwgLnJlbW92ZV9uZXcoKSB3aWxsIGJlIHJlbmFtZWQgdG8gLnJlbW92ZSgp
Lg0KPiANCj4gVHJpdmlhbGx5IGNvbnZlcnQgdGhpcyBkcml2ZXIgZnJvbSBhbHdheXMgcmV0dXJu
aW5nIHplcm8gaW4gdGhlIHJlbW92ZQ0KPiBjYWxsYmFjayB0byB0aGUgdm9pZCByZXR1cm5pbmcg
dmFyaWFudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNv
bGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQpUaGFua3MgVXdlLg0KDQo+IC0tLQ0KPiAgIGRyaXZl
cnMvbWlzYy9hdG1lbC1zc2MuYyB8IDYgKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21p
c2MvYXRtZWwtc3NjLmMgYi9kcml2ZXJzL21pc2MvYXRtZWwtc3NjLmMNCj4gaW5kZXggZWU1OTBj
NGExNTM3Li42ZWFjMGYzMzU5MTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9hdG1lbC1z
c2MuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvYXRtZWwtc3NjLmMNCj4gQEAgLTI1MSw3ICsyNTEs
NyBAQCBzdGF0aWMgaW50IHNzY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgICAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+IA0KPiAtc3RhdGljIGludCBzc2NfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICtzdGF0aWMgdm9pZCBzc2NfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgew0KPiAgICAgICAgICBzdHJ1Y3Qg
c3NjX2RldmljZSAqc3NjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+IA0KPiBAQCAt
MjYwLDggKzI2MCw2IEBAIHN0YXRpYyBpbnQgc3NjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgICAgICAgICBtdXRleF9sb2NrKCZ1c2VyX2xvY2spOw0KPiAgICAgICAg
ICBsaXN0X2RlbCgmc3NjLT5saXN0KTsNCj4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZ1c2VyX2xv
Y2spOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiANCj4gICBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBzc2NfZHJpdmVyID0gew0KPiBAQCAtMjcxLDcgKzI2OSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNzY19kcml2ZXIgPSB7DQo+ICAgICAgICAg
IH0sDQo+ICAgICAgICAgIC5pZF90YWJsZSAgICAgICA9IGF0bWVsX3NzY19kZXZ0eXBlcywNCj4g
ICAgICAgICAgLnByb2JlICAgICAgICAgID0gc3NjX3Byb2JlLA0KPiAtICAgICAgIC5yZW1vdmUg
ICAgICAgICA9IHNzY19yZW1vdmUsDQo+ICsgICAgICAgLnJlbW92ZV9uZXcgICAgID0gc3NjX3Jl
bW92ZSwNCj4gICB9Ow0KPiAgIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoc3NjX2RyaXZlcik7DQo+
IA0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNCg==

