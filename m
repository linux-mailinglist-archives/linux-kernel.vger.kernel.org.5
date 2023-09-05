Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C5793238
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjIEXB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIEXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:01:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2D11B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693954899; x=1725490899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=suEl6/ejUQokukMpoo0n9WV0D6vkO3cpxFxs15Tso+4=;
  b=PF4ZySvn1ZCm4L7T9CeSZhggd2DLQA5B8uxF8at29nbJ40M3qcCfNLkI
   ZbrV4fonpg+NoEEUGo2/QjwQoA8KD3MZtru8mI+gJjP7GHJhy0QmTR76/
   ww1Se+cAYH+9HwcuV25SwgjIQgUaGB3clz+jqgoGaUMfRqDebOpcGZg1A
   YhPAid4dv5kSoUD5G9CExDukgUwdSPJqE9QMv6EOSzYwLZeKmgGXdMhq6
   1tMFWWxqHCTdAuE48LLyNtJ1FXSJcDURDuRmloLnVFb5a0FqaoLus6NYv
   tE8FK0/PlAu57taFY1/SExE4gqY0+XtzjT89S5rz7aaa0kA27M6r7Nlo/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463301005"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="463301005"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856179106"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="856179106"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 16:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:01:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 16:01:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 16:01:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 16:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1GVgy8Pj8k2XvW8JY6JIAZ0qVknFslLeOhlwIrDMKMhJnkSLeBS+ugH/mCInTEs/p1X4jpho5F8KDXF/hZu680PYQ529/DKmMfC1MZUFqI9leR8rLwiHe4zqaa7tRGsF+WIT8cgafL5kyqy5E4QHAyST5L0SdKIX/EB7Lm+aBf2KVQlDcXqPDkkcK8QLwRPbLmChYh0Un/cuSVLnrYOFidubU29tVJPLCsqjpOxf9X9uclibomTghsDNqysAOJhqFXve1VSK9fZoVEk2wPZAxSJMX7GUJ62mOCN05nZ3dtvu64jdU6ZnjYDhIVC0lhUgoxg0RFrTJ+tSZDLj4ydFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suEl6/ejUQokukMpoo0n9WV0D6vkO3cpxFxs15Tso+4=;
 b=nb09d/JvQSoqiPgAVCdFXALjpmCVUhjDJnN4K2AADxCnilaUNxCxkpg3YeEb9qo76F1KcxSdMn5Idh8sSDLFEFRQkmbJ4pyvqxEB9t+N55LZj34pW33J2plMOJ1jrllSyZo9UlIhYON3r5iqIl1FNdQDLD8717f9qLyWXSreSrqXg72jLN710zSkVa/c4q9+0R/ezj9YCHZEdjO+0IT1Oh93bGNNA4l2TgxiCC1ou+5H6b+OLKhti6yAd4uEbOSRApaxa/l9a2hjeGQLKHbWZFTmfpv0nD7hPaOUpn2dqamBMo2vRCyZqrPONW5NtnKhn8MbvuTQMJixmNCXKLAEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 23:01:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 23:01:28 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZz2d2h64fZccrFk6GvcmTUnLRhLAM+vwA
