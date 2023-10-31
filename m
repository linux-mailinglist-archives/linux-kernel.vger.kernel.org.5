Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C07DC451
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjJaCO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJaCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:14:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A67E12D;
        Mon, 30 Oct 2023 19:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698718456; x=1730254456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o+KC32sLjou9iCLKRuJHhFK3Xqh3LtloQROhuKpqDSU=;
  b=EIlAgGiCK0KwS9YNPPfQ0uczAP5B5WpDeOQOnmT5qlOz7cGcms3ouPDH
   fT9Ml5A+rJKhSc8Xwlp7oW2kd7XEvaen//NU9EGAPu4/4+gJfg2+LubaB
   oS2+W43rJD6uftA+ks8koRL6fmG6m2iTb6N6hESytLkpsZvJQCg7vjOdE
   PS8417ShO8WrY8d61Hh1DUMChV14u8xd1LxcqVRTKnzEp4xeGgo22JC9Y
   90jx5QBu+6V902GfI5UsUv0M8RRuBAprX1xYCZkfnlyHPhSyV9XnI5+SG
   Bor3VaHa4BumTrjksOXAztabb6YsCaVw2jYyNh4agbTDMo+DA6rLf8th0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387078838"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="387078838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789636582"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="789636582"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 19:14:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:14:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:14:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPOPHAMcJCalVdYXMOG+WY4J5cx5skcFNrwcKPLKuk0EdxTqXneZ5ZdvqeGXMsRK1FsNwLEOjhyQPvLdZAE2KmVWXdNlFocM9TIzM6DSj+wX/b0AX0saJ19PWdBUkeJyq4oU5eKXm7i9Gj5aq0HQkmv6vUYipYM0WEuo4vZTo7V+kbmcqSe+GP0YqagUvkVDtTjvSJHrvNFfT0Lz5cE24peCWUvkuKxd2qRTTugDtf3qw/ZfAnf9nfVdZICHCOCcbNa4YMveOx48IbfmKuzqdMKhkdeQzUUNi7rn5BqPowe5fgwTfa2mbCjZrsXJAyy6l8yM3D+NKRKGPsO6g6d4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+KC32sLjou9iCLKRuJHhFK3Xqh3LtloQROhuKpqDSU=;
 b=b4ulHKCqc7QoU0OC0Ane03DZUnd0MQAwxP9GlgSSeToCuoFFLQjmaQ+9KXvkvT4yje2tYFab3aYoP5+ccDxhnZM5Bj1LttGgXAU6dc16n6S+LyXpDqi7fMouqsbZ3TDoRUrtr+8LFV4YxziGQgw1wbGZYXp9mHRdFk6qphzOUVt/HWsMAN40v+d/8xlvFEg9DMCIHszPrsfnj3DlTV8pZblq0cm5rwxprdVXsryo9NWF4dHOnBjarZSY/icU394a9VdaGZsVnWilpBLtF30YXvH2+eBT2GdxXrk6XCY4OLriqbMRWIDM5W2axHJUSUsb+wEoNftLrk6oweU2xXzVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 02:14:08 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 02:14:08 +0000
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
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v7 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v7 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHaB5TixCHG5cTHNk2mA1ySpDzMbbBiJjaAgAEKeQA=
Date:   Tue, 31 Oct 2023 02:14:07 +0000
Message-ID: <cdeef06d81abb3fc4b5f4bea6b3fd5b83972249b.camel@intel.com>
References: <20231025-vv-kmem_memmap-v7-0-4a76d7652df5@intel.com>
         <20231025-vv-kmem_memmap-v7-2-4a76d7652df5@intel.com>
         <4df63333-de57-4a58-a110-77b4fdfa6a9e@redhat.com>
