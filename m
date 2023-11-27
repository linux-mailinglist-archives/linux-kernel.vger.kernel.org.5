Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C97F96ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjK0A5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0A5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:57:09 -0500
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127410F;
        Sun, 26 Nov 2023 16:57:14 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 3AR0ideI2979085; Mon, 27 Nov 2023 09:44:40 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3AR0i3D52542568; Mon, 27 Nov 2023 09:44:04 +0900
X-Iguazu-Qid: 2yAacpQQBoyLJaNnJz
X-Iguazu-QSIG: v=2; s=0; t=1701045843; q=2yAacpQQBoyLJaNnJz; m=IvL9GODCEI/6/BlERHiwoxeYMIOmXzeZnyXX5D/3ONY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1801) id 3AR0i2Q51724097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Nov 2023 09:44:02 +0900
X-SA-MID: 12451971
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV/xPaWCRy76WBxop7JRQd3wGnqNbONMf0HUYgltA4S70hb283fnLMUXo1J7blsEODaoezACwu3ux1A/SCrQQRTca+wJpkOpknofbm1ZUQKO0Jb05EDCh+9NSGf/eAKP3ryCLCZ48XPONI9pgTPgkYqyUlTAT4BIfYD1fqx7GaRd6Zqwy6qCk+eTW30Q8JLqxUzuZA85XBXkZyEp3Q32bXMW8K+HvMGKj61tVwu84vw+GSgnDFXfZHn+vx/DUErZFlqYgpr9BwcCPRIie65h0FLn6wELfXFOZVZqO/psWq/5OPEn5G/kD0Gqjw2V/RbYjIvpM+Eb2TRLTurShKW9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLZsa5X4OxDbDEN9vLbo8G2S01z4gRnv7eJvblwTZzU=;
 b=jdXxNmagKFh2hN0GvWPJWZdfmLTE6uhlPiNtf9w7qWGRxBjeNRXQRAzkWSpPDw+Vneuze/3W3DcKgJdyGu3YXgK6iJwnNgW5gJ9il3/JdHiEhzRdiCrflwU6L9i13Uebh0Cta4/7767mFptIj379rteAOIYVJga27JIabmzEc28wdIcorBBmBh1D/xNbWew3ku2EuHXRyzG6JgI+8YpyfkE1OKQAAhDGLB1qDNqReKovhPsJaazVKte/NaSta3okn6UwCRPz8cR3T/Cw9KTFE7E35kMdEj1zECqzaAeHpdV46CFNkNmk3+T/YAzPLZ0qPe6lk5xGy2b+DggGYve37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 5/5] MAINTAINERS: Add entries for Toshiba Visconti
 Video Input Interface
Thread-Topic: [PATCH v9 5/5] MAINTAINERS: Add entries for Toshiba Visconti
 Video Input Interface
Thread-Index: AQHZ/NvbHB/dvsA2r0a9mhWUkDGv8bB5stGAgBPnWVA=
Date:   Mon, 27 Nov 2023 00:38:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62015CB80317567D6F9C4A5E92BDA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-6-yuji2.ishikawa@toshiba.co.jp>
 <767e3297-e1f9-483d-870e-67e75048b91a@xs4all.nl>
