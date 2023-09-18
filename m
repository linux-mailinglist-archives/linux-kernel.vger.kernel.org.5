Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06A7A4856
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbjIRLX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjIRLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:22:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588594;
        Mon, 18 Sep 2023 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695036172; x=1726572172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z4JnIsLOIogGXhdqq+EnhmdH67d0ZBJk7QoZh9aMRNM=;
  b=UjSaXNMWwKz2NarDBpiIRu6ykeyvZipgGfjCfjBXBdkoCOrWGwZovcwD
   SbHAYyNrb+WpbALdfhs7FQLP3ajQz0r++ozuuoaLRBs62WevLKnFedXf3
   Pr/o3BKZcsOU3JHNV175+nkwP1nE8XzkeUl1hPUBADb9pYNpxUMqcbhLd
   2D2bZrLvA8aSf4lYoVG/8/+8hdF7D8Eb2O4QwKaEzQwtQxjjA18YwwjyA
   Wi5RtGRCtXa/Nbt3GUjRUgEhxyobHDkp7Bg8n8vlRyNk5w3v8otfxRVDj
   Sh1KE7SL0Z6g4ue9rjtI0b+F69/6N8WamJM/cQfcx93ILEhxvpyaGjhXu
   Q==;
X-CSE-ConnectionGUID: s6gq2gw8Txa/V/OAGCgAiA==
X-CSE-MsgGUID: ivH+t/5kQfWRQWqx7Igqaw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="235737719"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 04:22:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 04:22:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 04:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+3jKcsB1aXiqzsgvAeXJeFs9MbDnIWXAcJFdlwzA2cE38M7XTD/TEvy8JxhVpUtXcjFLWk/VcGqJO2uyQ3XAPrCbE+8QEFhqXO/npEB55xsr5vk9UO1VeurffydXUfaUxJPzUjsu+0Z3w4zOd6hwzsy+HqVD4/urDEpAIuBgy0DMMPsW/UPJ2se2Dkq72egNryD4EJIawAN3kGQcDG6tCISqOg1OG74LgdBSfZUXthZhJWsQd2MzdOc6NBnVgaJVlWnqh0opBXccxnEmFfw24QQwfZKZkNhGWYRbn7/pICCUyyRaHMCDq3ZrKCdy81+OeeGG9ALOjGQn7ZSK2f0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4JnIsLOIogGXhdqq+EnhmdH67d0ZBJk7QoZh9aMRNM=;
 b=XGT9CFo4LHOTaFBmfYzeijfLtmnS7LYjR8ZOZIGHUiuSx3d9VBrzqh1hR/i1D49dR+A5boXgNfrssG2cogPRJMZcy2ZKSL2ADW2nQ4BBu+TBP838RS69rPv0oILmBVma+bIr4yrH1ASYpfQo8JD9iXxHB7oCRf2QhlLm8QSio/kmd7nSPVIOoirCv8h1vatN9DTu4hcxKaxBi7zrvqdz56qAttvBUjlYene9IhqOCPEerpopbz8qw+J9n3GcBbLSeq5IID+LJ6LOu1vomUwLOAMBe+azrh89fyiPS7HPGsBI2m5/H6OmIgCPc1PzmHYPcEIUITuHd9/CiUqJ9bo0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4JnIsLOIogGXhdqq+EnhmdH67d0ZBJk7QoZh9aMRNM=;
 b=Mc6NIl96UiHH24nFKOoGT7wD9Gqms2fMPpuj76Tl7GhCDdQlP129rgZ7B2JYS0gb44TgP0qFnpFqaWXynANJIU34yxXdnsVTvftZuCMjD5pbHpyAh7yd7gjuUYG/o+3jllvnYhtRxnY6IHsKowFEbNjpZPCBK00/AYZ/XkDBORE=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.23; Mon, 18 Sep 2023 11:22:13 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:22:13 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <david.wretman@ferroamp.se>
