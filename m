Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409AE759A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGSPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGSPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:41:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CCC2698;
        Wed, 19 Jul 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689781273; x=1721317273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NBrGVUFRONNpJkol/f++DqTLg0u1OFRp0l+a8A/Mc7E=;
  b=x+CuMEmC9Wu7omQ2BSdQjZdIaWrrPNFHJpAuhESB8uYyXAbXGC3ihuGJ
   TQvaI5HAYOGsvguJJRBRXVFIcmMA6X5L4y+xAH0C+lKW2Y7oudOGI41hI
   q81XGcOo9I/93rn76mp9EW2I9kdb5+DvZ0fZsAqHSRhHUntae0o9M20zV
   FOH2+3TpXn5cPmGo5+9JFRXuUGeiR2p7ZR4+3HKPAwbZ7yFhH5npOXLDl
   AOWAY+TyO/1KR2r8FIpsyhepWIHOFBdbkVJN0blcfyJIxJkGX/KE6O7GO
   SLb3nkh7CgUvBlDxdo2+ypryXjoj+6BCKpNtRypD8yx391FZeW4R3yAwZ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="223993872"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2023 08:41:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 19 Jul 2023 08:40:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 19 Jul 2023 08:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljzUKgtaasEUbC5IS3thFUhxjCX6x6ay8pOirqIsSq7t5QuVbY/9wHDBWmBJLxEeinYKvoCKp7w7chZNuMTpdAuhYRul6nG9ITofdS0VKdprHvaI1efn4C7SFuwler+z2WXUJMqkF28ySJUZCMBfmrVhW65PcqQdECqZf/LcEUc6DLQOSVhlhYHeXQQUzccXm1oTaKfLe+WOjVfo9q1psqhH4l6rXy/220XqEl42Swl2/TNJFAkauERZAKO5R8jpLneNku181o4h2VanfLgo/ow/wWxJDl68o7LcOM1yT4yl/iaVhyA++QnKdTeYiY8dqOV33E31FpQD83HDSBXn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBrGVUFRONNpJkol/f++DqTLg0u1OFRp0l+a8A/Mc7E=;
 b=kF44Skcij4FTNl4mR8rMSlcmnhHi2zCxHMYjhOxG3hJNTcFXb+l9yT1vbciebZzSL5z+E2XdZ7+Q468tLhoI/xEfn2aKL3scVKv5fYU1QkqAft8ynL4n18bcWaWaY+4wkE78GO6h5zBDdFndh3Yh4CErcspaugb5rRGOtenojIVvlmWAVd8UKECqs1O1qSnsA0DTEN41Jc02N4Of4dxXL8bb/qrWCQts7aWkAA15FLju2csXwVGpaoAAYZnWONG7mR0oJF2qUUVJ+a+22MszM+AIJHVN9p+z5yjDXdGrGKmRStLBlIutW30jYH9vjGtpGrTjnRRfVnVGdjGHEPhWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrGVUFRONNpJkol/f++DqTLg0u1OFRp0l+a8A/Mc7E=;
 b=Tb76DWwH3zOJ3xH8ek19mDif5LRvbEWIJ1g9vbMJaLEyqgH/cNhZs/u6XVXL9/UhuOg3SYp+1SezLHrChDLcQMdy7uGimmWGFDFHYeE87Qm61kbDWlrzj3dxNEdRLCNI1CcU/phdLr03fco6Dtu9Uvvca+vCxZN3/JPnybX63mE=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 15:40:56 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 15:40:56 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Index: AQHZtmQN1fNQSJrvVUecFTBMTPHvkK+9gjCAgAO/14A=
Date:   Wed, 19 Jul 2023 15:40:56 +0000
Message-ID: <3d5cc96388f27b1f03f5a1d3bee7113686548e43.camel@microchip.com>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
         <20230714150051.637952-2-marius.cristea@microchip.com>
         <d0682516-28aa-dbfc-81d1-33300c669835@linaro.org>
