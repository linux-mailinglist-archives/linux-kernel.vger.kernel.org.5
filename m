Return-Path: <linux-kernel+bounces-22505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DAA829EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A31F23330
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87CD4CE1C;
	Wed, 10 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L4/KjlFG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Lrr47Voy"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016F4CE06;
	Wed, 10 Jan 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 653c9796afd611eea2298b7352fd921d-20240111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6VmsA/WKKRZ7bWn/cof/bqlVD8AlG5Lh/ouP0o+yAQY=;
	b=L4/KjlFGBRblWHPwzTIkvXIFJXdRd4LR2hKghSeMLxd2S9b7EdPuLGofsAI+SI2OZpCuI3KPNb5qaGx2JmN3P2A01DasugNrSKV8GF12rzevPEJHAz6V5vGDiVu2NSv5i/wCUltCJX8VnhzNdfbVp0ZSkEzc6HUjDYurrDMwJ+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0e55a030-1c66-46a5-a7da-2ce576b6cc78,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:978b347f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 653c9796afd611eea2298b7352fd921d-20240111
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1164168954; Thu, 11 Jan 2024 00:36:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jan 2024 00:36:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Jan 2024 00:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chkFEVU7+wmGmUrzLaVvtFiUYI4o+EqvQmzlM5EhMecKUvVCSqLRiNCzkwKBeGXu3Nf4TO1GjJFTmsjtTIaI6Q7m3dLzgZUcJ0mdIHnU5ihSwpQVj2/nrQJlQTKxBcGJNgPjUoutf9LkD/EGFa8IoTdEgKHRiBK6lFsQIrcOxt6AYFKk5pSBnni2lAsZR5Zpf6xQjclyITS89yBaBUx5EwWX8MsWVoseOgVcrBRYWp3OPJSjBSQtbHlbk9fvKHC9DY3QqeqOM2+OEGkLe2QoXqXcZU8SEzwQS/2/2iZZC8K+m2WoHrmS7XcePqB8GkDuT/FxF4lZ87oMbjBjCBDmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VmsA/WKKRZ7bWn/cof/bqlVD8AlG5Lh/ouP0o+yAQY=;
 b=V7KQw1vDONfZWSUzKjZa6VI6xqa/MfA9U7EOmRVf7mKyfGNJDuFQ719U1idThcESUE4PKV4PQV4oIzXWXK1RhhEUkh5DUkdiIVu2wwkxz//sPQPROA7Mpam2w68aZCQh3T5Nhz0x+Iq+lIajoODsBRNgrFdd6covNBbE8wnNQ5gdwTuCLjgiMch61t+e0Sdhy9aOGVFCmJYZ/W3eX5FrmLuTGwomtzS9puAY7+jxlkjbShfE/S5AgdyDFHRSM0zcV+Vj2FNnPi+cfv5drWEBqDyxj0FRtudCqKRy1WJDPwiaSbdgnoQDRM1qk3dVhxeFpjD5mtP9M4ok1y+MB3Q84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VmsA/WKKRZ7bWn/cof/bqlVD8AlG5Lh/ouP0o+yAQY=;
 b=Lrr47VoyZiQBS9suYnK+OAvvCTTiwnnY41YQs3mHbXNTBBtX2orwbzZP/ECnLYUm7qcjMrRdldn9PCkDOFW9VSv8thvoecCLZgUdkxDfH+hCgJC1acmQHxW5LGrHNIK7R/WGqmgs0auzcZmfCYTC0Z+dxndJaoV4rrHErZsk2Ms=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB8921.apcprd03.prod.outlook.com (2603:1096:990:93::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:36:21 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 16:36:21 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Topic: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Index: AQHaQ49Q/kjMpPuFZkuoMhc+qwpaZbDS2qqAgABkfoA=
Date: Wed, 10 Jan 2024 16:36:20 +0000
Message-ID: <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
	 <20240110-grumbling-tattling-0202fc5e21f2@spud>
In-Reply-To: <20240110-grumbling-tattling-0202fc5e21f2@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB8921:EE_
x-ms-office365-filtering-correlation-id: 0e24ce41-7543-4e85-a3db-08dc11fa46fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vCNpS+uVLLDOYgzPgOQGoJcdlTf2ZgZVvUSrNHqUc1rswoEIETuhNvyeFD3OJTdKzZ2a+2Z+lzRmq5dgECLJZXvwfQACiw0cuLX9pp0SpIjnoyXT+KAtVwEWxNSpFC/dkcu0+50GJs1+Lo0t8iJtedSX8tbrWy66MmIEhmykgUTCdWQldXoDecI+yP5ePT0rUFW9J9E7yfAXC2Fq4RK6SX7x6JY1t4/8+8dTc0gtx+uXL7WhHz8kYDh2zp9iR081TcsVK+59AN7wOAIA0dEqBsse24nvK5X0ZZtkLSnVryr2iqmh4ceBX70aQXhm+SEBcQ3ZiCZr6a3l0CzlJP7O9m4Xe/ZLWEOtm9GPDT4Teczh374mtTYAl/QnLP/kSd8hnZ8FI9JWZeL6924fuu1E1w2oUYN1U34ncEkfK+UuSysCvLWoMnQ+8qv96MLtj8FIM2YT/rATaLcnkXNk20RW8LE3tRZeP0MeqWTlOK8+wZ5uaaQo3bN1a0oQyEyOO6Wc+K3nynj5J0O0r6fnoMom2760t79gJhdJ0ZhmwO6md/OeCzm2niExkyrFMIcySHag84KD+J6me9FaZ1Q2Lr3T4ewYbHnHhzr3FEcWT19K4dJ1I72atQProuaGWEgrgDAaRkUgKxpUXxa/S/NNbvzqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(71200400001)(478600001)(6506007)(2616005)(966005)(6512007)(26005)(86362001)(38100700002)(38070700009)(122000001)(85182001)(36756003)(41300700001)(2906002)(91956017)(4326008)(5660300002)(83380400001)(15650500001)(7416002)(8676002)(76116006)(8936002)(6916009)(6486002)(64756008)(66446008)(54906003)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkpzZGh1K290NnlqSVRPNzlIem9CeHhldEtzVGJURE10MjZ6R3BPZHFKaUVN?=
 =?utf-8?B?bm1aNzlXRmIyNllPY3FHODYzUDl3eENKdDN4QnRUbllSYXRkei9uNmo0ZFVm?=
 =?utf-8?B?bFFiK2pTV0RDeSsyMDZ4VXc0Yk9Md05XTStwbi9KZFA0MGZxYVlvaGNneGF3?=
 =?utf-8?B?VnZRdktZMnJDaFdKYmE1ZmFtSHcydjR6YkN6TVFDWlJmOUVNa21VNkZTcVo2?=
 =?utf-8?B?dzBYSUUrRVYwVjF2U083YXZmQ28wUzVNeG1QRnNocFd4Mm1pYUdHc3d4NXh2?=
 =?utf-8?B?ajNrK2FIK1hnckhzSVBKUHFVY2FqYmFnbEwwNTBrNWNlSFg3UVJML25QRSsw?=
 =?utf-8?B?Vm5TNWRxc2ovTk4zd21wQm9MOUx5ZW1XWUlvbDNBSGsxWk9BUjJFM1h1Sm13?=
 =?utf-8?B?dExoV0MxeUJuSWdnNVY4TnBpWERCRUJjYUVRMWxrRGtiWm4wSnlYSzJMT0pG?=
 =?utf-8?B?aldSVFBEZjY0MnloU21PVDVyS0NYQ1NsSmgxN2NkckRUamRYM0w0b2tDYmJE?=
 =?utf-8?B?MXlHVk94b1RiR3B5M1ZBbjhvNm5LK3VKaFVKdEk2TFozTzZ2bDl1WDFiZkpE?=
 =?utf-8?B?SFdKYW8wMUlZWmg0RUpvTkdVUlpjd043U05VdThmeG9UbXJCSGI3UTBCR2hH?=
 =?utf-8?B?ak16UjQvSVdSSS9BZjRBMm5UY1NDejAybkg1Wk1JQUNDQ0xtRDlSTm03OGVt?=
 =?utf-8?B?ZUxyQjQ1Z3lGMUo0VzJLZGxSRjhvVVZCY0JiOVVVVmJ0S0VSNm5FU2FIbG1E?=
 =?utf-8?B?a085NEFEbE5NcXU0aW1sMnNkaW9MV2NEeTZaUmVNbU1mOTNyQ1ViNS9iamg1?=
 =?utf-8?B?VkdlN2FsZkJCQURSVnFXaFdISkY0bGtlNUx1TWZxSHJGVW5rMjZodlQwdkJD?=
 =?utf-8?B?NEMzVGJ1V0c0MVJScHV0WXlTUEdNZXZLY1JPVmQ5ajFMRGNQdjJ5NTUxZDgy?=
 =?utf-8?B?SWlMVndSNzZPRW1TUE1TRmd5VklRUU9Tb1o0bEF2V2dHM0s3QWdDbEllaFNz?=
 =?utf-8?B?OTZ0dkVOdHVtcmphT3haM0U2UU9nN2FuTlVneGFROFora202V2lHZnZVNVpH?=
 =?utf-8?B?ZXVDeU5XWE85MnF0RFgwMkpxQmxvWnNqZlowdmFjS0FxQm9yaHY3RjN4K0dx?=
 =?utf-8?B?azE4elZlNzNZazY4elhwWE9wM0p1c0pDeFRCYjQ2L0ZKSXNLb285YzYwZ0FS?=
 =?utf-8?B?QWx1WFE5YjVZV2hOdTM0N3VaUWEzNTZsS3JMUW1ZMVNMa1RhNzJiY3lMdEV0?=
 =?utf-8?B?Vnp5TGJUTGl5aUNMaEFJb2xuZU51YjZaVGdEN0FPbHNIN2RVbHlHK0l0VWZo?=
 =?utf-8?B?TFpWaEtacDBlMUU2bFR3dTRHMlljdmg4UnBvdCtLMXNDVmQ0Rm5qcURZYTBm?=
 =?utf-8?B?NlM5cm5ESlM5V2xqY3RKZFVkOXZiR2ptZC9hUnFHVlVPOWJoQ0N4NDF5T3po?=
 =?utf-8?B?S3pIbWZ5VHlzcGVreEdIaitFNjdNK2I5c0UyM1YvZXpzSFNqeFgxZ1hWbHk3?=
 =?utf-8?B?MFRXZC9IeVFsclpUdVFDQitUaHlSdCtQdWZiLzFjMEFqOVRjMGxwL3lyazFU?=
 =?utf-8?B?UW05aHZMQllHaGtRYTlIVlZEOEl2SEJ1Rm5uUUFoRjNpcnN1eTdJaWYwd3Rw?=
 =?utf-8?B?MG1mZk5vb2orYS8vbVVNU0czN3ZFSExVZDFVbzBmalVVeGx0NWF3U2VlYlI2?=
 =?utf-8?B?cGsyenNMSmJ0UktrenhCbW5NK01TOENySU9DTE9DZ2lsR3c3UGdRTjZ2Z1Zu?=
 =?utf-8?B?UytSQzhTTnZhcDZ2cTliU3pLZEduQWpMYWZoQ3B2V1ErMm1HK043RElSL3I3?=
 =?utf-8?B?TW95NDZmUndJRHowTU1sNExBTHJtci9pcGlwUTYzMFFQYWZ3RkxWK0VhQktP?=
 =?utf-8?B?ZHBVVWVIeTUxTDV2bXZNRXEvSUlSRnp3MHQ4OTBvZkl6MU1LR2pSODlHQVM2?=
 =?utf-8?B?Rm1FY3JjbUxLaXo2bHk0c1ZjSGZHS1F4aWpwTWtUYTE2ckxtMWlaVHovRGpw?=
 =?utf-8?B?bWpCYjNEQTF0Ty9hcFdHeEpGUm1mUjNDTVdCK0szQ1ZLeWZJdVB5Y0Z6TlRF?=
 =?utf-8?B?R2RTMnVKVkFab2hwVDBpN0NGKzV2a2poTTdmclJYWHR2cWFBUFNFZ3ZVcDZG?=
 =?utf-8?B?ZTRxZXNrc1hrQXZUMXZGUkVrcUxGR29BVXhsZ2dIekkwSk5YdWJNVXRJeUdm?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB8EC6F69E48AE4E8BC6A9871AFA30B4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e24ce41-7543-4e85-a3db-08dc11fa46fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 16:36:20.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkiwKXMFMgswrL+uprcKZ3G9D0Su/1agNnU5GqoE8WRpYX8Sily2xwagW338XRb//Qo1jbq92pMbtA0hrVHTRVDQ65gMASqi+0CXqKwph4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8921

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFdlZCwgMjAyNC0wMS0x
MCBhdCAxMDozNiArMDAwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBXZWQsIEphbiAxMCwg
MjAyNCBhdCAwMjozNTozMFBNICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gMS4gQWRk
ICJQcm92aWRlciIgdG8gdGhlIHRpdGxlIHRvIG1ha2UgaXQgY2xlYXJlci4NCj4gPiAyLiBBZGQg
cmVmZXJlbmNlIHRvIGdjZS1wcm9wcy55YW1sIGZvciBhZGRpbmcgbWVkaWF0ZWssZ2NlLWV2ZW50
cw0KPiA+IHByb3BlcnR5Lg0KPiANCj4gSSBjYW4gc2VlIHRoaXMgZnJvbSB0aGUgZGlmZi4gVGhl
cmUncyBzdGlsbCBubyBleHBsYW5hdGlvbiBoZXJlIGFzIHRvDQo+IHdoeSB0aGUgbWFpbGJveCBw
cm92aWRlciBuZWVkcyB0byBoYXZlIGEgZ2NlLWV2ZW50IGlkLiBOQUsgdW50aWwgeW91DQo+IGNh
bg0KPiBleHBsYWluIHRoYXQuDQo+IA0KU29ycnkgZm9yIG1pc3NpbmcgdGhlIHJlYXNvbiBpbiBj
b21taXQgbWVzc2FnZSwgSSdsbCBhZGQgaXQgaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNClRoZXJl
IGFyZSAyIHJlYXNvbnMgd2h5IHRoZSBtYWlsYm94IHByb3ZpZGVyIG5lZWRzIGdjZS1ldmVudHM6
DQoxLiBUaGUgbWFpbGJveCBwcm92aWRlciBoZXJlIGlzIENNRFEgbWFpbGJveCBkcml2ZXIuIEl0
IGNvbmZpZ3VyZXMgR0NFDQpoYXJkd2FyZSByZWdpc3RlciBieSBDUFUgZGlyZWN0bHkuIElmIHdl
IHdhbnQgdG8gc2V0IHRoZSBkZWZhdWx0IHZhbHVlDQpmcm9tIDAgdG8gMSBmb3Igc3BlY2lmaWMg
Z2NlLWV2ZW50cyBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIG9mIENNRFENCmRyaXZlci4gV2Ug
bmVlZCB0byB0ZWxsIENNRFEgZHJpdmVyIHdoYXQgZ2NlLWV2ZW50cyBuZWVkIHRvIGJlIHNldCBh
bmQNCkkgdGhpbmsgc3VjaCBHQ0UgaGFyZHdhcmUgc2V0dGluZyBjYW4gZ2V0IGZyb20gaXRzIGRl
dmljZSBub2RlLg0KDQoyLiBXZSdsbCBoYXZlIHRoZSBzZWN1cmUgQ01EUSBtYWlsYm94IGRyaXZl
ciBpbiB0aGUgZnV0dXJlIHBhdGNoIFsxXS4NCkl0IHdpbGwgcmVxdWVzdCBvciByZXNlcnZlIGEg
bWFpbGJveCBjaGFubmVsLCB3aGljaCBpcyBhIGRlZGljYXRlIEdDRQ0KdGhyZWFkLCBhcyBhIHNl
Y3VyZSBJUlEgaGFuZGxlci4gVGhpcyBHQ0UgdGhyZWFkIGV4ZWN1dGVzIGEgbG9vcGluZw0KaW5z
dHJ1Y3Rpb24gc2V0IHRoYXQga2VlcHMgd2FpdGluZyBmb3IgdGhlIGdjZS1ldmVudCBzZXQgZnJv
bSBhbm90aGVyDQpHQ0UgdGhyZWFkIGluIHRoZSBzZWN1cmUgd29ybGQuIFNvIHdlIGFsc28gbmVl
ZCB0byB0ZWxsIHRoZSBDTURRIGRyaXZlcg0Kd2hhdCBnY2UtZXZlbnQgbmVlZCB0byBiZSB3YWl0
ZWQuDQoNCg0KWzFdIGNtZHFfc2VjX2lycV9ub3RpZnlfc3RhcnQoKSBpcyB3aGVyZSB0aGUgR0NF
IHRocmVhZCBpcyByZXF1ZXN0ZWQgdG8NCnByZXBhcmUgYSBsb29waW5nIGluc3RydWN0aW9uIHNl
dCB0byB3YWl0IGZvciB0aGUgZ2NlLWV2ZW50Lg0KLSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMTIyMjA0NTIyOC4yNzgyNi05
LWphc29uLWpoLmxpbkBtZWRpYXRlay5jb20vDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K
PiBDaGVlcnMsDQo+IENvbm9yLg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1K
SC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCAgIHwgNg0K
PiA+ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiBtYWlsYm94LnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdj
ZS0NCj4gPiBtYWlsYm94LnlhbWwNCj4gPiBpbmRleCBjZWY5ZDc2MDEzOTguLjcyOGRjOTMxMTdh
NiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFp
bGJveC9tZWRpYXRlayxnY2UtDQo+ID4gbWFpbGJveC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+IG1haWxi
b3gueWFtbA0KPiA+IEBAIC00LDcgKzQsNyBAQA0KPiA+ICAkaWQ6IA0KPiA+IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCMNCj4g
PiAgJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+ID4gIA0KPiA+IC10aXRsZTogTWVkaWF0ZWsgR2xvYmFsIENvbW1hbmQgRW5naW5lIE1haWxi
b3gNCj4gPiArdGl0bGU6IE1lZGlhVGVrIEdsb2JhbCBDb21tYW5kIEVuZ2luZSBNYWlsYm94IFBy
b3ZpZGVyDQo+ID4gIA0KPiA+ICBtYWludGFpbmVyczoNCj4gPiAgICAtIEhvdWxvbmcgV2VpIDxo
b3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQo+ID4gQEAgLTU3LDYgKzU3LDggQEAgcmVxdWlyZWQ6
DQo+ID4gICAgLSBjbG9ja3MNCj4gPiAgDQo+ID4gIGFsbE9mOg0KPiA+ICsgIC0gJHJlZjogbWVk
aWF0ZWssZ2NlLXByb3BzLnlhbWwNCj4gPiArDQo+ID4gICAgLSBpZjoNCj4gPiAgICAgICAgbm90
Og0KPiA+ICAgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gQEAgLTY3LDcgKzY5LDcgQEAgYWxsT2Y6
DQo+ID4gICAgICAgIHJlcXVpcmVkOg0KPiA+ICAgICAgICAgIC0gY2xvY2stbmFtZXMNCj4gPiAg
DQo+ID4gLWFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICt1bmV2YWx1YXRlZFByb3Bl
cnRpZXM6IGZhbHNlDQo+ID4gIA0KPiA+ICBleGFtcGxlczoNCj4gPiAgICAtIHwNCj4gPiAtLSAN
Cj4gPiAyLjE4LjANCj4gPiANCg==

