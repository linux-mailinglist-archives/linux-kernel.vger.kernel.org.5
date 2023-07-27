Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D76765E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjG0Vrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjG0Vrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:47:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD922685;
        Thu, 27 Jul 2023 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690494457; x=1722030457;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Bh3RL4+u0lUJD+We6BEIJiYBc8B+kaEbBx9PsDcqGHc=;
  b=HjuXWNA4M7xHrLkt0qzpC3zB30nFhQ1IIk1W6k6iAk9fjuktJLpYxCov
   0xQfXGofjkozXv9Myxue59+9LqzMmOZHXGgpkbU6gTmV//JubgFrKsng3
   PZpPjCip4qnOnR7TlH1XptAxCehRjzakFUGU6lfqAsT/yHdafXcHNNXfu
   aLBpsgbY9mRnnNAA16+Uo3uf9QJLHaNXmkBd0i3xi0KrNUOdmaFn7+BO5
   dzorDlrgLKl/NmoU0/KksS273iPQsHL3XBPDddHC6wEp1csJfFUjV/0l/
   jQyHTp0qFsFdghp4V5MbR5IB7doeUpslIq8MlMa/glrsPSRX9vFQeut6m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371139290"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="371139290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 14:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797182946"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="797182946"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2023 14:47:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 14:47:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 14:47:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 14:47:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 14:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbrdg9grKxzpglwoyIjj8ErNi2hOftgs+0qZkSTHHWfv8slYFwprJkAbT8xcJTEB74BktIuXU06VOu8v81P0f4cTAG114oIMfnQJ0zEUiC4ZzDP2p1ZRRDKqg2/RiFip005HKoJ1I/YBQz2c4vxEMsH+e8kHaNdUbodZCCLQrjx3NXo9AYsjlgMnpyKoKunbxJq3DJglzuOukWiRAPwSaQqdhbYH6578loWXAARRgSif+XPkI9yv0HYZV2q4W6pFwRRZQ8KeC8pjeStK31cwuQjx4fefHReo4bpjeGLe1GQLOfPu1q2ge2APmB3ngDsuNFeowgp+BCs0FlAjACeDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh3RL4+u0lUJD+We6BEIJiYBc8B+kaEbBx9PsDcqGHc=;
 b=DDLZ6bCmr2v4flldBDa8I4RTRTdre4Steiav3CVk28Dl0cV2RMaIec7uvADN2zPxpXs45E2Q6WvUHoAjUGTSZ3pr6y1wITD4IUUDCQjwupQT2RW3H1u5lG5+bZlr90yXzzLJyJ9kmojBi5WSVNkAXF/wJRgwyBUQD6nHQUQ65SK2j/7IT2oTZD/Rx15qAksVF4aC+tUg70Ze0ru2aAtXMEe34j+nmODd19RMQfw47j/imzTZA5MOarAZw5kCDtcxaJL8RUOqI2Z0UZUA7U5/34WvVv8jFS3EkRzBvp4qEkymA2eLrhr7mWy0S0pjpTBTzzxOqMm1hxCJtzsiSmSWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 21:47:22 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e527:d79c:2bb3:e370]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e527:d79c:2bb3:e370%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 21:47:22 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc4