In-Reply-To: <d0682516-28aa-dbfc-81d1-33300c669835@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|DS0PR11MB7459:EE_
x-ms-office365-filtering-correlation-id: 66b6a871-28fd-4bb9-134d-08db886e8b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NO+PJ6Ydmp7aNnqw2+1U29L63AN1sJWRgKZ0rsqnWjbEF/d45cn1+B87lwGH+bGgIWOUgKjbbJ7eZyC0nKKFiq1lCTKlrR/QnAzcGa1/lZp/E3faEbOdzHq+J3QbbSwQCDB+4oE1umgiM8IMr+iPI/aNcFjtDvjgzKgu6a2WJakECuoN8ZMAsHaO86pgEblLLc8mZuvmS03ycR7uYpfY8fJtwcI0uEjyIAnagyue2EzJAfusMfFQDQQF+4nt8WRNhNjk7GZBVv4yVjFvzUVCaNtKfGNn0fSaXUFOwzTGbebt/1b+scV/Xam5XoME8Yf/hF6SZmMR4PR25tPfxPu7UNAsOkQmPDd9qGVTGgMjdpAfVsoh71bnDL2cGF4D9o2sLfYlpckTBugztKlvvlRzL/GRx8SM90i+IzwCfOCZcorvOWz5KRsy8SXEWRzqY6smwnslk/NCXXy8aS5YmeurZLL4tB8jwMrDAfDTQlq0Gix166OIUsi1B4enCt8/qeGVip34yfAblfg3XWrOoRfkcoWzNE/6eIbTSxv/OMy+aLMGT5KONzReWl38RAeMjKzN6y0Ic34h4DLmyrcJoBda3DGVmkoOUUMABakO+Kf6BnOlAJGmh4xy11I1QbOfSieo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(110136005)(478600001)(2906002)(54906003)(91956017)(6486002)(71200400001)(8676002)(36756003)(4326008)(64756008)(316002)(66556008)(66476007)(66446008)(41300700001)(8936002)(66946007)(76116006)(2616005)(6512007)(38100700002)(122000001)(186003)(38070700005)(86362001)(6506007)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3c0S1c1cC9OY2FDNTduR1J4TU5Oa0VONkhudWhjdVQzWTdPZVc4R1JjNGVl?=
 =?utf-8?B?SHJIclJNcjIxTFBDUWROamIvTzNGQU5SRzAwY3BzOXdJTGZQMmF0NkpnL3pu?=
 =?utf-8?B?OXRWak9qdUxiUkZFaUFzM0p0M0RrREQ4aGlqYjArNE5ldVBrKzVLMzBnQUQ0?=
 =?utf-8?B?bXpRSE1PZFJzTmN1bEc2MjVSM2NwUjhsSjBlcW05QjRrOXNPVlpKSmVCbUpH?=
 =?utf-8?B?NklNOG4rVE9vMVBBUGJQQ0x6NCtQNjBQbmR6VWNaSHUrVWNVZVpDdWxUK3l3?=
 =?utf-8?B?L1Y0M3VmeUh5WUpXM200aWRzNjFRbDEvcW54RGRBeUJRaThlZk9qbEhPWVdG?=
 =?utf-8?B?c2cxWjIzSHR3WFgyb3g3dlYwVzA5eVJWRktJZUxNVG00MEZtTXR6ODdoT2tN?=
 =?utf-8?B?ZHlKNXJwUm5UcmxWNGFyMS9jc0Z2MVp5a2NKRmFHeVBJZFF3UTdnN1lXZFlT?=
 =?utf-8?B?MUVjbHo5Z21vNHBaUDdVaGpLWEFXb3p5ZUJYb2dPWk1WM25hN3VxOE9HUnR3?=
 =?utf-8?B?UGJBeU5VeGtydVBUenUwUHFYVGdIMzlIbGpzNStMTmVDVmVDSmVCSUVqbjBq?=
 =?utf-8?B?WmxwTTlSd3ZDTW5vREljWkhVUmZ3WXY3YTVzR0gyeWV5TU1jTVZjdllQRWc2?=
 =?utf-8?B?RlhTRncrb1pCS0ZCMWcyY1I1cjcvUG1YbkQzeXJkUUZ5Z2lIY2JJTlhOTUxJ?=
 =?utf-8?B?cHVUeEVsbmtOLzNXUlJMeU8yOUhNN0JndVJPTXdhdWtodGNRN3JmMkNkWWFO?=
 =?utf-8?B?QWZVUkF4dlpxVXJhYSthMHFMcFc2ZDBmaXdjbGgvbDBEVFA4K3RWUk1tRlBx?=
 =?utf-8?B?ZE91eXRaNUkwaU4yc1hPbFpUb1ZTOCtvc3hVYXBWSWQ1UktTekNvZWtabHpL?=
 =?utf-8?B?NStIV0lyTE14MnluOFB3ekRiQXJrZnk5ZndGaDVscE1BdXBhYjkvZEwxVE0x?=
 =?utf-8?B?WTlicEw0N1NESEJEc05QWjBjOExnaEI3VHdBNlVadmFsc21XeGU5bU5IdGJj?=
 =?utf-8?B?MUVWNmpkcys0czRjalkwODhVU0twa0RIdkV0dmE3eWNFekx1Y2lWRlkvL1Ar?=
 =?utf-8?B?bW5vNTYzZ3V5MWpiUkNHaS80dlF4dHdXOXUxaTFRdVd6TjVSYzArU3U4VkI0?=
 =?utf-8?B?VDZSMzdOMzEweWkvRVNYYVlHMEpiN1VhZDZ2eFFaZWVWUlJCbHM3aFJ3Nmpm?=
 =?utf-8?B?R0VjVGdVRjZaa08xSWRxZk95OHdyT0lKNHhVSnUzK2Fqa1FSeUFNOEZqUXF6?=
 =?utf-8?B?RUpWbjBZZzZ2M1JxOGJwWkgyRzg2Y1hKTXVHZlZjZnM2SGpDd3NVKzBPUVl1?=
 =?utf-8?B?ZVJ1RzBwaDVqc0p3ZzFZWTNDbzFadDFRVkVTd1FZZ0ZYNGhCdTRmTE95KzYz?=
 =?utf-8?B?K3BEbURnQTRPZC90Z3VLQU5HSVJYVzA5b0lGWHR0MUp3ek00ZlV0QWlYUlhm?=
 =?utf-8?B?OEFRMHR3NUJ1Y1gxcUxRYmJJSUNMaHhYSHpYUlJheXBRSEFNdk9uVVpTbUJF?=
 =?utf-8?B?VW5FRGtrSCtlUXB2Sy9MZXp3dFdzVzNoWlAwWXFjMDdBYlBiSlB2WmJsK01P?=
 =?utf-8?B?dGEwZlkvOEZHdG5rajNXNVdBSWpVZllTUUVycllPc2pFYmRGRm15cTVoS2po?=
 =?utf-8?B?WVVGQnc2eUtqR0FFOGRDcVV0UzN4OU9aQ3NVa0xrOUxJMVl4TXBIckVQemFZ?=
 =?utf-8?B?ZmgyVTFQbzVVQ05HcjhtNnR5UVJFVlBjZ05JTExKbXRuY1hNSmthR0hjSmpQ?=
 =?utf-8?B?R0FmUzZsTW5xeVlRcExWeEc1SkUyTXd6K1JjOVg4aUZzY2lQdFR1dTdlVHFj?=
 =?utf-8?B?NkdNVnN2aSt3ZFFoemN0QnpBdzVicXpkcUlmRE9rc3ArdURJTGVkeEhwUlhO?=
 =?utf-8?B?WTc5Z2taVExyY1lYdEpQUmJNeUNqUTNDT2NvMW4vbmtUNzIrV2dHVXZHdzVO?=
 =?utf-8?B?eXdPaHR4QUUxYUFockFaYXVlc0VYVDZpcXl2OEZJeit3ekhmeFNuU2ZOU1ZS?=
 =?utf-8?B?cVViWjZrVGl2d1RCaks3SkZIdkljejNkMXZ0V25WQW5RQnFTYmp1Y3VWbFBP?=
 =?utf-8?B?Z21wZVk0U0tQaldDcmJCeno3RlFlbWx1THJIMFM1TXlod0hDczZweG50bmRE?=
 =?utf-8?B?UUlpbEF5SDBBdzlmOTd3QXhGejlreHlqNndNaU1CV1dFOXJpaXZVOEdoaHda?=
 =?utf-8?Q?a+yC8Sn0QGPRZze2jdZjn8o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8508347C821558468A8D6581F8DBB1F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6a871-28fd-4bb9-134d-08db886e8b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 15:40:56.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k+ifz6cTA74sR2spMgxi/c8jvz7udK7JiGbeWb7Sm/CAuyESaozo3Unin9pZgMFK9COpmKWmn6lyXryU2lQfXAd3Yl8qxtrLrdGA4QBXw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArwqAg
Il5jaGFubmVsQChbMC05XXwoWzEtN11bMC05XSkpJCI6DQo+ID4gK8KgwqDCoCAkcmVmOiBhZGMu
eWFtbA0KPiA+ICvCoMKgwqAgdHlwZTogb2JqZWN0DQo+IA0KPiBNaXNzaW5nIHVuZXZhbHVhdGVk
UHJvcGVydGllczogZmFsc2UuDQo+IA0KPiBPcGVuIG90aGVyIGJpbmRpbmdzIGFuZCBsb29rIGhv
dyBpdCBpcyBkb25lIHRoZXJlLg0KPiANCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiBSZXByZXNl
bnRzIHRoZSBleHRlcm5hbCBjaGFubmVscyB3aGljaCBhcmUNCj4gPiBjb25uZWN0ZWQgdG8gdGhl
IEFEQy4NCj4gPiArDQo+ID4gK8KgwqDCoCBwcm9wZXJ0aWVzOg0KPiA+ICvCoMKgwqDCoMKgIHJl
ZzoNCj4gPiArwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246IFRoZSBjaGFubmVsIG51bWJlciBp
biBzaW5nbGUtZW5kZWQgYW5kDQo+ID4gZGlmZmVyZW50aWFsIG1vZGUuDQo+ID4gK8KgwqDCoMKg
wqDCoMKgIG1pbmltdW06IDANCj4gPiArwqDCoMKgwqDCoMKgwqAgbWF4aW11bTogNzkNCj4gPiAr
DQo+ID4gK8KgwqDCoMKgwqAgZGlmZi1jaGFubmVsczogdHJ1ZQ0KPiANCj4gV2h5PyBEcm9wLCB1
bmxlc3MgeW91IHdhbnQgdG8gc2F5IHRoZXJlIGFsbCBvdGhlciBBREMgcHJvcGVydGllcyBhcmUN
Cj4gaW52YWxpZCBmb3IgdGhpcyB0eXBlIG9mIGRldmljZSAoZGV2aWNlLCBub3QgZHJpdmVyISku
DQo+IA0KPiA+ICsNCj4gPiArwqDCoMKgIHJlcXVpcmVkOg0KPiA+ICvCoMKgwqDCoMKgIC0gcmVn
DQo+IA0KPiANCg0KQWxsIG90aGVyIEFEQyBwcm9wZXJ0aWVzIGFyZSB2YWxpZC4gSGVyZSBJIHdh
cyB0cnlpbmcgdG8gYWRkIHNvbWUNCnByb3BlcnRpZXMgZm9yIGVhY2ggdGhlIGNoYW5uZWwgKEFE
QyBjaGFubmVsKSB1c2VkIGJ5IHVzZXIgb24gdGhpcyBBREMuDQpUaGUgY2hhbm5lbCBjb3VsZCBi
ZSBzaW5nbGUgZW5kZWQgKENoYW5uZWwgdG8gZ3JvdW5kKSBvciANCiJkaWZmLWNoYW5uZWxzIiB3
aGVyZSBJIG5lZWQgdG8ga25vdyB0aGUgcGlucy9jaGFubmVsIHVzZWQuDQpNYXliZSBJJ20gbWlz
c2luZyBzb21ldGhpbmcgYnV0IEkgd2FzIHRyeWluZyB0byBmb2xsb3cgdGhlIGJpbmRpbmcNCmZy
b206IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDcyOTIu
eWFtbA0KDQoNCkJlc3QgcmVnYXJkcywNCk1hcml1cw0K
