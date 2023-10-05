Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959D7BA07A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjJEOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjJEOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:56 -0400
X-Greylist: delayed 3745 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 06:38:25 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [IPv6:2001:240:bb81::4:1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF4C27B1A;
        Thu,  5 Oct 2023 06:38:25 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 395Ca0dC042974; Thu, 5 Oct 2023 21:36:00 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 395CZLco1883460; Thu, 5 Oct 2023 21:35:22 +0900
X-Iguazu-Qid: 2yAbOubUDSqMlhOYnA
X-Iguazu-QSIG: v=2; s=0; t=1696509321; q=2yAbOubUDSqMlhOYnA; m=VUNHFsTl1nPRmHHKyWIAxdZZizjOhBpf8fNEBA6DF1c=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1802) id 395CZJfT478147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 5 Oct 2023 21:35:20 +0900
X-SA-MID: 8267000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/gDJmnEfUTjKQL1GbHdo2ER/NNpAbZO+N3Y6P6ki2zVmEp2TFhogo7vSiEaMrVRY7yZT720RkKTuVKA53AXR5EV1ObZ8NmsTXzZQF7MxdsLHEdLmiWigIgeRhjpwdHjtbmePnu08xLO7KE02uv0zI/xYCZWsVlyPGW22vQt6OOfBwbqjqrJBVYKhI2u36jRu4C5qVkhr7OJTfkuHGx/zfFOpocmDrn5htZTlWK6+a/7jOVjSn4sZg6WJLBVnXNxbMbQJRtXnONwHl/IdyuWuz2XjaWUcSYRWWAjziFGe4OKBLFtUm7rRYR2vgsZ5HtdINnUsKyFlMUSMdoARA+Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvR4HrchB1Poci4oVJ7RnkW6XdQC34xfe/uScxUkVnY=;
 b=Ymsff+r5Eld6OyOFQtJJv8bntkZGPKH5TH+zpWRTCvnZG2V0dGJNl6SsZyB3kHuEYbe0kVlbC/7Jl2XViMGmhxW/249kQ99GCeQ7jWw7+r+WHUb66ih7sfVyUHtId1wZFfvq10uxDCSF35sLmytCWGYvubt/Rvy6NgrPOHNpSE9yb9tSGeVj2whl0kBf46JGiWoV5s4gWb9P/+MUA8saaGaNl8QsVqCJ+xzYS79xh6Q52jYJduKzisWDFI6E1llaPjFP8A9OigAcJ9RpJep2ZEmoiykecK0syjGVIhGaeIKjYVPuDcfGAr6uwvD369v62e+ToTHOq5+7F/eQVUOmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Thread-Topic: [PATCH v8 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Thread-Index: AQHZ8AgkTX0oYXPBH0yGWNLApT8XbbAvujwAgAE7bHCACEiggIAAH5Xw
Date:   Thu, 5 Oct 2023 12:30:13 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62017DD4EEF22EF91D9FA03892CAA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
 <20230925232806.950683-2-yuji2.ishikawa@toshiba.co.jp>
 <c58ffc72-59d9-49f5-be22-18588f7df1e3@linaro.org>
 <TYAPR01MB6201C2E34B969197C9E9DFB492C4A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <8a936a54-9c20-4a3b-ac2c-ae65cd22698f@linaro.org>
In-Reply-To: <8a936a54-9c20-4a3b-ac2c-ae65cd22698f@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB12110:EE_
x-ms-office365-filtering-correlation-id: 5ffac6fb-53a7-4bcf-9e2d-08dbc59ed31f
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQDBDtlmJG64MLnC1oBkcHMXRaX0fVVs2ezJODvJ5/GHMT7NKoY8FqKn/P/9mjoS6U659nLTsIUbxNa0BJVrFXYXLjqga+nC5+AIrhR74R9TDn7F2T2DYei5ozLFyfTqZLs35e3DG6n7/kIXIWs5a0jWZi04b3vQ6En9i9ho1oqg/K4urfyUgIrm8ozJzZCg/TVu29q+CBX2jHOxe6FfVDt2JoqULcG1y8kPJki4D86FbKI0tnsZhq5dYAzLspAnON6rp//eMmkHdZf70h0qt5WrGqBLAjFWyYSW6AVZSgyEyDc9m/K+ds5NmdKX04JRB8cvl8cFTUvSK5nZXG5riMWB9RaYdjl+5B/2LGllkXGhgUmQRFfDwIfbATlTDZM/LXbK0q4ELi+orWwoLaazGoQJc8NnGQiCawxUCl5NKwO2EIsVVdvfBvkNXY284KkSbiUpO+VCGygiVa+WHS0chthjTmF+0uoKvzFUjlU7UFGQBNnD1drBieG+EZCSHr69cbhpWOpYpATNCHQ+wFlkgDbt3z6qX2BvRd2X6VDshw+OHdvhCBcBAZ3J0VJCZtiR9NXEXQxSEyAKL6cHKp++m6+fbLl1C86KfzpqS+MrwZHL1IGIDDfsjfQ+s9F9z5uC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(478600001)(966005)(6506007)(26005)(33656002)(55016003)(7696005)(53546011)(122000001)(9686003)(2906002)(5660300002)(54906003)(4326008)(8936002)(38070700005)(71200400001)(38100700002)(6636002)(8676002)(64756008)(316002)(52536014)(41300700001)(66556008)(66946007)(66446008)(76116006)(110136005)(66476007)(7416002)(86362001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjNqU1hQOUFER3hJMUxkaGZua3F6RlFQdkVXZnZFaU1FcGdBRFlRenVzdjg2?=
 =?utf-8?B?ck1TZVlNVDcwbUNrS1ZKRGNyRFBwU1dsQWxsSnE2U1ZaWUVLb3RQa2V6V1ZS?=
 =?utf-8?B?RkptRTlOMkQzaUhValFOZzBEZ1RpbjZrS2xzN1VueENBaGc1RXhpNUlvemdv?=
 =?utf-8?B?S2dFZUloc28rbkdvY1RoTm1qenRNQUw1MDVqK3UvZlhaS2xRVjE4MXhHbXZU?=
 =?utf-8?B?TmY2TTloYnVjMnRmb3NYWlFoVnd6b2xtVUtYMDZLSHg0eFdrL2NGVXNHcER5?=
 =?utf-8?B?TFhOTGNISEZpYUkzMGlhSU1iNzdrUUJqQVZRTUVVQklRSGNsRTg0ZjFkWjFx?=
 =?utf-8?B?VTBhRExrOTd5RGNQeUxGNTgzUS85QnplZ0xNSWpjRU94QjFpUlNkemhhc25H?=
 =?utf-8?B?TE81NEFiakFKVGdVTzZNUWgrMjQ1WjlBZ3RzOHZndytocDRLYnBWU3B3OWcr?=
 =?utf-8?B?UzhCVXZ4TFRxcVJyTjFtenFqb2grZVRtWFdBMEVGdzRLdjIrSkJHTWt1N3p3?=
 =?utf-8?B?Z0xJSWlRZGpQc3dhMkpUdk9ma0NhL2k0UUZsdjN1bnBYK3pDU2FqMFNOMENz?=
 =?utf-8?B?SGpSZ0UrMG9YNFV4QmdQaEdWdDlvNGZNT2VkRnhJeUg1QWVYYzhmUmk4NnNW?=
 =?utf-8?B?V2JJTGxvNDV4QUlaUlRPQXYxR1dlTHgzamp0NkVFQmpMQ0Y1eGhaOVMzMGtQ?=
 =?utf-8?B?endmLzdoaUdRVWxLKzROa2lHZm5tM1l6VXh2dnpReTJEZjJCL0pXZFNKWlVR?=
 =?utf-8?B?WnFMcWxPZlRibGpock5QdjdXazlJK1Uva01HdCtJUHExNHJFTEw1aE1mUUNv?=
 =?utf-8?B?NXRDaW1BcDU1R1djY3lRRDhOWWNyMngrWTBtV2ZhVldVKzc2V0tDMGpuYXEx?=
 =?utf-8?B?S3AwNm1mb3dpVkVXeDlkVC8yU0ZPVFZSMm4yZGJsZkEzN2xvWkF2Y2RLcmxR?=
 =?utf-8?B?TTBOeExzdWxSbmcwTjZydEliN1FieVkwUTFMYlVsbFNZeDIrZDNEYndvTUp5?=
 =?utf-8?B?YWQrTUpvSy9JU3VJejNRU3FOQU9kOGJMNTNVTTFLU1BmanBUNTZkRFdkKzgz?=
 =?utf-8?B?eXBFWHBVbEZvWXpHRENNclRVSWFvWWFvZUozcDExQys4UHVBdlFRNmpkU2dU?=
 =?utf-8?B?K05yQXFzZk1qSFhZdXc4eEt2VUgxUWxsb1Q3a2RlZXpMV0RjalJ5QjJpRHFr?=
 =?utf-8?B?Y3dyZUk4MXNUYUNzY2M0b3I5d1d3L3NQV21RRjhzVzBNYlJ2MnZSeG9mSE9r?=
 =?utf-8?B?T0sxV2V2ckREbDgzLzBvM2dGbmtORUlvN0ZYbEtSbThjS0xLN2pIZjI3RGpz?=
 =?utf-8?B?V2MxMVR4ZTVuNjdJVVlra1gxVElreG9xTWJGcTFGRUpUL1lNNXhqdm5YN05t?=
 =?utf-8?B?NUZUa1dBTkZGdGdqMlFtMjJJQkNQeG9rRktDdkZQTTdZa2xPbUwzTWJybUJS?=
 =?utf-8?B?WWlia05IanVPdHp4RFdDdFRMVGdPMHlFK1lmK0VMTlluQnFtZ0R3V3dlMW4w?=
 =?utf-8?B?Y29aSVFjU1MyVi9VdVdqWHp3blJRbDAxZk14bm53dThXd0tEYUpYVnhHcUxN?=
 =?utf-8?B?bk1mSjJhYkt6dmRCQzVMTC9Jc1NXRExsVlZZbVdudE13cTJVbExZWlYzcGU3?=
 =?utf-8?B?VzJoOXJjbXpVYzBKSzRnOW1YNjBkMmZIUHJFUk5rRU41WjFOZ3V4S1JodUpk?=
 =?utf-8?B?VmVIT2w3VW9rZ0x6RHQ0ZmhHWW5GaWlKbE9PMnhTOXlQSHZ0K1RRVXFqTW9q?=
 =?utf-8?B?ZGhob1daVytRV3Y5Z1U2a2c3RnN6VWRRcVpGVnB3QklqbytGL0FUMktlOEVY?=
 =?utf-8?B?eGkrbmNFS2p0RFVSeGM2dDE0U2JvL1JwMEN1TXd0RjM3OHRMYnB1K0hLWTRP?=
 =?utf-8?B?VzBmaHRlODUzZ3ZNYzJjNGRMRHBzQ0tYK1F3cWVIb21OeWdWZ3hSVmpsMmp0?=
 =?utf-8?B?bEw2a3dFcnNRaGJsbDdsekYveGRkYkZrcWVFVE83MXNSSGJjYzlTckdrZ2ZO?=
 =?utf-8?B?NHc5YkJtWFJ3aXkwNW51Vlg5T3YxSzhoYTB0NE5URG81QmxFVHp5ZGJWL0xT?=
 =?utf-8?B?T3RHeGxOMCt0K1EzWVdURVdRUW1CenEydXdjbndGLzMvVG10MmlxV3ljWEgv?=
 =?utf-8?B?RHE2NGhQcW02L09oeEVhQzVlS3ZHeDdLRTZjbDQwUHZIUHBwREJ0VzhvWnls?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffac6fb-53a7-4bcf-9e2d-08dbc59ed31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 12:30:14.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egDAuK0kh3g1Bp0c0MIys3gywDAMa87LZm66cwRnTdGucQNHAlnlAIXmVS48dDAKDJ8D+Qhm4FWL5A/gq8bkPtIlMzlPd/7z+u2/z4WmwvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12110
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDQsIDIwMjMgMzo1MSBQTQ0KPiBUbzogaXNoaWthd2Eg
eXVqaSjnn7Plt50g5oKg5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemW
iykNCj4gPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBodmVya3VpbEB4czRhbGwubmw7
DQo+IGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbTsgbWNoZWhhYkBrZXJuZWwub3Jn
Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQpDQo+IDxub2J1aGlybzEu
aXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY4IDEvNV0gZHQtYmluZGluZ3M6IG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6
IEFkZCBUb3NoaWJhDQo+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVyZmFjZQ0KPiANCj4gT24g
MDQvMTAvMjAyMyAwMToxMCwgeXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcCB3cm90ZToNCj4g
Pj4+ICsgICAgcHJvcGVydGllczoNCj4gPj4+ICsgICAgICBlbmRwb2ludDoNCj4gPj4+ICsgICAg
ICAgICRyZWY6IHZpZGVvLWludGVyZmFjZXMueWFtbCMNCj4gPj4+ICsgICAgICAgIGFkZGl0aW9u
YWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+Pg0KPiA+PiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5k
ZXIgZHVyaW5nIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gPj4NCj4gPj4gSXQgc2VlbXMgbXkgcHJl
dmlvdXMgY29tbWVudHMgd2VyZSBub3QgZnVsbHkgYWRkcmVzc2VkLiBNYXliZSBteQ0KPiA+PiBm
ZWVkYmFjayBnb3QgbG9zdCBiZXR3ZWVuIHRoZSBxdW90ZXMsIG1heWJlIHlvdSBqdXN0IGZvcmdv
dCB0byBhcHBseSBpdC4NCj4gPj4gUGxlYXNlIGdvIGJhY2sgdG8gdGhlIHByZXZpb3VzIGRpc2N1
c3Npb24gYW5kIGVpdGhlciBpbXBsZW1lbnQgYWxsDQo+ID4+IHJlcXVlc3RlZCBjaGFuZ2VzIG9y
IGtlZXAgZGlzY3Vzc2luZyB0aGVtLg0KPiA+Pg0KPiA+PiBUaGFuayB5b3UuDQo+ID4NCj4gPiBJ
J20gdmVyeSBzb3JyeSB0aGF0IEkgbWlzdW5kZXJzdG9vZCB0aGUgaW50ZW50IG9mIHRoZSBsYXN0
IGNvbnZlcnNpb24uDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzBhYTQ3MWNlLWRh
ODMtMTcyZC1kODcwLTFlYzdhNTYyYmFmN0BsaW5hcg0KPiA+IG8ub3JnLyBJIHRob3VnaHQgImFk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSIgY2FuIGJlIHVzZWQgYW5kDQo+ID4gInh4eDp0cnVl
IiBzaG91bGQgc3RheS4NCj4gPg0KPiA+IExldCBtZSBjb25maXJtIHlvdXIgaW50ZW50aW9uczoN
Cj4gPiAgIC0gInVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UiIHNob3VsZCBiZSB1c2VkIGlu
c3RlYWQgb2YNCj4gImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSINCj4gPiAgIC0gQWxsIG9m
ICJ4eHg6IHRydWUiIHNob3VsZCBiZSByZW1vdmVkIEFyZSB0aGVzZSB0d28gY29ycmVjdA0KPiA+
IHVuZGVyc3RhbmRpbmdzPw0KPiANCj4gQWgsIHRydWUsIEkgbWlzc2VkIHRoYXQuIEl0IGlzIGlu
ZGVlZCBmaW5lLCBhcG9sb2dpZXMuDQo+IA0KDQpJIHVuZGVyc3RhbmQuIEknbGwgdXNlICJhZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UiLg0KDQo+ID4NCj4gPj4+ICsNCj4gPj4+ICsgICAgICAg
IHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgICAgIGRhdGEtbGFuZXM6DQo+ID4+PiArICAgICAg
ICAgICAgZGVzY3JpcHRpb246IFZJSUYgc3VwcG9ydHMgMSwgMiwgMyBvciA0IGRhdGEgbGFuZXMN
Cj4gPj4+ICsgICAgICAgICAgICBtaW5JdGVtczogMQ0KPiA+Pj4gKyAgICAgICAgICAgIGl0ZW1z
Og0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBjb25zdDogMQ0KPiA+Pj4gKyAgICAgICAgICAgICAg
LSBjb25zdDogMg0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBjb25zdDogMw0KPiA+Pj4gKyAgICAg
ICAgICAgICAgLSBjb25zdDogNA0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgICBjbG9jay1ub25j
b250aW51b3VzOiB0cnVlDQo+ID4+DQo+ID4+IERyb3ANCj4gDQo+IFRoaXMgYW5kIGZ1cnRoZXIg
Y2FuIGJlIGlnbm9yZWQuDQoNCkknbGwga2VlcCAieHh4OiB0cnVlIi4NCg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KDQpCZXN0IHJlZ2FyZHMsDQpZdWppDQo=

