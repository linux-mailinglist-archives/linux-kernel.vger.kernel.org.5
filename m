Return-Path: <linux-kernel+bounces-66321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB07855A74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A6C1F292EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A1BA2D;
	Thu, 15 Feb 2024 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MBpeUXUC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XTTq6hmz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087F33DD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978461; cv=fail; b=SgfW9L88ZnHwhDRdVDzPln3mJVkrsP7N7c5IRxu/u+IK5ZQY+58pgtSNge7ANPfV8G5TNS68RptCChWQWdPGaSfTTNnSx9CvMg1Jk0B+PirP29HbyVJhKegIln+VyfySATsKoXV+jIA4J5EiKmMsqXX8VC5DPGZH1dnuzh8Cnmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978461; c=relaxed/simple;
	bh=uVpiQO1TsgbApR/ZlJ142yswArqVykz9GzGp19vGldc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9d7ov//u3BpWLSyYnudWAoVvgY7Zyf527iYtbNEfdkGHUyyij4TGtRRMb8pQ+Lt6geMSVJ5M2L/dYAblsucNiaLU7zzvS1J20HzfxUCQK7EDlTfSV4gYNOU1H2rYo5EMsz45QEm6vRBIJkouJuOolSTQ+PPscCT8qUcAFp98Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MBpeUXUC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XTTq6hmz; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ed9612acbc911eea2298b7352fd921d-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uVpiQO1TsgbApR/ZlJ142yswArqVykz9GzGp19vGldc=;
	b=MBpeUXUCKIpfwug9KK5E7ZTPqWwyD7EZGKXfXBTbt4ztE0by2JMpTiOnx5CCEuhe8nhpdaE+q4aR5yeM+iL6jJhk8iInOW0kpTnVLL/TDzRLsId+hyJelknPoaTwMsNrRKlfv+c8qS4qszkT5K9gshAs5vURJeYAT2f4AgLo1CA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a19449d3-e2f8-4629-a27a-851c21650409,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:42eccdfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2ed9612acbc911eea2298b7352fd921d-20240215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1084165875; Thu, 15 Feb 2024 14:12:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 14:12:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 14:12:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KId6HwtgLCepaVEvkaxAFxMBjlS8+jtC7WlyoiOhFK0OKCBcSqjnUC5wJB9h9LvHcII6k5cENOlIl2W0QdPO4WeIv/xLXwjYZKZg09OlDAzZe0nWVwqXTnVNKfMF/AtGR23p8LQBWaA4cXx/Dej3625/ikogtW72lkQRsY70ZUdKu9KDrRcqjyw0T2d4b4q3LGe3PmvfcmVJpCwveeMRyeoCU12eIc8U+fIHc1vg0MPwk6I0bGdvZSnVJhEBtOnX0Q80zLh6mltc5jbwyHyrKDyXV570JZRvBa8o7X+ZnInQcUSNp5tavi2alIt/IY0xM6vP9546xKXxdEZyb22+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVpiQO1TsgbApR/ZlJ142yswArqVykz9GzGp19vGldc=;
 b=O5KuptaBfHa5innXskvuq5IBpnrb/mXe2gXtxoi+ypfYWalGZJYvOROT6iAtRx1OVqKJ6U++SxuY8OCcvf5nAPSsgUO38Z6F55+GXux1PtU/2wvEQzVTfLpzu42MsX7leLw1qxvpe1JSSVB5U4pl63BraClFVedSCF01qC6wUf6SK0nKcKclE0kEwAuLePsCI9giow2YUVuXb1yzenzXU0wg38OZpW+RQIm4XZ5nPWaE05h+dhq4d8UZw1T8ElXMgwtadH6RF7w+zfE1lBRoc6u2YGTdGy2xKXi6yhWZFQeIJPu6PC+uXvfH4PqMEbNpmhD4pWNGtYIefl1sS6SibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVpiQO1TsgbApR/ZlJ142yswArqVykz9GzGp19vGldc=;
 b=XTTq6hmzXA/bifdtzrl0wCJjMfbHykAr3wePJrz3eA+RnHG76NgPYUpyjV6BAfJFRO0WswgYce5y+EFA955troPi6htiTUomLghJL9rdo6XrG7EtKMwhN5272Wnbc2feJxIx8PJ9QoODwYDi+Cw5VH8zLKm726wL3PUboUIGWNI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5970.apcprd03.prod.outlook.com (2603:1096:4:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 06:12:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 06:12:18 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 2/9] drm/mediatek: dsi: Fix DSI RGB666 formats and
 definitions
