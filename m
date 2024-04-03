Return-Path: <linux-kernel+bounces-129007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93218896312
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09221C22B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F73D56F;
	Wed,  3 Apr 2024 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DCov68NA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="G8CvULDJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C993D576
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115557; cv=fail; b=V63zJ4YlsZlCB0O27DR7pjepaLpYLxYinzP/3VQYcOv2CY1OvYsqP7eCZceGZ0K/1MiS8ALf8vARTiVY0xYegyLba74JNyVcP8gZwIL2/aCMDzJr/wYQqBmHGXV0Xl7WMZIFzFabTnweVzIL1RQFHTspXF0CmtiUFsetMQMwU7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115557; c=relaxed/simple;
	bh=DBY+JNbyB9Ntgb0EXaPM5b/bh/BgvABMivVHH6rAaKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVEoX9vhh6AFYuABeotPFvLH41AXU53mFrJhJ4WhCplogQoWzklpL6f/TmEoVg0Cd72WKtW6xaB766SHOE1044HPVW5oCxNwBV8Cd85OzZS27Lk3eDev0pdrZYNxgskXScqVqqOg4f0W0ARAwR8DLOHH89htleYQsQI9dd2eIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DCov68NA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=G8CvULDJ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: badeed76f16b11ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DBY+JNbyB9Ntgb0EXaPM5b/bh/BgvABMivVHH6rAaKo=;
	b=DCov68NAYPW2ySF6OZafec3tlYh+iRJ9uP8YFWsWjslUGJxqoX7mCSl9Vd1s2rkoiNl3lMYbIUot4CXkUTE7A3bfWe29YmiN4xNm1cuIaV70aSJkAUs92+3/va3W4XIzxy9meUd7KgjzYUzsuuqKHOCoDRZsAYl42ZXkeOoASD4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:aec7e150-7dfe-4f67-82b8-6374bc158ccd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:07a24082-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: badeed76f16b11ee935d6952f98a51a9-20240403
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <light.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 730602965; Wed, 03 Apr 2024 11:39:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Apr 2024 20:39:08 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 11:39:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fwa5b8TH1mIni0Mq+6l1aoxLiTZQxRYjTON/48+1TUDdCQt+WsmwamNHGk/HhkF40OGLH5l+GigPD593DFwA7/90BFKZV3+6EIpDSwPDTvbV9I/65Rv/R+ksGM9Wvcfvp0qBFG0i2Gq20zoi/BQtLuNqlBTbBh0C8dKggHHlFjNmPdkyyUSiLIpKmA7JKMkJMoKE6OBIWXTk0EdCWr7qjm4q1Dns9p+YVfk9IbtCRC0zayFiJl58LNQllXANOssO+FoWi8ldlW/ISdXiVSEFtEbfM8hBsaLUp+XeVA6u0CH0h/srIK19dHnbrfSM8cYH6xGv1Pql2NKn1OexWS+ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBY+JNbyB9Ntgb0EXaPM5b/bh/BgvABMivVHH6rAaKo=;
 b=is6cjLeDG7Ad4t3Q2znxqAdcrymOxe0SRlM0I8r79bwTRPwDTOwPoegVYdsmMzEQ60opXuxgM07xVY4etOSwVsOCqCbca4Smsvt+bgnvZ0lzXxozHL4ztCxqcp+9axx/mCUKs7bOQtP7eElcTF76AHpDpasXgIvz2ais3Tzvg3eI7a93AyJpE6CNFMvkH9vr7rSLdoVLkWaH/AiRpkjfBBKZO2bpoFywD8uvv+pRjJL2aQhFyXutfmDAJpbo713BvXFLFgi1RaqKTsi8F/uEUwsxNOjRQaOU0qbMb7Zo3ByWpO5Ta6SGfwb/KkHs942LSDVksORUp2dP3nJUA/bXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBY+JNbyB9Ntgb0EXaPM5b/bh/BgvABMivVHH6rAaKo=;
 b=G8CvULDJ/xvj/4z5SPMe5rzlo2vDth4g2CgFFb/rW2Hep7hvItpi70Ogk9Sd0jo/Alj3JE8q0vaI4CjZ4iJ/IzMIXEBxYUgc0cHwe2ri5IBivv6OFHYX8tOgE+QZb9enYsJ70KKD4cRoz7jVsaUfRx+mdRcDojkojpiDR5LKr3M=
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) by
 KL1PR03MB7850.apcprd03.prod.outlook.com (2603:1096:820:f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 03:39:06 +0000
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86]) by SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 03:39:06 +0000
From: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Hillf Danton <hdanton@sina.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSF0gZjJmczogYXZvaWQgdGhlIGRlYWRs?=
 =?utf-8?Q?ock_case_when_stopping_discard_thread?=
