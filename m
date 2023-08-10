Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C69776FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjHJGHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHJGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:07:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA25B1728;
        Wed,  9 Aug 2023 23:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691647628; x=1723183628;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=yde+7CfZGPJHeDapCdz6Kyn9EGKzFLaHahp+XhjkX/o=;
  b=HOnr45eZ1MDlJFt3p4Zeplc7/pw5tk9y7Hy59YuiigSSCIA/cCniH0XA
   JDsmA7sPBrj1Qt7G+hgLWPLQA+sUPbiszvdTuBr9b7lxU4u4zo45d0wE7
   SN5Kpp0XvafdyAZvTgv4bCL8Eu0V67tnpJsnORLfSbWHhZQcjuZR4gVw7
   wD0Z5Evs1AmzO28kEgUpMD2JrcLMHKQ+2oVBQjSnnh+lA/athKVeDlB53
   eFYS0WAv4HDAFb+5TN45CTiUI9FlmMJ9m1vpZw07FezqlqF4Ka59gowby
   atZ3va697OoiwfdL+q2z2A10csRagUO8FaAkaggjz/qmIphnU6A6yPub3
   A==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="165773383"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 23:07:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 23:07:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 9 Aug 2023 23:07:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIr2DJUvx2QbNY8yaPjv32sazmCqs6G4EdOPt/lvktKiZ1It6E1ebBddegYP8wEg78/GyKCTM5Zuns4ErFe3+qLFQSthBkW7QVWvRx7xaucSp9CGIMrWetZmWuCM87ruiVT8kSzqOSQR0poV33j/KwkpisT1lkBFdJMMGFgbyT5pvxD/C+Xk2IUfOkFqXiKZNPk6By4epibTn9ZFP5SjTAcTJ3uwQ6Y4xHuJDjq0zx+004bbMPzhTyar9DigEzfgu3pC8lS2AscmnFtFVdyA6HAwGaW8qm+A6vbPhc64ogroxsEoJSjALnaFpcFK8KRUVabH4D7jmE6l7nP/pyFUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yde+7CfZGPJHeDapCdz6Kyn9EGKzFLaHahp+XhjkX/o=;
 b=nnCIOVX01bnmCjoEO2V3LONp/QJTakXQyDAQBSpZRYpyUniS1mohTd9neoIsNv1A9Z6r54IlXy6ZY9yZIrB69ygO4HzkjqNx/pBWBAI0iQF5OzPZAitpVG9g0EZUdp+quXpnxNn4BELhhWctKOH04Sl3fcqhmh3eIIG9FK6uXCgbls3hqe/v2jxM7AzR0Zd93j89flg12avvW+ALwAsgEubrYqLZf4+4ehWnQqAd1N0WK2YTOZq218LFY509ugyW5uPniGBR0TBaac9WDg+PBJaGTTxM+06vps0rp6YvIdKnNLlIaGE6iWZeIUk34Bvm/r+0VvxyQ5OlO4ois2GV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yde+7CfZGPJHeDapCdz6Kyn9EGKzFLaHahp+XhjkX/o=;
 b=XLFmlQjOvkqWuh3iPJkK9N0zKVW3+G4/+ussFpzD8dalksjzecaVRja2b/jiK4FXPMXG197mdTJkqnJwZxS5XceK+WGlzanUNltB5ifMF/dQ+wMx4aEWvZ75y3g0ERejSHvkZpBZdTLCDV+AUae37MbBkTMTvGe2VlLHUXybhtI=
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 06:07:05 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:07:05 +0000
From:   <Varshini.Rajendran@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Thread-Topic: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Thread-Index: AQHZwT2jCSX0WfI8jEav2hRLgd0xLK/PDigAgBQHSICAAAiCAIAAAVcA
Date:   Thu, 10 Aug 2023 06:07:04 +0000
Message-ID: <ced9143d-2325-45c7-7509-8439ac421007@microchip.com>
References: <20230728102350.265520-1-varshini.rajendran@microchip.com>
 <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
 <f97b2698-f482-622b-5f9d-02c3113db546@microchip.com>
 <3ff895eb-9675-9133-1b84-8d40b965e8da@linaro.org>
