Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694F7DBA69
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJ3NRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3NRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:17:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EAC2;
        Mon, 30 Oct 2023 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698671828; x=1730207828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kntn6NV01c+X4o9vMDDVMybgPNrASYMzbxeO+oo7GJM=;
  b=Ug4fq0w/huH7YRydfOPwKo2nhGMhAE5cMxilphi8JO/UOajz1YpQFEZx
   qU4mzXW0L9xpQVk1jOEj2Wd44e/G7+rJRHcDH8+v1089JO6bDHQfjpiTh
   fdVEmNxisDKrAqIgNdmNi5+mLGaUhnih/rvzsSjm5ebZQXoiyLoPqbA4V
   aTcc2RMZ8fg/1i/3CF/yuRP3A7Ey2ytBbuuUIWpYa39w52cU/Rwvc96pq
   X0VtaOMfAGwzD7QBzUCThgIjpTyDIW3jYfsmWO4GcVKaVO83z9qIkpCb7
   UupceOcJan5kzOvwXk/YgsLG6+X7KQkH6I6vB6Plv+pw7yCF7hatdsNnP
   g==;
X-CSE-ConnectionGUID: bhIEvhhiRTe07RJXpqJ8Bg==
X-CSE-MsgGUID: 7IDz3Bm0Tl6VUNgzt60iTg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="10822745"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 06:17:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 06:16:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 06:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbapLjCV5ebsLqa/llwiok5sTVMISXYOW/m0eeKZCl9j5pjsRPNdOQ21ZoAs/mfQf15rG2Kj+XKspndyswST/ugLt05gAmJ28cCmPreRJqxQdQIBYHfFjqIQZGpNjE4Y7uK7pkbNCznIFeoN5MFmzTn1QB+g5wFjAqg1SKeXoLRYoHdPE7WfZyqacCIRq7UTHvDl26d7W2xDFEVgWO+MLPyACksxTRoHYSLrLeYajo6RjJjcI3VsQQKqUq8VcMVheZukL6RhqyPiAeD+tUiqFWKeU2xRfIJv++cmlovxKcJkrAG1cR+eGzIu9IAbCH3yF+pB/8pFqLxAxkpXPlzVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kntn6NV01c+X4o9vMDDVMybgPNrASYMzbxeO+oo7GJM=;
 b=J0M3xNcTLQ7YKHBA6mI5wxrQnbOBkff0szEqvq+KQ3EJ0DaApg7SDhIsS3FJOqdZ+KnhpsXxnA9bhFFcc9r0cfNi4mvuoo5SjrJvyPsMSorzhYsbxH2BcaYl1uZgbgiH0FBQKfKDXFkwit+gA0WRw/V8UEuCCpDHneTGkWmuhBXmdZ6iY0ROn4vfnd6+cwfK6U5W/NRzNRG9hSFM7zO5QE5monGIT8NENIXDHhW7jhZmVm+EpqfLS/8argyT6VZ5gccnufR3rYtO9jfASiSZQdOVQLeANqMK7R1KofrY2tEmFUKGtgLy7Bxa75Maocz4sZ0BfeddUOQgAooDqC2ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kntn6NV01c+X4o9vMDDVMybgPNrASYMzbxeO+oo7GJM=;
 b=pp/BdIn6hG0y0cGyi3yd9AbRwqoZnpBIYFOF9BI+yjwA53nPnAhkUbmn75KtAADEXXmIYW+Lz7SOoqQVraGHYqP7gxmRARPZayXJbrsBiUUed/vKMhdiExrU5DX0h7hqk1GR7vWn2vzndzhFXY5vvsndoSorKFylRNYx42lZIOU=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Mon, 30 Oct 2023 13:16:40 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 13:16:40 +0000
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
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHaBciQjBoWnY4j9k2nUOrnZEADaLBYlZuAgAnFeoA=
Date:   Mon, 30 Oct 2023 13:16:40 +0000
Message-ID: <3ee02690-8912-47b4-a97e-6d364969c956@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
 <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
