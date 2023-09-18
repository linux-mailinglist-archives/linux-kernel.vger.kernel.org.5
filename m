Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1ED7A3FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbjIRD50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjIRD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:57:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA4FF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695009429; x=1726545429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uTWtBb7PnNIuvRV9LDil3lVsMUnEkvmErErcCOycRDU=;
  b=IAJAoNGWZcsax/WxuDK4XhrBlAbAyCjaAK5JFmDvpTb2YA8xScFoi+1P
   8LGEwiYX7g+zmNk5zIz9vTEDjOl+1k4weoo0qZfsnslDwXJxVBh+dJ+w7
   0Mk/KH6O+5l+5bYdqZTZ/opyd46tKKxx/TyXwBbcwVQrxISPvzQbjvvPo
   s5s8027r+Eth29IcEC8GGCQedbt7CWAcXstZ8k/CMqHdbCCAxGq5u04gg
   7bzK27qfc5EcrPqhaWxS1JjMqaUOfyhdKAzIlDWBMoqPixf9zVbHWkCpM
   ++zk2fH1AD3grVg7VGQy+e4UQsyDBPtjN+uuR72grc6g4WryBlPE9sVVK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382301796"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="382301796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 20:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="748863494"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="748863494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 20:57:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 20:57:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 20:57:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 20:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4blwFTnKSTUuiLuGpEa5h2AXZQXQiA22aVOWGB3z9dIisbkiyYCMQsS62veU/vmocYCkJwaxGVCNcIHYUSZwm64JsOFz1+OYIVdizr4mvpVC4f880QgBwjVg7ikQtRno25GUwsF0jJXI/x7fcAXewrVViTf8rQrL+5dsrDVupfv3nsj2YEj7G8ZBZ0/7Vq5n6/vUVNEWFUyg4KdiqE6KilLTFSQ1WaKteZEzKAmp1Lx11Ny37gbbKApkGFVNXH/xVhkHX3/RUOmNjfW43bc5iqt3aGgz4uC3WfFP+NeI7EotNaV6KYBqsSi+nPhrSfV0Tm8jqRindsqhFhoNC8iNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTWtBb7PnNIuvRV9LDil3lVsMUnEkvmErErcCOycRDU=;
 b=LBGCKR2YjmPAN1oUiBuZb15b4Ck0GjeUvE0cm24D4+0zJboIOw3vPSdZfI0RaXJtePLGG6ciT7honJnv8Md+wa7kPM92/ZANdBfGBU+t10jgvHFEXSabfRO4u31QDioHYUDtrJ7wBA7YSON4PXV9R8xeqxR85MTv+Abt/A7tXsPnRay2GXhmBa0XaI51mcrW9UMLDgn/K+nSjPRuCwU01jOnoyf9gc5kLCa1hsHx51gyeVRqWOZQF5tbheJFlsCUD+re3YQVYNxi1Ezci3TpDfzXni0imTag0Tf2RyAhdfbnI3rsFxvspT5O/kx0mnZJoNo3K7s1H/MwQekSLrV/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 03:57:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 03:57:02 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Fix __noreturn build warning around
 __tdx_hypercall_failed()
Thread-Topic: [PATCH] x86/tdx: Fix __noreturn build warning around
 __tdx_hypercall_failed()
Thread-Index: AQHZ583v2PfA+aNQqkiWFay7gdllE7Ab0DEAgAQoi4A=
Date:   Mon, 18 Sep 2023 03:57:01 +0000
Message-ID: <c14474b7e646fc861e5aeae704705645ce6fa24e.camel@intel.com>
References: <20230915121208.307807-1-kai.huang@intel.com>
         <ZQRNiTVQu23wFC/d@gmail.com>
