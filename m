Return-Path: <linux-kernel+bounces-22367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F715829CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591011C213C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB74B5D2;
	Wed, 10 Jan 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OfUEv+4b";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qrpAgTPA"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088F4B5A8;
	Wed, 10 Jan 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A6STbj002408;
	Wed, 10 Jan 2024 08:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=PODMain02222019; bh=aE8CCKthFT2toNmFXNEFKHc6DZ9ZHD7mOCnHZdIaz
	cQ=; b=OfUEv+4byLFBKHAub34CwltcfUUhrKRkIhFLF6hka20bHI+tNvTJLNdww
	iniAwUgNxQPaTbZ/zW3HyMaAR4kXqG/NK4Npm4FseHQKMWdiJj96/4JEgYaOc0ff
	Vp5Stat1DWbt+o5yJGx/neTy5C8zIKmZemcfTush+3tI9KeuU5qKQEIJEROxeiaU
	9QGAlmKr1EVK9IYd9gA3efcPRpXumjB9UpPV10Su0XPwoUSsnMQQUl+X1yuWuhND
	OJyNHXb85UAGlfhwo+Sof7m4TZdriu1D5zVwQFyBf9GXizGlI8IlZPJvbt37co1I
	nkaunPGSWMKdD2mDYuLsNgKLcmfAw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vf45pnfk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 08:37:03 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv4YC/jchfL1stjlgPhSuej1aI086xv9YC9TtU2Ja7GO78R1bS2PHgOgWLrF5Cg/Rvf6YQ6GH90tg9s2LOSeG0uVYRG+FFmo63+4s4hOIvKBxScdig8wUBI3qfMmRexsj51/t6HQVN7e6BPRz4pHK0Qh/6wyex//1G6sCiuaZgb5UK7OQ12Y3AM1ApMShkSbLgUtzYfAv5sXWB3ZepQdJoDA6/UT6FzAneJA8yhfxruTeUypCfGZ7isHHYck8fHMyiLU1wDHbcWLskxWfOK0pfHlCM3onTRkUMd7JOnSC/HSbMPQ6B6x6A6VuA8F//ZP1seQU907AuA6J44eOQiaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE8CCKthFT2toNmFXNEFKHc6DZ9ZHD7mOCnHZdIazcQ=;
 b=OBp9I6R5Lf7I35jdvc7CIFMkcnQmoOGHcrAtF8zdJJfjykvjn7rBC8Ud45Lg0CHpoBQZnyI01DpUB6LRVyKPT7wHytWyCpcLR0zwOMu62qLTu6VTFFnOJ3elBZ2Zx+L9vUFyMtlbNHvrjDRdySKqoiZfsyuy7ytTrZN5Je2jSU7/FbL/NIXNFRkefNM9kgnWLIK6ehIKx7Zj/GI8JmX1uD6xRPx4ydaSY1McpUDlAVyOVd39/Z8uB6ZwoqYWK6c0f96B4hOp8P3ggvzXgR+g4pVpmD+bA+ogtc6oyT+wuqRznCQpXdBdBnWa9S3GI0qy80HwoE+PDwvP6hax3YJlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE8CCKthFT2toNmFXNEFKHc6DZ9ZHD7mOCnHZdIazcQ=;
 b=qrpAgTPAf+QRckaubgT22nlotYzeRPiGr0MtFVSO/KU+kdqCQKC2+mz42cckAL8VbhaTlv/lWgTZjRJXd1rG7e2xv9MfhYEVTvABlAmubcYYbLhjoWFNYLITkN+tPHplTbnE9v9usxaFSXVLuxi1QBXH7J2f4TfZiwlNE6cyBwE=
Received: from DS7PR19MB5688.namprd19.prod.outlook.com (2603:10b6:8:73::14) by
 MN0PR19MB5729.namprd19.prod.outlook.com (2603:10b6:208:374::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:36:55 +0000
Received: from DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb]) by DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 14:36:55 +0000
From: James Ogletree <James.Ogletree@cirrus.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven
	<Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<James.Schulman@cirrus.com>,
        David Rhodes <David.Rhodes@cirrus.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Peng Fan
	<peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        Jacky Bai <ping.bai@nxp.com>, Weidong Wang
	<wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Topic: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Index: AQHaP17EFm09wiwp9km197ze4eTGobDNm1eAgAR1GICAAAfzAIABDb0A
