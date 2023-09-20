Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092037A8205
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjITMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:54:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5483;
        Wed, 20 Sep 2023 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695214456; x=1726750456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MmUNYQASao/1JzdsOnIAoSmCpfTd2EHOa1Ith47T8Dw=;
  b=ZPWAAeKVophQwxX2qrBg1kmWqDEkBcPSKtHKdztvGh9uxgzqVAnsP+eU
   t8QcZLahXtAiwCe4EP+PvDiFH9wet8DVYsAFI0HyS/QfcgrFD6p0Z6kSe
   OnuFo1gG7X2/hpnsoLInAMEcqr6uYVXCQZdl0VLCTRVJ+1K/BxG/uXQMc
   Pgx4VeTOX93Faif5tMUb8LyPAs/nK2tDZsSbp+OTBN6Bo//9YL38sjbN5
   ckV/wlx8tShH85oqvJwJEywnZHjguDXfxRiK/jBsWITyQbsE3haiLe1E0
   gJ0doAiDR5qh9H4dyur2xAtLI3dH1frMpAeKXw6udWxZhfPTcgtZcV3In
   w==;
X-CSE-ConnectionGUID: bIlt8mqMRTm9FPkXMxRWnw==
X-CSE-MsgGUID: xHVo6KuaS92ux3eb7nJeVQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="5510864"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 05:53:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 05:53:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 20 Sep 2023 05:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBQ+1UytDp8kuS2knfC2J9Q+VLr1v/RUUmqXYfsKlIZxz2vVuqRg9sGCzM4NkCBCmM9KkFN4kn9t7nXzKH/WVN+ddy/gPEhv1CnP4F6A/nQjAPFB6vLicaEsMMRJFMdJaneZgE+TzIJX2S87z4h8jXjujiLQNgOBrTwtdbZTr90k9NUMWA6e7lL5z8Qn3YsHo+f6SToPC8rglssQn3XOQq8sMoyLtfXVd9zREXGuiY1Kj2G/W5q29Afy3+f0RQ8qOleLujbKM7tKyqRv3BcivHnT9MUAELwqDW0OQ+m3N1t+/u1CAbejMyk9NT8d1PhYvv0CXsLN+K7IPGdukQ2yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmUNYQASao/1JzdsOnIAoSmCpfTd2EHOa1Ith47T8Dw=;
 b=BsMtyvyvBZDNsxHKy+WnQd4zCo5fkxQLmMcixUf15kPHjelVpJF7QOoMCzrdQQX4xJYF6CcRZc2QN/H6JJodx9L/ueL1HOT5CgmqOnvjkqJT9ovXQiBQXpWDGsZdRknjXSOzgmNd3WLSJHcMEYeRkShMt4kTjjoLcVu1pkS/d1kU3dgqFmlFOSjNPQqbvaIxhdDQr27fiHF/RR3S0lM6KnKF+lAEejCPstA8QY1FJNC7VDe7tOhXaYremV0Y2yAFODmHrjGHBZbeQWhkf8X6RS0hKfG7P3trkNAI6Ft3/2QfdY1FC0zJNlKMXHJEiDcKxggTB/3aiPVImrEX7XnOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmUNYQASao/1JzdsOnIAoSmCpfTd2EHOa1Ith47T8Dw=;
 b=Ov8konSRr/bETTUVhtKZLEXSThXyYp1sdrDA9QbzwTxSAIlGE4H0U9T7lyf5lSZB524apw8tmHJFRkBrvM26pyRXo3+oBOgCZF8KUjQ9nwqLYHFN8pszs5GNFgpL/ig7HhAJhn+TcijH/NmgJ5bP/S/+oWF8Cd0DnGux+n17JTI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DM4PR11MB5376.namprd11.prod.outlook.com (2603:10b6:5:397::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Wed, 20 Sep 2023 12:53:36 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 12:53:36 +0000
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
        <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <Ciprian.Regus@analog.com>,
        <jtm@lopingdog.com>
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mEuK01gdvjwlU2rxFfJz2fLmrAZl0+AgAhYVYCAADtmgIABkw2A
Date:   Wed, 20 Sep 2023 12:53:35 +0000
Message-ID: <8c0b32c8-ac9f-2510-f8f2-96594ae2abb8@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
 <d1ffe3b1-d078-4f39-a263-c09dec6c4169@lunn.ch>
 <248dc5fd-f860-507b-6b3e-4be62cd91b2a@microchip.com>
 <8e9fecd4-f9bc-46d0-b7bf-fbf7ac83cc80@lunn.ch>
In-Reply-To: <8e9fecd4-f9bc-46d0-b7bf-fbf7ac83cc80@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DM4PR11MB5376:EE_
x-ms-office365-filtering-correlation-id: b008ce97-d046-4074-017f-08dbb9d89a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yldpJ+XuLq8Tcle/oGprRgEXMFZ5ZHqRNsANpJ9Y5DS67THu4T7hKfaX76MqfB94vXOkIYTgTf9unAWesKxi72bQwyT/zgpz/WVdFSAt0jmQiSbrhSHPHIVC0+QQF3iSR/mtx8vH39hyxGQWXRdSds1cpLkEwslLSshNkmQgX8KQLMpiDYm1XMDo2AUyoZZzXrAwZE6rnSKKv0ZGrWLLXeqlQstsxmXbo9YOlkNyei33/Dg4x5W/HrZxT3XzMDHyBHVbVJV5iK+5eJPrPxbHV2zk5cNsQxT3HY3rA3+/qTMNbtaH63lE1E0TbgixW0F5bB4O670wO+QzqiwSM89lc6yt71ICn2p2CuvLvAPEDiYZCpXi6X7c2ewp8HwDAKqnKHDMVZAd236JF6d2feuMEB23Ii1GXo8+lcTgYl4ssuxEK4A6vszyizp3jIRt8L2uvm+g0eeh1ciomoYcfHwuUMPoe/WXkXntd+A08Do786tnoOY2eQZ6j3QKGQZXxfFRxfDTd/WzclgQVtGquqee/FlB1LO1UYCnTPeEoC2QTJvknjUIX7sPMIgkaVudPygaIuygLG5yzQhX2hl6nE3r4NZpSdluo1tKFB6jEw0aKPuR7E1fJ3SCFZGt4ZjmQG+c0wU+hWtRAsM8rF4Q4Ar/6otk7u1BVD11cwOw3fCXDsl+0hC7FjKeftWPv2GB/j6l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(38070700005)(6506007)(6486002)(53546011)(71200400001)(6512007)(478600001)(83380400001)(26005)(2906002)(7416002)(66946007)(54906003)(66476007)(76116006)(66446008)(66556008)(64756008)(316002)(2616005)(6916009)(4326008)(91956017)(8676002)(5660300002)(41300700001)(8936002)(36756003)(31696002)(122000001)(86362001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9McVdpMWhHL0JUOFYyOVhEWStObHFPUGVvc1NMeFZUWnptQmZ2bGdXcHMx?=
 =?utf-8?B?UHFPZ1k0R25vMElmV3h1V1d1UjJxVGhKN293LzhFQ2M1Qk1HT3VsYk1YKytI?=
 =?utf-8?B?b2R4eS9aa2FaVVlYZ1lnTEQxL21EVXJiZDNNb3FQNjBwV2FOMkl0U0p4SElz?=
 =?utf-8?B?WlQ5SGdlWTZKc0YvaUNhVzRkUVNZM1VZd2cySXBWZUQ2Ri9KU2gydEhOYTQ1?=
 =?utf-8?B?K0VrNEd4WDlQdjNBbmhkQThqMDA3L3NEVy9TbnZOWWdFengwRm55dm85WkxQ?=
 =?utf-8?B?L29PTXBPZWlSVnh0UXBuckxISUk0aFYvZDVuc3ZyL096V0NvelBEd3dIUk10?=
 =?utf-8?B?RkQ3OXBlM1hkc3VrdWNSWXdoYzUwTFZyNHF3YTV0MVl1OVpzZ1NUbTVHa0pY?=
 =?utf-8?B?K3ZyVVF6OG9QUVJhNHoyb0hHZHNmb3RRL0V6SzJlWTJrM1Q2dWdQN3VZM0p3?=
 =?utf-8?B?NjRqWVYrWVZLeUlmVjhhSCs0RnhCYXRjSGhTWVJNNm5KRnNrRFVBZVUrZDZr?=
 =?utf-8?B?NmFHQjZJZzA0NE9QSnNabitZSEdjV3BXQ0lHcEFlRmtFWmZ1ck9nWU4xQnIr?=
 =?utf-8?B?SkJVRlVkNWRaS0N2Rit1cVhJZEZNMHFNWDNFL29sTHphQ3lrbXBjbmFqVlVr?=
 =?utf-8?B?MjZ0OGxmZS9jdXg3RnRRZFhlWWhUeDZOTERCbXpqRDROUENNQnRxMS9tamFZ?=
 =?utf-8?B?R1RDTHFYa0VhZGw0ZmpWQzBocGw5eG5Zd01yUHhuUXg5V1ltZ0RoSG9QbUp5?=
 =?utf-8?B?cFNpaFhadUc5SzQxbC9nSWlYOXB3MWpNTG1NRGlrTkFIY0xJUlJFdTd2NEdZ?=
 =?utf-8?B?bmU1Ty9uQ1dHZXJDK0tsUWkrMXdpdU45djBxcCtEcjkzbG9GT0VBS2NMK3k4?=
 =?utf-8?B?UTMzRmllNXFhbkttbFJUb0dVOHl6WVFsOFJCRWVUMGk0UXUvdllYOFlWQmlU?=
 =?utf-8?B?VnBVWVNaTWxRaVUyMWUveFlUNFZKb0RwV3F5Uks0Q3ZyT1EyYU84OTJ2d3B3?=
 =?utf-8?B?SFZSb25DTlE2bnBlU1l6UlFYYXhwa3lOYUEwTks5UnMxNURCb1JpRGFpOWFZ?=
 =?utf-8?B?UTlMQk40S2lZd1l4UlJUWFpDVG9HUEt4VkRuRkRiUXlsR2M5RG90ZUkvYVYx?=
 =?utf-8?B?L1pzTTF1MkpwTi8yczZJR2N5YUFLbGVRREdGL0lpZXhKcFowa2tGZDIxd0FX?=
 =?utf-8?B?RFJLNEc4amtPdzNpMWdURzcrSEtqT3NNbE9RWjFFT2NXN0s3K3MzQ3M5U0p0?=
 =?utf-8?B?RmVLQUord2gwanFPeFhNbDZrSDhqdStxMlBNbTQ4YmxoQWVubWNvZlBYTG81?=
 =?utf-8?B?Y21mV2Y2TGZuNzlwZXBMY0d0RTJxR3dIQUl0VjJ0Z0hqVXN4d1l0N1JEMS8w?=
 =?utf-8?B?NkFSalhaNThNR2dxTmZMTitJRDNnV0RMbUdRNVdZZmt5ODZ5UHNlajdOWUY1?=
 =?utf-8?B?YW95QVlFUzgxSHhjR2VqRE9oenplOTlUS0dOYmNQVlYvQXVId3BCMlVCVStk?=
 =?utf-8?B?dHBuMzBJT1VsM01Od0x3K2hoWUNRL2hwQ0hXTzg1S0s5L0I5RVhGL09rajZy?=
 =?utf-8?B?aGRvQklVZ3NRdjF6OWgrYVk1ek1YZFNCbHBjME1QdUtSU1NUUTcvUHNrYU16?=
 =?utf-8?B?UGp3MWNndEVVdHZjM0hlM3orSWJrNlBSTTRLUVkzaFFKbTdtbUpqeGRCcjQw?=
 =?utf-8?B?eUpuTExZckR4WWhhUC82TzZrTDNSRmcybEpxT0k0akZzQ1FLc09LZE5ROVpD?=
 =?utf-8?B?S05vdml2U3FNQVBmRCtwajJDeGxNTndncWVRclF3ZTJvTzFqVDM1TC9tcHdm?=
 =?utf-8?B?NTVTVVhaOTFoeUQyUHBuTVc3ak95K2pSYVc3UU4wZGVpUzhZdE11cFRJREZm?=
 =?utf-8?B?c3ZNQktxUThTNGd3bURZS2pMZmwwN0Q2NFpSSWlVS0JUemp2VUJiSVloTG9Q?=
 =?utf-8?B?RG9nRDUxNU81cVMxQ21ueDlVYjFOS042dWNHYy9sYklyUzVSelpNUUNxMXB5?=
 =?utf-8?B?S1djTTl2ajljL0lBdkhWQ0Fyd01jdzM0Q0pUWnhORitkQnFaMEtEZ1RCTjJG?=
 =?utf-8?B?K2J1a3E4Yy91ZytCamNHK3U1R2lkWk1vYVIxeEJVZlc2MTNhckZqQWkyQ0xT?=
 =?utf-8?B?NTRhTVEvaE1ZMEJielNXWDM1RUlQWXh3UG9PK3ZrVXRTUHdjRlppaXIvVFJp?=
 =?utf-8?Q?2EbR/D28qZWfIm55YJqF3b4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A094AEB5C8014F9C73926598DA9D71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b008ce97-d046-4074-017f-08dbb9d89a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:53:35.9232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+nTgSQ8Y2IB9iA0aUWSXHfSO4qnki8cDnLq5Os73OfBZBLPEh+Qjbup3ZK/Fk35zo3SrNIdBNh0fQ286Mt3qlcnTN2jHiBdlJlCwyUgdBvCyLv0NtCbyGmBpYROMIQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5376
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxOS8wOS8yMyA2OjIwIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gU3VyZSwgSSBjYW4gbW92
ZSB0aGlzIHBhcnQgdG8gb2FfdGM2IGxpYi4gSWYgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHkN
Cj4+IHlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGUgU3RhbmRhcmQgQ2FwYWJpbGl0aWVzIFJlZ2lz
dGVyICgweDAwMDIpDQo+PiBkZWZpbmVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXgg
TUFDLVBIWSBTZXJpYWwgSW50ZXJmYWNlIHNwZWMNCj4+IHJpZ2h0PyBJZiBzbywgdGhlIDl0aCBi
aXQgb2YgdGhpcyByZWdpc3RlciB0ZWxscyBhYm91dCBJbmRpcmVjdCBQSFkNCj4+IFJlZ2lzdGVy
IGFjY2VzcyBDYXBhYmlsaXR5LiBEaWQgeW91IG1lYW4gdGhpcyBiaXQ/IElmIHNvLCB0aGlzIGJp
dA0KPj4gZGVzY3JpYmVzIHRoZSBiZWxvdywNCj4+DQo+PiBJUFJBQyAtIEluZGlyZWN0IFBIWSBS
ZWdpc3RlciBBY2Nlc3MgQ2FwYWJpbGl0eS4gSW5kaWNhdGVzIGlmIFBIWQ0KPj4gcmVnaXN0ZXJz
IGFyZSBpbmRpcmVjdGx5IGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgTURJTy9NREMgcmVnaXN0ZXJz
IE1ESU9BQ0NuLg0KPiANCj4gWWVzLiBJZiB0aGUgY29yZSByZWxpZXMgb24gYW55IGZ1bmN0aW9u
YWxpdHkgd2hpY2ggaXMgb3B0aW9uYWwgaW4gdGhlDQo+IHN0YW5kYXJkLCBpdCBzaG91bGQgY2hl
Y2sgaWYgdGhlIGNhcGFiaWxpdHkgYml0IGlzIHNldCwgYW5kIGRvIGENCj4gZGV2X2Vycm8oKSBh
bmQgcmV0dXJuIC1FTk9ERVYgaWYgYSBkZXZpY2UgZG9lcyBub3QgYWN0dWFsbHkgaGF2ZQ0KPiBp
dC4gVGhhdCBtYWtlcyBpdCBjbGVhciB0aGUgY29yZSBuZWVkcyBleHRlbmRpbmcgdG8gc3VwcG9y
dCBhIGRldmljZS4NCk9rLCB3aWxsIGRvIHRoYXQuDQo+IA0KPiBJZiB5b3UgYXJlIG9ubHkgdXNp
bmcgbWFuZGF0b3J5IHBhcnRzIG9mIHRoZSBzcGVjLCB0aGVuIG5vIHRlc3QgaXMNCj4gbmVlZGVk
Lg0KT2suDQo+IA0KPj4+IEkgd291bGQgZXhwZWN0IHRvIHNlZSBhIGNhbGwgdG8gcGh5X2V0aHRv
b2xfa3NldHRpbmdzX3NldCgpDQo+Pj4gaGVyZS4gcGh5bGliIHNob3VsZCBiZSBhYmxlIHRvIGRv
IHNvbWUgb2YgdGhlIHZhbGlkYXRpb24uDQo+PiBBaCBvaywgZG9pbmcgdGhlIGJlbG93IHdpbGwg
bWFrZSB0aGUgbGlmZSBlYXNpZXIuDQo+PiAuc2V0X2xpbmtfa3NldHRpbmdzICAgPSBwaHlfZXRo
dG9vbF9zZXRfbGlua19rc2V0dGluZ3MsDQo+IA0KPiBQbGVhc2UgZG8gc29tZSB0ZXN0aW5nIGFu
ZCBjaGVjayB0aGF0IHBoeV9ldGh0b29sX3NldF9saW5rX2tzZXR0aW5ncw0KPiBkb2UgYWN0dWFs
bHkgcmVqZWN0IGFsbCBpbnZhbGlkIHNldHRpbmcuIEkgY2Fubm90IGd1YXJhbnRlZSBpdCBkb2Vz
LA0KPiBhbmQgaWYgaXQgZG9lcyBub3QsIGl0IG1pZ2h0IGFjdHVhbGx5IGJlIGEgUEhZIGRyaXZl
ciBidWcuDQpZZXMgc3VyZS4NCj4gDQo+Pj4+ICtzdGF0aWMgaW50IGxhbjg2NXhfbmV0X29wZW4o
c3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4+Pj4gK3sNCj4+Pj4gKyAgICAgc3RydWN0IGxh
bjg2NXhfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KG5ldGRldik7DQo+Pj4+ICsgICAgIGludCBy
ZXQ7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKG5ldGRldi0+
ZGV2X2FkZHIpKSB7DQo+Pj4+ICsgICAgICAgICAgICAgaWYgKG5ldGlmX21zZ19pZnVwKHByaXYp
KQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgbmV0ZGV2X2VycihuZXRkZXYsICJJbnZhbGlk
IE1BQyBhZGRyZXNzICVwbSIsIG5ldGRldi0+ZGV2X2FkZHIpOw0KPj4+PiArICAgICAgICAgICAg
IHJldHVybiAtRUFERFJOT1RBVkFJTDsNCj4+Pg0KPj4+IFVzaW5nIGEgcmFuZG9tIE1BQyBhZGRy
ZXNzIGlzIHRoZSBub3JtYWwgd29ya2Fyb3VuZCBmb3Igbm90IGhhdmluZyBhDQo+Pj4gdmFsaWQg
TUFDIGFkZHJlc3MgdmlhIE9UUCBmbGFzaCBldGMuDQo+PiBBaCBvaywgeW91IG1lYW4gdG8gdXNl
IGV0aF9od19hZGRyX3JhbmRvbShuZXRkZXYpIGluc3RlYWQgb2YgcmV0dXJuaW5nDQo+PiBlcnJv
ci4NCj4gDQo+IFllcy4gQW5kIHRoaXMgaXMgZ2VuZXJhbGx5IGRvbmUgZWFybGllciB0aGFuIG9w
ZW4sIGFzIHBhcnQgb2YNCj4gcHJvYmUuIFlvdSB3YW50IHRvIGF2b2lkIHN1cnByaXNpbmcgdXNl
cnNwYWNlIHdoZW4gdGhlIE1BQyBhZGRyZXNzDQo+IHN1ZGRlbmx5IGNoYW5nZXMgYXQgb3BlbiB0
aW1lLg0KQWggb2sgb2ssIHdpbGwgbW92ZSB0aGF0IHRvIHByb2JlLg0KDQpCZXN0IFJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgIEFuZHJldw0KDQo=
