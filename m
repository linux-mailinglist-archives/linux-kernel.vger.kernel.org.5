Return-Path: <linux-kernel+bounces-75837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87F185EFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073BC1C21AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050BD1755C;
	Thu, 22 Feb 2024 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f/qWLu4+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t5v9d7kc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B028EF;
	Thu, 22 Feb 2024 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571502; cv=fail; b=rHDUY70WKH0v2GqWKB0cDNV9QWOgffaWPlE6s1YX5WDrq0YC1473oGE0/Wf1ziKucz8PO2/8/TzrF86ge+V0lxrz+tHEwwr2d/Xw8nZh9AhK+QfaOIUtWWtbUegSXXn5fOqQYjz6zl829MIlkx1MbJWEmIoYjqYSTvJwCTFSbt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571502; c=relaxed/simple;
	bh=/nMbrcglKDEtyWvTs307z0s5hILK4klJQtSVqH20GHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7Gk78ZjkRvtQdUqf196yxh3DGellrpGvtVBH8Rqyw/brAWH/yaud/CTN6u4wbgxko1K6iZMCx1i3DpuV6vxoNlrZ/EUFZS4CmKPLEJVwuyjMgBJaIZJefdONGREk+mbtmyjoQJX1ajdR6+RJ6VUkAeYRPM4Ewl+hcfVCJ9zy68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f/qWLu4+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=t5v9d7kc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1308e832d13011eea528b71b88a53856-20240222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/nMbrcglKDEtyWvTs307z0s5hILK4klJQtSVqH20GHE=;
	b=f/qWLu4+i3qNKCbaKNENNu7JmQe6m4Vo3LtShr33vbN8vqzmg5R+yAp7OdvaYar7o7m0driJfZjyKbIyR9U9jQ20h78AMJQuLaOyspi9VeP1cHetVRc4gHeTYBd7Wp4kscK99e9kOH6cgcw7VoNTKAGpv3ozklDWyLeOt96Qv3k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:efa3f811-0cce-4a2c-b7ad-b0954c3e36a4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e5d3928f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1308e832d13011eea528b71b88a53856-20240222
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 469357307; Thu, 22 Feb 2024 11:11:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Feb 2024 11:11:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Feb 2024 11:11:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzEzZ2n/nvoIVdi2q9VUzepVlOiupmGKySDKX7OJ86NXJ4aw9/Q/lGm+Yidw2j0AcdlQY09KXXXQ9aV2E8ZMrGDRAS+1xtHk4GEyIghP8vCBf4jCx03uJT21BJWT/ULpKw6p/keYRh/UE4KkDfKsPSeH6jM3fV+Kp7bMuW42tK6Lw06Kbsk4VaBqkycVidt7zb3/AtpCpWCSyBMCuefdhpkfTiNrS92TWrG5pgIS7aZ1JW65oegGDLRmRewfs7K/WNSH3EyJzMZc4uHRVkwVpUnMHs1uow1vzIO47NF73QityLl2mKDojy96a9XjwDjEZdMXN9KNtd3iwxDMNNWAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nMbrcglKDEtyWvTs307z0s5hILK4klJQtSVqH20GHE=;
 b=mri7IlCLIP6Sc6GEqv4CXn5oJfIEyrofsDMjT/dhrpwwSIgcLSxs5H3hWBw90MYdHJBqMVw8dco5PR4yGTGSZiE2gMZNmwvdDyMzk5l+yyKwNG5WGcFxzxphLA+6sQcX2BOi61CWh3UdXLEaeCkANzajcGwA17ALjAue8LrhOHIUOJUdnetBi+E+7ddoKdcEMqq1beR1pJJkQmT0S0SNjV/zQaAqR9nlfe+ouMe3ul8f//bbYRe80zmv2UPykolbrrlSLlIwYIBVKK45T1e0rAMKQX2EfXxz7jVYb1XPmXfRwnnCIhiFB73rQjGpjEfYBfh2GTJVk8tPUbrisIL20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nMbrcglKDEtyWvTs307z0s5hILK4klJQtSVqH20GHE=;
 b=t5v9d7kc+E5o+W8iXp2UqrrR6YPavRFm4jZtSeop+rX0qlO93raZcwJX6dCbvqBHZ0fity5ZMfE/hUPGvSICsgMlyMPX01uqjLspHwDl+YzHLRNmueA1kvE1vWKzhkfnItt6qyfWyTBSyki1OkZmrd+MJCc9jD5eCzBB6ZvcH/4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7644.apcprd03.prod.outlook.com (2603:1096:400:416::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 03:11:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7292.029; Thu, 22 Feb 2024
 03:11:26 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?=
	<Moudy.Ho@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 6/9] media: platform: mtk-mdp3: drop calling
 cmdq_pkt_finalize()
