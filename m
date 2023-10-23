Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154927D2AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjJWHJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJWHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:09:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEED188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiSpQhQZFpJerQcbZu8w3KevMhdj3u3dszyyqWwoYrTSICJJMaXkOnf31dRvQ9E7asYjMbHKQi5D38IA/3SfQkKX0ErCmPmCTUob7kn/dsTm24alrVcwX90teVPUa3san4Y+I5VzpIWyMo5NL0+fxPYeqEIum3ljHAeaBSc3BPXdYsl1rM50OE08Wzw66w7gpdOOWjG4sVh8ItL8McrDqOIYx27yei5iczugujIh5jiGKEHiAQif8LxvY8Gg58YrSCkyGLLT20y2P6wEloS7lx/6xPvGeQRaiNoOH6tvc8eOV8oV1v1Zt/yMmMqYk+wfaYe+zVv5RDuET3ufid/Dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K8q73x1/x2w3r8NIY/bWU5qEV2mCg/KAXHZm09FEMc=;
 b=bm0oKS+Cr7zHsgSyqGdOje3lJDbOtCkYYBkekAeHqnOBQG16L4ThzvFb3SAvnmlXIY2vYolhZXKaEvSMbhsGBaVP7OnMJ4xL1NOuTXWFHZXZG8mdIS+rTltAPhgky2sq9nPhuEXhdL7z3AVvcsuz6GamuKPZyJ2ORlLCVWfmcOF44eWNrU24vkIRupJpwi2V3nqRjjbKMVaus0MgNycNSg/T78w1fzoRFq6wQ/nYRkKtz73vnmWZENmz60B9V28BKDwK4qU6dUHAotEiDE0+jMUwuXdxQpY+0kgj8ize+M3BD3nR1JmJefxhnABl2nb9/LCXFzAnkb3wZOHcl2+WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K8q73x1/x2w3r8NIY/bWU5qEV2mCg/KAXHZm09FEMc=;
 b=T/Zqw6B4dZMpDhcWwEK26DDO0PRqZdwwzZKbqBNYZr3ntXESanXfezBL1tlk08B5nCq4HdGIiqvaCElG1YU4IshXSyFxmSctHal6MHbRMW/UERIKO0P1aK6oL3jvDhCP+/GR/bqIJkxap+f23OvrzDAt9/MNYnFYbLbsc3G6apg=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by AM7PR02MB6209.eurprd02.prod.outlook.com
 (2603:10a6:20b:1be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 07:08:58 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db%7]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 07:08:58 +0000
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
Thread-Topic: [PATCH] um: time-travel: fix time going backwards
Thread-Index: AQHaA2RiVZFQrWdgxUymyPXI7Wg85LBW+MuA
Date:   Mon, 23 Oct 2023 07:08:58 +0000
Message-ID: <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
In-Reply-To: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM7PR02MB6209:EE_
x-ms-office365-filtering-correlation-id: ccca4a9f-6ee9-4070-5c3e-08dbd396ed5b
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhEOJO4/uZ5ofjEVms34rbcINlS4NS6/7hXAnyW1dR6aUw1WpVvfxMXrZO+6T0RcCLAU96XG6puC5onKacReizGXx2w0RhO6y0QtD11LZ5u5sWt8ZLwOQ83sCuXjqWdKNMguVOfH3JG31IJuR+lNL0wsKL7DkiWQaE1+BPeKP2zdlIPduQb+PtN3oVtgj1mTM1F82dMeQhPOmYHdKP8hJdsyFtT9ONiNMu2FTXWiyW0/dTHJeR5UACe7QvEbu3U3rTPfC4zA+3AkFr4fVe25IisPONbze+MSEyfYDFFrTrLtdJNGqILhleSatJHnyeczRUz3FjupU6jfzA6k/nv8o+fEwo/Pdfr8plv3Dfn91YhHe9OtieNHOTOeXhX5PmPcJ4tXASrp6l92NlIQeo1ThwQbA7zaTS4jhbSI2vxMnSYdT6oRm+8X3rJb9dV1hHczS4SXAoZXjsKbDeZlZJXr2wTSBW1QkWLgbrpcpLlzt3oMfwzjXQe61eDueryXkyEfbXJ1h4jKy+/aJudSvzz/oA+8Qi0Q1RnPxWmX7Vy+flU1dAhvirFczU/ulWAF7fUWxEEzMbIUJAIiOHqs1GfPW5NXBJH6fpd4ALjGnPnMAvPRYcsigiUisU1zBoxymyJQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(38070700009)(4001150100001)(2906002)(36756003)(4326008)(8936002)(8676002)(71200400001)(107886003)(122000001)(26005)(2616005)(38100700002)(316002)(5660300002)(6506007)(478600001)(6512007)(6486002)(86362001)(91956017)(110136005)(41300700001)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FNSTllU3JYUUxuWGJ6bGJCNDZOUTFncnlpZElQa2ZBT1JKbWNuendsN3Bq?=
 =?utf-8?B?dkR4RGhQSDBULzQ1N0haY0RZai8zNHA3dGw0WXRmemdrTXgrMXl4TTREQjIv?=
 =?utf-8?B?eWdBTTZDd2JsZWUxTVcyemNRS3JYcHlqOUVJdjIzNTdNNTNRNituVUtUSkIy?=
 =?utf-8?B?MXVNbjZZZUJmTDRGc2FGdDB5RElNaVE2Ry82aUxYUTNkRUdkU3FRV2hNK0Nh?=
 =?utf-8?B?QlVEKy8ySTJPZlg0UHBvZCtRNWFNakJtQS93WTg1WW9Jd3ovZFBMVUdBZ1c5?=
 =?utf-8?B?cTY5dVZTbXlWbnR2bVZJWUc2U2FQU0tISFZhU3lVNlhOY1Z0dW1nWWxOZ29q?=
 =?utf-8?B?Mm5RL3hxemhMbS9USGpDVzVqYkdkeGEva0Z1ZkY5dXZ3MTg4alppTnJrMDls?=
 =?utf-8?B?Q2M0UEJIY3lVOFVDTVRZaTFuNFFtb2Vmb3RXY1JnUFNoeE95N3R1Y1ByWGF4?=
 =?utf-8?B?ajA5c0U1UWR4Zmd2RkpKdjhLVDc1WXJmR0d6c3ZPeU9ncTc0SS9jNjVYek9v?=
 =?utf-8?B?OENoSHhIc1hFMGpPQWoxTU45eFhNTjEvNVlIVmJOUW9BUHBPZW9OSzhseGE3?=
 =?utf-8?B?c3FWNlBUa0tObTJBYlVrVkZ3d2I3TFllY3RKTTZhdFZxbXBHVlB3N2pVQ2pB?=
 =?utf-8?B?V3g2ZG80NDk2a1grSDJKZFdZKzl0blN3T0g5d2xaQlFXNStwanF1dnhxTUx1?=
 =?utf-8?B?ZWllVUV0b2N2eEFLYzdZbHlUMDByNTIwRDJiVkU0MGtzTG1EYWdiQVpiWWYr?=
 =?utf-8?B?S09BMGlaWWhSKzNKVDJaZHJ1QjRWMEhKMk00Z3RRNDZTRXVkYTBKYnpycm1a?=
 =?utf-8?B?OFRnUHU0R0daLys1VW03bUtQYzM4a3RrRnJ2SDl0NzFLb0dQN3B2Slg3R20y?=
 =?utf-8?B?NWFEd2FnSnBxM1VtTm93Rk1XS1dJVkdjajZ1MjhRZlNHcklSSUlrOWVacUhT?=
 =?utf-8?B?WlZMV3NnL3luQmVQblZTT2Z3TGpwZjk1MFo0b0ZSelBiNyt0N0JGeDZaemlJ?=
 =?utf-8?B?MExPVVkvRTVnN21qMGZwQ1ZRZVZya1ByMFN3dmg2RVdHWVlheHMycFM4eTRU?=
 =?utf-8?B?WGdsQUJlTGc4RHdhUWVvOGNMcHNLQnFQazlpT3dPa2ZSVjhDb2tzUTUvN2hJ?=
 =?utf-8?B?dXdVOUpwZUNPQURaMUgvZGJsVmt0ZFdTQzBrMCtQTzExVkJVOURQejgweG0x?=
 =?utf-8?B?YStTQzQyNW9rTEhIUzVRNGwycUREMEpzU1F5UHFjM1BJelh4d1lCU2RjQkRQ?=
 =?utf-8?B?cFBTZ3NUbUFNVDVHNGU3UVUrdlJObmppY1VnbExiQ1N4bDZrWDhUdzFVeHgy?=
 =?utf-8?B?VTNoT3o5RWpJTjhIQkkwbWkxNThESEVmV0xpZHFsZ0NNK1NyQ3p5NG1FM3cw?=
 =?utf-8?B?MkZwMHU1YzhYZlNMSldmakkzeG04aXVjRGdoNUtYaStQVUhadk9Zc3c3MkZ3?=
 =?utf-8?B?eGZReFhnUE1waWw1bkN4aEZVQ0Rud0c3UXk4dGE1YVFFZDE2dUF1MDM1WW1q?=
 =?utf-8?B?WlhsMGIvN1Jqb0NZYTkybVFvTm1YWXR2QU8rMTRRUHRCWjU0d3pRbnZ1WXIr?=
 =?utf-8?B?SVhxQ3JrNTc5cGNXVlZPZHd2TGtwa09rbkZQUUx6TG56d1I0YnQxSTZ2ZmNx?=
 =?utf-8?B?a1dDSHpYTmpKYjQvUlJzSjNnQzEyWDY4QWxoM251Tkl6T0g5WVlsN2ticFhD?=
 =?utf-8?B?WDNXa1l1Q2l5NzJmTStXZVhnVzBwMk9JNDhlMlNRQlZMankwdlBWbWxhbERY?=
 =?utf-8?B?dlBCTWl4ZEtra21IcXI1S2F0VGpjQjI4SGZCY0VDbU5ZVXBwZzdwZ0s5a2gy?=
 =?utf-8?B?YWRzVGVnYnlnYU1DWitIN3BERkF2eno4amI2dG9DanE2cGQ5T0JORVhnNjVB?=
 =?utf-8?B?bUxwL1FQYU5GWlZzdmxCZ0ZVS01WaERhci9GTlFYWEhwcFlQNVd6dVJTQXlS?=
 =?utf-8?B?c1ZKTUtLNlA0ZnVBR2hwNjhoUGtkQ1c1eVZUNXBpWTAydlMvZmRZVlc2ZWYv?=
 =?utf-8?B?eEpNNnl5aVVscGd0QkEvam5mVDBlcjR0ZUg0b1RJMnJURTNweVZ3UGZ0eXNM?=
 =?utf-8?B?T0RCcmZHdksrUlpEQUlobDk5bkRBc1Fqb2dvMURva2RQN3p2eVBGcnBaTzYv?=
 =?utf-8?Q?475RavHNY3BASHSKzT9P28VxH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F0901484C5342409C0D158667DEED0B@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccca4a9f-6ee9-4070-5c3e-08dbd396ed5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 07:08:58.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7ihg0J9EL6H2q0o7wyclYrM1i292D0p8ra8AX6bxyuNtS73/OZLPFeFhXY3ksqC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTIwIGF0IDE2OjQ3ICswMjAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6DQo+IEluIGJhc2ljIHRpbWUgdHJhdmVsIG1vZGUsIEkgc29tZXRpbWVzIHNlZSAidGltZSBn
