Return-Path: <linux-kernel+bounces-24279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026982BA38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6B8285698
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715A1B295;
	Fri, 12 Jan 2024 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vsv9YA5D";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TI7FkpWl"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3671B27B;
	Fri, 12 Jan 2024 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 82dea1dab0fe11ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0EgEFbbhTpvoNyv0r0F7Wo8PIH7mUE72L7yyRXHk4WU=;
	b=Vsv9YA5Dj36iIrnxRx1yYZgR4d9tbjaT/rratMTwEEeiJ7IwHsW14JuMSjwl7hoRwWr4d/c4NiCvAurFxwaRuiRyTiI/GNtr7x9ZyVZ9mJ0uer9GYJkd1Dx05cttT68Z6TnQ3My2xKE8rf418G9ExKsltAJB/clzgZpGLhcr1iM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b9ed0759-cab7-48cf-bc0f-450fdd92f5e1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:414d152f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 82dea1dab0fe11ee9e680517dc993faa-20240112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 507118493; Fri, 12 Jan 2024 11:56:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 11:56:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 11:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH3PHQJ2FCPaqPDovWmi8YpPFMrDMzB+fGs2o3MaiGAwAZvuhtlYjlO8eZV94p5OSyZs9He4YJC2sZhwAS0QaIJTGO63bc3pxXgRe+zaboTYNmFmPrNwSdAijEue+LEb9fMI8evQH/ZNdUl/TuU7mZUh9MDjpI4W/33Pm60vBPY/7XuRuHwSqBZPW4SF0kZEb5nM0gpTpnVNsdeB33TTX1DXh/b4u39frnfFbM2ezYRsewHeYOCGbuD6k/rBxQ2vft+x48eUApho/8IBHkPucSqZ2PNZH2t+2+kINZRblLSSjAMmlKD4UKXjbKDQUR4LOLuBVSORnId0VMYsKfLlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EgEFbbhTpvoNyv0r0F7Wo8PIH7mUE72L7yyRXHk4WU=;
 b=nUQ2WqlZLc/5C/Hz78eSFHMmtmqShdF6KCaWVbQJF65hjhyuPNgs3hEULPoC7JbCPqNscVcVNFNP1yhCQKxfRATbQ5avtgkifhiuv85bZ+UDQ9W4mnSS5YulCbvCEjhOd0VlLZyBsw0IVZ6A/XAvu+Cjrat5dv2BdLMmOehR4F7U18chNBrumObp3fG99xFNW3se+AbcFJ0F0mQ3pw/V52220GyYuD3HaN3VRfs1uUBTKxhDIFOq+9rrr2vXh+WC1HHiXzS277JmjUkT2gE8laGg0KjOOEyhNaL8bUGCEDV+ZG78B0xcjxLH1eMhPgv7dhUf9JjvvcjSThSXRdxlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EgEFbbhTpvoNyv0r0F7Wo8PIH7mUE72L7yyRXHk4WU=;
 b=TI7FkpWlQMMNiHufwIF6HCSwLrBz+iuH8yvTIyXXIpImeDYmY0XQqT7ok5KVkayFKS90N6E3Ix7nNM82LeOSkpg5V1oXVstw7u4JVLRBL6vApDnbnunLTyH6dDQ6SgCi6u16dIHFHxzyl7Qf/s0a0n2CMveGSyAeV3KsYi+wifQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7476.apcprd03.prod.outlook.com (2603:1096:400:432::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 03:55:32 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 03:55:32 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLDVjsEA
Date: Fri, 12 Jan 2024 03:55:32 +0000
Message-ID: <eeb06fdc3539eaa52aedf110c70b4da686d45de7.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7476:EE_
x-ms-office365-filtering-correlation-id: 20612dc3-aac7-497d-5b38-08dc13225358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSyP7wCJDBZSeAM3lpKK50yA5oct11TfasgGmSYg42miNb3LPVbI7N2WDh4wcu2n/DEnApWpS0qdJFyC2wUwHhCUcvmVlcwY6VpGWi2ogoPoLiFtZMIxbBHakz/dmJMBWTYNOmhIaPIRt65babDO0nd1IobK7DVffgIE1RRdtTy7MGuNUKnRbNp5i+TpSr/D1aXpQ+P82Z0+I7Z7cNbyU3ftoH0QuHUiqzgvZQgI0/wa2HMKjwRA0pmwE/vd17NaXoIBhMk/68VL54UPCSvDVp7XJOydmz5fltyIDXxPcb62kWmeQiRA6C33wiZ/vRQ5rsxMaRkeTXmvavwSTNWjK97o93t8pMfTrbXWUw741Xh9brZzWs5JGR382APJyrFtNUev7KrUWiiU7Ctetn5asLS+sqP+/iSwN3L9741BiIH2Jh6/txHsp/mMgu84/kYJdps57I2sXALlwnuRwE7893wSqxifB664UK7cUJ4QASPdlzEKdWA6UhNa9+QInm0P0gGnKuyE2hHm0i8BOfjayRq+ddNpjh1RxtzciPFzAQmBuzW9iY8R62VZ1OV9S+N3Ljz7KxYQfLPwwWTwUYUpBh3Zyhz106bU77Lqra0xabKfW4g2AEi8DJjyljXd+j6LlokK+LsrwtyRR++0hLAzJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(71200400001)(26005)(2616005)(83380400001)(6512007)(6506007)(478600001)(966005)(6486002)(66476007)(8676002)(8936002)(38100700002)(4326008)(66946007)(64756008)(66446008)(85182001)(76116006)(66556008)(36756003)(54906003)(6916009)(316002)(86362001)(122000001)(5660300002)(7416002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGkyUFRXME44a1BhaTRFV0t2UmozeFQ2WlU2a0xyNUNsVXBCRDAxVjZEVGRs?=
 =?utf-8?B?QVgxVTB3VVUvc3A1V0RxdUtPQTc5R3pKeTJTUm9VV1JGN1c2a1laUXEzMUN6?=
 =?utf-8?B?UitoWnBaanA0VEF2RU5EQjdESGljT0xCUkhHc3RsaFNZVi9hM2U2UStKcDRY?=
 =?utf-8?B?S3ExdTRaaGlYUEpYckkrTUlGZUh3ckwwL2kyYkJvZzNZSWphTW5NUk1CcTBx?=
 =?utf-8?B?NkJqMmlkY2RhRjM2WjdzbldtSFBHamFuQktHZ1hRVTlFcWNJUFVwM2lUNG9V?=
 =?utf-8?B?T0RSeFdWdHlSMUxlbk44YVBORFlXZTBJS1FJZEZadUlRVld5dG5KckVMUlI0?=
 =?utf-8?B?WGEzSlhNUUVEeXpmbHVNU3Y2M0VoMS9TcmpMMzZuNW9BRnFsMkEvdkpPSVdn?=
 =?utf-8?B?Y1pJcWxnbDBZak1QTXFvbVBvbzBFZUhpRE90ZzEzdFZKaUpQRkQ2V00wK0FV?=
 =?utf-8?B?V0pLaExEVTVXbitDeFBtRUdvOVhwc3drSmQ2aTBOK25rblJDa3V4ZFh5TFdT?=
 =?utf-8?B?TndSd250aWxrWmREcitkNS80UEpCT1EzUU9xNXJxQ3NCU04xamo5WSt2dm54?=
 =?utf-8?B?UkpwT2JXWWoySjNtR3QyODl6cDVsMG5EZmZiSlBmUmJRNXJDRmZrbWpSeUF5?=
 =?utf-8?B?UGhPRUo5eC8vYm9DWXNRR1ZxVkZKK1Y5TWlLN3ZYL3pSUUdGRG81M2RvTGpr?=
 =?utf-8?B?WlBVUVdEZUUrRklQbWgxWlNvdGtzLzE3RlBoR1ZzNkNlTDROVlo4S3d1Mjc4?=
 =?utf-8?B?Vkswc0E5R1pBS1dIV2pQOHRCa3JoRmpZbm5TZ2hkYW5QU2pWWGdNNTZpbGtr?=
 =?utf-8?B?UG5lWEJFUHFkMmFhUStQdHdnOHcvRDFIUkUwc1dVRlJVMTZOOEMvWmJQSkRB?=
 =?utf-8?B?V01LRk9MRFRXM1NoWWl2SDl3RzZIY28vWFJwL2lCNHFhd28yTlVtNFFsMXlC?=
 =?utf-8?B?Zkx4dHBBdmxwVmRuZUcvbHV0TlJVd2FXRUs0akFsUStqN2dCQ0FFbGF6aVEz?=
 =?utf-8?B?VnByR01uY3FrdWFkMUNRREJUUXdkQjFqdFNpWmcvM0YvemJWd1JnUUJ5T1Z5?=
 =?utf-8?B?bmJaK1hsSG43VHJhME50ZXdtall6K1kzZnFrV25WNVp0S3ZKbk5iMHhtZWFC?=
 =?utf-8?B?aXlqNStLdjl2b3Z1MHFrczY0NWhTdStvNUJ3eUdPcGtRSUxNTlVCOVkzTjBy?=
 =?utf-8?B?RXJSOXdMaEZyOWVuMlUzWmd2c1hxbnJSWGJMRUlMcmlYSXFPV1J0Q1IvY0F2?=
 =?utf-8?B?SEkreExwcTl3amR3OVQ4RDAxcWc3cUZIakRLZUtHbXZzYmxQTVpwN09Jb1kz?=
 =?utf-8?B?OW5WNlY1VDFuUmJEY05VR0dybTExUzZvWFNZSXlMS3NFK2dDdG1NWnNVcmxZ?=
 =?utf-8?B?YXN3RDU3cFZtOUZsTU01Q001ME11S0pwUFpjdTRGTEZDY0lPbGpQdlhTdjBn?=
 =?utf-8?B?MTFkTHdodDkyQUgyajZSKzBsZmVuSkVyYmZ1QVFPU2tLbmRqYWpiUTUwT1JZ?=
 =?utf-8?B?VU91dDkvUVhHMytBc2czUTlDZmFPdTBGdU91OEtpZGI5SklJV01rWFF3OTVv?=
 =?utf-8?B?RUoyVFZzOUhMYXZYUy9OQ25QUHZNeTFOU3hYWGx1THNPNmdrRHBRR0FlbzJG?=
 =?utf-8?B?OVowSHNrTkMrMnZJN3NQWE1YL29aYzh1OTlGT0pDZ05CUmdHZDE1YjlKdWk5?=
 =?utf-8?B?REhiWUFIWlZkY1piemhzdjh4NkNLTEZReU53VHhDbnNQTWxwNWV4SzVubENP?=
 =?utf-8?B?TkJMeEFpN012a0t4MzBWa2NiUjFCeE9NbTZLdmVFeTJjYjRYcWU0bUxobnZ2?=
 =?utf-8?B?K015T3RKbFhoTEl6UzQ5Y0xXZVBHUE44R3lyd3pmQ2x1VGhZWWgxekM3UGY4?=
 =?utf-8?B?WVYzMURSWStsWm1HR1MxSHUrNVhMaXpqd0dRQW44ZVVBOTFyZjE2aS9oZFpD?=
 =?utf-8?B?M3JZc3NWajYvQnJHV2xCVS9vS1N1S25ob1NFTW96QURDVkhhWm9IaUN5ZGJM?=
 =?utf-8?B?Q1QvZ3FrMmY1Y0R2ZUZSTUl6OUcrMC9MNkowRHJ2eHBTdlhNdzFTMmVzMHU2?=
 =?utf-8?B?ZzU5Qmk5dzhEb0dlZUdqRUMrS3BVU0VUT1NMbU9TdUVPYk5kZFQ1czE4OEhL?=
 =?utf-8?Q?UbK0xOm2Eyk3m1ziOMaevY5sn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6FB9EF54F83AD4DA5692F3024286488@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20612dc3-aac7-497d-5b38-08dc13225358
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 03:55:32.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIAD/PZq2/julCrU/XDIj/FBe4pRvY7uVyzL8cpIM1AJk1kRMlpQIGjSzk5MC/rupkJgdQC5QjwzTF8iugOgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7476
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.435600-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/XD0CNJ3fxO4dcT3ZaTocyYHhs0mgDoxyETzgIO4sasaQTVtPXXNM8ha
	W4U9IrFrA4Ssa7YWxCkW94ofbFHq39ZRkVakSSW0ZXJLztZviXEwr+fGcfUiamyiLZetSf8n5kv
	mj69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7FB7I3vXSmhjiwcVtKUGRALpHSsnkcVPZhOTn
	fZ5fsVXriaHN8zjL28=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.435600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3D99337B31900C4CCA6EB8CC81067957F0BC19F1433D989D62DD29F76C34298A2000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgaW50IG10a19j
YW1fdmIyX2J1Zl9pbml0KHN0cnVjdCB2YjJfYnVmZmVyICp2YikNCj4gK3sNCj4gKwlzdHJ1Y3Qg
bXRrX2NhbV9kZXZfYnVmZmVyICpidWYgPSB0b19tdGtfY2FtX2Rldl9idWZmZXIodmIpOw0KPiAr
DQo+ICsJYnVmLT5kYWRkciA9IDBVTEw7DQoNCkZyb20gWzFdLCB2YiBpcyBhbGxvY2F0ZWQgYnkg
a3phbGxvYygpLCBidWYgaXMgemVybyBpbml0aWFsaXplZCwgc28NCnRoaXMgaXMgcmVkdW5kYW50
Lg0KDQpbMV0gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYy
L3ZpZGVvYnVmMi1jb3JlLmM/aD1uZXh0LTIwMjQwMTExI240NjYNCg0KUmVnYXJkcywNCkNLDQoN
Cj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo=

