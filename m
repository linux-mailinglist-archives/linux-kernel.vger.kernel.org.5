Return-Path: <linux-kernel+bounces-10964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970A81DF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21859281AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36726525E;
	Mon, 25 Dec 2023 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tFV50jgd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="atyXWAcS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510361C32;
	Mon, 25 Dec 2023 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c6810318a30411eeba30773df0976c77-20231225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o4M4UfU4U+GUMFCQP/JcgkxVOS2rnjIid7voUQzLf4Y=;
	b=tFV50jgd8TfN1E4OHtopyAlmTerIyf8htynFTcDxa80iYs3jMRZB0/0EMKvNuLNOWI5klvyWAYYZmGPeNVloHfXR31TUaPXsjL712E+NqKnYDWa1ZSCveY3jgzZwfcH55A5PShLEpCUxx3N6bpwWE+x4Kimn0ZtJSu5XUWVivxA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e7c257b1-8bc8-4d81-9266-1319006d2644,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:26362482-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: c6810318a30411eeba30773df0976c77-20231225
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1761752003; Mon, 25 Dec 2023 17:05:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Dec 2023 17:05:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Dec 2023 17:05:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9ZRpxQEbB2eoahCo5xMHn2Y/Bj0RdZNqhwrGoXC7PZQ3P1NyhO7iimVS+tlhMO0VV7a3K5iKPcbIuu9Ksj6RPUM8czfwupU8O+TNg2M4fdTNYDp4r1gORLmlw4Muw2CowK2qGn7EdVmG55ocv5vQdzE2Bvf5OwZNNhLgs80b1kcoPZyRTqQrltim+FXDZTije8txsN3K80YXnAeOWKMSmf26TOJsBtsbKE4xtofk1UWgU2XdgyuNORTFPImtErB3XMa6QoazIXNQg2zYo8COryiZjYLlxML/q5BmDRYQSNeTiAMlM/4BJ43Mg7V76XA3JgpIrI86ZiGWK6cbDshig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4M4UfU4U+GUMFCQP/JcgkxVOS2rnjIid7voUQzLf4Y=;
 b=JAG1AFJ5o47Pvz1sPUSseCYyYLpDo8cfCtmrz4J0Z6FAoWF8mYyZZJZ5vAnT/ARx4l+6cwqLk9Yzl28tAsHSYKdhANQ8ALUpbJHpFVYcatUBZMHxwo8e/oZ287wnqnu2scHVouYjMQfa7iiRgc+yYuAr3RfXsyMC3SKUHs/GZOHQyG4C6yDequZmXSVHFfO0VPbk0vq/TYaehDI21X0oJ1eGfmy+NGTzS8NRCEPAwmNaKUtrXDGWaHhHZZU47cHmm/2WeQekP1ZtI+JQZ+iaPlWk7BljPjhzvVoexQLbNfCgqxA/JEOKIM47GXMz0DiAM3bfteeMpy56nl6qv+cZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4M4UfU4U+GUMFCQP/JcgkxVOS2rnjIid7voUQzLf4Y=;
 b=atyXWAcSc+XUKcQI3JbDHwO0lEn26JliXgPDkV8QoFjVLTRHoenGnm54/ooMXjgpEoLKP86Q53Ls7PdZXcVJ60Ds2lWtRe/i62kMKU2T8z5FpkAIiZ6gt1i600REC6wRPM9sfTiCmZGYGrD5i0QFeGsa8Wn+eX3uZv0S/oXuXjM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5475.apcprd03.prod.outlook.com (2603:1096:820:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 09:05:33 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.023; Mon, 25 Dec 2023
 09:05:33 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "drinkcat@chromium.org"
	<drinkcat@chromium.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 01/11] drm/mediatek: Add interface to allocate MediaTek
 GEM buffer.
Thread-Topic: [PATCH v3 01/11] drm/mediatek: Add interface to allocate
 MediaTek GEM buffer.
