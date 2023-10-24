Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269BE7D4D63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJXKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJXKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:12:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E9DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698142325; x=1729678325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YkpT9wWbc97uFxprOB/bSfRZ65XULBFGy7TIVEX9WxE=;
  b=AyE1l+gfQWoebXMGzn2hTPlFeWNsRXjHJMuGLOn+GrSf7y6efJ2vKgtI
   HYhCJqEehGDt1Jhk/jxT0Fze8UuFUrNNKM9KeFrHkvyN47SQJXVPb2Y98
   RgUNy9kt21ScSUDHRIcrY8v0E8DqTWQlxO553GiBz0nY8tO1gJyMYUjId
   6ofAWbpctVTWlO0pUeiela315+fmVdyu8M1pyQWAS3V+r0ODPW86SPfOZ
   uYvtNknhXen6HtipH4pTSdaYT+yPC1AUuO6NDykWBlMjSlv0RScb6TmYA
   qasU2LEknm6EIKgGnHTGqHdLeKyvjTwWkSE4TWoJ2QOy9kV7oXGDX7jwR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473250661"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="473250661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793435162"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="793435162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 03:12:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 03:12:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 03:12:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 03:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzP8tS7j1j9/XZL1PlB4tBcoe38xseKrXzYSK/y3z4zvfee3EEcY2jsSP5aJG0l1Yc97YrJt1DKBN4annsbR8Lm8CcfiGJSAYFqGLn09vjYgXv6kYzh+SrunYHhoPXtkdmEf0xWSZBv9vdEiZEUVT2kUPd4G89LT/jmXooe3ZOP8+og2vAa6/E6p6huSJAFK9oEsUZSIQf+GjdHL/fB9I+ng7Gmo74Kol7kQD3/5WLmH11H1oaUjUntbxq9J+7iDGMHbBatwO3tP1D/ZtFkM1oXFGFQGW1LjwrYVQsSrBG8tV6RsA4F0wj9zFeOa2WEMcyc30Ab+A/H8HNIhXfCwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkpT9wWbc97uFxprOB/bSfRZ65XULBFGy7TIVEX9WxE=;
 b=C/qM+rLghK/0VO8mZJEmX0q1OfbhJv9T5TxibXGFYWDZyi1Y4lT4ngG05SYXa79Fau3Nh4b5a+6ETKqSKVffY3PlQNtWPTtiEzdpno+/38XSRdkj1Sq4sUIgHN2p7BDOX5J98thr2ixVt8mxxUkjoBYpAlT6bo3tv5OAJGPLvkVO19m23RV/XCsTZ8Psi1C3N7+CrVgQtfhXLgborEacY0pqD1bZai2PjMG8xS7Pvmg0r3uNc4yvqa1IbDeGAUh16OL/23aKezCiTZ+qOpYFsPfgo6FozzCT03Qo5hCsh0N4h+8IfUCpfAfHdE63iwkJjy1gAOIEPnichTncEbsHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 10:11:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 10:11:58 +0000
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
        "Christopherson,, Sean" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaA2fwP2oxJW5BTEmP/QrJKHzACbBYvjeA
Date:   Tue, 24 Oct 2023 10:11:58 +0000
Message-ID: <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
         <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5641:EE_