Thread-Topic: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIGYyZnM6IGF2b2lkIHRoZSBkZWFkbG9jayBjYXNl?=
 =?utf-8?Q?_when_stopping_discard_thread?=
Thread-Index: AQHae+EjGuIimSJa2U6kUjro/ZAA7bFC6B+AgAAWVxiAAVk0AIAF7G8AgABpwiuAC0nn9w==
Date: Wed, 3 Apr 2024 03:39:06 +0000
Message-ID: <SI2PR03MB5260819B5B1719063EFF458A843D2@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com> <ZfzQz5hwECOEGYVL@google.com>
 <SI2PR03MB52607606AB0D29C8AB123C1484312@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <Zf4FIAkI83GbQYLB@google.com> <ZgL9NLLiSdDeIMg_@google.com>
 <SI2PR03MB526041E42B6BD9C9DA9FBAC184352@SI2PR03MB5260.apcprd03.prod.outlook.com>
In-Reply-To: <SI2PR03MB526041E42B6BD9C9DA9FBAC184352@SI2PR03MB5260.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5260:EE_|KL1PR03MB7850:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDMG/VaKODwi4J1rqR8H7yauKbQZLZZfrmAEjyLNXjKXjq48RY2UonkQTc7rXF/j+9hl1GanOUNrYbr9QMDXqa52b6+soGYl7UQTLOcYA2ulPH4Rx/lxe10lBC/AfJdmBXre9E4hL8QHOTKTyo9wd8iygCZpQpWAZuEdZG+My/Rx7ntvW015XVkfa8WrJfpZxnJpvDv1fv/AbzhW4IBmt1GMXV0sicQ+NP/1CSCT+jui3kSOA8xKEF0Zr23tBSwmn0FhVoygagkYKiVZ4UoYk8iYS8S1zl1iu+3MYLdQ7poV+BtLYUbbDDe7WO8JAGJ0Pg3tObGU2NgWhhQWHSQBkjpK/3k5RIrgpCNW9FFegZaNfXizW273N10BpJWMWYrxUEzpcGyyH0+liuK+4wwzeLBCNlfgxXIbIVKkRfRDkwvsc4a7YH5t2fKM/EvTOMnhiuE3rpunoJL86oysFS52+2tbM3zppn0iiEIbojfbwzwLm5oEjPPmh3SsixMfPsGu4pTN/P+dh1x4enULXSZFm8bDteRsNn4Tk7MJRuGWWWxOTkf6fVFFlDS5K9T1gdAMcBZt1iCcXRMdvXPfxdRoJxpc9exiLL8bl+Q3WOJTTWDU8Nb4WjmJE89mbCvUAJz3N2pP3LQsQWGoPC+qYWrxbJOGe4Er1O8MMcq1se9Gn94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5260.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tzc3d2tMMjYrejR6VlBCZEpHZGxsbkZxRG8xU1JsVXNlSDVjRFYxYnF6WXVM?=
 =?utf-8?B?RVdtanRtZHZENUZVYU9HN0tLcnJQbFVhL1hydHh5cjZTVFZyenNSeHJ3TTlU?=
 =?utf-8?B?QjF6dWtSR0l6cjV3WGd3cFg3ZFB4b0I1VVlydW1EL2xGNnNlMzhvdVBEa21Q?=
 =?utf-8?B?NFozSmR4T2JRSjVIMVEzTUlOZkFIVUZSQk9wYWlmNlBoUHNYcmdVMFRDeGxQ?=
 =?utf-8?B?SjdLZ3lWQnRQNjB6amJXMTVobUk3QVhuWWVGUm5aenh1NDRMWmpjNGNWNy9n?=
 =?utf-8?B?Z3J4S0NibStTSGt0dGRMWDBoMG1CODdPVGR2dnRpcm4xdHExbGNMOExaeERN?=
 =?utf-8?B?cE83UGpPNzBLOUZMQjE1RUpyVlVQd1RidDQ3enRNLzBCUzA1bUNJOHNLSG1Q?=
 =?utf-8?B?WlN3QWw0c2JadzFiRzkySzlmUEd2WGF2S25yRDZ6K2Y4ODNLTjhzd2FRcjVn?=
 =?utf-8?B?N01BOHBlZ1NRU1lLZHplZXdTWEZzeXB1SldCU2NPbEk3WmVZcEs0N1NSZFFy?=
 =?utf-8?B?dkd1U0J3bDZ2Qi9qbU4rKzNZNFpnamM3N2cveWEwNjViVWNGZnYySmdiVVow?=
 =?utf-8?B?dGFmSWpHMmdoNDE5OGJZRHowM1pTVnFiaFZJbXZrcmlHYm5PR2xHQkNSaUZt?=
 =?utf-8?B?c25tZHhPQ3VsTG9uRVF5ajUyeElNRTIvRkRHTDV6MThUSE5FS2ovRzF1Slo2?=
 =?utf-8?B?djc4K296WmNDVDN3VkljNzFUNUt3T21OUUM5YkJSRjVUSVBTRDBHR1IrbXRE?=
 =?utf-8?B?K2RTM292czh5S2VGVzNZanJKSVZiMElFM1pHdElsMWozZ1V6Y2w3RmtsKzZ3?=
 =?utf-8?B?Ym5TTCtWblFLZUVhRy9qZUlaL0lJSzM0RjdvbjdwcjJtZms1OFFUeDVleHEv?=
 =?utf-8?B?a0tCa3lvMlVaTzY5T2RJMEVKUlcwR1ZicjRhclFsUU82bG1vOVZ2ais2U3BI?=
 =?utf-8?B?cUZXeFlIRFZsblBZSTZTNHc2Wmx2WVp0bWNRZ0p2R3FvV1dEdEJSQlVkMS9j?=
 =?utf-8?B?elIweFRoZHA5MEZiSHgvb0ZBM0Q5WWo1S3pxamI3NWREYjNPYXRRRW16L2xv?=
 =?utf-8?B?NUh4Z1J1WjFIQ0s2UHNDZ05ENnMrVWUxcG1ES2hFYXpITVpFQThlNXNHUlZK?=
 =?utf-8?B?WmJpRndTMDVPekgzK0NzZlRLT09JUFdScm5RR2QyeFo1L00wMU5nOHMzd3Ba?=
 =?utf-8?B?aTBDT1J5MXdvaDlINHVHZHlxM29iNU15a0U0SXdKbEdhbVZjakFxaGZJSjJm?=
 =?utf-8?B?QXVFaFJWMkFYVm9YVCtHNEVmL2xVNldqdWRWWVU3Z0tla0wwWndhVDRXWDNH?=
 =?utf-8?B?NmpTNXJrdTVta0FpVnFNNDFpZCs5am1IYXRnSFdFVFlPRlBvL0QyWUhmQXZa?=
 =?utf-8?B?SHNjVVc1RUd1MjdJUEZoZnBEYm9tYTRERm5ERXdEMWY0aXhyM2pPOTVIdjAy?=
 =?utf-8?B?d2tnZk1mV3d5ZUhtNmVtcWVJSDRuc2YrdktkcURGdHV0clpqeGZCK00zUTVJ?=
 =?utf-8?B?ZzN5Y0Y2alZrdVkrWm0xcUxUNWYrN2RSRmxCYklCbWNvbHFGZkZnUGJMNUZ3?=
 =?utf-8?B?M2pTcXpZdTA1T3A4SFVQOWdReFU5QVdtRnZRQlAwZmNUTGpvWGluWWtvVFhJ?=
 =?utf-8?B?SVBrczZZVUREcTk0SjFBNEwxVWR4QndpVjRqOVY0WDg2VkRraUVyT1g0aVoz?=
 =?utf-8?B?dDdINVZDYUJtQkR4ank0SGxrVVpWOHZIUlQ1aktvR2dXS3pTRjhHYjhDTElU?=
 =?utf-8?B?MTJ0NlF5S0t0Z0VkM1RCaUErNGJXaUhiZk1nQXNtU3E0NkJUemREVU12dW0z?=
 =?utf-8?B?R2NmdjFWVkdEVFdqN0prNW16RHpTQVdBT1NjcDBISzBINHlYNE8ySmxpZTVZ?=
 =?utf-8?B?Ny9MUUxNeW1hanJxTTVNVWxLUVlnWUlQYkR0ellTcXh5RmN1RjRMZGJ4Wmg0?=
 =?utf-8?B?SHBydUdCUHIzYkN1YXRXNXVYN0xYWnlOTkt2alBWajZpSmJ5ZnpOYTUyUFRu?=
 =?utf-8?B?VzRRcGhtV0VWVDdDQzhZelVKZVNQZUhoeFIxNGF4OUw2UENLYytGV2E2MGtI?=
 =?utf-8?B?MUpwVVhFbzdrYUhseUY3MXptQ2lxdi9zMUZEWUEwSnpwWXZoRWhhK0hFMVJz?=
 =?utf-8?Q?oqn5OBjY+uJQ4owIv/2SbzRka?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5260.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0cf88-b641-4807-92bc-08dc538f9d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 03:39:06.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/DN5PCo8sXGd9VYxwNP4wRbRI8gSFnPDPNkk9HK2UXkfuW0KwIwjEG5ImZOnsaqG/AEn8Plqph/n99hYIwiU7iSjPUwm0b8QRDFmg2MPg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7850

