Return-Path: <linux-kernel+bounces-24218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DB82B93D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8991F232CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682B1399;
	Fri, 12 Jan 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oLRbIr1Y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UE7J/rBe"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14901EA6;
	Fri, 12 Jan 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bf910bb6b0ec11eea2298b7352fd921d-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7alT9VPprqD92vSNfjfh3mVnOm44hZ5NuG7kv2KaNlU=;
	b=oLRbIr1YcWXK9WFia26EF/6snfCLk7oHs9aDRkOa1UGv/o98HxTa1a/yT06sFejywwa4QiYDW5kF9fo2hD3EkdnuUgqk3kZH0kWvwRx9j/jGH4OCkLGZxFyAz9g53VyNGdBQ4LcuPuJIMpPwy673eo5Lo0dW9QxsbK4LoLiByKA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c0003981-495f-43d6-84d7-6fcc1ab8bb23,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:647c298e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bf910bb6b0ec11eea2298b7352fd921d-20240112
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 9469205; Fri, 12 Jan 2024 09:48:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 09:48:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 09:48:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg3XL9ZGQIZpmqeNc8ueA7g7NeGEdRh6NFdis6E2roG4Tr5CzIDRMef6foEi0ZkMwACvWv75IJbkqpKNUftNTeNOQz41PB1h1V1gLLjcVw9l/ai6bW/Y3ArJzqdk1zYLjyGjM+DJrj78dFtVspTESCWhmOMoD6LzR8ItuPoN0IZGsFXMpraYNwGVxGeUZMyPZ5fHy5URmchvBKYIX+y6A+LCwnwjLS/BAGfzEN//+rW1UyzwA1GkxOpDInvEjHBE+V7e8GsxHMa9OSDUyeVSZcIHHDe6aGZVmyfEEcFojBQ2G6Z+z0OqsBIhEmY9XkmpLotdL41oOIQ0l+8cI7HArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7alT9VPprqD92vSNfjfh3mVnOm44hZ5NuG7kv2KaNlU=;
 b=XCrG7ebz2BOfOdGIhCjza25wc8ZW3CvpO1EKIRHgysIcxXlmoEvPxNvYHodJNro3Gf9o2vNEoS4JOSopp5zlmNxhjRMBauPzh9gOlTfK6P4TfSNINJIAj45Xu1CykCjjK2q+pZqbVjt0YzoE2rSKwUnU3jIcCzQUd3zJNolTTUJ2ffqTZjI9WznBGF4UJY1b+gkV/GzQTA65c/MJbiL2BKA/dqVuLaKUOSMZeCHX0UIyWKVi0RP2dQxVgM3iNZ6cAhpV8mSWLkRShtIJ0FPoBx9gLjZvIAL++BewPJCcu7v8XXH5BhdFxN8sD8qYlW2B6kMEH3g+kBXEtLOJ4zQPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7alT9VPprqD92vSNfjfh3mVnOm44hZ5NuG7kv2KaNlU=;
 b=UE7J/rBeredc0Btv+rQU9Z+nFGFfUUI+gSTUwJeduGx70qtmgIEeJ6EY/4nJiPpFKLin2kq0r9gxc4u8g4UNU/2PPIO3Dw3xlTGLQhMWvoZkKCvpp/6hSdj/AUT6ZciM1Wlv4JyiT7AV0ZAAt/SahiKmWZqIjS7DafNzytwUlPk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6991.apcprd03.prod.outlook.com (2603:1096:101:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 01:48:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 01:48:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLDVa1gA
Date: Fri, 12 Jan 2024 01:48:49 +0000
Message-ID: <f821ede01547956809576a159476e7ac33b2dd47.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6991:EE_
x-ms-office365-filtering-correlation-id: a453ca98-5d82-4737-4013-08dc13109f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuRWb3XJ0RJ6WABSxLdCGsYtejYRPD+H+Bz5hY70alUJLE1uddZcYd+cpG3MeYnE6kW0sx9yfD0nsctqUy++nbesqOVYrh0ikZDT8dn7SkmmQ09VT5pJRtMU/8GhFMxksm8JinipQT2tCXSHK/tBPlsDpz9+Ks2WhmQa0cA9frMtAEBJgJvTnDRK0CHocjof06YbrjL48qJyu+5oM/xVwv9JaeP8ZOQHXYa9rJRjQ/yQooJbkUfWipW700hnj9ZcI5UQFryNuL879iZ48LaRIQfkDcueT7hvv0T2VOgYAUk4Oe4HRpUOqundUElI6r5gXEOazVgBiTwS2ex63p9UroahjwbBsmgBN+Z5nWqbVgidcmCRSKu/y4B2kHJmNWODey4dHvtQ3WmTQBETcYzV1VleoQe3SXo9d0rObov1am7VY6advxmEMmhb5oCYz0i7x5HGO2sIbFXIQkJPq80diNdFI/x18UAHi16zSKA2Y1euF9AKXyMw8yhneYujp629NLsbeAt63/DLFism+Hxo0bUNVxD06k9Xa6u2559GjXRd6ZpeMh4reJjBk7hn6kc5BQSCbz8rEvJCMc5WKliAlNFBARRS7WccBUQluOr8PcvuJGCEHBLejWiIEk/+M3Gi07DhnGHvQdtcc3K5qsX+NuShoh9qfhvE2w+rhBwQs6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(54906003)(6506007)(6512007)(5660300002)(64756008)(66446008)(66946007)(66556008)(76116006)(66476007)(6486002)(38100700002)(8936002)(8676002)(478600001)(316002)(2906002)(71200400001)(7416002)(2616005)(6916009)(26005)(83380400001)(4326008)(122000001)(41300700001)(85182001)(36756003)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RXd0NYSzk4K3gxOHh6TUVPVWl6RTRUb1R2Qkdsd1lpdW1tSVFUczZLbnFP?=
 =?utf-8?B?NjlCNGxqd3lWc0RJVlE2QTRWb0VJSXZYelp1emZxSkp5QzVoSEpLemtCRFE1?=
 =?utf-8?B?b09MYzJuR2RvcFppeWFWMHRyeS9sYTR4eFU1YnAzT1Mvc3dNNE9WNXRxOW5U?=
 =?utf-8?B?L0IzUjNraHdLN0FQM2QyalZxenp4aVY4MzA5UlIxd3dwaWpXNlliempyVENn?=
 =?utf-8?B?Y3MwWEZ2TWNiMXJJWkZRdGttcmU1S2VkSUZYbDF3TUFZcWJaVmVpR1dLRlJV?=
 =?utf-8?B?OFg2SjM0blQxWk4wenZlQnVJdmd4YzJ1U3VGVnBYQUdwNWVacDJWMHhtTUxZ?=
 =?utf-8?B?UUZXVUN1STl5cmwzcVdnS2MvSjk2YktjVVB6OWR2M3U0RHRKUG1NNG9YTHMw?=
 =?utf-8?B?OXFGVmxpSHZJZFVwZ1BtczdSS2QrWW1DSDRYa3N4Tkx2NjAyY3p3TW4zTGNo?=
 =?utf-8?B?WmNBZXNjYVplTjV6UldPcU1Eb2duSHc3MGtMNUpqSkxNZmtpT0RpWTZpU2o0?=
 =?utf-8?B?WVVlV0NreUpiYmxqNVo3clJzWGMwNC9mdDBuWnRPZTNhZWhvdndsd2pZeTFj?=
 =?utf-8?B?S1RGOTdsS3QvazJLR3U2eVdvQlMxSFdERU8yeEZoYjhGUk1rRTBITTJra28v?=
 =?utf-8?B?U0MyeExPVFI5eWNhYmFQQlJ4ejhFbzFEWVh2dS9QVkNDSEd3NlV2VkZVS3dG?=
 =?utf-8?B?SkozbVlLQml5VWJBb3RGa3pBOEdKWHk2dzI3eDdhbkFIaFI1alFsaUtLS2Rq?=
 =?utf-8?B?YjhWcDVWclEzRUpSQUl4RndqZEFNQ0dwWThmQ09YcGpaczMvdW1sR2JmTEFo?=
 =?utf-8?B?TFF0M2lLa0F2QWR4QVc5WEFwbVVSUUhrN20rSVRKOUk0bnNyYnNLVm9KSVFX?=
 =?utf-8?B?WEQvREZuQ3A3RkFPeEhDMFVnRXpwQmpkSmpuTFFnMThLL1c4NHRVSTBnUmtN?=
 =?utf-8?B?QUd2QmNDd1dFbGxqTzFUdUJHTndpb1k1eVpobjVtR25XdWtwV0x0czAvSXRx?=
 =?utf-8?B?dHZCcmd6ME5sRmZiMVBvSHkrdFBnaXFlcmwwMTBIcjRVUnoyRE5nOWNjZDF3?=
 =?utf-8?B?N3E4d2JHMXhtUVNqRUc5UGpuU0RMd1pNNXJTZmFDdlFIUytDblY5Tm5vR1Ry?=
 =?utf-8?B?Q1labk13MzRieDQvY3o0WVNOU0NSblBsK3Yzc3A5Vkd3ekRHRmhZNGk4UlRT?=
 =?utf-8?B?UXorQjV4cTN2ai9MYVpuMXVIdnZVT3lCblJmUy9WZVpaSklGSUpQcy92ckx3?=
 =?utf-8?B?ZTdPOXpycVBjL0MvOGdNeEVMMERmQW1INVBSTFo1NFFLVk9KUm82WkQ4dGd0?=
 =?utf-8?B?RnFjYXRBYVRQekZMZUx3V0dpbHBxSnpKMk5QUFNuUXh5c3pPWjJHZ1cwajky?=
 =?utf-8?B?cG00clA1ME1NSWw4OE50T0dubno5T3dhWDU3cGQ0ZEoyQW5UYlhBV2FYNjV4?=
 =?utf-8?B?SHhORkx6WFZuRUErRlZsUVhJMlFnT1VoYUl3TktXaGgzYUphS0RJeEVEc2Rl?=
 =?utf-8?B?Nk81NEl3U3U4SGovUUNucGlhS3ZUQVBJRDE4QUYwYW5lcjlXYndyWnk1M0w2?=
 =?utf-8?B?V3ZPS0t1amNMcGdqalJOd3ExQTFUTVd3UlpmakJyME4ybnpIbWRlZlpuTm1T?=
 =?utf-8?B?SE1MaTRPaTZRNEpnODh5RWZoMEk5bVNlK0RRV3laSWNDbisyTUppQ3BsSE1u?=
 =?utf-8?B?MzhNWUlsUlpiQUJMNGJqZDhyb1RaRXB6VThwZTd3RUxLbGhva3hpVFRsUHcr?=
 =?utf-8?B?akVTM2FFSXk5SFg4WG9HQVZZNGdNVER0ZTQwQkI5UkxwOXFkajI3S00zUFIz?=
 =?utf-8?B?Q0FEa2U3N1VBRmdTTEErc0xaRVIvRU13TjluaFFJNXE0OGxBZ3ppQWE3VWN0?=
 =?utf-8?B?dVNzMklUd3hhcnFFTUx3c0w5ajhSMnkrWnJhTllvL0FEbDZvS2NTY0x3NkF3?=
 =?utf-8?B?V2I5SUZ6NkFJOTR4NFRJTFZzVTVMbExac0tZK2lTaWQ5QWtpWFZpRDdXeFlJ?=
 =?utf-8?B?SWE1elpNYm9xRUkzbS95elo3Y2c1VUZGdEEvMVhwWXRNbDJjb2k0MkVvZmVr?=
 =?utf-8?B?YjZuRGZCWGhzUVMvWkZoQ0tDeVF5LzFQSENEL0tlMkFQd0NFOXB0czBaN1BF?=
 =?utf-8?Q?iOCQH2iXLhV8GE1fnNmwxoM0i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EBD91438FE165419E6EB9F0A4F51984@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453ca98-5d82-4737-4013-08dc13109f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 01:48:49.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBCUPpTzacT6UpnfLSMzVJsivtg9KxMYXC/6BslRbPNhAswDB99S5AHoMIFFRLa0rcpRFqA3u4Rs2UynN9mVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6991
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.468200-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/XD0CNJ3fxO4dcT3ZaTocyYHhs0mgDoxyETzgIO4sasaQTVtPXXNM8ha
	W4U9IrFp8dbyXEG2mDz9n/vgRBjkdtiC6nY+rGaDhPQQVFw3HFE9nxZsOR/FTmyiLZetSf8n5kv
	mj69FXvAOkBnb8H8GWt7DW3B48kkHdB/CxWTRRu25FeHtsUoHuXCgU6tQzpcCmv3zUTvQebbh9s
	Oeak89A6lcGBlh+YMzrpcchznD6Bw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.468200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5E8015052F85C0A7122C47274D3525D1729D0B3A107B15366AF7D3A21F9D0D232000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgdm9pZCBtdGtf
Y2FtX2Ntb3NfdmZfZW5hYmxlKHN0cnVjdCBtdGtfY2FtX2RldiAqY2FtX2RldiwNCj4gKwkJCQkg
ICBib29sIGVuYWJsZSwgYm9vbCBwYWtfZW4pDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2
ID0gY2FtX2Rldi0+ZGV2Ow0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSAwOw0KPiArDQo+ICsJ
aWYgKHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KSA8IDApIHsNCj4gKwkJZGV2X2VycihkZXYsICJm
YWlsZWQgdG8gZ2V0IHBtX3J1bnRpbWVcbiIpOw0KPiArCQlnb3RvIG91dDsNCj4gKwl9DQo+ICsN
Cj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmY2FtX2Rldi0+aXJxbG9jaywgZmxhZ3MpOw0KDQpUaGUg
Y29tbWVudCBvZiBjYW1fZGV2LT5pcnFsb2NrIGlzICJQcm90ZWN0cyB0aGUgYnVmZmVyIGxpc3Qi
LiBXaHkgZG8NCnlvdSBwcm90ZWN0IGh3X2VuYWJsZS9od19kaXNhYmxlPyBBbmQgSSB0aGluayB0
aGUgbmFtaW5nIG9mIGlycWxvY2sNCnNob3VsZCBiZSBjaGFuZ2VkIHRvICdidWZfbGlzdF9sb2Nr
Jy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwlpZiAoZW5hYmxlKQ0KPiArCQkoKmNhbV9kZXYtPmh3
X2Z1bmN0aW9ucy0NCj4gPm10a19jYW1fY21vc192Zl9od19lbmFibGUpKGNhbV9kZXYsIHBha19l
bik7DQo+ICsJZWxzZQ0KPiArCQkoKmNhbV9kZXYtPmh3X2Z1bmN0aW9ucy0NCj4gPm10a19jYW1f
Y21vc192Zl9od19kaXNhYmxlKShjYW1fZGV2LCBwYWtfZW4pOw0KPiArCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmNhbV9kZXYtPmlycWxvY2ssIGZsYWdzKTsNCj4gKw0KPiArb3V0Og0KPiArCXBt
X3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldik7DQo+ICt9DQo+ICsNCg==

