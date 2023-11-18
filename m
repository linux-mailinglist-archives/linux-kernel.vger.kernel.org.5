Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C37EFCCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjKRA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjKRA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:58:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AA93;
        Fri, 17 Nov 2023 16:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700269132; x=1731805132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RlVcAsZGxSJLqfyCdMkuycrkSwjQfpaBCIp0emxMqAw=;
  b=UJGa17lXkGiAbEpb9EJS7V+ze2j6woojNGWoLLtFqMAZ4DTJoaL8RUWB
   XbGSFzul5ah3bm0MyM25uVX+7haqHPb692Hk/aawgMUyDUc3qtoxr4Dit
   S2WcXzXllsNT3Au5H/2E19p7asAYj4lOCqa6ynOvHg8CBTcbT5D0yLhNI
   RPlZBJ2TMDP/4jC6wlZgEqZ7slzwBLvTIz7ulVOCr64qmMY6K82W5e3Sg
   RHXOumxNzT4cUcMHLCxf4nBhTpTtcEkgPOHB0xxSY2IGAher3WpxzKgcY
   elNkhF+XcQt/q2YtvwTnkc4VN2Fqg+IXNLq+oi5UbQkkwRAN7HqrQMk2p
   g==;
X-CSE-ConnectionGUID: T+AnjKmbTAWrbXkwqgW0bQ==
X-CSE-MsgGUID: vHN9VTCQRdG+48bCI9fe2A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="242595989"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 17:58:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Nov 2023 17:58:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Nov 2023 17:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykh+fQGjG5vOIBKsy5qrfOyGBr1vMiEZ3Ei3hNxXDFkbg7oWmq3HLhlrmx4kOmkeBN6GqFuG6Nt96N0B5G5lPUQQqFRjIuSHGvxr8BNa+AYcSX+PfIV8+h8cZAnj5pHZU45AFcVDVy+QuBfX8A/IFrJAZi+SG7q1q0RRliyqqyf1WW5BA3+P8t0bUj0Mb5fOt/IyVzlb+uspDR/oeY3lE6+QtOw1BgA29Vaa4CIqSS/V77TNsVhQ+ve6aOf6tDvYfXLDdEcnyQT5nqXgNytlD7S0MGx9hGbOga+oTef//FWg8IiMt8l8V4QajQ83O1ur4AW/rfZsHXJJNEKOS2Lm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlVcAsZGxSJLqfyCdMkuycrkSwjQfpaBCIp0emxMqAw=;
 b=LWwL65kCj2G+k4ZddWCifJMe6LugKdXJbtRiQhJ9Vw3zH3db45QSUjZih1lxhSejclir2dzItlpWZ4mDy0vC7O6a8WDohiEWfBNSAKYqddvNmNge1Q3cA12RigYKFerOdpS+q4ZeHhTDcAuGUSlVjEunfTgSTwBa8lvgHa2ISWbPwZuvTmsIxxCX3dr1XqqS2rIURHuIZLWKQnCamfWiqf3qltYIzbLy22jLACz1ZwnySRif1WDuUitT6M0pYXUQ74I1VAg8rSvkl5YYsUDON4/rCflnKTfSQLWYJ+h5sGabTeMb1joUq0Pb+flkmNY9h8YMtfWQHXbW8Xw8LflKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlVcAsZGxSJLqfyCdMkuycrkSwjQfpaBCIp0emxMqAw=;
 b=wgHQ8BH2rSOFY99iAMCi9RPWEw/hNT/I8h+vyCX+vjP8FLXPBSI2TD2G28yGycK1stBjaQyS9bsq8kO3/mqepGwGX1vK+UGPRUtjXbtCXaG9kAj1XfjGkkQU8/hP5AJqrqexfZBXriv4JMOnYFo93SS/IR/BO3hVhzQ6hDFJMPhuAAbZJCDzNOfCXUUIoaLsmfqe8vvEOr01hPZBNNVhdxn5A5dZPfsXucZ5++kBzPQINyURhTuSXAUQRUtgYhJAI0/vzgAvop9Zj0sdYgIeluJ4ejTos03LIQtosmUGSOvLhaD7Ik4Wd5W27jsywVzYOKHSXKb7VeeIq1WJzrKzBA==
Received: from LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16)
 by CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 00:58:08 +0000
Received: from LV8PR11MB8678.namprd11.prod.outlook.com
 ([fe80::c99f:310f:d10a:34d0]) by LV8PR11MB8678.namprd11.prod.outlook.com
 ([fe80::c99f:310f:d10a:34d0%4]) with mapi id 15.20.7002.022; Sat, 18 Nov 2023
 00:58:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <inochiama@outlook.com>, <conor@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <unicorn_wang@outlook.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Thread-Topic: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Thread-Index: AQHaGRP3NnIUDpWQg0iOY4D1arBpnLB+W0AAgAAWQYCAACFuAIAAlbMAgAAZy4A=
