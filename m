Return-Path: <linux-kernel+bounces-88147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5286DDDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A418E1C231E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DE6A03D;
	Fri,  1 Mar 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vGFnFEWp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ht37klGF"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C36A029
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284086; cv=fail; b=KnlCPCQJRXnVzNLp1wqPuXQLEvaCYiOHZFhvYH1n0ewvdAUwb2EXeBRoAIQf+5yrcA5kXHGd/d//GF1Zje6YkLaN6EaqUXs8E2Pn9ld9czEAaTnlxLs/be7ocPN4VO+m2woQTNhaMKOSQ1uyUGpPZCFXwD/3slXot89ysrW060c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284086; c=relaxed/simple;
	bh=CYVOOl0P1P8XI4RqVPOxuOH2maQbhnl+rwqVgrxx9RY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5NWFXFcC25cD4CQN5Ts1l8Lcvu4119g4V1QYNR3+esp6svR8NQtoWthjIjmNgcNj/PZqXaZH13cq0eHTLNWPlBxu43wVfocX1kj1KcMp4aNHQMYIPWF8u3pRjEQH0zk5O+IndxsibNX6UavzQ1CJpemfRkm53Fygx/vIsfbt9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vGFnFEWp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ht37klGF; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32fa963cd7ab11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CYVOOl0P1P8XI4RqVPOxuOH2maQbhnl+rwqVgrxx9RY=;
	b=vGFnFEWpdKUD6rLcAasKe+Oy760yTKmSzszEBCuVpjUQA50GyQUN4I94CMp0HZBpcAtnADzX+wOGhAbExaTvdcnOLFcTsd4UlEHIkpgtVD+A+7gcxFzmWNJ9b9kYsGt2N8hesY9xG+ek9uewYsupyHdQokRrek/yLKM2gDd/H1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2091d6ca-5ead-4de3-9899-ed7d7adc9c4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:43d063ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32fa963cd7ab11ee935d6952f98a51a9-20240301
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1598239389; Fri, 01 Mar 2024 17:07:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 17:07:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 17:07:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giQ60lD44i+7XQMzniIGE4N/iUdZEqPAfhmIqpUX/vNaq2D6Q2OXyBlf6wIma9A0M1Mv/+N8nRrstRFfCWANg+8yc5JnOgC2Pd1UYQazbEyiCfo6PtlGRAANIYfvGR4VtPm3zGo+xwm4OSK67hh/78KkLb4HjOjdIm2S8gnT0u40d5QD+MjYO3ehtNejAmNFI12qodky8AFd50y83KJ483THdbeO7As3gYCEM37ChUqsXf6XcdRvWACjV3LaAupe/p3RFgfPOwJupE1dxa0xCeFvAh9vWxICBfdH9uNHBdCod5qgGQQJkcne3l/OTbrteCJlNU7s5PeCGL6xKOBSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYVOOl0P1P8XI4RqVPOxuOH2maQbhnl+rwqVgrxx9RY=;
 b=obm+zcE99RKsn6cZ990tJr7LmemKAyrMH2bu0O/tae3/9kCrG6yEA3uw6owJ1J8AfSt+bLOBd94cCu8trIPYdZPYfPWC10l8Xt5o9xctd6eZXncum5SSmaZTbGJ592IAGyQ3pXByvIGvnb/df0twGUu31tZOBdE2In5d9Hj6T2+R2Lj/BmvLyWgiOIyTQczPFphqwv1AwFVeADr/8ZW2/W5ZLKM0BPO67WuoXaVm6eSkKkW+uUSZyR/7r08Ik8965sKyWQPurIzIbqoKenvEti0EFpB+72yUm8lTbTKCNKSKWCkuba63I4Iuhm6AxDLZeJRe8hcz7oEWy+JloTY9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYVOOl0P1P8XI4RqVPOxuOH2maQbhnl+rwqVgrxx9RY=;
 b=Ht37klGFxiUDNjH2oGfHGBOT4ltar1c3YPLYfuTCFvnB3hCiwq4SyxuQ+qqKftcKb6aoy5czw9OdjPycntcigLfzBiy87GQK8ejxz3G3/DwWCFD9Xv1Zd7NDspnTcDM0lpPP4nvAGlhf9FR52zOPz6OYhvaogI5aZUZp5uG9Vsc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7388.apcprd03.prod.outlook.com (2603:1096:400:416::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 09:07:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 09:07:54 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v5 09/13] drm/mediatek: Support alpha blending in Mixer
