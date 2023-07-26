Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2641763BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGZPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGZPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:54:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27C2109;
        Wed, 26 Jul 2023 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690386897; x=1721922897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IgYaEELOfh5Lw+3mlkQhRNlPSdFzk5JOB8Akc3Itmug=;
  b=AaHkm2wfUwLda/H5pyQ1eLI6Phv6BoiKEGbq6V80MrZeK3W+PmhdHi8p
   xCpzTUWuudEZ4awLpMJPYVIAsU2hYAG7cSH9qLS0xIDsu6o9mIKcyhcMr
   MXtuGkpdP6nxhUcRTa9w4l9vPM+Tv3nuDmqUrUqOoLtsrkLhgt+3iGRcm
   rzmKFFfhi3W7sO6lXgTEY+JXuB9QZ8560QI+k2k+7iMaWaiQFu4IjEf4p
   jpC89fL3brdDXQR/rdQozxZImYGg3Dlvarfs8gdQrpZosdF2gEAT7BRcx
   4t9SVZxhkKnrbCzmiKSQgfWC6ZsFLgrNLH2GEyPo1r0EQhUFP5ImErGuf
   w==;
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="163340225"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 08:54:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 08:54:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 26 Jul 2023 08:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDdqUU/00NQE47O3x+45yI+NjwZyz+ifVB+1QXSLjzsxRUu+8kmvVYIPDb4RvVgA/nx6gUGlYlR37V/wHPewkd+z8lX72vixmLaXeLV35PhLX2NUZfZ02Z3M5P2IhgYyPbrrf/ayC4DrTNWvt2GDroMtE6Vo3sa4yHDchlVp5AP/8c7GHUT1/NIpxtvV0b8W6DInBpnivSyK/nz2DMEYBJQTSh5goDm1xXcjvpOprVVsoT5UFeJ3D9KGQylW0a+/6JlJny4Mjq0QopoUgy9Rd7iTRZr3ovr6OG1RK2Gb5TSJk9v8PZswI1DqJT6ric/xXwFyCOc3+2OGlySFnanq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgYaEELOfh5Lw+3mlkQhRNlPSdFzk5JOB8Akc3Itmug=;
 b=fQQ+q4SdIEwDdHsX0fK1ucg5ATOMH7olhjQgyzXigtkjQtqiGBp77JSuP7GPDXicPyKfH3mSC+afWgs84R/EL3tZJb1bNvh/Jxs9kKHiJkfAjJze0TzfIW2Aa9B9n5MsboPpMTLyeLBAbvZXc9X++RD6uCWrM+KRfx+0F6by5nol0EwwAmo8U5vg1tmLj5V7GPY6Dzk0X1rdhs9egbl8OAJSCVg6Wyjcd+8HrW3ll+LHoCRubg7xS6Zx7oph4FHILXw1im/JfM/QXnYVgdCCT8OSvHfR4wC4iQ362klDSORihBsMmEw8bDS92yWbTXlCRJZzcFSs+kDtegGqeo+m8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgYaEELOfh5Lw+3mlkQhRNlPSdFzk5JOB8Akc3Itmug=;
 b=dA2+TXPmSv0dNFi78+K4Rnyuqa+S0JVqhdiPlY9iNrqvNMFO4F2aZj4LUErp4bmAVvM4e01FibnIdCWm1eVOtN+vtpUOHoMwBJoStk0wVKw6agQVTEreywO5k9yGt8tnmMxAUhKcdzCCarRouogUfllJClQZLK84RTTadsOuWp0=
