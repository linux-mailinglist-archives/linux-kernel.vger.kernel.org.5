Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ACC788CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjHYPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbjHYPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:45:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AA2135;
        Fri, 25 Aug 2023 08:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcYxdl9lA0cdyx18MFTyTUghc6qS3U3pfHf5wK747az0N5kfdbgAL2JQlpH3bWp/R9tMX0awrDrI4W1oaG5CvVsKv19rr5PCs8GFGtPapD/jS6dc8T/OeNnGtTHceIerp3sxzTeFIrDqbut15GWt33BtfsjX0C8j++tCDSR7ltTmxxOdP6AngaReGRgGr9+v3MBbxAwuizD3N+791aEj5yfcbHC6qQNa07GNrxzkvQJroyIwdDDGqa3HFZOD4j0rjSMlhlxdtoY0lXlfy7RcpH+0mW7wN5eyEUJuPf3HonrhypkBE+zxMsrHnfe4R3OfcmXj/DYNVNLNS6OpSTotTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27iK0MIVp/GcBlKwXY4BhVfDu6nDI9rl1Hi3Qg1amh0=;
 b=UzpyYpXdLF9HbfY4zdBY+U1cHwDsKJsp4a5d0yKZWEZx4VJw4ejz03/xWrQsnlBRTd6CgWg5RcKLBY8emH51oZUdnQUjuVnmoym8sZe2XMQx84bQ7OAQZGmVT41X376t+amOpK4bjLhVSek55gPBcCAo8JjW29CR/vShI77wTP8+XC0RGvsLI3+XIGOl5SW6C/xlncd0u6yRBJZ9+jUQFvudqA+h8ANFirIgvhl1QPo8VSweiCToxLOyZXg/0QNd4NGYbz1bHRpC+n5JsF+n5iJDes1Gb4L9xAYHfW4YGdCaVw+K/sSw0NnX/KcwZbSv6Cl6HH43a38HjVqpbwTPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27iK0MIVp/GcBlKwXY4BhVfDu6nDI9rl1Hi3Qg1amh0=;
 b=XOnoMvUVMCtFSdg9iiIH4Srke7OEkWadN36n/6SfrsX2O8OkljO8e/o/6ursckL6O3t/lw19C/ilqx1lO4Z/K6V658c87jk1dHUpkqmo5elqa6s9HV/6SLejJhHCyxRe0KnPCi7f5Kq11L71izMqVePm4XCxCwN1IOuyYBf5jJI=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 25 Aug
 2023 15:44:55 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 15:44:55 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ12sYQ9ArFLbHmUyJfmCCvgO8ew==
