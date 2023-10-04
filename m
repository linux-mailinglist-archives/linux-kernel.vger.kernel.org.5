Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1A7B8B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbjJDSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbjJDSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:45:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5298;
        Wed,  4 Oct 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445126; x=1727981126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5oaYxRBhUyzoXub2laEUGIA84HrQGNRbtK2ZWn0WnYw=;
  b=dvC5dPz8CeZTo9FV0G5784wQc/SIMcCvyI6Wfw98dN2kFteAXI0eSete
   hrxIAwpV4L0NuNqN8s43gYWvlGaoEaa2ABPaH6R7OHKAjbHA85z4Qq5XQ
   fP6Hk102F2rAu+4l89nGzA7o78n0KaQrpc3wgfnTEsEPiyF5bA3y9ZWAl
   H7rSv0aX2YI+kKf23TjUQwN5HtZ6uKrMNJ88bkABNhARYCfDNm9oFwQ7z
   QRu2b0IOjv3KhzR/d4rZTV483OlnUg9LqHef0FmhKs0XsL8U/VpiOLaoz
   SpInMd/inJleC6JXozC/etzPqwOFlracA/dZajmSaX1jTvPZZHsRXzVH4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387135744"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387135744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701243348"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701243348"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:45:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:45:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:45:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:45:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj7MAvbFv7vZg4ZZ2tvGZUM/khT/Crtug2DnuiD9vRVjxuCErCrdSQ+zNbF7LHMtWLMK8hvHoFIYGKcwnsUGtSOpHuCm23PaU9OZnH1Rplk9BnUaTNOzB/ywO8kRZ9TWV7CkLX+dIvKyZ46kPVvKB2GvImOcZexieJGRunfQICBbN6L3mhyka+ZqZTEGICbRw+mF3EqH2KNq7AN6UVxSf6VQXzDkYu2A8p6A02zCpcTKrBztdyWdcv0vy7OQt6wlkLjUZva3YBhfTm+F57BGYhrHat4NDT8infm9IgBsHa8u9Eaw0i5URfrgRd/SU0i1PHeBLEshA0I+LNxTWnxPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oaYxRBhUyzoXub2laEUGIA84HrQGNRbtK2ZWn0WnYw=;
 b=RD+3CeK75AjeRL9RIvxG2SbloU+HNmcJUMAYN1dMR6p2Y+iNEk7FrcgowppUgVKxLu55IeMdK3KgIFJQ6c/MX79LYH2GbIlAIGXjKXFH1PnHlwMmmEsOU6XI9rDmI7I5eQr2RlgdPdLEagd8nm9qQQzLGOPGDwYZlJKBCAkiHkSFCH/quVk5H4eZgT4zmlTaX00FhW/qYaJqHnDhyHq44gZ6jkh8NY3kzXK2yHRoLjK32wppPUPucd8uS1DASbSb5HWlGXkh0sHTegknQHAR6rXhubiarkA7pHCql7R8pHO6IAPhBGIj8Wv59XB3UajCuDguXoL2piVx9PiqJ0NHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 18:45:23 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::3c56:2e9f:2454:cd41]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::3c56:2e9f:2454:cd41%3]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 18:45:22 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Wang, Wendy" <wendy.wang@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Don't warn about BIOS locked limits
 during resume
Thread-Topic: [PATCH] powercap: intel_rapl: Don't warn about BIOS locked
 limits during resume
