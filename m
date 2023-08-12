Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674B779DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 08:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHLGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 02:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 02:41:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9E211B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691822514; x=1723358514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GJh6xwGm3OLiY7/VTmBBzrvvgjJao2EgpTdWj0aU0bg=;
  b=ntTa+EVMa9CPgziFgKDOnPg909kh57ahBn7z6uvmddixzdlT95YtrauH
   f+4f+bCkxzlpi3oaNfhQSXU4dAQCwkKeGsnU2wJhCdChEMlodiUJCEdhx
   i5O0XI8soDFChyLU49KwkSqw8gYmZ27mwjbl1itQSfr/QuYzmECOFiQUy
   ekiuev57tNx2hkMJQG88NOEcW6Xhv8O5ja8X/0bsY3/lYSxCvv6buUjPM
   09YYPx/gbwdcmh1QVqxbdzUT7dg92fHlxSGUmFSV0uao9hIn7+gQ1QXPj
   D4Y2IFv9fEE/QV3MOecAs0jzkdjIzPL+JV7VDRd54UfyMKh/587aiHqu/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371813878"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="371813878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 23:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="847007582"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="847007582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2023 23:41:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 23:41:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 23:41:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 23:41:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 23:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfBc946ansQSZ582xgVpZqjYd491ncAnVOzF+bJcnUAUHg7Sz7gTTRtM1ygjSGtR7rOmUNQL3tJV57Xl8CyBOYNYO+U8I62++qJeCkEqGRTDUlNMb2XUOzgXRGfBOOpanMe4IZ8QBPNRnlXrmwNsVigLBUmwvAXdYzymITCZqTe5yRSq96NP7XCb6Evj65Orumg1rUwYBxcmqadiDncx/7UBFuVw9oAvLYL+PKyiEtkMxE+CZMF2zoY5jc/Kb8R2ADWk5P4AuIYM4CsBRyXn7onk7arxmINFreuFOWsI/9ULkPb3MkwesdrrPlnB91Uf21yoFJwH8rWGN5oF4wU38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJh6xwGm3OLiY7/VTmBBzrvvgjJao2EgpTdWj0aU0bg=;
 b=TUKsXt3H9cSIyLCoUMxD8w9dbyWMvdXKf6foZcJGlK3JGHQVj3f7FXyI1jjrg+6jTOfJrfrpgwoS/4YJWnCsCdZs7TKu1Fv/atB6/bTaHDrw61ur3GQNVfFtmQUZ3uzc7uFXnMfWNbBhrNWao+gsOmk+flEuOUsHYb1pro9J6IHxBNSD7tptY/hpjKIblofaAkHXyGqghE67MnoH68uJok9WeeiAhfQrdYSGUG5bWyHoGPX5KpLsF32AZZTnhzQvdWUlZT6jp/+HeNWwyxDeIbuME0akO8aH3a1oOmJtxlZVZ4e40zSfDSJUvjj7gNYP49k7M9H9di8uP/ZUBZx0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 06:41:46 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Sat, 12 Aug 2023
 06:41:46 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZxStsBtGoY60ZQkekYudRfTtGjK/mROWA
