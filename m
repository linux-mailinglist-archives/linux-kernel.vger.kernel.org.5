Return-Path: <linux-kernel+bounces-134003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D689ABF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BA51C20C96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4938DCD;
	Sat,  6 Apr 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bofMx2ls";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="C+hg3PNX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C43BBF5;
	Sat,  6 Apr 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420173; cv=fail; b=U0xeS+VuWIkJY90tbXMma+8PQhFkpzuoALLtqkdgpu5VNJV4g3p5uDwcQF5nwZNubdj4NR64g6eO6TwbK6E1sfNBsd5kXji0cAGTJKaBFC/36ttR4Ip8mrK/bSs8phV8ar9Ny8IWlTCA/R/Bdv77lfEy3c9Ql5f4jBt44+W6sMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420173; c=relaxed/simple;
	bh=J8YfWEZKXCmvJ0+ZHv0LczoQSM+1Z9X5U6Lny1Ic/Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1oQOL2soMXbW+zWyurNnSlS8y93b4wKNQUFUO2D2fbkRgUEz35ML6Zh0fgOmSrEI5l2VcCe8kCt+qMuxIywvUS2FPOKI60TL3uJT5cFoBzGrd0F0Ev4LqTJeTlmiNqXtim7Sz61IRl3XNVmk/m6zILnFbk1WKKyTWcL3dCu+Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bofMx2ls; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=C+hg3PNX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2e188e2f43011eeb8927bc1f75efef4-20240407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J8YfWEZKXCmvJ0+ZHv0LczoQSM+1Z9X5U6Lny1Ic/Dg=;
	b=bofMx2lsOGHBuin7YSqWG1us9s7rhWoM85aBvaO8rtr+4b5xYP+4FzPzjkzfOT3Fzx1s05ng+QpCahsjsEbBjovLI17C6Nq7xocs3v+h0tuQ9NcP2plhVurewFlNV+EOlsT4ItG15mKLqE2V0j7I+FjyajGpVeM64K1pWQejLL4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2dcb7b21-dc2f-4101-a415-b6da91e5ac13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:1ae5c000-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f2e188e2f43011eeb8927bc1f75efef4-20240407
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 448014161; Sun, 07 Apr 2024 00:15:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 7 Apr 2024 00:15:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 7 Apr 2024 00:15:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S11Sp1taBIqFI2SnsBYP16S7OZAM9sklEobU+Ypa6jF+3RYbnpPKc2zZRKvvLkR+mzfx5c0bY+DISEDsRF6j6/N59M4BgJLswVmEZSkSfnny9NahVRjzqZfd/p3OkRAJJyM60m5AiEGDkbBeoScUvL+maUllv0CmJD4BScq1pRFCnkmccqJdm5Vmv7wnUF+T22SdYdk46wm/xRwKTBBWf6hBPCnhjf2S8/3DN5ReTn4h931Go8ZLvsai74i6wcwQuZWLlFh7ykMUfTZmw27INwFQxcD4IrT82lckJ8DqdaD1JxCwY1dSl7sfqR/DB1s3uqpvnHc6eXl9rr6XozX+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8YfWEZKXCmvJ0+ZHv0LczoQSM+1Z9X5U6Lny1Ic/Dg=;
 b=XnADi3EeoPFFl5cSykPMM8sp7JVyrX7bXUWTYFZWQMixh9s/DwO96kFOg68xaPRdGf1Xjv53tslGg38jYqnceCU9HGksLMcabj/zxeJlq4ufBKCYDJabXOCd4lK2QaCQY05OYmCl3l91zHSZYY+nBtY4ZtnBi67nl92iSeATOWTfpJzb3i0p3E61GYXkb0XHvCDTWiJ9YMbHLiiHGwMIGOgwf/BxaO0VT+9UXBMZiXRMAri2WoDWA0j9HQGf2xrspESa0kl5je49wSGSsbFjGz/LfUf0din+anfqdjCOWNEcaORDL0/LzSIM/+3gMvpZLfvUcd8PT7ypN6sMns2hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8YfWEZKXCmvJ0+ZHv0LczoQSM+1Z9X5U6Lny1Ic/Dg=;
 b=C+hg3PNXCApYd432+xi6DSY8h4WHrg3jhhkZI62x2FYJJWFLYx/4zBbYdCOmclEkB905nfw8K7lC0DCbsVDa1TnWYkogPeXnuhUXzhmJNTOMFwqoWfmFDw8OvyuSS9a9aHVJ8gBS68Hywzt2sfdvP0l7VoYuM6/zPnBQLl9LdwQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7453.apcprd03.prod.outlook.com (2603:1096:820:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 16:15:52 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 16:15:51 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Topic: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Index: AQHahbFYn7GUjisJlUGOm/8L6IGNq7FWsNGAgADVnQCAAK2ZAIABjPeAgAAcDYCAAZLzAA==
Date: Sat, 6 Apr 2024 16:15:51 +0000
Message-ID: <f2476233528e18f78cdfa4eb7bc4c5ae91f70db8.camel@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
	 <20240403102602.32155-3-shawn.sung@mediatek.com>
	 <20240403-conflict-detest-717b4175a00c@spud>
	 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
	 <20240404-lankiness-devouring-d4d012b22cb9@spud>
	 <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
	 <20240405-remindful-galley-2dee9eec4f34@spud>
In-Reply-To: <20240405-remindful-galley-2dee9eec4f34@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7453:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXJOf2Q/aCemC0J++QePdvIadMO9wiJdbQpr8Vz594XCllr8xnWwCkIEc0nSPWFFkkiKRwqBtNShFBdfCK7wnHhXwwgFsuvZtWpJzP1Cf+9DSA7xoIhSUQ6iPRKDP6cvYhiUFwKObPjIwOwzhvV/6Kd3xuvDcU8Zr83+E0lqHCuVdrD8qcF+UZqRVHqrSmSBg9lLr6NBSuBfKgFT8gjifpoSYyNaBEpv/DCUjqv4iFPBiGl8CrymLBrO8NgWtLj5ClFS+V1z5kU+Jb4R6/nS/W3+EjjOzGx2H9NJVaHH5HYDFXmIXJNvYCAEKKNSG/hb0IDytK/G9m9L9U8bmoh1H36euwiJUEysWNBi5xB5A9eC/xMIgJ9TSuQ3PKHx8U458tNRKDfJriwJ0meG5xxyB59VN/Kzzq3DYORxDw2LH34895f5nbiheTrjPkh9/zq40ANrXEkodvtB/7CA0j9iZYwt7GVzVOVsl5y6BWmnZT1Ya1B4Iw/9VwcKO2cT4KU78wMxb1dUhGyMYJ1IKVD4NMrd9qkoKb5NwhtQKmbkgaTyaXv8htEnXQ6UKg3YQ3WM/IY8myGs8il0wiezOhJ474bQojnR4He313MOHVIpIYjCX0CTBKE7StI+ZaiAgwmN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZysvZFI2RFRkZ3Z0eU5Ta3BiWll5RFhVcDJMZENCdWdtTlZaNlVtVy9uM2dR?=
 =?utf-8?B?NG13R0V1Rkx2ajFxNTk0dW14czZFT1o3UkxnKzdHWk4rcTNaSUtGcmxtUFdH?=
 =?utf-8?B?WVUyTEZvdnZudVZwZXZjaU5EVzVZeWUxdklNQXVXcjM5Q0Z0ZjY0NFlaaUlB?=
 =?utf-8?B?STdDajlicGkzWjRlTlM4bUJWaEs4aWxxNkhMdEJOUmNnUGRCVFBneHQ1U3ZL?=
 =?utf-8?B?WnMySXo2S25NYnl3NTZpMk9IVnRJejZwUjdQVUl3NDBUbzNob0tHMGxzNXN3?=
 =?utf-8?B?dkNwdmswY1U5ZndRdXNhVVdUTnlDeVorLzByY2Z4T2dwbzgzUkh6c3NaYU9s?=
 =?utf-8?B?b2RMbXRFUFFQbTQraHQyUmhTTkVQWVlySXdNTjVUWnBaMzFnNmYvT3hWcmJH?=
 =?utf-8?B?Z2dlTlYxNHlnL3FSSjdLVjZBUjJhUTg0cmtRVVZJMnkyS1FnRVlxWWZOd0Yw?=
 =?utf-8?B?TWZkTHUwdnl5TTlLcWpnZ01BN050LzB4dDJxU2tFMHVObUlvZ3hnMU9ZVkZD?=
 =?utf-8?B?RG45TnlHdTBlb1lFOTZTd3RVVEtGU0pMRU53dGk4ZFdtajRsYUdEelRVdXRQ?=
 =?utf-8?B?Rm9lNVBTTmN2NE9iVU5jOVliQVkvZjF4YkJZeTM3cW1zdFdWbnU1NWxzYWxQ?=
 =?utf-8?B?dWtEV3ExNW14OEFDNSszclJVTlZ6YTFJQ0lWOCtlcnVlUFViY0M4MVh0S0dz?=
 =?utf-8?B?aGNITFFCeThkSytwbEw3U0l6UklwWUlhcnRtV2tXSFp4VC9LSjdwZlJGRTVE?=
 =?utf-8?B?TUVqY0Fwa3RpV3JMUHhpM004Wjd6MG8wZDloQjMyMFNFaUowUWRvWlpFUWZ5?=
 =?utf-8?B?TkhqV2xrRG5yZlJIK1EwQ3NzMG9nM05YS1orZ0owVHBuWVU2VkZza3dOZkRR?=
 =?utf-8?B?d1czOTdDSmMrenVId1VydTN4d05PWGxKYlNIbDVHeG9NNE9ieWhwYWgyQi81?=
 =?utf-8?B?Rkgya3B4Q09pNkpEWVJGWkZPaFZjRDk1K3A1cVZZTXcyTGltQTI2Z0RzUGN4?=
 =?utf-8?B?MXdBZDZwcXQySnhqbzRUZFJydG1sdFpycE80ZjNvOTJ2ODFrUWx6SDZMTHVS?=
 =?utf-8?B?MlQzN2dyR3BVSFlPSWFnd09xVWhmODBoaFZpRFlnMjZhOHJBZXF4WThQRWky?=
 =?utf-8?B?THRxRUg1aWwrSFUybHdaL0VnTWk0WDRHNlZET0thU200RUFRY0FPc3NHUG45?=
 =?utf-8?B?OUt3NUNRdExwaUlGN04zRU5aRWpRMUEyTFdSNVU0ODMxS1dVRG11UG5oQ2FG?=
 =?utf-8?B?NVhhU1QyTzdYMlgzWGNwNm1nbHFpQUVrTFEwZmhJOGhocnRqaWtwRGFpb0p3?=
 =?utf-8?B?UjZ2eGE1cUdndDlVSUJkZFE3OUJsb0lMOWxrV2lFTmk4MXBjNkQrTEpJRUZL?=
 =?utf-8?B?ZzhiY0JlejhsQkdXOHlPeCt2RUZnMDVrTkdyN0JzR1FwUE1Odi9JN0VIdWdM?=
 =?utf-8?B?R2wwMXdGMEhhOHJjWUpTVFBPVTNsaEVZT2YzeG1vU1Zqc3lhcEtXTVhBcUhl?=
 =?utf-8?B?N3B4YysycTNYdTVlam4wak9GNlczMTBFNlFpaXZWSW5jelR4TFk2UVUxb2V0?=
 =?utf-8?B?ck9ITVRpWGp3Q0Z6b09BUmVOZkFKbXFub2J0VUlaampDQkh0RTExOCtUbVJY?=
 =?utf-8?B?RzYvZ1h2VDkwUzI5cEJ1SVArVHhXN1Q5M0cyditKRkgzbUx6U1JzN3hudVJ6?=
 =?utf-8?B?Y0xlUzRac2VaRGtUMkpER2hUUzhhcHh6RTN5THhhZkw4b0ROWitFMkl4ZWw4?=
 =?utf-8?B?a1daWlJJRHlpM0N1dGtNSkVZbXR6OG1RUzVSTmNTMHVmQ2k4U1FUNGloRHpU?=
 =?utf-8?B?TWlYTU9JVW1jcTZTeGh3QkZUUDBVM3pydkpOTzVsZ25rOFExWWVjWDlYOUlM?=
 =?utf-8?B?TWhZb1BLazhJVStoSDE5U2pKWmd4U0x0ZDhCSTJDNXlUaGMycmI5TFp5VDJW?=
 =?utf-8?B?UzJydzBvRkRwajNPUG80M3M0NGJrbm4zWmZqMjNVajNweGttb0hmUHdFTnBQ?=
 =?utf-8?B?UDFHS09OaStRdWhtMEJRWkVDNjJYMWRzZEJrY2NJbUtiK3FNWWwrczVDTjJE?=
 =?utf-8?B?OHdSa1B3OVdFUS9URXBReStWVElkcU9nL1lLYVYyc3NFdlNhckVvQUhTbHVP?=
 =?utf-8?B?YmpLTUtQMU9XZW1hMkRxZDNORlM5Zm1vWlhmRGNSNXJvK2VsdzVsbGlqcmQw?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20F85947EC7C0E48A36A08950217C4C6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c94d461-4923-4add-8196-08dc5654d41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 16:15:51.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeF6GUrwssJzjj7GCJRGyZLi3UrxuAmuauRNnaX1SjS8H3kg70gO+RtwfFRPZScVzGOepVXCiqhh9InN11z6MOPldizBozZ94de1Qse8BdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7453
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.671600-8.000000
X-TMASE-MatchedRID: TmlY9+XBoTkOwH4pD14DsPHkpkyUphL9fjJOgArMOCao+b+yOP0oGIhF
	En/rCbw6XJHwgBAo9RpK0A62LggjSZTZ9V50RBQ7kkBrUL/4Vy5MkOX0UoduuQKzHKFHzLsJTo+
	d5kYVw/FC/9HFmT0PUY6PfzW2Y7wy0KO5SGxuaaThG1IOMb7PsMnlJe2gk8vIgrAXgr/AjP3j6f
	SiVX5Av1RKMTSTTuSA0Snp7c4pH3fI2RqSAXh33hlckvO1m+Jco4jW7zSDg9k0QmmUihPzrAdFf
	cUpjiwQjmyACjGw3SAtxLD7rfIMruHhSemIhY/OSEQN/D/3cG4hdi6zxllm1s/GMgxfN8H5sJC4
	m2jcjnwjp3MPfX9kRTq5q4U8+01l8RB6c8n4mAqwr5ZZVOw5da6xL0KIHMvxlL1/3IuU47KQKxu
	mdxDYer9bqluIoivMm2VH+qPYoSUFdAziKc3t6bdQIb8hCnY+4+ZcrqvCDkENht78/JfyBD5d5e
	olrj0RrwLdNMRGzZGRk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.671600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D01326C611F4BAFC571BFBF334221256F021C5B3C79D7EFA98416DB824A780832000:8

T24gRnJpLCAyMDI0LTA0LTA1IGF0IDE3OjEzICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgQXByIDA1LCAyMDI0IGF0IDAyOjMzOjE0UE0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjQtMDQtMDQgYXQgMTU6NTIgKzAxMDAs
IENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIFRodSwgQXByIDA0LCAyMDI0IGF0IDA0OjMx
OjA2QU0gKzAwMDAsIEphc29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IEhpIENvbm9yLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0wNC0wMyBhdCAxNjo0NiArMDEwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgQXByIDAzLCAyMDI0IGF0IDA2OjI1
OjU0UE0gKzA4MDAsIFNoYXduIFN1bmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiAiSmFzb24t
SkguTGluIiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gQWRkIG1ib3hlcyB0byBkZWZpbmUgYSBHQ0UgbG9vcHBpbmcgdGhyZWFkIGFzIGEgc2Vj
dXJlIGlycQ0KPiA+ID4gPiA+ID4gaGFuZGxlci4NCj4gPiA+ID4gPiA+IFRoaXMgcHJvcGVydHkg
aXMgb25seSByZXF1aXJlZCBpZiBDTURRIHNlY3VyZSBkcml2ZXIgaXMNCj4gPiA+ID4gPiA+IHN1
cHBvcnRlZC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICAuLi4vYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2Ut
bWFpbGJveC55YW1sICAgICAgICAgfA0KPiA+ID4gPiA+ID4gMTANCj4gPiA+ID4gPiA+ICsrKysr
KysrKysNCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiA+ID4g
PiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gPiA+ID4gPiBtYWlsYm94LnlhbWwN
Cj4gPiA+ID4gPiA+IGluZGV4IGNlZjlkNzYwMTM5ODUuLmMwZDgwY2M3NzA4OTkgMTAwNjQ0DQo+
ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+ID4gPiA+ID4gbWFpbGJveC55YW1sDQo+
ID4gPiA+ID4gPiArKysNCj4gPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+ID4gPiA+ID4gbWFpbGJveC55YW1sDQo+
ID4gPiA+ID4gPiBAQCAtNDksNiArNDksMTYgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ICAg
ICAgaXRlbXM6DQo+ID4gPiA+ID4gPiAgICAgICAgLSBjb25zdDogZ2NlDQo+ID4gPiA+ID4gPiAg
DQo+ID4gPiA+ID4gPiArICBtZWRpYXRlayxnY2UtZXZlbnRzOg0KPiA+ID4gPiA+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiA+ID4gPiA+ICsgICAgICBUaGUgZXZlbnQgaWQgd2hpY2ggaXMgbWFw
cGluZyB0byB0aGUgc3BlY2lmaWMNCj4gPiA+ID4gPiA+IGhhcmR3YXJlDQo+ID4gPiA+ID4gPiBl
dmVudA0KPiA+ID4gPiA+ID4gc2lnbmFsDQo+ID4gPiA+ID4gPiArICAgICAgdG8gZ2NlLiBUaGUg
ZXZlbnQgaWQgaXMgZGVmaW5lZCBpbiB0aGUgZ2NlIGhlYWRlcg0KPiA+ID4gPiA+ID4gKyAgICAg
IGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlLzxjaGlwPi1nY2UuaCBvZiBlYWNoIGNoaXBzLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IE1pc3NpbmcgYW55IGluZm8gaGVyZSBhYm91dCB3aGVuIHRoaXMg
c2hvdWxkIGJlIHVzZWQsIGhpbnQgLQ0KPiA+ID4gPiA+IHlvdQ0KPiA+ID4gPiA+IGhhdmUNCj4g
PiA+ID4gPiBpdA0KPiA+ID4gPiA+IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyLWFycmF5aQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoeSBpcyB0aGUgSUQgdXNlZCBi
eSB0aGUgQ01EUSBzZXJ2aWNlIG5vdCBmaXhlZCBmb3IgZWFjaA0KPiA+ID4gPiA+IFNvQz8NCj4g
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEkgZm9yZ290IHRvIHN5bmMgd2l0aCBTaGF3biBh
Ym91dCB0aGlzOg0KPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMjQw
MTE0NTkuMTIyMDQtMS1qYXNvbi0NCj4gPiA+ID4gamgubGluQG1lZGlhdGVrLmNvbQ0KPiA+ID4g
PiANCj4gPiA+ID4gSSdsbCBmaXggaXQgYXQgdGhlIG5leHQgdmVyc2lvbi4NCj4gPiA+IA0KPiA+
ID4gV2hlbiBJIHNheSAiZml4ZWQiIEkgZG9uJ3QgbWVhbiAidGhpcyBpcyB3cm9uZywgcGxlYXNl
IGZpeCBpdCIsIEkNCj4gPiA+IG1lYW4NCj4gPiA+ICJ3aHkgaXMgdGhlIHZhbHVlIG5vdCBzdGF0
aWMgZm9yIGEgcGFydGljdWxhciBTb0MiLiBUaGlzIG5lZWRzIHRvDQo+ID4gPiBiZQ0KPiA+ID4g
ZXhwbGFpbmVkIGluIHRoZSBwYXRjaCAoYW5kIHRoZSBkZXNjcmlwdGlvbiBmb3IgdGhlIGV2ZW50
IGhlcmUNCj4gPiA+IG5lZWRzDQo+ID4gPiB0bw0KPiA+ID4gZXhwbGFpbiB3aGF0IHRoZSBnY2Ut
bWFpbGJveCBpcyByZXNlcnZpbmcgYW4gZXZlbnQgZm9yKS4NCj4gPiA+IA0KPiA+IA0KPiA+IE9o
LCBJIHNlZS4gVGhhbmtzIGZvciBub3RpY2luZyBtZS4NCj4gPiANCj4gPiBXZSBkbyB3YW50IHRv
IHJlc2VydmUgYSBzdGF0aWMgZXZlbnQgSUQgZm9yIGdjZS1tYWlsYm94IHRvDQo+ID4gZGlmZmVy
ZW50DQo+ID4gU29Dcy4gVGhlcmUgYXJlIDIgbWFpbmx5IHJlYXNvbnMgdG8gd2h5IHdlIHNldCBp
dCBpbiBEVFM6DQo+ID4gMS4gVGhlcmUgYXJlIDEwMjQgZXZlbnRzIElEcyBmb3IgR0NFIHRvIHVz
ZSB0byBleGVjdXRlIGluc3RydWN0aW9ucw0KPiA+IGluDQo+ID4gdGhlIHNwZWNpZmljIGV2ZW50
IGhhcHBlbmVkLiBUaGVzZSBldmVudHMgY291bGQgYmUgc2lnbmFsZWQgYnkgSFcNCj4gPiBvciBT
Vw0KPiA+IGFuZCB0aGVpciB2YWx1ZSB3b3VsZCBiZSBkaWZmZXJlbnQgaW4gZGlmZmVyZW50IFNv
QyBiZWNhdXNlIG9mIEhXDQo+ID4gZXZlbnQNCj4gPiBJRHMgZGlzdHJpYnV0aW9uIHJhbmdlIGZy
b20gMCB0byAxMDIzLg0KPiA+IElmIHdlIHNldCBhIHN0YXRpYyBldmVudCBJRDogODU1IGZvciBt
dDgxODgsIGl0IG1pZ2h0IGJlIGNvbmZsaWN0DQo+ID4gdGhlDQo+ID4gZXZlbnQgSUQgb3JpZ2lu
YWwgc2V0IGluIG10ODE5NS4NCj4gDQo+IFRoYXQncyBub3QgYSBwcm9ibGVtLCB3ZSBoYXZlIGNv
bXBhdGlibGVzIGZvciB0aGlzIHB1cnBvc2UuDQoNCkkgYWdyZWUgdGhhdCBjb21wYXRpYmxlcyBj
YW4gZG8gdGhlIHNhbWUgdGhpbmdzLg0KDQo+IA0KPiA+IDIuIElmIHdlIGRlZmluZWQgdGhlIGV2
ZW50IElEIGluIERUUywgd2UgbWlnaHQga25vdyBob3cgbWFueSBTVyBvcg0KPiA+IEhXDQo+ID4g
ZXZlbnQgSURzIGFyZSB1c2VkLg0KPiA+IElmIHNvbWVvbmUgd2FudHMgdG8gdXNlIGEgbmV3IGV2
ZW50IElEIGZvciBhIG5ldyBmZWF0dXJlLCB0aGV5DQo+ID4gY291bGQNCj4gPiBmaW5kIG91dCB0
aGUgdXNlZCBldmVudCBJRHMgaW4gRFRTIGVhc2lseSBhbmQgYXZvaWQgdGhlIGV2ZW50IElEDQo+
ID4gY29uZmxpY3RpbmcuDQo+IA0KPiBBcmUgdGhlIGV2ZW50IElEcyBub3QgZG9jdW1lbnRlZCBp
biB0aGUgcmVmZXJlbmNlIG1hbnVhbCBmb3IgdGhlIFNvQw0KPiBpbg0KPiBxdWVzdGlvbj8gT3Ig
aW4gZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHNlY3VyZSB3b3JsZCBmb3IgdGhlc2UgZGV2aWNlcz8N
Cj4gQQ0KPiBEVFMgc2hvdWxkIG5vdCBiZSB0aGUgYXV0aG9yaXRpdmUgc291cmNlIGZvciB0aGlz
IGluZm9ybWF0aW9uIGZvcg0KPiBkZXZlbG9wZXJzLg0KPiANClRoZSBldmVudCBJRHMgd2VyZSBk
ZWZpbmVkIGluOg0KaW5jdWxkZS9kdC1iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLG10ODE4OC1n
Y2UuaC4NCg0KPiBBZGRpdGlvbmFsbHksIHRoZSBkcml2ZXIgY291bGQgdmVyeSBlYXNpbHkgZGV0
ZWN0IGlmIHNvbWVvbmUgZG9lcw0KPiBoYXBwZW4NCj4gdG8gcHV0IGluIHRoZSByZXNlcnZlZCBJ
RC4gVGhhdCBjb3VsZCBiZSBnZW5lcmljYWxseSB1c2VmdWwgKElPVywNCj4gY2hlY2sNCj4gYWxs
IG9mIHRoZW0gZm9yIHJlLXVzZSkgaWYgdGhlIElEIGFyZSB0byBub3QgYWxsb3dlZCB0byBiZSBz
aGFyZWQuDQo+IA0KPiA+IFRoZSByZWFzb24gd2h5IHdlIGRlZmluZSBhIGV2ZW50IElEIGlzIHdl
IHdhbnQgdG8gZ2V0IGEgU1cgc2lnbmFsDQo+ID4gZnJvbQ0KPiA+IHNlY3VyZSB3b3JsZC4gV2Ug
ZGVzaWduIGEgR0NFIGxvb3BpbmcgdGhyZWFkIGluIGdjZS1tYWlsYm94IGRyaXZlcg0KPiA+IHRv
DQo+ID4gd2FpdCBmb3IgdGhlIEdDRSBleGVjdXRlIGRvbmUgZXZlbnQgZm9yIGVhY2ggY21kcSBz
ZWN1cmUgcGFja2V0cw0KPiA+IGZyb20NCj4gPiBzZWN1cmUgd29ybGQuDQo+IA0KPiBUaGlzIHNv
cnQgb2YgaW5mb3JtYXRpb24gbmVlZHMgdG8gYmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBidXQg
SQ0KPiBkb24ndA0KPiB0aGluayB0aGlzIHByb3BlcnR5IGlzIG5lZWRlZCBhdCBhbGwgc2luY2Ug
aXQgc2VlbXMgdG8gYmUgc29tZXRoaW5nDQo+IGRldGVjdGFibGUgZnJvbSB0aGUgY29tcGF0aWJs
ZS4NCg0KSSB0aGluayBwdXQgdGhpcyBldmVudCBJRCBpbiBkcml2ZXIgZGF0YSBhbmQgZGlzdGlu
Z3Vpc2ggdGhlbSBieQ0KZGlmZmVyZW50IGNvbXBhdGlibGVzIGNhbiBhY2hpZXZlIHRoZSBzYW1l
IHRoaW5nLg0KDQpIb3dldmVyLCBJIG9yaWdpbmFsbHkgdGhvdWdodCB0aGF0IGFsaWduIHRvIHRo
ZSBleGlzdGluZyB3YXkgbGlrZQ0KTVVURVgsIENDT1JSLCBXRE1BIGluIA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwMTI0MDExNDU5LjEyMjA0LTQtamFzb24tamgubGluQG1lZGlh
dGVrLmNvbQ0KIHdvdWxkIGJlIGJldHRlciBjaG9pY2UuDQpJIHRoaW5rIHRoZWlyIHVzYWdlIG9m
IGdjZS1ldmVudHMgYXJlIHRoZSBzYW1lLiANCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNClJlZ2Fy
ZHMsDQpKYXNvbi1KSC5MaW4NCg==

