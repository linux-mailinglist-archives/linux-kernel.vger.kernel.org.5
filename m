Return-Path: <linux-kernel+bounces-105702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2A887E2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD234B212C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFC21105;
	Mon, 18 Mar 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jMZzZHuA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AgyKwaaP"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26A18049;
	Mon, 18 Mar 2024 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739143; cv=fail; b=XW/IkKgHKnwP+InFV4Ow54+tw1XpgsWrB7j/u87abRLJzfRLuJ1AiFWxIwUIeuyu9HZAXTfu+PEDwX1RX6j57GVsUIEPmAKujlvZPy1FH+l97ufWUcTeq5h2al4E8uwuLJkj1fAJ3Cs8TZ4nsHW1TboWpxkFhb0rtTyNTdRDi10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739143; c=relaxed/simple;
	bh=WL7sVT+E23jP3rUX9BE3Q5PEsLsPfhOg7AT6TVdiN40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSad5h3Ysgj/HFL3d9kngoknnzAfEYtyZ3pq5SggXnA6+JXOVVErKjC+cL4IERADVvirys1HULswxY7ebN8jUZ5hBXHC3rMXcWTdjTbgxTMr/Y1rXnk5ig7NI2RS3KG71s+Ak8XRi9/N/0/MpD6OlPioYOWHQCsE5oHGEDWFtTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jMZzZHuA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AgyKwaaP; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 005ba6b4e4e711eeb8927bc1f75efef4-20240318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WL7sVT+E23jP3rUX9BE3Q5PEsLsPfhOg7AT6TVdiN40=;
	b=jMZzZHuARoae8IyRB1k7jrKSWDDFKp5PUw0tAmEsro0rhXjalPCmt358aHpKlvmBXCNvUm9rYiWvyUPYAKDwpgFn0WjVn+Nx2S/KO8RW0gBmgjvfK5AqPIAwMThJIwXUybwywu3FODyLzyV2VP2Kz2heXQa/13F8PdPlMz5J5Q8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3a577e11-557d-41c6-b626-bf7148cad6bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:13a50200-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 005ba6b4e4e711eeb8927bc1f75efef4-20240318
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1654427521; Mon, 18 Mar 2024 13:18:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Mar 2024 13:18:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Mar 2024 13:18:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxfUCI3F2tucSPwJypDR6Boi1q8y6BeFQzCGhSwnPH4HwwT4X9SXqOgUEX4QzMAla59uCQ5/ICPY0NM7HwcHUzY9BuGvzaUrypdhfnPfi5gdQVQ4ItcBgGUZN62asV6e5+UjUGqBaUhfVQmCbnnlt/6cnNF7Atu9NNCp8PcvQ/UhKuAxd0YBPV5QrWCy48gdk6Lq/RV63Ke44l/cJTRfnhbyrBZjzsTu/knIQ8gVXgVayOL14hsIh8gJ2w25ZyBe0RJYCw2MbeIvrXO+K8A9u/PJa1BfcznpVuNx+gIr4HB84YZjtuIuuOp6+ZK/dETS+YXlnSWvs1dE9M9MwfGVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL7sVT+E23jP3rUX9BE3Q5PEsLsPfhOg7AT6TVdiN40=;
 b=KAdzWzhjftAy/lzCqfXtJywyNolkblxbuK8+Zp+Y/9GyGk/66mt07OUjYirXAeIoSPgKNUBuiY4mrB+VT7BRHI8HDsKTd438YlDWqyVqDPIaPzVzCSKhEvkBs+SUieBEmYgAyVcZTkiYRgcLVu7EvLv4Pu443TbWqFpdPTNyeJkOL7N9EtcRBJIGOBEbn0odfXJxm/Hd+zyeg4j2TNr+tj31V4tGVtPQymOJZgG8eKndBNWbUtbSnTPX927By+Cf+4CUS9sjNjq6DW10QPal7UIYXyup7OIrHHAVITjD968mgCxAwHdmzLoEOUomyGo5SlSlBXRgh1YTiyM7t8MJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL7sVT+E23jP3rUX9BE3Q5PEsLsPfhOg7AT6TVdiN40=;
 b=AgyKwaaPiFmjhy8FFk3VwykFed6R3rt7d86d9LkYQCmit4vj9g+k1Vs87ZM5PrevUKAb99qj7OSl/0JLo3GziorOKHIrqTQcHQl+DLpFKAvXLElkCjV21rouEhSd5DH2oDGPwCBa4fbGjjEAwD2wqXiyslNPuNLAfMa4D/e5oe0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7006.apcprd03.prod.outlook.com (2603:1096:101:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:18:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:18:42 +0000
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
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLE9X9uA
Date: Mon, 18 Mar 2024 05:18:41 +0000
Message-ID: <a9eebe2033542fc5d65bf582e8321fd0b03bf4f8.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iM5kmTq/vKLXu/ufPhWtzb88YlD0m95CPd2sKyMrDGeUcKXcgXbFAOAeg/V0InEzUuelI+etEEhfFqhWoFPQoPAAre8qIss0IO3JGbvGOkSm8IEyynVrZf5FhMsI9wma6Kw42f43Gcr9QNK8Y6kZ63ZJQ5eBGSmFC5Dvj9BbkhG2O3jhxepFgVvFc7pKSSlQZkrSJ3GsRZ9LahSFPp1eLqUMhsnE4tCCUEQkjOnpQCNx5dFkbI0d/U8CHc+CvAO5jPUKhE66mF6tuK7hrV04RCSbhWd+uXOzSHLGAcDcBkEGIXO5WPi/Jzlymh+MfjL55pfQaDmCyyb0VwVqr876951KgnFwdXwEkHyCC6qaNds7bFZQuKz9qXSFJ6ua4rzYTTBFldGhIJ/g2ewhFnnXbJAf9/40xPGyqm5EoRB4DJplo1a1Hl4GpBtSKrJn3ZYyDV9meKc5iHHBNWL1ViFQpoL0KT2BJ2nLPHpyytBPBaFUTD18/Kq5yxbocPEzFmqLpCtyZh2S2I4Av2X2ok6/ykkIux/E3xncR4Dpxg3KT3p5vw3EvsSEzCo9TFazyy7e4QXSed9JxzIj4+eoyO2iNp3riMFdU/rkvwNCAjmAp1BbPYZ6FDn8CMK/TIoh/kH7e2BvatypInINMiH0JQEmVkvZeg/7/6rN1EoatBiTJEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blRCdm9WNEFRZkNtMkVrVlhqYmorOXd2a21ab2FGeU5TK2xrRnA2aHB4b3dK?=
 =?utf-8?B?M3QvblRwUGk4QVppTnRERFBtbGY3UTZRNmZkdklJRHM1ZFIyTFIzTmJOenFH?=
 =?utf-8?B?RE5GRHR4azNDTi92YzdkU0tWa01LMUlqK3BYT0hOa1RmNFJPNUwzOGlab05R?=
 =?utf-8?B?cGxnTURWSWdhRVJqMEZKVDV1YnIxcU5tZFpHZzRwQXUreW44c2drNUhyeXdn?=
 =?utf-8?B?TEdFVmRjNWpOWHlWMkppdnl0Um00NFBqZjlZUzNLNXNnd3IvaVlxbjQ0VVky?=
 =?utf-8?B?WUkwQlhCY0J4QmNGbmdYdFQ5U1BwR2RNc3dNRFBxdHdQUXNaZEIxT2h1WTY2?=
 =?utf-8?B?QzZCaS9PcHZBdEpPSnIyKytaSW9LTXAwWitldERrc3VKOWw4RzROZjh0cUo2?=
 =?utf-8?B?RllZYkdkWlhKMU9oZmZFSTJRd256Vyt6R0JiZDltVncxL2sxL3B2Q2NoTDZk?=
 =?utf-8?B?aHhEZ2tHODZRRiszVXJnb1ZiV0puNlFTNlEwY21iQzJlUXBFUkprQ0h2MStK?=
 =?utf-8?B?K01aVlA3cmdvWkVyNWhsYkpRZnpjYlBWeWx1RzlCS2ZYeFZNN1VBOTBaU3dn?=
 =?utf-8?B?d2pCaEU5SXhIRThiVU9aNlFMREdocVI4MDRJZ0xBaEJJMFYycUlDbkRHRFRZ?=
 =?utf-8?B?bmw3RENDSnc0ZUJ1WlNxRVA0WldQKy96LzJkMkR2d1g2VmdlSy9Bd3NJR3Jk?=
 =?utf-8?B?NXpwVTNsS0lOVnVEbytkZS9hN0dPTDRLYXlmancxQVdyUmtlOEx6ak4vWEpH?=
 =?utf-8?B?NUZyU2ZLT0NXVHhCU09vZ2g5QlhacFUzYjhnWGZaZEFOMXFMVHNWUm9GaHNB?=
 =?utf-8?B?YjY5eGZNMFJWR1kzbm1Ba3ZhMS84bGdSVWRDb2NvKzdEN05ST2lrMXhzZGR0?=
 =?utf-8?B?TGMwaldLM3dyeldEQW8wZU5GVXJ1a3gvQ295QXprTkl2MG9vbU1NY2grNWRT?=
 =?utf-8?B?ZTYwT3dWN3VRb0lzMFUreGNYSWhUelpNd2FyL1ZwNUZpWWs5M3plTFh2SEtK?=
 =?utf-8?B?Wkg5WGgwclJWQVh5K1ZTNGhVVE5EZzlrYXhrajNsSlVjZGtTcnVJcG1BNnlU?=
 =?utf-8?B?REo1OUZvbktnRjBjN0JDa2J2c0tRaU1ORVJidDE5empIamlTSDZuNnR0MEVm?=
 =?utf-8?B?NkkzT3ZGSEVxZEg5MjgzUUtOT3ZpV0ZHTHdlZzRoNFFwdG9qekxjOVA1aW53?=
 =?utf-8?B?NzQ4TFM2Ykpmd1pzaHkwbVJRU2liL05BQU1GTGliTEZFT1ZvY3U3alNyVjJ5?=
 =?utf-8?B?aTBSOHBCbmxacVA3SGtUdCtGeWV2T2NSUHl2Rlp0ZHZkenBidlhOL3A1c0tS?=
 =?utf-8?B?aUErUWdqaFB1TXMvczBhWTNDbkQ1TEtnSmtxL2NsTncyVy9iZFZQYlViQXNP?=
 =?utf-8?B?cytPYkZZRnMvMk95TzBQaDlKTWRrUnpCZmZ5YldUdlV2aStvVmVqY3RVUlhD?=
 =?utf-8?B?dTdqTUJHQjczV1k4cHo1Q1l3Rk1EWTFCM2V0b2xla0VhRHFRN2FGbGJlQURS?=
 =?utf-8?B?V2tRUVdVRW1LYUtHVWhDcE44SGVMdE92ZkpNcmxsV2Z4MHB2YVFMWmRVZWZE?=
 =?utf-8?B?UnlOdG55VENmZVhzbHFBNDgxbHRtVExodXdmRC9OR05zdmVFRURLQndzdUhJ?=
 =?utf-8?B?KzdHUTNycFhXWi9kTktpUDdPb28yWU5TMzAxbDZERUd2TFhobElIakw2RjZU?=
 =?utf-8?B?VWkzQzROZnBEb0hPOFZzN2YvWWM1MlI3dEZ4T3YzVUF1U2NsenpoNjJqbHE1?=
 =?utf-8?B?OForYU5RWW8vMU9GMUpiTnlMdm02T2dtNHBlRGpRZWNXZGFqSXh2azkwY0s2?=
 =?utf-8?B?cnZZckIzaStoeFZHWi90TGc3RTlwRFFpR29pZXZER2sxM053WVBacXZUZEI0?=
 =?utf-8?B?b1dWV0M5RlpETmNKZXhKaDNQME05MmFRaEhZMjUvQTQ2dUsvdWFtWmN6Zzls?=
 =?utf-8?B?d25UYUM4aGtkU0hKb1Z3QVRiQTNaMFl6YWxkQzBQNWwyNThWeFd0VFB6aWFT?=
 =?utf-8?B?ZWNxVzV2UjYyK0RQSEtoRkI0dVcwcjIzY1g3eWNtaDZ6RFZveXphRU9EbVlE?=
 =?utf-8?B?RDdrR2JydnFaZFk3QjJMZjUzMEl3V3NHUWF6OXo2UGRtQ0RTK21SaVJXVnNQ?=
 =?utf-8?Q?Z2ySwrRT1YDyZpaFNQAtSQikj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E36C2F8D8D7BFE438F2E6B1EF54663A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167c2d13-ba35-447f-3828-08dc470ae06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:18:41.9686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKNRJWzuAo268XP7gRVPs4CiPpxDGytKju7x+35NWVbA8DCqi2YmsgYcKdnLKXwkoIj+15WIE1ElUZKDCcgl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7006
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.201300-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/XD0CNJ3fxO4dcT3ZaTocyYHhs0mgDoxyETzgIO4sasaQTVtPXXNMMhP
	1tiEXdMs0Q6mtZ8tcpzE5sN2sFEOjEGsY7H1diHXBVprK8rvWXzFcf92WG8u/H8fXhwPLN7GjxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwrfHxA6Z6eUZAm2ddODgaK8YbK
	dL8aBe7Jtrw/fQmYlVDRzj+ozxLJw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.201300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9FF592F553F7F31327C983AE25D45BEB2B27E355D708C59E8D384F0361E8E2F72000:8

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
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdHJ1Y3QgbXRrX2NhbV9m
b3JtYXRfaW5mbyB7DQo+ICsJdTMyIGNvZGU7DQo+ICsJdTMyIGZvdXJjYzsNCj4gKwlib29sIHBh
Y2tlZDsNCg0KRm9yIGFsbCB0aGUgZm9ybWF0IGRlZmluZWQgaW4gbXRrX2NhbV9mb3JtYXRfaW5m
b1tdLCBwYWNrZWQgaXMgdHJ1ZSwgc28NCnRoaXMgaXMgcmVkdW5kYW50LiBSZW1vdmUgaXQuDQoN
ClJlZ2FyZHMsDQpDSw0KDQo+ICsJdTggYnBwOw0KPiArfTsNCg0KW3NuaXBdDQoNCj4gKy8qIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAtLS0tLS0tLS0tLS0tLQ0KPiArICogRm9ybWF0IEluZm9ybWF0aW9uDQo+ICsgKi8N
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY2FtX2Zvcm1hdF9pbmZvIG10a19jYW1f
Zm9ybWF0X2luZm9bXSA9IHsNCj4gKwl7DQo+ICsJCS5mb3VyY2MgPSBWNEwyX1BJWF9GTVRfU0JH
R1I4LA0KPiArCQkuY29kZSA9IE1FRElBX0JVU19GTVRfU0JHR1I4XzFYOCwNCj4gKwkJLnBhY2tl
ZCA9IHRydWUsDQo+ICsJCS5icHAgPSA4LA0KPiArCX0sIHsNCj4gKwkJLmZvdXJjYyA9IFY0TDJf
UElYX0ZNVF9TR0JSRzgsDQo+ICsJCS5jb2RlID0gTUVESUFfQlVTX0ZNVF9TR0JSRzhfMVg4LA0K
PiArCQkucGFja2VkID0gdHJ1ZSwNCj4gKwkJLmJwcCA9IDgsDQo+ICsJfSwgew0KPiArCQkuZm91
cmNjID0gVjRMMl9QSVhfRk1UX1NHUkJHOCwNCj4gKwkJLmNvZGUgPSBNRURJQV9CVVNfRk1UX1NH
UkJHOF8xWDgsDQo+ICsJCS5wYWNrZWQgPSB0cnVlLA0KPiArCQkuYnBwID0gOCwNCj4gKwl9LCB7
DQo+ICsJCS5mb3VyY2MgPSBWNEwyX1BJWF9GTVRfU1JHR0I4LA0KPiArCQkuY29kZSA9IE1FRElB
X0JVU19GTVRfU1JHR0I4XzFYOCwNCj4gKwkJLnBhY2tlZCA9IHRydWUsDQo+ICsJCS5icHAgPSA4
LA0KPiArCX0sIHsNCj4gKwkJLmZvdXJjYyA9IFY0TDJfUElYX0ZNVF9ZVVlWLA0KPiArCQkuY29k
ZSA9IE1FRElBX0JVU19GTVRfWVVZVjhfMVgxNiwNCj4gKwkJLnBhY2tlZCA9IHRydWUsDQo+ICsJ
CS5icHAgPSAxNiwNCj4gKwl9LCB7DQo+ICsJCS5mb3VyY2MgPSBWNEwyX1BJWF9GTVRfWVZZVSwN
Cj4gKwkJLmNvZGUgPSBNRURJQV9CVVNfRk1UX1lWWVU4XzFYMTYsDQo+ICsJCS5wYWNrZWQgPSB0
cnVlLA0KPiArCQkuYnBwID0gMTYsDQo+ICsJfSwgew0KPiArCQkuZm91cmNjID0gVjRMMl9QSVhf
Rk1UX1VZVlksDQo+ICsJCS5jb2RlID0gTUVESUFfQlVTX0ZNVF9VWVZZOF8xWDE2LA0KPiArCQku
cGFja2VkID0gdHJ1ZSwNCj4gKwkJLmJwcCA9IDE2LA0KPiArCX0sIHsNCj4gKwkJLmZvdXJjYyA9
IFY0TDJfUElYX0ZNVF9WWVVZLA0KPiArCQkuY29kZSA9IE1FRElBX0JVU19GTVRfVllVWThfMVgx
NiwNCj4gKwkJLnBhY2tlZCA9IHRydWUsDQo+ICsJCS5icHAgPSAxNiwNCj4gKwl9LA0KPiArfTsN
Cg==

