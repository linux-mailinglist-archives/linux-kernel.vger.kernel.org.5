Return-Path: <linux-kernel+bounces-15228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A18228C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1BEB22513
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57B1803D;
	Wed,  3 Jan 2024 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D9H9HQu8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="a5/nfdVx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74697179B5;
	Wed,  3 Jan 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cde20206aa0711ee9e680517dc993faa-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LNIIGmYVK/aAoDSPBxQSzDo5F9ii79Sa4h+twSgEJF4=;
	b=D9H9HQu8t2LqT1KkK6/kQg7A1VskVVOmgKtTxdaaaZRcnvl4+DIl1dD3N2LZKR4DRQL3ZQR/3aNyOB30GYwKgKO0Mt4KocZNhJFTqw6ioeDi0MpHu5vNxbsvv1dcOU35OBx69EJnIop1j7rlLKRU3xht+CNozhKQUPdiAGFQhjI=;
X-CID-CACHE: Type:Local,Time:202401031451+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:502b021c-619d-4ace-9ce2-c095ea05cdaa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ec5f6f82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cde20206aa0711ee9e680517dc993faa-20240103
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2013170906; Wed, 03 Jan 2024 15:14:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 15:14:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 15:14:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcnLKjrXKXYkzGl7xEsq3Q1BOrr2WfA+EhY3llYhZFfKjtUJHmOUTkJqALmG/SSRn534xQEqnW7iqh0bUTMFXMZHU+iAnTuXoNuqmX9OSkV65Y25/JLq6HdiEHVgdxaTJWQUlc3INAPbrPj0gHGyt0VZ9mX40WrnS81cfIlEHU9RjXaldsnU7Pgzjf+Sz4I7SNonMBZqxnZ14BN5Ej0OvUb+jbw96ZId1tj1DRxrv9PM2rIjd4kAaL3fvO9+YNyNLWCXX59gYKaVNRuq4h/yER8zSGPBqLqaqUukrV8mrsEF2+HjoZ00/ANFDqdhA4Kub5pH4bsgnwbeP7C6TTj38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNIIGmYVK/aAoDSPBxQSzDo5F9ii79Sa4h+twSgEJF4=;
 b=i9tflvwHBfHH76HII0xJsSFNsHseNO6d9lGG6m+mk9sntI9TyMjQZfGT5nEuH3My2Lqn8hnJL7jOpVxfDMKf48QYA6Gz+781G4A22YjbaLapOF3ukEW6bFhyMOKx2M9NOw8sRJE/dFwl0OXkIBxIiyP3bnrWaAet/HpvIK7hk+2XakVU/SjEtfLj3sdQkx8bqAvBRsmurdAVb4/FMUTa2sgovQutZVtfluPtJMpARko2JXPx3D7GIrmqO+Nx5TOAlzmupezBLg/oZoWeo8imWs4SLH+Zi8yReD/DC4acXWqXbG6VqxrItcQkJt1NgsKnnPgz22IkihY3I/cqAwM1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNIIGmYVK/aAoDSPBxQSzDo5F9ii79Sa4h+twSgEJF4=;
 b=a5/nfdVxLFlIqwmDrfqAKCMKTg4tZ/1LQ163iKHaN5A8jdmLwBBIxnln8YWJBEs+o9HdG9j08GufxhIuHJmPqcGD7jEQwUC3j1lwi8gg99oEVuYSvx+9pRt2yOXz1NcW8UCbq7QgsVPTEjpXEESt32//gnw6IBFiGKJgQTilqOo=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB6227.apcprd03.prod.outlook.com (2603:1096:820:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 07:14:54 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:14:54 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC/gxcAgAg824A=
