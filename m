Return-Path: <linux-kernel+bounces-99732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A8B878C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5850282C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E9B64A;
	Tue, 12 Mar 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PtKiPB/2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Qq+wpS77"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054988F45;
	Tue, 12 Mar 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207100; cv=fail; b=ggNZ9Lx9N5fyxf0QArCuziioUWXUcs52vMqRjU4lWKF1V5MRk9skgQf7MZjbyQ8ZsQiGWprY+B36lB4psvXaSMuEDJqJ+QRCvzk4uvU8FNlQsHfXtu2HulM+jou0chMyU5+x6AwSSHSO9wkcDPMuaouFIo2XskXZgwlhN9St4Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207100; c=relaxed/simple;
	bh=NwDl0vEHIivU23QkK29WrGMgN9uGZn0VOc3f9hOETds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O40/6xaOiD1sWy28so4T/Lky7Ll/gU9RX4Yz3iyDBlBVt1zQjUjUG89tuhFXsmx3tiPKElK763AT9kr/UpawwlA1Zys2rWsD9XjJnH0UAnojttBtzuCibRbTOhrN86m+zE6gB/qtt34UUFnXLFiPJ6L6fHHles6lukh9DTil4TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PtKiPB/2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Qq+wpS77; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3d32e15ae01011eeb8927bc1f75efef4-20240312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NwDl0vEHIivU23QkK29WrGMgN9uGZn0VOc3f9hOETds=;
	b=PtKiPB/2Q8GAyMpqnNGq6d0/g+400fLOo+CEOGtAOWlN00CFd0KlSThQI9rJW/3CLNmw+FHnj3ZN0G0HBK9sRvi8OqjESgxbU4+Fa9umhtaCZYjH7+EYCMcQ6ixNMRzLdG8K9zhf/ShB4KS3ArG4VdsanahQx4cKw7I0JEuJGRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:cddbc2c7-7ea6-46e4-9796-40b2ac75f5a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3f27e284-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3d32e15ae01011eeb8927bc1f75efef4-20240312
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1369306739; Tue, 12 Mar 2024 09:31:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Mar 2024 09:31:22 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Mar 2024 09:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctIRA4ss9Igcr5hOk7M2QS6gASKIO7NrznDf+la0Q0LPikNmTbEEwbZB5BvaZvh6wO9vGgiUni0dX4COdFT4snF+O3rSopG8BxTl2akWC/dvqn0+gL00jSLFqOx6q7PTV0uIExh3lFEjpKKC/AC/5e+9sr/Iug5m3haZRIjEbVGck5yQqQlU62WYPyDuXfiE753+X6B8XvVKkJ6jgri6yrF/1g1Izqe27a9v6Lof+YZAwNjn6SzOE8oBmi1EjZD5bV8DOEp9FwKM7v7L6jG3PyQUyW1kPcU8Dm5ihgE3/lZRfHU7RKW1ocHIS47V0rexoCb1ps6Bdk/uR7GIbBmubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwDl0vEHIivU23QkK29WrGMgN9uGZn0VOc3f9hOETds=;
 b=DYGtjP/hFoV+Eesnq7M5BbP0YSQKm9rzKgAg8A2+mFxBHUJuCjbnvdPUJFA4jYeib8wpcWV0P6g4VpjPacc+8akSZ4Q2fJCqnUkSRV4cX/S48RVFXSQo7m55Ghm1WNru82sry31lTb+wRGCqF4Lp+JgxuCJ6ZgykklyhSTujOS99Bm48kFP2IMRF9Owb8ei1vSUXE8YM8Cg9MXlZbmFIQ2vEEwRW1ePOEjAgK6FnuakxFTE4+OVgLYEPDu+88S5Eb0Idw5lEJjXw39pI/pq9BifE5urD0pE1k6q/zBRdCF30tJYiELZKVNwZD0x2UHprOyiVvusBTeSKbhvueDv6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwDl0vEHIivU23QkK29WrGMgN9uGZn0VOc3f9hOETds=;
 b=Qq+wpS77wYLJVhO/flMKGxR22VZMTlTtfWb7snzxJgxptpxvMfy/pNymYS1BPMFMPxPEJ7Tyym0QDjCRLDUXm1SJmcGTsCFmKJsRtI8F6aBu2LnyyVvrgB6XlzEG+J0r8K1KvdLr+K5Gh3+ez1QsKSdcmuxK0f2BgOdccONGi5k=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SG2PR03MB6538.apcprd03.prod.outlook.com (2603:1096:4:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 01:31:20 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 01:31:20 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "10572168@qq.com"
	<10572168@qq.com>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v7 0/2] media: i2c: Add support for GC08A3 sensor