In-Reply-To: <4df63333-de57-4a58-a110-77b4fdfa6a9e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: 1cdd998b-c38a-4a8b-7977-08dbd9b71040
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a40vqQ1e3CXiOOP8TEKO3NnK492AiTWJSF10iYy6yjhZbGd0e4PO18wtSmnTH6jVFAOlt9yPKzZzcrSA0RsyH8Jr4e6b/pjMwgB1EOHqJqWasbCKBSyjtMQyc8QlJW6XvrYpzP80dJWq1RW014HtvvuqJ9BPQIbxOF2BA6Mv2MswfwkptJz7IrSf7w/YxPGr0du0tgOFChhS9NWW/E/atTIApsjPmv4gyUjGuLwTimIdCdxpDxpNdrT8x7yNibiaKVAFvqLLM1DialXfLIRl7/w9/wxF5Cx6TLeAHNnVF7f8RZU2oj1VbI5GAnubEyeb6+853we6tvXB1bYGto6aUmJpHGndT6wgTPOM0gTsEXTWpy4li7ib66Vdgbf6pR9I1QeURkONXilLuaXj1KRhNIfalO2+vtwReLQeof/BQB4mBagIrd1AUIAmE8kcKLUJf8WSc50lI/IB9f1+nTzW1Z1H5h6MZaUfxN9rdrONVMqHcCEuWv6/VNNnyKQncZup/vyhwVrpA+6mVadzJSepDdPgUbTzjCdgF4g8NGSnPrNQy3cEQ96UI9bewy40cNer/9G0Bf4vUT5Aivoerft/ZI+/nHQ07x0XGh07ORd8g7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(6486002)(53546011)(66946007)(6512007)(6506007)(316002)(38070700009)(110136005)(76116006)(66446008)(66476007)(66556008)(54906003)(64756008)(8676002)(8936002)(86362001)(36756003)(41300700001)(5660300002)(4001150100001)(4326008)(2906002)(7416002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhvb0RoYTR2UXhXcHB0dU9XOG1tcDl4a09VaTR2dk5LSVZiTzhMUDhodnZj?=
 =?utf-8?B?czBFZDhRMElQZk0wbGF0aUdZNUNXZUFMN2E0ZW5jb3BGTk5pTWREeXBkZ1U2?=
 =?utf-8?B?VE83cStsT1JrOXVRTGtuaUlibVBEWjZEbk1XNWlWZnVLWldBOWlsbytPTmN4?=
 =?utf-8?B?SWdNcjQ0WWp1VXRMWUJJVUVNa1RHRnBGd284T1M4eGxLQWxSemFKcU5QUVFY?=
 =?utf-8?B?YW1ENitsLzRKZzB5Qmh3WnRabTl2TTJ3OG1ZVDBlNzQ4K3J0emU3Q2Q5QlhW?=
 =?utf-8?B?SWJYOWtBNFdNREs5dDF3aEJDd3FJWnQwM0U0bjkvbjU3Sm1GY21uZmRzUDlN?=
 =?utf-8?B?cSttWk1mWUlJWmpvZmZCOWkzbzVmcExjdGxURVZWSEVHZUVhY24rcTVZWW1W?=
 =?utf-8?B?YjJyMXM2NUN3bmo4SERHMkRUZ3hNZTlXNklNS0cwQVhCRDQ3eHVkbVp5N0NN?=
 =?utf-8?B?VDEvOFdsOUUzZ2EwSWd6TzRqaVY3NVRYbUpITmhDKzROVUhuakZzZXNtOXVE?=
 =?utf-8?B?N3dyTGV3enp6OU5hNUMvb0cxckF6SHR5RllWQWpINXUyb1poSSsyT1cyZ2NP?=
 =?utf-8?B?V2NjUlMrcjRsWTJORmx6MGNnbkE3cmlMdmR2TkNIdStxUzFRQXFaOHM4SFpB?=
 =?utf-8?B?UUFMa3VudEhqYzR4bTVQTFJtTkVzc1FBWjFJMTYxd2pNb0ZTc3NXMi9ucUIx?=
 =?utf-8?B?b1JSUnpBUW9yb3dCTExaU2k2TzlvbGtTWk04SEdXbW1zM2NJQ09kTk5sWERQ?=
 =?utf-8?B?eUIrTnBXbCtNMFZSbkhDUUZkL3ZnQU81bFA2amZBaVI3Q2dJZVhJTXE3bVl1?=
 =?utf-8?B?TktEbEFEV09yR0RaNC8rbVYzODhYSmYzMy9vakdHZ00yT1pvVGVCMko4YUNJ?=
 =?utf-8?B?L0FnWG1FVHprMUpUdzRkRWxmek55OEZLeWpDVEF4UTczTUw3OGkxMXZoSjY0?=
 =?utf-8?B?Sm44SG8vbWR2WU9SOTFZYWRwY2NZMGc1ZmJCVVU3cWJCelNpblQ5ckF1ZHhW?=
 =?utf-8?B?L2svTTByWEZVTWFKRWRXc2hTbnozdnZtNU5uZEdvNzhMMjVQRnNFUFRZYTNu?=
 =?utf-8?B?UlhQZHQwaHlyUW5GbXpSdm42VlRFZ21zRjhxbG94Ukd3aVJ6WnRjM2JYZkpP?=
 =?utf-8?B?MGZtekVpYmVPNjZ2ZndRVHpLYmFtb0l2QjlnR041Y1ZyQW12OTlmR1pjWWVH?=
 =?utf-8?B?QWdxQmdvRGthNzE0b2NoTUtaQUJ2c1dpTnhtVnVsczJIbTg0V2NJUEo3UEFG?=
 =?utf-8?B?MjV1cXRCQUNpemszaG1LY2dxOEFYcUVoVTdlZUxDRzJZTTZyNVN0Y29Ib2p3?=
 =?utf-8?B?a2NvbkM3akJIODdJSjRLbks2bVNGYmRyd1cvblVjcUM2NUFCNWFHU3JjMk5F?=
 =?utf-8?B?TmNmdjI3cWVPSXdBdW9BamZmcGc4Z01IOXVkOEFza2ZPZmg3UUZxM2I4MDNE?=
 =?utf-8?B?cndOdjdLVU5FbGNUK1lqdmdKbzNWUHlNMmRncDdMQTJvdStzc2x6TGx1UWpv?=
 =?utf-8?B?cXFPN3N0a01uUy9Fb0ZlM1ZlTTZ1Qy9ZVVJ0RXJFTEtoY1FValpSeVlSOHFW?=
 =?utf-8?B?S3FURWJrKzVnSk14aVZOZ1d4L1RiZUdsQjNRcnIvcVl0L3h6VEF1cGtVdG5B?=
 =?utf-8?B?REZib3RCaEpreFk5cHA1YzRyZElTbExRakVHTGpvdFgxVWN2eSsvT0RmSW1T?=
 =?utf-8?B?RUVGTHBRZTBmMHMvVjRYRzIvZENkZkthS3pLSnJ6TnpKQ25tbWs0NnFoOVJx?=
 =?utf-8?B?Z0VVQ2l2RE1zMDZmQXlVelZ0a2JWY3NQZnpwMWgyZHJ0RzlUNktXdElkWU1O?=
 =?utf-8?B?d29FUlNaZjR3TytUWU1aclgzeCszNkpoaFBFNHhJYTI0MXVFRlQzNElvYUUz?=
 =?utf-8?B?bVlRUXRmZXVaSlFzNjgwRzRYc0YzQ3hCOFBPL0NoenppM2JDdElFLzR4NTdr?=
 =?utf-8?B?VzBXa0lnQXRyVTFobVpLcWpkRG0vOUF2Y1R6ekpMU0U4cnAyKzBuN1hxMEdX?=
 =?utf-8?B?Sjd6WThKOXdjaGZvTGtqZTlQZEpuWlk1ZEpCNk9BTGVPMmFRVXdlUFVKN3Fo?=
 =?utf-8?B?WjhBUkliUlliMEFKTXh2dUUrcllreUhiWW9WMU14cSt3aFJyL1A5Um1QVEh6?=
 =?utf-8?B?L1B4a2E5OWF0amZVSkF6aEhTdS9BWGd3UXNQdk1CSTl2cEdXNHAwZDZSUk91?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <017231DDA262B24B8D6A03F7399B0962@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdd998b-c38a-4a8b-7977-08dbd9b71040
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:14:07.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkoCNvBv+NQYVnQZbL/BcBcimwwBsCrdekrHkGA6HGNLoSJOHTPJO2NVKfCgm1leFEaJKl/OmL7v6mz6tBdC87u6mAbZ5UzoeLsXAEF/Nso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDExOjIwICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAyNi4xMC4yMyAwMDo0NCwgVmlzaGFsIFZlcm1hIHdyb3RlOgo+ID4gClsuLl0KCj4g
PiBAQCAtMjE0NiwxMSArMjE4Niw2OSBAQCB2b2lkIHRyeV9vZmZsaW5lX25vZGUoaW50IG5pZCkK
PiA+IMKgIH0KPiA+IMKgIEVYUE9SVF9TWU1CT0wodHJ5X29mZmxpbmVfbm9kZSk7Cj4gPiDCoCAK
PiA+IC1zdGF0aWMgaW50IF9fcmVmIHRyeV9yZW1vdmVfbWVtb3J5KHU2NCBzdGFydCwgdTY0IHNp
emUpCj4gPiArc3RhdGljIHZvaWQgX19yZWYgcmVtb3ZlX21lbW9yeV9ibG9ja3NfYW5kX2FsdG1h
cHModTY0IHN0YXJ0LCB1NjQgc2l6ZSkKPiA+IMKgIHsKPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVj
dCBtZW1vcnlfYmxvY2sgKm1lbTsKPiA+IC3CoMKgwqDCoMKgwqDCoGludCByYyA9IDAsIG5pZCA9
IE5VTUFfTk9fTk9ERTsKPiA+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgbWVtYmxvY2tf
c2l6ZSA9IG1lbW9yeV9ibG9ja19zaXplX2J5dGVzKCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IHZtZW1fYWx0bWFwICphbHRtYXAgPSBOVUxMOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IG1lbW9yeV9ibG9jayAqbWVtOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTY0IGN1cl9zdGFydDsKPiA+
ICvCoMKgwqDCoMKgwqDCoGludCByYzsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoC8qCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKiBGb3IgbWVtbWFwX29uX21lbW9yeSwgdGhlIGFsdG1hcHMgY291bGQg
aGF2ZSBiZWVuIGFkZGVkIG9uCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhIHBlci1tZW1ibG9jayBi
YXNpcy4gTG9vcCB0aHJvdWdoIHRoZSBlbnRpcmUgcmFuZ2UgaWYgc28sCj4gPiArwqDCoMKgwqDC
oMKgwqAgKiBhbmQgcmVtb3ZlIGVhY2ggbWVtYmxvY2sgYW5kIGl0cyBhbHRtYXAuCj4gPiArwqDC
oMKgwqDCoMKgwqAgKi8KPiAKPiAvKgo+IMKgICogYWx0bWFwcyB3aGVyZSBhZGRlZCBvbiBhIHBl
ci1tZW1ibG9jayBiYXNpczsgd2UgaGF2ZSB0byBwcm9jZXNzCj4gwqAgKiBlYWNoIGluZGl2aWR1
YWwgbWVtb3J5IGJsb2NrLgo+IMKgICovCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGN1cl9z
dGFydCA9IHN0YXJ0OyBjdXJfc3RhcnQgPCBzdGFydCArIHNpemU7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjdXJfc3RhcnQgKz0gbWVtYmxvY2tfc2l6ZSkgewo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gd2Fsa19tZW1vcnlfYmxvY2tzKGN1cl9zdGFydCwgbWVt
YmxvY2tfc2l6ZSwgJm1lbSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0ZXN0X2hhc19hbHRt
YXBfY2IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYykgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbHRtYXAgPSBt
ZW0tPmFsdG1hcDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogTWFyayBhbHRtYXAgTlVMTCBzbyB0aGF0IHdlIGNhbiBhZGQgYSBkZWJ1Zwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjaGVjayBvbiBt
ZW1ibG9jayBmcmVlLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbWVtLT5hbHRtYXAgPSBOVUxMOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiAKPiBTaW1wbGVyIChlc3BlY2lhbGx5LCB3ZSBrbm93IHRoYXQgdGhlcmUgbXVzdCBi
ZSBhbiBhbHRtYXApOgo+IAo+IG1lbSA9IGZpbmRfbWVtb3J5X2Jsb2NrKHBmbl90b19zZWN0aW9u
X25yKGN1cl9zdGFydCkpOwo+IGFsdG1hcCA9IG1lbS0+YWx0bWFwOwo+IG1lbS0+YWx0bWFwID0g
TlVMTDsKPiAKPiBJIHRoaW5rIHdlIG1pZ2h0IGJlIGFibGUgdG8gcmVtb3ZlIHRlc3RfaGFzX2Fs
dG1hcF9jYigpIHRoZW4uCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVtb3ZlX21lbW9yeV9ibG9ja19kZXZpY2VzKGN1cl9zdGFydCwgbWVtYmxvY2tfc2l6ZSk7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJjaF9yZW1vdmVfbWVt
b3J5KGN1cl9zdGFydCwgbWVtYmxvY2tfc2l6ZSwgYWx0bWFwKTsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBWZXJpZnkgdGhhdCBhbGwgdm1lbW1hcCBwYWdlcyBo
YXZlIGFjdHVhbGx5IGJlZW4gZnJlZWQuICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKGFsdG1hcCkgewo+IAo+IFRoZXJlIG11c3QgYmUgYW4gYWx0bWFwLCBzbyB0aGlz
IGNhbiBiZSBkb25lIHVuY29uZGl0aW9uYWxseS4KCkhpIERhdmlkLAoKQWxsIG90aGVyIGNvbW1l
bnRzIG1ha2Ugc2Vuc2UsIG1ha2luZyB0aG9zZSBjaGFuZ2VzIG5vdy4KCkhvd2V2ZXIgZm9yIHRo
aXMgb25lLCBkb2VzIHRoZSBXQVJOKCkgYmVsb3cgZ28gYXdheSB0aGVuPwoKSSB3YXMgd29uZGVy
aW5nIGlmIG1heWJlIGFyY2hfcmVtb3ZlX21lbW9yeSgpIGlzIHJlc3BvbnNpYmxlIGZvcgpmcmVl
aW5nIHRoZSBhbHRtYXAgaGVyZSwgYW5kIGF0IHRoaXMgc3RhZ2Ugd2UncmUganVzdCBjaGVja2lu
ZyBpZiB0aGF0CmhhcHBlbmVkLiBJZiBpdCBkaWRuJ3QgV0FSTiBhbmQgdGhlbiBmcmVlIGl0LgoK
SSBkcmlsbGVkIGRvd24gdGhlIHBhdGgsIGFuZCBJIGRvbid0IHNlZSBhbHRtYXAgYWN0dWFsbHkg
Z2V0dGluZyBmcmVlZAppbiB2bWVtX2FsdG1hcF9mcmVlKCksIGJ1dCBJIHdhc24ndCBzdXJlIGlm
IDxzb21ldGhpbmcgZWxzZT4gd2FzIG1lYW50CnRvIGZyZWUgaXQgYXMgYWx0bWFwLT5hbGxvYyB3
ZW50IGRvd24gdG8gMC4KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFdBUk4oYWx0bWFwLT5hbGxvYywgIkFsdG1hcCBub3QgZnVsbHkgdW5tYXBw
ZWQiKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
a2ZyZWUoYWx0bWFwKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAr
wqDCoMKgwqDCoMKgwqB9Cj4gPiArfQo+IAo+IAoK
