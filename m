Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B67BD44D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345399AbjJIH2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:28:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671DAC;
        Mon,  9 Oct 2023 00:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/4+DPbqzxr87oAfvdPCkf/16TCKCRKFUajYbvjsamj8j44mc/D8lArMOpdrQPhpo7yk5tv2OYonFaDOpQ8gnUg6UPdlRi4PElMX6b7G2TGLC/WFhdBzZpXAeA7HLnHTOwpCixiAa+TR9fSEYKtCbDYaMpVrK+mxYRhltsTy1/ORrxTt+BZhM/Nq2TDiukB3LaOxrTCUT3PhP09NBVXoi1gq96dUmUizIRwvgAoyvb3AvAEN3jlrZbdOVpccKdHMnXQ2e63NpJhfv2EFqkCegi8NhKG2oEPoI11E0Z5OFj/gANLbUPb8Js702luCq0LjA/udGOh2toluujeqooR1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3fPmwq4Gt4c38bJn3fxkXerKIgpFFq+MfGt5aIR/eg=;
 b=kYedei0i4571WbMw7BA0MRISp23+hndnP6ToafvWHSlYZgJwOy/nGSTCLkH8WDn6rAQ7mvG44O9e+AyyGNgUeOApwqHZ+MNF4bNyw1gu5FuMvHxPIt3sGq3cFP8gTGhnl5PapsDTQo9xg/q2qoU/plIQSFHUyWgzQF4Ds0YXNsylfwEvWVu9PZiJp3m+rjyWE5D39qY5A5sB+8r0wiMojCC1ldVhRRvqsswfFMAem2WClaW3OKxh+9tznS/mJdSmQbN8GTWJFOOHbhb9banZup4va9koWQy4DZX4ODF/AGhDwT4VB//Ztsc3/rwYcZV1jIUgcbApVU9XffNE+QxtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3fPmwq4Gt4c38bJn3fxkXerKIgpFFq+MfGt5aIR/eg=;
 b=hhPrAGCvGUXHAKbDFFLkNeenwXed00Usc0/8ClKDMm5eMWPfslQLCQlyv6hhn6H9lMSIlM/jE5Pzfk1haR2lt6Ippj9QrSedC+jozBOVN5PwkFbH290rMXW2zjkU977OD2Dgdk6UHESRzC6p/g9es8L71AVziZVJAKrTpxSujFE=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by VI1PR02MB6254.eurprd02.prod.outlook.com
 (2603:10a6:800:199::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 07:28:14 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:28:14 +0000
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "wenchao.chen666@gmail.com" <wenchao.chen666@gmail.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 2/2] mmc: debugfs: Allow host caps to be modified
Thread-Topic: [PATCH v2 2/2] mmc: debugfs: Allow host caps to be modified
Thread-Index: AQHZ8qjlFEKaUyJADkyDDbc1l5b7g7A9pkCAgAN4wgA=
Date:   Mon, 9 Oct 2023 07:28:14 +0000
Message-ID: <d7b1664f32f3ab7a3ec3e557ff957826ba396be0.camel@axis.com>
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
         <20230929-mmc-caps-v2-2-11a4c2d94f15@axis.com>
         <CA+Da2qy=6CVEkuP5t2dPQVk_eHex-U4-BzJuQ2Y6ozZMfSEbuw@mail.gmail.com>
