Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02BA7A6023
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjISKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjISKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:51:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC02F0;
        Tue, 19 Sep 2023 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695120675; x=1726656675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/y3AbeA7YN5glgNiZXPGgPJBI6+KgKuINinjLthNZRI=;
  b=V6W6Y2APg0jFUVRln+9jSDneCVFavBNbGAjxZ0H9aGCOLkXl3vXFwUyd
   qyeowU9KTzaWg7QqZNG1tcsoUv1Q4/K70i62qJuQwZ9g3JbVPkuXnFKAH
   HNiNj6E0ZqrhDq+wlrZO6W8s6yG5j9LVIvYoGD38thAL6jcJHdCDpJZCa
   Lvawdq3rL0I2P5aez05i5k7PuyHa/OjnG8vzDE/MC+1uTlkRyDgxhdOJr
   EP4OH8ox9KTpUoFQCFgM5iOzVEdQladV3Da650bvVyrlSZPW6WIhjEzT9
   SfvrYed43KMWAZfXMt1caq2H8HJ8s4mPBZnErpVE9q0WmO/e3M3gpiQjN
   A==;
X-CSE-ConnectionGUID: Dl8rEJVbQfa2mDeHznaLeA==
X-CSE-MsgGUID: TxDDzdSqTESSDUnWrEn0mA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5406910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 03:51:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 03:51:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 03:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HViqZlnRpIziMnlHq0KQxnQ1r3ZYu7SjHzypxvSxoyCLvsQlOy80MPM6o4mwW2ISg9iCIRCFnARtHf7GCfzHjjXt+BDUMYi5RNus84gMR+9ixPylZ9liM9UETgWMQ+ma6QK3gxp9F7qBCLKQvU0q9hpqWzBw59KJp4tolV30H1vzKOTInPZXwusaKQ3yHvgFyMmS/TNb9Y1tB0g+Y/0E/pMdFAhFODyXf62D5NtauJnZzgrReyEENQjyzBZWJqk04vTp9unZTWkb9GttMIUz4lmKoG1PJy4MWlIKvpqMhKw6qD/nJ1ctpCqV07q3/WyD5jrFvnLdvht0diMoQ+kyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y3AbeA7YN5glgNiZXPGgPJBI6+KgKuINinjLthNZRI=;
 b=G3xLG+wwBXQwOELXcwzVYbG2ECdYTtqwYru53+zZfCsCV1bbJcnjvBc1qpCZn0gZkEyoP9/g5mzWrKVLhOW/jUWyzW+DMS8FLwD5D6ZC2SnqMPnzy8/M59zgj/TEjEz84gITCr8xIadtZOEYrJN83yTltVK/olA/MRBshCV9cEhkuIwO0YuQB+ApwmWdE+CsVndTZEINmT1NV2LOWyR9r9RpoMupZVJJUHrDif8lu8P6iTEOQBU680R1jPW8XanDdvX28CQh9FJUjHqd9rKrCx/pun2wVO0T6hzN8t45+Mo85F/fYI2OxcinmTooZ6U3uKXNlHpqdYClSV/UXsRTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y3AbeA7YN5glgNiZXPGgPJBI6+KgKuINinjLthNZRI=;
 b=ozLk6dal7fb6qbICX4gJivYj4XnWpMJKCUZMwGxyZhvAJgILe5oPaP56kGrTj4pnIqueUlMZaemxFE2LDOiAQ/rGXPIXEhi0P8rDnSBIF3Ssc2cND/1pU7HR8OXqy6Uj2m3kz+Gx5w/gb4bHO1TwkRHxVwvz+c7WdlLMxbQcY0w=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Tue, 19 Sep 2023 10:51:05 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:51:05 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <Horatiu.Vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <Steen.Hegelund@microchip.com>, <rdunlap@infradead.org>,
        <horms@kernel.org>, <casper.casan@gmail.com>, <andrew@lunn.ch>
Subject: Re: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree
 support for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree
 support for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mE4qGiJRc4rzEqgohxfx8uHBLAT5cgAgAM68oCAABF1AIAK120A
Date:   Tue, 19 Sep 2023 10:51:05 +0000
Message-ID: <30954e1d-c764-4fea-d8dd-1f19c72c31e0@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-7-Parthiban.Veerasooran@microchip.com>
 <feb8eaeb-954c-416d-6e30-acb4b92764e0@linaro.org>
 <f429ea93-9cb2-8869-a98d-fb55161cf880@microchip.com>
 <439bf5eb-c146-2f67-1d64-4efa100ee85a@linaro.org>
