Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB41B776F99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjHJFbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHJFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:31:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13928211E;
        Wed,  9 Aug 2023 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691645511; x=1723181511;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4eq5KrTUnsdAdsWXXoo0v1VSgzUIFcfjjXQ9rzFfo/Y=;
  b=r5b5F5jLBzzbg82+91dKdvz+/FczJWzlyIW6gjUsqe3vtS9pEtvFkn2Q
   sXFDNjgp6h9LlAGqqODSjfX7LzH1PXubM/rVsNVuIVU7HAXI5ww2+GAkN
   njdZc9aDRiq/1+wqR+BReEdbWg04E0n5bQ60lBI7hFrmbjMeQ+JJA8PgL
   L1h2A/POrRKyewW8OMLZc+jS+ZsuInPPBLl9qcaqpHpCYqKIDKM7Yp97V
   qXq6i82d0BRQEsU4RU053DdEWjXre6D5n33Ib6MIMH+UGm83i/3tHEMZs
   zNaRFE096H5BGVoXwDKTlvOjh8hWiND/pNdBeJiDVcs89Z5vITNSEhaFp
   g==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="240835852"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 22:31:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 22:31:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 9 Aug 2023 22:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRkvNwVZJrikw8XJpi9C90jRXCfol/31KDS+597i1BOa/9g8fQZIYJf0VHxpTcKZhxwXBnhIxa52mHr70mT8//3Ngo/w28o13ygv2oGGHEYDGHSbSFQXSBJ3QYNyc4VIaeL3zWWo9xQrVGXH9YNJ+xvgRM3lYEr2EMKKPtbdAkIyPiHOk2f1ZESEW2QBrt6YVFMcQsx/lRR/MNTBjEFPwxgJiWOSJ7PZK/4g6i4ipqpBmpgCTytw1exLc0WkSr/zaSbhdBLfAaQrQSiiJHFlr4LQ2Gt2gyBkSMvYgm2/9cMT2/zMHYWhEDpDqe4PtyV01q+fFCl0FFYh8bqiNSpMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eq5KrTUnsdAdsWXXoo0v1VSgzUIFcfjjXQ9rzFfo/Y=;
 b=ZXA+HmwO5pHbai88HYRBihDeqtyPCCQ55+A64siMJN2XaYlp7pM0+bbEXXuTe00b7tMonxEI4wHnBGuEpy6GBa/RsT338kFIcBILiNhnk3T1j1Tk0GQ6jexPtuJen6AWU3Lgtj8Y32+SSak/LHsMR8KhfDGHk/b8Sp89VRhha+tJrEIkoyi47DGlc8trcEyQ2ddJsi59jYRi4SOobwV73vWTAAanBTu6glSj96LWVmuq2z6CTkbii1FofoQtCof47UuGNCkxsQczPs/ZNzQpiNViGF+jcj2IJB8NXmq1REmJ+/kFkgLuSSXBAdv4iBygl5tFVBzY39M+4OOnJRr6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eq5KrTUnsdAdsWXXoo0v1VSgzUIFcfjjXQ9rzFfo/Y=;
 b=b29dhUpazGz8BizOwzQnhcDVFg3YUtElrIKR6jeJGN6E0QzGVftfaJ6ULFDnDT4od5Qo9l19Jps/GHFnn4ia6Hu6a0LD/DX39642G3MfEgNRMnA/BgbRBiZi9HP+1sFA11ceXHGJmg6fh3NRMom5kVjSyBFqrBVZ5fTd2etUV9Q=
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:31:49 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::d60b:acac:9481:18e%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:31:49 +0000
From:   <Varshini.Rajendran@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Thread-Topic: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Thread-Index: AQHZwT2jCSX0WfI8jEav2hRLgd0xLK/PDigAgBQHSIA=
Date:   Thu, 10 Aug 2023 05:31:49 +0000
Message-ID: <f97b2698-f482-622b-5f9d-02c3113db546@microchip.com>
References: <20230728102350.265520-1-varshini.rajendran@microchip.com>
 <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