Date:   Fri, 25 Aug 2023 15:44:55 +0000
Message-ID: <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
In-Reply-To: <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB9PR04MB8090:EE_
x-ms-office365-filtering-correlation-id: dcf00290-51f9-4eee-cf52-08dba5823ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSD5rMr+udDvNvPqhmIj+KS/Uv/ua36CdL2zNxTAhN+h9fOKI4CytwNNbNvPlbdBBZuCcw33UdGNKj2kfHfREVXemNZFoZqxffK/swKdzPkEM9npb1w+IvV8VDLzW13lfuYIWmSzusnc+4+Bh9ozAa4qz/J1bADfQpBpcjsTmqSVpk+Op0AzKA0q1UOQ+Y0B1PzQUqE3YGCCQEr6xhiISdVILq1etmXEGYRYUbdzm06cNMp/GTn9tODXkSg9esrQm/bYrAVdy8lUvxsft4jfYA6A//h8J5s2fqllsR5ksavmX0NiJ/x/EqqyIrAdoZZEwp4vLsQBW1abeGz7vnK7d+cIs2K4t00E9+VVzDS2InnM3mrdqaxPcaVFAhe3jCxwZE/vFk5AGWgDOhVQ+9fjb3qKbbmTIlfxtnqOEKPU5UuQgOUfvyrq1t9UcE0jYTxTCc3LMMxc2+P6Weeb3mnvomyhzIWfvXYkAlOmpHGhUiPqxydtsfIQtKy94rUWhGNJz8ZFS9ZvXPBBshXxWMMJFnsIg+zhLa5MfduATurJNJJw8ytZ1jnMumxTqGyHcXPOcglL+RNVkmv3YilIuM+bTBON/YbIuK62ue3wh7fCmf20rH6juWVchKsou+mO/xDK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(8936002)(71200400001)(6506007)(7696005)(55236004)(53546011)(478600001)(2906002)(26005)(83380400001)(66556008)(316002)(6916009)(41300700001)(54906003)(64756008)(66476007)(52536014)(66446008)(8676002)(76116006)(66946007)(44832011)(4326008)(9686003)(33656002)(55016003)(38100700002)(38070700005)(86362001)(122000001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNOY1p6VE9MVXpmUEdMSkF2clNzd1kyM3pSbFI4cUhtMFE1c2NGZXlMZHFM?=
 =?utf-8?B?ZXc2UExxN3l5aWJjMVJCdUZoVFhsZWFPb05DMGdWTGtpb0FHLy9BRWk2L2NF?=
 =?utf-8?B?WVNqeDhtUkNLVFhxS1pJcWM4WVpld0FuOUY0ZXhPZC9remNSOVBNTktKL3hG?=
 =?utf-8?B?ZHYzYUxnWUV3WEFWblJnTHVsKzE2K1hvdzVjMGlGemRPWURxbS9xeC9Ub09k?=
 =?utf-8?B?TjRwNTNNWkFHOWZpTmlucmlIekxVYzhVSWQzaGhSc2d0K2kxc0RZQUVDRHpS?=
 =?utf-8?B?Ulc2N3pDVEFIcFN1OGNZMjdqb1hJQURheE1JWTQzeDJ4QU1NeXNBeWhXMFZt?=
 =?utf-8?B?UWpscTdhRDh3YlNyVExWcHdmM0h4b2lvWXZyUGxpemZLN1BaVktxUjBHU2Fi?=
 =?utf-8?B?MWhSd3ArU2t5VFFzbStjYjErK3p0eGpRUUtyYXl6bUI1U0d1NWl6RGVNaVRm?=
 =?utf-8?B?dmt5SWNsQTB6TjF3OVJMUEpheTJjRDNkSi96OGIrS2dWNDZRZEd3YVJ2OVRl?=
 =?utf-8?B?WXNaRmRZYWZ6cDZYTzVRVGFUcEV0VmxhbExHZ1M1d01yZ0hPNUNIUGlWQUxB?=
 =?utf-8?B?ZEF5YkJpMDA4aEE4SngxNG1WMk8xN1VyUWFQQTNVSWtTVERwa21udlJod1Rt?=
 =?utf-8?B?M0hLR1ByelQxb1lZN3ZVVldBMkZvMERNeXlVT05UWVU0R3Q4WkRMNG40OVhQ?=
 =?utf-8?B?eU9RL1ZxSU12RDhFcU5pR1plKy9oQ0RXNDNrR3FjYmV1d0F3OC8xUzlEcGF3?=
 =?utf-8?B?dzcyUHNhTHUvMGVUVkkzTnROQlF4L1A4RDVNV2I5RVZTZ29ETWIxR1ZBcytx?=
 =?utf-8?B?MVREbkFuRmZEaW5DakR6bWY3ajJHbUprSHUvb3I0b1ljS0JHVy9RTytlOENQ?=
 =?utf-8?B?ckdnNEdxOUU2RUp2dGhYK1JDTlZKWnZuVncrNnFjRm5YdHhXdlNSTmJheHp4?=
 =?utf-8?B?ejRBaWdlYnZNVXZveEd2N1kxZm9YM1V0SlF4V05QNXZvdDF4ZHpSdTJjUERN?=
 =?utf-8?B?azZaTndSWlhwbWc5RktQUjg0cFJIMTFyZjQweGxrQ1RWd0xqY2MxTEpjRysv?=
 =?utf-8?B?MnFIcXZjSTk3SndNNTh0WjA1eWJLUUI3QThWYzBaWE5oRFY4MVpnVERCMnd2?=
 =?utf-8?B?Y25jdS9zRm4yZFhaTkVpTjFSckZkZ2dyVHJhY2NhbzNqRTB5Q09Fb0VlN3U2?=
 =?utf-8?B?WnQ3YlJuRW9Pc3hUNGpFK3ZWTWlnZTU4a1NkTnJORUZQais1N2JEbktvWm0r?=
 =?utf-8?B?aTVJcGFISHppaUZQY0VINGl5UU4rL1I0VktJOEgrWUYrbFF0UzZMNDFrTjQw?=
 =?utf-8?B?aDhWMHZDbHdYdjdzcDJNTndUMUs4RlpUeVdlcEJHVDZuR3psSkF0ZlR3aThl?=
 =?utf-8?B?MzIyOXhQaG92clZ0SWs3V0hxczRZNldGTHNqTkliSGpaaWcyekgvVTFJOTg2?=
 =?utf-8?B?TkRxMnNlS08xcXdpK0QxdlM4aGE4aGtRVUx1eG1lZFF4bUk2N2xIVWlCTWVF?=
 =?utf-8?B?MG4yVVNlMnh1M2JLb0VpVENBak1RVlo0cjA4dEN3UDFDeFpuUldJZDFPR01H?=
 =?utf-8?B?aE8wVDZ5ZnZsVVIxYVljcUVML2Evd3F1WkNpZzRONk8zS2Y1djFHRUFVSXJt?=
 =?utf-8?B?UkFiRWlHalp0eEF5WmFUMWowQmxjdHRINStJdC92TXI1MTYwL3ZTWjdGNk5s?=
 =?utf-8?B?dEJsMVp3c0xxK0VJNEtQc0J4Mm9tTW1ITUhvK29NNFNZU1F4NHhCM2dGYmlv?=
 =?utf-8?B?WC9BUm9WUExqbHdkcGpwWDR4eUJjREF1c3prUmxNaU9BM2txcitCRkFRZVk0?=
 =?utf-8?B?WU1VSXRVQWkrRjhtamdmc3Nya1NnVFNjeC9Jd1diWUlCTXl1ZTRjODNMNmph?=
 =?utf-8?B?T2JqSENJRlJaL3VRamNwdnlGdll6UE10S3kzV0pub3EzNnc4L25Zanh4Y2VM?=
 =?utf-8?B?QVgrSjNEcnNWUG55S05sWFFlcncxZ2xCTlB0Rkl4WlVBZVZ5NVE1QWRUUWpC?=
 =?utf-8?B?b1JxN1RoZ1FXSmdRSTBqa2p5TUhCNzduNHlPMXoxeEdnbzNyY3RLZE5zNkIw?=
 =?utf-8?B?NlJZRnVwQzVYR1VZV0JKbzExSURWL3JKeTN4ZjRMWjZNY1JoTkRFSVI4MTNY?=
 =?utf-8?Q?mFJYQEyhbga1j6xU2eAtEd6fK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf00290-51f9-4eee-cf52-08dba5823ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 15:44:55.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvLnSh7E8KGBRRarT5CQvsma6bN/oA5SXAFWJrVGAFje+8JlE8bKUr14TxtZc5z5hFYYB6UoeGtrhROsbL/n2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDI1LCAyMDIzIDc6
