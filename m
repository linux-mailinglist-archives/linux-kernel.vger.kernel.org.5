Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A7518FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjGMGpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjGMGpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:45:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF7173B;
        Wed, 12 Jul 2023 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689230744; x=1720766744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JmbkeDcODjTyFsMC23ohZWRiBnsOgeHA8XtPYBW5e18=;
  b=SQby0EOiPe7RZCXh0TsekFPxrW7egr9vdkeMQPUEXe/1gmsCnh+rw5fz
   Bq/qmRMKA+y0ZOEp6ItWphxqdpcotFwjD/z43JgUECbRpJAcstyEYAdN2
   KlgE+tF8viKP17MI2vZ5RiuVCznTkDOjb8Z7jddjUqWqHI7VJP2cA5wPg
   1+14tVGrQ8Kh9jnMdI5SukzBpK9IcKRD41rSw6vEsi0AROGDhVAsV//19
   PLwuC+ux4lE7Ud0U/GFduIedoErXECeIY18Ig0loIIPjteuDNeix1f9Pn
   edZOjlcF6RVZNZysM05dqJ4u0zwmdqiguc5RDZSHl9gykQsD6r+k3kkWJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451465436"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="451465436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 23:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791917092"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="791917092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 23:45:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 23:45:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 23:45:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 23:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6zF/J7WpSTFcMtrLV3ESpPBr4fg1YYw16yOiAj+bbXHbB7L/CDcezg9YFlutsbZ536j5wQWlsHi32Urt5lCAJjCdnQ9TBOVVnPu2etRsfEvSMCK61o0+U/QVvQq0IX0RC1EM/K6kLlIw82Hu4IKcT+Bpit2MZrei7M1Re9ByGpDz8ffRCX0dwUtiYJueMiutY6CcQfMzqMQp4D9Aw6XEO/jLELEn9THPufTlcWLSuugybC/fjL4SQsp8zbe8m0pvZvcb17uJ2qOgv+v+FkeJZet8lwOaOt7kr8FpNmxQPEKf32nEZLCAilu4IfS2UbGJ+gpWd5yeRykv/JdtY72OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmbkeDcODjTyFsMC23ohZWRiBnsOgeHA8XtPYBW5e18=;
 b=TVuDHgUS2g0d7rdXTQQ8DlYQTm9u3csPUnM4yklP8KaC99zRDVhDijeGIHc3LiL03VuNwyLE5Uy5sf6VL3Zo8pH9qA/zIlzO2QoH1JI9v07wS+9hL+H3XNGD7HN6lVXfypDXEh34+x16OTD5jkZBX/amuynRHh75383XVJkUTd3njEswOgYxHRdEUk7KOmMVxQjMHDWr7Hb1bvaDnHX2S54EJoq1WOtut9eAPFU219cC1eI69dqbLJTcM4ZDOCoD+llOmHpwJCdTa1YJ8z7bIQf5x+4MyOx7WsFgJOXwVMqrVfTeTBNXx5RIGlk+kEAUEWkTVocV+wfxtTQHpObxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 06:45:21 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 06:45:21 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Thread-Topic: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Thread-Index: AQHZn9Tstvh84woP/kqwvI9d+8RyUq+ND9wAgCe4+ACAAA4cAIAClJOA
Date:   Thu, 13 Jul 2023 06:45:20 +0000
Message-ID: <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
         <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
         <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
         <87edleplkn.fsf@linux.ibm.com>
         <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
