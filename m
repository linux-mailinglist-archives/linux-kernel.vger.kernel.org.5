Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12578E037
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjH3TKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbjH3IdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:33:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24D1AE;
        Wed, 30 Aug 2023 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693384399; x=1724920399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bfmrUaSGPf9ipBu9qeBDcmyUnsXpGFOnV0R+qwcKPaA=;
  b=XW4lGz3gSQ1s7FzBZNWEd6GA0tGQuDadZy5b87n/2dOii0/rrb+iAOtA
   /IGR6f0U1TlSPJcx8EwwP4gRyI64MRoO8eC2oommLMPXI2TMJ4J77Pvy3
   WVdfBkATgqXHJZ02OORyiKopUhIJ9PLEbL3WHdwjITC7DT6umSq7RDpYK
   cABTRX5iExb9+DW4aPWu2y4PRKpqqd6630/+gJdLZ3xWWzcAcp/GgGkwL
   s3ugaHqdFfTarkz5wvCBvW8NGdQfHx7g6TLxVjgXspNte1ZnEdQj4ndWY
   t3PisZ8DcYxI7PHLnnGA/AFynOGH4c3e38+LJC4/L8tfOMLyxQcykT9a0
   A==;
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="1999082"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2023 01:33:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 30 Aug 2023 01:33:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 30 Aug 2023 01:33:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ356RW8E47r2UmgD4vQKzRK8RJDZNKL2dqNuMLJo0XDJwGxHZslp/ZRg0H/IsaWip7/zp/73mHVhMzB16T9z9GMi3A9z8aKGjrXzNNGeHcxvPPQh+b4d9oCogaXRzAaHd5pDm5XbajAq5M359FOsUIKmV3shGRIzAUYzId+PP8f63rOqM2tiU1+1UUreV0CcI0MwzN8SpiCOnmG5OlSIPBSAuWM64RAhXjh1dBtR5B2rRvayGaxOWGZPlvApZ5nI5fNyYAfeCxYeQ7ArbYx17SQZ05gdBXoeovyRH9o6YMUXjKdjDIyWW3KFyXk3a0OM0HN3HWzYvs9YJyz+DvGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfmrUaSGPf9ipBu9qeBDcmyUnsXpGFOnV0R+qwcKPaA=;
 b=HnMaRCJkGxjStGy2J8QIqoiNnUG6y0gu85yHkuH4Eor3Q+IEEiU40xaJdQbho+buvRb5kjkqCVCO0xOT6uVyJa5u45oUgVzcR1ZDAKuzTNlbAU+ehbzpp+KdQXqtn9eG0z+njMUktoVk4h3S58fomI3GxN8w5vYAHVHStVtEEb9sMP5+c1k79AQVc5QnzNxnlRXtGOXTjVkGwjs+DQ6dJjNfN0RFaRQfDbc86zNcRfasTQzcEh/bJQv1dol8QraC0HQ/svaRN8j6fCHuv8ylVBKKv0B86MHaogMMoR/npcccc5UD1UQQx4EsLnpQxaRXDoH4AnEtyl/4nCID/w3mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfmrUaSGPf9ipBu9qeBDcmyUnsXpGFOnV0R+qwcKPaA=;
 b=FzoV9wvCGtgJ7n722k8lAngtJJcTHg2AfNVzpJ0joxTrTbaXP46z+iqRGzHzBwwxWfqfHwU4Vp6XCR5Wwm+CS03e/If1TlderjuI3DFvEf45FvFhU/QnUXhMDF0MXN33r6Nea2hO1TjRM225rb0RMGtUJ+L5XNOTzlr9IeqVMPs=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 08:33:13 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 08:33:12 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Topic: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Index: AQHZ2o9SDk1SI69KHkCZzOSMXZ1LCbABgmKAgAEBuAA=
Date:   Wed, 30 Aug 2023 08:33:12 +0000
Message-ID: <ac2296410c46aac0166252defdf4dd5082c67ebe.camel@microchip.com>
References: <20230829154133.40716-1-marius.cristea@microchip.com>
         <20230829154133.40716-2-marius.cristea@microchip.com>
         <ab0d99ca-54b9-2535-a783-967a3b2443bf@linaro.org>
