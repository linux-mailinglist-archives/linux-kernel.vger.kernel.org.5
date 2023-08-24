Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D6786CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjHXKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjHXKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:33:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940A1991;
        Thu, 24 Aug 2023 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692873222; x=1724409222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F0mPRKrfx1xet7mxkFUSxd8OAOESWAdpZoP2lPYKovQ=;
  b=u3c3d81wCPN0mzhyLd7aBuwnU/w194TQUNI8Y8WYI8+pRU1aIgNqhvsv
   /qnKQDh2wLK31uiw2ZGA/fPB++xNUFzssQeJF2fwoPc+srH+gllz7GE/1
   ovBjBnx9ETjncu5IJOdkWlLy9iIaZBLL3gxAv+uhGYYKJz2R7OGaZvtnc
   Xom+mfl4bblLFjOrgpP4Kvlg19qo4RPOqZ6drAikOGknU/yK1JRZMvC0c
   rQOkjdbO1TDevVDeWsFsuoGWfMIbgV6XbrU20NiF3DfXBYv2CDqSEAxZc
   7sp5Y+vpYKMCuMxIZkvsriksTwXyIMaFjP5WJpVUChau5oyD9NK2C2jTM
   A==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="168074666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2023 03:33:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 24 Aug 2023 03:33:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 24 Aug 2023 03:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK1CTdUenKb1ZUuHnpEcpSMXCVXPNiJRBLK8Vmi2G3sGKIpmnUBynx4P0w8XaupJaGYoV8Ggq71YdpMs6PUaH5r4DcfwL88L93f16JDW0OhAbv60/dLc2vsALma6GDBpgxB0P0MxkzfMT5HiZAAxVNzWsS+fbtidxcNn8wNiitUvdZOIxW/rOElfB+8FUqFrjRraIV3gpCsW09SAdTsQmWs2YcdzgQg+H/s0wfa72ILR1csJgjyVcp2obaOdNO4Ch1yp0tSYixLHRenivt2OOdWXoGG+4CybZm+2r4bTdtnByJzxgZmdwP/wF30yC3gdhE0EcNRtT3en7h6QahIVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0mPRKrfx1xet7mxkFUSxd8OAOESWAdpZoP2lPYKovQ=;
 b=aY9ytdL5S4m7EoOTtXB4DPr+7ZHawPGDxy4d0aXrGZmymiMAqapK1CvbOiVG6hBu6b1tnKSiE0z26EFgx8uoPKs4MvDHO/tiS+tk9Dia1H/E0d58xNkpHsnUdiI7wWMH5hpfLJNUHlSHkMExJvm2r1mM5mnvCofh5pup3yTnRR1tQTE95HPsE12I//eNW6fQAMSolY9YZHdpXncQGXMlqV06LnZhIBqB2KJXrM0t3bkm1h7/s9wK+FEMBP5TBJuiIw4DrPgbhF0tZeUQl0l296cuCfPe/+/x4U1U0XYkcy/Qqpa/iESKVTSrs+w6yvTrYqZr/dD5as8VO/3je4inTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0mPRKrfx1xet7mxkFUSxd8OAOESWAdpZoP2lPYKovQ=;
 b=YxKqR1YXio8bVaicDJvpbCyhbR8zW8ijSUHEIkec0iD5jrs7kjvUuuyvwYxPzSsS3ShOkDRCq08INvIzllKzuZb1nvYyX4P+2G5dfGqGiPzK+pThS0FaTbqljqAsWkkiveFKI6PMaVbS05KAWpwzLNtwDIuulz9fy5IAlaPNs58=
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 10:33:36 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:33:36 +0000
From:   <Balamanikandan.Gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <dmitry.torokhov@gmail.com>, <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
Thread-Topic: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
Thread-Index: AQHZ1a5MHo1XTdZMVECNex1WPftljq/30tcAgAEtJQCAACAYAIAAIW0A
Date:   Thu, 24 Aug 2023 10:33:36 +0000
Message-ID: <e6dc48bb-438e-42f1-a756-6995cff5516d@microchip.com>
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
 <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
 <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com>
 <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
 <CACRpkdY83_nQx8tWRV9SJyD=-SvY+30FiSXkrb5vKkd+QfuPaA@mail.gmail.com>
