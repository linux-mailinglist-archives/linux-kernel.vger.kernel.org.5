Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA57E36FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjKGI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjKGI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:56:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2FAB;
        Tue,  7 Nov 2023 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699347379; x=1730883379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9UDqBl0hDARijFhTHbVwIxHZnaqSt5Eq9bQlWvblQjA=;
  b=nZ4mS0/I4AY3Uhpzn8ctyKvYguFgyFXYWJjvM68ZsUy2SoAz3YWfAzEs
   SQARd/uBx1nP5rMCyJgCX0vbGO+lg6uO6mMS/PWCZflFXbmbpSUn0OFan
   mK+T4z+0YLa0jYuY0b2UCioaf0Pyh0LqKqlWhZcBop0djEs69nNkYk9Ba
   Zk0GZvtnvHeUhLqHZXDBW8fdpda0x3OTsFuN6M4Qjwicdso/3EiV7a7ih
   ZwEchdzlHcaImEiTETWH7pVttYKtXHwA+xpRV+KrUrHfC5GlfaAX9ZW+L
   CXKhNK0zpdVWuJBYGS66cvk6ov99vQ4hWx9rXBnmif0r4FM/sy/sghMav
   g==;
X-CSE-ConnectionGUID: l07eScumRSep0jMMyeFs0g==
X-CSE-MsgGUID: AhQQraUUQAeMWVQmiqMWew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="241981789"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 01:56:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Nov 2023 01:55:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Nov 2023 01:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTUln/5ddPE2f6gBNQIMvW6EB3HxrfpVRy8QtTR+c58HscNeqSzUr2Syf4ReplAT3leLo+GPGo5TK3L/cbJNCtYqa3tRcJ42wyiJ/nR+JWqV/QKXqzo7CNGq1VPvWFq//4pddDvEJWvkQeBhFeItvmp61h7tXHKqlFgd+X12BbV9vldcu1U4Hwj/wNX5/WWDtlUpJoJXKrMH0D9Y3H4Wn3YzkKSb1PI1e8XpUkX9i05P7wXc7MRqNLsmLYrrGeXDBnTfAro0v700OPF5SMuwRQCCGJi33zQW6LYpujN39mdo2tXjmMHYrrrYrw3oD41OzSTuOjnQoEYhTw1LddLwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UDqBl0hDARijFhTHbVwIxHZnaqSt5Eq9bQlWvblQjA=;
 b=a36ar8qZyjkWNYgfMlqg0DqHTE6FGUfbTxMM1pTUZ9eujaZKZiY8G7Wyewux9Gibda87eWRuglGXOMmfa1v5k8Hwij8XCeXqskP7lMpkN+ZA2sOihAHHN4QDcW0OEM4LhNX9NgPGVX5dmgWyuAmAz4e2uil7xsOXOBlVp2pzArLWTRCFTk8oOjKNnbcDpfhQlS3WOX4SA8C6nBvwK7jMFws04vmIrMebVBM6b73KFQCvDx4KTG2I93mT6+sHMFYxc8IrNTeJ7oVz8ewppw2W3u1BSrwTdvauR1cEHQ/aiSub30hv2RSNN1PUTM9fsqXpcxtMC6Xx+6/tATQ9NPTsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UDqBl0hDARijFhTHbVwIxHZnaqSt5Eq9bQlWvblQjA=;
 b=keUrg8Dzfm0wTnbrzPzYZQC265zPBI5ALNwwnZiRNxduzAV/6kXGc7nWMX0qGI8k3cV9PZ9UvubF+SKUnKU/2jmv1XujqSM1+G4XidmZD09ewNN6UUZrAevJLRlduD560/r8mCd2kf4SEyhgnZezBL5BT7/9PQg+QUn2TU5btuQ=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 08:55:49 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%5]) with mapi id 15.20.6933.029; Tue, 7 Nov 2023
 08:55:49 +0000
