Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375AC806308
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbjLEXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjLEXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:36:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42843183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701819419; x=1733355419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K3h0JpJsw/P9CcIlBhk88qo1dFlkdlocvXXo2/hFKi4=;
  b=iFuQf6RwVheL41a0/f35SH4NBIoAWOxsdUtGYEL+QanXWpRzFOOU3iFD
   0q0EGrNJy9cm+yw6qRmgREw3kSZxqfCXWW8S3++onoYeRu2wMnjOEyG2h
   REZOOhOliTfzIldaNcTpkAMuvEvP2Lbsq5ZPJ3K94SiNkydcEM3W3+Jch
   W5VtXFk5tgu7Wwj9NeXzP6tpILZdKe2t0QOz+sE/6jiG+QtstVwEpZGwN
   upxYUOPDUzUfbKHoRUtxqdLQcngwKXZtBhwwK//jRSVSP1fCNzFIei0cA
   ovlEllkgROJHydRpeMHmNly2IJ71iX8Mz150zl9Qwh+2jGJHuYFflWBdG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7273094"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7273094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771095713"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="771095713"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:36:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:36:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:36:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:36:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRZL1k7fxQHKSKstHcakLG6Wbd73sY80K+QSPDsWzyvdYRS22m1SGPQpHdiXJW0M9759IMnWPsU/reZ2Nyhh2BMIl+mszhwhLFGYjwZhkSlrdeDLJTK0zvrUZE64FuZnYzLy1VagFp13mfTwqvzoDLp6H6YCUUzM45j+OEbH0wjDxtkmIP/D2Y/9f8gpxrE+DWfzx7zeo6p6NC5DFKIFf7vsq3OOrke8KIvGo4z136Gx2jA0V5TBiOA3fepC6jVvPmpKQo3RNWSyF2ad7+ZSuEoXmP2XuyzzZ5gyx1alAWjeU7XVvc8Jz1dM849Gw8PM57j1DhTeEQdCi2+0YcA8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3h0JpJsw/P9CcIlBhk88qo1dFlkdlocvXXo2/hFKi4=;
 b=RDRXAygEvQWs5QAE/IHoaOKmyMkWKVzzBsPPAaPszkRHd0JuzIDzfyNY1wM/uTSGTQHEFPs5f338q3RjPSNClDtnf6r2apKf1yyXlojwuErTmecx3TEV6L+I318oWHJLroVi2tYI72/zSniyzkNy/KFR7W3tJ4M2yktm4GdqPEh9y9gKKDhS8N6zhlt7HLlJ19bWRMB3zgHtBYVW18vQATE/OqKzSVhBtAAFxyY/z56WOravg96ULhDYhl+k0nfH6zMh5IGkzQGoJALTARSwxPnzOhhMCRPyLN01hIza35Y07TZGWYNJ2vgTXNnAckZ7u9BQI5fN4telZClQKtYoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:36:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.025; Tue, 5 Dec 2023
 23:36:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaJxRg2LJJnT2of0eK3PTgcDCh0LCbWa0A
Date:   Tue, 5 Dec 2023 23:36:55 +0000
Message-ID: <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
         <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5145:EE_
