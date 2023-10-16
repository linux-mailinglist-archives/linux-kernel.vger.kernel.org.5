Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C67CB233
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjJPSTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjJPSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:19:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74921E8;
        Mon, 16 Oct 2023 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697480369; x=1729016369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eKN9o2n+JMcouGFNEcCu1j95GKCH0TSLn/UXo701adg=;
  b=TkKCk8oPRt8Mjc0vLJCfEdpvYbs+VCwGSklbNQeVIL3ukd1frv+sPGJN
   z7hcSjW55cTz7mrowb2GNf8fCiycjkpU/jg6S/vmh2Sq5rppBzDg8BZpa
   DlUv7QWUoKYPgPD7tSXyqG5hb4ZnVXrew+PWdvBrPWjRJ5txPBlH9jJZD
   Ha3T6iJ1QlIWL3OIuPu2RQm9709HNuQwpT4L3dduFMmdf0COC90yVF3PB
   drAI1m6haVFQbbmLLo7KcgnSy/NsKw/LF4UgbtrVDH5q36Q88nIQngLMk
   /zttJpksahXBqJx5GiPPmh4eDSGFKY9RjDa9MRPtRlei1iPmtvT9wUUJ0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="364959742"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="364959742"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 11:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826124680"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="826124680"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 11:19:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 11:19:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 11:19:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 11:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9H2zy7KS3DsLyv0/hY4E4rStVo41fOl19HJwg7zFY4935WC7VjE00oL3pWmCT/yNALNhXT5YP18V2BjVG5PI7hV8H9xr8PoLvLyZS+Lqs4AEcKBIcGxRJ4PqLhYX20HPlgJ5OOfVYw8rYX3CqXwHYx7fx4yQTE5hRNb2O1i6l9ZgoNLVl01LQ7PYigmFib2zPwQFm1MVfqIZyPQeLl3zGh9mxsEyVVrp5GZx48PCBhRm6UYF/ipZj/w4oAdAMwGewpUQpzLH+oa78KBnmgB81IjKHVUeK6n0USnKCWgoJ0iivFWNynEHRp6aVkBVk1BjSZnXkRyEaOrjUrfVrTXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKN9o2n+JMcouGFNEcCu1j95GKCH0TSLn/UXo701adg=;
 b=nOoH3nNBIaJtmPAZDSeFIu7QBMCcAXXnOQTBIIUHN3hU7WvYkyxmlp5qKIWgl5bnRkCoPTItSTFlk1Lp55q0SN9OgMeJHWFk07L0O4EpTCJCRfmu0mwwG1wIlpWvbohOHDkVCG2VviK/NN8Qn14RvZOL2vuxxk/jMopFHM+rlVIPYp/0aQ+oAZ6u+tbTtF5VitCwnxLMxfAKPtVxx/uTBdV1doJ8Nae4lUwVn8Z7xbcxkmApIQLbVe6N70KOeb81WlOHZDnONF3chBUv8PvB2+Mr+WDYymWjJGLjaLAqylEWJfTlv9meY+EFvZgdlRkf9br0ItNji5nNJGzvGTLAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 18:19:22 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 18:19:22 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZ97pKI6hvp9K6YUusBrDLSLOwW7A+CSq7gAOLEoCABB0cgIAALs4AgAbq9QA=
Date:   Mon, 16 Oct 2023 18:19:22 +0000
Message-ID: <32bea77c4c632f29adfa0556661f1998591a834b.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
         <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <831b9b12-08fe-f5dc-f21d-83284b0aee8a@redhat.com>
         <f0d385f1c1961a17499e5acccf3ae7cdadb942cb.camel@intel.com>
         <748d40cb-35f4-98d6-a940-055de88bbc8b@redhat.com>