Thread-Index: AQHaNc3/z4g1rSJ0xkaYIVC2Y+hRprC5t2oA
Date: Mon, 25 Dec 2023 09:05:33 +0000
Message-ID: <4169f943f6e82da50243d91614ab73d6b5f57c8a.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20231223182932.27683-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5475:EE_
x-ms-office365-filtering-correlation-id: cf46818e-2e17-4d3f-fab7-08dc0528a6f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOgW/fq4ScVsA5ral3MOmnTv9Zmk6RIaCofLoR3HTt5NfVBqSh1LAodH4/0vq0cA4KOpa3VLBL81ywac1Z2RwzXPbYhRgNk+QO9xof2zJvMR5yqtWlVY42eP5LUjPaa4eJovqJwHdkrtsiKh9V+54zhY/hOlzmtCyQO2qclVGtEMZKHcXfhL8fuOxc3ThYAtLUvCqzE9Id2zbM0mLQdVV6vywjL1FnOWzRbQPT95/n3k8JcoylEjhU95RIrqkaxfN+jV+Bv6XH5I1eun5+ptVOIDdIj2CAweaK9afUibfHPoApT5Hr/aASUEtHLlAPj9zL9B8mXZWaad0wpxbY0VtDV+0jhBq1dHTHd8OcBpcBNrKABBN17L9jZpCNTGarJgAGRbMuko78apCXG2EZji+zm2WTor+7tvy9Rk+cvX4noSnc1kXt+zbggQtboVxoiNZiZq0VgVPbW/33UgcTC5xB9uV5nHivZ/lJPd4GV3RmBYuJt/K9IvT22XklLEye56kiwfoLXsBzPTjjerZv8ygFSRi2loE/7mijXPHuQMtrDnHa2UlZyLAWdD6K+YniHLG2TJiMOiErCdyl0++7C0kfOhAXQFMEnzq+dGcSHaoo4DJA9UoLoUQAVuSiGrWV6u/0JZWjFfWbgwNDAH2Yvm02rcrBH9i2uQsyXJgAR9ovIO7uta1UxCFT0UJeUkQWac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(478600001)(71200400001)(6506007)(38100700002)(26005)(2616005)(122000001)(41300700001)(8676002)(8936002)(316002)(54906003)(110136005)(4326008)(6486002)(64756008)(66476007)(66946007)(66446008)(66556008)(76116006)(5660300002)(7416002)(4001150100001)(2906002)(85182001)(36756003)(38070700009)(86362001)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RrZm95N1U0NHRiNmoxcHdLTlR0WHVEdXdibDFlM2tKZXRGQ25Tam16OUtt?=
 =?utf-8?B?Y1VqYzhQU1JNMG5hVzZYTFFTNjhyTXlXSHB4My9JcXFTcDZVS1FFbm90SmRp?=
 =?utf-8?B?bFoweG9LVy82WTkxMmRQYVY4NENIaXZ5aXduQ3MrOTBVNDYyU1Q4NWFjejNP?=
 =?utf-8?B?WURvZ2Z2ZkhXVDBMMHpWcjhybTdORFpWU2dKTmQ3WGNJUDlOUlRxREU2Z01N?=
 =?utf-8?B?V3VBdU95cW0relNhbjVWdDVianVMYk1kc0ZRalltL0ZKQVlvbkg4R1RYYVFH?=
 =?utf-8?B?ajVOVXBFS1J3d2V6cVVwbG9KVnpFRjVHMzFCbDdPSDZHSDFlSVJIR3Y4bTNS?=
 =?utf-8?B?VEhjTStmb2g2bHNBVjNXR1N0dDhVQUR1NHR6OEgwaFQ4Lzl0RWJEKzVJYW42?=
 =?utf-8?B?V2VFYzZNR0Uza3RqV2lrc1UyN3dMcHJQQzNRUEFCdTRjR1FsaXMyeDRYdjRN?=
 =?utf-8?B?aHpTaGpEWnlPd2VxaUk0bUJMbGdxZTAralQ5NTZZUHRReDFpTU1xWkRwZGtZ?=
 =?utf-8?B?a094NlY5eFcyQXhXYXZaYmkzY2I0V1BqVGJVT2V0NktBRGxFNUNuZHcvTjJI?=
 =?utf-8?B?NjFqZ2NOZk9rOXhpVUFUUUlpUmxIUE1oRStzS01hZi9ZdHJBTTBlS2dOaWZt?=
 =?utf-8?B?MjRFNHY4Sk1oVjNpTkFYaklGNWRzRnliYWtNSWluaWdJbjU1d1Q1a1M4Z0lP?=
 =?utf-8?B?UHAyRkR4eEZqZ2pGRW1PRHNLanVZaS9hb282VUluL0xsdmR6NlBnS2FaaGFJ?=
 =?utf-8?B?cGtXc2hibU0xekFvektNWCt4MnFhWVZEKzFYdGloeG5ldUZJRDJrdHI2R1hR?=
 =?utf-8?B?ZEFBZHJNN0JFSW1vUXRNY2pQSTNmU1g0dWlzY2REQzdhVmRlQysrSWZMRXhS?=
 =?utf-8?B?dERKZngzSHRrQ1Q2bzRSUGRUMTFuZGo0cTNvN2h6WjZHYWpvL1hRV0wrY2xo?=
 =?utf-8?B?ZTViM1dRcjlKY1JkUGdscTlVZWJMUDh2YUM3NEdBU296c0xnZXRlNEE0Zmhm?=
 =?utf-8?B?WWJLb0NSRE4vZWEvSUx5R1haYWt3Q3VyU2Ivb3htQkp3YTdyREJRMDBaT2Fk?=
 =?utf-8?B?ZG9PUnVWWTJMM2xJMW5HSDB5d0hJS2J4ZEZKOVRpalRmSXZ3MWR1MEptK29l?=
 =?utf-8?B?Rmp5ZkRLQzZQbEx0T3YrVHU4bUpkZ2pwMlk4dktGaDVkVTQzbDNBYS9wNDho?=
 =?utf-8?B?UlVvcnljS0xzVzNheitMZ09WVGpvZW9STVhUeE1nUTV0MnJPNVUyOVhYYTI3?=
 =?utf-8?B?VWJBdkRQaGNIUjE5YnpDMGkwdDVLSk1OR2J6M04zWVA1WU9Va25RSURPcjJI?=
 =?utf-8?B?WTZockVFUzZsQy9VUUtIVERiMVFPU21JRkwyeGQyN2VhMFg5QjcvRHNhZis5?=
 =?utf-8?B?Ukt0Ly8vRW9yRGVUcnRMeUJGQjI3aUpCTUZjYTloMmRWcjBZSzN6K1l1cGJu?=
 =?utf-8?B?bklaZUQyUDhveDlTd0FPTnlqTTIrQ1hCZUFBVG83dlFtK2xFRkVGamJ5OTFt?=
 =?utf-8?B?Z042U1JReWV0SnlzSEJlZDBMV0taSHk3VUtMejIyUVQ2Y3VlbHZkMmxLd3Jv?=
 =?utf-8?B?d3R1UnQvMFZSY1NqdThPUkxBZUs3YnhEWnNKWWErV3M2a1VJbXV5R0ZHbEJx?=
 =?utf-8?B?RTcyLzhqeTRDcE1GdXdzbFE0MXoyK3Y1SytRZUQ2cEpwU3hiK1ZaYlNhK3hz?=
 =?utf-8?B?cXN1dEdmL3lJZkd1UEdxMGp6Ym5RMkdiQTJ0RTRHVTQ3R3phMzN4UGF5WVJC?=
 =?utf-8?B?MWR6citVUnV3STBnSE1qTnY5RnM3THpaMDRpSURqcW9EZkIxekJydUhHL1px?=
 =?utf-8?B?dFk5bS8zbU9IUlBhWFRPTG5aQ0kraUVuL3YvYU9jUzYrWlJuOEhCQVRCNHc5?=
 =?utf-8?B?TlNhMm5tdTAwdkRJRmlCejJIRUZ3TmQ1b1FPdjBkcmlUU3hqeHFIa0d5U3Rk?=
 =?utf-8?B?SkY3QWlWQW5UeGovdU9MV2FTeGJCMTdER1krcXJmdXJXYkhDS2JmeWF5Q0dS?=
 =?utf-8?B?eGhpb2Zkb2hkYWhSMlFYSXVCdGQycFdaQTdlNnN4ZjFKdWloc0xnWjBnbXRu?=
 =?utf-8?B?dGttVnF2eGViSlA4T0w4MzRCRVVMdGk5VThDU3kyK0JTbkxKWEMrYm95ZjNa?=
 =?utf-8?Q?nfrPdp848Gmz3zWYrY6cm9UUU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0337139496182409E0DEE897865D23F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46818e-2e17-4d3f-fab7-08dc0528a6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 09:05:33.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6gDGy7ljgQEWohXyVpl7k3V9qvDY7wVgn88CXZq8ZvBvZNWd9L3KItiGenRzS3G7XQRIONUoy+P8ao99xJwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5475
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.751200-8.000000
X-TMASE-MatchedRID: PL66URbwWA8OwH4pD14DsPHkpkyUphL9MZm0+sEE9mtpRtFovOTjTWeD
	iOVpb8s7N5zqN/saWGffDheQtmGHqTwij/SkStHmL/daYw3EVHyeEP0DdJruljUsHjosUACSmQJ
	6sUxppuJOFu8ssjxG8/FjRYaB9JwD2WeQjW7v2UECNMj/7qB/gxyDrkIwjihb8EzvgHT9P5qIMV
	4nweffzUKW569qkbFJhxfamrf2qxWbGHSBj+j5WYSvKOGqLLPK5Y0kb0hqatyM2ehTV+imiyb3O
	x4lhYcthjXRysqny34PHbXmBXByiNMsGRKm0bkEypeMiaCPnxvb4SkGdkTN9XOMCXNrYTWi1rfl
	znbz4mDsJbnEUDpZMnybR4oj90UAlh+IkeJQ88bYd2+/8wYTda19jpg9rDdhPPNQscfVdONnLsx
	vwfNLnUexP8F1neHmhwqZUMR8IWoryFHbNnBLG8nUTf2MoOKYKJfSpcAUv12XaPx34rRVKDQprF
	KxNRd04vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbtuRXh7bFKB7gaftQpRRj0hCwQj/
	SIpghKeORtFjCZevs/6To2Vbmc0lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.751200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B0CF683261263BB87C12E62A5EBDC1191EE71A0EF703962809E89A96C37561352000:8