In-Reply-To: <3ff895eb-9675-9133-1b84-8d40b965e8da@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY5PR11MB6344:EE_
x-ms-office365-filtering-correlation-id: 3f2145fc-cd3d-4824-27b3-08db99680576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOCZtLzg3zudEbk8hZzIEjNpNc68kdMutTrvIXjPmc70O8hzO7rDTptpP8+Fdz4bQ+70uKnwDZWtJ2yBmvNtfFSGyESdRXwKEWyZJ1g54iqfSUJyffYVPZzQE1LnZhCsaPh7kln7LlGKg8sTXMUhRu0vYfAU+42mEARB+wIqIiVnqC0VPfiywn+ZbMtFRRbntslJWJ33Ify/RoW6tH8jVOKOIwSGeOoZ47UcLLh/7DCN7Jy24RBaxIiuBy3u3D7dgjsKJQoZETthoul6HS/QHiWTTgtEoBltxd4s28+xwFxXQGn2ZXe3FFOoHoEpkaXXpwzuR8/qauBBbqfZZupoh6uUceeVbDsOmE1uHYQsT5IVwaNLvHE7WeMSQFh8Ot9mCFMl/XreEx0uvrk6hHvSaYi72wNA7ScY61gynC2LCQDhwg3VZuWbt70skPAkf/5HM7r4L2OzmHuG3s0SmmfBdHQNueZlfJq5RHy3CJCMY4Yv9jx0wUFtHk2uNoUJAZNC/Uj9qmAHNyX+ax9Rymt7/mOJvme5WxAeQUvqT4iIOBWhFaMZX5tf7PEpPt7RSmxmiLpQfaSf3oz84DphYyv/mtsDEsKNzbzXssJMkF6MfOOdClTiphme0nA3Q59kGD/Qd+Wt0zinv2Oe1J/XA4n2rD8mjuB5sFqYg+0XeTSj5vc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(1800799006)(186006)(36756003)(53546011)(2906002)(478600001)(26005)(6506007)(6512007)(71200400001)(6486002)(31696002)(86362001)(8936002)(8676002)(316002)(7416002)(64756008)(66476007)(66946007)(66446008)(66556008)(5660300002)(76116006)(91956017)(41300700001)(38070700005)(122000001)(38100700002)(921005)(31686004)(2616005)(110136005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlNoZG1uRkZIMks3UnovSXNXOHQvT3ZaQ2haMTdOeEd0LzlVbC9QSFRTdXJK?=
 =?utf-8?B?ZEZ6bE85RFpzK0dPdE4vMi9VN1ZzejhUamVXY0NsVnB2aGN6R0VUbFRLU3A1?=
 =?utf-8?B?OHpkUWdDZngvSUxNbmJuRFJ5RC9hOWpXRDBpWFpCYjBoVHZLNS9zYUQxUnNS?=
 =?utf-8?B?a0Jock5SVlFPM1RST1J0M0FJTTZwbTFkUHpLYndXS01PZ3dlb2lDM25jZG5q?=
 =?utf-8?B?ZVExZVRQQXF4eVlmM1c5VStWT3M0Mis3YjJpb2R4MUg3ZVl5RnhXVjltcHdX?=
 =?utf-8?B?T0YvMW9vME9TOXJVUEc1RTJmbnFxWVM2Z2VoNXE5dUJTblFoL3lhNDNyUFpH?=
 =?utf-8?B?TmtMOXA4c05lak01Tmt5Ryt3Z3BBWXBhVGFIbjJXVTJoWmdFZDBUTkE4Szh5?=
 =?utf-8?B?UWRuVHkzcUdYMHB4eS9jYVhNMWgwYWMwSE0yU3orQktGY3VuaFhwcGRrRXUw?=
 =?utf-8?B?RndHcGdQVXRCNUdNYjlFcXRLNUVXZkE3azhzMlJhRzVGNFYrSFR0UXlHNTh5?=
 =?utf-8?B?b1FSWXUwZ1FGd3pMNEdTRVE5WTNaSmx2NUJvOW5JTjRSSml6R21xNU82V1hW?=
 =?utf-8?B?bmRUWWFsbkJXQUFCTnRQUkxjbi8xZExZYWR0R2hSYlpINXZRM2M1KzJLdGkw?=
 =?utf-8?B?bHp4ckpyRnBjTVkxYjNNb3lFQVZmelUyaTNpUEVVcExiNEhnc3E5Y0NheUEr?=
 =?utf-8?B?ZjA2Q2VVaXRJejVBYVUrRUc4M0ttNXhGcFNja2o2QlFWUC9iNlI2N2NKUHUy?=
 =?utf-8?B?S2Z2RWZOMTFLRlc4MlMvd3JUdURjWWc2cnZVRHpkRHpETjlyNmdmc2xJd0l1?=
 =?utf-8?B?aTduNkluQmRDdFExTGhKUW5HckFuOWQzcFhGTkxCZ25veXNXZ2pIRTNGZm1o?=
 =?utf-8?B?QTl4VmtZbm5GamVudlFvTkdYT1YyNFYzSnlmd2xNd2ZQc3E4Y0dnT1JVMHU4?=
 =?utf-8?B?YmhCSThRM2k0dE1kZkZHa0RSZG5oOVZvMHFCdTdYTTZKWFBWMlFmLzM1bk5j?=
 =?utf-8?B?eUQwYTZaUVJ6KzUxbkE0UDVZQ0x4Q3ZyTGZLMkRxMW1XZ0FkS3NLT3EwQzRM?=
 =?utf-8?B?a09iZGhOdWtsdUM2Ny9xVVFleTlCVENIYzNHaGFBQWQrV3NVOStNS2xrVWIw?=
 =?utf-8?B?TEU4cTY0VVZ4OVN5eHlEYlNCcXE5cXJFZTNxTUNkQWtURG85N0crUGZScjM3?=
 =?utf-8?B?eXZTSHNzRWNoNDZGZ2NRZnFPRDN2Vk1DZCtDaWNQUUxqNmxaSHEyNmY3ZGZ6?=
 =?utf-8?B?UnJmYWg2bEtPaDZkNThvRWJSVVNSZmc3OHZHT1V3Qnl0QlRuRStkOUpNeXQ3?=
 =?utf-8?B?RmFFQk9ZVFNaN2p6T3dpY3RGNTA4S1g1LzhaeVBLRnN0OGY2Vk9UZ1IyUm1T?=
 =?utf-8?B?RzBsdXFzUVFTRGxkYVo2enZxNThhT3RoVkFFZkdTTGZxMWlFam5vWkZzTjRR?=
 =?utf-8?B?dE5ScTJqcGhzQzNDekYxdFZUT3gyYkJRZkNzSVJmL0hFa3ZtZnRZd3JqdGNM?=
 =?utf-8?B?SWttUUdTY1NNWWg4NzJQS2I2MnVwS1Q5V24vNGlFcUg1eHVFay9zQWdYUmtI?=
 =?utf-8?B?ZCtuejl6clhSNzBVRWRWMWI1clNnM0JWMlFOMUdPODl3V1Q4WXUxbkJ1TWdr?=
 =?utf-8?B?ME1GNWJMeWJYV3ZaVXBoKzZ6UkM0aGhTQTV6V2ZPb094M1JYVHZVcUhjeGxh?=
 =?utf-8?B?dHRkVmp1SjNhdGhGZnpXMVJwdXpValBJdk0rUnZNSXpaQlpzODRna0hWdi95?=
 =?utf-8?B?bHJZT0VpRFFWM3NnR1k2YXpPb1Ywb1dyb013NnhmcWpFVkdBNVd0OXZtaGo4?=
 =?utf-8?B?RENQR0JmY1R4YVdMRWF2ZTIrR2prYkRyOGVLNzAwcnd3d1NJekRwYjVMSnpa?=
 =?utf-8?B?ZFpzc2JzNTJ4c2pIWk0waVM1dG9NNEFmNjBCbXlOUUpzUnZWR1ZoUlUrT20w?=
 =?utf-8?B?UlJQMmFXSTNGWTllZkIralAxa2cxMEZSODlCbzg5RVg2OUlXVnZXNDhPT2ZC?=
 =?utf-8?B?SWNmQ2dNTkFOUHBxUnF0NXNBQ1dSQzlBRmplcWlrTTE2amdpMFBEZUd3eXgy?=
 =?utf-8?B?aUhxaTJWOXNQeEh0RXZTZHB4aUJmdmRGMzk4TmFqYURhMkZYbTkzN2NseE03?=
 =?utf-8?B?MHNRZWFoRmRRL0w5endncEZNQURmR2tuc0d4NXFHeDlXcEh1VExDSisydDBE?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9351D4D820514DB52A4BC29C0B2A70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2145fc-cd3d-4824-27b3-08db99680576
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 06:07:05.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAZ4rLAh5ceuxCBf/bh98gyvmsCyqjS9C8voUAkc4BpbQCXEZUhw9Qhj8qCAEtxQBdoXjKvIhoXnSQn2YZfTQzGKEoEfg/6vveWYoF5qEI5YkXzMfJZSsBwhkQVZjr/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDgvMjMgMTE6MzIgYW0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTAvMDgvMjAyMyAwNzozMSwg
VmFyc2hpbmkuUmFqZW5kcmFuQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IG9uL2RldmljZXRyZWUv
YmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sDQo+
Pj4+IGluZGV4IGMxYmRjZDkwNThlZC4uY2UwZDk5NTAzNjQ1IDEwMDY0NA0KPj4+PiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1w
bWMueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xv
Y2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbA0KPj4+PiBAQCAtNDMsNiArNDMsNyBAQCBwcm9w
ZXJ0aWVzOg0KPj4+PiAgICAgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNC1wbWMNCj4+Pj4g
ICAgICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXBtYw0KPj4+PiAgICAgICAgICAg
ICAgICAgIC0gbWljcm9jaGlwLHNhbWE3ZzUtcG1jDQo+Pj4+ICsgICAgICAgICAgICAgIC0gbWlj
cm9jaGlwLHNhbTl4Ny1wbWMNCj4+Pj4gICAgICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4+
DQo+Pj4gV2hlcmUgaXMgdGhlIGNoYW5nZSBpbiBhbGxPZjppZjp0aGVuOj8gTm8gbmVlZCBmb3Ig
aXQ/IFdoeT8gV2hlcmUgaXMgdGhlDQo+Pj4gZHJpdmVyIGNoYW5nZT8NCj4+DQo+PiBIaSBLcnp5
c3p0b2YsDQo+Pg0KPj4gVGhpcyBTb0MgaGFzIGEgbmV3IHBtYyBkcml2ZXIgYW5kIGlzIG5vdCBk
ZXBlbmRlbnQgb24gYW55IG90aGVyDQo+PiBjb21wYXRpYmxlIGFzIGEgZmFsbGJhY2suIFNvIEkg
dGhpbmsgYWRkaW5nIGl0IGluIHRoZSBlbnVtIG1ha2VzIHNlbnNlLg0KPiANCj4gVGhpcyBJIGRp
ZCBub3QgcXVlc3Rpb24uDQo+IA0KPiBJIHdhcyBzcGVha2luZyBhYm91dCBhbGxPZjppZjp0aGVu
OiBzZWN0aW9uLg0KDQpPa2F5LiBHb3QgeW91ciBwb2ludC4gSSB3aWxsIGZpeCB0aGF0IGluIHRo
ZSBuZXh0IHZlcnNpb24uIFRoYW5rcyENCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4u
DQoNCg==
