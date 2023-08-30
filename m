Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2C78DF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbjH3TPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbjH3Mso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:48:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADF132;
        Wed, 30 Aug 2023 05:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8CPwomwIQMLJ9L/QAElqRxVLZwRI/L+83IPyi6S4dI0/49clklpULIhFtUI5NjUesOSkWfbOrUsuCcuRUiuQ0IJEKo8KKmzXnRFfE5NibEEOoEq0tDWtY2Dgq8Rv+V/anozrXqJpBWoa24rX6cZ2vKlyqc1zlR85piD/fBHdhphk/C5w3msVbkPslbL7m1LNyQkC3CG0L2fhRkiX6yoUNczyNBXlp4/ZaE3p2EsG8wDeRrERQ+2bkaeV/MCzAzXMw/MSjC0O2H7W2hXcGhB08q0I6ks+cgRk7MKyOYuBprMu7qI5obdVgEUhEW/mGLnXY/WNh7hNdZ+zp54f3qZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ8bwRYjBk8olF2Rd322Wa97cKFX5qcwZIcK12+6AxM=;
 b=guxQ84ujdnVyiCafrAVv3J3WvMajeL47cKkws4R1fNt52sxTPS/uiUXVMPeEyHIzWzblOHjSju+ivmKfFGiiNWzf7NbiI0xtKLQH8ko5YWJAbjtQsMh3ja+BTAUB95xHDMaEOlBywj2n4Uk+PZz7/uaCx9bpQG2jdmdsCA0CIyrU8SnCDSBmOCzEZpV070aT1UzCN1wiUxdMshm+W5PFAUAytgIAMh6fTqHnJjhLpCS3zMoCRpiQ0NysJf+WWPCBQdBGLPNFXkMj/9Nh4mKEqjxbadjZPPFrZnDKR6KTKMWLd7Y9md6BZKwSF1JhDzm/mK/ZZmxvzG9kqUUdlcwohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ8bwRYjBk8olF2Rd322Wa97cKFX5qcwZIcK12+6AxM=;
 b=Re62YvRdQLwF//Lh6VS+pwFITJFtGxe1eOJYzF8BzdUvPXVCilDjhY176EUEfUPovJu/as1uZcgXZyhAUxUQkieyaSkjm5PXYZq8Fp6lwjKDcejQ05x7u3lXYD38F/7CD12rUjbARlAxgqfBAknIS/qlVs31BwnNJ2K7hzFwEDM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 12:48:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 12:48:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC] scmi: pinctrl: support i.MX9
Thread-Topic: [RFC] scmi: pinctrl: support i.MX9
Thread-Index: AQHZ1ljQGymVJC/R70ObhTQ99JrC7K/5IV8AgABBfyCAAUzIgIAAARsggAgSAgCAAA8p4A==
Date:   Wed, 30 Aug 2023 12:48:37 +0000
Message-ID: <DU0PR04MB941726AF86EEB0BBB55B9A2A88E6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
 <DU0PR04MB9417B3CB9638F936DF19C523881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CACRpkdZKMsC1Wyi+nOf7idAWMTUe8w2XbtpWnbDKrCLD75ND1g@mail.gmail.com>
 <DU0PR04MB94178923DFC8E71287E560E888E3A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZO8sRknW-6vdKoDd@pluto>
