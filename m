Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5715765FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjG0Wyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG0Wyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:54:35 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2AE94
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690498474; x=1722034474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/rJlxC3Pvrz9nfAtutZqOmFCKeWS61Z+buW0iRk8W5Y=;
  b=jnpIHUIDi+gFfAQrBx/tJpV6NriOAKXjjJDLbJHr6j2wrtDNAMyB/8bG
   cvkJ+9Ng1lX0VWddn3X14TxwPLTSgJmBrkhWoFOtdVcj+H4gR+FunxSyJ
   565NW5dsxXDfmn22/ZQ3AGqP0t3E5wp01b2xRd6g0tPfq7fP/C6m5c5N+
   mBEW6JJrG90L6Mab5b9wLLNmKVj7NyfkhgtZzyDAiNNNniT9GhG/gEOj8
   L6djnbWW3ZuaTRRjZLJieCVmM6qeu+SV+vFLTiznsckygLQkxuwzvQzWy
   4EBi3j03X9pskXGeGaXkwHpT6g349Bbj5cg1NcVlSBU/55NXeFu+MsiiA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367323410"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="367323410"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 15:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792659295"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="792659295"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2023 15:54:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:54:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:54:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 15:54:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 15:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gufj5+Uz1M8geMFDSIfBNK/zNVBdUVoCLlENDOVxZ/owuSEU6Vfu/ul8GIZIOkQwp60GrNNipkyim3ZSJL5rrP5twGrEv8sq6Z+tNz8FtxHoXHynSsbzbF47cNgew8P5gvx7Rm5QLyGreHhv5tKCtzCrX/hYTkwJqusXhF3HqL6YDMQWKZ38/1KMhriVkQVqLxA7l/hExh7jY/00I7xG6OuiviBV1fDoVkpPOUT8KKfBukO0oDONivrCAOYJXm72+kM3z07jB2W46gtbxeKgugo35o1OsrdouW+iHsjZ9dSM2Niw3ZkiXiJdtHXoYF1GxarFL8czPEWlKqSjVfZmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rJlxC3Pvrz9nfAtutZqOmFCKeWS61Z+buW0iRk8W5Y=;
 b=CwoSb9iKruaJC0/dx/Clz/ENnvfdg/RJ2+IBtG+Wo7DQ2HIA10J1T37IWmJ2TrIFdGMjwCoG11+BKJHHviPVzkkUcZxgF3wpgYSPepKR8bGdQ2/Gh7YFHYgwMIzjNK9t68DbyEib0bco0aLBKEB8xD/ma3OfHRGfy6sFP5YLh8Q1BmsU+5/SQ1moJBe118M0r3v276LsxJbv0Myv7PmphoIRT14XMJfBQf/TOef7ZXfhb08RiRieudoP4MFwYL/WU7DqJFWGgtuKN5DvHbTR3CCKUQqvgvpuD7p+E9QVgXTOIs4BPPA+DZc2eiGWsnPEgzZ1COrhQTpeXbGFAdBAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 22:54:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 22:54:28 +0000
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
Subject: Re: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Thread-Topic: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Thread-Index: AQHZv7EqgHMyN5+0wkOBrwJbR0AS5K/N0ZsAgABpmAA=
Date:   Thu, 27 Jul 2023 22:54:28 +0000
Message-ID: <6374fd1aa1e2ff4777eab2421cfc439d259cc603.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
         <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
