Return-Path: <linux-kernel+bounces-67965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC38573B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9622834C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DCEEDC;
	Fri, 16 Feb 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GBHla3EL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nik2MmLp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF81D27A;
	Fri, 16 Feb 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049490; cv=fail; b=PR2sH+MX74KG9GHTwJDnl0E9YHjA7pEAsB2poP2yQMEbLkzieQk2JlP3SPjkNjmuU3sIcnN8WzrENV5z4VMywwKz9bIPCiBA2webDJuw7Uc+m2csA2u4ukTBovY5HyMj8ICw0AY3/JauKNk2/QBwXj0wPMt1FZ06GCHTNwmO79I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049490; c=relaxed/simple;
	bh=bnvtyPb14BcQNtpMeXuf446JJOEL2hh2ruSwWwixMxs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/VYYOqDJUat9eVV4yitR9HYCK4CkfxLr8xP6+WZUTzE56KdHIkRpBcHOTxTwgtn8VRW35q8QyZ1NwranquRdb/zjbrQHI45RTjIZGGmmCnVluRASwlWLyWBN36yEPSJp164ZgRLzvUNDOIO0wgflM0bCAtI6CaBtzbA0vZyELU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GBHla3EL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nik2MmLp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ad2ed440cc7011eea2298b7352fd921d-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=bnvtyPb14BcQNtpMeXuf446JJOEL2hh2ruSwWwixMxs=;
	b=GBHla3ELVSU1ixtaZKzv4rQXuAfXPkQIREChQcFb/WmCdPe5Fq5aQVZdF//wRFHA02IARBqhsoNpUuk+7Gb7hgEvTbS5ApYOzMfCX9S1BTfgZ2j0PP+SjySWPLhkFE/sbXqSjzJuEiXdzySODRnKUSjT6CWdGKBtQYF9imbeXho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6a240353-e5e2-4b20-9445-97ecb28f7594,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0ee1d5fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ad2ed440cc7011eea2298b7352fd921d-20240216
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 335966377; Fri, 16 Feb 2024 10:11:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 10:11:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 10:11:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUB0jeSVgCblvLmv78e8qm73k+mvuUF1bMfqBuVMDG0qoKxka+8ZhhHm5i1/rXcTDyOtKwfq7gq0ng8S3NfUdIUBAUs0gkKk3rQMb7U+rmj6zAC12ZVktkhSOsFrikEk7YMVl2yZUoXrz/BkYFjg3xHLPZN23h3MbmuhLGrmeUl84/m38THIoPEQ7dhjp/eVWH1BJ/n0XPS5WnRJGIHCtZAokGyotIBcezM058VLXVs2etgdvMvOP9+tS1Gxvs3OKH5+AZb9XxFxtu28Sc9ZpsIFWnCa6PX1d5ji0+4nvji2ew585ACQB2QQOBqHEeI3grG54RN+0XE9z5FpvyJZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnvtyPb14BcQNtpMeXuf446JJOEL2hh2ruSwWwixMxs=;
 b=bJWDTcegD0F+w4jUwlc6UB6htjcESVuXyCScw3V5iEDhaYzmyk/iD3HlZErUrXcTZ8zyLBMDMIlUACni+wB8b1ScIJ53K+0/8ntuU2Eq83aR+8h0E94A5NNxLnHfuyuW1RJovZJ7OSPa0kTcsR6nFegb3qVU+5RQh5hnSV9HFOXNupkn+cWVhuIP4ubdV81x19G68CJeuuoi47397rIJLFSNhQy2IJzgDa68/Kdd2X5XUnyAUGU6UvvNqJDhNT5R9GjTDS4E58HH6LRO/e6WhFjNW0xsaskn/wQ1yTSZp46EiyNUn7CPQH54G//i+X4NxTBru+OIUtYywUGzYzsGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnvtyPb14BcQNtpMeXuf446JJOEL2hh2ruSwWwixMxs=;
 b=nik2MmLpYrSFM2VC/sQpdCYBmZ04CdLoTg2widOX3vFDheryyUJLsFqUntpSATV//Ya8Oyns/LMfWrY/OXZqPPZ3eFu4K7h+o7pARpBGNLwOH7sDL2al+2pluJFI1j5xurVptUvvm6zDwSS4dqJVtP/edG/yHwD6CLRnz6GSVv8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8814.apcprd03.prod.outlook.com (2603:1096:101:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Fri, 16 Feb
 2024 02:11:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 02:11:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/9] soc: mediatek: cmdq: Remove unused helper funciton
