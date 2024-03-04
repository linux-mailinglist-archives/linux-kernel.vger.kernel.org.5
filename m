Return-Path: <linux-kernel+bounces-90862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D84870624
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7210AB2CA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B84DA04;
	Mon,  4 Mar 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cbq7r/B4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qNTDiT7V"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB9481A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566771; cv=fail; b=B8o/TuW6wHFOYrY53qQPy4w4pjHgoNmzIyoc0y8PTGLLP4YGi073wYQjDOQ1sa/lVjmAZEsWX4736dKBq/i+x8wQn3fP/NfG5MdapKOFpDcRrVKua5zw2EYUL9kwCSt5xEjSr/Yz1LZMkeJS/Qqcn22hIGT79nHPbLJ7DNg6NbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566771; c=relaxed/simple;
	bh=f5Ppwzs9pIDg42WbFULARx1Zvvit5C0FWfSXhf8UEQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IJFBPINXfIW3Md2W+XyBHmprQuK5eahKqzaxqlem7jI+1ri0Waas9HmwHiNmTUL2E1FaDQsMJoKfetLZ8eRLsN93+sNu9Ugr70xAEqk1RDLKtc+g0QPlHigOT3v0DS2/y3mNfBJGJL9T5McnxICZdjwKnp1iAPZ1Dxwwd2QskmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cbq7r/B4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qNTDiT7V; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 60b31aecda3d11ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f5Ppwzs9pIDg42WbFULARx1Zvvit5C0FWfSXhf8UEQs=;
	b=cbq7r/B4+U/iR7ryh0JqYXBrx+eV7eYKp5C2mWyWHH0YlGs0HXePtfi/4hZolacG9gm+O1WfHf1OPqmWnhyjavH4q0TWBZx4M+2iTb+r04L2+dq1NRpz2kdHdaopbcfXEUVoKmnQ24ZJGzUoyjjUkjlDWyz1fLAugh0bnyox5eg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c79d4845-8189-4d73-b0e6-281aa0b3b334,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:37b69884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 60b31aecda3d11ee935d6952f98a51a9-20240304
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 862905885; Mon, 04 Mar 2024 23:39:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 23:39:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 23:39:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUL8EV9diFscckXq7wH0PiKTmzUtn8cD0Js275h5pv4BFzPI0gxYnPMhXdIpE8N5S+CNsHgEvoqCVXja3G0E0mzq8sBuOq60LiOCOVN9BWNMnAYe8oaGoCDyxZIaiqO54SVLIa6FVp3V47mh1SR6dgG/irlp4AYS7Dpa5luWtkgTxdqrXcBC0A+CJXX7Zu6gu3E1IGb8IHFLxZ7z5lwpJJk2p/9mTSdRQUG73knEo8HcGqJmMfj1h14jNtMAhuH4FGDeUtok8WbFA0lHm69SMkWzAQU7BLq5sOyg9NxQZNaEEx46CHM0GvBElzv4XIswJL/IMekGHqlkzFn/NaJBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Ppwzs9pIDg42WbFULARx1Zvvit5C0FWfSXhf8UEQs=;
 b=gs0fxpzC5qi9c5CyDNKt3j617pxgQKs/v7F3gN3Ekyxaj8ePitRu+WpYu6dt6dMa8+xJ4RRnwil3mEWsQmaybd3KD+tLJldSRh3+hlFC4cGOEttSsgUwW5vCCm8TexLDfgVppUJEIgpSvJr1FxlYvMVHKwZLNBu5nrSWcHMOO35TXgz8o/STJJ0CREggWmdU1ntRhRzBpzbLzRabxe88g3gmdWlR/qc60U73jInlYnqjTngcCg/WoL41htAQyo6Kz8GF9ac/KgsK7y5JRbFdWi796aZVAZgj/B0ehw4R7uYxr5W3snpLdMHcHP3PnVW16gGA9HbpeKyWikmD7Pkt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5Ppwzs9pIDg42WbFULARx1Zvvit5C0FWfSXhf8UEQs=;
 b=qNTDiT7VIxQ1Kp5lZwpAZ35lD76oNOIrO8NZC/uQc0cxY4Z6iBAlHygcfpcgYVJkCEaAHy/SYDss9/uAC5Itq4RjHxHhsFM08+WMuFAqvYyFhzXz37BYrRbKQO/FwwZWa3D7aibHsjlkmozlKIu57z/BvA36pvxOooObH1q8H8c=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8230.apcprd03.prod.outlook.com (2603:1096:101:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 15:39:20 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:39:20 +0000
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
Subject: Re: [RESEND, PATCH 4/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
Thread-Topic: [RESEND, PATCH 4/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
Thread-Index: AQHaa+b/w8B443UOGkqSLoAweqsZE7Em2q4AgADhwoA=
Date: Mon, 4 Mar 2024 15:39:20 +0000
Message-ID: <2872ca3bf9fb3e55a93c1a7d48149bacdd8e2bd5.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-5-jason-jh.lin@mediatek.com>
	 <ade36b07c4f60a755a3b7700250e56ec61711d53.camel@mediatek.com>
In-Reply-To: <ade36b07c4f60a755a3b7700250e56ec61711d53.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8230:EE_
x-ms-office365-filtering-correlation-id: c60b3a7e-9ce9-4aef-0eb9-08dc3c614261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWDkAZEjofGk+ZM7m0LXZ4HXDNyAauSez/mPlsxWRy6GigiEtrPZl9ejx1txKjoOMtXVT9mDc0fczwm2KW07V/3LwIclG5fo5YULrImqfcUw3mQcX4RgIAhTCiZzf6oO6ZXl0EzSNXy7NH4uZrNCs7xyDGUQSv+TzwdHE6FV88lkCkNmxWoqwSf1xXgDzOEsGlhX6hD8c0KMErzKj5lRsCcRCA9k8dnxHSCWssNCm0hHay1Cqc1z91gIohy7IeF9vm03XZHA8d297nODSYhcFobir96HQlYDWj6045m4MIs0Re5oeJvrGwc54GBcg6lFjxg5kNRh8AiKwvP8BeG21M66hwtE4fr6HIRIFdsMTD8E3v477IdIMVcAQzBwwiVsBNj7jlHRPrN2YtWb3gPLaZEiHcTNlq/zwGmwIBMN4PYVEWPA++ADN4gFqpLK6g+OLm2dJ8fdZDgN8j6eF2/WCMIF5qgPUhDnVWvO2SxyqvJANpnjvGPVyiyvOXM+yKUNSBZnswLoXCPiG4+joVMAQ8HI7MnkyEEtBp5LFFxFGwHBrvV6Mcaf69nWtMV7OxczXm0mfOj472y/2DNHw5gDppE7bfRV0LEjDJa1b5vmMHoqG2UTSHvRTZaek1YkeQGE4/GXLxfvImY6X+aOpaKMTY3mwgUryRMbj1zFcMfbhbbM34eK4Pa+5fYRePCTl0NRfjP2Dd8gKMV18lL/eFqr2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFZJNUtSbE1wRGhuTGpLSWYxRlVHNkVoMGFLaXRTdU5kK0RxeUpTWEh1czV5?=
 =?utf-8?B?Um52MXF3WU5xK2NMSzBDWHR3ZW1EZktFVjc1anVMSktkM2lSbWtaVEZMQTk0?=
 =?utf-8?B?OTI1MHczMHhCT0lBRzU1WVZkV2ZHWXRYaDNFMzIxOXJSUDZxZFdWcjZsZUlQ?=
 =?utf-8?B?NkcwOFVPdlNjNWJQcXRaWERSS0UrNFNTcGZKWGdBMENZbUlUYzZEeFhkS3Jh?=
 =?utf-8?B?ZGxFc0JEcjAxbEFrTnBod2xFWTRUQmNJK2JieTRuWjdEUnAzbVJ3K1VMcVZQ?=
 =?utf-8?B?czlKcHI5blhNNGQvZWFvL1VWSUp1L3dLM2t5VUVaVWJrL3JhRFZGYmIzWURt?=
 =?utf-8?B?Yzk4NEo0RmdXL0tGSDJ0Skl4WjFUT0srT0tReHZwTW9YRldGNEpTM2NZQi9j?=
 =?utf-8?B?dnJXNjZhbGw3UmJINXpGdmlrVHN0UVErNXd6Q0FnYjJ6ckQvOTEzdjRkM2Y4?=
 =?utf-8?B?enYxQXdiTU9BT3VhbWdYRkhxNHArRnZvWi9Mc0x6Y0xvakt0dnErSVdGS1FS?=
 =?utf-8?B?bUROQkZFelVZM0FNMjZ1cURwTzhNaXROL0trYUtTejA2V2RtUXZMakwvOEt2?=
 =?utf-8?B?b0xENkZKMEJibzhVRGx4Q1BGK2djZVNKMHFZTDRKQnA0R2YvbFEwUFhsWGQ4?=
 =?utf-8?B?MWFEbXNMeFRHcStZaUdYeXBEemdGVU9heHpsZnJpYWRCUno3TWVoV1RESTho?=
 =?utf-8?B?ZWdRWTdrMXYySXkyd2dKSG5Jb3NkTWgyKy9FRVQ5dHRkREI3UERjcGpydHBQ?=
 =?utf-8?B?NjJwcnNWK0JLbllmdEdiT2s0WFZ3V2IrVXhkVjNyZDVBd080T2FNelptZEwv?=
 =?utf-8?B?a1U0S2ZqbkY2bEdoY3FXby9lVVJUVDdZdjNhYllsVmtZNDNkOE12c0J4bnFG?=
 =?utf-8?B?bDROUm9UUUR4eFZ1azFKYktRc2ovRm44cjVDVGZVVUFCYlVCMmdPNmxOa0NL?=
 =?utf-8?B?SU14OXpJRjNtVUF5UkxWanVjU0h4a09HWHZYUTdwNXlMdDU4MDdaTDVvMnN2?=
 =?utf-8?B?WS9XbjdSUWJhdFF0Z0l2VnlXSUFxcWVCSFhsbGx1OGdKZm5hVnJ1dWloV1dk?=
 =?utf-8?B?dlZsZHJrd0YzYlNmWFduQ0phM09CVW5PbTFJSUY5WWZWM3ExeWFjU09WVFRu?=
 =?utf-8?B?VzlqNnRMcmtSTHpHRENvR2U0ZXFZWEVKSHN5S0tsMnJEQlRQM3U3cHMxV0xH?=
 =?utf-8?B?VVovYzdJY0N3T3pURjBFZFBHbDdxUk9BT1U4YzVrcGEwV3BpOE82YzRySkJa?=
 =?utf-8?B?UFN2NDVFV1FWZllzdWtOdWhpSHlJcTNsWVhrZFhiNjNSQXF4YzFLTWNOWjdV?=
 =?utf-8?B?cjV0WVdlN05SY1JBeVZoZGFZMElOamVTZThNOXNtb2c0WFk5UUZKYWIzQ3RK?=
 =?utf-8?B?MXd3bXV5SWgrd2IwV2xGdHh4U094TEg0aDdMQ1lGTEU5d1UwNTVuek1wK1Bk?=
 =?utf-8?B?SEZITFdwVm5RWWRRVVpMVUFnS2xYRGc1WElPTnE2L3JNN0VsR0RQNW8yTHFT?=
 =?utf-8?B?SGV3UTkydW4wMGUrajVWYUpXSHBuZ081VDVSM1Q1Y0FDM05lQ29rd2tHTHVx?=
 =?utf-8?B?dG5ud010cWdCeld3RG9kY2I3TWFkSnhydk5Vb2FsdURFRkV0TTRyVlo1ZTlX?=
 =?utf-8?B?cVBwdmttMXhkZ2MrOVZjTUE0TFBzYXNrdHNKNys3dkJTNmJ5TXRYdWdTRVNz?=
 =?utf-8?B?Y3owVTU4UTIrUU8xVG1sbHBxMlVEb29YZHFUMnYvNktKdDB4Z0NpcGF3T1hn?=
 =?utf-8?B?cmJCaTcxcHdZUmdYaUhURnhpSG5vU29ETDQyVjVLK3ZZTlFUS3JqYWpmVXc2?=
 =?utf-8?B?QnorSHlpRSs0dnNpajBjdVQ0bjJDV3FSU0hHQVRzT2Q2bElLMFlRWjBwSEZW?=
 =?utf-8?B?aURGQ1FYcGpPUmpsS2xVZk90WStEWkFBT0w0dnlwUHFQMGovS0hsM0p3QTQ5?=
 =?utf-8?B?TVFETUt0eVV0UFNiS1o4QjJkVHhrSDFYRDhhZnpsYzVQSExEajh6eGhNSEE5?=
 =?utf-8?B?R3dhWXorUmFQR1Q3OFo0dVBmbW85MHRkRW91dHh5bkVIZmNVWnkwMmc3L3Zt?=
 =?utf-8?B?WlVhUk9OZUcvQVB3NVkva29IcnNMcTMxMFlXQzVGVlRuWElXOHhCelFDOHQ1?=
 =?utf-8?B?SVl4SEhhVlFwWmMxSWkwY3pKS1YvemZiL0F3MnZVVEJBVDFUTkx4QzhqVkph?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72B7321F6961414B9A9D484776CBD15E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60b3a7e-9ce9-4aef-0eb9-08dc3c614261
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:39:20.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFgNogXY0Qcseg6O1g97V94vVQ3mQJaZkjvT7Lk4yzCA5sPX9DNOzOFFovllelZIPf50ECQnp9qwPgExkxRU9PwbXaVDOy9TYuyG0G6/4bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8230

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyNC0wMy0wNCBh
dCAwMjoxMSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyNC0wMy0wMSBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KCkgZnVuY3Rpb24gdG8gc3VwcG9ydCBD
TURRIHVzZXIgbWFraW5nDQo+ID4gYW4gaW5zdHJ1Y3Rpb24gZm9yIGFjcXVpcmluZyBldmVudC4N
Cj4gPiANCj4gPiBDTURRIHVzZXJzIGNhbiB1c2UgY21kcV9wa3RfYWNxdWlyZV9ldmVudCgpIGFu
ZA0KPiA+IGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkNCj4gPiB0byBhY3F1aXJlIEdDRSBldmVudCBh
bmQgcmVsZWFzZSBHQ0UgZXZlbnQgYW5kIGFjaGlldmUgdGhlDQo+ID4gTVVURVhfTE9DSw0KPiA+
IHByb3RlY3Rpb24gYmV0d2VlbiBHQ0UgdGhyZWFkcy4NCj4gDQo+IEknbSBub3QgY2xlYXIgd2hh
dCBhY3F1aXJlIGRvIGluIGRldGFpbC4gVGhpcyBpcyB3aGF0IEkgZ3Vlc3M6DQo+IA0KPiBjbWRx
X3BrdF9hY3F1aXJlX2V2ZW50KCkgd291bGQgd2FpdCBmb3IgZXZlbnQgdG8gYmUgY2xlYXJlZC4g
QWZ0ZXINCj4gZXZlbnQgaXMgY2xlYXJlZCwgY21kcV9wa3RfYWNxdWlyZV9ldmVudCgpIHdvdWxk
IHNldCBldmVudCBhbmQga2VlcA0KPiBleGVjdXRpbmcgbmV4dCBjb21tYW5kLiBTbyB0aGUgbXV0
ZXggd291bGQgd29yayBsaWtlIHRoaXMNCj4gDQo+IGNtZHFfcGt0X2FjcXVpcmVfZXZlbnQoKSAv
KiBtdXRleCBsb2NrICovDQo+IA0KPiAvKiBjcml0aWNhbCBzZWN0b24gKi8NCj4gDQo+IGNtZHFf
cGt0X2NsZWFyX2V2ZW50KCkgLyogbXV0ZXggdW5sb2NrICovDQo+IA0KPiBJZiBpdCdzIHNvLCBk
ZXNjcmliZSBhcyBkZXRhaWwgYXMgdGhpcy4gSWYgbm90LCBkZXNjcmliZSBob3cgaXQgZG8uDQo+
IA0KWWVzLCB0aGV5IHNob3VsZCBiZSB1c2VkIGxpa2UgdGhpcy4NCkknbGwgYWRkIG1vcmUgZGVz
Y3JpcHRpb24gaW4gY29tbWl0IG1lc3NhZ2UuDQoNCj4gQXMgSSBrbm93LCBHQ0UgaXMgc2luZ2xl
IGNvcmUsIHNvIG11bHRpcGxlIHRocmVhZCBpcyBzZXJ2ZWQgYnkgc2luZ2xlDQo+IEdDRSwgd2h5
IG5lZWQgbXV0ZXggbG9jaz8NCj4gDQpBbHRob3VnaCBHQ0UgaXMgc2luZ2xlIGNvcmUsIGl0IHdp
bGwgY29udGV4dCBzd2l0Y2ggdG8gb3RoZXIgR0NFDQp0aHJlYWRzIHdpdGggdGhlIHNhbWUgcHJp
b3JpdHkuIFRoZSBjb250ZXh0IHN3aXRjaCB0aW1lIGlzIHNldCB0bw0KR0NFX1RIUl9TTE9UX0NZ
Q0xFUyBkdXJpbmcgR0NFIGluaXRpYWxpemF0aW9uLg0KDQpTbyB3ZSBoYXZlIHRvIHVzZSBldmVu
dF9sb2NrIHRvIHByb3RlY3QgSFcgcmVzb3VyY2UgaWYgZWFjaCBjbWRxX3BrdCBpbg0KZGlmZmVy
ZW50IHRocmVhZCBtYXkgZXhlY3V0ZSBtb3JlIHRoYW4gdGhlIGNvbnRleHQgc3dpdGNoIHRpbWUu
DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
IHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmggIHwgIDkgKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiBpbmRleCAyZTlmYzliYjExODMuLjAxODNiNDBhMGVmZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTM0Miw2ICszNDIsMjEg
QEAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2DQo+ID4gZXZlbnQs
IGJvb2wgY2xlYXIpDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93ZmUpOw0K
PiA+ICANCj4gPiAraW50IGNtZHFfcGt0X2FjcXVpcmVfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5z
dCA9IHt9Ow0KPiA+ICsNCj4gPiArCWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsN
Cj4gPiArCWluc3QudmFsdWUgPSBDTURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFM
VUUgfA0KPiA+IENNRFFfV0ZFX1dBSVQ7DQo+ID4gKwlpbnN0LmV2ZW50ID0gZXZlbnQ7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4g
K30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KTsNCj4gPiArDQo+
ID4gIGludCBjbWRxX3BrdF9jbGVhcl9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0g
fTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KPiA+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4
IDJmZTliZTI0MGZiYy4uZGU5M2MwYThlOGE5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTIwMiw2ICsyMDIsMTUgQEAgaW50IGNtZHFfcGt0
X21lbV9tb3ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+IGRtYV9hZGRyX3Qgc3JjX2FkZHIs
IGRtYV9hZGRyX3QgZHN0Xw0KPiA+ICAgKi8NCj4gPiAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBib29sIGNsZWFyKTsNCj4gPiAgDQo+ID4gKy8qKg0K
PiA+ICsgKiBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KCkgLSBhcHBlbmQgYWNxdWlyZSBldmVudCBj
b21tYW5kIHRvIHRoZQ0KPiA+IENNRFEgcGFja2V0DQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBh
Y2tldA0KPiA+ICsgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHRvIGJlIGFjcXVpcmVkDQo+
ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29k
ZSBpcyByZXR1cm5lZA0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0X2FjcXVpcmVfZXZlbnQo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAg
ICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5kIHRv
IHRoZSBDTURRDQo+ID4gcGFja2V0DQo+ID4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0K

