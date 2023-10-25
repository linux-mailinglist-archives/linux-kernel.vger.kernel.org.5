Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7D7D6A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJYLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJYLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:40:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3089129;
        Wed, 25 Oct 2023 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698234005; x=1729770005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h7eTP0bDqVcVyFR9UYksOtstVrHc7Wwh7qXmouWHXOU=;
  b=iLlgwNS5B4aqMPOSGiUXGHROkEMnrp192MW96xVSInV2JJOp1H7+L6D0
   jj6Yhh21lbVJevSz9LjP+D29f3D1qtJ1JIgk34VeT4l+xxXXEKl/prwSp
   UWg8j3S/XwGkVT4IFn0TobJ74H7hK16/YybW3ud3BS+GP8z3dtBjk9BhB
   FRNHUrlJ0SnpvoqjN8IjLZh034s2mM19sJApmm9Id7tlfgExJIzCRXTE8
   h3tXqaIpEDt9BeiYH18pj/OQ9rZN/YwxP1VByZVDdZZhaByZKxVtN65Q3
   lpg1t4lzC63S9nbmCwM1ZkPTNLw7gJ7fsTa3sx8klernN1G1E+Y7tgczi
   g==;
X-CSE-ConnectionGUID: zlNFRjvlT3e17oSp8X6trw==
X-CSE-MsgGUID: 9TNapRfwSX2GWZwe0oDr6g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="10663356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 04:40:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 04:39:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 04:39:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab4314D12jA8YHFYuSfHeoz8JVZIBV8RGWMjfp66LJkRvhU16r4YkWvRrPYiDSl12SZFjELqypRZnej16R/Xxtt+RmbQBH8LzyCgrMtALXNhkgYWF6pOz7u5hYXg+ajTJsU11HOCl6sPlG1QqyW+ftCKdEaG8MvZIctgjzwzS4cStaqxjBQeUhZMsJOZ6/++0hoCprJBiYrEcPhf91tJ+q2f3eRNzNZUeuTckI16fZ3/JgTaUeeee/+SQsPVHr5T2HlaZAPUw1P8Vs6K/gQZNjRHZuNmEngahBOVzoIq3SFQBOZJ33NGbTYm0BioxpAXKKM+9CfTN2f4R6S1P3dmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7eTP0bDqVcVyFR9UYksOtstVrHc7Wwh7qXmouWHXOU=;
 b=lPPb49Wgwp4xA/vyz/0mUjeHu9LlRtsPOxqndErx4LaO7pf/FyCq85UhgDGeOcmW0U462fTfMYOXENAFMxQ0ZfuGjaVor+bECq2H3GzesSfRfuba3mNHYAxuCJkChH5BgiyhXZpdgrrcgjNqg61953qopDdS2O9a6y61s0ZMalv2Mv0GNIIolTpYa5OHGSunx+dlcDPA6hGOk2emHfcMgByWc5ETZOkR5dyo6Fx6+nGEq5/XViERulfGZFvNATijM8PDYIbPLYTfDIDrULPrpm+h7ndp+hcZyUdF/rK4527I/JjFMT+erBJkzfC2PxoCRsnDqerKm99Ip4Qmw1c/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7eTP0bDqVcVyFR9UYksOtstVrHc7Wwh7qXmouWHXOU=;
 b=XHeJDT6zQrRVxAZsia9rzyJ1Zr1NH3FqcQ7JX6ETRYp06OfOw2qjkiokHa8fMd4zK0ofC6psmg5ZiHRCqnBfmnCJrC0P+JMrMe6NLGIvNAGjvZWsD1H7B77BOGexMLYnGzYYP9AeO3EaP3JgMo4zDvcZzvnaK0hh+OEyxsvV2BI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Wed, 25 Oct 2023 11:39:50 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 11:39:50 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Topic: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Index: AQHaBchLKhew5fqyxUWYo0q8cO3RgrBX+QGAgAJrWwA=
Date:   Wed, 25 Oct 2023 11:39:50 +0000
Message-ID: <fe52e414-c2a7-4e29-bb37-73a5614b3951@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
 <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