From:   <Marius.Cristea@microchip.com>
To:     <conor@kernel.org>, <jic23@kernel.org>
CC:     <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Index: AQHaB0lj9PO1FMJaPku3xMkF5R2gP7Bam5gAgAGWpICAAAxogIABdeqAgBDtRgA=
Date:   Tue, 7 Nov 2023 08:55:48 +0000
Message-ID: <1fb7d32772cb5e76a5f1fd6b8f3b32754f8a9395.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-2-marius.cristea@microchip.com>
         <20231025-cheddar-tucking-b2ea777ed4f9@spud>
         <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
         <20231026-perkiness-financial-55313e297230@spud>
         <20231027152625.44b26d80@jic23-huawei>
In-Reply-To: <20231027152625.44b26d80@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CH0PR11MB5426:EE_
x-ms-office365-filtering-correlation-id: 8542c0de-3e50-46a2-3f28-08dbdf6f5696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTjM/LADZ4YrKpSupfWk410j43HtmDAVE6kevd9qL+dhz5JwyxUAS2LPHsCCxG9mOB6swjI+v1gYZKDLUO5ZNQQXJw3CUGWhkfKzlHWntmA0K1JcrSWrFyvuAAV908Q2ZWFi4NVslBQDvi1GCwBzoq1akzYvlsKPOD6XY6sGd+onOIPjYu/BifzTUXeK1rluF6XQ94gI6R6uG7rXLGeRbSwIqjUwsL61qK4SPFblNJbLYK8XThgiv1Zj/BbKVcNEFHGWLsoyXlGnzgHEjIQ5e3I0d+uX1B8yxwwC39nbkAZ0EqVs3JwWkBJLb+Y7bUD1CV2z6Kx4KUA8TTZSYB3z+gx1Ko5ROw6FDSedzIvv7VXhslydUXGqHxNOFsFSYFp541abpAf1ocNcf+jRCkQh9R9tjtSfM26aKGeyQh/WYDSOcgRKFHk2WObXkNojMMCZ+H/hZLvk0woD0yQfiqM3fH4Z0A4537GEhc5AzT45uldSMmP3j3oFaUYb25lEyi0oXVK8Lah5Fcps3N+eOKeiB0Prx6rZxW1LSP418kU/9KJu8iy1PjYKGr7If0WRtB+s0oyQGqu8w8ALx57wqxnGAZE5Bjq5ZURMAuI0pqrzkjXNkI1lWYFG1LNnndc9aeW7UU9LVd0uNy/o+OnSag6+Ga9qD5kDeb28c0n5f4qjuUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799009)(451199024)(186009)(64100799003)(6486002)(83380400001)(71200400001)(26005)(2616005)(38100700002)(8936002)(316002)(8676002)(2906002)(4326008)(4001150100001)(5660300002)(41300700001)(54906003)(66946007)(66476007)(478600001)(6512007)(6506007)(66446008)(64756008)(76116006)(110136005)(91956017)(66556008)(36756003)(86362001)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnZ6d3ZueHEzOXpSK1dvQmJkRll1enB6NWxzZkxRZ05KNVZlcTBVWDVFTERq?=
 =?utf-8?B?MW5wWUVsT0MrbnpzQ3pteTBPVytDZFBQL3UrbGVhVDJReGR6V1hVNEVjdWc5?=
 =?utf-8?B?Z3VQVUJ3cVRCTEVPd2RGUk15OFphakRicmVUUzVhblp3VDBybUxuOHdnYkZu?=
 =?utf-8?B?NjhkZFI3ZWxjQXNSdVVXZFk1YTUxWWhQMGpYczVzNzhHaWxzNjQ1blp5NFc4?=
 =?utf-8?B?RWMvbmM0UHBIR2drR0NvWGY0RW1zeVBCa3FYWW1DUkYvODIrb1RuOXB1S1J4?=
 =?utf-8?B?dmRpV0Vyd0xoMThhZmlQcXBwWXhyNjlGZjBiQ0QxdU5YcURCQlhRYnZRVFE1?=
 =?utf-8?B?YVpYNHlacUZ0cWNQTFAvV0VuV041MGFhaDI3ay8zV2tiR1c0YTBWL1RDcFlD?=
 =?utf-8?B?QmNpNkV4STJZMUpxem5vdWtpSFBmeU9vd25MME4wanhuQ0hLZzNTbDQ3Y0h1?=
 =?utf-8?B?RGlmNEl1bklYYkxHb2RFakdTUWtJaFh3WVVJNWduOTRhbU41blV6b0Q1QU1l?=
 =?utf-8?B?NWtWaUl3RVlJT3RBK2lBcUNyWStiWVNjTk5RYnlsZFNYeFpFWld4WWZJV1lo?=
 =?utf-8?B?V2xQNUwyS3loYVdycGRieFNEMTAyVjFSMWRIKzFVSGx5ZHUrNklUMThPRk12?=
 =?utf-8?B?ZkJIeW83ZUIwQk9yVUY5OUd6d2luTlowWjRDS2o0eHVURVlDRXhSM1dRSTZ5?=
 =?utf-8?B?dy9HcFRkaFdIdkFnMkdaQWNvdS9yamNYT3dDNUVxcE5CamdNNnNSNWhRMWNV?=
 =?utf-8?B?cE9UQVA5RFZVMkpoRmF6dFBOTFhNbExsc3hkTmNDN3Q0SXUzbjFFeGVSYWdU?=
 =?utf-8?B?cmM5UG1JK0tmSWE4VUpFMzVEcWVMbjJLYXhBUmFaVkRGSWdHZlFaTU1ON3RI?=
 =?utf-8?B?dWplUHJtK0pQMTJNTzdWa1hJVWhVSmJXdDkxMFZDMEllQ1VUT0dMQjQyTlVF?=
 =?utf-8?B?RHFTN1BOdlBob0cwLzFTZWVKWWtuelNkY25tenc0N3NuMUxKTzNpMk8xZFJP?=
 =?utf-8?B?TTBMM21wSDhxYm0wN09EWDNuNnFDN3lONHRIaFBHMXJsY3dNQkNXeXMwTzNH?=
 =?utf-8?B?VUg2c3NNalVxVzdTSjF6bG5PUEFocVNQL01vQ2lhZjYxQ05uZ3VIVWVYRDVs?=
 =?utf-8?B?bjZXaUdYTDNaOUZKeTFzcTFFT0JWc0F6WXpEU2V6c0NxQW9IQ2V4S3B1L3lU?=
 =?utf-8?B?anJMMXU1UkVuZU1sZnBwd2k4aC9xNTBaRDJyR0ZiUDVoaC9abVF2Mjdmd0VI?=
 =?utf-8?B?MDFqVGsyZnZobzh3NzVlYStWZGpnM2pleHlQRGpHODJvQ1JhUXZmaEdLSG1y?=
 =?utf-8?B?SXVEMGpBL1NnVUdwalk3Wi8vTHdLVGNTZ2JpalJwZDVXUmlYck9Qd21hUzYv?=
 =?utf-8?B?clVhWFNxMStncThrVWlLbWNYM1lzK093bHl0N2pOcjZUV1ZOL0lPWWozOUxW?=
 =?utf-8?B?UnU0Uis3YjdYRGttMW9UdUtUcWhqa1RPUTJFNmljOG92dTh3aWdjRjY4bVdF?=
 =?utf-8?B?WlNQNkZTVytwNEx3c096dkMySFJaNHFyOVlUT00za1hDeXc1aUJsaGo1SG5s?=
 =?utf-8?B?SlFrdjYyOHZUQXdMMWNrei9EZnRaOTFFemFLaENTN1FpbkZYMjdCcENmalox?=
 =?utf-8?B?c2JBMVBhV1paeENxeDU1ODhRRUdBb2wwa1lCdzV3b0dxUFhpc1VjOG5rUEln?=
 =?utf-8?B?N2p0NEhaWEIyaTV3UnlYVVRhb2FveiszUDFya2FPN0dMNkhHUitoYmJXOFpX?=
 =?utf-8?B?V0RnOTEwMDJab2ZTb1AxVlFNYVFyVWJ3ejRGZkkwS0lsZkRqLytpVHdlYXBV?=
 =?utf-8?B?MHBnNytjVURnTDBySXlTMndkRjdsb05BK0Y5djJ3Zjh6by82MmJGYzVQK3BX?=
 =?utf-8?B?RXNzbEgvQzM4SkluV1NEYkFMUFlDemorTXJPVjhsK1FSbHh3aHQ2QW9JODA1?=
 =?utf-8?B?M1hBQkx4cC9aR2JPRVZ0T01mR3lLemFvSGJ1a0o4SHFsSXFOYkxpc2wvUVVH?=
 =?utf-8?B?UXFaQ25UR1NDbkg0K3NXSllDdXoxNFh6UXU0cy9hTGd2SUNQVllpMmZKaHd4?=
 =?utf-8?B?U1VGTjBkZmN6SEUyRGN2MGxiaDVXVDBiYWp2eFNrL1VtS2lOaHRCUE5VQkxO?=
 =?utf-8?B?QjJDSzRYVERLOS8zTXdyZVRscE1BTFcyUTJwSVlHNWdGV1NzSW1TVVdzTVdY?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <174C8FCFFE12494EB1B2766D84298028@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542c0de-3e50-46a2-3f28-08dbdf6f5696
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 08:55:48.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U739cwiHimPFJ98y5NSoN8FnY5dDVHA8yF/UtL8cr4xPThKlNqxBc3QNWEbBU4gxWXSfHIzqZNwMQI8HVcaeMmh4P+NlNO3adtrjKJKa4zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gRnJpLCAyMDIzLTEwLTI3IGF0IDE1OjI2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9u
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9u
IFRodSwgMjYgT2N0IDIwMjMgMTc6MDg6MDcgKzAxMDANCj4gQ29ub3IgRG9vbGV5IDxjb25vckBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMDM6MjM6
NDZQTSArMDAwMCwNCj4gPiBNYXJpdXMuQ3Jpc3RlYUBtaWNyb2NoaXAuY29twqB3cm90ZToNCj4g
PiA+IEhpIENvbm9yLA0KPiA+ID4gDQo+ID4gPiBPbiBXZWQsIDIwMjMtMTAtMjUgYXQgMTY6MDgg
KzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+ID4gSGV5IE1hcml1cywNCj4gPiA+ID4g
DQo+ID4gPiA+IE9uIFdlZCwgT2N0IDI1LCAyMDIzIGF0IDA0OjQ0OjAzUE0gKzAzMDAsDQo+ID4g
PiA+IG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+ID4gPiA+IEZyb206
IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFRoaXMgaXMgdGhlIGRldmljZSB0cmVlIHNjaGVtYSBmb3IgaWlvIGRyaXZl
ciBmb3INCj4gPiA+ID4gPiBNaWNyb2NoaXAgUEFDMTkzWCBzZXJpZXMgb2YgUG93ZXIgTW9uaXRv
cnMgd2l0aCBBY2N1bXVsYXRvci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCi4uLi4uLg0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArwqAgcmVnOg0KPiA+ID4gPiA+ICvCoMKgwqAgbWF4SXRlbXM6
IDENCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgICIjYWRkcmVzcy1jZWxscyI6DQo+ID4gPiA+
ID4gK8KgwqDCoCBjb25zdDogMQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqAgIiNzaXplLWNl
bGxzIjoNCj4gPiA+ID4gPiArwqDCoMKgIGNvbnN0OiAwDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICvCoCBpbnRlcnJ1cHRzOg0KPiA+ID4gPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IElSUSBsaW5l
IG9mIHRoZSBBREMNCj4gPiA+ID4gPiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICvCoCBkcml2ZS1vcGVuLWRyYWluOg0KPiA+ID4gPiA+ICvCoMKgwqAgZGVzY3Jp
cHRpb246IFRoZSBJUlEgc2lnbmFsIGlzIGNvbmZpZ3VyZWQgYXMgb3Blbi1kcmFpbi4NCj4gPiA+
ID4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gPiArwqDCoMKgIG1heEl0ZW1zOiAx
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoCBtaWNyb2NoaXAsc2xvdy1pbzoNCj4gPiA+ID4g
PiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiB8
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgQSBHUElPIHVzZWQgdG8gdHJpZ2dlciBhIGNoYW5nZSBp
cyBzYW1wbGluZyByYXRlDQo+ID4gPiA+ID4gKGxvd2VyaW5nDQo+ID4gPiA+ID4gdGhlIGNoaXAg
cG93ZXIgY29uc3VtcHRpb24pLg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgIEluIGRlZmF1bHQgbW9k
ZSwgaWYgdGhpcyBwaW4gaXMgZm9yY2VkIGhpZ2gsIHNhbXBsaW5nDQo+ID4gPiA+ID4gcmF0ZQ0K
PiA+ID4gPiA+IGlzIGZvcmNlZCB0byBlaWdodA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgIHNhbXBs
ZXMvc2Vjb25kLiBXaGVuIGl0IGlzIGZvcmNlZCBsb3csIHRoZSBzYW1wbGluZw0KPiA+ID4gPiA+
IHJhdGUgaXMNCj4gPiA+ID4gPiAxMDI0IHNhbXBsZXMvc2Vjb25kIHVubGVzcw0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgIGEgZGlmZmVyZW50IHNhbXBsZSByYXRlIGhhcyBiZWVuIHByb2dyYW1tZWQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGRlc2NyaXB0aW9uIGRvZXNuJ3QgcmVhbGx5IG1ha2Ug
c2Vuc2UgdG8gbWUgLSBpZiBhIEdQSU8gaXMNCj4gPiA+ID4gdXNlZA0KPiA+ID4gPiB0bw0KPiA+
ID4gPiBkcml2ZSB0aGUgcGluIGxvdyBvciBoaWdoLCB3aHkgZG8gd2UgbmVlZCBhIHByb3BlcnR5
PyBBIERUDQo+ID4gPiA+IHByb3BlcnR5DQo+ID4gPiA+IGltcGxpZXMgdGhhdCB0aGlzIGlzIGEg
c3RhdGljIGNvbmZpZ3VyYXRpb24gZGVwZW5kaW5nIG9uIHRoZQ0KPiA+ID4gPiBib2FyZCwNCj4g
PiA+ID4gYnV0DQo+ID4gPiA+IHJlYWRpbmcgdGhlIGRlc2NyaXB0aW9uIHRoaXMgc2VlbXMgdG8g
YmUgc29tZXRoaW5nIHRoYXQgY2FuIGJlDQo+ID4gPiA+IHRvZ2dsZWQNCj4gPiA+ID4gYXQgcnVu
dGltZS4NCj4gPiA+ID4gSSBkbyBub3RlIHRob3VnaCwgdGhhdCB0aGlzIEdQSU8gaXMgbm90IGRv
Y3VtZW50ZWQgaW4gdGhlDQo+ID4gPiA+IGJpbmRpbmcsIHNvDQo+ID4gPiA+IEkNCj4gPiA+ID4g
c3VwcG9zZSB3aGF0IHJlYWxseSBuZWVkcyB0byBoYXBwZW4gaGVyZSBpcyBkb2N1bWVudCB0aGUg
Z3Bpbw0KPiA+ID4gPiBzbyB0aGF0DQo+ID4gPiA+IHRoZSBkcml2ZXIgY2FuIGRldGVybWluZSBh
dCBydW50aW1lIHdoYXQgc3RhdGUgdGhpcyBwaW4gaXMgaW4/DQo+ID4gPiA+IA0KPiA+ID4gPiBB
bHNvLCB5b3Ugc2F5ICJJbiBkZWZhdWx0IG1vZGUiLCBidXQgZG9uJ3QgbWVudGlvbiB3aGF0IHRo
ZQ0KPiA+ID4gPiBub24tDQo+ID4gPiA+IGRlZmF1bHQNCj4gPiA+ID4gbW9kZSBpcy4gV2hhdCBo
YXBwZW5zIGluIHRoZSBvdGhlciBtb2RlPw0KPiA+IA0KPiA+ID4gVGhpcyBpcyBhICJkb3VibGUg
ZnVuY3Rpb24iIHBpbi4gT24gdGhlIFBBQzE5M3ggdGhlcmUgaXMgdGhlDQo+ID4gPiBTTE9XL0FM
RVJUDQo+ID4gPiBwaW4uIEF0IHJ1bnRpbWUgdGhpcyBwaW4gY291bGQgYmUgY29uZmlndXJlZCBh
cyBhbiBpbnB1dCB0byB0aGUNCj4gPiA+IFBBQyBhbmQNCj4gPiA+IHRoZSBmdW5jdGlvbmFsaXR5
IHdpbGwgYmUgIlNMT1ciIHRoYXQgbWVhbnMgaWYgaXQgaXMgZm9yY2VkIGhpZ2gsDQo+ID4gPiB0
aGUNCj4gPiA+IFBBQyB3aWxsIHdvcmsgaW4gbG93IHBvd2VyIG1vZGUgYnkgY2hhbmdpbmcgdGhl
IHNhbXBsZSByYXRlIHRvIDgNCj4gPiA+IFNQUy4NCj4gPiA+IElmIGl0J3MgZm9yY2VkIGxvdyB0
aGUgUEFDIHdpbGwgd29yayBhdCBpdCdzIGZ1bGwgc2FtcGxlIHJhdGUuDQo+ID4gDQo+ID4gU2lu
Y2UgdGhpcyBpcyBhIHJ1bnRpbWUgdGhpbmcsIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBoYXZl
IGENCj4gPiBwcm9wZXJ0eQ0KPiA+IHRoYXQgaXMgc2V0IGF0IGR0cyBjcmVhdGlvbiB0aW1lIHRo
YXQgZGVjaWRlcyB3aGF0IG1vZGUgdGhlIHBpbiBpcw0KPiA+IGluLg0KPiA+IA0KPiA+ID4gIlNM
T1ciIGlzIHRoZSBkZWZhdWx0IGZ1bmN0aW9uIG9mIHRoZSBwaW4gYnV0IGl0IG1heSBiZQ0KPiA+
ID4gcHJvZ3JhbW1lZCB0bw0KPiA+ID4gZnVuY3Rpb24gYXMgQUxFUlQgcGluIChPcGVuIENvbGxl
Y3RvciB3aGVuIGZ1bmN0aW9uaW5nIGFzIEFMRVJULA0KPiA+ID4gcmVxdWlyZXMgcHVsbC11cCBy
ZXNpc3RvciB0byBWREQgSS9PKS4gVGhpcyB0aW1lIHRoZSBwaW4gd2lsbCBiZQ0KPiA+ID4gc2V0
IGFzDQo+ID4gPiBvdXRwdXQgZnJvbSBQQUMgKEFMRVJUIGZ1bmN0aW9uYWxpdHkpIHRvIHRyaWdn
ZXIgYW4gaW50ZXJydXB0IHRvDQo+ID4gPiB0aGUNCj4gPiA+IHN5c3RlbSAodGhpcyBpcyBjb3Zl
cmVkIGJ5IHRoZSBpbnRlcnJ1cHRzIGFuZCBkcml2ZS1vcGVuLWRyYWluKS4NCj4gPiANCj4gPiBI
bW0sIGF0IHRoZSByaXNrIG9mIGdldHRpbmcgb3V0IG9mIG15IGRlcHRoIHdpdGggd2hhdCB0aGUg
R1BJTw0KPiA+IHN1YnN5c3RlbQ0KPiA+IGlzIGNhcGFibGUgb2YgZG9pbmcsIEkgd291bGQgZXhw
ZWN0IHRvIHNlZSBzb21ldGhpbmcgbGlrZQ0KPiA+IA0KPiA+IHNhbXBsaW5nLXJhdGUtZ3Bpb3M6
DQo+ID4gwqAgZGVzY3JpcHRpb246DQo+ID4gwqDCoMKgIDx3aGF0IHlvdSBoYXZlIGFib3ZlPg0K
PiA+IMKgIG1heEl0ZW1zOiAxDQo+ID4gDQo+ID4gV2hpY2ggd291bGQgYWxsb3cgdGhlIGRyaXZl
ciB0byBlaXRoZXIgZHJpdmUgdGhpcyBwaW4gdmlhIHRoZSBncGlvDQo+ID4gc3Vic3lzdGVtLCBv
ciB0byB1c2UgdGhlIGludGVycnVwdCBwcm9wZXJ0eSB0byB1c2UgaXQgYXMgYW4NCj4gPiBpbnRl
cnJ1cHQNCj4gPiBpbnN0ZWFkLg0KPiA+IA0KPiA+IFBlcmhhcHMgSm9uYXRoYW4gZXRjIGtub3dz
IGJldHRlciBmb3IgdGhlc2Ugc29ydCBvZiBkdWFsIG1vZGUgcGlucy4NCj4gDQo+IEJleW9uZCB0
aGVtIGJlaW5nIGEgcGFpbj8gVGhlIGZ1biBpcyB0aGV5IG1heSBnZXQgd2lyZWQgdG8gaW50ZXJy
dXB0DQo+IGNvbnRyb2xsZXJzIHRoYXQgYXJlIGFsc28gR1BJT3Mgb3IgdGhleSBtYXkgbm90IChh
bmQgdGhlIG90aGVyIHdheQ0KPiBhcm91bmQNCj4gd2l0aCB0aGVtIHdpcmVkIHRvIEdQSU8gcGlu
cyB0aGF0IGFyZW4ndCBpbnRlcnJ1cHQgcGlucykuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQg
dGhlIHVzZWNhc2UgZm9yIHRoZSBTTE9XIGNvbnRyb2wuDQo+IEdpdmVuIGl0IHNlZW1zIHNvZnR3
YXJlIGNhbiBvdmVycmlkZSB0aGUgdXNlIGZvciBTTE9XIEknZCBiZSB0ZW1wdGVkDQo+IHRvDQo+
IGFsd2F5cyBkbyB0aGF0Lg0KPiBUaHVzIG1ha2luZyB0aGlzIHBpbiB1c2VhYmxlIG9ubHkgYXMg
YW4gb3B0aW9uYWwgaW50ZXJydXB0Lg0KPiANCj4gSWYgc29tZW9uZSBoYXJkIHdpcmVzIGl0IHRv
IGhpZ2ggb3IgbG93IHRoYXQgaXMgaGFybWxlc3MgaWYgd2UgYXJlbid0DQo+IGxldHRpbmcgaXQg
Y29udHJvbCBhbnl0aGluZy4NCj4gDQoNCkhlcmUgSSB3YXMgdHJ5aW5nIHRvIGRlZmluZS9kZXNj
cmliZSAzIHBvc3NpYmxlIHNpdHVhdGlvbnM6DQotIDEpIHRoZSBwaW4gaXMgbm90IHVzZWQgYXQg
YWxsLCBzbyBpdCBkb2Vzbid0IG1hdHRlciBpZiBpdCdzIGNvbm5lY3RlZA0Kc29tZXdoZXJlDQoN
Ci0gMikgdGhlIHBpbiBpcyB1c2VyIGNvbmZpZ3VyZWQgYXMgImludGVycnVwdCIgYW5kIGl0J3Mg
Y29ubmVjdGVkIHRvDQp0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgKHRoaXMgY2FzZSBpcyBub3Qg
c3VwcG9ydGVkIGluIHRoZSBkcml2ZXINCnJpZ2h0IG5vdykNCg0KLSAzKSB0aGUgcGluIGlzIHVz
ZXIgY29uZmlndXJlZCBhcyAiU0xPVyIgKHRoaXMgY2FzZSBpcyBub3Qgc3VwcG9ydGVkDQppbiB0
aGUgZHJpdmVyIHJpZ2h0IG5vdykuIFRoYXQgbWVhbnMgaXQgc2hvdWxkIGJlIGNvbm5lY3RlZCB0
byBhIEdQSU8NCnBpbi4gVGhpcyBmdW5jdGlvbiAoU0xPVyBjb250cm9sKSB3aWxsIGF1dG9tYXRp
Y2FsbHkgY2hhbmdlIHRoZSBQQUMNCmludGVybmFsIHNhbXBsaW5nIGZyZXF1ZW5jeSB0byBsb3dl
ciB0aGUgUEFDIGludGVybmFsIHBvd2VyDQpjb25zdW1wdGlvbi4gRm9yIGV4YW1wbGUsIHRoZSBQ
QUMgY291bGQgYmUgY29uZmlndXJlZCB0byBhIHNhbXBsZSByYXRlDQpvZiAxMDI0IHNhbXBsZXMv
cyAoaXQgd2lsbCBjb25zdW1lIG1heGltdW0gY3VycmVudCkuIFVzaW5nIHRoZSBTTE9XDQpjb250
cm9sLCB0aGUgY2hpcCB3aWxsIGludGVybmFsbHkgY2hhbmdlIHRvIDggc2FtcGxlcy9zIGJ1dCB0
aGUgbWF0aA0KaW50ZXJuYWxseSB3aWxsICJiZWhhdmUiIGFzIHRoZSAxMDI0IHNhbXBsZXMvcyBi
dXQgYXQgYSBtdWNoIGxvd2VyDQpwb3dlciBjb25zdW1wdGlvbi4gSXQncyB2ZXJ5IHVzZWZ1bCBp
biBjYXNlIHRoZSBzeXN0ZW0gd2FudHMgdG8gbG93ZXINCnBvd2VyIGNvbnN1bXB0aW9uICh3ZSBz
dGlsbCBuZWVkIHRvIG1lYXN1cmUgYmF0dGVyeSBwb3dlciBjb25zdW1wdGlvbg0KZXZlbiBpZiB0
aGUgc3lzdGVtIGlzIHB1dCBpbnRvIGEgbG93IHBvd2VyIHN0YXRlKS4gUEFDIGludGVybmFsIHBv
d2VyDQpjb25zdW1wdGlvbiBpcyBwcm9wb3J0aW9uYWwgdG8gdGhlIG51bWJlciBvZiBjaGFubmVs
cyB1c2VkIGFuZCBhbHNvIHRoZQ0Kc2FtcGxpbmcgZnJlcXVlbmN5Lg0KDQoNCg0KPiA+IA0KPiA+
ID4gVGhlIHN5c3RlbSBjb3VsZCB3b3JrIGZpbmUgd2l0aG91dCB0aGlzIHBpbi4gVGhlIGRyaXZl
ciBkb2Vzbid0DQo+ID4gPiB1c2UNCj4gPiA+IGludGVycnVwdCBhdCB0aGlzIHRpbWUsIGJ1dCBp
dCBjb3VsZCBiZSBleHRlbmRlZC4NCj4gPiANCj4gPiBDaGVlcnMsDQo+ID4gQ29ub3IuDQo+IA0K
DQpUaGFua3MsDQpNYXJpdXMNCg==
