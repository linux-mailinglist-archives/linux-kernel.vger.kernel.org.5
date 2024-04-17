Return-Path: <linux-kernel+bounces-148232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE068A7FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47882281C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9861350FA;
	Wed, 17 Apr 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CQ7lwIeK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="o773y3dC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4ECE572;
	Wed, 17 Apr 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346186; cv=fail; b=lI3XbwyrVAGGi74R9Vq7pbJZUomC5MJMxo2AKAMl+MqxzLzEDLarZDEQ18y4faC+Lu6NZrTOjVJKKYlucN7aCfABWXhIJhWKSl8T1ZDuH834zIGN7/kdnIM95NGRZR/5dSFJDbBnBv1WvAFGI6gYun/Jdb3MXyK6tkNbL43JXdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346186; c=relaxed/simple;
	bh=SUaNmR/36xcsdOH+JKSarELz/dXgVFtoxK24HEoc/LM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSjf2tZrysZS2Y2mNL3HCbYjc1OyZvVIHXyPjEnSwo8SoCI7T1iU4ueyNXp4uPjFxIVSHU+p4pZI8RubV/Bv754wgMPvC7qKddgUGMstEmjqecopjNcAL7DKUHMOereiojQ2T1dhZCFVY//RuicX6hU2W0NVbv9twsZjgp0C5M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CQ7lwIeK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=o773y3dC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 02fd8a2cfc9d11eeb8927bc1f75efef4-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SUaNmR/36xcsdOH+JKSarELz/dXgVFtoxK24HEoc/LM=;
	b=CQ7lwIeKsZAldBBkj3JyZk4MCWF7Zos6zUAoIDVOXi+gLQalov6jnMEXzLLTBEqUAApNcMcaq/PNdkPYF0+OF2Oi+r+Jf9ACef1EY3oyC4anuhjer71Sdd0sMLuhYArjt4xc9kOz/GONH4D2ebG8O7pYk0spViIY4TF1zqtwCIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b6a51213-032a-4ad8-9a29-7b91613b2a89,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:546aaf91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02fd8a2cfc9d11eeb8927bc1f75efef4-20240417
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 458919651; Wed, 17 Apr 2024 17:29:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 17:29:35 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 17:29:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7sxSRVQtJHpwz/mFb2oSKN0TD2ox+RqP/BUmPNqytn2Tnt5gxhDXyhfLXINVd4wHG8BStmp+bq2EvL1ppiRLwlMui4IdLOpano//lAihzmCKjUithsbtuLm0fDIfeO86YxpNXYiiA8p5mz4/IF9o16WbBO3VxiOEntE/Ze2E7Sg3HZcU4e0VAi/ikyOgaU3NeGMSVaPXoBoPi9DpqrAueHEQFOFY3CoVCgpceB+G1bMj1yW3/dqtRLVVRG7lelyItq0/uSGXne6uidTSxOjJlOktLNm+5iYq6nTYCCTN7O4MYIZcCXCM3rDUbjEATAsDXuD44A6vy0NZd3fOivQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUaNmR/36xcsdOH+JKSarELz/dXgVFtoxK24HEoc/LM=;
 b=mwMsHnv8vDFr11u9PEFfQGRGjAMDwQBAbQl4JxF+1akYWpEuz77qhAkQNBOoHtepY6RY4RTwTVd1RT1neFxQaBl2wuv4SxEnpHf74ZgiryEpylLG4EiW0WB9T2WxZeGp5cJ2YYecLrEwE5h5LwYP2XvqwMwEIMqYe5kDVdL2AETXx25fOUSnix+qGrb/Z6RF2KKDXobLJWzaf9vRrXNyKVS65Yi/3IfV9YXY+WaCau3Do+ihKDQVBCJNUfmOn5KHRIJ8fZh0+U1Erz8c22dSOQ31u1q2856swl2MathS3y6gWGsb+rGKILAHlAC52KdV9OuDR9l7vTkKGs6RGxvNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUaNmR/36xcsdOH+JKSarELz/dXgVFtoxK24HEoc/LM=;
 b=o773y3dCjxU8/WIu/srnhwYnNSQBafCbSLPcoJTVjgwniW69isoZPiGOjA+BkPR3ogBc9rWr9SmiqIv+nDz68UOKa4VuaMrOrc86BSk9lySlYpw5Zgl66d3Nd4Q7ewYWTMCKnpz+FSMe95mQ+U0FZgfYj4TlwkAihgL9mQEhrpA=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:29:34 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:29:33 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "amergnat@baylibre.com" <amergnat@baylibre.com>
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Topic: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Index: AQHajyQsFRoxXt1vlE2SkQwxcZAltLFqegCAgAAOj4CAACueAIAAAfoAgAApLgCAAUDrAIAAFPkA
Date: Wed, 17 Apr 2024 09:29:33 +0000
Message-ID: <12cc437d2213720190a2fcf132411cfe4485f5d0.camel@mediatek.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
	 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
	 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
	 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
	 <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
	 <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
	 <d11e174d85c7f5a9b4ffe5fb2bb15dfd5823f83e.camel@mediatek.com>
	 <ecd7c691-db47-42aa-ab19-f554c20774af@collabora.com>
