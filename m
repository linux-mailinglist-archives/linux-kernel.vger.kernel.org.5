Return-Path: <linux-kernel+bounces-72184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9D85B092
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743F41C2261A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDA36B01;
	Tue, 20 Feb 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tc3Be3ob";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aRGGfcH9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163F8465
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393057; cv=fail; b=X8QZuRGQr9R7jpvnwPniwJeiTSRjKCW0BhqpVvzYWzFg8nTUWE7CwjZLyS8mSBwPp9nMN4TdcUSf7bu+aXVsF1zqGrPVEgEj0jfELcxMV+bNe+1OouShsZG94z5iJ79uSNDgrQPUJXaE479g0FoHrw854PuQ+IEE7QsnpdXhuXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393057; c=relaxed/simple;
	bh=tpF9IWjmkorsEG8rRM1t58d7hophi7oMwY9GKNWqlSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4AjijYc4D9y+FQ69Ac/3J+x+P/ie62fSa0g3c91SqqEKAMltzuPlBWFeZKzyb9qe7Me1FaqTOaq+ieP1QtUXcc3NZSO1GzVP/DhTm/zhJs88qTVpfQ2IakGe4Y51fLg/x2nFmmzQffEluAkzoYOP9tJu/hNTJO5qYMx8Cw5X1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tc3Be3ob; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aRGGfcH9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9c69c642cf9011eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tpF9IWjmkorsEG8rRM1t58d7hophi7oMwY9GKNWqlSg=;
	b=Tc3Be3obhzs2GgOc10/+jT/d5xdW/OQZyEzCQfuax9AbKT1zSs2xSCGVF6jvqYFEmRvoOLdAsEj23Fz29rXFbcBnn+KU4Y8NkBhY1abGPAiiupKT7IglGwjmP8/S7tJEHfZMeH7CXK/N+WJnSPs0x9fTUPFy7xoiPXfgw9IEymg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:48997c0f-11ae-4158-aabc-ecc168bd5ff2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:61c97a8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9c69c642cf9011eea2298b7352fd921d-20240220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 65085835; Tue, 20 Feb 2024 09:37:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 09:37:29 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 09:37:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rewyh1aSJ7Pf5SZlAngqYBHbhDP3zGBNehmiDbpUrrJv4IEc/ysIkw1R+0jiA/f/NYUDTlkeXonLXKq/NHiw6FCAPpgmWf/WQR0/k9MxDrXja8iXrbkCQ0RiUgw3o34Y5l25ZcqzgChC+SdUQVHNRcP4qbK/rN87Tyu3vAEwJJ2Avy03u5AZJWrjoKYC/jpzbhqIce2BceIm5DXa2Y0/wCaAaUPhUypMFmZ+YpUEhxYBIN/KSpYdYFi+DzUYavmHblc77Bu04hCS8taDH+5C+WNwmxzEobGxPLnmcqN5TZALK3Vsshsc3mJQ+In0fzOjPSbn92GCKy+zRoa60HhtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpF9IWjmkorsEG8rRM1t58d7hophi7oMwY9GKNWqlSg=;
 b=Zy+si2lvNyJfQ4KbosI15FPaPBp7+DaNxzyb4ZOjnh2LN4X3uf54pLo1hxGMVK8vIllrcB2tl0cHRaq8H4A1qNHgVjZKHDbNra/nJnejpnTiCCmjHLv1v6lkRUCf5WUWDP9o6PyGuW3dl5SKlM6RlV9RKtiITYlWXkPisLz0g8JjeHI74ujIhc4Q0pisfds60gB2j475viUgNnIP0JDz2uzngzvfWh4E1pBakM69BAdl7s3N2p4oo2sy4p7WEfxyk3hJB37jSPiTdV89v9SNFOAl1tebzfk3g8ouSHDTFA0rWMVTJyKjT7MdFi4NtZEPdqXbyUtzYxBcyxIQCuQF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpF9IWjmkorsEG8rRM1t58d7hophi7oMwY9GKNWqlSg=;
 b=aRGGfcH9L7y6Pbiju4/BrtNTqb3qrpzYfT58Q3nPtoDREDDVj4dWZlgngW+jlxRLxuVk+UcGgRJzbtxtWZ0dxz19GSyfjV8Rsdo3/LxULWbxPTKVVp985jQugtkgVAW99ugCbor63Pua8oJGp105PxXjiP476RCUTK89K3lgZME=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8295.apcprd03.prod.outlook.com (2603:1096:405:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 01:37:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 01:37:26 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH v2 1/3] Subject: [PATCH] drm/mediatek/dp: Add tee client
 application for HDCP feature
