Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4E801B1F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 08:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjLBHWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 02:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBHWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 02:22:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FFD48;
        Fri,  1 Dec 2023 23:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701501780; x=1733037780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vJ1m4S2bU8nHnCda0GSQZ8fx9VRw8/dieOorGLlnwqQ=;
  b=aEurdmmqiHmU/KFnuCoE7pjqQYeux/0qx9t44gOBV3yiLAEE/hx95lyj
   qXy8bRDBLoF1+epVuKGgXRcb+4/2mPimWK2yjR9zG5bWNiQhq28mcDQh4
   sYmuZ8CAkJS/PJEndedCCWDewjUgGgPPShdJDiYK2HTXOp2UwHVFnrXGD
   /8RpBZ4lFRxAiCHL0uPPfASstsJ05YZYAKVY3zVQcwFcf+ceGN9bAy9QH
   Jt4P+Mrf8kkCzn/MDifOq6T1q4Rlybm7r/gYD1uwbvnrzOx+rq3h9QbdQ
   06FeoK60XBno0wCYsVKvmd4R+kyTW36jAydnKZFmUWhExKCNYRunQGsIR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="460079162"
X-IronPort-AV: E=Sophos;i="6.04,244,1695711600"; 
   d="scan'208";a="460079162"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 23:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893417051"
X-IronPort-AV: E=Sophos;i="6.04,244,1695711600"; 
   d="scan'208";a="893417051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 23:22:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 23:22:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 23:22:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 23:22:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgi/BrWfMgKTtnPMOXbutsI3YoCkVOfFQk6P5UxFtnr8jhF2NLN73Xy+wuVzwZMOWtGM0I+7KYCBkjj69CEZKP10oZK3wuPNtNQrQ4Six8eePFVUWmvtu+FJ0YTWFkzNOAkhtGgxPFyZIJys3TJTs9AwXjqK2qjUjS0xjGbOZ7bXPUMEPsgyCEkmJtPV1QcLfVlcNiqRk/PYzWt95barMzVsgev2XhIdKmATZPYuG9c4ggXw/Jk25G34yN3sNx2epekseUFwl2zjSihasYLqdDkDgqOv4JsdgQijJpgz7l8zXrdkGRlklO7VABCzDZntcw8EvgXIZqewO/IhwXB2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ1m4S2bU8nHnCda0GSQZ8fx9VRw8/dieOorGLlnwqQ=;
 b=VxBdKlO4FytoC5qDmmzvZQB1OaARQlccX3Siy1NROBnocoZ+hiXwkHPMIeCSpoorVipCpwwhdlTv9ihqeNh1zQ2utDtHv6cwgCDcqn7L4XN2vVtVnmduubrtXtLL28X10ljjA18+6YEYBImnPYn6EAVOVT6IrytNa8R1N2P8K1F+Bndv2H7GERTnzq9QvkWFjScYEPqjzv78mB6qpfJF2hiqVXeQNumQrrVn92H/Ej9CDVbaXSEAyXUOB1v8RZ//DBbWiXnE7jiYMMUglY9KaOaOpoBcM+wdOnFbLxpQC1GHQuOvx3Ww8HWEAQkPzl7QMWWvYGsU+1w55CaRsYgeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Sat, 2 Dec
 2023 07:22:57 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Sat, 2 Dec 2023
 07:22:56 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Thread-Topic: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Thread-Index: AQHaITQZBbXp8QjFIU2kvTj7Yr0p3rCTtDOAgAEGTICAAFbXAIAAjP2A
Date:   Sat, 2 Dec 2023 07:22:56 +0000
Message-ID: <8bc654e26dfe88250f2a3d13d43b1f1e11c7c074.camel@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
         <20231127131651.476795-4-rui.zhang@intel.com>
         <ZWlAKS2iK9Oy+7tQ@araj-dh-work.jf.intel.com>
         <9f97885ace55b6f928160a178bc0ec505ac6eeb3.camel@intel.com>
         <ZWplCq1hg9gydfEy@a4bf019067fa.jf.intel.com>
