Return-Path: <linux-kernel+bounces-15223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590D8228A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EC11F23BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D848179BE;
	Wed,  3 Jan 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TY7HPZWB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EgWF8ohj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C9179A4;
	Wed,  3 Jan 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e9bd10b8aa0411ee9e680517dc993faa-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uxIgKL+1ht6IguB/qNXDz+mvdJMltjLSWoWdzQgxeLc=;
	b=TY7HPZWBDe/I6zn1/4roq84Dkp3syJ4juCwnSS3NQCQUd8Jcs5f+Q+A2NMlSXHZtzGklQnJulm3GVcdaS67NZHfgOiTllz4urFOoDdgSaXe/sDGAXNcQKBXrHtWkdPJg1qhkOBY5B+bEhp3eVswAiAGhxOVPoAXj/9XzgZxjRbY=;
X-CID-CACHE: Type:Local,Time:202401031451+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:78ef6a57-3225-4597-a1f1-00c9334b1f14,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ec5f6f82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e9bd10b8aa0411ee9e680517dc993faa-20240103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2077218418; Wed, 03 Jan 2024 14:54:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 14:54:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 14:54:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+IrR9rxlNv4FdH2WkRtOhKRb1xqzpuQyyTU2ooguQrZATsM1tr7+2d3cxw0wKb89zIxtxZuBkVIU95dsQCXtC1sQYI7eRfcs4a6t3a5/yFvztfZ1kIdHT7C49qAKrRmCzDfphbE6z2GdWDzrIuUwEZ/qArW7smig3xcXXmSXGTLXlHGZUfIJAi63k/cuW0gTUUS7aJRER9ObpDY8heEjp488xShIsFqXI3ON4WhPFL9VBpYq5btVPgAuLER1Ac1BsOCIdxUhHblCTPvOHgnsM0ITXB4Dp4rgZBkYI+fvMc6q9ql0+AycYHh9uugH0ERsbF/KngpB8+zLEiB9Y33OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxIgKL+1ht6IguB/qNXDz+mvdJMltjLSWoWdzQgxeLc=;
 b=nvutGjvH7EWVIZQOM2zmFiiG1cufO0kidnWcLDWpxfn3Y31QL+teszHNZ8vSghKQaidRwHSoXH6uk2HYNYEwGDQ7HlxeeS1M1IMe6sYz3XyYd43lNTL+SKYDaGmCBum5WmITYkSBeJ2jk8htL8H2BCE6lXZWhPOwzaS2FC1Qd70zq1SyVicKzQx2E2RmGJxGvymCs6FUkysTOKXCKZC5JYX/JMd95xCqVT8aWB9uDS4zljtW8NSolZ8ec8yqn5MzGjzMBxzEIxK44yqV4vNDgMNOr6GfyhWyaiEhQN3N8sIAYGC76xxiqvQl2kC9+W9wtgc1yCP5eohosZqXQ5gmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxIgKL+1ht6IguB/qNXDz+mvdJMltjLSWoWdzQgxeLc=;
 b=EgWF8ohj1zHPcj5yPiWRj0FbL6cETtKxKJmAHKybsgtufpNg94+2nPNi9J7gJMecVEwMT0qaleCtjDNSdFC+r7LS1U0uYkg+iON0erfnoRR0yAe7wqXZKBHe4HhDC1vUREbmSksE2JPMikVfdq30J3v1H9K/9Cq2NLDvxWtpUQQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:54:14 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:54:14 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC+NRuAgAmFEYA=
