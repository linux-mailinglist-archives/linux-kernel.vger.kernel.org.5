Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8C7E80DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbjKJSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbjKJSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D53E400;
        Fri, 10 Nov 2023 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699633693; x=1731169693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bg+UT1kNkxlM/qsbzaKNihLGAPYCV98X3GdxnuU6dgk=;
  b=h0tt4gxVlUzloeT8lxQFwU8CibpVR9R+IrJa5rkpOq0f81TWreoHI4IC
   BoN0TPCITorIz3DXtFMjCsiEXiMMTohrXyC6gEDJeZAHgEfvk8oSwwT0E
   K+PNUX6dvrIjFae6Ew2zcuRbPNNcRq9muwpBgLnifAgcvB7e/hJnADFaO
   udTZJMeoIbK0xCH6t04FqXf+PpRswyzZk2yuHb5+5gHGtUbyv4v3Iw/nO
   fEWNUcZ36t1D7BoP78CymoO/LiB+xNUBPMKZoJJ/oEgHkTIdActLHzMn3
   R0dinYsw9kTg3DWUFppL2RCH3CLwYj9lj4GbgwTo9kSpNmJ7/kEKKYlmI
   Q==;
X-CSE-ConnectionGUID: SvPqDJACSyCbPiV/lVulgA==
X-CSE-MsgGUID: QT2qTRfrTeGiAqN+U2w8Bg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11533536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2023 09:28:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Nov 2023 09:27:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Nov 2023 09:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJF6mFg/cdwD5J4RBdNY8bn9cjr99qQIsqdWKxSFnyJcHA4EdGpFAxGsv92hJYg6CXs7p6fFyzGvr4/qJfnCY6Jm42UGJG9C/x6QaIgjDCGqisCQbthyIvgzAiJzTBvmue3BekBLMzp7KgZGbLbV/EjxWCzp/Boklc/eM034HYpK1miUfyjc+8vYvOdHm0LQa5LHMyB06EkWWgFqo6PUoFx+6ZrYH/t9k+pp6k6usfdo0YJHyguhFGz4hDNGgk3MmFAeuECh0x41KwN8uNYfGoGLHV0ZHOhdHskL9qOL56YPPAQ6rkVrH+xcCw7tLrhvkWzn0FkFi0hYKbN85VyYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg+UT1kNkxlM/qsbzaKNihLGAPYCV98X3GdxnuU6dgk=;
 b=cNKi71TxW5wkhWNU9nu8wg9Qkv9zxQCS1Y4DiW4MIRQNsUxNjWfm7PnIZR2Qn/MTpJH60qEW+Bx89G/LyuNC2ZQcIgbHHqN0nKE4617bgMxFN5nja19MUQJL71G0yQRobfczJW9kEUYItaxpau5g8Q6xNIrguxMJRXmF+LvpZmdAKq2Gmhhh4bitaQh1sTmQke9TNMIX47ei2whcNzSbueWDwqUa1zOsrarnTrd8YMhOYFU8q6Yo2vNEvJVj4gQ9A+q2S4WlJcxjKghi2SipqlPeVtGmwQ9d1fI2P+gMZcM/RbKGyOmSFuFEkmRBZSvWmGARI/PRwVOceQxPCRWLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg+UT1kNkxlM/qsbzaKNihLGAPYCV98X3GdxnuU6dgk=;
 b=ZCvbkZ5Gr7IuBcXEAMGfoMKU/mNSvNeiKIUVi6q8b96Ap5JFNTfwdnOt4Zf0iAzQktQb4E2JOfjFn45qGoT7W3Rh8eFgRKCQfsptGFIAkGjeW/sNDCDjYjaQr8ZkJby7D7WsH/Ks07S6b3gruzT9B/k8iFzTGtqP6IlViRcQkgpIgdvc334caR3UiqI+gecvotuAyXQ9L/1m2X/GReXp4zmivDgFCPnOrjlYewM/Sf2P47JgrWmN9QYY938259iq2o+XhbAKaz5Tq5yP9D6Zro/PyqDbyq/MRaJRwGPfQHAFrK0ybIzPwkEKrmdJbpccXpXqR6cpb0q43mjkGOMZXA==
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Fri, 10 Nov
 2023 16:27:54 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%5]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 16:27:54 +0000