Thread-Topic: [PATCH v2 1/3] Subject: [PATCH] drm/mediatek/dp: Add tee client
 application for HDCP feature
Thread-Index: AQHaV/ePwyvGD4XnJkOIaHAXSCsAzLESisgA
Date: Tue, 20 Feb 2024 01:37:26 +0000
Message-ID: <bae975ea502ba7b6cb0fa73f7c8d461f4c9b963f.camel@mediatek.com>
References: <20240205055055.25340-1-mac.shen@mediatek.com>
	 <20240205055055.25340-2-mac.shen@mediatek.com>
In-Reply-To: <20240205055055.25340-2-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8295:EE_
x-ms-office365-filtering-correlation-id: f79e2243-8649-48ab-99ca-08dc31b47e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rh6DgZ/tebGyqGnpXxAL7rCDpYFe7IZHhwLv8XvaYkvlqzeVMhSudbHW9SQNy/Z5EVOPxAPxDo556ElPZZHv+kfQheo1uX4QUYzCrYvlsNjDOculAiTyh1H4TadRRIL3ozj1Cf0uE6SsH/KhPvQ69mFE6Jsm3jcwQqK3kas+IhkhEBOcR88LlgZPeQ5dpcmFLH9EvzWWLU8jujk+rZBn8fcYNwwpkJc0xIdQO4ECGuEI3TD7bG0El4ypsKlThoVSOLWTulOKHOvnE8V+jCy8wSq2jDT6vUSKZ2KZOJn1X0wg2g/jtl3XH8k6jo45Yh9AcjufjdAYpu/Q9K0fIrRbyPp671zMBQZQsDs3mBNfi7yc5ad49c0DVMrU7/AZkcWvmTx8JpvxQb8omgsiFYV/K28ke9LmpRMkACO0JFP9e3LAh1XFFyK3s6maUvOMHTgIRY7Fdy+5r7mmdoh105bs4YigPaxtU8qzeAXbokKRfjMKZ/UAESjLHP9n/QBHK7vMJrpUtGHz23WTT/PqWFB3eggTvFbta30Yy7ROKxTBv71omo3aAtvu4XQttvGyzgAxb9YGKesYya1FDK+TuxHPmFKz9KoAin4T46VyeqCy+/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm9MR0ZJMUhXalpqZU9JWVRQMXhUUXRvYjFvZHJ3alhGcG16QUEwaGdiVFlH?=
 =?utf-8?B?Ymx4WkxxSEZhakFndXQ0VXRNbzhLTHlmYXRJQ01JalhyaEpybzVoZXV6OENT?=
 =?utf-8?B?eVpSS1Z3QXpsaDFmNU1PWFVDa2R5RUpnaHYvMk84Nm9aR1BBQXg0aC9veERJ?=
 =?utf-8?B?dzBMRFdrRU44N0hWaWM2TE5rUGFHRjBTdHpxK21KbWxwVHUvUUMvaHdaT01s?=
 =?utf-8?B?TDhZc3NHK2ViU0pOMHgvM0dnMjExWHpvTGMzbm5oVUUybGszU1M0Z3p3L0lV?=
 =?utf-8?B?b3NHT1dXQ25id1UxLzluS0xLRDlMWmU2VFNRaHZQcWNuZG5QanJtaTdlWnNG?=
 =?utf-8?B?R2F2SExRb1doeU9wRjRCZzlCeUhWSkY0cDVOYy8raGltb3dXc1BZMUxwT0tK?=
 =?utf-8?B?TXZ1TjdJZmRicno5ZkVTZEpiUHBtSGRaUXRGYmNmQzcvZ1krdU5LWnVKUGt1?=
 =?utf-8?B?UlVaa25TNUMvSGNvZWlRNWhmVWhoYW5ERUdkTjdJeElLL1U5aTl3clRLZUlh?=
 =?utf-8?B?TkgxVk9TZzhtdjhNcmlyTDFIZ2JsSnl2WlV1bDlGUW1uOVZpTTdoZFFJaXd4?=
 =?utf-8?B?WXZscXpJdVkwb2JVVDVaS01aemYydVJ1cUdHZ3QrZG54TlMxelFMYXM2V3NE?=
 =?utf-8?B?VWU5QU5DTS9JeUg0ZWgwV0psY2d1NlhreGhXQzBMd0Fmc21yaEprellqVjJV?=
 =?utf-8?B?Zy9JOVJBbkpqc3dCUWpQMGdhY3I5a0c0SmVZS0pUZ0ZIZmtXMFptQ0F4VTBN?=
 =?utf-8?B?OEZLYUhoc2wzK2Zsb0NVY0IrMDdpejZyMjJvcnNpZzZkaFNFQkluK0RGWHl6?=
 =?utf-8?B?VUNWNVJDTFFVT2RFSWsyN0MrcUc5K1JSUnR3K1J5cytBbit1RlBIUE45aSta?=
 =?utf-8?B?dVR3WlJBeTBvQm5WVVFOTE9YTkNmZmFJOU10TDFvVHdTVjdYdGxUSHJhbWc3?=
 =?utf-8?B?RE8rMWtueWwrYXBJVWVGcDh3MGZNaFdiZkl5MUhKYlFoVjE1U3M5T1o0S2po?=
 =?utf-8?B?Y3NpNkNwUENSVVh6RkdHOXdSY25IOFZPVWV3QjQwQm5GTnErQThVR0dON1hu?=
 =?utf-8?B?a1ZvN1NpVVgyWnpiOGVxUXlKL05UZWc1UkRwODVaSTVsUlJSTnFTY3kyd2N5?=
 =?utf-8?B?OU50a2RjY3JSVDZNWFMybTNUL0orazdSYzh4UGpkVlVPdXRCTk9MK1F0YWEr?=
 =?utf-8?B?K280Tzd1bkw0dm5aMGpPOVpLMmxxSmtGbnY2RDVYeEEyZ2RNa1VpWG5LdVJE?=
 =?utf-8?B?cnpQSndSVnVsSVZudWJ2UW1ZUUd0bGd5a3V6NjE5eVZyc2wxRzd2Q2dPTmJq?=
 =?utf-8?B?dEpDS2RrcWFGRVdkcEtvY0VmWWs5cXgyOHNjVzBZTXhLNTF1alpVLytIbmZ5?=
 =?utf-8?B?VmVLU1ZoTDN2ZC9hR2J1MjRna25FbFV6Um82bEJKV2lnR0FPOFR0bTJKaTJj?=
 =?utf-8?B?cTdXWExXOU4vTDFIdHFNbXFnS1M5YTNpMjR3WTVtRSt5bDl1U2x2ZEI3TWFY?=
 =?utf-8?B?QWozcEdLWkEreGIzOVBlL2FUNDhGR0FmUEZvbXlLcmJFczBRWit2T29mSDBp?=
 =?utf-8?B?bk5zaGZMd2I5bGlRY0xhc0M2c0paY0ZDTVR0M3lsZ2dNS211NGVCVHgzSHVN?=
 =?utf-8?B?VnFvNWdPeTdac2tHWkVsU1EwU1ZiSVVTQzNZK3ZKWnVKaitvQ1AwSUhDOTZs?=
 =?utf-8?B?OVFiYWExYkJZU05leXVURkNBMXd4TmpUckVWdWxSR0NQWlZIUFBtbHBGN1Rz?=
 =?utf-8?B?aXlxc2FUWStmMkhRZ2VlanpydEx0dkdwalE2WnhaNUlobXEvYy9TTW9IeVpq?=
 =?utf-8?B?eVllU1VMMlZGQnBYbk1lZjFqbjRqRXk0T0tlc2dMWGRKeVFEUnhRR2x4U1A5?=
 =?utf-8?B?dEx3TUJCY3Nua01IcFp1RmxKWFZCMmN3U21kTFVDL3dTVmVWcW94KzJrUTlL?=
 =?utf-8?B?RmxoenA3NkwyODJ2SGtFVmE4SzBBU2xqQnJDWHY3S0N5TzlUWm1ndTRGOGtE?=
 =?utf-8?B?V2FrTk9ycGZvV21lQ2p5VnVSMk5YNjFjUjVmMUVPbTZER3VWQkRMTmJTc1hx?=
 =?utf-8?B?WUIvUDJGNEwwSXovanpuOC9WWXRZNWhybUJ5Y1QxNDRTazd5L3RSYnVOMDNW?=
 =?utf-8?Q?HxXRmdUV8Dl0l1L6zDIZU6uGS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85DD915BBCAAC046BE898159C6A9B8C2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e2243-8649-48ab-99ca-08dc31b47e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 01:37:26.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r436Am2yQaydsTIwuq2cyDrK7RuoDd16QibJS4/3yw2RP5AdGAOdKGqF+zQ1HV+LVZWin6NsS+A9id4d9Gzq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8295

