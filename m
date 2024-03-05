Return-Path: <linux-kernel+bounces-91629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00B871466
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC9B22840
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C33C063;
	Tue,  5 Mar 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ra3b4j9C";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dAWfAdhE"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F31C01
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610210; cv=fail; b=DL/dx+Fp3AJj7MFXBBKQEOHaZ45TbvtAni94lbEEQJje+6GZJeAFzuo6iki+VJYKgF6ZgAm69v4TegjW2EzNoir3Ks1nrYmY3kr9xkfVHytL9v2UaHazfLxsVkyEaaxRouaXQ/QaDY6ACItILh5UjmI8u26zMXbuMOaEpmr/bqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610210; c=relaxed/simple;
	bh=Ok2mNXorXnB2H/KHiqHUT4X5imlQRkEWHprl88ad7XI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQeswiWEid0gZh2F9OaNlpin1SaxORBbqJsRXdRy8c/96l9US8AUqcFNoSUiXoACo+jIHd5/b/Bh77fPqh1KkYBKADa8jERx66bi2H3QcjVdYW+MChetCFCiqGF6sdEI42xo0yo7u7rjP8KVbT9CIyLwhbT/GExdjLEa8EvS+Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ra3b4j9C; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dAWfAdhE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7fe92040daa211ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ok2mNXorXnB2H/KHiqHUT4X5imlQRkEWHprl88ad7XI=;
	b=Ra3b4j9CqUrxw66FFyvphjgsZSGLVKSPNu20JT+cOFuJgOnY6pAmbz94Sp9jEQQo67e1IUy2K4oxCgSnZZCIYFvcNxZFvx7NkQ1ImD6CoWPFratJ5oHItJh36EOlkHGL43jhvEQB5m+7sy5ucTv0uxxvxtA7bjHkfWYUin4jLEc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:63baffd5-7ec6-4ee4-8015-417e7769b1bc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:800183ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7fe92040daa211ee935d6952f98a51a9-20240305
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1775511041; Tue, 05 Mar 2024 11:43:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:43:14 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:43:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzWSibBq/2Vr5pLyDA3kLsVrKM+MzmpQbMFzgnCNfq6dB/el/zmQZQUGEQdY9hCNNp0t8kLUo5IbsJk0IePZQn+ccBCJR3fSkc8v/MeT1XcJZsP3Nup015EMxApWmreMGo7ifLQfOW3UEC0LLDMd0LX5w6nqObn0KgbYcW8DScu17GBwSE1YZLb50JJDiuHsiXjQRYzswf63P9t74CZ/hszuJM14mJodXZz/dGEW3fgcUF2B98qEO2n9FC0/OCi9as3MiIMwjxTadZv3FQeGki5I7Ds55/UCt929a5L95ko56BgV+InhLNPty7B6PRszxIKXQTZF2WQuHP/CfEIiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok2mNXorXnB2H/KHiqHUT4X5imlQRkEWHprl88ad7XI=;
 b=obG8cr1wQAtJvhDqggp+UPQYrDcJsdBSgt4lIIuHEzQCrulQ9a4Zi/zTWcrbw0xTqCuRkLyJiXPWSDP6byQ+CCT2g79/yuv+abUavOUyDLkmyA2v2V+PMXLFArM3yNgkwFB87HJyFutGxxqJG9a9fURRVJKabJhrVtteIBKqHayT3xZsqh9MogQfz/wDAlKltLdfbtYngidy+T9SUGcuP6FytkNkR+tmCSbLWAn2DETfzXtkhaKYXdexEWJsXtrYALl9MBSJ6/Hc07+96EOnAZ7xyynnWNgAAGz4H9+qX2j8+wAISh6cyruTL1juTnOChH55jkDdLfpFcbp1bLqQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok2mNXorXnB2H/KHiqHUT4X5imlQRkEWHprl88ad7XI=;
 b=dAWfAdhEFm+mzjx2FePleafxPG5FnVAcKEwYycPnCQbhNYO+N/eymjN4jKVTO9Nu1BbQSbaF0I70hHXmqvu2CpIPjx7tx2/BSqDs+jOTUTGhE2hhJf9t7bMyU50mZLBMsBTcujUVws55qkAdW1B+cYNxdyBPZzcW2Pa03VJMdso=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7521.apcprd03.prod.outlook.com (2603:1096:400:411::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 03:43:12 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:43:11 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Topic: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Index: AQHaa+cCzUxpGjkGLEWHYFHl9iiQSbEm3+cAgADfigCAAMPgAIAAA10A
Date: Tue, 5 Mar 2024 03:43:11 +0000
Message-ID: <315bc1a74f835bbd36a874a719054d6787148376.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-6-jason-jh.lin@mediatek.com>
	 <1d14bad104b8e5c74ffe6c08cbafb4da6e1e751a.camel@mediatek.com>
	 <ceab73ebb925dacc14376f7054e20411612b507e.camel@mediatek.com>
	 <ed9fc19a909ee6aeb8fc8eab10020808ea391b38.camel@mediatek.com>
In-Reply-To: <ed9fc19a909ee6aeb8fc8eab10020808ea391b38.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7521:EE_
x-ms-office365-filtering-correlation-id: 7f438be9-8e43-44bb-5f47-08dc3cc66190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /D2bvj1UieASrdrJI8/J5BPpcoQ74xJGqbzOUIYjnTNt5TWp6n3c9jlHXrdS6N2tBimhY4uW1OmtvIzqLvnomJcq83WMqpPjUh+lssCWUsKx6VdmSDHy67vWiERwber3wXw15g4qWfPkCRsl8S+7on71zs3zX0gWvDRtTxO3vBYfoiqI4aFBlbGrP/SwAFcH9ivA1kwzTaR+2/qldXh0l47/DJYTxovxMCD0Zji9vI/K3Dq1ex0Y8HPd7hVcD3ZWqeGgNPyE21v7tnfO0g0d4dI0ec8lIJ5ByRUnHVgaI7DtPYM6YXCk9CPEDkRcS3oP+6EbgXy10EgIDGagTClxDaowl3dRVdoBoAsgQTheJDBJDXWlVQ0Q4wk6N1ab1mEnqn6hxHZmuVUMqDIdwB/PzpXO1HPm683YSb70ofHKzlebuu5IEyJc39wBVk+IxsMue+zS9hjSIQrlXl8vzBW234Xxictzmbbt130/SfvyjAGbnroTLDCumjDogDK7G1bzS93FGXy7mg4FqbbNeR7H7Xq20+LSLLPTHfrsetGyJTajjO5q70kHG6sKb3i0eBiygAhML5imjCjpnDmzskPOaq4BysUqMguvNje2wh6ExjhytBVgBNR1iA6dTAM6KeTxV8/iLqu+ZL0QY7a2PTwjif+xHPlxkCzKlqKpjm+AeIFIgEW+KpriAnvKMV1Floqh1FrMWBYSgd8tz1QgOWXMrlsii00YP8reGcvOijpbD9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVpBZXpVQVFoTlRlam5IRXRSb3BaSHQvdWcycmNhWlJGdUh6eElrUktqQWgw?=
 =?utf-8?B?ZDUwQ1piR01tbkNHOXEzQ01qZm9aZmV1a1VZTHpRVFFHVmFpbUVNU21zWENC?=
 =?utf-8?B?OTVLajA4NitXdDE0TEVobUJ3dDBYN3ZpUzJ5NHBoaTJNWXQrL3pTYjBvdmht?=
 =?utf-8?B?U0E2eEhXN2R1S2ROZEJiYmNpaW5RVGNYWXJwbXhwU1dSZFQyZG5qcEM4VUhN?=
 =?utf-8?B?NnZxd2dTL2JhMG9oelN1T2IvQnBHdm5ld1VGck9nREQ0RnRsbWN0Sm5VNUtF?=
 =?utf-8?B?RVdhREFIL21VekxnbjZjYlJoQVU0a3hzZXFqSHB3ZVg4WWZqTE0ramxuOGhv?=
 =?utf-8?B?MUJ3NjNoNlBsVGJrQ1hBRUlvYy9mTVFvRE9yTjBDOEZZbkxRdGVMekVLbE9v?=
 =?utf-8?B?bll4YlEzejlSTkpxZGRpbkQ5YnFYSHJrazNDVk1DaElFSVNFL2l0TWlwUDFi?=
 =?utf-8?B?SVJHenAwK1JwV0lnalJJdlA3cjVUbHZPQzdMVDlyQVBJRmZNa0lvdzRHRnp3?=
 =?utf-8?B?dU9FUEZkUks5cTNGTVB2WlFCZkdVd29Dcm8wZFIzZFlGejZpNStUcmpLT21Z?=
 =?utf-8?B?UUIwVTBISnpST2tFYitKWEFPWnplYlRSLzE2dzRvdFYrRm1sZXJEcXNYVFdh?=
 =?utf-8?B?YzlmZGVENUlGTW1ZV2xXWGpHN0dLRXNxNThsSFU5cEd4NVQvWldMMUxGV2VP?=
 =?utf-8?B?WG8ydTZSenh1RUNlNVZLaEtRci9JVDdRdVZMYnBwWUJpNVBHd09sdEZCZ0ww?=
 =?utf-8?B?WndoT1kvOGVaTWEyeWkxTnhWaWZtS0pJdzFYSFNQQ0dSSDFqdXRta01tOGI4?=
 =?utf-8?B?TWZqY0ZGVm9FcEJRbzY1d3BZcEwzL1VzZk5wSGI0REIrUVNQWml2YjQwaE5M?=
 =?utf-8?B?c3J1WnJrRkMxbE9vamV4L0U5MFoyTnErbDAvcTJtbGNsdGpTaTlSTk9aWWFC?=
 =?utf-8?B?VnhNUkF1REVsb3BNRTBjeW54bVY3VU1Jbi8xZ3oxMmRPRUpNblRBUU1xWDRy?=
 =?utf-8?B?bkIxTEpDejlxb1BmUjQ5cVJWRTUwai90eUsyY1FXeWtzT2RJU20zYXVmMTJz?=
 =?utf-8?B?eGIrUFNMMFhLWVVSeDg0d2hiWkp3NVJ5Ti91VFdxclEya0FpRW4xVGN1R05U?=
 =?utf-8?B?ZEVlODc3TVU3UmdYR0U3N3F4Mm00NmRFV24yZzlKbTZsWWcrejNlQWdNZm82?=
 =?utf-8?B?ZlpnaTJmMXErN1pkYkZENG9FcGRNVk42TUNxZTlWRFViMERYa0p2SjhMOTZZ?=
 =?utf-8?B?eUF1T1h6MVUwRDhjL1lGd1d0MzZUYWk1WUxORHJEVXpwWmdEdVhJMjYxZmJr?=
 =?utf-8?B?ZFk0Ym96d0tHeC9CSjVVYlJMWHlQVmdoY1RYUkhTeFc2VzN4UHFzbTNqRUdL?=
 =?utf-8?B?Vm9BdWZ1MlI0Rmd0d3hCMkNnY0tZUjBSRW1nT2F2cWg5Q2J6Uzdsb2dsV290?=
 =?utf-8?B?dm5wd3dEcnNHV1dYMEwvaDlsTXV3SkdEN200QjlqTXJWNGI5Rm5iMlV5VGRN?=
 =?utf-8?B?eXF4YTBqempheFpTbVl3WDU1eE92Q2JlbCtmQWozOVZ1dlhmOGlFSFVSS0Zp?=
 =?utf-8?B?eXBuM1ZnMUJXYXdYN09LMi83R3B4a1orK0JrWWFvd2p2Vmc2aUhqUndDVDc1?=
 =?utf-8?B?cW83ZksvY0s4V0pHSlJZajFPMGlGaVF1dnY4VVh0RzF1dWlCTmNDYWwwZWhZ?=
 =?utf-8?B?aW50NjE0ZDQ2MlZBeXJhY2N4dUU1VGZuTWhRS0xWekx6ZDRSUFRraEkxb0o4?=
 =?utf-8?B?b3F4aTBRcVhKTkxNOXNEUGk5cVZoYVU1Z0lrOStTTVplUSs5V1FGZ2tkbGsr?=
 =?utf-8?B?L29McjNITG8vWUVVSjJzREFvUjJIcFNFQWlXUVovMjZqUkg0c25ja1ZFQnlU?=
 =?utf-8?B?SnlZU3pmSEI1aW1pNFphTGRjSHRZVEpWc2QzbmNEdm9IZFN0VWRZY3RrcCsr?=
 =?utf-8?B?bmdtejk1SW84YW9TcCt4MHhxVmJaOHdjTHgrdU05OEtFbEVtWXN0V3VxbUNG?=
 =?utf-8?B?QiswK1pQd0dYZG1OY0R6TTgrZUhlNCtyaElVNVVwM2pScEI3cEozbk9CeTFY?=
 =?utf-8?B?SGt0Z1FSSmxpRlIvaTVSZVhIZ1lNT1hFUHhxK2tPL05xUUEvNy9ockQ1T3Bl?=
 =?utf-8?B?cjhiVDJDOXNJRTh2aFhDZ0VaaDdGcXBPQVdRTXo3cGZhVkM1MHJKNDN5SWhk?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6EAC332CB09C0469B85607C745B978E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f438be9-8e43-44bb-5f47-08dc3cc66190
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:43:11.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tp0Ew59mV15iVXMBZ6gtquDDsr6+/das64Pcbihx0CL94vHuFfpPSRKzySmPXsZdUevFQ9xzJMGE+oj2aJ6J428NDJFq21eB8gN8v7+HQzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7521
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.797900-8.000000
X-TMASE-MatchedRID: QW5G6BKkLTo6yy6RAAEPcya1MaKuob8PC/ExpXrHizyLWuywoQz7tLmn
	rGB/kwGMH+RndCK32H0FIWA1386EUMME2BsoiKJMhK8o4aoss8pKPIx+MJF9o99RlPzeVuQQkk1
	UCWc2BMj3Ui4/pNR3w/kIVHds+4ciWLTnLBzaZJISDAzxRL+lMaOI1u80g4PZGNAPebYwJ/uwoW
	8logP/FPEhqIqBPXN5dCnwFnnJfgCAaBshbPhdTNjko+KiQPUGhSl7KAXaa8J794qAHfSq0kOlq
	bLB247fQOcxSdTpDT+Rk6XtYogiatLvsKjhs0ldC24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.797900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A55CC3255D3CF23167A27CC10A09A31CA1F5EBAD77C99BC245CFCE94F051FD082000:8

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDAzOjMxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDE1OjUwICswMDAw
LCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4g
VGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gPiANCj4gPiBPbiBNb24sIDIwMjQtMDMtMDQgYXQg
MDI6MzAgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEphc29uOg0K
PiA+ID4gDQo+ID4gPiBPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gPiA+ID4gSVNQIGRyaXZlcnMgbmVlZCB0byBnZXQgYW5kIHNldCBHQ0Ug
ZXZlbnQgaW4gdGhlaXIgcnVudGltZQ0KPiA+ID4gPiBjb250b3JsDQo+ID4gPiA+IGZsb3cuDQo+
ID4gPiA+IFNvIGFkZCB0aGVzZSBmdW5jdGlvbnMgdG8gc3VwcG9ydCBnZXQgYW5kIHNldCBHQ0Ug
YnkgQ1BVLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgfCAzNw0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmggfCAgMiArKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25z
KCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYw0KPiA+ID4gPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCj4gPiA+ID4gaW5kZXggZWFkMjIwMGYzOWJhLi5kN2MwODI0OWM4OTggMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gKysr
IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiBAQCAtMjUsNyAr
MjUsMTEgQEANCj4gPiA+ID4gICNkZWZpbmUgQ01EUV9HQ0VfTlVNX01BWAkJKDIpDQo+ID4gPiA+
ICANCj4gPiA+ID4gICNkZWZpbmUgQ01EUV9DVVJSX0lSUV9TVEFUVVMJCTB4MTANCj4gPiA+ID4g
KyNkZWZpbmUgQ01EUV9TWU5DX1RPS0VOX0lECQkweDYwDQo+ID4gPiA+ICsjZGVmaW5lIENNRFFf
U1lOQ19UT0tFTl9WQUxVRQkJMHg2NA0KPiA+ID4gPiArI2RlZmluZSBDTURRX1RPS0VOX0lEX01B
U0sJCQlHRU5NQVNLKDksIDApDQo+ID4gPiA+ICAjZGVmaW5lIENNRFFfU1lOQ19UT0tFTl9VUERB
VEUJCTB4NjgNCj4gPiA+ID4gKyNkZWZpbmUgQ01EUV9UT0tFTl9VUERBVEVfVkFMVUUJCQlCSVQo
MTYpDQo+ID4gPiA+ICAjZGVmaW5lIENNRFFfVEhSX1NMT1RfQ1lDTEVTCQkweDMwDQo+ID4gPiA+
ICAjZGVmaW5lIENNRFFfVEhSX0JBU0UJCQkweDEwMA0KPiA+ID4gPiAgI2RlZmluZSBDTURRX1RI
Ul9TSVpFCQkJMHg4MA0KPiA+ID4gPiBAQCAtODMsNiArODcsNyBAQCBzdHJ1Y3QgY21kcSB7DQo+
ID4gPiA+ICAJc3RydWN0IGNtZHFfdGhyZWFkCSp0aHJlYWQ7DQo+ID4gPiA+ICAJc3RydWN0IGNs
a19idWxrX2RhdGEJY2xvY2tzW0NNRFFfR0NFX05VTV9NQVhdOw0KPiA+ID4gPiAgCWJvb2wJCQlz
dXNwZW5kZWQ7DQo+ID4gPiA+ICsJc3BpbmxvY2tfdAkJZXZlbnRfbG9jazsgLyogbG9jayBmb3Ig
Z2NlDQo+ID4gPiA+IGV2ZW50ICovDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICBz
dHJ1Y3QgZ2NlX3BsYXQgew0KPiA+ID4gPiBAQCAtMTEzLDYgKzExOCwzOCBAQCB1OCBjbWRxX2dl
dF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFuDQo+ID4gPiA+ICpjaGFuKQ0KPiA+ID4gPiAgfQ0K
PiA+ID4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX2dldF9zaGlmdF9wYSk7DQo+ID4gPiA+ICANCj4g
PiA+ID4gK3ZvaWQgY21kcV9zZXRfZXZlbnQodm9pZCAqY2hhbiwgdTE2IGV2ZW50X2lkKQ0KPiA+
ID4gDQo+ID4gPiBzdHJ1Y3QgbWJveF9jaGFuICpjaGFuDQo+ID4gPiANCj4gPiANCj4gPiBPSywg
SSdsbCBjaGFuZ2UgaXQuDQo+ID4gDQo+ID4gPiBJcyB0aGUgZXZlbnRfaWQgdGhlIGhhcmR3YXJl
IGV2ZW50IGlkIGxpc3RlZCBpbiBpbmNsdWRlL2R0LQ0KPiA+ID4gYmluZGluZ3MvZ2NlIA0KPiA+
ID4gPyBJIG1lYW4gQ1BVIGNvdWxkIHRyaWdnZXIgdGhlIGV2ZW50IHdoaWNoIHNob3VsZCBiZSB0
cmlnZ2VyIGJ5DQo+ID4gPiBoYXJkd2FyZT8NCj4gPiA+IA0KPiA+IA0KPiA+IFllcywgdGhpcyBj
YW4gYWxzbyB0cmlnZ2VyIHRoZSBoYXJkd2FyZSBldmVudCwgYnV0IENNRFEgdXNlciBzaG91bGQN
Cj4gPiBub3QNCj4gPiBkbyB0aGF0LiBPdGhlcndpc2UsIGl0IHdpbGwgY2F1c2UgZXJyb3IgaW4g
b3RoZXIgR0NFIHRocmVhZHMgdGhhdA0KPiA+IHVzZQ0KPiA+IHRoaXMgaGFyZHdhcmUgZXZlbnQu
DQo+IA0KPiBTbywgd2hhdCBldmVudCBpZCBjb3VsZCBjbGllbnQgZHJpdmVyIHVzZT8gQW5kIGhv
dyB0byBwcmV2ZW50DQo+IGRpZmZlcmVudA0KPiBjbGllbnQgZHJpdmVyIHVzZSB0aGUgc2FtZSBl
dmVudCBpZD8NCj4gDQpZZXMsIHRoaXMgbWlnaHQgYmUgYSBwcm9ibGVtLg0KDQpDbGllbnQgdXNl
ciBzaG91bGQgdXNlIHRoZSBTVyB0b2tlbiBldmVudHMgZGVmaW5lZCBpbiBkdC1iaW5kaW5nIGFu
ZA0KcGFyc2luZyB0aGVtIGZyb20gZHRzLg0KTWF5YmUgZGlmZmVyZW50IHVzZXIgc2hvdWxkIHNl
ZSBpZiB0aGUgU1cgdG9rZW4gZXZlbnRzIGhhcyB1c2VkIGJ5DQpvdGhlciB1c2VyLg0KDQpBbnl3
YXksIGFmdGVyIGNvbmZpcm1pbmcgd2l0aCBJU1Agb3duZXJzLCB0aGV5IGRyb3BwZWQgdGhlIHVz
YWdlIG9mDQp0aGVzZSAyIEFQSXMuIFNvIEknbGwgZHJvcCB0aGlzIHBhdGNoIGluIHRoZSBuZXh0
IHZlcnNpb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0K
PiANCg==

