Return-Path: <linux-kernel+bounces-167267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C272A8BA6B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75EC1C21E80
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA4139CE0;
	Fri,  3 May 2024 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rx2Uq+qH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="u+Udmqtm"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B5224D0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714715150; cv=fail; b=s4wKHqhnmj49lBCX7sh57IILZsUMpRMDfzen3ZAs5EbWC3NncNsDLa6mBkGtzS9FwtcQaxHOxvOLoFlFMS4ZoBcLk7pmI3Gu+mXcD2GsSqDHN5RvXz/k/ZBu1QPLP+qk3CkUF/QRiDSrllJp8gHXJd7mi33J9Ox6M1sBczS3RQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714715150; c=relaxed/simple;
	bh=FcYq2mNuLn2ob4/jNBS9LtzL8h6dfH8nXwmy5fCbS5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouMKIirMwousFJDO6MuY9204SwQGv9KORrQTdWohYVEMSYJUm31b6oDwT6J5EB0qxR5Ay+ZZsdbaqYTZM14i7Iw4KigNPEUOR1DTDEbDpeyD0HxSn36T/2Cz5VAf2cwbPd0PAMwzggmbUDMqxYTGUG/nrEPNNcvx11TZI4Fhpj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rx2Uq+qH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=u+Udmqtm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5fa7ab98091011efb92737409a0e9459-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FcYq2mNuLn2ob4/jNBS9LtzL8h6dfH8nXwmy5fCbS5I=;
	b=rx2Uq+qHTVJNTR1aWyMGeEw1xr9OFnU0PlEjSTkhpcg2U4ckPTJdesjYSDyh5eyU7uKBp3wiUT0xY3n8u4SGXQ7PnwM2rLpPqW6WJSOnLfUNNieFEaMq41F9bf5bvlvRG1pJ3OiU9jkas6BX+qI6dKrX289LYsNLFwXD1et1CPA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:cb901f70-9644-4c7b-a38e-bc7ec7c92f7f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:91654d92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5fa7ab98091011efb92737409a0e9459-20240503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 347006167; Fri, 03 May 2024 13:45:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 13:45:38 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 13:45:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7CXpaYkgEM2DS0R8EixDKzZnPFfg/7WB6LY+5dcUiQN0ye6vBeTuL6WJd8wAIQoTgCrrvlk5G4aVc39RTcpOaNn//kdRH3CnNwY98b48Yiogy8ensXl8Et5UkM4xYYyw47XKl0ttk2DuJXrCk5rH6Kiqrfv2mLlcnBEyVVWZd48ki6+Xb2udDls1njAmFjvkzR2NHeWDzEhFYCLZ7zNyVmV0g/8wf7YmDuelZrrIGbGixuCdrG5xUlOlFqS2z/4MYqAVqrjmB/d6Aq81dVjM0kVu6wFwxc64wDBKD6xGYFm/eXG28ZtAHaNhF7izRStQ5kbEgsF+jNd3bJptaqpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcYq2mNuLn2ob4/jNBS9LtzL8h6dfH8nXwmy5fCbS5I=;
 b=FTFWSN0l4vl7KqbJ+LzU2NsQNLtC2q63muul2+O0B3PepixIIiZiUtcLgLCG8c5UZps8v/ODJ06ELc74j32aLQwZ7F1bFiWcQxIkEcWBF1egVM3/bAIrMxjj8N2WrngA3EmI3eLa2nY86SL4LBvPozpojQmKjexICuY/rmjezQsB9j49BhRHUrlrT5343GNyIRO1FxOddEzVe7t80VY3FBHFdVXTDn9lAydRsTzJyIHni1IYe73HpS32dJhPafweLZFe09oAXi2xz286LxqMHsCg4SQbJqsX2dUuewxIbcbvaJ8QSBauIgvrnhBsalIWiA08eop6E+RA2LaIR1y6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcYq2mNuLn2ob4/jNBS9LtzL8h6dfH8nXwmy5fCbS5I=;
 b=u+UdmqtmuS4bv6LQPsvuX0SJ61HMVg1yJHC/AXmnyAHRE56s1URUcb4o3YRye+RsIgMzikQz5PKHpJxNbfdv1lmPkV2ReOU31o3TP2G5Y5b+pehQXaRTRB0OWqywYiJLSs3/5lXHWaS18N5BrylYOF6liNPtRzNJsYzImsFLAyI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6663.apcprd03.prod.outlook.com (2603:1096:4:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 05:45:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 05:45:35 +0000
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
Subject: Re: [PATCH v7 10/18] drm/mediatek: Support constant blending in Mixer
Thread-Topic: [PATCH v7 10/18] drm/mediatek: Support constant blending in
 Mixer
Thread-Index: AQHanH0OIYpg0km0AkqAbGjgl+CENLGFAUEA
Date: Fri, 3 May 2024 05:45:35 +0000
Message-ID: <a9ea4f79d35b5d0495020261728282a97e9be6d9.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-11-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-11-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6663:EE_
x-ms-office365-filtering-correlation-id: 3b6bb56f-bb56-455f-594b-08dc6b344119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UzJMRlNFdWZ2YnRacWRGQ1VCeWc2ZVlkYVc3WlJXU0xFZ2pjeXorb09xK0N5?=
 =?utf-8?B?Ump4S1BieERma3lVcW9kNEw5RldpbmVwU1VncCtTSy9hUWJYYXNLODJWL1Nq?=
 =?utf-8?B?YVBIekc5WE1GMWp5UHdaczlwRWtycXdnSnBuY0NUSFhHVFcwOFZDQVNpQlJU?=
 =?utf-8?B?OUJpTUpVUDhNYTBQYlFhQmxrNWthMm1ZRlBhc28vV292OVVlYURMdk8xb1JE?=
 =?utf-8?B?YnFCN1M3R1JDNk1jaEdTZE54Z1dQOWRvN2RXQW1Eb0hGbFdPN29xcGRDVGdm?=
 =?utf-8?B?K1hWSXhQTGM1SDJIUWxJQ25GMGZ2T0tGQnN5S1pKL0cram40VVdaS0VVNU5R?=
 =?utf-8?B?a0Y0S3JBQThHRDBmZ1NDUE9tSFQ2dWJDazY1eFBJekxKMnJNM01lMElHRTEy?=
 =?utf-8?B?YzFLUWpXcDkyN0U2YlJnN0FkUk5HbUtXR3NzdHB6U0k4NlFXWnQ5TDBIMUZ2?=
 =?utf-8?B?NXREdDZPYTQ5SzF5bFhBR3VnWU1XYlNUU2E2WnNUZFo2MC84cWM4bVJPcGwr?=
 =?utf-8?B?T2hjZ3MrSGo3TzE4VkZ4bllRK0MyTWxTdzVtOVl4MVlobmYvLzRGUVlSaElT?=
 =?utf-8?B?Q2JBZkxZcit5UzRxYnVCVDJaTG41cGFxcTFJRTdxdWZ6NTFUSlcwYThBQ1B4?=
 =?utf-8?B?ZXBpdXFZNzJpL2hPbENXckZnSWFZUnp1Yjg0OUJlQm96SWhCbVMyTGdrc2dI?=
 =?utf-8?B?UkR3RUdVcjNMTlJnVW5DOEVobmpldlUwME94RjEvS0NwN1JiWGhRTXhHZVFs?=
 =?utf-8?B?OVpub3lhSHhDcGxKTU1tUkREMEhxWG5LOERHU1ljRmlGOEx0RW0yWXhIbnBM?=
 =?utf-8?B?Z1poZnROQy9HVFloRVk0RFRML0QrcFhFQVFiWk8yVWxWQkJ1a0hUdmhGTUpw?=
 =?utf-8?B?elRqc1NTNno5ek9pM09ObDM1Smd5VzFUMlc5TXRzZjNYa083cE1IMmc0aDVx?=
 =?utf-8?B?clJrTmFPM0V2UEpyVENETUlRNitPTzVka0puWUJuQTM0OU9YUjJLN3Zla1RC?=
 =?utf-8?B?OEhueVgvMDdYTmdYVEZscm1GMSs2ZWNVdjNYMGNKaXRXYTR1MGNlL2lKeXgw?=
 =?utf-8?B?OUZCbnQ3cStlRXo0YXY1cmFCck5uUDlpYVFEYzZvVWU1S0dYRHowWmhGUmpH?=
 =?utf-8?B?Q29ENlRFZVNyOUdpMkM1L3hNbythU2ZUMWpZS01sV3hHa0k3RWRJcDVjZHQw?=
 =?utf-8?B?a1NmeVQzRVQ5VFExcFJpVlhFUXczSXUrS2NUTXdkOTB1TDk5OVlWUm8yWFdz?=
 =?utf-8?B?V05ldmZnTWp5STVGZmY3dVFTVENRbWZQSDBhKy93REEwV1Z2N20zMFk4c2dM?=
 =?utf-8?B?UXVUUEIwMzE0ZWV5eDNVdGdvTytqVUg4YUtuUE4wMDBITW4vLzdhZmdBUzVx?=
 =?utf-8?B?bEU2M3U5MUpYSWpEWlZRYnVqT2Z5VE5sVVRGRUp4ZnpDZXNGMk1BY0ZEZi9j?=
 =?utf-8?B?OW54M3AzeU9qOTdKWC8rQW5kczJhTkcybDZuYjlCdmFEZ09pVTdMRythT0Zq?=
 =?utf-8?B?cEw1R1Y4VjVCbVdZOW11alVFY3JXaEJuaEV2S2h4RmlzdFlhTzRmY0owUmFL?=
 =?utf-8?B?ajBVUnNPUXFwa3Q1a216QTBsOEl5WE1ZMHlBcFJBY1lMZGdDZUZIZGhYV0Iw?=
 =?utf-8?B?R2haWEw0M2ZFc1B5NUhWc3pGd3dncWZoaGpDdWI3emJHbmlHdHJwV3BOVUQv?=
 =?utf-8?B?bHN4RHFMOVpNZVRxVGw4aHRXMUhmeHFaSXlZeGhmUVlJUUp4RFV5Y2VONzhE?=
 =?utf-8?B?OUxZcHk1NGtxVE81QnJZb1RQZ1YxN3N4S3A0RmFRdGQxQWhPNStPRWFtUTBz?=
 =?utf-8?B?am9oRXo3VjFuT1RjUEMwQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNWM2RSRjFGcTBOVE44MHk1THhUbFBmZnoweVliQVFkWkdWT0dGU0lLMVZu?=
 =?utf-8?B?N092cW8zNHRibFVUK2RudG85L2U1VzVZYVlvMGpibUV6akdvQUJBU25tdlQz?=
 =?utf-8?B?NDJRcUdkY0xTYWFycXFDQWZ3OXF0dzVZUTBXWFVORDM3c3dCYVlDclNIS3RI?=
 =?utf-8?B?VDFhMDhRWU0vMFNiTkNtTXhJOXBydEJadWJaWmhEOU4wQUw0SU5vRTRyTkhW?=
 =?utf-8?B?cjJjYjNoNzJnVVpsdWlGdVRDNTJ4UytPN3RtcDNLckxYeG1kTGZ3NVJMc1A1?=
 =?utf-8?B?dnZUeDJzMi95Tlo4cldoQzZuQjl3NWh0clY5amR4RW0zL0dVZUJKZ2pmcDFu?=
 =?utf-8?B?V1hvSVoyL2dDZHlBenlGbDNLNkZJZ1J2T1VuUC92dnBsNWVEN0k2L3E0Q05a?=
 =?utf-8?B?RnlHUC84SW1ldnpiYzRGa3VrUm9SWTJhQjNlK2RtOFI5ODQ2bS96alVvalVR?=
 =?utf-8?B?RUJjdlIwWmgrbFIxU3FZQW1QK1NraEtrM3JtQUcrUXd1V0J0MGlVY1F3eld3?=
 =?utf-8?B?eXY0QURJSldpSDBSVUtWeE1oaEs2WEFrUXpMY25lcXNjYUx4ZkVQUjNPcEZa?=
 =?utf-8?B?QjFOVDlWZ2Q5d1pQeFViTitJTXVFdTc5WndvSWYzKytZRGZubUE1aWFwc1g2?=
 =?utf-8?B?Mks4T0tsVzlsS3J3dnRqWHlYRW9rMHlrL0Q1L2pjZytjaGppMVhEYjY4VFRO?=
 =?utf-8?B?bUFDc0p0TjE4NzZPdk9yRlhBNnpVV0hnTndubi9iR3VWMldZbmRlanVESkJM?=
 =?utf-8?B?SXkzRjdPaUVYRm9nTnpjNXhtVnN6TTFubWlISWgrcjZ3YW9DQVE4ZXNHbzhq?=
 =?utf-8?B?TGR2N09TVjM2UW5aQzNZamZlL21KQ2JLN2N3d1lRc1VKYTVUcXUwSUtubjNo?=
 =?utf-8?B?YWhNMjZrMGJoV1VLMlh5RHBFRkx5U1ZnS25zTktLVVQ5dzEzQVcrZUMvTU84?=
 =?utf-8?B?dk5nYWlybzFPa3J1RWlLWTlvMFRlRFg5LzQ4L3d4TGo0YlNHRTk2Tm5Balcw?=
 =?utf-8?B?YW1OYnIzTDR6QVVFajdpWTQ3emdMZTJJNWZxUEcrNzJ3ei94VlZMbzhDZnF6?=
 =?utf-8?B?TlVVTS8xK2dJOTNta1FKWDRybXdjaGhlMXI4NHRrejVnK3M0bWR3WTVLc3c5?=
 =?utf-8?B?czlJbExFSmFJTzkvb1dBTjZqb1J3eG82MzJ4OHRaTDRKSHo3QTl6SytEbWRW?=
 =?utf-8?B?VEY4L3pzQ1dSeStwOHh4YkRCR0ZxZjMzUFhpMktBeUdRam4xN0lONWx2K3kv?=
 =?utf-8?B?M1VxaGM4NnpYWGNYRll5NGQ1OEZIWnNZQSsrcGtYdjRvd1dqK2w1TUZIYzAr?=
 =?utf-8?B?dy84SUhmdjFmblhDSHZYS3FKaVdRTGd6aHduNmJVNno1SGlRL2JBQkF5ZjAx?=
 =?utf-8?B?b2lWZlRCbFdJS1lUaDAwMWxOdnAranFoR2pTb3FoYzNGYTRFQ2UxeEVrcnJ1?=
 =?utf-8?B?Q3dJbGFMbVBkKzJrZjIvalJpelBNUmV3QWhzUng5RE5xUnFBbGVhNnBTTG9q?=
 =?utf-8?B?MkFLcDFOcVY1UFFWSGlUeVloTzNSa2xhUHVXaUN4dlpvUWZ6ZUpZeVlreDlm?=
 =?utf-8?B?Rk9Sb3NtTUNVZ3R1SFNMZ0VRY0MvdXJlaC9IbjRsMVVLMWJQQ2dMcmg0b0xU?=
 =?utf-8?B?cmNidGFJVG52Q2NqdUdvR0lJb1haQUEwUnk0NGtRSlBGd2NQc210bFdJQ1Z1?=
 =?utf-8?B?OU5VUWsxUWluTDYwRkZTMTIvSlkzQWJ6Y3RRMklUZU84d3pZbnJ5ZzczM1Er?=
 =?utf-8?B?YklTczNmRXJsSDZQM3pyRDJlY0ZRcUt6WWhQRm51bVVBUkplUTM5eVA0MDFw?=
 =?utf-8?B?SGtlVEUxbFVVcXVCeXZOaTBmOHF3Wm9FSVE2UlkwRkhjdzFKZ09JelhaRmFs?=
 =?utf-8?B?RnBpL0hRYm9VUmV6QTQ4cU1zejlRQkt0S0w3Qi8vOWRwWG51dThucWxZQjlY?=
 =?utf-8?B?amM5cFJWd0piNGNUQmJxSCt6SVR2MHJTcUYvWS82SDZXaE1CMUJrLzdGeFZQ?=
 =?utf-8?B?MDhVK0paQ3ZmUDA2YS9IWTRvQ0I2Y0NHdlMvMmwvYnFIU0M3L3Vyb2pBaklU?=
 =?utf-8?B?dk12MzNFYzZRRHphZEJuRnE0eXROSFNzOWlNUWVxVFFvWHZ3ZjhNaWtZeDhH?=
 =?utf-8?Q?LkDcKWiEdGjKPzEJPECynpNoc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF7033777E45C4DBB3456A0CE479E45@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6bb56f-bb56-455f-594b-08dc6b344119
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 05:45:35.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfbBsfitZ6kcu2DH14Hd3rHm8kksQo2kRq3CXRGvYd+NuVyp7aAXE3mk6dgkoTxInMUHv3y44UuIZQ3JrlXsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6663
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.634400-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsOwH4pD14DsPHkpkyUphL9X4GSJGyYc34PSotRL59FufKC
	81FnsF5IrUhQzMxACbphbsRjLV+pNp+BjDkC4XJT3y1ZMjVHx6kP4vBWNr0zgSS30GKAkBxW3MO
	EcRunIomDf9L0VsOPxjBOzX5DwsUoNGfbF3Cuxelor4yxPAz7WSGi0ftsSkQyqX2p24LQ06SjxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwVKUsrfRuHDJbcf8xC+jHlHSuQ
	YcxBvG7eBXlYVzNiKKTxCI/nmgusw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.634400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	17457150CF6E2F25DE2E1CA95DF786D983CFE232BC25E11C2BDDCE046BD8205F2000:8

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTg6MzggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCBjb25zdGFudCBibGVuZGluZyBpbiBNaXhlci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDEyICsrKysr
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhk
ci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IGluZGV4IDRm
ZmQwYTA2NDg2MTMuLjUyODNlMDk5M2VkNjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2V0aGRyLmMNCj4gQEAgLTE1NCw2ICsxNTQsNyBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9j
b25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCXVuc2ln
bmVkIGludCBvZmZzZXQgPSAocGVuZGluZy0+eCAmIDEpIDw8IDMxIHwgcGVuZGluZy0+eSA8PCAx
Ng0KPiB8IHBlbmRpbmctPng7DQo+ICAJdW5zaWduZWQgaW50IGFsaWduX3dpZHRoID0gQUxJR05f
RE9XTihwZW5kaW5nLT53aWR0aCwgMik7DQo+ICAJdW5zaWduZWQgaW50IGFscGhhX2NvbiA9IDA7
DQo+ICsJYm9vbCByZXBsYWNlX3NyY19hID0gZmFsc2U7DQo+ICANCj4gIAlkZXZfZGJnKGRldiwg
IiVzKyBpZHg6JWQiLCBfX2Z1bmNfXywgaWR4KTsNCj4gIA0KPiBAQCAtMTczLDggKzE3NCwxNSBA
QCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNp
Z25lZCBpbnQgaWR4LA0KPiAgCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+
Zm9ybWF0LT5oYXNfYWxwaGEpDQo+ICAJCWFscGhhX2NvbiA9IE1JWEVSX0FMUEhBX0FFTiB8IE1J
WEVSX0FMUEhBOw0KPiAgDQo+IC0JbXRrX21tc3lzX21peGVyX2luX2NvbmZpZyhwcml2LT5tbXN5
c19kZXYsIGlkeCArIDEsIGFscGhhX2NvbiA/DQo+IGZhbHNlIDogdHJ1ZSwNCj4gLQkJCQkgIERF
RkFVTFRfOUJJVF9BTFBIQSwNCj4gKwlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNl
LmZiLT5mb3JtYXQtPmhhc19hbHBoYSkgew0KPiArCQkvKg0KPiArCQkgKiBNaXhlciBkb2Vzbid0
IHN1cHBvcnQgQ09OU1RfQkxEIG1vZGUsDQo+ICsJCSAqIHVzZSBhIHRyaWNrIHRvIG1ha2UgdGhl
IG91dHB1dCBlcXVpdmFsZW50DQo+ICsJCSAqLw0KPiArCQlyZXBsYWNlX3NyY19hID0gdHJ1ZTsN
Cj4gKwl9DQo+ICsNCj4gKwltdGtfbW1zeXNfbWl4ZXJfaW5fY29uZmlnKHByaXYtPm1tc3lzX2Rl
diwgaWR4ICsgMSwNCj4gcmVwbGFjZV9zcmNfYSwgTUlYRVJfQUxQSEEsDQoNCkluIG9yaWdpbmFs
IGNvZGUsIG1peGVyIGFscmVhZHkgc3VwcG9ydCBjb25zdGFudCBibGVuZGluZy4gSWYgIXN0YXRl
LQ0KPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhLCBhbHBoYV9jb24gPSAwLCBhbmQgcGFyYW1l
dGVyIGFscGhhX3NlbCBpcw0Kc2V0IHRvIHRydWUuIFNvIHRoaXMgcGF0Y2ggZG9lcyBub3QgY2hh
bmdlIGFueSBiZWhhdmlvci4gRHJvcCB0aGlzDQpwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCj4g
IAkJCQkgIHBlbmRpbmctPnggJiAxID8NCj4gTUlYRVJfSU5YX01PREVfRVZFTl9FWFRFTkQgOg0K
PiAgCQkJCSAgTUlYRVJfSU5YX01PREVfQllQQVNTLCBhbGlnbl93aWR0aCAvDQo+IDIgLSAxLCBj
bWRxX3BrdCk7DQo+ICANCg==

