Return-Path: <linux-kernel+bounces-165935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D58B9399
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C63B20EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1E1AAD7;
	Thu,  2 May 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ve5t+D2w";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RV1WGeZ0"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADB14292;
	Thu,  2 May 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619433; cv=fail; b=PyIDWTS3ttzOyyXQ0KLHu/jHeqNTXt64vYFKIGM5/3JocVxNYSgjEz4BMtVvL7FwJqnnXL8nQUWA87TRMsRt/DQ2sPufgsovy/zHb8cZs5QgeKYoHoIkzA3QvJZREh3H9CuyKfufXD4kKacC3RCiQPQ+3aovvyqwvszUB8OTAuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619433; c=relaxed/simple;
	bh=RkURepAiTBbswo2FKVZ7oH17CJKZrj5R3627Ow8abLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CehdWb6AYz7BBBWRMdk6qEhBsjl34EqORRwa9Kag3aZ6leQcgsNwMR1YeqMkLKZKIM9+4o6cVyJ1a7J42FnCh2hQ5rNVIoURiE0TND39XspHWf1cknLRBYbJLCrq3i+wDrn8FDoUke3w1XWh3XhzNy+wmaO/M2CrF6jikgnz5GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ve5t+D2w; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RV1WGeZ0; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 86709594083111efb92737409a0e9459-20240502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RkURepAiTBbswo2FKVZ7oH17CJKZrj5R3627Ow8abLI=;
	b=Ve5t+D2wu8xX4a/tiUyWZLPaKHDV/4lhUszCk2S5SR2TdTqyncdLbjEkM2E/2i0wbvGBI3LXjybjQ0tCEy5YsLDtkZqoHZDVevKHfANk+hXWPvtWEDcJASoICFfB6cLVYMOyscrBvJm0PEpMjOXrzd/lALs4cIzLLSRg/tWVkxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:67707b2e-f67c-496b-aa2e-26a8c19b96ac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:16325983-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 86709594083111efb92737409a0e9459-20240502
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 141310031; Thu, 02 May 2024 11:10:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 May 2024 11:10:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 May 2024 11:10:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgx2i8UzydeLSU8ToP986ZSfDEpVW5IAKhKdCJLmUPFEmi/JjXVy2UWvaf5+hKT3ZddJQtlF+99U6zoXcCqeOt1O1FOTapFklglFXH345vNidmwCgC+pntujYnMvYTOTAsVSXoBRVTUCjUzXtFNC4RjV317ojwIACro2uy5spHICjx5zWblTU76UVJE+uk7HewEWmfV0rD70qljfZ6EsRhOowqLvXTJ09fgcOwjxA/kYy5DVBRHFDwrYa7S9bASJgLc5kFKv2HPC4XmkLFr3BSNarQ5GIQ4NxpqkkaWPF8U/ARtLjQULiWtLvJ+6JD2JNWXkzl7eUAOUXN2xPAVu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkURepAiTBbswo2FKVZ7oH17CJKZrj5R3627Ow8abLI=;
 b=OX2Ddujfnb2E9PHeQLDaB1Bt7f2/QVPZd0BokAvh9JaToArEI6wsOv9JsRMS+uDZeF147MZsaUwP2DtQRvzqL1NYd7cuZm2parkd+Cjytvw22GQV+52iAWKxK6PFzWm7bZFLK+p+2GadwjdFhdjE5B0mEEVse+iS2Y7fYATGVG7lurBCAIhX1hkwtSUbgPSHh4SLcrOg6DfH9UuyswmbpggOFjj6GEU2SG9vYkP3n9L9NhQJM0+j4G+pnSd+Oeg7YdUzG5C3pMrVPFJYVl+TVdJDwjk4OQmW4TJPTwugFCb9KnIs+OxFZTndV6TNJMAxL04+HWNzYEPMfqnwzIKDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkURepAiTBbswo2FKVZ7oH17CJKZrj5R3627Ow8abLI=;
 b=RV1WGeZ0MGdN/IcvRVBzVFWR8DqmjeG71jonMrg207gf0+/Ec9Bno32IxdGDz8djdBrrcwHq6nq5XklVA39VA2rBUL2Pyfa2bT/yaS5mZOFGfoL3etYkfUskipt03eWxCe/7Q+zbX6BzeQieXqs+CwIcFheNlj0MiiD3L+yrPIM=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by JH0PR03MB7716.apcprd03.prod.outlook.com (2603:1096:990:16::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Thu, 2 May
 2024 03:10:24 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a%7]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 03:10:24 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Thread-Topic: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Thread-Index: AQHal6xCZTDOyK83d0m4QJA7T219GbF+aQGAgAEyugCAA7F4AA==
