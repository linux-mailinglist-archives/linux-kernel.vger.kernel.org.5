Return-Path: <linux-kernel+bounces-142545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A168A2CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ABB1C22B81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EE42069;
	Fri, 12 Apr 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E3L9nXnu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BzmwYB+V"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369443AD7;
	Fri, 12 Apr 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919647; cv=fail; b=KX3MhrS4QbLLAbw8JZCcAXVEdFEA+BE6lh3Ca4HzZ48/UfoVT49jii4VZUNNkzNkAbDtQeT3Z+56tH21jUMYntHebGpyO18oL7iF1TCaA1z01qu595n0JgMaj5zi9sarQodBw0my886RnG+kipsWzJH1CsDRdIU3Yb54wuz50mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919647; c=relaxed/simple;
	bh=OP0RV2Vy0dypvX+F26ZnwOTjKUcx15+5S5xhFxAMAAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQtjcvgom6HsabjdTn+YOUrq1lnWrSeKeOithNJ1AFEB3fknAjDGERWNVaJFecxdOtf8D7LGWJwbrwp2o6qixT0zDbZgWJKXz2+qguSGgdViS7D8BFmDunw9Y1T5r5hn4x15g0VDiX4g70Axt4KWjtIQem034eaS0qdi3fn1neM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E3L9nXnu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BzmwYB+V; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e638961ef8bb11ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OP0RV2Vy0dypvX+F26ZnwOTjKUcx15+5S5xhFxAMAAM=;
	b=E3L9nXnuKFkUSVcKCYON1P9cGbrzjDAkJavlz6LHYSQY6MnduhX1A/MptC09KWTomK4b+MyESKWyBMy8Y5OzDEtQqi4amiBrbkmGM0CCU3ZJhvlEbGzptJ48p6GmUXIy4/UfjQJKcF7GOUNqtQAsPSe0jzvUauDvTJOLgfnpne8=;
