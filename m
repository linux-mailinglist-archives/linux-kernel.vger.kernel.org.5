Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84D7A80DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjITMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjITMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:40:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389B83;
        Wed, 20 Sep 2023 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695213635; x=1726749635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hH/tXfcgFWyY1J6pGeUm+MrA0FJHy2L4mbGlIXpLcj8=;
  b=xYm7GgcIUevm6xCmH5shkr+vllIdyjDcmjejkhz9zL+SC/QxoHti6MRC
   PSrdlplzWHVggUsJ16vzWI/C/T7mZOakOKMpUHfdjXewDtG+TvWiyyPR0
   5j+EdjquXL9Yf0mGzeSKojjNd6WmdrSf9EqrWAgGIXgtNyLP/3y5m4csG
   bEBe7CtfIDaLB61WL2GoFBwDixCWpVHdH0+05Ou1gE6frp3Jhc2j7CB7i
   z81L4s9ZZvL10UjxO0Yy7igbkwKqlhgMof9+erN+Zq8mEScMyZnpacdTv
   6bo61QJU2VWMt9ldtVBQNWz8AuLNW/OwzUS00A0obw3MtGROshqqGdJpZ
   w==;
X-CSE-ConnectionGUID: PpI1jxETQgiDG9gAzPFPCQ==
X-CSE-MsgGUID: O1O5ezL9Rd2nkXUgycpX+w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="236186306"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 05:40:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 05:40:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 05:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj5rbJzOGm5bV0VqgRPGCSV9GGoHBVeVzyZ97GLq5orJX5fnam3gc7Qa8zDrfhFfelNoPj15xoTfTkSwC63KJWB/kYEk64f5elkusZfpj+aWoRGUURaS/STa3pfozim2hUdNFhTBPuGxYmvpSjLYl3Hyq2psKzCSB9mvZv/hiOcldw+b2rAMAAomgGw27pe1C8D/0WoX/jcxLMsnBJHQClxlXjy2SfpAcjomt3qZfrvBiskroU9Ws/LjU5zYN77/v3Mbeb2XKwSrLOY7hwgzJSRnZ6YT7bvV7zBOh7P+tmbtJOtACscBnEqXYIzw/WcdVaiz09pmWn+Ml0TLr26BBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH/tXfcgFWyY1J6pGeUm+MrA0FJHy2L4mbGlIXpLcj8=;
 b=Wy3/svpvHQROeayUo1rCNrkXpmPlixm3p7DwK3Q0C2PKenYoPrUqGFUg9vIIOGct6zqqE/j22x7Zbpm7GBaOWsfbuN0uH2gkQ1heIJ3neNeb89Rmd2grkVP62VEO8uljC7uT9pLdErsIAA+mUZaOoMvfzXQx5Ledm9zwZGr+8mYALr3BfxRWe6yW93AiVOUZyPVm4Fs5vBJRoEL+QeEf1xBecE9uHRuRu6NZBjBS9aWA3xZGp0zfX7L+XOwhvEyKLBvSvvG7nfuqzN1uZ9PG9Ry+YmFp1u4V8igG9fkxBp1a4CmYIn96HQgiS3SXLeWcLxJ7wPztfruVCD1ed0vhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH/tXfcgFWyY1J6pGeUm+MrA0FJHy2L4mbGlIXpLcj8=;
 b=ATrAN2+YeI12RuVRiQAnEjzFE+1A99pdpHL3jwgPzQJ4YDQIuG5sgeCup9oQI6+zphG6X7bwQDcaxjBsK62pCk8GrzMImUXNGnpzJn5rA/DYWJR+vEm78/dkbCvMNHaOw7xOJQa0OHTOmoxWisZy3Esn6MDGy5YGnDoJuziSvtU=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Wed, 20 Sep 2023 12:40:31 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 12:40:31 +0000
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYCnuAgAoMZoCAADwLgIABZ4MA
Date:   Wed, 20 Sep 2023 12:40:31 +0000
Message-ID: <cf23ed3c-d1cb-61fd-a305-e2787ef70cb1@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
 <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
 <deff3e64-a10f-4d07-9651-502442a86987@lunn.ch>
