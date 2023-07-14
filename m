Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDBC752F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjGNB71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjGNB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:59:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75730FC;
        Thu, 13 Jul 2023 18:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULjYaY2TWTAFBIxdg/SegTcRck51n5bvsmiCXS9T5UeLfnyp2zVTMwUMqfJlsWvi5xvQhuVeFY5gDc91UG7fabckVZCSMy0XfnrFEAKX3AkWamj6N427v/4pHobyAQbYnmQ7HsnsHDl9MaFYXJbSyl5CU33ms9P7DD7zKzXemlt3a1QdDjPlHjdyNc5j8l01DMVoMRmwLGQ+A+loX/Z1FE68gd/OwkHiqpoPDhRq6oQHTlIn8k28MpgC4Zj5GGBQ5a5YJczkdDsp1W6fExUnXSE6Bkcs1dVxXFRtSB9+3GiatIHdMa+Jk6JDt+X7Yidm0dxrTt2XQ1JB54aQrzp4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTqOBjtVFloFNlFCRK6VwSyADPtTTW9f6NvDJGN0l18=;
 b=KvWdEsTrJ9ApuwPCXLkzS63apZLeYAJnLhAAvsBNYu634CAruVRr8J7DzI5you0SoMueKAWDtP6yLPqptbWtrKOCkMj9amCXXMqpcYF9NEyvO0qs1mllSb4jEGwVGxivs1GmeLyWPQQlLkU2UL/qO/kors37rgzoBJ+YT0VwuyrEDtsquD5XvyojbU2lph6DpBxUk50iOC+YOFRiuBcKpveXkKgqTbHU5slhMIW7yItjU/iJZR7gSGQuuclvNv26UW0hiIhAg4wsVu8NwpeV/5wHzAwJL46zxTe279Bwwfz5J3U6JHhLSi6Agd8nE8o6oCkkkEQLB9lDZ7yed/rqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTqOBjtVFloFNlFCRK6VwSyADPtTTW9f6NvDJGN0l18=;
 b=qpcdlnR8f2c4Syc80dati/tOc0qI66452EOlVckrd2XgzU2w54dEfDAk3uL8+rQgtFf1fHH37ru83uM8YT3wSTLcYqHFakAEUnulT6r++7O3tB9idoIOwzqa5oxMNHrLLMHpCyjXQumM0D8URxyOtq5hze4ISBFyqvrU6pjOSZw2srX8uKVTKwaqE2GGLjfThRZ2Ou5+1eKs+aXSLi2gZP2TMHHkPUobz//Boud1L7i3f4ySv9clz6XzeViWPpdN0KG0+yYq5esJVmiIrwFYVD45NDOxr7I9O9Fzclk8tIGmHZj9OjWcOhcGMjiG5ZXnAsQI9MiXGpxwqk5QmsaL+g==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB4447.apcprd06.prod.outlook.com (2603:1096:400:83::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:58:28 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 01:58:28 +0000
From:   =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        "GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCBuZXQgdjFdIGJuYTpGaXggZXJyb3Ig?=
 =?utf-8?B?Y2hlY2tpbmcgZm9yIGRlYnVnZnNfY3JlYXRlX2Rpcigp?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggbmV0IHYxXSBibmE6Rml4IGVycm9yIGNoZWNraW5n?=
 =?utf-8?B?IGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ==?=
Thread-Index: AQHZtUxFdBcs7OOjzUWXxK9s8E8HO6+3MS4AgAA1ehCAAFzpAIAAvtDw
Date:   Fri, 14 Jul 2023 01:58:28 +0000
Message-ID: <SG2PR06MB37435D9B1A706460D8EDFCC9BD34A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713053823.14898-1-machel@vivo.com>
 <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
 <SG2PR06MB37438F03D13983B7F603E43DBD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <d83f5767-a98f-a258-f0c4-e7228345b93f@infradead.org>
