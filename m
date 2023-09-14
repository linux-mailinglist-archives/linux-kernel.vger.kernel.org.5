Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666579F8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjINDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjINDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:21:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DB1BD9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694661698; x=1726197698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JnS/Yl9e6Hp0ykYvLtQmXRNh7rR7nNn/ECD1rgH0F3s=;
  b=MQq8aOg6XWeMCa6NFF57BUwbKvi0PgjqrLGoCEDVIvxUoDYS4OTjp7V7
   eg/VYsR/ThRN/dDX4RctA/ONO2c6o+s3GTHA25NjzPqInaUZyqABrL0ZQ
   fqlt9yzooId975d9TV3IifgrZ6FT1mmXEAf6PatC5tnejI7nTX/yIWn+5
   iSfshpLv33g3/WK/s6LE+WkICmgEpy5zCd6G/iI+RJ2XSys/epjXZpShg
   eQ5D0JhHZm2g6XFPc5ISz+jzwdc9B85VlGhkI+cVBhhI4F8d5VDhlCD3R
   V+qgC9bXDqZsg5du9vLXmxNorPTwvC5KOAiHZxwhuaD6gB8CAPaMcOGuq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465213731"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="465213731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 20:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="918093004"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="918093004"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 20:21:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 20:21:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 20:21:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 20:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyAiCgTWCMnM0Ivtv7Mgs/Fqqelpgur8D5zDHHON4+MdRrVO6HgnbntZCOXfKc/5US7J3EZziyRuLLScYPxHsZFxkwj+xMvyvv3prqt4b3X0UGQFedFKUwuIP3RiwVHsetp7qgzojRnjIX6ZHKaPOZTNSZXG+SEkajC1wtbHPu0tw4wqdTdKuvkJvsrNJbVYF7bJU8wLsjfAVVoJpDRCQ+6SXC3ENMn6XeHezIsVVtjnkmQC3xk7EpJOk9rstT0Y/HsFSmxUhQFELo8GbAW42Qfgi1V4d0htH/NX+NeZK+tzYPvjcGL7gBIfVDpyxQO24kql3VJH/ealIx70Zigv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnS/Yl9e6Hp0ykYvLtQmXRNh7rR7nNn/ECD1rgH0F3s=;
 b=SFzk5a9YBt0ftzj23zbR58Xk8gfmtBClXELVPgVD6SX28QkvJoy0tW5H2PHo0z9Z0RazZyOvCltBP61Ed0GxpIAS0VmPaVsd1+ImAWUjKGi0rHayAjFCn62/9Kk0ru3ayTbthKeTuy8rbTNMAhpYRo9LT+wVC49gKvZxmGWW1J5OTvSrsSZN/dJy+6fZLopwrlwuMX4jsGkRkyiLy5zOAwG9vWa1RNPF1QxLyWRPWT0urVVM7C/JCR4Ybo9hCalsdMDrr556TZlH9ifv35MIgnzgzAVi5cxicKE/91cNGoAdObOu9rcNnkhoac8kTRkIAytVJ8J0YxA37FOh6kLchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 03:21:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 03:21:30 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     lkp <lkp@intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Topic: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Index: AQHZ5qem7IU2VPrp+E+UjIKvurp2uLAZhucAgAAgzIA=
Date:   Thu, 14 Sep 2023 03:21:29 +0000
Message-ID: <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
         <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