Thread-Index: AQHZ9vGC7b8aRH0YYECKlKiqXJ0UBrA59/kA
Date:   Wed, 4 Oct 2023 18:45:22 +0000
Message-ID: <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
In-Reply-To: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: 4f91e3d9-8534-45f6-0b8a-08dbc50a110e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkwY0NMzFCwK+iunKWBrWxAFVeR5XxPSje5S+8gsyzTfdoo7XIBMH7vSOQnL6minv2OQn4/mdXxS4hX6/CrzhLy30I83RbPm5ysYOYO1dlr6dD3ilrUqKErBVrh30hjDJZe0X0UNG9C3IGtI+jW4z2nM3tfK32O93wE8XQvPL1bcJmFJiFXbyZo1DQQD0ly+4GBMonX5dzJs0eqptwMFNWIJfSBDn+Hjg4fNsCfO2kUQKCLyJyyXU18P4RC8G0P2f2LbPAceB8f/ag5HOVQ7akN47AO0usJqqIaHNxM6PcF+Q3RVq4LsOHOatsqSa0PDba1bpuupNnZ2wFywlQsO1/pEQzqA5MtdfGsc2JzvDehHM9ER897TFbWObPS6yclCQoUUslS7n7RfFWzGzX/6RygF+ZWqCs3fdsqIdwZ8bcTmV6QGaN0YKYYKmbPeZhdpo3iyt5tPYgXsgc25YjQX5OkvyZ7lrJ5hzKDt+8h9PQFIcG+hEvSZnoZeXH5kIWDfArYxqpX0q/JMg6Svc5dLtsBhOFcNWSvJtlhpMOd2OIRgjZ/Cft0XxaR5Vnx5wv8/lbFzKTD+mMUOUIqNkSpov/WrpX+s4QW5QnKaXckLapDBnHJmAwWx5KTCJ5MaiY1M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(2616005)(316002)(66556008)(66476007)(54906003)(64756008)(66446008)(66946007)(91956017)(110136005)(76116006)(66574015)(26005)(71200400001)(36756003)(6506007)(6512007)(82960400001)(122000001)(38070700005)(38100700002)(83380400001)(86362001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNiR1JVOEt2UDFlUmd1QnNheHZjYW9NSGkyUjFZUXJOOGUyTTRSOURsME9B?=
 =?utf-8?B?blNqSHRtTWFsdGhib3greVVvc0MycWFyaHdGdU9vYkRrTkNjanFqSXdDZXVX?=
 =?utf-8?B?LytoVFRBNC8wU2hJV1Nyb2FQYTZVU1BidGNDM0VxM0xnR2EwYTE5ekY1OUt3?=
 =?utf-8?B?aTVDVmpZcEovbHRyUGhqblFKaFNkWkw2RTkxMGdhaWx2VnNqUEt0bnhwT245?=
 =?utf-8?B?M0xncEVwblBobEtpbHJJb0FMVU16UUZSckFTMVlkVEg0R0liNlJtMFFpeW5h?=
 =?utf-8?B?Vmxvbmk4UTM2SklCb2xRRFZnMWk0SDlMSXJPdWdjZWJxaE5Gc2FLaEdtMTJQ?=
 =?utf-8?B?ZlhWakg5eTY5SFBnRzh1T2hNRnJuSGFocE5ydW45ekVWSUh1dHY5QmxmQzdV?=
 =?utf-8?B?dWJ4RlFZSjNaeFBTVVR2QUMwZHk1UEZmdENDOWNDWGcxUXNqeUNqclB3T1VN?=
 =?utf-8?B?bkVUYmQ0SWFDVVlNNlg2SlJuMFNIZlltc05JeDBMcHllazlmWVlMUmFqd3Jl?=
 =?utf-8?B?ZWxXK1BPOHl6MDBqYldESkhZRXlCU3VOUFZQb2RuYmt5QVRaYzVEVkNYOE1z?=
 =?utf-8?B?MzIySVFLZGppajRkaFo4NVpyMWVlQWp4ZS9OeVFOaTFpdVBPTHpib3hxUUtS?=
 =?utf-8?B?M0VwWWxCT3YzZWMxWWVTWG42TzhJbkg1djVjSXRLVU9ZaG1jd3M1MXJDakdS?=
 =?utf-8?B?aHFMSjM1VlFBbTNRVzNucytvc2ZzajNDZlY0cTBSdlRIZUhMa2dYSlBUTnha?=
 =?utf-8?B?UjhvMjJROFZXT1ZRVzVMc2hjbFJTRW1nckVVMisyTWZXQXBMYThEVDBMeWds?=
 =?utf-8?B?UDFqY1FQNldDOTZLZVo2ZkdCeG92cGdIYy9vQklaY3liZXlnNlZLOXZZWE5m?=
 =?utf-8?B?d3BNS2VqNWlITFRTV1g2cUtSdW52Zlh4UkpNaWozSGhDRnM1K2JXRFZNTTRs?=
 =?utf-8?B?ejh0WFpKWHdPTmw5M1hXTWFsdlhGdStwZ2lhanoyRkprakc5WjIybEZuYnRU?=
 =?utf-8?B?cU1uVEFiS2VUWkZ4eVVFSmlOSkFtVGh3VGxmaXJrYnJMQnhza0w5Q1dYWVVI?=
 =?utf-8?B?U0Urc1VDaVNYemlqeEJmTjFEVlU0Y1p0bzJ3cU40aFNDWExyaUFDUmZHVmYx?=
 =?utf-8?B?cWFqUHRZSEg0blNuSXF6cFIzWG5zUjA3YTZLUEpvUTEwK1h5aERSUGxMcEI1?=
 =?utf-8?B?ZWcwdUtISUlMcjMrbmpaK3hXaG1IQlE2bWhpZ25nVmxTM0ZCdC91Uk56bG5L?=
 =?utf-8?B?K0lzUXgzQWRsVzE2QzJpVzdScUFjeTFQUWFKUWZBajdQTjR4Vlh5M2pPVjRJ?=
 =?utf-8?B?Z3AzejJDeGdYSGlSV1dBdkVTTi9FQWYzUTNPU0FtaWMwVEJVdmQwenQyL2ZC?=
 =?utf-8?B?U1BXMEJ6NjZZamxQTE5XYitCQzVUTUs1RmdXTW1BUHlBdndlVmhxQmNRQmJt?=
 =?utf-8?B?bzlYd2QybjZCYnJCYXlpUmZSL0MvRFZJQ0dKeXdCZE9pa0hUTUE0UDRwZDZN?=
 =?utf-8?B?eEFpblRKakMrUG9GOFNkWmdMbW81bkxkU0hkTlp1d3BrMWJLYjlMdHdJQ0dZ?=
 =?utf-8?B?NjJhWWQ5dEl5YVVEZ3I4bU01SXhVVXdBT3MwWFNXNEc3cHAyQXlzYzg1Q2kw?=
 =?utf-8?B?MlBJeVVVQy9ONHhPb0xxQUJKSGw4VWs0bnR5NmMwZHVpZnFKcTRMd3Y2UzRt?=
 =?utf-8?B?K1p0Mi9CQllra2p4bXp6bG9HUTVTall5bzRIcTJZT09sdDZtOUU5TkJ3WHpQ?=
 =?utf-8?B?Z0h0Qm15TGtsL2hwSk1rQ21MM2pjL1J4dVY3Z2RuR1F2Vi9hdXMzZEVCU0ha?=
 =?utf-8?B?c3JhblhKNXlkUm1NNURVem5KV01XRFJlR211MGdpMlh0Q3pyazBJY3ZFMUhq?=
 =?utf-8?B?QWRXNDJiVWtiNTZVV25sdmJkNnJjcDlkMnkvMGdzcFpQK0VDd1pOZ29nWmNF?=
 =?utf-8?B?WGpPZ3lIYzZ0bmlLS3d0UWtrV2tidHhINmlrZHdZWW5ZZFJGYnFTRG9CTVlk?=
 =?utf-8?B?Q3dEaXFuOEFoM29WeVdjR29ITVptWmljaGIxUW8ySC9UUW5xQk9JVE5Zandx?=
 =?utf-8?B?SzNMS2RpWndBWkFVNFJFTW1tSkNwSVNGUmZ4VytJbjFMSUpyeEJucElzancy?=
 =?utf-8?B?bmhzZ2FTbDh5SHVmYStEd1pFbDdrYmNOSGF6WS9hdksxeVdveHlteWJRa203?=
 =?utf-8?Q?DU2qEFR5eQXOjuMvQZhJReY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63D391C8973FD74F9F3B0D884495438E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f91e3d9-8534-45f6-0b8a-08dbc50a110e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 18:45:22.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSl+Zty7dfh3PJyoyexr9juvVPfXAqqMjLGGUFd8irHN2Du2lN5Jbc8elLlD2vIVxI3EGK9dKLNUZb3FszoUvFp2k84ykpY+8/kNSHAhGwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDIxOjM0ICswMzAwLCBWaWxsZSBTeXJqYWxhIHdyb3RlOgo+
IEZyb206IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4g
Cj4gUmVzdG9yZSBlbm91Z2ggb2YgdGhlIG9yaWdpbmFsIGJlaGF2aW91ciB0byBzdG9wIHNwYW1t
aW5nCj4gZG1lc2cgd2l0aCB3YXJuaW5ncyBhYm91dCBCSU9TIGxvY2tlZCBsaW1pdHMgd2hlbiB0
cnlpbmcKPiB0byByZXN0b3JlIHRoZW0gZHVyaW5nIHJlc3VtZS4KPiAKPiBUaGlzIHN0aWxsIGRv
ZXNuJ3QgMTAwJSBtYXRjaCB0aGUgb3JpZ2luYWwgYmVoYXZpb3VyCj4gYXMgd2Ugbm8gbG9uZ2Vy
IGF0dGVtcHQgdG8gYmxpbmRseSByZXN0b3JlIHRoZSBCSU9TIGxvY2tlZAo+IGxpbWl0cy4gTm8g
aWRlYSBpZiB0aGF0IG1ha2VzIGFueSBkaWZmZXJlbmNlIGluIHByYWN0aWNlLgo+IApJIGxvc3Qg
dGhlIGNvbnRleHQgaGVyZS4gV2h5IGNhbid0IHdlIHNpbXBseSBjaGFuZ2UgcHJfd2FybiB0byBw
cl9kZWJ1ZwpoZXJlPwoKVGhhbmtzLApTcmluaXZhcwoKPiBDYzogWmhhbmcgUnVpIDxydWkuemhh
bmdAaW50ZWwuY29tPgo+IENjOiBXYW5nIFdlbmR5IDx3ZW5keS53YW5nQGludGVsLmNvbT4KPiBD
YzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgo+IENjOiBT
cmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4KPiBGaXhl
czogOTA1MGE5Y2Q1ZTRjICgicG93ZXJjYXA6IGludGVsX3JhcGw6IENsZWFudXAgUG93ZXIgTGlt
aXRzCj4gc3VwcG9ydCIpCj4gU2lnbmVkLW9mZi1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5z
eXJqYWxhQGxpbnV4LmludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxf
cmFwbF9jb21tb24uYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gLS0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMKPiBiL2RyaXZlcnMv
cG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYwo+IGluZGV4IDQwYTJjYzY0OWM3OS4uOWE2YTQw
YzgzZjgyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24u
Ywo+ICsrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYwo+IEBAIC04ODIs
MjIgKzg4MiwzNCBAQCBzdGF0aWMgaW50IHJhcGxfcmVhZF9wbF9kYXRhKHN0cnVjdCByYXBsX2Rv
bWFpbgo+ICpyZCwgaW50IHBsLAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmFwbF9yZWFkX2Rh
dGFfcmF3KHJkLCBwcmltLCB4bGF0ZSwgZGF0YSk7Cj4gwqB9Cj4gwqAKPiAtc3RhdGljIGludCBy
YXBsX3dyaXRlX3BsX2RhdGEoc3RydWN0IHJhcGxfZG9tYWluICpyZCwgaW50IHBsLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVu
dW0gcGxfcHJpbXMgcGxfcHJpbSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGxvbmcgdmFsdWUpCj4gK3N0
YXRpYyBpbnQgcmFwbF93cml0ZV9wbF9kYXRhX25vd2FybihzdHJ1Y3QgcmFwbF9kb21haW4gKnJk
LCBpbnQgcGwsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBwbF9wcmltcyBwbF9wcmltLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbG9uZyB2YWx1ZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgZW51bSByYXBsX3ByaW1pdGl2ZXMgcHJpbSA9IGdldF9wbF9wcmltKHJkLCBwbCwgcGxfcHJp
bSk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpc19wbF92YWxpZChyZCwgcGwpKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAKPiAtwqDC
oMKgwqDCoMKgwqBpZiAocmQtPnJwbFtwbF0ubG9ja2VkKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHByX3dhcm4oIiVzOiVzOiVzIGxvY2tlZCBieSBCSU9TXG4iLCByZC0+cnAt
Pm5hbWUsCj4gcmQtPm5hbWUsIHBsX25hbWVzW3BsXSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJk
LT5ycGxbcGxdLmxvY2tlZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRUFDQ0VTOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmFwbF93cml0ZV9kYXRhX3JhdyhyZCwgcHJpbSwgdmFsdWUpOwo+IMKgfQo+ICsKPiArc3Rh
dGljIGludCByYXBsX3dyaXRlX3BsX2RhdGEoc3RydWN0IHJhcGxfZG9tYWluICpyZCwgaW50IHBs
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbnVtIHBsX3ByaW1zIHBsX3ByaW0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbG9uZyB2YWx1ZSkK
PiArewo+ICvCoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldCA9
IHJhcGxfd3JpdGVfcGxfZGF0YV9ub3dhcm4ocmQsIHBsLCBwbF9wcmltLCB2YWx1ZSk7Cj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKHJldCA9PSAtRUFDQ0VTKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwcl93YXJuKCIlczolczolcyBsb2NrZWQgYnkgQklPU1xuIiwgcmQtPnJwLT5uYW1l
LAo+IHJkLT5uYW1lLCBwbF9uYW1lc1twbF0pOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Owo+ICt9Cj4gKwo+IMKgLyoKPiDCoCAqIFJhdyBSQVBMIGRhdGEgc3RvcmVkIGluIE1TUnMg
YXJlIGluIGNlcnRhaW4gc2NhbGVzLiBXZSBuZWVkIHRvCj4gwqAgKiBjb252ZXJ0IHRoZW0gaW50
byBzdGFuZGFyZCB1bml0cyBiYXNlZCBvbiB0aGUgdW5pdHMgcmVwb3J0ZWQgaW4KPiBAQCAtMTYz
NCw4ICsxNjQ2LDggQEAgc3RhdGljIHZvaWQgcG93ZXJfbGltaXRfc3RhdGVfcmVzdG9yZSh2b2lk
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmQgPSBwb3dlcl96b25lX3RvX3Jh
cGxfZG9tYWluKHJwLT5wb3dlcl96b25lKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGZvciAoaSA9IFBPV0VSX0xJTUlUMTsgaSA8IE5SX1BPV0VSX0xJTUlUUzsgaSsrKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZC0+cnBs
W2ldLmxhc3RfcG93ZXJfbGltaXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF93cml0ZV9wbF9kYXRhKHJkLCBpLCBQ
TF9MSU1JVCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJkLQo+ID5ycGxb
aV0ubGFzdF9wb3dlcl9saW1pdCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF93cml0ZV9wbF9kYXRhX25vd2Fybihy
ZCwgaSwKPiBQTF9MSU1JVCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZC0KPiA+cnBsW2ldLmxhc3RfcG93ZXJfbGltaXQpOwo+IMKg
wqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoGNwdXNfcmVhZF91bmxvY2soKTsKPiDC
oH0KCg==
