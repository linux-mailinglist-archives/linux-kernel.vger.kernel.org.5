Return-Path: <linux-kernel+bounces-84465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76986A718
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742EF2837C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749C1E87F;
	Wed, 28 Feb 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XPo+5DF+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TKsADhGl"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC34400;
	Wed, 28 Feb 2024 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090360; cv=fail; b=Mh4YGyyEtqCIN0stUKSYp7KY7laCrDkXTdRF70Gxnn6UoYnlj8PlZsrWLZVy8kN4SGR2LVB4+UXMZEfquAw93I3aHgHzEonGxKeWm3LJtnhT+OQB8+ACR9LXHdxMs8gqIW5XNLZrH0TQxVcxPU/zFHoCmeyw2O6+dGpy+BITb50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090360; c=relaxed/simple;
	bh=EoePiGgy56lC8x/SHAdI1SVvOdzSRKBrtznAKcWbMro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=id8VdsqEFya1+ap9Sj15xNB5Sb/Z+VuFAVbWAEdTfoSoOCjDxmCe6rUY/Zo5Udo8frsFKiZTsAxg05FF4OENk5T7g8rVLtI89exgb2GtALL7hlXQi2ER/lajlBYpwZ5ImjkV7bkv/rLIS4lPtrR0bWDeMH0C0X8RZYdY/7yBkVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XPo+5DF+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TKsADhGl; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 249e3ab8d5e811eeb8927bc1f75efef4-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EoePiGgy56lC8x/SHAdI1SVvOdzSRKBrtznAKcWbMro=;
	b=XPo+5DF+Iol0nuRTwDxs9daYIiZBxHslvjUMLxCBTg5ObZ6AiQfPWO0kPAR9N9HrMuY02rzsrh8VJFupPr2dJCtO9Yv4z2XYngRs3OkocGg+P6HngEEjo4E1jOSRBcX4uezl73bGPi+R/ovYws9gkcbLuXMvsgjA61Ea481e2Hg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6395a26d-2b1d-4dfd-870b-eecb4d691220,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:61facb8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 249e3ab8d5e811eeb8927bc1f75efef4-20240228
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1129982982; Wed, 28 Feb 2024 11:19:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 11:19:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 11:19:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9nWuHJHyCi6+698ZH7WGxPtby1haqzOlfGsvpl+SZ2SGYwcX3kutPlFM+ZWRo0D1lxlZUVWKrgkMwG/vX147/7lKEu8R6NRv158+jO5WBHEavAlgGPruseRyy4IcyTMnRv7Udmi6Kl/KtfVpRTmx6KzkVSfsOM9oFEaoDfkpw7jLXpZu9AyYID5NF8NcidJCjoPFoNY7P8J77nUc9q3m2ZjZqr8pW1yHvTg2ZUK7KhwgU/agX34PTD+w6XrX5CQHbnmAQN3nHMqYmPmR4bO40LpaKj24PPYJeCj8iFJVCtYZfbv44djL8oDFP0lMGKQDClyWGmpji9hb/pOk8WGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoePiGgy56lC8x/SHAdI1SVvOdzSRKBrtznAKcWbMro=;
 b=XXltoEHkCj0F0an4akgT9c/d0ptQQInmk8UrX9SHbaXv52mU11SxaolJAJBNXCbGKh2xO46WSgFYGsNUuU9r+ukNMntgVOKyZE77yPRNYWuwqT2mJTmdNIzSE80I3VdlSIBWbQ6D3huCi8yzSSn++tMN4nlM/1HvuNKr2bUCp4F9wzfu6AsXbQpyOW13ngK6WywyyIq1TdrmzPj5T/qx0iZQFFo/OLQa6g+yXYNGScST/DutSsZrob0s3VL6zdlD8vzCk19ho8T/tgyflzU3W0LdA3G0LniRSAyynotl5DQcy0Dkoev4mbwGwOOodqfqXEs0cZh+0+REWyHDN4DchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoePiGgy56lC8x/SHAdI1SVvOdzSRKBrtznAKcWbMro=;
 b=TKsADhGlUCpJcK0G1JdsmzsCfCgp1siZdEE+rcTsE37G+0OxT3LhuFNEaxMbX5pfzhtM53S0jejIqzHw9GbGJpo6aJcSKOXE+o5EDgesmWyk2Hd0hCaVR7gGmBg2DAOrf01e4jSNfLs8v2KdjjUxLPEQ7oclaOFS5YnklfOgjA0=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYUPR03MB7087.apcprd03.prod.outlook.com (2603:1096:400:357::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 03:19:07 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 03:19:07 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "10572168@qq.com"
	<10572168@qq.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaaR0Dr2G8OwgcZUiafwf4WUg7y7EeI9sAgADzsAA=
Date: Wed, 28 Feb 2024 03:19:07 +0000
Message-ID: <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
References: <20240227013221.21512-1-zhi.mao@mediatek.com>
	 <20240227013221.21512-3-zhi.mao@mediatek.com>
	 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
In-Reply-To: <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYUPR03MB7087:EE_
x-ms-office365-filtering-correlation-id: 7ddb1c1a-02c8-4483-7b44-08dc380c064a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+uEyb4en0IwNAW09n3+alOYLEsva1QEz7/R6kvBI575fE+m064FqPdKjmDVJkAQB4s30brbXWIwW7FqnpHD76mQVfVYFGTDgTbhmiqrlMChS2LTa0LcqB6506UQ9X3Q1PCJ2Luq4/Z7+3xL8Xw/wul0rqrlMAWBccg7CNm8FxH0RABsy5xyiPfsn4U1KjxLuZ2EfZU22mBnRv90Lu02cIgOOgKVDmOzC33M5rbVWwwW6dHV/YauptmOC4dhJNrg672Xn5rul3CI8QDGpmYndm1z822NCZxlKJg8g+quaTOWKNSIhWYnK7XAUnqe6EFw342fnUxQPVEFQ4Ls2HRNBY90mgNZJBM8w1lFFQ7P88R9CnlrjwGWUFi7l+aWhLEf5vxV0yIYF+lFFuShS+vKUJxF3+Y5BMfjKNtv5w+jUj11e2DBffkLH9w0WD1Xd5Gm+N9hgajxOloHKiav1J0r3FljZANhuTMi0bq6NcuZBTUjfXN6YmxhNPoB2KppSGDBmQEKWegbfiKQv30wDryYDObA717HGCABilEm1myhhyAn1qFRKjCBhQBJmK6oC/rJF2LFWsDYNT9DI4YMV3xjwy0+Z1HEVHsC4NIMdDAMiiN5xRI2iSv3MBErDNrmtflFwE+YVC4vGfEoR1IZw3Ig2pZpD/fUmImwOJFO+N9NOlEyNoCCOE4+et4u3ZtLvwj82THhA5OQIlgdmJun5tvGMRGuZ46vxo64qmokFYSpi0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVqcnR0Q3I4NjFFSUw4dGJ6Q0JqZnVHcHo4U05pV095bDVQcVEyUEhNZlUv?=
 =?utf-8?B?eHZGakxkM2JDMC82cjlxTmVFRVoyRSthTC9oc2l4aFdUVHd0clJ0bmdzRW1C?=
 =?utf-8?B?ZDJwY3puVk1iNEl3d2diTWxVS2VtNU4wdlNVdHl1OXBCYzRpaEl5TGt1Z2d5?=
 =?utf-8?B?OU9oSDVsOVZmaCt6eWlTeHVQTC9RYzZ6RzByVHdHR1cyVFBXMUcraTJhNXVK?=
 =?utf-8?B?SE13azUzcmxTdU1ySk04bWtiNVJRNGhUVHljQ0NGRGtOQjZ6N1lFS0hmaHhS?=
 =?utf-8?B?b0xuOWhtdlpKTmF2TlVSd3hTRzlQeE1xQXd6TjRXSFBjRGhDd2l0RW9hZFZT?=
 =?utf-8?B?VFJjdW1kOE45ZDVmUzZOK2Q1QllzMEZQZHc4RlRTNjJtU1c5VWloYURxZVBB?=
 =?utf-8?B?bm4xK2diUVBNNHErK3FPbU1VSVhYMnEvQ0t5WWRubFcrRE5KUW5SaXVNMUFE?=
 =?utf-8?B?TnQ4em5JM1paOGpvTHpSZlBBK09iWXVIR21JNEl2TGV1Q20wZ2Y1WHVWS2VT?=
 =?utf-8?B?YzJkcHRheFpBeGtIN2oxM21xWXF4OUpUZ1hndWtJb25hMWIvZ2lFazJPc25B?=
 =?utf-8?B?ZzNLTmZ0Z1oyWHRFdGNZRXZKcDVJU2pBamtUdis3TzJuaGZyT2hqbmdERmZL?=
 =?utf-8?B?T2lKd2daQlBwUlFDMUkxdEQvcGZpZ1pPVytjSi8wSlliWFRkSmJVUTdocmhH?=
 =?utf-8?B?MVMyY1NJTGhwR1E0bFJvVDNqZlhFSGE3Slo2WnRmT2g1MkZYVjBwcmtRcXpz?=
 =?utf-8?B?OU1Ja1d4Q2UwZXV0VVZKeHFEdkh1R0tqTXBNVXZNREN6Zld5czJTZGZ4MmpN?=
 =?utf-8?B?aks0V2lINlZzd292MWVqMzlwOFk2QTArR0lwM0htRXhvOFcxSlgxc1FTYVFQ?=
 =?utf-8?B?Z2pNanh2VWtkeERVWVUxZHQ0bVM4bHl6NlBLb0NKYW1HbGs0VzYxMThkSVRq?=
 =?utf-8?B?M2RpWGtsQ01yMlQ5MjhpUzhjRThSNmQ5a0ptUkN1dkMwUTFRUXpMeTExd3lU?=
 =?utf-8?B?NjZXUXlOeUVDS2ZRQVRnTnZKSUFoWmdobVVUTDZsLy9UYTlIbVlORERtK0JV?=
 =?utf-8?B?emdoVEJZMDdnRGoxc2JlTDV6YTFCRlNtcVdQeUdkYVhmM0dGdmMrRzRKZUk5?=
 =?utf-8?B?aTNxVGg4N2pEZEhHcEgyd2FtMnZRd3ZMNnVSRGlRVFRkdzJpdU5FVkRmNitN?=
 =?utf-8?B?NDNRK0xmRER6Y1YyeFZJUFVqazcwbU9rc0xvZjRmL3JWVVhIU3hWSlg2Vysv?=
 =?utf-8?B?ajZzaTV3dEd3R0ZsNCtzcllnZ0pWRkRIR0Mrbmg4TUlENW5adkZLTGFuUno1?=
 =?utf-8?B?elRIcmJCNkpLamhNdE0yNmdnYkZOWnBoL09jclN1MW1hdjhabWRNdzdYSXk5?=
 =?utf-8?B?eTRZQnB6RXFrczRZVXlSVDE1bjBuWSsyaDdnQUdabHh3RFltb2gySUlxakJ0?=
 =?utf-8?B?ZmZScnZQNUY1V3FiQXBZV2daejJBeHV3eVYwZUhkVjYvNUlrVFh4WElUeHV4?=
 =?utf-8?B?UnFycHA1bjczV2h4aU5OeFNQYVNNQ2Q4dEFMYVdZQXVkNHlqZ044eG1FWUlj?=
 =?utf-8?B?Nkp0MThoRWhqcXNva2ZKa2pvNUpyQkIvdUNrMmtDZVYwcUpwbGRnQzJhSGRi?=
 =?utf-8?B?YnIyUTZNcUpBbFU5ek9iVTFkZ1dneTJISUtlTjRNVWlocTk0NUFPOUhld2Fj?=
 =?utf-8?B?VnJpdUZyK3RRZXZlcU5BUEZCS0RzRjByQ1hFY0ttcS9LRUtrbklhL2k1TERU?=
 =?utf-8?B?KzQ3aUpoNWV0dWtyQ3o3cUFyY3MvRjhrNkRmeXYwblk2TEtyaURhUUdVSUt0?=
 =?utf-8?B?V0JoLzh1aEgvQkxTZG5pUm50bEhYRmpmNnA4UzEvVXNSaXVnQ05EeStCdXl2?=
 =?utf-8?B?cGQzWVJ6V09wMkZYY3lPMWdSMWJ0Q2pVRnRjVi91NzVsbjVOSlpGcmZnOGpw?=
 =?utf-8?B?Z0FEVWpCTFpJKzFjN1hVMytYMDVlMUJya3pSSXFKZHRSd0JKNHJ6T25uTTNZ?=
 =?utf-8?B?c1ZnNFQvaklLUUlYcklIYTFseExCeTU2Wnp2d3Avd0lxRHlXbG5aRTBBZTVB?=
 =?utf-8?B?VGlicHNvSGc3RFE3R3A1ZnFwK244eVArMXY1dWJQQzBCUCszQ0piYVdvM0lX?=
 =?utf-8?B?ODhySi9BbFhDVTZIb2ZEc0ovd2pRNmhJOEc3M0xWdHFMTGk5RU96V0tZRm9y?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19496F76B2DD1F42AEC44D271F42122B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb1c1a-02c8-4483-7b44-08dc380c064a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 03:19:07.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cigkdDVIgjxgS1HVD9VylHh+aFFcpU1shAar0TxL1c5WqdODmqMwSqt7ciJJsva3SBoau3at/gR03JqP1JeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7087

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gVHVlLCAyMDI0LTAyLTI3
IGF0IDE0OjQ2ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAg
T24gVHVlLCBGZWIgMjcsIDIwMjQgYXQgMzozM+KAr0FNIFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBhIFY0TDIgc3ViLWRldmljZSBkcml2ZXIg
Zm9yIEdhbGF4eWNvcmUgR0MwOEEzIGltYWdlIHNlbnNvci4NCj4gDQo+IC4uLg0KPiANCj4gDQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9wbV9ydW50aW1lLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3Vt
ZXIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3VuaXRzLmg+DQo+IA0KPiBUaGlzIGlzIGEgc2Vt
aS1yYW5kb20gbGlzdCBvZiBpbmNsdXNpb25zLiBQbGVhc2UsIGZvbGxvdyB0aGUgSVdZVQ0KPiAo
SW5jbHVkZSBXaGF0IFlvdSBVc2UpIHByaW5jaXBsZS4gKkF0IGxlYXN0KiB0aGlzIGxpc3QgbWlz
c2VzIHRoZQ0KPiBmb2xsb3dpbmc6ICBhcnJheV9zaXplLmgsIGJpdHMuaCwgY29udGFpbmVyX29m
LmgsIGRldmljZS5oLCBlcnIuaCwNCj4gaTJjLmgsIG1hdGg2NC5oLCBtb2R1bGUuaCwgbW9kX2Rl
dmljZXRhYmxlLmgsIHByb3BlcnR5LmgsIHR5cGVzLmguDQo+IA0KPiAuLi4NCkFmdGVyIGNoZWNr
aW5nIHRoZXNlIGhlYWRlciBmaWxlcywgd2UgZmluZDoNCjEuImNvbnRhaW5lcl9vZi5oIiBpcyBp
bmNsdWRlZCBieSAibWVkaWEtZW50aXR5LmgiLCB3aGlsZSAibWVkaWEtDQplbnRpdHkuaCIgaXMg
aW5jdWxkZWQgYnkgInY0bDItc3ViZGV2LmgiDQoyLiJkZXZpY2UuaCIgaXMgaW5jbHVkZWQgYnkg
djRsMi1kZXYuaCwgd2hpbGUgInY0bDItZGV2LmgiIGlzIGluY3VsZGVkDQpieSAidjRsMi1zdWJk
ZXYuaCINCjMuInR5cGVzLmgiIGlzIGluY2xkZWQgYnkgInY0bDItY2NpLmgiDQo0LnJlbWFpbmlu
ZyBoZWFkZXIgZmlsZXMgd2hpY2ggbWVudGlvbmVkIGFib3ZlIGFyZSBhbHNvIHNpbWlsYXIsIHRo
ZXkNCmJ5IHNvbWUgb3RoZXIgaGVhZGVyIGZpbGVzDQpJIHRoaW5rIHdlIGp1c3QgbmVlZCBpbmNs
dWRlIHRob3NlIG5lY2Vzc2FyeSBoZWFkZXIgZmlsZXMoc3VjaCBhcw0KInY0bDItc3ViZGV2Lmgi
LyJ2NGwyLWNjaS5oIi4uLikgaW4gc2Vuc29yIGRyaXZlci4gDQpJZiB3ZSBhZGQgdGhlc2UgaGVh
ZGVyIGZpbGVzIHdoaWNoIG1lbnRpb25lZCBhYm92ZSwgSSBhbSBhZnJhaWQgaXQgd2lsbA0KY2F1
c2UgInJlcGVhdGVkIGluY2x1c2lvbiBoZWFkZXIgZmlsZSIgaXNzdWUuDQpBcyB0aGlzIGRyaXZl
ciBjb2RlIGNhbiBiZSBjb21waWxlZCBwYXNzLCBzbyB0aGVyZSBpcyBub3QgbWlzcyBhbnkNCmhl
YWRlciBmaWxlcy4NCkFub3RoZXIsIEkgYWxzbyByZXZpZXdlZCBzb21lIG90aGVyIHNlbnNvciBk
cml2ZXIgY29kZShzdWNoIGFzDQpnYzBhMDgvZ2MyMTQ1IGFuZCBpbXgvb3YpLCB0aGV5IGFyZSBh
bGwgdGhlIHNhbWUuDQpDYW4gd2Uga2VlcCB0aGlzIGNvZGluZyBzdHlsZSBhbmQgZm9sbG93IHdp
dGggbW9zdCBvZiB0aG9zZSANCmltYWdlIHNlbnNvciBkcml2ZXI/DQoNCj4gDQo+IC4uLg0KPiAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGdjMDhhM19wbV9vcHMgPSB7DQo+
ID4gKyAgICAgICBSVU5USU1FX1BNX09QUyhnYzA4YTNfcG93ZXJfb2ZmLCBnYzA4YTNfcG93ZXJf
b24sIE5VTEwpDQo+ID4gK307DQo+IA0KPiBUaGVyZSBpcyBhIERFRklORV8qIFBNIG1hY3JvLCB1
c2UgaXQuDQo+IA0Kc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BNX09QUyhnYzA4YTNfcG1fb3Bz
LA0KCQkJCWdjMDhhM19wb3dlcl9vZmYsDQoJCQkJZ2MwOGEzX3Bvd2VyX29uKTsNCkRvIHlvdSBt
ZWFuLCB3ZSBzaG91bGUgdXNlIHRoaXMgTWFjcm8/IA0KPiAuLi4NCj4gDQo+IA0KPiANCj4gLS0g
DQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==

