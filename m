Return-Path: <linux-kernel+bounces-146095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C88A6090
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B958281C24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5838825;
	Tue, 16 Apr 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LBUc9F/3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Fjef/oL4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2F10A16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232257; cv=fail; b=Ic/VVLxl+mdedU/sYqmaOVP4uCmbh7TDO4JBvWBU/JNMj9C+jl6ItZFKhwBWLxrMbsgxbi4BBkg4mfAzyRntfhoV3Ox7frsHqyAPdxzdur9R7eiG/8Jpr44MzA01DWOMtO03j6j1gM06YgmPTPbdfw9uB0K8xzHGjaZjp6EW4RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232257; c=relaxed/simple;
	bh=dySE8Z+v4NYPEFVP+jzeCHR2rtOCZLxOAR8Ab+dSTFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFQNFyT7QFLeGYahyddL8yautYZVcLhKRo3MPYSEq10yJ1KHi+WZOkTMKUc6pMQ1IOYMwixfUJGt0PDo2YcmzMgnQT5GErfwhQurfDuT3AQt3h9x99unbsuzMFA1jTZLK24dsTU0fzfcj7SolS+quVsv6bLBY7euir7eDkX4EzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LBUc9F/3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Fjef/oL4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c0f6e3a8fb9311ee935d6952f98a51a9-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dySE8Z+v4NYPEFVP+jzeCHR2rtOCZLxOAR8Ab+dSTFI=;
	b=LBUc9F/3e8B2vm57AV45S2wJ5V5ByEtf2r2Qn0RcXbSAMtZqXrm5GHe0noUKqG+WX/QNlJ0ppV2nlFhIC/f3TwIsCmZh1ovgRwsR4Glig0MURWpVXonpNxioYeh10icOZWJFSFHR1uoBSMUJ2rMiSaVZRJqh9WSykb6BHKMVl64=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9abaf905-e0a6-4015-8fe8-2f974573f24f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:26a1f3fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c0f6e3a8fb9311ee935d6952f98a51a9-20240416
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <light.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 87973952; Tue, 16 Apr 2024 09:50:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 09:50:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 09:50:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOknicPyhf11WTx+ps0ppQcDaA8L6PSIkfFtr8vD2rQnEoY3SM4bL/jRJGB4eki2mLqksXQHRhJF1Tw2uR/wFK2OnwPoRnls/G8vFPcduvMEQHuIADienyCUE6Xf3eEbPQwhKgzkGq7InAXXO03LC5o5YKZjbmRIt1iMJAt3hN1D75ggxKVcrVwI2Dj91EGZ+OyZ8QLuHYhrKtPUvrEDcwwRXzgOHHC8vucWYVKwQjHTb82jXdutDEa+BbqOoGqr9lli8iMx7x8MLGQWaJJlX8HORlP70AS+ZVZzsLQD7Gco3xHzLGKwoase1jvrQ9wBpgDiVeYSluUmC+KsOtRKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dySE8Z+v4NYPEFVP+jzeCHR2rtOCZLxOAR8Ab+dSTFI=;
 b=ikqEQqrqaAJw2lGLg4iXkWF7+8iYkSpmpUXdnSsdaZz5vNAAukK+k+wFuPoCe9KlXctFbKNOlZ7MZAtLYPFuMROIKiAAyVIYtwtnTjiO3HsSwCGqzmqRddcDFQLPnmtA2sU81LzJo7J29WK7uwPU8zwVqK7cczSPbkJVdKX95Nmwvlr7ISqFbwWwG+jBp7aY6k+iVabSnDH1khj6ReiEHrDhsZW4NPw7EgPKdj9sZqUzRpIWN0u25UEoDqrc7GKSz1Qt5iBZ9iYlXTP7dQKyAWeO6BODSRE3UCH4kHeDfj0KzIsYllBC9OEH3IlIV61Ry+29V5TFnSL3OUzUhVUxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dySE8Z+v4NYPEFVP+jzeCHR2rtOCZLxOAR8Ab+dSTFI=;
 b=Fjef/oL4HdRo1EsoEInJpa0itYLzeurf5OcFq7vDH8atg+cuKCJ5LjECVzhI5flpAlOx2/4XT3o2Z4Mu/jwI7Tr/T2cAr5WSQvwyGAJrEo2AjE6xab7zcK7/OnsR2BuBCV3LDq+tMcaN9Vzr+B9qe9Zhd083BUqV+NJXVfk/L7g=
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) by
 TYZPR03MB8343.apcprd03.prod.outlook.com (2603:1096:405:26::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 01:50:48 +0000
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::4b3e:d779:27e3:3a08]) by SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::4b3e:d779:27e3:3a08%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 01:50:47 +0000
From: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Hillf Danton <hdanton@sina.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjog5Zue6KaGOiBbUEFUQ0hdIGYyZnM6?=
 =?utf-8?B?IGF2b2lkIHRoZSBkZWFkbG9jayBjYXNlIHdoZW4gc3RvcHBpbmcgZGlzY2Fy?=
 =?utf-8?Q?d_thread?=
