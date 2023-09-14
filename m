Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE97B79FFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjINJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjINJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:18:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34411BF2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694683132; x=1726219132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Plu6HNyqIjziAZJbERsP2Vt6ex0fnbrqYnuK5YLa4os=;
  b=fd6dYm5Dx6HFQpfMx0HQ7kJaizJ2OEogOtxUwuaObTt9Oa3wB0TM7LWj
   /Ka67RPo7RS4OQKs00VmDvc91FBdzPCArV+0l6XXpy59kpOcgPM2glWVq
   8O/DgcrMBbSnwjmb60QtBLgBvf2NNtKqzCn8JJ5vobCbAAkuJPegS/LZz
   ueCl2MWhZlIWY0qSHJZuJq4cqRrkOmno3N3za60tANo4R7+Sq+QHaoDQf
   +sSnvw6VF54gmgJnWEq8i+Ryqi7w0TDzLCNjOtrZnio2yFDyK6bhvCRqE
   md89HCI2eSWef6gDppAo+MUzHkPk8IWrr1gWx0bssDm2tfaOraG6qJwbs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465271288"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="465271288"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="809989328"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="809989328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 02:18:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 02:18:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 02:18:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 02:18:51 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 02:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n15PSybI0O5i9+sIjeGPAFiBJxi8sRCWHubELvwXwvIMmDnA6/HLbGM3AGUt9bIOtX9C3ckv/OqDE5eXgfdwxbZSziyO1rVauYeftufxE87XehNMr0k4b4AhTM8uewebKCuQcrCSR4zVfuOoJRxgClpGWCdynCl8nryfrh7QT7TIbtBgiEzDqLEKeazfloXa2ZfsguDrvPE1VBMZNlExZqV8gNYDdJaayRmWh3lh68AKCN6KyuXa8nSEXkz1QaCrUFJ7M8r+QJ8/oFwMURB8K0IVe/AHwV7H5nXaKWHxDJtCqPMgF4JtuEJKxVYf3b25Y9POGjn9qgVFoxOBUAv5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plu6HNyqIjziAZJbERsP2Vt6ex0fnbrqYnuK5YLa4os=;
 b=YCxsbrcCbNXSxSo0v6IaUvmDz9QhcXWSUPZSpSUW5czQiL3LFK5XUNSVHRL7ttOKC+AT+Ez3qF3Ns4xx6CSMlcwsd280H7a7RuBMvYhEVqyzpQrcMS2bJzqeCI+5H2xloZBq9C55OXenP7hawRqzh3Xz1LBHdRNPJh0tgAilGXz4hb1laMturSL9CJQ3A6gCWHoqfEY/2oI7ZwoHg8W4oy5MRSwtBJfob/ajZDuSzWmaH0sI2CFFHNknB7QDUmceVi21Tu0Gz+aggo31evRC/0PtiAea+1On6gGnNJGBD56fLSB3U7+s0yoNfoTQCA1iJkISH5r5Oh9DEvPCG2Pgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 09:18:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 09:18:45 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Topic: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Index: AQHZ5qem7IU2VPrp+E+UjIKvurp2uLAZhucAgAAgzICAAEWGgIAABr8AgAASL4CAAAVyAA==
Date:   Thu, 14 Sep 2023 09:18:44 +0000
Message-ID: <cd1331511723e283c7238078bc12c71a739d4dda.camel@intel.com>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
         <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
         <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
         <20230914072959.GC16631@noisy.programming.kicks-ass.net>
         <9eb77be3a64c25b3264d5011a93242d006b88627.camel@intel.com>
         <20230914085913.GD16631@noisy.programming.kicks-ass.net>
