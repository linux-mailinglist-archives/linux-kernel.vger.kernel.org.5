Return-Path: <linux-kernel+bounces-120618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B346988DA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FCC1C23A30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9F37702;
	Wed, 27 Mar 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q8QjtEbt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MR4RwxIV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E836E;
	Wed, 27 Mar 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532069; cv=fail; b=tmXTBytzn0aXdeFsAd71lEPuzl2G1l5EEpvBKb5YkQengkmOyOw6edsb/7OyA9p6xExh0CS6l47dGEBwYg42CZ+yodt8JVJksRpg97vc7Qk7IaNVeyr+LC4QWK+h0Dmk4tY17kAH8m3CJQ3ZHCPzWcDp1+rw+RtcoUQsYZlIkv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532069; c=relaxed/simple;
	bh=dlSIZREpijCSTz0fn0Cw40ojIi9TmOvXf+MCMKy1SFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhV/GyPd+WTfYF7/vRrpVgrGUjWsVsbafT95SwDaDm3jCvvaF0FVFX8pSyx/py6X9moWbJ2gUMNsqZhbYBqptFea5TQ2ukfqa3Z6UpzS+7NTUD7EG4rR+OEYVEuoa/Y9BaDXT0/lJqEEoY9XZLGzsmkx5dOIfllJ90Ec+Rqqamg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q8QjtEbt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MR4RwxIV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f5e0f50ec1d11eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dlSIZREpijCSTz0fn0Cw40ojIi9TmOvXf+MCMKy1SFU=;
	b=Q8QjtEbtTfp1MjLXAbMhrbxE/7uhqTVsrvSMwaXwkFmmOb/3IUstX7Af2HOuqhhxNUbbh4TNcHqevQ4UH7iQ4SiY0srpxZqYRglt9fwL4W+rc702C8lhSR3vuglEZ+Gqyovzj06/K5iJxQKeB3DLeOQr+HG4I+zXi+FopN3A1eY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c6c9ca46-2408-4343-889d-1889d36af791,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f4957e85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f5e0f50ec1d11eeb8927bc1f75efef4-20240327
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 406556770; Wed, 27 Mar 2024 17:34:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 17:34:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 17:34:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGS3Sf2dUfjOZvWcraANAQqrAElS3LTQUsHAM9m5PvKs2BNzUR1Yu0T5dp23Z/tViselUczX14yIyXTPj5tEAsMX/EZEtmCEDjODLdWLUk7zmI8L9hBeBv2n5YIIL3D10y90voTp5V6RVfoquYT0GoixNHFzRUAyUa464Mf17kn/rg5hyslqJPU0syRNCDh99ClNvoD8hwjxFz6S7fdzZ8yJl49LWWVGrBa9qnbc0Ed1Iu6AOt292uoNDhlb1oslfY8gCLx5++wN5XGhkl5m3flMHBGS5p+NER8tBccUL7NwvRkup1l9k2jaP2XIO/74WuXjIBcXKCKD4jO4pjOsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlSIZREpijCSTz0fn0Cw40ojIi9TmOvXf+MCMKy1SFU=;
 b=cybU3UEWwjCfwBna+X6rmLQ0qVgaBQflIZP+b5cAxAWYt097VHe93DZTkX8urYcpOlEjM4Ji6/3xBPE3NVBJPESVsOo/Cl9ljcIj1ni5GKBt40K5rvP6JGIIM158tJALJLr/eEawcb75tXauGRaIbzG6MKbf4sWoIldsosTp+DLOc+ZDhKIBzH8tfQ/qg6mYcWoBPtchQKAiotYiay1qEyy6YcnZlS4Za0hSeyUFkNJtFuUBhmvTHlHGRHTyRoFdaK3OHPiSWw+vPHos4ap9naCRm5ztrJPVya+n4IxufF+t3+9ZFFmmgmrIo3NChpDeWhOgyF5DEmMu9aKy+XtSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlSIZREpijCSTz0fn0Cw40ojIi9TmOvXf+MCMKy1SFU=;
 b=MR4RwxIV2kGDd4H0YLi0r/6efz47/5zUiUHyMn0kJAtifdq3YoD9wz6yk3ac/xiME15AKWNHcXcP2hD+g8F15ZdL4k8DwNNhHu9mKVtLKRKyukSkxj0wcZgVT8PwowE/36gw9Vo/DwXetTXE8OpdBddd5JFmzcdZ5NvmYmuYahU=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 09:34:13 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:34:13 +0000