Thread-Topic: [PATCH 1/9] soc: mediatek: cmdq: Remove unused helper funciton
Thread-Index: AQHaX6kDHuMd36PAI0ivctRW8ckBZLELN36AgAEEBoA=
Date: Fri, 16 Feb 2024 02:11:16 +0000
Message-ID: <724be11a24799e2a4a97bfb5b8f2ba0173f00141.camel@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
	 <20240215004931.3808-2-chunkuang.hu@kernel.org>
	 <c87af05e-9017-4806-88b1-7aa65f2b7070@collabora.com>
In-Reply-To: <c87af05e-9017-4806-88b1-7aa65f2b7070@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8814:EE_
x-ms-office365-filtering-correlation-id: a2b3350a-fc3b-4363-e2a5-08dc2e948ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkPDXD+TKG5YHZjWdMIzsnoS2hX1SP4ro2LDO+LjRCcbQX6SKtAdxsXU0YRD58rK5bEtvgdKh7vFWSJz+Qr8CuSpwvAlJ3PdRSRgEmyKJ0NF2/IsNDSU3lGvOSVIAErU7Or38EvKpl6G+xG+r61bCiylBmhMcRWlRnspRVQShdOjPbPdv2DsD152J41yeEwI9oamnCodUILW5Gehity7WLeo4xzPFlW6/fnqmtuWY9T0jIaTaLPHJ/HHoEGc97LLAne5GyarsyOW2TZMoAPYY+aa/fUlFWGylG1CkvfM5/ipI7sZVyai/raRjhVEOgaX+S3W5TMeoB0Vj5B6cUNvCVyUspwyp5ECj2o5PWEq7sBIRHqDKCaWltI8Nl++hWiKiSAL4/zwsl3nYKr1Up+grXpHBG1Qek5Cwc3hnFr1gyKIG9WwYICr2N55c5LawM4Gu9zHHFJvXXLIguV2XWhV6lD6HzDeH87hcRFbd15Mk6Y7EVEYEhP6oktGhCKe2Rd9TqDvnZnZCwkhOjl/V1jIAGj1CaP90qXNqLoBF1ipNq2WORpcNUyN3y28dpgKjcxhUuMg1TGI+t1GXnCcFZcHpeuMlA7JO2Xfl9w1SdpqbRnZq6tDIHXBOWpXuSnYAQca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(66946007)(66446008)(64756008)(66556008)(8676002)(8936002)(66476007)(76116006)(2906002)(83380400001)(38070700009)(38100700002)(86362001)(122000001)(85182001)(36756003)(26005)(110136005)(71200400001)(316002)(41300700001)(2616005)(478600001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZlOFpRVTBZdFNRTGU5aXN2UGtMdHdoaHQ2RjVIRW9DUm11WHBHVlN1ai9Y?=
 =?utf-8?B?WHp3MGpFSTVhVmM3N3BNYnpBRHJZcjJlTFg2cTBFMzFBc3VhemN1Z1dTUU91?=
 =?utf-8?B?M055ZVpvMDVwUExtdVZyZmpzUXdKalNWMGM0b1l4cklJQWxlTW5PMDUzNTI4?=
 =?utf-8?B?UHgwSW5DZ2V6NEIxdHA3eGpDKzBudDJvbnRWOG9iRDN4RXArR1h1VkxwQkpN?=
 =?utf-8?B?K2RPamRSWUszSGFXbFlqYjFneW1GSUQvUzRMdEp1OCtCQllqMFlzNk4vTzlI?=
 =?utf-8?B?eEJOYnhCMEVxNGVNSWRrVisyMHY3OWtmR3FoV1lGZUNvMEtWMDZSNExIcmli?=
 =?utf-8?B?VmpVVU1sUEJxekNBWDdrbktVOGsyM014MS9YS0NBalpwWE9jVVk3YTRPUlV5?=
 =?utf-8?B?VjBoZ25sOFBtd0RkdDhBSHc3L3dtZGJXL1VkR3hNbmFkUWI0RUVmOHJzVEdS?=
 =?utf-8?B?MEY0SWQvQUdCOVptUEFzdk10WmRNU1NpRDFmZGZMbTBDZUsyQjRubVhWS1k2?=
 =?utf-8?B?QzRhVFAzQmVHeG1BbXEvYzVYdkpzQlowS0RXdEIzZVovd0ZjRkVuQXcwNDFj?=
 =?utf-8?B?T25zWDFncWxUWGZ0MFdpcU5DcFpLd243bm5ua1NDWCtYZXlSSzZxWmphaGhB?=
 =?utf-8?B?VW1CMTFVM2NHdXJMQVhEa1BQT2cvTnNZUWlTSFZiamxETmFndE1BMW1HK01i?=
 =?utf-8?B?aVErcmRHWW8vTE90enJjb1FObExMTDJyeVRtUXZjUjZJbnR5VGlvSzdwc2xk?=
 =?utf-8?B?dEV1c1JNSUJNd3JKcU1EUmRXc1hkUGpKOVdMdHZDdy9WZEFPdEd2SUpFZjZM?=
 =?utf-8?B?THRLSGFzdnBqZ0FIcTBuWnhBdG9tamppaWcvV3FYczFzRFZIK2JMMGNGclp5?=
 =?utf-8?B?M3IzQmpmK01nRkc4TnNQZXI2ZzcrVnl1THZ0eFpJeVAxSExzQ0ZXR3VIZ2xT?=
 =?utf-8?B?RHUzSm56MVkwUHh1OUFDQ29xRXQ1clhmTkQwTmJJV2h0U0o5T1JBNEIzR0RW?=
 =?utf-8?B?dEFXUG1Gb1h5Z0xEUE1QTjMydHJYTE9KVEpWbnZkL21zRGJHYmtTWDY2WG8y?=
 =?utf-8?B?ci9KWGJRK2VWNDBlQzg3ZXYzK0Z0c0tyb2pXdThkYVgxcUMxOWh1eHF3Y3k0?=
 =?utf-8?B?cTFTT1BUYm9kZS9LYkhBUXhudEdaVHc1a0pEc1QyVlhWSVRjL0NjVVZCVjVK?=
 =?utf-8?B?cUNiblJnUFIxK1plaW5UdlRtVkdiRXM0cWVFZjY0QTNhQTZVUzdZL3J4Ukth?=
 =?utf-8?B?dS9YeUxvQzhwclJib3AzR2s5REpvVnJPdVNRaExHVmR6WmdHcytVcDU0eExD?=
 =?utf-8?B?Q3dnNkkyL0x1SFRLdHZUbDgzUGE2aFY2OWdOZFhOMXBtRVJZZWxjRzRINXFZ?=
 =?utf-8?B?VnVGeldBM0VSVTFISUtVODRSdjdZYzRwNzJOU3BIVU9TSTUyRUE1OHhCdFJO?=
 =?utf-8?B?RER4T1JmY2c4bTlXU0pZM3ZEVzBMeU41K2sreFl2VlA4QlBJUVBnTjNIK1Rz?=
 =?utf-8?B?NG9wWHJScTlwWHJpRTNKNEtPVlhiNEkyUnJsQjd2UG9jbjhMcVNwRVE0ckxV?=
 =?utf-8?B?ODR5bS9VMkpWUGtnYXByUHZPd3pSbGFJRjJvcHU5S3d6RWR5Nnpxa0NSbkpz?=
 =?utf-8?B?NFBjTUxpY0NLWldoUkhNM1UxcEZvREgwamdyck5uOUF0dEJQMzlPK1FoZUtY?=
 =?utf-8?B?cnFtU1ZUZzBwMjNXamIwMUduT2Y5czBPYTcwZkdjMStpTDc5R0pEMFc2clM2?=
 =?utf-8?B?TmQrR0piV0JVbkdEV2dpWjR5SHEveDYwU29Tai9yck9vWityRjZoSWkrVjVX?=
 =?utf-8?B?Q3lEMzVvRFVLR2ZTb3ByZlNJOXhUWnVoNnlldWlwdXJlbWZuSTIydFd3Sytt?=
 =?utf-8?B?ajJITmxWR2lhMjJGWjVvQTVodm5zKzhENFFqRnVqbkVlVXNwclpEcXluWXFB?=
 =?utf-8?B?T0xJY1c0clQ5YjFlU2pLRVNweERwTWdFbk1GeEV6Qko3eGFzSUhvelJjUnVK?=
 =?utf-8?B?WStlb0NVbUlnOWtuV3RmMENvWCtPYjFpeWw5cVdvVm9ScXZGbkhINExINkgx?=
 =?utf-8?B?ek9SYjhVLyt0cTBXckJjQmdmTHYvdDlwdDVQcVZJczBBSXhMd3dLMGNvV0lh?=
 =?utf-8?Q?hyvjaqm4f0BKRc4Zf7cbA3XTs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9CBDC7D3D92D4D8BB5A93B7FB2334A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b3350a-fc3b-4363-e2a5-08dc2e948ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 02:11:16.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmseptpRhBNKj3Opq8EvqdlVDhr4UHhZ0My0TdQF6zq+MfCFVK29ncIWFpGIzXwjIBWsAz+f4dwY6EtUrc2bHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8814
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.077600-8.000000
X-TMASE-MatchedRID: C/snMIRQLS0NtKv7cnNXnSa1MaKuob8PofZV/2Xa0cIVgNy0ftNF+2yd
	bY7xfgXYlZVh9HPz1DignyTitAW3LaGsq9dfniq5kPoFsM336M5Cs7hdHoFFAyzt4/lw8JZDR05
	HQqBvtpdsl89sGhfIw8bkszVqfsDfUjeY/xoLQ8EmZusHWPhfCiQqzcugG1CVMd+V0iXHKSUa0t
	0gVPb2SASkpFq6SQC1DMsOoTK7WFA0Z9sXcK7F6XlMlWV+Ir67YoHH/gi0K9th2fnHe1cilxFxR
	5JQAS6O46Vw6gT3GO1qpLteFSdOcRF4l1oN/bmO58dk5sbwmyjt/okBLaEo+E4K0IMk2m3GCGLK
	c455kYoJlz0YDvV4K7T3HaLgNwGewW0i719Lv57r/EBmiNuXtyGlZBSK0BYbRQ0dAChl/lywoW8
	logP/FDyK8WRp1qJNz8qCqYCx0xZ8XbDftE7Is54CIKY/Hg3AwWulRtvvYxTUHQeTVDUrIke0Gx
	/n9RcltVC7UY1n6yI7AFczfjr/7LuX5Z3gK6aVoARXpEh3WYwwg51S9BD8VoBnXkjUA0P/G+ExM
	EY6Zvs=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.077600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1847B2E62BF08B84896B63E2E761BD7EC9A99F02262841A19F5642B6292FBAC62000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDExOjQwICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTUvMDIvMjQgMDE6NDksIENodW4tS3Vh
bmcgSHUgaGEgc2NyaXR0bzoNCj4gPiBjbWRxX3BrdF9jcmVhdGUoKSwgY21kcV9wa3RfZGVzdHJv
eSgpLCBhbmQgY21kcV9wa3RfZmx1c2hfYXN5bmMoKQ0KPiA+IGFyZSBub3QgdXNlZCBieSBhbGwg
Y2xpZW50IGRyaXZlcnMgKE1lZGlhVGVrIGRybSBkcml2ZXIgYW5kDQo+ID4gTWVkaWFUZWsgbWRw
MyBkcml2ZXIpLA0KPiA+IA0KPiANCj4gSGVsbG8gQ0ssDQo+IA0KPiBXZSBjYW4gdGVjaG5pY2Fs
bHkgZm9yY2UgdGhlIGhhbmQgdG8gc2F5IHRoYXQgdGhpcyBpcyB0cnVlIC0gYnV0IG9ubHkNCj4g
YmVjYXVzZQ0KPiB0aGVzZSB0d28gZnVuY3Rpb25zIGFyZSBjb3B5LXBhc3RlZCBpbiBib3RoIG1l
ZGlhdGVrLWRybSBhbmQgTURQMw0KPiBkcml2ZXJzIHdpdGgNCj4gbm8gbWVhbmluZ2Z1bCBjaGFu
Z2VzLCBhcyBpbiwgdGhlIG9ubHkgY2hhbmdlIGlzIHRoYXQgYHBrdGAgaXMNCj4gc3VwcG9zZWQg
dG8gYmUNCj4gcHJlYWxsb2NhdGVkIGluIGJvdGggb2YgdGhlIHZhcmlhbnRzLCB3aGlsZSB0aGUg
b25lIGluIG10ay1jbWRxLQ0KPiBoZWxwZXIgYWxsb2NhdGVzDQo+IGl0IG9uIGl0cyBvd24uDQo+
IA0KPiBDb2RlIGR1cGxpY2F0aW9uIGlzIHNvbWV0aGluZyB0aGF0IHdlIHdhbnQgdG8gYXZvaWQs
IG5vdCBzb21ldGhpbmcNCj4gdGhhdCB3ZSB3YW50DQo+IHRvIGVtYnJhY2U6IHJlbW92aW5nIHRo
b3NlIGZ1bmN0aW9ucyBmcm9tIGNtZHEtaGVscGVyIHdpdGggdGhlIHBsYW4NCj4gdG8ga2VlcA0K
PiBkdXBsaWNhdGluZyB0aGVtIGluIGVhY2ggTWVkaWFUZWsgZHJpdmVyIHRoYXQgdXNlcyBDTURR
IHBhY2tldHMgaXMNCj4gcGxhaW4gd3JvbmcuDQo+IA0KPiBUaGlzIC0gZXNwZWNpYWxseSBiZWNh
dXNlIEknbSBzdXJlIHRoYXQgd2Ugd2lsbCBzZWUgeWV0IGFub3RoZXIgY29weS0NCj4gcGFzdGUg
b2YNCj4gdGhvc2UgdHdvIGZ1bmN0aW9ucyBpbiBhIGZ1dHVyZSBJU1AgZHJpdmVyLCBicmluZ2lu
ZyB0aGUgZHVwbGljYXRpb24NCj4gY291bnQgdG8NCj4gMyAob3IgYWN0dWFsbHksIDMgYnkgMiBm
dW5jdGlvbnMgPSA2IHRpbWVzKS4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCByZW1vdmluZyB0
aGUgY21kcV9wa3RfZmx1c2hfYXN5bmMoKSBmdW5jdGlvbiBpcw0KPiBzb21ldGhpbmcNCj4gdGhh
dCBJICpkbyogc3VwcG9ydCwgYXMgaXQncyBvbmx5IGRvaW5nIHR3byBzaW1wbGUgY2FsbHMgdGhh
dCBhcmUgbm90DQo+IGV2ZW4NCj4gc3BlY2lmaWMgdG8gY21kcSwgYnV0IG1vcmUgbGlrZSAiZ2Vu
ZXJpYyBzdHVmZiIuDQo+IA0KPiBJbiBzaG9ydCwgYXMgaXQgaXMgcmlnaHQgbm93LCB0aGlzIGlz
IGEgTkFDSyAtIGJ1dCBpZiB5b3UgY2hhbmdlIHRoaXMNCj4gY29tbWl0IHRvDQo+IHJlbW92ZSBv
bmx5IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgSSB3b3VsZCBhZ3JlZS4NCj4gDQo+IFRoZSByaWdo
dCB0aGluZyB0byBkbyBpcyB0byByZW1vdmUgdGhlIGR1cGxpY2F0ZWQgZnVuY3Rpb25zOg0KPiAg
IC0gbXRrX2RybV9jbWRxX3BrdF9jcmVhdGUoKQ0KPiAgIC0gbXRrX2RybV9jbWRxX3BrdF9kZXN0
cm95KCkNCj4gICAtIG1kcF9jbWRxX3BrdF9jcmVhdGUoKQ0KPiAgIC0gbWRwX2NtZHFfcGt0X2Rl
c3Ryb3koKQ0KPiANCj4gLi4uYW5kIG1pZ3JhdGUgYm90aCBkcml2ZXJzIHRvIHVzZSB0aGUgY29t
bW9uIGNtZHEgaGVscGVyIGNvZGUNCj4gaW5zdGVhLCBidXQgdGhhdCdzDQo+IHNvbWV0aGluZyB0
aGF0IGNhbiBjb21lIGxhdGVyLg0KPiANCj4gRm9yIG5vdywgeW91IGNhbiBzaW1wbHkgcGVyZm9y
bSB0aGUgLT5jbCByZW1vdmFsIG9uIGFsbCBkdXBsaWNhdGVkDQo+IGZ1bmN0aW9ucywgdGhlbg0K
PiB3ZSBjYW4gbWlncmF0ZSB0aGVtIGFsbCB0byB0aGUgY29tbW9uIGhlbHBlciwgcmVtb3Zpbmcg
ZHVwbGljYXRpb24NCj4gYWxsIGFsb25nLg0KDQpPSywgSSB3b3VsZCByZWZpbmUgY21kcV9wa3Rf
Y3JlYXRlKCkvY21kcV9wa3RfZGVzdHJveSgpIGFuZCBsZXQgY2xpZW50DQpkcml2ZXIgdXNlIHRo
ZXNlIGNvbW1vbiBmdW5jdGlvbnMuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBSZWdhcmRzLA0K
PiBBbmdlbG8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5n
Lmh1QGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyB8IDU5IC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLS0tLS0tDQo+ID4g
ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDQwIC0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDk5IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBiMGNk
MDcxYzQ3MTkuLjY3ZTE3OTc0ZDFlNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTEwNSw1MCArMTA1LDYgQEAgdm9pZCBjbWRxX21ib3hf
ZGVzdHJveShzdHJ1Y3QgY21kcV9jbGllbnQNCj4gPiAqY2xpZW50KQ0KPiA+ICAgfQ0KPiA+ICAg
RVhQT1JUX1NZTUJPTChjbWRxX21ib3hfZGVzdHJveSk7DQo+ID4gICANCj4gPiAtc3RydWN0IGNt
ZHFfcGt0ICpjbWRxX3BrdF9jcmVhdGUoc3RydWN0IGNtZHFfY2xpZW50ICpjbGllbnQsDQo+ID4g
c2l6ZV90IHNpemUpDQo+ID4gLXsNCj4gPiAtCXN0cnVjdCBjbWRxX3BrdCAqcGt0Ow0KPiA+IC0J
c3RydWN0IGRldmljZSAqZGV2Ow0KPiA+IC0JZG1hX2FkZHJfdCBkbWFfYWRkcjsNCj4gPiAtDQo+
ID4gLQlwa3QgPSBremFsbG9jKHNpemVvZigqcGt0KSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQlpZiAo
IXBrdCkNCj4gPiAtCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiAtCXBrdC0+dmFfYmFz
ZSA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQlpZiAoIXBrdC0+dmFfYmFzZSkg
ew0KPiA+IC0JCWtmcmVlKHBrdCk7DQo+ID4gLQkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+
ID4gLQl9DQo+ID4gLQlwa3QtPmJ1Zl9zaXplID0gc2l6ZTsNCj4gPiAtCXBrdC0+Y2wgPSAodm9p
ZCAqKWNsaWVudDsNCj4gPiAtDQo+ID4gLQlkZXYgPSBjbGllbnQtPmNoYW4tPm1ib3gtPmRldjsN
Cj4gPiAtCWRtYV9hZGRyID0gZG1hX21hcF9zaW5nbGUoZGV2LCBwa3QtPnZhX2Jhc2UsIHBrdC0+
YnVmX3NpemUsDQo+ID4gLQkJCQkgIERNQV9UT19ERVZJQ0UpOw0KPiA+IC0JaWYgKGRtYV9tYXBw
aW5nX2Vycm9yKGRldiwgZG1hX2FkZHIpKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJkbWEgbWFw
IGZhaWxlZCwgc2l6ZT0ldVxuIiwNCj4gPiAodTMyKSh1NjQpc2l6ZSk7DQo+ID4gLQkJa2ZyZWUo
cGt0LT52YV9iYXNlKTsNCj4gPiAtCQlrZnJlZShwa3QpOw0KPiA+IC0JCXJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCXBrdC0+cGFfYmFzZSA9IGRtYV9hZGRy
Ow0KPiA+IC0NCj4gPiAtCXJldHVybiBwa3Q7DQo+ID4gLX0NCj4gPiAtRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF9jcmVhdGUpOw0KPiA+IC0NCj4gPiAtdm9pZCBjbWRxX3BrdF9kZXN0cm95KHN0cnVj
dCBjbWRxX3BrdCAqcGt0KQ0KPiA+IC17DQo+ID4gLQlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsaWVu
dCA9IChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsOw0KPiA+IC0NCj4gPiAtCWRtYV91bm1h
cF9zaW5nbGUoY2xpZW50LT5jaGFuLT5tYm94LT5kZXYsIHBrdC0+cGFfYmFzZSwgcGt0LQ0KPiA+
ID5idWZfc2l6ZSwNCj4gPiAtCQkJIERNQV9UT19ERVZJQ0UpOw0KPiA+IC0Ja2ZyZWUocGt0LT52
YV9iYXNlKTsNCj4gPiAtCWtmcmVlKHBrdCk7DQo+ID4gLX0NCj4gPiAtRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF9kZXN0cm95KTsNCj4gPiAtDQo+ID4gICBzdGF0aWMgaW50IGNtZHFfcGt0X2FwcGVu
ZF9jb21tYW5kKHN0cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+ICAgCQkJCSAgIHN0cnVjdCBjbWRx
X2luc3RydWN0aW9uIGluc3QpDQo+ID4gICB7DQo+ID4gQEAgLTQyNiwxOSArMzgyLDQgQEAgaW50
IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICAgfQ0KPiA+ICAg
RVhQT1JUX1NZTUJPTChjbWRxX3BrdF9maW5hbGl6ZSk7DQo+ID4gICANCj4gPiAtaW50IGNtZHFf
cGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+IC17DQo+ID4gLQlpbnQg
ZXJyOw0KPiA+IC0Jc3RydWN0IGNtZHFfY2xpZW50ICpjbGllbnQgPSAoc3RydWN0IGNtZHFfY2xp
ZW50ICopcGt0LT5jbDsNCj4gPiAtDQo+ID4gLQllcnIgPSBtYm94X3NlbmRfbWVzc2FnZShjbGll
bnQtPmNoYW4sIHBrdCk7DQo+ID4gLQlpZiAoZXJyIDwgMCkNCj4gPiAtCQlyZXR1cm4gZXJyOw0K
PiA+IC0JLyogV2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQgaW1tZWRpYXRlbHksIHNvIGp1c3QgY2Fs
bCB0eGRvbmUuICovDQo+ID4gLQltYm94X2NsaWVudF90eGRvbmUoY2xpZW50LT5jaGFuLCAwKTsN
Cj4gPiAtDQo+ID4gLQlyZXR1cm4gMDsNCj4gPiAtfQ0KPiA+IC1FWFBPUlRfU1lNQk9MKGNtZHFf
cGt0X2ZsdXNoX2FzeW5jKTsNCj4gPiAtDQo+ID4gICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgN
Cj4gPiBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA2
NDk5NTVkMmNmNWMuLjZjNDJkODE3ZDM2OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC01OSwyMSArNTksNiBAQCBzdHJ1Y3QgY21kcV9jbGll
bnQgKmNtZHFfbWJveF9jcmVhdGUoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYsIGludCBpbmRleCk7
DQo+ID4gICAgKi8NCj4gPiAgIHZvaWQgY21kcV9tYm94X2Rlc3Ryb3koc3RydWN0IGNtZHFfY2xp
ZW50ICpjbGllbnQpOw0KPiA+ICAgDQo+ID4gLS8qKg0KPiA+IC0gKiBjbWRxX3BrdF9jcmVhdGUo
KSAtIGNyZWF0ZSBhIENNRFEgcGFja2V0DQo+ID4gLSAqIEBjbGllbnQ6CXRoZSBDTURRIG1haWxi
b3ggY2xpZW50DQo+ID4gLSAqIEBzaXplOglyZXF1aXJlZCBDTURRIGJ1ZmZlciBzaXplDQo+ID4g
LSAqDQo+ID4gLSAqIFJldHVybjogQ01EUSBwYWNrZXQgcG9pbnRlcg0KPiA+IC0gKi8NCj4gPiAt
c3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdF9jcmVhdGUoc3RydWN0IGNtZHFfY2xpZW50ICpjbGll
bnQsDQo+ID4gc2l6ZV90IHNpemUpOw0KPiA+IC0NCj4gPiAtLyoqDQo+ID4gLSAqIGNtZHFfcGt0
X2Rlc3Ryb3koKSAtIGRlc3Ryb3kgdGhlIENNRFEgcGFja2V0DQo+ID4gLSAqIEBwa3Q6CXRoZSBD
TURRIHBhY2tldA0KPiA+IC0gKi8NCj4gPiAtdm9pZCBjbWRxX3BrdF9kZXN0cm95KHN0cnVjdCBj
bWRxX3BrdCAqcGt0KTsNCj4gPiAtDQo+ID4gICAvKioNCj4gPiAgICAqIGNtZHFfcGt0X3dyaXRl
KCkgLSBhcHBlbmQgd3JpdGUgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICAqIEBw
a3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+IEBAIC0yNjYsMTkgKzI1MSw2IEBAIGludCBjbWRxX3Br
dF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+IGRtYV9hZGRyX3QgYWRkcik7DQo+ID4g
ICAgKi8NCj4gPiAgIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7
DQo+ID4gICANCj4gPiAtLyoqDQo+ID4gLSAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmln
Z2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZQ0KPiA+IHRoZSBDTURRDQo+ID4gLSAq
ICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5k
IG9mDQo+ID4gZG9uZSBwYWNrZXQNCj4gPiAtICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4g
LSAqDQo+ID4gLSAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBp
cyByZXR1cm5lZA0KPiA+IC0gKg0KPiA+IC0gKiBUcmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3Vz
bHkgZXhlY3V0ZSB0aGUgQ01EUSBwYWNrZXQgYW5kIGNhbGwNCj4gPiBiYWNrDQo+ID4gLSAqIGF0
IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQuIE5vdGUgdGhhdCB0aGlzIGlzIGFuIEFTWU5DIGZ1bmN0
aW9uLg0KPiA+IFdoZW4gdGhlDQo+ID4gLSAqIGZ1bmN0aW9uIHJldHVybmVkLCBpdCBtYXkgb3Ig
bWF5IG5vdCBiZSBmaW5pc2hlZC4NCj4gPiAtICovDQo+ID4gLWludCBjbWRxX3BrdF9mbHVzaF9h
c3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7DQo+ID4gLQ0KPiA+ICAgI2Vsc2UgLyogSVNfRU5B
QkxFRChDT05GSUdfTVRLX0NNRFEpICovDQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50
IGNtZHFfZGV2X2dldF9jbGllbnRfcmVnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBAQCAtMjk0
LDEzICsyNjYsNiBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBjbWRxX2NsaWVudA0KPiA+ICpjbWRx
X21ib3hfY3JlYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGluZGV4DQo+ID4gICANCj4gPiAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBjbWRxX21ib3hfZGVzdHJveShzdHJ1Y3QgY21kcV9jbGllbnQg
KmNsaWVudCkNCj4gPiB7IH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgaW5saW5lICBzdHJ1Y3QgY21k
cV9wa3QgKmNtZHFfcGt0X2NyZWF0ZShzdHJ1Y3QgY21kcV9jbGllbnQNCj4gPiAqY2xpZW50LCBz
aXplX3Qgc2l6ZSkNCj4gPiAtew0KPiA+IC0JcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4g
LX0NCj4gPiAtDQo+ID4gLXN0YXRpYyBpbmxpbmUgdm9pZCBjbWRxX3BrdF9kZXN0cm95KHN0cnVj
dCBjbWRxX3BrdCAqcGt0KSB7IH0NCj4gPiAtDQo+ID4gICBzdGF0aWMgaW5saW5lIGludCBjbWRx
X3BrdF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+IHUxNiBvZmZz
ZXQsIHUzMiB2YWx1ZSkNCj4gPiAgIHsNCj4gPiAgIAlyZXR1cm4gLUVOT0VOVDsNCj4gPiBAQCAt
Mzg0LDExICszNDksNiBAQCBzdGF0aWMgaW5saW5lIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1
Y3QNCj4gPiBjbWRxX3BrdCAqcGt0KQ0KPiA+ICAgCXJldHVybiAtRUlOVkFMOw0KPiA+ICAgfQ0K
PiA+ICAgDQo+ID4gLXN0YXRpYyBpbmxpbmUgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVj
dCBjbWRxX3BrdCAqcGt0KQ0KPiA+IC17DQo+ID4gLQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAtfQ0K
PiA+IC0NCj4gPiAgICNlbmRpZiAvKiBJU19FTkFCTEVEKENPTkZJR19NVEtfQ01EUSkgKi8NCj4g
PiAgIA0KPiA+ICAgI2VuZGlmCS8qIF9fTVRLX0NNRFFfSF9fICovDQo+IA0KPiANCg==

