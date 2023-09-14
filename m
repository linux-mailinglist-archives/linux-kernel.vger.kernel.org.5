Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5479F5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjINAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjINAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:46:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEC193
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694652360; x=1726188360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AKsy33xkFNTrLW0F4ZgJd5DNbjvWfC8VeA38dV07T3c=;
  b=AVfOZgbG/NPTyA2L4xF1m0bmCAg5yPR0RGnhf+ryWCxrPOUrl1t1gLKl
   f0W8ayfqZEEJtLvmDPvrWNkXVc0m7Kgihy9MIhG6s88tBprDKLErKlNF+
   xfz+1fxZ1I3useCnJGgrPICsRxVOGZ/QW33TE9BRtkr5gguQEz84lL2in
   Ma5Ip028rMhftX5j25cqkWjcsnXC3c46VZ7hvIsWiFqIXVUg7RQm0Cvfq
   jNRxh0ygLzuvGw80IgLmCi4pnbd5Z3T4DME0NbBKH29HhRPhTpu7XvhPt
   0eBFpcbSUUTF8mg1G5f8dzYWez3H4X8qgihacy8B6F25vJRLm4BcDM5Br
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409775824"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="409775824"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="834538757"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="834538757"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 17:45:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 17:45:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 17:45:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 17:45:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 17:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilWBhKv0yB4tyQqrpuVON8ASS9Cd2o2U2YaS+iQT1AEtFAo84JWi41AIIQP0vGZFKG1G1j8beGMjcpD9fpUKc+TkreJyB6K6x68II7N155yjvI8ePe9A80LATC3gORsEux49Svm8zwwYk03sjHDXhuNbjlxRGWof+IfV40GhsP15kKspFCU4GGYunLGA6bZSRVaZ6xqC+y1g4lYILlPKH4l4QlKewmWDWCmcZ56MT/gfIBgiYCFLlPu5MB5Dqgt8v5ZRwWwF+7M5ldYQHL2k7qp2GRkEPDg31vOP6lCqtEEE5WgsreiptAWuiOYlLmNKLTaoJyKwg/SgZyamlyI0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKsy33xkFNTrLW0F4ZgJd5DNbjvWfC8VeA38dV07T3c=;
 b=gOrDZoeyxD6wYD8CXNbIvOXTTqP409rdB0ta7//F+odjHDFo5fYhvzzdQZ95W6ptiRhRedvM/O8ZAerlNIyGcoADbnOC/YWomqPra3zYjjgVTTehZ7ibNjlHF8uGj5OSeKuF/+m0WRRjR4NsWKkn/okI9/lyYW5MHn42tFlqCnI5dPQytyBFojv681y5Xhjld+VOtXojDON/iKICK3xIPLQjEw2o9/ojMiFRDPzmAq7FJXJqlLywd+lCfYtfwpNoN0Due8T1aEhG6YOqTopXpLx121PKYS0rnHhVuFzyrB7Eem9fPZqxLFrq1yOIiLQ8hX70/myKWdk1mUq0+pYRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 14 Sep
 2023 00:45:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 00:45:50 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZz2d2h64fZccrFk6GvcmTUnLRhLAM+vwAgAypa4CAAAZRAA==
Date:   Thu, 14 Sep 2023 00:45:49 +0000
Message-ID: <4f4c7f4085cffd63c2548ef6dbaa7857e8bbbc89.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
         <20230914002255.GC3638268@ls.amr.corp.intel.com>