In-Reply-To: <ZO8sRknW-6vdKoDd@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9244:EE_
x-ms-office365-filtering-correlation-id: 8113f73c-3404-4af7-1433-08dba9576e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbraCW8VF/PNCab/+DRDdmEZFfjq4//MzkTeuCaOSM1G4hC/GdWYOe7Adyj/ogz2sukqOY3sQ+8fGmGcAJGdXHsl4JPUZFzRfUPremjVdi1bg+SZbhTzybJT7hxBKeHMFqxHTowKql0ugLjGUJFNp8QVkA7kjkLRioLVZbQbURAgfWI8bmvgWB+YJL3U1a1jzGg8UTlOzmVy50lRiSOuJN2EY3Lzecoggm7fZ6hufFH1/ERkuHTipaGIASarQXQ6WePsxqmWUk2boBz1rvn63qSkZEUXouyxvecM5bMt78++Wr+672xGscBuomQJbXILDxORH7EtBqSWQpHNvgp0zfjK7E9NkobixZm/YptPHEo3QrsfWrBpasi7igYj5Y/KdnIjohtNjjVk7HF7NpJjzm2ipxxGLmwzUApGXLk9qx1J4fwOtuiAbiZMrtupvYzRhfZgrD8uXDsGGoc6ISu1XqOEYTHaM5msNzhrWt4QzgcVz5tsd3rfc44Ehn3X5ch8W5RMNl68GRObP0IuJ1a+ffNgs5ZnH6GsPeqp7ZKtLI5WfbhDeGDuAX2pFbzoCwlnZGKaqQrLs8ANLNlCgaQO3Xd/vd5B8X12fS+WBybgZMJ2cyTS08fxoi9YiwL1S1b6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(1800799009)(451199024)(186009)(6916009)(64756008)(66476007)(66446008)(66556008)(66946007)(76116006)(54906003)(2906002)(316002)(5660300002)(4326008)(8676002)(8936002)(52536014)(44832011)(7416002)(41300700001)(6506007)(7696005)(55016003)(53546011)(9686003)(122000001)(71200400001)(478600001)(86362001)(38100700002)(38070700005)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2xIRjNQT0ZWNmRGUC9Kb3BIa3p0SEVmK1h1aGZNczFaRnpWdXJCdnY1d0ho?=
 =?utf-8?B?a1ZRQUxhMVdzaGFYbU40dFY2N3R1ZFdicW5nVDJyK0pNbXBLTDd6Qm94elFN?=
 =?utf-8?B?NVE3dmZBek5Ba3ZYdXArK29CTmpvMllOa1NUNFhUQlkvN1cxYzFrNnc2U1cz?=
 =?utf-8?B?a0dVMG8vamRuOEdQdlYxZ0RsNDZTdFlFY05rUU9iY1FjNkM2eHBBOGRYa0Z5?=
 =?utf-8?B?MWJKZnRPSXphL29SRGVjSnJrUzJGZ0tBb0RXTG8xOHlWNXEvcEVzZDNlZmpQ?=
 =?utf-8?B?M0F3YmRQOXZqZ2ZwTmxtQlNVUWl5UjQ0RXlMbTBxQ0IwS0I0NWZDaERPZkJw?=
 =?utf-8?B?am9adGwyaTZtU242cVZubzBBUHlIYXpvbDJ1NHhlbGtqa1Q5RlJwcXJ6cWlB?=
 =?utf-8?B?eXptaG12VkJuUHpqVVVmYUJua2cvZzJiWFBITzMxWWRDVll0bmNaMGVMNWxt?=
 =?utf-8?B?S3R4cmhEbmg2U2VXUDhtNjFTSExIc0Ywd2lKb3dSTE50T0VLQUNKemRSbzJk?=
 =?utf-8?B?Y0o2MkpTQXluWTRFMlRTVGVwTCt2WE1aTGMrR1VnWmZlS05Wby9MVXdISitJ?=
 =?utf-8?B?V3N5Z2t1Sy8zNVg3c1RhNHFHMlFnRnYvL1RBb3h4VWtPZ1JCUjBIN1BURWdW?=
 =?utf-8?B?K2NmamZCcFlibjNlclJjWlZQNEd0b0ZibGxYZWhmNnJCTGVRV0hidzZKZEhM?=
 =?utf-8?B?Vm5qcnFSZkdxMmgrMytOQVhlWlNZRFZPNFpPbUcrOXFRaGFMZFF1STNUbjla?=
 =?utf-8?B?S3R0S3pwNncwNklMNXpZNnk5bytvM0RIVUpPNjZ1QlpOZGNZb2FUVGV1NVNa?=
 =?utf-8?B?eGpCL0FaRVNIWGtyL0J2RnF0VmwrOHZoNlM5Y2dxWjhFVEl6VitnWkJTSk5r?=
 =?utf-8?B?RGFhRzBVSVFjZ3JFUFc0ZGRxNXA4a1JZNEpGQk4vQ0V6K0VudVhKY0RTNnlS?=
 =?utf-8?B?ZTNjbTFQam1LWXhNL3FkaGxraDZDanFEZXRHdzFUSUZMRUdwZ2MvZXVjRnRz?=
 =?utf-8?B?M3dTS0FwaEUvNWt0TUY3R2RKRW9xZmRaUzFiT0FaRXF5OC9nczQxSmZaejFa?=
 =?utf-8?B?bnlCSGlGVFlNNTlFQ2xEMHdwczViYWhOcm1mRHVDUDFxY3FSMkppWWlKZklj?=
 =?utf-8?B?a3ZLK2Z1em92WkJBbnhNK1F4bmQyM3RtTmJPNXowOW9yNVFjRDF4WnN6UVJi?=
 =?utf-8?B?UzFDTDhPMEtiNS9aUGFHUEhTZHU4UHFOMGNaMVBEMjZ2aWRkM3JIQkVwbXZN?=
 =?utf-8?B?SURLaVJvNXRJR2FncGFCRkVtR0hya3d5blRWdGlsMHcyeTBnOUpTMlBPMjR5?=
 =?utf-8?B?enc5VUN3b2tSekR4NkpaRnY0V1JBOXoxUmNjcEVYSTFxZ0lLbWFGNzhuZnZw?=
 =?utf-8?B?aFJUcG1PVzMxcENzNU14SUt0Z0VqK25YQWFBV21Cb3FYbHlhUUpFYzBlNGxV?=
 =?utf-8?B?MlN2ZEc0OG5VRURnV1M1ekRNY1ZiT3FtYngyaklKdW13OWtLeHJNYWp3SUtC?=
 =?utf-8?B?enVwZjNqamVvSERZOFpxM2NDSklpSnlCYmVaZDlGMWdGUHcxUHVqWSsyMUNS?=
 =?utf-8?B?TXF3SS9XT1hiTFNhWlRQdGJjVzFtV0pxaTJWeWpMVnRFVmMzdldCZytBUDFJ?=
 =?utf-8?B?djB4YnQ3VGJCdnA3aWJJYXBTbnRVTWErbzZDSzRaSlVpYTFQSWgvTXpjVXFJ?=
 =?utf-8?B?MHJzR01aeDk2V0ZIUXJnNFhtUjZsTEJZNjRPQ0JSeUFZNy9zWDlFbXBEaWdN?=
 =?utf-8?B?bkNQSk05NXh5VVlDeTZOaUgwV1JHMVk2MHV3bXpCWlVjbm5aQWx6MXpxVi9o?=
 =?utf-8?B?cHlaMXVsWnBaUllKSlNIZGlnUEhST2RIMXU5ZFlWZkhNQTJNbXRLVlpkMkhw?=
 =?utf-8?B?SkZxOUVWUW15d1RlMGwxVFl0cVRFNUdENGQ0aTVNTmUwakFWUWVuSWhrbmZU?=
 =?utf-8?B?eEZZcVl3Sm56VDdiSnRPdlRidyszS3VUb0ZHa2F1MG9XWGhxZE16NmViREdX?=
 =?utf-8?B?MmRzbDd3Mm5DaEp5djYxVUxJVUVLTktJcTdVa0hhSzE4eXhVWjBkS081aW8w?=
 =?utf-8?B?em5pbm9DTlBSSjFtdCt0TXo4RW5zZTNOSUh6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8113f73c-3404-4af7-1433-08dba9576e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 12:48:37.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCbbnJQpzI29KeGJwAUmFr6jYPJHpR3lo3+8wdHPgzxZ+eVo0ULyk2sPwX6xp45dRQtLdWbtDdOV1md2q/9LBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCj4gU3ViamVjdDogUmU6IFtSRkNdIHNjbWk6IHBpbmN0cmw6IHN1cHBv
