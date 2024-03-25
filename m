Return-Path: <linux-kernel+bounces-116396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDCA889A56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F91C32F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9813DBB3;
	Mon, 25 Mar 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="quyOlke2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V/dTw8DM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361F13F42E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332210; cv=fail; b=E2cM2Iyn0TPL/GOZXtcXGXrda1ou/cSFNswng38QYhzSVnKWQdfDnpvpKfdPjXUumXepJ9Jg+HZ2oTUB/ll83WWgD1tOpUAqEZYGrpnj3HduBVVEn9Diap7ddMLK8f7ZpJMJKIGmc0VN7TGQXbOvdGkvzU0QPUXDbDq52mJNWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332210; c=relaxed/simple;
	bh=zRoWWTQIB1U1bmPuG0ebT0bMz8UcHCoeIcT7irzPr9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDlCoaMyMStoiWzKlRNDoLPH1UtmSMd7sieX8F0Dm8mQTRATdRhCJdvJVYPyIFVz0C6V0dEo2qC2PDB8yGUnAQwWo7R8IZPd6TM4v7mvEj97spyIAmsF+7YG+rgVMcKXwWNSGYEs+BrsryqqTApYmB4+vtPowh1jmWJzDN4WXK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=quyOlke2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=V/dTw8DM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d8ce58f2ea4b11eeb8927bc1f75efef4-20240325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zRoWWTQIB1U1bmPuG0ebT0bMz8UcHCoeIcT7irzPr9U=;
	b=quyOlke2QfjldQVAIM7515TPHlpF1loZhs3fpCn7RGws+muiXz3dG75DOwaH+jXE4PVTxc8F869bXK+dq9voLOxn55Sbhpf2gNkgaK1mMyav99oovPj+EdJE5qol9RwF3ND8JX7nQ5Yl+nRMyuCZLjMHlKuFqnMEoKjxHqvaIRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a768ae9a-dfa6-4a52-a146-174669de7de9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0b106185-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d8ce58f2ea4b11eeb8927bc1f75efef4-20240325
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 470950209; Mon, 25 Mar 2024 10:03:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Mar 2024 10:03:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Mar 2024 10:03:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnrHgPBT/4edwjBQYLalRDSRZQeY6Vi2Nl7FlUYtFLQ5WwWM1/nx8bNPSSF/A7ngPJJnbC3jMYiSws8+nINN1FYhci4X9OLiJToD68AGIBIekzHXWyAynU/9EAkzAhF+tqkbwjT+vU9X0NAdKLe5rjtJqoeiAYapvEOETAs4nt7gDaLCpKNaa99acCe0QpN+2b5e4mlPHBIgFlMxkOIDIX0FcYenp8QIXGZbNPQOki5yiYDf8Uf949Qj3jIf6i0wzhmwghfUZl5pA+IQWtDxJHth8YyiC45IxoaBXEf5Bcp0V6T7QSr1ni96+x5TTpTmj+JOO0PWOOumF0U4lqE73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRoWWTQIB1U1bmPuG0ebT0bMz8UcHCoeIcT7irzPr9U=;
 b=X36kQm9wVpvZNA2INz0HQht5hYMfAgrv1kC7nI49322PruV/Y2UWVvae3BI7UYDjsexGXahG93mYwEIz9tgQo6qiPTUD6B/yQZLyOeFVTUVhzgt4583Gx5NndYg6DcUN4mOWAOsExSEN0XV6nizhdDDQdRb/DVwgUoud02J0PH9z6AkdtKxnaO2REqA77d6Rxdfh/gH6JFtggefeVvtm+3TlYAbZsOPe2h0DAGjdK5JFYV8r0wc3nTurfQ8jP6j8apR4ULDmkz/huwdCDw//IMLd1gnBhA7nKew6uvXhCoeA8wsjFD0t/McBrKQv7LN4/DaUEnl4c790s1vVb5Gx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRoWWTQIB1U1bmPuG0ebT0bMz8UcHCoeIcT7irzPr9U=;
 b=V/dTw8DMXH9PP9Efp6jMM/HF0RX10JmBHGA6CoHzoiq34wnQKcrf+qhS+nXgnItU1xzzEA0Utm9xgC3cNsDWde8sMQ7iwzDAZlCc1axPKY91125Wi2H83qCcmNjck64wwDqmniJrIzjVsjaD4mmnRfRtatFih84lB6jwmJhxAsQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8692.apcprd03.prod.outlook.com (2603:1096:405:b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Mon, 25 Mar
 2024 02:03:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 02:03:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 11/14] drm/mediatek: Support "None" alpha blending in
 Mixer
