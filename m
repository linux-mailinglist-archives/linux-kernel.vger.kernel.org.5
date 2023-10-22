Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D47D2364
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJVOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:49:13 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2182.outbound.protection.outlook.com [40.92.62.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE98E1;
        Sun, 22 Oct 2023 07:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNsDM4EOn9vlw5L8Yki9RSu0lQJMjaFnxn/X38bi/WR8ALd8sCw/1ZDCh9BKWU3j/cYOzafCdyjgvH+uo5zApuKcpSXqzPzL86ABVpHaV5m9G9irA0gw1rve544Tw8ejl3pI2TwYXd+pVUWshRfCv9TjcFKDNXBgI4Dp4Bh5MA2f3piYYsMHc4mAsKw3IGPxOgE8Np0T1b8P2en8jge5hPmNVHCvJyHX9yPWw+9trw7yGG+IA0FigTZY6fItZjTPbXvcAbJaTtvNe/uuUhNNjyZO+Q2ffglwe7DLtzq6fGLcEiu/Fh3KW5aCPJFAw+6h7j2oSDJRt9GsmX6ZCIvzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERfhJrC+xtIZIz97DZHV9bQbOw4dujamvQHZjai5VGA=;
 b=RKjZraOnnCbmP9I84zEamgVWcRchUxqV7AvaeroT5aFg4nt1YYBJUi3+y+WzRna1oL4Y6mNeqk72bm/zg/4GzwfRc9SNz16NLIymQoW2NRYwYZl2hytdUL5ER482NrY8JqWgpPZ76Tmj9t2GdMt/fEMbrJMYPhcRQNE1pKPheOwaLTn1J73sqKHPrfCC7ypdK9VHCc1qj6yMYlxE8FUupgMpT6p9UcWU/CvNFF6mTO4RZh3TXT3u20K8Ku2dswZuVOWf9D+EsuYW7DcHAuB/B6BY+T0Bxb1+w9OpzUs4fbUFw8PnGBdb6fjEseb4zxXRgrp6nvosRuNAlaWgSCTm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERfhJrC+xtIZIz97DZHV9bQbOw4dujamvQHZjai5VGA=;
 b=KbZzMTHaTfkKDTSks+BdLjTnC0oQOTwpnuOrbufNuO70abXU53ZqFH304mLM4VL55PbP/5sFyD4LBhHyGQTG531JcCjXoZcWkgKn0WhwY6CY28ZQfa2kCpwh4lKgH16YwsgxFTdi7gvx5J3SSMWgrl1f3fpd1Wffhc/S9wmzyarZtZRSCsdqe84DOXYYzd6IcmYkC6DPWf0PBA1BjNzQzTK+xxU0u76256LCT/ZY2aNWWST3+TyiyEc9ME8Ngb7sWvCM+IZ8HHIIs08mfCKj+/nnv1tRzu4ZsI3kR+udGV9q9xDkDuzyshzEKScbafwtuzkj+55m7I1WmK8lO3vbnA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4453.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sun, 22 Oct
 2023 14:49:02 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8b4:a93e:f211:364b]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8b4:a93e:f211:364b%4]) with mapi id 15.20.6907.028; Sun, 22 Oct 2023
 14:49:01 +0000