In-Reply-To: <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH0PR11MB5952:EE_
x-ms-office365-filtering-correlation-id: d452d7ce-9aa5-4300-4e05-08dbd54f1939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLnZPlYxqQDSGbHZ+JQGXgnDg9HItPbtr7eScWrnGYu1MZ7fdEp1Xn1aBPmSv0lS3v7on8UXhCrYx0ux4GJgOwLFs16lLxhdIIT+iCVX57w/PXrk6roSoTwEeReoIacIEVBdrGHTYCrGXmhiuSM0TrGVTaMBjQs5cgQ+B2H8VTsNXliduNiINnq2B58IccViNdf9fBQIZc6c814NLjGERLvI3+QUlhigrLwPesIYRcQLMTiit1PgRnwSsXOT8TfpKcYfdmJBTf+vUGbD3eY6E6vKoeh68HQXXE9GbP3Z9Hc/qdAFIbomTT7htnCd3xbccY02POF4j1JKesz7bG7Wd7QoCanWfO2hnXfRfKdQNJz49JcwZ63bAU6qmUhOOyGkX48nXh3GkG8wnUA9yTNn0Y6XA8E+sFuXdr0fi+xNQrFMgpPcMr9uCXgaF6wNSRIkULbtA4FJGCrnoRLwlPFxb/RDb3jSt8NKLbTBDp0IHfDFAVHWhx2cdiUwr+H5ojlnrEAug9x2GJCt7EWAIDfFoCFLu6yl19wPXJ2/PtF5bRBpnyWmjnc+UD7mVKRAycgnlLmICB4HkQb59XNq3UK8PVKSEL72Myws4ddjQNV567mgriNNACvYMCg+Zn/QagsOtZRbhLSayfR8gjJPVdcux0XYJckEO1e0OOwHzr/Fe1VzNs9AZJxSlrjHVCGPc/3H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(38070700009)(31686004)(53546011)(6486002)(91956017)(2616005)(122000001)(316002)(66446008)(107886003)(83380400001)(36756003)(54906003)(66476007)(478600001)(7416002)(64756008)(8676002)(76116006)(31696002)(2906002)(6916009)(86362001)(71200400001)(38100700002)(66556008)(4326008)(6512007)(8936002)(5660300002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFpHRFBUOE9SL1h2Mkh2d3V5MkNsZ0xjM3VEcXI2MGNyK0FwUjVQY1lyQm11?=
 =?utf-8?B?TjlCUWtrQURzRzdkZ2xqTnFaeHZlTXJVOEk1OGZFbzRrbWxBZDRobk5uY25M?=
 =?utf-8?B?bzJXcFZ1TnNhV2hqNEVkMGhxWlZ1MnF5ajNBTy9OQkpjdFg4UVhnOHA0MHpY?=
 =?utf-8?B?ZktXTVJUa2UwcDMrcVBUZjRFakE4aGV0ZEdLU2NWLzJkZlRES1ZJTmF5SCt2?=
 =?utf-8?B?dWlMV3VzOUNJSSsrLzZGY21FazNkY1NMamhNM1VHSk9KMGFkaDJ2MmliZ1pt?=
 =?utf-8?B?Szl5dkNMd1YzYi9JaUJsQ05LSGMwQ2pjVFlEOTdGR1crZlZNejhncFlpVkpN?=
 =?utf-8?B?ME9DTTNuRnQ0VkVSc3EvSWR3ckUwNFRPZnNTdnZIKzRaZDRJUDhGR1B3bHpI?=
 =?utf-8?B?WVp0YjRobFo3Z0xmblpZMk5UUEtBNzd5RUdMZEtRL0pXTCt0azkyY3J0MTVu?=
 =?utf-8?B?SUNQS2pGRUx4cFF6bjc2SmgyamtvRy9mNnAybS9nUGRZeXI3ZlZtandtdGxR?=
 =?utf-8?B?VUZVUnpTdU1pVE9yZ3B0UXh6SUEzTWZpcHJqT21JZ2dFTG1qRHVaVW9RUjVv?=
 =?utf-8?B?UDIrWk1JS3Z0SGxzN05HRVQ1d0xzZlQ0cHUrSXlFU0d1QW81ZVZvK1E4S3F6?=
 =?utf-8?B?Ly9KZmJqS0ZnNUFlR0c2dzZ3WEIxelJpcHBhaHNINWg0NW8xOWZ0VWFOWWhC?=
 =?utf-8?B?UUNzOUF1eVB1cjJHajFidER4Mms4cjVjRVUwTCthV3VEem9NMFJLc1dieUZl?=
 =?utf-8?B?enRjZnE5bnhVVXNYOXVXUGN3Q1RBZkRiTGViZ1M0WlNjWWhZWjZOdTlnZ0dh?=
 =?utf-8?B?alhTQUpzWFFKcXAwTGc2dGJqVDhhYnExQ0lqTnJaVGhKZUNCWmIrZUpvRmd2?=
 =?utf-8?B?NDJManBtUWk5a0c3Z0RsZDQvRnU0eXpUVVNwalR2VjZVVkdpb3JkUm1SOU9o?=
 =?utf-8?B?dHhtdGExY0xDSWx1ajUzaGZVUTRHeHNoNFFEZlFZRDJFWnJBMHExSG9IU0Vw?=
 =?utf-8?B?bm5nRzNWUWgydWg0YnJITlhzY3hHUzRJWE9XNllYaXU0akhOV0VMTyt6RHRq?=
 =?utf-8?B?UU1SV20raCtZVHNidkFmWDNaZ3VzOHZhSEh5TUp3akM5THh0cGhobTBteldZ?=
 =?utf-8?B?WnpNNmJTVUJYTHZtWCt1UGtpQmNwb3NLN3hEN0tuR3hRQWVXeHJZV1dTcThn?=
 =?utf-8?B?Mm50MGVoVllvVnpHL0t2NGR4eUM4WmJ6TDdOYXRMK2JrazJsaU1CTnl2UUVU?=
 =?utf-8?B?VFFEMUZOZVNhSU9xNkRtK3hDWGhHVzQ1TmJOLzduMm1TYUZ6bEk2d3NCRnJV?=
 =?utf-8?B?enpvcTIvUm5xWUdYVG9neG54WFkwTittUURvcEs2SEdGTlp0bTFtRjZwU2tF?=
 =?utf-8?B?ajMrdm1lU2FzNHdXQVNOL0hGcXd3aU1mM3VCZzBERVJ3bzJjelV2cXBnQ29L?=
 =?utf-8?B?Zm5Uam80M0Z4eTZWRnF4c0RIbEd2V3BDZ01CTVo0cjEwN3ZkdFpxbEtYSGs0?=
 =?utf-8?B?MXV2VVRBUnJ6aWhiY3c3V3AzM2ZDRDVtNDJ5cG1pMFlrSFEyYXRNWGZpSDFp?=
 =?utf-8?B?WjhvcU81RW1YS1pOK3A1eCtLRGdCWlU4VmFqSlRSL3dSNkViS1VjcWJ0d0Jj?=
 =?utf-8?B?eDJvL0Q5NDNmWUpWSnN1Y1JxVW1DWFpZajVnR2QwcVpBRDM2RldtV2RVeExa?=
 =?utf-8?B?S2RsUTI1L2pXQ2lLNmdWamFqam93Q1BCeVVpWkMxSHliYW41OG0waVNtNzIw?=
 =?utf-8?B?WEd0a25UNEJueDk0d1NpaFlLcHhsQVJ5a1QweUFLMFA0akIrT3dpVlVLNzhN?=
 =?utf-8?B?M0M1R0ZTbHk0MVM4OTkwTG0xOHEvaWNBZXYveHlQQ3VOZ3VQalA5ZkhCSFJs?=
 =?utf-8?B?Qk9NTnoxTFROelpYWW9FL2ZhVm4wakxLU1l2Qm9Zc2tUZ0RJU3V6cmFmRjgr?=
 =?utf-8?B?a0E3Z1BVaXBKYlRYanRROTV2dkdlaVhNZmJ0Nk4zVmZLYU0zQjk4V3N2aEht?=
 =?utf-8?B?S3Bxd3UveUZmNEZMZFRaaVpyU0N0Um41TmFKU0FkOUhBZHNYNHRUVURKbTZv?=
 =?utf-8?B?RXBOdUVaR1BkN3cxd1NRWUJIMDFKZ2hmbml0SHpjL0NzZEZJQy9IVlZsZlN0?=
 =?utf-8?B?cUpaeGNhS0FWMTZCaEVhdUZ3RTJBY1h1VlN0RXZ6a1B0N3B1NEM3VnBpTEQ3?=
 =?utf-8?B?d3ZYR0MxU0dQK3RuaUpMMFNVWVJnR3RJczJlQ21ZbzV2MnY3emJBeXZPZ2NW?=
 =?utf-8?Q?sFTTLOlbzV9FZOgTbTltxjnJrEMUoCm0G5U1FR1siI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30EF12D6BE938C469DC8AA85C99C3982@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d452d7ce-9aa5-4300-4e05-08dbd54f1939
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 11:39:50.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jN1gR3PP6GrIHKJkvVpQ+eBbWZKVgUbtfvQrO9SsntjiiPrH2Fetr/GZ7j5QM2/jeoKHWKs5R63PypcL6MeCDm+uZqp0BDXf0jsbPKQtTjEmUtSszhnmznpcWtbwmu/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA0OjEzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgICAgcmV0ID0gb2Ff
dGM2X3BlcmZvcm1fY3RybCh0YzYsIFJFU0VULCAmcmVndmFsLCAxLCB0cnVlLCB0cnVlKTsNCj4+
ICsgICAgIHJldCA9IG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2LCBSRVNFVCwgJnJlZ3ZhbCwgMSwg
dHJ1ZSwgZmFsc2UpOw0KPiANCj4gSnVzdCBsb29raW5nIGF0IHRoaXMsIGl0IGlzIG5vdCBjbGVh
ciB3aGF0IHRoZXNlIHRydWUvZmFsc2UgbWVhbi4gTWF5YmUgYWRkIHNvbWUgI2RlZmluZXMNCj4g
DQo+ICNkZWZpbmUgVEM2X1JFQUQgdHJ1ZQ0KPiAjZGVmaW5lIFRDNl9XUklURSBmYWxzZQ0KPiAj
ZGVmaW5lIFRDNl9QUk9URUNURUQgdHJ1ZQ0KPiAjZGVmaW5lIFRDNl9VTlBST1RFQ1RFRCBmYWxz
ZQ0KU3VyZSB3aWxsIGRvIHRoaXMuDQo+IA0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIC8qIFRoZSBjaGlwIGNvbXBsZXRlcyBh
IHJlc2V0IGluIDN1cywgd2UgbWlnaHQgZ2V0IGhlcmUgZWFybGllciB0aGFuDQo+PiArICAgICAg
KiB0aGF0LCBhcyBhbiBhZGRlZCBtYXJnaW4gd2UnbGwgY29uZGl0aW9uYWxseSBzbGVlcCA1dXMu
DQo+PiArICAgICAgKi8NCj4+ICsgICAgIHVkZWxheSg1KTsNCj4+ICsNCj4+ICsgICAgIHJldCA9
IG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2LCBTVEFUVVMwLCAmcmVndmFsLCAxLCBmYWxzZSwgZmFs
c2UpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+
ICsNCj4+ICsgICAgIC8qIENoZWNrIGZvciByZXNldCBjb21wbGV0ZSBpbnRlcnJ1cHQgc3RhdHVz
ICovDQo+PiArICAgICBpZiAocmVndmFsICYgUkVTRVRDKSB7DQo+PiArICAgICAgICAgICAgIHJl
Z3ZhbCA9IFJFU0VUQzsNCj4gDQo+IFBlb3BsZSBkb24ndCBhbHdheXMgYWdyZWUsIGJ1dCBpIGZv
dW5kIFNUQVRVUzBfUkVTRVRDIGVhc2llciB0byBzZWUNCj4geW91IGhhdmUgdGhlIGNvcnJlY3Qg
Yml0IGZvciB0aGUgcmVnaXN0ZXIgeW91IGp1c3QgcmVhZC4NCkRvIHlvdSB3YW50IG1lIHRvIGRl
ZmluZSBTVEFUVVMwX1JFU0VUQyBpbnN0ZWFkIG9mIFJFU0VUQyBvciBpcyBteSANCnVuZGVyc3Rh
bmRpbmcgd3Jvbmc/DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAg
ICBBbmRyZXcNCg0K
