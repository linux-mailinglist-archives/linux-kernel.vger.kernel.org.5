Return-Path: <linux-kernel+bounces-142481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988C8A2C23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32FDB22E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFEA5467B;
	Fri, 12 Apr 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Apgeq12b";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c4B7YUPh"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823F535B7;
	Fri, 12 Apr 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917114; cv=fail; b=lsU7sbWZwSIGLk0en4f3RkOUY5rxqV4WonkJmBcPBNZ5Hi8zH+CKeZclzZLA1fBmMGO26kMxBx/hKVZdb1fpV6c6qdeStuh3OOL8VXDkewr4r1ypP4QlW59y/F+osprWZ0yN6N1pIyvix0FapzDbAHmDdPCHbm/gKnQALhPkGQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917114; c=relaxed/simple;
	bh=27qGGB317FuMAGjmuszKEYG57Bxj5xBFLZVyomkX09s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fjHAaAQzR/wzXRuw32+Bd2QFoOcny8Mk66+MGk8WsI77aoXTPzo78s6A3H1pW5AYZU8Ha8n1nKjZnc/H/RhmuSBWLhso3a4bHy3srZasVUmhjZixJ8gx+b5AHaZQIsmUqoGK1yQaO5MHNEHw1YDexq16b3TgLe/+qeHeIpbCsYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Apgeq12b; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c4B7YUPh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fff73e30f8b511eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=27qGGB317FuMAGjmuszKEYG57Bxj5xBFLZVyomkX09s=;
	b=Apgeq12bIRpLzlIq/BMgCgVdJ+kDyIPkNaTfQH2koOChDVAoALR1SlGm/QANnsaJUyXF/IGsArKQ8EcHWvuEFpHiHxwOcCVF9S/QNJIKXZXBlf0hHJUod/bx+LPKWPv3CCfqlEB8HLpaE05n9UgozGpjjhhEMRBnjdam81MOKXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:50bd4316-1128-430e-aaaa-2f7d1cbd6b39,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:bbf88091-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fff73e30f8b511eeb8927bc1f75efef4-20240412
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 417480851; Fri, 12 Apr 2024 18:18:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 18:18:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 18:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfFvvJWuHe9RL9Cp5YDVFlKgJYQopy4BntxgNiW81HmibW4IM5g8QGpaoEMdq9BUi2G3Q+yU7+zE6MRAQX+ov7vWr7dFtXiRrOtOuVDjrvL3qbAXy/MgrTmeRrGzVfBa+N1EVRvwDRN9XSTAPUg0vi2QsyA28QorqJl1qEA4Yp7SueMo5golrC1nZQzIZCUEYjS+u+rWk9ur6cHWqCUi0fwphiEW1AuTQZ7FwP/XzPvMKTY/lQj9MkVtEjOie5VKEA2VdV35p8ZZ4idVQ0tDTu7lnKt3588WHncFZPJggowJGpXvdC8ioDrWqludWsmuKOuAPDb/UdZTbnQznls99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27qGGB317FuMAGjmuszKEYG57Bxj5xBFLZVyomkX09s=;
 b=Z0Y8ekDpDd8RVIs0e5423pVg3di/tymc0qdSvBS7ilSUirXvimT98fvPqUuXrdW27taAYvddwnDGIhFUKenAHAt3xGakH8r6oF/azQMvtxSHQBYfV7sPLDBKMB9MEZSRT4BqWJE6cw7LxaOsiNqrKyGOTYog/d+iBFKWSahmKVWaPBKHgS7PudabbD8HNY7+SegkSVBr8ojLb/znpbhXILlEphYPKqAi0Ff+QRplXAAkt/DO+4SKf2SkCE2Dn4V3l8rLDRa9v4KfyhoMhMjh3Rp1hIcYKUbYJGcq0eH995MiS6hxDlWHjzpAEaSAUPHrN18C/2nXU5sZmfRwApl/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27qGGB317FuMAGjmuszKEYG57Bxj5xBFLZVyomkX09s=;
 b=c4B7YUPhUerd7doaQbmnhqSsHB9SjTPqj6Sm46OB04jOqnwprOVEtNHDLMARCaNcLXPMO7euqiO46NOaFdI2T+nudqGpoU+d5jQ9wwinpNveRWVwQmRwocG3j41mnc7FGe71P4VmuO5nRAdXVkDbYMcp8+TJpFfbNptvtxGqkOI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB7631.apcprd03.prod.outlook.com (2603:1096:101:10d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 10:18:20 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 10:18:20 +0000
From: =?utf-8?B?T2xpdmlhIFdlbiAo5rip5YCp6IuTKQ==?= <Olivia.Wen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "andersson@kernel.org"
	<andersson@kernel.org>
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
	=?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= <TingHan.Shen@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Topic: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Index: AQHai+NzkV2m7c/nxE+B5uMVEPmmbLFkbbOA
Date: Fri, 12 Apr 2024 10:18:20 +0000
Message-ID: <caeb4e7e0c58d07d621958ca3d92b3a9b6f6c292.camel@mediatek.com>
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
	 <20240411033750.6476-2-olivia.wen@mediatek.com>
	 <5cf005b9-d737-4509-a9fb-f0e59465482c@collabora.com>
	 <6e8e553b-8c5f-404a-a396-17d8b3440d93@collabora.com>
In-Reply-To: <6e8e553b-8c5f-404a-a396-17d8b3440d93@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB7631:EE_
x-ms-office365-filtering-correlation-id: ef9e36ea-006a-4783-aff1-08dc5ad9e0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPNK/yAEGEFqZszXIm+cYz3NS0X6BID38ZWel5BcR+9lw9MrcpgGcnDvdx1xhbvLQu2f+GlL+BqgVovvpdIPaVLLaAZQfEf6+G79F+f3qApOImhjw35OhtNsriW1+39hkYmSC/F92m/Ei8n4de2fVFMbWd8AUtfnVtSEdQlNN4TV3gQfY7S7weNwS+xH43SU8mvcg4/ncYI+AvVZrzjq8ECejaXOTuLw9B/7Vp71RRYjO3K2bqJdXC65WZto/lWl/qbK6PyTxm+y6NNRqSTpY4PE4MiTyt0XC+Aw6NrV8G+OryonDFjlsMaPAh9qGSnBbbg60PCW84MkaUrMt3S08/uviAYMZqIHdiP2R1aP+VJZVfMQYwtrR3/VNAkz/gb5pedAAnuYwvDQDDZYkR9tLLpBBUTPer96qYuT4TnA5rQON6/z3HZVRoaB9sNnGg85QjYkpnaXr+kGtGLQ7NlmXktX4+Q6PN0adMT3X87jtz/vp9XTCq2FAJKxqC9+kq9V9LjrzS6H5mYUQSJihU7BTmRQtIMHYQFz0ZEXtqPbA8J4w6NimXjr9K7qIsAr9OpqkOMuLZY2BwJ3GUubqGJMZvt8izKDWDA8hcxOUf/LrHGbKtzZhDoP3WrV8Iyw5s8y31/Z80nya1qV8Or2OMnhhyWyvIzW5dbSaTsBnAUKHi90QtmLBdSnpJXshZYZHz1dF3LBEx9Y65prUsP/jy6ttTV4/ImX3kzqxgHGq+FynTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDQ4bWgzK0xKakh5Tk5pYXA1dVhOTmFSbFJIWit6VkR2NWtCRGFMcmJvUWl2?=
 =?utf-8?B?RmhxZ2J3Vm81RzE1UVBsVEVxYit0bFBSSFRURGtlTi9zaTl1QmtweE05ejlp?=
 =?utf-8?B?N21XaVBlZGlTWUNicjIzYk1Obzc0dzZOL0s4TXJld0JoK21GdXlTRG5idEcr?=
 =?utf-8?B?b3lUKzFyZG1jWWRTdi9adjZKdjlyUzQyQ2NrQlgxV1l0eVIyR3NzN05TR1px?=
 =?utf-8?B?bmdQRTBSbmFIUWxIUWdPRW1tSGhMY3B5OEdTN0VxenNnV1lvdytjd2ZlSFZh?=
 =?utf-8?B?MWZBYkNSR0FIM1NxMy9OMTFqSisrbGRQeitWS0d1d1Y5ZERBcmpkN01PeWxB?=
 =?utf-8?B?YTF6SjBNMmd5ZHZEb1RJb0RBaXpOa0Z5bzFxOTE0d3NDT2RRRHhQTTNBSkpa?=
 =?utf-8?B?ZFJyeCtnaDF3T0JBbExhcmdydGNvYVg4MUdLMGxmQktZY1hCc2R1c1RDeFBl?=
 =?utf-8?B?ZUh1aXlUc1EvRkFzbXhJcHhoSVk1dG9aK3Q2UHgralcxTUpBcWZYSkJZV1ZH?=
 =?utf-8?B?NkV6NHZpM2RUMXpoOXRoYnpLUGI1WkVyZVlGOEdmWWw2U25IajB0U1gwR2JV?=
 =?utf-8?B?bXZodzdLS1lvRlozeVFya3k1Snl5NnFkVVM4QmEwNjhJeWRIdm1IVXZkMHJF?=
 =?utf-8?B?aVBJSDdYak4rRnR5endHRkpwVTNhYnlZTVdNRXF1MHE5eVM2WDF6TE9tVGJH?=
 =?utf-8?B?ZGZqT0RTZ3h4UDZEMFhnVmdQZ2ZKWE43ZVhGaXpRQmg3VTRlNWRmYi9JVlQ0?=
 =?utf-8?B?R05rbUZWUkdVbTdvT3c5RHNiVjhSeEk0ckxnb3JCeWs2Uk1CUnFpdE51dXBi?=
 =?utf-8?B?SERtWmI4d3lsWXdvWHFSRjBMaDZsOUN3OVpDTHFTdHdUR1Z3ejIrbWN5WUN2?=
 =?utf-8?B?WXVVdi9YM2RTVnJtZFNKMmZxWnMvSlkrZDhWTUpYVldIK0JtZTN4bWJXdHg0?=
 =?utf-8?B?NnVxMS9EZGFOVVVsejkvSVdrS3NrSUZuRlNrbHBhdFVSMEZnS1d4VTV1OEQw?=
 =?utf-8?B?V2JhV0pGbDdVcklrVzh6cTc4REc5Tk1vd21xMU5xSkg3anYwS20yeEJabklp?=
 =?utf-8?B?WDgxdlRSeVU0S2MwbHNlTkZjVEYrZHArMVN1UnBXdzlMWE14dVBOMytnM09X?=
 =?utf-8?B?YjJGa01lSFdFM3hocm1jNnlJcE1HcS9mM25OT1Q1c0w3RE9oZDhQcFJkRHE0?=
 =?utf-8?B?YkF6czFOT3BvMFhHNGVCYTRUYkpWVVJSTC85ak9wamE5TUtoaFlJSjR2WGtr?=
 =?utf-8?B?aVJUZXc1WGFxRG9zRmd3dHlQYXhydnVjYUFJMFpoaWF3dzhkK0dKWkJhQXFE?=
 =?utf-8?B?WlNPREpnQkt2MEEzTFdGL2hBdUpJdlhMbmozVGJnUmsxOVFZdDRWVzl2dHhr?=
 =?utf-8?B?VlZaUzVLY0o5RGZNV3NLcmpxMGNSRkdLeTV2ZldCaFVKZTZPNldZTnRMbEtC?=
 =?utf-8?B?RUY4ZTNCRldiQ3gxbHR2Rm1oc2FzekE1WGJsRzdIc3hmTkVFMFZMT0dheEpn?=
 =?utf-8?B?NXFERkxPTWNzc1Q4MEtTYzBhcG1YUkN0b1hnYWtaMk9RV0NhSWhBS2s3ajhH?=
 =?utf-8?B?U2xLb3BUdm1qalM4c2duUVgxcm8zcXN5T1U0Y09sRzlQWU9wQTZEMTMydmlG?=
 =?utf-8?B?aHlWL0JsR0dyR2o1a0tvQ0ZCSCs3NnlneEZHNUxDcHIxR3lVWlRLd1J4SnZx?=
 =?utf-8?B?bVkxQktuN1h6RUt0VFhFUUZVcDIrRFpHYnpUVVY3SWFsRXk2VVBiTGhqVnlk?=
 =?utf-8?B?YWhMMnduMFFXNU9EMVIvVEp3dS82UTZ6L0d5ekVTUlQ4YWM2dW5rNmgzbXd5?=
 =?utf-8?B?K1BwdWlHSmFlWGt4eFgxMlkzQlM1VlBxOEZtUHd1SVdGZFVQc3hCNEVzbjAw?=
 =?utf-8?B?RGZZanJTRnNYZmN0eEJXTmhjSlY0SEtib2pwU0NPZEY5L3BPSjhhTFFRUy9P?=
 =?utf-8?B?L0MyYytCZkZVY2ZmRlQwR0lGRVo2cWpGNjhMdmt6S0poVnlNSE1tai9POHJp?=
 =?utf-8?B?NnRzczdHb0tXTWcyUStGSktDUmltWTlnZ0tpR3RUN2NFN1RzM1VzdmEwSXNO?=
 =?utf-8?B?a2Zpc3BYSzJnYzFIYnAxNUU3Z1l4aC9SU0FWZEVPWHRSUVc3RU5HK0Q5MG16?=
 =?utf-8?B?Sm1QbXVteWtEdjVmOHF1K3VlSUl4KzQzMUo2QVNNOHkyMFM2NnBPSzE2Zkw2?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5023A37EF5539B498EDD808538560ADD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9e36ea-006a-4783-aff1-08dc5ad9e0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:18:20.6365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7p2hTxnA2iLLDdZtBNrJlBEBJWs99GmfwBRSImkNTfKjSDrt5uBemsh3ED0bxh4oQJ2T1FncrZhqBMQ2kUv3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7631
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.659600-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXY9FWgANwn4kLtSq0qk6SvLnEjLiYgp5vhA9lly13c/gExXH/dlhvLv1pbYq2f4jz+fmD
	BY9YlH79EilqyAMpqss0UUyUNQxLRDHlMveoJOATmAId+2bAQwvySAwufpFSKmyiLZetSf8n5kv
	mj69FXvEl4W8WVUOR/joczmuoPCq0df3vMTG5xQ1mD4LLk0izcVMgzjBd8JDTVavgPFPTjSMP+n
	AMZRav2
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.659600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	494391BA1E72F39E9F3744A9ED37CCB79EABE53BF165D5B65603A8A8E4AE2E9B2000:8

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KDQpPbiBUaHUsIDIwMjQtMDQtMTEgYXQgMDk6MzkgKzAy
MDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxMS8wNC8yNCAwOToz
NCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gaGEgc2NyaXR0bzoNCj4gPiBJbCAxMS8wNC8y
NCAwNTozNywgb2xpdmlhLndlbiBoYSBzY3JpdHRvOg0KPiA+ID4gVW5kZXIgZGlmZmVyZW50IGFw
cGxpY2F0aW9ucywgdGhlIE1UODE4OCBTQ1AgY2FuIGJlIHVzZWQgYXMNCj4gPiA+IHNpbmdsZS1j
b3JlDQo+ID4gPiBvciBkdWFsLWNvcmUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IG9s
aXZpYS53ZW4gPG9saXZpYS53ZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL210ayxzY3AueWFtbCB8
IDMNCj4gPiA+ICsrLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvbXRrLHNjcC55YW1sIA0KPiA+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGssc2NwLnlh
bWwNCj4gPiA+IGluZGV4IDUwN2Y5OGYuLjdlN2I1NjcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGssc2NwLnlhbWwNCj4g
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL210
ayxzY3AueWFtbA0KPiA+ID4gQEAgLTIyLDcgKzIyLDcgQEAgcHJvcGVydGllczoNCj4gPiA+ICAg
ICAgICAgLSBtZWRpYXRlayxtdDgxOTItc2NwDQo+ID4gPiAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTk1LXNjcA0KPiA+ID4gICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1zY3AtZHVhbA0KPiA+ID4g
LQ0KPiA+IA0KPiA+IERvbid0IHJlbW92ZSB0aGUgYmxhbmsgbGluZSwgaXQncyB0aGVyZSBmb3Ig
cmVhZGFiaWxpdHkuDQo+ID4gDQo+ID4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgtc2NwLWR1
YWwNCj4gDQo+IEFoLCBzb3JyeSwgb25lIG1vcmUgY29tbWVudC4gUGxlYXNlLCBrZWVwIHRoZSBl
bnRyaWVzIG9yZGVyZWQgYnkNCj4gbmFtZS4NCj4gODE4OCBnb2VzIGJlZm9yZSA4MTk1Lg0KPiAN
Cj4gPiANCj4gPiBBZnRlciBhZGRyZXNzaW5nIHRoYXQgY29tbWVudCwNCj4gPiANCj4gPiBSZXZp
ZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiANCj4gPiA+ICAgICByZWc6DQo+ID4gPiAg
ICAgICBkZXNjcmlwdGlvbjoNCj4gPiA+ICAgICAgICAgU2hvdWxkIGNvbnRhaW4gdGhlIGFkZHJl
c3MgcmFuZ2VzIGZvciBtZW1vcnkgcmVnaW9ucw0KPiA+ID4gU1JBTSwgQ0ZHLCBhbmQsDQo+ID4g
PiBAQCAtMTk1LDYgKzE5NSw3IEBAIGFsbE9mOg0KPiA+ID4gICAgICAgICAgIGNvbXBhdGlibGU6
DQo+ID4gPiAgICAgICAgICAgICBlbnVtOg0KPiA+ID4gICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE5NS1zY3AtZHVhbA0KPiA+ID4gKyAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNj
cC1kdWFsDQo+IA0KPiBzYW1lIGhlcmUuDQo+IA0KPiA+ID4gICAgICAgdGhlbjoNCj4gPiA+ICAg
ICAgICAgcHJvcGVydGllczoNCj4gPiA+ICAgICAgICAgICByZWc6DQo+ID4gDQo+ID4gDQo+IA0K
DQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KSXQgd2lsbCBiZSBjb3JyZWN0ZWQgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KT2xpdmlhDQo=

