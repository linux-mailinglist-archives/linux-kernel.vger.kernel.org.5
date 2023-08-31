Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDA78E692
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjHaGdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHaGdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:33:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E401B1;
        Wed, 30 Aug 2023 23:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp9Vcw7gqXfQwwLId1fux6NJ2oGHHz6x6YaZF3bjTQzZVr1DWA0v8Bkdagpxx3UG/JienA7y8wm5CsAM2RUHnlFBfmCLF6z0KDVnxE8xX+yZbimYFU3Ub9dY1tmMwTJOhnyqHOkthfuCC1blAL9bnGsFIM84hY6kpJcBG8wtS5naSQptyu7TSurxThMarYcpBmIiFC6/oL1LQefqm6pU9zDZpw/GmYIZnaT27f30q1eYmc0ponqynFsY/aJgeIIXd22sao3dbD2pBq883HsCFxxpF7RQBL1CxWqY6Hjs2vdx18UOgGCkuacRDPsBSbOAL8RDKrn1K1WJv/lq0v2LbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erKfR1CaGBuGCY51r9yRe8yfqUA5WIDMVESGkHkYpG4=;
 b=TC4cvj1W11/Yy+2UAzbm7L8tmZs4G5Z22XurptsQJmChlfI3gtvs8ZnsRo5K675LU31ISxw/5IU9OCdE//mSVULZpVMkCDDmzTel6L7vyvs1472Ocequf2SjQKjjxCOqMNYLL3dPSqNWTk8mZ7fnm4hRYeHnV488dh6p5QZtaQk8qJAtRvqM30+rfNQsFNKgS/4tJKpq8c96OeNVc8o6bfm3smgp1+A0bnipOA2J63wmMY1QIOgg5bXSP5Lmp3gz8FvSEWE/tQicFS6/KTNefjMpcGpFV7GWpg33UM1TEPKrQCOIiYr1mNTQAtkCL2jTROhgyT9lCw3SYXBM7jOhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erKfR1CaGBuGCY51r9yRe8yfqUA5WIDMVESGkHkYpG4=;
 b=s7pn4LqxZm1eQb/u8RYBJChWX4Zb9enX0G019wx5mJr4Rmr2zImWh4FwPJNdoddtYtLBP4U3Io3mcN6nktGMHys/MvFnrktD/B0wXUJHRJwjq67lswffFIyY20aICFntgs4+fDzdoT+W59CRqzE4CU+RYZ0wfLjHINh/qifWKK8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 06:33:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39%4]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 06:33:10 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Thread-Topic: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Thread-Index: AQHZ2klmZUX6Ja0EJ0SXpP8EIwL9DbAA5awAgAE+P1CAAFEhgIABddFw
Date:   Thu, 31 Aug 2023 06:33:10 +0000
Message-ID: <AS8PR04MB86766A53AD3EDCB308457A928CE5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
 <1693291534-32092-2-git-send-email-hongxing.zhu@nxp.com>
 <7c083976-81cc-96e3-af76-43944ce571ac@linaro.org>
 <AS8PR04MB8676B511250439EF71D0E3488CE6A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <3baa61b5-e915-88a5-8e8d-717072ce6f2d@linaro.org>
