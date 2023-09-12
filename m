Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2379D1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjILNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjILNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:04:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0A2132;
        Tue, 12 Sep 2023 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694523815; x=1726059815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GP91EBkG/PBdZNnKXUpHMqPNJHvRXiNDKaB1Zq7W92U=;
  b=NSiSy54pU3hMiAYv3DYu30gU8YbPaHraVFfesGvGyFr1kgayuwvqjPu9
   2UinC5Vk1DNO2Bzv9Vn6Xwnelhi3A3LNV4uSXcSiOfpPvIChZIbCnqpDA
   j6ze3v+D6sGVcmZkmE+4fLsV1frN/QUJI9tLg266BenRzsQTsFKSQ4C9m
   IG6RcFAgAxwpu8Ggyz32TTzs4sV7psBpR3aCDTUfHXCpoJAS0vQgTXCq2
   vCAL3+vqJyukaV6u0LWIjmrtEYCfOlPwPQWrFe7FVLI6dKLODsfFbMVLr
   5E3X5e0BsEWJLvpeJMLbTCWdD9GlbP54+bkjgkmmVIfPDQifDO8gcmqNN
   w==;
X-CSE-ConnectionGUID: ZvJGHCTuQA+cb+RqxQcRTQ==
X-CSE-MsgGUID: 8kxfzXUqQY6gOdsFdeDSxQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="4197522"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 06:03:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 06:03:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 06:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVDGw7CNgXO/5no8EtIvBJpaMMwyTF8UXnrovbtZQVPW5FJyaIwaToYkOVQo60O49AgoNTeFHkkV5VAurDbQ0oltQblCOs91ETdaQe0TGEpO6pf6HYjoVz5oWHke/5d9RJl1+QNQ/mujFzxUBu90rWter5hNyhknjDIfZjcyZKFdVRszfia0DFlXyrqhAzXCABhopQFN025R7j9kUTa4pEQtA5w3Yc47t6zSiDGqq4THga3kcK+Sj3ZQ6Fw0Xie69W4H7IaRZjYqCCWDHcNQiHdzOrbg40umvD4LpbO8HYweSSBKWFMgT0DlCUUhg8GuaWIpcEhfLQuEEA5dgXkhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP91EBkG/PBdZNnKXUpHMqPNJHvRXiNDKaB1Zq7W92U=;
 b=fdZnCR8/JAGmx49JgOI8s1x+007HN/fYsI66jbwEsbRkfupKpTibrCKvpTQE6Rn62qy4LjUENbcHJwoxoB5dXHXvIUKuFTHXkoqknUaeCckzSJxLSvXQX5m/jfyWT75zwatSllO9vI8BAwme1rZ0CY39HHk3ChHVE1RzAGZ+oaJ8FTNpl+BgowAgBehtLppCkuzRch9tDaokrHHZVuQ9KuEXu6eZS+FIwGMCTO6YpjQ5ys/6zIQLZ7bwrdmkL1ZK7pSzVnMTVAqPg/ftL7orrnKGFiuaKcz/lSUcFXbMxPhHT05BufsaqCbb5etdxlORePk40qCTV3W05j51IrigqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP91EBkG/PBdZNnKXUpHMqPNJHvRXiNDKaB1Zq7W92U=;
 b=vpfwjilfJ62N5fpxzubFCnt4WY2PNQb4Ci0X2HSGk0qUUH/3WzIVGTaYIul0SV9U2hX+nYkZQK0ZkIHDLthfVNJTCF8SXmTW3vMj8YUzaaDSDucB4dN2WCJGVa/ApzT7t2ZKDWD2ReYVQ0zmO2zz+5nwqyeLVx6XqTdW1kaA+Kk=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SN7PR11MB8042.namprd11.prod.outlook.com (2603:10b6:806:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:03:25 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:03:25 +0000
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibASf7oAgASuf4A=
Date:   Tue, 12 Sep 2023 13:03:24 +0000
Message-ID: <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
In-Reply-To: <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SN7PR11MB8042:EE_
x-ms-office365-filtering-correlation-id: 5a1e69db-0d1e-463e-50e8-08dbb390a64e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21VjeVVjZSatewxH0FTkGcV+u9YNi3OMkmPQzRLre+nmDjyihZpetpCVT7XPjAV+OZ80mcRPytSP4zCGJtcHifphxCOit14jzQVEHAEnr5cV2fvlcidF93fJG8qIjwwmo7lN0BuJ/Wgp5bAKqzX97KoL00AoGZ+N3p80iF2hbTmSGMJDvC/E/RhvwPxH2Fe/z2//nmCQsY2mSd5H3YRNFWFawpCDQMc913Lh1IHOuP6eeu5VwLWHXasCA/r9ro+x1ParWr/nRQz6u9aQhPAwmbuk7VEUWGWZ9AmuXKgTb+sClmbOOLUg/uhajprEQ2GBtv0w0Mf2TwIEa2j/mXVitQn0+WfReGxKJquZNshIy5CphpJ7Ccr1ikZdlhFwp6YAzVsf2qlmLAhdlE3cHlHH9nrkQL2CcpNiRzDqiUb3eaWxeHYF263Tu2CN2vLagQJO1PGuYPB0NHXk5+asZEgy3K2skWBIxqqMwCqGw33yRdoHKWPrThgXtRpQzYm0bdMJVVG7m92d9WHgfePQR8AJlz43N48Wl6O1wtlyt0OcZ62ZtguvYVLRfWn93r+P7MTUDTSmY17slWN+rZ6CB3aylteH3XVr1acxo+AO6RayivqA36db76xdZPlTorQMM4KErjnyj7/WTxrv61niM+VGlm8/Akcqd068UeYYD8W4DCrN1Yv3S6aWZAyAskBzixIM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(2616005)(107886003)(7416002)(2906002)(31686004)(83380400001)(41300700001)(26005)(53546011)(6506007)(478600001)(6512007)(122000001)(38100700002)(38070700005)(8936002)(4326008)(8676002)(91956017)(316002)(36756003)(6916009)(66476007)(76116006)(54906003)(5660300002)(64756008)(66946007)(66446008)(66556008)(71200400001)(6486002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU14NThmS2dCLzY0ZU1kdlhsSTBCbFNLU002UUtiZzNGd1JkWDNNMXdwU1lK?=
 =?utf-8?B?Z3ozcjByODQ5bm15bDQzRGhMbjlua0xDbHZvUGl1UTl5RCtXVDZuTHBhMk83?=
 =?utf-8?B?ZGpxWTJlV2RkMzBuK2M4NzdydGhXbUNubWM0YjFVTmEzYzFMU1A4dFJjRWFy?=
 =?utf-8?B?WGxwaHNtUkdjQTdjTmpnQVNEeEhncm9KcWlETWNoalNLZE40MExXNFVGUXgx?=
 =?utf-8?B?TktxZTZxV25VR0hndVlEYUVsc1Q3VnhGOUJrYk1WRzFiNG81M0tUSm9JbDRq?=
 =?utf-8?B?c3FVTHNYdGpOQ05UNmt0VkhBNHdLR2txSytGMWRicXVvMm14NjJVdEp0Tzl1?=
 =?utf-8?B?cmtWRVRtYkFxeVowSW4wdTAxTFlVTXAwamN2ZG14T1ZKZXdobEdYbmFFUWQ3?=
 =?utf-8?B?ejhybnpIY3RRYXZUdWdjSm9SL1RJQ2IvZXNQTjRSWUIyQlBMdTRLS2s5V2ky?=
 =?utf-8?B?Skd3VDU0MUtZL3Azcll0YWhXdXdURGZ4aitDam9taUxOQlUyN014QXZsRjNy?=
 =?utf-8?B?UkViMnBocDVWbVFaR0txVDFXQ21JYjgreGozZm8rSCtKbzMxWVRCK3ZkdE5H?=
 =?utf-8?B?MVRFaWcxYkR5MXpGclE1MU9YWG9uOGN0ckwyR1VOUHZEVlYxcmRIL1gwRitN?=
 =?utf-8?B?QXpmb2s4QU1BeTgrMGV1ajdhTzdKRWZBdFJNYXJDV1hGOU1wRk1OajJuWTA2?=
 =?utf-8?B?QVpNeDBwWVZmUkY0VlRJbXI2dXFvRXBmVXozU1A5T3hhQnl0dk4rYlBRQjJi?=
 =?utf-8?B?cVVBa1dXK3ZCWXc4L1R0d1dzZEVvTm1UWkZBMkwvL1RkT2lrUmR2VzVETUFK?=
 =?utf-8?B?VTNhaDkwNlFER1RxbkxVNjVNL1htQkczYnErNGFjL0pjU1FtMkl4SHBVaXBP?=
 =?utf-8?B?ZFE2emFmODVjQWFPNVhJbGFwNEt4SjFibU83Uk1BYWhmcFhZYlkyZnhJS1ZG?=
 =?utf-8?B?QzIxRGs0QUdnQlROc2xDNWNvVEd5eEVWc092MmVsaXFRWXFCLzZtRXZvOVZH?=
 =?utf-8?B?QnQrbWhBckwxbEF1VGQvSnpRQ0loR1BtY2tFbFlpTEVJWlFIUGJDU1NuMThl?=
 =?utf-8?B?RXlIdEVTOVhIUTM2dE10aVdROUFBRUFFOUt6QzdSSnpDdXhTOG5ZVjVXcjdR?=
 =?utf-8?B?a0dzQmdkdHl1b1ZHbC9takJja3BYeU4zZ3J1cWNoTjNZQ2Z1dHd5K1IzTUpT?=
 =?utf-8?B?ZzFhNzFTb0lndG5HaVc3Vy93SnBRNWtVUzN3RWx0aGpKR2ZuUkdVWDFXUWpa?=
 =?utf-8?B?em9SVnptcTg2Tyt3KzVqYjk3WDN0UkFKNnREckdQTVdBK3ZQaVJxZUpWek1H?=
 =?utf-8?B?NWhNOUp1T1pVZGpDaTZDRnNTZmVhL3NCcDgrSWw0MTAwZE9xa3VDbWJtcW5t?=
 =?utf-8?B?YldzMjVldUQ0eEt5dVNoNzN2bS92cDFEdW5JL05OWTNEdXpuMnlIVy9TOHp6?=
 =?utf-8?B?SE1LWFJLSmVPZFhRVkpCaW1CNmZnck9IaVk0WnhoVkdMT0F0ZEdNSUExOWR5?=
 =?utf-8?B?QWZhOXZhSWdGL0JyM3AzOVVVL0JnYWZqa05icFJ5K1dMOEdMbXU5QWpYRUFj?=
 =?utf-8?B?VmVoK1oyV3dBa254bW9BRXgyU0NWSE1qOXh4RzY5S0thSG1kZ2VmWkNGeDJo?=
 =?utf-8?B?NkFHcTBMaW1DTi8xWDlhbm53cWhwQld4YytuYldZRm1PQmR5OWcxS203N0l3?=
 =?utf-8?B?Q0tGQW12NWdJQ0J2MytucWw3QzRYblJYVXVOZGZ6ZmhsMldFZjJNdk9SQ25x?=
 =?utf-8?B?NHF2QWtZVTFWU0lNSUFBMVg2TlBlMGI2RkhWbHVWN25UcnlxQ1hCWmU3Sk5n?=
 =?utf-8?B?T3phZmRSTkxVUTI4bjE3ZnBUTVlabEFnUW5SdllKa3JGNzRJSTNrZFFZYXJl?=
 =?utf-8?B?Mit6RVlEb1RnMlUwRE02R0hJS2pSOGdLRExnL0podGFObS9MOFpDbnVucmJ5?=
 =?utf-8?B?bC9vRVY4R2dFb3pXOWloeENzU3Rac0ZuU1U5cEM4dmhxbE5OeS9xeTJrYlYw?=
 =?utf-8?B?RkhxeFp2QlYrVzQ1N2N5MWJNenM4VUNwVVd4NDlCSUVyUWYwcmdLZTVaVTZJ?=
 =?utf-8?B?UHFvRXlqeis2VitBSWFaeWxiQzZNSHpXb2hMdUlFbG5kd1BGQTRzNFhYbmN2?=
 =?utf-8?B?QW4wWC9WRXEwSnB5VzRPUVN6OGhDV3NsdldPNitkK0g2dmlLZGZ2b2pVSGJ3?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C528AB54B7CF74BAA5FF1E1392DF1BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1e69db-0d1e-463e-50e8-08dbb390a64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:03:24.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv+GEuyh+jWLc6TAnHYmkUoVxwTugQ5bXsukN9liL5GEvudJoTJ9y/7kVcJ0ic68hF2SyL52bVnt5u9acXNlTkv5435YAL5AG/Mk75tM1F8VQdLftTl6xOOocbWmcySB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAwOS8wOS8yMyA3OjAzIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIFNlcCAwOCwg
MjAyMyBhdCAwNzo1OToxNFBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBJbXBsZW1lbnQgcmVnaXN0ZXIgcmVhZC93cml0ZSBpbnRlcmZhY2UgYWNjb3JkaW5nIHRvIHRo
ZSBjb250cm9sDQo+PiBjb21tdW5pY2F0aW9uIHNwZWNpZmllZCBpbiB0aGUgT1BFTiBBbGxpYW5j
ZSAxMEJBU0UtVDF4IE1BQ1BIWSBTZXJpYWwNCj4+IEludGVyZmFjZSBkb2N1bWVudC4gQ29udHJv
bCB0cmFuc2FjdGlvbnMgY29uc2lzdCBvZiBvbmUgb3IgbW9yZSBjb250cm9sDQo+PiBjb21tYW5k
cy4gQ29udHJvbCBjb21tYW5kcyBhcmUgdXNlZCBieSB0aGUgU1BJIGhvc3QgdG8gcmVhZCBhbmQg
d3JpdGUNCj4+IHJlZ2lzdGVycyB3aXRoaW4gdGhlIE1BQy1QSFkuIEVhY2ggY29udHJvbCBjb21t
YW5kcyBhcmUgY29tcG9zZWQgb2YgYQ0KPj4gMzItYml0IGNvbnRyb2wgY29tbWFuZCBoZWFkZXIg
Zm9sbG93ZWQgYnkgcmVnaXN0ZXIgZGF0YS4NCj4+DQo+PiBDb250cm9sIHdyaXRlIGNvbW1hbmRz
IGNhbiB3cml0ZSBlaXRoZXIgYSBzaW5nbGUgcmVnaXN0ZXIgb3IgbXVsdGlwbGUNCj4+IGNvbnNl
Y3V0aXZlIHJlZ2lzdGVycy4gV2hlbiBtdWx0aXBsZSBjb25zZWN1dGl2ZSByZWdpc3RlcnMgYXJl
IHdyaXR0ZW4sDQo+PiB0aGUgYWRkcmVzcyBpcyBhdXRvbWF0aWNhbGx5IHBvc3QtaW5jcmVtZW50
ZWQgYnkgdGhlIE1BQy1QSFkuIFRoZSB3cml0ZQ0KPj4gY29tbWFuZCBhbmQgZGF0YSBpcyBhbHNv
IGVjaG9lZCBmcm9tIHRoZSBNQUMtUEhZIGJhY2sgdG8gdGhlIFNQSSBob3N0IHRvDQo+PiBlbmFi
bGUgdGhlIFNQSSBob3N0IHRvIGlkZW50aWZ5IHdoaWNoIHJlZ2lzdGVyIHdyaXRlIGZhaWxlZCBp
biB0aGUgY2FzZQ0KPj4gb2YgYW55IGJ1cyBlcnJvcnMuDQo+Pg0KPj4gQ29udHJvbCByZWFkIGNv
bW1hbmRzIGNhbiByZWFkIGVpdGhlciBhIHNpbmdsZSByZWdpc3RlciBvciBtdWx0aXBsZQ0KPj4g
Y29uc2VjdXRpdmUgcmVnaXN0ZXJzLiBXaGVuIG11bHRpcGxlIGNvbnNlY3V0aXZlIHJlZ2lzdGVy
cyBhcmUgcmVhZCwgdGhlDQo+PiBhZGRyZXNzIGlzIGF1dG9tYXRpY2FsbHkgcG9zdC1pbmNyZW1l
bnRlZCBieSB0aGUgTUFDLVBIWS4NCj4+DQo+PiBUaGUgcmVnaXN0ZXIgZGF0YSBiZWluZyByZWFk
IG9yIHdyaXR0ZW4gY2FuIGJlIHByb3RlY3RlZCBhZ2FpbnN0IHNpbXBsZQ0KPj4gYml0IGVycm9y
cy4gV2hlbiBlbmFibGVkIGJ5IHNldHRpbmcgdGhlIFByb3RlY3Rpb24gRW5hYmxlIChQUk9URSkg
Yml0IGluDQo+PiB0aGUgQ09ORklHMCByZWdpc3RlciwgcHJvdGVjdGlvbiBpcyBhY2NvbXBsaXNo
ZWQgYnkgZHVwbGljYXRpb24gb2YgZWFjaA0KPj4gMzItYml0IHdvcmQgY29udGFpbmluZyByZWdp
c3RlciBkYXRhIHdpdGggaXRzIG9uZXPigJkgY29tcGxlbWVudC4gRXJyb3JzDQo+PiBhcmUgZGV0
ZWN0ZWQgYXQgdGhlIHJlY2VpdmVyIGJ5IHBlcmZvcm1pbmcgYSBzaW1wbGUgZXhjbHVzaXZlLU9S
IChYT1IpIG9mDQo+PiBlYWNoIHJlY2VpdmVkIDMyLWJpdCB3b3JkIGNvbnRhaW5pbmcgcmVnaXN0
ZXIgZGF0YSB3aXRoIGl0cyByZWNlaXZlZA0KPj4gY29tcGxlbWVudCBhbmQgZGV0ZWN0aW5nIGlm
IHRoZXJlIGFyZSBhbnkgemVyb3MgaW4gdGhlIHJlc3VsdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAu
Y29tPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9vYS10YzYtZnJhbWV3
b3JrLnJzdCB8IDIzMSArKysrKysrKysrKysrKysrKysNCj4+ICAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsNCj4+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvb2FfdGM2LmMgICAgICAgICAgICAgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrDQo+
PiAgIGluY2x1ZGUvbGludXgvb2FfdGM2LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAzMSAr
KysNCj4gDQo+IEknbSBzdXJwcmlzZWQgdGhlcmUgaXMgbm8ga2NvbmZpZyBhbmQgTWFrZWZpbGUg
Y2hhbmdlcyBoZXJlLiBJIHdvdWxkDQo+IGV4cGVjdCB0aGlzIGlzIGNvbXBpbGVkIGFzIGEgbW9k
dWxlLCB3aGljaCB0aGUgdmVuZG9yIGNvZGUgY2FuIHRoZW4NCj4gbWFrZSB1c2Ugb2YuDQpPaywg
YWN0dWFsbHkgdGhpcyBmcmFtZXdvcmsgaXMgdXNlZCBieSB2ZW5kb3Igc3BlY2lmaWMgZHJpdmVy
IA0KKGxhbjg2NXguYykgbGF0ZXIgd2l0aCB0aGUgTWFrZWZpbGUgdXBkYXRlIGxpa2UgYmVsb3cg
aW4gdGhlIGRpcmVjdG9yeSANCmRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC8sDQoNCm9i
ai0kKENPTkZJR19MQU44NjVYKSArPSBsYW44NjV4X3Qxcy5vIA0KDQpsYW44NjV4X3Qxcy1vYmpz
IDo9IGxhbjg2NXgubyAuLi9vYV90YzYubw0KDQpJZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3Rs
eSwgdGhpcyBmcmFtZXdvcmsgaGFzIHRvIGluY2x1ZGUgdGhlIG1vZHVsZSANCmluaXRpYWxpemF0
aW9uIGFzIHdlbGwgdXNpbmcgdGhlIGJlbG93IEFQSXMgYW5kIGhhcyB0byBiZSBjb21waWxlZCBh
cyBhIA0KbG9hZGFibGUgbW9kdWxlIHNvIHRoYXQgb3RoZXIgdmVuZG9ycyBtb2R1bGUgY2FuIG1h
a2UgdXNlIG9mIHRoaXMsIGlzbid0IGl0Pw0KDQptb2R1bGVfaW5pdChvYV90YzZfaW5pdCk7DQpt
b2R1bGVfZXhpdChvYV90YzZfZXhpdCk7DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+
IA0KPiAgICAgICBBbmRyZXcNCj4gDQoNCg==
