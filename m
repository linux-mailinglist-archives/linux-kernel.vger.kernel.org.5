Return-Path: <linux-kernel+bounces-24817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7382C2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991DF1C21DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB106EB6F;
	Fri, 12 Jan 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bhQtZtFk";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="p4Mkwxx8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C27316B;
	Fri, 12 Jan 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CCkTR5028141;
	Fri, 12 Jan 2024 09:41:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=PODMain02222019; bh=aC4xHwUuiQwqZPj+0wp3hwsvh+cRzFL2V2tY2D0B8
	8M=; b=bhQtZtFkqEg5qtOtuDa3F0Bv6Cam8cSMXujxXOSKtOnLc1RgRvhVRa5rR
	hQMnnjLYwu4t1INYMf2tl+FXrFyrR+fp58Ohl/oG1SCfRokQLG3JNZw4fakK4+v9
	J4Z44fSbkg1P7tXRCqWf5Ao5LC9SwKqA+TUpCzO3TFQuPin+Gl9Gi2PX6wExyjLz
	/EQEtW8cmHPZSgG2HcIW1WSzmkDiArLDJ6HZAqm5dsgjM0/2MgaKVGAH4dTnHgVK
	dHFn9kWQEtK4zf/+mEQWVMUUxKuscmSFt+ELCt84xLMC63Jvx/UjI555Y0Sjlrkb
	qZqh5kC4lnQMUQw8eKD6pLe5aIjbg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vf552rmec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:41:41 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5G9vJGTtrglMthqxedPfpR0vkRANUWJdxEBiqHt3KCoV7d2xKiZh9ewrhZCkbRHj2CwkM4uw3QqM7UhX1YdGzfH4I5FXBSHwuoGKtliySa9B3myvRldX/vCmbQI4GntfAit8Z6pWsURLV16BbRvhL22AJxx1eJrXYcgqmeWVQ4aIavjvfazqo05Tww3Jh41viBVsIQ3Umrq5Xc3aH0I8kXFGxxZvlQEGWEiUkQz3PtYNGGTuRXE0eVL8RuzAaxgQJFK/K0RG207tSSB0mcwYtO4KD3MPiRQFx693QafyUcTWMqcTX1FMT9s3Ju3iJSS+soP7xkm+bLwCs2UEvTA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC4xHwUuiQwqZPj+0wp3hwsvh+cRzFL2V2tY2D0B88M=;
 b=lSlVrrma3865oE1VYE49bfPb3OmkPpWcJ2JvLfDMLKBZ4Wtz0kC7KJei5HvbWvD76EaGPdFvXxIY33rw6q9dtJ8HdUoqt2wMj3H2L5YXPzwPiF/gXQ1zRkPFKxTtJW2Dz9vxqLDjHtFBOw7Uu23LTwQxG36jTLJTl6XHrfh3CkcimbRXeGmiR4XTlGPzm5ixigw92aM8gbphcVrkVP3sejkQoorf523vuKUvUiTaam7F9tvojIxOVsIcK0vlRZalOh0dP2N5GmirXNiqalGxr9FNZ0dc50CqA7a8sOsaq1gr++/CV2ukq84fq98z01qmgP+rpOnciUSburE8WezY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC4xHwUuiQwqZPj+0wp3hwsvh+cRzFL2V2tY2D0B88M=;
 b=p4Mkwxx8xRvb4AcB0aKNmoEb5hxx6ErA7v5nqIHJ+o8i2evsFWlkwz4v63SpPPTZzCSNUnCMicMD3s1hN14aluojoXeJUh/JbaNSHW3PvafNePFrSclqFqg5sMbHH4C+kf53VYYvG41TqmjjcroIZuvBbcSWMMEsF8vaswAQLb0=
Received: from DS7PR19MB5688.namprd19.prod.outlook.com (2603:10b6:8:73::14) by
 SJ0PR19MB4541.namprd19.prod.outlook.com (2603:10b6:a03:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 15:41:32 +0000
Received: from DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb]) by DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 15:41:32 +0000
From: James Ogletree <James.Ogletree@cirrus.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven
	<Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<James.Schulman@cirrus.com>,
        David Rhodes <David.Rhodes@cirrus.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Peng Fan
	<peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        Jacky Bai <ping.bai@nxp.com>, Weidong Wang
	<wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Topic: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Index: 
 AQHaP17EFm09wiwp9km197ze4eTGobDNm1eAgAR1GICAAAfzAIABDb0AgAEakwCAAhwmAA==
Date: Fri, 12 Jan 2024 15:41:32 +0000
Message-ID: <F1282174-6152-4EC3-BF53-2EDAA3CBB838@cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
 <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
 <ZZ3JNuLp-ZfGOQRF@google.com>
 <42A07166-6569-4872-B5E0-6D71C6F3656D@cirrus.com>
 <ZZ-YhtIulqrSFc3R@google.com>
