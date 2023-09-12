Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBF79D716
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjILRCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjILRC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:02:29 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2057.outbound.protection.outlook.com [40.107.9.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE544173A;
        Tue, 12 Sep 2023 10:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtFK6yk6lpLv6TsWk915ViDWyFwE1H/0coeaH7xBoHVJ19KIJ2lG6CWrMPa4xh2ydoMJnTp4L6GfV/XoS9MbvUVob3ctkq42ZLLaVBIiDSprr9c4+BIebjk6QM22Dv2+rr9SQcATMG5EEUVF7jUC0CkWk3cLquInzRTvr15glOwO3OafL6DtVBSQGlL4bYkUntKIFhv2Yhch5MQlOFlzcjygHq3k87MlX2rPRyPlm6WgRQeK9twrECrYwEaAScYPEilYsjd5GkJME/gNqh2bfAwd6CKco8cYkB765QG0qNb9hYYTV8cv4DvUc+/rwPR8zy9D7Kwr6gTwDMSJEXf74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSdzcrkoefqtVC/W3BOn27xtZqNIQ6Uo4dbyCjF9VS8=;
 b=Yy742YzRDHVtptG/qAHq7XXoy0fnH5vJWm4XOhy9H7MEh2ptOhc0cNg0+HsZVWqpoXK/CPOFWhMBtB0yvHkPrQdKMr3eb+AX1WbF8bp1FO1EK5evsSLKFvE1MkvR0PimjGgQeV0+YsgAnTMLPWonxEjmM3S8ywWkh+3Fq1CWcQoM6AWI3aF8k28ts+GQDwTmShKnHcmLJv2hqvzjh0qfeV0bctTrz/c4vXUD+ufznhWvRnRRS+SHrJoQeNdndPDF/yiBVvjiYKxjpcTfPVkHhTvvJ0B/j6j5tjJJ9NHvmWzjFa9L+LiV70ni1F+KpCH4NH9VX1ksIfiPpe8Z4GsAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSdzcrkoefqtVC/W3BOn27xtZqNIQ6Uo4dbyCjF9VS8=;
 b=V4ycWfwfK6NZ0GUYwtZWCtzR3BPU13JEDH4aLopPfu5v+LrWq4nbqOz5aabBcOmgQyaeM6pt2SaprLMf2JuuqGBvffQCkm4NQpiVtjnGasgPG9U1DByG4JrlP2Vh/usJ3ZAdh6Wa1pvb+ojckSFwF2C7nx8K/YTijO1pqLiKZ5NBQ6orLVuIhCPR1eKoXcHXpbsKnekYMTjL3Kl/bJfwh8PXmXTKit0+j0Es5vIgsrviqLV6Vm/egkLxjBq5Dos0CgnQP5LKcwwf3z1qS//RHA48+eZhcuQnUca+8t6LoCr07jbcMVrTs9tgrZLYVi8e8hSBET1hglObhTwhvpgeTQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3444.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 17:02:23 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:02:23 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Topic: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Thread-Index: AQHZ0jZLGonsLT7psk6V57DL3sI7p7ABi0MAgAx8eICAACGXAIAAAcAAgAAJOoCACD39AIAAi4MAgAACooCAAAHPAIAAAUwAgAAX4ICAAEH3gIAAE8cAgAAKbYCAABIXAIAAA7GA
Date:   Tue, 12 Sep 2023 17:02:23 +0000
Message-ID: <f12ba12c-4625-1b13-a0c8-376138d94b45@csgroup.eu>
References: <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
 <20230912154423.gcb5rzwzh4jbcaw7@revolver>
 <1189edca-9029-4c2e-ba71-b3a1c15b61dc@paulmck-laptop>
In-Reply-To: <1189edca-9029-4c2e-ba71-b3a1c15b61dc@paulmck-laptop>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3444:EE_
x-ms-office365-filtering-correlation-id: 36d95105-1089-409b-580e-08dbb3b2088a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqOH3vGLMQBvjf/mM9O1ODxy9hyJmG/y7T+QxKcP182CgtF4pmUpw2QPiVIL+6xdErabrmUZ0kn5FGEErtEEx/eyMjboRBdMGdxchCV5/+EYxFt1N8Bhn2bFhOUt9teoLp7snekhjPRwaggZtcNfMAfsKA7See2XZeXlZk/KMkwf6NK5hOc/z1BKJ5IEp7IexY1gWCWCBovOBLtzTfRlHHAQ5aEvirV1Ziyt4zYZtq9QCL/QmQXL/o8F7Ukj5TWZ7sVnfEdjX2vxjUN1jVQu8Ol130Lp76Df3+GZBSwFvn8SfDgI6A6Axa1QNtNquo4ZWXNwgPIpanIpJvYnKnq/btP9e8kws5r80B73CXmQKFZ0FAEuMbqYRA6V2ebry6BKws+gifMtw3KUWzLbZm4Fa7svIPAR/3hV1bZVfk7Bm8pB4odHDKXHx1TFerQV/J7iFMAoTk9mJmr3z2DxDDsrJbKLSa1DNk5uH/iGZIVlSDycQXPKZkBMsyj94PHNAfWp48vD1yX7oKGIvjpJV0b0xF0TENTTNC0r87wpRwq/HcRiGus9b3WfYZxrPb8mmE4q37qbSanxV/zNWr0t6iJYnHZZhO+31Y0AYAQFMnjQ+UVBn8/VKPmNCNzYacWP8+2P5a0tUb9olfh+k0qhMBP+KapG2mf7xWcNlxzTXwmS50bOaoUizyt6YyzySnCa06u7JD2NgQqpqH9LQZu12OcXNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199024)(1800799009)(186009)(6512007)(31686004)(5660300002)(71200400001)(6506007)(7416002)(6486002)(26005)(478600001)(2906002)(2616005)(44832011)(8936002)(8676002)(66946007)(921005)(41300700001)(122000001)(76116006)(110136005)(91956017)(66446008)(38100700002)(36756003)(64756008)(86362001)(316002)(31696002)(38070700005)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RLTGZJZzNLUnBMQU1lQThHSWVzVEF6VGtndjVZaTBFUXFvdUxBenpqaXlG?=
 =?utf-8?B?ZDQ5bEh1dVBGSHAyMlhHMkd5SGxVN0FzWEFvVVdKZ0pmZ0ROdENlcHY5bW4x?=
 =?utf-8?B?QjV4VXRZekR0dzlpTjAya2FPQUpobW1UbVhudm9aRzR4WllESStDVTNzSi80?=
 =?utf-8?B?SEd3c0pVckxnR2hPdDc1Mis4VmFnUWFTSGgvSDIrVHRHeGxMRWx6VGs0L2w1?=
 =?utf-8?B?L2hkeHNPN01RbWhpRFVBYVlhVnl4QU9wNGVmaUlwbGk5TXdaNlpSNy8vSW9Y?=
 =?utf-8?B?eFg1cll1eU5TY3Q0b2xPWWsvVVhENlliQXJJa05mbXVjRWJPc0pDcWExUklH?=
 =?utf-8?B?ZmpsZDNsZXB5UTA1Mnhwc1NzY09kSENxZlk1Zyt4Y2hIK3kvbTNyOHdGaVh0?=
 =?utf-8?B?WS9veFY0NGtrNW1LcnZMYXFRTW5JeFRtVTNDaHluUVI1YUdreVVZQjBwQjNO?=
 =?utf-8?B?MjBtSkNXVFQ0ejQrMlRGMksyblhFVWluSHQ4OG9hTTczSEFMUE9uNEx1MW52?=
 =?utf-8?B?eUVXNkNZMHlvcmwyWUZQejFNbzBZYWROQUNMRit1cTB0SG9Ja1IxZnh6VkpF?=
 =?utf-8?B?bjd0Q2xmcWNYMEFFbDZwek1lLzdoYjJrc0xsY0w0MnNCNkdnaDdRbWloUXll?=
 =?utf-8?B?eHN3d2xSOEU2Q2hFMzlRSUl3S01ML1RZS3hlV0YyK3VBUG1IRVZjWjd3Nko0?=
 =?utf-8?B?aXV0T0QzNVJQN0JaRjZVbGQyTS9RaC8xZEJGRDJVcmJXeVNVbzhveUVWbUVV?=
 =?utf-8?B?TitzWlM3aGRMNVBsVVdrNGJKZjd4L2tCSlF1d01yQ2tBZE1RRXZyOE0xNXBR?=
 =?utf-8?B?cEFrendiZWFCS1E1SWNwVWhpWUtpLzV2d1pzUXhpKzdrOENpRW92R0RHRFli?=
 =?utf-8?B?bmtoV0NBMHcwQ1VTbWVOSlphY0wwaDhLTk10MU00aURiejV5cCtDcVc3ZUJ3?=
 =?utf-8?B?c0I5S2pTSWR1MkpROGE1VkxqR1dqdk84bzMxWnhCb0htRGlQUnBWcW5yaFo3?=
 =?utf-8?B?UDdJRkV1UXI5Q2VxQnU4VkgyajFhMWZPRytSL1VENG9LOWx5SGFoWDlxRUIr?=
 =?utf-8?B?RUR1ZWdkVTRQYmh4SXhqaGhZYWVpMXg2MllVQlFiWkp3RjFRZW9iRFdSYXFD?=
 =?utf-8?B?V3ZWKy9RcEZvWHZ4c0FzeGttdWdFekRQb2lwWDMxY295enZxZlRWalpCU2p2?=
 =?utf-8?B?Mjh3WEdlRisxQ3BxZEJ5M0d4bllHdkMyanlGb0lzQTlGbjZkQzZ6S2hPTnR6?=
 =?utf-8?B?clhPRFg5ZEZodHUzVDNIRFQvNkh2QUJFWmN1UEJZQ1Y4YWRleDRUYmd3MlZs?=
 =?utf-8?B?c01nSUVGdHBTc1RMQmR4SzJFeXpEYUpFcWcyeVhBTXp2QVpOQTh5M25DTkhU?=
 =?utf-8?B?QVpvWjdQUFFQcExVOHZsN3RyVm03UWlDbG0yclo2NWt1UE5oNEpSYnIrOGlv?=
 =?utf-8?B?VmVTbWJndENOUllwSnRyYU43SUNVeWV2VlZpVE54N2VRWjZSQ1oxbEh4WnlY?=
 =?utf-8?B?dm5SOUlmdUdHK1NuNDFUMzdWa3Qrbi8wNWxTd1d1VTNnWEE4MVphdGNUa1A0?=
 =?utf-8?B?L3ZzSXQ1RGRPYVVNV0ZVbFdUblVhbERzUFR4TGRCUU1SSDJ2K1VJTUc3N2hy?=
 =?utf-8?B?UzRtWDBNTGFtYmNBd0RyL25aRTVscWl1VVl2YTA2LzFqaHlqODA5NFBJdmpC?=
 =?utf-8?B?TWFNUHhaUkNaVExJSVZBQTlZMWpVSkxaR3lmRU91YVlOTTQwZXpPZFFiSlNC?=
 =?utf-8?B?SldFZG5xNzBFOC9pVmlLY0toM0x6eTJ3L3Q2YkVNUDl5L0ZCYXhCZmZqenNH?=
 =?utf-8?B?OTB3UGo2NUMyREZVd1d2R2hmTlpxMmdtc3E2Q25JMHNWN2tnWFE3YjJyc2dD?=
 =?utf-8?B?ZFlkYklXK1BWUE0xM1NQR0R4eEJvZExmblBrTmg5VytPbU1YV04xVjFReVE0?=
 =?utf-8?B?NlFjYmpPck5hdm54TmtES2UzTXJLU1JTVXRqYnZzTTdWOGNHenJTR0RQRVVl?=
 =?utf-8?B?MDg1bmF3MklyZDF3MTZGRFBkYnIyaWtKOGJtWW5wd1FHZlI3anQ2YU9qZDJB?=
 =?utf-8?B?bmN5amFIeWhnYTF6RG9uVmFVeDV2dWNycTNTaDhkVjdTTU5qN092Tm9vdUtI?=
 =?utf-8?B?TkYraCtqemR3eEdTTDhsY0Nwc3l2blRNc0dHNU9Ua2VHZUpwdHdCVHBOY0E5?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4CD25C247D3DC479AB4243CA56D6E6F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d95105-1089-409b-580e-08dbb3b2088a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 17:02:23.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHaHaNR6wQDfSgjic/0z8SG7C3Rvj10PMREcOxP0k48kBZlmF+l5SipGy6CMIRZAljK/Up0HIGy/+BCAST3nOVwdX3uCDmQ9oBYTSHqpaGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjMgw6AgMTg6NDksIFBhdWwgRS4gTWNLZW5uZXkgYSDDqWNyaXTCoDoN
