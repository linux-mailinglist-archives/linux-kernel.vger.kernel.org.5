Return-Path: <linux-kernel+bounces-112164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0800887672
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E346EB2240A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F217F3;
	Sat, 23 Mar 2024 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cCT8XVAk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VOmVotiL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53308A31;
	Sat, 23 Mar 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711158336; cv=fail; b=SPQWcPJzVOHN3GJT1522SqGOs1XZzOdnptaeiOeO6Z35LVn+W0WkSnbWOC1BW+rCKQ7ENLwzRqsH7qwZLpQI2pwst3Vai8Z1nGYFi7Muyi0kLYiElqKmfVkE4S+G+zq5jy8AfA1Wleh/uYBdPo811LgwqKScGwYkLgPS0oAywLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711158336; c=relaxed/simple;
	bh=cikjoK+cgl3FFrF4d9aTDtKYD+M4ZmaOEwdkgvTep4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqYhmP37RPvCZbUrfyl8itC/v9d/I8qdfVP0k1Vgqu+Aas2EvX26EHYu9AhlpNS72I+smgyZuTDw3Bg4ddjkxrY1ZOce6UPfgYfnAcvrBiMwm9HAvATyr853N7CXFPtNpk6NSiopONTkolNgr2Tvqgm0IVW8V8e7RnXCbHS0LsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cCT8XVAk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VOmVotiL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 01c40efae8b711ee935d6952f98a51a9-20240323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cikjoK+cgl3FFrF4d9aTDtKYD+M4ZmaOEwdkgvTep4U=;
	b=cCT8XVAk5kMeD7/d45+gy9vgjQXQZguTGjDTaarRFlMMj5a75w4LNxsJrmUk8rygZBL6kUPknL/8vYv2eQqh5thJpMQkpG9zJ7oPFpb37H3JR/DPqqUYdUItMYzCO7wAqYXBzjqM8V8D5cA/PwNXzAr+OK44BvWkpeclptnk3bM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9e583e7a-63a5-4907-9929-89789424e658,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7a39d481-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 01c40efae8b711ee935d6952f98a51a9-20240323
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1003641974; Sat, 23 Mar 2024 09:45:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Mar 2024 09:45:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Mar 2024 09:45:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0BCIxCQysK9dk2NQBPe5RzKwNuPb/V21IL1GmQZKuA16kMwwuiF854yQISGQPPp0oILrXmEPk3l2nKHJU0MahvCv7dkGNSau5TTCFypxvo79bgITEcUaX/TcKg51GiMRh8bGrlNNMjouBH5h9yMUaE/zt+bBUH9KvNvSUzGwXrYL2/LJY70lAp3Lluz3R57l7jxGQDJ5ubNcMaRis/uxbCodm/CM5CtSut1hZmasW0o9AfpclR9uSpgSHGlc6sG/D5Vc7lsz00FbUOW8Bzrobq63zBzb7JqYkXK2cSOW5fmtQ+tam0l27hcr63RiajXRGXvsmmuEZ8b70tDXD6hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cikjoK+cgl3FFrF4d9aTDtKYD+M4ZmaOEwdkgvTep4U=;
 b=oQXZmb+CqqA9OZrbms9vp1uAmcZ8ZJSJGHQIRct7jWaDcmq8MpsQG62eDt5fm2FDwC8kGfmav3sYgGUQ16YoniwqpeW4+wHXJdMaR73/0U2SMfRreySTxsoiBxonSYxWm+Nbmjojs7ou6uVYDBNIXMA6/B998ipDfhc3cQxs8FwzAWE1ve1Evb42U63FYfvXx9A1XyZBNCyOxqk6a3r2ROZB7NA1VnjhBLoGVVGSs2O/zFxC2aMSYAdBb7NRleG1NCmlLlOuS26jFJp9RV5NuTJVMhmSM+JI7Bia5zFDwUxXXfvUOiqWfReO4E3SqBzzGBcWyKYG72SYTtqXlyjYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cikjoK+cgl3FFrF4d9aTDtKYD+M4ZmaOEwdkgvTep4U=;
 b=VOmVotiLu3/pXBSxSSSgOgzpB0NfgvF/eCmcraLYIzdsoiLOkqNpdrZE++HsMJkqv9AT51HkprPbiDG8SGjDbLiHbITkn27Fj7YueFsEWS/pxaUKtZsxsxb+Wp+oDqcmdjr5MZNwlDG0UWieDOWVHN4hZViRU8irnBTI208j+TY=
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com (2603:1096:101:187::6)
 by SEYPR03MB7842.apcprd03.prod.outlook.com (2603:1096:101:178::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Sat, 23 Mar
 2024 01:45:15 +0000
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::cb92:439c:31f0:7945]) by SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::cb92:439c:31f0:7945%6]) with mapi id 15.20.7409.023; Sat, 23 Mar 2024
 01:45:15 +0000
