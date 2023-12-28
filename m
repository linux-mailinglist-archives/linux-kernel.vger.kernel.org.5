Return-Path: <linux-kernel+bounces-12359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA181F3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A46EB22B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C6C17CD;
	Thu, 28 Dec 2023 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nqfjNyjK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VFnfD4Jk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911F882A;
	Thu, 28 Dec 2023 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c7a5fe0aa52111eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VoeB3wg5oCRYQCbWGs5vWoT6/+tMH3a/YzrB9/IquUQ=;
	b=nqfjNyjKpHgLkh8ubLowT9RYnnd/QIO7dP2AV8S+h9t8JSXslP0vN3oPoVpFkalqiPHuvvZUR2agyAI9ux5tGgqjTxJ0bxZogPYo/zSO1phx94ewwbYeKhUAJvteFPkLCj6jcIeVcW6cHAowPr9AizGe+BHrLslSHntPx9kqvDA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d002be18-bf28-4340-a4a0-3a54356717c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:65258f2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c7a5fe0aa52111eea2298b7352fd921d-20231228
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1362123834; Thu, 28 Dec 2023 09:38:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 09:38:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 09:38:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPSsgH1CJKn6z6vzuf+msXkuUecTOIFU+s289XEIxtQTNKIGGkmEJy4xL7XuX46TslY1LdpkMoK7k+UN2r32fdrW4DWBZSz7FFnURaLMHVSrUK9Ghl12WQfStdUrDC4NsVPhZ8Yuyi4jxnAbaK5PvsT+McK2lrmZ/WzL+quHDYwypHGK899ZJv/Kf1e8DbuC/Ii+yX0wnnx6YFVYYASqnezT2Vgh6qKIuakkt9rrEX/SxLGSayh4zYmjy/nSFpi5WDhHm5gcleC0fD9MkLo0MLJZUhzjwh0WZHoDmUdzQsSvAhHvtwhaKcdDC9lxgehha4yFH0p2zTP3aBxRCiZJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoeB3wg5oCRYQCbWGs5vWoT6/+tMH3a/YzrB9/IquUQ=;
 b=ZQGKKQb+6pEnhUVGCtcnhw1QRAL0hkGn13T1K9AieusZv1dIzUYl8eZGDx0W7VyTOxwQVnI81SY1pLQi+nv1GaJy1v+dAj4cdNa247q3FW6+fEs2JP6t23Lzzv/AXjLC2GGIeca5BZzTPg3rwhhzG/cYu2tydRzP9TrgqISX1c9/53djPAkmPT4URaoO+HVmVQR1ufQbLY4LN0W1oJDoiCk36iyKMm0+Wbeg5PC37oYmzn36ckNcR2OugdJWvSdtHgt22U65EuhbYX2G4IihUHf7RopdflVyEPOwV2nShd7FMlx4B4CSYe8NZFLK3TvcJYdipOt74GipmxvAngKHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoeB3wg5oCRYQCbWGs5vWoT6/+tMH3a/YzrB9/IquUQ=;
 b=VFnfD4JkIMZS2Gz5168zhsXmWhv+sRJq+BOBLDkPdOxEGi7B+NVSYViPNEo64imXld4mgCvqANOFZ3UJ/NA8Xa9QfB9DsniU4gNNObe12IoiiwTC1gMFglLmS1ZDhe6hUzHwlzKGz35lIRNmZT0CKg4WnPihUtYzR6gUl+ILTt4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB8176.apcprd03.prod.outlook.com (2603:1096:405:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 01:38:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 01:38:15 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7Sk8AgAF4JwCAATFvAA==
Date: Thu, 28 Dec 2023 01:38:15 +0000
Message-ID: <f3a8c0cbdcf5da0381eaee5e0595319cd1970dde.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <f338215fb8f7ff1e0ebeb0f1e21a8b4dec5f0c61.camel@mediatek.com>
	 <83db5f669a6404ba3bf65ecd7b024af2509c19dc.camel@mediatek.com>
In-Reply-To: <83db5f669a6404ba3bf65ecd7b024af2509c19dc.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB8176:EE_
x-ms-office365-filtering-correlation-id: 588153fa-6343-4977-fbcf-08dc0745a973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rnamIPk7iqTrVcN2qr/hEUZUQ0hj00+G/HU6KvzeNz3O1At4AAv7rNI5tXn0mJgBDtBqqYT3+++uha/iGP2e//2fKpx7Pobr+jtktkryoqTgi/DV/zii2K8Ch3JCq2IKy6rrrUDqBc1CbWePPdFZwH2YutjweIWP1JjG3o4PKGXC6BYjFsusJwgaB74pXoeFwjWOjSrlCsOebiT/gTYuQb72iTEzPc4I7veVawEIU3xvTzdE6bz2I0Srxc8tf4hd7Y5B0QAjzgaAENoGFOQCHcYY5xL53+3aTzQ1sGle9dZ4XbHSJOeBPwL1SZ5jaGWter245xJjmgP8CqvN6Z/mbkpjQrpV0cTRnRgYgvDpQSME+mBcuBvb3blWtZbXY46KLx3Zngorj3rlEPS/61TjdvS6s+rDPoikeIVrY92tUEqYxT84Qwr4Ou404GW5mxZCRpz3q/9u78zTVYm1/+IKTyClWV/wpJxTm65lbU/kHcXczj2iUdRtx1wLjvI36RfOZxHNOCjy4Gt8oiSlz+yloLTOCfx1nUqGTXQEf1g1pbJFshZe1rN+I9kmDug3TUipR9MhbLyya2+rst8BZaE3VZ5nJlvUqy6aFuMN37aW/I8mmXNHGQ3mHQVgwEUtAAB861mxGY/D8VSMTwgIjXmYShlS7bjeuQxex+9rdh//pQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(2616005)(5660300002)(15650500001)(26005)(7416002)(83380400001)(4001150100001)(2906002)(76116006)(66946007)(110136005)(54906003)(316002)(66556008)(66476007)(66446008)(64756008)(6486002)(6506007)(6512007)(4326008)(478600001)(8936002)(8676002)(71200400001)(41300700001)(122000001)(38100700002)(38070700009)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGwvNW1HK0FUSENoVGhibElxeWhnQzFnbFVaT24wQjh2SGlhQ0oxUElJKzlO?=
 =?utf-8?B?N2tHVkltRDVseFo1a2ZTcXBxbEtBa1Y5OW94ZXppYys2S1R4a2prRzI5OUZi?=
 =?utf-8?B?L0JpbDhocnRONHBybkkwWFVWZzdVbVMvZGEvU0VSVWp4VjNlMjJlRWt4VTZq?=
 =?utf-8?B?cFFIeVBtR21BRURGVVBLandHWmR3anBDVlhPV0tzYm1JT0ZhcGVOTW9Ec0tG?=
 =?utf-8?B?S3JmMmtpMlp3dXE2MlBlMzcwOWxYOG5sMHJVMnJZcC93ZTJ3OHJqdVQ3c1dm?=
 =?utf-8?B?MGZ2YU1oRitIUDhSajRNVk9OZzRpdkVGZ1c3bmpwc2tsa05ubWh2bjBFU0ZD?=
 =?utf-8?B?QkVnQllQWldyS3ZTWGN6bVY2bk9oNXJMbVlFRFY2WWthQ2dNYUMyZldFRFM1?=
 =?utf-8?B?RFpzSVY5bHZ1Mm9ZdEVZVlVINTEzaUxNVktTOHU3UnBlTFJYbWcxOXdIQUhU?=
 =?utf-8?B?T3U5ZjYyR1hVb3h4RThsQ2VoR2V6V3k1RFZFNU5NUEVOUENUV3E5QlhOSFU5?=
 =?utf-8?B?TUZ5Zmhzb0hnT3RTTVlNSmVrSS9YMXFuWXRhNExQUy9QdTNYUFVVbEg4Rjdy?=
 =?utf-8?B?ZkszRy8xK21MWmFTcnZXS3pra0gwTlJOTnVZLzRXSWlMOG5lMmhhanVWZ0Vp?=
 =?utf-8?B?RmJTOU92VTd1bW5zbUZKblhsbGJvL2FwSGIrVFFXQk9JQXlFL0ZoN09rS2ZV?=
 =?utf-8?B?MHpBU1JweVVQQ2oySWtVTTBvQS9RTEFORFNjVk0waUFPMDhRaGtjRENCbVFR?=
 =?utf-8?B?NE04OHNhSjNBeHg4b3NoMGJPcTE3M3JNQ2JRZDJDSys0SE5KLzBiL09MRW9z?=
 =?utf-8?B?S09LRG5DQVpPRXpEUmNlMWQ1YklsajFhTlVLeHlnVUdGT0ZGVThXWVRQY3Fa?=
 =?utf-8?B?cGhwd0tOT3dra0JHNGdkTk9tODdRdGUwWGprRGxqZEs4NTFVU01pZ2hCbzBC?=
 =?utf-8?B?MkxhbUpWRE9VdytSZVpCdnl1QnRhenMxT1RiTFN5WFN5YmxVa3JReThEZFZp?=
 =?utf-8?B?UnVaUkROcmRDdUd1VjJKNXJXaS9aalllczBiR01EUDRxVUxmdURvSlVsRG42?=
 =?utf-8?B?WTB5c1Jla08ra3Z0YThuRHQ1YWRRQW1MMzBQYnhkckt3T3JlSGxpRlJDNDIx?=
 =?utf-8?B?V3k1T29QK3ExZTd3dUJBTThVaUZXSGE0TXBEWGRKQXRUcmRTUU81MUE5MnJh?=
 =?utf-8?B?WXhDenpTUmhwS0FidDJrUDhXZlF0YWlOdk9ocTQwR1FSTWFXWXhPa2taeXFw?=
 =?utf-8?B?c1IzZjZSOHBSOVNZSTVTLzZpWWlEeHFNVHMwcDJ3TFVwUnRadGlOcE9vK1pB?=
 =?utf-8?B?TEdsZEZYUHR4YmVrR0t4cTZYbGlIVk5vdUFQdXlPWTZZN2xYWk1BOVpGQnN5?=
 =?utf-8?B?UGYwTGtBNzBpVnRhR2M2TU5Ka1UySTRFWFdGaGNUWHd1dE94NjZRUS9yNkV4?=
 =?utf-8?B?TkVGNTArZG9QVStWWEhHSnVBNEJKUnliK0JIemgwZnc0Zk5wTHZ2RHJGdHc0?=
 =?utf-8?B?ZjIzRkEyQmFMb3NkeHJ5WXFDbmpwaTk5ZUczQVNQdDdYdVBLQjZuc2FJTlo4?=
 =?utf-8?B?QlYyd25EaUtkQUJzQ3pXakQ2ak5HVmthM1BRQUlxbnhPWVIycDNjUDlDTW9V?=
 =?utf-8?B?RW1lQzRnRGpxQi82N0JaOEIxQWFDRmJXREt5V2FGU3pncExvRDk3aU5XZHNR?=
 =?utf-8?B?a3NTVkdWRlZBMjBCSzhUMTNScDFoNzBzQjVzRzNUc2l6aE8rSVZudVR5OVZU?=
 =?utf-8?B?Rm94cElXZm01Sk9nMU1zQ1ZOdXdNNkxJU0JIemxNR2kyUXlXazk4NVZmSkY3?=
 =?utf-8?B?MEJiUmQ1NzBFb3VFT3N4U3pEZmFFRmlRYlByL2R1Si80YTYxSUlHWFhTV3Vv?=
 =?utf-8?B?aGxlUFlZRkxzVlRJa0EyLzFzSkpWZFl3aGtta1lxaGNDNitSRnJMc3RQanRX?=
 =?utf-8?B?UmlMNHllSlR6TnBPOWxnSWNpdkx5V0F2WUNscFZQMWQ1OWZIZ2xTS3BqWm5Z?=
 =?utf-8?B?eGZtdjVYZERkeGlhazRBQVZXc25UUVRSUHh2eXhUVFVQTTFBYnVoYkd4Ym54?=
 =?utf-8?B?cEpzeXp0VG92ZXVzRmU5S2tZY1lpUXNIclZVNmcyYTYvQWZaRmxPbzJuZlBO?=
 =?utf-8?Q?GW++HZ1N5KyqI6wWhe1u4jaz1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1498604554FC44190495FED5650365A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588153fa-6343-4977-fbcf-08dc0745a973
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 01:38:15.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCTB29HmmsyDC8kyBzyLIIedjzo+jYFtQUYJWqhlaIjPPlHY3RMQTcTXyl+z3uMjps55jhLhVyaf2+ATy0j4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8176

T24gV2VkLCAyMDIzLTEyLTI3IGF0IDA3OjI1ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gDQo+
IE9uIFR1ZSwgMjAyMy0xMi0yNiBhdCAwODo1OCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3Jv
dGU6DQo+ID4gSGksIEphc29uOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1
MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlk
ZW8gcGF0aCBmZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFkL3dyaXRlDQo+ID4gPiByZWdpc3RnZXJz
DQo+ID4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ugd2lsbCBlbmFibGUgdGhlIHNlY3VyZSBh
Y2Nlc3MgcGVybWlzc2lvbg0KPiA+ID4gdG8NCj4gPiA+IHRoZQ0KPiA+ID4gSFcgd2hvIHdhbnRz
IHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0KPiA+ID4gDQo+ID4gPiBBZGQg
Q01EUSBzZWN1cmUgbWFpbGJveCBkcml2ZXIgdG8gbWFrZSBDTURRIGNsaWVudCB1c2VyIGlzIGFi
bGUNCj4gPiA+IHRvDQo+ID4gPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1
cmUgd29ybGQuIFNvIHRoYXQgR0NFIGNhbg0KPiA+ID4gZXhlY3V0ZQ0KPiA+ID4gYWxsIGluc3Ry
dWN0aW9ucyB0byBjb25maWd1cmUgSFcgaW4gdGhlIHNlY3VyZSB3b3JsZC4NCj4gPiA+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gDQo+ID4gW3NuaXBdDQo+ID4gDQo+ID4gPiArDQo+ID4gPiArc3Rh
dGljIGludCBjbWRxX3NlY19maWxsX2l3Y19tc2coc3RydWN0IGNtZHFfc2VjX2NvbnRleHQNCj4g
PiA+ICpjb250ZXh0LA0KPiA+ID4gKwkJCQkgc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNr
LCB1MzINCj4gPiA+IHRocmRfaWR4KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGl3Y19jbWRx
X21lc3NhZ2VfdCAqaXdjX21zZyA9IE5VTEw7DQo+ID4gPiArCXN0cnVjdCBjbWRxX3NlY19kYXRh
ICpkYXRhID0gKHN0cnVjdCBjbWRxX3NlY19kYXRhICopc2VjX3Rhc2stDQo+ID4gPiA+IHRhc2su
cGt0LT5zZWNfZGF0YTsNCj4gPiA+IA0KPiA+ID4gKwl1MzIgc2l6ZSA9IDAsIG9mZnNldCA9IDAs
ICppbnN0cjsNCj4gPiA+ICsNCj4gPiA+ICsJaXdjX21zZyA9IChzdHJ1Y3QgaXdjX2NtZHFfbWVz
c2FnZV90ICopY29udGV4dC0+aXdjX21zZzsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHNlY190YXNr
LT50YXNrLnBrdC0+Y21kX2J1Zl9zaXplICsgNCAqIENNRFFfSU5TVF9TSVpFID4NCj4gPiA+IENN
RFFfVFpfQ01EX0JMT0NLX1NJWkUpIHsNCj4gPiA+ICsJCXByX2Vycigic2VjX3Rhc2s6JXAgc2l6
ZTolenUgPiAldSIsDQo+ID4gPiArCQkgICAgICAgc2VjX3Rhc2ssIHNlY190YXNrLT50YXNrLnBr
dC0+Y21kX2J1Zl9zaXplLA0KPiA+ID4gQ01EUV9UWl9DTURfQkxPQ0tfU0laRSk7DQo+ID4gPiAr
CQlyZXR1cm4gLUVGQVVMVDsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlpZiAodGhyZF9p
ZHggPT0gQ01EUV9JTlZBTElEX1RIUkVBRCkgew0KPiA+ID4gKwkJaXdjX21zZy0+Y29tbWFuZC5j
bWRfc2l6ZSA9IDA7DQo+ID4gPiArCQlpd2NfbXNnLT5jb21tYW5kLm1ldGFkYXRhLmFkZHJfbGlz
dF9sZW5ndGggPSAwOw0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArCX0NCj4gPiA+
ICsNCj4gPiA+ICsJaXdjX21zZy0+Y29tbWFuZC50aHJlYWQgPSB0aHJkX2lkeDsNCj4gPiA+ICsJ
aXdjX21zZy0+Y29tbWFuZC5zY2VuYXJpbyA9IHNlY190YXNrLT5zY2VuYXJpbzsNCj4gPiA+ICsJ
aXdjX21zZy0+Y29tbWFuZC5lbmdfZmxhZyA9IHNlY190YXNrLT5lbmdpbmVfZmxhZzsNCj4gPiA+
ICsJc2l6ZSA9IHNlY190YXNrLT50YXNrLnBrdC0+Y21kX2J1Zl9zaXplOw0KPiA+ID4gKwltZW1j
cHkoaXdjX21zZy0+Y29tbWFuZC52YV9iYXNlICsgb2Zmc2V0LCBzZWNfdGFzay0+dGFzay5wa3Qt
DQo+ID4gPiA+IHZhX2Jhc2UsIHNpemUpOw0KPiA+IA0KPiA+IEkgdGhpbmsgaXQncyBub3QgbmVj
ZXNzYXJ5IHRvIGNvcHkgZnJvbSBub3JtYWwgY29tbWFuZCBidWZmZXIgdG8NCj4gPiBub3JtYWwN
Cj4gPiBjb21tYW5kIGJ1ZmZlci4gSnVzdA0KPiA+IA0KPiA+IGl3Y19tc2ctPmNvbW1hbmQudmFf
YmFzZSA9IHNlY190YXNrLT50YXNrLnBrdC0+dmFfYmFzZTsNCj4gPiANCj4gPiBZb3UgaGF2ZSBh
IHNlY3VyZSBjb21tYW5kIGJ1ZmZlciBmb3Igc2VjdXJlIGdjZSB0byBleGVjdXRlIGNvbW1hbmQu
DQo+ID4gSWYNCj4gPiB5b3Ugd2FudCB0byBtb2RpZnkgY29tbWFuZCBidWZmZXIsIGNvcHkgZnJv
bSBub3JtYWwgY29tbWFuZCBidWZmZXINCj4gPiB0bw0KPiA+IHNlY3VyZSBjb21tYW5kIGJ1ZmZl
ciwgYW5kIG1vZGlmeSB0aGUgc2VjdXJlIGNvbW1hbmQgYnVmZmVyLg0KPiA+IA0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiANCj4gDQo+IEkgdGhpbmsgc2VjdXJlIHdvcmxkIHdvbid0
IHJlY29nbml6ZSBub3JtYWwgd29ybGQncyB2YSwgc28gd2UgbmVlIHRvDQo+IGNvcHkgdG8gaXdj
X21zZy0+Y29tbWFuZC52YV9iYXNlLCB3aGljaCBpcyBhIHdvcmxkIHNoYXJlIG1lbW9yeQ0KPiBm
aXJzdC4NCg0KUmVmZXJyaW5nIHRvIGNtZHFfc2VjX2FsbG9jYXRlX3dzbSgpLCBhbnkga2VybmVs
IGJ1ZmZlciBjb3VsZCB1c2UNCnRlZV9zaG1fcmVnaXN0ZXJfa2VybmVsX2J1ZigpIHRvIGJlY29t
ZSBzaGFyZSBidWZmZXIgYmV0d2VlbiBub3JtYWwNCndvcmxkIGFuZCBzZWN1cmUgd29ybGQuIElu
IGNsaWVudCBkcml2ZXIsIHVzZSB0ZWVfY2xpZW50X29wZW5fY29udGV4dCgpDQp0byBjcmVhdGUg
dGVlIGNvbnRleHQgYW5kIHJlZ2lzdGVyIG5vcm1hbCBjb21tYW5kIGJ1ZmZlciB0byBiZSBzaGFy
ZQ0KYnVmZmVyLiBUaGlzIHdvdWxkIHJlZHVjZSB0aGUgcmVkdW5kYW50IG1lbW9yeSBjb3B5Lg0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkguTGluDQo=

