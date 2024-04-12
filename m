Return-Path: <linux-kernel+bounces-142554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB128A2D11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8009528445E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375353818;
	Fri, 12 Apr 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pYJMvh2g";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CGUjdGJc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921935339E;
	Fri, 12 Apr 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919975; cv=fail; b=M+qyWi+ZR9qCbYHQzfVLg58ax6DtyjW3+BBJFa+TDtMHwYzBk470Stqemoh6cCtpHSzp2mAET0U5SNBffYBe8VlzOVmC2Ho1tWVuZ9Zil986DRD6MmK/qXmW6tDOr7KDc/0M90MNAk/dbuMfeSdDfiO1oHPsAadSP62/MlEmR+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919975; c=relaxed/simple;
	bh=52aIV4Wra8M/22bVbzGgBlSGHfekU7YhMBHKiev+BGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/XJa1K7MNwB5yaKTXQ76depo/HidIngKh1E5qLricG/ZoypeD8XXstLX+j4oKpvvcZNFuQayEGfgeVj+KmsUowPTLBhSKgBJncCuyHlZkSPylFG3/KhupUkBbq7XceTC9fXnKhJiczivgwcXbsNCZqzKi99AlLLOhWyLRPpxO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pYJMvh2g; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CGUjdGJc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a940eb84f8bc11ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=52aIV4Wra8M/22bVbzGgBlSGHfekU7YhMBHKiev+BGs=;
	b=pYJMvh2ggZ4LKtBi12N86RpOrvCt3x+6+61z/tArps2pruyjxDbwSnwCiZMXlNyIV3gXd21C5i5aOYyD4ypiVSnB0VytAYuWwSKzzwVsWmfeDZUh7HyNMstT/ycRTIAZa+Y01HIZXcaBCoZToxzOIZYANZWIZG+r9STxvDCSmJM=;
X-CID-CACHE: Type:Local,Time:202404121821+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:31db4e5b-e6cb-4c0a-a028-af16baedbce6,IP:0,U
	RL:0,TC:41,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:36
