Return-Path: <linux-kernel+bounces-91624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F10C871458
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6172849CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A138385;
	Tue,  5 Mar 2024 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UtZvo+DV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="v+shHGas"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5E376E6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609889; cv=fail; b=JfogthrFTqva/cbmwL+DG70XKpZZm0Lsil5NkhEkY6NOpX1N8mqy+KWl78VuHuWAQp7t7T2tKhj5X8eGu3ysAt1IE99bK22Cnj7yFWy2rwr6nZazrf/XH/3sPyKnOKhMW7VwCPdL4A6V9b08yF4UolzyPJlbph8TqZOs3ZRv3DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609889; c=relaxed/simple;
	bh=p2nIsOx9G/jQcDdJbfpVpXrMBpjtn53FYjmLZrycrXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNKRfDDIuqUDzvjRyu79iuz6gf9UHd5opYgvd8uhjJEEeo8CXUtTuKWcBTi3IJ3UNYpJcoQr4D9noNJSiZ+jH7e1PuZ77nbDzbSC5LCUY+/40TAHulLMQ8UhZCXuxuXSkusB9JWnjjaTMAfoWVtrTSYXWkxrgOwrYL1aZhGuru4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UtZvo+DV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=v+shHGas; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c57f9770daa111eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p2nIsOx9G/jQcDdJbfpVpXrMBpjtn53FYjmLZrycrXc=;
	b=UtZvo+DVdWRBJi4Ye1l8Hg7UxWO4WGzu+ywm8Wt3IIHtvWFQAj6bU3jonVa54nZvfvduZqKEJjEQQZbANKf4ouGNEW2Tg8xf2RcGk9MZ53sOcQ82G2p4kpkdJ0qcjdeDc/rVWuXajxzjhygEv9FPAeyHFeWDSYZH4QES034akzg=;
