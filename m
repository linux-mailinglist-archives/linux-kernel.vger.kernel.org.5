Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF87BBD31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjJFQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjJFQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:47:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C62A1706;
        Fri,  6 Oct 2023 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696610788; x=1728146788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rVdZeoM+UklO5E+OI9W/7NCqb9Htm7I3oEKPVgMHT94=;
  b=XAg7Y0HhvZ+ph2jxU+urDUaKS+mRsjcc7gi+jkQGOdzVunQDzcl/CBRy
   smVKUTkRjaZe94sWFnBRP8hQMeMoEM9/pjlvH1hA12MTRJag8fKhuh6Q4
   bD+ZBMekE/4wf7wRC72ogoL9hv54HDeTKIfk/EbGQybxVaNbRelVsD+q7
   hWgPARscpQxu9Cms3VEkseBG6RjJplZKJzyDqMtLodivtq3cY4i+kAb+L
   Qkk47+T+zMfs2z0iPoHfi4dD58W3dkGX2JtmaRcAy0uXBxkB5UH7no51o
   GcCGH28SJZUYyx3XRC8cAYdsm2cfrzwqKwgskuUqW1TJmTCsTI1IlUQ+e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387667186"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387667186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 09:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781703309"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781703309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 09:46:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 09:46:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 09:46:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 09:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL16U/TXGXTjZrYN86ID/shZAV/1WilUP+1dHFD0uqdA1a0TyiJ1MA1SIhbCXwnN73KDzfFHLCC/97ESwLPggwDq3a7BJd3vSxY7hZLQ8gN7UnXg+Rsrr2du9Jt+CbRxusaD9+XAbH1kSao5N9hWoI1+YydoN2K/pszd0Wn2b4Q9gIvepRYwdxxOqrvQxA9jyTZyFeEupNXGvHaxYYZ1y/7rEVgFqrBf69CIUV3bl9CZWqzCAwhtxpLkNsdVbRb/QorrzSHevPf93FmvxlrMw/GzFh2xpzyJlysmIk6+Mysxgre83R/yAys8ibuSApNi+0tKXwBqR389Ap2Y5Vt4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVdZeoM+UklO5E+OI9W/7NCqb9Htm7I3oEKPVgMHT94=;
 b=fov041WN9zyerSw8OS2HzHTJqhARPh4HEuzZGZ42P+uVYzobYrQ1/uwUwPi2Ky/KPlXbINuVXcjONwDi/cdxbkr5EcjRPxlIko1aByc0kxCKkiSu8zKU7Mcj9p5Y+ACq9ULpLZP9K3aFmYEshGPDWS8GG/XyXPxw2ByEV00QeSWxk9VoGjXNPReQoEi4mGaIzWJo4GwD3l4jOQu12VcfG5aWANr1WQXXaOJml3HTx0RSn0RunCIbQ9mKj/tdof/6cf/Tl/C2B56WiGDeL/sEa+BB7KxW8CyB24zHcv+ZyWZa4Iv/3FFpK9+oFR8u6hOex86csVEqO/uiUqHfW7gOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 16:46:18 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.041; Fri, 6 Oct 2023
 16:46:18 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZ97pKI6hvp9K6YUusBrDLSLOwW7A7tDMAgAFFlwA=
Date:   Fri, 6 Oct 2023 16:46:18 +0000
Message-ID: <a6cb3c36069e2aaf9ce486c68ee4cb0973dd6b70.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
         <651f28b87e6a8_ae7e7294b8@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <651f28b87e6a8_ae7e7294b8@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB7400:EE_
