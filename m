Return-Path: <linux-kernel+bounces-116383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0988963C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638CE1C2FEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700C130E5C;
	Mon, 25 Mar 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aHolh4I1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CaHT5G6g"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC913957D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331566; cv=fail; b=PgtTdgWbzICYRzqPfhVkxnQzbM9RqACnAdnya0LGKxHZlNPXmgBjQvPLEHImfhfXZzNlj97D3lf78naS/p58lBb040fFcjHkjuOYAis7KJhBAfD0JE1KJ20lXNei4IBKzgZFipr4S14qzlJj7RFEsJA7cGGLH+Iu/MmZKQMswqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331566; c=relaxed/simple;
	bh=3RzT4Zcq/09Xyf6rDEBipFAuZWaIzRCWi6EQXIS47xY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTbR4lwEhiMe966a3OG5hcV8ak6fgY0EYhFINcStHLoX5ig/eMuU1vPz7G1d7PGJqq9MlIJSaXxcUHz8271RtmKBdM2OSXEsoZMBaTdDNTKuIE6wttV7bryxxe1NTM3hq2jJQdDVW497zMS4FmOEfxTjfHAKikHKdWhHF7KpNKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aHolh4I1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CaHT5G6g; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 57c978aaea4a11ee935d6952f98a51a9-20240325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3RzT4Zcq/09Xyf6rDEBipFAuZWaIzRCWi6EQXIS47xY=;
	b=aHolh4I1909OVAVgZgj3IlxeTwjd7Mu0rOYFPbTj6u03uF2llNFZISXpWw3O8UvbOcVcfl8ObqXEfNdaL/T/VCtVxGzCZrz/VLrLl9dFpynyoeA4tEP3TSBvdbDaU928ny3LaIdDzSfXaVRB2rVCRJAWMonK3QA+CU7TXii8VCY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0a519265-a167-4d4b-a859-96b876cfb25b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:1065e081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 57c978aaea4a11ee935d6952f98a51a9-20240325
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1463350650; Mon, 25 Mar 2024 09:52:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Mar 2024 09:52:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Mar 2024 09:52:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvGKwhBDbA/oXrB5CCs3WDKzdadDWK18wOcF2ICyYwhhTVNUmBXKmWgWQcxiWXfBoeTKbFvNlN31gOh3dtBQZ/wZN+PVEz51bz+wcMYVLnpX09EowqkSh/C7Dthd+fix0tuSfgKidY1FgOV6pKg+/cKNJULVcipJz5kS03F0qmNvlHfyTuh5oevmJEScpfcpQKI+aym4KJd5UFJDQlqzQofxSnHLOHsXvZ7PX6kSGjrEGGB2VIUa8uWcKDNcygAQism0M61CnFMXI9I3GRGjeXhF8PPhUqHvc8aAiswdQ16RDORyv0Sa3Vg5vcz0WKllCi0xwnhlkpriBtgjcf8xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RzT4Zcq/09Xyf6rDEBipFAuZWaIzRCWi6EQXIS47xY=;
 b=Gp5brppyJZlqAQGIkvzJnMtlD3z2sQiFVK/r3vqJbNsSO79WMy1PHVz9n8QzlaplBvi/NSThrOsH2Wl41LB3EoqjWPrVjzFYxOqmxDXM6ls1+2YD2w6k0tbS9g98AtkFvwni7o7w2Z2GuMW8wpimpJy6ZFLQqFYwg8HGe1t50RH3DVTkpCcw+IF5J4bfqTyo40iAML3oSL2nOh6Kd4pbiM9/AqnNJJujrcLC8pHAhvsqkIdsFGRAJbW91HdxER7Mquv2gLMA8xXU5HCj8FEiccMbZol36J2GvrhcAd6epeEjrsg0l3dhInp2nsKySRC1fWU1LtXxN8FRy3bwxecwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RzT4Zcq/09Xyf6rDEBipFAuZWaIzRCWi6EQXIS47xY=;
 b=CaHT5G6goDjncVa5dbRL7sGZWctKD7DeoBjzUWJq6ANeLI6ny5xrTc3jJgHSwOFEgpDqlSnGO37xOOPXNuefxS3cuxtkE4EhrqQBPjn+Bot9G4CxNaP6vZdw0Hgx3PaqbZlHbeTL2+R3gy+vZhZqlZlXTMXwimjSkfziaGjrFxI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI4PR03MB9201.apcprd03.prod.outlook.com (2603:1096:4:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 01:52:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 01:52:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Topic: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Index: AQHafBnuCAQWF4qq7ESf/M74clw44rFDd0KAgAQ+tYA=
Date: Mon, 25 Mar 2024 01:52:27 +0000
Message-ID: <fd3beacfc59f466ab5e51276a3479c0501350a39.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-5-shawn.sung@mediatek.com>
	 <a5b00d343b922e726476e4b3c1973d44a05aacb3.camel@mediatek.com>
In-Reply-To: <a5b00d343b922e726476e4b3c1973d44a05aacb3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI4PR03MB9201:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lg+uVvs6qVrQu43C8FhBpGcQUQpikfRzc7Hq7LllUmvsYeUSpJTKOOQwUrfPb5gCXSwzz1S8X3DiZkvjoradPqouvkPOcvxkIrZ2qqOttxLeR6L/6XGWutV3gqWgreU1MOA0CW97F6lCnccPcRY6BC8v1mCMLQp6AOATdLa4PD8rOIiCqfUTaSE1PLGy78/fgK8YuXnXANBubR1sOjEVSmE8FPsGkx/HqLeCWebN0gAFdHzQk97vTP2khkUgLJ6WOFl8Ooix5Yht2sB2emKoS98P4zfJpIj4my1RPMznQBZc57IaD8aJONujttMcvL1bMHRn2AEDPMD3RkL2dbzbc9j0iWpYYFwr6X4zo+iMA14bGB61eU48Dhc6AfajiE/g9TdMects7acx319N8ZiwJuTi0kMn/H+2yiJClmMgAddDvRHpK239MF6v8s8uwU/PU8RrjgqU0rQCU6ALPLGR18iUQK9DU1Pqc2wO0remzdOFJBJ4tHzZEk+yH+50qmWdCC2qGFIeaGaBaYc8J+bLjKrABGQ7zvg92vESgXmT0qXbX4Ke0DcUFy+gALJDorpi3tTNWN+mdwm/STW4WsVq7p8di6sqwMliNspbfF12eVLwx2rj+M5I2T09ldEGQZ3mD1BUY6qRQlEjG/Zi2im74mAMAGFm7N0whJH0+wc11XQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1VQMlBJeXYvQitJNlpXQ0xuZHV1aXBLWmZzMmVJKzlYcGdpb2RZN2psLzUv?=
 =?utf-8?B?Znd1QkZVYmpqazhNM2JiZzZrNjZnMzhVeVQ5SkY2dHBMcTFwOTR6czRKY2M0?=
 =?utf-8?B?UG9ZcGVyaUNiNExyNER3ZDdpeGMxOEo4VnBBL3dGYXJXTnVISHlOY0JEQjVF?=
 =?utf-8?B?U29yNnRrN0dtekFZQUlKQTIrbm9vTVJybHp4Q2t3Ky9UNW81a3ZJMWpWSWdk?=
 =?utf-8?B?VFd3OHZ4TVdIeWVSYzQ1N3BNR2g5UUtGQzZVSWVBdzBvamJmbEVZRFlwdXN2?=
 =?utf-8?B?bEw3ckxFL3B6M2xxcEQ2UVQ3dlhGR25QcXByc2ZacnRpVWs2OG9vRUhaSDlW?=
 =?utf-8?B?bjJiRFNWVmZjcUphaTFQdnpmMUpkcTI3UG1PZUFscERzQXJDVzdGekI5RHRK?=
 =?utf-8?B?dm1EOWp5SVB6aE5IR2laYVRuR0pvaURsaTJQSFpBM0RUU2o3S3JoUmwwV1VK?=
 =?utf-8?B?SGpSOTBqd3dYNk10a3JzZHI4eXBEZ2h0dU1sS0ZveUF2a2JvampMV2h4ZDhZ?=
 =?utf-8?B?cGk2VEdWZXNVQ0FtbHVzTlp1NkdSblhtUHI2WExhOEF2ZlVJdzgvNkJVV3hn?=
 =?utf-8?B?WTZjaEhnWHFlUHlRdGFpTytKTTY5VW9SVHI3ZUl6aTNTY3F5dlNrT2lVeEJ1?=
 =?utf-8?B?L3RpZk1FYmVERWNMUEIzNkFvZlBxQTRHWGxtZ2xKL01MNUxFcXBCS1d0YUla?=
 =?utf-8?B?bVdpUFpCN2VKZk9XRzFucTZKNzNIaFZydmFlb3FudzlkSm9NMXAvNVlJbmRF?=
 =?utf-8?B?RzFkTTlJUFpBWEpoQXJvbFdLMDV1ZjlnVlJudWcrTjFtVnhIK2JCREM4cTRt?=
 =?utf-8?B?V3NNRG9zb25ZUXhmSWVqUkIvUXJkNEFJQ3dHSFBKa29icHdxOEVMM05rM3cw?=
 =?utf-8?B?b0Y3b2VTall3NmsrMmhtTHZFZUxqQ3pERDVSdWpUVUxyU1p4cVhZWi9IYVg4?=
 =?utf-8?B?U1MxcVpKUGZQa0tITVlLejh5WjlTdEdHS0xiSjdWQXlMMzcwdU1UMSszZElh?=
 =?utf-8?B?SEM2SGpXZzNFSHVvTXMwYkhyN2VtVnI0ajlLWGFta1NCRzNxUGtjWE9zUHg5?=
 =?utf-8?B?U1VqQ3ZydFNucUFJTCtBQ29oS3pHZUxxaGlvTDdhSVpvdUtzQXd5UnpyUEhL?=
 =?utf-8?B?YVlJUFJTbUxvbUlSZ2VFclh0REpLTTA1ZFQ4TTFjcGFLRlRPcnVLdTlHV0ZC?=
 =?utf-8?B?TFdBMXBudFJIQkVCWXNFNkprSkRBSk9YcVlJN2dtSGE0ZXduNkRvaHUxaWF1?=
 =?utf-8?B?eUZCK25IaklGS2dkejUyQzAyMGFMMzFxclZOeWsrdkdzRkh4RXNBMkJKc1lM?=
 =?utf-8?B?d1M1Wi94T0czZHUyU3h5cFRDckw4dlU4RGQxMkRFSU5RaFY3SkNHcEhXNXJo?=
 =?utf-8?B?UWtIdGtxTTRwOFlDQ2pvaWdpYjBOWVN1U2xkRkhJMDY0Y2xBK0R5TG9iT2FB?=
 =?utf-8?B?ZndlazM4ZHlueklWMGswek1DZWE4K2lLYlFWMCtSTTh5bjhQZFl5cDN2NVRu?=
 =?utf-8?B?WnRYbnUvdDY1SjdBR1BqaFhHbXVRdkxwenIzYVo2bksveHpRVFRFY0tNZ3Rl?=
 =?utf-8?B?RlFVaWFoV0RxTW13ZkJEdHdOZnhUSWJyVUtkR3BuUnF6THJFL3Q0ZnVRWDZh?=
 =?utf-8?B?Q21pSDZtWjBWQjExUFBZRnlFa0RLUUxvbG9BbE9HMi82eDRrNUtiZkZ3SnNo?=
 =?utf-8?B?SVRPSDV5dk1tcDg0QlJiK2VWaFlQaWFWVWQ3ajkwY2FxWjB2MU9LdWJXcFFr?=
 =?utf-8?B?QnF6OTZqcXplbndzb0pLMmc4Tk4rMS9wdGRBMGNLTjJVTjMyY2FGbGJTS2o2?=
 =?utf-8?B?SkZyQ2pDUXFkdndRZjdUWGdHSlZGK0xCZE9wdldLcHZnWFg4WE5tNTNpNDBB?=
 =?utf-8?B?NFFCTFBTK25ROUdLNnByVHpXODVLV0hrMTlwK3libnhqeVdRcEZmdmpGbVRX?=
 =?utf-8?B?VldVbTJUTm9zakdOQ2EyQUtwcFJrTFV5UHJGMitNQ0xGRWlVaTlXYWNLT1NF?=
 =?utf-8?B?OWxJL1dBaXlxcmNudkpRbGZlaEN1T3RSZ3hzVE9YQlJoZ0ZvOTdNT1RJWWJm?=
 =?utf-8?B?OUIrMlRiN05UMFFKOFppMVJXMXVwY1J5YVgzNmw5M0pjNmNvL29NK3F3eENQ?=
 =?utf-8?Q?oEHgHodQZAN+yZ3u4mBEwH7BX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C55DD758852349BF1AFAC610E82A32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b18a847-90a9-4877-bfe7-08dc4c6e3974
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 01:52:27.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IY8SUX/INwwr6//PgtmeVJcb1WjbyGkAmH98z2Vg9eeNH/3O0Y6lJRA8Z/Iid0sdJwSHRV2vA8uyMHeP/2h6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR03MB9201
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.911800-8.000000
X-TMASE-MatchedRID: csPTYAMX1+EOwH4pD14DsPHkpkyUphL9kd8i2lgND8uSO6So6QGgynGp
	r8/fPJWiOopRncAqMLsWbSbQY8kp4CELH1lCpEsvQPrPw3WbUAtKPIx+MJF9o99RlPzeVuQQJDl
	ZUZrKI61L7i1BXLtDKJl0arOKBKPMKc+6Aaw3enlbd1zMnVGjF8PCYXPGeJYnjdXw3QqAuhqGW/
	nbo6obw3d9ig2e+wc5+9AI+LLwgRxC/bXMk2XQLIMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7nC1C
	BeCUr4ZcLdBsXW6oQZyozAJ+r8s+yQS63Cg95rT66XHIc5w+gc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.911800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8DAB9D67DF1BED205900CE336EAD76DE65BA83CA91EEA186CECBB936F4E228F22000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTc6MDIgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgU2hhd246DQo+IA0KPiBPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4
MDAsIFNoYXduIFN1bmcgd3JvdGU6DQo+ID4gRnJvbTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24u
c3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWx3YXlzIGFkZCBEUk1fTU9ERV9ST1RBVEVf
MCB0byByb3RhdGlvbiBwcm9wZXJ0eSB0byBtZWV0DQo+ID4gSUdUJ3MgKEludGVsIEdQVSBUb29s
cykgcmVxdWlyZW1lbnQuDQo+IA0KPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCj4gDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaCB8
ICA2ICsrKysrLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMg
fCAyMSArKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19wbGFuZS5jICAgIHwgIDIgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RkcF9jb21wLmgNCj4gPiBpbmRleCAyNjIzNjY5MWNlNGMyLi5mN2ZlMmUwOGRj
OGUyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2Nv
bXAuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaA0K
PiA+IEBAIC0xOTIsNyArMTkyLDExIEBAIHVuc2lnbmVkIGludA0KPiA+IG10a19kZHBfY29tcF9z
dXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQo+ID4gIAlpZiAo
Y29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPnN1cHBvcnRlZF9yb3RhdGlvbnMpDQo+ID4gIAkJ
cmV0dXJuIGNvbXAtPmZ1bmNzLT5zdXBwb3J0ZWRfcm90YXRpb25zKGNvbXAtPmRldik7DQo+ID4g
IA0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwkvKg0KPiA+ICsJICogSW4gb3JkZXIgdG8gcGFzcyBJ
R1QgdGVzdHMsIERSTV9NT0RFX1JPVEFURV8wIGlzIHJlcXVpcmVkDQo+ID4gd2hlbg0KPiA+ICsJ
ICogcm90YXRpb24gaXMgbm90IHN1cHBvcnRlZC4NCj4gPiArCSAqLw0KPiA+ICsJcmV0dXJuIERS
TV9NT0RFX1JPVEFURV8wOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGludCBtdGtfZGRwX2NvbXBfbGF5ZXJfbnIoc3RydWN0DQo+ID4gbXRrX2RkcF9jb21wDQo+
ID4gKmNvbXApDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
DQo+ID4gaW5kZXggMGViZWFmOTgzMGQ4My4uMmE3NjdhODIzYzgzYSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtMjg4LDYgKzI4OCwx
MCBAQCB1bnNpZ25lZCBpbnQgbXRrX292bF9sYXllcl9ucihzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRl
dikNCj4gPiAgDQo+ID4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX3N1cHBvcnRlZF9yb3RhdGlvbnMo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB7DQo+ID4gKwkvKg0KPiA+ICsJICogYWx0aG91Z2gg
Y3VycmVudGx5IE9WTCBjYW4gb25seSBkbyByZWZsZWN0aW9uLA0KPiA+ICsJICogcmVmbGVjdCB4
ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4MA0KPiA+ICsJICovDQoNClNvcnJ5LCB0aGlzIGNvbW1l
bnQgaXMgbm90IHJlbGF0ZWQgdG8gRFJNX01PREVfUk9UQVRFXzAsIHNvIGFmdGVyDQpyZW1vdmlu
ZyB0aGlzIGNvbW1lbnQsDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+ID4gIAlyZXR1cm4gRFJNX01PREVfUk9UQVRFXzAgfCBEUk1fTU9ERV9ST1RBVEVfMTgw
IHwNCj4gPiAgCSAgICAgICBEUk1fTU9ERV9SRUZMRUNUX1ggfCBEUk1fTU9ERV9SRUZMRUNUX1k7
DQo+ID4gIH0NCj4gPiBAQCAtMjk2LDI3ICszMDAsMjAgQEAgaW50IG10a19vdmxfbGF5ZXJfY2hl
Y2soc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHVuc2lnbmVkIGludCBpZHgsDQo+ID4gIAkJCXN0
cnVjdCBtdGtfcGxhbmVfc3RhdGUgKm10a19zdGF0ZSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGRy
bV9wbGFuZV9zdGF0ZSAqc3RhdGUgPSAmbXRrX3N0YXRlLT5iYXNlOw0KPiA+IC0JdW5zaWduZWQg
aW50IHJvdGF0aW9uID0gMDsNCj4gPiAgDQo+ID4gLQlyb3RhdGlvbiA9IGRybV9yb3RhdGlvbl9z
aW1wbGlmeShzdGF0ZS0+cm90YXRpb24sDQo+ID4gLQkJCQkJIERSTV9NT0RFX1JPVEFURV8wIHwN
Cj4gPiAtCQkJCQkgRFJNX01PREVfUkVGTEVDVF9YIHwNCj4gPiAtCQkJCQkgRFJNX01PREVfUkVG
TEVDVF9ZKTsNCj4gPiAtCXJvdGF0aW9uICY9IH5EUk1fTU9ERV9ST1RBVEVfMDsNCj4gPiAtDQo+
ID4gLQkvKiBXZSBjYW4gb25seSBkbyByZWZsZWN0aW9uLCBub3Qgcm90YXRpb24gKi8NCj4gPiAt
CWlmICgocm90YXRpb24gJiBEUk1fTU9ERV9ST1RBVEVfTUFTSykgIT0gMCkNCj4gPiArCS8qIGNo
ZWNrIGlmIGFueSB1bnN1cHBvcnRlZCByb3RhdGlvbiBpcyBzZXQgKi8NCj4gPiArCWlmIChzdGF0
ZS0+cm90YXRpb24gJiB+bXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zKGRldikpDQo+ID4gIAkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+ICAJLyoNCj4gPiAgCSAqIFRPRE86IFJvdGF0aW5n
L3JlZmxlY3RpbmcgWVVWIGJ1ZmZlcnMgaXMgbm90IHN1cHBvcnRlZCBhdA0KPiA+IHRoaXMgdGlt
ZS4NCj4gPiAgCSAqCSBPbmx5IFJHQltBWF0gdmFyaWFudHMgYXJlIHN1cHBvcnRlZC4NCj4gPiAr
CSAqCSBTaW5jZSBEUk1fTU9ERV9ST1RBVEVfMCBtZWFucyAibm8gcm90YXRpb24iLCB3ZQ0KPiA+
IHNob3VsZCBub3QNCj4gPiArCSAqCSByZWplY3QgbGF5ZXJzIHdpdGggdGhpcyBwcm9wZXJ0eS4N
Cj4gPiAgCSAqLw0KPiA+IC0JaWYgKHN0YXRlLT5mYi0+Zm9ybWF0LT5pc195dXYgJiYgcm90YXRp
b24gIT0gMCkNCj4gPiArCWlmIChzdGF0ZS0+ZmItPmZvcm1hdC0+aXNfeXV2ICYmIChzdGF0ZS0+
cm90YXRpb24gJg0KPiA+IH5EUk1fTU9ERV9ST1RBVEVfMCkpDQo+ID4gIAkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gIA0KPiA+IC0Jc3RhdGUtPnJvdGF0aW9uID0gcm90YXRpb247DQo+ID4gLQ0KPiA+
ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19wbGFuZS5jDQo+ID4gaW5kZXggYTc0YjI2ZDM1OTg1Ny4uMTcyM2Q0MzMzZjM3MSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gPiBAQCAtMzM4LDcg
KzMzOCw3IEBAIGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+
IHN0cnVjdA0KPiA+IGRybV9wbGFuZSAqcGxhbmUsDQo+ID4gIAkJcmV0dXJuIGVycjsNCj4gPiAg
CX0NCj4gPiAgDQo+ID4gLQlpZiAoc3VwcG9ydGVkX3JvdGF0aW9ucyAmIH5EUk1fTU9ERV9ST1RB
VEVfMCkgew0KPiA+ICsJaWYgKHN1cHBvcnRlZF9yb3RhdGlvbnMpIHsNCj4gPiAgCQllcnIgPSBk
cm1fcGxhbmVfY3JlYXRlX3JvdGF0aW9uX3Byb3BlcnR5KHBsYW5lLA0KPiA+ICAJCQkJCQkJIERS
TV9NT0RFX1JPVEFUDQo+ID4gRV8wLA0KPiA+ICAJCQkJCQkJIHN1cHBvcnRlZF9yb3RhDQo+ID4g
dGlvbnMpOw0K

