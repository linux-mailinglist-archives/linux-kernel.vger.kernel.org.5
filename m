Return-Path: <linux-kernel+bounces-41165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354483ECCB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33651F22C42
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7491F61C;
	Sat, 27 Jan 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NvJinATL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wTymYTJa"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8273D6C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353448; cv=fail; b=g/qjcJajKqY5LOTDZoqxrqnOJGIuIasxtlZJF5Y+b2CZfMu+p6FJ5lqwYfygFp4snADtEq4ZpS38cYoULXtdJPmzAuZQcDPB+jUkDVrN5D8z0ofYrl5s/jRcEy+iMekZtrtQAnPmMEmWRc5uboD3LmuIYEVgZ7zprIOI0upP/5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353448; c=relaxed/simple;
	bh=9izs5glMs3yRYFE9dG1piORZeaE4gtNALimeba/Be7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOmcw5uv2/iSh8mqEhVdNQk3gB0lotAz97JbPsBuH6WMUWYwnrWtXr6WHwZ0lAkjwZatuYjbZeazNJH/lo1bJaOtCu3vTQ9wBEr+/qSi3mLcZJcOV6w4/gxFgL5tJcIMEcVWtiWTb+/k4x4H0l5E0NFuinorP5v0rDlkI9BZpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NvJinATL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wTymYTJa; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c27640a8bd0311eea2298b7352fd921d-20240127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9izs5glMs3yRYFE9dG1piORZeaE4gtNALimeba/Be7k=;
	b=NvJinATLLSJNI2UQ+c3dtBxY0Gqd64Qk8adq+wAkReQ1KuQSOlcY35iREzKhxAiLcR+lyn7mX/TmQGDIk5CcqmIg8vNW1si4v0AU1gE0Q7qWvO6YmxDCFJvnHHFgBUuDCkaqIBqOU6uxzByhmFm0EenAc4mPpZ6QxWNvxZHyr6E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:799614e8-5949-44c0-ab77-7f091a460810,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:0d89b78e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c27640a8bd0311eea2298b7352fd921d-20240127
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <haiqiang.gong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2080532813; Sat, 27 Jan 2024 19:03:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 27 Jan 2024 19:03:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 27 Jan 2024 19:03:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX0YK8EE9li91AMgoRuH8hZ1Nx/gkS5GLcXkigOWk6uZBmuj1jUj2WH6Jd59v773pz8vRY+7EWLQztqha+hG0/fZmfNIjzfSJEmMeX8nK5ymbnPP3RY9Qs2XZCJW1pjo71NH5s0Nf7T+T5+wI4bJr61PCgEfK2zhl494I/P/04tIz02IEjDcaNe1ve7G7qQ5LoZAi3rovxcz/agvfv/vteFIAvusZ/P0KpVQRPm87CUcZO1WJLkUjJ1yKcrmRMkOMAtBSS9zvshnzPX9lkeZ72xDRGJ4spr9pCTpEYO/M5J75sBPr987gkskY2bpDsR9W835QQPdShm22XqxGtBzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9izs5glMs3yRYFE9dG1piORZeaE4gtNALimeba/Be7k=;
 b=dlbL8z9wVvNlilJWr1JVuXlpLxs8uxVs+E3EDNCSmErmYaUTMTZcya3MTuU00R/19TXdhVb6EV5v/m4DWec50Uhb1e7RWWzRRnXzlJ0Qo7P02VERE5Wt13GkfHv59dke3zy9AmOwDyDPZIor61eHz7lhVVjj2xqSdRoeHYHRJhpcDi+4wKNgMNnZ50xzQdWYw5SNfv5AlqDieq9dRLbfCRkA8U46jb/MEnyT2y3uCt1ouel0W/fpGIv2JByGtt6w9IHIvNrM3gNx+aPeWEbMxZRmalPqWxu2kyFLhwqSDPqGVgu81LDjl4potgpMZbm/f90fkOfu+hkPxW8DdNmvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9izs5glMs3yRYFE9dG1piORZeaE4gtNALimeba/Be7k=;
 b=wTymYTJaYj+XYsBRBu0aK8UVE1FBq3I3yY/n8TmBCSME0HtK+5yH5qoxiYuLCFnhjUVmzep2RLuR17YieNwn5L4NeXCuyfzT7VTtmpG/9UWLUlnJZ3vDBV32r0ljhVXnmsefzjWzUhVbA/yqeQp0pmbQ+NnZXehmh1S8tRfDtCI=
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com (2603:1096:990:a1::10)
 by TYSPR03MB8131.apcprd03.prod.outlook.com (2603:1096:400:471::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.30; Sat, 27 Jan
 2024 11:03:50 +0000
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb]) by JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb%3]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 11:03:49 +0000
From: =?utf-8?B?SGFpcWlhbmcgR29uZyAo6b6a5rW35by6KQ==?=
	<Haiqiang.Gong@mediatek.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?TWlrZSBaaGFuZyAo5byg5Lyf5LyfKQ==?= <Mike.Zhang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: =?utf-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBtbS9jb21wYWN0aW9uOiBhZGQgY2hlY2sg?=
 =?utf-8?Q?mechanism_to_avoid_cma_alloc_fail?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tL2NvbXBhY3Rpb246IGFkZCBjaGVjayBtZWNo?=
 =?utf-8?Q?anism_to_avoid_cma_alloc_fail?=
