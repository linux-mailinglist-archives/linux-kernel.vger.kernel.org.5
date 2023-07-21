Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5375C569
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGULHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGULHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:07:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB344AB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689937426; x=1721473426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KGKffzYIg0jyUsu5iY8zQ1C3d4akZ6HTTdVzrKHdtcI=;
  b=YDOcHRWto5MCEX+m0QXgFvGBPi3D/Isy9IFf4xCnm/4ngYgycCarf4ch
   oXL+2+/bLloqL3DmiJ/Bj3XN64rC8WqbMvVUfmkRtkx2zwH8f4lH8omfU
   IysMBUYbeGSgXy5/L7BLZ/EtBRcgOFLbB7RD1VhEcCrulXvlZVPqt6XUH
   wBHnjC5+7WYOVHPGQMzE5Jq7hYqf7+aqgX3ZUHgdepkA/P9j61cynVzpE
   cWNyX7w/RgLmyp9IibhLCSv558/E9L8CJp4jQ1zSgqTrqQhWfQZVEjTRv
   c7RxzK/GOSCG/iErtiJmJOy8khyPcqyDviqMn/IXf86OZMAtzU0gJ+XuM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356980305"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356980305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848793179"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="848793179"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 04:02:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:02:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:02:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 04:02:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 04:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGSySyCdPMwcxcsKFRL9te6EPQyKjS3qSB96bsgzazz2QTmlLpxPLKGmxPAUsn6CATjdhFPSFF0jkxCXSxtwUZ37A/fIPgFeBEkAnLGyHQ8nFPShgJxUBpxKkbJbUg5VQYViCE7NfA4/0juS9dhBp2YM336HEuucZ9uUaRgjh99r5ohFMsdoXw2i673tyqhiLhj9n6QXs6dZLUd07cud5Pg3+lk1amRyUIKNZ4bFPgkQNwq6ZNeyWrZa5UruBmTtzppl3IuTAMQaa2oWbSBEqfDFVBaDh+XgYHejZxuxIvMpld3FFO0+lAWhlNJsfc0mliPBWdEWpb3G/bpH1Jppfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGKffzYIg0jyUsu5iY8zQ1C3d4akZ6HTTdVzrKHdtcI=;
 b=D0YvVABVm5GLHrONPt/VoP+brERfzq2crmamjJU0a4iSvblfsgHp6jU9B1kclOAE65Pn8LsgN7bKfWmayKZLHoMOsWnO/Et59wiv6Q5zwbW6DNoOhMBI8LyyP8JkzFLdNm1q0m7p3pmB8WnAh1pepVeUjZzg2mHttHD1wz1lZJsxkYR5mQCX4STBur0RF3LWfZ4HfOMQvJ4QdWPqudqrCg+9lEDNVMU+1aSTXuKX3GFdTgKstcEM1zr+tMjtzWwdVJjYVUU/OdMASPicfwwO4/OgB/sAI6J8EHoo5s5YePXaCVQsyMI1qPuQQFMYFQTZG6xgIGPoPfFhkD4ryGcq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 11:02:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 11:02:50 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZuwSXJzY29NdU9UyvS7MM7BQC1a/CoqcAgAC5BYCAAIK/AIAAMU+A
Date:   Fri, 21 Jul 2023 11:02:50 +0000
Message-ID: <2c1fba82f9425fa569cdf5c2aa22a7b1159cdafb.camel@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
         <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
         <a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com>
         <20230721080618.GC3630545@hirez.programming.kicks-ass.net>
