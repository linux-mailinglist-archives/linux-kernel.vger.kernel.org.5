Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C57892C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjHZAus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjHZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:50:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F58326B8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693011028; x=1724547028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/wy0x8vFFmYKSP+vlVDj1KgwbVolrCUl6MWwSyao/PY=;
  b=Uyt+YYQh17+WzDuIOMf+Gb2dcc6Ps/p/4yBQCCOBy+AkHxck+G5j7Owj
   TE+ZRPL8A3srQtKw7V6r+3bpos6gX9ME2ufIUZHyNNErUWM1FxvmNcc8W
   ALrkye/u/CnHcnUB9nnLyVEtrhkohZF1JML0Xrc8sJtD+4M4UyjaatOqR
   6+QQZpZNyofyfi8Kj2VTzLK4a3arshhaDVYF/SOqC7Jvx67Uusy5B0Zkj
   JadOh5+qoomef/WYqdP5Cr/r1n3LYNutpxyquj87V14cyWFx0ON6fUW34
   l7WzlmSox9OBfPX4MfwnQHuc8OhUAw9N/azQ275Hby4YG6YBYOBXjsPGv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461197857"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="461197857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 17:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="737649196"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="737649196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2023 17:50:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 17:50:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 17:50:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 17:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0wh67mXvO0HU96Y5b69a176ZM57U4i1I8te1ONTSCho8XfURUSENcr0OD4RNE/j1NPZ+WWcx5dJm0UeL4rvLElq/FAqeupew7Mh8yhm8NHPLkjYVy3OPt8ANLEMdHfKcSdIUB6Mo0AOhXEWg7Lt0Fr/cqRTIBB5H/Bt80E5J1YF1lmlf5Pb6bQt9nDZ5yLyg7KlwjyaXVNpR+ozZjE7UlHwXTTSbpMZmkHlvizIyTWWhxaFWa7jXfIeacxX1w7sMrXGPt6aB2I+WOW4+ARzP2oD9ABXW9S78GgSUeifGD6ckY2CP4sC3jLkg+tMnTJ7EdIlFr7HOKvKqbvEWDivOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wy0x8vFFmYKSP+vlVDj1KgwbVolrCUl6MWwSyao/PY=;
 b=DkeE/ZEyGNQypMhNk8jYgXfb4hw48DP09+nxuUV0S/7xwpq0YiQuFYY75/zQskSuncr5Ed6y5qZOXWM2zLm5wdWDrKxzPdjPVZNn/YeSGhhFlDF33iC/bLRDrqXJPbvT7Ufs1caZT90e6q/hDti5glC97aIzMQ/5nhlANVSCvftas7EQtM2r41+/IXg3EJvxOrAV/TyQRz3Ky0ullcs/JdOxKgVMx84kNaSod6PCt5sKflw6Gxrh6xtKwwpHoQGOKziN46yCdhZBr4WCKunAT6COjDxaGW5stvXVOyWQc9XDqXyrDxkE1c7QBYIxk/GxIcpiQh9jP5BBKAEj/CLIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5502.namprd11.prod.outlook.com (2603:10b6:5:39e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 00:50:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 00:50:11 +0000
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
Subject: Re: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZz2d7UQsEDFsUOEaymlW0GXBdza/7uv0AgAAUuQA=
Date:   Sat, 26 Aug 2023 00:50:11 +0000
Message-ID: <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
         <20230825233558.xzqukr3vbccii7f4@box>
In-Reply-To: <20230825233558.xzqukr3vbccii7f4@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5502:EE_
x-ms-office365-filtering-correlation-id: 405e2d4c-42d2-4c3c-ba9e-08dba5ce66f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLPAevP7WPloFc4pzKmdYBqQvXcGGs40Xb68Hj7VsbqQ2dXXUbbhH68YZ/+HSkFyFKYyKHPeRAYsmJ8o1wMxHVMJaogG9H2JgsYWYYEXsuor0O2T1+tXutXlYa4HvflXBuJm52xkPUWcLtS+cl+VE6/HGMmuQmXShhh7Wn5ArzL04CQ8Wo1f/LQswgfWhKUaArQAQdOlqsGOwUCjj1D09DsKPwLSFZFEFKy3WFBYF+2t0yOY9qv7tWqaeq7fuBYSyFF8xcY3HD7+FAxb5p1zCBjWJzGbYbH3UMnlRRnYTyhZnEflK1cHbSka6lR2Tx2kRNYrqBgb7Vf48FRMS6eSsaRRcnGNWVsJ65TZpCrfRPJJ+mDxVaeq95WiEfz26U18K3bGpprkQztqOvhV2FRJze17b60mQmkRN1h5i3yw31vX2Qwp2NhFCNpQY5GcTT5XNMGuwdipB63x+EfclhuRWhO4JpFQw6Hwdbinzk9b8QnfS2HoJ53ZQhpgAGyiuuRKpzX7M+1ETvPP8ucBnAAXv4RQYs+gu7IdCI52uxjRMSGxdjtjmLQZt/laQfYqwibO+ZQrQxCgTTfhzs3X4OOCIW/O4BaYlnlilltNnbHSP/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199024)(1800799009)(186009)(6506007)(71200400001)(6486002)(36756003)(86362001)(38070700005)(82960400001)(38100700002)(122000001)(83380400001)(4744005)(2906002)(478600001)(26005)(966005)(2616005)(76116006)(66946007)(8936002)(8676002)(4326008)(91956017)(41300700001)(5660300002)(66476007)(66556008)(7416002)(6916009)(6512007)(66446008)(316002)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SSt5Sk9UY0V6SkdKSWRtVTZERVNraWVHY0VGSjlWdXdxeGRtQzlvWVdOanRj?=
 =?utf-8?B?UlZDcm1iL2VQdGg5NHZnYWROTHhIalo3bWZJNk5CMU10VUttQnZUQXhIL2Zz?=
 =?utf-8?B?aUtHNE84aU9FZ2RraWdNa21UaWN1eCs3a1pkMG42c3k3QlFoRUU0dzlqbW1P?=
 =?utf-8?B?M1FTOTJ1WDVKWmUwWlBuaGNVRVV1dXBlMUcxeldQQ2xBTU1neWk1RU1aVmdW?=
 =?utf-8?B?Rk12T1pDZXpuZzFiUFhYR29wTmtMSlphOWV0VFNqbkE0bndWM2MvTG4vbXkr?=
 =?utf-8?B?TVZ0amlIR0U4TXNxZlYzdDJkZHJaTjlTVm1hYllpNTl6VmFxNmREWG0yMzQr?=
 =?utf-8?B?cjVPQmRDNVQyZ2w0eEdaUXVOdVBVM2F2QVkwSHU2TFdCSjZCZEY5N2xrMFc3?=
 =?utf-8?B?anJMNFQ1RTAyRUtjaFZiS1NpWW10UEkzcjlwMGNYRzA5amV2RGd4bVZuWWxR?=
 =?utf-8?B?ZEpSaHpINDlDaXJYV0hUWVJDMmloTjlYcC95MXV5Wmd0M1BERUVaMk1iRm9i?=
 =?utf-8?B?WjZrU05VakdQZnBKaE0yZ1hLMnYycVUxcjJRNWppdEdxUkpmUnlsNG5kWXJJ?=
 =?utf-8?B?VWVHWUZUdUN0cFdYL3E2dC92TWY2UkdTdzFZcmlQQlFGT1IwQlNMcUQwTlV3?=
 =?utf-8?B?Q3c1S016SFNwd1B5eTV3MGJ3SG9QbHNDcXpXN1dkSytTcWllZ1lxNmNpOHlF?=
 =?utf-8?B?VXNKVjFYYi9sdXM3YlNTVHZPbFdVbWEwQi9PdGdESzRmMzRlV3o5QTEwVlBO?=
 =?utf-8?B?cUpGNWpuZ1JEamlsWEdjNWRjL0hpbnB3VCtEbHdUdE4ra1BrVmFNL21KUVV2?=
 =?utf-8?B?NE81ZHRPandSdmZTYTB6SnZ1dVNyTDFmWmQ2OHI2bUp6SEZFNGdUeGdEb2VO?=
 =?utf-8?B?bUJYenZnODBOb2p4dXEzMHdreEhWQXhHVEhBYUxPTHhUR3pCcUpXMEladEpy?=
 =?utf-8?B?b21nRGpHY1lPUnd0ekZXQ0wxbXZkTEc0M1MzdkhjMFoycmZxNlhKYXBJZ1Bu?=
 =?utf-8?B?MXVGbVZnTVAybUVZK2hWU0hBdktzRG5zMFkvOGJEMW9hZmtrU1R2dEtWNXFl?=
 =?utf-8?B?L2JsRXhuR0NZNi9PeVpMcUp5Ym5HQk41ME9TOFlxMjI0cnA1ZFdPUnpiQTdG?=
 =?utf-8?B?WUJjTmdaRjRvdVQvS1BFT2NKSVNxNk04T084RVJENHEzcGh6M3MrTFhRY3Qz?=
 =?utf-8?B?U0p5QVJ5cm1ZVFU3NVhhSHJUQXlLaHpCMzhlQUZzRENOZnE0STN5ODY0UklE?=
 =?utf-8?B?eE83Q3hYMGlEVGtoSjNhcHBWWUNkOE5MY0hCcWt6dTNQa0pRMkhSVW40V2Zj?=
 =?utf-8?B?ekJHNWwxVUFxcStVYTBJSDVqOSthWERiczVvckJPY3ZmVUhoZkNEcFVsUStn?=
 =?utf-8?B?ejQwU1kvOXVYdE85bzZwa2x2SU1lM3lFbzY4VEJJYncxNXNmTUtYRE51QlVN?=
 =?utf-8?B?Zmlac3BBdHMrRHFvM2ZPVGRYeEVLV2g3MVlpL0FoUzc1RzAxaEZWMm5FSTc3?=
 =?utf-8?B?OWZKUzdTd2F0dWlES1hyc2orNUIzQmt1eHJDTFFQaGpiQmdudHZRZWY5dUtZ?=
 =?utf-8?B?R2VwUDI4dm9ITThOL1NhNmtWMXYremV6SDZWdWxuM3dKYjV6ODJqcWZZUzEx?=
 =?utf-8?B?UnExdG1JQ3BhWkloY2ZpcXFGRFdPZUFDK0t5QWY5bC9HWDdjWlk5WDlGL3BE?=
 =?utf-8?B?Y1JFRW1UbDB1UWdXVjRBbFNwZHhFNE05eFdJMWwrdDM1SnRla2dEVHFydjJC?=
 =?utf-8?B?clpQQkdKRXRoWnVZSlVsL2JEekkwSWQza3RIdlpFeTVNSzRNSDJ1YUM3RGdp?=
 =?utf-8?B?WEpKeGUzdEFhQktjNWNIMVIzalNuRXQxY2cyN2RSZWNoN3FGZ1ZZOUVCRDdr?=
 =?utf-8?B?aXV6eHRnblpoYUo1NXc1YnVkNk83QjhiUkF2Zi9PSXFRbVY1ZnQ3TnBOUmd6?=
 =?utf-8?B?ZTNrYW1UTklWak9LYysxa1ZtUTYrelZiN2Jkek5jbUtKREpEakYrRHltd28w?=
 =?utf-8?B?UzFJRFR4bmhUdHZyQ0k3QTMydG11bWhzVFBEZW9GRU4xeGcrT2Z5NFFTT293?=
 =?utf-8?B?ckYrdm9EbXVhS3J3RGRrYTMyVFJtRXM4ZC91L1J3MCt4cGUwb3cza1hvdUNE?=
 =?utf-8?Q?pk88W5Vh/Gq8IWdYf8dUVwkJw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D0565658068B2409F99C2B3D9CB469A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405e2d4c-42d2-4c3c-ba9e-08dba5ce66f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 00:50:11.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czYiGnwRyBAeveY9tNaRzeWSpXVIaMUOmBgUDnu453ov4Df43PgMTzWV0XWRvSlHrNwchZ2vkiaRYBdDHr3yTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5502
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