SGksIE1hYzoNCg0KT24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjUwICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24gd2hpY2ggd2lsbCBiZSB1c2VkIGZv
cg0KPiBIRENQIDEueCBhbmQgMi54IGF1dGhlbnRpY2F0aW9uIGluIERpc3BsYXlQb3J0Lg0KPiAN
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSByZW1vdmUgY2EgZm9sZGVyLCBhbmQgY2hhbmdlIGZpbGUg
bmFtZSB3aXRoIGxvd2VyIGNhc2UNCj4gLSByZWZpbmUgdGhlIHRjaV90IHN0cnVjdHVyZSB0byBt
YWtlIHRoZSBkYXRhIHRvIHRlZSBjYW4NCj4gICB0aHJvdWdoIHRoaXMgc3RydWN0dXJlDQo+IC0g
cmVtb3ZlIGF1eCBhbmQgcmVncyBmcm9tIG10a19oZGNwX2luZm8gc3RydWN0dXJlDQo+IC0gcmVt
b3ZlIHNvbWUgZGVmaW5pdGlvbnMsIGFuZCB1c2UgdGhlIGRlZmluaXRpb25zIGluDQo+ICAgaW5j
bHVkZS9kcm0vZHJtX2hkY3AuaA0KPiAtIHJlbW92ZSB1c2VsZXNzIGNvZGUNCj4gcGVyIHN1Z2dl
c3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhyZWFkOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvOGZmZjU5YjU1Njc0NDlkODIwMWRkMTEzOGM4ZmENCj4gOTIxOGE1NDVjNDYuY2FtZWxA
bWVkaWF0ZWsuY29tLw0KPiANCj4gU2lnbmVkLW9mZi1ieTogbWFjLnNoZW4gPG1hYy5zaGVuQG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4gKyNkZWZpbmUgUkVUX0NPTVBB
UkVfUEFTUyAwDQo+ICsjZGVmaW5lIFJFVF9DT01QQVJFX0ZBSUwgMQ0KPiArI2RlZmluZSBSRVRf
TkVXX0RFVklDRSAyDQo+ICsjZGVmaW5lIFJFVF9TVE9SRURfREVWSUNFIDMNCg0KVGhlc2UgZGVm
aW5pdGlvbiBhcmUgdXNlbGVzcywgc28gZHJvcCB0aGVtLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAr
DQo=

