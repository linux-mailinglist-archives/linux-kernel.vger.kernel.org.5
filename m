Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1777B7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHNLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHNLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:52:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505610F9;
        Mon, 14 Aug 2023 04:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNz/SDro19cgFLhY4pdsnuGHgCEVHgvLGumqJwJRDyh5Q2E+FIgdjw4VWTVxPlK/hapiZUADQCIfUChkiQtqbICbowb++k7VEk7uDtF04ZcAjVp1eIpSBOah0RjJJCFXbl1JqbNZc6P/gdk8EXjR1o8sZKY7+TB+P3qm6nTG8fHNsAc3LcArcx4f0KLS2N1XK5INK5FR5u7pV9aYLtJ3PQkYJPSVbswUJOPgKnnEcXUs0YHm9fdB/1zL5GF46vhNWyAew6bAjFLXyOkX56E/BEDEuljznm65pZqQt1FnGp0a1QDsxY5kl5HhMCV5gjqkXaOSLKzYYdM7bHqHc9Vf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEfTpJMTb2LV1/NewlPcYIH5bzTpnc3XA14yqICrtp0=;
 b=PbT14mtGaOwQnvDBuECOVPXuP4VabPKzcJXZHqimuk6VlTqg1BuNUW1J9C7enn790mJNe12EPtaKNMFqSRriOHspSHYFlvLRx01tBGMzyq6gP5Iv2CisENmfxfgWfeT16/z/MGcjs6wvV39ig5LZSxFupAQqldHzHM4DVNwCzEAFMK3eLOdkBfXwIsK//gx70tTKaeMxr8P4O0UVlRyzYNhyRVZ1lkD3z0kR9HzcFD0T33QuJgvpxgKPNv+Rn0HcBPzMSZU2cST1Bo9nzRinnkaYCbf0EQqH1ReqtAcCaaNfc7JC5quoJI6/a2a4CK2bk3/I1NQOoBKeYGOgCPGlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEfTpJMTb2LV1/NewlPcYIH5bzTpnc3XA14yqICrtp0=;
 b=G0i0Q7+TLZSiXQOP9k+hWUvjkH5BwIuAi0DepFKxGoldjzUBF1eFC3WoXHH8gSHvPSW6dtBnl8GNLB4NJJMAVByzKN0zsmfufyHND4HbutSabvfpTUXuwj4BS/s1y1OFc0+vCSo4H5dsEaRtjEcUJSl7IhVLQy6Jc9rGbumsI9w=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:52:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:52:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
Thread-Topic: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
Thread-Index: AQHZzptKGRzeYjj+t0aib+FRuESMSq/pprEAgAAF8gA=
Date:   Mon, 14 Aug 2023 11:52:16 +0000
Message-ID: <DU0PR04MB941702FF9AAFFFBBB7740C978817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
 <20230814104127.1929-8-peng.fan@oss.nxp.com>
 <CAPDyKFqaA2q=jEYDwAE58vERcHC_rtNYpYf8TbvU80a29oFy3w@mail.gmail.com>
