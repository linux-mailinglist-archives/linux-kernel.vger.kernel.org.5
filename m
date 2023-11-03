Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA77E0936
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377776AbjKCTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376368AbjKCTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:09:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C0191;
        Fri,  3 Nov 2023 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699038551; x=1730574551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UeeyMK0XIwcF+jdgCPVCnYbsQicHxBdIhyPWBQqkY2M=;
  b=A0Zm5s+VG0mUIpAibMGK69UadxyEiwGcuZhC52WC5Ph2SwkYJBCT/c2J
   0XOEoS0rL28kDHm9wkTSA9FeWbSG4xH2xjcyL4f100wVe0vdbwkAKCr6L
   seJRUuGVOgsnpKxYa1sU4ZpzP9mOUO12ZIH0oIgJPnwh8ASikpjzc3Qrf
   NyBiNj5IUUuX4rrBvv16KtKtuWTgEel0BQqmAiJ/b7R0DecEDREzSuPUO
   HzE4XRH46dTSqpmRswYZrFg/bhCXMlL2I+zKwmsRSNvxmIoJphwLmlx71
   7D8WDzmKW03+hetwrcp9oj2aOvO2ZJb0jYZ/ZbY9LJwEZj39KZr/bJX5J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="455494755"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="455494755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="827581246"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="827581246"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 12:09:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:09:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:09:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 12:09:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 12:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMCtPimbPwSrRyOSSoe5BMhUkaV/eKSuuFByso1SM+CW5RcyeQ8GkAiqJ6GQaBkAKeI4XMS0cYVCC/i5ydrsudRrtsAtFND8zVe98Ba/QHBO0el2gVSzl6bloRV0SWNXzA4XNgDEBIrL+qES55dl6YGvJpg9+AiY3rTsJGW/+EsPrTg2YZxccf0Ssrz8V8YO47FkFPKCh5Q0SsiUmy36avij7NRELDVRpv+gERRcfJi3GED1HriPXv3IjpwQXmQ5Llt2KnDhZkXNrQIVeFIxPMAsLlPMEVuelOIqvuL02Bp+zbZqdizZovwZ7jAjTn0pRDm0xhAKP2BplaX3i0jP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeeyMK0XIwcF+jdgCPVCnYbsQicHxBdIhyPWBQqkY2M=;
 b=j9TNcToXDyxhZsp93/uV9eAirs5wTnBLu74vaxY3sSHgAjfs4oKwt1jVKqr7BswLfIl2Z8U/P5RAjM/JaeA7nM7LHJvy27gdBzu+We7u8HdJ6YMlW1onKOtOt7ZUnCjP2YD09A32NvK2hqCSTdoCcwRhOKNq/iSlAcqsu4utx+HOJKimGQ1dTnqcXaEkZ5Upqbv75IVvl76NkH7q73kv12JPrjqu0I8XZW/TLvnxll32Q0t2QAc/hm52J0KBInUD4G4EkkFNbHtJpZ/bnRrpBCU/ENpB/FIe0UVb4KWA9Q+LBMizoIl3wzD2SImEhgaaK/UJb7gzn9npUW5c2rh1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 19:09:04 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6933.026; Fri, 3 Nov 2023
 19:09:04 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHaDRYauzeQm+bvbUOtiGTt8mxyDLBoz3cAgAAoxgA=
Date:   Fri, 3 Nov 2023 19:09:03 +0000
Message-ID: <eca45ac5fc08572038bb5d842de6bf7d6dc3821b.camel@intel.com>
References: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
         <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com>
         <ZUUjGgB40u_tmRg9@debian>
