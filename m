Return-Path: <linux-kernel+bounces-105692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76FF87E2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71011C20DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F347208CB;
	Mon, 18 Mar 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FaJs2mca";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mQ0py6dm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D901EF0D;
	Mon, 18 Mar 2024 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710734745; cv=fail; b=HEe6QBOb+wUNJaqZidYjEnbP7XOCC/1oTWNfVmRxFgaOdbUQBdBriZIF+VJGQyhnpueC8S7vl4/6ljH7vYpib8x5yoWx1YZMNgG5KlxiUcgm8j7ngXyD8hnK0m4GT7HPu8oADYjB1njClz+7qaSDWKGXDuO9ev/ooSmxOYSN33g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710734745; c=relaxed/simple;
	bh=xBpUYzme6LomQC56sgj4EsJG7WMpMjmWBTX1j/rtiV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zd0IN5nJD1beLBbAOTQGulnbIIusIldWc9K5rFX7LbDLoTVHqKT1Ar0kRzMVfMdjuf2og6pLAaY1hYFfwKrYrmzzbUzSnhmosCqHcf6OJAO8LFpILRqaiqOQAa4Wc3KjKpA9V2NccanqdioMvO/J0kSlFQ6nqn2Ko30tesUPtnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FaJs2mca; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mQ0py6dm; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9a04282e4da11ee935d6952f98a51a9-20240318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xBpUYzme6LomQC56sgj4EsJG7WMpMjmWBTX1j/rtiV8=;
	b=FaJs2mcaySBtxnVAxnnZTEBlB3VikuGOkZJ6EwTig0G82Wqs7F8R5EYi5vwRinUhwk5nMVyp/Lduelv6yqroRvV/U6NOSM4s7aCABEwQwhI2Sx4dOBu1g9xvXGp8jmFJXP+NZuPBx0S8Rk3WkqgezugFF0kWCNrvfXzn6M2CWCI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:530fb68c-a8a9-442b-8fd5-375b15aa4946,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:54d30100-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9a04282e4da11ee935d6952f98a51a9-20240318
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 256349102; Mon, 18 Mar 2024 11:50:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Mar 2024 11:50:28 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Mar 2024 11:50:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUAcrP6GrwT5fqynQDfRN1fsykCno4qggGQzcPlLOHjgZceoWdK7DZxRhW4v7kI02zQJK76QKKQygiWXqZObCjgjXQ2eXHGTqDT4OmVZd+swHnuu34lYXd2Cu9ry4uqgfP8rrEpTWOdVadMZ/yU2LwPXObOkozPwrv12/W/B1pdZST4XopQ0VwFtR1lRQEz1EiTUC2by+lHSENn8Zvmgs/HPDb6SohOZgD9ivEu7kDrQZnUJrt/59SbRLBubr/1umT6ZTYoGISSGj5lrKvFSp3IJELrgtnfUtZfJeJVIJVBbFXBmtdbs9IPHSbvx1/2wTS1sP0y9XJ+eohT6QeYT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBpUYzme6LomQC56sgj4EsJG7WMpMjmWBTX1j/rtiV8=;
 b=eBMb8XIRQCZZuoxH+94DaM/+97H2D9Gs6UAieCTYaST+myIUwVX8wPm13fILEHw+JCooKsgAWLz/pUmO0tbExSFwy5aOgUwgnqTU9wG3AspSeo2cGbAyr32zTDmONcAPVEAvlKODQV08WM/hURZUIofky6CoQ3moRN5JvXIoZOj46OuNd4EL8c3LeD2UVH32jfn2/nIjBz6ob0ZN+o8fWVcVRW+4GxMb3Ew+xdRQUzi5RHav8bEnCxox06vKflC5axGAupatBkmuJfA9off9yZVN/JeOlrPXz6blkbegvvOlJ+GFwOFWORoi+RWFCRRrvRMK5xbPS2Oe3UgkxczUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBpUYzme6LomQC56sgj4EsJG7WMpMjmWBTX1j/rtiV8=;
 b=mQ0py6dmUAP1qt8MIDPFyv7ZnAGX4rdU+8zn5HoQXB2vicQbMNaeoB5qVT03I1q1PkJinN/mvAVC3Q44hnzOBdatoY5ty4EPZi2aqJPp+evx4curBq7RI+oyx9At8CAKe9xIFvdEq5y8QPmXRd7N8gYyjG6BZp0dp47Mv/0MpYQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6950.apcprd03.prod.outlook.com (2603:1096:400:276::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Mon, 18 Mar
 2024 03:50:25 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 03:50:25 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLE9RzAA
Date: Mon, 18 Mar 2024 03:50:25 +0000
Message-ID: <6a0cb747db7a1c9dd5ccb5779e10b9114e186e14.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6950:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5UZc+mV+RSwy6w9KGkL3YGThnxJ0O75H4ZNgl52qM9i08s5aalcZ61gFc+5D3o+5U2W4T6YiE16HUDX4QzElbAuTcC+kJ9BsfdL19YTMMrt67y8wbaQ7WIX4kdtD4lvV4RNgG7nkrgTdZAefkaxi1osUkPxairfi0cvJ8lENnh42voZShpRAP+qN/z4nM/lvGMHXaUBODvIuz8H+bf90MjUot71t7bK+0M/eE+BGOj1IS7jhS2HPGsCrCGNv4nn7JvxqwNzRL0fNugJ036TZTgHrPis+ivbnARVPSjMFx68cFNFHiLWWN/jDxqbHbZYlJCppXV/f/BaitoTyHfLJVgSDVlY4YDjYpoXfXJpy8s4g7ZjGSrel+9ujFjBIBFt0+m4EhP4C7bYkaMVK0VAeXxtTPHQQa60eclTK4EhzQJzAvk8GAxduSaroTfAPhILyCweH8mqLFxrrghEONi5/0+L3uCGe9bRmPT4nXDy7dMJ9QjichqQuhlVZXLWTOe8OR6YJuj/GiG23PkcuZtozEa4UN1KlTD4phLwM1RRmUbb7o6ExJ7aPqpN1MvD7PFBoWfjsjkzWF71xPU9cGugQ0aNl3YzMtpdDG0hsiMLOGr4cqDbrirlLPobkv1o0Y5C9I105Wtu5ab6KmwYbk9QMZBsLHMc605r62+UoyzB7Ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xJUVBJTDVyYWNZdzQrcThURWRkT2NnZGFjTHAyTkx2UGxTVC9pbHBycUNL?=
 =?utf-8?B?ekQwZ2NITGo0Sk9JQ3ZjYUxyK3pkWjBXU21sNnJUTkNOdkEwTVRGV21jaXN1?=
 =?utf-8?B?SmJkY0wvbXBRU2hKSDVkeXdrRWZSSG5nUC9OWWdtS040cngrZlNUclJKbWtv?=
 =?utf-8?B?UytxcXFNb1pwTFlMRlRrZEM2WlZ0eUZxbEtMU3prQmx4dTdXSnlhVURVV2c4?=
 =?utf-8?B?M2pLRk83dFBrYkhQUkh0YmVZaEpJOGJDZytsQ1BLOXNTRnB5d3Z5OXF0bVFI?=
 =?utf-8?B?aXJpcmtaWjU5VFcwTmNrZytFMDhML0w4RkdiZkJqWWNFUkRoMDh3eUgxQlJv?=
 =?utf-8?B?L1NGU3UxUUhnekw4d0IzVGhRM3lpbzVEejdFdzVhWmxoQkw2QjFwa0EveEFn?=
 =?utf-8?B?eHRmWVVScW80cWp2YW9tRHhKRHJQTjlCdVowcHlNRFgvSGEzWnIxWnlCYzRL?=
 =?utf-8?B?NGxmU2tlNDVSMHh4ZTY1OUU0QTBPZUpvU3FlY0xWUTVId3ZHWWlOc0UzTURK?=
 =?utf-8?B?eU5wRS8wdnJseWViUGdYRWdkbTdBMlJ2ZWJ0T2NuczNySGNzRkRLYllZMHVD?=
 =?utf-8?B?UGExQjlNdTdnazN6TGEzWUg5cnNmSzhPZmpSZGpxdVUzNUQ2REJzNExNcnFP?=
 =?utf-8?B?M0IrLzlxMjUwTXFvalJVdC84NWsrTWs1bWlmaFdweHIyQWd5NUR3TzE4c3Jt?=
 =?utf-8?B?QlFLSkNnSkdIZWhjVXNldE13RVF4d2JsRUxBc1ljWEtxV0JhUW1FYWd6L2cw?=
 =?utf-8?B?ZjNuZkFNOUpkcGtxaGVEUkRsTzZ3SkRtdm81L2dVM2s1QlRFMy8wOVJTMHg4?=
 =?utf-8?B?NUF4bkc1VHZRcUVUS1V5UzB5OVRMMU9PNDZzT1h6aXdpTERLYzhJMDNoQzY4?=
 =?utf-8?B?MHlmbjNDWEZtVGgrUGdaZ3BWc1pzdjgvSmdsYzEvMzB5UHE0ZmRib05UVW83?=
 =?utf-8?B?c3BDRjhnYWdEWHNkVkxveGNIS0grY200Ykt3YzVyYTd6SXJsbGwwcHE3aFA3?=
 =?utf-8?B?bFlDQWQvWThUTjkyOWdoVjVuU1VBamlOeU95RDdrOGsxQ1dBZ25vME00UnM2?=
 =?utf-8?B?Mm0vb3lUMEtDa3BLVC9aVVg4UmlYd3lGdFlrTDZ3TW5IM2dIbE1rbDUyWFp6?=
 =?utf-8?B?N2kwd0hjV29tcnB1cVRXVFR0V0xOMU1yTnJaREU0VWJQQjdzdEhWNmhWODQz?=
 =?utf-8?B?M0VwM3ZBZjBkWTFlbTNYSmtZWlM3MEVrMjNzaWVxM2hUMkF1SXR4ZjZKV3Fl?=
 =?utf-8?B?OFNiWEZWcEhxb3BhRzhRY013dzB1ekVqZGYyN3JvVE4yQkdhdGJNbTFmZVQy?=
 =?utf-8?B?RDVnYWhhaGhqcFpaQVZnV3F3Vk0wam0wdVVtSlpTMXQ3ekJvTmlrUGt6S1Y5?=
 =?utf-8?B?VkwyYTNOZ1hpUDNTaDQweHpLSCtwRlhGbTNSRGQzZU90S0drcGh3YnpuK29k?=
 =?utf-8?B?ZkZ6RTRKZThqWVQrRnBta01WOTVrQlNpUzJESC9lMzRjVXJqbmlsRWo3SnFK?=
 =?utf-8?B?T1V4ZlBHVEMvdHlnVWxYSnpKNE9Ha1R6b0NjMTZ4eWNlRFRURm1EZ1JlWFFQ?=
 =?utf-8?B?YlpBQ2pPb3FVdCtyZ3hLUm40QmFENm5za1FVT1hFY1l4THlud1JiYzhQdnZl?=
 =?utf-8?B?bGJqQllDNFNyR2dMWkQzWVErNzBxajJVUmorTXhTdHpDZ0Mza0ViUDNYSEw3?=
 =?utf-8?B?ZGpGRmQvcVNPcWt6MytjQ1F3UnR0SzNpdVJkemZMcFlFTkVRU2pTMFYyaFpD?=
 =?utf-8?B?eE9tNHQ3L2RvTUNhTTZrT0VUSWNqbS84ME0rUG1CWGNNU2ZNL1VZeTNOWFAw?=
 =?utf-8?B?V2RLMmhLU3pOMWx3bDJKY0hHQ3R4aTBnemd1Z2gzVDgzSUhoNVpINi9FejQ3?=
 =?utf-8?B?RXVyMm1wcE9sTTRzNDhoT2xheHlwWGNsMnFnTFJ1bVBySFZ3OVpGWmtJbXYy?=
 =?utf-8?B?Nkw4OVR0dGhuYkNzeGl1MlRLM2pTbjlBYXlwT2lHYmFUc2ttZDhBR2R0ZEFy?=
 =?utf-8?B?bm5KdVRiUzEzbEJiOE1Kd1l6VUdFSjB0STBaNGdxQ3VmbXdqbWtZcksvaEt2?=
 =?utf-8?B?VVhTRlMzbHFDdGpRczBKMThCOHAwSFF3UmpHUUlpaVdFODJTajQ2VlJqcDJ1?=
 =?utf-8?Q?GbZt4V4V7ShkcxrJX37bapZjD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CCDA2A4C1AEB945A3D56F10E514FCBC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21029cc3-90a6-4568-0b99-08dc46fe8ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:50:25.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCxpKv8n6lNrYGALYiBbK72Ow6fxcVFpVAjZp07cIZADV+k9QDHnP51p6zkZMsp+7kaRr1tOKCW80jcDmgJffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6950

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIHZvaWQgbXRrX2NhbXN2
MzBfc2V0dXAoc3RydWN0IG10a19jYW1fZGV2ICpjYW1fZGV2LCB1MzIgdywNCj4gdTMyIGgsDQo+
ICsJCQkgICAgICB1MzIgYnBsLCB1MzIgbWJ1c19mbXQpDQo+ICt7DQo+ICsJY29uc3Qgc3RydWN0
IG10a19jYW1fY29uZiAqY29uZiA9IGNhbV9kZXYtPmNvbmY7DQo+ICsJdTMyIGludF9lbiA9IElO
VF9TVF9NQVNLX0NBTVNWOw0KPiArCXUzMiB0bXA7DQo+ICsJc3RydWN0IG10a19jYW1fc3BhcmFt
cyBzcGFyYW1zOw0KPiArDQo+ICsJZm10X3RvX3NwYXJhbXMobWJ1c19mbXQsICZzcGFyYW1zKTsN
Cj4gKw0KPiArCWlmIChwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGNhbV9kZXYtPmRldikgPCAw
KSB7DQo+ICsJCWRldl9lcnIoY2FtX2Rldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBwbV9ydW50aW1l
XG4iKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCXNwaW5fbG9ja19pcnEoJmNhbV9k
ZXYtPmlycWxvY2spOw0KDQpJIHRoaW5rIHlvdSBzaG91bGQgc2V0dXAgaGFyZHdhcmUgd2hlbiBo
YXJkd2FyZSBpcyBpZGxlLiBTbyB0aGlzDQpzcGlubG9jayBpcyByZWR1bmRhbnQuDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+ICsNCj4gKwl3cml0ZWwoY29uZi0+dGdfc2VuX21vZGUsIGNhbV9kZXYtPnJl
Z3NfdGcgKw0KPiBDQU1TVl9UR19TRU5fTU9ERSk7DQo+ICsNCj4gKwl3cml0ZWwoKHcgKiBzcGFy
YW1zLndfZmFjdG9yKSA8PCAxNlUsIGNhbV9kZXYtPnJlZ3NfdGcgKw0KPiBDQU1TVl9UR19TRU5f
R1JBQl9QWEwpOw0KPiArDQo+ICsJd3JpdGVsKGggPDwgMTZVLCBjYW1fZGV2LT5yZWdzX3RnICsg
Q0FNU1ZfVEdfU0VOX0dSQUJfTElOKTsNCj4gKw0KPiArCS8qIFlVVl9VMlNfRElTOiBkaXNhYmxl
IFlVViBzZW5zb3IgdW5zaWduZWQgdG8gc2lnbmVkICovDQo+ICsJd3JpdGVsKDB4MTAwMFUsIGNh
bV9kZXYtPnJlZ3NfdGcgKyBDQU1TVl9UR19QQVRIX0NGRyk7DQo+ICsNCj4gKwkvKiBSZXNldCBj
YW0gKi8NCj4gKwl3cml0ZWwoQ0FNU1ZfU1dfUlNULCBjYW1fZGV2LT5yZWdzICsgQ0FNU1ZfU1df
Q1RMKTsNCj4gKwl3cml0ZWwoMHgwVSwgY2FtX2Rldi0+cmVncyArIENBTVNWX1NXX0NUTCk7DQo+
ICsJd3JpdGVsKENBTVNWX0lNR09fUlNUX1RSSUcsIGNhbV9kZXYtPnJlZ3MgKyBDQU1TVl9TV19D
VEwpOw0KPiArDQo+ICsJcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhjYW1fZGV2LT5yZWdzICsg
Q0FNU1ZfU1dfQ1RMLCB0bXAsDQo+ICsJCQkodG1wID09IChDQU1TVl9JTUdPX1JTVF9UUklHIHwN
Cj4gQ0FNU1ZfSU1HT19SU1RfU1QpKSwgMTAsIDIwMCk7DQo+ICsNCj4gKwl3cml0ZWwoMHgwVSwg
Y2FtX2Rldi0+cmVncyArIENBTVNWX1NXX0NUTCk7DQo+ICsNCj4gKwl3cml0ZWwoaW50X2VuLCBj
YW1fZGV2LT5yZWdzICsgQ0FNU1ZfSU5UX0VOKTsNCj4gKw0KPiArCXdyaXRlbChjb25mLT5tb2R1
bGVfZW4gfCBzcGFyYW1zLm1vZHVsZV9lbl9wYWssDQo+ICsJICAgICAgY2FtX2Rldi0+cmVncyAr
IENBTVNWX01PRFVMRV9FTik7DQo+ICsJd3JpdGVsKHNwYXJhbXMuZm10X3NlbCwgY2FtX2Rldi0+
cmVncyArIENBTVNWX0ZNVF9TRUwpOw0KPiArCXdyaXRlbChzcGFyYW1zLnBhaywgY2FtX2Rldi0+
cmVncyArIENBTVNWX1BBSyk7DQo+ICsNCj4gKwl3cml0ZWwoYnBsIC0gMVUsIGNhbV9kZXYtPnJl
Z3NfaW1nMCArIENBTVNWX0lNR09fU1ZfWFNJWkUpOw0KPiArCXdyaXRlbChoIC0gMVUsIGNhbV9k
ZXYtPnJlZ3NfaW1nMCArIENBTVNWX0lNR09fU1ZfWVNJWkUpOw0KPiArDQo+ICsJd3JpdGVsKHNw
YXJhbXMuaW1nb19zdHJpZGUgfCBicGwsIGNhbV9kZXYtPnJlZ3NfaW1nMCArDQo+IENBTVNWX0lN
R09fU1ZfU1RSSURFKTsNCj4gKw0KPiArCXdyaXRlbChjb25mLT5pbWdvX2NvbiwgY2FtX2Rldi0+
cmVnc19pbWcwICsgQ0FNU1ZfSU1HT19TVl9DT04pOw0KPiArCXdyaXRlbChjb25mLT5pbWdvX2Nv
bjIsIGNhbV9kZXYtPnJlZ3NfaW1nMCArDQo+IENBTVNWX0lNR09fU1ZfQ09OMik7DQo+ICsNCj4g
KwkvKiBDTU9TX0VOIGZpcnN0ICovDQo+ICsJd3JpdGVsKHJlYWRsKGNhbV9kZXYtPnJlZ3NfdGcg
KyBDQU1TVl9UR19TRU5fTU9ERSkgfA0KPiBDQU1TVl9UR19TRU5fTU9ERV9DTU9TX0VOLA0KPiAr
CQkJY2FtX2Rldi0+cmVnc190ZyArIENBTVNWX1RHX1NFTl9NT0RFKTsNCj4gKw0KPiArCS8qIGZp
bmFsbHksIENBTVNWX01PRFVMRV9FTiA6IElNR09fRU4gKi8NCj4gKwl3cml0ZWwocmVhZGwoY2Ft
X2Rldi0+cmVncyArIENBTVNWX01PRFVMRV9FTikgfA0KPiBDQU1TVl9NT0RVTEVfRU5fSU1HT19F
TiwNCj4gKwkJICAgIGNhbV9kZXYtPnJlZ3MgKyBDQU1TVl9NT0RVTEVfRU4pOw0KPiArDQo+ICsJ
c3Bpbl91bmxvY2tfaXJxKCZjYW1fZGV2LT5pcnFsb2NrKTsNCj4gKwlwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZChjYW1fZGV2LT5kZXYpOw0KPiArfQ0KPiArDQo=

