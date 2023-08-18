Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94723780B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbjHRLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376738AbjHRLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD7E5F;
        Fri, 18 Aug 2023 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692358295; x=1723894295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hTOgqnmpx/O9SQauqemoT0WPfveqY7DaLk01jcOeKeM=;
  b=bU9C4yIuhJtOiehJtFqdXGLvpueg73+pLovAloBCoZerRRhcv56cFjY7
   dqCQiAMjoewnJzbCnQJgikUY+WhC4dimxQUNoWOaaIIaDqb8GvoikCyoW
   5RtXwH7/0TurC46wAkL9FHKgm4W7iR1Yf2emzPb8I9j0+Kl/DslgNkzS7
   FlHRLtqCosmmnI4RxT6S1qkbe32IizAJt4wv95gQmxReYs5evIv2rS7+f
   cDwX1tQEORPuI5cU5HkmwkbAGXhuFYzHKsMSJbV3iWWWVhl+1gREbn9je
   69Sap8deYJYv/ARlM2qQxo1xwb2h4Oz1AUa2ZHIqZ2auOZAhMW3W7s1gg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439461365"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="439461365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858654990"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="858654990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 04:31:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 04:31:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 04:31:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 04:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpDsK5N6GCT/oukRPD5QmAfCDnJNHv+AS3ItmvTkOzV/NNe61BCyMDh3RMV5Ao3t+jo+4w2T1DS3ooWBDbiv6/HmtTI/LFPR/56WrlkZCMvoxb7lBbKTd+fQfPKx9sicd2Z4HfgT4YRUAzvSHzmTY/Kcnh15/e1MeJcERZm/LLYDl9wnQiNoFMrHCIvR3BOagSAMqxOlWSmoObC6IqIAvfuNCLaAFoXYJSqDT4BfjRCDAJnizcn1UF8ETrSXtPa1BPpYJhVt8LM2UbIeisgizO9K9stINVlHb8EnOBylS1VtuDc7FZMgSqMQfHfYcSO3wzdCJutDpw9t009HmSYiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTOgqnmpx/O9SQauqemoT0WPfveqY7DaLk01jcOeKeM=;
 b=Fls1Ma913Dp672VV7LoWpTr1g8KcCNCw9VDfVCQ281YkjYgKsoW/302N32AZtqUdxEpxzf2qR3oUpwnvbg4ZATvWOD1JqAuYwKFIUeI6LxrFqwldnYzjWDWa2MzkaZwHXsU1NZA8fokbSX1IH6rS6i5GKRn6mH14WWZatTkz9tPiw2bpGPD/Fn9Lsh65T11jVQ9sWPygqNMUs8xvba3I+9OXf1J1o3APySOCrxfQXJgSb7xH/G99P+xcpEeMIpL+xjc812dYGrPhl05vovJZFJGu8abdv2cYxze22VKQyuCivJ23GypbYrF/OQAceOih8lfEcKgsbIG2Gcih6xZOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:31:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:31:31 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5/8] selftests/sgx: Include memory clobber for inline asm
 in test enclave
Thread-Topic: [PATCH 5/8] selftests/sgx: Include memory clobber for inline asm
 in test enclave
Thread-Index: AQHZyi8fQxM69z2+3EWW+IhzI1tCxa/v+q6A
Date:   Fri, 18 Aug 2023 11:31:31 +0000
Message-ID: <013cfdeb959079ff7b41bc0509b1bcfc4f1aea8a.camel@intel.com>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
         <20230808193145.8860-6-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-6-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB6851:EE_
