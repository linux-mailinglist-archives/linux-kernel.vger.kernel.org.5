Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC277936C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHKPoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHKPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:44:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856A120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691768652; x=1723304652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o3GBkO1WTkdsmX/JLIq1WpL9g9fR1a+AhFynhNDVd/E=;
  b=hagwYTPC/ALIb8zudQWPzpT8Cu3OYN9NPqydqqSuqJld7/MB85ImkkJK
   j6wjfAtHwxDQ0Xus+oJ0Nw4ICYkbFZYnjxle+j+rj9AWW/jKtgWlvtJGf
   JuRBaXlId6pTIauBdX2O8ejVbZtC1j9HgRUUVTqiyCFWzYBcSiktgGnVl
   ov58QqzNWFGC6z17DX/UwsGXh+B26Ubgv7qkn8tfkCJe1cna4pd8+Pc0L
   Qnlb02VjdppUVr82SHDbIL5H5fNDTS+9JIxlJQMM+sGtGBJeerlQlS2qL
   /Al+ViRjaxw9+NLWnyl50Ba9HJJyhLSnqc5gAGi+gXV3OLd8aS088OncE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="361844401"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361844401"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 08:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="732703772"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="732703772"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2023 08:44:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 08:44:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 08:44:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 08:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG+1M5pK34KKc1yXc682oSlCjJTcTbjdYSVw73/o+G9/n9BbGT6PbXrjLkZnl5uI9Hwu9H9WeADZhiGllJBe3aVSagsF1fVMY4rU52UhUkD1PR4v9w3bc6GmfYXe1jSp2xRo1h1djTpBOjh3Ivv0IghXw3yQKP9o6tIDSlbyhx8XeqOm1K7/b05C8r0Qlkcn0YzPWRppRifjerTLuz12hesMmsW2ltI8dhVcXGVmF1FnG5T+r8GlRG9DJCF4stQ5dhg4VgMO5/r5Z0R8n9C/qDUfOe39fmVG85f+dUUgNH9BkDu8hD1UhBiKE+TZ/S9qi7T/krCLFZAw78CeEiDk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3GBkO1WTkdsmX/JLIq1WpL9g9fR1a+AhFynhNDVd/E=;
 b=VB4pQhyKeYugHIUCFwqXYP4jjS8weqBArcsZosCR0niHLs6sk7nXuk9rmkK17dFe+Zo2V/P746HwpNX+NQ815aKFcx0jb358xmRI5bZp8DARBaDXecq5LakluqAm1rQczIB1b6Y49ec+Xjcl5GfcDT8fOEFu7UcENrVnPvE4LKPGbv4cwJwqqkxZifZiCGJ5xDid48PPYYRZFkNfvqszv1NCLZ3y+IifKblhAO58GwcMVV5GxCmt3E/h2CuKKyXHDRyzVcJrQqOCxTsM8pf9AbFCEqH9Yd37PAXqYqlZvewtI0S0MZM+w/vzLRgf+UD9zJ4Wb2E7/g1nx0fJ3NcipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:44:07 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 15:44:07 +0000
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
Thread-Index: AQHZyTasQxDpAFZd+EePyA0yH6z91a/lQuIA
Date:   Fri, 11 Aug 2023 15:44:06 +0000
Message-ID: <81477dd06925117667ed9c53a89403ca6e69973f.camel@intel.com>
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
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4604:EE_
x-ms-office365-filtering-correlation-id: 7c38fdc4-2afb-4c03-595f-08db9a81cc28
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wH0ssLc49Kb+XWDemLYe76QBKOYuGJNWGTQr3/VcbkoMSXTfWcewMbTQ2aQ2IrkPsx7N6/78aE3Q5CU8UqL7KREhk4FbR4X/QDKCBVL0eFOVzlA15VqQEnmS02OgZD1yamySWx30Q3LWnMmTah+hzlxu1njfqUK6R7+xizJJO3Y/x1sbSFvLi3YezZOLBNK7MfEJgw1B+Ti/Fe9vkEAuZbQaO6Jm5j3/YR9JRIJ1GCtnuk7ypdQ5Ae0Ltiwwt+E6KWRlmA6HLly+ArXN4cVz421sirLIF73Y4HyxPVvs4UwlPuYhMgFhZP83vyxYqU0ZgScTndGYgKtaOs06BbSpLZWUn1AOBiImmMymfyjfZEoqkoTgFc4i8oevT1Ew1lHEABSzSrGIXEuH9sbmXfhoPyoScatHH6gDddCo7Llr8KLSSDzGDN9/6U8+P3bxJvM9Je/UYIzgTVbjbtetTq1RNoPhUiY6/jaYwxyqaIde85XXA1sClDPT2ZYRqodk4XB/udckPM8VUBmz5G9xogibF2MOIWDvjalgV1eOohosyiNtXUgcWyhxTz05YGyvtKuiZtp5a1PpjKFrP8GLCcSrBkgYQg46+eFFwVUoW7MdkPOHOlZxa+JMYt80CshHlNLPLyGbz6j/a4+sZ8tBMZfmNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(186006)(1800799006)(54906003)(478600001)(71200400001)(66446008)(110136005)(26005)(4744005)(6486002)(6512007)(2906002)(6506007)(8936002)(7416002)(91956017)(2616005)(316002)(8676002)(4326008)(82960400001)(38100700002)(64756008)(66556008)(76116006)(5660300002)(66946007)(36756003)(66476007)(38070700005)(122000001)(41300700001)(86362001)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzYzbmpUL1RKc2dDYk1OZzZZb0Y3bEl1YkNsLzNNNHRiUk1uRVppR1ZMelFZ?=
 =?utf-8?B?bGZFZTlsV3UxVm9JVVZLL3NLaWQ1S0Y0YWxXUHpJUzR3OWxzSGN3YUhoUU0w?=
 =?utf-8?B?MVJkZzdIS21LZi8xS0ZOZlhYRUp3SnArcklubE93N0ZjamMrNmM1MmE1TlFJ?=
 =?utf-8?B?d0FLMDQ1ejlVTVluZXZ5UTl5U3dBMHNaQTIxV3hMcnNtenhNZzBwSTlxMHZH?=
 =?utf-8?B?cFliVmV0bC9MdFozTit3TFBJSEZlVHhvYVpYVGU3TDJUNkg1cmZyVkoxazFM?=
 =?utf-8?B?azhsbXVSRUU3RUFFMUJlMmE1M1pkM0tBVVVzUCtkUUt1Mm44TEVhRFN5UW94?=
 =?utf-8?B?ZmFUMC9KSWs5dDlUNjZ4UGltQmh0R0RwVWp3T1paTm5QQzJlL3d5TUhaL1Jn?=
 =?utf-8?B?SWplclJ1b1lDNjRlbFJKQjNKVHNhY1hQU0JZazlNRldOR3lwUTBOM285L1lh?=
 =?utf-8?B?QTR5dnBzeXYwSkN3TEJxQ3hZMHFiZGxveDNmSW5GWmN4TXVxV2c0L2VYSWRB?=
 =?utf-8?B?dlJKQUlGdHB0TXlHcjFGME9rZzVEUE41ZjJRaVhLODU2b0ZiVjJ5a1BkOElz?=
 =?utf-8?B?NFhsQzlLN2lrV3BXRENGdU5jNDk0ZG1IVm1sRG84Rk9lUWpzQnZCSnJJNC9W?=
 =?utf-8?B?NDgveDJ2WGdUWWJtTkpXOFV5bjgwN01KQ2xmYVBKR2t5TXF5MGdNR0lqaVpY?=
 =?utf-8?B?VWkyV2VJaFBnOGVqREZFSDdLdFZuNjdSdjB0RGs1RnlUN0QxZ2k2WG1rVmxR?=
 =?utf-8?B?QWF2Qm9WWStwRTJqaWRpcmdGeFdMUWJzcGV5aGx4Z1VLalJSZjVybDBBdXdk?=
 =?utf-8?B?bkZ3b05PL3JTV0FHS2tFaEcrRXFQY3VSY215QlhzNUhwOG1ZQ1U1VDhKOEdu?=
 =?utf-8?B?V1NZa0VHNzV1UVRyT0lIMFQvcktDUlp0VjBqVVk5YnQvUTkzWGwxWWtqbGs1?=
 =?utf-8?B?OGsyOWQyOVZrOUx6YTBUd2xubmkyODByRmlUZStTNXp3NllkdHg0UjBOVEtP?=
 =?utf-8?B?cHZWWkRtbGZ3dkp2VDR4SWlnYmVIRFNQTk4vUnZaSDlBWWRnNTdWb01ud2tV?=
 =?utf-8?B?S0ZyWWZ3dmVid1QxNGQ3Ly8vWEFveXVGbi9tSDdXSXdFQnhNQ3g4bXJGcWc2?=
 =?utf-8?B?eFV1UlpUYi9JRlJRV3ZIL2FlanRIUitIT0RUS24yNUdESGo5eHIvcTl6VmNE?=
 =?utf-8?B?R0g3cnJobXN3LzZmL01DaDE5SHZXbFVXU1RnTTZQNzlBKzRydlNZb2JxaU9m?=
 =?utf-8?B?RnBOYUZNUGZjd25sSlY4UmlBOGtKTkNmMlJIazBZTjBKUitzVDhWNmhNcUhZ?=
 =?utf-8?B?YzREU28rRWpqZ2hEeVdZUmNrdm1XMTdTSGx2aDZ4ZGZzb2RreHlsaHdzSDBY?=
 =?utf-8?B?cEp2ZHo5dWh0SkR4YXJ4VVhLTUlLaXBXWWFsWVA4QzdJQWRMRjBHWkFRakxi?=
 =?utf-8?B?T0dRb2xHam5iWTVWenJlZU1ES1dWd09lMFJuY1RtbldsaWsycjNGa095dVZD?=
 =?utf-8?B?L3dsL21IRTRIQ0dhai84M3FycnlOVGlEdjlQa2g3WWx3cGVkMHM5ZzJESzRy?=
 =?utf-8?B?bFNZVFhKbTZrNmYrc2JQREpKWUhRcjl1UmllV1BHcWw0YUp1QWNaeml1RU1l?=
 =?utf-8?B?ZjNMdElmQ1Z5bXNBMnlLMVhmbS9VVVR3NDd4TGtWTXVGdEVZM1hjSFlNckFW?=
 =?utf-8?B?NTFndjMvM2Fnbkc3c1BNRWZOUW1YdzZBSVdpUEZ4cTlJQWVTeTQ0SkhuK243?=
 =?utf-8?B?THNJZm9yblpNV3FlZU5pdTVYWE5Zc2VLOEd6Ny92T2hZWXdrbzY5STdvbDdM?=
 =?utf-8?B?eGUvamtPbXBnUkNQaEZTaWVBSGFNbjdrMHBUMStyVDRXWlFmcVB4UGIxS0Ez?=
 =?utf-8?B?ZUZ2c0ZiU3BPSThyMTZCQWZWcjBBbWhQWjlzTWYzNTNNamhndXpBaGRDTHFu?=
 =?utf-8?B?Z05qWmdHY2ZaVkJXTHhNZjFMZjYvWEh0bExqQ0toUkxWR0RPQzkwZXdoRTA1?=
 =?utf-8?B?M01pQTJyNmJGTml3OFBWcVJTM3puUDFRNGJXNlF5VUZEM1FYb0lWRlhRc0V4?=
 =?utf-8?B?c0FORzFab1Q4czROZHJMcTlyZlpWK25va1ZSZnRyTXNDU0VqTndJSXZTQnla?=
 =?utf-8?B?Y3prRFJEQkZ6Lzh1V1IwVzVlSjJBR0V0Nm9XQ2VUdFJZRmVqYWZvV2pBSlZ1?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F61EC6D813A894EBFBA5CB806E10969@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c38fdc4-2afb-4c03-595f-08db9a81cc28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 15:44:06.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA+60vXz8HRwpKKk1UCmwuSWTcCAFAk3ZjNYEUZU1+xxvAprAr9jEXR2ybfR6RUX9GTteogDC3H/8h40A/Qnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9zbXBib290LmMNCj4gQEAgLTU2Niw3ICs1NjYsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYnVp
bGRfc2NoZWRfdG9wb2xvZ3koDQo+IMKgdm9pZCBzZXRfY3B1X3NpYmxpbmdfbWFwKGludCBjcHUp
DQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBoYXNfc210ID0gdG9wb2xvZ3lfc210X3N1
cHBvcnRlZCgpOw0KPiAtwqDCoMKgwqDCoMKgwqBib29sIGhhc19tcCA9IGhhc19zbXQgfHwgYm9v
dF9jcHVfZGF0YS54ODZfbWF4X2NvcmVzID4gMTsNCj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBoYXNf
bXAgPSBoYXNfc210IHx8IHRvcG9sb2d5X251bV9jb3Jlc19wZXJfcGFja2FnZSgpID4NCj4gMTsN
Cg0Kb3IgdXNlDQoJYm9vbCBoYXNfbXAgPSB0b3BvbG9neV9udW1fdGhyZWFkc19wZXJfcGFja2Fn
ZSgpID4gMTsNCj8NCg0KdGhhbmtzLA0KcnVpDQoNCg==