In-Reply-To: <20230914002255.GC3638268@ls.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB7205:EE_
x-ms-office365-filtering-correlation-id: f28880f9-613f-47b4-2b76-08dbb4bbf11c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nS/uqDxJYqU07/5daQsqsMh99PF+diJpuSu1Sc+RORB+s0EVqa/AEDzQcL0BbR5vQHC7A2AvH0KhaZlufDhEwGT9k+Rrz3OcL8GW3GOMFL6Z8G4yEOQYFy95crgdonUb0lCR5ya4/2G8Yj13HFDnt5T8hwONIfoRhCtJG0utvhdJ1IpXNMrmEaHg0j9n4+kxIIvltlOYlNFdCWFloj1J3d8NSr5dd0tonPyYM36jSsv6giGtWEJp2fzrEyboU6GFSpVO9VKPXz971n9jwXGtM7dcvZhgWIG4nyEoDUJRKPKNvBKc/dO0CwkAtheF0pjYeb37q2udefYh0I1fGTx5eIueKvOVFankTkkOH/Y/5cBnfXCEmv+hP9voFuEq6t0u1Od+rJXz/LX0pNYcIa/InIJCmFRMWQY672LrfDQQK8QpnEpfN2nn/m/1MPGAU7ZzqFtdnlmgC3bNYS5n04qTHMA5tD/Qhj5qEw3WCzLUd5XHyoinrkVGpRQYc5bgnuYmfZQXdFltfVkzzZIKfY1cwd3yOgw+px9l+yLofbkY97OHuCa8dsSjQYc8NMuwy0iEyKs6Cx3kVDz+aH538Yjvx0XuOORI0DMoSVsRW6qcZbxcIx/GHNuuq0DMQgrTQmJ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(38070700005)(82960400001)(6512007)(71200400001)(6506007)(6486002)(4326008)(26005)(54906003)(2616005)(86362001)(7416002)(5660300002)(2906002)(76116006)(8936002)(122000001)(66476007)(41300700001)(316002)(66946007)(91956017)(66446008)(36756003)(64756008)(6916009)(66556008)(38100700002)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlYyajNXcEhuWi9Xb0x1aHhEN3JEci9XMWplVFpERFExdlFLZXdNczh3M1Bk?=
 =?utf-8?B?bHAydWM2NkRZVm0wUy9lQ3FwWjcyUnk0ZXppZ05PQzFySHpBUnozaktBU1R0?=
 =?utf-8?B?ajVPdGJ0YWNzaHFTOHQxd0lqdURDTU9FaG9IWTZEVjdpL3YrUEN0S2lzNEt0?=
 =?utf-8?B?ZGluK1VRMHd3SDRPd3NtYUNBbkxNODJreDJIUWltWHJVUzRVOVdXU2lWRWlj?=
 =?utf-8?B?YUlGd2VPdGc2b1Y2TGdqcVRDNGN5WFpkajhadklaS1J3dHVqNDlBamxkM240?=
 =?utf-8?B?NXdUc0ZDeFNXaXB6RWNlaUN6bzJSQ0VxWjMyeDMvdWlqOTZHNnRmcnBVVXEw?=
 =?utf-8?B?UkFxRU5NWXVzWWRKc3FBYUdvK0dtZm4rUDllZ2JsVWVCcCtNeHNsZ3d0OFFm?=
 =?utf-8?B?Q21DWHVsQ01DcEpLWmVlWlhRblNkeG1PdWlQamoxY3c3djljYlBEcklsRW9r?=
 =?utf-8?B?QUZYbllpWUZVTnRKRjMrcG5TN21kM3M0cjZJWkJUWUJJYTlLUmI5MjNaRG9r?=
 =?utf-8?B?NC9Ec3RwYWp5dHlvM2Q1QmxOYkNsVDAzZk5mM1BVK2ErTG82Z3dsaFdWRVJz?=
 =?utf-8?B?VUJUYkJFY3c1N0JiMkdQVFR4b2VWTEhtbEp0Z21WbVMxcVl6ZERrMytzRFB1?=
 =?utf-8?B?Q29qY3ExZkNmbFcyeEl6TVA0SzRLQUJWeXo2M09ZbTIrZWJrUUpNOCtkQ3VE?=
 =?utf-8?B?WkFGNmRHV2Rxem4rUlRoVFVTS01kR1VHSk01UDk3cG5qNHhlby9zbkMydkQ1?=
 =?utf-8?B?alBkOE1LNW5RclhzcDdIbm1GUWM0V0ppblBXME55K0NoUWJRY3F3c1graHJo?=
 =?utf-8?B?RVVqeWpwaUJHemFId2hEN0g3V3RsbFcvaEpLMExMZHkrTWFnejc5aGl6OGJ5?=
 =?utf-8?B?Tjh0REIvRUQ0c1cybnlDSWY0ZjdhcGxFNVZLNk44b0hBYjYyZ28xVDQ2OW8v?=
 =?utf-8?B?ak80M2ZwcFdIcHErd3JNTUJvL1FCS0lqUVJDTEZ6dXVhL3JKY2o0ejNPV2dj?=
 =?utf-8?B?QTd4SEFWZkI1ay9RT0RPU3hwN3BpZndEMjVSaUh5dFNnekVlQmlyMmExYytR?=
 =?utf-8?B?cDZsNlNwTDl6akxQMXk1SVJ1UjZrVVRUcVVuNGVkZVB4VGwvaVVYeTg3WGM1?=
 =?utf-8?B?eFo0T2RMZFRnRzNYVk5GT1hnTVIweFgvZGttUHBBNFRJTXFxdVUvcFc0QUdY?=
 =?utf-8?B?b2dzcGY1MTk5MzIwdGZuMzZIaUpJazNTdW9XSEdHSzdpaUVZSjNPbG9keUlG?=
 =?utf-8?B?YXBucVJMUE91ZHA3WjZKd1JNV0FWTVJUTWVDeGxZZjVCS3JRUy9PVitTRkRE?=
 =?utf-8?B?Nm1ISTQ3STlHb1NPcDgxVVo5QkNScVcvbEFOU3Rnc2ZhbEVYWWY2cjZzZHB5?=
 =?utf-8?B?Z2tvYTZOZS9KS2d0OE4yc1ZSRGFnWWQ3OCtjZmYxVzZZNXhsaS9UdEkxZmFx?=
 =?utf-8?B?ZnBMeUhNMGJhOEZ0YlAzNk1KWnlUYWpWekFkMExBYm1qMEZMNzBiVTlNT2Zr?=
 =?utf-8?B?cE1zWGdmWURzMklWWnovUDcybVhNdDFYdlRiTkJmYXhVa054K0J4d2UrTHlo?=
 =?utf-8?B?Y0QxU3dGaG1pNDdMeWtWOEJLQmVRN09rdmdaMzBSWU1zTE95TTVzV3pzUU5R?=
 =?utf-8?B?NHBHUEJYdVlqZjF6OVJmRit6LzlCMzVXQ25BOWxKZS9Ia1hjclgzYWdFMDZy?=
 =?utf-8?B?cFNjVEgzS0dHTVlKdTZXbDBsR3hCYU9sRHd2YXdsQnovV1JRQ2hQYWxNdVJi?=
 =?utf-8?B?NnpUdnlldDVUWC9oenNzMW0vT0xDVW9qck5pK2JMb3o2MENuZUFaSElZdnN5?=
 =?utf-8?B?RXFiZTdZRWpaU3ZranM1NVpUYm5DbzhQWERoQ0FDN3llbTNNSVpqakdRNUlH?=
 =?utf-8?B?UmZ1UG1NOHpwY2psRmlQSFR0ckMzTS92b1NpRHlYWDRQZnhZYzhobkJoTG5R?=
 =?utf-8?B?V1Vza0N4NjFsTGxGVlRKQ3dsOVpZL0xOT0h1TGhJeHJ5TkxzL09ib1o0eGtt?=
 =?utf-8?B?UEFnMUNiRWlZblkybkhxWE04M1J4d0xaTnNkWHNBbnZjKy92bjcrdGVhMXRI?=
 =?utf-8?B?SjY0emttYUE5UGhTNEFMK0ZpQ3p1cTlYRVc5T2FydjczMUNGcHg2bTRpMktp?=
 =?utf-8?B?ZXhvcnRHNFhVUkNBbnp4ZmJvWWsxcnpNYS9odllMaHZBQSs2dm5TeFlPdHJq?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD0AE0F9AC2C2446AA36FFC4F1D605B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28880f9-613f-47b4-2b76-08dbb4bbf11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 00:45:49.9899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9sGL6DWgei2LwhI3RrHDdxi23ftEtkoizil2Lj5/PcRx4wsnwwzEMw1HxNC2pixnQuYgHIc/6G/p27hw/Wv4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTEzIGF0IDE3OjIyIC0wNzAwLCBJc2FrdSBZYW1haGF0YSB3cm90ZToN
