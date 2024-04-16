Return-Path: <linux-kernel+bounces-146261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A518A62D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A97D1C2201F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE53C097;
	Tue, 16 Apr 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B8edmuio";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OjQqEKlN"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A163839D;
	Tue, 16 Apr 2024 05:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244077; cv=fail; b=r5X7wTGxC4OtMU/agZxgwAvKmc8MuuH4t0Midd99gQvfshTv9zR5nL2Fjj3LvZPTuUd7hCgLBcuJkVL0YhVCzpkQtmBr7/SSHQwWGwcAs0BsR2NvzDfvb4NdMkmjbVZP1M1cymdpZ1NghmcQ726tYfSJ7pJL1WTt09wFbs0eemw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244077; c=relaxed/simple;
	bh=8/UvhkzRv/wNUs887MH/2YTWKH8su5xTMe3/TZ4aZNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNsAMa8eHWhzrYEQtZ5dw5d79XGRegmiwEm2edk0GZH/v7zHbWppAby6k5ge5n9SFBtvkpc0e+mDw0A7lVxWswpPtTfymKSHfMetrH1en6ITdYBTR/MRliBee7RnE73o5xE1u5z943TZ2JfCRtHK5XvJ5oNbFA057LaWIZX41Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B8edmuio; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OjQqEKlN; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 467a0e54fbaf11ee935d6952f98a51a9-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8/UvhkzRv/wNUs887MH/2YTWKH8su5xTMe3/TZ4aZNE=;
	b=B8edmuioEC/ADSX3pVOyZh7jhCjyhUlnNejPMk94Xsa8L5iCi3GzH8aHDd+ksz+ndlwDVXiZdhSeJrEDJ2SXVJ5edXJutQlL7RpOmzGBZfYYoCO1dAKJ8p/nEcB4fNB9edIlR6yOxYpZ1EgQRlrs8ITJnaeG9GOQPkF+UtKiyNU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3fc25b35-11cf-4681-8d5d-5c02f208abfd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:6dbe3986-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 467a0e54fbaf11ee935d6952f98a51a9-20240416
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 982798087; Tue, 16 Apr 2024 13:07:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 13:07:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 13:07:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlRt8y8zY4enJzFnED+mixGeL3aHlVUTpacFjZuODB4nC7jrqhLNux20F5rl26d9CPFKjd37QX+CBWNHAolS7SbypWdgt7TdRz+wAyjBaJhxWEgIE7qFfppZfINKPxoDAd6IWSpjcRQM6aEtV4tGDU7Vlgpc3gEbMUsPpNP3EDQ6L1u3ffERwusB0lCnhV3tRT8AV6jCmTR5PNVg7kmLIc9rZHYRTyydE+/kGnBQMR+E33GyhmklUwkdpUZbN20pFT8rnPuX+LrGi3UxOhm+KD5Iqq4GLh+0/QowjH0BJP7ifnNxBJghUfgy8FEpnhjhHecXpxnp7PRCWfHnsL6HUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/UvhkzRv/wNUs887MH/2YTWKH8su5xTMe3/TZ4aZNE=;
 b=Ks/dA+khtqSv0CxQ0nkFD8h8qMjKtxL4qOX4m6D1uUhFPwPsU6C5GXX2N/ZkviHVqUSgkI5ZB1qP6wOaC8HM+JzJWbl5gBFvajfbO1MxAH+0fo8z0RyLzqqUuaHLD1joJVQnV22Pxn1D0TaJjudRjwfmQNIHJ56/1NJhyezbW30k63FA6RoHZR6YDI6mcqMjbH1bBToeJbF4j0o5Pd0XTOR/yyw0w1UcdCwNdv6DJiabwf8qPxahFM3q3h49IEiqFgql8Rom50k1T16+kt/cHDxd1vC/igruMwwrqrsHkqSmpbEouUKDxLaEJ+N54wgtm+lNX9sNNwVZXXWZ6ng+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/UvhkzRv/wNUs887MH/2YTWKH8su5xTMe3/TZ4aZNE=;
 b=OjQqEKlNEWb3Q/l3xrGLje92XurX4rV24rze0IoNBZGeXvhNv8MvKguoaKCA4TEo5SAcaFQF+Ygn+JEm2gyODzUucUntBbWiZsbeucZliIl5uRbi/cXpnP09qhuGlDse4DyLIqwfupFzajgt1kg4G08nHNm2QRhYmQqXExkBsnA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OS8PR03MB8872.apcprd03.prod.outlook.com (2603:1096:604:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 05:07:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 05:07:45 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "tfiga@chromium.org" <tfiga@chromium.org>, "nhebert@chromium.org"
	<nhebert@chromium.org>, "nicolas.dufresne@collabora.com"
	<nicolas.dufresne@collabora.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"jkardatzke@google.com" <jkardatzke@google.com>,
	=?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"frkoenig@chromium.org" <frkoenig@chromium.org>, "stevecho@chromium.org"
	<stevecho@chromium.org>, "wenst@chromium.org" <wenst@chromium.org>,
	"jstultz@google.com" <jstultz@google.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "tjmercier@google.com" <tjmercier@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5, 19/23] media: mediatek: vcodec: disable wait interrupt
 for svp mode
Thread-Topic: [PATCH v5, 19/23] media: mediatek: vcodec: disable wait
 interrupt for svp mode
