Return-Path: <linux-kernel+bounces-67950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5346A857381
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7873B1C234D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB13DDC6;
	Fri, 16 Feb 2024 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bl8H6wZf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gDNAzhfE"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E910949;
	Fri, 16 Feb 2024 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047609; cv=fail; b=JFPwpWkLJ/2DrN1hFk+VWvlJmqCKHd9EjM2u6TxK15Hfdk+OKIPd+yOFOxCMOO3Z01opnAGKax+mkcVifpdgP8++fkkddeSKzcZKxStQE/K2UNVjKBgqu0jZQdYVy9S8lFyrsEpA9TKOn9T4Lkida5fcQj8sGnC2zEJ7y4QVTFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047609; c=relaxed/simple;
	bh=65Y9VzRWzEmG+LSCtL1YdUg6SS9VsZ7nakuj/OZAlUU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZD+COHxdQFLiKwWkFjbCx7UbXvHgv6yjzUOFJiEAjasq+w2yxbTiPXmqksWcONV2RE+UrF4G3ZJlxH3Y/Q566KDO91hBrgL32F6ToFOe9CfekCPxBQUmDYYPle4BWT2bC7CiCp+8ghFCI9wA25fvovqaQHOw/01HdBGI1HWy5NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Bl8H6wZf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gDNAzhfE; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f788206cc6c11ee9e680517dc993faa-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=65Y9VzRWzEmG+LSCtL1YdUg6SS9VsZ7nakuj/OZAlUU=;
	b=Bl8H6wZfWx3i3/AIA0qpf6/IQ/eCkBSWmGuoWuueY3+s0MBosQrnMVNEh801RrNYB7xknIc/tPtYtaj4O3Z6I/4ZbXIrSbu9P7DLRo4e2u7wIkfQ5NZ1iFwfukig+dG2S9ifgaQzwJvBN+8fiuk/VGRzF2SrbJ3Pi9v5fSJ8aPg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:74a678cb-fee1-4cc2-af79-42f6e8e7b6ae,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b276578f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3f788206cc6c11ee9e680517dc993faa-20240216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2050614151; Fri, 16 Feb 2024 09:39:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 09:39:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 09:39:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNM1sZrsWXDvBURx8jxOdPrFrcvZn1AAX0duEUvlh4toKp7bCS01NDuApjwnbozomebG3zRQL5or62CKEuUFiiMNeTPoPSVCSw3SCH9iOOfbTRKw21l22cSKNKsG8MeQdy/1P5TRkO0Yz8HSNEwrptkl3BZ1akCDEwv93LjZzElXBMEvdm/f1u8Uz2IviiImF71vIxrZLRPzo9VGG/SBR1IygboPvIHmE9wAjyV8mIKkaoHf0DVdg4DnhUVVPm6XCP9BiNSm2z4gVJuejSDoGamMi5JrHWG++aC6oVZl+cLYZw/u4lEKasEzlPfYlJek4KP9rYEJgIi/6G337kygfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Y9VzRWzEmG+LSCtL1YdUg6SS9VsZ7nakuj/OZAlUU=;
 b=kGO7yyX08mvyKJwagkhQmnXlDdBpBCMbQATFsnfjholVw3JtHuLJYNoFFfNQnQZCGroM8uTrJdDWI1Fv1BMWMBV/pn862QpNDwQm928xotn3cxU2BUv3hwAQO2+kHwvEDZjCMUHHUe28SpER+DqASCWFRgctQVTOcPbxZCvNCa3D7BjAwOpuqyuNGWxuwFWdmQKzCsRFdvZclJBkVuBWiT217eAOCINl4xr6Nfn5WYc1AymiqxIYrHglbqkXJ78/clmORvJS6ZM8yh8euKa8PrAtf34viR3CrpcO5qNj8OrAEjn2C2WhqhMr/WUFwIJRQNYalLFg4UJQwCBsna3Ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Y9VzRWzEmG+LSCtL1YdUg6SS9VsZ7nakuj/OZAlUU=;
 b=gDNAzhfEyrsukZftWlPh1+Iw82VRcGKCPD3JJyczajYB0RcSvW/VJEkU1ZaZvWFvArqpa0asUmj18bdYLS7sEkTy3CHiwkyn4KpMmqBUxGegIHFKVxuvX2XlRNfbuGRIC6YzNVj/YOKXMBSoz2IvPoQy0k3kLkYcX3MmjuYvF90=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5464.apcprd03.prod.outlook.com (2603:1096:301:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 01:39:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 01:39:35 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 4/9] soc: mediatek: cmdq: Add cmdq_pkt_nop() helper
 function
