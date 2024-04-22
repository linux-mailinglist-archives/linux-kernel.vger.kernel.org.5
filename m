Return-Path: <linux-kernel+bounces-152778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179E8AC41D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55BD1C21A98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440963FBA0;
	Mon, 22 Apr 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qVoS8Ook";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MzpZibF5"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C9DDA3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767035; cv=fail; b=qgZ7NhQ8Ryvs2U/rYVHG60xnepLzxmCREcW5MWRdMWBypeaed60J1/GdjvpEa09c03dvQD2YONe0/tbaEMM+S/c6yeccvQHimZqsOJJZruGkV6jaNNsGZsVY6Com7BtkaLlCOBIOWAo8wTTb32rBXBk2scKJLL3jjB46NEhgTfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767035; c=relaxed/simple;
	bh=gc7PJL2aybSfav4aqTX15hkAhS/9gNs5c97A1yVxJQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIQ+ZQB+BrzRxGhFiftLCNXmdBTxKiUECLnIcCqPzJF3w5npzKm1bVrROnnFp//JtD+JqwQkjhpKsaLBHr56q7WAIh0O9JpD37SeBu/Cl1SOXMyxjq+Ej7DdBaVzzmI1WSos8mESWSkyrp4Oj3clbfJBDVJiQnMQGW4N0X0J2d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qVoS8Ook; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MzpZibF5; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc6bf7ae007011efb8927bc1f75efef4-20240422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gc7PJL2aybSfav4aqTX15hkAhS/9gNs5c97A1yVxJQ8=;
	b=qVoS8OokjzSM3i+DTyM2hvlSDqyTM+OhBp/r3nOPk+7mknW9bfSGrXk6jnFD4OYNMmD+kwP0WdJEAvkBtAP3FLjHsbrSC4JI14JtUPfx12cBJ/ceihafw9WI8gMhc5bHt8z01Q4JkPMXpOBGVJS+mcFabAh0yU6OA4Cg7cH5XEc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:76a43ef1-b5e4-431e-a1a9-59619d38040d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:be51f482-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dc6bf7ae007011efb8927bc1f75efef4-20240422
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1521631390; Mon, 22 Apr 2024 14:23:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Apr 2024 14:23:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Apr 2024 14:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM9kPlfCa78v5yShWX2Gy/xaol+bI8IrhOv5OQKGnzX4t3KWy9FKLE5Ppkt5k7RuQKdBhIV0Q/OrKgPfgc3wlAvqLv/yPOR0eWqptUVUQxF23cwYRLc4uswrfWP2HuETju6y0j5p3JPZh0qTfVFUDevwhnyKi1ysepJ1qJiyxfMWToCn2tM1ihd7lCP2ZfC5mimf+zbmqw++sW4higsMc2pWdVv5V5BMg6gB5t10i6biZimMPUhHlDg46YQuw87PfIyb9bTDcleNpBlltG0820ECXyO5RdkfKG+FvcWA+Qx+Mh98ezBhW4ce2hQy54U6a5htxMWxcPZxxNTm2pUJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc7PJL2aybSfav4aqTX15hkAhS/9gNs5c97A1yVxJQ8=;
 b=lTfPD08StRurH/tBY4VK2ULJ2Th30OaqNZ95bsjMQ2NUVSXfmmIA82UrdWzi7CjAu+MnaHr9QbzsoX2ns8tq0beq9Q8Xzb22v3yKCjEEN1ePFQQ7LXpUgQRiUkVY9JmjBDh7bVDSveIBcQ+NaFA38Map15HpY9wPggjcClXTSOqp27uaVsznr9NQ0L/BzPbtRgeo5Bdomcf8zGxEeM8GJdcZGckAOm12QcgHJS4jsqsXgKbIdUiNSf89MA7M1WxsMhyojcW/Rwa9KJscXLj6yndWXi2gRWD81xa/44tJc3FF7RdAT4i+r5jzWJRu6fknVg3tJK84Iiat2eKP3eTsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc7PJL2aybSfav4aqTX15hkAhS/9gNs5c97A1yVxJQ8=;
 b=MzpZibF53S8MAVkIrhTGk6cS1mYZb87/Ka4MTAve5Ea15Yx0xE3r3K1B1aXMIJ1+URL4GXtp2ArTHhjxCo3wFW+1zwowvxtr9U3Qi23W0+5ib9EwE1P7QPMt/IXAU4nmDCyGs2sfm0d0yFDvQoG1jUUgYRxveBJYIunyIVf+2/A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8790.apcprd03.prod.outlook.com (2603:1096:101:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 22 Apr
 2024 06:23:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 06:23:34 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY
 Timing
Thread-Topic: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY
 Timing
Thread-Index: AQHajIdSbZjcHXFFMUWKfmXDcbZSALFz4iUA
Date: Mon, 22 Apr 2024 06:23:34 +0000
Message-ID: <ec0d3a66b0d0732a87f13ea1b1ce62bfc16605c9.camel@mediatek.com>
References: <20240412031208.30688-1-shuijing.li@mediatek.com>
In-Reply-To: <20240412031208.30688-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8790:EE_
x-ms-office365-filtering-correlation-id: 25511eec-b405-4018-45ea-08dc6294bd0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?cjczT21nUkFrTjhvbm5wU1BVRENNbzFFMDhjdllReHZTZ1E3TmdHZWFDOGZj?=
 =?utf-8?B?ME5JNkFzQm50cHV6MmNPeUZvKzNrM3FIQ0tuMDlZZTlwckJDZFQ5Y0FHY1pa?=
 =?utf-8?B?M3duV0JHT1Y2R1FIMEZqdW81VG1ScjZ0Yng4VzNhNjBLZDVENHJoL0FzbW5i?=
 =?utf-8?B?NGl2S3VueUM0UEZBdFJlSnFDbkE2dnYrQlVSOGtvOEJVTGErelZSNEtTTlZn?=
 =?utf-8?B?b1BvKys3enlCRTB3TEJmVGRnRlQ2TUNUQlpORTRaSHgrZXkxZXg1TDFDUVNs?=
 =?utf-8?B?UjlBWUpHQy85d1NnUGlVU01BaXFHRTA5S2FyWUZtRGZvN3lJbGw4aklZSVE5?=
 =?utf-8?B?cUtpTm1GRkhsMmo4cE5leDlNWWpJWGt5NG5DYlJBV3A3dDlFbDZVUVdpd0tM?=
 =?utf-8?B?czl3YllBT3ovdFVjZGthZk5xTDcyZ0M3K2YxdmswTVJnblZKY1JiUGwvL0J1?=
 =?utf-8?B?STZ5dG85ZkltUHkvZ2lMaVNTYURSdC9zUlZoNUpqUkx4cmJNa3NsRCtZSkM3?=
 =?utf-8?B?TXdLc2VQdjYvWUVGYThaQlZEdDM4dGNjR0V5S0ExRHFtSUxRejUzaC95WGlp?=
 =?utf-8?B?anltOWo2OGlXYmFRTXRTNDZWam1qbU9xR3c5TEFzaWN6OWR0WlVoaW5UMGlJ?=
 =?utf-8?B?Z0JseWVnU1VpOGx6MkZtV1JzRHd4bnU3aEtGd1o1VklBWUpXUXFxbGphc2Jt?=
 =?utf-8?B?SVMzUkk4VHo1aitGeG5hamRJaHhtVUYxcGQ3UmZReHJCa2ZkL0FzMW1qTWRO?=
 =?utf-8?B?N0NJT05DNW1zYVVQNS8zNFhFYkRzZW0yZmt4dWRyelVBU0d5SVdVMjZ1d0lP?=
 =?utf-8?B?MUlQWHhOQ2J3SDBZTVBiSXpZWlFndkJXTmlNWis2dWswRXNWUWZ1OFdoU2tu?=
 =?utf-8?B?aG5Pb2k4V2Jyc2JjMVZSSEV5aW9LNUY1eThnbGY2QnVaZlBVcFdXbGxRQVpT?=
 =?utf-8?B?L0VSd1dZZ2V2WTE0K2NETG5IUk81c3RXMHhmZkVYam1TQko2eDlWRFlxK1FS?=
 =?utf-8?B?RElmQlh2dUFaS1EzYmZLTVRnSHdJa3MzdEh3dXJBMnBxa1pqcWdOdmJtTUFW?=
 =?utf-8?B?WVY1L2lsUy9WOWVEaFNHVzY2bndoQ0hUeTk5YlAzanptaGV0elVLcFdGM3Bv?=
 =?utf-8?B?R1cwNGJaMUpwdTV0d3NSbC95Z3A0b0kxVUZPbGd6RUliZFNrdGpRUUVvMVZ3?=
 =?utf-8?B?SEV5UFVtMVRzL0hKYk5ZQUl1UmIvTHNDU0hNZm1wQ3pqOFAwL1d6SE82ZC80?=
 =?utf-8?B?T0wyQUVwZzJ3aXRLQit0UjZMN0psMHBjWWc1azEremhSb3YwbkpSWk53bHNH?=
 =?utf-8?B?OHZ1TEtGWWFOMXZuc1dqVW9rcXQvRk4ybDhnRFZLcFc2emFSdkFiNG1OVC9a?=
 =?utf-8?B?VWhlQ1d4c3JqNUtQcmtQM242cUxJdVlEWWViYnFtZElxeTZQUkMrZElYbjFB?=
 =?utf-8?B?SldIN0FvS1BqOGwyaEVtd0EzTnlzdSswYmcvYWNoYjNWcS9GVkJETy9oT0JB?=
 =?utf-8?B?OW05ZWdzWlMwYVJkSUZDbFRSdm9mS09XYUxTeVFnTll2WnhqTk4wVTlIN0FH?=
 =?utf-8?B?eUJyUnU0OTZWWG9oRkJWRXcycGg1RFpnb1dSS2FsTU0zWVMwSldrOU0rZTNJ?=
 =?utf-8?B?N0xRbFk1RDBNQ3Y2aXcyUnZ4UDNUdVlQc0ZrZ01zSlRINUw5T1EzdHN6dVBP?=
 =?utf-8?B?UUFiVDV2NzZxTnVadzdhQXBhR3VoL0h6cGFWYmlrQ2ZKVmJkRnZpOVVrdWlM?=
 =?utf-8?B?Qm81VkZwNHdMYlBCOXg4czJOZEVyWElrRFYwemZWRHl4V2x2Vzh1M3BPZFBo?=
 =?utf-8?B?aFM4WDRTUHRQTlBZWHMvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU1tWGZnRUN1TmRCWiswZEs1bEZKR2taMGgyempTU3E5TlFwaVV6WWUwRWJE?=
 =?utf-8?B?ZkNtV3FoT3pnL0pHWmdkSE1NRjVNeGY3MG1IcStuZ1ZLUkgrb0lpVGJ5U0Vj?=
 =?utf-8?B?UHg5ckFXMU5UdkNGV2FsZUtXQlFDb081a203ZTZoZGdyeDAvbUlzNWVVNnk2?=
 =?utf-8?B?M1EvNjNIZ0dUc0ZLYVYvVENVYURWYkp2aDJZSWxOZzk5OHU1cHBlRzdndTlq?=
 =?utf-8?B?a3EwV0JaNkhTR1dzZzJTZlU4am42bVBlZnRqU29yQ0k4UmJiRmZuUHgzSUMx?=
 =?utf-8?B?VW9SMFZsNmhHRGh3SnF2c3dKazRWYnBJQy9jVlgzYmlSb3EzWndlQWhpa1Ar?=
 =?utf-8?B?NVUrWUMxL2tRQWQ2SnVRc3pUem1IZ3A2WDd1RmRVY0xuaTdaMitIZCsyNmpK?=
 =?utf-8?B?S3BhbUFUQ0xqNXZ6S2JGL3RQbzJXMVRhenVtUU1ObnVhMHkxYW1NMHVXaVB1?=
 =?utf-8?B?YWx6a2xGSzVTbTdHVlRxdzh4VHdXZGtYdWFwVWdOVitSWWx6REFzVTFremg0?=
 =?utf-8?B?YStuYy9XL0NsRktoZFRxK2ZqZXUyQS9xMzhGN0l1NU54WWFZbVlXK0NCaXhW?=
 =?utf-8?B?VkVJTHY4YjRVUGtiYmVlUVdOVGNaL1U2MmlWWWNOUjBNclJGR1A5UVdFRWVu?=
 =?utf-8?B?bTg1T0JyQUlmMXJnZEZVc2l6ZUpMY0xBZ0JabmFsdWNYOXFNT0FRZTQ3VzhT?=
 =?utf-8?B?WmtyeTJaTnFPcVVqdUdTZmNNdzFiY2dML1MvYVd1elJQcUlmRzloMmJQb1FR?=
 =?utf-8?B?RCtCOU5rVm5lTFRsY01sVUVOaHhMcjEvWjBYOHU4Z2dtVW1yeDhlV09hVGNa?=
 =?utf-8?B?aGR5b3F5OWpoTW5xY3Q3V2JNaWc0LzZnWk4zaFYvUkliNk9YY014Q0FIN25m?=
 =?utf-8?B?Yi83TVNSTXAwL2dpdUF1eU00QVVoTmJnRXlyY1FNT0tMOVFvNGE0cnQ2WjYx?=
 =?utf-8?B?UHpSNjVxd0dWbWNwdzVyUmJPRlhES0FLa1N2WnFjUTVSMXpyQ0N6WDJkQyto?=
 =?utf-8?B?WWJoVE82MWtLTzc5VkQzbThHaTM3dEllYWlmZE8vTTMvVmMzTC9oajI4ZkFh?=
 =?utf-8?B?V2VJNFZEYlRBYjl4S3RWT3NpcDV2TldaVm5rVW1ZdlBzSzQyRHk5SlJrdldD?=
 =?utf-8?B?bFNuWmRzaCt2S2JLNnBNK1N3UkFWSldRaDAwSXFRelE4ZFV5WERDUEVrTnlY?=
 =?utf-8?B?R09JMFlEdUFyS0JkdnhBQlk4SVllKzlCU3JIc3pma0V4cnU5WHU3YVFXNWxN?=
 =?utf-8?B?VE1KYWZlS3FlRGI5N3VDb1o1ck9FQXhRTHJ2cUVhRncvTWwvWjRBcHdzd0x5?=
 =?utf-8?B?L3BWb0xadTdtYXlMYmkwdUZHaklLT1VqM1N3REZzRjY4ODhUQlZXRklIQmJy?=
 =?utf-8?B?TnArVzM0b0dmb3dnT2Z1VHU0K2huYTJkcEZmdkNkcTJhNFVHM1kyUlluSFln?=
 =?utf-8?B?UFB6TW5iSjV0T2lWK1FTU3hmNXBuSnc2ZjR4U2I1c3pROWJTYS9VdEFsbXdo?=
 =?utf-8?B?UjBCTmpoNmZXVkpnYTFYK1IyS29zMzJRUlJ0eERKLytNYnorNnVzd3F1RGlZ?=
 =?utf-8?B?U0poZmxyQW1Oc2JHUUZybEt0QVp1TytHZUJjYTVkT1RibFhVQWYxYTAwUTd5?=
 =?utf-8?B?R2thK2lWYmV6SWZGaUpsaURzVkhYSnAxN3VUQkxGaE9XanBTYllCL2JUOHI1?=
 =?utf-8?B?czFpZ1hzQWFoZkxLZXNZSWJPbHE2b3RCNngvakxLRFZoYWdlU1N2cUE1Mm1T?=
 =?utf-8?B?YmxRemtyY1hHNXpKTVhLaVF0QW1ZUlpCb0xqK1ZWSUR3UnNBV0xrZmNiQVMx?=
 =?utf-8?B?ZWJ4eGN5aXNNY1UrVkVJRUNzRENXZjUvUXR0cTZBbitJOGlNWTFMMHRuNlNm?=
 =?utf-8?B?R1NmcHcvOGNkZzNjWlBVMU5vZm1tem1aMDh2eG1QMEt4UmpHZ1VPQ3dVNXVU?=
 =?utf-8?B?S3lPYms2aGRKQjBncGJSY1NnK1NJMlFZRVRyS3NDMzNmV3p5ZW1EUXd3UStx?=
 =?utf-8?B?OGdGVnJmdUdxMmd6aldEdlJOZVhEZnN1VlpjZmlMaUFKMFYzUmZGakREYnRC?=
 =?utf-8?B?NkFkKzk3bW9Rem4rN3hNeGJoLzJMaHRSN0wwbDM0WlhUam8yeXZ2cm1GSXVo?=
 =?utf-8?Q?frGJV1W1pN6Oqi+P5svhSsGgp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <456E96C7DFC59E469F5D52664B71B035@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25511eec-b405-4018-45ea-08dc6294bd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 06:23:34.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LP5hgnEXQs7YviAYtk1nR+TbDQovowFDg313OO/dQdxC9DzO0IlyBH9cvYLdQtUKYldpDQUoi/8mXQYm+Lxw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8790
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.591500-8.000000
X-TMASE-MatchedRID: VPleTT1nwdTwwWEc4kIXNSa1MaKuob8PC/ExpXrHizwMMVVVmDalobOQ
	xA6xQbISZu4773m809bKOr+TkY7j/lhdPEiZHlm8U3amdi/Zkbun/jR8PqMWfgL65aBpm3K7Yyz
	kaNcuq8brCObItrgydK5Vf30gK3qOJkzQY65fggED2WXLXdz+AfQ7szeVKdNbDlLOAk1ICss9ds
	T2fWzZy+LzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG76sBnwpOylLNWYaJbd1fyoGkrh
	GPIEECi0SrCsVHXKyadUWl73acgYEKIXRN0CrrhYo+8SORNcZFpiwsY529pIt3msBi4YqeMkPud
	go7YgMC5ZyimlDMxyA56xhuba2WuZ86KY3oNT3zIO0Si2Tuenn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.591500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	42445767F6775CBA96E07D0FE76A63EDA63867EAC12017CF23D6F0DBCCDD50852000:8

SGksIFNodWlqaW5nOg0KDQpPbiBGcmksIDIwMjQtMDQtMTIgYXQgMTE6MTEgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGNvcnJlY3QgY2FsY3VsYXRpb24gZm9ybXVsYSBv
ZiBQSFkgdGltaW5nLg0KPiBUaGUgc3BlYyBkZWZpbmUgSFMtUFJFUEFSRSBzaG91bGQgYmUgZnJv
bSA0MG5zKzQqVUkoNDRucykgdG8NCj4gODVucys2KlVJKDkxbnMpLiBCdXQgY3VycmVudCBkdXJh
dGlvbiBpcyA4OG5zIGFuZCBpcyBuZWFyIHRoZQ0KPiBib3VuZGFyeS4NCj4gU28gdGhpcyBwYXRj
aCBtYWtlIHRoZSBkdXJhdGlvbiB0byA2NG5zIHNvIGl0IGlzIG5lYXIgdGhlIHNhZmUgcmFuZ2Uu
DQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gQWRkIGEgY29tbWl0IHRvIGRlc2NyaWJlIHRoZSBpbXByb3Zl
bWVudHMgdG8gdGhpcyBwYXRjaCBpbiBkZXRhaWwsDQo+IHBlciBzdWdnZXN0aW9uIGZyb21lIHBy
ZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQwMzE1
MDcyOTQ1LjE5NTAyLTEtc2h1aWppbmcubGlAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBB
UmJ3IWl6VFZ6aE4xb2U5Rk1EYXdRbHI5UjdQTmYwbjZ6N1pnY1N3OElVY05mY1p4QUpRNlJqYTlh
SGFVb0w3bElTYmRNSFV2T05hbzYtM193WmJzMGFINzJBJA0KPiAgDQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDMzICsrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCBh
MmZkZmM4ZGRiMTUuLmQxYmQ3ZDY3MTg4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jDQo+IEBAIC0yMzUsMjIgKzIzNSwyMyBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX3BoeV90
aW1jb25maWcoc3RydWN0DQo+IG10a19kc2kgKmRzaSkNCj4gIAl1MzIgZGF0YV9yYXRlX21oeiA9
IERJVl9ST1VORF9VUChkc2ktPmRhdGFfcmF0ZSwgMTAwMDAwMCk7DQo+ICAJc3RydWN0IG10a19w
aHlfdGltaW5nICp0aW1pbmcgPSAmZHNpLT5waHlfdGltaW5nOw0KPiAgDQo+IC0JdGltaW5nLT5s
cHggPSAoNjAgKiBkYXRhX3JhdGVfbWh6IC8gKDggKiAxMDAwKSkgKyAxOw0KPiAtCXRpbWluZy0+
ZGFfaHNfcHJlcGFyZSA9ICg4MCAqIGRhdGFfcmF0ZV9taHogKyA0ICogMTAwMCkgLyA4MDAwOw0K
PiAtCXRpbWluZy0+ZGFfaHNfemVybyA9ICgxNzAgKiBkYXRhX3JhdGVfbWh6ICsgMTAgKiAxMDAw
KSAvIDgwMDAgKw0KPiAxIC0NCj4gLQkJCSAgICAgdGltaW5nLT5kYV9oc19wcmVwYXJlOw0KPiAt
CXRpbWluZy0+ZGFfaHNfdHJhaWwgPSB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKyAxOw0KPiAtDQo+
IC0JdGltaW5nLT50YV9nbyA9IDQgKiB0aW1pbmctPmxweCAtIDI7DQo+IC0JdGltaW5nLT50YV9z
dXJlID0gdGltaW5nLT5scHggKyAyOw0KPiAtCXRpbWluZy0+dGFfZ2V0ID0gNCAqIHRpbWluZy0+
bHB4Ow0KPiAtCXRpbWluZy0+ZGFfaHNfZXhpdCA9IDIgKiB0aW1pbmctPmxweCArIDE7DQo+IC0N
Cj4gLQl0aW1pbmctPmNsa19oc19wcmVwYXJlID0gNzAgKiBkYXRhX3JhdGVfbWh6IC8gKDggKiAx
MDAwKTsNCj4gLQl0aW1pbmctPmNsa19oc19wb3N0ID0gdGltaW5nLT5jbGtfaHNfcHJlcGFyZSAr
IDg7DQo+IC0JdGltaW5nLT5jbGtfaHNfdHJhaWwgPSB0aW1pbmctPmNsa19oc19wcmVwYXJlOw0K
PiAtCXRpbWluZy0+Y2xrX2hzX3plcm8gPSB0aW1pbmctPmNsa19oc190cmFpbCAqIDQ7DQo+IC0J
dGltaW5nLT5jbGtfaHNfZXhpdCA9IDIgKiB0aW1pbmctPmNsa19oc190cmFpbDsNCj4gKwl0aW1p
bmctPmxweCA9ICg4MCAqIGRhdGFfcmF0ZV9taHogLyAoOCAqIDEwMDApKSArIDE7DQo+ICsJdGlt
aW5nLT5kYV9oc19wcmVwYXJlID0gKDU5ICogZGF0YV9yYXRlX21oeiArIDQgKiAxMDAwKSAvIDgw
MDANCj4gKyAxOw0KPiArCXRpbWluZy0+ZGFfaHNfemVybyA9ICgxNjMgKiBkYXRhX3JhdGVfbWh6
ICsgMTEgKiAxMDAwKSAvIDgwMDAgKw0KPiAxIC0NCj4gKwkJdGltaW5nLT5kYV9oc19wcmVwYXJl
Ow0KPiArCXRpbWluZy0+ZGFfaHNfdHJhaWwgPSAoNzggKiBkYXRhX3JhdGVfbWh6ICsgNyAqIDEw
MDApIC8gODAwMCArDQo+IDE7DQo+ICsNCj4gKwl0aW1pbmctPnRhX2dvID0gNCAqIHRpbWluZy0+
bHB4Ow0KPiArCXRpbWluZy0+dGFfc3VyZSA9IDMgKiB0aW1pbmctPmxweCAvIDI7DQo+ICsJdGlt
aW5nLT50YV9nZXQgPSA1ICogdGltaW5nLT5scHg7DQo+ICsJdGltaW5nLT5kYV9oc19leGl0ID0g
KDExOCAqIGRhdGFfcmF0ZV9taHogLyAoOCAqIDEwMDApKSArIDE7DQo+ICsNCj4gKwl0aW1pbmct
PmNsa19oc19wcmVwYXJlID0gKDU3ICogZGF0YV9yYXRlX21oeiAvICg4ICogMTAwMCkpICsgMTsN
Cj4gKwl0aW1pbmctPmNsa19oc19wb3N0ID0gKDY1ICogZGF0YV9yYXRlX21oeiArIDUzICogMTAw
MCkgLyA4MDAwICsNCj4gMTsNCj4gKwl0aW1pbmctPmNsa19oc190cmFpbCA9ICg3OCAqIGRhdGFf
cmF0ZV9taHogKyA3ICogMTAwMCkgLyA4MDAwICsNCj4gMTsNCj4gKwl0aW1pbmctPmNsa19oc196
ZXJvID0gKDMzMCAqIGRhdGFfcmF0ZV9taHogLyAoOCAqIDEwMDApKSArIDEgLQ0KPiArCQl0aW1p
bmctPmNsa19oc19wcmVwYXJlOw0KPiArCXRpbWluZy0+Y2xrX2hzX2V4aXQgPSAoMTE4ICogZGF0
YV9yYXRlX21oeiAvICg4ICogMTAwMCkpICsgMTsNCj4gIA0KPiAgCXRpbWNvbjAgPSB0aW1pbmct
PmxweCB8IHRpbWluZy0+ZGFfaHNfcHJlcGFyZSA8PCA4IHwNCj4gIAkJICB0aW1pbmctPmRhX2hz
X3plcm8gPDwgMTYgfCB0aW1pbmctPmRhX2hzX3RyYWlsIDw8IDI0Ow0K