In-Reply-To: <748d40cb-35f4-98d6-a940-055de88bbc8b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: 609c110c-bf2e-45d8-6186-08dbce746c0e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5v+oNjWPdBk0syBss5KvcMPZUKlTqO85iF1WZW8gFVXC6VSr6c2FoyucHdMJlyhTMDTZ5ZaUPGoJP2/1SFiY7WREV1oW/yRKOEwMtsTHW0W2K36uaGpPRYhmtwAgqGO03RoD6kfDPyoQFqVSTSFuMPEErxBjuFkZZx1GsuAkg73ryiNzS6EtpP7RnEY1f7zYqgYXVJ+bn1961kQGEaKZJGk9sV8p6B9976WULxINMLxqeFzzS+LC+27amHqbHC+WDUH69w6BM3dRcyokIS0NfPsphjIScnw1wGo+4Kr3RDuDfZ4KTVUnk777F09G07Oi/LrcRwl1Q8STOU0K6iDaboKdFYh60pyhS3A0c9A8m9/PGKQF0e9waGKOoQb7RjtAFr5YJQz61j0mPo2A+FNNJA0pOphKRLoi89ssB17JcshsefUqYn/r9DDZHHIWIQXkuUBs/k1MYxClJmGe7Icp5EMqTcvmABwMnp2G/EZ2v+pgymc2xD43fm2BBEKfUNCTPAlB7WfgFQ8bQStkJDHz05F2pM5iIuPuXy2sJLca5Pflbk4kGoUdh57ypKaOyGrYfk/E2oNtLntHAMaxcMmxZtzm+BNSc+F/kVU/8dZ1PE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(54906003)(53546011)(66946007)(2616005)(83380400001)(71200400001)(7416002)(66446008)(26005)(316002)(66556008)(64756008)(6506007)(66476007)(76116006)(41300700001)(4001150100001)(4326008)(5660300002)(8676002)(6512007)(478600001)(8936002)(4744005)(110136005)(6486002)(2906002)(36756003)(82960400001)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei90bkdkdUdoRVR0V2JhUXlDdGlNSm00NFVvTjZJRVFLNzdwWUJ6dkx0ZWwv?=
 =?utf-8?B?anhGMjVUL3dWbVgrelBWZElJQU1qbDRxNEc0RmpUWm1oUHB1bU9uQ003a3ls?=
 =?utf-8?B?WjZZL3F0eFU1UmRvUEhqU3pNY05wdDUwVXVDQ1BXM0piZXpCWnFVWDczenkx?=
 =?utf-8?B?OEJYUnhqZFE3M0FpbXRyVEk5bEZkakExdk1nd0MvUXNkMWJ6eWxsaTJYMnR6?=
 =?utf-8?B?M3o0UTlKNkhkNGk2Q0k0SkJwZkxFNmVZZjQ1ZjdBa3A1aWtuV2lzcGlpN1Zi?=
 =?utf-8?B?bjR1eEVwa0l1RFU0UHJxbERqbFBrZmc1SlJvOG5tZ3ZWczFEZ3VEeW5pRnJH?=
 =?utf-8?B?MEJVcjRPMk9mbTZ1Zkc2R3NPWSs1bCtEbzkvTGFJUkh0MVNnWHJSem1yL0FH?=
 =?utf-8?B?QjdZSEtIZGZ5clhqUSt3UHhMU05MaEN4RFdaKzk1UG9iWGNYYWpCZjhIaVBR?=
 =?utf-8?B?V1dMWmpvMVdKcEhHWGxEa3IrVk0wZlptZW9IUTY3bTlGQ0JpYWdtYU9Tamdz?=
 =?utf-8?B?T0xYWHZNY1FPZ2hXQ1NhejRwU1BuUVNURHBqN0RpWEhqMkc0UnlzZXgxWFNW?=
 =?utf-8?B?SEJVclV6OTBtRExtRGdUdDZHZjNjUTV4YXh1cURhSHcwVWo4N3dpWnBLT3JW?=
 =?utf-8?B?bVp6ZkNtc08vYnlzaldwOVpwZDhzQWhISEhmMWpPT1p2QTFLU056eElOclJk?=
 =?utf-8?B?VUU5bWRmcGZrazR5VDFDTVhCOURqczJFaWU0TDFwRTFZa0ZYczlQalloQ1h3?=
 =?utf-8?B?aFdHRGM5OStQeSszKzUzNlZ3OHJndnMvdlFhRlRNdG1yaGdaaVpuTkYxUGFC?=
 =?utf-8?B?bllwSnRNZ0hjTEFUVFQ5OWZLS29Xc2ZzTHpjYkY2K0x3ZTYrb3V1REhKOUNt?=
 =?utf-8?B?YU9aWWJoT1ZQUVpqc0lKWWhjbEVJOGs0ZG04L1NGRGc5WUpGRHdNWFprYmRF?=
 =?utf-8?B?R1BCVzFRb0hSYkpxNFd3Q3VzTmtZS2ppdDlRQzNyWlFpb2VsWnhTWGJhaUg1?=
 =?utf-8?B?Sks2UDYyYzZzRFV0eXAzekFKQzBPbk12WXpxdDJjNGFpSTgxVXRIQzJrQTFH?=
 =?utf-8?B?ZGM1TFZiZ0JRVDVSRWFFRnROWXdqMkJtb3d5K2UwMlBVZHRJU29EUndEUHh1?=
 =?utf-8?B?aXRYdW45Z096clVDMy9hSkw0U2JjYzgyTDU2UkNqcG1hY01nb2F4YmJMbCs1?=
 =?utf-8?B?c0pGeUdoSGpKZjB6VXY4OXFhQ1lQeGI3NmpqL00wZVB4SFlmWlFYRTkvSndw?=
 =?utf-8?B?NHJBY0Y5azU0M1dpZTFUVERSU3lISDJodzRPMVMwc0V0alZlZzFIZ2xxSUEy?=
 =?utf-8?B?d3ExdXN2Smx5S3M5MVZVWkJsMCtESlFpNlhTK1JURGVJbm5ldkFNTGV4am1T?=
 =?utf-8?B?OUpJYVZ3d3h3UEdPMWhlUmMrdnhaUWJoZm40Q2FTM1NOR0N1TnU3UzZ4VDlx?=
 =?utf-8?B?LzRHQnpKOFJBbFFKUnE3M0xQU3ZreG0yaHppOCtBVkY4V2Ivc2xzWXZ1akJs?=
 =?utf-8?B?aDZYbEQrQ3V2WTA2eWtIa3dsN0xJekZkaUp6elNWQUk3WnpaSDQ5Zkl1UHI5?=
 =?utf-8?B?aWZ3eFJEU0pNVXpZNkdKQzlwSkdadmtmQVh1VkJqOE9ZMWNROW90L1hQUHN6?=
 =?utf-8?B?OTZhVGYxSWllM3ZTSUNGaWJBZ3NsWGVVSFdVdmZKTEl4YUdXemZFQ0wxUkor?=
 =?utf-8?B?R2ZlZTFnSXZKNm9uTmw0QUdVbzJ1MjFjOFphdnhuUUpYRGNManRPdUs4Mm9p?=
 =?utf-8?B?cGJWeTdKME5wQW9UNkxmdjdrR3liUm1rZENwQmRTQ2hkenF6UjJYZnZpc1cv?=
 =?utf-8?B?V3lqeTJxWmZHclEvTitZWThRaGkyVENtSm1JK3pRQmdTaDluVFduemFqK1lN?=
 =?utf-8?B?MVhjc0VFWkV1K3pFVkZnMG4xczRvZ3hyM3V4MU1SbHV4QXk1WVV3TmFWZ3FD?=
 =?utf-8?B?WUNTaGNjaHVkMnVpc3YzdGhUbk5JOFo2eENUWkZiRmRpUXA2Vk5FL3c1VSsr?=
 =?utf-8?B?WGovVGF2UFBIWWxkWWQ1ajJWVmtGM1dQMlVDUTNtYVo2Tmo4d0NmWUVEQ0lJ?=
 =?utf-8?B?aVdFWVBERkRLNzFUWVYzRUgyR1l5MDlkd3N2eG9Ud1hyS2RsWnh6Q2o1L3RY?=
 =?utf-8?B?SXdJbUtLUjBJVnhMUjBneDVpaVBheEo5U1d2ZUk4aC8vcE9WWFRmSWs3SjZm?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32E19C8D3729B4BA4449643E965710E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c110c-bf2e-45d8-6186-08dbce746c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 18:19:22.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i3za90CCo4QlYoLaVrZltNzNeQDXKVudLSEwfUEXaaxiYofISSzTvzR6oUFXiwOiW9wzVkDe07wwu3JVa/5WAQ3v6eAdruZ9fvTxqPMs5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
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

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDEwOjQwICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAxMi4xMC4yMyAwNzo1MywgVmVybWEsIFZpc2hhbCBMIHdyb3RlOgo+ID4gT24gTW9u
LCAyMDIzLTEwLTA5IGF0IDE3OjA0ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPiA+
ID4gT24gMDcuMTAuMjMgMTA6NTUsIEh1YW5nLCBZaW5nIHdyb3RlOgo+ID4gPiA+IFZpc2hhbCBW
ZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cml0ZXM6Cj4gCjwuLj4KPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoGZvciAoY3VyX3N0YXJ0ID0gc3RhcnQ7IGN1cl9zdGFydCA8IHN0YXJ0
ICsgc2l6ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9zdGFydCArPSBtZW1ibG9j
a19zaXplKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdhbGtfbWVt
b3J5X2Jsb2NrcyhjdXJfc3RhcnQsIG1lbWJsb2NrX3NpemUsICZtZW0sCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdGVzdF9oYXNfYWx0bWFwX2NiKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnVtX2FsdG1hcHMrKzsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG51bV9ub19hbHRtYXBzKys7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4g
Cj4gWW91IHNob3VsZCBkbyB0aGF0IHdpdGhvdXQgdGhlIG91dGVyIGxvb3AsIGJ5IGRvaW5nIHRo
ZSBjb3VudGluZyBpbiB0aGUgCj4gY2FsbGJhY2sgZnVuY3Rpb24gaW5zdGVhZC7CoMKgwqDCoMKg
wqAKPiAKPiAKSSBtYWRlIGEgbmV3IGNhbGxiYWNrLCBzaW5jZSB0aGUgZXhpc3RpbmcgY2FsbGJh
Y2sgdGhhdCByZXR1cm5zIHRoZQptZW1vcnlfYmxvY2sgYnJlYWtzIHRoZSB3YWxrIHRoZSBmaXJz
dCB0aW1lIGFuIGFsdG1hcCB3YXMgZW5jb3VudGVyZWQuCgpBZ3JlZWQgb24gYWxsIHRoZSBvdGhl
ciBjb21tZW50cyAtIGl0IGxvb2tzIG11Y2ggY2xlYW5lciBub3chCgpTZW5kaW5nIHY2IHNob3J0
bHkgd2l0aCBhbGwgb2YgdGhpcy4K