In-Reply-To: <ecd7c691-db47-42aa-ab19-f554c20774af@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|KL1PR03MB8142:EE_
x-ms-office365-filtering-correlation-id: 8018b38f-ce9c-4709-0bf3-08dc5ec0e467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?dUM0NHM3NWttNGdZQ0VFRlFRR2FzRzI3T1FONHRsaVRDTjZrc3ZFU1dCQk9q?=
 =?utf-8?B?Z3p4Unl5cGNFWlpUdEhoTTJ3dnRVZFVHdGE3R1c0OVRVTzA5QkpXUHFzR05h?=
 =?utf-8?B?K2FLVEp5Ujg0UmltenhnWmJLWCtVaCtEbnBJOEUwMHg2d3poWlYxNkJvbjhq?=
 =?utf-8?B?N0tOZ01ZYlR0ZmRNaFMwK2JicjRWYmF4MEhLQW10dFNWRndXdERzczhhS1ZR?=
 =?utf-8?B?QTZsWTErMGlXSVZQdTQrQ290cEd0c1ZjVE9qUDI4dFdBMHUzMVlEVUFEa2My?=
 =?utf-8?B?WVZ0R1dqQ2ZidThGVFFJNkNmYVo0ZU1HUk8rZnA5QkczcnQrZmk4OUxkTFA0?=
 =?utf-8?B?dTBMMVRYT2NxMWRGY2l1dy9KZzFyZkxiVmhYeTBDU3k4MlQrZHd0d3pJSVBu?=
 =?utf-8?B?bWF5dVdOcnROcTR5ei8xckx2TWl1Y041T1NLRlpNOE1wdkVCc0diZlhlZVQ5?=
 =?utf-8?B?YVF0TC9JQUhMa01sRUVLMTRyUlJaSUo4OFpoeHJGM3hDYW1vbkpVZStZRWRn?=
 =?utf-8?B?aVZERmtCMlN6NVF2ZWxqMkhlY0c1YngyYzJQOXJMelFGQi9iTHJVbmZCdzdx?=
 =?utf-8?B?WkhIQzBUN0xieTc1OXdIZmdMb3k4WW9mZFZCWmJOZThYK0ZuOStjNU9tQ1Zj?=
 =?utf-8?B?eHptWE1jZGNGaWM1cjhLUGh0YTZZNlNSMUpiNDI4OUJaQWtMeWFxTUQzQnVl?=
 =?utf-8?B?QTBteG5sVnpnVkhPM0ZvUGF4dTgwOE9uWTVBcVRmemhwM3dZdkJjNVNUQXlD?=
 =?utf-8?B?WElBRUtWV2RQbTFNRnB2dkh5OFNzb1hTUjdPTDh2amxzaVhITkFJUFdpS3RY?=
 =?utf-8?B?WE44U25vK0o3aDNCUHZ3aEl4SG50cTFpR0tWODNlYXlpK2p2WFhkOTVBQm5M?=
 =?utf-8?B?VVRUR1NYKzdRNUsvQ2FLWjJwKzRxeW94QlcrLzlSOTNFOHdmMm50ak9tK1cw?=
 =?utf-8?B?elZPVzJGa3Q1Z0ZrcmpqN0hueHRNZGFmeXJTa1ZUYm8rTEJIR0NmME8xVFRO?=
 =?utf-8?B?bFkwWnFoaGFwb0QwY090dHR4a3RWRjVINWtsMlk2bGVOVU9sYU5jOXhCSTJI?=
 =?utf-8?B?MlEvenk1aGhwa1FCUDk0YnJPN1NReU5udlRkcC95dVRSaGd2cHRRSFZDM0Vi?=
 =?utf-8?B?Q3B0ODhML0hjQ2NLSVpBZlRIR1ZVWDA5Sm00U1hMMHVsbVRSK2pJSjF4RFBm?=
 =?utf-8?B?UWdrdURFaDFYOEhWN0l4RzVxa1pKTEJmRVROUmNJMUs1N3l2U2RscEVBdi9z?=
 =?utf-8?B?cG9QUklYNGtTQUFQL0MzQTZSdDZwVk83ZFhkTTVXTCsrQi9JdkxFZ1hObm5r?=
 =?utf-8?B?Rm9ndEhNVitrdmJkRWliTGU3ZDIzY0EyNjF0Rlc2Vk9YcFBYdHc1RDhTd1pM?=
 =?utf-8?B?SDRHT0cvTjd0UGNUWlVXeXNPVU85dkxBb01xSGVCTnB3SU54b05WV1B1NXNH?=
 =?utf-8?B?dmgxS09DMlhmSCsyR0FXRW5weVQ3VG5qTkdPaGhZTkJDQXhOQlgvYjdkR096?=
 =?utf-8?B?c3NjQUo1eGdSQURnVmlTZ3ZQMHlCczJZcWtkdmtnbFhoRytsWnVrTFpsQmVK?=
 =?utf-8?B?VWpMY2pSUVErKzNQQWNkUWZGN1FrV25mQ0tBQjhEZENLUlA5Wk9aOG5saGxm?=
 =?utf-8?B?WXhydzNwSnI3SjNCYmNZMEV4THhwWllMZW9aRHJVampuaU9DMlY1b2h3QzNh?=
 =?utf-8?B?d0Y3cnVaUXNpMDN0UkYzWUY0Z01VL1lUTG9vUmMySVJMNWdNeXdLdnRCbFVF?=
 =?utf-8?B?Nmx1OXFjUzFub1dpRVh3ekRwZXZBcktXVWpEbytUc1dVOHMrdjlxbXlVZGFF?=
 =?utf-8?B?b0ZXVGxtOWJhdEtKODFvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG83ZzRoTTB0dzBRUnNUSkdOSUlySjEwNGpsRGtJOFNWa001YTlrUHJ4RHN1?=
 =?utf-8?B?c2lwZDl2MnFaWFp6NW9pQzkzT09JT3RBK2hHZG9pWU9MVEpGRUxtVXVjRFMw?=
 =?utf-8?B?UWYwb3F1ZFQ2Nk1mQTJBMVAzUzViOVdRc0owUUtGdE1qRWFBNmdZN2kzRE5i?=
 =?utf-8?B?V250bXNWUmtrSkJibGRheGUzSDZvbTMzQ08rUnNjSnE2TDg2QUgxWHFBL1dv?=
 =?utf-8?B?ajlGOFduU3YvMy9kdVptQzBiZWtuWXdpc2ZZOFdRb3N2NnZIVzBGaTI2VzRr?=
 =?utf-8?B?c21oZXBxVllCRVpDbHZCdTFCR01ReWVaNHFIS09mOVpNa2p5U1Q0dUxueWNL?=
 =?utf-8?B?WnRLMkxVOHdHODBwQ0NUdzk1Vm0xdU9WdUNiTXV0bDM3V2Zya0RTMk1TOTBz?=
 =?utf-8?B?d1hYNEJ5cnVuc0w3cmQrSXBQTjlyTmFyeTQ5bW5hdUgvRDYrc3NUOEQrUnJW?=
 =?utf-8?B?TG1vRlJPOGxScmRCekp4MS9PNHFtSUt4V0JpOHhmL2M1YnFNSGQzV29jTERC?=
 =?utf-8?B?MGc4c1dyMHhwZlp5WlRQMEFxcm82a21YdVdlRlB6cG94aE56bGhEeVNZbDNt?=
 =?utf-8?B?Q0FhNzh4c1J3U01DQmp5TytRbmZqMmFTZmtHMGs4eFBza1dFOXg4MElHNFdr?=
 =?utf-8?B?TWhqU2dManRIaVdDU0xPSkI2elFCYzM1Y1cvelVBS1dLOEpUQzNrZDBkYkJy?=
 =?utf-8?B?YzIxTGJpWGRqdGowUzhVSTNPWHluUktLbEpDQ1YrWDNId0hCL205cG9nSnR3?=
 =?utf-8?B?SHJkUEtQRUUwWFNFQnlYL0k5cWhuZVdFc3J3M2N3aHNQd0JRT01jMkFBRndB?=
 =?utf-8?B?bEJCQ0t1Z05ZQlhHR2tZOHMwc3EzQ0Q2bStHVUNJTlkzLzBzbmhnMGN3aGx5?=
 =?utf-8?B?dFJJaWYyWHVuU3JJZEtic0dOZ2QvcDJ0cWhBU0RWOStualRvMzJYY2lPSTFu?=
 =?utf-8?B?c0NQa3A5MHJXT1ZHNlptblE5eEdNclVhYmFUaElOYjM5ZENCSU1sdVJFUDgw?=
 =?utf-8?B?MG5uT1d2T3dod2s0cjZWTzJ6VTR0VmVva3U3emFuVFFkOTAvRys5QVZMTnQ1?=
 =?utf-8?B?bTZVdEl3NGtUZThhakp1MU5VUHlxRDFZcUk0cUUwdUJydlplUGF6R2RvNW01?=
 =?utf-8?B?QjNWT1c2WDUvNlNNV2NBNnF5T0NvcUwwZTZLdmdjQmFwVFdldU0rcnpkdHRC?=
 =?utf-8?B?SzVCdENrRDlCV0YwWTZRc0MrMlRXZ25wazNVemNkYjRxV3RkOXh1aDFaL3BQ?=
 =?utf-8?B?eXFDK2l5dy9lWFo0WmRxUlE0aWRjeFJxcDV2emhrQi81QUVhS3ZyOG9GWk4x?=
 =?utf-8?B?MitvWEFDM0tRaUpZa1Q5Vm80UURlaWpXNGwyYTJOMlpkUmxpejNEeW1xSDVx?=
 =?utf-8?B?SDlRanc2S0ZUR1BHc3lBcnE1TnR1bFFDRTFqZHdUc0ZQd2lyYkp0UnlhbEVB?=
 =?utf-8?B?Q2lyU0lqeXJ5RmJvZmJPWHpjU3RqaGpSdEZrOHhXV3VueU5ORkpNM1RhMTls?=
 =?utf-8?B?WGljbVlJYVREencxeHlpL3YxTmxXZndLRDhIZkY3N2lDbzMrY2dGS1VUTkJp?=
 =?utf-8?B?angxSXpWbkpSTENEcUFYWjFBdkM0cDBTT05zWHcyNUVmWXEvSTlqNDFaVVBE?=
 =?utf-8?B?NEE5Zk1WUVVYOHJUdEVpQ1FoVld4T283MkEzd0JCdTVWbThkUlg4dWxwZExo?=
 =?utf-8?B?NFdWM3lqRk9XWlAxcGltT1hMRkdVSnFQTnlCT3lQQ1RlMGVHc2xuOFk1NHF5?=
 =?utf-8?B?bXhMZ3NjUmg1ay9RRXhSLzZ1SityOW8xb2t1cHBIWkw1MXdXLyt5bW1UUXlw?=
 =?utf-8?B?a3pudzB4YjNOU3VNUVQ2cnQ2ZXZZY1dzZXhkeFRjVTFzd3RIeXlPZTRFWjVL?=
 =?utf-8?B?UGVIcThRZUE0OWtQZDBtaGtXdXIxOW5wekJaMktidEwwRk9nZ3NMWnk5UUJM?=
 =?utf-8?B?SG9TcmtXUU1Ma29LY3pSUTlZcE5iVVdtU01INEp6RmwySERQVzhEMSs1a0NG?=
 =?utf-8?B?Rk54YkwxQkpiRjJHT0VLRlJrZ1p5WTltekF3b0hiYmk2WkZ4eWFKeDF0UXU4?=
 =?utf-8?B?UWtRNUtGQWZQSzFXR0l0VlBRRzE1ZTRDdW5rekxJYWJJV3lzT1lzRmkxaDlX?=
 =?utf-8?B?ZklGOEFDb21iemprMjFydFZHcldyN2xFNUYxUlVRaGExc0VMOWpGK2lCQ1Qw?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DB1D58EB9228140849A479756510A90@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018b38f-ce9c-4709-0bf3-08dc5ec0e467
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:29:33.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1LZHtE2CADjfBIyFeZgLdVLQ5osxtsbDSJXxza82eKhNfVphmf4ofi6xRgFFPdk+JnsDnWVeL4FeSIGFJ5B+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.484400-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4+qvcIF1TcLYOVL
	sil/9Kd121nyRSrQ1fYzbI1E6WnGTuDg0sdjQJGs/O70vD0Lt8BAq6/y5AEOOi8zQZ2rR/Op/MT
	l/DYL0t92aOfb3vXhU0NY3JzSooWUqFBo1DmTbAhor4yxPAz7WTGZtPrBBPZr/Z2SSD7R8hTTuv
	V4z5H9l3jvcteFyVUc3SIrho7PKQaAaBshbPhdTLiMC5wdwKqdTEFC0zV7bKRiZCTkFQiKcNYQA
	opXl6nxdqg1nRv0Su2Hc4lwrx5hREkjllSXrjtQ0gVVXNgaM0qcIZLVZAQa0I7xHquoAJGGq7rF
	UcuGp/FYF3qW3Je6+74ZxuRkpY3ZAhSREXNLA4Zl+Y5RBnugI3qlPBiV1xXVDnTiJ2V40wQhsJN
	j8H4N3sFd1SIWTL2zGPUcji4QswLU9JZoo5hnafwNgAzF8116xNxlEFDc5GXHtMBP/jXy2fh0UM
	xNN2q2VGMhh6J/ibp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.484400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A06647960273ABCB026AA166A88AA4661BA8E9E34DBFCCD9F83421996E3EA6892000:8
