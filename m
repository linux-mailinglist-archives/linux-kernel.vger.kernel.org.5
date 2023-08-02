Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3185976DB72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjHBXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHBXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:20:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB080FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691018448; x=1722554448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kQKQYgglgGUAZktab4svIOuD4fOZBa/pHcRd3nA/alk=;
  b=GiXGKRf2BIJd3X5U1IsOOeQpLNB+TMB+Bxxc6k4S2BOlYmn0ALvkVgk0
   w9vyEhwPhz+sNRfwb8TriuAFuHtgO/Jg+oGRzvsU1tpXM8b9R2h2lLtvf
   7JVuCWlYvEgfWgsO7LntTVO0KPXSqMxwAlYSDjMRl3TS1512QXCXB+K0d
   VU4St8hH/9qMZrNfU44ca5MN/kjQ4kzOL7RudlVwKKGP67E9ZcDB3gdPy
   X1ABRRFfWClggywjIjUX2jWZ7mYWMlAuRy5YHygqd8LxnDmWFGvGBqhny
   MEq7G5OP1gtva7cDFteaLerbcOioqqztNYWCO7BXqMktU/ZkfwLo/Cn1b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349321279"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="349321279"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 16:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060016015"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="1060016015"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 16:20:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 16:20:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 16:20:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 16:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9srnjM6sHWNFu7EXg18+epwzjjJ3IC0WxiT4nnniSNFsbKWLFzYmClrM1Knaf9/Np/Cql0LIocCaF6iKe6VdZwx5FkQYB2jw5D896KhLbBBNEBwhQi/oje15Atvy84ohHguyDYuxxun054ZpQ4alYRNiH/8FUA1gYvMBD2VMI3BPmPS5npOeWaNac5PgvpWA5nedOFPr8vn/ozPRpzX1AnLmJ2bS4DPNLA+cX8p/0mWua3kOX5RiSa2tkQFp0tlo5D16rkErkFe98o1+zNIybMvEnVPEdqxhAJpLmcC6L8RZSuYWQ/fr8vwNTJ5N9QZYi8mGZlq9eAv2GZhe4vfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQKQYgglgGUAZktab4svIOuD4fOZBa/pHcRd3nA/alk=;
 b=BcdxBcNNA2wiiTW1TB0LBmWuVTLjMFhx4jd61TzJbjD7hnXL39QNFn7psRc3dbCGpaC8krNG4l4XxMtMy7UbRaBxkGYYYCDaCBGuPbWk1mpW+OZwOyRUTfpbgTObjxm0oVC484B//HLuXL7n+PRJmf8uso5ci21YL+AHuLf3/REPRRJS2egRonjfi+5ZntgnkFzdccwemfFe9j1SnsKCGQlBA0nFXF15+Z/aRIqCgaceeYHsnvU/hymRNrUbLrRK7leuDM8WdGiwh7Ciz9ELH7mDwirnqJ8w82SgZGQjISachDtOeCR04LFSyR5YtOQWo8dBRme3z2UGVXRCFEuMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Wed, 2 Aug
 2023 23:20:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:20:45 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
Subject: Re: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args' to
 use x86 "register index" layout
Thread-Topic: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Thread-Index: AQHZv7EuDeTmYmtxiU2quJkSiZ2kg6/XklGAgAAeN4A=
Date:   Wed, 2 Aug 2023 23:20:45 +0000
Message-ID: <de1f8089878b0ad822043459d4974c719a90556d.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
         <20230802213235.GA3597003@ls.amr.corp.intel.com>