Thread-Topic: [PATCH v5 09/13] drm/mediatek: Support alpha blending in Mixer
Thread-Index: AQHaX/dwzlMRIS25HEKnUCzuHDG94rEir/QA
Date: Fri, 1 Mar 2024 09:07:54 +0000
Message-ID: <0bcdd451d6952f7096c4a550e345a13e710e6cba.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-10-shawn.sung@mediatek.com>
In-Reply-To: <20240215101119.12629-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7388:EE_
x-ms-office365-filtering-correlation-id: acfe8957-a619-4365-ad25-08dc39cf14c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAez6Xvn494IPfvmP01KQGS5PTtU6+8l4qScQS9Qw26yi0/HDSgoo34xMn5cxqrNJHAWfQPnivxatU9kPRMo5wZh2Ue2IkYqXnaduRnsW5ntpjIV/pGFMeuei9RGurjhsQUt/x5DtB6sGBNAt5484xtgYUTG2jHpYyyuSLmVBgSF7rJ8tgJI09UGbhfOE67mkGFYfLj3kCqBFI9VWbPTWaJ5pEmdi5UxqXguRi5zCgftVeIN3/VtVemlTUXYbf29P9lhPrRP7fXXV7cA0Fo7w51jEl2tkXumUasVGsTUw+4JuFf3NQIq6yTItdWkZBo0I+0SXUDtYAnNj9JyiEQo1ITgq+0jjDrdiH1FMsi5oL8/cM3Sv6GmPzxUGWhagsOinFSr9Mb2afnFpMBPcSXj+DDSZ1EGf91HDiRI74cLXcGebiD8fb1fLGxjbdtTNxh485Tq6DswzVQybbL6PeKZ72yO5GWWgf5KvepZ4jCxnyM++P//Wf+98mX1MpbH3j8/C4RDgtK34tzc4BFrzaUDbG8hpj8IFkrebk5L9erBmx1jgCj1bCNGGcO5bOZ1P43y24NMxUyoEnylOEYe2af+RfQbYTPspVkOSfPXdNca0KiFbU7E1yTjZoX2wIvFHTBhmJfskYAgNkwBzXqk4h+GkwOwbBNTMffCW8v66AwqumqIexqFIoKgrHB0B9npiB/zQ5JoQLJ5ZUh8YqA+x7SPC6SiprlZlYU63SbZtICOXfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlJKZ2gvTWRwRGoxRTFCUVZGK0ZmM2k5MklzV1NqZmV6WTBsV2VIdzRCMklV?=
 =?utf-8?B?QmU4YW1lazJETjhVNzRaN01kNDU5MHRHMkJOSkNvNEZiZTRNV2xQK0ZOaUd6?=
 =?utf-8?B?dU9Lcks2d2F0MlpRZlZ3bFBvTHpZWEJDZXEvbXZzS3hWcWxsSDlxQkpOTGJy?=
 =?utf-8?B?RHRLU3V3MzlEOHhlNFdTdDlFRUJTQk9oWTUydTU0S3lJbGNvcmFiMFNid3JF?=
 =?utf-8?B?QkpuYlA2SkRkK1pMaUNlSzFRajNRdklrT1I3R3JOVHdVeXJyWVdiVXRBYXZC?=
 =?utf-8?B?Ty8wRlZGMmVuSlNzUXV6SXhFcGZEK20wakhrTnF3ZzZiT1hsQjd0RHpGWHRX?=
 =?utf-8?B?ckN4blZQUS9UQi94ZHNkRUFER2FHYkhucEI4a1UwZGZ4ZWh2OW5BL2M2OTd0?=
 =?utf-8?B?eHRrTzI3alhFR2c2djgrdGRpWVlrZ3hTMGY2S1NTK3h2M0pEYk5XNFA5VmVp?=
 =?utf-8?B?WWlNdUJQdzZxSUFDWTNkUVl3QWtpdFQ0S1BuVjRMWWQ2aEtab1RFTlJCK1A0?=
 =?utf-8?B?NXY1YVFzZTRlOGJDdDBLN1Q2bUl3YTQwaGorbW9IdGx5VW5ibDQveEpHZ2Fw?=
 =?utf-8?B?dEhYeGlmeVVlaVduY09KRzJ6d0Z0THBMS04wdEJLYmVRTDBUcXhZTFdIOVUy?=
 =?utf-8?B?V1E4dXhERWxraDVreUNxemxJYzhkdTRvcXlaRHpIWXlrdjd3OUVQbWtCT0dX?=
 =?utf-8?B?V3FKcWdOekRGSzF6aFNKR1lLeUJIRmNrUnAyVi9YaUdJc3dpWkdNZlNYNnVs?=
 =?utf-8?B?SkpQVVBuYVBUTjZMUlFiR1dzZldzK1dLVUVtbVpUOWF6cWxZNUFRbDRLcnBY?=
 =?utf-8?B?Q2tpWksrVWVIWUkvOFhBbDBRakZOUzJ6TE5yQ05DaFRKaFRaY00xQ3I3QTNF?=
 =?utf-8?B?RkZDR2IvNC93UTFYdXJNaEdhVGcrZGRXSjZpRWR2SGx5UGZVbE9QSTd0d3Ix?=
 =?utf-8?B?N1N5dnRSa0svS0NPcmZDcll5eHRCdGpsRnV2WHNobU5PQUFZTHBWSnFsK203?=
 =?utf-8?B?M3g4c3lnLytacXRMa1dWdVFXUTN3ZzJYa3A4Z1JTNG9SMG5aVThyS0ZqQ2c4?=
 =?utf-8?B?MEtaejBCaVUwRjhkRnptMVI3ZXZQRVpuclAyQXgxNUJ5eXhTVmRoTHgvS09O?=
 =?utf-8?B?bGZGL3VTL1YrQTNqZlNYU2o5dUxta0ZaRlh4eWhBd0JRQ0JaRWd5M1NhZ0hk?=
 =?utf-8?B?aVI1MGt1OU5mNEFNUzkyY0VJSlA2eUxWZGY3NXRoKzNnWm1uRkNjUVRHdExa?=
 =?utf-8?B?V0VsY2hJaTVHNTVPYjczZmNNUDJOQWdHZWJpaS9nRkcwRUpETGp1eWU0WnlU?=
 =?utf-8?B?Y2ViS2VVR2FCYnVrdmx2TEdISWtjcHhlcnZlU1JJWlp1Z1B3RlAwRW1PQkxY?=
 =?utf-8?B?MmREa0NMWEdXZXBnUW1WVWdYeSs0aU0xM1BUS3FiUzhXcDJ1M251SEhJVlQ1?=
 =?utf-8?B?eS8ydC9DczZNTGdYbTR4dDdkaWVTQ1JCNENrUlhLT3FqQ2VWV3dld3dETmJO?=
 =?utf-8?B?end6NitBQy9FTlc3UTRiaVg1VHJvNnl2WXN4ZUtUU1cweFFVcVVVQlIzWHVX?=
 =?utf-8?B?bWJOUDN1c1hzTXhGeGR1ZStNVDBrQllNY2Z6UTZyUTdnVzFFMDRzck5YQ2hi?=
 =?utf-8?B?ZjFJQ2pGRzlockhRazR3WnRwQ3FKU3NnYUVPK2JjTzN1ZUpBVXBwRzFvWVAz?=
 =?utf-8?B?cHlINzhEOEZ3WEgvVVdGRmswcmxlaXNUL1owbDJCMkY1TW8wWEhvVzlnQkk0?=
 =?utf-8?B?dXhDUjRxdFVWNGRhODk1L1U4YUgraEpWMjJlUjlmam9YOWFZZi8rcnFGSlB3?=
 =?utf-8?B?dllKV3h2eUh2ZVJBdjVLUWIvQWYxSVk4Z2hHbzdDRXh2dmRzOCtlQis2aHBE?=
 =?utf-8?B?eHJFMDJJV3VibmlZQTZkOGxlNHBkUlFZWkhmMHZCRFh2Ui9ERU8xSmlhbHgw?=
 =?utf-8?B?cjRLUmREOUdHMmUzUC9ETVd1M09uVGs1V3hXVlhlaWNvY0p1QllTTVpLVndU?=
 =?utf-8?B?NnhPcGJSNE1HS0EwT2J6N1FJc3B5NlVldDhEbEJkZTBiQnlCb2s4UUkyN3dk?=
 =?utf-8?B?NzdBRnI4bTZvcENMVE80MDhtNWJ3djc0Mng1MWhmUFRYdWtxc1ZvQ0V0bW13?=
 =?utf-8?Q?hI4K6GAWiU0iJW9+BAu0Od0Bp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D017D7E435B7804D8796FA7B92C93A92@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfe8957-a619-4365-ad25-08dc39cf14c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:07:54.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvYbo8BCfUo4r4xGc8ROF3c/BF9EZ+mqzqvOETYzmPaqyBWbDzcjL57g5ezVn6LEajRBvvexJUESagCr5E1N7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7388

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTg6MTEgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBhbmQgIk5v
bmUiIGJsZW5kIG1vZGUgb24gTWVkaWFUZWsncyBjaGlwcy4NCj4gQmVmb3JlIHRoaXMgcGF0Y2gs
IG9ubHkgdGhlICJDb3ZlcmFnZSIgbW9kZSBpcyBzdXBwb3J0ZWQuDQo+IA0KPiBQbGVhc2UgcmVm
ZXIgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBjb21taXQNCj4gImRybS9tZWRpYXRlazogU3Vw
cG9ydCBhbHBoYSBibGVuZGluZyBpbiBkaXNwbGF5IGRyaXZlciINCj4gZm9yIG1vcmUgaW5mb3Jt
YXRpb24uDQoNClNlcGFyYXRlIHRoaXMgcGF0Y2ggaW50byBwcmUtbXVsdGlwbGllZCBwYXRjaCBh
bmQgbm9uZSBwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhz
aWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDI2ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRy
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gaW5kZXggNjk4
NzJiNzc5MjJlYi4uZTk1MzMxYzA2ODE1MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19ldGhkci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZXRoZHIuYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
Zm91cmNjLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiArI2luY2x1
ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4N
Cj4gQEAgLTM1LDYgKzM2LDcgQEANCj4gICNkZWZpbmUgTUlYX1NSQ19MMF9FTgkJCQlCSVQoMCkN
Cj4gICNkZWZpbmUgTUlYX0xfU1JDX0NPTihuKQkJKDB4MjggKyAweDE4ICogKG4pKQ0KPiAgI2Rl
ZmluZSBOT05fUFJFTVVMVElfU09VUkNFCQkJKDIgPDwgMTIpDQo+ICsjZGVmaW5lIFBSRU1VTFRJ
X1NPVVJDRQkJCQkoMyA8PCAxMikNCj4gICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUobikJCSgweDMw
ICsgMHgxOCAqIChuKSkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX09GRlNFVChuKQkJKDB4MzQgKyAw
eDE4ICogKG4pKQ0KPiAgI2RlZmluZSBNSVhfRlVOQ19EQ00wCQkJMHgxMjANCj4gQEAgLTE1Myw3
ICsxNTUsOCBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2
LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCXN0cnVjdCBtdGtfcGxhbmVfcGVuZGluZ19zdGF0
ZSAqcGVuZGluZyA9ICZzdGF0ZS0+cGVuZGluZzsNCj4gIAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0g
KHBlbmRpbmctPnggJiAxKSA8PCAzMSB8IHBlbmRpbmctPnkgPDwgMTYNCj4gfCBwZW5kaW5nLT54
Ow0KPiAgCXVuc2lnbmVkIGludCBhbGlnbl93aWR0aCA9IEFMSUdOX0RPV04ocGVuZGluZy0+d2lk
dGgsIDIpOw0KPiAtCXVuc2lnbmVkIGludCBhbHBoYV9jb24gPSAwOw0KPiArCXVuc2lnbmVkIGlu
dCBtaXhfY29uID0gTk9OX1BSRU1VTFRJX1NPVVJDRTsNCj4gKwlib29sIHJlcGxhY2Vfc3JjX2Eg
PSBmYWxzZTsNCj4gIA0KPiAgCWRldl9kYmcoZGV2LCAiJXMrIGlkeDolZCIsIF9fZnVuY19fLCBp
ZHgpOw0KPiAgDQo+IEBAIC0xNzAsMTkgKzE3MywyOCBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9j
b25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQlyZXR1
cm47DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKHN0YXRlLT5iYXNlLmZiICYmIHN0YXRlLT5iYXNlLmZi
LT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gLQkJYWxwaGFfY29uID0gTUlYRVJfQUxQSEFfQUVOIHwg
TUlYRVJfQUxQSEE7DQo+ICsJbWl4X2NvbiB8PSBNSVhFUl9BTFBIQV9BRU4gfCAoc3RhdGUtPmJh
c2UuYWxwaGEgJiBNSVhFUl9BTFBIQSk7DQo+ICANCj4gLQltdGtfbW1zeXNfbWl4ZXJfaW5fY29u
ZmlnKHByaXYtPm1tc3lzX2RldiwgaWR4ICsgMSwgYWxwaGFfY29uID8NCj4gZmFsc2UgOiB0cnVl
LA0KPiAtCQkJCSAgREVGQVVMVF85QklUX0FMUEhBLA0KPiArCWlmIChzdGF0ZS0+YmFzZS5waXhl
bF9ibGVuZF9tb2RlICE9IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKQ0KPiArCQltaXhfY29uIHw9
IFBSRU1VTFRJX1NPVVJDRTsNCj4gKw0KPiArCWlmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9t
b2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUNCj4gfHwNCj4gKwkgICAgKHN0YXRlLT5i
YXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKSB7DQo+ICsJCS8q
DQo+ICsJCSAqIE1peGVyIGRvZXNuJ3Qgc3VwcG9ydCBDT05TVF9CTEQgbW9kZSwNCj4gKwkJICog
dXNlIGEgdHJpY2sgdG8gbWFrZSB0aGUgb3V0cHV0IGVxdWl2YWxlbnQNCj4gKwkJICovDQo+ICsJ
CXJlcGxhY2Vfc3JjX2EgPSB0cnVlOw0KPiArCX0NCj4gKw0KPiArCW10a19tbXN5c19taXhlcl9p
bl9jb25maWcocHJpdi0+bW1zeXNfZGV2LCBpZHggKyAxLA0KPiByZXBsYWNlX3NyY19hLCBNSVhF
Ul9BTFBIQSwNCj4gIAkJCQkgIHBlbmRpbmctPnggJiAxID8NCj4gTUlYRVJfSU5YX01PREVfRVZF
Tl9FWFRFTkQgOg0KPiAgCQkJCSAgTUlYRVJfSU5YX01PREVfQllQQVNTLCBhbGlnbl93aWR0aCAv
DQo+IDIgLSAxLCBjbWRxX3BrdCk7DQo+ICANCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBw
ZW5kaW5nLT5oZWlnaHQgPDwgMTYgfCBhbGlnbl93aWR0aCwNCj4gJm1peGVyLT5jbWRxX2Jhc2Us
DQo+ICAJCSAgICAgIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtf
ZGRwX3dyaXRlKGNtZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVn
cywgDQo+IE1JWF9MX1NSQ19PRkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNt
ZHFfcGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9iYXNlLA0KPiBtaXhlci0+cmVncywgTUlY
X0xfU1JDX0NPTihpZHgpLA0KPiAtCQkJICAgMHgxZmYpOw0KPiArCW10a19kZHBfd3JpdGUoY21k
cV9wa3QsIG1peF9jb24sICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0NCj4gPnJlZ3MsIE1JWF9M
X1NSQ19DT04oaWR4KSk7DQo+ICAJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4
KSwgJm1peGVyLT5jbWRxX2Jhc2UsDQo+IG1peGVyLT5yZWdzLCBNSVhfU1JDX0NPTiwNCj4gIAkJ
CSAgIEJJVChpZHgpKTsNCj4gIH0NCg==

