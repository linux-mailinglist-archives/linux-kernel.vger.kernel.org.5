Return-Path: <linux-kernel+bounces-9472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5481C628
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C2EB21090
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7BC15B;
	Fri, 22 Dec 2023 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MGY/7gBg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sEf72xov"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9351119D;
	Fri, 22 Dec 2023 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ac128aa8a0a011eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HZLzo73mtn2wccnkyN2uJWGgDRE0o+306Cmn6Fx1M6I=;
	b=MGY/7gBgn57PWfRydAWgzoznICFM+Q9Qk6qPV61qLjNcCrMZjaKN1Rh0iW2FeYF12ZR0wBiKai5K1bZXeDyl+yIExc7d0hoJH21StVRxVvI6IwUp16i11nbofwI5HXCwr6q+PG0e4WPIRHQ61ghErZmSppnoZE/t8KEDZmQk4A4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:adef543d-7a59-4096-84f2-60bb1a8f4217,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:c8b88e7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac128aa8a0a011eea5db2bebc7c28f94-20231222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 73239297; Fri, 22 Dec 2023 16:04:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:04:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:04:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Pl51izia2ns0kbLWVRIZ+W5uq6EqAYEaDhq5qz7SwGraOv2WFs4dqsQXxV59V50hr6ujW2DCdFt+vJN66dvJijiQXZbC1shrAvdSRqG2W3i28VFzOsZSeftqaulZAgqH5PBjp/5z1CmuCNjqS2JrZTvhnJZJC8jDiEIL20JD8IuCOKJCGNvZcnR44MS7+6N8rMzX3Sv/vxNev3Nh2LXF2erU1yZ/dg5c2WHgFA3w48zxcIsIYnGU1EAvLfWIGGPFTwxd9WgzvUMDZWUzCWUXBEx3XKwslcRtqmmK+x3m/8Dt0XWmT8l9QMaNsBP7lB8HwsEHoCZAVnxNIjFdGUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZLzo73mtn2wccnkyN2uJWGgDRE0o+306Cmn6Fx1M6I=;
 b=gcCTkBospJTW0rwiEtfcAfPD9Z2kn2jW9XkDJZliLE9MyrjKHnEJNi6ak+SwDGY3urJ6sabpi2HhOdxSWEAgj1caUoxnu5jTvUbzL4kzoU/0eZt5BG7YvelGOKmh2kB90ZvdUA9w+rsyBO2kyRqFvTdX5BBwbAqE5NlNE7f5ZCRwy8ioo1in7Kyy0pCncoS2LCwPZ/wmuxJyz25aH7u8KKQYze2QWEQFNDgLbv3Gp9aq/97g8outCmw8iiT1mtPRV7FHEzSLYUfHAks8tEs7mN8kcRNl1OMtw9rZDSB424DCFzWUFgY/+xTlJbSChH2ZSn3o8FLJtlGVvvTtIPB53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZLzo73mtn2wccnkyN2uJWGgDRE0o+306Cmn6Fx1M6I=;
 b=sEf72xovLak2tcLAdeVTDFnJMmMNsHBPRVmD0uaPHVAk0Gg5RVESbv+LAlTyOr1yAhhu74dTq/+i2ftbmyaB21TJGOgK7NhHpIcXi52q3F6CzZLxK+EdJgO7bFd2ZLDnRXBil+Aaa44apHexZxoF4SNdGnG1wFpq3kl4WJSzaBI=
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com (2603:1096:400:39::8)
 by TYZPR03MB5469.apcprd03.prod.outlook.com (2603:1096:400:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 08:03:33 +0000
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::7bc3:66:4e44:6c12]) by TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::7bc3:66:4e44:6c12%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 08:03:33 +0000
From: =?utf-8?B?V2lsbGlhbS10dyBMaW4gKOael+m8juW0tCk=?=
	<William-tw.Lin@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Thread-Topic: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for
 getting chip information
