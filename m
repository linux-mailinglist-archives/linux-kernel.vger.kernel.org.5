Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079FA78C946
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbjH2QBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjH2QBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:01:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253651B9;
        Tue, 29 Aug 2023 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693324863; x=1724860863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hzJTR3f/9AFI4djY2UyQBTnOB4YZrAbaPL5QfChHQw8=;
  b=CCARFP+9RzeAtJdxiXxhGENTEIObXDlqI67RSnatNSyY5qgIUHT6rP3t
   zSNrQUYYgtuKrS1Y3QjuNHjCG/Hv0drAkuLIWWCqjF0qeZC2XgzJXxgy5
   OAtCk9B3w3zf3lhaSXJxmdFy7RYBUKsvoz5oSbt4Cixxqk3Lg8M7oxMWA
   1eTgomgRT3bNiUAqkUuhIptgK76ahcTyqfbVPls5E62jZUGMhAXJwLQAC
   yRzCJ2Oc7UMTwfrTQNgi8YFMvhelsreME1VD/ARH0QmV6PGXz97Kj4crk
   ZnocjESnXibZA6IT1hJVhi+2Q8MNe5pmOAoVziF0YkWQQQO/zvR3ddvdf
   g==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1886816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 09:01:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 09:01:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 29 Aug 2023 09:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1h3g6jGWqrVVVDeofvxQsVgjrco71OlUdLWPYzP9dFeDBVPvfOTGFUQLYmPTUeSkaEoJazxlepYAzIk04K5J5yOIU4YIHAiU+SEpqtt2s6GXTO3tfuv91OguFdETJpMMBIAesDBCWn1gSBlmmWfB9tu3iDgs7BW+CfKm5a+fRBT1Z64/3BOCw28CoO60BIyaT/gSU6OUnV1AvR0kCJO65QouyrkwMiYepyiZUhRxldezS9wFMTVxvx3uk0Ql/+HbhjaY4tTCZpSRbLdicHh8IWlt6yf65G3axUR4j+ZxKISyNKBF5wmy1qdJEoVzkHBTLon3KLGNidjAFdAt30y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzJTR3f/9AFI4djY2UyQBTnOB4YZrAbaPL5QfChHQw8=;
 b=MKYVc5m7RQa91XCjksBqXM5ASjgohANUqo6XHVr5BH+/+emZs7FJPWv6++eranPBkBZi2h5JEtNsDYEKuB3kwkOdYiazEOeklL1/YTra0kmqiobuKQMxO44/5IeRC18G01ircOl2X7qSRRET9cLi/Z2Wyr6FvApEOwRZ3ThVQV5s0rNZfR7GXsZ4+qmh/ZVaonxq+vKWG+peVIVbjk5qY9Zr1ivbnA9TaAy0rYBRv+fLpC6D7UCsUztau6hmkRmxKiQeZi7aRvSQun50X9zM+G4WgBYkreuTFUzJLImNP7bS2AzYgf5YmO2X9Lhb8lLsGIVyavxqRk3dRvRDp9bUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzJTR3f/9AFI4djY2UyQBTnOB4YZrAbaPL5QfChHQw8=;
 b=srIRoJsJIEZgQcw5St/eBikKmxkA2w7mJ4/vb8cLpJ2PKnWwtRX36/LQHTr5VCOEi8ZJfGIKoKquxM15CitTqYOxa7zu5pbe93vXozMaabwSPfibkCD6imy3UQ2puwCKTkftRpXqJU2ZGgalTn9ADSsIGbyH0ExSYvrN2UFczSg=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 16:01:00 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 16:01:00 +0000
From:   <Marius.Cristea@microchip.com>
To:     <conor@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Topic: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Index: AQHZ2o9SDk1SI69KHkCZzOSMXZ1LCbABaq6AgAAEMgA=
Date:   Tue, 29 Aug 2023 16:01:00 +0000
Message-ID: <8db5512a9ccb0d4f3bb3b0e063c7b43e08e4dadd.camel@microchip.com>
References: <20230829154133.40716-1-marius.cristea@microchip.com>
         <20230829154133.40716-2-marius.cristea@microchip.com>
         <20230829-legal-superjet-f992cdab2bd3@spud>
