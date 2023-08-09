Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99A775067
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjHIBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHIBfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:35:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC21173F;
        Tue,  8 Aug 2023 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691544908; x=1723080908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rtZoBZ3sPv2qJWkRBXbyiYigULB0tBQEU+69g1VKEbM=;
  b=KvP2MWDHKzLMjJVnMY8Q9sZ+Vpa8tQr6NgH0inOLQzB0SYdfer3pkx1c
   n1Qerh3TdNRU5GVqv63GmZl2ejAJvGFuxkJmLMHOP4HEvQOv2yQdpfMe4
   pD3D3U+gNeV2zwx0nevIKe5Mmo4UOJLRA/iF87W++//ozrD+ULPOSD+Lo
   PeR9L+7Va8VschYcyUZA1V233EG6pAEtp4SpEn4OOTu9cPtIKrwEM57Zq
   Li4FGKZwxkMsJ9k+rkn3WaXx5criVrVi29HyqRcypbvk2Tw1CFW9JYFmT
   Y5dXgNFo8Fzjpv4ExF8gj6uF57Yx/xDYtIZJk8/G1tndZnLpykIXFY9QS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351305109"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="351305109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 18:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="761164196"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="761164196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 18:35:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 18:35:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 18:35:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 18:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmFvkjqo+EKP0VARP0RpzVlR9BqWE2X4lvwIt0BZvSs47o7kMxl78NQOaJYLr6iYA7GTq6sBUE4fujWbd52ViLNPLUNqaMrX6sUXMENQRkcbUSsF0sel/BJ35zsgRdOmcgKIcj0vcnI1TQ/cHqV7D6RRTgxluByhuSA+HomxnxxLr55JtsBFTAyhbRtD59+jrmG2ORYPl2h1iLboNby3beiGkcEKU5w8aRi2FqUgHbvSuDqNv82OeEIvd6Uyl03xUFnb3ep6lfA+kli7keOWkAx7atK7UBnaedaHa70tTP0TMBLJmy6wYJDfZ63Uruo8wenaPmw4PQZ853Hft9y13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtZoBZ3sPv2qJWkRBXbyiYigULB0tBQEU+69g1VKEbM=;
 b=Kc1gYHJj73co+KrxkNBlypyyBttJI6HAYNsA0uSkpgkC2UnSf8kuFgFkkWF++hdBXqyUnOanV/UuQ57LICjWpdy4dCydAw8B/8UWVyOsZC3n7+0SSezZK6ye6xELcrLOuQPvbhQQGA7V1gNbaKvhG7mvjhi3wV6jTgeJ9RASj2v5PSCjnqdRSB5MQycGYng5dSppDDwGeYTc7SckcEgLCJgu7RWSh3cbEkHG5lplC+0JTJ3nEzlb3Hx7uypnYuJT6Bd3HW9SV0z9pEy06Z0YRlGHJCrUoYj0BsnZj8DKCix4GE3kWnx43BeSFuPhXY0bYwiafg8AlSXQd1Wh1p6Cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 01:35:04 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 01:35:04 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: thermal: Do not attach private data to ACPI
 handles
Thread-Topic: [PATCH v1] ACPI: thermal: Do not attach private data to ACPI
 handles