In-Reply-To: <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: bac609a0-6576-4a82-6e17-08db8ef46ee5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yueRkwsi4MPV1EGoMfoyMWOq6z+ulKlWz6M6rUgISOtxCmJSdgPissTNH0TbE7Cl1CcbXpJ/8vrdPsv8W+kQ8KtjhtiZi3aP8I8pTU+94oGSLuQthffBxwONUL+iiV5yRCULPni6Ey8G45AFmjtDFNNvBpTudbej8WNDljLcdwiyRnpknwkj/YcK6eXg0EXEShZTCv7RWLQHptdbiNIChdrEtVSMU2TUqUE+HtiYo16omqBwOupq9AqXC8ep2fenxqD5H1Vz3fWzwmZL4wQgg3uPXF70RaUH5deR+UZbDowBHyQkKhMAWYlvAQ1TZlfkUiy+b9Fn8nWiQO5imsZHGpIPe4JoB+RHFS0GmzSeiYyJRB7OjW0em4hNIO65oVXAvHfc5mdhD2y97ei11Iv2kbq6LtVKY/+5OaZhnDKaoSvbg6Ptw+y/uOJNahMhaW0SI0epBKYFUsrvwKoUVWHAOqhuOYzPSTOpCzJmAI549v1mi1kVGNjJ9E3E9FA+14QjGar3Izo6ER/47A+Qj+Gvi19ATXFLPhutavR63XqhzZ3V9qLpbF907FobQK/bmQacYkeuISE+Jgjw3WEC4qyA3q2qnFvhcZupf9WsRHUnlQMwWQ/wG1pEwKHpotR+ziVo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(316002)(2906002)(8936002)(8676002)(7416002)(5660300002)(38070700005)(41300700001)(36756003)(86362001)(6486002)(71200400001)(122000001)(478600001)(26005)(82960400001)(6506007)(186003)(54906003)(2616005)(76116006)(66946007)(66556008)(91956017)(83380400001)(6512007)(38100700002)(64756008)(66476007)(4326008)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnRjOS81MDh6RTBjckpTcWNtSGMrZCtaRldRdFIxVUdhcWQrUERQMUpydTBy?=
 =?utf-8?B?bDRiODZ0RFZ6VGtWTENvNHJQUlp4bmZFdWpLTURRV2h1end2TUplOGpSWkd4?=
 =?utf-8?B?Q1FPUkpza1U1Wnp4U29KdjVyRTE5a0t1N2laTXF2dzN0Z09KeU5pck1DWU00?=
 =?utf-8?B?d0V0K3pldlJKV3JSSWlrN1h4aGg2MG9kK3pndzYxZkVXM3hDYlM3NG1aUE1D?=
 =?utf-8?B?eXE0dElwWUN6WVVrQmRoYTdPdHVhQVZLSzBKalRkTWRBV05iSk1HQkw3aFcv?=
 =?utf-8?B?WG5NMFZObDl0NEMxV001ODJjSVJmUWtybTkyME8yRFhPbkNDUDhpRWhBMXFX?=
 =?utf-8?B?UmlKNXFnUDZsc2U2Y3I0cGdzNjdHZjcrRDlTdUJJT3FXbVM4a1pEOTVGSHF3?=
 =?utf-8?B?MERxSEsvZmtmNnVJVCtuclhGbEpqTmpOUUhDaEpFb2JZSkRUK0dpVEVnUVZw?=
 =?utf-8?B?eE1ZbW11M1pZV2NsWWVHTENkTUphSm8xN3ZTdW1xYUlVYUF6RmNnRkJ5ZGdr?=
 =?utf-8?B?bUVTb1AvSWF1K1I4d3BwdmNkMUVVeC9XVVVrSnN6ZEVpVm44QlVkR2xqUFVG?=
 =?utf-8?B?cEI5SGp3d24xYzlzZjZValh3Nm1CdXJsMVNHTlFiMXo0Qis2M0ZxbFQ4ZWY0?=
 =?utf-8?B?TjN1Tk9wenZxdzBta01nWnM5MlZOdElibklWL2pWZW0xRzFVY3ZuS1BneUJh?=
 =?utf-8?B?TUdUd2ZzSThvYnc2ZWU5WVFzOXJOSDJ6V1V2Rmx2RlQ5bllSdUR3MWV1UFNx?=
 =?utf-8?B?VFlnY0dpelFQWGZ6TVhjYSt0Mk1GNVFVbEhpM1RmNC8wTFIvNmpLSzI3a2xm?=
 =?utf-8?B?TDVZZGcrVGtKMlN0cW5Jeit5Z2dORUMrN0VOcGFlakhhUFp3SkZvNExxaDhT?=
 =?utf-8?B?VTFDalE2cExQcGorNUJZdEp5TEJHbUg4U2VLdEUwc2o2bnFrLzUzNjN6NTE3?=
 =?utf-8?B?VUQxd3RTTUh6dUUyNTYvSjUxNkZuTFJqSDdyVitBam9icVd0R2QyL2RRblgy?=
 =?utf-8?B?K01UdTBGZGdkaEhtazFKMXd1ZTdJZXI0bnpuTWJZaUphZmxuR3lucUtHdzk3?=
 =?utf-8?B?d3hwK2s3QW5aNGZEVCtTdHkvekhKa3JxNDRmMWl6YmJySnppdDlXbFg4elFM?=
 =?utf-8?B?OHNteWE4ZFN5Sm9ON2hCU3paOFdtMHFQZTFrMitMWjZ4amFqR3JVRFpIUGFN?=
 =?utf-8?B?UXRKejNnbDhWTmpLa050NnRyZzZEU2RZOENHTzJ3Y3E0Nm5tZk4yY0ZORFM3?=
 =?utf-8?B?YmFCRng4SUdmVTdzOUlhK0NGZHd3STNMRTUxQXE5ODJWR0tJdnd2U2ppUHBp?=
 =?utf-8?B?dEEzVUxicWhhTklnVEVQNkhrdlROYTAvS0NWRldRclVac1QycXVxQmxpcXlO?=
 =?utf-8?B?ZDArejhFeGNibjdYa08wNG1DSWI0eGNObzdwcEkxZDdGZjVLTmRjeTYwb0tt?=
 =?utf-8?B?QjMvYzZoUTBMVWZRVkRXTUlIQ0hrWmNFVXVvMXNEN2RLMnhIQStpblJsVGdj?=
 =?utf-8?B?dk9DQ004dmZlbnFmVUgrdTYza1pTWjRPODVJOUErSEIvc2VwWDlvTFVFR25r?=
 =?utf-8?B?R0hjOVVvR3p6ajE5Z0pBTU5hYWd5YWlyS0xHaWdQTW9mQlVMTUQzRG9pTGNT?=
 =?utf-8?B?YW9RcUJMVnRqejA5SzVEY3YxVlVSakpXYy9hZS80WnljWW5qTWZDazc5Ymc3?=
 =?utf-8?B?elVMUCtZSEJ3MjFhWmw3RXBaV042alR1NjJCN0VCcXY2aHU1QVd5Ylo2RjFJ?=
 =?utf-8?B?QzBpTEloUmZlUXFrSG1pWk42bk9UeUFoMURRNGJtZjVVQkZuVFZYQnhJbDBO?=
 =?utf-8?B?WjJLclpjdmlocjhyRFdoZFRHcFl1T1RXSmM3Rldrd3B2NmpGVkNpWFp0TUV3?=
 =?utf-8?B?ZDJ1aEVZTmpwMjM0a3ljYlVDdUNLeE56V3JhSjdHWUlXSnZFQ2dlYWxyNEtD?=
 =?utf-8?B?WWtCSW5YTTMwNDhJZ0owZExGKzVlaFVNNXJHS3I3YkdsVE95ZlVPWW1DUzJi?=
 =?utf-8?B?QnRmT0xuYlJSb3pvNWQ0TGR4WW9adWFvdUNwVGJhRXRSVVdFbGp1dkpIRU03?=
 =?utf-8?B?V3MrVHpFd2JOenRyMlBnNkVtRnVOK1Qxc2lYdnR4RnJsci93WW12TzhwSWZY?=
 =?utf-8?Q?kX0byG3GUvV/5691dzO11NiYe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5094D6180AB4844BB3F6FC020CE1B877@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac609a0-6576-4a82-6e17-08db8ef46ee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 22:54:28.6245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTnjr26YZEEUFkb0jkrz4X8V1wAtW8Stps7Rd/7b30koljsKJwJcmt0rkk2x9EQO2JOz45QpRbX33Y5LaGd5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDE5OjM2ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNTowN1BNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHhjYWxsLlMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4Y2FsbC5TDQo+ID4gaW5k
