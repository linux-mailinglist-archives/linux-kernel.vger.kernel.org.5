Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA27D428E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjJWWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:07:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C499
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098835; x=1729634835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mR6V81BjyTYo4OFmzjTf/0azn4zPFPXAZA179q9zHbE=;
  b=dD5afD1HSg9EmlhfG5bm8zzTkA+GDOm4r7dkpQQFifQOMB5L+M7hSIkO
   bqIZt+x7e1zD2AGlCpVvxcgy2FTY21belSfBTzZTU3CJTlNoOQhJXmDaD
   viwwcFLY0WCBxHkBnlIMSwWyqsC/vimev80O03NmPzQVYTkX4Zc07GL3u
   Nl9RfyRniaTUakmbxCGW5y1NWXoGBELQcCsqDno86lEUm94ieis+yDqHS
   fn512bvBDNz4cos6bokxoZd3HLo6ChDQdwbx/9tdlSegpZ527g+M+voaH
   ZAjgzgxKlb9vGyN5bsHySeJCx46qBAGFcFSEZrAbDCH5E+e0g98Jz/Gjj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5565273"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5565273"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 15:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828592270"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="828592270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 15:07:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 15:07:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 15:07:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 15:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD2VWurOOhAZN6KQezAq5FqLbZ8r5hz8wff9LeiJb4uxfU0YrtQ3dQ9q3Me2epjNYVotekBNZl1qIwiiVrVOoKjLWS3J5dGn7u9g3zAiQO5oUhxYOhX4tKt2q9AvrUJRb6UDfGHVGrOm6fDzRgNXrfeGYE/8K7083wbVcbDr3D1ujUZE91uRmTJxwPxHWxrF9c48QSQoVQHBDK53qNHkdntNjbOwEhGPE/3N7g0HzLVz7CkD6ktzvDGFLPLFDLfAmqnVqKqHImRv926kgMnlmZd7cBZxpG/z3Cc3/6mM35dkDAYU3yz2rZQWJ+hb0CXXgDEcA+XBX8fDyKZxuMwUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR6V81BjyTYo4OFmzjTf/0azn4zPFPXAZA179q9zHbE=;
 b=LurVXJehc8N02wj8YXuKjC/npMeby4UQIRXi/qWvhZ5iacLpIj6ibaP399m+naerWk1hKjaQ+ErLS0w2hmM/YhDAy+o+TJF4tEWw27p4LpQ5f8W25AhaA2VecGm/4O6ZBm8dADGu514nKA8jOyLprGyRZ3Y6IodGuLB29Q8E2dxIEY/X2vNaiHfDUML8cz4kolCVTOAhTGme5RlHju2HfVGhfeTzU6jQs3rvT2JZBVeIxSQQ1u73Wo7lyQDu5ahQX0tz1q1OHdo3ZeYh54Yoq7noqfPckElTAhY/aD4a1RJjxztmmTRmX5dnPjhOfR1/ggdT02AuOvZ7byp9CYIXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 22:07:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 22:07:05 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaA2fulhiwSXIJjU27xCEE2qMPErBXIG8AgABkzACAAG51AA==
Date:   Mon, 23 Oct 2023 22:07:04 +0000
Message-ID: <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
         <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
         <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
         <20231023153142.bes7zxcjc2soihsl@box>