cnQgaS5NWDkNCj4gDQo+IE9uIEZyaSwgQXVnIDI1LCAyMDIzIGF0IDA4OjQzOjM4QU0gKzAwMDAs
IFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkNdIHNjbWk6IHBpbmN0cmw6
IHN1cHBvcnQgaS5NWDkNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCAyOjQ3
4oCvUE0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gPiBNZToNCj4g
DQo+IEhpIFBlbmcsDQo+IA0KPiA+ID4NCj4gPiA+ID4+IGl0IGlzIG1lcmVseSBtYWtpbmcgdGhp
bmdzIG1vcmUgY29tcGxleCBhbmQgYWxzbyBzbG93ZXINCj4gPiA+ID4gPiBieW1ha2luZyB0aGUg
cmVnaXN0ZXJzIG9ubHkgYWNjZXNzaWJsZSBmcm9tIHRoaXMgU0NNSSBsaW5rLg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGlzIGlzIGZvciBzYWZldHkgcmVhc29uLCB0aGUgcGluY3RybCBoYXJkd2FyZSBt
dXN0IGJlIGhhbmRsZWQgYnkNCj4gPiA+ID4gYSBzeXN0ZW0gbWFuYWdlciBlbnRpdHkuIFNvIG1t
aW8gZGlyZWN0IGFjY2VzcyBub3QgYWxsb3dlZCBmcm9tDQo+ID4gPiA+IENvcnRleC1BIHNpZGUu
DQo+ID4gPg0KPiA+ID4gWWVhaCBJIHVuZGVyc3Rvb2QgYXMgbXVjaC4gQnV0IEkgZG9uJ3QgdGhp
bmsgdGhhdCB0aGUgZmlybXdhcmUgaXMNCj4gPiA+IHJlYWxseSBmaWx0ZXJpbmcgYW55IG9mIHRo
ZSBhY2Nlc3MsIGl0IHdpbGwganVzdCBwb2tlIGludG8gYW55DQo+ID4gPiBwaW5jdHJsIHJlZ2lz
dGVyIGFzIGluc3RydWN0ZWQgYW55d2F5IHNvIHdoYXQncyB0aGUgcG9pbnQuIEp1c3QgbG9va3Mg
bGlrZSBhDQo+IGxheWVyIG9mIGluZGlyZWN0aW9uLg0KPiA+DQo+ID4gTm8sIHRoZSBmaXJtd2Fy
ZSBoYXMgYSBjaGVjayBvbiB3aGV0aGVyIGEgcGluIGlzIGFsbG93ZWQgdG8gYmUNCj4gPiBjb25m
aWd1cmVkIGJ5IHRoZSBhZ2VudCB0aGF0IHdhbm5hIHRvIGNvbmZpZ3VyZSB0aGUgcGluLg0KPiA+
DQo+ID4gPiBCdXQgSSdtIG5vdCB5b3VyIHN5c3RlbSBtYW5hZ2VyLCBzbyBpdCdzIG5vdCBteSBk
ZWNpc2lvbi4NCj4gPiA+DQo+ID4gPiA+IFRoZSBTQ01JIGZpcm13YXJlIGlzIHZlcnkgc3RyYWln
aHRmb3J3YXJkLCB0aGVyZSBpcyBubyBncm91cCBvcg0KPiA+ID4gPiBmdW5jdGlvbi4NCj4gPiA+
ID4NCj4gPiA+ID4gSXQganVzdCBhY2NlcHRzIHRoZSBmb3JtYXQgYXMgdGhpczoNCj4gPiA+ID4g
TVVYX1RZUEUsIE1VWCBWQUxVRSwgQ09ORl9UWVBFLCBDT05GX1ZBTCwgREFJU1lfVFlQRSwgREFJ
U1kNCj4gSUQsDQo+ID4gPiA+IERBSVNZX0NGRywgREFJU1lfVkFMVUUuDQo+ID4gPiA+DQo+ID4g
PiA+IFNpbWlsYXIgYXMgbGludXggTU1JTyBmb3JtYXQuDQo+ID4gPiA+DQo+ID4gPiA+IE91ciBp
Lk1YOTUgcGxhdGZvcm0gd2lsbCBzdXBwb3J0IHR3byBzZXR0aW5ncywgb25lIHdpdGggU0NNSQ0K
PiA+ID4gPiBmaXJtd2FyZSwgb25lIHdpdGhvdXQgU0NNSS4gVGhlc2UgdHdvIHNldHRpbmdzIHdp
bGwgc2hhcmUgdGhlIHNhbWUNCj4gPiA+ID4gcGluY3RybCBoZWFkZXIgZmlsZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gQW5kIHRvIHNpbXBsaWZ5IHRoZSBzY21pIGZpcm13YXJlIGRlc2lnbihhbnl3YXkg
SSBhbSBub3Qgb3duZXIgb2YNCj4gPiA+ID4gdGhlIGZpcm13YXJlKSwgdG8gbWFrZSBwaW5jdHJs
IGhlYWRlciBzaGFyZWQgdy9vIHNjbWksIHdlIHRha2UgdGhlDQo+ID4gPiA+IGN1cnJlbnQgaW4t
dXBzdHJlYW0gZnJlZXNjYWxlIGlteCBiaW5kaW5nIGZvcm1hdC4NCj4gPiA+DQo+ID4gPiBUaGUg
U0NNSSBwZW9wbGUgd2lsbCBoYXZlIHRvIHN0YXRlIHRoZWlyIHBvc2l0aW9uIG9uIHRoaXMuDQo+
ID4gPiBMaWtlIHdoYXQgdGhleSBjb25zaWRlciBjb25mb3JtYW5jZSBhbmQgd2hhdCBleHRlbnNp
b25zIGFyZSBhbGxvd2VkLg0KPiA+ID4gVGhpcyBpcyBtb3JlIGEgc3RhbmRhcmRpemF0aW9uIHF1
ZXN0aW9uIHRoYW4gYW4gaW1wbGVtZW50YXRpb24NCj4gPiA+IHF1ZXN0aW9uIHNvIGl0J3Mgbm90
IHJlYWxseSBteSB0dXJmLg0KPiA+DQo+ID4gVGhlIGkuTVg5NSBTQ01JIGZpcm13YXJlIHVzZXMg
T0VNIGV4dGVuc2lvbiB0eXBlLiBTbyBJIGp1c3QgZm9sbG93DQo+ID4gd2hhdCB0aGUgZmlybXdh
cmUgZGlkIGFuZCBzdXBwb3J0IGl0IGluIGxpbnV4LiBBbnl3YXkgbGV0J3Mgd2FpdA0KPiA+IFN1
ZGVlcCdzIHJlcGx5Lg0KPiA+DQo+IA0KPiBTbyBteSB1bnNkZXJzdGFuZGluZyBvbiB0aGlzIG1h
dHRlciBhcyBvZiBub3cgaXMgdGhhdDoNCj4gDQo+IDEuIHRoZSBjdXJyZW50IFNDTUkgUGluY3Ry
bCBzcGVjaWZpY2F0aW9uIGNhbiBzdXBwb3J0IHlvdXIgdXNlY2FzZSBieSB1c2luZw0KPiAgICBP
RU0gVHlwZXMgYW5kIG11bHRpcGxlIHBpbnMvdmFsdWVzIENPTkZJR19HRVQvU0VUIGNvbW1hbmRz
DQoNClllcywgYmFzZWQgb24gdGhlIE9sZWtzaWkgcGF0Y2hzZXQgd2l0aCBteSBsb2NhbCBtdWx0
aXBsZSBjb25maWdzIHN1cHBvcnQuDQoNCj4gDQo+IDIuIHRoZSBLZXJuZWwgU0NNSSBwcm90b2Nv
bCBsYXllciAoZHJpdmVyL2Zpcm13YXJlL2FybV9zY21pL3BpbmN0cmwuYykNCj4gICAgaXMgZXF1
YWxseSBmaW5lIGFuZCBjYW4gc3VwcG9ydCB5b3VyIHVzZWNhc2UsIEFGVEVSIE9sZWtzaWkgZml4
ZXMgaXQgdG8NCj4gICAgYWxpZ24gaXQgdG8gdGhlIGxhdGVzdCB2My4yLUJFVEEyIHNwZWNpZmlj
YXRpb24gY2hhbmdlcy4NCj4gICAgSU9XLCB0aGlzIG1lYW5zIHRoYXQsIHVzaW5nIHRoZSBTQ01J
IFBpbmN0cmwgcHJvdG9jb2wgb3BlcmF0aW9ucw0KPiAgICBleHBvc2VkIGluIHNjbWlfcHJvdG9j
b2wuaCwgZnJvbSBzb21ld2hlcmUsIHlvdSBhcmUgYWJsZSB0byBwcm9wZXJseQ0KPiAgICBjb25m
aWd1cmUgbXVsdGlwbGUgcGlucy92YWx1ZXMgd2l0aCB5b3VyIHNwZWNpZmljIE9FTSB0eXBlcy4N
Cg0KWWVzLg0KDQo+IA0KPiAzLiBUaGUgU0NNSSBQaW5jdHJsIGRyaXZlciAoYnkgT2xla3NpaSkg
YnVpbHQgb24gdG9wIG9mIHRoZSBwaW5jdHJsIHByb3RvY29sDQo+ICAgIG9wZXJhdGlvbnMgaXMg
aW5zdGVhZCBOT1Qgc3VpdGFibGUgZm9yIHlvdXIgdXNlY2FzZSBzaW5jZSBpdCB1c2VzIHRoZSBM
aW51eA0KPiAgICBHZW5lcmljIFBpbmNvbmYgYW5kIElNWCBkb2VzIG5vdCBtYWtlIHVzZSBvZiBp
dCwgYW5kIGluc3RlYWQgSU1YIGhhcw0KPiAgICBpdHMgb3duIGJpbmRpbmdzIGFuZCByZWxhdGVk
IHBhcnNpbmcgbG9naWMuDQoNClllcy4NCg0KPiANCj4gQW0gSSByaWdodCA/DQoNCllvdSBhcmUg
cmlnaHQuDQoNCj4gDQo+IElmIHRoaXMgaXMgdGhlIGNhc2UsIEkgd291bGQgTk9UIHRyeSB0byBh
YnVzZSB0aGUgY3VycmVudCBTQ01JIFBpbmN0cmwgR2VuZXJpYw0KPiBkcml2ZXIgKGJ5IE9sZWtz
aWkpIGJ5IHRocm93aW5nIGludG8gaXQgYSBidW5jaCBvZiBJTVggc3BlY2lmaWMgRFQgcGFyc2lu
ZywNCj4gYWxzbyBiZWNhdXNlIHlvdSdsbCBlbmQtdXAgTk9UIHVzaW5nIG1vc3Qgb2YgdGhlIGdl
bmVyaWMgU0NNSSBQaW5jdHJsIGRyaXZlcg0KPiBidXQganVzdCByZXVzaW5nIGEgYml0IG9mIHRo
ZSBwcm9iZSAoY3VzdG9taXplZCB3aXRoIHlvdXIgb3duIERUIG1hcHMNCj4gcGFyc2luZykNCg0K
T25seSBEVCBtYXAgdG8gcGFyc2UgdGhlIGR0cyBhbmQgbWFwIHRvIGNvbmZpZyBhcnJheS4gT3Ro
ZXJzIGFyZSBzYW1lLA0Kc28gbmVlZCB0byBleHBvcnQgc29tZSBzeW1ib2xzIGZvciBwaW5jdHJs
LXNjbWktaW14LmMgZHJpdmVyIGlmIGJ1aWxkIGlteA0Kc2NtaSBkcml2ZXIuDQoNCj4gDQo+IElu
c3RlYWQsIGdpdmVuIHRoYXQgdGhlIHNwZWNbMS5dIGFuZCB0aGUgcHJvdG9jb2wgbGF5ZXJbMi5d
IGFyZSBmaW5lIGZvciB5b3VyDQo+IHVzZSBjYXNlIGFuZCB5b3UgaW5kZWVkIGhhdmUgYWxyZWFk
eSBhIGN1c3RvbSB3YXkgdG8gcGFyc2UgeW91ciBEVA0KPiBtYXBwaW5ncywgSSB3b3VsZCBzYXkg
dGhhdCB5b3UgY291bGQganVzdCB3cml0ZSB5b3VyIG93biBjdXN0b20gU0NNSQ0KPiBkcml2ZXIg
KCA/IHBpbmN0cmwtaW14LXNjbWkpLCBkaXN0aW5jdCBhbmQgbXVjaCBtb3JlIHNpbXBsZSB0aGFu
IHRoZSBnZW5lcmljDQo+IG9uZSwgdGhhdCBkb2VzIGl0cyBvd24gSU1YIERUIHBhcnNpbmcgYW5k
IGNhbGxzIGp1c3QgdGhlIFNDTUkgcHJvdG9jb2wNCj4gb3BlcmF0aW9ucyB0aGF0IGl0IG5lZWRz
IGluIHRoZSB3YXkgdGhhdCB5b3VyIHBsYXRmb3JtIGV4cGVjdHM6IHNvIGJhc2ljYWxseQ0KPiBh
bm90aGVyIFBpbmN0cmwgU0NNSSBkcml2ZXIgdGhhdCBkb2VzIG5vdCB1c2UgdGhlIGdlbmVyaWMg
cGluY29uZiBEVA0KPiBjb25maWd1cmF0aW9uIEJVVCBETyBVU0UgdGhlIHVuZGVybHlpbmcgU0NN
SSBQaW5jdHJsIHByb3RvY29sICh2aWEgaXRzDQo+IGV4cG9zZWQgcHJvdG9jb2wgb3BlcmF0aW9u
cy4uLikNCg0KSSBhbSBvayB3aXRoIHRoaXMgYXBwcm9hY2gsIGJ1dCBJIG5lZWQgdXNlIHRoZSBv
dGhlciBJRCwgc2F5aW5nIDB4OTksIG5vdCAweDE5LA0KYmVjYXVzZSAweDE5IHdpbGwgYmluZCB3
aXRoIHRoZSBwaW5jdHJsLXNjbWkuYyBkcml2ZXIsIEkgY291bGQgbm90IHJldXNlDQp0aGlzIElE
IGZvciBpLk1YIHBpbmN0cmwtc2NtaS1pbXggZHJpdmVyLiBPdGhlcndpc2UgdGhlcmUgd2lsbCBi
ZSBpc3N1ZSBpZiBib3RoDQpkcml2ZXIgYXJlIGJ1aWx0IGluIGtlcm5lbCBpbWFnZS4NCg0KPiAN
Cj4gTm90IHN1cmUgd2hhdCBTdWRlZXAgdGhpbmtzIGFib3V0IHN1cHBvcnRpbmcgbXVsdGlwbGUg
U0NNSSBkcml2ZXIgZm9yIHRoZQ0KPiBzYW1lIHByb3RvY29sICh3ZSBkaWQgaXQgYWxyZWFkeSBm
b3IgU2Vuc29ycyBod21vbiAmJiBpaW8pLCBhbmQgaWYgdGhpcw0KPiBhcHByb2FjaCB3b24ndCBu
ZWVkIHNvbWUgc29ydCBvZiBtdXR1YWwgZXhjbHVzaW9uIG1lY2hhbmlzbSBpbiBLY29uZmlnDQo+
IHRvIGF2b2lkIGxvYWRpbmcgYm90aCB0aGUgZ2VuZXJpYyBhbmQgdGhlIGN1c3RvbSBJTVggKGV2
ZW4gdGhvdWdoIHRoZXkNCj4gc2hvdWxkIGJlIGFibGUgdG8gY28tZXhpc3QgZnJvbSB0aGUgU0NN
SSBrZXJuZWwvZncgc3RhY2sgcGludCBvZiB2aWV3LCBhcw0KPiBsb25nIGFzIHlvdSBkb250IG1l
c3MtdXAgdGhlIERUcyBhbmQgbWl4dXAgZ2VuZXJpYyBwaW5zIHdpdGggY3VzdG9tIElNWA0KPiBw
aW5zLi4uKQ0KPiANCj4gSW5zdGVhZCwgYWRkaW5nIGFuIElNWC1jdXN0b20gZXh0ZW5zaW9uIHRv
IHdoYXQgaXQgd2FzIHN1cHBvc2VkIHRvIGJlIGENCj4gZ2VuZXJpYyBkcml2ZXIgKGFzIHlvdSBw
cm9wb3NlKSBzZWVtcyB0byBtZSBsaWtlIGEgc3RyZXRjaCBvZiB0aGUgZ2VuZXJpYw0KPiBQaW5j
dHJsIGRyaXZlciB0aGF0IGlzIG5vdCByZWFsbHkgd29ydGgsIHNpbmNlIHlvdSdsbCBlbmQgdXAg
cG9sbHV0aW5nIHRoZQ0KPiBnZW5lcmljIGRyaXZlciB3aXRoIHNvbWUgaGlnaGx5IGN1c3RvbSBh
bmQgc3BlY2lmaWMgSU1YIGJpdHMuIHdoaWxlIHJlYWxseQ0KPiBOT1QgcmV1c2luZyBzbyBtdWNo
IG9mIHRoZSBnZW5lcmljIGRyaXZlciBhdCBhbGwuDQoNCklmIFN1ZGVlcCBhZ3JlZSwgSSB3aWxs
IGZvbGxvdyB5b3VyIHN1Z2dlc3Rpb24gYW5kIHBvc3QgYSBwYXRjaCBmb3IgcmV2aWV3LCBsYXRl
ci4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IFRoYW5rcywNCj4gQ3Jpc3RpYW4NCg0K