X-CID-META: VersionHash:6f543d0,CLOUDID:d5ad9982-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:4,Content:0,EDM:-3,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 3,BAP
X-CID-BAS: 3,BAP,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a940eb84f8bc11ee935d6952f98a51a9-20240412
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1133937984; Fri, 12 Apr 2024 19:06:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 19:06:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 19:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+v7SQS0w6Y47FtgMigv7D2WOT09l9seTUhU4pumPfo3mtLc+D7NFTXoOUhbnkJHg3zeDlgKfY3j2lKyq4tINAcb9uyz3G+pumMtci5IAaASZjqI2f9ihFVbJm0gHaaQXlFzUBF2NUXH9t9ugHzDEbbGMgXeoCnZJk88QZOohZvdZa7FWX+4RF3V4PYy3Snx6pRoGZR01nHqVg6VXcK9eTZ0rqjD8sntPq4aHEHG6eG04W0Lwv0zH7tYgn/xQryVP/K6GmePNM0gMCyDMpcv4OojHQJ5aXJBGroVCtxIBGwq6n0rgv/9PsZ7ZSbawtEyki53nejHOCpcPxNPY3zSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52aIV4Wra8M/22bVbzGgBlSGHfekU7YhMBHKiev+BGs=;
 b=E49Wj7k6cOyIbFXtGwzFD3ocAbv8K3i2yJpTTf/Qk+XUMJCYvf82FPbj5dWw+L6iNflwEvM5TYLlMEwgyDJvpldASYbosh0hpBISU/352FB98VT89CBNz1Ned9msb9Ahj0zUIUQTW31ROQr6lJ6kYYOD386V9PGTv9K6KHFVO3Oyw3jqlm4C/5g3hv9P1ldMWF+61NHsO9guwjUKJngy5CLN0wImWr/LS9NCy2uUgWeW7B0fGV8hAeDM2RjpPAftDgaSq5paWu55sRfI30L/f2jRfaolx6LtrKJ9blOycgUKMT8vcLTuT9eXZan71a+/eYwlgvuL46LcTWYSiwFyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52aIV4Wra8M/22bVbzGgBlSGHfekU7YhMBHKiev+BGs=;
 b=CGUjdGJcfEH2xoAU0PDJObBthwMTWB5ydMZW0boYpYhvU5WA8VhFrSP2uD2ldy9svCVbM7qWqJBLYP/6NjlQ336GLWXL+Wg5ANXUHTNjUWznZoc338n/KpWzNYGWjH7B3XC6uEp9g6eDBFGQa6oD6Y+kLtlN1GVogI00iNr5XtE=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7407.apcprd03.prod.outlook.com (2603:1096:820:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 11:06:03 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 11:06:03 +0000
From: =?utf-8?B?T2xpdmlhIFdlbiAo5rip5YCp6IuTKQ==?= <Olivia.Wen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>, "andersson@kernel.org" <andersson@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?VGVkZHkgQ2hlbiAo6Zmz5Lm+5YWDKQ==?= <Teddy.Chen@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= <TingHan.Shen@mediatek.com>
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Support MT8188 SCP core 1
Thread-Topic: [PATCH 2/2] remoteproc: mediatek: Support MT8188 SCP core 1
Thread-Index: AQHai9axYKR+Wo7XokGUJy4nwRh4YbFkeyIA
Date: Fri, 12 Apr 2024 11:06:03 +0000
Message-ID: <aa64c07569f249d52252689f47db2a6a9bfc2666.camel@mediatek.com>
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
	 <20240411033750.6476-3-olivia.wen@mediatek.com>
	 <f1bdf524-17b4-4cce-a7ed-abc97786c975@kernel.org>
In-Reply-To: <f1bdf524-17b4-4cce-a7ed-abc97786c975@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7407:EE_
x-ms-office365-filtering-correlation-id: 18add865-ca5b-4ecb-1d93-08dc5ae08b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPcEI0XBTn6gHK24TRM6Kcz09s4832vrFBLevqoxfnyjZ6MryLG0kwRJG1/A1SO6dxK4/x7zilwGZBrb0G5oVoCEF3VEpPOayx6aljqrylHLk/riUvGQKMz82NIkWHAGDt7PdWjHf1acYukzPu2HxSS/8TtaRtb3mWnvCotMq2WvpI73yu6EhU9aYAgOwViyXyouS/z+UBhlYuYzOdfoZ4PagFm7HtSlH/qj18itfqqZrK1zJvYXl3I+DG5x4TPDwduz1JyadJLGwzF3JbpPTQOkMwrmOV11GTNDUY6X1X2B11AQhqavZgj+pPEcuzOCQfZBzb4iIKmb+CVWPvMDHXBSh2TRB/LneFTbI6CdDN6W/uVwV6t863/V3aoxTzlPdF9vI6oCUVnpllPmFX/EzVxYgQNEcbVrehiEl8zlG37avppCds4z4eGzAnfSbqoAOBNUcqVU0in47H4+75+LkBiBwwnPpeDu53UdsDQ7Z2VhsiFcvRPlRgG1+yMSEKuLgUiz1oo5NGPeXzBIBAomwyPXD1SO/oGk9Vi8an1+EyG9jjpZ0vfbncOTcFPyhHoVI80ZThrjiQDhHbwneec7Vz7xh4fNsTjZOEIfEnAbkfCTg+vhnLjocptRuHE14yPzNr3mgFEAE1AmjuXf4RGk+lGtK3pV6Cy2mzAo4Mq/OmYCTgRzTxPmb/xs1JZpk6oGBuumJEEz3b8PjVkdjloQlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkNLZWFBU053SlcvUVAvU2lZYlpWVWxoWityWGJWanRURUFJREpuRHhHK2F3?=
 =?utf-8?B?U0FXLzlmQVAxUlQzdmRwU1ZFU1hlbjhMY3JMQUprYlNVT2h2OFpLVlVXRStu?=
 =?utf-8?B?SDFZODVmZzBENnQ3cDFTODZwQkQ5SkJFOWtjTDA4Zm5nWFp2cmZXNlJiMFZP?=
 =?utf-8?B?QnJpeHljanpHeTl4Y1A1Wnc4bjN4dmlPOS8rVjlaNUtETlI1VVo2eWFsQWpt?=
 =?utf-8?B?Zm1KRkZEQWJzVzNtY0VPdjRoTW5qL215ZWZpc0tHTVVuNmFySnNNMHBkOVJV?=
 =?utf-8?B?NlhEVzJ0MTRIeTNKNTczMlhlNUVJZnlGWVhBNXBYdWpxam1TRWJMUjJkMmVK?=
 =?utf-8?B?N3lBNFFVaTFCdFY2ZmROVzBJNERMNmdEeUpLNjdpTUxmdTl1UlF0NGhXVmZL?=
 =?utf-8?B?cy9GQ2RuVDBhNmVXUmhTemNnNjNONDVMdGlUZVA4M0RPTERRcFRHZ3MzVHV0?=
 =?utf-8?B?WGJrdlNXRlRzWFRCNlByc3c2SDNkZk9OUXE1NEdXYkVVT2paNFBoUHRFNytU?=
 =?utf-8?B?ZHZvcnlnOU9aS25pSytjWXQ1UFVCNDAvaXpkSTRDQ2hEQXlTaW1KaGtRRVdN?=
 =?utf-8?B?a0dWMS8vWGF1QndvTitGRmFxc0tJWkVEZFYwNW5VeEpMRU5Sc0x1bXNhUjNs?=
 =?utf-8?B?TlZtZU5JRkhWYVJLbFBWVkNNYXQ1OHpHQXBTNDJ3YytPY2RrN2NCZ2gwQ2Vn?=
 =?utf-8?B?N3pBWlBKQkRZdGRubHlxaVVITEp3RjZUSUVRQTYxT0RqdThZYWtFVldXSHNr?=
 =?utf-8?B?YTAvUU5UN2pFdk80N2k2UUhCN1pXSVlVY1R2THIrb0J5Uk5IQksrTVZTNitQ?=
 =?utf-8?B?b3F1U2hDVFhGSEZ1S2lzbVJRQmJnTW8rYUxUWGZESytjUG5PN1dBK1duNUZr?=
 =?utf-8?B?M3BVZ3MvSE1ycjMvMGFOckdqb3IvdnFkbHd0S01nbWluVHZEamNGNFk5MW14?=
 =?utf-8?B?K2hWaURYcnBibmVHb3hKTndUVGh5SGwySkhqbjR4dnJOc0tzREppSTBlRjNX?=
 =?utf-8?B?NEViZ0pWY3NtS2Jna1dCRW9zZU9jemJzQW1Yc2ZsRzRjdTVtaXg1aGZ4ckNR?=
 =?utf-8?B?R1U5dlRtZU5md096QlFTYTdwRWN1dkRaSXYrWUlHb0wyeXJPRUs0ZHZpU3Y0?=
 =?utf-8?B?NThZME5MeUVmblFHaExpVmQ5L01WYzZXeTBtZ2NKOVZtb1IzUnNxY1ByTmd5?=
 =?utf-8?B?NmluSVZSbmtnaEVtOUpISm10ZzhXcEl6RmhUd1JLQiswUXV0bjNtQytsbFBW?=
 =?utf-8?B?dnlOYnIyM1FpK0MwcFpRbDdocTdDQy9jbDJXeERPMWpJQS9MdWkwQ01sY0JJ?=
 =?utf-8?B?Y20yYk5SWVNLT0tJdVZUaGRISTEwTzZKS0FSRGFLY1FBZ25JcHBOMTJaamxW?=
 =?utf-8?B?cFVmT0VIMGh4VUlqWGxlSUZhQWNIb0RrSVhyVnJ5MFpwUjIxVUtLSVY3L1hl?=
 =?utf-8?B?OTAyakNWK0xRUjZvcmJBalN6b01NV0krNzA4Ri90MWJmOXAvL3VoOTZ4Y2Nu?=
 =?utf-8?B?M0dWcHMwSXdZZXJleTB4Tm4yVE5iaTdTQzhuUTdZa1Yya3pydDZFamk0Nk1B?=
 =?utf-8?B?bkVpbzlWZ21BRkhTRWZWYjV5bFB1cUgyR2dNaElzaHB3M3pFUVI2UW8wYVB6?=
 =?utf-8?B?WkhWMVh2dmplQmhPVXlyUjJwQkVTazVTc3NuRzF2cXlBV2RoQVlHZmZZbjhE?=
 =?utf-8?B?T3U5a1YzTFlTNW0rYWpEclB3MDlhWVlTd1Nzb3k1MDhYek9SNDBwYThFMXpT?=
 =?utf-8?B?Q3FzVGVrYktxZGNWS2FNQ1dhSjFDbkZQWEJCWkpuNEZVWmR6WUFKcTlyaVZj?=
 =?utf-8?B?MVZIaVF3SENYVXFFZUdqVFZwTktUT1k0ZGVQRWsyRkFaSTdTVzQ0cVg2RXpL?=
 =?utf-8?B?N1V3Z1ZGVldCY0xraXBsQUZjUzMwQ0tpdUpQY29yQlVNVmZZREpEbzNpVlBp?=
 =?utf-8?B?Zkh1ZDQxNGF1Uk5SMUlnL0xmVGtQeDhCaVd1Q1IzaEkyQ282ekdJRWovWlg5?=
 =?utf-8?B?L3ZCeWtVcE9TY3Q1QmtkMHlqSlJNYzNiWFJIRkV1UmNBQTB4N21aUnJvZVRS?=
 =?utf-8?B?eW1hbER0ektZc1M3ay9nMGtPMXkvd0RPU080b25ESmFya05iajYwSzdVVW0y?=
 =?utf-8?B?WE0wRER5WTlwazMwRWxyM3A3RjN2dXpLbktmSitYdVFCbW1iSjU4SWtONy9h?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCDC59C96A74914396A8F1402171BCC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18add865-ca5b-4ecb-1d93-08dc5ae08b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 11:06:03.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgUxvh13HDof0Exdjoie1dr6y8MVeaYkXICSaQWvdxjTWw4MOW1ebo+PbXPVpdYZG4GS50LsgK6lYTwn9RMZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7407

SGkgS3J6eXN6dG9mLA0KDQpPbiBUaHUsIDIwMjQtMDQtMTEgYXQgMDg6MDcgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTEvMDQvMjAyNCAwNToz
Nywgb2xpdmlhLndlbiB3cm90ZToNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zY3Bfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc2NwIiwgLmRhdGEgPSAmbXQ4MTgzX29mX2RhdGEgfSwN
Cj4gPiAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtc2NwIiwgLmRhdGEgPSAmbXQ4
MTg2X29mX2RhdGEgfSwNCj4gPiBAQCAtMTMyMyw2ICsxMzYyLDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQNCj4gbXRrX3NjcF9vZl9tYXRjaFtdID0gew0KPiA+ICB7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1zY3AiLCAuZGF0YSA9ICZtdDgxOTJfb2ZfZGF0YSB9
LA0KPiA+ICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zY3AiLCAuZGF0YSA9ICZt
dDgxOTVfb2ZfZGF0YSB9LA0KPiA+ICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1z
Y3AtZHVhbCIsIC5kYXRhID0NCj4gJm10ODE5NV9vZl9kYXRhX2NvcmVzIH0sDQo+ID4gK3sgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNjcC1kdWFsIiwgLmRhdGEgPQ0KPiAmbXQ4MTg4
X29mX2RhdGFfY29yZXMgfSwNCj4gDQo+IFdoeSBkbyB5b3UgYWRkIG5ldyBlbnRyaWVzIHRvIHRo
ZSBlbmQ/IExvb2sgYXQgdGhlIGxpc3QgZmlyc3QuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KSSB3aWxsIGNoYW5nZSB0aGUgb3Jk
ZXIgYXMgZm9sbG93cy4NCj4gK3sgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNjcC1k
dWFsIiwgLmRhdGEgPQ0KJm10ODE4OF9vZl9kYXRhX2NvcmVzIH0sDQo+ICB7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5NS1zY3AtZHVhbCIsIC5kYXRhID0NCiZtdDgxOTVfb2ZfZGF0YV9j
b3JlcyB9LA0KDQpCZXN0IHJlZ2FyZHMsDQpPbGl2aWENCg==