Thread-Topic: [PATCH v5 2/9] drm/mediatek: dsi: Fix DSI RGB666 formats and
 definitions
Thread-Index: AQHaWdWBbTwXCyP25kSEDaoNKCMs8bEK+DAA
Date: Thu, 15 Feb 2024 06:12:18 +0000
Message-ID: <23017aad8135b41bffede3b55c0ac273daef0b82.camel@mediatek.com>
References: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
	 <20240207145307.1626009-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240207145307.1626009-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5970:EE_
x-ms-office365-filtering-correlation-id: ab6e348d-0bf1-45c7-6a03-08dc2ded107e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QnrTMPq5+cpAMqN/4fw5U3n6qxpBWtOnPAPzrG6o63jSq2We+hykQ1BJq7DtyIV6E35erxA5hSpCnSjaLCXRg7CGtFGm3m1e4NoUZSBUz8/LxWTcE6euVkee8e5vVcSGMGkDnM9KVHSv1i6QCCkhISh8brbiiWlQtr+IQ0e6Th0TJXunk4C4Wu3tsD4Rl0Pf2z9SyWK05yjScmusapJ3FfrDkmHIJBiaef2eM/OF9FtoJeJsDlQ9M2E/cG1lLYXCCCY0tk4MarfS9WiU3OGV5rnJizkCuciDlNBCa1p35vyvOZ4CGA/YGHF9GUfFrMcBo1avcZ5tSgOT8Aa7soKLeF+W3GQ2g9+hxQudvNmmk1rDSKpw/sma5GUkqadXFJHPpB+GONkAt8Dg1leIt/39yrBDDxjnDRLQVCFbFhaU4TqzivgxfblAmhkyGJegyEP/87eQ8AwvFizCmuSKXmjjq2F5PKJZI3ZigitUYkIu3JttoNKAhYA8fM96N28+JYZLKp194+8UEgL8AgjIv2JmQiU5yh9p/KS9S4e6RiRWAkC/hI6knz1ehBWY4VLOIKbn7M99iNvA8CDUex2dF8fRaF2P1K3VzHm79J5keMBxma8b/18VplELDE68HuAp1iXC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(85182001)(36756003)(86362001)(122000001)(6512007)(6506007)(478600001)(41300700001)(71200400001)(38100700002)(54906003)(110136005)(26005)(2616005)(38070700009)(6486002)(83380400001)(316002)(66446008)(66556008)(5660300002)(64756008)(7416002)(4326008)(2906002)(66476007)(8676002)(8936002)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTI0eVBWMTF2UEtGYkROZ25Na3dmZmduTzRYbWZYcFh3elIvUXFrMUdwblJ3?=
 =?utf-8?B?ZWZubWlCTExha2Y5dUhVNXBlN0NVcVVJK2tqQmg3RTgyV2NtMlVSVVZoSlZS?=
 =?utf-8?B?YVpZc3Joanl2UWtsM0pYZ2pDMUNra3owcmZpN2kvZGNvR0NHMHlaUjhwTnkz?=
 =?utf-8?B?Y0RFbzNTWlpxS1RYbkVOT3hwVWlDeDVPeVIrUWdpVDVXVHVSWWVqeTQ0Y3Zn?=
 =?utf-8?B?MVJaREpRMWJ5YXdRMFoxalAzQXVtSWZNemFwTE5OeXBSaEtBUEtlOUZMRStD?=
 =?utf-8?B?Vi95Wml0SzZETTgwTzJ2elF0eCsyNDBUdmh4V1lqODlyaE42enhSKzF6NUVQ?=
 =?utf-8?B?RENmRVgvK2RjWWcwQlR3SGNpYkJITkpndmFTTFhYb0NBUjJGUVBsa3hleWhX?=
 =?utf-8?B?Uy95N2hTcWwzRXVGQzZPMEYyR1FNZmhzZnJYelk5NDVSYyt0VTUrYWZXVngv?=
 =?utf-8?B?UThpZDhOVlZYRVJYWkVUTHp3Zll2d2dNWktQTmx4Uzc0RDExckJNRGx6VHVl?=
 =?utf-8?B?ZDlOQyt0dGRwbU0yWUJTaWtLMFBmS3NhdEtuN3ZWVmNtdHlTNGdyM2ViOHNG?=
 =?utf-8?B?L285dU94M0pYY1lBRGZmenZJYXJDZXl0RXBnSXBqallrcTRKME9nWGFhbXhi?=
 =?utf-8?B?Y05rZk92WC8wZGg5N0JkSmpLcGJMRWhLSGdtbUJLZjFJb0RvNXJEMjRiaWY1?=
 =?utf-8?B?SGt2UkpvSjhaUlppbTFXNW5FRWZkU21Gb215R3V4NDBhcDdZQ3ZZcmpMa1hU?=
 =?utf-8?B?U0t2WGxxcWFzcG9LSHJ0VUJHQllJa09RV2lYUzUzVDMrakpxaGRGVGZhUFFE?=
 =?utf-8?B?ZkhzbXlPa1JYNXRaaHdoOFNTUHBHZmRyMDhKOHFmelVaU1dxVkNzZXBYdUVV?=
 =?utf-8?B?N05xcXZyZFkydDZ6SXlaSmYxa0hmK2tpSldIZ25lYUVIQWlPOVYrVE9hZU9N?=
 =?utf-8?B?VUQwbFc0U2xOZEJKekRqcS8rMkFlbjRwMFFJOFI5akhzV0hhaGJad2ttWTFH?=
 =?utf-8?B?azYwVGtCbW5DUWtRZ3VMeUd0SUdVbU5XWnkzUituNnBEbVpjWUtLWUxLaEJM?=
 =?utf-8?B?Z2c5elUwcVlydERDTDZraFhQTXVtNktJNUZxRnR6ZzNGRTZWai8vVXBzZDVq?=
 =?utf-8?B?a3pmU1JqZEN3ZUkwTWo3OHVUU2tPSWNaOFY0OStJWXcxa1JyZmk3eG0wUUlV?=
 =?utf-8?B?NzFIT1V6clhDWmJKdEtKR0NKL1MyVWNscGYyRkRzMEJhVXp4UWQyeWEydjdu?=
 =?utf-8?B?VmQwVVNPOVVIVVBWbXhHaFEwMytZci9PWW5aSE5Ub3g5UGQrc1lmRXhrOWk4?=
 =?utf-8?B?SDl3WDk2OFhTc1RaRTNnUUF4ejk0dlFMWFUvYjRkNmZMS3lvaGl2cG83Qm9G?=
 =?utf-8?B?MTdvOEZhUWRIcXFlQ0F5OFNqamREMCttN21aMFV1SlFOcFlsNEpqb095N2pu?=
 =?utf-8?B?dEY4dGJDMzZzTUdrOU96MFlBV2J4eGZldWwydGpsTjZLa1JMZXBCRjlBRU15?=
 =?utf-8?B?bnNsUW5OMnBpVEh1ZzJxMDd6aW5JZlN2K3dTZVp6b1J2VlVCNm5CdVZrUWVj?=
 =?utf-8?B?S0pSbERTOEQvTmpJUWY3blZoNGpFNU4zNGhxVklwQkFtS09kUUFkZXA4Zncr?=
 =?utf-8?B?R1I5cE9sd2tLdk9zWExEaU5TeXJxbDBBenBFY1RPVldzOEFkdXF4TWh6M3l1?=
 =?utf-8?B?Z1FJUkxVUFR0QnM0UnVIRWFYbnFOVHVMeHB4dDhkay9OTndFVVN6enBvYVpm?=
 =?utf-8?B?NEZFZm5MNmxFSm5sVEQrTm00aEw5bitRbW9iTGV1d3ZDRTJKbkw2dExJdmxt?=
 =?utf-8?B?cldubGNFY0ZSMUlSaHZJN1NhVmg4RS9aUFdqbEp5R1pSTlZ2d0tZODFwTmNZ?=
 =?utf-8?B?aGNUMVdkWFFYWWlBZ2gxL25CbFEyelJnNUhhcXFFckxySXdaQlp0Zy9ucjB2?=
 =?utf-8?B?YXRvMnZWU21zWVo4eUw1dTlrVFNpRUNoa0hoQ0J3N2dhQThiSWx0TnpVdzg5?=
 =?utf-8?B?REJUdS9QUG1vMCtGYUhud1FYVXhDdGJuOExUcGJPY01KZGc0bmpSZXNwUEJ5?=
 =?utf-8?B?UGxtM3E1c2E4ZWpWUUk2VVhnWUt5NkRrWk5vMlFDNTVzWWZwYnB4eTd5MUhK?=
 =?utf-8?Q?ha+tcDQDFe2hpVyayM9SZV6dm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB6047F0AFDD7469E0907784119A488@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6e348d-0bf1-45c7-6a03-08dc2ded107e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 06:12:18.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khej7qRr5IL859vaXNMjBlPGjjsoxRv/caErpAPKiOTzKlpw7IgOKK9ZHnVtNCFH3hHs6HeVbNOTlV7I1eHf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5970
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.399300-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQNtKv7cnNXnSa1MaKuob8PC/ExpXrHizxHZg0gWH5yUbwv
	UFdZPHgIzMLPzF1PD3uKE/uQTmGLXMrC2rWI0ze+t1AhvyEKdj4k227IvqakhQfxTM57BPHDTak
	PH+NO07EmTX29bLn7V+dTsIISNsrfPUtyIkHfnjVDiyuN5FvFNkyQ5fRSh265CqIJhrrDy2/AqM
	u2U06kJuLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7CKFCmhdu5cV8RqGh8L9v6DDrh
	Pi68nEdxiZfwCjIiDGgNXoAc42ojztabCbAIUGn97Hsq9jD4SeWp07L1VtqgVaKsaPP0djAOZvN
	Lt3XI+S5ZyimlDMxyA56xhuba2WuZ86KY3oNT3zIO0Si2Tuenp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.399300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9C3DDC0EA5BF18356E9277E2480BEC995297BC4D2D49B2AAAC0D540D825CDF4C2000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAyLTA3IGF0IDE1OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gVGhlIHJlZ2lzdGVyIGJpdHMgZGVmaW5pdGlv
