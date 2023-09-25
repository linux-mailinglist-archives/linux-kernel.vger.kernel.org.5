Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439C7ACDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjIYBsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIYBsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:48:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A54BD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO+xe1l39h7W7e68cK0APd1/wv0yzGkRxDd5807pd23DNhy1qAkC5pZqyn53jfXmeTWr4ElN8XJVLu9zuJRc9Lu+dlEakzzMotxEdLxrK6cJ9rI+wQxoBr/nfFdSvxUEX/s0e+mJ4wXUs6s3UpyKWWSqCC9esedWF/3sX+k2AEMOKP9NaXODLF+IgkrpIMHUqlMTYlEYPfbNpLRjdw2JKddxwuN3EczzwH82NfZceJJbaNkxMz+FKiD/r/5Pq18lzAp4aJYXD7QMXhg7tI9fkziWQ6NqTdK0AMDZi4PLiCdYeU+/6FrgyfbvXAYRgDWHJNyaxLN1i+iZg4Po50cUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSTOJgaGL2W77ioG0io8axV0Aak8/Ev0G6CADoqzGgU=;
 b=EJ2jOu4JymnkHuixNsBYiqgcNUwFcN7IZ/Qx34p4S59ZWzaNVGP9NDvfuSC3LDdGhNkRyns3myxwhOf/E1QDI+Uan+AZmVWDYND5nMdggkpMk/FVgo4jeCmp4yeq/oCDn94y7eqD3S0JugLYCVY3eifTGO9LQ+qdTReCWxOU1NqVskktkrNUw7JIAxuZPoZerHkGt9MjH3C8AEWOvFtbWZIlkkiZ8DWFsUah69/Hgev4ajVMtMLft8IO9QP9BzcYyPlZvP/I+Yymh0MOWE0st28r9/ah7mm8iS4RP5vDTXzIxVPxLqyAnZRkeIl7zsmSvUsEEC3s7ApYwHJAgqur5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSTOJgaGL2W77ioG0io8axV0Aak8/Ev0G6CADoqzGgU=;
 b=B4ofjVcCbS8Bs2jd0X1fi8hAJEk/IKfm58JOkHiG+VSWFMRCaLC4gCwKrkLyIvvrnNCdvv2b074OboN50s7MIuy7VFLAd9MqM6w/oEqipsSrXdspz/9UiZq/ZutIqEDAxSvUc7NvpKrlljPO3scmvcZDJ0NCFe8d3cei9WB0nIA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB8032.eurprd04.prod.outlook.com (2603:10a6:102:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 01:48:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::24a9:9fa7:a73a:17b2]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::24a9:9fa7:a73a:17b2%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 01:48:29 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frank Li <frank.li@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Topic: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Thread-Index: AQHZ1y2a5ACVVu/RDkO3EqDs79ccMLAqMpIAgACsXoCAABaZgA==
Date:   Mon, 25 Sep 2023 01:48:29 +0000
Message-ID: <AS8PR04MB8676E3E378C123D401C5A88D8CFCA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
 <20230924140734.GL7231@dragon>
 <CAJBJ56+mEQQroQkPGptdWokWjK2EBa3M407wXXqGg9Vg6E6cgQ@mail.gmail.com>
