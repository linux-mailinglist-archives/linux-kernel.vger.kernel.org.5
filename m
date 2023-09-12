Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E079C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjILFVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjILFVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:21:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E348AA;
        Mon, 11 Sep 2023 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694496072; x=1726032072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V/ZsafPoqoZGxY2M9rfE3xNimvahm5mKGpfK3ze1LG0=;
  b=bD8E/Y30zl7soOpT+zJSozq+tO+Zozkx2VVF+5MYsJQ5lSQhwWq4N7Lj
   0S2bG7ctb2eY4TW0rGOF4IqsAfEJe2Ef0uOuPkIsoaXVT3TY/RWHaYNLU
   6w3OpuiHmViJ4ZwdzRff7YJZsaTD21VChAx0EV3cktTJ+n0c4QCAhM4SQ
   hZTJaS7Ze26JZSWaeCK2E66YNGBDMcBpBuxYl/cy7Y3jyFHDK0tNXWJfH
   fYpZYXmqEdUugH9fHOxtA9Fd1029DLYblUmn8l+KFJILEQKpH8RIY+Ree
   +dpr7AwBmhxKoEX7MpQ4Up5EhejbdZvyrbkXFHuUi109Vr7mJkfnR7udZ
   w==;
X-CSE-ConnectionGUID: HdUnEvObTlKOHksS9u9sEA==
X-CSE-MsgGUID: ZFWtBw6xTLyssxmBuIyqiw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="4153527"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 22:21:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 22:21:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 22:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3HiGqkhgfX9HV6u3mbJt42Y2jUlpb9boHTDuugzyvgWqY0hgI6q9BRBIOYBQzCv7k91n5V3SRaHU8FKu4puIvK/+jfnXwz4nVHGakjf6uzyZ+mL5i4pvbMLChMVyP8ueh9Cq/v28M08CsMJKao8+RS9V58uHzkSW4ng7fN1wy6s65pOMAAvsU30cT5gl14xilDzbuTzyRc9wokcFI5Zlet7z6/UgAuw7SKLUlU8QKjXaeMOpbmWOJyqzHwP8Dsq4/8ey8yBWmoC1g0Mo1LYZDfM5s57VvefLCQU5tIu04LFLnJxLNiqZ6heh+821N5EdQyl5kYb1MrUvtzW59eKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/ZsafPoqoZGxY2M9rfE3xNimvahm5mKGpfK3ze1LG0=;
 b=fAcyKqprQzcyBvjsor02DZtjg2f9np+cMb6CgRUTo4Tnkftg9BtQpcasHGqKuHVbcT7HeuZMJacs+ax6Kvx3oZG6dcpKlzdUnSTPUlrcdLplynuLiwT9krYiDCWJ/DkLJzS5qjcaWJ0y7+gXsDr707oCFbktJ6nL4BwK356d6eXjT8Qya8blld9J9OE41b+Fra2s9C4c53wOLRdGHQfMUEMff3UeQx/pc4HAwZzh1MBWD8LStmt28cwvF2qPU1YhgzAMX13aQmK3KZ0UvJwp+Pct2Qy1rM5NPaYtutD8fzb8PvANBC308hr9iLj6dTg6mXnT5NF6DFW6m2VmW84U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/ZsafPoqoZGxY2M9rfE3xNimvahm5mKGpfK3ze1LG0=;
 b=vlrQPgGmYQ6u0kPD5gJ5feBmwuyaGjpkuNsnmmkYTwXv+VFOBZKjyS4VfhktQyuXgNQTN4ukVfLKZP95udPNoN20bwd2F860B0P1SpHeso9CAxt0c4/Mea7lNz5Z9k4w1CQ+CEYdOpyaj6gQEzTAGL3uFti31C58PBrSBV2dl2o=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 05:21:01 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::edf5:57d3:d82d:3557]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::edf5:57d3:d82d:3557%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 05:21:01 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Aubin.Constans@microchip.com>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <eugen.hristev@collabora.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Hari.PrasathGE@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
