Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7F75BDB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGUFTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGUFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:19:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B755C2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689916782; x=1721452782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4qWzdJI1QwBQBPUCxrgVLU2ntLpc2XLjR6lVWRLJK0U=;
  b=eFmUeQOhCoFidBrPw6KTJWwDRMM8KPwbOuW+XOqoQhpq5BBqS7doUXwz
   HpK3oQ6A/HuM+Po+WRzmY4WtlVU6xRCkEJcsmfjcGFR0CygohQPBi5maV
   NaDDhxuFWhhV5adRmK+waMDnWuWfNQANsvTHqsz9hdtP5Ak3kgWhIFKsn
   UiA46OO2Vxz4LAWaOpUZlhG904lSQ+gJyQH+O3bymNbibq4TizemowXRy
   Lzfv+4JUeQJxpGliXk0xecl3eIgOd4OI+wiNRBQ+Qbyf8eJ1alp4Q3zIR
   5giPNkARttXBddUIh0UlB9psrsK6LumfP3tx5/kIaYwmYsAoAP9lIv+s4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351819445"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351819445"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814812104"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814812104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2023 22:19:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 22:19:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 22:19:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 22:19:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 22:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1rAQAv5Dpo+FVyIvulfUPoED1gzAibLXXEtpvLGKFq0t2/izNUsNiDAW1KkiwD331ew7AZV57Caenzb4NcRFjVKzFKwzTfD0S+z+7LpW4I5hq5YnriBHXf00tAIXcd4lVDbjx9qXTSHSIfPwCOJyBnR4bJZ5L7ZQD7jdsvB/K4dpXMdE1gmjBzLGWdDX3TI9Y6RmZ+vM10H4xoU8WqiicFK/lbNVd8WdoDJNOu5tKaZwpuArlVgy34AZnLjN2KAU02svyI1cqnh4ByIhr0Q5THs1mcIEpMhwKGCzuQ/39q+mgSEfj5uJYglfU8Gs52SHxxu8m8zJrdf1UH3hJQRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qWzdJI1QwBQBPUCxrgVLU2ntLpc2XLjR6lVWRLJK0U=;
 b=II8FMOcu6Lt2/I7Jdfs/HxnI5EZXqc6/N9EfSNiCGgR6Xs+bLydjzYYbG+g+m4yVwX6mSGOstoZiI9sqh9bbTOY0TsuTzu96VYk8T/ZNxR0yp2f012oloainazlSWTeeFuq8CJLre/EsVvVbNhK2/F0pE9R07VzlqXnu4grAQDeacaW8jYM8hFHRQ6rnaSHDetpia6NXyAZFk4vzgNTWet/0QVOJDaRL7dVFW2KL8+r250cU0fS+EQwH5WO8jZa3QFjP+XaD1mVDjiyVG4Ridjw6o1kgkIWvMKhrmrcVWmHoyjk+YAwhpAcd2nMskYOcY8b4tAcj4OilvQcWQwrM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 05:19:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 05:19:31 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 07/11] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v2 07/11] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZuwSYT1A9fUjMSE6qMYcfTYYmXa/Dr84A
Date:   Fri, 21 Jul 2023 05:19:30 +0000
Message-ID: <152cfe1f60a9f90a3950c37e676990be6cad59b2.camel@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
         <11e9ef9994640c4bb8c00fe133abc7550171208e.1689855280.git.kai.huang@intel.com>
