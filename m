Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE86813259
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573325AbjLNOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjLNOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:00:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4119A3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702562428; x=1734098428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ihCz/mvBGxyurRz7wxzyrMKbBZKRVYEHXsDVzDOr/eI=;
  b=IyfG7RfBrcdGCv5DbFx9WT+p3PFhLs+EZLn7hXX5IUuRFdaNq0zZWqz5
   lgYJfNh9KKBFxYZ+CPu/gsGp/IYWBhatOuaf3F3v7v572ZAnYZ7jP0svV
   1bRcqAQ4q6rB6DQLZJpPazdPyB7PPjj/EWIYsLxL6/i5kfarQQiu4Wr2y
   y81oSFbpEHVUoImrw3alGEAaMzMz+zxeSaP4EtO6b5u3BsMu8cmYlFSKP
   NkVr1iPTb6f64LMsXGv4ri4KoFymFvyW3CDsGpUljimVmpn/2Q/7evkrM
   5lZjfDeYfllD9bEdvGhoufirCOup2L3ykmeScEVm7yqQqpZrh+aud0+f+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2288538"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2288538"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750536607"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="750536607"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 06:00:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 06:00:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 06:00:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 06:00:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYBSYrCgABV05aJMte6PRFWMP1gRfr7bdbb0SxM/g5mXJ/L9kByEVOm1StRL9xioY5mMmNOjGUiCtgSzn67//K3Y0yXFhkdzSAEKm6heUGZI0xTB4PLiAxLopdOakwjWKBAbFZhKtQbh5yUZxuK7Rx5NfsLvVnpHeIsHVv1hlycFySZtT3azDaH5yIQiFA7MzUZekhKFSjdTTWbqse+y5FaYNGEAhZH5WSJU0tf12M/8O09kDnKtqlhhgv9dnrSXOrl3imlZ4X7Eeo65uZci546XdzKizkPYOcLvR0vi2TlBxkVhiHU21eqa1HTheXRhGo8wgOvkyJVXudN8P4nruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihCz/mvBGxyurRz7wxzyrMKbBZKRVYEHXsDVzDOr/eI=;
 b=fVanyTPC754bSGT+ZQukqQyxpcFUxWwhejlWXnI7u1ik4KaJOm6Nts2HzXTVL/P5XqOUTmLLm4094PAfnNjNlpdBn0d2HYvg7UixVfGU0ZTlhvOWvhPoS2MfFC6iadOpWNnKYsJTPDWXkJbcdpsReBwNP6LyoNZ9DFx/v9f0N7TJht8KBxjs5/g1SIfHPcBgCu8t0XaLVXy18UBt48l0zosLA5UphjY6MijP1C14MTkNQnbMLJ7UiT3OkyJoJlQem89Oa9qNwii+ZXazO3cUpRW2Q4DFcgiHcCWecinHAm04uAAvh0V0YnRkc+2QbdQr/31wcvr+feRaYQhXPHZOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 14:00:23 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 14:00:23 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [patch 53/53] x86/cpu/topology: Get rid of cpuinfo::x86_max_cores
Thread-Topic: [patch 53/53] x86/cpu/topology: Get rid of
 cpuinfo::x86_max_cores
Thread-Index: AQHaLpXfQxDpAFZd+EePyA0yH6z91Q==
Date:   Thu, 14 Dec 2023 14:00:23 +0000
Message-ID: <c381f0467befebab2fc85e6902ace747da67ada8.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
         <20230807135029.218547661@linutronix.de>
