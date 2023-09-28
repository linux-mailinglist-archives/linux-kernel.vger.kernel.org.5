Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F667B2232
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjI1QYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1QYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:24:22 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2075.outbound.protection.outlook.com [40.107.12.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399AEB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5p/xrv25xB7vvaX3oJ9jNOPG01WmWiQ/1SUToN+8J7nwgzn/S/oAEZO9O7jUmrBK4EpyCQP4LBwu+qYAa6sXFzThJEtMFDrvf01ytaR5geHkiBokVrd7ksZroaW4i97iNFtu2m/3JX3KmsUuxhCT7VWk4bvR/iTpMDWkOkwOqWsId0kuYVK9YqJBgJpZ7KV+nrePAfelI8GBHoQvGSYwQaC5vHmQ8+BKQ6/mCCvy5fsMNI6ipPAAIhk16hJuZJ5R3E/ex6OKdupXDXZWLYTcbIaCKKkKV2ZaQZa/MQGGOsqeWu217PQQYZ4b19VvtiOyV7McxeCq752osvAbVxcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il5bjxuAMEVfJvZH/7b2hQHGdJ5lt97vRWqLKesMgrQ=;
 b=bC8+w2U8b+JbRtDwHo/bXxLxw/ug9UhAo3Vsiq4PaPvcgje9JBhKNeDRN85fReNUspBMuGaEguF6XX8SjrfDm7pXwS8ueyXHxc3i4Xhzz95n151JYpccZzlt+Azf20+TduPpBayQhF2vI8OGt0YGgLLTt5JTbMc06jRl/WeA5Pv4Gp83HadypbaBFEOlfQj0bOkAN5MA3AFFeHIAWJUbvUXqtAiXK3eXvgCOH6v79ANsb+yoEVqUHUn0hshObYC3lipzlq+FFq1JQNX6Al61tCGSUNxUzqp+OnSGNsWji2CrtZX6ttfeDdKmTGHDkskowqx0e16zPExUfZZ/OQ/e1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il5bjxuAMEVfJvZH/7b2hQHGdJ5lt97vRWqLKesMgrQ=;
 b=IQadFI/UkCqYpZVq3C8cFvo3dGI9N4QuuVPHN9Q02pcnOXEYE54JbJh301mw+FyrIdi9QPcZCvnDK3Ex5PMK5GXwvafeDydaSCmTKE3mmC5Zz7FyMP7c4PH76IcXRkhJvpdDrltuJtFPTYBQxAjFK0YeGszu0FKpRkSWM5mSdJTQ+RpC/VfVC55A6J4teFYxmCZc/mwnoaExyenTy1gHg85dYGyvjH722F2XZ4y0X09GRlcBh5ReTvaonMlcg38SblTYMtj/FSx7ziT4yMFI0OIy9Kc6VJmq8ZMmyPGdLZ0pBsKRypbdUj/mwqk4HsogJxzPpOFW12iUPmfHfCf4MQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1607.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:24:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::27df:697c:bd7d:774f]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::27df:697c:bd7d:774f%6]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 16:24:16 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "jim2101024@gmail.com" <jim2101024@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Thread-Topic: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted
 DMA
