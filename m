Return-Path: <linux-kernel+bounces-156618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F28B05B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003BD1F266EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45072158D83;
	Wed, 24 Apr 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ovSES+bD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BrldugQy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CE158D96
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950102; cv=fail; b=faLm4eLdYX43nGe9PJPlGjiCHQyHEVX8dh1Ydc2M4qgbZk7BesCQ2DDEo/m+GP2xTZ3XXNgv+8T6BTW3mYKx4FVwELsfOqcgkLUyR6HZKU2+xnuHj7z9OVDcXOLUSzXNxl43ffSy149ty/NbT/Djdk1mth+6d0B/MACbdIzjdKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950102; c=relaxed/simple;
	bh=F+3+82YTQ8CnBt4CW2AP15CLb1OqBUY6KafubDYfGIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MzrfR0eieHCzjzSkAjGrO674TF759OGhioBx4TqH3d1P77AVLEtgkDMk7BGISdDf6in8n6uY/jAmLcpoe8BVZjiAG5A9rbnqGoDQ9x38do4j7GXJ1nnzQ3u+MKyDVU5g1sPQcf5NkzCQ42CqTjwrAL2I72qgg/SB/+8D9jrreBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ovSES+bD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BrldugQy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 116fa918021b11efb8927bc1f75efef4-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F+3+82YTQ8CnBt4CW2AP15CLb1OqBUY6KafubDYfGIw=;
	b=ovSES+bDQ752m+sh4Bt6Yn4FvZ4z2hPvmJyNUsEZdjOUFTAFIwnYukgNx31s+fmzwHfZ4Ey/8FlAKrgUuahTwRp+9ybnoVcikB+xeD3btQyWNk6ONnDUb+6Fo8HORXYrLZ0eSWzWUOGXub7FPl9/I+Jo/IEVmcu1wjHxPLntVj0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b86f50f3-0e15-4ffb-9643-115a66e0f8d8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:c0ea8e86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 116fa918021b11efb8927bc1f75efef4-20240424
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shuijing.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1183965738; Wed, 24 Apr 2024 17:14:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 17:14:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 17:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUVdu+2dykfeNOOC97kuCgL/4u3cR/yXl+O5x1sH7hRHJX8JO8pVjXlz8mQRzpUrjoGoQsmgsnwiYJ/wSDRyHERN2yHGO6KXPiFdhQ+JUW9tFsh0IUp5jmghNlxQbfrBACYTN+H8Y9taEu57fpLSKFLWQS1Nih4n8VxlI1hTQafewk5R3p/1CGK+lSZ8q7YcJL9/DJOI1l9GwSU2qH/x8PwYIcfSWXSHVEISfzMn5DRNhN6hWQAbmWGpyyjsRlGWpXjKvgfYO4/Dhhd8IeqZjDpAJMrrLK23s3pibvH+U1C7F9MDCggBMdCeGrtJwZVEr38/2zE0g2lpyB+ADNV7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+3+82YTQ8CnBt4CW2AP15CLb1OqBUY6KafubDYfGIw=;
 b=U8opyOeRHWgZs4SK/Nm3+nek2mi5jmRg+eTZjisMDNepiS9T05cwQR+pFq0H/q382gC0bQstVIkz3Cj6e72WyyQ/X1fW6U91+ifxsYFEB8MDn80N4ofpEVETEVZogo5Dzgg54B7N9weETqFihpXzDd1/AO86EFeGIZ2jdyWPxMgIeUuGgs2pI3l5J2TYzq6fOXun9r0ALOfMOptWstKYfgVGbkvf2u5gNcMeUtA36mG4+g3D2fcjysbT6T298mGLoT3hQrMhC/lrT2xUH3nrDXUeJCVgx0cT7WhcS6uUI91lC6hy3G1E5Gaz4M5aC9034SD+qzjb/MLjNTsw08Htvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+3+82YTQ8CnBt4CW2AP15CLb1OqBUY6KafubDYfGIw=;
 b=BrldugQyNr2QVstqVG4/Y/kjYOCYk3GcnDIW3Xd4oKX97vNl5jEqUFUcMlDrX5AuJGNYmWi0CCq1JrioxUzUL4H2BGwCAInCOa8a9UO5KgzQB7FUlAmeUt+0lK9RzmmxtLi6Vb9/8JCYv5MNsZ2jAHki/L92xkHVuj1h/mGs/PM=
