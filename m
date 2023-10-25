Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8D7D6ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJYMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJYMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:03:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3DB0;
        Wed, 25 Oct 2023 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698235393; x=1729771393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sZEl9JnMf5CZFQ2vOxcFRb5bZl+MFetO/ACGhZn+FMU=;
  b=Cw4gHxjwyJAILSB+ctxUbjwwgRONg24K7225SZEfb6z4XAwd3ZJoxWJD
   Ng6LzijxZyCbpZDEwGRGwqOckaw6wEFpwVDHzVDCRGvisepX+GU7VMTNh
   BezJwu9kPrh5/DzvmW+40A/KO70QOHQt8pJgHSDSejYgS6PiP9B3Zoj7M
   HJqqRfQXaED43XwefgL/iRA3E2lQhQFVesRvDkEcp2cWXIcwj7BHWVdry
   tVh7Sz012DuUJ+r4JB+EzJkdtKRTqfm+yCYk9raFXFQXJNxAuF40NnXhb
   Z9IABEACnZAWQkx+EJclkJZqfAm9nMkBIDsP00ykWDXiIqe4Br+k9/SED
   Q==;
X-CSE-ConnectionGUID: 3UEKfl7ISESICLApQIhgLQ==
X-CSE-MsgGUID: DDovWjl1RxSgJjZp6/vLeQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="10568989"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 05:03:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 05:03:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 05:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnWYQ+eqwKgYW+0QCYauzEH+UmQ05RWzVY2lCM06je0Sy1pnCu4t3yEsgwVBQrchpJnbJUi9P8h/4T4WmZEqX0khRSXbEisenBVYKCMt/ZcgLneY0S25+VHIES2QFiryKNV+Jaf1ox5M5TX34ZFp7KNiN7G9uM78mX6lNjHqxepqRU5tLTnmAh1Z7dk8azK78p9WB+D0FpbPXp7ZUXTVGO8XUhetAnWEYi/Y+3aNFl3KzjtqJwrpwNvcxE8V1k+qknLFS5PK7/tyOPcTlx+m7WkF8UK++lxAVj7AqpBfTgDsrE978sPmw1VYpHuoCO/shq+Yqz9y3zR8VFOrtGi8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZEl9JnMf5CZFQ2vOxcFRb5bZl+MFetO/ACGhZn+FMU=;
 b=L+yru1OsqLJ5Z02ygpyDwN6hp6JXbvM6831ICgd5HQjIQX39FcmmxAe5snP+vNsCAAqv1Y1XsbEk8HGQHkex9ww9O8uBvYZD1Y1/tlM3172jswbOW7cfO58HmnD7xtS26rlNu76gStLC2Nh9YSlY7Hv24nap9ZIDY/8SD2kOn6NBduNByJu+PFuoIIlOHmBkeo12XxEFi73HYNHOSD4WWn4oi3mYvJeifwpA772oTlGjoqsRynYlX8WighbprYs0p/rwBtI/udXOIjD9CFZjKUJJwJiq3dZaq4LOSvc3PQiq7hlaBidAPKElWg/B8hIeL+16DHbzyKXP6HCZnLyfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZEl9JnMf5CZFQ2vOxcFRb5bZl+MFetO/ACGhZn+FMU=;
 b=nVWvAcpe2GE/LVAvfZVlZn3vs5zy+CIN8D1UbiTp4y5sLvLHPKUTYAB6R/gJvC4sdVXYM4yJE6YdTnCMjrNJiYv3eKREBygT34fC+G31K2YQ1WRDBLEbid/rAExTg08DJwv82vs1OJkQ+9nK3Rp3SbilSyOWRP0VFJ5KmRrImAk=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:02:58 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 12:02:58 +0000
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
Thread-Index: AQHaBchYB3PCp799EEm9bj7uTu4tjLBX/WmAgAJtaIA=
Date:   Wed, 25 Oct 2023 12:02:58 +0000
Message-ID: <97872e83-1490-4f1a-81ff-3f7692571dd1@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
 <423e0b42-a75e-4104-b445-7d9ff0991acf@lunn.ch>
