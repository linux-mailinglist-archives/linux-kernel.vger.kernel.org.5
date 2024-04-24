Return-Path: <linux-kernel+bounces-156811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC478B087F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464552881C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64815A492;
	Wed, 24 Apr 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BRFoLjeK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="D+Wmzbav"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4215A4A4;
	Wed, 24 Apr 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958999; cv=fail; b=ZCMTvRsMhbauqr7OW1Kw7EeHewmMTdJX8iZsspL4pg9aXGFA1P3Z/rmVLrdLQKvz3TqdwAttnb6q46IX5YaS3yjQSNJ44gltjIaJNWW859yDbb74diKEx5T/VwqgcEfiLPHkaHU+YL3E9M30brJ7sZfN2fJeutMoAu8DKOJsje4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958999; c=relaxed/simple;
	bh=T2bEmeuNSv8hUr2shzIod6JXAyJTGFepZaCgarPncg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=opw/LyqiKPDctGpI5TpUH/6TiVIZa7qudoj9pK7SHuUeH6YaRdwjzbN1+oM4rFVfTVC326+zdwtZ8mzAIg6CGmgYsx2LgndsJ+bq/QF4AN5GUX8nBdZBstLcqoyPSVtfxTtL7VIIyu5EiMGpnal5cYCbl3DH87OvnOTJ+z0v9tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BRFoLjeK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=D+Wmzbav; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4c89dc0022f11ef935d6952f98a51a9-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=T2bEmeuNSv8hUr2shzIod6JXAyJTGFepZaCgarPncg0=;
	b=BRFoLjeK5iEXJnIsdU68ybB9qT/BHQPm3ay0FSCtFDQea6z5vQ3P4gaP5Ytw9WwB481w7j86XdqGWTcsUh3Myz3W16+LLKpol83dpV1nN+s1Vt6IGr8r57wgNTR4orL0K44qZrpCqumKnvfi+XQ/x46y7k8GTu9pmszD29k+320=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f71fe2da-9e93-491e-ac48-f88b93e1d2c1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:52930f83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: d4c89dc0022f11ef935d6952f98a51a9-20240424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <peter.tsao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1810976086; Wed, 24 Apr 2024 19:43:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 19:43:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 19:43:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsmkUO1Q7q8qo+tLi5fuso2kUJiqn1JvDgfpTq2r4Uky8TaMalA/IgqYOEdGCXyStR8rIkB/9t7M6o5rcPO0irlHJyxtpN7UTB3tUNf3e+AOwLeI+lt0GksBqs+raUT+PqSwmsFhsw9xXiFluw+L+zUSqFDfBH5Rdcj8sjuzvRa1bocpBzpM1jQZcumGfVaSlVuI2PEFp0yBICJw9NzY11vPB6eGf50b78qnGlUk+uhRIJfz4Wue8gTUU+sn/xe5C1NdLKcaKY0geWsTEoyQW05vA0+BMGhPuWJ7siDj3a3pSQp2S1VTDpTloFm3AYHORbpaZFy802aGyURTeJnBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2bEmeuNSv8hUr2shzIod6JXAyJTGFepZaCgarPncg0=;
 b=YiBtsTkAGH2BpEOJMqz+y26V42QN0oNeep+KUztkyG+2fCwGxGM8o1tSFriRX8phtb0eya01MjHNo2bh9hdrK+itF9SCrP9qEY433X4rSsAW1lfvJmQYlOIVz7GuTHqUhr2AZYNOLRT2mI3NwK6ZHYRhDjbOjApq77QcKEWldT+m4+LEP1xJrbtGn1p+vA4EI1+JLbrJcQsClL6WZ8Rg452oq8acmFL3WvZgJC7h+brpmgFhnMI1dD1bRS96xmD62P5Hn4JRGS6mDIqOSfsFU++0KQ2CuhP2Mi8ISBXJs2oLc8b6ZxIboy89PcJnZQh8uBb4Zl6aDn43aZj9spOGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2bEmeuNSv8hUr2shzIod6JXAyJTGFepZaCgarPncg0=;
 b=D+WmzbavkscYAqntUyt0LvpE7cWrlaFSeSKApHaqKxS7nDUWtyqKKzVPAOxZF4BaW8eO3HN42/44AUiWis3w4o7C6NLaOk8+T69IEie/9n/+3XlP649fdSPnaB4IsqnGnQHbHzjeMNAgYFXxsh1z6GXBDXsF4SDOPe8Pw34JYzM=
