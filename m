Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A3F786345
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjHWWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjHWWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:19:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FFE76
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692829160; x=1724365160;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0qRzZVKRfAkPoMpKL2Stz6ntqxl9UzJV9RTDU88bhPY=;
  b=EX1aAfwVojD0wy9jS/flBpu6kfemV32F3/86xyTVkxl0gh8UF0xAtCCq
   0jm3aXzjsrllPYzABh5SPrEtSh04xizJscdBhoL8oHyltnkUbIcYFhXVi
   3eBNb488xrpOC5Q8f35DAQoMAQtM/59mWCEROQdjsHL1uFENPkqZ4/E9n
   fNec4NfZJVRv9ZxthOo4SI74jdxEkcgC1tzdzZz5FiuQbvTnAnpT2mavs
   6znbU4NJ4K53JqYIBLtr2YuDSLZGfdnR2GkFxUfkwVdtPLVXUsqZ66tGM
   JAdPXuUFmseACSy/0O/gDql0qTwb4hlzvJQ9fcGVI3pCvCImY7c3f+pNs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371696111"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371696111"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826893038"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826893038"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 15:16:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:16:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:16:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 15:16:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 15:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9cTdfqnzDoXVyQHzUBldvwrIe+sq8ELYRSftKIvuQoz9O9O7ZrqP1x6IT94+oC2tEDdBzfOwuBoMCBjjoqblhWD44WE7BKHCnA9iGBfxE3uGRS9C9gAm2PhKHLQ9SLBiQDiQ/09npT1Fik6Ekj3B69Z80h9sMX/oFFyS0CeW1b5OjQ3flRoMcPQZ8AnYPEgdNVYooZYsjxIFgZOi0Ek3tVhwdU9h0Uu/HkkcfgL38+XhKz3zrHlW6BHilqjVhW0D1SdyqnJF9h6hLLzISmJZnrC7S4tBlgsRFvmx7aOx8gto9GXpbhWIJC8Sd33ofASwRSWzytKorKNRIcPBM3IJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qRzZVKRfAkPoMpKL2Stz6ntqxl9UzJV9RTDU88bhPY=;
 b=JEZgtkTNna8qkFcjwznJ23Kmej0Q45o+1cYKy/B8+KcpNVXosyx/bLiIeip98Cuf3cPjOK3UTwsfaucHyGTVN4hD32uMr9t9Wa3eJfVXUMoz0DLCcL+8CaiRw7NxFgenHVRSObmExui301VuWwaGF0oYM4eajhN10b6ekhTcEhTa46vwckHMRAwaD9ddgw/wf4Iz5ZMxrjI5TLxFP2PUS+E4XPetJs4+hsskDQVeBKt+WzDE9SAb8+toJsAeMB4cvB+sLHxrau4i9yGE6nD2giInyVltZi7RqiyP9L1U8qXJm6RI6C52rNotppZb0DCepbf/N0rtAJ+IJT1uBecb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 22:16:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 22:16:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4
