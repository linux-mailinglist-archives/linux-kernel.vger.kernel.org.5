Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724867D81AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbjJZLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:18:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A41A1;
        Thu, 26 Oct 2023 04:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3RQfflJOonKjjqLnZnuwdmq+PrMB/mzG9cunm4jvtcKz3Y7yNbFjcGM5dwigReZtSoedO2PjKOS0//CR+CWiSs1GNI/vO2SOMTwAb9VcbufZw4I9ACXtmUpaojExxsNd/OiEhZyxKWEs7zY8nbHkgSa5mFHMBW6hqLkHiAZ+OqsivT0hW6dkmY7+hcABVy57A6AhwFkRHxWDjrR1Q5yfSFyxQ85mlS+qfYfL2RwIGeoK7HNoyATgFpNfbydABYMTKT3fP9Nz4P0cpvsocYG5Ma7UxR731raorR0WYOIXAe9jK0Fyd8V/cm5L1T/zZTd1amUOBTpS37Q0B6RbCUQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYorjR8lNtA4tF14ivx1TUl5zBCZyhQGFXlwFArlckI=;
 b=DTETNnhX0CIOK47L0oSzdJ4puEMEhKHM0NoxIL3EieDuH5ClJO478ronbS95JRVIodQnv7mwwe0H0l1kYTO26fAH0rtQvtheePcOJEwWSZJpSsOC+H6vuALMvIJNbwDBgRtfiYYgA/ZLbDoPoruMBH362FNuHzQKUQ3ATrTYlKByAFpHcNiHkhk7sk8VFgHl1OEE2fvVSJvtU2gVUh5vDXydOjy97GRvTRysEYXCYIQoFsjwGW7mSpEB5Nrkpe1PsAHiS0OqQe1stXZz7y06riviS4aBtj1aIP0G3zZX2gi04Vzjwx+tQoNIN75jy0fHOY/4HCAdxI8abJvupb8eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYorjR8lNtA4tF14ivx1TUl5zBCZyhQGFXlwFArlckI=;
 b=nditT8DSChXxvq1U01YpQGGtpYZGizYJ5PeBRQC6AMS2hatZi07P0LXG4AoMAHGZK3QIzlB7soLZ1OTmf7R2Km8AXUTzirhs/GkZGLD95K8YFHDEcJslBdQlpMQW/Hf9Vm+qnp3ogxlgH6a3/1M+y3l/W12CDV+ujQrGyRjvka4=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PA4PR04MB7582.eurprd04.prod.outlook.com (2603:10a6:102:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Thu, 26 Oct
 2023 11:18:00 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.008; Thu, 26 Oct 2023
 11:18:00 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
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
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 07/11] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v6 07/11] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHZ8T3sryJpFDeFrk6dlOZwOqPkRbA5OOwAgCLfbSA=
Date:   Thu, 26 Oct 2023 11:18:00 +0000
Message-ID: <DU2PR04MB86305DF657B0809B754F6F1895DDA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
 <20230927175401.1962733-8-pankaj.gupta@nxp.com>
 <f664546b-b287-46bd-9f83-34a571d0f512@linaro.org>
