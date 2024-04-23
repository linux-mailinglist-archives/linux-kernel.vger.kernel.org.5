Return-Path: <linux-kernel+bounces-154609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8C8ADE55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108081C2146A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F747A73;
	Tue, 23 Apr 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aBp1lj7z"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A51CAA2;
	Tue, 23 Apr 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857748; cv=fail; b=jhV/VRhZWvCXN0UZkZKbf/gpVkTHg1mk9FKdwi64ZghIM3CU/43myr96hEZZUFIwP8jg//jEEomN2QFvtNh6RLs83WaLbmmuq6GfXmLb1QOxsegl5Gz4Mv87ebNvUqvmH2FWhWv4VLNjZaZPq7jywwrGzAfSscRtshLXQzAao0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857748; c=relaxed/simple;
	bh=+y/35Q/AYih1JVY418gt9CaythVvnMSZ0HB4k0LzNfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gj5Q3eSyuHf0EPtCwJ60rnf4EXLrAoXiMzLXcVFLd0zEqqOKyiL9XAH4rNMRe8GvFMjkehFEsJMio1QlFw+zm+nFgTrotfKUUWWymF/Z6Qsu7hUSlXG88+8DsE7goRkmc955wo+VU8yf0OEoT0Zg2C3p98Ddkb9APU+7UcxVZFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aBp1lj7z; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR9FxWlhqLl6NCjbnZMQ9n0JHZ1sR0LUbVWsg67O8ykNsmWzp7iMA4Rk70XMqxufLmBrEe1dThqNCRN1V2E+rbj8mxcCz3cqQdUo1x2ASEoP7S66vmTHgUxOIbLdbAqhB8WNUVHpCovBrLPEmhLrAXpE/EEkRyS0yR46/zcKjxWgCxKieCBRRYy83ncA1c9hnSRoEe/xCi/kfUMMNjNBy3banKbGhtOcfyKHCLK9FjABGmF2/WiQve48mnSZ2t5jVm0aqqh8F9X9sd5GaPrn3hWgt02iXUCESkqY2PWRQw5PfvzF6fZXf1LDAtRXr4RHj+sE1HinskockqTSph6W4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y/35Q/AYih1JVY418gt9CaythVvnMSZ0HB4k0LzNfU=;
 b=cL2XPj+wytV1TnVMb17lVmcNi7jrB6GpZQgYquDMbFtK1HT6Uh+spk+HKhEO4no40ypPolfTaPfCEEHW6EZqKP+mFL/BG0cXK90smaWJD2pZTizkz4O1Er3ddDIaRm42kq72vibndop1Svx4dYX/AitbIbPiPeUR2pYQPbAHUZ/D9VJ1x0Pvtjd000EDIGw36yR5VsAOSaZrkCqkUo/FR0Ds6/hmcfiq1owYK8WP8YUAuhODLs0CI2nBQScTxK4i7iMxJ5Bk9XzKYmsYJ4PglpQjDtCKpoStKXW9MRT+1M4LQOWJ/gvMPq/VjvmYtykcak82VJbrf9IehAQmNTvRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y/35Q/AYih1JVY418gt9CaythVvnMSZ0HB4k0LzNfU=;
 b=aBp1lj7z0CyNrHw5lBDTd8rDr4OaTlRTsuH5LlctZJWRGYx+eI3oUggYE34ClQ2TOzIaqM+wtF+fw6w2Q/VxWZ4BdwMppim1Ng+lGPLx19RzyPIHAHOtw11OeBOcY5/nmmpQsU13PbJ2BHkrj5QDc/bgrBSPYUfHidPF7I1JinQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6898.eurprd04.prod.outlook.com (2603:10a6:208:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:35:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:35:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Claudiu
	<claudiu.beznea@tuxon.dev>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial
 console
Thread-Topic: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial
 console
Thread-Index: AQHalKXX7KDT/pNThEmks453iN5ur7F1dieAgAACDHA=
Date: Tue, 23 Apr 2024 07:35:43 +0000
Message-ID:
 <DU0PR04MB9417D8D052B09BC9FA58826B88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6898:EE_
x-ms-office365-filtering-correlation-id: e15de14a-ee1c-4d65-06c8-08dc6367fbf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWd2Rm54a25iTTlRNE4xOXRqNE1XTElDVGg4R0xzaWlEKzdtd3piT2FJREh5?=
 =?utf-8?B?aHdVMmtXUXc3MmxoYU9WT1hpQ3BiWlVqOWVQRWJHd0YwbXBKemdTV1pmOTM1?=
 =?utf-8?B?UTBmTzV6cWJQeU81OUtYNVBxc1ZjWU9GV0tJekNySjVZbStEaUFOQm94SEVV?=
 =?utf-8?B?V0hZYnUxSkVHcDhjanUxYTMvcStFSkRlejJLenNYa1dWcWVYWXB1Z0tVSm1p?=
 =?utf-8?B?WlRpRXlXQVBQbGZoVDdYbVJTUktCTFVnRk9KUTVvSEQ4WWVVWTE1eHdZd2ZP?=
 =?utf-8?B?eHE4ZURlWThUMVNmdDFmS0VSdVpFUll4K3BiUzlZYWtHa3Q1bElDUllCdGY5?=
 =?utf-8?B?a1JOMWtpY2ZRWVZFVGtsU3BTUm9heEZvQkZBZy82amozcTE5Vmo3QXFkRGxh?=
 =?utf-8?B?NS9JY1g4QXJuM2FmbVI5QTU5d0FSOTJpYndqWXREeUU0anA4RXFFWWd0VUI5?=
 =?utf-8?B?WXhFTmNYWkJ6alUzWUcrYmlvM1RrWThRak1tY2xYd2RuWU9HWUJRNDV1Qk84?=
 =?utf-8?B?Um1ERyttai9jeDV4R1JqMTh3ODlua3BhemNGS1l6RGRGQms3TjF6L1RkWUNY?=
 =?utf-8?B?QXFRMHk1cHJOQnlwelZWZzFvR3JSSEVaOWowNWJaUmQzWWw1NjFrR3JNdmg5?=
 =?utf-8?B?Z0lqQUl2VWlncE1KYU9TMFoxalhEc3BIbU5LWlB4VnFwNldtcHJ2WXFRcmFO?=
 =?utf-8?B?c0pMRXBxYXI2ZisrY1FoNWZnRmRKcExzRHlBK1ZGck9NUVJ4QnlPcHE0NURq?=
 =?utf-8?B?QzJnLzZvbktqRkJSUjZEOXA3R0x2VVlPaEFSc2NmWGExSTB0WWgvaFVGRjNY?=
 =?utf-8?B?REVIZEVEbkN0alhrUklQQTh6MS9pNmNaYW5VbUx5MzZGYUFjNm00ZXRCeWhJ?=
 =?utf-8?B?Z1MxSUh5M20yUkIzeTdUOHB3RkdlNXlhM0M2QmdWa0pyTnRCTUxNM0xWNWFw?=
 =?utf-8?B?bllONU9sM24rUzU0d2hCYXg3MFMvTVBFTEZPQ1ZhNlZIL1dKa3BqR0NxRlFo?=
 =?utf-8?B?alhUTklHMGJKUFZYb1VudnRvanBPL0h3Z2JvLzlCQ0ZDb09OeG9LQ3BzRWw5?=
 =?utf-8?B?MEwzZDNMY082YytzbzdiRkZkNWtFSHNOL0ViUCtHUzJ1UTd2cmxGZHlUS0k4?=
 =?utf-8?B?cTdmUkl6WnZTUXdwd2hIZWtXaTlGODMzMXBNekF6RzhQVkRPK01qU1hEOStk?=
 =?utf-8?B?dlNzdEdJUkZKWUlxOWoyUm9meElGeG0vMU1QYXM1UWtLSlFOYzMzZ0IzTjE3?=
 =?utf-8?B?Um84WTcrMCtmRHp6L3hCTDBmNnpsOHNyNE12VytHNmcyaTJqVytPM05OT1Vk?=
 =?utf-8?B?YVYwaDJGdlpteUZSdHhiNTRGdkZ4VXNERmd2d2t0SWltL3ZNWS9LT2RNYzRp?=
 =?utf-8?B?TUQ3UHRIR3M3QStqUGRBeEthOEpRMjR0K1E5eTdXQm4wSmd4UXJaTHlpZDVy?=
 =?utf-8?B?RCt1NTh2cmpzSlFSS21ZaVBEc1Z4ZmtTRnNKT0MwTXk2TkV3NStpYnhCV1Mz?=
 =?utf-8?B?TFVITVZyeXhFWmpmWk04RVQvVi84Vkk3eXFrSTFGUzRyc2JjTm92RUt5ZU5Z?=
 =?utf-8?B?L0RKU1B3aWFNWnJleXBVTm14OUhZKzJqVGcrdGpWNUQxVUcvWVB1NmZkRlM4?=
 =?utf-8?B?VHF4em1ZMEc4cWp4RWdVODRrd2N4OUM4YUJjVGxlekMxYU1uUkJyaHFSdHNR?=
 =?utf-8?B?RTZxWHFwRCtHa2pCR2V2SnZYMCs3LzNGWXY0SGI2VVFnWDgvVFF1QmN4dTIz?=
 =?utf-8?B?KytoZDk0cU82TXlKZnYrTG45WU5WQXN0cm1yZkdqMkZ3dkVMcWhOZnBKaEtq?=
 =?utf-8?B?eUpOaUI5d1RBVjlkT0w5Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmtZOEVZVjhpRkM1YndkZGtlUFpyMXBrelM1ZytCZkJJOW9PV2FmdG5FemYr?=
 =?utf-8?B?ampvbFNydWlNaDU1RzBISVQ5NjlzYlBFbGxFZFkvUGhzQVRJc21IWmZxenBO?=
 =?utf-8?B?YjF5MkdUaDBYN2xzSWVKWlRVN0xhYXJnZE51aWtVQkpVNGNEcTJMK1VyQVd1?=
 =?utf-8?B?NUM4cmx0VmgxRWdsM3BzS21xL2xJUEp1Z29DaXRIdkI4cTdCWDVhalNoaUZK?=
 =?utf-8?B?b2VTOVg0SDA4RTlka1pKVEtSKzF6T0U1R2Y0WTRQVTZoY0p0TzlIVFdhTGMy?=
 =?utf-8?B?U3dnT3dMc0tjNHl4SVE3eVUyYWk3RkJ1ejNnR1AvNml0ZGU3a1lJejM1bEx1?=
 =?utf-8?B?OEg1VEcza3pxRko4OTdoMmRhdFVBSlpMZWMwcyt1b1BCMzN3WTg5N0xUSHJp?=
 =?utf-8?B?MGtic20rUmxXMVZVZi9sTU5wM1lCT3FVZkpSNStvUlVWcTd1MEpkai9vMG5N?=
 =?utf-8?B?OGNKdFcxakhqMkJvRlFBRmt6d0J6c0hIazJXV2JwUUpOc3Z3RWc2S3ZVeU5W?=
 =?utf-8?B?NU5EQUc3ZGFSTi9zc21NYVQvbmtZdkh2anpvUnkwcmZ2ZUFiNVQrYnp2R0p2?=
 =?utf-8?B?MzR3aDQ4bUlBK1pnTGZJbUNLRkpuS2VHUGxKMGNKNCt2NmZHYlBFMHYwM1pH?=
 =?utf-8?B?UmlsRnArMWFlNVFJbWdJQmh5aTErUUJOeGluRFlqRkJrMkpTS2s5ZTF4RGx6?=
 =?utf-8?B?SWNZVGtaTmxPUXpkdncyRmhRZTI3S1hEdFU5N2xITElwQUd1WE10TEFOU0VZ?=
 =?utf-8?B?YWpZT2pTMXNXaUF0clZkN2NVdnB1bWY5anh1VjEzc2twK3VkYVhuTEpoN3lq?=
 =?utf-8?B?djUrSStSK0UxZTRMbXd3eFNyaGg4b2grWWRQbFF1VWtzbG1yN0FCY1hzUzA0?=
 =?utf-8?B?TFZMbHp0QVl3a3BDUVg2cFl2NExWR3NjdGFicVVrWWd1L204WXhjdUJ6TTJD?=
 =?utf-8?B?Q3NpKzFXY3IyVW56eGk2Zm9BbmRhQXRNaEhVYlQwekNKMFFHVWdBaFZJdmlj?=
 =?utf-8?B?cnlCQjltMUh6bk81SGw5MUE1UXNCdjEraUJMZ3d1ckJHcGQ1ZE8rSWoxWG8w?=
 =?utf-8?B?SFBZYnZCWWpQK3pKb0dzUmpoekFhaFpWL3hKazk3KzdnYVVETXU2TWNXOFpS?=
 =?utf-8?B?MFdSSjFLUzF4VWVCUGNxa0FRZHhOaXdPV2R3SmlNRTVvcHZnL1F3OXBHU2ZG?=
 =?utf-8?B?YVo4eHlmTUJiT1gzaWtUQThOSXRVOEZSQWJyeDdId0Nrek5jR25xVUdMQ2J4?=
 =?utf-8?B?RjQxTCsyOTE0YVNEME5OTVdkdUtxYjhFWG1McHJ0MytsS3hkbDlqTVVmaThG?=
 =?utf-8?B?QkZFNXhUbnVzd215R21jNHNCaFMyUk15Ty96Wm1rR0dFSFpsZEpPdWc0UktD?=
 =?utf-8?B?b1BYcU9xTlpFRm9WczBwZGU0TVBDdmU3RWxVc3duM0hVLy9La1VvZng0dzZX?=
 =?utf-8?B?ejRpVXkwWjlURFZZRkNFekpRTStaMFIrbE9kL2lDSU5Wb3h1ZzEyN2NDMWxj?=
 =?utf-8?B?WU4zNzNrZEc5TVRZUkE0TW5jSGM5bWlmZ003dnlaS3hRNTg2SEZqWk4xVHFl?=
 =?utf-8?B?akt5Sk1UOEJ5cHlyNlJVcWkvdHpKU2NjWHUwS2tDSDdmNzAvMlIxYXNKWVRB?=
 =?utf-8?B?WlgzSWVUK0RzSndLN0NXd2l3bWN5bHRFWmZYYUo4TmRQZHlnVHNFRVJJeUFy?=
 =?utf-8?B?VUZsSGJvRnpSWXFVOG81MjJYY1NrM3lhMkx2Y2Vyb2JxVEZPNnN6MmpTSW82?=
 =?utf-8?B?MVMrUDRPUENmSFpjeGxYcG1EOG5KODJJUHpXZ2pVWXd3UU91Y2hkb1dnTCsz?=
 =?utf-8?B?aHNCNXZPckdxQ3FZdGt5Q3dQczdoc3JvaEkyS29NbUJSYVR4elRhM0ZPai9a?=
 =?utf-8?B?NWtWL1I4UVIxeHovUTJqM1poRkpQMVd0S3ZnamorQzUyc01MTHN4YU1KMTRr?=
 =?utf-8?B?SnR2RU5acnVJQlBkRXE5NndwSW1QQjc2Kzl3MXRPWDN1eUpDN1lHSGdvQ3Jw?=
 =?utf-8?B?R2FMT3lMOUVCY0pEQVpreGFDb1hFbzZaeHZsMHRjbFU2bzN2RkRFWjNpalhI?=
 =?utf-8?B?VTNrQ24xK2xiQWp4YVUwcGx1cm9yTjFNTWorWC9yV0dMOVNFRTIrWkVHOUVE?=
 =?utf-8?Q?K0/c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15de14a-ee1c-4d65-06c8-08dc6367fbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 07:35:43.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+Q6w8RKB7IV1iZ+4P/RNks0H5MHLChHQuuvDsly1HNyCtPxv/j8B/y4nttKAzFVpQF6G4ogh/J6USQwAaoKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2VyaWFsOiBzaC1zY2k6IENhbGwg
ZGV2aWNlX3NldF93YWtldXBfcGF0aCgpIGZvciBzZXJpYWwNCj4gY29uc29sZQ0KPiANCj4gSGkg
Q2xhdWRpdSwNCj4gDQo+IENDIFBlbmcNCg0KVGhhbmtzIGZvciBDY2luZyBtZSwgYnV0IEkgYW0g
bm90IGZhbWlsaWFyIHdpdGggc2gtc2NpIGRyaXZlciAoOg0KDQpUaGFua3MsDQpQZW5nLg0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gT24gTW9uLCBBcHIgMjIsIDIwMjQgYXQg
MToxMeKAr1BNIENsYXVkaXUgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gd3JvdGU6DQo+
ID4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+DQo+ID4gSW4gY2FzZSB0aGUgU0NJIGlzIHVzZWQgYXMgYSBVQVJUIGNvbnNvbGUsIG5v
X2NvbnNvbGVfc3VzcGVuZCBpcw0KPiA+IGF2YWlsYWJsZSBpbiBib290YXJncyBhbmQgU0NJIGlz
IHBhcnQgb2YgYSBzb2Z0d2FyZS1jb250cm9sbGVkIHBvd2VyDQo+ID4gZG9tYWluIHdlIG5lZWQg
dG8gY2FsbCBkZXZpY2Vfc2V0X3dha2V1cF9wYXRoKCkuIFRoaXMgbGV0cyB0aGUgcG93ZXINCj4g
PiBkb21haW4gY29yZSBjb2RlIGtub3dzIHRoYXQgdGhpcyBkb21haW4gc2hvdWxkIG5vdCBiZSBw
b3dlcmVkIG9mZg0KPiANCj4ga25vdw0KPiANCj4gPiBkdXJyaW5nIHN5c3RlbSBzdXNwZW5kLiBP
dGhlcndpc2UsIHRoZSBTQ0kgcG93ZXIgZG9tYWluIGlzIHR1cm5lZCBvZmYsDQo+IA0KPiBkdXJp
bmcNCj4gDQo+ID4gbm90aGluZyBpcyBwcmludGVkIHdoaWxlIHN1c3BlbmRpbmcgYW5kIHRoZSBz
dXNwZW5kL3Jlc3VtZSBwcm9jZXNzIGlzDQo+ID4gYmxvY2tlZC4gVGhpcyB3YXMgZGV0ZWN0ZWQg
b24gdGhlIFJaL0czUyBTb0Mgd2hpbGUgYWRkaW5nIHN1cHBvcnQgZm9yDQo+ID4gcG93ZXIgZG9t
YWlucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90dHkvc2VyaWFs
L3NoLXNjaS5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zaC1zY2kuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2kuYw0KPiA+IGluZGV4IDk3MDMx
ZGIyNmFlNC4uNTdhN2YxOGUxNmU0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zaC1zY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2kuYw0KPiA+IEBA
IC0zNDQxLDggKzM0NDEsMTIgQEAgc3RhdGljIF9fbWF5YmVfdW51c2VkIGludCBzY2lfc3VzcGVu
ZChzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldikgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBzY2lfcG9y
dCAqc3BvcnQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPg0KPiA+IC0gICAgICAgaWYgKHNw
b3J0KQ0KPiA+ICsgICAgICAgaWYgKHNwb3J0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICh1
YXJ0X2NvbnNvbGUoJnNwb3J0LT5wb3J0KSAmJiAhY29uc29sZV9zdXNwZW5kX2VuYWJsZWQpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3NldF93YWtldXBfcGF0aChkZXYpOw0K
PiANCj4gZGV2aWNlX3NldF9hd2FrZV9wYXRoKCksIGFzIG9mIGNvbW1pdCAxMGJiNGU0YWI3ZGQz
ODk4ICgiUE06IHNsZWVwOg0KPiBBZGQgaGVscGVycyB0byBhbGxvdyBhIGRldmljZSB0byByZW1h
aW4gcG93ZXJlZC1vbiIpIGluIHY2LjYgKGFsdGhvdWdoIEknbQ0KPiBzdGlsbCBhIGJpdCBwdXp6
bGVkIGFib3V0IHRoZSBkaWZmZXJlbmNlKS4NCj4gDQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAg
ICB1YXJ0X3N1c3BlbmRfcG9ydCgmc2NpX3VhcnRfZHJpdmVyLCAmc3BvcnQtPnBvcnQpOw0KPiAN
Cj4gSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbWFrZSB0aGlzIG1vcmUgZ2VuZXJhbCwg
YW5kIG1vdmUgdGhlIGNhbGwgdG8gdGhlDQo+IGV4aXN0aW5nIGNvbnNvbGVfc3VzcGVuZF9lbmFi
bGVkIGhhbmRsaW5nIGluIHVhcnRfc3VzcGVuZF9wb3J0KCkuDQo+IA0KPiA+ICsgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiANCj4gSWYgdGhpcyB3b3Jrcywg
d2UgY2FuIHJlbW92ZSB0aGUgY29uc29sZV9zdXNwZW5kX2VuYWJsZWQgaGFuZGxpbmcgZnJvbQ0K
PiBkcml2ZXJzL3BtZG9tYWluL3JlbmVzYXMvcm1vYmlsZS1zeXNjLmMsIGFuZCByZXZlcnQgY29t
bWl0DQo+IDMwOTg2NGRjZjkyYjc2ZmMgKCJnZW5wZDogaW14OiBzY3UtcGQ6IGRvIG5vdCBwb3dl
ciBvZmYgY29uc29sZSBpZg0KPiBub19jb25zb2xlX3N1c3BlbmQiKS4NCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IA0K
PiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29u
dmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIu
IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dy
YW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