In-Reply-To: <3baa61b5-e915-88a5-8e8d-717072ce6f2d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8413:EE_
x-ms-office365-filtering-correlation-id: a5b4b3d3-c800-4092-69e4-08dba9ec2567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFcLYcyorFAsZG606MhUmtP4dedVOiIC7UWfkuXvS2pZ4Sy4E3NwAdM3xGmL22acI4tP5xCHquQ5LSo8PIRt+mt3VegUkdIwaSNDLpVJXP+flohqzecNqQWWmyID7WdC62R2iCjiNoWynSh4X45bWXuq+Qd1CPzAZKXBkz8W9bgTMCg43asEGeyO02lugea0dVytOPRvCw31PMk/RaZh8tKf/81YbShyCMaZsGg+zPvfVpWIMk77DEprpIT8eq4ZGvC1Hg/t8uv3gf2orjFLcEkDUDmB9S0ItxodcSM8tOwhcpMSUo6I0IJezPlVZvauCNUNir7aX13qtvKeCVnddewdNq1c9hYEI0DAVwftZgPjkhazEXRyPObzB1yubM7uwi3cj/qXRHcDs0VWmyB1ZZKAOlzZtu8Gw7bCVuURWEk1VPxw1MuPGnNPh/5Uqms/RORSTLNSJOa0FOh/bBVagWw3S28M2CQ3tsXA6Nn4b+v0VKTARVMJCDSbXnZoqKvQSSINmES2QJOsLfqPV+AqMhKWNxl04ecliaDLSa6vfUbHYYlr/nUz7Vw+YG3Ic1E1qsb4r+z5Kiw0Ksl0LCmjWp8Z+vQfSQCzht1QgNc/T9TccWhLSzx6Kw0thLDX8pgs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(41300700001)(6506007)(53546011)(7696005)(9686003)(7416002)(921005)(55016003)(122000001)(66476007)(66556008)(54906003)(38100700002)(316002)(64756008)(38070700005)(66446008)(76116006)(66946007)(2906002)(478600001)(110136005)(966005)(45080400002)(71200400001)(4326008)(8676002)(8936002)(83380400001)(5660300002)(52536014)(44832011)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d0o4RW1LaW13cmp5UWRudUhXOUtpOHhMcEpxeWllN1M1aSt5Vm5VOXJaWXBt?=
 =?gb2312?B?dm9iUFZpT3hMSi9CNTdqcmRjWXBMSnhOOFpCSnhmOG9jM0gyNi8xd1NFaHZV?=
 =?gb2312?B?aVltMC9YWHg3bDFmZitLcUh0ZlZURXpMSEFuVEp2d0hkZVdSTGFpK0FQV1FK?=
 =?gb2312?B?RmZybDBoY2JQQWwvSkZQU0lteEVQVnY3YjJJd1J2RFY1MXZ4VFc3UUhVY242?=
 =?gb2312?B?WEtBclZERkY1MkVheTEyeW94R0hHK2p0aS9QVVhjUFRDYlAxc3ZOYmVjUUZ5?=
 =?gb2312?B?bjl6ejlOVTQ3RzNFN1F4aXRXbVVuZ2tOdGd4TmsvSVYxVlF1b2g0czNCQUUz?=
 =?gb2312?B?UVBVeDljZ25PcjY0eEl1a3NHejFzRG9nNllLVzAydThRblVJTVFWYWZUWnc0?=
 =?gb2312?B?YnNiT2lCcTliMEViV08xUmg5UHoyWDVqbE1rSkNlQk9OeFphQXIwZ2JIR1kw?=
 =?gb2312?B?NW5lQ0tFTXlLWk5kZjMyVDk2d1dVc2NBK3RUYVcvYWJ1bXd6amtYOUhWZlNs?=
 =?gb2312?B?c3J4SjNQak43M2JSNmtBa1FSTmZrVUN1cjQwUmRwTGVCaTJlNjkrbms5b0kw?=
 =?gb2312?B?Qk5KQ1Z5NS9jT2VYWmFnMWJEV3BPd3pwVUJDMnR0VDdNblB2ZExvOTJUelRh?=
 =?gb2312?B?SGlLdE9JT2c0Wm5HaUkxSThYSkxreEJ4YXZPa05ncXFUbU85aHBWejdBb090?=
 =?gb2312?B?R1crZDJEd3JBRzBqeEtudzE0RjExVk0rVG5mZ1c3blpOMWZhZitWeGM4Yi9H?=
 =?gb2312?B?N0xxK214akxCOU02dXAwYlh2N2dQWk5tb1U5RTZwV0lZTTZVRTZ6WEwrMGhW?=
 =?gb2312?B?bm1lMWdSL2dGT2xvRWhkaUc3dGRpSjh4TXg3U1lkVlRYMWp0R2NlTUtjUHZZ?=
 =?gb2312?B?UEI1Vm94QUdkVHpSeU5GeEVoL0c3cXNnN2U5cjZ3KzZSemlrK2RxemdDUzE3?=
 =?gb2312?B?MFVkcW5CUCtGcGtSSXdJMXEzMDBTWjFiUFpjeXpzZmRLL0pOYitQTGgrNDlR?=
 =?gb2312?B?VC9RZy9HMDV5RElrcmJrajM0ODJtTVcwbjk1NUxXVWltWW9nc0J2L0Vuc3gz?=
 =?gb2312?B?YkJraDNKOHI1SjFHb3BmS0k4T2ZOamlBYUJUK1FPZXNJSTVLQzFGL3VadWdW?=
 =?gb2312?B?R0VDZUc1M1FZYU1lK0RaU3hXSTIxdmcwczFUaXFFWURPN0FBZ1NuaWFDeU5V?=
 =?gb2312?B?cTZ0TG5XSlRYSlBpRzBGdk9Td2crVnNPZkFZbmJJQ25EWXovc2pzSHF0UUpZ?=
 =?gb2312?B?aWwzUnVoOG03QlFTU3hBRjdGWXFWdUZEV0h3Ky9yamJYVHQ0d0xPcnFPUG5F?=
 =?gb2312?B?SXBXeU41L00vQmpwTiswb0FiTDVNZVhTR2tIeEFTYmRFK1MxWlpGd240Q29j?=
 =?gb2312?B?MjNONHNEWGpMVVZZeUhwd0w4ZXdrSjZHQUhyL095QmJZVmo0bEpDVlV0NXFy?=
 =?gb2312?B?aUlSQVpjcm5VTzJLM1F3bC9lQjZvc0xQZjlSOEVkNFdCSWVueE5zZ2pGdjVp?=
 =?gb2312?B?YjhTWFFrTDhGeUpTMkoyWGhQMlF3ektHaDFzaTFRd0JqdkEzK0pndFdlOURq?=
 =?gb2312?B?b1lYRkJYYzhRVXo1T0FRSjZrVlJpc2U0dmJNN05SS2RDQWdKbThUWjZVSUJ1?=
 =?gb2312?B?allVRGZoSHRvR29obExMN3hQQ1NodkljOVhlbVFlZ3Qvd3h5UUhyZkxsejZz?=
 =?gb2312?B?ZVNPMEk4eE5SWVoxOWtOVFhtTTAvRnBuVzhqUkZZVXd2ZXZ6cEZwSGJVUWI1?=
 =?gb2312?B?WlJCc0ZkUGNBa1dQWGdRbWpnY2IyWXZnNHY2eVVOWVd4WWNIT0U2QVVlMVU2?=
 =?gb2312?B?eUR3ZDdmdXA2RnY0amQxWnBUaFlLK2dCT2ZmNk83emg5Ni9yK1kzeW5Ld0FU?=
 =?gb2312?B?UmI2c3VaT3ZUUU5kZ3Z3cWd4NHRvTHI2R0JKZUtyeHZUMWNWUjFVNDlTS2Q1?=
 =?gb2312?B?Q3FmUnZFT3Q4Q2FkZXdvNFpYUVAvdDVrWXAvN3BRano2Y2JXc0w0SFZYOU1w?=
 =?gb2312?B?YnkwRWJzbjRaa2VOZnQ5WGUwdmN4anE2RVNxazFKL1hUdkdIc2o4VHcxV2hO?=
 =?gb2312?B?WTZnRmRPTHNLOFJTNmxXSk9NSTRVZnk4QVlDUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b4b3d3-c800-4092-69e4-08dba9ec2567
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 06:33:10.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUxJL4ECHQnApUuQP+5/rqAWzAvIuonFBezBgHPsEGNGn7qYDfwgJeUEBnb18i//RayOhjz3iupgGh0smSDrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPE6jjUwjMwyNUg
MTU6MzcNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyB2a291bEBr
ZXJuZWwub3JnOw0KPiBraXNob25Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdt
YWlsLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYS5mYXRvdW1AcGVuZ3V0cm9uaXguZGU7
DQo+IHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZQ0KPiBDYzogbGludXgtcGh5QGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzNdIGR0LWJpbmRpbmdzOiBwaHk6IEFkZCBp
Lk1YOFFNIFBDSWUgUEhZIGJpbmRpbmcNCj4NCj4gT24gMzAvMDgvMjAyMyAwOTozMSwgSG9uZ3hp
bmcgWmh1IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+Pj4gKyAg
ICAgIFNwZWNpZmllcyB0aGUgZGlmZmVyZW50IHVzZWNhc2VzIHN1cHBvcnRlZCBieSB0aGUgSFNJ
TyhIaWdoDQo+ID4+PiArIFNwZWVkIElPKQ0KPiA+Pg0KPiA+PiBJIGRvbid0IGtub3cgd2hhdCBh
cmUgdGhlIHVzZWNhc2VzLi4uDQo+ID4gU29ycnksIG1pc3Mgb25lIHNwYWNlIGJldHdlZW4gInVz
ZSIgYW5kICJjYXNlcyIuDQo+DQo+IEkgZGlkIG5vdCBtZWFuIGxhbmd1YWdlIHR5cG8sIGJ1dCBp
biBnZW5lcmFsIC0gd2hhdCBhcmUgeW91IGRlc2NyaWJpbmcgaGVyZT8NCj4NCj4gPiBpLk1YOFFN
IEhTSU8gbW9kdWxlIGNhbiBiZSBjb250cm9sbGVkIGJ5IERTQy9zb2Z0d2FyZSBpbiB0aGVzZSB0
aHJlZQ0KPiA+IGRpZmZlcmVudCBtb2Rlcy4gU28gSSBhZGQgdGhpcyBwcm9wZXJ0eSAoZnNsLGhz
aW8tY2ZnKSBoZXJlIHRvIHNwZWNpZnkNCj4gPiB0aGUgIHdvcmsgbW9kZSBvZiBIU0lPLg0KPg0K
PiBTbyBtb2RlcyBvZiB3b3JrPyBPciBkaWZmZXJlbnQgZGV2aWNlIGF0dGFjaGVkIHRvIHRoZSBQ
SFk/IE9yIHdoYXQ/DQo+IFRoZXJlIGlzIG5vIHVzZSBjYXNlIGluIGhhcmR3YXJlIGFuZCB5b3Ug
c2hvdWxkIGRlc2NyaWJlIGhhcmR3YXJlLg0KPg0KT2theSwgSSBzZWUuDQpNb3JlIGV4YWN0bHks
IEhTSU8gc3Vic3lzdGVtIGRlZmluZXMgdGhyZWUgdXNlIGNhc2VzLg0KQW55d2F5LCBpdCdzIHNo
b3VsZCBiZSBhbm90aGVyIHN0dWZmcywgYW5kIHNob3VsZG4ndCBiZSBkZXNjcmliZWQNCiBpbiBQ
SFkgZHQtYmluZGluZ3MuDQo+ID4+DQo+ID4+PiArICAgICAgbW9kdWxlLiBQQ0lFQVgyU0FUQSBt
ZWFucyB0d28gbGFuZXMgUENJZWEgYW5kIGEgc2luZ2xlIGxhbmUgU0FUQS4NCj4gPj4+ICsgICAg
ICBQQ0lFQVgxUENJRUJYMVNBVEEgcmVwcmVzZW50cyBhIHNpbmdsZSBsYW5lIFBDSWVhLCBhIHNp
bmdsZSBsYW5lDQo+ID4+PiArICAgICAgUENJZWIgYW5kIGEgc2luZ2xlIGxhbmUgU0FUQS4gUENJ
RUFYMlBDSUVCWDEgb24gYmVoYWxmIG9mIGEgdHdvDQo+ID4+PiArICAgICAgbGFuZXMgUENJZWEs
IGEgc2luZ2xlIGxhbmUgUENJZWIuDQo+ID4+PiArICAgICAgUmVmZXIgaW5jbHVkZS9kdC1iaW5k
aW5ncy9waHkvcGh5LWlteDgtcGNpZS5oIGZvciB0aGUgY29uc3RhbnRzIHRvDQo+ID4+PiArICAg
ICAgYmUgdXNlZCAob3B0aW9uYWwpLg0KPiA+Pg0KPiA+PiBOb25lIG9mIGFsbCB0aGlzIGhlbHBl
ZCBtZSB0byB1bmRlcnN0YW5kIHdoYXQgcGFydCBvZiBoYXJkd2FyZSB0aGlzDQo+ID4+IGlzIHJl
c3BvbnNpYmxlIGZvci4gSXQgc2VlbXMgeW91IGp1c3Qgd2FudCB0byBwcm9ncmFtIGEgcmVnaXN0
ZXIsIGJ1dA0KPiA+PiBpbnN0ZWFkIHlvdSBzaG91bGQgdXNlIG9uZSBvZiBleGlzdGluZyBwcm9w
ZXJ0aWVzIGxpa2UgcGh5LW1vZGVzIGV0Yy4NCj4gPiBJdCdzIG15IGJhZC4gRGlkbid0IGRlc2Ny
aWJlIHRoZSBIVyBjbGVhcmx5IGFib3ZlLg0KPiA+IFRoZSBmc2wsaHNpby1jZmcgaXMgdXNlZCB0
byBzcGVjaWZ5IHRoZSB3b3JrIG1vZGUgb2YgSFNJTyBzdWJzeXN0ZW0sDQo+ID4gbm90IG9ubHkg
IHRoZSBQSFkgbW9kZS4gU2luY2UgdGhlIFBIWXMgYXJlIGNvbnRhaW5lZCBpbiB0aGUgSFNJTw0K
PiA+IHN1YnN5c3RlbSwgY2FuJ3QgYmUgdXNlZCBieSBQQ0llIG9yIFNBVEEgY29udHJvbGxlciBm
cmVlbHkuIFRoZSB1c2FnZQ0KPiA+IG9mIHRoZXNlIFBIWXMgYXJlIGxpbWl0ZWQgIGJ5IHRoZSBI
U0lPIHdvcmsgbW9kZXMuIEJUVywgdXAgdG8gbm93LCBJDQo+ID4gc3RpbGwgZG9uJ3QgaGF2ZSBh
IGdvb2QgaWRlYSB0byAgZGVzY3JpYmUgdGhlIEhTSU8gYnkgcGh5LW1vZGVzIHByb3BlcnR5DQo+
IGFsdGhvdWdoIEkgcHJlZmVyIHRoaXMgd2F5IGluIG15IG1pbmQuDQo+DQo+IFdoYXQgaXMgSFNJ
TyBhbmQgd2h5IGRvZXMgaXQgYXBwZWFyIGluIGNvbnRleHQgb2YgdGhpcyBwaHk/DQo+IFNwZWNp
ZmljYWxseSwgaWYgdGhpcyBpcyBzZXBhcmF0ZSBzdWJzeXN0ZW0sIHdoeSBkbyB5b3UgcHV0IEhT
SU8gcHJvcGVydHkgaW4gdGhlDQo+IHBoeT8gTm8sIHRoYXQgZG9lcyBub3Qgc2VlbSByaWdodC4N
Cj4NClVuZGVyc3RhbmQsIHRoZSBkZXNjcmlwdGlvbnMgb2YgSFNJTyBzdWJzeXN0ZW0gc2hvdWxk
bid0IGJlIGNvbnRhaW5lZCBpbiB0aGUNCiBQSFkgZHQtYmluZGluZyBkb2N1bWVudC4NCj4gPj4N
Cj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMy
DQo+ID4+PiArICAgIGVudW06IFsgMSwgMiwgMyBdDQo+ID4+PiArDQo+ID4+PiArICBjdHJsLWNz
cjoNCj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhh
bmRsZQ0KPiA+Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBwaGFuZGxlIHRvIHRo
ZSBjdHJsLWNzciByZWdpb24gY29udGFpbmluZyB0aGUgSFNJTyBjb250cm9sIGFuZA0KPiA+Pj4g
KyAgICAgIHN0YXR1cyByZWdpc3RlcnMgZm9yIFBDSWUgb3IgU0FUQSBjb250cm9sbGVyIChvcHRp
b25hbCkuDQo+ID4+DQo+ID4+IFBsZWFzZSB0cnkgc29tZSBpbnRlcm5hbCByZXZpZXcgYmVmb3Jl
IHBvc3RpbmcgdG8gcGF0Y2hlcy4gQ29tbXVuaXR5DQo+ID4+IGlzIG5vdCBjaGVhcCByZXZpZXdl
cnMgdGFraW5nIHRoaXMgZHV0eSBmcm9tIE5YUC4gSSBhbSBwcmV0dHkgc3VyZQ0KPiA+PiBOWFAg
Y2FuIGFmZm9yZCBzb21lb25lIGxvb2tpbmcgYXQgdGhlIGNvZGUuDQo+ID4+DQo+ID4+IFRoaXMg
bWlzc2VzIHZlbmRvciBwcmVmaXgsIGFzIGV4cGxhaW5lZCBtYW55IHRpbWVzIGZvciBldmVyeSBz
eXNjb24NCj4gPj4gcGhhbmRsZS4gQWxzbyBvcHRpb25hbCBpcyByZWR1bmRhbnQuDQo+ID4gU29y
cnkgYWJvdXQgdGhlIG1pc3NpbmcgcHJlZml4LiBUaGUgcHJlZml4IHdvdWxkIGJlIGFkZGVkIGxh
dGVyLg0KPiA+IEFuZCB0aGUgb3B0aW9uYWwgd291bGQgYmUgcmVtb3ZlZC4gVGhhbmtzLg0KPiA+
Pg0KPiA+PiBCdXQgYW55d2F5IHN0YXR1cyBvZiBQQ0llIG9yIFNBVEEgY29udHJvbGxlciBpcyBu
b3QgYSBwcm9wZXJ0eSBvZiB0aGUNCj4gPj4gcGh5LCBzbyBpdCBsb29rcyB0byBtZSB5b3Ugc3R1
ZmYgaGVyZSBzb21lIHByb3BlcnRpZXMgYmVsb25naW5nIHRvDQo+ID4+IHNvbWUgb3RoZXIgbWlz
c2luZyBkZXZpY2VzLg0KPiA+IEkgc2VlLiBZb3UncmUgcmlnaHQgdGhlIHN0YXR1cyBvZiBQQ0ll
IG9yIFNBVEEgY29udHJvbGxlciBpcyBub3QgYQ0KPiA+IHByb3BlcnR5ICBvZiB0aGUgUEhZLiBT
b21lIGJpdHMgY29udGFpbmVkIGluIHRoZSBjdHJsLWNzciByZWdpb24sIGFyZQ0KPiA+IHVzZWQg
dG8ga2ljayBvZmYgcmVzZXRzIHRocm91Z2ggdGhlIGludGVybmFsIGdsdWUgbG9naWMuIFNvLCB0
aGlzDQo+ID4gcHJvcGVydHkgaXMgYWRkZWQgIGZvciBwaHkgZHJpdmVyLg0KPg0KPiBTb3JyeSwg
SSBhbSByZWFsbHkgZmVkIHVwIHdpdGggdGhlIHN5c2NvbnMuIFNlZSBoZXJlOg0KPiBodHRwczov
L2xvcmUua2Vybi8NCj4gZWwub3JnJTJGYWxsJTJGMjAyMzA4MzAwMzE4NDYuMTI3OTU3LTItd2ls
bGlhbS5xaXUlNDBzdGFyZml2ZXRlY2guY29tJQ0KPiAyRiZkYXRhPTA1JTdDMDElN0Nob25neGlu
Zy56aHUlNDBueHAuY29tJTdDNGMyYTVjZmZjNmQyNDgxMjFjODYwDQo+IDhkYmE5MmJmM2I1JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODI4DQo+IDk3Nzg0
NjY5MjM4NDklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0oN
Cj4gUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0Ml
N0MlN0Mmc2RhdGENCj4gPTJtWWh2WEZ4Y1FzdEREOXlDOTY5UzFDUnZ6ejE5ZU4ybFp5a0xoeHo5
QTAlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBJIGNhbm5vdCB0cnVzdCB5b3Ugb24gdGhpcyBhbnltb3Jl
LiBEZXNjcmliZSBoYXJkd2FyZSBwcm9wZXJseS4gSWYgeW91IGhhdmUNCj4gcmVzZXRzLCB5b3Ug
aGF2ZSByZXNldCBjb250cm9sbGVyLiBJZiB5b3UgaGF2ZSBjbG9ja3MsIHRoZW4gY2xvY2sgY29u
dHJvbGxlci4NCj4NCj4gPj4NCj4gPj4+ICsNCj4gPj4+ICsgIG1pc2MtY3NyOg0KPiA+Pj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4+PiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAgIHBoYW5kbGUgdG8gdGhlIG1pc2MtY3NyIHJl
Z2lvbiBjb250YWluaW5nIHRoZSBIU0lPIGNvbnRyb2wgYW5kDQo+ID4+PiArICAgICAgc3RhdHVz
IHJlZ2lzdGVycyBmb3IgbWlzYyAob3B0aW9uYWwpLg0KPiA+Pg0KPiA+PiBTYW1lIHByb2JsZW1z
Lg0KPiA+Pg0KPiA+ICJmc2wsaHNpby0iIHByZWZpeCB3b3VsZCBiZSBhZGRlZCBsYXRlci4NCj4N
Cj4NCj4gSWYgeW91IGhhdmUgc29tZSBIU0lPIGJsb2NrLCB3aHkgZG8geW91IHJlZmVyZW5jZSBp
dCB2aWEgcGhhbmRsZSBhbmQgd2h5IGRvDQo+IHlvdSBwdXQgaXRzIHByb3BlcnRpZXMgKG1vZGUp
IGhlcmU/IFdoYXQgaXMgdGhlIHJlbGF0aW9uIGJldHdlZW4gSFNJTyBhbmQgdGhpcz8NCj4gU28g
bWFueSBxdWVzdGlvbnMuLi4gZnJvbSB5b3VyIGNvbW1pdCBkZXNjcmlwdGlvbiBhbGwgdGhpcyBs
b29rcyBlbnRpcmVseSB3cm9uZy4NCj4gWW91IG1lc3NlZCBkZXNjcmlwdGlvbiBvZiBIU0lPIGFu
ZCBub3cgdHJ5IHRvIGJhbmRhZ2UgaXQgd2l0aCBzdWNoIHByb3BlcnRpZXMuDQo+IE5vLg0KVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnRzLiBOb3csIEkgaGF2ZSBtdWNoIG1vcmUgY2xlYXJlciB2aWV3
LiBQSFkgZHQtYmluZGluZw0KIHNob3VsZCBvbmx5IGhhdmUgdGhlIEhXIGRlc2NyaXB0aW9ucyBv
ZiB0aGUgUEhZLCB0aGUgSFNJTyBzdWJzeXN0ZW0gc2hvdWxkbid0DQpiZSBtZW50aW9uZWQgYW5k
IGJlIG1lc3NlZCB3aXRoIFBIWSBkdC1iaW5kaW5nIGhlcmUuDQoNCkkgd291bGQgcmVtb3ZlIGFs
bCB0aGUgSFNJTyBkZXNjcmlwdGlvbiBpbiBuZXh0IHN0ZXAsIHRoYW5rcyBmb3IgeW91ciByZXZp
ZXcNCiBhZ2Fpbi4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPg0KPiBOQUsuDQo+DQo+
DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
