Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F075EBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGXGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGXGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:39:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C910C0;
        Sun, 23 Jul 2023 23:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiRQa1dchBawftYIUR3MnP6+89Ld8KddclrwVN3PWxGchkq1VsXgPOVjmkv7V13eCdPjpEMqu1JFSBsg/VXu0ocrtRwKpQxM3yZbvo7cvECeVT0MlpgujtxVmbmADPMIey1CYVtvHLwnw90QOjlrbqVfoy4//l7SPFczQE8xjQU73aWemV8OirB9PWl8NIOysQlYfgIGanslA8sFjlA7bHkHV/WBekKyfU9ET8wDeoeKQGuuid/VVIMjEfYZfUMU6A6oeQzMV5lzMDvH8nqfxtsM5W9P++ZY2yyu0ZpkHVaidG6GXGJZuoFIsTPjKof3NJBq5vM+ob2CCIUzzbcuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD9mPzn6Ni/nCow/oKM8subwXhng1v6p7D/psqVEJyY=;
 b=U+jJI2OjUJRsOEJqakGtIj3Apk7kjsqWWJu2ZeBkKaH/fDUkLz3O5UsMD1G/fQ3CZaA9olryc2Ypwzco/IbqCU+uR9UycR96qrXwgfSzFuNYnF6DpPZWm44qZAuDvFVH5b/6GzIvOSXCPdA3wa7pVveEQs0LaL4bwRotW70bdA1Zw8RWgqlRivDFL8LkanQ5rr1y4cLAu0t0PfdcV2iyM7MrHokXOBwow9Tk5Odlk9rZ0mo/5xoZbwMhM/d+XsXHNDq3WhFoQYx8lWcGc/sYZdhX9wYKrI4IAAwYeMrQOo++KwdhEsILMQZv3Njqr4a3OVp5OQOoMW1xnmrhulURTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD9mPzn6Ni/nCow/oKM8subwXhng1v6p7D/psqVEJyY=;
 b=M7ZNnA5AOqCzlv9WfvMhaW0iXJq/6paExBEK3FKJspxo/J6rmZXv1MXFYFxv8BPmS2hmutpIgmCnL7s0scVoYL10DlYQXRPV+ANqggMkZjP3o5rRKwSlMvI5rnr2DBGn+1U6BiymmPR/iLt6DPvejwLVnYiK4RtN5RGhF0FsleE=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 06:37:31 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:37:31 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Topic: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Index: AQHZoFASKHuzjH0W/kSFBShO5sZzaK+NajCAgCk2AgCAEge+cA==
Date:   Mon, 24 Jul 2023 06:37:31 +0000
Message-ID: <DU2PR04MB8630BD44DE9B4CE902D26DB69502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
 <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
 <2517e06b-61b0-baa5-cfb8-72d0b05a780f@linaro.org>