From: =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	=?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
	<fan.chen@mediatek.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Topic: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAMHwCAAAMVAA==
Date: Wed, 27 Mar 2024 09:34:13 +0000
Message-ID: <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
	 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
In-Reply-To: <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|KL1PR03MB8001:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSIy8hMFNrVEqShmVrJpIAGD3HULWP8Uk7ihjlJGV4fcNEfbqC2IWDRhgr5OXPOBtEIrgHEyBNytoC1oh74Lhzr/eNTazyYQKoOWbPzVxShmiZrMg+ygOJQjq1CGtYPL0gL/1xFAQuVIeDJTQrRlFB8bO5LL2eb7C1sLq6t+21NdqhbZiLMfYyi7OiGNfy5JDf5tMDokmLahsAxNVL+rzgR9nqcKYV/bLyonKFlMWqDYXV9lZTibQ/rw3vCj/yo71uhEePZ+UFgMeeS+njGOHJokYK8fAsn/YKjXJkce5AKOIqKOO6R9f3QoWsPr55TxFDqGb25/9p3FJBAYAbboMxzdn5t1m/R/61hANQd4ELC1cOVWOdcZzyVzb5eDXJJ2TnGkqQ5QsSuTKQ0s3Ohu0coy/VLobzHJimUWM486URIARkkZ5IEuehVD74afdSBrJs+XbwChVJScubBlPMnpK4VJ7ibsCqLQEfChu8/PFVdxK4G0lu1plXQkX9qcFFAhwwsFSyzfFeK3g/rolzRC5jFGvZ6b7UOf/6588N8566CPeDorvlYTE5HZHux6fhPBPtmEH35WiEN7VMKYQ9ExqbbxZxppKrYp31cFjQbsNapoxf/OrmcJtsbqj+RJRJewzMZFO5ox0mK7Y8yFEWdmhO9+RSpQjU4KZ2fVZ9A7DVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHZKREZsdGRTTzlKMkJxd2x4T0sxcGtqdE1weXA5cXY2eTI0anZMZ0lDR3di?=
 =?utf-8?B?ZUJ5ck9ZM1RzTXdFR0FEcUdqM3llOE81WFhKWTFHelhxNTRoTDhBczI0TFNZ?=
 =?utf-8?B?cldUenQ4N3gwSlR0WVBjWlV5VFdhbEszODVQcWg2ak9sRHZIQTNWV00wVE1s?=
 =?utf-8?B?R1Fuc0pDajBSOFpKbFhlZ1IreXZKdk8yeDZZT3ZDOEpvRjJsZTR0Z0hTMUUv?=
 =?utf-8?B?TXdIVnV0TWxtRG9jU1lzYTRHamljY0tNQlpvc2E4ZmlNejhsaWJNOERQVFdp?=
 =?utf-8?B?Ui8vWjE1WVJrZUZFRXF3aVlnTGs0dm0zd1k1MVlxZjRwNFNwWHl0YUpGZUZz?=
 =?utf-8?B?Q3hZQWc0dzByV0hVRWdzZkJiSTVhaVl6MTBlVlgvTlppOTA5Y2JXWlN2cVRl?=
 =?utf-8?B?T1JYbmFYZWhzRVFRS2NmblVVZTF5ajNQMStDUEhiUmVqTytCaXdHUUJzWm03?=
 =?utf-8?B?eEdoVXdWRWt5SkxVMmk4T2QvMSt0d1UyRGFoaWQxUlBScFZGbFl0OWg1UDVD?=
 =?utf-8?B?SDYvZGlHU1dvUERWYW9vSG1HY3VqSHZFeklORlpsWW5tQXpWWXBzallCUDVF?=
 =?utf-8?B?WWQ3OWlVNHppeHNNSGpORlU3SWlLai83SVdzeG9iS2tlellnL1lVMGhiNkF3?=
 =?utf-8?B?MVRaVEVPSHJuaEZ4Mit3cEJybWM3UGNxUUxKMWZQRWtwbjFFdEpCWFNhUmtz?=
 =?utf-8?B?QzFDU3F2Y0tveTAwRXcyL1RobU1sRDBxeUVxYWFCWmF4Qm94TVR5V1JnQ1dD?=
 =?utf-8?B?NkVHMFU2emx2UUZPNlJNeWFrV2lqbGFvbmN6cnUyQ3UxQVZZY0FoS1JyVmlN?=
 =?utf-8?B?MFVhellRd1RQVkNyRXdjc0x4NS8rK2puKytwcGpFL0lzZHo3c0RjSFV6akNn?=
 =?utf-8?B?c201SnlrZFo5LzhXeTVTYU9iL0h3WEp3ZUpVVnRLYWU4ZDhyQzdkMjlqSTVa?=
 =?utf-8?B?amgvNUljZzhiRVArdGptYmRkaEpEMkNrN0tkTWtRaEVwUEIwaC8wV1dnQ0I5?=
 =?utf-8?B?MTV1M3N2WFUxb2RabS8yTHhyL3NiT3FrVXVxSXMyanhFSkdDNXJ4Wm0yd1Fk?=
 =?utf-8?B?UjdoNDJyVGpGN2lxWUlXT2QwNlVsMUxMYXFxNjJKM3lkcmxyeEtxa3Y1MXNY?=
 =?utf-8?B?aEFCVlJHNnFJbWUrN0RTVTJUcnhrRlpYWXd6ZittSjVKdmFRMk5rcXZBWXBj?=
 =?utf-8?B?R283cVNZNmxTclIyYnlKSlpuR2hia2dZZ2ZnUUhpRFk5ZVdSL0FuT0xqT2lL?=
 =?utf-8?B?aDR0NG9HM3VKbXh0RHlZZDJGcTRkZXJEbUs4b0Jva3hmdGFMN0syQ2lic3di?=
 =?utf-8?B?L0s1a1FueUZTWHZEK1ZJVHZ2VWo1dEh2dTV4dGIreTQxL2hlWHJOQjgvK1hJ?=
 =?utf-8?B?aGtXZWhFQ3N6cUk4OU1ydVp4VFRaeE9zeWx5RFZRS2xaSUZPL0RBSXk2K1F6?=
 =?utf-8?B?UXV2OHc2YU4ycWJHRVRQQ1FFWHRQT21YdjkzZWhTTndnRkdqVHlhbWM4V25F?=
 =?utf-8?B?UzhhWXpmc0RNbGJ6bGpRM1RXT1QzVHd5MjRSSTB3VnV3Nlc5Q1NXT0plT2ZX?=
 =?utf-8?B?eWVXNTlyMFZGZ25hSTh3eEVzeElBYVVKUThmdnJ3aWFSWHBGbElreDBab2Rr?=
 =?utf-8?B?YVgraVpIb1V4Q1dhUG1QTFB5M2NRWkdlVWNNVERCT25IbDZWMk9LcGlmbE5v?=
 =?utf-8?B?NkNodUg4QXQ4emxKbWRwQlV4K0IzVU1EaGtKNG14UVBkcThxdWxIK1VxMllM?=
 =?utf-8?B?dUZkNThrekhUMml3TFU3OEg1QVF4UGdKd3NIZVlGbFpUU1VTeG5vVVlLNWpP?=
 =?utf-8?B?VlZsYmtaYkdrQk5sYUlkSHR3cUU3QzFzMzlveFN4aFhVUTdlRERKeG5JNEZ0?=
 =?utf-8?B?QWl5U1d1OVA2SXhHU1lVZUx3SzFDWUF6dGZHMUlrR3RJd0VFaEYvS1dHOXgy?=
 =?utf-8?B?eTZVZ1FndVdyajIrK0FYWTJMQ2FqTjh5ZGJ2SGxoZFhQSXVPRUIwQ2xoM1lR?=
 =?utf-8?B?eWtxdVhaTjZjMWtrK1dObjM3a29LS2lPRnh3U3dOaEtHWVJRVG1PTkVNOFlp?=
 =?utf-8?B?U0lmL3pRcTBMendENlNFU29rU295SVpxTnZZenhYdEEycDI0RTd0UW9lWExQ?=
 =?utf-8?B?WjFRZlBRWmtwcFcwWVNiWURCUEkvOGpOb1ZWRm44Z01aYStlUGhGdTM4MHZN?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9D8EFD8A9AD041819CB2060EA8E09B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae19b4-8b86-42a7-22db-08dc4e411049
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 09:34:13.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XQwC9JQJQncbcs4fAOv+EZIB6Vp6QXn60waiNTrRrBpYGIW0IK0/KqPET/1JfKVRGlnMWL6cIslGb8OznbUAsYMqafW6mNQTuoFT+Lb+Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDEwOjIzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzAzLzIwMjQgMDk6MzksIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4gT24gMjcvMDMvMjAyNCAwNjo1NywgeXUtY2hhbmcubGVlIHdyb3Rl
Og0KPiA+PiBBZGQgU21hcnQgTXVsdGltZWRpYSBJbnRlcmZhY2UgTG9jYWwgQXJiaXRlciB0byBt
ZWRpYXRlaw0KPiA+PiBwb3dlciBkb21haW4uDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IHl1
LWNoYW5nLmxlZSA8eXUtY2hhbmcubGVlQG1lZGlhdGVrLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci1jb250cm9sbGVyLnlh
bWwgIHwgNA0KPiArKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+
ID4+DQo+ID4+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcG93ZXIvbWVkaWF0ZWsscG93ZXItDQo+IGNvbnRyb2xsZXIueWFtbA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci0NCj4gY29udHJv
bGxlci55YW1sDQo+ID4+IGluZGV4IDg5ODVlMmRmOGE1Ni4uMjI4YzBkZWM1MjUzIDEwMDY0NA0K
PiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbWVkaWF0
ZWsscG93ZXItDQo+IGNvbnRyb2xsZXIueWFtbA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbWVkaWF0ZWsscG93ZXItDQo+IGNvbnRyb2xsZXIueWFt
bA0KPiA+PiBAQCAtMTI1LDYgKzEyNSwxMCBAQCAkZGVmczoNCj4gPj4gICAgICAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+PiAgICAgICAgICBk
ZXNjcmlwdGlvbjogcGhhbmRsZSB0byB0aGUgZGV2aWNlIGNvbnRhaW5pbmcgdGhlIFNNSQ0KPiBy
ZWdpc3RlciByYW5nZS4NCj4gPj4gIA0KPiA+PiArICAgICBtZWRpYXRlayxsYXJiOg0KPiA+PiAr
ICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+
ID4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIHRoZSBkZXZpY2UgY29udGFpbmlu
ZyB0aGUgTEFSQg0KPiByZWdpc3RlciByYW5nZS4NCj4gPiANCj4gPiBXaHkgZG8geW91IG5lZWQg
aXQ/DQo+ID4gDQo+ID4gUGx1cyBJIGFsc28gc2VlIG1lZGlhdGVrLGxhcmJzIGFuZCBtZWRpYXRl
ayxsYXJiLWlkLi4uIHNvIG5vdyB3ZQ0KPiBoYXZlDQo+ID4gdGhpcmQgb25lIHNpbWlsYXIuDQo+
IA0KPiAuLi4gYW5kIG5vdCBldmVuIHRlc3RlZCENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo+IA0KSGksDQoNCkkgd2lsbCBkb3VibGUgY2hlY2sgdGhlIGZvcm1hdCBvZiB5YW1s
IGZvciB0aGUgbmV4dCB2ZXJzaW9uLCBzb3JyeSBmb3INCmluY29udmVuaWVuY2UuIEJ1dCBJIGRp
ZCB0ZXN0IGl0IG9uIG10ODE4OCBjaHJvbWVib29rLCB0aGUgcmVhc29uIHdoeQ0KcG93ZXIgZG9t
YWluIG5lZWQgbGFyYiBub2RlIGlzIHRoYXQgd2hlbiBtdGNtb3MgcG93ZXIgb24sIHNpZ25hbCBn
bGl0Y2gNCm1heSBwcm9kdWNlLiBQb3dlciBkb21haW4gZHJpdmVyIG11c3QgcmVzZXQgbGFyYiB3
aGVuIHRoaXMgaGFwcGVuIHRvIA0KcHJldmVudCBkdW1teSB0cmFuc2FjdGlvbiBvbiBidXMuIFRo
YXQgd2h5IEkgbmVlZCBsYXJiIG5vZGUgaW4gZHRzLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdS1jaGFu
Zw0K