Thread-Topic: [PATCH v6 11/14] drm/mediatek: Support "None" alpha blending in
 Mixer
Thread-Index: AQHafBnj8Hxb7Yje7E2W2D1oL9ORl7FHuPuA
Date: Mon, 25 Mar 2024 02:03:14 +0000
Message-ID: <3a427289f49b196d99934b9b4aaebeeebb13c628.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-12-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-12-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: avPHMG+T4QYxNS3zawYzAPS3VVJBw08DB0DhLIu+dTqzNp7gmUctOF+NN/CiugPxSrqYPBNB+DXaet8Zi8mLSAspbALxx/ymCC/33CuGm1JuTUvXJHSchecEy3uw/Y/69/L/hDaB+0MD1uYCx2VviuOwdBYO7xAYlOyISj5V+PWmDbjGefvl0KO1GUr3mbobonNzmpfHhhhFarpWKrywzvxRRKM0WyqntK6UKdbiCLBEGY3gl+qSllQU6m28n26T7SuUV6KDcXzWLfDSbqpq8k72H1fzV9BBuxYsZEP4wXspcHQbv/GQDwS3Dz8HiigNf7pMqD1vokKfNeyeMM8GWAiOW1/VmxRM9jlxrnLrNm743pNFSmqsuFzl8R9dopqmaBttbJSaJ2GUuAqv6eMPLSX/mhKAjKU5PIeNW8TrRsfzN/4rncCPkYqPkaDYH9WwmcWLwm/oRdvISl8Lp7rHYW0Tz5XRm9VVqfILZUliQ4u/kb3NAs6y3C6wwSyKNZp3T8yHMWG6I2ys3X9qZPgKO3sAz62+IPTUuQT4JxO6881qFn1Hg91PVYqs/Mb0tUmw/JxkJlJFvd9QCSyz9t/yERmYxOCvoaPLt9qctvzwdQcQxzk8q5JZ5+aHrEW0r43hBhGOAy9GbtezqKSJjecgQn4vf2Kx5NhPicmktymoN2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJJK3RGNWdNR1Y2NVdYZm5LK3k3a3FBVml2dm40aEplOUpiZFlDRG5pcmxh?=
 =?utf-8?B?V3EreG5KMStqVXZpZ1dlcVA4eCtWZkd1dWl6aEsxQVJ4Yi9HOHlFdWNyYWJx?=
 =?utf-8?B?RjU5ZWp3Y3JZVXhvbTZiVGRzWlNIRVVBNi9FbnVkeVBWSjc0VXdZTXJ1d3ZL?=
 =?utf-8?B?clgvZ1J0TURhWm02OEpsWW8rdWRacjlRQklNeURjNjVuY3NCRGJRRlRhajBj?=
 =?utf-8?B?ZDVjZW12RW10NnBscitST3lVaWI3aUFkaXFPaEdkTHgzbklOdE92UllmUEQv?=
 =?utf-8?B?YVVNTDQ1WkFMYlNyUTlVL2M0SE9TakR4Q3VSTjI0Wk90RkdPY2tlNUR0UmJH?=
 =?utf-8?B?VXFrQlFuZVUyY2JxQlBUNTJ4dHpWTEVSdTBZa1RVR0dlK1ZBUyt5RWNnRnVX?=
 =?utf-8?B?dmZvZzlnUGJHcFdYM05vTHBCV1lzMlBYSTA0QjA4dFBqTnNOcGQ4S0VIZjFK?=
 =?utf-8?B?d0lLcS9icUtNeEJuUXlweURXaEJkbURYM0RWazdGWTJWaVhPSngvVkdYdFJr?=
 =?utf-8?B?TUluRXpYN1JLdEUrN1YvS2ZEVnJPbEFtam1EbmgyaCt6eHJ3NVhrbUZwOENz?=
 =?utf-8?B?akg4dEppeWRHa0Q5bXRZaVFSTHhDK3lrY2p5c2MvYWt2Yzd6NUxrR2pwa1No?=
 =?utf-8?B?ZHFOU0hmMkdSeGhBRjI2Qnd3aXZabW53WW0reVp5cmxFR2JBYUIxcW9MSG5Q?=
 =?utf-8?B?Nnh5dDYzTmt5VGFDd2wwbWh5RVpuTVdMdFBqOU1tYjlyTVpBTUlwK0x3ei85?=
 =?utf-8?B?WHN1NEdZanZZaHEybDJNdVVRUDR4ZWVKVTFVbjY3RlpMZzJDNlBrbE1RZ1h0?=
 =?utf-8?B?SFNBRnJncmJyS0YrREMvUndQN1YxaWhxQjNCZk1XbHBKM2RHVDg1Nm8wZ25r?=
 =?utf-8?B?ZjMvRlJ2MUZtbWRmMTN6RVRabW5zeUhHM09aM0lIVDduVlFFVjBSTnZlRlpJ?=
 =?utf-8?B?MWN5Q2JxZXhhVEpHdVVQSE10bSs3bVQwM05MNnFPTGV5azVtakZCcmxUOE1T?=
 =?utf-8?B?Z0REb3k1aEc2WWdKTmhCd1NKRndzalduMlBBWkVCTFF5YXVoelJBNHdKM2Iv?=
 =?utf-8?B?SHRhVTFUc2xEY0wyUG1JcUVJT252YjF0cEEvV25DTVZ4UCs0dklUZEIvelFO?=
 =?utf-8?B?VDI0Vi9CeDFiSS9qSGFacituVTRpdWNxcmVwcHdFS2Y5dVpKb3J4Vm5RVG9N?=
 =?utf-8?B?UTRaUzlNQnRWeVVkeFg4TVpwV0QxQWJJL0JDaTJXRHpjalRhaElkNTlsMXBl?=
 =?utf-8?B?SkVsQWVCdlNpWlFNaGltZmx2azlXN3E5UXJZbFdyK0V2N2lMSTl2dVZKMkU3?=
 =?utf-8?B?R09sLzBmUndUQytZNU96TDlydmtuMTRWVVlmSkd6ZGxiNTY5Sy9leTdFWTYy?=
 =?utf-8?B?MUVZdEREWXpuc3R3dG42bmFmcGNPRFNCV1VFVUZremI0WEM4VytaZnhpZVQ4?=
 =?utf-8?B?QTBYTEJyOVJYUjFEVlNMZzBjdHlxT05qVFdYL3pLYVFuMmVTaWJmQmFFSXpR?=
 =?utf-8?B?cmhYbVBhOXBwVVdBUVk5RjJTZ2pTTVQ2SHRiTTg0YzlBUEQ0VThDSS9rVEQ0?=
 =?utf-8?B?a2NscS9taDZlNFdBNGFxN1RTeU4xRzJkem1QQmh0bHlQeW92ZlJMcnc5cEtD?=
 =?utf-8?B?cXVjWjRWdGhnenM4UkRYbk1uSU9QN0M5eHF1RklpVkxhYUxmb0ZSRmJaeTRw?=
 =?utf-8?B?Mit1TXdad2U5b1dkZms3eUhLV0pUeVJvZERaWS9oOWtZdWtBak1KWmxCdnIz?=
 =?utf-8?B?MExwOGZ3SzBHMlZDVVhGNHIxZ2FBempROTVGakJQMUo5TmpYekRsU2twNUll?=
 =?utf-8?B?NWNoRWk5SFZ1cHNuQ0I2M2xlWVlNdDhxWHkwemZ4cUxsNlF3M3FRbERUOUMr?=
 =?utf-8?B?ZjluNVVXSkUyTGkyeGN4U05ndnBHcXZpMEhINTJlK3l5Yk54UmRxa0dkTzda?=
 =?utf-8?B?TE45U25zSkR6Wm5iQk0vcVNXbnpkSVhiLzZKSkg2ajQyUzVDeGE5WWsvWGFq?=
 =?utf-8?B?ZHhNM0RFSTc5UnNLc3VzN1Z3WDFXOGZZcFRaTTBIc3pOdTYvWGtyazRkajNR?=
 =?utf-8?B?VkZCWkZ6RnRuTjJzTktJZW5WUXlBdU5VdTlBck1CYjlwTGlMZXZXbXhISmpP?=
 =?utf-8?Q?6k06PeJYS1RAii4hL0XU9FZye?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A7C29AB50D8F34ABE14D016F68C2750@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762167d5-2dbd-4c3c-5daa-08dc4c6fbb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 02:03:14.4493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b8mtrvry54QoFeaB78mxsQr6o2e1mdLpJrV3glL9+SfufuRIUO0FQZrydn0aIOVHsTrIKIL3Lj+wqH3FWawEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8692
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.159900-8.000000
X-TMASE-MatchedRID: 9zTThWtzImsOwH4pD14DsPHkpkyUphL9X4GSJGyYc34J5zM3dzkaQbJn
	Ph8w+R5oxpWxmut0txol6rr8933abhAq4jU0QZlBlGudLLtRO1sTc3GwbO2sy8IlE5O+zrEPvFf
	PytWHA2khXi7xgp14q/Osv2OU4IcBAaUyBbEosi3LtNJZxvPj1iwJzaIVMjGtoN1ZeaPfSbijxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDw8Dy8CAJHnrPMYPo0JT4AAG9dD
	nroCnwFHACU242+KRPXzjodmILeSA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.159900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EF5D42849781C4497F30BA8A816A8ED2F87E0C7F7E89B3DF6843B42C689E7C1E2000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiTm9uZSIgYmxlbmQgbW9kZSBvbiBNZWRpYVRlaydzIGNoaXBz
