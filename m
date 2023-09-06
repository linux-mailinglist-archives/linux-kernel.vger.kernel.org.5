Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C02793C81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbjIFMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjIFMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:21:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3561713
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694002909; x=1725538909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zj8/EugBGxm977p3CTdZ2nOzv4rxKlv0ylbU7H+AGyI=;
  b=NoFtv09oixR0b319DO/wlIMCfpqQzYHz7epHF95vhVG+c3EE/oflTtVy
   ImR5Cvn0nRu7ZcMr7Zi3Zaod36X4U4ppbttERD5jt0Wk0rAM2Gv2sQnFG
   7gFmqd8BUkOaSrYwrF/lvf5jaYl9e+hiD9UqfnQQi+L/D9Uom0smUwOkX
   w5QP8gKj3vYUyFM9cupgVT1+WR6ReWkfTB5M/Ufn3wF3x+FgLjXG7+w+N
   QXfwCkR2w/qjXLHoDWk/XTzg5gExLQeH+93IBbxy+1NS9QTxkaZr9ThB1
   4BWYcV/5sICPtGo1gBWw0kP4HKli+Y3ao0+ptJLJyLhc8zr5ZTEozCfwN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374445621"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374445621"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="811632614"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="811632614"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 05:21:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 05:21:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 05:21:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 05:21:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWP2IzlQ4M354xOyjGoHZNNf2zOMYJtjKSvUKp/vuCv1TTNO9acsEkTUnIJUHDCTotnYUMhntIJmGOe19JGZQQztpo7SYjZ9DqV4SGYY/Hkephd4zpbfpk7jII/gQcP9n/vsgMWVIfe6RmPvZYS2Abk8SZsIA5zR+fuRz05yOeKnApP/33sSsPb+K0rYMA2205THHv0TWOdsOfqkCI+NmWCJ2ldLUxNqFpYJAHHDcxHVsB07TANTglgbGqONQtj5TH+j6U4Kglh9hxEBv7fYpyJNTLUkOg49dzZ4o7ETNDo0nIyFpLMC+mA88BOVm0F+ulX9useGOF7mjHpbHiA/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj8/EugBGxm977p3CTdZ2nOzv4rxKlv0ylbU7H+AGyI=;
 b=aoF8psapJ5XA8lidjnk+mr7tz8HcHXmCb+Zn5W9fh2XNI8mjGgPdSDYm3jQBtMa8dKMGw1LZDTA0gYG/ln/g5UT2YwhB+eG4oN0LK0dqIHf30E6k8R0hzXVv3vw7jB8QJsG42ch7rUU2GLBHRiP11CJUPClh4SsMu75HKNomW4mRFeYN4ELOlCQMUtSYYPwJBZZisQSyftAmJPtQo2+SQc+BMn2vwuLQq795BYJWR64yfe1/G4qaZvdqmG+hO7/zY7WFE6SSj3s4Le8O7raaG0ebBripzeODXzb8uRKAc658+OnMKVDMalYqVevwYtnEGOna2Fkdfy1B+osMCmDmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:21:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 12:21:35 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZz2d2h64fZccrFk6GvcmTUnLRhLAM+vwAgADYxACAAAbJgA==
Date:   Wed, 6 Sep 2023 12:21:35 +0000
Message-ID: <e5e18b2eed05b15867ad5c9b1288ae128967bf21.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
         <20230906115716.GF38741@noisy.programming.kicks-ass.net>