In-Reply-To: <20230829-legal-superjet-f992cdab2bd3@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: 84433c2e-d7e2-4111-47e2-08dba8a92398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKfgXLqVlhaOCs6/MzR/yvJDVG2ePwowWB8UnVa3UnJQNzyTbZ4Fn9B11QW/7X80DXo3pMwCUzUbSKBrdfMuKwp9kI0Ns2JHlA/4q6HJVnT8PEksIZWRKv1uuJVVD/tbEDjRgSSfcnKC/SQB0QuM8U8d0Dz6VGpyRyB6rfPm+4n8mSIuoVKmgPcUjAmSIIT8Sxxk2Hzv5TmTo2njbcf8eJvO2upc/nr/6uqwqGbOWKYkdvs+X+irnqGkXluvzf3MHorOmV/NxFIAuTt4KSRmYjePjrCFiEzdHByTDkXjYZQDfSJXK+arjh0s+yJOuNJnyHhYGSlFG8o2H1atqa0bIfLloEXSahUUbFUoyJ5yxt2tpNssNpVHGMau7jLlayN/0g7z1StFlDnk0m2nFGZ7FiLbxNXJTbS4Okb3i7mIDKboVVlmTf2ENqhmaSmzvJSagmQWw9Yab8vKqFujMEqjFrwA2veo3T53vAQrhKmtsPVlBSU8X8bLULnWczr/loPfqv1okR6vC8xKNzeU4WnOfIxuUq5WX0nDdNC+sU74Lz8rJb/kUNkA28csFePzKbshjiOgCX24oRO4gj496YkeKgCfkqLAE3n5d4eETqdZwyU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(38070700005)(6916009)(41300700001)(4326008)(2906002)(83380400001)(4744005)(86362001)(2616005)(36756003)(26005)(5660300002)(8676002)(8936002)(71200400001)(6506007)(6486002)(54906003)(66556008)(64756008)(66446008)(66476007)(66946007)(91956017)(76116006)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzFldUJkSk9QcDgyUjhtT3ExblMxMjEvR253OXh6cmlwdGYrb2d6SjZ5ME0y?=
 =?utf-8?B?eDkvSGowSUVraG04L1RSK1ltVDcrdEZPVU9rUXRRN3QxbnlvLzdqZXAxYjJv?=
 =?utf-8?B?SlRzU043dkg4Z3Bwd0xtNUVQd0V0NFdhVFVDK3c5MGd3Wk9PeDM2azBjNlNh?=
 =?utf-8?B?bnEvQXpDY2VoQXJxamJPbDVGbmNxSmhVUUdrdm8yRDdFYzh6TXk2ZkZKbXVo?=
 =?utf-8?B?YkM0b0FHZDI4RnBBZU0wcTkySGMvSzdoTUUybUpTakt3WHpPSlpJUkhWRDdm?=
 =?utf-8?B?YjcxNkR6cTVUZ0poQ1V6b1ZDclJoaGR4bDBhMktmazFBUk82azBrUDhpRU9P?=
 =?utf-8?B?UjRSZC9jQVBKMEFsOUZuRDAyWlVBdy82dVI4NlFnSVlXRlNNL0R2dmNFSFZQ?=
 =?utf-8?B?NHNpdzVtZlFrb3lSVlh4Q2d3UjVHQ3NJazI5TThnUVlld1FUTG5SSEw3OHhu?=
 =?utf-8?B?WHVrWjVhTitjRGZwbHFwUzhndFV6Um5kcEs2WW5XVzM4SEhiazRCNGpkSHFm?=
 =?utf-8?B?SHhCL0dVd2VyUmNyMStFT2RYZTJ0b2RJaVlHVkZTbEEzeHlFaDZSQVpHYVlj?=
 =?utf-8?B?RlIzb2swVTFSNFQvZndodmNranhvSHEwOWhmc3pHWnVxbXd5c1Z0TTBybUN3?=
 =?utf-8?B?Z2RYWjlrV0NiY1IxOU81SWlaN2VsemxZbFBMZjQwOFBVbkVUeXk0WS9Ed3hj?=
 =?utf-8?B?UkF1c1Y4ODJXa3EwVU8zMmV6Yi9DM2c5anNSNDhqNzNtZ3dwMVJ0ZVo3YnBv?=
 =?utf-8?B?RGFGMmp0aDF0TjNQb3RhZ3o0dG4yNUM1KzFiMEtJaElGejliR2puaWsvQytW?=
 =?utf-8?B?OWxZbWdzWFVDQ0tQckhhc3RHQzIvNTNsZnhpNjNyWmp0dkNyMWRmWTdsVmRv?=
 =?utf-8?B?MXFYZldxbVNIUGc1d1pDd1M5M01PMEl4VzYxcTNxSGVnNHpTNmhXTU5JcDFX?=
 =?utf-8?B?SFJrT3NYNzk0MW11YnQrOG5ia2VoZndibWZYVHplemtNZUxSVndUK2FzS0tY?=
 =?utf-8?B?b3RIYlNnNk1HRWZIY2Nyb3Z6d1N4RCtwSnZnWFQ3Z3VjNG90bWxaQ2tGVDlI?=
 =?utf-8?B?RFUrcnJnVC8zOVJQZEt5N3plWGVhVkhtb3dIYmdGcmRlZHl3UHlUUm9zaDYy?=
 =?utf-8?B?bGEzU2VEcWtETU1nRmhpNHJUZnZEMEpxc0dtOERDdnltcXEyOUVBT3dweEpZ?=
 =?utf-8?B?QjZQQmVsWmNNOG8vMmxERmFLOURKL1FvTnlBSUVLOWNSS2kwaXhud01haXF5?=
 =?utf-8?B?Y0d2U2l2MXBhbFIzMmhjVmYydDZFNFdpVjVEb2FqajJEdDRpNFhPOG9sa3or?=
 =?utf-8?B?U0RCbjhrdFZZL0RlempSMXlJTk82NzFvZGhGSERKV0ZnM0hsc3FTc0ZjdTA0?=
 =?utf-8?B?RTNRamRCRk4rckFqK1BDaVFRbHZpczIrRDNWUnVaYWhVdXpqbFZFeVVVRk1Z?=
 =?utf-8?B?Qm5XTmlyWTVoSWdlRnB6TFUwVnNobG1UMFRYeGxBd3lqKzJxVlVaaVpyVjYw?=
 =?utf-8?B?Q1ZXNFU5dGxxS1dMZWFYcUFlc1lSSzBXSmdFWFBETktGRG9pT3JicTk5SHpm?=
 =?utf-8?B?clVFS0JnS2EwWElwZXFDTlNKRXJmZFBsYmljR0xXSWlYVGE1NVdaejA1V1Nu?=
 =?utf-8?B?YllWUkxOZzVMeDl0alRiTEVXWkZTN0kzZy9YeUhtZUN0dG1EVklDVGNNaThT?=
 =?utf-8?B?QXVLSWFnM2paTmJZbkFsSGRtL1hCMjZSUTFyWUxwZ0lRNUp4RTVadGVFZXF0?=
 =?utf-8?B?SjFtYlFZOEkzamd5UXhuWnJJc1Uzc1F6WW8vRlJVZ1ExY2JLeTRPeWJNNWp1?=
 =?utf-8?B?TDdHUTREWHcxZnBYSVN1RWhOR1NOc1RydHZSN2ZVRmNRYlQyUUR6MTVMaFky?=
 =?utf-8?B?OHZYT3o5RS9wZGhiMmtjYUtJcnQvRU9WeW9GK0JVTEpWQmE1SXRwTmNxWVBL?=
 =?utf-8?B?d1Vpa2hoY3lQd3VhKzFoSldjbTRVU0ptakZIVVU0NFVqcDFldDJmdGQ4NmpR?=
 =?utf-8?B?UFZKWkpQM2FLRzdwMzBpV1hSUEthOUJNakFiR2hUd0xrREl6VnluRVlZb0NY?=
 =?utf-8?B?ZUYzK3psOTVaTmVjYXN5VWYxQ0kxOUFySFc2RnBJRFB5STNZbUlVRjBTMGgz?=
 =?utf-8?B?K05mSjlZR29rc2tWL3liTW1sakJocVp6bzViajhrYkpocXZQV1libFdoMnFZ?=
 =?utf-8?Q?EHK1uYsioVaHMpbWeasLmS0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <951E024943FE2A4F9C0BA56254383250@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84433c2e-d7e2-4111-47e2-08dba8a92398
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 16:01:00.2298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozxfcH5RGYYrAjhdBeH68IWU3OY/QwP2Upc90hg6q3GjeRUpLr6BR71NnEH06SyQVkMuXi4a86RbVLXq8t7KNgQJwwqkftGwyMFmfZ3PF6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3INCg0KT24gVHVlLCAyMDIzLTA4LTI5IGF0IDE2OjQ1ICswMTAwLCBDb25vciBEb29s
ZXkgd3JvdGU6DQo+IE9uIFR1ZSwgQXVnIDI5LCAyMDIzIGF0IDA2OjQxOjMyUE0gKzAzMDAsDQo+
IG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IEZyb206IE1hcml1cyBD
cmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+IFRoaXMgaXMg
dGhlIGRldmljZSB0cmVlIHNjaGVtYSBmb3IgaWlvIGRyaXZlciBmb3INCj4gPiBNaWNyb2NoaXAg
ZmFtaWx5IG9mIDE1My42IGtzcHMsIExvdy1Ob2lzZSAxNi8yNC1CaXQNCj4gPiBEZWx0YS1TaWdt
YSBBRENzIHdpdGggYW4gU1BJIGludGVyZmFjZSAoTWljcm9jaGlwJ3MNCj4gPiBNQ1AzNDYxLCBN
Q1AzNDYyLCBNQ1AzNDY0LCBNQ1AzNDYxUiwgTUNQMzQ2MlIsDQo+ID4gTUNQMzQ2NFIsIE1DUDM1
NjEsIE1DUDM1NjIsIE1DUDM1NjQsIE1DUDM1NjFSLA0KPiA+IE1DUDM1NjJSIGFuZCBNQ1AzNTY0
UiBhbmFsb2cgdG8gZGlnaXRhbCBjb252ZXJ0ZXJzKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IERp
ZCB5b3UgaW50ZW50aW9uYWxseSBkcm9wIG15IHJldmlld2VkLWJ5IHRoYXQgSSBnYXZlIHlvdSBv
biB2ND8NCj4gDQoNClNvcnJ5IHRoYXQgd2FzIG15IG1pc3Rha2UuIEkgd2FzIG5vdCBhd2FyZSB0
aGF0IEkgbmVlZCB0byBrZWVwIHRoZQ0KcmV2aWV3ZC1ieSB0aGF0IHlvdSBoYXZlIGdpdmVuIG1l
IG9uIHY0LCBhbHNvIG9uIHY1Lg0KDQpUaGFua3MsDQpNYXJpdXMNCg0K
