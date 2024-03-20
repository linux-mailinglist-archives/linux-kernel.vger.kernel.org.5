Return-Path: <linux-kernel+bounces-108474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8958880AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84CE1C20CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DF1E501;
	Wed, 20 Mar 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NM//dBSZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eh9XJRLU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992351DFD2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914627; cv=fail; b=H2Qa56MHA0rb9SwLcn4CF96rmhGOY8uDhEDOyPd9YHyITGHW8pNd2pAJYAmzS0TkRqhHK/fnPGCFJFRFPnzwxkAik/RCWPPn/5akNVIxQEQj+CLy8elAwqpmUN2bGhLgnFhOL+1BcTwsV6c7BLp9Jy45JQDX5+8WgiVKhrrEq5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914627; c=relaxed/simple;
	bh=BfHe+ARrnShqEUBaUVvC53qLDo9tqGjcnNoghxJJo84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HDK8U+WSMYrV66qGGp5Hu+TUbs905sQ1nfDMQt2O97GOGNCx1fZXnoZOMoUtooJAInNG5BHIRQyqB8TMa6T7tRXwomNehFujxkC14RRPu/j8qnnhiOPyeoeGqKDsQkQ3vw50W+hivdnZF7KSasTYp7LaQ2RK/6pJV3xsvuB0V1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NM//dBSZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eh9XJRLU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 964ab568e67f11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BfHe+ARrnShqEUBaUVvC53qLDo9tqGjcnNoghxJJo84=;
	b=NM//dBSZGQOLqy/Kpu9Gea6X7oRmWj0MsVDTf2qFLIJI5Yr/TmJroGWtD+W3EGmiLgshpdMowxEergdjeqkqLqvLJjPMgebRGFVtF97+knM61/7P6uxlrhXd36siCQ9hkMMEKIWonFKnlDA04ul6Dpo7emvJ6wAehkiHAbPc0GA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a240cf97-2478-47ab-8add-f0cfb4b1957e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:5e999c90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 964ab568e67f11eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1728674234; Wed, 20 Mar 2024 14:03:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 14:03:33 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 14:03:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCwTlXSWQ2u02N8qnyOLjDpuk/3llCeEL7d4sLRjpW0676Q7HcN3ruGuqA05xrYd/7OlWEv93nqMdZX8xeyavC1BF7/lt1tao30qovFPlXqi2akqK42OgpmOAtyP1s9jwm70mZEXqmqSJKke4oKk8CcPwmsPwosDubPxKY75nY4MDz+DUbgTkPbl/GbsnWSvuMTBzFWLS9gKQSSpUbCVtGy/zcNecT3OsWC7Gas2rkKViTeDlgRtlUT4cP2DlWY2xkYfRFfAIbW8WCwuqsetgEvTSBVsIoHC8u8UB7IGGe28dFqNM5+P2k2xTtDBGPoPDo83swuBlI9QgCPbtJXD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfHe+ARrnShqEUBaUVvC53qLDo9tqGjcnNoghxJJo84=;
 b=JpjzlDc/KWyUMDokoTBk9aXbuwnCb/cucIpd2x4pX3qTBIPzBLCiddY7TNNlMht9pOQ7RZDQ1m5IvQRa2WWJzAtN4yC9jljq6iNLmSf3MvMAE01tqfwOsrkVaC65Jd7jnOvYSOelgPNFYVZluHrMuCg4ANTLZi/MQ+Td1X80NOxDnFbNOyuWhgClCJjotka4rKU91TnqGqNagrIr1NkZx12apK0AuK/712RJ9JizpvO7UCoxMqXhiLMyuEN4+cL+Fizq10Vn99BnymXZJvkrdr5LRYhegEEVfLzYgSL4c0prXqBB7CgHIcSZ7411zoT2a2LJgsUJ2GM9hgCFpIWg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfHe+ARrnShqEUBaUVvC53qLDo9tqGjcnNoghxJJo84=;
 b=eh9XJRLUDJK0oOHoJCw9JjoLqNAksd5FytjFFFj0mcDJnyM0+4uOfIyaQ/hMDXddVDn7fv7tFa37Etj1hD8zjOeKu4Yfl50jU4JmkxEJZdQ/qHiq+minsAD4aEKrl63shTTR3DIs2Id1BK/oYZh+I9u9PsiHps9UacSzuI0ENPg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7190.apcprd03.prod.outlook.com (2603:1096:101:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:03:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:03:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Topic: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Index: AQHadfPkOYxnhk7qmk2FGd0xEv068rFALL6A
Date: Wed, 20 Mar 2024 06:03:27 +0000
Message-ID: <2a0a4d12edfc92d40d5ae463f8a261e8799ddafa.camel@mediatek.com>
References: <20240314094238.3315-1-shuijing.li@mediatek.com>
In-Reply-To: <20240314094238.3315-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7190:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5gfaSaXmXTApT+1U1TVZEzwF2NJjU1kE7t72Q6O3hw+GUS2fPW9g9NeP15ZGEM/+Lhj2NRjcZewZWfmGuT7bWsYdK4TT3fFu+k828QJT7sHtEf3o1IMkVC3EHBgiqZgqqMPVsku2FPzHS2YEuEL2zFbNxLN/q11AJJPgJgakSEaIR4oVDAIJkOj9CWOYK1aEW24Jvc1LebZBDwOlaOuc97n0g10VGV28tCv3lLIDSuFt6Bgch6HYkF2ZsAzgFHMCCl9j2zrFRz83FV/z+wGMGaYnp3Oc5UYL3+pKJMYGgvvJe42y3G1mqTQcQbEKv/Tbp7Ij/8sHndIOXIniDxxokQYZBxaN9Wm4CSbi8IFru909RzDjdjvPqwSbk1FcPKiCwIFMxnrtvz7jOHQQ8TQpV6YFq+vjbewI4Np7xffWEJxPN1LLEc747ubuBJMeAK3pjzA7O9fEpWm4Bqd/QqffHApC+tYQa2geYZhvHiZJNHqw+wFfmXalYVUtsjxjAZbgRfzx2bbm/3XqdZQnLjhzlWslnpYARCsdgZinKlkCTowXEJ/nGEodBFJaYV3EN9pR4y3JopWd+peASVo2jEVfTT9cOhSrg4U0K2aZMFDRq+7Ptly3sf7wBV5cf97Ua/WDsuuCOybaUL6H2d3wEL1FxpgIKSa4f0b+s/K1qPZmQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2UycmhkQ3MyZzJIY2FxTWphSnVhN3huZGtmQTNzVzhScXNJck04Vm5pWWhK?=
 =?utf-8?B?SktWVlVVNjd0ZHJOQkYrWjlmazhOY1QyWXVoWXNqYWtNTSt4YUd0ejIreEpQ?=
 =?utf-8?B?amlrNy9EbUY0Y2N2KzVkZ3hzRi9uREhlYnVsMkluQ0NKLzEvczA1TnBQV2JV?=
 =?utf-8?B?eTFEczhualZ1NlJlc004WVJyUXo3YjBJQVBrT1FTcXVnOWxLZHNGbEF4QXhp?=
 =?utf-8?B?Wit1RkdKZG55WWwydWIwTVlDU3g1c3NGVHhQMkxJSkpEWVRRWUVMOU8ycjNN?=
 =?utf-8?B?bnZCR3E4Q0Q2T2h0b2dubHZ6d1B1b1JpQ0UwNG5RSFJBbzZNdUlCS0hOTWdQ?=
 =?utf-8?B?U3RFdUVwUFV3OTZoc1ZVUDdNWmFlQkdHZEhXSmQvRFJMVjR1RnhvVFBWU0t0?=
 =?utf-8?B?eFJ2eHhZQXZ0L3NaSkxpUGNLMkkwZlM0L2Z5Ry8xeVFOUDlDQnlEdm04clRw?=
 =?utf-8?B?MXA0L1NWQUYyVFlFcXhuYXh6bFhJWlZxSGRXNnBxUmRiekppL0I5NS82UU43?=
 =?utf-8?B?RjlCZDRhdm5sa2hxT3ordk5ySFlzVkVRcHhsemRCQlVIM21uMGtGODl0WS9H?=
 =?utf-8?B?YzlKd0g2ZTl0WlE5ZTJMcG1NbzU2Y0Z4L0xFQ1JkdGJHeFl6RGp5U0FMdmxI?=
 =?utf-8?B?KzlJL01GaXVuSW5EYXpLWkpGK3EwZGlzZEhyclloMUxVa296N0wzRWl4SnFt?=
 =?utf-8?B?NytuQ3N3Q2hLdW5EeDd5eHlWR3dmY05BbExCMUhrMG1ITCtPZUdPSlFkSFVh?=
 =?utf-8?B?WGFVaHBYODlJRUlMc3NJRFA3V2NDN2xXUEU2NkpWck1ONEVwZEtJTEpvdEN3?=
 =?utf-8?B?VklRc0lUZzdSWHNRM0FxTVFXNkEzTWlEWUVXTEtzMFQxT2hzaHNpQ09qdUdh?=
 =?utf-8?B?KzdZK0ZOQmpUUUFkbzQ2NjF3Z1QvMjhqNjBtYWN0S3VpRDFFOFhaRUlVZ1gz?=
 =?utf-8?B?ZUFoWDZnN1BqcDhVL3hzMnRBWlhQbFp3b0pneFhlSCtYejlONnI1N1Q4NEhU?=
 =?utf-8?B?QUJiWFJsZ2t6V0Z4UzEwZFJuOWJnS1kvUmdhZTF6bis4VUI3aHF3M1A1RnZQ?=
 =?utf-8?B?QUNxMURiUWhERTBaOXBNQTZQcS95OGZ4TUxjUGVNR2RqMFNJUFlsVGVUejB0?=
 =?utf-8?B?Z0ptMFFxZ3dXcnNVM0dpOW1mUVFlODZmZ3FFQjZYS1N6S3hydGx5S0xPUzh6?=
 =?utf-8?B?ZWl6TmdObjBWTkpBMzd4TXZkMGZKanZxdkFYSkZ4NVRjcnh6VDdFNnh6Vkp1?=
 =?utf-8?B?TWFTTDEwRTY4clpWZjlPUUFjc3VsMmh5MzZ2TkNyTmRSSEhqOTVUa2xFYVRy?=
 =?utf-8?B?c29jci8yRU14OFdYNFFoNjg4WEJSSWpoQStSWWhtYkl6b1BIaTRJaWtKRGZC?=
 =?utf-8?B?UDVIdGNuSm51MVI3N3dKd29VNVYxWjVCL2RUVFNMNGJHZ1BrbnMvNEo1eFlm?=
 =?utf-8?B?dHZHRjdodDR1QkJFVWpDR21xeXJVTy9uODIzbnd5L3cybjRiVWFVRjZKZjFh?=
 =?utf-8?B?dmZhSTZLMVdvcjczcVVFc3QvaGVxc2svNVlMU2V4OTZRVjJFRkZlRG1tMlZF?=
 =?utf-8?B?c0lKSUw1a3lsOWNhaEJoNFRtUlVSM0ovVjkvcEFIU2l2UnRBVDlXVlVCRzBx?=
 =?utf-8?B?L1NCSEh5cTVBNlc1ZGFJS2tZVWwwWjZzM2YwUEJMcHJCUWpVbmk0N0h0QkdI?=
 =?utf-8?B?V3VuN0Q4akV1cXJhaEd4cWF6VjI0bnRRcnhCQWo0NU12amdqWW1kd3Q1cThT?=
 =?utf-8?B?VHF2L2tPY01CeTBhdkEyRjdiQlh5QWtwZHl1eTZhMHAvMTF0UDN4MWN4eHc4?=
 =?utf-8?B?Qkt0aVd6TlBHVDhpZWlDU3EzcWQzeFdyQk5mZ0dkZkN1MUtZREhNVks4TzF3?=
 =?utf-8?B?ZUY1VGR2cFR0SGFsR3RvWjkyMEZORmpSbEp3cU1DaUlORmJQdE1zN3c5TTVR?=
 =?utf-8?B?bmJRcU0rVnVxUnNPK1BYaFF2ZC81UnNoUHNzV21qRE41cm1icTNHaHp6Wko1?=
 =?utf-8?B?T0NQeU5XT3VnTkRXNXQva1psTUVaaGg4dEs1ckM1bE03bEZra01QNjJXV2xK?=
 =?utf-8?B?ZWtKaDlJZ0U1MklWMDRIK0ZGeWcxendPUlRwQlJMZHRrOVlqQlozeWRET1Jj?=
 =?utf-8?Q?yuXuPB3Ctb8qBhuUHVdYFsW7X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2A7195949F06D40B6E2AE942A13BA50@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d35d0ba-eb2e-45bd-9f7e-08dc48a37620
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 06:03:27.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Is7Y0PAmzTIAvHtfY/hcB7G1nH2E8LW00W0PJVXjzE0lJ+EnJ5hSUd/ZBX3+B7DVaKMoy8nVNCs5f4cZl9c6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7190

SGksIFNodWlqaW5nOg0KDQpBZGQgJ2RybS8nIGluIHRoZSB0aXRsZS4NCg0KT24gVGh1LCAyMDI0
LTAzLTE0IGF0IDE3OjQxICswODAwLCBTaHVpamluZyBMaSB3cm90ZToNCj4gQWRkaW5nIHRoZSBw
ZXItZnJhbWUgbHAgZnVuY3Rpb24gb2YgbXQ4MTg4LCB3aGljaCBjYW4ga2VlcCBIRlAgaW4gSFMN
Cj4gYW5kDQo+IHJlZHVjZSB0aGUgdGltZSByZXF1aXJlZCBmb3IgZWFjaCBsaW5lIHRvIGVudGVy
IGFuZCBleGl0IGxvdyBwb3dlci4NCj4gUGVyIEZyYW1lIExQOg0KPiAgIHw8LS0tLS0tLS0tLU9u
ZSBBY3RpdmUgRnJhbWUtLS0tLS0tLT58DQo+IC0tX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18tLS0tX19fX19fX19fX19fX19fX19fXw0KPiAgIF5IU0ErSEJQXl5SR0JeXkhG
UF5eSFNBK0hCUF5eUkdCXl5IRlBeICAgIF5IU0ErSEJQXl5SR0JeXkhGUF4NCj4gDQo+IFBlciBM
aW5lIExQOg0KPiAgIHw8LS0tLS0tLS0tLS0tLS0tT25lIEFjdGl2ZSBGcmFtZS0tLS0tLS0tLS0t
PnwNCj4gLS1fX19fX19fX19fX19fXy0tX19fX19fX19fX19fX18tLV9fX19fX19fX19fX19fLS0t
LV9fX19fX19fX19fX19fDQo+ICAgXkhTQStIQlBeXlJHQl4gIF5IU0ErSEJQXl5SR0JeICBeSFNB
K0hCUF5eUkdCXiAgICBeSFNBK0hCUF5eUkdCXg0KDQpBcyBJIGtub3csIHNvbWUgbG93IHBvd2Vy
IG1vZGUgd291bGQgaGFzIHNvbWUgc2lkZSBlZmZlY3QuIEZvciBleGFtcGxlLA0KQ1BVIGR2ZnMg
d291bGQgbGV0IENQVSBydW4gaW4gbG93IGZyZXF1ZW5jeSB3aGVuIENQVSBpcyBpZGxlLCBidXQg
d2hlbg0KQ1BVIGlzIHN1ZGRlbmx5IGJ1c3ksIGl0IHdvdWxkIHRha2Ugc29tZSB0aW1lIHRvIGxl
dCBDUFUgZnJlcXVlbmN5DQpzcGVlZCB1cCBhbmQgbWF5IGNhdXNlIHNvbWUgcmVhbCB0aW1lIGlz
c3VlLiBEb2VzIHRoaXMgaGF2ZSBhbnkgc2lkZQ0KZWZmZWN0LiBJZiBzbywgcGxlYXNlIGRlc2Ny
aWJlIGl0Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlA
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMgfCAxMDANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rz
aS5jDQo+IGluZGV4IGEyZmRmYzhkZGIxNS4uZTZmNDgwN2M4NzExIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTgzLDYgKzgzLDcgQEANCj4gICNkZWZpbmUgRFNJ
X0hTQV9XQwkJMHg1MA0KPiAgI2RlZmluZSBEU0lfSEJQX1dDCQkweDU0DQo+ICAjZGVmaW5lIERT
SV9IRlBfV0MJCTB4NTgNCj4gKyNkZWZpbmUgRFNJX0JMTFBfV0MJCTB4NUMNCj4gIA0KPiAgI2Rl
ZmluZSBEU0lfQ01EUV9TSVpFCQkweDYwDQo+ICAjZGVmaW5lIENNRFFfU0laRQkJCTB4M2YNCj4g
QEAgLTE4MCw2ICsxODEsNyBAQCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSB7DQo+ICAJYm9v
bCBoYXNfc2hhZG93X2N0bDsNCj4gIAlib29sIGhhc19zaXplX2N0bDsNCj4gIAlib29sIGNtZHFf
bG9uZ19wYWNrZXRfY3RsOw0KPiArCWJvb2wgc3VwcG9ydF9wZXJfZnJhbWVfbHA7DQo+ICB9Ow0K
PiAgDQo+ICBzdHJ1Y3QgbXRrX2RzaSB7DQo+IEBAIC01MTYsNiArNTE4LDEwMyBAQCBzdGF0aWMg
dm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdA0KPiBtdGtfZHNpICpkc2kpDQo+
ICAJCQkodm0tPmhhY3RpdmUgKiBkc2lfdG1wX2J1Zl9icHAgKyAyKSAlIGRzaS0NCj4gPmxhbmVz
Ow0KPiAgCX0NCj4gIA0KPiArCWlmIChkc2ktPmRyaXZlcl9kYXRhLT5zdXBwb3J0X3Blcl9mcmFt
ZV9scCkgew0KPiArCQl1bnNpZ25lZCBpbnQgbHB4ID0gMCwgZGFfaHNfZXhpdCA9IDAsIGRhX2hz
X3ByZXAgPSAwLA0KPiBkYV9oc190cmFpbCA9IDA7DQo+ICsJCXVuc2lnbmVkIGludCBkYV9oc196
ZXJvID0gMCwgcHNfd2MgPSAwLCBoc192Yl9wc193YyA9DQo+IDA7DQoNCkl0J3Mgbm90IG5lY2Vz
c2FyeSB0byBpbml0aWFsaXplIHRvIHplcm8gYmVjYXVzZSB0aGVzZSB2YXJpYWJsZSB3b3VsZA0K
YmUgYXNzaWduZWQgdG8gb3RoZXIgdmFsdWUgbGF0ZXIuDQoNCj4gKwkJdTMyIGJsbHBfd2MsIGJs
bHBfZW4sIHZfYWN0aXZlX3JvdW5kdXAsIGhzdHhfY2tscF93YzsNCj4gKwkJdTMyIGhzdHhfY2ts
cF93Y19tYXgsIGhzdHhfY2tscF93Y19taW47DQo+ICsNCj4gKwkJZGFfaHNfdHJhaWwgPSAocmVh
ZGwoZHNpLT5yZWdzICsgRFNJX1BIWV9USU1FQ09OMCkgPj4NCj4gMjQpICYgMHhmZjsNCg0Kb3Bl
cmF0b3IgJz4+JyBoYXMgaGlnaGVyIHByaW9yaXR5IHRoYW4gb3BlcmF0b3IgJyYnLCBzbyBpdCdz
IG5vdA0KbmVjZXNzYXJ5IHRvIGFkZCAnKCknLg0KDQo+ICsJCWJsbHBfZW4gPSAocmVhZGwoZHNp
LT5yZWdzICsgRFNJX1RYUlhfQ1RSTCkgPj4gNykgJg0KPiAweDE7DQo+ICsJCWlmIChkc2ktPm1v
ZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVMU0UpIHsNCj4gKwkJCWhvcml6
b250YWxfc3luY19hY3RpdmVfYnl0ZSA9DQo+ICsJCQkJKHZtLT5oc3luY19sZW4gKiBkc2lfdG1w
X2J1Zl9icHAgLSAxMCk7DQoNCicoKScgaXMgcmVkdW5kYW50Lg0KDQo+ICsJCQlob3Jpem9udGFs
X2JhY2twb3JjaF9ieXRlID0NCj4gKwkJCQkodm0tPmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZf
YnBwIC0NCj4gMTApOw0KDQpkaXR0by4NCg0KPiArCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5
dGUgPQ0KPiArCQkJCSh2bS0+aGZyb250X3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0NCj4gMTIp
Ow0KDQpkaXR0by4NCg0KPiArDQo+ICsJCQlwc193YyA9IHJlYWRsKGRzaS0+cmVncyArIERTSV9Q
U0NUUkwpICYgMHg3ZmZmOw0KPiArCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgzMiArDQo+IGhvcml6
b250YWxfc3luY19hY3RpdmVfYnl0ZSArDQo+ICsJCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0
ZSArIHBzX3djICsNCj4gKwkJCQlob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSkgJSBkc2ktDQo+
ID5sYW5lczsNCj4gKwkJCWlmICh2X2FjdGl2ZV9yb3VuZHVwKQ0KPiArCQkJCWhvcml6b250YWxf
YmFja3BvcmNoX2J5dGUgPQ0KPiBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICsNCj4gKwkJCQkJ
ZHNpLT5sYW5lcyAtIHZfYWN0aXZlX3JvdW5kdXA7DQo+ICsJCQloc3R4X2NrbHBfd2NfbWluID0g
KERJVl9ST1VORF9VUCgoMTIgKyAyICsgNCArDQo+ICsJCQkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2
ZV9ieXRlKSwgZHNpLQ0KPiA+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiArCQkJCSogZHNp
LT5sYW5lcyAvIDYgLSAxOw0KPiArCQkJaHN0eF9ja2xwX3djX21heCA9IChESVZfUk9VTkRfVVAo
KDIwICsgNiArIDQgKw0KPiArCQkJCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSArDQo+IGhv
cml6b250YWxfYmFja3BvcmNoX2J5dGUgKw0KPiArCQkJCXBzX3djKSwgZHNpLT5sYW5lcykgKyBk
YV9oc190cmFpbCArIDEpDQo+ICogZHNpLT5sYW5lcyAvIDYgLSAxOw0KPiArCQl9IGVsc2Ugew0K
PiArCQkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0gdm0tPmhzeW5jX2xlbiAqDQo+IGRz
aV90bXBfYnVmX2JwcCAtIDQ7DQo+ICsNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUg
PSAodm0tPmhiYWNrX3BvcmNoICsNCj4gdm0tPmhzeW5jX2xlbikgKg0KPiArCQkJCWRzaV90bXBf
YnVmX2JwcCAtIDEwOw0KPiArCQkJaHN0eF9ja2xwX3djX21pbiA9IChESVZfUk9VTkRfVVAoNCwg
ZHNpLT5sYW5lcykgDQo+ICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiArCQkJCSogZHNpLT5sYW5lcyAv
IDYgLSAxOw0KPiArDQo+ICsJCQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYNCj4gTUlQSV9EU0lfTU9E
RV9WSURFT19CVVJTVCkgew0KPiArCQkJCXBzX3djID0gcmVhZGwoZHNpLT5yZWdzICsgRFNJX1BT
Q1RSTCkgJg0KPiAweDdmZmY7DQo+ICsJCQkJYmxscF93YyA9IHJlYWRsKGRzaS0+cmVncyArDQo+
IERTSV9CTExQX1dDKSAmIDB4ZmZmOw0KPiArCQkJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
ID0gKHZtLQ0KPiA+aGZyb250X3BvcmNoICoNCj4gKwkJCQkJZHNpX3RtcF9idWZfYnBwIC0gMTgp
Ow0KPiArDQo+ICsJCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgyOCArDQo+IGhvcml6b250YWxfYmFj
a3BvcmNoX2J5dGUgKyBwc193YyArDQo+ICsJCQkJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
ICsNCj4gYmxscF93YykgJSBkc2ktPmxhbmVzOw0KPiArCQkJCWlmICh2X2FjdGl2ZV9yb3VuZHVw
KQ0KPiArCQkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0NCj4gaG9yaXpvbnRhbF9iYWNr
cG9yY2hfYnl0ZSArDQo+ICsJCQkJCWRzaS0+bGFuZXMgLSB2X2FjdGl2ZV9yb3VuZHVwOw0KPiAr
CQkJCWlmIChibGxwX2VuKSB7DQo+ICsJCQkJCWhzdHhfY2tscF93Y19tYXggPQ0KPiAoRElWX1JP
VU5EX1VQKCgxNiArIDYgKyA0ICsNCj4gKwkJCQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5DQo+
IHRlICsgYmxscF93YyArIHBzX3djKSwNCj4gKwkJCQkJCWRzaS0+bGFuZXMpICsNCj4gZGFfaHNf
dHJhaWwgKyAxKSAqIGRzaS0+bGFuZXMgLyA2IC0gMTsNCj4gKwkJCQl9IGVsc2Ugew0KPiArCQkJ
CQloc3R4X2NrbHBfd2NfbWF4ID0NCj4gKERJVl9ST1VORF9VUCgoMTIgKyA0ICsgNCArDQo+ICsJ
CQkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieQ0KPiB0ZSArIGJsbHBfd2MgKyBwc193YyksDQo+
ICsJCQkJCQlkc2ktPmxhbmVzKSArDQo+IGRhX2hzX3RyYWlsICsgMSkgKiBkc2ktPmxhbmVzIC8g
NiAtIDE7DQo+ICsJCQkJfQ0KPiArCQkJfSBlbHNlIHsNCj4gKwkJCQlwc193YyA9IHJlYWRsKGRz
aS0+cmVncyArIERTSV9QU0NUUkwpICYNCj4gMHg3ZmZmOw0KPiArCQkJCWhvcml6b250YWxfZnJv
bnRwb3JjaF9ieXRlID0gKHZtLQ0KPiA+aGZyb250X3BvcmNoICoNCj4gKwkJCQkJZHNpX3RtcF9i
dWZfYnBwIC0gMTIpOw0KPiArDQo+ICsJCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgyMiArDQo+IGhv
cml6b250YWxfYmFja3BvcmNoX2J5dGUgKyBwc193YyArDQo+ICsJCQkJCWhvcml6b250YWxfZnJv
bnRwb3JjaF9ieXRlKSAlDQo+IGRzaS0+bGFuZXM7DQo+ICsJCQkJaWYgKHZfYWN0aXZlX3JvdW5k
dXApDQo+ICsJCQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPQ0KPiBob3Jpem9udGFsX2Jh
Y2twb3JjaF9ieXRlICsNCj4gKwkJCQkJZHNpLT5sYW5lcyAtIHZfYWN0aXZlX3JvdW5kdXA7DQo+
ICsNCj4gKwkJCQloc3R4X2NrbHBfd2NfbWF4ID0gKERJVl9ST1VORF9VUCgoMTIgKw0KPiA0ICsg
NCArDQo+ICsJCQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgKw0KPiBwc193YyksDQo+ICsJ
CQkJCWRzaS0+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiAqIGRzaS0+bGFuZXMgLyA2IC0g
MTsNCj4gKwkJCX0NCj4gKwkJfQ0KPiArCQloc3R4X2NrbHBfd2MgPSAocmVhZGwoZHNpLT5yZWdz
ICsgRFNJX0hTVFhfQ0tMX1dDKSA+Pg0KPiAyKSAmIDB4M2ZmZjsNCg0KSGFyZHdhcmUgcmVnaXN0
ZXIgaXMgc2V0IGFjY29yZGluZyB0byBzb2Z0d2FyZSB2YXJpYWJsZSwgc28geW91IGNvdWxkDQpn
ZXQgdGhpcyB2YWx1ZSBmcm9tIHNvZnR3YXJlIHZhcmlhYmxlLiBEU0lfSFNUWF9DS0xfV0MgaXMg
c2V0IGluDQptdGtfZHNpX3BzX2NvbnRyb2xfdmFjdCgpIGFzIHBzX3djLCBzbyB5b3UgY291bGQg
dXNlIHBzX3djIGluc3RlYWQgb2YNCnJlYWQgaXQgYmFjayBmcm9tIHJlZ2lzdGVyLg0KDQpSZWdh
cmRzLA0KQ0sNCg0KPiArCQlpZiAoaHN0eF9ja2xwX3djIDw9IGhzdHhfY2tscF93Y19taW4gfHwN
Cj4gKwkJCWhzdHhfY2tscF93YyA+PSBoc3R4X2NrbHBfd2NfbWF4KSB7DQo+ICsJCQloc3R4X2Nr
bHBfd2MgPSAoaHN0eF9ja2xwX3djX21heCAvIDIpIDw8IDI7DQo+ICsJCQl3cml0ZWwoaHN0eF9j
a2xwX3djLCBkc2ktPnJlZ3MgKw0KPiBEU0lfSFNUWF9DS0xfV0MpOw0KPiArCQl9DQo+ICsJCWhz
dHhfY2tscF93YyA9IGhzdHhfY2tscF93YyA+PiAyOw0KPiArCQlpZiAoaHN0eF9ja2xwX3djIDw9
IGhzdHhfY2tscF93Y19taW4gfHwNCj4gKwkJCWhzdHhfY2tscF93YyA+PSBoc3R4X2NrbHBfd2Nf
bWF4KSB7DQo+ICsJCQlEUk1fV0FSTigiV3Jvbmcgc2V0dGluZyBvZiBoc3R4X2NrbF93Y1xuIik7
DQo+ICsJCX0NCj4gKw0KPiArCQlscHggPSByZWFkbChkc2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVD
T04wKSAmIDB4ZmY7DQo+ICsJCWRhX2hzX2V4aXQgPSAocmVhZGwoZHNpLT5yZWdzICsgRFNJX1BI
WV9USU1FQ09OMSkgPj4NCj4gMjQpICYgMHhmZjsNCj4gKwkJZGFfaHNfcHJlcCA9IChyZWFkbChk
c2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVDT04wKSA+PiA4KQ0KPiAmIDB4ZmY7DQo+ICsJCWRhX2hz
X3plcm8gPSAocmVhZGwoZHNpLT5yZWdzICsgRFNJX1BIWV9USU1FQ09OMCkgPj4NCj4gMTYpICYg
MHhmZjsNCj4gKwkJcHNfd2MgPSByZWFkbChkc2ktPnJlZ3MgKyBEU0lfUFNDVFJMKSAmIDB4N2Zm
ZjsNCj4gKwkJaHNfdmJfcHNfd2MgPSBwc193YyAtDQo+ICsJCQkobHB4ICsgZGFfaHNfZXhpdCAr
IGRhX2hzX3ByZXAgKyBkYV9oc196ZXJvICsNCj4gMikNCj4gKwkJCSogZHNpLT5sYW5lczsNCj4g
KwkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPSAoMSA8PCAzMSkNCj4gKwkJCXwgKGhzX3Zi
X3BzX3djIDw8IDE2KQ0KPiArCQkJfCAoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUpOw0KPiAr
CX0NCj4gIAl3cml0ZWwoaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlLCBkc2ktPnJlZ3MgKyBE
U0lfSFNBX1dDKTsNCj4gIAl3cml0ZWwoaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSwgZHNpLT5y
ZWdzICsgRFNJX0hCUF9XQyk7DQo+ICAJd3JpdGVsKGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
LCBkc2ktPnJlZ3MgKyBEU0lfSEZQX1dDKTsNCj4gQEAgLTEyNDYsNiArMTM0NSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YQ0KPiBtdDgxODhfZHNpX2RyaXZlcl9k
YXRhID0gew0KPiAgCS5oYXNfc2hhZG93X2N0bCA9IHRydWUsDQo+ICAJLmhhc19zaXplX2N0bCA9
IHRydWUsDQo+ICAJLmNtZHFfbG9uZ19wYWNrZXRfY3RsID0gdHJ1ZSwNCj4gKwkuc3VwcG9ydF9w
ZXJfZnJhbWVfbHAgPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXRrX2RzaV9vZl9tYXRjaFtdID0gew0K