x-ms-office365-filtering-correlation-id: ef44d994-b718-4a8b-4fb7-08dbf5eb10c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZP9bbKwm7E7rsl1NWK69oKj4LUDeJyGJ3b0VWKrCNPSgBuSXx+RlC80u5/Zl4L/HvnXnlibhOCkJQPshTQxmX8LXBk3vAOnN/HlSjRGp+0LW/PMxqD1RmSjG76CRRuf4A5xCNgd91opEVv1NlqxpXp9f/NoZsSihVxtnW0V0F4ZT8rxTcZsk5vv3HTsyCT8nr3wI1eqofiOZSq8jslLjJzMYwOZAsfTgSVsEQMYsHs7sbOBZZZeYoWr9crTOW9bheFdfpFSxiDeFnNmX8U23IuNnQtxWi4CVKeK2sJZwi5603jrNAsjwVczo8nBsvPflzXQOLIfzCAkRpRxaGkxpYCwD3PZXr3Lv9oUpXaARsyy5rWS7YXrBPMhbE3CXk5Es2Fdu2Rv07Mp+6HNz4X6IT1kSgSRx6BYLkg15Vj8o6AAJKruyRuFjlpHNgFeLRLrgO7zzvdgJLTKSpUlsQb5qLqc4K7skj579RlWzakFIjeAWPF+9AW2xfxuC/nU3dAoPJZnf95EkmzaeoFmLIPLbDCJP1BroEn1TCYqqcoWrtkBhhDgzos8ov70QYAZLsDogq4qYW4575Ll7FOTjPd9h429qjhk5e+rDSyc/7q4TMmOFA47fPGGT2Ipk2L2aa4m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(26005)(71200400001)(110136005)(316002)(66476007)(91956017)(66446008)(64756008)(54906003)(66556008)(86362001)(36756003)(41300700001)(8936002)(66946007)(76116006)(38070700009)(8676002)(4326008)(7416002)(2906002)(122000001)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG43U3FXMFhUaVZqRFhWV1VMbXE5T1ZwMTd0dnRUUVVSYjdNczNicFNnVmgx?=
 =?utf-8?B?Tm43SXl5dDU3YlMwbVBRZ0tEcC80QWFQK0hhRGtxVHpvWmxsYlhXOVVmbUZo?=
 =?utf-8?B?TXhLYWdQTms5WTFCS3RlWklWY0picVA3eDFrMjZxMWdCZUdDUWF5bXpPRkRj?=
 =?utf-8?B?OGp4YnpvWWhrSTk0TnlDeVFBdUVkVEtKTXgwRU80VXZRSFhwa1FtSXR4SXZM?=
 =?utf-8?B?bm1ja1hGaHpvK0ExbE9VOGJqekRjM095QVUxQUppOFNSTmdIWVkzT1hvWEZQ?=
 =?utf-8?B?elVxSGVpT2tWSithOW9uQ1cwTDVFckc3OURUMVM4cjJLL29TeUNrQytsVTVH?=
 =?utf-8?B?czgrK2MwdDNTNFpBdmo4ZndyUTd4L2NhcFNYMnNrODRna1NPU3hHN2ptWWty?=
 =?utf-8?B?Ym1mUDZFcnZhN1c0SjZyVzhmVlpGVEFMQWNaRWJYMGgybXIxWERUVFFrMW5O?=
 =?utf-8?B?NUdPU1pUSU94ZzVtQzRtWXE3TnQ1ZUZ4c205cVp3L1h4aW83UWR3WjdUMU80?=
 =?utf-8?B?OGFRNWZIRUYxMVFTWkJvTklVZ2RBNGlGVmRlK2ZFRDhSUnBNK1EyL1B6K0Nz?=
 =?utf-8?B?bHd6VkM5djd6bzg2RVRielk1VHVYamVsSUdsZ01ha2gwVWdJYjlkb1RiTjA2?=
 =?utf-8?B?Zk9ZNXUwYUdLUTFPYnFvQk5HRDJuRVovMlJQaE9CSTNnbWtuQkx5S1g5VUk5?=
 =?utf-8?B?WUZPUHhWZVg0cmNDM2diMk92aDhnSG9HdXZwczBKSzA4eHF3cHBwQ3pmeHZx?=
 =?utf-8?B?cGpDY3g0ZVJ1ZGY2b2FSRGc2Z0tCV3J2S2M1eHBaNTNMaXlMaFpvcHJNVXlP?=
 =?utf-8?B?QlJ1VjduMUNoaUxGT3l2S1VXZUlsRnZZNktzSUFiMUVndWx1T2pHQnhjN3hl?=
 =?utf-8?B?WWpUa1QvZ2ZBZTdQaHRyUm5KbURjMjdvMTFRR0Q1UUVQcTdpZzgvVThRUmk3?=
 =?utf-8?B?Q0Z2OHl6bUw0MGt5b2VxN3FYWC9HMjR2ODNURzc3MkNDRDZCTU82dEswbTlL?=
 =?utf-8?B?OXNyZjhpdy9taFRRREJNUmNwOVFWVVErM3ZGQ011cFBoRTlzWVBjOXdWUkZp?=
 =?utf-8?B?UHBUc1Q3S05ZSmZEMXYxQk0wbWVObVJ2NWQ1N2tQY29tR0R2QkM1YzVkb1pU?=
 =?utf-8?B?ZDNkRXRuUjh1OXhyb3lIbk1hY1JXQ2E4d2hlZ0p3cWk0cERsZVZKV3FsMlYw?=
 =?utf-8?B?Yi9RWlBDa2FiUXhYNGJ6K2dmaXFzZXlCNkFuN2NOR055UVBSTVMwcDV2MUpQ?=
 =?utf-8?B?UmVtSkNkWUhCK3ZDMlA5ZzZ2bFY4SHozNXNTUkxUME00OVhJSnFtazBPRkNl?=
 =?utf-8?B?elh0czFqYWlIa21SeGpwdWpPNG9mUHZUdlpDY2ErUTFTU3JQSWJuazE3Y3dT?=
 =?utf-8?B?ZzQ3RS9CTSs3MjBnZXE5L1FjTGJLeGJ5eUpSZ2pkRENpTHpTeFZVSXNicTFL?=
 =?utf-8?B?NG5tdHZJcHVYR1c3N3prZmRidEdXVTU3bzV6Y3E0a2VUeGV1VG5zb2lSUVB2?=
 =?utf-8?B?T0VnZUpPaE1scEFXNXhrWGtqQnA1c3FhL3hBaHR2Zk1VY0ZmNlZJb0JldU91?=
 =?utf-8?B?ci9RencwdC9Sanh3dlZrbmJYYll5Y04vcEROZGExbko1eGlTaS9xaWl3WWda?=
 =?utf-8?B?cDdBK0tBSWVyOGVpYVdYRnhqQnJueDRuT0Vib3FXYWUwL0RpYWlsZmtJMUNq?=
 =?utf-8?B?K0FKUWJ5RFFEVXJic3N3SGx5SVpjQVhCNmVFUnFHWUtvRkdzTVVMNTBLQzd2?=
 =?utf-8?B?Ri9PL0ZlQU95Y0tRdjZmS3o2MzdHWlcrcVBkSzQ2V05TTWhEaWc0cjBBNXV6?=
 =?utf-8?B?d1V6Q1RsY3VHOHFKQ1ZyNkgxY0hZYXlvSTJFTjl1NGc2Z1NXT0JEZVVxZHNj?=
 =?utf-8?B?eVFJTVZLS0NMUHBWN2VnNUJZK3hEOGt2c21vanp4aHhYb3pvSmR6UWZ3U21T?=
 =?utf-8?B?NEw2MCtrMWZud3dBL0tuOTZobHRSbjRSYWZEOXVJNGsyakNBK2tKV2xVUFM5?=
 =?utf-8?B?ZHVxUE1Fb3pWbmN4cUZWMnhpT3ZXNUt3bFRPb05lcTRsQkkyYUVZa1h6ejA5?=
 =?utf-8?B?OFNOMWZ0dFZiWWxYWE5wRDZBTk8yaWp2RldqWTJRWkdtaG9pQ2VudkxwZUhs?=
 =?utf-8?B?ZEROVEMxN1hCUjFmaEdlS1BQU0k4VktYMXh3MFpPTWNsZUx6d1g4ZnVqd1ZO?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73A22C34411FC142BCDD48E0FE9CB279@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44d994-b718-4a8b-4fb7-08dbf5eb10c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 23:36:55.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw3fE99DUC9oYbZmNMPuBnum2d5blnDW6ptTBjijrnidNRtdaZXGLOMiP+6B/UmHlbPAjPzX5atVlHoSabJ5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
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

DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGFjcGlfbXBfc3RvcF9vdGhlcl9jcHVzKGludCB3YWl0KQ0K
PiArew0KPiArCXNtcF9zaHV0ZG93bl9ub25ib290X2NwdXMoc21wX3Byb2Nlc3Nvcl9pZCgpKTsN
Cj4gK30NCg0KSXMgdGhpcyBhbmQgLi4uDQoNCisJc21wX29wcy5zdG9wX290aGVyX2NwdXMgPSBh
Y3BpX21wX3N0b3Bfb3RoZXJfY3B1czsNCg0KLi4uIHRoaXMgYmVsb3cgc3RpbGwgbmVlZGVkPw0K
DQpJIHRoaW5rIHRoZSBjdXJyZW50IG5hdGl2ZV9zdG9wX290aGVyX2NwdXMoKSBzaG91bGQganVz
dCB3b3JrIGdpdmVuIHlvdSBoYXZlIHNldA0KdXAgLi4uDQoNCisJc21wX29wcy5jcmFzaF9wbGF5
X2RlYWQgPSBjcmFzaF9hY3BpX21wX3BsYXlfZGVhZDsNCg0KLi4uIGZvciBURFggZ3Vlc3Q/DQoN
Cj4gKw0KPiArLyogVGhlIGFyZ3VtZW50IGlzIHJlcXVpcmVkIHRvIG1hdGNoIHR5cGUgb2YgeDg2
X21hcHBpbmdfaW5mbzo6YWxsb2NfcGd0X3BhZ2UgKi8NCj4gK3N0YXRpYyB2b2lkIF9faW5pdCAq
YWxsb2NfcGd0X3BhZ2Uodm9pZCAqZHVtbXkpDQo+ICt7DQo+ICsJcmV0dXJuIG1lbWJsb2NrX2Fs
bG9jKFBBR0VfU0laRSwgUEFHRV9TSVpFKTsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIE1ha2Ug
c3VyZSBhc21fYWNwaV9tcF9wbGF5X2RlYWQoKSBpcyBwcmVzZW50IGluIHRoZSBpZGVudGl0eSBt
YXBwaW5nIGF0DQo+ICsgKiB0aGUgc2FtZSBwbGFjZSBhcyBpbiB0aGUga2VybmVsIHBhZ2UgdGFi
bGVzLiBhc21fYWNwaV9tcF9wbGF5X2RlYWQoKSBzd2l0Y2hlcw0KPiArICogdG8gdGhlIGlkZW50
aXR5IG1hcHBpbmcgYW5kIHRoZSBmdW5jdGlvbiBoYXMgYmUgcHJlc2VudCBhdCB0aGUgc2FtZSBz
cG90IGluDQo+ICsgKiB0aGUgdmlydHVhbCBhZGRyZXNzIHNwYWNlIGJlZm9yZSBhbmQgYWZ0ZXIg
c3dpdGNoaW5nIHBhZ2UgdGFibGVzLg0KPiArICovDQo+ICtzdGF0aWMgaW50IF9faW5pdCBpbml0
X3RyYW5zaXRpb25fcGd0YWJsZShwZ2RfdCAqcGdkKQ0KPiArew0KPiArCXBncHJvdF90IHByb3Qg
PSBQQUdFX0tFUk5FTF9FWEVDX05PRU5DOw0KPiArCXVuc2lnbmVkIGxvbmcgdmFkZHIsIHBhZGRy
Ow0KPiArCXA0ZF90ICpwNGQ7DQo+ICsJcHVkX3QgKnB1ZDsNCj4gKwlwbWRfdCAqcG1kOw0KPiAr
CXB0ZV90ICpwdGU7DQo+ICsNCj4gKwl2YWRkciA9ICh1bnNpZ25lZCBsb25nKWFzbV9hY3BpX21w
X3BsYXlfZGVhZDsNCj4gKwlwZ2QgKz0gcGdkX2luZGV4KHZhZGRyKTsNCj4gKwlpZiAoIXBnZF9w
cmVzZW50KCpwZ2QpKSB7DQo+ICsJCXA0ZCA9IChwNGRfdCAqKWFsbG9jX3BndF9wYWdlKE5VTEwp
Ow0KPiArCQlpZiAoIXA0ZCkNCj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiArCQlzZXRfcGdkKHBn
ZCwgX19wZ2QoX19wYShwNGQpIHwgX0tFUk5QR19UQUJMRSkpOw0KPiArCX0NCj4gKwlwNGQgPSBw
NGRfb2Zmc2V0KHBnZCwgdmFkZHIpOw0KPiArCWlmICghcDRkX3ByZXNlbnQoKnA0ZCkpIHsNCj4g
KwkJcHVkID0gKHB1ZF90ICopYWxsb2NfcGd0X3BhZ2UoTlVMTCk7DQo+ICsJCWlmICghcHVkKQ0K
PiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ICsJCXNldF9wNGQocDRkLCBfX3A0ZChfX3BhKHB1ZCkg
fCBfS0VSTlBHX1RBQkxFKSk7DQo+ICsJfQ0KPiArCXB1ZCA9IHB1ZF9vZmZzZXQocDRkLCB2YWRk
cik7DQo+ICsJaWYgKCFwdWRfcHJlc2VudCgqcHVkKSkgew0KPiArCQlwbWQgPSAocG1kX3QgKilh
bGxvY19wZ3RfcGFnZShOVUxMKTsNCj4gKwkJaWYgKCFwbWQpDQo+ICsJCQlyZXR1cm4gLUVOT01F
TTsNCj4gKwkJc2V0X3B1ZChwdWQsIF9fcHVkKF9fcGEocG1kKSB8IF9LRVJOUEdfVEFCTEUpKTsN
Cj4gKwl9DQo+ICsJcG1kID0gcG1kX29mZnNldChwdWQsIHZhZGRyKTsNCj4gKwlpZiAoIXBtZF9w
cmVzZW50KCpwbWQpKSB7DQo+ICsJCXB0ZSA9IChwdGVfdCAqKWFsbG9jX3BndF9wYWdlKE5VTEwp
Ow0KPiArCQlpZiAoIXB0ZSkNCj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiArCQlzZXRfcG1kKHBt
ZCwgX19wbWQoX19wYShwdGUpIHwgX0tFUk5QR19UQUJMRSkpOw0KPiArCX0NCj4gKwlwdGUgPSBw
dGVfb2Zmc2V0X2tlcm5lbChwbWQsIHZhZGRyKTsNCj4gKw0KPiArCXBhZGRyID0gX19wYSh2YWRk
cik7DQo+ICsJc2V0X3B0ZShwdGUsIHBmbl9wdGUocGFkZHIgPj4gUEFHRV9TSElGVCwgcHJvdCkp
Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQoNClNvcnJ5IGZvciBzYXlpbmcgdGhpcyBsYXRl
LiAgSSB0aGluayB3ZSBjYW4gYWxzbyB1c2Uga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgpDQp0
byBkbyB0aGUgaW5pdF90cmFuc2l0aW9uX3BndGFibGUoKT8gIFdlIGNhbiBzZXQgc3RydWN0IHg4
Nl9tYXBwaW5nX2luZm86Om9mZnNldA0KdG8gX19QQUdFX09GRlNFVCB0byBkbyB0aGF0Pw0KDQpM
b29rcyBzZXRfdXBfdGVtcG9yYXJ5X21hcHBpbmdzKCkgaW4gYXJjaC94ODYvcG93ZXIvaGliZXJu
YXRlXzY0LmMgdXNlcyB0aGUgc2FtZQ0KdHJpY2suDQoNCkFueXdheSBJIGFtIG5vdCBzdXJlIGhv
dyBtYW55IExvQyAoYXNzdW1pbmcgY2FuIGRvKSBjYW4gYmUgc2F2ZWQgc28gdXAgdG8geW91Lg0K
DQo+ICsNCj4gK3N0YXRpYyB2b2lkIF9faW5pdCBmcmVlX3B0ZShwbWRfdCAqcG1kKQ0KPiArew0K
PiArCXB0ZV90ICpwdGUgPSBwdGVfb2Zmc2V0X2tlcm5lbChwbWQsIDApOw0KPiArDQo+ICsJbWVt
YmxvY2tfZnJlZShwdGUsIFBBR0VfU0laRSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIF9f
aW5pdCBmcmVlX3BtZChwdWRfdCAqcHVkKQ0KPiArew0KPiArCXBtZF90ICpwbWQgPSBwbWRfb2Zm
c2V0KHB1ZCwgMCk7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgUFRSU19Q
RVJfUE1EOyBpKyspIHsNCj4gKwkJaWYgKCFwbWRfcHJlc2VudChwbWRbaV0pKQ0KPiArCQkgICAg
Y29udGludWU7DQo+ICsNCj4gKwkJaWYgKHBtZF9sZWFmKHBtZFtpXSkpDQo+ICsJCSAgICBjb250
aW51ZTsNCj4gKw0KPiArCQlmcmVlX3B0ZSgmcG1kW2ldKTsNCj4gKwl9DQo+ICsNCj4gKwltZW1i
bG9ja19mcmVlKHBtZCwgUEFHRV9TSVpFKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgX19p
bml0IGZyZWVfcHVkKHA0ZF90ICpwNGQpDQo+ICt7DQo+ICsJcHVkX3QgKnB1ZCA9IHB1ZF9vZmZz
ZXQocDRkLCAwKTsNCj4gKwlpbnQgaTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBQVFJTX1BF
Ul9QVUQ7IGkrKykgew0KPiArCQlpZiAoIXB1ZF9wcmVzZW50KHB1ZFtpXSkpDQo+ICsJCQljb250
aW51ZTsNCj4gKw0KPiArCQlpZiAocHVkX2xlYWYocHVkW2ldKSkNCj4gKwkJICAgIGNvbnRpbnVl
Ow0KPiArDQo+ICsJCWZyZWVfcG1kKCZwdWRbaV0pOw0KPiArCX0NCj4gKw0KPiArCW1lbWJsb2Nr
X2ZyZWUocHVkLCBQQUdFX1NJWkUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBfX2luaXQg
ZnJlZV9wNGQocGdkX3QgKnBnZCkNCj4gK3sNCj4gKwlwNGRfdCAqcDRkID0gcDRkX29mZnNldChw
Z2QsIDApOw0KPiArCWludCBpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IFBUUlNfUEVSX1A0
RDsgaSsrKSB7DQo+ICsJCWlmICghcDRkX3ByZXNlbnQocDRkW2ldKSkNCj4gKwkJCWNvbnRpbnVl
Ow0KPiArDQo+ICsJCWZyZWVfcHVkKCZwNGRbaV0pOw0KPiArCX0NCj4gKw0KPiArCWlmIChwZ3Rh
YmxlX2w1X2VuYWJsZWQoKSkNCj4gKwkJbWVtYmxvY2tfZnJlZShwNGQsIFBBR0VfU0laRSk7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIF9faW5pdCBmcmVlX3BnZChwZ2RfdCAqcGdkKQ0KPiAr
ew0KPiArCWludCBpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IFBUUlNfUEVSX1BHRDsgaSsr
KSB7DQo+ICsJCWlmICghcGdkX3ByZXNlbnQocGdkW2ldKSkNCj4gKwkJCWNvbnRpbnVlOw0KPiAr
DQo+ICsJCWZyZWVfcDRkKCZwZ2RbaV0pOw0KPiArCX0NCj4gKw0KPiArCW1lbWJsb2NrX2ZyZWUo
cGdkLCBQQUdFX1NJWkUpOw0KPiArfQ0KDQpJdCdzIGEgbGl0dGxlIGJpdCBzYWQgc3VjaCBjbGVh
bnVwIGNvZGUgaXNuJ3QgaW4gY29tbW9uIGNvZGUsIGUuZy4sIHdpdGggYSANCg0KCXZvaWQgKCpm
cmVlX3BndF9wYWdlKSh2b2lkICopOw0KDQp0byBhbGxvdyB0aGUgdXNlciB0byBzcGVjaWZ5IGhv
dyB0byBmcmVlIHRoZSBwYWdlIHRhYmxlLg0KDQpCdXQgdGhpcyBjYW4gYmUgZnV0dXJlIGpvYiBp
ZiBuZWVkZWQuDQoNCg0KWy4uLl0NCg0KPiAgaW50IF9faW5pdCBhY3BpX3BhcnNlX21wX3dha2Uo
dW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsDQo+ICAJCQkgICAgICBjb25zdCB1
bnNpZ25lZCBsb25nIGVuZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193
YWtldXAgKm1wX3dha2U7DQo+ICANCj4gIAltcF93YWtlID0gKHN0cnVjdCBhY3BpX21hZHRfbXVs
dGlwcm9jX3dha2V1cCAqKWhlYWRlcjsNCj4gLQlpZiAoQkFEX01BRFRfRU5UUlkobXBfd2FrZSwg
ZW5kKSkNCj4gKw0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBDYW5ub3QgdXNlIHRoZSBz
dGFuZGFyZCBCQURfTUFEVF9FTlRSWSgpIHRvIHNhbml0eSBjaGVjayB0aGUgQG1wX3dha2UNCj4g
KyAgICAgICAgICogZW50cnkuICAnc2l6ZW9mIChzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193
YWtldXApJyBjYW4gYmUgbGFyZ2VyDQo+ICsgICAgICAgICAqIHRoYW4gdGhlIGFjdHVhbCBzaXpl
IG9mIHRoZSBNUCB3YWtldXAgZW50cnkgaW4gQUNQSSB0YWJsZSBiZWNhdXNlIHRoZQ0KPiArCSAq
ICdyZXNldF92ZWN0b3InIGlzIG9ubHkgYXZhaWxhYmxlIGluIHRoZSBWMSBNUCB3YWtldXAgc3Ry
dWN0dXJlLg0KPiArICAgICAgICAgKi8NCg0KU3BhY2UvdGFiIGlzc3VlLg0KDQo+ICsJaWYgKCFt
cF93YWtlKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlpZiAoZW5kIC0gKHVuc2lnbmVkIGxv
bmcpbXBfd2FrZSA8IEFDUElfTUFEVF9NUF9XQUtFVVBfU0laRV9WMCkNCj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ICsJaWYgKG1wX3dha2UtPmhlYWRlci5sZW5ndGggPCBBQ1BJX01BRFRfTVBfV0FL
RVVQX1NJWkVfVjApDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQoNCg==