Thread-Topic: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjogW1BBVENIXSBmMmZzOiBhdm9pZCB0?=
 =?utf-8?Q?he_deadlock_case_when_stopping_discard_thread?=
Thread-Index: AQHae+EjGuIimSJa2U6kUjro/ZAA7bFC6B+AgAAWVxiAAVk0AIAF7G8AgABpwiuAC0nn94ACpKEAgAtJPA+AAVjNAIAFCedA
Date: Tue, 16 Apr 2024 01:50:47 +0000
Message-ID: <SI2PR03MB5260A533CE9E9466F5E14FC684082@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com> <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zf4FIAkI83GbQYLB@google.com> <ZgL9NLLiSdDeIMg_@google.com>
 <SI2PR03MB526041E42B6BD9C9DA9FBAC184352@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <SI2PR03MB5260819B5B1719063EFF458A843D2@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zg8Fvu1X_4uqQl9A@google.com>
 <SI2PR03MB52608626CE591F850F5F815384042@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zhmepjudrjw0RRhn@google.com>
In-Reply-To: <Zhmepjudrjw0RRhn@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5260:EE_|TYZPR03MB8343:EE_
x-ms-office365-filtering-correlation-id: fe5b98a3-e954-42d0-e6ef-08dc5db7a33d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?enFqY0lYd1BVUW1PZ2hHME01bHFQL3BnS21CSXRLZE5zb2J0MjFlcFFJSEN1?=
 =?utf-8?B?QnZrVVEzYjZMSDdPVDM3RE9IeDhmNkppUjYza1ZrNVdFNnRTN1l0dkJsRkpQ?=
 =?utf-8?B?ak1VQUtMc1NERXRnR3QrUEZrQzVRellMYys0VU5MUm9jandnaHd2cHBBZEhK?=
 =?utf-8?B?NkdqVGZMZnJaK2E0aURpNEtkNW1zSSt6d1JyVDluSDV0VVdCdVJpTHdWTHhS?=
 =?utf-8?B?ZXIzdVcwZ2dlN2hiN2prZWgyeWxqNHh1UThKejEyYnY1TFAzMG9WTjZhaU1l?=
 =?utf-8?B?ZnpNTEFjZkF6UW16WFIwWnovUjlPTlVCRWRFRjFBSWJ5OWNQUmpuTjhJOTl2?=
 =?utf-8?B?SFJOTTJHTVRoM0FuSkorQ0pUS2dRSm80RDNiZDVFZ3pmeEtYdXY5NmJsb09D?=
 =?utf-8?B?dmh3aEgzOXBESmhNV1pSOVVZS0o4ZGtXNTBoWWdhc3pvWnFGbUlQMDRKbXph?=
 =?utf-8?B?eEYzVHRmQWNZUkRuYnRkRmw3MUVhYTFUUVhxRUJJQlh3emFXUCtCelZ1cjhv?=
 =?utf-8?B?THhKUGNZYit1dmhwQ1lzM00rbnhFL3dYYnhIVXpnY0tNYVlzQzlBQXVMZTFS?=
 =?utf-8?B?bkJISDZqajFQS0pKMDlqOFJUUi93Vk5pYjNLc3VNSjRCZVJOOVBha1BJQnR4?=
 =?utf-8?B?a0xLdUxZbHlCK2dOb0FNaTR4KzRqeDkrUEIxRStBam03WEJGamkzUGcrd3R0?=
 =?utf-8?B?RysweTYrazBOZkhhdW1XL2RoeEk0OHQzYlZhL05MZ1hiWm9TdkhKaGhvYllj?=
 =?utf-8?B?aEVBTlkvYU92V214U0ViTFg2QlBqWUlVQWJvRXkwY2YvZCtEM2x5Rms5WVY0?=
 =?utf-8?B?dytjYzl4aW5tV2RZVm9DTlJKVzFreFFwdW8vKzlSQU9FYkNYVDYyMVh3Tmha?=
 =?utf-8?B?c1orKzl4WEYxa0dqWlYyNWxCajlqVzhTc0ZLcEZ6bFZ0bHlaR2NjS3UzR3dV?=
 =?utf-8?B?Q2d0bXcrWEhyT01zdWhIUzNacDUybHhpRFkxbmpZcTZCZGhQRnFoNXJiRm5Y?=
 =?utf-8?B?U24wT2Vub0taMnNaY0R0aVd2dzdoVjBiLzNldmpPeDFuMVJFQzNrcU1jaEJM?=
 =?utf-8?B?a3l6SFFYaW1XOWxKOXYyTDZMbkRsL0FSdnpQYW51RTJjTnBMbUZpMXcrSTI4?=
 =?utf-8?B?WUxNR1FsQXk1U0ZjbDQvTkxGbzlnNmZNSVBuSEhqb2lBR3VEbEJvQ2VESko2?=
 =?utf-8?B?anh3Rm5zQTZuNTlGcEdGaUYrai8rTnQ3Y2NiSWMvWGhJc00yZzFTSGZjRGRx?=
 =?utf-8?B?Y1pIeGMwT011WnBrYUplSHBNYUZLRnljT2YyVHBTU0xzTXRUWXlwclFiTld5?=
 =?utf-8?B?cHpxUDIxbWRWeksyR2pCTTBFdWxyc1A4WUtwUlM3WWw5dmR2cFVxUHlKWEFM?=
 =?utf-8?B?TWZxc09VWlo5TS91Y2MzTFJoQ0pUN3pKYW5ZQndqMElMZk1UbVpvc0RXNU9D?=
 =?utf-8?B?N0x2UExjaWltckE3RTZxS0hjRXdqOElCZ2ZrUWo2VDRmMEtPNEhGZkR6SE96?=
 =?utf-8?B?OTFJdTcyYzlGL2k2Um5oOE9GMlZsQVlYemtZQ1NaMVRwUTBjR2NuNCt5c0E0?=
 =?utf-8?B?MS9QZzlZR0dvSWlONEZVQXFCbDM0a2dXWkMwZUhOdkpleDFqWXM3SmRvZ1hn?=
 =?utf-8?B?eEtCZm5OSEl6RVl0ZmYvdCs2SWQ1aEpXK0J3V0t6bDQxVzRmZ0RiSFVpeFJa?=
 =?utf-8?B?OUZDdUtVSVFkOG9xN1dpTE1XK2VtL3hyMWkybjN4ZG8vSHBIaEluMWp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5260.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21QSUJ5Ri9GbEVhek1GWFk4ZmQzRUthRzlQWkIwbEc0YldieGNCYklVK1I3?=
 =?utf-8?B?TDYvSkc3UGx3ZzZQdWhIcG0vQ3ZIT2NNZXJ1aFBrMXF6L1hpQTVaaE9RMFVB?=
 =?utf-8?B?VkkxdndrY2pGenZBUjhodi9lQVUzYk1wdkFEYkNNNkFheHVua3Z6dHEyaGkw?=
 =?utf-8?B?dUVpZU50MmtIQmFzam1jMUpjeHFIR1ZxUlQxUWR6ckJCaUVmU3hYZTcxYWcz?=
 =?utf-8?B?YytBVTNndkFDMTRjYUJJYm5SbkVISXVRS2w5eGx3bkdBMFM1WlZTM0NFNzZr?=
 =?utf-8?B?N0svd2dLd3pmSkRlaXNEUytaa1dDK2N0d1ltV3dMK21jaEZjVHo2ZTJpbzg4?=
 =?utf-8?B?K1d2MnZRdWpaUWxqSXNBWWFQVDRNbFV6dXRhSGg5U1FHVTlJT29FUi9pMlMy?=
 =?utf-8?B?WDZMa3Z4bFlpQkZUYnNLRnl4L3F1aTNHMDI5QVUzRlNibHJYNUU3SWNtSWxT?=
 =?utf-8?B?NGZhYTIvdEFFTHBFN0wwVWNyVm1YUVBPUlpTUDlYeW01U1phKy9ENWNUV3BB?=
 =?utf-8?B?djZtMTl3UE5uY05uRmdTZXo4NUNOV3VMMHRQd20zWDZuVWp1UGxiYnEvb283?=
 =?utf-8?B?OXVDK0JpOHRBaG9rbHVFalI5MXBKVWN6WjJCdVRQT3NTZk11Sjc3aHVwRnpk?=
 =?utf-8?B?NkVPcjVjS0kraldQYWN1QllPMnM1TmZJQ0t1c2tSMTA4Ynk1UmlRcWdMdzZo?=
 =?utf-8?B?ejVyR1d0NmIrWG9iWjFBc2dlOVJPVU5xYllROWVySEs3OFg2ZWh1bTFQU1pJ?=
 =?utf-8?B?WVRNRkxpeW5FbDFFMTlHdHM2ejE3RkdQVm5pcXFjanVZRWxsZk1haW5NNmR0?=
 =?utf-8?B?REpUL1U5NmdSc2tRYkExY3FRZXIwSnljSlZmc0FENTByM0YxTFBobWwzYXIr?=
 =?utf-8?B?MlY2SVZ5NG40ZG54blY2SFpkbTJyZ2F4QWFsaTlSK29tcGs3TmQ1Y2s0OGt2?=
 =?utf-8?B?dXkvcHlSUlJYV2JCRU1MSjZuTnNvTHFNTzl5YVdIRWs0ZzZOMmJueU1VQXdM?=
 =?utf-8?B?UFhPSXhvZ3Y4RitLcWhrYjJKdUpCMUdUclpmNXNzWW1qcmdJWW96WEN3dnBu?=
 =?utf-8?B?NHhnTjBmZHBIYzJuSHl3bTJWcXpyUTBpc2tFdG03Q09OVXhpZTROSitLZDc2?=
 =?utf-8?B?ek5TbUVYOGtHZ2JTQlRTZGJMRC9xaUEwem5jNEMyaXNzZXE4VzJrSGNyU1Vv?=
 =?utf-8?B?RnNDSklCL3ROMUZhZ20xa0NDRU5aeHdkelZHcWVxNFF6cHd2cFh1S2dXMGMw?=
 =?utf-8?B?clRWMks3L2hwZkgwSkt2bzJYZUtNSWc0WlpBVkNJTnhRUHN1ekl2VTY2S09X?=
 =?utf-8?B?VlVoalhEMnFQb0FybEpTSkk1eXNGUndxT0ZneDRMN252QnZKcCs4b2ErSmY0?=
 =?utf-8?B?VEtqcEd3RHVsMWVERTJzeFoyZGNNSHNOTUtKWngrZG1RK2tVc2xXcDdPRXU1?=
 =?utf-8?B?WGJBWDJPbGNRcXIrNy9vblRCRjFPUk1adnYvT29LczF6S0Q3VXlEUktHYSt0?=
 =?utf-8?B?TFVobnYvR2RZNWx5dzI1M1g1Zm5kbjkxNHNJck1GQXRzbTg4Y2VIdGl0MXps?=
 =?utf-8?B?Mm1Ha3RuajNIZmw0RFRzc0J4WUhrc0w0QmQ0Yk9DYjhTb2lWeHNDV016cHlM?=
 =?utf-8?B?ejAxakRENXVqVjFiUEdBYVBhL2s1T0JzNlZINCsvbzYzY011NWRZa0JQdnNv?=
 =?utf-8?B?Qmo2VmlUUVZQcG14YzFJYkY4bVpxNk1xZFNSWjBSZEVkRlRpUVJhWjF2aURs?=
 =?utf-8?B?RWlRZ282VG1aejhtOUQrZ01waG9BaXN0dkdMNU5XSE5kVExJbG9sck8xS1Jo?=
 =?utf-8?B?eVovYTVidzdyWk90bGVOYlBxQ0dpc1lFOUJPZmRxc2VtdmNRdmQrU2lGQTY5?=
 =?utf-8?B?bVV2RGd6aVpLY1MzbmpzaWtWeGd5cXRkcGw5NlZWdjlkYTZCYU9kY1VHTGhN?=
 =?utf-8?B?ZG5RQW1oeDdGajc0eUlCN01sS3A0ODVOS3ljR3JCbG9UNUVQbFpaVWlWeGJK?=
 =?utf-8?B?Mk5HbTN0SDQrQkdUNm1BemRoR3Z1QkNKamtQMGptaUdneUV6OUpzQVlDa2Ji?=
 =?utf-8?B?WTVZSmV5L3dQbmlabFBXREFOMVFNakpHZ2c0dVVGTUZMbWM1ZXoxN2lFcm93?=
 =?utf-8?Q?YI0VYUB6Y75JUeU3I0IJBXCDq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5260.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5b98a3-e954-42d0-e6ef-08dc5db7a33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 01:50:47.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyIetB+kk6kAE7sDWc8wNybLTk7L8rRYrIOkY6jNmnZEinNpBU+b6UJQAJ26EOlqVWVDpMY2OlQLHQRuL2DekcdOcoVUdFCUcCP/ARS7x1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8343

Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJmcy1kZXZlbC8yMDI0MDQwNDE5NTI1
NC41NTY4OTYtMS1qYWVnZXVrQGtlcm5lbC5vcmcvVC8jdQoKV2l0aCBwcm92aWRlZCBwYXRjaCwg
aXNzdWUgZG9lcyBub3Qgb2NjdXIgZHVyaW5nICA2MGhvdXJzIHRlc3QuCgpQbGVhc2UgaGVscCBt
ZXJnZSB0aGlzIHBhdGNoIGludG8gQUNLIGFsc28uCgpMaWdodAoKCgrlr4Tku7bogIU6wqBKYWVn
ZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgrlr4Tku7bml6XmnJ86wqAyMDI05bm0NOaciDEz
5pelIOS4iuWNiCAwNDo1MArmlLbku7bogIU6wqBMaWdodCBIc2llaCAo6Kyd5piO54eIKSA8TGln
aHQuSHNpZWhAbWVkaWF0ZWsuY29tPgrlia/mnKw6wqBIaWxsZiBEYW50b24gPGhkYW50b25Ac2lu
YS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQgPGxpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PgrkuLvml6g6wqBSZTog5Zue6KaGOiDl
m57opoY6IOWbnuimhjogW1BBVENIXSBmMmZzOiBhdm9pZCB0aGUgZGVhZGxvY2sgY2FzZSB3aGVu
IHN0b3BwaW5nIGRpc2NhcmQgdGhyZWFkCsKgCgpPbiAwNC8xMiwgTGlnaHQgSHNpZWggKOisneaY
jueHiCkgd3JvdGU6Cj4gSSB0aGluayAncmVhZG9uJyBpbiB0aGlzIGxpbmUgbWF5IGJlIHR5cG8g
b2YgwqAncmVhc29uJwoKV2FzIGZpeGVkIGFzIHdlbGwuIFRoYW5rcy4KCj4gCj4gK2YyZnNfd2Fy
bihzYmksICJTdG9wcGVkIGZpbGVzeXN0ZW0gZHVlIHRvIHJlYWRvbjogJWQiLCByZWFzb24pOwo+
IAo+IAo+IAo+IOWvhOS7tuiAhTrCoEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4g
5a+E5Lu25pel5pyfOsKgMjAyNOW5tDTmnIg15pelIOS4iuWNiCAwMzo1NQo+IOaUtuS7tuiAhTrC
oExpZ2h0IEhzaWVoICjorJ3mmI7nh4gpIDxMaWdodC5Ic2llaEBtZWRpYXRlay5jb20+Cj4g5Ymv
5pysOsKgSGlsbGYgRGFudG9uIDxoZGFudG9uQHNpbmEuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0IDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldD4KPiDkuLvml6g6wqBSZTog5Zue6KaGOiDlm57opoY6IFtQQVRDSF0gZjJmczogYXZv
aWQgdGhlIGRlYWRsb2NrIGNhc2Ugd2hlbiBzdG9wcGluZyBkaXNjYXJkIHRocmVhZAo+IMKgCj4g
Cj4gT24gMDQvMDMsIExpZ2h0IEhzaWVoICjorJ3mmI7nh4gpIHdyb3RlOgo+ID4gT3VyIGxvZyBz
aG93cyB0aGF0IHRoYXdfc3VwZXJfbG9ja2VkKCkgZmluZCB0aGF0IHNiIGlzIHJlYWRvbmx5LMKg
c28gc2JfZnJlZXplX3VubG9jaygpIGlzIG5vdCBpbnZva2VkLgo+ID4gCj4gPiBzdGF0aWMgaW50
IHRoYXdfc3VwZXJfbG9ja2VkKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGVudW0gZnJlZXplX2hv
bGRlciB3aG8pCj4gPiB7Cj4gPiDigILigILigILigILigILigIIuLi4KPiA+IOKAguKAguKAguKA
guKAguKAgmlmIChzYl9yZG9ubHkoc2IpKSB7Cj4gPiDigILigILigILigILigILigILigILigILi
gILigILigILigIJzYi0+c193cml0ZXJzLmZyZWV6ZV9ob2xkZXJzICY9IH53aG87Cj4gPiDigILi
gILigILigILigILigILigILigILigILigILigILigIJzYi0+c193cml0ZXJzLmZyb3plbiA9IFNC
X1VORlJPWkVOOwo+ID4g4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCd2FrZV91
cF92YXIoJnNiLT5zX3dyaXRlcnMuZnJvemVuKTsKPiA+IOKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAgmdvdG8gb3V0Owo+ID4g4oCC4oCC4oCC4oCC4oCC4oCCfQo+ID4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAuLi4KPiA+IOKAguKAguKAguKAguKAguKAgnNiX2ZyZWV6ZV91bmxv
Y2soc2IsIFNCX0ZSRUVaRV9GUyk7Cj4gPiBvdXQ6Cj4gPiDigILigILigILigILigILigIJkZWFj
dGl2YXRlX2xvY2tlZF9zdXBlcihzYik7Cj4gPiDigILigILigILigILigILigIJyZXR1cm4gMDsK
PiA+IH0KPiAKPiBUaGFuayB5b3UuIENvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhp
cyBwYXRjaD8KPiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIw
MjQwNDA0MTk1MjU0LjU1Njg5Ni0xLWphZWdldWtAa2VybmVsLm9yZy9ULyN1Cj4gCj4gPiAKPiA+
IOWvhOS7tuiAhTrCoEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gPiDlr4Tku7bm
l6XmnJ86wqAyMDI05bm0M+aciDI35pelIOS4iuWNiCAxMjo1Mgo+ID4g5pS25Lu26ICFOsKgTGln
aHQgSHNpZWggKOisneaYjueHiCkgPExpZ2h0LkhzaWVoQG1lZGlhdGVrLmNvbT4KPiA+IOWJr+ac
rDrCoEhpbGxmIERhbnRvbiA8aGRhbnRvbkBzaW5hLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQ+Cj4gPiDkuLvml6g6wqBSZTog5Zue6KaGOiBbUEFUQ0hdIGYyZnM6IGF2b2lkIHRoZSBk
ZWFkbG9jayBjYXNlIHdoZW4gc3RvcHBpbmcgZGlzY2FyZCB0aHJlYWQKPiA+IMKgCj4gPiAKPiA+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
Cj4gPiBPbiAwMy8yMiwgSmFlZ2V1ayBLaW0gd3JvdGU6Cj4gPiA+IE9uIDAzLzIyLCBMaWdodCBI
c2llaCAo6Kyd5piO54eIKSB3cm90ZToKPiA+ID4gPiBJIGRvbid0IHNlZSBteSBhZGRlZCBsb2cg
aW4gc2JfZnJlZV91bmxvY2soKSB3aGljaCB3aWxsIGludm9rZSBwZXJjcHVfdXBfd3JpdGUgdG8g
cmVsZWFzZSB0aGUgd3JpdGUgc2VtYXBob3JlLgo+ID4gPiAKPiA+ID4gTWF5IEkgYXNrIG1vcmUg
ZGV0YWlscyB3aGV0aGVyIHRoYXdfc3VwZXIoKSB3YXMgY2FsbGVkIG9yIG5vdD8KPiA+IAo+ID4g
UGluZz8KPiA+IAo+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+ID4gPiA+IOWvhOS7tuiAhTogSmFlZ2V1ayBLaW0gPGphZWdl
dWtAa2VybmVsLm9yZz4KPiA+ID4gPiDlr4Tku7bml6XmnJ86IDIwMjTlubQz5pyIMjLml6Ug5LiK
5Y2IIDA4OjI5Cj4gPiA+ID4g5pS25Lu26ICFOiBIaWxsZiBEYW50b24gPGhkYW50b25Ac2luYS5j
b20+Cj4gPiA+ID4g5Ymv5pysOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGlnaHQgSHNpZWggKOisneaYjueHiCkgPExpZ2h0Lkhz
aWVoQG1lZGlhdGVrLmNvbT47IGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
IDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiA+ID4gPiDkuLvml6g6
IFJlOiBbUEFUQ0hdIGYyZnM6IGF2b2lkIHRoZSBkZWFkbG9jayBjYXNlIHdoZW4gc3RvcHBpbmcg
ZGlzY2FyZCB0aHJlYWQKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lgo+ID4gPiA+IAo+ID4gPiA+
IE9uIDAzLzIyLCBIaWxsZiBEYW50b24gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIDE5IE1hciAy
MDI0IDE3OjE0OjQyIC0wNzAwIEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gPiA+
ID4gPiA+IGYyZnNfaW9jX3NodXRkb3duKEYyRlNfR09JTkdfRE9XTl9OT1NZTkMpIMKgaXNzdWVf
ZGlzY2FyZF90aHJlYWQKPiA+ID4gPiA+ID4gwqAtIG1udF93YW50X3dyaXRlX2ZpbGUoKQo+ID4g
PiA+ID4gPiDCoCDCoC0gc2Jfc3RhcnRfd3JpdGUoU0JfRlJFRVpFX1dSSVRFKQo+ID4gPiA+ID4g
wqBfX3NiX3N0YXJ0X3dyaXRlKCkKPiA+ID4gPiA+IMKgIMKgcGVyY3B1X2Rvd25fcmVhZCgpCj4g
PiA+ID4gPiA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBzYl9zdGFydF9pbnR3cml0ZShTQl9GUkVFWkVfRlMpOwo+
ID4gPiA+ID4gwqAgwqBfX3NiX3N0YXJ0X3dyaXRlKCkKPiA+ID4gPiA+IMKgIMKgIMKgcGVyY3B1
X2Rvd25fcmVhZCgpCj4gPiA+ID4gPgo+ID4gPiA+ID4gR2l2ZW4gbG9jayBhY3F1aXJlcnMgZm9y
IHJlYWQgb24gYm90aCBzaWRlcywgd3RmIGRlYWRsb2NrIGFyZSB5b3UgZml4aW5nPwo+ID4gPiA+
IAo+ID4gPiA+IERhbW4uIEkgY291bGRuJ3QgdGhpbmsgX3dyaXRlIHVzZXMgX3JlYWQgc2VtLgo+
ID4gPiA+IAo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gwqAtIGYyZnNfc3RvcF9jaGVja3BvaW50KHNi
aSwgZmFsc2UsIMKgIMKgIMKgIMKgIMKgIMKgOiB3YWl0aW5nCj4gPiA+ID4gPiA+IMKgIMKgIFNU
T1BfQ1BfUkVBU09OX1NIVVRET1dOKTsKPiA+ID4gPiA+ID4gwqAtIGYyZnNfc3RvcF9kaXNjYXJk
X3RocmVhZChzYmkpOwo+ID4gPiA+ID4gPiDCoCDCoC0ga3RocmVhZF9zdG9wKCkKPiA+ID4gPiA+
ID4gwqAgwqAgwqA6IHdhaXRpbmcKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gwqAtIG1udF9kcm9w
X3dyaXRlX2ZpbGUoZmlscCk7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gTW9yZSBpbXBvcnRhbnQsIGZl
ZWwgZnJlZSB0byBhZGQgaW4gc3Bpbi4KPiA+ID4gPiAKPiA+ID4gPiBJIHBvc3RlZCB0aGlzIHBh
dGNoIGJlZm9yZSBMaWdodCByZXBvcnRlZC4KPiA+ID4gPiAKPiA+ID4gPiBBbmQsIGluIHRoZSBy
ZXBvcnQsIEkgZGlkbid0IGdldCB0aGlzOgo+ID4gPiA+IAo+ID4gPiA+IGYyZnNfaW9jX3NodXRk
b3duKCkgLS0+IGZyZWV6ZV9iZGV2KCkgLS0+IGZyZWV6ZV9zdXBlcigpIC0tPiBzYl93YWl0X3dy
aXRlKHNiLCBTQl9GUkVFWkVfRlMpIC0tPiAuLi4gLT5wZXJjcHVfZG93bl93cml0ZSgpLgo+ID4g
PiA+IAo+ID4gPiA+IGJlY2F1c2UgZjJmc19pb2Nfc2h1dGRvd24oKSBjYWxscyBmMmZzX3N0b3Bf
ZGlzY2FyZF90aHJlYWQoKSBhZnRlciB0aGF3X2JkZXYoKQo+ID4gPiA+IGxpa2UgdGhpcyBvcmRl
ci4KPiA+ID4gPiAKPiA+ID4gPiDCoC0+IGZyZWV6ZV9iZGV2KCkKPiA+ID4gPiDCoC0+IHRoYXdf
YmRldigpCj4gPiA+ID4gwqAtPiBmMmZzX3N0b3BfZGlzY2FyZF90aHJlYWQoKQo+ID4gPiA+IAo+
ID4gPiA+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gPiA+ID4gCj4gPiA+ID4gPgo+ID4gPiA+
ID4gUmVwb3J0ZWQtYnk6ICJMaWdodCBIc2llaCAo6Kyd5piO54eIKSIgPExpZ2h0LkhzaWVoQG1l
ZGlhdGVrLmNvbT4KPiA+ID4gPiAK