Thread-Topic: [PATCH 6/9] media: platform: mtk-mdp3: drop calling
 cmdq_pkt_finalize()
Thread-Index: AQHaX6kSXKmZDXp+Sk2UfWr2NrlM3LELNHMAgAFM0gCAABqbAIAJHnGA
Date: Thu, 22 Feb 2024 03:11:26 +0000
Message-ID: <143420847d70fd03763863c1a0a60751591d5240.camel@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
	 <20240215004931.3808-7-chunkuang.hu@kernel.org>
	 <4dcfaf49-aaac-4980-a149-02fec3109f31@collabora.com>
	 <af4bfdd52f0ca022730aedcb456bb1a0b105ae3e.camel@mediatek.com>
	 <b3c384b6-7c8f-4428-a62e-1036b78217cf@collabora.com>
In-Reply-To: <b3c384b6-7c8f-4428-a62e-1036b78217cf@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7644:EE_
x-ms-office365-filtering-correlation-id: 32fe8519-b902-47d6-c2e9-08dc3353f4cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6esd91PE1YpPYMsmpSn7Slla/9Yq5yUXAaeIfY+H4s/popy1/q4JOZ37AaQBqDbOqNAdGcWlb0U2xZGJyCP3hmHaO5xYQyYfxcekefQEUU/GdH/84XRP/0zcQgVI0RJsMF2syidmwFh4dnudxaDPZGkmAzAHX+b/JMMXjRdwvoXsGTCVnRs1HXBW2gBUDqb7aiNe5zsgJ6u0gWr3PrX0dUFfR3MmvdNfwpZtRUFJIdt9BWV89L1Pz9gb0atM5wyoiBttVNhMZhwLnfwd7TcR/06zYB7QPvkjHzaVBtYVXO0GEEOjOZ5zuNMTV/43jfigS+UAIBTCGbWrK1X54eZmd/5in5cOz66fFoknTGm9FBxR7b4SjY7TGZVPCr59JdP7FhL34B+0Dyr5R23aP8/Upq0ZIMaA3LzOVWpr2rhb2DffA10YPdn+eMojRMLJoGMuUuEOFzJr+o9QyJcvUFPmmGRjhZtPFmEq5CN0xCJG40haZyVfI4xq5jOgPzfe3qxpQ42Ux7a10xH5VH//pFn8mWCduEqCOPyQs3WJRsA3yoihbu2d0uUYsUOBz0bQv1AxGgQkI2vIE/YjYsuK3LLpTpcu8iTfeJGFzvGiQBKf9y5N3iHLVR9eO1jKStkRI4c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3VyandPK3ZNeEx4UWtpTDg1emVvWGVsYXMrR25JdFRLdzlkTStGV245ZlY4?=
 =?utf-8?B?b1F3cElTWHVzK0lyM0UvQUlaVXdiaGowQm1BMGJYMElzR2YyVGgxTFlYcGxM?=
 =?utf-8?B?UlMzWnFmbDlRTjVyb1Mzam1RY3N3UGFtMXo0c2kxYTBaVW1vK1IvdWdmU05s?=
 =?utf-8?B?WVIyUkZqVHZyUUpFM3pBK1M1WU9paW1Yd2xjQVJHMnpmaVA2T0QzK0poWUhi?=
 =?utf-8?B?LzV2UGVBeThiUmFaS1FrWHoxam1RVkhITFpKSHdnNTBXMkNTWkR0VE0waW9G?=
 =?utf-8?B?R2o2a1BNL3RCWWlnTXd4TWU2WU5PMDRTakFycDFZYlp5RkJaVVUxUGNsbjBX?=
 =?utf-8?B?bnRHa0N3d0V0R200VHlqLzFtUzdYeHJHaW5iRmlRa2dRd2pyQ1ZyVnRMYitp?=
 =?utf-8?B?UzNSQnFhL3dHc09aRDltKzBCbVNYVldvVDY1cXJ5VFZvQ3NWL3RhTUcza1FC?=
 =?utf-8?B?M1NYMHlWdll4Zy9qejVSa1Y1V3hUd21iMWh3aFBoT0I1U2k0ZU0yRWNVb0JR?=
 =?utf-8?B?VnRsMHZBaXV5OUthUzdkM1J6d3UzWGFzYmhWSWRzYVRBMTRIb1IxTjgyYWg5?=
 =?utf-8?B?OWVObzF6WTdmQmhjV1Z3bjV0RG9jVmI2RkpZTjlhZ2lTUlFHNE00R2dYQWdK?=
 =?utf-8?B?MnNKSjFQWEZOR1ZkdmZEd3JxdGJqbHdTTzBrVHcxeGYzbE5ma1RkS2puanlW?=
 =?utf-8?B?S08weE0walo2cDZkcldvWklpY28xbHZDaUVlZHMzR2lwSkE4Qi9xNWJoVUVJ?=
 =?utf-8?B?VnpTMlp2SE5kRlRRTkFaQkJZbDlxUE4yUVBXMjBsRWVpMHZTcDFKZTR6SXBJ?=
 =?utf-8?B?QlN1NWFDUFp0NDgwWDJzSXUvOFRsaStRc1h3YWRJdS80UHhKaXdUeGJyVDJE?=
 =?utf-8?B?cWZzQlFoWE0vdTJnS1l2TXRsVzU3VGt4TzlQbHlVbUNwV1R3cDFzSlMxODlV?=
 =?utf-8?B?UGliMjdBajJBNGJWYUUrZ3pyY0FyNGxhekNOTnBpNjZGeCswd2RzamVnaVZH?=
 =?utf-8?B?d1NJbFN1K01qdTRINDhPSTdSZkVLdWRsY0VrMDN4c3huaVEyOUdPS3hydmxO?=
 =?utf-8?B?UFFzRi9GRGEyOWpXS3FrNUltekhQamZHa3pjWkZBQWNWU2lMMWIvaUhMSXVT?=
 =?utf-8?B?OEM1cnFydFIvNzVJczZDM3J5MHBTSnV1Mko1ZTZKVHA3STQ2c21ydTR6N3Jj?=
 =?utf-8?B?MHg1TERVaWVtMHhWMGQvOHdRdkVsbTg3aWdVdFhPaHJqY05HelZDN3orTFJ4?=
 =?utf-8?B?ZldFNjlKMEp4alRaUkEzZ0U2YnVBdlRGYUJCLzZsL1p5b2FTUFJEUWpYNjFK?=
 =?utf-8?B?WGFQMW9Hb3dWaUlmbFB4RG1wSlYyRDZJdm53di90T1ZCZUhaeU1wL2tURVY2?=
 =?utf-8?B?NjhRb0c1dllhQk1FT1dnR1hncXAweFpmQ3g4dTE3MU1CcGE5ZDlyTUhCSmh5?=
 =?utf-8?B?RWJ0MWVwUnVybm1sUjYySnBQckxucG9iVEpzclBIM0RMd2dud1VKbGNQaVNK?=
 =?utf-8?B?dmFOdGtaYTVDN2tlV2huTjl0SlgreVJEUzJUN0krYUhZU1ZObFhvTjAxMzgy?=
 =?utf-8?B?cDNkWGtFRVpkTW5GZG1BQnJXdXlIckV5THl6aXoyeitPbWNHTmxuek5nTU1C?=
 =?utf-8?B?RUVRZ0RJUlRjQkdFVDEvVk52WGYxNE5zNVJxbmFLd0p5dGVPNEJ4MURocTRu?=
 =?utf-8?B?am9wRmNLYng2L0RNaXpIZnJETTcrdURzb1dMK2RBTGhaRlMxMElpZU04aElS?=
 =?utf-8?B?YlpQRXcwNTdLNWtyQmhBZHBwdUkrdjVRUndUTWRPZHl4RGRQaXFqc21iRm1P?=
 =?utf-8?B?VXdxK0pQSTdkZEpwR1pXZnpMTWNxY1E3TDdoeHdWd2FKeHpaOW4rZXN5em4y?=
 =?utf-8?B?NHFJTDlNdVY2bXVvVzBvTko0Tk51eXVvTFBHRHdmbDA4YTBqcERESC8rWnJD?=
 =?utf-8?B?b3I5TGJaalZZTnd1WVlKdWNOb3JONnp5VUpuRlFWVWNnWkZvZ1JLK3E3Tk1L?=
 =?utf-8?B?dlFCaDV3dyt5eGhLTFM4ZWFhNDZwY1htSUFYK1pVaGZlOXQrRXNuT2k5Z2pG?=
 =?utf-8?B?VDFUeHFTYVQ5dktnMEJIMEYxZXJKRHJOSGNiVzdRRFVhdDBGVEcyKzJ1YTBt?=
 =?utf-8?Q?UmaEHJ4R1Xg8Ypqd4FxBYZfbT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF73FB09613EDF4AAD5E52FF6609F83F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fe8519-b902-47d6-c2e9-08dc3353f4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 03:11:26.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3/5KYe5zAfY53BYm8E0Bc3x8qX4H/5nZBo5cF15hyqMeIkY4/nhAt+78/UGmDWk7Sq2kyoo/YMX3NxN1vq+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7644
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.478700-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGgNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDzndXi2
	YXWTaJQzjp580cxU1G1aRMdnMA7rPLM5yFdOCNfRX8uVX0T0kdSgD0t7xcmluh1jWjAZHoEnuyc
	hkLJfCifINZXen7hxyUpO4zY8xTkRhYCPK21sETu8coKUcaOOvQRryDXHx6oXmHy7uaiMrL4bAW
	T2SG9hnQb+gwlwIDxSMQS20wcmmUP8MPUrbremB3317SsjPnPrZa7LkubQvj/RziMbBeTI+epUO
	lu1Vn8QMqsQZEs57EhLxGnh6HMQ1l/ag3kgZsCOKaMQ6tw7oDK6hgVvSdGKo75FKKSYetLBLtPi
	+002mY/BfR/WU+6YOA2RIsmnQg20DgDuJ0RJJx+e7UdJp0QINX0tCKdnhB58pTwPRvSoXL2ZMPC
	nTMzfOiq2rl3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.478700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B3DAA88DE9C1F1EDA4B2D1E0D024452014219335AEF23E34E1EB51F9AC7A10DC2000:8

