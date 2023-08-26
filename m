Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531157893E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 07:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjHZFAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 01:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHZE7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:59:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522491BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693025986; x=1724561986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AtYTgN/93K8mlTqgagQpB+5fFgSl2TZCnO4BqMEpJHI=;
  b=TNBxA4wgK7zIyG4p+aG3CuIWTyjQoHDNoFq1cLg1NKrSsghe2nUHEW0l
   vsHKX6pxiLkrFFovhbMVszYQvxa8+Ixpbb75gp4LUxDXfJ81GvI9tP5ko
   tcgTf7CZ9UUBtk2G1sl48i7sq9pPRsJ0Ewh8Fnv7t6naSDhIKei4Z77c9
   /SScXJSo5NYRsHrGrC0ZlN/B7jUbvpHvHOZtUql6iScUWUDPvXv6XeBb1
   VOkfBvnR5pt+na/LD3QwTIl9nOqsTQDZyxrkriaTOiVxNoLiE5naMEfLY
   X9J1ZjUhMucI1lVSMvabDJI2WZIKZDVr4KeWjfYq9oSq9axg0xcDVlzQa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="441195637"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="441195637"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 21:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068446745"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="1068446745"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 21:59:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 21:59:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 21:59:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 21:59:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 21:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp5SK/y+hORm56SUjFGCpORPwiRRoidSt5YAC/aOc0G7fyaAKW9VdqIAa2bnwlqO0XgnRwSc8kUmEBV6fMufwLh9LpjiznjpdnlxxFHMSCtcaPjrNKh3KgXoPG5Ol9xJKSlIDtl7/ZWlRDeL3ILrSFdCxjfbta9F+3WsR0JAgVtSOfHGinDxOoy5R5jkI8lalKELFOvISmUGPLauMtkWHJ/symeh5gl19UsE0uUC4s27CNhZM1u0Adag+YuEy5k02e1Fjc0pFhK3xrrmP5meE4lO7KkxMh6+9YsN8HL8PRpSjcGdwpzgq0MWXuXT+w1yjdb4ps0z8xiTbkErG0QiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtYTgN/93K8mlTqgagQpB+5fFgSl2TZCnO4BqMEpJHI=;
 b=leYjR7HQh8Qxq+BfuctfuYxA7yYsWuJ+/FyQgU+T4tv+B2L06R13g6pzGwGliZuAW1hCKr3Izsb/9SepTibBmGhGkRUT7T4LrgxL5R2ix9lqu+/ylcs3FlGRUOaLi6bhc4LCcKYWNzM+y2FmSfa3dZ3UHSCg4NqNgOskFPUFApID59TXaSUVHfpCSPo4DdQCzzLR8idNOPT0Yk9E/C2/e4q9JeiiD9BY+RlfSAS2hZYXp8V/z/z7seQjaJbfl8vt5IWB1J4O3oQ+9LsfnMyRektDX5yYPb1DciiOF6BYjMRYYnk/QCdonM+eEklmYFKAScYADl/PBjmvdP35UiEWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 04:59:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 04:59:34 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZz2d7UQsEDFsUOEaymlW0GXBdza/7uv0AgAAUuQCAAEWtgA==
Date:   Sat, 26 Aug 2023 04:59:33 +0000
Message-ID: <8edee3c83760b5662911d40d106ecee54431e9aa.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
         <20230825233558.xzqukr3vbccii7f4@box>
         <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