In-Reply-To: <ZQRNiTVQu23wFC/d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5463:EE_
x-ms-office365-filtering-correlation-id: 545496d4-dffd-4556-70de-08dbb7fb5093
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33XB84nf+8WH5Lk7o1ctsq8afLvYJ4Gn0Gw2hcBH6X8aXMQOzbHBBytLJ2/PLcNLkWqiVwchjoN9tQNJ5z+xSivcRn/hgWfJF2K/qpArgSj4bq3HGd0ifEQf3EYdBu7lCLFLFVgHFSlwThBBRN0Is/ZyFsJmCeI4Ku4F1JwvR8KuLN/2BDPCRWwRq7/Sdk7xeuEfZOyep3dWJzwfV0QD71f3FpppTTjmpdFiAX7l6AK7PsulK0X1Iaenf9Att3piltZAiKGcV9SIZtImDeAaZpgWQES4zKBMX3JbE0N9n2Y4fpAP2bWrjzWUoCv0VkTg1l1zviIFQF2JqXp7nXmp4WNGe/f2fpvXheJzWo9jMgXGuxWW56Xf+HGuoLbTgNRiFVzZGnUHGi+ZIfDM/63BlP7vnqX78vUX6M4GYF3fBZiiaf8QmucfeALueS7JC7pbyuGHqcPC6yFMWEbWS/41evNT0wceYJiKVSkykq8uBT/FwOX+jvHRot6UlWEpmqb4ajJZm9zgSczOAidyiFy3rWPOmcb2QzJAzQCzGYT3ArbZfE455Q4BiT8gdtI6TZEaFM6O4+5DFoRFbk4NVGgP12nWqXzNfDGnz1Waol640mU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199024)(186009)(1800799009)(122000001)(36756003)(82960400001)(38100700002)(38070700005)(86362001)(6486002)(6506007)(478600001)(5660300002)(66946007)(66556008)(66476007)(66446008)(54906003)(64756008)(76116006)(2906002)(71200400001)(8936002)(8676002)(4326008)(966005)(6512007)(83380400001)(41300700001)(7416002)(91956017)(6916009)(316002)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEszQ3V4WEJxRUpEK1ZkZWRNT0NvTzk3U01mN3NtSU5Wa2VXTktIQjA3a21B?=
 =?utf-8?B?YXZWQ3VCSndheU1HcWl4YmYya3B3UWoxSkdWbjlwZjhGNkNsZUtCdDZjSlZo?=
 =?utf-8?B?MHdMMWxiWEVVU3FoaXBqU0xSRnBYSGdNYTFpU0k3bythWW5sdnNyR3hCYks0?=
 =?utf-8?B?N0oyR2ZUWmZzdkNLeVByQnJSNWc5bnhFZ015Y3NnM1cza3dnS1pRcEFtNlU1?=
 =?utf-8?B?R3ZzeXRJRmZtWm1oeEl2bjExUkhKRFppUDZpR1FWMUZ6azhQbHJDMFpOVDRl?=
 =?utf-8?B?T1llZjJ4MzRFU1FvUjEvTmtDdDg0TjNnSnFoSzlSajcvZzJGS0VhdWxlUUEx?=
 =?utf-8?B?WWV1Ymdxa0hVcGFOQkZ0enhqYWxZYk05MWk1Nk5sa1dCc0ZVZmtDU3JYRGhn?=
 =?utf-8?B?aXpFQ1g1dmpDRlBuVENTS1dyd0I1K3AyVjJZTlAreUZWbncyUmlVRnFOWEo0?=
 =?utf-8?B?dm02YUhsTkM0eDJzVXNGbU1jMWlDY0VNKzNFdHl5ZEFYWFRBd1pkNHcwWFpW?=
 =?utf-8?B?WnZvWFlzWCtlTFRnRnA2TUVIeEZrOU05YkpnOXUyR2dibTZBTzhCckVwbmNV?=
 =?utf-8?B?blZiMzQ2ck0rdGZOcXIzS3NzWFFmMkNmc21OazdZTjFpY25mS05RdzRxU0hh?=
 =?utf-8?B?R3o4aW84MURmdmEzdHhDUGd0OS9ucE5JaDF6S21iQk5hZ2F2SW5kM3dBVURV?=
 =?utf-8?B?YWU3YWRZbUNFOG5xcVRkUXNyV24yVWI5K2pzWUdQYVh4UitOSUliSFI3K2x0?=
 =?utf-8?B?N0xvMGxkVEdWQmN3WUlGWUVTTE1Za0FxNFNsLzRQaVdNcmgwb3FUQ0p1dDhi?=
 =?utf-8?B?TUM3R080NHZuTFovNU9NMmhtRXczRWpsdW1EQ3JJNzlqMFBMM1lUMDlxZXRH?=
 =?utf-8?B?dkN4ZUhVWW5xanZNY2FGMU9TNmJDaGZNbDNEZDVKMWE1Nm8waURyTFFjNzFF?=
 =?utf-8?B?N1NGOXRFblI4NjREbkxNYVZtVUhRZ0tNdWJkNWoxL1hvR2RHOE13ZkphS0t3?=
 =?utf-8?B?cWFnRDd0ZVJoUnlXaUgzTm42c0QwMExnV3hWQ09MRXo5L29ub1hoR3g1YStp?=
 =?utf-8?B?eWgvQm94Qzl3TjY3cW5Ca2VoOHJJSUx6eWNVeUFIUkNVV0JkVEwvT1htaFpy?=
 =?utf-8?B?bEVFRm9UOFBTTmFoWTVaMWNqTnFvdnR3UHlvNHhiMjdpNlU0YU5kVTA2TWV0?=
 =?utf-8?B?S3kxdncyUEgzeEV0dnZuUHVzZjYyUFBhYXFWSkJmNXpIQUN4NXNLYnYzaWRB?=
 =?utf-8?B?azhJVTdwQUxVOUs0MlBwNnZBNnorU0VMZmpNTnZUTWFySC9LdEV2aFlpQ01m?=
 =?utf-8?B?UGlxM1NvVjRjbkNlK1dnNWZ0bEl6eW5nQ0E5VEJNV3ZSQ3BSOXlLN01oQTI0?=
 =?utf-8?B?Y0tqb0RSbmV6OXFOMTl5a2k2N2lDUXhmS2FPci9RVXdGVVBaVVlWSWNQUnVy?=
 =?utf-8?B?ZkVSclpUdHV3bldvQjNDN1hRSWJxSnBPckVxQ0NueWtuYldQalQ4bjN5OHkv?=
 =?utf-8?B?cDlwckdJRng0c3dFV0hGQklkdEhQbWVzcUtQYUFXVUxITk0yNDI1cGsvSk44?=
 =?utf-8?B?WDdhNDVidTVsR2RjdXZLbStZdmZnVDh5dU1nc1JyZHhhSWdHZWRYWkVjREtm?=
 =?utf-8?B?dXpDNUtFWXpkTHl6U0JmSVBNRTh3VEorLzVlSFdEbEc1c2JXMzgwRStHUjF3?=
 =?utf-8?B?NmcrRXZVcnNtbzVXdE9LUFRETDJWcmc3RzdqcDBWeHg4NENnNkxHNi80eXpT?=
 =?utf-8?B?ZXVGVCtCTkQ5WWdVK0VSNUFrRHRLaGVycDYwano1a1hJVDAxckd6YkF2YW5p?=
 =?utf-8?B?ay9uelUrdktORGV4SFl6U1M5MjVxTnhEb3d0Rm1SR2JPSUR2d2JRSUF6YU10?=
 =?utf-8?B?Q01iQ3duK2E3cy9MSml3dFlYYTg0WkxrTHN2VEdiT2s1bzd2Tll2RGlDdkQr?=
 =?utf-8?B?cUYwUFZSdEVzWjB0YnN5a3NZWjI4ZDJuZG9uaG40bmN0SFlaZklCdFNSSzFv?=
 =?utf-8?B?YTJxejRQREdvaTBPQW5JN2Zpb2N2MXdhT21IZG9hNzZCL05Oek4xV0tQRE12?=
 =?utf-8?B?QXVSaXFEK1lvYlMzcUFIMjRMUHlrOG80YlNRaGR2dlRySFNqUWQ1aHFYOGFz?=
 =?utf-8?B?Q1B4VVVMc2F6MGRsa1Q1M0NzMXIrRHV5M0lmVW1TUjgzRm44cCtYTkpRVW9x?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEB1A198005EC94FB86B4D347FEED190@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545496d4-dffd-4556-70de-08dbb7fb5093
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:57:01.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29PbtMT2qJp/Q8wD+UlCjfSA3IalHyTWY9xaAcssh/Q49Zm+PoCVKxsDMyHS/3Jw/OMklIXgyUZxa1J4U5SA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTE1IGF0IDE0OjI2ICswMjAwLCBJbmdvIE1vbG5hciB3cm90ZToNCj4g
KiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBMS1AgcmVw
b3J0ZWQgYmVsb3cgYnVpbGQgd2FybmluZzoNCj4gPiANCj4gPiAgIHZtbGludXgubzogd2Fybmlu
Zzogb2JqdG9vbDogX190ZHhfaHlwZXJjYWxsKzB4MTI4OiBfX3RkeF9oeXBlcmNhbGxfZmFpbGVk
KCkgaXMgbWlzc2luZyBhIF9fbm9yZXR1cm4gYW5ub3RhdGlvbg0KPiA+IA0KPiA+IFR1cm5zIG91
dCB0aGUgX19ub3JldHVybiBtdXN0IGJlIGFubm90YXRlZCB0byB0aGUgZnVuY3Rpb24gZGVjbGFy
YXRpb24NCj4gPiBidXQgbm90IHRoZSBmdW5jdGlvbiBib2R5Lg0KPiA+IA0KPiA+IFF1b3RlZCBm
cm9tIFBldGVyWjoNCj4gPiANCj4gPiAtLS0NCj4gPiBGV0lXLCB0aGUgcmVhc29uIGJlaW5nIHRo
YXQuLi4NCj4gPiANCj4gPiBUaGUgcG9pbnQgb2Ygbm9yZXR1cm4gaXMgdGhhdCB0aGUgY2FsbGVy
IHNob3VsZCBrbm93IHRvIHN0b3AgZ2VuZXJhdGluZw0KPiA+IGNvZGUuIEZvciB0aGF0IHRoZSBk
ZWNsYXJhdGlvbiBuZWVkcyB0aGUgYXR0cmlidXRlLCBiZWNhdXNlIGNhbGwgc2l0ZXMNCj4gPiB0
eXBpY2FsbHkgZG8gbm90IGhhdmUgYWNjZXNzIHRvIHRoZSBmdW5jdGlvbiBkZWZpbml0aW9uIGlu
IEMuDQo+ID4gLS0tDQo+ID4gDQo+ID4gRml4IGJ5IG1vdmluZyBfX25vcmV0dXJuIGFubm90YXRp
b24gZnJvbSB0aGUgX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCgpDQo+ID4gYm9keSB0byBpdHMgZGVj
bGFyYXRpb24sIHdoaWNoIGlzIGluIDxhc20vc2hhcmVkL3RkeC5oPi4NCj4gPiANCj4gPiBOb3Rl
IDxhc20vc2hhcmVkL3RkeC5oPiBpcyBhbHNvIGluY2x1ZGVkIGJ5IFREWCByZWxhdGVkIGFzc2Vt
Ymx5IGZpbGVzLg0KPiA+IEluY2x1ZGUgPGxpbnV4L2NvbXBpbGVyX2F0dHJpYnV0ZXMuaD4gb25s
eSBpbiBjYXNlIG9mICFfX0FTU0VNQkxZX18NCj4gPiBvdGhlcndpc2UgY29tcGlsaW5nIGFzc2Vt
Ymx5IGZpbGUgd291bGQgdHJpZ2dlciBidWlsZCBlcnJvci4NCj4gPiANCj4gPiBBbHNvLCBmb2xs
b3dpbmcgdGhlIG9ianRvb2wgZG9jdW1lbnRhdGlvbiwgYWRkIF9fdGR4X2h5cGVyY2FsbF9mYWls
ZWQoKQ0KPiA+IHRvICJ0b29scy9vYmp0b29sL25vcmV0dXJucy5oIi4NCj4gPiANCj4gPiBGaXhl
czogYzY0MWNmYjVjMTU3ICgieDg2L3RkeDogTWFrZSBURFhfSFlQRVJDQUxMIGFzbSBzaW1pbGFy
IHRvIFREWF9NT0RVTEVfQ0FMTCIpDQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPg0KPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Ut
a2J1aWxkLWFsbC8yMDIzMDkxNDA4MjguOVJkbWxIMlotbGtwQGludGVsLmNvbS8NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4g
IGFyY2gveDg2L2NvY28vdGR4L3RkeC5jICAgICAgICAgICB8IDIgKy0NCj4gPiAgYXJjaC94ODYv
aW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oIHwgNCArKystDQo+ID4gIHRvb2xzL29ianRvb2wvbm9y
ZXR1cm5zLmggICAgICAgICB8IDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29j
by90ZHgvdGR4LmMgYi9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiA+IGluZGV4IDNlNmRiZDIx
OTljZi4uNDcxMGQ4ZGQ3MDBiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3Rk
eC5jDQo+ID4gKysrIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCj4gPiBAQCAtMzgsNyArMzgs
NyBAQA0KPiA+ICAjZGVmaW5lIFREUkVQT1JUX1NVQlRZUEVfMAkwDQo+ID4gIA0KPiA+ICAvKiBD
YWxsZWQgZnJvbSBfX3RkeF9oeXBlcmNhbGwoKSBmb3IgdW5yZWNvdmVyYWJsZSBmYWlsdXJlICov
DQo+ID4gLW5vaW5zdHIgdm9pZCBfX25vcmV0dXJuIF9fdGR4X2h5cGVyY2FsbF9mYWlsZWQodm9p
ZCkNCj4gPiArbm9pbnN0ciB2b2lkIF9fdGR4X2h5cGVyY2FsbF9mYWlsZWQodm9pZCkNCj4gPiAg
ew0KPiANCj4gSXQncyBub3QgYSBiYWQgaWRlYSB0byBkb2N1bWVudCB0aGUgX19ub3JldHVybiBu
YXR1cmUgYXQgdGhlIGRlZmluaXRpb24gDQo+IHNpdGUgZWl0aGVyLCBzbyBJIGRvbid0IHRoaW5r
IHdlIHNob3VsZCByZW1vdmUgaXQuDQo+IA0KPiANCg0KVGhhbmtzIGZvciBmZWVkYmFjayEgSSds
bCBmaXggYW5kIHNlbmQgb3V0IHYyLg0KDQpTaW5jZSBpdCdzIGEgc2ltcGxlIGZpeCwgSSdsbCBz
ZW5kIG91dCB2MiBzaG9ydGx5Lg0K