T24gU2F0LCAyMDIzLTA4LTI2IGF0IDAyOjM1ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAxMTowMjowMVBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gKwkvKg0KPiA+ICsJICogRmFpbHVyZSBvZiBfX3Rk
Y2FsbF9oeXBlcmNhbGwoKSBpbmRpY2F0ZXMgYSBmYWlsdXJlIG9mIHRoZSBURFZNQ0FMTA0KPiA+
ICsJICogbWVjaGFuaXNtIGl0c2VsZiBhbmQgdGhhdCBzb21ldGhpbmcgaGFzIGdvbmUgaG9ycmli
bHkgd3Jvbmcgd2l0aA0KPiA+ICsJICogdGhlIFREWCBtb2R1bGUuICBfX3RkeF9oeXBlcmNhbGxf
ZmFpbGVkKCkgbmV2ZXIgcmV0dXJucy4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKF9fdGRjYWxsX2h5
cGVyY2FsbChUREdfVlBfVk1DQUxMLCAmbWFyZ3MpKQ0KPiA+ICsJCV9fdGR4X2h5cGVyY2FsbF9m
YWlsZWQoKTsNCj4gDQo+IERvIHdlIGV2ZW4gbmVlZCBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKCkg
YW55bW9yZT8gSnVzdCBjYWxsIHBhbmljKCkNCj4gZGlyZWN0bHksIG5vPw0KPiANCg0KX190ZHhf
aHlwZXJjYWxsKCkgaXMgY3VycmVudGx5IGFubm90YXRlZCB3aXRoICdub2luc3RyJyAod2hpY2gg
aXMgYWxzbyB0aGUNCmJlaGF2aW91ciBvZiB0aGUgb2xkIGNvZGUpLiAgV2UgbmVlZCBpdCBvdGhl
cndpc2Ugd2Ugd2lsbCBnZXQgYnVpbGQgd2FybmluZyBsaWtlDQpiZWxvdzoNCg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9hMjNjZThmZDI4OTE0MWNlYTNhMWI0ZjNkYWNlMjIxZGNhODQ3
MjM4LmNhbWVsQGludGVsLmNvbS9ULyNtMjA1YjI5Y2UzZTMzOTgzZWM2YmU3MzNjMmFmZmZiZmQ1
Y2I2NTNmZg0K
