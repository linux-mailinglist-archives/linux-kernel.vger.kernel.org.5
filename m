Return-Path: <linux-kernel+bounces-167462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3738BA9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAE91C20E63
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4914F13C;
	Fri,  3 May 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GZWCtlLF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="naCDcigG"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7241E493
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728541; cv=fail; b=NNVJ/YsX1pn0kuee1GRSrZs3s0emeJ9GAl2EeECAhumjOoLqComCo6mcBdIA/jmIsBFrQItYENs4ZW6jSNGqQTpVe+8PxSRtqxSH8x0JiMpMwesuHt7s7xrc/qdkR3rl6y7lcnS2EFabO2Xsw//g9Ros1AqYa1DbbwJ9PWEwZ44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728541; c=relaxed/simple;
	bh=qqHrgozgjGfd9AyIS+8x1gOetNdtGcm1msUE4M4dlLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njuq/7N1Mkw6ZQiwg+XMR+NH3UY++q9XpcCH+DtZB91bTyKuUGOh1JdCru+TckMzKBaJD1N8+DNirE0J1BlWliysySpP2J87I8jU9nZMOvlUD2B0WnciZzsBAHjWwU7Oqc1w7dKFsz7r8jh0ycJao4p4I9/yHDQPaS6ggrfPwxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GZWCtlLF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=naCDcigG; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8fe67888092f11ef8065b7b53f7091ad-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qqHrgozgjGfd9AyIS+8x1gOetNdtGcm1msUE4M4dlLw=;
	b=GZWCtlLFrCZb9RqOgB6sjmZe8ERiMZARIPNdmsgKMp4noChZtT6zOSGma1oAzR4IyhR8R+YPN+zaZncnJ0Lx+XmiyAThUZ1XpdAyFVgEXH4R3EURIU3fEhtsBBen0Gfzc53uMJqqGRxGH0lOOg2LwL/0bHzEG26UIVdV4ZLIc0k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c7282845-ea5d-45bd-bfe0-c55c4cf7a710,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:9aa3a5fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8fe67888092f11ef8065b7b53f7091ad-20240503
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1587064719; Fri, 03 May 2024 17:28:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 17:28:54 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 17:28:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guh8X8wCsfdbA3bHBRApdoFtUikqs9oIsHITSlbyA/BlVdYCj0Z6aYRYEf9Bgxc+BroBOdBAVubqC1j2IrEElfmc0XKQjTry0dNhUvegJh4QOY7VR/Oidysy6oWYBUvayQngkbk3LLf5FlSXFZYIk3m5+vXFJo/PP30uO6wb6n6TA1rHPzb7YLbjB1a7tzhgCuBCEGzWYI+CmRh4SeWmnPvp6xPbs66R9fBazWLuzEoiv2gWoE/PikDcnFh/W7SRX5JntVr6n8uA7ViEaaOhTsOiHavKe8QCH3zWAsU39FIdNxmuZXUMsEMxjBfkvrE5jgtRAC21xSZCAUbtJh+Aag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqHrgozgjGfd9AyIS+8x1gOetNdtGcm1msUE4M4dlLw=;
 b=gyDlEQd2G4utgWXsW83A/ME42JsRuTI4HS9wwcZRg/ipfC9ONBHLsDk6rYW5bwBbFCiAc4GV58aw93/koOeG7rPxQMk353aXE/w2vIyCBenAnjkrTOvG7/M/hkupuEXL79Fa1KnonlbZ092kPTr/gS7KNmNB8vlp7bvKhjoL3xF7A9lxL9iXde0LIU5MPeKuU8RG7cmA0Fblcra29bDy/xp7KxaSvXXEz6Nr6XylUSlDrEDFW0nDRB3LpYW83f2aufIpyasuoZLfeav0wB7u0MEDijU1RvG4ttj0DeicLMGNL5DqCwCZRsPESntxhMSVDPbwvtYPGJ+T57orZnMTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqHrgozgjGfd9AyIS+8x1gOetNdtGcm1msUE4M4dlLw=;
 b=naCDcigGMpWtx0kvSS4eFjXowtFd0XHkxy52SsCuc2qaZP0UZ74BVGmp8YmmxX5sTqqex9WLCIMM0XOyZJESN1CVuFPAyMhnugiGUqyaw5S/HKHgNYgb/0GgOrSITr1ibuHZk4mXnLBWqFlhj78FbaeLwWQroUyDG4PEqMfU6GA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8249.apcprd03.prod.outlook.com (2603:1096:405:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:28:52 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 09:28:52 +0000
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
Subject: Re: [PATCH v7 12/18] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Topic: [PATCH v7 12/18] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Index: AQHanH0LyMy6O7cZrEyCT0yDlFAQQLGFP6OA
Date: Fri, 3 May 2024 09:28:52 +0000
Message-ID: <86db6c04cf2e3873232c93f8c7d33814a1a42edd.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-13-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-13-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8249:EE_
x-ms-office365-filtering-correlation-id: 26c9b7aa-1966-491e-a614-08dc6b537225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RVpFb0MxL0tnNjVCZFBJZkw5Qm1GNThDQ0V1OUJwWk1KSjNSTEVZNFprbnZu?=
 =?utf-8?B?OWo1d1IrMGdRb3FuNS9jajJGNjgzTGgwNmNabGFjUEFxMC8yelBMVlRxLzIr?=
 =?utf-8?B?eHNOenB6V0tic04xUS9MQkw5NEllT1I3cVM4Y24xQUMvTHpIYUxsaHlOc1M2?=
 =?utf-8?B?NUVCMmxGajFCZXBRaWRDK0o1NFBWQnJVT1hPdnFPUlNWdGl4ZGpxVVJXU3dC?=
 =?utf-8?B?UUFsaVZlb1ljbXVzaUpTUDJ3SlZwaWFLTnBNZlk2OFJiQndoZUNQV25NN0R3?=
 =?utf-8?B?ZGpIRkpNQjJCVW8zUnZZS0sySDgxZjV1ZkVmUzJBSkx6QnlZOUdUQkNhZHlM?=
 =?utf-8?B?clZoaU1rS3FtZFZBaWNmMnBCcnRwMHk0aENUcGtIRjhUSmRRZG8xcStYc0hm?=
 =?utf-8?B?M3dWM2o0Yy8yOWtnN3VYcGFVQnNoVW9jNGxhNXZhemI0ekNoT1A4MHdiOHdt?=
 =?utf-8?B?MjQxVk9FKzk1UzNPZlduNEdkejRsd2t1ckpIdWJwT00vRjg0dFMraWloTlRw?=
 =?utf-8?B?QTB0cUtuYVFDVG56L2Z5Z2hqNjhBYWRnMlRjdThydEs2dGQ2cHVZNkx2RDFa?=
 =?utf-8?B?ZzJDN0o3SW9TbGJHRTY1T0REVTdCVnlCNmJVcnAzZFhRMWdkMW1mbG5nTnVo?=
 =?utf-8?B?NlVMek50L3NtZnVjRFY0M3hMY0xGMEt2UnBIdHdNWkVlbWF1NjZySTNaV1VU?=
 =?utf-8?B?WmRBUWJvUUJheFB5UElSRXI4T0FBQTk1TU4yVU5ONlFjd3dlTldEQzB5ZXlY?=
 =?utf-8?B?RmR0N3hQdjJJcmx3WnVFbDNaSHJRT3F0a0V4YXhIU2kwY1hQenlKQS9tY0I2?=
 =?utf-8?B?bWtzbmNUVVpMT0UxUE1mNFZocTYvYUpCY0hicTVZWEx6NGJ1cG9nUHJiamkv?=
 =?utf-8?B?NDQxMFlnZ0NoTE00N3p3ZnM3cUpualJEYmlFN0VsMDNXSkFZZWVmWFVuc0xN?=
 =?utf-8?B?eGJYT0xsT2RwNGdVODVzSk1LcWJmcGgrWTBFVEIzS24vb0FGQTBkcFJoWEVJ?=
 =?utf-8?B?NXdXQkxZRkp5Qi9XamRkeFJES2cxRDFsa1U2aFV0YjRLYzI0SG0zWUdYREtW?=
 =?utf-8?B?ZDZiMk5UdWtIbWZEYW9maDhIeDdFaUdicjZFZjJ4YXpUU29tdFRmdG9Yb3kw?=
 =?utf-8?B?MEc1WlNJNDNHK3haVWlYV2hiZThDc1VFVDVTTTViRXRIKzV4dVlHMDUwTHBZ?=
 =?utf-8?B?RVA1b1dsdktXazFUMmdXeXBhRlQwZnFMcjhiYUE2NStjNXFsZXFxaUxnZ05n?=
 =?utf-8?B?RTduengzM3RTaUR6ZGw4dUEwWTRDZzB3ajIxdHFkdzBVWGJaOXVSTjlVemRS?=
 =?utf-8?B?L3IxaGtWekw3bkl2SmVRQVIwR1duRzVGa0NkZDgzOTNaQ2tNUm8vcFhwZnF4?=
 =?utf-8?B?MlJtVXA0UmJqSFBlZHA5ZkMraUZ0N0R5VEVCT2I4QzRQb0V1dExxSkNFZFZy?=
 =?utf-8?B?blBBd0ZRY3F6eFBaTjBySkJHNU50dTZZNEZ2MnhmUWd0T1lRdFF5dnN4Rm8z?=
 =?utf-8?B?Q1FnUE8zNTRZQ0VVK2M4ODdzRllvdkltME9iMFQybGpRSGFtWGQ1em1pY3V3?=
 =?utf-8?B?QmtYQU9MaldkbWRHSWhKWXJYUzlPdDhURXhJN2lsWFNGeDRwd21xY25adXc3?=
 =?utf-8?B?SDhqaDRwSkh6OXo4c01DSVNINC92Mk5ld1ZVblhaeEFzTVduRzlUc3N6K25T?=
 =?utf-8?B?SSt1Y3IyT2lkbXp6U0Q5bU1oREx5aVZrdnVMdmlVNTF5R3Z6MjlSaGtqalFP?=
 =?utf-8?B?Tk9TZ2xlRUFWK2JOSGhwV05manlSZFA3ZG5yUjBYY0VMZUgwRW1pdEF5ZS8x?=
 =?utf-8?B?bXY5bXpwcHhZd0lXNWNvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9ndUNMbnZQNXlna2tzbkUxd0VCN29WZ2tXRGxaSVZMWi9heHcrN2VISE02?=
 =?utf-8?B?OWh2MG9LbEtwVzVKano0MTRrZENobG9wK0pqd1lycXJtcmE1QkpNZEFGY054?=
 =?utf-8?B?cCtGNFd6ZUhWK3psYkZiWGZhd1pmdk9rT2pWSk5jR1hTWTJ2aHBlSkZ4c3U4?=
 =?utf-8?B?YVdjbzg0UXN1VERCNGs5bHBYSVlXMEhKUUFkZUM5ckpqeTB3STBuZ3ZvRGdN?=
 =?utf-8?B?ejFwY25wTkNVN2RYemp2VlQ1K1J1ZG1DVXd1ODkrSm9jdFhGYWRGRGlyVjlP?=
 =?utf-8?B?Z0o2blJwOW1GUzh6YTJzdVVYR1VTR0luMjdQVSs5aUw0ZEVMVVJzKzZmUEdK?=
 =?utf-8?B?NW9PdjVxK0JObk0rNkZRbjJ2RzZrUGo3WjRHd3kvQU5KMlluYlN4SXpMS1dF?=
 =?utf-8?B?eGowUkRoVm1kZFY4SnoyRVFnTFBuUm1wU1N1ZEtFVzh0TWNvQS9Xc1dRdC83?=
 =?utf-8?B?MzVpTjNpYnBVOGZPTTlicE5jOGd3K1dVVDlHTWNQbVR1emV3U2JYN2oxcjFM?=
 =?utf-8?B?R1NmS2greENlZnBSbU80ZFBKdStvTlNqUFhCUTFnNU5CWHlSdWZVNGxQeExs?=
 =?utf-8?B?NEJkckNJbDU5aXhLZFNGTmV2SUNvVlEyQmtwK2lpcmlybHpzL1ZteHpzZklK?=
 =?utf-8?B?dE9kbVBYSzFRTHI0ZGpRbHgvT2wvTjVGU1JzbE5VM05SRk0xRUNSMUZCRHov?=
 =?utf-8?B?dVRSWUJORGpjWm9PUExJUlE1NUFOcmtrR3lXTklBUXQxMkJIK0RWNXZ4d1hl?=
 =?utf-8?B?RFppSUNIVlUycGpFa08xOEpxMEUrRWtJdGNiMXR1WllIcHRJMHIxcEpNNThO?=
 =?utf-8?B?bWt5UWJMNTIvWkRxTXc5emp6bEN2VjBhNGM0SjF0ZTJEUWFPaGd3TnlmYisr?=
 =?utf-8?B?L2V4WU5RSUh3ZzZPUk45YWFNTnljeXZnQ2l1UEYyeU1QQzEzNG5DWmlpenox?=
 =?utf-8?B?eTJka2RoQ01rRzJ4QU9FSXlvYjFOalZLOW1SVFljK0R3MlAwZktKaVRCQ2or?=
 =?utf-8?B?MjB5cVZyN2xrK0ZIMmphRTJzbU1jd1VFa1BMNEsvcTVaTmJqSE5UM0J3OTR3?=
 =?utf-8?B?TnowbDgxaDhqY3huUUZBYlZPMlVhVEVPTVc5MGNRaWtSOE9uUFlMSU5ZVllr?=
 =?utf-8?B?VldHV0lVa2NkOWJkL1pLQWF0MHU5amhaYUErSVU0dVVHdy9ZaHdVdkpmZjJp?=
 =?utf-8?B?RVVXaTVkbGhRN1BJOUo1VFZ3WW9TTGlYcFRNSkF5ZXR6d0J3eWVSRW5OY3M3?=
 =?utf-8?B?eUYwT2tZajJPWE9BMFNJWUtmb0lMZDF0eDV4Mm1OM3hnYzhRZGo3cjNDRDFO?=
 =?utf-8?B?SEVrckFEMS9Vb3BpS1hSZjBhUFBBWEYrVDAwRlZPNm5uZVpWUHJjd2tPTkxm?=
 =?utf-8?B?L3Rxcm9IZko1a2xraHpwcXJBV3pPanV3SndJdnRtOFBGdjdLTy9pbFhBZ2ZU?=
 =?utf-8?B?elVCZ09qQWMvdzlDNit6YWVMRFBxQnZKT3d6N0xSdUd3VUI2a3lENUJkQWhj?=
 =?utf-8?B?OHFFMzZDTktjOGFKU1BOS2ZCN0QxS09BSzhPSEJYMkNrNVZQbTU5YlpHMSts?=
 =?utf-8?B?bGJqcGg0eGtia0pXVFBiVmNLOSs0TmxHRXBPRUJBeGxOYm1RR1J1MzBBU0VC?=
 =?utf-8?B?ci93OHBFVy9LN2lrK0tIN21ES0VCYmxCd0haN01kWmJHNlE5bGxzeVFpUlVw?=
 =?utf-8?B?RlI3M3BwRkNwN3RRbmduSGtNVVRnNCtZQ3RtWjJXT2NuOTB6bGFkV0VIT2ZX?=
 =?utf-8?B?ek1HMjVBQ0dlV2d4MmpGUHRzQ1l4ZjdYa05lSWlab3ZNckdyM3V4cmR1RDhE?=
 =?utf-8?B?K3N3NnZzcU5xd21wTGgrQ3MxeXV6YzMwMkY3YkJ2TFJnV01haklZeXptd2JM?=
 =?utf-8?B?Qkc5dWxlQ3dlMXJBeTc2NkFxa0FLenBHUk03TUVwc0NBM0d0L1pEb05QRWRP?=
 =?utf-8?B?UnNJVGJoQjRBUFpJeTdOL2hCV2VIWHhrTkpYTTJZVTAwbXRtK295TzZCaHFi?=
 =?utf-8?B?aXFIUXVxZlpjOUtkZkc2azRMMTErMWVrMFRlYjhjMlJBMm5NeWVBWGxwdEZx?=
 =?utf-8?B?UTZ6WGtpLy9LTlEvNFg3ckxXYVpqbzZOazljNWl4Vys0L3lUamJsV0grRHhx?=
 =?utf-8?Q?yNvBnchu+rNJ3a+fR2qbxSpl7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D94B6609AB3EF74E999117C043D9F78D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c9b7aa-1966-491e-a614-08dc6b537225
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 09:28:52.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgqhOd+zfJsm/+TyHrGa3ZJVYf80X/njr5rzw3lVH0kH5f6NOurIubxtCly94SWMopN0cHsA5s+VOS/aZUi6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8249

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTg6MzggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
aW4gTWl4ZXIuDQo+IEJlZm9yZSB0aGlzIHBhdGNoLCBvbmx5IHRoZSBjb3ZlcmFnZSBtb2RlIGlz
IHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXdu
LnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZXRoZHIuYyB8IDE1ICsrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19ldGhkci5jDQo+IGluZGV4IDUyODNlMDk5M2VkNjUuLjRmMDQzYmUyMWVlMzYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gQEAgLTUsNiArNSw3IEBADQo+
ICANCj4gICNpbmNsdWRlIDxkcm0vZHJtX2ZvdXJjYy5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
ZnJhbWVidWZmZXIuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2JsZW5kLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gQEAgLTM1LDYgKzM2LDcgQEANCj4gICNkZWZpbmUgTUlYX1NS
Q19MMF9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX0NPTihuKQkJKDB4MjggKyAw
eDE4ICogKG4pKQ0KPiAgI2RlZmluZSBOT05fUFJFTVVMVElfU09VUkNFCQkJKDIgPDwgMTIpDQo+
ICsjZGVmaW5lIFBSRU1VTFRJX1NPVVJDRQkJCQkoMyA8PCAxMikNCj4gICNkZWZpbmUgTUlYX0xf
U1JDX1NJWkUobikJCSgweDMwICsgMHgxOCAqIChuKSkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX09G
RlNFVChuKQkJKDB4MzQgKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBNSVhfRlVOQ19EQ00wCQkJ
MHgxMjANCj4gQEAgLTE1Myw3ICsxNTUsNyBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCXN0cnVjdCBtdGtf
cGxhbmVfcGVuZGluZ19zdGF0ZSAqcGVuZGluZyA9ICZzdGF0ZS0+cGVuZGluZzsNCj4gIAl1bnNp
Z25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnggJiAxKSA8PCAzMSB8IHBlbmRpbmctPnkgPDwg
MTYNCj4gfCBwZW5kaW5nLT54Ow0KPiAgCXVuc2lnbmVkIGludCBhbGlnbl93aWR0aCA9IEFMSUdO
X0RPV04ocGVuZGluZy0+d2lkdGgsIDIpOw0KPiAtCXVuc2lnbmVkIGludCBhbHBoYV9jb24gPSAw
Ow0KPiArCXVuc2lnbmVkIGludCBtaXhfY29uID0gMDsNCj4gIAlib29sIHJlcGxhY2Vfc3JjX2Eg
PSBmYWxzZTsNCj4gIA0KPiAgCWRldl9kYmcoZGV2LCAiJXMrIGlkeDolZCIsIF9fZnVuY19fLCBp
ZHgpOw0KPiBAQCAtMTcxLDggKzE3MywxMiBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQlyZXR1cm47DQo+
ICAJfQ0KPiAgDQo+IC0JaWYgKHN0YXRlLT5iYXNlLmZiICYmIHN0YXRlLT5iYXNlLmZiLT5mb3Jt
YXQtPmhhc19hbHBoYSkNCj4gLQkJYWxwaGFfY29uID0gTUlYRVJfQUxQSEFfQUVOIHwgTUlYRVJf
QUxQSEE7DQo+ICsJbWl4X2NvbiB8PSBNSVhFUl9BTFBIQV9BRU4gfCAoc3RhdGUtPmJhc2UuYWxw
aGEgJiBNSVhFUl9BTFBIQSk7DQoNClRoaXMgbG9va3MgbGlrZSBwbGFuZSBhbHBoYSAodGhlIHdo
b2xlIHZpZGVvIHBsYW5lIHVzZSBzaW5nbGUgYWxwaGENCnZhbHVlKSwgbm90IHJlbGF0ZWQgdG8g
cHJlLW11bHRpcGxpZWQgYmxlbmRpbmcsIHNvIHNlcGFyYXRlIHRoaXMgdG8NCmFub3RoZXIgcGF0
Y2guDQoNCkZvciBubyBhbHBoYSBmb3JtYXQsIHlvdSBjaGFuZ2UgdGhlIHNldHRpbmcuIElmIHRo
aXMgaXMgYnVnIGZpeCwgYWRkDQpmaXhlcyB0YWcuDQoNCj4gKw0KPiArCWlmIChzdGF0ZS0+YmFz
ZS5waXhlbF9ibGVuZF9tb2RlICE9IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKQ0KPiArCQltaXhf
Y29uIHw9IFBSRU1VTFRJX1NPVVJDRTsNCj4gKwllbHNlDQo+ICsJCW1peF9jb24gfD0gTk9OX1BS
RU1VTFRJX1NPVVJDRTsNCj4gIA0KPiAgCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJh
c2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB7DQo+ICAJCS8qDQo+IEBAIC0xODksOCArMTk1LDcg
QEAgdm9pZCBtdGtfZXRoZHJfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdW5z
aWduZWQgaW50IGlkeCwNCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5kaW5nLT5oZWln
aHQgPDwgMTYgfCBhbGlnbl93aWR0aCwNCj4gJm1peGVyLT5jbWRxX2Jhc2UsDQo+ICAJCSAgICAg
IG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtfZGRwX3dyaXRlKGNt
ZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywgDQo+IE1JWF9M
X1NSQ19PRkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBhbHBo
YV9jb24sICZtaXhlci0+Y21kcV9iYXNlLA0KPiBtaXhlci0+cmVncywgTUlYX0xfU1JDX0NPTihp
ZHgpLA0KPiAtCQkJICAgMHgxZmYpOw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIG1peF9j
b24sICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0NCj4gPnJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4
KSk7DQo+ICAJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm1peGVyLT5j
bWRxX2Jhc2UsDQo+IG1peGVyLT5yZWdzLCBNSVhfU1JDX0NPTiwNCj4gIAkJCSAgIEJJVChpZHgp
KTsNCj4gIH0NCg==