In-Reply-To: <767e3297-e1f9-483d-870e-67e75048b91a@xs4all.nl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TY1PR01MB10656:EE_
x-ms-office365-filtering-correlation-id: 5ff39a2a-b153-41b1-cdd6-08dbeee13cb7
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChgoYcYlfK0ArdfYNad/ABRqX6vdIHpQrtl0CoDsQgFbmph+bdaDkNu17xzX/rfuXansRTCBIVDTIdMJmWIeMDkmxiiRc1mZO/Up8/qNG4co5r+9KXua6N9IFIV4wNlVcq8pFEJzvDcYjN6A+NLeno/vvjv5yDuB9HUOPxi4VIlLge965F7eXPoAuYQGGfqYZ3FPFTH6FBUfr17mmD6qpp1sYd2yykwvzzQyFFlmPL6Yro9kOWFj7Fyof0wCa+DrP+b7mkCVdRfbxA+k1eB+SOR9SsJMRl63WbsmvDygk5Ft8loPT5Ilm+aFwMum20B222/2FzfvCBtAjG/SSJOfohOsLSFF9jnMgEWj6QxumL/bZ1VplK90Ma83HWfYVIswm5LtqsGoWAFzY05u5eZGub+Ks6wdv8cfpLM1f01vaJj/C7q57twRUj4x2uX1cKkB8bEtnL65L5AcjuGCLXlOMrxNht6lWq7Pt/rSY0vd5RnmuvO19GjfHYNcLNQyCQC+vo+tY6qw08UU+XVak7bKFea6BgvMRqEzwTj2fUiKa/atemtcMJaZXuW+Kqhm6KrN8ZULwvTmvf0bt4W1CGRpIr2lA0Cz52nyJfPQrCAcddHYcHR0sfSilOwVfDzSn8FL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(38070700009)(41300700001)(122000001)(2906002)(55016003)(33656002)(83380400001)(7416002)(5660300002)(64756008)(26005)(86362001)(6506007)(53546011)(4326008)(8676002)(8936002)(71200400001)(9686003)(52536014)(7696005)(478600001)(66476007)(66446008)(66946007)(66556008)(110136005)(54906003)(76116006)(316002)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JISjllQzdYUXhFNjNzUmVHZnhUeDdEaXpDSzA2UlhlUFErVndVUmpuMmJD?=
 =?utf-8?B?VVhqMHJTRjdPeFBFV0ZnOFdMbkRZSmdBa0tKR2E1a29Ddkd1SFFsektZOXpC?=
 =?utf-8?B?ZUVwQURBMU50TVRBaVBQZS9HSXo5V0N2L0NoNWJQN254ejE1Z1Vvc1hncEpu?=
 =?utf-8?B?L3RpRlo4UWxhdnJmdDJZSXVxNGtRUktESHduRHZlOVhQMXZ0VHFyMkxXZU5V?=
 =?utf-8?B?ZDNnL1l4Sko2WDRkNzBYZno4aFVIaUNOSCtIWCtIbzNlTHo2TkxkK3pqVHc5?=
 =?utf-8?B?V0xYb0tIUWVmV2RRWjR1SnZuZFRwbVlCeG1TZlFGenFoK0FjUnZRcE1vM1FX?=
 =?utf-8?B?cnhOUUZnTE5QQWpBNUN4Q21jVlc3WUlyZlgzTmZNeTBlZUtJa244bmtZU2ZQ?=
 =?utf-8?B?YWdOREdNaFMrckVqRG0xaFFQVm1ZeW0wUlEwRVo4QlhZWTFYRXNVazh0dVNS?=
 =?utf-8?B?K2l6VmxNTHBab0E4UzJWT0hKTU45S2xTOElaVXJiZVBVVWx3RTVxcCtDQ2g3?=
 =?utf-8?B?WWZOZ0Vmc1pHcHZVK0l3Q1gvNHF4bjNQSkwzcnNlc0hsQjByS3E5aHVXRTNn?=
 =?utf-8?B?dDN5Wk11aTRPSnMzNytWcnJ1OENqNXAzRnloTHZnTnVaV2ovRWk4TG5BaFEy?=
 =?utf-8?B?SlJQQVhuS2o1eDE0azJia1paMEVKUnk0ZEtWbTVxekI5d0haZjFvbFpHRmN0?=
 =?utf-8?B?UDVRUGg1TU9tOGdjTlNhKy9BUDhIeXQ0ekZHYWxSREhVaFAyMXBCSWMyZkEw?=
 =?utf-8?B?YmRoZE81V2tTQWkwTzZBNlpucjh5VWgweVdpU1l1WmdudDB3L0QwNS9wZm5z?=
 =?utf-8?B?RXpleHJBcXNBWkdqN3U1dUpjUFBnTS80QjNJTHZGWm9OTUJaRU03dWc0Y2Mr?=
 =?utf-8?B?MzY1eTBGYVJpNHpsSE5FcGtZZlZFa3lEQzNydHhHTUFHNlFyRGFrNDN0a0Zm?=
 =?utf-8?B?bjVJS20zZ25pZmVKei9SNjhHYXJudURUUVFEcXpmYjJzZ1pBeGpZK3YxbjV1?=
 =?utf-8?B?VEVMdG0zVDd3cjI4UWEvaHNNK2FKWkJjeDN0UUI4NmNkUDFEdWVteTJsb2F1?=
 =?utf-8?B?UXlFbTlhMkRxZkk1K1g0eE81UW5ETS9FS012bVVQOHdnRGRwNllvVXZHZ0J2?=
 =?utf-8?B?RWxITUdKNEtiV0hKOXEwdTY2VlVKTHEvRkh3TVNtMVFvbVdXSmMzT282azI4?=
 =?utf-8?B?dEVkY1NsTWxsOUJKYVRrUkFBcDc3c3ltQkphYmJtM2dZbFVvSjVJMzlwbGI0?=
 =?utf-8?B?NkRWS0dObTBrMitMQk9jZTBBa0Z3U21LWFFVUm0vNVozVVdlSmJYbDdyUnN5?=
 =?utf-8?B?MmxXK0t4azExRVdHeW1DRXY2WjRJQVNhc0RSeDg5d2VoOFlWUnNtSG5EMzZx?=
 =?utf-8?B?SEZldUttZS8vbHhyUyswdThnYjdYSldjU3hVWWNudGdYRHVtV1R3UVl5OUJN?=
 =?utf-8?B?SitrbllLK2NoZUlDc3Z5K2U2U1JrVjgrQm5NWUt5dG1nNlRzRUNla0pQZ1VO?=
 =?utf-8?B?SjV1eUpZcTZ6LzNVZU5pOTkwRGdiOVhGNzNUTTN5UkxMQXNMZ3dEeHVrcDJu?=
 =?utf-8?B?bHI5QlFIcSt0eWJDb0ZGdDVxWWxOZndGdmt5cHJxYitGVTZZaVZ6UU9BWFNi?=
 =?utf-8?B?VzUwWldmSGpuMXQvTGJ3WmhsaFpEQXdrQ1lxUkdlelVuS01vcHNaUk1iTllE?=
 =?utf-8?B?Ym1wWGEyKzRlT3ZPU0lDWGhTTUtTdXl2cURJYzZQeHdNd1dJbVFEdzdaeURp?=
 =?utf-8?B?WlFlcE9IVkxYS1FNVmdWTUZnZEtxUWRySUhsUlhsVkFoMzdORStWa3ZMMmV1?=
 =?utf-8?B?ZW5WbjJQSlZjQWkwMitVRVh0em93WGFPbVBUNlcwVnY2cTM5RVVXV1JmRFZO?=
 =?utf-8?B?anRMdmdUcnR6ZXg5Y2hmdHE4bzI2eWllaHczT1JzQ2FRd0M1VWtnZHVjOW1t?=
 =?utf-8?B?eWwvTnhFSDJRK1NSNTBJdGJoZTFwaWxtQ1FSVTQ5NzZDTmpFOG03UXRodmNr?=
 =?utf-8?B?a0FKSUVOOTExRWJkUytYVEI5blRUcEQ0NVNsc2J2a08xYm1wR2FmV1RUalcy?=
 =?utf-8?B?VHI0QXJKUjcxem54MkZIWGlZMVcwVy9uTDdtT1FLcnZCVVg0em15U1Vid1hp?=
 =?utf-8?B?Sm93NlJJWENIak9TQi85ckZaL0RuMzc3Yk1iUnp6a05ia3R0c1pRL01OTXoz?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff39a2a-b153-41b1-cdd6-08dbeee13cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 00:38:55.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzJ6oPp7F2tkz1Sw9EnNSNgV6iIHr1KnVPt7dvSFgGmcbLVH5QW0GIhp9jvQgdofYumyUzrkEnMBD/x3HXptawbZmHuaXIlkk4aqFNcJCvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10656
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSGFucywNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD4N
Cj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTQsIDIwMjMgNTo0MSBQTQ0KPiBUbzogaXNoaWth
d2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8
oemWiykNCj4gPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBMYXVyZW50IFBpbmNoYXJ0
DQo+IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBNYXVybyBDYXJ2YWxobyBD
aGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBpd2FtYXRz
dSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXiw0K
PiDvvK/vvLPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gQ2M6IGxp
bnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDUvNV0gTUFJTlRBSU5FUlM6IEFk
ZCBlbnRyaWVzIGZvciBUb3NoaWJhIFZpc2NvbnRpDQo+IFZpZGVvIElucHV0IEludGVyZmFjZQ0K
PiANCj4gT24gMTIvMTAvMjAyMyAwOToxMywgWXVqaSBJc2hpa2F3YSB3cm90ZToNCj4gPiBBZGRl
ZCBlbnRyaWVzIGZvciB2aXNjb250aSBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgZHJpdmVyLCBpbmNs
dWRpbmc7DQo+ID4gKiBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KPiA+ICogc291cmNlIGZpbGVzDQo+
ID4gKiBkb2N1bWVudGF0aW9uIGZpbGVzDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWppIElz
aGlrYXdhIDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPg0KPiA+IC0tLQ0KPiA+IENoYW5n
ZWxvZyB2MjoNCj4gPiAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gQ2hhbmdlbG9nIHYzOg0KPiA+IC0g
YWRkZWQgZW50cnkgZm9yIGRyaXZlciBBUEkgZG9jdW1lbnRhdGlvbg0KPiA+DQo+ID4gQ2hhbmdl
bG9nIHY0Og0KPiA+IC0gYWRkZWQgZW50cnkgZm9yIGhlYWRlciBmaWxlDQo+ID4NCj4gPiBDaGFu
Z2Vsb2cgdjU6DQo+ID4gLSBubyBjaGFuZ2UNCj4gPg0KPiA+IENoYW5nZWxvZyB2NjoNCj4gPiAt
IHVwZGF0ZSBwYXRoIHRvIFZJSUYgZHJpdmVyIHNvdXJjZSBmaWxlcw0KPiA+DQo+ID4gQ2hhbmdl
bG9nIHY3Og0KPiA+IC0gbm8gY2hhbmdlDQo+ID4NCj4gPiBDaGFuZ2Vsb2cgdjg6DQo+ID4gLSBy
ZW5hbWUgYmluZGluZ3MgZGVzY3JpcHRpb24gZmlsZQ0KPiA+DQo+ID4gQ2hhbmdlbG9nIHY5Og0K
PiA+IC0gbm8gY2hhbmdlDQo+ID4NCj4gPiAgTUFJTlRBSU5FUlMgfCA0ICsrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5U
QUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXgNCj4gPiBlYWExYTI4YTlkNTQuLjYwMzVmNzExYjNm
YiAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+
ID4gQEAgLTI5MDIsMTcgKzI5MDIsMjEgQEAgRjoNCj4gCURvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vdG9zaGliYS55YW1sDQo+ID4gIEY6DQo+IAlEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svdG9zaGliYSx0bXB2NzcweC1waXBsbGN0LnkNCj4gYW1s
DQo+ID4gIEY6DQo+IAlEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svdG9z
aGliYSx0bXB2NzcweC1waXNtdS55DQo+IGFtbA0KPiA+ICBGOglEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZ3Bpby90b3NoaWJhLGdwaW8tdmlzY29udGkueWFtbA0KPiA+ICtGOg0K
PiAJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3Rvc2hpYmEsdmlzY29u
dGk1LXZpaWYueWFtDQo+IGwNCj4gPiAgRjoNCj4gCURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvdG9zaGliYSx2aXNjb250aS1kd21hYy55YQ0KPiBtbA0KPiA+ICBGOglEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3Rvc2hpYmEsdmlzY29udGktcGNpZS55
YW1sDQo+ID4gIEY6DQo+IAlEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3Ry
bC90b3NoaWJhLHZpc2NvbnRpLXBpbmN0cmwueQ0KPiBhbWwNCj4gPiAgRjoNCj4gCURvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy90b3NoaWJhLHZpc2NvbnRpLXdkdC4N
Cj4geWFtbA0KPiA+ICtGOglEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbWVkaWEvZHJpdmVycy92
aXNjb250aS12aWlmLnJzdA0KPiA+ICBGOglhcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvDQo+
ID4gIEY6CWRyaXZlcnMvY2xrL3Zpc2NvbnRpLw0KPiA+ICBGOglkcml2ZXJzL2dwaW8vZ3Bpby12
aXNjb250aS5jDQo+ID4gK0Y6CWRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdG9zaGliYS92aXNjb250
aS8NCj4gPiAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtdmlz
Y29udGkuYw0KPiA+ICBGOglkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXZpc2NvbnRp
LmMNCj4gPiAgRjoJZHJpdmVycy9waW5jdHJsL3Zpc2NvbnRpLw0KPiA+ICBGOglkcml2ZXJzL3dh
dGNoZG9nL3Zpc2NvbnRpX3dkdC5jDQo+ID4gK0Y6CWluY2x1ZGUvdWFwaS9saW51eC92aXNjb250
aV92aWlmLmgNCj4gPiAgTjoJdmlzY29udGkNCj4gDQo+IFRoaXMgaXMgYSBiaXQgb2RkOiBpdCBh
ZGRzIHRoZSBkcml2ZXIgdG8gYW4gZXhpc3RpbmcgZW50cnksIGJ1dCB5b3UgZG8gbm90IGFkZA0K
PiB5b3Vyc2VsZiBhcyBtYWludGFpbmVyLiBUeXBpY2FsbHkgYSBsYXJnZSBkcml2ZXIgbGlrZSB0
aGlzIG9uZSB3aWxsIGhhdmUgaXRzIG93bg0KPiBlbnRyeS4NCj4gDQo+IEF0IG1pbmltdW0gSSBu
ZWVkIGFuIEFja2VkLWJ5IGZyb20gTm9idWhpcm8gSXdhbWF0c3UgZm9yIHRoaXMgY2hhbmdlLiBC
dXQgSQ0KPiB0aGluayBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gbWFrZSBhIHNlcGFyYXRlIGVudHJ5
IGZvciB0aGlzIGRyaXZlci4gVXAgdG8geW91LA0KPiB0aG91Z2guDQoNCkknbGwgbWFrZSBhIHNl
cGFyYXRlIGVudHJ5IGZvciBWaXNjb250aSBWSUlGIGRyaXZlci4NCkkgdGFsa2VkIGl0IG92ZXIg
d2l0aCBJd2FtYXRzdS1zYW4gYW5kIGhlIGFncmVlZC4NCkkgbmVlZCBBY2tlZC1ieSB0YWcgZnJv
bSBoaW0gYXQgdjEwIHBhdGNoIHN1Ym1pc3Npb247IGlzIGl0IGEgY29ycmVjdCB1bmRlcnN0YW5k
aW5nPw0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUhhbnMNCj4gDQo+ID4NCj4gPiAgQVJNL1VO
SVBISUVSIEFSQ0hJVEVDVFVSRQ0KDQpSZWdhcmRzLA0KWXVqaQ0K

