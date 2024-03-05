Return-Path: <linux-kernel+bounces-91621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B587144E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8CBB23E51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44A3CF75;
	Tue,  5 Mar 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OwzqwTpx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dUGso7cB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEE29CE9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609480; cv=fail; b=qB9AfZWfcYfj/GMLLGXvD3ki8oYgFhf/4rTAhbaD7BYgq9pC7ZoV/zbqj+86egQ/1lTHUfaXUZinUhTHso4Pq0mtCRZY/55e6jDDRhFNz7Lw6/IxTnF0FIzC92NG1URXy34A5dvUBp5SgxfQxGTgXMWwexLTlKInhSqqftI0DjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609480; c=relaxed/simple;
	bh=XgD7YIfsdA2nEwUZCh+mDF6I7INcMHO94EDV6pQR8YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9apvUMYkdyIO1vCDHdpy5fGBAdQEbS/Y3ni+Pbu6vnyqY7trliIlmFk7lG9KMjNPNXc4DnY2ti2x1x0Wrcz77DaIGWwJKvaY0/afL17kbHYfdV4YCZJ/ZfgRFpCT4W8SIF5E8jVALR9EWUWJ9VCUZMRy8AAbNRSCmHWLSdinkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OwzqwTpx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dUGso7cB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0af99a2daa011eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XgD7YIfsdA2nEwUZCh+mDF6I7INcMHO94EDV6pQR8YY=;
	b=OwzqwTpxnuuYH74TLI5zkbtv7RAIEjH/U2exjT86GUi0gdlMtIdovVIWG/ttCHLw9MsNcloWX5p+IbfWFA/7UXjSqm4UPpjsxkwme5GlAlXH1WG+IZwkAA/z1/JfAXM4TqgJJFcf1rF1IXJ390gkrSs2TXSu/g1h52yIDUdX/qw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a93521d0-a0ea-437d-91ee-078bf34b2c57,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:08f40490-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d0af99a2daa011eeb8927bc1f75efef4-20240305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 618595064; Tue, 05 Mar 2024 11:31:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:31:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:31:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Biv8sSWlGMEGdOOY+M95uC49KwxjPGBQoneFKo1wSa0hFB+d6Jtli5nBHif4kTBe55QVwBQjbtEiCwWJYUQZd1oqX3snzDvXdyDOPGNVGkkRsHZ50J+USn8IVgIWNn5mIjp9zhDAG9lGEg9Fiy7UvSaUKfcU/X/eiFKBaQHu4wSaXu/Yy9XZy795xcMitfqX8VsNn3bjKPJv19V0avPhnduj4EdWYE7Smz57WDy2mcNYDtqGDlMZPVJcP/4yXghEifVdn7nztmNOmvh1bSRozCfZejTHc1y9gYl7M2AM645bXM1eXp8/kkis//2UfESbB4K35qiPaPqHNbB3beaOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgD7YIfsdA2nEwUZCh+mDF6I7INcMHO94EDV6pQR8YY=;
 b=FOtZ9SC0JzDqnDE3xtsVZ7vPwL7b0Ge2jSb0ApUWZhtmrkZjwlC9rzyTEIcBLs5xE5dSi1c0uqrYFkt9/mlkTCyUBZljXP57f9qYXPkx8jnMCJEStgHIO+KBaByQ3vpZm7Ofgt5kECgQUca/8n5olQfbqA4xcIJGMq/Jvimt/WYdnxVq9WnFQ52kmyKI/lFbasR7vIDgWzlq1hlCV6YwURwr56oEpywTnR0R3oHPpBxMIHGJzD0LLYPD4gduo/30uxdqaTEF+bF1W83m/SHnZRUPpatDSCucjjH4+Nd65+8x+hP1mZo7tvBQ1Zspd7HCEO4RxExsP7DtiAKlBDue5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgD7YIfsdA2nEwUZCh+mDF6I7INcMHO94EDV6pQR8YY=;
 b=dUGso7cBhrsYuU+f4c1jrCqTYQ7KJRMD+cGJgZf5Fx6OX/8iG7iOVSbYkL70cSo6NHalpg3FjrDdTCg0FUh+7KZPFCmWdwepVtwSmcszC6Sk3GS8x5isfZSNu3J5BigMqvzpOo6YublfVTcvB6xe9dreS+eeIr1OmReJ8yVjxsk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6992.apcprd03.prod.outlook.com (2603:1096:101:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 03:31:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:31:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
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
Subject: Re: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Topic: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Index: AQHaa+cJEQPI4k9J/kOhfVF98/x/R7Em3+aAgADfjICAAMPfAA==
Date: Tue, 5 Mar 2024 03:31:08 +0000
Message-ID: <ed9fc19a909ee6aeb8fc8eab10020808ea391b38.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-6-jason-jh.lin@mediatek.com>
	 <1d14bad104b8e5c74ffe6c08cbafb4da6e1e751a.camel@mediatek.com>
	 <ceab73ebb925dacc14376f7054e20411612b507e.camel@mediatek.com>
In-Reply-To: <ceab73ebb925dacc14376f7054e20411612b507e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6992:EE_
x-ms-office365-filtering-correlation-id: 68e06f63-fe4c-4b7a-20ae-08dc3cc4b2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c93MTZtWvQ6Wb6Qa09hA4+retqJXOxNpSbOJfDH7kD+5vffCuyCmI5jfWh1zoUcHGBfEz434eT3mseVMtdx10ShvCGidYVqPH39dSVo/eosSH6nU9WdKa99C78wY8yTISsrs9ePrMNsaq8yVC1fkJZd3yIElmj/7PWObNM5OpMcskJHE5nAXn8BFuzBaZfkkSLHKHwGm52FqziwL/czN/ZQi2gS4XKyTpJ9VwhVe+QFOBrp7O5hhbqXvCHbs4hVHBQre1jJr0PKbOiZgqZ6eIy4GKJud18HubcQtwrvJi5kmYVUcHT/PJMp2UMEFWrGoFFYLVD9u9lTzw5Q9OaOUbtmrFENxXQMhEC4A92H3KsXkKL6DXEDnLvJAHUkOcRqVdDn5vMw//lxan51IbycCR6N1KhI6fYuNu3wv9YsuBWboeAfx0WNkLqH4GQ8YNKV0PuCkdeO4Moaj/wdlMWalHtqCIhKYU46SwOjMGQSwTJLf85KqdCkmjKyGkiGL1CX7K+Bk4lu743MMXeNIZmd9nuq0yhCJo1R96aWK1JIjlEBXbVQLPpOX0Z1TNqyJ204fq2xHQJSokXvDIOskLBFt840O52JjUA7B5y9dhhIlFNZFEiZi/bZLmcK6U/tDW+OUtohcrTEQl9Q6loa/pjCAulzgqGtRSccqSyEjqpyyVFFErcmoptvTpFpzbvSyqfk4AKqsz2gcgx88B/ToSQCWxxKVrxpB11Kz0Eksy8sKjto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkhVaUVmUHFITnRRU1hKRFN4TkFidStYN2kwNDJ3UThNZk9EYmNoblN4L29W?=
 =?utf-8?B?aGF6WkNBcGFJVThnVEhuUi9yZi9mRjRIcmNDM0pMaklpQlNnVmJ1OUZESXJE?=
 =?utf-8?B?MU81L05QQTJrQmFqZFF1czdjZlpSemQ0ZUtHb1hkMnptK1E0RjFGd0o5R2do?=
 =?utf-8?B?TS9tNHBscjZNS2dkU0RSMUhuZHpPdUJ0SHRneDJNN0V2bnJaOEMzOW9KZU5w?=
 =?utf-8?B?OVdWTzBKTzh4clZwc3Vla0Z5YllSS3lJSXRVa1RZZnhqeHd4ZGlRK05hRDlV?=
 =?utf-8?B?SytWcXlkY1dUenJ1cmtJUVdZRURqYnJId2xVeWlUZWQxNHlhL3hXODgvTjRR?=
 =?utf-8?B?dnFDL0RNNnkyRnJlTkRtNXZqRG4rZ0ppcVNqemllVDJrZWlMb0RKby80QVhU?=
 =?utf-8?B?RllRRXR2UGZhZlB4c0FGbTh3THoySDVVMENGa2tUOVQxZTJKTys1N0lXK2Vt?=
 =?utf-8?B?RklQQnhMWnNOeGo0VFUwSU1MY1BrVy9qaUlTdGNtKzZKREVIRWtZSUF3aEV2?=
 =?utf-8?B?SktLUnV4djhwQ1lVelZUTW9ndC9lOGZUc21DbkJyTC9uQ0pqS05Cam9JR3dG?=
 =?utf-8?B?SEJTYWtORktLYWMydnRkZytXL3NaQVlHMmZZelgwVk9ZUXU0WEpjUEZMNk50?=
 =?utf-8?B?UC9QN2JTWVZiRUhQbFlSL2s5YTJvSXBnMWZ4ZDZtRnl3UkpzODJrMVJMeml6?=
 =?utf-8?B?SHVXaE1HM2swVlovOWlwUVlydDVxM04ybGVRYUQ3a1BjNll6ZDYyaXdqVGZH?=
 =?utf-8?B?citYaUxvSUF3R1Z5Ti9HQk1nV0prNlNuSTB4UFBYeCtMS2dNNVE2TTVmY1RK?=
 =?utf-8?B?enRkaEdoUjVVeUZZeEZxem5lOWJxZm1nRXAyYUVEemY5Ylp4Nk5YdHh4M3Vn?=
 =?utf-8?B?RWdoWEYzc2JRSE5Mb09KYjcyUjRxZnQzdG5RM3lnVGhvZXpGb0R6eEZIUHJX?=
 =?utf-8?B?RFIyQmQ4UzRjYmlVSENGd3RuS1NwazNJOTlTb1BBVjBWMGgzck9ldXhFcjVi?=
 =?utf-8?B?UjFpbWU1amhlSGFGVllmN1BTWnRkZWhYbHpaQlJLd0YwQXd2ZWx3bWpTMlMw?=
 =?utf-8?B?aVQxS0Zlai9WT3FRM0I0WHp1Q1J5cTVSZktXK0Uzam1HcEZla0dWSVJDVzVV?=
 =?utf-8?B?WUxRZ0doS0ltSFh1WTI3aEt4d2NiRUlxYjN0SXB2OGhWSDJ3TUp6WjROVE5t?=
 =?utf-8?B?NnpXNjRJR0krZ0NBRHd1UDUxMGRwd0c0cEt1cDhDcVJoNGJvWGpaYStDaFRH?=
 =?utf-8?B?KzFYdFU4WlV3cHA0bkFaY1R4Qjh1Z0d6MG9EcFRqcVFCdTg2a3lwN0RwUS8x?=
 =?utf-8?B?TkpvaW9HcFYzd0pqRHZ0UkcwQ0Q4eTR3ZWlyYlM2aUZadEhXYlByRzJlai95?=
 =?utf-8?B?bVFwWUJRQmMzdENudHV0WTNtVG9TUzE3SUlQUTZPYnEzOVErOW1QblAxNnR2?=
 =?utf-8?B?MTVjdHRqTEVaQndVVCtJdy9hbzE2TWhXL2N3OGpCN3lscjNIRmtFWlZrVGph?=
 =?utf-8?B?SjVxeU5JSzR2L0NKbktwYTNVWWxjblNYZkFGZzV1NmU0enYxbzhZSm5HK0RG?=
 =?utf-8?B?T0s5OXA4V240NTRFUUhvZmM2UndsL1NtbUFUOHV4MDJmR2V3aU9hKzJTbXJj?=
 =?utf-8?B?alQyeFVLaDJyRjYveGRzZVpiRVJNQitFMjhNTnJPRzUrMnFTa0JTbm1JS3Fm?=
 =?utf-8?B?N0ppSUptMnFCZThjT0owL1VoSml0Rjhod3pVbnpHYXNkZGxIOWpjOXY3OE5H?=
 =?utf-8?B?a2lJSXpxQUtFb21tNVdzTk9udy9ka0tQWnUzSEcxRWRUclg3S3hDUnBZRjdq?=
 =?utf-8?B?M0VjTmpGRmZ4MDFOYllMYVliMS9mVFpUUjEySWVZTG03Q0hBY1pYODB6L3F6?=
 =?utf-8?B?TGpueFdmR3grSE5RRXJGeEg4OVVpWUZpd0orNXRBZFV4cm01dXhWcVRDUHpF?=
 =?utf-8?B?bkhNTVNmSGpXY2VDdUUrUVFIR25VcnJoVzQvT1FnZy9wVE5GLzQ3T2g1N3FC?=
 =?utf-8?B?Q3FjZHh1bDl3clFOTGJOWUthK2FEUHowSDFFalZYT1ZGYkN4b0tCNUVzQmR0?=
 =?utf-8?B?d3gvcGo3bkx1SWo5R0hHNjdzb09IeWkyVkUrTmhXektkczZUYzQzb2VGQjJk?=
 =?utf-8?Q?k1+xqng0Sylaa9LMuPyNvSZMB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E055167477EA42BBA5AFC2858FAC01@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e06f63-fe4c-4b7a-20ae-08dc3cc4b2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:31:08.8796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVqePyQtxCv3hLyycbMdAH3x3AgPun+FEFwGctlUDf+0eD1Uxr5EcITwmLVZxvi7blY5T0f2rD5kznAR3uCSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6992

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMDMtMDQgYXQgMTU6NTAgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gSGkgQ0ssDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXdzLg0KPiANCj4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDAyOjMwICswMDAwLCBDSyBIdSAo
6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFzb246DQo+ID4gDQo+ID4gT24gRnJpLCAyMDI0
LTAzLTAxIGF0IDIyOjQ0ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gPiBJU1AgZHJp
dmVycyBuZWVkIHRvIGdldCBhbmQgc2V0IEdDRSBldmVudCBpbiB0aGVpciBydW50aW1lDQo+ID4g
PiBjb250b3JsDQo+ID4gPiBmbG93Lg0KPiA+ID4gU28gYWRkIHRoZXNlIGZ1bmN0aW9ucyB0byBz
dXBwb3J0IGdldCBhbmQgc2V0IEdDRSBieSBDUFUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgfCAzNw0KPiA+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCB8ICAyICsrDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOSBp
bnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gPiA+IGluZGV4IGVhZDIyMDBmMzliYS4uZDdjMDgyNDljODk4IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gQEAgLTI1LDcgKzI1LDEx
IEBADQo+ID4gPiAgI2RlZmluZSBDTURRX0dDRV9OVU1fTUFYCQkoMikNCj4gPiA+ICANCj4gPiA+
ICAjZGVmaW5lIENNRFFfQ1VSUl9JUlFfU1RBVFVTCQkweDEwDQo+ID4gPiArI2RlZmluZSBDTURR
X1NZTkNfVE9LRU5fSUQJCTB4NjANCj4gPiA+ICsjZGVmaW5lIENNRFFfU1lOQ19UT0tFTl9WQUxV
RQkJMHg2NA0KPiA+ID4gKyNkZWZpbmUgQ01EUV9UT0tFTl9JRF9NQVNLCQkJR0VOTUFTSyg5LCAw
KQ0KPiA+ID4gICNkZWZpbmUgQ01EUV9TWU5DX1RPS0VOX1VQREFURQkJMHg2OA0KPiA+ID4gKyNk
ZWZpbmUgQ01EUV9UT0tFTl9VUERBVEVfVkFMVUUJCQlCSVQoMTYpDQo+ID4gPiAgI2RlZmluZSBD
TURRX1RIUl9TTE9UX0NZQ0xFUwkJMHgzMA0KPiA+ID4gICNkZWZpbmUgQ01EUV9USFJfQkFTRQkJ
CTB4MTAwDQo+ID4gPiAgI2RlZmluZSBDTURRX1RIUl9TSVpFCQkJMHg4MA0KPiA+ID4gQEAgLTgz
LDYgKzg3LDcgQEAgc3RydWN0IGNtZHEgew0KPiA+ID4gIAlzdHJ1Y3QgY21kcV90aHJlYWQJKnRo
cmVhZDsNCj4gPiA+ICAJc3RydWN0IGNsa19idWxrX2RhdGEJY2xvY2tzW0NNRFFfR0NFX05VTV9N
QVhdOw0KPiA+ID4gIAlib29sCQkJc3VzcGVuZGVkOw0KPiA+ID4gKwlzcGlubG9ja190CQlldmVu
dF9sb2NrOyAvKiBsb2NrIGZvciBnY2UgZXZlbnQgKi8NCj4gPiA+ICB9Ow0KPiA+ID4gIA0KPiA+
ID4gIHN0cnVjdCBnY2VfcGxhdCB7DQo+ID4gPiBAQCAtMTEzLDYgKzExOCwzOCBAQCB1OCBjbWRx
X2dldF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+ID4gIH0NCj4gPiA+ICBF
WFBPUlRfU1lNQk9MKGNtZHFfZ2V0X3NoaWZ0X3BhKTsNCj4gPiA+ICANCj4gPiA+ICt2b2lkIGNt
ZHFfc2V0X2V2ZW50KHZvaWQgKmNoYW4sIHUxNiBldmVudF9pZCkNCj4gPiANCj4gPiBzdHJ1Y3Qg
bWJveF9jaGFuICpjaGFuDQo+ID4gDQo+IA0KPiBPSywgSSdsbCBjaGFuZ2UgaXQuDQo+IA0KPiA+
IElzIHRoZSBldmVudF9pZCB0aGUgaGFyZHdhcmUgZXZlbnQgaWQgbGlzdGVkIGluIGluY2x1ZGUv
ZHQtDQo+ID4gYmluZGluZ3MvZ2NlIA0KPiA+ID8gSSBtZWFuIENQVSBjb3VsZCB0cmlnZ2VyIHRo
ZSBldmVudCB3aGljaCBzaG91bGQgYmUgdHJpZ2dlciBieQ0KPiA+IGhhcmR3YXJlPw0KPiA+IA0K
PiANCj4gWWVzLCB0aGlzIGNhbiBhbHNvIHRyaWdnZXIgdGhlIGhhcmR3YXJlIGV2ZW50LCBidXQg
Q01EUSB1c2VyIHNob3VsZA0KPiBub3QNCj4gZG8gdGhhdC4gT3RoZXJ3aXNlLCBpdCB3aWxsIGNh
dXNlIGVycm9yIGluIG90aGVyIEdDRSB0aHJlYWRzIHRoYXQgdXNlDQo+IHRoaXMgaGFyZHdhcmUg
ZXZlbnQuDQoNClNvLCB3aGF0IGV2ZW50IGlkIGNvdWxkIGNsaWVudCBkcml2ZXIgdXNlPyBBbmQg
aG93IHRvIHByZXZlbnQgZGlmZmVyZW50DQpjbGllbnQgZHJpdmVyIHVzZSB0aGUgc2FtZSBldmVu
dCBpZD8NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgY21k
cSAqY21kcSA9IGNvbnRhaW5lcl9vZigoKHN0cnVjdCBtYm94X2NoYW4gKiljaGFuKS0NCj4gPiA+
ID4gbWJveCwNCj4gPiA+IA0KPiA+ID4gKwkJdHlwZW9mKCpjbWRxKSwgbWJveCk7DQo+ID4gPiAr
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiArDQo+ID4gPiArCXNwaW5fbG9ja19pcnFzYXZl
KCZjbWRxLT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ID4gPiArDQo+ID4gPiArCXdyaXRlbChDTURR
X1RPS0VOX1VQREFURV9WQUxVRSB8IGV2ZW50X2lkLCBjbWRxLT5iYXNlICsNCj4gPiA+IENNRFFf
U1lOQ19UT0tFTl9VUERBVEUpOw0KPiA+ID4gKw0KPiA+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZjbWRxLT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ID4gPiArfQ0KPiA+ID4gK0VYUE9SVF9T
WU1CT0woY21kcV9zZXRfZXZlbnQpOw0KPiA+ID4gKw0KPiA+ID4gK3UzMiBjbWRxX2dldF9ldmVu
dCh2b2lkICpjaGFuLCB1MTYgZXZlbnRfaWQpDQo+ID4gDQo+ID4gRG9lcyB0aGlzIGdldCB0aGUg
ZXZlbnQgc3RhdHVzPyBJIHRoaW5rIGV2ZW50IGhhcyBvbmx5IHR3byBzdGF0dXMsDQo+ID4gc2V0
DQo+ID4gb3IgY2xlYXJlZC4gU28gSSB3b3VsZCBsaWtlIHRoaXMgdG8gcmV0dXJuIHRydWUgZm9y
IHNldCBhbmQgZmFsc2UNCj4gPiBmb3INCj4gPiBjbGVhcmVkLg0KPiANCj4gWWVzLCB0aGUgZXZl
bnQgc3RhdHVzIGlzIDEgb3IgMC4gSSdsbCBjaGFuZ2UgaXQgdG8gYm9vbGVhbi4NCj4gDQo+IFJl
Z2FyZHMsDQo+IEphc29uLUpILkxpbg0KPiANCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+
ID4gDQo=

