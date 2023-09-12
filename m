Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8575A79D0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjILMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjILMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:15:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF7710D2;
        Tue, 12 Sep 2023 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694520909; x=1726056909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OznXB3Tja3QyhDOISDHii827VVASY4HaPSp213hTCh8=;
  b=l6LCfnh4jvX+T0hSCOq3G2sjjOOrAd5a17gZnrnUU7lTGo2+1QbJ70dr
   JVlv32OLeHhDg8/eVggjeh5awW6/Rc3FRkTnqKX5Ederqwmyfpd1cRIrC
   1cIpMOy14DhmiiutYxmmLhRZC3CyKwRBpLDp0u2CzPFsw6Wd2S69ew3IL
   5G3ouVMq1XI5l6H/Unis88X79+ZzejcxbftWdtXEyCLj3ZhqpUy6GHbov
   j3729J0pbl1o0XuV5k0fFBjM2mWJPGnl9+YgPftjXIq0J2A6P7E1VWws3
   rdnlBvl9Ir2a41Y3sY/n7r9PzKit4oEVUkWCcEzqBP1OyNln5nAq6cMjV
   A==;
X-CSE-ConnectionGUID: i7bsysiIT2GEojdFbYMyeA==
X-CSE-MsgGUID: Yn6cwHKrS2O95SPLsqR55A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="4371197"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 05:15:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 05:15:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 12 Sep 2023 05:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V71dcOa4V7HsTWEuedPW+4RuZv54MHkcrLWilETkajSVYafZzuzQ6f8B7EqyNjFCRGumI2+Fp4byacpEgYMbZIVw8I7mmUR//nAWxn76yTgbXxBdK03ZxP6R2WQp+7fMHcop0W92lhrQw87aTtRn2aYpUQmS6aUZGkT3IC5oSH+p/JnWSnKKtJMHwjdbUTUZsom9t8t1NLfHYXwpzkl1CcqF3XKMMHVWPI71Tm/iRO8b0b3xjcNeQZu5kler3RI5Qbf2veawXRk46iK8NE6W+Z1p1fF8Z8esXQvC+Te8dFqG1Qh4WwdP4DY5iUKSd1oneUePFxe3CNXqxsiSHcfPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OznXB3Tja3QyhDOISDHii827VVASY4HaPSp213hTCh8=;
 b=cGBMy9hdbkINbFtPxaeX9reKnoWiadXAd0FitTV+4ffKxGKtnyANe7qh2PrPFhvzOYkLUAhbItXaQP933ASppOFik9mIpWtPQvhAP4SqERTTS2lTOmzIYszEihkIHH6fLaXfFzg5PscXuxwbKOpPzKQmElv8vwfPiyJqSWyYTjcjw6BZF1pHri4vVjfczMncWsZDkeHCg5jZ9eEgS1Re+DDDgIdABje4vxWPaantNdQTBwGurygnK9hoZyWpcpr2+dHOzP8njhU131O2OgLB9LXxIdd1LcXmPxFZgvwZLLebB5mWygbyFHZWQhT8kL04ZVo2T+lXQQn20b+pH2t7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OznXB3Tja3QyhDOISDHii827VVASY4HaPSp213hTCh8=;
 b=AwZC2RiulrHdZC3FIaDANkZYG9CVH/9YZKgnMrGnlpfK1bhFrodNlLrpXBna5IztuWagpSRcfcdDfEZMDrIKISpLrU0BIjOlAl1jnOo6/9dKH+gkS5eDrvn6m6bM7SYnB8tvCuTkI+Z2gGD0Ey5UHb085QJEElhbVQjGPSZPSQY=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 BN9PR11MB5514.namprd11.prod.outlook.com (2603:10b6:408:103::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 12:15:07 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 12:15:06 +0000
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
Thread-Index: AQHZ4mE4qGiJRc4rzEqgohxfx8uHBLAT5cgAgAM68oA=
Date:   Tue, 12 Sep 2023 12:15:06 +0000
Message-ID: <f429ea93-9cb2-8869-a98d-fb55161cf880@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-7-Parthiban.Veerasooran@microchip.com>
 <feb8eaeb-954c-416d-6e30-acb4b92764e0@linaro.org>
In-Reply-To: <feb8eaeb-954c-416d-6e30-acb4b92764e0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|BN9PR11MB5514:EE_
x-ms-office365-filtering-correlation-id: ba4ac5a0-aca9-413b-4a1c-08dbb389e6e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1OZYO053uBE+aaB+fyk44aHLou3oT9csO15StCwhjcv9k0JyZ2/wp64qAqUGPGDjCtP6E8hpt6Xvn3bDZ4dVCvqi1z57TtXWaeq22Dp5B+wTaEoa1HymJOryPhPxx1BbymmV1RZ6o3oJSe0RSMx7A0PAQVK1iisqsRUIYc4JdERh4wTSEuS06OWm9ERbs5EanFnfgGYIyyflp7Dl0ksyuTvCzo/ZdfoeyIwRWMR9h1N+G6yTTKtFvx2fQmN/9JA11iokeeNkSnam2NAlCYmUVoySnxbxPbV9ZvlicceGotPBHYmAt/Nvu3LCV4GylTQFaDDQ2OinZp28ADD1w0qiqRir4/y2Xlw2zsQZBFts8FTxtJivey2W/IZjoS1oR4Ei2GkZ+nS88rFZKuU0EirQsjmoFDaSZt2k20UFt9gDTGS9oGVL+62hf70IxEugx91nMMsPSUwRisngZOFCQAxMl/lxQ2Mrsd5D8XuGU5IQcOMqtB/s8hq37P5ezUyu28c/VcHKEVqc3CtIO+lg1sOCnA5doMtFlgSkPzqIOLtFXcD2ML7vzqC6keEKuWwUh8EM35F+J98A12vy+RAAvIY6RfZK2wQbQvvICCh6TYT+fFtldInIxC2i/7wEnDT1bpVJ6RNL0YkEb0c3OOqW9zQWloSV5oXoSQuL5ysE3Z3P9OiR1BjpFSr8yNcE40wC5AYZV2EQZSRJ2aEy+skJkTamA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(186009)(1800799009)(451199024)(76116006)(91956017)(86362001)(2906002)(53546011)(71200400001)(6486002)(6506007)(31696002)(7416002)(38100700002)(26005)(6512007)(122000001)(966005)(38070700005)(2616005)(478600001)(36756003)(5660300002)(8676002)(8936002)(31686004)(66476007)(66556008)(64756008)(66446008)(54906003)(6916009)(316002)(66946007)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aitudS9qNmltYXNFQ05UcXI3SGM4YlhValNxYU5RVzVXQjhjUXNTYnRRRHR2?=
 =?utf-8?B?YVBmTHovR2pYK2lWM3ErbzJSOC9RZXFNVTN4VFVVWkdSMzIrUHJtOGdXVGg0?=
 =?utf-8?B?ai9TMU5zeFNlanFnUVZ0MG14ZlVsTjBic0NzcnhFRWdnVE4vdlpPblMxbnFs?=
 =?utf-8?B?NUhHUWVFbEhzM25CNURSMmJuNjR1K25uV3F0TG9CYzdUVDdmV01NS0NUUE94?=
 =?utf-8?B?ellCOFZkQzcveEFnbHhjbGRmSFhNQXY5Y1Jsb2FjNjJGUnhIVDdnMHBpM0tl?=
 =?utf-8?B?Wm9saWNiT2p6WUEySkppeS90dithWXBIK2hmYy9zclA3d0pVYUNYemd1b24z?=
 =?utf-8?B?WTdRK0hJV09aQTRVekoxUmFzdWViRWovZ2gvY2M1dEhTaFl3VVY5aDh6Y29w?=
 =?utf-8?B?cTMvUFlhMVRmcDE2eEdhV1kreWJSeDNLQld4dkFnbnE3YXkwRWtYTE9zdTha?=
 =?utf-8?B?aFBGM1NPODhtb0d4SnlhOE5NUWFpSms2cGQ2ZWhXYkFkL2RvMDBlT2FERmFE?=
 =?utf-8?B?QUwrek4wZTYwQkZUblJOVEJWWHpMKzhUeTZvKy9oaXJtOHJSK1FWQlpoOGU5?=
 =?utf-8?B?L0FXYWlnZE5UVW5ETmZ3YmlkV1JlUUtNQ3RmQVp0RDFDMG9JS0xKalBKQWVO?=
 =?utf-8?B?Qm9BU0x0SThEQ1VaOWQ5bVZTUG5vbWhhcTVlVFBBRlVyamsyMFlJOW93N1pX?=
 =?utf-8?B?MUI4UEljZUxDdXI5YkJEWWVGbzJYdUxBUnkvRTZvcFczYnlHS0c4R1J4Tm9B?=
 =?utf-8?B?VDBSUFNjNFRmSVRtQkdkUHJkZHRmd1d2TDlqSUFWV2dlV2M4djcxcUgxWGpy?=
 =?utf-8?B?dzI2eEV5dXI0SHh6QmNHOSswYS9XZ0N4RU13WElaSFhhL2RHQmlsOUlSRjVL?=
 =?utf-8?B?ZGVleXBkdE1iMDgyQXA1eHpuN3JydkxIWXNOUDFJcUIzNmFvR0txQkxicEpQ?=
 =?utf-8?B?ZnphaTdwdUJNdk15aWx5K0t2QWRBMDQ1N01UdmJoSEVEc2hPVTA0dmhmdGdh?=
 =?utf-8?B?aGY5Mm1jT1pPaVcwbWx1aXlYM1VoSGtORFE3Ris0VjNOU3RjaDdQajNnTVBm?=
 =?utf-8?B?SmhNMlQxd2F4S09xQTBXMEc3MWx2bi9CeE9DZGptMWlMeFFlZjlpcTRmNHND?=
 =?utf-8?B?Y0I4RVZBUVpaYVlPTWJPM2xIaUdqM1BQdFI3WkMxUHFpcVo1NE14aERxMmwy?=
 =?utf-8?B?RVpvTXNtcUI5Z0luaDZTMUM0ZTlObVgxUnN4ZytrTGkvUHpSQlVSZ1l1MFM1?=
 =?utf-8?B?WEtGaTV1b2RDTEtPUGxkam8yeHhGUkpuODZ4T1pYRnllZlNIRUVnK0o1V0VE?=
 =?utf-8?B?a3NYMEh3RGZDcERiTHNoeVBVTmIxeDMwdyt2ZlkwdXpzbW9nYnZkRHBCUERG?=
 =?utf-8?B?MnBxY2cyM3hFNXZDYkswMTdzSURnd0dvUVVqSlBpNzdZazBNclpwTTNEbG1V?=
 =?utf-8?B?aHd2d2ZjSGkzWTlEU29TclA5NGUxdC9ERE5oK3R4Sk96VDU4K0dVR2pJQjVH?=
 =?utf-8?B?NW8xRjhOUjRQMWk1T3BmaFRQSzZUVjdFbXZqWmp1aTBNOUFWSUZBaHM1Situ?=
 =?utf-8?B?RzVvaDAxeXdMNVFHNDNzTmpYSkFlL2NOWjhEU0swbHIvWVpsVkVVT0dEajdW?=
 =?utf-8?B?dElNb3RWRnRsNGdra1Vjc0hqOVhrSytTSkdvZnJ3dHVFc2t3UTQrc3NLb1Za?=
 =?utf-8?B?QjY1NUNma1pXL25HQktmRkpWbS9kV1l5Ri9MQXpraXdrenVVY05RN2xud0M5?=
 =?utf-8?B?SkRaMWpoSXhSeGFVdVE5MERIcHJ3K21XaUZTRThKMXV5c2dZelI1R2R1UG5J?=
 =?utf-8?B?Sk4wdkNCcGNSTWcxaXRhWDRWcld4bUZ0U05SZU1sc1N1cXRGUG54azVFSG1k?=
 =?utf-8?B?UStCWVgyQXk1dHhpVGNqcUt6ZEZoSi9FWkxhbmN6amJCa0JxSnBUanBGL01n?=
 =?utf-8?B?QU9SV1cxWmVGUGRPdVY5Y2QzNnZ6bEFFRlNjSllQWGN4N2xITG4zZUEwaEVi?=
 =?utf-8?B?dk14cVpBRHE2cWJxcEM3SmRWOVU1KzdqTTFYOUc0WFgweHpVMnltSCtmd1ZG?=
 =?utf-8?B?RGVJVEtKZGRNb0lnRFQ1czg1eHZQc2tJWUM1cmRYQXFGNTJqQzVJNllseVJT?=
 =?utf-8?B?bHk0NUYvYVdwNmxJbWhuUGNTbURVZG1sR2NxRmlxTm1UUEN2dFNoM0J1Sitj?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E3AD6F4FDA134AA14A0DE40FF2DF84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4ac5a0-aca9-413b-4a1c-08dbb389e6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 12:15:06.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+GoM2gQX7GDfBGrkcZrgNiqXMK9/JKPzSitB0TLfdMbgpAdzSM9fmBqOH/9q/6Yv2UC3FaG9CVUWO8lynKfmJUdjAso6MrHoe4n7L0LehB9PebNPlKu4C0cF4DeZeNT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQoNCk9u
IDEwLzA5LzIzIDQ6MjUgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDgvMDkvMjAyMyAxNjoyOSwgUGFy
dGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPj4gQWRkIGRldmljZS10cmVlIHN1cHBvcnQgZm9y
IE1pY3JvY2hpcCdzIExBTjg2NVggTUFDUEhZIGZvciBjb25maWd1cmluZw0KPj4gdGhlIE9QRU4g
QWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZSBwYXJhbWV0ZXJzLg0K
PiANCj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0u
IFlvdSBjYW4gZ2V0IHRoZW0gZm9yDQo+IGV4YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUg
LS0gRElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkNCj4geW91ciBwYXRjaCBpcyB0
b3VjaGluZy4NCk9rIHN1cmUsIHNvIGl0IHdpbGwgYmVjb21lIGxpa2UsDQoNCmR0LWJpbmRpbmdz
OiBuZXQ6IGFkZCBkZXZpY2UtdHJlZSBzdXBwb3J0IGZvciBNaWNyb2NoaXAncyBMQU44NjVYIE1B
Q1BIWQ0KDQpJIHdpbGwgY29ycmVjdCBpdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQYXJ0aGliYW4uVmVlcmFz
b29yYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvbmV0L21pY3Jv
Y2hpcCxsYW44NjV4LnlhbWwgICAgICAgfCA1NCArKysrKysrKysrKysrKysrKysrDQo+PiAgIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4
LnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4zNDY1YjJjOTc2OTANCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9j
aGlwLGxhbjg2NXgueWFtbA0KPj4gQEAgLTAsMCArMSw1NCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEu
Mg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L21p
Y3JvY2hpcCxsYW44NjV4LnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IE1pY3JvY2hpcCBMQU44
NjUwLzEgMTBCQVNFLVQxUyBNQUNQSFkgRXRoZXJuZXQgQ29udHJvbGxlcnMNCj4+ICsNCj4+ICtt
YWludGFpbmVyczoNCj4+ICsgIC0gUGFydGhpYmFuIFZlZXJhc29vcmFuIDxwYXJ0aGliYW4udmVl
cmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjogfA0KPj4gKyAg
RGV2aWNlIHRyZWUgcHJvcGVydGllcyBmb3IgTEFOODY1MC8xIDEwQkFTRS1UMVMgTUFDUEhZIEV0
aGVybmV0DQo+IA0KPiBEcm9wICJEZXZpY2UgdHJlZSBwcm9wZXJ0aWVzIGZvciIgYW5kIGluc3Rl
YWQgZGVzY3JpYmUgdGhlIGhhcmR3YXJlLg0Kc3VyZSwgd2lsbCBkbyBpdC4NCj4gDQo+PiArICBj
b250cm9sbGVyLg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiBldGhlcm5ldC1jb250
cm9sbGVyLnlhbWwjDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+
PiArICAgIGl0ZW1zOg0KPiANCj4gTm8gbmVlZCBmb3IgaXRlbXMuIEp1c3QgZW51bS4NCk9rIG5v
dGVkLg0KPiANCj4gDQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAtIG1pY3JvY2hp
cCxsYW44NjV4DQo+IA0KPiBObyB3aWxkY2FyZHMgaW4gY29tcGF0aWJsZXMuDQpZZXMgdGhlbiB3
ZSBkb24ndCBuZWVkIGVudW0gYWxzbyBpc24ndCBpdD8NCj4gDQo+IE1pc3NpbmcgYmxhbmsgbGlu
ZS4NCk9rIHdpbGwgYWRkIGl0Lg0KPiANCj4gDQo+IA0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJ
dGVtczogMQ0KPj4gKw0KPj4gKyAgbG9jYWwtbWFjLWFkZHJlc3M6IHRydWUNCj4+ICsgIG9hLWNo
dW5rLXNpemU6IHRydWUNCj4+ICsgIG9hLXR4LWN1dC10aHJvdWdoOiB0cnVlDQo+PiArICBvYS1y
eC1jdXQtdGhyb3VnaDogdHJ1ZQ0KPj4gKyAgb2EtcHJvdGVjdGVkOiB0cnVlDQo+IA0KPiBXaGF0
IGFyZSBhbGwgdGhlc2U/IFdoZXJlIGFyZSB0aGV5IGRlZmluZWQgdGhhdCB5b3Ugc2tpcCBkZXNj
cmlwdGlvbiwNCj4gdHlwZSBhbmQgdmVuZG9yIHByZWZpeD8NCk9rIG1pc3NlZCBpdC4gV2lsbCBk
byBpdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiAr
ICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArDQo+PiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgc3BpIHsN
Cj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgI3NpemUtY2Vs
bHMgPSA8MD47DQo+PiArDQo+PiArICAgICAgICBldGhlcm5ldEAxew0KPiANCj4gTWlzc2luZyBz
cGFjZQ0KT2sgd2lsbCBhZGQgaXQuDQo+IA0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
bWljcm9jaGlwLGxhbjg2NXgiOw0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwxPjsgLyogQ0UwICov
DQo+IA0KPiBDRTA/IGNoaXAtc2VsZWN0PyBXaGF0IGRvZXMgdGhpcyBjb21tZW50IG1lYW4gaW4g
dGhpcyBjb250ZXh0Pw0KWWVzIGl0IGlzIGNoaXAtc2VsZWN0LiBXaWxsIGFkZCBwcm9wZXIgY29t
bWVudC4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+PiArICAgICAgICAgICAg
bG9jYWwtbWFjLWFkZHJlc3MgPSBbMDQgMDUgMDYgMDEgMDIgMDNdOw0KPj4gKyAgICAgICAgICAg
IG9hLWNodW5rLXNpemUgPSA8NjQ+Ow0KPj4gKyAgICAgICAgICAgIG9hLXR4LWN1dC10aHJvdWdo
Ow0KPj4gKyAgICAgICAgICAgIG9hLXJ4LWN1dC10aHJvdWdoOw0KPj4gKyAgICAgICAgICAgIG9h
LXByb3RlY3RlZDsNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4g
DQoNCg==