In-Reply-To: <CACRpkdY83_nQx8tWRV9SJyD=-SvY+30FiSXkrb5vKkd+QfuPaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|DS7PR11MB6128:EE_
x-ms-office365-filtering-correlation-id: 7c5fc14f-43e9-4bd9-5a3b-08dba48d92f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0TDvG7N9txGZY54k8fqU7YSKNghM3QfMeSBZB/lT9R8OhdnsVlw1QcX89a+qEvO0ZCvridWyzI2l5mgpIsR+zSjZ/sdVRbkrE4U02MEzgATO50aQUtWKwR8UK6nOkYclGXGJyP57gQE5Y5FeLeLlc/BtvKmYjRPTHwPfavfZ4e9m6FSd0nB4Wyy/VNCP25aBUl8hn/thqOtZqBhBb3WrbKzgWc+YojBPnonGAmhsbSGiGY60gC7UBYamj/+M+YmLXF9x1NQsaHh9sAhv9ZYYTHUsTGyt+bskQrOoC+7xCBFmbJkiyP8yEowaVdP5jtb42fjYXIg5KKs0+cyxW3mLbyRGTvEFbOs1uutHduOW+wB2+VzttzfTXjU+S/o4eRUaSkoVrY0KzCNrxcKEBXNCuWiL4JZ5cQx1Jkb/llIyXPmxPfp+PtvuQlmxcimNjUv/BuUYDifzIHQML6iCjhaFgoY6Rc3GO69SotVsTSSgysT/GA1KuADYffoMiAgcP5RYFKFUc6GDjs5E7IHGAg4ntx3GLkcyjv1rzKMd5tYxMk3pCA7icerLzryMO2G6x0VPMMchzY8BNmWTOin2YkhXCpSvFsQq/WM5J0VXe9bWY/1Zx1hyizaynfB7BShND+3ZKf+ktd2bQ1zPxZWdzpdbqcOr0XtyP5DPEZ0AQZ2zq67BZB0+MQ+SRJOxVE1+Bgom
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(2616005)(4326008)(8676002)(8936002)(5660300002)(107886003)(4744005)(36756003)(26005)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(54906003)(6916009)(316002)(91956017)(478600001)(31686004)(41300700001)(6512007)(2906002)(31696002)(53546011)(6486002)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWt3aHJhM3cxOHFNa3BJRlFYVWJGdXlJa0NkYXpIL0toOGd1dndKUS9YaTRV?=
 =?utf-8?B?cnFTblZlM09OMzNBMUR6NlcrVGFEc2JvNkRjRnNyMEhLVkduWWN5UTNnYXpj?=
 =?utf-8?B?bGVkUVE3akpkZnhoWjhPSkQ0ekpjUkpCK2Z3cmlEUXdMd2VPNEh3RUVZRkdO?=
 =?utf-8?B?Ui9ZS0NzNkdmWlpTWWQ5c0RFSUdvK2NZVlROOEJJbVF3Mmg0NmFCSnc2UEs3?=
 =?utf-8?B?WTJFUG1SUmlSK2ZIL0d2dVVTQ0NMekxQdEdtSFNtSlRRR3BGWlF2UzhjRmxD?=
 =?utf-8?B?dmNTMVdHeEp2ZXlJL1dsWHRTS0cvMkt4SGNIbXU0UFN0VGZEa1VYMFRPNENy?=
 =?utf-8?B?cjJaVkswWjFYUW4yUjdCeHRvY3VETkNPL1lCVm95amlUeW5ZSVRGRDVlSzhM?=
 =?utf-8?B?NUFKMkJ0TGkrYzRCQXNsTzREazB3T05pUXdWd0pHdzVKbUNTQ1BuT3dlTjQ0?=
 =?utf-8?B?ZzZjQkViQjFZRXJZWldhNFhXV0RxSE9PT2tpVFRlWDEvcjdMY01WMzEvZ1Zn?=
 =?utf-8?B?VEx4VTRjczMrWUZKTXlMQjJvUnBJUUt4QTVqZm1UVFdYSW1pYVIrcSsvMzZO?=
 =?utf-8?B?OVJPWTUyQ2VQRjkwTWV0YzFzSVBCNjhvSUxFdVN4cDJWWmJmanUxeEp2ajNv?=
 =?utf-8?B?SjRHSGNMbFdxSFVOS2ZtQzVxaG11REpkZE9DdnFjdHgrVm1zM0V4V1k4dkVZ?=
 =?utf-8?B?MFFCbmhmbk5Sa2JYbWltMXpuNEFiOXhzODNwZyttYnFjZ2Q2emFjVjdKWkVk?=
 =?utf-8?B?ZVJBWERNMTBDalo5elNQc3RlYm5pRmxZVzAwWlJsTjYzYWxnaURabzMrTG5z?=
 =?utf-8?B?eUhHZy9KSjdGNlNKVEx5ZWRqVmo2cjRSQTBCa1JBV3dTQ0FDRi8zbXczeDNI?=
 =?utf-8?B?TS92dmR2L1NxRDRBM0dERUZQcXlQYVRWSHZCU3Z2bDU5TDVkV2lOSEdOV3VI?=
 =?utf-8?B?SDIveE5yZzlNT3A2MTVhVUlDVExzSmVzSitMUEJFZzh5UVhqOHBVL3UvZnVD?=
 =?utf-8?B?RE5uN3V3ZTg4aTc5MFBPVnZCK2VDc1l1dlNTZ0RZSkZNTDA1Q05KQ1VZaWRE?=
 =?utf-8?B?QkxSWnJpbEZEVGVUMWRwOUxPdVhlbXdLaG9IeGs3ZnU4SzE2eUZwdTBMKzJX?=
 =?utf-8?B?K0tFbndHVTFyQ0FxbStaN24rRyswanpUV2tBUDdoVGgxWDM5TzNkcnZwSVpi?=
 =?utf-8?B?NFU4RWQvTGJYN2tteEQ0dW1DTCthNzZCVjlsZ0lubkFQR0o2Rm1KcHREUnRj?=
 =?utf-8?B?bFVZdnZxWUd0NmxueEh4UVF5VUhWRnFiMDRZM0pRRG9MbW9NVEJvSXBncmJY?=
 =?utf-8?B?bjllaHZqa0QwWjFjNXlzMk9TUk9wazdmUVhHT01KdWpDcnM2YWRWUmJOOVJJ?=
 =?utf-8?B?MEFoY1k3R2tBQ1FyMnpnYTJTVWNVbHBpY1NwRy9HN2hmQi9uV2gzdXdVejJI?=
 =?utf-8?B?OXdFbjN2dkN2cTRBaFdRWjhXSnBhZE9wdFVBcDRUcTB2Ri9UbDBXVVdvcGM1?=
 =?utf-8?B?Tk5RaHd4NFVTSlV5UlY5S1ljdmlRcFIxTkVYTERtV093Tms4aVNrQng3ODh4?=
 =?utf-8?B?QnBaeUtSSTAwVENTZWx4QklIbkx6Qk5zSHdqdzR4WUtkVEpZTjBNVTI2Tk9I?=
 =?utf-8?B?TnRmWGh5eWFoWmhZQ21RWU95UGJrK0FaYmVPT0x4Z1Bydk1zWlFpR2pRZFdO?=
 =?utf-8?B?dlNhVnZ3SDhCRmF2cDhLdUVlMmw3U1hYamJuWW5vRzJnRWI1aFdOOUowZFM5?=
 =?utf-8?B?NWYzYldiMkRTWjQyMVByVlh5U1NOU0VBbUtvTmpPN293TUtlT1lzRHhZVnN6?=
 =?utf-8?B?dWZzZ3lBVzFpUEQya1NOQnRaQVZPc0RMWWpSWTArZlBReGo0RDZkazhzZFN6?=
 =?utf-8?B?Sk5CRmdDMWJEcElBMU8vUVBhcXVMeHovK25sUWJtTVhKbVlPNnpRMHBMSXFl?=
 =?utf-8?B?THBhL1RWbXFxaDFYK2MydVhWTjM2dnNKcUo4ZFpycHZhVlJsRDd5NnhaOE9N?=
 =?utf-8?B?ajFLS2E3TUpWbis4R1N1aXlENkp6TW41NWxLMWhLQTg3NW44Zm1IeVVPWDVW?=
 =?utf-8?B?SzBoeGZNekpnT0pNYnlKc0NDcmlGNVBCWDl1cWxDeE1aamE0cGlEbG9wREVo?=
 =?utf-8?B?VlgyUWpGZXUvMUNxdDQvdWQ1bDdIblRUbVhFTk5vMUhIL1poN25VWkpZYyta?=
 =?utf-8?Q?BUaCYf4yqO2fyHKp4HZ1CoY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB7988B49F728640BB1589EFF0D786C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5fc14f-43e9-4bd9-5a3b-08dba48d92f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 10:33:36.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C32x15Fgihy7X4hnUs8wx4WlNkFHJb7ONxKdSsHhws1XAdvjvOifLclmQOmP73H2RaAQvqeQ8NpJAlkHbawVpD2aq8h79HWzoAeFUlhzLqHQrZKaYHw5LzOaHXASE0Ou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDgvMjMgMjowMyBwbSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCA4OjM5