In-Reply-To: <CAPDyKFqaA2q=jEYDwAE58vERcHC_rtNYpYf8TbvU80a29oFy3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8408:EE_
x-ms-office365-filtering-correlation-id: 884afef5-85d4-4f4e-8647-08db9cbce7ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ShO38WpEoOyYBbVDT4xUSFsQVXKRKOoisVuBHrQSnX0IE0bp+03LsOfAHb1DZD3xiHjT8ghzjkhqZxSe3qwbpKwgcCd+vllJ60Qp+G8MW/l203Vsti7TtOIa/hLio0yHYQYRZ0onCHp2/bhcziv1UldAtbSipEhvin0Ca6jQIb7A5NIoELRlqZXGVkpDSzJsKNcuCSaiRm+qIDBnGrZSLmhsCX8rF5OuVgc5yU49cpwUJOYrqvMpnEkGl+MwROnJMoprc49i1fYPvbXjqZv6C1/YAupjYwzbuq78Iw0icIC9EMMVHECTRjdB2egNZvlutqbFnakbhH5LJaB7tsQJ1922ueUGkx2336h8hhDet2+WquTKdJO9X/kZIqDRunw0KAR/FNEm68yIpbr2GY9SdSbBbA2+ooWwBZxIWhlfK/RHaIsoxzPONcWQ+iJ0oRe+xqa+//g7huaV8HLgxThu5vlTQ/F9d927FQA2T2CGiDNeeXZPiVwmf40hpyZYqtQ4W36njWv1GP3aITj2Zfe0maU3RJOSh/BVunQoaYyD2e2jopPt3E7Z3BwprtvE/oI19HH5vTHPmRzDK6kLhf1DTm6efgV+4d8+44WzQHHst+HSxYb6Fp84loIyiRSMRdl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(33656002)(52536014)(5660300002)(86362001)(2906002)(44832011)(55016003)(83380400001)(66556008)(64756008)(4326008)(316002)(76116006)(66946007)(66476007)(54906003)(66446008)(38070700005)(38100700002)(110136005)(41300700001)(26005)(9686003)(6506007)(7696005)(8936002)(8676002)(71200400001)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhzVE00MjVNVUxvUGVUNEU3cCtqNkJ0Zm5LV2dpWjBzSmJETUFDYzR4dVVZ?=
 =?utf-8?B?ZlBFWDdVZUxkU1d0TG1vMFFVdStCbWFOL1hLbk9jTEkwbzJ5ZHVrclNiWnR0?=
 =?utf-8?B?KzFEZmhjak1LODhHNW94UlZwenltNkhCS2M3cnZyd0lDa2MxbE1ROURkaGpN?=
 =?utf-8?B?THQvblQ2cFhSVVVuOWk4UXp5R2YyYTRMS0F5cUpnRDJtMHhyRlBYeC9UWVRj?=
 =?utf-8?B?dlcwTncvd0FEL0EwbGpycWhIeXlxZjZwWTJZNFlJeWQwaE9iLytDSmhCRzVH?=
 =?utf-8?B?ZkpCMUJFYnlDanV1ZGRxOEN2dzRKYmN4OVQvQ1doRVJiUUp3Qnl3d2ZPQXAw?=
 =?utf-8?B?YnJwdzI5QUY2T3NrR0luV216UTNTUVFnWTh0TkNSTTJhVVhwU3lyTjFjUnlY?=
 =?utf-8?B?bmxWL21oeko2OFF1K0dlaFQ4Mmp1emxmSERYbmlleHVzZVVDR3ZKYTFvQXFX?=
 =?utf-8?B?R0g2YkYwT0dDVnM4aEFqb1FONlI4bzBUUTM4clBmV05xbGdjU3Qva2kyOWIy?=
 =?utf-8?B?YmUzSWdFeXMwb3YxWXdiK2NpZmRCZkRwS0dWRVlxdk5xUTc1K1FBbVVEKzlN?=
 =?utf-8?B?dmJ2RnZwbzZYQkNtcDBhWThiYnA2RWRDMWZCVE1WNU9hTW1yY0ZSeFZJWWZ5?=
 =?utf-8?B?U3NKZEc3R01WdjlUOUNPcHQzSTJIQlhLYXZqOFh4V1Axa1NMbzJlYXR3UUU4?=
 =?utf-8?B?MHBKVTd0ZFVFMnltNE8zRSt4ZHVxNks3Ri9XbTFyWWpxeHJ1ZHpTMmlwZnB6?=
 =?utf-8?B?ZDhXcml0ZmJ1Y2ZlTTVSRG95VmtReU8ySlUzKy9RZUxnekhPSWswMjcwQ21H?=
 =?utf-8?B?THVlbGJvcjV3eUJ1VG91L0UvWmdhOUM5WXRtZkpyajl2b2pHcEplQUo0WExD?=
 =?utf-8?B?clQ5MWdVR2gxT01wRGlDb3NlMDZ2YWlQdm11MTZuNTVyck1BKzRIVWsrK0FH?=
 =?utf-8?B?ZXc0S0lOeDdGOHNDQmpMODczNjBGK1RPN3BZeWNaUlQ3d255dEttYXU3Rzk0?=
 =?utf-8?B?dUZPdWJZc3N1aHY4S1NNY1MxZWpxbXYvVUw4NlhpRDNUbmFodyt2eWg0b1A0?=
 =?utf-8?B?dUFRR1o4SUFtQnN1MFpMakQ4czVJVG5ONlRzak9JUmhKVXIzZW95KzEyNUwv?=
 =?utf-8?B?ZTRjTlhheVg5M0V2K0huMmlyVk0xYTkrREl3aFRJcEcrS3RJRGl1eURadm5R?=
 =?utf-8?B?VGQ3dFhSL25FVGRocjJzRXJDWDI1QlgvZmZVMldvM2JVR0Y5YjB3MjZMS1Nw?=
 =?utf-8?B?T0c4ZThnTytZOEYyZ2lWSWN4OVFKbFNaVThGWENrcVNCRXF0Y3k3VXAvQTN5?=
 =?utf-8?B?ZXAybTFFOHFSQ0g3VGVudVJLVlkvMnVTTHZpTFczNWlnOGRSdGdlc2daYUpP?=
 =?utf-8?B?OGtmbTRNYnV5S3hYbmt2eUI3b2Q4ZTR5ditYdmVFVnNMdnJjTFRsT2w3Nkhl?=
 =?utf-8?B?ajMzY1YrSGUxRTg0T09HbHVadGNITmRYRmNDVjBHZGV3K2w3QjNWbklnRkx2?=
 =?utf-8?B?ajhRNVdXTFRsMWVLSUhMM3FFSTE3aWJDVmY4eVJUc2ErQlZycHJKSEpaZVcy?=
 =?utf-8?B?YXhMdTY1ZDEwbGNLMjZxQ3dpNGVVVERORE9jcWU5dGFHOEIzOGFPZEZpdGVB?=
 =?utf-8?B?RjFTRHZoLzBJNW4rU0R6dUJKWkNHL2hWdlhkSENVcGxHVzFLMnZ4cGE2YnFs?=
 =?utf-8?B?WWgyZGx2ZnRZRlM2aHM4ZTBCZ3FnNkNBRzNrUzVzOXEvL3RML0c1VEtCRk00?=
 =?utf-8?B?Tk5CQmdFYmFzZHN3VHp6RC84N2lHZ3NvUlRKVGdnVGoxcmozTXA0VCtHN0dl?=
 =?utf-8?B?YUJkSXRza3ZJUmx3R2oySTB4cTZuU3c2T1B1cEwxWm5zL3hXam1uU1c4SE14?=
 =?utf-8?B?cHdJc2dDYlBuaEpkaGRsTnNXQ2hMVUtaZFFSYlN5ZERJT29QdGtlRW5naTkw?=
 =?utf-8?B?bkhmYUdPeDgyVkhHaU1VbXJ2aW5jK2lncDJ4Vit2a3NGbmpsdjRNdVBaU0w5?=
 =?utf-8?B?V0gyb0hhZE9wMkE1R1dxQk42TmZEdm5VYXRIeThtL2JNK2IyNGJuWG5VcUYx?=
 =?utf-8?B?VzQ3OW9zMWgzT00zZ2NUbHpZVXAyQVA0YVhOTWh2c2F6dmcrbHVLbUFjZ1Bj?=
 =?utf-8?Q?b14o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884afef5-85d4-4f4e-8647-08db9cbce7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:52:16.1424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjvpqyDYcTTmK6L20Vfs+4E7m2b8yeZMU1avOCL5tOvlQMJtNCbv/Q8MKERDUVmdazbnis0cNTlEg+V9UlXp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDcvOF0gZ2VucGQ6IGlteDogc2N1LXBkOiBhZGQgbXVs
