Return-Path: <linux-kernel+bounces-166018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ABC8B94D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8177F1F22201
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC39C2E9;
	Thu,  2 May 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ugrpEfDc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GRMfWEyt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878411B960;
	Thu,  2 May 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632572; cv=fail; b=QojL1+f4mFPj7TlXvgjYDRi5XRSw6NJ9FI9mLIZ3AQhWOfho88wJT7mbE0nLHvLLs8sWf41wOWd4JM2mujRDTl/09ECKjHkbhJRsRwJ1hkN3mw9uAH+BAVG0OXShT+0x14Zupkj3H0w1gWyf7AIZCpq640idOFrLnqgHsKOQE9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632572; c=relaxed/simple;
	bh=9EGafV8Seu/aTJ5L2VXjcSFvI4fAnuJu7h+/4ZeCPGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmpyIvCCq1lYSuSQiLrrDObdsKqhDQri7PKl5QKLaPz+2gOKyZ1Akq2rktMz730ggE4FcJZikDZilKb1gQTGnXcjod70KBYQFpCmzPnF0aPFgK5o6GFYVNRlhUrlpCRBSPCeB16+Bv3j5JkRVM6iItcLb7zYpBPvbO4yImezmMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ugrpEfDc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GRMfWEyt; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1aad1502085011ef8065b7b53f7091ad-20240502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9EGafV8Seu/aTJ5L2VXjcSFvI4fAnuJu7h+/4ZeCPGM=;
	b=ugrpEfDcdJxF00gEsPw6ZcN6nywMZ9hoWHLli3zey/ll4/QwOzEIQBApA7o42MPpgDcYI7HhnxYY1PO1OdnM8OPAyIU78JARlY0yOtP/m8c7QYeLrKOd26fp09z+s8r3MIwze0I9rpUinwrRbz+KmF1ovFRiONuascviiJ9vc2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:442a2c16-3f1b-4dc1-a5ca-87943a90a4fd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:ad0fdc86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1aad1502085011ef8065b7b53f7091ad-20240502
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 950156433; Thu, 02 May 2024 14:49:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 May 2024 14:49:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 May 2024 14:49:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKqCu+pN0WbVdaCmJXIUX7A5wgC7tGrKfQVzemdrvAf8BBHwMlXroJxBi/KH8i5cNAz5LQbni5yVlgf3v0C/zNTJ6MIPqFmFLdVzAXNy4f7qDKYF4LkKEYEe/lZF1CAlPSQ1ldRvLdRYbEHU1x0EDx62CGNKOJfMK6rfYqZFCnXzzhetvgfpwx/98i5xv+rZUmRyhaRL4UdjarFPH1uaS2/DMyLqrtCSnA6RwnG65/H2WA0cwfWL3EiZ+ALf7764qiscn9ly+mpPyJTiQT8+ElX89zWbmMVvdPxeUTzu4+VsXz18qFXIcTiOz2lJ/hN2FKqMqpQayXH9T+r3jrhXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EGafV8Seu/aTJ5L2VXjcSFvI4fAnuJu7h+/4ZeCPGM=;
 b=VYfVLnDzTjHV1LxjaJglbIEVO3jxeoxVVqQB/3ghvbeWgaHeQeqsi9Xm7WTNyyaqVizACt87SSl4IwCcOk5b3K5n9tjUQMHSWwGJUNgtaksl0XPfIJkHnzTYFvOO+2QBme2/aT0XD0aOL9ySydEhc3+YkPiTBO7XWbMuYEMlf4CyNBFSudBSQO7J1xy/o7/FcULkv7zbiKALwBh2qg2qoGgyzgji5sFF9KthvoLnPyyNu5sG/U83hegq7Vj/RZnWaZU/hhp3f6CnMzPdrKrc584wU11ijPaLuZZmYPPWxKiftECbT99zf32eE8cI71sc1yQqzZY/YlpqPh8KlvvsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EGafV8Seu/aTJ5L2VXjcSFvI4fAnuJu7h+/4ZeCPGM=;
 b=GRMfWEytsYpgzs/PFEvi13+jmwuI+BSfOoXjYFoCqUFObBHWnyuP3mlVhIx/eSBZw994qqA+e08Iqy/9Q9XO1vI0C7oNWCHwtrEzL/x58aSmtAeNRF5pjGIxlL6o+uvFI8pf8h0rY7N117Uo2QsevYlPV1GIa3w5mQ7vDH2yAAU=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYSPR03MB8446.apcprd03.prod.outlook.com (2603:1096:405:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 06:49:18 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::343a:d17a:5383:4b1a%7]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 06:49:18 +0000
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
Thread-Index: AQHal6xCZTDOyK83d0m4QJA7T219GbF+aQGAgAEyugCAA7F4AIAAC0UAgAAx4gA=
Date: Thu, 2 May 2024 06:49:18 +0000
Message-ID: <aac0a4cc0a12fc9593ab7de6c34836757e6814f3.camel@mediatek.com>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
	 <20240428202837.0cabca17@rorschach.local.home>
	 <20240429144626.7d868ad3@gandalf.local.home>
	 <661f101456506db945ccbd94700a0f47b95f91e5.camel@mediatek.com>
	 <20240501235044.12fa3297@gandalf.local.home>