CC:     <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>,
        <andrew@lunn.ch>, <casper.casan@gmail.com>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <davem@davemloft.net>,
        <devicetree@vger.kernel.org>, <edumazet@google.com>,
        <Horatiu.Vultur@microchip.com>, <horms@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <Steen.Hegelund@microchip.com>
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mEuK01gdvjwlU2rxFfJz2fLmrAb5K2AgASbMQA=
Date:   Mon, 18 Sep 2023 11:22:11 +0000
Message-ID: <9043c1c4-a0e6-d9a4-4d37-9986e69649cc@microchip.com>
References: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
 <20230915130118.927821-1-david.wretman@ferroamp.se>
In-Reply-To: <20230915130118.927821-1-david.wretman@ferroamp.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB7026:EE_
x-ms-office365-filtering-correlation-id: 5f53d6c6-840b-42e8-6d09-08dbb83980df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTjVCiS8jWakT//NvbDZQO4OirxHQAo2ryo7pZt7/fFgRIqlkJ9Mzidlahl3QVt2yKlCco9GeE5GeX81pSBTK/4saZXTbUAuVUYe0N6O2etZjmwjDSHY3pRSHaZSOVN4V8FWfoseVFLK6W6MEApC9uhbQHiDmvVfxfqtkimNdp8DyoWqmx/w1mzomiDoEMv7Rm5aZIo18wNHsqFz7PHpvxmayDe9cHpfeMWuoNraTOSgF42RgrY55SNQ0SKxzCIhVjmsbeT5Cx5aPEusCfwGqLxgpLXVoRbKGBGsrw7RSi8AuD5AtWWP+DaWDC/TxZanBas8b4NvJZ7WhKRF4LSd/LQGax/ticrZQcFAAaZ+RH7NoblxKgSE7uKB+dV/8TMNfarqbX9LdytAMzMS8WoZzwq8BS/MI6FJZ/gW7RHLnOILyDbUyqYTg5orHN8gzh3jWcuqgSnIyO0FGvAfUED/f5QoAEXJ8na2TKmDhS1U0++wh+W14VYVQoCOiaKOTvM7SCFFCbcUXTv5tJJPHXmrn/tC7h8EJ8PCUN8HNr/eUMVLFsVpKpAt5Z0zZtgtGe6ck5qyXV9qRzd7P9UJ+xil+viy8nZV3VeLlg4wjli8w/aDblIxGeWCemFFz7AWQZltl9VoRq2ndz5Og14REctSHHLrPHPe+llb8R9SFEc2+9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(66556008)(66446008)(64756008)(66476007)(54906003)(36756003)(31686004)(38070700005)(5660300002)(107886003)(2616005)(38100700002)(26005)(7416002)(2906002)(31696002)(86362001)(4326008)(8936002)(8676002)(6916009)(41300700001)(316002)(76116006)(66946007)(122000001)(478600001)(71200400001)(966005)(83380400001)(91956017)(6486002)(6506007)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm9mTWJNbTFhZm4vaTN0RHdOeXRnYnhYU0pQUlI5eEJJUWFQQjVSanhKeTd3?=
 =?utf-8?B?WnRva09HcFA1RjdselJndHFjU2owamZ6S01xaE94U3E5Z0RBRW43K2xBS2da?=
 =?utf-8?B?Tnh6MUNkUlZaaXJ2TWJrY1ZuYVNzZEJ3L3VlSlpDRW1DM004eHZJNXdUelN1?=
 =?utf-8?B?Vzl5V3dldVliOG9GaFg4YTc0aGZpZjVjSU4rSnZ0emR0dklNZnBhRkwyemJX?=
 =?utf-8?B?Smo3dndNVEVVeGY4YUVNNTIwZUxrSG1lek8vaDNSYlpsVGJEZHpuREhFOHA5?=
 =?utf-8?B?ZGlObEN1NTROc1Z1dDhLVTgxcjZ0U3JzV2R2QTdJTzR4Y0NrYkIzOHZWU1FP?=
 =?utf-8?B?SU02MHloeXZVYkErcmt5VENJbEZMN05UMHlYWDNnTEZMK2ZwQXE1Q3ZFYm1a?=
 =?utf-8?B?RkRnQ04zY2hsM2x6QVJOZlk2N3l6bWREY2Zxd0VsdXlHTm82RExUUHFmQzZ5?=
 =?utf-8?B?YTlCL2dRZGRtcjZhRDlqc2dJNDhaTU9UbnNEOEZzTUZhd2RkWWhzdFlZVlNv?=
 =?utf-8?B?K2VScEZuQ0tyZkgzV2N0b1ZuYnhyNTNrc1J3NUViTU52bk1EL2dueGE4Z1dC?=
 =?utf-8?B?a0RMaDZ1Z0FIS01Sa3B0UDNGTWMwdmdqQk1MMUJaV0djMTIzUWwzN0h3dHBi?=
 =?utf-8?B?aTl3bHNJSXpYVG1XcHlYVit6ODk0WDlIbCtncytCVnp6TEQ2NDgzdE0ybmNy?=
 =?utf-8?B?YjFjbnBQeWMzV08zWXR1SEFoMWtMNWR6THV3MWJ4Y0N0cEpMeGdzSHd5Qkl1?=
 =?utf-8?B?dTF5VXF1dnRlZFBLbFZLVU1kWFVHSnJmbXlreElnVmVBYTVDeGlFRjRFS1Nn?=
 =?utf-8?B?Wk1NamNiNjF6ZjQyRHZRY1ZBbG5ZNTVPWHUySUluZFpuWUlPZmJENGxQQnA4?=
 =?utf-8?B?dnRWQ0pEVXpWWldTVTR5QUZXWFJ0QXk5VHZQTk1PTWdDcnBXcWZXRDNJMGFM?=
 =?utf-8?B?cGhaRmFrcUNtYjREQ2k2bGFNQzg1TFM5SzRGR1RXVElrREFpSkdJc09kKzVo?=
 =?utf-8?B?S2tNMFpxbWpJdkhsV3ZuMUxYM1grdUUzQ0RLeElQMzIwdXNzeU5MeUJLOEc0?=
 =?utf-8?B?SVZ5VE83K2M5RlhqWUhZMFdLVkduQWozVmxzdHlNeCtCR21DTE85ZjAwRHo3?=
 =?utf-8?B?TjlqQmZjTGw3VFlMaCtnQVV5cC93YkRGWGFxMHF3RzQ0ZThzR05ibkVOWDRy?=
 =?utf-8?B?KzNGajBMM1dnOXVrS2l1bzd3N3docDc3OEgvRGx4TXNVN2NtM291bkdWWXJZ?=
 =?utf-8?B?bGNEUmJJb1dZZVJ2VHQ0TVd0VEJFMEcyNm91bXBKU2hXbUdYcnF3Y25qK3NH?=
 =?utf-8?B?NHZaTmJnUHhiOHFCOVcyOU85NFBHcktFa214enRsWDlWMFpSbnQ3bXJYVkti?=
 =?utf-8?B?Tk8xcGs0MXAzOFd2WUxiZGVNQ3FmY0lQYk9wdVMwNFRzZndkUlJDdEo1UFFE?=
 =?utf-8?B?cC9NWXRYQzExTjI2elJ0V0tRTDBpbHFoZllVeHYzOXFYVmRDdFcrNSt2N0Vw?=
 =?utf-8?B?UUViOXMyOUV1d3FBbGdjQjB3Vi9TYlh0WE5qQjdQL0VJUnZtc3VxdWVkT3RJ?=
 =?utf-8?B?OXZvOFVoS1orMVdYV2U4Q2VYUWdZWjJxc1RTZHV0QWE5bnl2Q3pYQ2FabzBM?=
 =?utf-8?B?eG0zK290eFFpOUhjNTh6NFFJMWJCUHkwQWMyRlUrSEtpMkJmWEViOElLRzVM?=
 =?utf-8?B?Mjhuc29sYy81c1Y2RUY5dEdyMnJHNTVRQnk2UGtyVS9Yd2tBMjVROVBBM0dj?=
 =?utf-8?B?VnFURzZyc3V1ejJJOU9xeHF0UG8wT2dBMzIrOFlPL25XTWVlTU96SkpjQkp0?=
 =?utf-8?B?enJmai9PR3JaT254UFdYNmxVdGkrWFFDWVNCL2Fvb05STWJLeUxPTGdXYXJR?=
 =?utf-8?B?NFZaZGhhZ2FvM2I2Mmx2aHpReDlUeUwwaGlJS1lhY3ZXb21zVVRhMU5ldmJF?=
 =?utf-8?B?d0NPa1pIWC9oY1N1WTA4Sm5SSFBobkFtQU1YVEh2b1hraVJnODZZbXNTamI3?=
 =?utf-8?B?QjRURVhwamxOOXdTRFFjMk14RFlVR1UvbWkvK0JRSTJUZjRaZ2U4LytjaGZN?=
 =?utf-8?B?RlJLb3VNODV2L3k3YlVFMU10c25tZ29DbXZFSVFsT1BYcUtjUWh2dTNkQUor?=
 =?utf-8?B?bnkvYWg3MVJQZjZkNFRidG85Y3BqNkJHZVZCUWxZZTh1aGo2R2MrckdObmc2?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD647658ED8F9048BAAE2F76C8AC19EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f53d6c6-840b-42e8-6d09-08dbb83980df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 11:22:11.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqgDK07uBQgV9kqt9aQ6gpjFV4KuObcBKu/1ZQ9FPjT9q2PUhDs/5HQBDRysUU1wOOUnHuUl5xKfuUuNk6OkyE5MUE+Rx9WN0mPfcMcKtgajWKSU2jzO1rlUMJCLpIF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4gUGxlYXNlIHNlZSBteSByZXBs
