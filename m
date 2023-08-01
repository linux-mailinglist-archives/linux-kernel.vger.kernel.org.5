Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7676B1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHAK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjHAK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:26:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C251702;
        Tue,  1 Aug 2023 03:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc2f+OTV+6BLO7MvkeimJBMb3a0aItkBXQSKTHxtU4qd/C0rKCZtV/KLtBu0geFJ5gKCsUDxcirXy5gz5z5EWDek7dWXA/QN+L01VO4hFnbNAeA2jv3o+RL/Mf0u4a9XL6yIzaJlqXoq5YmriH+B0iV0VuUoUdAWjGt8iJTA84eN0Yw9NnjNQf2VBJnrgrxvFQ/KDSGLTV10lhUMKK+4fgGsPcAq8+EDum7QUc4jtgBAzCArGwzD5H1SnZMpdzjzaLX8GzazPkF2U1s0sDpImtkr3LjEyTi43OfKZsOfOfh57E4YV1z0eAJv1/ZddDd5MUGiqJdca8Yvr+crTRepdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxQ4gG+2Tnh/zg54ci3gB6/J7CPI2K85OLcOjrGELyg=;
 b=GX/SNUUNpDC2dvgMl2pHLbPuwO7ec5/2qwy8VHIOfVW9aqEBcGDaNgstgkkzMz1Gn9mTxrPxEOcmbkrXa64zadpKn6i41knE9mhADFZ+R+EyVZfTtoJW0Bn4ywGW0ODBugCQsHVLJnhYbPJ1OZY5zn2n/99ReZOylpmyxDuDxXREZnLcjxF7Hc2V9d9LhMt3qT2UpojnFtJM3pZdPjKcUGdpqV+RHZf0UngDtkjE11xKo26dlJW5axEppG3USxqB0UPZpWkEc4aMhGe4qwWKS5ym3YeLoUVJoNAX3WGZNfhMF3AXv+Evh/0YhgeDUsHXwClHlLSWhXSfeDXFx888GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxQ4gG+2Tnh/zg54ci3gB6/J7CPI2K85OLcOjrGELyg=;
 b=DHqiT+4BkmX1b2Cobojq2Hmjq+vJSV3m76XftUbzJWwmpP49M8KfmLTqfTsqWSocAPBpXoomHxb0ZCawordMsP13mLbaKAMqgjjjKNOTTjK3004bYf3oBegR+waVjIQmXnAYhSGd6RG+JF3lbPR2UQ0rwI9Uc53TyYiFddL7om4=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DBBPR04MB7770.eurprd04.prod.outlook.com (2603:10a6:10:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 10:17:02 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::8023:8aa8:aa19:cf90]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::8023:8aa8:aa19:cf90%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 10:17:02 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Thread-Topic: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a
 support
Thread-Index: AQHZk4ySo5z9jvXatUK9E0ukC4423a90QK2AgDU7d7CAAeGJgIABJGgAgBG9U4CAFz+qUA==
Date:   Tue, 1 Aug 2023 10:17:02 +0000
Message-ID: <AM6PR04MB59259B4B336E630060CD8B0DE10AA@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <3505527.iIbC2pHGDl@steina-w>
 <VI1PR04MB5936370C11D1523558437D9BE12FA@VI1PR04MB5936.eurprd04.prod.outlook.com>
 <4630917.iIbC2pHGDl@steina-w>
 <AM6PR04MB5925D0B730978A949D48E25BE13BA@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <2c1dabb7-f1fd-478c-a249-994c450eb758@sirena.org.uk>
