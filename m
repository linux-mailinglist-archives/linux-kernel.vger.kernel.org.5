Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3165075CDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjGUQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjGUQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:13:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AF448F;
        Fri, 21 Jul 2023 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689955987; x=1721491987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6nUiK2dgWEAa9WxcehwdRotWPrw0xAl2OpguKmVABvM=;
  b=jdOKjvEYikDUVb1xfkjYGEoq9k1LJ6HYv6oT4n91/xazqpQjruGDJayo
   dKNltz2OWPiIQzSdQRkDEb0C34bUdNQzZ0c7bv6mClsuGRqVnPS0+swuT
   LCjMi4q6Y4NUGY7aptNQk6VUMaiiJAcYm9kjWImEBArH2mFXy+dTAmCxg
   YW3TMHc2CvEplo0WoBsTPS2dfhx/JAWujSmaC3ThpjKm3VEtmik9eEYtG
   /scUDXOiu3KaEVMISZ4jAXp+MtYxPkwF8ZX59WakjQTopeNxXKugJ36wk
   sVHoDITRUVFlfQMVIWwcSUPeU6STXGw86OE4bAwegz1+zHSxSxW0SW7Sc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="351937945"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="351937945"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795013686"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="795013686"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 09:12:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:12:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:12:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lglP+KMuxumuqW2cPvZy+Kj0RXIOe2yBIqbS1bAF2lYtCK7gZPOI83OSOB4GMxXLg8q10630hlGFfK5rSf2cWxY3joGXrGfux50wpq3vLR2QImZBMsCUUrdrWw8NEY2topzO22JEkmn9C73aGRe499FZUUbVGVGb9VORc1r2KgJVQDLwMVh/oyqpDAfxaQvYChVxDzjiLjpMx7T/Y/QL7qDV2N07TsW8lSAfxFhnrFe697VEwZLrC0ivFEsYjLdTd6D56BnKr+LGkeLdGYfJeNcsrBwww3TTBCZIf9/zA/HyJBDqisiBaR43r6J5G8SwepBoLC/CJTzFhkm9oqU6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nUiK2dgWEAa9WxcehwdRotWPrw0xAl2OpguKmVABvM=;
 b=G9IzOXuIhRWPFNCUlTHVCNxCoRaOL/bmyC6hwMOWkcEpY50jr5iPbUvscuQ5RNy+wdPlw3X90CTKotC0muS5NWtW5EjMfpfGK34bhk44ELlqr9B++WlStD5OE80eP/kf/9G+M+Ns51kIPniM1DxHw3K0QpU3LfAirYWed7nGF15CMTbnoIFcZSPehaBKctHLclfOSu6TVM81rB45lDRbNLDMByJpAzRKIlEEnS7XGFw6gqk+hM40Lh1fsc+n/xQu0q3xJ3DxXlX+G1/bgkBZCjCAbPnCgiQPg3molNB1CCBOB/YWNyaEZnjVfOYjDK78b+BJal6WP8B3fjVfoxtnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Fri, 21 Jul 2023 16:12:36 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 16:12:36 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHZu5xgYrDsoI6/ykSzsldNoVNgSq/EADCAgABYqiCAAAh7AIAAAnGw
Date:   Fri, 21 Jul 2023 16:12:35 +0000
Message-ID: <DM8PR11MB5751B68955275006A16E1C75C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
 <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
