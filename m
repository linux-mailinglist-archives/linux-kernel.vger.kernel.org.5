Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068EE7C94D2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 16:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjJNOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJNOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 10:00:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91662C2;
        Sat, 14 Oct 2023 07:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrrcrZfdQq0MVo5Cc5xj6zRJWPe8qXg02j2tUarAHsqcyfFd1nc64AwPuND9ucg6oraTIYRCK04FJ1IJk/nYuq2UosBNcUFRLXR7sKSDAilqYHXkQ/pfj622RGWFkreOfz6a0Y6AA2LGF1lDsBRUiW36TEvejtDbPMXO9uXtOB6akyd8LDR4baiKNveZtge7K1vOPspri2QGvuIeRlmQ9N7jrFfVJV0TpaYdxgxzNwDzrUAhPa/Gar6GsVJVIR8bFoBGVTZl4ULozkxiLdaYsN4Pnl05ROXQx4WdtzQQWrXQPu7jFKgdBawJBYh6I5ySf6Ufgri/9RSlIvl13y59MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4FjuTZBAIcsSlIN6j5QzA9Pp4uFrjGi46sYare9sQo=;
 b=gYpxWsmjRlcIcxP+GJ6TmrN9yZpFghErpodsGjjA2zHBS7SybVQ0fgUkT7txzBEh9ICUfEzXpuAf8Fv1kF/iDjVvmPckJog9Xx2/c5i9AP1hVIvupliqfv9bwuRomshUO11sDzAwTTcVwKHY/m26JIRqZ+EPydqf8vWoUmX2My/BcmYRPKDtqW5ibeNqjryl+l9dU1maN7bj3Xx4dUNF7St0EXgc9I+3Xibnpf4ZZI8vkdCKBnCkb+6LSxc/R8dBTQuVXV5tlKuVgXV/d+WYw/aNF/XYA6Iwv4tI8PHjvMKjPYyA3IO8/WegakMqtMcbniZMIc9acwSGwFjl+sJeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4FjuTZBAIcsSlIN6j5QzA9Pp4uFrjGi46sYare9sQo=;
 b=cuSt8PV78D7q6JoTFCTACyO0qSPHvosCTnZt3F2n12YuscLRtHaYGoTxR0rSU/jwNfP+9KRFk0tFen5pmQUWou+wkyvS7mRcoa27YWaHKyCohJqzaYosVhrYRiMFiFed8Kv3QNyJi0UQbIsKZI+TimcV4wmXiEdmYtCd2FyNtkM=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DU0PR03MB9865.eurprd03.prod.outlook.com (2603:10a6:10:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 14:00:25 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::fb3c:4931:e74e:c691]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::fb3c:4931:e74e:c691%3]) with mapi id 15.20.6863.043; Sat, 14 Oct 2023
 14:00:25 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Rob Herring <robh@kernel.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
Thread-Topic: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
Thread-Index: AQHZ9o172nD/7tvDCkmM9q6Ey5mxHrA5tBeAgAB1cACACPt3gIAGO3QA
Date:   Sat, 14 Oct 2023 14:00:24 +0000
Message-ID: <tw55zws77ydpjjzjg7itzfphuo3w6yqp6sgdt6ylwfsexjz2lm@qruycd72w56s>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
 <20231004063712.3348978-2-alvin@pqrs.dk>
 <20231004143937.GA3091822-robh@kernel.org>
 <mkeegnnfuxmutdkun7tprz27miyeisvhppsdp5mxmeq4kykecy@b576w45hwcbd>
 <CAL_JsqKrGM1KFPxECXM49KZ-CYxhBShODk0TQeEMx8r-ztSh6Q@mail.gmail.com>