In-Reply-To: <ZWplCq1hg9gydfEy@a4bf019067fa.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM3PR11MB8760:EE_
x-ms-office365-filtering-correlation-id: 586b148a-00ed-4602-5e64-08dbf30781b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQkoesrQuSH1HSQWTBLsMXLEnejZPdTd+fNljovmsgO1Y0TWsvBg8nlS1XvgOyyLxeZdvlcsBfTtVUDNmESSOkVObm4Aq+iyQGj7DlR0SyN7Ye9nmO9RO3GZPMrrwGnq6x+EEx0G86oK/LFGM0g2VEYKwTpd+z811E1moFrij91kF1cF+XHA78LqvNvM5tMZwJKGoqrYSd3+XL1qlr+pQwIn3DWj2/zMljp9fVeTIB0T2W0+09UYGXSVUwqmwaIGhPPRDsQ4rTLCYAQ3qnQpm3GBzhOMisNGiYDWXw/Nxb4Xa9TMKvZx+aQTxqxhNd0c0gxfsiVhWATpR8dLhwZpkpxsPBe6us/Qv8G53ti3mZUNsdyKv2Qhnv/4BOV7aCCzc+EsJMCp25iR0Ma7RkdhEdSxk8hFvXHbb8c+CmFed2ByvUMQkCaBGyYtomzEuFW21R/4m5Icw52wJwq5un0/XZqsKugFXPYQi+NplxmpSA+waPrrDiR+P8XDjsXaJ728MwXgydeImt+lHXAxtaWelDq7MQGz10dLL47hCWudTg1uLpKLQLCut2JN/HEiVAZwIhxAQ2bL8zsymjnu55jZs7i2cghvmryQnp8fYe49ZqyrI7x4vKf+oZ8Z0mfd8Wa0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4001150100001)(5660300002)(86362001)(6862004)(4326008)(8676002)(8936002)(2906002)(38070700009)(41300700001)(36756003)(2616005)(6512007)(6506007)(82960400001)(83380400001)(26005)(6486002)(478600001)(71200400001)(38100700002)(122000001)(316002)(37006003)(91956017)(54906003)(64756008)(66446008)(66476007)(6636002)(66556008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d29UK2s0cHpmaTRwNU9vZFp5ZHV1SDF2Q3NPd3gvaU5MTE1QeWo4SFo5WDlI?=
 =?utf-8?B?VGhHVDNHZFZwaG1KQ1loMnEvYk9SYVhib21jb1Jvd3ZSdndoMjRPK3F1c1oz?=
 =?utf-8?B?NkpZbjFzTTVMWGkrZ1JzSnRzU3BNODdmZEQrSG4wYlU3L2VkV2poOHZsL2Fp?=
 =?utf-8?B?YjVHaC9ldVE2ZFU0Zjd0MHZGcDgrSXBVNWdWYVhycS9YQThGb3IxbXBvRENJ?=
 =?utf-8?B?Qlo5ZFNsVU1nc0h2emlEM1hDcllyUllyVzFrcHA4dGsxSmRZK1o1ZUpnU01L?=
 =?utf-8?B?cFB5UTM2bjFTUEQyRmtZaitsMFcwQThXUzA4akNuUFpqZmZ3dmV3ak51UHo4?=
 =?utf-8?B?NnpkdTF3OHB2Q0tyR2ZhZk1ZMzN3aGxVbHJlekkrL3RJemVTQmg5R0RJcFc0?=
 =?utf-8?B?UmR1SDJaaU1CTDI3N3BmRU5nL1JxQ1g1NWpQY3RPLzlxMlVlVlptWXk0WlI4?=
 =?utf-8?B?UWd1Q2NkWTNCM0FQejB6U3FVZ1dpdWdPSE5Bdi9lQlU2T0FPbHhoVjA1UTZN?=
 =?utf-8?B?UmRHcDlDUUJ6WkF4RjI2YnhpZVZRRGNkNjFSTWZHSHJUTjN2VWdMbVhzSjV6?=
 =?utf-8?B?QnAzTTlOb3lOQm95bHBJZzViQkhLM2RBV21BSHJqOGx5MkNEbHZaUHhyOXND?=
 =?utf-8?B?cXl3TWllMmlJakc5TUprNmJ6UGFPTUxxK1ZkL1JtbW9RL3FHSXJLMjNSRDBK?=
 =?utf-8?B?M2x4M0s4UW9uQVRQT2dIUFZGUDFnTGgzNFhvME5kQnNVeWtUaVRublpPRm9Y?=
 =?utf-8?B?aWgzK0NZYWkyRkxsckFpTFZSTlA3em1Uam1IV0l3K2dOMGRPNlpKWitVQ1Rh?=
 =?utf-8?B?MlhpbDM4KzhTakt1TVdIYnVKNTVad1JtUWZtZ0FkM045K0JjMDZaSUxNRS9M?=
 =?utf-8?B?V2ZSM2twcEhUQVFIN0pNS0tNMS9veVFMNVBDZUxqaDNmMndtbWE3S2NvS3lW?=
 =?utf-8?B?NWo1QmxkcU5hb1RmbC9vL3c0dEJJa21EZTVwakR0TGZVczNZZGlQVGp2bktR?=
 =?utf-8?B?bk9UVEJvallUOWtMMnJqUWpuZjFSQzJwa1BlVi9GUHg5OVA4aVFOU1h0bzdO?=
 =?utf-8?B?VWEzUDVwZzdwcW91U2UvWGlrb2g0K2EydkUvaWZ3ZWs4VmRrMHQxbnFINFZt?=
 =?utf-8?B?T1l2c01JaTViNGFSbll5TUxTU2YrbWVmQ0JmSVFtMkx4MTR2VlRZN3RlUEJq?=
 =?utf-8?B?bm9od1NZMWFKMGFDVDBSOTRZOWg2b3NFY2lvaE5oWm1sdU1sTy9YSWt4aTYx?=
 =?utf-8?B?OHVlYlpIYWlkRlFQVXJDQW1neURtdUtGS3ppd0hpZWIzQ2lYaElhVDNiK216?=
 =?utf-8?B?b2ZmeFlueU9VMC9MTW9JZVhROFB4cFdhRlFVUWxhNkNMaHVnd3EyN3NmOGlx?=
 =?utf-8?B?VFBmQ25FVmhBcHI5UnVEbThJaER6RU9UeU1ndUR2a3FBcUFGbm91WTRyT0dS?=
 =?utf-8?B?Yk9icVFhQkFkZU9lWHdId1BDd1l0ZHZySzdyVHVhR2FxdzRuaENIYy9Edk1a?=
 =?utf-8?B?SEtUZlBubFZYRUdOUUg0SFkyWGwzd3poNTRMSlFoYTczbkxzQUZRUUh2SGFG?=
 =?utf-8?B?MHV0MEdHbGtHSjhKL0VLb2Z0MWIzcitPc0MwYW1KbUFySm5EUlJXa2RwYjB2?=
 =?utf-8?B?elMyS1NTZVlkUW9CZDRoUGhSd0kvV0laZ3RnSlUyeHp4UUFtRGlZbGpnTkNH?=
 =?utf-8?B?UEc0eEZQSHF1ZzFEYzk4U0FINzNFYkF6Zzl6SjRJQ2FmWlFLRHMrK2wzeGp3?=
 =?utf-8?B?VitCUEo2YkNxQ2JLWnJwUjNDcG00NGRVdzBZSEhQUkNWTUQ2MFRBNy9nRHhV?=
 =?utf-8?B?S0dCVVZiakFSSmJJL3VOMXd1OXZ2VmRlektVa0krbXM0T2tsMGl5Wm1NNHBv?=
 =?utf-8?B?MnlSajVlaGhEZmZzRDZsOUI0YVYra3dkYlNVODB1enpaYkJqRUhEYW8zbE85?=
 =?utf-8?B?N2VVc29sZlorMkViZW9JcFhqbXFkNThtOG9sR0dEYnlMTkxobjhnZURTTDhM?=
 =?utf-8?B?NEFra0dGbUhWbjRHTk1MVDh3WXdyK0dmMzZiZzlMT3ppend0Q2ZmcWlWemNC?=
 =?utf-8?B?a3VoWHcrSXVKY3BNdWtjK095MzB0Nk4vVk9Wb1BhczFLNVVFUlloUnY2YXh4?=
 =?utf-8?Q?2aCbDU+UEHgw9Lrg8AD8mMNP0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EBCFA0CA4CC694DACF84DC0A4BB578E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586b148a-00ed-4602-5e64-08dbf30781b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 07:22:56.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkSlDbeB46gLBA8oYLO1K/MOvwD4fQ8g9Wz7Ku5pET1sZX3UzYXecduhtqDlRDN5AGPbJkK6QzAfG/xu56TgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
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

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDE0OjU4IC0wODAwLCBBc2hvayBSYWogd3JvdGU6DQo+IE9u
IEZyaSwgRGVjIDAxLCAyMDIzIGF0IDA5OjQ3OjMwQU0gLTA4MDAsIFpoYW5nLCBSdWkgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIzLTExLTMwIGF0IDE4OjA4IC0wODAwLCBBc2hvayBSYWogd3JvdGU6
DQo+ID4gPiBPbiBNb24sIE5vdiAyNywgMjAyMyBhdCAwOToxNjo1MVBNICswODAwLCBaaGFuZyBS
dWkgd3JvdGU6DQo+ID4gPiA+IMKgDQo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IHRlbXBfZGF0YSAq
Z2V0X3RkYXRhKHN0cnVjdCBwbGF0Zm9ybV9kYXRhDQo+ID4gPiA+ICpwZGF0YSwNCj4gPiA+ID4g
aW50IGNwdSkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHRlbXBf
ZGF0YSAqdGRhdGE7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfbG9j
aygmcGRhdGEtPmNvcmVfZGF0YV9sb2NrKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgbGlzdF9m
b3JfZWFjaF9lbnRyeSh0ZGF0YSwgJnBkYXRhLT5jb3JlX2RhdGFfbGlzdCwNCj4gPiA+ID4gbm9k
ZSkgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNwdSA+PSAw
ICYmICF0ZGF0YS0+aXNfcGtnX2RhdGEgJiYgdGRhdGEtDQo+ID4gPiA+ID4gY3B1X2NvcmVfaWQg
PT0gdG9wb2xvZ3lfY29yZV9pZChjcHUpKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZm91bmQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoY3B1IDwgMCAmJiB0ZGF0YS0+aXNfcGtnX2RhdGEpDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290
byBmb3VuZDsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqB0ZGF0YSA9IE5VTEw7DQo+ID4gPiANCj4gPiA+IFdoYXQgdXNlZCB0byBiZSBhbiBhcnJheSwg
aXMgbm93IGEgbGlzdD8gSXMgaXQgcG9zc2libGUgdG8gZ2V0DQo+ID4gPiB0aGUNCj4gPiA+IG51
bWJlcg0KPiA+ID4gb2YgY29yZXNfcGVyX3BhY2thZ2UgZHVyaW5nIGluaXRpYWxpemF0aW9uIGFu
ZCBhbGxvY2F0ZSB0aGUgcGVyLQ0KPiA+ID4gY29yZT8NCj4gPiA+IFlvdQ0KPiA+ID4gY2FuIHN0
aWxsIGdldCB0aGVtIGluZGV4aW5nIGZyb20gY29yZV9pZCBhbmQgeW91IGNhbiBwb3NzaWJseQ0K
PiA+ID4gbG9zZQ0KPiA+ID4gdGhlDQo+ID4gPiBtdXRleCBhbmQgc2VhcmNoPw0KPiA+ID4gDQo+
ID4gPiBJIGRvbid0IGtub3cgdGhpcyBjb2RlIHdlbGwgZW5vdWdoLi4uIEp1c3QgYSB0aG91Z2h0
Lg0KPiA+IA0KPiA+IHllYWgsIHNhZGx5IGNvcmVzX3Blcl9wYWNrYWdlIGlzIG5vdCBhdmFpbGFi
bGUgZm9yIG5vdyBhcyBJDQo+ID4gbWVudGlvbmVkDQo+ID4gaW4gdGhlIG90aGVyIGVtYWlsLg0K
PiANCj4gQ291bGRuJ3Qgd2UgcmV1c2UgdGhlIGxvZ2ljIGZyb20gVGhvbWFzJ3MgdG9wb2xvZ3kg
d29yayB0aGF0IGdpdmVzDQo+IHRoaXMNCj4gdXBmcm9udCBiYXNlZCBvbiAweDFmPw0KDQp0aGlz
IHNvdW5kcyBkdXBsaWNhdGUgd29yayB0byBtZS4gVG8gbWUsIHRoZXJlIGlzIG5vIHN1Y2ggYW4g
dXJnZW50DQpyZXF1aXJlbWVudCB0aGF0IGlzIHdvcnRoIHRoaXMgd2hvbGUgZWZmb3J0Lg0KDQo+
IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+ICtmb3VuZDoNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
bXV0ZXhfdW5sb2NrKCZwZGF0YS0+Y29yZV9kYXRhX2xvY2spOw0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqByZXR1cm4gdGRhdGE7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gwqBzdGF0
aWMgaW50IGNyZWF0ZV9jb3JlX2RhdGEoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4g
PiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gaW50IGNwdSwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBwa2dfZmxhZykNCj4g
PiA+ID4gwqB7DQo+ID4gPiA+IEBAIC00OTgsMzcgKzUxMSwyOSBAQCBzdGF0aWMgaW50IGNyZWF0
ZV9jb3JlX2RhdGEoc3RydWN0DQo+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldiwgdW5zaWdu
ZWQgaW50IGNwdSwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbGF0Zm9ybV9kYXRh
ICpwZGF0YSA9DQo+ID4gPiA+IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNwdV9kYXRhKGNwdSk7DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB1MzIgZWF4LCBlZHg7DQo+ID4gPiA+IC3CoMKgwqDCoMKg
wqDCoGludCBlcnIsIGluZGV4LCBhdHRyX25vOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQg
ZXJyLCBhdHRyX25vOw0KPiA+ID4gPiDCoA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFo
b3VzZWtlZXBpbmdfY3B1KGNwdSwgSEtfVFlQRV9NSVNDKSkNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gPiA+ID4gwqANCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgdGRhdGEgPSBnZXRfdGRhdGEocGRhdGEsIHBrZ19mbGFnID8gLTEgOiBjcHUpOw0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAodGRhdGEpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVFWElTVDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqB0ZGF0YSA9IGluaXRfdGVtcF9kYXRhKGNwdSwgcGtnX2ZsYWcpOw0KPiA+ID4g
DQo+ID4gPiBJcyB0ZW1wX2RhdGEgcGVyX2NwdSBvciBwZXJfY29yZT8NCj4gPiANCj4gPiBpdCBp
cyBwZXJfY29yZS4NCj4gPiANCj4gPiA+IMKgV2Fzbid0IHN1cmUgaWYgdGVtcF9kYXRhIG5lZWRz
IGEgQ1BVDQo+ID4gPiBudW1iZXIgdGhlcmUgYWxvbmcgd2l0aCBjcHVfY29yZV9pZA0KPiA+IA0K
PiA+IENQVSBudW1iZXIgaXMgbmVlZGVkIHRvIGFjY2VzcyB0aGUgY29yZSB0ZW1wZXJhdHVyZSBN
U1JzLg0KPiANCj4gV2hhdCBpZiB0aGF0IGNwdSBpcyBjdXJyZW50bHkgb2ZmbGluZT8gbWF5YmUg
eW91IGNhbiBzaW1wbHkgc2VhcmNoDQo+IGZvcl9lYWNoX29ubGluZV9jcHUoKSBhbmQgbWF0Y2gg
Y29yZV9pZCBmcm9tIGNwdWluZm9feDg2Pw0KPiANClRoaXMgaXMgYWxyZWFkeSBoYW5kbGVkIGlu
IHRoZSBjcHUgb25saW5lL29mZmxpbmUgY2FsbGJhY2tzLg0KRWFjaCB0ZW1wX2RhdGEgaXMgYWx3
YXlzIGFzc29jaWF0ZWQgd2l0aCBhbiBvbmxpbmUgQ1BVIHRoYXQgY2FuIGJlIHVzZWQNCnRvIHVw
ZGF0ZSB0aGUgY29yZSB0ZW1wZXJhdHVyZSBpbmZvLg0KDQp0aGFua3MsDQpydWkNCg0K
