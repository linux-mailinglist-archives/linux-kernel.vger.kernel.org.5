Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459C7643FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjG0CuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjG0CuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:50:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8801BD9;
        Wed, 26 Jul 2023 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690426214; x=1721962214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9iaoOdaCjuLK/tlSvx9RiT52XdRK8iNsylFnUlcLhBg=;
  b=PtP9vQd6cOSrgS50U/rthpZERCcp8a0wteIjk9wblmfBbj5eZITRQc+n
   1N+aVZtDYlKbU9yIfP0xwyKIwX4/u1qRP2p8rtbuvTVSa8bcocvhyv/FQ
   2EDLSngY5SnUp6xcTDjzs08nbTt4W/kNScNRgBQVepbJNtkfKQBpVVVfr
   PyAfm37XoHqFMzNC+wZW/NeWNu74sm+PYceadVKpuYJQUg3Ago7LFz3RF
   oASQYcaVKx7bYa48zC3cGEv2Y2vbMkcFasp3JgPPEqMdVLmyfhJsvUBbV
   Lh9zqtW67DpWL4VxI17C7iiDOCeAl5N7ch6+Q7qIlSkO1a87c1+iqzckJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367061140"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="367061140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726764554"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726764554"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 19:50:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 19:50:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 19:50:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 19:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtpX6ddi88qigQ17LSLWRf0k/TzRaPVkVlaS3jcWSS5rzNcyCItJylcsDBeQmMHSWz18xGVpUB/paTBf8aHw/6rFiGcgxI39RD380S10T2BQ9AJXFevsy37XoGD566zwhAgjnsELFIZgpIHs4zdCRjDsPTnZr/psaMB3blTs9angH6Q8Rv7PqEXRSQH3zb2iDuRYSNQZRgokIAUpK+xV9Wug8UmGhdcR/s8+cxMa76cZvbalxzwuPIOFRGedpsKOuZ0bzrxaueFYenxkSzPPwLAvBp2Dr94tPj4FvvdSKdiM2vQ8kc6Wnlw3C/oaabVY4ZTgypcseAIREm7HtgQ10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iaoOdaCjuLK/tlSvx9RiT52XdRK8iNsylFnUlcLhBg=;
 b=fhz676DGg/uKVTSd/8dKFsgO1IU3Te3tgdUpKELWZZmj9Te76If8NGe04kagnNZvDIesuaRdiudqJrwvkjuUl76L96ETY9Pw1vGvVkzuah8R8Fi9ne0eDR7yhvDmBE3JafMz4B09T6fe5mBshA4oT/oGS1b7H6MWsDnXeP5GA/WEGOcuPO0oNV9yheP8ZQSPNBpl6Kz5nIgU2WXF6nPMbPCQi/V8HUoy2kpDVgTGV2whuxJ9lgu/6kv9imqT2D7uPgCnWJ6gqrQjj+NFX8ytasKWJpEqbjsTEpT1x02Zfqv1n0m8UUDRCa51iIJKj9Cshh09QpirZMMZqWkZpAI+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:50:03 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:50:02 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Thread-Topic: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for
 EAUG race