In-Reply-To: <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5322:EE_
x-ms-office365-filtering-correlation-id: 5c401e19-cb36-4748-cd8e-08dba5f13d6e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAj5hWkJnWPMGFdVVTTfBBHeZY0yRZUHVvbBlkO8DVHp/YfVhFWZdvofsOIssGIf1otAdNrvcqGHuIYlLWTHc2/edW7FpvanswY6cx0xhxIEz2Rn9XN5YQNjdAbWJ0Lc1ZoD6AxiAdmHlpAlkv72xrmhyQOC7iRF8yC3mME7z3XrbOhx1HLgeIgXZm0X5kxd76ouZBzUKV1/dHLq1+kjAUpMaac4wPnzTzuGE0imXWY2CnEj3i9ByCSkq2+t5CFgJzE9teEiUc4TaBP1EopxErBDZfBYCo60r31jtyfG+s77B0U6K10mFag2/MQpzOqEtuaqCGdx/JMJ2c7UbSHSOeMRoDEI9yH+8m1YoKFIttY2y2ebpErcgf9WJzGdeoiC+vdajOnsqIZpfExhFqjRyG8rEr8hrevZtw645gYyZdnPE940uOk8VVaM9LzbRgmT7L/jFmJYImVFbZMJp8oQ9glht9nU0WidXjXrLTT5zp6Shvj/cgwG6ZDKzqbvkCPU8i5GN27BY3aRnCrCOhK+fW8vmXNJ1hYOebGbL4xkicKTlntS5Px4cq9PYyPTC7ntAKs8kF3kI/aMOWgokfypYJ3zbtCMu6gbwiSEYrbMmsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(1800799009)(186009)(451199024)(2616005)(5660300002)(8676002)(4326008)(8936002)(36756003)(83380400001)(7416002)(26005)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(6916009)(66946007)(66476007)(64756008)(66446008)(6506007)(54906003)(66556008)(316002)(76116006)(91956017)(478600001)(966005)(41300700001)(6486002)(2906002)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0k5bTBzM3dIa2FNV3c1LzI1N0dOU0Q4Q0xIY21sQXhxMmwxcUVFWkcyRzFL?=
 =?utf-8?B?aWNNUkplM1lyT3IxaDdGcDVOWWFMWUtsbW1pbjdTNUZ3SXkwNXlOU3RqVXpG?=
 =?utf-8?B?OVplU2tab2JIMkR0TENLNTliQkV4YmxQam0wRnI1ZUtLUDN2SlQ2MWdMWk5H?=
 =?utf-8?B?dHJUdjUyL0xxbUlUQzFRTnNkbGNuMEhnOWFDWERNbEk4QTNqY0k2SkNvTlRr?=
 =?utf-8?B?VkVsOGFoRlhiSTg4OW5xMnFFQ3EwQ1JkbTRkR3k0QXBRTmNtZHV0RVZuZklR?=
 =?utf-8?B?L0xlSEZhODJnSFN2ek45M3RSQTJxZ3JOUDRBd3RQcys4QUg5REs0cFpGVEpr?=
 =?utf-8?B?TFZrS1RNNDIwbnk0RHhCR25JNUxBdXduRmwvYWhaRDFPMFg3cjMvOU1hbUVI?=
 =?utf-8?B?dFlwNkREejV2Z3RVU2VwdmRpRjhtYmI1ZlpEUWJQT3NCNDFtRmZDSldHbnpO?=
 =?utf-8?B?RXpxTWtLb24rU056Z1ljb0VVaUNwY3Znb2owNzA3T0s5eVZtOVpDTFRMQ29v?=
 =?utf-8?B?eTgwd2c3OTN4b1RVMWdmNElMRlBBRktmb0gxd1JTR2IvMzRZUVE4cGwxa1dK?=
 =?utf-8?B?bC9aalE0YjVvSjR0TUZiZVVnaFY2MWVXTzM3eGprc2RFcklvZzRYUXNEVHY3?=
 =?utf-8?B?Y21WZ0xaMXZpcVdCUUpGcnBESUh0bkcvbDZZekVqNk5QUjNJZ1EzcU9maWN4?=
 =?utf-8?B?bkRZL3RDT0NtbldxVTVBZ1krL2xtYkNXRlB1Z3F2di9kTXNlODZFNks2MURr?=
 =?utf-8?B?MDdacWV1STBQWDd4RGFXd1dUUGZCNmdsaFdyMFZuY0g1aDFCcUdCMEM1QjMw?=
 =?utf-8?B?QTJnbG1CdTZ2eXIwbStFbWJLbnl1QW5PcXI1V0dVRlIzOStWZDc3SFZXektK?=
 =?utf-8?B?ZDhKYXRmaHJ0b0M4MmhTbHNsME5kbkhNUHJyRkNCTFI3MXp1RE9Ma0tMSTdK?=
 =?utf-8?B?b3VWbmpNZGtiWUVibEg1d0xnSDdzWlRrRFFmQnpiVElSZ1pldEd4RlNuRVlm?=
 =?utf-8?B?TEVjcEJBckMrTEdmWGdIMFFYS2dtM0hSYmYwdzY1TE5EeXpuY1RnZWhhaDI5?=
 =?utf-8?B?d0grT0JxSFNEVXBtRHFBN2o0bXF1d2pFWlBRaTZRUG1IN1BVM1B1ekRpK3hC?=
 =?utf-8?B?Yk5ENmtxSXRRNzZvS01PT3BreDRONWpyZHArMDRFZXJJWHlBZXcyellsUUho?=
 =?utf-8?B?ODlqeUsvcWlvSENxR1YrajJ5RUZ6OUdxWmRGVzhXdHZTZTVWamlZMUE0K1ND?=
 =?utf-8?B?OTY2dkVlNzE1WDlWY0d0ZDF0TCtJR1QyZ3JLUW9xRnhWT0YvSHBtNTVUakJM?=
 =?utf-8?B?OW1CT0RDUmg0YWFwNkdHd2RPbDZxM3JxUnB4NHNQY00vZkgzQnEwRjd2bWJ4?=
 =?utf-8?B?YzhWTTRCcSsxZU1kL3pUQ0JqQnU3OXI5RlpBWlExNnVwMHN1OWo5S3BZV2k1?=
 =?utf-8?B?SWl3NGF0ZXBja2ZVY2Vod0RaaUk3cUZhVVRxdVFydWJVTUZ1MHVhcGthY2VJ?=
 =?utf-8?B?VTgzUDdtWHNtbnJ1SGpvMjE0dTVkbjJDUUlHTTJTQ2JVZjJpcWIvQ2Ivczhn?=
 =?utf-8?B?UUZJZ2hoc2llNG1KekFkbXJrSkZtbVRHWTdGSHl4MWJtZmpEWHAxS3N4NS9B?=
 =?utf-8?B?RGVCUlR6dlNVTnlsY0dHUisyZXRRTUtsU2svK1lTUXFJMDRlUmcxYjhWMU5S?=
 =?utf-8?B?SzNZbTEzS3orbE5VdldwZDNNb3FpVGFpVm5LaXNJdHJMNDhOLzk5TFdRU0Ji?=
 =?utf-8?B?QmNhRjJqdnI3MjNDNUo2QXBUQlB5bldTMktrdmp1QTI0MEsyTFJ4WFd6YjdF?=
 =?utf-8?B?VC9pR0RoRy9TNFoxL1VvMGtta05RSzc4UHRjeWcyZzQ3UlhVeW9XKzd5Z2hM?=
 =?utf-8?B?c2xkc3VzVC9HbnVYRXhZbS9hWDljQ3ZUY2RLZDBIU3BMUXh2U24yUnFYSDJP?=
 =?utf-8?B?VU5zUldodms3ZGlIaXRkVHpXam0vdjkzd2VHMmIzRXJaUTVQWVMyVkI2NC91?=
 =?utf-8?B?R2szL1QzZVdJVGVtVjZGZzVsNGtYaUVVVmhHQ1ZCV0dZQmdWL0pkSHVhWWlP?=
 =?utf-8?B?WDFseW9IQXN4c0RZWGdxS1Vrdnd0cW8vZC9YYXFlV0lINWkxNnBDeWVHdk5D?=
 =?utf-8?Q?XNwCBvaU+em5Ad/tN/O6kVNG5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02F3019520EC6B47B453DF4EE42028D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c401e19-cb36-4748-cd8e-08dba5f13d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 04:59:33.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usR5vrGu/vsVxPwpagaFHsGmAfnO4G8eKqIZNbLH9B+nSuF2Oqqa5q2JnFi4s8f0shqeXdfnggATUgUSE/7CkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTI2IGF0IDAwOjUwICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBTYXQsIDIwMjMtMDgtMjYgYXQgMDI6MzUgKzAzMDAsIGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5p
