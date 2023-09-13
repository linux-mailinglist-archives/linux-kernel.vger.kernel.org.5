Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38479E29E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjIMIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjIMIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:51:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F80196;
        Wed, 13 Sep 2023 01:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThcEJ+GOMH9209MTA82veABKi2onquL0ie7hlv18XUy4zGEJZCJg2y1DnR33C/Lf9XGFyyP6k7kDO8nJUDm6kIbT3e6YV+EBwXhIaV2t3kSsKrCuLpC1mUw3xA0QHkA9nAtxiG14nG8dqLN/6VFHR2xT33+XSDenVj7cR0ESyPvKRwx/bevxENsOSLVKntKdw6b5ZmZEgTDj2s3qyEYv3IpAgiTN1kGwlt1qEHKNmjTYa5+TQZBJEQMKRnb4zOrApUGoVqcZUkyCZ0+K7PWApxmqgWxof7jYMUSz6aYFve7EJUqyIVj5+pIpbo32ZjWbc35WilCSg5zd5xEohaYK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc+GZ4U40PrEyiljHLaQGpoafJyu8xzyNOvXlSt97N0=;
 b=hqSIGPsuggiVB7Ej4wzrI8VwXxrRzU7NuTQ4fKJ6/nsa7L/em1TXOWsnigCxoWLkgl5P3TTF/3bvcSlQ99QhyOe23z7bWipisZtkpij475EgoOtfy83IAemQYYVeNcZYUiVqxK/y+cVnwNr5I+rMyVMBjShToVUVWQvH59HPOUsEIsr+FAajWqz89Wpn4pv4dkeoxH/S7pxIJR/zSLRiXgriodyR29jTwalMuCEa/1zi383B0vmww/soqfUDOIZFG2P28DsUw2r03L7jr7FH8WzUjD00De1RfgYQgBDzBh4Y7XtTVSd9pPFQBSuO60IJsWps0kg3TqLNeOBLBx3qCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc+GZ4U40PrEyiljHLaQGpoafJyu8xzyNOvXlSt97N0=;
 b=yUyrMWQK06GvOkF5S+XgfI/Wxa/4VoYxGDKlX+Kv/22dnKKwsJQ2dKDD1lOJMoSqh6IfTNTzYRiMPCF6MwyKeReNb4o5Tk1iAoQv1VEe4OK5K/4V9isNlp7aJ2WuIKhTPpYQym5EVM640dRWVo5NPt1BjEmSNNeRv+hTf/4CMRH5CWytA6v64wWTOyp265UQq2dqwzdpsUH4nIi4DuERHOXJR0/UGseZslQZyUASlv0RMePP1dPzprrJadWPC8Jx7k8zh4SpAnrJF9kQdFU4d/RPAdRh6fFIvM1Q4Ed2ovP3bW+tvGyb0KmFs1vB5U9Fk8DrA/hfBVj5/LxS8sgA7g==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYSPR04MB7082.apcprd04.prod.outlook.com (2603:1096:400:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 08:51:14 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 08:51:14 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hwmon: max31790: support to config PWM as TACH
Thread-Topic: [PATCH] hwmon: max31790: support to config PWM as TACH
Thread-Index: AQHZ4J74hgtrGBuSsE+/2qt904rcN7AN+tyAgAp5vZA=
Date:   Wed, 13 Sep 2023 08:51:14 +0000
Message-ID: <TYZPR04MB58533E15AA65FCDA0F603FA3D6F0A@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
 <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
 <8a3b41a2-0ab2-6213-04a1-54ab7263c647@roeck-us.net>
In-Reply-To: <8a3b41a2-0ab2-6213-04a1-54ab7263c647@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYSPR04MB7082:EE_
x-ms-office365-filtering-correlation-id: b2a9992b-ed9a-4416-4823-08dbb4369615
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NnN2+8RsJlP+Kt89TwFot1RajHuFp0TBCYTS31OrvY0rBFiOOueBS7UMMMp32n0EOjoYOysuBEl45skD9DIz7cZenJG73jNX9FmIZ/5vOQX2OwIT9mvlnJ3E4ymGrHjRkDTbNB7Th298JRjhRIxrfSG8okfEPIfUMHpNaO63Z6LYNOBdgfbKb9MLwCZ3IV0STFHvBPB6gOWQ6e+GIvcN8eT4H7B5mNti4Wi/3WU7OSphlZm+Y4UxYdZfpyQAIXhNe5w/c/b8lKeCBuNk09GPMPAAHlwWZB2xhhDz+UvJ0LHaVXHYuA/AKpS2HKf+Z6BBDfuZN81D5I+tsMzPaMmzqOc6XLl2p+/+zOE3Y2HktjWFEzREU9ybWmUSpbL/yePY3sH01sfTB2X56SRGgHZKAoPPCrucPfU906GYiufj05lM7JZKQLBladVan95uTxKm8Blf46zc4L9WW5rmJtEj2KuCymR4EOhldYJF73fPt3cgsVRFGvdf+O1bUJUB22ng1NbHwPIag9q/3QIW3zfnJEzFEFCYxaI48sqh7TU1p3e/+nUQWB8I9OYuCvOMDvrWZgrAofeJtjzFaqNcaTKNdIDDXizhRigL2sEN5X5BWAadY2yp8MNjFP4mEGf4bF0n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(71200400001)(6506007)(53546011)(7696005)(122000001)(33656002)(86362001)(38100700002)(38070700005)(55016003)(26005)(2906002)(9686003)(478600001)(83380400001)(316002)(5660300002)(52536014)(4326008)(110136005)(76116006)(8676002)(41300700001)(8936002)(64756008)(66556008)(66446008)(66946007)(54906003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlpBay9TSk1oNktSMXRwWTNHLzZqbVNlQTFrdVlBYzBlUDdpVnhCMHlONGFK?=
 =?utf-8?B?TVp4VSt0NkZWNjl2WXJBYVAzVmtYTm50Z3FIaFptTmF2MFVwOFEwSHNCa0Rp?=
 =?utf-8?B?eDUwRm9hbWVGa1AzbWdlVzhsQkppL1praVF4bFBWcldqVnlqUkNJazRZVk5t?=
 =?utf-8?B?U0JlWnNPOWc5Uk1ha0dPQTlGQy9qcFhtRmtPVjRyV2Q1b1c2SElCNlZZRmtm?=
 =?utf-8?B?ZVVhdWhublROREtORzZHQXZWNGdTbEtFeFEzZEV6d2dEc3k4R1pDUllGVnMy?=
 =?utf-8?B?NjltWngxaHFHbGtiUnIxV3UrY3orWGFwbjBSSWhMdDcvSGZ3NjgyOHd5SUdt?=
 =?utf-8?B?eGJLc0dQZkFzb3hiOUZPQjU3NjlqWUp5YkkwUHpadU04dkNVODlNcEFSRzVU?=
 =?utf-8?B?bm1ZdHF0amNEQ3lObVBJcm12VTJOM1J6cG5xTzlSUWFOVERyM0dXUWt0NHVU?=
 =?utf-8?B?T1VJTGFBbHg0bU9BVjNhSHVOZXREck9MUVdyN0RFUVNKd1ZjNVpTTk5iazBZ?=
 =?utf-8?B?YlcvTGtiTnRFMDBPN3JHb2U1L0owT0hWMWlnZm1Lbk9ETlVTSVpXTmVuVXU2?=
 =?utf-8?B?YUg5ZlFJbGFjbmFMSGVxWm9CK1BBODZWRmhJY28zKzZuSGlkUk1HUU5hQTQr?=
 =?utf-8?B?VC9OQ29lblU4N0t1R1pDL2p5SHJzVWpMWk1NczAweHkrbENFVFJzMVpta0JJ?=
 =?utf-8?B?bGZ6K2VGSXN3UjdxY2ZzTlVCOUtuaEZ2K1VDZDBRaG1McjZEUVdiL2J5MWd2?=
 =?utf-8?B?d0QwVFd5cTR2NGMzdFB2RFlsNGdKL2p3bktWcnRyanQwaUkwQStKZjlOelBt?=
 =?utf-8?B?YU1IRnRsM2p6OXV5dDBqQnl6UWNCQjNKWUg0RFpwQzJud0hDTjQvNzJVekFR?=
 =?utf-8?B?MlRPSE5sN0hDRjhIVE5iNnVVMkpQS3JYSTNBZlp2WnViYzBRZVEyeXhzTEFN?=
 =?utf-8?B?ZnVXUVIwSFJpS3NwVUVzSURucmVmS0t1N2VBdkl3WkxYaEFMcXFqZ0JUUWhW?=
 =?utf-8?B?VWE4VmdzbldXeHBrUGEvM2JKbGV5dHdqa2p6OVhPeW1qZ2JudEZnMnA4WjIz?=
 =?utf-8?B?UE5GbnJ5TGtTRWg3VXpGa3lFVTN0c2k5b1R3ZHpWOTlwUjIrbnVJZytneC9y?=
 =?utf-8?B?bUV3UVpOd1UzcDU2OEhTeDZ6eDhvVXl5eWV1Y3U3TFhqRC9udTc1R1o1LzMy?=
 =?utf-8?B?c3RHMVhMMzB5cEFXZEF4WlJKek0yV3UwSElMc0RGd2Y4YmZ2amZITnVmUmZp?=
 =?utf-8?B?L0YxN0o2bm1MY1B6YjFWS05MK09oRGhET3NJQUJkeG9nL09FbjhqcmdXRVFV?=
 =?utf-8?B?SDdKNXhWb2liNmg4Smt6NU5pRTk0MkhsUGhtREtuRzJIanJCTEtUaGk3YU93?=
 =?utf-8?B?MUFVYkx0bDVuNVdQUzYvVy9EMUY0Y3NYOVpDcEJqdk9JSHNCcG9rMU43RWpT?=
 =?utf-8?B?VUFMMDB4OXgxczZzbi9FZ1A4VGI4UVlPbFZFVSt1Um9KWDNybmgydHRZNUtY?=
 =?utf-8?B?SDY2MWRaanVXYUtvUktFTmdwUVNFSVVuMnJhdmFMMmZId1N3NEpKRUVYd1J5?=
 =?utf-8?B?clhrOU10d3BNYlkvT2dOQmFINDdVSTZJdnNkT3Q1akhsMzdmTkwrZ2d0WnNG?=
 =?utf-8?B?M3lGSWdyU2dkTU04QS9kZ2x2WEFkNzdoMjc3MDFBYWxPcmZGVEJuL1BrbFhK?=
 =?utf-8?B?NmwwOTJWbS9VQUk1Qm5LLzlMYjNPOXpDMDRVK3dHZ3BqTXZBU0hBK3ZvMzQz?=
 =?utf-8?B?MnVKQjMzWGJxenlwbUdUeGkxZFE1dEVpb09OQU83cm90T0t6cmg0U0k4bEt2?=
 =?utf-8?B?OHJmRjVBT1RFcytCQ0JCbCt2dDlwK1oxYUZ1L21KTzNzaEFDT0xzYnlBbXRv?=
 =?utf-8?B?VlY0MUR0NW9uYU85OWVjMHloV0pnbi9LMUJodkhrOUU3VUhPTmh6azhNUG51?=
 =?utf-8?B?L3VVNkpyWnBTRkdYTUQ1S2w2RmJ0MlZodlNZdlpHa1MzRUZFa0grVFd3djZq?=
 =?utf-8?B?eG0xbXEzQnRiaGZqZGlLeDdQdUJObGQvdkJsRTVkRTNCV2dDYis3NkFOQkZ5?=
 =?utf-8?B?MVZuUWd4Yks3MlliYVAzb1Y3THAwbTZ0WFRHbW5RNXJUQTcxQldnRGFXZzZS?=
 =?utf-8?Q?ZmkmVgnqtUDSQWe95oF9ikxp6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a9992b-ed9a-4416-4823-08dbb4369615
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 08:51:14.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIOnlkoDrgcBujBsQHWxvPhAujzqXmlDj4k5+HgBcBx9pWbU/pp39yOiD8PLiy/Zdf6+E6Uy0aPVa5AFAvLqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFRo
dXJzZGF5LCBTZXB0ZW1iZXIgNywgMjAyMyAxMjoyMCBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hp
dS9XWUhRL1dpd3lubiA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0Bz
dHdjeC54eXo7IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+DQo+IENjOiBsaW51eC1o
d21vbkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gaHdtb246IG1heDMxNzkwOiBzdXBwb3J0IHRvIGNvbmZpZyBQV00g
YXMgVEFDSA0KPiANCj4gICBTZWN1cml0eSBSZW1pbmRlcjogUGxlYXNlIGJlIGF3YXJlIHRoYXQg
dGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsDQo+IHNlbmRlci4NCj4gDQo+IE9uIDkv
Ni8yMyAwMTo0OCwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBUaGUgUFdNIG91dHB1dHMg
b2YgbWF4MzE3OTAgY291bGQgYmUgdXNlZCBhcyB0YWNob21ldGVyIGlucHV0cyBieQ0KPiA+IHNl
dHRpbmcgdGhlIGZhbiBjb25maWd1cmF0aW9uIHJlZ2lzdGVyLCBidXQgdGhlIGRyaXZlciBkb2Vz
bid0IHN1cHBvcnQNCj4gPiB0byBjb25maWcgdGhlIFBXTSBvdXRwdXRzIGFzIHRhY2hvbWV0ZXIg
aW5wdXRzIGN1cnJlbnRseS4NCj4gPg0KPiA+IEFkZCBhIGZ1bmN0aW9uIHRvIGdldCBwcm9wZXJ0
aWVzIG9mIHRoZSBzZXR0aW5nIG9mIG1heDMxNzkwIHRvIGNvbmZpZw0KPiA+IFBXTSBvdXRwdXRz
IGFzIHRhY2hvbWV0ZXIgaW5wdXRzIGJlZm9yZSBpbml0aWFsaXppbmcgbWF4MzE3OTAuDQo+ID4g
Rm9yIGV4YW1wbGU6IHNldCBgcHdtLWFzLXRhY2ggPSAvYml0cy8gOCA8MiA1PmAgaW4gRFRTIGZv
ciBtYXgzMTc5MA0KPiA+IGFuZCB0aGUgZHJpdmVyIHdpbGwgY29uZmlnIFBXTU9VVDIgYW5kIFBX
TU9VVDUgYXMgVEFDSDggYW5kDQo+IFRBQ0gxMS4NCj4gPg0KPiANCj4gRGV2aWNldHJlZSBwcm9w
ZXJ0aWVzIGhhdmUgdG8gYmUgZG9jdW1lbnRlZCBpbiBhIHByb3BlcnR5IGZpbGUgYW5kIGhhdmUg
dG8NCj4gYmUgYXBwcm92ZWQgYnkgYSBkZXZpY2V0cmVlIG1haW50YWluZXIuDQo+IA0KPiBQZXJz
b25hbGx5IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcHJvcGVyIHdheSBvZiBjb25maWd1cmlu
ZyB0aGlzLCBidXQgSSdsbCBsZXQNCj4gZGV2aWNldHJlZSBtYWludGFpbmVycyBkZWNpZGUuDQo+
IA0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KV2Ugd2lsbCBhZGQgZG9jdW1lbnQgb2YgbWF4MzE3
OTAgaW4gdjIgcGF0Y2guDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWxwaGluZSBDQyBDaGl1IDxE
ZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2h3bW9u
L21heDMxNzkwLmMgfCA1MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vbWF4MzE3OTAuYyBiL2RyaXZlcnMvaHdtb24vbWF4MzE3
OTAuYw0KPiBpbmRleA0KPiA+IDBjZDQ0YzFlOTk4YS4uMGY4ZmU5MTE1MzliIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvaHdtb24vbWF4MzE3OTAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHdtb24v
bWF4MzE3OTAuYw0KPiA+IEBAIC00ODAsNiArNDgwLDUyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
aHdtb25fY2hpcF9pbmZvDQo+IG1heDMxNzkwX2NoaXBfaW5mbyA9IHsNCj4gPiAgICAgICAuaW5m
byA9IG1heDMxNzkwX2luZm8sDQo+ID4gICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgbWF4MzE3
OTBfY29uZmlnX3B3bV9hc190YWNoKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkgew0K
PiA+ICsgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+ID4gKyAg
ICAgaW50IGksIHJldCA9IDAsIHNpemUsIGNoYW5uZWw7DQo+ID4gKyAgICAgdTggcHdtX2luZGV4
W05SX0NIQU5ORUxdID0geyAwIH07DQo+ID4gKyAgICAgdTggZmFuX2NvbmZpZzsNCj4gPiArDQo+
ID4gKyAgICAgc2l6ZSA9IG9mX3Byb3BlcnR5X2NvdW50X3U4X2VsZW1zKG5wLCAicHdtLWFzLXRh
Y2giKTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKChzaXplID4gMCkgJiYgKHNpemUgPD0gTlJfQ0hB
Tk5FTCkpIHsNCj4gDQo+IFBsZWFzZSByZWZyYWluIGZyb20gdW5uZWNlc3NhcnkgKCApLg0KPiAN
CldpbGwgcmVtb3ZlIGluIHRoZSB2MiBwYXRjaC4NCg0KPiA+ICsgICAgICAgICAgICAgcmV0ID0g
b2ZfcHJvcGVydHlfcmVhZF91OF9hcnJheShucCwgInB3bS1hcy10YWNoIiwNCj4gcHdtX2luZGV4
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
KTsNCj4gPiArICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlByb3Bl
cnR5ICdwd20tYXMtdGFjaCcgY2Fubm90IGJlDQo+IHJlYWQuXG4iKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSsrKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmICgocHdtX2luZGV4W2ldID09IDApIHx8DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAocHdtX2luZGV4W2ldID4gTlJfQ0hBTk5FTCkpIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiANCj4gU2lsZW50bHkgYWNjZXB0aW5nIGJhZCBkYXRhIHNlZW1zIGxpa2UgYSBiYWQg
aWRlYSB0byBtZS4NCj4gDQpBZGQgZXJyb3IgaGFuZGxpbmcgaW4gdjIgcGF0Y2guDQoNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWwgPSBwd21faW5kZXhbaV0gLSAxOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBmYW5fY29uZmlnID0gaTJjX3NtYnVzX3JlYWRfYnl0
ZV9kYXRhKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsaWVudCwNCj4gTUFY
MzE3OTBfUkVHX0ZBTl9DT05GSUcoY2hhbm5lbCkpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBpZiAoZmFuX2NvbmZpZyA8IDApIHsNCj4gDQo+IEFuIHU4IGlzIG5ldmVyIDwgMA0KPiANClVz
ZSBpbnRlZ2VyIHRvIGdldCB0aGUgcmV0dXJuIHZhbHVlIGZpcnN0IGFuZCBzZXQgdG8gZmFuX2Nv
bmZpZyBpbiB2MiBwYXRjaC4NCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlJl
YWQgZmFuIGNvbmZpZyBmb3IgY2hhbm5lbA0KPiAlZCBmYWlsZWQuXG4iLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhbm5lbCk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbl9jb25maWc7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGZhbl9jb25maWcgfD0N
Cj4gKE1BWDMxNzkwX0ZBTl9DRkdfQ1RSTF9NT04gfA0KPiA+ICsNCj4gTUFYMzE3OTBfRkFOX0NG
R19UQUNIX0lOUFVUKTsNCj4gDQo+IFRoaXMgYXNzdW1lcyB0aGF0IHRoZSBjaGFubmVsIGlzIGNv
bmZpZ3VyZWQgYXMgcHdtLg0KPiBXaGF0IGlmIHRoZSBCSU9TIC8gUk9NTU9OIGNvbmZpZ3VyZWQg
YW5vdGhlciBjaGFubmVsIHdoaWNoIHlvdSB3YW50IGFzDQo+IHB3bSBjaGFubmVsIGFzIGZhbiBp
bnB1dCBjaGFubmVsID8NCj4gDQpUaGlzIHdpbGwgY29uZmlnIHRoZSBjaGFubmVsIGFzIFRBQ0gu
DQpDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzY2VuYXJpbyB5
b3UgbWVudGlvbmVkPw0KSW4gb3VyIHN5c3RlbSwgdGhlcmUgaXMgb25seSBCTUMgdGhhdCB3aWxs
IHNldCB0aGUgY29uZmlnIG9mIGZhbiBkZXZpY2UuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY2xpZW50LA0KPiBNQVgzMTc5MF9SRUdfRkFOX0NPTkZJRyhjaGFubmVsKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYW5fY29uZmlnKTsNCj4gPiArICAgICAgICAg
ICAgIH0NCj4gPiArICAgICB9DQo+IA0KPiBTaWxlbnRseSBpZ25vcmluZyBlcnJvcnMgc2VlbXMg
bGlrZSBhIGJhZCBpZGVhLg0KPiANCkFkZCBlcnJvciBoYW5kbGluZyBpbiB2MiBwYXRjaC4NCg0K
PiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBp
bnQgbWF4MzE3OTBfaW5pdF9jbGllbnQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbWF4MzE3OTBfZGF0YSAqZGF0YSkN
Cj4gPiAgIHsNCj4gPiBAQCAtNTIxLDYgKzU2NywxMCBAQCBzdGF0aWMgaW50IG1heDMxNzkwX3By
b2JlKHN0cnVjdCBpMmNfY2xpZW50DQo+ICpjbGllbnQpDQo+ID4gICAgICAgZGF0YS0+Y2xpZW50
ID0gY2xpZW50Ow0KPiA+ICAgICAgIG11dGV4X2luaXQoJmRhdGEtPnVwZGF0ZV9sb2NrKTsNCj4g
Pg0KPiA+ICsgICAgIGVyciA9IG1heDMxNzkwX2NvbmZpZ19wd21fYXNfdGFjaChkZXYsIGNsaWVu
dCk7DQo+ID4gKyAgICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAgIGRldl9jcml0KGRldiwg
IkNvbmZpZyBQV00gYXMgVEFDSCBmYWlsZWQuXG4iKTsNCj4gPiArDQo+ID4gICAgICAgLyoNCj4g
PiAgICAgICAgKiBJbml0aWFsaXplIHRoZSBtYXgzMTc5MCBjaGlwDQo+ID4gICAgICAgICovDQoN
Cg==