X-CID-CACHE: Type:Local,Time:202404121814+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5a1179ce-2fcb-4438-b872-e2e2fc745594,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:d05d1a86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:0,Content:0,EDM:-3,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e638961ef8bb11ee935d6952f98a51a9-20240412
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 341757240; Fri, 12 Apr 2024 19:00:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 04:00:38 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 19:00:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS18k4JCrzro2LQ7ZAfTMlQhYKFk9CivSAVB+/hDOimen00FR0q9J2TizLKE4qAHJQCYUeeAM3MWKzjytUZ6aVeJT5MnYeT64HWpJEa+LmWfp2dy/qvIiTkaTTOMv03xo9exJa1OcN30wB5URrtq1aI5XksZ2Sir1+mxcgYK1MOkFdcg1lCirHebZ3gD44o2OijRotdo70JxzmOdSnY5wBJ9kCkZ7a6RUTRSpTiTpCBMUN1nPzIePNeyT0Dtzpit+d1u6tBtdiVVkidaLtuEei0kOBMVmftpBfR+nnp4UzdHZUT0bofmj+/1DgwaPvnkFAhxw+4C/NANzPdhucsUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP0RV2Vy0dypvX+F26ZnwOTjKUcx15+5S5xhFxAMAAM=;
 b=idzDH/u1aPuK0nNEOax7ERQbdYKrKz9UoZDA7LoPJxC/kle9FkOt3ZswsrVl61bX6evRLmhk8efv5LHMe5Q/RlK92ctQHH0IyyvjbZjaaf/OPe8XX7XnfvCFGcBjDkUM9PR3mS+mLUo0UNxWQfVko2haNzBfVjYy/tMn7UO6MU0Yy+9111xwvIDWxHAzap1lyLuQulMpurNBfLq2EOQ21CeNSe7DMgK3h2oMoYTE4Zun5UT6CFGPGwLeYmW338rc12hWugUnh05Mle65YdF1r0I240vf/QK4Q+Ki+zQ0S7/lvjlMMh9BU+twSR37zsbxLY3EgMJ9tfp0+bDy3nAhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP0RV2Vy0dypvX+F26ZnwOTjKUcx15+5S5xhFxAMAAM=;
 b=BzmwYB+VyYj+CfPrGcTVDQgPBbQ6K/7/LgrQcKA0YLFnSHZ0lEAe7DwC9Q2fz0cfCWhgM0P9mpiw8sw43NPozBZsPGbBrQerR7Dei3O+MF0BHAqJIzQga/x69bLDlkU9sxVMvt7UoTCyUonBgkpLkBQViRTc9JYW9ahmPGE0cqc=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB8901.apcprd03.prod.outlook.com (2603:1096:405:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 11:00:36 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 11:00:35 +0000
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
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Topic: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Index: AQHai9aSf5MLPhJJL0KB/Q681KNVHLFkeZyA
Date: Fri, 12 Apr 2024 11:00:35 +0000
Message-ID: <d5116ce34c051da340b743c31480fe6918729716.camel@mediatek.com>
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
	 <20240411033750.6476-2-olivia.wen@mediatek.com>
	 <7598d482-456b-458e-a0b6-b5767f9c4863@kernel.org>
In-Reply-To: <7598d482-456b-458e-a0b6-b5767f9c4863@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB8901:EE_
x-ms-office365-filtering-correlation-id: bb354064-b3c5-4d51-77b1-08dc5adfc802
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88EuamWMEB8Za7i+JIzYO8HRIUfVbUX9MmFsgSPpc5+k32+XFVqZkVDCdJqsuCNtyjpDG9HfCPJJ4mcHEuuIfNWYLnfk5TCxtYESxfNAgroZcwACCXmJrsxr0Sb6JBevkK9GCMBC0xUIdATbO3WdnMveDCbALK5gk8/jJy67sUQDS6yGqB3ZNFWAQ7ObU0P/Ev51If+1XtkbQBmFDWqpgZ0HKRojeBl9IuLGsafQrqOpuFMq8NnxXX68JAYM6RQZyjrv371uJB1SM50DpIsI3AaPSvWh9AvI3P935fkl4UUwIDzgeLYjb6CKK9O2pn1wWBN/pksBv9oShQi8hq6jMpwxg5tLjS24LafArKn2MEdPdhC6PFk9x+bsOjqfqW1Y8JBeW6IvIoev4cvJtQtY1gET1HMYouqojgRw6YxlFr2qTL6Q34TFPrS6BlLOxS+PaTc6nmlUDy7081t8Hpcbcm1XycQP8Q7Z/9KI30TCeBHu3k0/Td9trf9J9fPSbqx9Of/JiQjx5j2myzl0SQoBt8dhqLSptA4Ui2m2VCtENduE0FiW7/ciaPFnxl4A7Y1CYycxjLO9Re1NenTctMBRdtgcLP5oGTdAhHDCzjCjcEjpCrLQEuHiwQJd5YwcPw3RMU0CScB/P3ZnRnl6oA24kddPKpMRZ92vGZDJUDgzSPPzeeQQkXRMMI4F2LpSbk5jTHWuQUn/biL7cw+6f+XZKZBCsBUCxHrGJWZoUwyjlfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGsyUjJ3WFNoc2NHdlJld2Q5L1BIeVFWTnVPNjRIU0k4NjMxcUdNcFZURFky?=
 =?utf-8?B?QXdMeE0zY0U1RDZGM1J0S1ZURVViUUw3cm1VMzBkY3lNZStJNFI0R2NGKzRM?=
 =?utf-8?B?MUFoRWV2UHp1RGdreXpuZTdCQWZFYUxMamNYR3JaRmxEK0FLOUNKK0MvQndo?=
 =?utf-8?B?Lzhta1JUYUNBMXVRdG9MMmFZQ3oyZUV5V1BUeXc5L1ZxWmlJQTArcFY1Mk9T?=
 =?utf-8?B?cGpjZitkYldkVjQ3MXNGejZiL0ZsL29FbTViWklNVnprcWM1eFNQc0QzVFA4?=
 =?utf-8?B?OGFaMWxaOFY4UzZzdlZ6QjdHejZSTjRjZnI4ajQvcisvNjA5Mms2alJaNUdi?=
 =?utf-8?B?eUxGNXFLanV3SHRkOXd0RVFKYnRKQThlOTFkOE5GTnBYc1ZmUllmR3VjL3Rm?=
 =?utf-8?B?eE9IYXdySGw1K3ZMZlNPTnl5YXFpaTBseXN4RHpVTjdUeVJ3dlkzZ3I2NmZp?=
 =?utf-8?B?YzlsRmxRMTdhMUNaUFptWGNYcHY2WVlVdHZwbU4zZFd1L0l0eHNHR1VUT1Zi?=
 =?utf-8?B?aTJBLytyU0E3U2p2TmxUUlc0QVNiRGFmNENseTdqbTU3Rkh2S3RiVnJJL2Va?=
 =?utf-8?B?UW1jWWJkdHdxbnZocnRJeHNkVUpKbUFLZTRBZ1k0dWlCWFBIcjRRQlFvRzBo?=
 =?utf-8?B?YkpIZWFuenc4L2gxMDJpbGxyT0sxYUQwSlJ0a1JUMitOY3JxdUw5VlVBMGFJ?=
 =?utf-8?B?L2pRRE82VVRHQjNuaDUxNlJiVU5RTWhVTDA1cDhKYmg0MFNHaEo5dlZudk5E?=
 =?utf-8?B?eXNmc1ZmcmxKdDNOWHdrSHpxV0pRZ3VveGQrMGVBSmFwTTFRSTE1VnpCQUVC?=
 =?utf-8?B?WmpIdldPTThqN3pweEk3SUwwRzdzOFpVSWR5K3drWjFRVEtZQVVXVWd5QWhP?=
 =?utf-8?B?dVB2cy9HNWVYQXpTb1Y5U1lXZFdHdGJTRUNqd0thTlgwSlNvZ0VoczhZVnNM?=
 =?utf-8?B?d081ZzB1ZzhvZlJDdThiZ3h5VU1vZ1dVZzNDM09DUDBEejBJYVNpMlR3NSt5?=
 =?utf-8?B?NmNFZVZnSkcrb1RRUjhGZUdhMld6RG0vN2xsaEhuSDdqVEc0RE1yVDdlK1gv?=
 =?utf-8?B?QkhHYmxDaDhQVTR0VjRIelRxSEh2c3UyMkZib01MbHd2OXh4cVBDck1SVzZR?=
 =?utf-8?B?K25rTGdSRXZvby9CbEt3TE4vclhOck9hVjI5SFNlcTZ0bXU2ZXhGay9qMlJ5?=
 =?utf-8?B?VE5oeGRyK3IrUUZEcHg3VytGV051akdRQVN6OE1zeU5hRkpZbWoxUzhvS083?=
 =?utf-8?B?VXFwZGVXdjJ0OHcvK2RhNGpLNDhpMzNHQUxMQk9qZ2c5QUlSWkpGOCtGT0VT?=
 =?utf-8?B?VzM1a2Q3cnVZcjEvTEFBL21ZSGRXUndxU2R3bjdqK2dnc0cyRWlTM282MWhh?=
 =?utf-8?B?VE1EYjlLTXBtWllHeVkzRXlDV21GcC9qK2IraWRhc0Y4UzVvSm90Sy9tdnZt?=
 =?utf-8?B?RWdma1BQYnJLTWtUUHdHU3lyKzVJZUV6S1YwRUdUb3FSd1NmKzlibTRFZFln?=
 =?utf-8?B?aHY3N2hPLzFZdXp3UllKandGM3pWTm5mUEo0U1hFRjgxaWhMU2YxVTczbDJj?=
 =?utf-8?B?V3JnNW1IWU0velFJK3hTN2MvR3dldXlKNXgxalJMMkE1amM5ajdCcXlNaUZU?=
 =?utf-8?B?a1VsQUtwK0VYNktSNzF2dlppWDIvcXJKVDZlMWtZMk1BR1JJTEs4bVNDWk5F?=
 =?utf-8?B?blVOV0ZtZXhyekZtV3B0TEpESkdpL0MwOTNTTiswMUxKNUhIQVlHOWpPZ1pH?=
 =?utf-8?B?YW5hcG5oTnJPN0diY1hIWlhucnRhTW1UT2crd2hKWFd5MTZKR3l5c3liRHlH?=
 =?utf-8?B?anhEalZzWjIwdmNyWExZcmFIZ3hpdE1MaHBzMFAzRUlZaWRXbDJYV3BURnYv?=
 =?utf-8?B?aEN3b3lXMzI2ZEpCcGJGellmZXZtakhvdUFtSnEveExjL3EyYTJQK0FlQ3Rp?=
 =?utf-8?B?Q3NYTmFENnZZcG1WeVRtMEdUdWM3OGJ6ODFxbUJBZjZiZDQyWGgxdDZ1alVh?=
 =?utf-8?B?NE5XaWVMZDZIdWVCL3ZFTzVWVlNpUkRSdzFsK0FLNmdySUZjQmh2R3NRY1lr?=
 =?utf-8?B?NVllbityOVdST28xU1NLMDVWVnV0YUtwdk1MM0MwQXZaNUFwSnh6aUQvd3lt?=
 =?utf-8?B?aDZaS2tuWUd2dmNFNlY3MnA0RTdJS0xmTzlQZlhSeG5GTlVzQmhFMGhzOXhu?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E3D6AAB5ED9824F9702B4AD465D8B56@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb354064-b3c5-4d51-77b1-08dc5adfc802
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 11:00:35.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u19JZKQ0LvAaoVwAFbXxdpjp7aEnqnHQGWs/eywg1+HRnk8eKfB2CrBFhhHe9mM6ILFw6EjAHO5UzsJ8g6YRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8901

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUaHUsIDIwMjQt
MDQtMTEgYXQgMDg6MDYgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTEvMDQvMjAyNCAwNTozNywgb2xpdmlhLndlbiB3cm90ZToNCj4gPiBVbmRl
ciBkaWZmZXJlbnQgYXBwbGljYXRpb25zLCB0aGUgTVQ4MTg4IFNDUCBjYW4gYmUgdXNlZCBhcyBz
aW5nbGUtDQo+IGNvcmUNCj4gPiBvciBkdWFsLWNvcmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogb2xpdmlhLndlbiA8b2xpdmlhLndlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBBcmUgeW91IHN1
cmUgeW91IHVzZSBmdWxsIG5hbWUsIG5vdCBlbWFpbCBsb2dpbiBhcyBuYW1lPw0KPiANCg0KVGhh
bmtzIGZvciB0aGUgcmVtaW5kZXIuIEkgaGF2ZSBtYWRlIGNoYW5nZXMuDQoNCj4gPiAtLS0NCj4g
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvbXRrLHNjcC55
YW1sIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGssc2NwLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGssc2NwLnlhbWwNCj4gPiBpbmRleCA1MDdm
OThmLi43ZTdiNTY3IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZW1vdGVwcm9jL210ayxzY3AueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL210ayxzY3AueWFtbA0KPiA+IEBAIC0yMiw3
ICsyMiw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNjcA0K
PiA+ICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1zY3ANCj4gPiAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTUtc2NwLWR1YWwNCj4gPiAtDQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNjcC1k
dWFsDQo+IA0KPiBNaXNzaW5nIGJsYW5rIGxpbmUsIG1pc29yZGVyZWQuDQo+IA0KDQpJdCB3aWxs
IGJlIGNvcnJlY3RlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gICAgcmVnOg0KPiA+ICAg
ICAgZGVzY3JpcHRpb246DQo+ID4gICAgICAgIFNob3VsZCBjb250YWluIHRoZSBhZGRyZXNzIHJh
bmdlcyBmb3IgbWVtb3J5IHJlZ2lvbnMgU1JBTSwNCj4gQ0ZHLCBhbmQsDQo+ID4gQEAgLTE5NSw2
ICsxOTUsNyBAQCBhbGxPZjoNCj4gPiAgICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAgICAg
ICAgZW51bToNCj4gPiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc2NwLWR1YWwNCj4g
PiArICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtc2NwLWR1YWwNCj4gDQo+IEFnYWluLCBr
ZWVwIHRoZSBvcmRlci4NCj4gDQoNCkl0IHdpbGwgYmUgY29ycmVjdGVkIGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNCj4gQmVzdCByZWdhcmRzLGENCj4gS3J6eXN6dG9mDQo+IA0KPiANCg0KQmVzdCBy
ZWdhcmRzLA0KT2xpdmlhDQo=