dGkgc3RhdGVzIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgMTQgQXVnIDIwMjMgYXQgMTI6MzcsIFBl
bmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBtdWx0aSBzdGF0
ZXMgc3VwcG9ydCwgdGhpcyBpcyB0byBzdXBwb3J0IGRldmljZXMgY291bGQgcnVuIGluIExQDQo+
ID4gbW9kZSB3aGVuIHJ1bnRpbWUgc3VzcGVuZCwgYW5kIE9GRiBtb2RlIHdoZW4gc3lzdGVtIHN1
c3BlbmQuDQo+IA0KPiBGb3IgbXkgdW5kZXJzdGFuZGluZywgaXMgdGhlcmUgYSBmdW5jdGlvbmFs
IHByb2JsZW0gdG8gc3VwcG9ydCBPRkYgYXQNCj4gcnVudGltZSBzdXNwZW5kIHRvbz8NCg0KSW4g
T0ZGIG1vZGUsIHRoZSBIVyBzdGF0ZSBpcyBsb3N0LCBzbyB0aGUgY2xrcyB0aGF0IGV4cG9ydGVk
IGJ5IHRoaXMoU3Vic3lzdGVtKQ0KZ2VucGQgaXMgbG9zdC4gV2hpbGUgaW4gTEYgbW9kZSwgbm8g
bmVlZCBoYW5kbGUgY2xrcyByZWNvdmVyLg0KDQoNClN1Y2ggYXMgc3Vic3lzdGVtIExTSU8gaGFz
IGNsa3Mgb3V0cHV0LCBoYXMgR1BJTywgaGFzIExQVUFSVC4NCg0KVGhlIGNsa3MgYXJlIGluIGRy
aXZlcnMvY2xrL2lteC9jbGstaW14OHF4cCosIHdoaWNoIHJlbGllcyBvbiB0aGUgc2N1IHBkLg0K
DQpJZiBzY3UtcGQgaXMgb2ZmLCB0aGUgY2xrcyB3aWxsIGxvc2Ugc3RhdGUuDQoNCj4gDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9nZW5wZC9pbXgvc2N1LXBkLmMgfCA0OA0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ2Vu
cGQvaW14L3NjdS1wZC5jIGIvZHJpdmVycy9nZW5wZC9pbXgvc2N1LXBkLmMNCj4gPiBpbmRleCAy
ZjY5M2I2N2RkYjQuLjMwZGExMDExMTllYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dlbnBk
L2lteC9zY3UtcGQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ2VucGQvaW14L3NjdS1wZC5jDQo+ID4g
QEAgLTY1LDYgKzY1LDEyIEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbV9kb21haW4uaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPg0KPiA+ICtlbnVtIHsNCj4gPiArICAgICAg
IFBEX1NUQVRFX0xQLA0KPiA+ICsgICAgICAgUERfU1RBVEVfT0ZGLA0KPiA+ICsgICAgICAgUERf
U1RBVEVfTUFYDQo+ID4gK307DQo+ID4gKw0KPiA+ICAvKiBTQ1UgUG93ZXIgTW9kZSBQcm90b2Nv
bCBkZWZpbml0aW9uICovICBzdHJ1Y3QNCj4gPiBpbXhfc2NfbXNnX3JlcV9zZXRfcmVzb3VyY2Vf
cG93ZXJfbW9kZSB7DQo+ID4gICAgICAgICBzdHJ1Y3QgaW14X3NjX3JwY19tc2cgaGRyOw0KPiA+
IEBAIC0zNjgsNyArMzc0LDggQEAgc3RhdGljIGludCBpbXhfc2NfcGRfcG93ZXIoc3RydWN0DQo+
IGdlbmVyaWNfcG1fZG9tYWluICpkb21haW4sIGJvb2wgcG93ZXJfb24pDQo+ID4gICAgICAgICBo
ZHItPnNpemUgPSAyOw0KPiA+DQo+ID4gICAgICAgICBtc2cucmVzb3VyY2UgPSBwZC0+cnNyYzsN
Cj4gPiAtICAgICAgIG1zZy5tb2RlID0gcG93ZXJfb24gPyBJTVhfU0NfUE1fUFdfTU9ERV9PTiA6
DQo+IElNWF9TQ19QTV9QV19NT0RFX0xQOw0KPiA+ICsgICAgICAgbXNnLm1vZGUgPSBwb3dlcl9v
biA/IElNWF9TQ19QTV9QV19NT0RFX09OIDogcGQtDQo+ID5wZC5zdGF0ZV9pZHggPw0KPiA+ICsg
ICAgICAgICAgICAgICAgICBJTVhfU0NfUE1fUFdfTU9ERV9PRkYgOiBJTVhfU0NfUE1fUFdfTU9E
RV9MUDsNCj4gPg0KPiA+ICAgICAgICAgLyoga2VlcCB1YXJ0IGNvbnNvbGUgcG93ZXIgb24gZm9y
IG5vX2NvbnNvbGVfc3VzcGVuZCAqLw0KPiA+ICAgICAgICAgaWYgKGlteF9jb25fcnNyYyA9PSBw
ZC0+cnNyYyAmJiAhY29uc29sZV9zdXNwZW5kX2VuYWJsZWQgJiYNCj4gPiAhcG93ZXJfb24pIEBA
IC00MTIsMTEgKzQxOSwzMyBAQCBzdGF0aWMgc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluDQo+ICpp
bXhfc2N1X3BkX3hsYXRlKHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKnNwZWMsDQo+ID4gICAgICAg
ICByZXR1cm4gZG9tYWluOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgaW14X3NjX3Bk
X3N1c3BlbmRfb2soc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKyAgICAgICAvKiBBbHdheXMg
dHJ1ZSAqLw0KPiA+ICsgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBib29sIGlteF9zY19wZF9wb3dlcl9kb3duX29rKHN0cnVjdCBkZXZfcG1fZG9tYWluICpw
ZCkgew0KPiA+ICsgICAgICAgc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCA9IHBkX3Rv
X2dlbnBkKHBkKTsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBGb3IgcnVudGltZSBzdXNwZW5kLCBj
aG9vc2UgTFAgbW9kZSAqLw0KPiA+ICsgICAgICAgZ2VucGQtPnN0YXRlX2lkeCA9IDA7DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gDQo+IEkgYW0gd29uZGVyaW5n
IGlmIHdlIGNvdWxkbid0IHVzZSB0aGUgc2ltcGxlX3Fvc19nb3Zlcm5vciBoZXJlIGluc3RlYWQu
IEluDQo+IHByaW5jaXBsZSBpdCBsb29rcyBsaWtlIHdlIHdhbnQgYSBRb1MgbGF0ZW5jeSBjb25z
dHJhaW50IHRvIGJlIHNldCBkdXJpbmcNCj4gcnVudGltZSwgdG8gcHJldmVudCB0aGUgT0ZGIHN0
YXRlLg0KDQpMUCBtb2RlIGluZGVlZCBjb3VsZCBzYXZlIHJlc3VtZSB0aW1lLCBidXQgdGhlIG1h
am9yIHByb2JsZW0gaXMgdG8gYXZvaWQNCnNhdmUvcmVzdG9yZSBjbGtzLg0KPiANCj4gRHVyaW5n
IHN5c3RlbSB3aWRlIHN1c3BlbmQsIHRoZSBkZWVwZXN0IHN0YXRlIGlzIGFsd2F5cyBzZWxlY3Rl
ZCBieSBnZW5wZC4NCj4gDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgZGV2X3Bvd2VyX2dvdmVybm9yIGlt
eF9zY19wZF9xb3NfZ292ZXJub3IgPSB7DQo+ID4gKyAgICAgICAuc3VzcGVuZF9vayA9IGlteF9z
Y19wZF9zdXNwZW5kX29rLA0KPiA+ICsgICAgICAgLnBvd2VyX2Rvd25fb2sgPSBpbXhfc2NfcGRf
cG93ZXJfZG93bl9vaywgfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgaW14X3NjX3BtX2Rv
bWFpbiAqDQo+ID4gIGlteF9zY3VfYWRkX3BtX2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYsIGlu
dCBpZHgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBpbXhfc2NfcGRf
cmFuZ2UgKnBkX3JhbmdlcykgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBpbXhfc2NfcG1fZG9tYWlu
ICpzY19wZDsNCj4gPiArICAgICAgIHN0cnVjdCBnZW5wZF9wb3dlcl9zdGF0ZSAqc3RhdGVzOw0K
PiA+ICAgICAgICAgYm9vbCBpc19vZmY7DQo+ID4gICAgICAgICBpbnQgbW9kZSwgcmV0Ow0KPiA+
DQo+ID4gQEAgLTQyNyw5ICs0NTYsMjIgQEAgaW14X3NjdV9hZGRfcG1fZG9tYWluKHN0cnVjdCBk
ZXZpY2UgKmRldiwgaW50DQo+IGlkeCwNCj4gPiAgICAgICAgIGlmICghc2NfcGQpDQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+DQo+ID4gKyAgICAgICBz
dGF0ZXMgPSBkZXZtX2tjYWxsb2MoZGV2LCBQRF9TVEFURV9NQVgsIHNpemVvZigqc3RhdGVzKSwN
Cj4gR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgICBpZiAoIXN0YXRlcykgew0KPiA+ICsgICAgICAg
ICAgICAgICBkZXZtX2tmcmVlKGRldiwgc2NfcGQpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBz
Y19wZC0+cnNyYyA9IHBkX3Jhbmdlcy0+cnNyYyArIGlkeDsNCj4gPiAgICAgICAgIHNjX3BkLT5w
ZC5wb3dlcl9vZmYgPSBpbXhfc2NfcGRfcG93ZXJfb2ZmOw0KPiA+ICAgICAgICAgc2NfcGQtPnBk
LnBvd2VyX29uID0gaW14X3NjX3BkX3Bvd2VyX29uOw0KPiA+ICsgICAgICAgc3RhdGVzW1BEX1NU
QVRFX0xQXS5wb3dlcl9vZmZfbGF0ZW5jeV9ucyA9IDI1MDAwOw0KPiA+ICsgICAgICAgc3RhdGVz
W1BEX1NUQVRFX0xQXS5wb3dlcl9vbl9sYXRlbmN5X25zID0gIDI1MDAwOw0KPiA+ICsgICAgICAg
c3RhdGVzW1BEX1NUQVRFX09GRl0ucG93ZXJfb2ZmX2xhdGVuY3lfbnMgPSAyNTAwMDAwOw0KPiA+
ICsgICAgICAgc3RhdGVzW1BEX1NUQVRFX09GRl0ucG93ZXJfb25fbGF0ZW5jeV9ucyA9ICAyNTAw
MDAwOw0KPiANCj4gV2Ugc2hvdWxkIHByb2JhYmx5IGRlc2NyaWJlIHRoZXNlIGluIERUIGluc3Rl
YWQ/IFRoZSBkb21haW4taWRsZS1zdGF0ZXMNCj4gYmluZGluZ3MgYWxsb3dzIHVzIHRvIGRvIHRo
aXMuIFNlZQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvZG9tYWlu
LWlkbGUtc3RhdGUueWFtbC4NCg0KVGhlIHNjdS1wZCBpcyBhIGZpcm13YXJlIGZ1bmN0aW9uIG5v
ZGUsIHRoZXJlIGlzIG5vIHN1Yi1nZW5wZCBub2RlIGluc2lkZSBpdC4NCg0KSnVzdCBsaWtlIHNj
bWkgcGQsIHRoZXJlIGlzIG5vIHN1Yi1nZW5wZCBpbiBpdC4NCg0KDQpUaGFua3MsDQpQZW5nLg0K
DQo+IA0KPiBUaGVuIHdlIGhhdmUgb2ZfZ2VucGRfcGFyc2VfaWRsZV9zdGF0ZXMoKSwgYSBoZWxw
ZXIgdGhhdCBwYXJzZXMgdGhlIHZhbHVlcy4NCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgc2NfcGQt
PnBkLnN0YXRlcyA9IHN0YXRlczsNCj4gPiArICAgICAgIHNjX3BkLT5wZC5zdGF0ZV9jb3VudCA9
IFBEX1NUQVRFX01BWDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKHBkX3Jhbmdlcy0+cG9zdGZpeCkN
Cj4gPiAgICAgICAgICAgICAgICAgc25wcmludGYoc2NfcGQtPm5hbWUsIHNpemVvZihzY19wZC0+
bmFtZSksIEBAIC00NTUsMTQNCj4gPiArNDk3LDE2IEBAIGlteF9zY3VfYWRkX3BtX2RvbWFpbihz
dHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
IHNjX3BkLT5uYW1lLCBzY19wZC0+cnNyYyk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgZGV2
bV9rZnJlZShkZXYsIHNjX3BkKTsNCj4gPiArICAgICAgICAgICAgICAgZGV2bV9rZnJlZShkZXYs
IHN0YXRlcyk7DQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiA+ICAgICAgICAg
fQ0KPiA+DQo+ID4gLSAgICAgICByZXQgPSBwbV9nZW5wZF9pbml0KCZzY19wZC0+cGQsIE5VTEws
IGlzX29mZik7DQo+ID4gKyAgICAgICByZXQgPSBwbV9nZW5wZF9pbml0KCZzY19wZC0+cGQsICZp
bXhfc2NfcGRfcW9zX2dvdmVybm9yLA0KPiA+ICsgaXNfb2ZmKTsNCj4gPiAgICAgICAgIGlmIChy
ZXQpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiZmFpbGVkIHRvIGluaXQg
cGQgJXMgcnNyYyBpZCAlZCIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHNjX3BkLT5u
YW1lLCBzY19wZC0+cnNyYyk7DQo+ID4gICAgICAgICAgICAgICAgIGRldm1fa2ZyZWUoZGV2LCBz
Y19wZCk7DQo+ID4gKyAgICAgICAgICAgICAgIGRldm1fa2ZyZWUoZGV2LCBzdGF0ZXMpOw0KPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0t
DQo+ID4gMi4zNy4xDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