In-Reply-To: <2c1dabb7-f1fd-478c-a249-994c450eb758@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|DBBPR04MB7770:EE_
x-ms-office365-filtering-correlation-id: 836442be-c192-4795-2265-08db927872b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4FV5qyen2W7o1sOW5a3xrVmrYbxbtoeLtxrLDTTt0ir41gfHGbe1RBQpm3Whk+5e4Ekdx1nQsaXOsyMf4Wgqtf9388/IOKWVat0YW54+at6G9dr/FSBxSRD/h2ENwUkkfsOfWpYMftPn2WlMaY+G1VKdx7M4UI0Dr8h04xJIRgqhsRPhBy89hv+2J24X7l8Y0eZYeSWvRxSdNRNtQFOTXa1iDRxgNCophAkmzORxapefeUnLihp7/vXqpophjkpjitBHCxd3tp3rz0Pz0k0T4BmLPWh6ZXQEiz1e3YFzJx1+i6ljIWuDncbaPT3ZtRRYRDkX5bOAuprvTYGTal5ORkT/TrpiIvdaWPt5JdCc9rJXAwRfOeqIWlfY4/aVUDqw0YI6iJzyu6cDrasUbUrSD+Zoma4W2crMDDea3Yd8RBTbFJwieQ2hDYg4LFDBDhUMFic6jvuJzjQ2ME7emZOZd19me1gSq6rGX5kSnAf4gGcmeXpcO03/q7qHlYprWzz9qEG2VyWRU5Wh39LhLv5GEM/2cawaOz/cB09udzMLxf90RfWv9InwE/o+ZgYSKGyWKgkwj/W2gxDsxAt82od2tP3irN7g3G8Rr28qNnXPa7Ur/7yo3d/55bI/XQPatwB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(86362001)(66476007)(316002)(8936002)(6916009)(8676002)(66446008)(64756008)(4326008)(5660300002)(41300700001)(7416002)(122000001)(54906003)(38100700002)(33656002)(66556008)(52536014)(66946007)(76116006)(38070700005)(478600001)(2906002)(71200400001)(44832011)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SUFGT1o4R3pBWDhFZ2x4YzMvT3JGSXNYUHNKNEJzZ0VVellNYlpMc28xU25X?=
 =?gb2312?B?UVREd3JlRmN5cTJIWkZnNG16Tlc0MTZGWDJMcnVzNGkreDFpVEZVS1dJNXU5?=
 =?gb2312?B?dzVXd2NhNldpRWV2UU5oS1Ura21CTkZmRmJvRzh2UDRPeXBJcnc5UTZaZ1N6?=
 =?gb2312?B?MGJFbVNlVDNwV3lpeDlRNzdUanVkSXNIRjBkenBRZzdSYUFRY1FqWVY0Vzli?=
 =?gb2312?B?RU1Mdm9Ld0lDUFdoM08zbmQyVnpOenBIbWppbFZKcXJlM2pKZHM3Z3Y3LzB3?=
 =?gb2312?B?bTd4RVFGZi9Eajd4VTliKzlQSytxZmZ2eDlHbzlYd3MxT1BDYjBzVnNKb2t5?=
 =?gb2312?B?WS9GSkRUbWF0ckNpRVNCQUJVN0VCRzVIMGNxVGI0dmJpbnJRZnRRZE9PYXZU?=
 =?gb2312?B?Tm03eXI1bW9lOTdBSHlodWJ6am4yRmJDbGZRZmQraGY5VWxxZkdlQkVjdmoz?=
 =?gb2312?B?VkhDN3lWSk5McjFWclpweng3dkxWa2dzQURSMUlHUnZsTWM4MUkvWXRTdUxm?=
 =?gb2312?B?V0NoQ1d5bGduM3A4WWU5anU1blA5bEpoRWRVSHZRaVNlNUJONTFtajBsd2ZX?=
 =?gb2312?B?QnpMWms0TUNUUisvaEZkWTAwdzdpV05VeU1RNXV1NlE4ckwxVGlmdEE2QWE1?=
 =?gb2312?B?cldFM1NOSXJVSGhqKzJ6ZVo1aWEvRGlaSDUzTWp6WGJtOE5PRXN0QTQ2NldP?=
 =?gb2312?B?V0ZyRFIwZUdvRjdyZXJGNGhDRmNIRUozTU0zaERQb1ZBM3VkU2N2Y0h4ajJI?=
 =?gb2312?B?K2NaSEVQUmpKS3VrQ0J4WGlaU2lQT0FQOWpHdzFoalRsK0dmdHk2T1UvZWUz?=
 =?gb2312?B?ajF5R2FEV0QyLysrcFpGQjJzU3hGU2NGMnhoQ3ZtTTFzemV0YlljbTkwMzZV?=
 =?gb2312?B?SWtUUEFSbjc0a2drMitoWEtZNWxTNVMvekEvaFVOSjRuZ3VhRHRpUjVkR0U0?=
 =?gb2312?B?cUNDenp4STZJdm5xc0VyVUxMRmd0Zmk0b3FkZEZJTHNMRjRqcEw3RUgwUFZU?=
 =?gb2312?B?V2xFQnVQRS8rVE1rNXp1SzJ6R2VFbUxMT1B1VXIvMXdDckpiUThKWnowVWFN?=
 =?gb2312?B?b2tsT2lya3p3b3UybkFWOXJmV0JyNWhLNnBZM3ZHc2lONDh3clJtOStFd2ty?=
 =?gb2312?B?cWJoa2VnQlpZZVVZYVo5dnd4Wk9mUFJ3Wm1CcWtMWXN1dmFWYVFRTFNoR2ZT?=
 =?gb2312?B?K0Rkd2FiR2ZkYjMydHBBaDN6N21DdkR6Tmc4QkI0NlR2OVU4ZlR6a0dkL0dS?=
 =?gb2312?B?NVU1a2s1ZTRqOWRCeTJYd1RpRW5xMVUyaTRIclNiTEI2R2MzaVFGSlZQZHla?=
 =?gb2312?B?Qjk3L253V1NXZ2RYZVVyZWdiTTBxd1U2L1gxTk0vL05MM29UYlVCSlFiVi9E?=
 =?gb2312?B?UFlsT3duclBlaVFHVEE0QmVhUW90aUJKalRqNW85aytWbVA4dUZqdkFvSEFP?=
 =?gb2312?B?VkNyM3dULzVEa0RKQkNpZ1J5RG1ITmhUWGk4Y0JtanZ1aHlSNWFSU2ZQaEs0?=
 =?gb2312?B?L3NmdkpydXp3OEhTdE1Rb29QNm1VT0R0Nkl5cHhHSzFwKy9qcDVFN1dxL1dw?=
 =?gb2312?B?Yk80bjJTUXJFV2svdXpLUGlPQU5QT05scnhtVnZKWXR4MWxaQTFBTVpMVnFs?=
 =?gb2312?B?a1NobnNjVkZLbXVWcFh4bnB5R25tbEFPeFBUa1oyWnVKZU5UMXc2Z1RJczlR?=
 =?gb2312?B?VnoyVy9PYnFXU3RUeUlPU0dIMmRnVndJVitiZDVhUDRNS2J0UE4xZ21LTUtG?=
 =?gb2312?B?VXo3RTd2OTcyUVNxbW11NlB1VlpCTnVmREt4d2hKRjNFa1I3V25XUytLQzV2?=
 =?gb2312?B?ZlRob2xRaFh1Mkl5emNLWWFCdW1ndEVkUFVQQ0ZtMEk4alRiS0tGRVJ3QlNK?=
 =?gb2312?B?RUFXSkt1dFptdWtzaFQ0S1l2ZWoxOXIwOVpDeEpxYVh1dzBXYTU4S1d3U0xF?=
 =?gb2312?B?U1ZmdTU0NjNCTmlZY2UxcXRHRURFM0x5S25wOWwxZEZoK3RuRnQyNUVNT1hh?=
 =?gb2312?B?Vm5DK1htOUZGVGRqUlE1b0hnVTlJMnBncXBaN1hISWR3dGY4MEcvN0M4TGNW?=
 =?gb2312?B?Z296ZGFnZml5QVcvMTJJdlNpSmY4ekNndjhEVm5qekYxOUo2RTNsUHVDR3My?=
 =?gb2312?Q?ZlHM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836442be-c192-4795-2265-08db927872b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 10:17:02.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgYFThGK2OLXdF59IHF+zINtpQWY5DvsKmI2fQ/2a56+SBKNk2LwbFw3DiHRp08y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqN9TCMTfI1SAyMTozMw0KPiBUbzogSm95IFpv
dSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3Rl
aW5AZXcudHEtZ3JvdXAuY29tPjsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAuY29tPjsgbGdp
cmR3b29kQGdtYWlsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W0VYVF0gUmU6IFtQQVRDSCB2MSAyLzNdIHJlZ3VsYXRvcjogcGNhOTQ1MDogYWRkIHBjYTk0NTFh
DQo+IHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDA5OjUzOjE1QU0gKzAw
MDAsIEpveSBab3Ugd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91
cC5jb20+DQo+ID4gPiBTZW50OiAyMDIzxOo31MI1yNUgMjE6MTMNCj4gPiA+IFRvOiBKYWNreSBC
YWkgPHBpbmcuYmFpQG54cC5jb20+OyBsZ2lyZHdvb2RAZ21haWwuY29tOw0KPiA+ID4gYnJvb25p
ZUBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4gPiBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7DQo+ID4gPiBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gPiBD
Yzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlt
eA0KPiA+ID4gPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEgMi8z
XSByZWd1bGF0b3I6IHBjYTk0NTA6IGFkZCBwY2E5NDUxYQ0KPiA+ID4gc3VwcG9ydA0KPiANCj4g
UGxlYXNlIGRlbGV0ZSB1bm5lZWRlZCBjb250ZXh0IGZyb20gbWFpbHMgd2hlbiByZXBseWluZy4g
IERvaW5nIHRoaXMgbWFrZXMNCj4gaXQgbXVjaCBlYXNpZXIgdG8gZmluZCB5b3VyIHJlcGx5IGlu
IHRoZSBtZXNzYWdlLCBoZWxwaW5nIGVuc3VyZSBpdCB3b24ndCBiZQ0KPiBtaXNzZWQgYnkgcGVv
cGxlIHNjcm9sbGluZyB0aHJvdWdoIHRoZSBpcnJlbGV2YW50IHF1b3RlZCBtYXRlcmlhbC4NClRo
YW5rcyB5b3VyIGtpbmQgcmVtaW5kZXIuDQpJIGhhdmUgZGVsZXRlZCB1bm5lZWRlZCBjb250ZXh0
IGFuZCByZXBseSBhZ2Fpbi4gSXQgY2FuIGJlIG1vcmUgY2xlYXJlci4gDQpCUg0KSm95IFpvdQ0K
