Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9347D7DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjJZIBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:01:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E5B8;
        Thu, 26 Oct 2023 01:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9DEYp2yPwzTZFFGAxOyE+oKdIjVYIEXGXYgwr01CavQxEMGa6a7uS0hrajSBIwEOdTWd2jQY2jznPFsSRbVC+XlFupiSZqO5QqM7+LIc2qqEu7SdE52f8eVf3CU6p/m3mQPhAfqGAtH5grewFF5Kndt3UuDCjdfBiP4zqFMTDskpEfcEJrgdE7TCTk5+IzJX8A2wBoeuLikRm9mgTHaWY00F+MUnCtf7+k4Orp9ZDoovFePIJ4njpH/bhYH+WKYkPKnXKCK5RKmuyJ6Ha2dLhJulHpmsOc7MZAI5rOIKXA+w6pRhbj7QYDTdpi7JHzWRUuOi0aNHjaQ1z6Tg2tlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvhbLAdpJZiVn4YsMFvzWhVF8Vp3K/yuNRqeJ8W3dhg=;
 b=LIXrUP5zX9qRKIrijVFrh5oH4nsrAfqU7xC0DObUT2lZyuTBkYJGTaLCoq+RdLaJ5wLnz/TKK4eLuLu49zgL0N8S2BURUA5bC/oJa7jGq9HP2712k+nHrwJgC/m+lRUc+v2oItMO0SyoCtpXNGF7hqm6FCH1KtxmFKXlVBRx8WnYqwx+Vu7G9o9N6ZrKowbtmrj2pD51pwu2kyDjqmf3chdGL6iLOtpaL2cZUPGKvpt3a7RZEgkC9xrr8mAhLf/EC0pLxNgBJD8VTateZP1OwO0VaFScB+Bp8thY0LmEzwumEf07Bz6BeJNyunTzi5lC1k6+W4L7teYXGB2kCItDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvhbLAdpJZiVn4YsMFvzWhVF8Vp3K/yuNRqeJ8W3dhg=;
 b=XOL+yPxCxzzRt3QgBCL+5ezJXORsfCZq41e6iCB5ubl2+Lw2QcBoFOVJYNBd7C1cIKeDIVvTHMSzf4s8jkucqEXycqQR7JI/bZMgayUbwqQp+E+tE9E5OUnYAL/DQimweokR98rfNboprASCf8lwxeCRgSEvaMVrDM/i9O8Vm7A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Thu, 26 Oct
 2023 08:01:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Thu, 26 Oct 2023
 08:01:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "clement.leger@bootlin.com" <clement.leger@bootlin.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: clk-conf: bypass setting rate/parent if already same
Thread-Topic: [PATCH] clk: clk-conf: bypass setting rate/parent if already
 same