SGksIE1vdWR5Og0KDQpPbiBGcmksIDIwMjQtMDItMTYgYXQgMDg6NTYgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxNi8wMi8yNCAwNzoyMCwgTW91ZHkgSG8g
KOS9leWul+WOnykgaGEgc2NyaXR0bzoNCj4gPiBPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTE6Mjkg
KzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gd3JvdGU6DQo+ID4gPiBJbCAx
NS8wMi8yNCAwMTo0OSwgQ2h1bi1LdWFuZyBIdSBoYSBzY3JpdHRvOg0KPiA+ID4gPiBCZWNhdXNl
IGNsaWVudCBkcml2ZXIgaGFzIHRoZSBpbmZvcm1hdGlvbiBvZiBzdHJ1Y3QNCj4gPiA+ID4gY21k
cV9jbGllbnQsIHNvDQo+ID4gPiA+IGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBzdG9yZSBzdHJ1Y3Qg
Y21kcV9jbGllbnQgaW4gc3RydWN0DQo+ID4gPiA+IGNtZHFfcGt0Lg0KPiA+ID4gPiBjbWRxX3Br
dF9maW5hbGl6ZSgpIHVzZSBzdHJ1Y3QgY21kcV9jbGllbnQgaW4gc3RydWN0IGNtZHFfcGt0LA0K
PiA+ID4gPiBzbw0KPiA+ID4gPiBpdCdzDQo+ID4gPiA+IGdvaW5nIHRvIGJlIGFiYW5kb25lZC4g
VGhlcmVmb3JlLCB1c2UgY21kcV9wa3RfZW9jKCkgYW5kDQo+ID4gPiA+IGNtZHFfcGt0X25vcCgp
DQo+ID4gPiA+IHRvIHJlcGxhY2UgY21kcV9wa3RfZmluYWxpemUoKS4NCj4gPiA+IA0KPiA+ID4g
Tm8sIGl0J3Mgbm90IGJlY2F1c2UgY21kcV9wa3RfZmluYWxpemUoKSBoYXMgY21kcV9jbGllbnQs
IGJ1dA0KPiA+ID4gYmVjYXVzZQ0KPiA+ID4gd2Ugd2FudA0KPiA+ID4gZmluZXIgZ3JhaW4gY29u
dHJvbCBvdmVyIHRoZSBDTURRIHBhY2tldHMsIGFzIG5vdCBhbGwgY2FzZXMNCj4gPiA+IHJlcXVp
cmUNCj4gPiA+IHRoZSBOT1ANCj4gPiA+IHBhY2tldCB0byBiZSBhcHBlbmRlZCBhZnRlciBFT0Mu
DQo+ID4gPiANCj4gPiA+IEJlc2lkZXMsIGhvbmVzdGx5IEknbSBub3QgZXZlbiBzdXJlIGlmIHRo
ZSBOT1AgaXMgYWx3YXlzIHJlcXVpcmVkDQo+ID4gPiBpbg0KPiA+ID4gTURQMywgc28uLi4NCj4g
PiA+IA0KPiA+ID4gLi4uTW91ZHksIHlvdSBrbm93IHRoZSBNRFAzIHdheSBiZXR0ZXIgdGhhbiBh
bnlvbmUgZWxzZSAtIGNhbiB5b3UNCj4gPiA+IHBsZWFzZQ0KPiA+ID4gY2hlY2sgaWYgTk9QIGlz
IGFjdHVhbGx5IG5lZWRlZCBoZXJlPw0KPiA+ID4gDQo+ID4gPiBUaGFua3MhDQo+ID4gPiBBbmdl
bG8NCj4gPiA+IA0KPiA+IA0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBBZnRlciBjb25maXJt
aW5nIHdpdGggdGhlIGhhcmR3YXJlIGRlc2lnbmVyIGFuZCBwZXJmb3JtaW5nIHRoZQ0KPiA+IHZp
ZGVvDQo+ID4gcGxheWJhY2sgdGVzdCwgaXQgd2FzIGRpc2NvdmVyZWQgdGhhdCBNRFAzIGlzIGNh
cGFibGUgb2YgZXhjbHVkaW5nDQo+ID4gdGhlDQo+ID4gTk9QKGp1bXApIGluc3RydWN0aW9uLg0K
PiA+IA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGlzIGV4dHJlbWVseSBmYXN0IGNsYXJpZmljYXRp
b24uDQoNCkFzIGRpc2N1c3Mgd2l0aCBKYXNvbiwgdGhlcmUgaXMgb25lIHByZWNvbmRpdGlvbiB0
aGF0IG1kcDMgY291bGQgZHJvcA0Kbm9wLiBtcGQzIHN0aWxsIG5lZWQgdG8gYXBwZW5kIGp1bXAg
Y29tbWFuZCBpbiB0aGUgZW5kIG9mIHBhY2tldC4gVGhlDQpwcmVjb25kaXRpb24gaXMgdGhhdCBp
ZiB0aGUganVtcCBjb21tYW5kIGlzIGFwcGVuZCBieSBtYWlsYm94DQpjb250cm9sbGVyLCB0aGVu
IGNsaWVudCBkcml2ZXIgaXMgbm90IG5lY2Vzc2FyeSB0byBhcHBlbmQgbm9wLiBCdXQNCmN1cnJl
bnRseSwgbWFpbGJveCBjb250cm9sbGVyIGp1c3QgbW9kaWZ5IG5vcCB0byBqdW1wLCBub3QgYXBw
ZW5kIGp1bXAuDQpCZWNhdXNlIHRoaXMgbW9kaWZpY2F0aW9uIGlzIG5vdCByZWxhdGVkIHRvIHRo
aXMgc2VyaWVzIG9mIHJlbW92aW5nDQpwa3QtPmNsLCBzbyBJIHdvdWxkIGtlZXAgYXBwZW5kIG5v
cCBpbiB0aGUgZW5kIG9mIHBhY2tldCBmb3IgbWRwMw0KZHJpdmVyLg0KDQpSZWdhcmRzLA0KQ0sN
Cg0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCj4gDQo+ID4gU2luY2VyZWx5LA0KPiA+IE1vdWR5
DQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3Vh
bmcuaHVAa2VybmVsLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jbWRxLmMgfCAzICsrLQ0KPiA+ID4gPiAg
ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY29yZS5jIHwg
MiArKw0KPiA+ID4gPiAgICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRr
LW1kcDMtY29yZS5oIHwgMSArDQo+ID4gPiA+ICAgIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLQ0KPiA+ID4gPiBjbWRx
LmMNCj4gPiA+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1k
cDMtY21kcS5jDQo+ID4gPiA+IGluZGV4IDZhZGFjODU3YTQ3Ny4uYTQyMGQ0OTJkODc5IDEwMDY0
NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRr
LW1kcDMtY21kcS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvbWRwMy9tdGstbWRwMy1jbWRxLmMNCj4gPiA+ID4gQEAgLTQ3MSw3ICs0NzEsOCBAQCBpbnQg
bWRwX2NtZHFfc2VuZChzdHJ1Y3QgbWRwX2RldiAqbWRwLA0KPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+
ID4gbWRwX2NtZHFfcGFyYW0gKnBhcmFtKQ0KPiA+ID4gPiAgICAJCWRldl9lcnIoZGV2LCAibWRw
X3BhdGhfY29uZmlnIGVycm9yXG4iKTsNCj4gPiA+ID4gICAgCQlnb3RvIGVycl9mcmVlX3BhdGg7
DQo+ID4gPiA+ICAgIAl9DQo+ID4gPiA+IC0JY21kcV9wa3RfZmluYWxpemUoJmNtZC0+cGt0KTsN
Cj4gPiA+ID4gKwljbWRxX3BrdF9lb2MoJmNtZC0+cGt0KTsNCj4gPiA+ID4gKwljbWRxX3BrdF9u
b3AoJmNtZC0+cGt0LCBtZHAtPmNtZHFfc2hpZnRfcGEpOw0KPiA+ID4gPiAgICANCj4gPiA+ID4g
ICAgCWZvciAoaSA9IDA7IGkgPCBudW1fY29tcDsgaSsrKQ0KPiA+ID4gPiAgICAJCW1lbWNweSgm
Y29tcHNbaV0sIHBhdGgtPmNvbXBzW2ldLmNvbXAsDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtDQo+ID4gPiA+IGNvcmUu
Yw0KPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRw
My1jb3JlLmMNCj4gPiA+ID4gaW5kZXggOTRmNGVkNzg1MjNiLi4yMjE0NzQ0YzkzN2MgMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGst
bWRwMy1jb3JlLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay9tZHAzL210ay1tZHAzLWNvcmUuYw0KPiA+ID4gPiBAQCAtMjMxLDYgKzIzMSw4IEBAIHN0YXRp
YyBpbnQgbWRwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiA+ID4gKnBkZXYpDQo+
ID4gPiA+ICAgIAkJZ290byBlcnJfcHV0X3NjcDsNCj4gPiA+ID4gICAgCX0NCj4gPiA+ID4gICAg
DQo+ID4gPiA+ICsJbWRwLT5jbWRxX3NoaWZ0X3BhID0gY21kcV9nZXRfc2hpZnRfcGEobWRwLT5j
bWRxX2NsdC0NCj4gPiA+ID4gPmNoYW4pOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAgIAlpbml0X3dh
aXRxdWV1ZV9oZWFkKCZtZHAtPmNhbGxiYWNrX3dxKTsNCj4gPiA+ID4gICAgCWlkYV9pbml0KCZt
ZHAtPm1kcF9pZGEpOw0KPiA+ID4gPiAgICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRw
KTsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
bWRwMy9tdGstbWRwMy0NCj4gPiA+ID4gY29yZS5oDQo+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNvcmUuaA0KPiA+ID4gPiBpbmRleCA3ZTIx
ZDIyNmNlYjguLmVkNjFlMGJiNjllZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNvcmUuaA0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY29yZS5oDQo+ID4g
PiA+IEBAIC04Myw2ICs4Myw3IEBAIHN0cnVjdCBtZHBfZGV2IHsNCj4gPiA+ID4gICAgCXUzMgkJ
CQkJaWRfY291bnQ7DQo+ID4gPiA+ICAgIAlzdHJ1Y3QgaWRhCQkJCW1kcF9pZGE7DQo+ID4gPiA+
ICAgIAlzdHJ1Y3QgY21kcV9jbGllbnQJCQkqY21kcV9jbHQ7DQo+ID4gPiA+ICsJdTgJCQkJCWNt
ZHFfc2hpZnRfcGE7DQo+ID4gPiA+ICAgIAl3YWl0X3F1ZXVlX2hlYWRfdAkJCWNhbGxiYWNrX3dx
Ow0KPiA+ID4gPiAgICANCj4gPiA+ID4gICAgCXN0cnVjdCB2NGwyX2RldmljZQkJCXY0bDJfZGV2
Ow0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0KPiANCj4gDQo=

