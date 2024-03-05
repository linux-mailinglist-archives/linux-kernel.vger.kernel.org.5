Return-Path: <linux-kernel+bounces-91611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B26871438
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B62845E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172229CFE;
	Tue,  5 Mar 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y6F5amT/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="n6bNR4Uf"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899F2F44
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609207; cv=fail; b=TyEQE563BMPDcOE48bG2dm3jebjSpcfBqEj/n87rgaCreOwTxNUjTG31vUBQWZZ7aEbHHQUNuHk8FVbdDMGuBy9hsumAZOT804mhjYU7lU55xj/Eofjit1Nn5rF2w/1gkixEvrtfgMptFMPhbIFqgJMrhM8KHfISAQIe0onPK+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609207; c=relaxed/simple;
	bh=uyH5qgaHMo93TIyJmc6Uuqv9P6S/5iFUicS69IcNXUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErNpEwZrNJtvriLpQme94VKujJy9DrQ0rneXtvVEtDZQkNiDcZqyQpV9l2UeGZ2yM23CNTYbnN2Q+vgdEoRVoYQWQQ4DZQcNfq28HZsyzawLq1veFf7+t4N4CQ75V/wQqBGKaqSc5gnxm+4mFrzLXnvGTYALeP039wfxSyFiTZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y6F5amT/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=n6bNR4Uf; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c03408edaa011eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uyH5qgaHMo93TIyJmc6Uuqv9P6S/5iFUicS69IcNXUM=;
	b=Y6F5amT/NYmzRwYPNS/AzmErq686MofyAuN9AV8M54/4VjTSNmjPLPWCKRsyxuGwJKrPjGmLaPXDy5WfQvsVpgx0FI03A3pm1PQ9R/fw/R3GbXxdPdwiRW+1KjiSxI+beBWUnFV7NhpNLh5ZqhgnvdzPXeCxCI1WbuZ9sj2aYtE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:16b7c132-669b-4567-859d-6bdb8155d706,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:16cb82ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c03408edaa011eeb8927bc1f75efef4-20240305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1808647169; Tue, 05 Mar 2024 11:26:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:26:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:26:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Daj/Kb1Tsx5xaIvgGQkn+MK4KSnW83NKFG9zCpBVd8mGUgv+SV2/cFXhhoiQfjQq6fe4+J3HkaMuXaMjKvFHqWmJpm5cxWNFPD5pb4ee2rkPGHYL9elmjCFWbqZ9fHiwgVT4bU0myBJhalUNbdLznfLr/O+oBsJptgaIirg2wDvubkuSNC3tiye0x6PvTO6bfiTgXU+O+uvRxwdjXo2NP3u6lJOb3UjKz94Hoi/QUvqVraBvhEVOlpRtam7jGEn9qb4n/NZzmXcr1S/WGXsBHHJx5FzRVQds6gR4w+iZAoVXj7i0pW1+jfm1CYEd8hAprxSgjvvZZTG2eOd/rwmaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyH5qgaHMo93TIyJmc6Uuqv9P6S/5iFUicS69IcNXUM=;
 b=cmyKY4Dyoi+klW76OteORtWWw/4DoJ5vKFkIBVyVYquuiRZvlDkC4muhmWkiLOBT6XbvqfdA9B/zqZUH0dWFT7Vg9xdOx3oWo+aHYVW1yRnu4WEKcmlxd+lNoh42nRGwLB+WKQKQ5irlcPAUFGk1d37D2xqCCjQGj2xNhR7dAnsBNCBR+u0l6tSbSQ47n/CSqRcoaLY9AgKdRr3P9npo+SkY1r17ZJafJyZHyvcH+CGEd4NKKwpJqLw2dnXrS155CnBueS0niTNHvMbgchm+v6Q6u/2RGi+v7uFIPC8qWpfQj29vfqwmTO2dQcXrNjJO6nMo80T6V0VqAjVoxCUqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyH5qgaHMo93TIyJmc6Uuqv9P6S/5iFUicS69IcNXUM=;
 b=n6bNR4UfgW//y7A6kXNu0B3RdSOO8khMv7kEN9yHDupvVk3z/wItZvTPtjwZF0wWvQc+7Lty/1s7hbhXMJ7EqzPtAKEdBhmUmy0S/9jEkAoOTxEVSxMRa8EeMFEAfHxbpgBR82bAvolZ0VtJEaZLb2480r8oZ2YQuoBN/VsMwJU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6620.apcprd03.prod.outlook.com (2603:1096:101:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 03:26:33 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:26:32 +0000
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
Subject: Re: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Topic: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Index: AQHaa+ccRvkxaECXsEmGlXDC8fIiUbEm65cAgADYBICAAL5tAA==
Date: Tue, 5 Mar 2024 03:26:32 +0000
Message-ID: <172e03d1f7bdb65c15e6a6ca5f52b3dd1929c7cc.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
	 <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
	 <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