In-Reply-To: <CAL_JsqKrGM1KFPxECXM49KZ-CYxhBShODk0TQeEMx8r-ztSh6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DU0PR03MB9865:EE_
x-ms-office365-filtering-correlation-id: 07341070-7e11-4244-b131-08dbccbdea19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHKAShPm2m/CZ7ZGC2fQMrrY2EGaZSWGHhA/y5XAkU4TWhiSslRRrgVMtoajLThjuDdwy8hc4+VQ9+fFccDe2b5sJJx+sTDTgw9ERRusnpmsWxpWSq5BLMKoqKX38AhMFuvtq79fLfD+uNJqa8nxDEzU+zEBybssnyrkNrYFiAZjHD9mjsI2nvH+pvmA2F3pnFySw9p8J8gzUDrZVxqlw4SDuPIqCdnpr+Qlo9BElKZz4s5R0CPeorVgKHWQTUlyN1C0TYUqOF1XKAzBU1rt+Y5mm8A+p3Waa/XXpJv/YtHnfCZWEy8QFJntZpo6DM6CdHmuCtkxTKYnlmRpXgR1XdME7UeRcPopNAkq7Jq6ldCMyJxQfot3X9sWvLGKSwJ6KSrO6eQmscFUggB/Xfm+PnlPO7zY+a6vkR/VEGxmf6oyYZzpP2IcwHr6yB1rlyNMrvjkM5vllLzOmzBBTr8z7+tX3PKHQ3LAzvKv5R1/IDXDDNNjgtaOEblwelJsofDRjIndis93Fi2kZzYmKx0Ckf0RnZUOYfIVgH9QWDlH2yTkXGOgruM3+qFiLloWpNvOWH7kmuVD09N7pzwzQOTpF4tgoGnChPPil7u6CSeotBYUjg7nzF8dMefYgVZ7BBD5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(376002)(39850400004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(4326008)(8676002)(8936002)(66446008)(53546011)(6506007)(41300700001)(5660300002)(64756008)(54906003)(76116006)(91956017)(66556008)(66946007)(6916009)(66476007)(478600001)(6486002)(2906002)(66574015)(7416002)(83380400001)(38100700002)(86362001)(71200400001)(9686003)(6512007)(85182001)(85202003)(26005)(33716001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWREUWZxWnc2WXpHTDhOV29PL2hUYi8vTVg1QjYxY1BIWS9tTDduS0Q1TlBH?=
 =?utf-8?B?OWYwUDlXMk1KVTFLZ05NcTFLN2pqTDFuQ3Q2NCtOZDQ5Nk1DS0lKQ0VpUFlo?=
 =?utf-8?B?RkxCT3d4ZEgrWVp1bjV5NTRGc0pvUmZkcFpXZDlRNmhnc3MwZkVCNUlnSHNk?=
 =?utf-8?B?SVRka0JWRkY5K1BEMUJFTkR0ZlhXdGlmeG1kaUUrb1dVTVdDcmNlVU04RWE1?=
 =?utf-8?B?cERpRENWOHpLZ0p0bit6cXkxZkIrSkJiYVZEemN6NkpTc2xncW5EcUxWV1l6?=
 =?utf-8?B?NnJiNTJxb2gxWi9KV0k4bHVRUFlVQnNtZ1YzcndxTU51dzJWcStuZHU5blhR?=
 =?utf-8?B?eW9hYzFOS0tVK2lpbWlkdHIrL1Y1SGV2UnFCVHRvaTI3a3psRXY2RnlwRzkw?=
 =?utf-8?B?ajBQWGJNZlZsMUtwM2hhZVc2ci9jOEI0Zmg4M0ZyZzUrQmNBSk9sek5FdCt5?=
 =?utf-8?B?RUhJR056dExGNXZIUHNWTVdxTmVvNW9BYVNWTWxBcjl4a3BUa2ZQcXpUYWVw?=
 =?utf-8?B?Q0hkcHhta3d2SzNQTWg0d1NzTGtOMldnVE4wSVFoL1ZtNlpPL1preVdFWkxx?=
 =?utf-8?B?WEJtNEZPck9rdGNjcEdLWXBnNHhSd0xOcjBsU0s4NVMyNHVMTnVWNkVidWIv?=
 =?utf-8?B?UTFYdTBHK0FVeG90SUZ4TUFLOWxRN2lxdXpGNS96NW0vNzVBdk50TmUyMWRV?=
 =?utf-8?B?QmJ1bDVnMHpZUlJJVDRXUXMwbmErTkRRWUNHaXJMZE9sRDE5a1NsL0Z5UmRr?=
 =?utf-8?B?L2t3NjZVa3kzYnVHU2ZnWGREVVFHV0RwWlRxZVN6aTJDOGtROFkxRU01ckcw?=
 =?utf-8?B?YjVtUmwwNGVxbm9yeFZHSUFyM2xhMUlpNng5VFJCVUFScUhVQUtxRDFtNGtl?=
 =?utf-8?B?QnBoMkFiaEs5ODdBNXFuQ0xvZE1DV2xGbFVqc1JHdzJveXpnbnhDaE5ENXdO?=
 =?utf-8?B?QkUrUlhnZUlkRmNPZEtOQXk2cUlXKzRET3BpTkRwQ3dPSlhSSUFseVhaMnVy?=
 =?utf-8?B?Vm4xMWk1SU85K1h5QmRqTG5xeXV0OVhtUy9ISnZrL3JydDVPTmxkUWQ5anYy?=
 =?utf-8?B?SitURHhJdmZkaHZBMDRvSjNZNFlhVDBqQlpmT0tldE5tRzZVNHRURGR3ZW1P?=
 =?utf-8?B?QzRCa2tvUE5SU09WQ0VVYU1nb1k3UWFtbVNHbkt1SGN2R0tqYkJVT29aU2w1?=
 =?utf-8?B?eC9HdkdzMnRyWkNRZHYrNDhBNmdRT01qcEE0TFVBcEUwTW1Ndm8xenZmclJO?=
 =?utf-8?B?b0liMW9pb2lXVW5uRzlOWE9pTzVBSXVST0plL2tjNGhsVkZVUXNDTXpJZlBG?=
 =?utf-8?B?cjZPU0xmaGtWOUUxQ3Ivd2o5VjkyYVZsM1ZQLzZoM3BjRnFVb2d4M2Jta2ZQ?=
 =?utf-8?B?SCt4T1ArN2RON1J0MDNmUjlSanAvRFF5WS9OMjBFWm9OZ0VVSENSVHdYZk1P?=
 =?utf-8?B?aDRaYXltMXNNc1R6UWhwWmpyK2E5N2pqVTR2MjJ0WVJQdkwzMzQ0cFBLQnJP?=
 =?utf-8?B?Nmt0TmRFMGdBWXNBaTVWenR6WlQzeXdHeUk0S2ZHRjRmYmk2QjQ4QTFmTjFk?=
 =?utf-8?B?UjZmQVkxb09mQU5nNVpXNmpRSlkrYzVwR0lCTEhuYlRETDNWb2pibVVmOXNx?=
 =?utf-8?B?T0p0S29JQ0JOeS9QNHZINDQ5UlhsYXpCb3Y1VWs3MW5RNjEyN1RyR2I5cDJl?=
 =?utf-8?B?UFFRRE9pUkdVSGFCR2NFQW80Y2NBTFk0ZjUvTHZpTXZ1aEZMNGRiR2RUM1Fo?=
 =?utf-8?B?dHh1cTJVdk5lVEwyUnFLSyt5akNyRTFsU2dvaGJka0M3QSsvSjBhd2hjMTlO?=
 =?utf-8?B?RFc2YkJhME93YWxFZGgzQjMvWHZRSTVIT1J0UzhWN25VdU41NDljYXZPU2Y1?=
 =?utf-8?B?U29tWTR4U1VUSTh1VG8vd1k4ZENJaXFzTEVCNGR4eE1aWFJMSkxvdCt6TGha?=
 =?utf-8?B?d2twUjRWUkVHM1IydVFUWWFZanB6Sy9HTWVlbXp2VDBiYko0R012ZFJRYkQz?=
 =?utf-8?B?SVUzbmZQU0VoWHd6ZkJzZEI2dVhaL0FqbWhTbkFtYkh3VGNCdmN3bmVtaU1T?=
 =?utf-8?B?S2JkUnRIZVpaenBxcDRteXkwZHBOd2IySFkxVTN6YTlmRTlQZVQvaVpna3ls?=
 =?utf-8?Q?fct5K3LAxqcp7wP/dHlh7E8qS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <308DCEEB10A0D049BD12F4EB1EB15E2C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07341070-7e11-4244-b131-08dbccbdea19
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2023 14:00:25.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbDwiQ/6SqUBYtzOtzOIVvPyMiM6YSydw9o+hpkkJe8VWwBF+pYXBizVFNYL69A6+OzHFJWGjE4gyoQnNod8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMDk6NTA6MDNBTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIFdlZCwgT2N0IDQsIDIwMjMgYXQgNDo0MOKAr1BNIEFsdmluIMWgaXByYWdhIDxB
TFNJQGJhbmctb2x1ZnNlbi5kaz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIE9jdCAwNCwgMjAy
MyBhdCAwOTozOTozN0FNIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+ID4gKyAgICAg
IHNpbGFicyxtdWx0aXN5bnRoLXNvdXJjZToNCj4gPiA+ID4gKyAgICAgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gPiA+ICsgICAgICAgIGVudW06
IFsgMCwgMSBdDQo+ID4gPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPg0KPiA+ID4g
RG9uJ3QgbmVlZCAnfCcgaWYgbm8gZm9ybWF0dGluZyB0byBwcmVzZXJ2ZS4NCj4gPg0KPiA+IEkg
dGhvdWdodCB0aGUgbGluZSB3b3VsZCBiZSB0b28gbG9uZyBvdGhlcndpc2UuDQo+ID4gQ29sdW1u
IHdpZHRoIGlzIDgwIGluIGR0LXNjaGVtYSBhcyB3ZWxsLCByaWdodD8NCj4gDQo+IFllcywgYW5k
IHVwIHRvIDEwMCBpcyBmaW5lIGFzIGFuIGV4Y2VwdGlvbi4NCj4gDQo+ID4gPg0KPiA+ID4gPiAr
ICAgICAgICAgIFNvdXJjZSBQTEwgQSAoMCkgb3IgQiAoMSkgZm9yIHRoZSBjb3JyZXNwb25kaW5n
IG11bHRpc3ludGggZGl2aWRlci4NCj4gDQo+IEJ1dCB0aGlzIGRvZXNuJ3QgbG9vayBsaWtlIGl0
IGlzIG92ZXIgODAuIE1heWJlIGlmIHlvdSBwdXQgYWZ0ZXINCj4gJ2Rlc2NyaXB0aW9uOicgb24g
dGhlIHNhbWUgbGluZSwgYnV0IHRoYXQncyBub3Qgd2hhdCBJIHNhaWQuIEl0IGNhbg0KPiBzdGls
bCBiZSBvbiB0aGUgbmV4dCBsaW5lLiBObyAnfCcganVzdCBtZWFucyB0aGUgbGluZSBlbmRpbmdz
IGFyZW4ndA0KPiBmaXhlZC4gTm90IGltcG9ydGFudCBub3csIGJ1dCBpZiB3ZSB3ZXJlIHRvIGdl
bmVyYXRlIHByZXR0eQ0KPiBkb2N1bWVudGF0aW9uIGZyb20gdGhlIHNjaGVtYXMsIHRoZW4gaXQg
d291bGQgbWF0dGVyLg0KDQpBaCBJIHNlZS4gT0ssIEkgcmVtb3ZlZCB0aGUgfCBub3cgYW5kIGl0
IHdvcmtzIGZpbmUuIDopDQoNCj4gDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gPiA+ICsgIC0g
aWY6DQo+ID4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICAgICAgICBjb21wYXRp
YmxlOg0KPiA+ID4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ID4gPiArICAgICAgICAgICAg
ZW51bToNCj4gPiA+ID4gKyAgICAgICAgICAgICAgLSBzaWxhYnMsc2k1MzUxYQ0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAtIHNpbGFicyxzaTUzNTFhLW1zb3ANCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgLSBzaWxhYnMsc2k1MzUxYg0KPiA+ID4NCj4gPiA+IElzbid0IHRoaXMganVzdCB0aGUgJ2Vs
c2UnIGZvciB0aGUgbmV4dCBvbmU/IE9yIG1vcmUgcGFydHMgYXJlIGNvbWluZz8NCj4gPg0KPiA+
IE5vdCBzdXJlIGlmIG1vcmUgcGFydHMgYXJlIGNvbWluZyAtIHRoZXNlIGFyZSB0aGUgb25seSBv
bmVzIEkgYW0gYXdhcmUgb2YuIEJ1dCBJDQo+ID4gaGF2ZSBub3QgY2hlY2tlZCB0aG9yb3VnaGx5
LiBJIHRob3VnaHQgaXQgYmV0dGVyIHRvIGJlIGV4cGxpY2l0LCBidXQgSSB3aWxsDQo+ID4gY2hh
bmdlIHRoZSBuZXh0IG9uZSB0byBhbiBlbHNlOiBpbiB2MyB1bmxlc3MgeW91IGNoYW5nZSB5b3Vy
IG1pbmQuDQo+ID4NCj4gPiA+DQo+ID4gPiA+ICsgICAgdGhlbjoNCj4gPiA+ID4gKyAgICAgIHBy
b3BlcnRpZXM6DQo+ID4gPiA+ICsgICAgICAgIGNsb2NrczoNCj4gPiA+ID4gKyAgICAgICAgICBt
aW5JdGVtczogMQ0KPiA+ID4gPiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ICsgICAg
ICAgIGNsb2NrLW5hbWVzOg0KPiA+ID4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ID4gPiArICAg
ICAgICAgICAgLSBjb25zdDogeHRhbA0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIC0gaWY6DQo+ID4g
PiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+
ID4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ID4gPiArICAgICAgICAgICAgY29uc3Q6IHNp
bGFicyxzaTUzNTFjDQo+ID4gPiA+ICsgICAgdGhlbjoNCj4gPiA+ID4gKyAgICAgIHByb3BlcnRp
ZXM6DQo+ID4gPiA+ICsgICAgICAgIGNsb2NrczoNCj4gPiA+ID4gKyAgICAgICAgICBtaW5JdGVt
czogMQ0KPiA+ID4gPiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ID4gPiA+ICsgICAgICAgIGNs
b2NrLW5hbWVzOg0KPiA+ID4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiA+ICsgICAg
ICAgICAgaXRlbXM6DQo+ID4gPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiB4dGFsDQo+ID4gPiA+
ICsgICAgICAgICAgICAtIGNvbnN0OiBjbGtpbg0KPiA+ID4NCj4gPiA+IERlZmluZSBjbG9ja3Mg
YW5kIGNsb2NrLW5hbWVzIGF0IHRoZSB0b3AgbGV2ZWwgYW5kIGp1c3QgdXNlDQo+ID4gPiBtaW5J
dGVtcy9tYXhJdGVtcyBpbiB0aGUgaWYvdGhlbiBzY2hlbWFzLg0KPiA+DQo+ID4gSSB3YXMgdHJ5
aW5nIHRvIGltcGx5IGhlcmUgdGhhdCBpdCBpcyBpbnZhbGlkIHRvIHNwZWNpZnkgY2xraW4gZm9y
IHRoZSBmb3JtZXINCj4gPiB0aHJlZSBwYXJ0IHR5cGVzIC0gb25seSBmb3IgdGhlIHNpNTM1MWMu
IElmIEkgc3BlY2lmeSBib3RoIGluIHRoZSB0b3AtbGV2ZWwNCj4gPiBjbG9jay1uYW1lczppdGVt
cyB0aGVuIGl0IHdvdWxkIGFsbG93IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4NCj4gPiAgIGNs
ayB7DQo+ID4gICAgIGNvbXBhdGlibGUgPSAic2lsYWJzLHNpNTM1MWEtbXNvcCI7DQo+ID4gICAg
IGNsb2NrcyA9IDwmcmVmMjU+Ow0KPiA+ICAgICBjbG9jay1uYW1lcyA9ICJjbGtpbiI7IC8qIG5v
dCBPSyAtIFNpNTM1MUEtTVNPUCBvbmx5IHN1cHBvcnRzIFhUQUwgKi8NCj4gPiAgIH07DQo+IA0K
PiBXaGF0IEknbSBzYXlpbmcgd2lsbCB3b3JrLiBUaGVyZSBhcmUgbG90cyBvZiBleGFtcGxlcyBp
biB0aGUgdHJlZS4gVGhlDQo+IHRvcC1sZXZlbCBkZWZpbmVzIHRoZSBmdWxsIGFycmF5IGFuZCB0
aGVuIHRoZSBpZi90aGVuIHNjaGVtYSBqdXN0IHNldHMNCj4gdGhlIG1heCBzaXplIHRvIDEgc28g
dGhhdCB0aGUgY2xraW4gZW50cnkgaXMgbm90IGFsbG93ZWQuDQo+IA0KPiBwcm9wZXJ0aWVzOg0K
PiAgIGNsb2NrLW5hbWVzOg0KPiAgICAgbWluSXRlbXM6IDENCj4gICAgIGl0ZW1zOg0KPiAgICAg
ICAtIGNvbnN0OiB4dGFsDQo+ICAgICAgIC0gY29uc3Q6IGNsa2luDQo+IA0KPiBpZjoNCj4gICBw
cm9wZXJ0aWVzOg0KPiAgICAgY29tcGF0aWJsZToNCj4gICAgICAgY29udGFpbnM6DQo+ICAgICAg
ICAgY29uc3Q6IHNpbGFicyxzaTUzNTFhLW1zb3ANCj4gdGhlbjoNCj4gICBwcm9wZXJ0aWVzOg0K
PiAgICAgY2xvY2stbmFtZXM6DQo+ICAgICAgIG1heEl0ZW1zOiAxDQo+IA0KPiAoYW5kIHRoZW4g
Im1pbkl0ZW1zOiAyIiBmb3IgdGhlIGNhc2VzIHdpdGggMiBjbG9ja3MpDQoNClRoYW5rcyBSb2Is
IHlvdXIgc3VnZ2VzdGlvbiB3b3JrZWQhIEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gbm93Lg0K
DQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg==