Date:   Sat, 18 Nov 2023 00:58:07 +0000
Message-ID: <cd5e88b0-db70-663a-6436-e892f589e3a3@microchip.com>
References: <20231117-kindred-manor-863549870bcd@spud>
 <IA1PR20MB49536A1E4C97EA62558C6CC3BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB49536A1E4C97EA62558C6CC3BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8678:EE_|CH3PR11MB8240:EE_
x-ms-office365-filtering-correlation-id: cf6d058b-ecca-485e-e0bd-08dbe7d16dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMa9FYmROwRJPM+nN/GUXYiT7utCxIiGaNu3QXTVGD+0uVRSZVcp45uZRPmI340EgZHO6IIJrOqYQtQo1nKUrowym0UYEgpLPIuXeNOsXcAlgMvxg3+NFm3rnWsbLYcj3Rbh3jQlZcaodsDq1MInNSlg4SzHMg3km51lblZ/P/e3umaORY8eU6uzTe1BSCxyMOKUv/LJ0QXqHVeCzZotGxXI8pSrbwJjwzEriP1BZ7d1fSEzGIHXTjpdQQrNOuBVQ/nclogz1GlbbZb6oj2AiYhav/fZ6igNZ7OpJaVRDGjVLhRpkQvWKsYWbffd5i2H8rkAWAXYpdPzb019riA+fsB4ZGpVXDyys9mki4K8A0CH19E9+UgVADFx9AI9XXA6mEAAzf5hb63XxEcSFXfLNXe4esYOaO48URyxWzZU1WBvyjuZpepjbPFTjWKLJ+wKFBTF//hkGlSwLSeLnW8Ib7NcBl5TUoafJQTw48YCvrh+EGXh9ao24kl5s5mFO/kVF11AQIFcuLy9STTMc8QpDwr7RWOOBIClGUetiE+yf3Di3e0ZAOCfQozG+MObv/Yi+mht8wHFPh8UhhMWCkGEj27hNAhrKYpwrAhqwTeZqdBslNGT1DzMY2a8ZaP8BGP4cUP8+EIz4Kk6aNgFMIOwugCt5qQsVcn430CJY4/66xZbUzw/+03870hrCD6ReF4s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(558084003)(26005)(41300700001)(122000001)(31696002)(36756003)(31686004)(2616005)(6506007)(38100700002)(38070700009)(6512007)(71200400001)(6486002)(2906002)(7416002)(86362001)(316002)(66946007)(5660300002)(66556008)(64756008)(54906003)(66446008)(110136005)(91956017)(76116006)(66476007)(478600001)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1jS2o5ZmVWMlNNeFM3cWZMcFJuQVQ0TktRTURCeG55bE1rTUJhTXhPQys4?=
 =?utf-8?B?M0RpZGVKdlFQRmZGYTdFT0QyUSt3QlNiVFdXL3lwVFpxcVBtZ1VrUmROOEk2?=
 =?utf-8?B?Qi9pcjBXS1pFNHNVRFVNeHdiSU5QRmRCL1g4ckQ4dGVnWmszVmIwZUNwbUgx?=
 =?utf-8?B?Zy9SY2JnRU5sc1JtSWF1NTZwdjI5cTB1RVlGTkxGWVhwbUdNNFNDTFpDRFo1?=
 =?utf-8?B?QmlMZWFHeGRMaW5yUnBOdEJDWi83ZDlnL1lZNGpFOXJrUjZpSm4wdWR6aVBj?=
 =?utf-8?B?bVlPZ3Mwc1h5QnlNa0dUb1BUTWpacFB4b2xqRE15NzNkd0ZZWjA5U08zckZP?=
 =?utf-8?B?cDE2Y1ZZSmR2L2E3ZHdUNWRMWWFXM1loT3luTzlraWQxUlVxbU9QVlprL09w?=
 =?utf-8?B?SmZrZ2M0aXRWa3F6RlMvTzZEQVFNbWNLQ0M4emI3R0c4eWh5NThsOVRPMjBG?=
 =?utf-8?B?TWUzVXNOQ09qY2trWTBjWjZPWXB1eDgyd3Qrd1M4MTJ1MUdLNis1M3FLMkgr?=
 =?utf-8?B?SzIzWFpMcW1KRTNleU9nT3lMVzg5MkVsQmpjSnR0bVhQcU5xTEZoUjZlejUr?=
 =?utf-8?B?b3BPRHNCaEp5L2l1d2lYdktRYllQRVFvcmtwK1hPSmFZZ1N2T28vcmQ1dHRr?=
 =?utf-8?B?cExKUlA1am9tQkpDTW9IMGZQVUlnaXBMMEhWREFRRG9XMVBqVldRdm5GVTlL?=
 =?utf-8?B?RytTUUwzR2xFWXZLdUltYzFQWUdPSk5HNWRVVmVtVEEzclNsS3Y0aE9KOEww?=
 =?utf-8?B?bkJxOS9GMjlzRXlpTnBuSWVLUjZUcCtjUjl5R2dZWHR2b3owODRKTEtkcWxL?=
 =?utf-8?B?bVlwSE1sMXlyRjdydVh3WkJwRC85cTRYSVBycEhmRDZhUlJBUWFjb2dYeEVW?=
 =?utf-8?B?NGpWam9TZk5PdldrMjZzT1VIeEh3N1JNYjlSUDBjNUtEK2wvdDZLbGhJM2tk?=
 =?utf-8?B?Y3EyZ2NLc0JQRHVDSjVOb095VTJJUmEwMEI1ZEFiSjNwRzk5dmpQWTArYVFr?=
 =?utf-8?B?VVdNMHJCdTc1QXBmK3lBTkhobHdVenQzbkx2MHdVcm5xaitvdDJVdVlVdHV2?=
 =?utf-8?B?TEplOWxxVnYwTjJ3Qnd4Vy9rWVJIWHlNR2Uyc3h5SlEzRVR0aEVWM2greThJ?=
 =?utf-8?B?VXA4UG9raURvVlIyZGlwWWl6Y2RRYnVWM0pSaWdsRDR3QWcyVzEveVdkenFV?=
 =?utf-8?B?SVowSEpHSzRURk1VbmpnL3BjY1hVeE05UGxZeTRHZy9qWGR6bG01aGpRWDNs?=
 =?utf-8?B?ZDNxVFFxS3B1eTcxV3k2T3NtWU4wRnd3eVNlekoySCszZHA4K2hlNmhJdVhI?=
 =?utf-8?B?VzBMNGorVWV1ZEVVRlhQMW44N3NiYjZMMmNZMFNQdVJhRkY0TGR1emRhOGk2?=
 =?utf-8?B?ejZkemJzYmk1YUxJb3NabDhLQ2tORmNKVENGTzUvTVdFdFJaY05rYWdDR3Rr?=
 =?utf-8?B?a2o3S2dNeUVZQWtKMzZlSzJIYUhHdVRUVWNSNnZIdkVCZU5vaGp2c1pSdncv?=
 =?utf-8?B?OVhGTUhWbVQ5alZxMTNKVVh5MVh4cm9Ja1BwZTJCM0x6aWNIVmkremtNei9F?=
 =?utf-8?B?b095LzdyeGZRRUdORUZJSnAwSXFkMU1LcnJIZXk0UE12NTVwUmhYSTBqV2NZ?=
 =?utf-8?B?a2ZwZUdWTnZBTWc4T243d1Z2SFlzazlUUm45OGlwOXIxSTZ0Z2V5NW5SdVBR?=
 =?utf-8?B?dmVXMTVVU3JCM0EyV0JDaERuT3VCd1ZkR2J1TEdnS0FCWXo4OTRpSi9Nbndp?=
 =?utf-8?B?cWF3ZmtKc3MyN3RmVFhNU2FMQ1lvKy9BeEk1bEtCUlgzSWI0TXJMdURFSVpl?=
 =?utf-8?B?L2lvbnVYc045UWZHdXpveFVqd1hmOVRZR0lkVnZSczRjM2ZLZ3l1OEtLR3Rr?=
 =?utf-8?B?dXhMQmhOUWphQmdRVVdIZldVd294Qm5qRkpLbnJKdnpIdnliWE5RV3kvNkJi?=
 =?utf-8?B?M0h0RWcrQWxyMDRIOHgvcEZFRGVzOGZrT0N4QmVzdDJuRFFQM0FaMkt6S0hK?=
 =?utf-8?B?NGh4Ym1ta1gvQlFYZkVldWowUXNBTFJPQ0h6cWR2MjVldzVkSU5IREpRRXlB?=
 =?utf-8?B?d1FIRGlhRjlDWHNTUkRKQW9OT3phT012UloyaDJwbXlHV0c1eFJDUmxkM0Zl?=
 =?utf-8?Q?PoAhiyRZuC7GjwVNYinX61ZtL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C2943241FDDB54DAEC03986A0B13BE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6d058b-ecca-485e-e0bd-08dbe7d16dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 00:58:07.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq8EJw2E1Hogqts+VUiHUGkO6kR/373XL5q8O5bqcsV24RukNefv1TVX7aHCqHWSdXjwNJXmivI6Rh/CWpcd37athtCcogf2m9uNNnc6HvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFRoYW5rcyBmb3IgeW91ciBjbGFyaWZpY2F0aW9uLiBJZiBJIHVuZGVyc3RhbmQgeW91IGNv
cnJlY3RseSwgdGhlIGJpbmRpbmcNCj4gc2hvdWxkIGhhdmUgYWxsIHJlZ2lzdGVycyB0aGF0IEFD
TElOVCBoYXMuIEJ1dCBmb3Igc3BlY2lmaWMgdXNlIGNhc2UsDQo+IGl0IHNob3VsZCBvbmx5IGNv
bnRhaW4gc3VwcG9ydGVkIHJlZ2lzdGVycyBhbmQgb21pdCB1bnN1cHBvcnRlZC4gUGxlYXNlDQo+
IGNvcnJlY3QgbWUgaWYgSSBtaXN1bmRlcnN0b29kLiBUaGFua3MuDQoNClllcy4NCg0K