In-Reply-To: <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6620:EE_
x-ms-office365-filtering-correlation-id: 63b70176-cb70-4071-58ac-08dc3cc40e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGM/a9T7dOB1UPLd7ACgR3oxNctV1xC/PaGEqk5NmOw1c621Jp0xwfvMEhs7bbBKQDwYJ64Aepoc6dMVps+6zxDB6vuTfB/MFG+a1SJQgCk0PbrUm3yQ4zW9HPiGDX1HNHzTI8mYs19cRSxMfuCGZxcHw/OE8Q/50yIuEES035MF4xRV4zQofE7oEyyo7d1HbyddDNTvbq7eXlJY0ZHcBsStv/HHTbX0GCBAufa2241wXi0YNjauYHb6IjyOQ3TazR7QRdOlvpiKjrwgmBdj0oVupG8uvUbUSJ5sSi713oXmBAFI03VgNq9kfaZ14F6JnutgQSJoehx3vzALyUk5L5ts7P4V8cGYC3sHFP44rPAqhEpyO2tdBwXaOgn9Cp9MeiaSuDgwRazNdtzSzbtFTifvrGRDr5LLwQxQorbl7xMdnjevjewKX5Dhrh4odIn2bT70FJw8qqW98Bseceifuvkwnod1nI0yZ+0aeJJaMKY4XuSTEpDWUbSxloqmBpvR8CA7hfCOMxzeS06JeDMRczDvQJs92WY525j9omC6ZI3rdfPNoFomH+Fh+ReT50sVNEysaN0GmUBOjQ62G9/i2Igxiy4Dsqv+nIhoAiZk42BFGJSxYeMoxdg7fGdbV/o4fQ+1AQwjuERI/AVo2D6Tfx6nIK7NhaLYgKYZMyeLVYIS7FLEd9HLBFgEwRv8jTo2j6w4DttgcS4ZxNIr+1kvlEGvJrmWAoqua9E8XuK+DgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm41MWppNDVwaXUraHRDc041cVRRZ2hJT2tIMlZVbEhCY3pJZS9oMGdFVk4r?=
 =?utf-8?B?bkVjSVFMNUV3RnlHb204cnRMRXRKZEJaaUpGclRCb0pTUE1JNFN4QUhsci8w?=
 =?utf-8?B?cnU3RGtXYjZDV2t6Tlpnbm9BZWVCMytSMG0yOHF5SGNPNjI1bjZ5eGVTeVNa?=
 =?utf-8?B?cklhOEN5b2IzTlNmdzVHZCswU1ZWNTJDZ3h4SjRaNzZ3TDcwM2NjcGU5TjZn?=
 =?utf-8?B?aEppMFdFSWFhajEwT0tlYXZZKzBJaVVGeGsxcnBGSXlvczdoYzlXUCtkWU9U?=
 =?utf-8?B?eklEbjN3SGhoVkpuNG9nOTk0QWxyU1AyNEFYOWdzaGJUQ0RmTDlrR1paSDdM?=
 =?utf-8?B?RDB1SXByRlo5anJ4eVJaelRFbWw5a0ZXcm5SYlBhWWovZ3l2RGVaVThOQWZz?=
 =?utf-8?B?UUVDVmV4K0xqNXphbktzbkpndm5TS3ppajgxcXVtU3hMTmVyYVQ4Z1p1WWly?=
 =?utf-8?B?ZGM3dHFOMllRWU5RTFJFZzVheUZIK0VScWN1VUkvUC95N051QndtZGpDczlq?=
 =?utf-8?B?a20zaGJ1R0xXb2JQcDFaUFkrZHJtOHkwZ1FKckMrRExlaWNac3RXKzFRS2Jx?=
 =?utf-8?B?VEFRQzNBNW9EMWRudjhPM1JWeGxYaktwbzdsdGZGSDRYbGJIanhhSTE2c0NG?=
 =?utf-8?B?cXd0UmZSK2tJSVRYbGpZdmc3RHJEMWtCRVkvNEZGUTNCR0NhckR1dXlyNGRv?=
 =?utf-8?B?a1lLZXk3SVI2QWNJcCtiN0NlV2NuWWtuVklHUGNEdmxlYnF3UjZnNWdpVEVW?=
 =?utf-8?B?WlBnanFwK0x1Z1V2YlRNSitVUlZKczZRenplb0x5Y09PU0pRYzk1anpPbWF1?=
 =?utf-8?B?Z05xaUI4enhJYTlBMnZlZ3VKalFOZE16bEltcitJY1BVbndRNFI5QVIrM0Vu?=
 =?utf-8?B?UzF2WWgwenFUSFZWcGovUXR4eHRiaTlnL3NmY3g5TEZTNGlDbzdPMmMvb3lU?=
 =?utf-8?B?M0NPZjFCTmNDWFZLam5HSHNqcTVnT24wbVVsRC8rN2s2OXBiNjVFbHVNdmk5?=
 =?utf-8?B?Y3J6UVAxdndUSmRWNGUyUzBuNVUyNEFPRnJsd1FNQk43N1VQVytqMUdVTCtF?=
 =?utf-8?B?RVkrSVpFYk1jVWhXUFJiU25QNVNJRmJ6T0xWbU0xeE5wTXpaWXhpNGNBbjd5?=
 =?utf-8?B?WmNlNER2cEIzcmhpU2hXUE9tdkFoNW1EVXc0cUxuOWVxRXZqUjc3V1Z3Yk0z?=
 =?utf-8?B?LzRHVjcySEpkK2lBTlV1NUpLQmlINGRpUm9nQVZiYXZJUUlQY2Y3NnZrNmxa?=
 =?utf-8?B?ZUNSTU1ObFVWZWJhanA1TUZEcFNWZXBqM1E4SFlLL3ExTEVIeWlWdTlWNG40?=
 =?utf-8?B?bXBxVnI4eVZhdTl1SXVUWWhlWDBoNlpIcnJCMG5yeGdEQURrckxROEFrNUxI?=
 =?utf-8?B?WGc1aXhJT0Vld2NEc2ZNNk0xQXlKS3hmdHh3OGJlcnAwd1U5TVFKaE5yUHRk?=
 =?utf-8?B?ZnJFbmpDR243WlYwVGJSaDc4RzFUU25BaHdqckVuSFliWTYzZGY5UjlvLzMv?=
 =?utf-8?B?dVZNRmREeFg3MGx2Z1JLNERaV01QN0lsM2hRME9rU1BObG9MRUVQWXl1UjJT?=
 =?utf-8?B?a25UcW1tVE5QNll2WFBvSWRpclQyVHFodFdJU1BuaHR6TXRpMVVXTERUbk9k?=
 =?utf-8?B?YjEvOTR1blFxQ2RGckJDOEhsNktneHUwYzBNSGNic3NXZ2FJQk9jT2QrSHIv?=
 =?utf-8?B?QTJLL2w5bGZVcHJZNXRQU2poUGRva2k2QUZ2eGVxZWxEa0VCSFRuZ2FHQWRa?=
 =?utf-8?B?UDRKdWgvK1ppcDJhRE8wc0oxOEVKNU1JREYvd1ZiY201NGJOUlN4QWo5elFt?=
 =?utf-8?B?aE85TjRnUzczdzZ1bXdzYUNaeS9HVkxNcXIreUYvZVFqUVNqYnlvaG9zMmhZ?=
 =?utf-8?B?bk5GQm9VRHR3MjZyTnVzVHVlaXBvWGVZK2pHaUVncU1WbTR2VDlVYUk4NnY1?=
 =?utf-8?B?clFBSit0RXNOQklTaTB2TncwOHkvT1A3WEpkQlg3QnJJZ1BTVktSME05R1cv?=
 =?utf-8?B?USttbUE1KzJYekRvWmVVTWtRMlZCRmVkZXBjRFU0c3E2N2pwcFdsTGFKSTVm?=
 =?utf-8?B?eU1lcnhxQkpaT3l4T1BRYWxOSTdWTGRHaWNGcUhqYzlnVFJ1WXdSNmVGMTZF?=
 =?utf-8?Q?F4iSS0Bnx1JVAM1s+INZ7hzrb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D924B5E36C6BC94C977FB4A59C376E9A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b70176-cb70-4071-58ac-08dc3cc40e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:26:32.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voc+6CDM87/DcZ2xJCJqnq9lN7ZzgCK9sj2cu7UP/6U5aIWr+3TPw1YBWQKsNM/USYYMWYKQ1mvGEuVxmgGU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6620

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMDMtMDQgYXQgMTY6MDQgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gSGkgQ0ssDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXdzLg0KPiANCj4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDAzOjExICswMDAwLCBDSyBIdSAo
6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFzb246DQo+ID4gDQo+ID4gT24gRnJpLCAyMDI0
LTAzLTAxIGF0IDIyOjQ0ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gPiBBZGQgY21k
cV9wa3RfcG9sbF9hZGRyIGZ1bmN0aW9uIHRvIHN1cHBvcnQgQ01EUSB1c2VyIG1ha2luZw0KPiA+
ID4gYW4gaW5zdHJ1Y3Rpb24gZm9yIHBvbGxpbmcgYSBzcGVjaWZpYyBhZGRyZXNzIG9mIGhhcmR3
YXJlIHJpZ3N0ZXINCj4gPiA+IHRvIGNoZWNrIHRoZSB2YWx1ZSB3aXRoIG9yIHdpdGhvdXQgbWFz
ay4NCj4gPiA+IA0KPiA+ID4gUE9MTCBpcyBhbiBvbGQgb3BlcmF0aW9uIGluIEdDRSwgc28gaXQg
ZG9lcyBub3Qgc3VwcG9ydCBTUFIgYW5kDQo+ID4gPiBDTURRX0NPREVfTE9HSUMuIENNRFEgdXNl
cnMgbmVlZCB0byB1c2UgR1BSIGFuZCBDTURRX0NPREVfTUFTSw0KPiA+ID4gdG8gbW92ZSBwb2xs
aW5nIHJlZ2lzdGVyIGFkZHJlc3MgdG8gR1BSIHRvIG1ha2UgYW4gaW5zdHJ1Y3Rpb24uDQo+ID4g
PiBUaGlzIHdpbGwgYmUgZG9uZSBpbiBjbWRxX3BrdF9wb2xsX2FkZHIoKS4NCj4gPiA+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAzOA0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDE2ICsrKysrKysrKysrDQo+ID4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gaW5kZXggM2ExZTQ3YWQ4
YTQxLi4yZTlmYzliYjExODMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCj4gPiA+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4gPiAgDQo+ID4gPiAg
I2RlZmluZSBDTURRX1dSSVRFX0VOQUJMRV9NQVNLCUJJVCgwKQ0KPiA+ID4gICNkZWZpbmUgQ01E
UV9QT0xMX0VOQUJMRV9NQVNLCUJJVCgwKQ0KPiA+ID4gKyNkZWZpbmUgQ01EUV9QT0xMX0hJR0hf
QUREUl9HUFIJKDE0KQ0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlcmUgYXJlIG11bHRpcGxlIEdQUiBh
bmQgeW91IHVzZSAjMTQgdG8gc3RvcmUgaGlnaCBhZGRyLg0KPiA+IEkNCj4gPiB3b3VsZCBsaWtl
IHlvdSB0byBsaXN0IGFsbCBHUFIgYW5kIGRvIG5vdCBsaW1pdCB0aGUgdXNhZ2Ugb2YgZWFjaA0K
PiA+IEdQUi4NCj4gPiBUaGUgcXVlc3Rpb24gaXMsIHdoeSBsaW1pdCAjMTQgdG8gYmUgaGlnaCBh
ZGRyPyBJZiB0aGUgR1BSIGlzDQo+ID4gc2hhcmVkDQo+ID4gYnkNCj4gPiBhbGwgdGhyZWFkcywg
dGhlcmUgc2hvdWxkIGJlIGEgbWVjaGFuaXNtIHRvIG1hbmFnZSBHUFIgdXNhZ2UgZm9yDQo+ID4g
Y2xpZW50DQo+ID4gZHJpdmVyIHRvIGFsbG9jYXRlL2ZyZWUgR1BSLg0KPiANCj4gWWVzLCB0aGVy
ZSBhcmUgMTYgR1BSLCBmcm9tIEdQUl9SMCB+IEdQUl9SMTUgYW5kIHRoZXkgYXJlIHNoYXJlZCBi
eQ0KPiBhbGwNCj4gdGhyZWFkcywgYnV0IEdQUl9SMCBhbmQgR1BSX1IxIGlzIHVzZWQgYnkgR0NF
IEhXIGl0c2VsZi4NCj4gDQo+IEkgdGhpbmsgdXNlciBtYXkgbm90IGtub3cgd2hpY2ggR1BSIGlz
IGF2YWlsYWJsZSwgc28gSSB0aGluayBDTURRDQo+IGRyaXZlciBzaG91bGQgbWFuYWdlIHRoZSB1
c2FnZSBvZiBHUFIgaW5zdGVhZCBvZiBjb25maWd1cmUgYnkgdGhlDQo+IHVzZXIuDQo+IA0KPiBD
dXJyZW50bHksIHdlIG9ubHkgdXNlIDEgZGVkaWNhdGVkIEdQUiBpbiBwb2xsLCBzbyBJIGRlZmlu
ZWQgaXQgaW4NCj4gQ01EUQ0KPiBkcml2ZXIgdG8gbWFrZSBpdCBzaW1wbGVyLg0KDQpJZiB0aHJl
YWQgMSBwb2xsIGFkZHIgQSBmaXJzdCwgR1BSIGlzIHNldCB0byBBLiBCdXQgcG9sbCB0aW1lIGV4
Y2VlZA0KR0NFX1RIRF9TTE9UX0NZQ0xFUywgY2hhbmdlIHRvIHRocmVhZCAyIGFuZCB0aHJlYWQg
MiBwb2xsIGFkZHIgQiwgR1BSDQppcyBzZXQgdG8gQi4gTGF0ZXIgc3dpdGNoIHRvIHRocmVhZCBB
IGFuZCBHQ0Ugd291bGQgZXhlY3V0ZSBwb2xsDQpjb21tYW5kIGFuZCBHUFIgaXMgQiwgc28gdGhy
ZWFkIDEgd291bGQgcG9sbCBhZGRyIEIsIGJ1dCB0aGlzIGlzIHdyb25nLg0KSG93IGRvIHlvdSBz
b2x2ZSB0aGlzIHByb2JsZW0/DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiA+IA0KPiA+ID4gICNk
ZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCj4gPiA+ICAjZGVmaW5lIENNRFFfUkVHX1RZ
UEUJCTENCj4gPiA+ICAjZGVmaW5lIENNRFFfSlVNUF9SRUxBVElWRQkxDQo+ID4gPiBAQCAtNDA2
LDYgKzQwNyw0MyBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LA0KPiA+ID4gdTgNCj4gPiA+IHN1YnN5cywNCj4gPiA+ICB9DQo+ID4gPiAgRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9wb2xsX21hc2spOw0KPiA+ID4gIA0KPiA+ID4gK2ludCBjbWRxX3BrdF9wb2xs
X2FkZHIoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkciwNCj4gPiA+IHUzMg0K
PiA+ID4gdmFsdWUsIHUzMiBtYXNrKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGNtZHFfaW5z
dHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gPiArCWludCBlcnI7DQo+ID4gPiArCXU4IHVz
ZV9tYXNrID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0KPiA+
ID4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiA+ID4gKwkJaW5zdC5tYXNrID0gfm1h
c2s7DQo+ID4gPiArCQllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0K
PiA+ID4gKwkJaWYgKGVyciAhPSAwKQ0KPiA+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gPiArCQl1
c2VfbWFzayA9IENNRFFfUE9MTF9FTkFCTEVfTUFTSzsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+
ID4gKwkvKg0KPiA+ID4gKwkgKiBQT0xMIGlzIGFuIG9sZCBvcGVyYXRpb24gaW4gR0NFIGFuZCBp
dCBkb2VzIG5vdCBzdXBwb3J0IFNQUg0KPiA+ID4gYW5kIENNRFFfQ09ERV9MT0dJQywNCj4gPiA+
ICsJICogc28gaXQgY2FuIG5vdCB1c2UgY21kcV9wa3RfYXNzaWduIHRvIGtlZXAgcG9sbGluZyBy
ZWdpc3Rlcg0KPiA+ID4gYWRkcmVzcyB0byBTUFIuDQo+ID4gPiArCSAqIEl0IG5lZWRzIHRvIHVz
ZSBHUFIgYW5kIENNRFFfQ09ERV9NQVNLIHRvIG1vdmUgcG9sbGluZw0KPiA+ID4gcmVnaXN0ZXIg
YWRkcmVzcyB0byBHUFIuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RF
X01BU0s7DQo+ID4gPiArCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiA+ID4gKwlpbnN0
LnNvcCA9IENNRFFfUE9MTF9ISUdIX0FERFJfR1BSOw0KPiA+ID4gKwlpbnN0Lm1hc2sgPSBhZGRy
Ow0KPiA+IA0KPiA+IFRoaXMgaXMgZnVsbCBhZGRyZXNzLCBub3QgaGlnaCBhZGRyZXNzLiBXaHkg
bmFtZSB0aGUgR1BSIHRvDQo+ID4gQ01EUV9QT0xMX0hJR0hfQUREUl9HUFI/DQo+ID4gDQo+IA0K
PiBNeSBtaXN0YWtlLCBJJ2xsIHJlbW92ZSB0aGF0ICdISUdIJyB3b3JkLg0KPiANCj4gPiBUaGUg
YWRkciBpcyBub3QgbWFzaywgc28gSSB3b3VsZCBsaWtlIGluc3QudmFsdWUgPSBhZGRyLg0KPiAN
Cj4gT0ssIEknbGwgY2hhbmdlIGl0Lg0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkguTGluDQo+
IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCg==

