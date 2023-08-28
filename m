Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8578A3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjH1BLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjH1BLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:11:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB327AA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UesUO/K5rOT45EQtVxY6yDKv7vPSoui0uHv9nqQ8/Pc0AetTd55dyKDrRuXeZ8d2o+EKZYtdDf+EnKz1wQ0APV0XOL09OqsJo+JYCH+fw1gQax6UoYsU3NDdDVX42GHbGZbTvj/Y7neJB5O5I/fSwaZ8/bZ4oMqIVlDJSWXgkTg9zbAPdYIBcibq+QTX0EItT3AokH6UU+hMuhxS9uVqCb3n+jcYB99vEku9d3px/7cWDvSWsGKlOiPob93XTrujIxyPTGTMAwtF/JQ0kx1zTPdGFzPsKYzGFIuuABtvZHaJan+wIRd+mYZf51KNc6q2+8neTXPwXwaEkZYg2FFk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDxN4fhK0fQDezRB4ZE4HoVy+N0SXIu1Gp3VOerwNKE=;
 b=hUYGvrG0cHlNuqzWJ/Mj2ewEhZcHfcC9ryUynyuihHTsEJ8qsDXetbSx+Q+epXijxsXfAuUiTQaz+NjvUhbjyd5r+IZqmO3u4sGcCkczTKy/W7vuLkesnjUdJFikhHTXaHXFBwT6a5Gcpy0nY3hvoWtE4VMdiPaWvQ6BRJAIn096Pp5zMCyRLm1/p4FAupnsNX+AQAQMfQ244O5OaoWM59/lCzseDwn8Vj7Qfx4J7/It3FGvM8vpfK8ja/G7nnvo4OTS9qqDpgvZoNvSF8MugMBR1cwwMtZLZtB55RxiV3yU2jFNebYFkWxrRh8OU/c5p5LCJU19Xu2AKTQpaDn3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDxN4fhK0fQDezRB4ZE4HoVy+N0SXIu1Gp3VOerwNKE=;
 b=YuEDXR4V/HcSjCaABjTgiNl/PDwmqS4Xs/8OS90e7B8AecxnUkzRlPYuSoWBsGpROmdrNEnh47SSxx5/YYZj8bZiM4Y8XIMK8M3HrqXKiWKxX6PWle7bTYWvauaaIQZDk7SesRIHb04uscF+xUBLQpZ/ESuSUX0mseFWqi5aioI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 01:11:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::7fc:79ec:6764:1a39%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 01:11:11 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Topic: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Index: AQHZ1y2a5ACVVu/RDkO3EqDs79ccMK/8MSIAgAK4t0A=
Date:   Mon, 28 Aug 2023 01:11:11 +0000
Message-ID: <AS8PR04MB8676BEC9BC60872589519BCF8CE0A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
 <eda5944e3d36d1daf25e5b8613f6f781d5fafc18.camel@toradex.com>