x-ms-office365-filtering-correlation-id: cfff5ba0-82be-4476-b6cc-08dbc68bc375
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZY5lprhcUEwK6reJbBJlBjdah/GDxsImes4T5eOc285QzoYG/O2I43PMpigbFqhcBTa0CzizUdKCxlJgdN3VMD6hYkI+LPgr3xcqs/mhrht13KvtOGTkansGAnAUe80n5KUX4ywyVeITydn3HugM8wf9NbCweOr0Stva8nGZ+KkRmAGYy+oUVv2OUUOecg/g/8vc2nvBtFbsisPIL9jPCs2eFKyo7TKdvHYoPJudwfOKGtRm7nYE6mQiBfzmb1Mlj8xHCtTnv+Gz2RGQysWMPSCN8fu4/ajgon5UyrLEzoo8zwzJT/FCZNEeHhmJ6bDPd5ZexzStD7/MXgP7+Uu2AtnpVJQkULh9xupIZRHRKpYQdjgn/B85QH/MK/11gTbGPkpuIDkniQtM9Kon/K7C+glEPVY4CotbD0lqIjZtogMu52cOLEeDA/EpDBH6HG+NBiB8jBUvhQOKDQ8tvuPie6/d5hJ5Vjo8oh8Lc6LL3anjnD5oE7gE+W9rLxEyHjqlHU15oVhQ5AI/iJJO3Gxcpl6nS/aXLiMJhGq11wImf0buDeMcFfSwB/QsiSoMobxwGT/3eH+zPbgP/6eo56BivKGC7z3k47GGUBXRPmqaeyhr4l9bwEzi+s/VYqCB4a2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(54906003)(6512007)(82960400001)(122000001)(5660300002)(26005)(2616005)(8676002)(71200400001)(8936002)(4326008)(478600001)(86362001)(6486002)(66556008)(66946007)(66446008)(66476007)(316002)(64756008)(76116006)(110136005)(38100700002)(6506007)(7416002)(83380400001)(36756003)(38070700005)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW93aFljNEN2NzlMaHUvVW80MTN2TU80UnhZaDFLVXhxR3kwekxFTlQ4dnpH?=
 =?utf-8?B?VFNiY0RaSVJsWHY1VUlPZjBTajRkOWNQRTE4ZEgza1ZGcE5YalUrMncvUXdX?=
 =?utf-8?B?Uk94eDVvd2k0L0xiR3VwMVlKcFY5RjgrQmxlWXZDOFIyMkdDNHlyMnQ5aUJG?=
 =?utf-8?B?WTIxcGRTM1Y5WGE3SklUd0IyaU8wL2FFV25ESWp4UmdsemJqODR1WVpQVmxF?=
 =?utf-8?B?Ym1seFhDY0NPczV3UXBhaWJVNnRPUTlqbElTT2o3ZHF5cndsN1N4SnBHRlZN?=
 =?utf-8?B?anJZYXhaWTI0M2t1SHB6Sm82ZHlWQW5GeFhHdnlzTlJZMUtFWmd3NFJrZ3hF?=
 =?utf-8?B?V0NMRWVWc0ZCVkJWbVNBRld6amh1alQvMFRBbm9GbFczZlFkZmFXbzR4VlRy?=
 =?utf-8?B?c2h0eE94bW9tZEs1aGRycnZjR1RFR2piUXloc2FtL1RuRFEwWnA4dnVGaVpl?=
 =?utf-8?B?U0dsTjA3T1Z4M1VGZ0xnWmxVYndLUDh2VWQ5d0pQb09ydUpvM1VmcWd2MTJX?=
 =?utf-8?B?Y3dDaXR0MWhXdUx2QWRLTUJHNklKbnpoUW1GRDdadlk2OThKRUdOTmFHZmpt?=
 =?utf-8?B?V2h0UmJQV0tjSjhtUi90aWlpMnJYd3MzbFFGQzQwaUhpY3ZBOFQ5U3M4SElB?=
 =?utf-8?B?ZmVrWFA4QUVucE15VUFrek1yYk15ZnZqQUh4YURBZ0lVNzlPa3ByTit0MUlJ?=
 =?utf-8?B?NHArTklWSXVIR0FML0hYQ2VKU3J6YVJ3QlFmY2dOOG1iQTdsQUVTMEVJdHdC?=
 =?utf-8?B?MUN4dkN2NHNSdHU0MDlLSXdSaytVWDlmWEFpR0lvZUY1aTNSOHVXVzZMc3dC?=
 =?utf-8?B?ZFBjQmlKOGUweXNUcGRRbnhTcytFVTU5Z3ZLOFJKYmFyVzN3bTRwcHFyazc1?=
 =?utf-8?B?STRCUlpyN3BCMjJzeWhQYktRZHNOcTZHalpROGxxUzcxZkJqYkdMc3BJWDFD?=
 =?utf-8?B?Y1RXNnpVaEhoRHd2RUhRUDV3a1paQ2dObExlSkw2WXVyUWZFOXEzd3lmZEQx?=
 =?utf-8?B?akF1V1F6alVuU2JwYlNFNkRSeXEycFRXTTdwekVlL0FydldjNTlabUZyUmFo?=
 =?utf-8?B?T0o0dmZYSnlrdnNPT2Q4RXJNZmJQYm43ZHFqZEgrYXRKL3JEK3BlY3d2SWIy?=
 =?utf-8?B?VWJQL3RNaTVkY2JzUHNLbU9TdHRxT0V6UlYrRjk3OGxZQ3A2UWM3Wk4zZThK?=
 =?utf-8?B?bDA2R1FmeUhjVEhpa0c0d1F4UmppNW1sN3NBZlVBNjFwQ0tDNXZ1VnJUK2Rm?=
 =?utf-8?B?QkVHMkx5WTgxSjh2WWJ1MnFjejhicU0xMFFWdDJWeWxMS05PVVNpM3RuT0ll?=
 =?utf-8?B?ZGcyWSttd3dtd0pNdVFBNDdCck1tbzNtMUpqcVZnVTR6b3VwREFCZ3pFT1Ri?=
 =?utf-8?B?Wnl5S0tLeUlteXlYbVdpYjd3REc4dGRaV2xYdkE4emE5OWRHMEh0akJNdDBS?=
 =?utf-8?B?bU5ZZEpQdXFLU3I0aXhNU1kySGs4bnlCNUswTit4ZlJBSVFoSDEwWCt0WHI2?=
 =?utf-8?B?blVNdVJoZ0dhRnVXdENaL256bXN5d0JOODBNSHdlYitNRnZpeTRRM20yZWU3?=
 =?utf-8?B?MDlEOG4ra093S3picGh3N2xDTDFENUVEZWRyekhybXVvaktGZFRWNExHWVR3?=
 =?utf-8?B?SmppMVk2VGZzNklVbVFtMlFpaXJtR0plVmFZcmtsZ05IcEJweCtrN0pjcjVJ?=
 =?utf-8?B?T3IwMmpjbDU2bUlUd1JRRFNpWDJkcC9sMEY0T2hiaE1USGlZZFNyODBGQUxG?=
 =?utf-8?B?eTBibWJJaTVoTksvRUJ3ZnliMlczRjlwN3ZqOTV4MjluSDhKZXloTXlQTG12?=
 =?utf-8?B?TDQvekczMEM2ZTBQcHBmUnUvbnN2QTFaekcyamVyRUlDbVg5dG9zOURNd3kz?=
 =?utf-8?B?SDdWZ093d1NzM3FrK2xqZElPdzczZ3hyWVZZc0MyckxpdnZ2MDdFY2VtdHZH?=
 =?utf-8?B?N0VFRVJ5VmxwN0duQ1BjaVNJemdtN0h3aHRoNkRjYTUvdU1PYUxwOVZkZ3pN?=
 =?utf-8?B?WGVNNFhiYStxUHArWVp3K08yQXQvenpYRnh0aDVnVVNaUlUyTWF6K2dBK28r?=
 =?utf-8?B?MWNCRnNqRUE2TVA3MEZoeS9YYWdHMVJCbnYrZVBLWGpUNHJaOFpMTklOWWZx?=
 =?utf-8?B?K1dFcmhHTlA1Z3E2bVptK2tNS2RIcE5JOXE4Ly9ydTlYMjl1a0FoaG05NW1K?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4C54611DC9599408CD8F2F4041D0DEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff5ba0-82be-4476-b6cc-08dbc68bc375
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 16:46:18.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0A1+HPcWeqHvLIhl6/78oTOl2A7Nj8hedfC1ZvnASXZP0QIqkNyfESXlGz8A19LOvmB6xTslw5HKelW6YnNCpF6FlfNzFxoROeUH0jLt+Uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
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

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE0OjIwIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
VmlzaGFsIFZlcm1hIHdyb3RlOgo8Li4+Cj4gPiAKPiA+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVn
LmMKPiA+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMKPiA+IEBAIC0xMzgwLDYgKzEzODAsNDQg
QEAgc3RhdGljIGJvb2wgbWhwX3N1cHBvcnRzX21lbW1hcF9vbl9tZW1vcnkodW5zaWduZWQgbG9u
ZyBzaXplKQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBhcmNoX3N1cHBvcnRzX21lbW1hcF9v
bl9tZW1vcnkodm1lbW1hcF9zaXplKTsKPiA+IMKgfQo+ID4gwqAKPiA+ICtzdGF0aWMgaW50IGFk
ZF9tZW1vcnlfY3JlYXRlX2RldmljZXMoaW50IG5pZCwgc3RydWN0IG1lbW9yeV9ncm91cCAqZ3Jv
dXAsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgc3RhcnQsIHU2NCBzaXplLCBtaHBfdCBtaHBfZmxh
Z3MpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1ocF9wYXJhbXMgcGFyYW1zID0g
eyAucGdwcm90ID0gcGdwcm90X21ocChQQUdFX0tFUk5FTCkgfTsKPiA+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCB2bWVtX2FsdG1hcCBtaHBfYWx0bWFwID0gewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5iYXNlX3BmbiA9wqAgUEhZU19QRk4oc3RhcnQpLAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5lbmRfcGZuwqAgPcKgIFBIWVNfUEZOKHN0YXJ0ICsgc2l6
ZSAtIDEpLAo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQ7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoKG1ocF9mbGFncyAmIE1IUF9NRU1NQVBfT05f
TUVNT1JZKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1ocF9hbHRtYXAu
ZnJlZSA9IG1lbW9yeV9ibG9ja19tZW1tYXBfb25fbWVtb3J5X3BhZ2VzKCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyYW1zLmFsdG1hcCA9IGttYWxsb2Moc2l6ZW9mKHN0
cnVjdCB2bWVtX2FsdG1hcCksIEdGUF9LRVJORUwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICghcGFyYW1zLmFsdG1hcCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtY3B5KHBhcmFtcy5hbHRtYXAsICZtaHBfYWx0bWFw
LCBzaXplb2YobWhwX2FsdG1hcCkpOwo+IAo+IElzbid0IHRoaXMganVzdCBvcGVuIGNvZGVkIGtt
ZW1kdXAoKT8KCkFoIHllcyAtIGl0IHdhcyBleGlzdGluZyBjb2RlIHRoYXQgSSBqdXN0IG1vdmVk
LCBidXQgSSBjYW4gYWRkIGEKcHJlY3Vyc29yIGNsZWFudXAgcGF0Y2ggdG8gY2hhbmdlIGl0LgoK
PiAKPiBPdGhlciB0aGFuIHRoYXQsIEkgYW0gbm90IHNlZWluZyBhbnl0aGluZyBlbHNlIHRvIGNv
bW1lbnQgb24sIHlvdSBjYW4gYWRkOgo+IAo+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRh
bi5qLndpbGxpYW1zQGludGVsLmNvbT4KClRoYW5rcyBEYW4hCgo=