x-ms-office365-filtering-correlation-id: 742478cb-5f7a-4508-734b-08db9fdeab6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppz7O3/K1OeqjpKYaHIsCLEEZAuD/2mlq0Bi1SuzXQ+8oUvG7ktIJeq2TmOSmdOlVHR6n3UJeZhE1W6eT+DZA/dC550O8pgC7VKlZkgbSFny/74TNTtmsLiVIyNETsma1TRYNPX9IYksVAUOLWTjCIHogH6h55ToY0mNr9GnHgcsbiAxCsQYAnXocEMxWD8kTIpXxwtEzQnfliChmGeApwK3wdAl3fwomdiL8x6Z2J3qqqgUoGZLBKljqo3VCwjCECoyvMBo8N4g3yosMQ0/6mbhlHNNBBzIrlmebcXMimHODnWauDX+yteg8MHcq2F5kKoXdWCQBTX5G0gbwNuiu4BVYRkBADoBsX1Iv6pGItII7rN+mDSK/gBU91x6xQ0SKm9suCv4iCeYtL7XxsmzlBu1fASMr4gC48vzGe8YDx4Jt6w6C0GhTvsRRJnCCt9B5dExl3n2gF/p23oenf7eZwc+xBJesv/t1jrNwXx5A5PnpuU2sQlyXwS1k8ZfVcKXRGXfj9hJXGE5H6A4R5yGvTvCnO/EEryA/nNA36m0BLSK3p5ACwFBKF2u4uO+dVYPCqFb1+PC59ejkciDUOQFnc8ICMrrcXoA4BurXuuvi/u9I7h+WyXse29uh2dlOpRE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(36756003)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6506007)(71200400001)(6512007)(6486002)(2616005)(122000001)(478600001)(76116006)(82960400001)(66476007)(316002)(110136005)(64756008)(38100700002)(91956017)(66946007)(38070700005)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkhiai9mcGs2eVdxZVI2VU1RZG9KQUNVUzFncGR1a055dnNCc3BGZ08vbHBY?=
 =?utf-8?B?YzVzbUZPZUg0QXZiOE1LSSsrWWIyakZkeTJ6M0lTSDN5MlFBbGljaXpScHpL?=
 =?utf-8?B?RmE1MWY1T0VlcEpXekJOdUxiZm1mRGptMlh2cjF2LzE5UjZyZWFKUGF5RktG?=
 =?utf-8?B?aVRVR05oU0ZVMzcvTWs4bHZPemZnRDEzbndIMEcrRHZlY3hOQ0FwcWhvOTU5?=
 =?utf-8?B?Nm43NDhlRThEL2NEUUh5dmlZWnNHU1VSQVJpRUR3U09QYzJxSW9MUTZINndm?=
 =?utf-8?B?K1dkTUtRSWVOYTY0b2NrRkpTS0I2Z0Y5SWVvV3M3Tlc2TXE1cFRwbnRhVkM2?=
 =?utf-8?B?clV2MkJZL2drbUdHVXNHZFJGSGN4OG40azE0a1c4QUlnRkZ4eW8wb1M0ZGdO?=
 =?utf-8?B?aUovZGZFRWNUMExQZ3FQUkRrcDdwTXhWWnRkZ1gwSzdlc3JrLzJ0aFRMc3Y2?=
 =?utf-8?B?SGJwSzdRczQ1SXhHWXV5Z2hmMVVrSUNia016UmVkZzQzdXl6QVNMOHBrNGJF?=
 =?utf-8?B?dDFyOTRyK1FjV1FzYXRmUUpXdHhvZlVxaFpsdElFYjh1cDlKdXNEREovMGQy?=
 =?utf-8?B?K1V0TW5Dd1R2azcydmhDa0N4ZVZwUWM3dEdtWk8waElXbmpLTm5YbFQvMEJG?=
 =?utf-8?B?U1diM0VRTlVkU1poUWxDeW5NOUoyZTFIYkJ3Lzhab2UwU0I5VmJoU2hCK2sr?=
 =?utf-8?B?RzFXcEl0cjBlQ0pRNTV5NXF6alJObXpBNEhiQzJoVWU0RjI2NmRTSUY1aUhW?=
 =?utf-8?B?VVR1byticFAxN2FOcnFSTlRGU1h3WWNCK295b1NoVDV4blhQQjJFQnBTVE1J?=
 =?utf-8?B?MTVJTm9Ia3ZvMnhZQ1g3ak00YzNWMzFFZ0ptZmo3ZDgxYXZRZytBUTdkcTFI?=
 =?utf-8?B?NWdWb1BHeGZMYzJMSFV4VGZPZWlsWk1BWERYaDNVVFNRWTBZbmw2ZWZkL2hw?=
 =?utf-8?B?VzcyNXh3QklZeU4vcDFuUEpzZ1FPZmpPajN2bTkreW9JVzdkWExvdndESVhw?=
 =?utf-8?B?S0RDemxUaXJERWRJUXpnY0ZzTytSUUdCY0hXL09OTVM4TEs1SExDanZJYmp6?=
 =?utf-8?B?L2V6Qyt1UThjRndsNUZ3NklsN2c1WTVZNjZQVGRzZXR6OHRzcUpXSktjbTNt?=
 =?utf-8?B?QjFLMC9qSi9yQjZ2N0NkaWpWeTEyNGdSNENqRTFhanRzd1JPbFlCODdvVUpF?=
 =?utf-8?B?aEM5dU85WlIvTWhwMFlKVVZRcjNwMUZCSW5oTTJlSGFQS0ptREhQT2R2Q0M5?=
 =?utf-8?B?ZFVWZkIvNURTNlViL0lCbmtackxJY3NtS2h2b1hqdS8zVGd2SnZ6WTBRT1pG?=
 =?utf-8?B?UUdLbFdyR042a1phOU5FUlVSemkxYUpwVHNuZkxnbVYxMVRPdks0dlhTSmw5?=
 =?utf-8?B?T1NTS0VQSzM4ZDJoOEV6dktIUHgzUHJnRXRYRTN1R1RpZFBwMTg2b093VlZY?=
 =?utf-8?B?SVc3d0ZSVitFNDRDVDRqSTAwK203YXVKYTJoR3psbTZ3UUhWRUdRcFJ4V0Np?=
 =?utf-8?B?aUltZFp3RlQ2R3RLQ09hOXcxeTNKZ0t1MU93LzBSc0ZRM0RzSklneDVjd1Nv?=
 =?utf-8?B?ZlMzQXZVZmVEeWZGbGRmQXRwSW1tQXVOUk9CeDFrYlVKc084WkN4cnE0Rit6?=
 =?utf-8?B?ZThBMHBsZFNaZkVicEVCSVYzTG92bmI3VndzNUV2L2NXUUVWcFA0dU43alNG?=
 =?utf-8?B?K3VGaitZOVdKSXBWUW0wdTNKaFZvZU9UeWQ2cEVQcEdES2hjYWpBQkluTVRM?=
 =?utf-8?B?bVNaaVRyZEtzUS8yejRNWVY0eWY4RUJkNW9yeUttMzVyRzkyQnJ2bXN5OVVk?=
 =?utf-8?B?S2ZEalorY3g3bWc4c1pGanVXZUVBTjJxR05VNGxMMXFuMWtMOVBEQkxaUDRB?=
 =?utf-8?B?Z1h3OGZjRnNWaFVZRnpSVWllUjhKRUhXb1psZk9QUkNvc09TV2o3R1piejd0?=
 =?utf-8?B?bDZvaHpzK3l0WG5NL2N1M1FsSFlGdVBBQlQzeHlWeEw5aXFCenczb21Ganln?=
 =?utf-8?B?SW9ueE5DVTJ1Z2lIRXNGRVo4NjRmRHJjVVB5dVZBa0lrTVU5MUp1b0h6ZGVS?=
 =?utf-8?B?eWtwL0ZNVFhFQno4d0wrVFRjMWlrVy9qTVRBbG53M3NVTXk3a0VTVkcweWty?=
 =?utf-8?Q?TBCiME+trxoUtmgvKL8dPvIet?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E6DB78D165C742866B04E58254732E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742478cb-5f7a-4508-734b-08db9fdeab6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:31:31.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ez0F+izAwKe/dvHkdeMIBqpD5HVRFqX8xJWR3Y3cV0s96llySH/cQI2ZRstTDLXNf2w7sveIY3OEq4nttk7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDEyOjMxIC0wNzAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEFkZCB0aGUgIm1lbW9yeSIgY2xvYmJlciB0byB0aGUgRU1PRFBFIGFuZCBFQUNDRVBUIGFzbSBi