Thread-Index: AQHZwCYBmjwKzMBZUUGqRDKoJ6bjba/M6cUA
Date:   Thu, 27 Jul 2023 02:50:02 +0000
Message-ID: <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
References: <20230727010212.26406-1-haitao.huang@linux.intel.com>
In-Reply-To: <20230727010212.26406-1-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN2PR11MB4677:EE_
x-ms-office365-filtering-correlation-id: fa7d0969-7618-42b7-03a0-08db8e4c2d15
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25TprIXko+m4Gcrp8WQuCfFi/6yuYAvfM9WEKW2WIX9xQSDAOprNtGPG8xXg8iIYts4lr9l3QcN6IJtrdMSxSo4bUeSkfS9aCZIb7ckHHxidrYtZqzpgmm1siV1XtPSDx0Ul3IQrTAfhN9ImSahw5pva7sgwoWsMt1xNuDn6x9wX01RNw0u3OwkjXZp7FbjNKy/5hn9mb/QkWk6KVi7Om0ydT7zikXVKNuvUX8CF3VPRYt7QgXOEOT0yakcy1j6VT5T7z84KNJ555FJOlvS7Q23R6cQgRRJlpthlBPAe8j0sMEihQTOMfjxCU+fHcSBElUrYGooGf/AvZTk6/MN4rj7AkqSjVETJknGyAkYeGnJxSlvYxXU1Auhc9cpdFhxPuQvLh+GC5LiVGl3cv9pIKfgPQcjkMBObv9ud2Kgt5mkra4i2lxSjVphAEwkpujkpX6TwvV0aEcfR6+tIMbeXw+6cRAmgPrP1eRoymmyx0w/6VMHXVsFnJuQeh3yFiEc4rqre7Hrivub1y/58/rQI9T9N20K6lQsj3YWNR9jAzIrtthRNYTQroxt+Sx0n9oS+RhAK4+wfJrFIgVlqohYjMvv+zQcshF6+GIIHUoNPZyv9s+J7Eg4Vh/nbhxYY1V0W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(54906003)(6512007)(110136005)(6486002)(966005)(478600001)(36756003)(38070700005)(86362001)(66446008)(2906002)(66556008)(71200400001)(2616005)(66476007)(186003)(6506007)(26005)(82960400001)(64756008)(921005)(122000001)(38100700002)(76116006)(4326008)(66946007)(91956017)(316002)(41300700001)(8936002)(5660300002)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkN6YVJZb0FvU3R3c1UzS1hJbEVLQmdPL3BpR3FCaTduVlRBandBMDEwUHBL?=
 =?utf-8?B?MzJNOFVtVlEyQ3loRmpWb0dlZmZ1N3B3ak9hTm5MaFRpV3NybkdFa1NUYnkv?=
 =?utf-8?B?dExPOVNIQUFpT1hQYXBQOVY5RXFKa0F4YTNEc1dKNzkzcXYwWnFwbm5BdStY?=
 =?utf-8?B?UU1RVTlDSGtqUWxzN2cvSDBEU0JEMnltM3A3b3ZFNzl6S0c5YytteGtsOG9B?=
 =?utf-8?B?TGNYdlhwQjFNNDBCdGFONmErT0lDbi9RZzZZZjExS3VlZXp2aGc4Qk1seElC?=
 =?utf-8?B?cEZ6U2VSdzFFTG9YcDN2RW5LMk1DdTJsN3JSaFJVZTVBUGZrUVZ3c3loR2J4?=
 =?utf-8?B?TWkzYjM0ZExFR0szZDlVeTBEbkUzaEJNRUN2QmxXWEVHMkRGWGhMbVJjN3Vr?=
 =?utf-8?B?UFdOS1EvcG5Da25kTzBPTzNXRWJ6VE4rVjlEalRaV1l5WkNqTENNbklUVUI0?=
 =?utf-8?B?QzdJU2tkNWtYY3h2L0EzMW1TTG1mRXZyV3hsbzhlOVMyZFZtN25ORjNGZGJI?=
 =?utf-8?B?bzREVHE3T09SNDVrQ0FJUElFK2Z3YXZRWlVRVjBKakFhTDYwU3N1TDQ0Q3Rq?=
 =?utf-8?B?Q3VGZWpyWE8wLzFYU0pVWldMcmlJdTNtZkI4aFhBNXc0R3pvR2xMb2M1Q3hB?=
 =?utf-8?B?ZG50WmtHdzNCOEtJVFJ5QjVpNXhkcHZra1pEUGNzZ3RINTd1d29aUmJnYzVI?=
 =?utf-8?B?SFplenNZWnN5RXMxcm5tNkJrck84Uld6SHdqSFd1VEpMY2s1RkNqWmxJVG5m?=
 =?utf-8?B?cWUvV0VtU0c0R3FZNWVtc1NTbVFhVXh2cncrYkJOTk5oandnL0lERE1weXVF?=
 =?utf-8?B?Mmd2RVlHV2VzZzIveFpVcXkvaUVndlJ1Qkl4S2doVTN3OENYaitUNlFCcjJa?=
 =?utf-8?B?cFhpellXRVBacnRwVEVQc3Vnb2x4NG4zN2RuTFhESEgrRFBjYW9Qc1BDVzd6?=
 =?utf-8?B?cTE5aW1rV2JWbXpId1JxRElZejVqaEJpdEtsTXVlM2djRGdPcEprRXBiWW8r?=
 =?utf-8?B?cVZkZ2hRbmR6eWswOFAycDRrZmVLV2U2ZjRsUkdjeVNrV3Awb0d1R1I5UTQx?=
 =?utf-8?B?cFM4VkUyU0E4OVZ5RG9FSlJOcXFZRE1ZY0N3WU9PeGVaZ0xVOENFMDBOeEkr?=
 =?utf-8?B?TVJWZEk3LzZyYnNqWmNnbGx2NGpTRkN4ZUp6QjRDckdGSDEwN25xcWxzSjBM?=
 =?utf-8?B?WTRjNEF0LzdJTzdYcFI4djk4U2NDMFdCSUFmcmJaMU40R0k3VmlCWEUwYW55?=
 =?utf-8?B?anJnRm9HWUFyUHZKeGxrRUtDVVM3YUlWYkZHZDRvZGE2bFZEa2VnRlhFQkt2?=
 =?utf-8?B?VTJMZ0wwK0V3K0pZZEp1WWdxVGVNbnVXclRRVU1ZdmZ4QVRsK09nQmVnQTF4?=
 =?utf-8?B?N2VrS1NMZ2dVengrUUJiaFZKNlZINm1sVXFOOTJ6Z0FoRDMxM2k3bUd5dWxT?=
 =?utf-8?B?aFNJZzA1THdSMmkxZm5RV3paS2k2czBaMzlDTFpuZGNLYWdPN1ZFTEMyUEdX?=
 =?utf-8?B?QkRRNlF3YzlXUEtlL3NLTzU2U255UmJtVTR1L01xVHBXTmVzVlE2SWJOUVo1?=
 =?utf-8?B?M3dRWlFlR3BxMElwQm5oSU15bDVmL2pZbXRDckFkTFBvWThxNGZBblVQdzla?=
 =?utf-8?B?c0hrREdKa3FreWVWdEgvTjJ4STNCVm9xckJuaTlucENWSnhweGdNVCtyY0JU?=
 =?utf-8?B?Y0NnY0VkRlU3Y3ZMU0pNSVcwdEx3dXZTb3NjcWVITkhLVk1aN2xyZENVbGli?=
 =?utf-8?B?WkFPaWYzNXpnSGlLTEJ1NXBwM2NGWW4vS3RDV3paNEVDZ0drdlVxZXZWMlNE?=
 =?utf-8?B?K2RnNDhuU2s2Mm4xTmlHdm8yOEI3Y3NuRUdKajZkNW9ZZGlpaHRhSjRKaHRa?=
 =?utf-8?B?OXpjYVVON2M1d1Bpa0RZR2hDVVp4bjdSVG9tYXI0RVhuRFhTSG50MDc3aTR4?=
 =?utf-8?B?NGpBdXBFR2ZxazlhTGRNb1JpenlaRnBiQU1OcUpnUHNvTXpoMG8zNVZQZWkx?=
 =?utf-8?B?NnpKUFRFM0hOZDRtQXpBNUZBQnFCMFJSc0FUMDdBcTBVdnRDNC9waE80ZmFj?=
 =?utf-8?B?SU1Ra2EyT0xUWldoajZHWnk1dUtBSEo3WjIrekJMWm9VSTZuQWRFSmYrVmho?=
 =?utf-8?Q?NpxRstoHkedSZqNPTrqtshm5m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E9195B5445D3E41B19B47343A316A9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7d0969-7618-42b7-03a0-08db8e4c2d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:50:02.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmmIIbHJ4y5nCxWE4jfHDb1bmyI7GVQqizK1mRXzr8mXG/isCzamgKSBTyceNmfVb+dXPj7zYI2IxsmrYe6ziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDE4OjAyIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFVuZGVyIGhlYXZ5IGxvYWQsIHRoZSBTR1ggRVBDIHJlY2xhaW1lciAoa3NneGQpIG1heSByZWNs
