Return-Path: <linux-kernel+bounces-141750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0628A22E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DA02874D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767B718AF9;
	Fri, 12 Apr 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jbcCPcPb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jT2mVGhi"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D11798C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881115; cv=fail; b=NsspZuZmJZ/i92/+7ILYHFylsKiYkvffAgRfUNZPqe/1OE+0GNtvHI4P7fFpbxAGmVmIN94F0Ymyej61nxxf0M+rzJr63CDA9cbyB8/w3lSH+A9gd7OLSmqSi1B4m7zmtfUau1D6OHF5CUTarRxiJ6Aq2XvjHMaQ+EADdvo7HfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881115; c=relaxed/simple;
	bh=n9MNz0gQxhyVPqziz5MB4jlXG3DOj/Q02HFsl5zVU/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+n36WpMmMom6rSnHm7ONVEFqdzuQlkVbdhgspLS786NUp5F1WJ/3IWXRmzA9E+lJX5Bbx4Fjv+yr5QxzAfupwEV/Kv3jYNSpiZLQPFgYaWwPbbAkPgwgleNn2RCE6sVtVfpXe6HVAzKfwQo1tXp+vhcL7uzFUw0lm5K+CXU03s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jbcCPcPb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jT2mVGhi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ecef508f86211ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n9MNz0gQxhyVPqziz5MB4jlXG3DOj/Q02HFsl5zVU/E=;
	b=jbcCPcPbcF0tD2QoCmnAUFCIhdi7tzJ2qCKmvFP3zGE8zcLMOlg6Lwg1fwRcASJF2wbWHZlRCwoZr2/MKeSE4pbqfYLcyChcFZm5Yr2LkSFCJi/TW5GYjWQ/PE38iGK05hbC5+CW1UHH3AHrYODqYpjOp5Vik+XTSVwjOQWhaZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:19717bfc-9c46-4acf-9870-17124e2aff83,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:09b4cffa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2ecef508f86211ee935d6952f98a51a9-20240412
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <light.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 152412977; Fri, 12 Apr 2024 08:18:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 08:18:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 08:18:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5X9zUvLK1VnKMVUJPfXMZRd5vQ+JqC7y6xisnVTorBdyEMTngiwxxiQjqC5de6eKtQmRuo1J1FQDppY0k6vN9jqLbA3QbRcdB+/Nuv/GOSHGTXmIj5EdkEyTBg5WgZmPLjUEvMcmaouHkOHu98WsoT/C3L4xYpD1fQOY9NZr34iq+Eg0b0nnwTu94NuCDa8mDForpmPwlZgVDQcUDz4vS5ZfyUXDyecqAbAWeRiiElOCdfQ5qtQd8LTPILuPhishojE7UrztSMkQs2S+RX5JAHpKFrM9yN2RAMqEr5wbg1ZNgWEYPrXbyzUJYG6WTGApNyk8m2ZFQmpy+DmXBzM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9MNz0gQxhyVPqziz5MB4jlXG3DOj/Q02HFsl5zVU/E=;
 b=hTMH8MbS38TRc4I46Q1ijsl4ddx9Tr9rvUYMVWi9G/0BKwQftPlkvAmRxwG3d5yhdU8hILQ1ri4rVMsvivi/sK1GVxpjVzhl2lfaxYOu7itcGYlQ/kMPcxGwEfyAokUB9YaN+R+HOuBLZxnEvlCt58w7Nvk0evbE5pmWjMhfyj3fOwIzQMPgw2Qkolgz3rBg7LCHSKw7+WzA4egqVYPMzu8/WfXMwsLKSrVGCLPrTV1kEzrAkNlxhhBFig+Jv/VdGa6kW6l3lXmX95nMVKa/hl8e2Oi1MqVpRWYSrfo7/BvnN86TAAQho+DQFsPz26d6unEbMxPmzv+f3gE3Zlluzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9MNz0gQxhyVPqziz5MB4jlXG3DOj/Q02HFsl5zVU/E=;
 b=jT2mVGhijiyh+m+gnANOinOqurhdhMqXeX9i92eHMIpRtGTMDoczl5luaYA54jfrLl/UhwIgCdl+hQJSWFdOcYt1VWD8oQOdav1Psk8qxb82Bg9tzuGQvjFKO8PGOvj/6mgx0odSp/jQ1mCC4E5FIpv7MP3c9Lr/rllhHgXUKEA=
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) by
 PUZPR03MB7113.apcprd03.prod.outlook.com (2603:1096:301:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 00:18:23 +0000
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::8023:c923:222:1b8a]) by SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::8023:c923:222:1b8a%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 00:18:18 +0000
From: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Hillf Danton <hdanton@sina.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjogW1BBVENIXSBmMmZzOiBhdm9pZCB0?=
 =?utf-8?Q?he_deadlock_case_when_stopping_discard_thread?=
