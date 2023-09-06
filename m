Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17379385E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjIFJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjIFJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB6F1997;
        Wed,  6 Sep 2023 02:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko2i/X4kGaEXJTYfV6t8/ob7ayb7+m6Hfm+1RCbMpEnWb0g5UztxHyr/jsLSl7w0jIRCRoldiW6c68mDvdbOYI00CulZfBo+RNl7LR2Ow3CMhp7aQtY76mogAutK+o6bo0s5rr7vGril8TwSsuvUFNIlaDpQ3a+w8vTl6VHVvrGXIrTzWOsdUWHc8/C5R8b7D4v7JUZzX5BOvjOaS0ZhegtbZdNyi6tqNNC1dPew2aJiavvJ5TaFSUIuykH0FF0DMRd1UgjtQU8pX2b95hyBA1+GWwUlmbDHBNhnaBMlzhZJvKM2qn8Qzobaw20+1VfgjFeMnChHqNz9XY2/Qx40Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9MOBXA4aopOF5qchZGEZUV5+P4SPztuODyzWASSzhA=;
 b=kjiSKGGtm/oS6tXCRY9Vf++D7yGwwRYUAvVkx3+V6t083vKalc/x/pznyMlXy+BhSbVGBIknr5eeAORgYfcTdl2WKwhXAvF+k4dLhNJDuLc2g3E6vug3EUgtdartgGLnUDUf7oVGdX4Gkos9aLrySe85YJKHSsKxALRYLSzq3O6Te956wliCtpa7Tae3oFGfbeCrMZ61Z9yarA1TgSpSbXJ9dSYCsWpdcjzj7Xm+r1jyZ9mBToApJfX8W4EUdVTRM+ARnWEwoXprJKZ0KdtcIdY8yLff2/FhyMUzR4Vhr2+Xqy5PrpSJ7LNRvHyFdzozUdGx6Ig1hrL7BDRKpeJ/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9MOBXA4aopOF5qchZGEZUV5+P4SPztuODyzWASSzhA=;
 b=sPRoXdQEr+Dxloc0uQ0NNykkk0v9+j3EN4eizr0xd59E+lG7QiX+gR9pKfOGgvXCiPBN4dLFHiwdCnQ9q1n4TiszJl1srSbMQ4cSK99vznOawkTprTnNf1wcGUaPrY4lwKrnGlJh+u8Ew9ob2SAZbBVU4E2vaCV1FaClKMtWqvE=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:33:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:33:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2] media: amphion: handle firmware debug
 message
Thread-Topic: [EXT] Re: [PATCH v2] media: amphion: handle firmware debug
 message
Thread-Index: AQHZ1Wr4MpOF1Va7B0eZmnLieY5jV7ANno6AgAAAtGA=
Date:   Wed, 6 Sep 2023 09:33:15 +0000
Message-ID: <AM6PR04MB63413EDFCB2DE4CA70B30C65E7EFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230823023837.23101-1-ming.qian@nxp.com>
 <7d068861-2396-00e7-5851-bfb35810ab0a@xs4all.nl>
