Return-Path: <linux-kernel+bounces-122449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47088F7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D10B22A98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104944EB36;
	Thu, 28 Mar 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OImOxEOh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qIdrZ4UF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9892C85C;
	Thu, 28 Mar 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605990; cv=fail; b=l0ocoqvZk0n7rAK/Xg1oa+J48czrONATru0D0wapUfVAGzlKSiTFR8VcbWLfRdpYNqWqZFxJNb8ZYY968x37VN1A3WOc4hMBaS5YwNtS+rOcE9tiuO8BFOxUzG65pFsAw6hwvsZrSL61MKw0dByIyZqGNxdf9SU0eqxIBsqNvIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605990; c=relaxed/simple;
	bh=WlBYV11YkztUS8itDelIsUL4Ob+PPe3QeEgK13/W4YA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzzAc+0t0xMWr0sOdeYSBI2yHoot+6QeAuGWXm48zz9OLVrR9MiNWVtzVYrIruRGhXfDAzN9pIe/cn0671HBV7WbHa8GC08D7bnVklYw7e5+/3js3LSUd4MK2BRSCCPgk6MD+7x2O+tvwly++dGbRTbt7qZ+JGMNaJUyMCUjL0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OImOxEOh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qIdrZ4UF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4c4c9d0aecc911eeb8927bc1f75efef4-20240328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WlBYV11YkztUS8itDelIsUL4Ob+PPe3QeEgK13/W4YA=;
	b=OImOxEOhvq7WnFIxWP2IIugH+R6uLdwBDZWFBPvRhHTKmfTbYYKOMwI7Q2CQogEMaN/c/3TkspIGCUUsV9lGIUQTyzKUOiVbk4vceSL1+PkJ6ZemzEen+7cDtsTEtBnxdnamNCavFS30MSKc5EFh0dFrG99NDpCjuajrFxmPu3Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:aac56df3-63dc-4948-87dd-f2df54ab70c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:71256c00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4c4c9d0aecc911eeb8927bc1f75efef4-20240328
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 693267831; Thu, 28 Mar 2024 14:06:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Mar 2024 14:06:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Mar 2024 14:06:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+e0fn93ts4nV8SmyUnjOm6XX/1vaOi0DRDgKEtZC8ba9sVGxdeImrg9xx+5fDu5xhqE+4KcImg654oREdqswdNOSdthcqvRifOfOzgf/hIT6FGex3nkAXoj+I/pHoSuaBs6ZHmvXbzbTuaUMNmUMpZF5Oi9qMRJ90zToJRWD3vLnwdHyds6GPkzrupO9dHrv8yzGDQG/dSbmYxOQNkr2pwbrV8KLR7nPnR/8ncv2PXsitPhF4Wm3kftigPyDoCsXxmXTC0DZMpTVYsGXsnYtRk69Wt7Dp7q0lSHB6/0G/8ZNYIxTHz5rUI7qRSnf2UJr2CfsDpoI9lYCSodpzH9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlBYV11YkztUS8itDelIsUL4Ob+PPe3QeEgK13/W4YA=;
 b=GRPNArtaQdyE5/HMr0megMyqcjCRufzKxS/nXpru+qJurLFGUr1VbjcJWwNiD7DjLikubjK+rT1BP4PIfdYP9CAws/OF17CLqidEy4TVQxyxINLOpwyBSuXEbQCZASguqNQ26Flqd7AxRHwLlbTTKXCkKeMPDVQYhiQDwd6+4SynFYlBv0JTap09WFOLIM/4eWKJQjooUKq0vh4jRi6QydhhckBe7PFxyBJIyz9x2Ty674YbeqhRd5Su07Nx/QCvILMpCyCPPJHhOBcSzPr9VEcxE6c2jjTtMOgezA7JcsHdrgXUIKD3hLJ+C0eUCoZFYPNTGW2kSD3/RYCtNBkWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlBYV11YkztUS8itDelIsUL4Ob+PPe3QeEgK13/W4YA=;
 b=qIdrZ4UF97UavV/ErxF+LC8UDhs/56GDdp7EllAMD+N7wAVsTNGUz3V1CEf/a5AtXRWxuYKoIZFwUGv6cS30HxzBlb74n0b+1lYGTpykGvr7CNngfJT3oxVmZxOIWqkK0IQ1eOSmDeMxR1M+uPONnwroJWXSiL744zzVnkFkNdQ=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by TYZPR03MB7154.apcprd03.prod.outlook.com (2603:1096:400:342::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:06:16 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:06:16 +0000
From: =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>
To: "amergnat@baylibre.com" <amergnat@baylibre.com>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	=?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, =?utf-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?=
	<Xiufeng.Li@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Topic: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAMHwCAAAMVAIAABykAgAALJYCAAAEjgIAAA36AgAACP4CAAA48AIABMNGA
Date: Thu, 28 Mar 2024 06:06:16 +0000
Message-ID: <3b04c5344435cdb941b5d132e8f5fbfdf9188d67.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
	 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
	 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
	 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
	 <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
	 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
	 <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
	 <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
	 <CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com>
In-Reply-To: <CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|TYZPR03MB7154:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhZnZYMkpGkdjCxGyXu8XeXifgTfsdYAr98xjZWNffp3v9U5qD1uC5g0prbF/SaikcgV4otCZmDUTp8PNNQGHbh+49GOM7opEBzT4yWuCeYHaeTQ8G4SevQWl2OLrivJJiR0lUPAevVXEq7etHaq67hehU6fabHcF0Mg/+leEG9BIDOqmUcz/ByLwrDPqx8h6T5vzbCeZuaoGg8ELvp/zKGqGQR7A3Qxobk0YSdPYzSCV6SezQ0IsX2GMuNGbhrXK6bPUuH+qmEaIGAtSRbOCgpX32/hvuBsx6g5bQAM0NsFc1O5IpSa8eaBSjAYwVyQpFS0t0Xn3BYzN0zzux2j9254HHPkiNJmblCX8XyHQRtduCrjjRtnrZ5zomkQkhK8UTh0LmQqRLNsMAfuO4KP6Afl7v9WYn/OAwbQNyBTMg5o/RVtpnqoRCWmWHipXWEV5z4APopoCVjBqokIHn5U1f9p87MPiFl+5A0Y0hIRxbSIggU2asMTN5MCASIYrkemWW9j3NYokiTwbzv5NGa0KmwJJWVC5al8dMhU0zVJCDPY2WQ5bXl7QiwM0Rf9TXAumCYcYZGj35LNc/OYcr208knvLi6zgw5qs+sP1iNAvygEwOgj1oF77eS2PCHs17JEc448nI6aHK+6Cokyh+5t/HLDoxsz5czvNs3Bl7vj8qI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3J1bGV5VTI4N0EzTXBGMVczOGlvWjhMWE5ZemN5WUFFUklFdUVqYWxjbVpI?=
 =?utf-8?B?R2dHR3lmS29NMkVjWVROWU9Jdkhna1JPMDhkeDE0TlBnby94MXBUdFlaVHQ2?=
 =?utf-8?B?ZnJHUjVIenVLRDZiUFUrN3JldUZFMDcwSThjNk9lUmV4NnEvNHVWcGlBMmgv?=
 =?utf-8?B?TWRtaWtyRUR1OUNyVjVPbmY4SldjR011OFl5MmZ6TXZBS1o5aUl3NXFrS2E5?=
 =?utf-8?B?ck0zZjFKTWc5TzFTNGl2VVQ1RFlpcTZuZ0YzUlcrc1BHY0FjcStlZTltc3Vo?=
 =?utf-8?B?cWlhUlZPbFhjeWxSbWtuSCtidTdZV3M3KzI2VGtPbE5BZG9KS2Y0V2NkeW52?=
 =?utf-8?B?dkhKb2RuNmpYejZLNXFLeDIvQ1Z4WGx2V3JLV25GdXVMamxvTXkxOSs1MFpW?=
 =?utf-8?B?SWJReXBQUTNiUjJxd08rb2pmNGF6enhYTnJjZU9aRWVIL3EreUE1REwza3Ir?=
 =?utf-8?B?dXRyVEhlR3I2dkVRdHBvcGY5bmlXcDlSemZ3L1VHZE8zcVpndGNmeU5sSlZo?=
 =?utf-8?B?Y0dTQ2h3ajZmNFFIMDZ3RDk5Z3V0YU1TeDE1WnowZ0FXcUF2QmdjbE41TENK?=
 =?utf-8?B?aXRpYXc4UG8yb1pYcERTK0xCQ0tCVkoyTVhjeVVZSHo2UHBQSGltYTJWQ0lD?=
 =?utf-8?B?M1JlSkdEa1RXQThTWjZ4RlVRWHhVSlA4Q3dxSEdmcnd3VzNwY09ILyt6WkpQ?=
 =?utf-8?B?TUEvb3QzSk1qMkRoVzRqbVhhbTIwNnVqWnF3LzA1VHBjVlAyRE42Nkd2Tng2?=
 =?utf-8?B?czU5K3M1VzR5Vk4rVzhDNWgydVBXbU1ENHBINmx6b0VjdmZuSWFiSmJlWVVy?=
 =?utf-8?B?Z2F1ZVJOUlExdU1zZFZOQkZuS1ptaUZvQTlrbEp2cG5OVGxKMCtTei9lbEh4?=
 =?utf-8?B?dU13QzYyZnZIbnJCOXY0bmEwbU92c0xMZnFXRDZJRG16RUxrcVYvTUpaMklY?=
 =?utf-8?B?YzhwTDBJcitIa25SQzRKN0hmcEdwOElUU3BBTjhWNlpnMUFQTHVkZFNrbDZk?=
 =?utf-8?B?dTdxV1BJTXBBVkFpMVA3RGFsNEdoQ1JrVDN6Y0VvNCt6M2QzOFdxbDVBRWNn?=
 =?utf-8?B?ckpGbTRReWR0OXNKV3dCR3BVTjRRWjl5TmdYVWJCanZ3N0ppcGZGU0FnVzY0?=
 =?utf-8?B?MTJDdW1pS3AvWjlFMTRBRy9zZi9CeC9jWnpEWkEyVTBwU2hid1VMRDc3Nkd2?=
 =?utf-8?B?a0Zra3pQazU2c0NPWkdSVDdXaE8vbWpIY3llZFZ5UERUdUlzVGl2WDV1bmRj?=
 =?utf-8?B?MlFIOGlLTnN3Mmh0R2JCUllGUDdGOTBUWVRXK29xY3RtYU1tcnFGemZVY1Yw?=
 =?utf-8?B?VFFOYnZSQlVTenR4c1dpM0ZQOVJmTlpPa1BlNmw1TzhQM2pleEVISFlPaDd5?=
 =?utf-8?B?YTdaSkRVenlMNHBMZmVRVnprbHQzNHdvaUNNcllRZ0RpK04wQlB6MlpYcEhj?=
 =?utf-8?B?cWxDMUFOaFh5VmJMTnhaNnp4ajY3ZlNGaGUzYWNkQW56a0pXZTl1QXl4YUwv?=
 =?utf-8?B?SjVwTS92Vkw3L1Z0bXZaTTNsRjNpdTUrSGNkekN0THRDY2loUjlkSXZYaEUw?=
 =?utf-8?B?VEdBcENORVFsSjQ4SnF1cWRjWkxWa0s4T2laZUptcVI4T2RkcjFSaUlmc0Nz?=
 =?utf-8?B?cUI4Uk03c3FsK0V6Ykhka0pNUDc5Y0xud3NlMDJLenhodmJzZUlIMVRqc2l1?=
 =?utf-8?B?aytWbVVJbmZwRHI5NXgvekpPNFpRbTBqby8yTFZpQ0VJeGd6WDJqU2I5VzZz?=
 =?utf-8?B?bGUxakNoSVZFVmRpQTlJdUVPaXUxbU5YeEYvRkYvajkxSFF1c20rVmU3b3BI?=
 =?utf-8?B?d0c2NTJ6VG1kTW55R0Ewb1pmdFcyT0xoOXVXMmRBY3IwVjVEbzYyWEZtaHJ3?=
 =?utf-8?B?U2llODIvSGprNHQ5RVFiV2ovWHNONHQ1YWFLaWR6eXAwYVB2eGc1b1k4TEY5?=
 =?utf-8?B?cjVoZGdZaTlKRGxtSmg3eENqN083WWlFNW12WURIbmMzeFlRcUQ0a3Y2enNq?=
 =?utf-8?B?T1dtblMxTjUzNWt0Vmd1b1p4NHBPSEZ5QkNWRms0bjQ2ZDRxTERMZUtodXJO?=
 =?utf-8?B?dkRMTE04WXJPNFZGTnBYL3FsTlVsNVV0WmQvMmZmV25Mekt2Y2c3bERmY3ZC?=
 =?utf-8?B?aGV4dXJpYVluakgvMFB4aWJTc29jRlVrTE5peXlJREdxb3c1ZWY2VUE4eVdq?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A27B0249C833468EBCEA8AF86D2BAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaafd68c-3f4a-4188-945e-08dc4eed2dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:06:16.1686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkD4rR7u9fdHNMrQqb7ecayGgs0QBfHS3kmDGzZlJdUGobIQUyY2OPHbf7jsfa6YKMa4DsRDtmZwgiBSEtjCarH7eeaRXL14gr3QtVZ3k+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7154
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.304200-8.000000
X-TMASE-MatchedRID: yxAmdCLMIs3UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCmDkADifjktt9Ib/6w+1lWR4nU6KtjDMA4KwF4K/wIz97fK
	xaM2xqkCovfARTETELYCY2rxjmAZgS22k34pVV30R0Wxq9RAoB5l/lu28zzkBDYbe/PyX8gRIb6
	Ca8Vcr8PDxTPsYX4xAIJ764D2KgwIoRe4evzWLZNOEZs/2oH3cwT0v3Gl09yikSUjj2vJDnPlYo
	V6p/cSx3tyEp3+CaNzWogTgJ+knjLmn1oDITWC5W3dczJ1RoxddymZBcuGGRMUdzAovpQT/vNEd
	c0gW6191dQctzNPkApLVoWzHn19mYYF7llze03YlcqT+ugT9EEMYW8F4Hadcb/1uHmr1Emr00te
	HDCRu7OLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.304200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2D177CF6651F9797D96B680DF478585A2CFBEEBC45C99096CEFCCEE2C76D4D2E2000:8

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDEyOjU1ICswMTAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBIZWxsbyBZdS1jaGFuZyBMZWUsDQo+IA0KPiBTTUkgTEFSQiBt
dXN0IGhhdmUgYSBwb3dlciBkb21haW4sIGFjY29yZGluZyB0byAibWVkaWF0ZWssc21pLQ0KPiBs
YXJiLnlhbWwiDQo+IE5vdyB5b3UgdHJ5IHRvIGNyZWF0ZSBhIGxpbmsgZnJvbSBwb3dlciBkb21h
aW4gdG8gbGFyYi4NCj4gDQo+IEhlcmUgaXMgbXkgdW5kZXJzdGFuZGluZzogd2hlbiB5b3UgZW5h
YmxlL2Rpc2FibGUgcG93ZXIgZG9tYWluLCB0aGUNCj4gbGFyYiBsaW5rZWQgdG8gdGhpcyBwb3dl
ciBkb21haW4gbWF5IGhhdmUgYW4gaXNzdWUuIFRoZW4geW91IHdhbnQgdG8NCj4gcmV0cmlldmUg
ZGUgTEFSQiBsaW5rZWQgdG8gdGhlIHBvd2VyIGRvbWFpbiB0aG91Z2ggdGhlIGR0cyB0byBtYW5h
Z2UNCj4gdGhlIExBUkIuIA0KDQpZZXMsIHRoaXMgaXMgd2hhdCBJIGFtIHRyeWluZyB0byBkby4N
Cg0KPiBJTUhPLCB1c2luZyB0aGUgZHRzIHRvIGhhdmUgdGhpcyBpbmZvcm1hdGlvbiBpbnRvIHRo
ZSBwb3dlcg0KPiBkcml2ZXIgaXNuJ3QgbmVjZXNzYXJ5IGFuZCBtYXkgaW50cm9kdWNlIHNvbWUg
YnVncyBpZiB0aGUgTEFSQiBub2RlDQo+IGFuZCBwb3dlciBub2RlIGluIHRoZSBEVFMgYXJlbid0
IGFsaWduZWQuDQo+IA0KPiBJdCBzZWVtcyBub3QgaW1wbGVtZW50ZWQgdG9kYXkgYnV0IGR1cmlu
ZyB0aGUgTEFSQiBwcm9iZSwgaXQgc2hvdWxkDQo+ICJzdWJzY3JpYmUiIHRvIHRoZSBsaW5rZWQg
cG93ZXIgZG9tYWluLiBUaGVuLCB3aGVuIHRoZSBwb3dlciBkb21haW4NCj4gc3RhdHVzIGlzIGNo
YW5naW5nLCBpdCBpcyBhYmxlIHRvICJub3RpZnkiIChjYWxsYmFjaykgdGhlIExBUkIsIHRoZW4N
Cj4gaW1wbGVtZW50IHRoZSBnb29kIHN0dWZmIHRvIGhhbmRsZSB0aGlzIHBvd2VyIGRvbWFpbiBz
dGF0dXMgY2hhbmdlDQo+IGludG8gTEFSQiBkcml2ZXIuDQo+IA0KDQpUaGUgcHJvYmxlbSB3aXRo
IHRoaXMgbWV0aG9kIGFuZCB3aHkgInNtaSBjbGFtcCIgaXMgaW4gcG93ZXIgZG9tYWluDQpkcml2
ZXIgaXMgdGhhdCBvdXIgSFcgZGVzaWduZXIgZ2F2ZSB1cyBhIHByb2dyYW1taW5nIGd1aWRlIHN0
cmljdGx5DQpzdGF0ZXMgdGhlIHNlcXVlbmNlIG9mIHdoYXQgd2UgbmVlZCB0byBkbyB0byBwb3dl
ciBvbi9vZmYgcG93ZXIgZG9tYWluLg0KVXNpbmcgY2FsbGJhY2ssIHRoaXMgc2VxdWVuY2UgaXMg
bm8gbG9uZ2VyIGd1YXJhbnRlZWQgYW5kIHRoZSBzaWRlDQplZmZlY3QgaXMgdW5rbm93bi4uLiAN
Cg0KU28gSSB3b3VsZCBsaWtlIHRvIHN0aWNrIHdpdGggYWRkaW5nIGxhcmJzIGp1c3QgbGlrZSBz
bWkgaW50byBwb3dlcg0KZG9tYWluIG5vZGUuDQoNCj4gUmVnYXJkcywNCj4gQWxleGFuZHJlDQoN
CkJlc3QgUmVnYXJkcywNCll1LWNoYW5nDQo+IA0KPiBPbiBXZWQsIE1hciAyNywgMjAyNCBhdCAx
MjowNOKAr1BNIEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiAyNy8wMy8yMDI0IDExOjU2LCBZdS1jaGFuZyBM
ZWUgKOadjuemueeSiykgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjQtMDMtMjcgYXQgMTE6NDMg
KzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiB1bnRpbA0KPiA+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4gPj4gIE9uIDI3LzAzLzIwMjQgMTE6MzksIFl1LWNoYW5nIExlZSAo5p2O56a555KL
KSB3cm90ZToNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+PiBIaSwNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+
IEkgd2lsbCBkb3VibGUgY2hlY2sgdGhlIGZvcm1hdCBvZiB5YW1sIGZvciB0aGUgbmV4dCB2ZXJz
aW9uLA0KPiA+ID4+IHNvcnJ5DQo+ID4gPj4+PiBmb3INCj4gPiA+Pj4+PiBpbmNvbnZlbmllbmNl
LiBCdXQgSSBkaWQgdGVzdCBpdCBvbiBtdDgxODggY2hyb21lYm9vaywgdGhlDQo+IHJlYXNvbg0K
PiA+ID4+Pj4gd2h5DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gSG93IGRvIHlvdSB0ZXN0IGEgYmluZGlu
ZyBvbiBjaHJvbWVib29rPw0KPiA+ID4+Pj4NCj4gPiA+Pj4+PiBwb3dlciBkb21haW4gbmVlZCBs
YXJiIG5vZGUgaXMgdGhhdCB3aGVuIG10Y21vcyBwb3dlciBvbiwNCj4gc2lnbmFsDQo+ID4gPj4+
PiBnbGl0Y2gNCj4gPiA+Pj4+PiBtYXkgcHJvZHVjZS4gUG93ZXIgZG9tYWluIGRyaXZlciBtdXN0
IHJlc2V0IGxhcmIgd2hlbiB0aGlzDQo+IGhhcHBlbg0KPiA+ID4+Pj4gdG8NCj4gPiA+Pj4+PiBw
cmV2ZW50IGR1bW15IHRyYW5zYWN0aW9uIG9uIGJ1cy4gVGhhdCB3aHkgSSBuZWVkIGxhcmIgbm9k
ZQ0KPiBpbg0KPiA+ID4+IGR0cy4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBObyBvbmUgdGFsa3MgaGVy
ZSBhYm91dCBsYXJiIG5vZGUuLi4NCj4gPiA+Pj4NCj4gPiA+Pj4gU29ycnksIE1heSB5b3UgZWxh
Ym9yYXRlIG9uIHdoYXQgaW5mb3JtYXRpb24gSSBuZWVkIHRvIHByb3ZpZGUNCj4gdG8NCj4gPiA+
PiB5b3UNCj4gPiA+Pj4gb3IgaXQgaXMganVzdCBhIHN5bnRheCBwcm9ibGVtIEkgbmVlZCB0byBm
aXg/DQo+ID4gPj4NCj4gPiA+PiBQbGVhc2UgZXhwbGFpbiB0aGUgcHVycG9zZSBvZiB0aGlzIHBy
b3BlcnR5IChob3cgaXMgaXQgZ29pbmcgdG8NCj4gYmUNCj4gPiA+PiB1c2VkIGJ5IGRyaXZlcnMp
YW5kIHdoYXQgZG9lcyBpdCByZXByZXNlbnQuDQo+ID4gPj4NCj4gPiA+DQo+ID4gPiBJdCByZXBy
ZXNlbnQgU01JIExBUkIoTG9jYWwgQVJCaXRyYXRpb24pLiBJbiBwb3dlciBkb21haW4gZHJpdmVy
DQo+IHdoZW4NCj4gPiA+IHBvd2VyIG9uIHBvd2VyIGRvbWFpbiwgSXQgbmVlZCB0byByZXNldCBM
QVJCIHRvIHByZXZlbnQgcG90ZW50aWFsDQo+IHBvd2VyDQo+ID4gPiBnbGl0Y2ggd2hpY2ggbWF5
IGNhdXNlIGR1bW15IHRyYW5zYWN0aW9uIG9uIGJ1cy4gV2l0aG91dCB0YWtpbmcNCj4gY2FyZSBv
Zg0KPiA+ID4gdGhpcyBpc3N1ZSBpdCBvZnRlbiBsZWFkcyB0byBjYW1lcmEgaGFuZyBpbiBzdHJl
c3MgdGVzdC4NCj4gPg0KPiA+IFRoYXQgc291bmRzIHJhdGhlciBsaWtlIG1pc3NpbmcgcmVzZXRz
Li4uIG9yIHNvbWV0aGluZyBlbHNlDQo+IGNvbm5lY3RpbmcNCj4gPiB0aGVzZSBkZXZpY2VzLiBN
YXliZSB0aGUgZXhwbGFuYXRpb24gaXMganVzdCBpbXByZWNpc2UuLi4NCj4gPg0KPiA+IEJlc3Qg
cmVnYXJkcywNCj4gPiBLcnp5c3p0b2YNCj4gPg0KPiA+DQo=

