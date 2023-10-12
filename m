Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A57C64EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjJLFxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJLFx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:53:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213D9D;
        Wed, 11 Oct 2023 22:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697090008; x=1728626008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2u2HMTex5UqYHj3KPeGJE2Xma8qL3f5lP1p/rERtz2k=;
  b=Hv0l2sz4sqSeIsfgANJ1/roG0Dh19BwNE0u/yYexTNxpkOaLbG6KnjE3
   K3pCaBklvvxgQzb1nfer064F0SBWk+dwkx8ylJvmhcJ6JoytjG19g4vbb
   S17cBaJsw9eZLvgGvQMQ/iCI4PbnarNg5dFKj3Szb1Kz7ahAd/NfMvvxe
   gaE+Ns9k4fmIt9vacSL9F+VsF1lbm+0Tp2/YYW5St/nWjsCn0PxZQmTAe
   DUH3Yc/R+0XEy2MEJTkDIKK/DkOZtq7cj34UPFTykkfiRxBlq8FVmMP44
   DcpjwjeU7PpQF3hp7eas5CYjEJMT9JDP+zlTtqukK4IR3zx2P8Z5dzvga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="375192722"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="375192722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730789966"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="730789966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 22:53:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 22:53:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 22:53:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 22:53:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 22:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0ZC4ztlV9RN55EAfGYOvDbidtL0vjxBifWIV+E+LWG2r0w5Z4BN2gzxsEk35ZuSLQ/u/wgCOHTl0HC3dS6SzHEz7V1djUVMGoovL2Uo7ZYFwgmyaxChGnMNwRhPtEj64rd75grx+WEzeDdc/5bw1skWezU6bZ2xgF/f1g50xn3rfuJSvMKkouQ5VEODILYgUJiXt+vuQ+M2UFAM/bi/QJXa64tshJuBXlfMRN2XskGrJUdmxw0JcGU+MPt7xUOCG8R/mnmlF5sTa7Jd8BZSEHDaBrUiMmzGq0FnTnBOzt++FKzVoDgvJqGHnGzRyhyw2XIdVJ2Wr+ebj31yRJb+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u2HMTex5UqYHj3KPeGJE2Xma8qL3f5lP1p/rERtz2k=;
 b=Y8RaVXAJ7qKTVQvjnZ+lNTaK9qzN3j7aZ+W9jKuam6jXHrBJM58gmZcon/JPMJ7kJXjwem6s3eZdnnni32qAoL270s5heKZcwOYZQ9r3xBFajyRPGpfby4UNTXkGBHcSzVguJeNMWrgvQouR/h8ZHxuFe58TJ8hVlePvEb0laKsTafeM8u+s6wWcULz6wYdO7LqCC3Kke8knUSgYq9QW4KYQ+I02siQLm5MUsBLbp4a9MPZmGuotl5MjbyH1vwe3EopVIulpGaRWRaxwOM1n+idmsFf3Cum9iiaYF5gWDs3EEUIvaHTInjPmV+kidsxq3jBqiBqyt59n/W1J6D4mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 05:53:23 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:53:21 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZ97pKI6hvp9K6YUusBrDLSLOwW7A+CSq7gAOLEoCABB0cgA==
Date:   Thu, 12 Oct 2023 05:53:20 +0000
Message-ID: <f0d385f1c1961a17499e5acccf3ae7cdadb942cb.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
         <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <831b9b12-08fe-f5dc-f21d-83284b0aee8a@redhat.com>
