Return-Path: <linux-kernel+bounces-144813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABB8A4B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D601C21460
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4283CF58;
	Mon, 15 Apr 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aC09zM/f";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eygfDaMU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7B3BBCE;
	Mon, 15 Apr 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171802; cv=fail; b=XeJgSvK7H6+1r45WWsyOk7rFIWAcoQgLCwqc1+fmxB/FomoTU9Wdi2Ek2FysAzwhNxcfVOAbAIzLf+6YxqEHHro5X9ur/opM0cehDoKUt0BnFhpFbKyZRO86UVeAkFagul4edG57DbZVAyF6PVrlooWp6pAqwbGCh9mtgkV4X8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171802; c=relaxed/simple;
	bh=b1PzSdtKbS/g38roABlG5DtuHuBbTEqIh2bE5LZxpnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghz395O+a/vhMckRLspSNBPWeKtpLpk/nVouzTkJQ8M3ez9clNx2BLlVZahm8sLwKB6E/sgPwIeJJmYMFwmdQz7PEcjkSgTMVD9ylAkNQP9DVqDFqUVMZ88L9XrMz2chgmtlVA/iminfFJ+evDuFB/ZFb3nSs7aLq6ef/a9B40I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aC09zM/f; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eygfDaMU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fdac007cfb0611eeb8927bc1f75efef4-20240415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b1PzSdtKbS/g38roABlG5DtuHuBbTEqIh2bE5LZxpnI=;
	b=aC09zM/fmTKpYATJvmwm/bHYOPa4EL4L5fUm87TVwM2kWJ53HncwZ2u9PPRHTxWSgYfQ/0rbc76n26KaWKwMiyaXAb52+AK0XRO3wC8omSoRmDDMwMru54Hw0K/NZw5odw4yssDuLnyeUtlE2d2mOE/mZbV+aTdHoiENNNRFPIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4e3394f9-4200-4254-b23f-c5a7935f3025,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:dae8af82-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fdac007cfb0611eeb8927bc1f75efef4-20240415
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 33537913; Mon, 15 Apr 2024 17:03:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Apr 2024 17:03:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Apr 2024 17:03:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPDqBko01hFTvo2y7EyFbeJOeLX1rQnGel6Nl6jpL002nwwLtqL3HvmRR0l3Wg3e9DUd9HUo8Z2Pu1Id9nd9xuHVezmQaCvJHAbnjymB0hNRPvkkJ0hVXhZV93ZvA18b/gNVGrKXfvc/+4Ki/xX4S1+o8oanF6QjaBx6TWPnU8AOgdiodEkALVmj70XmvH6An/cBtNmBMqJ5Pcr0STse9ekRQE0+AINJEh1Nx+tsGhkP8MUiGg45N/Sbe7tyKbxpf9KAhBzz560lPLzKACPJfq/z/cLEQSK9vVhiDLGuPXsrbmrDWb+5JxcJDT9k+qiAVafwOt9dHo1yskoFMjELiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1PzSdtKbS/g38roABlG5DtuHuBbTEqIh2bE5LZxpnI=;
 b=G40ptubQCZvlAU7mm569uYyuXGZTV+tV/AIBWIS+CYkAw6PrzWZDetmkCUcfihUgwdad25acPXpkG2qPkpmWk9oL55FYk6v+vlbH/0bXUbiCfbq39svay9NnV1WRcoHx512+i3RtkJbEcu5ajMRSA0atGtCObObukn9lJRcaA5d4SbsyN1eYGWxJal82lK27vnW5xH+tYshHdNaxOV+b9WnrCDi2b8OwmOO/VVAUAwGSLHLegoiW6eLtCONvlIby6NFHvCfq1IBZ9yD87/b4tyF3S2ipQaiObI83ugBGYG4sgkiHJ8IOAK8qz7AT4Iu4Dm6B7uE6rgkU2hJtCjA86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1PzSdtKbS/g38roABlG5DtuHuBbTEqIh2bE5LZxpnI=;
 b=eygfDaMUzrpB7Ehov5y6nu3iJaQEnPsegqBjF0a5LBZgdSevH8USdpTnaVO+0ey8Tyst3OMPcA503Jw4T1ZxqtciotlbkowMHKJh/OYEwaBiSS8T/bRd9aBFDx8Z0EQBq/IlCONhbrzLJfxBKCq4WOXOwkDfgV63jj3uhNIlkKg=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by KL1PR03MB7020.apcprd03.prod.outlook.com (2603:1096:820:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 09:03:05 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 09:03:05 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "chu.stanley@gmail.com"
	<chu.stanley@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
	=?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= <stanley.chu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-support-va09 property
Thread-Topic: [PATCH v3 1/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-support-va09 property
Thread-Index: AQHajwpNl8GOtiYtZEybRPFXuumKzbFpCV4A
Date: Mon, 15 Apr 2024 09:03:05 +0000
Message-ID: <00ecb45910f795c7b4af02c7aaae0caa29871821.camel@mediatek.com>
References: <20240415075406.47543-1-angelogioacchino.delregno@collabora.com>
	 <20240415075406.47543-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240415075406.47543-2-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|KL1PR03MB7020:EE_
x-ms-office365-filtering-correlation-id: 403e1044-5051-4265-c465-08dc5d2adced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?bkRnWCtNLzMvUTcxNG8xYXNjUnZ3VE81ek44T1dYYm5ZYUpZSko1UUt5bm9Y?=
 =?utf-8?B?OFp3b3VjYUVZOVp5OHp1cktOclhqTXVsR0FqZGM5MG9TL0JOamVwaTdsenR6?=
 =?utf-8?B?ejVVOTcwcmJSU29mdWViY1FON3FkRktaSnJEMlRTVjlBUkc4Vi9QNUxqWDZi?=
 =?utf-8?B?aVFuWEYvV3RhSmdCenBWMUlwd0pmejhMOStRUm9ZeHE1UTNWb0VWT2ZJdUxK?=
 =?utf-8?B?QkJmZzVKSTV5emsvckFKV0NpNyt2OURyd08rTVI1RmMvWnpvRXRwcTYweEQ2?=
 =?utf-8?B?dzk2K0ZSeHJ5aWdyM2tnZVhNYmIwUGVJcWJENTlnTTc5bXdMR3VVdlJJYlBE?=
 =?utf-8?B?L0Rwd2RFUFFGVGltOXFoNHAvODBVQUh1bko3cGh5enJSQVNGdEhWUE5XYWcr?=
 =?utf-8?B?YXBxaUlEcUN1Vmh1UUN3ZGNGV2dMV2Fpbm0yUW0wcWlmMDhGVm1rVS92NWRM?=
 =?utf-8?B?WllmQnZQY2FjcEtWb3FJUXJxT3VZTGlBQlQ5R2Q5TGMyM2pQNVpadVlQQjd6?=
 =?utf-8?B?MlJLT1c0MDg1SkJkL2tTK2lZd2VWYVUxTmtSdTkvMmJDanNjWWR1ZUk1UUVU?=
 =?utf-8?B?NHF4SFhmNHYvdkxzNElxNW5DRVczOGE2UTZmN25rN2xQb0ZDVjlRa216eU9r?=
 =?utf-8?B?VU4vRHhqOFI5Wk1WV3NtOStqaDZGNVhvQ250V3VlSUxMdndCVVR4eVdlbzI3?=
 =?utf-8?B?djJDMXNZZVhEdGgzWTNRalJGMzEwZ2Y3SDAzdTgyeUdNWHJEV3VGdjc3R0sr?=
 =?utf-8?B?bnp2MkFMRXN4K2tDZ1pYUktBcFNHVWd6ZjkrOGRUbHVzT3J4MlI3bUROYTVy?=
 =?utf-8?B?dWZvdmk0Vyt4eTZaczRZN1FvTlJhbEgvVDN1UEIwVFdWcFQzaVNpcUtlQmxo?=
 =?utf-8?B?ZndScy9hV2pDTEg2dXJMMnJlYzJkTzdCOTB4anVFRXJtdmtQUCtodk16ODJa?=
 =?utf-8?B?WnpGT0ZJais1Rm9pRGhNOE85RmVPeEdmSUFERzFsNktXQnRaNGV0dVBhNTlp?=
 =?utf-8?B?THk5VkI0ZmkxUEh6cEpFUWcrMVYzaW5taW5yOEY3RHpKMFVjend3ZkJqZXVj?=
 =?utf-8?B?dFJWeTRvY29WR21DU21yZTdvaHdkenN4eE9udlFuV0NiUVVhTVR4TnVBd0Fv?=
 =?utf-8?B?d2U3TjBKdk8rR1IzWjN0bmMrcTQvdXZHcXN0ZTFqaXFheGs1dFdRVmFtbVNM?=
 =?utf-8?B?MEpJSTJPcGt2ZExES0w3UUVOTUgyY0N2eTB6MTZrMklCRU1CMENhQS93UEZm?=
 =?utf-8?B?YnM3bWxDWGs0Q1pkUHJqKzRpcDJTQjhzNkRyNEJiT1ZpN3JqcmhIbkNkMjhY?=
 =?utf-8?B?dFpndE1xRmJqZjJyNnY3RkNXYVM4aDJBdVNwb0trdzZKZ3RiemljdjBhS3pV?=
 =?utf-8?B?dkoxNXVSUnZuVzNxdGZ0Rnlla3FlU0loNitxVUFnU093WCtxQUxpbWl4UGdr?=
 =?utf-8?B?RTFkdkhNWklUQzFGRU9nTjFLN01hNEQ3cUF2SFNtTG12L1h0K0FNVE1HNkRo?=
 =?utf-8?B?Znk5Y3lpVjgxbThOaUNRMFlJSTJjdGxsNEZaN1VCMHFld3RXZDJKcmNwdXdK?=
 =?utf-8?B?N1Z1ZU5qbWJXNVNYbW9RTCtwd3ZHNmxBRzNVVEF5WGVLUFk0Wml4YlFVTVhI?=
 =?utf-8?B?eFVlL05ISXFQQVFtSDMwYVBHWVcrK1pYeTl6MW5hSjhiTE9FRjJqeGtxZjQw?=
 =?utf-8?B?OUFaYjNibE5Cd2pkWUp4Z0s3MUYwcjhQNEl5S1lZQkE1Y3VjOVVPRkRUS3po?=
 =?utf-8?B?WFgrbTF1d2VIQ3I5bTZOS2diS3A5WDZqaXhtVEVDWUtlK2NjTFJZQnl6SE9i?=
 =?utf-8?B?NFdvMDNaaXdQR05RaEYyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDVrZmsyUzk1a3lrU2c0c2FwNnFrVzFRYzVpbnlBSytyMXJVai8yUUpTRWVF?=
 =?utf-8?B?YXdaS29QTGM3YkI5VmZ2VEJyT0FMVk5Yb2tUVkhvS0lwNWNEK3NlS1cyVkpG?=
 =?utf-8?B?WkhRVExSK3BoNTZpZS9laG1YQXhkUnlKZWprdzdtSmU5ZlJVUFhqNE1lZXcz?=
 =?utf-8?B?TTNNTklVaDFxcy9Ia0hLWnlyd09XMkdkdU56WlZIOFlsbHZ3TFdrYklRbmpv?=
 =?utf-8?B?WndpdHVNYjBIL1pkNFVTVy9BNWplelE3NVBzVlA3aERGMEJGQnRmSUlFc05o?=
 =?utf-8?B?YU1JNEppM1kzTENDQWV5VmJFK25iQ2RObHZtanRKZkRIaXFuUmxoVTB2NWVk?=
 =?utf-8?B?SkZuN1hvODh3eDJ0ZHI4bkVuK05WK1dua3NrRjdqNHhuWHZkckkwcWxKNGQ2?=
 =?utf-8?B?dTkyRUlVN3hKZC9YZ1lrNHFMWVZQZFp5WmtiaDZIblkrWkxaMUh2MWF3SEpX?=
 =?utf-8?B?UmxFUEo2RktOK0ZVd3hvb29OTHR1K2t2M0dUbC9ZdU03WTB6bk1HWnpjZk5Y?=
 =?utf-8?B?NnRSRmp1d0FNdWI4UjFwRWIyeEowN000Qm16YmFlUW5yVlozWU4rSmUyMEFO?=
 =?utf-8?B?UTVOWWkwYUN0S3BHN0QwTnRQOHBPYmQzVnhINXpUeHNIT2J2dmR4ekZQZDdq?=
 =?utf-8?B?bm50M1B0Sm1WcGlYQ290UjRmN3V0ZWZmYVRwTW5UWUVUbnlMOFBaeGZYME5I?=
 =?utf-8?B?ZlU1Mld6VFVnT3FDbjdQQWNkcm1qOWhISHFvTmx5aXMrd09uNVRFeW9RbVV0?=
 =?utf-8?B?Mzl3V3VJZ3lPeEJQcEtRelRvRSttVUp1MnRRQi8wTVMwRk02NmRMbkgyQ08r?=
 =?utf-8?B?c0lzUG9HcW5xMDJuaHQrM1Erc1hhNkpFUWZtN01MTUJmbTI4VFQvUGJYdjl1?=
 =?utf-8?B?TUJnT09lcEt2bkpnbEZMVzMxNUdPaE5NWUYwVFVtc0g2OEY4em1VMGVHekhh?=
 =?utf-8?B?dVdRNHRKZ1NWU2pjbUUwejlZd1F4VEpPQUxpajVySkVYY0s4aG1TSXFWOHBN?=
 =?utf-8?B?b3paK3ZSVEswZ1ZKaUpzVkdqL2NML1BzSjlaTWtaaVRDb3VGK3V5dU5ONHNJ?=
 =?utf-8?B?L29rcEc3QWlQQnIyRy9wRVFIbVRTbzl3dHlPYXp1L0Y3d05pQW9NTGVMZXhV?=
 =?utf-8?B?bDhZWW1OTnpNdGZ6VDhGTm1rdTc5bm5FQ2dzd0E4dWdYYW9TTFlINXlGWmpr?=
 =?utf-8?B?VXdtRmxDYzNVQnloa2VvWk82MHYyVmVVUlBtWUJ3L0lQeVpodmJmaXRoQnZQ?=
 =?utf-8?B?KzRsOFBqcGtNeFdDalovb1R3Y0NVdkNJcExBS0JxdmovcnRVQjB0OEdXdWxH?=
 =?utf-8?B?L2lYM2xMNTFma2J0eWJza3VtK1NhUURLdjhhOWkyL3JqSWE5Q0lxSkUrMlB2?=
 =?utf-8?B?N1c4OGZ5MnVXelcwYkMxNGNYaXZEUHZTdmMvakZRZkMrVFRiL0s2WXNSSHBn?=
 =?utf-8?B?L00rSkRoT1N3U1hDUDZXN0srWDRYeE5zcEgrcEJsenh5V2pYTTV5UE9Lc1p0?=
 =?utf-8?B?MmdldTNtRXJmOCtQVWp0QXByVGU4SEV1bE12WFM5aFkzMjNsVnFXQnYzWFlX?=
 =?utf-8?B?TlRGK1Q0bHBkaC9iSUYyRk9kSFY3bmFQNXdNai9QcE9QeGZkS0F0eFFTelYv?=
 =?utf-8?B?VmFiUmo0MTE2M1U0WHk0WFhENWNwOWJ5d0JGL1dOV1ZKa2Z2V24wV05zY3Nu?=
 =?utf-8?B?RUwzR21jR09FeDFVY29EVU9yRGNqZUNWazg0U1B6dXVQMEJEckZmUnRnRmJq?=
 =?utf-8?B?d3pTOFBWRFdsWnJySlJXMlg2dE1UdFI2SlNqUUJETW9uamUwSXQ0eGZ5Mmtj?=
 =?utf-8?B?ZHNPQWEzVlhKMk1NQm5oYXZ5SloxTS8vMFNSeUdwc3NiMW5lQjRZY1paQkg2?=
 =?utf-8?B?R2UrdTJGV3FxbzR5dUxpSm9MQkkvS0lRMGhob25GOVN4QlU1MlR5UWtoRDY3?=
 =?utf-8?B?dkxtbGxzZVBlVHlmOEh4MHFZNDNZYjhmQXdZeXIvaVZEY2ViN3JwNFRIZXAv?=
 =?utf-8?B?NnRaVXN1ZGZ1WlhjSlJyQ3d2Mm9tMVJ3RzRoYWpLMFhVenJXdmZZQXJzQnJ4?=
 =?utf-8?B?UHc0bURES1BXVWticTRyQ2dQRjRkazBvWjk2bnNPdUV5RTM1bys0LzBHSUp5?=
 =?utf-8?B?ejZZQmdtWlI3dXZIangzbEVhQjB1U2FhVnZXNnBUSWtDeTc2a3lPZjZoa1Qx?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E03645CFD13A4799F229585B746768@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403e1044-5051-4265-c465-08dc5d2adced
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:03:05.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2WZeTkAkA9N6Prx7cCJ8zq0+Rc1k6nLPhtt9qSxHHZ1Iwyvm8zjXQKIu42fDduHTswNAhg+l+3GKUi4U256hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7020
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.655500-8.000000
X-TMASE-MatchedRID: u8usGLXufdjUL3YCMmnG4t7SWiiWSV/1YefZ7F9kLgsNcckEPxfz2O7H
	s99bUUHUbK343yO4r4t6MoZxG6GXZImoXedGE6+KF6z9HGHKwNt6zDxGcFEbCr4UBECYc8Kmilv
	Ab18i4hMFCXmAJJjxmFK4aFrQcTRqu+66Sy5jOwKgx+na8dyT1VaOJcCxVHYrZOV3cNsnUIZCdc
	EmTf2tvylMEKo38KD7bse5bocc1nsYB2fOueQzj9IFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ16qpwquwhuUWGj/2lq3Bu3LSETm+jtBvjb80sOnAJ0q0SpLGeCIZ4X8C+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.655500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DF2AB734532F119ABF953911531FE353D5CC613E2DE96D273352C569DF7E49F62000:8
X-MTK: N

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDA5OjUzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gUmVtb3ZlIGNoZWNraW5nIHRoZSBtZWRpYXRlayx1ZnMtc3VwcG9ydC12
YTA5IHByb3BlcnR5IHRvIGRlY2lkZQ0KPiB3aGV0aGVyIHRvIHRyeSB0byBzdXBwb3J0IHRoZSBW
QTA5IHJlZ3VsYXRvciBoYW5kbGluZyBhbmQgY2hhbmdlDQo+IHRoZSB1ZnNfbXRrX2luaXRfdmEw
OV9wd3JfY3RybCgpIGZ1bmN0aW9uIHRvIG1ha2UgaXQgY2FsbA0KPiBkZXZtX3JlZ3VsYXRvcl9n
ZXRfb3B0aW9uYWwoKTogaWYgdGhlIHJlZ3VsYXRvciBpcyBwcmVzZW50LCB0aGVuDQo+IHdlIHNl
dCB0aGUgVUZTX01US19DQVBfVkEwOV9QV1JfQ1RSTCwgZWZmZWN0aXZlbHkgZW5hYmxpbmcgdGhl
DQo+IGhhbmRsaW5nIG9mIHRoZSBWQTA5IHJlZ3VsYXRvciBiYXNlZCBvbiB0aGF0Lg0KPiANCj4g
QWxzbywgbWFrZSBzdXJlIHRvIHBhc3MgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgY2FsbCB0bw0K
PiBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwoKSB0byB0aGUgcHJvYmUgZnVuY3Rpb24sIHNv
IHRoYXQNCj4gaWYgaXQgcmV0dXJucyBhIHByb2JlIGRlZmVycmFsLCB0aGUgYXBwcm9wcmlhdGUg
YWN0aW9uIHdpbGwgYmUNCj4gdGFrZW4uDQo+IA0KPiBXaGlsZSBhdCBpdCwgcmVtb3ZlIHRoZSBl
cnJvciBwcmludCAoZGlzZ3Vpc2VkIGFzIGluZm8uLi4pIHdoZW4NCj4gdGhlIHZhMDkgcmVndWxh
dG9yIHdhcyBub3QgZm91bmQuDQo+IA0KPiBGaXhlczogYWM4YzI0NTkwOTFjICgic2NzaTogdWZz
LW1lZGlhdGVrOiBEZWNvdXBsZSBmZWF0dXJlcyBmcm9tDQo+IHBsYXRmb3JtIGJpbmRpbmdzIikN
Cj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9n
aW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91ZnMv
aG9zdC91ZnMtbWVkaWF0ZWsuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+
IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9ob3N0L3Vmcy1tZWRpYXRlay5jIGIv
ZHJpdmVycy91ZnMvaG9zdC91ZnMtDQo+IG1lZGlhdGVrLmMNCj4gaW5kZXggMGIwYzkyM2IxZDdi
Li5lNDY0M2FjNDkwMzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2hvc3QvdWZzLW1lZGlh
dGVrLmMNCj4gKysrIGIvZHJpdmVycy91ZnMvaG9zdC91ZnMtbWVkaWF0ZWsuYw0KPiBAQCAtNjIy
LDI3ICs2MjIsMzggQEAgc3RhdGljIHZvaWQgdWZzX210a19pbml0X2Jvb3N0X2NyeXB0KHN0cnVj
dA0KPiB1ZnNfaGJhICpoYmEpDQo+ICAJcmV0dXJuOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9p
ZCB1ZnNfbXRrX2luaXRfdmEwOV9wd3JfY3RybChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiArc3Rh
dGljIGludCB1ZnNfbXRrX2luaXRfdmEwOV9wd3JfY3RybChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0K
PiAgew0KPiAgCXN0cnVjdCB1ZnNfbXRrX2hvc3QgKmhvc3QgPSB1ZnNoY2RfZ2V0X3ZhcmlhbnQo
aGJhKTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+IC0JaG9zdC0+cmVnX3ZhMDkgPSByZWd1bGF0b3Jf
Z2V0KGhiYS0+ZGV2LCAidmEwOSIpOw0KPiAtCWlmIChJU19FUlIoaG9zdC0+cmVnX3ZhMDkpKQ0K
PiAtCQlkZXZfaW5mbyhoYmEtPmRldiwgImZhaWxlZCB0byBnZXQgdmEwOSIpOw0KPiAtCWVsc2UN
Cj4gLQkJaG9zdC0+Y2FwcyB8PSBVRlNfTVRLX0NBUF9WQTA5X1BXUl9DVFJMOw0KPiArCWhvc3Qt
PnJlZ192YTA5ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKGhiYS0+ZGV2LCAidmEwOSIp
Ow0KPiANCg0KSGkgQW5nZWxvLA0KDQpNZWRpYXRlayBtYXkgaGF2ZSBwbWljIHZhMDkgYnV0IGlz
IG5vdCB1c2VkIGJ5IHVmcy4NClRoZSByZWFsIHZhMDkgdXNlIG1vZHVsZSB3aWxsIGhhdmUgYWJu
b3JtYWwgYmVoYXZpb3IgaWYgdWZzIGNvbnRyb2wgaGlzDQpwb3dlci4NCg0KVGhhbmtzLg0KUGV0
ZXINCg0KDQoNCj4gKwlpZiAoSVNfRVJSKGhvc3QtPnJlZ192YTA5KSkgew0KPiArCQlyZXQgPSBQ
VFJfRVJSKGhvc3QtPnJlZ192YTA5KTsNCj4gKw0KPiArCQkvKiBSZXR1cm4gYW4gZXJyb3Igb25s
eSBpZiB0aGlzIGlzIGEgZGVmZXJyYWwgKi8NCj4gKwkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVS
KQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKw0KPiArCQlyZXR1cm4gMDsNCj4gKwl9DQo+ICsNCj4g
Kwlob3N0LT5jYXBzIHw9IFVGU19NVEtfQ0FQX1ZBMDlfUFdSX0NUUkw7DQo+ICsJcmV0dXJuIDA7
DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIHVmc19tdGtfaW5pdF9ob3N0X2NhcHMoc3RydWN0
IHVmc19oYmEgKmhiYSkNCj4gK3N0YXRpYyBpbnQgdWZzX210a19pbml0X2hvc3RfY2FwcyhzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgew0KPiAgCXN0cnVjdCB1ZnNfbXRrX2hvc3QgKmhvc3QgPSB1
ZnNoY2RfZ2V0X3ZhcmlhbnQoaGJhKTsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gaGJh
LT5kZXYtPm9mX25vZGU7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAgCWlmIChvZl9wcm9wZXJ0eV9y
ZWFkX2Jvb2wobnAsICJtZWRpYXRlayx1ZnMtYm9vc3QtY3J5cHQiKSkNCj4gIAkJdWZzX210a19p
bml0X2Jvb3N0X2NyeXB0KGhiYSk7DQo+ICANCj4gLQlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29s
KG5wLCAibWVkaWF0ZWssdWZzLXN1cHBvcnQtdmEwOSIpKQ0KPiAtCQl1ZnNfbXRrX2luaXRfdmEw
OV9wd3JfY3RybChoYmEpOw0KPiArCXJldCA9IHVmc19tdGtfaW5pdF92YTA5X3B3cl9jdHJsKGhi
YSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCWlmIChvZl9wcm9w
ZXJ0eV9yZWFkX2Jvb2wobnAsICJtZWRpYXRlayx1ZnMtZGlzYWJsZS1haDgiKSkNCj4gIAkJaG9z
dC0+Y2FwcyB8PSBVRlNfTVRLX0NBUF9ESVNBQkxFX0FIODsNCj4gQEAgLTY2Myw2ICs2NzQsNyBA
QCBzdGF0aWMgdm9pZCB1ZnNfbXRrX2luaXRfaG9zdF9jYXBzKHN0cnVjdCB1ZnNfaGJhDQo+ICpo
YmEpDQo+ICAJCWhvc3QtPmNhcHMgfD0gVUZTX01US19DQVBfUlRGRl9NVENNT1M7DQo+ICANCj4g
IAlkZXZfaW5mbyhoYmEtPmRldiwgImNhcHM6IDB4JXgiLCBob3N0LT5jYXBzKTsNCj4gKwlyZXR1
cm4gMDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgdWZzX210a19zY2FsZV9wZXJmKHN0cnVj
dCB1ZnNfaGJhICpoYmEsIGJvb2wgc2NhbGVfdXApDQo+IEBAIC05ODUsNyArOTk3LDkgQEAgc3Rh
dGljIGludCB1ZnNfbXRrX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gIAl9DQo+ICANCj4g
IAkvKiBJbml0aWFsaXplIGhvc3QgY2FwYWJpbGl0eSAqLw0KPiAtCXVmc19tdGtfaW5pdF9ob3N0
X2NhcHMoaGJhKTsNCj4gKwllcnIgPSB1ZnNfbXRrX2luaXRfaG9zdF9jYXBzKGhiYSk7DQo+ICsJ
aWYgKGVycikNCj4gKwkJZ290byBvdXQ7DQo+ICANCj4gIAl1ZnNfbXRrX2luaXRfbWNxX2lycSho
YmEpOw0KPiAgDQo=