In-Reply-To: <f664546b-b287-46bd-9f83-34a571d0f512@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PA4PR04MB7582:EE_
x-ms-office365-filtering-correlation-id: bc5d9e61-5986-47db-9f41-08dbd61536b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vnk1iPgjqlxs7uwpBnk9QKEmMl5v5zdAhnef4IgPh4SiDNJgsM0nnuiBAWEy4JYngNB5qbowyapOKrAXgle/EjWYBr/qWK7d0ouK6Q6d1BluC1HFs6VF2ppEBoQ9+lwPSM8AO15c3ZazCUqg91A51Vq+jTe17qKdt6szkBq/Anyxku+fRde8ua6+kSfMN9dMDHiXjPIrK3b54pJ6bktAofa4SfRUnWFPLS/DYVBiZXg0WYTeOMG4qG8j32/ZH7CeBMbOcH38WPSG9ak3vaMX4hc1W5scK1kuXNTT+Qj45W61zlRzp4fdLKKTQITEAGvLE3xppwtzhsq/QUE6MnVs09brig67wLEj/5myp1ckJzTpG9PWdMeEuss+sR7R0Ipzdhg8UnY33E7DnifpOuNJlvNAtlFzgL4ZkMBDK8aavjzB11igbaHODxKv4Xx1i0vjdiNvJ4CpUlYPizwz7Erj22Qs/7xAsVTallmlfLpzHfwAHoPdg7UPZ6rgidD4b01dYp/5bKs8RqfCrVKjO0wRch2/o8fmmJwyZu1zv37v6deE/c0ShD3cUXkZefJ7SjTl8i5WkXWh0mr3+cR7wzMxoQKfSTc3bFggtOG5Ri8iFVtEODGBORPiPcOU/phr5xB1pSlyxoiIUIVEtTm0Y80LqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(122000001)(38070700009)(921008)(38100700002)(5660300002)(83380400001)(55016003)(41300700001)(7416002)(44832011)(76116006)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(8936002)(478600001)(6506007)(2906002)(6636002)(86362001)(316002)(33656002)(71200400001)(53546011)(7696005)(52536014)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWF2TWxUdEJON05HTXIzTytXdXVkN2I4VmQvRS9iMHVKRE1JUERLQzhyNFlk?=
 =?utf-8?B?Qm5yN2NuRGZTUkF4UjBEakNsZ25HNmlZSzRpci9sRlNhNllLYmFuMDRCYldq?=
 =?utf-8?B?RmdtaTVJZ2ZKYUQ4UTFEYzJaRmM1U05qSXdkQjFNMEFKVytabFRWT3lwL2Zm?=
 =?utf-8?B?MXZhZGhna0FNTzBLbFZHWmlZUHRkR3VqQllOTWx2b21icjdxKzN0RElnbEFR?=
 =?utf-8?B?bXhPRkRaVjdhYnczbnA5N1ZUUVRLeWk1SnZYZFpDWWE4R2NJaWo0V2JVTXlC?=
 =?utf-8?B?dTd5dzFCWWJIVTNTZnFEbmJnN0huZUh2WjkxdlBQcEtxdUcwdTUzRnZTOGlP?=
 =?utf-8?B?QzZCcDZieUF3WTZ6amxUd2Y0YWI0MVAxbUQrcmhUTmErTHcrWXNlOU5qSHpV?=
 =?utf-8?B?ejNRdi9sSGVQOExuT2tpZUFaS0ZhQzRVdlZzckxha1hHTE81ZHZBM3E1SndB?=
 =?utf-8?B?T3ZXcXQwTkdpMkZhd3hGY0JoVnNTc2IyeW4yb2RzcXZjbGRRNklvMmFobFRk?=
 =?utf-8?B?UDFpUXBUc3R1YmpXWjFGMncwR2R4RFpiM2E4U20xL2JsbnF4Q2RFMkNwUXd4?=
 =?utf-8?B?RVVXTEp5b2lWcDRrWjA1UzlUTGo1NWw1MXRuNXFGMHdIcXV5WlNUVm1HbDRI?=
 =?utf-8?B?U3d4Y2Y4emFuWmw2WEE5VnY5b1BLL05OOFdDRUlnVDVoa0JWYTlTcG0xeGo5?=
 =?utf-8?B?YnlxQ2huUTFvY1dRNnpNeDA3SnZPVVgxTnRZc2hScW44SDVKcUZsSEdBRU1y?=
 =?utf-8?B?aVFNenB2R0FLT2ZoRVh3OTBpZGlGc2hIVWMyQndDaDlFU3dPMTRraHFSTkxQ?=
 =?utf-8?B?UGY1STBOeHNVdlVaUHdPZUhRVGpYTHlYVjhkdWc1TzFoSldSallERDhseTZK?=
 =?utf-8?B?VXdYR01WL3NWSHhKVllVM1lRY1kwT3dWV2tMbHV5V05keFREb3YzUlhJWWpO?=
 =?utf-8?B?K1krYTg1eEpzcWVQUkRaelI1VHpCYXhSdTI5UEk2YWh6MFEvWnBSZFdaeSsv?=
 =?utf-8?B?TDZZTDA0aEFub0FsdTJaNENPS0Y4MU8wdG5PQWJNbjE0L0JkeUtiMldkeERH?=
 =?utf-8?B?M1FraGpzOEo3U0xZU2E1RmU4MU92VkxMMC9CQWJSeC9hREd4RVJaa29Wc2VM?=
 =?utf-8?B?MjN0ZTM4TmFlVHVFK2hRTjBYekY3Qy9rSlM5R2xBZVl0ejJlNENhUitzd3Vx?=
 =?utf-8?B?MUZnT3kwUjNTSU5RaDE0a1lGVXZBN0tqdDk2TkZBT3hSWExzNWx5REdqOHVn?=
 =?utf-8?B?Y0wzcVVsL2dHWXQ3WW0yWkp0SjdlL0ZXL3RYOGsxczBhZWJsR0dHUkxBSXR1?=
 =?utf-8?B?aVU2bXNOZlVYOVEzM2FrTjM4UVRpTHJKRTdtK1NyRDQwSS90bFhIbHVLaGk3?=
 =?utf-8?B?STEyaTY2MEV2SFoxQ3FqUnZWTU5KN250MVJpMGlFQXNIRlJ2N1o0QWFDb2pU?=
 =?utf-8?B?Z2FZeWV5eUtsQUNkVDRFa1VueEp0L3VOM1JSeFI3dXRTalNOSldzQmpxVjlP?=
 =?utf-8?B?akVQTGM4VTVoRG5vUDAxYlRvTlR6WExLZFp1b29qRUV5bjVTb1JLOEtwUDN4?=
 =?utf-8?B?ZzFmdUt2dEFXQWwwZDhxcHh0NGlveTJxOUcvcTladUtJVzNxTmNmQ3lxdE45?=
 =?utf-8?B?ZnYxemd0STNaMGJCNGZBQTJtUG9sYzlNT1JBbWxxRHZJM014VGF2blVXM3Fl?=
 =?utf-8?B?TjJROEtMd1NZNUZnU3FNcHFlNWRua0pjWGZqdFJML3NZczdleDVwL3FqTm5a?=
 =?utf-8?B?aTZKVFBTU29uTjcyZG5Ga1dyQ0tZYUp3OFp2SmpiaEgrQ1RpeU44M3paVkxx?=
 =?utf-8?B?VUhjRmRkQmU0aTdHSWczNzRoMWt6cUVqS3Jwc2lsYkVBcEpRMGNlVSs3UFlp?=
 =?utf-8?B?NDYvSTE1eW9YbExVUnpHai9RR1ZmRnBlNWFabFM0aWxGcVFEbUp0WFJST2Fk?=
 =?utf-8?B?Y1pQYjV3U08vam93cXI0R1BScmZVMzZXK0VUMnM4SlZqV3dxMmVWZ0FsRmli?=
 =?utf-8?B?Tm9FMEpGczhlZEFTMjg2djBlVEpFcm9DMnRkTllHaVpzRng2TXo2eldFb0dR?=
 =?utf-8?B?MTdnejRMdUdwY3VXdGVYYVQyVElkMXB3VTJLS0lCM1FCNkVTQStkbjdRaDNK?=
 =?utf-8?Q?lHuZmOmF2P+ykvL5mNWMS+ly/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5d9e61-5986-47db-9f41-08dbd61536b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 11:18:00.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7v2vPRcnajm2o1wP81lNwxDNiq2mPKS+5vkZG821sKLgxPvxcfFuSRd+F14IklNdU7/Jt6wLbViluyEYuoEywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgNCwgMjAyMyAxMjoxMSBQTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3Vw
dGFAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgY2xpbkBzdXNlLmNvbTsNCj4gY29ub3IrZHRAa2Vy
bmVsLm9yZzsgcGllcnJlLmdvbmRvaXNAYXJtLmNvbTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC0N
Cj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+
IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBs
aW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdhdXJhdiBKYWlu
IDxnYXVyYXYuamFpbkBueHAuY29tPjsNCj4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNv
bTsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQ
QVRDSCB2NiAwNy8xMV0gZmlybXdhcmU6IGlteDogYWRkIGRyaXZlciBmb3IgTlhQDQo+IEVkZ2VM
b2NrIEVuY2xhdmUNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBs
ZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1l
bnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQN
Cj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMjcvMDkvMjAyMyAxOTo1MywgUGFu
a2FqIEd1cHRhIHdyb3RlOg0KPiA+IFRoZSBFZGdlbG9jayBFbmNsYXZlICwgaXMgdGhlIHNlY3Vy
ZSBlbmNsYXZlIGVtYmVkZGVkIGluIHRoZSBTb0MgdG8NCj4gPiBzdXBwb3J0IHRoZSBmZWF0dXJl
cyBsaWtlIEhTTSwgU0hFICYgVjJYLCB1c2luZyBtZXNzYWdlIGJhc2VkDQo+ID4gY29tbXVuaWNh
dGlvbiBjaGFubmVsLg0KPiA+DQo+ID4gRUxFIEZXIGNvbW11bmljYXRlcyBvbiBhIGRlZGljYXRl
ZCBNVSB3aXRoIGFwcGxpY2F0aW9uIGNvcmUgd2hlcmUNCj4gPiBrZXJuZWwgaXMgcnVubmluZy4g
SXQgZXhpc3RzIG9uIHNwZWNpZmljIGkuTVggcHJvY2Vzc29ycy4gZS5nLg0KPiA+IGkuTVg4VUxQ
LCBpLk1YOTMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogR3VwdGEgPHBhbmthai5n
dXB0YUBueHAuY29tPg0KPiANCj4gV2hlcmUgaXMgdGhlIHVzZXItc3BhY2UgdG9vbD8gUGxlYXNl
IGluY2x1ZGUgaXQgaW4gdGhlIGNvbW1pdCBtc2cuIFdlIHRhbGtlZA0KPiBhYm91dCB0aGlzIGFs
cmVhZHkuDQo+IA0KSXQgaXMgaW5jbHVkZWQgYXMgcGFydCBvZiAiRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zZS1jZGV2Ii4NCkkgd2lsbCBhZGQgaXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRv
by4NCg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3NlLWNkZXYgICAg
ICAgICB8ICAgNDEgKw0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9LY29uZmlnICAgICAgICAg
ICAgICB8ICAgMTIgKw0KPiANCj4gDQo+IC4uLg0KPiANCj4gPiArDQo+ID4gKyAgICAgcmV0ID0g
ZWxlX211X3JlcXVlc3RfY2hhbm5lbChkZXYsICZwcml2LT5yeF9jaGFuLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnByaXYtPmVsZV9tYl9jbCwgaW5mby0+bWJveF9y
eF9uYW1lKTsNCj4gPiArICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0
ICE9IC1FUFJPQkVfREVGRVIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIHJlcXVlc3QgcnggY2hhbm5lbFxuIik7DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgZ290byBleGl0Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcHJpdi0+Y3R4
cyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZihkZXZfY3R4KSAqIHByaXYtPm1heF9kZXZfY3R4
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4g
Kw0KPiA+ICsgICAgIGlmICghcHJpdi0+Y3R4cykgew0KPiA+ICsgICAgICAgICAgICAgcmV0ID0g
LUVOT01FTTsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbCBhbGxvY2F0ZSBt
ZW0gZm9yIHByaXZhdGUNCj4gPiArIGRldi1jdHhzLlxuIik7DQo+IA0KPiBTbyB5b3UgaWdub3Jl
ZCB0aGUgZmVlZGJhY2suLi4gSSBhc3N1bWUgeW91IGlnbm9yZWQgaXQgYWxsLCBzbzoNCj4gDQo+
IE5BSw0KPiANCj4gUGxlYXNlIGdvIGJhY2sgYW5kIGltcGxlbWVudCB0aGUgZmVlZGJhY2suDQpJ
IHdpbGwgcmVtb3ZlIHRoZSBkZXZfZXJyIHByaW50cyBmb3IgbWVtb3J5IGFsbG9jYXRpb25zLg0K
SWYgc3RpbGwgbmVlZGVkLCB3aWxsIGNvbnZlcnQgdGhlIGRldl9lcnIgdG8gZGV2X2RiZy4NCg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
