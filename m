Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAD786799
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjHXGjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbjHXGj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:39:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9C10F9;
        Wed, 23 Aug 2023 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692859166; x=1724395166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F4O5z9EElv3rXoJSR1c6QPYxzg1Av187ClVYL7R/zrw=;
  b=JRUhKQZs48cyoUb46xD/kGU5IMA99FN2kSc2M0NaZ+5zcfGY5dXZFEr6
   5Uk7ZrWKB9uLmdImTtRoCtE8SO+SFtd0e0H8RzRtxtlbQ/jacwu6fVCO7
   5TmQQj8lvAlMGZRQZP2sRqksr05wWagewOdLiaxC/uaOz2IHp4D23LV8P
   9FxS5OJR+BQbetwRToSZfi/pzBKzEKyQ7pDNRt/8Umx76J+ZXz/kh1m34
   JF5mp8iXmPBUjp5Pk9NKL8t2FIbFYY7ZvduFGF8jADOysfcWtQXAd9m3K
   A3xfqba4CjoG+pT2FxYh9GTehRg/Nwjj9ACax4O0gmmW1Nx2OQIdNXZO+
   A==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="231470007"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 23:39:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 23:39:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 23 Aug 2023 23:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3L4N+dygUvBbMcdsGRONAV0SnFpWQ7MBpZ0w64dmHHm3wcAw7Inv9wUK6UQPOaO4o+JLAelhQmaOBL1RW4RcfhgT+O0mGN9Kf2xE5y7KrDIlWJshtq+Di0IOMRQ3NwGJkCOuo9a4K9ZnCg9vJ4CVI62y2KPfcorC9SziFtEdXunC+gKOQAxli2V3D534RNd803NnVGmedh1nJnPnLfPLF/YL7KM/eb9K5nkefm6jpWab51YQ5jajxDRZGw4gh6Ex29TAweT0Ujk0bl7s1CoRuBLFPgK0pmWY6Y0teIpG/Qx8xNGKSdNnRxkSIvBMt0qWKZX9dmXdjKNSFN3AFKK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4O5z9EElv3rXoJSR1c6QPYxzg1Av187ClVYL7R/zrw=;
 b=JUeuN+UndXGJbMV+2OCb1fEnjbkWLnoexgTjO3eT8tQPRskQCiCAzUbmz7s/jqWG/7tF/d06cXNUHX8CMsMAlpmAg4gddHoY1nS2Y/ERwJL66cAcah9mT6HOvYlChAos7jMV7LsnRqvO5d2Wl8sbn2MygsM97pEPayDcFT8MtHjaMxBjjL2cmCVfUPeomIOx/Gnah5NceKOSdn5gynI/4KC+MUirCidxLdJ8yWqJMOpP7ly4C1to5irWJqkUVr/2P+8EuijB+GtyNzf372zRnUXTOjDpOPwb3LLB0hUCpDEBVDhyQj19moadh9s8LG4zVOeMxhv7YoKvpc8xjWYK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4O5z9EElv3rXoJSR1c6QPYxzg1Av187ClVYL7R/zrw=;
 b=YyraovrANMZutHOMUMXieGG9Sm7G7CzaB3h12nuK03A+2t/alUsNVLIFBDofOz2lM7uyEE1jBUuRdqb8FpxjEkaJxlxWvlrS4Ou018WRe4TctaA8c0tYLLu2vTKIGuSv3TMwv162/1zaICItpKgPkvRdiQVjoRpu5hUfI60Y8WY=
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 06:39:07 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 06:39:07 +0000
From:   <Balamanikandan.Gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <dmitry.torokhov@gmail.com>, <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
Thread-Topic: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
Thread-Index: AQHZ1a5MHo1XTdZMVECNex1WPftljq/30tcAgAEtJQA=
Date:   Thu, 24 Aug 2023 06:39:06 +0000
Message-ID: <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
 <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
 <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com>