Date: Wed, 3 Jan 2024 06:54:14 +0000
Message-ID: <557f2d60a56845fbb368a88318fc1e74b0e6f38f.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <0124eca6dfcd45af4c454ab1937590ca89a2a787.camel@mediatek.com>
In-Reply-To: <0124eca6dfcd45af4c454ab1937590ca89a2a787.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5605:EE_
x-ms-office365-filtering-correlation-id: 544c08a6-118c-44fe-700b-08dc0c28cc0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOQcq3wBuGEGP60k4u7CIQhqgLBpClbST3hf7BHDArNkhIyegrdbffvpOU/+HLTvJdyk5XowYbjVazlZhB/fDVKu1UV85PNO+S4lLGfkcC0RYP9Lodtc7hEgNE5rUDDYUAzbXq0048QOMP2z+CU1wpgy+Bul5GuqWT86cZwFIm8sLcuhrXB70YoddGVQito0ip8g/Amf4Qeg4OVtthXQtSrOagKrXoQ1MWKMKQdHWs9FBSwp0O0vE/HM5RWdA1ZsMsQWIvhs0qM/tfPKY5JcxOxY11mY2lA+zZiRKMiBXsHJy+37Sz9Kkw5sMZKVPP8d/wTRGwccxmLq+fMlKgsO5fIPpiLdHLSkA1jpZBN3T/n35xGOdu9uwe98Hl6H/L2WlnRz+o96xZISkKZ8N9W6gHAr0UkSf0L4O/xAV1CbD9zueX14aQp4DEwthtRgCvNMvfvsMorHSq5rdjCm2EP6LwCUWW7lwa+v0A5RiM0rYSV2o0k11oD4O9b3/9DnkV1KSChAK/GQZpqIhjktX4leNaakhjGxW9ws6/5hdhXWVfBbNi8gQEGbpd/CSRjv3HS20BQ+wpVdZcbNP6509kLLts2rHSosA4SN4Sfc0LJReU9u+tDhjb80Yd43M0f/l7lJmviraTSwVlfdYCb1iABgTikqKE98kicYnLjQCHBNM8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(83380400001)(4001150100001)(38100700002)(122000001)(110136005)(41300700001)(54906003)(8936002)(316002)(15650500001)(8676002)(5660300002)(7416002)(71200400001)(2906002)(4326008)(478600001)(66446008)(6486002)(66946007)(6506007)(64756008)(91956017)(76116006)(66556008)(6512007)(66476007)(38070700009)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlhFOElYT1B1bXBPNjZPTFdKZDZrQmtUVitCTkRhQ3N5cUw2MnBGaE42Zi9H?=
 =?utf-8?B?WkdudVpXT0RHMzBHeFg1MDFleFpFMFpoSUIxREg5VnhYQjdQZWFEdGpmcGRD?=
 =?utf-8?B?OElLbVhEb1NNTC9rM1U0cG94M1pMdGtPV0NmNkdVTmlVdThxQTNoQ0RLSTBH?=
 =?utf-8?B?YlFrNDM0dmlPcmoyWHhKWmZPK0dGb3NZTGlXMXg1b0tjNS9heFBZSGVsQm9S?=
 =?utf-8?B?ay9EN1R0Z0dNSC9zZVEyRzBCaXEzMlpnTjFMTFBIL3BVVHJGWkw0a1dBSVl5?=
 =?utf-8?B?THI4dWhEQmJzZCtjMFhMMXVYMDV6RDlWQytIMzdxNkhXS2t2SElBK2M4c1RF?=
 =?utf-8?B?b1Zab2lFVVdFc2NWK24wWXJqWS9IZjVGc0s2cGhYdWI1aDNFUTRmMkNPVHlu?=
 =?utf-8?B?ZHhVZVN0ZUIzMWpBb2pHNVc1RWxLcXJzVmpnMzVnNTNQdmNOWjJSSzl1YlZD?=
 =?utf-8?B?bjNHcmV2c3doWlRtekxyMjU1V0U2cXc1ZkhxQjlZbDNhdHRkYW5uaVZ2cVJx?=
 =?utf-8?B?Yzc4ZUJRRDlteitNeVV3ZzQrVjRHWTk5QTlRNmhJVmRkVTl0TjU2cXZYZ2xB?=
 =?utf-8?B?cGR2bHNMZ3A2Q2ovbnA2R2dsS2hnNXc3R0RhWlg1WHljT2srY0lKTHhYTWJV?=
 =?utf-8?B?VnR2cVZxeGhyV2Z1OSt2MEhVU1d2ZjhUMmdyWThIbGFuaDFXMU52WUtpaWds?=
 =?utf-8?B?WkJpZzZ0czhaYVRVSmNwc3hIemJrM3d2T1NzYnJseWVrbmJxUDJWR0RhSDRE?=
 =?utf-8?B?L21SZEN6NjFiN2l2KzZtaWR4ZjNwb2N2V3dzVXdDNjN5UHNCc0RiY2MzRHhk?=
 =?utf-8?B?M3dtR0ttcWxqL3llNVpVd0Z0UmtSU0FhWGVlOXJaOUlNN2FCZ3Y1eXhTMHdo?=
 =?utf-8?B?cjU3eEt4ZytrVGFnSGNzSkFVMkF2aEJPU2VxR0hXREZrNEUySzJRd0VTcHdU?=
 =?utf-8?B?QUlsYm84dXc4YVVRdWNEck40RnFqNEw5MVlBMzAwc0xXNWdINlFqVUpURHlD?=
 =?utf-8?B?YmlBWXZjQm1XQ1BYdFp6RERNU1Vqc3l2eWMvQnNSQ3ZsS2VkVmtQdkV6RTVD?=
 =?utf-8?B?S1JXRHcvdkRQMzJRZExkeE4rZ2xhalFZK3J6Y2RvZ0Y2N2Z6R3JzME51QmRl?=
 =?utf-8?B?L1QvWXU2RDRVcHJSNFJYQ0tKb3dDUTVmekVEQmxCMWFsTHpJRWdnM0U5TEZW?=
 =?utf-8?B?Vk43cG4vcEdnNkE5ejBVRy9ybi9iS3I4WE01bnFPaTJoVzhhV0pnMmQwUzhP?=
 =?utf-8?B?MW5qcHJKMGU2NFIxYW8xOW0zdXZNeTNMZENRKzUvS1ZaajUyVk1INjZCQ3l3?=
 =?utf-8?B?dTFjb1lBeVc0anVlZkNPZG10NkNOcVhkQ3lJZHBnanpsbzk3VElUb2ZBNElw?=
 =?utf-8?B?ZC9PVmk3UzArQ3N4dnJ5RlRtYThXVk1CK3NCZXh4endxT2gxdURQWGVsRFJu?=
 =?utf-8?B?dS92SGQwanBwWU5SU2sxSFBVYWVqY1JsTjJPWmdvMllpNytIZW1WYjBmOGhB?=
 =?utf-8?B?OVBubE9qeGNTT2hMNndXVUlpbldXa3U4M3NZQWtQSHdXV3V0S3VLTTdqQjlN?=
 =?utf-8?B?VTdzek4zc05zdUhVZmw1YWJtOVcvWlZXTysrOTJBVVBBM29La2pkbkJoY3JF?=
 =?utf-8?B?TENjVS9mRUNWZzNLeGd0Z0lTUWZ4cnB4UDJVZUtwTm8wclFCbDVYMGg3eUNh?=
 =?utf-8?B?WEtnR1VZT0UvRElTaXh2Y1hGd1V1RUpUblNVR2RwVytQUWlpSFN1b2RrTHFt?=
 =?utf-8?B?aitZenNnNm1iM1F6dGI2VmdSRWZDTGsxUENOcTJGcm9LcGJCZC9BQ1VUbDg3?=
 =?utf-8?B?NkxSbEV6ZDhwbHdwTEVmR01ONGR3UWc0anY1WDZtTmsxNkFOdGIrbkZPa3hW?=
 =?utf-8?B?UDY5SXphLzVONUJoU1RVQ3ZBalY4cjR3ZWEwdjBCWVE0L09XWEV5RytJclFi?=
 =?utf-8?B?OVJOWUR2eFYzY0RvTURnWTBDYnRkOHNlZkZpQ3RralNwSFdSZEUrcjdZOFpB?=
 =?utf-8?B?b0RKNURCZVVDVy92SjlxNFlDblFXdE8vYnRIOXhKVC9sczRDOWFBc05XbWJH?=
 =?utf-8?B?MEZaN3dPd1VFNm9DdXNUKzlwR3QxODQ3emM3Ri8wUThpZUthRS93bVRDU0l3?=
 =?utf-8?B?ejU3dTNYT3h2UFpkbXp1a3JZOSsxb0pBdmN3V2M2bU8rSWcwSTQ0U1ZheVpl?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <987863AD488DC649B124CBAD3091C9BA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544c08a6-118c-44fe-700b-08dc0c28cc0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 06:54:14.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOlE4h3C8gyCL/ur936Bo4lvomt/kmOQJ+QObumGVl7AhPSoDfsbZsILp2HNnw4S7eC84aTA9D7psbJKHh4hePvz7ppr1HA5UZjd2qUyC/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5605

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDA1OjMxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gRnJpLCAyMDIzLTEyLTIyIGF0IDEyOjUyICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBm
ZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFkL3dyaXRlDQo+ID4gcmVnaXN0Z2Vycw0KPiA+IGluIHRo
ZSBzZWN1cmUgd29ybGQuIEdDRSB3aWxsIGVuYWJsZSB0aGUgc2VjdXJlIGFjY2VzcyBwZXJtaXNz
aW9uDQo+ID4gdG8NCj4gPiB0aGUNCj4gPiBIVyB3aG8gd2FudHMgdG8gYWNjZXNzIHRoZSBzZWN1
cmUgY29udGVudCBidWZmZXIuDQo+ID4gDQo+ID4gQWRkIENNRFEgc2VjdXJlIG1haWxib3ggZHJp
dmVyIHRvIG1ha2UgQ01EUSBjbGllbnQgdXNlciBpcyBhYmxlIHRvDQo+ID4gc2VuZGluZyB0aGVp
ciBIVyBzZXR0aW5ncyB0byB0aGUgc2VjdXJlIHdvcmxkLiBTbyB0aGF0IEdDRSBjYW4NCj4gPiBl
eGVjdXRlDQo+ID4gYWxsIGluc3RydWN0aW9ucyB0byBjb25maWd1cmUgSFcgaW4gdGhlIHNlY3Vy
ZSB3b3JsZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpo
LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+
ICtzdGF0aWMgc3RydWN0IG1ib3hfY2hhbiAqY21kcV9zZWNfbWJveF9vZl94bGF0ZShzdHJ1Y3QN
Cj4gPiBtYm94X2NvbnRyb2xsZXIgKm1ib3gsDQo+ID4gKwkJCQkJCWNvbnN0IHN0cnVjdA0KPiA+
IG9mX3BoYW5kbGVfYXJncyAqc3ApDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjbWRxX3RocmVhZCAq
dGhyZWFkOw0KPiA+ICsJc3RydWN0IGNtZHFfc2VjX3RocmVhZCAqc2VjX3RocmVhZDsNCj4gPiAr
CWludCBpZHggPSBzcC0+YXJnc1swXTsNCj4gPiArDQo+ID4gKwlpZiAobWJveC0+bnVtX2NoYW5z
IDw9IGlkeCkgew0KPiA+ICsJCXByX2VycigiaW52YWxpZCB0aHJkLWlkeDoldSIsIGlkeCk7DQo+
ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJdGhy
ZWFkID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKW1ib3gtPmNoYW5zW2lkeF0uY29uX3ByaXY7DQo+
ID4gKwl0aHJlYWQtPmNoYW4gPSAmbWJveC0+Y2hhbnNbaWR4XTsNCj4gPiArCXRocmVhZC0+cHJp
b3JpdHkgPSBzcC0+YXJnc1sxXTsNCj4gPiArCXNlY190aHJlYWQgPSBjb250YWluZXJfb2YodGhy
ZWFkLCBzdHJ1Y3QgY21kcV9zZWNfdGhyZWFkLA0KPiA+IHRocmVhZCk7DQo+ID4gKwlzZWNfdGhy
ZWFkLT50aW1lb3V0X21zID0gQ01EUV9OT19USU1FT1VUOw0KPiANCj4gVGhlIHRpbWVvdXRfbXMg
Y291bGQgb25seSBiZSBDTURRX05PX1RJTUVPVVQsIHNvIHRoaXMgZHJpdmVyIGp1c3QgaGFzDQo+
IG5vIHRpbWVvdXQuIFNvIGRyb3AgdGltZW91dF9tcy4NCj4gDQoNCk9LLCBJJ2xsIGRyb3AgdGhp
cy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+
ICsNCj4gPiArCXJldHVybiAmbWJveC0+Y2hhbnNbaWR4XTsNCj4gPiArfQ0KPiA+IA0K

