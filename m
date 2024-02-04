Return-Path: <linux-kernel+bounces-51455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB19848B77
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C11BB23EBB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7C79CC;
	Sun,  4 Feb 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pIkMSe/Q";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lTIi7wqN"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBD6FC5;
	Sun,  4 Feb 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027487; cv=fail; b=Jc1SWpGlf6bkISCc/UC27Hqi9i8y9zve+aDxdkaRN/5BayK4gEEt/Sn1TJlO5KufQghrGgJ0JRSBUU1oAJ+TEJQDJptzD9cfeKU0wpU+3rYnYdH/knVN8yw8wFgKZXDKKQeHcGe7LqWBzfyTFpTNSN1HmCwNlCIMI76sworOGIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027487; c=relaxed/simple;
	bh=biY563V5vizlAgY9+vh5xsoLqvaK1DLciQZpRl9GmA0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=of5pT3W+QlODWxbJLGNidFuKYpAScCEm7/JuetOw6x7LReHm52IaUImYxdVJWhqTG9PzI1EkHe1WRnVzMBee1U2W91Lr/SYqKK9zdKSSgcoCFsEj/3YsfPNM4Uwl9F239vdkAQiu+Cz2YLVKxbBGh7G04c70O8zRwdE7bxGgHGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pIkMSe/Q; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lTIi7wqN; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 23dd0044c32511eea2298b7352fd921d-20240204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=biY563V5vizlAgY9+vh5xsoLqvaK1DLciQZpRl9GmA0=;
	b=pIkMSe/QZ29i5b2BFHZQNI7pSm18y/1pX/sTLMDzbzT2TxkoVeQMtqGlmj98LV4A7/9Old7Y3g1QOOnFrXu2Mt4BlvCF5H8EWuGRNlvk1U3XK8pGWHIgyZJoMaryBEfVYyi4JfhNxPfi1CMLMeQjupo9Gc102/WZWcx/C6TwxMs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:33980c43-91af-4c44-b18f-91fc5a7935f8,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6e16cf4,CLOUDID:ebe81780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 23dd0044c32511eea2298b7352fd921d-20240204
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1216901359; Sun, 04 Feb 2024 14:17:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 4 Feb 2024 14:17:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 4 Feb 2024 14:17:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUP1NvdYO8kdIZTp4bM+SFoStpEVkhVaH5Fl4IucIqkVonNMsaeN2GxZihi7k17xdYJVFcZAbzVloiEHZxpQr6jCGW8IZRjZxNLb4lCUf+SzupWbNRUucgnprEljzAm1FHZ49/+o5J75Xf+nx295E4llXHUUvoNmZJep8PNOL3yyNWr7P+Z09BTNn7aTptOp8/fmugQbZ3ZgtAP/H8aiKVfwb0OWE3LWIjc8TJy581yClxSFqGZ72UMIhTZU0PQm2wPvZc4WAaX8rLzjWFqrf1QpZ1/X3pSkBpOFQr6JMVXNkOPgm/6pajCj/aIEspDZMdyCXmHiKtPCoUoDmwoj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biY563V5vizlAgY9+vh5xsoLqvaK1DLciQZpRl9GmA0=;
 b=IMAIg+hcG6LCu+/J88l2z1OCmfaExQHgQEb8a/hw7w1dqodCVEFTQIVkKRij0Y60W9JepZpVKftmtUYwlmBiAUqpJH3BrZPLGSwwcppOmBuSB+5nIy/5rYC0jkDj0TBcjjL2yGjfJNHv2Z9Xl9XTUdf8CecoLpviFPmX9xIUEzRb7JBIPAh4kBbgZkPiZv+GJ4iCDDSRvAWxWZlGnTXq+Fc/In2ticP3ylZ0/FijmoMLv7vJUMtVIIoc9tECUAMUkN0F38DEka/KGsSQXV9kXaTfwv0/wsA5lmJX0/tDT1DJX5/JyHuOd003qoROEYcm+3YE0yfzrmvbX/+IQ76WJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biY563V5vizlAgY9+vh5xsoLqvaK1DLciQZpRl9GmA0=;
 b=lTIi7wqNrE22f2p6upQ9zxsMauDxpHIEU8+juYHYDz5x8aGDf8+LOhvCUD862o2KHNbuSPTeRbRb8vRsm720k530GbF3941JhBgppQECoQu3BIFZ0CzpCVQnF6tQcjuMQQaRWn5CmRtWcvxeP/sC2SdXtasGWUSGSoThn96wLz4=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by TYZPR03MB6820.apcprd03.prod.outlook.com (2603:1096:400:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 06:17:53 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::8146:6419:98ce:83a2]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::8146:6419:98ce:83a2%6]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 06:17:53 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "john@phrozen.org"
	<john@phrozen.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	=?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xfi-tphy: add new bindings