X-CID-CACHE: Type:Local,Time:202403051126+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:35bdd849-47ca-4d9d-a874-47ba34d2297d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:16cb82ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c57f9770daa111eeb8927bc1f75efef4-20240305
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1371164959; Tue, 05 Mar 2024 11:38:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:38:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:38:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFGY/XLQqAWV1uiYa3dtzDJim2cNZxFdZO/zI6y4UhJjyVrcmstYwDQnkkkCYSSPNZjKtoB6gDCkkmWteNoeI/o9VD4LhnLbJFEW6OgvyQur+ffcZxCAyKcYv3v4CNfl2ljgnzb95kj+QYoEx+bowy/ILn82SdzCM9R/oGb5gRSA2hitzCPLAq33ZXa0ZkLhHZ/NzcfgoAWAtyKpHa72DwOr+uZzJxoeqjJd46OD6/W2/ZIw010YkHORTMJFXpv/ASbQBJuZA6dcOYaqO4TMG2jSrEJ3YJu2OiHiqL83S3/iGUcosWoRkqQZIdWXqbsKrGnDNQ+utmejXCWz2gCh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2nIsOx9G/jQcDdJbfpVpXrMBpjtn53FYjmLZrycrXc=;
 b=Nf7bsa36ge7ovBFPhjNv+UZxO3idMrAUiIhAOk7sANtd2MGQmRHvDDpIlTzh+OQxViecUAsnLHFQsprmsPVy4WMb1H+ejw0S0SJ6Dnpjyj4WSe4gFN5oHHdWhoSyj8Fv9vUdtlPg1ZpL/KJ8vGSD9N/AJPocvV9X6AFKqUluIhFBJQ5q+2L8t9a7bilMOeZufWt5AiaOaOlecqZmudDdh9PR+OpgcAQ4uJTeL8wZI3YqSUNN8uRCb4y7QTEwSeaO1aycg9PE8+1T2JPZveGxPY9TPy+URhcpXpeMqP9qLxFvXIlmd14bfLOxxOMST+tPdE234XgdfbZ1+b3+06q1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2nIsOx9G/jQcDdJbfpVpXrMBpjtn53FYjmLZrycrXc=;
 b=v+shHGasBz3P389KioXmFZga/4vPdHJAwPPvJoKpjBqPXwRVW7lTqwzTJctNf1g+LiExto01J93RPEidRgFXGe6nSpeRIO2iQ+uwDlp9KohvUQxMNi4j8GIn0lfM83M42tp5ie5z/u0vkB3Tvs4+/Io3M2VWWcWdOfAwSBT3utg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB8402.apcprd03.prod.outlook.com (2603:1096:820:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 03:37:59 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:37:59 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Topic: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Index: AQHaa+cLJ6J47YqzE0edY2v/hhyrU7Em65gAgADYAYCAAL5vAIAAAzIA
Date: Tue, 5 Mar 2024 03:37:59 +0000
Message-ID: <0e18361489d77d38647db957d921bf21fcc067c0.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
	 <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
	 <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
	 <172e03d1f7bdb65c15e6a6ca5f52b3dd1929c7cc.camel@mediatek.com>
In-Reply-To: <172e03d1f7bdb65c15e6a6ca5f52b3dd1929c7cc.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB8402:EE_
x-ms-office365-filtering-correlation-id: e0b66050-236a-4980-cb92-08dc3cc5a792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MHcwzzSWS8EPSXrPzOOiLWZkVJcYgJrKmslI/zbH34bCzLnhRfDHeugS5mvy/N+nB5OsuDz7hZ/Piz4zxYYWZb5C5kWY/WteFGsv5sMAFcd9khUO/iBX39Fo1ctPGQ7UpQLjItS6FRyz3wSHWN1TyeSPh2BpfkHYfYmgKnyfGgiq0B8xM/4I/NX8vtO7v4/qQ39hsL1S3nm9CIYJYz3ywmqXshHaMh7DCVbzVaE+8K6H8bwI5RBNV8HTEdYFYHr9SQ0iXS6uTI8IdjQx9HpOKLqfLdIDlxTFYtnellDr/SW4xGt+UEg9iR9X3dhlRoCm8y/8Ypf3m+Fw7IbOHbehZmcS34bQcuQAbJI8h3dvzQJxjv50VBNjIn8vNUYrDy4H+u0vVVBRYd3ueDJBlDkKOK6rFsIOz5DHHD70XpkRinJRiD3MG4eYMrl/A2DBt59KSuYiaDMtESVLafIJ6pmqQHRY6xvo5UNkwNCaO+lRcbQhprBXeGnUSFq51g+LjzvMTosL+wqY4rdmbYB7VgcG0dDIASZfWGcI3Uf9+9jjw7wLq+GAD+htT5X46KPHUdpsGdkMpLh9Sbtgj/7h7to/CVA4tqh/la6W2jFxreugUtLWbUxr1tCX5GQ72lDjC08MiQkC11Zhth5mkSpMltzJJh1wvLoXyrCiwobKuP48JbCutNo4In9P2/tBXNLdchXgctAdCMI3+WwV0x/futZpr2ITClJ5SO4ytTifsKBDFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkN3TTdkNExwTk5QVmg2OU1HelY5bFRFRWpSWFkvMXhQZzlmZ2lJR2Fyb3Q0?=
 =?utf-8?B?VDJjSGJJQVQ3bFdNL0ZyKzVoRXJKNUVKYzhVVERLRFBmZ3BYa1R3Y2crMTJR?=
 =?utf-8?B?L0F0RFRYMk1XSnVKODhTQ0t1YTR3cGJ3cWJwY3Bodm51OFZFYTZTeFJiWGhn?=
 =?utf-8?B?Rm85Mmd4M2o2cXduZWRJWndvREhhVkltdUFpN3U5TUZHUkRPUHRnbFhQU21P?=
 =?utf-8?B?L2E2a1JrZ0c1b204SFVZNDVBVURVZUF5S3lIa2lQTTM0NWpiNmpBdGVwbFlG?=
 =?utf-8?B?cmtybmU4c2lIcy8xSXBGK1g3SmFHUFNKL2oxUmZpVFdZLzJpdkdDak1lM1JS?=
 =?utf-8?B?ZUlXTXJHYm5nendXNWEwTHJUVkxuMDR5c1pFYkcybmtFQ2RXNFpBbE13MGUy?=
 =?utf-8?B?a1VRNnl4TVIzLzBlK3FPZUxQVFFFcEtaV0RzM2NVZWlBVS9qd2QzQzdrYUxP?=
 =?utf-8?B?dkVrYUJEQ1NGczVVeFBTYUZyVUJuUXdyd2pURHhwZTRNK3ErdUMyN3I2ZVBi?=
 =?utf-8?B?ZmNZcGdjTjA5c2ZYVW94VXFtMjBxVy9JOEk1OVlZazY0Yy9TMWhoSFVqbFZN?=
 =?utf-8?B?YUJwaFZQZy9aM0kyWTF2U2RQZ2lZbVpabXFMZWFVQkRWclZLWXRJWFN0YUtT?=
 =?utf-8?B?cDVLT3BGeWJJU2ZYRHY5TVZsRkUyVHNiQ2NEUkpJeE9jbDhwSW5WWGlMZC9w?=
 =?utf-8?B?YW10dHFsdUx5aWt3RTRKbHR6QVdkSlo5M3YxcFkrbFhRRUk1VzFXcmtYbmdk?=
 =?utf-8?B?SmR1U3dQc01INElmYW9pa1BBeW5CVVJ4ZkszZzRSZDBBMTg2RzdEblRIcE9D?=
 =?utf-8?B?UFg3djlscVZKMXhpMXdKR0R3clhhb0FodlRaZ01lU2s1VTc5RkRrOE8rekxo?=
 =?utf-8?B?NjZhZVMvSldBS3B4c0NBY2NjZFB5MTFaNWxvNUtpS1Z5S1hjVVRuRW5QR0NV?=
 =?utf-8?B?c2tmdHVJcnhUWllCSHNCUWtQRElINWc2ZEJTUTB3ZXFHVVcrYW9CQWlxLzM2?=
 =?utf-8?B?dE03ZWlwdysxVHJRVWEvUEc1WkVPOXQxMkREcHJVc1FwaGZDL2dYR0o2VWE2?=
 =?utf-8?B?SXhVSGtEZ3ZJWkZLeTJwdWRIS0QydXROVVYvV1k1MHRNY1NqVWtJR1NlcEM0?=
 =?utf-8?B?dTdNVnBFMjFETlVXQ0RwUEIyUkliekVkTkNGMHJFVVVLYmhDU3ExWnU0bGg1?=
 =?utf-8?B?QVFOR1ZQMk80QjY2cWROZzh4eWZzUE1ZdG0xdmpDZmR4ZlRNZTdnczIrbkZX?=
 =?utf-8?B?U2U0TVR4YldRUy8vS243RmxLSnRyUnRMRDhlem5Zcm55R1ZBZk9zak5ncGI2?=
 =?utf-8?B?ZnJTaTdPTnJSZDZkb3diVUFuMmc5UVVIdEZwSXlQdFlUeHY5alJ2d3dzUFNi?=
 =?utf-8?B?cHpoZFU3MGRiSXpMUmx4cVBzRlFBNUtmNk1NbDZlWFdNV0E2YXFob1ZPTFdn?=
 =?utf-8?B?cGVVWlpRejA2aVlGODh4T282eDJiMllENFJxWnZzVVA3YUxOVzZZMTNjWm52?=
 =?utf-8?B?K3dXTkR4SkhycThjKzRBZExtSXJhS0k2N2I2dVRBbnFqSFhJdVJ6MDE5T1Uy?=
 =?utf-8?B?c0l4M1JoRTUwZmk4ME4yRnNIdFZzTnJQLzM3VzJYbzhEcnJUaHpnbkpHM2FO?=
 =?utf-8?B?bDRIZ0JUNnpuOUwrYnZHY09IMHlSLzZxZ1RtSmlUSFdUeCtFOUovSGxZT0hF?=
 =?utf-8?B?VUNQaS9UNXV5dGFySEdyWnhKWmg4OForQWUxQkp0UmZsMkFWalBaV0ZpYU80?=
 =?utf-8?B?ay8vMk51R0lPYWNLMGQ4ZkpGMkNhM1MwZkVwMG9mYzlXR0RNblJLaDlYQ3pG?=
 =?utf-8?B?Z05uWWJSS09qQzRmUHFnM09PeU1qMEp1THcwZmZYNWtSM0lHYmE4L2NWZko2?=
 =?utf-8?B?TzIrVGZVRmhpYkloY1FQZFBIRGdGZUFYWlBWM2ExTWdsNVlzWHZkeFVpVGx0?=
 =?utf-8?B?ZUgyOStJUkFpdHp1U2VHMkdRR2ExMUlIaDV4OXB4NXRDK25ENVp3b2FkNDNH?=
 =?utf-8?B?UDdZdXdSb2ZDUHNLSVozVVNZSXM1YnRvYVZRV1o3QjBpazRrWGt0U200ei82?=
 =?utf-8?B?WWhlWUtoRktXdFdoSWRpN2Z3cG9ING15S1lZcVdOYlIxOVRBZnFBQW91N0M1?=
 =?utf-8?B?TGtCNFBLbkNqU0t5WjEvcTdEMWpUc3FIS09nSWxHdkdmSUg5VGtacER1ZlpC?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC164A2855BC0345A96C590D858AD38E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b66050-236a-4980-cb92-08dc3cc5a792
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:37:59.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UmhuaSv67JhEItbXdaEpOI/ExYAxTxZhP6GSZ3qwLFQN2i3vkNt6Gsvd819hfZ6Y077EEgULy0jDI7J4nXW0ay9COIwvNPtyOphFAwhwIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8402
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.820500-8.000000
X-TMASE-MatchedRID: 8+bhjh9TQnHoSitJVour/Sa1MaKuob8PC/ExpXrHizyLWuywoQz7tLmn
	rGB/kwGMH+RndCK32H0hcnM8qCdEajW+K/PcvqBro65WJt1k1O8Ea8g1x8eqF8lgi/vLS272+lm
	NZCKoGWFG5M2kXEpG3mmW2sWau8OPzcCZ20yMYlUD2WXLXdz+AbuesBT0pDFRDpCUEeEFm7CtEa
	JoVjyWkDu/leP9T0nGAn/jq7o4j6CUYaO/E+T/Q836paW7ZnFoUXlp1FHYSPVzwVmY5TMrNvWnL
	2FmW8AToYF92SVscfliEgb3ryiNYFfcVmfgO8Ty2OSj4qJA9QZb2iL0xnz/EsxIlVWoMfNWZt9E
	JVCt3oi+5D/rhFC2hJGTpe1iiCJq0u+wqOGzSV0LbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.820500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B491891A12C4FB46AE36095EE343D3ED83D946D44189EF3648E61851813EB2C32000:8

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDAzOjI2ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDE2OjA0ICswMDAw
LCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4g
VGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gPiANCj4gPiBPbiBNb24sIDIwMjQtMDMtMDQgYXQg
MDM6MTEgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEphc29uOg0K
PiA+ID4gDQo+ID4gPiBPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gPiA+ID4gQWRkIGNtZHFfcGt0X3BvbGxfYWRkciBmdW5jdGlvbiB0byBz
dXBwb3J0IENNRFEgdXNlciBtYWtpbmcNCj4gPiA+ID4gYW4gaW5zdHJ1Y3Rpb24gZm9yIHBvbGxp
bmcgYSBzcGVjaWZpYyBhZGRyZXNzIG9mIGhhcmR3YXJlDQo+ID4gPiA+IHJpZ3N0ZXINCj4gPiA+
ID4gdG8gY2hlY2sgdGhlIHZhbHVlIHdpdGggb3Igd2l0aG91dCBtYXNrLg0KPiA+ID4gPiANCj4g
PiA+ID4gUE9MTCBpcyBhbiBvbGQgb3BlcmF0aW9uIGluIEdDRSwgc28gaXQgZG9lcyBub3Qgc3Vw
cG9ydCBTUFIgYW5kDQo+ID4gPiA+IENNRFFfQ09ERV9MT0dJQy4gQ01EUSB1c2VycyBuZWVkIHRv
IHVzZSBHUFIgYW5kIENNRFFfQ09ERV9NQVNLDQo+ID4gPiA+IHRvIG1vdmUgcG9sbGluZyByZWdp
c3RlciBhZGRyZXNzIHRvIEdQUiB0byBtYWtlIGFuIGluc3RydWN0aW9uLg0KPiA+ID4gPiBUaGlz
IHdpbGwgYmUgZG9uZSBpbiBjbWRxX3BrdF9wb2xsX2FkZHIoKS4NCj4gPiA+ID4gDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyB8IDM4DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBp
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDE2ICsrKysrKysrKysrDQo+
ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiA+ID4gPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+
IGluZGV4IDNhMWU0N2FkOGE0MS4uMmU5ZmM5YmIxMTgzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gPiArKysgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gPiBAQCAtMTIsNiArMTIs
NyBAQA0KPiA+ID4gPiAgDQo+ID4gPiA+ICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJ
QklUKDApDQo+ID4gPiA+ICAjZGVmaW5lIENNRFFfUE9MTF9FTkFCTEVfTUFTSwlCSVQoMCkNCj4g
PiA+ID4gKyNkZWZpbmUgQ01EUV9QT0xMX0hJR0hfQUREUl9HUFIJKDE0KQ0KPiA+ID4gDQo+ID4g
PiBJIHRoaW5rIHRoZXJlIGFyZSBtdWx0aXBsZSBHUFIgYW5kIHlvdSB1c2UgIzE0IHRvIHN0b3Jl
IGhpZ2gNCj4gPiA+IGFkZHIuDQo+ID4gPiBJDQo+ID4gPiB3b3VsZCBsaWtlIHlvdSB0byBsaXN0
IGFsbCBHUFIgYW5kIGRvIG5vdCBsaW1pdCB0aGUgdXNhZ2Ugb2YgZWFjaA0KPiA+ID4gR1BSLg0K
PiA+ID4gVGhlIHF1ZXN0aW9uIGlzLCB3aHkgbGltaXQgIzE0IHRvIGJlIGhpZ2ggYWRkcj8gSWYg
dGhlIEdQUiBpcw0KPiA+ID4gc2hhcmVkDQo+ID4gPiBieQ0KPiA+ID4gYWxsIHRocmVhZHMsIHRo
ZXJlIHNob3VsZCBiZSBhIG1lY2hhbmlzbSB0byBtYW5hZ2UgR1BSIHVzYWdlIGZvcg0KPiA+ID4g
Y2xpZW50DQo+ID4gPiBkcml2ZXIgdG8gYWxsb2NhdGUvZnJlZSBHUFIuDQo+ID4gDQo+ID4gWWVz
LCB0aGVyZSBhcmUgMTYgR1BSLCBmcm9tIEdQUl9SMCB+IEdQUl9SMTUgYW5kIHRoZXkgYXJlIHNo
YXJlZCBieQ0KPiA+IGFsbA0KPiA+IHRocmVhZHMsIGJ1dCBHUFJfUjAgYW5kIEdQUl9SMSBpcyB1
c2VkIGJ5IEdDRSBIVyBpdHNlbGYuDQo+ID4gDQo+ID4gSSB0aGluayB1c2VyIG1heSBub3Qga25v
dyB3aGljaCBHUFIgaXMgYXZhaWxhYmxlLCBzbyBJIHRoaW5rIENNRFENCj4gPiBkcml2ZXIgc2hv
dWxkIG1hbmFnZSB0aGUgdXNhZ2Ugb2YgR1BSIGluc3RlYWQgb2YgY29uZmlndXJlIGJ5IHRoZQ0K
PiA+IHVzZXIuDQo+ID4gDQo+ID4gQ3VycmVudGx5LCB3ZSBvbmx5IHVzZSAxIGRlZGljYXRlZCBH
UFIgaW4gcG9sbCwgc28gSSBkZWZpbmVkIGl0IGluDQo+ID4gQ01EUQ0KPiA+IGRyaXZlciB0byBt
YWtlIGl0IHNpbXBsZXIuDQo+IA0KPiBJZiB0aHJlYWQgMSBwb2xsIGFkZHIgQSBmaXJzdCwgR1BS
IGlzIHNldCB0byBBLiBCdXQgcG9sbCB0aW1lIGV4Y2VlZA0KPiBHQ0VfVEhEX1NMT1RfQ1lDTEVT
LCBjaGFuZ2UgdG8gdGhyZWFkIDIgYW5kIHRocmVhZCAyIHBvbGwgYWRkciBCLCBHUFINCj4gaXMg
c2V0IHRvIEIuIExhdGVyIHN3aXRjaCB0byB0aHJlYWQgQSBhbmQgR0NFIHdvdWxkIGV4ZWN1dGUg
cG9sbA0KPiBjb21tYW5kIGFuZCBHUFIgaXMgQiwgc28gdGhyZWFkIDEgd291bGQgcG9sbCBhZGRy
IEIsIGJ1dCB0aGlzIGlzDQo+IHdyb25nLg0KPiBIb3cgZG8geW91IHNvbHZlIHRoaXMgcHJvYmxl
bT8NCj4gDQpJZiBQT0xMIGluc3RydWN0aW9uIGhhcyB0aW1lb3V0LCB0aGlzIG1heSBiZSBhIHBy
b2JsZW0uDQoNCkJ1dCBQT0xMIGlzIGEgbGVnYWN5IG9wZXJhdGlvbiwgaXQgd29uJ3QgY29udGV4
dCBzd2l0Y2ggd2hlbiB0aGUNCmV4ZWN1dGUgdGltZSBleGNlZWQgR0NFX1RIUl9TTE9UX0NZQ0xF
Uy4gU28gd2UgYWRkIHRoZSBjb21tZW50ICJBbGwgR0NFDQpoYXJkd2FyZSB0aHJlYWRzIHdpbGwg
YmUgYmxvY2tlZCBieSB0aGlzIGluc3RydWN0aW9uIiBpbiB0aGUga2VybmVsZG9jLg0KDQpBbmQg
Y3VycmVudGx5LCB3ZSBkb24ndCBzZXQgdGhlIEdDRSBoYXJkd2FyZSB0aW1lb3V0IGluDQpDTURR
X1RIUl9JTlNUX1RJTUVPVVRfQ1lDTEVTLCBzbyBpdCdsbCBwb2xsIGZvcmV2ZXIgdW50aWwgdGhl
IHBvbGxpbmcNCnZhbHVlIGlzIHNldC4uLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4g
UmVnYXJkcywNCj4gQ0sNCj4gDQo=