In-Reply-To: <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|LV3PR11MB8508:EE_
x-ms-office365-filtering-correlation-id: 2969e706-4008-44c5-3a5a-08dbd94a7462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfGxbXXGUWt4iZZhRU/9utnC9y3OIQ8Sji6CdLyiNwwWBed4uhJGFjVK/jfkeKIpNC2KB1SukVRWu3YwHdofjrd02Wo0P86PMbWb+NXFXJEnQYvXwJNcGWYM8uO27uSPIsTOw2xVEvpFmfccBuy16X5h8S+GecQL1A/Xe/5rFhXO7VuQXbxASS6JYU8gf19zKBWQI7KPgTaM8X64FWevDS8gj5MzhxC8Dn/ufjCYSCscToj38HGbdmD+7LdnOKoTWzFqgqeO9Kbp2CzSvDP1P/+TiSEXM+Bxq6M2PqPTJ7rBMqYdl6Sv7Xry6AwUg1i/GYUxsJs6Z7G0L1PBQaD4w462Hk2c0zMXJnk+5Ra9cA1XiCJu93laPyAYAw+SP4XJ8gfp85VX6wND/VHqkC9tNyhg8RqSF+/Dd2Nb3tkVoXjFvnEFzrQ3DY9cp5FwLWe+InenVZW5WdhEsKQUu6hab0osJq+Js0WwUOGORHx4U2lmQlzib8PATz8BQ1N7BC/MGMY8kuPAuymxSpqCGxK/0oLdGGmEQZ9WnriThlv8Cxx2mh0Yw3WZIoC8LmO5ZqLAXMySTczdBXmCmCWmB6+cSyQGK6B82KMQ2bca9NaET5sWFjZUJEPpA8eQhcvfb8gkqvyfGEuOcNj5VSooXlmLuohJUnuWfWkyKdCNzlSp8ry3ep2yyu04OaPzKIhbxZql917LA/YWhW2hCsO1zDGhBs2iWq0KGAWj51VLLMsZlMZOXwKhLoq2v453Vrc1r9eU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(36756003)(83380400001)(86362001)(26005)(38070700009)(6486002)(53546011)(6506007)(122000001)(76116006)(64756008)(316002)(66946007)(66476007)(6916009)(66446008)(478600001)(54906003)(66556008)(91956017)(966005)(5660300002)(71200400001)(2906002)(31696002)(2616005)(8676002)(7416002)(8936002)(4326008)(6512007)(41300700001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azN5NkUvYkNQck03VDMxNWZYd0pwRDhtTlhla2RBM1pnYzl6QmFscStpUHo0?=
 =?utf-8?B?V2c4S3NrOHkyaEFZQ1o2SDkzbWl2anpaNElWZzZ1dlVrZmZYYnB5T2RMYndu?=
 =?utf-8?B?YzF4eGRPVldGa0NHMEV3em4wVXlYUCtiS3BndzJBQkFIWFhlVE1RV3dLQis1?=
 =?utf-8?B?UFVGejBXczJyYjg3eDduVTdOcDlqYUQzODNPTW01MVFqcm1HUUw2dkRkUko5?=
 =?utf-8?B?dUNtdmMwK0grd09PeUVkVkhsZGVIdWpRMllMOVNjWXROZ0NHcGRBS2s1cTNo?=
 =?utf-8?B?K0U1eDd3dG5aMnpFNU9lanRJY1hqZkpIcTV6YlNqUU96K25CdWFyR2cvSDN1?=
 =?utf-8?B?b01YangwcDl2TVRWL0JsV0lwbWs4MkYram5JaFZQSTJqQmRhbzcvZnQyY3U4?=
 =?utf-8?B?bUFaQXJWdElrOUgvMEtJOGpTQnJPVy9aZ3phb0hEaWRJa21GWk11TkZ6ZXJm?=
 =?utf-8?B?dzBBVnpSMnV4WWE2OFhTL25yK3V1Z3JtZUxxQVM1c3dTUm9YZXV5OGlTWEoy?=
 =?utf-8?B?OWo0Q1hMMDFGRzBoamlYbllFeTA1R3RNQmRWVVNKWVM1Z3ZYanNwaDI3c1BD?=
 =?utf-8?B?a2txclJsamo3bktGbnE0UGpTZUVWWWVRM24zbElnZFNaTVhqMGtnNjR0d0pq?=
 =?utf-8?B?YWlpazBUcGZEeTN6eHdhaTJFMkJER09xOUlCZDA0NFF1bXI3eTdWUGdrT2dE?=
 =?utf-8?B?dGZ4R2dzWkhQdGhmdi94MWNiT0lvY0RrUFRKSTVVcHJOUmZZWTBLY1YyRVNY?=
 =?utf-8?B?VVpFckdQY0plQ3dPdHVmMmsvbDJ3WTZKTjl2eUpFR3FMSzY3NHBJNVBIakxj?=
 =?utf-8?B?bkNGSFJMZTNNczUvZEdQaEdFdTZ0alFsa3NSQmJLWXBZUWRGR0tteUhvbEt1?=
 =?utf-8?B?NXZiUkpHVUlCb2N4M293OXl3QXh1Z1V1YnYzaWJrL2VqSHVOQW13djRUUk1F?=
 =?utf-8?B?RGVtNnY1U1hndDZoYVNUbXlTRVFWK0VGbkJqOEZQUXZGRGNzelV0MUluQWNI?=
 =?utf-8?B?RDZSQ0ZiREhuNGczOWp4WEhGZmc3amUxWDdPaWlpRWEySUdPYnB2OEVxdnVx?=
 =?utf-8?B?UzFTTWNGeWlNWm9wUUZ2R21INEUyUitOWHU2UU94MThTc3B0VUs1OCs1WS9Q?=
 =?utf-8?B?Zit5eFQwaUNLQ2ZubHdScVMrY0pNSTJyL1hsS0lZem1kcXFLN2tOUC9kN0sy?=
 =?utf-8?B?V1pQN0x6SkJ2Tm1KQ2wreVNxNTZFcGpLd2t6ZUQvRFR0b21jSjZ1RlVOemVk?=
 =?utf-8?B?SFlRL2p1NUNhUmVhS1UyeExudDByLzNsWXdLUitFY0dzSXpRYURDamtLQWJ6?=
 =?utf-8?B?a2JvZWxTK1lLKzloZyszNXVxTG1QTklBditaaGpJamxtOUpVOEs4MUxSd2hR?=
 =?utf-8?B?WXNCUDhsTVQ1MWFJZ3RLZXlVei9vZ0l6MW5NenRQQklLWVJZVjA0dXlqUGE2?=
 =?utf-8?B?bUpqRHhqbGtVU2E4MGFZcVBDMGVjUyttZWUrU0krVDQvT2FZQ09VOHl1OVZx?=
 =?utf-8?B?amdSd21OVTN6MkVHcmVCOG9DVzN6aWhnUlRwMXUrZ1o1azFFNU9MTnNXY1B5?=
 =?utf-8?B?d3hGZmxpSDVHcmh1dXh3bUFIMTYrTzIvMWRxbTZ1Q2NSalVORjNhRnJOZzVB?=
 =?utf-8?B?RzFBOVpXR3BWMHNMWkhhNUNXU1ZIWGJVbGF3OXVuWjBkRDJYUzhUaE05dlBY?=
 =?utf-8?B?cnJkejlOeU0ybnBhbHVramdKR24xZjIxbkNJZ2NIaDhaaWwreU9lakw4dkpJ?=
 =?utf-8?B?M0pvMHRVcW9JZytiWXJsTVczelU5ckNFYWVLbk1NbXlwbnhkRkE0YS9Rc2d3?=
 =?utf-8?B?OE9BQ2FxQlV6b1N6SnIrS09VOFRuYW5DaWJ3c3YrMXQzWW92WVEzZjREdVUx?=
 =?utf-8?B?QVZ4YzBsc28xREltYUVCTm5tcUMxRVl3UmxnQmRvaVVMcU8yK0RaZjZWRXpL?=
 =?utf-8?B?dGFnMVQwVnRuNnYvK0pPYWNPNU0yY3c5dFRWampqeHlqdmtwcUR3RFBnNWdV?=
 =?utf-8?B?WDlsOCtkVld4VEw1ZTVoQkVSVllmcytBTk1xU1ZNUjJBVUl5cEJyQlVkQTgw?=
 =?utf-8?B?b3k1QnJBSE9xR1h0eGdpampuVUlDUktBakd1NnluRmN0c21TOWNzWm5TYUc5?=
 =?utf-8?B?bUFsMkxISFBYRm9SaXUzRzFSQjNqLzQrMk5UYzdkMklxYndsK0RjWTFmczMv?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BBF52711CD2E64190DFF8214CC75ED3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2969e706-4008-44c5-3a5a-08dbd94a7462
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:16:40.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJ3Z8uRtCxVsufBCEaGy44BwrV8uiDkZGMSZIUPZfRCBeqhTFdOhzIoL4ZUTytEHBdcWu8Su74ylKyZRJecWxrHJC88xAi1lQdmBAyTCukcdN2PpzYhM+xSdUkrcOynL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAyNC8xMC8yMyAxOjMzIHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIz
LzEwLzIwMjMgMTc6NDYsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+IEFkZCBEVCBi
aW5kaW5ncyBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WCAxMEJBU0UtVDFTIE1BQ1BIWS4gVGhlIExB
Tjg2NTAvMQ0KPj4gY29tYmluZXMgYSBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlciAoTUFDKSBhbmQg
YW4gRXRoZXJuZXQgUEhZIHRvIGVuYWJsZQ0KPj4gMTBCQVNF4oCRVDFTIG5ldHdvcmtzLiBUaGUg
RXRoZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgbW9kdWxlDQo+PiBpbXBsZW1l
bnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxleCBFdGhlcm5ldCBNQUMsIGNvbXBhdGlibGUgd2l0aCB0
aGUgSUVFRQ0KPj4gODAyLjMgc3RhbmRhcmQgYW5kIGEgMTBCQVNFLVQxUyBwaHlzaWNhbCBsYXll
ciB0cmFuc2NlaXZlciBpbnRlZ3JhdGVkDQo+PiBpbnRvIHRoZSBMQU44NjUwLzEuIFRoZSBjb21t
dW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5kIHRoZSBNQUMtUEhZIGlzDQo+PiBzcGVjaWZp
ZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFj
ZSAoVEM2KS4NCj4gDQo+IEl0IGRvZXMgbm90IGxvb2sgbGlrZSB5b3UgdGVzdGVkIHRoZSBiaW5k
aW5ncywgYXQgbGVhc3QgYWZ0ZXIgcXVpY2sNCj4gbG9vay4gUGxlYXNlIHJ1biBgbWFrZSBkdF9i
aW5kaW5nX2NoZWNrYCAoc2VlDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93
cml0aW5nLXNjaGVtYS5yc3QgZm9yIGluc3RydWN0aW9ucykuDQo+IE1heWJlIHlvdSBuZWVkIHRv
IHVwZGF0ZSB5b3VyIGR0c2NoZW1hIGFuZCB5YW1sbGludC4NClNvcnJ5LCBzb21laG93IEkgbWlz
c2VkIGRvaW5nIHRoaXMgY2hlY2suIFdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgDQpyZXZpc2lv
bi4NCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQYXJ0
aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGlu
Z3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgICAgICAgfCAxMDEgKysrKysrKysrKysrKysr
KysrDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWlj
cm9jaGlwLGxhbjg2NXgueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwNCj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjk3NDYyMmRkNjg0Ng0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+PiBAQCAtMCwwICsxLDEwMSBAQA0KPj4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6
IE1pY3JvY2hpcCBMQU44NjUwLzEgMTBCQVNFLVQxUyBNQUNQSFkgRXRoZXJuZXQgQ29udHJvbGxl
cnMNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gUGFydGhpYmFuIFZlZXJhc29vcmFu
IDxwYXJ0aGliYW4udmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlw
dGlvbjoNCj4+ICsgIFRoZSBMQU44NjUwLzEgY29tYmluZXMgYSBNZWRpYSBBY2Nlc3MgQ29udHJv
bGxlciAoTUFDKSBhbmQgYW4gRXRoZXJuZXQNCj4+ICsgIFBIWSB0byBlbmFibGUgMTBCQVNF4oCR
VDFTIG5ldHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXINCj4+ICsg
IChNQUMpIG1vZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxleCBFdGhlcm5ldCBN
QUMsIGNvbXBhdGlibGUNCj4+ICsgIHdpdGggdGhlIElFRUUgODAyLjMgc3RhbmRhcmQgYW5kIGEg
MTBCQVNFLVQxUyBwaHlzaWNhbCBsYXllciB0cmFuc2NlaXZlcg0KPj4gKyAgaW50ZWdyYXRlZCBp
bnRvIHRoZSBMQU44NjUwLzEuIFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5k
DQo+PiArICB0aGUgTUFDLVBIWSBpcyBzcGVjaWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBC
QVNFLVQxeCBNQUNQSFkgU2VyaWFsDQo+PiArICBJbnRlcmZhY2UgKFRDNikuDQo+PiArDQo+PiAr
ICBTcGVjaWZpY2F0aW9ucyBhYm91dCB0aGUgTEFOODY1MC8xIGNhbiBiZSBmb3VuZCBhdDoNCj4+
ICsgICAgaHR0cHM6Ly93d3cubWljcm9jaGlwLmNvbS9lbi11cy9wcm9kdWN0L2xhbjg2NTANCj4+
ICsNCj4+ICthbGxPZjoNCj4+ICsgIC0gJHJlZjogZXRoZXJuZXQtY29udHJvbGxlci55YW1sIw0K
Pj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBjb25zdDog
bWljcm9jaGlwLGxhbjg2NXgNCj4gDQo+IE5vIHdpbGRjYXJkcyBpbiBjb21wYXRpYmxlcy4NCkFo
IG9rIG1pc3NlZCBpdC4gU28gaXQgd2lsbCBiZWNvbWUgbGlrZSBiZWxvdyBpc24ndCBpdD8NCg0K
cHJvcGVydGllczoNCiAgIGNvbXBhdGlibGU6DQogICAgIGVudW06DQogICAgICAgLSBtaWNyb2No
aXAsbGFuODY1MA0KICAgICAgIC0gbWljcm9jaGlwLGxhbjg2NTENCg0KPiANCj4+ICsNCj4+ICsg
IHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiAr
ICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEludGVycnVwdCBmcm9tIE1BQy1QSFkgYXNzZXJ0
ZWQgaW4gdGhlIGV2ZW50IG9mIFJlY2VpdmUgQ2h1bmtzDQo+PiArICAgICAgQXZhaWxhYmxlLCBU
cmFuc21pdCBDaHVuayBDcmVkaXRzIEF2YWlsYWJsZSBhbmQgRXh0ZW5kZWQgU3RhdHVzDQo+PiAr
ICAgICAgRXZlbnQuDQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBsb2NhbC1tYWMt
YWRkcmVzczoNCj4gDQo+IERyb3AgcHJvcGVydHksIG5vdCBuZWVkZWQuDQpPayBub3RlZC4NCj4g
DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIFNwZWNpZmllcyB0aGUgTUFDIGFkZHJl
c3MgYXNzaWduZWQgdG8gdGhlIG5ldHdvcmsgZGV2aWNlLg0KPj4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50OC1hcnJheQ0KPj4gKyAgICBtaW5JdGVtczog
Ng0KPj4gKyAgICBtYXhJdGVtczogNg0KPj4gKw0KPj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6DQo+
PiArICAgIG1pbmltdW06IDE1MDAwMDAwDQo+PiArICAgIG1heGltdW06IDI1MDAwMDAwDQo+PiAr
DQo+PiArICBvYS10YzY6DQo+PiArICAgICRyZWY6IG9hLXRjNi55YW1sIw0KPj4gKyAgICB1bmV2
YWx1YXRlZFByb3BlcnRpZXM6IHRydWUNCj4gDQo+IFRoaXMgbXVzdCBiZSBmYWxzZS4NCk9rIG5v
dGVkLg0KPiANCj4+ICsNCj4+ICsgICIjYWRkcmVzcy1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAx
DQo+PiArDQo+PiArICAiI3NpemUtY2VsbHMiOg0KPj4gKyAgICBjb25zdDogMA0KPj4gKw0KPj4g
K3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBwaW5j
dHJsLW5hbWVzDQo+PiArICAtIHBpbmN0cmwtMA0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAt
IGludGVycnVwdC1wYXJlbnQNCj4+ICsgIC0gbG9jYWwtbWFjLWFkZHJlc3MNCj4+ICsgIC0gc3Bp
LW1heC1mcmVxdWVuY3kNCj4+ICsgIC0gb2EtdGM2DQo+PiArDQo+PiArYWRkaXRpb25hbFByb3Bl
cnRpZXM6IGZhbHNlDQo+IA0KPiBJbnN0ZWFkOg0KPiB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZh
bHNlDQpPayBub3RlZC4NCj4gDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsg
ICAgc3BpIHsNCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAjc2l6
ZS1jZWxscyA9IDwwPjsNCj4+ICsNCj4+ICsgICAgICBldGhlcm5ldEAwIHsNCj4+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjg2NXgiOw0KPj4gKyAgICAgICAgcmVnID0gPDA+
Ow0KPj4gKyAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsgICAgICAgIHBp
bmN0cmwtMCA9IDwmZXRoMF9waW5zPjsNCj4+ICsgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8
JmdwaW8+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDw2IElSUV9UWVBFX0VER0VfRkFMTElO
Rz47DQo+PiArICAgICAgICBsb2NhbC1tYWMtYWRkcmVzcyA9IFswNCAwNSAwNiAwMSAwMiAwM107
DQo+PiArICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxNTAwMDAwMD47DQo+PiArICAgICAg
ICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiBEcm9wIHN0YXR1cy4NCk9rIG5vdGVkLg0KPiANCj4+
ICsgICAgICAgIG9hLXRjNiB7DQo+PiArICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
Pj4gKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICAgICAgb2EtY3BzID0g
PDY0PjsNCj4+ICsgICAgICAgICAgb2EtdHhjdGU7DQo+PiArICAgICAgIG9hX3J4Y3RlOw0KPj4g
KyAgICAgICBvYS1wcm90ZTsNCj4+ICsgICAgICAgb2EtZHByYWM7DQo+IA0KPiBBZ2FpbiB0b3Rh
bGx5IG1peGVkIHVwIGluZGVudGF0aW9uLg0KU29ycnksIHByb2JhYmx5IGluIHRoZSBuZXh0IHJl
dmlzaW9uIHRoZXkgd2lsbCBub3QgYmUgYW55bW9yZS4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhp
YmFuIFYNCj4gDQo+PiArICAgICAgICB9Ow0KPj4gKyAgICAgIH07DQo+PiArICAgIH07DQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gDQoNCg==
