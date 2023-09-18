Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7587A45D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbjIRJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjIRJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:24:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555AB10A;
        Mon, 18 Sep 2023 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695029082; x=1726565082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBLo8RSiA4+VPh/gflbudfWUTirQ8DEpQN+f4eh5HTM=;
  b=pA6/i6uhBLOYYzgg1xlSf8dYDxxIqiLAHLrKfBQ7oLwR9B11ezCg5JTs
   P5QCrYT0RGIADZ84aLFifvBJsDRjxWL2p0mLRCN0KHq4N/GVBomMSj8Js
   kLJeY/Dysi4l9iCwxSZCFtS/yBGeQTcNaMsnows5wM+Ymzd4XvCrbN6hz
   cpnvuaHZZEeZ6PwHA3YGUTNrmBobCQgD/pwOQYG/5tR3xVv+iFtiPqntZ
   8kxH9XBlrIv/K2FBIzYp2U4LU7JKDBhj3NM6w6vvf3N1uSHcW1RkB+ES3
   5CLGXbVqhZvsj9hnDcZGne2lQr8lLpq1VUq2oTuRWHLpiIMEM3YY5wqed
   g==;
X-CSE-ConnectionGUID: CLPLQpskQDi9rfQvvrRf3Q==
X-CSE-MsgGUID: UQlJw/OrSm6lgrfH0xdQ3w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="5069830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 02:24:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 02:23:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 18 Sep 2023 02:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzIv7gHqOmL9pvSYxCU3DZjZtl23aJU4t12uWOlRFrLachilcbjZOs6U2rN0hQOseqsJ5uHWZtpHDHMxQaqSr4m9u0XkLOaNBW53mUBVwpTr7bEf/BhgeqsOBIm3UUukllHz7DC+Kt3HId1Lq4/FkXNNdkFZz/bbdNe9SZHW5/DcLU/ULnQ1IKEEA2pluvTpvVDz2Ek7qvUnxJ+3WrlTvi3uaoI125iW08A1rraVnerAa/oUEuI2sorUzo7F1m3ZmSfmHWxLGHsBwbhYzsnOFW7RzG+kUMcuhCFO3vGnzsoci0tzTRihRbMtf5+GLKfx9CJqqij/bfMxGc9zwN6B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBLo8RSiA4+VPh/gflbudfWUTirQ8DEpQN+f4eh5HTM=;
 b=PptBWdm0K5OKF0nbEqFm6K3ovyP0ar8N3r21lI80X6cZwBPKd112Og25Hn+9fXA0dKc5jLNUANhpM2+T9Y5ViCZG6iv/Mfur7gBgr5mM5u9FLLXS/VOWCbGWh1YJQVwp9yudDgANRYnfLhUv67vMMZD3l8VNZXoTOs8wNpheC4OtVz8wV6/uaTx0vJKNltz7bf8elOVtZReLrZnOMJX/zmh4QSQPQ4kEEStMMEJnkEee1ObEpI2ocT7lsaqz+P9OVpnUUjDxjyQnCekviBQ3/pLw9+8jmYXUtPmugdNVyJFhAQ9NT5Trwf5rPAJk+9l0dw83sy0sCutn5xsIoZ/ESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBLo8RSiA4+VPh/gflbudfWUTirQ8DEpQN+f4eh5HTM=;
 b=R5UUrDz19a571OovLs4YcXlEuOeojbAXDxzVKue9zjDUvYKIY2RgkaQMNuL7zaqzMKLZqN6+eLQgJ0hNpFebTPsq22Nrh/EPMY5/v5trLxAtKMg6P/l5WMqHsiljYovkuQlesyJwxTHkfhFSdqJs2zH/CmsO/+C9fL+hVnlNLg0=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SJ2PR11MB7598.namprd11.prod.outlook.com (2603:10b6:a03:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 09:23:55 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:23:55 +0000
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
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHZ4mDzB/QUuCJz5U6/cDo3W2/tF7AT5fQAgAThHgCAACbuAIAHcNKA
Date:   Mon, 18 Sep 2023 09:23:54 +0000
Message-ID: <a6414443-c5c1-6380-110c-626e6ea649f1@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <eef69aa5-73c2-9789-9f6d-c3300553c44d@linaro.org>
 <fab8908e-ce74-eff0-8e67-6259b3ad5e1e@microchip.com>
 <588db15e-62f1-ca9e-211c-21d58e15bd73@linaro.org>
In-Reply-To: <588db15e-62f1-ca9e-211c-21d58e15bd73@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SJ2PR11MB7598:EE_
x-ms-office365-filtering-correlation-id: 9503737d-7016-447e-40a2-08dbb828fad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYh9HNaKCF3CVk4uduJ+DNHxePODofDP2i3lzoTwq1voWCVG2ZeycKRZv4HH05ha6PmSj7F/HEV+aBb2Gp8JwY79ChR3O/QgdaPl2JlyFRjLdajmnflaRl+86gGsegqoVu0ET9JHQnxqo/c+FqJ9EcS6d6RO8OsFTHp8KUtWNxLHo4LvPqQAQm+nDpVzYFIfGxKSLXMQ0lLlBhfoOyu+kEVgJc+pofhgV10dijYTzyT4kkrtdpYQOHEUtWv0kdGCSfdrfYJsdZ3Tk0PzGZC7dFBmohYRgeMLyF7BtRwHx/3KLf7NgyBKkCWhSNeogmCPwSmwko7/hVOLwVxQmgJHHRQpAknpRTekH2fiJaQz5+zmjQTIxig2B2bsLrL89Xa0nLwqBltMGTVn+b8jNmc8/FKdxc4qhJhxEDL7pWjy7xcWACI5cFjbPZtR6eVlc/Nxu/3YiO8ies5D1FV8P2rQWyFP6BlDDpZ/SpU837EXs0aZmX/DwPCV5AIGXbGPk93S4k/ZlKPsZx7SonTTrlWGbUCoEQzTZ6U/XeXOrMdH/MM+jEOAULeu7xUQUJZaAJ6iCjVM4C9jjLw1tlee/kzcTA0pUdHXK2dsxFlu7yu1cyoZRMHpCqNe1IsKePf80nGxJT5ZP3RRmC7vfFILluQKMQi2Y4wTFNdfnS1KBq+rv5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(83380400001)(31686004)(6486002)(6506007)(71200400001)(53546011)(31696002)(38070700005)(36756003)(38100700002)(122000001)(2616005)(26005)(6512007)(2906002)(5660300002)(478600001)(86362001)(91956017)(4326008)(8936002)(7416002)(8676002)(76116006)(66556008)(66476007)(316002)(6916009)(64756008)(66446008)(41300700001)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3pRb3grUjl5d3VmMFN2Tk94N1BiNGF0dlcvMjFDTXkvak14N0RlWXMzUU5U?=
 =?utf-8?B?VU1aanVGM01wZkJ1VmU1aXc3ZXlobW5BLzFvZisySHZJMkRjVWo1RUhlUGM1?=
 =?utf-8?B?V2RuR1BQbjNySjUreTZwRE12RExwS3ROYlgxaDJhakNwY1VQMnNPMmt1Y2wr?=
 =?utf-8?B?M0tuMEVPQmJqZ3dFU1NXL2g4ZnU4UEJOQnppbGNIcHdXY0hHVGxBbTZabUNY?=
 =?utf-8?B?NU83Q3NtcjlGOGgzc2lDeUFOOTFZTldjc3BpekNVa1ZaUDVpM00zWW83UnpF?=
 =?utf-8?B?RzZtQVhGcjc1Q2xZaHpLWXNueGk1Vnh5bnFYbEpkM0Y2WTBJNlpwRHhEcUVa?=
 =?utf-8?B?cTkvZU1rSkJvczZabTl2di9NUEsrVzhpUWN1cmEyd0kzWEZGUnlINlRyWFlO?=
 =?utf-8?B?a25XWmZDM1l0SGhJWldyNUVsT1ZtT1lXaE8zZWlYMk9hR001MzBnTlVKTkxn?=
 =?utf-8?B?V2Zka3JSRzAwK2pSZWNJdUVvbmhKYzQ0cnl0U281RTZVdGpPSjJLcnJiTjBr?=
 =?utf-8?B?aGsxa3JkNWg4QWJZNCtKMEVQQUlLQ28vTUVqSWlZTmkvdFd6TVdHbWt4U1pL?=
 =?utf-8?B?T2J1NGt3TFdKK3EwdjhjWkI1dHN6WFh6RjZnWGtoR0cxSm15NFBRY2VIMkM5?=
 =?utf-8?B?UGhVcDBTMzY0WlZKZ3JmY21UMmNoZllwL29yRWEwT0ZBV2dZOXZLQnBDSzRs?=
 =?utf-8?B?cU9NRjFhODdMempuellyd1JOc2VVQXhySlhsVWxtUytSbDNKeEJab1MvckI2?=
 =?utf-8?B?dVRrd21vV2ZuSWVxN01kN2oyK3o2N0NoWXNnM0FIeEFDbyt2em5UNEFmQytF?=
 =?utf-8?B?Q3Q5L0U5YzBvYk1DL0dYQlhTZWM4aFRjVkpaeUUyQ29xQmw2MDUyQkRMVWZG?=
 =?utf-8?B?U3lzd09RbmtnYnJQelhTVCs2VmY0M2QzTVJYak5jMmFtRXk1U0FPVGRDMElM?=
 =?utf-8?B?TlZpSENRdS9INTZEUlduUlZ2WUN2cnU1dGhrRFNLU2YzRVp0VTZ4WWJRQno3?=
 =?utf-8?B?aWdjcTJvakNxN1lUZXNNOE5CVEM4Z0x5WFNRMjRRb1Zrdk9Fd090ZVlBUFpE?=
 =?utf-8?B?dkdFMTh0OTRTUGxwY0RkVkhTYjgzTVZvTEFmY2MvMUg3TGhkYXNqM2w0T3pC?=
 =?utf-8?B?RFRJOXNsTm9ZSnFSUmNBN2oxWlh6dVdsMlI4eUVaMmhXSmpyYmlGR0QvUHJ2?=
 =?utf-8?B?T1VMdmwzVWplejJ1MFpjZjY3c1VQUUpZblVvYkdGcVYzdjZEczJwcHdRU0NS?=
 =?utf-8?B?RENSdnhSdlovVVJ0d3Z6L3BQMnpFWThmY1lPeWgrT1haVSsyMzhIeVBiOWtH?=
 =?utf-8?B?NjQybEc4Mm9Sc1NmVUozRGtLSTdwTmpXU3YycGV3eE16UHFaTjhxZmpleEdG?=
 =?utf-8?B?OU5JSlVMS2Y2TEpYRE1RaTNZMjhJWHo2M2VTMHM0MzQ1ZzlWN3FiWW1CS1Ev?=
 =?utf-8?B?OHdwdlA1WUhxTHBWY01BajVlaXJuQ0F2TTROd3ZUYmlCY0MxbnBXTEZQUnRr?=
 =?utf-8?B?Snh3TVMyVW52a1h5SlUyRDNuanZEY2hXb1VIalo0NVp6RzIxZEc1UjFIZWNY?=
 =?utf-8?B?K0FnS0g5d001RjJBUVZOYnkvQmJvL3lhM01HY0Z1RDFtNDFKSjhKSzNncFVP?=
 =?utf-8?B?aXBDd3Q0cEkwa08rdWNDOFEvaDJLZmRxOE1UNmd6K1NqMlBEZFNtc1hkc3FO?=
 =?utf-8?B?WVJDOEtwb1YyRXBYRFhNV0IxRjc4NjdqMVNaWmh5Wjh2czFDa3Y0WE1Pd1pG?=
 =?utf-8?B?Wm5Ga1RUTGtGWmhWNUtncFdKK0pteUYyeXJPRkdIY2ZVUkhvWUFBVHJwK0pW?=
 =?utf-8?B?MDVsOG45S3NDS1RwcFU3UlZTMEdLN2tNM2RMcWdnMUV4OUkxbzlrbW1zSE1I?=
 =?utf-8?B?OGorR29NWUJuRGpncE56QnBwU0VRSzYwR1dGTU5BR0RYRHZGazZraVFLQnpH?=
 =?utf-8?B?MmhPY28wZ2t3dldvaFE0NkYrT3I0aHV0UE1nYkpxK1FkL1NRdTc0MGFyRmxv?=
 =?utf-8?B?bzlyVkMyRXNHMWY4amM2dTR4alJsaStGOHdyR0p0TjJUZkI5TkhHQmQ0Q0o0?=
 =?utf-8?B?ZCtDaXA3b2pHeE03WXVSRGtNVVY5UTJ4eElscHFsYXR1U3FiV2YvdU93TWhr?=
 =?utf-8?B?YVVXbEhYdU9yZ2RXMktucmFQUDJ2bnk3QTBCSHJ2OTJEd1NWcnhxeGZOc2tJ?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04CEF8FAEC5C1648922089081B7B3FF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9503737d-7016-447e-40a2-08dbb828fad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:23:54.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4RmK5/shP/nDUi9oA1OLWZ86xUhiSjDjLUEsfob998odyeEUASd6PgI+BvJogdH7XS16jvksT4gN2XJ6FLqbEBM9Wwwovc3PXqjAp9/lvcBPhabhNc8te6SybcKC2KR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7598
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAxMy8wOS8yMyA5OjE1IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEz
LzA5LzIwMjMgMTU6MjYsIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gSGkgS3J6eXN6dG9mLA0KPj4NCj4+IE9uIDEwLzA5LzIzIDQ6MjUgcG0sIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+PiBPbiAwOC8wOS8yMDIzIDE2OjI5LCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3Jv
dGU6DQo+Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGNvbnRhaW4gdGhlIGJlbG93IHVwZGF0ZXMsDQo+
Pj4+IC0gQWRkcyBzdXBwb3J0IGZvciBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNl
cmlhbCBJbnRlcmZhY2UgaW4gdGhlDQo+Pj4+ICAgICBuZXQvZXRoZXJuZXQvb2FfdGM2LmMuDQo+
Pj4+IC0gQWRkcyBkcml2ZXIgc3VwcG9ydCBmb3IgTWljcm9jaGlwIExBTjg2NTAvMSBSZXYuQjAg
MTBCQVNFLVQxUyBNQUNQSFkNCj4+Pj4gICAgIEV0aGVybmV0IGRyaXZlciBpbiB0aGUgbmV0L2V0
aGVybmV0L21pY3JvY2hpcC9sYW44NjV4LmMuDQo+Pj4NCj4+PiBBbmQgd2h5IGlzIHRoaXMgUkZD
PyBEbyB5b3UgbWVhbiBieSB0aGF0IGl0IGlzIGJ1Z2d5IGFuZCBub3QgZmluaXNoZWQsDQo+Pj4g
c28gd2Ugc2hvdWxkIG5vdCByZXZpZXc/DQo+Pg0KPj4gTm8sIHRoaXMgaXMgbm90IGEgYnVnZ3kv
dW5maW5pc2hlZCBwYXRjaCBzZXJpZXMuIEkgaGF2ZSBhZGRlZCBSRkMgYXMNCj4gDQo+IEkgZG9u
J3QgdW5kZXJzdGFuZCBob3cgcGVvcGxlIG5hbWUgdGhlaXIgc3R1ZmYgUkZDLiBTb21lIHNlbmQg
dG90YWxseQ0KPiBidWdneSBhbmQgdW50ZXN0ZWQgYmluZGluZ3MgdW5kZXIgUkZDIGFuZCwgYWZ0
ZXIgcmVjZWl2aW5nIGZlZWRiYWNrLA0KPiByZXNwb25kIHN1cnByaXNlZCAtIGl0IHdhcyBqdXN0
IFJGQyENCj4gDQo+IE90aGVyIHNlbmQgUkZDIGFuZCBleHBlY3QgcmV2aWV3Lg0KPiANCj4gSnVz
dCBjYWxsIGl0IGEgUEFUQ0guIFBBVENIIGlzIFJlcXVlc3RpbmcgZm9yIENvbW1lbnRzLg0KT2ss
IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBGcm9tIHRoZSBuZXh0IHZlcnNpb24gb2YgcGF0Y2hl
cywgSSB3aWxsIA0KcmVtb3ZlIFJGQy4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg0K