Thread-Index: AQHaMzDO9/93g4Oh+0uLsEeB3cLSlbCyCngAgALp3AA=
Date: Fri, 22 Dec 2023 08:03:33 +0000
Message-ID: <bc22f2164445dd02d04f7636171f1f521f998eab.camel@mediatek.com>
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
	 <20231220103901.22180-3-william-tw.lin@mediatek.com>
	 <97d54894-7c71-49d8-a456-869c398636ec@linaro.org>
In-Reply-To: <97d54894-7c71-49d8-a456-869c398636ec@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5406:EE_|TYZPR03MB5469:EE_
x-ms-office365-filtering-correlation-id: 6370fe3c-f9b1-4559-cae4-08dc02c47e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XL+ixCZwdSXE2E6zqiZXwoAJBfhbsuBMBjll2X6ASm1nOnqcgaASw15riQE2fygEeiqw6es0ETRJ3wLpySjyABoqJNqBMfgYYLdGSI2Hk4dXMty+yfKaxCPwoJMaAhn5LvSeucOe2ydMvlrGYBWdkffBB6de0Ogyb1jzzLNPUmc01YZ0q/AKDz2Ij7tF30p3w5jymHjosF/MqKK1Ug59Xx3m6yCsGxPzPcvOkJWkqVZDdsuPbCd2lYsyR2T1bIPA0K1EohRyVipXzFlQ6AOC53THEhmgOFkEXZlgnPnXmhOkMXqCNKh6bUr7GlalLRxE1SO4MCvdAT2+ukpwSezqIM+EJmFpHtGDNM9Uqgg4H/4tY0bFUUXIqYp7Aub/2Xs2ehuVdp8sLWWz+RezZp6eyOyJ1tJhKdO2p1qm2jOP6aDcOeR276EdF9h+zP3d/EWqpBgBWzN/KKKHS6TNhzJhtUPxsSjEBxycYvObME6O+uRA0Z50BU9dzPzuTAHl2I+0NFOyszwo6lEWcymvZE87LMhJ2djgeMj0ciPLolFayjjqji1jP+Mn5+55bUIW1/pBZ2jn2RaC1kTEul+F6K09bZfLc0ysJXmChi2uqwX8GCMfCcPspP3JQ5tkI6/3WFJ0s2yWoIP6/uvRc3yCU++QIZeiY6cxLJil3fsbje/tkb52LhrMY2Zxc3nv7o8vReEccG4F/wb3QitWyXd+C2okMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5406.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(478600001)(6486002)(4326008)(38100700002)(122000001)(5660300002)(54906003)(110136005)(66476007)(316002)(66556008)(76116006)(66946007)(66446008)(8676002)(8936002)(64756008)(26005)(83380400001)(2616005)(71200400001)(53546011)(6506007)(6512007)(85182001)(36756003)(41300700001)(86362001)(2906002)(38070700009)(4001150100001)(7416002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHBndFg2TXUvbUUxWFFDOFRRRTV2RWIzaXFJNDdic3BlUVU0K0hkQUVvaVVr?=
 =?utf-8?B?TUV0cHlqWGU2eG50LytjYmZyMHBJYU02M1R4K1BQZGFPczZmQ1d6dHZTOUg1?=
 =?utf-8?B?VklReDZzZDlUUFhkVE5reU5aY2xIWW9wQlExOG52bTJuQ0hBMWwwamlGaXRs?=
 =?utf-8?B?RFQrUHVYRjJwNDFINmlyOFFUK0dOOUZhZExtSHJhdnErVFMzMFdoWjcvUkVr?=
 =?utf-8?B?cDBFOWduWEVuMDh3VUtqTHFQbi91cHk0c1VkT3IrWkMrQ3NFajE5dUU0R3dL?=
 =?utf-8?B?ejAxaFRnaWViTzNTWVJ0NUlLVUpCSE1hdit0dS9DMWptTXZUYkM4ZTUvYzgr?=
 =?utf-8?B?Y0svZnRjclJld2hnMnQwbjc0QzhFcmJjdkw0ek1NVUM3L1A2My9vZk9ocXBn?=
 =?utf-8?B?QnBvaTNnZU5JNXFKVTZiSWlyamprMDJrbDVTMFRwc3ZDN05wNlVtSEg2dUx0?=
 =?utf-8?B?cXc0Q2tVOWhiR1FYQUVkc0ZLU3ZFTUFoTzZVSEZ3OUd0SThpS1FWajE0VzJO?=
 =?utf-8?B?V28yeU9MUFBsSUdhNmh6L2lNOWpQblN6VWdnbnZ0SlZCVWd5d2phTUJpb0h1?=
 =?utf-8?B?Zkx1WThmSjQzcGxOYmtlUFQ5bVR3aEtXT0s0QURlRUtaTFlQWC8xWHI3TzRi?=
 =?utf-8?B?ZnYzSzRRaXAyazl1eThhbzVYS3crOHpydlQ2ZVAra3VLNEtPWVljQnRGdG11?=
 =?utf-8?B?U2lLZGVXd2IyMk5EV0RGTHBMT0dDMHhxdmZJeFg1UlZJY1J5U0xwOHZmeGIw?=
 =?utf-8?B?NGhOTlg4MUNLMkgvZTMzUmQ5VWR6QkRkMmNDMXNMdVNiazNjK2tGL0dMNndY?=
 =?utf-8?B?YkIxTGlDdW9CYjRjMzVTeUhJbEs0dzExUmtZRHNOMGVkZlBtbGtTZStPMWR5?=
 =?utf-8?B?dklYcHVVdTZiZTdoZjlTYWt6K016cjNPazdmYmh2QWR4c2QyZy9QOFF3RkZl?=
 =?utf-8?B?SGlldDc0VlFZMWtUTHNvbDMvMlg0YXJtOVdMbi8vc1FSV1RmUGh0WHNtWFcw?=
 =?utf-8?B?NVZUVVJ3am1JM2ZySmZFSnpCaExhdXVZalpaMTFPRkEyeU1aSUdyOWFDWU9L?=
 =?utf-8?B?bGROOXVvSUJhTVdlUjhLQk1JbHdWUDJxQ3pIV0V4dnNaeW9PTFZmK0FCWUh6?=
 =?utf-8?B?WFVGVFVMOVF2dkh1aDlxdkRMQXhIR0EzL0JmOEQ1NlNBb0JJaGlmZVRobUpC?=
 =?utf-8?B?U1R5WDBVNnphdHFDM2lrN3BkQlRWZ2tRdGpjTTBnZ2VwaFQvazF3VzlkMG10?=
 =?utf-8?B?ZVZqK3FIR1gwVkxndVRzcUJkSHFQNk53Wlg5Z0pCMFJTSHBMRm1sZzRubzQw?=
 =?utf-8?B?RWVnS2xjcVAzN0I4eUpVSWdxNStKRE14M1hSVW5VMCtwb0lGbmFkUXhKa2tZ?=
 =?utf-8?B?TmNWUkZIbDVEcFBSdVpEUEVuNEpORWVjdnIrZytLSFd4NVBkWURZUUtHQ3U2?=
 =?utf-8?B?SE5oS28wVnRHZDM0SnpOczZWU09MR0dkS0M5aFBmZEsydUE4V0J6ZnpNY0Vk?=
 =?utf-8?B?TGVldUpwcG41SjkxUkpydXBSbEppSFBOVmdoYkVPRzNTd2Fja3BVbUxMcnlj?=
 =?utf-8?B?VldxamYyZ214L1haTkFoUXlnNGJqc0I0OFNmYXhwUzBKcW1zZGs3MG40V1Jx?=
 =?utf-8?B?RElYb0tKZGxZeFU0ZXlUK1Z4b2RxUE5IWjNVbERlTFpyL1VXOHM0Zlo4RzZ5?=
 =?utf-8?B?eWpGdHl3ZmJCYWlIRnNBZnZPaVRXYWlpcS9aS1o4NytwV1MybzRQZlNsTFc0?=
 =?utf-8?B?RnNlckJ5M1I2dnhlU1ltNVNuNFQ4YlpZZTJGMWora29IbksvL2lMcEdWSE5z?=
 =?utf-8?B?SmxXZm1sbW9JN3p2a3NxaExBcFVvL2JTTU9NV09HaEJnWDdDaWhFTFBic3lm?=
 =?utf-8?B?NjUyV0NBcG0zck4xZTJqWEx5UHE5SVpWY1U0VHE3QWxvYW5LUFU3blhsaDNm?=
 =?utf-8?B?OEpkMHhHVmh0ZVVXWGlOK3M5aTRhMVdKVkY0M0hZWmErRXllcHMzLzVXeGlV?=
 =?utf-8?B?UmxLNUY0YXV0Mnp3VGEyVC9yMDRPdVg1dDlHb3czV0tkaklCRDB5bzh0VHVU?=
 =?utf-8?B?eDk4ekFLUDhqRk9QYkVycTFVQTZEM2xsbXh2ZzBjbi9lcHg0Q3Y0M2VVZHJO?=
 =?utf-8?B?RGtqdzU1aFhFTmJJM1UwMjkxWlNlZVVEZlJCa2RuaEFvTFN2SGNXZEd1Q21V?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B38EC96020B1D45819A290CB810448F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5406.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370fe3c-f9b1-4559-cae4-08dc02c47e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 08:03:33.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1PjUvq/pQhQJdbVIWf2D8dxHHDP8KbZDDeIXDqvhbKck3tww53xnVTUGzGbekLo1Q/3zQLd/UpM8ljD89q1zgYOEN3IKSoRQFFHDA58IPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5469

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBjb21tZW50cy4gVGhlIGZpeCByZWdh
cmRpbmcgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcg0Kd2lsbCBiZSBwcm92aWRlZCBpbiB0aGUgbmV4
dCB2ZXJzaW9uIG9mIHBhdGNoZXMuIFRoYW5rcyBhIGxvdCENCg0KQmVzdCByZWdhcmRzLA0KV2ls
bGlhbQ0KT24gV2VkLCAyMDIzLTEyLTIwIGF0IDEyOjM0ICswMTAwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIwLzEyLzIwMjMgMTE6MzksIFdpbGxpYW0t
dHcgTGluIHdyb3RlOg0KPiA+IEFkZCBkcml2ZXIgZm9yIHNvY2luZm8gcmV0cmlldmFsLiBUaGlz
IHBhdGNoIGluY2x1ZGVzIHRoZQ0KPiBmb2xsb3dpbmc6DQo+ID4gMS4gbXRrLXNvY2luZm8gZHJp
dmVyIGZvciBjaGlwIGluZm8gcmV0cmlldmFsDQo+ID4gMi4gUmVsYXRlZCBjaGFuZ2VzIHRvIE1h
a2VmaWxlIGFuZCBLY29uZmlnDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2lsbGlhbS10dyBM
aW4gPHdpbGxpYW0tdHcubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gPiArc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX3NvY2luZm8gPSB7DQo+ID4gKy5wcm9iZSA9
IG10a19zb2NpbmZvX3Byb2JlLA0KPiA+ICsucmVtb3ZlX25ldyA9IG10a19zb2NpbmZvX3JlbW92
ZSwNCj4gPiArLmRyaXZlciA9IHsNCj4gPiArLm5hbWUgPSAibXRrLXNvY2luZm8iLA0KPiA+ICt9
LA0KPiA+ICt9Ow0KPiA+ICtidWlsdGluX3BsYXRmb3JtX2RyaXZlcihtdGtfc29jaW5mbyk7DQo+
IA0KPiBtb2R1bGUgcGxhdGZvcm0gZHJpdmVyLCBiZWNhdXNlIHRoaXMgaXMgdHJpc3RhdGUgYW5k
IGJlY2F1c2UgdGhpcw0KPiBzaG91bGQNCj4gYmUgYSBtb2R1bGUuDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0K