Thread-Topic: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc4
Thread-Index: AQHZwNPsVRuR1bMTeUyKbz8TRAuFEg==
Date:   Thu, 27 Jul 2023 21:47:21 +0000
Message-ID: <5c506f1121b7169b8cb1ed4ee1f5ffd9a2fe4392.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA1PR11MB8473:EE_
x-ms-office365-filtering-correlation-id: 63fa778e-8456-4d22-b411-08db8eeb0ed4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNYiHnudENQTAf9xv9nnfrgbD8dX2WklvPXFyZdbxEGzwYCK5ObVMiQ4PvYCXzTLRxGqM0XWusNHUGk7YKPFbc3mVyd9Jv+DvliXzqtDsuCtt0p7O6JPNCk04zIsz67y59eXWgxBBiipkjK+9I0prgiIQVg5hm2fY08P2DLxS/KprZ90aCoJZhOeASAZL6d5U/ywCjgth939SGsAIie+28qIhueaw0staSTihLHSrMNb7UgZc47FMqNbuAiU4jVAAvsCj00qj0E3hCBCBzT4XxdqkH1XrgR3kOmyqrQ0I1gb5exxkZHvLtAT5p+XvJPcugBFZKCSt5dRra2cy++VS96K3Ik2cGqUh+sohV9+1ksyQxPyOayBuWzfTn6Jf3ylG7kZJG79TKE6lVjsu+ricuGSwpjpkYr5bRvw6xa6b7lEdxKHjtCUONlsVvoe1CTlWjYGG+qTm+2yifmPnnjD+WzktCGSjDe1bP2jhb9dSwR0QWZV3i+E+nxce8H2kPwrhoIH7SDLbLqux1xHHbdLosWKTFxqFdAh+2O3SUz4gJfo8qsq8a2KqST9OruwnKJUJv3a6padpao+8Yis9UZ9g0mHVRRn7QS8ViTN9wsotFO+OcH6pB2rmi9HYx6TpW6+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(2906002)(316002)(8936002)(8676002)(5660300002)(38070700005)(41300700001)(36756003)(86362001)(6512007)(6486002)(71200400001)(122000001)(54906003)(82960400001)(26005)(478600001)(6506007)(186003)(2616005)(83380400001)(66946007)(76116006)(38100700002)(66556008)(4326008)(66476007)(6916009)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3NXZndpbmZEMDlzTUJQeFNJaWx1Ni9KUGdFWXFMbVJ4MUExMGJ0ZFZaNFBo?=
 =?utf-8?B?blVDM2xiNVBjSTExMTF6bzRONWZWWjRaOFJvZ2dNVWFCVk5Ma25hTU04VXFq?=
 =?utf-8?B?aUtWWUg1OE14K3NiNmQwdzd6aGw4UW12ZUhROUFGQzN2MUdBMzF0ckJvWEhs?=
 =?utf-8?B?aThsS2dOSFUvalZ0SmpEMGZXTEl0RlZpOGRMeFoyc29KMTVqbWxiaFN4aC9F?=
 =?utf-8?B?M24zYWZSUDFSVG5uR3dmTXVaWE1EYU52MnRtYXZrL3oxUXJ2MHhweUhHUy9z?=
 =?utf-8?B?SjhoTllNWjVpRDJNUmNReVgwRno4VE5pWHJ5dXIyQUJ6cm9rUUVqUHdRVWhj?=
 =?utf-8?B?NnF2Ni80ODZxL3lnSTA0N0hiSkJYVU5Pd3QvbXh3NlkwN2RweTA0RGI0R3Bv?=
 =?utf-8?B?b1NRNG5MYnRCSVZTaXR1RzRCMi8yQXhjSmdkS2s4VzJJM2Y2d2dOOW5ndEVq?=
 =?utf-8?B?bXJEQ3hBY0YwaUZMeG9SRVZnRXlWRHA0c0gxNENlZTE3aldITUJCWWlQSis0?=
 =?utf-8?B?bGEwN0ovNDNTM201RWt3NjFmV1VYeFhucGsyWTh3YU1ZVTF6QzdVc2RTVUli?=
 =?utf-8?B?QWllZEQ2N2dhdU5XVnJzWHNxY1p2VnBsdHIzL2FvWksvZ2VDZVZEVEcyNmgz?=
 =?utf-8?B?R1Z4SkxGQ1BTaXFEVFBCZmU5OGNPWHBPOGNTSldYbEVscndHaDZZSHNjeXE5?=
 =?utf-8?B?Q3pGYTVUcFRGVG94OSs2U0xWcGgyaGtRMDNnSHZEMFdwWDVUWlJidDRpMlZP?=
 =?utf-8?B?NWluK1VDalE2LzR6Y2NuNEhZRUxSc24yVkt4c3FkWU9DZkFMWXFld2N1SEJD?=
 =?utf-8?B?eUhsMGRaVGc5bUh0VnprVFpiLzYzeDllUW1LUk5IZnpDbk9LS3VBVUFOZDUr?=
 =?utf-8?B?L2dvNDNKQjRXc0JpNnBUbnhuenFrSGR2VWtQVjl6dnhodTZwTVl4TnhMOTFv?=
 =?utf-8?B?NDF0OFdTL3U2ZjNHc1RLMno2M0g5NDlEQzkrSVo1RHhZYnBkc2VPQWplcVQ5?=
 =?utf-8?B?M1pobm5oU1JURlhBWXIrNTdyNko0YnF1RG9CcjJYaVdFR0s2NmROTTFLcnIx?=
 =?utf-8?B?dkZVbVZXREI2Rk9kQjJ6Z0d6VE5DUTFHdGtDVzhwcXBKSFBqaFo2WVhaWnA3?=
 =?utf-8?B?cGcyVUZBWWk3NE1hdkVsbXpEUm9aazVKb3kvOXFDKzdETm1XZ3RMSUpFTjhC?=
 =?utf-8?B?UmN6WDUyNXBSdDNxTjRpUXRGTmhURjk5VllFT21YaVU0OU9jdXdzc2lDTklQ?=
 =?utf-8?B?L0tqZlFQRVYyYUdaQmR3a29NaDBwamVGVjcyOGtnRkQwUlpOVEhsYnVCaHZ3?=
 =?utf-8?B?RXBqOFUyTHR5ejhoRmFWTnpKMEdDekpkWks2Tm8weU8yYkRWbkhuUUhneXZw?=
 =?utf-8?B?SS9zaDNxNDg2Y1IyUUxpaktPcHZLWXB3M1pQeDB5cGlZRlNrZ3o0bTBaUjNC?=
 =?utf-8?B?ZCt4Y3FSUnNwWnpEV2o5dFpuMWswd1djSDJPZ2FlaUZDNFRsMkkzakw1dU1G?=
 =?utf-8?B?SHR1NGFpbXljNGh0VFkvNWNSOFhqZW1uZm5FMHVxdStBeW5BcEJ2UjFMSHZE?=
 =?utf-8?B?Q1lQUlNRZVFjbk5PNjAzMFVQMEhqRHNhNWI1c2RndVh5MEF5NTBld0g2L1Aw?=
 =?utf-8?B?RjcxZFduYlVGSS93ZTAwdGZIUEl2Zm0weHpXQVpGWldxN3dzTk93dWdtMmZi?=
 =?utf-8?B?cTNFdlJTVVR5SW9BUGcrK2d6bjNQNjdlSmQ3ckdiK3UvbXR5TDVSVzl5TnFR?=
 =?utf-8?B?YUF3b1BPTFd5aTN2ZzJqSFJOdnhEdU5XNmRENjVMTTdnSHoxTWVUQ3ptZDZU?=
 =?utf-8?B?ZHRMNzVUK3Z2dFQzS3kvOGd5L0NSSlEvWHdPZEZwZjlFYkJZS1RFejhja1V4?=
 =?utf-8?B?REdhd1U1TkJLOGN6V1BkcDB0L0JQZ3A3b1AwbFg2Wmx5bTRHZDlqNEU1bXJU?=
 =?utf-8?B?MTB0NGh0ZXVYWFlzbW96OEtXZzVHK3V4R0REK3o0dHpJdG4yYWFrQ2xPSUkv?=
 =?utf-8?B?ZFpxbXEyRUpENlBFM2NFbUlLYy9rM2RHUDBHTG81aWNmN1hvRm82ZHFGQ3hU?=
 =?utf-8?B?MGl6WkV4cmJ6eEJTRENQQzFXdWVzbHBhMlR1aUtzNkJmc2E3NTVoYTNzQkgy?=
 =?utf-8?B?R1c3S1NJYzBlazZhZnFzWXFJNWtPL2xyaXVaTnRQZzRRcEttM1QxT25JaXZt?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75E31F6727BFC4682943459F9502396@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fa778e-8456-4d22-b411-08db8eeb0ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 21:47:22.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OuPkjewbbElZHiZAUnVJ2F+d9EMqZC62ukUpno3nQ0Ws1srDT+7WQKcX+w+gJPbpSMsANL2TAMHsNTOO4QyHcnnFlM8RaNNt43eqz/D7g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2N4bC9jeGwgdGFncy9jeGwtZml4ZXMtNi41LXJjNA0KDQou
