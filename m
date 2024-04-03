Return-Path: <linux-kernel+bounces-129030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627B896378
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B13B21DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE14501F;
	Wed,  3 Apr 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f/47bzwD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FCSbvQc4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA33716D;
	Wed,  3 Apr 2024 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118294; cv=fail; b=DkzQVVN6hxIuLoLjORtade75UJXC2eopqTCx9V5dfxP27WaDcymp0l44hFTRf4fd6HJWEOU7aZN7UuG+o37Wt/ygrRDBNW7JWiqQ1OJwKR5YxgrlipdAagWBgxhYqb5TLF+SL4VNTctWaC8uSv6LxvPkmimf9ER6EotDCzWJ4oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118294; c=relaxed/simple;
	bh=ALToTDOLXG1JUxgoypRInnHKy0z1IvTA4lbsrRxUGQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqthEc9mqXVF68Yrp2veIPOXqZCpJpsViEMCklgEUMw/hASDERAhiXhVIEG1zrwDB3x8vqRuiTqvAJ8FyMJbXwz8hDKDeHRAT+YYCem+/Z7saot6nEQecayXEWboSqrTOKydi1rBbh77kp68lI00aujLMS+yS5G6zuECPmLsMpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f/47bzwD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FCSbvQc4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1974641ef17211eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ALToTDOLXG1JUxgoypRInnHKy0z1IvTA4lbsrRxUGQ0=;
	b=f/47bzwDuBPLi9cFe0mvTbw2y8t2Oq//Lo8XiH/4yp7xAkA8PUuWttCRji8hVc8l3AT4vjwYwEPRPwiyS76Rqh3mbcNdY2sYbS/o5WC2RyUZVFILiXv3nr0kDb/4A7DANOypladMD4+uqF3DrAR/pgP9apgKDX+afoG6BhPI9vE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e8188b23-c155-4ae7-94cd-223564f94db7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:0842a600-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1974641ef17211eeb8927bc1f75efef4-20240403
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1618382479; Wed, 03 Apr 2024 12:24:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 12:24:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 12:24:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j49nLxqyQoQ8ZL4ssKmZ13j/umeAxH6xq/HAq7HuYs6VSs9UkNAShz1QAOR6XvZzsv419IhI7olAf4dMeYAKOnucyRN8JKptDqMYfPF4lexdaH9kITIOPm6ckCwZDUiseIqP1vPLgSI+qoPOVnJ1whm6dtwRuZTG//xkRdbsNzb3xzoH45nXVdV6l1qQRDhs/3ruPAB1oBrwqd7gLb9UYX71hUjAZ+WfVmSB3iN/Mvx66NdJqX2MqJ8N6Um4a/eHTmxhYzcAyuqr8Mz5Hm9JXw7fbB+vZxVFYWa3+Bcz9T63Thajo00D3/s2UF74MciqQh3MMv3diZ2UbIRk0RLonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALToTDOLXG1JUxgoypRInnHKy0z1IvTA4lbsrRxUGQ0=;
 b=NAdNhTJhAqo2ET7eqqrWmQ8m3OY31pXWjmx2/wyBYXqHaLxhBqf5Xg7Vu9PhT+GAz9Mg1djTnissROJ6aF1wFKNlBxumklENMf8ypuYAAtLHX22j9i8kAlC265R9ibVp58VkGMPvVmqy9oxJOI34GRNOW9tAxn5iJ9jAIrb3KpxttiN4dmh8PWnRUQ4tVE7oVvXh5sxOW4MUtckB0dJ2Co60cZSbAMsBt7JQyZPXUkb91xbv29liHEdLBQ8atNyjmZ0Axn0wc+GxGNWpIJrGvnV027jvWR7OMWO0hE4Pq3Rda19/IrFEbE9C+5+QKIu7/LVR/VbRnkKW2jZcxVM88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALToTDOLXG1JUxgoypRInnHKy0z1IvTA4lbsrRxUGQ0=;
 b=FCSbvQc4r1t25FTsRtsTg1wJhPVzN02U4PBCl/cgiZfumvSpmJqpxD6PQo6bWexeRynlUjBpw02n1LbiklMUP+ZSiFH9YF/gsZOyhEC8rAnuNnsY64URVbrZ08P5AQ2NqRJfH9mi0TKweJbWJYPKUZUrytTUftjI6XGh/jn8fcw=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SEZPR03MB8763.apcprd03.prod.outlook.com (2603:1096:101:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 04:24:37 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 04:24:36 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v1 2/2] media: i2c: Add GC05A2 image sensor driver
