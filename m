Return-Path: <linux-kernel+bounces-167188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D98BA568
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E1A283E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66EC18B14;
	Fri,  3 May 2024 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hT5lBejh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kegfeFk1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9619479
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703941; cv=fail; b=Pouwnjts7qcldpT7Or+R/Z0mZxob8jKaVXh3ayJqJ43wqNI9X+QN84vqidBy5c2z66C1oF8onpxOQsJJtubeg5U72Dv2zJnqTVjxZ3KHiAurl1wNXGsB5j4cMxOgOiSe8xJxFajeCSyXWpwTgKH25L4buqwAhzWMSOwbz2CBT+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703941; c=relaxed/simple;
	bh=rZi0dc4la8rRxAapo+yMvOANFjLN38zmfWs6YEyW6rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUAdMB7Q9dR125Yzfu4ndwwwsQiOZIoV5kiDkCcUYIUXhv3dc93AFz+xj+e7IP2X9IF8a7kNYF39DI9nkIqU//LBMm6XXEns6bT85kkmtX43AphfiIYl6di9hU4iwihT5XpHuEQCKOe5OY5Xwn3ka8vtUHy+/g9ia/HETwxVmZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hT5lBejh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kegfeFk1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4854add408f611ef8065b7b53f7091ad-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rZi0dc4la8rRxAapo+yMvOANFjLN38zmfWs6YEyW6rE=;
	b=hT5lBejhQgW2FqHqIgW/Iig3hVqiCDyFR6CxLdhuMc2eC+ehffZJjY2JFjY+sPo/8bEGaYZGKQgFfp0dLaMHLokA7JPqqeI3A9o1NwmQjbTdEoQNwRVyjPMKXhEBqCTGISG8UKAkHpF8AalIxO47pbNi+eBGtJ1P1vu4hRyRB9w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:feb50c24-5754-4980-9e8b-2dac25564104,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c713a1fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4854add408f611ef8065b7b53f7091ad-20240503
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1244999914; Fri, 03 May 2024 10:38:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 10:38:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 10:38:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR3HJe/DHZaJapqMgJkAXKc68jHIHp6R/ajB3HDm2wEUUUqVjO2kaT40TLogEEPmJDefiDjy49Y1s1E8I2Fu21tQUf+PoNcO3EmnxHMGxc0qtO3zRq8PTheaBGzKa1gFNHvYHz51LRLEGKDdOzNit88qyb1qnfNJpFI3KTN49LvUlzmYrJB8fSZlroBjLRQ85X5KgDfgjJILii3cybXuKJ4Bt31L0fcZl70lw99r5F8Mqzk9suNri52EjJVlsJGVpFhmeuKJL41kFAcO7FWGthoWDqyPq8mydoPVe09T2ZzPaQga5jmOITsgkYHhOQwfSABqXOtbhHCs4hf60uXbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZi0dc4la8rRxAapo+yMvOANFjLN38zmfWs6YEyW6rE=;
 b=HUSKsLvvJe/GIB2gavZtX5IXBzwGdyxJifM0jZuwaMg+2luRbTdcqNkNH4W7ilfEjPseJNKKTBowi90EPQXfAQup7POxv89AqUQEprBnla2cn82BWZYIHoXyRBHjbkmeHpzXbtmJg6kQTULIiVbsXgi5XjsNlYE4eEVrSR/ImB4nA0pyLWubyGLFeVWNyqahayTxBWiZAs1DgItUe53VQ5URWUg2AT6WUtYGMxzvIYJm20h1K04NabHVIp3V7MYDvbWxkr4zM4MOlJdjzpRosnmORd07jd+qNhALVUdZRi1aG+jMTiB9/f1484fCy8yDzQK/uSxzAjtn7J5nun/QEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZi0dc4la8rRxAapo+yMvOANFjLN38zmfWs6YEyW6rE=;
 b=kegfeFk1vbPrR7u9CEcpqIjZzRaIcrsAdRLedc/iECjT2z89dCTfOi9aj1SQOQtfHpt04QfWKAlm+YIpPdjUxr/wZO4uwaIEKyc3OE0HY13le8vqTwzYvsEmyLgxp55pUheTWD7VNKZHm7R+JMb3cWBWO3Dyqj8JM66XHiaWCug=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6902.apcprd03.prod.outlook.com (2603:1096:101:b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 02:38:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 02:38:47 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 05/18] drm/mediatek: Set DRM mode configs accordingly