In-Reply-To: <CAJBJ56+mEQQroQkPGptdWokWjK2EBa3M407wXXqGg9Vg6E6cgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA4PR04MB8032:EE_
x-ms-office365-filtering-correlation-id: 68c2ac00-c8ba-4e00-c1f4-08dbbd6984b7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28MTM4sebJiV0mWRUbOdEfD40McBQwdWCER+McMdGAetazOlI5JxyUH4WJsl8tJvrbFm0GqlU9N48sy464db80uGrAxJsVG2uwOnUrA/EHa5AETFcC2tSxe1E87Nv7vM5u5OaLSf424zd+1jLCmaRUKLDEJlWVD5mpQlKgqxtBF0ZhcfmawooSrLIViYOuV+KB303wPz4yigwQ1ZsDjtwMx9hYUGr0pyyLsDPXua1MOtBJc8MGfUrZyPMKmRpKAoG0HXXGEwo/xNWqWvL4VCmxUTQiS34b1czJUrmb/xBC3Q8vTzBc0Ty3qH6H9X8CG0OXrHzPnEb1tV/Qugjn71wsYTxxd7007455ABkcf5o6Xdo0v95u6mwvTQ8lZ3RkCfSmwKqIiEAoqRThvLBqpwanxNqT8puuOP+/MTPaFItGQtLHcNL3FmoYxsu+WHDGEWgOGCEucLw2AplFeP3D8FWE6tQk4Dqfu7KJeK+J8ydogfZ1hXbKZKg7Xle0mmciXme2Z+jKeA2xlyq6J7bkSikJW0tfVDYijSiZOS4MtkY3FRQVO8RRJwp19RsKZ2Ivh4fVDpXu1TdhdWTM8fNBYAunTdcvQGRfFBFjzxwkV9Q4nRySlyRMIv6LhIo96KPvIl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(41300700001)(55016003)(8936002)(4326008)(8676002)(54906003)(66476007)(66446008)(66946007)(64756008)(66556008)(6916009)(316002)(26005)(52536014)(44832011)(76116006)(86362001)(2906002)(478600001)(122000001)(33656002)(38100700002)(38070700005)(71200400001)(83380400001)(53546011)(5660300002)(6506007)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29MMjBsL2U5aE4rSy80V0lpNHdrVHhiNzc4WGFXQyttdjFkRzF2ci9DRWJx?=
 =?utf-8?B?c3dyUmk2ZjdCUFVJeTExeXQvYUlzYStQZE5jTmtZdmhXeFJnSFE2YW5ZdkxW?=
 =?utf-8?B?UW55enhBNU1uc3pzUU13bCtvWHFhMU9vVlU3UmdiQkQvUjN6UUtWQ0JNTE4v?=
 =?utf-8?B?alQyREVvdXlrM2ZLek1QRC9sTTlZVVk5elh5KzRFRFpDcEVGVWxxVzBFREYy?=
 =?utf-8?B?eVU4WWhMOWlqbmN3aU9YaFBxaE01L3pyaVhVUm9FQktQYkNNZmsrSUwxT2Vu?=
 =?utf-8?B?NGJaaFZCWWZCTlZ3MjBBODAwSXNGSVh6WUx5N2lVYU9xNlA1VjhxZVE5Kzcy?=
 =?utf-8?B?cHBhM29rZ1EwVUdSQm9JaGp2MVN1dG5qZHdERm1JNHo5WHpQZlYxKzk4RGZz?=
 =?utf-8?B?N2RPWSt6OHNWcmkwb1ZTWTFTWlM1YzFKU2ptK3I2TENtTnV0UEdkYkR0b2k5?=
 =?utf-8?B?N0NIenF4UHhVRWpINTJ6SWtub1hZZ1VuZUN3WEtERGsxQXpxdWhGc3oxYXRi?=
 =?utf-8?B?RnNCTkJlbGV2ak9nYVRKaEZPVEJsS28xSHpMMDN4a1lkcTJ5MEttaFhtOHdT?=
 =?utf-8?B?SkQ2WHJIL3VtdjJZR0UvNnlvTVZBZjlyRVdBU1Y3NXhFUUxabDlzQU1tZFdM?=
 =?utf-8?B?MlRSaWFRZmlLdEowY0tRdXBNS2RBMnQ1cDBNc3FtUmJBWXdSTHZpTkM3cmxw?=
 =?utf-8?B?TEdlWTFuVENiVkFpTHZNOXBZSklVQUNkM3ozd2duNnBtWStWcFIzK1RRN1ZJ?=
 =?utf-8?B?Rnllc0V5eUNqWkNxaWFiUzhrUm5QYmJ6QlAyMzZJNVBNVGN1T1NCNlRodXFj?=
 =?utf-8?B?aFBMQ1BHZWV0Z05hdytscDEwMmUxVEdBbDhHdGVYRUNnZnM3NStCcnNROHo4?=
 =?utf-8?B?b3lBcFlUU1J6WmNkdGRablF5L21ObHZXUGpGSlliUFI1ZWw0eGsxdDZrMGFO?=
 =?utf-8?B?MEV0dnhJSUZQZCt4TEZUSUw3Y0huYUdjK2hTZFp6anlpWW56NWxuaXVvc2tG?=
 =?utf-8?B?cENHcFRtZG1jeXcrNnRiQ0RoMHQ1aEhMTDhsMDk3RkdoL0dPd2VqblY5UFBX?=
 =?utf-8?B?VGdnZk1EODMzdUdpZ0V5QVcwbmpYbDk4RmRJR2tDTTMvSHVwd3A0MkdFc2NR?=
 =?utf-8?B?NUxLK0EyMjlILzBmeDViQ0NEVnJKSGJjZzQyaFdNRlRzMGdaOFRyMG1pMXJo?=
 =?utf-8?B?dG1NcnlmT1I2TytGWDlWRnVuTDM0dlptRVlNMjY5SHVsZHVWMGI4RjYwTUN4?=
 =?utf-8?B?Z0k2b1BTb3dUL29WTlh5Z1g3TmdISTBJVStkVmpzaFp3TDRmVStaMGJaTjZV?=
 =?utf-8?B?UEMzR2JIUHQ0THBMQy92eDQwZW5xcjFGN0J4Rld0MGRqdStKOUphREUxbXEx?=
 =?utf-8?B?Y1crYk9WUTN6MDhmeC9VTkZTSEdSWHFPSG1GQUhzdThiZ3BkRUliNUExRERT?=
 =?utf-8?B?V0cvQW9pYThuNXZaVTRQbFBLd3FteENSeXNvS1Bqc1N3azhTVnZxc1VyN1VL?=
 =?utf-8?B?QW8yWWZxV01VeWFMVjhOWjN0UjFGcU1iaktCNEVzcTVSNk1tekhLdndVeXRn?=
 =?utf-8?B?Nmd5eDNLazFGclNrNjJYdzFvQU9Bcm1ucENhUVE1NUs4OXAxNVR0a2NNVExy?=
 =?utf-8?B?OVI5djNuYU1NSEg3aUFiRUlpSGZoUVVFSGtpaVliYms0c1REa2JyelVjTmwy?=
 =?utf-8?B?eFNsUjVtS29vblZ4aXZvMmN1OUxXQzRFbXV3cStIaE5LMHhaQVRwaWVPQmpa?=
 =?utf-8?B?SXB3STEvTi9NRC8vWGVQeXVkN2tEbzlNTk5VUWdwbEVDSnpVQXBoU2dFZVlv?=
 =?utf-8?B?Wkk1QXFvNTNXbG5Ebk5VMkt1VlZsNnh6d3h0OW5PMFdJNjBhYTZWdGIwdGUw?=
 =?utf-8?B?aGl3eW9tY29seXg4YVF5NHQrK1Uybm5EUjJvUzZ1b2sxYzRyMXA5WU5LZTBM?=
 =?utf-8?B?eTJBTENaWm9LSEVNcjdSRWVBa1FJTzVZSlhacEtOcWRNNHMxVWZRT0RqcFJL?=
 =?utf-8?B?YVJCRmU3RUR3bjloVkNMbWhNbjU5bmRMNUxUeWl2VU9SZzlKc01lT1FOS1VI?=
 =?utf-8?B?azdNeGhNN3BSWWJLQWp4UmE1VEJDdW1JWXc3b2hvQWRaNkZzdHpRUE01OGNC?=
 =?utf-8?Q?LFooNUzIKRrtFcjBglZL4AfOj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c2ac00-c8ba-4e00-c1f4-08dbbd6984b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 01:48:29.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC5xeOKDPHwOVkjkAZVoIIS6UX6XVeVggBJlzmX9PLqLizxErr5x2xO2CrT/oJVLU3AdxWOg8DYvVcMWXU9d0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd246DQpTb3JyeSB0byByZXBseSBsYXRlLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gU2VudDog