Date: Wed, 10 Jan 2024 14:36:55 +0000
Message-ID: <42A07166-6569-4872-B5E0-6D71C6F3656D@cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
 <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
 <ZZ3JNuLp-ZfGOQRF@google.com>
In-Reply-To: <ZZ3JNuLp-ZfGOQRF@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5688:EE_|MN0PR19MB5729:EE_
x-ms-office365-filtering-correlation-id: fcd5be9e-cfa8-4f35-9e19-08dc11e997c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dmlc0XK9q2FnAi9sM+KhR/s4t+XkCtQXcyxpRPc2djC/5eUcv1FgoQS/9rar3lKH/z0TZVmztcwONGza1CfOOnxZekxt8u3uvk4x7qN4WtnMSJ3/gkfqLO83PdSoCfw/oXQImW5vdDbW//6zQNsoS+GfxHbcTdWtIioou/IKI11b+Oa9lkRuVi/wqxq9HNg2fMZ4U95XuQB0ETtmZ1MBcZAws/45fdGrGqWnL2TNk3WzvvV7xIQVDUTOkDstzaxVea5cu7ub5Jqu0GRjO1FeIGV3TcOxGldWPQ1ZwjaYLdccqDiE1MEeiPLGSpy6WTAjcWhgAMyThq4E9TxfRII7FywjQzYw+I5G6fyNXaRiG25jsB4nQYuyOgA54gSOGP005gACokihDBEjktH6QS/1AU0yooqlUG5VZHi3tLqrqH5ew1ca5itF238JUKXeHY/kyqzJULL/78mNR4jwStGIbPe0Pw+KvKQkuJaSVbw+QqiZ1u79sOLboam337dP0Xi0P0Pxv5A0u4zmTGSg/GA8NKt+jYsXGdnXvAoFB/lZEhOJN70KccrhjvRWqC++l4oEgQKRjOV6T72YnJV8lfOa22iqlndKP9Caf9n+GoUm3G7FwMwR4kQVM7q3tKP3pVLl0byVqu923dcC/2+7tk4ABw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5688.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(91956017)(36756003)(33656002)(86362001)(38070700009)(122000001)(2906002)(38100700002)(71200400001)(83380400001)(66446008)(2616005)(478600001)(6506007)(6916009)(6512007)(316002)(76116006)(66556008)(66946007)(66476007)(53546011)(64756008)(54906003)(6486002)(5660300002)(8936002)(8676002)(4326008)(7416002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MnpaSFdOVUhxWE56dG1HZTBhQUkrTEJteU9hWmk4eWN5YTVQR1MwNHN0MTQ1?=
 =?utf-8?B?WnA1Wmx6Y2hZcUh4NnBkRFRCbnRYRUhxQ2p4ckl2dTVWdHZwUU1ZUWZHOWVO?=
 =?utf-8?B?TDBuanY5bDgzQUxsd2VtUXl3dkQ3cUlLa0x3Z1FwaWNGTzErWkd5azZ0dC95?=
 =?utf-8?B?ejN1WXZVdjNBSnY5WDQ3VTNxejhYakxzckVEVjBkc1BrZitZSk1VZEJiMGpK?=
 =?utf-8?B?bGlFT1V3WjNrZ1J0TEgwWk1lRGdGeWgvZmd4aGlmMlpKKzJJVGlIVnJwbVFZ?=
 =?utf-8?B?T210OVhXR3RXY2p6d2hiRW93Y2pONTdEaVl1b2dJKzRpUTJuWmpKbitrYVFO?=
 =?utf-8?B?T2RpN0dNMzR0NUJmRzhVN2hjT0xjL3J5MklnRGxqdUE4b0VpQTlTRXA0d1dy?=
 =?utf-8?B?Skk0YlFQalJnQW5mRE5PckdZb1hvT0FpLzN3QW1MdVlQMVY1a3N5WTRXWVps?=
 =?utf-8?B?a0hnUlBLZmR6NWdSaGtTVVh1NG84d0s0MzBWemNNMS9YTDNPa2tWVjR3VXpz?=
 =?utf-8?B?aGVETlVlcWZsUE1JeDVWcWxLcTdNRHA4bmJseldaVjhLNnRFUWdjVGdFcjNP?=
 =?utf-8?B?RWFKMU95b1JhZ0pqcSttV0pWc0hicnpQY09zcWJ0dXY3UU9idSt0YTdjL3VX?=
 =?utf-8?B?YjFEQW5IcW9Nc1huTDhoNHl0UnJjeHIrMFFXMlN3TWRUcHRpMGhoRDI5RlZo?=
 =?utf-8?B?aWVQeFRjeHZMQUZGOUZnRlBraFBJSUsrL2ZENXR2QkdlczY4eVZkSm1WUUpj?=
 =?utf-8?B?YkZaSkI1cU5oMk1JODFnNytBRHBRTys0bitta1lPTThpTWhCREFFRHhzd2xQ?=
 =?utf-8?B?dmdNVFJEVU4vaTNxL1pSY0MrVncwY0V3cXNVYzlwVmNXNFNLY0pHcWlJTXQv?=
 =?utf-8?B?WnZRdVRNQVhKdlNMVCtyVHNRbzJ6NGgydmRnWlloTFBDay9mcnFOTkVqUE5k?=
 =?utf-8?B?Q1RORlFVekRpdzdTWmQ5NVdpajJhQnZ1RVpIYW92eW9BZFpsTVFFelRHcGcx?=
 =?utf-8?B?SWhqS2cxSStkbGJHMWF3amI1QUkxUHJpWkRpNk8rQURibzBKcG1KOERmbksr?=
 =?utf-8?B?N2dXYm1TNnZhNHRmbkhjVU5KMFZqdEJjaDB1U09iVlBvRTZzR1d3SVYvV1JN?=
 =?utf-8?B?Q0RJY09CalRmUFk1Rkcyb3NIMzV5UHFNUko3cldqOHluSGNXU0V3bHFZd2k5?=
 =?utf-8?B?WnpSR2JYOHJhYi9lemZaWmFRaXF2ekI4T2FmUG5HczNDdVVzWFBUOVhrMGdz?=
 =?utf-8?B?UmNMZ29YNm13elM5eSs1MkF6amZLMG04UVF5Y09LaDA4MzE0Yk1pV3QzdVdu?=
 =?utf-8?B?cEpQd3QvVFQyb2QrenQyckZvNU9OeHJmbERqbWJlNTJvb3FiazZHQnpHeDQ3?=
 =?utf-8?B?Zm50TFZ6ZFVIMm9vUlY2OHdjSjgvWmVDOVlkNys4WlhTVUY3NVQxYXBaeXEz?=
 =?utf-8?B?VDlzUXcrSVplT2hYOUZmbk5LL3ZoU1ZpOFZMUGs5Q3NodVBUTmcxYS9adzNY?=
 =?utf-8?B?RXprM0dvZWZRaGpQQjlqUFRydCtUbDE1cXhXcG52c1dGc3RZRDJnQmN3ZzRN?=
 =?utf-8?B?YW9PYTFReDVrUVdaVHdnYS9FQlI4bEVOcWptcE8wNk92YkZzVVpsYVlTK2ho?=
 =?utf-8?B?SGlyL1NSczBSTGRtSUk5TTd4RFNhT1Rucno5dkNocU5SOWkyWkdtMS9mamhu?=
 =?utf-8?B?QUtUcE0rZzJ6a0UzZjM1QXp2d09HWERlZlFGSlp3NzlDOXVEdk5BUVdYbVFs?=
 =?utf-8?B?Uks5QnFxY2wzeXNyUm5FQjh0QWhzbE5zTWFGdTJvWW03WWp6OFVlQmZROFN1?=
 =?utf-8?B?T2tTUWZxdHMvamlmOG1GYmJpbzQwTnVDMUwrMEFkeXUwdmZaUHRRTGYzdllG?=
 =?utf-8?B?YTJ3V2NjdSszdFFkYVJuWDRmeVNRam9KT3RuTktNRkM4bE0zbUl6VjVoMld0?=
 =?utf-8?B?TGRzZThocEpobGRQYWs2N3poeDFrYWF1bGZ4d3plT00wMGt2c093Vmw0ZEVX?=
 =?utf-8?B?K2N5RWlOWHVXUFh1V2c4c0wrNjVXejBlNUtJM3liYTNZQ1lIeHZ3a0h2dGxt?=
 =?utf-8?B?dmJyWTMwMjNOaGZxUUdpTmZXYVFvNjJ5TjdwcjlKbE81eXc2eWdpNHJEeFRN?=
 =?utf-8?B?aXFBUHpWQ3NGYm5pZ2JGS3VlNktLbHFmRDRUVzNDM0RHdWl3ZnFRSmkycW1s?=
 =?utf-8?B?UHZPVmF4cXI3NHR6bmhreTExdll3NkpkK3VZMWVFWjR6VkZ2Z2ZFM3ladHVn?=
 =?utf-8?B?bCszSmpOZUxvRW14RHdWd0FXZHR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFA12A6B01BE9B48A7AD064A649878A2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5688.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd5be9e-cfa8-4f35-9e19-08dc11e997c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 14:36:55.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTAQVzaUcYyByyxQaLk8gMlBljhxGP4qDnyr89Rz2Ihb9SXHACDAbqu9ga6Oe34+ou6gEQDtLMMxC4gx0/QIUfhXmXO0Kntm45tQHVdi+bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5729