In-Reply-To: <7d068861-2396-00e7-5851-bfb35810ab0a@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PAXPR04MB9400:EE_
x-ms-office365-filtering-correlation-id: ff038b72-be21-40f3-ca5a-08dbaebc4c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sgyfQ8Yin8OVXrYGoQPInc7q3hRPhrWrIPTUmUeSgX4/RtE+ar4sk4BJcq7wEj/Rm6lpZ47zqC7LxW3qvhLXp6IDJJnlOFpPMlxZ9G1cmzphMWCYQ0nOy7wuUx6mCsfwIcXpUS7IoJwLACa3OMBJB5pZUPEelgI0eTjNiR1ZmLHlf7m395MUfAC5R4Bms3quH2rdPhDqsownHNEy2ZQCS+utiLKjwP9QOV9t0GLTfbZlMkXdr55fI8Qk2oZfrQgpmD2cCHj/fMQr2k0oD3Lgy8qw7lyR1R4ueqRkztUNvQJ/5ftqtIqBxRvJ+gvwe9RQvWvct+50QH2fUmZLeoQHRtzafp0EssZe9sFsE75pxS9EopRj2qMuZZY3rvAS3PN6dULSHCYEHrNaOWWeUQHbzhU2thvCLiT3XL/+Z4DAx4RalPjgCm7epBfbPt9CsHZDe7pvf4ka5638x8/Cp/Cs9P/rTvS6JLDCWydqgY+5SVsHQBbMdSk8DnLdv0ee6GRImGmmn1O7aWfthWvm8zty9Q9D1nj48zRMJxfc1NIgEpCsmWu9viX2AKBi4TBj44RwJTF71rgkmOFjAQrB9sgJ1haZEeQy6SuW8J3VsMzZHZTGlAYNPyI/bcxPKR87xDan
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199024)(186009)(1800799009)(478600001)(71200400001)(9686003)(6506007)(110136005)(7696005)(316002)(8676002)(8936002)(4326008)(44832011)(26005)(5660300002)(41300700001)(7416002)(15650500001)(2906002)(83380400001)(52536014)(66556008)(54906003)(122000001)(38070700005)(38100700002)(33656002)(66946007)(66446008)(66476007)(76116006)(64756008)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1EvdXFXa2dwTWt3QTJJQ3paNHRsWFphWGJJS0U0Mm5WbW1jR0Z3K1FENjlw?=
 =?utf-8?B?Qk9jSSt5UEV6VXpJaUFXQllvNzloS2pmNXBrWUZKamU0MXk3Uk1CWkpBU2tj?=
 =?utf-8?B?ZzMxSEhhanJyZkwwRDVBaXBTMG5lYkF6Y1pvenoweU9OZHJrYUhiTDYvS1hP?=
 =?utf-8?B?THdCWk1hZUdRemVLRE9YK0h0dXRJeGpuQnNSMXRkdDMwZjN2Q0lTMUJ2a0E0?=
 =?utf-8?B?ay9PdDRYS1huaUQvZ2tmWGRhblNNbTRJc1dTUDRETGcvNTNsVmFrc1BqZjJL?=
 =?utf-8?B?WXQ1a2Jhdzg1RTZmTitMN094dGlQNW4yaElsNS93NXlFMm5ZN2FiUUxRNHZD?=
 =?utf-8?B?d1g3ckduL09VcHppN1AwQndOT2oyT3NjT3g3eVdrN1FjZmFVck1VMGc0enhs?=
 =?utf-8?B?TnRNRHJRL2lpSm5mMEhFUU5heGJRd3VCcXhUVUVrUFo2NkxuemJvYVRDZVds?=
 =?utf-8?B?MDBPMFgxRGUySG5BWWlnUjhObEdwRFpsUTBGZ2I4eTJhZXVrUkxWdUlSaE5D?=
 =?utf-8?B?UmZpUjNOSUsxSlFtSmlWOFBLTGlGRTZQUUhxdTh2VXpjZmZEUXcvalpVZ2lh?=
 =?utf-8?B?ZzJ0TFBPU29nTjQyZGg1U1B0UnRhMmlpb2UyS2IxRWVSY0xNRGVFL0RRT040?=
 =?utf-8?B?WnJQNUw0OGsySm8wVHNTcWdXRFBzK1U2cndkcElyVmNoYzhCNTJzS09KNVgr?=
 =?utf-8?B?OWpwOVIrZmpDaHYwY2taRkgwZ2hGUEhObXJ3WDF3Rk9GejRDMSt1Z0ZFck51?=
 =?utf-8?B?V0o4ZGc3UkZhd1V4RmZVeGFWbTBqKzErNFFFb29hMEdLeFhreVJJZXRGT1Ft?=
 =?utf-8?B?TVFkSDdyWm0vckk5U0lpalZZeWJBNHhPRTJMNVQxRUpMc093bEtzS2tobkxk?=
 =?utf-8?B?SFg2Vm13Q3YyNFdQSkpabmN2ODcvdGZvSlpza2ZNZ2IrczQ5OGJTQWRNZ1Nu?=
 =?utf-8?B?dU9VVUxvVFZDVWpmc01icjBhRE9GN2dHVzNHMzZDaENnNTdvZHF5MWtFSXJW?=
 =?utf-8?B?QlZUMUhsLzRqVzlnMkZPL2pDWWhPWXpOMGJFQXp5N3dKa2ZQUUlkcDErRzVj?=
 =?utf-8?B?V0dpRnZEandDSC9pMC9LdkVuNDR6aG9xUk5RUkRhckhYMUtjNHp2S1RydHAr?=
 =?utf-8?B?bXMvZENvdkhOUmQ2WEZqK2JRbjhZS0plQmgwcTJNSGNVcm1XSGtKMFNpSHdn?=
 =?utf-8?B?TktUSVM3QjFtMDdOaDhEUW5KMGY4WlMxcHE2YnlNTkE4K1A0UDE2U3VaR0ha?=
 =?utf-8?B?UngrRjJ2cUlieHNER2gyS0lUMHdwbm9UTHovdkN4bFBLT1o1SlVOT01HSDAr?=
 =?utf-8?B?ZW1oYy9pTWFWOCs2UG1XY2R4QnU0NlZiakdRWTJUVE5YK0VEbzVXMDVYZ3FY?=
 =?utf-8?B?aEZURVl4bjZHbzNkL1Q5bzdKK2pXQi84TXdiOXBNVFdWZjRaeG9xaU9jZlA1?=
 =?utf-8?B?eHVjQVdSb3F2ck81WkVNZnlZNG1LK1FwVWoyNWNHdm5aZDdadzJuTmcxYTRI?=
 =?utf-8?B?eWNHYU5ab25DVG5neWFiRVF5RDdBRXlYWXlHTDNFZTJ4b2toNXRxRk91eTNO?=
 =?utf-8?B?SXVBakVQaUJDN21aRk95U0dYVUF6TEVyVEJ3Y2pyZzNHZ2lKK2RkdUE3MC85?=
 =?utf-8?B?SUUxMDZGelpKODZwTFhCbUJZVWx1a1R2Ri9jeHplSGpmeGl5Um9IcEZiMHUv?=
 =?utf-8?B?UC9iemRaRFpCR3RuRjFOTXJ2aTFHYkwzdHVsTmNROFFPbllkVE9MbXpHcEk2?=
 =?utf-8?B?MWFiN0RUSjhtOTZRTGcxcDhRZTNXeXloYkltZFZ1bXd0MGd3SHN3UWFFenUr?=
 =?utf-8?B?SUFScFdlM1czdDlKYmd5eUlpNm5xWU12dkh4NXNHT3VVU2pnalY2bnRwdVJO?=
 =?utf-8?B?aE5hTmptRXBWWEV3OTZ6RUh6YWNhc05rdFV1c1AzRGlWQmNITEJpTjIvZ3F1?=
 =?utf-8?B?ZE5hVU4xYTNxZGEvNmNNN2t0UFBtaDkzWGNSaVByRWNrOSsrTHdyU3VkWjNr?=
 =?utf-8?B?b3hoSkQ1bTlJdXZRaWo2WmI3dHlMMTdhWllVMkZCbjBlZHZnQ1N4b25nZmtu?=
 =?utf-8?B?YmRyRDlXNkwxek9uNy9ERVF2bkdldzBMSzRDb1R3T2FORW1tcnNWNVJ6dkQw?=
 =?utf-8?Q?k7+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff038b72-be21-40f3-ca5a-08dbaebc4c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 09:33:15.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy/si3Qz7fOyHSyrCwPfF8G8KmjKR/wu40lHdnQzpS9/PLmreA5vHfQvAJH6jDwIyiNaTc9SXEMab1PXH5BVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gZGVjb2RlciBmaXJtd2FyZSBtYXkgbm90aWZ5IGhvc3Qgc29tZSBkZWJ1ZyBtZXNzYWdlLCBp
