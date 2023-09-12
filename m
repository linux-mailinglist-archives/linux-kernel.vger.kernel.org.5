Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537B79CEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjILKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjILKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:53:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5310D5;
        Tue, 12 Sep 2023 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694516014; x=1726052014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UuoV17w6stjSOa1g8ZJg0y2YHAK6bYz6OmUZ8DUHYUk=;
  b=qjWcOUutMlRM9TFg0/ya/8pGKTJDr5KH+0+66fX6wJiNKMNqaEJow9Cq
   WmkX/iSFwTrgd3rd2lyqTNiH/4k8dJCcYS04TEP/xPC8FfH9nBPGbT0KR
   E+8MS+0uLht87jaQyh9SRU2Cy/YycywLiNICcpUcZ02JkFhXPhy/rOE6t
   yXHTcVDrf+SODVvG0R4KP1aaG/5KlHFU5bPfx6i8s/SbDBF47hKkLz0NP
   RFNzNvl+UzPL2xtrF3jV9jASP41XXrBd5duGhJR+2SlRxvU9BEazc6MWJ
   L1VUKrkqn6e58IwZEE0ts970mVY4hm0vZZdN4c66VM4d5NF4LUI/6gHXL
   Q==;
X-CSE-ConnectionGUID: LsSK7Cs2SXCEwfkio8fEQA==
X-CSE-MsgGUID: 4Llak8ZISW6MyfsvfJesfg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="4358428"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 03:53:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 03:53:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 12 Sep 2023 03:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwhBT+5yXLWQYyX/zS7sqpLjxANi6t++a9cMW7GKDf0HrSLY+x8YoeRwu7ivdkqYiaHqshtksxmekNYhLDsNKesApohKGoQxsCw55mtRGnpK6ckW9yPiUh7L45nXgM/q7pkvR2Nk0l/vpofO+9c7DrKpsX8Mt5ugi0ndKMXhEo3Q6UIb5yFLg2ixQDUXruC0IqoflWNJbNZL00Rc3dy6sxzZ5AKcpkdKNn8LgzfQxjtAkVwf4Qdiu7THujTth9o3T2rrelFds8rpbNpteKUhW6SNfZ4JD1TAh1sJ5MQGPkRzOTVOg3y0Tt2EqCReQBJh2+DEQnMv8/5Xvr0AnEqZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuoV17w6stjSOa1g8ZJg0y2YHAK6bYz6OmUZ8DUHYUk=;
 b=Cl49tssQ6O3f5hu+PSj9R8N9P8mmbtL1sr43wNBqqsmacVZBeF153bdq3pE99GwWX/xWORplNO4MVnTa2OxcXwLnyPABmKlwHjmyIz//eG9Lu6IReCjiAqEfWNjSz0LZsrlZtcYn6pPcYh6yPjF6zpYXDKb1Vw/e9gdbHwH6N8fVgkHRdn1lAWtRnuBzYfpKCiMFl2VgPS7I/hQLxs0hluLlPTHTEycnY8c/f/fsmHpy4IyEvs0JQ/lFkM6o7B9DByDOsYPvtfQ3FNesaUzml2JexblXBXKyueFTyFCDdmI2CjRAEDIVIrwxK9oBuAcUUYo70ynDF3yM8+7QNQMzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuoV17w6stjSOa1g8ZJg0y2YHAK6bYz6OmUZ8DUHYUk=;
 b=eQv6uqBKZhOe5ZxZEQ/Tvt/oHZ+cCJgdoXXCDXDqjFsIm3E0hOAFH8vwv1KI6aAsH8f2eS8YoeXzODgdnOvMJJxQHNzD2/s8vztBtUMW/ZaSYcSfy1TmpH0VxhkUYs1/c191h9QoAqgyM/yUG7eKOxPtfPCbbhT+YTCCzfOM4TI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 10:53:29 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 10:53:29 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <horms@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <casper.casan@gmail.com>,
        <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mEuK01gdvjwlU2rxFfJz2fLmrAUWD+AgAKxrgA=
Date:   Tue, 12 Sep 2023 10:53:29 +0000
Message-ID: <f75cb1d2-a594-c982-370d-f7e3740bb6cf@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
 <20230910174453.GK775887@kernel.org>