ZXggNmJkZjZlMTM3OTUzLi5hMGU3ZmU4MWJmNjMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeGNhbGwuUw0KPiA+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90
ZHhjYWxsLlMNCj4gPiBAQCAtMTcsMzQgKzE3LDMzIEBADQo+ID4gICAqICAgICAgICAgICAgVERY
IG1vZHVsZSBhbmQgaHlwZXJjYWxscyB0byB0aGUgVk1NLg0KPiA+ICAgKiBTRUFNQ0FMTCAtIHVz
ZWQgYnkgVERYIGhvc3RzIHRvIG1ha2UgcmVxdWVzdHMgdG8gdGhlDQo+ID4gICAqICAgICAgICAg
ICAgVERYIG1vZHVsZS4NCj4gPiArICoNCj4gPiArICotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKyAq
IFREQ0FMTC9TRUFNQ0FMTCBBQkk6DQo+ID4gKyAqLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsgKiBJ
bnB1dCBSZWdpc3RlcnM6DQo+ID4gKyAqDQo+ID4gKyAqIFJBWCAgICAgICAgICAgICAgICAgLSBU
RENBTEwvU0VBTUNBTEwgTGVhZiBudW1iZXIuDQo+ID4gKyAqIFJDWCxSRFgsUjgtUjkgICAgICAg
LSBURENBTEwvU0VBTUNBTEwgTGVhZiBzcGVjaWZpYyBpbnB1dCByZWdpc3RlcnMuDQo+ID4gKyAq
DQo+ID4gKyAqIE91dHB1dCBSZWdpc3RlcnM6DQo+ID4gKyAqDQo+ID4gKyAqIFJBWCAgICAgICAg
ICAgICAgICAgLSBURENBTEwvU0VBTUNBTEwgaW5zdHJ1Y3Rpb24gZXJyb3IgY29kZS4NCj4gPiAr
ICogUkNYLFJEWCxSOC1SMTEgICAgICAtIFREQ0FMTC9TRUFNQ0FMTCBMZWFmIHNwZWNpZmljIG91
dHB1dCByZWdpc3RlcnMuDQo+ID4gKyAqDQo+ID4gKyAqLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4g
U28sIHlvdSBrZWVwIHRoZSBleGlzdGluZyBhc3ltZXRyeSBpbiBJTiBhbmQgT1VUIHJlZ2lzdGVy
cy4gUjEwIGFuZCBSMTENCj4gYXJlIE9VVC1vbmx5IHJlZ2lzdGVycy4gSXQgY2FuIGJlIGNvbmZ1
c2luZyBmb3IgdXNlciBzaW5jZSBpdCBpcyB0aGUgc2FtZQ0KPiBzdHJ1Y3R1cmUgbm93LiBJIGd1
ZXNzIGl0IGNoYW5nZXMgaW4gdGhlIGZvbGxvd2luZyBwYXRjaGVzLCBidXQgSSB3b3VsZA0KPiBw
cmVmZXIgdG8gbWFrZSB0aGVtIGV2ZW4gaGVyZSBpZiB0aGVyZSdzIG5vIGdvb2QgcmVhc29uIG5v
dCB0by4NCj4gDQoNCg0KRG8geW91IG1lYW4geW91IHByZWZlciB0byB1c2UgUjEwL1IxMSBhcyBp
bnB1dCB0b28gZXZlbiBpbiB0aGlzIHBhdGNoPw0KDQpJIHRoaW5rIF9sb2dpY2FsbHlfIGl0IHNo
b3VsZCBiZSBwYXJ0IG9mIHRoZSBuZXh0IHBhdGNoLCBiZWNhdXNlIHcvbyBleHRlbmRpbmcNClRE
WF9NT0RVTEVfQ0FMTCB0byBzdXBwb3J0IGFkZGl0aW9uYWwgVERDQUxMcy9TRUFNQ0FMTHMsIHdl
IGRvbid0IG5lZWQgUjEwL1IxMQ0KYXMgaW5wdXQuICBUaGlzIHBhdGNoIG9ubHkgY2hhbmdlcyB0
byB0YWtlIGEgc3RydWN0dXJlIGFzIGZ1bmN0aW9uIGFyZ3VtZW50LA0KcmF0aGVyIHRoYW4gdGFr
aW5nIGluZGl2aWR1YWwgcmVnaXN0ZXJzIGFzIGFyZ3VtZW50Lg0KDQpBbHNvLCB3ZSBoYXZlIGEg
Y29tbWVudCB0byBzYXkgdGhpcyBhcm91bmQgdGhlIHN0cnVjdHVyZSB0b286DQoNCiAvKg0KLSAq
IFVzZWQgaW4gX190ZHhfbW9kdWxlX2NhbGwoKSB0byBnYXRoZXIgdGhlIG91dHB1dCByZWdpc3Rl
cnMnIHZhbHVlcyBvZiB0aGUNCisgKiBVc2VkIGluIF9fdGRjYWxsKigpIHRvIGdhdGhlciB0aGUg
aW5wdXQvb3V0cHV0IHJlZ2lzdGVycycgdmFsdWVzIG9mIHRoZQ0KICAqIFREQ0FMTCBpbnN0cnVj
dGlvbiB3aGVuIHJlcXVlc3Rpbmcgc2VydmljZXMgZnJvbSB0aGUgVERYIG1vZHVsZS4gVGhpcyBp
cyBhDQogICogc29mdHdhcmUgb25seSBzdHJ1Y3R1cmUgYW5kIG5vdCBwYXJ0IG9mIHRoZSBURFgg
bW9kdWxlL1ZNTSBBQkkNCiAgKi8NCi1zdHJ1Y3QgdGR4X21vZHVsZV9vdXRwdXQgew0KK3N0cnVj
dCB0ZHhfbW9kdWxlX2FyZ3Mgew0KKwkvKiBpbnB1dC9vdXRwdXQgKi8NCiAJdTY0IHJjeDsNCiAJ
dTY0IHJkeDsNCiAJdTY0IHI4Ow0KIAl1NjQgcjk7DQorCS8qIGFkZGl0aW9uYWwgb3V0cHV0ICov
DQogCXU2NCByMTA7DQogCXU2NCByMTE7DQogfTsNCg0KU28gdG8gbWUgdGhlcmUgc2hvdWxkIGJl
IG5vIGNvbmZ1c2lvbi4NCg0KRXZlbiBjb25zaWRlciBhIHRoZW9yZXRpY2FsIGNhc2U6IHNvbWVv
bmUgd2FudHMgdG8gYmFja3BvcnQgdGhpcyBwYXRjaCB0byBhbiBvbGQNCmtlcm5lbCB3L28gZnVy
dGhlciBwYXRjaGVzLCB0aGVuIGl0IG1ha2VzIGxpdHRsZSBzZW5zZSB0byBkbyBSMTAvUjExIGlu
DQpURFhfTU9EVUxFX0NBTEwgaGVyZSBpbiB0aGlzIHBhdGNoDQoNCjotKQ0K