Thread-Topic: [PATCH 1/2] dt-bindings: phy: mediatek,xfi-tphy: add new
 bindings
Thread-Index: AQHaVVlE/mVAVPojXUW5T1b2W+Q2ELD2tvwAgAMCFQA=
Date: Sun, 4 Feb 2024 06:17:53 +0000
Message-ID: <031944545677573672000aee8f97149e56c15f83.camel@mediatek.com>
References: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>
	 <adf20671-2f1d-43ea-8584-df0c0b095865@linaro.org>
In-Reply-To: <adf20671-2f1d-43ea-8584-df0c0b095865@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|TYZPR03MB6820:EE_
x-ms-office365-filtering-correlation-id: 6134b7d3-c643-4b4d-9b4b-08dc254905bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsTx1K3VOzl+FFVaV3ylzDnNHShtLEA/AJJrKYdeaQf2ptb9BJn6PSAeScYhs+fMQ7VPSySzhLZFL59XwBR55L5jA8ihlX33pErKXK4EGmILkvHUTVRNr1ZYxLz+JzjLtOgzuYerBDvCJL103T5K82DCkgxMhU4pQj4S5r42eCGCwW9sW4vtkSV1BSBdwKKNjG1qM2fnoUmu0HKIwjWNng7oLY+/vr5Oura2znYhXFh59lsoQjv+1OOn7EyVeQFwy5L35OtBZk6r2Z5tdBhSCd6laJN2eu0yFsG9ZnOSRzphJdssJ1+1siW1c58F+MVQkCyt9/H9cZEMyLL7N5qhXH5v35AZbZXcBb8mYdlZ+q8QFnW0E5jeZCXnZkGyhXx6R2bKJj6zIzECeTvWmMTwPb6TZanz/pC6GYpg59mYDvgH1kK7Cse72MQFhCpOdSNKY5rL8bOZUNLd5/Hg9ZDT/h7NCvYSA9bavlbOxZukn0IJpRiaguS4l9KEM1/2dekZZZUQ6JrAW/2anLFOP5LMyD0sbJDb+9lJvYMS0ympsTCrB9BMSB4/0dlybkf1sy2BUEm+D0mixD3iFdqmjsCeZIf8wnwaktIJ0KAE4Y9P6MlcTulznfppp2JI8OoRXSLH8MW0NauYyAD0fxGkbM4r0ffJhn1tXnnq3f7FzrvOQDpjTJcuui5bcp3XQ3oPzUtM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(2616005)(38100700002)(122000001)(8676002)(8936002)(76116006)(110136005)(316002)(66946007)(66446008)(66476007)(66556008)(64756008)(5660300002)(7416002)(2906002)(71200400001)(6506007)(53546011)(6512007)(6486002)(478600001)(966005)(38070700009)(85182001)(36756003)(86362001)(41300700001)(921011)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhpRVhVdkt6QU11T1p1YXZmMW8vZXNkek5iUkdTNVFSUVRwN3gyUk1PVzFo?=
 =?utf-8?B?SjltdnRYQTJTT3U4WkhtcmVJZmhCVUxiWlRQTENsdjF2OG9HQlA2a2dSYmcz?=
 =?utf-8?B?YkVxd2dQc3REMUFNRVdHTmI5eDkzY2JYY0d3TEVLOEladWYvenhIM0pvSDgz?=
 =?utf-8?B?akhOcFpTZjlwZlZBaThqMHB6d2w1SENLdTIwWUtmRDlRN3dwVGkwQTBYMzJh?=
 =?utf-8?B?aHlqMWRackJVRjEwN2oxc01yQ1VqQk0vZE9keDlCNFJLakZQaHk1bkpKOWVU?=
 =?utf-8?B?aTZXeDJISDVyb1lzZzlSWkFta0RyenJIN2M4dTBtQ21WUTRJd0xGZ21ibVp6?=
 =?utf-8?B?NmNtTVU5c2g5dkhQeU5Zb3c2NWJqbnBIbWY2d003WTNnckp4TWxsZFl1aS9a?=
 =?utf-8?B?QmdLcGNnM2FrallGOXgwN3g4NkVVVDl5WjNja3pGQk5FU1Nyb1FCZXVualR6?=
 =?utf-8?B?U1U3NkdySmp3dlBXNS85Z2dkRytJaHNLZS9jM2NlSXhjbW1hRGtldGJ6WUo3?=
 =?utf-8?B?c1l4MHRDUFJ0YkNQSmN0d203cUVzUjU2cXNLRlROQkt3VFZYTlM4YXZ4MGVC?=
 =?utf-8?B?blhRWi9RQ2ZYQXNsZDdOenY3M3ZZNDhFZUZXbEtVQVlSOHBBUE9JWHEwWHhx?=
 =?utf-8?B?VllqRWlzd0t3MXZZUE1WQm5aYU1uZUI5OEF3dHBpT05aVjRIOENDVEFJcVNG?=
 =?utf-8?B?TnNkcWdSUkdHRERMR1h5cFBiUFMxNjRTU3VHWXZwd2ZEMkVVUjVIdllNcUh3?=
 =?utf-8?B?aG9ja3FnNm5VRloydzV1KzdkWmxwTEFZb2xTaXF0SzNyV2Q5YXhBSERkSk5x?=
 =?utf-8?B?dzIzRkwwQlFEbkJkYkQ1VW40V2F1bXNrOVhTbkVEaVpvQnZRYmhGQmk2WnlB?=
 =?utf-8?B?eU83VlRyT2k4VGJSbFltdjFTeDNNWldmNFduT0FzWVo2NTIyMnlhWmMxZUdo?=
 =?utf-8?B?MzRTdWVCWHhsdVNzSHc2RFc4WFc2L3BlR0hJYzRqRmwzVzUzVzFyOWRmUTJt?=
 =?utf-8?B?cWJQTDdXdzBRcGlSSEdkSDQraEtvS29hbjQ2ZGV4TXBocVo3QWQwdG1yMm9Q?=
 =?utf-8?B?VC91K1k3bDZJWVorT25OUkNac0ZRU1k4OG9sUGFJVjlHY1E1WHVjWG4yM2Rv?=
 =?utf-8?B?MkM3dmNWaHdBRzBLd29SRXQ3WURjL2txWW14cTRvV01ybVVJd1JuSG8wRU9z?=
 =?utf-8?B?bFBoTjI2WXpMNkNiUEZVcXpadm9zM3RFUVBYeDRlNStDNnU3QThtZzh5eHMr?=
 =?utf-8?B?dHV2TWdsc05uV0pyQnhsSGFDd1RISlRoMXI3b3FzTG5Wb1JHeDhEOU9qTnZC?=
 =?utf-8?B?cmhLOGVudzJaS1JXZFA4eEhMUHZDZTJWN0JpR2xjbTNpaEhHTXFyR2NKTG9a?=
 =?utf-8?B?V1IzQllvN2NPM1E3WEQyKzhTZDgrSUszVzIyZmJDZC9xbXlieW9INy9VMnJi?=
 =?utf-8?B?a1VBVXV3ang1bzZCRkdpTUtIL2hmUTUwRHM3ZUtKdFF1azMvcit5ZzkyUHZs?=
 =?utf-8?B?b1d6dG1zcHhBbHVjT092SCt6SmpxM1RlZFZta2FlMzhVS0s3TTRSN0Jsclhp?=
 =?utf-8?B?YWdZdkd4amdxMk1kaEphUFo4b0hFVUpHQmVOT281cXM2VHNjWm44VWMzdWto?=
 =?utf-8?B?YVppeCttaVdkT25CVmJWa2VsTXlwR01NWE1iUFhESHhuVXpSYXNrU0R4ZlJE?=
 =?utf-8?B?VXRZVU9qNk5NMFdhdnozclAwNU8yWkh2MVQ5WFBOanFzRXp1NzdDS2xOUC9N?=
 =?utf-8?B?UlNyd0xGNUFZT2dCeC9FVjNMUkR1LzFIeDRteG14a3BjR1R3dm5IZWlKUW1C?=
 =?utf-8?B?L0FSYWNrN2R1WFVSaXRGanQwMFJvZERtTVNkQlhsd3JnVzllQ2ZTdUlFQ2Qw?=
 =?utf-8?B?WEt4TCtYdE53eTdHSWF4a2RpQXlKSjc3UXpFWTFzejdaZjFXOHpPdjZOTm5l?=
 =?utf-8?B?S1BReGs0OFNxdE16SDNWZmE5MmU4VTZOQ2NQUE12UjdDU3F5Y28vNG9MeHhk?=
 =?utf-8?B?cTRGb011UE1UdU80ek9hOFlUcFNxdkYvOUlYaWxmM3ljWkkxQk5TTm5GMUpa?=
 =?utf-8?B?bjFtT2ZzZ0NOS2tXblZZa2RpelNIQisra2VxOXFqcWtYUWVSZnY1ZmJhR1Uw?=
 =?utf-8?B?cjZGTThkOUx5aDdBalJRYWJiV3VncjZyclp4YU9VbjAxOGgvQXVyeDBtTnBJ?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F42B1597B4A304C98713741946551B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6134b7d3-c643-4b4d-9b4b-08dc254905bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:17:53.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fIxCgLdowjyFm4ztbzl0ju3YZfRXcItrph6SmA8TJSpXb0ymCozoUf69z2uISLMdx3seFbjcHtOxPajXJq06ZZJKeSktJVeBEchZardRIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6820
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.821400-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tXP5rFAucBUHegqK9F+QonFa2o9UdV1eY2ab
	ZmsutUlsFGPl7f2/94awxH8BPFMeNJa+FAG1BTBPJ5W6OZe5hhf7KE7XIKgt8M/dZg2GSzOUcAJ
	RwO9xbIGIwBbALicP1oBOLpnEahLSNlkEs7t8193RP3YYzvGvkAZn/4A9db2RHZg0gWH5yUVCEa
	CCoG+rrDQJ3T99g06sZ1yrvKxpUVggpNt5EgFbMbc297PAGtWYF15s6prCIu87EPIkVcg+OWaGV
	MLZ5ERLi8zVgXoAltj2Xsf5MVCB1BLPx9cDMrKax5amWK2anSPoLR4+zsDTtEU1sg5GpXeU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.821400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7BDA6CE123544022FAC17518D47A66646CFB5867CF55772369CB942D5E0B6D542000:8