Date:   Sat, 12 Aug 2023 06:41:45 +0000
Message-ID: <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.026097251@linutronix.de>
In-Reply-To: <20230802101934.026097251@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7197:EE_
x-ms-office365-filtering-correlation-id: a8729e45-4340-426b-c865-08db9aff32a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbsNynqNJvRXdZuq+Q2UzvKrOColpL9esERk/vHxuZQYsGXNPvezW7cWESm6dsZhgTtVMP94dge8Q4L/o8guGJhBd0A3D5GaG17eUlQ4Gow21ROd1Ain+HJI+UMdiir9V8SGu6s2VunRS7+MVLRNWMC8P2WXtqF9sPpmM+znZdiWiAtoDicb50/POLITS7IhiDYfjuUJFIdndX6UV8u3a2HTbBicSULs09kpnj2d9/hzchHhGT0dwyCbPioiJAgDPHujk0EC3iHDWoW8Dfz5khwqulKHuHz/dnMas4d3XOVKLr9CwTRD9VF4q/NjvzCkSXsPYIZPy1VzLy90025Vaw/Z0cCJJ6x7iJ2Nhv495mk/w85JdqOQ55WvitSYL38ui53UV7q4eh60FPCGNTp7KFLsFCtDEWFF+qXZ8DxsV6ecAmDYcnpgXQRmfv8iTRduNQ6rTgor5K2wxcVj14IOQH5ye6DrPHG+OhFLjY8xbIKJrXZECI12ZZs24F5FqaM2Auh2ihawq4QDCjTzFO7NHGux/lNjY6+JJvycDjS8SGQdWVV0af1g3wUhPVscSJf0tagPM1uIkOaTYGgRL0raJxAt1ekVEqWQ0dhyDhyF0wxYr2pkC5FBpPFLuVNdJwra
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(186006)(1800799006)(451199021)(6506007)(83380400001)(71200400001)(26005)(122000001)(86362001)(478600001)(82960400001)(6486002)(6512007)(36756003)(2616005)(91956017)(64756008)(76116006)(66556008)(66946007)(4326008)(66446008)(66476007)(316002)(8936002)(2906002)(41300700001)(8676002)(38070700005)(7416002)(54906003)(5660300002)(38100700002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVMdUkwZDExdnNTbFMzdzlDVm5DUjdYUDNJbHIwanZUUUl5ZFBuZlZnSXRO?=
 =?utf-8?B?dDhCbk9QUzVJTzZxM0UyQytrWW5SbTBrVGJuZkdreGYyejQxTkU4Yjd1eUxo?=
 =?utf-8?B?ZXoxVGZ4NzhJT252MkpicTBJMGdrUWhVNGdwS1Bsd3Bia1dVTzZlV29JMGh5?=
 =?utf-8?B?dXZoY2N3MjkvSUdiWkswVlI1M2N4VVB5MUUxZTRXczR3ZEd3K1RBK2xPOUIy?=
 =?utf-8?B?VTByMzlsaS8wTG5keXNPK2tLc1JRa0NvNGFHd0IwSEZBTStFZGZGeHU1MjFT?=
 =?utf-8?B?aU00cGN5Y0llZFN1QW1aM1Vad1oyOTBWdGdxd2pIMWwvK3Q1ejZrVjR3eG9D?=
 =?utf-8?B?aThyQ0VDaU4zL3lGdUxSWWptYUZmbG9qc0xCM0YzQldWUkc5bENTWHpBbVVz?=
 =?utf-8?B?MjNKRmU2c2pYa3BNaU1XNXQzVkJnSEx4b0RROWE0bDdaYjliU3ozZ1Nxb254?=
 =?utf-8?B?WHAyNEhXSUZxaEplekIxdTV3YjJXcEhIMHpwKzhJRzhOL3NyUDB3ckNuak9R?=
 =?utf-8?B?MUJ5a1VWMWt5OElGU1laaDREb2dleWt1bFRGTzA2ZGNGSWVyb2VGbTNneUJj?=
 =?utf-8?B?cFljclM2QUkwUktTRmxWc2J3VFhXOVlkenRCanNmalp2RzhGek5Xd1Fkd2Jr?=
 =?utf-8?B?bitDSkx2N0dIa1JTRkhXWllhOTZNaTJYYURCVy9ZZHUyWVk2SGxadnBoMENu?=
 =?utf-8?B?S1VNc0NoUDh0ZXdXTSs1MkNNc1YraHpwUFpob0lhdmtFcUc3TkFmK3gwaVNl?=
 =?utf-8?B?UUFTNE8ya01pU3I4Uis4MGt1T1ZtRCtkK0tBK0hnZzVRUlFIb2xNdHB3M2F0?=
 =?utf-8?B?TlF5TVY1T0xwZTZZQlBFNFNLcmJFZFNtZ3NLWi90b25INXVZVklsWURoRnJo?=
 =?utf-8?B?QXdQS2MwQlAvRnZSYU43c3MvUkY2SzhpRUxVQTFqSEpMclZNMUQyblBVdlZi?=
 =?utf-8?B?NVVWd3UvOUJRYXhlVGtaN3pSMFgyakQ4K2NOc3h2cDJHNGU0a3RGVHE5Mmk5?=
 =?utf-8?B?NVV1NjhOWUs0LzlVcEFpNWlmaDJQeC9vZGtpKzFjVjNvQWdsOTRWQnhKeXhw?=
 =?utf-8?B?azN1cU5EQmF3MjhsUGcralRzTVUxZ0JYYTdjQzlZZ2pQY3VHdVI3VXlkQTFn?=
 =?utf-8?B?TmRocDk2TytML2tya21hWmFMdFdvT0NCQmFTK1FmaFlBbWZodE05dXE4MFZ3?=
 =?utf-8?B?U3NJMkxVQWN2d3dTWnRQc0NpNmFTZWlCQ1hTd0ZnMEtla0FEQXBnUUJzMDZw?=
 =?utf-8?B?dFZ6ZXc1N3FzdjVmVW9yOWpyR1prdlEyNGdzVjgrTHVscUlrNWJKd2MvZnZa?=
 =?utf-8?B?WHhmMDRIQzI1anpnQjQ1K2xleUwwVitmS2pSVzZoemxqRkc0d290TDErT1Fv?=
 =?utf-8?B?a2plT2tXUndPQ0xrVEJpY3diNExUdUZsZDNkRzNHcGRSdlFoczBRdEoweVIw?=
 =?utf-8?B?WXZadkRHMFFzMlU4V3dIbFd5QlliTGFzV2s0NS93TW1OMmJWYUg1T3k0L0Zl?=
 =?utf-8?B?cTJ1MW9CUW1kQ2J6aE5jQ0VObHNud3VBc1dGckhrWE5IU0M1em9hMjB2M1k3?=
 =?utf-8?B?R0RtMGMxejdEaVNSQ2xPaSszcVc5NkFqREszazd1c045YldFVXZ2Q1hpUkpp?=
 =?utf-8?B?ZXNOc1lXNENsaXR0ZFo4Z3cyYnYzdVBLa2tsVkNXdWhOR1g2cDRPVVVCRXVT?=
 =?utf-8?B?Kys5aW9jZ2oycWxiY3JicDlQenVCYVRBUXFsc2RpMUQwbC9aK2dBQS8xYmMr?=
 =?utf-8?B?T25kallPcUxXRi9RbUVFQ3kvL3I2RFVzblFFMjZYUDdhM2xYOHY2dVVjT2E0?=
 =?utf-8?B?TDBkK3FQOXdVamkyTG1kS2tHYnQ5dmYxV3ArbCtFL1hzRENBTzcybk94L3BJ?=
 =?utf-8?B?Q1JyMzV2SjBjeGdVeGI0aGFteFRLN1J1T2xWeTFmRVVIUkVldjNVNVpxN0t0?=
 =?utf-8?B?Y0xxRGlyaG9NVUlvYTRScGhaUk5wTmlhUFdsWDkxRDlOTllkc3IwbWNEbml4?=
 =?utf-8?B?WHJPa0ZvK1FFY0pnR0tzRCtldEtWRytSYktlb3FGOEtBOEh4WE04K0E5aXY0?=
 =?utf-8?B?bVlRMXdFajVpQ1RhUGN6VU5PVXduTXZlc1ZZOFI2c3ZQT3JaT0dkVm9MSjhH?=
 =?utf-8?Q?gP7Wx8TVnxwtE+DRxthYtRwOs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7180EA253AB58E4B9BB9E8135AF86544@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8729e45-4340-426b-c865-08db9aff32a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 06:41:45.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFW8R/JmA9S0gFDtSb3OrzbncYprehPJMiSomzLJEE7F341+qjUrEOrMtsx2KyO6IL/xJAO4TpLxNgoEf+wzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
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

PiArDQo+ICtzdGF0aWMgaW5saW5lIHUzMiB0b3BvX3JlbGF0aXZlX2RvbWFpbl9pZCh1MzIgYXBp
Y2lkLCBlbnVtDQo+IHg4Nl90b3BvbG9neV9kb21haW5zIGRvbSkNCj4gK3sNCj4gK8KgwqDCoMKg
wqDCoMKgaWYgKGRvbSAhPSBUT1BPX1NNVF9ET01BSU4pDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBhcGljaWQgPj49IHg4Nl90b3BvX3N5c3RlbS5kb21fc2hpZnRzW2RvbSAtIDFd
Ow0KPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gYXBpY2lkICYgKHg4Nl90b3BvX3N5c3RlbS5kb21f
c2l6ZVtkb21dIC0gMSk7DQo+ICt9DQoNCnJlbGF0aXZlX2RvbWFpbl9pZCgpIGlzIHVzZWQgdG8g
Z2V0IGEgdW5pcXVlIGlkIHZhbHVlIHdpdGhpbiBpdHMgbmV4dA0KaGlnaGVyIGxldmVsLg0KDQo+
ICtzdGF0aWMgdm9pZCB0b3BvX3NldF9pZHMoc3RydWN0IHRvcG9fc2NhbiAqdHNjYW4pDQo+ICt7
DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9IHRzY2FuLT5jOw0KPiAr
wqDCoMKgwqDCoMKgwqB1MzIgYXBpY2lkID0gYy0+dG9wby5hcGljaWQ7DQo+ICsNCj4gK8KgwqDC
oMKgwqDCoMKgYy0+dG9wby5wa2dfaWQgPSB0b3BvX3NoaWZ0X2FwaWNpZChhcGljaWQsIFRPUE9f
UEtHX0RPTUFJTik7DQo+ICvCoMKgwqDCoMKgwqDCoGMtPnRvcG8uZGllX2lkID0gdG9wb19zaGlm
dF9hcGljaWQoYXBpY2lkLCBUT1BPX0RJRV9ET01BSU4pOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDC
oC8qIFJlbGF0aXZlIGNvcmUgSUQgKi8NCj4gK8KgwqDCoMKgwqDCoMKgYy0+dG9wby5jb3JlX2lk
ID0gdG9wb19yZWxhdGl2ZV9kb21haW5faWQoYXBpY2lkLA0KPiBUT1BPX0NPUkVfRE9NQUlOKTsN
Cg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCB0byBlbnN1cmUgYSBwYWNrYWdlIHNjb3BlIHVu
aXF1ZSBjb3JlX2lkLA0KcmF0aGVyIHRoYW4gTW9kdWxlL1RpbGUgc2NvcGUgdW5pcXVlLCB3aGF0
IGlzIHJlYWxseSBuZWVkZWQgaGVyZSBpcw0Kc29tZXRoaW5nIGxpa2UsDQoJYXBpY2lkID4+PSB4
ODZfdG9wb19zeXN0ZW0uZG9tX3NoaWZ0c1tTTVRdOw0KCWMtPnRvcG8uY29yZV9pZCA9IGFwaWNp
ZCAmICh4ODZfdG9wb19zeXN0ZW0uZG9tX3NpemVbUEFDS0FHRV0NCi0gMSk7DQoNCkkgZG9uJ3Qg
aGF2ZSBjaGFuY2UgdG8gY29uZmlybSB0aGlzIG9uIGEgcGxhdGZvcm0gd2l0aCBNb2R1bGUgbGV2
ZWwNCnlldCwgYnV0IHdpbGwgZG8gc29vbi4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K
