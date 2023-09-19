Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF597A606A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjISK6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjISK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:58:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A018A;
        Tue, 19 Sep 2023 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695121074; x=1726657074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rac0/x0V9rLJ7AJXSbXYu5h9JoWyVY8ntZh8utSGbgQ=;
  b=whn8eunjt7u8lnQPfXSRVGYIaSuH3qQhLlFeq/Jnadj0n5dXDOeeCNBv
   plZYFzXTmmIRXqZYXw2VEfmaMSJXjD6yPais9wPviO4+k8o2nzmjeKqHH
   9B1YKb4CovgPlZbuitLnGC6AMFxCX4iSJv5ymjnqDc6pC1F573w4VxMci
   35NAqBwd/T214z1cji/OUOlyb9qxGpeTFvjXQXXkOtVZFHxAEucqCWess
   E7JCY9jc+56+TUJ4LMYbjnVQMZE5aVirWgJC+FvlfCYl523L8mJvucMjt
   AZQrvivrTG1ByM+35JKQ5FQUuofe5pRbEnrqD0Bm5BVw6JI3UmsG2VBXA
   w==;
X-CSE-ConnectionGUID: B4HwSoMRTbqKHwIwXyXLIQ==
X-CSE-MsgGUID: 8ppNgDEBQgC/OGCZZc/4NQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5415644"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 03:57:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 03:57:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 19 Sep 2023 03:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbUes/FQuXbkSVlnqZpY3dEwRQ45ZRQc4NUaOGbERLcD68KSpWpXkEBGXjvu+kewnnaAbuPxR5fce1lMOAbTp9rF1r55vbfQ7anGbuWF9ud6x999IvsZZGL4XwlKuQsBBOkUj458VN09VNIxEPPKhKw5Tckxu0mOEo0fFy9pHLppCQlCskuOEyRvNK+zHxMz96CGtTiFg0Jf1oVWhm8qtNEW7u9Y1CVC7TNv7lrDE8ofGuMYOE/TGljyYqVXJd6cnpg37e++qu9j1scFLrpg0tmUur8y/fwFc0gUUl3ZD+fALymkM5y0UMn0CH4U7zH6CYqg/0xx4AgMrdQKG/4S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rac0/x0V9rLJ7AJXSbXYu5h9JoWyVY8ntZh8utSGbgQ=;
 b=LNgoWwZnss17R3CGCdzdQfSqxCyjqLLVeuvd2vShrQAA9yybiBHrWYBYwO8Z+axS5/k5vFhWvB5anWr/zhYDC5nYZR87u4mFO2YmqzfjMgLApfqgFu1HymfzbwIk3+4rAAaumGt+ylcGZ4vScgnb7BNlPI3h5vsgXhntnMnru842fbgWtfXV5lD52kxMyA4vy5b5o0h7MOwlqxdAKQN+9rgsHVNdrz3Rlo/ILOQVa2HmDajDeHLH4DzxbEMtQKp66h2n9ybEX51AZ/PRUgRQ2DaO5s4zRQ/4MnhzPJIMwMBOn1WELG8pLnWGazbGZ7W1/g/InfXUiZVzIXpmTLvELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rac0/x0V9rLJ7AJXSbXYu5h9JoWyVY8ntZh8utSGbgQ=;
 b=JIxhLPUWO8YLiKirf8NKeLUKXtVClYk9gmMVy3NkyZAeQfhGT+v4UhnYoLBrmG+pYoD90pvmB4hwbwglSu0+5GThhym4CZIOdKQSPJOFtLpsLuMdU0YhmJHsCW+StDo2FXxIlDqksg+Bv6HfyfrV7XgKpgXNrOgEPb3LPnICI5U=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 CY8PR11MB7362.namprd11.prod.outlook.com (2603:10b6:930:85::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 19 Sep 2023 10:57:45 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:57:45 +0000
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
Subject: Re: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6
 configuration function
Thread-Topic: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6
 configuration function
Thread-Index: AQHZ4mExxuf2GMqaD0C1P60taFPT07AZhOqAgAiGjwA=
Date:   Tue, 19 Sep 2023 10:57:45 +0000
Message-ID: <46fab729-4c5a-1a6e-37d0-fea62c0717f7@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
 <dd0a6cd5-91e5-4e13-8025-d6c88bdab5a2@lunn.ch>
In-Reply-To: <dd0a6cd5-91e5-4e13-8025-d6c88bdab5a2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|CY8PR11MB7362:EE_
x-ms-office365-filtering-correlation-id: aa1cf5f3-35b2-463c-8a0e-08dbb8ff410c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZAoppKECCQa4EK6D9lKX5Dl0FY3Jb9HazbNLac8grVtXBi6M68sW3pd8qptXxtDFvUUqHAPdr++nFBcjj+t4UpUlZI/FaTzwNI1uvaVQjUGzGQT2ujdQIktYQFHS0Qz2+Dhqcxmy/y/YMD5jPyXx5cO5IVbCn9ZEOhxnHMLXuPGf5MwfWBWRqKABqOtckicEasmdM+Fmspbf563/XJwjUOmkG8eVR1envJxkYnEPpj9/AGN0GIE0S9B5PjhKWbLcHOsUPcuL8Ly3dzOgvlFjiY/KvJRVc8O4mMkfJDEM277hrC/k55lsfBee0NkOmDFRY/pRHOuoaU/Bf+BJT+fJFxEtWO+S2zTsJUdWyGs/Ki7zDgLzp9u05oomKhgzmRqTDdTezFJoR7YSxtEw/GJyQjwCoVt9pZqQnZMEcqvKm5zbjw2lAFUVzZdtJNERk+2q9q8ZJEXf2AsbbhXSzcs5CeOTifgdMKSEGNIgRLjNlzifNFf7x5CZ4AfrXVQglI13cU/2yMTQjZJ0lQkxyADl2bbFIjmqrjIqsOVawqtwCCwnf5foHlD2z57AJ6cQJx49NkM7KaOmatf1k52KlOo8pQUMpwTIPIAOoHesZvbC8iEkRod6QUp8brvyTa2eNcyTKSmwBhlPRji1JoIpIgGSNMvC0LNyBrppTxZlFvCGlXI+oW1xN5gk0ZaFpECOKuY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(31686004)(6506007)(6486002)(53546011)(36756003)(38070700005)(38100700002)(122000001)(86362001)(31696002)(2616005)(107886003)(26005)(2906002)(6512007)(71200400001)(478600001)(83380400001)(8676002)(5660300002)(91956017)(4326008)(41300700001)(8936002)(7416002)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(66556008)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJacGxNZU1WcGw0U3N6RzQyRkNZMXNORHhmNEhDdnJyVC95anJRcFN0QTYx?=
 =?utf-8?B?TG1SbDI3cE1YajFKbzZucE5pM1pvd0tPWDdPRHJvb0pIckRLK1pLalQ5OFR2?=
 =?utf-8?B?QVpHVWlObTlHNzFUR3lTSGJtZGExck15REZVSCtFVmdUQnIxWWRNWXUyR1p5?=
 =?utf-8?B?eFFsb0dhQzdaVXdROUp2QkxCK3ZMVGR5U3Q3V1ZBcjA4cjRjWGxnLzhCK3l2?=
 =?utf-8?B?ZnY3QWxmb09tY0ZsU3FJZjVzR2o1NDlVNzNUOXlxTjdrN2dxV3VCWjg1N1lt?=
 =?utf-8?B?TGJNd0FwckIrTG91dGd3Vk11ZURHaGMzbVEwWDBjNnNXczFGZXpkWEE0MzZv?=
 =?utf-8?B?czFCbWR4WVJRa2RIdGtEZll6T29saENzYzlrbnVBNExrU2xJRWR0V0FZUGxk?=
 =?utf-8?B?elBXT1FOOFNaN3poTjhDVkFWeEs3Mk1YNjlhZ0NKVUI5dDZnK2NXOUFWWDVl?=
 =?utf-8?B?NTZiTlZ3ajdiTXZELzF2cW9GZ0l2bEg4a1QxVVhJV1V1VTY0TFk5eG5RamlL?=
 =?utf-8?B?S2RGdWhUZlp3b0JpRmhiUEhHUTBVNGVxMUZIMXJOTE1sZlppSHVXUjVpYUor?=
 =?utf-8?B?bWxUbWpaQW1mS2x2eWppNEdYMG1QMzJRMlBESUNVN1B1ZXMrY2hNWENEbFpm?=
 =?utf-8?B?MHFLRUJMR0hxazVselA5U1haNm5VUDN2bVhEZzdReXNJMmRCWlR3VlF1eFlT?=
 =?utf-8?B?bUZobExkQTNuL0V0WWQ2eUcyOGtIZGNsQlQyMjR1WE1UL21yV0xBcXhuTC82?=
 =?utf-8?B?RzZBVjRZMFkwZnFxV0ZhU3pmUVJIcHdMYWJ6N0I3bzVWRFdOd0IwQWxETCt1?=
 =?utf-8?B?SzVFVXpSb0lNZzBRcFpwQk4zcFdtT1dZOXRQV2RQMStMQWlMUFNFZTFnUVlG?=
 =?utf-8?B?alF2UTZOdHViUjlQZ0M5ZHc1cHUwempydnJ4QnUxZHNERU9EMVVEbTRod3dr?=
 =?utf-8?B?QjIwUzJnWVJ6MlNZb29xUWt5YXlYVDdRemNtZ2V5dlYzaXRsZi81UldHWkl6?=
 =?utf-8?B?Y1k4T3N4am5OdG1teXI1WmpVWURaOE1sb0VQQjdlYzVMZXp0eW02dUhNdy8x?=
 =?utf-8?B?Wi9hdUZIaWRzZm1NRnJ3dWpJclozSEVWbnhxQzFETUJabmRick02b2ZXazhp?=
 =?utf-8?B?ekl2YkRxNmxiMDltZHUwdHVDKzlGMmt5ZGNkTXczNi9OdVZZTlFYZE9uRkg0?=
 =?utf-8?B?YWVMaVVKMVl2bTRpZllrazFkQTR4YmtuR09FTE1UTkdpUExyTWIxSjBNcHVk?=
 =?utf-8?B?RHR3Q2JzYVMxWmZvQzYyUTAvQU9PMThqbGx5cGFJK3JHUTdnaUVBbUFmSHdp?=
 =?utf-8?B?L0h5d05kekEvZDFpZGhobDJDOWpwNDArMTV5cGo0UXEvMmpKcFpIYU13QTRX?=
 =?utf-8?B?WHZtZkg1Q29uL2E1QVpzN2dEZzNZRmRRTnFFU0tURjgrK1lTWkM3d2JaRlVi?=
 =?utf-8?B?blU5Z0szSE1XWTJnRkQrdEtCM3R2ZzVlWVh4Qm5jWkN3V1ZmMDRoOHFpUGFv?=
 =?utf-8?B?UDB2MyttTjQ0dlczS3Z2ZmR1WEZBNVo5SVlidWJ3UzFUVmZwbkp1Z1dvQnh1?=
 =?utf-8?B?V0NOb2YwK1ZzdWZHUVNXakxNa05YZ21yUG9mTmE5R1hTMFpPYTVUS0NKSXhO?=
 =?utf-8?B?b0VsdklwRFQwNlZuTkIvUlZsVnNyeDByczM4dmFZS2ZGUFdGRXhaWFJQUldD?=
 =?utf-8?B?allvcU1NUWdNODdtdW1BZ0hhenI3SDVXamRtK1BSWjFPK2liT000U1g4RDl4?=
 =?utf-8?B?d1h2UG9IdktMVXU0T21nTWtlbEVPUGxEUTJBQmVscWNsYjR0WkhwbTdwWXpX?=
 =?utf-8?B?KytxQUJBTTc0dkswamVQSCtIVGl1blMza1JxQlhETXFSUWswN0g4ZldFV0pY?=
 =?utf-8?B?R3FUK0VKaW9GZVRuMTczeHNTV0VER1AreU5IT3lGMTduY014VG5USHhKdWNx?=
 =?utf-8?B?VzFHQVVFK0hhQWh3cFFOdUNCVWpHMDRBYjBBeTJuVGVTaTdZbmZjZFJHVzFZ?=
 =?utf-8?B?OC81R2NvTnpLWUk2VCtVVWhmRktMN216OVAvWjVLcjRhYWNlVzdnV3dha25k?=
 =?utf-8?B?czZzTk1MTnNRQnlxdFNtWUltWUM4aEV5NzZmTFUvb2pWcWViakw2SEI5TWNa?=
 =?utf-8?B?aXRMVlRXRkI5RVV1dHRMeGJpSWg3ZFZPRUJhQ3hNVHpvd2tQYlZFL2Z1bnlZ?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD7592B8AED5A74695F60D9D0E6F9D4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1cf5f3-35b2-463c-8a0e-08dbb8ff410c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 10:57:45.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5IdHktWu2jPu7zV6zZ2bbF3CWhsK1hdChUxcNj0pY9EGao4VgZuLNjSLulNx0doZRbTcNJg9cdOvae6PXtk9R9isaBOV2q7hBZ0x9j2T5NzqMsW0WzdjnDWTGPiCXPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7362
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxNC8wOS8yMyA2OjE2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK2ludCBvYV90YzZfY29u
ZmlndXJlKHN0cnVjdCBvYV90YzYgKnRjNiwgdTggY3BzLCBib29sIGN0cmxfcHJvdCwgYm9vbCB0
eF9jdXRfdGhyLA0KPj4gKyAgICAgICAgICAgICAgICAgIGJvb2wgcnhfY3V0X3RocikNCj4+ICt7
DQo+PiArICAgICB1MzIgcmVndmFsOw0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAg
IC8qIFJlYWQgYW5kIGNvbmZpZ3VyZSB0aGUgSU1BU0swIHJlZ2lzdGVyIGZvciB1bm1hc2tpbmcg
dGhlIGludGVycnVwdHMgKi8NCj4+ICsgICAgIHJldCA9IG9hX3RjNl9yZWFkX3JlZ2lzdGVyKHRj
NiwgT0FfVEM2X0lNQVNLMCwgJnJlZ3ZhbCwgMSk7DQo+PiArICAgICBpZiAocmV0KQ0KPj4gKyAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgcmVndmFsICY9IFRYUEVNICYg
VFhCT0VNICYgVFhCVUVNICYgUlhCT0VNICYgTE9GRU0gJiBIRFJFTTsNCj4+ICsgICAgIHJldCA9
IG9hX3RjNl93cml0ZV9yZWdpc3Rlcih0YzYsIE9BX1RDNl9JTUFTSzAsICZyZWd2YWwsIDEpOw0K
PiANCj4gSXQgaXMgbm90IHNvIG9idmlvdXMgd2hhdCB0aGlzIDEgbWVhbnMuIE1heWJlIGNoYW5n
ZSB0byByZWd2YWxbMV0sIGFuZA0KPiB1c2VyIEFSUkFZX1NJWkUoKS4gV2hhdCBhbHNvIGRvZXMg
bm90IGhlbHAgaXMgdGhlIGZ1bmN0aW9uIG5hbWUsDQo+IG9hX3RjNl93cml0ZV9yZWdpc3Rlcigp
LiBTaW5ndWxhci4gU28gaXQgYXBwZWFycyB0byB3cml0ZSBvbmUgcmVnaXN0ZXIsDQo+IG5vdCBt
dWx0aXBsZSByZWdpc3RlcnMuIEl0IG1pZ2h0IGV2ZW4gbWFrZSBzZW5zZSB0byBtYWtlDQo+IG9h
X3RjNl93cml0ZV9yZWdpc3RlcigpIHRydWx5IGFjY2VzcyBhIHNpbmdsZSByZWdpc3RlciwgYW5k
IGFkZA0KPiBvYV90YzZfd3JpdGVfcmVnaXN0ZXJzKCkgZm9yIG11bHRpcGxlIHJlZ2lzdGVycy4N
Ck9rLCBJIHdpbGwgaW1wbGVtZW50IHR3byBmdW5jdGlvbnMgdG8gc2VydmUgdGhlaXIgcHVycG9z
ZXMuDQo+IA0KPj4gKy8qIFVubWFza2luZyBpbnRlcnJ1cHQgZmllbGRzIGluIElNQVNLMCAqLw0K
Pj4gKyNkZWZpbmUgSERSRU0gICAgICAgICAgICAgICAgfkJJVCg1KSAgICAgICAgIC8qIEhlYWRl
ciBFcnJvciBNYXNrICovDQo+PiArI2RlZmluZSBMT0ZFTSAgICAgICAgICAgICAgICB+QklUKDQp
ICAgICAgICAgLyogTG9zcyBvZiBGcmFtaW5nIEVycm9yIE1hc2sgKi8NCj4+ICsjZGVmaW5lIFJY
Qk9FTSAgICAgICAgICAgICAgIH5CSVQoMykgICAgICAgICAvKiBSeCBCdWZmZXIgT3ZlcmZsb3cg
RXJyb3IgTWFzayAqLw0KPj4gKyNkZWZpbmUgVFhCVUVNICAgICAgICAgICAgICAgfkJJVCgyKSAg
ICAgICAgIC8qIFR4IEJ1ZmZlciBVbmRlcmZsb3cgRXJyb3IgTWFzayAqLw0KPj4gKyNkZWZpbmUg
VFhCT0VNICAgICAgICAgICAgICAgfkJJVCgxKSAgICAgICAgIC8qIFR4IEJ1ZmZlciBPdmVyZmxv
dyBFcnJvciBNYXNrICovDQo+PiArI2RlZmluZSBUWFBFTSAgICAgICAgICAgICAgICB+QklUKDAp
ICAgICAgICAgLyogVHggUHJvdG9jb2wgRXJyb3IgTWFzayAqLw0KPiANCj4gVXNpbmcgfkJJVChY
KSBpcyB2ZXJ5IHVzdWFsLiBJIHdvdWxkIG5vdCBkbyB0aGlzLCBQcmluY2lwbGUgb2YgTGVhc3QN
Cj4gU3VycHJpc2UuDQpTb3JyeSwgSSBkb24ndCBnZXQgeW91ciBwb2ludC4gQ291bGQgeW91IHBs
ZWFzZSBleHBsYWluIGJpdCBtb3JlPw0KPiANCj4+ICAgc3RydWN0IG9hX3RjNiB7DQo+PiAtICAg
ICBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpOw0KPj4gLSAgICAgYm9vbCBjdHJsX3Byb3Q7DQo+PiAr
ICAgICBzdHJ1Y3QgY29tcGxldGlvbiByc3RfY29tcGxldGU7DQo+PiAgICAgICAgc3RydWN0IHRh
c2tfc3RydWN0ICp0YzZfdGFzazsNCj4+ICAgICAgICB3YWl0X3F1ZXVlX2hlYWRfdCB0YzZfd3E7
DQo+PiArICAgICBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpOw0KPj4gKyAgICAgYm9vbCB0eF9jdXRf
dGhyOw0KPj4gKyAgICAgYm9vbCByeF9jdXRfdGhyOw0KPj4gKyAgICAgYm9vbCBjdHJsX3Byb3Q7
DQo+PiAgICAgICAgYm9vbCBpbnRfZmxhZzsNCj4+IC0gICAgIHN0cnVjdCBjb21wbGV0aW9uIHJz
dF9jb21wbGV0ZTsNCj4+ICsgICAgIHU4IGNwczsNCj4+ICAgfTsNCj4gDQo+IFBsZWFzZSB0cnkg
bm90IHRvIG1vdmUgc3R1ZmYgYXJvdW5kLiBJdCBtYWtlcyB0aGUgZGlmZiBiaWdnZXIgdGhhbiBp
dA0KPiBzaG91bGQgYmUuDQpBaCBvaywgd2lsbCB0YWtlIGNhcmUgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KPiANCj4gICAgICAgICBBbmRyZXcN
Cj4gDQoNCg==
