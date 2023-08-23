Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B63786374
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbjHWWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbjHWWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:36:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3D10EB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692830202; x=1724366202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+ENSygxlGLvsI+IB7JMEnxL8K3y21+Dwp0oPDvxqeQ=;
  b=K45CqdTVIpCCVdvgt/7wZHYpUpc4lUs7y95x5nF9GSO4FsGIIkdOFK9b
   /3ICjrvZXEpizAUHHrlRnXNkltkji/3MhCL8TfSLzWDHsDVUCCabnIVlS
   gsGbhZ1geX3VWhbIl6ISacBtPORkhfQ7lZKSO0UY+2Cpk9R8HcsitB7z1
   iHXsoHMPJtMuHsqdu00AzDuclu8E4XfyQ6i2M4mOhrUN/HRQOvpWCe6uV
   /k+RtTNgigYILitsueWxSFJ0oyw1sppHDdFQ32U/wOwSDSRNZz8yMopAX
   QLGfRNY+XSwV9esXO1zfBP67E0bABQ5udTDBYHiCWbiYwlDEuLatfs3R8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378041779"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378041779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860477742"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860477742"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2023 15:36:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:36:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:36:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 15:36:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 15:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC9nZ5Y5nPIgoEzg9EXk4zL1qvehg5YOvStd1blQ75Z7flxgElfCc2Q1DmZKxiCFF5OMz0U/LMOfWC6wnBqG1ubI7VgQepdGqLo5ry4sIAVZ2oIST1hyixTaprdh49jjR75rDyDq8CCfdgtdsSt7R7c/8fP//VIG2oJ52DcJDNQB58Y+djQtxOSz8lZHsBw4OaVRLwVltjpzlfnP4n9o0fj9RjvbkAYshXsGzeG5wVYw42DgS3jcLe5Fpw+75hpbA9Q8ZnEzwnCAu0cv5D4DegAYLdcoJrnK9aNQizkxeQcmPRPjtceWqBoGfKnxJ9U9w50BEIMceLAfLmIl43XNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+ENSygxlGLvsI+IB7JMEnxL8K3y21+Dwp0oPDvxqeQ=;
 b=MN6vDTBY9vBHqM1gt9TQpe7SyhRAvfzyrgJvcXt+SfpAcNasNEpxi7OeeyV8EzVlK/O7ikwESR16VmmuKENqXBRQCL8OGgyUFPl8Lf3fZ8SgqTDte3CUDvvnXqNfyeJx6FpGLHLUNmiU9Oj+ZftukPlLodX+8hvwn4iBFnat5JFdaS3Y+B+Nb7+tshNq9yMI679FFjfvA+lJKB4Rl6meNfpn7CYOElKXJd83TSE3hOhN9uUsHuogMAHb584e0E1TlDoGmbLvB8suK4u6gxeigCiIojZFWZ7fiIEqDNj9cZsyFmGebgbgf1TAW9k8WJVRwsM4UTRUrBbPgk9Am1Thrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 22:36:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087%3]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 22:36:38 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Topic: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Index: AQHZ0T6XikHFu8Y0uEe4Hq2FndRcXq/2Si6AgAH9QACAACj2AIAADSIAgAACtoA=
