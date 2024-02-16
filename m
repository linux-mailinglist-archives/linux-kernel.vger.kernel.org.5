Return-Path: <linux-kernel+bounces-67971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C28573C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604D91F21D79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE4F4E2;
	Fri, 16 Feb 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IY6Gn8t4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Pgeuk+Gb"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE53DF4E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049830; cv=fail; b=jBTGrWTynbwfvfav3X9mWmn/imXEw33sCVy1/TTrkWnBqw4HLnyYdKGJTsRs8gKL76cYbjy8bdaN3ZDSe/fKzWzlOKgRWpCotX58PTXAQeUYyoMqlSdQCO0OpRsFIka+4/n5RUazG7R7GYDlDphl6IhPxqFdCZW3/BIq6v0ovkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049830; c=relaxed/simple;
	bh=Qpxb6hlI21+yGVEYcu1Q4tqzGTbfzy6RztKOHM56AEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5NRlv2ylZZeT6bnoV4TJsivK6HPI6gX4f2CxhdwKjduFSYx9CsfpONTIVk3N+/g1FNGVsYSZok6TmeTX8JhCzdhSSu6oHlvWak7BWOIyX9HuQ+tRBANOPe/aCS7RiV1ccLeboG2G5rRDJcswrcNKtDhsQoMefWnml7Z4L3jQZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IY6Gn8t4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Pgeuk+Gb; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 79366ff8cc7111ee9e680517dc993faa-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qpxb6hlI21+yGVEYcu1Q4tqzGTbfzy6RztKOHM56AEc=;
	b=IY6Gn8t4qt2jiNNE4xy9GhQLsI/9lzmxfG2UYVaeHvJyQoqpRA7hxiKHPbUZS1YQFauknW8Xam9cVxg/6E3hOkbUp1b9aZnKLYsr8+GW/qtajzGfJKNhvzCMXfVcI60gsiAq2DEHgUNsLCY4g361tefxN6Jzcg812Zz1kkDBBjk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a1e05761-c1a9-4f71-acba-af7f08719b93,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:98e7578f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 79366ff8cc7111ee9e680517dc993faa-20240216
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 282784102; Fri, 16 Feb 2024 10:17:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 10:17:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 10:17:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmzK/9kZovbXdKdSPJDiCVooTnVarqBJdJ/cOleUQ3OXleIiNI3+eQYhojNX0fui6x9PHOI5SelEqapkS95B/siHAZWSGC8PDN9FyCFFzWa7VN5DcCMhgbFGBe6fwMTlQ+p98xT9LH0HUqa1PyxxdMkIGR6bNtKVLry9qxW9KFmOv/wTJB+yObTO5TyCjcg6tudVfPfMr03uEd8pGFeouOZf6i2J0Lfq4o1aR3OOtv69zdxUNwyzjJtJibQw+4+02sbVqj9JRkLBgmb4UxDlJ3L2eyhU//FAV8RhX4t/JJP7d/EdGCFdhmh7eoqR51vTVX9BUdZuE/nKqEjQg3CBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpxb6hlI21+yGVEYcu1Q4tqzGTbfzy6RztKOHM56AEc=;
 b=XCPxsf07ODzJequLVmaQgzKF/JL19e5m2G77yTiJ5XbQOZuPbo8/j3Lugf8vVhbTfKFYM9HJOP0oRPlR+dUu6K9IuzgJLEqsxcDPly8WPAi/7Jf5pLSCLRdo8F6hDPkgmgzEA+QVrz+qwFXA/CkdvIIPgmHrhDmkOEmvJAuc3We/fri+J3sZ/jMGnBHd2dCm6O7trwoccHGVtFiyhWb/ddojfYeipUpLtqDhubAmWGI3xAreh9774FZvUDCE7jenHwDjhvSYy5HcFczEnASIR8ERS9b7VhkeYxQF3Yv/HZVJzlhluNpJYp3boKGiW9uBdEft0SkCFnUn6n8BGIpWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpxb6hlI21+yGVEYcu1Q4tqzGTbfzy6RztKOHM56AEc=;
 b=Pgeuk+Gb3Xd8jlvgHFtCUTERsqi7TRlTB349AvRpP5Aaxrsf9KUpHjLB+6wlOnZWAVom+aSIKe17D41AIiKHF0rr7/TAmmQJLeSwtW3Mhikda/QsJrtQaIK6x9w4/ZDVRW6ma4qK6w/9J5OUYqTARmMpMV7Nbhr895fTp+7dLN4=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TY0PR03MB6533.apcprd03.prod.outlook.com (2603:1096:400:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 02:16:58 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 02:16:58 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Topic: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Index: AQHaX/dpb4xX9vYSDEyAoA9XDt3r1rELPigAgAD+WAA=
Date: Fri, 16 Feb 2024 02:16:58 +0000
Message-ID: <56eec57c795bdea59baac3ad3d25e015d4c596c3.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-11-shawn.sung@mediatek.com>
	 <44529502-250b-4c8a-94c3-2c481d1385cf@collabora.com>
In-Reply-To: <44529502-250b-4c8a-94c3-2c481d1385cf@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TY0PR03MB6533:EE_
x-ms-office365-filtering-correlation-id: 7f548a8b-034a-4b8e-33b4-08dc2e955ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mb5OP1D3QVCOHKHktG4lI8mJm/qta7+ZuekL+72B/mQd2rykfUS/J7tajmtL4IGvMQDO3zNz5k1psRMEew7CuR7H7B24hDF9Tv2bUeDu/4IzEvRXouDgV8zwU6GrK6bhpablVb2Gp0OraP5IgmrE9wslhrHDK4y2gJFLByZgfnvWK9cIhgmzAc0wBgrDIzdmvGbh1jtP+2qlPkoxvekXlcZVxAhBbR7m3b74KrHFYN0OYO+rxvHiyYlnp4Dmk4d4eurHP/Q9KgIY+iQHDiuwgVSuEyosXrxJrHA8iKccZEF6FKk6CMSwZwP3wI51ot0gtVbBaQm39fJ2/a2CAuJNfMrAjewASg8GlbrR5vbu0LodZEvT3L7T13CjLhw5N/vr0VcJsn3XCsEcJD1YM1Nqx1dol+G9I9PtXjSBGIUki+Qh8OUZppTmrQ7cMkGCHdThHd/2gmTj6mL+aPjlCsQwMnem5RoohsEyEay8Pf7AzCCgfUEyri9xJPreUh2y57SBjudy32cci7+p+LOkpi5xijb58QRcEHSirpz+nKjQ/aH51GkImEDjK46F2LcUpPAOUEGM75wpXkm7tKpzyBFR59bbXujdQl0g0+ghf0GyuBMFX5Bwgadf6PQl1hEMZSp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(8676002)(8936002)(4326008)(7416002)(5660300002)(83380400001)(2616005)(26005)(122000001)(36756003)(38100700002)(85182001)(86362001)(38070700009)(66946007)(66556008)(76116006)(54906003)(316002)(64756008)(66446008)(110136005)(66476007)(6506007)(6512007)(478600001)(6486002)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJHcENMZERtL0JEMHQ0S0toaUM3WGV2SkNweGxYeWJzcU9IRWN0UG5RTm5o?=
 =?utf-8?B?aklNWDJWSDV3Ryttc2JaUDhaZ0FCYnkxUE1STjAza3M4dkpkK2NoNVRVQytv?=
 =?utf-8?B?akpCUFlNUmJnMmlzaStVd2FjcVpJUEJMYWNMNVdtSW8vVW5meWx5Q1Ywd295?=
 =?utf-8?B?KzVlTjh1VlRDR2tJYURGWEw1L1hYOVNZdW1mRWQzdXNoMktMZkxVUE5lM1pu?=
 =?utf-8?B?NENUQ01wQ24wQTh0NDQ3S3c3ZEdkU0ZqMlJNK0hCRGZkOEFyNWhVQXFEeko3?=
 =?utf-8?B?SzBUeDJObGJqdlVtUVV0bi9EZUhvelVieXpZbllDNks4U3pUMGhLMDNQY0NJ?=
 =?utf-8?B?b1JUZGF0N3pKcXhNSzdmd3pNSUUrSzRhWXBLK2tkYS9Xd1B0WEVFbmcrVmwz?=
 =?utf-8?B?dGY4VDJ0UElNLzZEbnZDbzFvYmU1ak1sZFhXWjVab1ZudHdDNFRsVlJFZkRv?=
 =?utf-8?B?ZXRUL24yOUFmQXdPYng2YTlKY3RvUThVUUtHazBDdEZNcVNSQXNrVWRmQU1H?=
 =?utf-8?B?dXJVcFpQV1M3cTZWczFuRGN4UXp5MkR4WDEzV3VqY21ZR09QZ29DdVFXZC82?=
 =?utf-8?B?SlZ2MGhISzZoQnpXTzVnUC96UCt1SS9wMVNGTW05L2YwR1BOeHBNZnY3ekR6?=
 =?utf-8?B?enBkZ1ZSRFFHUlRxa2RyKzNHak5pOUw4SHdhQ3Q1TWNOY0VNbXVpbjhXR21o?=
 =?utf-8?B?Q252NWRNTEFGcmZ5U3YycFpkU1l2SGZLNndSREw0Mmk0d0RTUXRSYlgxamtZ?=
 =?utf-8?B?MmJLUnc4eExuZU1yMFhjQ0x6YnMweGRsOTdLVDd5ZTA3cTFBcFBGem44V0Zu?=
 =?utf-8?B?cDBJTndKS3JSOHNBZ3p0eXN1ZU8rR3lSTXZkZVZLVWJZcnBHci9BS29RQUYy?=
 =?utf-8?B?N21CamxwY0c1WXVienF5cUxaNDVXZGFDbldWSUhlM254TEdyamFXcllDaGVB?=
 =?utf-8?B?alNDbEh3RThFN0sxME9sakdYYzVGUGIwWkNNMld3Q1dEMXV2ZTg5cTFWaDdZ?=
 =?utf-8?B?ajZ6aVdFalZRUndCcmYxKytramRGbjdiVmFwUUxQYzVKUzJiNmUzSFNibmJs?=
 =?utf-8?B?U0UvaUxPR0RXRWdCNGpPOGZpcWVTVnM0dG5GQnE2WStFL0lNV2RlVnhLU1NP?=
 =?utf-8?B?QXdDaVg2S0lFSnNDWTV2UXhSRDh1ODE3dTNqV0hkanhrY1Z4SWhYZzlKeXh5?=
 =?utf-8?B?MElRaU12K1FoWmlOOG1XZnk3R0duWGRrUlF4SHprOUkzQVJiMFd4RHZvSUlF?=
 =?utf-8?B?RDJvYTZick9RT3BVMy8ybFJKVit3SHpJZ2NIUkFDa1Vkd3ZUWFFyVHRZY0Zo?=
 =?utf-8?B?RTdzUHpJQWZ0UzJoSlVhcUUxdmRSNzEvcDBiOUtJcjFvYjRhWWVjdHJtUU1J?=
 =?utf-8?B?aVVydnMzbHBiT2lXbkYzL3o4ZzFZR3FXSzlRT1pmZm51R244NGpHOWJOelVs?=
 =?utf-8?B?VEdRUk5pbU1iMUxvTXhpc1RQWTBaNVdJU2NWUDBnUEdueHprVzlod0VhWm05?=
 =?utf-8?B?WDFCcThWOGVncG5uM2t1SXE5cmI4VlhyUk9WNDR4RTE2MVhhTDdUTDhwVWdu?=
 =?utf-8?B?bTQwcEczRUVSQldJYjhocERxRmw4UzdhMHdITVVkZkNvMCtndi9YbUl2MXVM?=
 =?utf-8?B?TXBCT0V0OC93a25oaVlrc2doN0gvQ2pZb29HcGJob3d5cFJ1Qk1VS1dseWtp?=
 =?utf-8?B?Nmc5eVZFOVB4dVFWNXVZd1NJNjMxZmVVaXJYajg0dTdNK0N2VzlPaVd4S3FV?=
 =?utf-8?B?aUhaZWREM2l5bWFvWnJxalJ1WDFodDVJTDVZZW9DMmxuSnJsaGNNeFBiMzJC?=
 =?utf-8?B?SVpiWjVWMW5GVW5OWHNWaGR2MlQ1eGFNZ2hwc0drNFUwQjdpejNMMm40Y3Bs?=
 =?utf-8?B?ekRDUitPQWI2OXMvNGtyS3pLREpCZlJteWxXR3M2RHRYRC9rYUVPV0E5SU41?=
 =?utf-8?B?OVpzSXhxREZMR0lLVktUNkp6TFlRdEkwMENmaUFHS05Za25KV1lObWxoalJP?=
 =?utf-8?B?UlNRQlZmZWlwZlZMZTZ0dGIvMiszcUZsVHZHWWRhcHVsTi9EYzBZaHU3Tjhu?=
 =?utf-8?B?RWxmdERCSHdHd2k3Y0dEVUZiSm5DWEJmZEtXUUxwQlhGdzdZSExBR0lIVEVE?=
 =?utf-8?B?QXhSN0ZNV2tCampFWUlOVVc5dllyK0tPaVowd0ZXallWRjg5V2RkVzdjUTI2?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E477D7427617F4FAF3318AEA9717901@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f548a8b-034a-4b8e-33b4-08dc2e955ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 02:16:58.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFiMq69qVsTCMsTghAWrEmoCbMRAdyCvOdalo1vHPy6FGOz2ZLkkTWQm2fAgFZGEXroj7rlygHJioonprlfJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6533
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.228100-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU/wt
	lOVHF2NRUmsNbSHn8eCpfqpJhVojO6LCTO1UKypvQ4srjeRbxTZKPIx+MJF9o99RlPzeVuQQJWJ
	3QmcoR79RUHsj/YINIJaZO/nIoe7v7U4NkBX42MaSwdo9pBBGwI4lnIgC6UzTTDoylMQmcK+So7
	YBtVK4/OZvMxhRgyXOh+fw4x1yHCBmcP5F4hatbZ1v5WrnSRXhi/ymJ2FVg5Tfc2Xd6VJ+ysRLB
	g/IHlC9EiMeEgy/WOZLTtKDoVocJnHPBvSspzfjI0cHLI6lhgIXjpi5ffY2fywSWHxGIdT19acv
	YWZbwBNJ3EMno0ksGYdziXCvHmFESSOWVJeuO1DSBVVc2BozSnJnzNw42kCxxEHRux+uk8jpP8t
	MOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.228100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FE7AAD5ACC3C53850255C8DAB033FB27A73BF739C4C3B3CD62D855B91D6334282000:8

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTI6MDYgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxNS8wMi8yNCAxMToxMSwgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IFJlZ2lzdGVyIENSQyByZWxhdGVkIGZ1bmN0aW9uIHBv
aW50ZXJzIHRvIHN1cHBvcnQNCj4gPiBDUkMgcmV0cmlldmFsLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDIz
OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmggICAgIHwgIDM5ICsrKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgIDMgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAyODEgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IDE0Y2Y3NWZhMjE3ZjkuLjZjYjFlZDQxOWRlZTcg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4g
QEAgLTY4LDYgKzY4LDkgQEAgc3RydWN0IG10a19kcm1fY3J0YyB7DQo+ID4gICAJLyogbG9jayBm
b3IgZGlzcGxheSBoYXJkd2FyZSBhY2Nlc3MgKi8NCj4gPiAgIAlzdHJ1Y3QgbXV0ZXgJCQlod19s
b2NrOw0KPiA+ICAgCWJvb2wJCQkJY29uZmlnX3VwZGF0aW5nOw0KPiA+ICsNCj4gPiArCXN0cnVj
dCBtdGtfZGRwX2NvbXAJCSpjcmNfcHJvdmlkZXI7DQo+ID4gKwl1bnNpZ25lZCBpbnQJCQlmcmFt
ZXM7DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICBzdHJ1Y3QgbXRrX2NydGNfc3RhdGUgew0KPiA+
IEBAIC02MzUsNiArNjM4LDE0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9pcnEodm9pZCAq
ZGF0YSkNCj4gPiAgIAlzdHJ1Y3QgZHJtX2NydGMgKmNydGMgPSBkYXRhOw0KPiA+ICAgCXN0cnVj
dCBtdGtfZHJtX2NydGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ID4gICAJc3Ry
dWN0IG10a19kcm1fcHJpdmF0ZSAqcHJpdiA9IGNydGMtPmRldi0+ZGV2X3ByaXZhdGU7DQo+ID4g
KwlzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wID0gbXRrX2NydGMtPmNyY19wcm92aWRlcjsNCj4g
PiArDQo+ID4gKwkvKg0KPiA+ICsJICogY3JjIHByb3ZpZGVycyBzaG91bGQgbWFrZSBzdXJlIHRo
ZSBjcmMgaXMgYWx3YXlzIGNvcnJlY3QNCj4gPiArCSAqIGJ5IHJlc2V0dGluZyBpdCBpbiAuY3Jj
X3JlYWQoKQ0KPiA+ICsJICovDQo+ID4gKwlpZiAoY3J0Yy0+Y3JjLm9wZW5lZCkNCj4gPiArCQlj
b21wLT5mdW5jcy0+Y3JjX3JlYWQoY29tcC0+ZGV2KTsNCj4gPiAgIA0KPiA+ICAgI2lmIElTX1JF
QUNIQUJMRShDT05GSUdfTVRLX0NNRFEpDQo+ID4gICAJaWYgKCFwcml2LT5kYXRhLT5zaGFkb3df
cmVnaXN0ZXIgJiYgIW10a19jcnRjLQ0KPiA+ID5jbWRxX2NsaWVudC5jaGFuKQ0KPiA+IEBAIC02
NDYsNiArNjU3LDI0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9pcnEodm9pZCAqZGF0YSkN
Cj4gPiAgIAlpZiAoIXByaXYtPmRhdGEtPnNoYWRvd19yZWdpc3RlcikNCj4gPiAgIAkJbXRrX2Ny
dGNfZGRwX2NvbmZpZyhjcnRjLCBOVUxMKTsNCj4gPiAgICNlbmRpZg0KPiA+ICsNCj4gPiArCS8q
DQo+ID4gKwkgKiBkcm1fY3J0Y19hZGRfY3JjX2VudHJ5KCkgY291bGQgdGFrZSBtb3JlIHRoYW4g
NTBtcyB0byBmaW5pc2gNCj4gPiArCSAqIHB1dCBpdCBhdCB0aGUgZW5kIG9mIHRoZSBpc3INCj4g
PiArCSAqLw0KPiA+ICsJaWYgKGNydGMtPmNyYy5vcGVuZWQpIHsNCj4gPiArCQkvKg0KPiA+ICsJ
CSAqIHNraXAgdGhlIGZpcnN0IGNyYyBiZWNhdXNlIHRoZSBmaXJzdCBmcmFtZSBpcw0KPiA+IGNv
bmZpZ3VyZWQgYnkNCj4gPiArCQkgKiBtdGtfY3J0Y19kZHBfaHdfaW5pdCgpIHdoZW4gYXRvbWlj
IGVuYWJsZQ0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmICgrK210a19jcnRjLT5mcmFtZXMgPiAxKSB7
DQo+ID4gKwkJCWRybV9jcnRjX2FkZF9jcmNfZW50cnkoY3J0YywgdHJ1ZSwNCj4gPiArCQkJCQkg
ICAgICAgZHJtX2NydGNfdmJsYW5rX2NvdW50KGNyDQo+ID4gdGMpLA0KPiA+ICsJCQkJCSAgICAg
ICBjb21wLT5mdW5jcy0NCj4gPiA+Y3JjX2VudHJ5KGNvbXAtPmRldikpOw0KPiA+ICsJCX0NCj4g
PiArCX0gZWxzZSB7DQo+ID4gKwkJbXRrX2NydGMtPmZyYW1lcyA9IDA7DQo+ID4gKwl9DQo+ID4g
ICAJbXRrX2RybV9maW5pc2hfcGFnZV9mbGlwKG10a19jcnRjKTsNCj4gPiAgIH0NCj4gPiAgIA0K
PiA+IEBAIC03MDQsNiArNzMzLDQwIEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y191cGRhdGVf
b3V0cHV0KHN0cnVjdA0KPiA+IGRybV9jcnRjICpjcnRjLA0KPiA+ICAgCX0NCj4gPiAgIH0NCj4g
PiAgIA0KPiA+ICtzdGF0aWMgaW50IG10a19kcm1fY3J0Y19zZXRfY3JjX3NvdXJjZShzdHJ1Y3Qg
ZHJtX2NydGMgKmNydGMsDQo+ID4gY29uc3QgY2hhciAqc3JjKQ0KPiA+ICt7DQo+ID4gKwlpZiAo
c3JjICYmIHN0cmNtcChzcmMsICJhdXRvIikgIT0gMCkgew0KPiA+ICsJCURSTV9FUlJPUigiJXMo
Y3J0Yy0lZCk6IHVua25vd24gc291cmNlICclcydcbiIsDQo+ID4gKwkJCSAgX19mdW5jX18sIGRy
bV9jcnRjX2luZGV4KGNydGMpLCBzcmMpOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJ
fQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2Ry
bV9jcnRjX3ZlcmlmeV9jcmNfc291cmNlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gPiArCQkJ
CQkgIGNvbnN0IGNoYXIgKnNyYywNCj4gPiArCQkJCQkgIHNpemVfdCAqY250KQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YyA9IHRvX210a19jcnRjKGNydGMpOw0K
PiA+ICsJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRjLT5jcmNfcHJvdmlkZXI7
DQo+ID4gKw0KPiA+ICsJaWYgKCFjb21wKSB7DQo+ID4gKwkJRFJNX0VSUk9SKCIlcyhjcnRjLSVk
KTogbm8gY3JjIHByb3ZpZGVyXG4iLA0KPiA+ICsJCQkgIF9fZnVuY19fLCBkcm1fY3J0Y19pbmRl
eChjcnRjKSk7DQo+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWYgKHNyYyAmJiBzdHJjbXAoc3JjLCAiYXV0byIpICE9IDApIHsNCj4gPiArCQlEUk1fRVJST1Io
IiVzKGNydGMtJWQpOiB1bmtub3duIHNvdXJjZSAnJXMnXG4iLA0KPiA+ICsJCQkgIF9fZnVuY19f
LCBkcm1fY3J0Y19pbmRleChjcnRjKSwgc3JjKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwkqY250ID0gY29tcC0+ZnVuY3MtPmNyY19jbnQoY29tcC0+ZGV2
KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIGludCBtdGtf
ZHJtX2NydGNfcGxhbmVfY2hlY2soc3RydWN0IGRybV9jcnRjICpjcnRjLCBzdHJ1Y3QNCj4gPiBk
cm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAgCQkJICAgICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpz
dGF0ZSkNCj4gPiAgIHsNCj4gPiBAQCAtODQxLDYgKzkwNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2NydGNfZnVuY3MNCj4gPiBtdGtfY3J0Y19mdW5jcyA9IHsNCj4gPiAgIAkuYXRvbWlj
X2Rlc3Ryb3lfc3RhdGUJPSBtdGtfZHJtX2NydGNfZGVzdHJveV9zdGF0ZSwNCj4gPiAgIAkuZW5h
YmxlX3ZibGFuawkJPSBtdGtfZHJtX2NydGNfZW5hYmxlX3ZibGFuaywNCj4gPiAgIAkuZGlzYWJs
ZV92YmxhbmsJCT0gbXRrX2RybV9jcnRjX2Rpc2FibGVfdmJsYW5rLA0KPiA+ICsJLnNldF9jcmNf
c291cmNlCQk9IG10a19kcm1fY3J0Y19zZXRfY3JjX3NvdXJjZSwNCj4gPiArCS52ZXJpZnlfY3Jj
X3NvdXJjZQk9IG10a19kcm1fY3J0Y192ZXJpZnlfY3JjX3NvdXJjZSwNCj4gPiAgIH07DQo+ID4g
ICANCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2NydGNfaGVscGVyX2Z1bmNzIG10a19j
cnRjX2hlbHBlcl9mdW5jcyA9DQo+ID4gew0KPiA+IEBAIC0xMDMzLDYgKzEwOTgsMTEgQEAgaW50
IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCj4gPiAqZHJtX2RldiwNCj4g
PiAgIA0KPiA+ICAgCQkJaWYgKGNvbXAtPmZ1bmNzLT5jdG1fc2V0KQ0KPiA+ICAgCQkJCWhhc19j
dG0gPSB0cnVlOw0KPiA+ICsNCj4gPiArCQkJaWYgKGNvbXAtPmZ1bmNzLT5jcmNfY250ICYmDQo+
ID4gKwkJCSAgICBjb21wLT5mdW5jcy0+Y3JjX2VudHJ5ICYmDQo+ID4gKwkJCSAgICBjb21wLT5m
dW5jcy0+Y3JjX3JlYWQpDQo+ID4gKwkJCQltdGtfY3J0Yy0+Y3JjX3Byb3ZpZGVyID0gY29tcDsN
Cj4gPiAgIAkJfQ0KPiA+ICAgDQo+ID4gICAJCW10a19kZHBfY29tcF9yZWdpc3Rlcl92Ymxhbmtf
Y2IoY29tcCwgbXRrX2NydGNfZGRwX2lycSwNCj4gPiBAQCAtMTEzNywzICsxMjA3LDE3MiBAQCBp
bnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZQ0KPiA+ICpkcm1fZGV2LA0K
PiA+ICAgDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gKw0KPiA+ICt2b2lkIG10a19k
cm1fY3JjX2luaXQoc3RydWN0IG10a19kcm1fY3JjICpjcmMsDQo+ID4gKwkJICAgICAgY29uc3Qg
dTMyICpjcmNfb2Zmc2V0X3RhYmxlLCBzaXplX3QgY3JjX2NvdW50LA0KPiA+ICsJCSAgICAgIHUz
MiByZXNldF9vZmZzZXQsIHUzMiByZXNldF9tYXNrKQ0KPiA+ICt7DQo+ID4gKwljcmMtPm9mcyA9
IGNyY19vZmZzZXRfdGFibGU7DQo+ID4gKwljcmMtPmNudCA9IGNyY19jb3VudDsNCj4gPiArCWNy
Yy0+cnN0X29mcyA9IHJlc2V0X29mZnNldDsNCj4gPiArCWNyYy0+cnN0X21zayA9IHJlc2V0X21h
c2s7DQo+ID4gKwljcmMtPnZhID0ga2NhbGxvYyhjcmMtPmNudCwgc2l6ZW9mKCpjcmMtPnZhKSwg
R0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIWNyYy0+dmEpIHsNCj4gPiArCQlEUk1fRVJST1IoImZh
aWxlZCB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yIGNyY1xuIik7DQo+ID4gKwkJY3JjLT5jbnQgPSAw
Ow0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIG10a19kcm1fY3JjX3JlYWQoc3Ry
dWN0IG10a19kcm1fY3JjICpjcmMsIHZvaWQgX19pb21lbSAqcmVnKQ0KPiA+ICt7DQo+IA0KPiAJ
dTMyIG47IGdvZXMgaGVyZQ0KPiANCj4gPiArCWlmICghY3JjLT5jbnQgfHwgIWNyYy0+b2ZzIHx8
ICFjcmMtPnZhKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKyNpZiBJU19SRUFDSEFCTEUo
Q09ORklHX01US19DTURRKQ0KPiA+ICsJLyogc3luYyB0byBzZWUgdGhlIG1vc3QgdXAtdG8tZGF0
ZSBjb3B5IG9mIHRoZSBETUEgYnVmZmVyICovDQo+ID4gKwlkbWFfc3luY19zaW5nbGVfZm9yX2Nw
dShjcmMtPmNtZHFfY2xpZW50LmNoYW4tPm1ib3gtPmRldiwNCj4gPiArCQkJCWNyYy0+cGEsIGNy
Yy0+Y250ICogc2l6ZW9mKCpjcmMtPnZhKSwNCj4gPiArCQkJCURNQV9GUk9NX0RFVklDRSk7DQo+
ID4gKyNlbHNlDQo+ID4gKwkvKiByZWFkIGNyYyB3aXRoIGNwdSBmb3IgdGhlIHBsYXRmb3JtcyB3
aXRob3V0IGNtZHEgKi8NCj4gPiArCXsNCj4gDQo+IHRoZW4geW91IGRvbid0IG5lZWQgdGhlIGJy
YWNlcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg0KVGhlIHZhcmlhYmxlIG4gaXMg
cGxhY2VkIHdpdGhpbiB0aGUgYnJhY2VzIGJlY2F1c2Ugd2hlbiBDT05GSUdfTVRLX0NNRFENCmlz
IGRlZmluZWQsIHRoZSB2YXJpYWJsZSBpcyBub3QgYmVpbmcgdXNlZCBhbmQgY2F1c2VzIGEgYnVp
bGQgZXJyb3IuDQoNClRoaXMgaXMgYSB3b3JrYXJvdW5kIGluIG9yZGVyIHRvIGhhdmUgb25seSBv
bmUgI2lmIG1hY3JvIGluIHRoYXQNCmZ1bmN0aW9uIGZvciBhIG1vcmUgY2xlYW4gY29kZS4NCg0K
VGhhbmtzLA0KU2hhd24NCg0KDQo=