In-Reply-To: <20230914085913.GD16631@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB8226:EE_
x-ms-office365-filtering-correlation-id: 58b03154-0d1b-4e74-c83d-08dbb5039872
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCnOakYrw9j/kiEBNhF/a/h9H/DfzN1tqrSNNk2I5xh45gAQMMXPtkm5h5GfyrNbe+tLveYCnE65GlZ8i6TRj/5GZOuGgqxCYaapdO/5cm/G0lpw3nPqyn3lHIIStnG/CTxlxmwPrtI0ybk3gt9LbNtuaiMmJ+23Mt2w4orJSne4jIxA/j5qM1If+Q/WjjNURwhZz2wJcc/FEKaJuwXrbE1BWfZre8sBHrsX2wQqCAOcm9+3qYJaqbXe21xNAJi2O23boCSTOQuLex6xsjW+g5AulsJ4V03A5UJDZn8IdU/5aZex5NnAjvfmetCpF0ua8+W8ti5rlsYtICvlPpRDxjGZcXkMWt8ZQxPjIH+PShn7WdXmIiAfK2SSZFRT0WPq0ajhTRTG4Caz0zRcx7zpQgKBh6dOIaI0BohF5JmmRYO5GPZfMDaovmNW6jKoONJl4luYEMeSDuB5C3Y2E/vwCpT4YcFwgI07XnwhpuKG8fwyFWjiK1nLZxamT+xeVGea+NAUTb53augBmDsV43mctNCy2mQqq7Z87JxXFXpSBr9IHbuRE2t2w+XOgX/UYLSQOH2koH6cZD6R9UuO+OUPhQ/JeMHdS3eJ2m1AOWNOJKpsrNPpw/aKBgvYLfCxLr1z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(66446008)(64756008)(54906003)(91956017)(71200400001)(66556008)(66946007)(76116006)(66476007)(6486002)(6506007)(41300700001)(6512007)(6916009)(316002)(478600001)(8676002)(2616005)(4326008)(8936002)(26005)(5660300002)(36756003)(38070700005)(38100700002)(122000001)(82960400001)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDFvdWE0aFEvak8wREIzQnYyT3ZPVm01QzlXTXNiRTBvRjdJN0V2RnozbHZp?=
 =?utf-8?B?aVVPNW5PWUVmbjljeXdIOGFnR2QvU2NVc3ZHaTQ1THhsaEk4dGFSWUJ0K3hE?=
 =?utf-8?B?TUlKNnZkMFNHcWJMRjJsNkliVnRvVU1QalNneG5jMmxYVlQ0WGlJSFBCd2Y3?=
 =?utf-8?B?czE2cG54Sm5vVHQxQVU0dldtRmt5KzBwcTlPOGFqL0pjbmlpd3hhaTU0Q3Ix?=
 =?utf-8?B?MitnZTV6WUNJM2Y4TG0yM2JEM2lsT1dPVTRFc2JJTWFrWWxzNWJOMVJKa2t0?=
 =?utf-8?B?YkM4TEVBWFR6TTRkT2lEQ1hRbEIyOWQzTjl5OTJzWUF3V04wVm1RbWVnYnNj?=
 =?utf-8?B?ei9SZUhvZFdzZVpFOXNCQS94cVJoU1pFNlo2OGczMTdQOEYrUHBYZUMzOENB?=
 =?utf-8?B?bjFtUDNqV1o0VG9TeEJhVTNZQmprN0JDc0doQWxmK05MT1o2UGxyUzFMNDBw?=
 =?utf-8?B?anlzdkt2bzFaTis0TDl2Y0xXRzdockwxNW9tUC9oYytmckFlczBHWnFhY3l2?=
 =?utf-8?B?dGZHVTVWZWZoZTlRNCtlR2RJZThPVm01YkpDYUpkUVNhbEwySnllUVkrS3NE?=
 =?utf-8?B?Nml4dS92azZjcW5hd1VJUnpWU3ZRVDREYnZ4ZzN0Mm4rUXd3UzUxN1NwaUNO?=
 =?utf-8?B?bDAvRjdlM050U2NYRXlnMHA4TDMwcXQxdG14c0dnZjVhZlRicjB1azZQeTlK?=
 =?utf-8?B?Q29kd3NNZEQxeXFEb2FRTDZhN0xVSVJUbDZ0bzltZWpiQ1hldUQ0R3lQZktl?=
 =?utf-8?B?UkIzNUFUdy9IWGRwLyt0M1ZuNGJQditLNDFQWk4zQ0l3UzdpZldWdlJLVmVY?=
 =?utf-8?B?Wnc5QUUwQ1FZR2RlbTlJUlZZWUFjWThiejVIbXZzSUozanlzUGkzUnVhWElY?=
 =?utf-8?B?RU9wU0o2Z0xZeG1DMjJEcjFzb3dhN1RqU1ZqUFB0RDRselorQlM1d0w3clds?=
 =?utf-8?B?ZWpReTNoYzY1ZWMxTGNKQW9nenFGWHlORjZTN0xhdEx4T0hJUU5wemJGTnNx?=
 =?utf-8?B?RTBnUTErR2xuMTI5a3ZSUlNmeFFseU5jK29FVmUyR2RuaE91QUdmNk5scVJX?=
 =?utf-8?B?VHo1SGMrMkhGT2JQYjFOTllGNCs1UzNkcVV0RDNQZkdsc3lxMUZOZU5RUVBn?=
 =?utf-8?B?Q1dYS1duMnZ1YkF1SjVhRFFnZEZuYXV1czBIelRMbzlCVGV5eXVtbEpwMVBl?=
 =?utf-8?B?TUFCdTFFV3RaclozVHlPVXUxRVRBb2EvOTlCTmJYa0RtTXZyUXFrVUlxdDBY?=
 =?utf-8?B?QjVLNkwwOXdKeEtBMkhtRTBHY3hYZURMbU0ycHNqbU91MWl2VWZUZHcrMDZx?=
 =?utf-8?B?UmVZYkM2UHQ3cFgwZ2M3Y0pVbjhaeXEvN05BYlNyMmswMlYrNmlyZkl2azBa?=
 =?utf-8?B?SmdtSTNnTGp6QUpFK2g4RHdTVmdWUHVUMUxRZG82d2JkM2srVWdNK1NRVGNr?=
 =?utf-8?B?WDVVbjQ1cGFHak8zM1daeHhRa1dFcmx3K1UybUVmSzFvaTRRUHRtN2h1UXRC?=
 =?utf-8?B?R2grcFRRazJObDB3akpLMnYydjgxaGVQb0VTNFIvdlZIR2g0dllSOVFTekJN?=
 =?utf-8?B?RmNnWElSTEhNZ0dIV3FCWEJRY1F6M3FqWG4rVEJZRVVsOTFGWjZFUHdXYXgr?=
 =?utf-8?B?MlR0QXBSeDZtMlh2bnVOT3BuaE1CUFBpNkNrVVdJenl5SUVVWHluRDlpQ3Nz?=
 =?utf-8?B?dElCbnNoL1oxZFhUcldlcUpOclRtOWdIS0p4RTMya3FyT1hVS1hROGJzdHVY?=
 =?utf-8?B?ZWRqc1d2N2d3RTVUMWw3RTVnQ2NqWUpCK2dqVUhJMEJ2SXh4NS9DMWgwelk1?=
 =?utf-8?B?Vm9vdTNNY2puMlRUczlFTFNESnp2VjIvRmpzazZhbVYwOVNwZTd6L2hlMkZh?=
 =?utf-8?B?TVRSN3FEaUtuWThWVExCTVYxQW1lM0JNR3hVQmZpMFlPQWw5TzVXN1lmZ3Fu?=
 =?utf-8?B?WnlMVi85UkVDRXRPSzRsM2Q3dW1kc1VmR3o0MC95bmR0Ti8ya3RiU09IUXZC?=
 =?utf-8?B?c1VYK3pybnRwcytqVVhVdEZ3d0ErSTdDM0JXV0xPM2ZwTkVUd0VNODh1czRV?=
 =?utf-8?B?cUpDRzRoa2dEN2crekxyUnlTRk1HclBjdnJBbUVvR1c2djN4UkNFV2dlMTZZ?=
 =?utf-8?B?dzM1TTJOVXBRUERNVWxQN0JqbXV1T0NSenhXMHIzb2NFa0tsYzhBZ1FLbmF1?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF3AD1B75CD2D4FA8C97EE9E08342AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b03154-0d1b-4e74-c83d-08dbb5039872
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:18:45.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gjNbQSCKFPczQ9dBq36CL2ryAkjXC0lneTJk/NEiEiEpz8KEaNIgIX1RldgQw7IqGlOHK15OFi0uK7vK1hmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDEwOjU5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMDc6NTQ6MTBBTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gDQo+ID4gPiBUaGUgcG9pbnQgb2Ygbm9yZXR1cm4gaXMgdGhhdCB0aGUgY2FsbGVy
IHNob3VsZCBrbm93IHRvIHN0b3AgZ2VuZXJhdGluZw0KPiA+ID4gY29kZS4gRm9yIHRoYXQgdGhl
IGRlY2xhcmF0aW9uIG5lZWRzIHRoZSBhdHRyaWJ1dGUsIGJlY2F1c2UgY2FsbCBzaXRlcw0KPiA+
ID4gdHlwaWNhbGx5IGRvIG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgZnVuY3Rpb24gZGVmaW5pdGlv
biBpbiBDLg0KPiA+IA0KPiA+IEFoIHRoYXQgbWFrZXMgcGVyZmVjdCBzZW5zZS4gIFRoYW5rcyEN
Cj4gPiANCj4gPiBUaGVuIEkgYXNzdW1lIHdlIGRvbid0IG5lZWQgdG8gYW5ub3RhdGUgX19ub3Jl
dHVybiBpbiB0aGUgZnVuY3Rpb24gYm9keSwgYnV0DQo+ID4gb25seSBpbiB0aGUgZGVjbGFyYXRp
b24/ICBCZWNhdXNlIHRoZSBjb21waWxlciBtdXN0IGFscmVhZHkgaGF2ZSBzZWVuIHRoZQ0KPiA+
IGRlY2xhcmF0aW9uIHdoZW4gaXQgZ2VuZXJhdGVzIHRoZSBjb2RlIGZvciB0aGUgZnVuY3Rpb24g
Ym9keS4NCj4gDQo+IEkgdGhpbmsgc28sIEknbSBzdXJlIGl0J2xsIHRlbGwgeW91IGlmIGl0IGRp
c2FncmVlcyA6LSkNCj4gDQo+ID4gQnR3LCBJIGhhcHBlbmVkIHRvIG5vdGljZSB0aGF0IHRoZSBv
Ymp0b29sIGRvY3VtZW50YXRpb24gc3VnZ2VzdHMgdGhhdCB3ZSBzaG91bGQNCj4gPiBhbHNvIGFk
ZCB0aGUgdGhlIGZ1bmN0aW9uIHRvIHRvb2xzL29ianRvb2wvbm9yZXR1cm5zLmg6DQo+ID4gDQo+
ID4gMy4gZmlsZS5vOiB3YXJuaW5nOiBvYmp0b29sOiBmb28rMHg0OGM6IGJhcigpIGlzIG1pc3Np
bmcgYSBfX25vcmV0dXJuIGFubm90YXRpb24NCj4gPiANCj4gPiAgICBUaGUgY2FsbCBmcm9tIGZv
bygpIHRvIGJhcigpIGRvZXNuJ3QgcmV0dXJuLCBidXQgYmFyKCkgaXMgbWlzc2luZyB0aGUNCj4g
PiAgICBfX25vcmV0dXJuIGFubm90YXRpb24uICBOT1RFOiBJbiBhZGRpdGlvbiB0byBhbm5vdGF0
aW5nIHRoZSBmdW5jdGlvbg0KPiA+ICAgIHdpdGggX19ub3JldHVybiwgcGxlYXNlIGFsc28gYWRk
IGl0IHRvIHRvb2xzL29ianRvb2wvbm9yZXR1cm5zLmguDQo+ID4gDQo+ID4gSXMgaXQgYSBiZWhh
dmlvdXIgdGhhdCB3ZSBzdGlsbCBuZWVkIHRvIGZvbGxvdz8NCj4gDQo+IFllcy4gb2JqdG9vbCBo
YXMgc29tZSBoZXVyaXN0aWNzIHRvIGRldGVjdCBub3JldHVybiwgYnV0IGlzIGlzIHZlcnkNCj4g
ZGlmZmljdWx0LiBTYWRseSBub3JldHVybiBpcyBub3Qgc29tZXRoaW5nIHRoYXQgaXMgcmVmbGVj
dGVkIGluIHRoZSBFTEYNCj4gb2JqZWN0IGZpbGUgc28gd2UgaGF2ZSB0byBndWVzcy4NCj4gDQo+
IEZvciBub3cgbWFudWFsbHkgYWRkaW5nIGl0IHRvIHRoZSBvYmp0b29sIGxpc3QgaXMgcmVxdWly
ZWQsIHdlJ3JlIHRyeWluZw0KPiB0byBnZXQgdG8gdGhlIHBvaW50IHdoZXJlIGl0IGlzIGdlbmVy
YXRlZC92YWxpZGF0ZWQgYnkgdGhlIGNvbXBpbGVyLA0KPiBwZXJoYXBzIHdpdGggYSBwbHVnaW4s
IGJ1dCB3ZSdyZSBub3QgdGhlcmUgeWV0Lg0KDQpUaGFua3MgUGV0ZXIhDQo=