In-Reply-To: <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB8152:EE_
x-ms-office365-filtering-correlation-id: 278d9cd9-25bf-4a2d-491e-08dbb4d1b02e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udxAYI7xv/u26logl2Vq1sp9A0D5SzsGEcM7vceggXoSvmTUAGPHabgqMJcx4Yu/qXtgcHqW2vF4Nder7mTUVOW3C3PYl+95yrYtOGw8HukI1Nn2tVI5yxzmvSRTddXnH4KK/RvqL9ICoWjkg9NF0eSbZzMaLTo+GzZDmNmRZld1kYtO6cwquorLp4JqpHMwmaaMEgU5qjhcibFPi0NCIIriDzUXuEk2XTllJ5+elqBkC2KCK9alg7gvJD4V7SsLopbOItoLVZh3NNcoHXJl0gNTc2AqYipY50vFmUpGb28gcf+9aHKpUn47lQoU5nFn+dCZBHffy2d4Kg3tKYXf9ZDtJl8A1CeDWiV+3+MxmruHV6PLAOFMqjH0xkUEiWY1Lw/QU5ZINqooHi261u50wgNxaCbmzEv//0zZ/BBjY2nZBC5+uGuFCHBHV6YPJDM/7p/WriAElqmDjHgsF4IjchHDwRoIuH0+Vs3jFqtn/D2UBmYlzrd312qwWhdY9LFRLrevIgaHNx0RW/U6yuc/52qYWmCTxBNN/+hXYV9wmVaAVF+LVGXKlnQUyllNB9Sfj6a3yL0tNalCLa54+jMhyIRGxznZ4w8nWCImFGordQs2o9Ucw4sFNzunAMTK5javjUCIeYVEP+lheRDlqaLibw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(26005)(2616005)(5660300002)(76116006)(66476007)(316002)(6512007)(54906003)(91956017)(66556008)(37006003)(64756008)(66446008)(6636002)(6506007)(66946007)(38100700002)(4326008)(8936002)(8676002)(6862004)(83380400001)(122000001)(71200400001)(41300700001)(38070700005)(6486002)(478600001)(966005)(2906002)(86362001)(36756003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmdPaEdzT0pLTExkSEcxcFAxM0t4eW45azNnYmFYUHdiSE5jcHdpMTd0NU1Z?=
 =?utf-8?B?SElvNlNtaWJiV1RYR2ljajN3Q1RXdmFiWGkvVlNqOUxsOFVhZE1NaEoyQXB0?=
 =?utf-8?B?bXdjaUNURmZvSkNTQXo4Uit6N2tjYWZXNERlLy80YmJLSW14dS9TZHRtVUpp?=
 =?utf-8?B?SEhISU1GQlRkUjdPMFo3dmdnb1ZkZmpZNlJ0UTYyVjBxb0NmT3YxOHhHS3Jo?=
 =?utf-8?B?dlFLcnRwTTdJQ2ZYSk1rZWFZU2ZtZHBNbHhIb01teXd0YmVJKzBLUGFhazVP?=
 =?utf-8?B?TjFjYi9TUG9vSFlaQ2VrVWJzWWhGYkxyMEdia1hWa1UyQUdsNitWUURxQlpk?=
 =?utf-8?B?NExOV2w3NG9HLytCc1VTS1k4eDdpNzVBR2xjV2NIUjYwY3pGWEdySFp5YlA5?=
 =?utf-8?B?OGRiT1NiZ2krRGxhMVBUbWpqR2J0L0hqYVZWYzdQNm9JNEM4ek0rODRyQ2Uz?=
 =?utf-8?B?MFBmV2x4NDZKTXZYcjJuQy84eWIwTHhYU1ZWdzM3Y2R6WGVmUlBPNUFvVTFS?=
 =?utf-8?B?eUE4STY3amdXTkhZVHFVZ0p2Y1o1NEtFSFUxQTBQUURCSlRDWk5vUzE0TS80?=
 =?utf-8?B?amRtTWlVekMxbllyRmVJOThaRzFxaGluM2VJNjVFU01iVkVoVE94SFBnY1RL?=
 =?utf-8?B?WVVndjA3UTI2Wk1MdzdPcmY0WEh4WU5qWDdLQWNJb3ZwT2l3QXJMRHZ2VE4w?=
 =?utf-8?B?ajZhaHIrVjBISXFZanJ1eFR0dFIvVTVNVllrNVJxUFRWU0xOcVVMUEh2MFFM?=
 =?utf-8?B?ZVU3NTZKQ05PaTlBT1hSWG9xTUE2ODVQeVJTbEpHeFhiTlAxS1NxNEVqSDdv?=
 =?utf-8?B?QmpTWXE4ekNJcFo0Z2FHR3BKcHFYcWJaQ0ttK1lmNlVrSm9ONElKZldwcmNh?=
 =?utf-8?B?d2FTb3pxeVg4VzdHNnQ5RzBTWlNMYm51TE5DQTBRUFJYdVFOamQydFY1dFZx?=
 =?utf-8?B?RG1mQ0lCcDNUM051RGozWVVBTWhJdXJ4b3FGbDlWM1I1dThZUFI0bkVHL0E1?=
 =?utf-8?B?RXlGV292VVd5QXdtUmVyNUp1UlpFVHUrN2gvT0dQVG45d3ltZ2xRMlFkdEln?=
 =?utf-8?B?emhKaFZTa1dHRlEzWnNHVzlBV3FhVytPU1BVVStaZGxkT0FDYXhEZVBtcTFm?=
 =?utf-8?B?aHJDWStQNVcvaFJZTm9IUFFDeS93bXNyeXhncndDQWFYOXJ1Yng2YWVUcmRD?=
 =?utf-8?B?QUFodmtacCs4MG4wY3V3TFN4YUVmeVlBTVNLWUEzalU3VTUrVU1FTUVrYVZM?=
 =?utf-8?B?djNGc2pac0NQaGJTdXNLNFk2Vjg4c0pnSzR2ZlhqUVNmMzRyRjF6Yko4YW1z?=
 =?utf-8?B?NjE1VkpweGp3Z1FIWXU1ZmdHZys3c1ZIRmhkT09KYXU4Zm94U0hWWUdieDhX?=
 =?utf-8?B?UkpwSnp5b0pmd202ckloS0h5QTM2NklRRGpjK0dhQzFsbWVrNzR4UnB5M0Zn?=
 =?utf-8?B?N3dic3I2ZmV0UGhHbnNDeWNmTVo2Z0hXY1hiOFdSM1JkRWxxNWs5bTN3TkFQ?=
 =?utf-8?B?V3RmVU5hYVNPNkhlTWpaVThHZGZjYzNoSDRadmwxc1dWd2UrdFQ4NkJoS1Qz?=
 =?utf-8?B?Q0J3cVlweS9wbFY2cnp2OEtzQWl2L044aWFkcFdwbmtyK2w0azh1bjRlNmZT?=
 =?utf-8?B?cHprSzJkWlk2cFdGNWVCS2ZYNFZoRVd6eGtsZUhJaTFRVXdFRkdhL3FtaFNJ?=
 =?utf-8?B?dUQrMjlhbzRra096TXY2UHYzTVYrbmlHcE9iTzF6OTkzdVZpOURLWkI0ZnBj?=
 =?utf-8?B?QndTRDFZQ2hGdjNWS0p6aGJzU2ZGMmpTdzVvQ1FFN2hLeFovWE9oakNReVZC?=
 =?utf-8?B?VElPTThib0tXcEF4WWY2eGRqWVhqakRnNGtrVDZTVVJIRkJFcWFaMW1pblh6?=
 =?utf-8?B?UXdXZWlyRm85ZTZHT1VXeW1YdkRSUWhZaHRJcVdSc0NvUmM1Y1c2ZFFMVWpC?=
 =?utf-8?B?L3NSYXR0VWZXUnVyTFBZL1lidFcwTHhRT29WSkl6UGtsR0lhVjN0R0JLNENj?=
 =?utf-8?B?Zi9CcUViaGpmT3ZEcVFqRjBGMXJyYmNVSFdqNUhuZUxzL0RFMnpWVXpIYmk5?=
 =?utf-8?B?OG1NOW80RGpacFhWa0NYRks0dERmajJvTGJTYjZaRE5QVzc3a1lwNnB5WGZw?=
 =?utf-8?B?OEdhN1pXODJmSlBTenpZRFNsa2FpZjNnRWdXdUZYUS8rWW5yNXNqRkI2UDFT?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <080088FAAD9069499E44BFDF5A439C19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278d9cd9-25bf-4a2d-491e-08dbb4d1b02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 03:21:29.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8azhwhDLbTEdsVi9vHbs13s3IacIR3ktk2LcftfdDyjkmDxHNYTkSN0N6pAHni8zbkSnFEmoNoNFS9B2Lygb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDAxOjIzICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjMtMDktMTQgYXQgMDk6MDUgKzA4MDAsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3Rl
