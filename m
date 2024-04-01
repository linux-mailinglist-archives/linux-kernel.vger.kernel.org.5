Return-Path: <linux-kernel+bounces-126425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468EB8937C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23A21F2151C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF535522E;
	Mon,  1 Apr 2024 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XP3jYYNk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZqEFkxQe"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851C138C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942454; cv=fail; b=X6tRVvE1GZtGyJk93648exvzmCWe2KfO0c2BGX1e5MuNUspruLZWLIUiyV2RjeiAkVyIMaiX67jA5QVOxEOtGT7rKxZUWPL/AKphDjhzGIdJInRrp2p6C+0Txzt2SjNinaM619fMt9ZgiU6YtBFnoM3vCfQ/8JGPQc22NBu568g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942454; c=relaxed/simple;
	bh=Whtb21+3zyjII9cnnylrL7ieDPHRI5l8dx2WAVkxkPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rA0YQ8TgUfo2sBzOx//ztgO1ktH9xL0NinFNGtgppZSwHZtb8HVsaYLCXtar40hRzeo0vqIx+GxsT2Gw0FYSqs/2uRVISP+2cA0478arT/llig7ToDpO1hJapYlikNpJuQtEjdfT7GZMih74feY0ez8lwR7f9oMriJEFa5XaVyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XP3jYYNk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZqEFkxQe; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aebf818eefd811eeb8927bc1f75efef4-20240401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Whtb21+3zyjII9cnnylrL7ieDPHRI5l8dx2WAVkxkPs=;
	b=XP3jYYNkYFHZ9wtcUngDGWjba3PTigdjixk4HJjsAhndncVmi7g/Cx/9zxUy/TjsvgwmJ2dWXYJu3mwwsDgvLN2LALwfUUObISGmr46sJl/y6M8Nok8C3d4f0/6KOczHX5nkNSeKYgA9XS2RMIr41SoxZIBkKJF2+dr860Pb788=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7bafe892-3064-469b-85e6-b65a70ebd242,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e6cda885-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: aebf818eefd811eeb8927bc1f75efef4-20240401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 575805349; Mon, 01 Apr 2024 11:34:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Apr 2024 11:34:00 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Apr 2024 11:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA+8dlQLKAjNlU09rJmKMRt/U50fDAnNv5Ef0zCPLC3hgWmeZKkr2sDN7GIhv/JjlaoSjEv4Wyd4Ueo21Sohjh0N58h4G95brYywNjscUBvjbjzwug5zmqogvU0CebslAcP2GYzHuXjl0Y4yOp+ep7wilwmshkAw1s1xr5elPn3TcIASHqegUsfd3nswrTJ1bweFU87j3hiYU6UyrDjg8YUfGBeenJikPPmmb0PsEbuMiGiKf3qVq1qVhXP6pXVwZrYZA3gtTx2pgPnK0tEHyaFqZcVMJdwTMIFro9W4wl1BeJU4MSLLdPHy5AU1O5lGAWUcyLFeBJb3zzUJpeLa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whtb21+3zyjII9cnnylrL7ieDPHRI5l8dx2WAVkxkPs=;
 b=TVLuiSoA6cx0hT0J3xQzOSe1ndlaTZXvzgUC8hdbI1dPwCgXJFz59BV1GWYqKk+LkW0wiDh5Lz4VQ5ECqz+iPhgdfksZumZP+GuSHNaHRlvCfgMf+Sy2VtrHxwXjpUZFt6uzgoqISANTY0a6wJDcF96mYAQfWxJdLgpzbbkykJfK92HvBZ911V0fMn8skavUucdDlBfoK1sS85sZ5AtPHM283QzlU4FQgqC7f/B9LH3FUVaIJVZGX7hT1t5ZRxrfpAXBkAIwAgrzEKwYA1tBQA2uegZogjgNwOAXkuYCEG4w/03pAwEMvKvcDUUyRHtiBqMxrH9lQr1mnWAlNYfLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whtb21+3zyjII9cnnylrL7ieDPHRI5l8dx2WAVkxkPs=;
 b=ZqEFkxQex19PV0/RL4GidQmJnUjHYmEVx9xOIkTSciQPso3iPEBPetRjACsaHk4jWiZjkjUzlFlm0DYVLvdS1Hc9SJxxF74B9TllUQ7kesp9n2tSkraKkT78LNYm07FaFkKbdaoVgQUswvE2oCaePXsk5e0M1qTujzq3T1rMRGU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB8222.apcprd03.prod.outlook.com (2603:1096:405:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Mon, 1 Apr
 2024 03:33:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 03:33:57 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "dianders@chromium.org"
	<dianders@chromium.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?=
	<Nathan.Lu@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Init `ddp_comp` with devm_kcalloc()
Thread-Topic: [PATCH] drm/mediatek: Init `ddp_comp` with devm_kcalloc()
Thread-Index: AQHagSxG31DVhHPs1Emb0DDHRAE1drFSyIEA
Date: Mon, 1 Apr 2024 03:33:57 +0000
Message-ID: <f5b597e94de9150ba96e32cc9764bc09b2c298de.camel@mediatek.com>
References: <20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid>
In-Reply-To: <20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB8222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Keml/IMm8akNTqW2QRw1g+Y1yPtGzPhahXe+trd3XRcO1Ne2aaRlpKnslwH16gjVguoTZNlGUdSe4grEhYtskYUH7Uo+fLWN3JBQ0DWdBk0+AhyBXLJh0gyYGFGYK7JPCEOGtYm119u3yjI8/OT7r1EICZCG7/LakMwcjQOneSQ6/2yPSivHK9URNrlt7W2vkjM3T2vOoJIlW5fItlh/kja6fRsMPSdLu8XaFL0lsm7K/2SdUyD2SIY7Fsp2qu/HCHqQ0XzSbx1hymH1NekXXn/EuQGG7CIj/nw1C1b0Hthbc4hpGKsetSjHBHkA75yZ6eBA86/nSsYtUvo9DwuFcl1DlCVokWjt336NGkb5/cIZzSxSx2MUkk8NukWUPswLrVDzHEVCCmdQKk5Vw7xF9cn1ABixUVGqxf3Ai5rgZo8Y3iEBvcf/bOBXBNQpK2nDLx91kTu11ZlCuSFYi5FmFGHXsebSDGxzzABidlIES6jyM3nOfvHGi+AUGCQWWxyx4HDiA3Bu9apkDeNpOpw52vYM+f26JhPARagGx0+DjndJquP0RMwuGsZOuVCAy8D8GZMsbQsauBTXzOcEqR8aDkAW//XnBbMw+C+VQ/6U4h0Iic3OLO2dHFw/t6bbKW2MlQuPO9D9JjqrKrha6ZM7dHAoTgYBgXRCYSq5WVRd+ck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2E5NEFtUTJKdllxNVpyMnBocTQ5WTVKb2x1dWphSE9YdWNjTytjU1VHSC9J?=
 =?utf-8?B?RlM2dXJmR2p4a1c3YkVuZ2hNWWtzVi90RklhYkN4QllFY0kvdjJsM1JGZTAz?=
 =?utf-8?B?Si84V1h3S3RRb0hmVXkzcnI4RktYYU9wTHJuRndRUDMyekJWTUZ0ZWNONmcw?=
 =?utf-8?B?bUVjSlBaRFF4SEwvSGhhZ2VNRmZHa0xDNTlhdnZWTXltY1FOQ3NRSkJQVU9z?=
 =?utf-8?B?bndGY1RvRTFMTitTeEVYeGEvT2FwMU8yM3p5TXErR0tWdndMYVl4Mlh2NmlO?=
 =?utf-8?B?Q3F4N2lDMERRb1ExWVh0K0w4TEV2dE05aVFNaWZTSHZ0aW8vaDRwNjRPWmI3?=
 =?utf-8?B?N0VLTXljKzdjZ2RSaTZMRmxkNE96QnVic3NtejBnQytCeUZaTFlabEVGSUtz?=
 =?utf-8?B?dE5HT1NlN0JINTZ4RDRsQkJlMURuUlA1aFZ6d0d5b0ZiZ2FsRldzQURCN0py?=
 =?utf-8?B?UmI3d1lJVEhsSjZQZUtqL2QzNjhaK0ZtV2RySzA4aVJ0Ry9LWmtFWkdoWSta?=
 =?utf-8?B?blhyVk9WK2xCTHEwNkRML2dnZVlRU1FYS2xtK1N2VkVTcDc5WnI0ZTk5NUJo?=
 =?utf-8?B?UytzSktBajJ0M3NOMmlUTnJjeklXeDRWME1WUzBRSGFFdG12bXdVSExLNE5L?=
 =?utf-8?B?VG5SaUxWazJjTVVaczhtKzVxVFB0ZHFQUlF1UzIvU21CNjdiOTM0NU1XKzlE?=
 =?utf-8?B?K2ttQ28xbldmRVZwNXhDTk8zRmM0N1dOL3J5eVc5NzVsUjRWSWZZdkdBVG1U?=
 =?utf-8?B?UXpYZXI0UTN3cXNLQU9xbnZTdnVyLyt0SDhEUm55M0tyRktQVmtGd3pCbnVs?=
 =?utf-8?B?TkZBN3FVL0NLZW9RMlVHbXFHWmNLZUdzZmhTd0RlWXlCKzFNL2JrNUlXclRR?=
 =?utf-8?B?bGtRby8waEhQMndKN3c5cFY1Y3VOU0JDdW1oY0h2MExDQ3NPUXFlbjcxTUx0?=
 =?utf-8?B?YitBWVFadmhySjN0U3ZQYnVGMXJ4dUpnMzRLMllHZm1FWW13NHJ3MnhNRGZI?=
 =?utf-8?B?ZEo5aDlYR3NRZDFEcWxPSUFNdDh2Q1FmMXF2dWJPc1NWdW1pT2ZybjRNUjJ5?=
 =?utf-8?B?VUgrbG41Yjk4TEFPMlBTV3VJSkJ1YjZWOGI4eWhFSEdvcEFPalBpQVlIbGtl?=
 =?utf-8?B?Sm5qcUlhUVRQM1E5YWVoRUxQN3Z1dFJtdW5KWCtxTjgwMFRCU2J1RzRRVGs1?=
 =?utf-8?B?TlZVVWFUNGJYVUNmYkV2TCtmaEYzbXhlWUZRSGJZbXhlYzVlaG5kS0pWenVa?=
 =?utf-8?B?SmZQRGIvNzh6US94OFdORVcydXUzenBhaXJsbkZMNzNtR0J5NzNqVTFzRmZn?=
 =?utf-8?B?MXhmQXYxNGEvODJhaDNDVk40a0lJSTFJM25SWFRZekVTeHpVWVFOT3BLY0xz?=
 =?utf-8?B?NmJkV2FOUFdGMjVHVjZSZnA3SlVoYnBZeTJJc01WYVRUZm9mV2dDM1diRysx?=
 =?utf-8?B?b2FQdk83ZnpMOG1wUUZlcnIweTJIN0FHdDYzNzFlTzRjYWhVMUwzQlJSMWxE?=
 =?utf-8?B?OEFPYnl2UFprT3NXOWtHdHVnelFaSU5xUEJicmtXL0xXbngreXJJcXdiTjlj?=
 =?utf-8?B?djlDZjE5R2lzUjlXTWd5MnR2OE5CQ0taQWljazlnY09WVnZ5TGlRZnI1eXVO?=
 =?utf-8?B?UThqZmdaQU9QdFFDWUcrV0h5Z0JNTUhWNkZ3ODRUSHlMTWNXRFhxaXQ2U0Ur?=
 =?utf-8?B?eGdMSTVpNCtFVUo0Qk0wMjdHUVZsdGpnbVFzbzhia3lyUlZCckhldlhEenBP?=
 =?utf-8?B?US9TaUdKNnZ4WjFxMXdSNkl4VkxFUDFPWU5mUXRyQ2FUSEhodDl5WVpOQ1dD?=
 =?utf-8?B?cHNtM0R6VFhpdDlzS2d6TzMwK2RxakFxRFZJV2JMRHBzb0FYOUpyZ1IzSTQ1?=
 =?utf-8?B?eW1PVmw3OWdJSThPQnZHb2YvVVAzaUVqVGNhMVlYQS82cTduS0FYZkNITTdG?=
 =?utf-8?B?WERQS3dVbU5yelUvZmJEenlRTWJLTks1T3kwRkFOTmhWMll3VTM1ZWtnUjZU?=
 =?utf-8?B?SUJQMWt1L3JkblFFUzdhU2VwdjFUWXkvRkp5a1dKZXlFZjBydFJNcWhLTkRS?=
 =?utf-8?B?djZhbTQ3N2E1d29VMnBLeis2RlJlUWdtb1JVRU1ZbHBaUFlnYUVpTElYbmNm?=
 =?utf-8?Q?bS/zzHxjDDu+WQIKrZ+1G9a2v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <422F6C01D22F3C49B012D4ED26FFA8F9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe629ec-e182-4760-14ca-08dc51fc905e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 03:33:57.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrA1mfgZ58ALM/aaPbeXn2U4ekUWAMZlG3yvGfynCsgTPiRMa4VSz9/IB8bniHK77VSM7+6T2a1Ma/Z224zkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8222

SGksIERvdWdsYXM6DQoNCk9uIFRodSwgMjAyNC0wMy0yOCBhdCAwOToyMiAtMDcwMCwgRG91Z2xh
cyBBbmRlcnNvbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbiB0aGUgY2FzZSB3aGVyZSBgY29u
bl9yb3V0ZXNgIGlzIHRydWUgd2UgYWxsb2NhdGUgYW4gZXh0cmEgc2xvdCBpbg0KPiB0aGUgYGRk
cF9jb21wYCBhcnJheSBidXQgbXRrX2RybV9jcnRjX2NyZWF0ZSgpIG5ldmVyIHNlZW1lZCB0bw0K
PiBpbml0aWFsaXplIGl0IGluIHRoZSB0ZXN0IGNhc2UgSSByYW4uIEZvciBtZSwgdGhpcyBjYXVz
ZWQgYSBsYXRlcg0KPiBjcmFzaCB3aGVuIHdlIGxvb3BlZCB0aHJvdWdoIHRoZSBhcnJheSBpbiBt
dGtfZHJtX2NydGNfbW9kZV92YWxpZCgpLg0KPiBUaGlzIHNob3dlZCB1cCBmb3IgbWUgd2hlbiBJ
IGJvb3RlZCB3aXRoIGBzbHViX2RlYnVnPUZaUFVBYCB3aGljaA0KPiBwb2lzb25zIHRoZSBtZW1v
cnkgaW5pdGlhbGx5LiBXaXRob3V0IGBzbHViX2RlYnVnYCBJIGNvdWxkbid0DQo+IHJlcHJvZHVj
ZSwgcHJlc3VtYWJseSBiZWNhdXNlIHRoZSBsYXRlciBjb2RlIGhhbmRsZXMgdGhlIHZhbHVlIGJl
aW5nDQo+IE5VTEwgYW5kIGluIG1vc3QgY2FzZXMgKG5vdCBndWFyYW50ZWVkIGluIGFsbCBjYXNl
cykgdGhlIG1lbW9yeSB0aGUNCj4gYWxsb2NhdG9yIHJldHVybmVkIHN0YXJ0ZWQgb3V0IGFzIDAu
DQo+IA0KPiBJdCByZWFsbHkgZG9lc24ndCBodXJ0IHRvIGluaXRpYWxpemUgdGhlIGFycmF5IHdp
dGggZGV2bV9rY2FsbG9jKCkNCj4gc2luY2UgdGhlIGFycmF5IGlzIHNtYWxsIGFuZCB0aGUgb3Zl
cmhlYWQgb2YgaW5pdHRpbmcgYSBoYW5kZnVsIG9mDQo+IGVsZW1lbnRzIHRvIDAgaXMgc21hbGwu
IEluIGdlbmVyYWwgaW5pdHRpbmcgbWVtb3J5IHRvIHplcm8gaXMgYSBzYWZlcg0KPiBwcmFjdGlj
ZSBhbmQgdXN1YWxseSBpdCdzIHN1Z2dlc3RlZCB0byBvbmx5IHVzZSB0aGUgbm9uLWluaXR0aW5n
DQo+IGFsbG9jDQo+IGZ1bmN0aW9ucyBpZiB5b3UgcmVhbGx5IG5lZWQgdG8uDQo+IA0KPiBMZXQn
cyBzd2l0Y2ggdGhlIGZ1bmN0aW9uIHRvIHVzZSBhbiBhbGxvY2F0aW9uIGZ1bmN0aW9uIHRoYXQg
emVyb3MNCj4gdGhlDQo+IG1lbW9yeS4gRm9yIG1lLCB0aGlzIGF2b2lkcyB0aGUgY3Jhc2guDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczog
MDEzODliMzI0Yzk3ICgiZHJtL21lZGlhdGVrOiBBZGQgY29ubmVjdG9yIGR5bmFtaWMgc2VsZWN0
aW9uDQo+IGNhcGFiaWxpdHkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEb3VnbGFzIEFuZGVyc29uIDxk
aWFuZGVyc0BjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiBJIGRvbid0IGhhdmUgYSB0b24gb2YgZXhw
ZXJpZW5jZSB3aXRoIHRoaXMgZHJpdmVyIHRvIGtub3cgaWYgdGhlIGZhY3QNCj4gdGhhdCB0aGUg
YXJyYXkgaXRlbSB3YXMgc3RpbGwgdW5pbml0aWFsaXplZCB3aGVuDQo+IG10a19kcm1fY3J0Y19t
b2RlX3ZhbGlkKCkgcmFuIGlzIHRoZSBzaWduIG9mIGEgYnVnIHRoYXQgc2hvdWxkIGJlDQo+IGZp
eGVkLiBIb3dldmVyLCBldmVuIGlmIGl0IGlzIGEgYnVnIGFuZCB0aGF0IGJ1ZyBpcyBmaXhlZCB0
aGVuDQo+IHplcm9pbmcNCj4gbWVtb3J5IHdoZW4gd2UgYWxsb2NhdGUgaXMgc3RpbGwgc2FmZXIu
IElmIGl0J3MgYSBidWcgdGhhdCB0aGlzDQo+IG1lbW9yeQ0KPiB3YXNuJ3QgaW5pdGlhbGl6ZWQg
dGhlbiBwbGVhc2UgY29uc2lkZXIgdGhpcyBwYXRjaCBhIGJ1ZyByZXBvcnQuIDstKQ0KPiANCj4g
SSdsbCBhbHNvIG5vdGUgdGhhdCBJIHJlcHJvZHVjZWQgdGhpcyBvbiBhIGRvd25zdHJlYW0gNi4x
LWJhc2VkDQo+IGtlcm5lbC4gSXQgYXBwZWFycyB0aGF0IG9ubHkgbXQ4MTg4IHVzZXMgYGNvbm5f
cm91dGVzYCBhbmQsIGFzIGZhciBhcw0KPiBJIGNhbiB0ZWxsLCBtdDgxODggaXNuJ3Qgc3VwcG9y
dGVkIHVwc3RyZWFtIHlldC4NCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYw0KPiBpbmRleCBhMDQ0OTljNGY5Y2EuLjI5MjA3YjI3NTZjMSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAtMTAwOSwxMCArMTAwOSwx
MCBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZHJtX2Rl
diwNCj4gIA0KPiAgCW10a19jcnRjLT5tbXN5c19kZXYgPSBwcml2LT5tbXN5c19kZXY7DQo+ICAJ
bXRrX2NydGMtPmRkcF9jb21wX25yID0gcGF0aF9sZW47DQo+IC0JbXRrX2NydGMtPmRkcF9jb21w
ID0gZGV2bV9rbWFsbG9jX2FycmF5KGRldiwNCj4gLQkJCQkJCW10a19jcnRjLT5kZHBfY29tcF9u
ciArDQo+IChjb25uX3JvdXRlcyA/IDEgOiAwKSwNCj4gLQkJCQkJCXNpemVvZigqbXRrX2NydGMt
DQo+ID5kZHBfY29tcCksDQo+IC0JCQkJCQlHRlBfS0VSTkVMKTsNCj4gKwltdGtfY3J0Yy0+ZGRw
X2NvbXAgPSBkZXZtX2tjYWxsb2MoZGV2LA0KPiArCQkJCQkgIG10a19jcnRjLT5kZHBfY29tcF9u
ciArDQo+IChjb25uX3JvdXRlcyA/IDEgOiAwKSwNCj4gKwkJCQkJICBzaXplb2YoKm10a19jcnRj
LT5kZHBfY29tcCksDQo+ICsJCQkJCSAgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFtdGtfY3J0Yy0+
ZGRwX2NvbXApDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+IC0tIA0KPiAyLjQ0LjAuMzk2
Lmc2ZTc5MGRiZTM2LWdvb2cNCg==