Lg0KPiANCj4gUGxlYXNlIHJlZmVyIHRvIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgY29tbWl0DQo+
ICJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgYWxwaGEgYmxlbmRpbmcgaW4gZGlzcGxheSBkcml2ZXIi
DQo+IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KDQpCdXQgSSB3b3VsZCBsaWtlIHlvdSB0byBkZXNj
cmliZSB0aGUgaW5mb3JtYXRpb24gaW4gdGhpcyBwYXRjaCBpbnN0ZWFkDQpvZiByZWZlcnJpbmcg
dG8gYW5vdGhlciBwYXRjaC4gVGhpcyBwYXRjaCBjb3VsZCBkZXNjcmliZSBtb3JlIGRldGFpbCwN
CmFuZCB0aGUgaW50ZWdyYXRpb24gcGF0Y2ggY291bGQgZGVzY3JpYmUgbW9yZSBicmllZi4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNo
YXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZXRoZHIuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19ldGhkci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5j
DQo+IGluZGV4IDRiMTJjYTI4NWU4NGIuLjk1MWUzZTgyYTZhMWEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gQEAgLTE3OCw3ICsxNzgsOCBAQCB2b2lkIG10a19l
dGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4
LA0KPiAgCWlmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlICE9IERSTV9NT0RFX0JMRU5E
X0NPVkVSQUdFKQ0KPiAgCQltaXhfY29uIHw9IFBSRU1VTFRJX1NPVVJDRTsNCj4gIA0KPiAtCWlm
IChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB7
DQo+ICsJaWYgKHN0YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRf
UElYRUxfTk9ORQ0KPiB8fA0KPiArCSAgICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNl
LmZiLT5mb3JtYXQtPmhhc19hbHBoYSkpIHsNCj4gIAkJLyoNCj4gIAkJICogTWl4ZXIgZG9lc24n
dCBzdXBwb3J0IENPTlNUX0JMRCBtb2RlLA0KPiAgCQkgKiB1c2UgYSB0cmljayB0byBtYWtlIHRo
ZSBvdXRwdXQgZXF1aXZhbGVudA0K