In-Reply-To: <ZZ-YhtIulqrSFc3R@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5688:EE_|SJ0PR19MB4541:EE_
x-ms-office365-filtering-correlation-id: 7323703c-3d57-41b3-a184-08dc1384f3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Skdnu+MHFNqtPIqplN8EWCVmId/6dZmhKnhNCwIk1bl7btaqOXSOgmZtrAVp4PZoW0fnmnamQMfprs6StcOFcmiEayW8C0jwZmWT3uObUpKaCiQSseRYFOLBrq/+U8D7as4Wj3SdsluAmo1oAIq99PaSbYt03CXm39hps70XW82KIV0ZEaIAa5sitOlb8eakwVc/iS4jZJ+8lpi2Vb6yb8rnxhO8os5j5/EB5Rf5mYJ+qR7x/yJ4fB6iJce81ThK4tExOzYhzpHc+SMNl1FDHuTfmUKULgVdhrPNqwwmoHcvmWTGsqyTnVUZ20TLw7l2M1Hc2n9RnxWIK/AX9nVFaTKdugoAV3Vcf3cdbQcsnpbOvpSeid6PM2Hvrv+mnB7LKs0j4jyjgXMZwQBit9n0ucVYIOk/iDHGImK7e3BSnVsAnAynWeokxyLb3l6+kV8IfJQKKJhYa+vpwmI8OmiHm+9CyQeR7gJ53xRQp7plgu1FljGhRS48X4LljUKTF0sDple4xXSt+weX5+3KBFIXmfIFdz7QUSn+Q8VcbkaKTzHadWuqIjY535IIqPVrwz4nDR0SrvOZs9g31c3h+7h5FWxbd5BsImaksucEAjUc4Aq5/ZBDz6WaqJz/vC/uJsd9il3pEJ+h2Fmrn2tiy24JGw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5688.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6916009)(2906002)(7416002)(5660300002)(71200400001)(8676002)(8936002)(41300700001)(66476007)(66556008)(66946007)(54906003)(316002)(91956017)(64756008)(66446008)(4326008)(76116006)(38070700009)(38100700002)(122000001)(86362001)(6486002)(33656002)(6512007)(26005)(2616005)(53546011)(478600001)(83380400001)(36756003)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UW80T2swZWVYKzFXQ0lOcFdBbHMwTGVxLzBtTEhKb1JjU0xtSVVpeDVlMkhY?=
 =?utf-8?B?bDRzN2hsM25jV0pTQjk4dGM1Z1p1L25IdFcweFZMWWVvN2txRmYrNG5IOTJK?=
 =?utf-8?B?azRhMUhsbzJLZTdHRFpVZXpadUZZOFFLRU10VG1qbEFKaTNybDF6S0RYSzE2?=
 =?utf-8?B?MmpKalRvQjZqTFlGRGswc2RjcmFFY2lINnhzTllId2g3dFlZK3BxN2RpVzJM?=
 =?utf-8?B?ZlVzS3R2dXhnT2s4NTVSalVLUndqekZNTkQzclBaRUEzdmZmOUtOZmhqVDRO?=
 =?utf-8?B?MkkxQncyOEg4ZUpET0dCd2g5M2RFMkhoRjF2Njl2WEM3N21CS3VVclJnck5a?=
 =?utf-8?B?cnVGNVR5U2J3S1lHcG12dFEzVS9QVTJ6bjk4OUpXTzdRd0QzN05GN1JDa2wy?=
 =?utf-8?B?Z0JhVWlVZUxTVTc4TDhlbW0vU1RkNjkrdGNFZnJVcHBmZ1pRTGxFazh2OWJH?=
 =?utf-8?B?cmFJNzg4UW9sU2ZOcEdsQ2t3SkUvSTAyY24vMmg5YVF4QlVhbktLNWxLMFht?=
 =?utf-8?B?YlNudGNZaUZMLzRIVDlGaER1czBHSjZyNWtmT3pJcFBTZWpzRmdWcGtCSEhl?=
 =?utf-8?B?eERLUWNkODZ1ZkZLK2JTQ3N1RnpTQ3VJRXFyVEtjNFdEMFZHbDdiSUQzUlVp?=
 =?utf-8?B?eUxXRFhNMy9CaGd1MmVGcFBJN1hyYytPRm0zTTA1NmpLVHEzc3J0QjlNWTlz?=
 =?utf-8?B?RFEzdTBuQkNyalkxWXM3WWRrOC8wa1NSOGt6dUxsZ3ZBRUJBNGg4TDZnVkpU?=
 =?utf-8?B?VUJLY1I5cTd3ZitscVFvWDFXaUIwbVhyMk10Ui96N2xsTlVWaXc0eVRndW9u?=
 =?utf-8?B?RUdITHNIOHkxV1lxNTIxdUFSeFZPY1IzRGdUZzhvVzE5VlB2MzE5Um5xZDVE?=
 =?utf-8?B?RExKRGNPU2Y4NHhtN0ZWMTdZQnQvRWg5VDRnSUs2ekllSG9RajZjMTc2clhU?=
 =?utf-8?B?MjBYYk1YY3hPd0w0bVVGN0tZMW5hR2ZWZzlpbFVUbUFkRlJJZ2RsWHJJUTNj?=
 =?utf-8?B?MGIyNTZRWHc4bGc3ZXp5QXZzb2F4cXZUekdxaGlqSGpjTStXeHg0TzhPem9J?=
 =?utf-8?B?bnM3M0UwdWlwa3E4bXcwZDhnQUl0WXRpN2xxU3NzQWhrMjVjY1Jzc0Y2dExQ?=
 =?utf-8?B?R0NoL24wNUVJOFpnVXZDRW56NWpiaUpvaDhYMlozWjB4aloyb1ZGTXNaeG5E?=
 =?utf-8?B?eHFyMldWYTQzcjRRczlVMGUzK3FuRC9qWlBROUNZM1AvNUVua2tWWVh0U1Ft?=
 =?utf-8?B?cmtmeEhFUkRNdTJLQzhzWExyb2VNcFhVcDA2V3ZzZHBPY1YrTVVGTStDeFBF?=
 =?utf-8?B?a24vZ0VKM1loQlJXSmJEcE8xV3hmTzJPTjlSL1BLeU0wdnQrQ2l0L0YyUnc4?=
 =?utf-8?B?RjRaNkUrRitvSWhWK3UxUTd3UzQ1VE9hR1MyMFZFNHhuUzk1eWZoMTh3cENs?=
 =?utf-8?B?M0RoMENRelI3NUJsWkp6RjRWMFVxdFcyZUZsS202K1ZNU3FQejNQZzJBZ3Zh?=
 =?utf-8?B?ZnNoUk9zYTZjeVdYaXdCdW1kLzdZaGtzb0k0NU5iaGI2NzY1UUY3OUJpeVps?=
 =?utf-8?B?T0JkN2tpbTIyRG1sWlpzZC9MUzBBQzVRbWZCMHRUWEFHMjAwTjB1RUNNMUZn?=
 =?utf-8?B?eVNCbVZZZnV1c200SVlWMWw2VGhOQm02KzMycXhpa3RlMUtKNHhQMXRlTGRO?=
 =?utf-8?B?TTVkdWJ0RU9EMDRGNlJsc29rY0F3OGt1azZuTzFYdmwxY3hkQlU5SXMwUktY?=
 =?utf-8?B?U2lMeVdueTBQdSs0dE55OUZsaFJhSEt1d1VoZGFDdTZGQmh2a0dYSnEvTHFF?=
 =?utf-8?B?MzNDM2JJSWpTQVZhb1BOQVFLdXZsZlZyL1paSklKZ1VrMW1jb2ZXNTNGZHY5?=
 =?utf-8?B?a29UM2c5MUJmWVFuRkNRZGxsMVVrQ1RXODRyVFh1RE5NeExSNzdWUEZmQi9R?=
 =?utf-8?B?Sm9lUVdFQ1JoNW1PS05NUXpYWkdWRmxvMkJtRVlmbTZZdWRlQ0lscEdWenlm?=
 =?utf-8?B?UERVK2pqbnJ2ZDh2QVdjVUV3RjZ3bEplZnFzdldvZ1g1NG1xRmtTTnNXVHh5?=
 =?utf-8?B?RGZLN1VtQmw5cDRVT2hTd3JlZUtaTCtkVmhhNWRCdnREREJtTnhKQkpJTDMv?=
 =?utf-8?B?L29Ud2o3SlF0eWdULzc3RVcrQzl5Y1VURHRxckl4K3lQb2c4cStmdWFSN1pD?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6536BE2C7296E74B824FBD8C94BCB1F9@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5688.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7323703c-3d57-41b3-a184-08dc1384f3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 15:41:32.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y22GxrucyCiKhiSNw3aZDn0rXpgKJ7rJrEIlJwq47sFbRRA2tw6rpv9Y4PO2K3TJQAlcKVcXaviXo+/izX7wpdd8ozfK9Lr4+F2FAtQyiXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4541
