Return-Path: <linux-kernel+bounces-122487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CF88F861
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECE71F26C95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22B50A7E;
	Thu, 28 Mar 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WhwpL+i8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jhy8RZYt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEB22337;
	Thu, 28 Mar 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609434; cv=fail; b=MgR5u3mfw0bAJx6joCLX4wvLCpRzZpdoIsy4SGsPwoIGCpQDlHklGW7KigrND/AsDJqAJGaVwPQlTdCoVmMsHGrTtA6WtYuR+GWkDjt1GqNR3xiihZPBfmcoppkrKdwGWjXQW5CwQ1JVRtduI7D5LRB32K3LpMgWKh0l22xJuSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609434; c=relaxed/simple;
	bh=dpXqhdcs1vgUcDTcs4VQsPGsrUbiPYJUHMuqwqzpO7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VN/HlN7jJfGDwOsGvX1HEeSV/tc+q5ei1NY2Qdf94ubOhvkXdm2f6k81y/7EM05HhkLztioY1rg6cx1GNQ9cgABnmiW9z71tEGnkABSQVTWkHr0R1qbTmVo1zBx9lVPAiOLnPf+DYGuLkrV3OPIglKB4GJyYBUK3vMBRnqwI0xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WhwpL+i8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jhy8RZYt; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f5278c8ecd111ee935d6952f98a51a9-20240328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dpXqhdcs1vgUcDTcs4VQsPGsrUbiPYJUHMuqwqzpO7o=;
	b=WhwpL+i8btoWg+2UpdTBYFipZUdH0aHMrnzu/3g0NpG8nzvY7AmBscsnwwzRFlEeWB7LiGExIOBfQ2OfTML0CxEhuKptWuCkH3ZQy1aTsPW8DFuXrkSmKcGmOJyHpU5SaJ1I0Hfjte34E4W86J4fHlZ1nmIGHhB8jRmeujgHV50=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0e89dcae-f6f5-469e-8584-c088c50e5b05,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c3578885-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f5278c8ecd111ee935d6952f98a51a9-20240328
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 391405820; Thu, 28 Mar 2024 15:03:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Mar 2024 15:03:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Mar 2024 15:03:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUiQqmTY0CAVm3mOar/JpRxhrJoz+8luBaQ5v7BSP5Qgbvb7lsm1dnVxozvbscsrT12YPAH1iVAiZfPbL67ENx5QF+mdRL6BcDLp6K+Sl2Xtvv3fCnFzHTn4oDdvJ0cgrde87bTK9NXUdGIYBHfySoUeNgdeiP2S4V0+dM1y6Y9RVzwFWz+3WMVXnWhTBAb03RdVaHzw3G6WX1M0QVOtu5JXJKm2fl2gbLRryQUrg9BlLcKRZoHOPgzsCXi4v84Rg4a5NB7ei8lQCcCCOid24V+brt8nExUBHkV/z+7ZtUUJZ4dxqthm4yLYX+fujJ9qbWYxn1Q4aIyLQXV41RhrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpXqhdcs1vgUcDTcs4VQsPGsrUbiPYJUHMuqwqzpO7o=;
 b=VoVM2luTOJaOBA08LVlA/zQgg5DaDh4B8xpKAltXC9+PJtsedN8C5MW/EXpmTe/f0/I1svf2Ac2yhgP1GwbKBx5SNjp2XtJbdXLPIrdL1K2pFPbNgZYIS1q26fpxY1jXvhB6Wy1S0urTeGoXolIEQTAdp33ZCzLkd7kcMWQPOXUhbn2QRjOdUz97PVGp59wBMAqc73On+/eEeQ+1jFS0zXJAsLQRQyurupUoQlQQtidoIPvG+Pspb2nLCXdHCGt51GnSYeBCDO3/9RCY8KU7CZ6eTx8bEpMzwQib2zUto5fodWpX+V3p7BxKoIEP8em5mBxvZ5rknf5COpogDFZPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpXqhdcs1vgUcDTcs4VQsPGsrUbiPYJUHMuqwqzpO7o=;
 b=jhy8RZYtoREY2dYpGAmwKDbqRT50+Iafh9snGmC1G12YdABqRfY/SEZMpOKO9fnQN4bGSIZl2XAzP/mRGiY0fe4YnDJueYLAES6AVqv+2syQXH7L+4zyXDJpM6nmVIJj1qyHSC1btr9j/JlYhWRt6AK8d+Bq3kwiXN9ss0GDO8M=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by TYZPR03MB7155.apcprd03.prod.outlook.com (2603:1096:400:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:03:38 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 07:03:38 +0000
From: =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	=?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
	<fan.chen@mediatek.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Topic: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAMHwCAAAMVAIAABykAgAALJYCAAAEjgIAAA36AgAACP4CAAU8UgA==
Date: Thu, 28 Mar 2024 07:03:38 +0000
Message-ID: <930b50cb42df3a1a81bb097944c5f18fc5585da3.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
	 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
	 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
	 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
	 <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
	 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
	 <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
	 <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
In-Reply-To: <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|TYZPR03MB7155:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZNL13CxQf+15BHaAZASOUB27NT2C7sCSuWofPjVcP4sR1Wulw6dr90kQI+4nwgOFFv+BmirdVFRJpk8UIATL0pme5hJIu+nkO/V5xbswKhNoRaZyTmg6M+e1IgTf1uG8e6h7AUk+eaNry+evwv7WUWOnI6joX5F3axk7x/EycWBu1yDIpMzxeL+2iD7App0VXNQixeQA6wumujnfhIGj5x7N8kpezSE1Yu6f3cQlhVOSyUPsg0QGztPVTiMkXy8KI1A/8DhCuPlogYYw2cuv3lFcYFzyCiKTIFbz/QE1jY6Y9lzWj7Y6iswVCA7uHvrzBrF62vdtylRHXgWD0k9f/noRFVXzyLNBZzOOkNvxWGo5unu8/JZ9qGyT9KwudopG3gDmsrCY+zlQWv+ZjE6wCmdpRH0UpGH4sudPQvabWmNqSRQu+PCTo75SAhT+yjZQcJSizGSLHQnP5UlXo7PR58n9tvq3pmGJRb1x/sfQ0tfFuIqbjP4IDyhGjaW2U+CIthz71PpeY0yy9f0b+u0R3XfpsF4NtlpVjUU5hVt38hpdvNA/QZFn+03VXVws/b77UqueoCf81hYgjhak+OuP9nkbFw9CyWoblZz+5jRHvEvN6GhyVX5cUNKGeRj0lO//W0zbrJlxEZreBc2pgbeEdLp6+DlE1u2IC1EAAre9Zk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmpYblp3d0JPZkhsT2pIelAvMXdScnRKSWtIVEh3V1RrUjJEVU1BdWtSK2Fy?=
 =?utf-8?B?UUR2TCt1Y3hIRVAxZUNNTFN5ZXBRcnFiazVXWVRENnc2clAvT20zUlp2bTZs?=
 =?utf-8?B?clJIN3BTTVJwRThaUHFBRldLdU52UXNjU2J0U3dLVTh5M0ZsclJMY2hXejl4?=
 =?utf-8?B?QVRodG16S1E0Y0U2cndOWjRUazQyWTZpU1RLaEViZVJkSFcwU2tIbnlSUXVo?=
 =?utf-8?B?by9FTFlYcTYwRHJNS09JRXhnYXJSWDQzRHlVQUhnVTJhb0JQTmVucnoyVkc5?=
 =?utf-8?B?SHMzNFd3VkRBMUhlUlJreDZyT1dVejBaeEpsNjIxdFJhcmo3Q212VDlLSEdE?=
 =?utf-8?B?c0hnWFAzL0dWaktqSFF4RWdKWEVZWWtXSDdyME1qbEI4T3NxR2xXZTQ3RHZz?=
 =?utf-8?B?dGluN05zc3hJTUNQTGJIMk9SWGc0UEszZnFVelloOGhiSXRybDFHTzk3N3JH?=
 =?utf-8?B?eUJEeVVJYzI1K2J4WlRoWEFlQThJbk9DNDVsSDhVdXJFWldEVldiRHpBSVN5?=
 =?utf-8?B?cWQzOVVNcVpGeW4rRmRKNzRnM3J3ZVpmdDJJWlZ2VnlqWlJHbE84SzlhMlI1?=
 =?utf-8?B?aTJPbG1nbGlVb2JUVnJBU2loRFVmSjFxbVMvQUNoSnFkOEY5S3FjdkF5Vzha?=
 =?utf-8?B?RVZTTTQ4cUtiZy9UaTV5RmcvN3NLVVJCZFl4VDBvY3RBZ3E5blA0KzFmbVFQ?=
 =?utf-8?B?alNpd1o1NFRLYks2cloxRXN4c2cvbUs0QnVMVFptT0g0TXNmQTRYN0lwVzhV?=
 =?utf-8?B?SThKbDJ4OFBKZjdzaWJLL2dXcExOdjFOV2ZndlJNbFdweWluTXJZOUhzUmxp?=
 =?utf-8?B?ZmFNTCtraVJXbDBqMlhRc256bEtmK3RLNmJkZjRyU0RtRnNVaWV5cUxVVVFZ?=
 =?utf-8?B?dE4xSjdYWXF2QUVCZHpiZFBOSDdNOTMvbkJDQjdhSFpwWkJIUk5YVW9uZWZN?=
 =?utf-8?B?eXNqZUxHNDdLeGhoVEx6VUoyZzcyTXMvT3FEK3FxdFgvUWpEV2F6bDUybkVx?=
 =?utf-8?B?ZW9FeU1LUjVDamZrdGhWd3BoREozZ3ZpRVg3WjJZVkNJWXNiK3VjTk8rdVFv?=
 =?utf-8?B?SHVnSFIyZ3FuVHNJSTNVREorcU9obTgrYXR0MG5kbHYySjd1WEE1R1Z2R0d1?=
 =?utf-8?B?aDM4ZHlsN0tkdko5ZFMrRlQxY1hJbmdGYzVDNTV4TUpPcnVaRFRMS2lFaXJU?=
 =?utf-8?B?NCttRkp2SzhaU3QwVzdpRUJ1T1dINXZsOFJMWHNadkswK2cyakpXL1IrZFZO?=
 =?utf-8?B?amFnVkZObGdTbUE1UlprYlNtN3VJazR5Nm0wWlBPTFN3anJ0S2pPMEtnazV2?=
 =?utf-8?B?bUZ1clMwaHRNUWlmRE1LNXNRYjNYNm9BSmp1MWNBZ1dlYmd1SEJTdk1vc1Qx?=
 =?utf-8?B?ay9XWE9EUmJ2aXIwbUpzS3RSQ09zNjNtemhKOHkzSWQ1VWxwUkxDL3NlbTYz?=
 =?utf-8?B?NU5WeGdrS1RBWTJ4ZVByUThqc0Z3SktPcnFwdUNjZXNaMDZpclVyY3ViRGdt?=
 =?utf-8?B?ZlJjRDFhS2lSTlRsaEtYdFpMTHdndGR1a004VFNIUEZCa3NPRW9udlVBK042?=
 =?utf-8?B?SVJqMDkvQjJpRU1INFFXVjRRcHhuallmZDNEc0xmalAxbHdGZTlNdy93QWJ6?=
 =?utf-8?B?SjNpVTFlWUNaYktvY3ZHQmsrOUNsdmRrR0Q4YUJHK2JNc3ZnencyRjdxL3Ri?=
 =?utf-8?B?SVVZQTlhenhBNHBPTGJIdnJ0ekw1VUlrWmh6NHFMY0FRMU5RbTNWa3AzMXVT?=
 =?utf-8?B?R3V3ZHpTblFKSVFmT05Dcmd3K0o4VTNTeHppS3lnam5jU1dmTHBQRWFUWHRJ?=
 =?utf-8?B?VmUyVDB6Q0d5dlEwczk1OE5MVVk4dko3b29La2tiOWMrR1R5V3QzV2NJV3pn?=
 =?utf-8?B?RlBVdVhueWpZcDUxWk42Q3V6NnhndFpsdStjMk9kRjVLODhUbURKM3o4MTM3?=
 =?utf-8?B?VHBIY0xySmlXU0IzdG5LZFB3blZKOXBkc0NHeDA0VnEyWmkyZEFvOXV4K0lK?=
 =?utf-8?B?dURiOWQvaHEzM1kvN2wxVkNiV25FS0hsY2p4MG5MZnExWTJvei9HNjNFbkNS?=
 =?utf-8?B?N0pyVjJPaTlvZUZlOWxybFVZaXZwRnJ1Tm1DQzkvRVh1QXJaZ0lJelEwMll0?=
 =?utf-8?B?RUltR2NwdlV5R0ZOeE9oRE9lRHMwQmQ4K1FlMndPNUlkcFZJNUxGVnc0R3ZZ?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE15656619B06B409FF4F56C21F711BF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116b4e94-beef-457b-4418-08dc4ef53146
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:03:38.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ4LVYB7wUJqCoZiYZ6f2PIFs4JtOp/E0Dpp7abgyXpi72+OEtcZ12jHgW8fnmPIP+co2Zbp5fS9/ra92d/lGcY0tgYrPB8NFMJ2U96Nyx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7155

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDEyOjA0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzAzLzIwMjQgMTE6NTYsIFl1LWNoYW5nIExlZSAo
5p2O56a555KLKSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjQtMDMtMjcgYXQgMTE6NDMgKzAxMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVtYWls
IDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGls
DQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4+
ICBPbiAyNy8wMy8yMDI0IDExOjM5LCBZdS1jaGFuZyBMZWUgKOadjuemueeSiykgd3JvdGU6DQo+
ID4+Pj4+Pg0KPiA+Pj4+PiBIaSwNCj4gPj4+Pj4NCj4gPj4+Pj4gSSB3aWxsIGRvdWJsZSBjaGVj
ayB0aGUgZm9ybWF0IG9mIHlhbWwgZm9yIHRoZSBuZXh0IHZlcnNpb24sDQo+ID4+IHNvcnJ5DQo+
ID4+Pj4gZm9yDQo+ID4+Pj4+IGluY29udmVuaWVuY2UuIEJ1dCBJIGRpZCB0ZXN0IGl0IG9uIG10
ODE4OCBjaHJvbWVib29rLCB0aGUNCj4gcmVhc29uDQo+ID4+Pj4gd2h5DQo+ID4+Pj4NCj4gPj4+
PiBIb3cgZG8geW91IHRlc3QgYSBiaW5kaW5nIG9uIGNocm9tZWJvb2s/DQo+ID4+Pj4NCj4gPj4+
Pj4gcG93ZXIgZG9tYWluIG5lZWQgbGFyYiBub2RlIGlzIHRoYXQgd2hlbiBtdGNtb3MgcG93ZXIg
b24sDQo+IHNpZ25hbA0KPiA+Pj4+IGdsaXRjaA0KPiA+Pj4+PiBtYXkgcHJvZHVjZS4gUG93ZXIg
ZG9tYWluIGRyaXZlciBtdXN0IHJlc2V0IGxhcmIgd2hlbiB0aGlzDQo+IGhhcHBlbg0KPiA+Pj4+
IHRvIA0KPiA+Pj4+PiBwcmV2ZW50IGR1bW15IHRyYW5zYWN0aW9uIG9uIGJ1cy4gVGhhdCB3aHkg
SSBuZWVkIGxhcmIgbm9kZSBpbg0KPiA+PiBkdHMuDQo+ID4+Pj4NCj4gPj4+PiBObyBvbmUgdGFs
a3MgaGVyZSBhYm91dCBsYXJiIG5vZGUuLi4NCj4gPj4+DQo+ID4+PiBTb3JyeSwgTWF5IHlvdSBl
bGFib3JhdGUgb24gd2hhdCBpbmZvcm1hdGlvbiBJIG5lZWQgdG8gcHJvdmlkZSB0bw0KPiA+PiB5
b3UNCj4gPj4+IG9yIGl0IGlzIGp1c3QgYSBzeW50YXggcHJvYmxlbSBJIG5lZWQgdG8gZml4Pw0K
PiA+Pg0KPiA+PiBQbGVhc2UgZXhwbGFpbiB0aGUgcHVycG9zZSBvZiB0aGlzIHByb3BlcnR5ICho
b3cgaXMgaXQgZ29pbmcgdG8gYmUNCj4gPj4gdXNlZCBieSBkcml2ZXJzKWFuZCB3aGF0IGRvZXMg
aXQgcmVwcmVzZW50Lg0KPiA+Pg0KPiA+IA0KPiA+IEl0IHJlcHJlc2VudCBTTUkgTEFSQihMb2Nh
bCBBUkJpdHJhdGlvbikuIEluIHBvd2VyIGRvbWFpbiBkcml2ZXINCj4gd2hlbg0KPiA+IHBvd2Vy
IG9uIHBvd2VyIGRvbWFpbiwgSXQgbmVlZCB0byByZXNldCBMQVJCIHRvIHByZXZlbnQgcG90ZW50
aWFsDQo+IHBvd2VyDQo+ID4gZ2xpdGNoIHdoaWNoIG1heSBjYXVzZSBkdW1teSB0cmFuc2FjdGlv
biBvbiBidXMuIFdpdGhvdXQgdGFraW5nDQo+IGNhcmUgb2YNCj4gPiB0aGlzIGlzc3VlIGl0IG9m
dGVuIGxlYWRzIHRvIGNhbWVyYSBoYW5nIGluIHN0cmVzcyB0ZXN0Lg0KPiANCj4gVGhhdCBzb3Vu
ZHMgcmF0aGVyIGxpa2UgbWlzc2luZyByZXNldHMuLi4gb3Igc29tZXRoaW5nIGVsc2UNCj4gY29u
bmVjdGluZw0KPiB0aGVzZSBkZXZpY2VzLiBNYXliZSB0aGUgZXhwbGFuYXRpb24gaXMganVzdCBp
bXByZWNpc2UuLi4NCj4gDQoNCk1heWJlIHRoZSB0ZXJtICJyZXNldCIgaXMgbWlzbGVhZGluZyBo
ZXJlLiBXaGF0IHBvd2VyIGRvbWFpbiBkcml2ZXINCnRyeWluZyB0byBkbyBpcyAic2V0IGFuZCB0
aGVuIGNsciIgdGhlIHNtaSBsYXJiIHRvIGNsZWFyIHBvdGVudGlhbA0KZ2xpdGNoIHNpZ25hbCB0
aGF0IGlzIGFscmVhZHkgaW4gdGhlcmUuIEFuZCB0aGlzIHN0ZXAgaXMgc3Ryb25nbHkNCnJlbGF0
ZWQgdG8gcG93ZXIgZG9tYWluIG9uZiB0aGF0IHdoeSBJIHdhbnQgdG8gYWRkIGl0IGluIHRvIHBv
d2VyDQpkb21haW4gbm9kZSB3aXRob3V0IGRlcGVuZGluZyBsYXJiIGRyaXZlciB0byBkbyB0aGUg
d29yayB0byBwcmV2ZW50DQp0aGlzIHNldHRpbmcgbWlzc2luZy4NCg0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpCZXN0IFJlZ2FyZHMsDQp5dS1jaGFuZw0KPiANCg==

