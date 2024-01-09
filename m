Return-Path: <linux-kernel+bounces-20634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2BE8282C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487D5B23AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2672E634;
	Tue,  9 Jan 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PbYohNcK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="n8eVc2sT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46A29410;
	Tue,  9 Jan 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 16e87c70aecf11ee9e680517dc993faa-20240109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eHiHol4vcMX7tjzugm0HODe2g6cBMq5vYvupI/Matfk=;
	b=PbYohNcKOUOu3FaMNeETJhFpJ+k5SQO6ZCKfX13pBdVRtYRl7OCkMtpG8WTFev38SB9Dcd+ewW+yo2CVCg7VjYDqerCBU5Z4h+OxlV2zrrGqJEE7lrA/ewkUZ3r0zgcZ/qpjHAU3MC5mu0aLSFc++Absu1Zf0L6bHPKXh3Pvazk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9c75d290-101a-4612-a7ab-29bf39acc5d6,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:f8fff72e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 16e87c70aecf11ee9e680517dc993faa-20240109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 372820172; Tue, 09 Jan 2024 17:11:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Jan 2024 17:11:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Jan 2024 17:11:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPzCc50laVbv8YoDCL4pkfeUgftAL/pvh15wSEhRfgPcddszVysdTgEGqIGp/QbKTdL/XP5vFCb706DnnW/sQREIxMgGEPOtiyfXsXdyg58FQL/6+xFI4/g7mznaYrelDDxJ/VfOTB2VH7oYutMVQg5zb5uM/9YtEEReo4RwiUgc72ekeF0Gd8U6opQAoa7LIHl/hUBkmEdnlU0zZsS4wf+psgsedAOZ/t0Bji97CstJtue4hGOdUbQYSxkNRU2z9PB32Snf31tawwi+3EA7eqrq95umA0u9vL9EESyXFyJV/iwtZ/kh6gGcePSWomGZYHkJXbMoLl3kq8+np8DS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHiHol4vcMX7tjzugm0HODe2g6cBMq5vYvupI/Matfk=;
 b=Cbz8czLjJrIQI2nu9SD791MCrtJ2yV8OpwR3VcidkZn8vEKfuwEm0I348LntlAVNPlkk4fl+HzKGYBSWGAOXFszGHRkOhQjbsdZ3HahBZTtuO0PimRfz7oVboL47FPSQqWHEJzjrnWJR7umahS4DjguB6xFUaKMOhPLkY9Br29sPYGJ9dJWmRY6F3zgSRfon722+fX8Ji8Hi2MAM39CiVno2VBitNnDokbh8bTmrchYC38YRmhRUE4w3JqKwng5pDOJcMUIWxwOfcZwszzMLQ/g14D1e4bFTF/NqaxFV99v0zJYa7eimeBcT/h25pmrd+EBbNMANR3rMj6pP3gHIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHiHol4vcMX7tjzugm0HODe2g6cBMq5vYvupI/Matfk=;
 b=n8eVc2sT7se4Oonv2+JI4EdoxSw4L7AoN5pMVpIQWpp/5IVOOOkBDyEIgdRQuzRUu9HSY+nL2gfD3GhnVahr9jXLN0/Ags59KC9F49poFc/rOmLiouShTtTFTqqL1BzUTt2o3XCDU9eXNNE8HQjiwXeezlHhyOPVq21mlC5M+f8=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYZPR03MB8660.apcprd03.prod.outlook.com (2603:1096:405:b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:11:32 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:11:32 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
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
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Thread-Topic: [PATCH 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Thread-Index: AQHaHgO3BcY8s9aP1kisCFHZahMe8LCIKciAgBWJeoCAM8hgAA==
Date: Tue, 9 Jan 2024 09:11:32 +0000
Message-ID: <96fee4c737300e6b834ae0761c161edb6bf48aec.camel@mediatek.com>
References: <20231123115104.32094-1-zhi.mao@mediatek.com>
	 <20231123115104.32094-2-zhi.mao@mediatek.com>
	 <20231123-magical-rupture-83251807e995@spud>
	 <20231207102505.GI29417@pendragon.ideasonboard.com>
In-Reply-To: <20231207102505.GI29417@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYZPR03MB8660:EE_
x-ms-office365-filtering-correlation-id: 5d8e3cca-8418-4149-4795-08dc10f2f91a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f14+hYRN4oZJY6Mg8XpWv2QFmvp0B3L3FhDR67U68TZeH2UBaOA0sxiHsxdHzcaCnN6KaREOQ5F4nMlHxwnRbhzVh1aQtObwkPPctgKHr0fkK1Gt46JvCe0yY42NJOwUu+nt0Yyu4YFZ6y6YAgJazMXWDLINloQKnOEmrWqDjEoeY8LfqPWF37ZUdWkvelaWwn3whdgbB0FUbYiMObgL0T3SOT/IIsTYTgelm4AhJSewh0JK47weYEOWhSQS6/oLXYuhF3ttEkw+PhuIpjAwBMsLyDnlXwN9J7qwxmGis+suB/bX5Ct5Mhqluzk0YB+t5b1PqbB3dOLP4jN+mrKdQc9MVTGFGZ8trmPMq0iloSGd1pFiuezKr6ComwQQny7qHbdb6L+n29G9NTzcxRlv5+eQhake/fRYhCspd2rGg9jMcP/DqY2eNMYM8DxBbK5K+RE7ujSDwinKdeAeoJkQ7AjgTuVuvHsx/t2B+KEJI2qRA9Ek3qCvPOfiWEWWos+udA1MbT1kbWPSg/ULYXMn2G1DgzzjSM12GxI/ho3HY1QZV5Wi/FIoc+gHR4JwuESQZdd5Us/mULEM7+nbYMcYERciPXnlqoT/+Ci0/NdugIrCYySiRzHCi+Rhpz1Fgh//Uh8Dq8VGieMgQrGvZ0ZrzMsTjBJUVMby1l4ruGwYIr4dZFtrN+Jdz5f+l0PQ+QTn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(2906002)(7416002)(966005)(36756003)(86362001)(38100700002)(478600001)(38070700009)(6486002)(85182001)(83380400001)(2616005)(6512007)(6506007)(26005)(71200400001)(122000001)(316002)(8936002)(8676002)(54906003)(41300700001)(91956017)(4326008)(110136005)(76116006)(66446008)(64756008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFNZm16TjNVdWFxOUNvMWExK3V4YUVGakk1T3BabzdOdTlhOEU3RHFVVHVE?=
 =?utf-8?B?U1FRWk5QSTB3WkJUc2pzOC9rQXZkYkFWdG1Pa0M2dnBlYzdySGxTV0EyMWZZ?=
 =?utf-8?B?TE8zTGF4a2pETERCcFhkaHd5aTJzdlpjcG53ZE4vbmxBTXlzRFN1a2hhc1FS?=
 =?utf-8?B?U0FOZExobzVyQ2FGR1NJRFJzZG12RGVlUVVhZzkwZlhnZHlzYWNuT2dzOFdT?=
 =?utf-8?B?TzZwZWpndnpiK3d0dnJlVGJHRUxlenpTdDlPUjBuL1l3c1pDT2RCWmdhZWxw?=
 =?utf-8?B?cTRVVTA0RjNiT3F4Y1NrR2NpQnBrdndMaFZMRXBzeVA2RFBtS1J2Q3hBQi9J?=
 =?utf-8?B?MDJLTkFQdWtrUURXN0RjTGlnZUg0ellHV1h2eUE2SnNxY1pCdStLeHROUjRD?=
 =?utf-8?B?VlE5NzF3ZXZ5ejFLWTJIRWNabUgyQitBeWphTmRBTTdRK1UwQTdKYitnZFBJ?=
 =?utf-8?B?QlN3RFNiN3ZhMFlaQjJuQTF5a1NtU0xkdUF2Uk05SlN2V0JQcGE5ZFJCV3Uz?=
 =?utf-8?B?SkRlNlRZRmlFRTcvU0V1Qjl1Q1hLRldBaWYwSGZ1TksweVdoMFZJTmZYOXhY?=
 =?utf-8?B?QlRlbTlwYTQ4UGs3VjIwMUxMOHZXODNUamFKWnJHREdFN0J2Q2g4alQwVCtT?=
 =?utf-8?B?Z0ROUklucUVKdG5RQUNvcUYrTDZZQlpNMXhERVpDSWZ2eUV3eTU1Y01abTNi?=
 =?utf-8?B?eGhlTkh4K0V1YmNiT25Nbm1pUENxN2pKVVRRSnViVEorVHNSK1BwS2lXeUVu?=
 =?utf-8?B?cWVUejRCZVpOVWVjeGN4b3AxQ0xLL2NsMThOTHlCS0xFN045cTBITEpoeGtJ?=
 =?utf-8?B?UVFIVGtnUTE3UjNYRjI0S2xQSHVDdWdXZmN1eFRmQ1NjUk1vWmVRQnhBa1Mz?=
 =?utf-8?B?U0EwZTRzU1hZRGVvbWszVDJ5OVZJSnhDbVA3SHdwdWs3Q25sVE9DaFl4STFx?=
 =?utf-8?B?RkZ3NndMWGx2RnpMbGY2ME5xZXc5bGNpNHg4N2ZGcUpEeWlTRldDU3Fja0gz?=
 =?utf-8?B?emRrNVF2R0NtRUJNZzhQR1BnSVNVdjg0RS9nbE9sUmZBQWtlSzdOcjEyODhW?=
 =?utf-8?B?YUloYTJEcm12SHNUdDkvL0RGRE5EemFNVS8wVVRqQ1ZDeUFpWDA3VVZzSzRK?=
 =?utf-8?B?YzlKaUpucFRmWTRXM3hLT3RmdDljSG9JN0I5UjhHN2YyTk4veUlkTUgzZnFx?=
 =?utf-8?B?MUdiMWlqazE0OHNKdWNiRHBRNEl3Kys2SC9QaFo3VjhNSFo2TW5vYVdQMjVN?=
 =?utf-8?B?bjVxRE1RZW5peHlEVWtJb0FPbzQxLzc0ZXo5bDNKMjk1dUhmeDByWENoNHhG?=
 =?utf-8?B?RkoyK1VyU1NPdFlYVVFkTkNnTTZIeTNSWDBQSytMeno2R3MyUzNXL1NwRVRB?=
 =?utf-8?B?bThjVTVzT3lwUTFHRytpWFU2b1AxVDg0TzJuTE4rQkd5WEU2SS9KcHlrQStM?=
 =?utf-8?B?ZU45K3V1RWJpU090UHJTR1lNY0M0WVlDZE40SGdiV2NxVzMrZ0tzYS94Y1lS?=
 =?utf-8?B?ZDNUWFAwL2R3WkJjZ3JEQW43bmJqUjRPcjZwQ3c1V3JMalpMamxDMGtFbUd1?=
 =?utf-8?B?WHNuM2dlekprK2ZnZ2wwNFFiYzUzMWFwMy80LzVOVDFvU0ZmbFNEWFhTZkRy?=
 =?utf-8?B?L1NzZUNkQm1xYUp1Sk1oNWJCQWZaeFdTM1dpdjhveXVNV2huOGlVRmR3SklB?=
 =?utf-8?B?VFg2QUk1NEQ3aU0yaDNnL2hDbXJXclBNNU5keW8wMWJjYlowM1BXTFN6WDh3?=
 =?utf-8?B?bXRaajZSeW9jdzVkb2tvcXRnZllIemRMVWhISjVsWDFzeXcyRTFHWWdSSUIy?=
 =?utf-8?B?bUFkeUxnMDZTYkZvUkFnemsvL08wRGFPSjJxQ29zcjBtS1loSmFybmtqSlN4?=
 =?utf-8?B?QkJIbDI5dEdVL0llaUdkaU1ubDgrTk1yZXhudDBHVUlvSWFTOHNGcWJyUW9V?=
 =?utf-8?B?ZEJ2WkFkb2U3OGlrYXFKWmJvZzNmWmlaaGN5RUhwZkpsMzVMU3BYeXo4VGFx?=
 =?utf-8?B?WmtIa3I1ZXRaNlZXdVNURUVaa1lsUFRqVU1vY2NOc1lKbC8vUW5nMjBFdXBI?=
 =?utf-8?B?ZHZzZWZTeE5yTDBROWlWSFI3Rzc1WHMvekcra2RmVHRabU43Tlp2M3RnUjBP?=
 =?utf-8?B?Tit6SHkwQ3Z2WUt0NDlWYndwRHcwV2pSWmJWYkpCWEppdXhQMkdJNlY0UGNl?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0939665A803FBE41A3589C779EA032E1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8e3cca-8418-4149-4795-08dc10f2f91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 09:11:32.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWHW+V52LXkdyskItHO6DageUiUm1lpjXHL8qZDh0R1pV9bdEXRXWbJuvFuo8xZ1fNuKd8OkuiMS+ILU7ez+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8660

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDEyOjI1ICswMjAwLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIE9uIFRodSwgTm92IDIzLCAyMDIzIGF0IDA1OjMxOjM1UE0gKzAw
MDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiBPbiBUaHUsIE5vdiAyMywgMjAyMyBhdCAwNzo1
MTowM1BNICswODAwLCBaaGkgTWFvIHdyb3RlOg0KPiA+ID4gQWRkIFlBTUwgZGV2aWNlIHRyZWUg
YmluZGluZyBmb3IgR0MwOEEzIENNT1MgaW1hZ2Ugc2Vuc29yLCANCj4gPiA+IGFuZCB0aGUgcmVs
ZXZhbnQgTUFJTlRBSU5FUlMgZW50cmllcy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
WmhpIE1hbyA8emhpLm1hb0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gUGxlYXNlIHRlc3QgeW91
ciBiaW5kaW5ncy4NCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9tZWRpYS9p
MmMvZ2FsYXh5Y29yZSxnYzA4YTMueWFtbCB8IDEyOA0KPiArKysrKysrKysrKysrKysrKysNCj4g
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCAgfCAgIDIg
Kw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKykNCj4gPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L2kyYy9nYWxheHljb3JlLGdjMDhhMy55YW1sDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvaTJjL2dhbGF4eWNvcmUs
Z2MwOGEzLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEv
aTJjL2dhbGF4eWNvcmUsZ2MwOGEzLnlhbWwNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjA4OWVhMzIxZGE5MQ0KPiA+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ID4gKysrDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L2kyYy9nYWxheHljb3JlLGdjMDhhMy55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDEyOCBAQA0KPiA+
ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xh
dXNlKQ0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDogDQo+IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lZGlhL2kyYy9nYWxheHljb3JlLGdjMDhhMy55YW1s
Iw0KPiA+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBHYWxheHlDb3JlIGdjMDhhMyAxLzQiIDhN
IFBpeGVsIE1JUEkgQ1NJLTIgc2Vuc29yDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+
ID4gPiArICAtIFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0ZWsuY29tPg0KPiA+ID4gKw0KPiA+ID4g
K2Rlc2NyaXB0aW9uOiB8LQ0KPiA+IA0KPiA+IFRoZSB8LSBpcyBub3QgbmVlZGVkLCB5b3UgaGF2
ZSBubyBmb3JtYXR0aW5nIHRvIHByZXNlcnZlLg0KPiA+IA0KPiA+ID4gKyAgVGhlIGdjMDhhMyBp
cyBhIHJhdyBpbWFnZSBzZW5zb3Igd2l0aCBhbiBNSVBJIENTSS0yIGltYWdlIGRhdGENCj4gPiA+
ICsgIGludGVyZmFjZSBhbmQgQ0NJIChJMkMgY29tcGF0aWJsZSkgY29udHJvbCBidXMuIFRoZSBv
dXRwdXQNCj4gZm9ybWF0DQo+ID4gPiArICBpcyByYXcgQmF5ZXIuDQo+ID4gPiArDQo+ID4gPiAr
cHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgIGNvbnN0OiBHYWxh
eHlDb3JlLGdjMDhhMw0KPiA+IA0KPiA+IFBsZWFzZSByZW1vdmUgdGhlIGNhcGl0YWxzLg0KPiA+
IA0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4g
Kw0KPiA+ID4gKyAgY2xvY2tzOg0KPiA+ID4gKyAgICBpdGVtczoNCj4gPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBSZWZlcmVuY2UgdG8gdGhlIG1jbGsgY2xvY2suDQo+ID4gDQo+ID4gUG9pbnRs
ZXNzLCBqdXN0IHVzZSBtYXhJdGVtczogMS4NCj4gPiANCj4gPiA+ICsNCj4gPiA+ICsgIGFzc2ln
bmVkLWNsb2NrczoNCj4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ICsNCj4gPiA+ICsgIGFz
c2lnbmVkLWNsb2NrLXJhdGVzOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+
ID4gKyAgZW5hYmxlLWdwaW9zOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogUmVmZXJlbmNlIHRv
IHRoZSBHUElPIGNvbm5lY3RlZCB0byB0aGUgUkVTRVRCDQo+IHBpbi4gQWN0aXZlIGxvdy4NCj4g
PiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ICsNCj4gDQo+IElmIHRoYXQncyB0aGUgUkVTRVRC
IHBpbiwgaXQgc2hvdWxkIGJlIHJlc2V0LWdwaW9zLg0KW210a106IHllcywgaXQncyByZXNldC1w
aW4sIGZpeGVkIGluIHBhdGNoOnYzLg0KYW5kIHNvbWUgb3RoZXIgY29tbWVudHMgYWxzbyBmaXhl
ZCwgcGxlYXNlIHJldmlldyBwYXRjaDp2My4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbWVkaWEvMjAyNDAxMDkwMjI3MTUuMzAyNzgtMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCj4g
DQo+ID4gPiArICB2ZGRpby1zdXBwbHk6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBEZWZpbml0
aW9uIG9mIHRoZSByZWd1bGF0b3IgdXNlZCBmb3IgdGhlIFZERElPDQo+IHBvd2VyIHN1cHBseS4N
Cj4gPiA+ICsNCj4gPiA+ICsgIHZkZGEtc3VwcGx5Og0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjog
RGVmaW5pdGlvbiBvZiB0aGUgcmVndWxhdG9yIHVzZWQgZm9yIHRoZSBWRERBDQo+IHBvd2VyIHN1
cHBseS4NCj4gPiA+ICsNCj4gPiA+ICsgIHZkZGQtc3VwcGx5Og0KPiA+ID4gKyAgICBkZXNjcmlw
dGlvbjogRGVmaW5pdGlvbiBvZiB0aGUgcmVndWxhdG9yIHVzZWQgZm9yIHRoZSBWREREDQo+IHBv
d2VyIHN1cHBseS4NCj4gPiANCj4gPiBUaGVzZSBkZXNjcmlwdGlvbnMgY2FuIGFsbCBiZSByZXBs
YWNlZCB3aXRoICJmb28tc3VwcGx5OiB0cnVlIiBJTU8uDQo+ID4gDQo+ID4gPiArICBwb3J0Og0K
PiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy8kZGVmcy9wb3J0LWJhc2UNCj4g
PiA+ICsgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gKw0KPiA+ID4gKyAg
ICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgIGVuZHBvaW50Og0KPiA+ID4gKyAgICAgICAgJHJl
ZjogL3NjaGVtYXMvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy55YW1sIw0KPiA+ID4gKyAgICAgICAg
dW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgcHJv
cGVydGllczoNCj4gPiA+ICsgICAgICAgICAgZGF0YS1sYW5lczoNCj4gPiA+ICsgICAgICAgICAg
ICBvbmVPZjoNCj4gPiA+ICsgICAgICAgICAgICAgIC0gaXRlbXM6DQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgLSBjb25zdDogMQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgIC0gY29uc3Q6IDIN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAtIGNvbnN0OiAzDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgLSBjb25zdDogNA0KPiA+ID4gKyAgICAgICAgICAgICAgLSBpdGVtczoNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAtIGNvbnN0OiAxDQo+ID4gPiArICAgICAgICAgICAgICAgICAgLSBj
b25zdDogMg0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICBsaW5rLWZyZXF1ZW5jaWVzOiB0cnVl
DQo+ID4gPiArDQo+ID4gPiArICAgICAgICByZXF1aXJlZDoNCj4gPiA+ICsgICAgICAgICAgLSBk
YXRhLWxhbmVzDQo+ID4gPiArICAgICAgICAgIC0gbGluay1mcmVxdWVuY2llcw0KPiA+ID4gKw0K
PiA+ID4gK3JlcXVpcmVkOg0KPiA+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gPiArICAtIHJlZw0K
PiA+ID4gKyAgLSBjbG9ja3MNCj4gPiANCj4gPiA+ICsgIC0gYXNzaWduZWQtY2xvY2tzDQo+ID4g
PiArICAtIGFzc2lnbmVkLWNsb2NrLXJhdGVzDQo+ID4gDQo+ID4gV2h5IGFyZSB0aGVzZSByZXF1
aXJlZD8NCj4gPiANCj4gPiA+ICsgIC0gdmRkaW8tc3VwcGx5DQo+ID4gPiArICAtIHZkZGEtc3Vw
cGx5DQo+ID4gPiArICAtIHZkZGQtc3VwcGx5DQo+ID4gPiArICAtIHBvcnQNCj4gPiA+ICsNCj4g
PiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiA+ICsNCj4gPiA+ICtleGFtcGxl
czoNCj4gPiA+ICsgIC0gfA0KPiA+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9n
cGlvLmg+DQo+ID4gPiArDQo+ID4gPiArICAgIGkyYyB7DQo+ID4gPiArICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgICAgc2Vuc29yMEAyIHsNCj4gPiA+ICsgICAgICAgICAgICBzdGF0dXMg
PSAib2theSI7DQo+ID4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJHYWxheHlDb3JlLGdj
MDhhMyI7DQo+ID4gPiArICAgICAgICAgICAgcmVnID0gPDB4MzE+Ow0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgICAgICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9DQU1URz4sDQo+ID4gPiAr
ICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9VTklWUExMXzE5Mk1fRDg+Ow0KPiA+
ID4gKyAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInh2Y2xrIiwgImZyZXFfbXV4IjsNCj4gPiA+
ICsgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MjQwMDAwMDA+Ow0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9DQU1U
Rz4sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfVU5JVlBM
TF8xOTJNX0Q4PjsNCj4gPiA+ICsgICAgICAgICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0g
PCZ0b3Bja2dlbg0KPiBDTEtfVE9QX1VOSVZQTExfMTkyTV9EOD47DQo+ID4gPiArICAgICAgICAg
ICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDwyNDAwMDAwMD47DQo+ID4gPiArDQo+ID4g
PiArICAgICAgICAgICAgZW5hYmxlLWdwaW9zID0gPCZwaW8gMTkgR1BJT19BQ1RJVkVfSElHSD47
DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4gPiA+ICsgICAgICAgICAgICBwaW5jdHJsLTAgPSA8JmNhbWVyYV9waW5zX2NhbTA+Ow0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICAgICAgIGF2ZGQtc3VwcGx5ID0gPCZtdDYzNTlfdmZlMjhfbGRv
X3JlZz47DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgcG9ydCB7DQo+ID4gPiArICAgICAg
ICAgICAgICAgIHNlbnNvcjBfb3V0XzI6IGVuZHBvaW50IHsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgIGRhdGEtbGFuZXMgPSA8MSAyIDMgND47DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICBsaW5rLWZyZXF1ZW5jaWVzID0gL2JpdHMvIDY0IDwzMzYwMDAwMDANCj4gMjA3MDAwMDAwPjsN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmc2VuaW5mX2Nz
aV9wb3J0XzBfaW5fMj47DQo+ID4gPiArICAgICAgICAgICAgICAgIH07DQo+ID4gPiArICAgICAg
ICAgICAgfTsNCj4gPiA+ICsgICAgICAgIH07DQo+ID4gPiArDQo+ID4gPiArICAgIH07DQo+ID4g
PiArDQo+ID4gPiArLi4uDQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3ZlbmRvci0NCj4gcHJlZml4ZXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItDQo+IHByZWZpeGVzLnlhbWwNCj4gPiA+IGluZGV4IDMw
OWI5NGMzMjhjOC4uYTBiYmVjMGJmZWUyIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sDQo+ID4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwNCj4g
PiA+IEBAIC01MDIsNiArNTAyLDggQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiAgICAgIGRl
c2NyaXB0aW9uOiBGdWppdHN1IEx0ZC4NCj4gPiA+ICAgICJeZnh0ZWMsLioiOg0KPiA+ID4gICAg
ICBkZXNjcmlwdGlvbjogRlggVGVjaG5vbG9neSBMdGQuDQo+ID4gPiArICAiXkdhbGF4eUNvcmUs
LioiOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogR2FsYXh5Q29yZSBJbmMuDQo+ID4gPiAgICAi
XmdhcmRlbmEsLioiOg0KPiA+ID4gICAgICBkZXNjcmlwdGlvbjogR0FSREVOQSBHbWJIDQo+ID4g
PiAgICAiXmdhdGV3YXksLioiOg0KPiANCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50
IFBpbmNoYXJ0DQo=