Thread-Topic: [PATCH v7 0/2] media: i2c: Add support for GC08A3 sensor
Thread-Index: AQHabRItIdh6pUmyo0aIwkivbzCpALEzX9KA
Date: Tue, 12 Mar 2024 01:31:20 +0000
Message-ID: <983197a9531748d7a34a77ce0a74dd7f086e827a.camel@mediatek.com>
References: <20240303022609.26263-1-zhi.mao@mediatek.com>
In-Reply-To: <20240303022609.26263-1-zhi.mao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SG2PR03MB6538:EE_
x-ms-office365-filtering-correlation-id: 2397e95c-9439-4c8d-7656-08dc42341f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmpuRwjzhxO4m9WXgw450e0QVhJQDUGGMogik8ycp6TnapHm90yPCOMcuAuVWIrflhexXhElOI+CpRxgis+ZvukzL/CSrqCfIhZBewfZtdXI9bYP4q9mCaEo9rVEY9ELhaIBHTlsvcuHy5xPkSLYXYZakjbbgyllnVvw3iTt6QoPxTPXcV/NYTcxcqEGAVGyNockDh3t865PBE+BUX12BgzLqzCP1gTR/xoY3kVdFxxBYSuGJUUnfLJv+RZdxI9cIOJ7W44MKpv3ox2Xj8FULl0KO94gb4JQLO8NogAFL1QJ7RQaqJbvLfA6fzKVotl6P3O1cHfwe3zjLuO2grc2itLHwPih8R/OMZWf1/7YcfaFgu6yTuCyZGNVNzBBxtIxlRufkg789Lv+FVFJlpqM3tLD43lalaW/aMM7kNe5ewPBc/QTYNtcWoq7GQ4yWVI68EPutNpRPRkM54+4cMnw8c32y+wsZ0h+76HiSRYnePZFntahfZD6ogRrd6mwM6bVOGc2lmICr+OspzJCxo1ytzO2q0eWCjNLJzApd6bCyMX7IYq+wKN780OA2HY6P3uG9jvl+w2HLfJVG8ly7bkhxQuEj3KECWCpq4ns4EwBf6vYrDkPU/AY24TeLWq8K3qpgOkVxNe8HUAausSFFw/YDuTebk0eFUXtE2N+fl+Z6LsyL4qM2lEB81gy+59ZOTei
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnlValI3c2xDU1ljNmpYOEEvbFkvcDNrSDVvaTFyaGFJL3Jad0U3WHJ5YkJN?=
 =?utf-8?B?U2NJSzJFVUIxWm1rVTRRU2dzTWQ4Sk9lZytWNjhoQjUzYmhJeXlBTFl0blk3?=
 =?utf-8?B?QlljVjYwbW9aNmdVWjBHbUl6Um4yQXJNamJlOFQ3UWQ5T2kwSjJwQWdqWldv?=
 =?utf-8?B?M1BVaTJIYUJMc1dkcWc1L3lodDBJQXZQcGdkU3NoU1VWRkhDQ3VZMldsUDdt?=
 =?utf-8?B?anZ4UFdtdmIrblNyWlZyNTZmc3dLZjdIVzFiZHdNYVY0eTk4cTJwQ2pwTFln?=
 =?utf-8?B?b1FHRWRwSSt5U3JzcHJPNzlnVmxFdC9sK3YzbW5xYlIzeDhNTEpuQy81cEQy?=
 =?utf-8?B?eVpvNTM2NUFMSndFRUN1RDFGSFBlTlZyR3BMOTFlNDYyRDFGQi9HbzJDLzk3?=
 =?utf-8?B?ZFVaU0Z4Y1dRM3FLNkdYTElQL3BLdTFnclpRb0VONSt1NW1DZXlDM1dsMnNF?=
 =?utf-8?B?bUZSR2c0bERZVHVOSlNpNFU0WERwQk55dGNQb3lvU1NFcDNFM2xTNmJ1NWNC?=
 =?utf-8?B?MkNqQmx3dEM2bXQ2UnBhdGNQbENhRHNCNEdpcEdWbmxFUndYTm5ZaFI0UlQ0?=
 =?utf-8?B?djE1Yld6MlM2VDBXRUpldW5lU3lMU1E3a0YzNmhBU1U1c3dMUm9vNUtMREhn?=
 =?utf-8?B?WnRqUjVGdm03SnFTOXRyWkd2eEV4bk9JRHozanNpQUtjVngxYWJEdHk3UXZ3?=
 =?utf-8?B?aU1RYnk3VnVsNUZPcElWd0FFM0svemJpY3ZHWTMwbWh0RkJSU0t6bDJoUjVs?=
 =?utf-8?B?QlM4SU9VT09MMVJFL1BuSFpOSU4wUWNsSUpzT0RLM2I3a3lqSkpGYStLeGNI?=
 =?utf-8?B?SHNSMUI3UkhYdE1CQTNuRk1uWDZTZ0ttV3pBbWV5Q2NPV28xMVJsLy8vZHFR?=
 =?utf-8?B?d3dpR1lpN09RMWlZb1l4WElDU08zYm02TXg3QTNZbkkxcEJaZG4zSnMwL0tC?=
 =?utf-8?B?WE1naUFHZU1WaFJlcWU1MWVxNmRUd29hZllucUtOUkhTZndSU2JZVjlWdDVL?=
 =?utf-8?B?VjFNbEhFR1lTekxXd1B0S1lGSTVCUTNLT1Ewck1Ub1l0ZDVRQk1qOUVsQXFk?=
 =?utf-8?B?VElyTnZlS1NVWUZ3dEhoZ0FPU2NrUW1FekJNeE5pdlZXbXhCbXI2cTF5UFMw?=
 =?utf-8?B?R3pQaGlWZkxPNjVYa0MvUVdaVGFVdjdid3BqaWU2S05SWHhiZDRzWUxseGJi?=
 =?utf-8?B?eGt6WjZGbjlvc254SE02RS9qcnEvSnJBODFuekJMMVNickdYdHZ6a3pOaE5B?=
 =?utf-8?B?Mk9JdUpreSt3NUN1QXNjL2drVWlvLys0TTRQcUprK3BDd0VtVGlaSmVKOXBI?=
 =?utf-8?B?ZDVmN3dNZWs3ZnZPNG4xaGpzZXZEMXNtL2s0R0Q4TndRcFFDN2IvTUUzSWZF?=
 =?utf-8?B?dmIwcHhVdVFKU01LQm1rSmg5ekd3M1RWWHZML0VIQXdmNmhDcDNtZTF6WERS?=
 =?utf-8?B?SUNwZWZZdTJJc0xpNE8vL0JjTEczUHRDb2R6SHNUeExoejQwK2ZldFM4dmkw?=
 =?utf-8?B?RWF0bVQ5T3R0a1VzbDErb0h5bW1OR2lxakgza25sZFJHWGUxWERUQ0lya0dr?=
 =?utf-8?B?WDBCS2ZWUzZlMDgrTTRVUWVSNTdMMHlKaUdPRDcvYXlvanpaWktTM2ROWE1W?=
 =?utf-8?B?MXF4eVVvUTdRQzZ4REwrNW80NXMxYno2S0xJWmdzL1pRQWVjOVZBMW5YVHpB?=
 =?utf-8?B?YmhHL1M0emJQTGFQZ0VibTVlbi9zUm51bHNZNlNYcEtJdHpQNXdPRmkzeEQy?=
 =?utf-8?B?VWgzLzdNU0ZKYytqS2tSaStsaEtKd1lBL1ZIWkhjT2lOTlZwRXBGTURoSDcy?=
 =?utf-8?B?c2dQZGZGSVdqQ2xKMnQ3Z3hQcmlUTlAzbjZmL1YyR2JHc3V5N0YyR2lFRHVo?=
 =?utf-8?B?dHRpeTNTZ1VaL3BrcEZKaEdvaFpNdTZsMEp1YTFkdFlucGRWbWlaRmxrQk4w?=
 =?utf-8?B?L3BaOFFyUTl2V05QQnFIOEZ1VDhzTjU3YW10L3ZaempxalhLNFRSZXllUUVJ?=
 =?utf-8?B?TTBCdW9YNDY2N1FwbUZza215MjBRU25uWTJ6NGx2aW5nUThyVmZxSFliWWFi?=
 =?utf-8?B?Y1E4Sk9BUUl4cVJ2RTlIWGhSWkdoYmgwcitlWUl6aDhDZlF3Z25pNkJZbytG?=
 =?utf-8?B?TGRtR3hwM3NvSDNKK0tyYVZIZnBuUzB0SFZQOWdzdEViZW94Zi8wdWVYYUhN?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C96E33B2923D4B86349CFA6DD67676@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2397e95c-9439-4c8d-7656-08dc42341f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 01:31:20.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDf0FWKQEzJ9qdsYTOX7GZ/IMzJQ+kFd4xjJXknKla8a+Z4QAHxspVlzSAPXOGLp34slmQ/2rLvpsmrNRAbmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6538
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.642200-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4gPZZctd3P4BjLOy13Cgb4+qvcIF1TcLYG9z
	j16rJNcqrKfV8wugdrDBdc9OAQl+e1bpry0uquBQEPf7TDUOGopozho8K1gAGu8amKDrnhAvika
	0Ka6FTuuR/a+7CkNPgsr5AVdin4a1H0nltmolsgmEryjhqiyzyn+vzHfC29pfNSweOixQAJKozw
	9gka4dikltRjALUF+x0Orw/09zAN43Pdqtj2tcMdT4WBm7SuAOUAjrAJWsTe/xxaAXDrCns8Trc
	lOEW8K1UyClodf9Qow6uauFPPtNZao+znd4MHO5dARARTk4h599LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8SAHAopEd76vXNloowj4saw4UHyh4+AAwi7gwdTydvcF5r/aps4ibmxoTPL
	BOmNJTQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.642200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	25F0ECAC290E587376B134231220B0CBF1257D87E73C3BC608C2B5DD5F537E862000:8

