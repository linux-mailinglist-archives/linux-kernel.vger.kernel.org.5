Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B590B78F602
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbjHaXNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjHaXNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:13:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37380E8;
        Thu, 31 Aug 2023 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523618; x=1725059618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vfoe5CF0/Ixr4NWrt62max3SNFUDGIAqhwzkPYw+Bw0=;
  b=KI8TyRaHLKC7qsiz6sU8VtFPaKi250jNmNg977SjxqT+l7qKoT7tuTaa
   v011x/BlYdjq3yQhf09xJQQP8uAIwFVGAixYiM1tYuwn5F9KxZsw1Fgco
   BtThINkJuh1Z9UmUzCSMrd1xhu9NWILXgzWujtjowp5B2/yjg2jRBWeSe
   1ahARWx2sK3wD/Tc/hOC2LYCD4Kw282dyqONISr5JL3nypVvm+rAcEmDO
   RCHPkQ5BQHUEwGn+n+Zgkw9anIcRAC9GrhPQaH01AtgNdjiJWsEU4V2L3
   xaHqpz3oFaRxxgk4f+V3cxH1oQrz4QoV80J8izIvzO3NZ3aIperlxobBx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373486649"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="373486649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854468485"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854468485"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 16:13:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:13:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:13:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 16:13:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 16:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzXMKEG1pShea2zksTlMD+IJ6pGFufuFc/166DlqQ6CnR7jBtUjtlekQWDxyiWaeb3xqMG+93M1NAfSip1MEggq8KAFIe94wurP8wFe8YjH3Eyw8JZp4jXZ+KtsvPtkMoTTCvwA1OkQw8Dq1C4BZm6N7P802+h28uUmvI0mhRm72eCcmKrf2miDA8pIqe4PoAj/jxzmCnfsdfVwgKYLRn6iXP97qd3gfZohIxOKP3Olp1x+gWt6fvREDP4yM/ACNuybdVclBgozl82/qpL28jZqoV2b34GpSDJtVnwpnMOQElOcDTzQuQHgUs1u5Uc1ov3NIhxnlpb4g686NELEBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfoe5CF0/Ixr4NWrt62max3SNFUDGIAqhwzkPYw+Bw0=;
 b=TgxLAF/FuicMNsOj2NrtG9KBCrtaG09x+c7tsFnZaZIliuOI8w1QH5BqHT/JeKvRK4c/7ExjbIWSFza/8PL7XrJuDrL4csYPehQ5mmn3a1gkZAmBA4he1a6T+9N39JhTbw8jnCp2HD7cQMQ11+GkWjtlvrURphWP9/AaRwpQQucB+lotlDbnbTpXCkHJsnhLEFyrZdmo/LRRDWPZl0CdTHXQAkq0D6PunfekML/V/ZIGvDA0ilc4Ms9PGm8jDR5ChZjI2I7tvzZW4rVhdZutMRIaRyYbjcI7l5ixk1p1ueehHWasXIfDyrtJB73Y77OFGEWXcb+fS1jA+9qFITgApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 23:13:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 23:13:29 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 08/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Topic: [PATCH v5 08/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Index: AQHZ3BD+2VzxzHuvHk+Rb9VXHpJD97AFCVsA
Date:   Thu, 31 Aug 2023 23:13:29 +0000
Message-ID: <c68971b3b9d4962d30fed845e8796ad028a65a74.camel@intel.com>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
         <20230831134144.22686-9-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230831134144.22686-9-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ms-office365-filtering-correlation-id: e254cfca-ccbd-4513-3b48-08dbaa77e34c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0zMtFEiO9n9Fr4CCsAAJBOvnWuh0oDq4ZddfE3/CZUiJEv8MyFXswWO0/43/jKlI38ZpElN0zzIG9VTJjsndmDBphiUGzf+NchB7KmfyfuIeNL5brK9wIyYyoQC4D8LbQ7G/Lr4aGlTEzimKjPtYXvJkLY0N+po0YddpjHIu9wIr3pGWJEAKseXg344Dm6BsFcM/liq6HxVsNZWwehU7fxF9KSnIPuIcEpGYWFfhgcFSrGvV+zHdC6xBzj+5udZFMSUiM0vv1hS8g8cCdrLgqgr59ChDlEvuSbOozIUda3q7N7nH70o+WLYtpBJMaRKq4+69TTgqud78QoY9jFFL9LVS2z1xIzts54RQKT0oh5enIm0kyZV1US9dwuPGasdUTdzAyng8hJ5o3fFvSTK27sxha0DIqxm/5fwpiZK3Ba362DMDLW6oh7sHwUpzXpRH3Ass5v5qs4DuM7todF3PItQhEGicaMAvUS0AnUkLvExh1B/dlMPLEYpalcD1a5lYcwm3qhTe/yBm7AVb7/ED+asmzXZzAbp23//t9v0dAtprwpehTIB3WvT2FywDCKTgW1KlNkIQKzQO40xvz2rNm2+92d6gUxJ75PkjQLo0wFTzpUQvezh9f4XUFfBcp1PAMKcFyc32+pl8HrbTgCFxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(1800799009)(186009)(451199024)(6512007)(6486002)(71200400001)(6506007)(966005)(2616005)(2906002)(26005)(66556008)(41300700001)(478600001)(316002)(66476007)(64756008)(76116006)(66446008)(66946007)(110136005)(91956017)(8676002)(5660300002)(4326008)(8936002)(36756003)(122000001)(82960400001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW9lNzJBOFZ4bC9SeVdXblN0ZHNqNFlsMUE1b2RFcUYveTE1MGdCOHpad1hx?=
 =?utf-8?B?QlRGTDdhSU9PTVNPYk9zakZreHQ5d1dNMzRHSW1rd0ptVk5Xd1ZnbXlrWko2?=
 =?utf-8?B?d1VidzFtMXdnU2tqRWRCTkNHYStvemg4MVJ5U2pQYnJCV0lNL0QwRERyL0Z4?=
 =?utf-8?B?bVM5Mi9FajNhOG1SNlVhZjUveDZENmtsWjA4Zk55U1dMRVI2WmpaZzF3cXVj?=
 =?utf-8?B?QWtrbVJJOHpXcDhodkU0U2phK2R0NHdXYjJNWFZBZnFmMU1Ca1huOHJVMnNk?=
 =?utf-8?B?SCtrUGtsK0l1VEdYN0F5R0F1NjFYaDFxSmJOUzZpRERVU0hLS3BRSnJXS1FZ?=
 =?utf-8?B?RUttclJRSVdBUG0vdnBnQnBhMm1DVFgvOFgrcityMUk3cHZQU0ljclpUUGc2?=
 =?utf-8?B?MVpZdURNN2J4ZjFwY3Byb1AwTHFvMkpOZlhnK3JCbzE0T2xKM0Vqa1QyZ0NV?=
 =?utf-8?B?RkFmc2VhZXV3dXJwamhKb2Z6TjRjQ0ZsUDNuZStDamtGZ2VTWVA3R1NTR09O?=
 =?utf-8?B?dTE1SEhYUDZUNDlHcVlGQ3ZqUG94WnAvc1cyYjVsNlRBUDVzWS9yN2VtT3RK?=
 =?utf-8?B?dnF1alBiMGY5bjJ5eXJEUkZPWjdXSHFkVlJlWWY2M1ByQ1ZDZ1BZaUNnM2h4?=
 =?utf-8?B?VG0wU3JxUmpFekNNdUNBZ1JCOFFEcnJVYndZMHNpTEprUmVTWFZqTFQ2Z3lo?=
 =?utf-8?B?MSt0d3k2ek1kTzFNbVIxeXdpd3UrWEd3M1pFcC9FUVdUL3ZpaEdsYllndU8v?=
 =?utf-8?B?TTZjVHl3ZlcrUUlBMHZBUThNb0owOVNzZE5ETHFMUWFSQ1gyN3ZjcUdRU01i?=
 =?utf-8?B?czdCWllMdEFIUlZ4MCtUTXdNdER6ZzlVMWk1dEhDUEFGWnpjYXRINmUrVDdh?=
 =?utf-8?B?VzJrdncrV0V1TEwxN2paVGtteGd4aW4rSksyZy9tKzVBWHpuK2J2U1hNWE8w?=
 =?utf-8?B?UENuMzF3MDZuSVAvTUQ1bW1idm9WSXNYeGtqdzJydGNidWJtUmNtYjk3aEQw?=
 =?utf-8?B?TUJGOWREdmQ3TVUrQlp4NUppdURKWmYxc0lSdXg5azhhVEx3T0hXSTRON2N5?=
 =?utf-8?B?ZFpsL2JhbjRjUm1tWFc4NmZLMGFIaDcxRG4vamVNM2ZqSjQ2dFg3YlBoQXN3?=
 =?utf-8?B?ZkZjaGFOMWlmejlnNGhLMTh5V2paV2t1cjFiN0NqTDBKUnpyd0htNmdpQ0dB?=
 =?utf-8?B?YVNMdVEvUHRIaEhCN0YvUHJKZ1dROE8yM3QvaTYwbi9scENJRTdqcStOY1ZO?=
 =?utf-8?B?ZDRuc2hsKzJDUUY4RXRWRXpuSEQ5THVUN2dLSkU0cHUrZ21QcEVmb0ZDL1Fm?=
 =?utf-8?B?eVl6dGQyQnFaelUvSkxwQitEc3l4UXRna2F5aFFGQ0ZIQVJ4L1dNVVQyRDA0?=
 =?utf-8?B?TEI2YmRPUGJXS3dUZlNmYUZEWm9ZQjMrejNoL0VtZlNXRW5NNEMyaVdBdUlh?=
 =?utf-8?B?R3pmVFFubktWU1dyeEgxeGIvb0lSUVR6YSt2RXRaMysxNzF2b294RVVYMFVp?=
 =?utf-8?B?TEZUeDc3WVppdEJBb2c5Wi9EN0JTcCs4V3JlNnJvODk3U3pDTmNOSnh3ZFFD?=
 =?utf-8?B?Nlk4WlVkWlZRZ3REeWhCY3RwT05TelZJVkxodWpsSGg3THdFZnFPSjl6Yjdv?=
 =?utf-8?B?bndiNWJNMkZaZ0Q1MVFiWitiOVQ1bnZpRzJnSFFrb3IrTnErakIycEZyZDl5?=
 =?utf-8?B?L1JVREdPVXMzNlV1Y1JQem5VNXAzQTdBU0dDODNHSURxZjdNVWJ4cWp3bUZv?=
 =?utf-8?B?YVVyR0NNOHBiZzljVEdlREgxQlZZR01yWmY2VDNxUFFKUythUTFvOG1OOFRW?=
 =?utf-8?B?aEszS1ozNmpnQjN3OWlGdmF5ZDlwSmpxbm9VbVlvaWV0N3dVL1Mrdm5QZ0hI?=
 =?utf-8?B?QmswWkMzREtONzM1bmM0UHNiV0N5UHVFRytDSlFuc1RneFQ0akFRSGlHYXJh?=
 =?utf-8?B?dXVpWTVJOHZzd05URnJoU3dCQm1NTnBpaTZiMzFXbHI1N2l0S3VTQW1pTCtn?=
 =?utf-8?B?aHZxc0tPa2s0V0xrQnVzNHBDV3BBWFd3V1NFMkJ4bnFncllPazU3c0pwMDBk?=
 =?utf-8?B?OXdBUFQxR01Fa3FCWWZKd01sRWp6dHJKZzQ3OStrUHV2N0MvOVViditRRzA0?=
 =?utf-8?Q?DzDCaivNIZlI18e56uEF/J6vM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9901A35D64D0743921CAACF13ADD375@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e254cfca-ccbd-4513-3b48-08dbaa77e34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 23:13:29.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RJnvhtf/s1EA1msb7Rvo+rT5nrs3nGRzBsww/X17Cwc5MY9jWdC0YZsKA0QQXiZ3JrbJIHUQOP8cKSEc3uKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTMxIGF0IDE1OjQxICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFN0YXRpYy1waWUgYmluYXJpZXMgbm9ybWFsbHkgaW5jbHVkZSBhIHN0YXJ0dXAgcm91dGluZSB0
byBwZXJmb3JtIGFueSBFTEYNCj4gcmVsb2NhdGlvbnMgZnJvbSAucmVsYS5keW4uIFNpbmNlIHRo
ZSBlbmNsYXZlIGxvYWRpbmcgcHJvY2VzcyBpcyBkaWZmZXJlbnQNCj4gYW5kIGdsaWJjIGlzIG5v
dCBpbmNsdWRlZCwgZG8gdGhlIG5lY2Vzc2FyeSByZWxvY2F0aW9uIGZvciBlbmNsX29wX2FycmF5
DQo+IGVudHJpZXMgbWFudWFsbHkgYXQgcnVudGltZSByZWxhdGl2ZSB0byB0aGUgZW5jbGF2ZSBi
YXNlIHRvIGVuc3VyZSBjb3JyZWN0DQo+IGZ1bmN0aW9uIHBvaW50ZXJzLg0KPiANCj4gV2hlbiBr
ZWVwaW5nIGVuY2xfb3BfYXJyYXkgYXMgYSBsb2NhbCB2YXJpYWJsZSBvbiB0aGUgc3RhY2ssIGdj
YyB3aXRob3V0DQo+IG9wdGltaXphdGlvbnMgZ2VuZXJhdGVzIGNvZGUgdGhhdCBleHBsaWNpdGx5
IGdldHMgdGhlIHJpZ2h0IGZ1bmN0aW9uDQo+IGFkZHJlc3NlcyBhbmQgc3RvcmVzIHRoZW0gdG8g
Y3JlYXRlIHRoZSBhcnJheSBvbiB0aGUgc3RhY2s6DQo+IA0KPiBlbmNsX2JvZHk6DQo+ICAgICAv
KiBzbmlwcGVkICovDQo+ICAgICBsZWEgICAgZG9fZW5jbF9vcF9wdXRfdG9fYnVmKCVyaXApLCAl
cmF4DQo+ICAgICBtb3YgICAgJXJheCwgLTB4NTAoJXJicCkNCj4gICAgIGxlYSAgICBkb19lbmNs
X29wX2dldF9mcm9tX2J1ZiglcmlwKSwgJXJheA0KPiAgICAgbW92ICAgICVyYXgsLTB4NDgoJXJi
cCkNCj4gICAgIGxlYSAgICBkb19lbmNsX29wX3B1dF90b19hZGRyKCVyaXApLCAlcmF4DQo+ICAg
ICAvKiBzbmlwcGVkICovDQo+IA0KPiBIb3dldmVyLCBnY2MgLU9zIG9yIGNsYW5nIGdlbmVyYXRl
IG1vcmUgZWZmaWNpZW50IGNvZGUgdGhhdCBpbml0aWFsaXplcw0KPiBlbmNsX29wX2FycmF5IGJ5
IGNvcHlpbmcgYSAicHJlcGFyZWQgY29weSIgY29udGFpbmluZyB0aGUgYWJzb2x1dGUNCj4gYWRk
cmVzc2VzIG9mIHRoZSBmdW5jdGlvbnMgKGkuZS4sIHJlbGF0aXZlIHRvIHRoZSBpbWFnZSBiYXNl
IHN0YXJ0aW5nIGZyb20NCj4gMCkgZ2VuZXJhdGVkIGJ5IHRoZSBjb21waWxlci9saW5rZXI6DQo+
IA0KPiBlbmNsX2JvZHk6DQo+ICAgICAvKiBzbmlwcGVkICovDQo+ICAgICBsZWEgICAgcHJlcGFy
ZWRfY29weSglcmlwKSwgJXJzaQ0KPiAgICAgbGVhICAgIC0weDQ4KCVyc3ApLCAlcmRpDQo+ICAg
ICBtb3YgICAgJDB4MTAsJWVjeA0KPiAgICAgcmVwIG1vdnNsICVkczooJXJzaSksJWVzOiglcmRp
KQ0KPiAgICAgLyogc25pcHBlZCAqLw0KPiANCj4gV2hlbiBidWlsZGluZyB0aGUgZW5jbGF2ZSB3
aXRoIC1zdGF0aWMtcGllLCB0aGUgY29tcGlsZXIvbGlua2VyIGluY2x1ZGVzDQo+IHJlbG9jYXRp
b24gZW50cmllcyBmb3IgdGhlIGZ1bmN0aW9uIHN5bWJvbHMgaW4gdGhlICJwcmVwYXJlZCBjb3B5
IjoNCj4gDQo+IFJlbG9jYXRpb24gc2VjdGlvbiAnLnJlbGEuZHluJyBhdCBvZmZzZXQgMHg0MDAw
IGNvbnRhaW5zIDEyIGVudHJpZXM6DQo+ICAgT2Zmc2V0ICAgICAgICAgIEluZm8gICAgICAgICAg
IFR5cGUgICAgICAgICBTeW1ib2wNCj4gLyogc25pcHBlZDsgInByZXBhcmVkX2NvcHkiIHN0YXJ0
cyBhdCAweDYwMDAgKi8NCj4gMDAwMDAwMDA2MDAwICAwMDAwMDAwMDAwMDggUl9YODZfNjRfUkVM
QVRJVkUgIDxkb19lbmNsX2Vtb2RwZT4NCj4gMDAwMDAwMDA2MDA4ICAwMDAwMDAwMDAwMDggUl9Y
ODZfNjRfUkVMQVRJVkUgIDxkb19lbmNsX2VhY2NlcHQ+DQo+IDAwMDAwMDAwNjAxMCAgMDAwMDAw
MDAwMDA4IFJfWDg2XzY0X1JFTEFUSVZFICA8ZG9fZW5jbF9vcF9wdXRfdG9fYnVmPg0KPiAwMDAw
MDAwMDYwMTggIDAwMDAwMDAwMDAwOCBSX1g4Nl82NF9SRUxBVElWRSAgPGRvX2VuY2xfb3BfZ2V0
X2Zyb21fYnVmPg0KPiAwMDAwMDAwMDYwMjAgIDAwMDAwMDAwMDAwOCBSX1g4Nl82NF9SRUxBVElW
RSAgPGRvX2VuY2xfb3BfcHV0X3RvX2FkZHI+DQo+IDAwMDAwMDAwNjAyOCAgMDAwMDAwMDAwMDA4
IFJfWDg2XzY0X1JFTEFUSVZFICA8ZG9fZW5jbF9vcF9nZXRfZnJvbV9hZGRyPg0KPiAwMDAwMDAw
MDYwMzAgIDAwMDAwMDAwMDAwOCBSX1g4Nl82NF9SRUxBVElWRSAgPGRvX2VuY2xfb3Bfbm9wPg0K
PiAwMDAwMDAwMDYwMzggIDAwMDAwMDAwMDAwOCBSX1g4Nl82NF9SRUxBVElWRSAgPGRvX2VuY2xf
aW5pdF90Y3NfcGFnZT4NCj4gDQo+IFN0YXRpYy1waWUgYmluYXJpZXMgbm9ybWFsbHkgaW5jbHVk
ZSBhIGdsaWJjICJfZGxfcmVsb2NhdGVfc3RhdGljX3BpZSINCj4gcm91dGluZSB0aGF0IHdpbGwg
cGVyZm9ybSB0aGVzZSByZWxvY2F0aW9ucyBhcyBwYXJ0IG9mIHRoZSBzdGFydHVwLg0KPiBIb3dl
dmVyLCBzaW5jZSB0aGUgZW5jbGF2ZSBsb2FkaW5nIHByb2Nlc3MgaXMgZGlmZmVyZW50IGFuZCBn
bGliYyBpcyBub3QNCj4gaW5jbHVkZWQsIHdlIGNhbm5vdCByZWx5IG9uIHRoZXNlIHJlbG9jYXRp
b25zIHRvIGJlIHBlcmZvcm1lZC4gV2l0aG91dA0KPiByZWxvY2F0aW9ucywgdGhlIGNvZGUgd291
bGQgZXJyb25lb3VzbHkganVtcCB0byB0aGUgX2Fic29sdXRlXyBmdW5jdGlvbg0KPiBhZGRyZXNz
IGxvYWRlZCBmcm9tIHRoZSBsb2NhbCBjb3B5Lg0KPiANCj4gVGh1cywgZGVjbGFyZSAiZW5jbF9v
cF9hcnJheSIgYXMgZ2xvYmFsIGFuZCBtYW51YWxseSByZWxvY2F0ZSB0aGUgbG9hZGVkDQo+IGZ1
bmN0aW9uLXBvaW50ZXIgZW50cmllcyByZWxhdGl2ZSB0byB0aGUgZW5jbGF2ZSBiYXNlIGF0IHJ1
bnRpbWUuIFRoaXMNCj4gZ2VuZXJhdGVzIHRoZSBmb2xsb3dpbmcgY29kZToNCj4gDQo+IGVuY2xf
Ym9keToNCj4gICAgIC8qIHNuaXBwZWQgKi8NCj4gICAgIGxlYSAgICBlbmNsX29wX2FycmF5KCVy
aXApLCAlcmN4DQo+ICAgICBsZWEgICAgX19lbmNsX2Jhc2UoJXJpcCksICVyYXgNCj4gICAgIGFk
ZCAgICAoJXJjeCwlcmR4LDgpLCVyYXgNCj4gICAgIGptcCAgICAqJXJheA0KDQpjYWxsIColcmF4
DQoNCj8NCg0KPiAgICAgcmV0DQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMTUwZDhjYTgtMmM2Ni02MGQxLWY5ZmMtOGU2Mjc5ODI0ZTk0QGNzLmt1bGV1dmVuLmJlLw0K
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNWMyMmRlNWEtNGIzYi0xZjM4LTk3
NzEtNDA5YjRlYzdmOTZkQGNzLmt1bGV1dmVuLmJlLyNyDQo+IFNpZ25lZC1vZmYtYnk6IEpvIFZh
biBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+IFJldmlld2VkLWJ5OiBKYXJr
a28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxr
YWkuaHVhbmdAaW50ZWwuY29tPg0KDQo=