X-MTK: N

T24gRnJpLCAyMDI0LTAyLTAyIGF0IDA5OjIxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDAxLzAyLzIwMjQgMjI6NTIsIERhbmllbCBHb2xsZSB3
cm90ZToNCj4gPiBBZGQgYmluZGluZ3MgZm9yIHRoZSBNZWRpYVRlayBYRkkgVC1QSFkgRXRoZXJu
ZXQgU2VyRGVzIFBIWSBmb3VuZA0KPiBpbiB0aGUNCj4gPiBNZWRpYVRlayBNVDc5ODggU29DIHdo
aWNoIGNhbiBvcGVyYXRlIGF0IHZhcmlvdXMgaW50ZXJmYWNlcyBtb2RlczoNCj4gPiANCj4gPiB2
aWEgVVNYR01JSSBQQ1M6DQo+ID4gICogVVNYR01JSQ0KPiA+ICAqIDEwR0Jhc2UtUg0KPiA+ICAq
IDVHQmFzZS1SDQo+ID4gDQo+ID4gdmlhIEx5bnhJIFNHTUlJIFBDUzoNCj4gPiAgKiAyNTAwQmFz
ZS1YDQo+ID4gICogMTAwMEJhc2UtWA0KPiA+ICAqIENpc2NvIFNHTUlJIChNQUMgc2lkZSkNCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlhLm9y
Zz4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx4ZmktdHBoeS55YW1s
ICAgICAgIHwgODANCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
ODAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx4ZmktdHBoeS55YW1sDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWsseGZpLQ0KPiB0cGh5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L21lZGlhdGVrLHhmaS0NCj4gdHBoeS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAwLi5lODk3MTE4ZGNmN2U2DQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWsseGZpLXRwaHkueWFtbA0KPiA+IEBAIC0wLDAgKzEsODAgQEANCj4gPiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZ
QU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9waHkvbWVkaWF0ZWsseGZpLXRwaHkueWFtbCMNCj4gDQo+IFBsZWFzZSB1c2UgY29tcGF0aWJs
ZSBhcyBmaWxlbmFtZS4gWW91ciBiaW5kaW5nIHNheXMgb25seSBvbmUgaXMNCj4gcG9zc2libGUg
KGNvbnN0LCBub3QgZW51bSksIHNvIHRoZXJlIGlzIG5vIHJlYXNvbmluZyBmb3IgZGlmZmVyZW50
DQo+IGZpbGVuYW1lLg0KPiANCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgWEZJIFQt
UEhZDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIERhbmllbCBHb2xsZSA8ZGFu
aWVsQG1ha3JvdG9waWEub3JnPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgVGhl
IE1lZGlhVGVrIFhGSSBTZXJEZXMgVC1QSFkgcHJvdmlkZXMgdGhlIHBoeXNpY2FsIFNlckRlcyBs
YW5lcw0KPiA+ICsgIHVzZWQgYnkgdGhlICgxMEcvNUcpIFVTWEdNSUkgUENTIGFuZCAoMUcvMi41
RykgTHlueEkgUENTIGZvdW5kDQo+IGluDQo+ID4gKyAgTWVkaWFUZWsncyAxMEctY2FwYWJhbGUg
U29Dcy4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgJG5vZGVuYW1lOg0KPiA+ICsg
ICAgcGF0dGVybjogIl5waHlAWzAtOWEtZl0rJCINCj4gDQo+IE5vIG5lZWQgZm9yIG5vZGVuYW1l
IGluIGluZGl2aWR1YWwgYmluZGluZ3MgZmlsZS4NCj4gDQo+ID4gKw0KPiA+ICsgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ3OTg4LXhmaS10cGh5DQpBZGQgYSBnZW5l
cmljIGNvbXBhdGlibGUgIm1lZGlhdGVrLHhmaS10cGh5Ij8NCg0KT3RoZXIgc29jcyBhbHNvIHVz
ZSB0aGlzIHBoeSBidXQgbm90IHVwc3RyZWFtLg0KDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBYRkkgUEhZIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IFhGSSByZWdpc3RlciBjbG9jaw0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoN
Cj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiB4ZmlwbGwNCj4gPiArICAgICAg
LSBjb25zdDogdG9weHRhbA0KPiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBpdGVtczoN
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogUEVYVFAgcmVzZXQNCj4gPiArDQo+ID4gKyAgbWVk
aWF0ZWssdXN4Z21paS1wZXJmb3JtYW5jZS1lcnJhdGE6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4g
PiArICAgICAgT25lIGluc3RhbmNlIG9mIHRoZSBULVBIWSBvbiBNVDc5ODggc3VmZmVycyBmcm9t
IGENCj4gcGVyZm9ybWFuY2UNCj4gPiArICAgICAgcHJvYmxlbSBpbiAxMEdCYXNlLVIgbW9kZSB3
aGljaCBuZWVkcyBhIHdvcmstYXJvdW5kIGluIHRoZQ0KPiBkcml2ZXIuDQo+IA0KPiBDYW4geW91
IGV4cGxhaW4gd2hhdCBpcyB0aGlzIGlzc3VlIGFuZCBlcnJhdGEgYWJvdXQgKGV4Y2VwdA0KPiBw
ZXJmb3JtYW5jZSk/DQo+IA0KPiA+ICsgICAgICBUaGUgd29yay1hcm91bmQgaXMgZW5hYmxlZCB1
c2luZyB0aGlzIGZsYWcuDQo+ID4gKw0KPiA+ICsgICIjcGh5LWNlbGxzIjoNCj4gPiArICAgIGNv
bnN0OiAwDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiAr
ICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+ICsgIC0g
cmVzZXRzDQo+ID4gKyAgLSAiI3BoeS1jZWxscyINCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

