Return-Path: <linux-kernel+bounces-91631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C687146C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6E9283BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3568938FA8;
	Tue,  5 Mar 2024 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ERv3AmCX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KBdTKgQy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4B27441
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610695; cv=fail; b=dkzLJYBMMcRv0gqPuC9GFvif3sOqstrRqte/dbV0mWZa6VmdCfPMDNYxmTCpmNRZuI3xrCO9WI3zRJo6YGVpF6BlI0JEMmDt9z0DghGWjHeGVF0BROLxMSM7YuO2Llr4WwntcUH7sni2Lb9G5r4ai8v7DIr33i0afl1Ia9iUMaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610695; c=relaxed/simple;
	bh=0gPmGLkrliEriV/D9b3lHRbnJSYo46lnaY0D7QQlYow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lVMSDO/FG1MrTUsF3JOFJaeJLvzBrC4VCrgYC5cZnsucEmaTtHxAuckd6nuZ74Vv0qfOkiVYRa0hnbdHnB+t0n2/ZYsj+dZc010/9f3hLpl9OXXbC4zJVi5DofMzjnW/X4heImxWlAqYKAU2RKKW8/0GONe62WmRh5nlnKsg6uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ERv3AmCX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KBdTKgQy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a3b39e46daa311eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0gPmGLkrliEriV/D9b3lHRbnJSYo46lnaY0D7QQlYow=;
	b=ERv3AmCXwIuzqDK+DaGfdsYgoYo6HmvO5TmExWN8gKQ/T+D3JADHQ6jeUcoWYQpHkL9B0Oz+gCxortfUMC2jUss4KlpdDYKk0AIhQIBi9me3MMnb6E7dJZ3k/SylFZ61D9PiEW6nBre9owrZiZANV53JVo5FP4AQSuC+GSUQJjs=;