In-Reply-To: <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB8599:EE_
x-ms-office365-filtering-correlation-id: 2588589d-0e54-4ca6-ba3b-08db836cba6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvAsxU1VFI6ElZg3KQNz8CSyLboQR5O0c40yvy2ETf7YnonvcVOBqVnFX9Ojdrxs/iIj3rfSMDLTpXzwNX6iEY3f6U0oAWRhFN/6rXMRPQw/gnq3mhjJDaHRNspacli6sDnHIwfB0P1jAZTNlkIvD83k2yPMpfK3QcH79wY3MzTc5bkAOQGc9YtscTW06aK2sB5IYfb1E++EWtyzVE+D83TLv9aXlyb3Lxrg5KrwMWS8g1lFlTSWHyxn4Ss9yph/ef8SlvcwcjJ7yUpmq49drumwJdwptTfWqOfSyZp0OrHWL/T3e7ihsuMpBg1DCx+EF+N/NlVa6Jyet74c0v6+KWZ29k2oIkauaw2GRnGBX3RAUwjyDhulzypbsKsuNjxGWgfKvrJ2H7FQVWErYTonWJVrobbTvRYf0tKTkeVxE9lI9BKP7StuEcFqZn3oTxiaxgbbT0YS4oSM82ZOwU/qpI5Wr8OQklIgyWQlHJuOuFQLSimrzLgX0uwZgpiIM5wIqKP1PG1kXiHQQz/wX23DJN9u9j/zY8LeltT8q7DWiyCR20qoossBZAPMHGa8g9kNa1vUrdJsWI3SAtR+H7XNeO/t2bg7aUEO8IylAtZZiEUueWiYWrK8xxjhLGQmo+xhhXsNqF6X4d5hyd4u7BhDgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(110136005)(38070700005)(478600001)(186003)(53546011)(82960400001)(921005)(71200400001)(38100700002)(54906003)(26005)(6506007)(8936002)(86362001)(122000001)(8676002)(6486002)(2616005)(2906002)(66556008)(66946007)(76116006)(66476007)(64756008)(66446008)(4326008)(6512007)(6636002)(83380400001)(5660300002)(36756003)(7416002)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG5TcXRZSVEzNTlodDc0aG9YT3U4SEppU3NSWnlFZXpkaXNGRVJ5QXRZbmdr?=
 =?utf-8?B?WjZtNVZEenpsL2l3NFNNbTlqQzJtRWQwYitrNWQ4VDRxa0lsRUx2MEZoc3Z6?=
 =?utf-8?B?UnlIa2NKNk04ZGZqVi9HWkFjNjV5MkVoejh4eGJHSFNLdElEZE9CNHRQbGdK?=
 =?utf-8?B?SnFvTHNwV3l4OVYzbkZRU0ttQzJvRXVmRXlneWxMRHJJTGMxc0FqN2thTnVV?=
 =?utf-8?B?M3d6RXE0MFYxMWtRR3VPZTBxbFU4VDRRemdhV3F2Qi9TakVTSlpEOUQrVmFr?=
 =?utf-8?B?QmpjTitXelFaZFovNGpKamdYMGVHdnZMQVM5UWl5V0tObHhPeUNpR3JFRHBp?=
 =?utf-8?B?aldTWW5hQVhGM3hUUHNDT0NjRlZ4Zkw3Zmk0UGV2WHY2VStBL2k0NlFiUmc4?=
 =?utf-8?B?TlBoZ0dQaHlGUE5ldWxyd01idTJBV3JUMGN1aFd1STljSU1oekVrakZKOWZk?=
 =?utf-8?B?TE84LysxMlZZczhsdlpWdGwzS25HbUZmN2VlNXhNMlNkbHA3WUZCd1c2U01v?=
 =?utf-8?B?Zmp1TUhiSHlUNlJEWnJXYjNQdXBWNWpnTnRtQlJHWVhncldPNVlYNm8xU2hH?=
 =?utf-8?B?clFucW9OR1prc1pDTVV3Nzdna3FTOVhDd3g5YjJmWlFkbzAweEZWc0pFUU8y?=
 =?utf-8?B?VUZvKzlEYTZGamJkR0lOakI4YUhKVVN2YStWNjMwcENTQmQ3ODV3NFU1a0Ew?=
 =?utf-8?B?ZWpLNFVvWlVHb0N0REViQTJRd0xWcGVWRnp6SVBCa2NzYVFjUk12cEF0UWlm?=
 =?utf-8?B?QTEwZ1F5c2dDNEprYnhiMTkwdWszdTV0a3FBYXArYXZBODEwdXRMOU5TZk5F?=
 =?utf-8?B?dUVQWDhRUU05MkxOQjRJVFYwZDBsQ1l4U0lYaGN0Qm9JcnFFVncwM1ZVcjVw?=
 =?utf-8?B?UU1EaHRQOUtmY0dGcCtXUkNoVzV6T3E2QUVHWVhGYVkxU3ZZN0MwUURFaGQx?=
 =?utf-8?B?Q2tyMXdtdDI0N2MyYjQ5NjFSa25pUG9wTzhSZ2R6RVV4N0pqdG0zc1hzYWV6?=
 =?utf-8?B?cUhHbllOY0NpZDNkSHE1S1VqSUQrSFRwSm0rUlQyMlJwWTd2QXMxcWVIZllD?=
 =?utf-8?B?SHZsZWlOY2dxWEhvc1JRNExuMldhakFla3p4TEtUWnhBSGs0MCtGNDJDeitP?=
 =?utf-8?B?dnR1dzhrZDFrd2ZiSlpUNStOaGI0bGVjZ3FYS20xNTlHZ2swK2RoQ3h2Y084?=
 =?utf-8?B?MXZ1dDJueHcrcG1TY3cwaVQwMUxJWTdlQ0NVWGcvTmhFZHZITnVxdisycnFx?=
 =?utf-8?B?Z0c0eS9oWWVxamNzZ0h2NWZ0ejNPRUFPRktTM3hjSUROL3ZhQVdrRkNyTVRr?=
 =?utf-8?B?aHN2RDdJNUY2NVNvL1BvTXViZld3WGw1N2FHd3VqeFREK0xlWTdIdFRWOGdP?=
 =?utf-8?B?Uy83dXdodlNTQVJtVDVKdzlpZzJqRVJqNHVPSklhNWI2VDYwbHlSZjNzK1FR?=
 =?utf-8?B?YmNqdkZUcHhhSjFzdzNaSzVHL2hMaUlBMHdtSy8vWlE0WFZja0FiMEdRbDdK?=
 =?utf-8?B?Z1F0dHFpQWRzeWJXUXIydmN2YytYTGhBMHdPbVZ0YzZISlhPUkVsYVFWK1JM?=
 =?utf-8?B?WXVIZkNpSVlGZHU0VCtab0U2NWxTaGgvcDViSWJ5RWZRMmdnTi95MVRzV3FL?=
 =?utf-8?B?RXF5cEh0TDRUSWJtSE1PN0ZYeDdaSXVtbEtwTUxTS1NTME4vOWRZTkZRZ0tr?=
 =?utf-8?B?ZkJibnBidlRZSkMxYUFQMzNSMmZWd0NWSkxoaTBZU1ViRFYyMUF1eVVTUzZz?=
 =?utf-8?B?MHRCc2twZDBZSXdMR0tZSmhCc1lKSGk1eGZaOXNiWERuM2YwbHhrOWRHUnNU?=
 =?utf-8?B?eitHWHkrWjYybmsyemEzaFNPNmhHbnZkbjluUWRBYjY5Z2kvcm1vM1I4KzlC?=
 =?utf-8?B?UXYyMWhrVVBsTDNPeEJkK1BtUVozcUN2RnJ4RmNBbExQZXVXWW4wVVlwblQy?=
 =?utf-8?B?RjZnSDlpKzlNWC9WSjhyaXlGMjVPckdIMkIrMTEwQXFBblJTN0xJTUdwT1FJ?=
 =?utf-8?B?Um1MUUhXbnBhU0VCQnEvVnlCWUNzQ3lpTndNK3A4ODd2NEVDbkphRXluZW9t?=
 =?utf-8?B?WVBJcTA4bmhVR0dzSUlYT1BRZmNNTFcwU29iMGhwQnFTWWR2UnFYdTUxbGZn?=
 =?utf-8?B?VHdFZjlhbGV0SVRmUWJqUGw0VkU3TDh5RmpteDJMTXNzUGM3TkRROE1WVzJp?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF8C49C6FC17CA4B940F0189DB2A3A8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2588589d-0e54-4ca6-ba3b-08db836cba6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 06:45:21.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BM7/rmnYCcAGrh+ErUw3S6bgNvIraCtTjHgsKOZCa5NcCWsCL8hlYJjyROJnmZ5MciVQJIRxCCie4HOfxuQIPFqOJ2NzRQkdLkXw/GhCqoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTExIGF0IDE3OjIxICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTEuMDcuMjMgMTY6MzAsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+ID4gRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyaXRlczoNCj4gPiA+IA0KPiA+ID4g
