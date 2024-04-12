Return-Path: <linux-kernel+bounces-142333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4448A2A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26CA1C22AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4795F466;
	Fri, 12 Apr 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BJFW9reI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZT9GO3A0"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB805FB87;
	Fri, 12 Apr 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912470; cv=fail; b=Zydmno91jZ8mQ568Pf83U+5d7psBbeBCjunxt1eHWE0KOzZL+mSMmyp3q7oENW8b/ZLa45SUzOvwUwCVCMjq3GqET89f2OMYe0jumm4OxUAKo4Qdmgo5adrxpJ2b8B8OtB9B6xM0l1iYaDp2asgaFAK56zFsdOLGwTjE7btTL+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912470; c=relaxed/simple;
	bh=5YaglTU3AVz1+ABoUokeHVdSARoy6reHvriwgLYcPm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irWejuaOk2pdiicXcqnM7i334ZTFrzuNPghti6O91oYLk/HAvci5Acv3//J5QPxL/7foVuyYpKChXHOMKnRf2r67LJ07lm/CZ7I2VnnBl4L4n6HpudzVASdkRDRYmVpsMwgSoIU3T8V025+IRKg77ulebxlZyr15bMkXHCWa10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BJFW9reI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZT9GO3A0; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2eee805af8ab11eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5YaglTU3AVz1+ABoUokeHVdSARoy6reHvriwgLYcPm4=;
	b=BJFW9reIdDqQKLhJujj29pU6Mbm1OaxFW8EsNMkDoAOQteO1AUyY+d+cVHS/vvcI+4NZ5ho6wHak+mF32yjd0RYJ2gDcUHDuU4XaVnY98kmlstIlQ2njyBHouVte6GDZ3dHMKyzVq/I5h01i1IweQPYPtoWv4YKzGsfnX9UwOkk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9727ad0c-cc54-44b3-a570-d601c278dfca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:8b238091-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2eee805af8ab11eeb8927bc1f75efef4-20240412
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1494245794; Fri, 12 Apr 2024 17:01:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 17:00:59 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 17:00:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox9/uhQAs61Mq3BKZsCBQ9HXp/rkAKmSeDuu+F/9p8FtMlKAFsm33wczgc68Yj12ATqJ5X/Mohv+HM1UEy7c6NCVx9AiEfA92GseVdbh9Nv2GFAgaD/tZhmIRzN3RTZznAIOYQdJrbjKnAayLyf3MrmDZ3cSW7HUOdmJ+G9qr9tnW7u9oGn8z2ktV7qAkWY2YRKlCbhCeUEXBY+E/dgw+EZZldPaWeulvSza9IiwxLAL6nINO+vds58kT2HFCpW1X7Dl17zdyIzdALSCvn3PDzW5mjHP5UIAF7fZ+8ut/x7SVOBhIheaP71p0/2h1NWDFOp1ZWtYG65m1U6yv572XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YaglTU3AVz1+ABoUokeHVdSARoy6reHvriwgLYcPm4=;
 b=MfGLn+4jV5b9ZUOdKOksHz5blIAdd13nDC7PRHUjOUVT0+JbWxvmbm79sdp699454GcXrdFDc157ridvibujYSr3XQsc3nPxHLptLBqL7CvK2GgX9pek7el7ly/iXCtfsN66ztRsM45C6WFufWa3qAWeoXTKQ865ans2BHhmLH8t+vg/P4zbd82dfZmqq0/IKDTRaTUVHrhp0YzXV89QDbB45l0PO6jsyiFq2hHxLkF+HgPTfUNRnXVlDhJ+BGAquygT2NxFUy6Hsj7ckf2GMYngbXtQ87fBjVz3QPRH+aI2mtgKiZDyooCGrluRxVFo/QOTsoYuESHUNhBUsEG3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YaglTU3AVz1+ABoUokeHVdSARoy6reHvriwgLYcPm4=;
 b=ZT9GO3A01druTnyHMcPxJOVpxAPZOeSzZPSim8UCCyjaLkq8pdiDbEwKMk3Fh16WGYDjUcA7gyNVwjhBogWsCgo9lD5zp7gAGhmU8IKoGnphHPcYltWJr5bm4zaT70cdfz3qN4e8/5wKUinl//l9icbtxDpEgp7u41X4rf7yoAM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7575.apcprd03.prod.outlook.com (2603:1096:400:423::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 09:00:56 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 09:00:54 +0000
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
Thread-Index: AQHahbFYn7GUjisJlUGOm/8L6IGNq7FWsNGAgADVnQCAAK2ZAIABjPeAgAAcDYCAAZLzAIAE0f4AgAQieAA=
Date: Fri, 12 Apr 2024 09:00:53 +0000
Message-ID: <f38f46c4d3c81f86bd33d3b78e15dd42bc0797c5.camel@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
	 <20240403102602.32155-3-shawn.sung@mediatek.com>
	 <20240403-conflict-detest-717b4175a00c@spud>
	 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
	 <20240404-lankiness-devouring-d4d012b22cb9@spud>
	 <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
	 <20240405-remindful-galley-2dee9eec4f34@spud>
	 <f2476233528e18f78cdfa4eb7bc4c5ae91f70db8.camel@mediatek.com>
	 <20240409-scratch-rift-41f0967c2dc4@spud>