Og0KPiA+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdGlwL3RpcC5naXQgeDg2L3RkeA0KPiA+IGhlYWQ6ICAgN2I4MDQxMzVkNGQxZjBhMmI5
ZGRhNjljNjMwM2QzZjJkY2JlOWQzNw0KPiA+IGNvbW1pdDogYzY0MWNmYjVjMTU3YjZjMzA2MmE4
MjRmZDhiYTE5MGJmMDZmYjk1MiBbOC8xMl0geDg2L3RkeDogTWFrZSBURFhfSFlQRVJDQUxMIGFz
bSBzaW1pbGFyIHRvIFREWF9NT0RVTEVfQ0FMTA0KPiA+IGNvbmZpZzogeDg2XzY0LXJoZWwtOC4z
LWJwZiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwOTE0LzIw
MjMwOTE0MDgyOC45UmRtbEgyWi1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4gPiBjb21waWxlcjog
Z2NjLTEyIChEZWJpYW4gMTIuMi4wLTE0KSAxMi4yLjANCj4gPiByZXByb2R1Y2UgKHRoaXMgaXMg
YSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIw
MjMwOTE0LzIwMjMwOTE0MDgyOC45UmRtbEgyWi1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4g
PiANCj4gPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAo
aS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mDQo+ID4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0
KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncw0KPiA+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+ID4gQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwOTE0MDgyOC45UmRtbEgyWi1sa3BAaW50ZWwuY29t
Lw0KPiA+IA0KPiA+IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+
IA0KPiA+ID4gPiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IF9fdGR4X2h5cGVyY2FsbCsw
eDEyODogX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCgpIGlzIG1pc3NpbmcgYSBfX25vcmV0dXJuIGFu
bm90YXRpb24NCj4gPiANCj4gDQo+IEhtbS4uIFRoZSBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKCkg
aXMgYWxyZWFkeSBhbm5vdGF0ZWQgd2l0aCBfX25vcmV0dXJuIChJDQo+IGV4cGxpY2l0bHkgYWRk
ZWQgaXQgdG8gc2lsZW50IHN1Y2ggd2FybmluZyk6DQo+IA0KPiAvKiBDYWxsZWQgZnJvbSBfX3Rk
eF9oeXBlcmNhbGwoKSBmb3IgdW5yZWNvdmVyYWJsZSBmYWlsdXJlICovDQo+IG5vaW5zdHIgdm9p
ZCBfX25vcmV0dXJuIF9fdGR4X2h5cGVyY2FsbF9mYWlsZWQodm9pZCkNCj4gew0KPiAgICAgICAg
IGluc3RydW1lbnRhdGlvbl9iZWdpbigpOw0KPiAgICAgICAgIHBhbmljKCJURFZNQ0FMTCBmYWls
ZWQuIFREWCBtb2R1bGUgYnVnPyIpOw0KPiB9DQo+IA0KPiBOb3Qgc3VyZSB3aHkgdGhlIG9ianRv
b2wgaXMgc3RpbGwgY29tcGxhaW5pbmcgdGhpcz8NCj4gDQoNCkl0IGFwcGVhcnMgdGhlIF9fbm9y
ZXR1cm4gbXVzdCBiZSBhbm5vdGF0ZWQgdG8gdGhlIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGJ1dCBu
b3QNCnRoZSBmdW5jdGlvbiBib2R5LiAgSSdsbCBzZW5kIG91dCB0aGUgZml4IGFzIHNvb24gYXMg
SSBjb25maXJtIHRoZSBmaXggd2l0aCBMS1AuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UuDQo+IA0K