From:   <Marius.Cristea@microchip.com>
To:     <conor@kernel.org>, <jic23@kernel.org>
CC:     <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Index: AQHaB0lj9PO1FMJaPku3xMkF5R2gP7Bam5gAgAGWpICAAAxogIABdeqAgBYilIA=
Date:   Fri, 10 Nov 2023 16:27:54 +0000
Message-ID: <7974eb280202c551eb66000c8c26276080ad7da2.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-2-marius.cristea@microchip.com>
         <20231025-cheddar-tucking-b2ea777ed4f9@spud>
         <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
         <20231026-perkiness-financial-55313e297230@spud>
         <20231027152625.44b26d80@jic23-huawei>
In-Reply-To: <20231027152625.44b26d80@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CY8PR11MB7107:EE_
x-ms-office365-filtering-correlation-id: 41b61b2e-e47e-4d4e-a2e5-08dbe209fdda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: maR+cc2v04/IHvZwK2B8SzzfZwcorhrwAVZbFUqteBWOFKPU0NwfpgFUm0hh5t291+lLVZPD30Dg/y9XIHYc9T4W8nD7U89RoUxmEOUjXKnbSd7qqN+Tw2IFjiSEZjrD/koCWennxMCz6U0n3bqOWVEp4EWvBOq0ikFhF3hoxdpnMzw1Cjuj5mweAltll6p4nGhg+eWVGkApkDrdA+EDS4yGV48cJTIUPgUwqqJKgaDlvgHbdd1d688vD2mkFIyai2CqdCmZUEnVAfBqH4HrM3p8O+lQW0Bust8HeqrNMExttj2zb9Fl05T7TS20HaDfpVpWv+e6VMWo0VGqALo163LAjc+kwYpcSuUbZJ6nqDWl4Io5i2TXPm8ndju7h0Vt6ddI3HqYMlhDI2FJWfTTuOXw4MF3OdFUM2F7bYsfljfqlNN+tRp6GIVHD373nyJ3fQjwu9bzPglSPu9ro1A+k6YBzwlr1SmCnwW/bZ4C8t6axsCIiskrCdo0b+hggHL76JLQIkCXRe9DWWVQB/YQR6w+aqfPVeFi9fGFmvvRzMdKN8U4aUZh0cpk9kQt4bF2Flu8nQjVfjJuEiM8xvuQYFz+OAW2L16Jl6I+PhP94vnWSS1d9ICtg/q4WeuXRMPllMxYwIMsSloQ/Dptzon0csAOiMNfr2qmCxZQoqzKd96eFrEYpImevo3wLEJYfvqL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(4001150100001)(478600001)(2616005)(6512007)(26005)(6506007)(91956017)(316002)(54906003)(4326008)(83380400001)(110136005)(2906002)(966005)(66446008)(8676002)(64756008)(6486002)(41300700001)(66556008)(76116006)(66946007)(66476007)(5660300002)(8936002)(71200400001)(38070700009)(38100700002)(122000001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhlU21mSVVJeFYrb2xkcGo2NWoxcFl6T0t2YjNZMm9VdHV0d3FIMVUxZTd3?=
 =?utf-8?B?Qmg5U3VuS1hLSExaRTRQY3R1MjkwbU5Za3Z0YTQ1VGNDcG80WjF1VklYQjNG?=
 =?utf-8?B?YUtYRGxnVk40alordUxPVUdPZTM3NWNUUkNTMWtybWlZTXFzQ2ZOTzdXKy9p?=
 =?utf-8?B?LzlsTTZxTEtyanVOMXNRSnRWbEZEQnJNTzRUcGxXOVRXQkF6MDg0M1RYeWhx?=
 =?utf-8?B?VWlsOHdSV2h0UjNBdVQwUHpxZkQxbjRvT3Y3amtzcS8yQ3doUkNaVjlXUFR6?=
 =?utf-8?B?Y2RPSkNHY2dWRTY3ZkNqZVpWVXpPbjZiSlB6dk4rSEVvQ2NObURBdlpIS0Qz?=
 =?utf-8?B?UmZFVDJaK2k0RlFLLzNWbDdoM3FXYU5hTVB3SkRTSWE1LzBiM0lSSWEwbWtZ?=
 =?utf-8?B?eHhGdlZ2MU9FUUJDd3ZONjhNT1NSR1BtdElPTGdDY1NZQ1VkWUNra2ZrTjhy?=
 =?utf-8?B?ZlVqaTdFam00dk8yLzNIbE9BRTVhbjRBNE5TT3lYMEVOZXh0ck1pYlF4WFla?=
 =?utf-8?B?T2tXUXdJYjdXaFlsMk01L3BaaTRUeGZKRnMvSTJuNURwQXE0d0c3REpMK1Rn?=
 =?utf-8?B?d21ZcittRFdoL1lMck81SFFSOGNFQ0owcFAyRWZwTlplWDFFOWIwZlpQU1Zz?=
 =?utf-8?B?MGo4cnZjb1J3b1Z0T0NOUVdIU1Y3aEJMUXBvbnBOdEFLV1lONHRrdXA3MzJS?=
 =?utf-8?B?OXgzeDBSTHIxOUkyYTJaUlptelZnSisvN2prNHBjKy9vYno2SFpHekxWaWln?=
 =?utf-8?B?UHpOSUN6RHpkbjd6cTJCSVl1d0tSQm4zdTM3SFM0VFFNMHl4SzNvTXh5MGRv?=
 =?utf-8?B?NUlPNm9kYWg1ekMxaDRSdDZFU0pGSnF5bU9wN0lDMHl4MEF0ODh2TjBLS3Rw?=
 =?utf-8?B?RXBRNUZnY3RYTkVIUlZLVzJQOE5lZ2ZOLzBBbEdRS3NQb1lnLzE2VktmMTdR?=
 =?utf-8?B?bkdLc3NoNUFnUm8rNStrelE2NTRySGJkWVo0Nmt1Qm4vQ1lGbThYcStaTkhy?=
 =?utf-8?B?SHBtOVllRWJuVEtYL1c4bWJrRW9pZzBiNDNQQTRUVnh3QlhoSE04THNPSGln?=
 =?utf-8?B?a1JiUkcvemdPNS9wUENmNVhDcHdVSGNGdlpsT085a0lBQk5yOGdYa29LY011?=
 =?utf-8?B?U2l5L203UHJwTVhFc2hpOFF6QUZ2ZVMvWll5dGpKNXdCQ0k2NWZWSjB2c2tn?=
 =?utf-8?B?VFdENjBIMG15eHhoRUlvWDFldDZlV01BemxVSlpJZWV2dTFueitlSzRHVXJS?=
 =?utf-8?B?RWlDQWVzbkc3S29GNmo1a2tlT0JQVEd1d1RtQ0xRMG9KUmMyWEFaQ2pkbUtF?=
 =?utf-8?B?am5MazRpeWI1dVczN2lvcTRiMHl4WVhRNnZaQWczb3NUWXBLbTQzZU5nWXhh?=
 =?utf-8?B?SHNabERUV01wQUNieE5QL2x4b212S0p0WDdpNmtTUkZSZkRmdjFQUDg0NERt?=
 =?utf-8?B?emdYN1FTR29xcXVuSEw4TmlPSzEzZkp2SzYzRW5tdHBoeUY4dTBTVlVBOWhM?=
 =?utf-8?B?OWM4dktTTTQvSUVGK1NPU0kxSEthVmJmZlBpcDJCeDArK3J4MHU2NVNuVDAz?=
 =?utf-8?B?YzhSTnByd0padlIvWkFRbVZEeGp3aEhBZnFpUS84L01GQ3ZWTVViM2hyTkhY?=
 =?utf-8?B?b3BzV08wYStyekdFTVQ4Y2NyYXNSRXIrZ0xud2xHZnczMFFRNlhPTitjNDdJ?=
 =?utf-8?B?V3ZzN2FnRGVkVXI5NWQrSVBzbG8vUUZEWHVVK3hJKzlkN2wxWTdjbERZc1gx?=
 =?utf-8?B?OVMrbE93NjhsQ2d3UDFMckFHeVJhNTJZenJrMUVwcFVIdVovL0pOdzNsaENk?=
 =?utf-8?B?b1dTd1VqSFVHejhZczJYTURCMlZ5ZHdGd1hmYStzclJ0T1JJMDlxZnhaNVBv?=
 =?utf-8?B?blBPR3hIM3dNRjBLREljVUcxb082QjNadHpXNmZlS29SM2Y0MkcyRVFyb3lm?=
 =?utf-8?B?OXRibHlQWkIrYm5qNTZCYWs2UFQ5dCtyUDVQV3A4V2JuVENNREZ1M1NESWpt?=
 =?utf-8?B?SFdlOEpZRkZBUS9Pb0hObzhwY3lQblhJZGZ4VHk0UDNIdU5jbnZ6OWo3OWFE?=
 =?utf-8?B?M1B5N3FJYVdBMjljUjFiYUJxMWRqWTl5WHR6bW9XVDM2WUI2UktlVU92OXB0?=
 =?utf-8?B?cElLcEV1K29laGdjSXZGaWUyaHRxMzVLUk5QT1N1WGdiMk52N25zUXZwVTZy?=
 =?utf-8?Q?+R02e5dke6XUvMuyUp+2xWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C56D551228CEED4183D092142F5B87E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b61b2e-e47e-4d4e-a2e5-08dbe209fdda
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 16:27:54.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +++aOe3QzKUHlX/6XFvvSjt00mViI1gMN0SDNEfx1BXVPvmNnUT4JvokZie0rNzN6xVCwaPKDrgIwZyFUQv8mi/08cauiCRPrhIBHxqEAco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIEZyaSwgMjAyMy0xMC0yNyBhdCAxNToyNiArMDEwMCwgSm9uYXRo
YW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBPbiBUaHUsIDI2IE9jdCAyMDIzIDE3OjA4OjA3ICswMTAwDQo+IENvbm9yIERvb2xl
eSA8Y29ub3JAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IE9uIFRodSwgT2N0IDI2LCAyMDIz
IGF0IDAzOjIzOjQ2UE0gKzAwMDAsDQo+ID4gTWFyaXVzLkNyaXN0ZWFAbWljcm9jaGlwLmNvbcKg
d3JvdGU6DQo+ID4gPiBIaSBDb25vciwNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDIzLTEwLTI1
IGF0IDE2OjA4ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4gPiA+IEhleSBNYXJpdXMs
DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBXZWQsIE9jdCAyNSwgMjAyMyBhdCAwNDo0NDowM1BNICsw
MzAwLA0KPiA+ID4gPiBtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gPiA+
ID4gPiBGcm9tOiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4N
Cj4gPiA+ID4gPiANCi4uLi4uLi4uLi4uLi4uLi4uDQo+ID4gPiA+ID4gKyRpZDoNCj4gPiA+ID4g
PiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWRjL21pY3JvY2hpcCxwYWMxOTM0
LnlhbWwjDQo+ID4gPiA+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArdGl0bGU6IE1pY3JvY2hp
cCBQQUMxOTM0IFBvd2VyIE1vbml0b3JzIHdpdGggQWNjdW11bGF0b3INCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gPiA+ICvCoCAtIE1hcml1cyBDcmlzdGVhIDxt
YXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArZGVz
Y3JpcHRpb246IHwNCj4gPiA+ID4gPiArwqAgQmluZGluZ3MgZm9yIHRoZSBNaWNyb2NoaXAgZmFt
aWx5IG9mIFBvd2VyIE1vbml0b3JzIHdpdGgNCj4gPiA+ID4gPiBBY2N1bXVsYXRvci4NCj4gPiA+
ID4gPiArwqAgVGhlIGRhdGFzaGVldCBmb3IgUEFDMTkzMSwgUEFDMTkzMiwgUEFDMTkzMyBhbmQg
UEFDMTkzNA0KPiA+ID4gPiA+IGNhbiBiZQ0KPiA+ID4gPiA+IGZvdW5kIGhlcmU6DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURv
Y3VtZW50cy9kb2N1bWVudHMvT1RIL1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9QQUMxOTMx
LUZhbWlseS1EYXRhLVNoZWV0LURTMjAwMDU4NTBFLnBkZg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArcHJvcGVydGllczoNCj4gPiA+ID4gPiArwqAgY29tcGF0aWJsZToNCj4gPiA+ID4gPiArwqDC
oMKgIGVudW06DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgLSBtaWNyb2NoaXAscGFjMTkzMQ0KPiA+
ID4gPiA+ICvCoMKgwqDCoMKgIC0gbWljcm9jaGlwLHBhYzE5MzINCj4gPiA+ID4gPiArwqDCoMKg
wqDCoCAtIG1pY3JvY2hpcCxwYWMxOTMzDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgLSBtaWNyb2No
aXAscGFjMTkzNA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqAgcmVnOg0KPiA+ID4gPiA+ICvC
oMKgwqAgbWF4SXRlbXM6IDENCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgICIjYWRkcmVzcy1j
ZWxscyI6DQo+ID4gPiA+ID4gK8KgwqDCoCBjb25zdDogMQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArwqAgIiNzaXplLWNlbGxzIjoNCj4gPiA+ID4gPiArwqDCoMKgIGNvbnN0OiAwDQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICvCoCBpbnRlcnJ1cHRzOg0KPiA+ID4gPiA+ICvCoMKgwqAgZGVzY3Jp
cHRpb246IElSUSBsaW5lIG9mIHRoZSBBREMNCj4gPiA+ID4gPiArwqDCoMKgIG1heEl0ZW1zOiAx
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoCBkcml2ZS1vcGVuLWRyYWluOg0KPiA+ID4gPiA+
ICvCoMKgwqAgZGVzY3JpcHRpb246IFRoZSBJUlEgc2lnbmFsIGlzIGNvbmZpZ3VyZWQgYXMgb3Bl
bi1kcmFpbi4NCj4gPiA+ID4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gPiArwqDC
oMKgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoCBtaWNyb2NoaXAsc2xv
dy1pbzoNCj4gPiA+ID4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gPiArwqDCoMKg
IGRlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgQSBHUElPIHVzZWQgdG8gdHJp
Z2dlciBhIGNoYW5nZSBpcyBzYW1wbGluZyByYXRlDQo+ID4gPiA+ID4gKGxvd2VyaW5nDQo+ID4g
PiA+ID4gdGhlIGNoaXAgcG93ZXIgY29uc3VtcHRpb24pLg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
IEluIGRlZmF1bHQgbW9kZSwgaWYgdGhpcyBwaW4gaXMgZm9yY2VkIGhpZ2gsIHNhbXBsaW5nDQo+
ID4gPiA+ID4gcmF0ZQ0KPiA+ID4gPiA+IGlzIGZvcmNlZCB0byBlaWdodA0KPiA+ID4gPiA+ICvC
oMKgwqDCoMKgIHNhbXBsZXMvc2Vjb25kLiBXaGVuIGl0IGlzIGZvcmNlZCBsb3csIHRoZSBzYW1w
bGluZw0KPiA+ID4gPiA+IHJhdGUgaXMNCj4gPiA+ID4gPiAxMDI0IHNhbXBsZXMvc2Vjb25kIHVu
bGVzcw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgIGEgZGlmZmVyZW50IHNhbXBsZSByYXRlIGhhcyBi
ZWVuIHByb2dyYW1tZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGRlc2NyaXB0aW9uIGRvZXNu
J3QgcmVhbGx5IG1ha2Ugc2Vuc2UgdG8gbWUgLSBpZiBhIEdQSU8gaXMNCj4gPiA+ID4gdXNlZA0K
PiA+ID4gPiB0bw0KPiA+ID4gPiBkcml2ZSB0aGUgcGluIGxvdyBvciBoaWdoLCB3aHkgZG8gd2Ug
bmVlZCBhIHByb3BlcnR5PyBBIERUDQo+ID4gPiA+IHByb3BlcnR5DQo+ID4gPiA+IGltcGxpZXMg
dGhhdCB0aGlzIGlzIGEgc3RhdGljIGNvbmZpZ3VyYXRpb24gZGVwZW5kaW5nIG9uIHRoZQ0KPiA+
ID4gPiBib2FyZCwNCj4gPiA+ID4gYnV0DQo+ID4gPiA+IHJlYWRpbmcgdGhlIGRlc2NyaXB0aW9u
IHRoaXMgc2VlbXMgdG8gYmUgc29tZXRoaW5nIHRoYXQgY2FuIGJlDQo+ID4gPiA+IHRvZ2dsZWQN
Cj4gPiA+ID4gYXQgcnVudGltZS4NCj4gPiA+ID4gSSBkbyBub3RlIHRob3VnaCwgdGhhdCB0aGlz
IEdQSU8gaXMgbm90IGRvY3VtZW50ZWQgaW4gdGhlDQo+ID4gPiA+IGJpbmRpbmcsIHNvDQo+ID4g
PiA+IEkNCj4gPiA+ID4gc3VwcG9zZSB3aGF0IHJlYWxseSBuZWVkcyB0byBoYXBwZW4gaGVyZSBp
cyBkb2N1bWVudCB0aGUgZ3Bpbw0KPiA+ID4gPiBzbyB0aGF0DQo+ID4gPiA+IHRoZSBkcml2ZXIg
Y2FuIGRldGVybWluZSBhdCBydW50aW1lIHdoYXQgc3RhdGUgdGhpcyBwaW4gaXMgaW4/DQo+ID4g
PiA+IA0KPiA+ID4gPiBBbHNvLCB5b3Ugc2F5ICJJbiBkZWZhdWx0IG1vZGUiLCBidXQgZG9uJ3Qg
bWVudGlvbiB3aGF0IHRoZQ0KPiA+ID4gPiBub24tDQo+ID4gPiA+IGRlZmF1bHQNCj4gPiA+ID4g
bW9kZSBpcy4gV2hhdCBoYXBwZW5zIGluIHRoZSBvdGhlciBtb2RlPw0KPiA+IA0KPiA+ID4gVGhp
cyBpcyBhICJkb3VibGUgZnVuY3Rpb24iIHBpbi4gT24gdGhlIFBBQzE5M3ggdGhlcmUgaXMgdGhl
DQo+ID4gPiBTTE9XL0FMRVJUDQo+ID4gPiBwaW4uIEF0IHJ1bnRpbWUgdGhpcyBwaW4gY291bGQg
YmUgY29uZmlndXJlZCBhcyBhbiBpbnB1dCB0byB0aGUNCj4gPiA+IFBBQyBhbmQNCj4gPiA+IHRo
ZSBmdW5jdGlvbmFsaXR5IHdpbGwgYmUgIlNMT1ciIHRoYXQgbWVhbnMgaWYgaXQgaXMgZm9yY2Vk
IGhpZ2gsDQo+ID4gPiB0aGUNCj4gPiA+IFBBQyB3aWxsIHdvcmsgaW4gbG93IHBvd2VyIG1vZGUg
YnkgY2hhbmdpbmcgdGhlIHNhbXBsZSByYXRlIHRvIDgNCj4gPiA+IFNQUy4NCj4gPiA+IElmIGl0
J3MgZm9yY2VkIGxvdyB0aGUgUEFDIHdpbGwgd29yayBhdCBpdCdzIGZ1bGwgc2FtcGxlIHJhdGUu
DQo+ID4gDQo+ID4gU2luY2UgdGhpcyBpcyBhIHJ1bnRpbWUgdGhpbmcsIGl0IGRvZXNuJ3QgbWFr
ZSBzZW5zZSB0byBoYXZlIGENCj4gPiBwcm9wZXJ0eQ0KPiA+IHRoYXQgaXMgc2V0IGF0IGR0cyBj
cmVhdGlvbiB0aW1lIHRoYXQgZGVjaWRlcyB3aGF0IG1vZGUgdGhlIHBpbiBpcw0KPiA+IGluLg0K
PiA+IA0KPiA+ID4gIlNMT1ciIGlzIHRoZSBkZWZhdWx0IGZ1bmN0aW9uIG9mIHRoZSBwaW4gYnV0
IGl0IG1heSBiZQ0KPiA+ID4gcHJvZ3JhbW1lZCB0bw0KPiA+ID4gZnVuY3Rpb24gYXMgQUxFUlQg
cGluIChPcGVuIENvbGxlY3RvciB3aGVuIGZ1bmN0aW9uaW5nIGFzIEFMRVJULA0KPiA+ID4gcmVx
dWlyZXMgcHVsbC11cCByZXNpc3RvciB0byBWREQgSS9PKS4gVGhpcyB0aW1lIHRoZSBwaW4gd2ls
bCBiZQ0KPiA+ID4gc2V0IGFzDQo+ID4gPiBvdXRwdXQgZnJvbSBQQUMgKEFMRVJUIGZ1bmN0aW9u
YWxpdHkpIHRvIHRyaWdnZXIgYW4gaW50ZXJydXB0IHRvDQo+ID4gPiB0aGUNCj4gPiA+IHN5c3Rl
bSAodGhpcyBpcyBjb3ZlcmVkIGJ5IHRoZSBpbnRlcnJ1cHRzIGFuZCBkcml2ZS1vcGVuLWRyYWlu
KS4NCj4gPiANCj4gPiBIbW0sIGF0IHRoZSByaXNrIG9mIGdldHRpbmcgb3V0IG9mIG15IGRlcHRo
IHdpdGggd2hhdCB0aGUgR1BJTw0KPiA+IHN1YnN5c3RlbQ0KPiA+IGlzIGNhcGFibGUgb2YgZG9p
bmcsIEkgd291bGQgZXhwZWN0IHRvIHNlZSBzb21ldGhpbmcgbGlrZQ0KPiA+IA0KPiA+IHNhbXBs
aW5nLXJhdGUtZ3Bpb3M6DQo+ID4gwqAgZGVzY3JpcHRpb246DQo+ID4gwqDCoMKgIDx3aGF0IHlv
dSBoYXZlIGFib3ZlPg0KPiA+IMKgIG1heEl0ZW1zOiAxDQo+ID4gDQo+ID4gV2hpY2ggd291bGQg
YWxsb3cgdGhlIGRyaXZlciB0byBlaXRoZXIgZHJpdmUgdGhpcyBwaW4gdmlhIHRoZSBncGlvDQo+
ID4gc3Vic3lzdGVtLCBvciB0byB1c2UgdGhlIGludGVycnVwdCBwcm9wZXJ0eSB0byB1c2UgaXQg
YXMgYW4NCj4gPiBpbnRlcnJ1cHQNCj4gPiBpbnN0ZWFkLg0KPiA+IA0KPiA+IFBlcmhhcHMgSm9u
YXRoYW4gZXRjIGtub3dzIGJldHRlciBmb3IgdGhlc2Ugc29ydCBvZiBkdWFsIG1vZGUgcGlucy4N
Cj4gDQo+IEJleW9uZCB0aGVtIGJlaW5nIGEgcGFpbj8gVGhlIGZ1biBpcyB0aGV5IG1heSBnZXQg
d2lyZWQgdG8gaW50ZXJydXB0DQo+IGNvbnRyb2xsZXJzIHRoYXQgYXJlIGFsc28gR1BJT3Mgb3Ig
dGhleSBtYXkgbm90IChhbmQgdGhlIG90aGVyIHdheQ0KPiBhcm91bmQNCj4gd2l0aCB0aGVtIHdp
cmVkIHRvIEdQSU8gcGlucyB0aGF0IGFyZW4ndCBpbnRlcnJ1cHQgcGlucykuDQo+IA0KPiBJIGRv
bid0IHVuZGVyc3RhbmQgdGhlIHVzZWNhc2UgZm9yIHRoZSBTTE9XIGNvbnRyb2wuDQo+IEdpdmVu
IGl0IHNlZW1zIHNvZnR3YXJlIGNhbiBvdmVycmlkZSB0aGUgdXNlIGZvciBTTE9XIEknZCBiZSB0
ZW1wdGVkDQo+IHRvDQo+IGFsd2F5cyBkbyB0aGF0Lg0KPiBUaHVzIG1ha2luZyB0aGlzIHBpbiB1
c2VhYmxlIG9ubHkgYXMgYW4gb3B0aW9uYWwgaW50ZXJydXB0Lg0KPiANCg0KSSB3YXMgdGhpbmtp
bmcgdG8gaGF2ZSBzb21ldGhpbmcgbGlrZSBpbnRlcnJ1cHQgb3IgYW4gZXF1aXZhbGVudCB0bw0K
InBvd2VyZG93bi1ncGlvcyIsICJyaWNodGVrLG11dGUtZW5hYmxlIiwgInNodXRkb3duLWdwaW9z
IiwgIm11dGUtDQpncGlvcyIsICJnYWluLWdwaW9zIi4gSSB0aGluayB0aGUgZHJpdmVyIHNob3Vs
ZCBrbm93IChmcm9tIHRoZSBEZXZpY2UNClRyZWUpIGlmIHRoZSBwaW4gaXMgcm91dGVkIHRvIGEg
Z3BpbyBhbmQgaXQgY291bGQgYmUgdXNlZCBhcyAiU0xPVyIvbG93DQpwb3dlci4NCg0KPiBJZiBz
b21lb25lIGhhcmQgd2lyZXMgaXQgdG8gaGlnaCBvciBsb3cgdGhhdCBpcyBoYXJtbGVzcyBpZiB3
ZSBhcmVuJ3QNCj4gbGV0dGluZyBpdCBjb250cm9sIGFueXRoaW5nLg0KPiANCj4gPiANCj4gPiA+
IFRoZSBzeXN0ZW0gY291bGQgd29yayBmaW5lIHdpdGhvdXQgdGhpcyBwaW4uIFRoZSBkcml2ZXIg
ZG9lc24ndA0KPiA+ID4gdXNlDQo+ID4gPiBpbnRlcnJ1cHQgYXQgdGhpcyB0aW1lLCBidXQgaXQg
Y291bGQgYmUgZXh0ZW5kZWQuDQo+ID4gDQo+ID4gQ2hlZXJzLA0KPiA+IENvbm9yLg0KPiANClRo
YW5rcywNCk1hcml1cw0KDQo=
