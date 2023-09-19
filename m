Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C817A5F17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjISKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjISKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:11:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA89E;
        Tue, 19 Sep 2023 03:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuKmPUKTwupC2VqeeKrNGawYmzaGVOS94LtmYhaGmt4ktJZTNoc08AtSihJrNhxkRl7EU3BNhvI4ho2TKGCN4t/YYf24befY0QZ38txeBgez1CuglSnFfNfWE0xca2RGLxzbT1nSNYs29FFh3C/yFYuhY6ByVABmVONXNbXsSUIllnT1J/mnBBIolfmNfXm4JbHUSmFnOWWjKjvtfIElmTRqG3jlNbv5LFGJuv0QfLdRfUG+q5FPGuasP/htf/NZL7kbCsNo0pqBCCTVObjmIUrpVd7CbDMI07aGGTEmAGT1jh2LKZXq/u5VmdDCr4jlJsr+FwJ3CVgO3oaoqEL7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ndKjViCuf5lBWdETscIXfk3br/0wlRl2yFNA0T/F1Y=;
 b=ZVDfshRtlOhpPWdMH7f5Xbh20Zn3IdDwZBLyr2I5pHZMY7RdaNffYp8zvzfGr3iYxuZJvKhyxf/111mfH2Kw+h02V7B5wZBiaqgmgV0se+7ci+YrMxxiWoTpQQcuucOnYlknEUBz/5Q2SjZro6W4uG67j+WPjxX7lc+CxCGid6zl3E6PdRpdIHJcsIQOOF1rpo6UwsFUCPSk+mRB0P/GvjG3f2unPDkQFT+HYvKfl2Ef1fo3oMm9yCqgrUluel7GBtn3jwtAzH13hPWh/BYpRvsh1nBe9zQRbBbitaBvnMS+yMFz0mKdDFUzQUgC5iQVquie3xsV1spx5Ua2jbrbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by TYUPR06MB5925.apcprd06.prod.outlook.com (2603:1096:400:354::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 10:10:55 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:10:55 +0000
From:   Larry Lai <larry.lai@yunjingtech.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Noah Hung <noah.hung@yunjingtech.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggVjYgMi8zXSBwaW5jdHJsOiBBZGQgc3VwcG9ydCBw?=
 =?utf-8?Q?in_control_for_UP_board_CPLD/FPGA?=
Thread-Topic: [PATCH V6 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Thread-Index: AQHZ54JpDX/LFt2hHkC8+IcGhRzYgLAbl4+AgAZYWxk=
Date:   Tue, 19 Sep 2023 10:10:55 +0000
Message-ID: <SEYPR06MB65077401CD3AA45A9D5E5C97F9FAA@SEYPR06MB6507.apcprd06.prod.outlook.com>
References: <20230915031123.14515-1-larry.lai@yunjingtech.com>
 <20230915031123.14515-3-larry.lai@yunjingtech.com>
 <CACRpkdbi0bS0yiJ9ac6Z44os0w6FyKm+UsvbgQEYzYKymjww-w@mail.gmail.com>
In-Reply-To: <CACRpkdbi0bS0yiJ9ac6Z44os0w6FyKm+UsvbgQEYzYKymjww-w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6507:EE_|TYUPR06MB5925:EE_
x-ms-office365-filtering-correlation-id: 216c621e-80a8-4737-e5a6-08dbb8f8b644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/+FQ4ZewcLX2U5eDj0GJdkavknc3Xsj52VIKULDBLKMGbwH7UZyxku+HK2L2scEBGNhMcwInG0IbdcGWMRxUpfw0p6+ERBVHou1l7mO/G5V/CIjKxRQeCSAt+/ovFHZRRub8tgi0s9RZJp0FTmmg31iS3asac6Rv0tLjoHV2qh1cNTxxI38YGzrMYMRKzHXe+aNOJK6sT85fsKkEg6c1fwAOZ8taY/3fE01xp6BFUL5YD7FH2Fl+fbWF1rfj1aa+fMXXysbXzGuac06PkLm60u3QfHrt4JJG71aV9mmk9yQlbG+IPlraUBBa1to5Q46GRI6fl0Gc9JWVoWYyln2RNHVtPRCjsM5tOf1FgC48DF3UK5JZSmW4cSEeVK/VWGBYJAx0536lN/H1i3vkTdhylLcHeN+rTXcl7BHlXK8qXu5LM9/ZWEozPV7rJnYz/4DFFapaMZkA6xsAofH6Dn3183/NAJKo2REciJ3ZOzFR8mDNyseVW2nj5DSFAYWGNqcNRFftVHfJ48lx7gOCM0yAMDx4p/6MnuTu10ltH+alJ91Hq04D80Q/DmIpEZ1I9ciE4Oz/96OU6l6cdtZOd5pnb0Uu0+FKXyE0RuvDgnZwhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(376002)(366004)(396003)(1800799009)(451199024)(186009)(54906003)(66556008)(66946007)(66476007)(66446008)(64756008)(122000001)(76116006)(316002)(8936002)(6916009)(4326008)(41300700001)(7696005)(53546011)(52536014)(6506007)(9686003)(71200400001)(478600001)(91956017)(83380400001)(107886003)(38070700005)(86362001)(33656002)(2906002)(38100700002)(44832011)(5660300002)(224303003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BYbTBmU1NPQlBhamZxUTljNXJYUGxqZ01NNnZuWXlJVzE5dEhWdDBQRnAr?=
 =?utf-8?B?ZzNwcGNzNHdTVm16SGZ6R2l5YVZGWm9hVU54dFVUZURyUDJhWGhwVjhaQnZK?=
 =?utf-8?B?NDVld24vVXNSTERZMGhzSmd0aFppVE9EandBSGZodXFRSXYyZ1g2eUEwYmNu?=
 =?utf-8?B?MWpGUkluRXhjV3JiN1ZFc0tiYmpQTnlsd0JsWFU1Y2NVQ3NpeGVwU1lnUkJJ?=
 =?utf-8?B?alBvQlFneDZWUjlVUiszQmNrTHNCbzhpTnRMREVsVi9KcUFYTmNTMmNmcFFj?=
 =?utf-8?B?TGUxeXAvZEZWVjc1Vzc2ckk5U25ycDIrTnBYclF1eWR1ZFJoZHZ0YnBkSnp2?=
 =?utf-8?B?RFA0bDN6eUMwQUY3dE45bElkSW5vT08yR09KY3d4a05tVEo5bXVjVVBWbXRm?=
 =?utf-8?B?ODVkbGxpT3BNL0UwQ1ZIYkc3L3lWazhHZ3g1NVNGZmwrbjFDOEwwVGVpTmZN?=
 =?utf-8?B?YWV3ZCtSRk9rVFpoRVlhdXdnTGxaV0JvTzFjNlFBNFR1THR4bUo5Z240dGpY?=
 =?utf-8?B?OG9pYUNqWmNJMWg1S1FiaVRrMXNYYUJKNWl3S2V2LzRmOXYrOWtKbU14aUg4?=
 =?utf-8?B?WUUrWm42NVE5bFNuQVhSeXBSMklqcHBhbFpIaytVTUFPOGltWjVCdyt5RXRx?=
 =?utf-8?B?Q2hEcmlzcE9BQzd2UzRzWkpVSnliT25kNlhnczJpeTc1Q3ZBazg5RW9TRmNs?=
 =?utf-8?B?VERVbldXU3pHV2syaTFPMm1hTmhYMjNqUFI2K05PVy9kLzJtV28zOGp0eDBt?=
 =?utf-8?B?TG1saCtuZ0ZMbmRocVRBTkJpZnJmRUhLMzdZaE9USlkxSHBJL0VFbW8vcDJS?=
 =?utf-8?B?Ymx3TEtsRjZlT3lQZ1hJYVVXV00wYzVYTXRqUkJGOU0yVzY2NmJHR0ZkNWNT?=
 =?utf-8?B?cGVYOXBRTy9WWklFMUlXR3F0WGtZZzNMOGErY0d3YjE3dnNxMjB3U3oydEVn?=
 =?utf-8?B?UExNY2ZKSmxZMUFqbCtMQWx0QStHN3dzbGtpVHhQdVhkeWxzOGkrdSsrWFFa?=
 =?utf-8?B?UlpWMEpvMHRhRXh1SWZZbUQ1cWNJR0FkOUZxbDN1SEtNbmRvODB5WTlvSWNP?=
 =?utf-8?B?YkoyNkpkakVvOFk2OW1rb1B5M2dWOFNpcVh4VVNncEFqSE9RYUovNGx6MFNa?=
 =?utf-8?B?ZkhZUnJ1QU5VQVNwR3lzYnhQNk1ucm1IUXpPb1JIaUJ0MDY2dmwrUXk1SGNR?=
 =?utf-8?B?OEFzc2IycWpVc2V2am9NMUFJOXBKUWFadXc1WW0yZWdiaTkwQjRBZ2F4bnVa?=
 =?utf-8?B?dVdRZExRWmFtOVNJTFhCL2pMbWZwWlFKR3hidUdhS2I3NHF0YTdiN3pobUdH?=
 =?utf-8?B?N05aeTl3b3JXelM1TTlIdDJ1WmtwdTQxYnUxQXVrMWxQanJ3NWhqcmZDUzFu?=
 =?utf-8?B?anozeElNV3BhL0lwa0Y0VDBIQUIybDE2VEtTenJJVW5uVjdtT29XNFpKWmJu?=
 =?utf-8?B?ZkhkVy9YNVkyUUVNUXpzRUN5ZWxBcUE2OENnS2lqVlR4Q1Zsa2liOFh0ajFx?=
 =?utf-8?B?aHNxclBvV1FhSlkzY1lzZ3dtK1dZOUk2aWJYaSs5UTRjYXA4TllYamFXMnUv?=
 =?utf-8?B?RGlmaFRFN1NwOUdvYitWTHBrYlU1WHh4ZmY0dnF5NU84YUFpS1dtYlNIMVV1?=
 =?utf-8?B?THpTNGlQZFhVc1ZlN0dtV1ZTWHhVbGNtMnlHZWFheW9PTVpMbHlJejlaNzYw?=
 =?utf-8?B?MmFxV29ZUlNmbTNVaHQ5ZUNuTlpvU0w2Slo1aUNSV3pFTWNtMmFEK3k0YStm?=
 =?utf-8?B?QkluREdBdy9QV3EreTltb2EzREpmd0w5ZFBoVHhuamZRTmgwSmJyZ3NXdkM3?=
 =?utf-8?B?bFdBUFJWTGp1NzdOZVpFWk5Kd2sxNEhZcWZJSTA1QzNxTGZKK0xZQmpUTmJO?=
 =?utf-8?B?TmlYU1JrTWcyTGltZnU0MFp0TGMveTNiUDJsUlNoRGhnS3c4NzQ5ME5Tc2tl?=
 =?utf-8?B?ZEVWS29iczJjZDZZQXhXd1JNeFZScW1vTGdSSjZzQ0pQM1BDNmk3R3BJUFpG?=
 =?utf-8?B?eTNJZERKOHpUVVJFWGpkTzIvNGhvV28xSEVUd3JBYTkrT05FWjdERHphcmZB?=
 =?utf-8?B?d2VZSlQvdDIrMjZhNWVnU05VbzFnVkN4aWNwZjBxU0dqVWdIay9yaHVwaGVy?=
 =?utf-8?B?L2Q4OS9zWitTM0d5MTNCd0ttYzg2T1cyWGhtSjg3N1F3TExUQkZUWFlBS3lJ?=
 =?utf-8?Q?Ue1DDKgk25Ol1m7Q4/g7z0nQegk/N3720+Y9pplsHI40?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216c621e-80a8-4737-e5a6-08dbb8f8b644
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 10:10:55.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPysi0v9HJb0W4X6wqljyK54eLUKgM0etjtwPvPUMBEKG899i1aAvp6wgKz7J7z41G7kbytNldu/TvN2nHv2Mp2EnXC9pDwFYGd6iDRzVzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5925
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIAoKICAgICAgIFRoYW5rIHlvdSBmb3Igc3BlbmRpbmcgdGltZSB0byByZXZpZXcg
dGhlIFY2IHBhdGNoLCBmb3IgeW91ciBxdWVzdGlvbiwgcGxlYXNlIGtpbmRseSB0byBjaGVjayBv
dXIgY29tbWVudHMgd2l0aCAiPj4iIGJlZ2lubmluZy4KCkJlc3QgUmVnYXJkcywgCkxhcnJ5CgoK
5a+E5Lu26ICFOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+CuWvhOS7
tuaXpeacnzogMjAyM+W5tDnmnIgxNeaXpSDkuIvljYggMDU6MDIK5pS25Lu26ICFOiBMYXJyeSBM
YWkgPGxhcnJ5LmxhaUB5dW5qaW5ndGVjaC5jb20+CuWJr+acrDogbGVlQGtlcm5lbC5vcmcgPGxl
ZUBrZXJuZWwub3JnPjsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBwYXZlbEB1Y3cuY3ogPHBhdmVsQHVjdy5jej47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5v
cmc+OyBsaW51eC1sZWRzQHZnZXIua2VybmVsLm9yZyA8bGludXgtbGVkc0B2Z2VyLmtlcm5lbC5v
cmc+OyBHYXJ5V2FuZ0BhYWVvbi5jb20udHcgPEdhcnlXYW5nQGFhZW9uLmNvbS50dz47IE11c2Eg
TGluIDxtdXNhLmxpbkB5dW5qaW5ndGVjaC5jb20+OyBKYWNrIENoYW5nIDxqYWNrLmNoYW5nQHl1
bmppbmd0ZWNoLmNvbT47IE5vYWggSHVuZyA8bm9haC5odW5nQHl1bmppbmd0ZWNoLmNvbT4K5Li7
5peoOiBSZTogW1BBVENIIFY2IDIvM10gcGluY3RybDogQWRkIHN1cHBvcnQgcGluIGNvbnRyb2wg
Zm9yIFVQIGJvYXJkIENQTEQvRlBHQSAKwqAKT24gRnJpLCBTZXAgMTUsIDIwMjMgYXQgNToxMuKA
r0FNIGxhcnJ5LmxhaSA8bGFycnkubGFpQHl1bmppbmd0ZWNoLmNvbT4gd3JvdGU6Cgo+IFRoZSBV
UCBTcXVhcmVkIGJvYXJkIDxodHRwOi8vd3d3LnVwYm9hcmQuY29tPiBpbXBsZW1lbnRzIGNlcnRh
aW4KPiBmZWF0dXJlcyAocGluIGNvbnRyb2wpIHRocm91Z2ggYW4gb24tYm9hcmQgRlBHQS4KPgo+
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBHYXJ5IFdhbmcgPGdhcnl3YW5nQGFhZW9uLmNvbS50dz4KPiBTaWduZWQtb2ZmLWJ5
OiBsYXJyeS5sYWkgPGxhcnJ5LmxhaUB5dW5qaW5ndGVjaC5jb20+CgpUaGlzIHY2IG92ZXJhbGwg
bG9va3MgZ29vZCB0byBtZSEKUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4KCkNhbiB0aGUgcGF0Y2ggYmUgbWVyZ2VkIG9uIGl0cyBvd24/Cgo+ICsj
aW5jbHVkZSAiY29yZS5oIgo+ICsjaW5jbHVkZSAiaW50ZWwvcGluY3RybC1pbnRlbC5oIgoKRGlk
bid0IG5vdGljZSB0aGlzIGJlZm9yZS4gQnV0IGlmIEFuZHkgaXMgT0sgd2l0aCBpdCwgSSdtCk9L
IHdpdGggaXQsIEkgZ3Vlc3MgdGhlcmUgaXMgYSByZWFzb24/IFBlcmhhcHMgaXQgd2FycmFudHMK
YSBjb21tZW50IGV4cGxhaW5pbmcgd2h5IHlvdSBkbyB0aGlzPwo+PgpOZWVkIHN0cnVjdCBpbnRl
bF9waW5jdHJsIGdwcCBpbmZvcm1hdGlvbiB0byBjb250cm9sIGRlZGljYXRlZCBSYXNwYmVycnkg
UGkgY29tcGF0aWJsZSBHUElPcy4gClRoZXNlIHByb2R1Y3RzIChVcCBib2FyZHMpIGFyZSBpbnRl
bCBhcHByb3ZlcyBmb3VuZGF0aW9uIGtpdHMuCgpWYWxpZCByZWFzb25zOgotIFlvdSBhcmUgdXNp
bmcgSW50ZWwtc3BlY2lmaWMgSFcgZmVhdHVyZXMgYWxzbyBmb3VuZCBpbiB0aGlzCsKgwqAgRlBH
QQoKSW52YWxpZCByZWFzb25zOgotIFVzaW5nIG5pZnR5IG1hY3JvcyBvciBoZWxwZXJzLCB0aGVu
IGVpdGhlciBtYWtlIHRoZW0gZ2VuZXJpYwrCoCBvciAoaWYgdGhleSBhcmUgc21hbGwpIGR1cGxp
Y2F0ZSB0aGVtLgoKSWYgaXQgd2FzIHRoYXQgdGhpbmcgSSBhc2tlZCBBbmR5IHRvIGtlZXAgbG9j
YWxseSBiZWNhdXNlIEkgZGlkbid0CmFncmVlIHdpdGggaXRzIGdlbmVyaWMgdXNlZnVsbmVzcywg
bWF5YmUgSSBzaG91bGQgYmUgdG9sZCB0bwpyZWNvbnNpZGVyLgoKWW91cnMsCkxpbnVzIFdhbGxl
aWo=