bG9ja3MgdG8gdGVsbCB0aGUNCj4gY29tcGlsZXIgdGhlIGFzc2VtYmx5IGNvZGUgYWNjZXNzZXMg
dG8gdGhlIHNlY2luZm8gc3RydWN0LiBUaGlzIGVuc3VyZXMNCj4gdGhlIGNvbXBpbGVyIHRyZWF0
cyB0aGUgYXNtIGJsb2NrIGFzIGEgbWVtb3J5IGJhcnJpZXIgYW5kIHRoZSB3cml0ZSB0bw0KPiBz
ZWNpbmZvIHdpbGwgYmUgdmlzaWJsZSB0byBFTkNMVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpv
IFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+IC0tLQ0KPiAgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jIHwgOCArKysrKy0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gaW5kZXggYzcxZGZiYWRkMmQ5Li41Yjc1
OGVhZjgwOGMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0
X2VuY2wuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMN
Cj4gQEAgLTI0LDEwICsyNCwxMSBAQCBzdGF0aWMgdm9pZCBkb19lbmNsX2Vtb2RwZSh2b2lkICpf
b3ApDQo+ICAJc2VjaW5mby5mbGFncyA9IG9wLT5mbGFnczsNCj4gIA0KPiAgCWFzbSB2b2xhdGls
ZSgiLmJ5dGUgMHgwZiwgMHgwMSwgMHhkNyINCj4gLQkJCQk6DQo+ICsJCQkJOiAvKiBubyBvdXRw
dXRzICovDQo+ICAJCQkJOiAiYSIgKEVNT0RQRSksDQo+ICAJCQkJICAiYiIgKCZzZWNpbmZvKSwN
Cj4gLQkJCQkgICJjIiAob3AtPmVwY19hZGRyKSk7DQo+ICsJCQkJICAiYyIgKG9wLT5lcGNfYWRk
cikNCj4gKwkJCQk6ICJtZW1vcnkiIC8qIHJlYWQgZnJvbSBzZWNpbmZvIHBvaW50ZXIgKi8pOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkb19lbmNsX2VhY2NlcHQodm9pZCAqX29wKQ0KPiBA
QCAtNDIsNyArNDMsOCBAQCBzdGF0aWMgdm9pZCBkb19lbmNsX2VhY2NlcHQodm9pZCAqX29wKQ0K
PiAgCQkJCTogIj1hIiAocmF4KQ0KPiAgCQkJCTogImEiIChFQUNDRVBUKSwNCj4gIAkJCQkgICJi
IiAoJnNlY2luZm8pLA0KPiAtCQkJCSAgImMiIChvcC0+ZXBjX2FkZHIpKTsNCj4gKwkJCQkgICJj
IiAob3AtPmVwY19hZGRyKQ0KPiArCQkJCTogIm1lbW9yeSIgLyogcmVhZCBmcm9tIHNlY2luZm8g
cG9pbnRlciAqLyk7DQo+ICANCj4gIAlvcC0+cmV0ID0gcmF4Ow0KPiAgfQ0KDQpSZXZpZXdlZC1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
