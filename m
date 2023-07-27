Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6644766004
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjG0W6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjG0W6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:58:16 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D894
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690498696; x=1722034696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vkBBbL1rqykq70Xbw+93leU76am0yD/GYCaLy3H9mUA=;
  b=m2ANxTU3tS/BQhuq3jvXf6gUfuXUK+vCh9SwXtDulzERwuEyEZKnY3lU
   1rs20VPQPGjkh2yz5gm7N+n40z6/VQy538jwGkAuIs0U3pHUufQESRLWF
   0cUEps3g2xbjIIlfUty+UjYJYyHizfMz6jH+P+uwxpGzZ5ul+PMOdgWQA
   ehMDWHgtZBVZGR1DVBXUMTD1hnY3zxN2onmvCmvI7RH9IlkJFC+XZdWJ4
   LF6+cvfHhbPWS/o/eD2byNoWIE3Mr+9Mn5ICGcZ7qaV2/+hkIeyyI3cCl
   acnQWGzEB516Czy5U+urqBBLlscM1qVRwwOdWRuwKn7LDhfj36JB7NghU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348060666"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348060666"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 15:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="1057895496"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="1057895496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2023 15:58:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:58:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 15:58:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 15:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsmTfYTrvRUykazZ/1P2XEsHjPoBIrdJzP1HJVAWSP5cQ1htZUDyeq5A0u0b3fLxlGojZFJU3jFxSFfoSruZf5pe9oOtzSRGahGrbIkC21UahL8ybon2uvhoqyBh2340gIejuOjNIej99ExpUgz8DQ8w7a2pHShVRSJln+9AVlPWzZdDqtwzH3G4801+ORJH0qqGg5s+cyT7gjO3N8Qau3B+c/4tFEq2vC3SG37Sa8vrXBnlA28wuDzzP8mUdcPi4Fnx5iYSqgKcMjdG8EOW3jyD91ghXhNj7hHzOeVLTMxcmn7BPnZIoGugTPLsk6jaYqyPGAN2GY8H+ABQRzPqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkBBbL1rqykq70Xbw+93leU76am0yD/GYCaLy3H9mUA=;
 b=JKpiwnodIwi7Oo8wqCKVfUWcVeHlCqf5fprP2P0jHPz5Crdu0J69/0sZV7gosOMgfykJeOVCx7jNUFdGG/AZ21ljhfLgGpwQo2H9XcoOFL1rep2pLx1frZaxw97OtEV68PIe+eBzWwfooIOhi6bRJEjVCD12RbpLNEQq8wcI4FpZcBRUaDpWHIdgaL4HVqq0I0XSP1uI2+NzBozytM3HlDNOK5erh3RPHKQVbcJfSasUQoLSSTXb6JTeYDzEzo6UTuMp9seZ+FxPzEHo/oE5h1iqupFsPevNNWCiJKueOmEiMfQ51C8iWgOQEVOGbnQURKNnFH7wSfpkK9DycRUaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 22:58:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 22:58:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Thread-Topic: [PATCH v3 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Thread-Index: AQHZv7EqD9VrPyO3R0u6CRRsPWAafK/N1aSAgABmmgA=
Date:   Thu, 27 Jul 2023 22:58:12 +0000
Message-ID: <85b0ce940836b54813c07ff4a8215bb9eb9e4a13.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <3d91bb67e17270d6df6c09308861961e04c13921.1690369495.git.kai.huang@intel.com>
         <20230727165057.rdn4txmzdh4yorw5@box.shutemov.name>
In-Reply-To: <20230727165057.rdn4txmzdh4yorw5@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: 409f382a-5a78-4abd-dc4e-08db8ef4f437
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02v0gpvNFyOJCSaYnifljUgTAFor/+yJIfS8FmetZpuQvuY/JYs2c5WhN01A/64X42dy56Dc0eKaYbVEHecyoXMeDXpUyghTgBDqrDR33FhiCeibNyi/GDh89DM4Nd+s1lLK5GVsZS5J16Av3x+Waa4ArsUVNmc2hytiZTlU6G6Fyg0D8NYDfXh99EIxO6h/qunScJSFsg5Ty8onBuaRoEca46BHop7lTOOAyP47sXC5MC8uPcriybKygNtq5XN2FQ65CvgmAO/gMLama8+t1FGwj9TQvc9TiVZt9EEDfqmz6weIcFvkDjkDgUr9k3SuE7QxxhBXXcE5E7fXWANlnc7xrsF2pwOfblt3D2u7dJnRoVXbTxsDqt04PphDjz7rIcDHRDwX2R0sInEfmHtvDTlOXyNhsxrocPs9C3FgJ52t67pwISVF/85ipf00NfpvBaNTeC1MImMb1vgHdD7aFsUBKNSeKmhyjSGAvuzUf5IIXlAR6ZvWHK7g3lq4Zmg+RpaVP9XqXplcSz7fd7ocg15lqrD+OSZNYhzkyeVMqrDyc0+79E6hi76IOAmDFco6P490s0ciWneCZm9jZKGJIMslW+PpF7+JH0/Y8tvD0KAQ/SnsnrWBc4udEOwpxCIn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(316002)(2906002)(8936002)(8676002)(7416002)(5660300002)(38070700005)(41300700001)(36756003)(86362001)(6486002)(71200400001)(122000001)(478600001)(26005)(82960400001)(6506007)(186003)(54906003)(2616005)(76116006)(66946007)(66556008)(91956017)(83380400001)(6512007)(38100700002)(64756008)(66476007)(4326008)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZURmVmROUXpJVTlZb1V2bVJkb1RvZFFScW56RkNkRWRPdk9BOE9JMjM5Rnhz?=
 =?utf-8?B?alhZd2p4VHlpRTVEWkdLOXQ0bkh3emJURFExZmhPSmRkWGdiZW01cng2Y01y?=
 =?utf-8?B?aU1KSHJQdUdjUUJKbDk0UjdCUmx5d1l2eVc0TCt4RUk5aVQ3QjRmOUk0QVZM?=
 =?utf-8?B?dS9oNWgyMDRnMzFYMFVkUXYyRk9wQk5YdXlzVUlRRDNsVjJDVk9NbWE4ZG9z?=
 =?utf-8?B?WnRXRW5WTG5JU3d3QjRjYlZoNGdZVThKRDZRVEtlU3ZES1RQUWQvUnlKTFFm?=
 =?utf-8?B?RnJPRjBydWtZQVVVQjN2cWdLYTF6Vk1uVi9yd0JQNGN1b2tIUXpqaXEwQWpp?=
 =?utf-8?B?cmRFZ0dUYnZqR2J5Vm9SZ0dYNWhxUGV3L1N6NWJTSFhQRWp3TE5jM2NGU2Y4?=
 =?utf-8?B?STFWSTAwTmM1UFdhOTVMbWVmZXJoQ2MrY2FVdlBHbDFQRzlDb0tyWnVZdUVt?=
 =?utf-8?B?bURhckxRQlpYWXcxZnhEeVVJQThRR3lMdWNmMjBxaXJIYjdJcWdURTlZNmhl?=
 =?utf-8?B?a05RUmxRaUdGS0l1bEx3a01Rc1F6RkMzTnEwY045MjlKK0RWakhWczgzb3pa?=
 =?utf-8?B?aXBCd3lCSDl1d1ZOcHNVUjNFa2hyTVY4L0w0anNPM3dqS2NmYzduVTA3VWFI?=
 =?utf-8?B?dERuUlZLeDJwTVVWODV1N3VNd0JjcS9WeGtTSWJrQktsNi80RDAzQ0pYYjBQ?=
 =?utf-8?B?MUJTSEh5RVNLMmNlNUVpQnp6eFZOSExMbnZ0aitFQ3cwNFJsY1pndFUwTzQy?=
 =?utf-8?B?eEdHRlpNNkk5UHdwN3BvMHE0Zms1dWhUY3Nva2NGemQ1UHJWL0R6aS8wSTRh?=
 =?utf-8?B?cE5tZ25lOUJFSkJDaGNlY3BMb0d0cE5XWDkycEVhSU5YcEpNVGlyMjFaT3Fl?=
 =?utf-8?B?Vi9ud0xLbUFiaFBRUVVCZmRMMkRkeW1rYUQwZHdPM0llY21Sb2lXeDdYdUdh?=
 =?utf-8?B?VEdDK20yMzVSMHY5Wkg0aXdpM1cxYWZuclRGNXNIQlRWWDZDdmhIOVAzRFMz?=
 =?utf-8?B?bkU5eVNZUDZYRXc1TzZ4UGpHT000NXFUc3FVNkVOaUpUUldQdmRtbS9PTGVs?=
 =?utf-8?B?UkU4MjFFWDRpaVNnOVNhYzRhRGtPK2I3YUROT2J0OFZqOUpWZWdGUWJxVXdI?=
 =?utf-8?B?bDRNWXpieVNOVEN6eE5GSjhpK0JpMnZDamNHK09XVkg1SnM3dWRablpiaGta?=
 =?utf-8?B?MXloR251WEJZYWRQNlY1Ym5na1p3Q3dWMGFPUW8xandpZ2lIUUNQbC9STlU5?=
 =?utf-8?B?OG5taFUrY2RLeTRQVGYvWXQ4Zi9XU1NpNVl6K2o1YS9YV3JqN1VxQzJHeDUr?=
 =?utf-8?B?dEVSUkdzUzdXeFdzU1lOY3pBWkt1MGEyNnpYVWJKd2IxQ3o4VkRRRUtuSm11?=
 =?utf-8?B?SCt6Y2Q3VWNNVXJaV2xqbU5palNDdEdJeHJpZ2hkMnlqQWlLRGJ5VjJQWXZi?=
 =?utf-8?B?YjAvNW9tZnIwVXByaUlxejQrczA2WmZYa2ZGSVNkTk92TnRsZGlPNTVDMjVa?=
 =?utf-8?B?RDNRTTRSTkRKelNCK0gzaGo1UjRsTnVsUzZNOHRtdHBDbVlqeFVTb3Y0clIv?=
 =?utf-8?B?M295eUs1Njlpemd3Mjh0YjRpWkQ1bElMQ2RkVGdlbUx2TFNXNElFSFEwUDJt?=
 =?utf-8?B?Qzh0K0xxQ2pEWk5KVEVCc0Y0cUJCNi9wM1BmdnlqRmgwQkEwa1ZnMU5FNFBK?=
 =?utf-8?B?Rm5vd3hZaWxIVFppYjhWdHpwMjZXV3lnblhINWJEcVYvdUM4b0Z0WGpkNG1k?=
 =?utf-8?B?T0Z1Q0J0MTdWTEg3V1V1TEpQa2pEQUd1SEc2ZVE5VVVYZXlxUHVNV2ZBR04y?=
 =?utf-8?B?UmdObVVLcVlmQkN1WFMxTkdjWVZXRDlXODlaRTRBZ2hsVnYrTGhHK0VlTEVo?=
 =?utf-8?B?bmVKTHZPMC92MUV3VzY1SDZUK3ZGeHFKNUJ5WjloWlYvR01pYVNnS0JOejlG?=
 =?utf-8?B?aXJDNm9zZmhmODJkOC9TcCs3YjFhSlpFalRYYlI2aHRWYkZrZHdLdEF4QjQ5?=
 =?utf-8?B?anVBZnNyRmNpZFY5ZURQY05hY0llZk9VUGdjYXJJMHlpUUpCUGhUemg5NUVQ?=
 =?utf-8?B?dnFhVjNvbEQxNVl0UUlXTjA2Y0tyUUFadjJmeE1yS0FmcWlVMjgweEdrUDZs?=
 =?utf-8?Q?GXV0m70h0wRUvddfxV3iFQH6Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8D87EE4C2EA0643B0B6C7C913A610C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f382a-5a78-4abd-dc4e-08db8ef4f437
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 22:58:12.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAoFnfA8eLSctzgFKOyxQGQbd24emdR9P15G9EqqUeoPmMu+4+EHFJx40WYPSIhPr0DcfVYAl80mKDVhQYwP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDE5OjUwICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNTowOFBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gQEAgLTY0LDYgKzEwMywzNyBAQA0KPiA+ICAuZW5k
aWYNCj4gPiAgDQo+ID4gIC5pZiBccmV0DQo+ID4gKy5pZiBcc2F2ZWQNCj4gPiArCS8qDQo+ID4g
KwkgKiBSZXN0b3JlIHRoZSBzdHJ1Y3R1cmUgZnJvbSBzdGFjayB0byBzYXZlIHRoZSBvdXRwdXQg
cmVnaXN0ZXJzDQo+ID4gKwkgKg0KPiA+ICsJICogSW4gY2FzZSBvZiBWUC5FTlRFUiByZXR1cm5z
IGR1ZSB0byBURFZNQ0FMTCwgYWxsIHJlZ2lzdGVycyBhcmUNCj4gPiArCSAqIHZhbGlkIHRodXMg
bm8gcmVnaXN0ZXIgY2FuIGJlIHVzZWQgYXMgc3BhcmUgdG8gcmVzdG9yZSB0aGUNCj4gPiArCSAq
IHN0cnVjdHVyZSBmcm9tIHRoZSBzdGFjayAoc2VlICJUREguVlAuRU5URVIgT3V0cHV0IE9wZXJh
bmRzDQo+ID4gKwkgKiBEZWZpbml0aW9uIG9uIFREQ0FMTChUREcuVlAuVk1DQUxMKSBGb2xsb3dp
bmcgYSBURCBFbnRyeSIpLg0KPiA+ICsJICogRm9yIHRoaXMgY2FzZSwgbmVlZCB0byBtYWtlIG9u
ZSByZWdpc3RlciBhcyBzcGFyZSBieSBzYXZpbmcgaXQNCj4gPiArCSAqIHRvIHRoZSBzdGFjayBh
bmQgdGhlbiBtYW51YWxseSBsb2FkIHRoZSBzdHJ1Y3R1cmUgcG9pbnRlciB0bw0KPiA+ICsJICog
dGhlIHNwYXJlIHJlZ2lzdGVyLg0KPiA+ICsJICoNCj4gPiArCSAqIE5vdGUgZm9yIG90aGVyIFRE
Q0FMTHMvU0VBTUNBTExzIHRoZXJlIGFyZSBzcGFyZSByZWdpc3RlcnMNCj4gPiArCSAqIHRodXMg
bm8gbmVlZCBmb3Igc3VjaCBoYWNrIGJ1dCBqdXN0IHVzZSB0aGlzIGZvciBhbGwuDQo+ID4gKwkg
Ki8NCj4gPiArCXB1c2hxCSVyYXgJCS8qIHNhdmUgdGhlIFREQ0FMTC9TRUFNQ0FMTCByZXR1cm4g
Y29kZSAqLw0KPiA+ICsJbW92cQk4KCVyc3ApLCAlcmF4CS8qIHJlc3RvcmUgdGhlIHN0cnVjdHVy
ZSBwb2ludGVyICovDQo+ID4gKwltb3ZxCSVyc2ksIFREWF9NT0RVTEVfcnNpKCVyYXgpCS8qIHNh
dmUgJXJzaSAqLw0KPiA+ICsJbW92cQklcmF4LCAlcnNpCS8qIHVzZSAlcnNpIGFzIHN0cnVjdHVy
ZSBwb2ludGVyICovDQo+IA0KPiBUaGlzIGxvb2tzIHJlZHVuZGFudC4gWW91IGdldCBzdHJ1Y3Qg
aW4gUlNJIHdpdGggcG9wcSB0d28gbGluZXMgYmVsb3cuDQoNClllcyBJIGd1ZXNzIHNvLiAgV2ls
bCByZW1vdmUgYW5kIGhhdmUgYSB0ZXN0Lg0KDQo+IA0KPiBBbmQgcGxlYXNlIHVzZSB1cHBlciBj
YXNlIGZvciByZWdpc3RlcnM6IFJTSSBpbnN0ZWFkIG9mICVyc2kuDQoNCkluIHRoZSBjb21tZW50
cz8gIFdpbGwgZG8uDQoNCj4gDQo+ID4gKwlwb3BxCSVyYXgJCS8qIHJlc3RvcmUgdGhlIHJldHVy
biBjb2RlICovDQo+ID4gKwlwb3BxCSVyc2kJCS8qIHBvcCB0aGUgc3RydWN0dXJlIHBvaW50ZXIg
Ki8NCj4gPiArDQo+ID4gKwkvKiBDb3B5IGFkZGl0aW9uYWwgb3V0cHV0IHJlZ3MgdG8gdGhlIHN0
cnVjdHVyZSAgKi8NCj4gPiArCW1vdnEgJXIxMiwgVERYX01PRFVMRV9yMTIoJXJzaSkNCj4gPiAr
CW1vdnEgJXIxMywgVERYX01PRFVMRV9yMTMoJXJzaSkNCj4gPiArCW1vdnEgJXIxNCwgVERYX01P
RFVMRV9yMTQoJXJzaSkNCj4gPiArCW1vdnEgJXIxNSwgVERYX01PRFVMRV9yMTUoJXJzaSkNCj4g
PiArCW1vdnEgJXJieCwgVERYX01PRFVMRV9yYngoJXJzaSkNCj4gPiArCW1vdnEgJXJkaSwgVERY
X01PRFVMRV9yZGkoJXJzaSkNCj4gPiArLmVuZGlmCS8qIFxzYXZlZCAqLw0KPiA+ICsNCj4gPiAg
CS8qIENvcHkgb3V0cHV0IHJlZ2lzdGVycyB0byB0aGUgc3RydWN0dXJlICovDQo+ID4gIAltb3Zx
ICVyY3gsIFREWF9NT0RVTEVfcmN4KCVyc2kpDQo+ID4gIAltb3ZxICVyZHgsIFREWF9NT0RVTEVf
cmR4KCVyc2kpDQo+IA0KPiBPdGhlcndpc2UsIGxvb2tzIHNhbmU6DQo+IA0KPiBSZXZpZXdlZC1i
eTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
PiANCg0KVGhhbmtzLg0K