In-Reply-To: <20240501235044.12fa3297@gandalf.local.home>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYSPR03MB8446:EE_
x-ms-office365-filtering-correlation-id: b6990b41-b9bb-4927-de15-08dc6a73fd24
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NW5VOExxUkhUTTlUN21DVDl6Y25RcWhidXFaWHlhTVpYa0pzOERhRnpMMWZw?=
 =?utf-8?B?RVN2bzUyUnR0ZTg4bUlsWEx5SGtCY2dQaGs4NzhYM2RXWmh0YVcxMzRkckI4?=
 =?utf-8?B?dTE4TXZBM0V5eHAwbmdWYTFXQnN6ZkprV0gyTmMvdDBRQklTd0RKeWtyWjBC?=
 =?utf-8?B?VzJkaktkTWZlMVVXbHEwdmtESmtLMnB4NkY4SHdJUlJud25aUHhKY21Tc1BK?=
 =?utf-8?B?ajNqSlhLbHp4SU9FMVdqeWZkYmpwMTZ3V0orVXYyZ2VQekhETlpOUXBLdG5h?=
 =?utf-8?B?ZjB5SlgxWUZGK1VXWUh6TVRUbDgrckJWMWgyTGx1K3JabHJGdGwyTUh4Rndw?=
 =?utf-8?B?ZkNicmtwVlFqR1lWTFpQVm5qUjRnbjhhNXZ1bHRUaXVqY0UzUXIxOEhBSlN2?=
 =?utf-8?B?bnF1Q0FPbENaN3h3aVpGNGpFT2JibGdFbVdkZ2dEMURYR01LQ1huOUUrUUN2?=
 =?utf-8?B?RWZnVERMR1BCaVE1RG9oTSsxZ01QRm1uTHV1ZHdUTHBXNjI2d2dTUWhMRnVU?=
 =?utf-8?B?YTBYc0xLcTJJWmQ1UUpJcldEUXJZVkl6OGZoSXRmRHYwWlJadUxOenNBRnJ6?=
 =?utf-8?B?cjJJZ2hvNENUYU15bXo0MWQwUTBjNFJ6MjRmTStUdW5wZHJTdTR3Z1NWRUU2?=
 =?utf-8?B?TDloT0I0MWNoQi9FampBTUtHSDRmZHZHVis3YlkwbUhidDhCMEFKelA3aVRE?=
 =?utf-8?B?MnJWNHZqcERpRTdsa2tMc3c4OTFhSmlIU3h0c2FBeUprb2lIZVlkRitiUjN2?=
 =?utf-8?B?NjVKbituQk43cWJ0M253T3BleWtvbVhYYTZKMDUzcDJWL0N3Qy9ZZm4wd2xo?=
 =?utf-8?B?T1ErZVc0RTByYmtuT0ZnaGtUNFEraFdKWlVOdDV5NWRVMFVQZDVTZlMvOHhJ?=
 =?utf-8?B?VkRVS21KQkVYb2g0b0tKQXgzcVdhaFJjZVhpWm1scUlHdHlFUXd6cWxTOWVB?=
 =?utf-8?B?YURNbFQzV2lzbStDamRMbUNLSXNZVFdsNGlHb2hjY29Kd0treG11OUlRSEdp?=
 =?utf-8?B?UGZSOVpmVEovWW5ZTXcvMW53ZFUycHltOS9iVDNpd1VyaDhMS1N5UzQzOS9x?=
 =?utf-8?B?amg3VHR3VTRGN0FyaldNRW5mQ3NEMVZKKzJyTkJKTnR2MFp2SlpuQmdBREtW?=
 =?utf-8?B?VFZTOGtnMnBIWWk1QnRkakZPMCtlQ1FVTitqSExmczNtaFY2ZkV2Mm81TlY5?=
 =?utf-8?B?NHdRU3JteTU3c2VRREJ5TmxwaWM5UVRNUFFFbm5mVjFOOTlWM0hlcW9JUmVK?=
 =?utf-8?B?U2h6SXdmVFpYS0llU3Z6UVZQRzhPRE5RblgyTjhBOXNxOTB2SkhDNkdBWXF6?=
 =?utf-8?B?cmg1dHkvcDRDbENzR2k3QmZGT3RRQTc0T2w5NndhcG9jTHJSL2RDSGJvazcr?=
 =?utf-8?B?dWRQRUk0aWFxSWtIZE9rK21HSWxNTmpPNGtmdm1sSGRyYzdtN3ZxUkN5SDBX?=
 =?utf-8?B?T1o4c21JaGN1d0s2TFIvSXNEZnhtWVVCbSsvWXpwY3hKV1gvVitqVVNGQVhL?=
 =?utf-8?B?bnljclRkWDlML2dqajRZUFVyU2JPTksyTXQzNXFDK0cvcERPdHpGam1tVG8r?=
 =?utf-8?B?ZGRQTmU0OUJHY2hBcm5nTklLMDVNcGpWZTVUMnJDZkdPQmlMYWRmM3NnbWFI?=
 =?utf-8?B?KzducjFLTFRrQ0xBMzdvS0RuY09JRElTY0h5QWxoMFFFdGxhTURUVllSdUg1?=
 =?utf-8?B?cEpHMThrMWR0MS9qWGJLK3Z5dzRaYUUrZkhwVWs0RHZJU1l3VndpQ2FBcEJE?=
 =?utf-8?B?MXlPb0lVQXhVb2dXd2FLK1pPYWtQSE1iTmdNbDhwY0hKaTlyVHBhd1ZZeWNR?=
 =?utf-8?B?SEVoemYvQk1aeFk0bmpRdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRuZFVkZmNpUlJCUVJBMExsUk1PZWZYSHJyenRpaTBHcWgzSUwrNG5jemlm?=
 =?utf-8?B?Zy84MmllQ0Q3elRWOHhMU3VON0xIbFRadjJIWHNBMGU4ZUd5STlZTkxveG9U?=
 =?utf-8?B?UGJzQk45b2ZNb0p1NzRmYUF2K2gzNU5EUWYrNFh6ZHlmaEpOZnhFekt4eVg4?=
 =?utf-8?B?L1RGV3cxUXpCTXpRVDJQVkloMHc4VGtta1Y5bTVLZStzOTBVOHZJZ3ZyL05X?=
 =?utf-8?B?NEFFVzRWT0ZVTVh2SmdpTWt1QjdoSTRFVmlTaHFaS1REaXhwNTlHMEV1eFpM?=
 =?utf-8?B?Z3BydmwrWHdqd0hTeUdOdndWYVZrcHJObXFLV0JpOGgxZWpuNjRFNkJVSzRY?=
 =?utf-8?B?ZzNyajNuY2Q0enlma1QvUXozNEdneVUyYWtxbDdGT0s1WGJOSERpbW9odzh5?=
 =?utf-8?B?SzlPQXA5cWVzSHY0OFladW5TYjl3TWYxZjVzVGw1OFplbmNTb1kva2JHWGgy?=
 =?utf-8?B?VG15UjBycUE4VWlxL2FkWC9ZU1htTEl5WVJ2Uk5HditZNlR2N0JpRlJyVmNz?=
 =?utf-8?B?STIvc05iMkpsOFMxRWZnelRRYzEvQ1VuVTY1cUVkbGxLRlRvdys1K1hWY25Q?=
 =?utf-8?B?VThEWkZ4czZWZzl5K2h6cDg4Z214VVRudUdiQTdrVTZxbi80OFc4L21PakZX?=
 =?utf-8?B?c3oyYk5kQzBqWWY2UjlHcFJIc1FNeTBRY2NobjV6MTlzajUvUXJ0cXhnRFAr?=
 =?utf-8?B?ODdiTlgyUTZTcFRqMWZmVHRqV3J1bEJDd0dJNEh4SHZsL0JVN2owbzJCV3dF?=
 =?utf-8?B?MEFvWXk5VXlPR1ZhZmtkT2E2aUhKRlNlVVlKUUF1OUNLVmZlSkh4U3ZvZnAv?=
 =?utf-8?B?dFcvMDkvTGpvSDdnZzE2UldTaG9PejNkUWdqSWtqMGE1OGplMVFkdFVmbFor?=
 =?utf-8?B?U0dOeGtqM3ZEcEJTb2tBbGRUT0N3TUh3TFZEUXNobjZMRWptVE5pZFEwU0dQ?=
 =?utf-8?B?TnpFSUZlWEFITjArU21aclBRakJKWGU3ZEZ1eDBvOXJtNitEWjFtemNUNThF?=
 =?utf-8?B?RWY1c1VHWW12NXVZdm5hYjg5TWFvdDZIK0VocEsyUTlMMGpjZHh5aUp4ekpT?=
 =?utf-8?B?cUE4WUxJSWxLdjRrVEtGQTVweWxGWlVVa3NzOVNONklpTGtBNm1zNGF0Ynpj?=
 =?utf-8?B?Uzk1czd4S2szVDh5ck0rME5Fa0Z6UkRqZFJONzY2bHVWWVNScFNLNlZKQ1p3?=
 =?utf-8?B?MzdabTJ1MjlycTg3Y3FCSnd5M0ExbnJLVktkamIwZW1aQ2UvSlpLdlMvMjky?=
 =?utf-8?B?YmJnNW9JdmZvcERKa1FhS2k3UVFXTWxmMU93ZVJzcGhjOWRBUUQwWDE1OG4x?=
 =?utf-8?B?elZiWXhwUGhsbnZZS3Z1aUN0SHgvVDNPaG8xUlZvMjM1SXBSa1VmdERJZU9H?=
 =?utf-8?B?UDM1NlRTR0F6cTlxa3R6by9HRXkrVlJIeHhNaW1Vdjg1VFlFZ1l5UHFRY0wx?=
 =?utf-8?B?ZUNJdnc1bGFSOXhlQUpRM1Rld2lSS2QzNHZyV0x3b2swNkp6K21RZ1RQWFJn?=
 =?utf-8?B?QmI4SW5QdmxleFFlMmI1dHU5Qm9mS1ZBQWpFcWxqWlF2R1hxeWwrK09FTVg1?=
 =?utf-8?B?NDhVMTJERFJnejBtMDF3LzltT3RWdjdvTjZXTWQ0a28vZGRPN1JKblN6MkRR?=
 =?utf-8?B?dkI5VDZVUFhsY2ZsN2hFRU5BUmE5TnFmWHh5SjZRelArbTFPM2hVQ2hPSGUv?=
 =?utf-8?B?L1AzSmtZU2RyQnBYRE9lK292UzZ5Rk96RXhsMEs3aW03RGVOam9zNDZPOVZm?=
 =?utf-8?B?SU4wcFlONEIwZXJKSUlvU1NURUg3bGtnMFVkdFJGVkREeFlRRTJHanVZUkNm?=
 =?utf-8?B?dG5xWHRDSy9vRkNoZzFCQ3JjQTBvSXRsc3BnZzhhVStBdTlBQVpaeERHam9x?=
 =?utf-8?B?MDFSb080dkpzMTR3eHhxWEFiUHV0aUZTOFZoczJ4UUR2SWdPVmM5R3k0MjR3?=
 =?utf-8?B?RWVZREJhRnVrMkhnWjVFbGRQbUtveHEyaXBmYnEwMm41aE1TYlFvVW1lTlpH?=
 =?utf-8?B?SUhHV1E4QzI1VGZKVVVXYjBiZTQyR25qSlRPR1UxYlljaGFKSHZNdVJFV3Bt?=
 =?utf-8?B?N2t1SFZSa2tWSGZva2Z3RVoxMjQ5OVBFSXZpV2lycmZTNmEvK0drV2Q4WGFq?=
 =?utf-8?B?NEhaT29YTlRJc2JkbnZrSElrTllMMzVSN3Zrd0VLTm03aDN6Z2ZrSUpacFAz?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13EBAF4AE262D5419B41994BF08FD922@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6990b41-b9bb-4927-de15-08dc6a73fd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 06:49:18.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dSuQdxK54/6KVAoSZ8yXUHzl2qFr7FzzBEkuVP/dqEpNv6h4r9h64Fgcqlls5i2k4/jbUxydC38Rjr4leygmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8446

