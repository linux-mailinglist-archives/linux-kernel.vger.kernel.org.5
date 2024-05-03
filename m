Return-Path: <linux-kernel+bounces-167743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A38BAE76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C331F22F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A9154BEA;
	Fri,  3 May 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="foliLGxl"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F414265;
	Fri,  3 May 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745223; cv=fail; b=nIvvp1RqvISZ9hO5aa7SieXgQ2ttitnHnb2nhQExhi0w/3WsHsTaXeRSrB3PVROqGNsZlGwpB7wz1zsh+xYATJnhlC9mkgTK2V7sO3Ihdee1heRG4+qXrCuNI9iqzdXg/uqWeV6YzZRc2c2Kmh7ITViMeK/4Ie5wp0TFY9AP1bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745223; c=relaxed/simple;
	bh=LNABuFP3gY2kHjKMmkz/VagSqKiLmBhz8/ApRvLhTfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aghc+WoVfuod8wgpm153dHkalv9a+fhRKINRIltaxFJunCgPsppIqhWD2ZB/34onWI/20+Fm7K3+mNoyqgZ7I7Womy98P1yCzpdQ6YPg3DI0m3T/mku1QkTXi65PHQYvdZOWodyjcCK4/2Mth7b66sVcyPMVT/dXm1rW0rbXu+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=foliLGxl; arc=fail smtp.client-ip=40.107.114.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKy/C5bDxxEB/G32Pgl8RSiJUdvWU4aGLMG1Fr/r88RTtdpoNq0LxNSYC1F/0DfZFaqqC2IEoq3V8JavGykEXgeDXtmLNJ5RYOQAVmvKdblP1hFKftXOlHFfd3WHKHkdV4qVhyMP4StGTL76e3jsLZQue6+shtnKjI+s6VJ+hSpBLDjJhn2MLGcwdFTI+9nmgn4YUy7LK09HCdBx46Y4r+dDE0GQwWlaOn+z5DWomllZNRUqftMDO6lvmIfnYcqFAt7cpz8E7xoUvRYHrTUPQdcJUbAC2cv6Jw5y0PE4gmCPwPTRYmyFMzoibRAXJQtFX3dm8tUhJphzGCBQTSoY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNABuFP3gY2kHjKMmkz/VagSqKiLmBhz8/ApRvLhTfM=;
 b=TectxcqX0ZiCPgmA8Mjji9LbFkuMxlE7L2lgjkQcvj3AZ71ILvRjPxRr3TWCn9S1ejKDIlcN4NpYL3wkmRm2s3tmN5oYpBph6/KZcwEzaiG7jyGie1kk5jTjYWrQ34yGbmm9O3uJPrP0Z2Vhmp5tEiJibDqgE8H4vCOAjWtBeDuxL1oKMwU6DpCO/OkxjsQGz3h59FP+XswlBkSRPKNPMZpC2DJI8vb4Dwmj1I3BqkY6Omkv3ksx/ATDHBZMOq5T3U7m9yp5RaZkoPCEDkuYkGmoDQuhTZCIDmEqDYmKq7MYUdcarmtJDfhGBPgBewanskc//p1hlceIBRSW+5+/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNABuFP3gY2kHjKMmkz/VagSqKiLmBhz8/ApRvLhTfM=;
 b=foliLGxlj7/CjNid98rIpyjBEuj1S4qm2OaVcPfWwH6numlcaA81GuXacclsfvCNAZH4ijM8XTeM8bWhkNucIHShSrZRaYYG6AcrfxwkMBn3CsbNrPF0C8InJ5hZgmb1I9yw8JiYVD5fHeT/ByxFYeR0WTOpuXOvnJlRMRmHd0o=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB7398.jpnprd01.prod.outlook.com (2603:1096:604:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 14:06:58 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 14:06:58 +0000
From: Min Li <min.li.xe@renesas.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, Min Li <lnimi@hotmail.com>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>, "lee@kernel.org"
	<lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHam+EpYL1RQj6Pd0e+bs+IQUzeF7GDhIwAgAIJmoA=
Date: Fri, 3 May 2024 14:06:58 +0000
Message-ID:
 <OS3PR01MB6593F02ADBA0D036A49B7F64BA1F2@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References:
 <LV3P220MB12026032F3316F557415AD9FA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <20240502065836.a6xfpqsxm3vocxwe@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240502065836.a6xfpqsxm3vocxwe@DEN-DL-M31836.microchip.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OSAPR01MB7398:EE_
x-ms-office365-filtering-correlation-id: b494590a-1300-4074-d1a2-08dc6b7a4c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0NxS0RPZUNxRTRlMWkweEwvaUxZNElOQXE0TEtQYmdmSU03S3NMWk9uRUd0?=
 =?utf-8?B?eFBzaG1JUllqUXo0V01MSDVQdVVDc2hhYnFncnY1SnhlbElua2JyOFBJVFYv?=
 =?utf-8?B?L3gzcWtRdWZZSzVWQ1RNOXpTOEVZQWhqSFZLdFJGME0wMDBRRWg0a2o1dWFw?=
 =?utf-8?B?Zk1xMTloS3V3SFJCbTk1ZUh0T0FkSGVlOEliU0tGTk43UnQ3UDkybG9TL1ps?=
 =?utf-8?B?TGxsZVNmL1dkM0w0MGlvejlVTjErZkZpNDNkUE1pVUVLWjJiM3ZJcXZVUHpW?=
 =?utf-8?B?Q205MVA0VWNRaVpNU1JsN25qZy9pTXUyVE5MMVFWOHRwcE9VTWZJSEx3V09P?=
 =?utf-8?B?T3IvczZaeEdWaDBvYkhBeFFtSWIrci8rSVNTenEyd0FHdDZIcmRXL1NURFRa?=
 =?utf-8?B?aE1naEgyMDFGSWhDb3lKamFjKzcvVktkOXYyUkpDNXJvc01CM2Y3WWVCZ3JC?=
 =?utf-8?B?RU9HSTduMHV1RkNoRU1tTDVvSHd3a3BQblFjemJtV0lIQ3pFaU9hT1B2TGdq?=
 =?utf-8?B?T1lYbyt4Mmh3eHA0OStYTjc4ZDBxRE1TMTNWQkVWWjRuSDZGT0tPQUV3UVZk?=
 =?utf-8?B?cE5LYitPRExyMTNyWWh1YllMY3JoVDlVUmVZZlZwYnJSNzJmRjFrakhHc2Zh?=
 =?utf-8?B?SksrdTR5OE1NNGFJbm02cHdvKzRJNTF6NFJ1QUFVTUZOOU9ORUlRaVhrRjht?=
 =?utf-8?B?aFhtVUkwQURwQU1qcjk3SHJiWTVIaTFNanNOYUFiQWJMenVOWDVkVWpramRz?=
 =?utf-8?B?amZHVVd0ZEpaRW1YaEZkemF2bys0WWhxak1LV1dXVkoxTVA5djVOdC8zYS9y?=
 =?utf-8?B?a1QvUjB5dWdoclVBWFl0MVpndFJHN1RCWTlXbVlCcXd5UWVhOGxpZDlBQnhR?=
 =?utf-8?B?SnJtNW04Ni9hSVdjTS9yNWV0VVFZc0FreWd4WlNTT1lLdWtsWXM4T2taM3o5?=
 =?utf-8?B?ZUFsMFdxK3pOOWpGbitBeHhoeTlpWmduZFV3MnVrb0VzUmtjeG5NRkRnMVZO?=
 =?utf-8?B?N2xqVWkzVjVWcmFzci9Ja0g3RUdWMldqMTJrK2Zhbm9oYVRrbGt6anZDUU9p?=
 =?utf-8?B?Mms1bElZWjBPZVc3RFZTeTJWZGlIMmg4VUx6SHBIZkx2RnZ5R3pnbVVoVnN5?=
 =?utf-8?B?dGpGT2hQaDMzb1NVZHlWRk1ETDAySXIwcm9POVV2czF1MXU3UTJSVTBmWHBV?=
 =?utf-8?B?VHpQVDMxUnhzOHlxNVMwSmNlNDJtZTRUeXRSZUthOU4xMWNvQ3NtTFZKY2Rz?=
 =?utf-8?B?YXdwY2hkUUZyVXJHYzlTS0M4bzdSWUVWVDFUTmpWcmNvRHdhUlZUSFlMMlh2?=
 =?utf-8?B?SzJuNlZLT0NGSU9pWVJTMHdwcjAwSjBvLzg4SldjZ2RObk1UNnpoOTVIYmxq?=
 =?utf-8?B?M0w2N1Y1WmtYWHpyVVlJZFlabWZpRjNnTWlsbGE4WlhDU3pLSmpsQjB6eFJx?=
 =?utf-8?B?RWhyMEVtZzZ4Wnp3UDRHUjZoQXd6M2J2L1kxdnlkU2c4ak9ZRjZENzJpWmwx?=
 =?utf-8?B?YlVPZHZscUpIMmdXaXJTMTN2ajFBNllFUHpCd2tNRWZlM25kWHR1L043aGVs?=
 =?utf-8?B?Rno4MmFGRm5Fd1BlUWNZaUVtazFMODRwL3NFbkRFUnl2andFcDl3VERXVDZB?=
 =?utf-8?B?QzVWSzFRSU4rTmpHNjZCblBFNnBmU1c0a0lBWHg3Uzc3SVZPbjVoK1FURjFC?=
 =?utf-8?B?dzg1cklSUEpnSGpSWVdzc1I0Rkg1dnNCSHBaMit2THNmYnFmcXpkUnhzRlFW?=
 =?utf-8?B?U1RpSmpjMTlOVmVxdlVXTElyUmloL3RSUnFYQUMrdnNDdjlWM3hFWC9ycTZ6?=
 =?utf-8?B?TzI2WXFudkxqc3ljY2Y4dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2MwR2U3MDRodzFoVTFtTWs3bzlkMktqK1lDd2tmZ0FXQVRiUitHSTJSZTgy?=
 =?utf-8?B?OEY5aThoN3NKQ3lRMGI1aTJ2SmhBU0JGOXRlU2lZWk85bWp0WDVLdk4xNlNI?=
 =?utf-8?B?MVNQL21TTEVZNVBYbHdna2FSY2lPNUN1MXYrdGxrVXYyOFdWU2Z1Qmp1Q1BM?=
 =?utf-8?B?akhFQTROTjhKa2hGSzdZTGNqNHdicDNlYjVjTEt5bGdrN0FkNmRKQlFHYWNh?=
 =?utf-8?B?bGxERGlWdzFXajk3dEJiejdNZU02bms0OVpUQUtVU3pYT0RLOENSYlhtRmVi?=
 =?utf-8?B?dVJCUC9UR3piZEtDQTNVN3N6UHdjZ0F6UkFkK3VhVlVMY0Rmb09zQ1Buc1Uv?=
 =?utf-8?B?ZEU3RFdXRHltbzB4NXRialZYVU96Y3hTNmhwa2p1WGtJV1ZqbE5YZ3hVSVB0?=
 =?utf-8?B?Z04yR0R1WWhLNXNIdXhhL292MmZsYnljbGxPVWl6bXkxc0F4K1o5M0gxS3F2?=
 =?utf-8?B?WUNQMS85SzNUNWgwR0pZaGhKUjI4ZFdJU0J2ZHZmZC92QlM1d2drZStHTE01?=
 =?utf-8?B?b0h3K2JsYll1QStzQlN4YmFYdDVsdzBhN1ByeGpUSWl1QXFxNHVva1U2MlQz?=
 =?utf-8?B?QXF0N2ZyRUIwa1d0bGN6QVBsSnYzUGxTaXJTa2RRbnVLbUpSSUEySmowQk9B?=
 =?utf-8?B?Y1RuWFZwR2Jaa1VLT28vdzFNTnorWjRzeDRZakpEcFlBTVY5UDgyVktNckhv?=
 =?utf-8?B?OU5wRmE2aDYyb1RWNDB1eWdJMXhkUlpwc2NNNVhwNkZwc0tSa2g3bXdlbUQw?=
 =?utf-8?B?bnNvTG56ZjdSbHRCTllhTjludEFzVjFOWGF0WmkwZHAzSEN6RmtDOWtxdTRn?=
 =?utf-8?B?N2hId2p4N0RGRTZTbUJsTTJQMTQ5MzVaWTFKU1FBVDZHcFBHbjdSeEZiWjJB?=
 =?utf-8?B?SDVsUHNqTFpBTEFMNWs4SU5Jd0NXTjRSeDJLVDV0Y3FTVWs1SDRBVFp6Yk1M?=
 =?utf-8?B?QnpRc0ovbUF5RG5YbTNWK0hZMXNjT3RpaFdGVGhGZlFoelRWajMwVDJHTnlx?=
 =?utf-8?B?UWV4M3ZtL1UwMlNlVmJ4ZHNZSDFydjRPVnhHcGkyNTg0YzZUK2JHNTlEV1py?=
 =?utf-8?B?RXBwdHZsUVRVbEJHeW9xK0kwUFlJdlpvYVI2cnpiK2J1RktUK0dTNFJla3VE?=
 =?utf-8?B?YkExQ3E5blVVRUY1RldDRTZNSFRWdXlhRGhSdjFBS0w3eXB4NzJWVWVPdlBp?=
 =?utf-8?B?SUN5QlZyNnpDTkgvaFFCUlB4Vnl2MU4wenR0Z1RmbjVOeXpkc1RBd0JZR0tT?=
 =?utf-8?B?VHpOcEh4SkxaakcrVDhnRzNUNTY3N0hKajJlUFdMb09IQjBWbjNNdVhxelRE?=
 =?utf-8?B?SXBNaGRUZWhWSHNyU3p1QkdCNUFrQnFZTFNjRE9RNzFKRi80YTFHdGFoUS9p?=
 =?utf-8?B?Rm9WTWYzdW1rbkhIT0ZrOUM4ak5pL21uZ3J1RVltaURvWEJKZmFzeUcyTzJi?=
 =?utf-8?B?bXF0YVdvQy9CcnRPS1hpY0c5OHk0RVQwVlpNb0w2SGw2Y3pwYUVqcDJnVm0z?=
 =?utf-8?B?RE9YMDdCYW1VbzFkZnp2RzBpemxIbmpkNjFNcUwwOXRENklodHFQUmJtYlF2?=
 =?utf-8?B?SmxCNFFxYjB2bVhGYVZqV09zdnBTUGZjL0ZaUzlIRzBCNHpNSVNCN080RjB3?=
 =?utf-8?B?Q0diRk1kUlBNWFlwU2QrUkxhWnFXS2IwR20xUHZKZzZpaTllZmsxNlBvRFJa?=
 =?utf-8?B?Y0l3aHlsQzRFbzBPOVBzWVpCem9SSkVia3Z0TGFBR1hWMzFmekVVeW9OWXI5?=
 =?utf-8?B?RGpqS3RFN0FaWENnSzU2aHNDR1B6dzlEdGhIWlhPWUpJZVVQaWxscHFjZHJN?=
 =?utf-8?B?dE1vcDZ1UkZicHlsRk54K3lHSzBBOHRvTUxOdzFINERTcCtSQ3pUcEMrMWpY?=
 =?utf-8?B?bjJFcDF3ZmdJZ280czkvU0J0RzZkVWF0d2JoMkxiNFJmeEc5c0dvMzlPT0Rk?=
 =?utf-8?B?MWVabDU2OGFxNDFISTdNU25Gdk9rMEFiNjhQdDIrMEk5TEtiSzltUVFtcnV4?=
 =?utf-8?B?ZXRnb1NXQkJndUhOQTlBN0ZsU3hvYVFSY2hqNHVXczlnN2JpWWhnZW5CaVNz?=
 =?utf-8?B?Ykt4SkxJMVhtQ0h5S1FqODRBWmxXeEUxS09hUW1MWFJhZGI5VDM3QnRnYXlO?=
 =?utf-8?Q?KY300aLd7ysYnh7P9gW5sphrZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b494590a-1300-4074-d1a2-08dc6b7a4c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 14:06:58.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CAw4/603YSmx13cjjxRKd3thm8T+GUq7Tb336EHitjo7sV0tDau9+zTpqHXrL4ZXWPEt02TQjLJPK+RR6hzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7398

PiANCj4gSSBjYW4gc2VlIHRoYXQgbm93IHlvdSBhcmUgYXQgdmVyc2lvbiA3LCBpdCB3b3VsZCBi
ZSBuaWNlIHRvIGhhdmUga2VwdCBhbg0KPiBoaXN0b3J5IG9mIGNoYW5nZXMgYmV0d2VlbiBlYWNo
IHZlcnNpb24gb2YgeW91ciBwYXRjaCBzZXJpZXMgc28gb3RoZXINCj4gcGVvcGxlIGNhbiBzZWUg
d2hhdCBoYXMgYmVlbiBjaGFuZ2VkIGJldHdlZW4gdmVyc2lvbnMuIE1heWJlIHlvdSBjYW4NCj4g
ZG8gaXQgZnJvbSBub3cgb24uDQo+IA0KDQpIaSBIb3JhdGl1DQoNClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcuIEkga2VwdCBoaXN0b3J5IGluIFtQQVRDSCAxLzVdIGluc3RlYWQgb2YgY292ZXItbGV0
dGVyLiBJDQpXaWxsIHJlbWVtYmVyIHRvIHVzZSBjb3Zlci1sZXR0ZXIgbGF0ZXIgb24uDQo=