YWltIHRoZSBTRUNTIEVQQw0KDQpJZiBJIHJlYWQgY29ycmVjdGx5LCBEYXZlIHN1Z2dlc3RlZCB0
byBub3QgdXNlICJoaWdoIiAoaGVhdnkgaW4gdGhpcyBzZW50ZW5jZSkNCm9yICJsb3ciIHByZXNz
dXJlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL29wLjE3OWE0eHMwd2p2am1pQGho
dWFuMjYtbW9ibC5hbXIuY29ycC5pbnRlbC5jb20vVC8jbTkxMjBlYWM2YTRhOTRkYWE3YzlmY2M0
NzcwOWYyNDFjZDE4MWU1ZGMNCg0KQW5kIEkgYWdyZWUuICBGb3IgaW5zdGFuY2UsIGNvbnNpZGVy
IHRoaXMgaGFwcGVucyB0byBvbmUgZXh0cmVtZWx5ICJzbWFsbCINCmVuY2xhdmUsIHdoaWxlIHRo
ZXJlJ3MgYSBuZXcgImJpZyIgZW5jbGF2ZSBzdGFydHMgdG8gcnVuLiAgSSBkb24ndCB0aGluayB3
ZQ0Kc2hvdWxkIHNheSB0aGlzIGlzICJ1bmRlciBoZWF2eSBsb2FkIi4gIEp1c3Qgc3RpY2sgdG8g
dGhlIGZhY3QgdGhhdCB0aGUNCnJlY2xhaW1lciBtYXkgcmVjbGFpbSB0aGUgU0VDUyBwYWdlLg0K
DQo+IHBhZ2UgZm9yIGFuIGVuY2xhdmUgYW5kIHNldCBlbmNsLT5zZWNzLmVwY19wYWdlIHRvIE5V
TEwuIEJ1dCB0aGUgU0VDUw0KPiBFUEMgcGFnZSBpcyB1c2VkIGZvciBFQVVHIGluIHRoZSBTR1gg
cGFnZSBmYXVsdCBoYW5kbGVyIHdpdGhvdXQgY2hlY2tpbmcNCj4gZm9yIE5VTEwgYW5kIHJlbG9h
ZGluZy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGNoZWNraW5nIGlmIFNFQ1MgaXMgbG9hZGVkIGJlZm9y
ZSBFQVVHIGFuZCBsb2FkaW5nIGl0IGlmIGl0DQo+IHdhcyByZWNsYWltZWQuDQo+IA0KPiBUaGUg
U0VDUyBwYWdlIGhvbGRzIGdsb2JhbCBlbmNsYXZlIG1ldGFkYXRhLiBJdCBjYW4gb25seSBiZSBy
ZWNsYWltZWQNCj4gd2hlbiB0aGVyZSBhcmUgbm8gb3RoZXIgZW5jbGF2ZSBwYWdlcyByZW1haW5p
bmcuIEF0IHRoYXQgcG9pbnQsDQo+IHZpcnR1YWxseSBub3RoaW5nIGNhbiBiZSBkb25lIHdpdGgg
dGhlIGVuY2xhdmUgdW50aWwgdGhlIFNFQ1MgcGFnZSBpcw0KPiBwYWdlZCBiYWNrIGluLg0KPiAN
Cj4gQW4gZW5jbGF2ZSBjYW4gbm90IHJ1biBub3IgZ2VuZXJhdGUgcGFnZSBmYXVsdHMgd2l0aG91
dCBhIHJlc2lkZW50IFNFQ1MNCj4gcGFnZS7CoA0KPiANCg0KSSBhbSBub3Qgc3VyZSB3aGV0aGVy
ICJub3IgZ2VuZXJhdGUgcGFnZSBmYXVsdHMgd2l0aG91dCBhIHJlc2lkZW50IFNFQ1MgcGFnZSIg
aXMNCmFjY3VyYXRlPyAgV2hlbiBTRUNTIGlzIHN3YXBwZWQgb3V0LCBJIHN1cHBvc2UgdGhlIGZp
cnN0IEVFTlRFUiBzaG91bGQgdHJpZ2dlciBhDQojUEYgb24gdGhlIFRTQyBwYWdlIGFuZCBpbiB0
aGUgI1BGIGhhbmRsZXIgdGhlIFNFQ1Mgd2lsbCBiZSBzd2FwcGVkIGluIGZpcnN0Lg0KDQpJIGd1
ZXNzIHlvdSBjYW4ganVzdCByZW1vdmUgdGhpcyBzZW50ZW5jZT8NCg0KPiBCdXQgaXQgaXMgc3Rp
bGwgcG9zc2libGUgZm9yIGEgI1BGIGZvciBhIG5vbi1TRUNTIHBhZ2UgdG8gcmFjZQ0KPiB3aXRo
IHBhZ2luZyBvdXQgdGhlIFNFQ1MgcGFnZTogd2hlbiB0aGUgbGFzdCByZXNpZGVudCBub24tU0VD
UyBwYWdlIEENCj4gdHJpZ2dlcnMgYSAjUEYgaW4gYSBub24tcmVzaWRlbnQgcGFnZSBCLCBhbmQg
dGhlbiBwYWdlIEEgYW5kIHRoZSBTRUNTDQo+IGJvdGggYXJlIHBhZ2VkIG91dCBiZWZvcmUgdGhl
ICNQRiBvbiBCIGlzIGhhbmRsZWQuDQo+IA0KPiBIaXR0aW5nIHRoaXMgYnVnIHJlcXVpcmVzIHRo
YXQgcmFjZSB0cmlnZ2VyZWQgd2l0aCBhICNQRiBmb3IgRUFVRy4NCg0KVGhlIGFib3ZlIHJhY2Ug
Y2FuIGhhcHBlbiBmb3IgdGhlIG5vcm1hbCBFTERVIHBhdGggdG9vLCB0aHVzIEkgc3VwcG9zZSBp
dCB3aWxsDQpiZSBiZXR0ZXIgdG8gbWVudGlvbiB3aHkgdGhlIG5vcm1hbCBFTERVIHBhdGggZG9l
c24ndCBoYXZlIHRoaXMgaXNzdWU6IGl0DQphbHJlYWR5IGRvZXMgd2hhdCB0aGlzIGZpeCBkb2Vz
Lg0KDQo+IEZvbGxvd2luZyBpcyBhIHRyYWNlIHdoZW4gaXQgaGFwcGVucy4NCj4gDQo+IEJVRzog
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAw
MA0KPiBSSVA6IDAwMTA6c2d4X2VuY2xfZWF1Z19wYWdlKzB4YzcvMHgyMTANCj4gQ2FsbCBUcmFj
ZToNCj4gID8gX19rbWVtX2NhY2hlX2FsbG9jX25vZGUrMHgxNmEvMHg0NDANCj4gID8geGFfbG9h
ZCsweDZlLzB4YTANCj4gIHNneF92bWFfZmF1bHQrMHgxMTkvMHgyMzANCj4gIF9fZG9fZmF1bHQr
MHgzNi8weDE0MA0KPiAgZG9fZmF1bHQrMHgxMmYvMHg0MDANCj4gIF9faGFuZGxlX21tX2ZhdWx0
KzB4NzI4LzB4MTExMA0KPiAgaGFuZGxlX21tX2ZhdWx0KzB4MTA1LzB4MzEwDQo+ICBkb191c2Vy
X2FkZHJfZmF1bHQrMHgxZWUvMHg3NTANCj4gID8gX190aGlzX2NwdV9wcmVlbXB0X2NoZWNrKzB4
MTMvMHgyMA0KPiAgZXhjX3BhZ2VfZmF1bHQrMHg3Ni8weDE4MA0KPiAgYXNtX2V4Y19wYWdlX2Zh
dWx0KzB4MjcvMHgzMA0KPiANCj4gRml4ZXM6IDVhOTBkMmMzZjVlZiAoIng4Ni9zZ3g6IFN1cHBv
cnQgYWRkaW5nIG9mIHBhZ2VzIHRvIGFuIGluaXRpYWxpemVkIGVuY2xhdmUiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjArDQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFu
ZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphcmtrbyBT
YWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IEFja2VkLWJ5OiBSZWluZXR0ZSBDaGF0cmUg
PHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQoNCldpdGggYWJvdmUgYWRkcmVzc2VkLCBmZWVs
IGZyZWUgdG8gYWRkOg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwu
Y29tPg0K
