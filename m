Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB6773B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjHHPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHHPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:48:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9444BB;
        Tue,  8 Aug 2023 08:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxYOwcWGhXoFOTYWPDB3VaS52DB5FeLtguLLzSfAvuW9v0eUErVLqV+Dt24Zp7JsdqxF+vBk31D/tJIRCzhzIe1pE9xA60HqhFfCkKO6MI2mWJRSO8BANV76texB1i4f1dTDkJP4+R6RwRLB+FqEb3sQdyfoxDVsLXiTPecHsqdQb7HV0XfL1+QpUx8E9WkmYZGSWKaS1GJs0t6D0YiCwWavJJeyINpGD1BJMTElxOw6QgP1OTx+fNNjlU4wK6+gNuXD6g1E+0kWyEw3bXQHW4o1lmSv2Ffi9dovPXfwosi5pC0v5TqvR3Ns10uyhYPfPVNfrGQnAoXnDr4vv86XsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMNXuq+VpNQAyS6gojGpE1QoOIKTpnNMm+QQXwBl09E=;
 b=R7vZezfV67Ct2hShjptaa9sUj7iXHy2DN70QzKEHMJo7xTKAUZMn1K19c3jh2y72yGV4G7Tb5/Ekk+qAbpw551Dc9f7ojQ9gAGx0PwCvNCjf0o6SXNbrbbgMj0nJRPvjrNtYUcLFt8+vjabS/wArlLYyM4BWlfEgvVxDUWc05bM8UKh66hJ9dZaHxUz99GnuceU2Djdp21v/RBgAcLdyZuKQN0yzpmvA+BkVM3HdgQ9n4KUMMMMyruGVrS2S5gyUoEgo5ZpSaTdzavlI/M8b7Bm+6lT3KK9OsnrDkFxbo/N+3zbGXk4iAQ8nKOK7N7+gpoysIbl5h/6D6mr0yjGFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMNXuq+VpNQAyS6gojGpE1QoOIKTpnNMm+QQXwBl09E=;
 b=cOCOlIIx04HnOtCH2P/f7d6ZGbqshdFF9n6sR0zzcoR/iBbPy49sESzf1T4kNrEXci+CualYoVL2tM1GebUmNlkH1TiCmfIMf4eEebhboeVrJKyhU5cvHqwbI3MwRQImMGg+D50UEv7n3hzXSmGQhEGcLy0qbkbfScy+5aY1neo=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 11:34:14 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 11:34:14 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Topic: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Index: AQHZtLpCt80XNe94BE2xAgWYFY4Zrq+2fsMAgCnvgrA=
Date:   Tue, 8 Aug 2023 11:34:14 +0000
Message-ID: <DU2PR04MB863043CFB54E4CF2C5F34B65950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
 <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