Cj4gT24gVHVlLCBTZXAgMDUsIDIwMjMgYXQgMTE6MDE6MjhQTSArMDAwMCwNCj4gIkh1YW5nLCBL
YWkiIDxrYWkuaHVhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gVHVlLCAyMDIzLTA4
LTE1IGF0IDIzOjAxICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiBIaSBQZXRlciwgS2ly
aWxsLA0KPiA+ID4gDQo+ID4gPiBUaGlzIHNlcmllcyB1bmlmaWVzIHRoZSBhc3NlbWJseSBjb2Rl
IGZvciBURENBTEwvU0VBTUNBTEwgYW5kIFREVk1DQUxMLg0KPiA+ID4gTm93IGFsbCBvZiB0aGVt
IHVzZSBvbmUgc2luZ2UgVERYX01PRFVMRV9DQUxMIGFzbSBtYWNyby4gIE1vcmUNCj4gPiA+IGlu
Zm9ybWF0aW9uIHBsZWFzZSBzZWUgY292ZXIgbGV0dGVyIG9mIHYyIChzZWUgbGluayBiZWxvdyku
DQo+ID4gPiANCj4gPiA+IFRlc3RlZCBieSBib290aW5nIFREWCBndWVzdCwgaW5pdGlhbGl6aW5n
IFREWCBtb2R1bGUsIGFuZCBydW5uaW5nIFREWA0KPiA+ID4gZ3Vlc3Qgc3VjY2Vzc2Z1bGx5LCBh
bGwgd2l0aCB0aGlzIHNlcmllcyBhcHBsaWVkLg0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBI
aSBQZXRlciwNCj4gPiANCj4gPiBTb3JyeSB0byBwaW5nLCBidXQgY291bGQgeW91IHRha2UgYSBs
b29rIHdoZXRoZXIgeW91IGFyZSBPSyB3aXRoIHRoaXMgc2VyaWVzPw0KPiA+IA0KPiA+IEJhc2lj
YWxseSBLaXJpbGwgaGFzIHByb3ZpZGVkIGhpcyBSZXZpZXdlZC1ieSBmb3IgYWxsIHRoZSBwYXRj
aGVzIGV4Y2VwdCB0aGUNCj4gPiBsYXN0IG9uZSAoQWRkIHVudXNlZCByZWdpc3RlcnMgdG8gJ3N0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MnIHRvIG9wdGltaXplIFZQLkVOVEVSDQo+ID4gZm9yIEtWTSks
IHdoaWNoIGhlIGRpZG4ndCBsaWtlLiAgQnV0IGl0IGlzIHByZXR0eSBtdWNoIGEgc3RhbmRhbG9u
ZSBvcHRpbWl6YXRpb24NCj4gPiBwYXRjaCB3ZSBlaXRoZXIgY2FuIGhhdmUgb3IgZHJvcCB3aGVu
IGFwcGx5aW5nLCBzbyBJJ2xsIGxlYXZlIHRvIHlvdS4NCj4gPiANCj4gPiBBbHNvIGZlZWwgZnJl
ZSB0byBsZXQgbWUga25vdyBpZiBJIGNhbiBoZWxwIHlvdSBvbiBhbnl0aGluZyB0byBvZmZsb2Fk
IHBhcnQgb2YNCj4gPiB5b3VyIGxvYWQ/IDotKQ0KPiANCj4gQmVjYXVzZSB0aGUgb3B0aW1pemF0
aW9uIHBhdGNoIHdhcyBkcm9wcGVkIGluIHRpcCB4ODYvdGR4IHRyZWUsIFREWCBLVk0gY2FuJ3QN
Cj4gdXNlIF9fc2VhbWNhbGxfc2F2ZWRfcmV0KCkgYmVjYXVzZSB0aGUgYXJndW1lbnQgZG9lc24n
dCBtYXRjaC4gIFRoZXJlIGlzIG5vDQo+IHVzZXIgb2YgX19zZWFtY2FsbF9zYXZlZF9yZXQoKS4N
Cj4gDQoNCkkgYWdyZWUgc29tZXRpbWVzICJvcHRpbWl6YXRpb24iIGlzIGJldHRlciB0byBoYXZl
LCBidXQgZnVuY3Rpb25hbGx5IHdlDQpjZXJ0YWlubHkgZG9uJ3QgZGVwZW5kIG9uICJvcHRpbWl6
YXRpb24iIHRvIHdvcmssIHNvIHN1cmUgS1ZNIFREWCBjYW4gdXNlIGl0IChvZg0KY291cnNlIEkg
d2lsbCBsZWF2ZSB0byBtYWludGFpbmVycyB0aG91Z2gpLg0KDQo=