4oCvQU0gPEJhbGFtYW5pa2FuZGFuLkd1bmFzdW5kYXJAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+
IA0KPj4+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX01NQ19BVE1FTE1DSSkNCj4+Pj4gKyAgICAg
ICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAtPnBhcmVudCwgImF0bWVsLGhzbWNpIikg
JiYNCj4+DQo+PiBUaGUgb25seSBkaWZmZXJlbmNlIGFib3ZlIGlzICJucC0+cGFyZW50IiB3aGls
ZSB0aGUgZXhpc3RpbmcgY29kZSB1c2VzDQo+PiAibnAiLiBUaGlzIGlzIGJlY2F1c2UgdGhlIGNv
bXBhdGlibGUgc3RyaW5nIGlzIGRlZmluZWQgaW4gdGhlIHBhcmVudA0KPj4gbm9kZSBoZXJlIHdo
aWxlIHRoZSBvdGhlcnMgaGF2ZSBpdCBpbiB0aGUgc2FtZSBub2RlLg0KPiANCj4gQWhhLiBXaGF0
IGFib3V0IHRoaXMgcmlnaHQgYmVmb3JlIHRoZSBmb3ItbG9vcA0KPiB0aGVuOg0KPiANCj4gLyog
VGhlIEF0bWVsIE1TTUNJIGhhcyB0aGUgcHJvcGVydHkgaW4gYSBjaGlsZCBub2RlIG9mIHRoZSBk
ZXZpY2UgKi8NCj4gaWYgKElTX0VOQUJMRUQoQ09ORklHX01NQ19BVE1FTE1DSSkgJiYNCj4gb2Zf
ZGV2aWNlX2lzX2NvbXBhdGlibGUobnAtPnBhcmVudCwgImF0bWVsLGhzbWNpIikpDQo+ICAgIG5w
ID0gcGFyZW50LT5ucDsNCj4gDQoNClRoaXMgbG9va3MgZ29vZCEgSSB3aWxsIHNlbmQgYSB2Ni4N
Cg0KVGhhbmtzLA0KQmFsYW1hbmlrYW5kYW4NCg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
DQo=