In-Reply-To: <20230906115716.GF38741@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5155:EE_
x-ms-office365-filtering-correlation-id: 5043988d-ce67-4b24-6504-08dbaed3d021
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObF0bo5pWyBWBQkuwHwhqoszofLjdsDheSXFT9dh9BgKVFpHjvpg3UnZh6IX4nFudHuYBCSsLaVJHFJDHahvKVWyovjd+G393oeOfEWyZ1gDU9n0+hW54X3OPTorNFnpczYJCLfvml9n01EydvU925tEcLfJI7BJ/oftD+Mb98fDD3ps1zhiHRpFJYsEUMuN6AsAhMxfO6y0zlZ4YTKrZrYS/Nh4jqRKdLviZYr/wiZZN0dUm+BzfTHApqNB1s9lCcXLng5kYMZf7Lp3KE3PaxjKoSLLSgQJ2YmJB4crbRpN4Gl8Fyrw+z3/7jjtyK87h5SoLatf3vtkvkF7P1MOlLwYTBfxhtKOyb+KZtDgONrbqZNWkD0TgpYDVH6viWEgYG/miUTGYjxG8hVRsC4zaSJUwJZfBiN3q18byidvZvtaxex315v/g1GfGPAJAYCu1gzlMAyV8t8LH6fke0ktp4CkXOaKS5Doz4SoyivDzBkK0JaevnaMOgc04vXnvTVjdmld+HrvUocYsT7YB6Wl/v30FOhzEemd7B1AvSVN0JBF/26c6zYcSnwfEmIu2RumqIS6BIka+vQCxRJOLOYaHXW2BncM8OATO7cY7ocS3JxSaKHqtaEfXG/b6VRcvSEK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(6486002)(6506007)(5660300002)(71200400001)(4326008)(7416002)(54906003)(6916009)(66476007)(76116006)(316002)(66946007)(91956017)(66556008)(66446008)(64756008)(41300700001)(478600001)(6512007)(2906002)(26005)(2616005)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFEZFVXQ0pFMzU4Y3JxcXorL04yR2dhbEZFalRpVTdOSzBUQW9RTkNwTGtD?=
 =?utf-8?B?dmFVU2p2SGREd1dNUlpGSW5OcXJvaitJd0EzVERlRko3cFR1czhIS3BoM2ts?=
 =?utf-8?B?OFpqUTdzWldteDJsb0U1QWVpSmNrRXZMaEVYMHpmOEtJaUxGa1p6dG9wQ090?=
 =?utf-8?B?R1VrTWFyTERzRHkrcVZRZVdyVkpnNThaRlMySzZxRXo1SjlpeDJoVGVRcmh3?=
 =?utf-8?B?N0w1WmI1c2hKK1hBVmdUWk01UkU0bC8zOUhDeVJDUjFHMzJ1elF5cFZNTFJz?=
 =?utf-8?B?SFFnK0h4Nnd1ZGl3YmgxNnZFVldhampDYVk4TzQrOXlBTk9KTTBPanRNYlg5?=
 =?utf-8?B?Y3h2NlpwV3Nwb1JGZFkrUmlLVEVYVjgxZ3Zrc09SNDRHK29wNGhGdGhETmxr?=
 =?utf-8?B?aXhDVk1nSHRwY2dTQWJRMlJ4SGh4V2lVZmF6dmJGMmJFZlVUdlp2OXpTcWEy?=
 =?utf-8?B?dGxZcVpIQVZRNk03bEVQdjQ4WGJBakl2YzZCN3I0N0IrbTdhbGphTzBhOG1U?=
 =?utf-8?B?cEtmWkpKSStRWU5UNXQvcDRMWjBOTUpnbW03bEF4dmFZR0tTU2dFYnRmMUk2?=
 =?utf-8?B?NXpaNGJPS21MWDZEYzRwT3IyV0p5Y0NUMndFQzl2NVFOU2Mra29WM3ZVOHd4?=
 =?utf-8?B?ZWN4RnBZQTkzVnpBVk8vU1U5N0FDNEF3U1hmZ1FVV1pyWVRrMkVTWnJoSHI3?=
 =?utf-8?B?dGJVQ3ZzaERHcEd2bFc4WmltbEVQT3c5cWJQNk1MK3dkVEtVVXNkM2x3Y2V0?=
 =?utf-8?B?alVxZzZubk55Q0pxVkRaZ21GanNOdSttQXpyOE5nWkh3MW55aHVIdGdlRzJt?=
 =?utf-8?B?OE1IR3lmdVJBMFJ6Q3BLSmZ3Qm53dUxSQmJGN091QysrVnB5RmZoZkYyL0Fl?=
 =?utf-8?B?cmlINmFsSVRkeVp3SEVoN1NaTW85NXNHcGFyZ2JsRFQxSXh2VXRZUkZqOGFY?=
 =?utf-8?B?OVh0VnNuRk9vSFNxdmdBRFVQRmtVYlRMR2c2U0FWSjFsQzRZQTJBK1h3YUJC?=
 =?utf-8?B?T0tDdjhHQ0E1eGI2S1dob0syS2xqUi9Kc3ZOSjVKaHNQaWVMRzFVRnRjU0Ji?=
 =?utf-8?B?UklqQjVOckpOWkEzUnZIUmVQa0dHQVFWajUxNkt1S1NHODEyODJENlRhdENN?=
 =?utf-8?B?cExnY3JlVzN3bk9KMXpnYlNzcmp0Wld6SlNmK1pha0p1eHU2Z0lsVmhueVd1?=
 =?utf-8?B?cG1uYlBkeXlpSFB0MDNhSmZwUG5Ka1JOeDgvUnowZjdiaUw3QnhYS2dLT3RQ?=
 =?utf-8?B?MGNoNUdQUTBBcmhPQXZ4WHBTUk1veE9WeXBIdW82QUJpTlZJUHlITUtrRXQ4?=
 =?utf-8?B?OHY4bmo5SUpoUUU1WDJTV1pUb1RBWTl3RzRWNDQ3L0UxUk5mTE1heEV2TzI0?=
 =?utf-8?B?dDg2bnBjcWIxM2h1ZG80UWQrYlVhaG1ZR2huVTVLZWgybXNNcFlQYW9HcmQ1?=
 =?utf-8?B?K2FleW54dVNtT0xUbWt6aXBOak1vd0haOVVwdnNUcGcvZTIzUnNtYU1yS0pP?=
 =?utf-8?B?MlZ4RkJIME90N3dhb2tTcmVNTkNZOGtzZnRxaU5hYURzMzlndzBVWkRzb3B0?=
 =?utf-8?B?eTV1ZWV0OUlEM2tmcHUzRUxpSjNQSHN1WHRyaDlpUDFESzdKamhkWDNXMkR1?=
 =?utf-8?B?Y0ExWHNKekN5UFlDN080UTd0UC9mRTV2d1ZGWWhnTGpvM2VJTnR1V2hGVWtx?=
 =?utf-8?B?Z0MyaVlNd2lzQ0Z2VnBubzBXUFJkeWdoN0thOUFpeVQrU3k3U2VSRFNVSWJM?=
 =?utf-8?B?YkVOcXcvS29nUCtEMTRHc3l3eWYycmpJaTNNUmw4aGVVaWNPa3JGb2xmaHBU?=
 =?utf-8?B?dkptUnJ3U2JuOEFJT1hzdFlkVG1rKzRSYlJBYk5SQkI2a3BxVUlLRVkzeWtQ?=
 =?utf-8?B?d3p2b2hCSW9GQWFQTGdnZjNIMUp6cEFzZitDc2g0RmZyek5POVdiaVRnVFBD?=
 =?utf-8?B?cjZvOUFzQUpxRjdFeTBPNVNvbWNvYU5NZG5Wb09hZzcyRFJpQzJ1U2txaytP?=
 =?utf-8?B?ejJOR1QyZm16UnY1Uko4ZDhnR0ZOalpzWWR2V3d0Y0FKY20xVk1uVW5kQjF1?=
 =?utf-8?B?U2dFSDNQU2Q5cHdBclBSWFpNdFplb09aU0tSV0tPMmg1V2VaM21IMktnV2U5?=
 =?utf-8?Q?REAjaOfqMNoKFsVP3gBOUw5VQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9578D5079B9D5841A57E5E21785BBDEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5043988d-ce67-4b24-6504-08dbaed3d021
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 12:21:35.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qarZYcEPxfH2R1mXtlhmT/VQq4jDEg43IX5Sz04PwcPFh4LOAbP9bFGHTlsnM16jhXdcGzxR6bH25H5sFYDMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
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

