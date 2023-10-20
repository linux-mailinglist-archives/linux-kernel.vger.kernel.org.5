Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9837D0D81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376944AbjJTKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376791AbjJTKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:40:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7ECA4;
        Fri, 20 Oct 2023 03:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTwbtUUNmaK7RwUoyjatqDYBpqqLatblnbsWe8Vg2wsUCOaI95OxkP6e4ClZfJhC3VFkqsNSJgbKUMgIZ/X6Vgct9Nm/80DjLehBSa59ZgP0xCChJpvDghYMGrNVtvK2VcRYuXLJOOJPUpyI7S+G56lUzs2+eLuGQPR0hncnur7A751MnmcXeRVimJuQMOttrQojhed+aVLXgBTJo9hEal1XARKcsDvtTKXlAKHUEwXQQ7GMMSuzHr6N9dWj1paTlOkAI4TM176gQsTP+Lt3k9s3HUou0UTFh29z3R+HHo8r+G44QAXGMwITmMDh4vMYEx+WTBLARqBo4RHGwZc4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HikbV69RKu2L2QFG3sRMAlgug45kIExmkj7Zf0TGdHI=;
 b=DXQx0EEb79zoLqb5Qib5FuiiXHmL05rzHfFo2qPMe2NUAzzsbn/ubKVf8bucF58uRphpOaiBrKeUSQn88fpqUE1wmoMKuHn7Fr+QgwMshWe6+iL4w60FAYq5pRiIgRU9uZHlJQaiEE4gQsFomFiH0XMVRzEKdPzw5VQsGwfU1zSyBM3N0D7G0kdy/zq283PYgiETg5m/096cp7xHwIZqvY+m1c4S4AtYhxj5vEFaNMzOUiKMggJl4i7JbPZs7gqdyldV7SOA5TPDgaGDPq1/J18HmP9D/D9nylHhxr+YWzc5Hc4X8lTaPB5aWN4lhyiGpMnigycS2+nfk3jRMdsZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HikbV69RKu2L2QFG3sRMAlgug45kIExmkj7Zf0TGdHI=;
 b=VkU14mU1Ov4LQAkq6Kn2vJzzZYnoT9IGPuLjUyEMt8XFonlMnFMS7C7/PFmMPzoILtSZ6pNckLpvCgw8CWzBxCIbef5A5qQ9QsYDewlDqf1lvYfrQr9iGUk7hZRh2AAY8qp5C6MMfCXyTKYbAS6s8PwP41VFp4KvLR9slU815BE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 10:39:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::42ba:c439:3f15:6a10]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::42ba:c439:3f15:6a10%5]) with mapi id 15.20.6933.008; Fri, 20 Oct 2023
 10:39:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaAdM0/dESl/H2fU6IdWZad5bt0rBSfrZA