Date: Wed, 3 Jan 2024 07:14:54 +0000
Message-ID: <519df4d65db2904f3c9c27f73b47b9268c9ec049.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <1b21f5bfa561b049193742804de42a1c03500a73.camel@mediatek.com>
In-Reply-To: <1b21f5bfa561b049193742804de42a1c03500a73.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB6227:EE_
x-ms-office365-filtering-correlation-id: 2dd34540-8a33-4eea-31c2-08dc0c2baf3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgJKvP/x6WGZ1M97gZI/bwqp6Xc3CD371XXWR/3MmGMnA9Jo6q7yPBPVRAsMrdjgfgW+oq36BYh5WSCLdAFVJ/iVOsb6LCc6SynspJDv529grey/AtIizePldi1Bvk3ZJRJ8BfbiwgoRRStJ/JjMjl3RWqZBUy0MsQuW16VUjEhdSYYjSKajXBLMk1jMcJgMlk534jDxiYQ+2TkTRbA7J3A1ebqDPKH5VQy+FkEnhT2x+wo7Z22+eT77xD57Te4eRZ/SZ9UlY0TxKX8pd2aaouCCH4J5Sq+J0bRvspbPRB04qgaPtFQcQ1FS7GA20jHnYt+Csno5uFLsVJq2OARHSkXHG2HlgMO92XKw04dtqqaymTy1IYEzCeLZOxJtS4lFPIP0rW1aoBecQeDifXB4WiaISE66DN8zn4cEhXur7V8cfsuEpGdsx2thtC6yLP5DpfqBZ2XI/JJCQ3+NGBfsihhBjPNOCLfoSMHAUxMtBSl1sj5UTeDO3WopXIZNOrWr0fh8VFYKziVTvncOncvoDucg6QQCY/3mtvy3Mr7HsKn2W2kNUszNaOwCkanGWktI28r9qeRGQcpfIK9QgRXoaw163mmVrlmjmFh7KsAKqJWNYOBEiz59aPU2FKfwPU2PjlLTLIeV1IG3RuceIeswo9mjZG1HSuzn3iaRXApmqsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(2906002)(4001150100001)(66446008)(66946007)(8676002)(8936002)(85182001)(41300700001)(86362001)(36756003)(38100700002)(478600001)(122000001)(4326008)(71200400001)(91956017)(83380400001)(76116006)(6506007)(6486002)(66476007)(66556008)(64756008)(110136005)(26005)(5660300002)(316002)(54906003)(2616005)(6512007)(15650500001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hFOGU3Q0NPY1VjUlE2MXlTV0V4YUtSdVVZWERPUWNDKzZla0xaakpra2dL?=
 =?utf-8?B?NWcvQVo5NFBmVFBtSEM2eUpXVXZWbnJWOGt0Z0hZSjhCMENLVCtXZXlFbTVG?=
 =?utf-8?B?dmlldnQ5V2dpeUZmRWtvaEoxSzM4TCt3eGFIK3RVc2UzbG9DWUdPRmYrRThW?=
 =?utf-8?B?aEVmT3Y4eVlvL1QxMU56S05uVnVVOFNUczBSaFYrMVNiME9FU3N1UGowQkdD?=
 =?utf-8?B?dzk3dnlmYnBWa2swdHg4bUdHSWZISzlPZG45SGVidzRMVFNLSWgvdTFTMHZG?=
 =?utf-8?B?T3MwY3JBTE9zV2RueCtRelVFZ2EzaGFER25KSEdJS0FldVd6Rk00b0l2d1hi?=
 =?utf-8?B?MlB6ZTlWWSt0QmR3Qmd5ME1IYW5yR0FsNFBjeEl3TEVNOUl4WHpSc2EyNity?=
 =?utf-8?B?NDVsU3dzaTd5dGN6bm1XcTZ1OHp2TkhpYlFac0FBdk9nTHdzUTJNczcwcThB?=
 =?utf-8?B?UndHVzFENVpvOGJ2cDV3Z0JEOVVqc1Qvb0FaRldyMFBkejh0azZCVndlZG5S?=
 =?utf-8?B?akc4cmNUQXZJekVKVTRSTFlQMHI2K2haNWxkeU03aWlVdW5xaVRRVjE3aGZJ?=
 =?utf-8?B?ZGRMM25zd0k1QmpJMDRSRVlpQUQ0OTVmKzFJZTZ0d0J5UTRETWF2d29XV1Fj?=
 =?utf-8?B?Q2ZydGtRKzd3L1I3cWlVVTZKNmVXQnQxb0oyZ0tJS25qa0lDY1VGVCtKcXlD?=
 =?utf-8?B?dFBmTTRpQ0VTbEtkMU9IenlkVFB1L2dYbGR5Zk5Pa0d2aFduQTZ1dXVleEkr?=
 =?utf-8?B?U3NtT2E3Tzk1dDlqcFBhbUdYcWJQRDJuTTBRbkFQQUxsckU0OTZ6bXBOMEVw?=
 =?utf-8?B?WVpxMzBrdXMyS0N0NVd6YVpJb1F5WVBLbVZDRTQrSmJQU2wxaHFSTFRaWTVC?=
 =?utf-8?B?NEg5cHVid1c2dEtVZ0N1WWFLVjFNaDhNVmJSTmFLWGlRUElUR3V3ZEVMR3Zw?=
 =?utf-8?B?eCtvMG01MFNtRmZ0WDBqSFNhTDJCQk43YkxaVVpTeVBUSHJuenRQbW5ISkR0?=
 =?utf-8?B?TjYxdk9KU3lOVmFoNmFLWllPRlJQODdxa0hLbVVrTk00ZkcwVmhMblpWWkJ6?=
 =?utf-8?B?V3lDNHNFK1hTcHBTaGNlYmxrSElRbUxHZnlNbzhVVGRkbzZMdXpwSTFWdWRH?=
 =?utf-8?B?YVcyRFU1RG1rK1VZdFhUM1VxOHN5eG5rbVVMZUtiZDIrQ1lnSVBISFliMWkx?=
 =?utf-8?B?bEhNOWZpZVh3UnJ3YUw5UVdJUFh0bWVpTHdobHNXS0thb1JocDUxR0w0WEJk?=
 =?utf-8?B?RzAzY2dLV2FNQU03aWRlRkVVTTI3YlRsNy81R1JXQisvek5OTUpjTW11K0J0?=
 =?utf-8?B?WWJhcWgwYUYwZzYrUURBd2x6WDBlQy92emczbkpjWUFIOEZ6QmozZzBLY1Rz?=
 =?utf-8?B?TXRVOE5WQnBaV3NqNDhKSUduMko3VjY5QW5rdEVQWDRUcjAwcDdpMzBhYzN4?=
 =?utf-8?B?akpUUHR0d3VrK0YxQ0xJNStsSGwxSnNSQTV1alRVVGdSV015QmhJTHhadTFk?=
 =?utf-8?B?cENOaUZNQUxVbURLd1BMVkhvV2FPV1RJNjlkRGhlM3ZGek5pME4rYVYxWEJr?=
 =?utf-8?B?MFViaUNnVUpmNHJTdkZjZjVUMFJGdXpzNlZOSGt3LytaZXBmbXVvcVFyR0ZQ?=
 =?utf-8?B?UlNkUmgzVUdRTmJ0dzZtWDF2QzRPaVJmWHUzYjVXRXM2aVpvTTZjRzE4QjFG?=
 =?utf-8?B?QXljYlp3d2FiNjROUFpucGlvTDI2MzJHTWpLay9PZDNKM3RLT1pMd09Ld0xG?=
 =?utf-8?B?SUNmZkhrRCs5VDFnR0ZxQS9LWGZ6WEZlb21icEQrVkRFRjFvWk9KaXlZZzNv?=
 =?utf-8?B?VlZMRkdhYU5hVFBYNC9DZXNBS2o3dVo5UTRkNVNkMFZCdE9DVDFRbjRXaDM1?=
 =?utf-8?B?T3RzZVQvN0MyZW1wZVVLOE5ka2wrUmpRN1lSUzBPUWdibzJpUG1UWTRhZkwx?=
 =?utf-8?B?K2U4Q0NrRzlZT0NTR21nWEFBUURlRDI2Ym8xQmlkRG5Scy9TZFNtWDMvc0FM?=
 =?utf-8?B?YW9NN3Bmd252Mm90VkwzSDA0WEp5VWRTS1lYVmQwOTZBVk9EQ3hTVkJ3SUlv?=
 =?utf-8?B?VnVQKy8xSm1KL3lUdGw1M3g3ekVIUW1HenpWK1BpY29QNTcwSVNEdUdKK0FY?=
 =?utf-8?B?azRrN1NSbHFzaXEvc0lwS3plR3hZRXB3WnphSkRCWFVYREhsQTZlT3N1YlM0?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C6C1683BD36A429C9986422E36D003@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd34540-8a33-4eea-31c2-08dc0c2baf3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 07:14:54.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63etlLMpWGdAXv2SUAgXwdSEBiUzoe8CJZ3NuyXZk+TAkvWSr4OesBE27AVkU0mFHqvxM24zc1hncNbPsTY5CmV/s7ySxFFAkLsnRg1//fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6227
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.628600-8.000000
X-TMASE-MatchedRID: VfovoVrt/oYOwH4pD14DsPHkpkyUphL9fjJOgArMOCb3bBqxmjinTbs0
	9RsYKeKEiUqxWFzqa/9QGF7v4Up8Fw9FV6kNYiPHbc297PAGtWaQoBr+SFneJHPBWZjlMys28ha
	W4U9IrFpp2AbuTNMCFDjMd1TWYQcaeu/cjehQEBPRfDQgu+j+5SlayzmQ9QV0dow/ybqqTpKnXh
	ADgppWjac5LlJnbvbUuv8Bby3ll4azOchXTgjX0bMsPmSZxbpk7yWPaQc4INQxBvTc7v9+ZyWV0
	qXgzOhKLpw4iGWM/UudqC2fLtk9xEL9tcyTZdAsgxsfzkNRlfLdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.628600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DEE1356E8D5AB2B8A9ABC6FF0107CC4F639ECBCDFB0B7D6777D4D73C80EF6A882000:8

T24gRnJpLCAyMDIzLTEyLTI5IGF0IDAxOjI3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
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
ICtzdGF0aWMgaW50IGNtZHFfc2VjX3Nlc3Npb25fc2VuZChzdHJ1Y3QgY21kcV9zZWNfY29udGV4
dCAqY29udGV4dCwNCj4gPiArCQkJCSBzdHJ1Y3QgY21kcV9zZWNfdGFzayAqc2VjX3Rhc2ssIGNv
bnN0DQo+ID4gdTMyIGl3Y19jbWQsDQo+ID4gKwkJCQkgY29uc3QgdTMyIHRocmRfaWR4LCBzdHJ1
Y3QgY21kcV9zZWMNCj4gPiAqY21kcSkNCj4gPiArew0KPiA+ICsJaW50IGVyciA9IDA7DQo+ID4g
Kwl1NjQgY29zdDsNCj4gPiArCXN0cnVjdCBpd2NfY21kcV9tZXNzYWdlX3QgKml3Y19tc2cgPSBO
VUxMOw0KPiA+ICsNCj4gPiArCWl3Y19tc2cgPSAoc3RydWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAq
KWNvbnRleHQtPml3Y19tc2c7DQo+ID4gKw0KPiA+ICsJbWVtc2V0KGl3Y19tc2csIDAsIHNpemVv
ZigqaXdjX21zZykpOw0KPiA+ICsJaXdjX21zZy0+Y21kID0gaXdjX2NtZDsNCj4gPiArCWl3Y19t
c2ctPmNtZHFfaWQgPSBjbWRxLT5wZGF0YS0+aHdpZDsNCj4gPiArCWl3Y19tc2ctPmNvbW1hbmQu
dGhyZWFkID0gdGhyZF9pZHg7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChpd2NfY21kKSB7DQo+ID4g
KwljYXNlIENNRF9DTURRX0lXQ19TVUJNSVRfVEFTSzoNCj4gPiArCQllcnIgPSBjbWRxX3NlY19m
aWxsX2l3Y19tc2coY29udGV4dCwgc2VjX3Rhc2ssDQo+ID4gdGhyZF9pZHgpOw0KPiA+ICsJCWlm
IChlcnIpDQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIENN
RF9DTURRX0lXQ19DQU5DRUxfVEFTSzoNCj4gPiArCQlpd2NfbXNnLT5jYW5jZWxfdGFzay53YWl0
X2Nvb2tpZSA9IHNlY190YXNrLQ0KPiA+ID4gd2FpdF9jb29raWU7DQo+ID4gDQo+ID4gKwkJaXdj
X21zZy0+Y2FuY2VsX3Rhc2sudGhyZWFkID0gdGhyZF9pZHg7DQo+ID4gKwkJYnJlYWs7DQo+ID4g
KwljYXNlIENNRF9DTURRX0lXQ19QQVRIX1JFU19BTExPQ0FURToNCj4gPiArCQlpZiAoIWNtZHEt
PnNoYXJlZF9tZW0gfHwgIWNtZHEtPnNoYXJlZF9tZW0tPnZhKSB7DQo+ID4gKwkJCWRldl9lcnIo
Y21kcS0+bWJveC5kZXYsICIlcyAlZDogc2hhcmVkX21lbSBpcw0KPiA+IE5VTEwiLCBfX2Z1bmNf
XywgX19MSU5FX18pOw0KPiA+ICsJCQlyZXR1cm4gLUVGQVVMVDsNCj4gPiArCQl9DQo+ID4gKwkJ
aXdjX21zZy0+cGF0aF9yZXNvdXJjZS5zaXplID0gY21kcS0+c2hhcmVkX21lbS0+c2l6ZTsNCj4g
PiArCQlpd2NfbXNnLT5wYXRoX3Jlc291cmNlLnNoYXJlX21lbW95X3BhID0gY21kcS0NCj4gPiA+
IHNoYXJlZF9tZW0tPnBhOw0KPiA+IA0KPiA+ICsJCWl3Y19tc2ctPnBhdGhfcmVzb3VyY2UudXNl
X25vcm1hbF9pcnEgPSAxOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQli
cmVhazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwljbWRxLT5zZWNfaW52b2tlID0gc2NoZWRfY2xv
Y2soKTsNCj4gPiArCWRldl9kYmcoY21kcS0+bWJveC5kZXYsICIlcyBleGVjdXRlIGNtZHE6JXAg
c2VjX3Rhc2s6JXANCj4gPiBjb21tYW5kOiV1IHRocmVhZDoldSBjb29raWU6JWQiLA0KPiA+ICsJ
CV9fZnVuY19fLCBjbWRxLCBzZWNfdGFzaywgaXdjX2NtZCwgdGhyZF9pZHgsDQo+ID4gKwkJc2Vj
X3Rhc2sgPyBzZWNfdGFzay0+d2FpdF9jb29raWUgOiAtMSk7DQo+ID4gKw0KPiA+ICsJLyogc2Vu
ZCBtZXNzYWdlICovDQo+ID4gKwllcnIgPSBjbWRxX3NlY19leGVjdXRlX3Nlc3Npb24oJmNvbnRl
eHQtPnRlZV9jdHgsIGl3Y19jbWQsDQo+ID4gQ01EUV9USU1FT1VUX0RFRkFVTFQpOw0KPiA+ICsN
Cj4gPiArCWNtZHEtPnNlY19kb25lID0gc2NoZWRfY2xvY2soKTsNCj4gPiArCWNvc3QgPSBkaXZf
dTY0KGNtZHEtPnNlY19kb25lIC0gY21kcS0+c2VjX2ludm9rZSwgMTAwMDAwMCk7DQo+ID4gKwlp
ZiAoY29zdCA+PSBDTURRX1RJTUVPVVRfREVGQVVMVCkNCj4gDQo+IE1heWJlIGZvciBzb21lIGNs
aWVudCBkcml2ZXIsIDEgbXMgaXMgdG9vIGxvbmcsIGFuZCBmb3Igc29tZSBjbGllbnQNCj4gZHJp
dmVyIDEgc2Vjb25kIGlzIG5vdCBsb25nLiBTbyBJIHRoaW5rIHRoZSB0aW1lb3V0IGRldGVjdGlv
biBzaG91bGQNCj4gYmUNCj4gZG9uZSBieSBjbGllbnQgZHJpdmVyLiBBbmQgdGhlIGV4ZWN1dGlv
biB0aW1lIGRlcGVuZCBvbiB0aGUgY29tbWFuZA0KPiBidWZmZXIgZ2VuZXJhdGVkIGJ5IGNsaWVu
dCBkcml2ZXIsIHNvIG9ubHkgY2xpZW50IGRyaXZlciBoYXMgdGhlDQo+IGFiaWxpdHkgdG8gZGVi
dWcgdGhlIGNvbW1hbmQgYnVmZmVyIGl0IGdlbmVyYXRlZC4gU28gaXQncyBub3QNCj4gbmVjZXNz
YXJ5DQo+IHRvIGRldGVjdCB0aW1lb3V0IGluIGNtZHEgZHJpdmVyLg0KPiANCj4gUmVnYXJkcywN
Cj4gQ0sNCj4gDQoNCk9LLCBJJ2xsIHJlbW92ZSB0aGlzIHRpbWVvdXQgZGV0ZWN0aW9uIGluIGNt
ZHEgZHJpdmVyLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiArCQlkZXZfZXJyKGNt
ZHEtPm1ib3guZGV2LCAiJXMgZXhlY3V0ZSB0aW1lb3V0IGNtZHE6JXANCj4gPiBzZWNfdGFzazol
cCBjb3N0OiVsbHV1cyIsDQo+ID4gKwkJCV9fZnVuY19fLCBjbWRxLCBzZWNfdGFzaywgY29zdCk7
DQo+ID4gKwllbHNlDQo+ID4gKwkJZGV2X2RiZyhjbWRxLT5tYm94LmRldiwgIiVzIGV4ZWN1dGUg
ZG9uZSBjbWRxOiVwDQo+ID4gc2VjX3Rhc2s6JXAgY29zdDolbGx1dXMiLA0KPiA+ICsJCQlfX2Z1
bmNfXywgY21kcSwgc2VjX3Rhc2ssIGNvc3QpOw0KPiA+ICsNCj4gPiArCWlmIChlcnIpDQo+ID4g
KwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwljb250ZXh0LT5zdGF0ZSA9IElXQ19TRVNfT05f
VFJBTlNBQ1RFRDsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K