In-Reply-To: <d83f5767-a98f-a258-f0c4-e7228345b93f@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|TYZPR06MB4447:EE_
x-ms-office365-filtering-correlation-id: f834f0ff-1277-43b9-c321-08db840dd16c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRhXE/mNwlM/dc9fKGglwPIYY5/TNlarSV9lKHWVIuBYLWYAqip1xVzknumNDqoh3mrQc7G6/h2R0qB5byHxmEIL3x7OOvFQNPkZoQUoajcnCNBYLatBYBZVi5h1nJffLsZfmonyuNbb+a6/GUQQ19D4O1kh69UbaOlFagNRsrC46oysotWuUlsZIMMobyr53g5Ztyx2/faXOhC1oekS9waDUjfqn3i3zduXvFu38hBGmUTnWPRKMaHbhZxtNHj32mmIVx5felqKAYGB1xK6SCFWAQqGMDVCoRLoGKBo78g36QCboLflyXg0fKqojr0mqEQPKpf2BxLBAhQU642gDD+adq7KyQS8y+ImcKm2lBhoUU5xfKy4xIbbo94c+ltGRpNf3/lROAYBaqyPmFQCa/wMIeUiTp/y+z0xHe/tCRU5/I85xxnV7O6CNsYfMP6l6+3Cfw/Wj1JdchZA5+ZsqHZ387+7YzIo+M/D/IhnXxtSsALNX83kojClsiFmzRSEGVLvtIA3Hb5m6J+kiyLN0P8Siy+KIWa5ZS/dK8KguMXP/Ernl0wD68VXU4U8/KEIBdXjZALFQXJ10DhTUKigoxLBuWcggSlsjfeHnvNpoegQulQk4Yi18hiWAFydMfde
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(366004)(136003)(396003)(451199021)(2906002)(54906003)(478600001)(71200400001)(7696005)(224303003)(8936002)(85182001)(7416002)(76116006)(66946007)(41300700001)(66556008)(4326008)(6916009)(66446008)(66476007)(64756008)(316002)(9686003)(83380400001)(38100700002)(55016003)(122000001)(966005)(52536014)(6506007)(33656002)(38070700005)(5660300002)(86362001)(26005)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elRxV1NNc2dBMHhZa1BwcTZoWnA3Z1lLZ1VMN0NudlJFVmZNalZ3VTRJMWw5?=
 =?utf-8?B?YkdrREhkcXdVdG15aVVJaWtldkxKU0VIOWJHdldNNkhXbDJrUDc2QXlubExU?=
 =?utf-8?B?MHBCT1I0bVR2RG9rUFZoc1VIdGdYeW02VlAzakZOZ0hNME1oUDJZZk0yWVhj?=
 =?utf-8?B?NDZqbW9uR01ZWVZ0cGNTdGVNUE5YN2h0Si9IZk9va0FkRW9xWWpWelFjRWlX?=
 =?utf-8?B?bmN2bk01RVBZTG1DbUx3S3hSK1RDQmdTM3RsV1BOK2hGZ09QSVIweG81dWQx?=
 =?utf-8?B?THF6TXpYckFFOENaYUZocWJwa3I5ZE91MWJmeXpJbWlBcUFJODc4U0ZSd2sz?=
 =?utf-8?B?ekFHWnphR0F0bERmYVNuMUtlb1FBRElKSENsaTB3bVR0anlxOFhRWjdlNGtk?=
 =?utf-8?B?T20vSGgrbzJhYWR1SG9odmo2Um1FVFN6T0UwbGN1ODU1RUlJOHNBeDlkVTJH?=
 =?utf-8?B?REpOWWp1WHdLYXJUVDFHd3lCNUdRQlZtSXRnRnJ0VXllb0xmVlBtSW9CS1hx?=
 =?utf-8?B?TmE1R1E3bmY2TDgyR3l1b2FyMmJtcW1zR3llZUdjemV6Yi9FN0VjOGNoeDZv?=
 =?utf-8?B?Q3NtMW9uV1JWSU1YblRKeGVGeFJFSllvVWRiN0VLdjF4blRyNjVmU2hORm9K?=
 =?utf-8?B?anZxQTcwck13aHl1UmZDUDBqamxxNmNYRUQ3VENVa3NCTUxQYmY5YlRjbnBa?=
 =?utf-8?B?VHYvajFnVVVRTnFoUUJsM3lOdDJxbEZncSt3bVprQkI2TXZQOXQ3NXllNnhH?=
 =?utf-8?B?eERCT0hEejhmYUdFdnpEN1c0cm54bHBNYmtlNS9PeGNUVXNQcUl5NjZRMWRx?=
 =?utf-8?B?bWpaWndVT21mZmFmVkNCeGxiU21pTkhEZmdjM3JBNW9QVEpiQkc4Nk5yVVQ0?=
 =?utf-8?B?SlRWQk5HeGwwN2dBNXltUGp5RW5WQ0dxb21mLzJuek1jbnJGTUtCbHZWa2NP?=
 =?utf-8?B?YkZHRWlkNW5odjBITWlVdDBFWndkU042enlkYWttWGpFdmIxajE4eUVxa3cr?=
 =?utf-8?B?anpOTTZLemorOXBUWVpqTHMwMWZ6dUhHRHVFUHlQTTFuOWhhUmZuQVA3S2pa?=
 =?utf-8?B?Qlg4cG5PVjJYdVFWUk1Rd08wNGwvNVN6QzZJZ2hTV2Y1WndGbHd6SWpmUzlq?=
 =?utf-8?B?bFBkUVZKZzc5czlCam5jS2ZTNGFJQmhPU3I0UWliejVDVlhhQVVZNWFza3pN?=
 =?utf-8?B?Vld6bnJWYlRlazBjVWg1Y29INkYrTU9seG80QVVFOVdkNXN1VFhsd3pYRk1E?=
 =?utf-8?B?bDQ3OUU4aHJvVGN4UW9rbDVpMnBHeEpCc2VWbERyR1hPZVRCV1lwbzV5cEdx?=
 =?utf-8?B?VUcwVlRUeU5lR2FEU1pOUi9CY29jTzFYZmg4M2FqbHFUSThmWXkxeFpSRER5?=
 =?utf-8?B?cTFPUXVKbVhldjE0ejNHSjFCUHJ2bC9GbG9pSEtaSkNZeGtlNG5BU0dWL3Rw?=
 =?utf-8?B?M0FrSDJRMnpyeTd6V3VmM2M5RUc2ZkVRRWZEb045amZJY3ZMMEExdSt6R09w?=
 =?utf-8?B?UURrRE9vUXIvbkxZdk5TU0lxNVBpbElQendsREJna0dCQ3lZQUNobHUvOGNr?=
 =?utf-8?B?Q1ZLWlRoQWRPQnZWNVpMcW9nZTYyR1pRUk85WmxLSnc0Z2pYS054dXRadHEx?=
 =?utf-8?B?cmxpWWkyY2xjcW9XSTlPTzU2bWxrVm8vak56YXp0QXMvejF4MkhCa1FhbExJ?=
 =?utf-8?B?V2xQcGhzaCt6V2ZvemNVb0Y1TWtveVVUWkFJVDZ4bG4zdCtLU2FmS1Y1YmVl?=
 =?utf-8?B?azhVZ2RTZHFncGtBVVJKckN2THY4U0lRN1JDRlN5RTNGOUxzMnhRN0pXN1dQ?=
 =?utf-8?B?blhML2IrTGVQLzNSM05oY3UySXMxWlVLaEZvV3F0dHRxRjk1dWZkdTJ1VkpJ?=
 =?utf-8?B?SzZ1VmpUa2VHRFlpMFd3ZEd3Z0hBNW5nRFJqeCtGbURIMERFdVVEOWJnMW5q?=
 =?utf-8?B?cmkxSk5XKzAyVGxIb25OaXZrYVBoZzNGMXJKSlFtM1ZvUVJIMHk5RnJKaFdV?=
 =?utf-8?B?TkwyZDNtVEVWK2F1MzJuVU02VExnSDJFTVdEZTN4dDZnNHZpKzhIMThmc2E3?=
 =?utf-8?B?OG1XWnF4dzVZbWVqcVkyVGRIejU0cE9OQ2U5bFUzd0Z0cS9hUnhaZHFJQUF5?=
 =?utf-8?Q?LVeE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f834f0ff-1277-43b9-c321-08db840dd16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 01:58:28.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GrU7N2DCAw/qykdbV13dzp7K+kWKwP3McjZjNTplKaQhn9lnIb2Me0586vy+7DHjz5sgSXEskM/JiJy0UlKSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBJIHN1Ym1pdHRlZCB0aGUgbmV3IHZlcnNpb24geWVzdGVyZGF5Lg0KUmVnYXJkcw0KV2Fu
