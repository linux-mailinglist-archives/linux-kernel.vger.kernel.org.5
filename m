Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D30801A22
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjLBCxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:53:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D2D48;
        Fri,  1 Dec 2023 18:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701485620; x=1733021620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kSgG0B/bYp43ulAEJh2eOzHdAqcccLVRtY8uoX/YBWo=;
  b=XAeXu6QK04AVw4ZDvppOv2tfgvF6yhI86dJqGpFdVM1dN8KSbYSkpqc7
   9ozGa/qT6+l/BJjPZ4uSzdmrKGJ/WMFWzqq28s+lKOyZWfvy3A5yPTzT0
   CL4sZHNGXf+J0BLPMZ6tqvcgxNTkbKRcQHHVwXS+ozCH6eHSCGkfDacxx
   R8I3KpEJrjux3bOs40TpN09Dij70rVWxhS2x2sGZrWKOCjSC1cioGwbol
   /hXgWJE7h/jQbstIUuKRT2nuGlcv4Vk/4ON0FOMeKFAqw6Il3WEPUl/Dc
   +auSIMZ0EHuMpUWHDKwm+IdrP8uJilin0zrNzIKBT69XSRUh35F6uz50I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="457896553"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="457896553"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 18:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="746198592"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="746198592"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 18:53:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 18:53:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 18:53:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 18:53:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 18:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI+XaTRPTdKHIbRUSV+JT89fl0y3/va3ZKJFh214mHkaj8TL3mF3+R9JeY4csztn7PujXrOazFjW1Nty64YordpcQrFPzKULmkTWaG1QtRTzNza2N7J47/2LnDv4flSFRmQproAHcnDE5JYBHPM1to2hr4Nf/Pb0nWL0rCPy9FlKXdXPIQ21Oxs3CW7eiVg9/nrzeSkHqITHfxxv87Vg7QsAHRKAJ8A8Us2CfK54WWEdXqXVjtcz7RJp2GNz5mLUjur0AK1l8ukHvUc2DI3I5dBkjtXBHpXUKseENvF85TtFtJVVXsIbvc9XD7S+GEnGnYlipWjTm8TtojUMDpjwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSgG0B/bYp43ulAEJh2eOzHdAqcccLVRtY8uoX/YBWo=;
 b=BytQQRAaiQ7yZ+s1R4BJgbwvlrTc537D+XV3P0cmBsN4olh8hfE+FPQYGCMyjnV5l4UuADJN1Ca1S6qfmcBSxvjFOISJidXNcCevtSDHOLrd77Pe5Z6Cn3het7LmGRuKGEuw89pOnW0ieRjhYnzNYKeBpP0z4WjVYBbALZexwr9m/5B6IEtmwY+ahsrHR+Y9JNgFG36x9vWq+ugxPTd1rPsaLkQZC5FTUampJsvsVpOvPAtxuS7lZT1KxbX+HojEpTBIAJ8dpOXk1NxmZiiNLwymbx02bOKgpiBLDVpcZex2l4d/leks3fHNp88W+VueYBXrdSoZ5c50lQJIIlqIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Sat, 2 Dec
 2023 02:53:36 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Sat, 2 Dec 2023
 02:53:36 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
CC:     "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCAC/TXAIAA9rMAgAAlfQCAAG0aAA==
Date:   Sat, 2 Dec 2023 02:53:36 +0000
Message-ID: <b5070898c96232f83ba738f6516cfc8102cb7ca8.camel@intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
         <20231122221947.781812-1-jsperbeck@google.com>
         <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
         <ZWlSRE6KNNFwIYyq@araj-dh-work.jf.intel.com>
         <b561524f3378fb1d4c69451fdbf70bb5cbbb5ec9.camel@intel.com>
         <ZWpAqAumIajbw4iK@a4bf019067fa.jf.intel.com>
