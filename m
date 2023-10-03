Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00507B748E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjJCXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:15:57 -0400
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF41A6;
        Tue,  3 Oct 2023 16:15:52 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 393NFHU92655521; Wed, 4 Oct 2023 08:15:17 +0900
X-Iguazu-Qid: 2rWhdxlJIwucQo3dwM
X-Iguazu-QSIG: v=2; s=0; t=1696374916; q=2rWhdxlJIwucQo3dwM; m=++s+BmNwhnG4oixi1NgeEQ86YPWRgl171AJFY0KZNrw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1120) id 393NFEBk1513269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 4 Oct 2023 08:15:15 +0900
X-SA-MID: 8126196
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfrRLnKV/yathq0zb/UE/xLIKE5+lfZlUzjkM2tUujQxB7491+7s4ZWpwzJylT1oyRXi+o9sqcTlaFyX+d/bTmkX4xzJGOiXveeMFOSWuzaKRK8Ypd65EwQSe4XU2cVgQim18yyNvA9QDRDFoOyvRlZ3zhKJQKIvR62XN7J0WmHXa4TvMlzV4OPD6F8p3RaMmjPqcGztJo41tKjEF5hVOjTP0fSxasDW8/ENvQbcJ58xEPHGM9hIymvL+OoDWYWt6w4uX4G3Sp0soM+0o/PH6u1QDtIm+Dm9dVl5cOsDGG9h1q5tptC4Fp2y/57a3GoTa766D2HVfpzR7H36C1BujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lMuqgjnD9v265ksq4ypswVAp1+ycXCxgLAV6iQFUhY=;
 b=V4X+WbonkUsRDbebrxqH+gRPN7WTTiLAK3742dyZjrC5PCBIeaul+AO71lKUImsCQMI3eyGL58C2eD3+4AqcvG+8/otkLlMuGSw4dR1zZeuM+S7BYbvSD3ME5hErb8H7adnEv7BqreipYJDxHBeRG10hq/4wwKzIjXLL6uGlqh6a/DebCAI/E+FUpXVsCQ4dMS3nyON2DLdMqNFfBGBXCWJkXyitT8z6+oMuWoWnld3w5rQKoefMBlhgG/nPXzpA5DyD5WzZJm9VL1Jjz26fw6Fyy4dyKsnSz9NECw7iBxG3a5OZ53R/j36Up13fnyY5ntYjH9mokAeJN0gA/wVjsw==
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
Thread-Index: AQHZ8AgkTX0oYXPBH0yGWNLApT8XbbAvujwAgAE7bHA=
Date:   Tue, 3 Oct 2023 23:10:10 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201C2E34B969197C9E9DFB492C4A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
 <20230925232806.950683-2-yuji2.ishikawa@toshiba.co.jp>
 <c58ffc72-59d9-49f5-be22-18588f7df1e3@linaro.org>