T24gV2VkLCAyMDI0LTA1LTAxIGF0IDIzOjUwIC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBUaHUsIDIgTWF5IDIwMjQgMDM6MTA6MjQgKzAwMDANCj4gVHpl
LW5hbiBXdSAo5ZCz5r6k5Y2XKSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiAN
Cj4gPiA+ICAgDQo+ID4gU29ycnkgZm9yIG15IGxhdGUgcmVwbHksIEknbSB0ZXN0aW5nIHRoZSBw
YXRjaCBvbiBteSBtYWNoaW5lIG5vdy4gDQo+ID4gVGVzdCB3aWxsIGJlIGRvbmUgaW4gZm91ciBo
b3Vycy4NCj4gPiANCj4gPiBUaGVyZSdzIHNvbWV0aGluZyBJJ20gd29ycnlpbmcgYWJvdXQgaW4g
dGhlIHBhdGNoLA0KPiA+IHdoYXQgSSdtIHdvcnJ5aW5nIGFib3V0IGlzIGNvbW1lbnRlZCBpbiB0
aGUgY29kZSBiZWxvdy4NCj4gPiANCj4gPiAva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jOg0K
PiA+ICAgc3RhdGljIGludA0KPiA+ICAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZXZlbnRmc19p
bm9kZSAqcGFyZW50LCANCj4gPiAgIHN0cnVjdCB0cmFjZV9ldmVudF9maWxlICpmaWxlKSANCj4g
PiAgIHsNCj4gPiAgICAgICAgIC4uLg0KPiA+ICAgICAgICAgLi4uDQo+ID4gICAgICAgICAuLi4N
Cj4gPiAgICAgICAgIG5yX2VudHJpZXMgPSBBUlJBWV9TSVpFKGV2ZW50X2VudHJpZXMpOw0KPiA+
IA0KPiA+ICAgICAgICAgbmFtZSA9IHRyYWNlX2V2ZW50X25hbWUoY2FsbCk7DQo+ID4gDQo+ID4g
ICAgICAgICArZXZlbnRfZmlsZV9nZXQoZmlsZSk7ICAgICAgICAvLyBMaW5lIEENCj4gPiAgICAg
ICAgICAgICBeXl5eXl5eXl5eXl5eDQo+ID4gICAgICAgICAvLyBTaG91bGQgd2UgbW92ZSB0aGUg
ImV2ZW50X2ZpbGVfZ2V0IiB0byBoZXJlLCBpbnN0ZWFkICANCj4gPiAgICAgICAgIC8vIG9mIGNh
bGxpbmcgaXQgYXQgbGluZSBDPw0KPiA+ICAgICAgICAgLy8gRHVlIHRvIExpbmUgQiBjb3VsZCBl
dmVudHVhbGx5IGludm9rZSAiZXZlbnRfZmlsZV9wdXQiLg0KPiA+ICAgICAgICAgLy8gICBldmVu
dGZzX2NyZWF0ZV9kaXIgLT4gZnJlZV9laSAtPnB1dF9laSAtPiBrcmVmX3B1dCANCj4gPiAgICAg
ICAgIC8vICAtPiByZWxlYXNlX2VpIC0+IGV2ZW50X3JlbGVhc2UgLT4gZXZlbnRfZmlsZV9wdXQN
Cj4gPiAgICAgICAgIC8vIE5vdCBzdXJlIGlmIHRoaXMgaXMgYSBwb3RlbnRpYWwgcmlzaz8gSWYg
TGluZSBCIGRvDQo+IGNhbGwgICANCj4gPiAgICAgICAgIC8vIGV2ZW50X2ZpbGVfcHV0LCJldmVu
dF9maWxlX3B1dCIgd2lsbCBiZSBjYWxsZWQgcHJpb3IgdG8NCj4gPiAgICAgICAgIC8vICJldmVu
dF9maWxlX2dldCIsIGNvdWxkIGNvcnJ1cHQgdGhlIHJlZmVyZW5jZSBvZiB0aGUNCj4gZmlsZS4N
Cj4gDQo+IE5vLCBidXQgeW91IGRvIGJyaW5nIHVwIGEgZ29vZCBwb2ludC4gVGhlIHJlbGVhc2Ug
c2hvdWxkIG5vdCBiZQ0KPiBjYWxsZWQgb24NCj4gZXJyb3IsIGJ1dCBpdCBsb29rcyBsaWtlIGl0
IHBvc3NpYmx5IGNhbiBiZS4NCj4gDQo+ID4gDQo+ID4gICAgICAgICBlaSA9IGV2ZW50ZnNfY3Jl
YXRlX2RpcihuYW1lLCBlX2V2ZW50cywgICAgLy8gTGluZSBCIA0KPiA+ICAgICAgICAgICAgICBl
dmVudF9lbnRyaWVzLCBucl9lbnRyaWVzLCBmaWxlKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIo
ZWkpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHByX3dhcm4oIkNvdWxkIG5vdCBjcmVhdGUgdHJh
Y2VmcyAnJXMnDQo+IGRpcmVjdG9yeVxuIiwgDQo+ID4gICAgICAgICAgICAgICAgIG5hbWUpOw0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAg
ICBmaWxlLT5laSA9IGVpOw0KPiA+IA0KPiA+ICAgICAgICAgcmV0ID0gZXZlbnRfZGVmaW5lX2Zp
ZWxkcyhjYWxsKTsNCj4gPiAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gICAgICAgICAgICAg
ICAgIHByX3dhcm4oIkNvdWxkIG5vdCBpbml0aWFsaXplIHRyYWNlIHBvaW50DQo+IGV2ZW50cy8l
c1xuIiwNCj4gPiBuYW1lKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eICAgICAgICAgIA0KPiA+ICAgICAgICAvLyBNYXli
ZSB3ZSBjaG91bGQgaGF2ZSBzaW1pbGFyIGNvbmNlcm4gaWYgd2UgcmV0dXJuIGhlcmUuDQo+ID4g
ICAgICAgIC8vIER1ZSB0byB0aGUgZXZlbnRfaW5vZGUgaGFkIGJlZW4gY3JlYXRlZCwgYnV0IHdl
IGRpZCBub3QNCj4gY2FsbCANCj4gPiAgICAgICAgLy8gZXZlbnRfZmlsZV9nZXQuIA0KPiA+ICAg
ICAgICAvLyBDb3VsZCBpdCBsZWFkIHRvIHNvbWUgaXNzdWVzIGluIHRoZSBmdXR1cmUgd2hpbGUg
ZnJlZWluZyANCj4gPiAgICAgICAgLy8gZXZlbnRfaW5kb2U/DQo+ID4gICAgICAgICB9DQo+ID4g
DQo+ID4gDQo+ID4gICAgICAgICAtZXZlbnRfZmlsZV9nZXQoZmlsZSk7ICAgICAgIC8vTGluZSBD
DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gDQo+IFRoaXMgcHJldmVudHMgdGhl
IHJlbGVhc2UoKSBmdW5jdGlvbiBmcm9tIGJlaW5nIGNhbGxlZCBvbiBmYWlsdXJlIG9mDQo+IGNy
ZWF0aW5nIHRoZSBlaS4NCj4gDQo+IENhbiB5b3UgdHJ5IHRoaXMgcGF0Y2ggaW5zdGVhZD8NCj4g
DQo+IC0tIFN0ZXZlDQo+IA0KR29vZCBuZXdzLCB0aGlzIHBhdGNoIHdvcmtzLCB0aGUgdGVzdCBo
YXMgcGFzc2VkLCBubyBtb3JlIEthc2FuIHJlcG9ydA0KaW4gbXkgZW52aXJvbm1lbnQuDQoNCm15
IGVudmlyb25tZW50Og0KIGFybTY0ICsga2FzYW4gKyBzd3RhZyBiYXNlZCBrYXNhbiArIGtlcm5l
bC02LjYuMTgNCg0KUmVhbGx5IGFwcHJlY2lhdGUsIGFuZCBsZWFybiBhIGxvdCBmcm9tIHRoZSBw
YXRjaC4NCg0KLS1UemUtbmFuDQo+IGRpZmYgLS1naXQgYS9mcy90cmFjZWZzL2V2ZW50X2lub2Rl
LmMgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gaW5kZXggODk0YzZjYTFlNTAwLi5mNTUx
MGUyNmYwZjYgMTAwNjQ0DQo+IC0tLSBhL2ZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYw0KPiArKysg
Yi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMNCj4gQEAgLTg0LDEwICs4NCwxNyBAQCBlbnVtIHsN
Cj4gIHN0YXRpYyB2b2lkIHJlbGVhc2VfZWkoc3RydWN0IGtyZWYgKnJlZikNCj4gIHsNCj4gIHN0
cnVjdCBldmVudGZzX2lub2RlICplaSA9IGNvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCBldmVudGZz
X2lub2RlLA0KPiBrcmVmKTsNCj4gK2NvbnN0IHN0cnVjdCBldmVudGZzX2VudHJ5ICplbnRyeTsN
Cj4gIHN0cnVjdCBldmVudGZzX3Jvb3RfaW5vZGUgKnJlaTsNCj4gIA0KPiAgV0FSTl9PTl9PTkNF
KCFlaS0+aXNfZnJlZWQpOw0KPiAgDQo+ICtmb3IgKGludCBpID0gMDsgaSA8IGVpLT5ucl9lbnRy
aWVzOyBpKyspIHsNCj4gK2VudHJ5ID0gJmVpLT5lbnRyaWVzW2ldOw0KPiAraWYgKGVudHJ5LT5y
ZWxlYXNlKQ0KPiArZW50cnktPnJlbGVhc2UoZW50cnktPm5hbWUsIGVpLT5kYXRhKTsNCj4gK30N
Cj4gKw0KPiAga2ZyZWUoZWktPmVudHJ5X2F0dHJzKTsNCj4gIGtmcmVlX2NvbnN0KGVpLT5uYW1l
KTsNCj4gIGlmIChlaS0+aXNfZXZlbnRzKSB7DQo+IEBAIC0xMTIsNiArMTE5LDE4IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBmcmVlX2VpKHN0cnVjdCBldmVudGZzX2lub2RlDQo+ICplaSkNCj4gIH0N
Cj4gIH0NCj4gIA0KPiArLyoNCj4gKyAqIENhbGxlZCB3aGVuIGNyZWF0aW9uIG9mIGFuIGVpIGZh
aWxzLCBkbyBub3QgY2FsbCByZWxlYXNlKCkNCj4gZnVuY3Rpb25zLg0KPiArICovDQo+ICtzdGF0
aWMgaW5saW5lIHZvaWQgY2xlYW51cF9laShzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZWkpDQo+ICt7
DQo+ICtpZiAoZWkpIHsNCj4gKy8qIFNldCBucl9lbnRyaWVzIHRvIDAgdG8gcHJldmVudCByZWxl
YXNlKCkgZnVuY3Rpb24gYmVpbmcgY2FsbGVkICovDQo+ICtlaS0+bnJfZW50cmllcyA9IDA7DQo+
ICtmcmVlX2VpKGVpKTsNCj4gK30NCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
ZXZlbnRmc19pbm9kZSAqZ2V0X2VpKHN0cnVjdCBldmVudGZzX2lub2RlICplaSkNCj4gIHsNCj4g
IGlmIChlaSkNCj4gQEAgLTczNCw3ICs3NTMsNyBAQCBzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZXZl
bnRmc19jcmVhdGVfZGlyKGNvbnN0DQo+IGNoYXIgKm5hbWUsIHN0cnVjdCBldmVudGZzX2lub2Rl
DQo+ICANCj4gIC8qIFdhcyB0aGUgcGFyZW50IGZyZWVkPyAqLw0KPiAgaWYgKGxpc3RfZW1wdHko
JmVpLT5saXN0KSkgew0KPiAtZnJlZV9laShlaSk7DQo+ICtjbGVhbnVwX2VpKGVpKTsNCj4gIGVp
ID0gTlVMTDsNCj4gIH0NCj4gIHJldHVybiBlaTsNCj4gQEAgLTgzNSw3ICs4NTQsNyBAQCBzdHJ1
Y3QgZXZlbnRmc19pbm9kZQ0KPiAqZXZlbnRmc19jcmVhdGVfZXZlbnRzX2Rpcihjb25zdCBjaGFy
ICpuYW1lLCBzdHJ1Y3QgZGVudHJ5DQo+ICByZXR1cm4gZWk7DQo+ICANCj4gICBmYWlsOg0KPiAt
ZnJlZV9laShlaSk7DQo+ICtjbGVhbnVwX2VpKGVpKTsNCj4gIHRyYWNlZnNfZmFpbGVkX2NyZWF0
aW5nKGRlbnRyeSk7DQo+ICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gIH0NCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5oIGIvaW5jbHVkZS9saW51eC90cmFjZWZzLmgN
Cj4gaW5kZXggN2E1ZmUxN2I2YmY5Li5kMDNmNzQ2NTg3MTYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdHJhY2Vmcy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5oDQo+IEBA
IC02Miw2ICs2Miw4IEBAIHN0cnVjdCBldmVudGZzX2ZpbGU7DQo+ICB0eXBlZGVmIGludCAoKmV2
ZW50ZnNfY2FsbGJhY2spKGNvbnN0IGNoYXIgKm5hbWUsIHVtb2RlX3QgKm1vZGUsDQo+IHZvaWQg
KipkYXRhLA0KPiAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqKmZvcHMpOw0KPiAgDQo+
ICt0eXBlZGVmIHZvaWQgKCpldmVudGZzX3JlbGVhc2UpKGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQg
KmRhdGEpOw0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCBldmVudGZzX2VudHJ5IC0gZHluYW1p
Y2FsbHkgY3JlYXRlZCBldmVudGZzIGZpbGUgY2FsbCBiYWNrDQo+IGhhbmRsZXINCj4gICAqIEBu
YW1lOlRoZW4gbmFtZSBvZiB0aGUgZHluYW1pYyBmaWxlIGluIGFuIGV2ZW50ZnMgZGlyZWN0b3J5
DQo+IEBAIC03Miw2ICs3NCw3IEBAIHR5cGVkZWYgaW50ICgqZXZlbnRmc19jYWxsYmFjaykoY29u
c3QgY2hhciAqbmFtZSwNCj4gdW1vZGVfdCAqbW9kZSwgdm9pZCAqKmRhdGEsDQo+ICBzdHJ1Y3Qg
ZXZlbnRmc19lbnRyeSB7DQo+ICBjb25zdCBjaGFyKm5hbWU7DQo+ICBldmVudGZzX2NhbGxiYWNr
Y2FsbGJhY2s7DQo+ICtldmVudGZzX3JlbGVhc2VyZWxlYXNlOw0KPiAgfTsNCj4gIA0KPiAgc3Ry
dWN0IGV2ZW50ZnNfaW5vZGU7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZl
bnRzLmMNCj4gYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4gaW5kZXggNTJmNzVjMzZi
YmNhLi42ZWYyOWViYTkwY2UgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVu
dHMuYw0KPiArKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4gQEAgLTI1NTIsNiAr
MjU1MiwxNCBAQCBzdGF0aWMgaW50IGV2ZW50X2NhbGxiYWNrKGNvbnN0IGNoYXIgKm5hbWUsDQo+
IHVtb2RlX3QgKm1vZGUsIHZvaWQgKipkYXRhLA0KPiAgcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4g
Ky8qIFRoZSBmaWxlIGlzIGluY3JlbWVudGVkIG9uIGNyZWF0aW9uIGFuZCBmcmVlaW5nIHRoZSBl
bmFibGUgZmlsZQ0KPiBkZWNyZW1lbnRzIGl0ICovDQo+ICtzdGF0aWMgdm9pZCBldmVudF9yZWxl
YXNlKGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICtzdHJ1Y3QgdHJhY2Vf
ZXZlbnRfZmlsZSAqZmlsZSA9IGRhdGE7DQo+ICsNCj4gK2V2ZW50X2ZpbGVfcHV0KGZpbGUpOw0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgaW50DQo+ICBldmVudF9jcmVhdGVfZGlyKHN0cnVjdCBldmVu
dGZzX2lub2RlICpwYXJlbnQsIHN0cnVjdA0KPiB0cmFjZV9ldmVudF9maWxlICpmaWxlKQ0KPiAg
ew0KPiBAQCAtMjU2Niw2ICsyNTc0LDcgQEAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZXZlbnRm
c19pbm9kZSAqcGFyZW50LA0KPiBzdHJ1Y3QgdHJhY2VfZXZlbnRfZmlsZSAqZmlsZSkNCj4gIHsN
Cj4gIC5uYW1lPSAiZW5hYmxlIiwNCj4gIC5jYWxsYmFjaz0gZXZlbnRfY2FsbGJhY2ssDQo+ICsu
cmVsZWFzZT0gZXZlbnRfcmVsZWFzZSwNCj4gIH0sDQo+ICB7DQo+ICAubmFtZT0gImZpbHRlciIs
DQo+IEBAIC0yNjM0LDYgKzI2NDMsOSBAQCBldmVudF9jcmVhdGVfZGlyKHN0cnVjdCBldmVudGZz
X2lub2RlICpwYXJlbnQsDQo+IHN0cnVjdCB0cmFjZV9ldmVudF9maWxlICpmaWxlKQ0KPiAgcmV0
dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArLyogR2V0cyBkZWNyZW1lbnRlZCBvbiBmcmVlaW5nIG9m
IHRoZSAiZW5hYmxlIiBmaWxlICovDQo+ICtldmVudF9maWxlX2dldChmaWxlKTsNCj4gKw0KPiAg
cmV0dXJuIDA7DQo+ICB9DQo+ICANCg==

