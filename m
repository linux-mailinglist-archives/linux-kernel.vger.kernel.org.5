Return-Path: <linux-kernel+bounces-120644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B6E88DAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D7E1C234FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50847F54;
	Wed, 27 Mar 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lB9e2PZC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YqXuV3up"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529311401F;
	Wed, 27 Mar 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533713; cv=fail; b=eCxYoOk30EOQmnudRi4/6ZavXRzYkYzAPHnhCOd0HWeiTMMNpS0/rhHMccaTB93tHVeWWnMvzcLMfpO6reLqQTZioaTj1gPyiJQBaVujcPrP91APToZXjqsY4EQ25ukVQQD/bUB/BAklHp2qkecGLv5We0IHDMUaVX084/LIl4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533713; c=relaxed/simple;
	bh=PD+7Bolf8Ir//a3Kvm7XYOUeTEODUMxZ7BcB2/ksFUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IW8Yj0kYKb1lGdSbUCGNw4BHeNxu5HBgrIbuaY2H4iFGsrFBoNIPKTYuMWyYqQwdEJ8+irnszNZ13kPBQIEOwtusc7k/kKk1U8IYNM4imt9AUsYjnlnEUZN7hPA9VUKBibVBswuHcJHTRcW1E0uLvUsW9bsxrVlRRCimyt7F2fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lB9e2PZC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YqXuV3up; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 02aff762ec2111ee935d6952f98a51a9-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PD+7Bolf8Ir//a3Kvm7XYOUeTEODUMxZ7BcB2/ksFUA=;
	b=lB9e2PZC1XBzn7In56KhEoASoBLvnH/iIwAKEb7OlIC9UBPBHCAWEYFQCFy79l9EYwnzmQn8zLxiAewWfQ2fm9GAdWFN20n4cI5GCnVl59W5uTaoxqhYudIpB9s78O4yT094/EU7xRVolKlLcKfcC6HsMc2+4YruRr/F585wueU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f842adca-8052-4acc-b3ab-5fec1666859b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3a5f6300-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02aff762ec2111ee935d6952f98a51a9-20240327
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1670137246; Wed, 27 Mar 2024 18:01:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 18:01:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 18:01:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBwcJ81iA99VsGe+Wj9XpZyglM97skJUcyT7XR43CsSvey9iQWsTWkycz266+VAc7GA09zk6WiKDoxkq7rxuXwrx87NPE6YVQfe+QKXnH3dLIJfoGDcYxbviC1E20dVb0N3AQytJYsRFJhlMQvrMcJCbY0Q17BVAllIHtv0rNGeoCkfWrzy4z4eAksKY+63t2aEPwADd1z0YrsRkF+lVjnJ19SFypR9+7l7/Y75oJeXc5Xvw5IDI3wn4gRXfSWL6HWiQLmjXjknLeHmirmY+GUTJw49XWQ6UiI4+4KqL15nSn/E1rp6PyObzjU72lz8UT/BzMwiQnd1FOJLdMZFvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD+7Bolf8Ir//a3Kvm7XYOUeTEODUMxZ7BcB2/ksFUA=;
 b=CyInsNWd9T05+EWO+N++oKGlhs7jDWpe/aUr5xVuqXyzvvjAn+Q3WEcTbBjN7RJpnZDcubLy9uCEx4mgso6K4zQj2PACretr1ScVIMajQRDb5PY1oD0JS4hNnKQZ6NjXOnE3PTDjz8taoYEytW8BcCV54T1n1gptDrd8ArGrw8AJnnadrEASCJvK3MXyD/kuMbeosPW2oI5XyQac+gYor9gt1YE9h7FNUB/mgVZzRnqDbOYDqGYVyhO+KUNAqX3xl4NxQmImcftoS7R+AiHKvqoSPjh99QzMgEFUKLA61DetvP/dZFzZIO8+NqhzdYY3Eh9b3pxT1IhyYm1uD+cFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD+7Bolf8Ir//a3Kvm7XYOUeTEODUMxZ7BcB2/ksFUA=;
 b=YqXuV3upqfoeyqyFZ0dz7F4MVYH0j6o4+mjqPU1SBcPENHxfnyfHOCjoAzqFdRw/Fc/ybR29cW2RsoF4WA5jLuVbActmSK+eUwYEXiEB+9NdRC93AjFpnwsisJs8F8HYQ1kRVzXfIf7q1k0wn77iVaiqGTo0+jX7rMXL6GRuCvI=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by SEZPR03MB7326.apcprd03.prod.outlook.com (2603:1096:101:12c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 10:01:38 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:01:38 +0000
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
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAW3YA=
Date: Wed, 27 Mar 2024 10:01:38 +0000
Message-ID: <f25b4d913a584d753888e7a3c32502eae1f7fbf0.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
In-Reply-To: <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|SEZPR03MB7326:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZIE4OoWMxxrNfpmOP3kzGZ6CkAQujVtDKuF8jCMiQZZcYCuFDoJXWgcIT70YFfS4/o64Hm9hPsdRNi6TuvG+zSfk3UXLSwEM3TXGaa2TW2ZOaMBaAk82YJRaJhuVqqllTyGUYKcP0x/MHwbVOx9QBdoNIoGuJuNphSaQ3pnCAcYanmBcrH3l2LAMU3ivd0ZarKuq+BP9+btM17MrqLySqb0fL73BcUdC1NjD1uSfg8lYpL5hZ7Mv0bDJVjZD7ar+96IjVz2QtC7pw0L26mebu5S5RFdeVxonCXMsgjkppVmjbQ3ZiXCKqTmksP7pbA2jYywmWG1lrA3Q0wWXUKNJ75bNDaoFeoCaO9n5Kb0iuGeQLikNeMSZeWYr5F+KbyNW3h5AVXONsN/0b2CDYhVi6ScFVKF/vNmDZKwWUEnrosob1DZnw7BkSX7SIVUeJq0Lba/4PsCPjyJyJ2BMho8hRL53kZ2175sXofl9N0Vt0yiPLP9aqlMBLOo8fT/RSBeVLbOTxi/CMcx5FMKCHP2mTOzUdp+Ta8t8Wzt8MXoQdTwFviS4egf/QtorvlhYjCIlIX8QN2DxusHNPIWed6nboB57dwXcgi2tg9K6RngVAqOxtZQ/DPYgt3hBuuEd86IQWSUciCpypYvIdi17vlILf7TsjaFNrulrLwjjB3sfEQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTJTamRWeFAvNVhBUVJPNnIyZGVrbzFabVFBVTdGTDBnSEhSYlhFblpTeEsx?=
 =?utf-8?B?aDNxY1FNSDBZU0Z2Z29yaSt3YUxGcG9zcTVVcyszRGhWOXQ5cVJ1ajFZcjZq?=
 =?utf-8?B?SndRb2s3MlFBQkpNR0dXdDNObnJIOTY1NkhvOUNOU01laHdoYVlsSm9LOGZB?=
 =?utf-8?B?Z1ByUmkxcHM4aTNNbnZBVEVML3dpVnpTY29FSVVENE0vZ0NhY2x0VkpsQWpN?=
 =?utf-8?B?TllxWVA2K0JxTThnc2UxL1E0UHpOZktBSmY5aFhwczhzR2lKU29LUUpNRE4x?=
 =?utf-8?B?OWlpZUdZdmJqYndzVGhIdXg2V0tTaklza1pwbVFDUXFmZ0lWdEt5Z3JweWpM?=
 =?utf-8?B?RFRkRStLWWFZNjQwL1ZWWk4ybXRnTVRQUnhOR0E5ZGswMmpDMXRzdGw5OEtH?=
 =?utf-8?B?Q3BMVUJoWDRtOUlWaFJabEIwTVdQMzhjREJucGsyQVBkdm1Wc2dKRDVmMFpX?=
 =?utf-8?B?N1kydW1LcDBDYVRYTzBFdnVtWjNXUURJZ1l0YVFPUnNCbFBLSndwWGMrNytl?=
 =?utf-8?B?L293K3F5ZmpMK283SzZuenlPTUNiSlhBeUZwMXR1c1JlRGpKN3FLdzZNdml2?=
 =?utf-8?B?djNHUWNQSm1sWjhGdnNsQStPRnI0MnZDbEhvMlBibmxxK1U1ZmJXRm9qK2FP?=
 =?utf-8?B?QStmMVBoZVhmZSs5eEF4MDV6WGpxczBmQ2s2Yk5FUGc3YnpwbUl0aDBRVTND?=
 =?utf-8?B?ZlpkWWxkTkk1YkNDMUZlWTJNT1FPaFRuMHV4VlB2TGZRM2MydG12bStxN0R4?=
 =?utf-8?B?d2Q5UGtOb3ZvR1liWTBhSDlZemRNRUNuZXNiYkkxWGZ0VkhQaG1VbEp4ZzJ3?=
 =?utf-8?B?cXZpY3Nsbjl0cEo3dUY2NTlNa2xOVkVHb1A3VFBXT2lxWC9nNjRZMzJ2Sm4x?=
 =?utf-8?B?b1NmZUtBand3VldrdXdtVzhKVEVMbklZc0NzekFBeTBpb1QvSGRNb3A2N0ZG?=
 =?utf-8?B?SC8zSXBBM21FTEZGZ2Q4ZFFJSmVDd1ZlejZJNFQvd0h1TVdXVUhLdmttMzhY?=
 =?utf-8?B?dDB0dCtlaTZMU3pkOERDcGtsK1Y0WUNlZ210cVFmYVY4NVI2eFdTQkRRa2Js?=
 =?utf-8?B?amEyeHl0cmgvRTVOOEZ2dmRhMUxDWTdkTzZLUGdsTlB5b1h1NDI5MERYdXBD?=
 =?utf-8?B?bkNjU29GM1ZCd0FqelNoSGZ6eWxxQkNwSDRvc3lCQzBISFZJWHJWakpEeGc2?=
 =?utf-8?B?djZRbXplYTlkTldSSlpmQ1FLMlJzNEdIdVhoR2hVL2dmbWdiMXVYVkExSnB4?=
 =?utf-8?B?K1BVU0xPUTRHVHY1djVUMFUrUVMrOFUya2xKQmpIRVVnanAxbUdPYW9yd0tZ?=
 =?utf-8?B?K3hsc1VlUHc4MkxoRUpqSy80ZmRPNVpSWkR3aUQzY0VBVU5EYnplNHE0Tjd6?=
 =?utf-8?B?a0VMbkp3ZjhyNUNRR2RqMXZlMXhBKzFsVmR2M0pza01PRVY3UVlmQ3VPVnVH?=
 =?utf-8?B?SnZxOHFzRVZCRG1pSGIzeTVseTFPUTlYZEpBaEdCeGFRK0FrK2ZEZHFxd0Zv?=
 =?utf-8?B?Rlp4MzR3OUlWUEcwdzZNNzVlcElqSXdldVRSMXc5VkpVekMwVWpsMDVzRlpz?=
 =?utf-8?B?Q0toeG1zazJ4bDFMeHdyV1YwbUx3aXExSG1zRDl1d3J0OHRoYVdjVUlTL0M2?=
 =?utf-8?B?NW5heDlPTTFDQ0ZOVnBtOWg5bnJjaW1MTlBsT1RIUW91TmcyeFN5dlFudUhk?=
 =?utf-8?B?ZlpPSDJoK25BOG16TXg5dzFNcHZ0Z3RLM1FqZWIwM2toQnpjZjdpL01BODI0?=
 =?utf-8?B?MzRXSkRXVmVIRGdnbDY2bWNNNnd4a2hQTFJXc1RRaHY4dUhrdXJUU01rVXFC?=
 =?utf-8?B?b3I5bTBQY0paL1c5Q2RLM0pZTkJKNnlrbGNxc2k1dVdtajc3b3dSc0Y3Ly8w?=
 =?utf-8?B?QW9GNkhJZVd3aG9TMDNMVWtMZGZjdnFxQmlQaXJsK2ViZktxcmViZ1VRNnJO?=
 =?utf-8?B?bkh0TEhuOFdTYzZEaFB5dWsvR2JYSk1RMWdqek1UMTBBT09UVFNEbGFZV21i?=
 =?utf-8?B?L2k3N0krdkU2R08vY0R6S2MrczZTRFBSYlorTEpNTWpQUmw5ODFaellBeFM2?=
 =?utf-8?B?UlBRdEhuand1ai85VUdoazdjNllaV0J5NWNZT3ZBZWdEZ1ZUU0ZDdkFDMzBT?=
 =?utf-8?B?eDBaWkFVRDVRWVF1MW1nRlp3YkNjVUpIRTQvNWF6WmhPNE54cHJneEdrMGtj?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D4069AFDE51240929FD2930A6EE113@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0959fc38-b038-4abf-dd17-08dc4e44e4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:01:38.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QALhPyvzVk7Mk7tJfGeFasgzEtyBNTG5Vky9gTeTs5Yp6jpoibwakBH7YYx6irEDa/lNAFYklKaNAJMjtTdSXM7XY+jMB3y37YZrg3Ab8Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7326
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.726800-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tXP5rFAucBUFMkOX0UoduuQKzHKFHzLsJySZ
	h5ZDH/3f9W4F6Nyvtfq+MC1pu6vlcBEKiKihS7U7i3aa5wOREEX0tCKdnhB58pTwPRvSoXL2y5/
	tFZu9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.726800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	75C7D027C3D9AAD7EB1848D8DD7A0145E818D53A67927438DF2A0CEFF2C7C8EE2000:8

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDA5OjM5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzAzLzIwMjQgMDY6NTcsIHl1LWNoYW5nLmxlZSB3
cm90ZToNCj4gPiBBZGQgU21hcnQgTXVsdGltZWRpYSBJbnRlcmZhY2UgTG9jYWwgQXJiaXRlciB0
byBtZWRpYXRlaw0KPiA+IHBvd2VyIGRvbWFpbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiB5
dS1jaGFuZy5sZWUgPHl1LWNoYW5nLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL21lZGlhdGVrLHBvd2VyLWNvbnRyb2xsZXIueWFt
bCAgfCA0DQo+ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cG93ZXIvbWVkaWF0ZWsscG93ZXItDQo+IGNvbnRyb2xsZXIueWFtbA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci0NCj4gY29udHJvbGxl
ci55YW1sDQo+ID4gaW5kZXggODk4NWUyZGY4YTU2Li4yMjhjMGRlYzUyNTMgMTAwNjQ0DQo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL21lZGlhdGVrLHBv
d2VyLQ0KPiBjb250cm9sbGVyLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcG93ZXIvbWVkaWF0ZWsscG93ZXItDQo+IGNvbnRyb2xsZXIueWFtbA0KPiA+
IEBAIC0xMjUsNiArMTI1LDEwIEBAICRkZWZzOg0KPiA+ICAgICAgICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiAgICAgICAgICBkZXNjcmlwdGlv
bjogcGhhbmRsZSB0byB0aGUgZGV2aWNlIGNvbnRhaW5pbmcgdGhlIFNNSQ0KPiByZWdpc3RlciBy
YW5nZS4NCj4gPiAgDQo+ID4gKyAgICAgbWVkaWF0ZWssbGFyYjoNCj4gPiArICAgICAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gKyAgICAgICAg
ZGVzY3JpcHRpb246IHBoYW5kbGUgdG8gdGhlIGRldmljZSBjb250YWluaW5nIHRoZSBMQVJCDQo+
IHJlZ2lzdGVyIHJhbmdlLg0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIGl0Pw0KPiANCj4gUGx1cyBJ
IGFsc28gc2VlIG1lZGlhdGVrLGxhcmJzIGFuZCBtZWRpYXRlayxsYXJiLWlkLi4uIHNvIG5vdyB3
ZSBoYXZlDQo+IHRoaXJkIG9uZSBzaW1pbGFyLg0KPiANCk1NIGRyaXZlciB1c2VkICJtZWRpYXRl
ayxsYXJicyIgZm9yIGl0IGxhcmIgbm9kZS4NClBvd2VyIGRvbWFpbiBkcml2ZXIgdXNlZCAibWVk
aWF0ZWssbGFyYiIuDQoibWVkaWF0ZWssbGFyYi1pZCIgaXMgZm9yIGxhcmIgaW4gZHRzLg0KDQpU
aGUgbmFtaW5nIGlzIG5vIHJlbGF0ZWQgdG8gZWFjaCBvdGhlci4NCg0KQmVzdCBSZWdhcmRzLA0K
WXUtY2hhbmcuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

