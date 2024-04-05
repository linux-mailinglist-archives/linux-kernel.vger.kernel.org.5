Return-Path: <linux-kernel+bounces-133166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D762A899FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076DE1C23173
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882F16F27E;
	Fri,  5 Apr 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jQMBF2QW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GJu8P+Wv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2B16EC10;
	Fri,  5 Apr 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327610; cv=fail; b=dAlrX2PA3u3r6uYbG1T+sFSGwSdcaJEqmprs/9h3XikL9viD8sf7rlVBXXeUStsfp/1RIK9DIkWw/qCMUJGHDCr+6klXMNYJ3e383FatVhwCBObHRA5Pvqtz5PHf/qLjP88KZHoeaREfr8PTOViuHpZtY7bFlyr21v4A11JfrAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327610; c=relaxed/simple;
	bh=jHZP82myEQQJn32w7utLLOD+fhEQ/7FjW/ZzVr5b4sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8rfrxU5YC7OtslN0NBmRG4EtAf/xzE2ToX+eCA7l1qlkvs65N4llJbzS1WyUZ65SevFc5JO5XPkE0jdl01LUckS83tgmeLsYGBIZ6UMBVcbMCozLLNSvysFtkIcM+7gyOseJxL8T7dV0VQponpXYwWf6h0+MVROms/Qa3ydZfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jQMBF2QW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GJu8P+Wv; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 725be398f35911eeb8927bc1f75efef4-20240405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jHZP82myEQQJn32w7utLLOD+fhEQ/7FjW/ZzVr5b4sk=;
	b=jQMBF2QWO6dsRCEpjj3ktNPazwcbtEeVaYWqUTa9fIXgIpTG4pzt4vRP5CmpvFgewrhK9w7BWxrZs0VaI9tM45XefukWHmBsV0NED7siKA7TzuxvejZzLAw1+pLAipa0oS8ztSORjMQ8hUkvFA4/yvxWLgaoyqwyBt9KczwujrY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7888dc53-6bce-42b4-98f3-21b8a5b2d393,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:be43d685-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 725be398f35911eeb8927bc1f75efef4-20240405
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1261466960; Fri, 05 Apr 2024 22:33:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Apr 2024 22:33:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Apr 2024 22:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFYW3i3I2Xbs+pnzS/e6t0pVswYQKmGJoEpEyjxGK9Fiu1hd/0lEoCy3QJcVBRfp/PlnulJS3VOxm+7Gunf017a/wvJp4an0YBFA1NQ2bN/f+nVo5e0IhVWcABuR1WMq2bqU4AyTdY0nbj2Sm9Qcs1zpEJs18iushAQPtFFXe+TLAi49h5Rpsig2E8YKjSBoOo+Mm6B1lHxdiYCPVpMHhCouU84zdt4/7kWpihUiQoJe3oI1nxhjMIoMvlQ0WqbYoYrZTNT/eFhvVZ6ljR+kGcP0/ijE+k3Xr50upfCaiaglYYiag5BizhltOKrI7tZ48JbPTvdWj8MiTH/VTeIVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHZP82myEQQJn32w7utLLOD+fhEQ/7FjW/ZzVr5b4sk=;
 b=jn+1yd3z5PDGdWgrCa1zcUpe+AI462NwukEZwLIr5BpwgUK+nL0JZ76nA20OXvAui6yVEHWy1Vywdl89QF1KDjyy72bPTSm6e0/Pnd+JJo3/LWpgON8HilqPFkq3ejibS92CUS/fIU9LHyVWXNR02ybPalYoOespuCa1x6Dh73ZrxSbkDIUE9VOx2PGwIEBzyqyYIZ7MQ73ORr8xc1L5DOsQo8ym7JcKb8PyoXO94GCpo0iy2Bd1H7F6ufkzh3nQwLxQ5gg2bXjFKa+pFXvYbHpS/3ku2sY+RFLGG2+gzBvZxOMY7wgohASM4CdnClKc3Kks8Oglpqg6x7q6X/gNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHZP82myEQQJn32w7utLLOD+fhEQ/7FjW/ZzVr5b4sk=;
 b=GJu8P+WvWEedh0/Eu02jsyBO48Ga4YyLTmR37PkVqB+WaH2LUOmsOVwO4jblVZ4Z8ERj/Oyc2Nv2doqxlzjFK1ANO4qJJ3dfjHKMToF8xCfi/SJfndyHhfOIWfn19kM7sfCbD93ZYxRuqiW4edW6EQKahMdo76ayR3RiAhxrrZg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6901.apcprd03.prod.outlook.com (2603:1096:101:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 14:33:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:33:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Topic: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Index: AQHahbFYn7GUjisJlUGOm/8L6IGNq7FWsNGAgADVnQCAAK2ZAIABjPeA
Date: Fri, 5 Apr 2024 14:33:14 +0000
Message-ID: <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
	 <20240403102602.32155-3-shawn.sung@mediatek.com>
	 <20240403-conflict-detest-717b4175a00c@spud>
	 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
	 <20240404-lankiness-devouring-d4d012b22cb9@spud>
In-Reply-To: <20240404-lankiness-devouring-d4d012b22cb9@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUF9ECEMioC8Phyp5omAdI9/bXoSnJl93rwnllLsE2DTwK4od5qESR2Ogb+84WGFiDdQnVEVhXenLQa52pZArs7PEZfy5p8wz8xVZcpzMbAxSb84f7n4KCYG0Zf2L86EyjtU1F6jDKM7OZdrYVGhpJfP8ch8Mxl2YzLKp7OhZSvUZaiCNZJaZePuLIGJjZoJUc7vAhP/xICNlHHGpJyfXDep3zrNG7McVC2i8yUzV2M3MLwbrBl9o8J6ofzq1f/YL1ceaw6qBxvkZi3rmuCn054qK0x4CTKtun1MEy6Rt+2ob6PCZjTS2FwIqr9Ao7PFu+ERa/axl31XP2gOQixDdE9BrCPue7ycYbBUk5OnteqxtQLO8PUK2+wPzRN458airioXBoTkBQdMiArt1vO86LxZGQyT/PrdFyIWYrnJkuM+zeZJBIAyaoIcM9+V6nXm0xOebTCxyvJraljocrP11MrSW0db446KP9NDI0lxC+C0Sokvur3uA48H/rdyhS9ptnTlnCmHP2H9irLATJYzDJQQ1vmmdTNuEqG0WFPqQG6jXgWxFme03dBZ+GlMYu1KksXXidWC6MfNXaQ9JAmTkaN6Q4ct1Io//qM4WmKSM5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am1WUFRQRUZwZ0haTHdSamQyVEVGTVZqelpJeGJETy9yZXhKMk0vZ3lCQkZS?=
 =?utf-8?B?eWZoQ0tvaG9CNFM3SVVhR3dqQndsOEVwVmFGWkNwNDhVcG9ZWnRDM2VqTFh2?=
 =?utf-8?B?VG9naklNL1B6cWhDQ3FxcnUrcmtBOVI1VlJrTUZJS1BycitnTkF5bG9vTGZS?=
 =?utf-8?B?T24vY01LbTl0RUMxeGdNWEhTL2lwSjdZK2ZvZWZwNTVyRTJMbnZUbUxXczYy?=
 =?utf-8?B?bzE0bnhqdlpwZ1ppRlg4SGFUanhNSmhYUGhsRGRaSDVGNWN4UVlEZG1LVEgx?=
 =?utf-8?B?TExTaU14ZE1Gc0RvUG85Ni9zYnFZR3dhK1JpNUFuYmh6dUhJbmd0ajRrUXBF?=
 =?utf-8?B?c0gwd1g4RTUxMTlyK3pLQjY4MDFBYmY4dWJJMjN3UHFGMWlzRmJBVmk2VHdH?=
 =?utf-8?B?ZkRLVGo2QUxHQ2hWdkg2WW5XY1hZMmg3SktPcXo2R1ZrWHR2OEU1MUVSZ3JB?=
 =?utf-8?B?cFVFeFB3R3E0c0NoWitURTNSS0ZxTUp5bWJRSXgwczRGQ0ROQkVNVGhnc2pM?=
 =?utf-8?B?enJHRkkyZUc2dUl4TlpLTlQ3VUFhbnhLMUVsLytQSTlTcHJ3d3I5NUZobHEr?=
 =?utf-8?B?NDBEZEs3M1JkQ1dUZ0FVK1g4QVBFZ0VxS1VjZlZYd0JwZGFVeUl3TGZiZTdL?=
 =?utf-8?B?Z3FBejVvVCtETHNyaEdzRWEyaVhQU21JWktMY3RFaS9KMFVKZ1VsZzRTbzNJ?=
 =?utf-8?B?MkwvV092UXZNRWRsbFRPOGwxZjFzY296MU93eXVWKzdMSVlRdVhCNFpmV3JJ?=
 =?utf-8?B?LzNTeHZyZHpuTFRKMHVQTHowd0RLY3RudEpqbUFyOFZKYjlGbmpDKzRxdHI0?=
 =?utf-8?B?UjNqNEttNGgrdzBvbENjN2tsRkduRW41NnFQdVJqSHFDUGtITzB1TkJETzA0?=
 =?utf-8?B?bE1iNFE2R3VLaDB5NE9leitrTk5lem0wVHlsTk9wQkhTZU5SY0owbGVhbzRH?=
 =?utf-8?B?Vlg4dE5LeC9Gd1lWUGRUdGpyWkxFZVlkVHZqdFpyV2VpTzdKY3dLQzVMbVhP?=
 =?utf-8?B?MXVUalJIUUR1Sm1pRksvWUJCUGptSW5HOER0RFltYUZYK3dWQTVVdWZpQ2Jk?=
 =?utf-8?B?dlFZQm5HVkRGWDl5UXF1THJ1YzBKRG00TDZnZTRNRldFUElFd0hEa1B0bVl5?=
 =?utf-8?B?dlBHb3dyWVJyUW5hck8yNHpWcEx4TlZmU2NSc2ZpemhMMEVOWmtFd1J1aDJB?=
 =?utf-8?B?UXozVy9RNHhDSTg5OWtTK0E3aVI4djBwYitrSC81SFQ1eXpVdXBYbjh5V3Zh?=
 =?utf-8?B?YStVcy9lNU5jNmhteXo0ZlRuVVoxRFJ3NFdBczRmNzlNMW5vZitTa01tdTVS?=
 =?utf-8?B?ZzQ5VEdFLzZmdy9QeTRQSUIwTnd5Y1VJZlVzeDRSTHBFcGZ5OFNZWGtGZDFo?=
 =?utf-8?B?dFQ1S0RlOEcyS0xSRmd6Vkg2cGs0Z0ZtWWNFL1Nxb1pYNFIyb0szNDhGeDF4?=
 =?utf-8?B?OVFyWWgxRnJyU0pGck1FUVNSS2d3enArTVBmTTRlWng4T0tGYkdRUkNMcE4v?=
 =?utf-8?B?R24wRU9JS2tkd3M5TlFBUnkzd0lkQU9SNkFucnhweXB3OTdNUkdqazJUR2ow?=
 =?utf-8?B?V1ZYZzdlMGE0QlF5UDBLN05LS1lLZmtOYk9MSEVtVFMvWFRaVFlOdkoyaEhX?=
 =?utf-8?B?MksyQ2lBV0JaRmZQM0VvVTB4Y0UwNFlCSUJhQkJBY1J3eEFRYnpjcjlTQnYr?=
 =?utf-8?B?QTc4SFF1enRlTVk5SitCbUtGb20rRkFQbVUxS2hoRjhjR1NPbmNhNHVhTTVk?=
 =?utf-8?B?RUZkWEZVblF1V1hyRkp0OVh2MWtxa1BBVEdHZFJVSVV2RHJRTEI0MzlyZ0xa?=
 =?utf-8?B?aDFlZmRwMW16OWp0QmsvS2l1UUdHdm1CUWFobWJuRFpua093ei9iVXExZUI2?=
 =?utf-8?B?ZVdrUndhY2M1MzFZbEV1aEFCaVV4S1R5eFRIRWorUjlRdjFlT0U4S0pKYVFq?=
 =?utf-8?B?VTFhR1R5RFZTZHJUVTNCQzVWWGh4VkJ5QWEvS0VqbVFhdlNqRkpvaXlmTkV1?=
 =?utf-8?B?djdIOGp2T21hWnZFb3VrYWt3WlpIWlhXcCtVbjdMazhQU0M1NWMwVTFDc1V1?=
 =?utf-8?B?V0ZYZjBYZGVPOEx0blROL1RHaWxnWjkyVy9ZNldFTVd0eTdiK1BaeEFpaWlz?=
 =?utf-8?B?RklJc250UlF1WGtyQUxrWDJ3QWxyWnJKMjNTNklnbzB0NjlHakZaSHY0TkFK?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB1EFB5CE5169E429042D7FCC7AD29F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefa76ec-0fed-4a56-1a06-08dc557d5411
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 14:33:14.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XY0BpDh2VXgSiOYGbefuMS5YvqKxi+BrKmPg297zxyR8aOdVIJBWyZyaxR8mr1mEExTPC6O1ki+rOACHR9sHEmPVvzx7HkuY6WYd87jYqY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6901

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDE1OjUyICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDA0LCAyMDI0IGF0IDA0OjMxOjA2QU0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBDb25vciwNCj4gPiANCj4gPiBUaGFua3MgZm9yIHRo
ZSByZXZpZXdzLg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNC0wNC0wMyBhdCAxNjo0NiArMDEwMCwg
Q29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBcHIgMDMsIDIwMjQgYXQgMDY6MjU6
NTRQTSArMDgwMCwgU2hhd24gU3VuZyB3cm90ZToNCj4gPiA+ID4gRnJvbTogIkphc29uLUpILkxp
biIgPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBBZGQgbWJv
eGVzIHRvIGRlZmluZSBhIEdDRSBsb29wcGluZyB0aHJlYWQgYXMgYSBzZWN1cmUgaXJxDQo+ID4g
PiA+IGhhbmRsZXIuDQo+ID4gPiA+IFRoaXMgcHJvcGVydHkgaXMgb25seSByZXF1aXJlZCBpZiBD
TURRIHNlY3VyZSBkcml2ZXIgaXMNCj4gPiA+ID4gc3VwcG9ydGVkLg0KPiA+ID4gPiANCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vYmluZGluZ3MvbWFpbGJveC9t
ZWRpYXRlayxnY2UtbWFpbGJveC55YW1sICAgICAgICAgfCAxMA0KPiA+ID4gPiArKysrKysrKysr
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4g
PiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiA+ID4gbWFpbGJveC55YW1sDQo+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2Nl
LQ0KPiA+ID4gPiBtYWlsYm94LnlhbWwNCj4gPiA+ID4gaW5kZXggY2VmOWQ3NjAxMzk4NS4uYzBk
ODBjYzc3MDg5OSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+ID4gPiBtYWlsYm94LnlhbWwNCj4g
PiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVk
aWF0ZWssZ2NlLQ0KPiA+ID4gPiBtYWlsYm94LnlhbWwNCj4gPiA+ID4gQEAgLTQ5LDYgKzQ5LDE2
IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgaXRlbXM6DQo+ID4gPiA+ICAgICAgICAtIGNv
bnN0OiBnY2UNCj4gPiA+ID4gIA0KPiA+ID4gPiArICBtZWRpYXRlayxnY2UtZXZlbnRzOg0KPiA+
ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgVGhlIGV2ZW50IGlkIHdoaWNo
IGlzIG1hcHBpbmcgdG8gdGhlIHNwZWNpZmljIGhhcmR3YXJlDQo+ID4gPiA+IGV2ZW50DQo+ID4g
PiA+IHNpZ25hbA0KPiA+ID4gPiArICAgICAgdG8gZ2NlLiBUaGUgZXZlbnQgaWQgaXMgZGVmaW5l
ZCBpbiB0aGUgZ2NlIGhlYWRlcg0KPiA+ID4gPiArICAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9n
Y2UvPGNoaXA+LWdjZS5oIG9mIGVhY2ggY2hpcHMuDQo+ID4gPiANCj4gPiA+IE1pc3NpbmcgYW55
IGluZm8gaGVyZSBhYm91dCB3aGVuIHRoaXMgc2hvdWxkIGJlIHVzZWQsIGhpbnQgLSB5b3UNCj4g
PiA+IGhhdmUNCj4gPiA+IGl0DQo+ID4gPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gPiAN
Cj4gPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzItYXJyYXlpDQo+ID4gPiANCj4gPiA+IFdoeSBpcyB0aGUgSUQgdXNlZCBieSB0aGUgQ01EUSBz
ZXJ2aWNlIG5vdCBmaXhlZCBmb3IgZWFjaCBTb0M/DQo+ID4gPiANCj4gPiANCj4gPiBJIGZvcmdv
dCB0byBzeW5jIHdpdGggU2hhd24gYWJvdXQgdGhpczoNCj4gPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNDAxMjQwMTE0NTkuMTIyMDQtMS1qYXNvbi0NCj4gPiBqaC5saW5AbWVkaWF0
ZWsuY29tDQo+ID4gDQo+ID4gSSdsbCBmaXggaXQgYXQgdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+
IFdoZW4gSSBzYXkgImZpeGVkIiBJIGRvbid0IG1lYW4gInRoaXMgaXMgd3JvbmcsIHBsZWFzZSBm
aXggaXQiLCBJDQo+IG1lYW4NCj4gIndoeSBpcyB0aGUgdmFsdWUgbm90IHN0YXRpYyBmb3IgYSBw
YXJ0aWN1bGFyIFNvQyIuIFRoaXMgbmVlZHMgdG8gYmUNCj4gZXhwbGFpbmVkIGluIHRoZSBwYXRj
aCAoYW5kIHRoZSBkZXNjcmlwdGlvbiBmb3IgdGhlIGV2ZW50IGhlcmUgbmVlZHMNCj4gdG8NCj4g
ZXhwbGFpbiB3aGF0IHRoZSBnY2UtbWFpbGJveCBpcyByZXNlcnZpbmcgYW4gZXZlbnQgZm9yKS4N
Cj4gDQpPaCwgSSBzZWUuIFRoYW5rcyBmb3Igbm90aWNpbmcgbWUuDQoNCldlIGRvIHdhbnQgdG8g
cmVzZXJ2ZSBhIHN0YXRpYyBldmVudCBJRCBmb3IgZ2NlLW1haWxib3ggdG8gZGlmZmVyZW50DQpT
b0NzLiBUaGVyZSBhcmUgMiBtYWlubHkgcmVhc29ucyB0byB3aHkgd2Ugc2V0IGl0IGluIERUUzoN
CjEuIFRoZXJlIGFyZSAxMDI0IGV2ZW50cyBJRHMgZm9yIEdDRSB0byB1c2UgdG8gZXhlY3V0ZSBp
bnN0cnVjdGlvbnMgaW4NCnRoZSBzcGVjaWZpYyBldmVudCBoYXBwZW5lZC4gVGhlc2UgZXZlbnRz
IGNvdWxkIGJlIHNpZ25hbGVkIGJ5IEhXIG9yIFNXDQphbmQgdGhlaXIgdmFsdWUgd291bGQgYmUg
ZGlmZmVyZW50IGluIGRpZmZlcmVudCBTb0MgYmVjYXVzZSBvZiBIVyBldmVudA0KSURzIGRpc3Ry
aWJ1dGlvbiByYW5nZSBmcm9tIDAgdG8gMTAyMy4NCklmIHdlIHNldCBhIHN0YXRpYyBldmVudCBJ
RDogODU1IGZvciBtdDgxODgsIGl0IG1pZ2h0IGJlIGNvbmZsaWN0IHRoZQ0KZXZlbnQgSUQgb3Jp
Z2luYWwgc2V0IGluIG10ODE5NS4NCg0KMi4gSWYgd2UgZGVmaW5lZCB0aGUgZXZlbnQgSUQgaW4g
RFRTLCB3ZSBtaWdodCBrbm93IGhvdyBtYW55IFNXIG9yIEhXDQpldmVudCBJRHMgYXJlIHVzZWQu
DQpJZiBzb21lb25lIHdhbnRzIHRvIHVzZSBhIG5ldyBldmVudCBJRCBmb3IgYSBuZXcgZmVhdHVy
ZSwgdGhleSBjb3VsZA0KZmluZCBvdXQgdGhlIHVzZWQgZXZlbnQgSURzIGluIERUUyBlYXNpbHkg
YW5kIGF2b2lkIHRoZSBldmVudCBJRA0KY29uZmxpY3RpbmcuDQoNClRoZSByZWFzb24gd2h5IHdl
IGRlZmluZSBhIGV2ZW50IElEIGlzIHdlIHdhbnQgdG8gZ2V0IGEgU1cgc2lnbmFsIGZyb20NCnNl
Y3VyZSB3b3JsZC4gV2UgZGVzaWduIGEgR0NFIGxvb3BpbmcgdGhyZWFkIGluIGdjZS1tYWlsYm94
IGRyaXZlciB0bw0Kd2FpdCBmb3IgdGhlIEdDRSBleGVjdXRlIGRvbmUgZXZlbnQgZm9yIGVhY2gg
Y21kcSBzZWN1cmUgcGFja2V0cyBmcm9tDQpzZWN1cmUgd29ybGQuDQoNClJlZ2FyZHMsDQpKYXNv
bi1KSC5MaW4NCg0KPiBUaGFua3MsDQo+IENvbm9yLg0K