Date:   Tue, 5 Sep 2023 23:01:28 +0000
Message-ID: <0728094e1d8751355360987f17fcc2db18b43ce7.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4544:EE_
x-ms-office365-filtering-correlation-id: 0cb01cf7-b87f-4201-4657-08dbae6409cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXIXEmFoiKmggR1JGd9MKZf6ABAHotkU+fFNb5q1XWJyWVH+KViBGNU/FcJHD7seiP177F6c1VKeKj6vMb6m8v97mfOij624fla/4gyA3I9jN8CEJNQL9c/0oSxjjI+qMEunah8GL76Aui/LsWDyzTetNphizIB8fxWzVxUEWZgSJ0LxkjQQfUn8Ysx35LdRKPvBcn8Iy8T8oEc8dTIOManPrySC6Gjbk/7yqPmLUO3HpAeSLzQBZjgmnBUb6u9jkmqAeUgkJKSQum5dJ1UH3zs87LZX6D4I73ivH/XJxtXTrXYdyLc/uAq3tf3jOg3I9tY0GzrLH/jVPlAsibrMFurffyUmfkoGu/wXHWK6zGx9TEOjqVeDWqcIqKcoQZ7Jb+3xVAJhHuomc2nQDNpvUWfN1kHMsXrgxlCdxyIt4qSH34TDql9C5rGtva8fOFwBE36bSP/BSqLQcmJCEX0ZelydRoqDetpQEcjEcrLkFjbLR7Q3ISErdtV+sTTPj3mYQGCXr5Yp+guECjSf7KkBAKAe+uABluYDjyDp7Df6c9DGgX29jpmRW8s4T8EIn9zWpj7FsvrR1TRTTm4MpCxGlOP57HhQCh+cjd1lI/ksuDGK64nkn+/DqdDZvl6TNzph
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(451199024)(1800799009)(38100700002)(38070700005)(54906003)(64756008)(41300700001)(110136005)(66946007)(66476007)(76116006)(66556008)(82960400001)(2616005)(6512007)(26005)(122000001)(6506007)(316002)(6486002)(71200400001)(478600001)(7416002)(4326008)(8676002)(8936002)(5660300002)(4744005)(91956017)(66446008)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJWY0xySGtvRUFUZ2tXZG8zVWJnMS9GbWFjaVY2RWxOT0tKR1ZkQk5xc25Y?=
 =?utf-8?B?NWdsT1JtY3dPTDcxN0UyWTZNaHlhYVNMeU1qcWZKZENHNnkwRlltT3FmY3Nn?=
 =?utf-8?B?Rlg2Z0x1OGpCVWNEWklISnBvdzlRcHVSbkRmNkZGKzUrc015MFBOMlVnTEdx?=
 =?utf-8?B?UGhkdjRyTmtBVEtIOTZrTVJqeGU4NUh6YUE0Z05CS04wN0UyWlA5Y1E2VVVw?=
 =?utf-8?B?YWphNDJROFVVMURzMHhqVEpPRFRZNGtQcHhxNHVCNWZqbTFLdGNoU1BQbnBx?=
 =?utf-8?B?UzJ2UHp4bHB5Y2ZJQ3B4dWdVL3ppajZGR0pXdEhJMlgwV1o3T2JlTE9sdGVi?=
 =?utf-8?B?NTdYTEpKN2tXcytHOFpCQ3Z2SHJZSVNuSDZLL0NQdWdYVlpNbTJlRExVNXBN?=
 =?utf-8?B?cFZWc3c2VU1CR1hseUNZMXR2U3A0RFhRRjlMWXVMWkNHNjcwbExiVDlFZzVn?=
 =?utf-8?B?UTZHeHlxckh2M1A0eUZreEg0alFINWt6cm5uUGhkT1JnY0Vac3l0bEVQYnB2?=
 =?utf-8?B?UzBnTGlKSVc3RGZ2QSt1YVNtd0JKRHNyMzRITi81dDl4RWlNSURMQjZWZEh3?=
 =?utf-8?B?L2hWR1hhVmhuWUxsekxtWUtoeGJkeTRVK0ovSGtUdXNoalFXU1FSa2N5bVdv?=
 =?utf-8?B?MkpDOTdYTC9GVWdSQ2RTVTlFTVZ5VHM5Z3BzY1h0Ykl3anplcERIYnY2TG11?=
 =?utf-8?B?dU5rUHNWZTFMSXdMZDUzekJCb011SWlUSXFoNlZBVXU2UHFpeDhEUldUSTIv?=
 =?utf-8?B?Q0E5dC9LaDJ6Umd0VGo2bjdxWExxNFJvU1dheWcwVU5GOEdyZFZpV1RoZ2FE?=
 =?utf-8?B?T1VTSXFOemZrZVpOcUJiOVgxYitCTitkZ29teFVvck5zUDdid2I0eFB6TUNO?=
 =?utf-8?B?bTVRQzBBanNnejg4NHVlOS81OEhNV29xcEgxdjNqUTkxcUV2YVRnaGRMYkRD?=
 =?utf-8?B?REhwazk4a0pWUll1NTAzblhSbFBhMFdWRGIzZFpOZU9oR0tHV0Q1c0RqQ0FT?=
 =?utf-8?B?NlhKTXI0aFEwUUUzOFF0QnUzKzVWS1F5aitBMDNTRjYyTTFVWHl1NGxMeTNK?=
 =?utf-8?B?TTNYMkI5VWwyemt6RUlCcVhNSVpnaXA5dmJNNGdUdFZRbDRvRmRLYUlxVXF1?=
 =?utf-8?B?OVkyOFp6QXNpTW5kaWY5S2N1L3A4Z0tjZzl6VGZuU09YdUhZQndUVUQ0MHAy?=
 =?utf-8?B?WmkvR3hmZVdjRHo1ZDNKeWtMVThRM3h4VzFDREZUbWdXUnMrSWZ4VUJ6VjVI?=
 =?utf-8?B?dlZuMHVtdVBnYzRGSXZaamsxaWNrMnVBZXk0NUpGbWtSQWtvQi85WDU4MktL?=
 =?utf-8?B?NlJGWUtlNFpTb004ais2bG4yQ1dFR0JiZHBCSmVBZWxrOEV5WENmTXplQmlH?=
 =?utf-8?B?MnY0K3cwVmJJbmc3MFdaSS9UU1lFNEFoY0RLUEVwQ0ZkM1FrOTIxWVJEZ0Js?=
 =?utf-8?B?dkZmK1M3Nk0yTXJ1Mkg3bGdPTE5sTThUaGhBN285TmdTOU91bnhJbFowNEEz?=
 =?utf-8?B?M05JVHRCTjBySjEyYU5EQlc2N2NnSGdHZVZjdzdqNjIrVzJZSnM0Y3U2Rkoz?=
 =?utf-8?B?NkVZNlVmZjM2Vm1OS3JIMmluSWVLU3dBRUx0cGxUMkFsTlpENUZxU0lKRWZ4?=
 =?utf-8?B?eFIwOERieHNMNWhBclRmQ0ZWUmk3Q1M2cGMwc0FRV0JZSTRkemtiZTVkcVNM?=
 =?utf-8?B?QW9FN0hFWkNBWHY3dGNQTTBseXN0ZzZMakFaYm1QYzBrWnljQUNONXhrVkZG?=
 =?utf-8?B?Ym1LbkVQcWh5MkRtUXQ0ZndDa2p5dVZDc0RSRUNlby9IRXJ2Rk1UNW9lMmZU?=
 =?utf-8?B?Zy94Y0ZpdFE1aEQ4cVg3Qk14SnArNmh6ZkZDdlZlUjdVd0xvRzhCWnFCN2o1?=
 =?utf-8?B?SmNrZXQ0ZHI1N0JyU3ZhV20yWVM3Rk9mNHNiYVhEV21nNExCbDh6bG1YOGJh?=
 =?utf-8?B?RWh6a0kvbld3UlBUM2RBSFU0SXdqemF3a0JvUHBBbTdxcE9zN3JOc1UzbVlB?=
 =?utf-8?B?ZFdJU1E0WktoZXhkazlMK1B2bWYzTll4MDZZeU4rUFhkSDRCN3ZiTHIrM0hj?=
 =?utf-8?B?Lzg3cnZkYlcycW5TYlZlRmh1WXU5WDJzb3dJeG43dlNoSDJ3RTBERHNkQzcr?=
 =?utf-8?Q?9bfEODd5rHHsLCTMNl1Zf593i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <754EFB2E04721041910DFE32418E4833@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb01cf7-b87f-4201-4657-08dbae6409cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 23:01:28.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4191OEjTjabaJvj0YeU1afTu3ikTF7otQ5EOjM5nYoMS2IHlc6SkuLHtdsw+7NH9HHmNogV8LDI249i8lTWVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
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