In-Reply-To: <439bf5eb-c146-2f67-1d64-4efa100ee85a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DS0PR11MB7214:EE_
x-ms-office365-filtering-correlation-id: 3bbfc829-b4bb-443f-7fb6-08dbb8fe5300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWTzRF1q5CijCfKp/1A1A1fPbeDm5fZLI2HcOYbO4F8+F7AP/YiZc5ql22zZWTzbE2rqEWX6JxIcu3ga7SPS+pDZCPdACknr+AeoOO2ErH1N2ZRg8EvRwbVnqf+tZ6AAj6KvhhNl7fw0QSjKeofeh0hKUuAlBTLyiNAK1In9X+opkZG8VY9Dsx65osx2mAkouCG+1X4TngP+WDzgYY7rNkfpcN/NXEHhjCeNLoedZk7tb3YjMdv65QQZFp14V2q+wInFJQlJCAsjExoctYmxn0TZLOjmGrBZDVwEX+WJs2f622s20HVPDuUwJ4WSCX64+U/U95uZMxeK18S4DAIPdeGZm3QuJkeo3NwQivAcMqNQ6HEWCaI00KSVhTKfbBHTfbvsvJVMgGeqg0QjkUu3vZfe3R+4XUvkBltqLxPqbPM4u8VsLpfy1kK+j9bnBK65hwa+pSNzgiZdTtpFeZhOyhpEDpDdwVMRa/uYocj4J/5J6IQcv4UkSL6P5/PPCDkgyed6MHCikxzIwkpjdiFbjIQPYUMUxSOxIlBGU4wSAIFMlB/qQqF4B80es+0Kclvg8R/AuT8PZr9RcQKNpTmwWpxTQsnJ7yhLCEqk7zaqPhgqKDemE2+y2eoQUdzXvnGo0PeudavGZ2e9290QWZVq7xrbvsrgv8dSHP9G2Xe3N0Uf8jjR0EQQUVjPJz77kBkBAYJXT9tyoS+kIHg47KvUwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199024)(186009)(1800799009)(91956017)(76116006)(6506007)(6486002)(53546011)(966005)(66476007)(66946007)(54906003)(66446008)(64756008)(66556008)(6512007)(6916009)(316002)(41300700001)(31686004)(478600001)(71200400001)(8936002)(4326008)(8676002)(5660300002)(26005)(38100700002)(38070700005)(122000001)(2616005)(2906002)(36756003)(31696002)(7416002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1BybTRyUUJSbUI2Y1JtdCt6bWhpVUVuRnhGZVZiaEZNWXhOOG9jUUhqazFP?=
 =?utf-8?B?emxqQWFPYUFFV2p5eU4rWlo2TVRua0lPS2E0QXAyaUZ1eXVNZHRiQzBtRyt5?=
 =?utf-8?B?OTFzZzIrNnE0U01wamdoVlZvVkJ1eU1lV3Y5YTZJRVVrS0Jsbk4zdnptbWs2?=
 =?utf-8?B?cDhXU2JhTTkySDhLY2VqdXQwWUprbDJ0QkRNdVJyZENMdlVFd1ZEZ1RIZWl0?=
 =?utf-8?B?dGFVa1NYSXlGN2g0R0xrR0kvcW1SZGY3VitHTDQxdGlTQlYzNlpxRURzMnNJ?=
 =?utf-8?B?R3ZreXJlRGQyd1ppdzY1VTkzTmozSjJZMW5LU1pydGRLQnhsYkxydWJLSHQ3?=
 =?utf-8?B?d1d3c2d6M1hqUHRmNkIveXJYKy9oajdQQnpqMDliQmowVTFxSDd5L2picFdX?=
 =?utf-8?B?K3FUYldTWUxOd0NTL25sbFRQNnJxSkZ5eUt1ejdaYkVFYVBHZGphMHpNMmg3?=
 =?utf-8?B?OTFKVUFZbXFrbm9IdmpPM2dScVhoVS85ZWZNN0dadmRQaXhDWUFQWkVIOXd0?=
 =?utf-8?B?OUloU1BZRDVpOGtRZ0lmeXJpU2JZeGFoWmpJTHJpMVBiSDRUS2Uxc0N5bThu?=
 =?utf-8?B?MlZYVHRySk0rSzJseU9WRlZFajljY1JndHA5N0lHOHlXKzVSeTlEejkvZURT?=
 =?utf-8?B?b1krbjJ5N2hMRHpORXp1b0VMSjRJQzBLY2htNlFTSFZBVGZwN09pZ2o5Uncy?=
 =?utf-8?B?V2p1RTdVMVZuZ0xmd01tNVV6ZHh4Mk1JRDB0Q2JCS0N5cUwvUFB2aVdpTDlp?=
 =?utf-8?B?OVkvdksxSGQ2aU94bGlvWXovSmROSjdPWExDYytzL3FhckRtbzJ6Z3VQaEZL?=
 =?utf-8?B?NjlWYjV1M2c3Z0IzZE9UT0J6ODVvQWxQWUNVN3ArMWZZcThtb01lSnJPNHhy?=
 =?utf-8?B?eHMxV2VCejVWOC9CdGVpWnVCWWJkMExLUXVJb3h0bTBXN0c0M0hyMnNaaDlP?=
 =?utf-8?B?M0pJYnFCczhibkR0bGJLZTdTNU44MTNvSmN6OUp6SWdwVHpaS0pFU0RvTFlX?=
 =?utf-8?B?WjhabHB1Z3FRWWN1QktZOUdEdytQeHVGdHI1bjVKK1BlQitPZVA5c1JoTjVY?=
 =?utf-8?B?d3BxRit6U2h6d1hobEo4VXdOUlAwQ0NYRHRvUi9yV0NOY0JFVzFXOXBFSUhJ?=
 =?utf-8?B?ZkdRYUJrQ0Q0MVZoMnRJelJLMUNWemR5MjFWZXl3MTJscVZyQTBGWHFZbkJS?=
 =?utf-8?B?RTZ4R0wzU1dDWnFxNEVRQ0h1VytLYlZNZDhMdTlZYkh3eFE4U2VRakUwZzlX?=
 =?utf-8?B?MnJlenFLejdyNWlRbUJzcEl6WmRRcUo4YXNsWUpsQXNXeHlXWjFBbGxTU1pE?=
 =?utf-8?B?TlFUVUF1dnNqRmlJb01CdGpBYW4yY2UvQXd3Uzg2alFUQ2RJWEd3dmFsakNo?=
 =?utf-8?B?a3dMOHBla1ZwdkdSdGVjcHBUcmhjd1M3Qk5rN2tFemk0MktzVWNBYkgyczV5?=
 =?utf-8?B?QlJ6eWE0QlloRUU3UVp5K1hjREM5VUdZaExMVzBjOTBUMEdRNGY4QWlRd0Fn?=
 =?utf-8?B?Qk4yZWZidkpTK09aMmY0ZnVvcHI0cVlweVcvM21NZUdzbmxFMVBZY01OOXY4?=
 =?utf-8?B?R0xQbW1ZcFNMaUsxT1R0ZjE4bk15Vm1VYXRUM1NLNDd4dXZpQVVBZWNKdHc2?=
 =?utf-8?B?NGdGZkFFajY1cnVqdTNBb2lVOTlMeXo0ZFhxcXh4RDdxanZqMmRiM3dTZW9r?=
 =?utf-8?B?dDIwWjB3VGNHd0kyMVVzSmNsOFp4a0pJNGh0K3haLzNRbjl2Q0xHUWkwRS9F?=
 =?utf-8?B?dVl4RDlTMmt1L2czbGEraWNRYU9IaTNob1BWR1BqRkdtbytLSFUxRGUzTko1?=
 =?utf-8?B?TXF3QXpmQzhpT1NLazhibElVRFBuSy8ycDVuYWRYdG9LdXBpOENPZ1VDMGlz?=
 =?utf-8?B?ellVNUxzMmdQcm1WdnFOc3BsaDk4bDNpdXdWRFNId3Z2ZXVhL0FDQkgxREZB?=
 =?utf-8?B?VFR1TktFb0doSjRiVWFPa1hUcXRVZHJOb2dlMHAvVkl3N3c3ZmlLcHF3Y3Jp?=
 =?utf-8?B?OXRndllueUM3TVhQT3ZldERUM0c5NEJ6T2pSV2h6ZlNuVTVJRFFWaGF4S2ln?=
 =?utf-8?B?SzYyK09oUFB2M1A2VTlENVZPMTNUYTFlUEcwK3NGdnI3M2hNeE5QdkFlKzFP?=
 =?utf-8?B?VTFET0hMZk4wMkNVMmVSc2hwSXo4a1krY0R6QlNCNlM0YmV2d1VacXVxc0Z1?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B52BA0EBC776CC4B943659E7B2F838F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbfc829-b4bb-443f-7fb6-08dbb8fe5300
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 10:51:05.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qwNb+cBcdfCZou108PZqbddXCrMQ+jivWFkNNEcRFZDy+wVb4CpBAXyZa70OPWEc6oz/5N8cvmMu34uf+aZ65cNjpKOC9BZEPKCAhiEcH57bULNafO2Ke68hfdEYCxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAxMi8wOS8yMyA2OjQ3IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEy
LzA5LzIwMjMgMTQ6MTUsIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gSGkgS3J6eXN6dG9mLA0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBw
YXRjaC4NCj4+DQo+PiBPbiAxMC8wOS8yMyA0OjI1IHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24g
MDgvMDkvMjAyMyAxNjoyOSwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPj4+PiBBZGQg
ZGV2aWNlLXRyZWUgc3VwcG9ydCBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WCBNQUNQSFkgZm9yIGNv
bmZpZ3VyaW5nDQo+Pj4+IHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlh
bCBJbnRlcmZhY2UgcGFyYW1ldGVycy4NCj4+Pg0KPj4+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVm
aXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvcg0KPj4+IGV4
YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUgLS0gRElSRUNUT1JZX09SX0ZJTEVgIG9uIHRo
ZSBkaXJlY3RvcnkNCj4+PiB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nLg0KPj4gT2sgc3VyZSwgc28g
aXQgd2lsbCBiZWNvbWUgbGlrZSwNCj4+DQo+PiBkdC1iaW5kaW5nczogbmV0OiBhZGQgZGV2aWNl
LXRyZWUgc3VwcG9ydCBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WCBNQUNQSFkNCj4+DQo+PiBJIHdp
bGwgY29ycmVjdCBpdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+ICJkZXZpY2UtdHJlZSBz
dXBwb3J0IGZvciAiIGlzIHJlZHVuZGFudCwgZHJvcA0KQWggb2sgd2lsbCBkbyB0aGF0Lg0KPiAN
Cj4+Pg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBh
cnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgLi4u
L2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sICAgICAgIHwgNTQgKysrKysrKysr
KysrKysrKysrKw0KPj4+PiAgICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMSArDQo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygr
KQ0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4
LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxs
YW44NjV4LnlhbWwNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4zNDY1YjJjOTc2OTANCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwN
Cj4+Pj4gQEAgLTAsMCArMSw1NCBAQA0KPj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+Pj4+ICslWUFNTCAxLjINCj4+Pj4gKy0t
LQ0KPj4+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvbWljcm9jaGlw
LGxhbjg2NXgueWFtbCMNCj4+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPj4+PiArDQo+Pj4+ICt0aXRsZTogTWljcm9jaGlwIExBTjg2
NTAvMSAxMEJBU0UtVDFTIE1BQ1BIWSBFdGhlcm5ldCBDb250cm9sbGVycw0KPj4+PiArDQo+Pj4+
ICttYWludGFpbmVyczoNCj4+Pj4gKyAgLSBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPHBhcnRoaWJh
bi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4+PiArDQo+Pj4+ICtkZXNjcmlwdGlvbjog
fA0KPj4+PiArICBEZXZpY2UgdHJlZSBwcm9wZXJ0aWVzIGZvciBMQU44NjUwLzEgMTBCQVNFLVQx
UyBNQUNQSFkgRXRoZXJuZXQNCj4+Pg0KPj4+IERyb3AgIkRldmljZSB0cmVlIHByb3BlcnRpZXMg
Zm9yIiBhbmQgaW5zdGVhZCBkZXNjcmliZSB0aGUgaGFyZHdhcmUuDQo+PiBzdXJlLCB3aWxsIGRv
IGl0Lg0KPj4+DQo+Pj4+ICsgIGNvbnRyb2xsZXIuDQo+Pj4+ICsNCj4+Pj4gK2FsbE9mOg0KPj4+
PiArICAtICRyZWY6IGV0aGVybmV0LWNvbnRyb2xsZXIueWFtbCMNCj4+Pj4gKw0KPj4+PiArcHJv
cGVydGllczoNCj4+Pj4gKyAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICBpdGVtczoNCj4+Pg0KPj4+
IE5vIG5lZWQgZm9yIGl0ZW1zLiBKdXN0IGVudW0uDQo+PiBPayBub3RlZC4NCj4+Pg0KPj4+DQo+
Pj4+ICsgICAgICAtIGVudW06DQo+Pj4+ICsgICAgICAgICAgLSBtaWNyb2NoaXAsbGFuODY1eA0K
Pj4+DQo+Pj4gTm8gd2lsZGNhcmRzIGluIGNvbXBhdGlibGVzLg0KPj4gWWVzIHRoZW4gd2UgZG9u
J3QgbmVlZCBlbnVtIGFsc28gaXNuJ3QgaXQ/DQo+IA0KPiBJIGRvbid0IHNlZSBjb3JyZWxhdGlv
biBiZXR3ZWVuIHRoZXNlIHR3by4gUGxlYXNlIHJlYWQgdGhlIHdyaXRpbmcNCj4gYmluZGluZ3Mg
Z3VpZGVsaW5lcy4NCk9rLCB3aWxsIGNoZWNrIGl0IG91dC4NCj4gDQo+IA0KPj4+DQo+Pj4gTWlz
c2luZyBibGFuayBsaW5lLg0KPj4gT2sgd2lsbCBhZGQgaXQuDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4+
ICsgIHJlZzoNCj4+Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4+PiArDQo+Pj4+ICsgIGxvY2FsLW1h
Yy1hZGRyZXNzOiB0cnVlDQo+Pj4+ICsgIG9hLWNodW5rLXNpemU6IHRydWUNCj4+Pj4gKyAgb2Et
dHgtY3V0LXRocm91Z2g6IHRydWUNCj4+Pj4gKyAgb2EtcngtY3V0LXRocm91Z2g6IHRydWUNCj4+
Pj4gKyAgb2EtcHJvdGVjdGVkOiB0cnVlDQo+Pj4NCj4+PiBXaGF0IGFyZSBhbGwgdGhlc2U/IFdo
ZXJlIGFyZSB0aGV5IGRlZmluZWQgdGhhdCB5b3Ugc2tpcCBkZXNjcmlwdGlvbiwNCj4+PiB0eXBl
IGFuZCB2ZW5kb3IgcHJlZml4Pw0KPj4gT2sgbWlzc2VkIGl0LiBXaWxsIGRvIGl0IGluIHRoZSBu
ZXh0IHJldmlzaW9uLg0KPiANCj4gTm8sIGRyb3AgdGhlbSBvciBleHBsYWluIHdoeSB0aGV5IGFy
ZSBoYXJkd2FyZSBwcm9wZXJ0aWVzLg0KV2lsbCBzZXBhcmF0ZSBoYXJkd2FyZSBzcGVjaWZpYyBh
bmQgT0Egc3BlY2lmaWMgcHJvcGVydGllcy4NCj4gDQo+Pj4NCj4+Pj4gKw0KPj4+PiArcmVxdWly
ZWQ6DQo+Pj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4+PiArICAtIHJlZw0KPj4+PiArDQo+Pj4+ICth
ZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+Pj4gKw0KPj4+PiArZXhhbXBsZXM6DQo+Pj4+
ICsgIC0gfA0KPj4+PiArICAgIHNwaSB7DQo+Pj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPj4+PiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+Pj4gKw0KPj4+PiArICAg
ICAgICBldGhlcm5ldEAxew0KPj4+DQo+Pj4gTWlzc2luZyBzcGFjZQ0KPj4gT2sgd2lsbCBhZGQg
aXQuDQo+Pj4NCj4+Pj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjg2
NXgiOw0KPj4+PiArICAgICAgICAgICAgcmVnID0gPDE+OyAvKiBDRTAgKi8NCj4+Pg0KPj4+IENF
MD8gY2hpcC1zZWxlY3Q/IFdoYXQgZG9lcyB0aGlzIGNvbW1lbnQgbWVhbiBpbiB0aGlzIGNvbnRl
eHQ/DQo+PiBZZXMgaXQgaXMgY2hpcC1zZWxlY3QuIFdpbGwgYWRkIHByb3BlciBjb21tZW50Lg0K
PiANCj4gV2h5PyBpc24ndCByZWcgb2J2aW91cz8NClNvcnJ5LCB5ZXMgaXQgaXMgcmVnLiBUaGUg
Y29tbWVudCBpcyB3cm9uZy4gV2lsbCByZW1vdmUgaXQuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRo
aWJhbiBWDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gDQoNCg==
