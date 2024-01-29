Return-Path: <linux-kernel+bounces-42096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0651F83FC42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F11C2155A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1044101C4;
	Mon, 29 Jan 2024 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XhQQpMwO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B6FC0C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495579; cv=fail; b=sStCM/59w/WD3vR+P07bGtgKzfPTA97EmrYbgvk6HgZS0BEyV2LgAbuQgOanqWnaGx0jf8eRvd9Wg1tjT7t1bx1TeoUw/xTnCZKymzR5ZIUSRApKhqDV6Y3yZIOM/s+/gVX9dLR3WgA3NVey78IW5sPvZlCwicEveLVNreudT+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495579; c=relaxed/simple;
	bh=vveXNnuLp9DPsj39CLAo+wCW3/rtRNo+2NXUKfTF3yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pj7Wy522zpmPp4BXbyscP0kzXDjpXqQyAwmkw/c5Xuq5WsChe+IOd4uLUPzqgTAu+eNY9+RYJVIg1xH85jh9oV8JXcZce9OC4JEY3UMCQaY+F7xk6PmjyYTnzCHHmeEYv6jkgWfDf9qqLtKOF9qsqlkReLXTnwYu21lcwV3HJhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XhQQpMwO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b2dd9f50be4e11eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vveXNnuLp9DPsj39CLAo+wCW3/rtRNo+2NXUKfTF3yw=;
	b=XhQQpMwO2GrrAKZVUrnk4UPQwv5kpSISJQEg8OnUCe3twaYmrmLIPUhl0fl9OQjTeR7mSnKSdX7qgny9aHSgjR8cEaFVIzichleeLS5iZXj67B6Hkp4tci2F65f8rX7TpXCdaTDKFdA0wdRJ70cGB1LRNVytPbPAwVg/mVSCjIY=;
X-CID-CACHE: Type:Local,Time:202401291017+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:f3d90c01-62c7-4c73-a9a9-929ae857450c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:cfff5983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b2dd9f50be4e11eea2298b7352fd921d-20240129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1918628090; Mon, 29 Jan 2024 10:32:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 10:32:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 10:32:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvOArMTMkFd6I1TAaYsNXDIjcVDGI4QT45wEHzuGWiw54rh6FqdqmjFt1Qw/8brsGFYnCImeg88KfbtXEYRABStFrpk3aP+PzUgdZAfzO+oVPjaTDtPXhXC2chCrnO8PzCPmVvuUwX/HtfDpQnvsmasThBwkz84RsSq5XXExi2A3lGOzf1PMAGvqOkjdQ/jo2YeDEQPg9+XHSjO1gxZg3yOIsHkcXhSmX9NxmFkOep8OM3FQGK4rtstRvkJ7bLITeQuYcHXbRmwOLsXjZkh2uLZPYIYMGyNXy4b8whn6GN7RA1dziAjw2YDQhi0t5j/DExNbqrjMrkam2k7kfBsqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vveXNnuLp9DPsj39CLAo+wCW3/rtRNo+2NXUKfTF3yw=;
 b=Z+KF3Wp3PEnJF+59QfgxBAbLk7kOfPrVRYUbwLmpw7TRaJQ9b7xWy+vBw4XaEaNSwOw9XZUZgHi/kMzf3vKCzMO4v+rL3d5xX1jUpUNuz7I7FHt/5YZoLlA1BdC9neGUs2RF/0SqgrOFsk39K/4oICU1M26qb/GMsvuJ+2sb6HtvUAeovn/bOSX/AyO3duBTuU2I9QgCskmzAAPUlCkqN+9CcMZB/YD85iMNZ5K6WaVQtdJH4Jd4lWjnjXCYyUzTPUjmT2D6hliQaJGOMninXZtd++JC8gGm8enNMKK2isneG04bwmyUmgRmbjMC9fCOyOMA2rrWtRiAUU+fIb8qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com (2603:1096:405:95::8)
 by TYSPR03MB7707.apcprd03.prod.outlook.com (2603:1096:400:410::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Mon, 29 Jan
 2024 02:32:46 +0000
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::7b:b3b1:29a3:b67]) by TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::7b:b3b1:29a3:b67%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:32:46 +0000
From: =?utf-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
To: "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
	"jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "sumit.garg@linaro.org"
	<sumit.garg@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] optee: support wq_sleep_timeout