Cj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6NDQ6MjNBTSAtMDQwMCwgTGlhbSBSLiBIb3ds
ZXR0IHdyb3RlOg0KPj4+IFNvIG15IHF1ZXN0aW9uIGlzIHdoeSBpcyBpdCB1c2VmdWwgdG8gc2V0
dXAgaW50ZXJydXB0cyB0aGF0IGVhcmx5LCBnaXZlbg0KPj4+IHRoYXQgaW50ZXJydXB0cyBjYW5u
b3QgcG9zc2libHkgaGFwcGVuIHVudGlsIHRoZSBib290IENQVSBlbmFibGVzIHRoZW0/DQo+Pg0K
Pj4gSSBkb24ndCBrbm93IGZvciBzdXJlLCBidXQgdGhlcmUgYXJlICdwcmVhbGxvY2F0ZWQgSVJR
cycgd2hpY2ggZW5kIHVwDQo+PiBncm91cGVkIDAtMTUsIHRoZW4gSSBzZWUgYW5vdGhlciBvbmUg
YWRkZWQgYXQgNTUgYWZ0ZXIgdGhlIG1waWMgY29uc29sZQ0KPj4gb3V0cHV0LiAgSSBzdXNwZWN0
IGl0J3Mgc28gdGhhdCB0aGV5IGNhbiBiZSBhZGRlZCBhcyB0aGV5IGFyZSBkaXNjb3ZlcmVkDQo+
PiBkdXJpbmcgZWFybHkgYm9vdD8NCj4gDQo+IENocmlzdG9waGUgYXJndWVzIHRoYXQgdGhlIGlu
dGVycnVwdCBzdGFja3MgbXVzdCBiZSBhbGxvY2F0ZWQgZWFybHkNCj4gb24sIGFuZCB0aGF0IHRo
aXMgYWNxdWlyZXMgYSBtdXRleC4NCj4gDQoNCldlbGwsIHdlIGNhbiBwcm9iYWJseSBhbGxvY2F0
ZSB0aGVtIGxhdGVyIHRoYW4gaXQgaXMgdG9kYXkuDQoNCkluIGNvbW1pdCA1NDdkYjEyZmQ4YTAg
KCJwb3dlcnBjLzMyOiBVc2Ugdm1hcHBlZCBzdGFja3MgZm9yIGludGVycnVwdHMiKSANCkkgYWxy
ZWFkeSBwdXNoZWQgdGhlIGFsbG9jYXRpb24gYXQgYSBsYXRlciBzdGFnZSB0aGFuIGl0IGluaXRp
YWx5IHdhcy4NCg0KV2UgY2FuIHByb2JhYmx5IGRvIGl0IGxhdGVyIGlmIGl0IGhlbHBzLCBob3dl
dmVyIGl0IGRlZmluaXRlbHkgbmVlZHMgdG8gDQpiZSBkb25lIGJlZm9yZSBlbmFibGluZyBJUlFz
IGZvciBvYnZpb3VzIHJlYXNvbnMsIHNvIGl0IGlzIGEgcHJvYmxlbSANCnRoYXQgYWxsb2Nfdm1f
c3RhY2soKSBjYWxsaW5nIF9fdm1hbGxvY19ub2RlKCkgZW5hYmxlcyBJUlFzLg0KDQpDaHJpc3Rv
cGhlDQo=
