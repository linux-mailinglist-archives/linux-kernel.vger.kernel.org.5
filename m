Return-Path: <linux-kernel+bounces-107171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61B87F869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EF9B21CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215FB53814;
	Tue, 19 Mar 2024 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bq58SmEs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qPo7lE86"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98670537E4;
	Tue, 19 Mar 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833337; cv=fail; b=cl3Td0JjnbGG2zu0hXki0boNH3FGXL8AaIi2YpkAk26F0D5z89JgG95v5oNONKSjv7N/sGxzaM2TNOpfmHkoDf+2zvHlOM0VtGqtdA8JDxWoNhhN+8f5Wuou9iUGfJmv5HSStMPdLnTh9MXdLo/bEv1mLEAlCFDPBaHzk+q2mmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833337; c=relaxed/simple;
	bh=3sxwcxcYMbwVbOUrpdLnUPvZiiORpGYfEnFmp3U2Jro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOxC4DGmCidpjVMTozPSiiBqwKJ9SfGgmCCB4uadyO970+DdfpxfkYvCPB/5fVU5QgR9RNGJ2ay3S9gPRbNRWA1D6kXrjZuzxs61YkXaNjyXOEWz6GYcLlE3bzwPxh63eF6/Vv2gAvameWuiWmPHdB/WjNmbTZFAm3TFXuyrMbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Bq58SmEs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qPo7lE86; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55c28308e5c211ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3sxwcxcYMbwVbOUrpdLnUPvZiiORpGYfEnFmp3U2Jro=;
	b=Bq58SmEs80BFWexnjtGX5q23OUUIQ0YDTc0pFlSsMO3KrcaUBpqQCrDsNJUbCswLo9rEY7uFVZbzkOehucERJs73l4LDOz61uZFKPFPg0f3cbTynNIAWs166Ne7HLftR9rFzJrZbJvkKkHT7iueUutQ1KyVTShPuXKL4RBGzC7U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b5531058-b31b-4b04-92bc-68cfc4a12e1b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:2cdc0f00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 55c28308e5c211ee935d6952f98a51a9-20240319
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1098845535; Tue, 19 Mar 2024 15:28:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 15:28:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 15:28:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf2wZ0U/ObUqroOGAr8uoYplHsAR1izNxFsbJmwvfp4EcvIYvUnXpsgrkWpXs/1mbUU9Zax2Z7W00FGcpguk3zazNSF+et3tv7CXJKZGVOsgGpRDBMEfR/UsTsin1tTOvoudjMw0WM2n1Icwfi2YLIi5ukJ5jSqrosVMP7ILM2K4GOlz8B1MhluNhhFJb5vahxDizKSmiSsAmQGl5hNrZvAeE/IR38K+e1rCkARL0O5dUA3Y8P/37l+X9zCzy68SwGkxdPCdqE9z0uFBCVgKX8/3tOp6CxZs2uPgnMo06FlX3L6hinccHBa16zcRx2SoJcmwxzNgKfEXWny7+Ye04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sxwcxcYMbwVbOUrpdLnUPvZiiORpGYfEnFmp3U2Jro=;
 b=lP1i8nQDulwmyUL0lWXYYS20Ele9Toc4ETEhqnvudvCNNvQ33rdBLbZtXCNm3aOVSuIFuY+BGufkUW51n9XM7iF8UxIDXSgqVnRCE/b4D4KO8wrwuPK0mJ3AYPfuvR+Uc+yw0ppLy0Z5Lw+8Dlwd+uxXtjvItf9II47SnPwhlTu0UukP8JkAHKg+VL45iJumUwcKNRbLTt2BVI3wAvUxsMlKvaaoPVI3phsCXUo269B9v57n5KISTr62Rd8g7Co18y34jto9hyfyaK7l2q04bR5gmZpH1ZruZW6cSEZgepSsoFwaL+krSABPYQD8IA2VsQu/Wc3H/MEA1+F+n66iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sxwcxcYMbwVbOUrpdLnUPvZiiORpGYfEnFmp3U2Jro=;
 b=qPo7lE86IcYFMOqg/7IVzJkA2zaJof4WVwEj8+EGlIj0hS9b5jXpVHojpxCK3iuQcNC0bnWNVAuP8jj42lhPNxL+J1ug6iacOBat7Ra4KLbNVfvIvkueOAKaEr9gK+dnsFTgh2fdspQPpVZs8VQb/F8P19/4dm8B/+mx0hp2QUA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8746.apcprd03.prod.outlook.com (2603:1096:604:27d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 07:28:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 07:28:45 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>
Subject: Re: [PATCH v2 3/3] drm/mediatek: Add gamma support for MT8195
Thread-Topic: [PATCH v2 3/3] drm/mediatek: Add gamma support for MT8195
Thread-Index: AQHaax5+L+LCYDjwHECYygI3+qUbFbE+x+gA
Date: Tue, 19 Mar 2024 07:28:45 +0000
Message-ID: <f52a7b789ba4704767d1c73ee036f2ddf5472589.camel@mediatek.com>
References: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
	 <20240229144844.1688-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20240229144844.1688-4-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8746:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AwWfzbcXqR/EZp6fRY+Uo+i0MxKUQr4J0BS6ZznTeoycbLa5MqWxv5iW9jpyThH2ItHHOiiPCcF4wq7eQlqEgnhU7SUySEaBpYhQRfkgsCKdKwdd1eb8pFioZcVyBVNWzx6BZusKYw2DDJNtswaAdWTjGlHPceS7/TnhXB0dsyIWRCevcuWvbZOIy6Iwv3vBJ5mv/XFrJCOwmxDF+j5i2GXJf4yjA4z4z6bS9i+88BATT+PLUBv+aMomAtgfmzsXCsvqz2Zni1ozXP1KIiArj3VDfLx9A4NnzkZqMGa5V8/kbOzMdAOwoNCJG5+AiSKc0xDJgGHPoC5mK3jMmnGSEk44S01HiuE25i4v5HsFko0ygK3u1C1XIMxqfgWqwrnzfN4HzOkhJgrRLgtftCkkVPUhOD4gvBNfxlLPbe4O/m0XCnTTd9XiUFFDqIGY7+0/H8mF9lL3SOsUpXL8OIqyUklRNvXGCqIltNYJoN1L0OpXDYZRcewckacQNG3ZR4sYroPfZVHOe3hOOQHTK/enWofUbkXcIVVlcMbJgROq/JsAWwheJoK6HwrV3H69h7n4injOOOMmtprNe8EWNG7O3eMbERO7Z1U8avKvZ+LyszsJBiUB/xyBQCRkzhT4j/D7GFlzKrUKC2DQ7QCh/EGLl9a+9wb/QadYQx78AkCFIB8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tQQ2tkRzJhQmVCQWlvK0F6MGhtU1BMemI5M1hDM0s4UjhUZWtvTXhYTnVv?=
 =?utf-8?B?RzJxaDVyTHBkQkZqd3J2cE9QOE0zaFU5cFY2S1FjT0daUGI5aDNUY212M0R4?=
 =?utf-8?B?TllrZVhxKzBmTnc3QUFaSW50TDVCdTlZUjNVTEU0U05CYnA4U1NWK1c4UHVn?=
 =?utf-8?B?OUNlbFRVWjcxeG5nS29uU3JqZDUrNW1QMDlsSkQ0ZVBPQmtITDRzT2E4VENY?=
 =?utf-8?B?ZnU1YVp0RE9RdWJ6aHc0ZnRiNTZZTnBnMXUzOHNSWDZHR1Robk1jcTYxOFF0?=
 =?utf-8?B?UGVaSGJWYXhyQVh3QUNQV3ZNZFArdWdwT3lzQkJWVEpaZ1gwWGMxWjNtRllh?=
 =?utf-8?B?dHFLa1JwalpiYkFKZFlNekJKWVJxSzZTS3o3cHBWVEEwVGQvT3kvUko4cThO?=
 =?utf-8?B?bUkxT05xWVgxQS92N1FnRmtEWGZicE03WlhBK2hmemRjamFMdW55TXNmQ21m?=
 =?utf-8?B?OTdxN3ZzRUdBNzlzdDJmaUJQczBXSnNhN1VpdmFNTnFnZnlVdnRid25xeWJD?=
 =?utf-8?B?bTM0YlE1NFpXWCtDcjgrYVlXa3lMdjcwcUhjSFRiVjJRVFc4L296QllUL3VU?=
 =?utf-8?B?bzBVejZ1czBjcUc4ZHpKK1FhclByUCtaVVJmbFpmNzZDZG5TdUhlSGlPaTUx?=
 =?utf-8?B?TmR6UHNZOHIzK1IrdkhJWU5KQnB6T3V5cW1ZREJubDQ4cDN5OEJUZTJtV1ZD?=
 =?utf-8?B?aTVHWDdlMVlqcDRPSVduL3YwaDAvb0NYSkFmNE9JQUVGemlyZ1c5d25udnF0?=
 =?utf-8?B?WFZyLzh5VWp6RDNkNkYvVEFaQjZoQU1Td3JJeTdYRnpQOUNCZTlRUWVrOExo?=
 =?utf-8?B?NWIrWUhpaUt1VWtXZW44MnNCRFRJWG1zY1Q3WjFMSG9LWkdsa2V1T0UvSFh1?=
 =?utf-8?B?ZUY4QWZUNWwyZmlTVk91NGhCTkhIZ0dBYXQ2NFRUYS9nRllVQlg4dVJtb1pE?=
 =?utf-8?B?UElPL1Q2Z21CRE55a2RDVlFIYWpZSEwrSWkxWTJpTzU5QWNNdmQra1g4MmNK?=
 =?utf-8?B?bFpFN09aZzhpVUFGT0xIQUdLaG40M2trN05pWW4xVkZLNEhLS0MvcTRJSGxJ?=
 =?utf-8?B?T0lmOGMzMkZmdDBjY3hJWW8zNTNtZFBTMHVGaW1Zb01zRTVuemMwdmVnZnFw?=
 =?utf-8?B?cUxaMmkxc3pWdkkrZFVjUnZOYXNvdUdnb0VqeEFGVlUrK3RsdnFvRTB1V2dk?=
 =?utf-8?B?MEdzc2IxVlIxY1puZVJ0NCtxTElCOUZzbzNESkV0YVVhSWY0RDI3cFM2WUJQ?=
 =?utf-8?B?N1BzM0xXbDZ3Z1E1U21qUVcrR0lKZWtCU0ptTTdMSGtCbEwrZEpuUDBJUmRM?=
 =?utf-8?B?ckRFQlRJajdCNmZUNm5WZEpkaHpvdnpzWU5jb2o4ZERkakRzSXN4dWZsZVFS?=
 =?utf-8?B?SHIzNlQzNkJCUFpESWRkMHVIL2Yya1d5UnluRmd5Vk5RYkFqQmI1ck8zUHBQ?=
 =?utf-8?B?VjdDdllqUHRNODFXRXY1MGRRdkxWR2JrcHd0ZXU3ZVQ2c1o4bGt6aFhYKzJ0?=
 =?utf-8?B?WnVqclJIZEJuVzFZbE8zYTUydzdnWmxnMzd0MVFLZG9kRmdkSjhvNDN2Tkh2?=
 =?utf-8?B?TTB6dWh6Qi9kV1hYd0FKSjhBc2hjLzVxZzFJZ0huSVpIbFpjQjFoeHhvWDVX?=
 =?utf-8?B?NWdyVHhIRFNyRnZCbFdtYXd1NEF3c2xpbjljdGt3RU42NDgxb3EydExsUjFQ?=
 =?utf-8?B?TzE1V3NpSU1CemJaUnBjVEN6b24wVmhDZmg2THBNaS9PU3lTK1NZYnYwTVZM?=
 =?utf-8?B?cWFEc0swazN6RktodU9LeUJNalNLUEkyc2lzRnZRQWFybURvQXU3Vk5zSURu?=
 =?utf-8?B?TCtDUVlKOHh3TWVjb0hiR2lLNjhaL1hhQm5oczFqSXdKdDJDWng3WTJDMCtJ?=
 =?utf-8?B?Q0h6a1RDZ2tRNmhRbk9ndXpuTnJGdmVwT2RVS1V2V0kxU0JIekR4eDFCQ3Jj?=
 =?utf-8?B?THFCL1pSbkhmakw3WE00dmpRVmgrOHdyNi8xSUtnb2pZejc3eDdsSWFySjdH?=
 =?utf-8?B?U3RKN3ljN0dnVllpV2NKRDl1NGIveXlnRXp5R2pwUnNyYjhkdnIxYnhpdHE5?=
 =?utf-8?B?WmltejkzT3N6Z2ZkRUd5RmpYSHliVU16ZmVuOHE0OGpNcWU4ZVBxa3lRTlg1?=
 =?utf-8?Q?4S3W7k4SfJpZJ9roiMALgcp33?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDBF7897A1BE0F4CAEE8770679E67C10@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f689dcf-c061-45ad-0e60-08dc47e63639
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 07:28:45.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Mx9p2qbfHWoK/DkIwgFM0TJ8JfnOjLVLlEousEKgV5A+PsVcUzISojNmdv6O8EO/QcHqfk2r4mFOnnto4DkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8746
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.928000-8.000000
X-TMASE-MatchedRID: fgYTp5XatxYOwH4pD14DsPHkpkyUphL9I5K4Cd+0ao+yD8qnkE3ipKM1
	tLS3/RBJLYexjI/F2s4qwQCg7f5qkwDNPxu11HXj4pdq9sdj8LW5+1figft3Lpsoi2XrUn/J+ZL
	5o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+zZ0VU/BSQ6FBYhCZxm8nLhlWrg9WdIYgpglE
	FYbNk3BuOeD6kjxot7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.928000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	39DAECB93E522B6EDA63A5AAE33E807F083F4E1048A40D6B3EC75BA632362CF62000:8

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjQtMDItMjkgYXQgMjI6NDggKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gU2luY2UgTVQ4MTk1IGNvbXBhdGlibGUgaXMgaW4gdGhlIHNpbmdsZSBl
bnVtIGdyb3VwLCB3ZSBoYXZlIHRvIGFkZA0KPiBpdHMNCj4gY29tcGF0aWJsZSBpbnRvIG1lZGlh
dGVrLWRybSBjb21wb25lbnQgYmluZGluZyB0YWJsZSB0byBlbnN1cmUgdGhhdA0KPiBpdCBjYW4g
YmUgYm91bmQgYXMgYSBkZHBfY29tcC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgu
bGluQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gYW5nZWxvZ2lhb2NjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMiArKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggMTRhMWUwMTU3Y2M0Li45MzMwM2JmZjhmMzQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC03MDcsNiAr
NzA3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gbXRrX2RkcF9jb21w
X2R0X2lkc1tdID0gew0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX0dBTU1BLCB9LA0K
PiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtZ2FtbWEiLA0KPiAgCSAg
LmRhdGEgPSAodm9pZCAqKU1US19ESVNQX0dBTU1BLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTk1LWRpc3AtZ2FtbWEiLA0KPiArCSAgLmRhdGEgPSAodm9pZCAqKU1US19E
SVNQX0dBTU1BLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRpc3At
bWVyZ2UiLA0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX01FUkdFIH0sDQo+ICAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZGlzcC1tdXRleCIsDQo=