Thread-Topic: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSF0gZjJmczogYXZvaWQgdGhlIGRlYWRs?=
 =?utf-8?Q?ock_case_when_stopping_discard_thread?=
Thread-Index: AQHae+EjGuIimSJa2U6kUjro/ZAA7bFC6B+AgAAWVxiAAVk0AIAF7G8AgABpwiuAC0nn94ACpKEAgAtJPA8=
Date: Fri, 12 Apr 2024 00:18:18 +0000
Message-ID: <SI2PR03MB52608626CE591F850F5F815384042@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com> <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zf4FIAkI83GbQYLB@google.com> <ZgL9NLLiSdDeIMg_@google.com>
 <SI2PR03MB526041E42B6BD9C9DA9FBAC184352@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <SI2PR03MB5260819B5B1719063EFF458A843D2@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zg8Fvu1X_4uqQl9A@google.com>
In-Reply-To: <Zg8Fvu1X_4uqQl9A@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5260:EE_|PUZPR03MB7113:EE_
x-ms-office365-filtering-correlation-id: 6e3f794c-6229-428e-4a24-08dc5a860de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1nS4sKjjAl6udvZ8fGlkK2Fn4MY+Nqs1WBeFKlEboqWzhlzwQLIm8PfX/M2dBdjmKwacg6cr04v/tqZ6OUe2sY6h6wJkB+OUuyahl/mskT8HnUciQcs0t/tETl54tkEX2GEX6JY7CUDXlwlm4/9JnCj5zM4EIsuNvV/KIiofgpAT0Nf+ptrOzlCn2cnMjFTmZDWuU3cSQCM+7cTqLcnCh1U0vAIsObseTCiA2FpVAknP9e4w5G5bi4A/FabUUYsj4D44ME4flfJ5rZkU2ZUG57cT50bI1TWl6EyCoqFrefIxxCIM27mT+oFy22WuRYWegRxB5KmhtADRgQkMQjTTEVCJ8j/tkB9V6NI0uuHutFqyOLtsCNMAr3eaaGXiTJ26W3x0KMA5Izpneneek+Lt3s3DftDB4cfKOaFi+8hhLr9u1BBKbPYPic7VUuR/73RQmcfBkl+95TvKiJc7xZh+7akHvskqO2r7frb87MprMyC0wly22WbFTHshvKYs/AGAj9Yuej8iKlNvAirkn6Wqu0jBxwiIkCwsfOEt/PVZL2sFR7+HfYSTg9/1iP2jQJA8gMkDiA17kx3b/eR6z8qhAAxYVlb9THBr99n7bPcc14R5BnVyVRr0HR0F+ss7YNgXTt3C8ihyYB/JkW+WxHlyyGREvPA4Y+3k/FfXm7lNyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5260.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzBWdzU3bk95Z1BGem9XSmNOZ3NLUERzQTlSMDJRUTVxN3F1QU9wU0xIWUx4?=
 =?utf-8?B?aFBTWDlJSDEyNFI1K3JXcWd0ZFU0UjBSR3YrTitLUmFNWElQUC9oUjRBMXAx?=
 =?utf-8?B?S003OFdnSFBCSERtVUJ6bFE3TFdvdHlXZE51aUt5cFF4U3BFendRTHJQbkVx?=
 =?utf-8?B?MDRTUVY3NndmeGttQVhvUXErVzgrMVVNQnFBV1NpVXpMaUFaaXhBemRCak9O?=
 =?utf-8?B?UjcycTF4MHlyeXZvdm81VkFIVUdQU1A2b0dzd2dsQzljRjdrMDZjT1YyRHRR?=
 =?utf-8?B?QzdpdlVlZ3lTSHcvaU0wWmU1K2hScXV2ZDR3VFR3b2trWlpzUjZtOWhrZ3pW?=
 =?utf-8?B?Vjg1U1FFR01XUm8wekxnc214L0NLdng1TkJpYkIra2FpbXdmeE5ya0o2aEpS?=
 =?utf-8?B?RnBSUWdnMVVRMzhucTl3WWhKK25aU0xGTmtRYTdhZ0taS1p1Zm1HUVpUWE92?=
 =?utf-8?B?UlVoeXFhbklWeVRNdEV2ci92V3NqQ0V3RHNPcnFsWS93eXQ3ZW9WUWNSUlJJ?=
 =?utf-8?B?WG1Ua3pGQjR4SGJ2VnlHZ01BUzBqTlAxZGc0QUVFRjJ6a0RHS2dML0VqWHht?=
 =?utf-8?B?RlZNRkZ4QmRiaEZpMktZK1A3bTJlaW9TbXBrbFcwdzRsNmJUM3RKL3pkMGg5?=
 =?utf-8?B?ZGJaNG05c1BNOElvMlpPNHJ2OXlMZmlzc0plOHlsWUtOKzNWQUhyQy9MSWpq?=
 =?utf-8?B?L0J6eUhoQjFad0pIZ3YvczhmSjdFYUNlRFNIazNmZmlDY1FPczlMY2M0cHQ5?=
 =?utf-8?B?d0tqZlAzM2M5RFkyblBiWEpiQ1VhZkF6Y0c1cGxTOUh2ZUFseFo2dkYrcXNw?=
 =?utf-8?B?bDBXMmVKZnVDbUZmMjdWb2pQanpPQmNnZDBNdnJJRTBLMFc5V0FLK0xsRVZD?=
 =?utf-8?B?MDBYUjMwL2dJYVZ4TFZGVFE1U0ErbEtvSndqWHJwZ292cUxQSmh2Q0Q3VEor?=
 =?utf-8?B?V3Z5Wm9uZlM5MnR0OThoa1pGYWVrYm9hNTRMVXI0WXY5NjV0SkFZaENNUzdR?=
 =?utf-8?B?T0NxbnJLc0JxeTQwb2FmaVQrUzMyS3RLdVlENi9kWGZlM0R0TTVEd01lSTJs?=
 =?utf-8?B?a0c4V0lKVlJWZ3FDZnloeEpkdHlGT0l0R1dxQ1E1OFlwL05rdHJtUDVXU1A1?=
 =?utf-8?B?SXBackFtbmZwWEhVUytDT0NBTCtadC9SUXVkWWZvK1d0aktyTzRBemF4NlRz?=
 =?utf-8?B?VUZvdHZZMFFPM0E2RnE4SHNIVnptaHp2bk1vdGdoK0Q4bEZHUktNbmFXendG?=
 =?utf-8?B?NjJGQWhDalVLc3o2ZUJYK1RBQllZNzZKcCswV0w4RXFZTDZLeVFLMHVEQi9V?=
 =?utf-8?B?Q0RRanhlWFlWVHhjclFJMi9oL3hNMmZWdCtyY3Azc2Jnd1RHK0xqeEE3WmF0?=
 =?utf-8?B?RnlxY01KOFpacWtON08ydSs5aDNZV1FmbStmcEtKTERibk8rMHk3bGZkZmVr?=
 =?utf-8?B?TFpiTi9rcUdoQ2xETTdZbnRHSWltQndsTml6QkJ3b2V2SHpJZzJOMExRVVNS?=
 =?utf-8?B?b2w0T2hweVZVa0pCYWdkRzRUWXkzVndqMXFya2lkL3dWaWJPV2FGNytsYXEw?=
 =?utf-8?B?T1FYWlhud0V5ZDJhQlluWEllSS9jZ1Rwd1Vua1Z3Q3RyR29wSzJucXJXalU1?=
 =?utf-8?B?OHN1dXRoc21rcTUzdjhBdjZPcHg5clgxTm0xTWdTd2plcmVHdE9pd2ZpazNp?=
 =?utf-8?B?QmMvb1hHUXJGYzBMVHF6eHZRWTJ3Qkg4cmNOMXNUZFB2SEFndVlEdGZ4SGFN?=
 =?utf-8?B?R1RtbUFDQlJsaFkyNDd5dlFWYUVrRGlXdXQxZkE2dmx0aGp3SERDVHVLRTBo?=
 =?utf-8?B?a2dJZThjTWxJYTF0WlM0dlh0anJXcTEwdU5XWU4wWjRCQnE3emJ4R0EvY3RL?=
 =?utf-8?B?ODBjN2g3RzVRY2NmRXNwTzFiRkhLV280RUhua3hjSWJyRCtjTm4rYy9nOW1W?=
 =?utf-8?B?VmpXTG1ROVB1eE04ajArT2R4bzJHRStmd0prZWd3TWM0ZC9VWHZjWk5Yck9w?=
 =?utf-8?B?ZGt3OTNwc0Q1VVZlR1lWQVk2dXFpUDNFZERGWWZyYTlzVmlpZ05zZTNIWS9s?=
 =?utf-8?B?ZTNvMGNJVE1ReEJKM242cC9qVGhNSE5RcEs1T3FzRUNiV2poNTUwT0RaUU9V?=
 =?utf-8?Q?zamTXnb93VBacys3Vnn/ZlzBR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f794c-6229-428e-4a24-08dc5a860de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 00:18:18.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXsnZppOYNdOEPthLMKrjaG2PaRwCiZDlk7VSqgfJhibgrkAu9OKJLd6i5+Y7vXzD+IL8lUXkBfbeVbK2bWAZ8u1CFSSZOCjEFw9jSMnG5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7113