From:   Jinjian Song <SongJinJian@hotmail.com>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "Lei Zhang(Terence)" <zhangl@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Subject: RE: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: AdoE9d51qkeKSsY1RaiHiunKsAwJYw==
Date:   Sun, 22 Oct 2023 14:49:01 +0000
Message-ID: <MEYP282MB2697E5CB0E3EAA119D1A1136BBD9A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7hc2hS7mqoyO1xB69JGf2xRtWT0uVls+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SY5P282MB4453:EE_
x-ms-office365-filtering-correlation-id: 4d6a5a30-4c17-44be-a672-08dbd30e0789
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+xTL9H/YoKvFJrMaIkLFMoEkgfgFglw2gUDKmf5ojrPxkvFzubkRS5T/eC5KXBnI8EUYtugRvpyI35j48yjZXq6sHQ6BuhDz+kC3z7L90WQhNLV7rp6FOPfQXO8BKVCUYOxdnIHbctFNnFVP8hVxgwqFcItNEh702XC9JOaS4ucyfADNS83rAoRKimJwpLmWkxLWG4wbcEzpdFbDFRdMKdJCy1R8dlMio4XRwIlEVr7ytZ3o8E9E6VTKYgbNm61J0oclyU7W1Gui/ryON9vII74Z0m5mOFFaRF+9vviQdLwP5gyHHUBspHG3pyFVU0yPXI/1TwepGWKCJC+sFg36WwBI9ZxAKQRKoHw0j7PkLRG5olEkWwkBxQ0mCp3r5AtPeFJ7WEohxl8CW5mKrmkO0gWVNfk5x2suYPRbOYJDeNel9zYoJEkO/WR4gMiH3Ef00GPGtJbNN5unvlj/QKY3/JJWbtVa5QfhQS8gJWhL8fT6mROnBenwsQt51w6RsKVn+gf7FBRP69rr2Nkyu9uRqU+ROMCSMJkwiHp8Ac4zJfOZKpWE5dOpKuB9wXLYJG0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHA5U2tnajVyd3l6U29kdGF3bldSTTVTM3UyV00wclNhejBpbzg2R0V3VlFk?=
 =?utf-8?B?ek8yTldlYkRuSXBaYU9kVEljUEROeWJzWnhwNFFRWlpYQWJIWVJHdzRBYVhD?=
 =?utf-8?B?K3NUMXltWXdSc3VMTGJnNjlBNjFHa2RCcmpXUWwwNjBiWEkySWZvN0ZDbHQr?=
 =?utf-8?B?a3UwQkhLSkZRRGVPbWx5UmQzVnBUZEZaQ21JaDFnYldvRUFsUGtqOW1BWjBT?=
 =?utf-8?B?eVFuSkRwNXV2NXI2TUR3NDVkbFNaZG5TNnVXc3dmcFFkV0ZYUlUxZFAxcG9T?=
 =?utf-8?B?R1VzN0lSQ25DUG5KUVpBa09QdTRqaXRPZWZMa252MG04aEZzR0lLd2dJVGdN?=
 =?utf-8?B?dWF0VG9CVW8yRG0vMkRucDhZWjF1T3gzTmdkT1FyNGlTYUdLOGdVRjlqa0hB?=
 =?utf-8?B?WTBRcXVjK2NGMlFEMXo3bkpKYlQ5UmFiWkFSV3JKMWR1cGt6Z0hhN2NoM0VN?=
 =?utf-8?B?QXl0d3daTGdIZERSV3BlL29tSGFjd0tQTTRVcG5NQTk1TXFidU9oWFlMUTJ6?=
 =?utf-8?B?Wk9JU0c1T3FPRThzL29McklPM3d3RnVxL01KZGlzSTI1YWRhV2Q2UEdwZHp1?=
 =?utf-8?B?Ri9nWkt2VXQ4bS9PZXRPUEQ3bGxkZlVnUFkyVXVqZzdvVHg0QVErbzFReVFR?=
 =?utf-8?B?aHZTaERrU2VocWV4T1E0YVIwY1lDYVQzOFJIbUlEb1BrR1Iremx2aDFMRjZ0?=
 =?utf-8?B?enpJK2JxT0pONU5iSllZRWZ6UTFidTlkWE1Ga1NYS0l5NEhMSjFmMFRaNnlS?=
 =?utf-8?B?a0pLcHFwSG1zN0tCdER6UUJPSy9xd0ZaVDlqeTB2TytHR1pTcGdtdWR1U0Z4?=
 =?utf-8?B?U01HUG90UWwrR1l2a3VmTGg5Rjk4U1VZY2lTWGd1ZFI1b0FUN3RiYzZvUjFJ?=
 =?utf-8?B?WUQwZ2xQYWZ1SFJYMmxhVjZjSjJZaTZEdzE4bEpUYXZwVUJZNFNUZ0syLzRm?=
 =?utf-8?B?TzBIb1F6TGliVFRPcEhWMkd1a2gvRmx0M2pTNGtqSG9iU1lWMVRodCt5YnV6?=
 =?utf-8?B?ZzZoV2NBaGdlUHFyelFmeVh5QWdvaGErS1dOTVhJZXk3UmpUbEdESnRJVUw0?=
 =?utf-8?B?US9XVC94cmFreWhYM0h6OEJPVG5uQi9GRDhVMDFCWnlvaExqc2VqaUMrRmp1?=
 =?utf-8?B?YnkrblJOSDUvaUJJb1V1cUtCRHlvYThwTEJlamtVOXdvZ0Uwd0RTcG5pZ3E3?=
 =?utf-8?B?d2EyN2V3T3hUV3VjWDZ1bXpHTzBnZkFtbjhKaGZ5V3F5d016Zy9JNzRhL1hG?=
 =?utf-8?B?SkJsUkNrSW5wdy93R3ZDZFFBekVxY2s3bHZFZ2lIY1FBc0llRzY5dEswK0ps?=
 =?utf-8?B?cXVXTVNMQWZBMmZxTVV2QkFiL2lMQU1TWE8ra1MzMktEWVJwSEhZOUZTaW45?=
 =?utf-8?B?L0w1elRTSXdoUXZhTE1EWm5iM1F6S3BneFl1bFZybDdKcEZkRERpRUF2bGFk?=
 =?utf-8?B?S05ZdEZQOHZ5cUdBL0FuQnJBR01KSTdWR3pSWW5Rb2w3cm9wNXU5alNQdHgr?=
 =?utf-8?B?aUF4cWIxRnVWazRrTmo5WnR4Vi9FVUxqckJnUWVzeE1kd2tVUGc5SHVjajBa?=
 =?utf-8?B?TmNBSHl0ZSthTytsMHV4WG4xUGgrNkx4dlB4MU8xUnNFbm9GTmxhaXFNZ3Z4?=
 =?utf-8?B?QXAwMVVlbGhKUjFMOVBydUZGb3Qrc1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6a5a30-4c17-44be-a672-08dbd30e0789
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2023 14:49:01.1974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFdlZCwgMTMgU2VwdCAyMDIzIGF0IDExOjE3LCBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxp
LnVzPiB3cm90ZToNCj4+DQo+PiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTo0ODo0MEFNIENFU1Qs
IHNvbmdqaW5qaWFuQGhvdG1haWwuY29tIHdyb3RlOg0KPj4gPkFkZHMgc3VwcG9ydCBmb3IgdDd4
eCB3d2FuIGRldmljZSBmaXJtd2FyZSBmbGFzaGluZyAmIGNvcmVkdW1wIA0KPj4gPmNvbGxlY3Rp
b24gdXNpbmcgZGV2bGluay4NCj4+DQo+PiBJIGRvbid0IGJlbGlldmUgdGhhdCB1c2Ugb2YgZGV2
bGluayBpcyBjb3JyZWN0IGhlcmUuIEl0IHNlZW1zIGxpa2UgYSANCj4+IG1pc2ZpdC4gSUlVQywg
d2hhdCB5b3UgbmVlZCBpcyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBtb2RlbS4gDQo+PiBCYXNp
Y2FsbHkgYSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgdG8gbW9kZW0uIFRoZSBvdGhlciB3d2FuIGRy
aXZlcnMgDQo+PiBpbXBsZW1lbnQgdGhlc2UgY2hhbm5lbHMgaW4gX2N0cmwuYyBmaWxlcywgdXNp
bmcgbXVsdGlwbGUgcHJvdG9jb2xzLiANCj4+IFdoeSBjYW4ndCB5b3UgZG8gc29tZXRoaW5nIHNp
bWlsYXIgYW5kIGxldCBkZXZsaW5rIG91dCBvZiB0aGlzIHBsZWFzZT8NCj4+DQo+PiBVbnRpbCB5
b3UgcHV0IGluIGFyZ3VtZW50cyB3aHkgeW91IHJlYWxseSBuZWVkIGRldmxpbmsgYW5kIHdoeSBp
cyBpdCBhIA0KPj4gZ29vZCBmaXQsIEknbSBhZ2FpbnN0IHRoaXMuIFBsZWFzZSBkb24ndCBzZW5k
IGFueSBvdGhlciB2ZXJzaW9ucyBvZiANCj4+IHRoaXMgcGF0Y2hzZXQgdGhhdCB1c2UgZGV2bGlu
ay4NCg0KPlRoZSB0N3h4IGRyaXZlciBhbHJlYWR5IGhhcyByZWd1bGFyIHd3YW4gZGF0YSBhbmQg
Y29udHJvbCBpbnRlcmZhY2VzIHJlZ2lzdGVyZWQgd2l0aCB0aGUgd3dhbiBmcmFtZXdvcmssIG1h
a2luZyBpdCBmdW5jdGlvbmFsLiBIZXJlIHRoZSBleHBvc2VkIGxvdyBsZXZlbCByZXNvdXJjZXMg
YXJlIG5vdCByZWFsbHkgd3dhbi9jbGFzcyBzcGVjaWZpYyBhcyBpdCBpcyBmb3IgZmlybXdhcmUg
dXBncmFkZSA+YW5kIGNvcmVkdW1wLCBzbyBJIHRoaW5rIHRoYXQgaXMgd2h5IEppbmppYW4gY2hv
c2UgdGhlICdmZWF0dXJlIGFnbm9zdGljJyBkZXZsaW5rIGZyYW1ld29yay4gSU1ITyBJIHRoaW5r
IGl0IG1ha2VzIHNlbnNlIHRvIHJlbHkgb24gc3VjaCBhIGZyYW1ld29yaywgb3IgbWF5YmUgb24g
dGhlIGRldmNvcmVkdW1wIGNsYXNzLg0KDQo+VGhhdCBzYWlkLCBJIHNlZSB0aGUgcHJvdG9jb2wg
Zm9yIGZsYXNoaW5nIGFuZCBkb2luZyB0aGUgY29yZWJvb3QgaXMgZmFzdGJvb3QsIHdoaWNoIGlz
IGFscmVhZHkgc3VwcG9ydGVkIG9uIHRoZSB1c2VyIHNpZGUgd2l0aCB0aGUgZmFzdGJvb3QgdG9v
bCwgc28gSSdtIG5vdCBzdXJlIGFic3RyYWN0aW5nIGl0IGhlcmUgbWFrZXMgc2Vuc2UuIElmIHRo
ZSBwcm90b2NvbCBpcyByZWFsbHkgZmFzYm9vdCBjb21wbGlhbnQsIFdvdWxkbid0IGl0IGJlIHNp
bXBsZXIgdG8gZGlyZWN0bHkgZXhwb3NlIGl0IGFzIGEgbmV3IGRldmljZS9jaGFubmVsPyBhbmQg
cmVseSBvbiBhIHVzZXJzcGFjZSB0b29sIGZvciByZWd1bGFyIGZhc3Rib290IG9wZXJhdGlvbnMg
KGZsYXNoLCBib290LCBkdW1wKS4gVGhpcyBtYXkgcmVxdWlyZSBzbGlnaHRseSBtb2RpZnlpbmcg
dGhlIGZhc3Rib290IHRvb2wgdG8gZGV0ZWN0IGFuZCBzdXBwb3J0IHRoYXQgbmV3IHRyYW5zcG9y
dCAoaW4gYWRkaXRpb24gdG8gdGhlIGV4aXN0aW5nIHVzYiBhbmQgZXRoZXJuZXQgc3VwcG9ydCku
DQoNCkkgdGhpbmsgdGhpcyBpcyB0aGUgYWR2YW50YWdlcyBvZiB1c2luZyBkZXZsaW5rIHRvIGlt
cGxlbWVudCBmbGFzaCBhbmQgZHVtcCBjb2xsZWN0Og0KMS5EZXZsaW5rIGZyYW1ld29yayBwcm92
aWRlIHRoZSBpbnRlcmZhY2Ugb2YgZmxhc2ggYW5kIGR1bXAsIGFuZCBubyBuZWVkIHRvIGRldmVs
b3AgY29ycmVzcG9uZGluZyB0b29scyBhbnltb3JlLiBGcm9tIGFub3RoZXIgcGVyc3BlY3RpdmUs
IHVzaW5nIGRldmxuaWsgY2FuIGRpcmVjdGx5IHJlZHVjZSB0aGUgY29tcGxleGl0eSBvZiBQQyBt
YW51ZmFjdHVyZXIncyBjdXN0b21lciBwcm9kdWN0aW9uIGxpbmVzLCBoZWxwaW5nIHRvIHJlZHVj
ZSB0aGVpciBjb3N0cyh0aW1lL3Byb2R1Y3Rpb24pLg0KMi5DdXJyZW50bHksIHRoZSBwbGF0Zm9y
bSBhcmNoaXRlY3R1cmUgb2YgZWFjaCBXV0FOIG1vZHVsZSBtYW51ZmFjdHVyZXIgaXMgbm90IGNv
bXBhdGlibGUsIFF1YWxjb21tIGltcGxlbWVudCBjb21tdW5pY2F0ZSBjaGFubmVscyBpbiBob3N0
IGRyaXZlciBhbmQgdXNpbmcgZmFzdGJvb3QgdG9vbCB0byBmbGFzaCwgdXNpbmcgdGhlaXIgY29y
ZWR1bXAgdG9vbCB0byBjb2xsZWN0IGR1bXAuIEludGVsIGltcGxlbWVudCB0aGVpciBob3N0IGRy
aXZlciBpbiBkZXZsaW5rIGZyYW1ld29yaywgdXNpbmcgZGV2bGluayB0b29sIHRvIGZsYXNoIGFu
ZCBjb2xsZWN0IGR1bXAuIE1USyBkZXNpZ24gdG8gdXNlIGRldmxpbmsgZG9pbmcgZmxhc2ggYW5k
IGR1bXAgY29sbGVjdGlvbi4gRGV2bGluayBjYW4gaWdub3JlIGRpZmZlcmVuY2UgaW4gcGxhdGZv
cm0gYXJjaGl0ZWN0dXJlLCBhYnN0cmFjdGluZyB0aGVzZSBjb21tb25seSB1c2VkIGludGVyZmFj
ZXMsIEkgdW5kZXJzdGFuZCB0aGF0IEludGVsIGFuZCBNVEsgYXJlIHByZXBhcmluZyB0byB1c2Ug
dGhpcyBwbGFuIGluIHRoZSBmdXR1cmUuDQozLkZhc3Rib290IHRvb2wgcmVsaWVzIG9uIG1hbnVh
bCBpbnN0YWxsYXRpb24gYnkgdXNlciBhbmQgaXQgZG9lcyBub3QgaGF2ZSB0aGUgYWR2YW50YWdl
cyBvZiB0aGUgYWJvdmUgdHdvIGZlYXR1cmVzKGN1cnJlbnRseSwgc2VlbWVkIGNhbid0IHN1cHBv
cnQgY29sbGVjdCBjb3JlIGR1bXAgZGlyZWN0bHkpLiBJdCBzZWVtcyB0aGF0IGRldmxpbmsgZG9l
cyBub3QgbmVlZCB0byBiZSBpbnN0YWxsZWQgc2VwYXJhdGVseSwgX2N0cmwuYyBmaWxlcyB1c2Vk
IGZvciBRdWFsQ29tbSwgYnV0IEludGVsIGFuZCBNVEsgZG9uJ3QgdXNlIHRoZSBzYW1lIGRlc2ln
biBpbiBtb2R1bGUsIHNvIGNhbm5vdCBkaXJlY3RseSByZWZlcmVuY2UuDQo0Lkl0IHNlZW1lZCB0
aGF0IEludGVsIFdXQU4gcHJvZHVjdCB1c2luZyBpb3NtIGRyaXZlciB3aXRoaW5nIGRldmxpbmsg
ZnJhbWV3b3JrIGhhcyBiZSBhbGxvd25lZCBpbiB1cHN0cmVhbSwgaXQgcHJvdmlkZXMgc29tZSBn
dWlkYW5jZSBhbmQgZGlyZWN0aW9uLg0KDQpTbyBob3BlIHRvIGdldCB5b3VyIGhlbHAgYWJvdXQg
dGhlIHN1Z2dlc3Rpb25zIGZvciB0aGUgbmV4dCBzdGVwcywgdGhhbmtzLg0KDQpSZWdhcmRzLA0K
Smluamlhbg0K
