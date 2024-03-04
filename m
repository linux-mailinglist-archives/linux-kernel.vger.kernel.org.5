Return-Path: <linux-kernel+bounces-90898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCC870685
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE741F2878C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15504F207;
	Mon,  4 Mar 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="idSkj+3o";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DXT8sVI2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B74EB2E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568313; cv=fail; b=L5JGBFOTexQmJtd1SaWQhnqIFxn15grelnT8S2tW5jegROhKmmAihD8nEs/E8Ytt9Q2/Khsl87iyoxALgWWj6LRdHArZXn/KWC0kh9KYBaB/woLTjYqndQmRjrlLdQz0jPVQrgzbDPXArWw7CozhFYCYsR/Ob96ifzDcuOJ4jF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568313; c=relaxed/simple;
	bh=wYhchrZlT6HJeC6nOzMlZmR21VqXny3Hs3ad695beXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pimu6tZO18MaIT0r3NpHfvEHLUEFD7FNUzzva8OamGuAuBsR4s5hcQmhVvoSsQiAYJy8ohZmziI1dEe/6Vavn/S1ShlVyc1IBHID+m1Y4qgcHL/TAmgya8saFx/7ukRLvrqVCE1IQIXJsRHAJKJofKRyXHpLOt8rXXPDQP5QO+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=idSkj+3o; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DXT8sVI2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f5abd1eada4011ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wYhchrZlT6HJeC6nOzMlZmR21VqXny3Hs3ad695beXM=;
	b=idSkj+3o5NqHaMtW9x3RLHaTaKVksFMRBQhsDgypsgXnxRYlj/HXA+epVVP7U7BNKN/cdBYDeEznJe3z7d+etLW0hjRL/OpTdBePEbVcp9DV8bw7LieGktSvW4uRt5nXiLy5gS1iU3kqAVnedqx+ItYa45bsVTxQf/i39Xns1fQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9ff3e0a8-4cde-4cdc-bcc5-345140f5f1fa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:dadf9884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f5abd1eada4011ee935d6952f98a51a9-20240305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 323043290; Tue, 05 Mar 2024 00:05:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 00:05:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 00:05:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbzN13RffaNK7HcOOvbsljZtP8RKcI+OPRuzjbzYQ2M3V5+Gzbz5rMLJt/Q5KHs696mYA6ELRSBdetGC+0uZjo+vccnqYeFk3RIsEnxUSkTpk7j5QTzRBWBjwFDcjqPrHtH0x4lzp3Xjt5yiZdv6hg+yqZhhfkMN9il+u3Eg2+Pr0GmvnbSDMr8wJhtO6gtF5L0PknFpw0XuQJuTyE/YMjPcwLKHFytdZPiRBlPQ1HhdWYsawDV4xSzpiBDQ2MQ7C5klnlyCgf78gst2PrM0R8sFg0ytc534aIUmlrn+b2JefW4Co0dc71oxB87kYBlCYNELOPSG2M5PahGsrXU6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYhchrZlT6HJeC6nOzMlZmR21VqXny3Hs3ad695beXM=;
 b=SAIn57za5Vp+6YiRIRg/Dl/AGfbDQYIfHcFMEfrUJSj1F2BAmG3LhYkmCzS7Vt+eN0ZYh3ByzRNdaI+pL6uTECmR3EXlASkfZtvi2W+MZ9StfT5e7HxnlYtT6XvVgIOWLgOYoYZDOFuoeH1j0OOalTuzAdIKFGtySuOZyeXEY/GvH6sVYwAuBIbW1dhhpy0U6V3mag0RPbHg2HD1rl0zFmOj5VGuIfbKW8AqhkN60C2Gh5mAWNIugKD1uj2lXN0Id4dVLykh7TqGUxeKL+CX1+S5iEzTJIcKU5SOSY2hTM5sDp6XM4m1mmOtNmcfBd2Kptz/i/U8PD7ggHpcb++ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYhchrZlT6HJeC6nOzMlZmR21VqXny3Hs3ad695beXM=;
 b=DXT8sVI2mjWBBZ8o6pMfHT2O/rT2HdXqwPCNYdyqHW14vGFV/nQxgd+yTeslLcFRABC3Nt2jSBY51rsUxkBtjwmbzq3URvaxSBMBzaQf2927L5OFTLuY1AazhFQjkO9+rjbjjU8uLGdkZG4sSDx2cpJ6lDn1FDQ34Qfump49Zpo=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB6860.apcprd03.prod.outlook.com (2603:1096:4:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 16:04:59 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 16:04:59 +0000
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
Subject: Re: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Topic: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Index: AQHaa+cLJ6J47YqzE0edY2v/hhyrU7Em65gAgADYAYA=
Date: Mon, 4 Mar 2024 16:04:59 +0000
Message-ID: <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
	 <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
In-Reply-To: <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB6860:EE_
x-ms-office365-filtering-correlation-id: 9ff4a9f7-b442-49de-08d3-08dc3c64d792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3g+IJTQpsdESmeS6kykldeSQIpYaoZy5T1ryo3XmH2Z51eCcA41nFZIzRToDExexlt2XmOGrZftr9VcybNhA1nJwagkbfDRc0vQ50Q5CXxIXSiGdNRFDpg1c7/5jbH3pcIEubpzB7ZBBBx3DuIvTfTA2Qu/I5IX+Ppfl1v9hAHPUQGamOu0ba1v0ASOLIommzEK6ltTTNtpgt23X4q+9CFsFL94dqfoCVOgH0BlTUiUPnhhg5E1e7Wlxv4uXgSXCddQKzbEqN8mQiAvlM9bZzMLu42x80DPTNjavw6uvNI7YwsIU+vs+CJ0KlkMXwPNUK70hd4MVr7SQ+flCyrxZMh6v9K1QyxPNLBV3rRTiUV73CqV5Sp9cI+oFvh5q9wiwW7q0Mt3l023NYgEuQWNPAtaK09pyFfVuLzmI/r60N2PsDpkYnSAv61rtujFrF7bp0UZiwTt8dDddbbGHlnLbq1qru2a2z1q2mKzCZKjrjB7wKahB2RSFdBkcJYFvuMFP1FfZF8IfoNNmAE95KR9YlK/G/Ah6RDJNAyguBBaELEmBu+3VBBdTn6gg8bNklvpnGC8oknAB5zsSezAZQF39mg712eVXeZxyAvCGgZUrFxVmB3s3XVV24Yo8Hz+GUPH2aR2zGASVbzPzjjGBzyZvsABabXpwKHg84RaADYojCMeQ/PnDsP6ilaPv1iF63LKikrmZWI4PrRNE2sag4lEw+l6QQheUGpJBT7q4/M0BEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEZ4MlBEck1RY2VPZ2lxVjFQK0s1TUFpdDUzSk5SNUxabTdsZnNKcEZhd2wy?=
 =?utf-8?B?bHdFMWZRRXlROFIzYnhLUDl4Zis4a3ROWlo0QkVuS2dlTnFtTTNvWVBwL2RS?=
 =?utf-8?B?bTBZZHVXREd0N2M2YjBTd1FQaW9rT2VTWkZxSVJId0N5TUs2Rll4cXlueVg1?=
 =?utf-8?B?a1hSRTJtRzN3b3ZMd1FRNjd0c2tqWnFuTG9GTFlNOEhwOGdoWnpjSlk4TUJm?=
 =?utf-8?B?NFJYRnFaUVZwWm1hL3lnN3ZhbHZVYTVSK2JPRzQ2bGMzT1J2L0VLeE91dHZF?=
 =?utf-8?B?dkVZZ2xINXo1ekNqdXJIdy9jc25sbFFCUStIN0NsUVJPT1pwRUpPL3FrTm4w?=
 =?utf-8?B?MjV2c2VOWnZIVmE2ZUtVRGNzN2x1TmVyNUtFMFNxSEtucVVzcHczWFZPWVVt?=
 =?utf-8?B?SE9pVlpjOGJpRGlEM2dUVFJWK2E4eUtLc29TN003dmEvOUp5TWZ6UkNKakt5?=
 =?utf-8?B?OVEvZWV4bS8rMGZKcTFyamtSUkh3ckNUb1p5UkFUdks5UzV6elcrcXhIRTRW?=
 =?utf-8?B?dFpGdmR6Z3Q0ZENDTFVQSUVuMWg3L3BlK0c2aXhYQXB6S0lDZXRiOHdHWGJK?=
 =?utf-8?B?WlUraWtBRTExbzRISlowNWtYZmF6V1dZYVpzdDAySDR3ZW13aFFOakw4T3RB?=
 =?utf-8?B?ZWtJdFRZY1lSeWNOTCthc3NlSnRJT0pLSGM2c09VR0lvU3ZTSktQUDJ4LzJ1?=
 =?utf-8?B?TXNSNnJPaDFXZStaMy9TKzFvQkxnVTFCTW9kNDIxUm5uNEMyL2wzcVVleHlD?=
 =?utf-8?B?dU9rVVdCNElpbzhTQkh3ZXNycUFyYnFrR0JvdDRDRTJOUUJMWTFwUm9WZDZv?=
 =?utf-8?B?T0h0VVlQRDJFNE03NU9KVFNDMWJUWGh6alE4bjVkSVhNejZ3TUFxamhjYVl5?=
 =?utf-8?B?dWQ0YXFldmczbkdnZjZCajh3cVRkVmRhb211L1pqZlFlQ2gzVktwVHpHTHpl?=
 =?utf-8?B?TTBDYTBNblF0YXM0ZG1iL1o0czdPdUZyVXRSL09MRFMvc1RDS1YyZk8vMFY2?=
 =?utf-8?B?T2hsbU5ZdDlQQ0lXbW9GcGMxTHgvMXlnWmxDekk5S1ZOZkxwT3RVWUc1RGxS?=
 =?utf-8?B?bHF2V0NXOHFwZDc5SENPcE05VDU2dk9DTlBnUHNqcDB3RXU5OGZJRWg1K3NH?=
 =?utf-8?B?c1dzdVNMSVFzR25zNHk2anhEaWFQR2c2bCtmTjJSdFhnanVvOGUzZjNTNXkw?=
 =?utf-8?B?elE5WTJuUGhuUmpKbWs2bTRNcFFWcmNWV0dRU2xUVFVURE9TNnEveXVGQ1F4?=
 =?utf-8?B?ZVQ1eGJ6dmlEaUJkVERUN2NxZ1ZGZFVvRG5WNEd0dHhKWEZvcWh6TzYvVVVT?=
 =?utf-8?B?VFRCb2pNYmlNem1DWE5kU3VpZVE1d3FWZ1Y5VkQ2TFNkYkpZakFCZ24rUFAw?=
 =?utf-8?B?MFMzNjlwMHE0bnhSOE5rY1ZPemNoSlZtekhmU1NLbTBWa0xhZXoyV0JpNHo5?=
 =?utf-8?B?VkdES3BYbFVvTGRjVjYxd0VFV2Y1VXEzSEhnQnpuL0RWQjZIR2dnMUtlUytp?=
 =?utf-8?B?Z1c2aDJTY21tMmJ4SVpRbzBCaGdqNnltN255YjBaZ0pzYXZjL0xqK1dmN2gw?=
 =?utf-8?B?N0FTS3gzU0EwblZuWEVvaDNYR21jYXFpOXQ3cXl1NVRlTU4rTGgvQ01SVU1T?=
 =?utf-8?B?TC9zTmpic0J3NURmMk55WmlYNDVmMmtJSDdvUERsbzV3bWY5cnlzU1NjS2g5?=
 =?utf-8?B?dlBjQVlEQWpIQ1V0cHNxUWZuOFpWdmpHbmk4a3BkWSs4bXlMNEp2dlovUHlq?=
 =?utf-8?B?RkFzSHIybmNoL2hJMGJmdStTZ3l0T3pFK3JYdTA2dXNhcG8wZ1ZrdWV2dlh0?=
 =?utf-8?B?aFN1R1E0VzVKNTYwYUVBNyszNWl5bE5jUmJtWGVQTy9YcFN2UkNucUJZa1JT?=
 =?utf-8?B?dzJ0VDEyM1o0MTdpUDBBckVwQmQ0UVN5WDRxQldyZ0pJS0VoTGIwcG9DVDJ3?=
 =?utf-8?B?ZkxwUEJjMys0eEJLb2RlbWZiK2JBT2VNS21Xam40SS8vOGRuVHphN0dRd1VX?=
 =?utf-8?B?RXNZejlwU211WDNLU0lwaWR4bGNIS0I5YzRyWVF0MCs1OWVObGZCcTB1RUJr?=
 =?utf-8?B?VWJGS0Y2OVdQTURrTDJUN2JGKzNneUkxWTh6bFh5bTlEM2hOYW9NeXY2UUVl?=
 =?utf-8?B?ZlBURERTVnlMR2lDbTdySDB2WUdCam9hWmdQWmZqQlVSQ3BYNmx3NHVTVVEx?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB309F0EEA130F48840A5FB4577E40E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff4a9f7-b442-49de-08d3-08dc3c64d792
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 16:04:59.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwSl8FniwHwh+J9XWx94ovpcC+n7gQdP12APlacQcqA8y+s8Js3nDjJwGCGMM1q1vN6NvdqVb2elPi4ZWjefUJrji0fNagrrpaIHx3WXvLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6860

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyNC0wMy0wNCBh
dCAwMzoxMSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyNC0wMy0wMSBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBjbWRxX3BrdF9wb2xsX2FkZHIgZnVuY3Rpb24gdG8gc3VwcG9ydCBDTURRIHVz
ZXIgbWFraW5nDQo+ID4gYW4gaW5zdHJ1Y3Rpb24gZm9yIHBvbGxpbmcgYSBzcGVjaWZpYyBhZGRy
ZXNzIG9mIGhhcmR3YXJlIHJpZ3N0ZXINCj4gPiB0byBjaGVjayB0aGUgdmFsdWUgd2l0aCBvciB3
aXRob3V0IG1hc2suDQo+ID4gDQo+ID4gUE9MTCBpcyBhbiBvbGQgb3BlcmF0aW9uIGluIEdDRSwg
c28gaXQgZG9lcyBub3Qgc3VwcG9ydCBTUFIgYW5kDQo+ID4gQ01EUV9DT0RFX0xPR0lDLiBDTURR
IHVzZXJzIG5lZWQgdG8gdXNlIEdQUiBhbmQgQ01EUV9DT0RFX01BU0sNCj4gPiB0byBtb3ZlIHBv
bGxpbmcgcmVnaXN0ZXIgYWRkcmVzcyB0byBHUFIgdG8gbWFrZSBhbiBpbnN0cnVjdGlvbi4NCj4g
PiBUaGlzIHdpbGwgYmUgZG9uZSBpbiBjbWRxX3BrdF9wb2xsX2FkZHIoKS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMzgN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oICB8IDE2ICsrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCAzYTFlNDdhZDhhNDEuLjJlOWZjOWJiMTE4MyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTEy
LDYgKzEyLDcgQEANCj4gPiAgDQo+ID4gICNkZWZpbmUgQ01EUV9XUklURV9FTkFCTEVfTUFTSwlC
SVQoMCkNCj4gPiAgI2RlZmluZSBDTURRX1BPTExfRU5BQkxFX01BU0sJQklUKDApDQo+ID4gKyNk
ZWZpbmUgQ01EUV9QT0xMX0hJR0hfQUREUl9HUFIJKDE0KQ0KPiANCj4gSSB0aGluayB0aGVyZSBh
cmUgbXVsdGlwbGUgR1BSIGFuZCB5b3UgdXNlICMxNCB0byBzdG9yZSBoaWdoIGFkZHIuIEkNCj4g
d291bGQgbGlrZSB5b3UgdG8gbGlzdCBhbGwgR1BSIGFuZCBkbyBub3QgbGltaXQgdGhlIHVzYWdl
IG9mIGVhY2gNCj4gR1BSLg0KPiBUaGUgcXVlc3Rpb24gaXMsIHdoeSBsaW1pdCAjMTQgdG8gYmUg
aGlnaCBhZGRyPyBJZiB0aGUgR1BSIGlzIHNoYXJlZA0KPiBieQ0KPiBhbGwgdGhyZWFkcywgdGhl
cmUgc2hvdWxkIGJlIGEgbWVjaGFuaXNtIHRvIG1hbmFnZSBHUFIgdXNhZ2UgZm9yDQo+IGNsaWVu
dA0KPiBkcml2ZXIgdG8gYWxsb2NhdGUvZnJlZSBHUFIuDQoNClllcywgdGhlcmUgYXJlIDE2IEdQ
UiwgZnJvbSBHUFJfUjAgfiBHUFJfUjE1IGFuZCB0aGV5IGFyZSBzaGFyZWQgYnkgYWxsDQp0aHJl
YWRzLCBidXQgR1BSX1IwIGFuZCBHUFJfUjEgaXMgdXNlZCBieSBHQ0UgSFcgaXRzZWxmLg0KDQpJ
IHRoaW5rIHVzZXIgbWF5IG5vdCBrbm93IHdoaWNoIEdQUiBpcyBhdmFpbGFibGUsIHNvIEkgdGhp
bmsgQ01EUQ0KZHJpdmVyIHNob3VsZCBtYW5hZ2UgdGhlIHVzYWdlIG9mIEdQUiBpbnN0ZWFkIG9m
IGNvbmZpZ3VyZSBieSB0aGUgdXNlci4NCg0KQ3VycmVudGx5LCB3ZSBvbmx5IHVzZSAxIGRlZGlj
YXRlZCBHUFIgaW4gcG9sbCwgc28gSSBkZWZpbmVkIGl0IGluIENNRFENCmRyaXZlciB0byBtYWtl
IGl0IHNpbXBsZXIuDQoNCj4gDQo+ID4gICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkN
Cj4gPiAgI2RlZmluZSBDTURRX1JFR19UWVBFCQkxDQo+ID4gICNkZWZpbmUgQ01EUV9KVU1QX1JF
TEFUSVZFCTENCj4gPiBAQCAtNDA2LDYgKzQwNyw0MyBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNr
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+IHU4DQo+ID4gc3Vic3lzLA0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0woY21kcV9wa3RfcG9sbF9tYXNrKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRx
X3BrdF9wb2xsX2FkZHIoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkciwgdTMy
DQo+ID4gdmFsdWUsIHUzMiBtYXNrKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVj
dGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArCWludCBlcnI7DQo+ID4gKwl1OCB1c2VfbWFzayA9
IDA7DQo+ID4gKw0KPiA+ICsJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0KPiA+ICsJCWluc3Qub3Ag
PSBDTURRX0NPREVfTUFTSzsNCj4gPiArCQlpbnN0Lm1hc2sgPSB+bWFzazsNCj4gPiArCQllcnIg
PSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICsJCWlmIChlcnIgIT0g
MCkNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArCQl1c2VfbWFzayA9IENNRFFfUE9MTF9FTkFC
TEVfTUFTSzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogUE9MTCBpcyBhbiBv
bGQgb3BlcmF0aW9uIGluIEdDRSBhbmQgaXQgZG9lcyBub3Qgc3VwcG9ydCBTUFINCj4gPiBhbmQg
Q01EUV9DT0RFX0xPR0lDLA0KPiA+ICsJICogc28gaXQgY2FuIG5vdCB1c2UgY21kcV9wa3RfYXNz
aWduIHRvIGtlZXAgcG9sbGluZyByZWdpc3Rlcg0KPiA+IGFkZHJlc3MgdG8gU1BSLg0KPiA+ICsJ
ICogSXQgbmVlZHMgdG8gdXNlIEdQUiBhbmQgQ01EUV9DT0RFX01BU0sgdG8gbW92ZSBwb2xsaW5n
DQo+ID4gcmVnaXN0ZXIgYWRkcmVzcyB0byBHUFIuDQo+ID4gKwkgKi8NCj4gPiArCWluc3Qub3Ag
PSBDTURRX0NPREVfTUFTSzsNCj4gPiArCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiA+
ICsJaW5zdC5zb3AgPSBDTURRX1BPTExfSElHSF9BRERSX0dQUjsNCj4gPiArCWluc3QubWFzayA9
IGFkZHI7DQo+IA0KPiBUaGlzIGlzIGZ1bGwgYWRkcmVzcywgbm90IGhpZ2ggYWRkcmVzcy4gV2h5
IG5hbWUgdGhlIEdQUiB0bw0KPiBDTURRX1BPTExfSElHSF9BRERSX0dQUj8NCj4gDQpNeSBtaXN0
YWtlLCBJJ2xsIHJlbW92ZSB0aGF0ICdISUdIJyB3b3JkLg0KDQo+IFRoZSBhZGRyIGlzIG5vdCBt
YXNrLCBzbyBJIHdvdWxkIGxpa2UgaW5zdC52YWx1ZSA9IGFkZHIuDQoNCk9LLCBJJ2xsIGNoYW5n
ZSBpdC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0K
PiANCg==