In-Reply-To: <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|LV8PR11MB8747:EE_
x-ms-office365-filtering-correlation-id: 9b539370-5918-461c-80ad-08db8a054c25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MumuDbXXG4GyZzdvnvZkM8xO63Vr2EyMnEiR25k9ZmyPs6nGq8KJJ8BeBkHr8YvG/lTk6PD/Xj2r10Kllq6NFMuMCh0t3xjmXtDFGspJ103XExL1sDwf8K4UqKXQdPOywrlhBf7fqpaNG5EJx7V5QIIs94z2OrnfY7m1fadxG4u5QtM3Hip0WfybETl12Tyj9Wse7IBD/ToAWa/36467fJkUOhRjl+t7MK2XhPnuBGO4eY4evCgnyQaB/tx7+rBkvoDT/c7zcGRovooGZU97hhk5Aggu4alts9GupM+14yl/d+cZlZRwlOvVG4ZKWQ4cuHdRVD7WL/4PpuSwzVY83bSZHKAamIfHc2dA010ec9UBTtoKZK+86/gh3XS01qk/MaQmfDwr25bKB3qhDXuLz5WgjxV652PXKtr8MWW2xrupNmxwUi7QL19cyPlSnX+iQGoMURmMxaqNYg6iDS6z6dzPZ1SppRLe7MmLVpUqBAv6L+huz3TEHUwsy9MhrMzIKTFGEcKEtVqAg8GU3QpEfytNaXCs+zutF0ro8nYi/XuprdfO44sQSowvkwdm9rc9V4OilLpFUDa5427mF9+pScp2rLRDY22plk14jT4s5BNfU6NS+KqV85OvSl1W28MJiHWkFrXNZ2W96GZo0B6zHcnBWmelveS61i/gZpahABAqnxl86ZJ8mo0lykv21wJ0f1GVSyUP1Rg+TWekspDOOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(41300700001)(7696005)(66446008)(8676002)(7416002)(8936002)(2906002)(66556008)(66946007)(54906003)(52536014)(76116006)(86362001)(122000001)(921005)(66476007)(4326008)(64756008)(316002)(9686003)(5660300002)(38100700002)(83380400001)(186003)(26005)(71200400001)(82960400001)(53546011)(33656002)(6506007)(38070700005)(110136005)(55016003)(478600001)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2srREZDUy95cTY5T3o5citiYlhJbnJFcGVQQkRhc1lDSkVCa0hKVG1GMmxG?=
 =?utf-8?B?YnEvcE1oUEt0VmtJcmV0dGxDOG1HbXk2dSs3UFlPSmRORDNaaG5pQlBjR3J2?=
 =?utf-8?B?OVdpR2s1OVZYL2RDSDUzZ0hUVmRiYU4yMCtHMk1rMk1NRlBrZktwZzNPenRn?=
 =?utf-8?B?UXljNk5Va2NFUU5TWmNlTmEwMjg4RVZJT2FlWWd6TEVFM1lzeHE2SHJPek56?=
 =?utf-8?B?QlFJVThiQ2RMWjJOUnVkTEtWdVVqZi9XRnJTK3NWVHQrTE03VkpIS2lXVUZR?=
 =?utf-8?B?Tm9tM0s3YkFhbFNUTnZKSjNjUzFSU2FtQVBVUnp5SXJzTVBadUhxUXZObCtG?=
 =?utf-8?B?MGJCNkVMVWcrcGxpRjB5UTZTMnlwakRZZkxhWnJTbzVuVW9NUGwwMkNzWkVE?=
 =?utf-8?B?c2E1WDdJRGZLdEhxU3ZsVGE1alI3ZnV3R0UvVy9JaVlJcWJoT1pHVmlrZ3Uz?=
 =?utf-8?B?VjFRamJxTGNLZDRYbmdxVHFvNHc1OFIxQURWbkM5WUtKRUx5L1ltcnVabmJx?=
 =?utf-8?B?b2o5S0RjbzVTd1RiNElKbW5pem1KaEdPaU1FSmJ4R2pqWUhmdUtLVi9qWlVD?=
 =?utf-8?B?TUtZV3lTNkRnMm1rbFVHOUd5VCtyWk4ybzFDbjN6b0tvVndpdld4NDNRTito?=
 =?utf-8?B?VkJjMEJQazRlSWV1eFN3NmxPZWNsRjJnMFFtalpHaUJrL2U5R2xPb2UrVzB4?=
 =?utf-8?B?MXp6cXdjSjZlRDVGY1hMcXFwd0RlcWhPU0s0cGRaajg1V3ZhREd6eldZQ0RX?=
 =?utf-8?B?WGNzdkNpMWlYc0JuVy9xZUJJNWR5eDVNODdjR1ppVU9ramEvK1RWY0ZtU1A4?=
 =?utf-8?B?OGNzSzY5TEo1ZzVNaklJK2pLUVRRdGFpWTR2dk1YRHZVeDNFa0hGczMyR1hr?=
 =?utf-8?B?L2haRkZyQ3VCSjF0NWZtR095QVhxVENKVG9Ra0djS01KQ1FLaWxMMmQwWGJ5?=
 =?utf-8?B?dTkwWVRCZE02UUFEN1pZdGk4QXR5K0FZODdEbk1EQURPNk1maWFmS254M0JD?=
 =?utf-8?B?dVZOSCtVQkhVNHBRRGkzTFFIQ1ZQR2pkYkgxVmk5UGdWQ1p5Y2ErNzhkZ0w5?=
 =?utf-8?B?TU53ZE94clJoZVpPb0pQOGN3blp1bkcyeHQ3M01MY0xPZzQwTHdjUjA5alg0?=
 =?utf-8?B?cElYUEpTNTBtaGY2bmtrY2I3dUdvbk5BY1RQTlBHc1czcVF2eEZXQVBzWmIx?=
 =?utf-8?B?eDlnZXl6c3NZaHNFWkJrZHFNaUo3MHZJc21ucUc4K1VWNXVwcURsUUp3UzVs?=
 =?utf-8?B?UGJSajR5bjVXMlFXODZ1ZEwzTmJGaTFvNmlidjRSNTlZcHJraFdsWktZamJj?=
 =?utf-8?B?eXRheHRMMFJHK1NDMitHOW10dTlRbHpOemh6bUJldE9MWkxGWFVsR3ZOd3ph?=
 =?utf-8?B?aGM5SWRKVUMrRHE4Z1FJWitvN2pkOGV4RWxjTmVhSnkwc2Y5VHlQRXNqa2Rq?=
 =?utf-8?B?U3Q2cmliZUNvdDlhY3o2Qi96WVZMeHVjVW1tbzFwdDl0c3c4SURIWWIzYWM2?=
 =?utf-8?B?VmlOa05VQ2NCUzh3cnpPQzdRbFIyTG5RL3JtT0IyM0FFWkhqR0dNb3B4MFZC?=
 =?utf-8?B?WU5jeGtRMmUrVU1JNGJWTm9mSHZCNUIzUmgrRU9ZTzlFZXNXN3MrNmh0WkU0?=
 =?utf-8?B?Z0ZqM2tHQVJ5UlFRSU9QVWx4ajdPN3dhTjl0TllIMldPQlpidkIzYnI1azM3?=
 =?utf-8?B?djA1dXRROENkcHdEQll5eHBEdmxKL2F1bnZCRGRjVEVaZDRYQSs5eVRCVzRF?=
 =?utf-8?B?T1d0aVViQmxXTEFIZW5mc0kxYy9sMXp6S21MVUN4UWlIUEVrUFdyVUVUbEJa?=
 =?utf-8?B?cDJ6OUVSeUpLV1Yza3pMNEVhNmJCTzJyOEIyb1J3VndqTk1yVk5NWDdVbDBq?=
 =?utf-8?B?NFhiRzFQVUJoY01BUTZPeXUzVGExMC84Zk5FcCs4Y0VpekxKeXYxOWFvSHlo?=
 =?utf-8?B?TE5haG5hU2JUNmRqTkc0QUVGcGJ4R0JTSWtoMmZ6Y2FVV0ErMDBJazhRYnAy?=
 =?utf-8?B?YitHbjAwRGsxUjlMMVFmSkNwZGtVRFVhNFR4SUJJRHVGUkdMd1pQdFJPQURn?=
 =?utf-8?B?RXJDNnZlVEJGZWd6MEIwTnIyWU95YWU2WU9lSzdpQU16QlNZQTJCaWxBaW1G?=
 =?utf-8?Q?wSoowawYZ9gZphDXrNydQcyEX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b539370-5918-461c-80ad-08db8a054c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:12:36.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUJ5IqyEQaMglG1LewF6Rr3a1uhzDOMEr520nm3P/rp69gkMxkZGYzKr8RtwrjazWbTIuiE5bVKvQ4CaX3ehFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDIxLCAyMDIzIDExOjU5
IFBNDQo+IFRvOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgS3J6eXN6
dG9mIEtvemxvd3NraQ0KPiA8a3J6a0BrZXJuZWwub3JnPjsgQm9vbkBlY3NtdHAucG5nLmludGVs
LmNvbTsgS2hhaUBlY3NtdHAucG5nLmludGVsLmNvbTsNCj4gTmcsIEJvb24gS2hhaSA8Ym9vbi5r
aGFpLm5nQGludGVsLmNvbT47IEdpdXNlcHBlIENhdmFsbGFybw0KPiA8cGVwcGUuY2F2YWxsYXJv
QHN0LmNvbT47IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+
Ow0KPiBKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9wc3lzLmNvbT47IERhdmlkIFMgLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+Ow0KPiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5j
b20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVsaW4uc3RtMzJAZ21h
aWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtDQo+IG1h
aWxtYW4uc3Rvcm1yZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFNoZXZjaGVua28sIEFu
ZHJpeSA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgVGhhbSwgTXVuIFlldw0KPiA8bXVu
Lnlldy50aGFtQGludGVsLmNvbT47IFN3ZWUsIExlb25nIENoaW5nDQo+IDxsZW9uZy5jaGluZy5z
d2VlQGludGVsLmNvbT47IEcgVGhvbWFzLCBSb2hhbg0KPiA8cm9oYW4uZy50aG9tYXNAaW50ZWwu
Y29tPjsgU2hldmNoZW5rbyBBbmRyaXkNCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtFbmFibGUgRGVzaWdud2FyZSBYR01BQyBWTEFOIFN0cmlw
cGluZyBGZWF0dXJlIDIvMl0gbmV0Og0KPiBzdG1tYWM6IGR3eGdtYWMyOiBBZGQgc3VwcG9ydCBm
b3IgSFctYWNjZWxlcmF0ZWQgVkxBTiBTdHJpcHBpbmcNCj4gDQo+IA0KPiANCj4gT24gNy8yMS8y
MDIzIDg6MzAgQU0sIE5nLCBCb29uIEtoYWkgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9y
Zz4NCj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDIxLCAyMDIzIDY6MTEgUE0NCj4gPj4gVG86IEJv
b25AZWNzbXRwLnBuZy5pbnRlbC5jb207IEtoYWlAZWNzbXRwLnBuZy5pbnRlbC5jb207ICJOZw0K
PiA+PiA8Ym9vbi5raGFpLm5nIkBpbnRlbC5jb207IEdpdXNlcHBlIENhdmFsbGFybw0KPiA+PiA8
cGVwcGUuY2F2YWxsYXJvQHN0LmNvbT47IEFsZXhhbmRyZSBUb3JndWUNCj4gPj4gPGFsZXhhbmRy
ZS50b3JndWVAZm9zcy5zdC5jb20+OyBKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9wc3lzLmNvbT47
DQo+ID4+IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6
ZXQNCj4gPj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPj4gPHBhYmVuaUByZWRoYXQuY29tPjsgTWF4aW1lIENv
cXVlbGluIDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPjsNCj4gPj4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtc3RtMzJAc3QtIG1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207DQo+ID4+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtIGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4gQ2M6IE5nLCBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BpbnRlbC5j
b20+OyBTaGV2Y2hlbmtvLCBBbmRyaXkNCj4gPj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNv
bT47IFRoYW0sIE11biBZZXcNCj4gPj4gPG11bi55ZXcudGhhbUBpbnRlbC5jb20+OyBTd2VlLCBM
ZW9uZyBDaGluZw0KPiA+PiA8bGVvbmcuY2hpbmcuc3dlZUBpbnRlbC5jb20+OyBHIFRob21hcywg
Um9oYW4NCj4gPj4gPHJvaGFuLmcudGhvbWFzQGludGVsLmNvbT47IFNoZXZjaGVua28gQW5kcml5
DQo+ID4+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbRW5hYmxlIERlc2lnbndhcmUgWEdNQUMgVkxBTiBTdHJpcHBpbmcgRmVhdHVyZSAyLzJd
IG5ldDoNCj4gPj4gc3RtbWFjOiBkd3hnbWFjMjogQWRkIHN1cHBvcnQgZm9yIEhXLWFjY2VsZXJh
dGVkIFZMQU4gU3RyaXBwaW5nDQo+ID4+DQo+ID4+IE9uIDIxLzA3LzIwMjMgMDg6MjYsIEJvb25A
ZWNzbXRwLnBuZy5pbnRlbC5jb20gd3JvdGU6DQo+ID4+PiBGcm9tOiBCb29uIEtoYWkgTmcgPGJv
b24ua2hhaS5uZ0BpbnRlbC5jb20+DQo+ID4+Pg0KPiA+Pj4gQ3VycmVudGx5LCBWTEFOIHRhZyBz
dHJpcHBpbmcgaXMgZG9uZSBieSBzb2Z0d2FyZSBkcml2ZXIgaW4NCj4gPj4+IHN0bW1hY19yeF92
bGFuKCkuIFRoaXMgcGF0Y2ggaXMgdG8gQWRkIHN1cHBvcnQgZm9yIFZMQU4gdGFnDQo+ID4+PiBz
dHJpcHBpbmcgYnkgdGhlIE1BQyBoYXJkd2FyZSBhbmQgTUFDIGRyaXZlcnMgdG8gc3VwcG9ydCBp
dC4NCj4gPj4+IFRoaXMgaXMgZG9uZSBieSBhZGRpbmcgcnhfaHdfdmxhbigpIGFuZCBzZXRfaHdf
dmxhbl9tb2RlKCkgY2FsbGJhY2tzDQo+ID4+PiBhdCBzdG1tYWNfb3BzIHN0cnVjdCB3aGljaCBh
cmUgY2FsbGVkIGZyb20gdXBwZXIgc29mdHdhcmUgbGF5ZXIuDQo+ID4+IC4uLg0KPiA+Pg0KPiA+
Pj4gICAJaWYgKHByaXYtPmRtYV9jYXAudmxoYXNoKSB7DQo+ID4+PiAgIAkJbmRldi0+ZmVhdHVy
ZXMgfD0gTkVUSUZfRl9IV19WTEFOX0NUQUdfRklMVEVSOw0KPiA+Pj4gICAJCW5kZXYtPmZlYXR1
cmVzIHw9IE5FVElGX0ZfSFdfVkxBTl9TVEFHX0ZJTFRFUjsgZGlmZiAtLQ0KPiA+PiBnaXQNCj4g
Pj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3BsYXRmb3Jt
LmMNCj4gPj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3Bs
YXRmb3JtLmMNCj4gPj4+IGluZGV4IDIzZDUzZWEwNGIyNC4uYmQ3ZjMzMjZhNDRjIDEwMDY0NA0K
PiA+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3Bs
YXRmb3JtLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFj
L3N0bW1hY19wbGF0Zm9ybS5jDQo+ID4+PiBAQCAtNTQzLDYgKzU0MywxMiBAQCBzdG1tYWNfcHJv
YmVfY29uZmlnX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPj4gKnBkZXYsIHU4ICptYWMp
DQo+ID4+PiAgIAkJCXBsYXQtPmZsYWdzIHw9IFNUTU1BQ19GTEFHX1RTT19FTjsNCj4gPj4+ICAg
CX0NCj4gPj4+DQo+ID4+PiArCS8qIFJ4IFZMQU4gSFcgU3RyaXBwaW5nICovDQo+ID4+PiArCWlm
IChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJzbnBzLHJ4LXZsYW4tb2ZmbG9hZCIpKSB7DQo+
ID4+PiArCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiUlggVkxBTiBIVyBTdHJpcHBpbmdcbiIpOw0K
PiA+Pg0KPiA+PiBXaHk/IERyb3AuDQo+ID4+DQo+ID4NCj4gPiBUaGlzIGlzIGFuIGR0cyBvcHRp
b24gZXhwb3J0IHRvIGR0cyBmb3IgdXNlciB0byBjaG9vc2Ugd2hldGhlciBvciBub3QNCj4gPiB0
aGV5IFdhbnQgYSBIYXJkd2FyZSBzdHJpcHBpbmcgb3IgYSBzb2Z0d2FyZSBzdHJpcHBpbmcuDQo+
ID4NCj4gPiBNYXkgSSBrbm93IHdoYXQgaXMgdGhlIHJlYXNvbiB0byBkcm9wIHRoaXM/DQo+IA0K
PiBCZWNhdXNlIHRoZSBuZXR3b3JraW5nIHN0YWNrIGFscmVhZHkgZXhwb3NlcyBrbm9icyBmb3Ig
ZHJpdmVycyB0byBhZHZlcnRpc2UgYW5kDQo+IGNvbnRyb2wgVkxBTiBzdHJpcHBpbmcvaW5zZXJ0
aW9uIG9uIFJYL1RYIHVzaW5nIGV0aHRvb2wgYW5kIGZlYXR1cmUgYml0cw0KPiAoTkVUSUZfRl9I
V19WTEFOX0NUQUdfUlgsIE5FVElGX0ZfSFdfVkxBTl9DVEFHX1RYKS4NCj4gDQoNCkhpIEZsb3Jp
YW4sDQoNClVuZGVyc3Rvb2QsIGJ1dCBob3cgZG9lcyB1c2VyIGNob29zZSB0byBoYXZlIHRoZSBk
ZWZhdWx0IG9wdGlvbg0KZWl0aGVyIGhhcmR3YXJlIHN0cmlwIG9yIHNvZnR3YXJlIHN0cmlwLCB3
aGVuIHRoZSBkZXZpY2UganVzdCBib290IHVwPw0KDQpJIGRvbuKAmXQgdGhpbmsgZXRob29sIGNh
biAicmVtZW1iZXIiIHRoZSBzZXR0aW5nIG9uY2UgdGhlIGRldmljZSBnZXQgcmVib290ZWQ/DQpB
bnkgb3RoZXIgc3VnZ2VzdGlvbiBvZiBkb2luZyBpdCBvdGhlciB0aGFuIHVzaW5nIHRoZSBkdHMg
bWV0aG9kPw0KDQo+IFdoYXQgeW91IGFyZSBkb2luZyBoZXJlIGlzIGVuY29kZSBhIHBvbGljeSBh
cyBhIERldmljZSBUcmVlIHByb3BlcnR5IHJhdGhlcg0KPiB0aGFuIGRlc2NyaWJlIHdoZXRoZXIg
dGhlIGhhcmR3YXJlIHN1cHBvcnRzIGEgZ2l2ZW4gZmVhdHVyZSBhbmQgdGhpcyBpcyBmcm93bmVk
DQo+IHVwb24uDQo+IC0tDQo+IEZsb3JpYW4NCg==