From: =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "nicolas.dufresne@collabora.com"
	<nicolas.dufresne@collabora.com>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>, =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?=
	<Yunfei.Dong@mediatek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	=?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?=
	<Maoguang.Meng@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= <Longfei.Wang@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Handle invalid decoder vsi
Thread-Topic: [PATCH] media: mediatek: vcodec: Handle invalid decoder vsi
Thread-Index: AQHaeo3refJcpvaXr0WpnyfUEffv7rFD2cmAgAC4mYA=
Date: Sat, 23 Mar 2024 01:45:14 +0000
Message-ID: <ef36f69b2bed28c4c084d24948ba56690e6989b1.camel@mediatek.com>
References: <20240320061336.2615-1-irui.wang@mediatek.com>
	 <6420a5c39e0a6f85d4fd5a85643d601bd1e2fb05.camel@collabora.com>
In-Reply-To: <6420a5c39e0a6f85d4fd5a85643d601bd1e2fb05.camel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7947:EE_|SEYPR03MB7842:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Om8A44Q5VXO2i/r6PSflL7vt87m8mXzXGpStzS9IO1/uaNU6J3oCxwPd425W5dp5puB2JlFEiyb+sec/hZn7JDFcZNDOi+H9IX96hvCFIlrctkJkykqo748BODyb6bwgilgzyjOs6IYAwav0MItQD+RarGXH1nQ8mlKoVoKTFWYXr1udzqdapeILehhUnZkdCDQx4vVaQYRigfLnS1ukSMmYiuxrqYThKf3lfvDWzx7SpHdRyWyZFdBhoK4mImnj/VYVbn9J5C7W3wehATNhyRMpkwDjJ7BYuUV46gxjzvYyg342ifz+4jzsH+JxlP+WsBTS4WwtQfGNsdLSYr0QMaRjpMnZbyqJYtbZuen1L8r3gpuUp4O+py87kYQhJPTrSTLbxRLg/UkoNXxqiBC7akoUkJrRljv4UwjztIQGMrLCT/eE731lK4SEnxeLdUxf2z4sKKbRb/xTSPrkCdLPPRhYCLsFIFcXCvALjoFrYwZHvrDynDT0DZHwOKr7D4tdaDE/nuMfuM0thCGYcsJN13g3+ty24kNlmQd1dccproDloeSOb/N5dyQnrgE66xGYQi+5kksZt1gSpoKr9bcfTFI877rvNf+QUuyAKJ2vMJ2oVhsdxw1/0DAOQrhDx2pekZJ3oJjb8bG8eBJM3AeQSFv5h7lfNlbQ58rKMusn8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hpZ3VlcjB0dGhQalRkWHhTWGVGcktwWlFWUGw2aFRGZlBrdldoYlVOdUQx?=
 =?utf-8?B?U1pnZ240a3dOMmtWTTVvR2lBdmxEdG5VYittc05VakpqblZSeGJjSXFlUXVq?=
 =?utf-8?B?Sm9UREQ5T0g0czNISXI0MzlDRXZnY3FvM2tpbm1oa1EyVUpOMG9VSmY2RmdB?=
 =?utf-8?B?a2svQXpTNENrVnJhRmhxZEhPNFJtaE13RXVJanRhNnFOTVZCVTV1TnZOVndM?=
 =?utf-8?B?ZGhOUUF6ZHlUalNobDdoeWk1TDc1eVoySk9qMEJjSUk4ZjlybmtHdU51ZW8y?=
 =?utf-8?B?ZytNS3lHOEcxU3Z3bUxyY0tsV1IwT2V2NnJPazhaMnBCR3htcGhRZ2VKazZR?=
 =?utf-8?B?elo5eXlYeHFOY0IxdUE5VktVQVE0Zm15ckpETHJDbDVGN1RCTXBidjBpaW1p?=
 =?utf-8?B?cFNLak5VN3ZnNitzaERoeXgrYkNnSzVsM3BuTjNvNVRRSldVcE5uRW1QY3Zn?=
 =?utf-8?B?SkM5TnJxRmZxNHllemlYdStKVmJWYklPUjVCTld5YWdiV2V4Y25DVDdVOFRs?=
 =?utf-8?B?bEdxdDJJQWZxejVCVlZVWUd4OGtwdjg2Vm44WkwrNDhFSnpyT3lOMktVL2VY?=
 =?utf-8?B?bVVpUUdHai96Q1NkajU3SkVIa1ZrWXd1eE5iaGo0WVRDT2drRFNia2Z4NDdj?=
 =?utf-8?B?a2gyK2V4czVSRkQzQlVtR0I2aHpySVhOWVFTeGdEZU00OFNxNmFBT1JaZzBu?=
 =?utf-8?B?dGFoM0MyL0VoQjlrVm9xam1vbXNGekY1YlIwUjVZQnNvZG5BckxDMXdZaUxX?=
 =?utf-8?B?a0g1WVl1a1RYMnRxcFE0YVVlR0N6cU0wT3RqNk5nc0htbDdXUittOHd4SHBx?=
 =?utf-8?B?cUkxMlR4eWE1UkZKc0VlN2tUUWxRK0ViNEs3VGhJSTVtSXp4MlhuT0JzMS85?=
 =?utf-8?B?N09MeTh3SU9wZXdoRmlpSmh6WXlSRHZpdnZ2Z1Q2MEp6dWZDTklWSG1OL1F2?=
 =?utf-8?B?bXVmbWtPSWZIOW5kemMxdUFKYnZHYitUNXg4a1o0c2RHUUNEQkNWbjB0YmpB?=
 =?utf-8?B?NzZyaENMazdrYkhIWXRzZjREaHcxMFc1a21kOWhhdjh5cENWc0FUQVFuVVVD?=
 =?utf-8?B?Q3Jjdys5NG1ndHV5V0Zlb2xjaWI2S3hnaEVSVzZWdFRSNm1BOTVWVS9mWXFs?=
 =?utf-8?B?L1VpdHhEUnBDMGdZQWNQS280YXdraGY2aTM3c3pyRStESXIyQWRkK3VEVkhX?=
 =?utf-8?B?QVJKTHdPMXhLYUM3eEYwUlFLei9UOWN3TnJzYmxOdUN5WnBTbzJhL1F4SlhB?=
 =?utf-8?B?YmRXK0JPZWJtMktWNFBjc0gxQTZuMVBieWk2SFdqcTZJOXQ3UEp2eTVEeFNH?=
 =?utf-8?B?UFcrYmhCeHBHK2RyaW9hZ3oxK3FNSEFqUnYzMlVsVXlyeUY1bytZRkZhWWI0?=
 =?utf-8?B?bkRtLzQ2TnhvM0Z6RHllQUhXRERiWDZuWWZ6ckdCVldVQk14ZHVnN1R3b2pi?=
 =?utf-8?B?VkNFaGpybSswU0JoNGxodEo2eDN0OWNtRDNENkt5OVdwdC9GOW9Fd2dGMFIw?=
 =?utf-8?B?NVYwZ0lWV0p4R1F5L0pxbi95QVU0UmRJbXFjRXFra2RhS2dzcGFSUjVvbnpw?=
 =?utf-8?B?UnJENHRRQmJzSVV2cTJKd0VZdWVvbGwrUjh2bUZVdkdmNjRLWjVoSUVKTWs2?=
 =?utf-8?B?bThUV0hXY2U5NWQyZndCaFBTZy90NllzVzNoYis2d3RxYnQ2bzVaMjkrRnNS?=
 =?utf-8?B?VllRQ1FlYU90VE5keS9SNmN3YWRvVXQ4QTJBRXZJbG9uam1QNkV5QjFWYndT?=
 =?utf-8?B?NEhHQTl2VC9aQis5cGJuTVYvQzVHQTBCV1prNG50bkExYVhVeWwxUlVrQVJ5?=
 =?utf-8?B?dWtHMEI0YUoxdDFYSElaSjg4VWpqcHpRdjFXbEF5M0crZUgvRGJqelo2WUlv?=
 =?utf-8?B?TEErRTdBRGxkay93UnZCYVQrR0gzdW1ldFZGK1FBNUFMRnF2dGtSRWxZMWJY?=
 =?utf-8?B?TFhNdC9YemVVU3hVbE5KRlBtb1dzb3VUWUVDMWtaZDJIc3I2bVFBUnVNRUph?=
 =?utf-8?B?ZHZSRElMU1RYNzlDbW91WHd3djBDbXJ3SDhGbnhwczZQdm13cDJ6amJKc0tO?=
 =?utf-8?B?MGExY1JrOVBudTgwdTRlRnFYZWk5eHRUOUZRSFFWL29zZmJmeStQekRVemFW?=
 =?utf-8?B?dUVCM2xhU3RtUGhFc25LYmJjNGpmanFiSCtqNGREbVNUb0J5eUVtR0kxaVVO?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C603F7A27AD74CBFD814A9449F0658@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7bdc8-5256-4a82-5f3c-08dc4adae2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2024 01:45:14.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60d5wcskZr8knXs71dbLkNiU3lV1z5wIqn8UFr+UU+m7la9v1e1CUdLO3jR+81zIL4kTs92OZcH2LFm3NEnRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7842
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.134800-8.000000
X-TMASE-MatchedRID: dwNgap4H9hjUL3YCMmnG4qwOh3D3JSTGEtdrY/Wb3fPagsZM0qVv18kU
	hKWc+gwPPBFZl58NoSlD3kWOn9N9u8cUiDRLzlgWbQ9aoPSmWJEk227IvqakhZTx+2LIqNmtEoN
	4n3g9Rrade+14hSjSvEl6C4RBaEbWC+lqh+lpl95PuMJi/ZAk8UCrr/LkAQ46I0YrtQLsSUy8Hu
	EMlEAK6PHzNepWgkJSiSBtKT/MiwZC/bXMk2XQLIMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7ihe0
	NbIqiwBMIu1C8WsGUiTWEjLO8RtpkmNVYeOcj3jPpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.134800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F7E023469A1B43954A57A06F6B018C81D56DC2DFB998973C0424E80C09A887A52000:8

RGVhciBOaWNvbGFzLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3aW5nLg0KDQpPbiBGcmksIDIw
MjQtMDMtMjIgYXQgMTA6NDQgLTA0MDAsIE5pY29sYXMgRHVmcmVzbmUgd3JvdGU6DQo+IEhpLA0K
PiANCj4gTGUgbWVyY3JlZGkgMjAgbWFycyAyMDI0IMOgIDE0OjEzICswODAwLCBJcnVpIFdhbmcg
YSDDqWNyaXQgOg0KPiA+IEhhbmRsZSBpbnZhbGlkIGRlY29kZXIgdnNpIGluIHZwdV9kZWNfaW5p
dCB0byBlbnN1cmUgdGhlIGRlY29kZXINCj4gPiB2c2kgaXMNCj4gPiB2YWxpZCBmb3IgZnV0dXJl
IHVzZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBJcnVpIFdhbmcgPGlydWkud2FuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29k
ZWMvZGVjb2Rlci92ZGVjX3ZwdV9pZi5jICAgIHwgNg0KPiA+ICsrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjX3ZwdV9pZi5j
DQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3Zk
ZWNfdnB1X2lmLmMNCj4gPiBpbmRleCA4MmU1N2FlOTgzZDUuLjE3NzcwOTkzZmU1YSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVy
L3ZkZWNfdnB1X2lmLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy9kZWNvZGVyL3ZkZWNfdnB1X2lmLmMNCj4gPiBAQCAtMjMxLDYgKzIzMSwxMiBAQCBp
bnQgdnB1X2RlY19pbml0KHN0cnVjdCB2ZGVjX3ZwdV9pbnN0ICp2cHUpDQo+ID4gIAltdGtfdmRl
Y19kZWJ1Zyh2cHUtPmN0eCwgInZkZWNfaW5zdD0lcCIsIHZwdSk7DQo+ID4gIA0KPiA+ICAJZXJy
ID0gdmNvZGVjX3ZwdV9zZW5kX21zZyh2cHUsICh2b2lkICopJm1zZywgc2l6ZW9mKG1zZykpOw0K
PiA+ICsNCj4gPiArCWlmIChJU19FUlJfT1JfTlVMTCh2cHUtPnZzaSkpIHsNCj4gPiArCQltdGtf
dmRlY19lcnIodnB1LT5jdHgsICJpbnZhbGlkIHZkZWMgdnNpLCBzdGF0dXM9JWQiLA0KPiA+IGVy
cik7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gTWFrZSBz
ZW5zZSwgdGhvdWdoIG9uIHRoZSBjb3NtZXRpYyBzaWRlLCB3ZXJlIGlzIHRoZSBlcnIgdmFsdWUg
ZnJvbQ0KPiBpZiB0aGUgdnNpDQo+IHBvaW50ZXIgaXMgTlVMTCA/DQoNCkRvIHlvdSBtZWFuIHRo
ZSByZXR1cm5lZCAnZXJyJz8sIGl0J3MgdGhlIHN0YXR1cyB2YWx1ZSByZXR1cm5lZCBieQ0KJ3Nl
bmQgbWVzc2FnZScuIEV2ZW4gaWYgdGhlICd2c2knIGlzIE5VTEwsIHRoZSByZXR1cm5lZCBzdGF0
dXMgdmFsdWUNCidlcnInIG1heSBzdGlsbCBiZSAnTk9fRVJST1InLCB0aGVyZSBpcyBubyBkaXJl
Y3QgcmVsYXRpb25zaGlwIGJldHdlZW4NCnRoZW0uDQoNCklmIEkgbWlzdW5kZXJzdG9vZCB5b3Vy
IHF1ZXN0aW9uLCBwbGVhc2UgY29ycmVjdCBtZS4gVGhhbmsgeW91IHZlcnkNCm11Y2guDQoNCj4g
DQo+IE5pY29sYXMNCj4gDQo+ID4gIAltdGtfdmRlY19kZWJ1Zyh2cHUtPmN0eCwgIi0gcmV0PSVk
IiwgZXJyKTsNCj4gPiAgCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gDQo+IA0K