Thread-Topic: [PATCH] optee: support wq_sleep_timeout
Thread-Index: AQHaT09C8Fo0yXViLEeu2D+3mVonELDqSCAAgAXQI4A=
Date: Mon, 29 Jan 2024 02:32:46 +0000
Message-ID: <0e9e3ec2079c1a9ac49ea1b93370a48b8e4a78cc.camel@mediatek.com>
References: <20240125052744.18866-1-gavin.liu@mediatek.com>
	 <d33bad27-da65-4866-96e7-a249824fcb6e@linaro.org>
In-Reply-To: <d33bad27-da65-4866-96e7-a249824fcb6e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8836:EE_|TYSPR03MB7707:EE_
x-ms-office365-filtering-correlation-id: 68f60e79-0a26-4903-55fd-08dc207293fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3lrxXPLqCoFKjTPbubmSRGbK+PIhW6HctGSV+wancTvjOfedmkznImimnqWm0HG6Wmr3d0ZO8OHPoiLXtej6nVKAENc3yUa8ZQTGKCP7aVANyU57ZFU23/aov9YIbagH69fTeuayhaoUvYqATv8TJnomo0YNvtwZO2jT5NIqtoDzc9B2o35bbMfasy6DvYTbiT8ff3fYLGSuBWxkWBNHFjGEptdJ5l4pt0SnZWMAymaQNRhUSEaEVtxgzn7gzJ1aDR8E84npFfiDgUxJ/QmvOMV8NuBSAAlQDOLZZ3VsYY73qLs+1LyrAtfVoovsPZKO+5nPC9RfeLzLMnM/7Hs1IWgHOdcXf/vnDvtH7r2URNP0OzMw8Qfe7Oo3mlz+8HESTSwTIMiDKUmJFWtX9vkbj8rITIh8nXGja8FnJd+9wmtO8WgpuAiSSMTqnBQIx2klxzJ25IJS5clQlVvBmIzhnmxKbI5O1gIBM+GOwboBWbxRR9Lrpoijyr6v7jo7VLI7kY44BG1P5PvK5tOp1XD5ywETnp+cltXG5ApLooOxkMDXg/M7/Oy6OBmaRiSYPXbiSXj3+uQdVKUlHo7Iux4tliCdf5ajckJG08oufr6V/MXnnx7/UqIiCjoN66Bq+jxvwJnC7FTOWuuNQ7E0tEQv5nblOeCFkuJOAVjpczOVcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8836.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(8936002)(8676002)(4326008)(2906002)(5660300002)(86362001)(110136005)(76116006)(66946007)(66476007)(64756008)(54906003)(316002)(38070700009)(36756003)(85182001)(66446008)(38100700002)(122000001)(53546011)(6506007)(6512007)(478600001)(6486002)(83380400001)(71200400001)(26005)(2616005)(107886003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0s4ZVAyaVVLSVI2VzZzdGFheFhqdUxNRkFEdGFXdk5YTms0VWdlSGIzZG5p?=
 =?utf-8?B?ZE8xeTFUSXFzYk5rSndNU3hIb2ZWekVYR1ZaMndQcjNZV0FxVXJsNW52WWlW?=
 =?utf-8?B?Y3NuNTNvSXZ3S1VZM0FTcWV4UHNwNGF5aDkzRUE0NWUrNFBRcFcxSlZDN1Nm?=
 =?utf-8?B?bmpSL3R3M0xEOVB6YXNLZWRSVy8wcWExQ3dOaHVya0JTWXJROHcrc3BVSExm?=
 =?utf-8?B?NUtSVEkvQVBmSTFKL0hFbTd6RHRFYTRBRk9qaCtJRVM5UDN5dkZXMFhUWjJW?=
 =?utf-8?B?WWhKV0g1WFMvZWRHWGEyNjNGdWxpbFBicVhxUTlBdlJOdzN6VFVHQmdwVEdH?=
 =?utf-8?B?eUxOS0FNSENsbkFzVDZSUEdjN1ltdW5FOGdnVWQwVzNUVFllcFdNU0hVK3dJ?=
 =?utf-8?B?YTk3TTcwSTlxazVjVGJwSlZhdjQxV29MOWpqR08xOXhwQ0hsWlRlcTNJUEJs?=
 =?utf-8?B?b1FiU0oyU3IveVFiUlIyNWFBdkdYTXRyY04xLzFoRHFrZ3d4SzExazR6SWRU?=
 =?utf-8?B?UFc4TGwzdDd3Q1NwdTRIVFZoUHdSU0VLSGt0dTRqdFZhSlhGaGcycC94RkdT?=
 =?utf-8?B?WHQ0MVVONHZPS3k5dHBBdWhQZ2d2dVBGV2ZReG5yL1JZOWo4SVJBeENoVkMz?=
 =?utf-8?B?emFxOWF1dWF6S3lqZ3ZmRTEyNlRqVm55U3RrOHVoVHVPR2RRNzVoZVRreXp0?=
 =?utf-8?B?bkdNMmZBbDVibllCcFBxU3JPeEJ0ak5NbWZDNG9wdEV1Q29VRnlyRFpWVHBl?=
 =?utf-8?B?RlNFUjR6Uy8zdHpHOW45RmswVjBBNndqNG5uYndaZEgzSUR6QkE2VGZiVlZJ?=
 =?utf-8?B?VUZ6bG5FYmlGNkE0UFpHRmJLb1JIU0V4STJRakh0azdDK0VmSktsOGtjQjdG?=
 =?utf-8?B?REsvZy9PSExUQndaNVZaOUNnYlFNSDloLzc0Sis0RU1Oclg0UWIyMkZzNnRm?=
 =?utf-8?B?aHZlVDd6QWpuTFd3a3VSejFQRlVEbUp0OVFieC85eFFiTEUyOERlMWJaRWRk?=
 =?utf-8?B?UldyZjdiTkRSSDFXai9hMjJRVytmV05xYWM1NWlUbDdxZk1ZTUQyN1pTaHZs?=
 =?utf-8?B?ck04STMvVzVDdVY4R211Y2FrZEhqTVpkUjZzMmkrV0J0TXlVZ2pDMWYrMGVN?=
 =?utf-8?B?bGR4VlZaTWFxVXFrQXJlNlFidWNITXFMYzFzREh1SnowYTI4TkYrQnhzWHhz?=
 =?utf-8?B?NEVpelBZc2wvVVZ3clBIQ3VWYm02c1hVdml3UndOd2pSOStROXpJWXFlM3Ni?=
 =?utf-8?B?OTVuUDcyQXZ5aS9tVXdEU1FsYmMwNDhMaHRwNGhWL0lCRGdXL290THdIc0Jl?=
 =?utf-8?B?NVQwUFdKdzhQbk1lMnV0T1lBNkt1QzVsYTZJdUd5MG4yL0JHOWlLcE4wdytF?=
 =?utf-8?B?UFBqUk5LRUxOdmVaTDVuSXlnSnNNRnJGM25VVmRQTW9LanFVbytUeXVXOGZy?=
 =?utf-8?B?UEttcmVZcHZacjhNb1d6bkpRcjNlaEFvYkc2MXlVbGZENGN6cnI1Qzd1dkNh?=
 =?utf-8?B?TmpaR1E3bFhScGNCUlJmZG9YdnRNUjNrWWZMV2hwVUMxWXN1RkJvVVdCZ2xp?=
 =?utf-8?B?VHY1Y1E2Ly9wZmFVaUNybzlSL2pZQU8xLytCK0E2Lzk4R2dRaWRhdEdPTDUy?=
 =?utf-8?B?VnhPNHoyVURPWndKbmNvUjdGOXdBa3krUVVOL3Jqd1Nxa3h5QzlsTEM1TjR0?=
 =?utf-8?B?ZGdVdlg2elNoY08xOFFzUmRzM0trbSs4S2FoblRQVC9ST1gzWHpDU1VsYkxL?=
 =?utf-8?B?amZ1NStHU2tzdWxwQW5tTXNNZEtqSkxSN3lrWnhaNmFEYkprVndaWDgrbE04?=
 =?utf-8?B?NlBwdk1hQUxicC9pMTAvelFXWExzVm1QY0hBYzJMYndFSUZPZ0RGMGs4YTdj?=
 =?utf-8?B?V2xlQ1AxbitQZXlzcmtvUVpWRVVjRHNYbmplTlVzb2drMlJrRVMzM2dzUnJX?=
 =?utf-8?B?K3pTMEVjc2lFaUk3bTg0MEZSZFZSQ0ZiMkFkS2RUODJkMjN1WlZadmZKcHJy?=
 =?utf-8?B?T2FzZ2puZ0E4VWZ5Y1NVQ3lyK1FNVldESnBoZDFjZkxrVVFON2hkckYzQS8r?=
 =?utf-8?B?V05tRm03WkwrUDFMWmJNNnJQeThZNkxrRGFMZFVoazhXRW5xV0R0cVJwdzFq?=
 =?utf-8?B?bmtqakI3L1g2N3lsTFRjU3hUbC9yTzFDNjV0czIrL1NneTArVHNHWHlpYkZ0?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25AE5398459EDF48B0CBCF5AF3CD57CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8836.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f60e79-0a26-4903-55fd-08dc207293fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 02:32:46.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lz8tpXBISBTirSt/gRCfn+VY6A+oAUPzzF6op4Xp+j3FhhkhExngJ79SUQwog9iaoNKdcgoPUNqalZ5XOFQE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7707
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.923900-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4uYAh37ZsBDCjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2zMXjNn4Xwe5+Mk6ACsw4JlwpnAAvAwaz9Ng
	smL8Bq9iULKbroIyd53bewgMAUhyib3gilrWi3Gjil2r2x2PwtUb8lR3sG9JCv8D7QPW2jo/qri
	XSlutGr0KQ0NNQls32OEi+Nxscd9IQt29eVvcJnNF8NCC76P7lKVrLOZD1BXQJW4Re2U2py2WWd
	1VBI96HZ6U2vAkh1gxSEpPXi+oeMBQ9yUrgo9zgsyw+ZJnFumR9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.923900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	418F30C1B230790A8F8D57A5E5C7307E5D5C5A5D967C116EF43410CE8AB3E0342000:8

SGkgSmVyb21lLA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB0aGUgcmV2aWV3aW5nLg0KDQpPbiBU
aHUsIDIwMjQtMDEtMjUgYXQgMTA6NDYgKzAxMDAsIEplcm9tZSBGb3Jpc3NpZXIgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgDQo+IA0KPiBPbiAxLzI1LzI0IDA2OjI3LCBnYXZpbi5saXUgdmlhIE9Q
LVRFRSB3cm90ZToNCj4gPiBGcm9tOiBHYXZpbiBMaXUgPGdhdmluLmxpdUBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gQWRkIHdxX3NsZWVwX3RpbWVvdXQgdG8gc3VwcG9ydCBzZWxmIHdha2luZyB3
aGVuIHRpbWVvdXQgZm9yIHNlY3VyZQ0KPiA+IGRyaXZlciB1c2FnZS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBHYXZpbiBMaXUgPGdhdmluLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvdGVlL29wdGVlL25vdGlmLmMgICAgICAgICB8ICA5ICsrKysrKystLQ0KPiA+
ICBkcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmggfCAgMiArLQ0KPiA+ICBkcml2ZXJz
L3RlZS9vcHRlZS9ycGMuYyAgICAgICAgICAgfCAxMCArKysrKysrKy0tDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0ZWUvbm90aWYuYyBiL2RyaXZlcnMvdGVlL29wdGVlL25v
dGlmLmMNCj4gPiBpbmRleCAwNTIxMjg0MmIwYTUuLmQ1ZTVjMDY0NTYwOSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5jDQo+ID4gKysrIGIvZHJpdmVycy90ZWUvb3B0
ZWUvbm90aWYuYw0KPiA+IEBAIC0yOSw3ICsyOSw3IEBAIHN0YXRpYyBib29sIGhhdmVfa2V5KHN0
cnVjdCBvcHRlZSAqb3B0ZWUsIHVfaW50DQo+IGtleSkNCj4gPiAgcmV0dXJuIGZhbHNlOw0KPiA+
ICB9DQo+ID4gIA0KPiA+IC1pbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVl
LCB1X2ludCBrZXkpDQo+ID4gK2ludCBvcHRlZV9ub3RpZl93YWl0KHN0cnVjdCBvcHRlZSAqb3B0
ZWUsIHVfaW50IGtleSwgdTMyIHRpbWVvdXQpDQo+ID4gIHsNCj4gPiAgdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPiAgc3RydWN0IG5vdGlmX2VudHJ5ICplbnRyeTsNCj4gPiBAQCAtNzAsNyArNzAs
MTIgQEAgaW50IG9wdGVlX25vdGlmX3dhaXQoc3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQNCj4g
a2V5KQ0KPiA+ICAgKiBVbmxvY2sgdGVtcG9yYXJpbHkgYW5kIHdhaXQgZm9yIGNvbXBsZXRpb24u
DQo+ID4gICAqLw0KPiA+ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZvcHRlZS0+bm90aWYubG9j
aywgZmxhZ3MpOw0KPiA+IC13YWl0X2Zvcl9jb21wbGV0aW9uKCZlbnRyeS0+Yyk7DQo+ID4gK2lm
ICh0aW1lb3V0ICE9IDApIHsNCj4gPiAraWYgKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQo
JmVudHJ5LT5jLCB0aW1lb3V0KSkNCj4gPiArcmMgPSAtRVRJTUVET1VUOw0KPiA+ICt9IGVsc2Ug
ew0KPiA+ICt3YWl0X2Zvcl9jb21wbGV0aW9uKCZlbnRyeS0+Yyk7DQo+ID4gK30NCj4gPiAgc3Bp
bl9sb2NrX2lycXNhdmUoJm9wdGVlLT5ub3RpZi5sb2NrLCBmbGFncyk7DQo+ID4gIA0KPiA+ICBs
aXN0X2RlbCgmZW50cnktPmxpbmspOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRl
ZS9vcHRlZV9wcml2YXRlLmgNCj4gYi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmgN
Cj4gPiBpbmRleCA3YTUyNDNjNzhiNTUuLmRhOTkwYzQwMTZlYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmgNCj4gPiArKysgYi9kcml2ZXJzL3RlZS9v
cHRlZS9vcHRlZV9wcml2YXRlLmgNCj4gPiBAQCAtMjUyLDcgKzI1Miw3IEBAIHN0cnVjdCBvcHRl
ZV9jYWxsX2N0eCB7DQo+ID4gIA0KPiA+ICBpbnQgb3B0ZWVfbm90aWZfaW5pdChzdHJ1Y3Qgb3B0
ZWUgKm9wdGVlLCB1X2ludCBtYXhfa2V5KTsNCj4gPiAgdm9pZCBvcHRlZV9ub3RpZl91bmluaXQo
c3RydWN0IG9wdGVlICpvcHRlZSk7DQo+ID4gLWludCBvcHRlZV9ub3RpZl93YWl0KHN0cnVjdCBv
cHRlZSAqb3B0ZWUsIHVfaW50IGtleSk7DQo+ID4gK2ludCBvcHRlZV9ub3RpZl93YWl0KHN0cnVj
dCBvcHRlZSAqb3B0ZWUsIHVfaW50IGtleSwgdTMyIHRpbWVvdXQpOw0KPiA+ICBpbnQgb3B0ZWVf
bm90aWZfc2VuZChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludCBrZXkpOw0KPiA+ICANCj4gPiAg
dTMyIG9wdGVlX3N1cHBfdGhyZF9yZXEoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsIHUzMiBmdW5j
LCBzaXplX3QNCj4gbnVtX3BhcmFtcywNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0
ZWUvcnBjLmMgYi9kcml2ZXJzL3RlZS9vcHRlZS9ycGMuYw0KPiA+IGluZGV4IGU2OWJjNjM4MDY4
My4uMTRlNjI0NmFhZjA1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5j
DQo+ID4gKysrIGIvZHJpdmVycy90ZWUvb3B0ZWUvcnBjLmMNCj4gPiBAQCAtMTMwLDYgKzEzMCw4
IEBAIHN0YXRpYyB2b2lkDQo+IGhhbmRsZV9ycGNfZnVuY19jbWRfaTJjX3RyYW5zZmVyKHN0cnVj
dCB0ZWVfY29udGV4dCAqY3R4LA0KPiA+ICBzdGF0aWMgdm9pZCBoYW5kbGVfcnBjX2Z1bmNfY21k
X3dxKHN0cnVjdCBvcHRlZSAqb3B0ZWUsDQo+ID4gICAgIHN0cnVjdCBvcHRlZV9tc2dfYXJnICph
cmcpDQo+ID4gIHsNCj4gPiAraW50IHJjID0gMDsNCj4gPiArDQo+ID4gIGlmIChhcmctPm51bV9w
YXJhbXMgIT0gMSkNCj4gPiAgZ290byBiYWQ7DQo+ID4gIA0KPiA+IEBAIC0xMzksNyArMTQxLDgg
QEAgc3RhdGljIHZvaWQgaGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3Qgb3B0ZWUNCj4gKm9w
dGVlLA0KPiA+ICANCj4gPiAgc3dpdGNoIChhcmctPnBhcmFtc1swXS51LnZhbHVlLmEpIHsNCj4g
PiAgY2FzZSBPUFRFRV9SUENfTk9USUZJQ0FUSU9OX1dBSVQ6DQo+ID4gLWlmIChvcHRlZV9ub3Rp
Zl93YWl0KG9wdGVlLCBhcmctPnBhcmFtc1swXS51LnZhbHVlLmIpKQ0KPiA+ICtyYyA9IG9wdGVl
X25vdGlmX3dhaXQob3B0ZWUsIGFyZy0+cGFyYW1zWzBdLnUudmFsdWUuYiwgYXJnLQ0KPiA+cGFy
YW1zWzBdLnUudmFsdWUuYyk7DQo+IA0KPiBvcHRlZS9vcHRlZV9ycGNfY21kLmggbmVlZHMgdXBk
YXRpbmcgKG5lYXIgIldhaXRpbmcgb24gbm90aWZpY2F0aW9uIikNCj4gdG8gcmVmbGVjdCB0aGUg
bWVhbmluZw0KPiBvZiB2YWx1ZS5jLg0KPiANCk9rLCBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBm
b3IgdGhpcy4NCg0KPiBXYXMgdmFsdWUuYyByZXF1aXJlZCB0byBiZSB6ZXJvIHByaW9yIHRvIHRo
aXMgY2hhbmdlPyBPdGhlcndpc2UgdGhpcw0KPiBjb3VsZCBsZWFkIHRvIHVuZGVmaW5lZA0KPiBi
ZWhhdmlvci4NCj4gIA0KPiANClRoaXMgdmFsdWUgY29tZXMgZnJvbSBvcHRlZS1vcywgYW5kIGl0
IGlzIHplcm8gYnkgZGVmYXVsdCBub3cuDQoNCj4gPiAraWYgKHJjKQ0KPiA+ICBnb3RvIGJhZDsN
Cj4gPiAgYnJlYWs7DQo+ID4gIGNhc2UgT1BURUVfUlBDX05PVElGSUNBVElPTl9TRU5EOg0KPiA+
IEBAIC0xNTMsNyArMTU2LDEwIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9ycGNfZnVuY19jbWRfd3Eo
c3RydWN0DQo+IG9wdGVlICpvcHRlZSwNCj4gPiAgYXJnLT5yZXQgPSBURUVDX1NVQ0NFU1M7DQo+
ID4gIHJldHVybjsNCj4gPiAgYmFkOg0KPiA+IC1hcmctPnJldCA9IFRFRUNfRVJST1JfQkFEX1BB
UkFNRVRFUlM7DQo+ID4gK2lmIChyYyA9PSAtRVRJTUVET1VUKQ0KPiA+ICthcmctPnJldCA9IFRF
RUNfRVJST1JfQlVTWTsNCj4gPiArZWxzZQ0KPiA+ICthcmctPnJldCA9IFRFRUNfRVJST1JfQkFE
X1BBUkFNRVRFUlM7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyB2b2lkIGhhbmRsZV9ycGNf
ZnVuY19jbWRfd2FpdChzdHJ1Y3Qgb3B0ZWVfbXNnX2FyZyAqYXJnKQ0KPiANCj4gLS0gDQo+IEpl
cm9tZQ0K

