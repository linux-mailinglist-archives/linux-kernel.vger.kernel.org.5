Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877D7BB47C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJFJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjJFJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:49:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA49F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696585742; x=1728121742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BLLeUO6O++XgqfpbntyD131vlbbVKnnv1R1ELppib7E=;
  b=ShXw/TaYeB7eqS8osYxxxXfVtkfzPatYeCtZPvzCWhE38GHRoqGMR571
   73w0tXe+aWRVO8RBptseQwDLM5xH6giJ2LqvSdPxCEK1lKy+SFZFWYxgU
   3wLVpMzKJpVT3sSqN0HFT3NlLr8AYE9uNxQ24UaGoryyddbFzfCuznJSx
   y3V6a6AHUlFtAQkWUI372/kSCMwwRr9lJPvDrOHM/VLhy1BQmcTGcxzE6
   7H0jKJ8KgJ7EA3btK8B0NkhkwIiql6NgA7RWnrtI7vjmFBiWvUpfq7PF/
   iu36VywjtG+9Po7K4+NPCtmtZkr7WpIknjqjdTZUm9Qc8ezRW8itLE3eK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="387598834"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="387598834"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868284250"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868284250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 02:48:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 02:48:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 02:48:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 02:48:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 02:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enLX812P1WMWDcwEd921QclQyw5/i0Nm/3sEdwiHo6X9N1pyjgwivpn4GPNYiteix0QiPPd3IBZ9e4/ltW+zf9oaiVGJJuP1etFDqPtF7E3IpS7VZPtHMeuWBcQeUOqBQSsYNkIrll0NObbBj28I1tN4SBLVsYkiyeYSatngtX+RNAYSc7Hbq4PmgXxoD7X3gPfHJruiqlgve6LDKI/DtTAgEuFBm6bkFzgQuHo1T9kRFA/Nnr0t70fx2VEKcmrTtEtu9hGsJDByz3McEg535/oEkQBW6HR4OABPITbC5UQPYbH0bToCstdP9kQfi5ckOxLjz7JomrkijGPtKvQj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLLeUO6O++XgqfpbntyD131vlbbVKnnv1R1ELppib7E=;
 b=O5FEkA9uR50VFmNfD8upF9m75/3y44Tw8EqPUYSqErQRuK/Py2DYX33UofuSe9H/vJLa3g9WWYoGcajZe0IibO3EM5Fvox+NvA5jp+RmVK/ajv0wcieWy9hdWM7CxBjXPUueDDV/1MQsMb5y8rNJIDOGfiSvEQxV4KS2ArNczp/7P0C7DIhepYpTW7bzArGZ/3m+kDMc9WPtnyMDsuNARC7ecy3rZEDzqwoQetfq0QhsI/WoChdwBYYbgJrOpJcOInPWHz/YyNXhRIt73Qh2wdrVUlxpCPryEvqPLn7KXvXbePJ/QILfAtfKp6jDhVLkTic91HFwjIPD5i0lYk1SIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 09:48:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 09:48:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Sun, Yi" <yi.sun@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yan, Dongcheng" <dongcheng.yan@intel.com>,
        "yi.sun@linux.intel.com" <yi.sun@linux.intel.com>