Thread-Index: AQHaB9aT2+bcxOGs60a5DL8lB8hR7rBbonSAgAASHRA=
Date:   Thu, 26 Oct 2023 08:01:45 +0000
Message-ID: <DU0PR04MB9417B338597E78EA51B7F6DF88DDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231026063941.1882023-1-peng.fan@oss.nxp.com>
 <CAMuHMdUA_OOvQmkZXn21pxC=nTw6wHQZp1P8mNjTca65+KjxAQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUA_OOvQmkZXn21pxC=nTw6wHQZp1P8mNjTca65+KjxAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: 346e0983-8d56-4281-1e6f-08dbd5f9ccdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfJZ4sNY9eo8GLkuFUM5HTRTG0XSvUd6bb6Ff3MyynfDlojY2ixFbW6Dgd/t136BEVfLpRhilaiGoUJq0oLxztU+f0VE82hSGlU797aOXEyJY8VLAhBGk8M/FbJRRLnHuwlRl7pr+gfBvdG6R/Uu5wHdl2ZYi9RFquxl1DPgbjuO2VJlJEpaCqxuwQ9NB/1/ry0YJZOt4Gc0yujZ6yyvGO8SZSU2TnbY+AOkEX7IyzH8WFlSh3hQLaKR52/iqTW8IdPWb++8cDPmcMkh3Ki0WAO20x+7zC/TuB+I0jGlFd6ZG5q4Q2fOuJJ3icVCKuaOgE0JGZrRujVyzdJkysXoS6XZX2Q4r4GZsfhv1bb0wxU0Qf4FJ1CWOycOMOiZaCTedjcJdn0/jQl/t3e+jd2WGRC5s8nrQpqfi0DHnBETsHxy9p3gMqcUKvHkr7xxXjlQ2+EiB8RDB/lvHqHMVfwhmZ1mV3BjxUf9O1q4q+fWaS92qhZtX/tthkcM9V07wzJpOLeEReeN3DWfjJCEYeqFUZKvzwzXECGcVXsr2Yqu04IFtMJXfzd/ftKfqEZIaLm/hZki9qAHTQoAnuCEifZIEzW992PPF03VsmwO+Tiywy+pb/gzbLFd5da5Ys7Az8JY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8676002)(44832011)(7416002)(8936002)(41300700001)(4326008)(2906002)(38070700009)(5660300002)(52536014)(71200400001)(53546011)(7696005)(122000001)(9686003)(6506007)(83380400001)(38100700002)(110136005)(66946007)(76116006)(86362001)(33656002)(55016003)(316002)(66556008)(26005)(66476007)(66446008)(54906003)(478600001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUhqYTlUSThZYkRPcGF0c1M4c1g1STJMY2pSeEdKM3VIZ3VURURKd3RlaUt5?=
 =?utf-8?B?bFRCSlF0cHVSS0Z5d2ZNeVpaN3RLT2JUbHVicG1HOU1CcXJFSmk0SHo5WERv?=
 =?utf-8?B?ZU1ZeXBtdnhiNThucGpBSXpCbTVkZFpDUHE2RWN5aUsxaWQ2aGsrSXFaR2VV?=
 =?utf-8?B?aHhRQTE0OXY2R1RmVTVUeGZBc3FUNE96blBrOUw0YWJ0Uk4wMWNTbDA3SXJn?=
 =?utf-8?B?UmE3VWZFRUNXTjdYaUFwWmdYZDNXS3J6M1BJajAyQ0xRZUoyZHJDdm5qWTZR?=
 =?utf-8?B?R3JSdHBLVFpFTVhmWnlMNDYyVlhaWW1OdXhmVHIxeHJyQ2p4R1V5cTBvRlNo?=
 =?utf-8?B?cjdBelN5TjdvS1lEUmpRam5kS3pneUtYUU10cEtHckUwVUVkcGtSWDBaWnA2?=
 =?utf-8?B?VFFkM1FLSlVob1NkQmxwak4rSGsvbXlidk9pK292SVBQS2Fya2RSUWRkYUEv?=
 =?utf-8?B?dVdibnBpYktjSHZXQldRTDBHZzRUSTZWY2EwZjRjODFwUG1DcE43Vno0WCsz?=
 =?utf-8?B?bWRWR2UyQkpMcHBuZHBtdWE2c2I0b2F4bVV6ODFlRDJpM2hGdjQrMVFyODdN?=
 =?utf-8?B?dGNLNWdjaHp4ZjFMU0JacGR2T1JLc09jc0Q5QkJLM25nRXU4ckNtdEVvR1Q2?=
 =?utf-8?B?MWYxdExJazZjUWR0TlN5QXBVODc2VVZrNC9OTU1HQzlXRlpQU2JLVWQ3YmVO?=
 =?utf-8?B?Vy9XRDFjWDVtRDcwenlhaVFXTEtkem1EQ3FoZ1lYbzl6S2JlcE9pSlJ3OVYz?=
 =?utf-8?B?cFp0QVZvTGN4dW5LeUppWjVqb296ajI1dWQ1OG9RRHhuWDhQc0lsMW9QQVNm?=
 =?utf-8?B?TE4wYWtIZkZYb01OY2pwVVRDMk51WUMrMG1GSFpYbU5CMzZLYjJNMkRUMURt?=
 =?utf-8?B?R2RVOGNmcCtNVnlDUU9DSk9lQWs5SmNKU2h5OXNnODhpdWRyTlZlWjFIYzlo?=
 =?utf-8?B?T2RRUjl0bHl3THhkV3JNZThwQjZqUlRUV0VMTzQ5ZGEwMWw0NkRWazFwYnB3?=
 =?utf-8?B?cFc4WVNhYW9aczJ1aVVaVnVrUU41K2lCZ0ZLYW9od2M2Z205anVoZnRianZi?=
 =?utf-8?B?WFN0YXN3cVoxMWNKaTkxaUZQaEZQLzdObUVPbDJZRm80VzR2dG9qRjFJRDEv?=
 =?utf-8?B?RDVRSW1teDZ2bnFuVCtsTVUvSE83Qll5clhRQnFvRjNoOC82NUJpc0hxaFA4?=
 =?utf-8?B?cERhcXRWcWxHcC85NklrV3ZsTkd2ZDVBTHErRXpLU3dFVmJKb2RNSVBHRHlF?=
 =?utf-8?B?MnZWOWRubGN4Rjc2RjJ4Z3plNndrTUE4cktZejI1Z09WWlUva1FaSHptb1FV?=
 =?utf-8?B?UTArcHpMMnU5L3ZnVXVrUUtyQ09oMDMwcFhLS0lXd2NaUlRudXJ4OVQ2d2FY?=
 =?utf-8?B?cG9GODFOdCs0ak9nUWZPUGtzcTY5OE9RcnNKLytoMDRIanpIbTZRRXVyREcy?=
 =?utf-8?B?Z090RUtOcDNiRlZVQzliYWtBYnNFMUVUMGRvNXI5citPQTgxQkRoRFYvbi9j?=
 =?utf-8?B?RmVBSFNycXBFS3dFcWVhbnRnaVhMTEpGZXNzTUhWSzNCdzd4dklzYll0UytT?=
 =?utf-8?B?VHpJaGhiUkF1NGtVYXVhbkhLK1dyN1dFWlFOZVQ1RExPQncrL1pyR2paaU9F?=
 =?utf-8?B?MGxEZGVhRDZFTVFkVzlRU3FRZG5vSHRneHdtMno2OXdNbzZBQWlGSkhqYWRB?=
 =?utf-8?B?UGpTR1R4QytnV0U4R1gwV0dPMStBY1J3dVc0TkNZM005RFkwUFFESFdPM2RX?=
 =?utf-8?B?Z2ZGWUFna0dya1dXZkRPRm5LUUtwd0w3d2VFM3MwSzZ1bXJybEJJdzd1NjB1?=
 =?utf-8?B?RU93c3dOYVFPb3Z2dWlmSndhKzlrYUxmNFY1c1dEMkNWRjhPSTVqYTZSZG1n?=
 =?utf-8?B?MzdIVWQ1RGxQWkQ3ekdOdlZxakxEUVlCTm9FRndBZ05QMWlkUEhVZ0tMRFBl?=
 =?utf-8?B?L1RGVmR6amI3T3NVd0QvUWR0c09TdXIreCtWaGw5dXNUelZnVlovZnR0TENl?=
 =?utf-8?B?TEhjSTA0djJCamRSSDk2M3p2M3hTQmxTUUkxOTZEa2FCRFY2aFVzdGZrZ3RR?=
 =?utf-8?B?QVptMEd3bU9CNG9aNjdTbUhTOHpGWC9JTm9tUm5wWktnbWhlRWZuTnFlVDdT?=
 =?utf-8?Q?VSs4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346e0983-8d56-4281-1e6f-08dbd5f9ccdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:01:46.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udbK6XUG0gBsaV6q+pbqtLfCM4p2qRC7fLDrwn+lGfvD95OhGKWcxJ2VQ5YJenX0E3I84sIEj1ZKrB7bL0tx/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGNsay1jb25mOiBieXBhc3Mgc2V0dGluZyByYXRl
L3BhcmVudCBpZiBhbHJlYWR5IHNhbWUNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUaHUsIE9j
dCAyNiwgMjAyMyBhdCA4OjM14oCvQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAu
Y29tPg0KPiB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4g
Pg0KPiA+IElmIHRoZSBvcmlnaW5hbCByYXRlIGFuZCBwYXJlbnQgaXMgYWxyZWFkeSB0aGUgc2Ft
ZSBhcyB3aGF0IHVzZXJzDQo+ID4gd2FubmEgdG8gY29uZmlndXJlIHRocm91Z2ggYXNzaWduZWQg
Y2xvY2sgcmF0ZSBhbmQgcGFyZW50LCB0aGVyZSBpcyBubw0KPiA+IG5lZWQgdG8gY29uZmlndXJl
IHRoZW0gYWdhaW4gd2hpY2ggbWF5IGNhdXNlIG1vcmUgY3B1IGN5Y2xlcyBvciBtb3JlDQo+ID4g
U0NNSSBSUEMgY2FsbHMuDQo+ID4NCj4gPiBTbyBjaGVjayB0aGUgcmF0ZSBhbmQgcGFyZW50IGZp
cnN0LCBhbmQgYnlwYXNzIHdoZW4gdGhlIG9yaWdpbmFsIHJhdGUNCj4gPiBhbmQgcGFyZW50IGFy
ZSBzYW1lIGFzIHJlcXVlc3RlZCBieSBkZXZpY2UgdHJlZSBub2RlLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlv
dXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1jb25mLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2Nsay9jbGstY29uZi5jDQo+ID4gQEAgLTY1LDcgKzY1LDExIEBAIHN0YXRpYyBp
bnQgX19zZXRfY2xrX3BhcmVudHMoc3RydWN0IGRldmljZV9ub2RlDQo+ICpub2RlLCBib29sIGNs
a19zdXBwbGllcikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiAg
ICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIHJjID0gY2xrX3NldF9w
YXJlbnQoY2xrLCBwY2xrKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKF9fY2xrX2dldF9odyhw
Y2xrKSAhPSBfX2Nsa19nZXRfaHcoY2xrX2dldF9wYXJlbnQoY2xrKSkpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmMgPSBjbGtfc2V0X3BhcmVudChjbGssIHBjbGspOw0KPiA+ICsgICAg
ICAgICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmMgPSAwOw0KPiAN
Cj4gVGhlIGVsc2UgYnJhbmNoIGlzIG5vdCBuZWVkZWQsIGFzIHJjIGFscmVhZHkgaW5kaWNhdGVz
IGEgbm9uLWVycm9yIGNvbmRpdGlvbi4NCj4gDQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBp
ZiAocmMgPCAwKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiY2xrOiBmYWls
ZWQgdG8gcmVwYXJlbnQgJXMgdG8gJXM6ICVkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX2Nsa19nZXRfbmFtZShjbGspLA0KPiA+IF9fY2xrX2dldF9uYW1lKHBjbGsp
LCByYyk7IEBAIC0xMTIsNyArMTE2LDEwIEBAIHN0YXRpYyBpbnQNCj4gX19zZXRfY2xrX3JhdGVz
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwgYm9vbCBjbGtfc3VwcGxpZXIpDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihjbGspOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJj
ID0gY2xrX3NldF9yYXRlKGNsaywgcmF0ZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGNsa19nZXRfcmF0ZShjbGspICE9IHJhdGUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByYyA9IGNsa19zZXRfcmF0ZShjbGssIHJhdGUpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJj
ID0gMDsNCj4gDQo+IExpa2V3aXNlLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAocmMgPCAwKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJj
bGs6IGNvdWxkbid0IHNldCAlcyBjbGsgcmF0ZSB0byAldSAoJWQpLCBjdXJyZW50DQo+IHJhdGU6
ICVsdVxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Ns
a19nZXRfbmFtZShjbGspLCByYXRlLCByYywNCj4gDQo+IEhvd2V2ZXIsIG9uZSBjYW4gd29uZGVy
IHdoZXRoZXIgdGhpcyBjaGVjayBzaG91bGQgYmUgZG9uZSBpbg0KPiBjbGtfc2V0X3BhcmVudCgp
IHJlc3AuIGNsa19zZXRfcmF0ZSgpIGluc3RlYWQsIHNvIGl0IHdvdWxkIGJlbmVmaXQgYWxsIGNh
bGxlcnM/DQoNClllYWgsIEkgY291bGQgZG8gdGhhdCwgYnV0IGZpcnN0IExldCdzIHNlZSB3aGV0
aGVyIFN0ZXBoZW4gaXMgb2sgd2l0aA0KeW91ciBzdWdnZXN0aW9uIG9yIG5vdC4NCg0KPiANCj4g
QWxzbzoNCj4gDQo+ICAgICAvKioNCj4gICAgICAqIGNsa19nZXRfcmF0ZSAtIG9idGFpbiB0aGUg
Y3VycmVudCBjbG9jayByYXRlIChpbiBIeikgZm9yIGEgY2xvY2sgc291cmNlLg0KPiAgICAgICog
ICAgICAgICAgICAgICAgVGhpcyBpcyBvbmx5IHZhbGlkIG9uY2UgdGhlIGNsb2NrIHNvdXJjZSBo
YXMgYmVlbiBlbmFibGVkLg0KPiAgICAgICogQGNsazogY2xvY2sgc291cmNlDQo+ICAgICAgKi8N
Cj4gDQo+IFNvIGF0IGxlYXN0IHRoZSBzZWNvbmQgcGFydCBpcyBub3QgZ3VhcmFudGVlZCB0byB3
b3JrPw0KDQpJIGFtIG5vdCBzdXJlLCBidXQgc2VlbXMgdGhlcmUgaXMgbm8gY2xrIGVuYWJsZWQg
Y2hlY2sgaW4gY2xrX2dldF9yYXRlDQpmdW5jdGlvbi4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
