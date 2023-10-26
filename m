Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769D7D7A41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJZBlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjJZBky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CC137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698284453; x=1729820453;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VNmfIcBGDOmlq8+4EhYZ5IzUuHnhKAgQK53Vyxpl+rs=;
  b=l8Jgip7mEKRrj9nC2Z9nAMsCSg4IrNe7PKDI19OtzfxD00NKf2nT9xWY
   7DKfhYNqlApPku++FLcHYxzpeVuLNimeD4qw8dld+PoFiEieTGdXZxpR1
   VPVHsfBMyI3KWVv9NaW5tS8uUvO1iETnkyRq99ghc/tic9YqZv9WC0pFL
   SQ8QRp3L1bHo0t6EgW+BovnEfm/4yFDpU41rNafSayHgpICF0xVndV9ht
   SmjzGyfAqMN3VLJl2ZyIi9m7myntHE4tKePGMbdt1kjc6LpzlUYid8WJE
   xaSvQcQxtNLNyJd7lQPMESdgYoXCFmnLhLLF+LvE+XKxUsM8MS0Oo1m22
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="225566"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="225566"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 18:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735585558"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735585558"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 18:40:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 18:40:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 18:40:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 18:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzQNnjuCw1hBP0VtkwOoQByYWE/1Ou12H4+g4JJBbvCBaZCKQ3VEtTsE8PSgBJem46nLAL36Gjo/3aeAaPv30DHxoUMzzF4VJzPqLHVzZYRrneEOe0lEpJvcwbu9QqcufXhskE54fuWVyHvmczm3xBszOEIqNhtQpqgKDvDgHFzH1nxA2jnbNWWDcqVloOHIAaXHdITQ/s3gzwQiv3x3yJvWg0r5LiFEkS3UI/XyDGkiJrBybiI5A7ZpBnVBbvTxY7JkczkhnOyh2Cgzo0vNETKEy3PA1lKJx5e0k7Txhd0TbyEpMZAiQwUFi/tLZSKaG9+TuYzRoQ/SVPYAk5YlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNmfIcBGDOmlq8+4EhYZ5IzUuHnhKAgQK53Vyxpl+rs=;
 b=g+AbweFNu6cgh04GhEuuyhmzRIye4oGfrwSrZ87rGRZA2jZIt0yRAkMnUF1lNI4GeOovZ+tZDZxs2N55+SpuJkGD5GhDjm4RidgWK8+vmlxvYQJYJm8Y4XgAG2fOQU0Avamh//s9/mnYsr9cr5GSVMeBF7u/d/sDgUFlUYsQv+eaCqhpA4i+4L/Vq9cSnE5Rf1V+2vODNj/ocxl4aFMRQwOtJ2aVIqAZZvX+LlttrNAw+XrIrWrpIxh+sSo4aF9XFiEj0ROOiq24UugPQPMsYHdDQ/Na602YaFnV1fAoK2MRUS2rQHuckXUhOpSmxKP3gL0dN3izwl2WeJhEqokaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 01:40:38 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 01:40:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSoD4BaRGvpYEWdXJl+rjaNYrBbOxaAgAASF4A=