In-Reply-To: <11e9ef9994640c4bb8c00fe133abc7550171208e.1689855280.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7747:EE_
x-ms-office365-filtering-correlation-id: 981266b9-fea3-4e40-c816-08db89aa0ffd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDlgXNeZj6+EjEBTN2QjR2XDMC08ESx+Xi2qKbcnQumn/W32beLfd4Rtl9cEtWEXZTyTMhRDoCOzxVnWSfoEUOqz1E4On10VWX7B5TwwFR6VVzVpoh9b0izA1rPpr6uOYArbEbORW3b6OtcePVRJOcsSx8JYeO4k4ELtWrSiMeFjxur3QeSSjgzvnJhghy+tK8px9K9gApl1UksZ9j0qRQncz4fIz7t0c+PrLI0kvqjlbgz+lSnIDyV0kr+y750b8JrZNHtJMgbuRZleYzXFTlNwvVnHv73nrPoChfyNXIaXseRJRhkI7kuYZg096EAznNkI4HP2x1Xbkh3J9v3DhO2TjPz+dCGVmVar3Zy6EUJN2e3GuqZ5f2yDfKT9KkVxH/lkSSkTpgFEeWY3zE88pQheBCk7qdddnjAHbvaU6zfj9Fx0mdHZeNbMpmN0XmxfWkCKOQH6WLZFjlWsSN72aUugrlAPZVb3+OhfzF6LtwVgLxM3VvpNBdh0nUGyz8FByGmNQm+7t3/oGN5tk/c0J956ZJfZqSCm4GnghKH8B1pEGyybkrpQLS6e3p9QXzz74afOzm1B86z3EC6TUsWqTCedKFXKkJkmrrMFema7Ce2H3Egh+GXBs1cl1MOb03Wb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(8676002)(5660300002)(7416002)(8936002)(2906002)(316002)(6486002)(54906003)(110136005)(478600001)(6512007)(71200400001)(83380400001)(36756003)(6506007)(26005)(186003)(76116006)(91956017)(66446008)(66476007)(4326008)(66556008)(41300700001)(64756008)(66946007)(86362001)(38070700005)(2616005)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG9XUFVrOUNVMWlLTDVwaW5hVjM2NlNQS3dvbUYyVFM1OURPNnF6VllJYmVH?=
 =?utf-8?B?WHRkVmlaN3hrMmMrYXFmbkxKdTlwQ3dqRFFxdEFrYnVKa3g1eXJqR3g3Z3Ux?=
 =?utf-8?B?cHZwa0twOWYyWllJSHlwNEJkYmVIUGRTeS80TEVTSi9VN2p6TFUycFRvUERj?=
 =?utf-8?B?QmZVSisxT3BBWmJrMlZUdTBmdXhQNHNIN2YvK256RnZFRHM2ajdDVFJSVnhE?=
 =?utf-8?B?VDU1QndIV09nb1MrSU16dWRSRUtmYjlsQWI4bzNlNmZpSXNDd3ROM1c2QU9B?=
 =?utf-8?B?MnBjNFJLVFRDL2hYM3ppQnFDSW4rZmhISmMzVFhVTCsyclNLQTRhYWgxK1pH?=
 =?utf-8?B?Zlp5cWhCM00xRHp2ZFgwazN6TmpIODYxeDNFUU1rYnpxUWVpU1pXY2NwR3dC?=
 =?utf-8?B?V3ZFMW80WDNrQXVqWVBsMnQwZ09hcE9kaktyWnpjOXkvRk9ZWDF5enBVcHlL?=
 =?utf-8?B?OG91L095VEJtUHNDc3B2clM5REZ6K25idUZUenhTajdQTDNiMThpRUxUUHhK?=
 =?utf-8?B?Z2YyQjl6Q1F4RWdJdEkzZEJvTTNWbGJnSHhKVGVLb1NaeGphUHRhT3MveGkv?=
 =?utf-8?B?WGo4N3hSQ1cvOVEyb09iUzlSbXdYWkpNL0gyclpZOUp1SWw0WEdqMlNVZ2Zn?=
 =?utf-8?B?WFpZRXdLTnNNQW9lcW9lanZzQ0o2K0JuYWt1bEs5MlhaOWdGQ1ZvMHQ5Ky9m?=
 =?utf-8?B?ZE1zZ3lYMEhYVHRDS1RwamltbWd1Z29wK2phRExPSjViV1Q1dS9ESFBrbVdp?=
 =?utf-8?B?MUtYbHJqMUZwQThVRFoxVFhaQnhhZmlLK3Q4SFByZ2hhb1FubWxxY2JUdjJJ?=
 =?utf-8?B?d2IrR05FUTlTeVlSN3pFcjQzVDgxY3RTOHRmbHQ5RlpFamZGdnlucm9yOERD?=
 =?utf-8?B?eSt4d2hmN0lXN3dXaWFpMWRFZE9mYUVlMUhKc1FURnlQVmE5ZE93bWtxRVd4?=
 =?utf-8?B?WFFhNExNdFJJSnJXd0VvbDNSZnNPSTF4Q1pzc3Y4dksrdVJCQVl3bUN2cFZa?=
 =?utf-8?B?b1hYZWxjZXErNzVqZ3BxQy85bllPa25IMXljY1Bnb2pOOUNxRGhmRU1lM2c3?=
 =?utf-8?B?YkczVEIxaWhNbTRFWUZQWWNnTjdGNUxOUTQ4OFkrU0lMME5ITHc2b0NPQVd5?=
 =?utf-8?B?R2VYYnBESHJFVXZtS2NzcTZrVy8vblhiT21jUEdhbE9xVnQvb3M5MUtaQ3FO?=
 =?utf-8?B?V3NPZ1BlS1hrVWJzVmZUd2gwSS82TXBXNVFWSUwxZnAyUkVTSlc2S0o2dXZ4?=
 =?utf-8?B?YmM3ZmxqNmZvcU5tWGRGSVBpZVh5a0RlSlhRNlJmQzNJLzdXdEEwaVBUNWNm?=
 =?utf-8?B?MjRXQ2pRbGJOVnhucS80SzdVK2MyWTcyY2xtR1JnL0JySk9rejRRN0Z4ZHpQ?=
 =?utf-8?B?cnQxRGt3aElYYmcvYVEzMDZZZkloYTc5OFZiQldLaFFOVERKTjc1RTcxb3Ns?=
 =?utf-8?B?eVU2eTViaGo5VmNzOXBDWXhOenAxVnBkNEtXRFppMllUNk5nRlFtYkVNRmkx?=
 =?utf-8?B?YXdETHhnem1abzZySXVwVnBIakUwc2dGd09NL003RkdNcTlLcEJlVVZtQ1Fu?=
 =?utf-8?B?ZzM4K0xKMnErdHJEazdUczJxRGJHenRFei9Ic3RocUtFYU1DVWVNVEJDMjN0?=
 =?utf-8?B?aFo1emZ4UlNBSE4rUjJ5U3R5blliMFAwbVpVSVVSR1RWQlNyVVlZTG1WOUY2?=
 =?utf-8?B?T3ZOVjRpS0VrTC9wRGdsOHM3Z2dxcCtVUTMxT1NJZTJlQjR5R2JmWC9QU1pK?=
 =?utf-8?B?RU92b1VjdGswUXM2TUtwSWRONnowUE5FRzZFOFdjL0hzZVBlQ3owVkVLSm5m?=
 =?utf-8?B?OVNZQzkwSXp4TnVOenQxdmFmWkYzN0FzQ0VyQWdPK3lCaUMwa0k1dlg0bThF?=
 =?utf-8?B?Q0dWNHNqcm45MS9XbS9NRWNBQndtUEI3NlBXMW8ySGtiWkQvbWxRbjExVEYw?=
 =?utf-8?B?NUVWd0JyL0xRTTY2L1JUSGk4RHYrdUl1RWs0TE5FUlowd3N0U0IvZmZhYTIv?=
 =?utf-8?B?aEhkWEUrN0xPNE9yZEppRnZhcVdBVUlua29wQ20xUy9tZTVxTUQ1bythNDBG?=
 =?utf-8?B?TnZhdW8rSFhhQ2tHMWl1ZU9ab2EySHdTOWJMZ0RRcHBYM0RZczBBRjBQMXZh?=
 =?utf-8?Q?2heKzOyiyhboHbr6TCoMTRiOd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD18704B0D8314BB3FAD5FA761FD0B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981266b9-fea3-4e40-c816-08db89aa0ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 05:19:30.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cva139PJQTv0SP0b3RUN5SWrjIE/QpjaSX4SXE0jsztJzGD6a32EZuYnHBZVyXes27gsxjUwzonQmDy2Z+xpIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBXaXRoIGFib3ZlIGNoYW5nZXMsIGNoYW5nZSB0aGUgYXNtIGZ1bmN0aW9uIGZyb20g
