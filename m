Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37F7DCD71
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbjJaNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbjJaNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:00:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E5DE;
        Tue, 31 Oct 2023 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698757224; x=1730293224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6lrPTOAiacMdmdOtTByxBYuJ3DvCdamR8i7qTarw3eY=;
  b=1sbY9d26a7gHVllen7SSuxu/x+h9GLIvKPzX9wjmdQzVAjcmj1xyr2e/
   v/MVziTeP0q3300rjvLMDx5jWme2JXz34DoycWuMv7fU8WfExkMrxMVk+
   fY1k36CyQosRO627ayKOoKy6aybTrer4I5j0KyaetQDcO5kucgOBEdi55
   HjV56jj9UNsMLgG0KYsrGGV3BuEv0NRYTwvm8g4dWtrcsNqewC2D6Kq/l
   MWcaClEuPXPxDgAlM8w0SrcfmGEJj65+zMWwFo5BPvC2OOYghPAm/ujgQ
   H2+0hQy4JzFejX5kgde4XzEcp+0kwYpYn4YU+7dqcVwtAZM/8yy4s3XCI
   g==;
X-CSE-ConnectionGUID: UQ1/csCVT4WZFdSox6Y0jQ==
X-CSE-MsgGUID: +7+hkVYxTIu3Erl0yYv6ag==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="10890424"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2023 06:00:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 31 Oct 2023 05:59:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 31 Oct 2023 05:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB+T7P9vYCVT4CDlH3hJ9vBHMwsjdQKtqVwXy4Dm/J4T7mdHOAMDJ8eoo2k/ObTPfa53h6D1sNJl9ZgR6L7K2smeml3Jx2dKr3RoHylSqZl0uVgrrSLCQ8Iipm1fpM2BN3BkZS5q7EIx+B0UUSXpotbNHv5GSKrxJQZser7Io2iOJ6L0RSfaAkXHSThIKgmyZps7LcgpWdJaw44aJyOg772199a2Zc9/hiD5/pnThDBH3Hp7ybYcQKDj3zGBfc2v3xWJoc0N6lvRY/VFaIuAYaeJ+ohxoLQ8FcT0W4+5bsvC6RNe7zBhuv9lkvCl9BaKPGw4AOMtK+EkOEHDybFZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lrPTOAiacMdmdOtTByxBYuJ3DvCdamR8i7qTarw3eY=;
 b=eoEdBJBxJg3KLmKSdiYklt9SNxJYiyONdqA/lmdtziaPPq0Kb6aDtAu7fIeQ+yrU/tyd1pBz893Lgcp3KerhFrHSzakSwQFTI8NmjXTss+HLSAhjzVszvrRpPRxkCXCLTJdh94OubO1I07tpT/BDzabqJ3BvmEI9/ue7xUZKhsHJRCIaNsZetZvzW5IrtzE69IDfr6xeMK5J3A7b3rzfReDSMwCNrCnSoSXjpE2Vf3K3AjNIWBfCOYZVbY/ohoHVEaKC6pGJasgBbmO5L6gtksQMswZOURFmR+bU8NBC05I2Q2HuxEigqJm36IvwrjsugxvV74DCfb/LvcKf8JAZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lrPTOAiacMdmdOtTByxBYuJ3DvCdamR8i7qTarw3eY=;
 b=TbeRMe/24mZSc8bCHV2m/0EECQq1vrk1A1hwz+KOCqUfQvsB7dmlDYz8MWA0caetiQ936XIBkIyiEnMDARKXyX8lykR2anwVqQ9C8h8NZcSbbzL5My0keT+gYQuxpo9mz9g5khWHe8jBGA6LVBFCGN7IKTSYY+sBpcEz6k/bkNI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 12:59:47 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 12:59:47 +0000
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
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Topic: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Thread-Index: AQHaBchdwqp9J78AZUCeswF+FBl/obBYkCcAgAtYjAA=
Date:   Tue, 31 Oct 2023 12:59:47 +0000
Message-ID: <90b77b7e-4424-4436-8cec-055f41fa7470@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
 <478c0e7e-bdff-41af-a12f-f9930f1c665a@linaro.org>