Thread-Index: AQHajLlPQOJ/uZSP40Ksw9Px35d4jLFqXpQA
Date: Tue, 16 Apr 2024 05:07:45 +0000
Message-ID: <ef2719ccc4f72cb01028021fd75906d4a6089023.camel@mediatek.com>
References: <20240412090851.24999-1-yunfei.dong@mediatek.com>
	 <20240412090851.24999-20-yunfei.dong@mediatek.com>
In-Reply-To: <20240412090851.24999-20-yunfei.dong@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OS8PR03MB8872:EE_
x-ms-office365-filtering-correlation-id: dbc390d3-e46d-421a-95fa-08dc5dd32704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?TUtBdEdZYXZXM015OUg4bndHQkhsOFNvVWtIOTRCQ3BwY1lHU2RNRURERG9D?=
 =?utf-8?B?R0ZFd3A2cWxMN3QzRXVBbEo0cS9FL3FSSnZWcU9kL3Z2dHEvUVZjbm9lTXJu?=
 =?utf-8?B?ZXJMdEs0WGRmeTc1OWg4eXR0Q2tFckkzSzFWTTVXb1l2L3ZqUkZuN0k2eXJM?=
 =?utf-8?B?ek5rcUpRSm0xYkZnZkJMTExVczc4K285bks2ei9aM3BOaDRoaG1URW8xTlhz?=
 =?utf-8?B?cGE0VGI0blRqV202Q3Q1M0JJbCsxRlZtMTFLbEpON0NxNGQ2R3AvdHJjTzlT?=
 =?utf-8?B?MUY2QjBrb0xLMGl5YWJuR24xMXB3QTdRTHNjYTJDTlBDM29xM01TL2xXSjRR?=
 =?utf-8?B?UHg5TkxCWXlNRkN0NG1TUjBwcFJHQWMrQjNkWTRMd3R2K3pRakVBUFN3Vmxo?=
 =?utf-8?B?eUxjM0RtdEJJTkhianQvTXpESWFkcFRPNCtpc25qZ1FYZU1SZWhKMC80a3pw?=
 =?utf-8?B?alZPdGNidnBDWFM1L1Jud2hpbG1KNk9SUlY2bFJEZWxxd2VVQXp3c0RuaFpR?=
 =?utf-8?B?UjJkaGw4L0s3a0x3aXlTcmdyUERWVFRwUW5PREFTWk14cFhvWE9ac0dnVEU1?=
 =?utf-8?B?b0xTcXJDVWlWSUFqbkZLNStGTnA0NDBqb3VTWGl5cjZJR3Fsek9PcGFPeTA3?=
 =?utf-8?B?dldMQWhFL1JwV1h3WTIzZlB5akRkSFcxS1c4ZU10TEdHUjFmUmFVZnREbk12?=
 =?utf-8?B?dnZyUFgxeCtqcjZkNUY5ckladlZJSTBmT3BoQnIwTUtQa2QyUXhWL2diMkxJ?=
 =?utf-8?B?bGpBeTIrRFFUNU9rVzg2ZFBjejJBbGhadzh3NEhsamdkRGF4ZEhYQXg3THZa?=
 =?utf-8?B?aXhZV1dqZGx5T2x5TFNPMHJDUmlFMHRoUFY2WTlHaFlyTHZ4U1hWM01CcGli?=
 =?utf-8?B?Nmg0MzQyTldLK0o4dnhrdExqR2JGMk5qeUwxSFhXNHhFYjhWK1hvMXgvZGwx?=
 =?utf-8?B?ODM3eUYxYkNaZWswcjAwZHo2SVp1cUw4ZXpSN2NWRzNvZTUxdkpKR2w3QkhZ?=
 =?utf-8?B?NHp4QTNsZTR4L05qMmJBVEJoWWJFZjJIUWZCYWZwTXk5SzF4ZzdHZVZ1cEM5?=
 =?utf-8?B?NUFUSVNOa0xLUVBiL3FvL1ppc0h4YnkrTmsvVHJGakN3OTUyTjhKZkhCTzR1?=
 =?utf-8?B?WkFVOG5yR0JKQnRpWm8zZ2MxVFVyek43czRFb1FsZWpnN2diaC9CUFlKdllN?=
 =?utf-8?B?bHByYmtHNWs0VHh3eFpGOFN4amp5WjJ4L0JSZ0tRblRnS3lrNWx5ZktQSWJp?=
 =?utf-8?B?eGNpQ3czdVllSnd1aTB6dFljd2tRdmtyZ0ZmQThDK01Kc0NLeXhMc1JHK1Rn?=
 =?utf-8?B?SnNmcCtCem01VHdGZ3R6Vzk3WmJLeERWdGhHRVd3eU9JY3ZteThVYWExTUNI?=
 =?utf-8?B?ajkwV1FFQW9PdEhsa2NVdzBzb1FzNEg4NlJJNFdZTGUxME5TVy9FQUZlV3NV?=
 =?utf-8?B?VktSV0YxWVZFTmZteEg3SFZHbEZFT04zVU0rcDZFNFBBblhlZUJYZk1hbTFs?=
 =?utf-8?B?WkIwbEhlR200cXloYy83eHNIM2xBYmwzUUE2SjZqcEVSYmQ3eEV1Nk1WZThj?=
 =?utf-8?B?U25ZNVB0NkZMdXh2UUxPTFBwQTRiTEEwMUh6L0VyZHdOZUh3M05zdmZtVkRQ?=
 =?utf-8?B?MHQ4a29FQklMMEIrZmpPR0VtMXFLV3FzN01rYWU5cGd1WGN3VUEzMDJLbXBE?=
 =?utf-8?B?WVJTTlZFS2FWNDVHWW1UTCt0OU1CYS9DWGNLU2RCUFFpcGpMQk94ZGJkU3ZE?=
 =?utf-8?B?NGN4U09LQUZXek5xNTBzbGVTNnZWL0NXU0Y5ZHJoSzFkQU4rSUg0M2JYZG91?=
 =?utf-8?Q?C+S9j8xKyqkyaPE8Ouj5K2L9Sw0uavMkKQ1pg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRlVDhBWThEbERPaTJ5cEw0dXNxNFkrYXEzUTMrRHpURyt2ektBVlA3ZXA2?=
 =?utf-8?B?ZnJMOFQ1RFhoeWhwQ3BONlpyTC9EU0tybUVqTUlLVEJYNSsxazM1VjlnTENm?=
 =?utf-8?B?M2thN1ZYRTJmcTJhVy80ZU5DRHNZYXpTdFRPajI4Zm55RmN4MGorZUMvWjFL?=
 =?utf-8?B?Q0pkK2cvNU5DSGkxNDdkZ3JkVTFnUXNKL1RhUnFDekVxemJibDFhWjU4ZXhx?=
 =?utf-8?B?dkdzMmRoTUlBaENNbnhhaE9zcWorODhMYnVsNUZNM0E3ZmNDR3c4RXRuakxj?=
 =?utf-8?B?Sk5oU0duTElvSldiNjdIMjRyYVNjSVBFakpJY201UjU5UmI3YnZIVXFtMEl1?=
 =?utf-8?B?K0xWejd1UU9ieVhVb1Z2OEsvTUdJckxYTUJYZ1lRRkMyUWg5Z3hJTmxLK3NM?=
 =?utf-8?B?MWZ4WDN0OHVvRks0Q1B1cGJVQ1hZVWxlSzNDSFBOS3B0U0JTdXFsajAzRkJV?=
 =?utf-8?B?NDlxVVFYTmhLU2FycUx2QU1HemExT1lkazRsemgvNGVLYUR2eTY4OXZZaUJ6?=
 =?utf-8?B?K1hKY0NlRnZocGQzbS93aytEOGRHZm9BOXV2a3lTUjJJdlhTb1FaS013M1Rp?=
 =?utf-8?B?NUUxa3prVmwxR3hIT0drVUJoVm90WHJ4KzlSeitHWDhzd1ZNckNrcURZSVJP?=
 =?utf-8?B?Z1d4Y1BjQTlrSkhWT1RzTkFvVElzajZRQWNsU1g3TENvU2JxM25PTUppNStX?=
 =?utf-8?B?UWxyUXhJTUo0SU9QVzhCSFQ1ZDVJYTNJb09semQxRCtWNFd3M3FHMythOVUv?=
 =?utf-8?B?MFFpTFB1N2t4d3FrN0g2SVYzdlkwam04RkxTSG5aZTM3MC9XNGY0YnlhRzBt?=
 =?utf-8?B?REcrYlZCY25uVm9rZS9LemZpTmsvVXFyTC9FRFRPV3RZM0RBZGNZM24rMS9m?=
 =?utf-8?B?T1pOeFBxODBKdlhmd3BWd2RSYUtvRWtDRG1GMGdTZkpvVnNwTnJlMmFmZjRM?=
 =?utf-8?B?UklrS0k1SnZVakVQbDR4QmMyZTY1N1VvbGhUTkxDUVp3UHBkUFBQekl3ZWZn?=
 =?utf-8?B?WjNIcGF2Vmtmbi84L2xvS3hIbmd6SjErclU1U2kvcVVuSXR0bnVxOFdNQjR2?=
 =?utf-8?B?ekRqeHN6eXk0MVUyQU16dDI3d05TbTVqNjJDRHBlVnUvSU41OG9nVDlXNlJu?=
 =?utf-8?B?SDRnRXVhd2hjazVYQnhZM3B1QVlJQUZNYmRqUjhqRENwSmhWcEduTWZFNVF1?=
 =?utf-8?B?NWlpMmUxbzRrY01mcTJsaWxWNXAxeGNsRS9iak1BRlAzSWdlYXVBcVR1b1hi?=
 =?utf-8?B?VitjZW5CVkVFaG9RVy80eGJ2b3BSOGFHa0xwVkVrRmRYYnFlYS9uRjRyWkZ3?=
 =?utf-8?B?eWpmWENiM0dJbm8xeGV1dm8xUVoyNVlTeWR1T3I3NWROZ1ZMTVBnM2xzdEFT?=
 =?utf-8?B?ZWFCa0tYY2RPZk9aZjNjTHl6YUlNa0pyZ0thTVpMWTBGSnBvTkY5U0FJYnV2?=
 =?utf-8?B?OUJEeEpZNTB2V3Zubkw1NlRpY0Vmay9MNlVNVzJIWllRY2F3ZjJMUlF6U1hz?=
 =?utf-8?B?Zk9uT1ZEQ2JjQ21mZU96eEJLVTI3Y1ZsZ05qRElHL282bGVJNlRMcGhucTRK?=
 =?utf-8?B?a2FsR1JMaGF5RHEvMWc1d0IxRS92cTluUmd3WVhCME42TXJ3SnJPT2ordld4?=
 =?utf-8?B?aC8rSHZuVUNid0MrdTlrbzkxeDVldk9IdkFERnBkWmFvdzNLRUJETEU0b045?=
 =?utf-8?B?RFVDSVc4MEFtR1ZKL3NsZWZmTkpnNWIwMXlydWtkb0tSdy9wcTF2alM2dHBZ?=
 =?utf-8?B?VFNpWmN0dFlzUHVhM1E1M0JpUDFEQkdyK3ZBVDNyeDVuZE1mcVVjZDd4TjZu?=
 =?utf-8?B?a2JKQlVWZ2gzMGRDYjd0QTNCRk1GWEVWeUNCWjFPaEY0M011bG5mdGNwRytR?=
 =?utf-8?B?U2tPRGVRN040UjBNa1h5N1oralEzZVJkVjNvZEp1V0JEanZ6a0tZUXF5MEY4?=
 =?utf-8?B?Yy9PSFIwMlo5RkVqL2tSNFZ6OXEzMzlaYzNjMnJ6YUhnd0VRS2tqa3ExVkUz?=
 =?utf-8?B?SmFXYnRvdUNEM2lMK3ZqSWpUdGhNWGc2SW1VUXl6R21RK2hXY08wN2dFTkRR?=
 =?utf-8?B?SXRKR1ZYVlhjdVV4R3NlU1JtcVpsZDlEcXI3UUFHcjZLMnU4UnVUUWROaDRq?=
 =?utf-8?Q?Jz02XHwXyaJlzHHlao4JKF47z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBA385D8F8245441B38A0DA8248C50D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc390d3-e46d-421a-95fa-08dc5dd32704
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:07:45.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GQSLP0h0S65KhN8brQ4bF6YVt0ms/j11ilMaMAUdeMS09pcTeEYNwoYlUBSNYBmhlpSAUMAjmyK0Earp7uMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8872
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.113400-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0OwH4pD14DsPHkpkyUphL9WjWsWQUWzVpfXk0kfCOnbnXd
	7xOm1pHBXHyP7irhZDOEVRl07FlKfSY0eULsNBXl4pdq9sdj8LX+So7bFipflt9zZd3pUn7Kojp
	CsYWLx+o+Z7QwZhMSMddpu+Np5N2NZ0UbqdNQrsvyWnRbNAHEdpnaxzJFBx6vEvoxTu3fj1trbJ
	sfhkTsdd08QNdJNlWITm1bSZyr4Hy5rzEqaXlmzVPjo7D4SFg4IpFOMUBYG+6nitih609znGtCB
	JGDrKJFkEzGtB3bnG4Dmpu0GuIWwdCjuUhsbmmkzfqlpbtmcWh9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8VgXepbcl7r7wVLosKlezoOCdqh3WKPC+C8TgQXkRRemCLZnsa7HQ0COAWG
	LnzsPmZ+Bf5+7o83YJElSGR5+0W6TyV0KfP0NMrPM+YDMu87c/A2ADMXzXXrE3GUQUNzkZce0wE
	/+NfLZ+HRQzE03arZUYyGHon+Jun7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.113400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DB9188A177B16B48D866596D346A64E1B8A6667D649C7002D9BD240C21A742E12000:8