X190ZHhfaHlwZXJjYWxsKCkgdG8NCj4gX190ZGNhbGxfaHlwZXJjYWxsKCksIGFuZCByZWltcGxl
bWVudCBfX3RkeF9oeXBlcmNhbGwoKSBhcyB0aGUgQyB3cmFwcGVyDQo+IG9mIGl0LiAgVGhpcyBh
dm9pZHMgaGF2aW5nIHRvIGFkZCBhbm90aGVyIHdyYXBwZXIgb2YgX190ZHhfaHlwZXJjYWxsKCkN
Cj4gKF90ZHhfaHlwZXJjYWxsKCkgaXMgYWxyZWFkeSB0YWtlbikuDQo+IA0KWy4uLl0NCj4gDQo+
IEJ5IGNoYW5naW5nIF9fdGR4X2h5cGVyY2FsbCgpIHRvIGEgQyBmdW5jdGlvbiwgX190ZHhfaHlw
ZXJjYWxsX2ZhaWxlZCgpDQo+IGlzIG5vIGxvbmdlciBjYWxsZWQgZnJvbSAnLm5vaW5zdHIudGV4
dCcsIHRodXMgcmVtb3ZlIHRoZSAnbm9pbnN0cicNCj4gYW5ub3RhdGlvbiBhbmQgdGhlICdpbnN0
cnVtZW50YXRpb25fYmVnaW4oKScuDQo+IA0KDQpIaSBQZXRlciwNCg0KU29ycnkgSSBnb3QgYSBi
dWlsZCByZWdyZXNzaW9uIGZyb20gbGtwOg0KDQp2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6
IF9faGFsdCsweDNhOiBjYWxsIHRvIF9fdGR4X2h5cGVyY2FsbCgpIGxlYXZlcw0KLm5vaW5zdHIu
dGV4dCBzZWN0aW9uDQoNClRoZSByZWFzb24gaXMgX19oYWx0KCkgaXMgYW5ub3RhdGVkIHdpdGgg
Il9fY3B1aWRsZSIsIGJ1dCBpdCBjYWxscw0KX190ZHhfaHlwZXJjYWxsKCksIHdoaWNoIGlzIG5v
dyBhIG5vcm1hbCBDIGZ1bmN0aW9uLCB3L28NCmluc3RydW1lbnRhdGlvbl9iZWdpbigpL2VuZCgp
Lg0KDQpJIHRoaW5rIHdlIGNhbiBhbm5vdGF0ZSBfX3RkeF9oeXBlcmNhbGwoKSBhcyAnbm9pbnN0
cicgdG9vIGFuZCBrZWVwDQpfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKCkgdW5jaGFuZ2VkLiAgQW55
d2F5IGluIHRoZSB1cHN0cmVhbSBjb2RlLA0KX190ZHhfaHlwZXJjYWxsKCkgaXMgaW4gJy5ub2lu
c3RyLnRleHQnLg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29jby90ZHgvdGR4LXNoYXJlZC5j
IGIvYXJjaC94ODYvY29jby90ZHgvdGR4LXNoYXJlZC5jDQppbmRleCAxMzEzOWVlMTcxYzguLmI0
N2M4Y2NlOTFiMCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC1zaGFyZWQuYw0K
KysrIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LXNoYXJlZC5jDQpAQCAtNzAsNyArNzAsNyBAQCBi
b29sIHRkeF9hY2NlcHRfbWVtb3J5KHBoeXNfYWRkcl90IHN0YXJ0LCBwaHlzX2FkZHJfdCBlbmQp
DQogICAgICAgIHJldHVybiB0cnVlOw0KIH0NCiANCi11NjQgX190ZHhfaHlwZXJjYWxsKHN0cnVj
dCB0ZHhfaHlwZXJjYWxsX2FyZ3MgKmFyZ3MpDQorbm9pbnN0ciB1NjQgX190ZHhfaHlwZXJjYWxs
KHN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgKmFyZ3MpDQogew0KICAgICAgICBzdHJ1Y3QgdGR4
X21vZHVsZV9hcmdzIG1hcmdzID0gew0KICAgICAgICAgICAgICAgIC5yY3ggPSBURFZNQ0FMTF9F
WFBPU0VfUkVHU19NQVNLLA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIv
YXJjaC94ODYvY29jby90ZHgvdGR4LmMNCmluZGV4IGFiYTU4NDg0YmExMC4uZjEwYjBlNTEyYTM2
IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCisrKyBiL2FyY2gveDg2L2Nv
Y28vdGR4L3RkeC5jDQpAQCAtMzcsOCArMzcsOSBAQA0KIA0KICNkZWZpbmUgVERSRVBPUlRfU1VC
VFlQRV8wICAgICAwDQogDQotdm9pZCBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKHZvaWQpDQorbm9p
bnN0ciB2b2lkIF9fdGR4X2h5cGVyY2FsbF9mYWlsZWQodm9pZCkNCiB7DQorICAgICAgIGluc3Ry
dW1lbnRhdGlvbl9iZWdpbigpOw0KICAgICAgICBwYW5pYygiVERWTUNBTEwgZmFpbGVkLiBURFgg
bW9kdWxlIGJ1Zz8iKTsNCiB9DQoNCg0KV2UgY2FuIGZvbGQgdGhpcyB0byB0aGlzIHBhdGNoLg0K
DQpEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/DQo=