T3VyIGxvZyBzaG93cyB0aGF0IHRoYXdfc3VwZXJfbG9ja2VkKCkgZmluZCB0aGF0IHNiIGlzIHJl
YWRvbmx5LMKgc28gc2JfZnJlZXplX3VubG9jaygpIGlzIG5vdCBpbnZva2VkLgoKc3RhdGljIGlu
dCB0aGF3X3N1cGVyX2xvY2tlZChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBlbnVtIGZyZWV6ZV9o
b2xkZXIgd2hvKQp7CuKAguKAguKAguKAguKAguKAgi4uLgrigILigILigILigILigILigIJpZiAo
c2JfcmRvbmx5KHNiKSkgewrigILigILigILigILigILigILigILigILigILigILigILigIJzYi0+
c193cml0ZXJzLmZyZWV6ZV9ob2xkZXJzICY9IH53aG87CuKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAgnNiLT5zX3dyaXRlcnMuZnJvemVuID0gU0JfVU5GUk9aRU47CuKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAgndha2VfdXBfdmFyKCZzYi0+c193cml0ZXJzLmZy
b3plbik7CuKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmdvdG8gb3V0OwrigILi
gILigILigILigILigIJ9CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uCuKAguKAguKAguKAguKA
guKAgnNiX2ZyZWV6ZV91bmxvY2soc2IsIFNCX0ZSRUVaRV9GUyk7Cm91dDoK4oCC4oCC4oCC4oCC
4oCC4oCCZGVhY3RpdmF0ZV9sb2NrZWRfc3VwZXIoc2IpOwrigILigILigILigILigILigIJyZXR1
cm4gMDsKfQoK5a+E5Lu26ICFOsKgSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4K5a+E
5Lu25pel5pyfOsKgMjAyNOW5tDPmnIgyN+aXpSDkuIrljYggMTI6NTIK5pS25Lu26ICFOsKgTGln
aHQgSHNpZWggKOisneaYjueHiCkgPExpZ2h0LkhzaWVoQG1lZGlhdGVrLmNvbT4K5Ymv5pysOsKg
SGlsbGYgRGFudG9uIDxoZGFudG9uQHNpbmEuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0IDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dD4K5Li75peoOsKgUmU6IOWbnuimhjogW1BBVENIXSBmMmZzOiBhdm9pZCB0aGUgZGVhZGxvY2sg
Y2FzZSB3aGVuIHN0b3BwaW5nIGRpc2NhcmQgdGhyZWFkCsKgCgpFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2
ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50LgpPbiAwMy8yMiwgSmFlZ2V1ayBL
aW0gd3JvdGU6Cj4gT24gMDMvMjIsIExpZ2h0IEhzaWVoICjorJ3mmI7nh4gpIHdyb3RlOgo+ID4g
SSBkb24ndCBzZWUgbXkgYWRkZWQgbG9nIGluIHNiX2ZyZWVfdW5sb2NrKCkgd2hpY2ggd2lsbCBp
bnZva2UgcGVyY3B1X3VwX3dyaXRlIHRvIHJlbGVhc2UgdGhlIHdyaXRlIHNlbWFwaG9yZS4KPiAK
PiBNYXkgSSBhc2sgbW9yZSBkZXRhaWxzIHdoZXRoZXIgdGhhd19zdXBlcigpIHdhcyBjYWxsZWQg
b3Igbm90PwoKUGluZz8KCj4gCj4gPiAKPiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiA+IOWvhOS7tuiAhTogSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4K
PiA+IOWvhOS7tuaXpeacnzogMjAyNOW5tDPmnIgyMuaXpSDkuIrljYggMDg6MjkKPiA+IOaUtuS7
tuiAhTogSGlsbGYgRGFudG9uIDxoZGFudG9uQHNpbmEuY29tPgo+ID4g5Ymv5pysOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGln
aHQgSHNpZWggKOisneaYjueHiCkgPExpZ2h0LkhzaWVoQG1lZGlhdGVrLmNvbT47IGxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0IDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldD4KPiA+IOS4u+aXqDogUmU6IFtQQVRDSF0gZjJmczogYXZvaWQgdGhlIGRl
YWRsb2NrIGNhc2Ugd2hlbiBzdG9wcGluZyBkaXNjYXJkIHRocmVhZAo+ID4gCj4gPiAKPiA+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuCj4g
PiAKPiA+IE9uIDAzLzIyLCBIaWxsZiBEYW50b24gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgMTkgTWFy
IDIwMjQgMTc6MTQ6NDIgLTA3MDAgSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4KPiA+
ID4gPiBmMmZzX2lvY19zaHV0ZG93bihGMkZTX0dPSU5HX0RPV05fTk9TWU5DKSAgaXNzdWVfZGlz
Y2FyZF90aHJlYWQKPiA+ID4gPiAgLSBtbnRfd2FudF93cml0ZV9maWxlKCkKPiA+ID4gPiAgICAt
IHNiX3N0YXJ0X3dyaXRlKFNCX0ZSRUVaRV9XUklURSkKPiA+ID4gIF9fc2Jfc3RhcnRfd3JpdGUo
KQo+ID4gPiAgICBwZXJjcHVfZG93bl9yZWFkKCkKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIHNiX3N0YXJ0X2ludHdyaXRlKFNCX0ZSRUVaRV9G
Uyk7Cj4gPiA+ICAgIF9fc2Jfc3RhcnRfd3JpdGUoKQo+ID4gPiAgICAgIHBlcmNwdV9kb3duX3Jl
YWQoKQo+ID4gPgo+ID4gPiBHaXZlbiBsb2NrIGFjcXVpcmVycyBmb3IgcmVhZCBvbiBib3RoIHNp
ZGVzLCB3dGYgZGVhZGxvY2sgYXJlIHlvdSBmaXhpbmc/Cj4gPiAKPiA+IERhbW4uIEkgY291bGRu
J3QgdGhpbmsgX3dyaXRlIHVzZXMgX3JlYWQgc2VtLgo+ID4gCj4gPiA+Cj4gPiA+ID4gIC0gZjJm
c19zdG9wX2NoZWNrcG9pbnQoc2JpLCBmYWxzZSwgICAgICAgICAgICA6IHdhaXRpbmcKPiA+ID4g
PiAgICAgU1RPUF9DUF9SRUFTT05fU0hVVERPV04pOwo+ID4gPiA+ICAtIGYyZnNfc3RvcF9kaXNj
YXJkX3RocmVhZChzYmkpOwo+ID4gPiA+ICAgIC0ga3RocmVhZF9zdG9wKCkKPiA+ID4gPiAgICAg
IDogd2FpdGluZwo+ID4gPiA+Cj4gPiA+ID4gIC0gbW50X2Ryb3Bfd3JpdGVfZmlsZShmaWxwKTsK
PiA+ID4KPiA+ID4gTW9yZSBpbXBvcnRhbnQsIGZlZWwgZnJlZSB0byBhZGQgaW4gc3Bpbi4KPiA+
IAo+ID4gSSBwb3N0ZWQgdGhpcyBwYXRjaCBiZWZvcmUgTGlnaHQgcmVwb3J0ZWQuCj4gPiAKPiA+
IEFuZCwgaW4gdGhlIHJlcG9ydCwgSSBkaWRuJ3QgZ2V0IHRoaXM6Cj4gPiAKPiA+IGYyZnNfaW9j
X3NodXRkb3duKCkgLS0+IGZyZWV6ZV9iZGV2KCkgLS0+IGZyZWV6ZV9zdXBlcigpIC0tPiBzYl93
YWl0X3dyaXRlKHNiLCBTQl9GUkVFWkVfRlMpIC0tPiAuLi4gLT5wZXJjcHVfZG93bl93cml0ZSgp
Lgo+ID4gCj4gPiBiZWNhdXNlIGYyZnNfaW9jX3NodXRkb3duKCkgY2FsbHMgZjJmc19zdG9wX2Rp
c2NhcmRfdGhyZWFkKCkgYWZ0ZXIgdGhhd19iZGV2KCkKPiA+IGxpa2UgdGhpcyBvcmRlci4KPiA+
IAo+ID4gIC0+IGZyZWV6ZV9iZGV2KCkKPiA+ICAtPiB0aGF3X2JkZXYoKQo+ID4gIC0+IGYyZnNf
c3RvcF9kaXNjYXJkX3RocmVhZCgpCj4gPiAKPiA+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4g
PiAKPiA+ID4KPiA+ID4gUmVwb3J0ZWQtYnk6ICJMaWdodCBIc2llaCAo6Kyd5piO54eIKSIgPExp
Z2h0LkhzaWVoQG1lZGlhdGVrLmNvbT4KPiA+IAo=

