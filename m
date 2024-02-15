Return-Path: <linux-kernel+bounces-66504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31795855D93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05BD1F2E7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360C13FFF;
	Thu, 15 Feb 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c9NoxlS/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cAiL+muo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABE11183
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988543; cv=fail; b=f7ph4n0QUiuiS2oKsOCLZtVDtZEd01WbEsLqhmvdW945aNiL4LLzhxi3ilDYen4zUcWqkgpKUKfGZh3TWSPYSCNDKH4cRIrlhde9Ia88UFQ8ROtiKgbJgLEeRf9dH5rnwUmznWdwG91v+wKgJui3cGRifQtyecOGQjgSvlCPrrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988543; c=relaxed/simple;
	bh=EuwYmoSiKqlqN9XpPF6quWZa4cz96V8TKHu1d6dcvW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IeDZ8GuTSn72txW3SeNldkuAmnz7V3J/NiXpI/mMCCD3CxVgbTJ06GLAwKjMCkY8tR3cqoe8D52dyzvo2f1sgT2obSdfXF/YKScg76v/UVMTnyeqFl53PtQO73M+TT1rG8aYRAJKAtysEKKnHA3fIRwsyKCRj8XwYmRI0r01pxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c9NoxlS/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cAiL+muo; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c60019f4cbe211ee9e680517dc993faa-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EuwYmoSiKqlqN9XpPF6quWZa4cz96V8TKHu1d6dcvW4=;
	b=c9NoxlS/4HOL2AheJqpjvU9aIEs/LByL0HSoeZUD/8nJY9lM7aS5H+aWqcWYfrjQYqCFHme2/0kIOV4dimvnLKelksWPC70f6kFSKtwj6W/+K8poKDY1GJPoASo2ttL4pDMXHr+JJnZncQil74Eo0G1UdKc4TL54tnDJu0z7WQ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:71a594f1-f2ef-4ff5-ae3d-283b7c3f4c49,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:77f1ea83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c60019f4cbe211ee9e680517dc993faa-20240215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 237417267; Thu, 15 Feb 2024 17:15:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 17:15:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 17:15:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkNSAVKE0F8pzqEqjluAmbsZtySpAuJHf2+aQoS6KNLZ7bwu65XTl120rcysYGX9dz5MMojoqs3zh5Ng2OaBCqaPWeDtYNBMGoJFiNCZFGlh9Usmq2OIiOlal3SO7NEcRQdWIpZYI69sknYAn75DoCndi+YtxxOCqgesUPLPsrWQ4jNHzDX9bjghRL3aTsNYZ5Z6Uol4yhfNYvZVUgUhpMsnpQ3r5/crlSKpFqUyJSTLj8OwhuSoLlqOkz3UyVUDAtSHwzWtCL4X3e+bi8G/kJkVQarsBTE8y0+DUmHjgUVumWZ7FtV2LxCAb2/BTI3xOj7Xwlkb8vQb7ASmdwERow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuwYmoSiKqlqN9XpPF6quWZa4cz96V8TKHu1d6dcvW4=;
 b=cp5evlMVLLzBayRLlkoX73eLR4/bMCpbIMCeDXkOLtXecHVncVlmHKdqYgr6v9yK/k3+LOXFu/8WR5smhR7blNipgDWqJJGG+gtzOgqgapd1pb8VxXQJIxgWKF8RJHJh1AkF95SK2ve787aUzIjkiJL6UkNcPFEydMrWR3d8sNlXDLbhDEU9yxkViQbi9N9NKXLJwqTmMe+Z9qzgNEj2ME952GIgcsDUC6gItVRWhkIuEm6kwrzL9w5vQ/btzyDgWZslkDzSWEYPo+7+iy+2CRjHVW+V9grAdGh6+4po0VOa6L/PD5rb6t+HB1YbYaaG3TZYs0Xs94DXtErduisrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuwYmoSiKqlqN9XpPF6quWZa4cz96V8TKHu1d6dcvW4=;
 b=cAiL+muoJaRfnVLH5pV60cq3tWA24zFQcONv3G0EvTz9rysChmOVt+F+o7pDzLCaR97lSXdVzxKjsob+mbTdNN9x/YNV2WmcDypHI4HncyGWaeJPd2OzzqeaSnlionCcrXBQmDq5jDrSCOkwJKunzugNR8q8yZCBy2ZeKnwkliQ=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by TYUPR03MB7067.apcprd03.prod.outlook.com (2603:1096:400:35e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 09:15:29 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 09:15:29 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v6 6/9] drm/mediatek: dsi: Register DSI host after
 acquiring clocks and PHY