Thread-Index: AQHZ8KIwkC6gffJFVEWantWEKIz6ZrAwbyqA
Date:   Thu, 28 Sep 2023 16:24:16 +0000
Message-ID: <f63dc670-1fed-26e0-ea60-aa19e6c87843@csgroup.eu>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
In-Reply-To: <20230926175208.9298-2-james.quinlan@broadcom.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1607:EE_
x-ms-office365-filtering-correlation-id: 0cbfe922-7f32-41d0-384f-08dbc03f5c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIA5eFxJmr3BdfDGmc4b8MhSCJ0pOLy4C0Pgy76UaJgg4OhIY6G0hVh9atxfnwXAiDVZ6TOPmSxwuSrVsa61R4pVg0BD86CsH9eiB2n1EAX1XgWw2WaXBjxdggYjcXC+maHQne5UyeOj8PZki03vZ1DKvGpA0qTwOSoiOEOKndnyKfSIqEf/qWL1Vl0QXN0xJdDvVCDTOF54tbQP+NmR96Fx4H+T7lBZ4UyF4+UGw9JtP6pOKb5mPlJLShcLFudl9VfOLudcT7v4Q07z/NxgD1Srt04UK38QSoiaH2oQmYUjjNm3dvHDu9IjQBlOaq7C6OUjUCAvbc/ZXpypn/sZD5XAh5RklNsDS28RkdtU4A8DFseiy1WhkVpcthhRUV0XFmw1LpGtKbq91s4QtC3jvKZpEP11vdt9/csOdxJTOh+JZJluRYb+ie3Fjf1AD6Gua5R7tMY2FY5c3TjDjRysHsUKtfJ7yIlSddDB6OAVhp52ifAL13x9t/093+YRUBugBsG8de1PaUGCdFSSaAS7dKgKM3GcG2TqzqMpVLhRCPHM7/f6tJWRhlz2sAEK7ySFPEYC2Jd56Q5U8Bm8WVCG7E1UGGqgtMJHRRVNpor+FSMEi+yPbllKh8xdnG5eaFhwZNzZnul2WHGrBhv+HfwbPEdScRx7bU0+sjVnmS3v2jPbCMdcPMiOidu9+ZUFc5+p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2906002)(316002)(41300700001)(4326008)(8676002)(8936002)(7416002)(36756003)(5660300002)(44832011)(66446008)(66476007)(66556008)(66946007)(64756008)(110136005)(91956017)(76116006)(478600001)(86362001)(31696002)(71200400001)(6506007)(6512007)(2616005)(38100700002)(38070700005)(66574015)(26005)(54906003)(83380400001)(6486002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExWb2FXUE1EbXpKQldYRDIwS3NLR0MzYnVkcmFaZXlrUkFHZEZTcFhxdkVB?=
 =?utf-8?B?OWNOeUVPWmVTbGVGcHhpYzArUVIzd2dFSmhpTCtoMjFzS3BNcHF4dElQSlNq?=
 =?utf-8?B?UmUreGZERHMvLzNxNTVGMlN6Wk41bDVkRWtyZkYzdjRkVjRuUldMSDJFMGRL?=
 =?utf-8?B?cDhHcitmQzVlT0xSMGN4MkdtQWdVYktnczJpWlZjTTlpdUdNVVpaTzRsUUtV?=
 =?utf-8?B?SFVSeTBESVhUZHV5SGxnMUFHancrV0tZdXdVbWJGLzNHVG1iUmxVbnB4Ym1u?=
 =?utf-8?B?R2huSlBlY1AzU2REOHhaL0c3dkYvdFF1V1IxVnJPdEc2OVhWYzlpd0U5Zmpy?=
 =?utf-8?B?QjhuZUw5Ungxb21zREV2RHFONnhaVlN1bDEwVTNlaUlxd2V2dFVXQWIwbWdH?=
 =?utf-8?B?cEgyY2w4VWVyRzd3VjZSczFETlFFdFNiRGY1OXdOM1lHR0J0bHRMM2lIREFz?=
 =?utf-8?B?Qnc0ZmVqMzA1MUY1eDhPSFZwS0hpbm1OSVNubkpPeUZkWlBkV3VFNS9mZTlu?=
 =?utf-8?B?QTR3TURCYWtlaUJuMExnSFlMZGlYY0dyL3hYQkFEQ05PK1QwSHlGeHpybmZ0?=
 =?utf-8?B?NUptREltWlVhVUFwa1ZyaUJycDU2QUxjMlVIV1lDMVFJSmNYN1hDK2hYSldQ?=
 =?utf-8?B?NHlXd0tYN0pPd0JWQ3QxRG1Mc1lNak1GaTlEVEZkSDBNN2JJaVNySXZFdUZK?=
 =?utf-8?B?aE9UbkEybmQzOGNJQXhjbkJpTWIzMlRmU2xqT0pWbUJzT0k3ZnpjZTBtNnFY?=
 =?utf-8?B?dDNIcjNmMGNTUzlsLzBidm95ZGZoMVUyTFAwM25CK3RYT0czS0pkN01iWmNE?=
 =?utf-8?B?NFpzQ2NiRVE5M2RUTXVkRWhySU9tQWNjb29aeWpTMFBBd1BINFpjazNLRUMy?=
 =?utf-8?B?SmIySmdVQ2psb2haS3BncVJ6amFwcFFXR2xxN0dKMjNmVElOK25SVlhveHFh?=
 =?utf-8?B?M3RFeHIvZVk1MHVpS2M3OGkxMFdVVWNlY2YvY3hrNy81OGlwanlvbExYZUhq?=
 =?utf-8?B?U0o3RkFpaG1uN2Y1QjI1QmpGRDFQOUNhdy9HL01XMHg5OW5rV0lMSkdVMTUz?=
 =?utf-8?B?MWd4RWpuQWNidDhaZVl5empuNlBNOFlnS0pqM2R4SC8zVzBNQXg2elQ3UFVN?=
 =?utf-8?B?SmM1M3V2dUIzaDVlQzZOZkJJV0xVcHJKeVNUL0p1OGo3bXNqUUhiaEF4YnBp?=
 =?utf-8?B?dGk5N1RNdklVRkloak1XdGRoaDR5dHl6UjNqdFVYcTdtaVBEU2w3Y0VKRDVM?=
 =?utf-8?B?andML0ZYdXNKN1cwRmpNcnVvWGtzdmUwS05saHFVWW51bklON0UyZFpnUDFa?=
 =?utf-8?B?YUlTT0JOejV0YkorSDYzVWsyUnJPVVF1bUdsSENZVHRZeTByR0Rzb2t0bFl6?=
 =?utf-8?B?ZlNXcEZxT0EzdEhOU3p2UFZEUWZ1VXFkUEhzRlFhUmZlOFZJOWNOcVV6UzZp?=
 =?utf-8?B?QUNMQ3hjNE9MRUxjb3B2SW1kT1pCSDB4Vk41ZEJUdVd3dFZoYUNzZks1TVJa?=
 =?utf-8?B?Vk45aTc1QmxUNmJQZmxPeWY2a0g4K2tqZVBKaTliWGRwbXdxem5wbEd4bkkr?=
 =?utf-8?B?OHNKS1Y2RC9Lc0FXWFpoeE41M0xiUkhOZFNMNXJFUlVqUENPSXNkbWhZQ3Rz?=
 =?utf-8?B?OFdmY2RhWXRwaU0rWCtPaXNpWkU0RHU0MjBlRlo4a2EvWkg5T2NCVzVkaVdi?=
 =?utf-8?B?K3VGZmtCcHlJcGFBbDQ1VGF6SGRCZ0RiS0FPaGx1SWJtZk9YZ3NBU0xUaEpY?=
 =?utf-8?B?STBHZktiOUlhNUFrempGdDY1MHh4U1YvdXRXOElYcWJKTGJHTXZYdndvejYx?=
 =?utf-8?B?cUVvYTVWT2k4TG5EWU1EMWFCTkpGKzNOd1FxRVlqUWZ4MGdKeTM4bVMvdmVP?=
 =?utf-8?B?VnpHS2JtbjBsemkwTXVMQjJvdFBUOGpJS1l2Y3ZiQlZUQ1d0RDZpbnI4VjVB?=
 =?utf-8?B?NEVTdExjcjhVZ3lEOUFHOXVSYUZnakIyWWxGSVZSbHoxVGI1TjZIeEZXa3Y1?=
 =?utf-8?B?U3RiZU9nSlFYM2l0U0JWNkkxeGdKaFBqNFpoaGw2d1hKdzUxczdSUGhjNkpo?=
 =?utf-8?B?cmJ3RHdCTGZjajhYeDdVSU9CaEVoalFDQ1UzMmM2TldWQzN3YWRsS0hhOGEv?=
 =?utf-8?B?SXRZRytRZkNIa2Q2bzRTYVB1SVFGVG1HSGZXM2t1czU0QjkwdW9YMGlMcnMw?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2519EE056E5934788EAECE3CAC4289E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbfe922-7f32-41d0-384f-08dbc03f5c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 16:24:16.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYP5E6d9lW6eGkOQYVK0sIJQQStbpGGZZ8zNf6Nt8cSoj+prE1YlaBfWNTuIfSCB7i99xOLgJZSAOdIcXufmef2hTjaVWCN9sweqi1G4V3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1607
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkZvciB0aGUgZm9ybSwNCg0KTGUgMjYvMDkvMjAyMyDDoCAxOTo1MiwgSmltIFF1aW5s
YW4gYSDDqWNyaXTCoDoNCj4gV2l0aG91dCB0aGlzIGNvbW1pdCwgdGhlIHVzZSBvZiBkbWFfYWxs
b2NfY29oZXJlbnQoKSB3aGlsZQ0KDQpJbnN0ZWFkLCBzYXkgIldpdGhvdXQgc2VsZWN0aW5nIERN
QV9ESVJFQ1RfUkVNQVAsIHRoZSB1c2Ugb2YgLi4uLiINCg0KPiB1c2luZyBDT05GSUdfRE1BX1JF
U1RSSUNURURfUE9PTD15IGJyZWFrcyBkZXZpY2VzIGZyb20gd29ya2luZy4NCj4gRm9yIGV4YW1w
bGUsIHRoZSBjb21tb24gV2lmaSA3MjYwIGNoaXAgKGl3bHdpZmkpIHdvcmtzIGZpbmUNCj4gb24g
YXJtNjQgd2l0aCByZXN0cmljdGVkIG1lbW9yeSBidXQgbm90IG9uIGFybSwgdW5sZXNzIHRoaXMN
Cj4gY29tbWl0IGlzIGFwcGxpZWQuDQoNClNheSAiIC4uLi4gdW5sZXNzIERNQV9ESVJFQ1RfUkVN
QVAgaXMgc2VsZWN0ZWQiDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbSBRdWlubGFuIDxqYW1l
cy5xdWlubGFuQGJyb2FkY29tLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9hcm0vS2NvbmZpZyB8IDEg
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29uZmlnDQo+IGluZGV4IDk1NTc4MDhlODkz
Ny4uYjZmMWNlYTkyM2NmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9LY29uZmlnDQo+ICsrKyBi
L2FyY2gvYXJtL0tjb25maWcNCj4gQEAgLTM0LDYgKzM0LDcgQEAgY29uZmlnIEFSTQ0KPiAgIAlz
ZWxlY3QgQVJDSF9PUFRJT05BTF9LRVJORUxfUldYX0RFRkFVTFQgaWYgQ1BVX1Y3DQo+ICAgCXNl
bGVjdCBBUkNIX1NVUFBPUlRTX0FUT01JQ19STVcNCj4gICAJc2VsZWN0IEFSQ0hfU1VQUE9SVFNf
SFVHRVRMQkZTIGlmIEFSTV9MUEFFDQo+ICsJc2VsZWN0IERNQV9ESVJFQ1RfUkVNQVANCg0KT24g
cG93ZXJwYyB3ZSB0cnkgdG8ga2VlcCB0aG9zZSBpbiBhbHBoYWJldGljYWwgb3JkZXIuIERvbid0
IHlvdSBkbyB0aGUgDQpzYW1lIG9uIEFSTSA/DQoNCj4gICAJc2VsZWN0IEFSQ0hfVVNFX0JVSUxU
SU5fQlNXQVANCj4gICAJc2VsZWN0IEFSQ0hfVVNFX0NNUFhDSEdfTE9DS1JFRg0KPiAgIAlzZWxl
Y3QgQVJDSF9VU0VfTUVNVEVTVA0K
