Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A475C581
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGULJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGULI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6C268E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689937617; x=1721473617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZrmwyxsxDmjszLyuYFOm3R7izvvFb5FgfKmYlAWSvlI=;
  b=Sr6SOpnOuP3mXhAoI+0WuvDDDKksXuULOHDk8dOJZmbIsTgAfDpktQ/c
   M/jyCbA4gJsq3WzUytkUO0/g7jnlkWN6NfRc/4Kt1OK+N5GOW3VVDlyCH
   k7DBkIL6y3EVyka8JrAtKHiodmdHUkYM//YZsawgPi608a7VPf1foUIBr
   gIDCCJY4LB20mGpZu7sGgac4y47HjQxgLEqoCC59/mkqfSYO6B7FNruhk
   tYr4Q6dvasmTWxDyJEr4i/Fs4g8F5YP8ku5RREJHSuFALYXod9eKPDKJI
   XrF8+2bIH8xunY+YcuXBZkB2ZrisCiErc2BF+KhtbNRjeIy51pY0LpHrw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453374556"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453374556"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718782027"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718782027"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 04:06:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:06:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:06:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 04:06:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 04:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bst5kOW9VK24mxyL8wJIFIvsgZh4U2noUFj6RwOJfLNxCPhspziWUMtLEuPS90QNpz8HpAxiXC+uMh556QqluX2THa5lfCCVK2rkFmOeBfzGyeAK+wzsRuCgf9kKaWvz4EO1Is4e62svl50TL0kCcFTcKHYgF6ZV29DpqFCTqYFpue/GRG8nW1X3P2fe+jtW1s/Ikg+55DyfrsQs8Bjws6KsGj3o0LzN3ea9fcZAoMV7hPmUh4vISeU6689mfuC21817RxDucbjMDjuNtpvWtuM5S6UqjKOVT6zkcWvLsTC5ufhFlterjDSs+4S9tyCcJE2UrVQv9yngyZghjg5T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrmwyxsxDmjszLyuYFOm3R7izvvFb5FgfKmYlAWSvlI=;
 b=YoX6xEdrC8S71w2XkxxcZA6PzModmGOp5OGX5tESWa0iAPPZM/Ihg173vVcHkW7TrhqnpWM5UaKv7BSxNXhRhC9330+WkG/DmijLPHqtvWQGN8fJobjNAucY+P+7f+Ei55oIOVlGNCc+uZNA2qRs75R7YRr8+woelqNOo/1holeqNDqCIdv/uUVvKJ2GyNqaHKTX6i4ccgyKMiJcPMSJieGcI/pSNP419owfq0YyF/VF7lrbej4noOiaiJwmXlKYrku4ki2ieWHhku2BUZeRroMazQaglZ3isUHOv2w74SlbEkR7/haS9tp10TQPaTeTYeUJ+g6OyWB54dQg/DtxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 11:06:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 11:06:47 +0000
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
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 07/11] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v2 07/11] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZuwSYT1A9fUjMSE6qMYcfTYYmXa/Dr84AgAAtY4CAADOlgA==
Date:   Fri, 21 Jul 2023 11:06:47 +0000
Message-ID: <3d86a1742c1d673ba4e006e6deca4a0018306edb.camel@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
         <11e9ef9994640c4bb8c00fe133abc7550171208e.1689855280.git.kai.huang@intel.com>
         <152cfe1f60a9f90a3950c37e676990be6cad59b2.camel@intel.com>
         <20230721080155.GB3630545@hirez.programming.kicks-ass.net>
