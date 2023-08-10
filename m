Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D2776FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjHJFia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHJFiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:38:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447C268D;
        Wed,  9 Aug 2023 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691645903; x=1723181903;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iN8+vytgyzZmpsJD4RdTYxIw8SLbD/J1TPVjbMmISJI=;
  b=nvPf6CaH17TkehgEPF/cI/LdSAAyP9lfINdkojsz+RHSIgkkCuZjbuzQ
   LZm5q4ioHTXeMvAF9n8WEnjz8An75Okk1w2dGigSQ7VjPM1LSfJGzRGlC
   UYC2RHfnCTE67C4VRDaLKYrdhXbFeZTkpVSRz0dAg0xOBhS4Sb6dYqgKG
   NSHEkRCQapWHFBz94oK2RtGNDZWPMWLAXEzfO9wNywmD5aRI0E9SNC+A7
   NkcJnROj2f2tOFuKY9fgQTQVq2kOtjtzonZbJ4oX6kMs7AZK0p+lLep0q
   869ju4hAYkUSwy4mr1KqDwQtHag/mK2DRBDtb0aLo0jLzrkS1OHLYErhM
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="229110775"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 22:38:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 22:38:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 9 Aug 2023 22:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3VYpBrGfasMBTgEbNDcmRhuAJE6CJu0rMVNz6ELlwqOhN1bI9iUjrHM0X683G9zVGQ/1eGx2xdJlfhbsrlk4GFEvECs3cUg77ik0kBNX09wbGq6ehlY9pqiVX1jZiHnOYmZpvvf8FjgnQLfLcndpXoTA/3aicguMffRYwI6EDzmoGk1S4g4u4jnUqtHAioiIRpNRp+bZI9e6GvLujIhS8jKm+zLMy/tY49yZ9A9VMnCDMcEtTnICMADIjOuhCVSVSx7vd101wA3jR9GrHobO2hLWFyOmmp9IbqIVViLqC1bFMG+nU6e+WXsk3AnQ3lJvufLFiqqeO7K+PKabt9aWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN8+vytgyzZmpsJD4RdTYxIw8SLbD/J1TPVjbMmISJI=;
 b=LDgaNlQObVQK4b9JnL/PGxKAs9froTUSai8LHqB+siNxI0WTFhWA59ijfFZtOXsbeipKqeWU8fWBJstn2v5sdb9hvl7sFsfpvDP5RpxduX/570HCnb8k/opXY5tsIrRVe60J2pRK+Inp44GBl2roNfZ0EK1sN7RYloYK7IPeVVTmG/unbiofYejgSeEcLtT9KWmtZDiOXL8OfoAr+M2ZMcZaK+VIQWfIntkmjtUD4kbMLhMXOwo9HZVBxvpFhAHYFK1k8AdEaD4Ffstg5o1bfiHroId3MjUTfQYbC0NiMoKO9pTWJ9Plz5k3mIhKyvzd1jHC0SPg5VW78gmh/wNwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN8+vytgyzZmpsJD4RdTYxIw8SLbD/J1TPVjbMmISJI=;
 b=BA7kqtMZPyRYKnJ9vPOhJx3PO1pgDmd33gAvfytxWg/hIO/SLO3yxbn3BY6ok6zzdn9kJjpvXp/zPdsvHiMb4LqCJ5hrPpnGGhIgsrWJI8ZbQLTkxsCOkVayFG9Wikb+J1zDk/09lfRYSnx+FUWIxVSvklEzDdE8e2Y3G28jgHU=
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:38:13 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:38:12 +0000
From:   <Varshini.Rajendran@microchip.com>
To:     <tudor.ambarus@linaro.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Thread-Topic: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Thread-Index: AQHZwT3NAMazmCxJ00CYrYZEYMY/z6/PB6gAgBQPkAA=
Date:   Thu, 10 Aug 2023 05:38:12 +0000
Message-ID: <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
In-Reply-To: <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|BL3PR11MB6436:EE_
x-ms-office365-filtering-correlation-id: bd8ab656-5210-47e0-8275-08db9963fce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfhmnT7rt91xh1IVgma16GUu907kpKFqq0tXfR0UKcpzi2P8GOmKRWeP2hkSnSmN48XNb8YK0lKk1z5AtKCsU38Oh6l+JmEhwXLLVhYOhdKkF7rpGDJ+b5O+ewy1aZwXL3xMEECE9PuE2F4PZb7SIUFsBoOpruqbHRZZvwM8THvpNaQ1SP2BULm/9xjD8No47ae/gT1yoMHLqUm8EUUtiImeakIayiAilWeCwhQTvWS6Q2dqfhNIgPE6VZjKVOmb40vc6aCiP+clzm7shIvsPs36NosligYL/7pU8Ab1rqay+7yZJz64/ul52U6ZFav7iYOGUWugBKun9Ac4t3J/OSuFTv4UM7jn2cEJ14FmE++TIoVVY8GRBV7krnBJHDH0DL1vsHj9V+uw+7n1s8qfOJq5yxhyUcrCQFam/vWpLIGBngwt4wgzd8o5dDtXlJpDHndc4xt63kOU3+IsEdXjmk6lzT1S1KJNN/FV9U8SNu334HmRDXpajXYqkDx4LtSW7XQqIsxcB8fPg6IUfRoEqQ6iqSQl8rv7f0aJ+fzb5spinJqn2LJPJx9q40rta3IJ8WFCHXf1JXoEz84tf54JTogCIoW88RzPanvC0CVU+WkAMLxNqfdyLFdtmbBE5U3+LSgeve4x68GtsJNB8v+1/JReU1InJuwNC6eoYuSNMWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(110136005)(478600001)(6506007)(53546011)(2616005)(6486002)(6512007)(966005)(91956017)(83380400001)(36756003)(26005)(71200400001)(31686004)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(5660300002)(8676002)(8936002)(7416002)(2906002)(31696002)(86362001)(41300700001)(122000001)(38100700002)(921005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNHV3dJVkFza08xNDZka2FhWU1ibFFTY2ZwRUhTUDJsMyswMlJDNG8vVFgy?=
 =?utf-8?B?OU8xYkVGSkZ0YWVYTWhnU0NFWlBwMENtOFdaRzdaZy9HOXZEL0FaOTBvbklj?=
 =?utf-8?B?WjBHMVl0dlRDSG1XWVU2cmUzVnBSdHQwR0Y3MUdGRmpJZnp5UEtibmF1S0pS?=
 =?utf-8?B?TVR3cW5DQUt5TXRrQVJrUjJsYUlQQytNcVlvOTFyNXNvSW1KV1NYTTZ2aU1w?=
 =?utf-8?B?ZWFMQ0w4WmtWdHUyZzBQTVRSYTUyc01UNkpDeFFCVThDMzBSWEJyZ2JIMlBW?=
 =?utf-8?B?TGdscGE4S3NZaWNCTFNmdkdveDlMVURhK3JxWG05RHZOWmVjRGtsckVwL3ZD?=
 =?utf-8?B?VUZCQUduc0huZlB5MHdXSWg0bjArT25pRnhlVDFXK1VQd1RacTNsWFFpMVQw?=
 =?utf-8?B?Z2NiZWV6R0I4YUhUVHdNQmVCbEVqU0J2R1djaFJKdTRsMUttYjd1bkFjUTUw?=
 =?utf-8?B?elB3Y0FDUzR4NjZKeExZR1J1SlBYcmpoR1o1Tkcydm8xZ00rZHE3eFdEMkxv?=
 =?utf-8?B?Y21VRGRkaFprL292QU5xR2lUbTN6cjFqbzVEWFI1SExqYmprQ0lwc3VWT1p5?=
 =?utf-8?B?by81WVJES3VDandUa0kvR1Yxd3VRaThGeW5NM2NwVFdHcG1YUmk5YUNZTGxC?=
 =?utf-8?B?bmYzOFlJVDBjVTE5UzZNNkgySU1TU1lHNHJnYWVsci9vZDR5ZUF5UVVva2V3?=
 =?utf-8?B?ajh1cWxCTno2aTNub2V3OXJsK2RicG8veS9nTHN2cDVvT1RIVVlqSGhyMVNM?=
 =?utf-8?B?M0Q4RVpiNGNFMlYzSkdXbmRXWjFJbFBsQW51L09IbDRJVlR4ajNzb0tRRTQy?=
 =?utf-8?B?UWFmM3hZQUc2czc1MWVqQ0VXVkRNek1QcU5hL1d2cU85a0JzcnBMM002M21X?=
 =?utf-8?B?cE13dDlTRjNsU3M5SSs2MjBRRHc1NnJYZzFWZ3cvZmN2cFluY3pBRjNWNHVC?=
 =?utf-8?B?Z20zU2hMNzc0a1JYQkV4bHNGaVhxTHRoS1diNmx3WWl1MjBuWVpteDJHQXF1?=
 =?utf-8?B?WHF5SXU2UVRlOWxzS3JGUXR1V3NJd3I5UVFDbXE0UWtZNE5WcXpOMDgycGRK?=
 =?utf-8?B?SGZady9Idk1HbXlkVitmS2c5c0REYWtnRWhPNzNsUFArcHFxWUVEL1lGYzJ6?=
 =?utf-8?B?WnN1YUdWamR0QytoK2NhZEdlaDMyNkVpdytsWVlzQUxMYnh0T0dNUkFzRHpV?=
 =?utf-8?B?bnlBNSsrei9ySVVuWHh1bytqQzRGMm1RNktGQ1U4ZjN5UHBDekF4WnlaRmZN?=
 =?utf-8?B?dVk0R3FkK1NEcE9raHhHWU9jNmcyemVxWHRQQk9MQnZkTlpFdnZic2xNSnNQ?=
 =?utf-8?B?TmxYdE02UG9CdVVjcXl1Nk5BT2t6OXdrRXBVTDJmbThaZUg4NWJ5NHZ6V3BP?=
 =?utf-8?B?SHdGU2lMNDNwdkUyNktRbVFrZXp0SzZTOWJzUzhrN2o5Nk9ydEFwbm9nYWxo?=
 =?utf-8?B?U1lvRDlodEpjSnhtMXdHTW9kZUVKTlBtdUtwbUV6NHYxMkwyT2JqTFpERHU3?=
 =?utf-8?B?Y3BTeFZEellabkpQak9zc051Z040T2JTSk90bG1wZVVJUWF5YlRiRkZGQ1lm?=
 =?utf-8?B?M0pBVjJVZC9ZOE0rY1dVZU0ydG5lVzdXUTJIbk5oZEZ6MGkyWDViTXhOWlNq?=
 =?utf-8?B?a0hRMlQxdTlvRmx6RFhpQk4vMlJTNHVPNEh1UzJKTVBYOTZqSG5ldnBDajlD?=
 =?utf-8?B?d0RvQ1NXNVdPenp2aGpnTW5GVVF4L1dObDM0VGhBOGlmRVZHU0ROTUdlUDRD?=
 =?utf-8?B?M3hGZEZVYlBzS1NWSis1THduTDgzZk5mUThQUlVVdHZZYVk4Smg0TExWTHBZ?=
 =?utf-8?B?cW1lOXVaWG1ONklxVWlkeWQ2Y3FHR1diR0QydUpYeDNhV2tWK3lmK25BemZZ?=
 =?utf-8?B?M05zMlhNdU5WTU5tMDM3VUkrcGRRSkZqclZsMDEwcm16K1dmKy9lZ0plM1F6?=
 =?utf-8?B?R2daQVRoa3ZETkpRdkhTVFh3RTBvUklTRTh5a0dzWkg0TGJ2WDd4VGxqWk1z?=
 =?utf-8?B?ZlBrWUorUG9TR3R6a1dlbm9LWlM3WGxIWXFEclkrQU4rM2dRaFJBV0FITjFR?=
 =?utf-8?B?dTU5b2svcnMrVVdCbGxwZGVZZEovRlV4eWhyQVovdmhXVWgzcVg1Yk5zN3Ni?=
 =?utf-8?B?KzhDR1pPYXdBNWs3VTgwN0lBc0VpdHZBWGJmcmhrYTZFS0IvdTFXVGpLeVhp?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C344C140F6FD41AB3FFEB8597C204E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8ab656-5210-47e0-8275-08db9963fce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 05:38:12.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRYeOpVf6YIOxhlp3r1i16kn8+0aACGDDcidA+RC42j/wrqKjAeCvtYhdYODR7FBZGZoSecbfIxl/7tVmpv+5/9IiM1PRixegV9r0TNKbp6TvKu0El4HKRM0kxq5Lpwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMDcvMjMgNDo0NyBwbSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDcvMjgvMjMgMTE6MjQs
IFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4+IEFkZCBEVCBiaW5kaW5ncyBmb3IgYXRtZWwg
VERFUy4NCj4gDQo+IE5BQ0suIFRoZSBhdG1lbCBjcnlwdG8gZHJpdmVycyBjaGVjayB0aGUgdmVy
c2lvbiBhdCBydW50aW1lIGFuZA0KPiBmaWxsIGEgY2FwYWJpbGl0aWVzIHN0cnVjdHVyZSBiYXNl
ZCBvbiB0aGUgdmVyc2lvbiBpZGVudGlmaWVkLg0KPiBUaGVyZSdzIGEgc2luZ2xlIGNvbXBhdGli
bGUgcmVnYXJkbGVzcyBvZiB0aGUgdmVyc2lvbiBvZiB0aGUgSVANCj4gdXNlZCB1bnRpbCBub3cs
IHdoeSBkbyB5b3Ugd2FudCB0byBjaGFuZ2UgaXQ/DQo+IA0KSGkgVHVkb3IsDQoNCkkgYW0gYXdh
cmUgdGhhdCB0aGVyZSBpcyBubyBjaGFuZ2UgaW4gdGhlIGNyeXB0byBJUCB1c2VkLiBUaGlzIHBh
dGNoIGlzIA0KdG8gYWRkIGEgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgYXMgZXhwZWN0ZWQgYnkg
d3JpdGluZy1iaW5kaW5ncyANCmd1aWRlbGluZS4gTWF5YmUgYSBiaXQgbW9yZSBleHBsYW5hdGlv
biBpbiB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIG1pZ2h0IA0KZG8gdGhlIHRyaWNrLg0KDQo+IFBs
ZWFzZSBkZXNjcmliZSB3aGF0IG1vdGl2YXRlZCB5b3UgdG8gd3JpdGUgdGhpcyBwYXRjaC4gU29t
ZSBwZW9wbGUNCj4gY2FuJ3QgdGFrZSBzZXJpb3VzbHkgYSBwYXRjaCBpZiBpdCBtaXNzZXMgYSBw
cm9wZXIgZGVzY3JpcHRpb24gYW5kDQo+IHRoZXkganVzdCBpZ25vcmUgaXQuIE1heWJlIGl0IGlz
IHdvcnRoIHJlLXJlYWRpbmc6DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0
ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjZGVzY3JpYmUteW91ci1jaGFuZ2Vz
DQo+IA0KPiBDaGVlcnMsDQo+IHRhDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmFyc2hpbmkgUmFq
ZW5kcmFuIDx2YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsYXQ5MXNhbTlnNDYtdGRlcy55YW1s
ICB8IDYgKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2NyeXB0by9hdG1lbCxhdDkxc2FtOWc0Ni10ZGVzLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2LXRkZXMueWFtbA0K
Pj4gaW5kZXggM2Q2ZWQyNGIxYjAwLi42YTQ0MWY3OWVmZWEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2LXRk
ZXMueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0
by9hdG1lbCxhdDkxc2FtOWc0Ni10ZGVzLnlhbWwNCj4+IEBAIC0xMiw3ICsxMiwxMSBAQCBtYWlu
dGFpbmVyczoNCj4+DQo+PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgY29tcGF0aWJsZToNCj4+IC0g
ICAgY29uc3Q6IGF0bWVsLGF0OTFzYW05ZzQ2LXRkZXMNCj4+ICsgICAgb25lT2Y6DQo+PiArICAg
ICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTlnNDYtdGRlcw0KPj4gKyAgICAgIC0gaXRlbXM6DQo+
PiArICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDctdGRlcw0KPj4gKyAgICAgICAg
ICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOWc0Ni10ZGVzDQo+Pg0KPj4gICAgIHJlZzoNCj4+ICAg
ICAgIG1heEl0ZW1zOiAxDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KVmFyc2hpbmkgUmFq
ZW5kcmFuLg0KDQo=