Thread-Topic: [PATCH 4/9] soc: mediatek: cmdq: Add cmdq_pkt_nop() helper
 function
Thread-Index: AQHaX6kNVnqiIRgASUWdE5QgeA0WCLELN4yAgAD7H4A=
Date: Fri, 16 Feb 2024 01:39:35 +0000
Message-ID: <830cde86af0df89f3331ff89e2b04e51f27cfd1c.camel@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
	 <20240215004931.3808-5-chunkuang.hu@kernel.org>
	 <680fcb9a-d7e2-4a15-877e-09c01024ed53@collabora.com>
In-Reply-To: <680fcb9a-d7e2-4a15-877e-09c01024ed53@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5464:EE_
x-ms-office365-filtering-correlation-id: d22aecef-cd01-4623-d63d-08dc2e9021cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+pqkuj4YgrTI1OVqaIZD+iDSCz9ZGwPbu6ggdjcMJXY9yUNokT/8LBKSHN3qBTDBnVEUQ9IN7oKHh653NC1CzQpTxmHpTjb1XPJK19/dU+EfXSIBrqmrRyPLUNzAeKj4xXBitKocqCNN6jp8EQXCLpt4cnXW6Ox3Rl/BZvKX378cJrJlHElqdz7LluCY8d1jxjLgImQUuqPBDejqBwPxhSDH7foFWFqbCTlc274XcZgX/HHUa2WlBEUiszKS+ffQkDCRy+ZIqKlNdx6W7Z3WEWjhWcqelWEy0/xvor2vVhLTAfG6H5gpCHmgT4UBrNiHHeQgimkhoW098ZZamnnU4s5R9uDqucYTWHyOwTEfF0pIoSrEm1RgpIpm/ZWD8HMMRpHzuXcYuN1u/ZeSlVGtFok9olyxLUaz9yiIyTALtde7sYdcduujVjXL+j1oQ+IPWrcBvamKrX/tsT/Bxp/RXbOSHpGGQFh3BePTraBNKdAJh9UqCk2hutR3fvQ0n2qsaRRmXA02GnIxUih1rqWlubZsRjYr26t1C60vA4G+Cc2KCqshzCghoe8xKECNUc0DR8fYpoTRN8FWbze6DDMJ91m4gSjvbVAQc0Gfaj4zg6Ci/M8+P4oE15zY0nZJitb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(64756008)(2906002)(66476007)(66556008)(66946007)(8936002)(8676002)(76116006)(5660300002)(66446008)(86362001)(122000001)(36756003)(85182001)(38070700009)(26005)(2616005)(110136005)(6486002)(71200400001)(41300700001)(38100700002)(478600001)(6506007)(316002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZ3eDNTZ0RCKzFBV2llWHJoNVZkVHpxQ3lJais1QTgySGY5YWk4Y2kwOUtz?=
 =?utf-8?B?dUtFNXFYVk9TSjkzQUlHRXJjN01pMFNyNjhHL2I0SkhoU2ZnRnRyTytSenhZ?=
 =?utf-8?B?MTl6ZVFMZWtIZCtiQk0wWE9KWG9FZGRMamdyWHIzWCt0RHZxOHl1NGc4cG0y?=
 =?utf-8?B?d1o2K01GY0k4SHJpMGVJRWhZa1NuRy9kdGlySTJ3U2c5N3VhSWZ1d205MDZW?=
 =?utf-8?B?NUh0aGxUdTRrWnpkcEFCNUoxbW5LbzZqM095S3VHRnRQY3E0bFNJWU1YRjVU?=
 =?utf-8?B?c0UrYlY4ZmtjanZZZVZ3R3drRHBKRUZpRmNXTVBJSm9CSzI1RmR0QkVlLy96?=
 =?utf-8?B?RDdIN1o3V1I2dTZZaW5QUSs3UlU4NVN1Z2lvVHlZVmpCZ2wvWU5nU0pEdENJ?=
 =?utf-8?B?dUxHcEJRWTV3NlVtQVVQNzJDWnF0aVUrSk5oQUU0eEFDRkY4bkErdE9CZW1u?=
 =?utf-8?B?aGlyLy9ONm9LakJldzQrSXE0d2lXMVJ2dU1wNkVva0RrRUN4TDl4SXVhRFpv?=
 =?utf-8?B?UnBNRU9pNThYK0VIclQ5NlpxRWZsVTdtRExtUkFjN2x3Z3h1UmpPN21RK2lr?=
 =?utf-8?B?U1ZNUUxPOUVsSGczY0Z2UWJZSWQxaDFyMkdvL0JSNGFSZytQSmwzeVFldmlS?=
 =?utf-8?B?WkFRZ28wUjNGWWEvSS9CR0pjZklHeGE5QkpKTks2b3IrVWJCUTJmalFYc0ht?=
 =?utf-8?B?S3ZYRkwyZkZKTlZYdU1rYXlqbFhiVlNraDVDSEJKczZJYzhJRVo5Y1lMU0FZ?=
 =?utf-8?B?ZnFXT1lWRmpUcDc5VnBkbGpNTG9DeFJ2ODhvVmhjeWlWZEVkNDE2dmFCY0Fl?=
 =?utf-8?B?cWxoVEN0SmJ3SXRIK0g3U21RU09jNGNZb3BiVWhBNkRveHpCb3hFa2hwV0JY?=
 =?utf-8?B?T2dqMTBCZlQ4aHgySTJCSDFVRnhtWDZZQnUyaTJmUWpITFd1L1hRd2poWXZD?=
 =?utf-8?B?dktyVFZDNk4xNDJkOGU5Szh3UHFOc01ITEJKNEhuMTQyU2Fhc1ZST01ESyt3?=
 =?utf-8?B?dis0MnJwSG13VlZRc0JOTVJabEs0U2cvVjkzMi9KTWFXVU54NmtkaW5HVmdY?=
 =?utf-8?B?dnNKRG43THJESHFqV2tRWCtsUHlmd1dORnFqV1Fiek8xNlNtTEd6NDVldUpS?=
 =?utf-8?B?NzBpQkFaWjM1YzJVNXdaQUtLRDdvVUx4VjB0UEVTcTFsZjAvd2xRbkFISTlk?=
 =?utf-8?B?MGhVbHR5ZEh4K0E5Q3RXQXIrNjFVQ0hnQlNVZzFyYVZNa3FSVXZtQ0NNbTlF?=
 =?utf-8?B?TGR3dlZpY2d3N0NGUnRvRFRxdVhDZlNrU25RdjdDa04xVitSSWMwQkN2eEZU?=
 =?utf-8?B?a0RNYzlhRm5PeE9oRVQ3RmFTd3VpZ3NaT1lnZFJyeUtwck53OXNWMWxmclpN?=
 =?utf-8?B?VkRsUXNPVnVqWG90alA1eWl5dEVJSzFtVXllVUtoSGlZbWF2Wk5jcG5oSlFI?=
 =?utf-8?B?MGFucTRrMGFNNnc3M0taZlFsTTk0MU00RlhCdTFxMUhFVzVlTkhmUzFKZDQ2?=
 =?utf-8?B?bHVxQ05MMU1oN0NNb0J6bmU5QkhhaGh4c0wrdUE2Yk1Hc3E5R3BJYk1lS0t3?=
 =?utf-8?B?RGNwOTdzanQ0czA5dDRDZjZHRlA4SXRDV2pYOEdrOGtkOFdnWEptc0NSOTJQ?=
 =?utf-8?B?N2trQmRYVTI4dUQyUTd0dW1xaXhrbEtiNkJkZS9rekxidWJvSHo1WEVYbG96?=
 =?utf-8?B?SGxucDhwTXBRMnF2NlN1UDRsNXJSVVBVQUNMYmZLa2x2RG51c0FadEExQS8w?=
 =?utf-8?B?Sythd0p0WEtOcHRkMkM3R2lCM3cxeUJjVFM5NzVpWW16b3hLTnBnNDl2SURT?=
 =?utf-8?B?dUhBcDUyMmlpdmdRWUxrWUI3RUprVXdiMURSd0RBZnJjam5iYjcxenlUeWVS?=
 =?utf-8?B?ek1VNHFrNVhOR2daYUYwdWpZSmRXczNtL1RtcXJHU2FlQnJJcGx0WE9JNHky?=
 =?utf-8?B?K1FLY284MGlQZHV2ZGhsRWlzK1l2NHU0QnA1OWNrRWdOeC9TMEtjenQvayt2?=
 =?utf-8?B?S3VJWFgyTGlGWGZlTVc5b3IvVmc4MkxBSXJLVkZTNkFDK0VORkU1YzliNnor?=
 =?utf-8?B?SWphYU1ha1RGelNlNDhQK1g1QVNmZjdCZFhLY2E1SVJ1RGhiZ1ROeEwxVWYv?=
 =?utf-8?Q?X5gRvMJ/oxbZKOYYiP1IV14Yu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AACBF210DE93D4A98A584FD8194FBED@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22aecef-cd01-4623-d63d-08dc2e9021cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 01:39:35.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKPlkGML70V8pVc1goaLPUREKMSvhUFX3R+3MgDph18wXryonKdNVwxafsxYytoVhBYcT5/5pmESm3rKXrYAIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5464
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.764900-8.000000
X-TMASE-MatchedRID: VPleTT1nwdToSitJVour/UD6z8N1m1ALjLOy13Cgb49qSjxROy+AUzj/
	a6hfsf6jUmsNbSHn8eAn3KEucUB/5omdFQV6iA8PGVyS87Wb4lyy4iyjvVWToiz+5QCTrE/sI6q
	q9xPsXYjdxyx5rGbLg031dl5LHVJBnuh7s4XRTZZgS3HnT6jvf7WTdtEh1dU0bcPp/oilssjPnM
	Ai6bw5xP1ALR2pad+hkZOl7WKIImrS77Co4bNJXQtuKBGekqUpI/NGWt0UYPDhS9L3PO5rYIkNe
	ipDPt1GBZMUgimhlTcEpubtyqI1GUO0p1hE1Fv7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.764900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FF6284BCB7250897974A059951AD46C27B9CB08449CF9C2A72CC36EAF7E266282000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDExOjQwICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTUvMDIvMjQgMDE6NDksIENodW4tS3Vh
bmcgSHUgaGEgc2NyaXR0bzoNCj4gPiBjbWRxX3BrdF9ub3AoKSBhcHBlbmQgbm9wIGNvbW1hbmQg
dG8gdGhlIHBhY2tldC4gbm9wIGNvbW1hbmQgYXNrDQo+ID4gR0NFIHRvIGRvIG5vIG9wZXJhdGlv
bi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVA
a2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIHwgMTEgKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmggIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAyNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4IGU5ODI5OTcxMTdjMi4uMWJlOTUwYjRlYzdmIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBAQCAt
MzY5LDYgKzM2OSwxNyBAQCBpbnQgY21kcV9wa3RfZW9jKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0K
PiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9lb2MpOw0KPiA+ICAgDQo+ID4g
K2ludCBjbWRxX3BrdF9ub3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHNoaWZ0X3BhKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiAr
DQo+ID4gKwkvKiBKdW1waW5nIHRvIG5leHQgaW5zdHJ1Y3Rpb24gaXMgZXF1YWwgdG8gbm8gb3Bl
cmF0aW9uICovDQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+ID4gKwlpbnN0LnZh
bHVlID0gQ01EUV9JTlNUX1NJWkUgPj4gc2hpZnRfcGE7DQo+ID4gKwlyZXR1cm4gY21kcV9wa3Rf
YXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGNt
ZHFfcGt0X25vcCk7DQo+ID4gKw0KPiA+ICAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQo+ID4gaW5kZXggYTY3ZjcxOWRlYzBiLi44MTc5YmE1MjM4ZjkgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAtMjU1LDYgKzI1NSwxNyBAQCBp
bnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwNCj4gPiBkbWFfYWRkcl90IGFk
ZHIsIHU4IHNoaWZ0X3BhKTsNCj4gPiAgICAqLw0KPiA+ICAgaW50IGNtZHFfcGt0X2VvYyhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCk7DQo+ID4gICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X25v
cCgpIC0gQXBwZW5kIG5vcCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRQ0KPiA+
ICsgKgkJICAgIHRvIGRvIG5vIG9wZXJhdGlvbi4NCj4gDQo+ICAgKiBjbWRxX3BrdF9ub3AoKSAt
IEFwcGVuZCBOby1PcGVyYXRpb24gKE5PUCkgY29tbWFuZCB0byBhIENNRFENCj4gcGFja2V0DQo+
IA0KPiBBZnRlciB3aGljaC4uLg0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IA0K
PiANCg0KQmVjYXVzZSBJIHdvdWxkIGNyZWF0ZSBjbWRxX3BrdF9qdW1wX2FicygpLCBJIHRoaW5r
IGNtZHFfcGt0X25vcCgpIGlzIGENCnNwZWNpYWwgY2FzZSBvZiBjbWRxX3BrdF9qdW1wX3JlbCgp
LCBzbyBJIHdvdWxkIGNoYW5nZSBjbWRxX3BrdF9ub3AoKQ0KdG8gY21kcV9wa3RfanVtcF9yZWwo
KSBmb3IgZ2VuZXJhbCB1c2UuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0K