In-Reply-To: <ZUUjGgB40u_tmRg9@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA0PR11MB7211:EE_
x-ms-office365-filtering-correlation-id: 243decdb-a72f-43bd-acce-08dbdca05873
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXi0rsWkELKgOxAxVAckY2To9uMbuiZiHmMb8W38XAnr2FjUsUuU4Z6hSWBsrJwKfWUmeQFbKJI9H6HtwntA2jsdI2AKrpy4243HREEcrmHgD9NEbpYLr2kORRZ4JgtHotkGb5aM1TPZkG/ydWOjRCkZjW8tmIiYOdtESkuoRLIG3q1vJRfFdGRfTQ4KBoRL50kYIvBBbltWacVM3ZjSpjBWyUnqsZ9Zzu11EgolBeW1uR3pXJrPKGuReyQ0fA0wplEjLNsUjPPNSgvbnKkG2bFBhTst++vmR1T3yD0IlnJ7AGDZC2WdYgxsdwgCGRWDaVYVc2JUCTuoHL3gMdpGvpvDUpJCMVUnJGxkDFUpWp1liQ6EaFA5+kh1A48Cc4OvmFYNn5z4n2jrz0v+5/9iQpeceIIiG+/uhkkC7o3AuUNVYnQCXduYEz9+efYLosGJhYZQmv/fKeM32zCLKzQSJWRFwOhKfI6aZyIlqB6ylnX+MPGdQdSY4XQqP29HTkDmHqeDKZryze1RNZ3/XnZ4ZFrqREBtw4PN+jr4yFP4gyh+EYwOxQNQG4uYviLrWblK3GXFhCEF3PJcXuPmhyH846/LMVF2PE7Kzmc+7WNr7m/D5wqqSpNRCptoWXZn9AZJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38100700002)(6506007)(478600001)(83380400001)(82960400001)(2616005)(122000001)(6512007)(4326008)(316002)(7416002)(41300700001)(8936002)(2906002)(86362001)(8676002)(36756003)(71200400001)(76116006)(66556008)(66446008)(5660300002)(54906003)(64756008)(6916009)(66476007)(66946007)(26005)(38070700009)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmdXbUVPSVpYbXRFQ0JSQldQSDBPSERYMmNRekZHajRTUjlYWmtPTGpXNjhp?=
 =?utf-8?B?Sks3akhnQ2RpTmlkNzN0M1I5Umo1b1dRSmpUdlRpVlRYQWwwMXJsdzk5YmZ0?=
 =?utf-8?B?aE5KRmJpcWk4ZnJxNWxXR2JrWm1lYS94eDRLbmdwSDNOVlloL1VFSU5PZU1K?=
 =?utf-8?B?dWUwcmNPQnNJVHBIOWxTTWdhamdweEhZU0RTZldxV3pYbTlQUE1sbkJ2NTg4?=
 =?utf-8?B?M0syZ2VNUi9zSDl5RDZOWEQxVEU0TTcram85RG9jWEtaUHNvRmlhVGVwc08r?=
 =?utf-8?B?bFROak44ZklaSDQ4YnlmVHhyQ0JYUVRrNGR3OElvbktpRkpzS0VxMlJIQWN2?=
 =?utf-8?B?MUVOTWpVWVRvQnF0RWhxYmV5MUZkTUpGWU5VN3lEU3pCdW1tYVZheEZYN1M3?=
 =?utf-8?B?a3Vyc3JxalQ1dE9ObmxNM0JObjZCenhGWHlSVklwUy9XLzRVOHRqdVNWWWkz?=
 =?utf-8?B?YThBQlNuWXZqM2pmZWlBZGJKWlBrKyszd0NaTEhabmlsaFVWUXVCY3lINUdj?=
 =?utf-8?B?Lzd3ODFlbHNOb3hCVkhERjJQZ2Q3bU1wRE02azVDTEhTNms4d3NjOFhXd1Vw?=
 =?utf-8?B?Vkp2Qmo1ZEZpSW9idEp6M2tybFpwYmNEOU93dkV5d2g2Y29LaEM3RWxsMEdV?=
 =?utf-8?B?Q1NRZGg3Zm4xMGE1UXBNRG02bnZMdktVMnVORVpFSGFpUis1QVBQRHVaMEV5?=
 =?utf-8?B?azZUUktUWmtVa1dFQ1drdDh5WE1iVkhqd2tIN09UZnVrSFdJQ3hYZGJNNWIx?=
 =?utf-8?B?dnZqdEc4bSt6ZWV5MWJQSU5aVjAyN2Q1MnJhMVY1TlJWNDZTdW1mZlZTQStM?=
 =?utf-8?B?cGozeUtaWU1kMzlkejFwdU91OVh1eVYydUZBWHZUM2t0bktXYWZlNWpnY05I?=
 =?utf-8?B?aHNhanpYR3hGeElOR1YvUFhGODlXdTh6NjVRY1NjV0h2am9xRzRiMVJPcDBE?=
 =?utf-8?B?MEpWYXJKckgxNnJaMzRKY1QwUlRhZ3NhVld0SkNnRGlnd1FhOUVBU3BYT2NG?=
 =?utf-8?B?WGJKL0VneGFYdU1sTURXejZicmd2V1BTM0dWRVZwTGFIQXZsb0hXbGdpR0pj?=
 =?utf-8?B?cFBhdEo1dXpMc0gySHRSRS8wWEl0alNTRkF6WnJDMlNNSUIzZHhuaHVUVGF3?=
 =?utf-8?B?VDVEQVVwSjgxY1Vwem82MjI1T3FRQzZDamQzRXllb1FmUUh6TnpoQXpEczk0?=
 =?utf-8?B?d2xadEFZL0hTQ3gvcXRsbzdSR2QvcjNQSzZnMDBtSkZvNDVCUHcyY0hBWDM5?=
 =?utf-8?B?NXlGdzVCMEt1d292cVRPaDF1UVJaaWJnQmxEVnBIY2lYQnFDRzE3bEE4eTFi?=
 =?utf-8?B?T1lEUjU4azdPeklZUkZzQU5pci9mM3QyVW0wZ2pGTnNISTJVWTdxKzU4dDNF?=
 =?utf-8?B?QnFDbVY0THVPTFpyT1lSUjRqUHFhMGRmRHpQTFV2QklTQ3NacERHK1lhRm4r?=
 =?utf-8?B?TXpDZEtZNXEzS0FoZGpXMVl3OGNCeGxSN0Vlc2lGd05qdm5DQzVsNm1DQitX?=
 =?utf-8?B?NGFKUWVrVmkxSS9FbWNTRFArQWpvMmM2OTRYL0ZLRkVHTy9FQlNLS3ZqdXVV?=
 =?utf-8?B?dlVHNGNhTWtKUTdDbHQ4YkovT2tFYlRORVg5eEtJRnRnWTA4Rkl5RTQwNkNK?=
 =?utf-8?B?VXFHa2ZoeUQyWEN2WWhZWW1qY3VoaU55eUR2anlpNGoxVVFMTytCUW1LOGlF?=
 =?utf-8?B?MlVVK3o2dzgvaFVraVpiVzcydVFWNlpuWm91RldqaGc5VCs5MmYrVlFUSUJO?=
 =?utf-8?B?UWNTK05ueEJLQ0lkcGNSTVBJUFAzSHRPSVA4V1JyM3RmNFg5TjIyRE5qNkM2?=
 =?utf-8?B?Z25CcDdmeE9KVXJuM0xjZWFYS0J4R2tqc3RTRVNPaXBMQ2dXK1ZSdkFBQis2?=
 =?utf-8?B?bkJtQjNOd1N2V1hDaFJ4elI5WTFrTFkwSE13MVJyZU41VjlKZ1M5eWlrRmdS?=
 =?utf-8?B?SVRqSnY0ZHJQNWZkY2cvVVVRWmxiS29uaW5ibWZPYzdvQzdkVmRJQlNsVzhj?=
 =?utf-8?B?MDFTQzVuYjlIR0pCS2VydWFnTG1UTmR1emhOUHVxTGRleHZ2dVR6MmE2SjBL?=
 =?utf-8?B?MkNwQy9hVGNwV3B6RXJJYmtIdmZKOVNieTVETlFwMlFDVzRYdDNDRnJSNjJj?=
 =?utf-8?B?dHAxcVhheHF1QS9UM1JtOE1jcjIzZ0t1YWcxSjFuZWxTaUVqcVozZE41RFRM?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE8A81030CC3D84A9E5ECF62FE7451C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243decdb-a72f-43bd-acce-08dbdca05873
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 19:09:03.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMv4XhlPESky12rb34qlD1s5H+qjJzw2hbIho9DR1GxlSzPuHUXX4HYhKqXZGjal4HK7tMk/4JKWo/lf9oj6/noO+yHEa1pnn3E/AfpRK7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTAzIGF0IDA5OjQzIC0wNzAwLCBmYW4gd3JvdGU6Cj4gT24gV2VkLCBO
b3YgMDEsIDIwMjMgYXQgMDQ6NTE6NTJQTSAtMDYwMCwgVmlzaGFsIFZlcm1hIHdyb3RlOgo+ID4g
ClsuLl0KPiA+IMKgCj4gPiArc3RhdGljIHZvaWQgX19yZWYgcmVtb3ZlX21lbW9yeV9ibG9ja3Nf
YW5kX2FsdG1hcHModTY0IHN0YXJ0LCB1NjQgc2l6ZSkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBsb25nIG1lbWJsb2NrX3NpemUgPSBtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygp
Owo+ID4gK8KgwqDCoMKgwqDCoMKgdTY0IGN1cl9zdGFydDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoC8qCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBGb3IgbWVtbWFwX29uX21lbW9yeSwgdGhlIGFs
dG1hcHMgd2VyZSBhZGRlZCBvbiBhIHBlci1tZW1ibG9jawo+ID4gK8KgwqDCoMKgwqDCoMKgICog
YmFzaXM7IHdlIGhhdmUgdG8gcHJvY2VzcyBlYWNoIGluZGl2aWR1YWwgbWVtb3J5IGJsb2NrLgo+
ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGN1cl9zdGFydCA9
IHN0YXJ0OyBjdXJfc3RhcnQgPCBzdGFydCArIHNpemU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjdXJfc3RhcnQgKz0gbWVtYmxvY2tfc2l6ZSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHN0cnVjdCB2bWVtX2FsdG1hcCAqYWx0bWFwID0gTlVMTDsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWVtb3J5X2Jsb2NrICptZW07Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtID0gZmluZF9tZW1vcnlfYmxv
Y2socGZuX3RvX3NlY3Rpb25fbnIoUEZOX0RPV04oY3VyX3N0YXJ0KSkpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoFdBUk5fT05fT05DRSghbWVtKTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1lbSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgYWx0bWFwID0gbWVtLT5hbHRtYXA7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbWVtLT5hbHRtYXAgPSBOVUxMOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlbW92ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcyhjdXJfc3Rh
cnQsIG1lbWJsb2NrX3NpemUpOwo+IAo+IElzIGN1cl9zdGFydCBhbHdheXMgYWxpZ25lZCB0byBt
ZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcz8gSWYgbm90LCB0aGUKPiBhYm92ZSBmdW5jdGlvbiB3aWxs
IHJldHVybiBkaXJlY3RseSwgaXMgdGhhdCBhIGlzc3VlPwo+IApIaSBGYW4sCgpUaGFua3MgZm9y
IHRha2luZyBhIGxvb2sgYW5kIHRoZSByZXZpZXcgKGJ0dyB2OSBpcyB0aGUgbGF0ZXN0IHJldmlz
aW9uCm9mIHRoZXNlKS4KCkkgdGhpbmsgd2UncmUgb2theSBiZWNhdXNlIHRoZSBjcmVhdGUgc2lk
ZSB3b3VsZCd2ZSBhZGRpbmcgdGhpcyBtZW1vcnkKaW4gdGhlIGZpcnN0IHBsYWNlIGFzIGl0IHRv
byBkb2VzIGFuIGFsaWdubWVudCBjaGVjayBmb3IKbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMuCgpU
aGFua3MKVmlzaGFsCg==