Date:   Wed, 23 Aug 2023 22:36:38 +0000
Message-ID: <SJ1PR11MB608365E9966D30A96B9C9B3DFC1CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
In-Reply-To: <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4736:EE_
x-ms-office365-filtering-correlation-id: d51c3d65-cef1-4705-8c5b-08dba42969ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aq2kAYqP69pGWBtAMoXYHSr/gUZ9vJjInNw+cEEW/57QBghQqV3sQXhjLFa1BGE1oDfdE9xqSEFU+2yxRPsew8LevcN+w5q0UeDMEZuBpSBBy41u59lqdVvv9luqoMxOcG4YcrnqtFEuYRY/3rvoZd6EqsY743d4MSl3Sm/L2itvENpykUDBb89YGerTVjBsj7EGyL5W8XWq2r1AlGV0IKKsPW9+uoIJxqzBzcXFBk0kyunZZ5EY256tsoSjmH16M8WUIqeMCBWQYdj716MqzhAX2WBnGKyvlL9hr1uF+rSLgJaAUfBMo+lXvVEqZUqLMNNBF7XM2rUbENxT1lOuZYmFJCzo34o64K1cZU5rKL4GyUeMYyB1wf1lJ2ZyFjY3Kio8Ofwjlu6Dsn9lBU+m7SvgtT3P4pWEICTNsuKIC57xrjWkUiPg7pOL5UupDr/N0cVTLcFF4TO1dTdf/93E1plYGHEU1/Hymb30zBBOQ6pGBLuzvfRXEySqfkFrY5y/K7qsVsUABQ4Nn2EIlGHbwqLX84Vc4Db2ECo+iEfvbrFgwRdnm+QP38UvVa7lC3EWVh8Dt+dNeZ4tOnyBLDctaHq+Qp9i1ZPEOzyCwnzKrVoa1dSo3PVhDjcu0INOXFhd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(186009)(451199024)(1800799009)(71200400001)(86362001)(33656002)(478600001)(55016003)(52536014)(8936002)(8676002)(82960400001)(26005)(2906002)(4326008)(38100700002)(83380400001)(38070700005)(9686003)(5660300002)(122000001)(66476007)(110136005)(66446008)(316002)(76116006)(6506007)(66946007)(54906003)(66556008)(41300700001)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkpxTHo5cnpkTjJQWUllN2pzRkRnNXNsKzZ2ZGhzZFdsUGEvam9RT0pOL0Qw?=
 =?utf-8?B?WWVKdWhCQ2ZyTHJ0T09CbHoyUEJwc2NwamFIMG8zWnEyVkFqNUtmTFZMb05x?=
 =?utf-8?B?VzdWdnBnaGE0bkdWb2FWZ1AxQ2QyQjY4bldpSDcxaG9FMjhKbDRvL1pHdlA2?=
 =?utf-8?B?K2gyQnE0UTJwZnFXL1lkWkdpaEtiL0s2b0dNZHhSWDVhUUs2WGVaNnNvbU5S?=
 =?utf-8?B?cXBSY0tLcUtsRWRHN2E0L3BRVzdjVGRIajdhWXp0dXZ2RHNDa3Fzd240UFkx?=
 =?utf-8?B?SFJ1RXQzUGVIWloyYWF3cEt1dnNyalBGVGcyWFE1M1h6MmhQeVRZQmR0akQ0?=
 =?utf-8?B?NEg1d1BheVZYRVJsUnE4NEp0UVFzeDRRcmJUMm5ZOCtrakZEVGtyUFhqMTVq?=
 =?utf-8?B?UzFKd21Oc1BxQm5Ua3hlcWcrbXUzcjBYZ0srL3E5N2t3aDZESFZLbWFTb1VY?=
 =?utf-8?B?U2s3dm9WSXVTNlA2Q05PS1UvMVQzRzRqSWRwS1RrbCtjTTJLL0lzaEl4dk5S?=
 =?utf-8?B?clp6dVkwc1Iza3ZNT2FscFg1QXJUNTZCcXBURlNaK2RwemQ0Wk5tV2hmMVc1?=
 =?utf-8?B?RVBZS2l5bVd0TWk5RHB1QWRmWGl4Z1B6RUg1aFdRY2hqZXU2TkRoTFY5cDdw?=
 =?utf-8?B?Z09mT0dOVG1vdjJxZ1pGbDlRRkcyRXpnbTc5MTlmbzFwRDhBbjhna0lKN2Jp?=
 =?utf-8?B?YXlia3NkYUpveXE4SWdCYmU2cWdWWGpIVmlVRzhPRENBTTg4RTRXMUNnYjNz?=
 =?utf-8?B?WnlFay91ZkJFZFl6d25Wc1hGOXZLKzBONEVRdFZ5dHNPUFg3cyt3YTkzaStL?=
 =?utf-8?B?RDZiOXZjS2VLT1FqaXZqdlBqc0NRRGFJZXB0U1VLU2RHR2M2ekVld0lBdlNG?=
 =?utf-8?B?azRjWjl2MTJWSi9UTjJ6UFNZWDF3WWl4NkdmMmdoZHZoek01MU9iamM5amtV?=
 =?utf-8?B?QVRZcHllY094RW14ZkFsdWtSUWM2UnYvU2JkdjJaRFFXcVZNUEJBdHZNTkto?=
 =?utf-8?B?ZmVDdVNMZ0I3UFRrdDQzYzJxWThGUlV1eHJCUnBmSGZGbW4wemJVR2hBM3h4?=
 =?utf-8?B?K04vcE1uMFFVdzdRMWpqUm4wUWk0OWJ4ZmNVTXJVNW5zSzJuT1RuTSs3NU9J?=
 =?utf-8?B?Y1VZelF0YmdrOG1vOTdqTkc1SjVpbkcvYmpVZmJDbEpFMWNwamVEMHFtaXBL?=
 =?utf-8?B?aUdKdEhCZVlvZGZFa3pFcjdCWmttdVBiejdOV2VCTDFDSVEwWWZTTUQxejFV?=
 =?utf-8?B?NWlaK3Yra3pFa21WT0IrbnF5V0Vrb2lBOXcralRyQThBUGhGK2IzMHY2aHJ3?=
 =?utf-8?B?QTVPZlJQR2JCeFUyeXlLTzl5T1R6Z3NuS2l3RHYwQU1nVU1XVjdjWlJ0MWhG?=
 =?utf-8?B?NUZBNVBnN0g0aUxlTHJaQ1dyeTRvay9ETFY1aGhTWmxXVFh6dTBIZ2RPaktz?=
 =?utf-8?B?WERaeU9Wc0lhL3FzS3ArYkV3SFYxZUhSRDVRU3RaTC9IQlRLb1BvWFYrT0lI?=
 =?utf-8?B?TnBLbCtTR0grek40ZWVoWjAraEFBTG1rU2YzemRyT2h2TU54cXZEKytjV091?=
 =?utf-8?B?SnJTSWgyOEIvQ2xLV0ZRMUR6NitGb2dlV2lIWmdqS0N0bVcraHAzS09aOFVG?=
 =?utf-8?B?SGpENS9pQWV0dFFJbWJYcG9RV3FJM01UdkVXRWZKQmI2bkxPYXp6eHdxR2c1?=
 =?utf-8?B?b0JWQmtFdVFreTMyMXQ5UnMxNTh0cDJIVDF2d1JwNTY4ZlBGclovZ2dVanVn?=
 =?utf-8?B?eDhWTnU2UUNGRGpETjNidjlHRHd0S3grNEFmMnVzRXZyRVFxMEZBbGFnUy9U?=
 =?utf-8?B?UGlxSDZRNVJ1UVlZYnFBNklPbmZPUUZnYlBhcjl0c0xvZE9wVlIvdXhsT1BQ?=
 =?utf-8?B?ZDYvLzJqN2phNXUrRUY5REZncW5US3JmY21ScTlicWxpVnNTWmVOOXhwL1VP?=
 =?utf-8?B?WHk1VTgyVXNvWUVTQ3hOMXcxb3hKWDBVVWYvSXE5ZTFQYlFha04waUlqY0RP?=
 =?utf-8?B?TnU5d2JqN1BhN0E3bjNyNTBNQlBDRmlCWXB6V2lzN2Rnc1ZIRmhYd0dLbzhL?=
 =?utf-8?B?RGgxM3dWUXZlQU5VTEEyaE1aamR2SWJMY2N5RXk3cWR6a2tyZUl6em9zbHcy?=
 =?utf-8?Q?Iwqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51c3d65-cef1-4705-8c5b-08dba42969ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 22:36:38.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5tMW2oLAhzZdX2NU0Z5beqIr7YRpoJtqUXUK+QBeApwQhCdj/NE78mhH6JNUwnRoYkktqzsasHBpggUCdcjow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

