Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3DF7D9E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjJ0Qqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0Qqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:46:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F4A10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698425210; x=1729961210;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5APhL3da0NfJtkHVM/K+DfA6jncFpVbL8LXpCDs+o3I=;
  b=DxUNurt5x6hFgxI6T8d1n+TFSeXH7rCeP9I8QwR2ju/TVkpJZ99FSWw3
   bZisXtQ/sswwI8hqVdS2BEPCR8/jW1FWezMImY57Pgwu3Wfnw2oIqgMrQ
   +RA/RuWT1tNq9GueHgmQ9BIzjGxaz+4FhNMkzyluviYHeqvUTsvf3opzk
   +NgYZ9x6Aoxa0zFbE79BQ1rsFzCswQOyzdp508xsC+yQEBAB08XS9FdF2
   puUExr53hwCvPLT5we7hB8vdE2OAo0VIiLG0CpzQEDGp6s6OkiZaoZZsJ
   oEqWeeoS+m84OHYK5jcvSxOb4BsfGepVfgRzjF4CFMTDZC0TbaUWBwP8M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="368026388"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="368026388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="903318442"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="903318442"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 09:44:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 09:46:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 09:46:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 09:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCH4f7e4pmOamPY/NPe3/rlVungDpGzro02py81QbmAnvgB/oFUKwQtwvHmucwZh6kjLhU7GGqU8vcoJFttzHff2sJjZe3ZxqXhqb9kMEL+XENqvuHXCQ1bcXBI2mH5ZeM6w5LlghcMFnjvHZ+dg/hLe5AH7YeQ+v1+1xBOz5XlzInzZs5Ro6KLCyrKIkmeC3ioO1UpZ1q8mUiznPaNiPsGgUu6X0GesAEqMDZ5n29N5Bvne399T0anuVb9GF129NOC1rjfjesR+L5KXcmVn/fPrm7++a609y4qZyr35upXjZ9wJoQL673tZWSHr0H48Pk8mRwBCuEzWY5nEbwZxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5APhL3da0NfJtkHVM/K+DfA6jncFpVbL8LXpCDs+o3I=;
 b=JZqFc2qtp8Ib3s9pVJuIB6coNBIok5HMATz4gUHnMyhCdLskm3ZHjLpGxoCrm/rnBs+AahlVi1eUUeZerpO5wClduEvERjyo/1C6Nm88ib2faDWbCNn1Fzj0zdX1w52krY2yrUmtwuxa7VfVPh2rNO2oev73sBX4fj6yRAC7kglh0Va+zxqMVe2n39uE9GzTvp1IU46+rGn9vUIMtDDQu5OzD4ZcYm8MI1vrLOnP48mCmO+a1stEoCC+7fRh34RgBHIhw7BNrTlBZ4gavYfX9rH0mazy4lhk+ZQO9y5mW+FRs15J1y+v6VItuJAuD2rXg7eFYP8H6rxWmwgkqvWyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 16:46:39 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Fri, 27 Oct 2023
 16:46:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSoD4BaRGvpYEWdXJl+rjaNYrBbOxaAgAASF4CAAozpgIAAAo8A
Date:   Fri, 27 Oct 2023 16:46:39 +0000
Message-ID: <3936d8f9abaf8eba98963a13ad75024931aeb930.camel@intel.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
         <fd2426ee900e4f3a57659f3688c5bb652779785c.camel@intel.com>
         <BYAPR21MB1688E43151404FFB435ACF41D7DCA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688E43151404FFB435ACF41D7DCA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6714:EE_
