Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7F7D06DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbjJTD3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjJTD3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7BD45
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772574; x=1729308574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hrLa69LdgTwkBBjglahf/CjwCToIyOEE7R4Uvu6OY/8=;
  b=UOyS4nJPumDBKXnn1DEzWXbubkrTwcK1AwKtN0cRlBWt9ouaXrZ9Il/t
   BE1w06ex2pB9RR/6BgFxeQOhqdMWcD/QmbMZj8ePKr8P+W9/x7yCyZ2LM
   QkzJNWkwphuNcKkPymVrOybkPk9IdnGUy9s4iNWLw46Qdzp4mCM0QAcMY
   GQFoozK6E3ClHVS9NUgXXkG0GWoYiOQhQOfLkhsiAIUh0gLxAPdqnLOaL
   0CveRZPAU64oFkZtfLvag8e32ly75ytdPsnD+vObvLwo1/KRmasEYDyIQ
   mglXHLKKsNlVYdnha36iyFTrrrQ8oO5fpyqNuGojNbo47I0rFEFeFI/L3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385299277"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385299277"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707105738"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707105738"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 20:29:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 20:29:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 20:29:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 20:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYLmukH5p/YjHm7s35QeAx+ZQ3HHj2fWebJb108ZWngkf52u0dN5jB/rCU4iPEVzxZP5J1S8CvflhY2yXXW22DAX9GdLQyvkC6rW64NW1yV430HQyV90n8f8GJTX1l86UfIPAKTJHyVxtAUGBn3uBPGPYudOb+auURW/jZV4MyP8A0Xfz8TAHuenhj3DeBNTK06ezFm1Et2dUSI7vaeAMvxj1iez3grJLlfYFdd06Cb7SJ2j84o23mnCt1xQb8uLUWDb999Lc6476va6dkiHhrRhcAKZHLPSkskb7uW1OS/xfae7UILLy95ZwLHvkriLYtsYky6spmDZ0LVUlf3lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrLa69LdgTwkBBjglahf/CjwCToIyOEE7R4Uvu6OY/8=;
 b=cCusv41zHRhFycpfWPIL1ZySIckIrdgSEe006E91LS6tNeM43T5ywH+2gXCySZLqYI3eok9Zp/7UF3ztanhZXWDV3eS+BbaXxRjFEB7qXqgDPnUBB39FYuYAbhwixekDt/5fNvoDiKY9B6aMj1k10xRZh/VO6VLH6/45mDnow8TNoWkmA73ytclWXq3vN2usW/R8eVU7xEzfgrwrvEYP+Hko8mMepccU4x6L0nFDweQtQsQTZJrrP/hPO8DMciltyqG+IEgsTwHfj6rkPQ07IqlHdyTZViAMo/AL5dmvii1ibULy8dqelQ4aatUMa4KP70AmzamuSvccNAQbNKSelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 03:29:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 03:29:25 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary CPUs
 in kexec case
