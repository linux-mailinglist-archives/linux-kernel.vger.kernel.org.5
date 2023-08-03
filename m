Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5276F0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjHCRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjHCRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:42:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A6D10B;
        Thu,  3 Aug 2023 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691084518; x=1722620518;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=3SWuMKQREYn7mlgF/xtUnzYDK0jmEamvkViRk2W08w0=;
  b=fKjb8Mfx6KkAtFSSdU78sDRuQN7gfb2RT/g5KOlKrfpvJ8MrDeAU2Io3
   WdmVbqNQVYgjdEIN6bjDxsu5bwYCoU5WtY7pwCq8zPiTAwzyLm2mr6T6w
   Tz55YbwHpcI3lYnzSO+RyeCLksRImlOfucLPpJfJPXek8k5yK+9SkK+BR
   Ju9bpZyzS0ZUEo1uqC3gzEurOSgTPKaF6+pn8DVm8d1uNfg0GKKnT2Wj4
   oW7j6NDkOi8RZuC5Rl+CC1j3kTDWbCz0j/lyBVSq98u/zsyk6dHeGOIDa
   wnEL0KrwhdWBj1T34ZXEVYH/9M+fy5+Glf9tIG8G6lK95kHP911vXSmka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373593322"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373593322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706654222"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706654222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 10:41:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 10:41:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 10:41:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 10:41:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 10:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em8SZM5Gxmv12PSEpk2ulw80ldkriLcqQ0/zXLbBnyOElkmWgfA24yfKwTM2UBev3FmWJqY4QCdKsP9NPzWy7hzoQAgS/IgaMXKBQy6/4mr4GUAaf9mn7QZIfXHljiRK1EbR9jlmiKX+g+F1+k5GhqT9XJSCtiw89Ll+q9FwIEbsZ13T0tS6eYGu4+RoOWXsfJN6+6MHXibcano2BVaxlR4J8LEz6vu+PH2Vw1Jx2yYdBsxJs5NDlLX39ACzf07orbStUsmADHYeZPm8DIp0qbk4i5rMSU3Tuad5xl1Y3NPOXqmUTxmU84dXcEr5puRCZv+qSuZZsiOZk4XnN1dnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SWuMKQREYn7mlgF/xtUnzYDK0jmEamvkViRk2W08w0=;
 b=mhAraY1RKfj/Zu1B2hJU21hX8yxQ272O7G82VX7TLp2pYShwMvfIErxq76lEvEAjbdFzSLyei7qeLaYRB8aI8G16x+Rb9Ayl5ctcSUioHLR7+QRdlfOOCpalWfPMLJSxxUcipa/tLsTQe5BXV1sqmIrgjjs9fJOA7IX91jPwnPn2UMSGHorOcaQ5cLWVoJf59K48WNquvON5wvJb7vEPRwESXrZK1UxvKUbB8dBAqAcqSACu5cahHZ7s0F0w17BUx9v4OOclsBuU2+ee7mwMCbFRz5v4rwh1YRVgJoEFvvoBqANa/ckq0Z3dBS0D/sw5iuwypOTi6A9fJsUkIsffaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 17:41:50 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:41:50 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc5