In-Reply-To: <831b9b12-08fe-f5dc-f21d-83284b0aee8a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH0PR11MB5564:EE_
x-ms-office365-filtering-correlation-id: 0fb2a9d3-13f5-47d6-0ff9-08dbcae78a0c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Anb++QQs8uuQcwW+1XhXX/+oageb6MC0C0c3tHIVMskNtr1dfvo9+jWqptX6iylPTVwvRgL7ezb3KvWHiuyWh1+jV7fio4gxcCfq68ElqAXSGyCOEGSU4g8fESTDWRc82Uk/3tADx756aCrUiGePhyu9BSar9ZFZbYryuW2crIXZtXRJdAPmByQ99qg5eeXA/JmYFZyQ7omBkrN/3bZspDNgrATDeJo+w8Hd4ws5wWr0Vo1SMLwwhjtelq+OYcfFE5lfhQtFp5wpPp4ME34nzT7Psqcvmf6KlI3Oml91ZD6fTdkKQLBkZ3yXClcte8YyQ/n5j7rNALVelYSsoXmAX5ACD8YFcb51859Tbr8pm/eKBaZZOYcU9pjQxGeuGd5Wx26OVx+bhuQAzTKNhP85CbHqZogAQpH2FhqG7S2ED2FyfClZ5nxwPtiBsLzpZ1ZPT9Y3cr3Hihe6uIWJBhBBxgmRhOcDNKcQZyxeMMjPvHlsZ/7Z5xUVtSjbgBwwDNCsrqumukDhVFxKJL8EHcRk8AZnGugCEYisRdvzgrMYrt1aztiYebC05vuuCv+xaaA2fCQNmpzCw2Rk3oUU1shAvK7DIuYvKqZBrz2gqtoCv6KpsHgzxrCYnj63QYx7B3xF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(53546011)(2616005)(478600001)(6506007)(6486002)(71200400001)(26005)(7416002)(2906002)(83380400001)(41300700001)(5660300002)(110136005)(66556008)(66476007)(54906003)(64756008)(76116006)(66946007)(66446008)(4326008)(8676002)(8936002)(316002)(82960400001)(38100700002)(38070700005)(36756003)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk5yaVF6cS9uWHRhZW9wNm9hYjJKcFVQRHV3T1NWa3dUMXBKdVZQQ2ovRCtB?=
 =?utf-8?B?cjl6cFVjeHZsVTN2VGZRdm1xb3VCc1RnSnJHTEVhaVRCN3hjK1RRYWtVbjJh?=
 =?utf-8?B?ZlJNVFpnZjJ0c0hpRkxMWHpwelFaamtnTmp3Yk0zUDZtdnVmQzlRd0V6bFEw?=
 =?utf-8?B?K1hjNy9zbU1wTndaMGhvM0ZPUGxQY1JMS09mVlR3QWVEWlkwcy9nM0trZ2Nz?=
 =?utf-8?B?R3E5U0Q5aE56R1M4Q1Q5TzFpVVJYOUpOYllwWUtKY0lmQm81VE1WbmpLREZp?=
 =?utf-8?B?c2FHNmRlbENKYkd6SXZ5eGwweHR4Z2JMRGtZVURrSmpVcVpUS0Y3ZkF4V053?=
 =?utf-8?B?azZGSEF2RkZzaG5nOVJLZVZSbmErS3pBc01meFpJY014UnBEdTdYbUtYY0Vo?=
 =?utf-8?B?UGYrK0FRcnVlMHQ0MXRSVGRmalk0S05LYlFaeWRPcTFqWVJPcmEzWHROVHda?=
 =?utf-8?B?Q0pvNWp5RUZJTno2L1hZTzRFUGp0OFJWYWxRWDRKTWxaWEJ6c3R3UzVqbFpt?=
 =?utf-8?B?eU5ZdUxDQW9BdkJkNExGOUh5a3BtMEhnSDIwVWR2QlVicTVIRzRqWWJ3RXVr?=
 =?utf-8?B?Vkc0UkpveEg3Mk03TDI3b3F6Ym1aS0FUcm85eGhZMiswSDJIbVVOZytTVmM0?=
 =?utf-8?B?NTdhQlUrN1l0c1dFU01MUVdNNUJhSEN3dDVXSFc5bUNkL2FrbzNPcjBvc0Yz?=
 =?utf-8?B?Vk1VVktXdXhRTERPZHQvUW9JRFpqZWVsQkJHK0s2ZW9MZ2Y2NmhEUVRCeWI4?=
 =?utf-8?B?d2wxbGtmUkVXNTlkV3Q3Qnc1T1puQzJYWU5xQVI1UXNtRElSc0hrbFg4RThE?=
 =?utf-8?B?UG9yZ3RLVkZIdUs4TUl3UEN4NmxhQXl2MVJPQmt5TmJaeEpCUUYyR2xDejZs?=
 =?utf-8?B?aEhjamQ5VzUrdEJDdExrOFZiaHMxV0ZQL05LOHZSTGo0dHR0SStTa2VhenMr?=
 =?utf-8?B?NUVwcHNEZStIMXVFd2l0TGRhR29iR1JuS00rVDdNUFQ4UVplK3hKU2dUb080?=
 =?utf-8?B?NHFTdm9kRHhJbTU3Vk9hMW9JU1FWeXJ1eU5KTFB3Z3p3aTdJUWdVbFcwNXFB?=
 =?utf-8?B?UmRaL2FlTWJlV0p6UnRqZTJvMDN5UGVwc0h1ODQwMEUvbXZJcTJBVE9ZYzkr?=
 =?utf-8?B?Uzd2UVM4Z29ySVFscWpXUk5RbHptNmhMazduYVhXR3pORkM0Rzg1TW9oYnJk?=
 =?utf-8?B?bmM2bzdFMTNLOWRQaVVaSEEreStBaEhFd3lld3dsdWRJcCtLTmFkRlhGR1Zv?=
 =?utf-8?B?eG5mRGl1U3YyTXIxQ0FtNWhlOSt0NWk5NncxMkxxK3JvNnRYQkJPTVorWFN2?=
 =?utf-8?B?RUZldUR4S3ZQWTcxWVNQakM2MHFQa1V2Q0hUOWovVGxacnlLVlB0WUlpelND?=
 =?utf-8?B?aGlBYlJlTWFmZE9KY0hsSEpXVmE4Q0JsMDVlYWR2SU1rN2kxeEx1YjRiWW9P?=
 =?utf-8?B?WWlhOXRyYmdWRnNJUnk2SXI1WUdpTUVrYlZhUE1QdFdYajhiOVRjcXk4NENz?=
 =?utf-8?B?Ym16NCtvdmpUaTRFQkFEVlFGSXpVM0tKRFdHRzE2ZWdGalpYb1FCb0hlUVBi?=
 =?utf-8?B?eURzTjJpNnBKN2hCckVEWmNoUDJ6TE9TS3FTYzIydHBMUHhqUmlzWTl6Z3BD?=
 =?utf-8?B?L0M0YW5ldDhMeU8rQUl1T2JnSVhLaHEzMk5Ja1V3cXBsdFg5cGxKUUJFQ3I2?=
 =?utf-8?B?eHJOVzhwM1JaNXZmbVVxc3l6Kzd5dU9rY2E4Wi9kNi9McWNvOU9XWHdGQ2c4?=
 =?utf-8?B?UytUV1dmM2dmdzVPUGJpbjk2WVJ4MFFoRTVOcHBjdWJUbzIzSTZia2JWTThm?=
 =?utf-8?B?Y2x0WnM5bEUrbXJibGxGaDQzTWkrY0syOHJ0R3lRZUQyTnFPb0k2aFlRWlpM?=
 =?utf-8?B?SVVsMHAvaHRYRlZlcTNQL0JIb0lDbE5RSTVpT1I0L3VqQkQ3S09naHp2S1By?=
 =?utf-8?B?VGFHN1JCUXBndEFOUGJEM3JPM2JVQngxVmY1bmRiaUVRaThGVmpGSjRiRXoy?=
 =?utf-8?B?YTJXU1FCOFZWVDR6VThTZjgxTDFTOHlkaU8wdW8wOXNuQm1VazlqdHNyZDVr?=
 =?utf-8?B?Qm5vdzkrc2RIbFRvaHQ2QWZHZllHNFBmdmVoM2pOayt5Q0VSeStKeTd5MCtL?=
 =?utf-8?B?d1dqOVFFT3UwOHRlUGVJeCszUkpBMFk1bFlkOUVQa3B4WVc2VnRDRnNXaG1R?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBDC6B0617748E4982E6CFCB5CDA3C04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb2a9d3-13f5-47d6-0ff9-08dbcae78a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:53:20.5298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAwnIcO1BJhZ83E8nWIsJ4NshrPsel7R39NIvVlJiBdbBs9lrq/o647G1qqRpKKbjMSjh9IEZ3BQCLMENKe2n9/2zxReDJJVcWmojdudA5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDE3OjA0ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMDcuMTAuMjMgMTA6NTUsIEh1YW5nLCBZaW5nIHdyb3RlOg0KPiA+IFZpc2hhbCBW
ZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cml0ZXM6DQo+ID4gDQo+ID4gPiBAQCAt
MjE2Nyw0NyArMjIyMSwyOCBAQCBzdGF0aWMgaW50IF9fcmVmIHRyeV9yZW1vdmVfbWVtb3J5KHU2
NCBzdGFydCwgdTY0IHNpemUpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQ0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7DQo+ID4gPiDCoCANCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoG1lbV9ob3RwbHVnX2JlZ2luKCk7DQo+ID4gPiArDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgLyoNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoCAqIFdlIG9ubHkgc3VwcG9y
dCByZW1vdmluZyBtZW1vcnkgYWRkZWQgd2l0aCBNSFBfTUVNTUFQX09OX01FTU9SWSBpbg0KPiA+
ID4gLcKgwqDCoMKgwqDCoMKgICogdGhlIHNhbWUgZ3JhbnVsYXJpdHkgaXQgd2FzIGFkZGVkIC0g
YSBzaW5nbGUgbWVtb3J5IGJsb2NrLg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogRm9yIG1lbW1h
cF9vbl9tZW1vcnksIHRoZSBhbHRtYXBzIGNvdWxkIGhhdmUgYmVlbiBhZGRlZCBvbg0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgICogYSBwZXItbWVtYmxvY2sgYmFzaXMuIExvb3AgdGhyb3VnaCB0aGUg
ZW50aXJlIHJhbmdlIGlmIHNvLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogYW5kIHJlbW92ZSBl
YWNoIG1lbWJsb2NrIGFuZCBpdHMgYWx0bWFwLg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLw0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChtaHBfbWVtbWFwX29uX21lbW9yeSgpKSB7DQo+ID4g
DQo+ID4gSUlVQywgZXZlbiBpZiBtaHBfbWVtbWFwX29uX21lbW9yeSgpIHJldHVybnMgdHJ1ZSwg
aXQncyBzdGlsbCBwb3NzaWJsZQ0KPiA+IHRoYXQgdGhlIG1lbW1hcCBpcyBwdXQgaW4gRFJBTSBh
ZnRlciBbMi8yXS7CoCBTbyB0aGF0LA0KPiA+IGFyY2hfcmVtb3ZlX21lbW9yeSgpIGFyZSBjYWxs
ZWQgZm9yIGVhY2ggbWVtb3J5IGJsb2NrIHVubmVjZXNzYXJpbHkuwqAgQ2FuDQo+ID4gd2UgZGV0
ZWN0IHRoaXMgKHZpYSBhbHRtYXA/KSBhbmQgY2FsbCByZW1vdmVfbWVtb3J5X2Jsb2NrX2FuZF9h
bHRtYXAoKQ0KPiA+IGZvciB0aGUgd2hvbGUgcmFuZ2U/DQo+IA0KPiBHb29kIHBvaW50LiBXZSBz
aG91bGQgaGFuZGxlIG1lbWJsb2NrLXBlci1tZW1ibG9jayBvbm55IGlmIHdlIGhhdmUgdG8NCj4g
aGFuZGxlIHRoZSBhbHRtYXAuIE90aGVyd2lzZSwganVzdCBjYWxsIGEgc2VwYXJhdGUgZnVuY3Rp
b24gdGhhdCBkb2Vzbid0IA0KPiBjYXJlIGFib3V0IC0tIGUuZy4sIGNhbGxlZCByZW1vdmVfbWVt
b3J5X2Jsb2Nrc19ub19hbHRtYXAoKS4NCj4gDQo+IFdlIGNvdWxkIHNpbXBseSB3YWxrIGFsbCBt
ZW1vcnkgYmxvY2tzIGFuZCBtYWtlIHN1cmUgZWl0aGVyIGFsbCBoYXZlIGFuIA0KPiBhbHRtYXAg
b3Igbm9uZSBoYXMgYW4gYWx0bWFwLiBJZiB0aGVyZSBpcyBhIG1peCwgd2Ugc2hvdWxkIGJhaWwg
b3V0IHdpdGggDQo+IFdBUk5fT05fT05DRSgpLg0KPiANCk9rIEkgdGhpbmsgSSBmb2xsb3cgLSBi
YXNlZCBvbiBib3RoIG9mIHRoZXNlIHRocmVhZHMsIGhlcmUncyBteQ0KdW5kZXJzdGFuZGluZyBp
biBhbiBpbmNyZW1lbnRhbCBkaWZmIGZyb20gdGhlIG9yaWdpbmFsIHBhdGNoZXMgKG1heSBub3QN
CmFwcGx5IGRpcmVjdGx5IGFzIEkndmUgYWxyZWFkeSBjb21taXR0ZWQgY2hhbmdlcyBmcm9tIHRo
ZSBvdGhlciBiaXRzIG9mDQpmZWVkYmFjayAtIGJ1dCB0aGlzIHNob3VsZCBwcm92aWRlIGFuIGlk
ZWEgb2YgdGhlIGRpcmVjdGlvbikgLSANCg0KLS0tDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1vcnlf
aG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KaW5kZXggNTA3MjkxZTQ0YzBiLi4zMGFk
ZGNiMDYzYjQgMTAwNjQ0DQotLS0gYS9tbS9tZW1vcnlfaG90cGx1Zy5jDQorKysgYi9tbS9tZW1v
cnlfaG90cGx1Zy5jDQpAQCAtMjIwMSw2ICsyMjAxLDQwIEBAIHN0YXRpYyB2b2lkIF9fcmVmIHJl
bW92ZV9tZW1vcnlfYmxvY2tfYW5kX2FsdG1hcCh1NjQgc3RhcnQsIHU2NCBzaXplKQ0KIAl9DQog
fQ0KIA0KK3N0YXRpYyBib29sIG1lbWJsb2Nrc19oYXZlX2FsdG1hcHModTY0IHN0YXJ0LCB1NjQg
c2l6ZSkNCit7DQorCXVuc2lnbmVkIGxvbmcgbWVtYmxvY2tfc2l6ZSA9IG1lbW9yeV9ibG9ja19z
aXplX2J5dGVzKCk7DQorCXU2NCBudW1fYWx0bWFwcyA9IDAsIG51bV9ub19hbHRtYXBzID0gMDsN
CisJc3RydWN0IG1lbW9yeV9ibG9jayAqbWVtOw0KKwl1NjQgY3VyX3N0YXJ0Ow0KKwlpbnQgcmMg
PSAwOw0KKw0KKwlpZiAoIW1ocF9tZW1tYXBfb25fbWVtb3J5KCkpDQorCQlyZXR1cm4gZmFsc2U7
DQorDQorCWZvciAoY3VyX3N0YXJ0ID0gc3RhcnQ7IGN1cl9zdGFydCA8IHN0YXJ0ICsgc2l6ZTsN
CisJICAgICBjdXJfc3RhcnQgKz0gbWVtYmxvY2tfc2l6ZSkgew0KKwkJaWYgKHdhbGtfbWVtb3J5
X2Jsb2NrcyhjdXJfc3RhcnQsIG1lbWJsb2NrX3NpemUsICZtZW0sDQorCQkJCSAgICAgICB0ZXN0
X2hhc19hbHRtYXBfY2IpKQ0KKwkJCW51bV9hbHRtYXBzKys7DQorCQllbHNlDQorCQkJbnVtX25v
X2FsdG1hcHMrKzsNCisJfQ0KKw0KKwlpZiAoIW51bV9hbHRtYXBzICYmIG51bV9ub19hbHRtYXBz
ID4gMCkNCisJCXJldHVybiBmYWxzZTsNCisNCisJaWYgKCFudW1fbm9fYWx0bWFwcyAmJiBudW1f
YWx0bWFwcyA+IDApDQorCQlyZXR1cm4gdHJ1ZTsNCisNCisJLyoNCisJICogSWYgdGhlcmUgaXMg
YSBtaXggb2YgbWVtYmxvY2tzIHdpdGggYW5kIHdpdGhvdXQgYWx0bWFwcywNCisJICogc29tZXRo
aW5nIGhhcyBnb25lIHZlcnkgd3JvbmcuIFdBUk4gYW5kIGJhaWwuDQorCSAqLw0KKwlXQVJOX09O
Q0UoMSwgIm1lbWJsb2NrcyBoYXZlIGEgbWl4IG9mIG1pc3NpbmcgYW5kIHByZXNlbnQgYWx0bWFw
cyIpOw0KKwlyZXR1cm4gZmFsc2U7DQorfQ0KKw0KIHN0YXRpYyBpbnQgX19yZWYgdHJ5X3JlbW92
ZV9tZW1vcnkodTY0IHN0YXJ0LCB1NjQgc2l6ZSkNCiB7DQogCWludCByYywgbmlkID0gTlVNQV9O
T19OT0RFOw0KQEAgLTIyMzAsNyArMjI2NCw3IEBAIHN0YXRpYyBpbnQgX19yZWYgdHJ5X3JlbW92
ZV9tZW1vcnkodTY0IHN0YXJ0LCB1NjQgc2l6ZSkNCiAJICogYSBwZXItbWVtYmxvY2sgYmFzaXMu
IExvb3AgdGhyb3VnaCB0aGUgZW50aXJlIHJhbmdlIGlmIHNvLA0KIAkgKiBhbmQgcmVtb3ZlIGVh
Y2ggbWVtYmxvY2sgYW5kIGl0cyBhbHRtYXAuDQogCSAqLw0KLQlpZiAobWhwX21lbW1hcF9vbl9t
ZW1vcnkoKSkgew0KKwlpZiAobWhwX21lbW1hcF9vbl9tZW1vcnkoKSAmJiBtZW1ibG9ja3NfaGF2
ZV9hbHRtYXBzKHN0YXJ0LCBzaXplKSkgew0KIAkJdW5zaWduZWQgbG9uZyBtZW1ibG9ja19zaXpl
ID0gbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMoKTsNCiAJCXU2NCBjdXJfc3RhcnQ7DQogDQpAQCAt
MjIzOSw3ICsyMjczLDggQEAgc3RhdGljIGludCBfX3JlZiB0cnlfcmVtb3ZlX21lbW9yeSh1NjQg
c3RhcnQsIHU2NCBzaXplKQ0KIAkJCXJlbW92ZV9tZW1vcnlfYmxvY2tfYW5kX2FsdG1hcChjdXJf
c3RhcnQsDQogCQkJCQkJICAgICAgIG1lbWJsb2NrX3NpemUpOw0KIAl9IGVsc2Ugew0KLQkJcmVt
b3ZlX21lbW9yeV9ibG9ja19hbmRfYWx0bWFwKHN0YXJ0LCBzaXplKTsNCisJCXJlbW92ZV9tZW1v
cnlfYmxvY2tfZGV2aWNlcyhzdGFydCwgc2l6ZSk7DQorCQlhcmNoX3JlbW92ZV9tZW1vcnkoc3Rh
cnQsIHNpemUsIE5VTEwpOw0KIAl9DQogDQogCWlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX0tF
RVBfTUVNQkxPQ0spKSB7DQoNCg==