SSB0aGluayAncmVhZG9uJyBpbiB0aGlzIGxpbmUgbWF5IGJlIHR5cG8gb2YgICdyZWFzb24nCgor
CQlmMmZzX3dhcm4oc2JpLCAiU3RvcHBlZCBmaWxlc3lzdGVtIGR1ZSB0byByZWFkb246ICVkIiwg
cmVhc29uKTsKCgoK5a+E5Lu26ICFOsKgSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4K
5a+E5Lu25pel5pyfOsKgMjAyNOW5tDTmnIg15pelIOS4iuWNiCAwMzo1NQrmlLbku7bogIU6wqBM
aWdodCBIc2llaCAo6Kyd5piO54eIKSA8TGlnaHQuSHNpZWhAbWVkaWF0ZWsuY29tPgrlia/mnKw6
wqBIaWxsZiBEYW50b24gPGhkYW50b25Ac2luYS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQgPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0PgrkuLvml6g6wqBSZTog5Zue6KaGOiDlm57opoY6IFtQQVRDSF0gZjJmczogYXZvaWQgdGhl
IGRlYWRsb2NrIGNhc2Ugd2hlbiBzdG9wcGluZyBkaXNjYXJkIHRocmVhZArCoAoKT24gMDQvMDMs
IExpZ2h0IEhzaWVoICjorJ3mmI7nh4gpIHdyb3RlOgo+IE91ciBsb2cgc2hvd3MgdGhhdCB0aGF3
X3N1cGVyX2xvY2tlZCgpIGZpbmQgdGhhdCBzYiBpcyByZWFkb25seSzCoHNvIHNiX2ZyZWV6ZV91
bmxvY2soKSBpcyBub3QgaW52b2tlZC4KPiAKPiBzdGF0aWMgaW50IHRoYXdfc3VwZXJfbG9ja2Vk
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGVudW0gZnJlZXplX2hvbGRlciB3aG8pCj4gewo+IOKA
guKAguKAguKAguKAguKAgi4uLgo+IOKAguKAguKAguKAguKAguKAgmlmIChzYl9yZG9ubHkoc2Ip
KSB7Cj4g4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc2ItPnNfd3JpdGVycy5m
cmVlemVfaG9sZGVycyAmPSB+d2hvOwo+IOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAgnNiLT5zX3dyaXRlcnMuZnJvemVuID0gU0JfVU5GUk9aRU47Cj4g4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCd2FrZV91cF92YXIoJnNiLT5zX3dyaXRlcnMuZnJvemVuKTsK
PiDigILigILigILigILigILigILigILigILigILigILigILigIJnb3RvIG91dDsKPiDigILigILi
gILigILigILigIJ9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuLi4KPiDigILigILigILigILi
gILigIJzYl9mcmVlemVfdW5sb2NrKHNiLCBTQl9GUkVFWkVfRlMpOwo+IG91dDoKPiDigILigILi
gILigILigILigIJkZWFjdGl2YXRlX2xvY2tlZF9zdXBlcihzYik7Cj4g4oCC4oCC4oCC4oCC4oCC
4oCCcmV0dXJuIDA7Cj4gfQoKVGhhbmsgeW91LiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29r
IGF0IHRoaXMgcGF0Y2g/CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVs
LzIwMjQwNDA0MTk1MjU0LjU1Njg5Ni0xLWphZWdldWtAa2VybmVsLm9yZy9ULyN1Cgo+IAo+IOWv
hOS7tuiAhTrCoEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4g5a+E5Lu25pel5pyf
OsKgMjAyNOW5tDPmnIgyN+aXpSDkuIrljYggMTI6NTIKPiDmlLbku7bogIU6wqBMaWdodCBIc2ll
aCAo6Kyd5piO54eIKSA8TGlnaHQuSHNpZWhAbWVkaWF0ZWsuY29tPgo+IOWJr+acrDrCoEhpbGxm
IERhbnRvbiA8aGRhbnRvbkBzaW5hLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ+Cj4g
5Li75peoOsKgUmU6IOWbnuimhjogW1BBVENIXSBmMmZzOiBhdm9pZCB0aGUgZGVhZGxvY2sgY2Fz
ZSB3aGVuIHN0b3BwaW5nIGRpc2NhcmQgdGhyZWFkCj4gwqAKPiAKPiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lgo+IE9uIDAzLzIyLCBKYWVn
ZXVrIEtpbSB3cm90ZToKPiA+IE9uIDAzLzIyLCBMaWdodCBIc2llaCAo6Kyd5piO54eIKSB3cm90
ZToKPiA+ID4gSSBkb24ndCBzZWUgbXkgYWRkZWQgbG9nIGluIHNiX2ZyZWVfdW5sb2NrKCkgd2hp
Y2ggd2lsbCBpbnZva2UgcGVyY3B1X3VwX3dyaXRlIHRvIHJlbGVhc2UgdGhlIHdyaXRlIHNlbWFw
aG9yZS4KPiA+IAo+ID4gTWF5IEkgYXNrIG1vcmUgZGV0YWlscyB3aGV0aGVyIHRoYXdfc3VwZXIo
KSB3YXMgY2FsbGVkIG9yIG5vdD8KPiAKPiBQaW5nPwo+IAo+ID4gCj4gPiA+IAo+ID4gPiAKPiA+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+ID4g5a+E5Lu26ICFOiBKYWVn
ZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgo+ID4gPiDlr4Tku7bml6XmnJ86IDIwMjTlubQz
5pyIMjLml6Ug5LiK5Y2IIDA4OjI5Cj4gPiA+IOaUtuS7tuiAhTogSGlsbGYgRGFudG9uIDxoZGFu
dG9uQHNpbmEuY29tPgo+ID4gPiDlia/mnKw6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaWdodCBIc2llaCAo6Kyd5piO54eIKSA8
TGlnaHQuSHNpZWhAbWVkaWF0ZWsuY29tPjsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQgPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Pgo+ID4gPiDk
uLvml6g6IFJlOiBbUEFUQ0hdIGYyZnM6IGF2b2lkIHRoZSBkZWFkbG9jayBjYXNlIHdoZW4gc3Rv
cHBpbmcgZGlzY2FyZCB0aHJlYWQKPiA+ID4gCj4gPiA+IAo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lgo+ID4gPiAKPiA+ID4gT24g
MDMvMjIsIEhpbGxmIERhbnRvbiB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIDE5IE1hciAyMDI0IDE3
OjE0OjQyIC0wNzAwIEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gPiA+ID4gPiBm
MmZzX2lvY19zaHV0ZG93bihGMkZTX0dPSU5HX0RPV05fTk9TWU5DKSDCoGlzc3VlX2Rpc2NhcmRf
dGhyZWFkCj4gPiA+ID4gPiDCoC0gbW50X3dhbnRfd3JpdGVfZmlsZSgpCj4gPiA+ID4gPiDCoCDC
oC0gc2Jfc3RhcnRfd3JpdGUoU0JfRlJFRVpFX1dSSVRFKQo+ID4gPiA+IMKgX19zYl9zdGFydF93
cml0ZSgpCj4gPiA+ID4gwqAgwqBwZXJjcHVfZG93bl9yZWFkKCkKPiA+ID4gPiA+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLSBzYl9zdGFydF9pbnR3cml0ZShTQl9GUkVFWkVfRlMpOwo+ID4gPiA+IMKgIMKgX19zYl9z
dGFydF93cml0ZSgpCj4gPiA+ID4gwqAgwqAgwqBwZXJjcHVfZG93bl9yZWFkKCkKPiA+ID4gPgo+
ID4gPiA+IEdpdmVuIGxvY2sgYWNxdWlyZXJzIGZvciByZWFkIG9uIGJvdGggc2lkZXMsIHd0ZiBk
ZWFkbG9jayBhcmUgeW91IGZpeGluZz8KPiA+ID4gCj4gPiA+IERhbW4uIEkgY291bGRuJ3QgdGhp
bmsgX3dyaXRlIHVzZXMgX3JlYWQgc2VtLgo+ID4gPiAKPiA+ID4gPgo+ID4gPiA+ID4gwqAtIGYy
ZnNfc3RvcF9jaGVja3BvaW50KHNiaSwgZmFsc2UsIMKgIMKgIMKgIMKgIMKgIMKgOiB3YWl0aW5n
Cj4gPiA+ID4gPiDCoCDCoCBTVE9QX0NQX1JFQVNPTl9TSFVURE9XTik7Cj4gPiA+ID4gPiDCoC0g
ZjJmc19zdG9wX2Rpc2NhcmRfdGhyZWFkKHNiaSk7Cj4gPiA+ID4gPiDCoCDCoC0ga3RocmVhZF9z
dG9wKCkKPiA+ID4gPiA+IMKgIMKgIMKgOiB3YWl0aW5nCj4gPiA+ID4gPgo+ID4gPiA+ID4gwqAt
IG1udF9kcm9wX3dyaXRlX2ZpbGUoZmlscCk7Cj4gPiA+ID4KPiA+ID4gPiBNb3JlIGltcG9ydGFu
dCwgZmVlbCBmcmVlIHRvIGFkZCBpbiBzcGluLgo+ID4gPiAKPiA+ID4gSSBwb3N0ZWQgdGhpcyBw
YXRjaCBiZWZvcmUgTGlnaHQgcmVwb3J0ZWQuCj4gPiA+IAo+ID4gPiBBbmQsIGluIHRoZSByZXBv
cnQsIEkgZGlkbid0IGdldCB0aGlzOgo+ID4gPiAKPiA+ID4gZjJmc19pb2Nfc2h1dGRvd24oKSAt
LT4gZnJlZXplX2JkZXYoKSAtLT4gZnJlZXplX3N1cGVyKCkgLS0+IHNiX3dhaXRfd3JpdGUoc2Is
IFNCX0ZSRUVaRV9GUykgLS0+IC4uLiAtPnBlcmNwdV9kb3duX3dyaXRlKCkuCj4gPiA+IAo+ID4g
PiBiZWNhdXNlIGYyZnNfaW9jX3NodXRkb3duKCkgY2FsbHMgZjJmc19zdG9wX2Rpc2NhcmRfdGhy
ZWFkKCkgYWZ0ZXIgdGhhd19iZGV2KCkKPiA+ID4gbGlrZSB0aGlzIG9yZGVyLgo+ID4gPiAKPiA+
ID4gwqAtPiBmcmVlemVfYmRldigpCj4gPiA+IMKgLT4gdGhhd19iZGV2KCkKPiA+ID4gwqAtPiBm
MmZzX3N0b3BfZGlzY2FyZF90aHJlYWQoKQo+ID4gPiAKPiA+ID4gQW0gSSBtaXNzaW5nIHNvbWV0
aGluZz8KPiA+ID4gCj4gPiA+ID4KPiA+ID4gPiBSZXBvcnRlZC1ieTogIkxpZ2h0IEhzaWVoICjo
rJ3mmI7nh4gpIiA8TGlnaHQuSHNpZWhAbWVkaWF0ZWsuY29tPgo+ID4gPiAK