Thread-Topic: [PATCH v1 2/2] media: i2c: Add GC05A2 image sensor driver
Thread-Index: AQHad00+IqkBATFIkUCM1xUJwrGHMrFAQfSAgARroYCAEWF6gA==
Date: Wed, 3 Apr 2024 04:24:36 +0000
Message-ID: <f2d8976b23b119ce8d002bde7a04d38babd93e08.camel@mediatek.com>
References: <20240316025253.2300-1-zhi.mao@mediatek.com>
	 <20240316025253.2300-3-zhi.mao@mediatek.com>
	 <ZfqQPTgqzOw7tATK@kekkonen.localdomain>
	 <8a6bbbdde57283b5bf8cab0ea7ecb0f201d437e7.camel@mediatek.com>
In-Reply-To: <8a6bbbdde57283b5bf8cab0ea7ecb0f201d437e7.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SEZPR03MB8763:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOqxJ5QhJ7a3sT+/ZT4coe/N2z5lmT/eEyra9BGLMj+uCWjF9hem5yW24HmxXyK/Jsn88e6ltlxryTEOVJLJjUzsQ+iqRo+veIKzRG2vAaAWBDVq0mTrpxnyrc0G5HUUvwpIBl+PoE/7bHF5h8WmRMz2A1ajjftGa0dvc5e2l7UA8QFTAVxRQKL7Bowyx2CwZDwf09jEyZ+zaz2T2HO1Lbglyx0unRK2mHPrrMa9VZdSoooqOZWh9jS/JZAXsnsoMn9FRtNizh0YldEWZl0glQUwnQps2Pa28WibMjalSH7luoMb1owy7Mg3M+R0evePFdW9MKUExpWxSWTC29xJjsTMbvDNrtCq3u2iIW3sMN+AAj2URUIVM9fpUZ7mfij2q6D/3qofR4dESiFte2TBCzgg2nN6kNRh/tZY/Exczwovh5Q2PTO8WAsjNziIlT1J2rIQRqLtrL3fI977DLBWdCsGhhLJhXPrbeNWFm6+3XfpkV7wm5I+fsx0SlcuOXQElAqv1aOHdPcNKhIa2GJPwmlgEFKt3+uhGlvVqbt3i1nrBSeL/Q77s6PGj70i202D9bKjKAQ2NFe+p64Rg0cqA5oy/qilgELzY62reHV+bt00F0XDejUwB1afwqAoaBmo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZ3MGl2T0s2M2lHYkxwSU5GUG9EMTJvU3oxVGxSaGRCUUl1VVh2d2lLWjRB?=
 =?utf-8?B?UWd5WE91UkpwMDZmNEx1aHlPUFJ0Y2N5b0lRaUFXUmFaVUJ4UUZmQm5hWElQ?=
 =?utf-8?B?RnY4aUFSM0ZldFRVbUZWdXpXdmdVTi9pVnhRVS9UeGZwdDlQRkJNSTdaTEU5?=
 =?utf-8?B?RVIzdTdzckVTK3VlZFJzTmtFczNpeWhhNXY2L1VLdzRvbjRzN0MyQjZLTk9h?=
 =?utf-8?B?eng0bDBiSERLOFhHNUluRytueEtpSmxzTDM0SlduMndFaXhZY1NMOGRvREFJ?=
 =?utf-8?B?WkVLNXZ5UHN2R3VmMzVuVTVXT2VGUi9ITzFzQkY5TE5IQitQMktoenptWjNa?=
 =?utf-8?B?QUlQbVlTVktvME5WbVQvTHhpeVp4alhvVlpNZm4yc0ZObTdBTStqaFRnVjRS?=
 =?utf-8?B?SFdqWlZTN3ArWTVEck80SXZVRTVoTVVUQ1h4WVh5bE5kcDdSV3BoUFRPd2lC?=
 =?utf-8?B?Qk8ydkdrMUpFNjZ1QnlndE8xOGozWENSSWJKUVZwdkRzL0Fqb0hXQTFuYTRK?=
 =?utf-8?B?Z1BVMkxCSit4WUtBSUhKWWh3QVlWNlFOQUxqN3pTdDFmZlhMamQ1SUw1NWQw?=
 =?utf-8?B?N2RiV1dKOGY3emFpR1V6cmlTclVGUVNCYVBTbHFreEdjS0lFOGlodnNzbnN4?=
 =?utf-8?B?MDRyUStIL09yNkRPWEFnYjk1Qi9iVjlzTDdhSllzVjhteEVUbnFaQ2IvSmRJ?=
 =?utf-8?B?a09MMkl1elZvV2MrTFZzckNKTmpnd1o4cFRCUm5pNlZCNFVZVElGNjFMOGVD?=
 =?utf-8?B?aGIzYXpDanpUc3dKY3ErM1B2T2NXSFpHRUdJbkIrMlRjRzlzSjEzVUNOZVc1?=
 =?utf-8?B?NFdMMWlnVlk2N2RjVDA1alBWTEYrOHE4ejNhOFhsazVRb2ZKS3B3M3NWUy9w?=
 =?utf-8?B?cWtFcFdHWDVGSS9zOUlwOEd5cWJyK0RHZlA5QWlOOVQydGV4VFBNakpubkxi?=
 =?utf-8?B?NHlIcEVRbkw5U0ErSmE2RFMxQ3dkanJDclBRczFqTHFhTy8vNFora28xWmJK?=
 =?utf-8?B?SGg3V1JyWkNEa1BpRU90cGdIazJsVVZ0bldycHQ4QXZHZ3VibVFJY29SeFhP?=
 =?utf-8?B?ak5nNjJzSk9iaUxxeGVDdnQzUDdpenFRZXI3NU9QTHNrT0FiMXo2S1BoelVW?=
 =?utf-8?B?bzZEQW0yZEJ6R0tBQ2NKOVlxa0RGVE5DY0twNVdGQ2F1KzF3WlFlOHZtUGVH?=
 =?utf-8?B?Z1YrZ0ExVVk2WWZpbFU4bXQ0ZC9oMHFHZVluYWtZYStpMVFNcnIwMzNZMXlX?=
 =?utf-8?B?NTlDeGFxNllJNHdTUk5DaythcUxmb0E4KzBqWkxjL2VjUnZnRDhUcUhnVnJG?=
 =?utf-8?B?VDk4Q2JmVDlTb2MvQWhQUmlxTFZOYk5vakp0aTJ0R2pHczBhd2lzalNjRW1z?=
 =?utf-8?B?RG5lYVV3cVcvL1NleGo4Q1VwbDhLM2t1TmRDL2cvMnBaVVg3dVR2TnRLcnpx?=
 =?utf-8?B?c3ZySFMzanp4V2lMVHVqcFRnc3UwNHBxQUdscmZHOElndUVvQTNHQ0NQSSt5?=
 =?utf-8?B?VExmcmZzMHJ5Z2cwamJ1MDM1czJYZURpV1VvbVpPNWs3WUdhaUZaME12WTgv?=
 =?utf-8?B?VXhFNW9PbG5Mdi9DQzkzelQxOXUvdlRjYkh2Q3RjVWFGZGxzYzgxcXA0dnV1?=
 =?utf-8?B?dWRnY2NIM1RCV01mdzhGUHc1YVpSQ2E2RkRsdWxvNUp3Q2V6d1cvSHdmaDRr?=
 =?utf-8?B?blJ3cEU5aytZc2pKRTZxemtzWEpuaTd3a0pYa0pzWnF0cUkwNVpVOWs0YUpX?=
 =?utf-8?B?TFI1WnE1N3VoMzhYbXd5Q3U4TWwrSTJzY3RZbDU5bTFtZEdnL2YyRGhJM1RN?=
 =?utf-8?B?c2NLeDNFTUJWNmlya3EzN0VJc3lURGxqcUcxZ2FDNzRvTVBXY3dpUG1BcEZw?=
 =?utf-8?B?UUNBRU04a1VWQ01pU3VYWjc5bi9qRGh2dlBOc3JYRUVIeVBUZ0dSM2FqZzBT?=
 =?utf-8?B?QkdUNkl5TzRxT2hwam9Yc29ENlExQ1ZPRjdsK1hXNklZRXJDTDFpWlhxSUpo?=
 =?utf-8?B?MnpzQWlGS3IvOGE1OTQ4QVFUR21abnNHQ0pZSE5jbVNxTGlHNWVOcTBrQUJt?=
 =?utf-8?B?VWV0UzMvdjRtbUtZZTBia3ZMVCsrM2poSXc2QkNqQXRlWldyaGtVckQ4Qjlq?=
 =?utf-8?B?M01WSk9aRDhsc2xIcVJ6c0dEM1hsRkh6dStSRHBBY1RoMnhDK1dzVkNiQzl5?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E66F93B9CA9384E90C5DC746E61DCBE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c544155e-acb0-4f8e-0ca7-08dc5395f8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 04:24:36.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7L/uHwgemAByKm809i0QaMYkeuwFvj7aiFeOPAMhkzJ2dRr4wVnfuI9Ce8oOxm0SxDQEG/nQVG/saiIxJnirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8763
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.951700-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4uG5dRZCgxC3uLwbhNl9B5UNcckEPxfz2IP+
	YDa/Dhu9JP00JqzxhIBrkO0aOJR63GaivMAy8a2BvHKClHGjjr2cyCGZko2aplVqIv0mjuMGo/7
	b2ABiEdK+j2QY5cRmWtP+J/cFFKsSHyzWFbk8FLVLc5N+0s1+DTK1/qdbjc7QEqzh2sHXZHGiw+
	Xvt/uB3M0AhBXEKaqYeo8Y7LCQaK8AiB89UisvLBWCVBr+Ay98wx0jRRxcQfNAiWCTfFh1XgBKG
	kW9znn5NZgKuXgLgpPcHsyE3Hr9h0L9tcyTZdAsgxsfzkNRlfL+VmoNXJ/8FMBrudef+SZcjocz
	muoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.951700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AD25280E4E5CDFF39D33C5A62753ADED7DFE98F4DB50350C0B7F911A52CA933E2000:8