cGluZy4uLg0KDQpPbiBTdW4sIDIwMjQtMDMtMDMgYXQgMTA6MjYgKzA4MDAsIFpoaSBNYW8gd3Jv
dGU6DQo+IFRoaXMgc2VyaWVzIGFkZHMgWUFNTCBEVCBiaW5kaW5nIGFuZCBWNEwyIHN1Yi1kZXZp
Y2UgZHJpdmVyIGZvcg0KPiBHYWxheHljb3JlJ3MNCj4gR0MwOEEzIDgtbWVnYXBpeGVsIDEwLWJp
dCBSQVcgQ01PUyAxLzQiIHNlbnNvciwgd2l0aCBhbiBNSVBJIENTSS0yDQo+IGltYWdlIGRhdGEN
Cj4gaW50ZXJmYWNlIGFuZCB0aGUgSTJDIGNvbnRyb2wgYnVzLg0KPiANCj4gVGhlIGRyaXZlciBp
cyBpbXBsZW1lbnRlZCB3aXRoIFY0TDIgZnJhbWV3b3JrLg0KPiAgLSBBc3luYyByZWdpc3RlcmVk
IGFzIGEgVjRMMiBzdWItZGV2aWNlLg0KPiAgLSBBcyB0aGUgZmlyc3QgY29tcG9uZW50IG9mIGNh
bWVyYSBzeXN0ZW0gaW5jbHVkaW5nIFNlbmluZiwgSVNQDQo+IHBpcGVsaW5lLg0KPiAgLSBBIG1l
ZGlhIGVudGl0eSB0aGF0IHByb3ZpZGVzIG9uZSBzb3VyY2UgcGFkIGluIGNvbW1vbi4NCj4gIC0g
VXNlZCBpbiBjYW1lcmEgZmVhdHVyZXMgb24gQ2hyb21lT1MgYXBwbGljYXRpb24uDQo+IA0KPiBB
bHNvIHRoaXMgZHJpdmVyIHN1cHBvcnRzIGZvbGxvd2luZyBmZWF0dXJlczoNCj4gIC0gbWFudWFs
IGV4cG9zdXJlIGFuZCBhbmFsb2cgZ2FpbiBjb250cm9sIHN1cHBvcnQNCj4gIC0gdmVydGljYWwg
YmxhbmtpbmcgY29udHJvbCBzdXBwb3J0DQo+ICAtIHRlc3QgcGF0dGVybiBzdXBwb3J0DQo+ICAt
IG1lZGlhIGNvbnRyb2xsZXIgc3VwcG9ydA0KPiAgLSBydW50aW1lIFBNIHN1cHBvcnQNCj4gIC0g
c3VwcG9ydCByZXNvbHV0aW9uOiAzMjY0eDI0NDhAMzBmcHMsIDE5MjB4MTA4MEA2MGZwcw0KPiAN
Cj4gUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhpcyBwYXRjaC1zZXQgY2FuIGJlIGZvdW5kIGhlcmU6
DQo+IHY2OiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWEvMjAyNDAyMjcw
MTMyMjEuMjE1MTItMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCj4gdjU6IA0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tZWRpYS8yMDI0MDIyMDAxMjU0MC4xMDYwNy0xLXpoaS5tYW9A
bWVkaWF0ZWsuY29tLw0KPiB2NDogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1l
ZGlhLzIwMjQwMjA0MDYxNTM4LjIxMDUtMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCj4gdjM6IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tZWRpYS8yMDI0MDEwOTAyMjcxNS4zMDI3
OC0xLXpoaS5tYW9AbWVkaWF0ZWsuY29tLw0KPiB2MjogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW1lZGlhLzIwMjMxMjA3MDUyMDE2LjI1OTU0LTEtemhpLm1hb0BtZWRpYXRlay5j
b20vDQo+IHYxOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWEvMjAyMzEx
MjMxMTUxMDQuMzIwOTQtMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCj4gDQo+IFRoaXMgc2VyaWVz
IGlzIGJhc2VkIG9uIGxpbnV4LW5leHQsIHRhZzogbmV4dC0yMDI0MDIyOQ0KPiBDaGFuZ2VzIGlu
IHY3Og0KPiAtIGdjMDhhMyBzZW5zb3IgZHJpdmVyOg0KPiAtLSByZWZpbmUgaGVhZGVyIGZpbGVz
IGluIGRyaXZlciBjb2RlIGZvbGxvdyBpd3l1IHJ1bGVzDQo+IC0tIG1vZGlmeSBzb21lIGNvbW1l
dHMgdG8gbWF0Y2ggY29kZSBzdHlsZSBhbmQgZW5nbGlzaCBncmFtbWFyIGFuZA0KPiBwdW5jdHVh
dGlvbg0KPiAtLSB1c2UgdGhlIGRlZmF1bHQgY2FzZSBmb3IgYXNzaWduIHZhcmlhYmxlIGluIGZ1
bmN0aW9uOg0KPiBnYzA4YTNfdGVzdF9wYXR0ZXJuDQo+IC0tIHVzZSBERUZJTkVfKiBQTSBtYWNy
byBmb3IgcnVudGltZSBwbSBvcHMNCj4gDQo+IFRoYW5rcw0KPiANCj4gWmhpIE1hbyAoMik6DQo+
ICAgbWVkaWE6IGR0LWJpbmRpbmdzOiBpMmM6IGFkZCBHYWxheHlDb3JlIEdDMDhBMyBpbWFnZSBz
ZW5zb3INCj4gICBtZWRpYTogaTJjOiBBZGQgR0MwOEEzIGltYWdlIHNlbnNvciBkcml2ZXINCj4g
DQo+ICAuLi4vYmluZGluZ3MvbWVkaWEvaTJjL2dhbGF4eWNvcmUsZ2MwOGEzLnlhbWwgfCAgMTEy
ICsrDQo+ICBkcml2ZXJzL21lZGlhL2kyYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAg
IDEwICsNCj4gIGRyaXZlcnMvbWVkaWEvaTJjL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8
ICAgIDEgKw0KPiAgZHJpdmVycy9tZWRpYS9pMmMvZ2MwOGEzLmMgICAgICAgICAgICAgICAgICAg
IHwgMTMzOQ0KPiArKysrKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNDYyIGlu
c2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVkaWEvaTJjL2dhbGF4eWNvcmUsZ2MwOGEzLnlhbWwNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYw0KPiANCg==

