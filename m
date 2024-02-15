Return-Path: <linux-kernel+bounces-66319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D9855A45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12F11C247C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD4B67E;
	Thu, 15 Feb 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="llz4kydZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f0fBE9eA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB64A12
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976955; cv=fail; b=h2rhrIzwJ7dh3qQbVTHnPcqtiNblgNR/f6kFTyEnek/Hus63MQgWkAacMnoSBOG2nOZfUCn/CzC4TXvfp+p5zF4njHpCxC3ibvt3F6CVMcgu7ON6vUhcCIJ5J1scoyQU/MUj9SbTF8EFm8J/i6NLBfyWQ1ufM7RZAEIpTlJYKLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976955; c=relaxed/simple;
	bh=kwbilpqRQO3dJCelqmY+rT6DPxEhrCLlmogWk7KTtgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlIgiiBb9TJNo3+nXEi69nuv2YRtLblS0+TQwt3FYwkMkDgKrmwnGi4cP0A5SPsSSli3rYnXUQFcHFaG6OJtx0GNm4iZiP+Hz9qswNS92pxaRfl/DsECE9j7/MKqsH38LNCudoH32URTeUBsHE5bvszHJ2h7EHnBXXwj3PLL4Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=llz4kydZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f0fBE9eA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ca7f3c64cbc711ee9e680517dc993faa-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kwbilpqRQO3dJCelqmY+rT6DPxEhrCLlmogWk7KTtgI=;
	b=llz4kydZbxnkXBczV5QuvDrSlFfGRb/c3acGHNXsM3XmeMLvoqN0DIXZqoxBO/d3izSLpFW84whBJWyaRtZpq0nzjJajEFmzdLuDy1/NMj/nZpMyp0+ADSNjREzJGWRERytlMyaEdPOqssSE/qQF47nG0nOeKRITo0lT/OH7GTo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2752bcba-cd26-44cf-aa54-60073fff433c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:8cd86880-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ca7f3c64cbc711ee9e680517dc993faa-20240215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 181358933; Thu, 15 Feb 2024 14:02:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 14:02:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 14:02:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWEBnWdVMi6TBBXfYasahuJrq5vFd/Ay0GZmLHnbw3rlk/adtzDU3eYHZwBAraDXvwB2uOcORGYWBtaAlJPlk/6/JiNIMSDzYEPp8i3sDfyuem4FOtsx0TkEUlFoR3uuXU7Cw0kJY2xwTRnzeEAZ/COzLyzxYx8t98ZR5kifNcUS+Ew/xauAw18tDfmesz8YUYTQsDQXNXH45Bk1s+JkvulyZf8NJIT7iuC7N/Xbsl2Lcs5w8rL2Dz0uFQbBlJyRU4FNpcSUkLBKN8mHG5SkItXBINmF1aLCAY0r+wan82UnPz9CTGXmihELuENzxrurjoH2H0yYApGeQVqbJUI3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwbilpqRQO3dJCelqmY+rT6DPxEhrCLlmogWk7KTtgI=;
 b=QvKn3QbaMCBIhOatIJMexOzcFgj33iXdbIMMI8+8GVBBcW/qaUZUOAYh3jA2pHVLXQl1werO8NbMbXvH+8GrYFv+ymDQzS79hU/GqyNPVZzA4g6exXE7kpFcxX+jdODsotnyjgu1sIk6YM3G0LYQ9bStottLI4GznxvYfBL9ctKBViNzTBd3vsyUS3+XDHDykvgPTFO4wCGFmGNDtRFjuAafBEAYJfDAfSB29hBXkgRjRJTCLwU2zg6dyGtdJq++NSgYjmULarOoTxZncfIRp7lVu4l6fcAxB43/comeuT4upQAefTxE0wH23SUl2fKO8v2ap7dILgtsDAlfdXU5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwbilpqRQO3dJCelqmY+rT6DPxEhrCLlmogWk7KTtgI=;
 b=f0fBE9eAtzI/9UZ0cFxR1mcgN9AyWMhuClYxXNc+qIRBsa88AKdMWGG4nmQK9GxDJ1yGDlprQrpUBDQCVi6eBUcbmldRWiU82Oxo+50UcTi16GWD1peqEnmRpjsTPLfQtxgAam5ftdqQzTWGcYr9nk+jnWjoJpD7AyxRMC93tBY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8525.apcprd03.prod.outlook.com (2603:1096:604:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 06:02:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 06:02:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 1/9] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