T24gV2VkLCAyMDIzLTA5LTA2IGF0IDEzOjU3ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVHVlLCBTZXAgMDUsIDIwMjMgYXQgMTE6MDE6MjhQTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gPiBPbiBUdWUsIDIwMjMtMDgtMTUgYXQgMjM6MDEgKzEyMDAsIEthaSBIdWFuZyB3
cm90ZToNCj4gPiA+IEhpIFBldGVyLCBLaXJpbGwsDQo+ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVz
IHVuaWZpZXMgdGhlIGFzc2VtYmx5IGNvZGUgZm9yIFREQ0FMTC9TRUFNQ0FMTCBhbmQgVERWTUNB
TEwuDQo+ID4gPiBOb3cgYWxsIG9mIHRoZW0gdXNlIG9uZSBzaW5nZSBURFhfTU9EVUxFX0NBTEwg
YXNtIG1hY3JvLiAgTW9yZQ0KPiA+ID4gaW5mb3JtYXRpb24gcGxlYXNlIHNlZSBjb3ZlciBsZXR0
ZXIgb2YgdjIgKHNlZSBsaW5rIGJlbG93KS4NCj4gPiA+IA0KPiA+ID4gVGVzdGVkIGJ5IGJvb3Rp
bmcgVERYIGd1ZXN0LCBpbml0aWFsaXppbmcgVERYIG1vZHVsZSwgYW5kIHJ1bm5pbmcgVERYDQo+
ID4gPiBndWVzdCBzdWNjZXNzZnVsbHksIGFsbCB3aXRoIHRoaXMgc2VyaWVzIGFwcGxpZWQuDQo+
ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IEhpIFBldGVyLA0KPiA+IA0KPiA+IFNvcnJ5IHRvIHBp
bmcsIGJ1dCBjb3VsZCB5b3UgdGFrZSBhIGxvb2sgd2hldGhlciB5b3UgYXJlIE9LIHdpdGggdGhp
cyBzZXJpZXM/DQo+ID4gDQo+ID4gQmFzaWNhbGx5IEtpcmlsbCBoYXMgcHJvdmlkZWQgaGlzIFJl
dmlld2VkLWJ5IGZvciBhbGwgdGhlIHBhdGNoZXMgZXhjZXB0IHRoZQ0KPiA+IGxhc3Qgb25lIChB
ZGQgdW51c2VkIHJlZ2lzdGVycyB0byAnc3RydWN0IHRkeF9tb2R1bGVfYXJncycgdG8gb3B0aW1p
emUgVlAuRU5URVINCj4gPiBmb3IgS1ZNKSwgd2hpY2ggaGUgZGlkbid0IGxpa2UuICBCdXQgaXQg
aXMgcHJldHR5IG11Y2ggYSBzdGFuZGFsb25lIG9wdGltaXphdGlvbg0KPiA+IHBhdGNoIHdlIGVp
dGhlciBjYW4gaGF2ZSBvciBkcm9wIHdoZW4gYXBwbHlpbmcsIHNvIEknbGwgbGVhdmUgdG8geW91
Lg0KPiA+IA0KPiA+IEFsc28gZmVlbCBmcmVlIHRvIGxldCBtZSBrbm93IGlmIEkgY2FuIGhlbHAg
eW91IG9uIGFueXRoaW5nIHRvIG9mZmxvYWQgcGFydCBvZg0KPiA+IHlvdXIgbG9hZD8gOi0pDQo+
IA0KPiBUaGlzIGxvb2tzIGdvb2QsIHRoYW5rcyENCj4gDQo+IEFja2VkLWJ5OiBQZXRlciBaaWps
c3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCg0KVGhhbmtzIQ0K
