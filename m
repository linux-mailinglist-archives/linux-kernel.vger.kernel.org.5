Return-Path: <linux-kernel+bounces-167259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9818BA69F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00CD1C21AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABC139599;
	Fri,  3 May 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pery2mmG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ia9PIOT8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9391C69D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714180; cv=fail; b=aWsVbNMmWaiMpyhM88zL6OeTT8Mv3q3Lx0rt/igGVls0ScsrQHdTncnly+5xn9aMvF4L38Pbf5cuMzTS6SHKpsdWZozMd74mBAstUDsDDAvJpmYdUejj+OE/+bErxXv5WHCXRy4YL+mfud9Xq1pbW/iR57FVjgee68CWdzK10PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714180; c=relaxed/simple;
	bh=kXaBgYgenpBbk4tHuVYf0WU5BJDSW96QbcjaajCNPp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ws+qcQH1zU+WWajaQBg65HqPkFfbLhwl9XPGWM+NPuFpyK5lrAHY8gLH1GBivphX+YVf9YC1sgXgMOeiTj8XYYnE3OgZSYIwW/LgM7wgz51PO+CXFidU3qbx7qMuX/mARML3nqQd976gq2+stW6otUy/lLUsTNO180Ymhyp4bD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pery2mmG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ia9PIOT8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ce28352090e11ef8065b7b53f7091ad-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kXaBgYgenpBbk4tHuVYf0WU5BJDSW96QbcjaajCNPp4=;
	b=pery2mmG3ownoa0ethhGG7yF2N8EDNuhHnJQqqcrwJHxypfkw7+nmiqAUIkzh2hu7ZYbYCXamnivSis/5R5YK6kc5Xy2PO/G0ELoLJRTT5XMpFp4S+zhtw5LNieLbYs5fdH2AvQrdd2mAbwhGCBOsxfpI68Cp7tpNleRUUwsr/g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ff5fd8c3-40a0-43bc-bc13-0b754308ef72,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:87cea2fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1ce28352090e11ef8065b7b53f7091ad-20240503
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 84144269; Fri, 03 May 2024 13:29:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 13:29:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 13:29:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMBBMMDbARNf8TAPvsJDZZwoSwkmhnL6tKHjfeCSHdkMiB9pk2FTa2tjkK1NF86uw5k97m9v5wEvwsrWRCwCekT6tTxkeD1Dy0ojL5QAwc2N8ChIbYcAsznzXlPM700gwJQQeowx5nBFd86qoAyhKXcaVyCP2vuiBoG5nwP4H2TTY5udbrpqCEu0W+NPAV6jbwDqTIxYG8kqioTwkmPKUqFQiafcPrLDeLpXTKs17Z4HPqVnLyQxFKybp+kW2rL5ss6zPM40d1bWB8VjVamMAXbJJqa1Qwhnz5YtW+yWjSvGAJ0hEMq3uD09gbWPKsjJbNJdrWWPFv812rU/aef39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXaBgYgenpBbk4tHuVYf0WU5BJDSW96QbcjaajCNPp4=;
 b=KqWfkm9664IWeyXkf9w049fUu1O81a+xf7V2ItjcUhGke2xQRW5HWWLvdrHQSx5Wcby4iW5KPo+lzD96hKp9yOiZkZDbiQ6sJLZAsuQhSKIBVsEoZ1fY+m9a5KFn5Ti3N0cQk+8hVRgBVp7GcEPH2tcFk+OjjH13GUSpn3gGBpsxsuOM095JxlXpmAw6X5K2calLZhhgVohrzR5LHD/1lGMeoSN93jxWmnJBmzr10q2aEn0zHG0GrpbXwG3IvFkjBQg+PDHbIc18gJ0rNNuBDIiz+M7g6XBcVxnepAxe8SAKI6UkCMKn37kOtp6NgTPsVbMyk1StjiTMULsIv/41Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXaBgYgenpBbk4tHuVYf0WU5BJDSW96QbcjaajCNPp4=;
 b=ia9PIOT8ZrvBPmOxMwXaee41YQrqo12dcPvkeBe4xa/iiLv47C/Xdqb9JlKsG2PG5v9o2SdH2FpnQvhgObiecgSm3GMzig6xHa8mG2l0t6NUXshxHc7LDvR/e4V3ygPC2E2bSMd8xbkACjSYyDD0mOEXIn1pyiNaNIK51hGg+ZQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8439.apcprd03.prod.outlook.com (2603:1096:405:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 05:29:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 05:29:25 +0000
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
Subject: Re: [PATCH v7 09/18] drm/mediatek: Support constant blending in OVL
Thread-Topic: [PATCH v7 09/18] drm/mediatek: Support constant blending in OVL
Thread-Index: AQHanH0LihYW7HR1qEKfMRscOmQkPrGE/L6A
Date: Fri, 3 May 2024 05:29:25 +0000
Message-ID: <d96ba0780c8b42257b0a60b4878e4cf229536de8.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-10-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8439:EE_
x-ms-office365-filtering-correlation-id: 3381e0b5-dd44-4ae2-8470-08dc6b31ff32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Nnk5a3FEQTVjU0dMcjhtY0ZrQjZzTzhxU3AvVjA0WGFmQ01YK01JakVlYTdu?=
 =?utf-8?B?aVZiVEdRdytlYXF6VUNYbjhpN2lvSFhCT2F1L09sWWxkMDFDNGY4VFh1ZlNY?=
 =?utf-8?B?K0g3NU10L3BJTW9MTGxLOUZ5MWNYRENKaS9tSWk5UzBUZEIxbVNkMUNkaU5Z?=
 =?utf-8?B?aXNwY0l3UHJzVnhwVEtmZFhYbzhOcUY1Tk9mZ0FCTUJDTythK2xxV0F6ZnBD?=
 =?utf-8?B?WWlNczBGRTkyc3RjdzB6YlNldlA2YlZTL2VhTmpaUiszVkxwK0htLzd4K1kr?=
 =?utf-8?B?OVBZdnhwRU9kWkFGSmEwa2tBTkZZcmtkc3FBa3ZISVBBY0txRlgxeldVVGJ0?=
 =?utf-8?B?SGFYNElDMExBV2RPUnZoeTliZG1vN25PekE4NzdlMVA0ZXhaVlc4Tm9EOEZp?=
 =?utf-8?B?ZVgwTG1nSk5RdXJ1Z1o5SXYvdm9TUzN3aEUzUzJGVmVza2Q0bnpQZTJQanRZ?=
 =?utf-8?B?KzVJc0htVHN3RjZEbWFsZlMrRitPaFdTSlIva2J3MStiSU9FUndhQmhvZnZn?=
 =?utf-8?B?Yk1KZURjQU9OYWkxcVRuS2o2NmowUHlLWUFsUUxVUy9aYVpzbUU5eVJlQUNx?=
 =?utf-8?B?OWsvQTJBMVRFUmNFWkFZVU9KYzJ2VmUxNHo2WXZlY3ZsY3NQTTBENnJzSHQw?=
 =?utf-8?B?T3B4THh6UXdCMEY1OTdtRytnSFZiWXlZYTYxYlBZVU53NHhLSjlHNVlsbEhz?=
 =?utf-8?B?RDF5VGFBczU0V1Nvd294dnhraG5tVGM5VU12enJFUG9MUVVPREJKcitkVXU1?=
 =?utf-8?B?aUp3TW8zK2JJS2hWUVJTUEc3NWROT1BPWFpHeVI3eE03OW5GQ2hHR3V3Vnkw?=
 =?utf-8?B?cVNGUEkyclRiNzZ4a1oyeEt5emtTeS9OanJsMXlkVm1tdHdRQStKSk85Qm8y?=
 =?utf-8?B?NUIvd3ZkSm9pcXBOdDJkcWs0WG5JeVdSVHcvcGdIUGdoZzRNaVZ1SFdMZTJG?=
 =?utf-8?B?dTBJSU5qRk1XM3lOUjVBMXZUaFJOdDFQSWhMK0l2eXN4c0ZQN3FXR0NXVTlw?=
 =?utf-8?B?MUpVUlRqR05PQkJIdjhIbUVuNDJDTUdIbUlLSHJGdC9MbmVUd0dHNVk5Sm9T?=
 =?utf-8?B?UjJ3eXFDSVN4ZFlJZmRKTy9ka3c0UU1CTU9iTHI0a0txWC9ZQkZ2bko4SndL?=
 =?utf-8?B?UVVEZ044UW9QV1I1RnZrSWJhN3NMYzFnNTlSaXVwTXBlaFFpWDN6SVBtVWJE?=
 =?utf-8?B?RHNVK2lBR29TcXN6blpIKzg1YTRBeWVrUU05RjBIMUV5eEJKSW9jN09md2ZB?=
 =?utf-8?B?Mzl5NjRucWN1V3pBYkw5VGtyOVVGbkx5amJ1RG1QOCtNUlArSTVmWmxZUks1?=
 =?utf-8?B?SmhmaUVKZTBQMFhCQUFYZllId2tZS3BRbnJTNG9hT1NDOEVucU1OcDNuUUZO?=
 =?utf-8?B?cUxnWkNkZW53UDFFK0xMK1l1NDNCY3pFd0dlMXNMVG5GamFvZnYzU08yeldn?=
 =?utf-8?B?YlVSTUY0MGZTUlBhMWFzNWE2YlRjd0tSSVpSeFVOUXIxeUViNUtQaGJOdUdt?=
 =?utf-8?B?TklCbDlaVXNGTkVWSTZkMXVDVHVrUkFDM3p6L0RGN3lBa21mQnB5bkR0ZWZV?=
 =?utf-8?B?N2JZK1oyY09jRFNhZUdkZW50ajQxTit3amdRVkNtN2ROakRBbTV6QVNDZi9R?=
 =?utf-8?B?OTlhdGd4djJMZUtGYkd6RG5xYkwzQmJOeE13QnpYTWdFVVNTRXNSRE5jc1Rz?=
 =?utf-8?B?cDlEMXhsT0ZENm5qckVFMElsOG5IbnI4SnhkUEtwUjhCMDMvSWNkM1JRNjBR?=
 =?utf-8?B?SmJoQjJUMTdyUExQRmN5VHpxU3N2MHNlV25OVDRldForSG9leWpLaWI4djh5?=
 =?utf-8?B?bW5FUi9oY21tVlh1Z3ZIZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjE1OUVzaGhjQWVObHhLK01wazhnWFJSeStVWWwwenJlMVFUOUpuTEk0VTV5?=
 =?utf-8?B?T0lzSTNocnk2Nmx1T2VWY1JJeTVYMHlHbk1JTFhRMWxHblZsTzR0bnB1b1Ey?=
 =?utf-8?B?RkxXQUNtV1huaFU1cjBtTzZyc3NVYU03YTVBRlJZS0JCR3FMYXYxNzBVS3Bh?=
 =?utf-8?B?azZHYmJPaVd0c0xaMkdGcGZEYlE3ZWdhT3ZVS01wQzZKQXdrY2ZqZEdQNm5K?=
 =?utf-8?B?bU95YWh3MENOTmM4NjVCVklZdXQ1T0pMMzE2TExwUnNLQ09RTVhzTk5TVERS?=
 =?utf-8?B?RER3L0ZUSk5zekhWMjk3RHFoTG9iK1Q3RGhYYzRTVy80TGZwUFhkQTJCR3Zv?=
 =?utf-8?B?Y2RGV2t3ZkRzU2ZlYlFxT1lUU3Z3a3pmNi9SOVVkUHN4VDdGT3pOcDB2L2dI?=
 =?utf-8?B?dkZBTnhqWTlmbjR2WFNUVStCTnoySHljcHcyK1ZBYm1EV3BjREtiVHRKb2pT?=
 =?utf-8?B?dEdITStvV3QyYmlNSk1PR3pTVkl6cmRqWDZFVTVoTWczVnNWaW1QdTFFUnNR?=
 =?utf-8?B?eW9JMW1idGpWdWZCUmVFVDNkdEthYXpIeGYyZklkQk5wZWxyQjNHWXdEQmdj?=
 =?utf-8?B?R1RoR2JHVGR2TTlRZDBrMTVBS2R4clNIWmN3YjhtVkZxRnArWjJQT2VpYTc0?=
 =?utf-8?B?QldUbzNpZUJIUEJzRmdqL2hQdGRaR1ZEb2ZKVngxYVBrYWJOVm9RVnlpbHAv?=
 =?utf-8?B?NGxyTUtFSys3N1JUeWtmdEVURWdseFNESkpXTEtGSnVYcm9tdDhEQkMybENl?=
 =?utf-8?B?N3FjRTJIWkk3TWdoeW9wMmI3azRjakp1T09NYUh5WWZyRU5YWFVla0ZNLzlV?=
 =?utf-8?B?L2tCZERhc3Z6ZHNORWJzN0YyQ0RHSTU2R1NsS2FXL1VocjhGOUtNeGMxSWk1?=
 =?utf-8?B?NW5MWlI0ak5MR0RabUJqUC9jQnUwOE5pZjdFbW1LdmoySU90RGxQZHhzRnE0?=
 =?utf-8?B?SVFPQUVyTWtVMXRqMEZLMFovaEVoNlVuWUpIeitlUnBTdEd3YjZ2MjNUc1FK?=
 =?utf-8?B?SUN4aTkyd3hRVmRVazh3WE5jcFZsTjRya0hzS2tqR0ZjdkV4eFlFY3VtK3Z2?=
 =?utf-8?B?NzR3RC9od1JvYzVwVyt3bEJMWXZQZkdJQ2IvQUdSckJ6TDducjJ1U0JmSk9v?=
 =?utf-8?B?TWw5YmpUa2dJc21UVFZlRWQ0TEVVZDhFSmNxZ2lJM2FXMTIxQmhxa1dFYjlw?=
 =?utf-8?B?QzkvQXhOb1hLQm9qUG84bjYxUTlPdmxwdjhXWjJ1Q09EUldBK2lzdVpxdTFJ?=
 =?utf-8?B?VDU3eWtTa2FXM2MzZ05Ud0h2dExZSmJlZThTUmo0azNsaXZRSy95NDlLdUts?=
 =?utf-8?B?KzcyV0hWczJtU21uTGRVQ2RPbi9IRU5zV2pUc1M4UGx1a2dBQStuSW9PdWNK?=
 =?utf-8?B?aTlJOVZqWVlSYmRkUDRGdytvTFpHbTY0eFVwajlGSlI0TjFOWkUxNC9JSUR4?=
 =?utf-8?B?NGMzSnJLK2E1SE85SWN5Qjc3UWMxVHZPS0s1cHVjSitzQzRnb2NnUWs4Mk5W?=
 =?utf-8?B?QVVKdjVMOWMwNFJzRStuM1BnNWpyWElHMHBLUnpWVTlPM2x4dzhjKzRNa0lz?=
 =?utf-8?B?UjM1SE5oMmltUTE1RUFCL01jbmJIYitDUk5zcjBaWUJqYWYzWTZXbjZ5MWQ2?=
 =?utf-8?B?WXNsU2cxMmhWTm9rVkhzZkU0L3JMWG9QSjVsOXEyelQvemRmVitENW1HZlhM?=
 =?utf-8?B?VE85b0ZPdy9jelh5NFZ2WGh6Mk5wb3UvSDRGa1VoYVhrdElkbm9PTVZ1cG4r?=
 =?utf-8?B?SlRKampkWDRwVHVrQUlwNytGSHhwc3JQT0k0K0VBbXVRQklST0pyVExydXN0?=
 =?utf-8?B?cTNoUTNmamphWXZzd3hrdjRFSzh6VHVGWXpMNmFYalU1YlBzTS9rY2wrTExr?=
 =?utf-8?B?RUFLckVDbXVsekR5OTgybnd3cmYzTmJUeEhINU5zK0xDZkJQWnFLajNkT2Ns?=
 =?utf-8?B?Uk5XR3JXa2pxZDBrTUpidW9hUDdXeEF4NVV0dzBIMlpwOW8rdWF2NjF0OXdK?=
 =?utf-8?B?V0FxWXo2OC9Dckd1UEpsM0tHN1ZuUEY1bTd0d3R5aWJ6Z1FidG8xRmtzVHZ2?=
 =?utf-8?B?clh2T24xQWVNeVdkczlqZCtqd3A5U3MyazY0QVh4aXV6Q2lTaW1kSDk1b1RW?=
 =?utf-8?Q?K94btZktWYNltQHFasFbcBTXv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B1BDF8A4000A74B8E7AE70D58EDA604@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381e0b5-dd44-4ae2-8470-08dc6b31ff32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 05:29:25.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0TA5rfRFuZTioCUjESubomPyS3BSlKP8FBnivATkDHsPrX7cvZ2qxRRKC3Ws6W7K+hyl+tyGbz45Lm+FGKAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8439

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTg6MzggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCBjb25zdGFudCBhbHBoYSBibGVuZGluZyBpbiBPVkwuDQoNCldo
YXQgaXMgY29uc3RhbnQgYWxwaGE/IEkgc2VhcmNoIGluIHdpa2lwZWRpYSBidXQgZmluZCBub3Ro
aW5nIGFib3V0DQpjb25zdGFudCBhbHBoYS4gVGhpcyBpcyBub3QgYSBjb21tb24gdGVybSwgc28g
ZXhwbGFpbiBpdC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFv
IENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDkgKysrKysrKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCA3MzgyNDRhNjE2NGU4Li5l
NDFmZDgzZTM2ZTc5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+IEBAIC0zOCw2ICszOCw3IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSF9N
U0IobikJCSgweDAwNDAgKyAweDIwICogKG4pKQ0KPiAgI2RlZmluZSBPVkxfUElUQ0hfTVNCXzJO
RF9TVUJCVUYJCQlCSVQoMTYpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSChuKQkJCSgw
eDAwNDQgKyAweDIwDQo+ICogKG4pKQ0KPiArI2RlZmluZSBPVkxfQ09OU1RfQkxFTkQJCQkJCUJJ
VCgyOCkNCj4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JETUFfQ1RSTChuKQkJKDB4MDBjMCArIDB4
MjAgKiAobikpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9SRE1BX0dNQyhuKQkJKDB4MDBjOCAr
IDB4MjAgKiAobikpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSX01UMjcwMQkJMHgwMDQw
DQo+IEBAIC00MjgsNiArNDI5LDcgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJdW5zaWduZWQgaW50IGZtdCA9
IHBlbmRpbmctPmZvcm1hdDsNCj4gIAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnkg
PDwgMTYpIHwgcGVuZGluZy0+eDsNCj4gIAl1bnNpZ25lZCBpbnQgc3JjX3NpemUgPSAocGVuZGlu
Zy0+aGVpZ2h0IDw8IDE2KSB8IHBlbmRpbmctDQo+ID53aWR0aDsNCj4gKwl1bnNpZ25lZCBpbnQg
aWdub3JlX3BpeGVsX2FscGhhID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQgY29uOw0KPiAgCWJvb2wg
aXNfYWZiYyA9IHBlbmRpbmctPm1vZGlmaWVyICE9IERSTV9GT1JNQVRfTU9EX0xJTkVBUjsNCj4g
IAl1bmlvbiBvdmVybGF5X3BpdGNoIHsNCj4gQEAgLTQ0OSw2ICs0NTEsOSBAQCB2b2lkIG10a19v
dmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdW5zaWduZWQgaW50IGlkeCwN
Cj4gIAlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2Fs
cGhhKQ0KPiAgCQljb24gfD0gT1ZMX0NPTl9BRU4gfCBPVkxfQ09OX0FMUEhBOw0KPiAgDQo+ICsJ
aWYgKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEp
DQo+ICsJCWlnbm9yZV9waXhlbF9hbHBoYSA9IE9WTF9DT05TVF9CTEVORDsNCj4gKw0KPiAgCWlm
IChwZW5kaW5nLT5yb3RhdGlvbiAmIERSTV9NT0RFX1JFRkxFQ1RfWSkgew0KPiAgCQljb24gfD0g
T1ZMX0NPTl9WSVJUX0ZMSVA7DQo+ICAJCWFkZHIgKz0gKHBlbmRpbmctPmhlaWdodCAtIDEpICog
cGVuZGluZy0+cGl0Y2g7DQo+IEBAIC00NjQsOCArNDY5LDggQEAgdm9pZCBtdGtfb3ZsX2xheWVy
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICANCj4g
IAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGNvbiwgJm92bC0+Y21kcV9yZWcsIG92
bC0+cmVncywNCj4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9DT04oaWR4KSk7DQo+IC0JbXRrX2Rk
cF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBvdmVybGF5X3BpdGNoLnNwbGl0X3BpdGNoLmxzYiwN
Cj4gJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gLQkJCSAgICAgIERJU1BfUkVHX09WTF9Q
SVRDSChpZHgpKTsNCj4gKwltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG92ZXJsYXlf
cGl0Y2guc3BsaXRfcGl0Y2gubHNiIHwNCj4gaWdub3JlX3BpeGVsX2FscGhhLA0KPiArCQkJICAg
ICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gRElTUF9SRUdfT1ZMX1BJVENIKGlkeCkp
Ow0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgc3JjX3NpemUsICZvdmwtPmNt
ZHFfcmVnLCBvdmwtDQo+ID5yZWdzLA0KPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX1NSQ19TSVpF
KGlkeCkpOw0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb2Zmc2V0LCAmb3Zs
LT5jbWRxX3JlZywgb3ZsLQ0KPiA+cmVncywNCg==