In-Reply-To: <CA+Da2qy=6CVEkuP5t2dPQVk_eHex-U4-BzJuQ2Y6ozZMfSEbuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|VI1PR02MB6254:EE_
x-ms-office365-filtering-correlation-id: cbd631be-b9e9-4389-0fb3-08dbc8994ccb
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJ1kdqldhjVO14/DA/uI9qe63AgzvBr77H7+SVFBGHRM4DPN3Mo++dQu+6gcj5No33Xys9+WDaU3dXxZR5VdaE58meL7/L06JUdXoejfNYIA/J2HG6lLRkth6ia1WTuIzr9+Yyu5dV8yC5GuEjFHwmVn+Q8AA3z4nxGy4qkMEHIhyhQpi5QC5SyirjYe3QBc93Zv5Nf/DUyjAb0/kFagAw4LmNqSw4WX9wUMN9i52eqAqWngTLfMXmdUfZxhUrgpFVaOFtSDdw84qL86Yg3K0Mbyl8HefMjqi+aXKr6gUE9+wgM5DSrDDrHd4ltvYHGdMo/PKWXhkbC3gptkRnaUhkVqPSI8arKoIpBYLmnqh8GqT+FobpFPc7V/IPiS47Fm/0ONjBqzmw09iFg7b0LbvFiwyEsWM5E+t3Cm4YZy+/7wmeIKYyBbM5CoanWgZKGLzwAPx7C4DEuC8T7zfWrv2OqNChvYDZZx6qA32+LLq61i6BfqFVtAQOvzXk5U67NHbKGiSOKpEGNJpZO7wxKecxT45JYOyGbmiibd3CI8a1lBUSm8yvSlTRkGU5S1h2O3mIkoQ6WtZEx47qeIdgBoBTi2s00xpaopjAuorXOJh6zbHv4ZlzxlD8zG0D7yCn4Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(2616005)(6512007)(107886003)(478600001)(6486002)(2906002)(91956017)(76116006)(5660300002)(66946007)(41300700001)(110136005)(54906003)(66556008)(66446008)(66476007)(4326008)(64756008)(8936002)(316002)(8676002)(26005)(86362001)(38070700005)(38100700002)(36756003)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDNkU29oRDZwOHBmemU1OXY0Ylpia0tkVzBnemtFMTlHbm5LNkdiNkIwZXZx?=
 =?utf-8?B?K3M0eEZTcHRzUnZINkNzYVVrNUFxckFiOVQ0VmYwM2I2R2tDeE1LendsM1lu?=
 =?utf-8?B?NU81cStUdG9pR1ZxYVB4RnZ3b1VjUEZUdTBWNzdKankwZWVpU0YrMGUrTnVJ?=
 =?utf-8?B?NXNoeXE3SlpRZkt0SWdxQlA3c2J6NTZyaE1XYUI1akFpdEdpdDJBdjVGYnBG?=
 =?utf-8?B?QzRUYVpuZFVDZ1RLWURwR2FwV0UwOUJ2Z3Q2WHdoZWVDWmMxWjJZWnNWWEtk?=
 =?utf-8?B?dW1CakY1a29rMmszRzZocGlmS2FDN2h5aFU5Y3RXT0g0bHM1Q0lFWGRRQmxH?=
 =?utf-8?B?WGRnVThaSTN6MFlNZ00yS2QveXk5OFNHUkorSXVrV2RiTkZjRzF5RUJrWjlU?=
 =?utf-8?B?QURQc3FxcUV4Y1JRYUROcmZtc3lwOXI0bmFvQVplV294QW9DdndBRXNqSWJT?=
 =?utf-8?B?Rk9JT0dRaEthdTJJNUdiK2RqSW9Cdkxnb0lrNDNoaitZZUVHNU1lWE5hUTA2?=
 =?utf-8?B?WGt2UzJrQ1NsajNuaktnWFVoL0pvK0xZamRWc2F6VEZVNlQ2bUpRc29iRVBC?=
 =?utf-8?B?WWpDMVNCVUwyUXdBRTk5VnRiRUthNUVtdXZKdWU3UkF5ZGtEaGRLZEw0M3ZC?=
 =?utf-8?B?VUYxL1M3OCtaZUdTMDJoVVkyYVFEbFhPNVVJU1V5YXNvNmdVaFRPL0FSNklM?=
 =?utf-8?B?dkNvbnZmdTVvNEd0eW9IeGg3ZmdNcWpBS3JORGxwUCsvVFY1QmR0dzkrZDdl?=
 =?utf-8?B?SUwxTVcrbGpUREduME9xV2o0RlJ3M1ZUdDRYMll1TXBFVnFFK0ZIYVQzZnBn?=
 =?utf-8?B?bWN4N1MwVTZQamNEMC9VTHlRdXZtUEVWZ2ZmR1o3OWFLTHB6T0wxUDVGTGpL?=
 =?utf-8?B?c21mRnlMVjNhSEtVcFFOZ0thRlBhT3lQVTNxLzE3ckZCbXRibEo5OHVsb3lq?=
 =?utf-8?B?R21WRllkMVd0QW5MMWc0dEJIQ1RFUnF5YThLeVBwYVdtaCtaU3RnVFBERVY0?=
 =?utf-8?B?OFdSQ204WmF1OWxLSjR5RkFNMy9hMDZWcExjQzMrSlU1c0x2OHVwUkQ3Ymto?=
 =?utf-8?B?aFJmTExzRnlzK1NRL2NFS1R2bGg2V1BtcGxKUVAxaEpCZ2kvNkU4Y2ZJaDRV?=
 =?utf-8?B?aUFvWms0YTNoZGt3bXZZVzRCWS9GMk43cGZJcHJvUjkvZzNzdExNZC8vbWhK?=
 =?utf-8?B?bWFsL2o2YmxWeVplV0t5UER3cXBXcHFYSEs3NHlLcWZ3L1NYaFFiVWg2bDZM?=
 =?utf-8?B?bTh0ZmFpd0YrNldmV1Rob3ZNMzBZekJoYVd0YnpTRDN6am9JNTNQR1BzZXZn?=
 =?utf-8?B?UlZrL20zREIyTXlUMGNUanZ3RGVhdTF1bklBR2J5c2pPY0V1c2JpTEtrMmxx?=
 =?utf-8?B?cVNVOVRRQjYzaEdJK3NhVXZXQ1VkTFRZck53eGN6UGFnWXBNWmlMZ1ZqanJ6?=
 =?utf-8?B?N1NVTFJKUEMyREd3bGxtWm1semdGMjBwU3NUZWVjbnNTeUc2Q2ZRbnNEZyt6?=
 =?utf-8?B?UjBDc2JRaGJ5cXZlKzg5a3hkMlZoTGNrbGtKU0hyZGpiY3FDNkZiQkI4UlFr?=
 =?utf-8?B?QUFNOWFUa0xMNWUyUnd4SkdyTzIrR25ieXRENXJKSGJuUXQ5U0M2eTgzRzhu?=
 =?utf-8?B?T253MXJ2SGFlTUJtQ0ZWelE3cWVqQUF1SE56YUwreFdMWFlWZUdjNlpjT0JW?=
 =?utf-8?B?U2lpL1FqdUdIVkUzaDU0ZmpGN25lNE82cjFmb1ZYTW9LUjVvc3U3ZXp1YzNU?=
 =?utf-8?B?Q0NSYXhWbTRDYnR5N0dzZzZua3ljWDJSOUVVUjNRcE5lY0Jvc1VNN21BZlRI?=
 =?utf-8?B?TTVhWmRBQm1HTmV6eXlucWVrZ0lBdXRoOUkxczdPSStVb3hjT2tCVE8wVGNt?=
 =?utf-8?B?b0c5bnpwZG54MG91ZUxTZnhVSVJTUjNEa3R4VWZwQXZ0MVhZTnFIRy9XemtS?=
 =?utf-8?B?emgvL0Y3SlY0YTRzMWhWWU41VE96SmZ1Y0RXSHNQa2g2WVNiYWRKQTV4TE5P?=
 =?utf-8?B?RVo0OTljeGdCQXdYMkpxWDdwRzVOVEVPaEcwRWJSWGo2amV5N1o4UW41dmFJ?=
 =?utf-8?B?b0lCR2NGQkk2STU2QitYV0JqY0FoQmU1a050cmxLUU52T2FKam01ZEo3MXJu?=
 =?utf-8?Q?fMchCSTEIOdQyVrXXebWrtLgy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5BB3993AB760F46BEB1B2CD013EA05E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd631be-b9e9-4389-0fb3-08dbc8994ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 07:28:14.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzfz1S2JGbrw1eAGEg4zUbz80+azHUQUHl9oYaJA3e94rUiStgzUAgOiFpTES1o4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTEwLTA3IGF0IDEwOjI3ICswODAwLCBXZW5jaGFvIENoZW4gd3JvdGU6DQo+