In-Reply-To: <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS8PR04MB8341:EE_
x-ms-office365-filtering-correlation-id: bf6e35de-d5b0-4e21-9ef2-08db980364a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiNJG7RwokUI3QFOiUFFtO40R38CYnq6VCt2ghGz0/xmuA5H5nZH5rUKh8gHdLS+TsjNf8IyvMmNWwGT5F1qUIukq+9AhPdTRymrZPzoEB6Ky+jyRxfPoOHIEIhsXxQILK5Mx9/StIZ9mg43stoLB+lH6esvHtOP8Bw1Ta4bcRZ/IX46UntpGA2BbM/lk6VPsMQ0Pt1lWnkBCxN2ZAx0dvUd1itt9uC5B5R6D6ZN5Pj2kEKrQuFhzFbpdewUg8gaV5tmt3TYKgDrYt/wAdnfbHDRgSdZrzz6oQwUgtAPcAQ3TzmT3fGKlkIeyrf1UnjX9xdW8UrxlDLcOeYQJ35iUC3D9e0+NUE7UN6LoJ/vTCVwRnKG1T+OGR8UgDSkT5QCtjEOJ+N4P1rIRmpFDp1ixUsEZrAl4mU/icwn/eKRzoPWfO8nYzCeHykjdSB4IWfmfoLHGoxJJJ7d9XV4Pq758vGz2MzflCBwFbPN3qpm6DqxFx2FJfKNmuFZQz/jP8e2pjI3gA2p5b9+m/vvFiz3OJZJpnhjcg59PuNimxwHb9DqV+b5V61mtp53m5/aikvaaOE0n07536JHsFgIbCkSA8FcC1yU2HMug+pdO4Ub0v4YXQ9utHYmZ2kJ7TNHoL/d3i5dXDgx/W9w+eGBGioJ0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(1800799003)(186006)(478600001)(122000001)(921005)(83380400001)(9686003)(53546011)(55016003)(6506007)(33656002)(66556008)(316002)(76116006)(64756008)(66946007)(8676002)(41300700001)(8936002)(66476007)(2906002)(66446008)(71200400001)(6636002)(7696005)(38070700005)(110136005)(38100700002)(52536014)(86362001)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXQxTlFQQUVldTd2NmdEcWFybFdLUUN0ZkR1RHZDbm1kNXdqeGhUbTNQRktZ?=
 =?utf-8?B?akhSak1LU1JTNGJPSFBYb2NZeUxYa0VwQk11UjZBdTd5SUNpOTExa21jVmxq?=
 =?utf-8?B?OHQyR0szeElYTWZsUzNQcXdUNHNVaGJ4a0JNSDN2NCtTWlhUc1JKSGQ5UVFG?=
 =?utf-8?B?RHFFOEdhei9qNHo1aHNLOHNqZG9nWUZkUENtcVNTajV2MVJncWlKUm5yYmRa?=
 =?utf-8?B?dXdtTXhiZ1U2QUNKQXFGbjY3T3lmTERXRExkMDhNN1NZeUFjNlJkRWhuWnZY?=
 =?utf-8?B?elZtNUppRkpEOFhNTnRpcVlFeVNzMVVpaWg2ZStrVWI1Q3BxSVZJSWZTZnFm?=
 =?utf-8?B?WEVuMk9Qa252enM3WDdOZVFQSTErMnBiNisvampibG9NSkMvMGtNSUd1TE5s?=
 =?utf-8?B?dms5OFNGRHQxaWdQcmpBbCtLMVkxRk9Cc2g4Y0tibUp6K29yazFmSzVyWVRY?=
 =?utf-8?B?TURGaFZ2NUNFQ0xudFFQbWVwaldQcmhHZnNYMnNOS1U4czVGcXlSYzBIaDFY?=
 =?utf-8?B?UGNrNjFQRVRQOUdGQi9WNUx2TkI2TURlYVF2SFN5em5LaFpJdW5RYzlnUksr?=
 =?utf-8?B?MThuRTc4Y3MrWUt3aFU5b0E5ckd5TkRWalMxRlF5WVBZVzd6RFZCMzVycEdO?=
 =?utf-8?B?MlRHRDZPWFZSZFA0cHFFL2RiVlViUGtmZ3h3NTVzaXc3dXBDaWdJUVgyeTVT?=
 =?utf-8?B?aE1JOXdlNkVsZHpDQkd1eHcyaXlXTzhIME9ZVkE1MHAwVmlpdjJNbE5sT2NN?=
 =?utf-8?B?d2VUZGF5QkdtMCtLMzV5S3lMOHcvZENrbUlLYzFaaGIzRDViZWsrczJBdita?=
 =?utf-8?B?SDZwaGQwSTlVTU45V0Evcmo1S2hhTGpLTHh0T1loM2hVdWVlamxWbHpJdzFE?=
 =?utf-8?B?SldCZGFqeDJJMVNyUzExSFlTTGEwM3VCaFh5OTJTMmpZVU84WUhIeU1lTlkw?=
 =?utf-8?B?QzlCTDFsamgyRXR2TU9PZkxranN5RjFqMlBMZG9ldEViWm9DOU5YbkZZMTBr?=
 =?utf-8?B?emcvWjRTMGxqMmVXTDlvQlhSZUY0a1B4UXp6U3ZEY0VKQVExNmdtMXhTeVMv?=
 =?utf-8?B?Sm1PbmpLd202Tk5CR0ZnOUdjTm9qWDBLT2x5Z2ZZSis5S3R6Z2xXS21nZTg3?=
 =?utf-8?B?d01MSUdIOS9aTGZWd21adVVRYXIvWWtHV1k0RWw4Qm1FdERXcE1tQTdEb2RI?=
 =?utf-8?B?c2RtN3BVbVo1WlpEZmQ1QlJSYUdYVnRXcWJqcmZoaXd6czh2RkdNRHZnQzhm?=
 =?utf-8?B?bTZPZzE4bEVpMW9qZm5PNFlxNjc3Q1p4ZXduSjZKSm4rUUQxRGZRYzk3dXYr?=
 =?utf-8?B?YzRNck1NaWU0Q2FqVlN4VzVkalN3aldPcWtXRUZ0L2t4MHdZYXhNbEtMNitZ?=
 =?utf-8?B?ZVlIb2ZubXVOS1Ewazg2cldIWFAydVFwdVp1SWhkNWIwTU1kb2RlRnd2K1E3?=
 =?utf-8?B?MUx2ZWxMekJtOXU3NkdhcUUzY096aE1jK1ZKeHhjNG9oRVJ1V3IzZGl6OFdI?=
 =?utf-8?B?ZVA4UUt3UDAvdzl0ZmdkUThhK0FJZ3MyZ1ZKTmhoQmZYM3pwQzc4OU00SzhP?=
 =?utf-8?B?ZzFQOHRmVllrZFlzemhoMysyTjlTVkdQcVlSL2JDbFZ3amtaWllDTnA3VElO?=
 =?utf-8?B?Tmp0VmFTM1dSSzhRUmZpMjJvS0JNNWFwODVpamVoLzRtTldzWnhNY3pZSDcr?=
 =?utf-8?B?N3JSWlRzNDJpR0pLb1JET0ZETUplYmk5WVhWL0JpeGEwY2E0Ym1FZVZNeHFa?=
 =?utf-8?B?UDhrSnNyclVwWUd5NVh1SmdHZUhHOFdoa3lLT3U4cVRuWFJ1UVgwVGJWbk45?=
 =?utf-8?B?RWpTaW8yTE1CRWR3Nm5GSkRXTXBxVUJBdHpCcGVIcXpmbDFlbWV2Uithdkxm?=
 =?utf-8?B?ekVId0NkTEorWnFodWhyWkRMTXFydyt3NjlzV0txamY3bVRWTzl6UU5LVUZp?=
 =?utf-8?B?Q2trZmZCcnhOZUVIZG1YbEQxclBnYjdMYTVQa21TYlhYcWplRlQ1cnBHUlpW?=
 =?utf-8?B?b0R0cVJzTmhmU0pxcVg0Q2praHEveEhyZWREYzFRcXBtT013QmowNGwxbGhK?=
 =?utf-8?B?NW5zbzhwdWRkU3JXeFdQUlpuaDVwRG9DY3RPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e35de-d5b0-4e21-9ef2-08db980364a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 11:34:14.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzJv1j7TLKWeJmibS7HSyUIKw6mS64z01iaFY50JhskZzt/6BzUOU0Wgx1b3sWLbHMGxg1FpK2wxjKr2F0rS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAxMywgMjAyMyAxMjozOCBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFA
bnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgY2xpbkBzdXNlLmNvbTsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgcGllcnJlLmdvbmRvaXNAYXJtLmNvbTsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAu
Y29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgV2VpIEZhbmcNCj4gPHdl
aS5mYW5nQG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEJvdWdoIENoZW4N
Cj4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC0NCj4gaW14QG54cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR2F1cmF2IEphaW4NCj4gPGdhdXJhdi5q
YWluQG54cC5jb20+OyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBTYWhpbCBNYWxo
b3RyYQ0KPiA8c2FoaWwubWFsaG90cmFAbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+OyBWYXJ1bg0KPiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHY0IDQvN10gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBh
ZGRlZCBueHANCj4gc2VjdXJlIGVuY2xhdmUgZncNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0K
PiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2Ug
dXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTIv
MDcvMjAyMyAxNDoxMiwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+IEFkZGVkIHN1cHBvcnQgZm9y
IE5YUCBzZWN1cmUgZW5jbGF2ZSBjYWxsZWQgRWRnZUxvY2sgRW5jbGF2ZSBmaXJtd2FyZQ0KPiA+
IChzZS1mdykgZm9yIGlteDkzLTExeDExLWV2ay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBh
bmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kgfCAxMSArKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPiBpbmRleCA4
NjQzNjEyYWNlOGMuLjJiMGY5MDFkMjcwOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+IEBAIC0xLDYgKzEsNiBAQA0KPiA+ICAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4gPiAgLyoNCj4gPiAtICog
Q29weXJpZ2h0IDIwMjIgTlhQDQo+ID4gKyAqIENvcHlyaWdodCAyMDIyLTIwMjMgTlhQDQo+ID4g
ICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9pbXg5My1jbG9jay5o
PiBAQCAtODYzLDUgKzg2MywxNCBAQA0KPiA+IGRkci1wbXVANGUzMDBkYzAgew0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHg0ZTMwMGRjMCAweDIwMD47DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA5MCBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgZWxlX2Z3
OiBzZS1mdyB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlt
eDkzLWVsZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmczRtdWFwIDAg
MCAmczRtdWFwIDEgMD47DQo+IA0KPiBUaGlzIHNob3VsZCBiZSB0d28gZW50cmllcy4NCj4gDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIG1ib3gtbmFtZXMgPSAidHgiLCAicngiOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBmc2wsbXUtZGlkID0gPDM+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBmc2wsbXUtaWQgPSA8Mj47DQo+IA0KPiBEcm9wIGJvdGguIFNpbmNlIHlvdSBwdXQg
aXQgaW50byB0aGUgRFRTSSwgaXQgbWVhbnMgaXQgaXMgY29tcGF0aWJsZSBzcGVjaWZpYy4NCltQ
YW5rYWpdIFJlbW92ZWQgdGhlIGFib3ZlIHRocmVlIGVudHJpZXMuDQoNCj4gDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gDQo+IERyb3AuDQpbUGFua2FqXSBB
Y2NlcHRlZC4NCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
