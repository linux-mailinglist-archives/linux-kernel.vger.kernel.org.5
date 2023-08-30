Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8704F78D255
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjH3DJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjH3DJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:09:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8BCC5;
        Tue, 29 Aug 2023 20:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzsrCeh1uGxxCpZwT6VEfhZcwPwZEmMHTjDVO4eN+HbHP3flPQq8TPElWu+4yexXQF8kpmq0CtDG8ZBCMtkhUHAVEjzOgHGcZj2Ss5OMyN/TeMueF8bAUoAndYxgUHYXQjQwzAf7Nwtwx0g8bvOF59vMz9PqgCKgZGOKGgyUv3mlv/y1LKHMV721rXCb5O+U5JYOv0lwN2qy6wxRcJrV/PAOr6sSjz155V6xaXAcLnjDCwvQHFlgCDW4A07rWAiT2s+eculk2KgvjpJIeZwfw2ynfO/gOo+CFiAyrEB/PQcrx8IJRhvI+gq1AR/4qFr9lvUtCGixqw0kYq0AI++uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn9LB4mkDNVKRY8D6rQRKjo6kYzchWMaXaqPVYt/NuA=;
 b=c9kBknTCpvVQODL296ual1+qZ7zd/+7i9iaEu0rP8UFtl8fRe684c8JX790lqUkyExhXAHuwRh3oojzcKr0B9/rkTJ+ipDdLRwNUEP7e2IGg4J3+xHw1S+G4QJo982rCcp/sVHWbwdM2QoAXtpx4f+HSsr4hfkuEKNJw6MVikcRUBm8aIYiryEJAE4pEktA3nw09WSV2pFK8kpwWaBD2qqOhPJuYvfAWmtTSKfcqxOtY4NLO7KY1ttTLm21wbVpg3uV76zVcyQsqo268y80Vy2dqORbsBHZx/eY22vgeoragYJx1+zy7bRBDyQ9jCGdbWpEI/qAUpdFh0TDB7TJIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn9LB4mkDNVKRY8D6rQRKjo6kYzchWMaXaqPVYt/NuA=;
 b=YT2InTnZ0Cy6IxYiPBaoIMQNbBaHeNRh6gzSd6QeCDJuK1MaaVsOU9GhPC/LgXFPYZJH+0PhfFuFMH0femY20Q7hiYUWq71ey+lD30yF7y6NUXBPDXdvggq1rtoZfHVfqHgM3PZ46UpByjwlzFQB92GnSPZu+UH8YX/ajZHPb7U=
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com (2603:10a6:102:1bc::10)
 by AM8PR04MB7427.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 03:09:03 +0000
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::2d1c:3c35:eb87:6d62]) by PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::2d1c:3c35:eb87:6d62%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 03:09:03 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] cpufreq: dt-platdev: Support building
 cpufreq platdev driver as module
Thread-Topic: [EXT] Re: [PATCH 2/2] cpufreq: dt-platdev: Support building
 cpufreq platdev driver as module
Thread-Index: AQHZjhJtJKe6rytEKE+YCs+BkZx8trACKVKAgACJjhA=
Date:   Wed, 30 Aug 2023 03:09:03 +0000
Message-ID: <PAXPR04MB8304AA1D331B3DA5B548EE3EEBE6A@PAXPR04MB8304.eurprd04.prod.outlook.com>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
 <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
 <ZO4yTQAV9EYA4erZ@aurel32.net>
