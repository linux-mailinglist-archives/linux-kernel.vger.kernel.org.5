Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C067D2E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjJWJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJWJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:31:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BBDF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053463; x=1729589463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1xmeQbz0nrZdPT47tiJQg4qW/3NBRGUvgECMIwRgMGA=;
  b=bgaj+44ZV3belbdcxKmZwLNnlhf8+RrLfNEgUTZk16itmodTlXsy070l
   ZhwyRvzkFsqopBk2ennllrJnyB3orfJLVRhXWqydYTW1mpqRxLeATgoiL
   XR3WPvW73w/ucBzw/m55ODTG8z2iQzMY2r+RMHJVq+8/hYPYCCAvsPCTC
   aCz7/k7DT7a6heyPbU7OUT1dLAWYd3sYdIJPmg5u7HO9yUjUKlB3Tg+lX
   E92TZXOkxfl8S6uAlQtJT3//iEMCdfCAR6kGrsnoGba+pAwq1ObWNjzcJ
   rOProVMndBtbVYwT8IlOCJkQ5UrPQeaev4d/bGxE4pO6sIzTer1phRv4v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="371871315"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="371871315"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="901756193"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901756193"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:28:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:31:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICZND/DqIRqgXqADrIGc7T3KVUDtOdnXYdlyy1QlwnKRIG7N7dXZAv3fjE1XL33QJNTHgkkM/tfUg/YXZJASAmI3u+hrRc1CkR6izLWOK6siBp6ZLABm5rIkGCAQi7oW5xExO6RwZhsIYl7EfIEDS9lcUMz7hyRtkweGnQYEfy6oSXeaC/Hij+wccHTO3Gnv/QeMZiOc4lKZQ2wzfmVUAhXyWnh22GNf1PrVN3KwXxhYHjMBzbJIxBUSqaZY9AIgmEeXGD2DyQ5jU4ObWUA/n8Us0y8iWvFKTmqejTCCUuSf2KQceVPlctjpSN1SpaLKH3BZPoTkqxdwHyowZ8N3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xmeQbz0nrZdPT47tiJQg4qW/3NBRGUvgECMIwRgMGA=;
 b=SWPhTXuk/bTkkKVGPTO67NCzEMkII45GdAo4vH+6RVVvDDMTHXsoUYj40QY3ZxFAgNwpRYZXAxJ75tGKNYK/RieHXZuFbkoJ3DTYiOmpFTwzWmI4SpWNSdj12C+DOV74iinRTIKMplJ5cS5FHq+E3qlC6gAusXk0UZom9TTB7QLdtB834UNxHIiU3dmodCOG0MuxD+xFe6ly4w780jUdlWEP9b2O+OloWNCoorCEZgSvjQYAb3qHeyj080OXZU1nEuOm6CoaHYwO871jr6payKozdOnA/tnb+VyfowtW/IyPg/pJQ1mxD0NtjApKo4YCyd96Z3/nCp79i2jWclvXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5438.namprd11.prod.outlook.com (2603:10b6:5:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 09:30:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 09:30:59 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaA2fulhiwSXIJjU27xCEE2qMPErBXIG8A
Date:   Mon, 23 Oct 2023 09:30:59 +0000
Message-ID: <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
         <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5438:EE_
x-ms-office365-filtering-correlation-id: 4b508f05-d8e4-4ede-9495-08dbd3aac41e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5xzX0Yx7w4XfV+z2v8Wb5KSh4Z1gQdP2RS/Ktp3GQrhxekIe4UzMLfX/ZgSN0R7OHd89a4BjbXRMol3rFns+6V44V2eo7PRDl+DFALaFb7gvqPjL1l6DNvnrsni2QG3/bwa/O0q7IX25CdVrePWIu94AKc4ByK5TXBRQnXsG+Ws65BEuKjRvqpdd+sokQ6z7MLZBXU7wSpYMvVwC45tbb9Rd2ddlt4Cj4N77F5pssgB1Ko5E47gVxoxGyfwzz24m5Xrodj+FSks4qVivPD3kUn4i0+oOIFZ97Lhc8CkSz7MNKbdWLAfmHkKyuBqCzm0FIJfTfPRWXOF3LiOt7FB78BcvVtek6KKSTRczchBO5MPb5fnB8fElhPxNYMhEXx6oxqm11KN68ErA+S5fwtbr1Jr2c7ixHHPST/CqUXGXUfG0sXSNPJksxsChKrjin9TBEXDqoMBSpfPbC1xW2GLLTUXSh8qxftUOMmezlQciyyRRjF/OCsEONBhoHgL+X7iQnhumPLh/1faTtp8SEBBZlPXLHVI8kfiuzd3XX8GRoS0zFTOb32W1hnXyzFSHLkF5NC5u1R0egJKYgmSELaENAYupSa0DG3Cv5OWGYo/8o5lRPEzl269FmqnSPbF34Eu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(38070700009)(4001150100001)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(7416002)(36756003)(8676002)(8936002)(4326008)(6506007)(71200400001)(478600001)(91956017)(110136005)(122000001)(2616005)(82960400001)(66476007)(66946007)(316002)(76116006)(54906003)(64756008)(66446008)(66556008)(83380400001)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1o2QnhOZ0NoamRTWEVJUURNMW9JRkNvcGYyRFRIYkN4ZDNrR1VCYlEvRWM4?=
 =?utf-8?B?c0xjTmVkMXk1Ri9WQ2VMektaYWlWWHlLdXNadm0wZXBFT1c3dmk3NDNlakRu?=
 =?utf-8?B?WWdmazZpb3hPZWNIalc2U0kwT1hjL1lXeGZrVFJyODhaNDdtNVFiUXArd1pL?=
 =?utf-8?B?SXJpcDN2ZU1rNHR1SVVkN1BxZlptMGJzdCt0Qzk2Vm8yUUdUOU8rblgvNGlH?=
 =?utf-8?B?TFNOSVJ5RHRxdjNneTFNYmhSTitzOW5MaXVGYkpiWWU3cHJvb3JjbDY1ZVlT?=
 =?utf-8?B?bzltWnd5ekdiWS94anBZQXpGRmIzK3BSb29GYkR3OW9XYVpEZ0ZQZ29SRW1M?=
 =?utf-8?B?Mnpxb1dqZkJjeFVMNmlNRGZyVXFuZVRlNDMxZitDMWMyakxYemRrNkdsZVRY?=
 =?utf-8?B?cm84c01SWDI5TzVwWTFMZUFaQmUrM2ZQUUNMejkyYUtlK05OWDhBM29LZ3pM?=
 =?utf-8?B?eXU3L1BYRXN5cFYyVmhlY3NvTGdHZktxM3VFazhXNDB5LzhGeVhaYlZlS1Iz?=
 =?utf-8?B?eE5tVlNlZzYwZjM0eGNDT1JiQVRteDZZK3NPcWY2c0tYTmRocXg4N20yekw4?=
 =?utf-8?B?d0x2QjYvK2VpaHJnTngyM1hWSExwQlFTUEdLTENJQ2ZYU3RZM3Q2YkVWdzBw?=
 =?utf-8?B?enV5ZjE3bExNbGxlb0RXWDZGT2dtdlFBaFNSK09NUlZKSjJkRjBKY3RKSkRz?=
 =?utf-8?B?K3BycEFGTExJN3paTGQ2cU5BaTdEOEpocE1NS2tkOFRMT21iNGtKdG9HTzhr?=
 =?utf-8?B?UzJmekJBS2o1Zk16dlNCRDB0NDdDTFVnd091bUFWR21OV3FXSHl1dy9KSGpG?=
 =?utf-8?B?MFNmOFZndG80M2g3VEdNWjJTYmpYQklJWEVQOFdwOXlZeWxkYU4wS0pHd1BS?=
 =?utf-8?B?dzhwbXpNcWtzNE5TbGVuMDV0b0w1OUxOaVlTMVJnUGVKOGZnU1Q5WHA0cFNS?=
 =?utf-8?B?RGRidnhrcWJZWWM0dWxoNk9raW1HUlBieWh0WCtvR0d0U0pBcE1XVHpUOUZC?=
 =?utf-8?B?S0lKcERqN1VUZkk1U3ZkaXhwMmFCTWpORExFTEJrUHRaZDcwMzBFYThCMkcx?=
 =?utf-8?B?Nk0wMzc1Z3YzV2graE9oOVRQSy92MW9wdlVVdDQxVXlRS0tIQjczQ1hkVkxr?=
 =?utf-8?B?aUl6eVBQV1JSWFVhL09WR0xkd01RMlpXWkF1aWpubitsY3VMU2hsbkpIN2ps?=
 =?utf-8?B?Q2VZcmR1UFZjVm5qT0owbGVkUmZZY1F5T2U0eU5GQTl1dlcrMXlZcnBNT0VR?=
 =?utf-8?B?bnRSVHF6MlFFT3ZUTHhxM293aTdNMGIzRkFjeVlKOWNZaWFQTjNtUDNhMGhj?=
 =?utf-8?B?SHh4dDJYa1BNL2tDWkkrL1R4UHZ0QkI5VFhYeDArVVFlWElFVmFQQk5kN1Av?=
 =?utf-8?B?bmJjNzVIbkJtMUxiY2t6bnRYRlc5cEVqRVY3amUycHVCL0tVdk8yWkRGaEg2?=
 =?utf-8?B?VnR4TkkydE9UMXo3MzZMZVJSdWxTWFZ5WS9iUlZLVEZGblFCYTRyMUJkR0Nl?=
 =?utf-8?B?M1kvbDJyWGUyWEJ5andzRWxQOUQ5WXBSazFGTGF2VkthU2p4eFJCQ09md2h1?=
 =?utf-8?B?YVAwN0duY0tXWGxoM0NzM3NoSUpyN005RS85b2dTRm9mVTJIdmpHaThJTkZo?=
 =?utf-8?B?OGNHRVE2eGlIUXdvNHZ6aEZubDJLdTgxMUpmWGtDSmIxQktvZS9odlF3TmQw?=
 =?utf-8?B?V0F5OWRpQ0YvRm1NQS8wWVh0ODRlN01yQ0ZaOERLMzM2ZWNidm9mbjh5SWlx?=
 =?utf-8?B?UThYSDl1L3FGUGhzb2JjY1pkblRVVlBmbnFtVmcrc1JKcGlNbDNtL2ZIMldE?=
 =?utf-8?B?a3ExTWZNYnZGMlhRYVN6RFZDdDBHcDRUS3JTc1BObWcwZFBVa1ByK3dubGd2?=
 =?utf-8?B?VCtQMzNKMzVXMExoUWtXWE1hamc3a2tKSEg2eFRrUVVCOXpDdEdmUG5EVHo5?=
 =?utf-8?B?WTdmOUVyaHEwZXc0U0dORlk5QVAvSy94ZFQyQ0U1Zk5FSHhXK1F5VHFselBr?=
 =?utf-8?B?WkIrQUR4aDVRS2p4YVBMV1Ira1AwcVpvSzRnemlhMXBoZG9ZT1k3Q1huS2Vk?=
 =?utf-8?B?d21OSFpCakFqRGxsRzFHU2pkL2gyVDl4K0hyZjBzbFM1enY3ZXVIeU9BckV5?=
 =?utf-8?B?ZmFldXROY0VYb1o2VGtpd1Uzbkl1ck14Lzd1aXZLVGhZWG00Mmh0Zisrb0J5?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C784A48547D5A4A997D8F29325D9EDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b508f05-d8e4-4ede-9495-08dbd3aac41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:30:59.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oI/AO7TakQnhIU3M7LV7VXuZzNzwOFhLDR4wNDlQyvfFjw76MBSe2FX6YvAfonF99vj4lXq4LpLtzTA2G0t7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTIwIGF0IDE4OjEyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFDUEkgTUFEVCBkb2Vzbid0IGFsbG93IHRvIG9mZmxpbmUgQ1BVIGFmdGVyIGl0IGdv
dCB3b2tlIHVwLg0KPiANCj4gQ3VycmVudGx5IG9mZmxpbmluZyBob3RwbHVnIHByZXZlbnRlZCBi
YXNlZCBvbiB0aGUgY29uZmlkZW50aWFsDQo+IGNvbXB1dGluZyBhdHRyaWJ1dGUgd2hpY2ggaXMg
c2V0IGZvciBJbnRlbCBURFguIEJ1dCBURFggaXMgbm90DQo+IHRoZSBvbmx5IHBvc3NpYmxlIHVz
ZXIgb2YgdGhlIHdha2UgdXAgbWV0aG9kLg0KPiANCj4gSW50cm9kdWNlIGNwdV9ob3RwbHVnX25v
dF9zdXBwb3J0ZWQoKSB0aGF0IGNhbiBiZSBjYWxsZWQgdG8gaW5kaWNhdGUNCj4gdGhhdCBDUFUg
b2ZmbGluaW5nIHNob3VsZCBiZSBkaXNhYmxlZC4NCj4gDQo+IFRoaXMgZnVuY3Rpb24gaXMgZ29p
bmcgdG8gcmVwbGFjZSBDQ19BVFRSX0hPVFBMVUdfRElTQUJMRUQgZm9yIEFDUEkNCj4gTUFEVC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92
QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2NwdS5oIHwgIDIgKysN
Cj4gIGtlcm5lbC9jcHUuYyAgICAgICAgfCAxMyArKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2NwdS5oIGIvaW5jbHVkZS9saW51eC9jcHUuaA0KPiBpbmRleCBmMTlm
NTY1MDE4MDkuLjk3ODMyY2VkOTM5ZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9jcHUu
aA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2NwdS5oDQo+IEBAIC0xMzIsNiArMTMyLDcgQEAgZXh0
ZXJuIHZvaWQgY3B1c19yZWFkX2xvY2sodm9pZCk7DQo+ICBleHRlcm4gdm9pZCBjcHVzX3JlYWRf
dW5sb2NrKHZvaWQpOw0KPiAgZXh0ZXJuIGludCAgY3B1c19yZWFkX3RyeWxvY2sodm9pZCk7DQo+
ICBleHRlcm4gdm9pZCBsb2NrZGVwX2Fzc2VydF9jcHVzX2hlbGQodm9pZCk7DQo+ICtleHRlcm4g
dm9pZCBjcHVfaG90cGx1Z19kaXNhYmxlX29mZmxpbmluZyh2b2lkKTsNCj4gIGV4dGVybiB2b2lk
IGNwdV9ob3RwbHVnX2Rpc2FibGUodm9pZCk7DQo+ICBleHRlcm4gdm9pZCBjcHVfaG90cGx1Z19l
bmFibGUodm9pZCk7DQo+ICB2b2lkIGNsZWFyX3Rhc2tzX21tX2NwdW1hc2soaW50IGNwdSk7DQo+
IEBAIC0xNDcsNiArMTQ4LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGNwdXNfcmVhZF9sb2NrKHZv
aWQpIHsgfQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIGNwdXNfcmVhZF91bmxvY2sodm9pZCkgeyB9
DQo+ICBzdGF0aWMgaW5saW5lIGludCAgY3B1c19yZWFkX3RyeWxvY2sodm9pZCkgeyByZXR1cm4g
dHJ1ZTsgfQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIGxvY2tkZXBfYXNzZXJ0X2NwdXNfaGVsZCh2
b2lkKSB7IH0NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBjcHVfaG90cGx1Z19kaXNhYmxlX29mZmxp
bmluZyh2b2lkKSB7IH0NCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfaG90cGx1Z19kaXNhYmxl
KHZvaWQpIHsgfQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIGNwdV9ob3RwbHVnX2VuYWJsZSh2b2lk
KSB7IH0NCj4gIHN0YXRpYyBpbmxpbmUgaW50IHJlbW92ZV9jcHUodW5zaWduZWQgaW50IGNwdSkg
eyByZXR1cm4gLUVQRVJNOyB9DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvY3B1LmMgYi9rZXJuZWwv
Y3B1LmMNCj4gaW5kZXggNmRlN2M2YmI3NGVlLi5mYWViZWUwMDUwYTIgMTAwNjQ0DQo+IC0tLSBh
L2tlcm5lbC9jcHUuYw0KPiArKysgYi9rZXJuZWwvY3B1LmMNCj4gQEAgLTQ4NCw2ICs0ODQsOCBA
QCBzdGF0aWMgaW50IGNwdV9ob3RwbHVnX2Rpc2FibGVkOw0KPiAgDQo+ICBERUZJTkVfU1RBVElD
X1BFUkNQVV9SV1NFTShjcHVfaG90cGx1Z19sb2NrKTsNCj4gIA0KPiArc3RhdGljIGJvb2wgY3B1
X2hvdHBsdWdfb2ZmbGluZV9kaXNhYmxlZDsNCj4gKw0KPiAgdm9pZCBjcHVzX3JlYWRfbG9jayh2
b2lkKQ0KPiAgew0KPiAgCXBlcmNwdV9kb3duX3JlYWQoJmNwdV9ob3RwbHVnX2xvY2spOw0KPiBA
QCAtNTQzLDYgKzU0NSwxNCBAQCBzdGF0aWMgdm9pZCBsb2NrZGVwX3JlbGVhc2VfY3B1c19sb2Nr
KHZvaWQpDQo+ICAJcndzZW1fcmVsZWFzZSgmY3B1X2hvdHBsdWdfbG9jay5kZXBfbWFwLCBfVEhJ
U19JUF8pOw0KPiAgfQ0KPiAgDQo+ICsvKiBEZWNsYXJlIENQVSBvZmZsaW5pbmcgbm90IHN1cHBv
cnRlZCAqLw0KPiArdm9pZCBjcHVfaG90cGx1Z19kaXNhYmxlX29mZmxpbmluZyh2b2lkKQ0KPiAr
ew0KPiArCWNwdV9tYXBzX3VwZGF0ZV9iZWdpbigpOw0KPiArCWNwdV9ob3RwbHVnX29mZmxpbmVf
ZGlzYWJsZWQgPSB0cnVlOw0KPiArCWNwdV9tYXBzX3VwZGF0ZV9kb25lKCk7DQo+ICt9DQo+ICsN
Cj4gIC8qDQo+ICAgKiBXYWl0IGZvciBjdXJyZW50bHkgcnVubmluZyBDUFUgaG90cGx1ZyBvcGVy
YXRpb25zIHRvIGNvbXBsZXRlIChpZiBhbnkpIGFuZA0KPiAgICogZGlzYWJsZSBmdXR1cmUgQ1BV
IGhvdHBsdWcgKGZyb20gc3lzZnMpLiBUaGUgJ2NwdV9hZGRfcmVtb3ZlX2xvY2snIHByb3RlY3Rz
DQo+IEBAIC0xNTA3LDcgKzE1MTcsOCBAQCBzdGF0aWMgaW50IGNwdV9kb3duX21hcHNfbG9ja2Vk
KHVuc2lnbmVkIGludCBjcHUsIGVudW0gY3B1aHBfc3RhdGUgdGFyZ2V0KQ0KPiAgCSAqIElmIHRo
ZSBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IGhvdHBsdWcsIHJlcG9ydCBpdCBleHBsaWNpdGx5
IHRvDQo+ICAJICogZGlmZmVyZW50aWF0ZSBpdCBmcm9tIGEgdHJhbnNpZW50IG9mZmxpbmluZyBm
YWlsdXJlLg0KPiAgCSAqLw0KPiAtCWlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9IT1RQTFVH
X0RJU0FCTEVEKSkNCj4gKwlpZiAoY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfSE9UUExVR19ESVNB
QkxFRCkgfHwNCj4gKwkgICAgY3B1X2hvdHBsdWdfb2ZmbGluZV9kaXNhYmxlZCkNCj4gIAkJcmV0
dXJuIC1FT1BOT1RTVVBQOw0KPiAgCWlmIChjcHVfaG90cGx1Z19kaXNhYmxlZCkNCj4gIAkJcmV0
dXJuIC1FQlVTWTsNCg0KDQpJTUhPIGl0J3MgYSBsaXR0bGUgYml0IG9kZCB0byBoYXZlIHR3byBt
ZWNoYW5pc21zIGluIHBsYWNlLCBldmVuIGluIHRoaXMgbWlkZGxlDQpzdGF0ZSBwYXRjaC4gIElz
IGl0IGJldHRlciB0byBjb21wbGV0ZWx5IHJlcGxhY2UgQ0NfQVRUUl9IT1RQTFVHX0RJU0FCTEVE
IHdpdGgNCnRoZSBuZXcgY3B1X2hvdHBsdWdfb2ZmbGluZV9kaXNhYmxlZCBpbiB0aGlzIHBhdGNo
PyBZb3UgY2FuIGV4cGxpY2l0bHkgY2FsbA0KY3B1X2hvdHBsdWdfZGlzYWJsZV9vZmZsaW5pbmco
KSBpbiB0ZHhfZWFybHlfaW5pdCgpIHNvIG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGlzDQpkb25lLg0K
DQpPciBJIGFtIHdvbmRlcmluZyB3aHkgY2Fubm90IGp1c3QgbWVyZ2UgdGhpcyBhbmQgdGhlIG5l
eHQgcGF0Y2ggdG9nZXRoZXIsIHdpdGggYQ0KcHJvcGVyIGp1c3RpZmljYXRpb24/DQoNCkJ0dywg
SU1ITyB0aGUgY2hhbmdlbG9nICh0aGlzIGFuZCBuZXh0IHBhdGNoJ3MpIHNlZW1zIGRpZG4ndCBl
eHBsYWluIHRoZSB0cnVlDQpyZWFzb24gdG8gcmVwbGFjZSBDQ19BVFRSX0hPVFBMVUdfRElTQUJM
RUQuDQoNCglDdXJyZW50bHkgaG90cGx1ZyBwcmV2ZW50ZWQgYmFzZWQgb24gdGhlIGNvbmZpZGVu
dGlhbCBjb21wdXRpbmcNCglhdHRyaWJ1dGUgd2hpY2ggaXMgc2V0IGZvciBJbnRlbCBURFguIEJ1
dCBURFggaXMgbm90IHRoZSBvbmx5IHBvc3NpYmxlDQoJdXNlciBvZiB0aGUgd2FrZSB1cCBtZXRo
b2QuDQoNCiJURFggaXMgbm90IHRoZSBvbmx5IHBvc3NpYmxlIHVzZXIgb2YgdGhlIHdha2UgdXAg
bWV0aG9kIiBkb2Vzbid0IG1lYW4gd2UgbmVlZA0KdG8gcmVwbGFjZSBDQ19BVFRSX0hPVFBMVUdf
RElTQUJMRUQuICBFLmcuLCBvdGhlciBDb0NvIFZNIHR5cGUgY2FuIGFsc28gc2VsZWN0DQpDQ19B
VFRSX0hPVFBMVUdfRElTQUJMRUQgaWYgaXQgdXNlcyBNQURUIHdha2UgdXAgbWV0aG9kLg0KDQpU
byBtZSB0aGUgdHJ1ZSByZWFzb24gaXMgdGhlIG5ldyBNQURUIHdha2UgdXAgdmVyc2lvbiBhY3R1
YWxseSBicmluZ3MgdGhlDQpzdXBwb3J0IG9mIG9mZmxpbmluZyBjcHUsIHRodXMgaXQncyBtb3Jl
IHN1aXRhYmxlIHRvIGRlY2lkZSB3aGV0aGVyIHRoZSBDb0NvIFZNDQpuZWVkcyB0byBkaXNhYmxl
IENQVSBvZmZsaW5lIGJhc2VkIG9uIHRoZSBNQURUIHdha2UgdXAgdmVyc2lvbiwgYnV0IG5vdCB0
aGUgQ0NfKg0KYXR0cmlidXRlcyB0aGF0IGlzIGRldGVybWluZWQgYnkgQ29DbyBWTSB0eXBlLg0K
