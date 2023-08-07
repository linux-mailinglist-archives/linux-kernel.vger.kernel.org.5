Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8871771834
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHGCOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHGCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:14:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA971706
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691374481; x=1722910481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ir6vfQye4iypch7+k0Sispucx759RE7YOhbqvOONEGw=;
  b=U842gNXS8XZjED3QgztccYpApPF8M3dv4vNsD/5RtVmFnpGxHkXWWgFp
   /pq2nSA5jcSM6HAldEFq4YAa0cUDRF8PlV4FGaTGMvysNqQodidEMxeYP
   uwW5mdBppcxddTSQWXpQkbPoO2qS6j0XZj+j6b0O8pUze84XyCKaQc9+Z
   dI/QfrjrV9XUxeR3k78idGfLRRjWfBWzgxMGKngT2wXYGv/JMHikkULgq
   0sZTD7Gk5STUacLXgR4tEBFfr4yZ1EXZ6DkYX0Jw2HQPLbCVD4uHvS+HN
   KbKCPX4mhm1/FaeN8yhUajqZESe+X/c26Zy+59+7bR5KpaalvJWwgwmUq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="360518241"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="360518241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 19:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="733933991"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="733933991"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2023 19:14:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 19:14:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 19:14:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 19:14:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 19:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/24s+cN/oMoLiVNHykk7xWhLaacGKPLpa6DvIvNBuvPL0CvQKQeyX9VbMBZuyVEoysi5cTy0fiv0CBnzEP74HtChBDoca9pDprHWDQhcuYQA2UwbTZ0gIE7GlY3P/4gMNf+MFIriffBiokgMtNQzCeTlYC3xBgxbaPO+Io4ZBVOQOztXtciKwzWZeDfs4LweVuP5BW1cdgS6bcP3FpgGv/neJgwSyzf8eQ7iwJJ3cWSUTJJd79jKnBrtaihmrzUy8+OcFjXuEmZvDD1UAiY3dB1SQQMqZ6iE/wj7NAEaIX1eBK1XPErwmmIqPVqgoqSHVIRkf/YDmS0dlhab7HzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir6vfQye4iypch7+k0Sispucx759RE7YOhbqvOONEGw=;
 b=RgMWumewPqrwUCQMe48LrGsJWSPGLNk7IKseAaNmfa57NUEGNVy2nTTdxEPfZwskvhmJK3DhaQzNkkKOUzkzdpu9e/rU8wOpzWFQ+fA08HMLPKM38jHHUWBdoFUHsI6XxKI8YQERC/hErn7LG/y2N8/FoB4Cw8jgQww9IoBrsclvtmQXz3oy8J45pVeiSVUhkKjUWSnwn2hWLkvX49sW5uztzhI611Xxna5M5pb8pWGYcw856LUO7kzRAzU/29gQdooEqiwKQ/a+/8zwHcmEQfxG1o2grt5sSxHQVTOsfoJsCbmp5Y//2pgRHGMMJyhFQwuKWs0pa27020G8uAd3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:14:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 02:14:37 +0000
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
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Thread-Topic: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Thread-Index: AQHZv7EtIX/ZgmaCwUyXvrRdv67KjK/dNoCAgADz7gA=
Date:   Mon, 7 Aug 2023 02:14:37 +0000
Message-ID: <b15b45ff5dc2fcfa08dfb3171c269d9ab0349088.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
         <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