In-Reply-To: <20230807135029.218547661@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS7PR11MB6296:EE_
x-ms-office365-filtering-correlation-id: 9b3d4732-d65d-46d8-910f-08dbfcad0411
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDwklkgxX382uoIju4Q6j54BLGYHErMUMaFFHUfdYYKazZpyMo7LSUaLJV0c0Xglv4NXDNCFrimvQt9nxQGN5JidIc4IQOxADSgsJH0uLqGPIsoezB+tdyyNltFpCJkWkkBOWA8+YW9Uh5WtMUZUi/CFKG4ALVTCncWkVQC6N09VWGnOdxAqEg5KwcJxtQ5ckFcfhZZXbUnWdyCygDyMKqC83DQHm5Ga2JtWgRG7gzK2G95x2uftY5u61W59zb3Xy49ptZKrMx9WooayVhs33C2LOCNuQoA8U6mYVLC+x5GbMcj4eZi6tpdj0+R7FJFzYc2QqveI0mL6TYZofLfZWFprOm7MqAUV1liEeQJDbG2cR0l+xxxqFPBE2oizWBeU19INdTPymwWoydwnpEqiYOpgPv/Q7XyJnj0E6/tRFv5znEOgROsUJxxo6BGicLYO4I6L/3IWOCEaOQtG8Zc7wRUrU7KKy6IhAeMgW+8Gvtir+FzT4YA4dRKQulvRuLmhmqSA0FkVuvXo3znj2t4r1CjoxFTG6AhRn0zUkHDs/OY2YJwRsgyQxcVBu9pWP0Z/8Rftu9xFetHRORr0C5UaRtIjTwMbsEz7WTbHFqWPtHXRkV7+6b213LuzFrHiaPlzl6KhPpXsa5XlsIDCfpk9Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(7416002)(122000001)(2906002)(38100700002)(38070700009)(36756003)(41300700001)(86362001)(8676002)(2616005)(8936002)(4326008)(6512007)(71200400001)(6486002)(478600001)(83380400001)(54906003)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(316002)(110136005)(91956017)(5660300002)(6506007)(26005)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzc3TytmTE9oZllaZHB0cVVvMGVCakJCUi96MFpaVklUTEU3OEdRVjR4RWJY?=
 =?utf-8?B?aHBZeDZRNWF0UWliSXVJVFRXQjUzWnlHZzJDSHByZjBsaElOZFBUYWpSRnpI?=
 =?utf-8?B?NWZwd2h0YnpuRW5sS0RDTXAvVWljT3dtSlJHVmFaeFdhUlExNTkrNkhiNzVm?=
 =?utf-8?B?UjlwQ081c2g2cjhuZk1KWlNGTFZYcWQzeDFGd1R6S3lmaVdTSUswSkVPUDh5?=
 =?utf-8?B?OER6RWtiemNLVjA5M3U0Um1oRXVaV0l5ZXYvR3VnQ2thRjR3OXY3Ni8wR3Av?=
 =?utf-8?B?Mk5aeGFnZkVyRjRmWHNOR2txVW1rUitCbDJVZlp0UkkxZUtYZ3ZIMWs0VzdL?=
 =?utf-8?B?ODJTbmJDRFVRYjdzbUlkdlBhMFhTamdiK001K3d3UHJlYnk2ZlBGMVhLdnBS?=
 =?utf-8?B?Ym5na1FrOFhmZTF0djN3NHVFRllEZHpNYlNLcnFqczh1N2w3NW1nWVNaNGtm?=
 =?utf-8?B?cTQ2TXhKNjgvVkw2QVB2eFprS2ZaVlBSdWZRNWwrUzhUdis2eDVJNFJZQ3NB?=
 =?utf-8?B?U3F4WmdCTGhKR1ZlSDVKeWczQ1dUOTBLZHdMTzc2QmpDWE41czZYaERYc3RH?=
 =?utf-8?B?c0J3UWNORGo1UTNkT2c2ZGlQb2N5ZVR6dHVnRUhtTVN0SkE0Vk8vb3lSOTkr?=
 =?utf-8?B?Ui8vWjlUWkRrVjBRZ0MzYlJUdk4yS00yckRIVzJkcW96TkZyK3pydy81TUNZ?=
 =?utf-8?B?THBVcUJZYmxNTFV2SlpVemdvbTZUSWtvRHB5aVNKeXNUWlIrdTZkS0tSMkM3?=
 =?utf-8?B?Y0hpbExQS2xmQkxmbUhFNXVBdDh0QWkzSDV3N3Vyc2JNWkZMc2t5N1ZHZ0lQ?=
 =?utf-8?B?aXZocFVaY3dSTWxuMFEzVFpaZEJvbjZkdUdDS0ZtMTg0QUREdytQRkxZTXNR?=
 =?utf-8?B?akJIN2RCM3ROL2RPcWhBb2htSFdmY1Qya1E2eFRTbkpFTm9samdsNWVqZEVM?=
 =?utf-8?B?cGlBZE5pd1RqWk9zeFRzeVZtbysybjZ5OG5oS1lTaVlocm9iKzgySW9oUkR5?=
 =?utf-8?B?M2JPaC9FRW5uVnlpanNHK3dkbXR3ZWx6SE13a042NFMyaXF5OWMxNjBxNkVN?=
 =?utf-8?B?TythZnd4TVVmakhpYnRaekZyQkJLalhyQm92MXJJUUJzYWhxNzRWZEExU3lI?=
 =?utf-8?B?VDJFVFhuOXd5QmZ6NURDdGl3eEpVTVlVT0V1NGZXYWd5bDVSNUh5ajJuWnl0?=
 =?utf-8?B?ODM0Y2dhN0tqWkxsVGNDbm1LVVlDU3hGTHBPQ1ZXNExIY1Z1TWhGSndIeWpt?=
 =?utf-8?B?WWFoRkF0QkFNZmVxcDRFdnBFQjdHL0E4Z3lEdkdWcmUxRXFnN1ZJOWtqSU5U?=
 =?utf-8?B?NUFVeVlKSyt5SkpRUjFLVDJPRXdVYVN6UG05dlNHby8zcFUwOUVTSDdST0dX?=
 =?utf-8?B?dU5kMDJiQ08rOVdBUTduYXdwZHVlZ3FZTmZCUXBSd0FyalJ3dEV0UEZwbUtI?=
 =?utf-8?B?VkQ5cDQ0M2E2Ui9qY254NW1WV3liWThvbUpkakdsOEdJTFluK1BzdndjK3lQ?=
 =?utf-8?B?NnoxRFdSWVBEaXlTKytwaEtYUnZJOStoTmZYT1FzcGZrL3NNUDlrcllXS0ts?=
 =?utf-8?B?c1pEM0dndXFYSElwak92MTkvbW1nVVQxZ2M3aVR5Zm9Kc3kwMGx1cVRNZ2Jt?=
 =?utf-8?B?aXVXL3dBRGFOanRtSC9YT0gwVUVvclRmZEsrUkNZMmtHMHdVOVlwbEpSam92?=
 =?utf-8?B?ajY0Qm1yczZ2U0laOFZkWTNpSnR5WWNubzVWT2t5WDZGUzljSkhrZ1IzcGpu?=
 =?utf-8?B?cit3WVM0V3B1VFRxeVhFSFVYNitIZU5EbDk0WUZMWjdzay93Qm9oVGtVMVhp?=
 =?utf-8?B?WG0vcHBWWHYydGFSSXR4dzVVVDVOVFMzTG50VFRLdkVGamtCTGRWMTlMaDJY?=
 =?utf-8?B?VUIwaTNvMElaWG9pQStaLzhjTVhPTjVxOUxROTVmWWJ6VnlFTXR6TkN3S2dN?=
 =?utf-8?B?Zmk2dmZKeWE5M2YxeXkvcjVyNllEQzVBTEo0bmRpeGQ3ZkMzV0FoS05hMW1X?=
 =?utf-8?B?MkZvVjlLbm5hQzVKdGZwZEtQQUgwTDNSOUlVbDI3NEcrTTdCeGllTjdrcnVG?=
 =?utf-8?B?Z3ZHdlg0bG5DUDBOTSsyMjRWa216S3JVOTE0bHJycjArcDVpc244cmJLcktR?=
 =?utf-8?Q?AL163u/WJccmFqlBS4CWyfOer?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86586221ABFC184891A5C1AAB94C7DD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3d4732-d65d-46d8-910f-08dbfcad0411
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 14:00:23.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58F4tFf/SBqoj9rt57hx31eHXassf1ecka4XOtyAWuxog4R83iA7QLX+Q7gCZBZEgX/DVfLShZXCSRbQ3j1vKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMNCj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL3NtcGJvb3QuYw0KPiBAQCAtNTY2LDcgKzU2Niw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBi
dWlsZF9zY2hlZF90b3BvbG9neSgNCj4gwqB2b2lkIHNldF9jcHVfc2libGluZ19tYXAoaW50IGNw
dSkNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBib29sIGhhc19zbXQgPSB0b3BvbG9neV9zbXRf
c3VwcG9ydGVkKCk7DQo+IC3CoMKgwqDCoMKgwqDCoGJvb2wgaGFzX21wID0gaGFzX3NtdCB8fCBi
b290X2NwdV9kYXRhLng4Nl9tYXhfY29yZXMgPiAxOw0KPiArwqDCoMKgwqDCoMKgwqBib29sIGhh
c19tcCA9IGhhc19zbXQgfHwgdG9wb2xvZ3lfbnVtX2NvcmVzX3Blcl9wYWNrYWdlKCkgPg0KPiAx
Ow0KDQpUaGlzIHBhdGNoIHNlcmllcywgZXNwZWNpYWxseSB0aGUgY2hhbmdlIGhlcmUsIGluZGVl
ZCBmaXhlcyBhIGJ1Zw0Kb2JzZXJ2ZWQgb24gYSBwbGF0Zm9ybSB3aXRoIGJlbG93IGNwdWlkLjFm
IG91dHB1dCwNCg0KIyB0YXNrc2V0IC1jIDAgY3B1aWQgLTEgLWwgMHgxZiAtcyAwDQpDUFU6DQog
ICBWMiBleHRlbmRlZCB0b3BvbG9neSAoMHgxZik6DQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNh
bCBwcm9jZXNzb3IgPSAweDAgKDApDQogICAgICAtLS0gbGV2ZWwgMCAtLS0NCiAgICAgIGxldmVs
IG51bWJlciAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDAgKDApDQogICAgICBsZXZlbCB0
eXBlICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gdGhyZWFkICgxKQ0KICAgICAgYml0IHdp
ZHRoIG9mIGxldmVsICYgcHJldmlvdXMgbGV2ZWxzICA9IDB4MSAoMSkNCiAgICAgIG51bWJlciBv
ZiBsb2dpY2FsIHByb2Nlc3NvcnMgYXQgbGV2ZWwgPSAweDEgKDEpDQojIHRhc2tzZXQgLWMgMCBj
cHVpZCAtMSAtbCAweDFmIC1zIDENCkNQVToNCiAgICAgIC0tLSBsZXZlbCAxIC0tLQ0KICAgICAg
bGV2ZWwgbnVtYmVyICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MSAoMSkNCiAgICAgIGxl
dmVsIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSBjb3JlICgyKQ0KICAgICAgYml0
IHdpZHRoIG9mIGxldmVsICYgcHJldmlvdXMgbGV2ZWxzICA9IDB4MyAoMykNCiAgICAgIG51bWJl
ciBvZiBsb2dpY2FsIHByb2Nlc3NvcnMgYXQgbGV2ZWwgPSAweDEgKDEpDQojIHRhc2tzZXQgLWMg
MCBjcHVpZCAtMSAtbCAweDFmIC1zIDINCkNQVToNCiAgICAgIC0tLSBsZXZlbCAyIC0tLQ0KICAg
ICAgbGV2ZWwgbnVtYmVyICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MiAoMikNCiAgICAg
IGxldmVsIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSBtb2R1bGUgKDMpDQogICAg
ICBiaXQgd2lkdGggb2YgbGV2ZWwgJiBwcmV2aW91cyBsZXZlbHMgID0gMHg3ICg3KQ0KICAgICAg
bnVtYmVyIG9mIGxvZ2ljYWwgcHJvY2Vzc29ycyBhdCBsZXZlbCA9IDB4MTggKDI0KQ0KDQpUaGUg
YnVnIGlzIHRoYXQswqBvbiB0aGlzIHBsYXRmb3JtLCB3aXRob3V0IHRoaXMgcGF0Y2ggc2VyaWVz
LA0KMS4gaGFzX3NtdCBpcyBmYWxzZSBiZWNhdXNlIHRoZXJlIGlzIGluZGVlZCBubyBIVA0KMi4g
aGFzX21wIGlzIGZhbHNlIGJlY2F1c2UNCgkxLiBjb3JlX2xldmVsX3NpYmxpbmdzIGZyb20gQ1BV
SUQuMUYgQ29yZSBsZXZlbCBFQlggaXMgMQ0KCTIuIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBwYXJz
ZSBNb2R1bGUgdHlwZSBhbmQgdXNlDQpjb3JlX2xldmVsX3NpYmxpbmdzIGFzIHRoZSBudW1iZXJf
b2ZfY3B1c19pbl9hX3BhY2thZ2UsIHNvDQoJYm9vdF9jcHVfZGF0YS54ODZfbWF4X2NvcmVzID0N
CgkJY29yZV9sZXZlbF9zaWJsaW5ncyAvIHNtcF9udW1fc2libGluZ3MgPSAxDQoNCkFzIGEgcmVz
dWx0LCBzZXRfY3B1X3NpYmxpbmdfbWFwKCkgYXNzdW1lcyB0aGlzIGlzIGEgVVAgc3lzdGVtIGFu
ZCBkb2VzDQpub3QgdXBkYXRlIGFueSBzaWJsaW5nIG1hcHMsIHRoZSB0b3BvbG9neSBpcyB0b3Rh
bGx5IGJyb2tlbiB0aGVuLg0KDQp0aGFua3MsDQpydWkNCg==