In-Reply-To: <ZO4yTQAV9EYA4erZ@aurel32.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8304:EE_|AM8PR04MB7427:EE_
x-ms-office365-filtering-correlation-id: dae6436d-d889-4c6e-5510-08dba90676f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUx83jOQXzjnsbiR08AmIU1PIizHqjsVStH0mROQF8mOiZxTdAhfbQVHsofGCBfiighTf8dMAv5e2oj20mxNAEYkzZXhvYVwqn4IarIepvhv9YCqknfTROR0CtLzDmmty4/c8QglseSKdTVrUyglcqJND49QjrkydrI3dcvvf00zqYWuUCbhwOhDk5EFOv8BfJDXn3lMMaCx7HPjdZ5EPVV1kCSSUjbsPasMT/Qujg3+9vnO/+Zgl4jimR7fiVf0yA7xUHO4Y2LiyNtBfJ6ZkJtkS2Jci2yslO7Kj8B7f2KkGipHaDGwJx4pplVXjro+IoCUU5loSsYLPEDsX5GGCxdfgFwdP+LSP55xH+FxMENXW84+GS6QmCHut2XWMxM75DcLQ9P/nwNtqI9uN9eXRFtjNBlbpjRH9t/zXKgG0eXxr5xf/FaK1rIq7aS+GGuD/Ud2xPES83EbGGvPW1mMioSegpFNdNlGTDSv3jGxGNXe5N1IPL3D8EWyxy+/TQEAzaWDSQeHPHs45HuY/6vf1IGcK3xxJ3Ic6tILZ/Wzz8Fo7wdWTvQFVmM25DTBBKbAgCHvk6qptPwJZxMs08D6/FlqSoiM73bx8k7eXGdQFMcsp8iFGIzhKUgNXQP9ki+j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8304.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(66476007)(7696005)(71200400001)(9686003)(6506007)(86362001)(55016003)(33656002)(38100700002)(38070700005)(122000001)(2906002)(76116006)(26005)(53546011)(83380400001)(45080400002)(52536014)(8936002)(4326008)(66446008)(54906003)(5660300002)(478600001)(8676002)(66946007)(41300700001)(316002)(966005)(6916009)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aCs4RWVqMEMwTkNnRXc2ZDI1b0oxN2hIWHA1NktGVG93TTAxYVBnRGQ2VU5L?=
 =?gb2312?B?WmFBVS9JcWlqQTRTNkRjb25vY3YwamgzMnVVTlNzbzNOQWs4OGlCUEV6YjRP?=
 =?gb2312?B?SEZKYVUySVdESHFnVE9KNHZySnR5MTN5NkhFaFFJYWNKWGxmWng4TUErdDZZ?=
 =?gb2312?B?OWlCVEFYOGUxVVZyclVaamdpS2VqcHRhRDRQRFVUUnpYQmY1Qm0wenl1dlQy?=
 =?gb2312?B?a3ViN25EQmFJNEdiUFZqRDc0UmRsSFNxcHVwSzIyQXdRVXZqRHZjeThsOHJv?=
 =?gb2312?B?cUNEN0hua0wxNzB2RENzMzB6eVZDZWFsanFQQS9mUjloMit2MGZqNStheExv?=
 =?gb2312?B?SG0vUUpvWUNIMFpVYVpZcG1XcC9tSFpQT2ZxQTNzNjBsSDZNQ21WMDRwZGJP?=
 =?gb2312?B?dkJ1S0RlbG1HWU9yQTlQTGdUeWx0amE0TkI0aitham5ZTmtvenpqOE1kM3Jq?=
 =?gb2312?B?bDEzVzVldEtUbWNEQXhQc0lOTW8zUmxLU3I5MzQrUFhudFlkRzZCaDk2TW1n?=
 =?gb2312?B?MFppM3VkL0tzVEc0SlZoZ0NseHJEMWNjc3h1bUlaVVRVN3dWVEVIV2E4djlh?=
 =?gb2312?B?LzBEN01GUFBMcUhCbW5kRXBGRmZMSGZ1S0hVSzVNSjMvdjFaNUU5UTgxVjhi?=
 =?gb2312?B?N0U3MUo4OUpJQkpXcGFvQlVvS2lwSDZabzNTVi93LzVEZC9vbGprc1lrM2Vy?=
 =?gb2312?B?S1htRktOMmVCZ0h2SnY3MVNmRy9OaHJaNk5STURwci9nY3FCbEJzSzBFUjNr?=
 =?gb2312?B?aStvQ00wRWw0UXIyQVNBR1Z3eWVBczFBRUIvOTVCaGxPeURDQVVrY2RUSytu?=
 =?gb2312?B?dG40OU05VDJ2azh4UWxvLzNPM2dzc0ZNd0U0a2VCaWtmd3JNS3FJanRTMmE0?=
 =?gb2312?B?UDdVb0NkYmlMdUxJMk1vdzJOdFRFcGQ5RXZvU0tpSjJUVlVzS2tjN1VzRGhk?=
 =?gb2312?B?N1ordEw3Q3hvOEk3MG9SY0VhbDdOWk15eWkvWmhEQXg3OW1OZkJXaHM0Tm5W?=
 =?gb2312?B?N3dwcXZBdUErek1ONjZvOS9GVjc2QXpKSHVLQ0x0YUdJVDFrVlcyVjhVYW5h?=
 =?gb2312?B?dlprZjdHSVErdEJ1TUQyT3E3VnRHNUE2QmF1TXp0aDQ2VnZmalN1aTJCQWpz?=
 =?gb2312?B?QXNOTDEyL0xmU2tNaEpNdWVqeFNPUTJ6SVI1QmtQdjY2ZHN6KytVOE9FRG1Y?=
 =?gb2312?B?WWZ3ZzZhQ2xpNGVTVXg4L3loazB5VVFGQU9DUjVjWmVYOXdZdDVIeGpmekg2?=
 =?gb2312?B?TVdVWThDT2lhYUNtRFpLZ1Z4VWlIQXk0MERwR21iSHc4bDJZRXl5R2xteWs5?=
 =?gb2312?B?STNydzE4alkzODdZaFU5ZUxFOWdXei9oeTNUMXFwSi9nM1FhenFZbkxvUUFS?=
 =?gb2312?B?NCtIcnQ4Kzc5YlZ3dTBJR2s0dk55dlNMS2VZTmpmMkVraDBRNXorUTNqazBN?=
 =?gb2312?B?d0tqZTZQazRvcll3S1k0dUN2VkVFQ2MwUm1lOTROTitQY1pSVWd4dmxFc3Uy?=
 =?gb2312?B?SzU0cEI2OUc0WnZXV1RUbVJmYlYrTE9INDg0V3AyUEVOcWhPcGs5WlRhOG50?=
 =?gb2312?B?blFqcC9aWm5RQmp6ci9zTjBJUnNCakltdzh3OUxFNy9MbE93aUtkRGZ4Yjlw?=
 =?gb2312?B?MEw5YUVYd1FCVUo5V2lnR3krUmxlSWFZNjRyMGllSVRWV0I3UFJLbWNpbSsy?=
 =?gb2312?B?V0ZTNzdUS0V5U0x4Wkk3NVVsMjBXRFFVRkVUZ0RYRTZobDg1UnI2V0ptdStX?=
 =?gb2312?B?NW5LSHFGTVJRdUtOaGIvYlJ4TnhRS3JKRGw5TUZycW1xWjlIZnhWS1k2VXFz?=
 =?gb2312?B?VHdkR3FlSGVIQ1ZmTXljWWtYTkVkY2liZUJ0YzNDa3RuQ0FvNWVlaE5oTlRn?=
 =?gb2312?B?cTR1TWxQYlNQczRSTm5aMnhqOWFJNnlUTjlEMEozbVY5SlVxbTZJOFpvTjBp?=
 =?gb2312?B?NkRMTkY5WDFUK0NLaDZkRUxoZkQyVlV3NkRZMXhQYSt2QkN1aEF4WnQ2UEpa?=
 =?gb2312?B?dEt4MFhFUDBCZW5nY0xuZ2hlQ3podVhSNWtWaDQwRjZlbnAwL1VONXU2WWFY?=
 =?gb2312?B?R2pUNldIMno3VHdiQTBlUkRnNkVoZFBXSFVTRUo3eHFwRFVubXh5ZGk4MU8v?=
 =?gb2312?Q?8tO+kRlxf76i0rMPJ2IPgL7Q/?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8304.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae6436d-d889-4c6e-5510-08dba90676f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 03:09:03.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68IDX/zgafRbw1+DXr4kivRYVIwgeiip+IFoFN/ViX4K085ZVltxE5cGE8JPY2es8nSPknVKrJOW22HZTdi6hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXVyZWxpZW4sDQoNCkknbSBub3Qgc3VyZSB3aHkgd2UgbmVlZCB0byBtYWtlIGNwdWZyZXEt