Thread-Index: AQHZyjUWYYFHY2DwO0G4zVsI9we5Hq/hLwOA
Date:   Wed, 9 Aug 2023 01:35:04 +0000
Message-ID: <174890f1ff566f229ece61b6fd47f26e9e57f9e5.camel@intel.com>
References: <5703187.DvuYhMxLoT@kreacher>
In-Reply-To: <5703187.DvuYhMxLoT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB5131:EE_
x-ms-office365-filtering-correlation-id: 7185d1ff-3cb6-4ad7-7d04-08db9878db34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nxclhrgxy/2ooHLlsYyLRyAUDwJupe7cZhG9Ol0BEH4Ny8pstHDNmIWYx3O68GFEs+J11wGJLpXjN+6LC9iebrTenCKgvqgE/Fli9mb8pLsUeHeWlHrnYA4qU0zu4XTdSR7Sk19YBhjgH4RwPJcM98NcLrqlweUbrq3gAHRIrTcBYzvvf25TGdM21tcg6n6fJWBLDeHuoA0j7svU7ERxtvDJo0PHEz5UOLYx7F/PunyAPnCOMbDG0KKyPY8MTSlhaIdFyLk6QbY2FNHHYQviez6yfStgJ6vdvdN05wz8+QybvPnKVo4lmzQjOLLok34SjDu6A2uTDrcao7Jh79pMrgADBdqPHwxUhDYr0iusqGkhbCr9TinwBDhywKKDYnYaES60xfi6xbum5Ud0lw2pyx8rlZB8QoJyjrflKMv8hjTSkDRzg9IfTSYw0V6eMCP9jvJ21HCavMWxmwXrqCkSFhYiAdWtgatPsWJotYoIgjXmP3Og1KdiY9KyyumMFtHEsW7rU2w+qJlqpxKWPOxUyDakPjQxOZQ3zP43DC3Wf8TEd0B64RyhsXMt2OfIMFzqBDYOlZl908dZ5RKd4TDt70gchlFxXw3yFa/RLM2YNUQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(396003)(366004)(186006)(1800799006)(451199021)(6506007)(2616005)(36756003)(26005)(6486002)(71200400001)(84970400001)(6512007)(122000001)(478600001)(82960400001)(38100700002)(110136005)(54906003)(91956017)(66556008)(66946007)(66476007)(76116006)(66446008)(4326008)(316002)(41300700001)(8676002)(5660300002)(38070700005)(8936002)(64756008)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ump4d1RGYnVvT2dGWlkzWFZ3OFc3OEFRbTVFaGJZakZ4TUdzdjZ0ZUdUZmRv?=
 =?utf-8?B?a3V0UlhxSTI4a3ZKaE5VdTh3ZnB2aTF3Y2FYTlBYcW9BR2h1NTVaNXo4VXFV?=
 =?utf-8?B?M2U5OE1CeHpPOGRXc1RoWGpkak9paXJ5MER4b1Y4U0xzSFR0NXFGaGt4REht?=
 =?utf-8?B?RE1Xc2VKVTRWTSsyWUhxMUwvQ1BwRmRJTmVmcnJjamdaYytYS1NQN3J0SjRm?=
 =?utf-8?B?VDNwbnl0WlNoanFWc1U2UGYvb3pEZ2tGQXpUdFFvRnAvZHJJMVlsenZ5OFBx?=
 =?utf-8?B?dktCNzJLTjVrVjJ5V2MvejNVRmlMMHgzRE9uL3NzcFNvbnRTNkZkVTB1VDZK?=
 =?utf-8?B?d0o0YWxVNnU0UXNKQU1aeE9LeHhEV0V4b24rNmRaT2xtRTBES2lXd2l4YnRh?=
 =?utf-8?B?NUpDV1JIbUdDckVmeFNKcjkyd1k5Q0xrNkNRSHBIekI2SGhqWHhnVXBzS1Fk?=
 =?utf-8?B?eG1lVm5VN0VtcW5wKzB2T1Z5VUZzcS8yTGhwQkNtTFRxQWRaTkdPWWN0QklK?=
 =?utf-8?B?QkxiejE2cXhWdUlGVmg5UDlYdXVBNkh5ekRBMjgwQlhXM2VVamhWTDJ2OFEw?=
 =?utf-8?B?UG42Y016RTZPbFpxNHdIZnB2RC9tc0RtUmtTRE16TFl5MjR5UmVqL2JTK3l1?=
 =?utf-8?B?WnVvc25INmNhZVhYa1NmUmJoc2thZS9mOUl2OG9ybXFpOGJDVER4SHQvcVov?=
 =?utf-8?B?dVhHeHJwYTVLZUJ3MlMrY0ZVVTRialhKTUk1KytOaEhKeVQ2S1BjSGlwai9k?=
 =?utf-8?B?N3RxeDRTays2VlREQmg4MDkrb0FmSG1sczhzS0hQWWxMVElkVXZKTVFGSkxi?=
 =?utf-8?B?anphWmJLSkVPTjhJMmhDT0F4VHJITUU0TkhBemFZTm1ZWVY2cXE1UytZMGNa?=
 =?utf-8?B?eTFTbjBoTVFPL0s3UCtXMzdmYktaS2pCZ2V2RXNQTzhJbnpCc1RYa2pMRVh6?=
 =?utf-8?B?aEt1cldaemozTjE0eHFPalBOczdMS1I0eXRCUGxIL08yL09NSWtYUVEyNlRh?=
 =?utf-8?B?WkVrWlNYT3ZhczN3OVdGM3lKdnpRQ2hQVHBvejBselFUUHRuTHVoa29HSEhN?=
 =?utf-8?B?bVNDVmtMRzdkTXpLUGNaeVoydys5QVNiMTEvUllFNUxrVTl6Rk1MMGxLKytU?=
 =?utf-8?B?ZVUrV1RvUU02TiswUlg3R3AwYmwyeHZmNTd3T3ZUUDlEU1pWMTRqREJicG8z?=
 =?utf-8?B?anpmcWNlbTRXTkpNMjF2L0pCTWJBVXlFcEZYUlZzYkVjZUdydnRkSFNIV1VZ?=
 =?utf-8?B?NzIyYjdyd1cvaWI3OGgrQVU1dGI3MnVYL1UyMzNMNnNJbHpyRkhoQldVTWFZ?=
 =?utf-8?B?TFdxSy9aenBYWVIya3BRdk5TTU5kMXl2b0I5VFFpRWxTZkpOSFhNb252ZDVn?=
 =?utf-8?B?SU1xRXplbWlDUjhscWRia2kyS0F2Z0h3VUxPVEQ2eGd2WU5XRzZUM1BLSTRZ?=
 =?utf-8?B?VWNPWjh3WlYxRFBVM25NNEtDUEFJcEEwUmgwUW9oakk0K3RTQ2t3am1uaUZ0?=
 =?utf-8?B?Uk1uVTFoRUZrVHQxbEc0RGNKV0VHemNwbW11aVgvVFh2VDVrcVdVWnlWd0Rs?=
 =?utf-8?B?SWY4VTRCSXk0bnNnQ3lHQkVXUThLUTAzLzQ2U0tIblFiakdvQWxaZTc0TVpn?=
 =?utf-8?B?bG9OOEMrc1QzVE1Pa09PYi95YW9YY3h2QzVVelJJekh0alp1TDNJcThGU3Jx?=
 =?utf-8?B?TUUxcDFkd0Uyd096RG5mTC9CbTRHM01aek5DSmt0ODBNYmdXRy81YTZ3V3ds?=
 =?utf-8?B?dk92d2RVeDZlVHQ4eTVKOUk0a01ldnlaUmQyZ29ja3RaS2JCcjE5TkZnWkdM?=
 =?utf-8?B?NmdXTTBwVk4zcEZDQ1hlSjliaHNSTFZZR2gzZVliVE5zNGc3dTNUWnZwbXps?=
 =?utf-8?B?bDVzS016L1B0ak5kekRqM1pacTNVNVZjWnpkR1VNZEI3MmtrVkYxdU8zWG1M?=
 =?utf-8?B?a20za0hYRVZiWk9CeXRXSlNsb3R6alVPYnptTk9WSnBIemMyUTA1Ullack9Z?=
 =?utf-8?B?Y0dpVGxzdXM0SzFsaWJhQm4zOTlZdXZKdTE5VmFBckN6RWs0Z1krbmZGbFRs?=
 =?utf-8?B?TDRzOVNoMnlHTFNJK3ZSc2ZBMWN6QzNwT1pQQUNRUVcvdDFjNlN5Y3FrMzNV?=
 =?utf-8?B?Z2hWU0c0TXFNeW91eXVkcHUwdk85NXFJMElObUpYekRrbFhwb1lhQ29PN3Vq?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4300BFEBA29AF429C7732770A6E5439@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7185d1ff-3cb6-4ad7-7d04-08db9878db34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 01:35:04.3648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVKBp3LCn5S9z6GWNwW3xshauqJBZu4FenSzpYO6n6vRPHn87agXviwjlkjmPf9gLfxmTV+roIWW9DsRwhN4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDIyOjE1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gVGhlIEFDUEkgdGhlcm1hbCBkcml2ZXIgdXNlcyBhY3BpX2J1c19hdHRhY2hfcHJpdmF0