In-Reply-To: <eda5944e3d36d1daf25e5b8613f6f781d5fafc18.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB9236:EE_
x-ms-office365-filtering-correlation-id: 5dbb5b65-8db9-48aa-880e-08dba763ab0b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBrd0XyZuCF1sjZSfquK/S3Ji3h/Ee910rqBOuhVTC6S1/8E/qSJzG+AQTXH6iXnj6w3H65+k29C9tR50S9TXy1Ri91dKWHiBtpYjHo3DZ3KI5u7F5spt0YLDQlMgDPbP7TYxiDzq+KlP8bMBztVCaAcd6g4MTjAwJaN4FjHTOChxk6gWmrf8YQWjE6FqyE/tu1vtkX+qHQcGQmVtyrd8Uazg3LJ3F+MJhxsrbuPN+9OqN5C3HIGUfhEhyvI44r2+F1NRoVeLIrwrVjQ9oBpFDbrCoSmKlYBmXtLJ60nQdd5FSmCRkUOXnOTxszn6RFEdEi5PnkyldaCk2edcJPpvX53mh4AiWXLP0p6665sv8Rw93EUm/AR6Lk1bt9EDtlaJj6Y5tKGaADte1Z57BwI+BnhFu9vepKsyS0w3eCVH83Y6Q6FVWv1K6fAmEDwRheeY9BPjjVHJXboCKiG1jdMaDc+oqjA/zwG1jVKUTM0VbJMhky+PjSzRskPcQOdxcj1Z/dGpjVeyCLwHmnMXbGcDrAqsRV3SyloYorgZ0gNB35yLf6mw63Ii3IqmAfUVI4rHHjleJzgdJ9GWzaPX5VkXkA/L9YPWTZ474WzjVmcxnTpU5JBMPzYO0yLszXoiKAD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(9686003)(7696005)(71200400001)(6506007)(53546011)(478600001)(83380400001)(2906002)(54906003)(41300700001)(316002)(8676002)(66446008)(64756008)(66476007)(66946007)(52536014)(76116006)(66556008)(5660300002)(8936002)(4326008)(44832011)(33656002)(55016003)(38100700002)(38070700005)(86362001)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXNmdE5NcnBCOFhvZ05vYTl5dFJaMll2bFY3TkI3dVA3Mit6N00rUlBBUHV5?=
 =?utf-8?B?Z3VKOXVxT0dDZ3NwUE1kL1oxMjIwbVdQbE8wOUVuQ24yVVRjQ0huV1F3elZr?=
 =?utf-8?B?cmh1STdJdS81c3FZWjdobFJLWUllN3JxWnZvWndacEFvMzc4cU53U09Vc3Yw?=
 =?utf-8?B?enQ2d25MNE15VnNZZnZGZ1Q0S0srMU5LQ1AyaVZtblRYNEN3OUI5emV1TVEr?=
 =?utf-8?B?OGZFakJkS2NPM2xianZncTBOU3A0Tko3N25JNFUxTXZTSWhwVEZ6cXZtUXlt?=
 =?utf-8?B?anIvWkRyMXhNdXNHYmc3MDJYU2FhOFp5NGVEU3kyNmpuWVFCMFpEbE5VOUZj?=
 =?utf-8?B?S2E3Ym4veWk4eHVpejhQVi9VaGJSVVpxMEwyZ2R3RURBRjhKYTQ1YVIxcUpI?=
 =?utf-8?B?MlJ3RC9nQ1IxQVdMV21WUTVwaTFjMWcwc3VtQmhMQ3FlSUI4RVV3eXdRZ2t6?=
 =?utf-8?B?QndJMXdYOW84aGQyLzltSmw1Z2EwZFJETzJBN2RQR215QS9yQjJzcGw4bUVP?=
 =?utf-8?B?b1FZamxIMk9xTWl3K3I1SzZiUGZlKzZmczdPclNhblJJbkc0ekF3Rk1yd0Nh?=
 =?utf-8?B?NHdLVWVuWW4vMkMzZ2dpaUJPV2drNm9uMDZtUTNCbVl5ZGcxTkJtd0dOVThr?=
 =?utf-8?B?K3k4TDZvQ2J2anBBSGtscHFyWEtnQWFNZ010WDc5enNuU1kzVXJzWjNMd0pD?=
 =?utf-8?B?ZDgyNXpobVRaVUxlU3BhZ1FHVkNzSjBNNSs3U1V1WkZ3eXdSazh5V255ZTll?=
 =?utf-8?B?NFRURVhwOHkzdEI0M0JoUWxyRkxVV3VKMXZzL09wUjhUc0h2cjY5RDkxVkRn?=
 =?utf-8?B?Y3dhZ2tRdEc3cTBqbEc0ZDZTVHpFTXJib1RPTzdJUTR1WVR1cU1qdkorS0to?=
 =?utf-8?B?WU5XN2RFa0ZUUkZwSzk3RzVmWEpwT09OTUxOb0NQaWZFYXBKeXNXc2R5Ujh3?=
 =?utf-8?B?aEVyTUtIWElpdXVIY3VRdDZtd3ZZZVlXenFIS0NlWVkydXl0dEt0QWs1RjRk?=
 =?utf-8?B?RTAxODJJTVhFOGh0R0ZocThUeGUyMkVRKzlXaTJpWTdiYzQ4ZWJiRWhlSkR4?=
 =?utf-8?B?U1VhZU9veHlNOGRzc2dmcE5pcU9QVGd3T1pLN0FGN1RBYk1DbmJQZWRxVUpX?=
 =?utf-8?B?bXNDUWNaZHQ2K1ZrSGVYQXNSY2hWektrOTBLNWx3T0dDUVdsTHM1VUd5aEVs?=
 =?utf-8?B?WGlTVWIxNkFHZ0tFS1BBY1M5QWNMcVJIbTM0NUhndW1vUDBGWTdxKzcraGRr?=
 =?utf-8?B?dTZJRndFeUkxeTNwSHMvMy9qbVMvTWVrRUZaNU1yTEdvVVcwL0NpSXRvTW40?=
 =?utf-8?B?aTYraU15SjJwQmZmRC9XbzFBeHlwUU1EUFZsSjMrYlRqcW9QRXh3ZWJLT25y?=
 =?utf-8?B?cTVxSFZlc0lRZk1wYzJ0Q3UrWDF2VWw4bldZRTRCR3M4cXk3a2hyU3AwaHFI?=
 =?utf-8?B?TnpSSkFtclZET09IV1dlWklRRlN5VDFNd3orWHNTdlJZRUlqcDlKeUxQT2xw?=
 =?utf-8?B?RnpIUXh5K1J6U0R0Z2Vsb2o0enVFVnZxendxa3JkbzJQcjdLd3QvVkVjSFpx?=
 =?utf-8?B?dWR2ZE5kZzF6MlJ2YkY2bi9PRDh2S21Yc0N4N2xwZFkzUkxZTzRPaGRxcWQ0?=
 =?utf-8?B?Y0ZzRXBlZno4RGNlV0ZEcFZKZ0ZDN0lRYWtGK0NOQkZRU0kyaUY2Ry9RbDVp?=
 =?utf-8?B?a1IwR2FkaHlwdFR6cUVxYmM3enF0ay9yeXg4THZLSHVaaSs1cnFaYXZFUTlh?=
 =?utf-8?B?THozdURqeEZOTXduZWQxOWdiSGwrSVJsOVBiUjVPZjJKbnpLTk1LQzJwVE1Z?=
 =?utf-8?B?cFNMZDRHL0hpckp1Y0o4WHBUeVZNR0c4S3g2NW5aNm5kMWJpQ09nZHBieWpY?=
 =?utf-8?B?VFBhSDQwQS9NTlZoMmJOQllUcDd1U0hVWUdTbkxnRDFZV1A5Q0dYTkJlMHhx?=
 =?utf-8?B?ZlhtWlpqQWIyTllRMzlYK0FUa0x0L2hMYWZ0aGRKVGVVSTU0LytnOEpCQ2Nw?=
 =?utf-8?B?OHFmSXFmNnV5VEI4Z0w4T2JFN05zaXhucVhjenZQRUYrbE80cGZRWi94MEtI?=
 =?utf-8?B?ckdSaUFxNFhnRjEzTmNUb0RROG15V0RTd0gyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb5b65-8db9-48aa-880e-08dba763ab0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 01:11:11.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uv/LLiA6UnPfEvkN3Bn4WJ6EI4sxayWxvQ0zl8irfq0BpZKoh1MTED9kdOFxrF2qB1dcaGY8qnXrxO7ZQQkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gU2VudDogMjAyM+W5tDjmnIgyNuaXpSAxNToz