PiBJIHNlZS4gSSBkbyBoYXZlIGEgc2ltaWxhciBjb25jZXJuIGFzIFBldGVyIHJlZ2FyZGluZyB0
aGUgaW1wYWN0IG9mDQo+IHRoaXMgY2hhbmdlIG9uIHBhcnNpbmcgb2YgdGhlIHNjaGVtYXRhIGZp
bGUuIEkgcGVla2VkIGF0IGludGVsLWNtdC1jYXQncw0KPiBpbXBsZW1lbnRhdGlvbiBbMV0gYW5k
IGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0bHkgdGhlc2UgY2hhbmdlcyB3aWxsDQo+IGJyZWFr
IGl0LiBUaGlzIGlzIGp1c3Qgb25lIGV4YW1wbGUgYnV0IEkgZG8gdGhpbmsgdGhpcyB3aWxsIGhh
dmUNCj4gc2lnbmlmaWNhbnQgaW1wYWN0IG9uIHVzZXIgc3BhY2UgdGhhdCBzaG91bGQgYmUgYXZv
aWRlZC4NCj4NCj4gQXBhcnQgZnJvbSB0aGlzIHRoaXMgZGlzY3Vzc2lvbiBmb2N1c2VkIG9uIHRo
ZSBkaXNwbGF5IG9mIHByb3BlcnRpZXMgd2hlbg0KPiB1c2VyIHZpZXdzIHRoZSBzY2hlbWF0YSBm
aWxlLiBXZSBhbHNvIG5lZWQgdG8gY29uc2lkZXINCj4gaG93IHRoZSB1c2VyIHdpbGwgcHJvdmlk
ZSBuZXcgZGF0YSBieSB3cml0aW5nIHRvIHRoZSBzY2hlbWF0YSBmaWxlLg0KPiBGb3IgZXhhbXBs
ZSwgSSBkbyBub3QgdGhpbmsgaXQgaXMgY29udmVuaWVudCBmb3IgdGhlIHVzZXIgdG8NCj4gaGF2
ZSB0byBwcm92aWRlIHRoZSBhbGxvY2F0aW9uIGJpdG1hc2sgZXZlcnkgdGltZSB0aGUNCj4gIlBy
aW9yaXR5IHBhcnRpdGlvbmluZyIgdmFsdWUgbmVlZHMgdG8gYmUgY2hhbmdlZCBmb3IgYSByZXNv
dXJjZQ0KPiBpbnN0YW5jZS4gVGhpcyBtYXkgYWxzbyBiZSBzb2x2ZWQgd2hlbiBjb25zaWRlcmlu
ZyBQZXRlcidzIGlkZWEgYnV0DQo+IHNpbmNlIHRoaXMgd29yayBkZXBlbmRzIG9uIG90aGVyIHdv
cmsgdGhhdCBpcyBub3QgdXBzdHJlYW0gaXQNCj4gaXMgZGlmZmljdWx0IHRvIGVudmlzaW9uIHRo
ZSBpbXBhY3Qgb2YgYW55IHN1Z2dlc3Rpb25zLg0KDQpXb3VsZCBpZiBiZSBiZXR0ZXIgdG8gYWRk
IGFkZGl0aW9uYWwgZmlsZXM/IEUuZy4ga2VlcCB0aGUgc3ludGF4IG9mDQp0aGUgc2NoZW1hdGEg
ZmlsZSB0aGUgc2FtZS4gSnVzdCBzcGVjaWZ5aW5nIHRoZSBjYWNoZSBhbGxvY2F0aW9uDQpiaXRt
YXNrIGZvciBlYWNoIGNhY2hlIGluc3RhbmNlLg0KDQpUaGVuIGhhdmUgYSBzZXBhcmF0ZSBmaWxl
IChvciBmaWxlcykgZm9yIHRoZXNlIGFkZGl0aW9uYWwgYXR0cmlidXRlcw0KbGlrZSBQUEFSVCBh
bmQgQ0NBUC4NCg0KSG93IGFyZSB0aGVzZSBsaWtlbHkgdG8gYmUgdXNlZCBpbiBwcmFjdGljZT8g
V291bGQgYSB1c2VyIG5lZWQgdG8NCnVwZGF0ZSBhbGwgb2YgdGhlc2UgYXQgb25jZSAoaW4gd2hp
Y2ggY2FzZSBzZXBhcmF0ZSBmaWxlcyB3b3VsZCBiZQ0KaW5jb252ZW5pZW50KS4gT3IgaXMgaXMg
bGlrZWx5IHRoYXQgdXBkYXRlcyB0byBtYXNrLCBQUEFSVCwgQ0NBUA0KYXJlIG9ydGhvZ29uYWws
IGFuZCBzbyB1cGRhdGVzIGFyZSBub3QgdXN1YWxseSBkb25lIHRvZ2V0aGVyPw0KDQotVG9ueQ0K