X-Proofpoint-GUID: FEFyViM-z6FNhKxIP3T-VNWl--CRb8dS
X-Proofpoint-ORIG-GUID: FEFyViM-z6FNhKxIP3T-VNWl--CRb8dS
X-Proofpoint-Spam-Reason: safe

DQo+IE9uIEphbiA5LCAyMDI0LCBhdCA0OjMxIFBNLCBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50
b3Jva2hvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKYW4gMDksIDIwMjQgYXQg
MTA6MDM6MDJQTSArMDAwMCwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+PiBIaSBEbWl0cnksDQo+
PiANCj4+IFRoYW5rIHlvdSBmb3IgeW91ciBleGNlbGxlbnQgcmV2aWV3LiBKdXN0IGEgZmV3IHF1
ZXN0aW9ucy4NCj4+IA0KPj4+IE9uIEphbiA2LCAyMDI0LCBhdCA3OjU4IFBNLCBEbWl0cnkgVG9y
b2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFRo
dSwgSmFuIDA0LCAyMDI0IGF0IDEwOjM2OjM3UE0gKzAwMDAsIEphbWVzIE9nbGV0cmVlIHdyb3Rl
Og0KPj4+PiArDQo+Pj4+ICsgaW5mby0+YWRkX2VmZmVjdC51LnBlcmlvZGljLmN1c3RvbV9kYXRh
ID0ga2NhbGxvYyhsZW4sIHNpemVvZihzMTYpLCBHRlBfS0VSTkVMKTsNCj4+Pj4gKyBpZiAoIWlu
Zm8tPmFkZF9lZmZlY3QudS5wZXJpb2RpYy5jdXN0b21fZGF0YSkNCj4+Pj4gKyByZXR1cm4gLUVO
T01FTTsNCj4+Pj4gKw0KPj4+PiArIGlmIChjb3B5X2Zyb21fdXNlcihpbmZvLT5hZGRfZWZmZWN0
LnUucGVyaW9kaWMuY3VzdG9tX2RhdGEsDQo+Pj4+ICsgICBlZmZlY3QtPnUucGVyaW9kaWMuY3Vz
dG9tX2RhdGEsIHNpemVvZihzMTYpICogbGVuKSkgew0KPj4+PiArIGluZm8tPmFkZF9lcnJvciA9
IC1FRkFVTFQ7DQo+Pj4+ICsgZ290byBvdXRfZnJlZTsNCj4+Pj4gKyB9DQo+Pj4+ICsNCj4+Pj4g
KyBxdWV1ZV93b3JrKGluZm8tPnZpYmVfd3EsICZpbmZvLT5hZGRfd29yayk7DQo+Pj4+ICsgZmx1
c2hfd29yaygmaW5mby0+YWRkX3dvcmspOw0KPj4+IA0KPj4+IEkgZG8gbm90IHVuZGVyc3RhbmQg
dGhlIG5lZWQgb2Ygc2NoZWR1bGluZyBhIHdvcmsgaGVyZS4gWW91IGFyZQ0KPj4+IG9idmlvdXNs
eSBpbiBhIHNsZWVwaW5nIGNvbnRleHQgKG90aGVyd2lzZSB5b3Ugd291bGQgbm90IGJlIGFibGUg
dG8NCj4+PiBleGVjdXRlIGZsdXNoX3dvcmsoKSkgc28geW91IHNob3VsZCBiZSBhYmxlIHRvIHVw
bG9hZCB0aGUgZWZmZWN0IHJpZ2h0DQo+Pj4gaGVyZS4NCj4+IA0KPj4gU2NoZWR1bGluZyB3b3Jr
IGhlcmUgaXMgdG8gZW5zdXJlIGl0cyBvcmRlcmluZyB3aXRoIOKAnHBsYXliYWNrIiB3b3JrZXIN
Cj4+IGl0ZW1zLCB3aGljaCB0aGVtc2VsdmVzIGFyZSBjYWxsZWQgaW4gYXRvbWljIGNvbnRleHQg
YW5kIHNvIG5lZWQNCj4+IGRlZmVycmVkIHdvcmsuIEkgdGhpbmsgdGhpcyBleHBsYWlucyB3aHkg
d2UgbmVlZCBhIHdvcmtxdWV1ZSBhcyB3ZWxsLA0KPj4gYnV0IHBsZWFzZSBjb3JyZWN0IG1lLg0K
Pj4gDQo+Pj4gDQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgdmlicmFfcGxheWJhY2soc3RydWN0
IGlucHV0X2RldiAqZGV2LCBpbnQgZWZmZWN0X2lkLCBpbnQgdmFsKQ0KPj4+PiArew0KPj4+PiAr
IHN0cnVjdCB2aWJyYV9pbmZvICppbmZvID0gaW5wdXRfZ2V0X2RydmRhdGEoZGV2KTsNCj4+Pj4g
Kw0KPj4+PiArIGlmICh2YWwgPiAwKSB7DQo+Pj4gDQo+Pj4gdmFsdWUgaXMgc3VwcG9zZWQgdG8g
c2lnbmFsIGhvdyBtYW55IHRpbWVzIGFuIGVmZmVjdCBzaG91bGQgYmUgcmVwZWF0ZWQuDQo+Pj4g
SXQgbG9va3MgbGlrZSB5b3UgYXJlIG5vdCBoYW5kbGluZyB0aGlzIGF0IGFsbC4NCj4+IA0KPj4g
Rm9yIHBsYXliYWNrcywgd2UgbWFuZGF0ZSB0aGF0IHRoZSBpbnB1dF9ldmVudCB2YWx1ZSBmaWVs
ZCBpcyBzZXQgdG8gZWl0aGVyIDENCj4gDQo+IEkgYW0gc29ycnksIHdobyBpcyAid2UiPw0KDQpK
dXN0IGEgcm95YWwg4oCcSeKAnS4gQXBvbG9naWVzLCBubyBjbGFpbSB0byBhdXRob3JpdHkgaW50
ZW5kZWQgaGVyZS4gOikNCg0KPiANCj4+IG9yIDAgdG8gY29tbWFuZCBlaXRoZXIgYSBzdGFydCBw
bGF5YmFjayBvciBzdG9wIHBsYXliYWNrIHJlc3BlY3RpdmVseS4NCj4+IFZhbHVlcyBvdGhlciB0
aGFuIHRoYXQgc2hvdWxkIGJlIHJlamVjdGVkLCBzbyBpbiB0aGUgbmV4dCB2ZXJzaW9uIEkgd2ls
bCBmaXggdGhpcw0KPj4gdG8gZXhwbGljaXRseSBjaGVjayBmb3IgMSBvciAwLg0KPiANCj4gTm8s
IHBsZWFzZSBpbXBsZW1lbnQgdGhlIEFQSSBwcm9wZXJseS4NCg0KQWNrLg0KDQo+IA0KPj4gDQo+
Pj4gDQo+Pj4+ICsgaW5mby0+c3RhcnRfZWZmZWN0ID0gJmRldi0+ZmYtPmVmZmVjdHNbZWZmZWN0
X2lkXTsNCj4+Pj4gKyBxdWV1ZV93b3JrKGluZm8tPnZpYmVfd3EsICZpbmZvLT52aWJlX3N0YXJ0
X3dvcmspOw0KPj4+IA0KPj4+IFRoZSBBUEkgYWxsb3dzIHBsYXliYWNrIG9mIHNldmVyYWwgZWZm
ZWN0cyBhdCBvbmNlLCB0aGUgd2F5IHlvdSBoYXZlIGl0DQo+Pj4gZG9uZSBoZXJlIGlmIG11bHRp
cGxlIHJlcXVlc3RzIGNvbWUgYXQgc2FtZSB0aW1lIG9ubHkgb25lIHdpbGwgYmUNCj4+PiBoYW5k
bGVkLg0KPj4gDQo+PiBJIHRoaW5rIEkgbWF5IG5lZWQgc29tZSBjbGFyaWZpY2F0aW9uIG9uIHRo
aXMgcG9pbnQuIFdoeSB3b3VsZCBjb25jdXJyZW50DQo+PiBzdGFydC9zdG9wIHBsYXliYWNrIGNv
bW1hbmRzIGdldCBkcm9wcGVkPyBJdCBzZWVtcyB0aGV5IHdvdWxkIGFsbCBiZQ0KPj4gYWRkZWQg
dG8gdGhlIHdvcmtxdWV1ZSBhbmQgZXhlY3V0ZWQgZXZlbnR1YWxseS4NCj4gDQo+IFlvdSBvbmx5
IGhhdmUgb25lIGluc3RhbmNlIG9mIHZpYmVfc3RhcnRfd29yaywgYXMgd2VsbCBhcyBvbmx5IG9u
ZQ0KPiAic2xvdCIgdG8gaG9sZCB0aGUgZWZmZWN0IHlvdSB3YW50IHRvIHN0YXJ0LiBTbyBpZiB5
b3UgaXNzdWUgMiByZXF1ZXN0DQo+IGJhY2sgdG8gYmFjayB0byBwbGF5IGVmZmVjdCAxIGFuZCAy
IHlvdSBhcmUgbGlrZWx5IHRvIGVuZCB3aXRoDQo+IGluZm8tPnN0YXJ0X2VmZmVjdCA9PSAyIGFu
ZCB0aGF0IGlzIHdoYXQgdmliZV9zdGFydF93b3JrIGhhbmRsZXIgd2lsbA0KPiBvYnNlcnZlLCBl
ZmZlY3RpdmVseSBkcm9wcGluZyByZXF1ZXN0IHRvIHBsYXkgZWZmZWN0IDEgb24gdGhlIGZsb29y
Lg0KDQpVbmRlcnN0b29kLCBhY2suDQoNCj4gDQo+PiANCj4+PiANCj4+Pj4gKyB9IGVsc2Ugew0K
Pj4+PiArIHF1ZXVlX3dvcmsoaW5mby0+dmliZV93cSwgJmluZm8tPnZpYmVfc3RvcF93b3JrKTsN
Cj4+PiANCj4+PiBXaGljaCBlZmZlY3QgYXJlIHlvdSBzdG9wcGluZz8gQWxsIG9mIHRoZW0/IFlv
dSBuZWVkIHRvIHN0b3AgYQ0KPj4+IHBhcnRpY3VsYXIgb25lLg0KPj4gDQo+PiBPdXIgaW1wbGVt
ZW50YXRpb24gb2Yg4oCcc3RvcOKAnSBzdG9wcyBhbGwgZWZmZWN0cyBpbiBmbGlnaHQgd2hpY2gg
aXMgaW50ZW5kZWQuDQo+PiBUaGF0IGlzIHByb2JhYmx5IHVudXN1YWwgc28gSSB3aWxsIGFkZCBh
IGNvbW1lbnQgaGVyZSBpbiB0aGUgbmV4dA0KPj4gdmVyc2lvbi4NCj4gDQo+IEFnYWluLCBwbGVh
c2UgaW1wbGVtZW50IHRoZSBkcml2ZXIgcHJvcGVybHksIG5vdCBkZWZpbmUgeW91ciBvd24NCj4g
Y2FydmVvdXRzIGZvciB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IuDQoNCkFjaywgYW5kIGEgY2xhcmlm
aWNhdGlvbiBxdWVzdGlvbjogdGhlIGRldmljZSBpcyBub3QgYWN0dWFsbHkgYWJsZSB0bw0KcGxh
eSBtdWx0aXBsZSBlZmZlY3RzIGF0IG9uY2UuIEluIHRoYXQgY2FzZSwgZG9lcyBzdG9wcGluZyBh
IHNwZWNpZmljDQplZmZlY3QgZW50YWlsIGp1c3QgY2FuY2VsbGluZyBhbiBlZmZlY3QgaW4gdGhl
IHF1ZXVlPw0KDQpCZXN0LA0KSmFtZXMNCg0KDQo=

