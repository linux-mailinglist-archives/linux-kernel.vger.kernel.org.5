Return-Path: <linux-kernel+bounces-84669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4C86A9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C61B25A80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3D2CCA7;
	Wed, 28 Feb 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LYwyLrc2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="an3zQwNI"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C72C850;
	Wed, 28 Feb 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108711; cv=fail; b=B4bhjLL59KdRmTTZoL/46Pkyh3dGke76mtiSkAGBrL6RrgxXX2iiuQXLEiViaY1j4vHZ7RJ9/SNEBJgXZ6rQ63SCdjza8uFBe2PbJXR3oG7Z8uClBdAUFSb7Rh1QvQDmC2eOaffoAfEJ3nafaVLcr57bZsy25jnwu/asgN/MA5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108711; c=relaxed/simple;
	bh=t6xkaoKhbk+uZroIocb0PIICoS4/ZNFEPBnqdYJ541k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KWpxMCdu2tNG6q8cLymqgcKlATqIy5Jt+JPfaXeyhW8cpLp3w3GuTHIBNli7vEFKlJXReVFDdWUqXZ1FSx4+izgftQOO7DQhYw/IsdVt1VYqUkHTbmkxit+Orb2X1rTeVCWtEdyxtYSrMF73jNvtE4+eemEd61Wm17tIM8LAmOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LYwyLrc2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=an3zQwNI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: de2691a4d61211eeb8927bc1f75efef4-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t6xkaoKhbk+uZroIocb0PIICoS4/ZNFEPBnqdYJ541k=;
	b=LYwyLrc2x16gO2VvaKnohxqjGoHvBvHsw3f6lsYqXN8lfawvE0p9KnditQ6M2ITIHcx4M9O9NWYS1+aXXxnIF3Qv9ThjrqQWCePBlDkQQewvHRiAHh7/3NyostRBmyXuOfxJ4dGir5SHM2O+3UOAp5wT3PSJmcRh7E4wTrf4ITk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f9dcfe03-9a49-453f-96c4-a07d156692f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3101ce8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: de2691a4d61211eeb8927bc1f75efef4-20240228
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1062476270; Wed, 28 Feb 2024 16:25:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 16:25:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 16:25:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYBfPNsAQzYrmd6Ylfe01W64QYXnt2Peze2osDkzDVx6ktzVbQfbECC5+eoUxspNsNwF6kd3VvdK0CIeLhFG3L5orAtfn4XbkGhRdKflkMUSRRLyYuQRW4iMzQ6UhGbdGIQ/LmCCCdqUKEaHrNnj/DHf0Jj1dBcSIT7bdz5Hxnu7A7NAI8JeKCYFsA2fjCuL1ZnIJOmoaXlZI7nz/PyFlxz3MXe9WCLcQW2UMgLFgRAWvm+uBEHhvXmDgMHb5jbH4EyhA+ajOF4EzPGA8FyEYpq0j7YdcGlwkC90UW1FBXa2DOSLlsPmQMFl0PxjXFQ6a1huwTJXDCDTQCdQFfR6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6xkaoKhbk+uZroIocb0PIICoS4/ZNFEPBnqdYJ541k=;
 b=boBfeoQHHEB1eJEEKgJucT4WoVfeE+28XPdLjwrvuN5cVLH0s0DEFecUYkgoLGmW8TvFJGZrLaVSm0lsGSvXx5iCBaXn/nwBfybX/x242wvNImJC+czS6ApjJ8uEJzth/iKzBPG4SUjEzUrJvOyFjxODM3IrReNNTNqAzd4FeogQFFurCBiKocpa9NdDcxL6PU6orD39HswqbbMj/QIve7/MU8uBiVKgqR9k8CpV7f1HcJkjLZHR87p2ZTbPJg28P6aVLdxRHefv8/QJx3bhgfuv27ek4gywFXS20ApiyO9HvjCgI12IBmdBXNr7qJs9MBnbAHrdbnq7yeTzS55F8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6xkaoKhbk+uZroIocb0PIICoS4/ZNFEPBnqdYJ541k=;
 b=an3zQwNIWC3bQ6+8Fwyjj6sTojpO17CcYRvDyyFZejbLzNXfNtP0WMA/OSuFvPvsfGkrhXF3I/O+CmwuWje80Rm3IGE7GsutfI4uOwfBzQ51VGDfUVRs8x3A71SgFRm5mzaAzhU1Hd92jwZMaVowAR2rnIutIwiXNNVNXwi69K4=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEYPR03MB6879.apcprd03.prod.outlook.com (2603:1096:101:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 08:24:55 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 08:24:55 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: [PATCH net v2] Net:cache didn't flush when ipv6 rule changed
Thread-Topic: [PATCH net v2] Net:cache didn't flush when ipv6 rule changed
Thread-Index: AQHaah+c6oKxRhQg9Uub4r5oXRowsw==
Date: Wed, 28 Feb 2024 08:24:55 +0000
Message-ID: <696e39599c7a5e793a9d96aceef0e34817ab0bb2.camel@mediatek.com>
References: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
In-Reply-To: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEYPR03MB6879:EE_
x-ms-office365-filtering-correlation-id: b24006d9-3f4c-4820-acfb-08dc3836be9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DD/Xcninj9MBWxUSgAn/23mdtCR7Rjuk6cX1IZytrslbtMrJEDZKSTHusDPxhlJfSTzA9E7gqHvUB3nVqKlnn4WQvbfYbs7C8D1xMAiOQFjp6rrvzTwLqDzZ37UotqejwpIfQOFkCrRZRGKsYnJOxDw+zytU4dsVBdTL2Ny+5ihfIj+6B4u+VYHtB9RHz9ZOFejPJvXBAs6z1L8tLi2ACdQ4PtRThSRk50CR+F69pZ8BmOJ0xLgERGwS6tyBRIkoKcwuzmAnLcPqcUpRH8OMJCf+9yHhFP0zo1Q+TASDPin0svMGMMEJnrLhWFms/plynxLSiXvJu9KFMlveOR/SbYti6KeFrIh5le0Zi58Xdc6y6ZRvBBb3v6PV+EnukDQVslACS7p3gNmSv5v08adt3XlXKZvB4PgtoVcK8bSyxeE6ow84BhtgFgv6nH2Ubi+IJVqp1ZtIVfstPkRxhG7RPUEWpRI7VE5gXNwLfCuErUUiZj+P/crShm/waWJTCGB4i7jJOra8Smu3znLUIvc0q+X8mpkUFTCvor/IPlGtAwWA77bacu3zrwL5vJfUq3j1NiaZ/INT2FUEH/WE4/sZIAewDm+K242j+XG3XnAEtc2C0vAP0kF8IaRS8yyuJrOhgA7Uh+QtqSk5E8tkRuSRjizygaHQ70nCBsQWgfeDjLf1Dhu/J3InlBfW4KJPjfwekinyTJH8VnfHK73gkv0ngg/J2zi4QND83PVUVMa9Kc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9nQms3eHB0cGQyV2QzK00wY0lHdC95NjE1MXlWQ1FzUXA4RnJUUk5FU0pl?=
 =?utf-8?B?Z1FLSzRURVp2eGpsTno4UGZLUVJCVXZ3Zi85STJEc1ZHNlJ0UERjMngzdklL?=
 =?utf-8?B?bmY5Q2I1ckhZTVlLbkVRcU1iM0tBckNCbitvdVQ0WnRob2tMWVhOVXlVb2JI?=
 =?utf-8?B?RXZlbVE5YUVYRzhuWDZUSUpLRkhNNGZWbTVjeDJndW0yUVlYWXh1aElyNjBS?=
 =?utf-8?B?R3F5bkVISktwd25KdndUTFFKQU8ydEpEL214cTVDZndieHZXNW5Kd2MxSHRW?=
 =?utf-8?B?ZUZVWjl1Vm83SWNYU29TRnZuaFpyUmtZZkVvYlhIN2FXMGdCQXp4NUhpbDI1?=
 =?utf-8?B?SkhGbEcvRDlubFY1U3kyVllSNGZXZzR3a2Z1R25waXJyWk1DcUdXUFJaME9s?=
 =?utf-8?B?ZHVZNHlQd2o3dEQrWVZqUGliMUpIeGlicDMrU0xyU2tUc29XeTZHNXRybzJJ?=
 =?utf-8?B?dFZCKzgyK3NRL3o3bFFiaGd5anV3aElPTHE2Mlg2YkhGb1gxKzVKKzgrbXNv?=
 =?utf-8?B?MDR4UDFTSk5YNEp4L2hwajZjaWUyRHhDYm5TL0Y3WWU5YmVMb29aMEExV2Nw?=
 =?utf-8?B?WVZVNkdWbXJERmNvOThEcVZGVmI5bytNR1p3dUVqS0tVcGw5dmR0ZXpuUTVX?=
 =?utf-8?B?dExCVmd3MU9GaFo3bStlNWRSUUZuYUJDdTRJcCttVUV4N1ord1N2dDhmbEJo?=
 =?utf-8?B?N1l3K3JCZU5wTVN4cVV0Y0hsQlM1SGVLYmRac0VSWktpOUEwQTFnbjU3dmtl?=
 =?utf-8?B?alhMd1JYRVVDWGZmRlZCMUxaUU5vQTdMZVY0ZC84a2Q2UlJMQTVLU0FQOXE2?=
 =?utf-8?B?UlZHMG9NOW9Fbk5ldzJKWW9nemJRNWluemdOS0t3MlhnUmUwOGMwSVp6OExG?=
 =?utf-8?B?SUpSdTRXRnVlcTBSeHJrK2JTNTVTdDNNTmRCUG5RWWQ4SENaN04rSmJDTm1J?=
 =?utf-8?B?cWpEcEZ1cjlwNEtuQktheDFxUmQxempIUkFseGVlYyt6ejNmM2R2bThpWnlw?=
 =?utf-8?B?MklqZlg1bStZMFExUjV3QmVTMFU0d251WlBWT0ZlVFVUdGpieGdldDc5ZTRh?=
 =?utf-8?B?UitMcHc5NGl4WDY2NmRIM1krZTd0azc0NHgzczJLWEVUbXpwWElNVVpPa0lv?=
 =?utf-8?B?TUNZQnZWTDVGUjUwRlZQai9EbTlsK0pqMVVKZzlxUGNPZWNYbkc1ZGNIV3Uy?=
 =?utf-8?B?SWhNUEttdTArek1HQm9uNEtSakRxdzEwK3RCQVpFT3QyYTZhTjdNbUtRRnFE?=
 =?utf-8?B?QytZQ0MwRkgwSEdaVjNMVzlhNjVaZzQ3ZXlrYnE4anNYbVBGTHdOVWJXTVc4?=
 =?utf-8?B?TEhZSUtwVWdnV29tZVliK094ZDlZcWV2RXQ2anpnMXA1Z2FJOEo1c2MwaEZF?=
 =?utf-8?B?OTZuMW8wMXgxNy9kdkIvVm10YVV4RUsyYjdFalZKSDZVbSt2OVZjNE11VnJE?=
 =?utf-8?B?eFY4R0ZpTXZTT2dVRVZndXdhN3FBNVJpQ1BBenlIYzJrd2x2R0pINms2eDZM?=
 =?utf-8?B?bWh2SjJ3QnFLNHEvTjF0UERMWkh4SFVYQ2twL0JrMVZuWDd5OEFrVnZObXAy?=
 =?utf-8?B?NmhjaVZWakdqcEowb2NxcFNwOGNuMS8wWmhGM3FuQzRnU2prenR3N2NTN0p2?=
 =?utf-8?B?bmlFYm1Ca3drNkJDeDhNbG9XbXV4WFBqUS9PcUJWcHlkcUJuV012K3lOTFdZ?=
 =?utf-8?B?czNZZTI0ejRVR1BrRzNzOVNDbXRRR3B0MncwRTNpTUpGUHdtcEhtZFQ2eERK?=
 =?utf-8?B?eUNVNitFeDd0aDIyOUtQZ3pSSm5GZ3o3YitoblFGMW5TUmdnRlRackxTRGhx?=
 =?utf-8?B?VmQ0Wk9CZi9YR1lsMGYwVE5vcUpVYUVHWVRkejBveDMzVDErbnJWYTFaQ1lK?=
 =?utf-8?B?TWpBU1IvOEsrOFZHN1UvQW5jb1ZLeGttTEFIN3ZaRGhza3Z4ZlViZXdMTGQ5?=
 =?utf-8?B?Tm1HYWJuU1l5bXQxUFRDd2gvdCtCWUR2Y0JxaW5NODEvcUpZNDFTQTEwNU9S?=
 =?utf-8?B?eVlaWE9SVktFdnIxYTJVT1Z4bXgyd1luSkFJSlkxazdWREptajBuN3ZOcERa?=
 =?utf-8?B?RjVJOTIxTGo0L2VBUFVPSFAwV24wUHYrUnRjUktHMlhXUEdpTUx6YkFGSG0w?=
 =?utf-8?B?RGE2M1NldFZhUUJBWHB1anZMV05EUG1aQWQ5TjlUVjcyL29nY0dxVVBJd1NE?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2ECCE70935C74082A5FBEE227FB812@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24006d9-3f4c-4820-acfb-08dc3836be9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:24:55.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnD8NGxGQthL5j8brUI5FHPFzHFargYVXTxHxo3MoQ4OS4V5ZtcVGBeaWcJ8IXKczypSjSsUaNNB27vSa6zn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6879
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.495200-8.000000
X-TMASE-MatchedRID: 8O9XrlnJpuwUN/8aAzvyJfVFR4sC8dPyWYu9PKwvg8/+TXZJvYxoecCS
	2AMm1nQCqeCFN03ZT0c18T+UX/k6C4moXedGE6+KjWe5HOFKvuO+OYU/Hm95Gd9zZd3pUn7KmBy
	ZR5gLLj478mRVMHEjG17ZOWlZyFCqzB1CJ6qmdNpor4yxPAz7WUyQ5fRSh265CqIJhrrDy2/8/L
	2o6LnOl1PEBxhgY10jzPswo+b23xfvk9E0156d6KDH6drx3JPVfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDV4aBaaKovc7xmgJDpdISDeemgtuhDgV3pkO0DDJG8LV4Z6qqfuZrRa
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.495200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C92A945A6C14ECA83A1ECC3391208E8901DDC4F6EDD524C81638397F2A132D732000:8

RnJvbSBiZjUzODU5YjM3OWE2NTNlZWM4YTE0ZmJiM2YyOTI4NmY5Zjg4OGZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogc2hpbWluZyBjaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRl
ay5jb20+DQpEYXRlOiBNb24sIDI2IEZlYiAyMDI0IDIwOjE3OjU4ICswODAwDQpTdWJqZWN0OiBb
UEFUQ0ggbmV0IHYyXSBOZXQ6Y2FjaGUgZGlkbid0IGZsdXNoIHdoZW4gaXB2NiBydWxlIGNoYW5n
ZWQNCg0KV2hlbiBjaGFuZ2VkIGZyb20gb2xkIHJ1bGUmcm91dGUgY29uZmlndXJlIHRvIG5ldyBv
bmUgYXMgYmVsb3csDQppcHY2IGNhY2hlIGRzdF9lbnRyeSBkaWQgbm90IGNoYW5nZSB0byBuZXcg
cm91dGUgdGFibGUgYXMgbm8NCmNhY2hlIGZsdXNoIGNhbGxiYWNrIGZ1bmN0aW9uLCB0aGVuIGZv
cndhcmQgdG8gd3Jvbmcgb3V0IGludGVyZmFjZS4NCldoZW4gZmliNl9jaGVjayBkc3RfZW50cnks
IHRoZSBmaWI2X25vZGUgdmVyc2lvbltmbl9zZXJubV0gaXMNCmFsd2F5cyB0aGUgc2FtZSB3aXRo
IHNvY2tldCBkc3RfY29va2llLCBvbGQgY2FjaGUgZHN0X2VudHJ5IGlzDQphbHdheXMgdXNlZCBh
bmQgbm8gY2hhbmNlIHRvIHVwZGF0ZS4NCg0KU28gd2UgbmVlZCB0byB1cGRhdGUgZmliNl9ub2Rl
IHZlcnNpb24gd2hlbiBydWxlIGNoYW5nZWQgYW5kDQpmbHVzaCBjYWNoZSB0byBhdm9pZCBkaXNw
YXRjaGluZyBhIHdyb25nIGludGVyZmFjZS4NCg0KU2lnbmVkLW9mZi1ieTogc2hpbWluZyBjaGVu
ZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQotLS0NCnYyOiANCiAgICAxLiBBZGQgdGhl
IGZpeCB0YWcuDQogICAgMi4gQ2hhbmdlcyBhY2NvcmRpbmcgdG8gRGF2aWQgQWhlcm4ncyBzdWdn
ZXN0aW9ucywgbW9kaWZ5IGZsdXNoDQpmdW5jdGlvbnMgc2FtZSB3YXkgYXMgaXB2NCBmbHVzaCBj
YWNoZSBhbmQgdXNlIHRhYnMgdG8gYWxpZ2ggd2l0aA0KZXhpc3RpbmcgY29kZS4NCi0tLQ0KLS0t
DQogbmV0L2lwdjYvZmliNl9ydWxlcy5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvaXB2Ni9maWI2X3J1bGVzLmMgYi9uZXQv
aXB2Ni9maWI2X3J1bGVzLmMNCmluZGV4IDc1MjNjNGJhZWYzNS4uNTJjMDRmMGFjNDk4IDEwMDY0
NA0KLS0tIGEvbmV0L2lwdjYvZmliNl9ydWxlcy5jDQorKysgYi9uZXQvaXB2Ni9maWI2X3J1bGVz
LmMNCkBAIC00NDksNiArNDQ5LDExIEBAIHN0YXRpYyBzaXplX3QgZmliNl9ydWxlX25sbXNnX3Bh
eWxvYWQoc3RydWN0DQpmaWJfcnVsZSAqcnVsZSkNCiAJICAgICAgICsgbmxhX3RvdGFsX3NpemUo
MTYpOyAvKiBzcmMgKi8NCiB9DQogDQorc3RhdGljIHZvaWQgZmliNl9ydWxlX2ZsdXNoX2NhY2hl
KHN0cnVjdCBmaWJfcnVsZXNfb3BzICpvcHMpDQorew0KKwlydF9nZW5pZF9idW1wX2lwdjYob3Bz
LT5mcm9fbmV0KTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3BzIF9f
bmV0X2luaXRjb25zdA0KZmliNl9ydWxlc19vcHNfdGVtcGxhdGUgPSB7DQogCS5mYW1pbHkJCQk9
IEFGX0lORVQ2LA0KIAkucnVsZV9zaXplCQk9IHNpemVvZihzdHJ1Y3QgZmliNl9ydWxlKSwNCkBA
IC00NjEsNiArNDY2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3BzIF9fbmV0
X2luaXRjb25zdA0KZmliNl9ydWxlc19vcHNfdGVtcGxhdGUgPSB7DQogCS5jb21wYXJlCQk9IGZp
YjZfcnVsZV9jb21wYXJlLA0KIAkuZmlsbAkJCT0gZmliNl9ydWxlX2ZpbGwsDQogCS5ubG1zZ19w
YXlsb2FkCQk9IGZpYjZfcnVsZV9ubG1zZ19wYXlsb2FkLA0KKwkuZmx1c2hfY2FjaGUJCT0gZmli
Nl9ydWxlX2ZsdXNoX2NhY2hlLA0KIAkubmxncm91cAkJPSBSVE5MR1JQX0lQVjZfUlVMRSwNCiAJ
Lm93bmVyCQkJPSBUSElTX01PRFVMRSwNCiAJLmZyb19uZXQJCT0gJmluaXRfbmV0LA0KLS0gDQoy
LjE4LjANCg0K