SGksIEphc29uOg0KDQoNCk9uIFN1biwgMjAyMy0xMi0yNCBhdCAwMjoyOSArMDgwMCwgSmFzb24t
SkguTGluIHdyb3RlOg0KPiBGcm9tOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiANCj4g
QWRkIGFuIGludGVyZmFjZSB0byBhbGxvY2F0ZSBNZWRpYVRlayBHRU0gYnVmZmVycywgYWxsb3cg
dGhlIElPQ1RMcw0KPiB0byBiZSB1c2VkIGJ5IHJlbmRlciBub2Rlcy4NCj4gVGhpcyBwYXRjaCBh
bHNvIHNldHMgdGhlIFJFTkRFUiBkcml2ZXIgZmVhdHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgQm9p
Y2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIFph
YmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgS3Vy
dHogPGRqa3VydHpAY2hyb21pdW0ub3JnPg0KPiBSZXZpZXdlZC1ieTogTmljb2xhcyBCb2ljaGF0
IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQo+IFRlc3RlZC1ieTogRGFuaWVsIEt1cnR6IDxkamt1
cnR6QGNocm9taXVtLm9yZz4NCj4gVGVzdGVkLWJ5OiBQaS1Ic3VuIFNoaWggPHBpaHN1bkBjaHJv
bWl1bS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMgfCAxMyArKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5j
IHwgMzkgKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2dlbS5oIHwgMTIgKysrKysrDQo+ICBpbmNsdWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5o
ICAgICAgICB8IDU4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDEyMiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91
YXBpL2RybS9tZWRpYXRla19kcm0uaA0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gaW5kZXggMmIwYzM1Y2FjYmM2Li41ZDJhMzllNDkxYWEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC0yNCw2ICsyNCw3IEBA
DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9vZi5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1fcHJvYmVf
aGVscGVyLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV92YmxhbmsuaD4NCj4gKyNpbmNsdWRlIDxk
cm0vbWVkaWF0ZWtfZHJtLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4g
ICNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+IEBAIC01NjksNiArNTcwLDE0IEBAIHN0
YXRpYyB2b2lkIG10a19kcm1fa21zX2RlaW5pdChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZHJtKQ0K
PiAgCWNvbXBvbmVudF91bmJpbmRfYWxsKGRybS0+ZGV2LCBkcm0pOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGRybV9pb2N0bF9kZXNjIG10a19pb2N0bHNbXSA9IHsNCj4gKwlE
Uk1fSU9DVExfREVGX0RSVihNVEtfR0VNX0NSRUFURSwgbXRrX2dlbV9jcmVhdGVfaW9jdGwsDQo+
ICsJCQkgIERSTV9VTkxPQ0tFRCB8IERSTV9BVVRIIHwgRFJNX1JFTkRFUl9BTExPVyksDQo+ICsJ
RFJNX0lPQ1RMX0RFRl9EUlYoTVRLX0dFTV9NQVBfT0ZGU0VULA0KPiArCQkJICBtdGtfZ2VtX21h
cF9vZmZzZXRfaW9jdGwsDQo+ICsJCQkgIERSTV9VTkxPQ0tFRCB8IERSTV9BVVRIIHwgRFJNX1JF
TkRFUl9BTExPVyksDQoNCkZvciBzZWN1cmUgYnVmZmVyLCB3ZSBkb24ndCBuZWVkIG1hcCBvZmZz
ZXQgZnVuY3Rpb24uIElmIHlvdSByZWFsbHkNCm5lZWQgdGhpcyBmdW5jdGlvbiwgc2VwYXJhdGUg
dGhpcyB0byBhbm90aGVyIHBhdGNoIGFuZCBkZXNjcmliZSB3aHkNCm5lZWQgdGhpcy4NCg0KUmVn
YXJkcywNCkNLDQoNCj4gK307DQo+ICsNCj4gIERFRklORV9EUk1fR0VNX0ZPUFMobXRrX2RybV9m
b3BzKTsNCj4gIA0KPiAgLyoNCj4gQEAgLTU5MCw2ICs1OTksMTAgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkcm1fZHJpdmVyIG10a19kcm1fZHJpdmVyID0NCj4gew0KPiAgDQo+ICAJLmdlbV9wcmlt
ZV9pbXBvcnQgPSBtdGtfZHJtX2dlbV9wcmltZV9pbXBvcnQsDQo+ICAJLmdlbV9wcmltZV9pbXBv
cnRfc2dfdGFibGUgPSBtdGtfZ2VtX3ByaW1lX2ltcG9ydF9zZ190YWJsZSwNCj4gKw0KPiArCS5p
b2N0bHMgPSBtdGtfaW9jdGxzLA0KPiArCS5udW1faW9jdGxzID0gQVJSQVlfU0laRShtdGtfaW9j
dGxzKSwNCj4gKw0KPiAgCS5mb3BzID0gJm10a19kcm1fZm9wcywNCj4gIA0KPiAgCS5uYW1lID0g
RFJJVkVSX05BTUUsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9nZW0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+
IGluZGV4IDRmMmUzZmVhYmMwZi4uMzBlMzQ3YWRjYmU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiBAQCAtNCw2ICs0LDcgQEANCj4gICAqLw0KPiAgDQo+
ICAjaW5jbHVkZSA8bGludXgvZG1hLWJ1Zi5oPg0KPiArI2luY2x1ZGUgPGRybS9tZWRpYXRla19k
cm0uaD4NCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm0uaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJt
X2RldmljZS5oPg0KPiBAQCAtMjgzLDMgKzI4NCw0MSBAQCB2b2lkIG10a19kcm1fZ2VtX3ByaW1l
X3Z1bm1hcChzdHJ1Y3QNCj4gZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4gIAltdGtfZ2VtLT5rdmFk
ZHIgPSBOVUxMOw0KPiAgCWtmcmVlKG10a19nZW0tPnBhZ2VzKTsNCj4gIH0NCj4gKw0KPiAraW50
IG10a19nZW1fbWFwX29mZnNldF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLCB2b2lkICpk
YXRhLA0KPiArCQkJICAgICBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZHJtX210a19nZW1fbWFwX29mZiAqYXJncyA9IGRhdGE7DQo+ICsNCj4gKwlyZXR1cm4g
ZHJtX2dlbV9kdW1iX21hcF9vZmZzZXQoZmlsZV9wcml2LCBkcm0sIGFyZ3MtPmhhbmRsZSwNCj4g
KwkJCQkgICAgICAgJmFyZ3MtPm9mZnNldCk7DQo+ICt9DQo+ICsNCj4gK2ludCBtdGtfZ2VtX2Ny
ZWF0ZV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiArCQkJIHN0
cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZHJtX2dlbV9v
YmogKm10a19nZW07DQo+ICsJc3RydWN0IGRybV9tdGtfZ2VtX2NyZWF0ZSAqYXJncyA9IGRhdGE7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCW10a19nZW0gPSBtdGtfZHJtX2dlbV9jcmVhdGUoZGV2
LCBhcmdzLT5zaXplLCBmYWxzZSk7DQo+ICsJaWYgKElTX0VSUihtdGtfZ2VtKSkNCj4gKwkJcmV0
dXJuIFBUUl9FUlIobXRrX2dlbSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIGFsbG9jYXRlIGEgaWQg
b2YgaWRyIHRhYmxlIHdoZXJlIHRoZSBvYmogaXMgcmVnaXN0ZXJlZA0KPiArCSAqIGFuZCBoYW5k
bGUgaGFzIHRoZSBpZCB3aGF0IHVzZXIgY2FuIHNlZS4NCj4gKwkgKi8NCj4gKwlyZXQgPSBkcm1f
Z2VtX2hhbmRsZV9jcmVhdGUoZmlsZV9wcml2LCAmbXRrX2dlbS0+YmFzZSwgJmFyZ3MtDQo+ID5o
YW5kbGUpOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZXJyX2hhbmRsZV9jcmVhdGU7DQo+ICsN
Cj4gKwkvKiBkcm9wIHJlZmVyZW5jZSBmcm9tIGFsbG9jYXRlIC0gaGFuZGxlIGhvbGRzIGl0IG5v
dy4gKi8NCj4gKwlkcm1fZ2VtX29iamVjdF9wdXQoJm10a19nZW0tPmJhc2UpOw0KPiArDQo+ICsJ
cmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9oYW5kbGVfY3JlYXRlOg0KPiArCW10a19kcm1fZ2VtX2Zy
ZWVfb2JqZWN0KCZtdGtfZ2VtLT5iYXNlKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmgNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uaA0KPiBpbmRleCA3OGYyM2IwN2EwMmUu
LjkwZjNkMjkxNmVjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZ2VtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2Vt
LmgNCj4gQEAgLTQ2LDQgKzQ2LDE2IEBAIGludCBtdGtfZHJtX2dlbV9wcmltZV92bWFwKHN0cnVj
dCBkcm1fZ2VtX29iamVjdA0KPiAqb2JqLCBzdHJ1Y3QgaW9zeXNfbWFwICptYXApOw0KPiAgdm9p
ZCBtdGtfZHJtX2dlbV9wcmltZV92dW5tYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosDQo+
ICAJCQkgICAgICBzdHJ1Y3QgaW9zeXNfbWFwICptYXApOw0KPiAgDQo+ICsvKg0KPiArICogcmVx
dWVzdCBnZW0gb2JqZWN0IGNyZWF0aW9uIGFuZCBidWZmZXIgYWxsb2NhdGlvbiBhcyB0aGUgc2l6
ZQ0KPiArICogdGhhdCBpdCBpcyBjYWxjdWxhdGVkIHdpdGggZnJhbWVidWZmZXIgaW5mb3JtYXRp
b24gc3VjaCBhcyB3aWR0aCwNCj4gKyAqIGhlaWdodCBhbmQgYnBwLg0KPiArICovDQo+ICtpbnQg
bXRrX2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwN
Cj4gKwkJCSBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdik7DQo+ICsNCj4gKy8qIGdldCBidWZm
ZXIgb2Zmc2V0IHRvIG1hcCB0byB1c2VyIHNwYWNlLiAqLw0KPiAraW50IG10a19nZW1fbWFwX29m
ZnNldF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiArCQkJICAg
ICBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdik7DQo+ICsNCj4gICNlbmRpZg0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0uaA0KPiBiL2luY2x1ZGUvdWFwaS9k
cm0vbWVkaWF0ZWtfZHJtLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5mNGQ0NzU3N2M5NGUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9pbmNsdWRlL3Vh
cGkvZHJtL21lZGlhdGVrX2RybS5oDQo+IEBAIC0wLDAgKzEsNTggQEANCj4gKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZSAqLw0KPiAr
LyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAxNSBNZWRpYVRlayBJbmMuDQo+ICsgKg0KPiArICog
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vcg0KPiBtb2RpZnkNCj4gKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQo+ICsgKiBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbi4NCj4gKyAqDQo+ICsgKiBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4gKyAqIGJ1dCBX
SVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9m
DQo+ICsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBP
U0UuICBTZWUgdGhlDQo+ICsgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBk
ZXRhaWxzLg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX1VBUElfTUVESUFURUtfRFJNX0gNCj4g
KyNkZWZpbmUgX1VBUElfTUVESUFURUtfRFJNX0gNCj4gKw0KPiArI2luY2x1ZGUgPGRybS9kcm0u
aD4NCj4gKw0KPiArLyoqDQo+ICsgKiBzdHJ1Y3QgZHJtX210a19nZW1fY3JlYXRlIC0gVXNlci1k
ZXNpcmVkIGJ1ZmZlciBjcmVhdGlvbg0KPiBpbmZvcm1hdGlvbiBzdHJ1Y3R1cmUuDQo+ICsgKg0K
PiArICogQHNpemU6IHVzZXItZGVzaXJlZCBtZW1vcnkgYWxsb2NhdGlvbiBzaXplLg0KPiArICoJ
LSB0aGlzIHNpemUgdmFsdWUgd291bGQgYmUgcGFnZS1hbGlnbmVkIGludGVybmFsbHkuDQo+ICsg
KiBAZmxhZ3M6IHVzZXIgcmVxdWVzdCBmb3Igc2V0dGluZyBtZW1vcnkgdHlwZSBvciBjYWNoZSBh
dHRyaWJ1dGVzLg0KPiArICogQGhhbmRsZTogcmV0dXJuZWQgYSBoYW5kbGUgdG8gY3JlYXRlZCBn
ZW0gb2JqZWN0Lg0KPiArICoJLSB0aGlzIGhhbmRsZSB3aWxsIGJlIHNldCBieSBnZW0gbW9kdWxl
IG9mIGtlcm5lbCBzaWRlLg0KPiArICovDQo+ICtzdHJ1Y3QgZHJtX210a19nZW1fY3JlYXRlIHsN
Cj4gKwl1aW50NjRfdCBzaXplOw0KPiArCXVpbnQzMl90IGZsYWdzOw0KPiArCXVpbnQzMl90IGhh
bmRsZTsNCj4gK307DQo+ICsNCj4gKy8qKg0KPiArICogc3RydWN0IGRybV9tdGtfZ2VtX21hcF9v
ZmYgLSBBIHN0cnVjdHVyZSBmb3IgZ2V0dGluZyBidWZmZXINCj4gb2Zmc2V0Lg0KPiArICoNCj4g
KyAqIEBoYW5kbGU6IGEgcG9pbnRlciB0byBnZW0gb2JqZWN0IGNyZWF0ZWQuDQo+ICsgKiBAcGFk
OiBqdXN0IHBhZGRpbmcgdG8gYmUgNjQtYml0IGFsaWduZWQuDQo+ICsgKiBAb2Zmc2V0OiByZWxh
dGl2ZWQgb2Zmc2V0IHZhbHVlIG9mIHRoZSBtZW1vcnkgcmVnaW9uIGFsbG9jYXRlZC4NCj4gKyAq
ICAgICAtIHRoaXMgdmFsdWUgc2hvdWxkIGJlIHNldCBieSB1c2VyLg0KPiArICovDQo+ICtzdHJ1
Y3QgZHJtX210a19nZW1fbWFwX29mZiB7DQo+ICsJdWludDMyX3QgaGFuZGxlOw0KPiArCXVpbnQz
Ml90IHBhZDsNCj4gKwl1aW50NjRfdCBvZmZzZXQ7DQo+ICt9Ow0KPiArDQo+ICsjZGVmaW5lIERS
TV9NVEtfR0VNX0NSRUFURQkJMHgwMA0KPiArI2RlZmluZSBEUk1fTVRLX0dFTV9NQVBfT0ZGU0VU
CQkweDAxDQo+ICsNCj4gKyNkZWZpbmUgRFJNX0lPQ1RMX01US19HRU1fQ1JFQVRFCURSTV9JT1dS
KERSTV9DT01NQU5EX0JBU0UgKyBcDQo+ICsJCURSTV9NVEtfR0VNX0NSRUFURSwgc3RydWN0IGRy
bV9tdGtfZ2VtX2NyZWF0ZSkNCj4gKw0KPiArI2RlZmluZSBEUk1fSU9DVExfTVRLX0dFTV9NQVBf
T0ZGU0VUCURSTV9JT1dSKERSTV9DT01NQU5EX0JBU0UgKyBcDQo+ICsJCURSTV9NVEtfR0VNX01B
UF9PRkZTRVQsIHN0cnVjdCBkcm1fbXRrX2dlbV9tYXBfb2ZmKQ0KPiArDQo+ICsjZW5kaWYgLyog
X1VBUElfTUVESUFURUtfRFJNX0ggKi8NCg==

