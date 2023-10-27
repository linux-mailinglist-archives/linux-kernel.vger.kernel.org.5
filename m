Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F347D8F45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjJ0HKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:10:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B0186;
        Fri, 27 Oct 2023 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698390651; x=1729926651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iJUi/q5SWmFaY9AlOrrriPRr3rWzTsR0qqwcwUTIJiI=;
  b=Dszs0nQLEa3uhRtQ7UobwstnocDIAc0vwFl2oiEhKz7pzYShJLQnKueg
   ni5OAwETNm9R8RmAC1IA/GRwm1B2clpn/ApGAnJIdZmpzrToJltIYOgv7
   kNFHj5/1/dUHhm/mS4xQSoj70tlzsV9lsoZfLwXIbYfhPK8+G3mNk0K8R
   DqU5XgA1ynQSOYHZgloyuH7yG73a59oZdf6VzDkv7AxuzSdPRRl/9Qjyn
   U5vDj9lauCxLcBOQziD23CTH8xEJ5TfToxWl+4mB1FSMLMxlt7vSWII8P
   gKClC/Rtcy7WBew0KPrK2uSL3orUgRV2FsYS34vhan0+HNxjqqG6ExaZD
   w==;
X-CSE-ConnectionGUID: XJDCUrsbTG6qUTlXujv/kA==
X-CSE-MsgGUID: 7MeG+ht6ReevRBQXzC+IDw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="10698303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2023 00:10:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 27 Oct 2023 00:10:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 27 Oct 2023 00:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqKl+GPYEaQsjn1vbXHWJ+duddNS/taZSMC0NJIoWW0HWqotv+2Jj27zkhVEsMxfeP11TiDeyU6Srz+l4kygMl7GknmAkycNdMoZzKfgpbRCkgr+G8kpB8ccibNlQNLccUceHp5MicDhgdlXEoDSj08m84eXvBNaDEOQgQYSkzWyscr34yI7z3VnFF6aEsOiq/ICJf3zY80qFjMNGCrdW6aIeyeDq5EVVXWxRhzjZi4P96l+J5PZ+YmxcAqttoJ9EDFzwuKhYqQzz3PxHuoDPM7H9O+auUvbtyJQf60GVY9smpft4oOlD4IomS0cy/3t5W3ob24n7kKoNHyjg5988w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJUi/q5SWmFaY9AlOrrriPRr3rWzTsR0qqwcwUTIJiI=;
 b=EjIbkn00XKFmVAyWLufcYF4HasHKGVctnLjC+K5SLjmLzHuoW3gwqq9EFz2YdiSuvBVCrXfuwNNGXxjwyvzCRP6qr2+qoMws6kYULN+QU8bm4d73M7lNG+Rx63RIT0zIX5aR3cU+CazEFz7TD/EUUrYSDPHUL8+hVcfdoekLm6/Wn41v5WqbhhqE+Ytzurs/Cy3XNqg31qBXmXylqE4/xMNYovJpU7QLuGAzPF3UCV8avxd+ISf5/SMrGMCifqIfPZ+JlaASJQqMMhxzIoJWpOypOwWQhhJQ49XhHBhVb2FKQOSUKWBwRm0hVXPTn6vETTWYa7R2uLan8P2kIGOkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJUi/q5SWmFaY9AlOrrriPRr3rWzTsR0qqwcwUTIJiI=;
 b=nbIt0+8KWjWsI7CSq4Gw1UuC8O8t+5LGq1GngtaclFVF87m3Zfwxq62sbw357LTtMUoxXBd1UzR83BxpwLSayw7IoN9X8v0NfKRLErbf0yG/KU1a+d4RC5VY0vTDENnQPppZTnmdbrmArc0dmhfrjGXpsQeMDhQyMqkVndeR16I=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 BL1PR11MB5349.namprd11.prod.outlook.com (2603:10b6:208:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.20; Fri, 27 Oct
 2023 07:10:42 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 07:10:42 +0000
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
Subject: Re: [PATCH net-next v2 3/9] net: ethernet: oa_tc6: implement OA TC6
 configuration function
Thread-Topic: [PATCH net-next v2 3/9] net: ethernet: oa_tc6: implement OA TC6
 configuration function
Thread-Index: AQHaBchYB3PCp799EEm9bj7uTu4tjLBX/WmAgAJtaICAAhl7AIAAuYcA
Date:   Fri, 27 Oct 2023 07:10:42 +0000
Message-ID: <0a56fde2-3190-4f65-9fc5-b1d5ff0da6a8@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
 <423e0b42-a75e-4104-b445-7d9ff0991acf@lunn.ch>
 <97872e83-1490-4f1a-81ff-3f7692571dd1@microchip.com>
 <7b3179e2-ac53-497e-94c8-ac364f5b47c6@lunn.ch>
In-Reply-To: <7b3179e2-ac53-497e-94c8-ac364f5b47c6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|BL1PR11MB5349:EE_
x-ms-office365-filtering-correlation-id: 1f0dde81-5d4f-4a01-7639-08dbd6bbd526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cx9K8NvZW5a5E+ZISP6OXoIIql2/DQ7vf07B6KTT0Trpcn2/svojiQEe8yr2DOGGDcdj0Q8uYLEYne25cP12aYsFp7GEfVfaK6SWYQ24M512LJlwRjk+HBxGmwMhU04QkQjA8czvkxDzTX5d5f/63qeI1jvLGkYrLotulMUwWvlzwF2zBUDy3MTMjJ1t9YtpoAM7cRF1PIYtvPTWYHotcQQVVa55hJM5fOHrhxAiQgdTxjUY+V/klr8B2NLykBBxYXEkX51cJtE6hA6167oJout5JTKJjitA9dOAL2dukMpar2mc5eRJgVVCITLS2zELw3kMpQWAPE8/srVZRO6eKI6pH3Umvik+CSubIN8O3zQC5v08i/YrZ6dcmKC3H2DxBvrwqOAJRaTSggAvue4HROdOKCXXgRdtnvbAy5rr1MmidQWLSmfq+Ed3U3tDsAsX1zKme38GQWjCqL/cxJjYtQoCMUQnDjNgEKfSAlusbjb9jQSMujOvxta9d48TA5h+MzI2O0bJ/coKOwLBen5CduWZB4xdh6GgZuVaea8pe62ujqEMicWtbOFyUwdVKRdxCfD18rWR5qhbgOaejW3h2iG0FBX0jIYezbD+Jm0ejleE9bKWkOB3+d0OuAzimpiujoZyh3ZXguFsBMV5Rb9bgOamowFit0eN9VmsZX3egiJbx1d3jaYCK+wQkVp2oBWoWUoMGBMB4VLOyZEhRFrMzSnFepITNxBylTxhKUlbvN+sRlbNtrQrpu9b/vJwHXOahcH5ICpulFVIx4u69pAOwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(2906002)(41300700001)(31696002)(478600001)(4326008)(8936002)(8676002)(6486002)(7416002)(91956017)(66946007)(76116006)(5660300002)(54906003)(66556008)(86362001)(316002)(31686004)(66446008)(66476007)(6916009)(64756008)(71200400001)(53546011)(38100700002)(2616005)(107886003)(6506007)(122000001)(36756003)(6512007)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWQwTisxQ2FiRU8yOXp4cUl6NWFLVXA4a1ZBaWs0OXJLWmFNZWQ2MHRxUTBy?=
 =?utf-8?B?cmdpZUEzb1ViQTdSMTB6SW9mNEl0dTd1VXIwUFpJMHNBLzdBNmpwbkVheXNX?=
 =?utf-8?B?YVNlSC9hRnMzd2doUVloUThiYmZFdXk1WnN5NlRLeGQ0R05zNXJNZzRzUkVx?=
 =?utf-8?B?VGNuSE1ZZ3lqRzZOQnF4NGRpaUF4Qnd0eVZvOFFYenY0dkUvbktNTGE0Y1ZO?=
 =?utf-8?B?SVZkLzhWMFNEWDJLYVhKUnpGOVJmVnRQYWI3MjBkNE9YUWhKc0Y2bEd1bW1v?=
 =?utf-8?B?ZTF0N0REVmpNRXNGM1dLOWdNUHNIZlhPbithN2RHbENpRDdabnhoV0VYYlpa?=
 =?utf-8?B?am5iSUlzN2szNFA1YXVXQVV4N0s1T0VxS05KdGs2VDRKOWllU0ozQ1Vwc2Jh?=
 =?utf-8?B?YklJWUlGbW1QQnFLakxkVGoxd3dOTGhTN1c3WmpIaHNJbkFWdElybCtsTmZo?=
 =?utf-8?B?VktLYmRicm9hT3BsaTZ0UU95MVkzL1F2azBXMzdGMkcrYWovb1NLK0lnOEw5?=
 =?utf-8?B?Ky9mbHhEd2dWVEVEVEoxbzJvWHBUeUh5c29wQ1ZRSTgybGZ4ZGQ2MytHWWh1?=
 =?utf-8?B?OVdrMzMxaFMvV1lzeEl4bkRibllrOFJkU3c3b1M2MGQwcnA5TWZWT09NM3N3?=
 =?utf-8?B?Mk93WDdoSkc0d1lsaXFpSFVxODNGdEk1VXZEWUYxMnJpYU9XUnpVQWtSUkQ4?=
 =?utf-8?B?VVJSYTl2dGVSS0J2T0F5ejE4c2ZBWDVUUE5YZ21zZGk4a2hEQU9HWDg5NFp0?=
 =?utf-8?B?S1lrR203OFloYTdWL3NZWUZLVzhYaVpYbXZBYWhEYytFZndJQUYzRWFDbUFG?=
 =?utf-8?B?ZFJBV1J6RzhBWlBYQ3Fib1l3czBBN2hkdElLdTJwNHM0VXhLMkRoZ3J4NDRG?=
 =?utf-8?B?TGZmOFhEcFFubStqeGhpMFloSEJmL1FUcFhSSk5MTmN0MGcrKzJDdzFnM2VF?=
 =?utf-8?B?WVJKTUZGMnFRU3RkdVM3NUNuSzdMWi9jb1Zpd3RhL3BReUpmWEE2WVg5OU03?=
 =?utf-8?B?YzdoUVJaTEtRc0VVVFhkM3Aza3JNUlV1MkFMcVlPeVl2cUo1OFpVcFFkVW5F?=
 =?utf-8?B?SzB3WFRQVFNzeTVHd0UrV0ZiK2NvZjIwM3NqK0VSSnNpM1NudDlJNWZzOWFq?=
 =?utf-8?B?czJwcnJidjVzK005Zkw0c0taRlVXZnRFczRiWXd6dGQxZmJmYTBuYlVMVmxu?=
 =?utf-8?B?WmtNRkU1SW1qbWg0TmYxVVlqWTl4Ti9hMHFPUnIxRFdNUGw3aEZxcGxGVnZs?=
 =?utf-8?B?d3JMeTd0QXhlV3JsVXRIaE1BQnZmem9td2JUS1cwNVFyU3cxN3BRa0V6WGlK?=
 =?utf-8?B?QVliMXlhT2ZNNkMrSFExdmJvY1BmMFN6L1NXc3FId0Rzd2d0eGJtcnVYb2xu?=
 =?utf-8?B?WGpDcmQzcWp2Rk4wdUsvamZJSkw2Sy9jb25uMWVsUzhWMEtIdW5GQ3hZTFdZ?=
 =?utf-8?B?OHFvYktiYkZMczlwVS9QS3B6VEprc25ZUjN1ZGRVZ1hFVEh1QWR1U2xyd3lX?=
 =?utf-8?B?emFTcDgxWCtCZlRvT09DZ3E3WFVINDMyQWlYMVRXMDB4V2hyckY3dEVCYkkv?=
 =?utf-8?B?R3dUT2V2czlIYzhyTkNWb0R3Wm9sNEdkNmhLamM1NEYyZ1l3b0JTVEFVbDlm?=
 =?utf-8?B?K3VXVXBMRlh5Wit2dTlMbmNyajByUU1XTEJjNWZtcnY2eGtDVE9SOGNIQUIx?=
 =?utf-8?B?T1RLczFzbkkwTzgvbE5ndmgzeUJYVlQ2NHdleWJRd1hudnNBT3dpWWlmckZQ?=
 =?utf-8?B?bk10aTJtZGR6VW1Da1VvMDhTQ0hlWkdvL0I3Q2NtTEE2d2UrVE5OQjB2SXJq?=
 =?utf-8?B?Z1h2dkhEb0wwNWd6dlp0Nk9pcGlDRUN1RUNxTFhuaUpwVXBxUnNBRSsrT2pN?=
 =?utf-8?B?ZlZ5ZUZHTHpVUWlZcVZ4aVhKZHQ3b3I4YndFLzY1bDdVWS8rWEl3SmFEWUVx?=
 =?utf-8?B?UmphQWRUSlI2ZW5KOGdtbXBaVFBhZWhIZmhMQjZNZmpyWS81dzNQWDJwQTZq?=
 =?utf-8?B?dlorM3RPanZVM0RoSGZHVFR3T3ZpV3BZWUFWVGpuU1YwdWpqSFFkQ2t4WTln?=
 =?utf-8?B?ZmxuMUxoU2JKQ0ZzWHVaZUtYS0xueGl2dVlvZ0Nsd0VOT0tWMFRpUXg2SU1W?=
 =?utf-8?B?cWMwdENmM0g0bFh6WGxwZjVNc29rdkJzNVEyUUxNa3plTUphM3pFY0ZsOG8v?=
 =?utf-8?B?eC9qd0VRdHVXTGJQS3BCblJZYXN6dWQwaTZ6R25CSFhwdUJMT0VkZFNERDlq?=
 =?utf-8?Q?pGKtYJ/qZdYuheJbluefjzLQjHeSkghbenE0cCeidE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06791B4BE16062488DEB6E111B51699A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0dde81-5d4f-4a01-7639-08dbd6bbd526
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:10:42.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpX5tGYl6pqlPv1q6uaOUTK2y9l48lXNlDo8IiM4jiVtKLiYacjEF527akJKhBrKmFKH5YShIVo7kC4ecckevxlkvwHVOwQs7SehEjTuUYoF6Z6QSTTLg1QajjVugqXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNy8xMC8yMyAxOjM2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiAtc3RydWN0IG9hX3Rj
NiAqb2FfdGM2X2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgYm9vbCBwcm90ZSkNCj4+Pj4g
K3N0cnVjdCBvYV90YzYgKm9hX3RjNl9pbml0KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+Pj4N
Cj4+PiBXYXMgdGhlcmUgYSByZWFzb24gdG8gaGF2ZSBwcm90ZSBpbml0aWFsbHksIGFuZCB0aGVu
IHJlbW92ZSBpdCBoZXJlPw0KPj4gVGhlIHJlYXNvbiBpcywgY29udHJvbCBjb21tdW5pY2F0aW9u
IHVzZXMgInByb3RlY3QiLiBCdXQgaW4gdGhlIGZpcnN0DQo+PiBwYXRjaCB0aGVyZSB3YXMgbm8g
ZHQgdXNlZC4gTGF0ZXIgaW4gdGhpcyBwYXRjaCwgZHQgdXNlZCBmb3IgYWxsIHRoZQ0KPj4gY29u
ZmlndXJhdGlvbiBwYXJhbWV0ZXJzIGFuZCB0aGlzIGFsc28gcGFydCBvZiB0aGF0LiBUaGF0J3Mg
d2h5IHJlbW92ZWQNCj4+IGFuZCBtb3ZlZCB0aGlzIHRvIGR0IGNvbmZpZ3VyYXRpb24uDQo+Pg0K
Pj4gV2hhdCdzIHlvdXIgb3Bpbmlvbj8gc2hhbGwgSSBrZWVwIGFzIGl0IGlzIGxpa2UgdGhpcz8g
b3IgcmVtb3ZlIHRoZQ0KPj4gcHJvdGVjdCBpbiB0aGUgZmlyc3QgdHdvIHBhdGNoZXMgYW5kIGlu
dHJvZHVjZSBpbiB0aGlzIHBhdGNoPw0KPiANCj4gSXQgd2lsbCBhY3R1YWxseSBkZXBlbmQgb24g
d2hhdCBnb2VzIGludG8gdGhlIERUIGJpbmRpbmcuIElmIHVzaW5nDQo+IHByb3RlY3Rpb25zIGNv
c3RzIHZlcnkgbGl0dGxlLCBpIHdvdWxkIGp1c3QgaGFyZCBjb2RlIGl0IG9uLiBNYXliZSB5b3UN
Cj4gY2FuIHJ1biBzb21lIGlwZXJmIHRlc3RzIGFuZCBzZWUgaWYgaXQgbWFrZXMgYSBtZWFzdXJh
YmxlIGRpZmZlcmVuY2UuDQo+IA0KPiBIb3cgZmFzdCBhbiBTUEkgYnVzIGFyZSB5b3UgdXNpbmcg
b24geW91ciBkZXZlbG9wbWVudCBib2FyZD8gSWYgeW91DQo+IGhhdmUgYSA1ME1icHMgU1BJIGJ1
cywgaXQgZG9lcyBub3QgZXZlbiBtYXR0ZXIsIHNpbmNlIHRoZSBtZWRpYQ0KPiBiYW5kd2lkdGgg
aXMganVzdCAxME1icHMuDQpBY3R1YWxseSBwcm90ZWN0aW9uIGlzIG9ubHkgdXNlZCBmb3IgY29u
dHJvbCBjb21tdW5pY2F0aW9uIHRvIHJlYWQvd3JpdGUgDQpyZWdpc3RlcnMuIEl0IGlzIG5vdCB1
c2VkIGluIGRhdGEgY29tbXVuaWNhdGlvbiB3aGVyZSBldGhlcm5ldCBmcmFtZSANCnRyYW5zZmVy
IHBlcmZvcm1lZC4gU28gaXQgZG9lc24ndCBodXJ0IGRhdGEgdHJhZmZpYy4gQnV0IG9mIGNvdXJz
ZSBpbiANCmJldHdlZW4gZGF0YSBjb21tdW5pY2F0aW9uIEkgbWF5IHBlcmZvcm0gc29tZSBjb250
cm9sIHRyYW5zZmVyIGZvciANCnJlZ2lzdGVyIHJlYWQvd3JpdGUgYnV0IHRoZXkgYXJlIG5vdCBi
aWcgYW5kIHdpbGwgbm90IGFmZmVjdCB0aGUgc3BlZWQuIA0KSW4gbXkgZGV2ZWxvcG1lbnQgYm9h
cmQgSSB1c2UgMTVNSHogc3BlZWQgU1BJIGJ1cy4NCg0KQXMgdGhpcyBpcyBnaXZlbiBhcyBhIGNv
bmZpZ3VyYWJsZSBwYXJhbWV0ZXIgaW4gdGhlIE9QRU4gQWxsaWFuY2UgDQpzcGVjaWZpY2F0aW9u
LCBJIGhhdmUgaW1wbGVtZW50ZWQgaXQgaW4gdGhlIERUIGJpbmRpbmcgZm9yIHVzZXIgDQppbnB1
dC9jaG9pY2UuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgIEFuZHJl
dw0KDQo=