In-Reply-To: <ZWpAqAumIajbw4iK@a4bf019067fa.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB8245:EE_
x-ms-office365-filtering-correlation-id: 449ff8a8-5641-4c53-8501-08dbf2e1e121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eklribf8Bf2jPOTFbPZ9wP2BJ1yqWmt4ebXbihn23srtz2sDaeuhzmGJl3tw4nBdHIj49sNHnQJoBpANmTCHP5ZlxyBpNutx0grMX80sYWWGj2BHKDMDZQx8X8DgAVj61tayY34Uq3/ZHhsSup1IIX9WKXql8JK4qbI8KUfxe+gvf/WxD738q9AuV4+UqxmlzuAQZ7kIbIquOCwZXai9t0/rvAc+eQkXnQ/LqvnDnD+rwwftBLzliYiNCJkHLlIuq9yjscIyHkqnkGSXpCzt0L3pqNcJyYhEWksyVFJ43fL6HbHtRFF6on0gs+9bPSPGVGn98KJDPfgwf84WxCe0WfZBrbu6UOuxGrBHQ9jFsJ+hObjyLJHCiAvC8ZajKzIY2V1LrwfruaZFujMxGFz9J8b58LQW1IhvL+dGyb0l41Jjg3Gnz0SOn30FoIQ81dfxYHrtLkwEqiFVL73vIiMjNKSEqHDka1m0xKuZEwWM54miYIu6RquExnP1JNrPkjomRdv9G6PjXCx/A2+qP8z+s2PAa/vMRg7e/haST6Std/3ATnUIk/yn3mdB2HvFA+R0t9VMQX5qpiBLKn2C5Z2AHAH/hiqsYjjmrAmZSU5en9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(41300700001)(5660300002)(2906002)(86362001)(4001150100001)(38070700009)(6506007)(2616005)(6512007)(83380400001)(82960400001)(26005)(71200400001)(966005)(6486002)(478600001)(38100700002)(122000001)(316002)(4326008)(6636002)(54906003)(37006003)(66556008)(8936002)(76116006)(66446008)(64756008)(66476007)(66946007)(6862004)(91956017)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emRTbjcvRFlnTXRtWHhJbWpQS1RMY1B4ZVNmckhYZ1NhNlcvc1ZFcTc5QytC?=
 =?utf-8?B?NnNleHJvK0EwQkh6WGorVlYwVHZVd2FIaHl1NjlSMDJqc2Nzdkoxd08xTjgv?=
 =?utf-8?B?eXlVMnpGN1FEYzNGSVlCdHdwVWk1MWVRaGZxWi9TY0ZMVlBxS1NzNmhoOWlH?=
 =?utf-8?B?ejk1MU90aVJHdEs3ZHRZNGlKSk0ycGVOZmJrcTZFd1IyMUhTa1UvSk1BMGM3?=
 =?utf-8?B?bEdaRVhwWlJFb1gyaWVmM2pIc2FrZThKcENaNWpJQ0lweVQyNjFJRDVtaCtL?=
 =?utf-8?B?M3JPSktPOU1STHBkUjB4RjJ3VVQ4UFYvQ3p3M213NDU1WGt4MU5TaTlsSm11?=
 =?utf-8?B?ZFpYK0g1UFNoNmFNUkw1TStxaktHOFZkeE9Wby9iK2VUaStYWFdYM3pvZzVO?=
 =?utf-8?B?S05NNWhhNFI3bkt3M0RxaG1IMTBUdWF5U3dxdUlUU0pJa1ExU3Bld3h4cTRO?=
 =?utf-8?B?c1RFVmRkVTVTejQ5Uml5eU5yYzdyMWQxcFp6clhvcURWeU5CV3R4VXhTMHhv?=
 =?utf-8?B?N1I0b2NBeVk1eWQxWTFUTllJVFB6U3ZUT0liL3ExWDY3T01paHBaTWp5UEFp?=
 =?utf-8?B?TWlJWDVzNkwvT1ZmVkU5R2pqaFFINzdUMEsxS3NnNlVjTlJHM1JXbkNjRmRE?=
 =?utf-8?B?VzA4ell1UmM4WWc5d2xtYk5XeWpicmE5Vm9qdVQvajVIeFh1ZXMxci92dEpV?=
 =?utf-8?B?QThHN3Fjc0ZHNlMrTXk0dy9xa1Q4RXJOcUNKV3NlMHNzL0ErZHE3ZXJYQ2M1?=
 =?utf-8?B?SkxoQVBaM3hMdGdNeSttREp5c3dJZ09lUTNwUFBINTZCOUVjUG4yTi9ZTlh2?=
 =?utf-8?B?Y3MxRDU2b1Z5K1RtM3htNDEvNFBEUEVCWHJQWXlxVzBXZTFrRWdaTFVGdnJ6?=
 =?utf-8?B?MGJtaTZ3RkFoWXptbUpJc0prYkhHc1VKeWVtWVVxN2drUVQ0WjFFenNKajV0?=
 =?utf-8?B?cUtjalN3K3BkcGsyaHVDb0t1bTBwK3E0TEtCdzFnTEdZa25Tdm5Pams0YkNW?=
 =?utf-8?B?bFNleFErZ0pRUE1GcVU5U2VPZXpBN2pRY2U2T2tuVXBKTU41Ym1DY1VyRzhC?=
 =?utf-8?B?YzRNLzNYN3pVSVVUc2ppU2NVdzlBdGgzOTF2aDZ4aThIOHJhd0JlK3ZvOCtE?=
 =?utf-8?B?aHpaTDZVNVg5ZW5RVkcrakgwbkp1aWtCVnhMS2pYeUJzdEZzVXlPa0ViMEZs?=
 =?utf-8?B?V1M2WU15czRPMVRoQ1NxbDhKbC9RS045blVuRlp0c0pLVkNkUkdRNWdsOGJF?=
 =?utf-8?B?bzBMU0NucVhTbkpZRVROd3FyR1QwS29WeXZKbDFabytDdGFpQjRxYjNVbHhs?=
 =?utf-8?B?aWYzajFrTzdpZkJlRGNLLzJtVHFjd2JwZXJyK2lrMzRZQ0ZwdDNrRWZ0VnZu?=
 =?utf-8?B?WVB2SjVCM2oya2FTeDdEUXlwU0JxOEJJSngwT1ZxQ24wajFZakhGVjRKMFd5?=
 =?utf-8?B?SkN4eXhTc2k0QnFTQzB4VUJEazVXeXVFL1VSMFJPVHVHa1dYc1RPR3Vod0ph?=
 =?utf-8?B?ejJmajB1VnVBdGRMSjZ6bjE0b1dkNEpjMHFOdnpZdUNUQXhPUnh5T1k5WWVi?=
 =?utf-8?B?bEQydVMvcTlJcSt6MFJ6NzgwTWNYUjRBd2RDMzU0bnFyMnlLaFhmMm5scldj?=
 =?utf-8?B?VmdlZU9KaUJNcERjbHlqcEVnTlFLTXRBcXZmakx1b1lTSE15anM4WmdKYXJL?=
 =?utf-8?B?ZUpweWN1b1hBYTB0ejBHSllXSGplS0xVU1RUa2ZKLzhzclYzcmNEUkNHSlpF?=
 =?utf-8?B?eCtnSVlHTXBrUDd3aFJmK1NmODNyRFZOYWx2cmlJcWRjbVZEd1RXN3RHT1Fk?=
 =?utf-8?B?SERHYWx1Y1JJeWs2MjM1cmJ4cmhPWU92UzhHY0JHMU9kYnFXQ2dYVXhBS3NF?=
 =?utf-8?B?NXFuMzhnQVRHUGM3VmhLRmhWTitjVHFVeGhrSHRkYkppUG02YkN3WGE0ZkQw?=
 =?utf-8?B?bXNlUzYrU3hyVDhxL1RwSDA5bWlkN3ptTmJ2YjU0T1FvY3NLbm9obkVWYUJz?=
 =?utf-8?B?NStrKzk4TjRUbllmRHFYNGI5aTdpaWpPWmpnSWxEVzFRNUVGV1FDQWY3a2M0?=
 =?utf-8?B?RExGV1dMR1ZPRTh5OVppUVRSUDBmYWdxZmxEVlIxdjNVOXczQy9qakhLS2d5?=
 =?utf-8?B?TGFzMG94OWpWNWRnSnhMbXJHa0hFTWtRdjR5U3h2VmFEbUdHODhzcktzb2Q0?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBED2BC8DBD722468960C3C60A066364@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449ff8a8-5641-4c53-8501-08dbf2e1e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 02:53:36.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rs7CKmw1oLAcUn4E8mQJ4JvmkmT54LaDAWfNKdmCHzq1d1u5Wwu7q/jAHDiy5mPapU0RAHKPGfm4GNWuTgKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
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

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDEyOjIzIC0wODAwLCBBc2hvayBSYWogd3JvdGU6DQo+IE9u
IEZyaSwgRGVjIDAxLCAyMDIzIGF0IDEwOjA4OjU1QU0gLTA4MDAsIFpoYW5nLCBSdWkgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIzLTExLTMwIGF0IDE5OjI1IC0wODAwLCBBc2hvayBSYWogd3JvdGU6
DQo+ID4gPiBPbiBUaHUsIE5vdiAyMywgMjAyMyBhdCAxMjo1MDo0N1BNICswMDAwLCBaaGFuZyBS
dWkgd3JvdGU6DQo+ID4gPiA+IEhpLCBKb2huLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZv
ciBjYXRjaGluZyB0aGlzIGlzc3VlLg0KPiA+ID4gPiANCj4gPiA+ID4gT24gV2VkLCAyMDIzLTEx
LTIyIGF0IDIyOjE5ICswMDAwLCBKb2huIFNwZXJiZWNrIHdyb3RlOg0KPiA+ID4gPiA+IEkgaGF2
ZSBhIHBsYXRmb3JtIHdpdGggYm90aCBMT0NBTF9BUElDIGFuZCBMT0NBTF9YMkFQSUMNCj4gPiA+
ID4gPiBlbnRyaWVzDQo+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gZWFjaCBDUFUuwqAgSG93ZXZl
ciwgdGhlIGlkcyBmb3IgdGhlIExPQ0FMX0FQSUMgZW50cmllcyBhcmUNCj4gPiA+ID4gPiBhbGwN
Cj4gPiA+ID4gPiBpbnZhbGlkIGlkcyBvZiAyNTUsIHNvIHRoZXkgaGF2ZSBhbHdheXMgYmVlbiBz
a2lwcGVkIGluDQo+ID4gPiA+ID4gYWNwaV9wYXJzZV9sYXBpYygpDQo+ID4gPiA+ID4gYnkgdGhp
cyBjb2RlIGZyb20gZjNiZjFkYmU2NGI2ICgieDg2L2FjcGk6IFByZXZlbnQgTEFQSUMgaWQNCj4g
PiA+ID4gPiAweGZmDQo+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+IGJlaW5nDQo+ID4gPiA+ID4g
YWNjb3VudGVkIik6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqDCoMKgIC8qIElnbm9yZSBpbnZh
bGlkIElEICovDQo+ID4gPiA+ID4gwqDCoMKgIGlmIChwcm9jZXNzb3ItPmlkID09IDB4ZmYpDQo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBXaXRoIHRoZSBjaGFuZ2UgaW4gdGhpcyB0aHJlYWQsIHRoZSByZXR1cm4gdmFsdWUg
b2YgMCBtZWFucw0KPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiAnY291
bnQnIHZhcmlhYmxlIGluIGFjcGlfcGFyc2VfZW50cmllc19hcnJheSgpIGlzDQo+ID4gPiA+ID4g
aW5jcmVtZW50ZWQuwqANCj4gPiA+ID4gPiBUaGUNCj4gPiA+ID4gPiBwb3NpdGl2ZSByZXR1cm4g
dmFsdWUgbWVhbnMgdGhhdCAnaGFzX2xhcGljX2NwdXMnIGlzIHNldCwNCj4gPiA+ID4gPiBldmVu
DQo+ID4gPiA+ID4gdGhvdWdoDQo+ID4gPiA+ID4gbm8gZW50cmllcyB3ZXJlIGFjdHVhbGx5IG1h
dGNoZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBpbiBhY3BpX3BhcnNlX21hZHRfbGFwaWNfZW50
cmllcywgd2l0aG91dCB0aGlzIHBhdGNoLA0KPiA+ID4gPiBtYWR0X3Byb2NbMF0uY291bnQgaXMg
YSBwb3NpdGl2ZSB2YWx1ZSBvbiB0aGlzIHBsYXRmb3JtLCByaWdodD8NCj4gPiA+ID4gDQo+ID4g
PiA+IFRoaXMgc291bmRzIGxpa2UgYSBwb3RlbnRpYWwgaXNzdWUgYmVjYXVzZSB0aGUgZm9sbG93
aW5nIGNoZWNrcw0KPiA+ID4gPiB0bw0KPiA+ID4gPiBmYWxsDQo+ID4gPiA+IGJhY2sgdG8gTVBT
IG1vZGUgY2FuIGFsc28gYnJlYWsuIChJZiBhbGwgTE9DQUxfQVBJQyBlbnRyaWVzDQo+ID4gPiA+
IGhhdmUNCj4gPiA+ID4gYXBpY19pZCAweGZmIGFuZCBhbGwgTE9DQUxfWDJBUElDIGVudHJpZXMg
aGF2ZSBhcGljX2lkDQo+ID4gPiA+IDB4ZmZmZmZmZmYpDQo+ID4gPiA+IA0KPiA+ID4gPiA+IMKg
IFRoZW4sIHdoZW4gdGhlIE1BRFQgaXMgaXRlcmF0ZWQNCj4gPiA+ID4gPiB3aXRoIGFjcGlfcGFy
c2VfeDJhcGljKCksIHRoZSB4MmFwaWMgZW50cmllcyB3aXRoIGlkcyBsZXNzDQo+ID4gPiA+ID4g
dGhhbg0KPiA+ID4gPiA+IDI1NQ0KPiA+ID4gPiA+IGFyZSBza2lwcGVkIGFuZCBtb3N0IG9mIG15
IENQVXMgYXJlbid0IHJlY29nbml6ZWQuDQo+ID4gPiANCj4gPiA+IFRoaXMgc21lbGxzIHdyb25n
LiBJZiBhIEJJT1MgaXMgcGxhY2luZyBzb21lIGluIGxhcGljIGFuZCBzb21lIGluDQo+ID4gPiB4
MmFwaWMNCj4gPiA+IHRhYmxlLCBpdHMgcmVhbGx5IG1lc3NlZCB1cC4gDQo+ID4gPiANCj4gPiA+
IFNob3VsZG4ndCB0aGUga2VybmVsIHNjYW4gdGhlbSBpbiBzb21lIHByaW9yaXR5IGFuZCBvbmx5
IGNvbnNpZGVyDQo+ID4gPiBvbmUNCj4gPiA+IHNldCBvZg0KPiA+ID4gdGFibGVzPw0KPiA+ID4g
DQo+ID4gPiBTaG91bGRuJ3QgdGhlIGNvZGUgc3RvcCBsb29raW5nIG9uY2Ugc29tZXRoaW5nIG9u
Y2UgYSB0eXBlIGlzDQo+ID4gPiBmb3VuZD8NCj4gPiA+IA0KPiA+IA0KPiA+IEkgYWxzbyB3YW50
IHRvIGdldCB0aGlzIGNsYXJpZmllZCBidXQgdGhlcmUgaXMgbm8gc3BlYyBzYXlpbmcgdGhpcy4N
Cj4gPiBBbmQNCj4gPiBpbnN0ZWFkLCBhcyBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnQsIHdlIGRv
IGhhdmUgc29tZXRoaW5nIGluDQo+ID4gaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNS8w
NV9BQ1BJX1NvZnR3YXJlX1Byb2dyYW1taW5nX01vZGVsLmh0bWwjcHJvY2Vzc29yLWxvY2FsLXgy
YXBpYy1zdHJ1Y3R1cmUNCj4gPiANCj4gPiAiW0NvbXBhdGliaWxpdHkgbm90ZV0gT24gc29tZSBs
ZWdhY3kgT1NlcywgTG9naWNhbCBwcm9jZXNzb3JzIHdpdGgNCj4gPiBBUElDDQo+ID4gSUQgdmFs
dWVzIGxlc3MgdGhhbiAyNTUgKHdoZXRoZXIgaW4gWEFQSUMgb3IgWDJBUElDIG1vZGUpIG11c3Qg
dXNlDQo+ID4gdGhlDQo+ID4gUHJvY2Vzc29yIExvY2FsIEFQSUMgc3RydWN0dXJlIHRvIGNvbnZl
eSB0aGVpciBBUElDIGluZm9ybWF0aW9uIHRvDQo+ID4gT1NQTSwgYW5kIHRob3NlIHByb2Nlc3Nv
cnMgbXVzdCBiZSBkZWNsYXJlZCBpbiB0aGUgRFNEVCB1c2luZyB0aGUNCj4gPiBQcm9jZXNzb3Io
KSBrZXl3b3JkLiBMb2dpY2FsIHByb2Nlc3NvcnMgd2l0aCBBUElDIElEIHZhbHVlcyAyNTUgYW5k
DQo+ID4gZ3JlYXRlciBtdXN0IHVzZSB0aGUgUHJvY2Vzc29yIExvY2FsIHgyQVBJQyBzdHJ1Y3R1
cmUgYW5kIGJlDQo+ID4gZGVjbGFyZWQNCj4gPiB1c2luZyB0aGUgRGV2aWNlKCkga2V5d29yZC4i
DQo+ID4gDQo+ID4gc28gaXQgaXMgcG9zc2libGUgdG8gZW51bWVyYXRlIENQVXMgZnJvbSBib3Ro
IExBUElDIGFuZCBYMkFQSUMuDQo+ID4gDQo+IA0KPiBBaCwgc28gdGhpcyBsb29rcyBsaWtlIHRo
ZSBsZWdhY3kgY2FzZSwgb2xkIE9TIGNhbiBhdGxlYXN0IGJvb3QgdGhlDQo+IEFQSUMNCj4gZW50
cmllcyBhbmQgbm90IHByb2Nlc3MgdGhlIHgyYXBpYyBvbmVzLiANCj4gDQo+IFNvIHlvdSBjYW4g
cG90ZW50aWFsbHkgaGF2ZSBkdXBsaWNhdGVzDQo+IA0KPiBBUElDID0gaGFzIGFsbCBBUElDIGlk
J3MgPCAyNTUNCj4gWDJhcGljIGhhcyBhbGwgZW50cmllcyA+IDI1NSBPUiANCj4gwqDCoMKgwqDC
oMKgwqDCoEl0IGNhbiBjb250YWluIGV2ZXJ5dGhpbmcsIHNvIHlvdSBtaWdodCBuZWVkIHRvIHdl
ZWQgb3V0DQo+IMKgwqDCoMKgwqDCoMKgwqBkdXBsaWNhdGVzPw0KPiANClRoYXQgaXMgd2hhdCB0
aGlzIHBhdGNoIHRyaWVzIHRvIGRvLg0KU2F5LCBpZiB3ZSBoYXZlIHZhbGlkIENQVXMgaW4gTEFQ
SUMsIHByb2JlIFgyQVBJQyBDUFVzIHdpdGggSUQgPj0gMjU1DQpvbmx5Lg0KDQp0aGFua3MsDQpy
dWkNCg==