Thread-Topic: [PATCH v6 6/9] drm/mediatek: dsi: Register DSI host after
 acquiring clocks and PHY
Thread-Index: AQHaX+yaad8TYRDVwEGKk9enqKnClLELHy2A
Date: Thu, 15 Feb 2024 09:15:29 +0000
Message-ID: <c7cd73ffaa3a330cfce03a343c4ecc6c52936040.camel@mediatek.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
	 <20240215085316.56835-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215085316.56835-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|TYUPR03MB7067:EE_
x-ms-office365-filtering-correlation-id: 8bfc64ae-6d3e-41e5-88cc-08dc2e06a754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HY8GfxO83+0i2t8xOy1gd3kbjDABS3jhU4QG5Sqypn2eJBJU7SgypOXPZkfkMnCqNo/0eUL/0aN88HweO53qxNlhjaZlJNwCKUwlE5IJy01zFgoD4UNCcKhkmibdzl3H3ZJ4/QX4awTSdUaNLjDrHKaypVcYcWbv3/dljr2ScKNVDRmj9EF4PqggEuN23CqFQTWdVnkuB5OCCD9WH+exQuisPdXCmbSdtIBJvJZi9XedhcIrGVIV4d8hLYokAONYA1hszn7ua2BqUvbNufqXMXvBTc7s0DSaY+Alkf/nN1bDETz456hJDAKDA22R+RA+NkE7k2a+pP129MBLIdaholiMEqjvQ+FIEYrLnaXW75ij2qMXa9JKZ1CT9rV0JkD8nZF915C6eBp+CLHewQtN+DTFKYBMjGWBvuX/MHBO14+Xcea5gke3ybvUSVouNEwNURayA82MI+EavK7VCQsp/ceM6TG7FykRo8dhUn9HuUIj8RFdNd6ahjOtzysWSrTsoExFbnBJBOhhoqEpgTflsIsLtyEK8ALKZhxPmgxNv+NKtPYL34hRJD21FPmv9A/kB/b9JGFL14IgqUUufu5ltsEO5y7VwIIjV6r+yf+ELZUQ72vZDBFj+wtI48uVYqxH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(85182001)(86362001)(36756003)(122000001)(6506007)(316002)(6512007)(478600001)(6486002)(54906003)(83380400001)(2616005)(71200400001)(110136005)(26005)(41300700001)(38070700009)(38100700002)(4326008)(8936002)(2906002)(76116006)(64756008)(8676002)(66946007)(66476007)(66446008)(66556008)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNCY0Q0b0FUN1hQb1VTV3A2dXViWS9wcHZTQUpvK0EzTTE1Qmlab3U2THVC?=
 =?utf-8?B?S2hhNTZuL0paeFM0cEN2M2ozdG0wcVp6NnJNZGQvV0RFR0Y3dzNUY3NIUm5T?=
 =?utf-8?B?TTN2aS96RC8wdUg3Y1dLUm5CMWFraTAwNks4Z05oY1VOcGdMNXFxSGxGOHNz?=
 =?utf-8?B?Q1pSY01nNnJHU3daWkVhWjJwdEJYWllmajI2cGx4QllZejllOG04Z0hndlRG?=
 =?utf-8?B?VVlwb0J4bHFpbGF4OFN6cVV0ZEplVnJJWm12U2I2aUpUcEpsTWpUWStHVGNC?=
 =?utf-8?B?ZGN3aEdQdXU4OUltYjZZNkVYbGlwNFhUQS9zZmZpaHN2d1preGZSMVAxaWp2?=
 =?utf-8?B?Vkc2U21MclY4OGtud3BlTG9zamJCTldSSXhqb2J1bVJmSFJKZnRDbHZieUx2?=
 =?utf-8?B?Zkw0eWdzRVIrSDJjQXg2Ukw0MzBBSmcwVlVHbXc0UnJOaWhnY2tHTW84ZzBW?=
 =?utf-8?B?WlRqTzFzMGVQRm1ScGZpTHJzOHJySnBDdEo2U0E3QTBqZHdlUlBHbEtuK3kx?=
 =?utf-8?B?MFJlSktVdFRSSFZBSXl6L1NXMEFkUmRxMW9qQXZ6Tkk5YTc4RzNmZys1ZVpW?=
 =?utf-8?B?S0wrdFlaUWFEUG1Sdy9YWDAwS0trM0RPNXgweXZtbzA4LysyWHdPN3Qybkpw?=
 =?utf-8?B?K09ZTGFjVFBmd3czeVZFS0ZLMnl6cWtxc2hMcDAvTE9YdCtGNTNqZlZlbUJZ?=
 =?utf-8?B?N0F6UUVqc2MxRURBYWZXaWZIZk5BeGdPa0VXbGNESUdXSk9lNXZmNzhwSHVt?=
 =?utf-8?B?Szd3MWRRU3ZGWitjbXFqd2s1MHB4NDd1Zk9NaklqWS9KOVNJMUlySCswd2dB?=
 =?utf-8?B?MVNnUlFFR25XQ3BOWTNDc2Q3c1FNbElReUpaNURxQkltTytyS0VlTzI3cnpM?=
 =?utf-8?B?dytIZWhoZmdUZFBjQWlkdzMra3FraHgraHJFaFhWTzVEMDFITm1KMy82R0c3?=
 =?utf-8?B?eDVmaHRYdXJSUXp0NTRyU3E3WEFqam1VZTd2b2djczM3RlBBeklrYmJlSnRy?=
 =?utf-8?B?SjNCTGZnSEJSNWhDcHhpUXVkVlQrN3d4b2RIeTFPTWpybFIzNWxTdDNxeXp1?=
 =?utf-8?B?QThxUWFXTVZtNzBweDdZcVBoZHdna2liaitoUDZKQnQvdkoyczcra1NML2xJ?=
 =?utf-8?B?a2RzMmdSQzdhK1lBSDlJd0xQLy81cENyN3pHaWhMSG9zVnphU3ZjV0NJU1Nz?=
 =?utf-8?B?ZFJTZlhwWXcrYk4yK0ZEMGJSbDQ5ZyttSVdoK2Nhb0cydWdzZGVvb2paMFJQ?=
 =?utf-8?B?OXNXNVhOM1N4ZXB5cFhNWVBFTEF2NFkzc09ua2VFQmViM0hYc2cxWXU2NWgz?=
 =?utf-8?B?M0E1Z2daeUZWYXJQQndIRDVLVno2RUF3YkxRbjVrY3hvbkNhZ0xjbnVCYmdX?=
 =?utf-8?B?SmExZ284Z3NrVVczQ3ZpM2tNT3VXV1loeWFyUUU1RXRHMU1UVm8xSmYrYVlm?=
 =?utf-8?B?TWMxK1dZcU10dzgrVzBVV3pDUVRKZFQwd1NTZ2xQN2JTQUFnbFdIVzNjb05v?=
 =?utf-8?B?bEZTTCs5LzM2bG1ITnIrdm9rTUd3TGVJd3Vsd1NQd0NNQkcwWVRGTDhzRkdG?=
 =?utf-8?B?OXZrcGcyclpUZE5uMU9FVjA1ckVjRk13aksvVkIzREhXSXlhcU9UNk5pdk9T?=
 =?utf-8?B?K0ZmT1lPYTlaWmtVYTlMRW9yMDY0UkFpd2FGdTRLV1FNUnQzMVIyeFFVS2Jo?=
 =?utf-8?B?Q0ZYYm9uODJNTnJqYXEzUTRMQkd1K2MxM28rUlUxa1lXTmhIM1FJdVUrSVB5?=
 =?utf-8?B?bTAwSUgxT1phaTN3bTNQY1pjK05kbS95OUFGYkk3bG4rR2phWFdxQllQTE9O?=
 =?utf-8?B?c3dOdUpwSHFkUlh5MXBadWhzSGlKSFM5ZHk5S1pPaC9mTnozUTlORE9LZEZQ?=
 =?utf-8?B?WGF6Y2lEZmZOM1pMcmN2Ym8wVmVvak5iNjR6VGZ0Z21ibGRKdFZhUmJaeXc1?=
 =?utf-8?B?VGwxWWJEc2tZZWRzK2hVZTZrK2IvS1ZRclFKQW54aHQ4cXIydW84UUZacmVW?=
 =?utf-8?B?bTRWSVdTam9YaWZ3NVN1RFBmK1R3clJ5anhHMm1MWXhoVnFOS0ZyL2VZSWtY?=
 =?utf-8?B?QTZ4QzFuTUVZejVEakFndTN0TU52Qm92NEFzeWEvY2ZWd2pyTWxleXRXcDFp?=
 =?utf-8?Q?1wmvQ4yQUlIhZdw7DD2uOmm/v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0707BA2ED8080444B6977CE39F982BD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfc64ae-6d3e-41e5-88cc-08dc2e06a754
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 09:15:29.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMyYxjNTwzB+zaH7We3d8ZuObbjNTtfKvFvTf64HYb+xUCC5AhCkT7oDafNjB4S8XNA4HCp+/SIroqcYCeQWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7067
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.322000-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/ui6/VcDv9f0ED6z8N1m1ALjLOy13Cgb4+qvcIF1TcLYD9V
	M5r8hZnsIwSBRdrw5NTI1TUbyXhF1F/yzOBJu22CJdOcBmSEp+VfAXPuWnqbj+qboe8+VsZ/MuT
	wbaqEJZM11IkNRj0lERKqjdlR+seHkKjL2IOi2LAVglQa/gMvfEyNDX2PfTDJGFo8MdqTS3Ty0x
	Zu1XNaSKVrlKJzfBPQ64sVlliWKx9C/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07RRAJ
	C2k3BZ6kOMVSCRRmxWT3zx2+vqfPx66ZxJlFBIkCcpMehBl9xI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.322000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5C0F4E29B654C0B9E04AEBF1C23312CE48166AEDB6C4EBFF8470436C5C66213C2000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDA5OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gUmVnaXN0ZXJpbmcgdGhlIGRzaSBob3N0IHdp