In-Reply-To: <20230802213235.GA3597003@ls.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB5890:EE_
x-ms-office365-filtering-correlation-id: ec669af8-784f-416a-f192-08db93af197d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgWtq9WyD8jfhWszZiferPvuVgSivS3YjU+JXdcKvE1SMDKEfM45dp4qV1kAmgZyqA79Vy3CUEIQZuwO11jG8IuQS02HaAFC0JAzmFLFDyYSJaa+neQpXWj6QWM0b2iViJA7hEDGQktUpBshX6SSxrGggptFoDNrxVkSjgk5kSAOoUeUlzzNnH/s9ir5U3x03Y797xrt2Tltqd3oQwaovk2xgQxnU6vzYzuvLHetB0nW/JSWF0Vpxjp9XU/Oodfdy3U+iZe6xlZR1kN+gC1LV07CafczZjk7FwW/AAr2FJQHVvlkhkjny/UzE0yXCFdVnQUL0QDAIto2sbLcThsOqLYIAb1is+fQJMslRWcj1m2lMWPAY4qdGZbc0QBdPnnQqHPBdbkJ9zMQWXatZJh4fxyJ6CzIdK0hi/aGODUJYvqXt2yG4k+UkAggStOUEOc4fJQ+yv7NkKuwx7EQ9qn2sNCfhh3OTEZk2lBh5vVgGnjASrEvZHHyc51J/tWUhF5Ha//JbBbzJylhl1UUmuGDJV66kzqAgX5vXBzOI6FAYnd+1gOCbInYFb2NjZLDHUfXE0CxcqelhxHGRJJ7EDj/G9QbfnwSaPqG6xG5r8LpPRMdHkFYBTbkAmHC6j7rrYgk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(66476007)(6916009)(66946007)(4744005)(91956017)(4326008)(66556008)(66446008)(64756008)(2906002)(76116006)(5660300002)(54906003)(7416002)(478600001)(41300700001)(316002)(6486002)(8676002)(2616005)(71200400001)(6506007)(186003)(26005)(8936002)(83380400001)(82960400001)(122000001)(36756003)(38100700002)(38070700005)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0l4SktnUzJ2SEdTVklBVlo5TnpaamxLSFhQdUFkS1Qyd0NMYng4YkNtbEFJ?=
 =?utf-8?B?MWc3Qi9CRG82MjNlNUZhd1RBTmUyclJrbStyMW53RVoxekpsUS9FWW5ZZWxp?=
 =?utf-8?B?TFU1eEJVbmxKcXoyd3F6T1VoYTR4TUdwL09VRTFiKy9WeXR0aXEvbUE3c1p4?=
 =?utf-8?B?UUkxQTVKM1J4bW0xLzVXcjAzZWNISmFLRUtsZVEva2F1RkdrbXoxQXBmOWlX?=
 =?utf-8?B?RVM1cnZpNWxsU0EwUXZDWFhEQTVlM2lmY0NDRndEdExmRWJRZ2pIZUJhalN5?=
 =?utf-8?B?N3hZVTBiU1pPdXJweG5VbmxnaFBMUFpIL1RTZnpTejNqdVF2SlRGZkNjTm9w?=
 =?utf-8?B?VTNRdWx0bm42S3pHRGRyZTRJZ2JNV1RZdTRYV1h2YnZwQWlHaDBncFB2VS9Q?=
 =?utf-8?B?U245MUFDTjdYRVl6amFLeUJsMTZSTG9LN1diZTJJMFNjSWp3ZGFDTExURHU0?=
 =?utf-8?B?ZjB2V0p6ZVNnTlpONFp0ZGR6ZmxaQWk4OUtjbHdUVmQrQlc1Sjd2STJxS0VP?=
 =?utf-8?B?ajY0MkxGLytlaFRkWWQ4NGhMaWdPbU5EQ2VOVkgySnBWKzA2Sm5vZXpsUjUr?=
 =?utf-8?B?MTZGZmsremVNeEgybTJYOWxWMVc4WmliL3Y0TEpRZWh5RDZNNlN1S2ZPcWVx?=
 =?utf-8?B?MFRuYkJINnl5M1EzVVBZcGo4THlYN0xKN3AxdjNkdVUxYkZab2x6aDFmZmcw?=
 =?utf-8?B?RjZzZHBNRmpxVkJOY0JMVE8rZnhBUVl2VXJvK2RvU3o2eGRkT29PMkVKVzVU?=
 =?utf-8?B?eEdZeExkVzcvRjNlSG1KOWJQZTgwUGRuKytYdzZFU0NQQk1mL2YrT1EyWEwr?=
 =?utf-8?B?bnB1NUh0ZVpIMDVQMVBZeFZ6WVZUZDk1NTF5NHBXT2VJL3hjS1d2d1ZtMW9Q?=
 =?utf-8?B?eURndUExcDRDa25tMWJlSlhRUXVHM0d0VjRJck9YWU9jdFVDcktVV3lqSjVO?=
 =?utf-8?B?T2hZUWkzSVUrUjBPRDN1UzQvaGdSWjZLSXZmajUxdEhMQW42NWJSRTN5R0tG?=
 =?utf-8?B?SHhES1Q3dHR1bUxnMklmSFRTN0tWN2tDcERGZGFFMlVRUGo0bHRKMmNFL2F0?=
 =?utf-8?B?Y0tvc2xJb3g4QkRCcWQrZktPVmhpbFYzcE9xM0ZlcjZ2NWx2L01UeXEvcjlx?=
 =?utf-8?B?amFSSUtUNGY4RlM2b3ZYS254bUZ4QVZib3RRMVZnL2JtdEtHRzZLVUUxdGtN?=
 =?utf-8?B?ZTk1ZDF3SEQwSlFQcnZ6VUxiYythdkg1QTRJcTkwMWt5NGlhUkcySDdNM2RI?=
 =?utf-8?B?NHhxVWVhU2xUV2EydnlROEUySzZiSEpGZU5WTzlCaU1xUUZUTUlLVENNdDA1?=
 =?utf-8?B?VWc5WE9tSUxHQVBtNTRCS3pRU1ZQK0REY3ljYjhsbXRPelBSOUxUUDZQc3V4?=
 =?utf-8?B?bGQ0b1I3b1FxZ1pRbmE5Ymo2S253Q2h3NnBhVS9sR3VHeVZuYTkxbFplV05R?=
 =?utf-8?B?ZTUybExWTlNidkRLN2VuSEZqQ3RZVmd2L3dxVzBVNUp5d1RaMXBlWXhzOHRn?=
 =?utf-8?B?clRyNmdYTmZLdEEreUZ3Z2o5akhIU0hqSjdEcVFmaHJUcVpwYkJFU25ubTNv?=
 =?utf-8?B?eEo4cDRmOVp0cjZYY2NWRzFnNktTNnE5UmN3RzNHb29hakYyZGFCWG1oRW1y?=
 =?utf-8?B?TEM5ZXRHZ0pjNVh1RHZINGJ2a3VzbFZQKzkwR3FremYxb1cydWthdFVxV1E5?=
 =?utf-8?B?ZnBOWkpiNkJqMG8rYW0zUXJINnp2VkswYmhQcEhmZjk4M1hSa2xJR0VLcjEw?=
 =?utf-8?B?alpiUGtpZDVGbzlQWloxTUtLV0VEbGtmWDFzODMxMjdXaGxrZWZoSkpudEdM?=
 =?utf-8?B?SVBTU0g0UXZSbTYzN0FsQWRxWnhpdmJ2SEVPYjdlZko1Uk8xNzFIYVBkaVY2?=
 =?utf-8?B?V1BrUHlXQXRxRDdLL3p6WWcydC9CaG9zbm0zTkxpRUN2YWZqOVRpc2ozSmdN?=
 =?utf-8?B?UGMvV0JxM2JrVUxaN0prMlBDQVdldFRJOG8zNVlMMEtMbzVrcHk0SUMwd0lB?=
 =?utf-8?B?a1d6THlRL1hmTUU1L3gzRytoVGxTUUNBdGYyNFJlNGJONGtuVEgxSEczaytw?=
 =?utf-8?B?V0JoRzJrU3ZXU2tLek5CZDdlZnpDM0VycFhWUEhwR3ZLWHdDMDJuekN4ejA2?=
 =?utf-8?Q?DaJv5kgi2qljYGikm4nvgmUa5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CFAB99A07D2B344A7342DA2DB3426C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec669af8-784f-416a-f192-08db93af197d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 23:20:45.9014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/4RaqPWC8j/a+seimUQdLdpOmlD108AYgOP4Lu1p1P6elb5/225mcND0FZ1OP8GBKj0hz/3X91H4Pzuagfbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBJIHJlcGxhY2VkIHRoZSBjdXJyZW50IFREWCBLVk0gVERILlZQLkVOVEVSIHdpdGgg
dGhpcyBmdW5jdGlvbiBhbmQgaXQgd29ya2VkLg0KPiANCj4gVGVzdC1ieTogSXNha3UgWWFtYWhh
dGEgPGlzYWt1LnlhbWFoYXRhQGludGVsLmNvbT4NCg0KSSBzdXBwb3NlIHlvdSBtZWFuOg0KDQoJ
VGVzdGVkLWJ5OiAuLi4gOi0pDQoNCkFueXdheSBJIG9ubHkgc2VudCB0aGlzIHNlcmllcyBvdXQg
YWZ0ZXIgSSBnb3QgY29uZmlybWF0aW9uIGZyb20geW91IHRoYXQNClZQLkVOVEVSIHdvcmtlZCB1
c2luZyB0aGUgU0VBTUNBTEwgZnVuY3Rpb24gaW4gdGhpcyBzZXJpZXMsIGJ1dCBJIGZvcmdvdCB0
byBhZGQNCnlvdXIgVGVzdGVkLWJ5IGJlZm9yZSBzZW5kaW5nIG91dCB0aGlzIHNlcmllcy4gIFdp
bGwgYWRkLiAgVGhhbmtzIQ0K