In-Reply-To: <20231023153142.bes7zxcjc2soihsl@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4606:EE_
x-ms-office365-filtering-correlation-id: 13d85db1-2fc1-4120-8e17-08dbd414643f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: entBaYKBUK+7UPA/48QzTmhxO6CrZ3a/Tq2fPq3iYXd8INfGeVNXOXtiVmLU6mZWL+G4kyDDozXI9ZgVx2uBySql4zH/bY3XPpB7vGIZlWTgOXDDoLzNHRjthpfHOpCZBzHMZBuR7xYz7scpI5IJAfg1oLGpPWey/TqWr1eSvlPpRPDUQldp+ORqmHH8i7Qc2dIop19M4lXDi7ajcCjaW+j1Zayav+lEF8SIvvf4hq+jtdrBjwnvNNc4t1WM5vWPo01JlAvNyhDXe3oaVtb0mOSOLhTpawfT3S6P70JFJXR7l8gY+yttL8vg4CCfBk9mqsub5GYYXrFNat4NYQAXhruGMWnrd/OsFN/KzrY5TvfhxYlPE01qzYORLjDAN8IWl5cpA7H92dhm8pXni/CgRm7EKKLVDGneIFvCOsnCAiok8km6EWweShFUxwAM3r83ANqLbGDbx8nfRltz+UI7uVQK0ag4RsnjM6Pbgc28vr7O1rdgE7+/SdEsS6VLZ2nlDMd8l87B1M5lm8Q7EORc+dGxWGx3hjTyajucXNZqhCNiGZOFKnoU1+wZgaX9xIqnFB9MN4XpgVqkes6TVaCNSbbJKfS636aHUwT0lGRSrAioAq4DqI/lvJIBlMsnhlio
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38100700002)(91956017)(122000001)(6916009)(66556008)(66946007)(316002)(64756008)(54906003)(82960400001)(66476007)(76116006)(6506007)(2616005)(71200400001)(66446008)(478600001)(6512007)(83380400001)(6486002)(36756003)(4326008)(41300700001)(86362001)(7416002)(5660300002)(8936002)(8676002)(26005)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVPN0lPL3NjQUJiNmJQQ1Y1dVlJNGFkRlZhdFpPcjhZc2x1aHJTb3pEeEdB?=
 =?utf-8?B?VTViWXRxVHJlc01YMjRLOGxMTnFsbno3UlZYcnhDNkJVWWdXS1ZVN29jY0Zq?=
 =?utf-8?B?ZTZJTmtoWi9TVXJPTHlCdWV0aFZ3V1VvRXVqcHMwQTE4SVQzMkY3WDlQU1JJ?=
 =?utf-8?B?NDd3eGE4SUNwZElPVXBMMTU5d1ZKNmdZK0Y3V3dhdEdsYkcvbG1XRlc1Rmdi?=
 =?utf-8?B?TkgwNGFvb3hWTGZUVml4Y0pweWtJQ29vRUphS2RpUlRBbnpsaTZzdkJmdzh4?=
 =?utf-8?B?d0x1cHd6Nkx4d3U0eVB4UmhsU3lKZUIyYm8wVW1SRktWWDJSSW9YTnozVWlS?=
 =?utf-8?B?UnB3SnFzWFQvNk1xVHprdVptMlN1MFRsVkErMjRCdTg0S1loMEttRU5UdXJZ?=
 =?utf-8?B?ZDhkSi9rTndCTjNKZi8vdzZvNmJsbCtNMk53c3ZUSTBFbUgvSjlEMC9VQW5n?=
 =?utf-8?B?UWdSMnhDOHpEQUxQYi9HUzZ1cmRZajVnNDJnVkp2QmpRbFY3aWZxejRQam8r?=
 =?utf-8?B?c0dvMy8xNFdBbHZJc2ZJQW1qN1puNjdiaDBMQmcraFhDeVhBcHBPZFpjNHo1?=
 =?utf-8?B?S2hLaithM0x3UmtkM1FhWmdoQ05qbGhHd0l3RWgzamEvQlpiU1dCMWNCZU45?=
 =?utf-8?B?dHIvVmZUL2pYL0xNcTF6TTJJQ3k0MTFUNGVEL09aK2puNi9qWUhyUE9XcDhw?=
 =?utf-8?B?bkNXMkl5MFQrM1pwL2VsU21vWFBDdlV2NFFxQ2FueTJBdVAyM0xRN2d4N2pz?=
 =?utf-8?B?U0FlTzlMbFRCVGxwMnAvVXZNdG55SmJlOHNOV2ZzblE0U0RJS2NzM3dockNo?=
 =?utf-8?B?VHNQY0RyeldDVURpK1RQVFp6TytiMGk0Nm8wQ29PTlA1TWozRnhVaDgwdWQ2?=
 =?utf-8?B?b2RTczdTdk1pQy9EMTNYVjkyNEhIQlV1MjdZU1Y2ZzJKdFo3T0Qxekl5aDB3?=
 =?utf-8?B?eWJWNjdJSm5yRWc2NFVGWEQwVU9QUEprY0Z3REFpTXZnblU0WmpVdUl6c1VY?=
 =?utf-8?B?UENzWTBwTWwvLzk3LzY2RWxRUUVrUldoMktFbTdIM2lnNVl3ZFVuWXJQZ043?=
 =?utf-8?B?SzNxY2t4VXRvRkE4SjNoSDZja21tbDNUSGFyTFUrUTlHdDZ4bEVuVVNFNDFB?=
 =?utf-8?B?YkFqM21xY2NpayttOWdWcjRuc3kwZTJVMDRiRVk4am9nRWJOaWNmSldmSDlw?=
 =?utf-8?B?bnhzWHcza09oY3Y0SXFHNktBR3Vxdkg2QU51NHAvU1pPcmFHSy9SZ3dJTnlt?=
 =?utf-8?B?eVZyWEVSRVU3TlJCVnE4VnRhSEF1bmlUWmp3V0F1MEVya01KQ2EzaW1sTzQw?=
 =?utf-8?B?NGt1NGpXVlpnZnM3WXg5bitYb1B6SThJcFlMNnUwMCtkV3BzRnQrSExodW1n?=
 =?utf-8?B?clMxZndPbFhlUE40K2orSmRwdk9ZQjJzZUJ6QWVUS3NLd0ZEZERTV3g0MkNL?=
 =?utf-8?B?OGFTM295Y3lld0ZCUkVPQ3dsa3VTYmtSZmZSRlNOdHozZUlFNkM0VTd0blpp?=
 =?utf-8?B?UlNGM3NQNkQ2L2YvUGt4VlJYdTFhblZVRFA3TzRDczhWd2VsZi9vOTk0SlJX?=
 =?utf-8?B?WW13R01ubHkrR2tVRktOQXdmSFdOMUpNOTNpZWtiNC9LYnRYSzZPUlAxRU40?=
 =?utf-8?B?L2xJclRnV3poS2t6aEpwdnVTZkdCeVJDTkV2VTR3SzB0Wms4cUVZd2RvbEVC?=
 =?utf-8?B?QmVEdkJVMFdsYXg1a0svYWxaTzZqd2pQbVpUbVg2T3hpcnZnZVNtYmxKVE0w?=
 =?utf-8?B?ejJOeEtnd212R1ExVDVINjd6dGRzYlNXSVdyMWFNY1Bza0FsYjVSNXZNbHkz?=
 =?utf-8?B?Qm5aR0lmV0dzeWp4NzhRTUhuUnhjUzNRcGpPa1hRRTFVeG10S2JQemJ4dVgy?=
 =?utf-8?B?cWt4NFhSY3dUYVdxWWdCVzhQQzVja2Z5QkttekQ2d1U2SmNqejQyLy9scjRh?=
 =?utf-8?B?eU5MZm9UN1hVUGNIUEMxYjVSbzkzWWNjMktnZXg1Tk10YWlpTnQyNHZTN0Vx?=
 =?utf-8?B?MEdCR1RYRmxnL3UrWjE4bmVFUHA0S0FZTk1HeG4vSTh6OUdkc20va0YvZ1F3?=
 =?utf-8?B?STNwSnllNFkyb1UrQlhkQzVrcThEZThOTDNjd2NJK29raWlGb1dVVjNaMmhm?=
 =?utf-8?B?cEl2ZE1HNTFKSE9UU1U0djhIbGhaSGtkak55RENJM3lXSzV6Q1lURnRCUStC?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1AE6408115B01479CD1F4539083C91B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d85db1-2fc1-4120-8e17-08dbd414643f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 22:07:04.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5FZ1G83m/iz/CRxpVbEbBcOjnINQIT+OG8F+7yvU+265kvLJFZW9qOXbn+AuyRGbd7vMWzmF7MY1uSdM8Lqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE4OjMxICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAwOTozMDo1OUFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IElNSE8gaXQncyBhIGxpdHRsZSBiaXQgb2RkIHRv