Thread-Topic: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
Thread-Index: AQHZ5MVb+wc+2m0DEUyU868OGWM9y7AWqEoA
Date:   Tue, 12 Sep 2023 05:21:01 +0000
Message-ID: <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
References: <20230911153246.137148-1-aubin.constans@microchip.com>
In-Reply-To: <20230911153246.137148-1-aubin.constans@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CH0PR11MB5300:EE_
x-ms-office365-filtering-correlation-id: 9335ca62-0797-4dea-8d15-08dbb3500dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWSPiWcLe/QKmySu0MZhfOAbv6pJcS+l7AHZEK3h4rk5b2ROpEl+Cp9+hZ2RH696EcfWZXA/5Uop0PmiWnuyG7ODu1uUpMv2noQ4bjiy4iAF1sNZbqe6hkqK+HG6Bxu4g8vAXwdlNRwCyEk81LAU3ySFtompBuu8DrzmTorg0wU0rzVWGCF9F1AmYPy7H5WRzkifqcSMNSSpDJOxpQOjx1aLWEe8vPNMe02Qp9Co7VtBKIhSAMhNxdtCUQZ0A8NS2H3w1UirF3CSGo0dgqnMDF5GL3CHdjcDVirHOKjZfkCe9lu57rQXj78LlUHHC4B6tb8GlkeZQCGXOMC07muMnsVSTsbmIA3WN8j9XtW0wJc0DmSvR+K24hySAQyBT38t7eiRSRhRVlJUcKUVMyO38/ckAEQDKYWCfsW9CgcKuxxGHPeqIbu+PLwdB1bWshAupCylBl8rzbpGhFPpDLrlLW+dATRNMB1c1Ch3aiT3C+W+Jb97wkfdxwSITMu663PrdUy5m+2aLvJsaR2I/blqTbrIVLEJR+/W0itAwDOMPXe039ZXCCcLk9XeYRy9y04xH8dHS9oT85dWu5AYu7572TV2nSjPXmaSbt750pswuK8CXNJch5fSH8cHIKx8GIHxQ2rE9Hgl1AliFu9zes1IKQ+dKoiT81Jyh1S1ryzkROO1vls6To53aFg2rKi5xTZg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199024)(186009)(1800799009)(86362001)(31696002)(5660300002)(8676002)(8936002)(4326008)(2906002)(36756003)(53546011)(6506007)(6512007)(6486002)(71200400001)(26005)(2616005)(38100700002)(122000001)(478600001)(38070700005)(83380400001)(31686004)(91956017)(110136005)(316002)(41300700001)(66476007)(66446008)(64756008)(76116006)(54906003)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhhWHhiOFdrR0l1NmZQMUhmR1YxU0FlcjlRR2J5YVJDVW92Rnh6RlRuTnFC?=
 =?utf-8?B?UE5ob3NKWWFUM2FpU0FlWjh5Zk41UDJjZFhMNHN4M0hMN2xRelhtT244UWNi?=
 =?utf-8?B?ZW5RN2FRYWw3ZFQvd1YwVlZYNnlyZTUzVkFVc3dTQmFLUlM2bEQwTnVqS1pk?=
 =?utf-8?B?SXdwVUxwMjB5VUJpeHV6NUdDQ3krbkJKeC81YkRza2tNUTNMRVoyaVFWdjJZ?=
 =?utf-8?B?cGJlaUwrKzE1c0Y1dmNwL0YrQytqMXdSdkdsQ2FFUElqanlSK2ExcVA2OG9W?=
 =?utf-8?B?TFd5Y0NLdkNSY29qejY3MG83bTR5K051bGNHMFdKbHBucVQ4WE13Vk1OUWJj?=
 =?utf-8?B?bjJORUgwVEowb3F1VjNDYXpWTFhKRno5bVRRMGFPdWZKdkM5U0YzbzlUdHRZ?=
 =?utf-8?B?NXFmNThzdjgwOEc0VU5pUGJKdU1UTXZHYmNTSXNibzZHaXBKQ2oyTDhOZ3pl?=
 =?utf-8?B?ZmlidDkyRU5OZ2RraU1zcVhVNllNaGxyOVFKdXltWHdodnhVR2dUZStORi83?=
 =?utf-8?B?QXl2TVFtVzZ0Rm9NbkhvT0dmQU53WnhyWHJsUC95Ym5mbjJqTVFSUnJLOHNK?=
 =?utf-8?B?STdnY1ltQ3Y0SVNhbFkwaC90UWRSdU5MdmRKYjlKS3NVUnR3NldMS2UyWTJm?=
 =?utf-8?B?RWVtZVdZSGtUMHRSMksxNTR3c1ZLT1JwTlNmd250VkZTeTBsVS9abDIyb0NI?=
 =?utf-8?B?SUJlR2xobG9mMmhZMnlseDhBbmVHWGVXQjFNaGlkbkZIYm0vL0dDNEZwRlVH?=
 =?utf-8?B?NUtXOTEvaTVNcG1qREVKOXl6OWpVWlFrVzFGbGNFbGVCWHZxZTd6SXJibGFs?=
 =?utf-8?B?dUNxallYTkRHUnM3d2l1eGdMTGxUQTM2d3NxL0NEQk1TWmlQYmg0WDRRMGV5?=
 =?utf-8?B?K2Y0YkVKSXBRYlRGZkY1aWQ2ZTZYVVJvRmlsTllSS0xzVDErcWwvdFR3S3RI?=
 =?utf-8?B?UUk3UmwrYjRidUhMUG5jY25ZcndJa1JNT3ppeHdrTFRnREx1MDJHT2pUWDR3?=
 =?utf-8?B?VVRSRDQ4SkpkTDdmSjlvQXBDSjAzMDlXa0Z0aEp2aWJaRDdDcDQvbWhBSjZJ?=
 =?utf-8?B?Nk9CWWpLKy91WnRFVXRPRXBCVlZWMkU4anJycmU4Y1NaZ3dVY2p1NGxjcW1O?=
 =?utf-8?B?QWU5MnI5T29qbk5ZeDBwb1dMSmtrSjdnNVE5dC9Hc1lVaW1HWEJGSUU1VHJP?=
 =?utf-8?B?dU1ydktVbHdGRUdSTFNxZWdDREdxV29icEIyVTZ2Rkg1NThiYlhzZHlOS3Ez?=
 =?utf-8?B?Z2NvcUsyS2Ezb0J3emFzZUJHUGhkVEhjd3dDUU9aLzZVOUtUckJ1MmxMVExT?=
 =?utf-8?B?bTl6U29CMzZ3bFgybnhMY2dvNE9SVHNXdUk0WE4vQm9CakpFeUJ5OVRxb2Nz?=
 =?utf-8?B?Y1lmMGlyTnhwYkpYRVRNTWJIWCtNeDhIL1N6MEF4RzVCN1NURUhOd1NzYlhD?=
 =?utf-8?B?MFlyNXBOM3RRRkQ2bFFMWlljc1k2WmRhRjltcklwWnZhdEl3dXJrNjc3YXZS?=
 =?utf-8?B?cElsalcrNk5CaU0vaUsxb1FNc2NYc3g5dzFnRXZ3RGhqeTE4K042eDF6VWEy?=
 =?utf-8?B?eGVpL0tEY1JWcllIOFgrQWZqUVh1WkJ5LytjWnFKNnRPVGNSdFZkVXgzWW5C?=
 =?utf-8?B?elNoZ0c0MEhuQkcwVUtBQ1IzdlVhUUtsc1RoeVRTOGZDSGpnS1p2Z0NmclJY?=
 =?utf-8?B?bWwzeFY0a0Q1dUlTWkU0cmFYaHU1cHRadURBRHBhVlJabExBYlVVVytpTCsr?=
 =?utf-8?B?TWNianUreThpclBxQ0FvNndpUis2RUVjdUhFanhyV0JXWVVpTEZlTDdRSnBt?=
 =?utf-8?B?dlIwSlZUNlh1a1Z1ZkRRZWd3RXpMN2hqMGZxNEpuZFd1R2psT1ZDRGFqQUlq?=
 =?utf-8?B?cC9FQXJHZXl4aWxoSHhDVGFFUWdOaWt5V0JIY1hyT1h2RVZvUDlMeHpDK1FG?=
 =?utf-8?B?cWlQRVpqdkN1SnZJQkNYQ2p5amxGWG5sUHUvcTkvaGgxcVZZRWF0THg0S2Rs?=
 =?utf-8?B?WjZMZG9tYUdRWXdFTEM3czM2WmJmNTQ0bXFyM2piNStldU5sSzVPUEI1NjVu?=
 =?utf-8?B?aTdtdmZRT1JUMVVpMnVjR2FaTHZMUnRCOWpqclQxc0dGVUN5SWt1Y0pqRGFI?=
 =?utf-8?B?RXQ0WE5QYmpTVEt6T0lOcWh4K0VTeG1hclk1ZDEyakhweVp6N1ZhekltdENF?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E2DBB2952DC946B21B74244F33F7E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335ca62-0797-4dea-8d15-08dbb3500dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 05:21:01.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j5RaGuKTcJjqLIWb+mzHTYJc31oCzQUGNEXOEiRg5UdqYyncigQFroXYmTadFhmHEIGpEnqz72gC8/Nf4U3z456MjC0Sql/36Q4mbd+Gvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMS8yMyAxNzozMiwgQXViaW4gQ29uc3RhbnMgd3JvdGU6DQo+IE9uIHRoZSBvbmUgaGFu