bnRlbC5jb20gd3JvdGU6DQo+ID4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgMTE6MDI6MDFQTSAr
MTIwMCwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBGYWlsdXJlIG9m
IF9fdGRjYWxsX2h5cGVyY2FsbCgpIGluZGljYXRlcyBhIGZhaWx1cmUgb2YgdGhlIFREVk1DQUxM
DQo+ID4gPiArCSAqIG1lY2hhbmlzbSBpdHNlbGYgYW5kIHRoYXQgc29tZXRoaW5nIGhhcyBnb25l
IGhvcnJpYmx5IHdyb25nIHdpdGgNCj4gPiA+ICsJICogdGhlIFREWCBtb2R1bGUuICBfX3RkeF9o
eXBlcmNhbGxfZmFpbGVkKCkgbmV2ZXIgcmV0dXJucy4NCj4gPiA+ICsJICovDQo+ID4gPiArCWlm
IChfX3RkY2FsbF9oeXBlcmNhbGwoVERHX1ZQX1ZNQ0FMTCwgJm1hcmdzKSkNCj4gPiA+ICsJCV9f
dGR4X2h5cGVyY2FsbF9mYWlsZWQoKTsNCj4gPiANCj4gPiBEbyB3ZSBldmVuIG5lZWQgX190ZHhf
aHlwZXJjYWxsX2ZhaWxlZCgpIGFueW1vcmU/IEp1c3QgY2FsbCBwYW5pYygpDQo+ID4gZGlyZWN0
bHksIG5vPw0KPiA+IA0KPiANCj4gX190ZHhfaHlwZXJjYWxsKCkgaXMgY3VycmVudGx5IGFubm90
YXRlZCB3aXRoICdub2luc3RyJyAod2hpY2ggaXMgYWxzbyB0aGUNCj4gYmVoYXZpb3VyIG9mIHRo
ZSBvbGQgY29kZSkuICBXZSBuZWVkIGl0IG90aGVyd2lzZSB3ZSB3aWxsIGdldCBidWlsZCB3YXJu
aW5nIGxpa2UNCj4gYmVsb3c6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2Ey
M2NlOGZkMjg5MTQxY2VhM2ExYjRmM2RhY2UyMjFkY2E4NDcyMzguY2FtZWxAaW50ZWwuY29tL1Qv
I20yMDViMjljZTNlMzM5ODNlYzZiZTczM2MyYWZmZmJmZDVjYjY1M2ZmDQoNCkZvcmdvdCB0byBz
YXksIF9fdGR4X2h5cGVyY2FsbCgpIGlzIGEgY29tbW9uIGNvZGUgc2hhcmVkIGJ5IHRoZSBjb21w
cmVzc2VkIGNvZGUsDQp3aGljaCBhbHNvIGhhcyBpdCdzIG93biB2ZXJzaW9uIG9mIF9fdGR4X2h5
cGVyY2FsbF9mYWlsZWQoKS4gIFdlIG5lZWQgc3VjaA0Kd3JhcHBlciBhbnl3YXkgYmVjYXVzZSBj
b21wcmVzc2VkIGNvZGUgY2FsbHMgZXJyb3IoKSB3aGlsZSB0aGUgbWFpbiBrZXJuZWwgY2FsbHMN
CnBhbmljKCkuDQo=