IGhhdmUgdHdvIG1lY2hhbmlzbXMgaW4gcGxhY2UsIGV2ZW4gaW4gdGhpcyBtaWRkbGUNCj4gPiBz
dGF0ZSBwYXRjaC4gIElzIGl0IGJldHRlciB0byBjb21wbGV0ZWx5IHJlcGxhY2UgQ0NfQVRUUl9I
T1RQTFVHX0RJU0FCTEVEIHdpdGgNCj4gPiB0aGUgbmV3IGNwdV9ob3RwbHVnX29mZmxpbmVfZGlz
YWJsZWQgaW4gdGhpcyBwYXRjaD8gWW91IGNhbiBleHBsaWNpdGx5IGNhbGwNCj4gPiBjcHVfaG90
cGx1Z19kaXNhYmxlX29mZmxpbmluZygpIGluIHRkeF9lYXJseV9pbml0KCkgc28gbm8gZnVuY3Rp
b25hbCBjaGFuZ2UgaXMNCj4gPiBkb25lLg0KPiANCj4gSSBjYW4uIEJ1dCBJIGRvbid0IHNlZSBo
b3cgaXQgbWFrZXMgYSBkaWZmZXJlbmNlLg0KDQpQZXJzb25hbGx5IEkgdGhpbmsgdGhpcyBpcyBi
ZXR0ZXIgYmVjYXVzZSBpdCBpcyBvZGQgdG8gaGF2ZSB0d28gbWVjaGFuaXNtcyBpbg0KcGxhY2Ug
ZXZlbiB0ZW1wb3JhcmlseSBlc3BlY2lhbGx5IHdoZW4gd2UgY2FuIGF2b2lkIGl0LiAgQnV0IG5v
IGhhcmQgb3Bpbmlvbi4gDQpVcCB0byB5b3UuDQoNCj4gDQo+ID4gT3IgSSBhbSB3b25kZXJpbmcg
d2h5IGNhbm5vdCBqdXN0IG1lcmdlIHRoaXMgYW5kIHRoZSBuZXh0IHBhdGNoIHRvZ2V0aGVyLCB3
aXRoIGENCj4gPiBwcm9wZXIganVzdGlmaWNhdGlvbj8NCj4gDQo+IEJlY2F1c2UgdGhlIHZlcnkg
bmV4dCB0aGluZyByZXZpZXdlcnMgd291bGQgYXNrIGlzIHRvIHNwbGl0IHRoZW0gOlANCj4gDQo+
ID4gQnR3LCBJTUhPIHRoZSBjaGFuZ2Vsb2cgKHRoaXMgYW5kIG5leHQgcGF0Y2gncykgc2VlbXMg
ZGlkbid0IGV4cGxhaW4gdGhlIHRydWUNCj4gPiByZWFzb24gdG8gcmVwbGFjZSBDQ19BVFRSX0hP
VFBMVUdfRElTQUJMRUQuDQo+ID4gDQo+ID4gCUN1cnJlbnRseSBob3RwbHVnIHByZXZlbnRlZCBi
YXNlZCBvbiB0aGUgY29uZmlkZW50aWFsIGNvbXB1dGluZw0KPiA+IAlhdHRyaWJ1dGUgd2hpY2gg
aXMgc2V0IGZvciBJbnRlbCBURFguIEJ1dCBURFggaXMgbm90IHRoZSBvbmx5IHBvc3NpYmxlDQo+
ID4gCXVzZXIgb2YgdGhlIHdha2UgdXAgbWV0aG9kLg0KPiA+IA0KPiA+ICJURFggaXMgbm90IHRo
ZSBvbmx5IHBvc3NpYmxlIHVzZXIgb2YgdGhlIHdha2UgdXAgbWV0aG9kIiBkb2Vzbid0IG1lYW4g
d2UgbmVlZA0KPiA+IHRvIHJlcGxhY2UgQ0NfQVRUUl9IT1RQTFVHX0RJU0FCTEVELiAgRS5nLiwg
b3RoZXIgQ29DbyBWTSB0eXBlIGNhbiBhbHNvIHNlbGVjdA0KPiA+IENDX0FUVFJfSE9UUExVR19E
SVNBQkxFRCBpZiBpdCB1c2VzIE1BRFQgd2FrZSB1cCBtZXRob2QuDQo+ID4gDQo+ID4gVG8gbWUg
dGhlIHRydWUgcmVhc29uIGlzIHRoZSBuZXcgTUFEVCB3YWtlIHVwIHZlcnNpb24gYWN0dWFsbHkg
YnJpbmdzIHRoZQ0KPiA+IHN1cHBvcnQgb2Ygb2ZmbGluaW5nIGNwdSwgdGh1cyBpdCdzIG1vcmUg
c3VpdGFibGUgdG8gZGVjaWRlIHdoZXRoZXIgdGhlIENvQ28gVk0NCj4gPiBuZWVkcyB0byBkaXNh
YmxlIENQVSBvZmZsaW5lIGJhc2VkIG9uIHRoZSBNQURUIHdha2UgdXAgdmVyc2lvbiwgYnV0IG5v
dCB0aGUgQ0NfKg0KPiA+IGF0dHJpYnV0ZXMgdGhhdCBpcyBkZXRlcm1pbmVkIGJ5IENvQ28gVk0g
dHlwZS4NCj4gDQo+IE5vLiBNQURUIGlzIG9ydGhvZ29uYWwgdG8gQ29Dby4gSXQgY2FuIGJlIGlt
cGxlbWVudGVkIG91dHNpZGUgb2YgQ29Dbw0KPiBlbnZpcm9ubWVudCBhbmQgQ29DbyBwbGF0Zm9y
bSBjYW4gaW1wbGVtZW50IG90aGVyIHdha2UgdXAgbWV0aG9kcy4gSXQgaXMNCj4gbm90IHVwIHRv
IFREWC9TRVYvd2hhdGV2ZXIgdG8gZGVjaWRlIGlmIG9mZmxpbmluZyBpcyBzdXBwb3J0ZWQuIEl0
IGlzDQo+IHByb3BlcnR5IG9mIHRoZSB3YWtldXAgbWV0aG9kIGltcGxlbWVudGVkIG9uIHRoZSBw
bGF0Zm9ybS4NCj4gDQoNClllYWggc3VyZS4gIENhbiB3ZSBwdXQgdGhpcyB0byBjaGFuZ2Vsb2cg
dG8gbWFrZSBpdCBjbGVhcmVyPyA6LSkNCg==