ZV9kYXRhKCkgdG8gYXR0YWNoCj4gdGhlIHRoZXJtYWwgem9uZSBvYmplY3QgdG8gdGhlIEFDUEkg
aGFuZGxlIG9mIHRoZSB0aGVybWFsIHpvbmUgYW5kCj4gYWNwaV9idXNfZGV0YWNoX3ByaXZhdGVf
ZGF0YSgpIHRvIGNsZWFuIHRoYXQgdXAsIGJ1dCBpdCBuZXZlciB1c2VzCj4gYWNwaV9idXNfZ2V0
X3ByaXZhdGVfZGF0YSgpIHRvIHJldHJpZXZlIHRoYXQgb2JqZWN0Lgo+IAo+IERyb3AgdGhlIHVu
bmVkZWQgYWNwaV9idXNfYXR0YWNoX3ByaXZhdGVfZGF0YSgpIGFuZAo+IGFjcGlfYnVzX2RldGFj
aF9wcml2YXRlX2RhdGEoKSBjYWxscyBmcm9tIHRoZSBBQ1BJIHRoZXJtYWwgZHJpdmVyIGFuZAo+
IGNsZWFuIHVwIHRoZSByZWxhdGVkIGNvZGUuCj4gCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25h
bCBpbXBhY3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPgoKeWVhaCwgdGhlIGF0dGFjaGVkIHByaXZhdGUgZGF0YSBpcyB1
c2VkIGJ5IHRoZSBpbnRlbF9tZW5sb3cgZHJpdmVyLCBhbmQKaXQgaXMgbm90IG5lZWRlZCBhbnkg
bW9yZSBhZnRlciBpbnRlbF9tZW5sb3cgZHJpdmVyIHJlbW92ZWQuCgpJIGhhdmUgZXhhY3RseSB0
aGUgc2FtZSBwYXRjaCB0aGF0IEkgcGxhbm5lZCB0byBzZW5kIGFmdGVyIHRoZSB0aGVybWFsCnRy
aXAgcG9pbnQgcGF0Y2hlcyBtZXJnZWQsIHNvCgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPgoKdGhhbmtzLApydWkKCj4gLS0tCj4gwqBkcml2ZXJzL2FjcGkvdGhl
cm1hbC5jIHzCoMKgIDEzICstLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMTIgZGVsZXRpb25zKC0pCj4gCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNw
aS90aGVybWFsLmMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3Bp
L3RoZXJtYWwuYwo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jCj4gQEAgLTc0
Miw3ICs3NDIsNiBAQCBzdGF0aWMgaW50IGFjcGlfdGhlcm1hbF9yZWdpc3Rlcl90aGVybWFsCj4g
wqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCB0cmlwcyA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoGlu
dCByZXN1bHQ7Cj4gLcKgwqDCoMKgwqDCoMKgYWNwaV9zdGF0dXMgc3RhdHVzOwo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgaTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodHotPnRyaXBzLmNyaXRp
Y2FsLnZhbGlkKQo+IEBAIC03NzUsMjQgKzc3NCwxNSBAQCBzdGF0aWMgaW50IGFjcGlfdGhlcm1h
bF9yZWdpc3Rlcl90aGVybWFsCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXN1bHQpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHVucmVnaXN0ZXJfdHpkOwo+IMKgCj4gLcKg
wqDCoMKgwqDCoMKgc3RhdHVzID3CoCBhY3BpX2J1c19hdHRhY2hfcHJpdmF0ZV9kYXRhKHR6LT5k
ZXZpY2UtPmhhbmRsZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR6LT50
aGVybWFsX3pvbmUpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXN1bHQgPSAtRU5PREVWOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHJlbW92ZV9saW5rczsKPiAtwqDCoMKg
wqDCoMKgwqB9Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqByZXN1bHQgPSB0aGVybWFsX3pvbmVfZGV2
aWNlX2VuYWJsZSh0ei0+dGhlcm1hbF96b25lKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlc3Vs
dCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBhY3BpX2J1c19kZXRhY2g7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcmVtb3ZlX2xpbmtzOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGRldl9pbmZvKCZ0ei0+ZGV2aWNlLT5kZXYsICJyZWdpc3RlcmVk
IGFzIHRoZXJtYWxfem9uZSVkXG4iLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRoZXJtYWxfem9uZV9kZXZpY2VfaWQodHotPnRoZXJtYWxfem9uZSkpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+IMKgCj4gLWFjcGlfYnVzX2RldGFjaDoKPiAtwqDCoMKgwqDC
oMKgwqBhY3BpX2J1c19kZXRhY2hfcHJpdmF0ZV9kYXRhKHR6LT5kZXZpY2UtPmhhbmRsZSk7Cj4g
wqByZW1vdmVfbGlua3M6Cj4gwqDCoMKgwqDCoMKgwqDCoGFjcGlfdGhlcm1hbF96b25lX3N5c2Zz
X3JlbW92ZSh0eik7Cj4gwqB1bnJlZ2lzdGVyX3R6ZDoKPiBAQCAtODA2LDcgKzc5Niw2IEBAIHN0
YXRpYyB2b2lkIGFjcGlfdGhlcm1hbF91bnJlZ2lzdGVyX3RoZXIKPiDCoMKgwqDCoMKgwqDCoMKg
YWNwaV90aGVybWFsX3pvbmVfc3lzZnNfcmVtb3ZlKHR6KTsKPiDCoMKgwqDCoMKgwqDCoMKgdGhl
cm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVyKHR6LT50aGVybWFsX3pvbmUpOwo+IMKgwqDCoMKg
wqDCoMKgwqB0ei0+dGhlcm1hbF96b25lID0gTlVMTDsKPiAtwqDCoMKgwqDCoMKgwqBhY3BpX2J1
c19kZXRhY2hfcHJpdmF0ZV9kYXRhKHR6LT5kZXZpY2UtPmhhbmRsZSk7Cj4gwqB9Cj4gwqAKPiDC
oAo+IAo+IAo+IAoK