ZCBFdWdlbiBoYXMgdGFrZW4gcmVzcG9uc2liaWxpdGllcyBvdXRzaWRlIE1pY3JvY2hpcCwNCj4g
b24gdGhlIG90aGVyIGhhbmQgSSBoYXZlIHNvbWUgZXhwZXJpZW5jZSB3aXRoIHRoZSBNaWNyb2No
aXAgU0RNTUMNCj4gU0RIQ0kgY29udHJvbGxlci4NCj4gQ2hhbmdlIEV1Z2VuIGFzIHJldmlld2Vy
IGFuZCB0YWtlIG92ZXIgbWFpbnRhaW5lcnNoaXAgb2YgdGhlIFNESENJDQo+IE1JQ1JPQ0hJUCBE
UklWRVIuDQo+IEFsc28sIHRha2Ugb3ZlciBtYWludGFpbmVyc2hpcCBvZiBpdHMgcHJlZGVjZXNz
b3IsIHRoYXQgaXMgdGhlIE1DSQ0KPiBNSUNST0NISVAgRFJJVkVSLg0KPiANCj4gQ2M6IEV1Z2Vu
IEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAY29sbGFib3JhLmNvbT4NCj4gQ2M6IEx1ZG92aWMgRGVz
cm9jaGVzIDxsdWRvdmljLmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBdWJpbiBDb25zdGFucyA8YXViaW4uY29uc3RhbnNAbWljcm9jaGlwLmNvbT4NCg0KRm9yIGF0
bWVsLW1jaToNCkFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNA
bWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyB8IDUgKysrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMjgzM2UyZGE2M2Uw
Li41MmJlYWY0ZjdmYmIgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5U
QUlORVJTDQo+IEBAIC0xNDAyMiw3ICsxNDAyMiw3IEBAIEY6CURvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWRjL21pY3JvY2hpcCxtY3AzOTExLnlhbWwNCj4gICBGOglkcml2
ZXJzL2lpby9hZGMvbWNwMzkxMS5jDQo+ICAgDQo+ICAgTUlDUk9DSElQIE1NQy9TRC9TRElPIE1D
SSBEUklWRVINCj4gLU06CUx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRlc3JvY2hlc0BtaWNy
b2NoaXAuY29tPg0KPiArTToJQXViaW4gQ29uc3RhbnMgPGF1YmluLmNvbnN0YW5zQG1pY3JvY2hp
cC5jb20+DQo+ICAgUzoJTWFpbnRhaW5lZA0KPiAgIEY6CWRyaXZlcnMvbW1jL2hvc3QvYXRtZWwt
bWNpLmMNCj4gICANCj4gQEAgLTE5MjM1LDcgKzE5MjM1LDggQEAgRjoJRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1jb21tb24ueWFtbA0KPiAgIEY6CWRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kqDQo+ICAgDQo+ICAgU0VDVVJFIERJR0lUQUwgSE9TVCBDT05UUk9MTEVS
IElOVEVSRkFDRSAoU0RIQ0kpIE1JQ1JPQ0hJUCBEUklWRVINCj4gLU06CUV1Z2VuIEhyaXN0ZXYg
PGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4gK006CUF1YmluIENvbnN0YW5zIDxhdWJp
bi5jb25zdGFuc0BtaWNyb2NoaXAuY29tPg0KPiArUjoJRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJp
c3RldkBjb2xsYWJvcmEuY29tPg0KPiAgIEw6CWxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCj4g
ICBTOglTdXBwb3J0ZWQNCj4gICBGOglkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWF0OTEuYw0K
DQo=