Date: Thu, 2 May 2024 03:10:24 +0000
Message-ID: <661f101456506db945ccbd94700a0f47b95f91e5.camel@mediatek.com>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
	 <20240428202837.0cabca17@rorschach.local.home>
	 <20240429144626.7d868ad3@gandalf.local.home>
In-Reply-To: <20240429144626.7d868ad3@gandalf.local.home>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|JH0PR03MB7716:EE_
x-ms-office365-filtering-correlation-id: ebf94aab-b6a4-4b0f-a610-08dc6a55691d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NkhwcHNpM0FsUHVaekZtY1lZZjc0YjdGZ1FSMUhETjJrNE1qanhMVUJRUUlX?=
 =?utf-8?B?SmFPeXpxMUErYldCK2JKeTFXOHo5WTVPakdvcW9STy9Sa1pzYm9JYXRXdW1x?=
 =?utf-8?B?ZXhETFJSeE5BZ3ZvbC80QWpta0lKa1RSbFN5ejBPeGZndHMvZ1hJbllPZ3BX?=
 =?utf-8?B?S0UwUnFlcjRyU0pWZVVwTktQQ2cvNXE4M0ZRcmw4SHJ5MTQzcDBDY1JQenJM?=
 =?utf-8?B?dlBrMk5CcWRTVFdDbjVPVXB2eTF1MUJWU0VYUHR6aklackorTU5LWlN6MWdD?=
 =?utf-8?B?T0tvY1Q3b2tLcUNRQmpJYlg0b3lCRFZsL2VpM2dudDcyMzJJMUJMUmVpNlJw?=
 =?utf-8?B?aVVxM1dIU2Y1UWlFZW5pa2lKb0tiUTJ2L0FSTUQ5WVREakJTU1hVOGtwQlhQ?=
 =?utf-8?B?NWxXcjd3c1ZobUF1UnZkRFVScGhwcXpoc0VKMHcybXVzL0lsU2VqZ0VLWEVa?=
 =?utf-8?B?a3RNYjR2eVQvYWFZK1Q3VTFXWjFNTFdjblZLYnRsUlV2T2hwSEJtaUtLbHNO?=
 =?utf-8?B?ZElkRGswbjZmc3lVOWJId0tFRmNiS3c4OUJTeTFpVTZlRmc0dUV6dzl0b3F1?=
 =?utf-8?B?QXNEcDd3MkJkUjhUZ2dIL0x3bXYyVCtPV0psRnhBdTF4UjlRTzlWWnFTYitZ?=
 =?utf-8?B?bjBGRTNxOENHNGROMkw4eWtmVmgrL0dCNlZncnZzYndxNlkzbzUrVFNnQlVL?=
 =?utf-8?B?OFhadEtJVE1OZkc3bHppNVNORGhvbit1ZXViY1BEYjhkaFFQMUkveFFTcVRz?=
 =?utf-8?B?akR1VnUycnRQYW5zanNxNy92Y05VR1U4NzhTV3ZvakU4Umw5TEVUNnIraGFL?=
 =?utf-8?B?V1hScnJvY0phblpJYm9TMDI3MTFJdGdYNzZDb1NRNDk4SG9Mc0psdmNtYU0r?=
 =?utf-8?B?cnJFNG12U3JHOWNxMERJVmVQUHN1TWRSS2FYTkVjU1BDQnZCS0VpNVpSR3FI?=
 =?utf-8?B?eU9lYVgrVUFPd3BJSXJaeVJYUVNncDlvNmJ6dmo4RFZtNXlPTFRxM2JhZGZk?=
 =?utf-8?B?UiswWE0vRjVDSGxNMGtrcm9zMCs0QnlhdmdjRFB3ak44alVFeTVzSEZUbThB?=
 =?utf-8?B?QnBMdTR6SkFNMWltT2I3RDdjajVEeS9kaUdBNnBOSXViUjhrRU83cGlnOWpn?=
 =?utf-8?B?dzFCM1RhSWZ2WTVCNjNZYjRlK3dXRFNVdWxmaXAwR1lJRHlOMlpRMHpsYnJM?=
 =?utf-8?B?U285QTBlMEk5dHhGSmQ0b0I2QnBMUko4VHFWajRHR3dad01USmVYaDRqVVVi?=
 =?utf-8?B?ekZmalpGNzlFTkRQTGlHcG5hYzBvZlJGUkdpUVZWU0JlbllkaVZ1LzlGTHZn?=
 =?utf-8?B?WGo4Vkdhakx3aEc1b2tGSkI1c1IzLzNJcXYxdTU3UXAxL0Z4Qk4rb0lEb3k5?=
 =?utf-8?B?WEk1ZmRaMlAxWkdYTE1MOXFQdXZvNUJnbmJNUk1UZVYyTTc3T1g1ZWs1MlRF?=
 =?utf-8?B?TmhZZGU3WjhhYWxzTzlZQmYweHZSZHVqZDBQcUdNZVNvc1RVb1B1Q2ZhRUtD?=
 =?utf-8?B?QlU0eERIWXg4RnI2aXF1OGVKcjhXQitLaWxpU3RaeEVvVEN3VGJOQmpCNU80?=
 =?utf-8?B?alFOY2ZyOGZwWjlGK1dYTVpxdkxLaUtRcW8yL21jTVJGWkgrdFlKNENweU1U?=
 =?utf-8?B?WlEzZWpVVURtTm50SlZhS0JIV21taUhtQUovYW45SGMvWVdvcE5rYWo2M2NW?=
 =?utf-8?B?WTlBQXJ0SlJmWUdoRlpOeFo1UzI0VWJ0U0pqNEcyNWhZUkg1MHRLbFYyeGR0?=
 =?utf-8?B?QnNtenNtMU9MZGZQNmpoVThzRExJWk9aZ1ljQ2F3TVZOMHd3c1UwWENjKzBM?=
 =?utf-8?B?ZHJ1cDgydHl1RHZOcWtodz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BrdUJBY3M0amVTQlZCN3h6Z290bE52amFXTUZYQnFRYUxlbE02cEZGeGFQ?=
 =?utf-8?B?OGM5YkNsY3kwL1J1VW4wQXM2R3hDRHdodCtzZkdObSsvSmR2UEsrcGcxK0NW?=
 =?utf-8?B?SGNHRmxCNmErNTJOR3Jub0d6eXpXSzRtUDYzZnlkenE1MGZ2cjQ4cWlydEtp?=
 =?utf-8?B?bnM4STBmRXQ2ZzM0QnRTdVNPbWREQVRjU3VSRjdKMnFQUHJhQTZ4OGZJUWxI?=
 =?utf-8?B?YzBZZ0IrZDJlREpqT0dQazNqbm9uUXFud05TUTl6TTVyVVpvN2lGd29hWlRj?=
 =?utf-8?B?UTlxYjFVdFBTQlRLRG52c3ViZ095MkhYRnliYVJzTlZyN3RtdlJjT1YyMGhK?=
 =?utf-8?B?UExvRGdsby9ENW9CQTdNTy90Y3Bva0NCQ0U3K1RHaHZWQ3NMUkVESFRLcUd3?=
 =?utf-8?B?alZ1Mkh6TmNGMUd2WTZ1L1FVVzE2ZFJ3N1VHYlR3bjlJT2M2WFhuVFp1eUdv?=
 =?utf-8?B?ZUxjSHJSanVEeXQ5eVFOcURPL3lMSVRlWW5uaG5IS2ZFZFlDNG1zVHBvdXY2?=
 =?utf-8?B?M3BXVVF1YXhaYXBjMUdXSHozNzZyb0lyd05JUVVmcENENWJrblRRQVpnNzd1?=
 =?utf-8?B?c3U4RXIyR2JNcnFvcCtsbkdmR1VlblBndUE4bXVpcGN5MEh3dFVURzZ1UElO?=
 =?utf-8?B?dFlzcGc5VzBpbTJINTlGejExMkIzcmh1VjRYUkp0QWVpbE0zY2lVbFE2UnA0?=
 =?utf-8?B?WDhnK1MyRDlQT1dJSDZaS1JwaUhHbW9WR2c2VHowY1NQRFRRQXpiUFlLWWlq?=
 =?utf-8?B?bzloOWlqQzZIRlkvVnd3TmJJaXl1a083VEFEMGxNSlN3cC94bDVoR2cyUHhm?=
 =?utf-8?B?elFjZ3EyejNQWWF6TnpScXpYcHhHYlNtWGhRcTBWdFc3QXpOa3JGdGo2UEY4?=
 =?utf-8?B?UjFLNlBWaXV2SWFMQ0I5ajJHL3RKejczeENSL3I0YSswckFUS1pZcUI4b2E1?=
 =?utf-8?B?NDFNeTQ3M2xXdExhNTIrYzhMcUViMC82L2phblBVT1JyNHU3bXBtK0kwUmRq?=
 =?utf-8?B?dmZjMG5yU0NlQlhDWDA4OWRhNWxlZ2dKSXlMeUp6citnYmVKRExMTzkrL3RF?=
 =?utf-8?B?U3QzcXF4SWw3d2xRcEtYWGM3bGNUZG94MWZwME1EZWZQYlRsZllNWUlsYW9q?=
 =?utf-8?B?MUU1bExseXVwbjdsb25nR2VVanpmNEFxb1ZnZlY4N3dVTGlRcVpqcHdSQjRp?=
 =?utf-8?B?aEEzbUlscm5SMUsvK2dWM2JKM1VMNitxcHAxK3M0VCtBZzlMclhlMklxMlJi?=
 =?utf-8?B?a2V4bkJjSm0xbWRFU0QrTDVydm1aUUdpWWhCWTFYb2FXRStxT3I4NUZtWW9T?=
 =?utf-8?B?TnVBVGpjUXl0WXdUTkFtSmp6MVUvekRFdGJGNEpGS3pCRkIzT2djZm9SUmxo?=
 =?utf-8?B?d3hMV1NxSUpiVkdob3Y1MGdCamliVVljOHlncjlsSjZ2M0ZMRUgvUmRJNm1j?=
 =?utf-8?B?My9aYnZEblZ6NE45cklwZFZ3VGZCdG4zWlZZZnErMGJCSkg1TWxWQnRScms3?=
 =?utf-8?B?ekovbWhJZ0xmTFUwZCtSYnVkVHBoYnlaWkF3WnFvZmp6QVBlODBmTkY4S245?=
 =?utf-8?B?N2JuY24vSi95Y1h4N244d25GY2lSUGhRcXYvWEppM0x0UHRGYVdPRHBWWUJ5?=
 =?utf-8?B?MHFxTXc4QlREUElZK1lXeGpNQW56Rzkrckpud05GOWVRSk45b1J6YW5haU92?=
 =?utf-8?B?T05kQjJ0YjBaL3dYNDZzMVRwWDhYdW0yeWlpLzJlU1l4d3Uyc0Q4RVRUYy9t?=
 =?utf-8?B?Zkk4OEVWS3JVK0U2YUt5WTk4bTF0VFNBc05SOEJnOC9vQjg4TG9iRFAyakJJ?=
 =?utf-8?B?R1QxZ2VEQzZ6b1V6cU1xbDE3cVFtNmlrQm85YWlndllncWlQWDU4R0hGM3Vq?=
 =?utf-8?B?U2l4dVVPYXA2V1VqWU51RGZVbnV0dzZFdFp3WXk3UERMeTBkd3VLYTBCaFAz?=
 =?utf-8?B?S1Nia3FHWkVUak5xaGg5ZFBJa1dCWEo3azZtc2dyci9Rdm5RakxQMjlxalZv?=
 =?utf-8?B?M0trUm5nQkxjYStMU1dTZk14Sjl5T203M3h0dlBmdE0wNkVuZzZsdFR4TEpz?=
 =?utf-8?B?RHhGUzE3eVp4SytvaU9HL056NTQ2WmcxQndyOE1HWFBEaG1BaXJwa2ltM3Q3?=
 =?utf-8?B?R3ZTbUpBS2FTV3Z3VXpPK0xJZnBDUVF1MVNrNlZJY1pzOHpCeWlnT29ObVc3?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E044F6CE2D4846AA9569B600C9E333@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf94aab-b6a4-4b0f-a610-08dc6a55691d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 03:10:24.7524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb/Qdh4xwodGuP0ekn96BFqoroGbg6KumcZ0PV+HzSSFrjvJP16vMQ/I7FQ55Yx1kDhaCSapE8jvqqRfYLbENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7716

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE0OjQ2IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBTdW4sIDI4IEFwciAyMDI0IDIwOjI4OjM3IC0wNDAwDQo+IFN0
ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+ID4gPiBMb29r
aW5nIGZvciBhbnkgc3VnZ2VzdGlvbiBvciBzb2x1dGlvbiwgYXBwcmVjaWF0ZS4gIA0KPiA+IA0K
PiA+IFllYWgsIEkgZG8gbm90IHRoaW5rIGV2ZW50ZnMgc2hvdWxkIGJlIGludm9sdmVkIGluIHRo
aXMuIEl0IG5lZWRzDQo+IHRvIGJlDQo+ID4gcHJvdGVjdGVkIGF0IGEgaGlnaGVyIGxldmVsIChp
biB0aGUgc3ludGhldGljL2R5bmFtaWMgZXZlbnQgY29kZSkuDQo+ID4gDQo+ID4gSSdtIGp1c3Qg
Y29taW5nIGJhY2sgZnJvbSBKYXBhbiwgYW5kIEknbGwgbmVlZCB0byB0YWtlIGEgZGVlcGVyDQo+
IGxvb2sgYXQNCj4gPiB0aGlzIGFmdGVyIEkgcmVjb3ZlciBmcm9tIG15IGpldGxhZy4NCj4gDQo+
IE9LLCBzbyBJIGd1ZXNzIHRoZSBldmVudGZzIG5vZGVzIG5lZWQgYW4gb3B0aW9uYWwgcmVsZWFz
ZSBjYWxsYmFjay4NCj4gSGVyZSdzDQo+IHRoZSByaWdodCB3YXkgdG8gZG8gdGhhdC4gSSBhZGRl
ZCBhICJyZWxlYXNlIiBmdW5jdGlvbiB0byB0aGUgcGFzc2VkDQo+IGluDQo+IGVudHJ5IGFycmF5
IHRoYXQgYWxsb3dzIGZvciBjYWxsaW5nIGEgcmVsZWFzZSBmdW5jdGlvbiB3aGVuIHRoZQ0KPiBl
dmVudGZzX2lub2RlIGlzIGZyZWVkLiBUaGVuIGluIGNvZGUgZm9yIGNyZWF0aW5nIGV2ZW50cywg
SSBjYWxsDQo+IGV2ZW50X2ZpbGVfZ2V0KCkgb24gdGhlIGZpbGUgYmVpbmcgYXNzaWduZWQgYW5k
IGhhdmUgdGhlIGZyZWVpbmcgb2YNCj4gdGhlDQo+ICJlbmFibGUiIGZpbGUgaGF2ZSB0aGUgcmVs
ZWFzZSBmdW5jdGlvbiB0aGF0IHdpbGwgY2FsbA0KPiBldmVudF9maWxlX3B1dCgpIG9uDQo+IHRo
YXQgZmlsZSBzdHJ1Y3R1cmUuDQo+IA0KPiBEb2VzIHRoaXMgZml4IGl0IGZvciB5b3U/DQo+IA0K
U29ycnkgZm9yIG15IGxhdGUgcmVwbHksIEknbSB0ZXN0aW5nIHRoZSBwYXRjaCBvbiBteSBtYWNo
aW5lIG5vdy4gDQpUZXN0IHdpbGwgYmUgZG9uZSBpbiBmb3VyIGhvdXJzLg0KDQpUaGVyZSdzIHNv
bWV0aGluZyBJJ20gd29ycnlpbmcgYWJvdXQgaW4gdGhlIHBhdGNoLA0Kd2hhdCBJJ20gd29ycnlp
bmcgYWJvdXQgaXMgY29tbWVudGVkIGluIHRoZSBjb2RlIGJlbG93Lg0KDQova2VybmVsL3RyYWNl
L3RyYWNlX2V2ZW50cy5jOg0KICBzdGF0aWMgaW50DQogIGV2ZW50X2NyZWF0ZV9kaXIoc3RydWN0
IGV2ZW50ZnNfaW5vZGUgKnBhcmVudCwgDQogIHN0cnVjdCB0cmFjZV9ldmVudF9maWxlICpmaWxl
KSANCiAgew0KICAgICAgICAuLi4NCiAgICAgICAgLi4uDQogICAgICAgIC4uLg0KICAgICAgICBu
cl9lbnRyaWVzID0gQVJSQVlfU0laRShldmVudF9lbnRyaWVzKTsNCg0KICAgICAgICBuYW1lID0g
dHJhY2VfZXZlbnRfbmFtZShjYWxsKTsNCg0KICAgICAgICArZXZlbnRfZmlsZV9nZXQoZmlsZSk7
ICAgICAgICAvLyBMaW5lIEENCiAgICAgICAgICAgIF5eXl5eXl5eXl5eXl4NCiAgICAgICAgLy8g
U2hvdWxkIHdlIG1vdmUgdGhlICJldmVudF9maWxlX2dldCIgdG8gaGVyZSwgaW5zdGVhZCAgDQog
ICAgICAgIC8vIG9mIGNhbGxpbmcgaXQgYXQgbGluZSBDPw0KICAgICAgICAvLyBEdWUgdG8gTGlu
ZSBCIGNvdWxkIGV2ZW50dWFsbHkgaW52b2tlICJldmVudF9maWxlX3B1dCIuDQogICAgICAgIC8v
ICAgZXZlbnRmc19jcmVhdGVfZGlyIC0+IGZyZWVfZWkgLT5wdXRfZWkgLT4ga3JlZl9wdXQgDQog
ICAgICAgIC8vICAtPiByZWxlYXNlX2VpIC0+IGV2ZW50X3JlbGVhc2UgLT4gZXZlbnRfZmlsZV9w
dXQNCiAgICAgICAgLy8gTm90IHN1cmUgaWYgdGhpcyBpcyBhIHBvdGVudGlhbCByaXNrPyBJZiBM
aW5lIEIgZG8gY2FsbCAgIA0KICAgICAgICAvLyBldmVudF9maWxlX3B1dCwiZXZlbnRfZmlsZV9w
dXQiIHdpbGwgYmUgY2FsbGVkIHByaW9yIHRvDQogICAgICAgIC8vICJldmVudF9maWxlX2dldCIs
IGNvdWxkIGNvcnJ1cHQgdGhlIHJlZmVyZW5jZSBvZiB0aGUgZmlsZS4NCg0KICAgICAgICBlaSA9
IGV2ZW50ZnNfY3JlYXRlX2RpcihuYW1lLCBlX2V2ZW50cywgICAgLy8gTGluZSBCIA0KICAgICAg
ICAgICAgIGV2ZW50X2VudHJpZXMsIG5yX2VudHJpZXMsIGZpbGUpOw0KICAgICAgICBpZiAoSVNf
RVJSKGVpKSkgew0KICAgICAgICAgICAgICAgIHByX3dhcm4oIkNvdWxkIG5vdCBjcmVhdGUgdHJh
Y2VmcyAnJXMnIGRpcmVjdG9yeVxuIiwgDQogICAgICAgICAgICAgICAgbmFtZSk7DQogICAgICAg
ICAgICAgICAgcmV0dXJuIC0xOw0KICAgICAgICB9DQogICAgICAgIGZpbGUtPmVpID0gZWk7DQoN
CiAgICAgICAgcmV0ID0gZXZlbnRfZGVmaW5lX2ZpZWxkcyhjYWxsKTsNCiAgICAgICAgaWYgKHJl
dCA8IDApIHsNCiAgICAgICAgICAgICAgICBwcl93YXJuKCJDb3VsZCBub3QgaW5pdGlhbGl6ZSB0
cmFjZSBwb2ludCBldmVudHMvJXNcbiIsDQpuYW1lKTsNCiAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXiAgICAgICAgICANCiAgICAgICAvLyBN
YXliZSB3ZSBjaG91bGQgaGF2ZSBzaW1pbGFyIGNvbmNlcm4gaWYgd2UgcmV0dXJuIGhlcmUuDQog
ICAgICAgLy8gRHVlIHRvIHRoZSBldmVudF9pbm9kZSBoYWQgYmVlbiBjcmVhdGVkLCBidXQgd2Ug
ZGlkIG5vdCBjYWxsIA0KICAgICAgIC8vIGV2ZW50X2ZpbGVfZ2V0LiANCiAgICAgICAvLyBDb3Vs
ZCBpdCBsZWFkIHRvIHNvbWUgaXNzdWVzIGluIHRoZSBmdXR1cmUgd2hpbGUgZnJlZWluZyANCiAg
ICAgICAvLyBldmVudF9pbmRvZT8NCiAgICAgICAgfQ0KDQoNCiAgICAgICAgLWV2ZW50X2ZpbGVf
Z2V0KGZpbGUpOyAgICAgICAvL0xpbmUgQw0KICAgICAgICByZXR1cm4gMDsNCiAgfQ0KDQpUaGFu
a3MsDQpUemUtbmFuDQoNCj4gLS0gU3RldmUNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy90cmFjZWZz
L2V2ZW50X2lub2RlLmMgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gaW5kZXggODk0YzZj
YTFlNTAwLi5kYzk3YzE5ZjllMGEgMTAwNjQ0DQo+IC0tLSBhL2ZzL3RyYWNlZnMvZXZlbnRfaW5v
ZGUuYw0KPiArKysgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gQEAgLTg0LDEwICs4NCwx
NyBAQCBlbnVtIHsNCj4gIHN0YXRpYyB2b2lkIHJlbGVhc2VfZWkoc3RydWN0IGtyZWYgKnJlZikN
Cj4gIHsNCj4gIHN0cnVjdCBldmVudGZzX2lub2RlICplaSA9IGNvbnRhaW5lcl9vZihyZWYsIHN0
cnVjdCBldmVudGZzX2lub2RlLA0KPiBrcmVmKTsNCj4gK2NvbnN0IHN0cnVjdCBldmVudGZzX2Vu
dHJ5ICplbnRyeTsNCj4gIHN0cnVjdCBldmVudGZzX3Jvb3RfaW5vZGUgKnJlaTsNCj4gIA0KPiAg
V0FSTl9PTl9PTkNFKCFlaS0+aXNfZnJlZWQpOw0KPiAgDQo+ICtmb3IgKGludCBpID0gMDsgaSA8
IGVpLT5ucl9lbnRyaWVzOyBpKyspIHsNCj4gK2VudHJ5ID0gJmVpLT5lbnRyaWVzW2ldOw0KPiAr
aWYgKGVudHJ5LT5yZWxlYXNlKQ0KPiArZW50cnktPnJlbGVhc2UoZW50cnktPm5hbWUsIGVpLT5k
YXRhKTsNCj4gK30NCj4gKw0KPiAga2ZyZWUoZWktPmVudHJ5X2F0dHJzKTsNCj4gIGtmcmVlX2Nv
bnN0KGVpLT5uYW1lKTsNCj4gIGlmIChlaS0+aXNfZXZlbnRzKSB7DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3RyYWNlZnMuaCBiL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5oDQo+IGluZGV4
IDdhNWZlMTdiNmJmOS4uZDAzZjc0NjU4NzE2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3RyYWNlZnMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3RyYWNlZnMuaA0KPiBAQCAtNjIsNiAr
NjIsOCBAQCBzdHJ1Y3QgZXZlbnRmc19maWxlOw0KPiAgdHlwZWRlZiBpbnQgKCpldmVudGZzX2Nh
bGxiYWNrKShjb25zdCBjaGFyICpuYW1lLCB1bW9kZV90ICptb2RlLA0KPiB2b2lkICoqZGF0YSwN
Cj4gIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKipmb3BzKTsNCj4gIA0KPiArdHlwZWRl
ZiB2b2lkICgqZXZlbnRmc19yZWxlYXNlKShjb25zdCBjaGFyICpuYW1lLCB2b2lkICpkYXRhKTsN
Cj4gKw0KPiAgLyoqDQo+ICAgKiBzdHJ1Y3QgZXZlbnRmc19lbnRyeSAtIGR5bmFtaWNhbGx5IGNy
ZWF0ZWQgZXZlbnRmcyBmaWxlIGNhbGwgYmFjaw0KPiBoYW5kbGVyDQo+ICAgKiBAbmFtZTpUaGVu
IG5hbWUgb2YgdGhlIGR5bmFtaWMgZmlsZSBpbiBhbiBldmVudGZzIGRpcmVjdG9yeQ0KPiBAQCAt
NzIsNiArNzQsNyBAQCB0eXBlZGVmIGludCAoKmV2ZW50ZnNfY2FsbGJhY2spKGNvbnN0IGNoYXIg
Km5hbWUsDQo+IHVtb2RlX3QgKm1vZGUsIHZvaWQgKipkYXRhLA0KPiAgc3RydWN0IGV2ZW50ZnNf
ZW50cnkgew0KPiAgY29uc3QgY2hhcipuYW1lOw0KPiAgZXZlbnRmc19jYWxsYmFja2NhbGxiYWNr
Ow0KPiArZXZlbnRmc19yZWxlYXNlcmVsZWFzZTsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBldmVu
dGZzX2lub2RlOw0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jDQo+
IGIva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jDQo+IGluZGV4IDUyZjc1YzM2YmJjYS4uZDE0
Yzg0MjgxZjJiIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4g
KysrIGIva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jDQo+IEBAIC0yNTUyLDYgKzI1NTIsMTQg
QEAgc3RhdGljIGludCBldmVudF9jYWxsYmFjayhjb25zdCBjaGFyICpuYW1lLA0KPiB1bW9kZV90
ICptb2RlLCB2b2lkICoqZGF0YSwNCj4gIHJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICsvKiBUaGUg
ZmlsZSBpcyBpbmNyZW1lbnRlZCBvbiBjcmVhdGlvbiBhbmQgZnJlZWluZyB0aGUgZW5hYmxlIGZp
bGUNCj4gZGVjcmVtZW50cyBpdCAqLw0KPiArc3RhdGljIHZvaWQgZXZlbnRfcmVsZWFzZShjb25z
dCBjaGFyICpuYW1lLCB2b2lkICpkYXRhKQ0KPiArew0KPiArc3RydWN0IHRyYWNlX2V2ZW50X2Zp
bGUgKmZpbGUgPSBkYXRhOw0KPiArDQo+ICtldmVudF9maWxlX3B1dChmaWxlKTsNCj4gK30NCj4g
Kw0KPiAgc3RhdGljIGludA0KPiAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZXZlbnRmc19pbm9k
ZSAqcGFyZW50LCBzdHJ1Y3QNCj4gdHJhY2VfZXZlbnRfZmlsZSAqZmlsZSkNCj4gIHsNCj4gQEAg
LTI1NjYsNiArMjU3NCw3IEBAIGV2ZW50X2NyZWF0ZV9kaXIoc3RydWN0IGV2ZW50ZnNfaW5vZGUg
KnBhcmVudCwNCj4gc3RydWN0IHRyYWNlX2V2ZW50X2ZpbGUgKmZpbGUpDQo+ICB7DQo+ICAubmFt
ZT0gImVuYWJsZSIsDQo+ICAuY2FsbGJhY2s9IGV2ZW50X2NhbGxiYWNrLA0KPiArLnJlbGVhc2U9
IGV2ZW50X3JlbGVhc2UsDQo+ICB9LA0KPiAgew0KPiAgLm5hbWU9ICJmaWx0ZXIiLA0KPiBAQCAt
MjYzNCw2ICsyNjQzLDkgQEAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZXZlbnRmc19pbm9kZSAq
cGFyZW50LA0KPiBzdHJ1Y3QgdHJhY2VfZXZlbnRfZmlsZSAqZmlsZSkNCj4gIHJldHVybiByZXQ7
DQo+ICB9DQo+ICANCj4gKy8qIEdldHMgZGVjcmVtZW50ZWQgb24gZnJlZWluZyBvZiB0aGUgImVu
YWJsZSIgZmlsZSAqLw0KPiArZXZlbnRfZmlsZV9nZXQoZmlsZSk7DQo+ICsNCj4gIHJldHVybiAw
Ow0KPiAgfQ0KPiAgDQo=