Thread-Topic: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4
Thread-Index: AQHZ1g+G1hiP1wpcfUiwYaWhi8T/fw==
Date:   Wed, 23 Aug 2023 22:16:55 +0000
Message-ID: <4cb8d8ab43723e66134626eb0b4fc5fca2371305.camel@intel.com>
References: <20230823065747.92257-1-feng.tang@intel.com>
In-Reply-To: <20230823065747.92257-1-feng.tang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BN9PR11MB5433:EE_
x-ms-office365-filtering-correlation-id: cdb3e765-c007-4b3c-bb87-08dba426a91e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARAzGvGg/ZySP2U+i8j9TqhaS50J3+ia+Vl/oHf5FMlIU543Eej0sV5i4xvBEou6ZqWmEDhPJG7D/rwBZKXeCRN0JPQ3uSZQdZlN9nDcIzUxrKmuEFVhQnOVzt6Zzjq5sW3JKIj70tcxh+3iPNHAGCLzzEBXPduJw2C9rKQp1k39GLwt1OJOfxR6kEvF451XDFXwbbvXdFmmfPXfNJmDtf6E7t/DuoFOpg2qMhGRyx26UFWvss+iW2V++Td5LVD59812vRVYsAmPHODhZsOHtzacurA/iGtACNDJNvKyMehBDni0bPoKtVM9SO3rnD0lhrMZ90yjp85NdudFuVl/r+jfFI3aT5JdRHhmJGXn9xb2FJk07vRE8FX0isdMXsohIEKzhjTb4pvizsF8FRQVRUhejoI2aXLHAxB6fSc1AC5unEO0l7QdxDyK/5hByDdb0t3JVLHz4kSNE+i9vXWvwgniqZLf+q7OXgwCAGQx6ynsVi8tDOv7Ba30JTyRJtQJhOLU+0qUzRc6+ueO2t+dxGlQ2ulc6OJCj688AGayerAkm0rkemhXvNynKNlJhPFNR79Ygf5Rf/3Zwrdx+9OIUYlflXmCGcTjBvoucI1BES4xr0DWaPh3n5Y5cgnd08ZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(8936002)(8676002)(110136005)(66556008)(66946007)(76116006)(66476007)(64756008)(66446008)(6512007)(41300700001)(91956017)(26005)(5660300002)(71200400001)(966005)(478600001)(83380400001)(36756003)(86362001)(82960400001)(2906002)(921005)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRuenExamd0ZnNrenl5a3I3aFJiaStsMVc3SW14clZiL3FKd2wzdm5Qd1U3?=
 =?utf-8?B?Z01SQlhWWFNXT280eTI0U2I2OGZDNVVLK24wZldjUlNTK3dvZjg1Nlk0UGVT?=
 =?utf-8?B?NlU3VDVVREFjbkovUUFOWERZN0pJU2R0ZzZYV2NsTW5adVIwSzdaamZMeUtU?=
 =?utf-8?B?R3dKWE81eThSUkU0ak91eFJsTVNzMHREdkd1NXpiNHJydklVVHduekM1ejZY?=
 =?utf-8?B?T2FHdWd3eXAvZW8yNFVmV2xFS09ydGFwMHV0YnlSQ081MnpQUXVuZzhZLzhi?=
 =?utf-8?B?NzVQanhGM1p6dUJiRWVzblM1R3o4OU9CYitOZTBwczMwblZUSWMzMVViMmI0?=
 =?utf-8?B?TFdXN0plQW1NTzR4UFVVZ0hKVEs5UitBQ3J0ZllGZjBQUUJLSEc4amdHd05G?=
 =?utf-8?B?VW1Eemc0Q3ZxbkI3bzFJWVgvSnI4QXA4LzRvSDQwcWg1OFBYbGZOVGlUWmU0?=
 =?utf-8?B?OWdkT2RSRVQyQnpRRGVQQXgvUTJFajdORlJLemh1Z3NEbk9KQ1ZhK1RZOU1k?=
 =?utf-8?B?UUFEanBIZVlzQko0dkNBV040bkRIcC9SRVZPcTdMK21uSXlENmZjN3VSOXN0?=
 =?utf-8?B?SzJVdERocXFNVE5YcXkvMkZObnpSNFJtWHZTZFB6NVBjaS8xYWx5SnY1UUk4?=
 =?utf-8?B?UFJSTUxuMTRtRmlOanl5b09nTFAwd25FWGpybDhJS08zR1NTcTFrUUtxTWZR?=
 =?utf-8?B?Si80bnVrMGlFNTFXQVJ5Vjg2R2RMbnZ4M2xoSnZZSXFWNjUrblVoZUVPVE1k?=
 =?utf-8?B?azh3U2ROOXpMbUZqcnZrckdHL2lUUUN2YWsvRlNDRUlvdGp6b01vZm9lMWtq?=
 =?utf-8?B?MFFHeW1qVTQvNmJZdW9teVVXMUpzb1owMTlyU2RWWkJKWlQwM1QvdUFtMkt5?=
 =?utf-8?B?dGpjb1RaVnczRFBSWDR6a0h5SlN1OEhCR1ppeWV6YmFSVitPTk5lbjJLa0Fx?=
 =?utf-8?B?QzRrTHZFT2VLSlpRL2ZPTFU0U0NPaVgvMEFpNE0rMG8yei9Qa2R2KzNFOUwr?=
 =?utf-8?B?SEZsWE9FeG11MGVqNEdJemdONHNTYVNPSW1EdWpRY3RNMHZ2S1JBMGlDRElu?=
 =?utf-8?B?NEhIMDdaV0M2eE54NUJaUkpHVE0vM3V3enFtYW5wcURDdFJaVjlicndXL2dH?=
 =?utf-8?B?N216OEI0ZEMva0dDZ1FjNjFwbWF2MXlpYll5UUFJUmozaW04bUxyemVndGVx?=
 =?utf-8?B?aVhMNVNqeW1hOG1OWkdxV1g2bzNrUlZuVjd0NExtUlUrKys0WlBId1F0TjFF?=
 =?utf-8?B?NVg4eEoyZUIrSzU2ZFJ4bThmMDdlM0NIenlmT3dTRGNmK0EzbXFmOWpJQUFx?=
 =?utf-8?B?dzJYVE1qUzhPcjZOZXJaUmlCUm5PV0M1akRTUWwwUklpRWFPaWRtU0ZmYlE1?=
 =?utf-8?B?LytHd2hGY2NkYkxKQ2krNUNpUENMeThYY3libzBCbERvNG5mdHRjNk1ZWVFN?=
 =?utf-8?B?M0YwSjZlaDlWZlZBSnNpakdYTmFtbTJ2MjRwWStuTFY1YlcrYzEwUFdHWEl3?=
 =?utf-8?B?c2JsNXhvNjBLNTFtbVpxbjZFb2dPMk1FQ1J3STh3MUtaZGJSa29BNDhGTkpt?=
 =?utf-8?B?V1ZiOXNEY1AvU3lmTTBlNjkzV0o4TnF5b045OFIxQXFoK1Z1ZkNpVW5yMzhr?=
 =?utf-8?B?Tm1sa3Myd0lWUVhEME9DYTF4MWcwN2FiY2N0cVZVTitteVhsZXJXaUtnSmNs?=
 =?utf-8?B?S3ZSL1Q3Y1VLSzVrQTZxMmVTSUcySnFQQ0JmTTNINkUwdW0vRVcvNnhSRFRE?=
 =?utf-8?B?ZmlRVHAzdTVDK2pLaFhEYVlEUWZ4K2VFSStsZHNJYTM4aWdYbm02NnhsUFVm?=
 =?utf-8?B?NXpkUTZsTjFoUTVQdUR6Q2d2TEJuM1A3VjlOMjI4U01OSDZHdEhkdXc1Nnpy?=
 =?utf-8?B?MG93OVR6VDl5TXVrRVA0RW5oMG5vZlZKSElmZFBPY0x3K3JhZ1FpMVJoZC9W?=
 =?utf-8?B?dHVMYmkzeXhjUzNXNlNITmlwL1Y0Q0pPajBHV1R3am1VWmFFNWVXSzhrK1ZR?=
 =?utf-8?B?eXMrRzg0emlONkhjWUV2djM5YW9zMEhzbFZELzg0bitQYkptb1VOVU9GdURi?=
 =?utf-8?B?WFltdlVuaTRoL0FnN3o2NVlWTlVhb21tOEZMMUVGRFFYWm1KbnpFdS85VUNP?=
 =?utf-8?B?V1VZTkt3dHZBVkxXNzJKN3RWRjNLTTQ2ZmlPUjBKckVPNjgrcXhFYlRsZGlk?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D9AE20053EAF14FB721B20EA00F97CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb3e765-c007-4b3c-bb87-08dba426a91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 22:16:55.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cz/Lf7C9pg6jSMK/A2eCAtmApcuMrtPMylCXynbFHQdnu2B468ihusisz6zrycMR0WBOUBTAmYhEZTaeU5XWLTcDzH5c4rVQkq8KZ2SINd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDE0OjU3ICswODAwLCBGZW5nIFRhbmcgd3JvdGU6DQo+IDBE