Thread-Topic: [PATCH v7 05/18] drm/mediatek: Set DRM mode configs accordingly
Thread-Index: AQHanH0PdlhQErovi0aCr7kn32IybbGEzRAA
Date: Fri, 3 May 2024 02:38:47 +0000
Message-ID: <7de580ce87464ede3249ce50648459573d092c84.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-6-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6902:EE_
x-ms-office365-filtering-correlation-id: 5410087e-7b94-48b8-b550-08dc6b1a288b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QndRYnRVZ0VuS2hzQTJxN2YwWkNITDV5NjdFRGVlZC94NG5HZFdFdDN6a0Rt?=
 =?utf-8?B?ekZkdE5RVUo2Q1RrV3Z6aUJEMjhBQzlCREYwYjIzZThZRWlmUkY5UW5HNi9Z?=
 =?utf-8?B?SVZ1SVlYSlIrSWQ5RUZsS0lDVnhVVXVHTEF4L2hBbXVzcDJvdENOZEtLZFA2?=
 =?utf-8?B?eHUzZ1VacHZxbTZoenNLbm15WXQwUmpLc0x6MkVHZXFhL0hGT1dtLzBUZVhC?=
 =?utf-8?B?NDhxem0zZnJaT3kyd2JZNFlBOWhEVlh4YTU3RHh4Zk14MCtYczZVREdQQ29U?=
 =?utf-8?B?Y20vVkNtdnUyeFBSM3Z5N0syUXJKRnNEdzR4YTJvMTNpY2JpY0N4V3FUdEx2?=
 =?utf-8?B?TnpGeWtLOVB1NFN6Sk5ITWFBZnRMMzlhODB3OEt4ekQ5c3RQcjE3N1dGbXRO?=
 =?utf-8?B?Z2h2T1hxd0k5MGJwUlRvTjluTit0VHJXYmsvMnFIbXQwcWJjNmJoV1JLZm42?=
 =?utf-8?B?U2E5cktJeE9sYXQreHA4SmRjR3pkQWJtWkVqTG5BV2twMU5uaEZVcXZYWDJ0?=
 =?utf-8?B?TER0Q0VKNXdRaVgvU1BFVjJDMEEremhNVmM1ZkhWd1k4ZUgvRGplN2xPU2dV?=
 =?utf-8?B?Zkd6RlMyZTAxb1BjSHY5Vk1vb0VLQjFETmJSN2xvQmVpV3pWNW56b24vVzFo?=
 =?utf-8?B?cmxTQytLS1V5cjhldkdYQ1k4NVBBQW0xRFhWYW5ERDAzeStlU3Jhc29mZnRR?=
 =?utf-8?B?ZitNM0hXTWZ0aTNnc1haNEkrVUNpQUpTcExPamg4K2pqMHpzZ2dGTnloSHh1?=
 =?utf-8?B?VFBQS01CSURJQTUzejNJMnp1N2hpWUpWRkljM1RZSDY1OXJpRkk1cFIzNDNT?=
 =?utf-8?B?RTBsV1o2dWtUMTlxaVc5WkxWWk8rRzEybXg4S1UrYnBRYmZqU0x4d21LM3o4?=
 =?utf-8?B?L0RNL1VlUkRoVjNHbGJYbm5KTUxYNWY5RXFMQ1d1K0c3eG5ncWFBTng5VlU0?=
 =?utf-8?B?bEJPa1oxNTdsaWxrTGhRVXRQdVNtaWJZdmdBT2RaZkFkVkl2b3hBdWtma1Z0?=
 =?utf-8?B?K1k1WEgxWmxOQUp6TVQ2aHcvd0ZVVnJZakYyVmI1L3l1cG1FWW9MWkI1bEJR?=
 =?utf-8?B?TVJGMTZDZzAxbFVpOEM5RSt3V2M1MkY4Q3hDTTV2YjdsNnF1L3lsOHIvRDBn?=
 =?utf-8?B?UmVvTnYrcFN4TElVOGNqeGhROTBvOEVYaXJ0MkJoYlErcGlPV2lhNnRxSUZw?=
 =?utf-8?B?SFpnSHEwa1dKV2dSZEk1RUFxR1E2Y0Ztb1YrQUpLbXFhYlZqK3B1L1VJOWRv?=
 =?utf-8?B?Ri9MRzFpbll3TzVHdGVITEttZDZ6b0VhVndHL2tWa3ZsUWJQcm1aOTNWYXBq?=
 =?utf-8?B?M0Q2S0pnV2RFUHJObjNMbjRCcVo4L1o0SzRtMThMMzZYdXpISEsvaTYrYWcy?=
 =?utf-8?B?d2p4d2lmOG40Z1J5c1FHRFJVdzNMa1k4T2dFaFRnN3Y2TXhISThlY1Y5alF5?=
 =?utf-8?B?b05BYmVlZTRoMk5rL2wvYnFmNGRUc0poblpHWGhJOWtzSUE4Ly9rL2h6Vm4y?=
 =?utf-8?B?Zk1EVHVOOUUyNUI3QTh3bG1iRnhhL3cxeWliYjA4bmQ0enA4anlFbU5uVW5p?=
 =?utf-8?B?STU0RU1OZnlMT2t2dkdCZWU2QkU1NXlWb3gxYUk0SzJzT1ZKaWFqeUVtcWZy?=
 =?utf-8?B?L0FBR1lCS3NGZ2tyTmNIaVJMYWo5RlpvWXRBS2pLck10cVIzaEJGdk44YU9m?=
 =?utf-8?B?OFVtQm9rRm5DTVA3cDljSFlhanlEU2NZUGt3TjVlMzNESXZwRGRkdER0WXhQ?=
 =?utf-8?B?Tlluc2ptNS9XVTB6MkV1UWNQeXFtRVE5c2E2dXBQQ0RWTzRPMkJBSy93WFhQ?=
 =?utf-8?B?TmNEdEFyVTVoZE4vMVNVQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nno0SFgwQlkzSWdjWHRMSVg2N0REVzYySkFFT1NGSmV1VTJBak9uc3YxK3hy?=
 =?utf-8?B?dUhINUJPZCtMQ3l5Y0VKS0s4aXR6WGJhWXdsWXR4N3oyeGZGWjZXQ2dWZnBn?=
 =?utf-8?B?MTA2OEN0R0xRNW5CS09ZRmJadjNPVWkvUnR0d1JZNm1DN1ZnQXNkUS9ML3pw?=
 =?utf-8?B?TWJPVkxvdzFBT1dKQkRKMDVidkFPSVZLUGF3aytheEduMEFMOXZEZkN2WTNV?=
 =?utf-8?B?dThUK2oxa1JtYjYzbVJ3VUc1cjNqL2NmTmFpa2hqcjlUYlJ0VGgwRnQ2TFVx?=
 =?utf-8?B?ZkhQanNvTVAzL0JvV0tyeS90YkEycTRMeHVublVLWkpnRVVDNGREd1JJRlJj?=
 =?utf-8?B?dkNrR29McG52bHdBZVFuazhvUkpKSkhsWlpoNjFnaENYRWdNaGhpQnk2Qjhi?=
 =?utf-8?B?NWtEK1VIdkZXME9ycEE5VVMweEFQbUplemEvRU1xWW9WSnIwN1RNQkNJdXNL?=
 =?utf-8?B?TGxObVdPa2cyZDZpQVBkaVBLZVpUVGRUYlpKNGM2TzR5YWoyZ2t5bmNXbWlt?=
 =?utf-8?B?MDRQVGpxRkEvekRNb0Q2ZnZWK0t4dUllM1Z4NmdyV1VqUGtIcTF0dmoxcDRl?=
 =?utf-8?B?Y3dML2tuNlo3QlBldTdNbWF6Q0pweE1CMnBqcUQyd3RHMjVkU1IzeFJaM0lz?=
 =?utf-8?B?WFdNM2JoeVlRTmxKTlBMQ0lqZmQveUlqSjVqZkcreUFqMmhJZFdMV2EzK09i?=
 =?utf-8?B?UWtPOVVqNzhWQkRRQjdnaTZ5cHlvdDhlU3RSOEhiME55dUtEOXZUQkFVeE1Z?=
 =?utf-8?B?TFlrdGJTaDNsUXU4UFVXaElNVHRTeFNhTVdhWHVpd2MrSHlpdVFRL0ZSZzVY?=
 =?utf-8?B?eUswRGZuaWpDaUdBZnVZazhYWkE4a3M1dEh3Ry9hSGE5bmVUY21acVBlSHNU?=
 =?utf-8?B?TkVZcnViR3BEeFJuVUFWekRxc3UvK1BreFo2MzNkQlgzKzE1RlZmUzgvZU43?=
 =?utf-8?B?R1VPL1B0L000NVNTR0hmNmpkUCtnc203WDBMUUJPblRJQmFMOVI3ZmNJRS83?=
 =?utf-8?B?ZkcwUm9xeWxVQklGUWxsb0JOcXh0RGZzL2pQSVlKZG1HQ1JNZ2lrVk82K2cy?=
 =?utf-8?B?QU4yYnVwamJLenAwR2xNemlmUGxrWURRNHFLREx1TytaOEVVTzh6cWgwSFNY?=
 =?utf-8?B?QnZDSENzNWtFMmxHamphY3NFWEtzN1l4L3QvMlMyak5LMzhDM3laWEVkTEV6?=
 =?utf-8?B?d3dNdDUwTUx1T2JuR1RacHYzK3BtdCtBNUlHaWxMK0M1YlJyZGt3RnlhNlJp?=
 =?utf-8?B?N3N3MExWL2ZkR3YzL3kzSTJtb291SVJ0aWNJcUJkZ05KOW0wbDN0dTRpdUlp?=
 =?utf-8?B?RnpDaGJzM2VjMzFhZXRRV0pWbzE0ZGhITEZXTmUycEM4RlJiUS9ZTFMxWVI1?=
 =?utf-8?B?RWdCTW5QcDFZVHNEVnFHWVMvUmE1b1dTL25aL3Ura1Y5YmMxOUtyK1c4YWJ5?=
 =?utf-8?B?WWZzWm95NFVuYjNqMTZuVlpsY3FKT0RIQ1I4OCtjcmkzeVpibmNlazhvRnVp?=
 =?utf-8?B?NHlxMXhrMHBBdzdZMHJmcVJiT1c5dWl0djdqbGRGK0FmN2NaNWloQjVHSnlU?=
 =?utf-8?B?aFBrZlNQNGFrUktGSXkrZ2VsM0RobzFPeFczRTFDcDBXYWEzekkxQnkyaUt1?=
 =?utf-8?B?Y3ZpTDVPazkrSlVPNk00ckUrY1BSSVp6MDBKLzRCMGZMWm9GM0h0SjdCOHdC?=
 =?utf-8?B?NDJwTEZUTldKamtMYmVta1JKS0FyRzREOVlXN1l0L3h4TXgrM0xNaG5kb3VM?=
 =?utf-8?B?NTlhWWdoNkMrSmY5bWlzb1lQeWo4YmlnbTRKa0tvdk1SWm1OMDVRakNzMHh5?=
 =?utf-8?B?RGdpSExBS094WkNKTFgzU1NSaTNvaVZrUGgzVGUzR0pMWE9Gb2UraGpiQUJv?=
 =?utf-8?B?QjA2OFkyTUFFaXFnM1drYld3Mys5TE5QOXh6NEpIem10TkJZblgxaWI2MG5O?=
 =?utf-8?B?VWdjbFpLU3ZjdFNtVTQ3czMwWFc2U0RzWk5HVGFNRVo1VVJjTXhOc1hZVlRE?=
 =?utf-8?B?MDZxVWJuWkUzeExOdERteFJBUEhjRUwvSVJic0U0bVZWeTdnTjZjUnZJUnhH?=
 =?utf-8?B?K3lGRlRQcXJWekgza1p0amhZRkZZQkpuWW5FYmtxQytDc2ltOC91WUR0bDVp?=
 =?utf-8?Q?KSITmCn4KTlZDAI0TPZjEjNqV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9776D28673598640BE9A8BEDAEC0D6A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5410087e-7b94-48b8-b550-08dc6b1a288b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 02:38:47.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GfEEe09FB1FM4uq557D0HprTPPHOAeAAbs/zxIiJoxBLtHQRoCuc58x9bmkYFVDwEeureudXm2diTRGF7iGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6902
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.516200-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvgOwH4pD14DsPHkpkyUphL9X4GSJGyYc367qpOHKudqc6Ge
	nlo/ebgn19iuiJe0Zld7fWQyyQ7Sr66UR+fsf9oDwVaayvK71l+46mo/tvaT3JEfv6UzUvbdoKq
	dagw8NC4a9foeMW5TJ3F5zpucqy2iJBVW14/3QK0D2WXLXdz+Ae3+iQEtoSj4+3n3Z6rbGhMNgl
	Bs2cTdndKTqNNvpFbTQEqLGEK5VoyE9zgVMk3pXhWCVBr+Ay98ndls9F9zmi3fc2Xd6VJ+yhM9e
	bPbqKjLI0VEPr+J+I+KGUoOUuWu8gzyMxeMEX6w0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDUZPbHO1fzrNO80BVEBGFfxbqSjjNGsqJBGuYik5c+d99Jv4yDUy1Iu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.516200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BE7BA7625697C5707623ECB2D654CAE9E741EA2FBD98D082A3FCEFE0578737D62000:8

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTg6MzggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU2V0IERSTSBtb2RlIGNvbmZpZ3MgbGltaXRhdGlvbiBhY2NvcmRpbmcgdG8g
dGhlIGhhcmR3YXJlDQo+IGNhcGFiaWxpdGllcw0KPiBhbmQgcGFzcyB0aGUgSUdUIGNoZWNrcyBh
cyBiZWxvdzoNCj4gDQo+IC0gVGhlIHRlc3QgImdyYXBoaWNzLklndEttcy5rbXNfcGxhbmUiIHJl
cXVpcmVzIGEgZnJhbWUgYnVmZmVyIHdpdGgNCj4gICB3aWR0aCBvZiA0NTEyIHBpeGVscyAoPiA0
MDk2KS4NCj4gLSBUaGUgdGVzdCAiZ3JhcGhpY3MuSWd0S21zLmttc19jdXJzb3JfY3JjIiBjaGVj
a3MgaWYgdGhlIGN1cnNvciBzaXplDQo+IGlzDQo+ICAgZGVmaW5lZCwgYW5kIHJ1biB0aGUgdGVz
dCB3aXRoIGN1cnNvciBzaXplIGZyb20gMXgxIHRvIDUxMng1MTIuDQo+IA0KPiBQbGVhc2Ugbm90
aWNlIHRoYXQgdGhlIHRlc3QgY29uZGl0aW9ucyBtYXkgY2hhbmdlIGFzIElHVCBpcyB1cGRhdGVk
Lg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCAyMiArKysr
KysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuaCB8ICA0ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggOGUwNDcw
NDMyMDJiNC4uYzljYWQzYTgyNzM3NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gQEAgLTI5NCw2ICsyOTQsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgxODhfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4g
IAkuY29ubl9yb3V0ZXMgPSBtdDgxODhfbXRrX2RkcF9tYWluX3JvdXRlcywNCj4gIAkubnVtX2Nv
bm5fcm91dGVzID0gQVJSQVlfU0laRShtdDgxODhfbXRrX2RkcF9tYWluX3JvdXRlcyksDQo+ICAJ
Lm1tc3lzX2Rldl9udW0gPSAyLA0KPiArCS5tYXhfd2lkdGggPSA4MTkxLA0KPiArCS5taW5fd2lk
dGggPSAxLA0KPiArCS5taW5faGVpZ2h0ID0gMSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX21tc3lzX2RyaXZlcl9kYXRhIG10ODE5Ml9tbXN5c19kcml2ZXJfZGF0YSA9
DQo+IHsNCj4gQEAgLTMwOCw2ICszMTEsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5
c19kcml2ZXJfZGF0YQ0KPiBtdDgxOTVfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkubWFp
bl9wYXRoID0gbXQ4MTk1X210a19kZHBfbWFpbiwNCj4gIAkubWFpbl9sZW4gPSBBUlJBWV9TSVpF
KG10ODE5NV9tdGtfZGRwX21haW4pLA0KPiAgCS5tbXN5c19kZXZfbnVtID0gMiwNCj4gKwkubWF4
X3dpZHRoID0gODE5MSwNCj4gKwkubWluX3dpZHRoID0gMSwNCj4gKwkubWluX2hlaWdodCA9IDEs
DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0
YSBtdDgxOTVfdmRvc3lzMV9kcml2ZXJfZGF0YQ0KPiA9IHsNCj4gQEAgLTMxNSw2ICszMjEsOSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgxOTVfdmRv
c3lzMV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZXh0X2xlbiA9IEFSUkFZX1NJWkUobXQ4MTk1X210
a19kZHBfZXh0KSwNCj4gIAkubW1zeXNfaWQgPSAxLA0KPiAgCS5tbXN5c19kZXZfbnVtID0gMiwN
Cj4gKwkubWF4X3dpZHRoID0gODE5MSwNCj4gKwkubWluX3dpZHRoID0gMiwgLyogMi1waXhlbCBh
bGlnbiB3aGVuIGV0aGRyIGlzIGJ5cGFzc2VkICovDQo+ICsJLm1pbl9oZWlnaHQgPSAxLA0KPiAg
fTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RybV9vZl9p
ZHNbXSA9IHsNCj4gQEAgLTQ5Myw2ICs1MDIsMTUgQEAgc3RhdGljIGludCBtdGtfZHJtX2ttc19p
bml0KHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0pDQo+ICAJCWZvciAoaiA9IDA7IGogPCBwcml2
YXRlLT5kYXRhLT5tbXN5c19kZXZfbnVtOyBqKyspIHsNCj4gIAkJCXByaXZfbiA9IHByaXZhdGUt
PmFsbF9kcm1fcHJpdmF0ZVtqXTsNCj4gIA0KPiArCQkJaWYgKHByaXZfbi0+ZGF0YS0+bWF4X3dp
ZHRoKQ0KPiArCQkJCWRybS0+bW9kZV9jb25maWcubWF4X3dpZHRoID0gcHJpdl9uLQ0KPiA+ZGF0
YS0+bWF4X3dpZHRoOw0KPiArDQo+ICsJCQlpZiAocHJpdl9uLT5kYXRhLT5taW5fd2lkdGgpDQo+
ICsJCQkJZHJtLT5tb2RlX2NvbmZpZy5taW5fd2lkdGggPSBwcml2X24tDQo+ID5kYXRhLT5taW5f
d2lkdGg7DQo+ICsNCj4gKwkJCWlmIChwcml2X24tPmRhdGEtPm1pbl9oZWlnaHQpDQo+ICsJCQkJ
ZHJtLT5tb2RlX2NvbmZpZy5taW5faGVpZ2h0ID0gcHJpdl9uLQ0KPiA+ZGF0YS0+bWluX2hlaWdo
dDsNCj4gKw0KPiAgCQkJaWYgKGkgPT0gQ1JUQ19NQUlOICYmIHByaXZfbi0+ZGF0YS0+bWFpbl9s
ZW4pIHsNCj4gIAkJCQlyZXQgPSBtdGtfY3J0Y19jcmVhdGUoZHJtLCBwcml2X24tDQo+ID5kYXRh
LT5tYWluX3BhdGgsDQo+ICAJCQkJCQkgICAgICBwcml2X24tPmRhdGEtDQo+ID5tYWluX2xlbiwg
aiwNCj4gQEAgLTUyMCw2ICs1MzgsMTAgQEAgc3RhdGljIGludCBtdGtfZHJtX2ttc19pbml0KHN0
cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0pDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gKwkvKiBJR1Qg
d2lsbCBjaGVjayBpZiB0aGUgY3Vyc29yIHNpemUgaXMgY29uZmlndXJlZCAqLw0KPiArCWRybS0+
bW9kZV9jb25maWcuY3Vyc29yX3dpZHRoID0gZHJtLT5tb2RlX2NvbmZpZy5tYXhfd2lkdGg7DQo+
ICsJZHJtLT5tb2RlX2NvbmZpZy5jdXJzb3JfaGVpZ2h0ID0gZHJtLT5tb2RlX2NvbmZpZy5tYXhf
aGVpZ2h0Ow0KPiArDQo+ICAJLyogVXNlIE9WTCBkZXZpY2UgZm9yIGFsbCBETUEgbWVtb3J5IGFs
bG9jYXRpb25zICovDQo+ICAJY3J0YyA9IGRybV9jcnRjX2Zyb21faW5kZXgoZHJtLCAwKTsNCj4g
IAlpZiAoY3J0YykNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4g
aW5kZXggNzhkNjk4ZWRlMWJmOC4uNmNmYTc5MGU4ZGY1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gQEAgLTQ2LDYgKzQ2LDEwIEBAIHN0cnVjdCBtdGtf
bW1zeXNfZHJpdmVyX2RhdGEgew0KPiAgCWJvb2wgc2hhZG93X3JlZ2lzdGVyOw0KPiAgCXVuc2ln
bmVkIGludCBtbXN5c19pZDsNCj4gIAl1bnNpZ25lZCBpbnQgbW1zeXNfZGV2X251bTsNCj4gKw0K
PiArCWludCBtYXhfd2lkdGg7DQo+ICsJaW50IG1pbl93aWR0aDsNCj4gKwlpbnQgbWluX2hlaWdo
dDsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgew0K

