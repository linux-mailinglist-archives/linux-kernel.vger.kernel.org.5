Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E4776FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjHJF7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjHJF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:59:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC61704;
        Wed,  9 Aug 2023 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691647174; x=1723183174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RANxzTUbR+hi/esodfZGtlrS7qFhfIhQt/eslCwYdI8=;
  b=BONrOVUuK/PDJRJQJGccTSxkwuZP1aAiEBIYjm/ayogZNdysUuAmCjoK
   bx6bVkTyVhspJ3xdhVBCoSUM7jQ15H6Bjh2sOCgyXGPyCwjF5tmXxPSad
   BSSGCSbbLitGstM2hlCCv2x2W2H6cvAkUlX1JahXWJxBdZjcYncfY+vhL
   VHDkl6N0OKu4+0tFVDMjTMb6FHfQ3UN2ahLPQgaGqoz8SsyOquShaC3Pv
   3jzyEipecBtp90zes0qSWdJzXXatCoWp0JurcOKM0M7jkxaq8HI/Ir8BY
   h0JyNPwYiCwp8ejEcX4Io+NqzrEoZoE9ZfA1ObxGlZ/Y7xBgbGbop69Ml
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="224742941"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 22:59:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 22:59:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 9 Aug 2023 22:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq4PAL/toNkt5Q6ZiBmVntmKybB1Gt1eB9syqgoq84pmu3g8+roUiTLz+RmU0E5vsQzw0KSAnXwSJGl7rhRTBq+iMTdAU5oy7KQj5Pyq/lwzUiOJr/+x4yYGkKCMKl4tpbgQi10TE3ECRIVjIG2A7OWwqGRnBN7DAsUezaCTcVjjktH8j9yTu/V/j1FwRJ9rpB5cZD4shkFBogO+CCgODSFdYZZVYw4legKdxUxQAnT0VMCmWsm9rFT6TSALRO2ecezfvGtGimJRrbhafOt1tnYO9Uf0eDTIt/EUUKtI6BMNayVHqY93Cu6YIbI28Ms5HQXtl2pdiDFWJ36puMX54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RANxzTUbR+hi/esodfZGtlrS7qFhfIhQt/eslCwYdI8=;
 b=Uv0goMrcpPdI9F4MUXQZHKFzZFBtxBDz7CEiAZ39HLt/VsDu+mH8VydFpZcPAHtEKlu7LFepSJqKF6al+Sn34IJ3/f0S0+/+7PU+izgdclk90I16AoHCL+AtGR3aZ3TJzG8d85IOY3F1FFNwaAtUq6MiBUGiUhiNzyafe/ozyzr1wHMS5TuvaTln4JrXJ+d4dpocjWsa3+g0USRE/ZgYdqu8jL/a05g1NB/Q/nzQ09VH58pmu2A9Ip0phRx1EyZ0G1ceW5IbcG93k2otX04vC1wIStjmRq7zR6CKzTxVDiHaj8y9Gkp+43oImhdkXYRVD7LrBqMolrH0pdgj4601KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RANxzTUbR+hi/esodfZGtlrS7qFhfIhQt/eslCwYdI8=;
 b=C+iSj5Etpl2xJAYLA5v1ARztwqS9dnUtnNvW4MLKaG9O/GBedr+9xuyC5mkYwoOhKcZOB2Qa/aSelPUYC3yFuHg4HYclU4Xo1NZannc5Pu9ycf7OmkwiI4UjxDTlLA2ISFzvx8HaNPqLe8Gk2HwnwVZ+hyv8P1s6bNVKWaAUfQc=
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:59:25 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:59:25 +0000
From:   <Varshini.Rajendran@microchip.com>
To:     <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <Jerry.Ray@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <andrew@lunn.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 49/50] dt-bindings: arm: add sam9x75 curiosity board
Thread-Topic: [PATCH v3 49/50] dt-bindings: arm: add sam9x75 curiosity board
Thread-Index: AQHZwT7Jsa01MFADR0ygcyQ0EZIDK6/PkA8AgBONEwA=
Date:   Thu, 10 Aug 2023 05:59:25 +0000
Message-ID: <82521b46-11b9-e62d-7d29-1a68f9de6f89@microchip.com>
References: <20230728103106.267793-1-varshini.rajendran@microchip.com>
 <20230728192532.GA1169417-robh@kernel.org>