Received: from BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:54:39 +0000
Received: from BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::8da1:a89a:df1d:ffc8]) by BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::8da1:a89a:df1d:ffc8%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:54:39 +0000
From:   <Ryan.Wanner@microchip.com>
To:     <machel@vivo.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] crypto: atmel: Use dev_err_probe instead of dev_err
Thread-Topic: [PATCH v2] crypto: atmel: Use dev_err_probe instead of dev_err
Thread-Index: AQHZv7mSMZ1QQhWivkCDKCUA5SV5ka/MM4MA
Date:   Wed, 26 Jul 2023 15:54:39 +0000
Message-ID: <48f16656-af30-cd6f-5adf-8b7dac0818a0@microchip.com>
References: <20230726120451.6099-1-machel@vivo.com>
In-Reply-To: <20230726120451.6099-1-machel@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2657:EE_|CH3PR11MB7770:EE_
x-ms-office365-filtering-correlation-id: 0d7add35-c1b2-4628-db91-08db8df09e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IJ4ppijzCJsL2UyEVdziGGVquLrKFb8CZi85NbSdFyEna4Cxwh4cVkiBwm5LqaZzX8/F0utGWw1z0qvc9YgKyZj8LM5/MqKlCH5BGierDguVMc5tl46f1DOqktlvb6rylcuO09NkSNXKUJMJ2wg8LFN0jI/gj/yVKtt/Wf1ak/sYPo4le/jIymdKOXIp0RnRquavYmr8dr3ISFCU873wSgugtMSFUCJUWqAwTD3tlT+xWfaHVNXtK5KT6YsAcUNjNJxyxvI6OtsHI2dJehFBYUI0gbJspnkqsLszNhyySOkifB/bNciHfnz5nShdips1Gqr5F+3twuPt1iL1e2zegZ3rJC6erVs+Y2KFG4c3RVW12l/CMltttB86q9XasMYYKd5CvaKecA2l7NSnmTJoVLfuKagkMJKAYI3CSA4DK2LiBqYwOXWEkh+IfqIg+wmx5Dpeh5MoAWZZwjpKQZKLAbszwEK/jgRZxihBiLIxpIO7MHfmWs3yjvXtfaiBpyqSxQDmsGXv6UYTm/YVUiyurPSa6pfV+9cshyT+fWIO5KCyHswA7QeuIEt6huymtS6wBjU3UljYcG/B5jSIiXKl2oz0UpH2Ek+By0e35pPv57stGdxmDRfJIPxqO/7LJB8m4DD75k3PWVNwGVwlI20wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(316002)(41300700001)(83380400001)(31686004)(6512007)(4326008)(478600001)(122000001)(66476007)(66556008)(91956017)(76116006)(64756008)(66446008)(110136005)(38100700002)(86362001)(31696002)(6506007)(53546011)(26005)(2906002)(38070700005)(186003)(66946007)(71200400001)(6486002)(8676002)(36756003)(5660300002)(2616005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hpcFNrOUNxbWt6UDZqa2N3N0FyRGtFTzIrSWtTTWsyN0tGVy9JNVlNclR3?=
 =?utf-8?B?eGs2ZXBDbmxvOUxWcjh2UHpFL0JjSXhDVDF1Z244dko1QnVSRHkxSXdDdHRO?=
 =?utf-8?B?RGxnbnE3VFlQaUdyRU1ySlBkVkZsQnB0WS8xWXFnN3VtMkVkVkREajB3YTRl?=
 =?utf-8?B?U1JwYndpV01Ud2NobFJGaUd2NlhSM0ovNGNHZW1mZjY5aGFwQmVoK3JMMHQ1?=
 =?utf-8?B?SURRM05CU3lWQVBzZzBuZnE5ZStkSlBEMW50c2xQWXV0SFpHZW1UWUtsYTdR?=
 =?utf-8?B?R3F2eTYvMDA5N3F4MjBxOEJneWJOK3pVM0hTenRpMWFkMkphVmluYXBxRm1y?=
 =?utf-8?B?d21EZ3pxdXhZZ1kydXk0Z054VE9YVlZuTnBvS0RqdlZZdC9ya1ltK3J2Tlhy?=
 =?utf-8?B?U0ZVYzFQMDUvYmxXUzBrUE9hMFdBME02cHBIVVl2NGp6T2R6RnN0WXh3MnZW?=
 =?utf-8?B?eENZQnVpMXFOWmlFZlArUlZVeDJ3YlpoekNRWXJCQTRoM003T1pRVmZiZ1VC?=
 =?utf-8?B?ZFBjWnpZRUdWS2FPdWpZNkp3d0R2MFE4dmZXclNCVXlic2FhZmY0VGdzdjda?=
 =?utf-8?B?bUMrSXVseXRGMUlTTGxGYUlsUFdaRVovbjh6eHJ4ZFVWVWd4VlhRYlMvR2xW?=
 =?utf-8?B?RXVKMkk3RzE5cXowcFdyaDk3Z0g0eXRPNzRudjQxazhaNjF5Wkh3d2czUGRq?=
 =?utf-8?B?MHFhWG9vZlRGR3gyL25wYzB5ZWx5aERHTUlhOHBPKzE4b1VEelFUVzVlbTBy?=
 =?utf-8?B?M291aDlWZnJxOExrRkg1bUJUNVM5K0FSenNBMnFHa0ZuU0tGMWV0d2ErQkJn?=
 =?utf-8?B?U2VqZmtDQWVOYlZmQ0xzdlpudk41dFkwK1E1M2wzaU1VZEpPdDZrRXZOUG9N?=
 =?utf-8?B?RG1WelVDVnJHeEx1ZTJKTFRQMXMyRUR0OE5sSmNBUkZob2ZrNGRLWk5vNnA4?=
 =?utf-8?B?bXlGOUszQXEvRk1scXlNVzQ1bUg2SHZEaUQvMWUxZjgrZEx6aVY4YlVZU01O?=
 =?utf-8?B?RHlrSjZKODV6eVh5QlRML1BvOHptd2N5THBHNFpJNCtZYzBteHJDeHpLM1R3?=
 =?utf-8?B?SVBTQ0NtbjV2TUt3ODN0VGVMVEw4R0NnRmFqaFBiYmFid0lyYmtnRzNGMVc3?=
 =?utf-8?B?Wi9sQ291Q3B0alhQUGwzY2NUWHZ4ZWtEeXlMK1owTk8wM0c5QmkxZUJRTGVZ?=
 =?utf-8?B?UTQ0UEdXMjFkNmpjK2NDcVZTcmtRMGJFcHRUNnBrYnM5M1Fmc05HTkhtYnZI?=
 =?utf-8?B?cHIvMW51dHJ1c25oVU1Xc1B5M0RtNjhXam5VWnNsZlBEQmh1bHIvQW05blNn?=
 =?utf-8?B?ZmZrOEw0Um9GOWhYREkrc25NNlA3Q0QySFJscUNraFhhMWI5UHJGcUN6dTJB?=
 =?utf-8?B?amc3VXA4ZUMrOFdJYTNRUGlmYWNtQUxrK21sVGd5eVVEc1hBb29YdWk0Yy9V?=
 =?utf-8?B?Vnc3eFliUFk0OHN1WVpoY2kwaEhhMnhLZXNLcnVTNUU1WElueUQrRDRQclIy?=
 =?utf-8?B?N0Z1ZGp5K3pNVzhJdlZ2OVo0cjNZbjNBell6Rnc4amVnblBKei9PN3BPdEEw?=
 =?utf-8?B?RDJnejVYdlh5U2ZiYzIvODdUL01aNmRrTEo4eVJScFZFQWowc0ZzNWphWFp2?=
 =?utf-8?B?ZnBwYkFxTWczRWQxRldlU01FcEMvcDVQdzVnb0ZzU3pYU0U2dVgyd0ZMbFVo?=
 =?utf-8?B?NlhVbllDdXQ2US9VRmZxTHY3YkdHSFVYQTJtOVFHQ2VOTVpuL1BSeXZoRlht?=
 =?utf-8?B?UGV0NmxzVWhCa21KTWhkUTRqcHMvaU9Wdkg4dDF5aVFOSFkyc0drcWtueTY3?=
 =?utf-8?B?MzZnVDV6cEU0MnYwWmtjbkhMY0dRWG1YN0xzWkdJOCs2UGlub2NoMGx3TlB1?=
 =?utf-8?B?QXRvcEJzOVhWNS9XQTh5a1Q3RHdnbkoyQUhPczVSL2FKb25kaW1sVnVTeFRS?=
 =?utf-8?B?SWFTM0FZTUlUbGhEZGhlYVVFR2pjeVY4RFlDSVRNOG96emRJbkpMUEd6cXJl?=
 =?utf-8?B?eFJ1djRCSVlDcWtWbEFnNmcveG9PSTY0bkM5eWFnRWFjd1FiWU5jLytiWEc4?=
 =?utf-8?B?TlN2VEJDa3RKRjAwL0tNdGR2YWk0ck84Y2dmd0ZVWmRyS1ZSQ1ArWnZPUnJv?=
 =?utf-8?Q?ckzUT7HEfcD+akoWYI8l1Ydp9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E6E9CF3073AE45A381730207EEF50B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7add35-c1b2-4628-db91-08db8df09e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 15:54:39.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NabKo4f5g1pctO7VbBnsL1kKWZkoII3+TCgsC8lVx0C3PNpi3L6JU6st3THf6PbO0nrbEPF6FXsLTnMHMb5lyUxmngnhnfVsa3W2u5uZY60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
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

T24gNy8yNi8yMyAwNTowNCwgV2FuZyBNaW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IEl0IGlzIHBvc3NpYmxlIHRoYXQgZG1hX3JlcXVlc3RfY2hh
biB3aWxsIHJldHVybiBFUFJPQkVfREVGRVIsDQo+IHdoaWNoIG1lYW5zIHRoYXQgZGQtPmRldiBp
cyBub3QgcmVhZHkgeWV0LiBJbiB0aGlzIGNhc2UsDQo+IGRldl9lcnIoZGQtPmRldiksIHRoZXJl
IHdpbGwgYmUgbm8gb3V0cHV0LiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBidWcuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBXYW5nIE1pbmcgPG1hY2hlbEB2aXZvLmNvbT4NClJldmlld2VkLWJ5OiBSeWFu
IFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Ny
eXB0by9hdG1lbC1zaGEuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9h
dG1lbC1zaGEuYyBiL2RyaXZlcnMvY3J5cHRvL2F0bWVsLXNoYS5jDQo+IGluZGV4IDZiZWY2MzRk
M2M4Ni4uNTY4Mjk1N2Y4MDVkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9hdG1lbC1z
aGEuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by9hdG1lbC1zaGEuYw0KPiBAQCAtMjQ5OSw4ICsy
NDk5LDggQEAgc3RhdGljIGludCBhdG1lbF9zaGFfZG1hX2luaXQoc3RydWN0IGF0bWVsX3NoYV9k
ZXYgKmRkKQ0KPiAgew0KPiAgICAgICAgIGRkLT5kbWFfbGNoX2luLmNoYW4gPSBkbWFfcmVxdWVz
dF9jaGFuKGRkLT5kZXYsICJ0eCIpOw0KPiAgICAgICAgIGlmIChJU19FUlIoZGQtPmRtYV9sY2hf
aW4uY2hhbikpIHsNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGQtPmRldiwgIkRNQSBjaGFu
bmVsIGlzIG5vdCBhdmFpbGFibGVcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoZGQtPmRtYV9sY2hfaW4uY2hhbik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZC0+ZGV2LCBQVFJfRVJSKGRkLT5kbWFfbGNoX2luLmNoYW4pLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAiRE1BIGNoYW5uZWwgaXMgbm90IGF2YWlsYWJsZVxuIik7DQo+ICAg
ICAgICAgfQ0KPiANCj4gICAgICAgICBkZC0+ZG1hX2xjaF9pbi5kbWFfY29uZi5kc3RfYWRkciA9
IGRkLT5waHlzX2Jhc2UgKw0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==