In-Reply-To: <2517e06b-61b0-baa5-cfb8-72d0b05a780f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS1PR04MB9333:EE_
x-ms-office365-filtering-correlation-id: 2fc8cc3c-ceef-4451-df17-08db8c1074ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MqNTr2bG1ri1/k4IhT3+k4AAu9hTsGgLRb5muMuMk1fzmpsWDAw6dBhRrZZAamz1rjMEObwtRjywLSWLR/0uVoAysyNGNTQ2hgzfZyo61KszhFCE0tTX6PDIkL3Yqc9WV6ZjRABy3OsvKxWlXFV/CeARaA/LJtOW7vfdSO8KChIQyPHkT5vEc+FSnGgA0LSmOjeWwk9VYSsD9dYsKAHtasGn1CbjdPOkLuRzrvTy1J6t1aUMaNIuTLRiTSGraDiUfOWanbyDLefI9BbmYeLnFZU7AlwIgCusFXFGbPd8L43Z7f+gLC8k4kbE1iEtbCLNJuRrvgnTKzR7HMxCl75r/D0qLMhpgtteeNpPEk2dltfa4FVbKx65menKqlcvPQy3RoAu5xOSvl2+cA/XzyRIySA6PnZEFb3wW/YcCip36KkJ9lxi9BVk5f9bNyVYkeKZZ2iZLFuekdaugQ3T8kzUOyGlgg8n2zsqssQELL9mt32iCH2E1d1Sq0KWaVFMNX5oXqY35Dfx+y2o2fKNA4+nZj9Kvc0DXVgVoEJoxznQfuk27TFveuCVI+2J8rcG1F4u0UwJvtJVIcdk4u3JZnyFOIB6wqCoYM3kWxFiGA7POPCUEzYXdeCZxFYGSKRoSaE97gL/9KgL6w7aePsr6WFC/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(33656002)(86362001)(38100700002)(921005)(55016003)(122000001)(71200400001)(2906002)(7696005)(9686003)(53546011)(186003)(6506007)(26005)(38070700005)(5660300002)(41300700001)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(316002)(6636002)(478600001)(7416002)(8676002)(8936002)(52536014)(44832011)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azVLaTJCRWJ0WEVkTmN5QU8zWEZQRW5NMVFjNUU1NlJUTVVEalVRTnpXOEFH?=
 =?utf-8?B?UVNlMHk3Z3U5dUhPdUtNaUY3UXZSdHdEak5YaTlHZGg4Skc0ckUwb3o2d2FC?=
 =?utf-8?B?ekdBQ1o5WHVIbjZ2L0IxQk5WYklta2tlcngvb2JNWDZHaG5GaDNya1UzYlhB?=
 =?utf-8?B?bHJIMTNTMkEyU0huMEdZTEdvZXVuT1R1UFV5VEhDakFMd3BJNFJTS1VUdkZ3?=
 =?utf-8?B?SGNBT3dtUW9aZm1RWUU3Wkw5RThabDUwNUQxYk5UM29LaEpnZXRaYTdJR01j?=
 =?utf-8?B?ZU1kQ1JtckhCcndsU3pITHF2bWZRazZYUFFHNnRCYTQyVlFPVTU2b2ozc3VY?=
 =?utf-8?B?N05zSUtJVTRmRnBibmRlUHNmOG1JSTV6ZVRLd2xqYWNuMll3K2JyVU81eXFB?=
 =?utf-8?B?aGwrKzQ3STlFaDRQd0oyQVFrVHZReU91Q1d0MjBCVFVTWEdQeWNHbVd5N3Zk?=
 =?utf-8?B?amdTd0ZWak1EQUJtTERCb2w5ZVJEK3RRTlRuMnFwdndBVnNVU2hnN2hxaUJB?=
 =?utf-8?B?VWttMlNWaDlnMkFGZDIrOWhRb2NWaWl5Y0xvRWZRMGMyRmd5bmtQQzM5RFUy?=
 =?utf-8?B?T2Y4NGlsNGVFaFNkbmZWZmVDWEk2VHB5RWtMVlg5YnVRajJzMVRCS25GYzdy?=
 =?utf-8?B?bXNkSjhkQXk2WXVMY3J5R3VDZ1hUY2lVUDcwdG0xUURLTkpyc0tOTnI0SUFw?=
 =?utf-8?B?aDVBbTVvbFZyb0QvWUovb2V4VVhEajVJSTVvejFjVzJENG9waHRvUnBFMzhO?=
 =?utf-8?B?R1MxZzA5eWE1SkR5SHBGZisxb0svZjlVSFNBd3BPeENYRzZEakgva0RVM3h5?=
 =?utf-8?B?ZWxxQ1JZMlo4NjA5cGxxd0lDVHlSMTl0d0V5RWRaakNsdm1oOVp2YnNkcHFk?=
 =?utf-8?B?Q0s1R0Rmc2JzMGpOWUtEWjhNLzczNTJnbVZoQXorOGkvRE1uWDZCSkxvQVUr?=
 =?utf-8?B?T2tlSlgrRTAvRUx5VVlubXF3T1pqRnBuYVM4OXhoY0lkM2lVOWFVT3NWbnly?=
 =?utf-8?B?bTgwMFUwN3Awa0x5RGxFUEZURGJDSWFLMVZwZDI0eG1LL09UTDhrN1hqeEtt?=
 =?utf-8?B?ZGdRY1NLenhJeXBrWnppcmorcXFtVGVUSFdUTldNVWJJWGR3UHBUL1k5dVJx?=
 =?utf-8?B?LzFCMmM4L2w5MEJEMUJvaFZKZGNMOHdhOFQ2VmMxeEVMbjRiSWlaNzhod0RZ?=
 =?utf-8?B?LzVsL3FySW80UVUxZVBqckJaamZJZHpLU0VlNDUzeVAwRG5ENi9qQjJxV3d1?=
 =?utf-8?B?ZnFkMUtONDZXU0RBMWRRb0tjaDR5ZXJTTm1yV1F1bEV0d0w5dTZoMmNjQ1U2?=
 =?utf-8?B?VmJPZHMwTnRsaHpFMUJwU3FwS0JPUUJYdElKblNwbkZuMHdybXFYaWVTVUtD?=
 =?utf-8?B?SWFyaXoyM29kL3llTDNGMXJWMGRYbkJaUXpqWXpqTU9NL2lURmpzNHlNVWRo?=
 =?utf-8?B?eHh0d1BabnlvMm52dzJpUHJJaEoxdHQyRnZsVEhQME5rcWdpMENibkZtdnNH?=
 =?utf-8?B?Vjh1YnNPcnBPZHo3RWh4a1VVcFl2dDZON0c0c255SURlZUJUV0M3a1pDSGNK?=
 =?utf-8?B?NGtPc1ljbXRmaVFybVJwRWV6NnVjbUVPTGNtVmh4anJtRGxVTzhPR2h5NXVZ?=
 =?utf-8?B?TzNKQkdJRVdnZmlwWkpoN1c0amZEVjVpRGlxcDR0TzBXOUEvZDhMdC83WTZu?=
 =?utf-8?B?MTRlRXBVaFJBUDFRYjY2ajZnZFJvMk9lbFFBVjJWZTVmakhCYTBiNGJWd1pz?=
 =?utf-8?B?WnFWbk5FdHliQllVNlY3dFgvVWM3TEdrRldIc3NFbnlad2RzUDRlblJ6cEpk?=
 =?utf-8?B?L04xNUpMNHZMc1FIenZ1ZjJwU0hnVG9mOFZpdmw4a3JoZnFHQW5xd3VaelQz?=
 =?utf-8?B?REZNNk5xV0dvK1NUdU5WNjZLMEIwNHBOR0g5bnQrUWtlcW81ZEcyYm1WY0tr?=
 =?utf-8?B?ODNEc01XcU9FNGRIOUwxejdxVW1WYXJsOW43VUd1dDdlWEg2aTBReXRaekFz?=
 =?utf-8?B?aHRKRTdxa2k5aGY0S3FZb096SXZ4Y1BReGZoay8vSUZOcUtWblFwNTExQWdE?=
 =?utf-8?B?Y1NwOFRVM2l3VEZLZ2pvSTJGNitQc1phbkJGenpyZWdVcWdPcDVidTJKRVdr?=
 =?utf-8?Q?aV+nTOe7WrvkdZ7mD0YfRTwAs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc8cc3c-ceef-4451-df17-08db8c1074ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:37:31.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrXLnuh7Gcatiky8KZIjl/sQXKsdFy9kzGCag29CB5RJ9jQmwy8YTIvqfCKX5GMYV4bsFBANJbKsazcdhFIn4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAxMywgMjAyMyAxMjoxMSBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFA
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFt
QGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IEdhdXJhdg0KPiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KPiBT
dWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYzIDEvN10gZHQtYmluZGluZ3M6IGFybTogZnNsOiBh
ZGQgbXUgYmluZGluZyBkb2MNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1h
aWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0
dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdS
ZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTYvMDYvMjAyMyAxNToy
MSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4gKyAgbWJveC1uYW1lczoNCj4gPj4g
KyAgICBpdGVtczoNCj4gPj4gKyAgICAgIC0gY29uc3Q6IHR4DQo+ID4+ICsgICAgICAtIGNvbnN0
OiByeA0KPiA+PiArDQo+ID4+ICsgIGZzbCxlbGVfbXVfZGlkOg0KPiA+DQo+ID4gTm8gdW5kZXJz
Y29yZXMuIERyb3AgYWxsIHByb3BlcnRpZXMgbm90IHJlbGF0ZWQgdG8gaGFyZHdhcmUuDQo+IA0K
PiBIb3cgaXMgdGhpcyByZWxhdGVkIHRvIGhhcmR3YXJlPw0KDQpBbHJlYWR5IENvcnJlY3RlZCBp
biBWNC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