NA0KPiBUbzogcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBDbGFy
ayBXYW5nDQo+IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT47IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBzaGF3bmd1b0Br
ZXJuZWwub3JnDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0g
ZmlybXdhcmU6IGlteDogc2N1LXBkOiBBZGQgbWlzc2VkIFBDSUVBIFNBVEEwIGFuZA0KPiBTRVJE
RVMwIHBvd2VyIGRvbWFpbnMNCj4gDQo+IEhpIFJpY2hhcmQgWmh1DQo+IA0KPiBUaGFua3MhDQo+
IA0KPiBIb3cgYWJvdXQgdGhlIGRjMSBhbmQgZ3B1MSBvbmVzPw0KPiANCj4gT24gRnJpLCAyMDIz
LTA4LTI1IGF0IDE1OjQ3ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgbWlzc2Vk
IFBDSUVBLCBTQVRBMCBhbmQgU0VSREVTMCBwb3dlciBkb21haW5zIGZvciBIU0lPIFNTLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiANCj4gUmV2aWV3ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFk
ZXguY29tPg0KPiANCkhpIE1hcmNlbDoNClRoYW5rcy4NCkkganVzdCBhZGQgdGhlIEhTSU8gU1Mg
UERzLCBhbmQgdmVyaWZpZWQgd2l0aCBteSBsb2NhbCBIU0lPIHN1cHBvcnQgcGF0Y2hlcy4NClNp
bmNlIEkgY2FuJ3QgdmVyaWZ5IHRoZSBkYzEgYW5kIGdwdTEgb25lcyBub3csIHNvIEkgZGlkbid0
IGFkZCB0aGVtIHRoaXMgdGltZS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+ID4g
LS0tDQo+ID4gwqBkcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYyB8IDMgKysrDQo+ID4gwqAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUvaW14L3Nj
dS1wZC5jIGluZGV4IDg0YjY3MzQyNzA3My4uN2I4YzI2ODliNDljDQo+ID4gMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gPiArKysgYi9kcml2ZXJzL2Zp
cm13YXJlL2lteC9zY3UtcGQuYw0KPiA+IEBAIC0xNjUsNyArMTY1LDEwIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaW14X3NjX3BkX3JhbmdlDQo+ID4gaW14OHF4cF9zY3VfcGRfcmFuZ2VzW10gPSB7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgImdwdTAtcGlkIiwgSU1YX1NDX1JfR1BVXzBfUElEMCwg
NCwgdHJ1ZSwgMCB9LA0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIEhTSU8gU1MgKi8NCj4g
PiArwqDCoMKgwqDCoMKgwqB7ICJwY2llLWEiLCBJTVhfU0NfUl9QQ0lFX0EsIDEsIGZhbHNlLCAw
IH0sDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgInBjaWUtYiIsIElNWF9TQ19SX1BDSUVfQiwgMSwg
ZmFsc2UsIDAgfSwNCj4gPiArwqDCoMKgwqDCoMKgwqB7ICJzYXRhLTAiLCBJTVhfU0NfUl9TQVRB
XzAsIDEsIGZhbHNlLCAwIH0sDQo+ID4gK8KgwqDCoMKgwqDCoMKgeyAic2VyZGVzLTAiLCBJTVhf
U0NfUl9TRVJERVNfMCwgMSwgZmFsc2UsIDAgfSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAic2Vy
ZGVzLTEiLCBJTVhfU0NfUl9TRVJERVNfMSwgMSwgZmFsc2UsIDAgfSwNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgeyAiaHNpby1ncGlvIiwgSU1YX1NDX1JfSFNJT19HUElPLCAxLCBmYWxzZSwgMCB9LA0K
PiANCj4gQ2hlZXJzDQo+IA0KPiBNYXJjZWwNCg==
