Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8C7DEA00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbjKBB1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348214AbjKBB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:27:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F4115;
        Wed,  1 Nov 2023 18:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698888450; x=1730424450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=33Fsx05WgKOQBuJGovaJUXMs0pM1cAAAqpufRbIxEtM=;
  b=WpPPrIghrTYONIV3hgrdhu3XAXtb7VpkCbpeFEscosUgrfQ85dWQqlP3
   ihVaFtTD/dFKqul0gFl5lrqip29ZIMUc8Kzd2DEwvr1t/7oeStfC5KC3b
   EI//9aA1wmGlqTqlA4Pbgd2NfiFKcqxUgbcI3BAucxXRiADUPmoYW9572
   89l58zLsR3mo2WoVHglK93/4n4AIOaYQ0cj92Ze7B0ui8dMVb64KOJY8u
   qcPcW6g7sWtZ4y6Xso54DrA/HE1WPMUPXfoAT1LdMUcs/Luk2AuqTS+N5
   NxA295fbi0D/NFQ8HVACXTBAiX4ru4u093xiBeLuOgdgIpGpSO3dBILzu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419727927"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="419727927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 18:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="710983112"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="710983112"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 18:27:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 18:27:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 18:27:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 18:27:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 18:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+bJo/73SFJKoOFIvrv+r1X/GgHjNZjDy3+mAd6TXhWLwryyPrDrjT6ctdiseD+sbmtJU6f9vCzKoy3eebwmKaGBYBd7xa9ZgwppYKFK0Pbum1gWxTIpyNTTVvwhRn93yJ6W+GSwQUFqiyxH8aEineiexqDtLJe3jelL3i3ktnBYELWTuQsJNz/JdTIW4fRYoK+lMxDsokmo9HFaDeGbtw5uH2yt/QT9KQk04Um4rEEIGGMacvpuwzNZUK59B+6geRRi5JcyH2h/WMw79Jjs0UzK/4UgoKn/i8OVB/HHNAelf9JjYHqbJgMdy7w1gMmhCxZWcJBnae1VSaKWO4dVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33Fsx05WgKOQBuJGovaJUXMs0pM1cAAAqpufRbIxEtM=;
 b=EAQxko35rdSXA6GNJnM9dJl8YF1mWRWlvQQx1qZP7V22YhG6FRzOCogNbwxBt35HVvK+XJYSnvkT7S5EYZGEIAJOhIHP6gfm4ropqTzOwb3zUNunOlmNbbnB/Qes4ztvup+WGKe1jZBYZg5SfELyjNuFlSkHaNR6gBKatAdsG5QqOx/SrrXlpBZ0XYdYfKXVIswQ9sA6cwwdVCaR1t/UxtoZ/YKw55xvl3clTtO0FT+orqc8OCZkoJt8QR2a4FS9+1Wp6OLwc8rB56TTMyyRsKHkUB8u0XMO4a5OTwJuaKR6V5MM6ejYOumq93f0U5qVxuVxWVWmLC3NU/8V1ikbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 01:27:24 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6933.026; Thu, 2 Nov 2023
 01:27:24 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHaDRYauzeQm+bvbUOtiGTt8mxyDLBmOuurgAACXQA=
Date:   Thu, 2 Nov 2023 01:27:24 +0000
Message-ID: <725291282836a82d2ac9c62dd5d5d2eedfd24c0b.camel@intel.com>
References: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
         <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com>
         <87edh93qfj.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edh93qfj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB6674:EE_
