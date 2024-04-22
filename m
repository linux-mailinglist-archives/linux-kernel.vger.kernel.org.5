Return-Path: <linux-kernel+bounces-152672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68678AC296
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1BB20AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB924A28;
	Mon, 22 Apr 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JLXYQ2uT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ohelk3ws"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587F1109;
	Mon, 22 Apr 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750609; cv=fail; b=pmrIVcgoX+4Bv7HURiezMpI0hSuRDXEym+pBkZGHTpunoh+MAfDas4I/5u6jh8qjowXDZIXVRJlcoGDWWf1q1TFYMuFEHpjCknBzPZYwHWo31jPjJqrD0T2Q2PhxAavGYs+KMVZJLYrEil9Ss4d8iNlPmKT8c0GTtI7scbuvygM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750609; c=relaxed/simple;
	bh=ubF66k8bYInnWIz34gfNCH9cIeY8rGQd2GUcNznoq+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYGYKuY2WFlxdrEFGF5h2VBK4Vp672Hx9E1RcbPfdiXManXWqEvOf+esiK44ARSNYt9b9C9hG4JkF/MwNKCDTTbEdEWAs6fXH/ZEVlK/TSKVmPBhyQ+DW84fYvL6L89BrU7/URz2BpvskLckcOU84YBpRQVY8RkleTlQ9DJT4+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JLXYQ2uT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ohelk3ws; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9e68b274004a11ef935d6952f98a51a9-20240422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ubF66k8bYInnWIz34gfNCH9cIeY8rGQd2GUcNznoq+4=;
	b=JLXYQ2uTS/kb3uXaWfh3VUqX3R1HVzM/uz8h1XdtaD77Ye0FpwOdggZ3F2LCoswIFbPiZnJibIYpmxcREkK/Z+UL7nxnWvinxRoEpAuXpbQG37F/NX9XagE2CAd2se0OpvOZVDJ1034XWBysnU3bQOPqVf53Ja/IH2+na3uQsE4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:16596d4e-37ea-498c-9f9b-92581bf4f107,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c654d891-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9e68b274004a11ef935d6952f98a51a9-20240422
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1599121083; Mon, 22 Apr 2024 09:49:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Apr 2024 09:49:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Apr 2024 09:49:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl/oWuAPybijbPzvC8J478l9GfdOYdz5cTsw83gCN+u8NEqc4cEfPeVWqOUsY3ytA4gebFKhScRiOeME6bokTprYhJJ9u38H9c2iKXeqAjZChdF7BRg6TiFnSZIKwlKadKj2qlWPyQ7oANJHSnGubUyBxRpQT/AmMA8/TVRdDqX3b3DbrKlishOoRfJlUXXSkve40GF+P6IX80S1Rw1A9daYw5aC29g/M/KhZa7GWmmv6b5YHanrk5W4TUR3pU+sZrfjFPsqzbFe+Z8FoxTvT31rkgexrwNUcSE1DEwF/Pk/hLBBHEm9Io8mIbfuvSart7OJ2DXcWfVmZdeJp/PapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubF66k8bYInnWIz34gfNCH9cIeY8rGQd2GUcNznoq+4=;
 b=HgzS+QCqBb4QxPyu2Nc2SjSzIa9l4zrGpUJCmg78w8+6cbdWSp95aavNjBEAhyea8s17taqNpATSWORauxjYi0b1NFjRJWeRfMJjb4m/JoulbUlG+YCuWSMLAWxNfTuxnPTeolKTT84AZhXPcDAdaXvaXrcc1TZYMWT/XyRLnOml2/xU2rXHCtDkBr+4GyiBBCCXWibHzvxqkUZ50v437dcwc/NcGalZ5Blq6anoCB1vgsQ+GxPEG7hoAoy6mh5/vae4dOXFA7/LMcj91e8LAOkpELSk/ZQQcLQJC54ed/0+/XyjuIRs07umnwBVxsOLNEdpnRpD3kRVRytKWq16Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubF66k8bYInnWIz34gfNCH9cIeY8rGQd2GUcNznoq+4=;
 b=Ohelk3wsqZ8Nq1LUc3JuukkyEEaY4+c+BoatdTzNHBHe1x83E5xVC6zgGEcnuwrM+Tk3JSIHVfeUi/dN22P2w5BCguUesUqHwPDuJbgkZjlt5QTl/DzZWVh4dzCZWGHoJvY77U86cy5cguH12NkiZVlRXr6m3cXZdo2h36aAEKE=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SEZPR03MB8265.apcprd03.prod.outlook.com (2603:1096:101:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 01:49:52 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 01:49:52 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "laurent.pinchart+renesas@ideasonboard.com"
	<laurent.pinchart+renesas@ideasonboard.com>, "yunkec@chromium.org"
	<yunkec@chromium.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, =?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "alain.volmat@foss.st.com"
	<alain.volmat@foss.st.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "mehdi.djait@bootlin.com"
	<mehdi.djait@bootlin.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
Thread-Topic: [PATCH v1 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
Thread-Index: AQHaksDabmbmnBaLLU6mK9P4MW3H+LFxBFoAgAKE3oA=
Date: Mon, 22 Apr 2024 01:49:51 +0000
Message-ID: <937260ad2046efd3d6ce2b3f0242fdff8ebfbd74.camel@mediatek.com>
References: <20240420011840.23148-1-zhi.mao@mediatek.com>
	 <20240420011840.23148-2-zhi.mao@mediatek.com>
	 <0cb44232-3be3-47cd-9e4c-f01f2839aff3@kernel.org>
In-Reply-To: <0cb44232-3be3-47cd-9e4c-f01f2839aff3@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SEZPR03MB8265:EE_
x-ms-office365-filtering-correlation-id: 42c27f71-22a3-4041-7e6a-08dc626e8069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?UGR3Mkd3WGdJeUhhZURkbHRlUzVvQXZTTGJrZE81OGx6UG8rQXVtZkVRZkFC?=
 =?utf-8?B?NnlmYlZtMDJhSmtNNjJWQmdsVlNRdEFNUXEyNk9BWFkvSVYzcTRza3B4UFhB?=
 =?utf-8?B?bDd6VUNWQXh3M0g4Ykh0SFlIMCtudk92Qkx3SEFjdTdxd0huZHJhY2lRZVJ6?=
 =?utf-8?B?M29YMmlGTmEycHBrK3ZyTGpVcWh3em1MbGxqdlNDVHJETi91QjF1UGdjRjVy?=
 =?utf-8?B?cytFSzlOVkhCbE1kTjJNcVExdWlibFpHMlkxbEhqRms3MlFBZDhhRkx2UGd4?=
 =?utf-8?B?UWg3TS81V0szTk8zSHU2bkVNcnB5ZG8vNG1Lbk9yQ1RIR1dCV1N1Y1pSMWJQ?=
 =?utf-8?B?UGZOcmh1Y1ZrdElyaVFodlpud3ZDbmdwZWFoQmNaQmYrTU1JaWE3WFpxWVha?=
 =?utf-8?B?WDI0OWZxMzhrTGFicGNGN1BMYU5yQzJaU2FoVnFhdVZOeVNvL29JZTQvRlNm?=
 =?utf-8?B?THhFVktsRWREOFBXZHg5MWgxVGYvVUs3T2x5VXdaNFltN0RQbUxuM1V0WEky?=
 =?utf-8?B?ZFdOMU4yNmFFbDIwblVOaGczK1M5L0EwRkc0ckNnQTFIdHRzSHNRNmxwUGFx?=
 =?utf-8?B?SStQWXA5cnI2Q0dhdkREL0Q3TWtMOU5mZjVqQmlGK01FVVNmUjJKU3k4c2ND?=
 =?utf-8?B?aVlBb2JiUUh2Nnd6Q1F5L2VKM1hib2JSaWkyNlpEaHlFUCtpN0htMHUzcy9U?=
 =?utf-8?B?dlFBZDVLckw5cXlMVVdWbkVPckZZVTVkOUFoWlM0c0hERUxiMHJPczROVHRw?=
 =?utf-8?B?S3VHQ0psRmRja3dVQjFHZzJzUVdGcjY5NUxyUUlubVc3NWh3UVlnY2RCY3pN?=
 =?utf-8?B?dkVUNHNVVTA1MElHalgwaEs3aVNFMVIzNjBwODgyRUlKdHpXb1ozMzVmT0FR?=
 =?utf-8?B?WDQyTEJFWG5ZZ2FndTJLK0tsbXZBY1JxSFR6U0grWlJob1FGanpWOW9KcThj?=
 =?utf-8?B?ZHJzTTk1cGFicDBUcTc4OVZqZlN0Y3JUb2QvOU5abTh3OHlJa0Q1NlRQNDY5?=
 =?utf-8?B?a1JXTDRCekVWTDNtNHJxUkZoeFNuWnRJZmpQRHZPcnpXNFFHQW8xYlozamJG?=
 =?utf-8?B?Wm9NNFdJMWZLcFVsUzFYK1pGTHo3cjlNS2JCYVNOcVdONTdnQTduR0U0RWtn?=
 =?utf-8?B?a01CR01xOGVYQ0YwQkdpeHVSV1V3YXA2WVMxck53WWVTZUJqZ2krL0I5eHVP?=
 =?utf-8?B?TkpMZEJxcEp4bURtanlrdHRjeTZCTXZPQmU1Z3JxNzVTUkppQW9ienIwU2hX?=
 =?utf-8?B?bXVydVdid2RWNXRrTlVia0Rsak5rYnVlOUN2ZVhOdE9tSTNqbkcrQWJlNDNR?=
 =?utf-8?B?UXcwcW4zbVVGTDRzK25DelZCSTl4RTBXak8ydlNnbTAweWVMdVBvREduTml5?=
 =?utf-8?B?QTRlMndObkRCZTBoMGM2VzZoN0lEeDBNSVk0MUNKUmdUSzQwQ3U2VkdqN09M?=
 =?utf-8?B?L0lmK3E1LzlnbXIyWnF4OWFweWljcXlSeFFPM0hnaVM5ajRIamRkS2l3akY1?=
 =?utf-8?B?QnlVVkFqVCtSeW14alhJRlRtazE1b1hWR3FXRWx4SnFRTnVvbU1yUkJUWUZ4?=
 =?utf-8?B?TEp0S3EvRzRYbU44ZW1seEoxb25qcVhZNUpMbXMreU1hRWhrV1AzUUNBRkdw?=
 =?utf-8?B?S3JUQ2tUU1psUFRjVVdTWmhBcDBka2VYMHZlQTlUd0orMGFpWjFnblRpN0FG?=
 =?utf-8?B?dDVoMC9YK3poSkRMU1ZRbi9abERZRzRjTWJ6T0xJbDcxazFCSEpmSml1Y1Vq?=
 =?utf-8?B?YVZDSTQ2dGpBWk1CclQybmJLaHZiUUNNcG1Tdk1BSk5VMC9KVWgwUEpRdUdu?=
 =?utf-8?B?OG1jRTBVM2VpRkNtZ21WZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3gvN1NhM2tUc3VscXVrQnd2SmpqTWdkbVcrY2c3RnlYRVhyMlhFaHRzNFZ4?=
 =?utf-8?B?QXA1eVNITno5SDZZTEs4QTRRT1hMamlzS2dwQjVzcDVJci9WeG8yS3RtYitP?=
 =?utf-8?B?Y0M0bmV2T25JY1hNZTdKRVVOd2VDVzF3cWdjV0M2RWdtM3RIMnRIdktZS0pX?=
 =?utf-8?B?TlpHcll5azNpNU9sL3l5Z1pFSWp3T2NGUytjTFd5R1REenlDM1ZqR20zREph?=
 =?utf-8?B?aURsQkMrcWpmUStRdU1QRTNlZ3JsVGlBamlQWlhodi80a0pHWmxneGkwUFEz?=
 =?utf-8?B?bisyRTRuc0R1cVAxN2NHRk5qK3dVaVRBblo3U005KzBpdXVXaDB5UXFhdHFW?=
 =?utf-8?B?RncvZ3B4VU1CaXhCQXRFOXBMbXBRK2hPRUlGMDB0SjVSVWluSlJmVEQwYXpU?=
 =?utf-8?B?Y0M4UFVLZmYzL2t5ZEhRSG5JOVd2ditkUGs0VE9zTk1vOHVtcDJIMkxRUk5J?=
 =?utf-8?B?ZkRLdDUwMkg3TFZST0VFK1hmZ3EwTmFkL3lRcnB1LzV2bzdGT0FPbHlLRjdX?=
 =?utf-8?B?OTlDUGV0aUJxNlJvSnFEUnhmeWdvcnFDNWFzQ2xKZGxIMmo3S3VqYzRGT1pJ?=
 =?utf-8?B?RGVLRDZrb0RPU1FDdzdDUitRb2FYWmhzR212M2lyd3hwUjNWRkV6VityM3Ja?=
 =?utf-8?B?N214RDBRL3hpV3lZUjJxaFhpMUF5ZHVRU0J3dmFJVGdPbGhVQkJrRzBvU2FI?=
 =?utf-8?B?K3FIK3dqSDJPNG1rY2NuZ1k3UTgvd0hCNXNlWHU4TDhzRjZudXI5RnNNRi9W?=
 =?utf-8?B?aFRwRFJEN0RQM1hERmVoRmo3RWI2bDYrNy9hUzRZVlMzaXBPcklOVTRMQnov?=
 =?utf-8?B?cytxM3hRSitpUmk2NVdRVU1rQlRTYk53TVUxc01IQlNIOHJxTkFxSUlIRjhU?=
 =?utf-8?B?N2EycVUvMy9uNXgwcUNBTDFiUDR6SS85VGpyTml4MDhxVGNtZGV6VGliWlcz?=
 =?utf-8?B?S0lMMTAwdFpldTNUamdLdW8vbFhjbmR5eFh3eEhHUHZha28vWnV5Y0ZOYmkx?=
 =?utf-8?B?Tm11b3ppa2N2Zll1dmZmM1p6RjBPVnJvNzRFakhGYVNCa2dydXQ3emxkQnBr?=
 =?utf-8?B?MWlwUkRTVENvLzFCYmp5Qkc1aFh2Y3pqV3diQkFtK2pQRy9ZUk5NTnkzVEdQ?=
 =?utf-8?B?YXlpeC92Y3NTeGVCRDZaQUsyM0hxUzBTcnhkZmlrMzYvZlJsZ2YraTdMajN2?=
 =?utf-8?B?Nm0wVU11WnBLRCtnWFJtZ0czQlVFa3pQMXMzd3dFSEV5L1A2RGJ0NnVrUkJT?=
 =?utf-8?B?K1R4QW54MVFUb0UyRTZzZ1dBOWg1L1NJOTc5R1hLM25oOE1rY2pJV0o5aXJk?=
 =?utf-8?B?MVpKdVB0OTdrUWkrMXFIRFRFTlVOaGY4TVpOVGNHWTluNnhaY05FRGhDTXBx?=
 =?utf-8?B?NERZUTNrenNqZzkzZXV1Y0pxM1gwQWRkREIySDIxTHUzRUxqMjk5TEp2S0Yw?=
 =?utf-8?B?T05VYldoZFl6bCtNTFN3bHQzTzRSSlpEWk1Ca2ExZHl5Vk51RnZteFE5bkx1?=
 =?utf-8?B?bGpUVEptY3hrZmp6M2lXNXVVK2ZmbnlxTWZBMVo5NUpORWh0SGFpeDBGSVlJ?=
 =?utf-8?B?dXdOZ2NsaEFwWDkxNWsydjJOUVNIeTl6anBTMXQva2pyREVSRGFDRTR5eHFT?=
 =?utf-8?B?U2dIMjkwM2ZzR0djcFpMZ21BbHk4bllidFZJSUhBWFQ5ZFh5Vm9PYkhsTjkw?=
 =?utf-8?B?WXI1NHJ6cnYrY0dEVHhxT1daM3FEZlRGbjV5aVdGT2pmREtFTDRpZzB4WWRM?=
 =?utf-8?B?dDR4UFNVZkY1NHpYWTVibGJ2RVhoRjB4YXFlQXJrTUtySDBObWloV3NOWnhH?=
 =?utf-8?B?bzB5VnBUS2RhamFTYW5xd0lwVVEydmh6V2h4Um5kS0o2QndFeGNQRm9sbU9i?=
 =?utf-8?B?a1E4YjVtT0k5SVFORWFmNktBdHNidlpIdU91RkdZL3JsY0dOYUl5ZUdwcU5t?=
 =?utf-8?B?aStoSzdtWUJqWTRnTEdZVWpxU2Y3MENVNlUvRjJLWVBUV1hKYzU1dXkyTk5z?=
 =?utf-8?B?Yk9pT211MllTaUhGTEp3WFE3UmNVQmJGbW9TK2RXbVNwd3c2cVNjYWIrdDFs?=
 =?utf-8?B?eW0zSVRmWmdyQkxkTzdxVFBxenk0YzUrZ2hQSFo3WXdvbjdsRnFBeVQzVEFX?=
 =?utf-8?B?WXUwNWo0UVVSVHZvb21QY1VsdWE0Y1ZyMjFKTkE2ZFhITnlUalkvU3B3YVF5?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFFB2DB96ABE1B4B9F1C9B8682A6C572@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c27f71-22a3-4041-7e6a-08dc626e8069
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 01:49:51.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2AZyYEhcQshCF9Cqwkd/jSnwfot+8rCpRsLBgDAKYYfpKxOxtJneHIVsbiJHmvCGMhbzoYdEL7dlm9Xr4U1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8265

SGksIEtyenlzenRvZg0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCk9uIFNhdCwgMjAy
NC0wNC0yMCBhdCAxMzoyMSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkg
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ICBPbiAyMC8wNC8yMDI0IDAzOjE4LCBaaGkgTWFvIHdyb3RlOg0KPiA+IEFkZCBZ
QU1MIGRldmljZSB0cmVlIGJpbmRpbmcgZm9yIEdUOTc2OCAmIEdUODc2OSBWQ00sDQo+ID4gYW5k
IHRoZSByZWxldmFudCBNQUlOVEFJTkVSUyBlbnRyaWVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gU29ycnks
IHRoZXJlIHdhcyB2MS4gUGxlYXNlIGRvIG5vdCBzZW5kIHNhbWUgdmVyc2lvbnMgdHdpY2UuIEJU
VywgdXNlDQo+IHBhdG1hbiBvciBiNCBmb3IgeW91ciBzdWJtaXNzaW9ucyBpZiB2ZXJzaW9uaW5n
IGlzIHRyaWNreS4NCj4gDQpTb3JyeSwgaXQgbWFrZSB5b3UgY29uZnVzZWQuDQpBcyB3ZSBjcmVh
dGUgdGhlIHZlcnNpb24gbnVtYmVyIGZyb20gIjAiIGJhc2UsIHRoZXkgYXJlIHN1cHBvc2VkIGFz
DQp2MC92MS8uLi4NClNvLCB0aGUgcHJldmlvdXNlIHZlcnNpb24gaXM6DQp2MDogDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MTAxMDQwMDIuMTE5Ny0xLXpoaS5tYW9AbWVkaWF0
ZWsuY29tLw0KDQpJZiBuZWNlc3NhcnksIEkgY2FuIHNlbmQgYSBuZXcgdjIgcGF0Y2guDQpEbyB3
ZSBuZWVkIGRvIGl0Pw0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

