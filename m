Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA30764951
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjG0Hug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjG0HuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:50:04 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9400265B3;
        Thu, 27 Jul 2023 00:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTkjkkX+rtg13ncmmz1/VBbi5cxi9CcernBHsZ1giLkgIW/Y97/ENsQxAznRtlAiHyX3Q47iYSguOqNqSdhXiHdyFniWGsfN+Q0eGwAZ8wSB9yhVVYM1SuiLpNj+WMsf65tJYPyEIHS1yHuL1VH2uXyt3C6dt5q2Qe0RaVytyzC4DUGa/LoKF4rPhRgqEoXtK8pVUkX4XYxovRNgZkCychUNV0qPkoq5uF1efZiwcVeOEOpzqvIFGSDjbOnv1vcrw/ZovlK16MqxPgEHhABS0NwnxVRlRZ59IpDT/LqgAJzDb7xVwl3Gc3js4H5w/EZPDQ1zW1rQN3eYNSD9tOTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0XORmYfMgSdzITJgKcGrMYdr3PGGfL1WwIq07a7RGo=;
 b=HG738Fqf4xewJYphjPynAa7Dp4Yy/BDZje6dJz7ci3T722N3xdUOIHd6iJcPiV+irWz++RB21B3tomNtPWna2dknUru0tpncXq9bATs91cSzE3CiZN3P601l+wAoA9UQmI+BY1zTgGrZunRRxuC21KxKo0ZPkMmNa5PODb91OQpb/ZvBDJn3TftQNzN3LQ/BJSeEDUJxHOtCLASkn8bfSQ+tG5kMTK1C2xkqImZSj3AT7IiVuggmBibgdVkIfa6PhAJBtIyCQBRbzjb+iTJ1fb+d1Stky91q6BHMNu4KfDE2ID/2w/AmKFkeNne+d2azrJnSYcByT48LGu/gnsWT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0XORmYfMgSdzITJgKcGrMYdr3PGGfL1WwIq07a7RGo=;
 b=f+uNBXPSXySvi95B/Z8r/4TWeXRWVRHlrT2bycTLsfvnY5zINEcLv4nscnUuQ2/KOpPPKK9FRUn1TrvuNrWfPYbS/awaAW9w8XHBRFAAypy32tO6C7kMTR0GJ75waO3OapHssdbOpu164yruyKIAlTJr5YOFkLDCCGAw3/TQubQ=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8392.eurprd04.prod.outlook.com (2603:10a6:102:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:43:49 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 07:43:49 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH] caam: init-clk based on caam-page0-access
Thread-Index: AQHZsvA+WWrJieH4YkOWcmdVA0ACEa++PL0AgADTpXA=
Date:   Thu, 27 Jul 2023 07:43:49 +0000
Message-ID: <DU2PR04MB863006A155869F804AB624439501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
 <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