In-Reply-To: <ab0d99ca-54b9-2535-a783-967a3b2443bf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CH3PR11MB7896:EE_
x-ms-office365-filtering-correlation-id: ded832cb-50f5-481f-1727-08dba933bfce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLpELdQwhRWZSe3e9QBG2iFNy0+4s05OJHBz49aCOUNgGACmOJaT0Qd1qNXoAKuajS4e/dwIJSsiOzMnFNY3eebgABmvhA4OtEX6bRoX5I0e9JybM7xPm2bh/xOqvIPYVTFn4ISiB1yLsPa93iQKMgj1V88twoNIWYP7o0sMwcCrtJGJnn7kOw8zlk2Opa2dzMVvVRbZ8yi6H6ty3tTVP48ORMc2PquycP6bCZ4EGfJ/bHTqfN3N9ViS7U7mVMrcVZ2rFIv3KEYIPinShCCHeveFW5yRZTtubdi/aqZtbYrFrLuCTi/36jL4NKebJrlII+eBeJsU+H//N4sM4usYc0qfLewNo73e15EKdenmvDC9kshdpFvMKOFG/jMmRWIxeXOCOJpZFQm8V7BJMsIpiuJ8RvAahXQWD9zx1KNKdizwYb+xFI8W12tKLaef9TdkWf2/c99Qyd0LOm5/DMvgRvAi4WNsZX1f28SVPKzMcjnGkDV3VComBEYzHm9sFfz0tz0vykoGyJ4RGmnaoVL8qbYf1zIiANWOjaq/ydrM0lPUC4zCn72g1af9ONrLeNQkXor/4u8UqnR9BWHxkago36H+9+1qLrmGobU2iXabElcEa69WYIjL7DsdwvftIDOX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(122000001)(91956017)(66946007)(76116006)(478600001)(110136005)(53546011)(6506007)(71200400001)(66556008)(66476007)(64756008)(54906003)(6486002)(66446008)(316002)(38070700005)(38100700002)(41300700001)(6512007)(5660300002)(8676002)(26005)(36756003)(2906002)(2616005)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a282M3pneCszODJOUFAyWW5RTUR2NkFmdWtkbVNRMGNBTTh1U1RLczYwWE54?=
 =?utf-8?B?WE8vOTE2Q2hYVlVjczloaDkxKzUwRCtrTXoyNnVZY3cvMGdtUHdlYzZWOVlx?=
 =?utf-8?B?NmJjZk9XQ0FkYU42bk9FR2kxSTNsZlJjd0puYmpobVNHOGRBclNmL3Z0aTMz?=
 =?utf-8?B?YWVTaTc1VUNMRVp4bWRsTzRUMXVzbGg2ME9KM00wTlo2Umd3TWlQcU5waWti?=
 =?utf-8?B?dEpnK0thZ0w0VkxCRWJtTTU5eUxaM1cwdGtQazI0SjBRTDNGSFNpQWVnZlZO?=
 =?utf-8?B?eWlOSjNOaFJVYlE1QS9ZYnB6TXRwaUJSRktudzFzNHVtYUpqakUxaUs5RjFN?=
 =?utf-8?B?VjhWamsyQkQ2a1pITWs3TGk2bVE0MldIRjlHajIvd0duQnRaSzJrZ2lJQnEv?=
 =?utf-8?B?N1N1cFdQTm5RYTJFdjhwTEtQNFNjVy9LRHY1VXpIR1pKbEdXcjZIQkNqWXQ3?=
 =?utf-8?B?UHJJMEZqeVJnUGFpVGRVdml4aHA0ekhCZjg5U3JUVVpiK24xOVMvSE1wenh4?=
 =?utf-8?B?MCtmS09aenpFSm8wNWF0NVdSZ0tKaDJVZGtvM0ZPYmJQbnlTV3dITTBSaFBy?=
 =?utf-8?B?K1dRZzJmYlo3UDRINmpTMFFRS1dObjFDT3g2YnNsd0ZLRmZZR2lyZHhCU0Vy?=
 =?utf-8?B?RnM5WklETzA5K2syZ0htY1hIeS9zbWxuZUZCQklUVjRZSkpzdXhyemxUUmx6?=
 =?utf-8?B?YXJmOFJWd0JCYUQ0U3NnRERaRTV3dWhCemsxLzdDdG9KcFJuY2pXcEg1bzlh?=
 =?utf-8?B?ZHo3ajJTYVdnMjMzNWtHZHpMemhmaVhtTyt0U3FxdHZOOTVPYkR3VWpUWmR4?=
 =?utf-8?B?ZFo2UVB3Z1Bpb3padnhINm4xNWVTTnRwdUxzS2hob3I3SFgvcExydHFJUTlU?=
 =?utf-8?B?czJnTWl5eEZOMU96K0hwTEJ6dUl2dVVuZVFyQUJ1eVRIWGpCdDd3R2VzeWEy?=
 =?utf-8?B?VXVOY2xlblE3aFNGTlpzVytQbm95NmYxd05pMndDQmc3dGY3UituLzdaeDUz?=
 =?utf-8?B?MytRd3hzYXBhS0c5ZFFORlQrVldFUVVHMEdIS2RITUVPWnBsMzlXVzV3VHVG?=
 =?utf-8?B?bEJ4b0Zrdmh4Z2V5dXh3OFIyQUJ2Z1J6U1AwNmExZkNURUl0TWcrb3E3ckpG?=
 =?utf-8?B?RUk4ZTY0ZUtnaENMMlpkbENYMzBoalVYOHQzU3NENHJXMlhQcWxydzIwRXB0?=
 =?utf-8?B?eHZLRFZJalBKbUZ5RlJ1VGdKRGhIV1RwUVRFNmpuOXNBUE5nMFRsVVN4dWRO?=
 =?utf-8?B?T2RSYm1iVTg5MzJNUUFwckpQV3RGL1V5N2NsNi9hMTZWcGFuSHJpTEs4WDJK?=
 =?utf-8?B?RkQ3Z3d1TDFaUHRuNDBCNXVQRGhiWmVnc0dsY0pZWnkxOEZ5TlgxUEc1SE53?=
 =?utf-8?B?Z2puMmFXQ05VNnJkNlBkajI3bnNSN29ZVm8vTExyOWVPR1hhbnkxUEJKOHhm?=
 =?utf-8?B?NWd5NWNuOGp6dzRMODA3V01LUkZocjBFNXVONVdrR0pXczlJeGlXeTlYb05F?=
 =?utf-8?B?cUpOc1RSWkxEZ3IvbVZmTno4a3lSb1JkcHh4MTlkTVgxTVE0U0JjdU1MMzVn?=
 =?utf-8?B?VVZQWmYyWGZSZlNRcUVtcUxhN2F6c2VGa0swY1FtZUhubVZiWXQ5ZG5OVEhN?=
 =?utf-8?B?WnJtV25XVDByY3NvMzVFZm1xVGgzTmhvUWw0eHJ5d21oOGs0Z012MHgxbFpS?=
 =?utf-8?B?Ym5LSi96ZG9SN29LMzRZcEc3ZnFpNFlnOU1HNXNCK2JPUXNHYTJMb200ZHJ2?=
 =?utf-8?B?QXFLTkJvZnJrWDdYUkhWOGZTamNGZC85Uit3aEQxTDRhUGFOS0pNRmZzV2Jm?=
 =?utf-8?B?Z21RcUxVMUx0ZGNJRjFxQXJFZ2tudFozSy9mWkdJaGUxSXZWQm80Q2RlS3hy?=
 =?utf-8?B?REt0UDNCRjRFQkhYNUYyK2pwMmJLVVdwZzgxNkhiemRjbVlVZkJJcVVWUkNn?=
 =?utf-8?B?RWVDcGRaeEJOazV2SEdtVGhxZFlzNWFrMEFBRUsrSTI4Um1FeUFmQUZDWVll?=
 =?utf-8?B?UWpSSytxRlNubUdxWCsrMXpaTldJci8yNDk2QnhRV1JjaVhiZmlPVGlCUzln?=
 =?utf-8?B?MEpqeGpDWGpzajJOeHpXcTlhTkJuV2Mzc0dYcnExd2c1eWxrVlFxeG5ESWpE?=
 =?utf-8?B?VHdyeFhKTlJTTWlWMEVTSmN1V1duSlBXUHE2alVsRS9FRVErZEZ2NW82aE1Y?=
 =?utf-8?Q?HXrEvJP8h+RfiTaSRFvPRHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <926C283C9292CC478C3EA680EB2148F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded832cb-50f5-481f-1727-08dba933bfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 08:33:12.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEhemOki9CS9PH3E2O7K9P/HGcBavForkQXZ+3hjioTBYXUSv21NRJP20cAydqCfsSjan+Lgxxtg8wBG7uKYnmoa7nVRqSeGxdWFLOQPGHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoNCk9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxOToxMCArMDIwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiBPbiAyOS8wOC8yMDIzIDE3OjQxLCBtYXJpdXMuY3Jpc3RlYUBtaWNyb2No