Subject: Re: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Thread-Topic: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Thread-Index: AQHZ+B6dKnLc5bB7/U+LmK8j/rA7EbA8hGSA
Date:   Fri, 6 Oct 2023 09:48:55 +0000
Message-ID: <9db9a874e5b7ff62e9cb419f51279047438c30ec.camel@intel.com>
References: <20231006062855.875631-1-yi.sun@intel.com>
In-Reply-To: <20231006062855.875631-1-yi.sun@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6370:EE_
x-ms-office365-filtering-correlation-id: eeddf2c0-457d-47a1-d248-08dbc65174af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkltihAo7SCHCRDuFWxpxBf6N8WfEurbCnm3LIIzI4By4e/xvntsSAiKpN4rknw+c9pZY4wu/mtIXOhjV0jLSpQ6USbsxDLMji6t6mIf8jFH4REbZ90ijRxv7wXA9J2pHATUhGxHc2gkUuR2tZFite4rb3UKCZSqnI5V2DbCsdZDclOgzpBRYsBvqKEx1qURlzyR7jW70UwWBFoRO3n0G4nKlyyw1C7sosjqFgrn2/KVvvXdKvl9x1wJ91j5WPA9o5JWPIsNAVQPZIwVJv7AaLV7/e98wzRK/iMwLRsPFG0HHcIbOf1oxqzs87a5sbGAmphoWGH5txqWRLR/BwndbW9db8vzq54dObmQR7F6iHM2ARCx131ZZUpuucNy7F3BczvZQUZE0p2MOaS0ExLPQV0SsQzqvPHVvZj6NGDD2YMiN3AGUAAjzyM/UebvPw/s2mtPsTrE0qAIBwT9bzQbSBCLc+njWPXpPTxmxZpGuOo3rZDJlpIxIx6J0vW7N6SndkBpVYUch9qCtYmYK5Mthgmcn6ijpGwRabWAQRzzE7M19oAIvVyrUJp35hi0bKFHb5CZBBZTEv9+pXGq0lmadioG/7FjBc9bu8jnL2lYCsR13wUWr2sq6Kgq94f5LHts
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(71200400001)(6506007)(6512007)(6486002)(478600001)(38100700002)(86362001)(38070700005)(82960400001)(122000001)(7416002)(41300700001)(316002)(2906002)(2616005)(26005)(36756003)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(5660300002)(76116006)(91956017)(110136005)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEJjVDQ1bXpWQS9XRjM5MHhlY1U3UDB2SjNFSlVLa0ZTa01sdHFGdzhWUk9Z?=
 =?utf-8?B?cjNRM1I0TXJHZUVBTXJ5YU1DSlFGODl1dVhOYmNBMzFGYlJOR2wwWGlSb25D?=
 =?utf-8?B?M096WVBtcnlCUkxTRGxTUmd3WWZlY1VDRVdYNERSQm42L29zV3hreDdDVWpN?=
 =?utf-8?B?ZWQ5TFY1NS9MZHhuUURGczFxWlRTVFNKN2VDSDBubXVqY0duZU0yMWZ2MmxN?=
 =?utf-8?B?RlVINjFHaklzcmpaM0VlWVQ1bWNkRlgvbXIyck12emdlYmphdmYxdWVLNUIz?=
 =?utf-8?B?ZEh5YldFNERiRC9MOHkrVVNMd0s1MjIyK0FmOVRQOXJua3d3U205NmtZSzdu?=
 =?utf-8?B?RHJwMm9jVmVOOFJXOXFRb215UG53SWJRd0diWmFmV05xT0o2aEczeWxLa2dR?=
 =?utf-8?B?a250aHMzZDJGdHp1KzF1YUxUL1oraVlEWnc5Q1A1cWtuMDkzVEZxakR0L3A0?=
 =?utf-8?B?WnZLSkVERmZtWDVIY3ZtMmN4WlFUWW9mRTlmenYxbm9RRDZFMEd4dVUva1Ji?=
 =?utf-8?B?cFduMkxnMThzMW8wQU1sNXo2c2o0dnpkR1p3eDZTRWlIZ0xGRERBcStncWZa?=
 =?utf-8?B?ekdFRnhpWDlBby9wVUxTNldPUjhXaUpmQ2JPREhhb2VWeGwwOUtxMzd3SUdq?=
 =?utf-8?B?TWM5M1FNa1VTYlhFNUl5WkxNODhZdldwVDhGM1FBRVY1WXgxY2puNzFBbzlh?=
 =?utf-8?B?VHpQQWVub0tSMk5pU0VIZGhTZ0Vqc1YzdkE3QjFGSHB6MjM3ZGFWRDUvRHk3?=
 =?utf-8?B?RlpzT2lZOWh5YlJrWFhRMURueVhmSXIrN0I1dXh6VVZHZjVpTmpsbkNValpI?=
 =?utf-8?B?dHBYZmt0MDVIZld1Rzc3eS9IQnVNT1hMVEVXMitWR0lhT1diNGV5dXNXOEhG?=
 =?utf-8?B?UWFQTmduZWNBVHNQOTFWbnIyMncwZlBFaFBLV3ZTSEk2VDdiM0VtZnRMdUlr?=
 =?utf-8?B?Y3lNZHMwZlZuQ3lPa0hRN0ZYaHdxU2FvdXVwWWpwZU54eXB0NlhCeENSbE9s?=
 =?utf-8?B?MGRyQjM0ck9HMm0wYmpmYmRiamw3bDRwTHU1RDRHWmVCUjZrLytldEV2RXdK?=
 =?utf-8?B?b3o4MVl0b3dORUMvR0Y1VU1NU0VaeEl4ZkwyYm5qb1J5c2drZmVWb3VzRjFZ?=
 =?utf-8?B?T2dJTStzdkJ5RnZsMmhsTkF5dG9PU2ZCUjdPWHFqcWhJdUtWN3BjK0ZCZ0ov?=
 =?utf-8?B?VmJ4L0J1RnJCM3ZNZ3FWd1lIaEQyMFoxNkRIUjV6cWNYbnRFYlJmTURqWU5z?=
 =?utf-8?B?UTc1dU1DbkErdHdUZTFsdk5UQzdodnZJcHZQSHZ4N1VNZEdXN0Z6aVVVQVZD?=
 =?utf-8?B?YjhKYUtwZEovbDVzaGpSM0NrdXZTM1pnb3pkamlydVZ6UnloYXNmZE0zdWJN?=
 =?utf-8?B?bEdWUnh2T0lEODZhNnBEYlFudjlwd0p0QTN1bHNWMlhZVkEzbUdIYk1QUjBn?=
 =?utf-8?B?cnlvSDlTQStvdk0yK2N5UXNsenE0elRjK0pwbWpDQUJ4dlVDNnZtQUpwbnhm?=
 =?utf-8?B?U3gvQUhubEV0TTBVN0JZaDhLNlV2T3VrQmhnWTVWNkpyajQzSklWbTBNUlBI?=
 =?utf-8?B?TDRhRFRZYnN2Z0pKMjhDTTFYVG1jRHMyVTJCN2x2ajFSZ3d3ano0RzhmbHlI?=
 =?utf-8?B?c1dhdDVwSXFCTFNxbXUzeWppYmtXR3hTTXFoSTBwMHh1TXVTUURDajhNVFBY?=
 =?utf-8?B?cGtpTzJMeXdIVkhPZGtlR0VGcGhVTlVtaHYyWTdvYzlMQTQrdGdIcVllcC9D?=
 =?utf-8?B?Sjd1WE1mQjhMbUZGeGZBWkRLSyswNzNyRGFablhlSk1nM1Q5L3dncWNGRHRq?=
 =?utf-8?B?R1JLYjIwMDZ1SUVxbFpHMXdEYkU4QVBHRVBpQUwxc090RXBqME91cmNodWpx?=
 =?utf-8?B?Y0lkZm5ReVdOUS9CTTFFSDZ0STg4V0J2eFFJTzlEaEZYZElwL2xCeVZSRDlS?=
 =?utf-8?B?dWdzdmxYbzlkWlBXVjhWWFZzbTdxcDFIa0V2Vit0VGdVNG1MK01mUjdnRUhE?=
 =?utf-8?B?ODV3UWpIVGlYNm84R3RkaWkxa1Q1RlJlUUZQQ2JEZ3RYUWpUb0ZIU08wT1BK?=
 =?utf-8?B?MW1HVkhuM0pkZVNnOXBCTnd0V0d6dnE5bUI3eXkyWW5kUlVwYk8rOHQzOUFR?=
 =?utf-8?B?dGNTN2ZkL3RSTmFWc2V6RlVZbzJubmN4OC93Z0cxMDBzTjhYeHRBVk9iTkpE?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F942A8589DBB4DBC1D57EE2E0B38D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeddf2c0-457d-47a1-d248-08dbc65174af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:48:55.5350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hqRv9QRXYj8kr6vQihUfazDc9htN8GK6dV9EKcL4ZVlMEsyznSZpN6dJ10RMSgaEPFF0NSz1J3MVaIH//ZPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
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

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE0OjI4ICswODAwLCBZaSBTdW4gd3JvdGU6DQo+IEl0IGlz
IGVzc2VudGlhbCBmb3IgVEQgdXNlcnMgdG8gYmUgYXdhcmUgb2YgdGhlIHZlbmRvciBhbmQgdmVy
c2lvbiBvZg0KPiB0aGUgY3VycmVudCBURFguIEFkZGl0aW9uYWxseSwgdGhleSBjYW4gcmVmZXJl
bmNlIHRoZSBURFggdmVyc2lvbiB3aGVuDQo+IHJlcG9ydGluZyBidWdzIG9yIGlzc3Vlcy4NCj4g
DQo+IEZ1cnRoZXJtb3JlLCB0aGUgYXBwbGljYXRpb25zIG9yIGRldmljZSBkcml2ZXJzIHJ1bm5p
bmcgaW4gVEQgY2FuIGFjaGlldmUNCj4gZW5oYW5jZWQgcmVsaWFiaWxpdHkgYW5kIGZsZXhpYmls
aXR5IGJ5IGZvbGxvd2luZyB0aGUgVERYIE1vZHVsZSBBQkkNCj4gc3BlY2lmaWNhdGlvbiwgYmVj
YXVzZSB0aGVyZSBhcmUgc2lnbmlmaWNhbnQgZGlmZmVyZW5jZXMgYmV0d2VlbiBkaWZmZXJlbnQN
Cj4gdmVyc2lvbnMgb2YgVERYLCBhcyBtZW50aW9uZWQgaW4gdGhlICJJbnRlbMKuIFREWCBNb2R1
bGUgSW5jb21wYXRpYmlsaXRpZXMNCj4gYmV0d2VlbiB2MS4wIGFuZCB2MS41IiByZWZlcmVuY2Uu
IEhlcmUgYXJlIGEgZmV3IGV4YW1wbGVzOg0KPiANCj4gTVNSIE5hbWUJCUluZGV4CQlSZWFzb24N
Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBJQTMy
X1VBUkNIX01JU0NfQ1RMCTB4MUIwMQkJRnJvbSB2MS41DQo+IElBMzJfQVJDSF9DQVBBQklMSVRJ
RVMJMHgwMTBBCQlDaGFuZ2VkIGluIHYxLjUNCj4gSUEzMl9UU1hfQ1RSTAkJMHgwMTIyCQlDaGFu
Z2VkIGluIHYxLjUNCj4gDQo+IENQVUlEIExlYWYJU3ViLWxlYWYJUmVhc29uDQo+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAweDcJCTIJCUZyb20gdjEuNQ0KPiAw
eDIyCQkwCQlGcm9tIHYxLjUNCj4gMHgyMwkJMH4zCQlGcm9tIHYxLjUNCj4gMHg4MDAwMDAwNwkw
CQlGcm9tIHYxLjUNCg0KSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHlvdSB3YW50IHRvIGxpc3QgdGhl
c2UgZGV0YWlscy4gIFBlb3BsZSBjYW5ub3QgdW5kZXJzdGFuZA0Kd2hhdCBkbyB0aGV5IG1lYW4g
aW1tZWRpYXRlbHkgYW55d2F5ICh3ZWxsIGF0IGxlYXN0IG1lKS4NCg0KVGhlIGp1c3RpZmljYXRp
b24gdy9vIHRoZW0gc2VlbXMgYWxyZWFkeSBnb29kIGVub3VnaC4NCg0KPiANCj4gRHVyaW5nIFRE
IGluaXRpYWxpemF0aW9uLCB0aGUgVERYIHZlcnNpb24gaW5mbyBjYW4gYmUgb2J0YWluZWQgYnkg
Y2FsbGluZw0KPiBUREcuU1lTLlJELiBUaGlzIHdpbGwgZmV0Y2ggdGhlIGN1cnJlbnQgdmVyc2lv
biBvZiBURFgsIGluY2x1ZGluZyB0aGUgbWFqb3INCj4gYW5kIG1pbm9yIHZlcnNpb24gbnVtYmVy
cyBhbmQgdmVuZG9yIElELg0KDQpBbHRob3VnaCBhbHJlYWR5IG1lbnRpb25lZCBpbiB0aGUgcGF0
Y2ggdGl0bGUsIHBlcmhhcHMgc3RpbGwgYmV0dGVyIHRvIGFkZCBvbmUNCnNlbnRlbmNlIHRvIHNh
eSB3aGF0IHRoaXMgcGF0Y2ggZG9lcy4NCg0KPiANCj4gVGhlIFREQ0FMTCBUREcuU1lTLlJEIG9y
aWdpbmF0ZXMgZnJvbSBURFggdmVyc2lvbiAxLjUuIElmIHRoZSBlcnJvcg0KPiBURENBTExfSU5W
QUxJRF9PUEVSQU5EIG9jY3VycywgaXQgc2hvdWxkIGJlIHRyZWF0ZWQgYXMgVERYIHZlcnNpb24g
MS4wLg0KPiANCj4gSWYgdGhlIF9fdGRjYWxsX3JldCBmYWlscywgZXhwZWN0IGEgemVybyB2YWx1
ZSBmb3IgYWxsIHRkeCBzeXMgaW5mby4NCg0KX190ZGNhbGxfcmV0IC0+IFREQ0FMTA0KDQpBbmQg
SSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kICJleHBlY3QgYSB6ZXJvIHZhbHVlIGZvciBhbGwgVERY
IHN5cyBpbmZvIiBtZWFuLg0KDQpBcmUgdGhleSB1c2VkIHNvbWV3aGVyZSBlbHNlIGJlc2lkZXMg
YmVpbmcgcHJpbnRlZCBkdXJpbmcgZWFybHkgYm9vdD8NCg0KPiBObyBhZGRpdGlvbmFsIGVycm9y
IGNvZGUgaXMgbmVjZXNzYXJ5IHRvIGF2b2lkIGludHJvZHVjaW5nIG5vaXNlIGR1cmluZw0KPiB0
aGUgYm9vdHVwLg0KDQpQZXJoYXBzIGJldHRlciB0byBwcmludCBzb21lIGVycm9yIG1lc3NhZ2U/
DQoNCkdpdmVuIHRoaXMgcGF0Y2ggb25seSBwcmludHMgbW9kdWxlIHZlcnNpb24sIEkgdGhpbmsg
eW91IGNhbiBqdXN0IHJlbW92ZSB0aGlzDQpwYXJhZ3JhcGggKGFzIGl0IGlzIGEgZGV0YWlsIGNh
biBiZSBzZWVuIGluIHRoZSBwYXRjaCkuDQoNCj4gDQo+IENvLWRldmVsb3BlZC1ieTogRG9uZ2No
ZW5nIFlhbiA8ZG9uZ2NoZW5nLnlhbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERvbmdj
aGVuZyBZYW4gPGRvbmdjaGVuZy55YW5AaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBT
dW4gPHlpLnN1bkBpbnRlbC5jb20+DQoNCkl0J3MgYmV0dGVyIGlmIHlvdSBjYW4gbWFpbnRhaW4g
dGhlIGNvZGUgY2hhbmdlIGhpc3RvcnkgYW1vbmcgZGlmZmVyZW50IHZlcnNpb25zDQpzbyB0aGF0
IHBlb3BsZSBjYW4gc2VlIHdoYXQgY2hhbmdlcyBoYXZlIGJlZW4gZG9uZToNCg0KCTx5b3VyIFNv
Qj4NCgktLS0NCgljb2RlIGNoYW5nZSBoaXN0b3J5IA0KCS0tLQ0KCS4uLg0KDQpUaGUgImNvZGUg
Y2hhbmdlIGhpc3RvcnkiIHdpbGwgYmUgdGhyb3duIGF3YXkgd2hlbiB0aGUgcGF0Y2ggaXMgYXBw
bGllZC4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJj
aC94ODYvY29jby90ZHgvdGR4LmMNCj4gaW5kZXggM2U2ZGJkMjE5OWNmLi45OTFmN2RjNjk1YmQg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2
L2NvY28vdGR4L3RkeC5jDQo+IEBAIC0zNyw2ICszNywyNCBAQA0KPiAgDQo+ICAjZGVmaW5lIFRE
UkVQT1JUX1NVQlRZUEVfMAkwDQo+ICANCj4gKy8qDQo+ICsgKiBURFggbWV0YWRhdGEgYmFzZSBm
aWVsZCBpZCwgdXNlZCBieSBURENBTEwgVERHLlNZUy5SRA0KPiArICogU2VlIFREWCBBQkkgU3Bl
YyBzZWN0aW9uIDMuMy4yLjMgR2xvYmFsIE1ldGFkYXRhIEZpZWxkcw0KDQpJIGJlbGlldmUgSSB3
YXMgdG9sZCB3ZSBkb24ndCBuZWVkIHRvIG1lbnRpb24gdGhlIHNwZWNpZmljIHNlY3Rpb24gbnVt
YmVyICh3ZWxsDQphdCBsZWFzdCBpbiB0aGUgY2hhbmdlbG9nLCBjYW4ndCByZWNhbGwgd2hldGhl
ciBhcHBsaWVzIHRvIGNvbW1lbnQsIHRob3VnaCksDQpiZWNhdXNlIHRoZXkgY2FuIGJlIGNoYW5n
ZWQgKGVzcGVjaWFsbHkgZm9yIFREWCkuDQoNCj4gKyAqLw0KPiArI2RlZmluZSBURFhfU1lTX1ZF
TkRPUl9JRF9GSUQJCTB4MDgwMDAwMDIwMDAwMDAwMFVMTA0KPiArI2RlZmluZSBURFhfU1lTX01J
Tk9SX0ZJRAkJMHgwODAwMDAwMTAwMDAwMDAzVUxMDQo+ICsjZGVmaW5lIFREWF9TWVNfTUFKT1Jf
RklECQkweDA4MDAwMDAxMDAwMDAwMDRVTEwNCj4gKyNkZWZpbmUgVERYX1ZFTkRPUl9JTlRFTAkJ
MHg4MDg2DQo+ICsNCj4gKy8qDQo+ICsgKiBUaGUgZ2xvYmFsLXNjb3BlIG1ldGFkYXRhIGZpZWxk
IHZpYSBUREcuU1lTLlJEIFREQ0FMTA0KPiArICovDQo+ICtzdHJ1Y3QgdGRnX3N5c19pbmZvIHsN
Cj4gKwl1MzIgdmVuZG9yX2lkOw0KPiArCXUxNiBtYWpvcl92ZXJzaW9uOw0KPiArCXUxNiBtaW5v
cl92ZXJzaW9uOw0KPiArfTsNCj4gKw0KPiAgLyogQ2FsbGVkIGZyb20gX190ZHhfaHlwZXJjYWxs
KCkgZm9yIHVucmVjb3ZlcmFibGUgZmFpbHVyZSAqLw0KPiAgbm9pbnN0ciB2b2lkIF9fbm9yZXR1
cm4gX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCh2b2lkKQ0KPiAgew0KPiBAQCAtODAwLDYgKzgxOCw2
MCBAQCBzdGF0aWMgYm9vbCB0ZHhfZW5jX3N0YXR1c19jaGFuZ2VfZmluaXNoKHVuc2lnbmVkIGxv
bmcgdmFkZHIsIGludCBudW1wYWdlcywNCj4gIAlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0KPiAr
LyoNCj4gKyAqIFBhcnNlIHRoZSB0ZHggbW9kdWxlIHZlcnNpb24gaW5mbyBmcm9tIHRoZSBnbG9i
YWwtc2NvcGUgbWV0YWRhdGEgZmllbGRzLg0KPiArICoNCj4gKyAqIFJlZmVyIHRvIEludGVsIFRE
WCBBcHBsaWNhdGlvbiBCaW5hcnkgSW50ZXJmYWNlIChBQkkpIHNlY3Rpb24NCj4gKyAqICJUREcu
U1lTLlJEIi4NCg0KSSB0aGluayB5b3UgZG9uJ3QgbmVlZCB0byBtZW50aW9uIFRERy5TWVMuUkQg
aGVyZSwgYXMgeW91IHdpbGwgbWVudGlvbiBpdCBjb3VwbGUNCm9mIHRpbWVzIGxhdGVyIGluIHRo
ZSBmdW5jdGlvbiBhbnl3YXkuDQoNCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgdGRnX2dldF9zeXNp
bmZvKHN0cnVjdCB0ZGdfc3lzX2luZm8gKnRkX3N5cykNCj4gK3sNCj4gKwl1NjQgcmV0Ow0KPiAr
CXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gKwkJLnJkeCA9IFREWF9TWVNfVkVO
RE9SX0lEX0ZJRCwNCj4gKwl9Ow0KDQpQbGVhc2Uga2VlcCB0aGVzZSB2YXJpYWJsZXMgaW4gcmV2
ZXJzZSBjaHJpc3RtYXMgdHJlZSBzdHlsZS4NCg0KPiArDQo+ICsJaWYgKCF0ZF9zeXMpDQo+ICsJ
CXJldHVybjsNCg0KSWYgeW91IHByaW50IHRoZSBtb2R1bGUgaW5mbyBpbiB0aGlzIGZ1bmN0aW9u
IHJhdGhlciB0aGFuIGluIHRkeF9lYXJseV9pbml0KCksDQp5b3UgY2FuIGRlY2xhcmUgQHRkX3N5
cyBhcyBsb2NhbCB2YXJpYWJsZSBpbiB0aGlzIGZ1bmN0aW9uIGFuZCByZW1vdmUgdGhpcw0KY2hl
Y2suDQoNCllvdSBkb24ndCBldmVuIG5lZWQgJ3N0cnVjdCB0ZGdfc3lzX2luZm8nLCBidXQgaGF2
ZSAzIGxvY2FsIHZhcmlhYmxlcyBpbnN0ZWFkOg0KdmVuZG9yX2lkLCBtYWpvcl92ZXJzaW9uLCBt
aW5vcl92ZXJzaW9uLg0KDQpJbiBmYWN0LCBwZXJoYXBzIHlvdSBkb24ndCBldmVuIG5lZWQgdmVu
ZG9yX2lkLCBiZWNhdXNlIGl0IG11c3QgYmUgSW50ZWwsIGJ1dA0KcHJpbnRpbmcgaXQgd29uJ3Qg
aHVydCBJIHN1cHBvc2UuDQoNCj4gKw0KPiArCW1lbXNldCh0ZF9zeXMsIDAsIHNpemVvZihzdHJ1
Y3QgdGRnX3N5c19pbmZvKSk7DQoNClRoaXMgY2FuIGJlIHJlbW92ZWQgdG9vLiAgSWYgbmVlZGVk
LCBtYWpvcl92ZXJzaW9uIGFuZCBtaW5vcl92ZXJzaW9uIGNhbiBiZQ0KaW5pdGlhbGl6ZWQgd2hl
biB0aGV5IGFyZSBkZWNsYXJlZC4NCg0KPiArDQo+ICsJLyoNCj4gKwkgKiBURENBTEwgbGVhZiBU
RFhfU1lTX1JEDQo+ICsJICogSW5wdXQgRmllbGQgSWRlbnRpZmllciB2aWEgUkRYIGFuZCBnZXQg
dGhlIG91dHB1dCB2aWEgUjguDQo+ICsJICovDQoNCklmIHlvdSBuZWVkIHRvIHNheSAiSW5wdXQg
RmllbGQgSWRlbnRpZmllciB2aWEgUkRYIiwgdGhlbiBJIGd1ZXNzIGl0J3MgYmV0dGVyIHRvDQpl
eHBsaWNpdGx5IGluaXRpYWxpemUgYXJncy5yZHggaGVyZS4gIEl0IGlzIGV4cGxpY2l0bHkgaW5p
dGlhbGl6ZWQgYmVsb3cgZm9yDQptYWpvcl92ZXJzaW9uIGFuZCBtaW5vcl92ZXJzaW9uIGFueXdh
eS4NCg0KPiArCXJldCA9IF9fdGRjYWxsX3JldChURFhfU1lTX1JELCAmYXJncyk7DQo+ICsJLyoN
Cj4gKwkgKiBUaGUgVERDQUxMIFRERy5TWVMuUkQgb3JpZ2luYXRlcyBmcm9tIFREWCB2ZXJzaW9u
IDEuNS4NCj4gKwkgKiBUcmVhdCBURENBTExfSU5WQUxJRF9PUEVSQU5EIGVycm9yIGFzIFREWCB2
ZXJzaW9uIDEuMC4NCj4gKwkgKiBJZiBvdGhlciBlcnJvcnMgb2NjdXIsIHJldHVybiB3aXRoIHpl
cm8gdGRfc3lzLg0KPiArCSAqLw0KPiArCWlmIChURENBTExfUkVUVVJOX0NPREUocmV0KSA9PSBU
RENBTExfSU5WQUxJRF9PUEVSQU5EKQ0KPiArCQlnb3RvIHZlcnNpb25fMV8wOw0KPiArCWVsc2Ug
aWYgKHJldCkNCj4gKwkJcmV0dXJuOw0KDQpMb29rcyB5b3UgZG9uJ3QgbmVlZCB0aGUgJ2Vsc2Un
Lg0KDQpBbmQgYXMgTmlrb2xheSBtZW50aW9uZWQsIGl0J3MgYmV0dGVyIHRvIHByaW50IHNvbWUg
ZXJyb3IgbWVzc2FnZSBoZXJlIHRvIHNheQ0KdW5hYmxlIHRvIGdldCBtb2R1bGUgdmVyc2lvbi4g
IE1heWJlIGV2ZW4gV0FSTigpIGJlY2F1c2UgQUZBSUNUIGl0IGNhbiBvbmx5IGJlDQprZXJuZWwg
YnVnIG9yIFREWCBmaXJtd2FyZSBidWcuDQoNCj4gKw0KPiArCXRkX3N5cy0+dmVuZG9yX2lkID0g
KHUzMilhcmdzLnI4Ow0KPiArDQo+ICsJYXJncy5yZHggPSBURFhfU1lTX01BSk9SX0ZJRDsNCj4g
KwlfX3RkY2FsbF9yZXQoVERYX1NZU19SRCwgJmFyZ3MpOw0KPiArDQo+ICsJdGRfc3lzLT5tYWpv
cl92ZXJzaW9uID0gKHUxNilhcmdzLnI4Ow0KPiArDQo+ICsJYXJncy5yZHggPSBURFhfU1lTX01J
Tk9SX0ZJRDsNCj4gKwlfX3RkY2FsbF9yZXQoVERYX1NZU19SRCwgJmFyZ3MpOw0KPiArDQo+ICsJ
dGRfc3lzLT5taW5vcl92ZXJzaW9uID0gKHUxNilhcmdzLnI4Ow0KPiArDQo+ICsJcmV0dXJuOw0K
PiArDQo+ICsJLyogVERYIDEuMCBkb2VzIG5vdCBoYXZlIHRoZSBURENBTEwgVERHLlNZUy5SRCAq
Lw0KPiArdmVyc2lvbl8xXzA6DQo+ICsJdGRfc3lzLT52ZW5kb3JfaWQgPSBURFhfVkVORE9SX0lO
VEVMOw0KPiArCXRkX3N5cy0+bWFqb3JfdmVyc2lvbiA9IDE7DQo+ICsJdGRfc3lzLT5taW5vcl92
ZXJzaW9uID0gMDsNCg0KU28gdGhlIG1haW4gcmVhc29uIHRoYXQgSSB0aGluayB5b3UgY2FuIGp1
c3QgcHJpbnQgbW9kdWxlIHZlcnNpb24gaW4gdGhpcw0KZnVuY3Rpb24gaW5zdGVhZCBvZiB0ZHhf
ZWFybHlfaW5pdCgpIGlzIGJlY2F1c2UgSUlVQyB5b3UgYXJlIHNldHRpbmcgdXAgc29tZQ0KcmFu
ZG9tIHZhbHVlIGZvciBURFggbW9kdWxlIDEuMC4gIFByb2JhYmx5IGl0J3MgYmV0dGVyIHRvIGp1
c3QgcHJpbnQgaXQncyBtb2R1bGUNCjEuMCB3L28gbWVudGlvbmluZyBtYWpvci9taW5vci4NCg0K
PiArfQ0KPiArDQo+ICB2b2lkIF9faW5pdCB0ZHhfZWFybHlfaW5pdCh2b2lkKQ0KPiAgew0KPiAg
CXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gQEAgLTgwOCw2ICs4ODAsNyBAQCB2
b2lkIF9faW5pdCB0ZHhfZWFybHlfaW5pdCh2b2lkKQ0KPiAgCX07DQo+ICAJdTY0IGNjX21hc2s7
DQo+ICAJdTMyIGVheCwgc2lnWzNdOw0KPiArCXN0cnVjdCB0ZGdfc3lzX2luZm8gdGRfc3lzX2lu
Zm87DQo+ICANCj4gIAljcHVpZF9jb3VudChURFhfQ1BVSURfTEVBRl9JRCwgMCwgJmVheCwgJnNp
Z1swXSwgJnNpZ1syXSwgICZzaWdbMV0pOw0KPiAgDQo+IEBAIC04NjcsNSArOTQwLDkgQEAgdm9p
ZCBfX2luaXQgdGR4X2Vhcmx5X2luaXQodm9pZCkNCj4gIAkgKi8NCj4gIAl4ODZfY3B1aW5pdC5w
YXJhbGxlbF9icmluZ3VwID0gZmFsc2U7DQo+ICANCj4gLQlwcl9pbmZvKCJHdWVzdCBkZXRlY3Rl
ZFxuIik7DQo+ICsJdGRnX2dldF9zeXNpbmZvKCZ0ZF9zeXNfaW5mbyk7DQo+ICsNCj4gKwlwcl9p
bmZvKCJHdWVzdCBkZXRlY3RlZC4gVERYIHZlcnNpb246JXUuJXUgVmVuZG9ySUQ6ICV4XG4iLA0K
PiArCQl0ZF9zeXNfaW5mby5tYWpvcl92ZXJzaW9uLCB0ZF9zeXNfaW5mby5taW5vcl92ZXJzaW9u
LA0KPiArCQl0ZF9zeXNfaW5mby52ZW5kb3JfaWQpOw0KPiAgfQ0KDQpBcyByZXBsaWVkIGFib3Zl
LCBJIHRoaW5rIHlvdSBjYW4gcHJpbnQgbW9kdWxlIGluZm8gaW4gdGRnX2dldF9zeXNpbmZvKCku
DQoNCklmIHlvdSBkbyBzbywgcGVyaGFwcyB0byByZW5hbWUgdGhlIGZ1bmN0aW9uIHRvIHNvbWV0
aGluZyBsaWtlDQpkZXRlY3RfdGR4X3ZlcnNpb24oKS4NCg0KWW91IGNhbiBlaXRoZXIgc3RpbGwg
a2VlcA0KDQoJcHJfaW5mbygiR3Vlc3QgZGV0ZWN0ZWRcbiIpOw0KDQpoZXJlLCBvciByZW1vdmUg
aXQgYnV0IGVtYmVkIGl0IHRvIHRoZSBtZXNzYWdlIHdoZW4geW91IHByaW50IG1vZHVsZSB2ZXJz
aW9uLg0KDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHgu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaA0KPiBpbmRleCBmNzQ2OTVkZWEy
MTcuLmQzMjY1MDk4MzJlNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hh
cmVkL3RkeC5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaA0KPiBA
QCAtMTcsNiArMTcsNyBAQA0KPiAgI2RlZmluZSBUREdfTVJfUkVQT1JUCQkJNA0KPiAgI2RlZmlu
ZSBUREdfTUVNX1BBR0VfQUNDRVBUCQk2DQo+ICAjZGVmaW5lIFRER19WTV9XUgkJCTgNCj4gKyNk
ZWZpbmUgVERYX1NZU19SRAkJCTExDQoNClRER19TWVNfUkQsIHBsZWFzZS4NCg==