MjUgQU0NCj4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzDQo+IGVt
YWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiBUaHUsIDI0IEF1ZyAyMDIzIGF0IDE4OjM1LCBTaGVu
d2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBVbGYgSGFuc3NvbiA8
dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjQs
IDIwMjMgNDoyNyBBTQ0KPiA+ID4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5j
b20+DQo+ID4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kNCj4gPiA+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBD
b25vciBEb29sZXkNCj4gPiA+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTGlhbSBHaXJkd29vZCA8
bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsNCj4gPiA+IEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAxLzJdIGR0
LWJpbmRpbmdzOiBwb3dlcjogQWRkIHJlZ3VsYXRvci1wZA0KPiA+ID4geWFtbCBmaWxlDQo+ID4g
Pg0KPiA+ID4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nDQo+ID4gPiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBX
aGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UNCj4gPiA+IHVzaW5nIHRoZSAnUmVwb3J0
IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiBGcmksIDE4IEF1ZyAy
MDIzIGF0IDE3OjM1LCBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPg0KPiB3cm90
ZToNCj4gPiA+ID4NCj4gPiA+ID4gRG9jdW1lbnRpbmcgdGhlIHJlZ3VsYXRvciBwb3dlciBkb21h
aW4gcHJvcGVydGllcyBhbmQgdXNhZ2UgZXhhbXBsZXMuDQo+ID4gPg0KPiA+ID4gQXMgUm9iIGFu
ZCBLcnp5c3p0b2YgYWxyZWFkeSBwb2ludGVkIG91dCwgSSBhZ3JlZSB0aGF0IHRoaXMgYmluZGlu
Zw0KPiA+ID4gbG9va3MgYSBiaXQgcXVlc3Rpb25hYmxlLg0KPiA+ID4NCj4gPiA+IFJhdGhlciB0
aGFuIGFkZGluZyBhIG5ldyBEVCBiaW5kaW5nLCB3aHkgY2FuJ3Qgd2UganVzdCB1c2UgdGhlDQo+
ID4gPiBleGlzdGluZyB3YXkgb2YgZGVzY3JpYmluZyBhIHBsYXRmb3JtIHNwZWNpZmljIHBvd2Vy
LWRvbWFpbiBwcm92aWRlcj8NCj4gPg0KPiA+IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBk
ZXRhaWxzIG9uIGhvdyB5b3UgdGhvdWdodCB3ZSBzaG91bGQNCj4gPiBpbXBsZW1lbnQgdGhpcyBm
ZWF0dXJlIHVzaW5nIHRoZSBleGlzdGluZyB3YXk/IFZlcnkgYXBwcmVjaWF0ZSBpZiB5b3UgY291
bGQNCj4gcHJvdmlkZSBhIHNpbXBsZSBleGFtcGxlLg0KPiA+DQo+ID4gPiBUaGlzIHN0aWxsIGxv
b2tzIHBsYXRmb3JtIHNwZWNpZmljIHRvIG1lLg0KPiA+DQo+ID4gV2hhdCBkb2VzIHBsYXRmb3Jt
IHNwZWNpZmljIGV4YWN0bHkgbWVhbiBoZXJlPyAgSSB3YW50IHRvIG1ha2Ugc3VyZSBJDQo+ID4g
dW5kZXJzdGFuZCB3aGF0IHlvdSB3ZXJlIHJlZmVycmluZyB0by4NCj4gDQo+IFRoZXJlIGFyZSBw
bGVudHkgb2YgZXhhbXBsZXMgb2YgaG93IGEgcGxhdGZvcm0gc3BlY2lmaWMgZ2VucGQgcHJvdmlk
ZXIgbG9va3MgaW4NCj4gRFQuIFlvdSBtYXkgaGF2ZSBhIGxvb2sgYSBpbXggcGxhdGZvcm1zIGZv
ciBleGFtcGxlLg0KPiANCj4gZ2l0IGdyZXAgIiNwb3dlci1kb21haW4tY2VsbHMiIGFyY2gvYXJt
L2Jvb3QvZHRzL254cC9pbXgNCj4gDQo+IFRoZSBnZW5wZCBwcm92aWRlciB0aGVuIG5lZWRzIHRv
IGJlIGEgY29uc3VtZXIgb2YgdGhlIHJlc291cmNlcyBpdCBuZWVkcy4gSW4NCj4gdGhpcyBjYXNl
IGEgY291cGxlIG9mIHJlZ3VsYXRvcnMgaXQgc2VlbXMgbGlrZS4NCj4gDQoNCklmIEkgdW5kZXJz
dG9vZCB5b3VyIHJlcGx5IGNvcnJlY3RseSwgIGl0IHNlZW1zIHRoYXQgdGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gb2YgDQpyZWd1bGF0b3ItcGQgaXMgd2hhdCB5b3UgaGF2ZSBkZXNjcmliZWQu
IFBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSBtaXN0YWtlbi4NCg0KVGhlIGZvbGxvd2luZyBhcmUg
dGhlIGRpZmYgb2Ygc2N1LXBkIGFuZCB0aGlzIHJlZ3VsYXRvci1wZC4NCg0KICAgIHBvd2VyLWNv
bnRyb2xsZXIgewkJCQkJCSAgICBwb3dlci1jb250cm9sbGVyIHsNCiAgICAgICAgY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1zY3UtcGQiLCAiZnNsLHNjdS1wZCI7ICAgICAgfAkgICAgICAgIGNv
bXBhdGlibGUgPSAicmVndWxhdG9yLXBvd2VyLWRvbWFpbiI7DQogICAgICAgICNwb3dlci1kb21h
aW4tY2VsbHMgPSA8MT47CQkJCSAgICAgICAgI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCgkJ
CQkJCQkgICAgICA+DQoJCQkJCQkJICAgICAgPgkgICAgICAgIHJlZ3VsYXRvci1udW1iZXIgPSA8
Mj47DQoJCQkJCQkJICAgICAgPgkgICAgICAgIHJlZ3VsYXRvci0wLXN1cHBseSA9IDwmcmVnMT47
DQoJCQkJCQkJICAgICAgPgkgICAgICAgIHJlZ3VsYXRvci0xLXN1cHBseSA9IDwmcmVnMj47DQog
ICAgfTsJCQkJCQkJCSAgICB9Ow0KDQpBcmUgeW91IHN1Z2dlc3RpbmcgdG8gbW92ZSB0aGUgcmVn
dWxhdG9yLXBkIHRvIHRoZSBpbXggZGlyZWN0b3J5IGFuZCBhZGQgYSBjb21wYW55IHByZWZpeA0K
dG8gdGhlIGNvbXBhdGlibGUgc3RyaW5nPw0KDQpUaGFua3MsDQpTaGVud2VpDQoNCj4gWy4uLl0N
Cj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