b2VzIGJhY2t3YXJkcyIgcGFuaWNzDQo+IGxpa2UgdGhlIG9uZSBiZWxvdzoNCj4gDQo+IMKgS2Vy
bmVsIHBhbmljOiB0aW1lLXRyYXZlbDogdGltZSBnb2VzIGJhY2t3YXJkcyAxNjE2ODkzNDAwMDA0
OTIgLT4gMTYxNjg5MzM5ODY5ODE0DQo+IMKgQ2FsbCBUcmFjZToNCj4gwqDCoHBhbmljKzB4MWEx
LzB4M2Q3DQo+IMKgwqB0aW1lX3RyYXZlbF91cGRhdGVfdGltZS5jb2xkKzB4ZTkvMHgxMzMNCj4g
wqDCoHRpbWVyX3JlYWQrMHhjMS8weDEwMA0KPiDCoMKga3RpbWVfZ2V0KzB4MTBjLzB4MjAwDQo+
IMKgwqBjb3B5X3Byb2Nlc3MrMHgxODk5LzB4MjIzMA0KPiDCoMKga2VybmVsX2Nsb25lKzB4NTcv
MHg3YTANCj4gwqDCoGtlcm5lbF90aHJlYWQrMHg0YS8weDUwDQo+IMKgwqBrdGhyZWFkZCsweDEx
Ni8weDE5MA0KPiANCj4gVGhlIHByb2JsZW0gaXMgYSByYWNlIGJldHdlZW4gdGltZV90cmF2ZWxf
aGFuZGxlX3JlYWxfYWxhcm0oKSBhbmQNCj4gdGltZXJfcmVhZCgpLiAgdGltZV90cmF2ZWxfaGFu
ZGxlX3JlYWxfYWxhcm0oKSBjaGFuZ2VzIHRoZSB0aW1lIGFmdGVyDQo+IHRpbWVfcmVhZCgpIHJl
YWRzIHRoZSBjdXJyZW50IHRpbWUgYnV0IGJlZm9yZSB0aW1lX3RyYXZlbF91cGRhdGVfdGltZSgp
DQo+IGhhcyBoYWQgYSBjaGFuY2UgdG8gYWRkIHRoZSBlbmQgZXZlbnQuDQo+IA0KPiBGaXggdGhp
cyBieSBkb2luZyB0aGUgdGltZSByZWFkIGFuZCBldmVudCBhZGQgYXRvbWljYWxseSB3aXRoIHJl
c3BlY3QgdG8NCj4gdGltZV90cmF2ZWxfaGFuZGxlX3JlYWxfYWxhcm0oKS4NCg0KRnVydGhlciB0
ZXN0aW5nIHJlc3VsdGVkIGluIGhpdHRpbmcgdGhlIEJVR19PTih0aW1lX3RyYXZlbF90aW1lICE9
DQplLT50aW1lKSBzbyBsb29rcyBsaWtlIHRoaXMgbmVlZHMgc29tZSBtb3JlIHdvcmsuICANCg0K
IEJVRzogZmFpbHVyZSBhdCBhcmNoL3VtL2tlcm5lbC90aW1lLmM6NDA5L3RpbWVfdHJhdmVsX3Vw
ZGF0ZV90b19ldmVudCgpIQ0KIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBCVUchDQogQ1BV
OiAwIFBJRDogMSBDb21tOiBzd2FwcGVyIE5vdCB0YWludGVkIDYuNS4wKyAjMTMNCiBTdGFjazoN
CiAgNjI0ZGI5MDggNjBhMDZjNjAgNDFiNThhYjMgNjBhZTIzOTgNCiAgNjAwM2ZiOTAgMTAwMDBj
MWU1NzdjIDQxYjU4YWIzIDYwYjQxOWFlDQogIDYwN2YwZGMwIDAwMDAwMDAwIDAwMDAwMDAwIDYw
MDViMjcwDQogQ2FsbCBUcmFjZToNCiAgWzw2MDdmYWQ1ZD5dIHNob3dfc3RhY2suY29sZCsweGMw
LzB4MTQ5DQogIFs8NjA4NDEzNjQ+XSBkdW1wX3N0YWNrX2x2bCsweDc1LzB4OTQNCiAgWzw2MDg0
MTM5ZD5dIGR1bXBfc3RhY2srMHgxYS8weDFjDQogIFs8NjA3ZmNhMWQ+XSBwYW5pYysweDI3ZS8w
eDQ5MA0KICBbPDYwN2ZiMDkzPl0gdGltZV90cmF2ZWxfdXBkYXRlX3RvX2V2ZW50LmNvbGQrMHg4
OS8weDE4Yg0KICBbPDYwMDQxMzE3Pl0gdGltZV90cmF2ZWxfZm9yd2FyZF90aW1lLmNvbnN0cHJv
cC4wKzB4ZjcvMHgxNjANCiAgWzw2MDA0MTRmMT5dIHRpbWVyX3JlYWQrMHgxNzEvMHgxYjANCiAg
Wzw2MDE0MDY1Mj5dIHJhbmRvbV9nZXRfZW50cm9weV9mYWxsYmFjaysweDQyLzB4NjANCiAgWzw2
MDU0NTk0Mz5dIGFkZF9kZXZpY2VfcmFuZG9tbmVzcysweDczLzB4ZjANCiAgWzw2MDAzYTY4NT5d
IGRvX29uZV9pbml0Y2FsbCsweDE0NS8weDNiMA0KICBbPDYwMDAyNTk4Pl0gMHg2MDAwMjU5OA0K
ICBbPDYwODQzYWM1Pl0ga2VybmVsX2luaXQrMHg0YS8weDE5NQ0KICBbPDYwMDNkMTExPl0gbmV3
X3RocmVhZF9oYW5kbGVyKzB4MTQxLzB4MWEwDQo=