T24gVHVlLCAyMDIzLTA4LTE1IGF0IDIzOjAxICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IEhp
IFBldGVyLCBLaXJpbGwsDQo+IA0KPiBUaGlzIHNlcmllcyB1bmlmaWVzIHRoZSBhc3NlbWJseSBj
b2RlIGZvciBURENBTEwvU0VBTUNBTEwgYW5kIFREVk1DQUxMLg0KPiBOb3cgYWxsIG9mIHRoZW0g
dXNlIG9uZSBzaW5nZSBURFhfTU9EVUxFX0NBTEwgYXNtIG1hY3JvLiAgTW9yZQ0KPiBpbmZvcm1h
dGlvbiBwbGVhc2Ugc2VlIGNvdmVyIGxldHRlciBvZiB2MiAoc2VlIGxpbmsgYmVsb3cpLg0KPiAN
Cj4gVGVzdGVkIGJ5IGJvb3RpbmcgVERYIGd1ZXN0LCBpbml0aWFsaXppbmcgVERYIG1vZHVsZSwg
YW5kIHJ1bm5pbmcgVERYDQo+IGd1ZXN0IHN1Y2Nlc3NmdWxseSwgYWxsIHdpdGggdGhpcyBzZXJp
ZXMgYXBwbGllZC4NCj4gDQo+IA0KDQpIaSBQZXRlciwNCg0KU29ycnkgdG8gcGluZywgYnV0IGNv
dWxkIHlvdSB0YWtlIGEgbG9vayB3aGV0aGVyIHlvdSBhcmUgT0sgd2l0aCB0aGlzIHNlcmllcz8N
Cg0KQmFzaWNhbGx5IEtpcmlsbCBoYXMgcHJvdmlkZWQgaGlzIFJldmlld2VkLWJ5IGZvciBhbGwg
dGhlIHBhdGNoZXMgZXhjZXB0IHRoZQ0KbGFzdCBvbmUgKEFkZCB1bnVzZWQgcmVnaXN0ZXJzIHRv
ICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzJyB0byBvcHRpbWl6ZSBWUC5FTlRFUg0KZm9yIEtWTSks
IHdoaWNoIGhlIGRpZG4ndCBsaWtlLiAgQnV0IGl0IGlzIHByZXR0eSBtdWNoIGEgc3RhbmRhbG9u
ZSBvcHRpbWl6YXRpb24NCnBhdGNoIHdlIGVpdGhlciBjYW4gaGF2ZSBvciBkcm9wIHdoZW4gYXBw
bHlpbmcsIHNvIEknbGwgbGVhdmUgdG8geW91Lg0KDQpBbHNvIGZlZWwgZnJlZSB0byBsZXQgbWUg
a25vdyBpZiBJIGNhbiBoZWxwIHlvdSBvbiBhbnl0aGluZyB0byBvZmZsb2FkIHBhcnQgb2YNCnlv
dXIgbG9hZD8gOi0pDQo=