In-Reply-To: <423e0b42-a75e-4104-b445-7d9ff0991acf@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: 9d94beff-c780-41f9-cc84-08dbd5525468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGtJZDg8ldTn6D0IkD0SeATd9Jw2KMOOVUfwNHRvK0p6a0ERaDvt6jYG+E7coR/APGafdE21ELHXXT2XdQG5pwgdQRiks5G7cgFh1v1TgmFPWKGyrakMWDgI9vAtIeFtl7RRPw8zsJrta8u7WqNnVYOfSFir/dpJuX5y3Cywb74/F0P0PWfU9LE0Bb5lgckPkUH75nlLHimYEwirK8zznybhr96zGLZgq+hRh9hggyCOmxu9CcluY05zk+wLaRGwySH3/m0Fcjv0oWlkAntc/SHVyTZ5TFQiKR6Aiz+XJfaNe+YtnUs1qaIHrWT0kCeyzUgUbsAlqllIDOEfiS36AgPrwsMvfj2Ptd6PRR6CNCjJ6lNVauz+3tFmEmN4kWWGiOymfXTlxh4+Uur08+qyDcrJfnPFV/ojvy5a+W8cvXsKB/DlMwQvtVuVJ9qVC6U1CQxniJE9acNYRlPfpPVXiTG4yswUjv3oXzreB9QqTQYMNeJ4uTi6+FZD7cZZf/+ImFwNntcibBMZBV8yOtE03eDPwStsL5RUqTNEticBPEJbSQEfikU9z0sJ4DEXKf2SOeUH51mtR9yWNaKzB38Zn+dUV0P/ijGAdbZa+aCoKiYj6EHrzfEdM2LXGM6rGhHYYMNxX/5t4808pSo24CMGxtPMQtswfiuOFKQpWWXbZ31g0t4axrUIqcrbgDN/6HTA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(71200400001)(5660300002)(64756008)(76116006)(66556008)(41300700001)(86362001)(66946007)(478600001)(66476007)(91956017)(6916009)(31696002)(54906003)(6506007)(6512007)(6486002)(66446008)(316002)(2906002)(4326008)(36756003)(122000001)(38100700002)(8936002)(8676002)(53546011)(2616005)(107886003)(31686004)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2wzUWNhVE1CQytGQytVNUhwZHZxWmRocUlocHBKRUJyeFQyWDhXN3VEc1Mz?=
 =?utf-8?B?ZU84dXZxUGswNzlvMmh4aWVQSjRqdmFFWVg2REdUM3lENXZ3djZ3cWtyVXVC?=
 =?utf-8?B?bDhCcHppRGZpY2tzektRbGNVU2xnY3RCUW9ud1orTEhjMVVDL0x0c25nZGhB?=
 =?utf-8?B?TjltdlBnOFZjc3RIUDNzaGppMFMrNXJiQUFGRG5jeUg5V0o0eHdpRjRyaG1m?=
 =?utf-8?B?cHZIZEYwRjB3TytKTDhncjZxMDJlWUJRWjFGOXlBSVNNQWVWVlkzTjZFZk45?=
 =?utf-8?B?OGpwdFhxVFd1MThkbWNzcWxXU3lzanZYcjR4SS9ybVNmQ1F2QlFXYTRFUnZ1?=
 =?utf-8?B?RGIySkhiWm04TFFkU1BHbXRnR2pCL1lUVXJUQlBxSTY2SlBFbVVBcnc4dDVF?=
 =?utf-8?B?TWFPZ09lTTIxQ3ZaUUZPaUw5aE5Ob1ExTWZDYi9qbWVBZ0hDZ0VSYmI0UDZW?=
 =?utf-8?B?Zlg1QzlLOHQxRE9HZmxvd2hlbXIybloyQVlJaGtqY1cwMFZnN05aUzdMZk5B?=
 =?utf-8?B?RlovMy85eHRhclVGdGMxV3QyRXY1L3ArUUNLdG9sN1pJVVZEejQzdnVhSjJR?=
 =?utf-8?B?K2czVHBYMGwxcWhxNHAwRHZDdm9XdnpPbTRMeVlENTNyRVFtZmdpZ2dCaFJ2?=
 =?utf-8?B?R0tSVHVnUDhMdXd0eFo3QUxJOEl1Q2t5ejFXbWpDT2h6dmczclczdk9GV1My?=
 =?utf-8?B?RllMV0Y2cDRNM3BjaUdBR3I5TFA3NlV1M2IxWVVoNXBMYnV2QStCNlgwc05O?=
 =?utf-8?B?Y25EQkJVODFuMW9sYy92VkNNL0pibkc0cEV5Ynh4aGwrRlZBVXA4Uko2alll?=
 =?utf-8?B?YzcyUVFxNmZZcStDLzVJUXJTZlRnb3hoMFVkWTRDcFFKbUo4MmgvMStobSta?=
 =?utf-8?B?R3BJN3VKdDJNVHg5RHVkRXRZc1JkeVIzY1NtUWdYUmVWaXNodllmZkQxYUll?=
 =?utf-8?B?WDBHdjU2Y2ZQTmJsd1ZYb1paQzlwYTdNL3JoV2hRZGR4c2ZaVktxZk9Mc3hX?=
 =?utf-8?B?TVd3REF0NGJmUUVCMU1zaXhUYU5nam91RFpVVE0rWGduVGJDR2JDNGw2ZkVJ?=
 =?utf-8?B?UlNBQ0E2OGpWTlREWE8wYUpMVmhyQ0RBbk1ZUm55eEtDSU9OaXJzbzBqbXEz?=
 =?utf-8?B?d2VkWjAvZ2k4V3lTZlJ1R3F0bVFDdWV5UUNCb1pkc00yV2dOTXY1algvR3Vk?=
 =?utf-8?B?NzRVdXpWT0owM1Bzd3phVlZLT1o3anVldHpTZExnaXZmUENXL2tqTFRQdTll?=
 =?utf-8?B?VVRkMnA4NUdUNXlzYTVObjhOblV0OXVSV2JTQTQvZFpPaUJyUFNvdzczMTZp?=
 =?utf-8?B?QTNXT1RWNXRBZzlWd1R5NlB4VU5veVFvbVhoTW5RWFk4YXEzU3hWbDdZSTJu?=
 =?utf-8?B?TVI4WW9zYXdGd042emRIbk5acU5LTlEzQldERkFQeFpKeUtuNkJpL2E2Qjh0?=
 =?utf-8?B?bVh3YlM4Q0gvK3BSN1JBem5DR1VvZGw5dHpKdGVxYmprdCtCN2lFNkVERlAv?=
 =?utf-8?B?SUpMelEvcWtwaUQwU1RmMkZxMUdzb2RDZ2l3ZCttOWhXeU1wNiszQnVsUzVi?=
 =?utf-8?B?OU1zKzlsSVU3eWtLaFF5MGg0ZW1uQmJpLzZmd3JvbmQ3YjNNQWVYZVN1Rkxr?=
 =?utf-8?B?QUcxRUlsQXRzcTZkdTNxZ2dHSkY0K2RQVUVuekRaSExidUN0Wjg1Q3FUbDkz?=
 =?utf-8?B?anJpQld3bnJBNGpMVlF1YlFZd3RFRlhsZDNSNGlVMExiK0VNa1pSbjZ1UkxH?=
 =?utf-8?B?bmlhQVM0S3o5Q1BqbGtEUHNTSXJaS0I1VkF1NUxsQkRpbVVMRUFWd083N1Nw?=
 =?utf-8?B?WFo1UmZ6WUFxUDFuSnBGNXdDeFpscWZTNkpRcUZXdCtYRnZZLzd5MnJmQVk4?=
 =?utf-8?B?WmgvQzA5MFk3eDcyV2RJbUNnb3ZDMnZwVVBnTG0wRE1FMFRic00vYTRsV3F0?=
 =?utf-8?B?NmMwTWJEdzlDdFhGVUFXbVAzKzdwclNxZy9qa2llK0ZqWG41Q1dtRGlmcWlk?=
 =?utf-8?B?eHlNS29hazZud2krcnFLN2hFU0FRRGFnV2M2ZmN3b1pXdjRtd0E5V25wVDlz?=
 =?utf-8?B?ZzhSQjlQYXBIa29oL3hXakVma2VKTzFyM3hIcE5oNUVjeXhjN3NyaEtqZ1M3?=
 =?utf-8?B?UjZmQzRCUzNaZGp6N2xtaTErZ1RrOFFkOEVPdkJYMCtWTWZicEdKb1ZRSDVn?=
 =?utf-8?B?Wmh3WFZSSXJoMkMzWkJjUGJ0YXVOcTBmQlNLVXJvNmR2dGhHUERSbVNGWGN2?=
 =?utf-8?Q?svJexPH7qSxQID9Pwtiw3xQ5PilqwVuyxQYrLfs3dM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE254A21B84235428F5DB5281B13A228@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d94beff-c780-41f9-cc84-08dbd5525468
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:02:58.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LZENkCAyqxP5NHx5+MpIEu1m1SuYwmAxku6nvgI1C2nNeAnwRXW6YzjKEjhS0kX/MfLdntj5XCwLzEyteCq2d1zQWO/K/YvmZ2cKQmTj5RdZdR1XonpWQz4SukwZlQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA0OjI4IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgICAgLyogUmVhZCBh
bmQgY29uZmlndXJlIHRoZSBJTUFTSzAgcmVnaXN0ZXIgZm9yIHVubWFza2luZyB0aGUgaW50ZXJy
dXB0cyAqLw0KPj4gKyAgICAgcmV0ID0gb2FfdGM2X3BlcmZvcm1fY3RybCh0YzYsIElNQVNLMCwg
JnJlZ3ZhbCwgMSwgZmFsc2UsIGZhbHNlKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBDYW4geW91IHVzZSBvYV90YzZfcmVhZF9yZWdpc3Rl
cigpIGhlcmU/IEkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzLCB3aGF0DQo+IGRvZXMgdGM2LT5wcm90
ZWN0IGRlZmF1bHQgdG8gdW50aWwgaXQgaXMgc2V0IGxhdGVyIGluIHRoaXMgZnVuY3Rpb24/DQo+
IFNvIGxvbmcgYXMgaXQgZGVmYXVsdHMgdG8gZmFsc2UsIGkgZ3Vlc3MgeW91IGNhbiB1c2UgdGhl
IHJlZ2lzdGVyDQo+IHJlYWQvd3JpdGUgZnVuY3Rpb25zLCB3aGljaCBhcmUgYSBsb3QgbW9yZSBy
ZWFkYWJsZSB0aGFuIHRoaXMgZ2VuZXJpYw0KPiBvYV90YzZfcGVyZm9ybV9jdHJsKCkuDQpZZXMs
IEkgd2lsbCBkbyB0aGF0LiBBbHNvIGZvciBuZXh0IHR3byBjYWxscyBhcyB3ZWxsLg0KPiANCj4+
ICsNCj4+ICsgICAgIHJlZ3ZhbCAmPSB+KFRYUEVNICYgVFhCT0VNICYgVFhCVUVNICYgUlhCT0VN
ICYgTE9GRU0gJiBIRFJFTSk7DQo+PiArDQo+PiArICAgICByZXQgPSBvYV90YzZfcGVyZm9ybV9j
dHJsKHRjNiwgSU1BU0swLCAmcmVndmFsLCAxLCB0cnVlLCBmYWxzZSk7DQo+PiArICAgICBpZiAo
cmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogUmVh
ZCBTVERDQVAgcmVnaXN0ZXIgdG8gZ2V0IHRoZSBNQUMtUEhZIHN0YW5kYXJkIGNhcGFiaWxpdGll
cyAqLw0KPj4gKyAgICAgcmV0ID0gb2FfdGM2X3BlcmZvcm1fY3RybCh0YzYsIFNURENBUCwgJnJl
Z3ZhbCwgMSwgZmFsc2UsIGZhbHNlKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICBtaW5jcHMgPSBGSUVMRF9HRVQoTUlOQ1BT
LCByZWd2YWwpOw0KPj4gKyAgICAgY3RjID0gKHJlZ3ZhbCAmIENUQykgPyB0cnVlIDogZmFsc2U7
DQo+PiArDQo+PiArICAgICByZWd2YWwgPSAwOw0KPj4gKyAgICAgb2Ffbm9kZSA9IG9mX2dldF9j
aGlsZF9ieV9uYW1lKHNwaS0+ZGV2Lm9mX25vZGUsICJvYS10YzYiKTsNCj4+ICsgICAgIGlmIChv
YV9ub2RlKSB7DQo+PiArICAgICAgICAgICAgIC8qIFJlYWQgT0EgcGFyYW1ldGVycyBmcm9tIERU
ICovDQo+PiArICAgICAgICAgICAgIGlmIChvZl9wcm9wZXJ0eV9wcmVzZW50KG9hX25vZGUsICJv
YS1jcHMiKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IG9mX3Byb3BlcnR5X3Jl
YWRfdTMyKG9hX25vZGUsICJvYS1jcHMiLCAmdGM2LT5jcHMpOw0KPiANCj4gSWYgb2ZfcHJvcGVy
dHlfcmVhZF91MzIoKSBkb2VzIG5vdCBmaW5kIHRoZSBwcm9wZXJ0eSwgaXQgaXMgZG9jdW1lbnRl
ZA0KPiB0byBub3QgdG91Y2ggdGM2LT5jcHMuIFNvIHlvdSBjYW4gc2V0IHRjNi0+Y3BzIHRvIHRo
ZSBkZWZhdWx0IDY0LA0KPiBiZWZvcmUgdGhlIGJpZyBpZiwgYW5kIHNraXAgdGhlIG9mX3Byb3Bl
cnR5X3ByZXNlbnQoKS4gWW91IGNhbiB0aGVuDQo+IHByb2JhYmx5IHJlbW92ZSB0aGUgZWxzZSBh
dCB0aGUgZW5kIGFzIHdlbGwuDQpBaCBvaywgd2lsbCBkbyB0aGF0Lg0KPiANCj4+ICsgICAgICAg
ICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgLyogUmV0dXJuIGVycm9y
IGlmIHRoZSBjb25maWd1cmVkIGNwcyBpcyBsZXNzIHRoYW4gdGhlDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICogbWluaW11bSBjcHMgc3VwcG9ydGVkIGJ5IHRoZSBNQUMtUEhZLg0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICh0YzYt
PmNwcyA8IG1pbmNwcykNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RU5PREVWOw0KPiANCj4gQSBkZXZfZXJyKCkgd291bGQgYmUgbmljZSBoZXJlIHRvIGluZGljYXRl
IHdoeS4NCk9rIHN1cmUuDQo+IA0KPj4gKyAgICAgICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIHRjNi0+Y3BzID0gNjQ7DQo+PiArICAgICAgICAgICAgIH0NCj4+ICsg
ICAgICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3ByZXNlbnQob2Ffbm9kZSwgIm9hLXR4Y3RlIikp
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAvKiBSZXR1cm4gZXJyb3IgaWYgdGhlIHR4IGN1
dCB0aHJvdWdoIG1vZGUgaXMgY29uZmlndXJlZA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAq
IGJ1dCBpdCBpcyBub3Qgc3VwcG9ydGVkIGJ5IE1BQy1QSFkuDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICovDQo+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKGN0YykNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZ3ZhbCB8PSBUWENURTsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVO
T0RFVjsNCj4gDQo+IGFuZCBhIGRldl9lcnIoKSBoZXJlIGFzIHdlbGwuDQpPayBzdXJlLg0KPiAN
Cj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICBpZiAob2ZfcHJvcGVydHlfcHJl
c2VudChvYV9ub2RlLCAib2EtcnhjdGUiKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIC8q
IFJldHVybiBlcnJvciBpZiB0aGUgcnggY3V0IHRocm91Z2ggbW9kZSBpcyBjb25maWd1cmVkDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICogYnV0IGl0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgTUFD
LVBIWS4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBpZiAoY3RjKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVndmFsIHw9
IFJYQ1RFOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gKyAgICAgICAgICAgICB9DQo+IA0K
PiBhbmQgYW5vdGhlciBkZXZfZXJyKCkuIFdpdGhvdXQgdGhlc2UgcHJpbnRzLCB5b3UgcHJvYmFi
bHkgbmVlZCB0bw0KPiBtb2RpZnkgdGhlIGNvZGUgdG8gZmlndXJlIG91dCB3aHkgdGhlIHByb2Jl
IGZhaWxlZC4NClllcyBJIHVuZGVyc3RhbmQuIFdpbGwgZG8gdGhhdCBpbiB0aGUgbmV4dCByZXZp
c2lvbi4NCj4gDQo+PiArICAgICAgICAgICAgIGlmIChvZl9wcm9wZXJ0eV9wcmVzZW50KG9hX25v
ZGUsICJvYS1wcm90ZSIpKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcmVndmFsIHw9IFBS
T1RFOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHRjNi0+cHJvdGUgPSB0cnVlOw0KPj4gKyAg
ICAgICAgICAgICB9DQo+PiArICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICB0YzYtPmNw
cyA9IDY0Ow0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgcmVndmFsIHw9IEZJRUxEX1BSRVAo
Q1BTLCBpbG9nMih0YzYtPmNwcykgLyBpbG9nMigyKSkgfCBTWU5DOw0KPj4gKw0KPj4gKyAgICAg
cmV0dXJuIG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2LCBDT05GSUcwLCAmcmVndmFsLCAxLCB0cnVl
LCBmYWxzZSk7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IG9hX3RjNl9zd19yZXNldChz
dHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiAgIHsNCj4+ICAgICAgICB1MzIgcmVndmFsOw0KPj4gQEAg
LTMxMCw3ICszODcsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChvYV90YzZfcmVhZF9yZWdpc3RlcnMp
Ow0KPj4gICAgKiBSZXR1cm5zIHBvaW50ZXIgcmVmZXJlbmNlIHRvIHRoZSBvYV90YzYgc3RydWN0
dXJlIGlmIGFsbCB0aGUgbWVtb3J5DQo+PiAgICAqIGFsbG9jYXRpb24gc3VjY2VzcyBvdGhlcndp
c2UgTlVMTC4NCj4+ICAgICovDQo+PiAtc3RydWN0IG9hX3RjNiAqb2FfdGM2X2luaXQoc3RydWN0
IHNwaV9kZXZpY2UgKnNwaSwgYm9vbCBwcm90ZSkNCj4+ICtzdHJ1Y3Qgb2FfdGM2ICpvYV90YzZf
aW5pdChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiANCj4gV2FzIHRoZXJlIGEgcmVhc29uIHRv
IGhhdmUgcHJvdGUgaW5pdGlhbGx5LCBhbmQgdGhlbiByZW1vdmUgaXQgaGVyZT8NClRoZSByZWFz
b24gaXMsIGNvbnRyb2wgY29tbXVuaWNhdGlvbiB1c2VzICJwcm90ZWN0Ii4gQnV0IGluIHRoZSBm
aXJzdCANCnBhdGNoIHRoZXJlIHdhcyBubyBkdCB1c2VkLiBMYXRlciBpbiB0aGlzIHBhdGNoLCBk
dCB1c2VkIGZvciBhbGwgdGhlIA0KY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzIGFuZCB0aGlzIGFs
c28gcGFydCBvZiB0aGF0LiBUaGF0J3Mgd2h5IHJlbW92ZWQgDQphbmQgbW92ZWQgdGhpcyB0byBk
dCBjb25maWd1cmF0aW9uLg0KDQpXaGF0J3MgeW91ciBvcGluaW9uPyBzaGFsbCBJIGtlZXAgYXMg
aXQgaXMgbGlrZSB0aGlzPyBvciByZW1vdmUgdGhlIA0KcHJvdGVjdCBpbiB0aGUgZmlyc3QgdHdv
IHBhdGNoZXMgYW5kIGludHJvZHVjZSBpbiB0aGlzIHBhdGNoPw0KDQpCZXN0IFJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KPiANCj4gICAgICBBbmRyZXcNCg0K