Thread-Topic: [PATCH v5 1/9] drm/mediatek: dsi: Use GENMASK() for register
 mask definitions
Thread-Index: AQHaWdV2upYdHfYi/Uy4HMDaqqXgBbEK9WaA
Date: Thu, 15 Feb 2024 06:02:20 +0000
Message-ID: <ed036e1dcaec3c050da07e42483e3747b06c6cda.camel@mediatek.com>
References: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
	 <20240207145307.1626009-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240207145307.1626009-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8525:EE_
x-ms-office365-filtering-correlation-id: 7e039c74-800d-4d2e-31d2-08dc2debabdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3AGniQXmDUHkakppFK8NL2ybtcEmGAbYkTr6+CEhiGfy+olk1ZmDDVvGs1J1qIOIBWmfxoJFzPFYM+j1Zplu7PM62AakX4RxqCfZuq76GOJ5UAZoLVxZCbQwUgaQTxzzEk2Zp62pXmUIZFgkTWhZn1b1lonQk1tlPVN74YOb5fjcNlZ5iClKcfbDcRVKTgjlevaFnxb2PDHHHS6VZoFGsDeOYtxMwg1tRjCgiXsoNB6K4mP8LUtUbMjP2c56Xeh2mTIItUwhSs2ImcmL3haFuBkCc6ggv596mVMKKnw21Y2mvniMNEMQnSdygh2/U0xPMyyRJ4FwA1ukMFYzqxUU32hu/rxQD9Q35SsJUtD+TaJ929Agx+OTzFoBGq8/ddVoXG4URkAQOiNEOvB4RiGXNUE0T4BxbiNA/ODmDT1D+Kbh6uPHPOi9YBqJwbLnHGroxI4fYmHM430quF1E3QxlW3jMtc8bP5F1cwHQqpm3s8AUdaDdKr7io/tSTCeZXRBRenq3F3ijOHHwu5Wb9dT1Tsa+m4IiuhId0V2LCed8oApiDdtjcontzV1i0cwQY/KPqsTXD1ACT/riF+EH+Er1/fBU/JYOCNhhBFd9I12QOKHKRVN0UlqB3GPPaUwraxY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(26005)(122000001)(2906002)(38100700002)(8676002)(4326008)(8936002)(7416002)(76116006)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(6512007)(6486002)(6506007)(41300700001)(316002)(54906003)(71200400001)(38070700009)(110136005)(36756003)(85182001)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWVlZmpzZ3ROSVoxaHEyWklET1FhM3VRbkVNN09QUlNReXU1cHBVcUo5RTBF?=
 =?utf-8?B?MDVvaWNUQWRWRjBMenFBN0dBTWhHY0tqdHoyM1JZUnRBSU5zVlc2T2Nua3B3?=
 =?utf-8?B?NGVBa3ZDVm5DQWp5SCt5Z21MR0FsSnBzV1R0NWFKbHBTVEdjVE5YMUdRbDlP?=
 =?utf-8?B?dFFnbGdIR2F4bHBEK2FzT3Z1WU1hZTNRQms3aGNhWmpSbWpHUmpVSzFzdjV2?=
 =?utf-8?B?d1I1MUNDTkdWb1YwdTJSRnZ1Nld4VVlSR0NUeDB3b0owYTdJR1hKOU04cXBW?=
 =?utf-8?B?T3F2dWl2aVJFSHZ4ZVlNdmNMb3BsZllPcmpPL1cxaUhqSDdaY2x3NHhNczNp?=
 =?utf-8?B?WU95VzRoYVJpS1FGTGZtdkY5NHRYdzUvdkdjU3VaUm1ITk5CeUtaaXhtam90?=
 =?utf-8?B?WU9nUmQyMndJNG4zaG9icnZ5Y1V5aUpPamFjTXNZdzJoZ29DNkQzMjM1VjZG?=
 =?utf-8?B?QVBqOVphSDBLOE9OR2daL2l4S1BmdTF0L21BNCtLbUJLVXpKbU5hclh3bllh?=
 =?utf-8?B?TkhIM2YrS043bUZmWEc1Qm5kR2x2ZnVEcTd1N25nSXNRN3RhbWJncW56cGYw?=
 =?utf-8?B?MmNSTjBkMGRMb3JjMW1Wa3BkNWNuWmt2amNXU3NlL1VHbnB4bzVRcFUwOEJQ?=
 =?utf-8?B?Ym1JNmpxWVdIVTBjZTlJTndTbUtGRlBhY0JONUpKZW9pWU9ZNGYwQzNhT2lJ?=
 =?utf-8?B?L0M5VGhnaXI0dDI3ai9vU0h2Z09leXlBWFp4dWlRZmk2TWY3Z0JabDVtbklO?=
 =?utf-8?B?Yjd6NEdiUWZ4dVU2Z3JVRDc3dGhEdGorUHR3dE5HOE9tQkZoZ0d0WEFJVTVQ?=
 =?utf-8?B?TVM5cXBNT2Z1UFgzek1OYTZmTW1WS1RqaTBCdGtobWVxQmUzYnNkeGNwdHE0?=
 =?utf-8?B?OWtQTnpRSVdDRW1IeUtLUFM3TXlzOVZDeGQ0czdLM1RZdU53eFQxQ1JpbGUx?=
 =?utf-8?B?NDFOdFlycWlkb2pEbWxKc1d4NWl2Qms2V0JxNXJXUHNrdlZsYmYzNjArOE9l?=
 =?utf-8?B?bW9iZXQzT2JybWdnd2c3VFZOZUNkOUljcDNaT1ZIMmZRZldjRHo0RjNKTHJr?=
 =?utf-8?B?UTJ6d3NaUUhaOGRRemwzM3JDdU5nTlljQW5YMlMxdUh4Q1BtN0FhYUxLS3Rp?=
 =?utf-8?B?ZmkxMjVhK2c1dGl5TmdRWkdYSkZTVWRKQnlBb1lpS0lTaUVBUW02bldzRWRm?=
 =?utf-8?B?dDg3MVFFMkY2M0Q4bTcrdUgxZFR0Q2FyeTY4WG14OHgyT0p1YURhWDUyTkpG?=
 =?utf-8?B?MFhRVFBlejFxcVhjK3d6aDcvZU1sS1cyd1BXUTVrdGxpdDYzL0hkS01sZXlP?=
 =?utf-8?B?UHQweURnazBlV09aQUE5S3hBY044cytBM2U2RGN6QWtJanFiTlhHWXE4ci9G?=
 =?utf-8?B?QTk4anFqK3oxUlQvNC9BMU5zUUptV0lGUHk3d0hTVWJBWjNGQUtqM2tyREQw?=
 =?utf-8?B?WDRhVGNGWkYrQ3lRL3orYlZnOHJlekY5R3hmZFVVekE2YWJKOFVnRkorUGRt?=
 =?utf-8?B?blVpVnBFRHdoUHh3K1dCSXpENU9DRUg3QkdHUjdkbzc2Z1psOGJibmpKbVhZ?=
 =?utf-8?B?S3l2dXg3MEg4REk4VjFFMW8xbzlhOFRJNVhmTGg4dDV0cHNNV09GMXRMRk8w?=
 =?utf-8?B?RUdRMEg4Z0hOSWhhWE5ZQ3pseUJ2R2RTcjhGK21YdTNqVWxxV2IzUkJlQkZU?=
 =?utf-8?B?VDA4TUZFL2VRZzc0Y1BEYUV4M0w1ZlVjbWx2aHQ4Zjc1Q1NCTFdJbVRtcXRY?=
 =?utf-8?B?UGlSVnJmdTluUGxnajF0eE5vN2EvazBaNE1zVlc1dTJLVTBmeUpUZzJyY0gx?=
 =?utf-8?B?VWd6U0d6STFaeDVLcEg0TFJzUHVBbm1nemFwUndNMHJGN01IVE5abkwvdGdH?=
 =?utf-8?B?UkhKUEl2MFliSjBnZmZWR0hib3pYaTlCMHBpKzhSWjVaeitlNSt4eFlRRFFS?=
 =?utf-8?B?U21LVW5IeElLUW52cytzWUI5eS8vcUd4bkZiei9lUmhMS1J5SkR3TDJaOTYw?=
 =?utf-8?B?VHdSQVVBQ3kvd0wvRDdNSWRPU3hPdVBRUkF2akY5dUM2NXJoOEs3eWpQQnZz?=
 =?utf-8?B?VVN6RE1MV2M4Q2tiYXZYVGlLUGZsWS81L2FUdWZkS2lvTms5amFkNzJWQlY4?=
 =?utf-8?Q?nJ8ZI2LegMAdxNea/5pcpIEND?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B522BF3D0910F04DB12132E1B2B93E8B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e039c74-800d-4d2e-31d2-08dc2debabdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 06:02:20.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16lV5zQXtwjQgtywQ5je3RLFsd85IR4kK05xh+8o/X5cpBAel0CRl6Pv73odoxQ4b0RwKE1hZzor2ydItUa8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8525
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.389300-8.000000
X-TMASE-MatchedRID: 7ySqCuYCpfjoSitJVour/fGG8F2k2BBVYefZ7F9kLgsNcckEPxfz2Iu3
	renu5Y0wGvX6HjFuUyf4exig1DmiESUtdpGicV4RA9lly13c/gGuiRuR9mCauk1KG1YrOQW/Qkz
	RZrI7fzZRzOYs2dj5zLUeXVaVYVhISSOWVJeuO1DSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq
	5d3cxkNW77KDBx5uGIW+boqkaQiM2k3T/90rcYw0olSaZ7dmBfBw+VPDwHksc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.389300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C13345D521483AF736BF2FFD7A67420308B26981ABCE19AE6070E05A2D94B9B52000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAyLTA3IGF0IDE1OjUyICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gQ2hhbmdlIG1hZ2ljIG51bWVyaWNhbCBtYXNr