x-ms-office365-filtering-correlation-id: 458e3be2-8f02-42b1-95b1-08dbd479a861
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9Gf7d8QhlKoUiX/q0phbm/BvAX4vM0/LJWhCrMRcAvcscD0WUCJ4DtZy08ru1Yw7VYYb+SQC+Ez57yJ3RH3h16KePluVQ281lguGOx0+Bldc9bmxJ0ucnJn5/P+7eNQF1++dYUI6qXIkdkGl176tN7RfKSt3V8n1dwp9QZ2CVX6Pk1AK+kU1euD8hOJuvEdYEeafv9RRx9eWoPWZWQTmckUaJsVmzRatgIWyjpTy3T8h1KSrqmv8aqIF5JZntXjdgbyqq3AUu+EM5GFbom1Mfwaqks9nEq5LEIObFe3LWm2VlaWMYwNJI2/kvzVGyMSb5gAL5qtPPTw/1Jd0aq1bQID1GPRb5/1helPVYTZvQcmtB5d4buGCyjUwO1UbyTuG2ZlL3uLmXOTBYNj8RSwbQ0ojwgXia8dAhYsB4A/UMX8699eZ1MQYZTOkELz7crhiVVCtsXqCLn5guk9yD9X3aa/pzow4aEErUmEquAf8Zlp9Dd3/k583LmUT3cpy2mu/jW4RKEqCuz2hL8cVC23CwzpqnUMbGHZ9VVY/IUZaGH3GeYYRB72DZdL1ZKtobjFVeqbvGkLhWM+FlQYudrNlhL2mCjwpjUdP3TvvTutR56BM+yrCZT96kBdMKSvEh0J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(7416002)(8936002)(4326008)(8676002)(41300700001)(38070700009)(2906002)(5660300002)(110136005)(71200400001)(122000001)(6512007)(82960400001)(6506007)(36756003)(2616005)(83380400001)(86362001)(91956017)(76116006)(38100700002)(66946007)(26005)(66556008)(54906003)(66446008)(6486002)(66476007)(64756008)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0l1bCtMZUVicU9lZzBES3JOSlA3S2xoY1E5WGJnbGxGRHRPSmFSVFVoaDNx?=
 =?utf-8?B?cnNPemdGVVhhZUZtaHV0eTNZUmVSTng3MjdGcjREWHVJajhtdUVIMStpOGZp?=
 =?utf-8?B?NGY5UkprVXkvWDdzblBCdGVUZEtGVDBmTVlrdXpydU4wTlI1SHhTendzOXln?=
 =?utf-8?B?U3RrNytCQm8rQUVHWk9SY0pNYUxBazVJVXRKQm43MXFFK0MrWnNvTEJ3aGdy?=
 =?utf-8?B?enppcjR4TXlwOFZHY0xNaGRnOWhJVUhranpVTXkySisxeHZOVTJCc3NBdzJy?=
 =?utf-8?B?ZXJFZC9LUHcxNzA1cEU0cEY4aXFQYzMxd2pseS9IT2xMZUlXZzAxbTJtaVdP?=
 =?utf-8?B?MytFY2tSMG83dTNLTER5aERlRklNaGk2Qjhta3ZmNVdzSHhjemFvTXFhOFBH?=
 =?utf-8?B?cThDb1hRandZY2dzNEVxa1FEUlN4M0hIem5MRmlkUnlJRzh0Y0RsQjZaWjJo?=
 =?utf-8?B?dGNZeXJmdDR1d0R0V2NDREF4WDZYV3I0ZGpwdzI5eUtudWZ0cGZub0h6UEk2?=
 =?utf-8?B?cWJ0aERiZTI3cFJRZ1h5SFZCVlRBUi9WK040b1RseURTMjcramZqWlRxRk9G?=
 =?utf-8?B?OE9YMFc1emVvUEtpMDlUc2xlalBmRitINUl1TlFycyt3UDR0N2k3eVRxOWlo?=
 =?utf-8?B?amd1cmlPS09JK2Q2cnBUUHVRNUJGSUVtZmwyeWRVSWFzNzZFc0VhT3N4WmtY?=
 =?utf-8?B?ZzU2c296czZUVzRyTm93QUt1VHdwYkdvODkyQXh1SmgyaHpiRVVlQW03dFow?=
 =?utf-8?B?UWVPdVNJbkswam1RUnFyazdnMHhFc01CVHNXQmlQK1RuR0ZtUTBKc0ZrQlJw?=
 =?utf-8?B?S3hQQUcrZ0FNcVhWRlBNcHFaSFFVaVcyU0dYemVEc0NuOWdCakpUUkxxVHdC?=
 =?utf-8?B?QXp3eGlScUVMSElCU1MyeXc3ZTE2OEtVaW43NFZCdUpnSnFCay90a0x1L0pI?=
 =?utf-8?B?YkU0NUxSUTVHNC9UWC9TRVJhaHh2NUhRZ0QrTGxpTWJONUQvZE5EUDI3dGor?=
 =?utf-8?B?djJGK0g3TXk3VmdWcEp5OTZaTlBZdmw1ZFc4aU5NWGY2L3JRdFdZOVBleTNu?=
 =?utf-8?B?d3dNRnpER056c3BiRjMzTzkxdm8wV3VZSGIxaTJMbHJXTDYwWERmUGo5UlU0?=
 =?utf-8?B?VTBHOFlvalMwOFNoM0tXOEt3a2JRTXRTMnRzMVk4U3htdFdYTFFOK1JlVERZ?=
 =?utf-8?B?dDk0QnpFSGRLdkNFNUY3MGYxdVlTV2ozUW11dk0zd2d0L1pqaEhxNWg0ZWF6?=
 =?utf-8?B?Mi8rbEVlZDd4QzVnREhnSVVteVVZeVE5dU42NVQxV2VVcWZ2d0d0Mnc2N1l3?=
 =?utf-8?B?bnFBV3FMNXhaeURnRnhtTnJWVS9nK3RpT0hoVmpSMEd2TUxUOGZOMEI2Y1Av?=
 =?utf-8?B?NERjMkE0K2poNFVBKzQvWngrZUQxd0FKeElncCtkRjNIbEpTZmE3d0NZRDhJ?=
 =?utf-8?B?N29WZFZEMURyai9oK09zanFWL1MrdkNRajdncHlqYVVvMzFZS1JtS2R1dnl0?=
 =?utf-8?B?Vm5pV0puWEdwakEvckxwQU16MU95eWdIUGs1dUVmVytiak9nSXpidHpyVG1K?=
 =?utf-8?B?RVRmRmxMbXE4dGEybDlqQzROZERpL1NrQjh4di9LSlRtY1NwNnIwdjVsUlFQ?=
 =?utf-8?B?ZkRPcEZYVmpIZjFPdnptK1I2Zm9NOWdGajdFeUZqNFFrYzZqUWFVdkFkWkJC?=
 =?utf-8?B?bmFSNjlySEpPbU5pNDNOb3llZCs5dlRXc2lHRGt5Q2JveVBoWU5PRmNQUVZR?=
 =?utf-8?B?SmNjeXQyNlNXb3ZEbGIzTDNnMkF5VEJwR2NCUUZWN2Vod2pWQnVtMklLQlNM?=
 =?utf-8?B?OXhZR1hZNTZiSVZrLzJZQkpLSCtRNkpWL1p4NXcwYmJYaVlUSlcrOHB3eXlR?=
 =?utf-8?B?M1AyRDdGRkNCeVA4Y2R2MGd2QnBVK1lxM2UrMmNWK3R6U3FjajM0dUc5UkVy?=
 =?utf-8?B?YzRkQTh0VHNKL3ZWN2FxY1lBRXRmS1BOaXhGYU1nbU4xTmRVcFBWSktxUDFC?=
 =?utf-8?B?TW1EQTBXVDBCRDFJb0xXZWl4cFl3RDZFc3FNTW5mN1Zod2dxYXVsbjdvM2Mw?=
 =?utf-8?B?bjVjaVk4emRQWFhPOWE2QnljUGVEOU9mUGxXc3pIVVFsNzFvc3VBandIakdI?=
 =?utf-8?B?U1NaR0RjRWo2SkpFemJiSlFWR1JLYWp1SERlbFQ3ejZTOSt6V09oeE9jQ1ht?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14BB5900AF5CC94796C831EA24564EC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e3be2-8f02-42b1-95b1-08dbd479a861
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:11:58.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeRvqQeHZ0eS9wJw1pZsjOrmrjVVUttPOOYebj84ba+F0FggMY9MDxMJ19EyJABvEpkoZ3CAUgLBaRRfYxdHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdC5TDQoN
CkkgdGhpbmsgdGhlIG5hbWUgJ21hZHQuUycgaXMgdG9vIGdlbmVyaWMuICBIb3cgYWJvdXQgc29t
ZXRoaW5nIGJlIG1vcmUgc3BlY2lmaWMNCnN1Y2ggYXMgbWFkdF9yZXNldC5TLCBvciBtYWR0X3Bs
YXlkZWFkLlMsIGV0Yz8gDQoNCj4gQEAgLTAsMCArMSwyNCBAQA0KPiArI2luY2x1ZGUgPGxpbnV4
L2xpbmthZ2UuaD4NCj4gKyNpbmNsdWRlIDxhc20vbm9zcGVjLWJyYW5jaC5oPg0KPiArI2luY2x1
ZGUgPGFzbS9wYWdlX3R5cGVzLmg+DQo+ICsjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci1mbGFncy5o
Pg0KPiArDQo+ICsJLnRleHQNCj4gKwkuYWxpZ24gUEFHRV9TSVpFDQo+ICtTWU1fRlVOQ19TVEFS
VChhc21fYWNwaV9tcF9wbGF5X2RlYWQpDQo+ICsJLyogTG9hZCBhZGRyZXNzIG9mIHJlc2V0IHZl
Y3RvciBpbnRvIFJDWCB0byBqdW1wIHdoZW4ga2VybmVsIGlzIHJlYWR5ICovDQo+ICsJbW92cQlh
Y3BpX21wX3Jlc2V0X3ZlY3Rvcl9wYWRkciglcmlwKSwgJXJjeA0KPiArDQo+ICsJLyogVHVybiBv
ZmYgZ2xvYmFsIGVudHJpZXMuIEZvbGxvd2luZyBDUjMgd3JpdGUgd2lsbCBmbHVzaCB0aGVtLiAq
Lw0KPiArCW1vdnEJJWNyNCwgJXJkeA0KPiArCWFuZHEJJH4oWDg2X0NSNF9QR0UpLCAlcmR4DQo+
ICsJbW92cQklcmR4LCAlY3I0DQo+ICsNCj4gKwkvKiBTd2l0Y2ggdG8gaWRlbnRpdHkgbWFwcGlu
ZyAqLw0KPiArCW1vdnEJYWNwaV9tcF9wZ2QoJXJpcCksICVyYXgNCj4gKwltb3ZxCSVyYXgsICVj
cjMNCg0KRG8gd2UgbmVlZCB0byBzd2l0Y2ggYmFjayB0byBrZXJuZWwgZGlyZWN0LW1hcCBwYWdl
IHRhYmxlIGFmdGVyIENQVSBpcyB3YWtlIHVwDQphZ2Fpbj8gIFdlIGRvIHN1cHBvcnQgbm9ybWFs
IENQVSBvZmZsaW5lL29ubGluZSwgYnV0IG5vdCBsaW1pdGVkIHRvIGtleGVjLA0KcmlnaHQ/DQoN
Cj4gKw0KPiArCS8qIEp1bXAgdG8gcmVzZXQgdmVjdG9yICovDQo+ICsJQU5OT1RBVEVfUkVUUE9M
SU5FX1NBRkUNCj4gKwlqbXAJKiVyY3gNCj4gK1NZTV9GVU5DX0VORChhc21fYWNwaV9tcF9wbGF5
X2RlYWQpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dha2V1cC5j
IGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF93YWtldXAuYw0KPiBpbmRleCBhZDE3MGRlZjIz
NjcuLmY5ZmYxNGVlMjg5MiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvbWFk
dF93YWtldXAuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dha2V1cC5jDQo+
IEBAIC0xLDggKzEsMTMgQEANCj4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvY3B1Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC9pby5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvcGd0YWJsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2hvdHBsdWcuaD4N
Cj4gICNpbmNsdWRlIDxhc20vYXBpYy5oPg0KPiAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+
ICsjaW5jbHVkZSA8YXNtL2luaXQuaD4NCj4gICNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+
ICANCj4gIC8qIFBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIE11bHRpcHJvY2Vzc29yIFdha2V1cCBT
dHJ1Y3R1cmUgbWFpbGJveCAqLw0KPiBAQCAtMTEsNiArMTYsMTUwIEBAIHN0YXRpYyB1NjQgYWNw
aV9tcF93YWtlX21haWxib3hfcGFkZHI7DQo+ICAvKiBWaXJ0dWFsIGFkZHJlc3Mgb2YgdGhlIE11
bHRpcHJvY2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUgbWFpbGJveCAqLw0KPiAgc3RhdGljIHN0cnVj
dCBhY3BpX21hZHRfbXVsdGlwcm9jX3dha2V1cF9tYWlsYm94ICphY3BpX21wX3dha2VfbWFpbGJv
eDsNCj4gIA0KPiArdTY0IGFjcGlfbXBfcGdkOw0KPiArdTY0IGFjcGlfbXBfcmVzZXRfdmVjdG9y
X3BhZGRyOw0KPiArDQo+ICt2b2lkIGFzbV9hY3BpX21wX3BsYXlfZGVhZCh2b2lkKTsNCj4gKw0K
PiArc3RhdGljIHZvaWQgX19pbml0ICphbGxvY19wZ3RfcGFnZSh2b2lkICpjb250ZXh0KQ0KPiAr
ew0KPiArCXJldHVybiBtZW1ibG9ja19hbGxvYyhQQUdFX1NJWkUsIFBBR0VfU0laRSk7DQo+ICt9
DQo+ICsNCj4gKy8qDQo+ICsgKiBNYWtlIHN1cmUgYXNtX2FjcGlfbXBfcGxheV9kZWFkKCkgaXMg
cHJlc2VudCBpbiB0aGUgaWRlbnRpdHkgbWFwcGluZyBhdA0KPiArICogdGhlIHNhbWUgcGxhY2Ug
YXMgaW4gdGhlIGtlcm5lbCBwYWdlIHRhYmxlcy4gVGhlIGZ1bmN0aW9uIHN3aXRjaGVzIHRvDQo+
ICsgKiB0aGUgaWRlbnRpdHkgbWFwcGluZ8KgDQo+IA0KDQpUaGlzIGZ1bmN0aW9uIGl0c2VsZiBk
b2Vzbid0IHN3aXRjaCB0byB0aGUgaWRlbnRpdHkgbWFwcGluZy4gIEl0IGp1c3QgY3JlYXRlcw0K
dGhlIGtlcm5lbCBtYXBwaW5nIGZvciBhc21fYWNwaV9tcF9wbGF5X2RlYWQoKSBpbiB0aGUgaWRl
bnRpZnkgbWFwcGluZyBwYWdlDQp0YWJsZS4NCg0KPiBhbmQgaGFzIGJlIHByZXNlbnQgYXQgdGhl
IHNhbWUgc3BvdCBpbiBiZWZvcmUgYW5kDQo+ICsgKiBhZnRlciB0cmFuc2l0aW9uLg0KDQpUaGlz
IHBhcnQgZG9lc24ndCBwYXJzZSB0byBtZS4gIEkgZ3Vlc3MgdGhlIHdob2xlIGNvbW1lbnQgY2Fu
IGJlOg0KDQoJYXNtX2FjcGlfbXBfcGxheV9kZWFkKCkgaXMgYWNjZXNzZWQgYm90aCBiZWZvcmUg
YW5kIGFmdGVyIHN3aXRjaGluZyB0b8KgDQoJdGhlIGlkZW50aXR5IG1hcHBpbmcuICBBbHNvIG1h
cCBpdCBhdCB0aGUga2VybmVsIHZpcnR1YWwgYWRkcmVzcyBpbg0KCXRoZSBpZGVudGl0eSBtYXBw
aW5nIHRhYmxlLg0KDQpPciBwZXJoYXBzIGV2ZW4gYmV0dGVyLCBwdXQgdGhlIGFib3ZlIGNvbW1l
bnRzIHRvIHRoZSBwbGFjZSB3aGVyZSB0aGlzIGZ1bmN0aW9uDQppcyBjYWxsZWQ/DQoNCj4gKyAq
Lw0KPiArc3RhdGljIGludCBfX2luaXQgaW5pdF90cmFuc2l0aW9uX3BndGFibGUocGdkX3QgKnBn
ZCkNCj4gK3sNCj4gKwlwZ3Byb3RfdCBwcm90ID0gUEFHRV9LRVJORUxfRVhFQ19OT0VOQzsNCj4g
Kwl1bnNpZ25lZCBsb25nIHZhZGRyLCBwYWRkcjsNCj4gKwlpbnQgcmVzdWx0ID0gLUVOT01FTTsN
Cj4gKwlwNGRfdCAqcDRkOw0KPiArCXB1ZF90ICpwdWQ7DQo+ICsJcG1kX3QgKnBtZDsNCj4gKwlw
dGVfdCAqcHRlOw0KPiArDQo+ICsJdmFkZHIgPSAodW5zaWduZWQgbG9uZylhc21fYWNwaV9tcF9w
bGF5X2RlYWQ7DQo+ICsJcGdkICs9IHBnZF9pbmRleCh2YWRkcik7DQo+ICsJaWYgKCFwZ2RfcHJl
c2VudCgqcGdkKSkgew0KPiArCQlwNGQgPSAocDRkX3QgKilhbGxvY19wZ3RfcGFnZShOVUxMKTsN
Cj4gKwkJaWYgKCFwNGQpDQo+ICsJCQlnb3RvIGVycjsNCj4gKwkJc2V0X3BnZChwZ2QsIF9fcGdk
KF9fcGEocDRkKSB8IF9LRVJOUEdfVEFCTEUpKTsNCj4gKwl9DQo+ICsJcDRkID0gcDRkX29mZnNl
dChwZ2QsIHZhZGRyKTsNCj4gKwlpZiAoIXA0ZF9wcmVzZW50KCpwNGQpKSB7DQo+ICsJCXB1ZCA9
IChwdWRfdCAqKWFsbG9jX3BndF9wYWdlKE5VTEwpOw0KPiArCQlpZiAoIXB1ZCkNCj4gKwkJCWdv
dG8gZXJyOw0KPiArCQlzZXRfcDRkKHA0ZCwgX19wNGQoX19wYShwdWQpIHwgX0tFUk5QR19UQUJM
RSkpOw0KPiArCX0NCj4gKwlwdWQgPSBwdWRfb2Zmc2V0KHA0ZCwgdmFkZHIpOw0KPiArCWlmICgh
cHVkX3ByZXNlbnQoKnB1ZCkpIHsNCj4gKwkJcG1kID0gKHBtZF90ICopYWxsb2NfcGd0X3BhZ2Uo
TlVMTCk7DQo+ICsJCWlmICghcG1kKQ0KPiArCQkJZ290byBlcnI7DQo+ICsJCXNldF9wdWQocHVk
LCBfX3B1ZChfX3BhKHBtZCkgfCBfS0VSTlBHX1RBQkxFKSk7DQo+ICsJfQ0KPiArCXBtZCA9IHBt
ZF9vZmZzZXQocHVkLCB2YWRkcik7DQo+ICsJaWYgKCFwbWRfcHJlc2VudCgqcG1kKSkgew0KPiAr
CQlwdGUgPSAocHRlX3QgKilhbGxvY19wZ3RfcGFnZShOVUxMKTsNCj4gKwkJaWYgKCFwdGUpDQo+
ICsJCQlnb3RvIGVycjsNCj4gKwkJc2V0X3BtZChwbWQsIF9fcG1kKF9fcGEocHRlKSB8IF9LRVJO
UEdfVEFCTEUpKTsNCj4gKwl9DQo+ICsJcHRlID0gcHRlX29mZnNldF9rZXJuZWwocG1kLCB2YWRk
cik7DQo+ICsNCj4gKwlwYWRkciA9IF9fcGEodmFkZHIpOw0KPiArCXNldF9wdGUocHRlLCBwZm5f
cHRlKHBhZGRyID4+IFBBR0VfU0hJRlQsIHByb3QpKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAr
ZXJyOg0KPiArCXJldHVybiByZXN1bHQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGFjcGlf
bXBfcGxheV9kZWFkKHZvaWQpDQo+ICt7DQo+ICsJcGxheV9kZWFkX2NvbW1vbigpOw0KPiArCWFz
bV9hY3BpX21wX3BsYXlfZGVhZCgpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBhY3BpX21w
X2NwdV9kaWUodW5zaWduZWQgaW50IGNwdSkNCj4gK3sNCj4gKwlpbnQgYXBpY2lkID0gcGVyX2Nw
dSh4ODZfY3B1X3RvX2FwaWNpZCwgY3B1KTsNCj4gKwl1bnNpZ25lZCBsb25nIHRpbWVvdXQ7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIFVzZSBURVNUIG1haWxib3ggY29tbWFuZCB0byBwcm92ZSB0aGF0
IEJJT1MgZ290IGNvbnRyb2wgb3Zlcg0KPiArCSAqIHRoZSBDUFUgYmVmb3JlIGRlY2xhcmluZyBp
dCBkZWFkLg0KPiArCSAqDQo+ICsJICogQklPUyBoYXMgdG8gY2xlYXIgJ2NvbW1hbmQnIGZpZWxk
IG9mIHRoZSBtYWlsYm94Lg0KPiArCSAqLw0KPiArCWFjcGlfbXBfd2FrZV9tYWlsYm94LT5hcGlj
X2lkID0gYXBpY2lkOw0KPiArCXNtcF9zdG9yZV9yZWxlYXNlKCZhY3BpX21wX3dha2VfbWFpbGJv
eC0+Y29tbWFuZCwNCj4gKwkJCSAgQUNQSV9NUF9XQUtFX0NPTU1BTkRfVEVTVCk7DQo+ICsNCj4g
KwkvKiBEb24ndCB3YWl0IGxvbmdlciB0aGFuIGEgc2Vjb25kLiAqLw0KPiArCXRpbWVvdXQgPSBV
U0VDX1BFUl9TRUM7DQo+ICsJd2hpbGUgKFJFQURfT05DRShhY3BpX21wX3dha2VfbWFpbGJveC0+
Y29tbWFuZCkgJiYgdGltZW91dC0tKQ0KPiArCQl1ZGVsYXkoMSk7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyB2b2lkIGFjcGlfbXBfc3RvcF9vdGhlcl9jcHVzKGludCB3YWl0KQ0KPiArew0KPiArCXNt
cF9zaHV0ZG93bl9ub25ib290X2NwdXMoc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4gK30NCj4gKw0K
PiArc3RhdGljIHZvaWQgYWNwaV9tcF9jcmFzaF9zdG9wX290aGVyX2NwdXModm9pZCkNCj4gK3sN
Cj4gKwlzbXBfc2h1dGRvd25fbm9uYm9vdF9jcHVzKHNtcF9wcm9jZXNzb3JfaWQoKSk7DQo+ICsN
Cj4gKwkvKiBUaGUga2VybmVsIGlzIGJyb2tlbiBzbyBkaXNhYmxlIGludGVycnVwdHMgKi8NCj4g
Kwlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBh
Y3BpX21wX3NldHVwX3Jlc2V0KHU2NCByZXNldF92ZWN0b3IpDQo+ICt7DQo+ICsJcGdkX3QgKnBn
ZDsNCj4gKwlzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyBpbmZvID0gew0KPiArCQkuYWxsb2NfcGd0
X3BhZ2UgPSBhbGxvY19wZ3RfcGFnZSwNCj4gKwkJLnBhZ2VfZmxhZyAgICAgID0gX19QQUdFX0tF
Uk5FTF9MQVJHRV9FWEVDLA0KPiArCQkua2VybnBnX2ZsYWcgICAgPSBfS0VSTlBHX1RBQkxFX05P
RU5DLA0KPiArCX07DQo+ICsNCj4gKwlwZ2QgPSBhbGxvY19wZ3RfcGFnZShOVUxMKTsNCj4gKw0K
PiArCWZvciAoaW50IGkgPSAwOyBpIDwgbnJfcGZuX21hcHBlZDsgaSsrKSB7DQo+ICsJCXVuc2ln
bmVkIGxvbmcgbXN0YXJ0LCBtZW5kOw0KPiArCQltc3RhcnQgPSBwZm5fbWFwcGVkW2ldLnN0YXJ0
IDw8IFBBR0VfU0hJRlQ7DQo+ICsJCW1lbmQgICA9IHBmbl9tYXBwZWRbaV0uZW5kIDw8IFBBR0Vf
U0hJRlQ7DQo+ICsJCWlmIChrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KCZpbmZvLCBwZ2QsIG1z
dGFydCwgbWVuZCkpDQo+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gKwl9DQoNClRoaXMgaXMgZm9y
IGtleGVjKCkgSUlVQy4gIEFkZCBhIGNvbW1lbnQ/DQoNCklmIHdlIGNvbnNpZGVyIG5vcm1hbCBD
UFUgb2ZmbGluZS9vbmxpbmUgY2FzZSwgdGhlbiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdGhlDQpp
ZGVudGl0eSBtYXBwaW5nIGZvciBhbGwgbWVtb3J5Pw0KDQo+ICsNCj4gKwlpZiAoa2VybmVsX2lk
ZW50X21hcHBpbmdfaW5pdCgmaW5mbywgcGdkLA0KPiArCQkJCSAgICAgIFBBR0VfQUxJR05fRE9X
TihyZXNldF92ZWN0b3IpLA0KPiArCQkJCSAgICAgIFBBR0VfQUxJR04ocmVzZXRfdmVjdG9yICsg
MSkpKSB7DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArCX0NCj4gKw0KPiArCWlmIChpbml0X3Ry
YW5zaXRpb25fcGd0YWJsZShwZ2QpKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXNt
cF9vcHMucGxheV9kZWFkID0gYWNwaV9tcF9wbGF5X2RlYWQ7DQo+ICsJc21wX29wcy5jcHVfZGll
ID0gYWNwaV9tcF9jcHVfZGllOw0KPiArCXNtcF9vcHMuc3RvcF9vdGhlcl9jcHVzID0gYWNwaV9t
cF9zdG9wX290aGVyX2NwdXM7DQo+ICsJc21wX29wcy5jcmFzaF9zdG9wX290aGVyX2NwdXMgPSBh
Y3BpX21wX2NyYXNoX3N0b3Bfb3RoZXJfY3B1czsNCj4gKw0KPiArCWFjcGlfbXBfcmVzZXRfdmVj
dG9yX3BhZGRyID0gcmVzZXRfdmVjdG9yOw0KPiArCWFjcGlfbXBfcGdkID0gX19wYShwZ2QpOw0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgYWNwaV93YWtldXBf
Y3B1KGludCBhcGljaWQsIHVuc2lnbmVkIGxvbmcgc3RhcnRfaXApDQo+ICB7DQo+ICAJaWYgKCFh
Y3BpX21wX3dha2VfbWFpbGJveF9wYWRkcikgew0KPiBAQCAtNzQsMzEgKzIyMyw0MyBAQCBpbnQg
X19pbml0IGFjcGlfcGFyc2VfbXBfd2FrZSh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhl
YWRlciwNCj4gIAlzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXAgKm1wX3dha2U7DQo+
ICANCj4gIAltcF93YWtlID0gKHN0cnVjdCBhY3BpX21hZHRfbXVsdGlwcm9jX3dha2V1cCAqKWhl
YWRlcjsNCj4gLQlpZiAoQkFEX01BRFRfRU5UUlkobXBfd2FrZSwgZW5kKSkNCj4gKwlpZiAoIW1w
X3dha2UpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKGVuZCAtICh1bnNpZ25l
ZCBsb25nKW1wX3dha2UgPCBBQ1BJX01BRFRfTVBfV0FLRVVQX1NJWkVfVjApDQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArCWlmIChtcF93YWtlLT5oZWFkZXIubGVuZ3RoIDwgQUNQSV9NQURUX01Q
X1dBS0VVUF9TSVpFX1YwKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAgCWFjcGlfdGFi
bGVfcHJpbnRfbWFkdF9lbnRyeSgmaGVhZGVyLT5jb21tb24pOw0KPiAgDQo+ICAJYWNwaV9tcF93
YWtlX21haWxib3hfcGFkZHIgPSBtcF93YWtlLT5tYWlsYm94X2FkZHJlc3M7DQo+ICANCj4gLQlj
cHVfaG90cGx1Z19kaXNhYmxlX29mZmxpbmluZygpOw0KPiArCWlmIChtcF93YWtlLT52ZXJzaW9u
ID49IEFDUElfTUFEVF9NUF9XQUtFVVBfVkVSU0lPTl9WMSAmJg0KPiArCSAgICBtcF93YWtlLT5o
ZWFkZXIubGVuZ3RoID49IEFDUElfTUFEVF9NUF9XQUtFVVBfU0laRV9WMSkgew0KPiArCQlhY3Bp
X21wX3NldHVwX3Jlc2V0KG1wX3dha2UtPnJlc2V0X3ZlY3Rvcik7DQoNCkl0J3MgYmV0dGVyIHRv
IGZhbGxiYWNrIHRvICJkaXNhYmxlIG9mZmxpbmUiIGlmIHRoaXMgZnVuY3Rpb24gZmFpbHMuDQoN
Cg==