In-Reply-To: <20240409-scratch-rift-41f0967c2dc4@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7575:EE_
x-ms-office365-filtering-correlation-id: dc9699cb-ca26-471e-ecb6-08dc5acf0f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UFqzvJV/6kBnmJHZCs+erF6xUT6K8J+FanfxfzoTUYEIT57SVbTOqxPQdIWTZ5G+Uwa5Id0Q0j2Y9JTPY8hsOoAF2qHZ3LDevohmHrEOJ1yqjIrzotXfEM1hnd0ewfa1tQGRyLg1un53zOUYNAhLF1OCr+M+4IWiMI5+An7F9101BRNQrREGHB29S65hMrIo+mJvD58OI3p3NXrzV4LuIWr7co0lV7y6TI02LpllioyDlnnlzZxkpaUcfAzxP6u1d5yzon8uJLJ6UdesmB29YKgR7GFAycG8yrppe7subBNqq6FP+FAWTrb8rviYnyT9Ysm6aBKxmIXLPsfeIYQ64yjat5U94Y2g2+tmy7D8rgx5gO7tnU5J6npboiGDPLw780UxsileF03XhaFFVAEMyROtG9KMqa0j5A0J5sBY8h9QfB6RNCu3x20vyBnx7A5Q7Tw+sbcmAHE4DlrpG9prhJ6p8mEdK0h3ESmsm6f4g2geJ2HSahGpZ9PzeSSzMrd7lIUW7WseaBGyGvN6LBMXZPd7doJO9xOUVjhQW0djq7OvGZwZ9jofCCzTyOlCM+otzMSg0Sv9DX9RwFtQTBgTtdJ/I6IKVmxNU/g5GdxUqGlSXNpe9jovM37WLrBHITm86KuToF92ynx7bkBs1md7jKF91ypBCdqAz3CiwlvxVyGu4IHsG37p7UUSKmWl45vUPeB/jWgXUwiXfc9A5crdpz43XG8jKVHOxhOAFB2Ugg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elV0cWg3UFFBN2o2ZUJObk5IWkQrS2xVWjF6QUZmNW93MFc4YmlCMjZiVWFS?=
 =?utf-8?B?RjF6KzJ1amllRjN6Zk13bk9Sclprekw4MGZhMkg4R3hmMm1mVnJmZUZYeFV2?=
 =?utf-8?B?V3ZNc2lkZUVJT3B5NTVNRVk1emlES3dRSG95bDM0ZkJVaEVKMnlETXlTZ3B6?=
 =?utf-8?B?MzFDV0M1NlpPT0ZZMUtaUzFKOG1naytOaGNBNVNBbUhlTFlBRXFUTnRRNmhk?=
 =?utf-8?B?Q290cksvcTlaVTZnenFxTU5kdk9aVGNyaEV6NFpCcXhIUVk0UTRWbStlTnZu?=
 =?utf-8?B?MFBEekx4NE5yUTF1R2xSaGZ4dFpyV0drM1Q1Q1pHVWdaQW54Tm5KRHBhU2dB?=
 =?utf-8?B?SUhlQ2pvckpjTkx0REwwRVBLanAydUdOVFFXSnlScHByVVdMdlFaVWlMS1ZD?=
 =?utf-8?B?Q3RrY0lid2RhRjVNRTJ3c3Y5TjV3dGV1dUJyQ1JGUFRVb3UxbnpWYzQzUzY3?=
 =?utf-8?B?cVY5Qmx1SjRTekthbEpuMzRZSTFHdFNFSzFoTWtZekpRWlF4M2g0Q2xrSUJx?=
 =?utf-8?B?Tlo0Z0EwcThCV3NaZE9WblZpZ0YzN3YzMVhCNU5Id1VLMGdDdlJEY1VNMFJP?=
 =?utf-8?B?SFFSWDc1QmJjTWtnQkpzT21MVUxQTm51ZjExVlpLRGdyTUdmcGR1QUpFZ3VL?=
 =?utf-8?B?Ymg5LytYV3RRODh2TzBVcmg1NjRLclJyY3JHLzRwblgrQkNScU9qMG1pRFl4?=
 =?utf-8?B?U1E4OTJXNStpRjlBN1J1b25aRldWbUNDTTVvS25EY1BoalZHYlJyVEViY0Va?=
 =?utf-8?B?NlFEa21sTFM1amx0cnBlYU1CQkJraGNjRlozWWVhV3RrVjFrdmRYVDhtS3Nr?=
 =?utf-8?B?SmdreGZPTExYTWdFSUprbytiTk9nUDFqYnR4azE1ME9vL0pKbnVFY2tSVXFk?=
 =?utf-8?B?a2ozMm1Fb0NUV0ozRFA5MzcwclhkL3hIeWNKYU5GNlBiTXF3US84NHJ1dGxZ?=
 =?utf-8?B?RUlqbElFWERBcWVKYk5zbU43WDQ3MWNtZmt5S1ZpTm1lNStZdFFGd2grK3l5?=
 =?utf-8?B?eTBTT1Y3NEY1cmJBYktVVk9pVEJHc2crVG1xR3g0NjYyckJyOEk2bHBRZSti?=
 =?utf-8?B?Z2lCSmZlSWx5UDRTcmhRdEpGc1JLV3EvQWZQTmpKaEdMSjYzYjBMQjZOcjdv?=
 =?utf-8?B?WllJVGhsekcrOEh2Q2lETGJEUDNlNXNyaTBvbCthTEx0Z1M4ak4zOFVSTHYz?=
 =?utf-8?B?azV6TDJJSTl3Q1lNbDB0WUx5OTZqZ1ZDNFZPTGg5T293eHFXZGVQNGdOYTJv?=
 =?utf-8?B?bU5hZDVqUElVUFhIR3gwUHNKTEZDZUJvMmRMU3kvLzVTVEduSldHUmNvRnRp?=
 =?utf-8?B?VHRTeWNsQTR0VDVFbmxRRzQrNUhlSUJRa0tLamFJa21tV1EwbE1uMUZ3L01p?=
 =?utf-8?B?K3NUZjJBSDNTclNGZWkvaEs0NTNnOUdCbmlQZklZQURoNDN2M0ZOd1dIVVg0?=
 =?utf-8?B?Y3AwRUY3YjJEWm5QdjFkdk5WcjNpWWJhVVZMa3BlZlNBT2dnSVRIK0dxNWRC?=
 =?utf-8?B?U3RPMnhMZFpacE85ZHJmREsvWTA1YzhXWjcrbEdDME15Wld1L1FnMnRHL0xY?=
 =?utf-8?B?UDNaWURWOE8ySHRxUG52ZmJ5YTJMU3hwZ3VMWkZZNDhDTkc4VjhaS2toSzBu?=
 =?utf-8?B?ck9hSlJLUGtiWG9oSlJUUFZXZFhYZHNVazluK3cyWHNpY2RWVm5jTWg1QU9k?=
 =?utf-8?B?WWY3U21OSW5SVXVzQkVUNG8wMU1MS2FIT2czVmo5ZmdrOFowbFg4RjkxVmNE?=
 =?utf-8?B?OG1KbWMveWJBZUh0VVlvMmdjVmQxOTJrdEtkZmxrUDBQUXJ6ZlV6ZDh4cXln?=
 =?utf-8?B?Unc2ZmZBWW9oRU5zMzYxcEJxamk3aGJjSjUrRHBmTXNZTXlSR1dlUkFJV2p4?=
 =?utf-8?B?cHBvRTY4N2htRThPbmpnWnBJOVh6S3M5QUZSOUlXM0hEUmNSWE9jTXpJdlhx?=
 =?utf-8?B?K2VUMUdwb0R5UW9rRWFmY0lwSWptTEdVZExqZkNjVXdTR21BWDd2SG8rL3JT?=
 =?utf-8?B?ZHozNnlQendPNWRTdnN3TDZoV2Y5SUtqUEhOKzYrcGhnaytmM3NSeFhyMGlZ?=
 =?utf-8?B?UGlMek9aWEJKVmpSOVNma3dHK1BMbDI5VnhVUCtYU1BoU0xsRFAvS0J4NGZI?=
 =?utf-8?B?TURmWEZQYllaK2VPaU1yTE1GTGZLT21lb2pjQTErOEJLUWpuazI5d2JJSThr?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D30CFCE65AC5E4188F528DF4A8CE149@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9699cb-ca26-471e-ecb6-08dc5acf0f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:00:53.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icl5o/So2J9gfsQWkluzPAkanGSAndCH66eRVb1HPTtEcYIw1+CsWg0RIpgI8icfFycIe7efzpnQ2cli8dDDrKAzqAElj/aMrCr4E1v/N1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7575
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.482100-8.000000
X-TMASE-MatchedRID: oll/cJ/dUC4OwH4pD14DsPHkpkyUphL9fjJOgArMOCao+b+yOP0oGIhF
	En/rCbw6XJHwgBAo9RpK0A62LggjSZTZ9V50RBQ7kkBrUL/4Vy5MkOX0UoduuQKzHKFHzLsJTo+
	d5kYVw/FC/9HFmT0PUY6PfzW2Y7wy0KO5SGxuaaThG1IOMb7PsMnlJe2gk8vIgrAXgr/AjP3j6f
	SiVX5Av1RKMTSTTuSA0Snp7c4pH3fI2RqSAXh33hlckvO1m+Jco4jW7zSDg9k0QmmUihPzrAdFf
	cUpjiwQjmyACjGw3SAtxLD7rfIMruHhSemIhY/OSEQN/D/3cG4hdi6zxllm1s/GMgxfN8H5sJC4
	m2jcjnwjp3MPfX9kRTq5q4U8+01l8RB6c8n4mAqwr5ZZVOw5da6xL0KIHMvxlL1/3IuU47KQKxu
	mdxDYer9bqluIoivMm2VH+qPYoSUFdAziKc3t6bdQIb8hCnY+4+ZcrqvCDkENht78/JfyBD5d5e
	olrj0R0U0F9PFnGmP/9kP++bIewkro3N/q9EtEu6cTLrgJBGoGwd8wUY9uMxjQD3m2MCf7C1GvP
	OqOdOHLaaqno0uWil4Y4UrAdMAvjf1TjH3joFfhuXUWQoMQtywJzaIVMjGtRL9uhZIYy12gE/e7
	oB73Yux5+3WN/fQdrzvWH03XqHoP5kb0rKmFexuZoNKc6pl+3b6LzJtd3JVUjspoiX02F/O+ms5
	efpt74vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.482100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E8ED5DD3F9E6962E4997ACAF2DAD9EC06417F1AD61437FD049C48BBAD4C10C6C2000:8

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDE4OjUyICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFNhdCwgQXByIDA2LCAyMDI0IGF0IDA0OjE1OjUxUE0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjQtMDQtMDUgYXQgMTc6MTMgKzAxMDAs
IENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgQXByIDA1LCAyMDI0IGF0IDAyOjMz
OjE0UE0gKzAwMDAsIEphc29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IE9uIFRodSwgMjAyNC0wNC0wNCBhdCAxNTo1MiArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3Rl
Og0KPiA+ID4gPiA+IE9uIFRodSwgQXByIDA0LCAyMDI0IGF0IDA0OjMxOjA2QU0gKzAwMDAsIEph
c29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gSGkg
Q29ub3IsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlld3Mu
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIFdlZCwgMjAyNC0wNC0wMyBhdCAxNjo0NiAr
MDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEFwciAwMywg
MjAyNCBhdCAwNjoyNTo1NFBNICswODAwLCBTaGF3biBTdW5nDQo+ID4gPiA+ID4gPiA+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiA+IEZyb206ICJKYXNvbi1KSC5MaW4iIDxqYXNvbi1qaC5saW5AbWVk
aWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEFkZCBtYm94ZXMg
dG8gZGVmaW5lIGEgR0NFIGxvb3BwaW5nIHRocmVhZCBhcyBhIHNlY3VyZQ0KPiA+ID4gPiA+ID4g
PiA+IGlycQ0KPiA+ID4gPiA+ID4gPiA+IGhhbmRsZXIuDQo+ID4gPiA+ID4gPiA+ID4gVGhpcyBw
cm9wZXJ0eSBpcyBvbmx5IHJlcXVpcmVkIGlmIENNRFEgc2VjdXJlIGRyaXZlciBpcw0KPiA+ID4g
PiA+ID4gPiA+IHN1cHBvcnRlZC4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8DQo+ID4gPiA+
ID4gPiA+ID4gc2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gPiA+ID4gIC4uLi9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiA+
ID4gPiA+ID4gPiBtYWlsYm94LnlhbWwgICAgICAgICB8DQo+ID4gPiA+ID4gPiA+ID4gMTANCj4g
PiA+ID4gPiA+ID4gPiArKysrKysrKysrDQo+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gZGlm
ZiAtLWdpdA0KPiA+ID4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21haWxib3gvbWVkaWF0ZWssZ2MNCj4gPiA+ID4gPiA+ID4gPiBlLQ0KPiA+ID4gPiA+ID4g
PiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2MNCj4gPiA+ID4gPiA+ID4gPiBlLQ0KPiA+
ID4gPiA+ID4gPiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4gPiA+IGluZGV4IGNlZjlkNzYw
MTM5ODUuLmMwZDgwY2M3NzA4OTkgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRp
YXRlayxnYw0KPiA+ID4gPiA+ID4gPiA+IGUtDQo+ID4gPiA+ID4gPiA+ID4gbWFpbGJveC55YW1s
DQo+ID4gPiA+ID4gPiA+ID4gKysrDQo+ID4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnYw0KPiA+ID4gPiA+ID4gPiA+IGUt
DQo+ID4gPiA+ID4gPiA+ID4gbWFpbGJveC55YW1sDQo+ID4gPiA+ID4gPiA+ID4gQEAgLTQ5LDYg
KzQ5LDE2IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiA+ID4gICAgICBpdGVtczoNCj4gPiA+
ID4gPiA+ID4gPiAgICAgICAgLSBjb25zdDogZ2NlDQo+ID4gPiA+ID4gPiA+ID4gIA0KPiA+ID4g
PiA+ID4gPiA+ICsgIG1lZGlhdGVrLGdjZS1ldmVudHM6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgVGhlIGV2ZW50IGlkIHdoaWNoIGlz
IG1hcHBpbmcgdG8gdGhlIHNwZWNpZmljDQo+ID4gPiA+ID4gPiA+ID4gaGFyZHdhcmUNCj4gPiA+
ID4gPiA+ID4gPiBldmVudA0KPiA+ID4gPiA+ID4gPiA+IHNpZ25hbA0KPiA+ID4gPiA+ID4gPiA+
ICsgICAgICB0byBnY2UuIFRoZSBldmVudCBpZCBpcyBkZWZpbmVkIGluIHRoZSBnY2UNCj4gPiA+
ID4gPiA+ID4gPiBoZWFkZXINCj4gPiA+ID4gPiA+ID4gPiArICAgICAgaW5jbHVkZS9kdC1iaW5k
aW5ncy9nY2UvPGNoaXA+LWdjZS5oIG9mIGVhY2gNCj4gPiA+ID4gPiA+ID4gPiBjaGlwcy4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IE1pc3NpbmcgYW55IGluZm8gaGVyZSBhYm91dCB3
aGVuIHRoaXMgc2hvdWxkIGJlIHVzZWQsDQo+ID4gPiA+ID4gPiA+IGhpbnQgLQ0KPiA+ID4gPiA+
ID4gPiB5b3UNCj4gPiA+ID4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiA+ID4gPiBpdA0KPiA+ID4gPiA+
ID4gPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLQ0K
PiA+ID4gPiA+ID4gPiA+IGFycmF5aQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gV2h5
IGlzIHRoZSBJRCB1c2VkIGJ5IHRoZSBDTURRIHNlcnZpY2Ugbm90IGZpeGVkIGZvciBlYWNoDQo+
ID4gPiA+ID4gPiA+IFNvQz8NCg0KRGlkIEkgbWlzdW5kZXJzdGFuZCB0aGUgSUQgaGVyZT8NCkkg
dGhvdWdodCB3ZSB3ZXJlIHRhbGtpbmcgYWJvdXQgZXZlbnQgSURzLCBidXQgaXQgbG9va3MgbGlr
ZSB3ZSBhcmUNCnRhbGtpbmcgYWJvdXQgbWJveCBJRHMuDQoNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgZm9yZ290IHRvIHN5bmMgd2l0aCBTaGF3biBhYm91dCB0
aGlzOg0KPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMTI0MDEx
NDU5LjEyMjA0LTEtamFzb24tDQo+ID4gPiA+ID4gPiBqaC5saW5AbWVkaWF0ZWsuY29tDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IEknbGwgZml4IGl0IGF0IHRoZSBuZXh0IHZlcnNpb24uDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hlbiBJIHNheSAiZml4ZWQiIEkgZG9uJ3QgbWVhbiAidGhp
cyBpcyB3cm9uZywgcGxlYXNlIGZpeA0KPiA+ID4gPiA+IGl0IiwgSQ0KPiA+ID4gPiA+IG1lYW4N
Cj4gPiA+ID4gPiAid2h5IGlzIHRoZSB2YWx1ZSBub3Qgc3RhdGljIGZvciBhIHBhcnRpY3VsYXIg
U29DIi4gVGhpcw0KPiA+ID4gPiA+IG5lZWRzIHRvDQo+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiBl
eHBsYWluZWQgaW4gdGhlIHBhdGNoIChhbmQgdGhlIGRlc2NyaXB0aW9uIGZvciB0aGUgZXZlbnQN
Cj4gPiA+ID4gPiBoZXJlDQo+ID4gPiA+ID4gbmVlZHMNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+
IGV4cGxhaW4gd2hhdCB0aGUgZ2NlLW1haWxib3ggaXMgcmVzZXJ2aW5nIGFuIGV2ZW50IGZvciku
DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPaCwgSSBzZWUuIFRoYW5rcyBmb3Igbm90
aWNpbmcgbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBXZSBkbyB3YW50IHRvIHJlc2VydmUgYSBzdGF0
aWMgZXZlbnQgSUQgZm9yIGdjZS1tYWlsYm94IHRvDQo+ID4gPiA+IGRpZmZlcmVudA0KPiA+ID4g
PiBTb0NzLiBUaGVyZSBhcmUgMiBtYWlubHkgcmVhc29ucyB0byB3aHkgd2Ugc2V0IGl0IGluIERU
UzoNCj4gPiA+ID4gMS4gVGhlcmUgYXJlIDEwMjQgZXZlbnRzIElEcyBmb3IgR0NFIHRvIHVzZSB0
byBleGVjdXRlDQo+ID4gPiA+IGluc3RydWN0aW9ucw0KPiA+ID4gPiBpbg0KPiA+ID4gPiB0aGUg
c3BlY2lmaWMgZXZlbnQgaGFwcGVuZWQuIFRoZXNlIGV2ZW50cyBjb3VsZCBiZSBzaWduYWxlZCBi
eQ0KPiA+ID4gPiBIVw0KPiA+ID4gPiBvciBTVw0KPiA+ID4gPiBhbmQgdGhlaXIgdmFsdWUgd291
bGQgYmUgZGlmZmVyZW50IGluIGRpZmZlcmVudCBTb0MgYmVjYXVzZSBvZg0KPiA+ID4gPiBIVw0K
PiA+ID4gPiBldmVudA0KPiA+ID4gPiBJRHMgZGlzdHJpYnV0aW9uIHJhbmdlIGZyb20gMCB0byAx
MDIzLg0KPiA+ID4gPiBJZiB3ZSBzZXQgYSBzdGF0aWMgZXZlbnQgSUQ6IDg1NSBmb3IgbXQ4MTg4
LCBpdCBtaWdodCBiZQ0KPiA+ID4gPiBjb25mbGljdA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZXZl
bnQgSUQgb3JpZ2luYWwgc2V0IGluIG10ODE5NS4NCj4gPiA+IA0KPiA+ID4gVGhhdCdzIG5vdCBh
IHByb2JsZW0sIHdlIGhhdmUgY29tcGF0aWJsZXMgZm9yIHRoaXMgcHVycG9zZS4NCj4gPiANCj4g
PiBJIGFncmVlIHRoYXQgY29tcGF0aWJsZXMgY2FuIGRvIHRoZSBzYW1lIHRoaW5ncy4NCj4gPiAN
Cj4gPiA+IA0KPiA+ID4gPiAyLiBJZiB3ZSBkZWZpbmVkIHRoZSBldmVudCBJRCBpbiBEVFMsIHdl
IG1pZ2h0IGtub3cgaG93IG1hbnkgU1cNCj4gPiA+ID4gb3INCj4gPiA+ID4gSFcNCj4gPiA+ID4g
ZXZlbnQgSURzIGFyZSB1c2VkLg0KPiA+ID4gPiBJZiBzb21lb25lIHdhbnRzIHRvIHVzZSBhIG5l
dyBldmVudCBJRCBmb3IgYSBuZXcgZmVhdHVyZSwgdGhleQ0KPiA+ID4gPiBjb3VsZA0KPiA+ID4g
PiBmaW5kIG91dCB0aGUgdXNlZCBldmVudCBJRHMgaW4gRFRTIGVhc2lseSBhbmQgYXZvaWQgdGhl
IGV2ZW50DQo+ID4gPiA+IElEDQo+ID4gPiA+IGNvbmZsaWN0aW5nLg0KPiA+ID4gDQo+ID4gPiBB
cmUgdGhlIGV2ZW50IElEcyBub3QgZG9jdW1lbnRlZCBpbiB0aGUgcmVmZXJlbmNlIG1hbnVhbCBm
b3IgdGhlDQo+ID4gPiBTb0MNCj4gPiA+IGluDQo+ID4gPiBxdWVzdGlvbj8gT3IgaW4gZG9jdW1l
bnRhdGlvbiBmb3IgdGhlIHNlY3VyZSB3b3JsZCBmb3IgdGhlc2UNCj4gPiA+IGRldmljZXM/DQo+
ID4gPiBBDQo+ID4gPiBEVFMgc2hvdWxkIG5vdCBiZSB0aGUgYXV0aG9yaXRpdmUgc291cmNlIGZv
ciB0aGlzIGluZm9ybWF0aW9uIGZvcg0KPiA+ID4gZGV2ZWxvcGVycy4NCj4gPiA+IA0KPiA+IA0K
PiA+IFRoZSBldmVudCBJRHMgd2VyZSBkZWZpbmVkIGluOg0KPiA+IGluY3VsZGUvZHQtYmluZGlu
Z3MvbWFpbGJveC9tZWRpYXRlayxtdDgxODgtZ2NlLmguDQo+ID4gDQo+ID4gPiBBZGRpdGlvbmFs
bHksIHRoZSBkcml2ZXIgY291bGQgdmVyeSBlYXNpbHkgZGV0ZWN0IGlmIHNvbWVvbmUgZG9lcw0K
PiA+ID4gaGFwcGVuDQo+ID4gPiB0byBwdXQgaW4gdGhlIHJlc2VydmVkIElELiBUaGF0IGNvdWxk
IGJlIGdlbmVyaWNhbGx5IHVzZWZ1bCAoSU9XLA0KPiA+ID4gY2hlY2sNCj4gPiA+IGFsbCBvZiB0
aGVtIGZvciByZS11c2UpIGlmIHRoZSBJRCBhcmUgdG8gbm90IGFsbG93ZWQgdG8gYmUNCj4gPiA+
IHNoYXJlZC4NCj4gPiA+IA0KPiA+ID4gPiBUaGUgcmVhc29uIHdoeSB3ZSBkZWZpbmUgYSBldmVu
dCBJRCBpcyB3ZSB3YW50IHRvIGdldCBhIFNXDQo+ID4gPiA+IHNpZ25hbA0KPiA+ID4gPiBmcm9t
DQo+ID4gPiA+IHNlY3VyZSB3b3JsZC4gV2UgZGVzaWduIGEgR0NFIGxvb3BpbmcgdGhyZWFkIGlu
IGdjZS1tYWlsYm94DQo+ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiB0bw0KPiA+ID4gPiB3YWl0IGZv
ciB0aGUgR0NFIGV4ZWN1dGUgZG9uZSBldmVudCBmb3IgZWFjaCBjbWRxIHNlY3VyZQ0KPiA+ID4g
PiBwYWNrZXRzDQo+ID4gPiA+IGZyb20NCj4gPiA+ID4gc2VjdXJlIHdvcmxkLg0KPiA+ID4gDQo+
ID4gPiBUaGlzIHNvcnQgb2YgaW5mb3JtYXRpb24gbmVlZHMgdG8gYmUgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLCBidXQgSQ0KPiA+ID4gZG9uJ3QNCj4gPiA+IHRoaW5rIHRoaXMgcHJvcGVydHkgaXMg
bmVlZGVkIGF0IGFsbCBzaW5jZSBpdCBzZWVtcyB0byBiZQ0KPiA+ID4gc29tZXRoaW5nDQo+ID4g
PiBkZXRlY3RhYmxlIGZyb20gdGhlIGNvbXBhdGlibGUuDQo+ID4gDQo+ID4gSSB0aGluayBwdXQg
dGhpcyBldmVudCBJRCBpbiBkcml2ZXIgZGF0YSBhbmQgZGlzdGluZ3Vpc2ggdGhlbSBieQ0KPiA+
IGRpZmZlcmVudCBjb21wYXRpYmxlcyBjYW4gYWNoaWV2ZSB0aGUgc2FtZSB0aGluZy4NCj4gPiAN
Cj4gPiBIb3dldmVyLCBJIG9yaWdpbmFsbHkgdGhvdWdodCB0aGF0IGFsaWduIHRvIHRoZSBleGlz
dGluZyB3YXkgbGlrZQ0KPiA+IE1VVEVYLCBDQ09SUiwgV0RNQSBpbiANCj4gPiANCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDEyNDAxMTQ1OS4xMjIwNC00LWphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20NCj4gPiAgd291bGQgYmUgYmV0dGVyIGNob2ljZS4NCj4gPiBJIHRoaW5rIHRo
ZWlyIHVzYWdlIG9mIGdjZS1ldmVudHMgYXJlIHRoZSBzYW1lLiANCj4gPiANCj4gPiBXaGF0IGRv
IHlvdSB0aGluaz8NCj4gDQo+IFRvIG1lIGl0IGNvbWVzIGRvd24gdG8gd2hldGhlciB0aGUgSURz
IGFyZSBmaXhlZCBvbiBhIHBhcnRpY3VsYXIgU29DDQo+IChpbg0KPiB3aGljaCBjYXNlIHRoZXkg
Y2FuIGJlIGRlZHVjZWQgYnkgdGhlIGNvbXBhdGlibGUpIG9yIG5vdC4gSSBkb24ndA0KPiByZWFs
bHkNCj4gc2VlIGhvdyB0aGlzIGlzIGFjdHVhbGx5IGEgZml4ZWQgcHJvcGVydHkgb2YgdGhlIFNv
QyB0aG91Z2gsIGlmIHlvdQ0KPiBjYW1lDQo+IGFsb25nIHRvbW9ycm93IHdpdGggYSAiZ2NlLTIu
MCIgeW91IGNvdWxkIHRvdGFsbHkgZW5kIHVwIHdpdGgNCj4gZGlmZmVyZW50DQo+IG51bWJlcmlu
ZyBiZWNhdXNlIChhcyBmYXIgYXMgSSBjYW4gdGVsbCkgdGhpcyBudW1iZXJpbmcgaXMgYWN0dWFs
bHkgYQ0KPiBwcm9wZXJ0eSBvZiB0aGUgb3MtZmlybXdhcmUgaW50ZXJmYWNlLCBub3QgYWN0dWFs
bHkgYSBwcm9wZXJ0eSBvZiB0aGUNCj4gU29DIGl0c2VsZi4gSSB3YXMgZXhwZWN0aW5nIHlvdSB0
byBzYXkgIm5vIiB3aGVuIEkgYXNrZWQgaWYgdGhlIElEcw0KPiB3ZXJlDQo+IGZpeGVkIGZvciBh
IGdpdmVuIFNvQyBiZWNhdXNlIGNoYW5naW5nIHRoZSBmaXJtd2FyZSAvY291bGQvIGNoYW5nZQ0K
PiB0aGUgSURzLg0KPiBBbHRob3VnaCwgSSB0aGluayB5b3UnZCBsaWtlbHkgbm90IGV2ZXIgd2Fu
dCB0byBjaGFuZ2UgdGhlbSwgYmVjYXVzZQ0KPiB0aGF0J2QganVzdCBiZSBhbiBhbm5veWluZyBB
QkkgYnJlYWsgdG8gZGVhbCB3aXRoLg0KPiANCg0KbWJveCBJRHMgYXJlICJub3QiIGZpeGVkIHBy
b3BlcnR5IG9mIHRoZSBTb0MuDQoNCg0KU29tZSBvZiB0aGUgZXZlbnQgSURzKEhXIGV2ZW50KSBh
cmUgZml4ZWQgb2YgdGhlIFNvQyBhbmQgc29tZSBvZiB0aGUNCmV2ZW50IElEcyBhcmUgbm90IGZp
eGVkIG9mIHRoZSBTb0MuDQpTbyB3ZSBuZWVkIHRvIGNoYW5nZSB0aGUgbm9uLWZpeGVkIGV2ZW50
IElEcyB0byBtYWtlIHN1cmUgdGhleSB3b24ndA0KY29uZmxpY3QgdG8gdGhlIGZpeGVkIGV2ZW50
IElEcyBvZiBhbm90aGVyIFNvQy4NCg0KPiBXaGF0IEkgdGhpbmsgaXMgdGhhdCB5b3UgbmVlZCB0
byB3cml0ZSBhIHByb3BlcnR5IGRlc2NyaXB0aW9uIHRoYXQNCj4gZXhwbGFpbnMgd2hhdCB0aGUg
bWFpbGJveCBpcyB1c2luZyB0aGUgZ2NlIGNoYW5uZWwgZm9yIHNvIHRoYXQNCj4gc29tZW9uZQ0K
PiBjYW4gcG9wdWxhdGUgdGhlIHByb3BlcnR5IGNvcnJlY3RseS4gVGhlIGNvbW1pdCBtZXNzYWdl
IGFsc28gbmVlZHMgdG8NCj4gZXhwbGFpbiB3aHkgdGhpcyBpcyBub3QgYSBmaXhlZCB2YWx1ZSBm
b3IgYSBnaXZlbiBTb0MuDQo+IA0KDQpUb3RhbGx5IGFncmVlIQ0KDQo+IEFuZCB5ZXMsIGFzIHlv
dSBwb2ludGVkIG91dCBlYXJsaWVyIGluIHRoaXMgdGhyZWFkLCBTaGF3biBuZWVkcyB0bw0KPiB1
cGRhdGUgdGhpcyB0byBoYXZlIGEgcmVmZXJlbmNlIHRvIHRoZSBnY2UtZXZlbnRzIGJpbmRpbmcg
d2hpY2ggaGFzIGENCj4gZ3JlYXQgZGVzY3JpcHRpb24gaW4gaXQgb2Ygd2hhdCBhIGdjZSBldmVu
dCBpcy4NCj4gDQo+ID4gSSB0aGluayB0aGVpciB1c2FnZSBvZiBnY2UtZXZlbnRzIGFyZSB0aGUg
c2FtZS4gDQo+IA0KPiBBbHNvLCBqdXN0IGJlY2F1c2UgYSBwcm9wZXJ0eSBnb3QgaW50cm9kdWNl
ZCBkb2Vzbid0IG1lYW4gdGhhdCBpdCBpcw0KPiBjb3JyZWN0IGFuZCBhZGRpbmcgbmV3IGluc3Rh
bmNlcyBjYW4gZGVmaW5pdGVseSBieSByZXF1aXJlZCB0bw0KPiBwcm92aWRlDQo+IGp1c3RpZmlj
YXRpb24sIG5vdCBqdXN0IHNheWluZyAiaXQncyB1c2VkIGJ5IHh5eiB0b28iLg0KPiANCg0KU3Vy
ZSwgSSB0aGluayB3ZSBuZWVkIHRvIGFkZCBtb3JlIGV4cGxhbmF0aW9uIGZvciB3aGF0IHdlIHVz
ZSBhIG1ib3gNCmNoYW5uZWwgZm9yLg0KDQpJIHRoaW5rIHRoZSBtYWluIHJlYXNvbiBpcyB3ZSB3
YW50IHRvIHJlcXVlc3QgYSBtYm94IGNoYW5uZWwgZm9yDQpzZW5kaW5nIGEgbG9vcGluZyBjb21t
YW5kIHRvIEdDRSB0aHJlYWQuIFRoZSBsb29waW5nIGNvbW1hbmQgd2lsbCBnZXQgDQpzZWN1cmUg
dGFzayBkb25lIGV2ZW50IHNpZ25hbCBldmVyeSB0aW1lIGZyb20gc2VjdXJlIHdvcmxkIGFuZCBu
b3RpZnkgDQpDTURRIGRyaXZlciB0byBkbyB0aGUgc2FtZSBvcGVyYXRpb24gYXMgdGhlIElSUSBo
YW5kbGVyLg0KDQpUaGlzIGNhbiByZWR1Y2UgdGhlIGxhdGVuY3kgb2Ygc29mdHdhcmUgY29tbXVu
aWNhdGlvbiBiZXR3ZWVuIHNlY3VyZQ0Kd29ybGQgYW5kIHdlIGNhbiBhbHNvIHJlbW92ZSB0aGUg
Y29tcGxleCBsb2dpYyBhZnRlciBldmVyeSBzZWN1cmUgdGFzaw0KZG9uZSBpbiB0aGUgc2VjdXJl
IHdvcmxkLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gQ2hlZXJzLA0KPiBDb25vci4N
Cg==