Thread-Topic: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Thread-Index: AQHZ94+CVtYaY4+0s0KVDjRWXxnMZ7BSHBuA
Date:   Fri, 20 Oct 2023 03:29:24 +0000
Message-ID: <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
         <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: 842b25f7-8284-4a7c-5569-08dbd11cc1fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhntaT57OjHQbv/m2VO+9CNs07t4y3/5gaDWITGDqcWuaxrmcFx/ZCJ6Fzt+dq+SkLsVFISNzDmdTNDxUEiaM8hqQ/J3gHvCvvS9rou4gpYZphYzlYQQ7GmFuvsLFGWO3+l3dnObuiZ1JbpG/T5+DoBOEcW/t7kl+yS4h0SD7+oXQcUy5CucacvgYEOHCTIHAAUR56GmhGAc5dGo2s2yGLu4WFqh2Bic3T7cDp9eWbw5vBP8Igj69SFhOPYicpwgqMT5kuvlLWWLku0ZEOTVHly1Zlg7OMPoOhCFgmm1gQfrwICyv5N4enOwMt5YhkW+FZBI3Dw2rY9M7Qan1O9DolbjAHE+4YIWqqUiPvEPuscmg2sRvXZIRcPLQk/JQTLjHhwikmlxNhUyNfJ5UqmEsw3hO7BWEt6wau6YSiO7jAF9LHa2YborU4lUHVh62Ucq/WLswE4KLKiq5z+GemqFKY8zsF57b42/uZIxlIm+f9jzw5teIrXOc/9vgmb39ajlVW5Z6oMYAT+NIrNs476nZrloTKV/54lyWY8m0IYgXCplcDa7Ebbk21FmjKneznelUOjAkhQtIIcLDdcvZP7nmAffw7q1zofC+Xff75w/Dltd2sv9U70pc1/RR2OHgxs2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(86362001)(4326008)(2906002)(82960400001)(38100700002)(6506007)(6512007)(5660300002)(7416002)(41300700001)(83380400001)(26005)(122000001)(36756003)(2616005)(8676002)(66446008)(8936002)(478600001)(66476007)(6486002)(71200400001)(66946007)(76116006)(91956017)(66556008)(316002)(64756008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q00wcVozdzZ4a2srQVFFalZNKzdtbmEzUXNsQm1EZFpnSE1qVldQTGF0azlE?=
 =?utf-8?B?V2tlQTJwUWMyNVF6L2VwZDJ6RzMxMnUyZ1c1dURwZTlpanlWVHhKVlFnVmVH?=
 =?utf-8?B?SW1XaHIxRDBRL3NwOXoxL2kydGdaVlErNGpGMXczV1JUdjJIZ3o3N2M0UnYy?=
 =?utf-8?B?K3dCL0R6K3JWQ1lGRWNHN2pqZTdkM1FGa1NRalJiVDF2bDdpcXdpcFNXaFAx?=
 =?utf-8?B?Mk5iN2s1aER6VHh6QWU2ZEtPTXZWRCtKU3UxK2lrNlZxM245ZTRQMnhFVXN5?=
 =?utf-8?B?ZTFaNjd3dnFWY0pTd1htRzg0RWVFS1luNFdrMnF2VXhRT1hwYmtqNDI3cFdz?=
 =?utf-8?B?YjNLa2dmMG85alZqZXI4U3lJclRreHlUd3ZFVDFUU2NHK1lFc1NSekhLWVpX?=
 =?utf-8?B?bC81ZVZXZk95YVJYL0t4ZzQyRzQyRXZIN0FTSHZHYXdLYkQ0dG4yYm5pNlln?=
 =?utf-8?B?OVRzcjhRZHpUQTR3Ky9ob09US0Q2eGMxbG9ZdVFRZnZBSS9rZUNGc3N6ZEJU?=
 =?utf-8?B?WWNvbnVQQ1M0clVnd3JkaHhZQ3hxVjVBc05KcGMzTFFZUnN3djNnYy81akx5?=
 =?utf-8?B?U1dnYTQzNWVmalZSN2VJcTRlZFNxK0NZOHlNNm43UXN6M1l6eWJRcC9SMmQr?=
 =?utf-8?B?N05zWGFtUFRGdXRSM01mVmd2UXNIdmc5ZmpzSHZrbTRkN3FCMzlGMjJRV3Za?=
 =?utf-8?B?N3dROE94ME9manQwMHVpdzVraDRraWFJL1QxL0JWTFVlUDFGRzduV1pHVjM4?=
 =?utf-8?B?NWhXQVpsdXZsMTdiK0RTVVNpbjhMS2J6SnNTTnpCeFhGQ2h2VHZVS041VFhx?=
 =?utf-8?B?SkR0MG9PQTB1bWVxbDExK2FqR0UzVjlVNzhsM1lNSDdXTE1wakQvakI2QTU3?=
 =?utf-8?B?Z1FVUWRYblFuK055RlZHN1pGeEp2V3FOVDBZa2cyK243T3VWbXBTT0xtai90?=
 =?utf-8?B?cFI0TEliR1lXWlVJelhJS0o4Tkp0eXVCY0tTVk92UGRsdk11NW9udVBzSVRi?=
 =?utf-8?B?MEs5WTFIbzJoWDFxdlBEczRlRkd4dm5aWXJKOUdLZEltRHd3a1p6M1hHQ0VJ?=
 =?utf-8?B?NDd4NnY2MTQ3R3hqeVBoY3hrYzkxWXZsQXo2QUxXU2x1eGlRSkVJckxSSXVz?=
 =?utf-8?B?Mzk3c3BTQXJKWE5zRjh1L0xQK1FoV0g1N3JrTDYwRVZWWHRaU1JpR3A3eUcz?=
 =?utf-8?B?ejNZN1RmUitwS3U1NkI2OXh1dCtWODJCaVJqY0FXN2V0dmhEYS90dGpraW9O?=
 =?utf-8?B?VkIra0Y1cTZIOEZYQ2FCcEFLL3VoaFRDZVJuTUlOem83WEtVSjJXUW5oR3Iz?=
 =?utf-8?B?b1VpM0w2Y3ZIZTBteDdrN2RQQ1dydVpHczZYMkdvQ0lsNkhjOCtpK0RyMTFI?=
 =?utf-8?B?bDJxRGRzK1FWcGlyWXlETWRtM2d5Q0J4ZklkUkVQc1F5M0YyOUNGMzVaankv?=
 =?utf-8?B?eUJZNjVNK1IzYVNxQ3ZhNWlycE9sUTd5c2RjWGxnekJjMWRIcS9CWkNGcVY0?=
 =?utf-8?B?MUk3SFNHZDU2VmpRNjNUcVF5WitRNUU3dFl4TEtHZGRqTVEwcTg2Zkt2YTFk?=
 =?utf-8?B?RlI5ZkcxRElzekxieGpzTW9mODNiN3ZlN1M1N2RBbkxCMFdndlM0dG1NY0JY?=
 =?utf-8?B?Unh3eUJHL0N3SEQvZnl1QUZPQW5vWTdMZjBoby9CVFVpRU4wNk1rZ2V1QkVB?=
 =?utf-8?B?bWpwWWRYcElIenduZmJZYi84cm9YUlgyOUZqM2o4Z1RnZXVRTmNuNGpSL2JC?=
 =?utf-8?B?R1RCRVFyWGNxZ05HelhYWitUWW5yL25nYm4xU3p2Q25NNTE2L3dpdTJ5ZHd6?=
 =?utf-8?B?bDR4WXpEd1daVlBSbEd5TjBUT0pCd3ZtWHNtRWpwSkxUbzdQb1JxZ0Q2bXE2?=
 =?utf-8?B?N2lOekJjZTZVS0VzcWZsS1BkNUEyam1odzRXK0hzTVhyTWxpQzQwU2d1WHBn?=
 =?utf-8?B?T1VTcGlGOW5mWlBqalgySTRmNks2RUJOeVRSaHdmUGZOT2NFVGVvMC9ubVp1?=
 =?utf-8?B?MDFVNVM3aHl0VDlrZXFEWjdjKzAxNkxRTGkzRjBpZVBPV2x3U0ovS0xSd2pZ?=
 =?utf-8?B?OGFTMDlZditqMHM1RHpoemhqTy8wTnArOElZd3FLdy9zdzlSRWl6UENRa2ZQ?=
 =?utf-8?B?Q0hobURUSVN4aFhDaGQ1WEdmMVlZTHVaRkIxWkdOeEJ6NWloSnV6UnJSMFJI?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F94AA4D6A8AC7542880F72292DFCA5C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842b25f7-8284-4a7c-5569-08dbd11cc1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:29:24.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw6TILQbexQkSUXL8lR2PhSAeZTQJu8fM9rBqyofxV5VeJLOyyEndchSFw5xnhBcvIHZ1xaNnvcXilaJ80Al+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE2OjE0ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFDUEkgTUFEVCBkb2Vzbid0IGFsbG93IHRvIG9mZmxpbmUgQ1BVIGFmdGVyIGl0IGdv
dCB3b2tlIHVwLiBJdCBsaW1pdHMNCj4ga2V4ZWM6IHRhcmdldCBrZXJuZWwgd29uJ3QgYmUgYWJs
ZSB0byB1c2UgbW9yZSB0aGFuIG9uZSBDUFUuDQo+IA0KPiBaZXJvIG91dCBtYWlsYm94IGFkZHJl
c3MgaW4gdGhlIEFDUEkgTUFEVCB3YWtldXAgc3RydWN0dXJlIHRvIGluZGljYXRlDQo+IHRoYXQg
dGhlIG1haWxib3ggaXMgbm90IHVzYWJsZS4NCj4gDQo+IFRoaXMgaXMgTGludXgtc3BlY2lmaWMg
cHJvdG9jb2wgYW5kIG5vdCByZWZsZWN0ZWQgaW4gQUNQSSBzcGVjLg0KPiANCj4gQm9vdGluZyB0
aGUgdGFyZ2V0IGtlcm5lbCB3aXRoIHNpZ25sZSBDUFUgaXMgZW5vdWdoIHRvIGNvdmVyIHRoZSBt
b3N0DQo+IGNvbW1vbiBjYXNlIGZvciBrZXhlYyAtLSBrZHVtcC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4N
Cj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dha2V1cC5jIHwgMTcgKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF93YWtldXAuYyBiL2FyY2gveDg2
L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMNCj4gaW5kZXggMTViZGYxMGIxMzkzLi40ZTkyZDFk
NGE1ZmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMN
Cj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF93YWtldXAuYw0KPiBAQCAtOSw2ICs5
LDExIEBAIHN0YXRpYyBzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXBfbWFpbGJveCAq
YWNwaV9tcF93YWtlX21haWxib3g7DQo+ICANCj4gIHN0YXRpYyBpbnQgYWNwaV93YWtldXBfY3B1
KGludCBhcGljaWQsIHVuc2lnbmVkIGxvbmcgc3RhcnRfaXApDQo+ICB7DQo+ICsJaWYgKCFhY3Bp
X21wX3dha2VfbWFpbGJveF9wYWRkcikgew0KPiArCQlwcl93YXJuX29uY2UoIk5vIE1BRFQgbWFp
bGJveDogY2Fubm90IGJyaW5ndXAgc2Vjb25kYXJ5IENQVXMuIEJvb3Rpbmcgd2l0aCBrZXhlYz9c
biIpOw0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJfQ0KPiArDQo+ICAJLyoNCj4gIAkg
KiBSZW1hcCBtYWlsYm94IG1lbW9yeSBvbmx5IGZvciB0aGUgZmlyc3QgY2FsbCB0byBhY3BpX3dh
a2V1cF9jcHUoKS4NCj4gIAkgKg0KPiBAQCAtNzgsNiArODMsMTggQEAgaW50IF9faW5pdCBhY3Bp
X3BhcnNlX21wX3dha2UodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsDQo+ICAJ
LyogRGlzYWJsZSBDUFUgb25saW5pbmcvb2ZmbGluaW5nICovDQo+ICAJY3B1X2hvdHBsdWdfbm90
X3N1cHBvcnRlZCgpOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBBQ1BJIE1BRFQgZG9lc24ndCBhbGxv
dyB0byBvZmZsaW5lIENQVSBhZnRlciBpdCBnb3Qgd29rZSB1cC4NCj4gKwkgKiBJdCBsaW1pdHMg
a2V4ZWM6IHRhcmdldCBrZXJuZWwgd29uJ3QgYmUgYWJsZSB0byB1c2UgbW9yZSB0aGFuDQo+ICsJ
ICogb25lIENQVS4NCj4gKwkgKg0KPiArCSAqIFplcm8gb3V0IG1haWxib3ggYWRkcmVzcyBpbiB0
aGUgQUNQSSBNQURUIHdha2V1cCBzdHJ1Y3R1cmUgdG8NCj4gKwkgKiBpbmRpY2F0ZSB0aGF0IHRo
ZSBtYWlsYm94IGlzIG5vdCB1c2FibGUuDQoNCk5pdDoNCg0KSXQgaXMgYmV0dGVyIHRvIGV4cGxp
Y2l0bHkgc2F5IHRoYXQgdGhpcyB3aWxsIG9ubHkgaW1wYWN0IHRoZSBzZWNvbmQga2VybmVsDQpi
ZWNhdXNlIHRoZSBjdXJyZW50IGtlcm5lbCBoYXMgYWxyZWFkeSBkZXRlY3RlZCB0aGUgIG1haWxi
b3ggYWRkcmVzcz8NCg0KCU5vdyBhY3BpX21wX3dha2VfbWFpbGJveF9wYWRkciBhbHJlYWR5IGhh
cyB0aGUgbWFpbGJveCBhZGRyZXNzLg0KCVRoZSBhY3BpX3dha2V1cF9jcHUoKSB3aWxsIHVzZSBp
dCB0byBicmluZyB1cCBzZWNvbmRhcnkgY3B1cy4NCg0KCVplcm8gb3V0IG1haWxib3ggYWRkcmVz
cyBpbiB0aGUgQUNQSSBNQURUIHdha2V1cCBzdHJ1Y3R1cmUgdG8NCglpbmRpY2F0ZSB0aGF0IHRo
ZSBtYWlsYm94IGlzIG5vdCB1c2FibGUuICBUaGlzIHByZXZlbnRzIHRoZQ0KCWtleGVjKCktZWQg
a2VybmVsIGZyb20gcmVhZGluZyBhIHZhaWxkIG1haWxib3gsIHdoaWNoIGluIHR1cm4NCgltYWtl
cyB0aGUga2V4ZWMoKS1lZCBrZXJuZWwgb25seSBiZSBhYmxlIHRvIHVzZSB0aGUgYm9vdCBDUFUu
IA0KDQo+ICsJICoNCj4gKwkgKiBUaGlzIGlzIExpbnV4LXNwZWNpZmljIHByb3RvY29sIGFuZCBu
b3QgcmVmbGVjdGVkIGluIEFDUEkgc3BlYy4NCj4gKwkgKi8NCj4gKwltcF93YWtlLT5iYXNlX2Fk
ZHJlc3MgPSAwOw0KPiArIA0KPiAgCWFwaWNfdXBkYXRlX2NhbGxiYWNrKHdha2V1cF9zZWNvbmRh
cnlfY3B1XzY0LCBhY3BpX3dha2V1cF9jcHUpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQoNCg==