In-Reply-To: <deff3e64-a10f-4d07-9651-502442a86987@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: 34943176-e5bb-4c97-b27c-08dbb9d6c6ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ADfstVWuH+FquQxirliFkS8EHExz3qH5+9OEhmc1TSCKRbUen3aPY9ivV4JQlLfQzLgzXRZuLYcvLK0TRCcFrNfk6bt+K26nfDD5TkzfuAq4ujRDVwIWSokxOZ6AhyhgtPySHg5Jb/0PvwYqwqAKCH1w5Fvbzg1HztXn7ud/olKq2IJz4cKd7b5q56XJGRI7CgTFpyWzOoqLevrm9DiAFN+5LayiyDYCzN0/6PSTf18lhEW/pnQAEf/8rwEoVFhWAkj36l0c0k5jTl5kejLd4d/yF4+pbG6052AoR8yDHYpm7L+gC0CeTLtxgf0e/GuybZpvd5cNO3QrYWUQxWI0SSDE/r5MufXF6cXa+eHwxA7a1ty1CcVx7hThC78SJzsnN2lE0Jn7e7uafoD/t/XDUTzLZQTyItZ6vRR2DDczIgwkEpxQ/l36cBASa7vzJnxXREt8MfPiEltdW+XHLWleTL0tJKPSLrtpkxjSngh2Mg38edejNyXc+G9BCCjHP45jYsc7TuHzSVaWR+AeCZwcjvhRZDY9Aw/rIrmTPj4PA3OXm5YQgBvqSfKkwYQRgj+RjvqLctQbSt5kCSGE3kEs0JaQGSbokUkjwfhgq+aiMBkLmyJ5KSckL8t5UCXqmgRC79uqUAD6xRHQgtz05ePMM6D+KMjgKWMbgtUnajoy/pzJ0tJHLDwORXlQ8VilSGZh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(31696002)(5660300002)(41300700001)(2616005)(26005)(2906002)(7416002)(122000001)(38070700005)(38100700002)(86362001)(36756003)(4326008)(8676002)(8936002)(83380400001)(478600001)(53546011)(6506007)(6486002)(6512007)(6916009)(316002)(31686004)(71200400001)(76116006)(66446008)(66556008)(64756008)(91956017)(66476007)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGwxR0l2ajFBbHcxTGkxSnFBbndSdUt5VGhFYnJUQnN3cDlxR0hTNEc1Nm95?=
 =?utf-8?B?aTFlNFF2S1pIdmZaOHJFbnhwVkladmZaZGlSN2NYYlVrSEpDL1V5b3A4RE9R?=
 =?utf-8?B?NS9MYU1Dczk4bjhLNmwyZG8vUlZ4TkRSOHdhd0M4WUYvcG9tZmJGS3FrVm1X?=
 =?utf-8?B?UHJscTNTWDZwTXlBSmRYOG12RkFBVkF2QzFHTXFXeWtvTHpjU1YvUldKc0dj?=
 =?utf-8?B?NHRIQ20wN0hIQWVldFNyMDIyVjR5aUtzMWx3cnRkcmVZS2hEZGxIejViYmNr?=
 =?utf-8?B?SS9YZ0thUVN4eHR1VWMrNTRxcGw1UkNtWk9vVjJBN3VVS0E4TUFIVnFYaldW?=
 =?utf-8?B?T0VtME95eU9wMUo5L0tQSDdDTTEzWEFBR3AvMEpVQWhsbFFmejlaN3R4U1k3?=
 =?utf-8?B?bExSbEZVQm9raGlPcHNvblV0aFNyRElONE4rVndZYjlZOW1iNkw0SXBydmo5?=
 =?utf-8?B?c1UrRDZUNEp4aVpJSy9nRm41cENzQkViK0tiWGhHenA1Z2VXQWVBVHFuWHRT?=
 =?utf-8?B?U3BqRW5nUFhkbS9SbWNITmJvOGZCVUJJeUwxYkRkWTRySDVVcmlyb1duTXVV?=
 =?utf-8?B?dm42TjRxYkxnRmFoK08yWlVNYS9UUkY5S2kzOVdTa1dORkozbG56Mk5OcjJu?=
 =?utf-8?B?VE1vSzJrMFBjLzdEcUczQ2tnQ2RiV1g4Nm9uWHdEWDRpMzNWUmtMVXZiRjVZ?=
 =?utf-8?B?VGdZTmZLMjVMdTY1SEk2VjNlcDBGZFdNUnpIRjF1aWxzRkNyZzhFRXlsb1RS?=
 =?utf-8?B?NlljRlFjU1Y2M1NYVElTY3p3SklHbmhoWndKN0U3T1dZbERrUTY3eVBGQzJq?=
 =?utf-8?B?UkxrS0ZmYTM0ejFmZUZ6VC9jcDQrZ1g2Y3N3aElXTVpLOWM2dHNmK1lqc2tK?=
 =?utf-8?B?R2FLTTk0RHM1ZWJvRFNOZVVqNi8xL25YU1V0cUtXbVRBMXpMVHNwYS91Vk5H?=
 =?utf-8?B?b1p1eTN4WHErTFFPcytmK3V6S2lkSjdhazd5TDVzRzNacXpUYVVPZjd4SVBP?=
 =?utf-8?B?dHNaVFBBQ3I1NGpYQVBQNTJsem5QSDRubk51bnNMTFpydFJXcHd3MWNaZUxn?=
 =?utf-8?B?cDhXbjJjWUhLRVlRcDhEdEtkU1RlKzFVcjNDcGlHb2Z2b0xWSmFwZVFVM0Fp?=
 =?utf-8?B?aCtTUVhLUVUwK3FhQ2o0OVYreUdzWFRjNCtPcnVYc1BsbVg1aGNlM2lrZWVK?=
 =?utf-8?B?UHB5Y2IrYTFyczVaWDIrc0dUd01TWkRzODVUclZEbnlybmpYd1hNcndLaG9r?=
 =?utf-8?B?RHkyWitXNVJFcE0waGhDWU50VXJLYnhrZGtyMW5FWUZCa0JtU0pqdEg4bEdj?=
 =?utf-8?B?WTNxMnBqVEJQalRacVlVd3JtNVZodEJpU0tDdzU0S0VPYk9sNG0wZUptZzF5?=
 =?utf-8?B?b0U1VXVXQXdoWFhLaHdvaE4xU09XaEgrRlg5dnp3cTBsZmRkMmVzdjZxUjYx?=
 =?utf-8?B?YnVlSk8xaUVBWjRDdHZ5RHBOWjBEOHBIVGVyQTAwK21MSXFJR0NQczJuL0pm?=
 =?utf-8?B?dlNRYkNJcFh5YWg1QnhFQ3BWSG91L2hGQTVYVlkzME1tMjNzSTl6ZzRGSDF3?=
 =?utf-8?B?RUxaNjVmZ1ZYdWw3MDR1TE9RSU9oQStHdVN6T0oxWUhOajNBdHdUdEVSL2Jn?=
 =?utf-8?B?d1daM2FEbVh4OEtuWDRnVlIxVEdSR3MrUHNpc1RLK2RHbmJRNEpFUVpTOFQv?=
 =?utf-8?B?L2RpNFJ1bWVCVlZkdWdOZ0hmU1grRHFhR1pIUndyUVd1eGdWUmJEMjZxNHlW?=
 =?utf-8?B?WjRoTkV4anowVlpqR0pFUUZFWmJad1pVRGlKOXdOd3lRVHFPL3puazN3Q2pS?=
 =?utf-8?B?enpqamdFWW9WbFVQTUtBWkI2dFV5Mjg0dzRESjA1enhtYXh4ZjEwcDMwa1FX?=
 =?utf-8?B?T2dDcW1VbURpQ05iblppdjlrdVdEazYvaDczSFVmMzVTUzU3UWp3Mlo3MC9D?=
 =?utf-8?B?QXVLdXB6YXpEQmJxREhaaTB6WXg2UXpxRmFWazQwbDFwK29ad2tjdnhGalZW?=
 =?utf-8?B?Tkxyc0tIdGRBNm5acUpLN2g1RFRVVnE1cncwWlJHbnlMRGhXekc5S1JZbVZK?=
 =?utf-8?B?dW9KSVptRThuOCtZd2lESXFrbFduNlRZcU1SUUg4anJKUVpoMDFKallianUv?=
 =?utf-8?B?UnRqSFBvcU40MjIwemtoZ3hGSEgrdE5KTXFONGtDSlFoK2d4dk5LdXUyUVdm?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F446AE423F01954DB7CC24AE8072A484@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34943176-e5bb-4c97-b27c-08dbb9d6c6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:40:31.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbCfgES5ERbY3HPQSxnC3qPCbqP2mVquR+LZRVMB9LbCVYepQcM+OkWUoWb+qylnBgHkoBEBpLKfEYz7oYyqW+Lu+knDTY6mun7YfM4eXSlAiT6jWgdMnRW9st8InGZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxOS8wOS8yMyA4OjQzIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiArc3RhdGljIHZvaWQg