Thread-Topic: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc5
Thread-Index: AQHZxjHIgXsOjjni9ES77lk8FHmSUg==
Date:   Thu, 3 Aug 2023 17:41:50 +0000
Message-ID: <9689a32a5b56cd5521cd8ae3c2530329bc820cde.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB7986:EE_
x-ms-office365-filtering-correlation-id: 8adb8bf4-e130-4993-1af1-08db9448eb32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzSz2O/WXo8fQ+EtiRrNwiVuRdEjKed/etp9fH/SbHmaP/eRRWw4uOAJybr+C6hTzt0ux3soHVqSfS4HyX7anfnhFM+kzbTL2OskftyIyTS8HiKY3f6pw5GEh7Ffk36y1X+mobcbysJasbWWxl+ml1/az7jxLFHdHvoqqhbBQgloob9fxPLSuhh8lC+Ao4mJs4ww5FPEItrAObbpTT6/DUpDdiI8w7SiCGxA50y40GemAbQQ95zYk7QeSLau+PaJbqFBEvWAii7VISkO5idxRLGo1bXV6eiD2Iz2DBqgA+LV5G4L7mKSAkVR+A8gNK2SD9rCUCFrBthDkFwCNH4Sr/T0p5DgvmBWqogu7qyEnlzr3go1C9vsvgtEeSTdUXvgp2aLQbAcJxrf+TaYcJwQrX96ClW4TI9RIvaaqJdyejZa9CQT/RT4I3Uhz/pLrYi44YpJpmQ9i7GePR602opsPoyrNAIdv82ZpT9QIRocXm7iwcMzbiSrZEeg1C5n1lrNXxNgVATo3QuDhlQM31cGusCFE7zIZjr2ll4mkonNy2Uqjhz0SZIj7mlw+nL/Bt/l1AJhN3SCkjmgF4SaTVk8EHpYwENgj+UE+pouCSep20M1G4GIBkzVc13CURkyAwzZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(6506007)(83380400001)(186003)(26005)(8676002)(76116006)(316002)(66556008)(2906002)(4326008)(64756008)(66946007)(5660300002)(66446008)(6916009)(66476007)(41300700001)(8936002)(6486002)(71200400001)(6512007)(54906003)(478600001)(38100700002)(82960400001)(122000001)(86362001)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S20yYmJPd1g1V1dEb21BRmVTMUFGUzM2dkR0eEhLVDNGY3doanVweGJROTVw?=
 =?utf-8?B?blVYOHdFbklxOEFBV25FQTh4N0I1MGNGUGJkaDJ0YlBDWmxuQUhtSU5tbnY3?=
 =?utf-8?B?NHV2bjJ5eXBncEk0N1ZDbjEwQ1YzQmNsSG8xNXA5ZzdNVzFmOUlpWXhhTTNi?=
 =?utf-8?B?WXMxUExOVDYveFNCV3pMRFJSNllZYWZiWm1TN3ZoMnNQZFBNYUZmbXBkMFd1?=
 =?utf-8?B?ZTEySGxYZDJidXRhaFlVWXI5S2w4TkFLZXpsZUhCWldLTE15Ryt5N1dtT2R3?=
 =?utf-8?B?cE00eEpOamlNSUhiMXRtNmpWTXVObEwrTDliOG1aejZyRTZwZFJmWGlFNzhG?=
 =?utf-8?B?SXlocm05eXZtY0pkZUhmYVZ5U3A2aXdyRVJWQ0ZyWkQvS05pcHljdjl5ck51?=
 =?utf-8?B?OERpdlA1ZE1PcVllYXVZMTJIUXQxZXpORE0yekh1eDByTHAwU3N4UGFoaGpW?=
 =?utf-8?B?OHl1VzBkT2xKWDIwa0p6OXhDbm1xTzdJek9aaWU0aTRDRThZRGxRdWdCSTVo?=
 =?utf-8?B?dEdYMEZBWDg5bVhFK2ZidDhyQW1pUFFXY3BuQUNCY0ZuUTNlWUtTOFZwVlB5?=
 =?utf-8?B?WG9zRXptVVNtbFdaZDYyQjhQUzA0RFp1SXJ4Rk9mQ3RkQmhYeXhsd0FocW00?=
 =?utf-8?B?dDMyckZZaHBUSW1rOVBMU2JqbkxuQmtIL2h4d2Q1TjRHK2VGZzhFd1lQRi9u?=
 =?utf-8?B?Y2lYaHRBYnQ4eVlFQXl4MllBTitGOUR3L3RPK2lyMU1SY0tDWEU5RDFhZVUy?=
 =?utf-8?B?NWJlUVo0aW04bm1lUGZXVUVqUE80VW52OGJiaVg1cTh5bng4by9rZjVXR2No?=
 =?utf-8?B?UXJGWlBXTk41SUx3VWg3K3dFcDQ0RnJVVDd6REhqczYwVDNHek5pMkR6WE1n?=
 =?utf-8?B?dDhjRkdpVGptSGdoNnBlekVtRlZ0d3h5Sm1qZjJvc1ZSYklOZ2VNaEh1cUJ0?=
 =?utf-8?B?ZEpYKzBwZ1VsMlJaRG80K0hwd3BabkNsVVBST205aks0VWs5MEZ5SDJubHVs?=
 =?utf-8?B?cTBiZENzcjJ3ekw0SzZ1a1h2eHFkdjIzcTNTVmJ2aFg3bWRFN3k3RlZYTHRJ?=
 =?utf-8?B?UE9Pb0dLNjNEbE5yVVZycmtmY1NLK2tTZGYvNU5LUkFod3hVU2g3VDAxZzBN?=
 =?utf-8?B?Y2FuRGVSbVBuSVVsd1B0dG9Da3VTOEZaMmloRXlzU2hsa3QybDRyT210MkVt?=
 =?utf-8?B?UmovWlpnVHV5SWNDdklIaFhFa0ZVMjBKSmJaeHRMa0VlbzNQNXYxT3Z1Qjhy?=
 =?utf-8?B?d29rem9QK2xqdzVndzc3c1BVbGN5ekN4UTg5dGEzY3QxSlVBTkVxdDBrY3Bu?=
 =?utf-8?B?SllyMmJsZUtEbktRbG1wVTh5b2FSZXFnVEQzM0xFenp2Vk9vdFB0U2YzdmV6?=
 =?utf-8?B?YVRMZFMwWURkbXBrMmZlY3lUTlFZVlZ3R0VNL2kzMWdpbG1wdHRNQlgxcUsr?=
 =?utf-8?B?YVh6TnI0cVJ5cWN3QnM0NzlLZWN6OVp5bU1CaE9tOU9IdEhMSGRteDRSdnhq?=
 =?utf-8?B?NDYvc08vNXBmWEFqVkRscWs5eSsrblVvbFo1OGdPMkt5SHhlak9qbXNHR01h?=
 =?utf-8?B?SHBuTUxPRHhOdnRTak9OMkNoZE5YZUVzSGwvNXRjelZSaHArTnhGM0U4REFC?=
 =?utf-8?B?QXc3M1dhSkJJSks5SytLc3QwMkxYQTV4T3BYKzYveTM3eEl0cDYyVlRiQ1U2?=
 =?utf-8?B?dEwzZHhwL1lrWGs4K3ZzOElrby9PMXlGbWFudUVUbFUySHhnQ3d6dGtld2k5?=
 =?utf-8?B?TkRkU202YUpvdnZ5dW1HQXdTcUszS1lCWVhaVXZ0bXJEdWE4azQ1bmhEOEZP?=
 =?utf-8?B?MWI2RUNLUFo0MC9iTGQrWXZlK2w5VGRkNnIzUUdiM3NrYkJCZlZiT1ZoOSsx?=
 =?utf-8?B?cmlSUnQ1eTdRcFNTVDFVV1dxNldjcmRtNGxmWDQza1A2RDVQREcwbnExNFR2?=
 =?utf-8?B?ZFpNd1g1UEdST2Z4ejZvWnVKbEp1ZXJEMkxGcVFmTmErVkRvMXhRei8zdFJl?=
 =?utf-8?B?S0s4V1ZsM25FWXBTRGhWblc0b1VUVWovS3J0VkpQeWN5c3ZxUFdHd3VBd1dU?=
 =?utf-8?B?dEVrSE1XeFdrelpkeXhOTTdCSmZEMnhaeXJycEVLRzRBalJnZjExd3Z3N2I2?=
 =?utf-8?B?VkVhTUM3bFYxcC9YUW04OVZ6Z016LzJXb0dWcFhkcWNPa2tsS043eU9udDVT?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A3648EB15D8484CA11992A19A909FA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb8bf4-e130-4993-1af1-08db9448eb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 17:41:50.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inmtPgYZfvq5jht7qMxlICepjumKYfVWPatECREJZ3eHBdk/JhI508xRx/06S1PHHjnemo9IPsOFp2lQqnR3ninr4LTjnaC+XYjZPdBWmxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsIGZyb20NCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY3hsL2N4bCB0YWdzL2N4bC1maXhlcy02LjUtcmM1DQoN
