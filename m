Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA67D857C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjJZPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjJZPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:04:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531731AB;
        Thu, 26 Oct 2023 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698332677; x=1729868677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pMwr4ANvednoHdsXGqmhyesaOBvLIYycExzB+MUagGU=;
  b=IVeOVnhejaID0g7e07pW6XOwPC6OK5nMhADtC/bjOeryhiMYAt0aXkBo
   BV6jqDdeR5SFjJU+0R1IFygBqRSNbnuXjSkZ9rfUgO3LePKt93vVxPM4X
   +T/6XS98+S0XevMnRdHHto+VEPlwKyf8bd/cuok4iUJ4VSMj4WaLMUebs
   JDAO90dnEhiOLs7tDdQby/bVmy9MczIAZVf93WQsSEklu2PAw3SBXkUZa
   hJa8mVxvfjAERbIbQEs+4Ik/1eLAUWinMkBiiW2cHxjLWDJjaRvQCjJFY
   R0Myyi9N2hYBn4SuUEr6o5PQaaTeGBPQyXxhNlisWGyhSd8UQ65M7Q4nr
   w==;
X-CSE-ConnectionGUID: KaU2AMuxQlai+mDd6vxTXg==
X-CSE-MsgGUID: dy0EayemQSam8FS7J9lmiw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="10645963"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 08:04:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 08:03:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 08:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KweqmeAtPXucmR/fQTpAkyD3raS/WvSNxxe7GB/kOJKNx4YFySbxlLHZEW9gPRg1Bw4ftsn6CFqFlJw86KGRMwKLDU50v+MZOLh/Wtj7RR4ZxfmOxCdWAeh9DDrTI0apMUTnx06ECjuzIezmkDEj28uBEwfo4inEuISm7/PZhL+k8WCdciYNkQkaWu3JiM23uYcmXIv9OSl7/KTbXBXiKR/nkCHqNmxrMNSMcdb694VoXRMi7IBxGV+5/mKQ+CdGvqCTOdg3BwgB88+fjoxEJGArLezAgzQLIeESgcy2mTLNQU6tbhr2Oyt/Jq3JdWAv+z/hzAsAwgxb7uVlqRvNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMwr4ANvednoHdsXGqmhyesaOBvLIYycExzB+MUagGU=;
 b=jHhv7BZrA1O7CONS0ULJpmnMCzbM71UnuWDyws5Pl5H+bBar/IeQdYFaW8S1XuDRzCvTPfe/HBFq52x3joC5EUf1pjaXgpdDxPhXtuAAKGEo653JAbswO0XM8c7GGSzBzQ2UI3X1hnQ4IP6g/CjgQS43WWS7DgfEyFFgtztzzOLwZwUe958YzfYdmQiociCjy2pvtqUNHFoj65gEXYXG2RUKJ7KHvHvFz+oqltXvS4xcEVMuyVj0tXUZI1dzeBlq6UeJOywUpUzkE8g2HC0zk/GWG1zXx0VBE7hRcCKVoKA4yYL/3HFkI27js3WIu1F/6jOX90s3ZHSMivDLNm4/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMwr4ANvednoHdsXGqmhyesaOBvLIYycExzB+MUagGU=;
 b=tjbvAPhIHoyFjnJQ4XegSpl8BsyDm/4IidOpQdWywFmakMDrsMf6eH2+eBy/CK6YKKQdtJG/1p/EAAzw6PgToOhZBk66Po+M0ppCi89j9lgNWb5i9UHGxPlW8jZkZAvAWJ3knlrxyKqsnBJjBagdRK/qXgFHOERmzRz1od6qEkY=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by DM4PR11MB5471.namprd11.prod.outlook.com (2603:10b6:5:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 15:03:44 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 15:03:43 +0000
From:   <Marius.Cristea@microchip.com>
To:     <noname.nuno@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Topic: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Index: AQHaB0llG35Muzqel0+JxBePU2newbBaky0AgAGZdIA=
Date:   Thu, 26 Oct 2023 15:03:43 +0000
Message-ID: <02ea54ae3a2ab4f0a19232a4df494f71b1de3b00.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-3-marius.cristea@microchip.com>
         <d914069815f76245ef91b6b7b0c6b382b054b562.camel@gmail.com>
In-Reply-To: <d914069815f76245ef91b6b7b0c6b382b054b562.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|DM4PR11MB5471:EE_
x-ms-office365-filtering-correlation-id: ca5b6857-e555-4818-ce5b-08dbd634bf20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRVgvOKPMlxC1XoEBUb0OknYx5NDYOfsyGcihWBVg10wTbKzBMG8J4NQIdzNC8pCadbh72iTn3mLRfjmNE7j39zi763CjJCe/2367QAsnBNJ6K6WqJSl6e5o54Re35NCr4vS8+dIEST9mt6Rps/AQR93zh0xkMQX5ISiHmdFdswrDYwtMxO5Yd469wgl0BErjvR2tVwxsAO2DzhBWqJs9YPbpR7g63nTfFODuXXExJB+lPfgijacYcmJEz0NeADKOqMI+UfhYfpfNdlD4Bi42af3D1vh9MW8mNpk1L4jtLYNYCh+DWyp+a9E3WPiP3FV3ggBkFImMDmcWOTNyz20k+UVrkcIC2aBu6ALehq/AUEam0JxREewc4/AhiXW59Bx5xbpc3kx+L1SXopsEQ6qJ6vCKHTrC0rKM/guwbCMI/aWp4cyfPliDm33jYAHtu1nTCuNx3rA+8Oepyy1MHSC319GvZym+UQ0zwq7WlIC8to3dbkyWLVUVLQnXzTCfuo5FFvQAFdNXiGRpiMnnZQMRRhEr665IypjXsjXSYzUl86UF2Eq0Ou/mdMJ01oAdJMj2DQLX/OeXXAko3oxgz+IKlSVYMIEyvpn9FSsEqYWh9j/2GU7NUDtPMYKcaRUB8V5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(2616005)(26005)(38100700002)(36756003)(2906002)(4001150100001)(38070700009)(6506007)(6512007)(83380400001)(4326008)(91956017)(66556008)(76116006)(66476007)(66446008)(66946007)(64756008)(54906003)(86362001)(110136005)(122000001)(8676002)(41300700001)(8936002)(5660300002)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZHaWRtSHlIMGlsNFdldmRFOXR5V1RkSXorOTZsWHI2aVFtUkZiWGVBQUdM?=
 =?utf-8?B?SGUyejdJSG0yRGxldHpqSi9DcnF2U0ZSR3VRT01OaEV1YXhnSnBQTUZEQ0cv?=
 =?utf-8?B?aHlKc1VNUG9WNVFubmZIV09ZRExRL2FvcXRqUlRNaFBGYnZscWFFMFhrNGlm?=
 =?utf-8?B?N1hlM2dGdHg5b1RRTHF5Wkt5YzBhRUoxNlM0Z1czL3lDTEp6RVh4NHUxamxW?=
 =?utf-8?B?THZYc3dtdzM0MFo4TmN6SWZ0eHMyK2dFeTFXSFIyZVNZYjl3ZFRiTHdUYzM4?=
 =?utf-8?B?SnVsM01YdHJmVjd0RWFFMkZDVkFGQVhwUUpNZ2JSVEJtekRWTmpwN2J0QU9I?=
 =?utf-8?B?WEpoZHdMZ3UwaWxYWVVNTW1kenRpTEd4TmxVdHpNMElXc2RVbyswem5nbU9V?=
 =?utf-8?B?WGJFM2FtTFpWMGxqUTVzNWZoK25jSHN5RHZkRmRnTFJRNHZoYVF1eTRuZVV3?=
 =?utf-8?B?NmRNNGFoOUhYWTJPVzIyamZiR0xxT0RJR1Byd2RTeG1SSUZoeVlCRXdKeDhK?=
 =?utf-8?B?ZlB1WUJoT296Sy9LUWp0UlZpeDNIWXZ0YUtndGE1SmJsRHNFYmgySmR1YlNh?=
 =?utf-8?B?NFhYZG92WVBhU1ZOSWphMHY3Y2FwSTRvZHE2NUJ3eExjRWtTSUJDL3o3ZGtP?=
 =?utf-8?B?YTNYR1QwZ0ZKby9XN2s4ZDk1aGlnMThxelpsT3ppdnRBSUR0ZnNSUFRBa3dz?=
 =?utf-8?B?WkUyUExyc2VjNElsUFNwdlRxM1pjRUJ3aVpjRXMvb3hXMDZzbXRha0N6azRq?=
 =?utf-8?B?UzdESHgyRitObEpMQ2xKUUtud2VwTzBoTGhpbGtWckt1bHJNeWlWdjE5WGQr?=
 =?utf-8?B?dzZYaG94TGU0ekRwRGR1WG5rZEpCZkJwNDJPMFhVeDBRTXFWelNlNml2U29h?=
 =?utf-8?B?MXN3K1NBV011K0xnRFZMY2Q5UEVTcGM2UmU4d0VVODJNcDYwZ1BIbTl4Vm9D?=
 =?utf-8?B?L0pDSEZjUDdkWVRSYUpoMXYrc3V0RGFieGRZd2NCb2hhbHAxdjQ3YU9MSHAw?=
 =?utf-8?B?LzhLZUF2UUloM05keko4eEQ2TTRiNlN6dDNJWktDaUNuZXZ3ZFVoUG41eE1p?=
 =?utf-8?B?azE2V1E5NU1BMkxnUXVCVkpVTmN0bnlodGw4MU56ZE5nR1RnL0NXM2lrYk4x?=
 =?utf-8?B?QTJJSnkwV0M5NkNwSm5ka3g2Y0cxbHpCQlVPWE0rclhSQjF6YXhuN1hEYlhU?=
 =?utf-8?B?QVg0MTlRQndqWTRkVjVoa1B4ZGpNSVV0V0F1azdxY0p2MjhhZndTSk1EbjhX?=
 =?utf-8?B?RlNsSXBCaUYxUjQ5ckRGYlhvMCs3MG1SMjVpYVpRY1NuWWMrZHVpUmtNYnRm?=
 =?utf-8?B?WjdwY001UmdmRC9NQVZ4VlRZejBMazlxdUFTKzFiaklNUVdGOXNFYTVlcGUw?=
 =?utf-8?B?bEs0amNLSklzZXNOUTZiVjlkL0xiOVdsRmR5VmxsN1UxM0dSTmNmRllHVjYw?=
 =?utf-8?B?b0dlWUh6ZTFsb0ZiMFVGL3A2SVU1Kzk1eTRLZnU4aUl2dGE2eGhGUFpMc050?=
 =?utf-8?B?ZkF2M2svK0hkNjk4VVZWK0ovUVo5WlNGNk84VElhNVNKdlZoRWRUTzBCREo4?=
 =?utf-8?B?WFM1REdYT3RRRXM2MnZ0cnlKR0swZ3VOYzR2Z3czR1RTREE1TkZ0ODViSlg3?=
 =?utf-8?B?Z2QwU3FyTURWWnR1OC9Oa2s5K2hhQTRFb3lEVGZMUzJZVURjOGN0YWdaeWFL?=
 =?utf-8?B?NjRZRWtrVFZNWjdHNmtNT0xsNmFzUHNOMWFoRmVmeGl1VXlKNXZoREY2WGxJ?=
 =?utf-8?B?eDBBcDdLT2VjTnErV3RETmhBR3NHV1QwZlQ0akhveWxYSlVNMmZ6K0JKbWNF?=
 =?utf-8?B?cFFsOCtIRXNhOFpKV1hlRUdWZ3p0ZzloNlAxOTlWQmU2aStDczVWY09DeWIr?=
 =?utf-8?B?TkJ5cjYrb1FTL2hiUmt1Y0JmRFhycVVVRVl0c25mNGVkbUFtVWtVKzBWbi9X?=
 =?utf-8?B?UlFVSXdwY0FNajVWbjgzR2tZa0pWUlBTZk0xUEw3SWdrdEdFZTdUTmlyWVZG?=
 =?utf-8?B?d2MyOUg0Q21XOUVUVUdmT21uNWxMTGFFSmFHTDcvNGpsYXBvaGFMMkhhMTc3?=
 =?utf-8?B?Sm1VaVMrcklQZ3dMQ1dmazAzWG5xaW5IY1I1M3pENVp6Zy9LeXBMY28ybUli?=
 =?utf-8?B?dzdoU2tUVHhhRjZ4NDE4cHc4RlVwdzJEQnNTdHZvN01zY2NFaWJpd1phWmNw?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1C5C1E46A97C241A76B70C6FD434E91@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b6857-e555-4818-ce5b-08dbd634bf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 15:03:43.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I68ihHMSw/uKlS0zaumTdhD+FPaOR1Z8GiRzQq3YatxOkt6oZ8OAfGFEBXTqYRydRTJP+80NjG+k1F2GtfMnabNYpyMIWZeFt/6XAeFMuBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5471
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTnVubyBTw6EsDQoNCiAgVGhhbmtzIGZvciBsb29raW5nIG92ZXIgdGhlIHBhdGNoLg0KDQpP
biBXZWQsIDIwMjMtMTAtMjUgYXQgMTY6MzggKzAyMDAsIE51bm8gU8OhIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgMjAyMy0xMC0y
NSBhdCAxNjo0NCArMDMwMCwNCj4gbWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbcKgd3JvdGU6
DQo+ID4gRnJvbTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+
DQo+ID4gDQo+ID4gVGhpcyBpcyB0aGUgaWlvIGRyaXZlciBmb3IgTWljcm9jaGlwDQo+ID4gUEFD
MTkzWCBzZXJpZXMgb2YgUG93ZXIgTW9uaXRvciB3aXRoIEFjY3VtdWxhdG9yIGNoaXAgZmFtaWx5
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3Rl
YUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiANCj4gSGkgTWFyaXVzLA0KPiANCj4gSSdsbCBi
ZSBob25lc3QgYW5kIEkganVzdCBsb29rZWQgYXQgdGhpcyBmb3IgNW1pbi4gQnV0IEknbSBzZWVp
bmcNCj4gdGhpbmdzIGxpa2UNCj4gc2h1bnQgcmVzaXN0b3JzLCB2c2Vuc2UsIHBvd2VyLCBlbmVy
Z3kuLi4gVGhpcyBzZWVtcyB0byBtZSB0aGF0IGl0DQo+IGJlbG9uZyB0bw0KPiBkcml2ZXJzL2h3
bW9uLiBBbnkgc3BlY2lhbCByZWFzb24gZm9yIElJTz8NCj4gDQoNCiAgWWVzLCB0aGlzIGRldmlj
ZSBpcyBhdCB0aGUgYm91bmRhcnkgYmV0d2VlbiBJSU8gYW5kIEhXTU9OIGlmIHlvdSBhcmUNCmxv
b2tpbmcganVzdCBhdCB0aGUgInNodW50IHJlc2lzdG9ycywgdnNlbnNlLCBwb3dlciwgZW5lcmd5
Ii4gVGhlDQpkZXZpY2UgYWxzbyBoYXMgQURDIGludGVybmFseSB0aGF0IGNhbiBtZWFzdXJlIHZv
bHRhZ2VzICh1cCB0byA0DQpjaGFubmVscykgYW5kIGFsc28gY3VycmVudHMgKHVwIHRvIDQgY2hh
bm5lbHMpLiBDdXJyZW50IGlzIG1lYXN1cmVkIGFzDQp2b2x0YWdlIGFjcm9zcyB0aGUgc2h1bnRf
cmVzaXN0b3IuDQoNCiAgQXMgSSBzYWlkIGJlZm9yZTogSSB3YXMgdGhpbmtpbmcgdG8gc3RhcnQg
d2l0aCBhIHNpbXBsZSBkcml2ZXIgKHRoaXMNCm9uZSB0aGF0IGlzIG1vcmUgYXByb3BpYXRlIHRv
IGJlIGEgSFdNT04pIGFuZCBhZGQgbW9yZSBmdW5jdGlvbmFsaXR5DQpsYXRlciAobGlrZSBkYXRh
IGJ1ZmZlcmluZyB0aGF0IGlzIHF1aXRlIGltcG9ydGFudCBmb3IgZXhhbXBsZSBpZg0Kc29tZW9u
ZSB3YW50cyB0byBwcm9maWxlIHBvd2VyIGNvbnN1bXRpb24gb2YgdGhlIHByb2Nlc29yIGl0c2Vs
Ziwgb3IgYQ0KcGhlcmlwZXJpYywgb3IgYSBiYXR0ZXJ5LCB0aGlzIGtpbmQgb2YgZnVuY3Rpb25h
bGl0eSB3YXMgcmVxdWVzdGVkIGJ5DQpvdXIgY3VzdG9tZXJzKS4NCg0KDQoNCj4gLSBOdW5vIFPD
oQ0KPiANCj4gDQovL01hcml1cw0KDQo=
