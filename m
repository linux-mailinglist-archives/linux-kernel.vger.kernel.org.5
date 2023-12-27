Return-Path: <linux-kernel+bounces-11768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE181EB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA31281314
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A3210F;
	Wed, 27 Dec 2023 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sc4Vf/mL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NGEROL0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56B1FBF;
	Wed, 27 Dec 2023 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: be4ff854a45b11ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xtwura4gAER/cOp0Frj5U5u8WyOnHh0lKE5lm/rxj1o=;
	b=sc4Vf/mLqhZ0/utnDd6PC3FTAHkX5x9jVtrBz4f01E6ZU88gmz/7ZfEzjIbD20x5vH4lQSIxF+ckbuTPhIqipa+tSJQJuat0YOYNU/rSR5cocnr0euqGLDfcHOAmD+FtxX73gDvdgD/CmAJPZhc45X8n1bQt6pft90zOjAL6zTQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:354fe517-4938-48da-87d6-d164b58e785f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:0f34852e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: be4ff854a45b11ee9e680517dc993faa-20231227
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 968484133; Wed, 27 Dec 2023 10:00:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 10:00:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 10:00:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7zmDTS3LPJUYInxU/RWkgXOOX8XFM6Vc5MF9k3V1bp72DwDlU6rSWmSV7vkOUOfXwLOogkybOwwggbj7iZBnZ+7eL1IsmsV/P1Cib2ZqZuJF2JpA27L53T0v6alJ6iRibhhsCDiUoFJbzgvG1EEi0q7do4e/SArcQMI43VnUEh+i/95M/OMIEzKdN1geSFJP0cNEmd9YpH2dEaoPYfnJqF9w4sx/SDMP6paewFjEH0gEhAZXMGOzAoKkIgTu4HSz8xu9oG0F93wcK+FU/5OlxjNUwOywuG5QQZJyaZwgMKzbF1qjeWlEGChgj7V31QxCVVqUK5yU5EFzdGE0dy+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtwura4gAER/cOp0Frj5U5u8WyOnHh0lKE5lm/rxj1o=;
 b=D16/p30+gl26lz2HabZ7doNiZ6Uws6IcO1KJGuPTJTQfeB86hiDEn+YDhEYsO3taeWBAePxAWRzw94GtmbzLtBxRC3jcoh7bdaz5xYP7OcPxQiKQjBCWDch62bnlZgnzvUXQUhxkulJ19xpyUOPkiPNvPINybwqqeyWpyuV9v33fhk22joa+b25AwyaHf0ByukHLZcO36Tfj3jXEia1S0GBM3nc7Btstae6XmejDAEH94d+/LCxsuTECBvSHvUZB5My7UmINPgWv/KCN9hyArpvFlzjER7VGLnb4RgILwn9zOOl2VoSqRUbh+VlW4OeXK4G7AIFAE9pS0e8Do+77AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtwura4gAER/cOp0Frj5U5u8WyOnHh0lKE5lm/rxj1o=;
 b=NGEROL0kpSv/ScXpRcrTgoZVqnsnAqYGB54nyRk17Hzf0kB06PQ2Vh3MekLUJZ+Kyuhp06t0omsKQYBKp5rjxV7cRemq3VuBANNr0d6eY0eDRGoFuknVoCy5/OIHbylFqMWPh3V/r0PhIoV4ovuY3KwpZ4lIyjrNsBKQVESQMA0=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB7981.apcprd03.prod.outlook.com (2603:1096:990:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 02:00:40 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 02:00:39 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaLykpK4Euf9aonkW1wfynk3w/xbCp9JaAgAd/FACAAFleAIAKpaCA
Date: Wed, 27 Dec 2023 02:00:39 +0000
Message-ID: <d463f6b87ec36087c062530a929031bcbc3f8924.camel@mediatek.com>
References: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
	 <d50abf1a-1ee7-4f84-9f53-69dfe9aad103@linaro.org>
	 <2f38caeb95fe9b2d01f158fd91ed0cedafa5d2fa.camel@mediatek.com>
	 <1050b195-9ac2-4c63-88b0-d8ba3299d334@linaro.org>
In-Reply-To: <1050b195-9ac2-4c63-88b0-d8ba3299d334@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB7981:EE_
x-ms-office365-filtering-correlation-id: fc890912-615b-4efd-ef75-08dc067fa046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmzWj+VfC4+MHSLH5AOsdX0IMah2ttFMlCZZfCmskjwCKheSmjb74qmEIKnLCjBUOl/V9FtT9UpRzwOV5MauTeo+WRn/sliFKRAyVeRr6p4MvB65Arg8EFeQldMZyfUvMBX3uhqj6UtrnP3nRwy2OD9W+jOlUXSBKP1piT3sVtn4gnjmOeCNaLwgGENSrxm0JAoRdBdAMqkb3LiJdVXG/PDKpWMrMpfp9jq7jAc4dYwOZLfa578wLjzZ6TicUOob8RyrVVFBwxI/Z0+dsGRNE5VhlH1N4WrtcKwi3BQt7FvqBgkfA6jtyAPK2g0eXrQ5b0C3iW12uMZ5wjMYyveP6o8o46Ssz/1a+vfQMTUERdeuMd6hby97XUrZYfBXrKcQh4V3tnWms3ZYUrT/ujdD5QUcf4gDArk7YGXPE2kA4ftffBUmdae7enk910lZWonFtreWn0/JwdTX/VsuASQjSjMVr2Dk/iv0O1IyIV2ES+XaeIe8yQyPdRoXFwFtDS+7byoNEyRFyUg6q7ZUFdJOc4MSydkcu0xUUIrD4/TgfIj/fibrNWz8udwp1gP7JoZb4e0q5AyZ51DLh6iXMgv+7s3Uc0Jp3vFuVW6clTwljlzpl6bYW1U7LVZDYHznKoJ3Vyz21RHzHK+wWZ1Xp5/mxq5zD30gH4nqzYaX9S1clonD32EXKsdoC5zBrSVHk/4RV+cQAhCPJz4GWNHEV07l/VPCuIDcfl/8ZBdJVOmlz5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(85182001)(36756003)(91956017)(71200400001)(6512007)(6506007)(53546011)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(38070700009)(86362001)(38100700002)(316002)(26005)(122000001)(83380400001)(2616005)(41300700001)(4001150100001)(5660300002)(2906002)(7416002)(478600001)(8936002)(8676002)(54906003)(4326008)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2tjN1dGY1hrUURiaEhkQnk1ZzNaNzVZOWkzRzNSMkhmdG1ydnN6VVNRWnh4?=
 =?utf-8?B?ZzJlRWZGMzdLMjRmMVhxNW1FVG05RENSM3dwbmd0Q08xWUxuSmpGRm1HbjY1?=
 =?utf-8?B?blBOV1VOZ25lMVdLR0V2bmlYNjBsZkJySG1TRlhQV280TnQ5YjlIdkg5STIz?=
 =?utf-8?B?RHVDRVE5UEh2Uld0ZjVBNThqRVg2M0tGOWRxQnVIOTdZaW1yaVpqZlhoU2Rl?=
 =?utf-8?B?Ny90S2RJemdkaWV5WmRlKzdXcXFUdWc5L0RwRHMyc2RMVFBpRVo1Mm5TeEVD?=
 =?utf-8?B?LzduV2x1dU5YMXBWazRMcnYrM3NHTFdvT0xKTmU3WDdOUG42UDZDRTN3V1NI?=
 =?utf-8?B?QUhKUXNnTVI4SWJ0bEtjQkVhRFVrZDl5ZVA1WlFQM045NXVqbW84ZFBLdlpM?=
 =?utf-8?B?eDQ2L1BqY3hGZXV1Y2dNVHYyd2NQQ1RNSUhUcmErQktkdWJaOVRqZHBzRHh0?=
 =?utf-8?B?UmFkRm84YlExWVVsTFUzZUlwMG9UM2tIeHdrbk1MY3ZsU0Z2b20vYm94aktw?=
 =?utf-8?B?R2tsNUJWTWp0THJiSXY1cEpBSzE2NHJ3U0tMT1dNbXpQbjZTSUgvaFhyNjVX?=
 =?utf-8?B?ODQ3ekc4L2lSRkZJNnlhVGt3QlkrM0F3amJXczEvYzVyWmkvTnVSRUFZRHFQ?=
 =?utf-8?B?cWVSOTU1T3l4Wm5xWk5IQTZEdzNvQ3NtWXYzaTg1alFSUWMyQXN2QzVpdUNO?=
 =?utf-8?B?N3ZjQ2V4MmVZRFBxenluL3dKTGh0UU1QdTlxc2duSWsvQ0xZSGVkZVZqRWVX?=
 =?utf-8?B?bjBBMnkzdlVKZlpEMERJUkl6aXJ3K0hVL3NiWlVsSk1rbExORmJlYWVpK25Q?=
 =?utf-8?B?Tkpidm13eFNzRGpZTkNJbnlrL3p1SnhpOU94ZTVjTzUrcG5id0J4OGwwNHEv?=
 =?utf-8?B?L1JwcHR6Ym41dWhhdDRXK09IZDlsNlY2SGcvMHhuOThKcjJoZ0VFWmJCQWpH?=
 =?utf-8?B?SDJBUEFzVlhsL3dUbGMzT3RSdmhvdUNlSEdZeDRSRmtDbHJsUTFBNE5tMWU1?=
 =?utf-8?B?dzNjM1pOTEVjYi9KS3BwVU0yK1VZMWpLY0ZrMytQVWszREtTVTl1UDNORkJZ?=
 =?utf-8?B?eTF1NG1mOTQxK1U2cWhqcVVWQnpmdkJVQlFKQkZQM3dZVUdpdmc0SDFmUHBJ?=
 =?utf-8?B?dk90YVpSU1Y2UnJkVWVTQU80bkxYU3RRSUNSbzFJeWFqN0RlbGg0Z0JBOEsv?=
 =?utf-8?B?d0VOTWFObk1zWTJvS0QyazFYNUhYNEdLUTltR3ZHcy9iQ1YydFN6T2JVZUUy?=
 =?utf-8?B?U3J1MUNKSEFNY2pWWjBiSjM1WWkyN1hDd1BGcHFxc2ZlZERSQ2Erd1VBaG1Q?=
 =?utf-8?B?RzhjQ3FyRDBCNDVCYld3Y3lYTzlxR0QyVGFTNTd2cFpsaWQ0UStXSERkbFRI?=
 =?utf-8?B?OGFxTWFvKzN2Zm0vcFBKMTljdy9mZ0pyWUZkU0RxbkQ0TTRnS1ZvdTlhNTZa?=
 =?utf-8?B?MmwrU1REQmpvbHZFc3RnSkZHK05yUFVRd3hYTnIvMDdlSEEySTc5WXZodkRo?=
 =?utf-8?B?VjdqWWNVQlBTRm5md0RkdUdQRElUcG9ia2VNY0x6UnFJcURMSHZGRHpqUWNP?=
 =?utf-8?B?KzBYZm5DMDdUcXVUYzhWaVc5MW9TMWFqUkFnVmdmT2xBQ1I5SlZCMzJwK3RW?=
 =?utf-8?B?RHF3TzhQbHZQRFQvOGcweFFmQmR4Q3NPQXgzQzNQaHBVa0JOYW91aG91TGtI?=
 =?utf-8?B?MWJBVVhsb3dMb25VQmM1VW5WOEpiL1R4WHZDUEpvWCtLeXYvcVZKRHROMHRy?=
 =?utf-8?B?eDNsbnBMQlNrRld2aE1paE9KSDdldlpRY09SbUZFQUFZTmpkbENYVzZYQkhE?=
 =?utf-8?B?ZThyK2dZbFgwNEtrWlpZYUkycjJrR3JKSi9pQWo1MTVrb3RMQ2FPdW1NRWRO?=
 =?utf-8?B?dFF4YTFSdFFjZU56b3NZSTRUN0lPdGp4ZXJEa1dXN2oxSlFLbTFhZ3RDL20x?=
 =?utf-8?B?MnIxbGo3L01yNVdQUlBOVDJpNkFrV3JoeXF0VjZTMWZjTmlWNVNEMTB1TFND?=
 =?utf-8?B?eDJyd3lNY2VFRGIwZU5YSS9rL1FFTGtab3lWcHpTQjM1MTZ5bmJpWWhVUXZ6?=
 =?utf-8?B?QUFxS1RHTU1MT21FWFlaQzcvVEJ5YmFoMEJzZk5raWtjNXRpRnpIZmRDaXl4?=
 =?utf-8?B?ZXNNSlFEd09zaFV5RWRDRDM1REUzOWNEQXR0cWZReXBvY3ZUZmVhSkE3Zk1E?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42836FE37306044D9B488206EBEE9B19@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc890912-615b-4efd-ef75-08dc067fa046
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 02:00:39.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3aZbnQ1hORclj8LsUfZ/SxNTOIjoT7fNvn1DYoVE/ikHCvb5oIbJO/Sjp7ntsYtG2i1yo8MtHHkxuNYPTDMN9QnR4yabwWlciPMavK909Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7981
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDA4OjI1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIwLzEyLzIwMjMgMDM6MDUsIENodW5mZW5nIFl1biAo
5LqR5pil5bOwKSB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjMtMTItMTUgYXQgMDg6MzYgKzAxMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVtYWls
IDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGls
DQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4+
ICBPbiAxNS8xMi8yMDIzIDA4OjM0LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4+PiBGb3IgR2Vu
MSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3JlIGFib3V0IFNTVVNCIElQTQ0K
PiA+PiB2MS42LjAsIGl0DQo+ID4+PiBzdGlsbCBzZW5kIG91dCB1bmV4cGVjdGVkIEFDSyBhZnRl
ciByZWNlaXZpbmcgYSBzaG9ydCBwYWNrZXQgaW4NCj4gPj4gYnVyc3QNCj4gPj4+IHRyYW5zZmVy
LCB0aGlzIHdpbGwgY2F1c2UgYW4gZXhjZXB0aW9uIG9uIGNvbm5lY3RlZCBkZXZpY2UsDQo+ID4+
IHNwZWNpYWxseSBmb3INCj4gPj4+IGEgNGsgY2FtZXJhLg0KPiA+Pj4gQWRkIGEgcXVpcmsgcHJv
cGVydHkgInJ4LWZpZm8tZGVwdGgiIHRvIHdvcmsgYXJvdW5kIHRoaXMgaGFyZHdhcmUNCj4gPj4g
aXNzdWUsDQo+ID4+PiBwcmVmZXIgdG8gdXNlIDI7DQo+ID4+PiBUaGUgc2lkZS1lZmZlY3QgaXMg
dGhhdCBtYXkgY2F1c2UgcGVyZm9ybWFuY2UgZHJvcCBhYm91dCAxMCUsDQo+ID4+IGluY2x1ZGlu
Zw0KPiA+Pj4gYnVsayB0cmFuc2Zlci4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IHYy
OiBjaGFuZ2UgJ21lZGlhdGVrLHJ4Zmlmby1kZXB0aCcgdG8gJ3J4LWZpZm8tZGVwdGgnDQo+ID4+
PiAtLS0NCj4gPj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXho
Y2kueWFtbCAgIHwgMTINCj4gPj4gKysrKysrKysrKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+ID4+IHhoY2kueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+
PiB4aGNpLnlhbWwNCj4gPj4+IGluZGV4IGU5NjQ0ZTMzM2Q3OC4uZTQ0YTcxYWNiNWMwIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRp
YXRlayxtdGstDQo+IHhoY2kueWFtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+IHhoY2kueWFtbA0KPiA+Pj4gQEAgLTEy
NCw2ICsxMjQsMTggQEAgcHJvcGVydGllczoNCj4gPj4+ICAgICAgICBkZWZpbmVkIGluIHRoZSB4
SENJIHNwZWMgb24gTVRLJ3MgY29udHJvbGxlci4NCj4gPj4+ICAgICAgZGVmYXVsdDogNTAwMA0K
PiA+Pj4gIA0KPiA+Pj4gKyAgcngtZmlmby1kZXB0aDoNCj4gPj4+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+PiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+Pj4gKyAgICAgIEl0IGlzIGEgcXVpcmsgdXNlZCB0byB3b3JrIGFyb3VuZCBHZW4xIGlz
b2MtaW4gZW5kcG9pbnQNCj4gPj4gdHJhbnNmZXIgaXNzdWUNCj4gPj4+ICsgICAgICB0aGF0IHN0
aWxsIHNlbmQgb3V0IHVuZXhwZWN0ZWQgQUNLIGFmdGVyIGRldmljZSBmaW5pc2ggdGhlDQo+ID4+
IGJ1cnN0IHRyYW5zZmVyDQo+ID4+PiArICAgICAgd2l0aCBhIHNob3J0IHBhY2tldCBhbmQgY2F1
c2UgYW4gZXhjZXB0aW9uLCBzcGVjaWFsbHkgb24gYQ0KPiA+PiA0SyBjYW1lcmENCj4gPj4+ICsg
ICAgICBkZXZpY2UsIGl0IGhhcHBlbnMgb24gY29udHJvbGxlciBiZWZvcmUgYWJvdXQgSVBNIHYx
LjYuMDsNCj4gPj4gdGhlIHNpZGUtZWZmZWN0DQo+ID4+PiArICAgICAgaXMgdGhhdCBtYXkgY2F1
c2UgcGVyZm9ybWFuY2UgZHJvcCBhYm91dCAxMCUsIGluY2x1ZGUgYnVsaw0KPiA+PiB0cmFuc2Zl
ciwNCj4gPj4+ICsgICAgICBwcmVmZXIgdG8gdXNlIDIgaGVyZS4NCj4gPj4NCj4gPj4gV2hhdCBp
cyB0aGUgbWVhbmluZyBvZiAwLTM/IGJ5dGVzPyB3b3Jkcz8NCj4gPiAwIC0gMUsgYnl0ZXM7DQo+
ID4gMyAtIDRLIGJ5dGVzOw0KPiA+IEkgd2lsbCBhZGQgdGhpcyBpbiBkZXNjcmlwdGlvbg0KPiAN
Cj4gTm8sIGRvbid0IGFkZC4gSnVzdCB1c2UgY29ycmVjdCB2YWx1ZXMuIDAgbWVhbnMgMCB3b3Jk
cyBvciBieXRlcy4gTm90DQo+IDEwMDAgYnl0ZXMuDQpPaywgSSdsbCBtb2RpZnkgaXQ7DQoNClRo
YW5rcw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