b2FfdGM2X3ByZXBhcmVfY3RybF9idWYoc3RydWN0IG9hX3RjNiAqdGM2LCB1MzIgYWRkciwgdTMy
IHZhbFtdLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggbGVuLCBi
b29sIHduciwgdTggKmJ1ZiwgYm9vbCBjdHJsX3Byb3QpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgIHUz
MiBoZHI7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgLyogUHJlcGFyZSB0aGUgY29udHJvbCBoZWFkZXIg
d2l0aCB0aGUgcmVxdWlyZWQgZGV0YWlscyAqLw0KPj4+PiArICAgICBoZHIgPSBGSUVMRF9QUkVQ
KENUUkxfSERSX0ROQywgMCkgfA0KPj4+PiArICAgICAgICAgICBGSUVMRF9QUkVQKENUUkxfSERS
X1dOUiwgd25yKSB8DQo+Pj4+ICsgICAgICAgICAgIEZJRUxEX1BSRVAoQ1RSTF9IRFJfQUlELCAw
KSB8DQo+Pj4+ICsgICAgICAgICAgIEZJRUxEX1BSRVAoQ1RSTF9IRFJfTU1TLCBhZGRyID4+IDE2
KSB8DQo+Pj4+ICsgICAgICAgICAgIEZJRUxEX1BSRVAoQ1RSTF9IRFJfQUREUiwgYWRkcikgfA0K
Pj4+PiArICAgICAgICAgICBGSUVMRF9QUkVQKENUUkxfSERSX0xFTiwgbGVuIC0gMSk7DQo+Pj4+
ICsgICAgIGhkciB8PSBGSUVMRF9QUkVQKENUUkxfSERSX1AsIG9hX3RjNl9nZXRfcGFyaXR5KGhk
cikpOw0KPj4+PiArICAgICAqKHUzMiAqKWJ1ZiA9IGNwdV90b19iZTMyKGhkcik7DQo+Pj4+ICsN
Cj4+Pj4gKyAgICAgaWYgKHducikgew0KPj4+DQo+Pj4gV2hhdCBkb2VzIHduciBtZWFuPyBNYXli
ZSBnaXZlIGl0IGEgbW9yZSBtZWFuaW5nZnVsIG5hbWUsIHVubGVzcyBpdCBpcw0KPj4+IGFjdHVh
bGx5IHNvbWV0aGluZyBpbiB0aGUgc3RhbmRhcmQuIEtlcm5lbGRvYyB3b3VsZCBhbHNvIGhlbHAu
DQo+PiBBaCwgaXQgaXMgIndyaXRlIG5vdCByZWFkIi4gU2hhbGwgSSBuYW1lIGl0IGFzICJ3cml0
ZV9ub3RfcmVhZCIgPw0KPiANCj4gWW91IG1pZ2h0IHdhbnQgdG8gZGVzY3JpYmUgdGhlIGhpZ2gg
bGV2ZWwgY29uY2VwdCBhcyB3ZWxsIGluIHRoaXMNCj4gZmlsZS4gV2hhdCBpIF90aGlua18gdGhp
cyBpcyBhYm91dCBpcyB0aGF0IFNQSSBpcyBzb3J0IG9mIGEgZnVsbA0KPiBkdXBsZXggYnVzLiBX
aGlsZSB5b3UgYXJlIHNlbmRpbmcgZGF0YSB0byB0aGUgU1BJIGRldmljZSwgdGhlIGRldmljZQ0K
PiBjb3VsZCBhbHNvIGJlIHNlbmRpbmcgYSBkYXRhIHRvIHRoZSBDUFU/IEFuZCAnd3JpdGUgbm90
IHJlYWQnIGhlcmUNCj4gbWVhbnMgaWdub3JlIHdoYXQgd2UgcmVjZWl2ZSBmcm9tIHRoZSBkZXZp
Y2U/DQpBaCBvaywgSSB0aGluayB0aGVyZSBpcyBhIG1pc3VuZGVyc3RhbmRpbmcgaGVyZS4gVGhp
cyBpcyByZWxhdGVkIHRvIE9QRU4gDQpBbGxpYW5jZSBwcm90b2NvbC4gQ29udHJvbCB0cmFuc2Fj
dGlvbnMgY29uc2lzdCBvZiBvbmUgb3IgbW9yZSBjb250cm9sIA0KY29tbWFuZHMuIENvbnRyb2wg
Y29tbWFuZHMgYXJlIHVzZWQgYnkgdGhlIFNQSSBob3N0IHRvIHJlYWQgYW5kIHdyaXRlIA0KcmVn
aXN0ZXJzIHdpdGhpbiB0aGUgTUFDLVBIWS4gRWFjaCBjb250cm9sIGNvbW1hbmRzIGFyZSBjb21w
b3NlZCBvZiBhIA0KMzItYml0IGNvbnRyb2wgY29tbWFuZCBoZWFkZXIgZm9sbG93ZWQgYnkgcmVn
aXN0ZXIgZGF0YS4gV05SICh3cml0ZSBub3QgDQpyZWFkKSBiaXQgaW4gdGhlIGNvbnRyb2wgY29t
bWFuZCBoZWFkZXIgaW5kaWNhdGVzIGlmIGRhdGEgaXMgdG8gYmUgDQp3cml0dGVuIHRvIHJlZ2lz
dGVycyAod2hlbiBzZXQpIG9yIHJlYWQgZnJvbSByZWdpc3RlcnMgKHdoZW4gY2xlYXIpLiBzbyAN
CmJhc2ljYWxseSBpdCBpbmRpY2F0ZXMgdGhlIHR5cGUgb2YgdGhlIGNvbnRyb2wgY29tbWFuZCBv
biB0aGUgcmVnaXN0ZXJzLg0KPiANCj4+IE9rLCBhcyBwZXIgT0Egc3BlYywgdXAgdG8gMTI4IGNv
bnNlY3V0aXZlIHJlZ2lzdGVycyByZWFkIG9yIHdyaXRlIGNhbiBiZQ0KPj4gcG9zc2libGUuIFNv
IHRoZSBtYXhpbXVtIHBvc3NpYmxlIHNpemUgd291bGQgYmUgMTAzMi4gQXMgeW91IHN1Z2dlc3Rl
ZA0KPj4gd2lsbCBhbGxvY2F0ZSB0aGlzIHNpemUgb2YgbWVtb3J5IGluIHRoZSBzdGFydHVwLg0K
PiANCj4gWWVzLCAxMDMyIGJ5dGVzIGl0IG5vdCBodWdlLCBzbyBhbGxvY2F0ZSBpdCBvbmNlIGFu
ZCBrZWVwIGl0IGZvciB0aGUNCj4gbGlmZXRpbWUgb2YgdGhlIGRldmljZS4NClN1cmUsIHdpbGwg
ZG8gdGhhdC4NCj4gDQo+Pj4+ICt2b2lkIG9hX3RjNl9kZWluaXQoc3RydWN0IG9hX3RjNiAqdGM2
KQ0KPj4+PiArew0KPj4+PiArICAgICBrZnJlZSh0YzYpOw0KPj4+PiArfQ0KPj4+PiArRVhQT1JU
X1NZTUJPTF9HUEwob2FfdGM2X2RlaW5pdCk7DQo+Pj4NCj4+PiBNYXliZSBjb25zaWRlciBhIGRl
dm1fIEFQSSB0byBtYWtlIHRoZSBNQUMgZHJpdmVyIHNpbXBsZXIuDQo+PiBTb3JyeSBJIGRvbid0
IGdldCB5b3VyIHBvaW50LiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gYml0IG1vcmU/DQo+IA0K
PiBBdCBsZWFzdCBhdCB0aGlzIHN0YWdlIGluIHRoZSBwYXRjaCBzZXJpZXMsIGFsbCB5b3UgYXJl
IGRvaW5nIGlzDQo+IGFsbG9jYXRpbmcgbWVtb3J5LiBZb3UgYWRkIG1vcmUgY29kZSBsYXRlciwg
d2hpY2ggbWlnaHQgaW52YWxpZGF0ZSBteQ0KPiBwb2ludC4gQnV0IGlmIGFsbCB5b3UgYXJlIGRv
aW5nIGlzIGFsbG9jYXRpbmcgbWVtb3J5LCB5b3UgY291bGQgdXNlDQo+IGRldm1fa21hbGxvYygp
LiBUaGUgZHJpdmVyIGNvcmUgd2lsbCB0aGVuIHRha2UgY2FyZSBvZiByZWxlYXNpbmcgdGhlDQo+
IG1lbW9yeSB3aGVuIHRoZSBkcml2ZXIgaXMgdW5sb2FkZWQsIG9yIHByb2JlIGZhaWxzLiBUaGF0
IG1ha2VzIGNsZWFudXANCj4gc2ltcGxlciBhbmQgbWVtb3J5IGxlYWtzIGxlc3MgbGlrZWx5LiBU
aGVyZSBhcmUgYSBsb3Qgb2YgZGV2bV8NCj4gaGVscGVycywgc2VlIGlmIHlvdSBjYW4gdXNlIHRo
ZW0uDQpTdXJlLCBub3RlZC4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAg
ICAgICAgIEFuZHJldw0KPiANCg0K