IE9uIEZyaSwgMjkgU2VwdCAyMDIzIGF0IDIxOjE3LCBWaW5jZW50IFdoaXRjaHVyY2gNCj4gPHZp
bmNlbnQud2hpdGNodXJjaEBheGlzLmNvbT4gd3JvdGU6DQo+ID4gwqAvLyBNTUNfQ0FQMl9IUzIw
MF8xXzhWX1NEUg0KPiA+IMKgL3N5cy9rZXJuZWwvZGVidWcvbW1jMCMgZWNobyAkKCgkKGNhdCBj
YXBzMikgJiB+KDEgPDwgNSkpKSA+IGNhcHMyDQo+IA0KPiAkKCgkKGNhdCBjYXBzMikgJiB+KDEg
PDwgNSkpKSBsb29rcyBjb21wbGljYXRlZCwgZG9lcyBpdCB1c2UgZWNobyBERFI1MiA+IGNhcHMy
Pw0KDQoxIDw8IDUgaXMgKGFzIHRoZSBjb21tZW50IGFib3ZlIHNheXMpIE1NQ19DQVAyX0hTMjAw
XzFfOFZfU0RSLiAgVGhlDQpyZWFkLW1vZGlmeS13cml0ZSBpcyBuZWVkZWQgdG8gbm90IGNsZWFy
IHVucmVsYXRlZCBiaXRzLiAgVGhlIE1NQw0KZnJhbWV3b3JrIHBpY2tzIHRoZSBiZXN0IHBvc3Np
YmxlIG1vZGUgc3VwcG9ydGVkIGJ5IGJvdGggdGhlIGNhcmQgYW5kDQp0aGUgaG9zdCBjb250cm9s
bGVyLCBzbyBkaXNhYmxpbmcgc3VwcG9ydCBmb3IgSFMyMDAgaW4gdGhlIGhvc3QNCmNvbnRyb2xs
ZXIgbGVhZHMgdG8gRERSNTIgYmVpbmcgcGlja2VkIGluIHRoaXMgY2FzZS4NCg0KWy4uLl0NCj4g
PiDCoHZvaWQgbW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1tY19ob3N0ICpob3N0KQ0KPiA+
IMKgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGVudHJ5ICpyb290Ow0KPiA+IEBAIC0z
MDYsOCArMzUyLDkgQEAgdm9pZCBtbWNfYWRkX2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3Qg
Kmhvc3QpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGhvc3QtPmRlYnVnZnNfcm9vdCA9IHJvb3Q7DQo+
ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRlYnVnZnNfY3JlYXRlX2ZpbGUoImlvcyIsIFNfSVJV
U1IsIHJvb3QsIGhvc3QsICZtbWNfaW9zX2ZvcHMpOw0KPiA+IC0gICAgICAgZGVidWdmc19jcmVh
dGVfeDMyKCJjYXBzIiwgU19JUlVTUiwgcm9vdCwgJmhvc3QtPmNhcHMpOw0KPiA+IC0gICAgICAg
ZGVidWdmc19jcmVhdGVfeDMyKCJjYXBzMiIsIFNfSVJVU1IsIHJvb3QsICZob3N0LT5jYXBzMik7
DQo+ID4gKyAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJjYXBzIiwgMDYwMCwgcm9vdCwgJmhv
c3QtPmNhcHMsICZtbWNfY2Fwc19mb3BzKTsNCj4gPiArICAgICAgIGRlYnVnZnNfY3JlYXRlX2Zp
bGUoImNhcHMyIiwgMDYwMCwgcm9vdCwgJmhvc3QtPmNhcHMyLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmbW1jX2NhcHMyX2ZvcHMpOw0KPiANCj4gV291bGQgaXQgYmUgYmV0dGVy
IHRvIHVzZSAiU19JUlVTUiB8IFNfSVdVU1IiIGluc3RlYWQgb2YgIjA2MDAiPw0KDQpObywgbm90
IGFjY29yZGluZyB0byBjaGVja3BhdGNoIHdoaWNoIHNheXMgdGhhdCBudW1lcmljIHBlcm1pc3Np
b25zIGFyZQ0KcHJlZmVycmVkLg0K