dGggaXRzIG9wcyBiZWZvcmUgZ2V0dGluZyBkc2ktPnJlZ3MgaXMNCj4gc2ltcGx5IHdyb25nOiBl
dmVuIHRob3VnaCB0aGVyZSdzIG5vdGhpbmcgKGZvciBub3cpIGFzeW5jaHJvbm91c2x5DQo+IGNh
bGxpbmcgdGhvc2Ugb3BzIGJlZm9yZSB0aGUgZW5kIG9mIHRoZSBwcm9iZSBmdW5jdGlvbiwgaW5z
dGFsbGluZw0KPiBvcHMgdGhhdCBhcmUgdXNpbmcgaW9zcGFjZShzKSBhbmQgY2xvY2tzIGJlZm9y
ZSBldmVuIGluaXRpYWxpemluZw0KPiB0aG9zZSBpcyB0b28gZnJhZ2lsZS4NCj4gDQo+IFJlZ2lz
dGVyIHRoZSBEU0kgaG9zdCBhZnRlciBnZXR0aW5nIGNsb2NrcywgaW9zcGFjZSBhbmQgUEhZLg0K
PiBUaGlzIHdpbCBhbHNvIGFsbG93IHRvIHNpbXBsaWZ5IHRoZSBlcnJvciBwYXRocyBpbiBhIGxh
dGVyIGNvbW1pdC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGluZGV4IDUyNzU4Y2Fi
MGFiZi4uYjNkZDYyNTFkNjExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMN
Cj4gQEAgLTExMTQsMTQgKzExMTQsNiBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAoIWRzaSkNCj4gIAkJcmV0dXJuIC1F
Tk9NRU07DQo+ICANCj4gLQlkc2ktPmhvc3Qub3BzID0gJm10a19kc2lfb3BzOw0KPiAtCWRzaS0+
aG9zdC5kZXYgPSBkZXY7DQo+IC0JcmV0ID0gbWlwaV9kc2lfaG9zdF9yZWdpc3RlcigmZHNpLT5o
b3N0KTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBy
ZWdpc3RlciBEU0kgaG9zdDogJWRcbiIsIHJldCk7DQo+IC0JCXJldHVybiByZXQ7DQo+IC0JfQ0K
PiAtDQo+ICAJZHNpLT5kcml2ZXJfZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYp
Ow0KPiAgDQo+ICAJZHNpLT5lbmdpbmVfY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImVuZ2luZSIp
Ow0KPiBAQCAtMTEzMCw3ICsxMTIyLDcgQEAgc3RhdGljIGludCBtdGtfZHNpX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICANCj4gIAkJaWYgKHJldCAhPSAtRVBST0JF
X0RFRkVSKQ0KPiAgCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGVuZ2luZSBjbG9jazoN
Cj4gJWRcbiIsIHJldCk7DQo+IC0JCWdvdG8gZXJyX3VucmVnaXN0ZXJfaG9zdDsNCj4gKwkJcmV0
dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gIAlkc2ktPmRpZ2l0YWxfY2xrID0gZGV2bV9jbGtfZ2V0
KGRldiwgImRpZ2l0YWwiKTsNCj4gQEAgLTExMzksMTQgKzExMzEsMTQgQEAgc3RhdGljIGludCBt
dGtfZHNpX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAkJ
aWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiAgCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8g
Z2V0IGRpZ2l0YWwgY2xvY2s6DQo+ICVkXG4iLCByZXQpOw0KPiAtCQlnb3RvIGVycl91bnJlZ2lz
dGVyX2hvc3Q7DQo+ICsJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+ICAJZHNpLT5oc19jbGsg
PSBkZXZtX2Nsa19nZXQoZGV2LCAiaHMiKTsNCj4gIAlpZiAoSVNfRVJSKGRzaS0+aHNfY2xrKSkg
ew0KPiAgCQlyZXQgPSBQVFJfRVJSKGRzaS0+aHNfY2xrKTsNCj4gIAkJZGV2X2VycihkZXYsICJG
YWlsZWQgdG8gZ2V0IGhzIGNsb2NrOiAlZFxuIiwgcmV0KTsNCj4gLQkJZ290byBlcnJfdW5yZWdp
c3Rlcl9ob3N0Ow0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gIA0KPiAgCXJlZ3MgPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiBAQCAtMTE1NCwy
MCArMTE0NiwyOCBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIAlpZiAoSVNfRVJSKGRzaS0+cmVncykpIHsNCj4gIAkJcmV0ID0g
UFRSX0VSUihkc2ktPnJlZ3MpOw0KPiAgCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpb3JlbWFw
IG1lbW9yeTogJWRcbiIsIHJldCk7DQo+IC0JCWdvdG8gZXJyX3VucmVnaXN0ZXJfaG9zdDsNCj4g
KwkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gIAlkc2ktPnBoeSA9IGRldm1fcGh5X2dldChk
ZXYsICJkcGh5Iik7DQo+ICAJaWYgKElTX0VSUihkc2ktPnBoeSkpIHsNCj4gIAkJcmV0ID0gUFRS
X0VSUihkc2ktPnBoeSk7DQo+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBNSVBJLURQ
SFk6ICVkXG4iLCByZXQpOw0KPiAtCQlnb3RvIGVycl91bnJlZ2lzdGVyX2hvc3Q7DQo+ICsJCXJl
dHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+ICAJaXJxX251bSA9IHBsYXRmb3JtX2dldF9pcnEocGRl
diwgMCk7DQo+ICAJaWYgKGlycV9udW0gPCAwKSB7DQo+ICAJCXJldCA9IGlycV9udW07DQo+IC0J
CWdvdG8gZXJyX3VucmVnaXN0ZXJfaG9zdDsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwlkc2ktPmhvc3Qub3BzID0gJm10a19kc2lfb3BzOw0KPiArCWRzaS0+aG9zdC5kZXYgPSBk
ZXY7DQo+ICsJcmV0ID0gbWlwaV9kc2lfaG9zdF9yZWdpc3RlcigmZHNpLT5ob3N0KTsNCj4gKwlp
ZiAocmV0IDwgMCkgew0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byByZWdpc3RlciBEU0kg
aG9zdDogJWRcbiIsIHJldCk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0
ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnFfbnVtLCBtdGtfZHNpX2lycSwNCg==