Received: from KL1PR03MB5976.apcprd03.prod.outlook.com (2603:1096:820:8b::11)
 by SEYPR03MB7461.apcprd03.prod.outlook.com (2603:1096:101:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 11:43:08 +0000
Received: from KL1PR03MB5976.apcprd03.prod.outlook.com
 ([fe80::1e68:565:d7dc:3f58]) by KL1PR03MB5976.apcprd03.prod.outlook.com
 ([fe80::1e68:565:d7dc:3f58%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 11:43:07 +0000
From: =?utf-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"aros@gmx.com" <aros@gmx.com>, =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?=
	<Chris.Lu@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [SPAM]Re: BT_RAM_CODE_MT7961_1a_2_hdr.bin is missing in the
 firmware tree
Thread-Topic: [SPAM]Re: BT_RAM_CODE_MT7961_1a_2_hdr.bin is missing in the
 firmware tree
Thread-Index: AQHalg3Lwk/yWWNNjk+SUAEZuKGLm7F3TQkA
Date: Wed, 24 Apr 2024 11:43:07 +0000
Message-ID: <9bed1f526b5be4a7ae6d89188d7bd46ec7b66e0c.camel@mediatek.com>
References: <6574fc0f-8a24-4aff-8a1b-dbf960b6375d@gmx.com>
	 <3b983390-110e-4c68-a825-6e811de78919@leemhuis.info>
In-Reply-To: <3b983390-110e-4c68-a825-6e811de78919@leemhuis.info>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5976:EE_|SEYPR03MB7461:EE_
x-ms-office365-filtering-correlation-id: 4e8579c5-bf76-4200-c9e8-08dc6453b5f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?WHcvVTNRZm1kKys3SnQ2TlBPek4xVmtyR2JsMFZVVFBCbWRLR2FYZDVZbzhv?=
 =?utf-8?B?MWdZTWtMdGo5TG9oRXBmS3FOa1Q1d3hlTTF2dWgyTTNqM3hpWWpvTW9DZk40?=
 =?utf-8?B?WE5wdm9JbGkzTTJ6V3Fmd2JqeitydDJpUXZCNjhRZDBSaDh4c2hNdjBYTFhU?=
 =?utf-8?B?Q3ByenpnUHg2S1NIRENWV3dwMnk0WGEvYy9MYnQyUTdSRGVIUHcrYmIrMTZz?=
 =?utf-8?B?QlJqajJHSklzYUxFZEk3MkpCVG45cjYwWEFlc3ZiSzdMcm5iVXVzQkVwaG9J?=
 =?utf-8?B?bXVleUpOMjAxVlBHUUxGa1BqeVNpcklyYk50RXJwbzlhcGhta0oybmxMY2I0?=
 =?utf-8?B?Uk5yREhyTWVXdG44aC9yNVBwM2dKd0NVdzdnYkxtOHpwbUJTVHRTRTZIT3pV?=
 =?utf-8?B?QW5rdUc0NEVrMDE4cDIzWDdkbE1ObmpPbXIxMjJOYXBsd3hiUm5kQXk1cXFj?=
 =?utf-8?B?ckw0eEdVckNLQllmVnNZbzgrYTIvczdhMFhMdlFrTTA2Yis2ZEI5Tk50VEMv?=
 =?utf-8?B?UGdxbWhNa2lrREo1aWVDQ2RwZU95eHpEQW8vMUVEYW03K0tGekE4c2lsR29G?=
 =?utf-8?B?aHJWK2h6WmREU2JnbzJMQThhV0tROWFYUDQ1OGhHNW9sUW02UDdYd0ZsV3FI?=
 =?utf-8?B?WTZmbCtrY295a3hnN2VCOGl0MGlZcFFPRjA2WTcwam0yOEJ3QXB0dXFZZ2kr?=
 =?utf-8?B?ZU9POG1JZWJQbFFCMy9sc3RRTCtVeDJZQm5kcHlGL2hsZ1RJT3RzQkJYUXky?=
 =?utf-8?B?TnRNYnZRRFNidUhZb3dLVkEvSzhZQkRna2t3czYxeXFiVXpraVJrUy9RT0dP?=
 =?utf-8?B?bXBSWXcrN1JIdTN0Ym9VWEpWZk1CUHA1ZXJzalh5WThLYjFHSWZQV0ZhTE50?=
 =?utf-8?B?SklTd2Izc3dDd0Iwdzd3WnFUWEM2aC8rRkVxSGxTS2RLdFpLYXZmVG85TUVB?=
 =?utf-8?B?V3dtaWswMHQrYnk2cjF2d1N6VGVXUjgyRHliVjdBSThJN0ROWHYxWlVrYVl2?=
 =?utf-8?B?dGVNOCt2dmJQaXY5Sy8rQmJ4MWtQVHVFMEl4Yk1wQTZMaHV6RUVmbWQ4VTc4?=
 =?utf-8?B?NWhBNStPZ1I2Rm5qUjlvNERGbkcrY1ZDQlkvVXliRTJ1eDhweGRxa2s2emVz?=
 =?utf-8?B?eHZ2WFRtcnA2eEZIdmo4SkNDNDJCcDd5cTV4bjFoSkJXSXVVS1RrYitQeWFp?=
 =?utf-8?B?b3VxT0dhelRoQUdoVncrZmt0c250Mjc1STh3NVJtbnBoZStpRUVuU2UvamFN?=
 =?utf-8?B?TjYyZXlrVFFDYzRyd3VhYzRtRHBnNnFGbEU5ZGduTlArNExHQ3ROUTI0ZG1J?=
 =?utf-8?B?ODBTT1FBMjhQTFlBWDM4ZGg5TmUyWnVFRDcxMmJpQVFsTmhnTkJkRGxyVlJa?=
 =?utf-8?B?bmwreHpWWmJiM1BUK0tJTkkxclhMZjJOMUNCeThvd09LRUdGS1JTMCtwclFS?=
 =?utf-8?B?Ym9oajkrTmo2TGpLZWNTWEYvSHZYd2l6TEc2Y3hyS0NuOFl3MURCWHE2VURi?=
 =?utf-8?B?bEsvb1Z5WTdnOFpnVkM1ZVd3bU92Z2pIbmRsSE04ZkFENFRPVnhvSENDQkxH?=
 =?utf-8?B?TXdmd2J1bm9pd2RpaXM1aGpmME1nVXByQXI5b0RXamJ0YUNSWmlaWU1oMkVC?=
 =?utf-8?B?Z1cxLzNNZk9MMzhDM2g1YVpuVFBMVGJjOG1pV3lkcXdoVG5kbUdVd09UTXh1?=
 =?utf-8?B?MjN6cEF4cERPUEh3Y3ZVT2UvQmp3alEzMXlJM1UrWTVtUUpmSUl6NWFhdzRX?=
 =?utf-8?Q?O4TiG10PgAAyTv9Rg4XUH18HNIRMZIXiO9dB3Db?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5976.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(217643003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVRMbjVialJoV2Uvait4RWx1dmhuMjBML2NtVEZPZm94Uk5CVmVhajlDaWdY?=
 =?utf-8?B?UnFxeVpmTXU3WlVKR2N1RlVuOGt4RWswalFDWkQ0dmxRQUsvdTlqNUYrLytC?=
 =?utf-8?B?WjlvdURreUIrNDUwMHI2WTZIWmVUZDF4YXNVZktBM1lYS29IVjllQ29qVSsr?=
 =?utf-8?B?RVJ5MmxKQ1lwR3REQTFlUVlFZ0lmc2lOdTZtRDdBMTZVY2QxQzc4VkN1Y1FW?=
 =?utf-8?B?TnR3anc0aW1WYnltQmMrWE1PeTUxbGFITm92WkF3bUVLUGNXWHVqeXdFN3M2?=
 =?utf-8?B?cUpnNmVCUjkwQUxBK0NmWHFYTVpoZmI2My9zck40aC84QW05NklYc0ZVODhW?=
 =?utf-8?B?M0hEdXUwT1VoL1pCOTd4Ym9Gb055b1NyNElBTUhHZUVsWi9NNEJLSXk3R1B4?=
 =?utf-8?B?aUFCUFpMM0ZoSVJJWm1PVWNrb0taUHk4S2lEZm9VOWpQbEtEOXlRNFFPYURn?=
 =?utf-8?B?d3R2ekpqb3RVb3BvYkF4cDB3M2xURFVQSEhSdU5vNmhmNTZuU25OYUI0YmNM?=
 =?utf-8?B?d3B1cVRoWmFrekZOMEV1VXlDSml0NCtiMzZzWjJFeVAvbmNSMG1tMUl5enps?=
 =?utf-8?B?RDZ5c1lPSjZoNDljWENXbHlScHNFNnZZM2JRQmpwVS9VLzFFMkp5ODdHTURt?=
 =?utf-8?B?ajh1Mk5Mc25VdUMrY3ZibTNoK0d5dk90SHVLWEFJSXpIMTFET21jWjdCemhx?=
 =?utf-8?B?eVl1MFpNM3pSTE5HUW9leWYyUGM0WGJtSHJud3A4QkN6OWlyZ0txUi9RTGZT?=
 =?utf-8?B?Y0phRnlrY0VidHNqdURBQlpmVFBPL0oxd1NNYy84aU5jTlRVeEMzRE5OWFk2?=
 =?utf-8?B?Y0FENWxRbmh0NUY1NHRWeEhWeGt3ODVHOHF2TUJPQXdTdkcxb21nWGxWS2lx?=
 =?utf-8?B?akpWQ3hIdDEvZVlBMEZtWnIxMFp2ektSZkNFUVRGWkZCQnhjWVhPVmFZTXdp?=
 =?utf-8?B?bGJjR3lBQkFrREdsTDREcWZDTy9tQlBPZFVFVHZIUFVSenJpdVJmWFBSQXRv?=
 =?utf-8?B?QVQwUXBnMlhTNkZISFcrcTZUMnc3Uk0wMkplaFQ0TExGYWduYlJNanc3bVNB?=
 =?utf-8?B?d001TjMyN0tMVXNNQkNmZ3MzVnpXems5bjhrdWhrWFNITlpUUUFOQ3ZFdlBl?=
 =?utf-8?B?Sk1WZE1YdHpab3A2bmNnQkxvRWU2RE0xdVVyTExCeG5PRzNGR2U5Yit6TTZG?=
 =?utf-8?B?NGFkTHdyb0F2TVJlYWxod21CVWVDYVk0THFBbDJ3NTJ5VklFMXUwVEdxZUtW?=
 =?utf-8?B?VC81cTFkYWhidmxwdUIra2VSN0JrM2o1QkxUMXdFZ1ZZQ3R1anBURWxxMFJs?=
 =?utf-8?B?dFYxQ1RoM2dPZWlFd3dma3kwRWV3SnIxS0dLTGkrTjlEYjEvRVFGdk9LRWFU?=
 =?utf-8?B?djEycVFuY28yKzBtSktwQk5pZ1Q4QUEySVRvY0dMdEdZVU12dnNNTEpvdkhx?=
 =?utf-8?B?TVdRNG9UZlhCd0ZhNFlOM0RHTmM2Wm1BNktkcjllRGJRVnkzcGdqeTVGcStp?=
 =?utf-8?B?QURiK3RSSlhmaGl1QmtvaXNiQzc3MGFMZUFwZmlUc3BZd25CdTczdDhKM01w?=
 =?utf-8?B?TzlPakRHYmhzaktGUFVYWUt0Vml4WFRVYUs1KzYvRk5mTjR5MXlIanAydnoy?=
 =?utf-8?B?dEorRmdKV0l6TTVPSUtDMUdyanowdlQ0MVFpRDNXby9WTXk1ODVqdFhkVDVD?=
 =?utf-8?B?R2NuOGdVZUhoQnBCNSt0bkVGaHg4ajVodjFVeWc1ZktibGw0VzBZRnZGNFJH?=
 =?utf-8?B?WnQvMWJWbmhDT25sU3c4Vmhtd0RjMjJQbkNPRW44VEZjRzJyY05YaGxYYUlz?=
 =?utf-8?B?UTNnV2dwYVJONTJsNnhkcldycUdnQXloSWpVSXJBM3NwekZtbUY1S0lNM1BC?=
 =?utf-8?B?UUJ0K2VDanAwZ0xXRVE1d21CcW8xL3dNdzRpUDMxeWdGM2cxT255VmZsejF5?=
 =?utf-8?B?SXRNcnRJSHNVMyt2VmZ1UFdraTVKMWZOaDVBMC9OcHF4S1Nkd1lwMnMxTzNs?=
 =?utf-8?B?ekREbWxSWUJ6QzdyRWhFa1piLzNpOE9oTkorRUQ4Z1NlSnRBc1Bzck1ldVRX?=
 =?utf-8?B?QUQ1THU4cE8yVGdQWEw4c29iaTZGUGhzY3VXVDBoV0pzd3JBQ1VDWUxXaGJS?=
 =?utf-8?B?MVZEV3U0RktrMEVoYWtRNDlwcGUzSnZPM3JpeUF1dUpTOEN1NHpFVzVKbkVF?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6133B7EFDC2A6E45AF320A2B45A38025@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5976.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8579c5-bf76-4200-c9e8-08dc6453b5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 11:43:07.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJsR3+xOOhRoaO49BY0/irwz5gxfzj7ECJXzyjlbTVhXQjLpebMOLQpRUmM9oDu4OtWrSo1Gc0jSt9ZN3QeeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7461
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.386900-8.000000
X-TMASE-MatchedRID: Nail4dlEBNHUL3YCMmnG4qwOh3D3JSTG2aYdnwn7qHf4JyR+b5tvoKEG
	Khm9baaNaxHUj1lladLmTMsOMIMt1xXfDcvxC40QlTsGW3DmpUsraL2mh8ZVK8Ri+FlXlWiFLrv
	R7aAmJFix7sLYPyWWYhe6pZB9+O5GxQWPXEu5GyYmtTGirqG/D52l+dw4X/RZDO+DX+rUwfaLKb
	tS74W9T/9NaPXfiafLoUNjrNnbqmgyuNiVUr7twHQEQEU5OIefuLwbhNl9B5UujyxRHwe+HM3Nx
	Xt1YjuORQII9MXXajr3HN/O0YC44Wm7zHaX7fyLFUNRozODPxgnMwsJei+AwxL6MU7t349by0YU
	AJwna7Li8zVgXoAltj2Xsf5MVCB15A2KZtey50Ox5amWK2anSPoLR4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.386900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BA55436EBD69B33D6B37AD83A39FA980D46F3890C648948EA36776E936F906F22000:8

RGVhciBUaG9yc3RlbiwNCg0KU29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5nLg0KTVQ3OTIw
IGFuZCBNVDc5MjEgYXJlIGRpZmZlcmVudCBjaGlwIChoYXJkd2FyZSkgYnV0IGJvdGggdXNlIHNh
bWUNCmNoaXBfaWQgMHg3OTYxIGFuZCB3ZSBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZXNlIHR3byBj
aGlwIHRocm91Z2ggdGhlDQo4dGggYml0IG9mIHRoZSAiZndfZmxhdm9yIiByZWdpc3Rlci4NClRo
ZXJlZm9yZSwgSSB0aGluayB3ZSBoYXZlIG5vdCB2aW9sYXRlZCB0aGlzIHJ1bGU6DQo+IFVzZXJz
IHN3aXRjaGluZyB0byBhIG5ld2VyIGtlcm5lbCBzaG91bGQgKm5vdCogaGF2ZSB0byBpbnN0YWxs
IG5ld2VyDQo+IGZpcm13YXJlIGZpbGVzIHRvIGtlZXAgdGhlaXIgaGFyZHdhcmUgd29ya2luZy4N
CmJlY2F1c2UgTVQ3OTIxIHN0aWxsIGJlIE1UNzkyMSBhbmQgdXNlIHNhbWUgRlcgYmluDQpCVF9S
QU1fTVQ3OTYxXzFfMl9oZHIuYmluLg0KDQpBYm91dCBNVDc5MjAsIHdlIHdpbGwgcHVzaCB0aGUg
c3RhYmxlIEZXIGJpbiBhZnRlciBpbnRlcm5hbCB0ZXN0IGRvbmUuDQoNCkJScw0KUGV0ZXINCg0K
T24gV2VkLCAyMDI0LTA0LTI0IGF0IDA4OjA2ICswMjAwLCBMaW51eCByZWdyZXNzaW9uIHRyYWNr
aW5nIChUaG9yc3Rlbg0KTGVlbWh1aXMpIHdyb3RlOg0KPiBPbiAyMy4wNC4yNCAxMjoyMywgQXJ0
ZW0gUy4gVGFzaGtpbm92IHdyb3RlOg0KPiA+IA0KPiA+IENvdWxkIHlvdSBwbGVhc2UgcHVzaCB0
aGlzIGZpcm13YXJlIEFTQVA/DQo+ID4gDQo+ID4gSXQncyBiZWVuIHJlcG9ydGVkIHRvIGJlIG1p
c3Npbmc6DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg3NTdfXzshIUNUUk5LQTl3TWcwQVJidyFq
TDg4anVITWNCOUNraGZReTAwdEdWaldzUlhYZE1OLV9UMjhBTklQMXhkdzBDNVlyMmRFTm0wbU0z
bjlFZ3Y1eHFkVDdvRHlFWHRPc3dKNm8yRVlaU3c5aF92NSQNCj4gPiAgDQo+IA0KPiBGV0lXLCB0
aGF0IGNhbid0IGJlIHRoZSBvbmx5IHNvbHV0aW9uIGZvciB0aGF0IHByb2JsZW0sIGFzDQo+IERv
Y3VtZW50YXRpb24vZHJpdmVyLWFwaS9maXJtd2FyZS9maXJtd2FyZS11c2FnZS1ndWlkZWxpbmVz
LnJzdA0KPiBjbGVhcmx5DQo+IHN0YXRlczoNCj4gDQo+ICIiIg0KPiBVc2VycyBzd2l0Y2hpbmcg
dG8gYSBuZXdlciBrZXJuZWwgc2hvdWxkICpub3QqIGhhdmUgdG8gaW5zdGFsbCBuZXdlcg0KPiBm
aXJtd2FyZSBmaWxlcyB0byBrZWVwIHRoZWlyIGhhcmR3YXJlIHdvcmtpbmcuDQo+ICIiIg0KPiAN
Cj4gQ291bGQgYW55b25lIGZyb20gbWVkaWF0ZWsgcGxlYXNlIGNvbmZpcm0gdGhhdCB0aGlzIHJ1
bGUgaXMgYWRoZXJlZD8NCj4gDQo+IFNpZGUgbm90ZTogSSB3b25kZXIgaWYgUGV0ZXIncyBwYXRj
aA0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDQxNTE0MTkyMi4yNTA1NS0x
LXBldGVyLnRzYW9AbWVkaWF0ZWsuY29tLw0KPiAoIkJsdWV0b290aDogYnR1c2I6IEZpeCB0aGUg
cGF0Y2ggZm9yIE1UNzkyMCB0aGUgYWZmZWN0ZWQgdG8gTVQ3OTIxIikNCj4gaXMNCj4gcmVsZXZh
bnQgZm9yIHRoaXMuDQo+IA0KPiBDaWFvLCBUaG9yc3RlbiAod2VhcmluZyBoaXMgJ3RoZSBMaW51
eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXInDQo+IGhhdCkNCj4gLS0NCj4gRXZlcnl0aGlu
ZyB5b3Ugd2FubmEga25vdyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2luZzoN
Cj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saW51eC1yZWd0cmFja2lu
Zy5sZWVtaHVpcy5pbmZvL2Fib3V0Lyp0bGRyX187SXchIUNUUk5LQTl3TWcwQVJidyFqTDg4anVI
TWNCOUNraGZReTAwdEdWaldzUlhYZE1OLV9UMjhBTklQMXhkdzBDNVlyMmRFTm0wbU0zbjlFZ3Y1
eHFkVDdvRHlFWHRPc3dKNm8yRVlaWGh1bndLbSQNCj4gIA0KPiBJZiBJIGRpZCBzb21ldGhpbmcg
c3R1cGlkLCBwbGVhc2UgdGVsbCBtZSwgYXMgZXhwbGFpbmVkIG9uIHRoYXQgcGFnZS4NCg==