x-ms-office365-filtering-correlation-id: 3b3edbfe-73c9-4972-cffe-08dbdb42de2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWrcFctQOHITMgV1sAnQm8XhxaXmO+nGDFsKul/K+LFNR4+HDmnCx4zJBsJDGj316OAvmCu2SriYR1GPgR9ppSXPmlOiQaV+MpWGDMBBK3jV2rES8LetvJ1kG/SbkQlihMfQANfMZt7o0g3z6G7RofbSDPmjGdsBBaCnQygJJ3d9WFnHLVsXSfnm0rHumfTK9q80/laK5SGsBCZjsVIOrKnyShSNtl/aNUbykWB6tHJOnAzUF1H3sLDCA19flElfbDyb3v4nEIaPaAyr7M0fv8dc8EPdp9sJz5vqkMDs60alNidCkpvrEXJ8Z3E7zHzYkdeU4tSDTyAhWVRDIc/WAmz8uHTSHbVfr7WhYT1ZMpoH4hIxJXpPrOFIS2/VaRqz20brvoaE+f9J6lWp5PXd14u4tWOsSfcAN2gSFQ9YxUWXj+KzZXoFvKhnuYdZSZr8doT7oqORbBLzqADCLiRYsgsskhYub9ri0NRxbeNa3kv8rdsfGnia8lABxNvAMtjGYdSdWp0ENQMinxEu6+1iv61qBSEV4ZSSes9rMSnkflMpC9RPJ7XyvbGoZ8LLDK89nRN7l3PPFfF/jZCVkmGc0I6I8+JbMyEAaN0O+8YAAtbBJwFJIOUoIkzzQQlp2Ydt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(7416002)(38070700009)(6512007)(26005)(6506007)(122000001)(38100700002)(36756003)(82960400001)(2906002)(478600001)(71200400001)(64756008)(66946007)(6486002)(8676002)(316002)(6862004)(66476007)(86362001)(8936002)(54906003)(4326008)(6636002)(37006003)(2616005)(66446008)(41300700001)(66556008)(5660300002)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGdFYXdWc29meVhlWlhOcU1vTGJPc29WQnpReUo5anBnTnR0bUljNnhOMGJO?=
 =?utf-8?B?NnZ0QVF0TkJIWmRsTTIvMWtxbWNwUVQwWWRYcG4vREpUcTFCeFRMSHpvcW5W?=
 =?utf-8?B?QnY3UnltRjNJYklUckpVNTRraXFoK3hYaU1ES2Jrd3djL0JBazdKOWl5RGJz?=
 =?utf-8?B?UWUrb3JaZmdNaElrMVhOczBHUXNkdHhHRWhucjkyTjAyUzRuZzFVZjM3SlA4?=
 =?utf-8?B?QU5FYXE5bG5ueE9xWEtEaVdONVpQWmMyS0VaUEJ4TTRwUE5LQ0Z3NlNra0t4?=
 =?utf-8?B?ajJEdGQzbEEycDVzSVRqaStzbUorWjY1Tzg3L0hobzE0aXd1ZnRnSFRaS1Nh?=
 =?utf-8?B?dmk5RmxYTkppZW1mNjFPRHUzbGRUbDh3VnNEK21sMFh0OVlYNjA0aU1EaXpi?=
 =?utf-8?B?b0VyNHpzakV4ZkM0ZzAxYk5OWVNlZFhkV3FDT3N4QnQ3eWJSNU9qYXZNcC9t?=
 =?utf-8?B?ZGJmc0xjNGc0ZitBbU9mZEpxWmRnaHUvSnp1UGcrRlBXQTZnN3dnQTZ3QzFn?=
 =?utf-8?B?SzVsaWJNbm9zLzEyMkU0Y3JlQVMxN3Y5TmVyV2RVVDhVeUZNRDhKVjRMd2wy?=
 =?utf-8?B?NHA3VXljZ3NTaVpRNjRjR0IvaWhFRU9SQy80eFRUcG9NcklGaVZpZlpJMGlZ?=
 =?utf-8?B?V3Z2Y2doWjllYS9nOUs5VXJoQU9LL1kxYkh4QWd5NkJYKzdsS3R5dlNyWnBJ?=
 =?utf-8?B?Z0dpRmtudUYvNHMyOENDTVI5Y0daejNWeHBvV05sZTdTc01kbkJVZDZ4TFJq?=
 =?utf-8?B?T05Ib0kvYkx1OXpvUnh6L1gzK1BQL1pHUmNFSzRTRlhwRTV3V2I0Vjl3N2gy?=
 =?utf-8?B?NzZtZlJwdzdFWXdXTXNWdzNCWjFrbzRDcmt5YlhsTG9aOVRIa3NCbEhFZ0o2?=
 =?utf-8?B?K1d4YU9GUmZrTjBSUTYzUWtLeGFBb1lVN3JCdHZ0Tkd4SCtSME0xZ1Y5OEJI?=
 =?utf-8?B?ZHQ4MzRNOXF2OFFSUTYvQ3RzVjErK29FaW12MjIxdUU4L1VNU2FJcGxpYlJT?=
 =?utf-8?B?M3l6N0pLVFp6VnV3Z2RzcUpyYlNhcndhMUszdjFmMHNmd2pjaWE4aldyVmZt?=
 =?utf-8?B?RFZpYXFDVzJsSVVRVzY1RVBjeFo5T01GdXdvNzBlQzhRWmpKQmhEUmdRZ0Zv?=
 =?utf-8?B?c08wejE5VzhzKzliWmdtQzlad1g2SWhhSFh5d3VGdCtUN2lycGE0QjJRc0xQ?=
 =?utf-8?B?bFJBQXJEQ3VUUVVrS1dVdStYQW1BT2k1dGZpVlI0M0VGOVRORVJqdGNLdElV?=
 =?utf-8?B?bHd1a0ZWNkp5cUs0SW9CQStCSHVMOWVoMkV6Q3RxTDhlSHJ2S0NJK0lYTUJ2?=
 =?utf-8?B?NUNqUGJyME9jVTRtd0pldE5aOEJpNllyNXAwUVRVZk40N3RmbU82STYwbWZI?=
 =?utf-8?B?dnhLMVFVYUYrOVVjOXZrOWQ0TVVEOHltcmVIYlVxQ3dwSmViYUFQNkZrQkhX?=
 =?utf-8?B?SW1zQWh3NkFOenZrZXIvOUZnOEpaOTJCRTdhMWlKc3hRbXgxUFprVi9XQ0tP?=
 =?utf-8?B?WmJSWis1b25aeUd2M3JxVmV3SWNxanhsbDJRbWczZkNnTXJ6S2NIKzFTWjEx?=
 =?utf-8?B?bG1DR3VHTFk2VzhjMGYrOHhuUTlhdmFvZmxFalVycEtyZm1PSThHbDdiMWZB?=
 =?utf-8?B?bE9HVmFLVGowOEpQc0h4YXk0NjVkMVdYeTVzeVZNUVE5VVFlU1ZiNW9nOGxy?=
 =?utf-8?B?M0wzQVY4MjRTbUpycjcvSEl6bU5WT2pxWmxXZThoTUl2NzlhMFh1dWwwNExE?=
 =?utf-8?B?NWxGLzJ5MzQ4MWZ4ZXkvQVY3U2IreEpsMDVwQUx6d3FkMjZITDc0ekpXa2sw?=
 =?utf-8?B?b3Q0NmpBZndwL2FsemVqbFdkK2p0UGxtY2lNcDA5ZmFKNmpqaGU2eFFpQjcv?=
 =?utf-8?B?VGJHZUYvbEtIcFRYS1p3d0tCQVpWMWpYa1AzVmxtMGRWdjlHY3YwNDd5K0x4?=
 =?utf-8?B?dzM0akRwVk5OQXlibzZjRVpxT2g5c1QvTUNCNyt1OG1IV0dSQ0k3RFpVelo5?=
 =?utf-8?B?N1R3bGdVWlNXRlp5OUpMTzFWbExKTnV2ZVVaWG1ka1U4OVk3ZXpBQmdiQ0RC?=
 =?utf-8?B?cmFIRlBTVVBUblY3aExoYjBFNi93VjJTWTZPS2swOGJ3SE5FMUdpcWh6clhS?=
 =?utf-8?B?a3RWVEVFb2V6Z0Qrd0wwRldWczdZOHgwUEs1MjJNOG55Uk53OVJMbXJnN1I1?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <763E8919CAF4ED44A818639C5EFBEFEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3edbfe-73c9-4972-cffe-08dbdb42de2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 01:27:24.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRpNZ3fTJgRE4PuuBNAOkafx/g1ItJG1YbNHBN2xT5g4uskn3p2NVR8uDJ1fSin///fwmWy78tcBN6lSo5+acSYJsYRIDAMSGtydUpDZop8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDA5OjE2ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToKPiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVzOgo+IApbLi5dCj4g