In-Reply-To: <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|MN0PR11MB6058:EE_
x-ms-office365-filtering-correlation-id: a7576fb3-4ecb-4ef9-9953-08dba46cd0d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJk9O5RaZv5bO7/YqrMx47EcnG/bDI+UKwJzLYoItg9Hz7msDjrg9SqwB98nPFGxQCm1DmkmubcFZNymqUR2GSrnX0BYtgYKl/XORK2I3JgWMyK9iHF2SFKN1aAZMt2wXCQLXfddmBmVAFO/UAW36BKqhJ9LaaTXMPwcsbNmoGRD7OTjOQo/ZfJeDeTbd/XppSX0GlMoJ72XooRKmfawZmXPEtULO5g+NX/zAArufkhxEXrO5+r1aMa1BJbUvPAxrQcnQT7clHld1HQRhe/vf4FD+bjJESrMx+V/r7/RJ1eOwJ4yd9sAID50fieQ6cL+hQ0yOrcsaAiwWvS8bVKMW/p6SDz3fG+aZZlRYWiZua/8h2sjMsiuS4ljcNXGyCiO05KR4GcK8BDr0I7mcYXx5MKdJtEJnpPS7MgcvYTCh1zUU4myEjbdnqiwOFyHR8qnmeWNlOrrdoDfKJhbzn9C6KTU0Bsz4QFaSpwkNkH4PW7TDXEPh2ZKa92yErLRejS5p2X/BSDhdCg+SR7LNAikYjgcb2jTmCCpTwScaOm9Z+tMdJc6GEZ0dNfh9ugrKRBtTTtxwc16h9x01isiI81P76qyUYmtNeTl9Th4LUiob6GHEW1pA8BQrRRcDuNFks3K8AsbEfZydZIgNy0fJNMJ/48sWgzjD4G6f5JeAI09mLD+kluzYGONN8wZuxalRIEj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(107886003)(4326008)(8676002)(8936002)(36756003)(83380400001)(26005)(71200400001)(38100700002)(38070700005)(122000001)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(54906003)(316002)(6916009)(91956017)(478600001)(31686004)(53546011)(41300700001)(6512007)(2906002)(6506007)(86362001)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmkycTY4a2FaYWJJWXB6clMwajB3THBlcE0yVnNYNjNOTUxoL2owdGxXbzhj?=
 =?utf-8?B?L0ZYc0Qrb25OeGt0cVJRWVdxRFpvOGF1S0cxZ1R0bFVCZElBMnV5UDlJUUNs?=
 =?utf-8?B?Q0luSHArdUFoamR2MHQwN0dGRy9OMkhXa1dXYlRtWlBRZzVVUFNEdkpEV2xv?=
 =?utf-8?B?TW9EZldPd0hsbE1NcUpRcklxOStZNThWN1hxeTRjUnNYakpKeHRhaUliWjA2?=
 =?utf-8?B?MFNqQ1pmLzN2ZjgxNnpKYWEraTFvRjdKYy9pZGtCNVh5TTRCVlVWRTdUZVor?=
 =?utf-8?B?a2Y2RFkxUkJadG4yTmJBUXN2aFFIT3BLRXBHK3B0VWVrcW1JbzdJbzJhdGl1?=
 =?utf-8?B?SXBSTWtnTzQ4dzB6YnNSNWZWa0hJd2o5eGZPa284ZmJHY0FaV3oyUmlFaWZQ?=
 =?utf-8?B?Z2dvYTVJc3pKMlJWOHFJaVNJOTh6ZHdFcmJvWHpWdnU1cU80ZytlNmRxSmEy?=
 =?utf-8?B?bXFjUnBVTlpjMUFESmIvYU5mNnRiTjBGR3RkZFBLODBqdHEyOUI3VDF4QmdN?=
 =?utf-8?B?bW5HQTZuc1RhU2dSeURhVnptVHlCd1NCeFA5TW10UVdLOWcvL3FXOGFmVWht?=
 =?utf-8?B?bG1tZ3FMUzRsdDBqbjA5MlZVejNRSTVYZnkrWnN2MTJGSUdJK1BIelRIZ2Vt?=
 =?utf-8?B?cW8vckY0QmlFVW41RjkrM0R4WmN3UjQ4RitGSEdMQ2svdlBlcEsvRnpicm9J?=
 =?utf-8?B?VjMxUEpOb2VwUGNTNkhPTFdGendHbENyWlRqRlh4cHZnTmVEWU5TM3pLbTRW?=
 =?utf-8?B?SSsxVVFCdk52U3NaZDc5d3k5ZEJDa3c0U3hhbUZDWGRqQklUT3d3NEhNZ2dZ?=
 =?utf-8?B?Y0xaekRuV21CR1dpb0psZGFTUDNjRDcyOGxlakJTZVpET1RpRmRLTVZoQTBR?=
 =?utf-8?B?TE92MTdTUldZRENnZTJoZzh6MmJtRHZjK2RhdlJPd3pzZXAyWTByZjErR0dn?=
 =?utf-8?B?RFJLRVJWbTJja0YzTUcvK293MmQxaDlnckRtTXpBcGZSY2hqUHc2UUNVRGx3?=
 =?utf-8?B?YTJyT2k5TzM3UWJJSHRsdEZDUTRuejArV1c5M041a2lXZ3ZqQ0M2RURHU1F4?=
 =?utf-8?B?anNEdFBXdkxsR3h5RnhLK1Y1RHRHN3ErQUdoY2NPRmJub2l5d1FxSzYwM3VM?=
 =?utf-8?B?Z3Y4Q3pmQytmejNMQk5pSU0yb2N6cTh4K0xIdGxOc0k5aFJUU0tpSDN5dEFS?=
 =?utf-8?B?a1Y5Z1ZQVVdQTFN3bEl3ajNuYi9KUW9Rb0pGd3NQMldlWi9ZcUNvOFRHMjJI?=
 =?utf-8?B?bitqMDMrWDRidUFuTHp0WktFWVlDK2s3czFNM1FYSC9EMlJYNmpXL3Arc1pZ?=
 =?utf-8?B?TjNaNGRkRlRzZWNKb0VqV0VXK3EwdnFvRmYvbTZVRUorSzY1MENxMTYrRHVo?=
 =?utf-8?B?aHByTlJSOEE4V3hEQmN2WHNwMkN0bE5CRHBKeU1qbEwwV3l5R0RkRkluRlR2?=
 =?utf-8?B?L2YvQ0ZYdGJhZGNYQ1JxVTJ3L3ZoaEovaG5HU0cwdSs5THg5M05TT0U1YXk2?=
 =?utf-8?B?OG1rU2libXVQOEthanN3TTYxRGk3MERVdmNQV28vREROSmN5SERsdUVhUFpt?=
 =?utf-8?B?MFRiV01xWGVpSWZkYXV2b0JaSWp2RmlLeW9qNkJ1akZTdGt2UUhaRUNWM3px?=
 =?utf-8?B?bWU4bGR5ejMwaHpXSVc3UTNLTExoL3JPM3FGZlY3MVNERE1BTHdCd3lML282?=
 =?utf-8?B?clFWTXVvdVVneGZNNkZGT1owOHhMNE51eHFqdVEwdjREeW1zcGZxbDU1SVFj?=
 =?utf-8?B?K3RxWnNzOWh0M3NzRVU4dFJSam5SU3VSaWNva010NWRBcHA5V0FZNG5EYzgv?=
 =?utf-8?B?R2V2UUhTdmZZS2YwdE4xbEh1eUFoUVRTVkJsa3ZVblJnaXBRMEFYVjlDNi9i?=
 =?utf-8?B?MjFjcEhwM3RoaFdFZWowc0lpK1pqY3RyRXdSRWJNNFpqTmVzUytzaFVSbEVQ?=
 =?utf-8?B?dDlqQnpRUVhpaDl4TEdSMm1jZ3k5RkYyVGtoQkRSWUU2RS92dWRFUmhpR3Uw?=
 =?utf-8?B?K050U29KS0xMSHpTWG5xSFBFSTU5anVjU214T0cvbGhPYTlzTk45T29NakdQ?=
 =?utf-8?B?TDU5WWxHQmVIY0x5cmZxU3ROdUNiWm13Z3huWE1TelFsTWV0N3lKKzUwNVNU?=
 =?utf-8?B?akp0YU00UE9paTI3aVRBU0dYWXRMSERoczJGS2h1T2ltai9FZThOWk4rbzVV?=
 =?utf-8?Q?9xS1k9VZCGfLF8tWro1kCn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFAF67550F37C44BA8E25A5F9C75E7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7576fb3-4ecb-4ef9-9953-08dba46cd0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 06:39:06.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSQluY0kclJZmQWDb2rkeLuhmcx+sKnVkDdN2KE7fZMuCUQfPdGcqxTx4bRtZ97ImxmLSrFrzsRsRBUv0mXVjpu9olkHkdgMJPnYiupbHlLraQHH6z64eTNN7uvTkuOt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMjMvMDgv
MjMgNjoxMSBwbSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+IA0KPiBIaSBCYWxhbWFuaWthbmRhbiwNCj4gDQo+IHRoYW5rcyBmb3Ig
eW91ciBwYXRjaCENCj4gDQo+IE9uIFdlZCwgQXVnIDIzLCAyMDIzIGF0IDEyOjQw4oCvUE0gQmFs
YW1hbmlrYW5kYW4gR3VuYXN1bmRhcg0KPiA8YmFsYW1hbmlrYW5kYW4uZ3VuYXN1bmRhckBtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBUaGUgcG9sYXJpdHkgb2YgdGhlIGNhcmQgZGV0ZWN0
aW9uIGdwaW8gaXMgaGFuZGxlZCBieSB0aGUgImNkLWludmVydGVkIg0KPj4gcHJvcGVydHkgaW4g
dGhlIGRldmljZSB0cmVlLiBNb3ZlIHRoaXMgaW52ZXJzaW9uIGxvZ2ljIHRvIGdwaW9saWIgdG8g
YXZvaWQNCj4+IHJlYWRpbmcgdGhlIGdwaW8gcmF3IHZhbHVlLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEJhbGFtYW5pa2FuZGFuIEd1bmFzdW5kYXIgPGJhbGFtYW5pa2FuZGFuLmd1bmFzdW5kYXJA
bWljcm9jaGlwLmNvbT4NCj4gKC4uLikNCj4+ICAgZHJpdmVycy9ncGlvL2dwaW9saWItb2YuYyAg
ICB8ICA3ICsrKysrKysNCj4gDQo+IFBhdGNoaW5nIGhlcmUgaXMgdGhlIHJpZ2h0IGFwcHJvYWNo
IQ0KPiANCj4+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfTU1DX0FUTUVMTUNJKQ0KPj4gKyAgICAg
ICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAtPnBhcmVudCwgImF0bWVsLGhzbWNpIikg
JiYNCg0KVGhlIG9ubHkgZGlmZmVyZW5jZSBhYm92ZSBpcyAibnAtPnBhcmVudCIgd2hpbGUgdGhl
IGV4aXN0aW5nIGNvZGUgdXNlcyANCiJucCIuIFRoaXMgaXMgYmVjYXVzZSB0aGUgY29tcGF0aWJs
ZSBzdHJpbmcgaXMgZGVmaW5lZCBpbiB0aGUgcGFyZW50IA0Kbm9kZSBoZXJlIHdoaWxlIHRoZSBv
dGhlcnMgaGF2ZSBpdCBpbiB0aGUgc2FtZSBub2RlLg0KDQptbWMwOiBtbWNAZjAwMDAwMDAgew0K
CWNvbXBhdGlibGUgPSAiYXRtZWwsaHNtY2kiOw0KCS4uLg0KCQ0KCXNsb3RAMCB7DQoJCWNkLWdw
aW9zID0gPCZwaW9FIDAgR1BJT19BQ1RJVkVfTE9XPjsNCgkJY2QtaW52ZXJ0ZWQ7DQoJfQ0KfQ0K
DQo+PiArICAgICAgICAgICAhc3RyY21wKHByb3BuYW1lLCAiY2QtZ3Bpb3MiKSkgew0KPj4gKyAg
ICAgICAgICAgICAgIGFjdGl2ZV9oaWdoID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAiY2Qt
aW52ZXJ0ZWQiKTsNCj4+ICsgICAgICAgICAgICAgICBvZl9ncGlvX3F1aXJrX3BvbGFyaXR5KG5w
LCBhY3RpdmVfaGlnaCwgZmxhZ3MpOw0KPj4gKyAgICAgICB9DQo+PiArI2VuZGlmDQo+PiAgICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShncGlvcyk7IGkrKykgew0KPj4gICAgICAg
ICAgICAgICAgICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsIGdwaW9zW2ldLmNvbXBh
dGlibGUpICYmDQo+PiAgICAgICAgICAgICAgICAgICAgICAhc3RyY21wKHByb3BuYW1lLCBncGlv
c1tpXS5ncGlvX3Byb3BuYW1lKSkgew0KPiANCj4gVGhpcyBkdXBsaWNhdGVzIHRoZSBjb2RlIHJp
Z2h0IGJlbG93LiBDYW4ndCB5b3UganVzdCBhZGQgYW4gZW50cnkgdG8gdGhlDQo+IGV4aXN0aW5n
IGdwaW9zW10gYXJyYXk/DQoNClllcyEgSSBhdHRlbXB0ZWQgdG8gZG8gc28uIEJ1dCBhcyBleHBs
YWluZWQgYWJvdmUgaW4gdGhpcyBwYXJ0aWN1bGFyIA0KY2FzZSwgb2ZfZGV2aWNlX2lzX2NvbXBh
dGlibGUobnAtPnBhcmVudCwgLi4pIHNob3VsZCBiZSBjYWxsZWQuIEFkZGluZyBhIA0KY29uZGl0
aW9uIGNoZWNrIGhlcmUgbG9va2VkIGNsdW1zeS4NCg0KPiANCj4gSSB3b3VsZCBpbWFnaW5lOg0K
PiANCj4gICAgICBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4gICAgICAgICAgY29uc3QgY2hhciAq
Y29tcGF0aWJsZTsNCj4gICAgICAgICAgY29uc3QgY2hhciAqZ3Bpb19wcm9wbmFtZTsNCj4gICAg
ICAgICAgY29uc3QgY2hhciAqcG9sYXJpdHlfcHJvcG5hbWU7DQo+ICAgICAgfSBncGlvc1tdID0g
ew0KPiAjaWYgSVNfRU5BQkxFRChDT05GSUdfTU1DX0FUTUVMTUNJKQ0KPiAgICAgICAgICB7ICJh
dG1lbCxoc21jaSIsICJjZC1ncGlvcyIsICJjZC1pbnZlcnRlZCIgfSwNCj4gI2VuZGlmDQo+ICgu
Li4pDQo+IA0KDQpJIHRoaW5rIHdpdGggdGhlIGFib3ZlIGVudHJ5IEkgY2FuIGFsc28gYWRkIGEg
Y2hlY2sgbGlrZSAuLi4NCg0KaWYgKG5wLT5wYXJlbnQpIHsNCglpZiAob2ZfZGV2aWNlX2lzX2Nv
bXBhdGlibGUobnAtPnBhcmVudCwgImF0bWVsLGhzbWNpIikgJiYNCgkJIXN0cmNtcChwcm9wbmFt
ZSwgZ3Bpb3NbaV0uZ3Bpb19wcm9wbmFtZSkpDQoJCWFjdGl2ZV9oaWdoID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKCk7DQp9DQoNClBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KDQpU
aGFua3MsDQpCYWxhbWFuaWthbmRhbg0KDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
DQo=