In-Reply-To: <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: 0c265d66-8d5b-4e0b-35bc-08db99631868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8ovd53GtHyCAqzaWGC0zm+eZzTAJ0W8nulw5EUyDu6ljFhqlDrAh54t7/6rWl0nXEIIOTIwPCg5FamHBjfYPF10pG7X6vuZiMJabve3MZOxb3MHOD2Ibp/4F4u3it5MNkgQH10VLra/FQIW77kwkOpxwI2W9+XGACqadx6UUIbBwwIjssPyzXJnoU7RHHHP8XmjJqIUxpciP+YJKMoPEreK0Qsc0Pb9Mou3LafaR9AOvraZS4bjruaqOWbNhhZL9Qlt3OcbaY78tUsXkwchBZp72scptnFRwqND6xTJTH6Qzkeqqe+A3gmWqR4rEpqkZduq82w0jgecxQNmCXMnFXzNj3E7oekS8GR0sSIxt7CmWlQk9pxdfZWaG4/lo1O23Xpx2gx0GHpbcEWQReUbm7hna4TBjC3GCZ96EVTmAzky/fnhNIo9k+eyBcwa+KiCOB2WZK2DBkREf38cx3J4Kq57rpkaAN/X7pbuSbx8tRstyYJsGuN8BnihI3YqRogzbw/HR1ND5IuGrwq6Nt+iNmyAvZUhFbUAvsrKW8MbvVIMHiG3FTN4KisrsY/5OxhtO/iGRwUN3Jh9rJUfArEVgory1zfCEf5PXgrxef1dR980WRpNNWduh5ZcyxVrFzT9y7olrxczPSggLvEM4bA/Q0SgqnFlgkRjBcUP2J3aQAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(1800799006)(186006)(36756003)(53546011)(2906002)(478600001)(26005)(6506007)(6512007)(71200400001)(6486002)(31696002)(86362001)(8936002)(8676002)(316002)(7416002)(64756008)(66476007)(66946007)(66446008)(66556008)(5660300002)(76116006)(91956017)(41300700001)(38070700005)(122000001)(38100700002)(921005)(31686004)(2616005)(110136005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXYxVDkzeTNiTUdYeE1CMjN1YkU3YW51eGF1M1IrajAyNVFUdUFwbmJ4QnJQ?=
 =?utf-8?B?OTc4Q2l1Rm1yQlUxRUlYd3pqVlI3QXVubUpudXNJTXdoajVRS3VDalc5RmRQ?=
 =?utf-8?B?QWRFaTBacjlVQmlDOGtYT3NnSG8ra3c3aHk5NW5tSFBaMXhRQ3oyWmtyNG9R?=
 =?utf-8?B?ZmZ5cTFhR1ZETXVSZlcybjhUSkdqM0hSSVlxajRudjJNTkFyc3d0cGRJNm9L?=
 =?utf-8?B?blhkNUJHVUdCakJPRDl2RENuQ01SelhERnZrdzdFeXJ0V0pIZkxmTHM0MElq?=
 =?utf-8?B?cDBjSWFHZ0wvV2RxWTdiUkg5WFA4MWlNbXd4MzVNTUwreEJpREoyMnN5TFdy?=
 =?utf-8?B?Y2NMNUxrbU5YYm9Yd1NpV25OSzVYTFI4cGRVSTRMYXdmWVJlQ04rbFdKazRY?=
 =?utf-8?B?aERnQVNzck9DMnp2RTdTbUxKMW55bWxlaFphYUhjMWZyMHlHSGcrcGtEWWdp?=
 =?utf-8?B?VUMxV0dBeC9FVW1mZWpWeS9qcHZFUDNRelE3RFJXWThGQkxUbWU2cTNHMXhS?=
 =?utf-8?B?eHd0d2FEUEEydS8zcE1tTkhFWkh6OFMrKzMwdkVHeGVxWTR3TCtURXo2azZH?=
 =?utf-8?B?SXhnU3B6aW5Jd3lDbURBNmo0dmh0cWw5c2llemxNdW5XSTFoL25ZTzdqdTVt?=
 =?utf-8?B?cVVPVDJCYzBua0VUTkpZRnpxYjNvcWZzVVRReFk1VDJaZzEyT3U3OXNIbERU?=
 =?utf-8?B?RjR6UFp5MDMxYWRKL2g4ZEkzclF3Q0dGdmdyRUQzcDFnd1Nab2FLcGtTb1h0?=
 =?utf-8?B?TjNnOHlsNlc4QXgrSExKSERUM2ZiL2tSQ1ZBcGxmeXBKUloyWDVaMk1DRnZY?=
 =?utf-8?B?NTBMV1FOMWYxb3JpVE1LVnppYWZrZlI5UlNkb3ZpWmpZakFKcHROV0Y5WUxa?=
 =?utf-8?B?YkRuUlNXZHZyVnZTNzJ5bVFuRVIweVFVdUc1TklmOE9VckIzUHhRYi9Ma1RL?=
 =?utf-8?B?SzRFOFZEcTVCZE0yVzVsdnVEc05UTDBKMUpnMThBS1hEdkRINHo4MjFTRTRN?=
 =?utf-8?B?b1h4ZE93SXhFWVpnRVgvMGdnM3ZxOHRCTUhDNDREazlrc0RJYXZlclFKeWhp?=
 =?utf-8?B?N3JXRTVLOTllRWt1UjR6N0lMaWxhNU1wRHRITUVIYmhtaHB1My9MUXFLKzha?=
 =?utf-8?B?NFB5RkNEUHNGdFNyWjMzL2FRVXBLRG4ydmhXNVQ5aTBRdmNUa1JML0dUVUNS?=
 =?utf-8?B?azF3SE56ZEMyNmRHdGtoaVVNWWxUMVE3TUxmNU8rZnVJVTVQOUFTZWF6czY2?=
 =?utf-8?B?OEV2bDA4ZGtkQ3Q5N0ZLNmZZZktwRGVpYlYweGVxZDFOUTR4UkxDT1pBQ2Ur?=
 =?utf-8?B?bS9nNGJXNUdoMWlMcVN5NzU0UENkWlM4azF0R1JDZXJzZm1IWXF5YVgvTkZn?=
 =?utf-8?B?Y1ZkeUR5NzdzSFZ2WU16VG84MTZjd29jQ21XZmtpbDk0bm1pVDBtRW9raUJh?=
 =?utf-8?B?RGVTSGVQbnpQMXZ0M2N6cklpN29iRnFKVURoSW91a2lrbUFIQXA0dExyQ2dP?=
 =?utf-8?B?bHJsYnBKRFRHZTBxMFcwdDFabjhrakZqRUppU0x5T1ZYZUhYUWhSVzJFMXBK?=
 =?utf-8?B?cVRsYWMvMkFRRHBYWHpNN3kyNSs3VkQ1a1J4RlJoUFowYXVnS1NFYzNBc0hr?=
 =?utf-8?B?WTh2SkhoUzFLUVA5UXB4djViV3VzWURuRk1zM1YvMHVNZTVIajRPNFU4b1Vq?=
 =?utf-8?B?L1RzL01TWnF6bEdVT1VoaXVDcjJpQk53UGYra2YxdnBpT3lwc1BPU2NOMjNt?=
 =?utf-8?B?K2xiUjlNZGhKUHFJdzBzK3RYNnJaZzlhNlVqa2tmeTc2L3VVYWl4ZFNlQzBO?=
 =?utf-8?B?VmtFRG9KeVlqY2lUYnppSFpNWHFLOW91R0I4ZE1WQjJSYTB2bWY2dWRGSWxl?=
 =?utf-8?B?cDdIWW9TcHhVdWk5bU9DekUweFBSVHhvdUlaQSt6NGF3UGtoem5Rb0s5cm9Z?=
 =?utf-8?B?elRkRTkyTHFMcFk2c1ZYc2RhZUZLTXg5SVFDV1VHc1RGT2hSanpXOTNiUllC?=
 =?utf-8?B?NWxGaWFJcUp6b0FjeDZRL1dhL05Xbk9NeW8rSE5na3VRNENMT25DVWp2NW4z?=
 =?utf-8?B?U3RuZmpkVklDczRCQVlMYytyTnNNU3d5emNUcnFSR2RBcnlKc3FsemdoaFlG?=
 =?utf-8?B?eWhFaXdQa2RpeWE4SlJOeWwrRWtPeHFlU3hmclYrT05SME1pM0lPM0F3b01Z?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8AE6FF8128B5247BA0C9E2AF4B1F3B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c265d66-8d5b-4e0b-35bc-08db99631868
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 05:31:49.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD7sJrYgQMRMxIf5G1b6hFF9xHjfEl3OTh7CYESIlSXgwLleCzs5tXH6armg4UoBU/OdX7BS/pmd/qBeVk2j0OOTlql9VrfkkwC+Rd9uZ/Heaq5tA3KP281ggPdRm0Nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMDcvMjMgNToxMCBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyOC8wNy8yMDIzIDEyOjIzLCBW
YXJzaGluaSBSYWplbmRyYW4gd3JvdGU6DQo+PiBBZGQgYmluZGluZ3MgZm9yIFNBTTlYNydzIHBt
Yy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWYXJzaGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJh
amVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nsb2NrL2F0bWVsLGF0OTFybTkyMDAtcG1jLnlhbWwgICAgICAgICAgfCAxICsNCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0bWVsLGF0OTFy
bTkyMDAtcG1jLnlhbWwNCj4+IGluZGV4IGMxYmRjZDkwNThlZC4uY2UwZDk5NTAzNjQ1IDEwMDY0
NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0bWVs
LGF0OTFybTkyMDAtcG1jLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sDQo+PiBAQCAtNDMsNiArNDMs
NyBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNC1wbWMN
Cj4+ICAgICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXBtYw0KPj4gICAgICAgICAg
ICAgICAgIC0gbWljcm9jaGlwLHNhbWE3ZzUtcG1jDQo+PiArICAgICAgICAgICAgICAtIG1pY3Jv
Y2hpcCxzYW05eDctcG1jDQo+PiAgICAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gDQo+IFdo
ZXJlIGlzIHRoZSBjaGFuZ2UgaW4gYWxsT2Y6aWY6dGhlbjo/IE5vIG5lZWQgZm9yIGl0PyBXaHk/
IFdoZXJlIGlzIHRoZQ0KPiBkcml2ZXIgY2hhbmdlPw0KDQpIaSBLcnp5c3p0b2YsDQoNClRoaXMg
U29DIGhhcyBhIG5ldyBwbWMgZHJpdmVyIGFuZCBpcyBub3QgZGVwZW5kZW50IG9uIGFueSBvdGhl
ciANCmNvbXBhdGlibGUgYXMgYSBmYWxsYmFjay4gU28gSSB0aGluayBhZGRpbmcgaXQgaW4gdGhl
IGVudW0gbWFrZXMgc2Vuc2UuIA0KQ29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLiBUaGUgZHJpdmVy
IGlzIGluIHRoZSBzZXJpZXMuIEFwb2xvZ2llcyBmb3IgDQpicmVha2luZyB0aGUgdGhyZWFkLiBJ
IHdpbGwgc2VuZCBhbm90aGVyIHZlcnNpb24gZm9sbG93aW5nIHlvdXIgYWR2aWNlIA0KYWJvdXQg
c3BsaXR0aW5nIHVwIHRoZSBwYXRjaCBzZXJpZXMuDQo+IA0KPiBQbGVhc2UgZG8gbm90IHNlbmQg
aHVnZSBzZXJpZXMgdG8gNTAgZGlmZmVyZW50IHBlb3BsZSBhbmQgc3Vic3lzdGVtcy4NCj4gV2l0
aCB5b3VyIGxhY2sgb2YgdGhyZWFkaW5nIGl0IGlzIHNvIGRpZmZpY3VsdCB0byByZXZpZXcuDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KLS0gDQpUaGFua3MgYW5kIFJl
Z2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4uDQoNCg==