In-Reply-To: <20230721080618.GC3630545@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: 20b3bfed-f51c-4650-07f0-08db89da0659
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UrPwfOqnPu6NBqb9qsNWHN0jYOIy1OZG6WhvuDndC6IxFV4nEzaNT5orT/Mt/C2k9aGWLjmWYYq59j3Mv0XNnl+nWvOPPni//1JPb08YdXlnHwNUDZPZAe6rcSj79AmP/6VEaIzUtrCU3h28a+KIcVAajCPPDtC7JNTG7VRNQ1/N6DGwrla6PBN+7azTuD/kJwwV0pFg7ubCBcc4ssYIe1D8ydRyY2C6phtlhh0zIMSmYHsjkuYLory2CNgmYJClvKpN7Ib23bk5ISkE3rZe5lwgGcytUJQ73E+oGgz8npz1FoAjFktNUfjaCMhKtRvM7ThzqcmsOJdjINjKX0JbrPoNxMPGsdlOqF99bj2CvFExxrk207St1m6Yj6K6kjxWBqoa3X/L4sl+GoDXownK4JKQWw/JTkB/sv/SHnKfIXyO3/GC66OC6C26IOXM++lNxJJC1nwswpS54La174wiTSf2CMl64DcE5SUMlxjZHyTUEPh6mIZvLzxvnhu6fmRbzmWrrzJ5KT5UpxHy7uBKfaPxT3AO6GjIvDFFeXGT+CKuYDZrOXm6EZpJd5UnUU/AtV5qU1IzaF5aPcDWOeOFaAMm+kbtpdRopsgavpaNsSf5epuUt4nXrEQvrGNJWWN7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(2906002)(83380400001)(2616005)(38070700005)(86362001)(36756003)(122000001)(82960400001)(38100700002)(41300700001)(53546011)(6506007)(6486002)(66446008)(66476007)(76116006)(91956017)(66946007)(6916009)(71200400001)(4326008)(64756008)(316002)(66556008)(26005)(186003)(6512007)(8936002)(7416002)(8676002)(478600001)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmtvYStqM1hqdkJQZDVDREhtMzNzZlNpWEZWeHdRSzdGK0ZZbkJYemwvQ284?=
 =?utf-8?B?U05tRDVQNFBWZkpsdXc3ZzdhRzQxU2Z4NW9ubS8zSzRvbExMNWtlaVRvdXRU?=
 =?utf-8?B?UkF0YU9hbEFCL3AvbkFFYktyNDF5YVQ1aXFXMTBhZ1BzZkg0VFQ5UFE1emg5?=
 =?utf-8?B?Y2c4UlZSTHNBbHpPM2o5Tkx1dC9nRVNKakNEZFdnSGxHOHZOTHo0b2RtREtl?=
 =?utf-8?B?djFrR1BpUUx4MUVHZ29JZE9OODVXZml5bGQwOGY4UkMxTlJVZU9JaW54OTBo?=
 =?utf-8?B?R2gvSG8rOHJHalpNazlTWTYrQUYxRm9yNjJaWmNyYXJSWTMxWGt4Ujl0S0gx?=
 =?utf-8?B?Z3lNQVE5Ynd0bTlkdGJBMFVqU2ZOY05tejN0Y0tOY25LTGE5M2dYdk5mdVMx?=
 =?utf-8?B?VkdEVVFkUTJHNkR1NjJQMVVWZXJkbWd6RHRLVDViZEhlaFJmcjJzTUNZTHBD?=
 =?utf-8?B?em1JVDZMZ3NWOW5Dclg0eVovWlROVnd1YmdVNXkwWU5ma0VXMTY4VTZ2Q2tO?=
 =?utf-8?B?a3BEWUNncnBhb0ROT05PY1ZjaVhMSlFKVWsxY3A1aG4wRkdZNzRtZzIwQmlB?=
 =?utf-8?B?V21WMFpqcldSQnR4bWFIMXQ3Lys3OW9ZOEIrUkRFSUFBWENodHR0M05IVXl5?=
 =?utf-8?B?R3ZwSTdRVUE1RHBBZklQNmx6TFhGaWdVVVpicjFoa1Vtd092dFBMNjR2U25X?=
 =?utf-8?B?T1pIek1LMkZ6UVNPY0VwbEdHK3RFdnhVdEJwWkcra2lneGUxSExwdlFiTFdt?=
 =?utf-8?B?ejQvb2liQUtiSDlUS2k3SExZWG4rbXUwdUt0ZjdkY2hKcGhIM0JOdlcyUjBn?=
 =?utf-8?B?NlR4MG0vSFoyeWpwQWdzRWFTcDM5UzV4YkhNanpSdTNMMmQ1MWtxVDBDWWV3?=
 =?utf-8?B?dUxEbDB6bHNSQUhzVUR0aFdpZ3NDaGdaeXRGUDQ4ODFpSVA2azFXTlU4ZzNT?=
 =?utf-8?B?aEJ3RGxFcWU4YUh4ZHpac2dlem5yQ2JyeHErTmxFeWp5dlVqa2lJcWpOY01i?=
 =?utf-8?B?YW1FUllESVJVOCtHTVB3TkZla0FpL2xNUE9OeUdvbk1XNFpTbUZicUJFSWJi?=
 =?utf-8?B?eTYvUk5iYjN4TTM2andEUmFVNDkzYzNQcWpCYnNkUVJMdUgwY2xsUmh6WHVM?=
 =?utf-8?B?TTV3NVdxOCsvM0FISjVqMWlWeFhRY21KcCt0Q1VMTDlZMmhiOUtTRjR0eGhl?=
 =?utf-8?B?UXg0bUtpaVNpeEhndVBBMmJYSTh5UGZLelhQemRIQ2RHUG5KTWFkZkh6d2pv?=
 =?utf-8?B?S1gySVczVnVXZEd6MjMzbjg3ZysxQWpXTWVmZHJUZ1o3OG9kUTNsQTFhSnFH?=
 =?utf-8?B?SlMwcDlSbmZtdXN4OU5QcjNlZHBYOTBqUDM5Y2JZOEV5WEFubUF2Q1VNaFNI?=
 =?utf-8?B?VHBMNWphYS85SVh3ZjFRay9wNXZqL2FCM0w2ejY3alZOUzBENFQ5em1nSk50?=
 =?utf-8?B?MjFvWXhxQWFqMXQxOGpySG1kNEZKTnpqQjlYd3d2RDQ0WDZlNkh6Ui9yUTJq?=
 =?utf-8?B?OTRwYkxlRkl1cHFSWHBQVHlqVmhubE1ueXRDQjFYL3NFVmlFclc5bVZJYUNa?=
 =?utf-8?B?YkNnYW9VbkpJS28xUDNDMTlNVjlzS0tLc09Va1k1c2sydkNpdDZPWStGWWQ2?=
 =?utf-8?B?U0E5b0FVdTBqNkVWOG9KTHhoVW9PZ0k0dHVpdDZrQ0tzUHY3cjM3RmlKWG5R?=
 =?utf-8?B?VVo0Sm9KUUlHcGVtWWFES0dQYzNjeFEwZ2RGaDRvRzZFd3hsbFlERFdUSDJk?=
 =?utf-8?B?ME8rNXZPaTdnYm9STHFXWWI3QVVuWS93UnE1S0Z5cjBlMjV1Wi9CRGROTFRK?=
 =?utf-8?B?ZFdrMlEwR3FCTFNyUDB6a2dzaWQwMVVvS25wSW00UUFWYjRDbGdhYUZoaE0z?=
 =?utf-8?B?ZkhXKzB2aVZKSWpqb2FCbUJiclV3MlZnY0F2WUpaU0xuMk5jVUdaQWdZbFhI?=
 =?utf-8?B?M0JFU29ZTkFKQXJIeFhYZEcvRm8ydjVPQkcvamxCUTZ1WkhybzQ2UGhWUlZz?=
 =?utf-8?B?cDNWODc1QjZUalNzNE00YkJzdUVzRVNNMjYrZVFBWUUwUVhRWVdSS2wxU0V4?=
 =?utf-8?B?b3lic29nMXk0bklCRUpSQkVaU1YwRUlnT1ZUdlNQYjE5My9ZdjhCU3d1UCtR?=
 =?utf-8?Q?MgsIh3Ud/WEg2tSl2elUzUmGS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612FF9254BE47B46A7B9E1FA7E80A56D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b3bfed-f51c-4650-07f0-08db89da0659
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 11:02:50.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/3k/hzLb484x8x6vjVBXhTdEdnPVAw3CLkj2FVkMRAiiEYoq1kgJzUpDnio4khA8vuqVHBD/QLh06Te3qD4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDEwOjA2ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMTI6MTg6MjNBTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gDQo+ID4gVW5mb3J0dW5hdGVseSBJIGRvbid0IHRoaW5rIGl0J3MgZmVhc2libGUu
ICBTZWFuIHBvaW50ZWQgb3V0IHRoYXQNCj4gPiBrdm1fdmNwdV9hcmNoOjpyZWdzW10gZG8gZm9s
bG93IHRoZSAicmVnaXN0ZXIgaW5kZXgiIGhhcmR3YXJlIGxheW91dCBpbiB4ODYgKGZvcg0KPiA+
IHdoaWNoIEkgbWlzc2VkIHNvcnJ5KSwgc28gd2UgY2Fubm90IHJlLW9yZGVyIEtWTSBwYXJ0LiDC
oA0KPiA+IA0KPiA+IEFuZCB1bmZvcnR1bmF0ZWx5IFJCUCAoNSkgaXMgaW4gbWlkZGxlIG9mIHRo
b3NlIHJlZ2lzdGVyczoNCj4gPiANCj4gPiAJMCA9IFJBWA0KPiA+IAkxID0gUkNYDQo+ID4gCTIg
PSBSRFgNCj4gPiAJMyA9IFJCWA0KPiA+IAk0ID0gUlNQDQo+ID4gCTUgPSBSQlANCj4gPiAJNiA9
IFJTSQ0KPiA+IAk3ID0gUkRJDQo+ID4gCTjigJMxNSByZXByZXNlbnQgUjjigJNSMTUsIHJlc3Bl
Y3RpdmVseS4uLg0KPiA+IA0KPiA+IFRodXMgdW5sZXNzIHdlIGFkZCBSQlAgdG8gJ3N0cnVjdCB0
ZHhfbW9kdWxlX2FyZ3MnLCBpdCdzIGltcG9zc2libGUgdG8gcmUtb3JkZXINCj4gPiB0aGUgc3Ry
dWN0dXJlIHRvIG1hdGNoIEtWTSdzIGxheW91dC4NCj4gDQo+IEFkZGluZyBSQlAgdG8gdGhlIHN0
cnVjdCBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtLCB3ZSdsbCBqdXN0IG5vdCB1c2UgaXQuDQo+IFNh
bWUgYXMgUlNQLCBub2JvZHkgc2FuZSB3b3VsZCBleHBlY3QgdGhhdCB0byBiZSB1c2VkLiBJZiB5
b3Ugd29ycnkNCj4gYWJvdXQgaXQgeW91IGNhbiBnaXZlIHRoZW0gZnVubnkgbmFtZXMgbGlrZToN
Cj4gDQo+IHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3Mgew0KPiAJdW5zaWduZWQgbG9uZyBheDsNCj4g
CXVuc2lnbmVkIGxvbmcgY3g7DQo+IAl1bnNpZ25lZCBsb25nIGR4Ow0KPiAJdW5zaWduZWQgbG9u
ZyBieDsNCj4gCXVuc2lnbmVkIGxvbmcgX19zcF91bnVzZWQ7DQo+IAl1bnNpZ25lZCBsb25nIF9f
YnBfdW51c2VkOw0KPiAJdW5zaWduZWQgbG9uZyBzaTsNCj4gCXVuc2lnbmVkIGxvbmcgZGk7DQo+
IAkuLi4NCj4gfTsNCj4gDQo+IEkgbWVhbiwgYXQgdGhpcyBwb2ludCB0aGUgd2hvbGUgdGhpbmcg
aXMganVzdCAxMjggYnl0ZXMgb2YgZGF0YSBhbnl3YXkuDQoNClN1cmUgSSBjYW4gZG8uDQoNCkhv
dyBhYm91dCBhZGRpbmcgYW4gYWRkaXRpb25hbCBwYXRjaCBvbiB0b3Agb2YgdGhpcyBzZXJpZXM/
IMKgDQoNCkZvciBpbnN0YW5jZSwgYmVsb3cgcGF0Y2ggKGNvbXBpbGUgb25seSk6DQoNCkZyb20g
YzYzZDAxYmY5MWZlMjNmMWUyZDJlMDg1NjQ0MzI2YmRlZTExNGQ0OSBNb24gU2VwIDE3IDAwOjAw
OjAwIDIwMDENCkZyb206IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCkRhdGU6IEZy
aSwgMjEgSnVsIDIwMjMgMjI6MDY6MzEgKzEyMDANClN1YmplY3Q6IFtQQVRDSF0geDg2L3RkeDog
QWRkIF9fc2VhbWNhbGxfc2F2ZWRfcmV0KCkgZm9yIFRESC5WUC5FTlRFUg0KDQpGb3IgVERYIGd1
ZXN0LCBLVk0gdXNlcyBUREguVlAuRU5URVIgU0VBTUNBTEwgbGVhZiB0byBlbnRlciB0aGUgZ3Vl
c3QuDQpXaGVuIFRESC5WUC5FTlRFUiByZXR1cm5zIHRvIEtWTSBkdWUgdG8gVERHLlZQLlZNQ0FM
TCBmcm9tIHRoZSBURFgNCmd1ZXN0LCBhbGwgUkNYL1JEWC9SQlgvUkRJL1JTSS9SOC1SMTUgYXJl
IHZhbGlkIG91dHB1dCByZWdpc3RlcnMsIGFuZA0KdGhlIGZvbGxvd2luZyBUREguVlAuRU5URVIg
YWxzbyB1c2VzIGFsbCB0aG9zZSByZWdpc3RlcnMgYXMgaW5wdXQuDQoNCkludHJvZHVjZSBfX3Nl
YW1jYWxsX3NhdmVkX3JldCgpLCB3aGljaCB1c2VzIGFsbCBhYm92ZSByZWdpc3RlcnMgYXMNCmJv
dGggaW5wdXQvb3V0cHV0LCBmb3IgS1ZNIHRvIHN1cHBvcnQgVERILlZQLkVOVEVSLg0KDQpBbHNv
LCBLVk0gY2FjaGVzIGd1ZXN0J3MgR1BScyBpbiAna3ZtX3ZjcHVfYXJjaDo6cmVnc1tdJywgd2hp
Y2ggZm9sbG93cw0KZm9sbG93cyB0aGUgInJlZ2lzdGVyIGluZGV4IiBoYXJkd2FyZSBsYXlvdXQg
b2YgeDg2IEdQUnMuICBIb3dldmVyIHRoZQ0KX19zZWFtY2FsbF9zYXZlZF9yZXQoKSB0YWtlcyB0
aGUgcG9pbnRlciBvZiAnc3RydWN0IHRkeF9tb2R1bGVfYXJncycgYXMNCmFyZ3VtZW50LCB0aHVz
IHRoZXJlJ3MgYSBtaXNtYXRjaCBoZXJlLg0KDQpPbmUgb3B0aW9uIGlzIEtWTSB0byBjb3B5IGlu
cHV0IHJlZ2lzdGVycyBmcm9tICd2Y3B1OjpyZWdzW10nIHRvIGENCidzdHJ1Y3QgdGR4X21vZHVs
ZV9hcmdzJyBvbiB0aGUgc3RhY2sgYW5kIHVzZSB0aGF0IHRvIG1ha2UgdGhlIFNFQU1DQUxMLA0K
YnV0IHN1Y2ggbWVtb3J5IGNvcHkgaXNuJ3QgZGVzaXJlZCBhbmQgc2hvdWxkIGJlIGF2b2lkZWQg
aWYgcG9zc2libGUuDQpJdCdzIG5vdCBmZWFzaWJsZSB0byBjaGFuZ2UgS1ZNJ3MgJ3ZjcHU6OnJl
Z3NbXScgbGF5b3V0IGR1ZSB0byB2YXJpb3VzDQpyZWFzb25zIChlLmcuLCBlbXVsYXRpb24gY29k
ZSB1c2VzIGRlY29kZWQgcmVnaXN0ZXIgaW5kZXggYXMgYXJyYXkgaW5kZXgNCnRvIGFjY2VzcyB0
aGUgcmVnaXN0ZXIpLiAgVGhlcmVmb3JlLCBhZGp1c3QgJ3N0cnVjdCB0ZHhfbW9kdWxlX2FyZ3Mn
IHRvDQptYXRjaCBLVk0ncyAndmNwdTo6cmVnc1tdJyBzbyB0aGF0IEtWTSBjYW4gc2ltcGx5IGRv
IGJlbG93Og0KDQogICAgICAgIHNlYW1jYWxsX3NhdmVkX3JldChUREguVlAuRU5URVIsDQogICAg
ICAgICAgICAgICAgICAgICAgICAoc3RydWN0IHRkeF9tb2R1bGVfYXJncyAqKXZjcHUtPmFyY2gt
PnJlZ3MpOw0KDQpOb3RlIFJBWC9SU1AvUkJQIGFyZSBub3QgdXNlZCBieSB0aGUgVERYX01PRFVM
RV9DQUxMIGFzc2VtYmx5LCBidXQgdGhleQ0KYXJlIG5lY2Vzc2FyeSBpbiBvcmRlciBtYXRjaCB0
aGUgbGF5b3V0IG9mICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzJyB0bw0KS1ZNJ3MgJ3ZjcHU6OnJl
Z3NbXScuICBUaHVzIGFkZCB0aGVtIHRvIHRoZSBzdHJ1Y3R1cmUsIGJ1dCBuYW1lIHRoZW0gYXMN
CipfdW51c2VkLiAgQWxzbyBkb24ndCBpbmNsdWRlIHRoZW0gdG8gYXNtLW9mZnNldC5jIHNvIHRo
YXQgYW55IG1pc3VzZSBvZg0KdGhlbSBpbiB0aGUgYXNzZW1ibHkgd291bGQgcmVzdWx0IGluIGJ1
aWxkIGVycm9yLg0KDQpTaWduZWQtb2ZmLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5j
b20+DQotLS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmggfCAxOSArKysrKysr
KysrKysrLS0tLS0tDQogYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1jYWxsLlMgIHwgMTkgKysr
KysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90
ZHguaA0KYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgNCmluZGV4IDc0ZmM0NjZk
ZmRjZC4uOGQxNDI3NTYyYzYzIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hh
cmVkL3RkeC5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgNCkBAIC01
OCwyNCArNTgsMzEgQEANCiAgKiBVc2VkIGluIF9fdGRjYWxsKigpIHRvIGdhdGhlciB0aGUgaW5w
dXQvb3V0cHV0IHJlZ2lzdGVycycgdmFsdWVzIG9mIHRoZQ0KICAqIFREQ0FMTCBpbnN0cnVjdGlv
biB3aGVuIHJlcXVlc3Rpbmcgc2VydmljZXMgZnJvbSB0aGUgVERYIG1vZHVsZS4gVGhpcyBpcyBh
DQogICogc29mdHdhcmUgb25seSBzdHJ1Y3R1cmUgYW5kIG5vdCBwYXJ0IG9mIHRoZSBURFggbW9k
dWxlL1ZNTSBBQkkNCisgKg0KKyAqIE5vdGUgdGhvc2UgKl91bnVzZWQgYXJlIG5vdCB1c2VkIGJ5
IHRoZSBURFhfTU9EVUxFX0NBTEwgYXNzZW1ibHkuDQorICogVGhlIGxheW91dCBvZiB0aGlzIHN0
cnVjdHVyZSBhbHNvIG1hdGNoZXMgS1ZNJ3Mga3ZtX3ZjcHVfYXJjaDo6cmVnc1tdDQorICogbGF5
b3V0LCB3aGljaCBmb2xsb3dzIHRoZSAicmVnaXN0ZXIgaW5kZXgiIG9yZGVyIG9mIHg4NiBHUFJz
LiAgS1ZNDQorICogdGhlbiBjYW4gc2ltcGx5IHR5cGUgY2FzdCBrdm1fdmNwdV9hcmNoOjpyZWdz
W10gdG8gdGhpcyBzdHJ1Y3R1cmUgdG8NCisgKiBhdm9pZCB0aGUgZXh0cmEgbWVtb3J5IGNvcHkg
YmV0d2VlbiB0d28gc3RydWN0dXJlcyB3aGVuIG1ha2luZw0KKyAqIFRESC5WUC5FTlRFUiBTRUFN
Q0FMTC4NCiAgKi8NCiBzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIHsNCi0gICAgICAgLyogY2FsbGVl
LWNsb2JiZXJlZCAqLw0KKyAgICAgICB1NjQgcmF4X3VudXNlZDsNCiAgICAgICAgdTY0IHJjeDsN
CiAgICAgICAgdTY0IHJkeDsNCisgICAgICAgdTY0IHJieDsNCisgICAgICAgdTY0IHJzcF91bnVz
ZWQ7DQorICAgICAgIHU2NCByYnBfdW51c2VkOw0KKyAgICAgICB1NjQgcnNpOw0KKyAgICAgICB1
NjQgcmRpOw0KICAgICAgICB1NjQgcjg7DQogICAgICAgIHU2NCByOTsNCi0gICAgICAgLyogZXh0
cmEgY2FsbGVlLWNsb2JiZXJlZCAqLw0KICAgICAgICB1NjQgcjEwOw0KICAgICAgICB1NjQgcjEx
Ow0KLSAgICAgICAvKiBjYWxsZWUtc2F2ZWQgKyByZGkvcnNpICovDQogICAgICAgIHU2NCByMTI7
DQogICAgICAgIHU2NCByMTM7DQogICAgICAgIHU2NCByMTQ7DQogICAgICAgIHU2NCByMTU7DQot
ICAgICAgIHU2NCByYng7DQotICAgICAgIHU2NCByZGk7DQotICAgICAgIHU2NCByc2k7DQogfTvC
oA0KDQovKiBVc2VkIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIFREWCBtb2R1bGUgKi8NCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwuUyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC9zZWFtY2FsbC5TDQppbmRleCBiMzI5MzQ4MzdmMTYuLmYyNTFlYmFkYjAxNCAxMDA2
NDQNCi0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtY2FsbC5TDQorKysgYi9hcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwuUw0KQEAgLTQwLDMgKzQwLDIyIEBAIFNZTV9GVU5DX0VO
RChfX3NlYW1jYWxsKQ0KIFNZTV9GVU5DX1NUQVJUKF9fc2VhbWNhbGxfcmV0KQ0KICAgICAgICBU
RFhfTU9EVUxFX0NBTEwgaG9zdD0xIHJldD0xDQogU1lNX0ZVTkNfRU5EKF9fc2VhbWNhbGxfcmV0
KQ0KKw0KKy8qDQorICogX19zZWFtY2FsbF9zYXZlZF9yZXQoKSAtIEhvc3Qtc2lkZSBpbnRlcmZh
Y2UgZnVuY3Rpb25zIHRvIFNFQU0gc29mdHdhcmUNCisgKiAodGhlIFAtU0VBTUxEUiBvciB0aGUg
VERYIG1vZHVsZSksIHdpdGggc2F2aW5nIG91dHB1dCByZWdpc3RlcnMgdG8gdGhlDQorICogJ3N0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MnIHVzZWQgYXMgaW5wdXQuDQorICoNCisgKiBfX3NlYW1jYWxs
X3NhdmVkX3JldCgpIGZ1bmN0aW9uIEFCSToNCisgKg0KKyAqIEBmbiAgIChSREkpICAtIFNFQU1D
QUxMIExlYWYgbnVtYmVyLCBtb3ZlZCB0byBSQVgNCisgKiBAYXJncyAoUlNJKSAgLSBzdHJ1Y3Qg
dGR4X21vZHVsZV9hcmdzIGZvciBpbnB1dCBhbmQgb3V0cHV0DQorICoNCisgKiBBbGwgcmVnaXN0
ZXJzIGluIEBhcmdzIGFyZSB1c2VkIGFzIGlucHV0L291dHB1dCByZWdpc3RlcnMuDQorICoNCisg
KiBSZXR1cm4gKHZpYSBSQVgpIFREWF9TRUFNQ0FMTF9WTUZBSUxJTlZBTElEIGlmIHRoZSBTRUFN
Q0FMTCBpdHNlbGYNCisgKiBmYWlscywgb3IgdGhlIGNvbXBsZXRpb24gc3RhdHVzIG9mIHRoZSBT
RUFNQ0FMTCBsZWFmIGZ1bmN0aW9uLg0KKyAqLw0KK1NZTV9GVU5DX1NUQVJUKF9fc2VhbWNhbGxf
cmV0KQ0KKyAgICAgICBURFhfTU9EVUxFX0NBTEwgaG9zdD0xIHJldD0xIHNhdmVkPTENCitTWU1f
RlVOQ19FTkQoX19zZWFtY2FsbF9yZXQpDQotLSANCjIuNDEuMA0KDQoNCg==