In-Reply-To: <20230728192532.GA1169417-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY8PR11MB7845:EE_
x-ms-office365-filtering-correlation-id: ae1ea9cc-b78c-4dd1-4007-08db9966f360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cScS/lQN9X8JRpu88HH7qgy7uaeZvnx12yQ12SEWKDlfa0LKZafiwCyl41ZZIFv7sqHL+mktm4rfsf8FjxL5Gf6NNapDo9f5Mb8At65/O7MquhI/VEJB67o01Xhdx3CEPREq/v65WjXhtDZJAlaHtox+QAV/XKgczBm93wFqK/MUZ7CJDhPYPmuASw6vPCCvKd81TcNb07YUatZ85xg6/aefuHR2eEM6Tw5v0PGc+Ve44kTtNrsRkJ1Sd5LxWZk0LN7YwN3ZZPF2lJ/hIJ6uARvyYpqHZnIoSgUOFp0rXyCcgEk0vV2CEkgxyJd4HpZipmFIQQKflvbMq/wOBOsxpfn8q50wpEnbaEo8m4h4iUwzuvioW08SOeXTxj3j8XPDFy1ZcYb1+0WfT2EDz4x/AHhlNdHLLDNp9IYHURWUIGgXQ0Eg8ran44ADDSIbZkT+Goe6WTAkTaTmhTIVdCtrp8h8+Qv9F6pOTaU6j1vWFtUbfGJ2vIRnLPDvySKBBbfz/1AfRi48Gn0zFHXD+VJi1rYe5FsTVdO14+PzyVnn6AchpfvgjfKy4MkuwvOP7IYswTyiFe6KRAG1/VTwaG0qAzoqBtunWIerz6+qqoaZmlR9uXuf4U2VJWxlDLn8cVWYaC0VhPoBf1UD+QILfUJQpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(186006)(1800799006)(2906002)(38100700002)(54906003)(478600001)(122000001)(86362001)(2616005)(31696002)(5660300002)(71200400001)(38070700005)(6506007)(316002)(36756003)(6512007)(6486002)(26005)(8676002)(8936002)(41300700001)(31686004)(76116006)(66556008)(64756008)(66476007)(66446008)(66946007)(91956017)(4326008)(6916009)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9OaGFkalFYeFFnaGR4ZzE1RmswZzVjcWhJZUJWWWF6d0xnWnJPTmRWWFBF?=
 =?utf-8?B?Ynl1Y252djJQTE1XNERTVVBTbEZ1eGNWaDljOUtJcWNrbHNaWHM0UUxnTFo4?=
 =?utf-8?B?djlIaVRyTW44aDY5WGMvcmJVbVladDluaE00dTlLQi9tZ05QTDlnc2NpMmhh?=
 =?utf-8?B?d2ZuVDkxOWhYRXF3azZ1am9LWm1RWU95YllRQXh0T1pXclM2b1JEcVVuWkJt?=
 =?utf-8?B?b05TWXlicEl4djY2WkhQbGhnR2xudlZFZnVkbk00SVp6TEhNQmtYRDZFLzdW?=
 =?utf-8?B?UFNSQ2o5cTJRMEc4TVkySUVzSlcySXVzWGZPWk9sbDZJb2w0L1lNc0Q1aHFZ?=
 =?utf-8?B?VTFxdU1HUkRVWDZmU1hhQ1QvcExWbHZCVDMwV256STFMQTdJUGExcUxXdGtW?=
 =?utf-8?B?VG4zK2JaSDZFWFFVbkRuOGlNK0ZvaWx2Y1ZFY0p5RGJXU09tRWxocVpyMGta?=
 =?utf-8?B?cHo0WSt2L3dEQ0FiM3RqWlRwMCtHQytyRnNMUjl6eWREQmFRYjZqTisrSWky?=
 =?utf-8?B?NGVqNFVXdFBIcmRtMkExV3FrV28rWVJRYnZQUHVyR0trNWRCNTF5ejFibTZu?=
 =?utf-8?B?WWhVeXN6emlvU0E3R3JTaFhUODB6ZDFpT2czd3VvaWhpMm5wMXMvVXVSeUZI?=
 =?utf-8?B?cktjZk05eGJCeU00S3M0VUkxY3V6S3NPQUhGRm5jMXJpSHJXVWZ3ZnV6QWZE?=
 =?utf-8?B?VjRGdlpRQXIrOWRZMTU5c3BaRjhOOUNrdVc2SjNRT0pDWVZyTmhnNHYwL1BC?=
 =?utf-8?B?c1BhaGIyVVB0RWJlMVRmQkZUbER3NVlGeWRRVTZCeTZuRWhXbVZuVXJEZmk3?=
 =?utf-8?B?U2dwYmxMS0FtZTg4S1ZJUGFldTYrbGJ1OW8zd3BZME1rUzNpZEZRN3RHTm5D?=
 =?utf-8?B?ZzN3cmV2U1VQeHFsMnRGUGFodjhOa0RDbFVtdXpkSDhYNnBveTNaeEtPeW85?=
 =?utf-8?B?QXdSbng0QW1IWkxwRzQyQzZoTTJHamVRWGx3eHFScllWWWNlOFBneUR3NXRF?=
 =?utf-8?B?V3hKcmNJcW5TekE5bHZncnkyNlJKTWErajhaUVZhdmlMU1VRQXpsSWk4bEMw?=
 =?utf-8?B?L3FURGp2MG42M0pWbkVLVUpMR2hrRS94N2tILzNpQXRZQ2hETVk3ZWp4VGRF?=
 =?utf-8?B?ZmNlNWh4eWtPei96VUJhTlZiQjZldTNLOU8zQUNwU3JscmhxSzRKU0JhMmFH?=
 =?utf-8?B?UzAyOHBpaTRSSUR3ZnlzVFQ5REdvaWNjOEtRQkhGQk5BY0REYkR0M3FNT245?=
 =?utf-8?B?M0ZTbkJha2IxdlVhSkRFRkdJdk1Bd1RWQU14NXdaS2ZEQi9tQytwWE9UQ3B3?=
 =?utf-8?B?ZVJRVFN4SU0wVDB0eHBERHpIOEk3bVBXbVNkN01Ea0hrcTRDSlhRdTFVcTd2?=
 =?utf-8?B?MExhbGFDRzNmTWtxZHdXcWgvTGdSdWVZaENHdjdmaTBLVEFOWkppU1BZd094?=
 =?utf-8?B?eCt0Z3lmZkdITmpYZDN3Y2JkdnpIUmlyQ1hONHFnZjk2SkhWUnRCcUR5UHc0?=
 =?utf-8?B?RWI2TG5wRUsxazEzUmpiTGZ3M21zUDNkcm5EYmFnVDkzOW1RTFpyKytxTUt4?=
 =?utf-8?B?VDdNT09JMlJEMzE4cXdNdjZ1UHNsUk1KZVR4ZWtYWnBYWXFzSHl5MUZCSGJi?=
 =?utf-8?B?NHVyY1BUQ2NtRFY4L01DcDFlNmpmN2hjSUVuT2pCZHFKWG9ScVJydWVkSjdI?=
 =?utf-8?B?RTJ4cDBkMkc5cGdmbjMxNktaQ1IxWlhSVjJJTDlOVVI5SVRZRnFYbDI1cjcr?=
 =?utf-8?B?YjdISVRFQVhjTTR1aTQrQ2VnbG9aQXoxVnVsR0dIS21xRi9JcWdJNHBGZE5n?=
 =?utf-8?B?VVVHWXo4TFFWdzVXb0tEUDd1WVVpSDJXMVd4S0diZVpkRGV4Q0ZGMVZPanZX?=
 =?utf-8?B?czZPMDR1VzloV3phZVE5VUQrM2h1cSt6RU1DVUt1VTRYcjdPRG9WZTg5VVMr?=
 =?utf-8?B?T1JKN2Vxc2xDcDdxZ2ZxS2JnODQ0MXlDY2Z6M2hiSCswUHovenV6SGNCR0xw?=
 =?utf-8?B?aHlya2VIcVNaeEdJVVJrWjdVWVFCdmpIOUN4RkphQmw2SzgzdXdWWGcwbnhl?=
 =?utf-8?B?bHRtWjBHd2piWC9OQ1ZvL3RQYVR3bTlMa3pUVWQva01SU1ZEalNYV3RucGs2?=
 =?utf-8?B?SEk0VnNwN2tLSE9Ib0tOK240RzZySkwwWmhTdUJtTkcvV2V2RUZ4OERSdG96?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD54CF8CC141A84DAB1756CDF42CA770@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ea9cc-b78c-4dd1-4007-08db9966f360
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 05:59:25.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6mGMDn6cAwZBP4K74SX9ow53qgPJ/LrYHxTInJAGJvvsLQ/51c3mm0HqFCPBSqC3leCSl1ljYuEl2mwiEHdVU1y1ytGQdaClQZY2Wev+B8sCE1G3Novssb70JltUWLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDcvMjMgMTI6NTUgYW0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDA0OjAx
OjA2UE0gKzA1MzAsIFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4+IEFkZCBkb2N1bWVudGF0
aW9uIGZvciBTQU05WDc1IEN1cmlvc2l0eSBib2FyZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBW
YXJzaGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5
MS55YW1sIHwgNiArKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2F0bWVsLWF0OTEueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
YXRtZWwtYXQ5MS55YW1sDQo+PiBpbmRleCBkZmI4ZmQwODkxOTcuLjE1YjExZmVhZTQ2YSAxMDA2
NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwt
YXQ5MS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2F0bWVsLWF0OTEueWFtbA0KPj4gQEAgLTk5LDYgKzk5LDEyIEBAIHByb3BlcnRpZXM6DQo+PiAg
ICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MA0KPj4gICAgICAgICAgICAgLSBj
b25zdDogYXRtZWwsYXQ5MXNhbTkNCj4+DQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogTWljcm9j
aGlwIFNBTTlYNyBFdmFsdWF0aW9uIEJvYXJkcw0KPj4gKyAgICAgICAgaXRlbXM6DQo+PiArICAg
ICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDc1LWN1cmlvc2l0eQ0KPj4gKyAgICAgICAg
ICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg3DQo+PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVs
LGF0OTFzYW05DQo+IA0KPiBIYXMgdGhpcyBjb21wYXRpYmxlIGJlZW4gdXNlZnVsIGluIHByaW9y
IHVzZT8gQ2FuIHMvdyBtYWtlIHNvbWUgZGVjaXNpb24NCj4gYmFzZWQgb24gaXQ/IElmIG5vdCwg
SSdkIGRyb3AgaXQuDQoNCkhpIFJvYiwNCg0KVGhlcmUgaXMgbm8gcy93IGRlY2lzaW9uIGRlcGVu
ZGluZyBvbiB0aGlzIGNvbXBhdGlibGUgcGVyIHNlLiBCdXQgdGhpcyANCmlzIGhvdyB3ZSBoYXZl
IG1haW50YWluZWQgZGlmZmVyZW50IGJvYXJkcyBmcm9tIHRoZSBzYW1lIFNvQyBvciBTb0MgDQpm
YW1pbHkgc28gZmFyLiBTbyBJIHdvdWxkIHNheSwgYW55IGRlY2lzaW9uIG9uIHRoaXMgd291bGQg
cmVxdWlyZSANCmRpc2N1c3Npb24gaW50ZXJuYWxseS4NCg0KPiANCj4gUm9iDQoNCi0tIA0KVGhh
bmtzIGFuZCBSZWdhcmRzLA0KVmFyc2hpbmkgUmFqZW5kcmFuLg0KDQo=
