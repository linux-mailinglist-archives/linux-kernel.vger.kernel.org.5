Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F386D781060
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378641AbjHRQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378645AbjHRQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:29:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094CC3C04;
        Fri, 18 Aug 2023 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692376170; x=1723912170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z2iRC3Gu761m6km9C2nX1hx7Lt5GioL7+xXrJRKL4o4=;
  b=h8rVFuH5r5tGhZVU5sjNTbRe0VoNXkChuTm3IH+ys/U/Of+hda9nL3PY
   B5iQQ7OwGf9ZYyRs+hNg+m3ZTt2UW3ZORquv64FiuOVsD+o7/VoBNjIqa
   Zu0qqFTLtZ7AlejjvpVq21ccmKzq9UdSBBqUylaMMKD6LjESUUGSWyFus
   Y5u0LjnvyFsazjbSzKjkquvSvn7RjZyf2vW9i/M7wgQPgThU8JT2hX1X4
   dMwRy5/dV/sUcOoSrjQzxAgudxLgKq34ucxIpl76ionxOPIerzlxgdAKl
   /PVMSf5iM5B/jSJaOarxDf91xcj+84QQb/pdq93gdk1zIBGRrgLxAYAcK
   w==;
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="137051"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2023 09:29:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 18 Aug 2023 09:29:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 18 Aug 2023 09:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYEzzz1D+tDnt/3UQ/8ducVywPn9z1BcSRFWco5d25sW+gB3xZI31D8NLluLoLKWS60ERHyHo02ajwxjjIBAY+LqMIoLkpUWWw7dpix0tSW/0M7hswwKhLlfIMOrR7V9Hb6z6Zp1/NISaJL3Bfiz+7XqQ3uWy7iE56fhhWqCbckI2mpQSZMyaH7xTqyNP7rRECFmmiKKh07OIp5DIHyT8NcK5X00bOZ5LScxbLxS51b6FBmbPXLQ4t+mdSFiPMjLRRr5FLWfCwoN19F8W+gEDLsy+5aD3JhRp5PALa1dQ228AIHsMgdisfo899Ke2lKplFcadM7NgAt5NFAt/0cgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2iRC3Gu761m6km9C2nX1hx7Lt5GioL7+xXrJRKL4o4=;
 b=fplS+z//B+weXxRH0G8JcTpw+bYaBBOAd4iRCO+3TR6MRrLMvImHrDNxhnRF51PIJa3gAzmApbu9kv44r7pLXfUErqoJTgpVrHYa3utletPEF2dadh1nCvDiXgMOYW+g/1yk7pHznC/iFXb1+gTklyqCapsylEdhGA62KTmTbxDofZDs8kpjujVIKPg6cL5n5aEUTNKqMKGSGAehAKJCMpJhsuw9kl4zGOdOfeMBS7X6gF67f4cplcC2JV9xmvxDV4wrHLvS+axBpzgrZt14+HlHEQy/BU79S4fe09O++l4poge2+gByQHLLSrNC7KowBXwLNi4PA+anAG4AvTY8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2iRC3Gu761m6km9C2nX1hx7Lt5GioL7+xXrJRKL4o4=;
 b=PFWNeVqI+LYohYg0v6CCx3EtHcLPU4EZc2msXVBA0eu4ZDq4ZlmK1pNG0tUod0R7M4ec0bYdgwW3auJgkXhRFumtLWT4eRgx8AOUG+AwRzcFdAZTfqChYsymvzsAj8Vh6t6iMtbXM/6Ljt4StJwBWkqIZ7i/ecV/yY7AnPvEIPw=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 16:29:26 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:29:26 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Topic: [PATCH v3 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Index: AQHZxuAR8aV7wOpdPUiNu/ootgnZAq/b/0UAgBRVRYA=
Date:   Fri, 18 Aug 2023 16:29:26 +0000
Message-ID: <1c0f578669737e7f27a8ff9e0416b6c96eb917f2.camel@microchip.com>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
         <20230804142820.89593-3-marius.cristea@microchip.com>
         <20230805185900.2441a20e@jic23-huawei>
In-Reply-To: <20230805185900.2441a20e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CY8PR11MB7746:EE_
x-ms-office365-filtering-correlation-id: e950bda8-9103-4f61-4478-08dba00849fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnpmpYKR0dvGNTol/pr7TsTla1K0Snq4PaaCHzt6ElFWgrUqU2lbu4rDpriEaPa6e0e15633auKcN5oWvM1+bQi8ZOqpzbCTBJnimG6tDqwvB++waQ20d81WKDvKqZ7196a1ey/ytH0YNZB4ZTpQAEOSZthajUoEqcjhBIDGBAjk0ioY2k3yBQgUK8b2EvXyLFe0BOodZQHSng/9wqBkVRPHfYZFaBWyBIz7NqY5z1l0/4gXZenWZIkOFTnCselapk7AAo9Ym96OyZISXEIutWPVMZFFvbhUQvHiOyUCOmv+OR9Ft39l+n2otrOQdxVMQkap/6Uav8CAobI3igWgEh+u/DHhYl/p0CsqsNbYtkZO8cnHHKeMe9KudzHNMpWDk0sEeVO0AW4ABABTpwX1kC5xpWfuTZnGqtr1A4gBzLJKm5i4gldJzO7AyCbOxfCV4hTWE0jMP+h5BNo8STc9SQDH+Eh6o59zlUB+IvHPBrZcAV3eh/wA1MxCL6MnF09gcRI/9ZwcbhSjMfNtYsJCAdMhW22WfSZZu7TRERiSQNEErWhnumzfSK3VFrgNKf9Kvavj8lNmklOy51hHd1DFcRR0ieNLO+Bqg/ervXDibOZts8/QoGRQCZnodQxUgswV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(186009)(451199024)(1800799009)(2906002)(4744005)(26005)(6506007)(86362001)(478600001)(71200400001)(6486002)(2616005)(6512007)(36756003)(5660300002)(41300700001)(66446008)(122000001)(66476007)(54906003)(76116006)(91956017)(66946007)(66556008)(64756008)(316002)(6916009)(4326008)(8936002)(8676002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFAvdUdORDR0elFJSXgwQmc2MzBTaTllU0ZFSjBqQ1JJRjZvQ0N2aHVJdUtY?=
 =?utf-8?B?ZWQxWFVzU3BnTDhFSDZvSy9XSUkrbk5QT0FoNGIyWXNtN0hrMUtLYmRJNXdh?=
 =?utf-8?B?MWw3cW4xREgxeUVZOEk3VlQzTC9mTXJGakM5Y2ZjaUlGdUFCS0tzTnlsaGRS?=
 =?utf-8?B?WFVxaTdKUUVYVk5ucklZemhGRUFZRkxSMDRCaCtYMVFoN3k4RnR1MmZ5Y21z?=
 =?utf-8?B?YWtNcnZhZkxrcncrVTROdVdNczRnTWFIaktVb3ZoL0pNK1JmWEVINXVBL3h2?=
 =?utf-8?B?MFNHQitBK0pVTXowVlV0eDQ5a2lFaitsUk11UzJBUVU1TStndndKckJYVjJT?=
 =?utf-8?B?NVV5VnlGMEVqVmtvMVl1c1FGYjRodkdMNml3Z1hmcjJyUEVrKy9KcE1YenZp?=
 =?utf-8?B?VHVVdjFBNHdBNWZzY0dZVWxYMmVGQUx1dkxBVzN0MDB3MkwrU1NUU09BTHpr?=
 =?utf-8?B?TGNWNm9Gc0dHM1I4TDRMaVNqcHUvSXpZcEd0eCttR1J4dUduaGIxT1huL2F5?=
 =?utf-8?B?MHFrMkFyb3JnQ2tYaTNPQWxsV3hwclRyZHhoNFJqam84a3Q5bzZLTmQyb2lC?=
 =?utf-8?B?NUtnZk9OOE5PZWlkemljM3FBWjVOMzU3cTF4RG5aWHJPT3RTeWM3Ynd6SnR5?=
 =?utf-8?B?alZxSnBBWHNxN0lncEIxVzlWT2loM0FSRWY5R1BycEFRcU5RVXZqdTZiMm5Q?=
 =?utf-8?B?cFdscEJqek5OM3JkcHpCeEgzZ1FzT2ZqTlVHc2xWMGpvNXpCSDJsL0owOEdn?=
 =?utf-8?B?UTBJN3QxZkd1WlpwRkR5S0NzUVFyeVlHZ3c4S2JSU0ZqejJsMm40NUNvRkd0?=
 =?utf-8?B?N0tlenhYQmVBRG1RQ0ZqamRwb2JnLzRFbkYwUTdzcTRjbVNtdVMxVDM0MnMy?=
 =?utf-8?B?SHlOTXFPejFTTXNoYnp4LzRpazVGK1FVUzNJTTBLMzhjQS9JNWh4QlV4TkVE?=
 =?utf-8?B?UmZGcWpXODQwemE2RnBIL0JMcnFNSEtFRytNZ2diUHgwRHpzZFhjT2FZSTFp?=
 =?utf-8?B?LzZ2c1pnREJNUUFnaXJzZGJKUlk0Skh0bmljWVVtTnZ1MTMyTFd4bVcrZm55?=
 =?utf-8?B?NEQzUW1GbmxTdDl4WWVkVGZqUm1JRlRoNkhmNks1clBZb3FNMjV1WFZ1OHBp?=
 =?utf-8?B?eTRZTUJvR081c3I0ZG1SU0tLeFFzcjhvQTVLZ1h1RGtSZ1hldDQwM3kzTEtK?=
 =?utf-8?B?anlkN3ZnZy9vTlp5d0dlTW1RbE15M0FQQjdKRlAxVGJ1bDBvblphZjlrT3Ra?=
 =?utf-8?B?empVdG9BTWRMZVJRdVBubVA1azdJakJhUGp0N1UrcHFFckVDamJPS3RJYmVs?=
 =?utf-8?B?bDk4VndHUWVGaFBKVFpUZVhoL3QrbW1KNHUzK3J4S3lXMWVPdFQvUXQ0VC9z?=
 =?utf-8?B?dW56K0Z2cDV2dXl3Qm5QelJRR2FxN01BU3dOVXVlOElocVcrTWpjQ0ZqUDQ2?=
 =?utf-8?B?UDY0NVZPMmNwbThYWTFDS1pQTnhwZ2cvRnBmV0c1RGxFMys2RkZqQTdQWGVL?=
 =?utf-8?B?cG1tc3FQQ0FDSm8xeWlYcUxNUUoySnV2aytmbkUrMFZzRHJRbFpnL3RFRE5D?=
 =?utf-8?B?V3hiQkU3bGQ2a2FTRlIzODh1UkRmWWxRTW9LRGc0czZoUDRTNFF2ZkJ5QkV2?=
 =?utf-8?B?eDd6WGl4NVMwVXhGZ0hadncvdGxiVkMzRzl0dkdWOE1OczNBRS80bFg1ZW04?=
 =?utf-8?B?NGRkc2RpTjNCSU5yWkFQc2lHc2pLUlVrNm04SG1UVWh4OEUzQ3JVdVRYWG9Y?=
 =?utf-8?B?OHJGK2s1M2RNOHRRcGxPbC9UeWpoc0VoL0ZObjQzSUVrYzdseTV2RU1VL1pY?=
 =?utf-8?B?NklEZERvcmU3dy9SalREczZ5TEU1OTVLSklGTUphY1lRdTFhdWtGYTNZNXE1?=
 =?utf-8?B?UVNlU2IrZEJTMUQvZEhFMFgyejg1S0tNVlpZQ3lMNWcxRmpFU1FyT2N5b2xn?=
 =?utf-8?B?bmhyQnZyQWR1cExsRS9nRWthQzg1MW51OHdoUEYxZllNZVllcTBQeWVnbVRD?=
 =?utf-8?B?OVNMVnE1SnRiQjVwdVA5Q2JsN1VSRG1QVkQ2eFUvc29VL0pUa0pIOFFnUjly?=
 =?utf-8?B?NEd1M0ZqNWdGbDRUNU04YUJqdEE2RUd1cjhrTnhaZys3Ly80NW1HQ2hUMEp2?=
 =?utf-8?B?ektCUzMreHFhTGUyQ1k5Y0t0a3lva2Z5bmNhVXZSL3BHTERObUtQK0JCUDYw?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE0DA7CE14D7D4885985D714BE3F9CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e950bda8-9103-4f61-4478-08dba00849fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 16:29:26.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6m9V0JtLsZs8bggxQiDmGBVKxE9gneuIzU7D7CXRhbuGc5B2YZw42fk50KpNVV+V/LIJt66AXfmZOGmFNX2QQOopw3jQrw+zkauIMw3nUqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCj4gDQo+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ICtXaGF0OsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpk
ZXZpY2VYL2Jvb3N0X2N1cnJlbnQNCj4gPiArS2VybmVsVmVyc2lvbjrCoMKgwqDCoMKgwqAgNi40
DQo+ID4gK0NvbnRhY3Q6wqDCoMKgwqAgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ICtE
ZXNjcmlwdGlvbjoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMgYXR0cmlidXRl
IGlzIHVzZWQgdG8gc2V0IHRoZSBiaWFzaW5nIGNpcmN1aXQgb2YNCj4gPiB0aGUNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIERlbHRhLVNpZ21hIG1vZHVsYXRvci4gVGhlIGRpZmZlcmVu
dCBCT09TVCBzZXR0aW5ncw0KPiA+IGFyZSBhcHBsaWVkDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0byB0aGUgZW50aXJlIG1vZHVsYXRvciBjaXJjdWl0LCBpbmNsdWRpbmcgdGhlDQo+
ID4gdm9sdGFnZSByZWZlcmVuY2UNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmZl
cnMuDQo+IA0KPiBVbml0cz/CoCBTaG91bGQgYmXCoCBtQSBnaXZlbiB0aGF0IGlzIHdoYXQgd2Ug
dXNlIGZvciBvdGhlciBjdXJyZW50DQo+IGF0dHJpYnV0ZXMNCj4gaW4gSUlPLg0KPiANCg0KVGhp
cyBzaG91bGQgaGF2ZSBubyB1bml0cyBiZWNhdXNlIGlzIGEgImdhaW4iIGZvciB0aGUgYmlhcyBj
dXJyZW50LiBJDQp0aGluayBpdCB3aWxsIGJlIGJldHRlciB0byBjaGFuZ2UgdGhlIG5hbWUgb2Yg
dGhlIGF0dHJpYnV0ZSB0bw0KImJvb3N0X2N1cnJlbnRfZ2FpbiIuDQoNCg0KPiBUaGlzIG9uZSBt
YXkgY2F1c2UgdXMgcHJvYmxlbXMgd2l0aCBnZW5lcmFsaXR5IG9mIHRoZSBkZXNjcmlwdGlvbiBp
Zg0KPiB3ZSByZXVzZQ0KPiBpZiBmb3Igb3RoZXIgZGV2aWNlcyAoYW5kIGhlbmNlIG1vdmUgaXQg
dG8gdGhlIG1vcmUgZ2VuZXJhbCBmaWxlcyksDQo+IGJ1dCB3ZQ0KPiBjYW4gZmlndXJlIHRoaXMg
b3V0IGF0IHRoZSB0aW1lLg0KPiANCj4gPiANCg0KVGhhbmtzIGFuZCBCZXN0IFJlZ2FyZHMsDQpN
YXJpdXMNCg0K