x-ms-office365-filtering-correlation-id: 2a2038d1-f7ce-4157-d9c8-08dbd70c4a70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WLAW5Eo7eFLqn1u5onTIMq9F7Z9g4unwMy3ScAQ191oCWkIVImBwzGvmA1u0h9wLfcOnLHAt8jYUR1nwCyBHcko2PeTYUi23MasJuVmKVLjW8woH6tsBiW4ElqyIbStCRIDK4nUI7k+ORP4HsqvwbfLgGVZrsnz3qmImlKIAWDgVWV4gwZtw2PI129RxL0v87IHQSLXki7o7JGKAf1ld2Oy2ESFekLbbiwRpgHMHNUtgj0y+OqmGfEKTyx9drpFmW1Gtw9pSVnXhmq2R1DHiHPWtFC45olQgh0RRYZ0zFHTZMIvR82tmZObFjIDdz10lw/163/rukn/9A/pAuRA/9F5uAGwznT6UE/ZSReR42XWaudeeR1EIWtETRegc4BA1v/lybq7vXT8PyTt1gGk3DEnsnqiPwdoZy2y7INTRsK4xCYsNJqs3wb7O+KQEVjQZ0TJwYgYVeCPt07HVgfgkZIrHj4bNbUOCV2i+m+/fBijvkSTj5k5lQKDCPWM/lS+Ty/0Ao7ABeswVLuF77vTrurOMA4y4UjQBQnkwCWMa+bdqzo1wafyRb+Y5kplD5kxFhfpcinzuJpMERpvDTJAtHhjY9v3TX7Wq50pdUgIiIQ4drMI4F38FgH8CoSw/xib1M9dLUdWZU7l5i5g5zh6C1agdLUazfeR/55xi9OjgTcyXGCHpTqYqTFlhvGE9v+V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(921008)(38070700009)(82960400001)(83380400001)(7416002)(4001150100001)(2906002)(122000001)(38100700002)(26005)(8936002)(2616005)(8676002)(36756003)(71200400001)(66476007)(6486002)(5660300002)(6506007)(91956017)(316002)(66446008)(6512007)(110136005)(66946007)(66556008)(41300700001)(86362001)(76116006)(478600001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WldsQXpVWXI4VGcvTHpwWC9NVVZScVJWZUFRYXNwVTVrQk9pc1UrZHBnakdl?=
 =?utf-8?B?VGdJRzV1NXZ4V2V1bmRNQnUwVWZZSjVUWFo1OHVGV2pCS25QMWRCU2xpVmJn?=
 =?utf-8?B?Wk55bWFIb0F2WkR6Z3J2Qkg3eFZZUDB5YTlhWFlSMjhURXJNdFU5eTFhTldZ?=
 =?utf-8?B?QVlrc1hvc001VG1KNzVwSjRheFR3LytZdTB4UE50QWViNnJNOFlycjdXWHBD?=
 =?utf-8?B?cC9ES0hjOGVWS3dMVEdXT0pINkpWcUtYSFJMK3ZCNnFKZWdYUTM1clZaeHVt?=
 =?utf-8?B?MzVoRHBoeWxxRDE3dDEyZ2RGY0hPWjlEY0I4UWxhclM4NktOdzVZYkt4UGdT?=
 =?utf-8?B?eE5qdXZkVnZUb1NBUFluZjlxTmJYT1VieGYxVG9OMWNGOElPKzFIaEFqRTVv?=
 =?utf-8?B?d3VsVGpWd1ZKSk9kMmg4N25EeGFscGQ0RWY2Z3REQTlhTFdUNFhFU3pNTFcw?=
 =?utf-8?B?a2thWWl5d2RNVjF3T1R1amo4NlplZFh3K3RXSHo4YlY1OWNWWXFVYXBoOVZU?=
 =?utf-8?B?ZEZxT1R4amwzeC9zNFBTU2c4djJpSVZVeC9TUCt6U241U1V4RFQ5Z1l1dDBr?=
 =?utf-8?B?Q2o0QzQ2TkxTbGhqZDlYcTRoalV3VWNkWGgrb0dQQkhwUkZyZGp2TVJZNmtt?=
 =?utf-8?B?YTFRcFc2NUxQSEgzT3djWkFIRTNjQjAxemoyeVdrUnlsQ253cm0vbGVOU3hP?=
 =?utf-8?B?Ym5wdmw1S3RlNUEzaEVuZTlKVE9KMVhBU0NweTJHclBhMTc5b1loZ3RYOUNz?=
 =?utf-8?B?dDhaU3dJaUVyS2FFMHd6WTZtQ0lyWHZkZzJJSkkyY1JnallnMnJQaVZHdTdx?=
 =?utf-8?B?UlVUS3YrMUJveUs5TDBqdXhCcDFjOGhjcnp1cERucW81YzZoR1VuaURuSlFl?=
 =?utf-8?B?dzAyRzh6dU56Vkl2RnI5VnlESjJvWExUanplSEhremw2SkE0cnAyY3JyQVB1?=
 =?utf-8?B?dWhRV3FMc0Q0TFNEa05NcG1Tc3Z1S3ZvV0MzVmdBU1dRaGJsZ3lCTUtnbHF2?=
 =?utf-8?B?L2l2b3plYTNkZm9YQWFxalZSdEVUK05VNVN3K1drYXJmdjJPdWYxaVZ0YStU?=
 =?utf-8?B?WHJud2ZBN0o0T3VVV0lqTEU2MFphSDBGNGRRd3Q2ZVdVdVUvQTBiQTAwSmNa?=
 =?utf-8?B?TW4wMSt4SW4rdzNqazZLTjhsZkhxN0FMUHFZZW92QW1abHB1cEYxbEVRREgz?=
 =?utf-8?B?VDErMU5jUWpvUDd2LzdLbFVtOUFZRHUrS2VoUG44U0ZrWWtkUGZlZEFoNHFP?=
 =?utf-8?B?SDgrcVBkZ28rZ0NBQWlqdkRBRUREWklGNy9kenQwWVk4bHpndnlEUG05dHRk?=
 =?utf-8?B?OU8yWW52QUpLQ1RvL1F0THROanZKcklabGxSZGdPNzBXNFNXcVlwdGJjY0RL?=
 =?utf-8?B?Nk9ra2xvcEhRR0tza0NKNjQ3SmVBL0tuRUhoVDRHNEFFRzIwT0NoN294TWZG?=
 =?utf-8?B?cmFBTXRYUEpoM3hDRHpNaTQ4SUx1WVRnbTZxdHMvaE9iRzRYa0kyRklObVpp?=
 =?utf-8?B?QnVYUzRMQnFPV3BVcWdTbmdSWFE5YU5MMEI2blVROUVtZ3lKTGhPQ2hqa0I2?=
 =?utf-8?B?ZElxNkV0T3pBQmV6aDhtTVJpZ09FOHIraDNzTU5rNTNNa1lDekM5djdFWFFm?=
 =?utf-8?B?azJCUlErMGI2WjBQQnloTThxVTVxSlNWdHJQUzdTL0lyYUIxYmtqS0JjaVVZ?=
 =?utf-8?B?Mi9FYThoMURHOW1hZUYydHRtS3pjSTZISW1wbWI5VGRXalcxd1VYMWZJdUMz?=
 =?utf-8?B?NGxYKzVpMU1rTHowREwxLzFjOXpXcVJYaGJ5Rzl5N1dnbWFURWJ6OWV6WmRP?=
 =?utf-8?B?blhHNGNMcis3cGhlRXQ4WnJ3L3c4NjBtTTg3UFhpZWlFeDhWaDZaQzcvMVpj?=
 =?utf-8?B?UkVES2hUR2U3ek1WNmFpYmMrck5jVzRUenFsekRXQ2ZYYmhlTlN6ZWdrYVdj?=
 =?utf-8?B?WGlicW9BMmJMWkNvVXQxWnNHUUI2UXUvZVFtbkRHSGhzejJ4T0RiQm5MbzZz?=
 =?utf-8?B?N1FFOXBFYTBpbk5VblVsVFRKYnlSOWhNL1BTSTh6cXdWVnVZYUVaWUY1VXVO?=
 =?utf-8?B?TjM4eUVERWRPbGhaTG5iYjR4RWNRcStad0J3bFk1UlByZGRFTnlSZEFpVDRS?=
 =?utf-8?B?YmcrSlQ3N084TUlycjVuSzFQZXZaVm1zMUZWUDZibFFCTU5jcFliNmZqM05I?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C6D0FB17C328D45885DCA0DD453CCCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2038d1-f7ce-4157-d9c8-08dbd70c4a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 16:46:39.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPLRdPhYsfBUDqmVKW990EMfFYwNyuCmwcTWN62pwxr0cgtaFJo+oGmSSj/YhWaM9Ch4+5VhbfREnaTxfMINAqVovcwpv5diGiL6zKFSmIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
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

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDE2OjM3ICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgp
IHdyb3RlOg0KPiBXaGVuIGEgY2FsbGVyIGdldHMgYW4gZXJyb3IgZnJvbSBzZXRfbWVtb3J5X2Rl
Y3J5cHRlZCgpLCBpdCB3aWxsDQo+IHRha2Ugc3RlcHMgdG8gdHJ5IHRvIGdldCB0aGUgbWVtb3J5
IGJhY2sgaW50byBhICJnb29kIiBzdGF0ZSBzbw0KPiB0aGF0IGl0IGNhbiBwdXQgdGhlIG1lbW9y
eSBiYWNrIG9uIHRoZSBmcmVlIGxpc3QuwqDCoCBJZiBpdCBjYW4ndCBnZXQNCj4gdGhlIG1lbW9y
eSBiYWNrIGludG8gYSBnb29kIHN0YXRlLCB0aGVuIGl0IHdpbGwgbGVhayB0aGUgbWVtb3J5Lg0K
PiBJIHdhcyB0aGlua2luZyBhYm91dCBob3cgdGhlIGNhbGxlciB3aWxsIG1ha2UgdGhhdCBkZXRl
cm1pbmF0aW9uLg0KPiBJcyBpdCBiYXNlZCBvbiB3aGV0aGVyIHNldF9tZW1vcnlfZW5jcnlwdGVk
KCkgc3VjY2VlZHM/wqAgSSB0aGluaw0KPiB0aGF0IHdvcmtzLCBhcyBsb25nIGFzIChmb3IgeDg2
IGF0IGxlYXN0KSBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpDQo+IGVuc3VyZXMgdGhhdCB0aGUgZ3Vl
c3QgUFRFcyBhcmUgYWxsIG1hcmtlZCAicHJpdmF0ZSIgYmVmb3JlIGl0DQo+IHJldHVybnMgc3Vj
Y2Vzcy4NCj4gDQo+IFNvIG1heWJlIG15IGNvbW1lbnQgYXBwbGllcyB0byB0aGUgY2FsbGVyIGlu
IHRoZSBzZW5zZSBvZg0KPiB1bmRlcnN0YW5kaW5nIHdoYXQgc3RlcHMgdGhlIGNhbGxlciBzaG91
bGQgdGFrZSB0byByZWNvdmVyIGZyb20NCj4gYW4gZXJyb3IsIGFuZCB0aGUgcG9zc2libGUgb3V0
Y29tZXMgZnJvbSB0aGUgYXR0ZW1wdGVkIHJlY292ZXJ5Lg0KDQpTaW5jZSBJIHdhcyBkcm9wcGlu
ZyBmcmVlX2RlY3J5cHRlZF9wYWdlcygpIGhlbHBlciwgSSB3YXMgdGhpbmtpbmcgdG8NCmFjdHVh
bGx5IGp1c3QgbGVhayB0aGUgcGFnZXMgaWYgc2V0X21lbW9yeV9kZWNyeXRlZCgpIGZhaWxzLiBB
cyBpbiwgbm90DQp0cnkgdG8gcmVjb3ZlciB0aGVtIHdpdGggc2V0X21lbW9yeV9lbmNyeXB0ZWQo
KS4gU28gdGhlIGtlcm5lbCB3aWxsIGRvDQp0aGUgMyByZXRyaWVzIHRoYXQgdGhlIHJlY2VudCBI
eXBlclYgZm9jdXNlZCBwYXRjaCBhZGRlZCwgYW5kIHRoZW4gd2Fsaw0KYXdheS4NCg0KVGhlIGtl
cm5lbCB3aWxsIGFscmVhZHkgYmUgd2FybmluZyBhYm91dCB0aGlzIHNpdHVhdGlvbiwgc28gd2Ug
YXJlIG5vdA0KZXhwZWN0aW5nIGZvciBpdCB0byBiZSBjb21tb24uIEZvciByYXJlIGNhc2VzLCBp
dCBzZWVtcyBzaW1wbGVyIHRvIGp1c3QNCmxlYWsgaXQsIGFuZCB0aGVuIHNldF9tZW1vcnlfZW5j
cnlwdGVkKCkgY2FuIGJlIHNpbXBsZXIgYXMgaXQgZG9lc24ndA0KbmVlZCB0byB3b3JyeSBhYm91
dCBoYW5kbGluZyBtaXhlZCByYW5nZXMgcmV0dXJuaW5nIHN1Y2Nlc3MuDQoNCkknbGwgdXBkYXRl
IHRoZSBsb2cgdG8gY2xhcmlmeSB0aGUgaW1wb3J0YW5jZSBvZiB0aGUgUFRFIGJlaW5nIG1hcmtl
ZA0Kc2hhcmVkIGluIHRoZSBndWVzdCwgYW5kIHBvc3QgYSB2Mi4NCg==