SGksIFl1bmZlaToNCg0KT24gRnJpLCAyMDI0LTA0LTEyIGF0IDE3OjA4ICswODAwLCBZdW5mZWkg
RG9uZyB3cm90ZToNCj4gV2FpdGluZyBpbnRlcnJ1cHQgaW4gb3B0ZWUtb3MgZm9yIHN2cCBtb2Rl
LCBuZWVkIHRvIGRpc2FibGUgaXQgaW4NCj4ga2VybmVsDQo+IGluIGNhc2Ugb2YgaW50ZXJydXB0
IGlzIGNsZWFuZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRv
bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVj
X2RlY19ody5jICAgICAgICB8IDM0ICsrKysrLS0tLS0tDQo+ICAuLi4vdmNvZGVjL2RlY29kZXIv
bXRrX3Zjb2RlY19kZWNfcG0uYyAgICAgICAgfCAgNiArLQ0KPiAgLi4uL2RlY29kZXIvdmRlYy92
ZGVjX2gyNjRfcmVxX211bHRpX2lmLmMgICAgIHwgNTcgKysrKysrKysrKystLS0tDQo+IC0tLS0N
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29k
ZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19ody5jDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19ody5jDQo+IGluZGV4IDg4
MWQ1ZGU0MWUwNS4uMTk4MmMwODhjNmRhIDEwMDY0NA0KPiAtLS0NCj4gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX2h3LmMNCj4g
KysrDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9t
dGtfdmNvZGVjX2RlY19ody5jDQo+IEBAIC03MiwyNiArNzIsMjggQEAgc3RhdGljIGlycXJldHVy
bl90IG10a192ZGVjX2h3X2lycV9oYW5kbGVyKGludA0KPiBpcnEsIHZvaWQgKnByaXYpDQo+ICAN
Cj4gIAljdHggPSBtdGtfdmNvZGVjX2dldF9jdXJyX2N0eChkZXYtPm1haW5fZGV2LCBkZXYtPmh3
X2lkeCk7DQo+ICANCj4gLQkvKiBjaGVjayBpZiBIVyBhY3RpdmUgb3Igbm90ICovDQo+IC0JY2df
c3RhdHVzID0gcmVhZGwoZGV2LT5yZWdfYmFzZVtWREVDX0hXX1NZU10gKw0KPiBWREVDX0hXX0FD
VElWRV9BRERSKTsNCj4gLQlpZiAoY2dfc3RhdHVzICYgVkRFQ19IV19BQ1RJVkVfTUFTSykgew0K
PiAtCQltdGtfdjRsMl92ZGVjX2VycihjdHgsICJ2ZGVjIGFjdGl2ZSBpcyBub3QgMHgwDQo+ICgw
eCUwOHgpIiwgY2dfc3RhdHVzKTsNCj4gLQkJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiAtCX0NCj4g
KwlpZiAoIWN0eC0+aXNfc2VjdXJlX3BsYXliYWNrKSB7DQo+ICsJCS8qIGNoZWNrIGlmIEhXIGFj
dGl2ZSBvciBub3QgKi8NCj4gKwkJY2dfc3RhdHVzID0gcmVhZGwoZGV2LT5yZWdfYmFzZVtWREVD
X0hXX1NZU10gKw0KPiBWREVDX0hXX0FDVElWRV9BRERSKTsNCj4gKwkJaWYgKGNnX3N0YXR1cyAm
IFZERUNfSFdfQUNUSVZFX01BU0spIHsNCj4gKwkJCW10a192NGwyX3ZkZWNfZXJyKGN0eCwgInZk
ZWMgYWN0aXZlIGlzIG5vdCAweDANCj4gKDB4JTA4eCkiLCBjZ19zdGF0dXMpOw0KPiArCQkJcmV0
dXJuIElSUV9IQU5ETEVEOw0KPiArCQl9DQo+ICANCj4gLQlkZWNfZG9uZV9zdGF0dXMgPSByZWFk
bCh2ZGVjX21pc2NfYWRkcik7DQo+IC0JaWYgKChkZWNfZG9uZV9zdGF0dXMgJiBNVEtfVkRFQ19J
UlFfU1RBVFVTX0RFQ19TVUNDRVNTKSAhPQ0KPiAtCSAgICBNVEtfVkRFQ19JUlFfU1RBVFVTX0RF
Q19TVUNDRVNTKQ0KPiAtCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICsJCWRlY19kb25lX3N0YXR1
cyA9IHJlYWRsKHZkZWNfbWlzY19hZGRyKTsNCj4gKwkJaWYgKChkZWNfZG9uZV9zdGF0dXMgJiBN
VEtfVkRFQ19JUlFfU1RBVFVTX0RFQ19TVUNDRVNTKQ0KPiAhPQ0KPiArCQkgICAgTVRLX1ZERUNf
SVJRX1NUQVRVU19ERUNfU1VDQ0VTUykNCj4gKwkJCXJldHVybiBJUlFfSEFORExFRDsNCj4gIA0K
PiAtCS8qIGNsZWFyIGludGVycnVwdCAqLw0KPiAtCXdyaXRlbChkZWNfZG9uZV9zdGF0dXMgfCBW
REVDX0lSUV9DRkcsIHZkZWNfbWlzY19hZGRyKTsNCj4gLQl3cml0ZWwoZGVjX2RvbmVfc3RhdHVz
ICYgflZERUNfSVJRX0NMUiwgdmRlY19taXNjX2FkZHIpOw0KPiArCQkvKiBjbGVhciBpbnRlcnJ1
cHQgKi8NCj4gKwkJd3JpdGVsKGRlY19kb25lX3N0YXR1cyB8IFZERUNfSVJRX0NGRywgdmRlY19t
aXNjX2FkZHIpOw0KPiArCQl3cml0ZWwoZGVjX2RvbmVfc3RhdHVzICYgflZERUNfSVJRX0NMUiwN
Cj4gdmRlY19taXNjX2FkZHIpOw0KPiAgDQo+IC0Jd2FrZV91cF9kZWNfY3R4KGN0eCwgTVRLX0lO
U1RfSVJRX1JFQ0VJVkVELCBkZXYtPmh3X2lkeCk7DQo+ICsJCXdha2VfdXBfZGVjX2N0eChjdHgs
IE1US19JTlNUX0lSUV9SRUNFSVZFRCwgZGV2LQ0KPiA+aHdfaWR4KTsNCj4gIA0KPiAtCW10a192
NGwyX3ZkZWNfZGJnKDMsIGN0eCwgIndha2UgdXAgY3R4ICVkLCBkZWNfZG9uZV9zdGF0dXM9JXgi
LA0KPiAtCQkJICBjdHgtPmlkLCBkZWNfZG9uZV9zdGF0dXMpOw0KPiArCQltdGtfdjRsMl92ZGVj
X2RiZygzLCBjdHgsICJ3YWtlIHVwIGN0eCAlZCwNCj4gZGVjX2RvbmVfc3RhdHVzPSV4IiwNCj4g
KwkJCQkgIGN0eC0+aWQsIGRlY19kb25lX3N0YXR1cyk7DQo+ICsJfQ0KPiAgDQo+ICAJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19wbS5jDQo+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2Rl
Y19wbS5jDQo+IGluZGV4IGFlZmQzZTllMzA2MS4uYTk0ZWRhOTM2ZjE2IDEwMDY0NA0KPiAtLS0N
Cj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192
Y29kZWNfZGVjX3BtLmMNCj4gKysrDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19wbS5jDQo+IEBAIC0yMzgsNyArMjM4LDgg
QEAgdm9pZCBtdGtfdmNvZGVjX2RlY19lbmFibGVfaGFyZHdhcmUoc3RydWN0DQo+IG10a192Y29k
ZWNfZGVjX2N0eCAqY3R4LCBpbnQgaHdfaWR4KQ0KPiAgCQltdGtfdmNvZGVjX2RlY19jaGlsZF9k
ZXZfb24oY3R4LT5kZXYsIE1US19WREVDX0xBVDApOw0KPiAgCW10a192Y29kZWNfZGVjX2NoaWxk
X2Rldl9vbihjdHgtPmRldiwgaHdfaWR4KTsNCj4gIA0KPiAtCW10a192Y29kZWNfZGVjX2VuYWJs
ZV9pcnEoY3R4LT5kZXYsIGh3X2lkeCk7DQo+ICsJaWYgKCFjdHgtPmlzX3NlY3VyZV9wbGF5YmFj
aykNCj4gKwkJbXRrX3Zjb2RlY19kZWNfZW5hYmxlX2lycShjdHgtPmRldiwgaHdfaWR4KTsNCj4g
IA0KPiAgCWlmIChJU19WREVDX0lOTkVSX1JBQ0lORyhjdHgtPmRldi0+ZGVjX2NhcGFiaWxpdHkp
KQ0KPiAgCQltdGtfdmNvZGVjX2xvYWRfcmFjaW5nX2luZm8oY3R4KTsNCj4gQEAgLTI1MCw3ICsy
NTEsOCBAQCB2b2lkIG10a192Y29kZWNfZGVjX2Rpc2FibGVfaGFyZHdhcmUoc3RydWN0DQo+IG10
a192Y29kZWNfZGVjX2N0eCAqY3R4LCBpbnQgaHdfaWR4KQ0KPiAgCWlmIChJU19WREVDX0lOTkVS
X1JBQ0lORyhjdHgtPmRldi0+ZGVjX2NhcGFiaWxpdHkpKQ0KPiAgCQltdGtfdmNvZGVjX3JlY29y
ZF9yYWNpbmdfaW5mbyhjdHgpOw0KPiAgDQo+IC0JbXRrX3Zjb2RlY19kZWNfZGlzYWJsZV9pcnEo
Y3R4LT5kZXYsIGh3X2lkeCk7DQo+ICsJaWYgKCFjdHgtPmlzX3NlY3VyZV9wbGF5YmFjaykNCj4g
KwkJbXRrX3Zjb2RlY19kZWNfZGlzYWJsZV9pcnEoY3R4LT5kZXYsIGh3X2lkeCk7DQo+ICANCj4g
IAltdGtfdmNvZGVjX2RlY19jaGlsZF9kZXZfb2ZmKGN0eC0+ZGV2LCBod19pZHgpOw0KPiAgCWlm
IChJU19WREVDX0xBVF9BUkNIKGN0eC0+ZGV2LT52ZGVjX3BkYXRhLT5od19hcmNoKSAmJg0KPiBk
aWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVj
b2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXFfbQ0KPiB1bHRpX2lmLmMNCj4gYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY19oMjY0X3JlcV9tDQo+
IHVsdGlfaWYuYw0KPiBpbmRleCBmMjdkMzI2ZjAwYmEuLjMxODY3NzdkY2MxMyAxMDA2NDQNCj4g
LS0tDQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92
ZGVjL3ZkZWNfaDI2NF9yZXFfbQ0KPiB1bHRpX2lmLmMNCj4gKysrDQo+IGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXFfbQ0K
PiB1bHRpX2lmLmMNCj4gQEAgLTU5MywxNCArNTkzLDE2IEBAIHN0YXRpYyBpbnQgdmRlY19oMjY0
X3NsaWNlX2NvcmVfZGVjb2RlKHN0cnVjdA0KPiB2ZGVjX2xhdF9idWYgKmxhdF9idWYpDQo+ICAJ
CWdvdG8gdmRlY19kZWNfZW5kOw0KPiAgCX0NCj4gIA0KPiAtCS8qIHdhaXQgZGVjb2RlciBkb25l
IGludGVycnVwdCAqLw0KPiAtCXRpbWVvdXQgPSBtdGtfdmNvZGVjX3dhaXRfZm9yX2RvbmVfY3R4
KGluc3QtPmN0eCwNCj4gTVRLX0lOU1RfSVJRX1JFQ0VJVkVELA0KPiAtCQkJCQkgICAgICAgV0FJ
VF9JTlRSX1RJTUVPVVRfTVMsDQo+IE1US19WREVDX0NPUkUpOw0KPiAtCWlmICh0aW1lb3V0KQ0K
PiAtCQltdGtfdmRlY19lcnIoY3R4LCAiY29yZSBkZWNvZGUgdGltZW91dDogcGljXyVkIiwgY3R4
LQ0KPiA+ZGVjb2RlZF9mcmFtZV9jbnQpOw0KPiAtCWluc3QtPnZzaV9jb3JlLT5kZWMudGltZW91
dCA9ICEhdGltZW91dDsNCj4gLQ0KPiAtCXZwdV9kZWNfY29yZV9lbmQodnB1KTsNCj4gKwlpZiAo
IWN0eC0+aXNfc2VjdXJlX3BsYXliYWNrKSB7DQo+ICsJCS8qIHdhaXQgZGVjb2RlciBkb25lIGlu
dGVycnVwdCAqLw0KPiArCQl0aW1lb3V0ID0gbXRrX3Zjb2RlY193YWl0X2Zvcl9kb25lX2N0eChp
bnN0LT5jdHgsDQo+IE1US19JTlNUX0lSUV9SRUNFSVZFRCwNCj4gKwkJCQkJCSAgICAgICBXQUlU
X0lOVFJfVElNRU9VDQo+IFRfTVMsIE1US19WREVDX0NPUkUpOw0KPiArCQlpZiAodGltZW91dCkN
Cj4gKwkJCW10a192ZGVjX2VycihjdHgsICJjb3JlIGRlY29kZSB0aW1lb3V0Og0KPiBwaWNfJWQi
LCBjdHgtPmRlY29kZWRfZnJhbWVfY250KTsNCj4gKwkJaW5zdC0+dnNpX2NvcmUtPmRlYy50aW1l
b3V0ID0gISF0aW1lb3V0Ow0KPiArDQo+ICsJCXZwdV9kZWNfY29yZV9lbmQodnB1KTsNCj4gKwl9
DQoNCkluIHN2cCBtb2RlLCBvcHRlZSBkcml2ZXIgd291bGQgd2FpdCB0aGUgaXJxLCBidXQgd2h5
IG9wdGVlIGRyaXZlciBkb2VzDQpub3Qgbm90aWZ5IG5vcm1hbCB3b3JsZCBkcml2ZXI/IFRoZSBu
b3JtYWwgd29ybGQgZHJpdmVyIGhlcmUgZG9lcyBub3QNCndhaXQgYW55dGhpbmcgYW5kIGtlZXAg
Z29pbmcsIHNvIGl0IHdvdWxkIGdldCB0aGUgZnJhbWUgd2hpY2ggaGFzIG5vdA0KYmVlbiBwcm9j
ZXNzZWQgZG9uZSBhbmQgcGFzcyBpdCB0byBuZXh0IG1vZHVsZSBzdWNoIGFzIG1kcD8gVGhlIG5v
cm1hbA0Kd29ybGQgZHJpdmVyIGRvZXMgbm90IHdhaXQgaGVyZSwgaG93IGRvZXMgaXQgbWFrZSBz
dXJlIHRoZSBmcmFtZSBpcw0KcHJvY2Vzc2VkIGRvbmU/DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJ
bXRrX3ZkZWNfZGVidWcoY3R4LCAicGljWyVkXSBjcmM6IDB4JXggMHgleCAweCV4IDB4JXggMHgl
eCAweCV4DQo+IDB4JXggMHgleCIsDQo+ICAJCSAgICAgICBjdHgtPmRlY29kZWRfZnJhbWVfY250
LA0KPiAgCQkgICAgICAgaW5zdC0+dnNpX2NvcmUtPmRlYy5jcmNbMF0sIGluc3QtPnZzaV9jb3Jl
LQ0KPiA+ZGVjLmNyY1sxXSwNCj4gQEAgLTcyNCwxNCArNzI2LDE2IEBAIHN0YXRpYyBpbnQgdmRl
Y19oMjY0X3NsaWNlX2xhdF9kZWNvZGUodm9pZA0KPiAqaF92ZGVjLCBzdHJ1Y3QgbXRrX3Zjb2Rl
Y19tZW0gKmJzLA0KPiAgCQl2ZGVjX21zZ19xdWV1ZV9xYnVmKCZpbnN0LT5jdHgtPm1zZ19xdWV1
ZS5jb3JlX2N0eCwNCj4gbGF0X2J1Zik7DQo+ICAJfQ0KPiAgDQo+IC0JLyogd2FpdCBkZWNvZGVy
IGRvbmUgaW50ZXJydXB0ICovDQo+IC0JdGltZW91dCA9IG10a192Y29kZWNfd2FpdF9mb3JfZG9u
ZV9jdHgoaW5zdC0+Y3R4LA0KPiBNVEtfSU5TVF9JUlFfUkVDRUlWRUQsDQo+IC0JCQkJCSAgICAg
ICBXQUlUX0lOVFJfVElNRU9VVF9NUywNCj4gTVRLX1ZERUNfTEFUMCk7DQo+IC0JaWYgKHRpbWVv
dXQpDQo+IC0JCW10a192ZGVjX2VycihpbnN0LT5jdHgsICJsYXQgZGVjb2RlIHRpbWVvdXQ6IHBp
Y18lZCIsDQo+IGluc3QtPnNsaWNlX2RlY19udW0pOw0KPiAtCWluc3QtPnZzaS0+ZGVjLnRpbWVv
dXQgPSAhIXRpbWVvdXQ7DQo+ICsJaWYgKCFpbnN0LT5jdHgtPmlzX3NlY3VyZV9wbGF5YmFjaykg
ew0KPiArCQkvKiB3YWl0IGRlY29kZXIgZG9uZSBpbnRlcnJ1cHQgKi8NCj4gKwkJdGltZW91dCA9
IG10a192Y29kZWNfd2FpdF9mb3JfZG9uZV9jdHgoaW5zdC0+Y3R4LA0KPiBNVEtfSU5TVF9JUlFf
UkVDRUlWRUQsDQo+ICsJCQkJCQkgICAgICAgV0FJVF9JTlRSX1RJTUVPVQ0KPiBUX01TLCBNVEtf
VkRFQ19MQVQwKTsNCj4gKwkJaWYgKHRpbWVvdXQpDQo+ICsJCQltdGtfdmRlY19lcnIoaW5zdC0+
Y3R4LCAibGF0IGRlY29kZSB0aW1lb3V0Og0KPiBwaWNfJWQiLCBpbnN0LT5zbGljZV9kZWNfbnVt
KTsNCj4gKwkJaW5zdC0+dnNpLT5kZWMudGltZW91dCA9ICEhdGltZW91dDsNCj4gIA0KPiAtCWVy
ciA9IHZwdV9kZWNfZW5kKHZwdSk7DQo+ICsJCWVyciA9IHZwdV9kZWNfZW5kKHZwdSk7DQo+ICsJ
fQ0KPiAgCWlmIChlcnIgPT0gU0xJQ0VfSEVBREVSX0ZVTEwgfHwgZXJyID09IFRSQU5TX0JVRkZF
Ul9GVUxMKSB7DQo+ICAJCWlmICghSVNfVkRFQ19JTk5FUl9SQUNJTkcoaW5zdC0+Y3R4LT5kZXYt
DQo+ID5kZWNfY2FwYWJpbGl0eSkpDQo+ICAJCQl2ZGVjX21zZ19xdWV1ZV9xYnVmKCZpbnN0LT5j
dHgtDQo+ID5tc2dfcXVldWUubGF0X2N0eCwgbGF0X2J1Zik7DQo+IEBAIC04MzEsMTYgKzgzNSwx
OSBAQCBzdGF0aWMgaW50IHZkZWNfaDI2NF9zbGljZV9zaW5nbGVfZGVjb2RlKHZvaWQNCj4gKmhf
dmRlYywgc3RydWN0IG10a192Y29kZWNfbWVtICpicw0KPiAgCWlmIChlcnIpDQo+ICAJCWdvdG8g
ZXJyX2ZyZWVfZmJfb3V0Ow0KPiAgDQo+IC0JLyogd2FpdCBkZWNvZGVyIGRvbmUgaW50ZXJydXB0
ICovDQo+IC0JZXJyID0gbXRrX3Zjb2RlY193YWl0X2Zvcl9kb25lX2N0eChpbnN0LT5jdHgsDQo+
IE1US19JTlNUX0lSUV9SRUNFSVZFRCwNCj4gLQkJCQkJICAgV0FJVF9JTlRSX1RJTUVPVVRfTVMs
DQo+IE1US19WREVDX0NPUkUpOw0KPiAtCWlmIChlcnIpDQo+IC0JCW10a192ZGVjX2VycihpbnN0
LT5jdHgsICJkZWNvZGUgdGltZW91dDogcGljXyVkIiwgaW5zdC0NCj4gPmN0eC0+ZGVjb2RlZF9m
cmFtZV9jbnQpOw0KPiAtDQo+IC0JaW5zdC0+dnNpLT5kZWMudGltZW91dCA9ICEhZXJyOw0KPiAt
CWVyciA9IHZwdV9kZWNfZW5kKHZwdSk7DQo+IC0JaWYgKGVycikNCj4gLQkJZ290byBlcnJfZnJl
ZV9mYl9vdXQ7DQo+ICsJaWYgKCFpbnN0LT5jdHgtPmlzX3NlY3VyZV9wbGF5YmFjaykgew0KPiAr
CQkvKiB3YWl0IGRlY29kZXIgZG9uZSBpbnRlcnJ1cHQgKi8NCj4gKwkJZXJyID0gbXRrX3Zjb2Rl
Y193YWl0X2Zvcl9kb25lX2N0eChpbnN0LT5jdHgsDQo+IE1US19JTlNUX0lSUV9SRUNFSVZFRCwN
Cj4gKwkJCQkJCSAgIFdBSVRfSU5UUl9USU1FT1VUX01TDQo+ICwgTVRLX1ZERUNfQ09SRSk7DQo+
ICsJCWlmIChlcnIpDQo+ICsJCQltdGtfdmRlY19lcnIoaW5zdC0+Y3R4LCAiZGVjb2RlIHRpbWVv
dXQ6DQo+IHBpY18lZCIsDQo+ICsJCQkJICAgICBpbnN0LT5jdHgtPmRlY29kZWRfZnJhbWVfY250
KTsNCj4gKw0KPiArCQlpbnN0LT52c2ktPmRlYy50aW1lb3V0ID0gISFlcnI7DQo+ICsJCWVyciA9
IHZwdV9kZWNfZW5kKHZwdSk7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlnb3RvIGVycl9mcmVlX2Zi
X291dDsNCj4gKwl9DQo+ICANCj4gIAltZW1jcHkoJmluc3QtPnZzaV9jdHgsIGluc3QtPnZwdS52
c2ksIHNpemVvZihpbnN0LT52c2lfY3R4KSk7DQo+ICAJbXRrX3ZkZWNfZGVidWcoaW5zdC0+Y3R4
LCAicGljWyVkXSBjcmM6IDB4JXggMHgleCAweCV4IDB4JXgNCj4gMHgleCAweCV4IDB4JXggMHgl
eCIsDQo=