MjAyM+W5tDnmnIgyNeaXpSA4OjI0DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KPiBDYzogcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29t
OyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47IEZyYW5r
IExpIDxmcmFuay5saUBueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAu
Y29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0K
PiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGZpcm13YXJl
OiBpbXg6IHNjdS1wZDogQWRkIG1pc3NlZCBQQ0lFQSBTQVRBMCBhbmQNCj4gU0VSREVTMCBwb3dl
ciBkb21haW5zDQo+IA0KPiBPbiBTdW4sIFNlcCAyNCwgMjAyMyBhdCAxMDowN+KAr1BNIFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIEF1ZyAy
NSwgMjAyMyBhdCAwMzo0NzoxNVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+IEFk
ZCBtaXNzZWQgUENJRUEsIFNBVEEwIGFuZCBTRVJERVMwIHBvd2VyIGRvbWFpbnMgZm9yIEhTSU8g
U1MuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+DQo+ID4gSXQgZG9lc24ndCBhcHBseSB0byB2Ni42LXJjLiAgQ291bGQg
eW91IHJlYmFzZT8NCj4gDQo+IFRvIGJlIGNsZWFyLCBteSBicmFuY2ggaXMgYnVpbHQgb24gdjYu
Ni1yYzEsIHNvIHBsZWFzZSByZWJhc2UgYWdhaW5zdCB0aGF0LCB0aGFua3MhDQoNClRoZXNlIGNo
YW5nZXMgaGFkIGJlZW4gbWVyZ2VkIGJ5IHRoZSBmb2xsb3dpbmcgY29tbWl0IGlzc3VlZCBieSBG
YW4gcGVuZyBpbg0KIGFub3RoZXIgdG9waWMuDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guDQoN
CmNvbW1pdCBhNjdkNzgwNzIwZmY0MDY5NDNkNTYyODZiYzA2YWE2MGMyYjU5ZDNhDQpBdXRob3I6
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KRGF0ZTogICBNb24gQXVnIDE0IDE4OjQxOjIy
IDIwMjMgKzA4MDANCg0KICAgIGdlbnBkOiBpbXg6IHNjdS1wZDogYWRkIG1vcmUgUERzDQoNCiAg
ICBBZGQgbW9yZSBQRHMgZm9yIGkuTVg4UU0gYW5kIGkuTVg4RFhMLCBpbmNsdWRpbmcNCiAgICBk
bWEtY2gsIGVzYWksIGdwdTEsIHYyeC1tdSwgc2Vjby1tdSwgaGRtaSwgaW1nIGFuZCBldGMuDQoN
CiAgICBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ2VucGQvaW14L3NjdS1wZC5jIGIvZHJpdmVycy9nZW5wZC9pbXgvc2N1
LXBkLmMNCmluZGV4IDVhMjhmNWFmNTkyYS4uMDg1ODNhMTBhYzYyIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9nZW5wZC9pbXgvc2N1LXBkLmMNCisrKyBiL2RyaXZlcnMvZ2VucGQvaW14L3NjdS1wZC5j
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gU2hhd24NCg==