In-Reply-To: <c58ffc72-59d9-49f5-be22-18588f7df1e3@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYWPR01MB8284:EE_
x-ms-office365-filtering-correlation-id: 574167bd-fc74-44f3-df23-08dbc465e480
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yo5+JxdJd9uaPPART23xsgObM6d7cwdR7AgVUGfK3NOk7coke8c3lj2MV5Bs7JCCwq1wFsrzvG4rBqMNtKMvPWuXfoTNX6gF1uoTtmZ/jj7Quo3O+SId6uR38Uu/O2w/a38TNS4cL1NW1PwNswhkhJU1V90ThPRP+IqCO0Yp0DHAYO6CxMhgbg2DxufsDHtRp3FzvL7XdtJClU7BJOwQVGAkp0Ug2oMCi8rj3t/huDl1MzvG6QbNNqzL/LR1Ugg7oV2AedC+P3aEI0mz3O/lMRlH8wqyMxsF9fN/1/q9mTuBQKv8VBCTl08PjLwZj6mX6fEbm8x3R1UuKWsUSEhSFQTUWvH5JffeaBQWM0I0aSqSCeLclWPhZeIAZORn52Oo04vWRiv7K2F6O7tf5nkDjXTOWN7/xAeWaSkcvaZDbSUDcEy2ZqcFDlaF7JrKEZpMp06uF4wNHeR9Aizfmv01y1qLhQmvPscwNuhzR2UZhGPOTu/Uc6LkV9saRt/gCERvEkrkajEihXuuzfPEO670+x12aSFaBKtAm/F1hKJ4Ur1QCRg107j/+KfJkBevKpUbXF1sTl3VZXTLNFHLmasMIEGUaU4UsxdnY4J9EzwQ5NnpI+GOtNZtCs++b+z/VHF9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(966005)(33656002)(86362001)(9686003)(38100700002)(71200400001)(6506007)(7696005)(478600001)(53546011)(122000001)(110136005)(66946007)(66476007)(66446008)(54906003)(316002)(64756008)(66556008)(6636002)(76116006)(41300700001)(38070700005)(26005)(8936002)(4326008)(52536014)(8676002)(5660300002)(83380400001)(55016003)(2906002)(7416002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFVKenREdVZZYmFsbVFYK29FWmh5eEpXZjI4czB0WHRSVUFaeXZUVW5uckEr?=
 =?utf-8?B?KzJ5L2FKckEzeXdoSzJ1SHo3ak1wZXMwY2xlWWxVQkRRemxKemY3SmVqU2hl?=
 =?utf-8?B?SGRQR012emdBTWFJNk9rbkdjSENXblpTSm9xU0dOQ3pDSHR5QWdHbjcyMWF1?=
 =?utf-8?B?OEs3S3dUc0tVOS9ua0NFR0NqNFZmQ1B3WTFycUI3V1lsREJwN3NQTnRzRWEy?=
 =?utf-8?B?TEU0TDhZMU5QNjZESENnaW1OcmtVLzVPUXRRUjRDN1ZwckptRzNOam5kNlI5?=
 =?utf-8?B?N1NtZmtIUGREVktMTzVxb2dsUEdMRWlVQTdpOEQ1YjVtNVBjcko3Y1NqOWor?=
 =?utf-8?B?TTMxcEM0b21yUnl4aDVTK2hYSUhuMDdaT0FRNWtYOURDYTJBWmxOY3hMTXV6?=
 =?utf-8?B?c1dzRVlXNlppRjVwTFc2YTNMK2tLYXZKclNvelBYMmUxbVI3TWhQamhSVEov?=
 =?utf-8?B?OHdaV3VRWTkyb2FtNjFvZUdMSFc2TzlRQjJOMndxYVVFaUVQYnBzTnVXTyty?=
 =?utf-8?B?dVVMTUNqWW1lV2phYy9ZRm9LdE5yTnk2N0VMNkpIMWZYRS9BVCtweWFzaW9i?=
 =?utf-8?B?MHVBWWg4WEpOd0lFSG8xYmg2NlE5TUpoMGRmY0lwczhNc2JLM29mMDNsN2pU?=
 =?utf-8?B?QVNaZkdmRFV4U2FobHZtaVoxcDE5RExMNk0zSHplMGNWU1pGcjdlSHdsTWN3?=
 =?utf-8?B?cmNaZkk0eFpRVXNkRTh5dDZGVGFtaDRhcFdodGRmaklFcWFsdGpKUUphanp6?=
 =?utf-8?B?V1hod0dlMzhBVmJSS1dYVVQ0aHdkZ2JHcUVrRTNjcDltNkozSHYxa2FLaWNR?=
 =?utf-8?B?TjhjdFptZWlLTTY5M1dsQjlmYWdJZ1VaZXpsTzhPMmh3WHNYTndUWDEzQ3Ir?=
 =?utf-8?B?a1poeDRzNmdTenpZUEhpWGFRY1Y4SWRseVlrazgxQWdoa2FPcFdxVTdQMFlZ?=
 =?utf-8?B?VFdZRUEwSmVEU2RwOHV1N1U4NnZtNXMxc015S2hCOC9tb3F4U0lEaVBHQit0?=
 =?utf-8?B?b0FlSWdDYmN0ZmM5NzBpaEFVYkhrOW93cTRlekcxaU5hOFo0M0F5cFRYeHlC?=
 =?utf-8?B?YnZ0Sit6Y2I2anBkR2p2RSs1ZTlKaTUyb0VIN0c2YXN2RjRQaFlyY24ycGJE?=
 =?utf-8?B?WWE1amJzbXZiVGRQUG9JLzJES0dBY1B2czF4QllEV3NnNDAzTWQvTlZNZDA2?=
 =?utf-8?B?UUZnRnF2YlhvTEZ1elF0T3g3WGlvQlVMTXp2ZVhkTDc5Qkgwekd4aG45cnUw?=
 =?utf-8?B?bXdHRkRLKy9DSE1YUzlLeEhobnMyZlJ1ZjVCR1JROTY4ZzJnTmRCd0pJMThZ?=
 =?utf-8?B?aHhLelM2eDFhcjdRbFlQd3VOcEhFTklqZHBld2x1eXc1RVpVcjVId1krL3hT?=
 =?utf-8?B?Ym9PUzNPVTg4SWVOaU50cGZocE5hZlQ4NGNFNkVFME45b2lwUFBMUlhUMEZ4?=
 =?utf-8?B?Rk1ObnBmYkxzTWZBUjh2aUc5N2NvdlpWU3pBL00vSlF6TStSS0RnYVlpNmx1?=
 =?utf-8?B?V3NvS3R1UTIyYjlaWVg2RkVIM2V3ZjhpMlBFblZFRFo2aGlUS1UwSitJSzY1?=
 =?utf-8?B?WkZHRytYRmdHMHFNbVN2REhmZDRpNEJVY1phWXc4Z240bmR4MWxoZE5vZjVP?=
 =?utf-8?B?ZWRIcndqNlo0cGl0ak9UdlJSL0Ywd2p5b3psRHpyWWREdDMyYlJrU3JEbjNE?=
 =?utf-8?B?UmhkZ0RDaVVmTGxheUM2MDVRdThmbEc5c3g5UnVpTyt3SEJoRjA1NzVmdm1R?=
 =?utf-8?B?NXVOelBZSTJUNXU5SkJDOHYyUXFQWmhYcDIrNlhIR291c1lyYVBtMkcvN1pB?=
 =?utf-8?B?TGlYckd1RFNyWHpQR2NhNTFBdkZPbmo0cHA1YVNaekNZZTFQbldpTkRkNTls?=
 =?utf-8?B?RWdOcEt6dm9hMERKeDIydDB0MUJNYzF1NU9Lem1ZV2pDM2FLRXRnMmI3dHds?=
 =?utf-8?B?eHEyMVozNWtKTXhabytLSWJyejhsa1Z3OWdkK2wrdGVRUDh3ZkFDNy9JVk54?=
 =?utf-8?B?ZWZOaThpdlRRU3A1cDNWdDNEM29jL29BVGltNmk4eGpoZ0IrU3kyeEo4cnBh?=
 =?utf-8?B?OHdJbkZjWE5TTUxHc29Eb0dQekN2L1lKVHN2RG5NM1NMazRlelBEUXBwZjcy?=
 =?utf-8?B?b0V5dkRwWVFvNmgzd0p2ZEN2cFNCQlRySDdtVlV4UFpUdVZiZG80bzZTM0VC?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574167bd-fc74-44f3-df23-08dbc465e480
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 23:10:10.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOiFhBCCGy9fAKDTN6NbAUTkLFmDy6J+8ug5yD9JpsD1y5f1qkIJ6Qt1NsQ3+Z8Gnn1PVNQIvwrqfbmjENMShqe0q8ASC7Lozn0bgafWa8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8284
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
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyOCwgMjAyMyAyOjMyIFBNDQo+IFRvOiBpc2hpa2F3
YSB5dWppKOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj4pah77yh77yp77y077yj4peL77yl77yh
6ZaLKQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD47IEhhbnMgVmVya3VpbCA8aHZl
cmt1aWxAeHM0YWxsLm5sPjsgTGF1cmVudA0KPiBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBp
ZGVhc29uYm9hcmQuY29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5l
bC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5
DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4sNCj4g77yv77yz77y0KSA8bm9idWhpcm8x
Lml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OCAxLzVdIGR0LWJpbmRpbmdzOiBtZWRpYTogcGxhdGZvcm06IHZpc2NvbnRp
OiBBZGQgVG9zaGliYQ0KPiBWaXNjb250aSBWaWRlbyBJbnB1dCBJbnRlcmZhY2UNCj4gDQo+IE9u
IDI2LzA5LzIwMjMgMDE6MjgsIFl1amkgSXNoaWthd2Egd3JvdGU6DQo+ID4gQWRkcyB0aGUgRGV2
aWNlIFRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIHRoYXQgYWxsb3dzIHRvIGRlc2NyaWJlIHRo
ZQ0KPiA+IFZpZGVvIElucHV0IEludGVyZmFjZSBmb3VuZCBpbiBUb3NoaWJhIFZpc2NvbnRpIFNv
Q3MuDQo+ID4NCj4gDQo+IA0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBSZWdpc3RlcnMgZm9yIGNhcHR1cmUgY29udHJvbA0KPiA+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBSZWdpc3RlcnMgZm9yIENTSTIgcmVjZWl2ZXIgY29udHJvbA0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSZWdpc3RlcnMgZm9yIGJ1cyBpbnRlcmZhY2UgdW5pdCBj
b250cm9sDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFJlZ2lzdGVycyBmb3IgTWVtb3J5IFBy
b3RlY3Rpb24gVW5pdA0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgaXRlbXM6
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFN5bmMgSW50ZXJydXB0DQo+ID4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IFN0YXR1cyAoRXJyb3IpIEludGVycnVwdA0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBDU0kyIFJlY2VpdmVyIEludGVycnVwdA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBMMUlTUCBJbnRlcnJ1cHQNCj4gPiArDQo+ID4gKyAgcG9ydDoNCj4gPiArICAgICRyZWY6IC9z
Y2hlbWFzL2dyYXBoLnlhbWwjLyRkZWZzL3BvcnQtYmFzZQ0KPiA+ICsgICAgdW5ldmFsdWF0ZWRQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IENTSS0yIGlucHV0IHBvcnQs
IHdpdGggYSBzaW5nbGUgZW5kcG9pbnQgY29ubmVjdGVkIHRvIHRoZQ0KPiBDU0ktMiB0cmFuc21p
dHRlci4NCj4gPiArDQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICBlbmRwb2ludDoN
Cj4gPiArICAgICAgICAkcmVmOiB2aWRlby1pbnRlcmZhY2VzLnlhbWwjDQo+ID4gKyAgICAgICAg
YWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVt
aW5kZXIgZHVyaW5nIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IHNlZW1zIG15IHByZXZp
b3VzIGNvbW1lbnRzIHdlcmUgbm90IGZ1bGx5IGFkZHJlc3NlZC4gTWF5YmUgbXkgZmVlZGJhY2sN
Cj4gZ290IGxvc3QgYmV0d2VlbiB0aGUgcXVvdGVzLCBtYXliZSB5b3UganVzdCBmb3Jnb3QgdG8g
YXBwbHkgaXQuDQo+IFBsZWFzZSBnbyBiYWNrIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGFu
ZCBlaXRoZXIgaW1wbGVtZW50IGFsbCByZXF1ZXN0ZWQNCj4gY2hhbmdlcyBvciBrZWVwIGRpc2N1
c3NpbmcgdGhlbS4NCj4gDQo+IFRoYW5rIHlvdS4NCg0KSSdtIHZlcnkgc29ycnkgdGhhdCBJIG1p
c3VuZGVyc3Rvb2QgdGhlIGludGVudCBvZiB0aGUgbGFzdCBjb252ZXJzaW9uLg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzBhYTQ3MWNlLWRhODMtMTcyZC1kODcwLTFlYzdhNTYyYmFmN0Bs
aW5hcm8ub3JnLw0KSSB0aG91Z2h0ICJhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UiIGNhbiBi
ZSB1c2VkIGFuZCAieHh4OnRydWUiIHNob3VsZCBzdGF5Lg0KDQpMZXQgbWUgY29uZmlybSB5b3Vy
IGludGVudGlvbnM6DQogIC0gInVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UiIHNob3VsZCBi
ZSB1c2VkIGluc3RlYWQgb2YgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSINCiAgLSBBbGwg
b2YgInh4eDogdHJ1ZSIgc2hvdWxkIGJlIHJlbW92ZWQNCkFyZSB0aGVzZSB0d28gY29ycmVjdCB1
bmRlcnN0YW5kaW5ncz8NCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICAgcmVxdWlyZWQ6DQo+ID4g
KyAgICAgICAgICAtIGNsb2NrLW5vbmNvbnRpbnVvdXMNCj4gPiArICAgICAgICAgIC0gbGluay1m
cmVxdWVuY2llcw0KPiA+ICsgICAgICAgICAgLSByZW1vdGUtZW5kcG9pbnQNCj4gPiArICAgICAg
ICAgIC0gZGF0YS1sYW5lcw0KPiANCj4gTm90IG11Y2ggaW1wcm92ZWQgaGVyZS4gcmVxdWlyZWQg
Z29lcyBhZnRlciBwcm9wZXJ0aWVzLCBhbHdheXMuIEkgcG9pbnRlZCB5b3UNCj4gbGFzdCB0aW1l
IHRoZSBmaWxlIHdoaWNoIHlvdSBzaG91bGQgdXNlIGFzIGFuIGV4YW1wbGUuDQoNCkknbGwgY2hl
Y2sgdGhlIG92ZXJhbGwgc3RydWN0dXJlIG9mIHJlbmVzYXMscnpnMmwtY3NpMi55YW1sLg0KDQo+
ID4gKw0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICBkYXRhLWxhbmVz
Og0KPiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogVklJRiBzdXBwb3J0cyAxLCAyLCAzIG9y
IDQgZGF0YSBsYW5lcw0KPiA+ICsgICAgICAgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICAg
ICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiAxDQo+ID4gKyAgICAgICAg
ICAgICAgLSBjb25zdDogMg0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IDMNCj4gPiArICAg
ICAgICAgICAgICAtIGNvbnN0OiA0DQo+ID4gKw0KPiA+ICsgICAgICAgICAgY2xvY2stbm9uY29u
dGludW91czogdHJ1ZQ0KPiANCj4gRHJvcA0KPiANCj4gPiArICAgICAgICAgIGxpbmstZnJlcXVl
bmNpZXM6IHRydWUNCj4gDQo+IERyb3ANCj4gPiArICAgICAgICAgIHJlbW90ZS1lbmRwb2ludDog
dHJ1ZQ0KPiANCj4gRHJvcA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KQmVz
dCByZWdhcmRzLA0KWXVqaQ0K