dCBjYW4gaGVscA0KPj4gYW5hbHl6ZSB0aGUgc3RhdGUgb2YgdGhlIGZpcm13YXJlIGluIGNhc2Ug
b2YgZXJyb3INCj4+DQo+PiBGaXhlczogOWY1OTlmMzUxZTg2ICgibWVkaWE6IGFtcGhpb246IGFk
ZCB2cHUgY29yZSBkcml2ZXIiKQ0KPj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFp
YW5AbnhwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1
ZnJlc25lQGNvbGxhYm9yYS5jb20+DQo+PiAtLS0NCj4+IHYyDQo+PiAtIGZvcmNlIHRvIHRlcm1p
bmF0ZSBzdHJpbmcgbWVzc2FnZSBkYXRhDQo+PiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9kZWZzLmggICAgfCAxICsNCj4+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhp
b24vdnB1X2hlbHBlcnMuYyB8IDEgKw0KPj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9u
L3ZwdV9tYWxvbmUuYyAgfCAxICsNCj4+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24v
dnB1X21zZ3MuYyAgICB8IDkgKysrKysrKysrDQo+PiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
bXBoaW9uL3ZwdV9ycGMuYyAgICAgfCAzICsrLQ0KPj4gIDUgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2RlZnMuaA0KPj4gYi9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2FtcGhpb24vdnB1X2RlZnMuaA0KPj4gaW5kZXggNjY3NjM3ZWVkYjVkLi43MzIwODUyNjY4
ZDYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2Rl
ZnMuaA0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9kZWZzLmgN
Cj4+IEBAIC03MSw2ICs3MSw3IEBAIGVudW0gew0KPj4gICAgICAgVlBVX01TR19JRF9USU1FU1RB
TVBfSU5GTywNCj4+ICAgICAgIFZQVV9NU0dfSURfRklSTVdBUkVfWENQVCwNCj4+ICAgICAgIFZQ
VV9NU0dfSURfUElDX1NLSVBQRUQsDQo+PiArICAgICBWUFVfTVNHX0lEX0RCR19NU0csDQo+PiAg
fTsNCj4+DQo+PiAgZW51bSBWUFVfRU5DX01FTU9SWV9SRVNPVVJTRSB7DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9oZWxwZXJzLmMNCj4+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9oZWxwZXJzLmMNCj4+IGluZGV4IGFmM2Iz
MzZlNWRjMy4uZDEyMzEwYWY5ZWJjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hbXBoaW9uL3ZwdV9oZWxwZXJzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vYW1waGlvbi92cHVfaGVscGVycy5jDQo+PiBAQCAtNDg5LDYgKzQ4OSw3IEBAIGNvbnN0IGNo
YXIgKnZwdV9pZF9uYW1lKHUzMiBpZCkNCj4+ICAgICAgIGNhc2UgVlBVX01TR19JRF9VTlNVUFBP
UlRFRDogcmV0dXJuICJ1bnN1cHBvcnRlZCI7DQo+PiAgICAgICBjYXNlIFZQVV9NU0dfSURfRklS
TVdBUkVfWENQVDogcmV0dXJuICJleGNlcHRpb24iOw0KPj4gICAgICAgY2FzZSBWUFVfTVNHX0lE
X1BJQ19TS0lQUEVEOiByZXR1cm4gInNraXBwZWQiOw0KPj4gKyAgICAgY2FzZSBWUFVfTVNHX0lE
X0RCR19NU0c6IHJldHVybiAiZGVidWcgbXNnIjsNCj4+ICAgICAgIH0NCj4+ICAgICAgIHJldHVy
biAiPHVua25vd24+IjsNCj4+ICB9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Ft
cGhpb24vdnB1X21hbG9uZS5jDQo+PiBpbmRleCBmNzcxNjYxOTgwYzAuLmQzNDI1ZGU3YmNjZCAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25l
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMN
Cj4+IEBAIC03NDUsNiArNzQ1LDcgQEAgc3RhdGljIHN0cnVjdCB2cHVfcGFpciBtYWxvbmVfbXNn
c1tdID0gew0KPj4gICAgICAge1ZQVV9NU0dfSURfVU5TVVBQT1JURUQsDQo+VklEX0FQSV9FVkVO
VF9VTlNVUFBPUlRFRF9TVFJFQU19LA0KPj4gICAgICAge1ZQVV9NU0dfSURfRklSTVdBUkVfWENQ
VCwgVklEX0FQSV9FVkVOVF9GSVJNV0FSRV9YQ1BUfSwNCj4+ICAgICAgIHtWUFVfTVNHX0lEX1BJ
Q19TS0lQUEVELCBWSURfQVBJX0VWRU5UX1BJQ19TS0lQUEVEfSwNCj4+ICsgICAgIHtWUFVfTVNH
X0lEX0RCR19NU0csIFZJRF9BUElfRVZFTlRfREJHX01TR19ERUN9LA0KPj4gIH07DQo+Pg0KPj4g
IHN0YXRpYyB2b2lkIHZwdV9tYWxvbmVfcGFja19mc19hbGxvYyhzdHJ1Y3QgdnB1X3JwY19ldmVu
dCAqcGt0LCBkaWZmDQo+PiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHVfbXNncy5jDQo+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbXNncy5j
DQo+PiBpbmRleCBkMGVhZDA1MWY3ZDEuLjk5OWVmZWFlYmZkNSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbXNncy5jDQo+PiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21zZ3MuYw0KPj4gQEAgLTE4MCw2ICsxODAsMTQg
QEAgc3RhdGljIHZvaWQgdnB1X3Nlc3Npb25faGFuZGxlX3BpY19za2lwcGVkKHN0cnVjdA0KPnZw
dV9pbnN0ICppbnN0LCBzdHJ1Y3QgdnB1X3JwYw0KPj4gICAgICAgdnB1X2luc3RfdW5sb2NrKGlu
c3QpOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIHZvaWQgdnB1X3Nlc3Npb25faGFuZGxlX2RiZ19t
c2coc3RydWN0IHZwdV9pbnN0ICppbnN0LCBzdHJ1Y3QNCj4+ICt2cHVfcnBjX2V2ZW50ICpwa3Qp
IHsNCj4+ICsgICAgIGNoYXIgKnN0ciA9IChjaGFyICopcGt0LT5kYXRhOw0KPj4gKw0KPj4gKyAg
ICAgaWYgKHN0cmxlbihzdHIpKQ0KPg0KPlRoaXMgY2FuIGJlIHJlcGxhY2VkIGJ5OiAnaWYgKCpz
dHIpJywgaXQncyBmYXN0ZXIgdGhhbiBzdHJsZW4uDQo+DQo+PiArICAgICAgICAgICAgIGRldl9p
bmZvKGluc3QtPmRldiwgImluc3RhbmNlICVkIGZpcm13YXJlIGRiZyBtc2cgOg0KPj4gKyVzXG4i
LCBpbnN0LT5pZCwgc3RyKTsgfQ0KPj4gKw0KPj4gIHN0YXRpYyBzdHJ1Y3QgdnB1X21zZ19oYW5k
bGVyIGhhbmRsZXJzW10gPSB7DQo+PiAgICAgICB7VlBVX01TR19JRF9TVEFSVF9ET05FLCB2cHVf
c2Vzc2lvbl9oYW5kbGVfc3RhcnRfZG9uZX0sDQo+PiAgICAgICB7VlBVX01TR19JRF9TVE9QX0RP
TkUsIHZwdV9zZXNzaW9uX2hhbmRsZV9zdG9wX2RvbmV9LCBAQCAtDQo+MTk2LDYNCj4+ICsyMDQs
NyBAQCBzdGF0aWMgc3RydWN0IHZwdV9tc2dfaGFuZGxlciBoYW5kbGVyc1tdID0gew0KPj4gICAg
ICAge1ZQVV9NU0dfSURfVU5TVVBQT1JURUQsIHZwdV9zZXNzaW9uX2hhbmRsZV9lcnJvcn0sDQo+
PiAgICAgICB7VlBVX01TR19JRF9GSVJNV0FSRV9YQ1BULCB2cHVfc2Vzc2lvbl9oYW5kbGVfZmly
bXdhcmVfeGNwdH0sDQo+PiAgICAgICB7VlBVX01TR19JRF9QSUNfU0tJUFBFRCwgdnB1X3Nlc3Np
b25faGFuZGxlX3BpY19za2lwcGVkfSwNCj4+ICsgICAgIHtWUFVfTVNHX0lEX0RCR19NU0csIHZw
dV9zZXNzaW9uX2hhbmRsZV9kYmdfbXNnfSwNCj4+ICB9Ow0KPj4NCj4+ICBzdGF0aWMgaW50IHZw
dV9zZXNzaW9uX2hhbmRsZV9tc2coc3RydWN0IHZwdV9pbnN0ICppbnN0LCBzdHJ1Y3QNCj4+IHZw
dV9ycGNfZXZlbnQgKm1zZykgZGlmZiAtLWdpdA0KPj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X3JwYy5jDQo+PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92
cHVfcnBjLmMNCj4+IGluZGV4IGY2MjZhOWY4MzVlMC4uODIzNDM3MGFmZWU1IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuYw0KPj4gKysrIGIv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuYw0KPj4gQEAgLTE0NCw3ICsx
NDQsNyBAQCBzdGF0aWMgaW50IHZwdV9ycGNfcmVjZWl2ZV9tc2dfYnVmKHN0cnVjdA0KPnZwdV9z
aGFyZWRfYWRkciAqc2hhcmVkLCBzdHJ1Y3QgdnB1X3JwDQo+PiAgICAgICBtc2ctPmhkci5udW0g
PSAobXNnd29yZCA+PiAxNikgJiAweGZmOw0KPj4gICAgICAgbXNnLT5oZHIuaWQgPSBtc2d3b3Jk
ICYgMHgzZmZmOw0KPj4NCj4+IC0gICAgIGlmIChtc2ctPmhkci5udW0gPiBBUlJBWV9TSVpFKG1z
Zy0+ZGF0YSkpDQo+PiArICAgICBpZiAobXNnLT5oZHIubnVtID49IEFSUkFZX1NJWkUobXNnLT5k
YXRhKSkNCj4NCj5JcyB0aGlzIHJpZ2h0PyBZb3UgYXJlIGNoYW5naW5nIHRoZSBtYXggbGVuZ3Ro
IGp1c3QgdG8gYmUgYWJsZSB0byBzZXQgdGhlIGxhc3QNCj5ieXRlIHRvIDAsIHdoaWNoIG1ha2Vz
IHNlbnNlIGZvciBWUFVfTVNHX0lEX0RCR19NU0cgYnV0IHBlcmhhcHMgbm90IGZvcg0KPm90aGVy
cy4NCj4NCj5JIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBsZWF2ZSB0aGlzIGNvZGUgYXMt
aXMgYW5kIGluc3RlYWQgc2V0IHRoZSBsYXN0IGJ5dGUNCj50byAwIGluIHZwdV9zZXNzaW9uX2hh
bmRsZV9kYmdfbXNnKCkuIFRoYXQncyB3aGVyZSBpdCBpcyBhY3R1YWxseSBuZWVkZWQuDQo+DQo+
T3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPw0KPg0KPlJlZ2FyZHMsDQo+DQo+ICAgICAg
ICBIYW5zDQoNCkl0IHdpbGwgYmUgZml4ZWQgaW4gdjMNCg0KPg0KPj4gICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4+DQo+PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbXNnLT5oZHIubnVt
OyBpKyspIHsgQEAgLTE1Niw2ICsxNTYsNyBAQCBzdGF0aWMNCj4+IGludCB2cHVfcnBjX3JlY2Vp
dmVfbXNnX2J1ZihzdHJ1Y3QgdnB1X3NoYXJlZF9hZGRyICpzaGFyZWQsIHN0cnVjdA0KPnZwdV9y
cA0KPj4gICAgICAgICAgICAgICAgICAgICAgIGRhdGEgPSBzaGFyZWQtPm1zZ19tZW1fdmlyOw0K
Pj4gICAgICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+PiArICAgICBtc2ctPmRhdGFbbXNnLT5o
ZHIubnVtXSA9IDA7DQo+Pg0KPj4gICAgICAgLyp1cGRhdGUgcnB0ciBhZnRlciBkYXRhIGlzIHJl
YWQqLw0KPj4gICAgICAgbWIoKTsNCg0K