Date:   Fri, 20 Oct 2023 10:39:56 +0000
Message-ID: <AS8PR04MB840464A53BB6FB11FE25EC9C92DBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-3-marcel@ziswiler.com>
In-Reply-To: <20231018145540.34014-3-marcel@ziswiler.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM9PR04MB8083:EE_
x-ms-office365-filtering-correlation-id: 32323d4e-419b-42da-6f32-08dbd158e6ce
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWQZgKhTqPp/F9Yb1wT/nQ8aaOOsdpJv0qC5AOZAlwFSpHk3jnuDjElHiHCs3iaLzPnzyJd3QFA5CudyHw2F7p8Ih43DLRKA/TwH9360muhnCagsIN+T6nTV63PU1/rYJTHUn5ppWDEwe1eawvgep6ys0MK5qDh16soqCZE6d70gPoGO5e/yHN4YP9a+jNBINkQGgTFjrgk3v0P1sZKNRM5JBlFAMutJFAKw2y33b38HF8WUhJBL2+EcC8N+fAR+WDcPfw7vakP9G7ulXyRNoZW/dg3CpDNyG5dWMGzFMsQS4rn1I1BQQOwNGy8Yb2rw8Sohd2ev3it5/wEVWJmtyTf/OWigY43VfG8ERybb/kiFtyCOHrBMWK2RUNpzDIfjXkxAbvcPQJOUaboHlnflcJ8ey7LN6cOAE/EglyjTEeBlyJtLYjswAngpxLZWw4Sak41XWr50XgQ/xlLj6YpqUz/G3PKYeJP0xVBN0wICXZdKYGV1zXOJi7Kz59NVB2MOZ4h+e26j70pypBVAWAeATaEMLNckhbBVA++hoG4fR4vP8HWJlETRYmQY+qbyAhev5RkVB7KWceY1l1Wq3AMNaOi/03KItWnXOHX4O2O65wi11sXNlTrcmktaeRhdNlva
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(55016003)(52536014)(8936002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(110136005)(316002)(8676002)(54906003)(71200400001)(478600001)(33656002)(4326008)(44832011)(5660300002)(41300700001)(2906002)(38100700002)(83380400001)(53546011)(7696005)(6506007)(9686003)(66574015)(26005)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yjg5cTYyRjVJNnF5dzNRK2hCS0dYNmd1eXd2UjZpa1A2Uzh1MzVzMDBxQVpm?=
 =?utf-8?B?SHEybEMySHNwY0hMZmRXSmp5SXRBUjlVeitRaXFQOWIwQThwTWdiYjZPb3BG?=
 =?utf-8?B?OHJUY3dOK3NKSzJmMmxET1FKRVJzcDV5WSt2cFZnK0VQREhmMUlyam4yRVJC?=
 =?utf-8?B?R3JMb29iUUp5UlpJL29OeEM2Q0dVc2x1YUpjQUJzaXBYSGd6d3VrQ2pCTlBL?=
 =?utf-8?B?NzdWb3o0eTVhU3hWNWp1d21kRWwyTHN0RmFUUkVBdjBKSFNOL216MjJudkJU?=
 =?utf-8?B?WWNvaW9EbDNZbWNkZ1pSbXgvNnJWTWxwNGc5K1o3VkQwQWtxK05QSDJqQnJ0?=
 =?utf-8?B?MmFWbG9tZ05WVjBqOFFBY3lNcDZNNy8vSW9nZHhyYXN6ZE11dHdoVmdUNkc0?=
 =?utf-8?B?NS90RWZLcU5Xa0huOWYrcHRTYkY0ZWFOMzdhMnN3TWhxRWpndVVoeUFsd3NT?=
 =?utf-8?B?VnV0a1BXL0ozNnFEQVFUZEtwMHFlOXh5ZzBNaHBEWDluZFVrRStrVmdURm9T?=
 =?utf-8?B?bUxGUW1TS1V1b1FQdkJQMXd6MWhoSjc4NTNVNFFaNWh2dGpJMXNSOHRNOWty?=
 =?utf-8?B?UWlwMkpnMU80d3ViUU9uQVlIU2tzZ05sNk1JYkx6RmRzSk1HeURiZERRK2xv?=
 =?utf-8?B?ZFVmZFFhTXhFeFM1RzJGbGJNVjJCV2l0SjJYVEZwRERQelVzc0I2S2I2SHc0?=
 =?utf-8?B?bnBXdTk4YlArZ3VQTy9HVDRWQ3VBOFNWekJJTm9Bby95NTh2SVF6VnVqWFNx?=
 =?utf-8?B?V2xObGQ0ZG5RQTBwTDdFeGxRd0Qvb2IzbHhkRXdpbDJ5RDJzRlphNnpYWFpI?=
 =?utf-8?B?RUQzZWtITWR4dFdVVEpzTitzZGdXNFdmMTZTTUJMWmpzcTRkTXM1d3UrOS9j?=
 =?utf-8?B?b3daWmY2UHBCYjF6ZkIzcjM4dEFsMVZNQllFblUrVnlnUVcwVERzdFNFZms1?=
 =?utf-8?B?bHIzV0xadzFuZVZsOG9RSUpaRWlybkljdmJ5UnVBZ1NsVHRwalEzRlIxbHh4?=
 =?utf-8?B?SW1BUHBtMWRUNmdSWGwwWGdPbmtrYjZLdnZ4STY1L1haWjVRTHhTM1o1WlJU?=
 =?utf-8?B?cGpNRDlzcE1ueUdmcWRiU0FnWG1nMjdQLzVWdjhSODh1bi90ZVNXNHZpVVVo?=
 =?utf-8?B?OTg5dnpZRlZYWmlVcUtwV3JIaWptdHhjRTZPWW44NXlmNFBVQUl6UkpRK2JY?=
 =?utf-8?B?UEl2azlsaTQ2RFhvZ3JFWC9RUkV3Rkl1STVyL25wQVVVZWxDMnJDUnNIWmIv?=
 =?utf-8?B?VUxaN3NPc1JFM3IwQVlHY05ValJlZHRCYUtiYjlDeGNoODN1WFNGV2VvQjRq?=
 =?utf-8?B?TTEybFltUitrYzRLcENpN2lzZHBwNkVQeE9lR1VIbG14aUtrVE9BU09hMUJP?=
 =?utf-8?B?S0h0NmUzYUFHaG4rVC9EYzdSREl5VHVGWVQvRWs2eVlhWGpYdmVSZVdsTnU2?=
 =?utf-8?B?RFF1MVdTRGd6cnM2aFRVTDk0MDB1RnJ1OXJRWjJ3c3hZZ2lGYnkxaTJjS1FH?=
 =?utf-8?B?cEVIMFQ2UGtZUWlVNEt0UmVTR2RRWGc0MEZENyswckFQSW0xVlRiZktSZEFy?=
 =?utf-8?B?aGNuOHNqVkNLUHdEV2xUZXFPTm04VWhLYUZTMERTTHhsci9ReFdXaVpKVzcw?=
 =?utf-8?B?SnpZUnlhUzN3UDMvcFI0ZVQyS0xrWjVhTHdhemM1bC9yMFlvSk5WRDB0SFJt?=
 =?utf-8?B?b3VLNnBRcWtibzFjOGwxUHZ1ajlKSGYxOE1NSzhIdUtrNU9UVlR1b1cvT2ds?=
 =?utf-8?B?U2RoY0RPMTRKMjdZY05rOXRDOVo1SmlONi9hRCtCbzhUcWZ3UHpObnVnUHRT?=
 =?utf-8?B?alVNYUh5aVR4cnU2dzBhSUEybDNXNFhCaWlvK2lRUzY5YVZ1eUo0S2JLUHZD?=
 =?utf-8?B?M3BRTG81OVl1NVV3QXh5OWttTDVoMUtsYXQwczJxRjUvR1JvZXlneFFnazI1?=
 =?utf-8?B?Z2M1WDRDUUpBRWw4U2QwR3hja0I1czdJOUJoMjF0VWZ4SThKZzZZYW01RzBq?=
 =?utf-8?B?c1lVeGlkQkFha2wvNmVibFFHVGYxVnNScjRibFhVZ1VMS1BiNGNkODgyd3Ay?=
 =?utf-8?B?ZGFDN251U2dhSnZMZE9DWk9QZkpHN3I2U1ZZSlJxV2pFRG9GbkhyNXhtVnBO?=
 =?utf-8?Q?EY3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32323d4e-419b-42da-6f32-08dbd158e6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 10:39:56.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59OIySbwCtLCyJZxLtKisFGI3k63wf+FLWvxkny/sWgrCBaDkebZnO6eDW/JeO6PJPVT4Jkf7ArLHg1zGUIsDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWxAemlzd2lsZXIuY29tPg0KPiBTZW50OiAyMDIz5bm0MTDmnIgxOOaXpSAyMjo1Ng0K
PiBUbzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU2hlcnJ5IFN1biA8
c2hlcnJ5LnN1bkBueHAuY29tPjsgSm9oYW4gSGVkYmVyZw0KPiA8am9oYW4uaGVkYmVyZ0BnbWFp
bC5jb20+OyBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT47
IE5lZXJhaiBzYW5qYXkga2FsZSA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT47DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5u
Lm9yZz47DQo+IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPjsg
QW1pdGt1bWFyIEthcndhcg0KPiA8YW1pdGt1bWFyLmthcndhckBueHAuY29tPjsgSWxwbyBKw6Ry
dmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djEgMi8yXSBCbHVldG9vdGg6IGJ0bnhwdWFydDogRml4IG54cF9zZXR1cA0KPiANCj4gRnJvbTog
TWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IA0KPiBVbmZv
cnR1bmF0ZWx5LCBueHBfc2V0dXAoKSBtYXkgaW5hZHZlcnRlbnRseSBhc3N1bWUgdGhhdCB0aGUg
ZmlybXdhcmUgaXMNCj4gYWxyZWFkeSBydW5uaW5nIHdoaWxlIHRoZSBtb2R1bGUgaXMgbm90IGV2
ZW4gcG93ZXJlZCB5ZXQuDQo+IEZpeCB0aGlzIGJ5IHdhaXRpbmcgdXAgdG8gMTAgc2Vjb25kcyBm
b3IgdGhlIENUUyB0byBnbyB1cCBhcyB0aGUgY29tYm8NCj4gZmlybXdhcmUgbWlnaHQgYmUgbG9h
ZGVkIGJ5IHRoZSBXaS1GaSBkcml2ZXIgb3ZlciBTRElPIChtd2lmaWV4X3NkaW8pLg0KPiANCj4g
Rml4ZXM6IDY4OWNhMTZlNTIzMiAoIkJsdWV0b290aDogTlhQOiBBZGQgcHJvdG9jb2wgc3VwcG9y
dCBmb3IgTlhQDQo+IEJsdWV0b290aCBjaGlwc2V0cyIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gDQo+IC0tLQ0K
PiBUaGlzIGlzIHdoYXQgbWF5IGhhcHBlbiB3aXRob3V0IHRoaXMgZml4Og0KPiBbICAyODQuNTg4
MTc3XSBCbHVldG9vdGg6IGhjaTA6IE9wY29kZSAweDBjMDMgZmFpbGVkOiAtMTEwIFsgIDI4Ni42
MzYxNjddDQo+IEJsdWV0b290aDogaGNpMDogU2V0dGluZyB3YWtlLXVwIG1ldGhvZCBmYWlsZWQg
KC0xMTApIFVuZm9ydHVuYXRlbHksIGV2ZW4NCj4gcmUtbG9hZGluZyB0aGUgYnRueHB1YXJ0IGtl
cm5lbCBtb2R1bGUgd291bGQgbm90IHJlY292ZXIgZnJvbSB0aGlzDQo+IGNvbmRpdGlvbi4NCj4g
DQo+ICBkcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyB8IDEwICsrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgYi9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0K
PiBpbmRleCA5Y2I3NTI5ZWVmMDkuLjRiODNhMGFhMzQ1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1
YXJ0LmMNCj4gQEAgLTEwMjEsNiArMTAyMSwxNiBAQCBzdGF0aWMgaW50IG54cF9zZXR1cChzdHJ1
Y3QgaGNpX2RldiAqaGRldikNCj4gIAkJaWYgKGVyciA8IDApDQo+ICAJCQlyZXR1cm4gZXJyOw0K
PiAgCX0gZWxzZSB7DQo+ICsJCS8qIFRoZSBjb21ibyBmaXJtd2FyZSBtaWdodCBiZSBsb2FkZWQg
YnkgdGhlIFdpLUZpIGRyaXZlcg0KPiBvdmVyIFNESU8gKG13aWZpZXhfc2RpbykuDQoNCkhpIE1h
cmNlbCwNCg0KUGxlYXNlIHJlbW92ZSB0aGUgZGVzY3JpcHRpb24gb2YgIm92ZXIgU0RJTyAobXdp
ZmlleF9zZGlvKSIgaGVyZSwgYmVjYXVzZSB0aGUgV2ktRmkgZHJpdmVyIGNvcnJlc3BvbmRpbmcg
dG8gdGhlIE5YUCBCVCBjaGlwIG5vdCBvbmx5IHN1cHBvcnRzIHRoZSBTRElPIGludGVyZmFjZSwg
YnV0IGFsc28gc3VwcG9ydHMgdGhlIFBDSWUgYnVzLg0KVGhhdCBpcyB0byBzYXksIGNvbWJvIGZp
cm13YXJlIGNhbiBiZSBsb2FkZWQgdmlhIHRoZSBTRElPIG9yIFBDSWUgYnVzLg0KDQpCZXN0IFJl
Z2FyZHMNClNoZXJyeQ0KDQo+ICsJCSAqIFdlIHdhaXQgdXAgdG8gMTBzIGZvciB0aGUgQ1RTIHRv
IGdvIHVwLiBBZnRlcndhcmRzLCB3ZQ0KPiBrbm93IHRoYXQgdGhlIGZpcm13YXJlIGlzDQo+ICsJ
CSAqIHJlYWxseSByZWFkeS4NCj4gKwkJICovDQo+ICsJCWVyciA9IHNlcmRldl9kZXZpY2Vfd2Fp
dF9mb3JfY3RzKG54cGRldi0+c2VyZGV2LCB0cnVlLA0KPiAxMDAwMCk7DQo+ICsJCWlmIChlcnIp
IHsNCj4gKwkJCWJ0X2Rldl9lcnIobnhwZGV2LT5oZGV2LCAiV2FpdCBmb3IgQ1RTIGZhaWxlZA0K
PiB3aXRoICVkIiwgZXJyKTsNCj4gKwkJCXJldHVybiBlcnI7DQo+ICsJCX0NCj4gKw0KPiAgCQli
dF9kZXZfZGJnKGhkZXYsICJGVyBhbHJlYWR5IHJ1bm5pbmcuIik7DQo+ICAJCWNsZWFyX2JpdChC
VE5YUFVBUlRfRldfRE9XTkxPQURJTkcsICZueHBkZXYtDQo+ID50eF9zdGF0ZSk7DQo+ICAJfQ0K
PiAtLQ0KPiAyLjM2LjENCg0K