TWF5YmUgdGhlIGJldHRlciBhbHRlcm5hdGl2ZSBpcyB0ZWFjaA0KPiA+ID4gYWRkX21lbW9yeV9y
ZXNvdXJjZSgpL3RyeV9yZW1vdmVfbWVtb3J5KCkgdG8gZG8gdGhhdCBpbnRlcm5hbGx5Lg0KPiA+
ID4gDQo+ID4gPiBJbiB0aGUgYWRkX21lbW9yeV9yZXNvdXJjZSgpIGNhc2UsIGl0IG1pZ2h0IGJl
IGEgbG9vcCBhcm91bmQgdGhhdA0KPiA+ID4gbWVtbWFwX29uX21lbW9yeSArIGFyY2hfYWRkX21l
bW9yeSBjb2RlIHBhdGggKHdlbGwsIGFuZCB0aGUgZXJyb3IgcGF0aA0KPiA+ID4gYWxzbyBuZWVk
cyBhZGp1c3RtZW50KToNCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgICogU2VsZiBob3N0ZWQgbWVtbWFwIGFycmF5DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgICovDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1ocF9mbGFncyAmIE1IUF9N
RU1NQVBfT05fTUVNT1JZKSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmICghbWhwX3N1cHBvcnRzX21lbW1hcF9vbl9tZW1vcnkoc2l6ZSkpIHsNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FSU5WQUw7
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBn
b3RvIGVycm9yOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1ocF9hbHRtYXAuZnJlZSA9IFBIWVNf
UEZOKHNpemUpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtaHBfYWx0
bWFwLmJhc2VfcGZuID0gUEhZU19QRk4oc3RhcnQpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwYXJhbXMuYWx0bWFwID0gJm1ocF9hbHRtYXA7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgfQ0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgLyogY2FsbCBhcmNoJ3Mg
bWVtb3J5IGhvdGFkZCAqLw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGFyY2hfYWRkX21l
bW9yeShuaWQsIHN0YXJ0LCBzaXplLCAmcGFyYW1zKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAocmV0IDwgMCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBl
cnJvcjsNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBOb3RlIHRoYXQgd2Ugd2FudCB0byBoYW5kbGUg
dGhhdCBvbiBhIHBlciBtZW1vcnktYmxvY2sgYmFzaXMsIGJlY2F1c2Ugd2UNCj4gPiA+IGRvbid0
IHdhbnQgdGhlIHZtZW1tYXAgb2YgbWVtb3J5IGJsb2NrICMyIHRvIGVuZCB1cCBvbiBtZW1vcnkg
YmxvY2sgIzEuDQo+ID4gPiBJdCBhbGwgZ2V0cyBtZXNzeSB3aXRoIG1lbW9yeSBvbmxpbmluZy9v
ZmZsaW5pbmcgZXRjIG90aGVyd2lzZSAuLi4NCj4gPiA+IA0KPiA+IA0KPiA+IEkgdHJpZWQgdG8g
aW1wbGVtZW50IHRoaXMgaW5zaWRlIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKSBhbmQgYWxz
bw0KPiA+IHdpdGhpbiBkYXgva21lbS4gSU1ITyBkb2luZyB0aGUgZXJyb3IgaGFuZGxpbmcgaW5z
aWRlIGRheC9rbWVtIGlzDQo+ID4gYmV0dGVyLiBIZXJlIGlzIGhvdyBpdCBsb29rczoNCj4gPiAN
Cj4gPiAxLiBJZiBhbnkgYmxvY2tzIGdvdCBhZGRlZCBiZWZvcmUgKG1hcHBlZCA+IDApIHdlIGxv
b3AgdGhyb3VnaCBhbGwgc3VjY2Vzc2Z1bCByZXF1ZXN0X21lbV9yZWdpb25zDQo+ID4gMi4gRm9y
IGVhY2ggc3VjY2VzZnVsIHJlcXVlc3RfbWVtX3JlZ2lvbnMgaWYgYW55IGJsb2NrcyBnb3QgYWRk
ZWQsIHdlDQo+ID4ga2VlcCB0aGUgcmVzb3VyY2UuIElmIG5vbmUgZ290IGFkZGVkLCB3ZSB3aWxs
IGtmcmVlIHRoZSByZXNvdXJjZQ0KPiA+IA0KPiANCj4gRG9pbmcgdGhpcyB1bmNvbmRpdGlvbmFs
IHNwbGl0dGluZyBvdXRzaWRlIG9mIA0KPiBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCkgaXMg
dW5kZXNpcmFibGUgZm9yIGF0IGxlYXN0IHR3byByZWFzb25zDQo+IA0KPiAxKSBZb3UgZW5kIHVw
IGFsd2F5cyBjcmVhdGluZyBpbmRpdmlkdWFsIGVudHJpZXMgaW4gdGhlIHJlc291cmNlIHRyZWUN
Cj4gwqDCoMKgICgvcHJvYy9pb21lbSkgZXZlbiBpZiBNSFBfTUVNTUFQX09OX01FTU9SWSBpcyBu
b3QgZWZmZWN0aXZlLg0KPiAyKSBBcyB3ZSBjYWxsIGFyY2hfYWRkX21lbW9yeSgpIGluIG1lbW9y
eSBibG9jayBncmFudWxhcml0eSAoZS5nLiwgMTI4DQo+IMKgwqDCoCBNaUIgb24geDg2KSwgd2Ug
bWlnaHQgbm90IG1ha2UgdXNlIG9mIGxhcmdlIFBVRHMgKGUuZy4sIDEgR2lCKSBpbiB0aGUNCj4g
wqDCoMKgIGlkZW50aWZ5IG1hcHBpbmcgLS0gZXZlbiBpZiBNSFBfTUVNTUFQX09OX01FTU9SWSBp
cyBub3QgZWZmZWN0aXZlLg0KPiANCj4gV2hpbGUgeW91IGNvdWxkIHNlbnNlIGZvciBzdXBwb3J0
IGFuZCBkbyB0aGUgc3BsaXQgYmFzZWQgb24gdGhhdCwgaXQgDQo+IHdpbGwgYmUgYmVuZWZpY2lh
bCBmb3Igb3RoZXIgdXNlcnMgKGVzcGVjaWFsbHkgRElNTXMpIGlmIHdlIGRvIHRoYXQgDQo+IGlu
dGVybmFsbHkgLS0gd2hlcmUgd2UgYWxyZWFkeSBrbm93IGlmIE1IUF9NRU1NQVBfT05fTUVNT1JZ
IGNhbiBiZSANCj4gZWZmZWN0aXZlIG9yIG5vdC4NCg0KSSdtIHRha2luZyBhIHNob3QgYXQgaW1w
bGVtZW50aW5nIHRoZSBzcGxpdHRpbmcgaW50ZXJuYWxseSBpbg0KbWVtb3J5X2hvdHBsdWcuYy4g
VGhlIGNhbGxlciAoa21lbSkgc2lkZSBkb2VzIGJlY29tZSB0cml2aWFsIHdpdGggdGhpcw0KYXBw
cm9hY2gsIGJ1dCB0aGVyZSdzIGEgc2xpZ2h0IGNvbXBsaWNhdGlvbiBpZiBJIGRvbid0IGhhdmUg
dGhlIG1vZHVsZQ0KcGFyYW0gb3ZlcnJpZGUgKHBhdGNoIDEgb2YgdGhpcyBzZXJpZXMpLg0KDQpU
aGUga21lbSBkaWZmIG5vdyBsb29rcyBsaWtlOg0KDQogICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9k
YXgva21lbS5jIGIvZHJpdmVycy9kYXgva21lbS5jDQogICBpbmRleCA4OThjYTk1MDU3NTQuLjhi
ZTkzMmY2M2Y5MCAxMDA2NDQNCiAgIC0tLSBhL2RyaXZlcnMvZGF4L2ttZW0uYw0KICAgKysrIGIv
ZHJpdmVycy9kYXgva21lbS5jDQogICBAQCAtMTA1LDYgKzEwNSw4IEBAIHN0YXRpYyBpbnQgZGV2
X2RheF9rbWVtX3Byb2JlKHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4KQ0KICAgICAgICAgICBkYXRh
LT5tZ2lkID0gcmM7DQogICAgDQogICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBkZXZfZGF4LT5u
cl9yYW5nZTsgaSsrKSB7DQogICArICAgICAgICAgICAgICAgbWhwX3QgbWhwX2ZsYWdzID0gTUhQ
X05JRF9JU19NR0lEIHwgTUhQX01FTU1BUF9PTl9NRU1PUlkgfA0KICAgKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1IUF9TUExJVF9NRU1CTE9DS1M7DQogICAgICAgICAgICAgICAg
ICAgc3RydWN0IHJlc291cmNlICpyZXM7DQogICAgICAgICAgICAgICAgICAgc3RydWN0IHJhbmdl
IHJhbmdlOw0KICAgIA0KICAgQEAgLTE0MSw3ICsxNDMsNyBAQCBzdGF0aWMgaW50IGRldl9kYXhf
a21lbV9wcm9iZShzdHJ1Y3QgZGV2X2RheCAqZGV2X2RheCkNCiAgICAgICAgICAgICAgICAgICAg
KiB0aGlzIGFzIFJBTSBhdXRvbWF0aWNhbGx5Lg0KICAgICAgICAgICAgICAgICAgICAqLw0KICAg
ICAgICAgICAgICAgICAgIHJjID0gYWRkX21lbW9yeV9kcml2ZXJfbWFuYWdlZChkYXRhLT5tZ2lk
LCByYW5nZS5zdGFydCwNCiAgIC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2Vf
bGVuKCZyYW5nZSksIGttZW1fbmFtZSwgTUhQX05JRF9JU19NR0lEKTsNCiAgICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmFuZ2VfbGVuKCZyYW5nZSksIGttZW1fbmFtZSwgbWhwX2Zs
YWdzKTsNCiAgICANCiAgICAgICAgICAgICAgICAgICBpZiAocmMpIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIm1hcHBpbmclZDogJSNsbHgtJSNsbHggbWVtb3J5
IGFkZCBmYWlsZWRcbiIsDQogICANCg0KSG93ZXZlciB0aGlzIGJlZ2lucyB0byBmYWlsIGlmIHRo
ZSBtZW1tYXBfb25fbWVtb3J5IG1vZHBhcmFtIGlzIG5vdA0Kc2V0LCBhcyBhZGRfbWVtb3J5X2Ry
aXZlcl9tYW5hZ2VkIEVJTlZBTHMgZnJvbSB0aGUNCm1ocF9zdXBwb3J0c19tZW1tYXBfb25fbWVt
b3J5KCkgY2hlY2suDQoNClRoZSB3YXkgdG8gd29yayBhcm91bmQgdGhpcyB3b3VsZCBwcm9iYWJs
eSBpbmNsdWRlIGRvaW5nIHRoZQ0KbWhwX3N1cHBvcnRzX21lbW1hcF9vbl9tZW1vcnkoKSBjaGVj
ayBpbiBrbWVtLCBpbiBhIGxvb3AgdG8gY2hlY2sgZm9yDQplYWNoIG1lbWJsb2NrIHNpemVkIGNo
dW5rLCBhbmQgdGhhdCBmZWVscyBsaWtlIGEgbGVhayBvZiB0aGUNCmltcGxlbWVudGF0aW9uIGRl
dGFpbHMgaW50byB0aGUgY2FsbGVyLg0KDQpBbnkgc3VnZ2VzdGlvbnMgb24gaG93IHRvIGdvIGFi
b3V0IHRoaXM/DQo+IA0KPiBJbiBnZW5lcmFsLCB3ZSBhdm9pZCBwbGFjaW5nIGltcG9ydGFudCBr
ZXJuZWwgZGF0YS1zdHJ1Y3R1cmVzIG9uIHNsb3cNCj4gbWVtb3J5LiBUaGF0J3Mgb25lIG9mIHRo
ZSByZWFzb25zIHdoeSBQTUVNIGRlY2lkZWQgdG8gbW9zdGx5IGFsd2F5cyB1c2UgDQo+IFpPTkVf
TU9WQUJMRSBzdWNoIHRoYXQgZXhhY3RseSB3aGF0IHRoaXMgcGF0Y2ggZG9lcyB3b3VsZCBub3Qg
aGFwcGVuLiBTbyANCj4gSSdtIHdvbmRlcmluZyBpZiB0aGVyZSB3b3VsZCBiZSBkZW1hbmQgZm9y
IGFuIGFkZGl0aW9uYWwgdG9nZ2xlLg0KPiANCj4gQmVjYXVzZSBldmVuIHdpdGggbWVtbWFwX29u
X21lbW9yeSBlbmFibGVkIGluIGdlbmVyYWwsIHlvdSBtaWdodCBub3QgDQo+IHdhbnQgdG8gZG8g
dGhhdCBmb3IgZGF4L2ttZW0uDQo+IA0KPiBJTUhPLCB0aGlzIHBhdGNoIHNob3VsZCBiZSBkcm9w
cGVkIGZyb20geW91ciBwcGM2NCBzZXJpZXMsIGFzIGl0J3MgYW4NCj4gaW5kZXBlbmRlbnQgY2hh
bmdlIHRoYXQgbWlnaHQgYmUgdmFsdWFibGUgZm9yIG90aGVyIGFyY2hpdGVjdHVyZXMgYXMgd2Vs
bC4NCj4gDQpTdXJlIHRoaW5nLCBJIGNhbiBwaWNrIHRoaXMgYmFjayB1cCBhbmQgQW5lZXNoIGNh
biBkcm9wIHRoaXMgZnJvbSBoaXMgc2V0Lg0K