X-MTK: N

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDEwOjE0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IA0KPiBVcHN0cmVhbSBzdXBwb3J0cyBwbGF0Zm9ybXMgdGhhdCBk
byBhbmQgZG9uJ3QgbmVlZCB0aGlzIGZlYXR1cmUsIGFuZA0KPiBoYXZpbmcNCj4gcmVkdW5kYW50
IGRldmljZSB0cmVlIHByb3BlcnRpZXMgcGVyZm9ybWluZyB0aGUgc2FtZSBjaGVja3MgaXMgbm90
DQo+IGp1c3QNCj4gc3Vib3B0aW1hbCBidXQgcGxhaW4gd3JvbmcuDQo+IA0KPiBBZGRpbmcgdG8g
dGhpcywgZGV2aWNldHJlZSBkZXNjcmliZXMgdGhlIGhhcmR3YXJlIC0gYW5kIHRoZXJlIGlzIG5v
DQo+IHBoeXNpY2FsDQo+IGhhcmR3YXJlIHN3aXRjaCB0aGF0IG5lZWRzIHRoaXMgcmVkdW5kYW50
IHByb3BlcnR5LCB0aGlzIG1lYW5zIHRoYXQNCj4gdGhlDQo+IHByb3BlcnR5IHRoYXQgaXMgZ2V0
dGluZyByZW1vdmVkIGluIHRoaXMgY29tbWl0IChhbmQgdGhlIHZhMDkgb25lIGluDQo+IGFub3Ro
ZXINCj4gY29tbWl0IG9mIHRoaXMgc2VyaWVzKSBpcyBhICpzb2Z0d2FyZSBzd2l0Y2gqLCBub3Qg
SFcuDQo+IA0KPiBLZWVwIGluIG1pbmQsIGFsc28sIHRoYXQgdGhpcyBmZWF0dXJlIChhbmQgYWdh
aW4sIHRoZSB2YTA5IG9uZSBhcw0KPiB3ZWxsKSBoYXMNCj4gYSBzcGVjaWZpYyByZXF1aXJlbWVu
dCB0byBiZSBzdXBwb3J0ZWQgLSBhbmQgdGhpcyBpcyB3aGF0IHRoZSBjb2RlDQo+IGRvZXMgZXZl
bg0KPiB3aXRob3V0IHRoZSBzb2Z0d2FyZSBzd2l0Y2ggdG8gYWRkIGl0Lg0KPiANCj4gSW4gY2Fz
ZSB0aGVyZSdzIGFueSBuZWVkIHRvIGRpc2FsbG93IHN1Y2ggZmVhdHVyZSBmcm9tIGEgc3BlY2lm
aWMNCj4gU29DLCB0aGUgRFQNCj4gYmluZGluZ3MgY2FuIGJlIG1vZGlmaWVkIHN1Y2ggdGhhdCBh
IHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5nIHdvdWxkDQo+IGRpc2FsbG93DQo+IGFkZGluZyB0
aGUgcmVxdWlyZWQgcmVndWxhdG9yIGFuZC9vciBib29zdC1taWNyb3ZvbHQgcHJvcGVydGllcy4N
Cj4gDQo+IEJlc2lkZXMsIEkgd2FudCB0byByZW1pbmQgeW91IHRoYXQgdGhlcmUgaXMgbm8gcmVh
c29uIHRvIGRyb3ANCj4gc3VwcG9ydCwgb3IgaGF2ZQ0KPiB0aGVtIHVucmVsaWFibHkgd29ya2lu
Zywgb3IgdXNlIGhhY2tzLCBmb3IgU29DcyB0aGF0IGFyZSAib2xkIiAtDQo+IGVzcGVjaWFsbHkN
Cj4gd2hlbiB0aGlzIGlzIGEgZHJpdmVyIHRoYXQgd29ya3Mgb24gYm90aCBvbGQgYW5kIG5ldyBv
bmVzLg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoNCkhpIEFuZ2VsbywNCg0KVGhlc2UgdHdv
IHByb3BlcnR5KGJvb3N0IGFuZCB2YTA5KSBpcyBub3Qgc29mdHdhcmUgc3dpdGNoLCB0aGV5DQph
cmUgaGFyZHdhcmUgc3dpdGNoLiBCZWNhdXNlIGlmIHBsYXRmb3JtIHN1cHBvcnQgY3J5cHRvIGJv
b3N0LCB3ZSBzZXQNCmJvb3N0IHByb3BlcnR5IGluIGRldmljZSB0cmVlLiBBbmQgaWYgcGxhdGZv
cm0gc3VwcG9ydCB1ZnMgdmEwOSwgd2Ugc2V0DQp2YTA5IHByb2JlcnR5IGluIGRldmljZSB0cmVl
LiBUaGVzZSBwcm9wZXJ0eSBhcmUgbWFpbiBoYXJkd2FyZSBzd2l0Y2guDQoNCldlIGRvbid0IHVz
ZSBzdWIgc3dpdGNoIGxpa2Ugdm9sdGFnZSBvciBjbG9jayBzZXR0aW5nIGJlY2FzdWUgaXQgaXMN
Cm5vdCBpbnRpdXRpdmUuIEVzcGVjaWFsbHkgd2hlbiB2YTA5IGlzIG5vdCB1c2VkIGJ5IHVmcyAo
Tm8gdmEwOQ0KcHJvcGVydHkgYnV0IGhhdmUgdmEwOSB2b2x0YWdlKSwgVGhlIGJlaGF2aW9yIHNo
b3VsZCBiZSB3cm9uZyBpZiB1ZnMNCmNvbnRyb2wgdmEwOSB3aGljaCB1c2VkIGJ5IG90aGVyIG1v
ZHVsZS4NCg0KVGhhbmtzLg0KUGV0ZXINCg0KDQoNCg==