cyB3aXRoIHVzYWdlIG9mIHRoZSBHRU5NQVNLKCkgbWFjcm8NCj4gdG8gaW1wcm92ZSByZWFkYWJp
bGl0eS4NCj4gDQo+IFRoaXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdl
ZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYyB8IDQ1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCBhMmZkZmM4ZGRiMTUuLmM2
NmUxODAwNjA3MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
c2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC01
OCwxOCArNTgsMTggQEANCj4gIA0KPiAgI2RlZmluZSBEU0lfVFhSWF9DVFJMCQkweDE4DQo+ICAj
ZGVmaW5lIFZDX05VTQkJCQlCSVQoMSkNCj4gLSNkZWZpbmUgTEFORV9OVU0JCQkoMHhmIDw8IDIp
DQo+ICsjZGVmaW5lIExBTkVfTlVNCQkJR0VOTUFTSyg1LCAyKQ0KPiAgI2RlZmluZSBESVNfRU9U
CQkJCUJJVCg2KQ0KPiAgI2RlZmluZSBOVUxMX0VOCQkJCUJJVCg3KQ0KPiAgI2RlZmluZSBURV9G
UkVFUlVOCQkJQklUKDgpDQo+ICAjZGVmaW5lIEVYVF9URV9FTgkJCUJJVCg5KQ0KPiAgI2RlZmlu
ZSBFWFRfVEVfRURHRQkJCUJJVCgxMCkNCj4gLSNkZWZpbmUgTUFYX1JUTl9TSVpFCQkJKDB4ZiA8
PCAxMikNCj4gKyNkZWZpbmUgTUFYX1JUTl9TSVpFCQkJR0VOTUFTSygxNSwgMTIpDQo+ICAjZGVm
aW5lIEhTVFhfQ0tMUF9FTgkJCUJJVCgxNikNCj4gIA0KPiAgI2RlZmluZSBEU0lfUFNDVFJMCQkw
eDFjDQo+IC0jZGVmaW5lIERTSV9QU19XQwkJCTB4M2ZmZg0KPiAtI2RlZmluZSBEU0lfUFNfU0VM
CQkJKDMgPDwgMTYpDQo+ICsjZGVmaW5lIERTSV9QU19XQwkJCUdFTk1BU0soMTMsIDApDQo+ICsj
ZGVmaW5lIERTSV9QU19TRUwJCQlHRU5NQVNLKDE3LCAxNikNCj4gICNkZWZpbmUgUEFDS0VEX1BT
XzE2QklUX1JHQjU2NQkJKDAgPDwgMTYpDQo+ICAjZGVmaW5lIExPT1NFTFlfUFNfMThCSVRfUkdC
NjY2CQkoMSA8PCAxNikNCj4gICNkZWZpbmUgUEFDS0VEX1BTXzE4QklUX1JHQjY2NgkJKDIgPDwg
MTYpDQo+IEBAIC0xMDksMjYgKzEwOSwyNiBAQA0KPiAgI2RlZmluZSBMRDBfV0FLRVVQX0VOCQkJ
QklUKDIpDQo+ICANCj4gICNkZWZpbmUgRFNJX1BIWV9USU1FQ09OMAkweDExMA0KPiAtI2RlZmlu
ZSBMUFgJCQkJKDB4ZmYgPDwgMCkNCj4gLSNkZWZpbmUgSFNfUFJFUAkJCQkoMHhmZiA8PCA4KQ0K
PiAtI2RlZmluZSBIU19aRVJPCQkJCSgweGZmIDw8IDE2KQ0KPiAtI2RlZmluZSBIU19UUkFJTAkJ
CSgweGZmIDw8IDI0KQ0KPiArI2RlZmluZSBMUFgJCQkJR0VOTUFTSyg3LCAwKQ0KPiArI2RlZmlu
ZSBIU19QUkVQCQkJCUdFTk1BU0soMTUsIDgpDQo+ICsjZGVmaW5lIEhTX1pFUk8JCQkJR0VOTUFT
SygyMywgMTYpDQo+ICsjZGVmaW5lIEhTX1RSQUlMCQkJR0VOTUFTSygzMSwgMjQpDQo+ICANCj4g
ICNkZWZpbmUgRFNJX1BIWV9USU1FQ09OMQkweDExNA0KPiAtI2RlZmluZSBUQV9HTwkJCQkoMHhm
ZiA8PCAwKQ0KPiAtI2RlZmluZSBUQV9TVVJFCQkJCSgweGZmIDw8IDgpDQo+IC0jZGVmaW5lIFRB
X0dFVAkJCQkoMHhmZiA8PCAxNikNCj4gLSNkZWZpbmUgREFfSFNfRVhJVAkJCSgweGZmIDw8IDI0
KQ0KPiArI2RlZmluZSBUQV9HTwkJCQlHRU5NQVNLKDcsIDApDQo+ICsjZGVmaW5lIFRBX1NVUkUJ
CQkJR0VOTUFTSygxNSwgOCkNCj4gKyNkZWZpbmUgVEFfR0VUCQkJCUdFTk1BU0soMjMsIDE2KQ0K
PiArI2RlZmluZSBEQV9IU19FWElUCQkJR0VOTUFTSygzMSwgMjQpDQo+ICANCj4gICNkZWZpbmUg
RFNJX1BIWV9USU1FQ09OMgkweDExOA0KPiAtI2RlZmluZSBDT05UX0RFVAkJCSgweGZmIDw8IDAp
DQo+IC0jZGVmaW5lIENMS19aRVJPCQkJKDB4ZmYgPDwgMTYpDQo+IC0jZGVmaW5lIENMS19UUkFJ
TAkJCSgweGZmIDw8IDI0KQ0KPiArI2RlZmluZSBDT05UX0RFVAkJCUdFTk1BU0soNywgMCkNCj4g
KyNkZWZpbmUgQ0xLX1pFUk8JCQlHRU5NQVNLKDIzLCAxNikNCj4gKyNkZWZpbmUgQ0xLX1RSQUlM
CQkJR0VOTUFTSygzMSwgMjQpDQo+ICANCj4gICNkZWZpbmUgRFNJX1BIWV9USU1FQ09OMwkweDEx
Yw0KPiAtI2RlZmluZSBDTEtfSFNfUFJFUAkJCSgweGZmIDw8IDApDQo+IC0jZGVmaW5lIENMS19I
U19QT1NUCQkJKDB4ZmYgPDwgOCkNCj4gLSNkZWZpbmUgQ0xLX0hTX0VYSVQJCQkoMHhmZiA8PCAx
NikNCj4gKyNkZWZpbmUgQ0xLX0hTX1BSRVAJCQlHRU5NQVNLKDcsIDApDQo+ICsjZGVmaW5lIENM
S19IU19QT1NUCQkJR0VOTUFTSygxNSwgOCkNCj4gKyNkZWZpbmUgQ0xLX0hTX0VYSVQJCQlHRU5N
QVNLKDIzLCAxNikNCj4gIA0KPiAgI2RlZmluZSBEU0lfVk1fQ01EX0NPTgkJMHgxMzANCj4gICNk
ZWZpbmUgVk1fQ01EX0VOCQkJQklUKDApDQo+IEBAIC0xMzgsMTMgKzEzOCwxNCBAQA0KPiAgI2Rl
ZmluZSBGT1JDRV9DT01NSVQJCQlCSVQoMCkNCj4gICNkZWZpbmUgQllQQVNTX1NIQURPVwkJCUJJ
VCgxKQ0KPiAgDQo+IC0jZGVmaW5lIENPTkZJRwkJCQkoMHhmZiA8PCAwKQ0KPiArLyogQ01EUSBy
ZWxhdGVkIGJpdHMgKi8NCj4gKyNkZWZpbmUgQ09ORklHCQkJCUdFTk1BU0soNywgMCkNCj4gICNk
ZWZpbmUgU0hPUlRfUEFDS0VUCQkJMA0KPiAgI2RlZmluZSBMT05HX1BBQ0tFVAkJCTINCj4gICNk
ZWZpbmUgQlRBCQkJCUJJVCgyKQ0KPiAtI2RlZmluZSBEQVRBX0lECQkJCSgweGZmIDw8IDgpDQo+
IC0jZGVmaW5lIERBVEFfMAkJCQkoMHhmZiA8PCAxNikNCj4gLSNkZWZpbmUgREFUQV8xCQkJCSgw
eGZmIDw8IDI0KQ0KPiArI2RlZmluZSBEQVRBX0lECQkJCUdFTk1BU0soMTUsIDgpDQo+ICsjZGVm
aW5lIERBVEFfMAkJCQlHRU5NQVNLKDIzLCAxNikNCj4gKyNkZWZpbmUgREFUQV8xCQkJCUdFTk1B
U0soMzEsIDI0KQ0KPiAgDQo+ICAjZGVmaW5lIE5TX1RPX0NZQ0xFKG4sIGMpICAgICgobikgLyAo
YykgKyAoKChuKSAlIChjKSkgPyAxIDogMCkpDQo+ICANCg==