YXkgZm91bmQgYSAzNC42JSByZWdyZXNzaW9uIGluIHN0cmVzcy1uZydzICdhZi1hbGcnIHRlc3Qg
Y2FzZSBbMV0sDQo+IGFuZA0KPiBiaXNlY3RlZCBpdCB0byBjb21taXQgYjgxZmFjOTA2YThmICgi
eDg2L2ZwdTogTW92ZSBGUFUgaW5pdGlhbGl6YXRpb24NCj4gaW50byBhcmNoX2NwdV9maW5hbGl6
ZV9pbml0KCkiKSwgd2hpY2ggb3B0aW1pemVzIHRoZSBGUFUgaW5pdCBvcmRlciwNCj4gYW5kIG1v
dmVzIHRoZSBDUjRfT1NYU0FWRSBlbmFibGluZyBpbnRvIGEgbGF0ZXIgcGxhY2U6DQo+IA0KPiDC
oMKgIGFyY2hfY3B1X2ZpbmFsaXplX2luaXQNCj4gwqDCoMKgwqDCoMKgIGlkZW50aWZ5X2Jvb3Rf
Y3B1DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlkZW50aWZ5X2NwdQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdlbmVyaWNfaWRlbnRpZnkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdldF9jcHVfY2FwIC0tPiBzZXR1cCBjcHUgY2FwYWJpbGl0eQ0KPiDC
oMKgwqDCoMKgwqAgLi4uDQo+IMKgwqDCoMKgwqDCoCBmcHVfX2luaXRfY3B1DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZwdV9faW5pdF9jcHVfeHN0YXRlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3I0X3NldF9iaXRzKFg4Nl9DUjRfT1NYU0FWRSk7DQo+IA0KPiBBbmQgaXQgbWFr
ZXMgJ1g4Nl9GRUFUVVJFX09TWFNBVkUnIGZlYXR1cmUgYml0IG1pc3NlZCBpbiBjcHUNCj4gY2Fw
YWJpbGl0eQ0KPiBzZXR1cC4gTWFueSBzZWN1cml0eSBtb2R1bGUgbGlrZSAnY2FtZWxsaWFfYWVz
bmlfYXZ4X3g4Nl82NCcgZGVwZW5kcw0KPiBvbg0KPiB0aGlzIGZlYXR1cmUsIGFuZCB3aWxsIGZh
aWwgdG8gYmUgbG9hZGVkIGFmdGVyIHRoZSBjb21taXQsIGNhdXNpbmcNCj4gdGhlDQo+IHJlZ3Jl
c3Npb24uDQo+IA0KPiBTbyBzZXQgWDg2X0ZFQVRVUkVfT1NYU0FWRSBmZWF0dXJlIHJpZ2h0IGFm
dGVyIE9TWFNBVkUgZW5hYmxpbmcgdG8NCj4gZml4IGl0Lg0KDQpPaCwgdGhhdCdzIHVuZm9ydHVu
YXRlLg0KDQpJdCBtaWdodCBoZWxwIHRvIGluY2x1ZGUgYSBiaXQgbW9yZSBhYm91dCB0aGUgcHJv
YmxlbSBpbiB0aGUgbG9nLiBUaGUNCnBpZWNlIHRoYXQgY29uZnVzZWQgbWUgYXQgZmlyc3Qgd2Fz
IHRoYXQgWDg2X0ZFQVRVUkVfT1NYU0FWRSBtYXBzIHRvIGENCkNQVUlEIGJpdCB0aGF0IHdpbGwg
Y2hhbmdlIG9uY2UgQ1I0Lk9TWFNBVkUgaXMgc2V0LiBTbyBzaW5jZSB0aGUgQ1BVSUQNCmJpdHMg
YXJlIHJlYWQgYmVmb3JlIENSNC5PU1hTQVZFIGlzIHNldCwgaXQgc3RvcmVzIHRoZSBvcmlnaW5h
bCB1bnNldA0KdmFsdWUgb2YgdGhlIGJpdC4NCg0KPiANCj4gWzFdLg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwNzE5MjEzNS4yMDNhYzI0ZS1vbGl2ZXIuc2FuZ0BpbnRlbC5j
b20vDQo+IA0KPiBGaXhlczogYjgxZmFjOTA2YThmICgieDg2L2ZwdTogTW92ZSBGUFUgaW5pdGlh
bGl6YXRpb24gaW50bw0KPiBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KCkiKQ0KPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogRmVuZyBUYW5nIDxmZW5nLnRhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBhcmNoL3g4
Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jIHwgMyArKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUu
Yw0KPiBiL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMNCj4gaW5kZXggMGJhYjQ5N2M5NDM2
Li44ZWJlYTBkNTIyZDIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRl
LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiBAQCAtMTczLDYgKzE3
Myw5IEBAIHZvaWQgZnB1X19pbml0X2NwdV94c3RhdGUodm9pZCkNCj4gwqANCj4gwqDCoMKgwqDC
oMKgwqDCoGNyNF9zZXRfYml0cyhYODZfQ1I0X09TWFNBVkUpOw0KPiDCoA0KPiArwqDCoMKgwqDC
oMKgwqBpZiAoIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9PU1hTQVZFKSkNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldHVwX2ZvcmNlX2NwdV9jYXAoWDg2X0ZFQVRVUkVfT1NY
U0FWRSk7DQo+ICsNCg0KSSdkIGFsc28gcHV0IGEgY29tbWVudCBoZXJlIHRvIGV4cGxhaW4gd2h5
IHRoaXMgaXMgZG9uZSBtYW51YWxseS4gSSdsbA0KdG9zcyBzb21ldGhpbmcgb3V0IGluIGNhc2Ug
aXQncyB1c2VmdWw6DQoJLyoNCgkgKiBDUFVJRCBiaXQgZm9yIFg4Nl9GRUFUVVJFX09TWFNBVkUg
dmFsdWUgd2lsbCBjaGFuZ2Ugb25jZcKgDQoJICogQ1I0Lk9TWFNBVkUgaXMgc2V0LCBzbyB1cGRh
dGUgaXQgbWFudWFsbHkuDQoJICovDQo=