In-Reply-To: <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PAXPR04MB8392:EE_
x-ms-office365-filtering-correlation-id: 3ae49d40-1e7a-4fd6-08cb-08db8e753791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHtHZqmIATmWjMVoUk4kjgXnylouM17qybO0RxLv836H6sIvIYTCGG3A1jy9GMkKupDAe3pplTzvGZnBRtRtaWHxmvNq/ldtGbXgBdd4K6NUtJf40mWEjpKEQOpoXCeOtc8HDpuRVIUMiiuj+ajWu1A87BTTHKf0WhBi49eXJkICK+WPs/4O68NQCcGz8F1Nn8yJnWSux5Iwa0X0fPfJoxtJfOWjM0KdSQ+hJ73TH8NLHNYbj+grw6GAH+fTzKUVZ9I/HrmEB0/Xfs/ha741vkHliY4Szh/qNP9iYfrGNHfNTypOEsa+AUHoLUQNQQHgk1yBaDDUBhTtAdtBoxd49ecyvsc0ecQnPnGYAgLuZIkgSj1GUjLJLUHuSbNa2LbYvGlhqyu5OX/qyXanYmYSMo/XD8s3NfuWMCL2mGn1BSEsJUY+3qY5DV2t5XAt92YEwuzaAYuNtXA/+m+Nwu4kt5ff95Flti2mP6s34hWqJGADTBiK+scpZZXZ4ke07WGTaGe3aT4GdCClzyNv6c7cOE4aftzwE5lJSbePzKRbDwdYtRvoOYVrd6xQbeBe8h3ou6HrNVseXAsaFZbiq8NAkAa0+iprcSDJI+ba/dBgv0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(316002)(8936002)(8676002)(52536014)(5660300002)(38070700005)(4744005)(44832011)(41300700001)(33656002)(55016003)(86362001)(7696005)(122000001)(71200400001)(110136005)(54906003)(478600001)(26005)(6506007)(53546011)(186003)(9686003)(966005)(66946007)(76116006)(66556008)(83380400001)(38100700002)(66476007)(64756008)(66446008)(4326008)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WC9YQ01rRXIxcVFmZWsvV1dsa0hoMTNjVDZaaWc5YzIxNTRuNjV5cmRBSkNu?=
 =?utf-8?B?RWc0M0V0R1hlNksrQW9GWlQ0M0p5cnNHM1BGVlJubzlvd3JROG1udlVlMG82?=
 =?utf-8?B?ajQ5dWlQOHgzbE9PZi9tZ3BVYlhzdkJkdllFa0tXUGVWaXp5aXZLOGJvS3Zt?=
 =?utf-8?B?MmJnRWJYYUoxNFhxN3VxTXFHNnRVNzliK01VeXU5TzhKZjlFUVpxTU0wTjVC?=
 =?utf-8?B?amxGMGx4VUhzNTgzR0xpVCtKalI3dDVXd2JXVHk3V2JIemREVlpTVkJHbVFh?=
 =?utf-8?B?YmRJZ3VUUWpQMkQ5NVVqNmp4YzkzMlo0cGxzc1ZlMEtnTUZhaExFRFFHd2lR?=
 =?utf-8?B?ajE2R1VQTjdUWUhvdm14Tzd6c3poVzNzQmVYeTdIelMwZjVLUk1VVnRhZVZN?=
 =?utf-8?B?WFVHdkpLaG5HMzdNRjFxVHBIcmJXNzBBMGZkSHZ4bGFZbG84Q0w5RStodnRH?=
 =?utf-8?B?Myt0MFRIb2xGanllVUw3cDRHT2prOFJPYUgxWWdtMnpiSmFqZk5rOE5YY0RH?=
 =?utf-8?B?aUZwUlExQTBOckdFMWR2OGxlUnZNekxIZFRVdkVpalQ0NllGS3F5bC9QZW5I?=
 =?utf-8?B?Q2c3SWhWVW1JRTVRck5lWmw1S01JT3lSRDJPMFdSdUt1Y3FnS0JxUXZWU1lh?=
 =?utf-8?B?MkRSWDRiVk51VXZzYkJoRmVUL09sZ3hRS3RWek9JR2pFaTI5ZjJRdk8yZ0Fk?=
 =?utf-8?B?ZjBaNmVoZlJWWnRlYlRqeHhrYm9lOVNpLy8xNkxKVXZBV25zRWQ5MnY3RnlG?=
 =?utf-8?B?SzhvZmltNVhoSExvMzZtMkdJOG12UG54SHdhRkplRC9BUzYyU2tzMjlaM2pV?=
 =?utf-8?B?LzVCTkRwWFpndzlMUlJFTGdVVnNBY2J2Z3k5WFlsVFFTNlpDbkowWitDbFpV?=
 =?utf-8?B?M1BIbTZ5MldYaVpIcVovRmpuWHlmdUJPand0LzZGTGs4NUp4cHpaVXZMTkk2?=
 =?utf-8?B?dndvNlZYcllETVpKYjdkTDZQWDlsekw4UjNHbGtGYThzUnNxemk2Wmprb2hx?=
 =?utf-8?B?SUNIUEV1d2Z5OGg5czVEbWx5VEVNYnQzWDRTWnc5b1dnNEpiTnduN1Z1R3RZ?=
 =?utf-8?B?cUtIUjBOd2M0OCt1YjhzNXI2UnhrZHVlOEhmTTducWlaeFNicjZOUkc4bW5x?=
 =?utf-8?B?RXNkVTBUQzVISGQrS1RsTlovdHk2RTV5NTUxdmlHWmdaK3YwQXloVk1ZQjRW?=
 =?utf-8?B?MmxPNTFBa2hkbGZDb0lFYlZOYStOZDFHY3RtNUd5YkQyV1FubVBFbWs5NFdH?=
 =?utf-8?B?SVkwbXA0cFVWeEpjckRLQldudUdVQVZDREhoeWlEUGhJY2JZTDRueGtXK2JH?=
 =?utf-8?B?OHpDWnF2dVJqVXI2UFljZUcrUlA3aERmYWVHRTd2MHU2RUVTR2hRTkNZalNa?=
 =?utf-8?B?aVIrbE5ZVHA2c1pwYlF0aW9sTkNxeDFPeWRtVWg0cTdFU3JmN1FzN2x5K2l6?=
 =?utf-8?B?NFNiV0taM2VRcG1QV2lSK2NrSmtDT2lvdU5rMEdRbit3cmRUVGE2WFA3cVZa?=
 =?utf-8?B?U21hV0wzZS9NKzdyRDNTM21iSGVuREVRVCtrRWxOWHZjYlNMVXNUQ0xYRUJC?=
 =?utf-8?B?OTA3SitNYkhmQzNIWUsxUmZja0hMWEFKcCsySEgwRStacTErcUtjOUkzL3RK?=
 =?utf-8?B?SHJyOU5ZYndGTmFsQk5LZlN0RnBma05tazY3VTRJTjBSZEhWYzdNUWZQcjdX?=
 =?utf-8?B?T0FYZCtHcFYxeGFrWnE3TEFRZSs0MXRsL2RFaUh3RWJLN1k2djAzK1lDTVQv?=
 =?utf-8?B?ejU0MVRmV2hqS3M4U0Y5N0Npa3hZZnp0WEtKcVhWTE0wdTc2dmFTTWhVSjZI?=
 =?utf-8?B?MTI0L0ZoUmxGc1BqK2ZmdFZjYTZiS21PRlVSWXpzaDl3VzBuUDhWYVc1N01L?=
 =?utf-8?B?SEd6OEJ1eFZMVHMxYUV2Nm85SUZ4TlpjTFlNanE2NitGS21xRmdzdTZESDgr?=
 =?utf-8?B?T3NKeGt4WHVUbkJLamQvV1lCTWZvQlY5ak1hNEZGaEFYM0diRXByNUFYMjNM?=
 =?utf-8?B?eVRkZE53dXVzZE42cmEzV1p0aGcreVcxNWNRM0FVaUNOZGZPYi81akZQOG9Y?=
 =?utf-8?B?M0xWRS9hNFJPdFJxa1MrakMvMVg5cEJ3ZWR1MWtUemJHMEhBYXVSUmJ0UGo4?=
 =?utf-8?Q?7I8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae49d40-1e7a-4fd6-08cb-08db8e753791
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 07:43:49.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mx04Ggitv5bSFN92SimfbI76rXveGMiokF0ilrbQs28MHJtL5T0gUMwsavMqDz9Dt+syzGGYSVMI8k/cT+ipnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9yaWEgR2VhbnRhIDxo
b3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDE3LCAyMDIzIDEwOjM5
IFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPjsgR2F1cmF2IEph
aW4NCj4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29t
PjsgSGVyYmVydCBYdQ0KPiA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgRGF2aWQgUyAu
IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IEl1bGlhbmEgUHJvZGFuIDxpdWxpYW5h
LnByb2RhbkBueHAuY29tPg0KPiBDYzogbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FhbTogaW5pdC1jbGsgYmFzZWQgb24gY2Fh
bS1wYWdlMC1hY2Nlc3MNCj4gDQo+IE9uIDcvMTAvMjAyMyA4OjM0IEFNLCBQYW5rYWogR3VwdGEg
d3JvdGU6DQo+ID4gQ0FBTSBjbG9jayBpbml0aWFsaXphdGlvbiB0byBiZSBkb25lIGJhc2VkIG9u
LCBzb2Mgc3BlY2lmaWMgaW5mbw0KPiA+IHN0b3JlZCBpbiBzdHJ1Y3QgY2FhbV9pbXhfZGF0YToN
Cj4gPiAtIGNhYW0tcGFnZTAtYWNjZXNzIGZsYWcNCj4gPiAtIG51bV9jbGtzDQo+ID4NCj4gQW55
IHNwZWNpZmljIHJlYXNvbiBmb3IgZGV2aWF0aW5nIGZyb20gZG93bnN0cmVhbSBpbXBsZW1lbnRh
dGlvbiAoYmFzZWQgb24NCj4gRFQpPw0KDQpJbXBsZW1lbnRpbmcgYmFzZWQgb24gRFQgd2lsbCBs
ZWFkIHRvIG11bHRpcGxlIERUIGVudHJpZXMgaW4gdGhlIHNhbWUgY29kZSBzZWN0aW9uOg0KLSBv
bmUgZW50cnkgZm9yIGlteDh1bHAoZnNsLGlteDh1bHAtZWxlKQ0KLSB0aGVuIGZvciBpbXg4ZHhs
KGZzbCxpbXgtc2N1KQ0KLSB0aGVuIGZvciBpbXg5MyAoZnNsLGlteDkzLWVsZSkNCi0gU2ltaWxh
ciBlbnRyaWVzIGZvciBmdXR1cmUgU29DIGFzIHdlbGwuDQoNCkhlbmNlLCBmb2xsb3dlZCB0aGlz
IGFwcHJvYWNoLiANCg0KPiBodHRwczovL2dpdGh1Yi5jb20vbnhwLWlteC9saW51eC1pbXgvYmxv
Yi9sZi02LjEuMS0NCj4gMS4wLjEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMjTDkxMQ0KPiAN
Cj4gVGhhbmtzLA0KPiBIb3JpYQ0KDQo=