Received: from SEZPR03MB8678.apcprd03.prod.outlook.com (2603:1096:101:231::6)
 by OS8PR03MB8982.apcprd03.prod.outlook.com (2603:1096:604:2a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:14:31 +0000
Received: from SEZPR03MB8678.apcprd03.prod.outlook.com
 ([fe80::97b7:3c7d:8683:b0f4]) by SEZPR03MB8678.apcprd03.prod.outlook.com
 ([fe80::97b7:3c7d:8683:b0f4%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:14:31 +0000
From: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
	<airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Topic: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Index: AQHadfPtb+z3LozX/E+GiLbBEBgpt7E3A90AgEBf2oA=
Date: Wed, 24 Apr 2024 09:14:30 +0000
Message-ID: <bb6683011afc9febc64946e9dcae102ca5ba0054.camel@mediatek.com>
References: <20240314094238.3315-1-shuijing.li@mediatek.com>
	 <b7addbd1-d199-4734-9db6-d7dbc3a7f7d9@collabora.com>
In-Reply-To: <b7addbd1-d199-4734-9db6-d7dbc3a7f7d9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8678:EE_|OS8PR03MB8982:EE_
x-ms-office365-filtering-correlation-id: 146d8588-5762-4331-d842-08dc643ef325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?ZWNLSmc0Q0FLbHhZWHpLeFJGeVJ3R1pUWVd6NHJTNWlXTEg0dSsyU2NQZDdV?=
 =?utf-8?B?ZHp4a3BEajdKSGlna3pXd2E3Q3FMUlpncWpyVEo3UTRuMHpFYm96YnZqc1h3?=
 =?utf-8?B?TUdENzI3c0RoazZRS1lTdmN5Z01EYlRGakhIRTU2NnNicmdNY0d1c1dwTHcv?=
 =?utf-8?B?b1hUNGx3RDFhYkhtek5LcXBUdi9BaEIzUmVxWnNHQkpuNlhROFROSHVMbS91?=
 =?utf-8?B?MjUwUThGMHhick40V2ZhT2dRM1QwdWpFVm55V0lBcWtrUHNXWUZCTnpKYllr?=
 =?utf-8?B?RXAzY01Wa3pGUVNlcW03UjkvZTZjWWk1VlhvUlhOeUE3UnZCTVFMZXBqa28v?=
 =?utf-8?B?TTR1dkhFd0Rxb2pLOTg4REpSU3hLQ3doWU1DTWl2TGcxbWFVRzQ2YzJtZHFN?=
 =?utf-8?B?ZnNZZjRuMWYwZ2kvcmlaQ0NBMUNKVnpYT1Z4NzlSUzhjQ2Uzc3luTHYrSzMr?=
 =?utf-8?B?OHpuSmhMTDJKeWtTUTJ6d2ZRL0l6Qm5ramdBclJuclR1T04xKzZqWEhrRlNk?=
 =?utf-8?B?TEJQdm9hTGRHVlFCMm1FQnNVSGRJN3NQVEdOU3ovcFUzTWNOWjlmLzl4eWZm?=
 =?utf-8?B?YjF5YkdFaTN1MElVdThNVzFTNkYzd0UrRkg4cldwenNjYyswbjk3MEVaWVNI?=
 =?utf-8?B?and1UWNBK09nNkwwMVgrV1BFV0RiZzBIeG5pdVlzWGpMUTVGNUNGMm1lSmhN?=
 =?utf-8?B?ZHkxTUMzaDg0MmwzdzdwaEpVZ2MxMHhGQlkwZTRwZXovWTZUR2RTK3gvZXYx?=
 =?utf-8?B?THpMYXB3RzhxZ0JqQ01HaS9uR0pJOFNSdFEwRXlOYU93b1A3dzd6T1JhZkp4?=
 =?utf-8?B?dHgweG1TVTRRRTUxcGNscTF2elhTSk4rZlpkcXhMZ1puK3BUNmNZcXZLaCtx?=
 =?utf-8?B?ei9UZStLRnFKT1EwUEVxcEJiVkdRTWZIbTlKQzNjQ1dOb2pCR203VzliNlcz?=
 =?utf-8?B?RDJTSHIxWkl2NXkzbVdBZUZGRXBOZ1F3SmxIYURobTBiL1JTVzc0SUlwcDFU?=
 =?utf-8?B?TUVXUC9XODNqcEJiSjhhbUIvNTVUcHJKQ0J5Q0o1bHZnTnlsM3Fyc3BTdkdq?=
 =?utf-8?B?dFJMWEJlQlZ0SnRKS2hJSEJpb0MxVmI0SE9PeS9EMllITHBxeWVFZW4rVmwv?=
 =?utf-8?B?Tzc4S0FBWU4vYXdPcCtPazBiOHRvaE1lWmN2SkQ0WTY4R0gxbElLbWs3RVVZ?=
 =?utf-8?B?dEpXVUJpTXRPNW9mbkwvRjJOMDBmdGgvZUdFMzFSZ3NTRDJvK1RUcEhCOHdx?=
 =?utf-8?B?ZE9OZGZQUE15YzI3Z2F0UUxVZFJuQkhHY003SlM5QTVkS1M3MjdFRFdqSjlN?=
 =?utf-8?B?WGxkdkxhc2lkQXBnWmdHdXcyeHRwWVZNSmhVUnBXUGlOd3cvbDhhZHBaM2x2?=
 =?utf-8?B?WkRJdXZyaTFiN0RITjRXdjFkNlVUcTZ0cE5BbURTMXBUNEZUOUN4bHAyTGlY?=
 =?utf-8?B?RnJPQTZHTDNFWk9HQlJTcTZQMDNweFJmV3FyaDJkK0NSclRLZ2JTMjB5SU1J?=
 =?utf-8?B?ejNFOUFxOVVYY1h4QzZKbWJCMWsxTkxXS2pQbjIvbFpnbmlrUDVDMSs3Qlha?=
 =?utf-8?B?UlgvbUZKQWdQMDhVcVVJUmFnM21SMHR3NytBZnYzVGhsKzl3VzRCVFJTdzFq?=
 =?utf-8?B?Mnd3VktNYkxEZUE4OC83OW1ZZyszTmh3K1BYT3J3bUJmRSsweVBuQjYzSkhT?=
 =?utf-8?B?azhzbmQ5US95blBaMlpNMFIvcWlvekV6aXVPamhGMlhUTjlvYVlnUTJEdlhq?=
 =?utf-8?B?K2xVNHFnWFl2NExjam8wdlNEaVkzdnZtbHhlNHdwZ3pKeWs1NVVvblZRS2Vt?=
 =?utf-8?B?azRtTVVIbll3U0hmMVliZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8678.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1dJazdlckVac0ZvSlF6bk1ua3RJTGQzeEdxSmhJYnlFNVBiL1hNSmRaeXUw?=
 =?utf-8?B?aVlCcFJROHhCY3dGTnR3aE1sT0tWRGRuR2ZBWnZBZHAxeW40N1d3Y3dDQ2JX?=
 =?utf-8?B?MHJPSFhHQ2ZyclA0aE1nc0JXQXRDNWVqaEI1M25WMG5vTjU1YUtQc29rVk1R?=
 =?utf-8?B?Nytid29hT1ZYWUFOMWRTUk9IZnN3Mk0yVXNhbGFhMXVsOXZvSmgxZWFjSVZZ?=
 =?utf-8?B?STNYMVZ4MmhBZlFZakNwQ2JPVmppSTdPWkNNNFRXRktVbmtEV0daWXpycTNX?=
 =?utf-8?B?RU5IMHZCN2ZJaUp1Z0xvUG1GLy8weEw1VWZzb3dEVFU3TWJMTTB2dUYreTdH?=
 =?utf-8?B?endOVzV1YnlMcytselh6czFLK2l1UDhyb2RuaUhWcEMzbFBxaWpCQXlZTUNX?=
 =?utf-8?B?b1Y1QXdiOWZDSDFwK3ZDd0FMSjRsWjA2L3ZHcjFBNlBFd0d6NXd1ckdjZ3VU?=
 =?utf-8?B?eWY1MU5LK0M1VlNIeFlYWjBaWnJYOGROdnY1NUY3NnpZZi9TSW14QjVNU0gz?=
 =?utf-8?B?eWxxYXJ2MlBsRXprN3lubmdoTFlvRGRaT05tN3RRWEUzbE1LeVlIb29rbGFD?=
 =?utf-8?B?K3JOQWt3dmpHRzZJMFZ0WjRQWjc1cGhXaUZPNG1wYlR2Q3VrRWtJZzB5RytM?=
 =?utf-8?B?ZDVYdjVWM016cnFqTmNqN3Y3bWdGVGdTRCtHRGZlS3dXeG4zRVdYSC9UVnBo?=
 =?utf-8?B?eHc3ZlNKRStzd29VK0I1WW01YzFwUmR5U0k5UGx1QkZ6TkpvOVVZeUFaQnZs?=
 =?utf-8?B?TUErdFJKSTVDUGJvZlpPNG5TRGF5WkFxYXJEUnNXTURsc3oxK3hWbHN6ZVRW?=
 =?utf-8?B?am05RXh1MndGSFFtWUo2TDliYTJUTGdKSGpSVWwrQjhsZVgrVDVrWW4xTGZj?=
 =?utf-8?B?MkFldUlvWnRHbThQOFNueDdsODJDQWFJSG10QzZIRnk5NU5mVCsxeUJZWHlk?=
 =?utf-8?B?em50ZEJKbzgrbElNRUtUMWlKNDlhd1VzNmp3YU5RKy8ydUV2SFBLY1BQVVNI?=
 =?utf-8?B?UmtnTmphZEwza3ZHbllEbGhIRzRjY1FOQnk2T3NtOUtRQ3pOQm5mdmRvN0Fx?=
 =?utf-8?B?cHNKRGlNZk1IaUNaSjRLUms2VUdzVU1reHQxUkpyQXJCVVlpbm9IbSt6TFVi?=
 =?utf-8?B?aysrMkE3ZmxTMmZhOUFZM1hRWTdRbFljdmVYTFR1TzFhS0w0QmhkM3JxVk1O?=
 =?utf-8?B?NG9wOElHRG9tbmQ3ZTlTSlJWekFFRS9lTHhVSDQvS25hRlJKaXUxSTgwOW9Y?=
 =?utf-8?B?bFRvTlJFUE51dU82TkZyeE5hYUw2TW5lUG9PZUlmVndWL2h1VnpEc1lqbUR4?=
 =?utf-8?B?dmlRMzl1TURxbVJVUVc2L0FnTW9xQWhqRTY2OWgwMFZiTVBlK1JUaTZqbmw2?=
 =?utf-8?B?OW84eHM1d0hZK2hRbU1lendFdVpSRlNTaTZrQXJhaldNU1BWdWVWS3pXRDJF?=
 =?utf-8?B?RjNpa1N1U2dIUkZRdjMzcllzSUZUQ3BKVEdvKzNsTjZaR2VzcTVsTUtMNmFX?=
 =?utf-8?B?TjAxMEdmMWh5NHVrUXdiNUFRbTBGT3NlNmQvcUdPTUhiV3k4VDYvY3JlWStj?=
 =?utf-8?B?ZkF6czhQcUxmRmw4ZHV6K1Q2QVNvZ3dEQkFWZjVMVkVRaGFlU2FLN0ZhZ0pE?=
 =?utf-8?B?b3g0MnVwRWxDYU1GdHNhSkhweHVaaFJNMGx0OXl6WmpRL2hCQmFEQzQrbHlB?=
 =?utf-8?B?NmxleTQvdHkvYmRQemdtM2U1OGJsU2tRQnZKbGM2MExndTY2YzBHTmtTeGVC?=
 =?utf-8?B?dE5GYnhWWE1PcU1RUXh6NWhjOXNxSDYzTThKNjJZS0tRWWtCR3hpLzVCSFA2?=
 =?utf-8?B?RXA1WEtQaUZoTkV0dStPY294VDVmWFUwTXVrVHp0RUlPcG53NmhybFN4UDlQ?=
 =?utf-8?B?VGtuY0lnaG9HcWJNY1c0Ly9DY0pKNzVJZUcwdFF6Z0Y5cTV4VEZyOENQMzhl?=
 =?utf-8?B?OFNJR2ZOcndsbXFveWVNejRUZUl4Zy9uelQ0ZU9id29xSTFROUYvcTI5ajZI?=
 =?utf-8?B?M1pjT082cWxMN0k2dDhycUw5d0V2N1hpQk1uRUZ3VzB4R1MxeW5uYXUrTWFp?=
 =?utf-8?B?cDhhTGtjQldscTNBTVRWS2xKbnRBVHJVTUlNWUdSSTFTZmg0TXlmT09ybUxC?=
 =?utf-8?B?b1JFbWo5OER5bVYzTlFCZW05clI1YVk3ZGU0VnhLaUE3bkVtYUNwL3RzTjVN?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA6E2D7F42812A4284B5E81C66F22F16@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8678.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d8588-5762-4331-d842-08dc643ef325
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 09:14:30.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2I1wzNa+Y9rKZA8blmzJIB0x9VK9+oDXyD+1dczahKYkwDm2Zp4qTnHvPpoejC2AoTOINk1eWE1lN141EofGvLiEptkqbmS9JMmgaDFC1dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8982

RGVhciBBbmdlbG8sDQoNCj4gUGxlYXNlIGRvY3VtZW50IHRob3NlICJtYWdpYyBudW1iZXJzIjog
d2h5IGlzIHRoaXMgMTIgKyAyICsgNCA/DQo+IFdoYXQgaXMgMTI/IHdoYXQgaXMgMj8gd2hhdCBp
cyA0Pw0KPT0+DQpUaGlzIGlzIHNldmVyYWwgcGFja2V0cywgYXMgc3BlY2lmaWVkIGluIGNoYXB0
ZXIgOC4xMSBvZiB0aGUgRFNJDQpzcGVjaWZpY2F0aW9uLiBUYWtpbmcgdGhpcyBhcyBhbiBleGFt
cGxlLCAxMiA9IDQgKEhTUykgKyA0IChIU0FfUEgpICsgNA0KKEhTRSksIDIgPSBIU0FfUEYsIGFu
ZCA0ID0gSEJQX1BILg0KDQo+IElzIHRoaXMgc3VwcG9ydGVkIG9ubHkgb24gTVQ4MTg4PyBBcmUg
eW91IHN1cmUgdGhhdCBNVDgxOTUgZG9lc24ndA0KPiBzdXBwb3J0IHRoYXQ/DQo9PT4NCk1UODE5
NSBkb2VzIG5vdCBoYXZlIHRoaXMgcGxhbi4NCg0KQmFzZWQgb24gdGhlIGZlZWRiYWNrIHlvdSBw
cm92aWRlZCwgSSBoYXZlIG1hZGUgdGhlIG5lY2Vzc2FyeSBjaGFuZ2VzDQphbmQgd291bGQgbGlr
ZSB0byBzdWJtaXQgYSB2ZXJzaW9uIDIgZm9yIHlvdXIgY29uc2lkZXJhdGlvbiBhdCBhIGxhdGVy
DQpkYXRlLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgYXR0ZW50aW9uIHRvIHRoaXMg
bWF0dGVyLg0KDQoNCkJlc3QgcmVnYXJkcywNClNodWlqaW5nDQoNCk9uIFRodSwgMjAyNC0wMy0x
NCBhdCAxMToxMCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+IEls
IDE0LzAzLzI0IDEwOjQxLCBTaHVpamluZyBMaSBoYSBzY3JpdHRvOg0KPiA+IEFkZGluZyB0aGUg
cGVyLWZyYW1lIGxwIGZ1bmN0aW9uIG9mIG10ODE4OCwgd2hpY2ggY2FuIGtlZXAgSEZQIGluDQo+
ID4gSFMgYW5kDQo+ID4gcmVkdWNlIHRoZSB0aW1lIHJlcXVpcmVkIGZvciBlYWNoIGxpbmUgdG8g
ZW50ZXIgYW5kIGV4aXQgbG93IHBvd2VyLg0KPiA+IFBlciBGcmFtZSBMUDoNCj4gPiAgICB8PC0t
LS0tLS0tLS1PbmUgQWN0aXZlIEZyYW1lLS0tLS0tLS0+fA0KPiA+IC0tX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18tLS0tX19fX19fX19fX19fX19fX19fXw0KPiA+ICAgIF5I
U0ErSEJQXl5SR0JeXkhGUF5eSFNBK0hCUF5eUkdCXl5IRlBeICAgIF5IU0ErSEJQXl5SR0JeXkhG
UF4NCj4gPiANCj4gPiBQZXIgTGluZSBMUDoNCj4gPiAgICB8PC0tLS0tLS0tLS0tLS0tLU9uZSBB
Y3RpdmUgRnJhbWUtLS0tLS0tLS0tLT58DQo+ID4gLS1fX19fX19fX19fX19fXy0tX19fX19fX19f
X19fX18tLV9fX19fX19fX19fX19fLS0tLV9fX19fX19fX19fX19fDQo+ID4gICAgXkhTQStIQlBe
XlJHQl4gIF5IU0ErSEJQXl5SR0JeICBeSFNBK0hCUF5eUkdCXiAgICBeSFNBK0hCUF5eUkdCXg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExpIDxzaHVpamluZy5saUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5j
IHwgMTAwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jDQo+ID4gaW5kZXggYTJmZGZjOGRkYjE1Li5lNmY0ODA3Yzg3MTEgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gPiBAQCAtODMsNiArODMsNyBA
QA0KPiA+ICAgI2RlZmluZSBEU0lfSFNBX1dDCQkweDUwDQo+ID4gICAjZGVmaW5lIERTSV9IQlBf
V0MJCTB4NTQNCj4gPiAgICNkZWZpbmUgRFNJX0hGUF9XQwkJMHg1OA0KPiA+ICsjZGVmaW5lIERT
SV9CTExQX1dDCQkweDVDDQo+ID4gICANCj4gPiAgICNkZWZpbmUgRFNJX0NNRFFfU0laRQkJMHg2
MA0KPiA+ICAgI2RlZmluZSBDTURRX1NJWkUJCQkweDNmDQo+ID4gQEAgLTE4MCw2ICsxODEsNyBA
QCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSB7DQo+ID4gICAJYm9vbCBoYXNfc2hhZG93X2N0
bDsNCj4gPiAgIAlib29sIGhhc19zaXplX2N0bDsNCj4gPiAgIAlib29sIGNtZHFfbG9uZ19wYWNr
ZXRfY3RsOw0KPiA+ICsJYm9vbCBzdXBwb3J0X3Blcl9mcmFtZV9scDsNCj4gPiAgIH07DQo+ID4g
ICANCj4gPiAgIHN0cnVjdCBtdGtfZHNpIHsNCj4gPiBAQCAtNTE2LDYgKzUxOCwxMDMgQEAgc3Rh
dGljIHZvaWQgbXRrX2RzaV9jb25maWdfdmRvX3RpbWluZyhzdHJ1Y3QNCj4gPiBtdGtfZHNpICpk
c2kpDQo+ID4gICAJCQkodm0tPmhhY3RpdmUgKiBkc2lfdG1wX2J1Zl9icHAgKyAyKSAlIGRzaS0N
Cj4gPiA+bGFuZXM7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0
YS0+c3VwcG9ydF9wZXJfZnJhbWVfbHApIHsNCj4gDQo+IFRoaXMgcmVhbGx5IGxvb2tzIGxpa2Ug
YSBnb29kIGNhbmRpZGF0ZSB0byBmaXQgaW4gYSBmdW5jdGlvbiBvbiBpdHMNCj4gb3duLi4uDQo+
IA0KPiA+ICsJCXVuc2lnbmVkIGludCBscHggPSAwLCBkYV9oc19leGl0ID0gMCwgZGFfaHNfcHJl
cCA9IDAsDQo+ID4gZGFfaHNfdHJhaWwgPSAwOw0KPiA+ICsJCXVuc2lnbmVkIGludCBkYV9oc196
ZXJvID0gMCwgcHNfd2MgPSAwLCBoc192Yl9wc193YyA9DQo+ID4gMDsNCj4gPiArCQl1MzIgYmxs
cF93YywgYmxscF9lbiwgdl9hY3RpdmVfcm91bmR1cCwgaHN0eF9ja2xwX3djOw0KPiA+ICsJCXUz
MiBoc3R4X2NrbHBfd2NfbWF4LCBoc3R4X2NrbHBfd2NfbWluOw0KPiA+ICsNCj4gPiArCQlkYV9o
c190cmFpbCA9IChyZWFkbChkc2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVDT04wKSA+Pg0KPiA+IDI0
KSAmIDB4ZmY7DQo+ID4gKwkJYmxscF9lbiA9IChyZWFkbChkc2ktPnJlZ3MgKyBEU0lfVFhSWF9D
VFJMKSA+PiA3KSAmDQo+ID4gMHgxOw0KPiANCj4gKHNvbWV3aGVyZTogI2RlZmluZSBIU1RYX0JM
TFBfRU4gQklUKDcpKQ0KPiANCj4gdTMyIHRpbWVjb24wLCB0eHJ4X2N0cmw7DQo+IA0KPiB0aW1l
Y29uMCA9IHJlYWRsKC4uLi5EU0lfUEhZX1RJTUVDT04wKTsNCj4gdHhyeF9jdHJsID0gcmVhZGwo
Li4uLi4pOw0KPiANCj4gZGFfaHNfdHJhaWwgPSBGSUVMRF9HRVQoSFNfVFJBSUwsIHRpbWVjb24w
KTsNCj4gYmxscF9lbiA9IEZJRUxEX0dFVChIU1RYX0JMTFBfRU4sIHR4cnhfY3RybCk7DQo+IA0K
PiA+ICsJCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVM
U0UpIHsNCj4gPiArCQkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0NCj4gPiArCQkJCSh2
bS0+aHN5bmNfbGVuICogZHNpX3RtcF9idWZfYnBwIC0gMTApOw0KPiA+ICsJCQlob3Jpem9udGFs
X2JhY2twb3JjaF9ieXRlID0NCj4gPiArCQkJCSh2bS0+aGJhY2tfcG9yY2ggKiBkc2lfdG1wX2J1
Zl9icHAgLQ0KPiA+IDEwKTsNCj4gPiArCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPQ0K
PiA+ICsJCQkJKHZtLT5oZnJvbnRfcG9yY2ggKiBkc2lfdG1wX2J1Zl9icHAgLQ0KPiA+IDEyKTsN
Cj4gPiArDQo+ID4gKwkJCXBzX3djID0gcmVhZGwoZHNpLT5yZWdzICsgRFNJX1BTQ1RSTCkgJiAw
eDdmZmY7DQo+ID4gKwkJCXZfYWN0aXZlX3JvdW5kdXAgPSAoMzIgKw0KPiA+IGhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZSArDQo+ID4gKwkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICsg
cHNfd2MgKw0KPiA+ICsJCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUpICUgZHNpLQ0KPiA+
ID5sYW5lczsNCj4gPiArCQkJaWYgKHZfYWN0aXZlX3JvdW5kdXApDQo+ID4gKwkJCQlob3Jpem9u
dGFsX2JhY2twb3JjaF9ieXRlID0NCj4gPiBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICsNCj4g
PiArCQkJCQlkc2ktPmxhbmVzIC0gdl9hY3RpdmVfcm91bmR1cDsNCj4gPiArCQkJaHN0eF9ja2xw
X3djX21pbiA9IChESVZfUk9VTkRfVVAoKDEyICsgMiArIDQgKw0KPiANCj4gUGxlYXNlIGRvY3Vt
ZW50IHRob3NlICJtYWdpYyBudW1iZXJzIjogd2h5IGlzIHRoaXMgMTIgKyAyICsgNCA/DQo+IFdo
YXQgaXMgMTI/IHdoYXQgaXMgMj8gd2hhdCBpcyA0Pw0KPiANCj4gPiArCQkJCWhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZSksIGRzaS0NCj4gPiA+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0K
PiA+ICsJCQkJKiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4gKwkJCWhzdHhfY2tscF93Y19tYXgg
PSAoRElWX1JPVU5EX1VQKCgyMCArIDYgKyA0ICsNCj4gPiArCQkJCWhvcml6b250YWxfc3luY19h
Y3RpdmVfYnl0ZSArDQo+ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4gKwkJCQlw
c193YyksIGRzaS0+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiA+ICogZHNpLT5sYW5lcyAv
IDYgLSAxOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWhvcml6b250YWxfc3luY19hY3RpdmVf
Ynl0ZSA9IHZtLT5oc3luY19sZW4gKg0KPiA+IGRzaV90bXBfYnVmX2JwcCAtIDQ7DQo+ID4gKw0K
PiA+ICsJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gKHZtLT5oYmFja19wb3JjaCArDQo+
ID4gdm0tPmhzeW5jX2xlbikgKg0KPiA+ICsJCQkJZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+ID4g
KwkJCWhzdHhfY2tscF93Y19taW4gPSAoRElWX1JPVU5EX1VQKDQsIGRzaS0+bGFuZXMpIA0KPiA+
ICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiA+ICsJCQkJKiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4g
Kw0KPiA+ICsJCQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYNCj4gPiBNSVBJX0RTSV9NT0RFX1ZJREVP
X0JVUlNUKSB7DQo+ID4gKwkJCQlwc193YyA9IHJlYWRsKGRzaS0+cmVncyArIERTSV9QU0NUUkwp
ICYNCj4gPiAweDdmZmY7DQo+ID4gKwkJCQlibGxwX3djID0gcmVhZGwoZHNpLT5yZWdzICsNCj4g
PiBEU0lfQkxMUF9XQykgJiAweGZmZjsNCj4gDQo+IFBsZWFzZSB1c2UgYml0ZmllbGQgbWFjcm9z
IGhlcmUgYXMgd2VsbC4NCj4gDQo+ID4gKwkJCQlob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSA9
ICh2bS0NCj4gPiA+aGZyb250X3BvcmNoICoNCj4gPiArCQkJCQlkc2lfdG1wX2J1Zl9icHAgLSAx
OCk7DQo+ID4gKw0KPiA+ICsJCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgyOCArDQo+ID4gaG9yaXpv
bnRhbF9iYWNrcG9yY2hfYnl0ZSArIHBzX3djICsNCj4gPiArCQkJCQlob3Jpem9udGFsX2Zyb250
cG9yY2hfYnl0ZSArDQo+ID4gYmxscF93YykgJSBkc2ktPmxhbmVzOw0KPiA+ICsJCQkJaWYgKHZf
YWN0aXZlX3JvdW5kdXApDQo+ID4gKwkJCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9DQo+
ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4gKwkJCQkJZHNpLT5sYW5lcyAtIHZf
YWN0aXZlX3JvdW5kdXA7DQo+ID4gKwkJCQlpZiAoYmxscF9lbikgew0KPiA+ICsJCQkJCWhzdHhf
Y2tscF93Y19tYXggPQ0KPiA+IChESVZfUk9VTkRfVVAoKDE2ICsgNiArIDQgKw0KPiA+ICsJCQkJ
CQlob3Jpem9udGFsX2JhY2twb3JjaF9ieQ0KPiA+IHRlICsgYmxscF93YyArIHBzX3djKSwNCj4g
PiArCQkJCQkJZHNpLT5sYW5lcykgKw0KPiA+IGRhX2hzX3RyYWlsICsgMSkgKiBkc2ktPmxhbmVz
IC8gNiAtIDE7DQo+ID4gKwkJCQl9IGVsc2Ugew0KPiA+ICsJCQkJCWhzdHhfY2tscF93Y19tYXgg
PQ0KPiA+IChESVZfUk9VTkRfVVAoKDEyICsgNCArIDQgKw0KPiA+ICsJCQkJCQlob3Jpem9udGFs
X2JhY2twb3JjaF9ieQ0KPiA+IHRlICsgYmxscF93YyArIHBzX3djKSwNCj4gPiArCQkJCQkJZHNp
LT5sYW5lcykgKw0KPiA+IGRhX2hzX3RyYWlsICsgMSkgKiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+
ID4gKwkJCQl9DQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4gKwkJCQlwc193YyA9IHJlYWRsKGRzaS0+
cmVncyArIERTSV9QU0NUUkwpICYNCj4gPiAweDdmZmY7DQo+ID4gKwkJCQlob3Jpem9udGFsX2Zy
b250cG9yY2hfYnl0ZSA9ICh2bS0NCj4gPiA+aGZyb250X3BvcmNoICoNCj4gPiArCQkJCQlkc2lf
dG1wX2J1Zl9icHAgLSAxMik7DQo+ID4gKw0KPiA+ICsJCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgy
MiArDQo+ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArIHBzX3djICsNCj4gPiArCQkJCQlo
b3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSkgJQ0KPiA+IGRzaS0+bGFuZXM7DQo+ID4gKwkJCQlp
ZiAodl9hY3RpdmVfcm91bmR1cCkNCj4gPiArCQkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
ID0NCj4gPiBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICsNCj4gPiArCQkJCQlkc2ktPmxhbmVz
IC0gdl9hY3RpdmVfcm91bmR1cDsNCj4gPiArDQo+ID4gKwkJCQloc3R4X2NrbHBfd2NfbWF4ID0g
KERJVl9ST1VORF9VUCgoMTIgKw0KPiA+IDQgKyA0ICsNCj4gPiArCQkJCQlob3Jpem9udGFsX2Jh
Y2twb3JjaF9ieXRlICsNCj4gPiBwc193YyksDQo+ID4gKwkJCQkJZHNpLT5sYW5lcykgKyBkYV9o
c190cmFpbCArIDEpDQo+ID4gKiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4gKwkJCX0NCj4gPiAr
CQl9DQo+ID4gKwkJaHN0eF9ja2xwX3djID0gKHJlYWRsKGRzaS0+cmVncyArIERTSV9IU1RYX0NL
TF9XQykgPj4NCj4gPiAyKSAmIDB4M2ZmZjsNCj4gDQo+IHNhbWUgaGVyZQ0KPiANCj4gPiArCQlp
ZiAoaHN0eF9ja2xwX3djIDw9IGhzdHhfY2tscF93Y19taW4gfHwNCj4gPiArCQkJaHN0eF9ja2xw
X3djID49IGhzdHhfY2tscF93Y19tYXgpIHsNCj4gPiArCQkJaHN0eF9ja2xwX3djID0gKGhzdHhf
Y2tscF93Y19tYXggLyAyKSA8PCAyOw0KPiANCj4gYW5kIHNhbWUgaGVyZS4uLiBhbmQgZXZlcnl3
aGVyZSBlbHNlLg0KPiANCj4gPiArCQkJd3JpdGVsKGhzdHhfY2tscF93YywgZHNpLT5yZWdzICsN
Cj4gPiBEU0lfSFNUWF9DS0xfV0MpOw0KPiA+ICsJCX0NCj4gPiArCQloc3R4X2NrbHBfd2MgPSBo
c3R4X2NrbHBfd2MgPj4gMjsNCj4gPiArCQlpZiAoaHN0eF9ja2xwX3djIDw9IGhzdHhfY2tscF93
Y19taW4gfHwNCj4gPiArCQkJaHN0eF9ja2xwX3djID49IGhzdHhfY2tscF93Y19tYXgpIHsNCj4g
PiArCQkJRFJNX1dBUk4oIldyb25nIHNldHRpbmcgb2YgaHN0eF9ja2xfd2NcbiIpOw0KPiA+ICsJ
CX0NCj4gPiArDQo+ID4gKwkJbHB4ID0gcmVhZGwoZHNpLT5yZWdzICsgRFNJX1BIWV9USU1FQ09O
MCkgJiAweGZmOw0KPiA+ICsJCWRhX2hzX2V4aXQgPSAocmVhZGwoZHNpLT5yZWdzICsgRFNJX1BI
WV9USU1FQ09OMSkgPj4NCj4gPiAyNCkgJiAweGZmOw0KPiA+ICsJCWRhX2hzX3ByZXAgPSAocmVh
ZGwoZHNpLT5yZWdzICsgRFNJX1BIWV9USU1FQ09OMCkgPj4gOCkNCj4gPiAmIDB4ZmY7DQo+ID4g
KwkJZGFfaHNfemVybyA9IChyZWFkbChkc2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVDT04wKSA+Pg0K
PiA+IDE2KSAmIDB4ZmY7DQo+ID4gKwkJcHNfd2MgPSByZWFkbChkc2ktPnJlZ3MgKyBEU0lfUFND
VFJMKSAmIDB4N2ZmZjsNCj4gPiArCQloc192Yl9wc193YyA9IHBzX3djIC0NCj4gPiArCQkJKGxw
eCArIGRhX2hzX2V4aXQgKyBkYV9oc19wcmVwICsgZGFfaHNfemVybyArDQo+ID4gMikNCj4gPiAr
CQkJKiBkc2ktPmxhbmVzOw0KPiA+ICsJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlID0gKDEg
PDwgMzEpDQo+ID4gKwkJCXwgKGhzX3ZiX3BzX3djIDw8IDE2KQ0KPiA+ICsJCQl8IChob3Jpem9u
dGFsX2Zyb250cG9yY2hfYnl0ZSk7DQo+ID4gKwl9DQo+ID4gICAJd3JpdGVsKGhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hTQV9XQyk7DQo+ID4gICAJd3JpdGVs
KGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IQlBfV0MpOw0KPiA+
ICAgCXdyaXRlbChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hG
UF9XQyk7DQo+ID4gQEAgLTEyNDYsNiArMTM0NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2RzaV9kcml2ZXJfZGF0YQ0KPiA+IG10ODE4OF9kc2lfZHJpdmVyX2RhdGEgPSB7DQo+ID4gICAJ
Lmhhc19zaGFkb3dfY3RsID0gdHJ1ZSwNCj4gPiAgIAkuaGFzX3NpemVfY3RsID0gdHJ1ZSwNCj4g
PiAgIAkuY21kcV9sb25nX3BhY2tldF9jdGwgPSB0cnVlLA0KPiA+ICsJLnN1cHBvcnRfcGVyX2Zy
YW1lX2xwID0gdHJ1ZSwNCj4gDQo+IElzIHRoaXMgc3VwcG9ydGVkIG9ubHkgb24gTVQ4MTg4PyBB
cmUgeW91IHN1cmUgdGhhdCBNVDgxOTUgZG9lc24ndA0KPiBzdXBwb3J0IHRoYXQ/DQo+IA0KPiBS
ZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHNpX29mX21hdGNoW10gPSB7DQo+IA0KPiANCg==