eSBiZWxvdywNCg0KT24gMTUvMDkvMjMgNjozMSBwbSwgRGF2aWQgV3JldG1hbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiAtLS0NCj4gT24gRnJpLCBT
ZXAgMDgsIDIwMjMgYXQgMDc6NTk6MThQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdy
b3RlOg0KPj4gVGhlIExBTjg2NTAvMSBpcyBkZXNpZ25lZCB0byBjb25mb3JtIHRvIHRoZSBPUEVO
IEFsbGlhbmNlIDEwQkFTReKAkVQxeA0KPj4gTUFD4oCRUEhZIFNlcmlhbCBJbnRlcmZhY2Ugc3Bl
Y2lmaWNhdGlvbiwgVmVyc2lvbiAxLjEuIFRoZSBJRUVFIENsYXVzZSA0DQo+PiBNQUMgaW50ZWdy
YXRpb24gcHJvdmlkZXMgdGhlIGxvdyBwaW4gY291bnQgc3RhbmRhcmQgU1BJIGludGVyZmFjZSB0
byBhbnkNCj4+IG1pY3JvY29udHJvbGxlciB0aGVyZWZvcmUgcHJvdmlkaW5nIEV0aGVybmV0IGZ1
bmN0aW9uYWxpdHkgd2l0aG91dA0KPj4gcmVxdWlyaW5nIE1BQyBpbnRlZ3JhdGlvbiB3aXRoaW4g
dGhlIG1pY3JvY29udHJvbGxlci4gVGhlIExBTjg2NTAvMQ0KPj4gb3BlcmF0ZXMgYXMgYW4gU1BJ
IGNsaWVudCBzdXBwb3J0aW5nIFNDTEsgY2xvY2sgcmF0ZXMgdXAgdG8gYSBtYXhpbXVtIG9mDQo+
PiAyNSBNSHouIFRoaXMgU1BJIGludGVyZmFjZSBzdXBwb3J0cyB0aGUgdHJhbnNmZXIgb2YgYm90
aCBkYXRhIChFdGhlcm5ldA0KPj4gZnJhbWVzKSBhbmQgY29udHJvbCAocmVnaXN0ZXIgYWNjZXNz
KS4NCj4+DQo+PiBCeSBkZWZhdWx0LCB0aGUgY2h1bmsgZGF0YSBwYXlsb2FkIGlzIDY0IGJ5dGVz
IGluIHNpemUuIEEgc21hbGxlciBwYXlsb2FkDQo+PiBkYXRhIHNpemUgb2YgMzIgYnl0ZXMgaXMg
YWxzbyBzdXBwb3J0ZWQgYW5kIG1heSBiZSBjb25maWd1cmVkIGluIHRoZQ0KPj4gQ2h1bmsgUGF5
bG9hZCBTaXplIChDUFMpIGZpZWxkIG9mIHRoZSBDb25maWd1cmF0aW9uIDAgKE9BX0NPTkZJRzAp
DQo+PiByZWdpc3Rlci4gQ2hhbmdpbmcgdGhlIGNodW5rIHBheWxvYWQgc2l6ZSByZXF1aXJlcyB0
aGUgTEFOODY1MC8xIGJlIHJlc2V0DQo+PiBhbmQgc2hhbGwgbm90IGJlIGRvbmUgZHVyaW5nIG5v
cm1hbCBvcGVyYXRpb24uDQo+Pg0KPj4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9s
bGVyIChNQUMpIG1vZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcw0KPj4gaGFsZiBkdXBsZXggRXRo
ZXJuZXQgTUFDLCBjb21wYXRpYmxlIHdpdGggdGhlIElFRUUgODAyLjMgc3RhbmRhcmQuDQo+PiAx
MEJBU0UtVDFTIHBoeXNpY2FsIGxheWVyIHRyYW5zY2VpdmVyIGludGVncmF0ZWQgaW50byB0aGUg
TEFOODY1MC8xLiBUaGUNCj4+IFBIWSBhbmQgTUFDIGFyZSBjb25uZWN0ZWQgdmlhIGFuIGludGVy
bmFsIE1lZGlhIEluZGVwZW5kZW50IEludGVyZmFjZQ0KPj4gKE1JSSkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWlj
cm9jaGlwLmNvbT4NCj4gDQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlc2Ug
cGF0Y2hlcy4NCj4gDQo+IE9uZSB0aGluZyBJIGFtIG1pc3NpbmcgaXMgc2V0dGluZ3MgZm9yIFBM
Q0EgcGFyYW1ldGVycy4gSSBmZWVsIHRoYXQgdGhlDQo+IGRyaXZlciBpcyBhIGJpdCBsYWNraW5n
IGFzIGxvbmcgYXMgdGhpcyBpcyBtaXNzaW5nLg0KTm8gaXQgaXMgbm90IG1pc3NlZC4gVGhlIGRy
aXZlciBzdGlsbCBzdXBwb3J0cyBmb3Igc2V0dGluZyB0aGUgUExDQSANCnBhcmFtZXRlcnMgdXNp
bmcgZXRodG9vbC4gVGhpcyBpcyBqdXN0IGEgTUFDIGRyaXZlciBhbmQgaXRzIGludGVybmFsIA0K
UEhZJ3MgZHJpdmVyIGlzIGFscmVhZHkgbWFpbmxpbmVkIHdoaWNoIGhhcyBQTENBIHNldHRpbmcg
c3VwcG9ydC4gUGxlYXNlIA0KaGF2ZSBhIGxvb2sgaW4gdGhlIGJlbG93IGxpbmsgd2hpY2ggaGFz
IHRoZSBpbXBsZW1lbnRhdGlvbi4NCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
bGF0ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jI0wyODMNCg0KWW91
IGNhbiB1c2UgdGhlIGJlbG93IGV0aHRvb2wgY29tbWFuZCB0byBzZXQgeW91ciBQTENBIHNldHRp
bmdzLg0KDQokIGV0aHRvb2wgLS1zZXQtcGxjYS1jZmcgZXRoMSBlbmFibGUgb24gbm9kZS1pZCAw
IG5vZGUtY250IDggdG8tdG1yIDB4MjAgDQpidXJzdC1jbnQgMHgwIGJ1cnN0LXRtciAweDgwDQo+
IA0KPiBBZGRpbmcgc3VwcG9ydCBmb3IgdGhlIGV0aHRvb2wgcGxjYSBvcHRpb25zIHdvdWxkIG1h
a2UgdGhpcyBtdWNoIG1vcmUNCj4gY29tcGxldGUuDQpIb3BlIHRoZSBhYm92ZSBleHBsYW5hdGlv
biBoZWxwcy4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgbWlzdW5kZXJzdGFuZCANCnlvdXIgY29t
bWVudC4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFJlZ2FyZHMsDQo+IERh
dmlkDQo+IA0KDQo=