In-Reply-To: <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB8179:EE_
x-ms-office365-filtering-correlation-id: d3afda57-bce7-410f-d740-08db96ec0ca0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esogIcKXP9uyCpMWGtWtWEhQ/sPIl+CbsFA7eAKjHVPEIS96lR1MA46VZm+ui7q/YWuujLc6R6ik3Toeuaan7pZ2SOSLmPJtpbWT+nDTW7TKtx+7DuGRQ1h6GbA2nqKc6Dv07SIIv+6KSMXY4muglO5MvE68uWvxmIpGK+mmo6aZfacMvRF/4G4no/Tje9/raWZy8fC79sEiWRROFIPyeH9f5a/lbd2Ay8vPArMNZp/FWvbCw4WNuLZEs866XH1raAEtKxblWuKfKDDKk/+BqIcDp9WsNUnobUlYK2ULXFnTfc3z1ocUQV4IPlvQ6FJF8rtZW5Zc+7FIhMztZVarB5VMOaA+csnXRPwPJ6eKOarouw/f40xtyzj2OHH4GjTI2tUwRK41FBYqUwGAiVXX+M1pN8cQiov15hYQR+Ka27tkI6szBfuUYmE/d7ujJ9c2iuDQKP/A1kWYXbT2YVBnZqGJ2I5K8YwxuNTAbI4tMfn7Nf3O7+eR357sUiQz7FvjK5nGjvWMjG0+zl2Te1wFMl1XLxLrn3f2oUABeg+IX3tidM1TsPcGBuqBtbkbbN1hs17V6ZqX/rGhKy4TmO/ZclD3qT7bWmYuwGRpG+unQszGiPb1BONv1H7nZO776pCA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(4326008)(6512007)(316002)(6916009)(86362001)(122000001)(478600001)(82960400001)(54906003)(38100700002)(76116006)(91956017)(71200400001)(66946007)(6486002)(66556008)(66476007)(66446008)(64756008)(6506007)(41300700001)(26005)(38070700005)(8676002)(8936002)(2906002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajVySFJLTEhnMXNmelptL054Z1hFYW1UWnZkMUEzaVNsOWRBTXJINnZ3cEhn?=
 =?utf-8?B?cmpucDRTb3AvUTFKaGsvd2xmUU5kTEJEUjdYVm9xaWhWcDFNYVhYVk1PYU1D?=
 =?utf-8?B?UGhDaEZVNGNSbXdpelZWTHZDeGpudHpPWmVBNDZaazIwbFJiY0Rpa04vemhU?=
 =?utf-8?B?bFhTV2dlZnhhMUd6RWkzaStxaE5vN0ZzU0hCUkFGeTkxd21reTF3VEdxUThI?=
 =?utf-8?B?cTZiNjhWWFVGRmhlMGEvd1A2aGFoaE5LZkNMMG5vSzFGazNNaUlGTTkrd1NS?=
 =?utf-8?B?a0k2Z3JOU0hiK0tWQXVHQlNlUDZ4d0NRWW1VQWtVTDZtT3hRd1dsa25Eb1JK?=
 =?utf-8?B?ZXVQSW1KZFdmQXYyRFZUNmh2ZWpxRkdNZWRMc1FmelkvR1lCNGFHL3hKYVJZ?=
 =?utf-8?B?VFlwZHVXRHZjYTVPbmFIZ3paZlRKM0laUlBsS2l0VWhqcWw5d1ppVzJlYkZO?=
 =?utf-8?B?S00xZmNKbTBLRmMybUloM2ZIbVB2ZFI0a2ZvWVN1QmE5RFJnWW9kM1JxWTFT?=
 =?utf-8?B?RForQ0ovWk05NFdIZUZENHV4KzIyWW9qbGM2UjRtc1o0aVhSS1hnMEk1N3ZO?=
 =?utf-8?B?bW1iRG9YcmI4NW8rejVFcU5FTmc0eUo1OVB4cGdIRHpyNUt4S0JqcFcrZEk3?=
 =?utf-8?B?T3FwVm5uRGRUYVljYm1NUUVCMWM4TmxGMnlObGVVU0xWcHl5WlB1c25PQklr?=
 =?utf-8?B?eXMzZWVaZVlZL0drNW5zTGFrMWY1d2F5KzZhS25jS1V4clAwbXB1T0NyMVNG?=
 =?utf-8?B?Vk5rTVByNklYeWlFdHdDbVNPTy9aQlpGalF4S3RpdWlpc05tR25zTU4rZ2hs?=
 =?utf-8?B?OWNtNmh0dUxVQ3RVa2hoTnFsc0RUVS9Cb0tPaGV6VERULzN1NmR1RjkzZXZW?=
 =?utf-8?B?Z1hoZWdHUVEwQWwzckNSa3Z5WkxGc0tNd2dhVFUzUHJhcWlvTXBNUTNldGJk?=
 =?utf-8?B?cVpxWUFHbGQ1b3VSQmVWQVZEOFFYRGFtVW85a2ZRS3NHekFla2tqUkhRdkJJ?=
 =?utf-8?B?WHhoampIb3RWYjc0YklNS3lTYUQxM3RXTG1ha0VSa2NxbGg5VVVnYTViREti?=
 =?utf-8?B?T1N5MmpQYStpaWgvZW1EWEJlcy9jQ1BhT05WbGhvZ2RXK3U4dFJQR0NnUktU?=
 =?utf-8?B?QlJZWGduQVo4V0ZRM3lubVRIbzR6ViszNnFmbHRlQWdLRDJYZGw0VS8yZWlR?=
 =?utf-8?B?VTdCcCtHTzJJM3dqTFBiSHdTcjdnMm9VbTYzTnFsQldiQUxwMGhBdVdDckEr?=
 =?utf-8?B?dERPdXd4MGZPcXRka0tkQkZjSlpzYmM5Nk95L1ZNeXlqMi94NHZjaTA0VG9o?=
 =?utf-8?B?MHFtalo4RW1CTklGM3RodFRpalBjNzlhSXR0OUdJWkVHUHUyOG84eXMwRjNu?=
 =?utf-8?B?ZEtDZkpra0QyTHhJeHBaSkduc21mOGoxcStocmR6QWJzR0o0aFpLM3lMUU4r?=
 =?utf-8?B?M2JTMGlETjZJVTd2eEZndVFNREgxNHpITnZhTHdjb2c0cjBpai9heEZTbnF3?=
 =?utf-8?B?S2dHZjVqNnNCeGl4WVpGTHR6SW9xVUg3R2lNS0ZZT202QWxlcHg3MFRmd2RR?=
 =?utf-8?B?RDRObVMzbGpFVHRCd0FvWmVMOHo4OFk2SStWTXVwMi9vWXlRbjBlKzY3endv?=
 =?utf-8?B?Rzl6d09hU0dYR2hZUXBEQ2RKdWtQZW5wdnVMQU0vUS9VMUYwZDgxRkRRay9q?=
 =?utf-8?B?Wnk0c25MNGtrUDIySFlyWk5yTVdadmEyc0k3VHZydnBOREFaVFF4WG1TZkZx?=
 =?utf-8?B?eGVISzU4dkVhYUh6SFl1YUpYdTMyRnhjaG11WXpBOUF0THhKZ1BHSXV1UU8y?=
 =?utf-8?B?TmplakFsVU16VS9mamNacXlWeS8zdjc0WHdhOCtHTSsxZko4N25GeDA0NUhw?=
 =?utf-8?B?YXZZQkhuaS90cUdtUUZlYkZJa0o2SHRTK2VOQVlsRjdMeXZSR21zSWh5N0Ex?=
 =?utf-8?B?dzJSdHRJL005eDJDWDZzdTdYV3NqTEEzVG1aaU12Yk5EVjlIeStBdnZZblMy?=
 =?utf-8?B?cDYvdndRUVd3RkE1QVZweTJMeTlzQVlDNVQyczMxRzBxcjM4RWhNNmJGWGhw?=
 =?utf-8?B?WkE2ZTRYQmVhT1IvcFFSNHZ6NXgwWXZiUEUvZHJ0ajFRa1RoL3Q4UUlzWVE1?=
 =?utf-8?Q?lndq+q/726bK7SUHDny78cK18?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA9011D3D7ED846B6CFF28E7730A836@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3afda57-bce7-410f-d740-08db96ec0ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 02:14:37.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4hLoeZNOAA46H0PBzSFcF5hb0JiJCqXQ+FpVxCb2WhhHup35SiVxMgV9XUZWjyCkx8DN+uqRagJrVt+xpi+1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
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

T24gU3VuLCAyMDIzLTA4LTA2IGF0IDE0OjQxICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNToxM1BNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gQEAgLTIwLDYgKzIxLDkgQEANCj4gPiAgI2RlZmlu
ZSBURFhfU1dfRVJST1IJCQkoVERYX0VSUk9SIHwgR0VOTUFTS19VTEwoNDcsIDQwKSkNCj4gPiAg
I2RlZmluZSBURFhfU0VBTUNBTExfVk1GQUlMSU5WQUxJRAkoVERYX1NXX0VSUk9SIHwgX1VMKDB4
RkZGRjAwMDApKQ0KPiA+ICANCj4gPiArI2RlZmluZSBURFhfU0VBTUNBTExfR1AJCQkoVERYX1NX
X0VSUk9SIHwgWDg2X1RSQVBfR1ApDQo+ID4gKyNkZWZpbmUgVERYX1NFQU1DQUxMX1VECQkJKFRE
WF9TV19FUlJPUiB8IFg4Nl9UUkFQX1VEKQ0KPiANCj4gSXMgdGhlcmUgYW55IGV4cGxhbnRpb24g
aG93IHRoZXNlIGVycm9yIGNvZGVzIGdvdCBjaG9zZW4/IExvb2tzIHZlcnkNCj4gYXJiaXRyYXJ5
IGFuZCBtYXkgY29sbGlkZSB3aXRoIG90aGVyIGVycm9yIGNvZGVzIGluIHRoZSBmdXR1cmUuDQo+
IA0KDQpBbnkgZXJyb3IgY29kZSBoYXMgVERYX1NXX0VSUk9SIGlzIHJlc2VydmVkIHRvIHNvZnR3
YXJlIHVzZSBzbyB0aGUgVERYIG1vZHVsZQ0KY2FuIG5ldmVyIHJldHVybiBhbnkgZXJyb3IgY29k
ZSB3aGljaCBjb25mbGljdHMgd2l0aCB0aG9zZSBzb2Z0d2FyZSBvbmVzLg0KDQpGb3Igd2h5IHRv
IGNob29zZSB0aGVzZSB0d28sIEkgYmVsaWV2ZSBYT1IgdGhlIFRSQVAgbnVtYmVyIHRvIFREWF9T
V19FUlJPUiBpcw0KdGhlIHNpbXBsZXN0IHdheSB0byBhY2hpZXZlOiAxKSBjb3N0aW5nIG1pbmlt
YWwgYXNzZW1ibHkgY29kZTsgMikNCm9wcG9ydHVuaXN0aWNhbGx5IGhhbmRsaW5nICNHUCB0b28s
IGFsbG93aW5nIGNhbGxlciB0byBkaXN0aW5ndWlzaCB0aGUgdHdvDQplcnJvcnMuDQoNCkkgY2Fu
IGFkZCB0aGlzIHRvIHRoZSBjaGFuZ2Vsb2cuDQoNCkJ0dywgYXMgSSBjaGF0dGVkIHRvIHlvdSBJ
IGJlbGlldmUgd2UgaGF2ZSBhbm90aGVyIGp1c3RpZmljYXRpb24gdG8gaGFuZGxlDQojVUQvI0dQ
IGluIHRoZSBhc3NlbWJseTogZW1lcmdlbmN5IHZpcnR1YWxpemF0aW9uIGRpc2FibGUuICBUaHVz
IHdlIGNhbiBldmVuIGdldA0KcmlkIG9mIHRoZSBlcnJhdHVtIHN0YWZmIGluIHRoZSBjaGFuZ2Vs
b2cuDQoNCkhvdyBkb2VzIGJlbG93IGxvb2sgbGlrZT8NCg0KY29tbWl0IGQzZmYyMWRhMTA4M2E1
MjVlYjJjYWM2NTc2NDkwMDQ1ZTIyZjZmNWQNCkF1dGhvcjogS2FpIEh1YW5nIDxrYWkuaHVhbmdA
aW50ZWwuY29tPg0KRGF0ZTogICBNb24gSnVuIDI2IDE2OjA0OjA4IDIwMjMgKzEyMDANCg0KICAg
IHg4Ni92aXJ0L3RkeDogQWxsb3cgU0VBTUNBTEwgdG8gaGFuZGxlICNVRCBhbmQgI0dQDQogICAg
DQogICAgU0VBTUNBTEwgaW5zdHJ1Y3Rpb24gY2F1c2VzICNVRCBpZiB0aGUgQ1BVIGlzbid0IGlu
IFZNWCBvcGVyYXRpb24uDQogICAgQ3VycmVudGx5IHRoZSBURFhfTU9EVUxFX0NBTEwgYXNzZW1i
bHkgZG9lc24ndCBoYW5kbGUgI1VELCB0aHVzIG1ha2luZw0KICAgIFNFQU1DQUxMIHdoZW4gVk1Y
IGlzIGRpc2FibGVkIHdvdWxkIGNhdXNlIE9vcHMuDQogICAgDQogICAgVW5mb3J0dW5hdGVseSwg
dGhlcmUgYXJlIGxlZ2FsIGNhc2VzIHRoYXQgU0VBTUNBTEwgY2FuIGJlIG1hZGUgd2hlbiBWTVgN
CiAgICBpcyBkaXNhYmxlZC4gIEZvciBpbnN0YW5jZSwgVk1YIGNhbiBiZSBkaXNhYmxlZCBkdWUg
dG8gZW1lcmdlbmN5IHJlYm9vdA0KICAgIHdoaWxlIHRoZXJlIGFyZSBzdGlsbCBURFggZ3Vlc3Qg
aXMgcnVubmluZy4NCiAgICANCiAgICBFeHRlbmQgdGhlIFREWF9NT0RVTEVfQ0FMTCBhc3NlbWJs
eSB0byByZXR1cm4gYW4gZXJyb3IgY29kZSBmb3IgI1VEIHRvDQogICAgaGFuZGxlIHRoaXMgY2Fz
ZSBncmFjZWZ1bGx5LCBlLmcuLCBLVk0gY2FuIHRoZW4gcXVpdGVseSBlYXQgYWxsIFNFQU1DQUxM
DQogICAgZXJyb3JzIGNhdXNlZCBieSBlbWVyZ2VuY3kgcmVib290Lg0KICAgIA0KICAgIFNFQU1D
QUxMIGluc3RydWN0aW9uIGFsc28gY2F1c2VzICNHUCB3aGVuIFREWCBpc24ndCBlbmFibGVkIGJ5
IHRoZSBCSU9TLg0KICAgIFVzZSBfQVNNX0VYVEFCTEVfRkFVTFQoKSB0byBjYXRjaCBib3RoIGV4
Y2VwdGlvbnMgd2l0aCB0aGUgdHJhcCBudW1iZXINCiAgICByZWNvcmRlZCwgYW5kIGRlZmluZSB0
d28gbmV3IGVycm9yIGNvZGVzIGJ5IFhPUmluZyB0aGUgdHJhcCBudW1iZXIgdG8NCiAgICB0aGUg
VERYX1NXX0VSUk9SLiAgVGhpcyBvcHBvcnR1bmlzdGljYWxseSBoYW5kbGVzICNHUCB0b28gd2hp
bGUgdXNpbmcNCiAgICB0aGUgc2FtZSBzaW1wbGUgYXNzZW1ibHkgY29kZS4NCiAgICANCiAgICBB
IGJvbnVzIGlzIHdoZW4ga2VybmVsIG1pc3Rha2VubHkgY2FsbHMgU0VBTUNBTEwgd2hlbiBDUFUg
aXNuJ3QgaW4gVk1YDQogICAgb3BlcmF0aW9uLCBvciB3aGVuIFREWCBpc24ndCBlbmFibGVkIGJ5
IHRoZSBCSU9TLCBvciB3aGVuIHRoZSBCSU9TIGlzDQogICAgYnVnZ3ksIHRoZSBrZXJuZWwgY2Fu
IGdldCBhIG5pY2VyIGVycm9yIGNvZGUgcmF0aGVyIHRoYW4gYSBsZXNzDQogICAgdW5kZXJzdGFu
ZGFibGUgT29wcy4NCiAgICANCiAgICBUaGlzIGlzIGJhc2ljYWxseSBiYXNlZCBvbiBQZXRlcidz
IGNvZGUuDQogICAgDQogICAgQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92
QGxpbnV4LmludGVsLmNvbT4NCiAgICBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT4NCiAgICBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
Pg0KICAgIFN1Z2dlc3RlZC1ieTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
Pg0KICAgIFNpZ25lZC1vZmYtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdGR4LmgNCmluZGV4IDYwM2U2ZDFlOWQ0YS4uNmI4NTQ3ZGM0MGZkIDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3RkeC5oDQpAQCAtOCw2ICs4LDcgQEANCiANCiAjaW5jbHVkZSA8YXNtL2Vycm5vLmg+DQogI2lu
Y2x1ZGUgPGFzbS9wdHJhY2UuaD4NCisjaW5jbHVkZSA8YXNtL3RyYXBuci5oPg0KICNpbmNsdWRl
IDxhc20vc2hhcmVkL3RkeC5oPg0KIA0KIC8qDQpAQCAtMjAsNiArMjEsOSBAQA0KICNkZWZpbmUg
VERYX1NXX0VSUk9SICAgICAgICAgICAgICAgICAgIChURFhfRVJST1IgfCBHRU5NQVNLX1VMTCg0
NywgNDApKQ0KICNkZWZpbmUgVERYX1NFQU1DQUxMX1ZNRkFJTElOVkFMSUQgICAgIChURFhfU1df
RVJST1IgfCBfVUwoMHhGRkZGMDAwMCkpDQogDQorI2RlZmluZSBURFhfU0VBTUNBTExfR1AgICAg
ICAgICAgICAgICAgICAgICAgICAoVERYX1NXX0VSUk9SIHwgWDg2X1RSQVBfR1ApDQorI2RlZmlu
ZSBURFhfU0VBTUNBTExfVUQgICAgICAgICAgICAgICAgICAgICAgICAoVERYX1NXX0VSUk9SIHwg
WDg2X1RSQVBfVUQpDQorDQogI2lmbmRlZiBfX0FTU0VNQkxZX18NCiANCiAvKg0KZGlmZiAtLWdp
dCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhjYWxsLlMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4Y2FsbC5TDQppbmRleCAzZjBiODNhOTk3N2UuLjAxNmEyYTFlYzFkNiAxMDA2NDQNCi0t
LSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhjYWxsLlMNCisrKyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHhjYWxsLlMNCkBAIC0xLDYgKzEsNyBAQA0KIC8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wICovDQogI2luY2x1ZGUgPGFzbS9hc20tb2Zmc2V0cy5oPg0KICNpbmNs
dWRlIDxhc20vZnJhbWUuaD4NCisjaW5jbHVkZSA8YXNtL2FzbS5oPg0KICNpbmNsdWRlIDxhc20v
dGR4Lmg+DQogDQogLyoNCkBAIC04NSw2ICs4Niw3IEBADQogLmVuZGlmIC8qIFxzYXZlZCAqLw0K
IA0KIC5pZiBcaG9zdA0KKy5Mc2VhbWNhbGxcQDoNCiAgICAgICAgc2VhbWNhbGwNCiAgICAgICAg
LyoNCiAgICAgICAgICogU0VBTUNBTEwgaW5zdHJ1Y3Rpb24gaXMgZXNzZW50aWFsbHkgYSBWTUV4
aXQgZnJvbSBWTVggcm9vdA0KQEAgLTE5MSwxMSArMTkzLDI4IEBADQogLmlmIFxob3N0DQogLkxz
ZWFtY2FsbF92bWZhaWxpbnZhbGlkXEA6DQogICAgICAgIG1vdiAkVERYX1NFQU1DQUxMX1ZNRkFJ
TElOVkFMSUQsICVyYXgNCisgICAgICAgam1wIC5Mc2VhbWNhbGxfZmFpbFxADQorDQorLkxzZWFt
Y2FsbF90cmFwXEA6DQorICAgICAgIC8qDQorICAgICAgICAqIFNFQU1DQUxMIGNhdXNlZCAjR1Ag
b3IgI1VELiAgQnkgcmVhY2hpbmcgaGVyZSBSQVggY29udGFpbnMNCisgICAgICAgICogdGhlIHRy
YXAgbnVtYmVyLiAgQ29udmVydCB0aGUgdHJhcCBudW1iZXIgdG8gdGhlIFREWCBlcnJvcg0KKyAg
ICAgICAgKiBjb2RlIGJ5IHNldHRpbmcgVERYX1NXX0VSUk9SIHRvIHRoZSBoaWdoIDMyLWJpdHMg
b2YgUkFYLg0KKyAgICAgICAgKg0KKyAgICAgICAgKiBOb3RlIGNhbm5vdCBPUiBURFhfU1dfRVJS
T1IgZGlyZWN0bHkgdG8gUkFYIGFzIE9SIGluc3RydWN0aW9uDQorICAgICAgICAqIG9ubHkgYWNj
ZXB0cyAzMi1iaXQgaW1tZWRpYXRlIGF0IG1vc3QuDQorICAgICAgICAqLw0KKyAgICAgICBtb3Zx
ICRURFhfU1dfRVJST1IsICVyZGkNCisgICAgICAgb3JxICAlcmRpLCAlcmF4DQorDQorLkxzZWFt
Y2FsbF9mYWlsXEA6DQogLmlmIFxyZXQgJiYgXHNhdmVkDQogICAgICAgIC8qIHBvcCB0aGUgdW51
c2VkIHN0cnVjdHVyZSBwb2ludGVyIGJhY2sgdG8gUlNJICovDQogICAgICAgIHBvcHEgJXJzaQ0K
IC5lbmRpZg0KICAgICAgICBqbXAgLkxvdXRcQA0KKw0KKyAgICAgICBfQVNNX0VYVEFCTEVfRkFV
TFQoLkxzZWFtY2FsbFxALCAuTHNlYW1jYWxsX3RyYXBcQCkNCiAuZW5kaWYgLyogXGhvc3QgKi8N
CiANCiAuZW5kbQ0K