X-CID-CACHE: Type:Local,Time:202403051126+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5878079c-7911-45c0-a858-97f89004a5e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:16cb82ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a3b39e46daa311eeb8927bc1f75efef4-20240305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 811409693; Tue, 05 Mar 2024 11:51:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:51:24 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:51:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNOsu/BeZ6f68GTX8eoJaH+x08V08ybfeniQ1SiT9vebQULIb+gZj1T+KEfImMNtckEzLLgICa5uLbOy7o8lDveJqjS0zG8oXoXirhWbCPdhnJGZoyFxwkbCno5MZankR09fIHqZkVVRGck3sABnE1WWZhES3fznPSBe57n4B6tSFj/3NMSMZGJ817eahteITeZ7Gj20M7wKbUxeWWrjPYFgNXm7F/I05EZkggBJtAo8Nz4XnzQgc7lAIiw+Hw3b7fFgOtO4C3ONqss1LS9AcMy8dNVqbdpy9/ydogl+mjOb+28Eyghcu+/TQJ3SqzaXAWHzEWT73NteRUVqG7OrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gPmGLkrliEriV/D9b3lHRbnJSYo46lnaY0D7QQlYow=;
 b=Kh9B7rqth7FUScA3WkGSF87dYvWbwKhqjkdg2Q/AF+ZPGQ1UfRtmJpZ5dRmpWEulWIVdYM4cC1pGQAwgL31U0lTWMMNsyvjMPaEDleatwZ63zdqs6HveT+tFym9NWJ93XLsd9tP02gCAuHl5p7Dp5OlD3JzGa22CGgS/GJOOrUGI7aoM/IEgy5nzMTKQCf/loHtBXLJHOH2hQEeb8/x2ictMxa80ZIUuLd5CK7OoBngctcuNufMTwx4nLAUf8Q1R8JWkUrcRI2JpKBE5TWsW9lOiZmKSfMMjguTq5TmT5egS8x8dW6oEehgyFtaWxk8jZhTIaIONpiOtU/l8H4CH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gPmGLkrliEriV/D9b3lHRbnJSYo46lnaY0D7QQlYow=;
 b=KBdTKgQyIdd76G1YVxhdHsJhl7WBkISYbeHXANvguTfWRcHq7uBdrnbZIbYj8UhPEe2/3cnRBp9Qhsr7VTh1Z0uDRDanhu72ecab11hAL1OkBQqqgLPtAnm+9ta06lq50GI1GN/yZXtHGEscb3x4U2xxHGWOjmQzMXeTlNaVWPw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8517.apcprd03.prod.outlook.com (2603:1096:405:5a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 03:51:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:51:21 +0000
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
Thread-Index: AQHaa+ccRvkxaECXsEmGlXDC8fIiUbEm65cAgADYBICAAL5tAIAAAzOAgAADugA=
Date: Tue, 5 Mar 2024 03:51:21 +0000
Message-ID: <388bf94dfc0a98386b131e99a5c57d210e86c99f.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
	 <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
	 <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
	 <172e03d1f7bdb65c15e6a6ca5f52b3dd1929c7cc.camel@mediatek.com>
	 <0e18361489d77d38647db957d921bf21fcc067c0.camel@mediatek.com>
In-Reply-To: <0e18361489d77d38647db957d921bf21fcc067c0.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8517:EE_
x-ms-office365-filtering-correlation-id: 0d99feaf-40f6-405b-a49f-08dc3cc78550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XeeRZBHgw4Ve1QWKhqGTvF1g6cmm7HP9btmEff52SU+bqk+B5XEHU3f8cohZS7WXp3QtQQG2C8azsXeyRACeVMFqtULbAVt3zevmgxuz2c1WT5jxjkD9blXZgHhXyaV6QWXSDaYIOo9atbTsShzYQfjbdZCskJSivhe8StB6P+3KqRqlk/d0DT6J3Ia8/N+UI1ek9/R/yORC8bFf223VHoKngyLM/196AJIjCqcc3sWWiRPQwkVzg85qFSn/bgxb/7Q6NSVbuw0iDwHeh3IpfONApKkV0U/wwt2tKR0f2pTpDRKbHcXoIG4ETOWQG0op72hOb0tXzAplzff1ecYAyq/FeULIcgpGayt3d7CAPaXRgh+sRk3fr8b1GqohBn3DlAsPBImHOnjM9B1903BQswuhV/9phpY4FqvXDDBRRWLT5ah/GP3Y7RYjxWWiwlBN+g9uYVYwavntTgtQutSLQuAas/wdTWfMCeQhAwYhd7VPcyIp2pU+0vrRyVGd2nTqv5NffdF2/7kmn9u06ONZdCMhZZ/DPEr0XigJ45mNuh8cpeMKdmToKaA887Tqk7f0SBtrACB55TQGKRuIUDUV2A7al75jDPuFMYCKCSREiQEajDG33/Ufmek7SZdICBrAXr9tsGrrQdxC0GIbaELzFiOHZBFEfkRl7fJ2/JzojWFZoIJ84Vl8kfXXWbxMXtcU0dsjZhQ6HILcFGJGOUIjreccBiRk1xSV8NShEh0/jdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBLUkFQcWxsMUJ2YVpyTnN1UTdyQnlGbGVERm5PTTE0YXdRbkVKZlZtWVd3?=
 =?utf-8?B?SDBYV29ieStVUGNiRGozV2JOSGRBV3cvdkFkQ211eFNNbDZ5K09rUFh3VHdO?=
 =?utf-8?B?VElwUnBwV1k1bHg2YjQ5SXVHUkRRQ3dLb2g3dk1pRWNCVWJGcHJHUDV0VnJh?=
 =?utf-8?B?cHFnWG1QbExFeW1NT2Njd282N0N5UklmdHp6NmRkbnVoTlQrOTBNWlpXcEw4?=
 =?utf-8?B?NkdzaTdQQVVhZ0ZZRDJzTTBpTTZYTTJ6V2tTQndSOFA0d0FDM2tQSVVIRlp6?=
 =?utf-8?B?NGRyaVdXLzNlMFVlNTlURU9uWjZiNG5FTFdtLzZxdkxBUWZwNTRSOEFoUit6?=
 =?utf-8?B?OWxkK0cyWUg2MkFHWlVVYVZMdmdFTW9EWTFQVXVqNnYwVEJ2TXAzMG9GaWw3?=
 =?utf-8?B?bWdLQXBNdHV3cU9jZk5pRGc0ckl1cE9DaFhQcUY4M3YwNElRQ0lqbmJSYTB2?=
 =?utf-8?B?bWxORGhlenNHVW9kUHpPb1M4NGRPOEdrR0hseWU3ZDlibVJMdFQ3VkRWZWp4?=
 =?utf-8?B?aFNoNDY2K2NMWXNCQ2Q3V0U5YnE3VVhncWpXTkoyckw0bTVJQ1lxVGYydGQ1?=
 =?utf-8?B?bGtDSlVqWm1nNm9ZYzBxM2MrMFdsVGd6YUJlTjIrTUNhRENPSHZxS3hBUkYw?=
 =?utf-8?B?WlNiU0VZSm9HdEI4OW03VFVPaUdTL2wwWnhpMFpEWElOSm9sKzVETVVpcUtG?=
 =?utf-8?B?aXhyTG95Zm9WdStaMmMySEpydFNienZ5WXNaRGtrVUh2VFI5VEdvTS9RSGli?=
 =?utf-8?B?V0twSHp6QlZ0V0FLMkdXenprejNXYU05TkJPTW1JRTd4SE8rQWJOK2R0cVph?=
 =?utf-8?B?cUROU3FrUm8rb01oUU5hUnFhaFhoT3Q2eThuVUErdmJlTFBuV2JSSUNKbWJ5?=
 =?utf-8?B?TE52dlZjdE5rZVBEeVFTUGRBSWh5VXJwU1JUVm5BMmFVYjdkUkFQd3pNbWlo?=
 =?utf-8?B?ZE1rbWtWcThQSmxEVkw0RFh1cHVudWU1bkVyeVRVeC9YSThDRkxFZ0VFOGFo?=
 =?utf-8?B?ZTVPZ3VxTm94eWJ1aERmSUpRMDNsSGZqcWpyNEd0aXJJYk1nOVpmeFZ1SDJZ?=
 =?utf-8?B?QVFLRWhiYWRFcStNYkd3QStSSTI5NDBtRFJOWXF6Qk8rSkNKNDNKWFpsdy9C?=
 =?utf-8?B?MmNpQ2pLSytJOHpKcExBRlNROVVEVzM3L3FGR2lkMTYwZDgrYnpHWlJmMmJ2?=
 =?utf-8?B?VEpkOFNvY0F4V3NYUnRKU0cxaG1HMENjKzd4Z0V6STVRMnZZaVpFaXI3WEgw?=
 =?utf-8?B?MFVWQlc4SldRZERRYURwZEZ4M0paWVlqa3RSOVEyV2tBWXpTNWRld1Z0aEVY?=
 =?utf-8?B?OUxmYTFkdlg3WWw1NUdiVVI4VE5xNndTRVJwNGh2UlkwQW5nMHFXOUpaSGJT?=
 =?utf-8?B?OXU4M3dadFZ3MktGUi9mM0w0ZnIwdmN5OFgyU2FiTm1hbFRaRkF2RmJyNzBo?=
 =?utf-8?B?VU5Qdm9TRGVLYndpaVpiT1EvSm5jNlE4Q2JhcE5pUUJBVWx5ZGdKMFdEbXNX?=
 =?utf-8?B?TFdwOU5VUER2cWQrTy83NWY0OXhuZHRPa0Z5RzhxemxMRk00WFdzME0zZGNW?=
 =?utf-8?B?YU43V0VHUWcrZVNuWkRTNVFyTjl3bGRRWHJoakc0OVVEVGNZc2RGKzZZcnhT?=
 =?utf-8?B?VThkM1ZUd1J1anBiUWdqSzBYUTNsVi92Z1RjWkVlQzhTMUFGRktZdXRXMDdH?=
 =?utf-8?B?RUE0bzljNGVCT1dvRzhRd3NtbzNneEpYay9JeEI5SHdHRjFBZUY4S3BuUmdD?=
 =?utf-8?B?SEphZVp3a1dSWjBUekZ3emhOeUpZNWh0UGFYb0JRM3puN0hZRWtYaExrNERO?=
 =?utf-8?B?WXBEZDJQQmJUM05QVm1BNVhDS3dRZHFzbUFXT0JSbnBtbStmMW5BR1U1K2xE?=
 =?utf-8?B?ZWdCNENwZVU5cURvWUFXMi9wNnhkYW00bUF2VjQ1VFFqaDVHWEhQeWJyaVcr?=
 =?utf-8?B?cGozcnhld0dIMGVaRUczcUVwZkdqTnFRSWMxV254TXNCcjVSSjJyZC9heHVw?=
 =?utf-8?B?WnZtQ1pYMjE3WVUxU3pzenhPSWZVMTJQQ1FKYUpjeThiZkhvejVoK0FHZ1VM?=
 =?utf-8?B?U2FhaFpLVVh4N0loYk82SWN0SkJIbkdjZC85cjc1cXVnMzR3cHBMOXYrcG51?=
 =?utf-8?Q?ISUjGEemaSs9Q/lakoOX1iVha?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A5D4F17195C92419867E0E5982A673F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d99feaf-40f6-405b-a49f-08dc3cc78550
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:51:21.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23CYTD471YbBv0pqjst2yrXa+4ep2j+YSTJgGedWvJvvyNZblOY+2ceXiIOpzBk26ttJKw4aEY80w2S8LtxMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8517

SGksIEphc29uOg0KDQpPbiBUdWUsIDIwMjQtMDMtMDUgYXQgMDM6MzcgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDAzOjI2ICsw
MDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFzb246DQo+ID4gDQo+ID4g
T24gTW9uLCAyMDI0LTAzLTA0IGF0IDE2OjA0ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+ID4gPiBIaSBDSywNCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3cy4NCj4gPiA+IA0KPiA+ID4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDAzOjExICswMDAwLCBD
SyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+ID4gSGksIEphc29uOg0KPiA+ID4gPiANCj4g
PiA+ID4gT24gRnJpLCAyMDI0LTAzLTAxIGF0IDIyOjQ0ICswODAwLCBKYXNvbi1KSC5MaW4gd3Jv
dGU6DQo+ID4gPiA+ID4gQWRkIGNtZHFfcGt0X3BvbGxfYWRkciBmdW5jdGlvbiB0byBzdXBwb3J0
IENNRFEgdXNlciBtYWtpbmcNCj4gPiA+ID4gPiBhbiBpbnN0cnVjdGlvbiBmb3IgcG9sbGluZyBh
IHNwZWNpZmljIGFkZHJlc3Mgb2YgaGFyZHdhcmUNCj4gPiA+ID4gPiByaWdzdGVyDQo+ID4gPiA+
ID4gdG8gY2hlY2sgdGhlIHZhbHVlIHdpdGggb3Igd2l0aG91dCBtYXNrLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFBPTEwgaXMgYW4gb2xkIG9wZXJhdGlvbiBpbiBHQ0UsIHNvIGl0IGRvZXMgbm90
IHN1cHBvcnQgU1BSDQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gQ01EUV9DT0RFX0xPR0lDLiBD
TURRIHVzZXJzIG5lZWQgdG8gdXNlIEdQUiBhbmQNCj4gPiA+ID4gPiBDTURRX0NPREVfTUFTSw0K
PiA+ID4gPiA+IHRvIG1vdmUgcG9sbGluZyByZWdpc3RlciBhZGRyZXNzIHRvIEdQUiB0byBtYWtl
IGFuDQo+ID4gPiA+ID4gaW5zdHJ1Y3Rpb24uDQo+ID4gPiA+ID4gVGhpcyB3aWxsIGJlIGRvbmUg
aW4gY21kcV9wa3RfcG9sbF9hZGRyKCkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8
IDM4DQo+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAxNiArKysrKysrKysrKw0KPiA+
ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4gPiA+ID4gaW5kZXggM2ExZTQ3YWQ4YTQxLi4yZTlmYzliYjExODMgMTAwNjQ0DQo+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gPiA+
IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAjZGVmaW5lIENNRFFf
V1JJVEVfRU5BQkxFX01BU0sJQklUKDApDQo+ID4gPiA+ID4gICNkZWZpbmUgQ01EUV9QT0xMX0VO
QUJMRV9NQVNLCUJJVCgwKQ0KPiA+ID4gPiA+ICsjZGVmaW5lIENNRFFfUE9MTF9ISUdIX0FERFJf
R1BSCSgxNCkNCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgdGhlcmUgYXJlIG11bHRpcGxlIEdQ
UiBhbmQgeW91IHVzZSAjMTQgdG8gc3RvcmUgaGlnaA0KPiA+ID4gPiBhZGRyLg0KPiA+ID4gPiBJ
DQo+ID4gPiA+IHdvdWxkIGxpa2UgeW91IHRvIGxpc3QgYWxsIEdQUiBhbmQgZG8gbm90IGxpbWl0
IHRoZSB1c2FnZSBvZg0KPiA+ID4gPiBlYWNoDQo+ID4gPiA+IEdQUi4NCj4gPiA+ID4gVGhlIHF1
ZXN0aW9uIGlzLCB3aHkgbGltaXQgIzE0IHRvIGJlIGhpZ2ggYWRkcj8gSWYgdGhlIEdQUiBpcw0K
PiA+ID4gPiBzaGFyZWQNCj4gPiA+ID4gYnkNCj4gPiA+ID4gYWxsIHRocmVhZHMsIHRoZXJlIHNo
b3VsZCBiZSBhIG1lY2hhbmlzbSB0byBtYW5hZ2UgR1BSIHVzYWdlDQo+ID4gPiA+IGZvcg0KPiA+
ID4gPiBjbGllbnQNCj4gPiA+ID4gZHJpdmVyIHRvIGFsbG9jYXRlL2ZyZWUgR1BSLg0KPiA+ID4g
DQo+ID4gPiBZZXMsIHRoZXJlIGFyZSAxNiBHUFIsIGZyb20gR1BSX1IwIH4gR1BSX1IxNSBhbmQg
dGhleSBhcmUgc2hhcmVkDQo+ID4gPiBieQ0KPiA+ID4gYWxsDQo+ID4gPiB0aHJlYWRzLCBidXQg
R1BSX1IwIGFuZCBHUFJfUjEgaXMgdXNlZCBieSBHQ0UgSFcgaXRzZWxmLg0KPiA+ID4gDQo+ID4g
PiBJIHRoaW5rIHVzZXIgbWF5IG5vdCBrbm93IHdoaWNoIEdQUiBpcyBhdmFpbGFibGUsIHNvIEkg
dGhpbmsgQ01EUQ0KPiA+ID4gZHJpdmVyIHNob3VsZCBtYW5hZ2UgdGhlIHVzYWdlIG9mIEdQUiBp
bnN0ZWFkIG9mIGNvbmZpZ3VyZSBieSB0aGUNCj4gPiA+IHVzZXIuDQo+ID4gPiANCj4gPiA+IEN1
cnJlbnRseSwgd2Ugb25seSB1c2UgMSBkZWRpY2F0ZWQgR1BSIGluIHBvbGwsIHNvIEkgZGVmaW5l
ZCBpdA0KPiA+ID4gaW4NCj4gPiA+IENNRFENCj4gPiA+IGRyaXZlciB0byBtYWtlIGl0IHNpbXBs
ZXIuDQo+ID4gDQo+ID4gSWYgdGhyZWFkIDEgcG9sbCBhZGRyIEEgZmlyc3QsIEdQUiBpcyBzZXQg
dG8gQS4gQnV0IHBvbGwgdGltZQ0KPiA+IGV4Y2VlZA0KPiA+IEdDRV9USERfU0xPVF9DWUNMRVMs
IGNoYW5nZSB0byB0aHJlYWQgMiBhbmQgdGhyZWFkIDIgcG9sbCBhZGRyIEIsDQo+ID4gR1BSDQo+
ID4gaXMgc2V0IHRvIEIuIExhdGVyIHN3aXRjaCB0byB0aHJlYWQgQSBhbmQgR0NFIHdvdWxkIGV4
ZWN1dGUgcG9sbA0KPiA+IGNvbW1hbmQgYW5kIEdQUiBpcyBCLCBzbyB0aHJlYWQgMSB3b3VsZCBw
b2xsIGFkZHIgQiwgYnV0IHRoaXMgaXMNCj4gPiB3cm9uZy4NCj4gPiBIb3cgZG8geW91IHNvbHZl
IHRoaXMgcHJvYmxlbT8NCj4gPiANCj4gDQo+IElmIFBPTEwgaW5zdHJ1Y3Rpb24gaGFzIHRpbWVv
dXQsIHRoaXMgbWF5IGJlIGEgcHJvYmxlbS4NCj4gDQo+IEJ1dCBQT0xMIGlzIGEgbGVnYWN5IG9w
ZXJhdGlvbiwgaXQgd29uJ3QgY29udGV4dCBzd2l0Y2ggd2hlbiB0aGUNCj4gZXhlY3V0ZSB0aW1l
IGV4Y2VlZCBHQ0VfVEhSX1NMT1RfQ1lDTEVTLiBTbyB3ZSBhZGQgdGhlIGNvbW1lbnQgIkFsbA0K
PiBHQ0UNCj4gaGFyZHdhcmUgdGhyZWFkcyB3aWxsIGJlIGJsb2NrZWQgYnkgdGhpcyBpbnN0cnVj
dGlvbiIgaW4gdGhlDQo+IGtlcm5lbGRvYy4NCj4gDQo+IEFuZCBjdXJyZW50bHksIHdlIGRvbid0
IHNldCB0aGUgR0NFIGhhcmR3YXJlIHRpbWVvdXQgaW4NCj4gQ01EUV9USFJfSU5TVF9USU1FT1VU
X0NZQ0xFUywgc28gaXQnbGwgcG9sbCBmb3JldmVyIHVudGlsIHRoZSBwb2xsaW5nDQo+IHZhbHVl
IGlzIHNldC4uLg0KDQpJZiBJU1AgcG9sbCB0aW1lIGxvbmdlciB0aGFuIHZibGFuaywgaXQgbWF5
IG1ha2UgZGlzcGxheSBkaXNvcmRlci4gV2hlbg0KSSBzZWUgZGlzcGxheSBkaXNvcmRlciwgY291
bGQgSSBmaW5kIG91dCBJU1AgcG9sbCB0cmlnZ2VyIHRoaXMNCmRpc29yZGVyPw0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkguTGluDQo+IA0KPiA+IFJlZ2FyZHMs
DQo+ID4gQ0sNCj4gPiANCg==