ZyBNaW5nDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUmFuZHkgRHVubGFw
IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0N+aciDEz5pel
IDIyOjM0DQrmlLbku7bkuro6IOeOi+aYji3ova/ku7blupXlsYLmioDmnK/pg6ggPG1hY2hlbEB2
aXZvLmNvbT4NCuaKhOmAgTogUmFzZXNoIE1vZHkgPHJtb2R5QG1hcnZlbGwuY29tPjsgU3VkYXJz
YW5hIEthbGx1cnUgPHNrYWxsdXJ1QG1hcnZlbGwuY29tPjsgR1ItTGludXgtTklDLURldkBtYXJ2
ZWxsLmNvbTsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEtyaXNobmEgR3VkaXBhdGkgPGtn
dWRpcGF0QGJyb2NhZGUuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIIG5ldCB2
MV0gYm5hOkZpeCBlcnJvciBjaGVja2luZyBmb3IgZGVidWdmc19jcmVhdGVfZGlyKCkNCg0KDQoN
Ck9uIDcvMTMvMjMgMDI6MDUsIOeOi+aYji3ova/ku7blupXlsYLmioDmnK/pg6ggd3JvdGU6DQo+
IE9rLCBzbyBJIHRoaW5rIHdlIHNob3VsZCBkZWxldGUgdGhlIGNoZWNrIG9wZXJhdGlvbi4gV2hh
dCBkbyB5b3UgDQo+IHRoaW5rPyBJZiBpdCBpcyBjb25zaXN0ZW50LCBJIHdpbGwgc3VibWl0IGl0
IGFnYWluDQo+IDogKQ0KDQpZZXMsIHRoYXQncyB0aGUgaWRlYS4gVGhhbmtzLg0KDQo+IE1pbmcN
Cj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjPlubQ35pyIMTPml6UgMTM6
NTANCj4g5pS25Lu25Lq6OiDnjovmmI4t6L2v5Lu25bqV5bGC5oqA5pyv6YOoIDxtYWNoZWxAdml2
by5jb20+OyBSYXNlc2ggTW9keSA8cm1vZHlAbWFydmVsbC5jb20+OyANCj4gU3VkYXJzYW5hIEth
bGx1cnUgPHNrYWxsdXJ1QG1hcnZlbGwuY29tPjsgDQo+IEdSLUxpbnV4LU5JQy1EZXZAbWFydmVs
bC5jb207IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IA0KPiBFcmljIER1
bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgDQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEtyaXNobmEgR3VkaXBh
dGkgDQo+IDxrZ3VkaXBhdEBicm9jYWRlLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IA0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOaKhOmAgTogb3BlbnNvdXJjZS5rZXJu
ZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggbmV0
IHYxXSBibmE6Rml4IGVycm9yIGNoZWNraW5nIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ0KPiAN
Cj4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20gDQo+IHJkdW5sYXBAaW5mcmFkZWFkLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMg
aW1wb3J0YW50IGF0IA0KPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmlj
YXRpb24gXQ0KPiANCj4gSGktLQ0KPiANCj4gT24gNy8xMi8yMyAyMjozOCwgV2FuZyBNaW5nIHdy
b3RlOg0KPj4gVGhlIGRlYnVnZnNfY3JlYXRlX2RpcigpIGZ1bmN0aW9uIHJldHVybnMgZXJyb3Ig
cG9pbnRlcnMsIGl0IG5ldmVyIA0KPj4gcmV0dXJucyBOVUxMLiBNb3N0IGluY29ycmVjdCBlcnJv
ciBjaGVja3Mgd2VyZSBmaXhlZCwgYnV0IHRoZSBvbmUgaW4NCj4+IGJuYWRfZGVidWdmc19pbml0
KCkgd2FzIGZvcmdvdHRlbi4NCj4+DQo+PiBGaXggdGhlIHJlbWFpbmluZyBlcnJvciBjaGVjay4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIE1pbmcgPG1hY2hlbEB2aXZvLmNvbT4NCj4+DQo+
PiBGaXhlczogN2FmYzVkYmRlMDkxICgiYm5hOiBBZGQgZGVidWdmcyBpbnRlcmZhY2UuIikNCj4g
DQo+IENvbW1lbnQgZnJvbSBmcy9kZWJ1Z2ZzL2lub2RlLmM6DQo+IA0KPiAgKiBOT1RFOiBpdCdz
IGV4cGVjdGVkIHRoYXQgbW9zdCBjYWxsZXJzIHNob3VsZCBfaWdub3JlXyB0aGUgZXJyb3JzIA0K
PiByZXR1cm5lZA0KPiAgKiBieSB0aGlzIGZ1bmN0aW9uLiBPdGhlciBkZWJ1Z2ZzIGZ1bmN0aW9u
cyBoYW5kbGUgdGhlIGZhY3QgdGhhdCB0aGUgImRlbnRyeSINCj4gICogcGFzc2VkIHRvIHRoZW0g
Y291bGQgYmUgYW4gZXJyb3IgYW5kIHRoZXkgZG9uJ3QgY3Jhc2ggaW4gdGhhdCBjYXNlLg0KPiAg
KiBEcml2ZXJzIHNob3VsZCBnZW5lcmFsbHkgd29yayBmaW5lIGV2ZW4gaWYgZGVidWdmcyBmYWls
cyB0byBpbml0IGFueXdheS4NCj4gDQo+IHNvIG5vLCBkcml2ZXJzIHNob3VsZCBub3QgdXN1YWxs
eSBjYXJlIGFib3V0IGRlYnVnZnMgZnVuY3Rpb24gY2FsbCByZXN1bHRzLg0KPiBJcyB0aGVyZSBz
b21lIHNwZWNpYWwgY2FzZSBoZXJlPw0KPiANCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2Jyb2NhZGUvYm5hL2JuYWRfZGVidWdmcy5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9icm9jYWRlL2JuYS9ibmFkX2RlYnVnZnMuYw0KPj4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9icm9jYWRlL2JuYS9ibmFkX2RlYnVnZnMuYw0KPj4gaW5kZXggMDRhZDBm
MmI5Njc3Li42NzhhMzY2OGEwNDEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9icm9jYWRlL2JuYS9ibmFkX2RlYnVnZnMuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvYnJvY2FkZS9ibmEvYm5hZF9kZWJ1Z2ZzLmMNCj4+IEBAIC01MTIsNyArNTEyLDcgQEAgYm5h
ZF9kZWJ1Z2ZzX2luaXQoc3RydWN0IGJuYWQgKmJuYWQpDQo+PiAgICAgICBpZiAoIWJuYWQtPnBv
cnRfZGVidWdmc19yb290KSB7DQo+PiAgICAgICAgICAgICAgIGJuYWQtPnBvcnRfZGVidWdmc19y
b290ID0NCj4+ICAgICAgICAgICAgICAgICAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9kaXIobmFtZSwg
Ym5hX2RlYnVnZnNfcm9vdCk7DQo+PiAtICAgICAgICAgICAgIGlmICghYm5hZC0+cG9ydF9kZWJ1
Z2ZzX3Jvb3QpIHsNCj4+ICsgICAgICAgICAgICAgaWYgKElTX0VSUihibmFkLT5wb3J0X2RlYnVn
ZnNfcm9vdCkpIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfd2FybihibmFkLT5u
ZXRkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImRlYnVnZnMgcm9v
dCBkaXIgY3JlYXRpb24gZmFpbGVkXG4iKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm47DQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg0KLS0NCn5SYW5keQ0K