X-Proofpoint-ORIG-GUID: KiUqVFt-_59rn2DFrjohafsGmi_mDMFf
X-Proofpoint-GUID: KiUqVFt-_59rn2DFrjohafsGmi_mDMFf
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSmFuIDExLCAyMDI0LCBhdCAxOjI4IEFNLCBEbWl0cnkgVG9yb2tob3YgPGRtaXRy
eS50b3Jva2hvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKYW4gMTAsIDIwMjQg
YXQgMDI6MzY6NTVQTSArMDAwMCwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+PiANCj4+PiBPbiBK
YW4gOSwgMjAyNCwgYXQgNDozMSBQTSwgRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZA
Z21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIEphbiAwOSwgMjAyNCBhdCAxMDow
MzowMlBNICswMDAwLCBKYW1lcyBPZ2xldHJlZSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4g
T24gSmFuIDYsIDIwMjQsIGF0IDc6NTggUE0sIERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9r
aG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIFRodSwgSmFuIDA0LCAyMDI0
IGF0IDEwOjM2OjM3UE0gKzAwMDAsIEphbWVzIE9nbGV0cmVlIHdyb3RlOg0KPj4+Pj4+ICsgfSBl
bHNlIHsNCj4+Pj4+PiArIHF1ZXVlX3dvcmsoaW5mby0+dmliZV93cSwgJmluZm8tPnZpYmVfc3Rv
cF93b3JrKTsNCj4+Pj4+IA0KPj4+Pj4gV2hpY2ggZWZmZWN0IGFyZSB5b3Ugc3RvcHBpbmc/IEFs
bCBvZiB0aGVtPyBZb3UgbmVlZCB0byBzdG9wIGENCj4+Pj4+IHBhcnRpY3VsYXIgb25lLg0KPj4+
PiANCj4+Pj4gT3VyIGltcGxlbWVudGF0aW9uIG9mIOKAnHN0b3DigJ0gc3RvcHMgYWxsIGVmZmVj
dHMgaW4gZmxpZ2h0IHdoaWNoIGlzIGludGVuZGVkLg0KPj4+PiBUaGF0IGlzIHByb2JhYmx5IHVu
dXN1YWwgc28gSSB3aWxsIGFkZCBhIGNvbW1lbnQgaGVyZSBpbiB0aGUgbmV4dA0KPj4+PiB2ZXJz
aW9uLg0KPj4+IA0KPj4+IEFnYWluLCBwbGVhc2UgaW1wbGVtZW50IHRoZSBkcml2ZXIgcHJvcGVy
bHksIG5vdCBkZWZpbmUgeW91ciBvd24NCj4+PiBjYXJ2ZW91dHMgZm9yIHRoZSBleHBlY3RlZCBi
ZWhhdmlvci4NCj4+IA0KPj4gQWNrLCBhbmQgYSBjbGFyaWZpY2F0aW9uIHF1ZXN0aW9uOiB0aGUg
ZGV2aWNlIGlzIG5vdCBhY3R1YWxseSBhYmxlIHRvDQo+PiBwbGF5IG11bHRpcGxlIGVmZmVjdHMg
YXQgb25jZS4gSW4gdGhhdCBjYXNlLCBkb2VzIHN0b3BwaW5nIGEgc3BlY2lmaWMNCj4+IGVmZmVj
dCBlbnRhaWwganVzdCBjYW5jZWxsaW5nIGFuIGVmZmVjdCBpbiB0aGUgcXVldWU/DQo+IA0KPiBJ
biB0aGlzIGNhc2UgSSBiZWxpZXZlIHRoZSBkZXZpY2Ugc2hvdWxkIGRlY2xhcmUgbWF4aW11bSBu
dW1iZXIgb2YNCj4gZWZmZWN0cyBhcyAxLiBVc2Vyc3BhY2UgaXMgc3VwcG9zZWQgdG8gZGV0ZXJt
aW5lIG1heGltdW0gbnVtYmVyIG9mDQo+IHNpbXVsdGFuZW91c2x5IHBsYXlhYmxlIGVmZmVjdHMg
YnkgaXNzdWluZyBFVklPQ0dFRkZFQ1RTIGlvY3RsIG9uIHRoZQ0KPiBjb3JyZXNwb25kaW5nIGV2
ZW50IGRldmljZS4NCg0KSXMgaXQgcG9zc2libGUgdG8gc3BlY2lmeSB0aGUgZGV2aWNl4oCZcyBt
YXhpbXVtIHNpbXVsdGFuZW91cyBlZmZlY3RzDQp3aXRob3V0IGFsc28gcmVzdHJpY3RpbmcgdGhl
IG51bWJlciBvZiBlZmZlY3RzIHRoZSB1c2VyIGNhbiB1cGxvYWQ/IEl0DQpsb29rcyBsaWtlIGJv
dGggYXJlIHRpZWQgdG8gZmYtPm1heF9lZmZlY3RzLg0KDQpCZXN0LA0KSmFtZXMNCg0K