In-Reply-To: <478c0e7e-bdff-41af-a12f-f9930f1c665a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|IA0PR11MB7816:EE_
x-ms-office365-filtering-correlation-id: 8ad1561d-6b5c-4bb7-209e-08dbda1142ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bwPfuGv4lKR+fq3luWWyI5GQBj4lGau1x4olX0CeaIqi487WAlnGsX12TBL5vPHPYkdANoP3f55JW6tEdlBgQl7ly2OJgdabqMZh9LL3SlRMId1BEEK6vB1XipcJSYaNV21Mpp0EO+vkTZBhM2TtnGZBTutWBqQ0vDcsFUGiQWX7N058MM8SODMpZqwY++cVx9f4zfxBeBf9/ZxA1cOX/NARUFnhsttYavv8HbtoTieh7PThy6eukv/InOSMwKWZ8ZyurbQfZF78c2teAGSgjxnT6NXkuQ7NhLrjVkEPGKNQsDztctm+Vs71PrcTlB4zB1c7iK0qlBYC3V84ceVG730TLCKKcCuq6Jnx9gyEGQO8FNHw6Z8WJVy4ZWyIptgsKxTbK+rJ8CSq8AROgF0GtE2s9PmjsQJVUwcolo52FQTd+CM1ifZFP95AlLMzSdGkn6fexf5PRMqOV0oZS10j+2YIa2ofwQCgd91NEoNF8n+mD/wRxXRGTqi6hFawPVXR4EkhaaLKr8NbRr5MftXvk7+gtLnNv/4kb73OOTTRsvYGF/cr/cdobKusH9vtBEO8ppsMlevOffquxy2mEhkM4gl6NMkfjvWKXB1NzcJjQrMeqyjcXbnKeapeggS2uyPxXxFsw0ZEapUJFO1/8GXo/n50uEa9FPfHxE0jXUozxcdigJdEBg+40dwVSPnBG2mW/jYSoFPbNTCS+L0vvaTcf7Uya915iQCmDprrvMYOJlkgzJ5RqjFB/k8HGaWicOk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(2906002)(64756008)(122000001)(66476007)(66556008)(54906003)(76116006)(66446008)(66946007)(316002)(71200400001)(83380400001)(966005)(53546011)(6512007)(6486002)(478600001)(6916009)(6506007)(91956017)(2616005)(26005)(5660300002)(7416002)(41300700001)(8936002)(8676002)(4326008)(31696002)(86362001)(36756003)(38070700009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmxrVE5hblQ5NE1qUmtnOHBrb0NEdXhWWFdHWldlMkk0Y0thWG43Ym43dE9V?=
 =?utf-8?B?RFE0MW1GcUplZzQ2djd2T2lhOTJvaDZnSEhOd09lOTlPNEoydlJBeEdqSlZ2?=
 =?utf-8?B?YkRLN1U5WHZ0RS81Q01RRkNGL2MwMHdXek4vR0VXczJKU3gwS2VLZDR6SWJq?=
 =?utf-8?B?a2pjWjV0K0lrNXV0L2E2VlI5cjVKTEhZUFBqMlFWbjF0TWxOSUhVTWpRbnZr?=
 =?utf-8?B?V0RwS1l6dlkrSENLcjBYUTYvczVIUURuTm5aQUh0SFFKMHdtMjdnTEFlTGN5?=
 =?utf-8?B?QSt3RnVXL2FGaThnVUJKWndrVUVUbjdjdXFndlJVRW4yREtyRUlHcE1MQkRx?=
 =?utf-8?B?b2lxbm9RT21LV1JuMzM4YWlBK1ZySDRxVFVGTnhXZ3VvelN1S2x2bEExdVFq?=
 =?utf-8?B?YitxaW5ZaUhCS1ZoVFB1YjhHelZ4NExMME5mY2RERXYwaFdHM0JuNnZaM0NB?=
 =?utf-8?B?NmdaVHFZRE1yWmdUa2Eva1NKK1BYczM1eHk1UnV2MGM2NzZYM2RHQk9YU3JN?=
 =?utf-8?B?WHQwSkszQldMSG1EOE5UWGZKcW5jL3UzN0YwTnVwM3FoVEw2cjJBWkxGOFA0?=
 =?utf-8?B?S2xnWWZWVzd6MEkydGxsN1BnSnp6QUtCciszcDdndEhLZ3BETlV6OHgxeWJj?=
 =?utf-8?B?Ylc0WXJPVTBjb25LOHRBY2hiZytERldxYjFMbitlMXNpU0ZjcDcybTlpRlZW?=
 =?utf-8?B?WGJPYThKamh5RkhDNVQ2bDB3a3BMb0VSUnpndlZ0ZU5TcXVFYVJrOWlCVmll?=
 =?utf-8?B?S1NIM0xMWC9vUGRBTTQreE0zanoyU2dzendIQWV6Y1NqV2dONDlmVUh5TUlK?=
 =?utf-8?B?aDJieERUaFF0eXpSUldDalMrdnhMenFYRVY4cTVHZGFIamgyNTFwRWVXSmxR?=
 =?utf-8?B?aFRMZmxVTEpSZjNrd3IxTTBWdmdvUUxxRVZQS0FKblNLQTlhbjhJbS9NV3Nl?=
 =?utf-8?B?U1NXOVVXSEJZdC84T294UzlicitObTF2dTUyRWx5RnZ1Wm11clVTNEJoTHhw?=
 =?utf-8?B?aUIxcGhzVjRPaVhNa2s0d3NlN2EvZVhvWk1kcTB2cnhsUHNGK0FhSWR0RWFy?=
 =?utf-8?B?UWhqcFVwTEVyU3AyaE8xeWdFQ0xSWC9Ybngxck9GQVZIcFZZRkVGS0xVdEVY?=
 =?utf-8?B?NGVZU0tyMjFBWXdUV3ZWYVJTam9vbnhyOTBmL0lVaG1pN25zVjJ2RHhKQk5u?=
 =?utf-8?B?bnM5V2x6UVJkM2pYOXEzazcwd2VGVjRRdUhOZmJ0S2J5NzRxdncxUzVaemNk?=
 =?utf-8?B?bW5XNU52MzduQW14SkdudzhGS1puMlJIZzA2MWcvazNEcGRHbEhUYnlzQVh5?=
 =?utf-8?B?eDJPZ1B4WS9VMVgybkdRWElNUi9vMnhYTkRDTVBWdG4yNyt0aUlDSENzMTJT?=
 =?utf-8?B?blJ6VnJQaERlL0F4NFNxRmp3TSswQ0F0ODNLbnlGRmJLQW54em1zMldCNVRZ?=
 =?utf-8?B?eG81U3FRb0YyeEZKc3ozZTQvTDgvQUJSQ2xqZEZCa252R2FlTTJWeEE4bGdr?=
 =?utf-8?B?OXdPelpUZ0FaVjZ3a0Z1Q05UUWZUTGVKNTJSMXRsaE5URjdJZGUwMFlBOVdk?=
 =?utf-8?B?QnR6VHVSTWNhSEYyb2lXc1VRY1lGWHRacG40NlRoQ1d5eUZZTk5MNmpqZGdl?=
 =?utf-8?B?cjNrdnhWOFlUZFdLUXIxcEdMRG5lVFZrcHpkeGlwS0M1L0lQWGkwTk1MWVZM?=
 =?utf-8?B?OUdKOHlubTVwalJNeWp4RXk5UTdrS0VZNGE0V0NsbFJWR3NKcGthS2lvUElK?=
 =?utf-8?B?Sk0xbENWblJRaG9wK2FKckxsM1A1cklHUXg0dGZkYjhpWVZpZEFnQ2ZZWjBw?=
 =?utf-8?B?V3NyVXljemdJcEtXVXJvNnVvZmF6bXFiVktuOVRvYmRUaHNrUGxCMVJkeGpq?=
 =?utf-8?B?WGFZNTlvNm9PSERqQVFxUzlhV3UrZTJsZGJ3Z3ZPWXMzTXdyZHVQZ0Vsa3dk?=
 =?utf-8?B?RGR0bk94SHo2Z3kxb05lZzRhbVd0Yk43L0ZNaGpLK1k1NWE5bUpvL0VwMDNn?=
 =?utf-8?B?NEVLUlNodWtWclBTME1HRFNlUkdoWkpjbE9EN2lKc0szMGFCYXA5OWk5UXl1?=
 =?utf-8?B?K2kzenNXN2RDY0svbUFtUlRZcTcwb2oyamVDdVJPNlhsd1F0UnkvVjlFNWNS?=
 =?utf-8?B?UE9ud25oOWFydC9TNjBoOGRZOEFqNXRoTXpMOTRtaFVaMEQrZngxRUFFdjdo?=
 =?utf-8?Q?si8jxodJ9SiLCgf3LI0sdXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FED8DB2B3A1D447911838422D55EF85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad1561d-6b5c-4bb7-209e-08dbda1142ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 12:59:47.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oO7M8Y6Be3gQRx2aMeVeEU4Md6u+PMZxXCwAAZDoBwM+0rggTYndgmj4EvNFDFAc/ZL8mZONpgbbQtPN6HF40AjAUPJnNrYsXPZRoGgZBASrGHj7iVE4XqtDt21LlbCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mDQoNCkFzIHBlciB0aGUgY29tbWVudHMgaW4gdGhlIG90aGVyIGVtYWlsIG9m
IHRoaXMgcGF0Y2gsIHRoaXMgRFQgYmluZGluZ3MgDQphcmUgZ29pbmcgdG8gYmUgcmVtb3ZlZC4N
Cg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KT24gMjQvMTAvMjMgMToxNCBwbSwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+IA0KPiBPbiAyMy8xMC8yMDIzIDE3OjQ2LCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3Jv
dGU6DQo+PiBBZGQgRFQgYmluZGluZ3MgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQ1BIWSBT
ZXJpYWwgSW50ZXJmYWNlDQo+PiBwYXJhbWV0ZXJzLiBUaGVzZSBhcmUgZ2VuZXJpYyBwcm9wZXJ0
aWVzIHRoYXQgY2FuIGFwcGx5IHRvIGFueSAxMEJBU0UtVDF4DQo+PiBNQUMtUEhZIHdoaWNoIHVz
ZXMgT1BFTiBBbGxpYW5jZSBUQzYgc3BlY2lmaWNhdGlvbi4NCj4gDQo+IEV4Y2VwdCB0aGF0IGl0
IHdhcyBub3QgdGVzdGVkIGF0IGFsbCBmZXcgbW9yZSBpc3N1ZXMuDQo+IA0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1p
Y3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29h
LXRjNi55YW1sICAgICAgIHwgNzIgKysrKysrKysrKysrKysrKysrKw0KPj4gICBNQUlOVEFJTkVS
UyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vYS10YzYueWFtbA0KPj4NCj4+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29hLXRjNi55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vYS10YzYueWFtbA0KPj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWY0NDJmYTZjYWNl
DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L29hLXRjNi55YW1sDQo+IA0KPiBGaWxlbmFtZSBiYXNlZCBvbiBjb21wYXRpYmxl
Lg0KPiANCj4+IEBAIC0wLDAgKzEsNzIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+
PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvb2EtdGM2LnlhbWwjDQo+
PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+PiArDQo+PiArdGl0bGU6IE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUMtUEhZIFNwZWNp
ZmljYXRpb24gQ29tbW9uIFByb3BlcnRpZXMNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsg
IC0gUGFydGhpYmFuIFZlZXJhc29vcmFuIDxwYXJ0aGliYW4udmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZXNlIGFyZSBnZW5lcmljIHBy
b3BlcnRpZXMgdGhhdCBjYW4gYXBwbHkgdG8gYW55IDEwQkFTRS1UMXggTUFDLVBIWQ0KPj4gKyAg
d2hpY2ggdXNlcyBPUEVOIEFsbGlhbmNlIFRDNiBzcGVjaWZpY2F0aW9uLg0KPj4gKw0KPj4gKyAg
MTBCQVNFLVQxeCBNQUMtUEhZIFNlcmlhbCBJbnRlcmZhY2UgU3BlY2lmaWNhdGlvbiBjYW4gYmUg
Zm91bmQgYXQ6DQo+PiArICAgIGh0dHBzOi8vb3BlbnNpZy5vcmcvYWJvdXQvc3BlY2lmaWNhdGlv
bnMvDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgICRub2RlbmFtZToNCj4+ICsgICAgcGF0
dGVybjogIl5vYS10YzYoQC4qKT8iDQo+IA0KPiBEcm9wDQo+IA0KPj4gKw0KPj4gKyAgIiNhZGRy
ZXNzLWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDENCj4+ICsNCj4+ICsgICIjc2l6ZS1jZWxscyI6
DQo+PiArICAgIGNvbnN0OiAwDQo+IA0KPiBXaHk/DQo+IA0KPj4gKw0KPj4gKyAgb2EtY3BzOg0K
Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBDaHVu
ayBQYXlsb2FkIFNpemUuIENvbmZpZ3VyZXMgdGhlIGRhdGEgY2h1bmsgcGF5bG9hZCBzaXplIHRv
IDJeTiwNCj4+ICsgICAgICB3aGVyZSBOIGlzIHRoZSB2YWx1ZSBvZiB0aGlzIGJpdGZpZWxkLiBU
aGUgbWluaW11bSBwb3NzaWJsZSBkYXRhDQo+PiArICAgICAgY2h1bmsgcGF5bG9hZCBzaXplIGlz
IDggYnl0ZXMgb3IgTiA9IDMuIFRoZSBkZWZhdWx0IGRhdGEgY2h1bmsNCj4+ICsgICAgICBwYXls
b2FkIHNpemUgaXMgNjQgYnl0ZXMsIG9yIE4gPSA2LiBUaGUgbWluaW11bSBzdXBwb3J0ZWQgZGF0
YSBjaHVuaw0KPj4gKyAgICAgIHBheWxvYWQgc2l6ZSBmb3IgdGhpcyBNQUMtUEhZIGRldmljZSBp
cyBpbmRpY2F0ZWQgaW4gdGhlIENQU01JTg0KPj4gKyAgICAgIGZpZWxkIG9mIHRoZSBDQVBBQklM
SVRZIHJlZ2lzdGVyLiBWYWxpZCB2YWx1ZXMgZm9yIHRoaXMgcGFyYW1ldGVyDQo+PiArICAgICAg
YXJlIDgsIDE2LCAzMiBhbmQgNjQuIEFsbCBvdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkLg0KPj4g
Kw0KPj4gKyAgb2EtdHhjdGU6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArICAgIGRlc2NyaXB0
aW9uOg0KPj4gKyAgICAgIFRyYW5zbWl0IEN1dC1UaHJvdWdoIEVuYWJsZS4gV2hlbiBzdXBwb3J0
ZWQgYnkgdGhpcyBNQUMtUEhZIGRldmljZSwNCj4+ICsgICAgICB0aGlzIGJpdCBlbmFibGVzIHRo
ZSBjdXQtdGhyb3VnaCBtb2RlIG9mIGZyYW1lIHRyYW5zZmVyIHRocm91Z2ggdGhlDQo+PiArICAg
ICAgTUFDLVBIWSBkZXZpY2UgZnJvbSB0aGUgU1BJIGhvc3QgdG8gdGhlIG5ldHdvcmsuDQo+PiAr
DQo+PiArICBvYS1yeGN0ZToNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsgICAgZGVzY3JpcHRp
b246DQo+PiArICAgICAgUmVjZWl2ZSBDdXQtVGhyb3VnaCBFbmFibGUuIFdoZW4gc3VwcG9ydGVk
IGJ5IHRoaXMgTUFDLVBIWSBkZXZpY2UsDQo+PiArICAgICAgdGhpcyBiaXQgZW5hYmxlcyB0aGUg
Y3V0LXRocm91Z2ggbW9kZSBvZiBmcmFtZSB0cmFuc2ZlciB0aHJvdWdoIHRoZQ0KPj4gKyAgICAg
IE1BQy1QSFkgZGV2aWNlIGZyb20gdGhlIG5ldHdvcmsgdG8gdGhlIFNQSSBob3N0Lg0KPj4gKw0K
Pj4gKyAgb2EtcHJvdGU6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArICAgIGRlc2NyaXB0aW9u
Og0KPj4gKyAgICAgIENvbnRyb2wgZGF0YSByZWFkL3dyaXRlIFByb3RlY3Rpb24gRW5hYmxlLiBX
aGVuIHNldCwgYWxsIGNvbnRyb2wNCj4+ICsgICAgICBkYXRhIHdyaXR0ZW4gdG8gYW5kIHJlYWQg
ZnJvbSB0aGUgTUFDLVBIWSB3aWxsIGJlIHRyYW5zZmVycmVkIHdpdGgNCj4+ICsgICAgICBpdHMg
Y29tcGxlbWVudCBmb3IgZGV0ZWN0aW9uIG9mIGJpdCBlcnJvcnMuDQo+PiArDQo+PiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IHRydWUNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4g
KyAgICBvYS10YzYgew0KPj4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArICAg
ICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gDQo+IFRoYXQncyBzb21lIHRvdGFsIG1lc3MgaW4gaW5k
ZW50YXRpb24uDQo+IA0KPj4gKyAgICAgb2EtY3BzID0gPDY0PjsNCj4+ICsgICAgIG9hLXR4Y3Rl
Ow0KPj4gKyAgICAgb2EtcnhjdGU7DQo+PiArICAgICBvYS1wcm90ZTsNCj4+ICsgICAgfTsNCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