ZHQtcGxhdGRldiBhdXRvbG9hZGluZywgZG9lcyBpdCBtYWtlIHNlbnNlPyBBcyBJIHVuZGVyc3Rh
bmQgaXQgd2UgbmVlZCB0byBhY3RpdmVseSBtb2Rwcm9iZSBjcHVmcmVxLWR0LXBsYXRkZXYsIHdo
eSBub3Q/DQoNCg0KDQpCUnMsDQpaaGlwZW5nDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEF1cmVsaWVuIEphcm5vIDxhdXJlbGllbkBhdXJlbDMyLm5ldD4NCj4g
U2VudDogMjAyM8TqONTCMzDI1SAyOjAxDQo+IFRvOiBaaGlwZW5nIFdhbmcgPHpoaXBlbmcud2Fu
Z18xQG54cC5jb20+DQo+IENjOiByYWZhZWxAa2VybmVsLm9yZzsgdmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDIvMl0gY3B1ZnJlcTogZHQtcGxh
dGRldjogU3VwcG9ydCBidWlsZGluZyBjcHVmcmVxDQo+IHBsYXRkZXYgZHJpdmVyIGFzIG1vZHVs
ZQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcNCj4gYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWls
Jw0KPiBidXR0b24NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIwMjMtMDUtMjQgMTU6MzQsIFpo
aXBlbmcgV2FuZyB3cm90ZToNCj4gPiBNYWtlIHRoZSBjcHVmcmVxIHBsYXRkZXYgZHJpdmVyIGFz
IHRyaXN0YXRlIHNvIHRoYXQgaXQgY2FuIGJlIGJ1aWx0IGFzDQo+ID4gbG9hZGFibGUgbW9kdWxl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhpcGVuZyBXYW5nIDx6aGlwZW5nLndhbmdfMUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZyB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL0tjb25maWcgYi9kcml2ZXJzL2NwdWZyZXEv
S2NvbmZpZyBpbmRleA0KPiA+IDJjODM5YmQyYjA1MS4uZGRhM2E3OGJmZDVjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVx
L0tjb25maWcNCj4gPiBAQCAtMjE4LDcgKzIxOCw3IEBAIGNvbmZpZyBDUFVGUkVRX0RUDQo+ID4g
ICAgICAgICBJZiBpbiBkb3VidCwgc2F5IE4uDQo+ID4NCj4gPiAgY29uZmlnIENQVUZSRVFfRFRf
UExBVERFVg0KPiA+IC0gICAgIGJvb2wNCj4gPiArICAgICB0cmlzdGF0ZSAiR2VuZXJpYyBEVCBi
YXNlZCBjcHVmcmVxIHBsYXRkZXYgZHJpdmVyIg0KPiA+ICAgICAgIGhlbHANCj4gPiAgICAgICAg
IFRoaXMgYWRkcyBhIGdlbmVyaWMgRFQgYmFzZWQgY3B1ZnJlcSBwbGF0ZGV2IGRyaXZlciBmb3Ig
ZnJlcXVlbmN5DQo+ID4gICAgICAgICBtYW5hZ2VtZW50LiAgVGhpcyBjcmVhdGVzIGEgJ2NwdWZy
ZXEtZHQnIHBsYXRmb3JtIGRldmljZSwgb24NCj4gPiB0aGUNCj4gDQo+IEl0IHNlZW1zIHRoYXQg
dGhpcyBuZXcgbW9kdWxlIGlzIG1pc3Npbmcgc3VwcG9ydCBmb3IgYXV0b2xvYWRpbmcsIGNhdXNp
bmcgaXNzdWVzDQo+IHdpdGggQ1BVRlJFUV9EVD1tLg0KPiANCj4gQmVmb3JlIHRoYXQgY2hhbmdl
LCBDUFVGUkVRX0RUX1BMQVRERVYgZW5kZWQgdXAgc2VsZWN0ZWQgYXMgPXkuIE5vdywNCj4gQ1BV
RlJFUV9EVF9QTEFUREVWIGVuZHMgdXAgc2VsZWN0ZWQgYXMgPW0uIEFzIGl0IGlzIG5vdCBhdXRv
bG9hZGVkLCBpdCBtZWFucw0KPiB0aGF0IGNwdWZyZXEtZHQgaXMgbm90IHdvcmtpbmcgYW55bW9y
ZSB1bmxlc3MgbWFudWFsbHkgcnVubmluZyAibW9kcHJvYmUNCj4gY3B1ZnJlcS1kdC1wbGF0ZGV2
Ii4NCj4gDQo+IENvdWxkIHlvdSB0aGVyZWZvcmUgcGxlYXNlIGFkZCBzdXBwb3J0IGZvciBhdXRv
bG9hZGluZz8NCj4gDQo+IFRoYW5rcywNCj4gQXVyZWxpZW4NCj4gDQo+IC0tDQo+IEF1cmVsaWVu
IEphcm5vICAgICAgICAgICAgICAgICAgICAgICAgICBHUEc6IDQwOTZSLzFEREQ4QzlCDQo+IGF1
cmVsaWVuQGF1cmVsMzIubmV0DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGYXVyZWwzMi4NCj4gbmV0JTJGJmRhdGE9MDUl
N0MwMSU3Q3poaXBlbmcud2FuZ18xJTQwbnhwLmNvbSU3Qzg0ZTZkZWNhMDlmYjQNCj4gZTg2ODU3
NjA4ZGJhOGI5ZGY1ZiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAN
Cj4gJTdDNjM4Mjg5Mjg4NDkyNDMwNjgxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9p
TUM0d0xqDQo+IEF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MzMDAwJTdDJQ0KPiA3QyU3QyZzZGF0YT0wMmlYRThIUVhITlhSaUE3U010bCUyQjVs
ZEdpVkRGJTJGN0d0TyUyRjBEdEFQMEVRDQo+ICUzRCZyZXNlcnZlZD0wDQo=
