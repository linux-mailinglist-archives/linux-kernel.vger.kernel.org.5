Return-Path: <linux-kernel+bounces-167424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983008BA96A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DF8B220CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C314F10A;
	Fri,  3 May 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X1iTCZpX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mVfk3gN/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65514D446
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727070; cv=fail; b=cWcgd3tb2a+Wkmus+FDFDjK6gtgcWVbjyjnak9M5XQXnQIx0SmEm8hAg6QrRVupv1ACPATgc1smTjt3NsVHI8IscSqcDkWswbyMdWgeeKSNlOTxkxctgJlMrsWKmtVZvDbkrCGL3B/PED2g2sksRSm9VNTIfZsn3PA6V05ysZic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727070; c=relaxed/simple;
	bh=F92yprGD64T9PDCGqztL79usPEPKudgAQxac4Ac65hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JK8nejLaSVeu4wAr/kAJNykQM9/csN0weF9ppXWs5Uo1oXm9k/YFWRhxzhAy1lBB/79h9cKU720kZrwrBxRAE0gxMTkBkwsSJ19zck2xC0z+AzNlvZ2y7KzbaQ7HUMN2gM+1HnCrMmjVgFUOpdBuMzjVYRdZXtWKxhBAORDcas4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X1iTCZpX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mVfk3gN/; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 20303c52092c11ef8065b7b53f7091ad-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F92yprGD64T9PDCGqztL79usPEPKudgAQxac4Ac65hc=;
	b=X1iTCZpXMpBrPN2yhLao7lXoGYTILiwQR+v930Xlg2MBoCKuGD+yOxOZE3SPEZ3h5mnC2+lD6cWHiuhPRT0Gp5Y2SgStq7rJv/ndjgbZTEjO6QO9a/ukhME3rdZfUOliBC2hZuqKOg5Ne5iEsLAL5AUM6dnNqBCFQMEfQPgcvIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:004e5338-609f-4a46-8316-6a4b7b942fa3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:23c64f92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 20303c52092c11ef8065b7b53f7091ad-20240503
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 962442141; Fri, 03 May 2024 17:04:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 17:04:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 17:04:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6Ol3I2ZYdYjPdvOiKy5FV0u4Jols2NQ/Ft9yu6GhvWdt+bJQ7F3aE3WzcrKL4QyLfImm5VQROgO608TECxNwtKt8GuRystYHeont2YUkjumyVJHitO9+KmJxNlmr8oD6e4Ci3vXGWQVohK6G1TjwK80YehrvUdQvQ0Z6ZSzwcmXRYRp9rzQjGYagtny99mgd3nuzm/1AmFWNwKh2b2zXa139qlXtCNj3UK0VWclebyG7Q1e6Usr5haExIzcJy8Anp54TLIBJE3D3td3If03Qs5J3SlSG8MAZEq9090afgwjH6eTaLLVMAlXYDTqvRv10uUcOGesP3KYU/NjY8gS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F92yprGD64T9PDCGqztL79usPEPKudgAQxac4Ac65hc=;
 b=LLMYt2XC1JNyLpMQV4+kVnHEH49ik7Afmqqddta1xtyDs8e0u0wAqctfU7MxqCvaCOKnLcnrc8vmuC7f1NNy2L5GXs7aTkuX6TFhegiBoIaWcruc7ObKQ2ug/zPFIISOc2sX0lwC5IAaVTASfuWOOOoZO6GyIB/TQL7dwluylPcek62G0bXTeYGm7+tubVF/RVKzyOAv8FBq0Tw8MnghTPm26gVt78vA730FOuHWWEEWfLQHfKEVRRjC/kBOvVFEPsWIjvuVAMH/bhN7o5LIuj8MJ19fBQID+4UkAsdITIh6XriJGQM+9pn5Md374zS8DqBDP8e6yf23hjj77Ih3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F92yprGD64T9PDCGqztL79usPEPKudgAQxac4Ac65hc=;
 b=mVfk3gN/RcQlfkqEtGLErNPHmrR4glMHYwxuv4Dbr4k5a54u8hiWIaqralnKOepaAiv0TIDXp0IDEJq9hAz6rG3fqtUDNiQ+boPGGpg1o2dIAQ/GJfKSV8L2PkIOxYx2w8P8ikmnT7QhEzJGlSRlhKnCrHnyNYJBrqhOcLxuEus=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8559.apcprd03.prod.outlook.com (2603:1096:405:65::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:04:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 09:04:14 +0000
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
Subject: Re: [PATCH v7 11/18] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v7 11/18] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHanH0Hg4YSAGd3fEyrAgu5Ke8iE7GFOMKA
Date: Fri, 3 May 2024 09:04:14 +0000
Message-ID: <5ebb2b0af6d26ee3137b2716f7068acf8233b80a.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-12-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-12-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8559:EE_
x-ms-office365-filtering-correlation-id: 870ac359-9320-4089-0aef-08dc6b500178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bGI0SXNyU21QS3ZMQXRaeWNORFFCY042dVlYajZiaXMvYmVZcTdVUG11bUdP?=
 =?utf-8?B?UnZONzFUWDV1MlFHY28zVnNDSmM4Q1JOakRoMUpFNW5Hek1LaDhSdkFZcU9w?=
 =?utf-8?B?em1zaE1pbjRJRjFpYUlPbjh5dERsbVUwdkNWNTRDNG5UNTZuMDR5S2JVZjBq?=
 =?utf-8?B?MFFETnZ6VjlWR1l6bnZuQk1jcnhsNHFIWHV5TW5MaUE2QzBlS3BicElYVGRE?=
 =?utf-8?B?UklBd2hHR3VJdkRBdFdjNkVVL0xDK29TcEJHSDZ4T09CUUxsdHJPaW53ajkz?=
 =?utf-8?B?WCtQNGJrNlQxbGZ0aGpaZTFrQ1NqTXBkUGZ5d29uUFErZENnQW9QNXhPYTht?=
 =?utf-8?B?TUFscTVUbXJVMG1xSUh5TVdRSXJYeGpid3pBOUJYMnZVT3I2VEpqdmI1RW5W?=
 =?utf-8?B?MVJyeUIxSGdoTkJNdlU2UHZIZkEyRkk0eDZEdDJ0bG5tOFpjZGc3Wm1BQ21i?=
 =?utf-8?B?b3AvaFJEOE16SVAzbkMyVnE1NDdoWEN0Z3FJdnZRN0drQTRwa2NwMTU5dzkv?=
 =?utf-8?B?VlJWbkJoRFFPQk5LSm1IUlQ4dUFvRHJ6Wk1rUHlPZTBFcGs4Yi9xWW52UEVP?=
 =?utf-8?B?TTlZUjRCRHBiR3RDTUFjRmJheGx1bFJaUDhpYkkvSFRqc1ZkaFRjTWtXN2sy?=
 =?utf-8?B?U3ZkM0Z5eHVQbkp0cVM5RVUyU291WHgwc1FaM2lBb3kzaDI2aC9oN21ZTUNF?=
 =?utf-8?B?blJjbXBieldYS0J3YWJGUlhRNUlza3RSU3ZETFdiY2FCTCs1QjhrbTlIcGMr?=
 =?utf-8?B?VER5K2JLV0ZRS2k3M1cwMDVCcjJQZGliRFEyWC9iclhDZWt1djdtZ3M2ak5F?=
 =?utf-8?B?VWlvbXlUNThCSVRLSTlCWXdkUGJTaFdXZVJYMmNHRG56K0ZweXBRYkZ2QUN0?=
 =?utf-8?B?TmdpQmVFUDBrVGg1elA4cHFXQXFlaE5FK3c0MWovVms4NVpkSUtESWlNMXlR?=
 =?utf-8?B?WkRCbXd3NzcxQ0ZQNTdTOVFFMUNRcDlPQjAvTUJ6MUJiSUlTdW5sMzBqRjRs?=
 =?utf-8?B?Mkt4WFJCUXZjTXdBTStBS1AwMEtYQjBpY3dkeWFGd25FTGkrRmlmekJEWUVP?=
 =?utf-8?B?QTA4OUljSkpmSHR3aGswajdtZDRmZ2loSG1HTVRTTjNwdlNtWnZDS1lYa0E4?=
 =?utf-8?B?OWs0MG0xSzVBTE9HNmkrZVFhSmljSVdHMnB3ZmtTYkpZRTNFSTB3ZTNiZFBV?=
 =?utf-8?B?ditrRXptQ0FFRjlGaDEvYlBnbzRKcnA5MCtHUWtEUnF1MEVxb04ya2FzWnhQ?=
 =?utf-8?B?YjVYUUR5OENhdHR6Rnd5SXZVNHEybStnWHFVbCtydC9nYk4rcUs0NU9CWUNa?=
 =?utf-8?B?OFhjeDdDaENiTjJQajRVQ3pDVHAyWGZQVkxuVXd3blRCaDI3c0pOWFVhdUkx?=
 =?utf-8?B?THI1TFZUOG1xL0ZsQmRwR2RQOEhMZ3BHOTA3V2Z2NzJMVzNTZnhTMmhMaXJr?=
 =?utf-8?B?c0g0NnpXL2hxK3BEYm5leEFKNnFTTm9aN1ZvV0E2NUN4Vm9Lc29xNDZQZ0hW?=
 =?utf-8?B?eTRGanVLTWhLcEhUSE1XZDBmQlV2SFd5SG14MHdQMUFPSmFVSXhLQlpsVmdE?=
 =?utf-8?B?SW41UmZHS2FIT3JsMkdhajYvMjg3MkZDZzRicmRKSG1ZdGsrb0NyN3NFUWFu?=
 =?utf-8?B?WnlaUHAyNGc5QWt6RmtsSjRxVHVkNDB1SVY3NU40NVJHNXprckxjYUNvemVm?=
 =?utf-8?B?ZTBna3NHQkRoOFp5MEVab0VMNEhBR3I4SDRLc3g1UWVqQTRPeHlnblByVXRP?=
 =?utf-8?B?TyswZDYvT25NTk9tcU93Q0VTVUxXQ284bWx6dkdVUHFoYzJ2YTVISFhDYWx3?=
 =?utf-8?B?MUdBTktjNWZwTU5CWFQ4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTVRODFqOWZvQUx5R1NsSWtzS1VxYXVoNmtjRVZEUUVGUDN5TWxKMVNGdkZI?=
 =?utf-8?B?YVYxSndXWDRCNlFlZXJ4NDg0MHZONTBROGNCZXhCQ2VvM1IvUkZwMGxKQnFh?=
 =?utf-8?B?Q3ZWQ3FyNisxMDhzOGxkRHFySnNaMytOUTFVQmlXeC9aLzQ3anZObHJqVnFq?=
 =?utf-8?B?MjV3NWRqcTNzSkNBd251S1gvcktJa01kd2ZhWTZRWG9aZ2J4OEdCL2tLY205?=
 =?utf-8?B?QVUydmUrTi9mV2t6U1g5Qk9jWkFzbEZTUDlsYWdkVER5L1VsWkNYOVVMMEFX?=
 =?utf-8?B?OGJBNEVtOHdoeHJ5bk4vSnVrY1F5a3hlVXdFM05JTDA0S0RLajFaWlRLL3hU?=
 =?utf-8?B?SFlReHdZTU5UWjJqUU1iUGhPUXJubjR0NEVSalQ2TUI4bXA5K0NYMDhXRmpu?=
 =?utf-8?B?ZytIODRjQnE4RU9QZDJJNGRGYnUrUVVoaTRBWjFLY2lzNUpMWmRHNWZkTnkx?=
 =?utf-8?B?V0pVR29IaU1hL0k3dHliYml0SXNIRGVSYkllWE1pUEorVzJ5eUpITzFVd1NV?=
 =?utf-8?B?NU1NR1lWNXFQRDg2SS9LTFFKcEFJcHRGTUlXQ0VNNUlIVTNocGR2NTVrcktZ?=
 =?utf-8?B?YndRN0JUL0U3cUZ5M3MySFRVQnVJZFZvQ0orZEJLakxsQUMvd01uRC82STRG?=
 =?utf-8?B?Vk81VWk5aXNzYkw5cW10dFZnbWZSZW1KQmpGck42aENmbEFzNWxCM2Q3ZmZZ?=
 =?utf-8?B?N3QyczBHTGxmT1NzNlN6b1hMUW5oUm1JK2FPbEtTaVFHNnNna1VkQ1RvUk5Y?=
 =?utf-8?B?bGJJbjloY2xmaVFmVktRTVhsQnNKY3RlbHVmRDlKZk54NGVFU2FhVGdGbGIr?=
 =?utf-8?B?RHBBdGYxWkJ4L3czSHJSNlI2NUliU1Qwd1lKeWZaMy9KRVk5aEJwdW9QMjNX?=
 =?utf-8?B?bzhOWFpSZ0dBY2FLYjQvYVpOMzlKNERmbGxGNjZ4TytNZm1uWmNRVldvVGVH?=
 =?utf-8?B?cm5JY0phbGdWQ2NYZ2FuYjZLSFhXVHRQTGZuakIxeE4yNldrbWkrQUVMTm9I?=
 =?utf-8?B?QVhCNGdNbWdydUNrU0NmekpmOEgyNDZYTlkzQjczVjBkMVBEZlBFOGFNU1p1?=
 =?utf-8?B?WTlFUm9mRXBJaUoxTkp2MFR1RzV0K1EvcFB2QlM5TGc0UGlPeWdrRjlTMUk5?=
 =?utf-8?B?Ty91RG1wek5jVzlmWmxxZy9jc2k1SmlVaE8rcnhlSElqb0RiWVNaRUJBb3Bz?=
 =?utf-8?B?M2tiN0pWTVdoUHovNFlnU0VtNUtIMVplNm1MWHRrclJ1dDNrVGVYTWN5c2Rt?=
 =?utf-8?B?SmhDbTlhci9IZmxzVHZRMU5RaDZ0NnNwRU9RMHBTUE04THZ0TW0wdVZ5M2Z3?=
 =?utf-8?B?WWlXRGtMQW9rai9heW1hN3BJZ2hqa0RhMXdNeWwwWHdTMU1QdGl0Qkh6bHND?=
 =?utf-8?B?dDRFMzhhbWhTMG9VcDJNeTNpR2RoL2tRNFVzZ3NzaldoL0tpeGdyY2RtL0pr?=
 =?utf-8?B?YVFleHFnM2tYR3hmUEhTQ3VmUUNSVmNLUkxMemV5RmUvMXo5UTZuQ3I0ajMz?=
 =?utf-8?B?WC9IU1d4QlVMbm1ZRHFnS290SjJaRzZ0VEE4cldsREx3bVZGWkl1VG5oMEZr?=
 =?utf-8?B?T0g5ZXdaMUpvWEQ4VnUzVEJHRW9YNHhFbHJEaTB4am1POFJWNVQxUkZ0RXUy?=
 =?utf-8?B?NDBWbUF5UzNKQjE1akZNdVR0VjFjZXEwREM5VTZVSXJFU05oNnpHNXFueDVH?=
 =?utf-8?B?OTlwYWxuNUtlNEpiT25CWUlEWG1qblNkb254V0Rjc3ZyRWdyZ2hIZHp1VWdP?=
 =?utf-8?B?T0dVbEg3Zy9mUElZTGlrM2crSVJ5d0M0Tmc1UzlDeU1idmZid1VoZVB3cklp?=
 =?utf-8?B?ZUc1cUhSeW9aU0xLWmYvd3NaNUREQVlTL1RlNm5aamFGNG5KVWp2YTZ0dk9u?=
 =?utf-8?B?cE9WTXlwMVg5Q0tyaXcwM2NMVHM5QWhCZ3JrQjdERTRnUVhMdi94NFNYQmJT?=
 =?utf-8?B?VDZ5Y0xsWUNhcTFlZk8xL283YnNoTi9rSFMvZnNBM1R5TFduaEVUUWRjTFpE?=
 =?utf-8?B?NXFPQWpVSEQvblVRQ0ZMVDg3c1pWVDIxR0VZWlo1Q0p5V0VSdElzYzlLRnIx?=
 =?utf-8?B?TmFkNkZhclNqZHhqS1NtSElMS1ZGdmNleDZTZXZjRWIzUHVuTHZKMjBJZTFM?=
 =?utf-8?Q?x+m6fFPPBCe944hBQLIYcm0xx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7939D2771402C04F86E1DC9D730C53FB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ac359-9320-4089-0aef-08dc6b500178
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 09:04:14.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7OEfuza24+QvwYGehzPrOE21JUzVpkX/zH1BNc5tJdP7ptVFEM59bwUW9z9EVAq9/SETkV7RYStCiVBt7wJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8559

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTg6MzggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
b24gaW4gT1ZMLg0KPiBCZWZvcmUgdGhpcyBwYXRjaCwgb25seSB0aGUgImNvdmVyYWdlIiBtb2Rl
IGlzIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNo
YXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKw0KPiAtLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggZTQxZmQ4M2Uz
NmU3OS4uYWQ4NGMyZmU1NzExMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYw0KPiBAQCAtNTIsMTMgKzUyLDE2IEBADQo+ICAjZGVmaW5lIEdNQ19USFJFU0hP
TERfSElHSAkoKDEgPDwgR01DX1RIUkVTSE9MRF9CSVRTKSAvIDQpDQo+ICAjZGVmaW5lIEdNQ19U
SFJFU0hPTERfTE9XCSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gOCkNCj4gIA0KPiArI2Rl
ZmluZSBPVkxfQ09OX0NMUkZNVF9NQU4JQklUKDIzKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0JZVEVf
U1dBUAlCSVQoMjQpDQo+IC0jZGVmaW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYp
DQo+ICsjZGVmaW5lIE9WTF9DT05fUkdCX1NXQVAJQklUKDI1KQ0KPiAgI2RlZmluZSBPVkxfQ09O
X0NMUkZNVF9SR0IJKDEgPDwgMTIpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4
CSgyIDw8IDEyKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9BUkdCODg4OAkoMyA8PCAxMikN
Cj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfVVlWWQkoNCA8PCAxMikNCj4gICNkZWZpbmUgT1ZM
X0NPTl9DTFJGTVRfWVVZVgkoNSA8PCAxMikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9NVFhfWVVWX1RP
X1JHQgkoNiA8PCAxNikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4CShPVkxf
Q09OX0NMUkZNVF9BUkdCODg4OCB8DQo+IE9WTF9DT05fQ0xSRk1UX01BTikNCj4gICNkZWZpbmUg
T1ZMX0NPTl9DTFJGTVRfUkdCNTY1KG92bCkJKChvdmwpLT5kYXRhLT5mbXRfcmdiNTY1X2lzXzAg
Pw0KPiBcDQo+ICAJCQkJCTAgOiBPVkxfQ09OX0NMUkZNVF9SR0IpDQo+ICAjZGVmaW5lIE9WTF9D
T05fQ0xSRk1UX1JHQjg4OChvdmwpCSgob3ZsKS0+ZGF0YS0+Zm10X3JnYjU2NV9pc18wID8NCj4g
XA0KPiBAQCAtNzIsNiArNzUsOCBAQA0KPiAgI2RlZmluZQlPVkxfQ09OX1ZJUlRfRkxJUAlCSVQo
OSkNCj4gICNkZWZpbmUJT1ZMX0NPTl9IT1JaX0ZMSVAJQklUKDEwKQ0KPiAgDQo+ICsjZGVmaW5l
IE9WTF9DT0xPUl9BTFBIQQkJR0VOTUFTSygzMSwgMjQpDQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUg
Ym9vbCBpc18xMGJpdF9yZ2IodTMyIGZtdCkNCj4gIHsNCj4gIAlzd2l0Y2ggKGZtdCkgew0KPiBA
QCAtMjk2LDcgKzMwMSwxMyBAQCB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRl
diwgdW5zaWduZWQNCj4gaW50IHcsDQo+ICAJaWYgKHcgIT0gMCAmJiBoICE9IDApDQo+ICAJCW10
a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZvdmwtDQo+ID5jbWRx
X3JlZywgb3ZsLT5yZWdzLA0KPiAgCQkJCSAgICAgIERJU1BfUkVHX09WTF9ST0lfU0laRSk7DQo+
IC0JbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCAweDAsICZvdmwtPmNtZHFfcmVnLCBv
dmwtPnJlZ3MsIA0KPiBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gKw0KPiArCS8qDQo+ICsJ
ICogVGhlIGJhY2tncm91bmQgY29sb3IgbXVzdCBiZSBvcGFxdWUgYmxhY2sgKEFSR0IpLA0KPiAr
CSAqIG90aGVyd2lzZSB0aGUgYWxwaGEgYmxlbmRpbmcgd2lsbCBoYXZlIG5vIGVmZmVjdA0KPiAr
CSAqLw0KPiArCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgT1ZMX0NPTE9SX0FMUEhB
LCAmb3ZsLQ0KPiA+Y21kcV9yZWcsDQo+ICsJCQkgICAgICBvdmwtPnJlZ3MsIERJU1BfUkVHX09W
TF9ST0lfQkdDTFIpOw0KPiAgDQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgxLCAmb3Zs
LT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiBESVNQX1JFR19PVkxfUlNUKTsNCj4gIAltdGtfZGRw
X3dyaXRlKGNtZHFfcGt0LCAweDAsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+IERJU1Bf
UkVHX09WTF9SU1QpOw0KPiBAQCAtMzcyLDcgKzM4Myw4IEBAIHZvaWQgbXRrX292bF9sYXllcl9v
ZmYoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkgICAgICBE
SVNQX1JFR19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdW5zaWdu
ZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+IHVuc2ln
bmVkIGludCBmbXQpDQo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1
Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+IHVuc2lnbmVkIGludCBmbXQsDQo+ICsJCQkJICAgIHVu
c2lnbmVkIGludCBibGVuZF9tb2RlKQ0KPiAgew0KPiAgCS8qIFRoZSByZXR1cm4gdmFsdWUgaW4g
c3dpdGNoICJNRU1fTU9ERV9JTlBVVF9GT1JNQVRfWFhYIg0KPiAgCSAqIGlzIGRlZmluZWQgaW4g
bWVkaWF0ZWsgSFcgZGF0YSBzaGVldC4NCj4gQEAgLTM5MSwyMSArNDAzLDM1IEBAIHN0YXRpYyB1
bnNpZ25lZCBpbnQgb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdA0KPiBtdGtfZGlzcF9vdmwgKm92bCwg
dW5zaWduZWQgaW50IGZtdCkNCj4gIAkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQjg4OChvdmwp
IHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JHQlg4ODg4Og0KPiAg
CWNhc2UgRFJNX0ZPUk1BVF9SR0JBODg4ODoNCj4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJN
X01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4
ODggOg0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4Ow0KPiAgCWNhc2UgRFJN
X0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4gIAljYXNlIERSTV9GT1JNQVRfUkdCQTEwMTAxMDI6DQo+
ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9BUkdCODg4ODsNCj4gIAljYXNlIERSTV9GT1JNQVRf
QkdSWDg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUkE4ODg4Og0KPiArCQlyZXR1cm4gT1ZM
X0NPTl9CWVRFX1NXQVAgfA0KPiArCQkgICAgICAgKGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxF
TkRfQ09WRVJBR0UgPw0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggOg0KPiAr
CQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4KTsNCj4gIAljYXNlIERSTV9GT1JNQVRf
QkdSWDEwMTAxMDI6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUkExMDEwMTAyOg0KPiAgCQlyZXR1
cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfCBPVkxfQ09OX0JZVEVfU1dBUDsNCj4gIAljYXNl
IERSTV9GT1JNQVRfWFJHQjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FSR0I4ODg4Og0KPiAr
CQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSA/DQo+ICsJCSAg
ICAgICBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZN
VF9QQVJHQjg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFUX1hSR0IyMTAxMDEwOg0KPiAgCWNhc2Ug
RFJNX0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gIAkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQkE4
ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSODg4ODoNCj4gIAljYXNlIERSTV9GT1JNQVRf
QUJHUjg4ODg6DQo+ICsJCXJldHVybiBPVkxfQ09OX1JHQl9TV0FQIHwNCj4gKwkJICAgICAgIChi
bGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9D
T05fQ0xSRk1UX1JHQkE4ODg4IDoNCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4
OCk7DQoNCk9yaWdpbmFsbHkgd2hlbiBjb3ZlcmFnZSBtb2RlLCBYQkdSODg4OCBhbmQgQUJHUjg4
ODggcmV0dXJuDQoNCk9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVAN
Cg0KYnV0IHRoaXMgcGF0Y2ggcmV0dXJuIA0KDQpPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCB8IE9W
TF9DT05fUkdCX1NXQVANCg0KVGhpcyBtb2RpZmljYXRpb24gaXMgbm90IHJlbGF0ZWQgdG8gcHJl
LW11bHRpcGxpZWQgYmxlbmRpbmcsIHNvDQpzZXBhcmF0ZSB0byBhbm90aGVyIHBhdGNoLg0KDQoN
Cj4gIAljYXNlIERSTV9GT1JNQVRfWEJHUjIxMDEwMTA6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FC
R1IyMTAxMDEwOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggfCBPVkxfQ09O
X0JZVEVfU1dBUDsNCj4gQEAgLTQyOSw2ICs0NTUsNyBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIAl1bnNpZ25l
ZCBpbnQgZm10ID0gcGVuZGluZy0+Zm9ybWF0Ow0KPiAgCXVuc2lnbmVkIGludCBvZmZzZXQgPSAo
cGVuZGluZy0+eSA8PCAxNikgfCBwZW5kaW5nLT54Ow0KPiAgCXVuc2lnbmVkIGludCBzcmNfc2l6
ZSA9IChwZW5kaW5nLT5oZWlnaHQgPDwgMTYpIHwgcGVuZGluZy0NCj4gPndpZHRoOw0KPiArCXVu
c2lnbmVkIGludCBibGVuZF9tb2RlID0gc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZTsNCj4g
IAl1bnNpZ25lZCBpbnQgaWdub3JlX3BpeGVsX2FscGhhID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQg
Y29uOw0KPiAgCWJvb2wgaXNfYWZiYyA9IHBlbmRpbmctPm1vZGlmaWVyICE9IERSTV9GT1JNQVRf
TU9EX0xJTkVBUjsNCj4gQEAgLTQ0Nyw5ICs0NzQsMTEgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCXJldHVy
bjsNCj4gIAl9DQo+ICANCj4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiAt
CWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEp
DQo+IC0JCWNvbiB8PSBPVkxfQ09OX0FFTiB8IE9WTF9DT05fQUxQSEE7DQo+ICsJY29uID0gb3Zs
X2ZtdF9jb252ZXJ0KG92bCwgZm10LCBibGVuZF9tb2RlKTsNCj4gKwlpZiAoc3RhdGUtPmJhc2Uu
ZmIpIHsNCj4gKwkJY29uIHw9IE9WTF9DT05fQUVOOw0KPiArCQljb24gfD0gc3RhdGUtPmJhc2Uu
YWxwaGEgJiBPVkxfQ09OX0FMUEhBOw0KDQpUaGlzIGxvb2tzIGxpa2UgcGxhbmUgYWxwaGEgKFRo
ZSB3aG9sZSB2aWRlbyBwbGFuZSB1c2Ugc2luZ2xlIGFscGhhDQp2YWx1ZSksIG5vdCByZWxhdGVk
IHRvIHByZS1tdWx0aXBsaWVkIGJsZW5kaW5nLiBTbyBzZXBhcmF0ZSB0byBhbm90aGVyDQpwYXRj
aC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwl9DQo+ICANCj4gIAlpZiAoc3RhdGUtPmJhc2UuZmIg
JiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gIAkJaWdub3JlX3BpeGVs
X2FscGhhID0gT1ZMX0NPTlNUX0JMRU5EOw0K