In-Reply-To: <20230721080155.GB3630545@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: d5aaac8b-fdc0-41d6-70ab-08db89da938e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhd74iQWdmKsoI45yx6NWHdImKRi404NWlBgBc7xbQIb8fCeYgSgGpnAdqjGIBAe/loEMDMkoxM5SDpFvNJDJpXRICoWxJNU3K9qspYDaCv2xlE1RvbWV0tJQiHyh4y6O1U6K0/NX7k38cO4V5u6Vo36fKIb76e4usiv9E0S0UhKOXwp8ArYbSDqbWrKThg4xv6JJIsmRPlaVATeZ6ymbhTewp3JQmvryWBxr7BM3aWj4VWRnaFet6Dx+irsJZjQqPvzMcDByIBjrdO7loRjPDbzoWxjjTIJeDAg7LWyF71kTEoT6rChdimCvAKUOX3wyI38/1AjsWqen+W8jAx+89i8WEMQjaGuQ7TMVu6VlTN+bohYN5ydlTiEoSSSh0TaO8oFPX0iQ0TtJ2g2hs9oYLgIqTpKM23AnVDovPBpliiNfUiVYmeYCVh2opeMQBoAhZRnwldtUKVxSBWoaOhw3qcaP8LzHPnRS+QUmmevr2AD/T+mqsNxe+6nA+bkF5irZ+QhmOKr9IHiKbO0s+93pSuOTwsVAlaKPGIGhnrv4E6FpIv+Z38ih13KQP2H7+NLTQ8vrJZ306eFJgNB4Z1asV4Mi+5hjHH+1PoEZ91X6s1uypHP81UpS7B23q2Lvsnt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(2906002)(83380400001)(2616005)(38070700005)(86362001)(36756003)(122000001)(82960400001)(38100700002)(41300700001)(6506007)(6486002)(66446008)(66476007)(76116006)(91956017)(66946007)(6916009)(71200400001)(4326008)(64756008)(316002)(66556008)(26005)(186003)(6512007)(8936002)(7416002)(8676002)(478600001)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVMU0hhOXpJQVJTUGQ1eVJlblM5ZDE3ZnltbWNWd3p6OEw5VnlyTVlZNWVK?=
 =?utf-8?B?SWFRZjlBcXFJVjg1enQ5MVZZc2NLUnIvZDhWQnFXVmNSa3FNdDhqRkxrRFlm?=
 =?utf-8?B?bXdxREdDTzdiTTBhazJhTENmM3N1ZjYydzB1TmFiZ2RvMUhENnZZQ1RHUE1D?=
 =?utf-8?B?UGhYeGkzQ3pjUGF4VXVIdWdNR2NkcUJ0ejR3WTdsbXhNa2l1YXc2bEpGaW54?=
 =?utf-8?B?MzlnRkZVaGlqMXRYWlNQMEJCWVBPS3hkZndSeDh4UWU5d09SeFNneW5kV21v?=
 =?utf-8?B?N2s5elZzYWtnSFdwMnpsTVgxMmZlMzNXakVZQUh0VjNPRFZQbU1zdkFLNjhZ?=
 =?utf-8?B?YVhaWUl5bzcyanZKb2Z1NGRlT2dBKzhFOU03SnZHdDhvbENmMFQzYjhxdjlt?=
 =?utf-8?B?bkcxYURiUjJRWVBtenpYT2lmYTQyS242clgxcXI4c0hiN1ZKc0szci9rTXRz?=
 =?utf-8?B?bENwZmMrVGEwNllFRUxtL1YrZU95Y3lsV2h3K2pMWEFtQmFOa2V2M1lWRldD?=
 =?utf-8?B?T0tnOU9GYlNqNis5L0RVZXMwa1pYcHhUakFuMHFwZXhNN2ZialVRcUZ4M2wr?=
 =?utf-8?B?czI0RXV6ZlltendzZFRlbk92NElIWW0wM2Z4eDduMkFuc2NsbTlNZ2Rscy8w?=
 =?utf-8?B?VkxZNzh6R2l3YXh1a253U3U0Qkl4c2FLcGQwMTZVVm5pbFd2U1lVS1F4dndB?=
 =?utf-8?B?V3VSdGdDTDY0eFFQQkcwTkRPUVgvQmZqRlJiZGdodWMxR1dkTWtwenhvc3Nw?=
 =?utf-8?B?bjRGR0IwQ01vOU9nOXNpWCs4ZGFId3BES25qVmRTeGgyUkM2bklHOXdYa0ZF?=
 =?utf-8?B?eUdOSXRTMytjWERTa29XRW4ra3lnbW5EeU1PaVdwY1lSamxPS3U3a2M1VzdF?=
 =?utf-8?B?bVVPcUZGL2ppV1ZRcnJib2s4N1pDK3JBUUgwRzlObnVtMHhIanhTZko0NTkx?=
 =?utf-8?B?ckplMk8weWcwZm51YzJoNnhndCtGakwxRk8vQm4xZTJ3WWs5WEtadGorYTRj?=
 =?utf-8?B?SC9DOU8zZC9SZStnSFQxUUhZQWxRN2hnKzVkbGZyUGZuWG81aDZJQWkyU2Zv?=
 =?utf-8?B?Y1JDSitKTUg3aElXVW5SVHBKcUozUnFkU3pTWUlVRGpvS3NSTVRRT3FZK3ZG?=
 =?utf-8?B?WjhlSUFLSVhxTC9yVWpsQm9RUFRJMTJGNzZMVml3NmQyLzBuYk51dGM3ZTh0?=
 =?utf-8?B?b3ppc0JLYStxcE1IK2UvL0hnN0w0T2UwN2JsbmhrRWo0eXZRTFdodEdGeXJt?=
 =?utf-8?B?b1VlU1BvejBtM1lCbXBORHpGVHlRZ0hwNXdOL21ZTUlPMlpiRFBqS2V0d2oy?=
 =?utf-8?B?OVVVRWhTaTZaYVprTUsrQ1ljWVI1MnpXbFYvUXhFYU1nU00zUkpsN3hWaEZI?=
 =?utf-8?B?VXJ1SHJXeTJuZk5mazZDRWFyamVqbW9GMjJyUWZoQmtmeCs1NW9PeGlKMzIx?=
 =?utf-8?B?bjlXekE3V3RoRWlScWdIem92RWxsZGJLQlpWeGFEZHNzYlp2SHEyd3FFN1VI?=
 =?utf-8?B?dTBjUVZqek15SXVad1dLUXNmRDBrQWdjcjd1dldpRUlhdFh2d1h6TXlOdjFH?=
 =?utf-8?B?N05YTlF0MjJFYjlKVllqb0dDaDJuZU04VWljZ3pwa2traThYbjV0VW1MZisz?=
 =?utf-8?B?VWl4MjVoUjFYZjI3NXBPRmZLcys3WExnNnNqTEpkQWc2RmRLSDRmMDdXOGlK?=
 =?utf-8?B?WkF4VVhJQS9uQmxUbFZUWGdnRzRETWM1OG1mUU9KclNkZTBJR3F0c0lXL1Ni?=
 =?utf-8?B?Q2xDZmtqSjhSUWlUZ0grNDhaYVFHTzdLNWNWUC9LOTQxZk5IN2J4OGU2dmNF?=
 =?utf-8?B?ZnVpTFVCblIwcDU2c2ZjOE9iaXBMVVBVa2pldmd4Skh0dWtmUjV1eVZNcXhT?=
 =?utf-8?B?WGMxTjc1U3Y5S2lMQlRXTndFZTB6SFNMbENOeTgxdjFSVm4rKzZTMms1d1A0?=
 =?utf-8?B?NDJXRmtuRVoxSk92WlFZKzFIZ0dvb1UvUEhOcTUzZWNiRVdSeTZDM3V3d1JZ?=
 =?utf-8?B?azI2aFFMOW1nQWI3SDVtZWhyWTM5UnRjeGlINDJXRXZVWDNrdkJDRENabk9k?=
 =?utf-8?B?NDgzRXZtaDJZRXVEcDVlQ0FPZ0E2cnlUOWdmVThmeGwzRVlqQ0VTMmlaaTJp?=
 =?utf-8?Q?uCH4V+zo+dqbPKtpaO1ZnH46B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9101D4C156C7E44AA2BBFBC954433E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aaac8b-fdc0-41d6-70ab-08db89da938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 11:06:47.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzA9h8XQMhDtx/Yr2EyQLXCGnBO67ywDlzlR7qK86B+y4Rs/TSWlXYY5pU40aA8VcNJgjSn78zwcpwyPz3zcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDEwOjAxICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDU6MTk6MzBBTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gDQo+ID4gU29ycnkgSSBnb3QgYSBidWlsZCByZWdyZXNzaW9uIGZyb20gbGtwOg0K