aXAuY29twqB3cm90ZToNCj4gPiBGcm9tOiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFA
bWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBUaGlzIGlzIHRoZSBkZXZpY2UgdHJlZSBzY2hlbWEg
Zm9yIGlpbyBkcml2ZXIgZm9yDQo+ID4gTWljcm9jaGlwIGZhbWlseSBvZiAxNTMuNiBrc3BzLCBM
b3ctTm9pc2UgMTYvMjQtQml0DQo+ID4gRGVsdGEtU2lnbWEgQURDcyB3aXRoIGFuIFNQSSBpbnRl
cmZhY2UgKE1pY3JvY2hpcCdzDQo+ID4gTUNQMzQ2MSwgTUNQMzQ2MiwgTUNQMzQ2NCwgTUNQMzQ2
MVIsIE1DUDM0NjJSLA0KPiA+IE1DUDM0NjRSLCBNQ1AzNTYxLCBNQ1AzNTYyLCBNQ1AzNTY0LCBN
Q1AzNTYxUiwNCj4gPiBNQ1AzNTYyUiBhbmQgTUNQMzU2NFIgYW5hbG9nIHRvIGRpZ2l0YWwgY29u
dmVydGVycykuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1
cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gwqAuLi4vYmluZGluZ3MvaWlv
L2FkYy9taWNyb2NoaXAsbWNwMzU2NC55YW1swqDCoCB8IDIwNQ0KPiA+ICsrKysrKysrKysrKysr
KysrKw0KPiANCj4gV2hhdCBjaGFuZ2VkPyBDb3ZlciBsZXR0ZXIgc2F5cyBub3RoaW5nIGFib3V0
IGJpbmRpbmcsIHNvIHRoaXMgcGF0Y2gNCj4gbXVzdCBzYXkuIEVzcGVjaWFsbHkgdGhhdCB5b3Ug
ZGVjaWRlZCB0byBpZ25vcmUgcmV2aWV3Lg0KPiANCg0KICBNeSBiYWQuIEkgd2FzIGJhZCBoYW5k
bGluZyB0aGUgcmVzdWJtaXRpb24gb2YgdGhlIHBhdGNoLiBJIHdhcyBub3QNCiJhd2FyZSIgdGhh
dCBJIG5lZWQgdG8ga2VlcCB0aGUgInJldmlld2VkLWJ5IiBmb3IgdGhlIGZvbGxvd2luZw0KcGF0
Y2hlcy4NCg0KVGhpcyBwYXRjaCBkaWRuJ3QgY2hhbmdlIGFueXRoaW5nIHRvIHRoZSAibWljcm9j
aGlwLG1jcDM1NjQueWFtbCIgZmlsZS4NCg0KDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCj4gDQoNCg==