Li50byByZWNlaXZlIGEgc21hbGwgY29sbGVjdGlvbiBvZiBDWEwgZml4ZXMsIGFuZCBhbiB1cGRh
dGUgdG8gTUFJTlRBSU5FUlMNCmFkZGluZyBEYXZlIEppYW5nLCBEYXZpZGxvaHIgQnVlc28sIGFu
ZCBKb25hdGhhbiBDYW1lcm9uLg0KDQpUaGUgZml4ZXMgaW5jbHVkZSBhIEtjb25maWcgZGVwZW5k
ZW5jeSBmaXggZm9yIENPTkZJR19GV19MT0FERVIsIGFuIGluY29ycmVjdA0KdXNhZ2Ugb2YgdGhl
IEJJVCgpIG1hY3JvcyBjYXVzaW5nIGEgZG91YmxlIHNoaWZ0IGluIHRoZSBmaXJtd2FyZSBsb2Fk
ZXINCm1lY2hhbmlzbSB0aGF0IHdhcyBhZGRlZCBpbiB2Ni41LXJjMSwgYSB1c2UtYWZ0ZXItZnJl
ZSBmaXgsIGEgbWlzc2VkIGVycm9yDQpyZXR1cm4gaW4gYW4gaW5pdGlhbGl6YXRpb24gcGF0aCwg
YW5kIHJlbW92YWwgb2YgYW4gdW51c2VkIG1hY3JvIGluIGN4bF90ZXN0Lg0KDQpUaGVzZSBoYXZl
IGFsbCBhcHBlYXJlZCBpbiAtbmV4dCBmb3IgYSBmZXcgZGF5cyB3aXRoIG5vIHJlcG9ydGVkIGlz
c3Vlcy4NCg0KLS0tDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMDZjMmFm
Yjg2MmY5ZGE4ZGM1ZWZhNGI2MDc2YTBlNDhjM2ZiYWFhNToNCg0KICBMaW51eCA2LjUtcmMxICgy
MDIzLTA3LTA5IDEzOjUzOjEzIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVw
b3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvY3hsL2N4bC5naXQgdGFncy9jeGwtZml4ZXMtNi41LXJjNA0KDQpmb3IgeW91IHRvIGZl
dGNoIGNoYW5nZXMgdXAgdG8gNzBkNDliYmY5NjJjZTQ1NzliZWJkODI5MzhlZjdmMjY1YmMzZTZh
ZToNCg0KICB0b29scy90ZXN0aW5nL2N4bDogUmVtb3ZlIHVudXNlZCBTWl81MTJHIG1hY3JvICgy
MDIzLTA3LTIwIDIzOjM1OjIyIC0wNjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpjeGwgZml4ZXMgZm9yIHY2LjUt
cmM0DQoNCi0gVXBkYXRlIE1BSU5UQUlORVJTIGZvciBjeGwNCg0KLSBBIGZldyBzdGF0aWMgYW5h
bHlzaXMgZml4ZXMNCg0KLSBGaXggYSBLY29uZmlnIGRlcGVuZGVuY3kgZm9yIENPTkZJR19GV19M
T0FERVINCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KQXJuZCBCZXJnbWFubiAoMSk6DQogICAgICBjeGw6IGZpeCBDT05G
SUdfRldfTE9BREVSIGRlcGVuZGVuY3kNCg0KQnJlbm8gTGVpdGFvICgyKToNCiAgICAgIGN4bC9h
Y3BpOiBGaXggYSB1c2UtYWZ0ZXItZnJlZSBpbiBjeGxfcGFyc2VfY2Ztd3MoKQ0KICAgICAgY3hs
L2FjcGk6IFJldHVybiAncmMnIGluc3RlYWQgb2YgJzAnIGluIGN4bF9wYXJzZV9jZm13cygpDQoN
CkRhbiBDYXJwZW50ZXIgKDEpOg0KICAgICAgY3hsL21lbTogRml4IGEgZG91YmxlIHNoaWZ0IGJ1
Zw0KDQpEYW4gV2lsbGlhbXMgKDEpOg0KICAgICAgY3hsOiBVcGRhdGUgTUFJTlRBSU5FUlMNCg0K
WGlhbyBZYW5nICgxKToNCiAgICAgIHRvb2xzL3Rlc3RpbmcvY3hsOiBSZW1vdmUgdW51c2VkIFNa
XzUxMkcgbWFjcm8NCg0KIGRyaXZlcnMvY3hsL2N4bG1lbS5oICAgICAgICAgfCAyICstDQogZHJp
dmVycy9jeGwvYWNwaS5jICAgICAgICAgICB8IDUgKystLS0NCiB0b29scy90ZXN0aW5nL2N4bC90
ZXN0L2N4bC5jIHwgNCAtLS0tDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICB8IDQgKysr
LQ0KIGRyaXZlcnMvY3hsL0tjb25maWcgICAgICAgICAgfCAzICsrLQ0KIDUgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg==