PiArCj4gPiArc3RhdGljIGludCBjcmVhdGVfYWx0bWFwc19hbmRfbWVtb3J5X2Jsb2NrcyhpbnQg
bmlkLCBzdHJ1Y3QgbWVtb3J5X2dyb3VwICpncm91cCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdTY0IHN0YXJ0LCB1NjQgc2l6ZSkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqB1
bnNpZ25lZCBsb25nIG1lbWJsb2NrX3NpemUgPSBtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygpOwo+
ID4gK8KgwqDCoMKgwqDCoMKgdTY0IGN1cl9zdGFydDsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBy
ZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGN1cl9zdGFydCA9IHN0YXJ0OyBjdXJf
c3RhcnQgPCBzdGFydCArIHNpemU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJfc3Rh
cnQgKz0gbWVtYmxvY2tfc2l6ZSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBtaHBfcGFyYW1zIHBhcmFtcyA9IHsgLnBncHJvdCA9Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBncHJvdF9taHAoUEFHRV9LRVJORUwp
IH07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHZtZW1fYWx0bWFw
IG1ocF9hbHRtYXAgPSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC5iYXNlX3BmbiA9IFBIWVNfUEZOKGN1cl9zdGFydCksCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5lbmRfcGZuID0gUEhZU19QRk4o
Y3VyX3N0YXJ0ICsgbWVtYmxvY2tfc2l6ZSAtIDEpLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWhw
X2FsdG1hcC5mcmVlID0gbWVtb3J5X2Jsb2NrX21lbW1hcF9vbl9tZW1vcnlfcGFnZXMoKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJhbXMuYWx0bWFwID0ga21lbWR1cCgm
bWhwX2FsdG1hcCwgc2l6ZW9mKHN0cnVjdCB2bWVtX2FsdG1hcCksCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFwYXJhbXMuYWx0bWFwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiAKPiBVc2UgImdvdG8gb3V0IiBoZXJlIHRv
bz8KCkhtLCB5ZXMgSSBzdXBwb3NlIHdlIHdhbnQgdG8gY2xlYW4gdXAgcHJldmlvdXMgaXRlcmF0
aW9ucyBvZiB0aGUgbG9vcCAtCkknbGwgbWFrZSB0aGlzIGNoYW5nZS4KCj4gCj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogY2FsbCBhcmNoJ3MgbWVtb3J5IGhvdGFk
ZCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGFyY2hfYWRkX21l
bW9yeShuaWQsIGN1cl9zdGFydCwgbWVtYmxvY2tfc2l6ZSwgJnBhcmFtcyk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUocGFyYW1zLmFsdG1hcCk7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBjcmVhdGUgbWVtb3J5IGJsb2NrIGRldmljZXMgYWZ0
ZXIgbWVtb3J5IHdhcyBhZGRlZCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldCA9IGNyZWF0ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcyhjdXJfc3RhcnQsIG1lbWJsb2NrX3Np
emUsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFtcy5h
bHRtYXAsIGdyb3VwKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFy
Y2hfcmVtb3ZlX21lbW9yeShjdXJfc3RhcnQsIG1lbWJsb2NrX3NpemUsIE5VTEwpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZnJlZShwYXJhbXMu
YWx0bWFwKTsKPiAKPiBIb3cgYWJvdXQgbW92ZSBhcmNoX3JlbW92ZV9tZW1vcnkoKSBhbmQga3Jl
ZSgpIHRvIGVycm9yIHBhdGggYW5kIHVzZQo+IGRpZmZlcmVudCBsYWJlbD8KCkkgdGhvdWdodCBv
ZiB0aGlzLCBidXQgaXQgZ290IHNsaWdodGx5IGF3a3dhcmQgYmVjYXVzZSBvZiB0aGUgc2NvcGUg
b2YKJ3BhcmFtcycgKGRlY2xhcmVkL2FsbG9jYXRlZCB3aXRoaW4gdGhlIGxvb3ApLCBqdXN0IGtm
cmVlJ2luZyBpbiB0aGF0CnNjb3BlIGxvb2tlZCBjbGVhbmVyLi4KCg==