Date:   Thu, 26 Oct 2023 01:40:38 +0000
Message-ID: <fd2426ee900e4f3a57659f3688c5bb652779785c.camel@intel.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7481:EE_
x-ms-office365-filtering-correlation-id: 2a3c8a0c-de25-4641-355c-08dbd5c48e5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8FJEj+gnM1A5fXV3xOkhCRv0QsXQtEBUSJw5j228AQbp9JZ5eU4JiZf36ostWpq15c1GLztp7WNRMhiMGeoyUsTmZvbq4uC5E4Xdc5UqoibwH4OD6CZORsXvWYGwqUBUvTW0ZnwZjrywYh5bWkU4ecaQWhIuEQR2j1zbtoa9P2ExiZC/MvWUCsyoLGjZ8Be1FneGQTxw3ojvV2DdWSDppSqhlGZmkAZjgLqMzLTKbuh4/51sPcsVDM55vGXdWDtHApjp4GhOEyZpFAhjoeS1bOB3uE5eOkZoPXEf6mX6tZkBo6jA29ruSrRQmckYa5SrobkYlb+QRKPPd34vD9U26/txh7DqlOJBvR9SKcosX3oeaNDESJ3FDSp4AVoBbHQ8OxWevKpWuqK3IBKM2eSh6AyCwHNqkGlXkL+M+3B5l13W1P0Fbm7kDxNDv67KoORdlr1dNdRG1zGDFSu4Im8z4nxMXg3B07azBuHpebxuYWD5N87pjpDQgL8Hi9ugJ6gx7ZU/l0wVWPfu+B79V367JwZqEVX5c429EDpWQYPI0WwzsStuZjpWkMaxMvUOCrx4rlOWV+vQoXKPrGGqtHJXsLm/bji7SJjLNEdpyfZUYOFALF2BOhzvet2G0AR2gOEbBmwLfA2O7RgXXxtNRkWimw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(8676002)(8936002)(66899024)(6506007)(86362001)(26005)(71200400001)(66556008)(91956017)(36756003)(66946007)(64756008)(66446008)(316002)(66476007)(6486002)(478600001)(6512007)(110136005)(122000001)(82960400001)(38100700002)(83380400001)(2616005)(38070700009)(76116006)(921008)(5660300002)(7416002)(4001150100001)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWpQeURTK09JcWdjblRMM3hzeXBiSkFBVlZwdDI4bnRlWG9TYjZVRFNHRDJl?=
 =?utf-8?B?cFV3ekhCS1oxSHpIOWVyVGNKbU1BQ0swSXExby8zR0w1RDNXajJFbXFNUlhn?=
 =?utf-8?B?cjdmcXlpY0t0UXFWNHJmQXdiS01idVJsekp3dWFPL0F3QUh3RkRGTVBMM29F?=
 =?utf-8?B?U3BSWFg4WUlacklYcmNyNmdHbkhOSURpM0RXbzVQUEpHdmkrNUhVc1E2dFhK?=
 =?utf-8?B?YVJxay93QzhHRjRSMWpjRHk2NU5pdXlRSG9RUVhqYjFUK2w3bW1IMWppaVN4?=
 =?utf-8?B?UnEzRGczWTNHeTZmN1Nma3loN0tCTzQrV1VuSm52RG52ZmxPM2NteUpIZVA1?=
 =?utf-8?B?K3dCOXJzemlocG4wV1RPTEFVT2FORFZIbUwyRjZaYzZHUUVCWjhZUFIySXZT?=
 =?utf-8?B?QlJROGJQc1grUitXSWt2by9qNTNZL25QWXhNZVd6ZTcvK3RJNFNZUXJLQ0ow?=
 =?utf-8?B?a0JWLzNWaGtsU09EMkpzb0JDeGVjNEtuYUF2bE5wN3k3TkZzU2FnR0xzTk9m?=
 =?utf-8?B?bFdqZmphNzVHTGYzWWVXdVJuKzB4WktvMzJGYlZucWNqTWlEK1VURFprTkZp?=
 =?utf-8?B?Q1gvMU1GVG5oR0JQdktkcTltY1JuV2dpeGE5eWVpVXhjUHJhS09xbWhNUzJo?=
 =?utf-8?B?TGlSTVRpRFUza21KRld0eloxMFZqWlVWdkRaaSt3blJBTzQwQ3hOMEZ4Q0Rr?=
 =?utf-8?B?UmJZdG9ZU0s0cmtjRUJRUVJDRWVnOFJyeEZLVW83aFAwdkdpQUR0WEREUGFE?=
 =?utf-8?B?eWJmUEN0dEZMZmNyL0dXbHJiRjB5RWRHTGFraUtEdDl1ZFZjc0s2ZVZNVXQ4?=
 =?utf-8?B?VC9HY1V2WWkvQmRzSzl6U1NJY2lQSmd0eldHSnlIZDlYMXp1cjEyN2lWbmc4?=
 =?utf-8?B?OTdDTEZOY1dtSzhWRnNrVFdUYU5MVnMyaTVwckMzdzFlL1EwLzNrbVpxbVho?=
 =?utf-8?B?azlUTWI0RVhXOU5TYUQrUG9jWkFYaUQvZFpON3JKVWV1NEZnSGpBSk1PZ1dw?=
 =?utf-8?B?OXZKbkJ5T2pRMFB1dExtM0VrYXZ2dzl4Yi93TnpPb2c3ZklMN0dKVlFOWWZQ?=
 =?utf-8?B?UXZMZW5sYm05dnlWSzVpWDNDU3JxUWxIa0RrRC9EOXRia2lLN0RHR3lrQnlC?=
 =?utf-8?B?VjdyU3JRcHQrWGltOEhSU1JzbEsvTnpEVTJiWFJmbi9tM3VqSXUrU1VJenpW?=
 =?utf-8?B?UUVOd1poT3MxUlBjdER0b21MZXBSdEFNTnZycGU4SU9VYzh4WkVtampnQ3hH?=
 =?utf-8?B?S0tSQ2c0MXorLzlLS0FONlF4LzQ0MWY1eG1WbXBKV21IT3lWME55SjFxY2ZI?=
 =?utf-8?B?WUZ0WTlUNGVyYTZqUkIyK2ZZcWpIMFQzbXhrRXByUk5BWmt3ZUE4aGdJQzRv?=
 =?utf-8?B?NmhVUDVBUGRudWdLYUNzUytEVkh4YVM2WnlLVkJlZ1BQTmFJQ3dmR1NmYitL?=
 =?utf-8?B?eER5dW15OVc5b2RueDFMdW41QjQ3cmk1MFI0d3RtbHJNQmtwSkxqZ1VPVHAz?=
 =?utf-8?B?T3hhcERRS1M1aG1KRHI5eThFU0tNd3owYTdETzh5Qk9va2F6U2JkS09QU0tW?=
 =?utf-8?B?ZWxZRTZvZVNIMGNSZWgwR0lid2tINUdGT1V3VlllU2lKSEhRaWFuVnBJZFBY?=
 =?utf-8?B?OXVBMWtpOWYwWjY1T2NDV2lKRndSMDQ1SFR1WWpsbzFZcktNS2RkOU9qbXN1?=
 =?utf-8?B?aFlkVEIrS1lCOEV6N3pnUGFRSHdyYUJUcy9PSmlnMmdVd2ZxWE5xTDBWUVNa?=
 =?utf-8?B?YTZwUEFaQk9rWWMwcVUwdUlTRk5KcGpLbnVXLzdSK1lXL1hXKzIzT0NBY0tK?=
 =?utf-8?B?cUdRVzY4V0ZxOGV3V1FZVjNxM0s4Q0RyWmdlbURleHdJN3ByQVZTdUNlZkZv?=
 =?utf-8?B?Ynk5WFdHYlFGQ0hNSm54SExRd21PeVhCNU5oQzNuSkhQZ0ZGNENDK0ExU3pp?=
 =?utf-8?B?bkEwMm43RzFyS1JOZXY0VHhaQkE0MGNIdWg3L3ZISTlTSHc1WVU3ZUw5ZWZ4?=
 =?utf-8?B?cHlZZ0IxcGpNUVd2TWlSNlBMb0JSTHoyTS8xbFBWYmtQWTZZRWRYUEF5NElB?=
 =?utf-8?B?N3pDTzRkMjdXRzdLSE5aWEs0VHZIWnJpUWV1amsrTWFFalp6L25FNk44YTRW?=
 =?utf-8?B?a2NQWGFjWFppcDRaOTNUVjhJUVEyMlhya0NnVnpwVnVBZ2wyRVhNZ0FzcHFa?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <411AFC034D07A444BF24DFDED207447C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3c8a0c-de25-4641-355c-08dbd5c48e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 01:40:38.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCWafHRg5dCUG3Naw1SQnIe7j88Oxf4G/5KLapLeZNNxLtvW/+Kcg4Z37PxdtQGdCmWrimruVw0SnqLo56VaX541j1nI8fuVO9AjdPWPjAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDAwOjM1ICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgp
IHdyb3RlOg0KPiBJIHRoaW5rIHlvdSBtZWFuICJzaGFyZWQiIGFzIGluZGljYXRlZCBieSB0aGUg
Z3Vlc3QgcGFnZSB0YWJsZXMgKHZzLg0KPiAic2hhcmVkIg0KPiBhcyB0aGUgc3RhdGUgb2YgdGhl
IHBhZ2UgZnJvbSB0aGUgaG9zdCBzdGFuZHBvaW50KS7CoCBTb21lIHByZWNpc2lvbg0KPiBvbg0K
PiB0aGF0IGRpc3RpbmN0aW9uIHNlZW1zIHVzZWZ1bCBoZXJlIGFuZCBpbiBmb2xsb3ctb24gcGF0
Y2hlcyB0byBtYWtlDQo+IGNhbGxlcnMnDQo+IGVycm9yIGhhbmRsaW5nIGJlIGNvcnJlY3QuwqDC
oCBBcyBJIHVuZGVyc3RhbmQgaXQsIHRoZSBwcmVtaXNlIGlzIHRoYXQNCj4gaWYgdGhlDQo+IGd1
ZXN0IGlzIGFjY2Vzc2luZyBhIHBhZ2UgYXMgcHJpdmF0ZSwgYW5kIHRoZSBob3N0L1ZNTSBoYXMg
bWVzc2VkDQo+IGFyb3VuZCB3aXRoIHRoZSBwYWdlIHByaXZhdGUvc2hhcmVkIHN0YXR1cywgdGhl
IGNvbmZpZGVudGlhbGl0eSBvZg0KPiB0aGUNCj4gVk0gaXMgcHJvdGVjdGVkLsKgIFRoZSByaXNr
IG9mIGxlYWthZ2Ugb2NjdXJzIHdoZW4gdGhlIGd1ZXN0IGlzDQo+IGFjY2Vzc2luZw0KPiBhIHBh
Z2UgYXMgc2hhcmVkLCBzbyBrZXJuZWwgY29kZSBtdXN0IGd1YXJkIGFnYWluc3QgcHV0dGluZyBt
ZW1vcnkNCj4gb24gdGhlIGZyZWUgbGlzdCBpZiB0aGUgZ3Vlc3QgcGFnZSB0YWJsZXMgYXJlIG1h
cmtlZCBzaGFyZWQuDQo+IA0KDQpGb3IgVERYLCB0aGUgc2NlbmFyaW8gb2YgY29uY2VybiBpbiB0
aGUgVk1NIGVycm9yIGNhc2UgaXMgaWYgdGhlIHBhZ2UNCmlzIG1hcHBlZCBhcyBzaGFyZWQgaW4g
dGhlIGd1ZXN0IHBhZ2UgdGFibGVzICphbmQqIGl0IGlzIGVpdGhlciBhbHNvDQptYXJrZWQgYXMg
c2hhcmVkIGluIHRoZSBFUFQsIG9yIHRoZSBWTU0gc3VwcG9ydHMgYXV0b21hdGljYWxseQ0KY29u
dmVydGluZyBpdCBvbiBhY2Nlc3MuwqBJbiB0aGUgYXR0YWNrZXIgc2NlbmFyaW8sIEkgdGhpbmsg
dGhlIHByb2JsZW0NCmlzIGp1c3QgdGhhdCBpdCBpcyBtYXJrZWQgc2hhcmVkIGluIHRoZSBndWVz
dC4NCg0KSSBjYW4gY2xhcmlmeSB0aGF0IGl0IG5lZWRzIHRvIGJlIG1hcHBlZCBzaGFyZWQgaW4g
dGhlIGd1ZXN0IGZvciB0aGVyZQ0KdG8gYmUgYSBwcm9ibGVtLCBidXQgSSBkb24ndCBzZWUgaG93
IGl0IHdpbGwgaGVscCB0aGUgcGF0Y2hlcyB0byBmaXgNCnRoZSBjYWxsZXJzLiBJdCBzZWVtcyBs
aWtlIHRvbyBtYW55IGRldGFpbHMgZm9yIHRoZSBjYWxsZXJzIHRvIGtub3cNCmFib3V0LiBGb3Ig
ZXhhbXBsZSwgSSB0aGluayBzb21lIGFyY2hpdGVjdHVyZXMgZG9uJ3QgY2hhbmdlIHRoZSBQVEVz
IGF0DQphbGwuIFRoZSBjYWxsZXJzIGFic3RyYWN0IHNoYXJlZCBhbmQgcHJpdmF0ZSBhdCBhIGhp
Z2hlciBsZXZlbC4NCg0KDQo+IFRvIG1lLCB0aGlzIHNlbnRlbmNlIGRvZXNuJ3QgZnVsbHkgY2hh
cmFjdGVyaXplIHdoeSBwYW5pY19vbl93YXJuDQo+IHdvdWxkIGJlIHVzZWQuwqAgWW91IGRlc2Ny
aWJlIG9uZSByZWFzb24sIHdoaWNoIGlzIGEgY2FsbGVyIHRoYXQgZmFpbHMNCj4gdG8NCj4gcHJv
cGVybHkgaGFuZGxlIGFuIGVycm9yIGFuZCBpbmNvcnJlY3RseSBwdXRzIG1lbW9yeSB3aXRoIGEg
InNoYXJlZCINCj4gZ3Vlc3QgUFRFIG9uIHRoZSBmcmVlIGxpc3QuwqAgQnV0IGdldHRpbmcgYW4g
ZXJyb3IgYmFjayBhbHNvIGltcGxpZXMNCj4gdGhhdA0KPiBzb21ldGhpbmcgdW5rbm93biBoYXMg
Z29uZSB3cm9uZyB3aXRoIHRoZSBDb0NvIG1lY2hhbmlzbSBmb3INCj4gbWFuYWdpbmcgcHJpdmF0
ZSB2cy4gc2hhcmVkIHBhZ2VzLsKgIFNlY3VyaXR5IGZvY3VzZWQgdXNlcnMgd291bGQgbm90DQo+
IHRha2UgdGhlIHJpc2sgb2YgY29udGludWluZyB0byBvcGVyYXRlIHdpdGggdGhhdCBraW5kIG9m
IHVua25vd24NCj4gZXJyb3INCj4gaW4gdGhlIGNvcmUgbWVjaGFuaXNtIG9mIGEgQ29DbyBWTS4N
Cg0KSG1tLCB5ZWEgSSBjb3VsZCBzZWUgdGhhdCBzb21lIHVzZXJzIG1heSB3YW50IHRvIHRha2Ug
YSBoYXJkIGxpbmUgYW5kDQp0ZXJtaW5hdGUgaWYgYW55dGhpbmcgbG9va3Mgc3RyYW5nZS4gVGhl
IGNvdW50ZXIgcG9pbnQgaXMgdGhhdCB0aGUgVk1NDQppcyBhY3R1YWxseSByZXR1cm5pbmcgYSBs
ZWdhbCBlcnJvciBoZXJlLiBJdCBtYXkgYmUgc3RyYW5nZSBiYXNlZCBvbg0KdGhlIGRldGFpbHMg
b2Ygd2hlbiBIeXBlclYgYW5kIFFFTVUvS1ZNIHdvdWxkIHJldHVybiB0aGlzIGVycm9yLCBidXQN
Cm5vdCBhcmNoaXRlY3R1cmFsbHkuDQoNCj4gDQo+ID4gK3ZtbV9mYWlsOg0KPiA+ICvCoMKgwqDC
oMKgwqDCoFdBUk5fT05DRSgxLCAiQ1BBIFZNTSBmYWlsdXJlIHRvIGNvbnZlcnQgbWVtb3J5IChh
ZGRyPSVwLA0KPiA+IG51bXBhZ2VzPSVkKSB0byAlcy5cbiIsDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICh2b2lkICopYWRkciwgbnVtcGFnZXMsIGVuYyA/ICJwcml2YXRl
IiA6DQo+ID4gInNoYXJlZCIpOw0KPiANCj4gSSdtIG5vdCBzdXJlIGFib3V0IG91dHB1dHRpbmcg
dGhlICJhZGRyIiB2YWx1ZS7CoCBJdCBjb3VsZCBiZQ0KPiB1c2VmdWwsIGJ1dCB0aGUgJXAgZm9y
bWF0IHNwZWNpZmllciBoYXNoZXMgdGhlIHZhbHVlIHVubGVzcyB0aGUNCj4ga2VybmVsIGlzIGJv
b3RlZCB3aXRoICJub19oYXNoX3BvaW50ZXJzIi7CoMKgIFNob3VsZCAlcHggYmUgdXNlZA0KPiBz
byB0aGUgYWRkcmVzcyBpcyBvdXRwdXQgdW5tb2RpZmllZD8NCg0KVW5mb3J0dW5hdGVseSwgSSBk
b24ndCB0aGluayB3ZSBjYW4gcHJpbnQgdGhlIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MNCmJlY2F1
c2UgdGhvc2UgYXJlIHN1cHBvc2VkIHRvIGJlIGhpZGRlbiBmb3Igc2VjdXJpdHkgcmVhc29ucy4g
SWRlYWxseSwNCkkgd291bGQgcHJlZmVyIHRvIHByaW50IHRoZSBQRk4sIGJ1dCB3ZSB3b24ndCBo
YXZlIGl0IGhlcmUgaW4gdGhlIGNhc2UNCm9mIHZtYWxsb2Mncy4gSSB0aG91Z2h0IGl0IG1pZ2h0
IGJlIHVzZWZ1bCB0byBzdGlsbCBoYXZlIHNvbWUgYWRkcmVzcw0KcHJpbnRlZCBmb3IgZGVidWdn
aW5nIHB1cnBvc2VzLg0KDQo+IA0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJ
TzsNCj4gPiDCoCB9DQo+ID4gDQo+ID4gwqAgc3RhdGljIGludCBfX3NldF9tZW1vcnlfZW5jX2Rl
Yyh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcywNCj4gPiBib29sIGVuYykNCj4gPiAt
LQ0KPiA+IDIuMzQuMQ0KPiANCj4gTXkgY29tbWVudHMgbm90d2l0aHN0YW5kaW5nLCBJJ20gZ29v
ZCB3aXRoIHRoaXMgb3ZlcmFsbCBjaGFuZ2UgYW5kDQo+IHRoZSBhZGRpdGlvbmFsIGxldmVsIG9m
IHByb3RlY3Rpb24gaXQgb2ZmZXJzIHRvIENvQ28gVk0gdXNlcnMuDQoNClRoYW5rcy4NCg==