Ci4uLnRvIHJlY2VpdmUgYSBmZXcgZml4ZXMgdG8gY2xlYW4gdXAgdGhlIENYTCBzYW5pdGl6ZSBk
ZXZpY2UgQUJJIHRoYXQgd2FzDQptZXJnZWQgdGhpcyBjeWNsZS4gVGhlIG9ubHkgY2hhbmdlIGlz
IHRvIGhpZGUgc29tZSBzeXNmcyBmaWxlcyB3aGVuIHNhbml0aXplDQpzdXBwb3J0IGlzIGFic2Vu
dCwgYW5kIHVwZGF0ZSB0aGUgQUJJIGRvY3VtZW50YXRpb24gdG8gZGVzY3JpYmUgdGhpcy4NCg0K
VGhlc2UgaGF2ZSBhbGwgYXBwZWFyZWQgaW4gLW5leHQgZm9yIGEgZmV3IGRheXMgd2l0aCBubyBy
ZXBvcnRlZCBpc3N1ZXMuDQoNCi0tLQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29t
bWl0IDcwZDQ5YmJmOTYyY2U0NTc5YmViZDgyOTM4ZWY3ZjI2NWJjM2U2YWU6DQoNCiAgdG9vbHMv
dGVzdGluZy9jeGw6IFJlbW92ZSB1bnVzZWQgU1pfNTEyRyBtYWNybyAoMjAyMy0wNy0yMCAyMzoz
NToyMiAtMDYwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoN
CiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2N4bC9jeGwu
Z2l0IHRhZ3MvY3hsLWZpeGVzLTYuNS1yYzUNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIGFkNjRmNTk1MmNlM2VhNTY1YzdmNzZlYzM3YWI0MWRmMGRkZTc3M2E6DQoNCiAgY3hsL21l
bWRldjogT25seSBzaG93IHNhbml0aXplIHN5c2ZzIGZpbGVzIHdoZW4gc3VwcG9ydGVkICgyMDIz
LTA3LTI4IDEzOjE2OjU0IC0wNjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpjeGwgZml4ZXMgZm9yIHY2LjUtcmM1
DQoNCi0gRml4dXAgdGhlIFNhbml0aXhlIGRldmljZSBBQkkgdGhhdCB3YXMgbWVyZ2VkIGZvciB2
Ni41IHRvIGhpZGUgc29tZQ0KICBzeXNmcyBmaWxlcyB3aGVuIHRoZSBuZWNlc3Nhcnkgc3VwcG9y
dCBpcyBtaXNzaW5nLiBVcGRhdGUgdGhlIEFCSQ0KICBkb2N1bWVudGF0aW9uIGFyb3VuZCB0aGlz
IGFzIHdlbGwuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCkRhdmlkbG9ociBCdWVzbyAoMyk6DQogICAgICBjeGwvbWVt
ZGV2OiBJbXByb3ZlIHNhbml0aXplIEFCSSBkZXNjcmlwdGlvbnMNCiAgICAgIGN4bC9tZW1kZXY6
IERvY3VtZW50IHNlY3VyaXR5IHN0YXRlIGluIGtlcm4tZG9jDQogICAgICBjeGwvbWVtZGV2OiBP
bmx5IHNob3cgc2FuaXRpemUgc3lzZnMgZmlsZXMgd2hlbiBzdXBwb3J0ZWQNCg0KIGRyaXZlcnMv
Y3hsL2N4bG1lbS5oICAgICAgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKw0KIGRyaXZl
cnMvY3hsL2NvcmUvbWJveC5jICAgICAgICAgICAgICAgICB8IDQ1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KIGRyaXZlcnMvY3hsL2NvcmUvbWVtZGV2LmMgICAgICAgICAgICAg
ICB8IDE5ICsrKysrKysrKysrKysrDQogRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1i
dXMtY3hsIHwgMTUgKysrKysrKysrLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQoNCg==