Thread-Index: AQHaTNn7A5RvAL1alUa4iZhYRPGYZrDlLS+AgANkdoCAAL4ogIAEN3+A
Date: Sat, 27 Jan 2024 11:03:48 +0000
Message-ID: <0da9c1215291afeebe2cd99b0d8691c7fe6bde3a.camel@mediatek.com>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
	 <Za3hf6A4V5QECvDy@casper.infradead.org>
	 <JH0PR03MB8809FC349066C215C28DE119947B2@JH0PR03MB8809.apcprd03.prod.outlook.com>
	 <ZbFZh-E7BZEGm_Ed@casper.infradead.org>
In-Reply-To: <ZbFZh-E7BZEGm_Ed@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8809:EE_|TYSPR03MB8131:EE_
x-ms-office365-filtering-correlation-id: 92d6fddc-cdd3-4d8e-3dfd-08dc1f27a3a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbE89AG/g1M62Lszy25O0q58uSqQEHnHgh0G6Ldt6/k1aTtk1QKr8zW7vB3WAb7zSTZHPFs4fHQpT0CzJ9Ypev4wtR0XXYMGf6QjnQZP7B1HLXdSSOxd2A8Gd1TwJbo6fTjrYWpj6aBFoT2q179x/jVqROZTSWFvJoFgNdaNZ1O3GRHQHW7bgAh4ybKijcTlQe/QMkPbJwWAdi/CpggyZS9zPkwhOdOpWa/AkAgLzui/HzLQMJvqq0cnQOL5zqai3jDVOz22vARKa8ysy13uOk5b9UtthFcWA9K/lBlOnScrWRlWQsjneGWd9ye7YFMIZBAo8ZryOF6m8rwf2yKw2lenqP1GZ5QBFQ59hAG6klGWo34w/4lQnIE6EpiSYJkFKtjozEauYk9IQPFciuTYda6f/cDeDu5NRtzR/7f8MJrFP6HOZpvP7aY1ZQnkb0n+BSfxKUroF33s4pKPx4sAVxskpCDlt3/4SZrOD0XWIWij0nRfXiX1xBZv/nPpt0RwUMQapkzN1yEq5+hXO4HA+EE08g+WlPjjdJIKOC6FsvLEHHs1NclVa5m4gemo05+FjulbR4ALu2tLKYPTDzSrNGctongsMcx+RI/rwQc0Ll61m5+4ZNpRYFQJ6DYoXgyeb4aofwsOji9En2vBmzCy9aCZ1k0mavhN1bbdKSZLPng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8809.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(6506007)(6512007)(2616005)(38100700002)(122000001)(5660300002)(4326008)(8936002)(41300700001)(2906002)(71200400001)(6486002)(478600001)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(36756003)(85182001)(224303003)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDAyd21SV1Exa3o4UXhWNlBLY3MwTVJTV1RyYmlyeUxQcVFGY3BXUFJTTU5y?=
 =?utf-8?B?azJIMHNoN2YwZmJ5VjJTUTUxSFFGM3ZvUGNENEUxditCSSt3N1daWmU3TVJF?=
 =?utf-8?B?VlVZbHB4ZWpVcmZ6SmtLOWtsM1R5Rm56bWlBcEtwY1dyTzVHeTBsb2JZZk01?=
 =?utf-8?B?ZXEwSk11Vkg0ZGpqUTFtejcwaG9YYkVacHE0OUpibTl6VWRKQXhpTUU1eXBY?=
 =?utf-8?B?djBoMXAyaE1PdWhZV2NBaXhVd0llSWdBaEVSYjlpN2pUTFRCbEpXak56OU14?=
 =?utf-8?B?MmRLc1ltNWVTaWxGUDlBOVAvcGdUemM1QmpRbEpvVXdkd21KVEllcUFwendK?=
 =?utf-8?B?NzlFWkRHcXpBTEVveGFHbTNvSW01SU5XOWtYUkRFOEpBdFFFVFVlL2JQcEZD?=
 =?utf-8?B?b2IwaDAzTGFYbTFSWjNEMXBsWGEwSk5XYnJtVkIyYm1JUUE0S2VpU2pTUFgx?=
 =?utf-8?B?d1lLV1NVWS90cW5ybGtxa29oRE54VVpRdUtrRE5HZnk0eXpSVFh5UzVqWEZS?=
 =?utf-8?B?NkhjLzVEcEJ5SEsxZ2NMVFNyeEhjWElYK0VNS0o4VGNKcjhCbXJmRzFjQkpE?=
 =?utf-8?B?UDg5YThiVWkwZURaNWhhUGtqbXFoQzBsNzEwcDZtaDMzZ3AyVkF1OU9ieFMr?=
 =?utf-8?B?dU5qMWovQlZKOGwvRW1hdUZIcUtHQnMvV3UzWTlqRXRZVU9uak4vZTRtRy96?=
 =?utf-8?B?bGtxNnRYbHlydXNRWEZVRE55Yld0eDdVNXdaOUtzblVWTjBpeTBReG4yK25I?=
 =?utf-8?B?NUh0TUVCd0tmQVVsbXk0ZC9HbHBiQ2RLSG4vQ1hvU2JkdHlpUWhLcHZXNG5W?=
 =?utf-8?B?dTBRcHRzVGZZeksramhYV0taUWlCcy9uVngyQWNpNE5Cd2x5VnZGZmtNMnNa?=
 =?utf-8?B?STFDaXcvMkZodkIvV3RINWdBMWQ0MlhqWUdNblZwQythbWpYeCtLZmllU1o1?=
 =?utf-8?B?Mm1VclI1eXVYeG4yTHFqSjJkcXN5RUxDbG1CeHRxUjFSdlo2eFpFN0Nualp2?=
 =?utf-8?B?MnJwUnVuRE9ERHFlY1B5SHJWTE9GVm80b284TGpnRGFNZmJoNzh6ZWRGeWZu?=
 =?utf-8?B?Zy9IU2dYM0dKVzNLTU0wZmdoZDdlUzNFcEFCM2h0bVk5MWFlNmoyZ0lhUUpI?=
 =?utf-8?B?enRnZHdYVEtWcTNDOXdVK0hyOHQvWThIMG9Jd2o0dHBnL0x6VFd4ckxvNFJK?=
 =?utf-8?B?K1ZLbFRqNTNobXJhcHM0NlAxb2RUNnRSb1ROVGFDdHluSi91bnpOTjBSWnhO?=
 =?utf-8?B?TlNuMG9nbk9MRU1ORFBMSlRYQVZPaXZMaEZ4SDFuTHA3MERlajFuL0dTMGpN?=
 =?utf-8?B?L0QyejF4bWJPbzNRTnREczR1eTNzRUtSTVROT0RKSmRsZWZSeitnKzRmU3BV?=
 =?utf-8?B?THJ4R2N6VUcySFV1UVRCVFF6TlEzZUNXMHFhc3ZIWnJ1eG9CU2lkbVBkeGkv?=
 =?utf-8?B?a09hS3VZMUQwdGdrbzU1aEdjeGpSMEJST2dXNEQrcjBCVWhiVVdnQ3FHcFA5?=
 =?utf-8?B?bUsyV05rY0U2RHgvMGJia3h2RVpYWHpKWFl3OWl6ejhqNGsxWTMyVE1vMzVQ?=
 =?utf-8?B?RS9abWdjS085bUgxcDgrUWpITWx0RHl6dDJyQysyZEJXakYreU1xMjdLN3U2?=
 =?utf-8?B?NnFqbkVmcU9MeU5LQTVsSUM3Zjh3bTVrSUFzZWJUdVFKczR2Z2lNQ2JVQWMw?=
 =?utf-8?B?SnJscTNDS0REY29BL3FGbERZR3JLdlV4d1lmQ0FxMTJTNUM4ekZFd2x5c3cx?=
 =?utf-8?B?ZkdKR1FIWTBaYitleks3bnhmckY3U0JkY2RRNG1wekIzK0FabkVWektKS2Va?=
 =?utf-8?B?L2x4VHVhSnA0anluN2xFSVIrUExxRTUyeUdoVzVyUVpzVU5STUtFUTFVRU96?=
 =?utf-8?B?ZW05QWFYTitNU3NYbFlHNWsrRVVuZmt1U2FFT1FXQmNLWFhGbXdsaDZZSU5n?=
 =?utf-8?B?aHNFZHJSNWkwZnZMVDExSDdEUTlYYnk0Q214YVRwVzdHNkJzWlRDSzgzaUpq?=
 =?utf-8?B?N3JUajZFMUhSSXYwb2dqVngrcmgzWWpWN0pBSEF0UlBsYkgyVTNhcFErbEwv?=
 =?utf-8?B?SlFpaVYzSDJvc0UrL1B0Y0plRmRpWHBIcnBBTEJzTFNrWWZLZ21jc255UjRs?=
 =?utf-8?B?RDU3M1gyU0ltK2Z1Rkk1d3Z2RXlVZExma0hiSFE5ZmZDTDZVNytxaDdpRTNl?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAD86D07A801F342AF856E0AEE5E2EF8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8809.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d6fddc-cdd3-4d8e-3dfd-08dc1f27a3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2024 11:03:48.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9cMrZDVDq5DKWc7SOmhuEefNGUxWUfLzRQSfErZgcB5sbK5MzABBegO5Es7DiRgBuJLW5BJxY2Feln4z5Vk4e9MlKdn1anlMLrgEoCDhuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8131

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE4OjQwICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAwNzoyMDo1M0FNICswMDAw
LCBIYWlxaWFuZyBHb25nICjpvprmtbflvLopIHdyb3RlOg0KPiA+ID4gSSBkb24ndCB1bmRlcnN0
YW5kLiAgWW91IHNheSB0aGF0IHRoZSBtZW1vcnkgaXNuJ3QgbW92YWJsZSwgYnV0DQo+IHRoZW4g
eW91IA0KPiA+ID4gc2F5IHRoYXQgaXQncyBtaWdyYXRlZCBpbi4gIFNvIGl0IHdhcyBtb3ZhYmxl
LCBidXQgaXQncyBubyBsb25nZXINCj4gPiA+IG1vdmFibGUgYWZ0ZXIgYmVpbmcgbW92ZWQgb25j
ZT8gIA0KPiA+IFNvcnJ5IGZvciBub3QgZXhwcmVzc2luZyBjbGVhcmx5DQo+ID4gV2hlbiBkb2lu
ZyBtZW1vcnkgbWlncmF0aW9uLCB0aGUga2VybmVsIHdpbGwgZGV0ZXJtaW5lIHdoZXRoZXIgdGhl
DQo+IGN1cnJlbnQgDQo+ID4gcGFnZSBjYW4gYmUgbW92ZWQgYmFzZWQgb24gdGhlIHJlZmNvdW50
IGFuZCBtYXBjb3VudCBvZiB0aGUgY3VycmVudA0KPiBwYWdlLg0KPiA+IFRoaXMgbWVtb3J5IGNh
biBiZSBtb3ZlZCBkdXJpbmcga2VybmVsIGNvbXBhY3Rpb24uIEF0IHRoaXMgdGltZSwNCj4gcmVm
Y291bnQgDQo+ID4gaXMgbGVzcyB0aGFuIG9yIGVxdWFsIHRvIG1hcGNvdW50Lg0KPiA+IEFmdGVy
IHRoaXMgbWVtb3J5IGlzIGtjb21wYWN0ZWQgYW5kIHBsYWNlZCBpbiB0aGUgY21hIGJ1ZmZlciwN
Cj4gdW5kZXIgDQo+ID4gY2VydGFpbiBzcGVjaWFsIGNvbmRpdGlvbnMsIHRoZSByZWZjb3VudCBt
YXkgYmUgZ3JlYXRlciB0aGFuIHRoZQ0KPiBtYXBjb3VudA0KPiA+IO+8iGV4OnRoZSBjdXJyZW50
IHBhZ2UgaXMgYmVpbmcgdXNlZCBieSBmc++8iSwgYW5kIHRoZW4gbWlncmF0ZSB3aWxsDQo+IGZh
aWwuDQo+IA0KPiBCdXQgdGhhdCdzIGFsd2F5cyB0cnVlLiAgQW55IHBhZ2UgdGhhdCBpcyBjdXJy
ZW50bHkgaW4gdXNlIG1pZ2h0IGhhdmUNCj4gaXRzIHJlZmNvdW50IHRlbXBvcmFyaWx5IGluY3Jl
bWVudGVkLiAgVGhlcmUncyBub3RoaW5nIHNwZWNpYWwgYWJvdXQNCj4gcGFnZXMgdGhhdCBiZWxv
bmcgdG8gYSBmaWxlLiAgWW91J3ZlIGJhc2ljYWxseSBqdXN0IHByZXZlbnRlZCBhbGwNCj4gZmls
ZXN5c3RlbSBtZW1vcnkgZnJvbSBiZWluZyBtaWdyYXRlZCB0byB0aGUgQ01BIGFyZWEsIGFuZCB0
aGF0J3MNCj4gd3JvbmcuDQo+IA0KWWVzLCB3ZSBhZ3JlZSB3aXRoIHlvdSB0aGF0IHJlZmNvdW50
IG1heSB0ZW1wb3JhcmlseSBpbmNyZW1lbnRlZC4NCklzc3VlcyB3ZSBoYXZlIHJlcHJvZHVjZWQ6
DQpUaGUgY3VycmVudCBwYWdlIGlzIG1pZ3JhdGVkIHRvIHRoZSBjbWEgYXJlYSBieSBrY29tcGFj
dGQsIHJhdGhlciB0aGFuDQphbGxvY2F0ZWQgYnkga2VybmVsIG1lbW9yeSBhbGxvY2F0ZXIuDQpP
dXIgb3BpbmlvbiBpcyB0aGF0IGlmIGEgcGFnZSBjYW5ub3QgYmUgYWxsb2NhdGVkIHRvIHRoZSBD
TUEgYXJlYSwgdGhlbg0Kd2Ugc2hvdWxkIG5vdCBwdXQgaXQgaW4gdGhlIENNQSBhcmVhIHdoZW4g
ZG9pbmcga2VybmVsIG1pZ3JhdGlvbi4gVGhpcw0Kc2VlbXMgbW9yZSByZWFzb25hYmxlLiBEbyB5
b3UgYWdyZWUgd2l0aCB0aGlzIHZpZXcgb3IgZG8geW91IGhhdmUgYW55DQpvdGhlciBzdWdnZXN0
aW9ucz8NCg0KDQo+IFdoYXQncyBzcGVjaWFsIGFib3V0IHRoaXMgcGFnZT8gIE9yIHdlcmUgeW91
IGp1c3QgdW5sdWNreT8NCldlIGRpZG4ndCBmaW5kIGFueXRoaW5nIHNwZWNpYWwgYWJvdXQgdGhp
cyBwYWdlLiBEdXJpbmcgb3VyIGRlYnVnZ2luZywNCndlIGZvdW5kIHRoYXQgb25jZSBhIHNpbWls
YXIgcHJvYmxlbSBvY2N1cnMgaW4gdGhlIGN1cnJlbnQgcGFnZSwgaXQgY2FuDQpubyBsb25nZXIg
YmUgbWlncmF0ZWQgKHJldHJ5aW5nIGFmdGVyIGFuIGhvdXIgd2lsbCBub3Qgd29yaykuDQoNCg==