bnMgZm9yIFJHQjY2NiBmb3JtYXRzIGFyZSB3cm9uZyBpbg0KPiBtdWx0aXBsZQ0KPiB3YXlzOiBm
aXJzdCwgaW4gdGhlIERTSV9QU19TRUwgYml0cyByZWdpb24sIHRoZSBQYWNrZWQgMTgtYml0cyBS
R0I2NjYNCj4gZm9ybWF0IGlzIHNlbGVjdGVkIHdpdGggYml0IDEsIHdoaWxlIHRoZSBMb29zZWx5
IFBhY2tlZCBvbmUgaXMgYml0IDIsDQo+IGFuZCBzZWNvbmQgLSB0aGUgZGVmaW5pdGlvbiBuYW1l
ICJMT09TRUxZX1BTXzE4QklUX1JHQjY2NiIgaXMgd3JvbmcNCj4gYmVjYXVzZSB0aGUgbG9vc2Vs
eSBwYWNrZWQgZm9ybWF0IGlzIDI0IGJpdHMgaW5zdGVhZCENCj4gDQo+IEVpdGhlciB3YXksIGZ1
bmN0aW9ucyBtdGtfZHNpX3BzX2NvbnRyb2xfdmFjdCgpIGFuZA0KPiBtdGtfZHNpX3BzX2NvbnRy
b2woKQ0KPiBkbyBub3QgZXZlbiBhZ3JlZSBvbiB0aGUgRFNJX1BTX1NFTCBiaXQgdG8gc2V0IGlu
IERTSV9QU0NUUkw6IG9uZQ0KPiBzZXRzDQo+IGxvb3NlbHkgcGFja2VkICgyNCkgb24gUkdCNjY2
LCB0aGUgb3RoZXIgc2V0cyBwYWNrZWQgKDE4KSwgYW5kIHRoZQ0KPiBvdGhlcg0KPiB3YXkgYXJv
dW5kIGZvciBSR0I2NjZfUEFDS0VELg0KPiANCj4gRml4aW5nIHRoaXMgZW50aXJlIHN0YWNrIG9m
IGlzc3VlcyBpcyBkb25lIGluIG9uZSBnbzoNCj4gIC0gVXNlIHRoZSBjb3JyZWN0IGJpdCBmb3Ig
dGhlIExvb3NlbHkgUGFja2VkIFJHQjY2NiBkZWZpbml0aW9uDQo+ICAtIFJlbmFtZSBMT09TRUxZ
X1BTXzE4QklUX1JHQjY2NiB0byBMT09TRUxZX1BTXzI0QklUX1JHQjY2Ng0KPiAgLSBDaGFuZ2Ug
cHNfYnBwX21vZGUgaW4gbXRrX2RzaV9wc19jb250cm9sX3ZhY3QoKSB0byBzZXQ6DQo+ICAgICAt
IExvb3NlbHkgUGFja2VkLCAyNC1iaXRzIGZvciBNSVBJX0RTSV9GTVRfUkdCNjY2DQo+ICAgICAt
IFBhY2tlZCwgMTgtYml0cyBmb3IgTUlQSV9EU0lfRk1UX1JHQjY2Nl9QQUNLRUQNCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiAyZTU0YzE0
ZTMxMGYgKCJkcm0vbWVkaWF0ZWs6IEFkZCBEU0kgc3ViIGRyaXZlciIpDQo+IFJldmlld2VkLWJ5
OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RzaS5jIHwgMTAgKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2ku
Yw0KPiBpbmRleCBjNjZlMTgwMDYwNzAuLjhhZjBhZmJlOWUzZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC03MSw4ICs3MSw4IEBADQo+ICAjZGVmaW5lIERTSV9Q
U19XQwkJCUdFTk1BU0soMTMsIDApDQo+ICAjZGVmaW5lIERTSV9QU19TRUwJCQlHRU5NQVNLKDE3
LCAxNikNCj4gICNkZWZpbmUgUEFDS0VEX1BTXzE2QklUX1JHQjU2NQkJKDAgPDwgMTYpDQo+IC0j
ZGVmaW5lIExPT1NFTFlfUFNfMThCSVRfUkdCNjY2CQkoMSA8PCAxNikNCj4gLSNkZWZpbmUgUEFD
S0VEX1BTXzE4QklUX1JHQjY2NgkJKDIgPDwgMTYpDQo+ICsjZGVmaW5lIFBBQ0tFRF9QU18xOEJJ
VF9SR0I2NjYJCSgxIDw8IDE2KQ0KPiArI2RlZmluZSBMT09TRUxZX1BTXzI0QklUX1JHQjY2NgkJ
KDIgPDwgMTYpDQo+ICAjZGVmaW5lIFBBQ0tFRF9QU18yNEJJVF9SR0I4ODgJCSgzIDw8IDE2KQ0K
PiAgDQo+ICAjZGVmaW5lIERTSV9WU0FfTkwJCTB4MjANCj4gQEAgLTM3MCwxMCArMzcwLDEwIEBA
IHN0YXRpYyB2b2lkIG10a19kc2lfcHNfY29udHJvbF92YWN0KHN0cnVjdA0KPiBtdGtfZHNpICpk
c2kpDQo+ICAJCXBzX2JwcF9tb2RlIHw9IFBBQ0tFRF9QU18yNEJJVF9SR0I4ODg7DQo+ICAJCWJy
ZWFrOw0KPiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2NjoNCj4gLQkJcHNfYnBwX21vZGUgfD0g
UEFDS0VEX1BTXzE4QklUX1JHQjY2NjsNCj4gKwkJcHNfYnBwX21vZGUgfD0gTE9PU0VMWV9QU18y
NEJJVF9SR0I2NjY7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2Nl9Q
QUNLRUQ6DQo+IC0JCXBzX2JwcF9tb2RlIHw9IExPT1NFTFlfUFNfMThCSVRfUkdCNjY2Ow0KPiAr
CQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMThCSVRfUkdCNjY2Ow0KPiAgCQlicmVhazsNCj4g
IAljYXNlIE1JUElfRFNJX0ZNVF9SR0I1NjU6DQo+ICAJCXBzX2JwcF9tb2RlIHw9IFBBQ0tFRF9Q
U18xNkJJVF9SR0I1NjU7DQo+IEBAIC00MjcsNyArNDI3LDcgQEAgc3RhdGljIHZvaWQgbXRrX2Rz
aV9wc19jb250cm9sKHN0cnVjdCBtdGtfZHNpDQo+ICpkc2kpDQo+ICAJCWRzaV90bXBfYnVmX2Jw
cCA9IDM7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2NjoNCj4gLQkJ
dG1wX3JlZyA9IExPT1NFTFlfUFNfMThCSVRfUkdCNjY2Ow0KPiArCQl0bXBfcmVnID0gTE9PU0VM
WV9QU18yNEJJVF9SR0I2NjY7DQo+ICAJCWRzaV90bXBfYnVmX2JwcCA9IDM7DQo+ICAJCWJyZWFr
Ow0KPiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2Nl9QQUNLRUQ6DQo=