In-Reply-To: <20230910174453.GK775887@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|MW6PR11MB8390:EE_
x-ms-office365-filtering-correlation-id: f081712c-27b7-41fc-f8a3-08dbb37e7fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLhK+y0OvtGpRFRtI3qHsRubBJYXmbg2IG3HXUOxQ0iukmJfcD6dtVqgJ6v4kF4f0ie5R5EIWYU3BDudozL+3mIdHtEhxASUO79ePGbBtRPYEkz05jdmolWXgQo0v42BPFdaScWhSH0IYgCY2Bp8tYnR7jEg58m9+GQDZmx3LFbpxtlIUsCeWq2/Yw1oaFRiv/+ws/G/Dmw3ujkzgTGlgRvohO5u2hmnjjrOyg6kl4bXTiIXReK6HlbiQwdnivPeIhz9PaBNLRin9kFEqV5vHF4g1Nd3FB72j0SFsQQ524462W+j4DElCiqfYpdMtQXeBYZXmxAqyG2lF8TJKfuvxY29PiJj5r6hMFAZJyslMdIdCLtp2ZNyZNM5dWzDTmUaoXxVTIFmfphq7Ymtu7ZO7HybWLllxAP3cnc/Ih/R069ORJlJhUm1kodF9WVlkjVFomQSsQLsyN+DA0QO1JhxGTY+bIA6c1ZxTo77nclCZ+xkhrvwy3CDQek5dAGuTyHESIApXOAjrN9ZvyuAR3lbqQ4U1Gl8j6pEdEXREGqwQeKrSjAsCsX1+Y9X7eimor3AXFobfJKmwXlzY/mR7X3Kr9Tlr0bBVbC74ffPLMFlPzs9LlVzYChYCkj84ZyfaS6HDoGfVXqpYiodHpfBBsZbt2QZud9s0Ke3/SvbnPkMYso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(1800799009)(451199024)(186009)(41300700001)(66946007)(66446008)(76116006)(66556008)(91956017)(66476007)(54906003)(64756008)(316002)(6916009)(122000001)(478600001)(966005)(38100700002)(38070700005)(7416002)(2906002)(36756003)(31696002)(86362001)(5660300002)(4326008)(8676002)(8936002)(83380400001)(6512007)(107886003)(2616005)(26005)(71200400001)(6486002)(6506007)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJWUkl5NEpUTXYyQzVxZzFaaHowQjU4eU52a1J6My9paXM1VzlFcGRRbTlY?=
 =?utf-8?B?TERqU2I2ZDVyb1FLbW1NSE0ybDk1WnhRcWViQ0prdVBoZUJ6eHRjejZIaENz?=
 =?utf-8?B?MnVKSVdYcVkxeHF0QUliL2lRQThTMFhtL3Vqb1VvbkRWUmZacVFXQTlheVEw?=
 =?utf-8?B?b0R2RVNZa1dPOUprZ0VGaGtmR3BBSitmbnUwUjZrVnAxYXg3azNTWXIxQlAr?=
 =?utf-8?B?WVZKM0lFRHRFVU92a2o0T21ZQUlubjdkMmh0dm1HeXFKNXBXMUtrcjBXWDlk?=
 =?utf-8?B?cGs5eVpTMGZYM01kLzdnUUdQZDFzV3NlUTI0NVI4WW0vU3R5dFphaU02bFhZ?=
 =?utf-8?B?WXFBcmZrT2c4MWFFSmZiYTlUOHlzRlRrV1NhOHozSnhrR3AxWFpBdVJ2K0gr?=
 =?utf-8?B?cnlLZngvck94M0NheHg4aldhYVkwbWFYN0grSVJDekJtOTYrQ0xqa0t0SmZY?=
 =?utf-8?B?eVRsWmtSRGlsZjA1QTRsN2x3QUN2V1VzWkNhTXVGRjRXQWwzblZLcU1sNjdo?=
 =?utf-8?B?RHJPT0ZKMVljRDJYSmxMTjE3VTNKY3FibnVyV3Njd0xtenVYaTZGSWZjTG1C?=
 =?utf-8?B?OUtzd0NpZzZxNnFyd2FIMDZZbm1ZSU9nTzlKL1pYY1V3QysrSDkvRUc0U2FW?=
 =?utf-8?B?eXlQN3J3V0VrMDJnR0pJUFgrb2dnVHZ4c2o4OXowam96Y01GRHBXeUFUMndC?=
 =?utf-8?B?QXZSc2lOYWxYSTN0TktybXRnUFc2dWJqeXIxcGl0cHlEUTVKUUdtZjFwYyty?=
 =?utf-8?B?aXk1NGo0WEdCMnM3dlRZU2ExVkZKNjVXeG91SnBHODllV1JiNmlPYUlHM0V6?=
 =?utf-8?B?Tm56L3J4L0Q1c05HdGVpUllncUlucll5NHF4dmhpdG94Nm5NeG9vaHhsem0w?=
 =?utf-8?B?Z1FvNmswUHJnOWVReUN6N0VUREdYRDV0K3J5M3FJdTJuaXViYzVVWld1K0Fy?=
 =?utf-8?B?MDJFSWNDcFhiSC9HSjlRcXU0TkwyakZMdHU4SXprNEJyeTV3NVpBbE5YNlhJ?=
 =?utf-8?B?SllwTWlVRnlBaUhoR3JVbWo3ZzdxQUFwdnlPUzVyRFBRbWdQMWU1bDRlbGhY?=
 =?utf-8?B?WEg1NTJzU0FUWGVEWHhlLzBFeEw2M0xVMzB6R0JoTkRMWlRiZjJGTVVVa3Rt?=
 =?utf-8?B?dkg3ZGFPTlNCaCtTeXJPODk2NFVTbHRwNVhZZHQxL0ptS2J2RkxFSHBnbi9U?=
 =?utf-8?B?aWVhOW4rUUN4aVAzMDY5Q2hCQlRtWi9GNStNWEI2OXRlcjBxSThxamtTK1lv?=
 =?utf-8?B?M1FPdHlyNWlBNGhaVHRRWkYzVnhtTW0vVFE1dW5ickx2SDVyc0ZqdmhvMzZE?=
 =?utf-8?B?K3Y5VTR6Z1Q2VzI2eE4vcHZmQm15b3VhYkdPR1VHTjd0UUN0ZXFzVysrbVdx?=
 =?utf-8?B?eWNpanRHMzgxeE90UE9vWktBckY4ZlltQkJvMzZJc2FOUmNLYXN2eXhjUlZt?=
 =?utf-8?B?dnZha2NFWlJhaVVybmRrems5SHArR09idWYxUjBuT2hZVDJid3pDWGhTNUJI?=
 =?utf-8?B?ZDZBWVo1NXIyVUxsOVM3akRFalRROFYwOFFKbG4vSWt4VDdKL1kvUHg2YnBM?=
 =?utf-8?B?eTJZV3cvS2hLYkVTRmhhUkJNSktuUFJVSTNkQXVpcEwxRUNoOTJmWEY0dUlN?=
 =?utf-8?B?S3dJQmpRQ2x6bGprSEkzV0drWnNja1o5RGg2aVlaOElsWkVKZkFjRnlCbFBo?=
 =?utf-8?B?OWxtakVwMGVMTnpTRmhmMHYvd3VoaGQ0UU51TnNEbTlVMWlxQ2ZoMG5BR1ls?=
 =?utf-8?B?dkQ5dUN3SjIySFFseTlYK2dFUEFVcFNUVjRxWHZLa2h0ZGxsOEx4aW8rMXJK?=
 =?utf-8?B?bDFTemxUeTFvSHBaZVpMcjBjc2YxV2xlR1dJdWhLaFNKTlkzMkpZQ2h4ZGIr?=
 =?utf-8?B?RHN1WTN6Y1gwU2x0UmxuVzJITnFyYVJtRnFpbE5pUVdsaHhHcnpZRUR3TytU?=
 =?utf-8?B?V2hqcVpPOUY1Z3htMnYwcVpxR1FPQ0NBUEJQbis1aE9hV1hGeFdmRmZlVGlB?=
 =?utf-8?B?djdOVzNrVC9JRy9IUFVJVmZHbGZMc0xGLytlaGhBVUI5RFJYL2thY1ltY3hM?=
 =?utf-8?B?S01pZWRXK2JPa2pDUCs5NTB1RzJaUG5xeXNuamNDYUVEbUdLNzFFWVRYdG9J?=
 =?utf-8?B?blJmNUxkVFhqR3pEbVVmeTE1ekI4WUFwTWlza01GQ21zTXVlQkRRT0IwWjZn?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <114B62D242630348BE64C253093A183F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f081712c-27b7-41fc-f8a3-08dbb37e7fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:53:29.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usLiECsxINK/1YOOLfkkujZ3nuW+2b3aSTcfrGdvDT//CEBpJ7rELBJohmO8tRF/pOHyhQpKiuxc0Q3zot8irdagiiOxIB4SMnXJOdr33PfnwI5BK5wSd9euDgHNvhYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ltb24sDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMTAv
MDkvMjMgMTE6MTQgcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIFNlcCAwOCwgMjAyMyBhdCAwNzo1OToxOFBN
ICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBUaGUgTEFOODY1MC8xIGlz
IGRlc2lnbmVkIHRvIGNvbmZvcm0gdG8gdGhlIE9QRU4gQWxsaWFuY2UgMTBCQVNF4oCRVDF4DQo+
PiBNQUPigJFQSFkgU2VyaWFsIEludGVyZmFjZSBzcGVjaWZpY2F0aW9uLCBWZXJzaW9uIDEuMS4g
VGhlIElFRUUgQ2xhdXNlIDQNCj4+IE1BQyBpbnRlZ3JhdGlvbiBwcm92aWRlcyB0aGUgbG93IHBp
biBjb3VudCBzdGFuZGFyZCBTUEkgaW50ZXJmYWNlIHRvIGFueQ0KPj4gbWljcm9jb250cm9sbGVy
IHRoZXJlZm9yZSBwcm92aWRpbmcgRXRoZXJuZXQgZnVuY3Rpb25hbGl0eSB3aXRob3V0DQo+PiBy
ZXF1aXJpbmcgTUFDIGludGVncmF0aW9uIHdpdGhpbiB0aGUgbWljcm9jb250cm9sbGVyLiBUaGUg
TEFOODY1MC8xDQo+PiBvcGVyYXRlcyBhcyBhbiBTUEkgY2xpZW50IHN1cHBvcnRpbmcgU0NMSyBj
bG9jayByYXRlcyB1cCB0byBhIG1heGltdW0gb2YNCj4+IDI1IE1Iei4gVGhpcyBTUEkgaW50ZXJm
YWNlIHN1cHBvcnRzIHRoZSB0cmFuc2ZlciBvZiBib3RoIGRhdGEgKEV0aGVybmV0DQo+PiBmcmFt
ZXMpIGFuZCBjb250cm9sIChyZWdpc3RlciBhY2Nlc3MpLg0KPj4NCj4+IEJ5IGRlZmF1bHQsIHRo
ZSBjaHVuayBkYXRhIHBheWxvYWQgaXMgNjQgYnl0ZXMgaW4gc2l6ZS4gQSBzbWFsbGVyIHBheWxv
YWQNCj4+IGRhdGEgc2l6ZSBvZiAzMiBieXRlcyBpcyBhbHNvIHN1cHBvcnRlZCBhbmQgbWF5IGJl
IGNvbmZpZ3VyZWQgaW4gdGhlDQo+PiBDaHVuayBQYXlsb2FkIFNpemUgKENQUykgZmllbGQgb2Yg
dGhlIENvbmZpZ3VyYXRpb24gMCAoT0FfQ09ORklHMCkNCj4+IHJlZ2lzdGVyLiBDaGFuZ2luZyB0
aGUgY2h1bmsgcGF5bG9hZCBzaXplIHJlcXVpcmVzIHRoZSBMQU44NjUwLzEgYmUgcmVzZXQNCj4+
IGFuZCBzaGFsbCBub3QgYmUgZG9uZSBkdXJpbmcgbm9ybWFsIG9wZXJhdGlvbi4NCj4+DQo+PiBU
aGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgbW9kdWxlIGltcGxlbWVu
dHMgYSAxMCBNYnBzDQo+PiBoYWxmIGR1cGxleCBFdGhlcm5ldCBNQUMsIGNvbXBhdGlibGUgd2l0
aCB0aGUgSUVFRSA4MDIuMyBzdGFuZGFyZC4NCj4+IDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXIg
dHJhbnNjZWl2ZXIgaW50ZWdyYXRlZCBpbnRvIHRoZSBMQU44NjUwLzEuIFRoZQ0KPj4gUEhZIGFu
ZCBNQUMgYXJlIGNvbm5lY3RlZCB2aWEgYW4gaW50ZXJuYWwgTWVkaWEgSW5kZXBlbmRlbnQgSW50
ZXJmYWNlDQo+PiAoTUlJKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFz
b29yYW4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiANCj4gSGkgUGFy
dGhpYmFuLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoZXMuDQo+IFNvbWUgbWlub3IgZmVl
ZGJhY2sgb24gdGhpcyBvbmUgZm9sbG93cy4NCj4gDQo+IC4uLg0KPiANCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXguYw0KPiANCj4gLi4uDQo+IA0KPj4gK3N0YXRpYyBp
bnQgbGFuODY1eF9zZXRfaHdfbWFjYWRkcihzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPj4g
K3sNCj4+ICsgICAgIHUzMiByZWd2YWw7DQo+PiArICAgICBib29sIHJldDsNCj4+ICsgICAgIHN0
cnVjdCBsYW44NjV4X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPj4gKyAgICAg
Y29uc3QgdTggKm1hYyA9IG5ldGRldi0+ZGV2X2FkZHI7DQo+IA0KPiBQbGVhc2UgYXJyYW5nZSBs
b2NhbCB2YXJpYWJsZXMgaW4gTmV0d29ya2luZyBjb2RlIGluIHJldmVyc2UgeG1hcyB0cmVlDQo+
IG9yZGVyIC0gbG9uZ2VzdCBsaW5lIHRvIHNob3J0ZXN0Lg0KPiANCj4gVGhpcyB0b29sIGNhbiBi
ZSBvZiBhc3Npc3RhbmNlIGhlcmU6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9lY3JlZS1zb2xhcmZs
YXJlL3htYXN0cmVlDQpTdXJlIHdpbGwgZG8gaXQuIFNvbWVob3cgdGhpcyBhcmVhIGdvdCBlc2Nh
cGVkIGZyb20gbXkgZXllcy4NCj4gDQo+IC4uLg0KPiANCj4+ICtzdGF0aWMgaW50IGxhbjg2NXhf
cHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbmV0
X2RldmljZSAqbmV0ZGV2Ow0KPj4gKyAgICAgc3RydWN0IGxhbjg2NXhfcHJpdiAqcHJpdjsNCj4+
ICsgICAgIHUzMiByZWd2YWw7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgbmV0
ZGV2ID0gYWxsb2NfZXRoZXJkZXYoc2l6ZW9mKHN0cnVjdCBsYW44NjV4X3ByaXYpKTsNCj4+ICsg
ICAgIGlmICghbmV0ZGV2KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsN
Cj4+ICsgICAgIHByaXYgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPj4gKyAgICAgcHJpdi0+bmV0
ZGV2ID0gbmV0ZGV2Ow0KPj4gKyAgICAgcHJpdi0+c3BpID0gc3BpOw0KPj4gKyAgICAgcHJpdi0+
bXNnX2VuYWJsZSA9IDA7DQo+PiArICAgICBzcGlfc2V0X2RydmRhdGEoc3BpLCBwcml2KTsNCj4+
ICsgICAgIFNFVF9ORVRERVZfREVWKG5ldGRldiwgJnNwaS0+ZGV2KTsNCj4+ICsNCj4+ICsgICAg
IHJldCA9IGxhbjg2NXhfZ2V0X2R0X2RhdGEocHJpdik7DQo+PiArICAgICBpZiAocmV0KQ0KPj4g
KyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgc3BpLT5ydCA9IHRydWU7
DQo+PiArICAgICBzcGlfc2V0dXAoc3BpKTsNCj4+ICsNCj4+ICsgICAgIHByaXYtPnRjNiA9IG9h
X3RjNl9pbml0KHNwaSwgbmV0ZGV2KTsNCj4+ICsgICAgIGlmICghcHJpdi0+dGM2KSB7DQo+PiAr
ICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+PiArICAgICAgICAgICAgIGdvdG8gZXJyb3Jf
b2FfdGM2X2luaXQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICBpZiAocHJpdi0+Y3BzID09
IDMyKSB7DQo+PiArICAgICAgICAgICAgIHJlZ3ZhbCA9IENDU19RMF9UWF9DRkdfMzI7DQo+PiAr
ICAgICAgICAgICAgIHJldCA9IG9hX3RjNl93cml0ZV9yZWdpc3Rlcihwcml2LT50YzYsIENDU19R
MF9UWF9DRkcsICZyZWd2YWwsIDEpOw0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICAgICAgICAgIHJl
Z3ZhbCA9IENDU19RMF9SWF9DRkdfMzI7DQo+PiArICAgICAgICAgICAgIHJldCA9IG9hX3RjNl93
cml0ZV9yZWdpc3Rlcihwcml2LT50YzYsIENDU19RMF9SWF9DRkcsICZyZWd2YWwsIDEpOw0KPj4g
KyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICBpZiAob2FfdGM2X2NvbmZpZ3VyZShwcml2
LT50YzYsIHByaXYtPmNwcywgcHJpdi0+cHJvdGVjdGVkLCBwcml2LT50eGN0ZSwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIHByaXYtPnJ4Y3RlKSkNCj4+ICsgICAgICAgICAgICAgZ290
byBlcnJfbWFjcGh5X2NvbmZpZzsNCj4gDQo+IEp1bXBpbmcgdG8gZXJyX21hY3BoeV9jb25maWcg
d2lsbCByZXN1bHQgaW4gdGhpcyBmdW5jdGlvbiByZXR1cm5pbmcgcmV0Lg0KPiBIb3dldmVyLCBy
ZXQgd2lsbCBiZSAwIGF0IHRoaXMgcG9pbnQuIFBlcmhhcHMgaXQgc2hvdWxkIGJlIHNldCB0byBh
bg0KPiBlcnJvciB2YWx1ZS4NCkFoIHllcywgdGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQuIFdp
bGwgY29ycmVjdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGli
YW4gVg0KPiANCj4gRmxhZ2dlZCBieSBTbWF0Y2guDQo+IA0KPj4gKw0KPj4gKyAgICAgcmV0ID0g
bGFuODY1eF9waHlfaW5pdChwcml2KTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAg
ICAgIGdvdG8gZXJyb3JfcGh5Ow0KPj4gKw0KPj4gKyAgICAgaWYgKGRldmljZV9nZXRfZXRoZGV2
X2FkZHJlc3MoJnNwaS0+ZGV2LCBuZXRkZXYpKQ0KPj4gKyAgICAgICAgICAgICBldGhfaHdfYWRk
cl9yYW5kb20obmV0ZGV2KTsNCj4+ICsNCj4+ICsgICAgIHJldCA9IGxhbjg2NXhfc2V0X2h3X21h
Y2FkZHIobmV0ZGV2KTsNCj4+ICsgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgaWYg
KG5ldGlmX21zZ19wcm9iZShwcml2KSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KCZzcGktPmRldiwgIkZhaWxlZCB0byBjb25maWd1cmUgTUFDIik7DQo+PiArICAgICAgICAgICAg
IGdvdG8gZXJyb3Jfc2V0X21hYzsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIG5ldGRldi0+
aWZfcG9ydCA9IElGX1BPUlRfMTBCQVNFVDsNCj4+ICsgICAgIG5ldGRldi0+aXJxID0gc3BpLT5p
cnE7DQo+PiArICAgICBuZXRkZXYtPm5ldGRldl9vcHMgPSAmbGFuODY1eF9uZXRkZXZfb3BzOw0K
Pj4gKyAgICAgbmV0ZGV2LT53YXRjaGRvZ190aW1lbyA9IFRYX1RJTUVPVVQ7DQo+PiArICAgICBu
ZXRkZXYtPmV0aHRvb2xfb3BzID0gJmxhbjg2NXhfZXRodG9vbF9vcHM7DQo+PiArICAgICByZXQg
PSByZWdpc3Rlcl9uZXRkZXYobmV0ZGV2KTsNCj4+ICsgICAgIGlmIChyZXQpIHsNCj4+ICsgICAg
ICAgICAgICAgaWYgKG5ldGlmX21zZ19wcm9iZShwcml2KSkNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKCZzcGktPmRldiwgIlJlZ2lzdGVyIG5ldGRldiBmYWlsZWQgKHJldCA9ICVk
KSIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQpOw0KPj4gKyAgICAgICAg
ICAgICBnb3RvIGVycm9yX25ldGRldl9yZWdpc3RlcjsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsg
ICAgIHBoeV9zdGFydChwcml2LT5waHlkZXYpOw0KPj4gKyAgICAgcmV0dXJuIDA7DQo+PiArDQo+
PiArZXJyb3JfbmV0ZGV2X3JlZ2lzdGVyOg0KPj4gK2Vycm9yX3NldF9tYWM6DQo+PiArICAgICBw
aHlfZGlzY29ubmVjdChwcml2LT5waHlkZXYpOw0KPj4gKyAgICAgbWRpb2J1c191bnJlZ2lzdGVy
KHByaXYtPm1kaW9idXMpOw0KPj4gKyAgICAgbWRpb2J1c19mcmVlKHByaXYtPm1kaW9idXMpOw0K
Pj4gK2Vycm9yX3BoeToNCj4+ICtlcnJfbWFjcGh5X2NvbmZpZzoNCj4+ICsgICAgIG9hX3RjNl9k
ZWluaXQocHJpdi0+dGM2KTsNCj4+ICtlcnJvcl9vYV90YzZfaW5pdDoNCj4+ICsgICAgIGZyZWVf
bmV0ZGV2KHByaXYtPm5ldGRldik7DQo+PiArICAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4gDQo+
IA0KPiAuLi4NCg0K