SGkgU2FrYXJpLA0KDQpVcGRhdGUgZ2MwNWEyIGRyaXZlciBwYXRjaC4NCg0KT24gU2F0LCAyMDI0
LTAzLTIzIGF0IDEwOjU5ICswODAwLCB6aGkubWFvQG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gSGkg
U2FrYXJpLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gDQo+IE9uIFdlZCwgMjAy
NC0wMy0yMCBhdCAwNzoyOSArMDAwMCwgU2FrYXJpIEFpbHVzIHdyb3RlOg0KPiA+ICAJIA0KPiA+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiA+ICBIaSBaaGksDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgc2V0Lg0K
PiA+IA0KPiA+IE9uIFNhdCwgTWFyIDE2LCAyMDI0IGF0IDEwOjUyOjUzQU0gKzA4MDAsIFpoaSBN
YW8gd3JvdGU6DQo+ID4gPiArc3RhdGljIGludCBnYzA1YTJfc2V0X2N0cmwoc3RydWN0IHY0bDJf
Y3RybCAqY3RybCkNCj4gPiA+ICt7DQo+ID4gPiArc3RydWN0IGdjMDVhMiAqZ2MwNWEyID0NCj4g
PiA+ICtjb250YWluZXJfb2YoY3RybC0+aGFuZGxlciwgc3RydWN0IGdjMDVhMiwgY3RybHMpOw0K
PiA+ID4gK2ludCByZXQgPSAwOw0KPiA+ID4gK3M2NCBleHBvc3VyZV9tYXg7DQo+ID4gPiArc3Ry
dWN0IHY0bDJfc3ViZGV2X3N0YXRlICpzdGF0ZTsNCj4gPiA+ICtjb25zdCBzdHJ1Y3QgdjRsMl9t
YnVzX2ZyYW1lZm10ICpmb3JtYXQ7DQo+ID4gPiArDQo+ID4gPiArc3RhdGUgPSB2NGwyX3N1YmRl
dl9nZXRfbG9ja2VkX2FjdGl2ZV9zdGF0ZSgmZ2MwNWEyLT5zZCk7DQo+ID4gPiArZm9ybWF0ID0g
djRsMl9zdWJkZXZfc3RhdGVfZ2V0X2Zvcm1hdChzdGF0ZSwgMCk7DQo+ID4gPiArDQo+ID4gPiAr
aWYgKGN0cmwtPmlkID09IFY0TDJfQ0lEX1ZCTEFOSykgew0KPiA+ID4gKy8qIFVwZGF0ZSBtYXgg
ZXhwb3N1cmUgd2hpbGUgbWVldGluZyBleHBlY3RlZCB2YmxhbmtpbmcgKi8NCj4gPiA+ICtleHBv
c3VyZV9tYXggPSBmb3JtYXQtPmhlaWdodCArIGN0cmwtPnZhbCAtIEdDMDVBMl9FWFBfTUFSR0lO
Ow0KPiA+ID4gK19fdjRsMl9jdHJsX21vZGlmeV9yYW5nZShnYzA1YTItPmV4cG9zdXJlLA0KPiA+
ID4gKyBnYzA1YTItPmV4cG9zdXJlLT5taW5pbXVtLA0KPiA+ID4gKyBleHBvc3VyZV9tYXgsIGdj
MDVhMi0+ZXhwb3N1cmUtPnN0ZXAsDQo+ID4gPiArIGV4cG9zdXJlX21heCk7DQo+ID4gPiArfQ0K
PiA+ID4gKw0KPiA+ID4gKy8qDQo+ID4gPiArICogQXBwbHlpbmcgVjRMMiBjb250cm9sIHZhbHVl
IG9ubHkgaGFwcGVucw0KPiA+ID4gKyAqIHdoZW4gcG93ZXIgaXMgb24gZm9yIHN0cmVhbWluZy4N
Cj4gPiA+ICsgKi8NCj4gPiA+ICtpZiAoIXBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZShnYzA1YTIt
PmRldikpDQo+ID4gDQo+ID4gVGhpcyBzaG91bGQgYmUgcG1fcnVudGltZV9nZXRfaWZfYWN0aXZl
KCkuIFBsZWFzZSBhc3N1bWUgaXQgdGFrZXMgYQ0KPiA+IHNpbmdsZQ0KPiA+IGFyZ3VtZW50ICh0
aGUgZGV2aWNlKS0tLXNlZSBjb21taXQNCj4gPiBjMGVmM2RmOGRiYWVmNTFlZTRjZmQ1OGE0NzFh
ZGYyZWFlZTZmNmIzLg0KPiA+IA0KPiA+IFRoZSBzYW1lIGNvbW1lbnQgYXBwbGllcyB0byB0aGUg
R0MwOEEzIGlmIGl0IHVzZXMgYXV0b3N1c3BlbmQsDQo+ID4gcGxlYXNlDQo+ID4gcG9zdA0KPiA+
IGEgbmV3IHBhdGNoIGZvciB0aGF0Lg0KPiA+IA0KPiANCj4gZml4ZWQsIHBhdGNoIGFzIGJlbG93
OiANCj4gZ2MwNWEgcGF0Y2g6djIgDQo+IA0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW1lZGlhLzIwMjQwMzIzMDE0NzUxLjQ5ODktMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCj4g
DQoNCmdjMDVhIGRyaXZlciB3YXMgdXBkYXRlZCB0byBwYXRjaDp2Mw0KDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1tZWRpYS8yMDI0MDQwMzAzMzgyNS45MDcyLTEtemhpLm1hb0BtZWRp
YXRlay5jb20vDQoNCg0KPiBnYzA4YSBwYXRjaDp2OA0KPiANCj4gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tZWRpYS8yMDI0MDMyMzAyMzg1MS41NTAzLTEtemhpLm1hb0BtZWRpYXRl
ay5jb20vDQo+IA0KPiA+IC0tIA0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPiANCj4gPiBTYWthcmkg
QWlsdXMNCg==