PiA+IA0KPiA+IHZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogX19oYWx0KzB4M2E6IGNhbGwg
dG8gX190ZHhfaHlwZXJjYWxsKCkgbGVhdmVzDQo+ID4gLm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+
IA0KPiBDbGVhcmx5IHlvdSBzaG91bGQgZW5hYmxlIENPTkZJR19ERUJVR19FTlRSWSBpbiB5b3Vy
IG93biBkZXZlbG9wbWVudA0KPiAuY29uZmlnIDstKQ0KDQpBaCB0aGFua3MgYSBsb3QhDQoNCkkn
dmUgYmVlbiBpbnZlc3RpZ2F0aW5nIGhvdyB0byByZXByb2R1Y2UgYXQgbXkgb3duIGVudmlyb25t
ZW50IHRoaXMgYWZ0ZXJub29uIQ0KDQpMS1AgcGVvcGxlIGFyZSBub3QgYXdhcmUgb2Ygd2hhdCB0
cmlnZ2VyZWQgdGhpcyBjaGVjayBlaXRoZXIuICBJJ2xsIHBhc3MgdG8NCnRoZW0uDQoNCj4gDQo+
ID4gVGhlIHJlYXNvbiBpcyBfX2hhbHQoKSBpcyBhbm5vdGF0ZWQgd2l0aCAiX19jcHVpZGxlIiwg
YnV0IGl0IGNhbGxzDQo+ID4gX190ZHhfaHlwZXJjYWxsKCksIHdoaWNoIGlzIG5vdyBhIG5vcm1h
bCBDIGZ1bmN0aW9uLCB3L28NCj4gPiBpbnN0cnVtZW50YXRpb25fYmVnaW4oKS9lbmQoKS4NCj4g
PiANCj4gPiBJIHRoaW5rIHdlIGNhbiBhbm5vdGF0ZSBfX3RkeF9oeXBlcmNhbGwoKSBhcyAnbm9p
bnN0cicgdG9vIGFuZCBrZWVwDQo+ID4gX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCgpIHVuY2hhbmdl
ZC4gIEFueXdheSBpbiB0aGUgdXBzdHJlYW0gY29kZSwNCj4gPiBfX3RkeF9oeXBlcmNhbGwoKSBp
cyBpbiAnLm5vaW5zdHIudGV4dCcuDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Nv
Y28vdGR4L3RkeC1zaGFyZWQuYyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC1zaGFyZWQuYw0KPiA+
IGluZGV4IDEzMTM5ZWUxNzFjOC4uYjQ3YzhjY2U5MWIwIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eDg2L2NvY28vdGR4L3RkeC1zaGFyZWQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2NvY28vdGR4L3Rk
eC1zaGFyZWQuYw0KPiA+IEBAIC03MCw3ICs3MCw3IEBAIGJvb2wgdGR4X2FjY2VwdF9tZW1vcnko
cGh5c19hZGRyX3Qgc3RhcnQsIHBoeXNfYWRkcl90IGVuZCkNCj4gPiAgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC11NjQgX190ZHhfaHlwZXJjYWxsKHN0cnVjdCB0ZHhf
aHlwZXJjYWxsX2FyZ3MgKmFyZ3MpDQo+ID4gK25vaW5zdHIgdTY0IF9fdGR4X2h5cGVyY2FsbChz
dHJ1Y3QgdGR4X2h5cGVyY2FsbF9hcmdzICphcmdzKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1
Y3QgdGR4X21vZHVsZV9hcmdzIG1hcmdzID0gew0KPiA+ICAgICAgICAgICAgICAgICAucmN4ID0g
VERWTUNBTExfRVhQT1NFX1JFR1NfTUFTSywNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29j
by90ZHgvdGR4LmMgYi9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiA+IGluZGV4IGFiYTU4NDg0
YmExMC4uZjEwYjBlNTEyYTM2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3Rk
eC5jDQo+ID4gKysrIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCj4gPiBAQCAtMzcsOCArMzcs
OSBAQA0KPiA+ICANCj4gPiAgI2RlZmluZSBURFJFUE9SVF9TVUJUWVBFXzAgICAgIDANCj4gPiAg
DQo+ID4gLXZvaWQgX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCh2b2lkKQ0KPiA+ICtub2luc3RyIHZv
aWQgX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCh2b2lkKQ0KPiA+ICB7DQo+ID4gKyAgICAgICBpbnN0
cnVtZW50YXRpb25fYmVnaW4oKTsNCj4gPiAgICAgICAgIHBhbmljKCJURFZNQ0FMTCBmYWlsZWQu
IFREWCBtb2R1bGUgYnVnPyIpOw0KPiA+ICB9DQo+ID4gDQo+ID4gDQo+ID4gV2UgY2FuIGZvbGQg
dGhpcyB0byB0aGlzIHBhdGNoLg0KPiA+IA0KPiA+IERvIHlvdSBoYXZlIGFueSBjb21tZW50cz8N
Cj4gDQo+IFllcyB0aGlzIGlzIGZpbmUsIHdlIHZpb2xhdGUgbm9pbnN0ciBmb3IgV0FSTiBldGMu
LiBUaGVyZSdzIG5vIHBvaW50DQo+IGJlaW5nIHBlbmRhbnRpYyBhYm91dCB0aGVzZSB0aGluZ3Mg
aWYgd2UncmUgZ29pbmcgdG8gdGFrZSB0aGUgbWFjaGluZQ0KPiBkb3duIGFueXdheS4NCg0KVGhh
bmtzLiAgSSdsbCBmb2xkIGFib3ZlIHRvIHRoaXMgcGF0Y2ggYW5kIHNlbnQgb3V0IGEgdjMgKGdp
dmVuIHRoYXQgaXQgc2VlbXMNCnlvdSBhbHNvIHdhbnQgYSBwYXRjaCB0byBhZGp1c3QgdGhlIGxh
eW91dCBvZiAnc3RydWN0IHRkeF9tb2R1bGVfYXJncycgZm9yDQpUREguVlAuRU5URVIpLg0KDQoN
Cg==
