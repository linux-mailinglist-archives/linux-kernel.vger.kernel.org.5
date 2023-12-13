Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E61811FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442559AbjLMU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:29:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562A9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702499365; x=1734035365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y/GgqtZFtjFtGHLnwFuWGue0lIOgtEZiSbGRSjzb7b8=;
  b=kPL/bkGNF4gxZMECxHtPFfxqEWGDJ5LRup1VjSYRVpxcTJ1gXU3KDLvh
   5Q55xTEVMbLGGzuZEySRmp7Dz3UPkj7+grPlqfr8W0aqJYytSghSStLFK
   QYPf0tzQfD9ykRqg6gsPGdkBN7vCpm6FYBxf2VPH0g1BKyvYcDAiHPx/R
   52jTHG2qCDJuvO0lMGSD5eZG1UD6nMXBfnxF9DmviG4aqjs5pon7lqhfn
   yQxAQvooWIAtarr9oaBb21lVCEeriIVapEvBZfPui2TpSRQMMS0wfDnB1
   bmxmZCnKhIJ31MEcbuigAzzQ0o9ToNQHjzMkXgbT0P53otpdJb+h/mLlj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392198270"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="392198270"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 12:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="15569267"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 12:29:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 12:29:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 12:29:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 12:29:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idwfoen8TUeWYFIvvm4I6gXJVyNIM5MBWxRcxEk01urdGEa0vds569A7a1gH3n5reoN/oRm/3rw2BJsolvez2j7GNfvc0vVpDeEkIetfFqQoHNw5UxMEOoIK56NfixcRAo/ZFQR9WD7SmBDcJpM7CKexYvkM6G+fRYiQWb8qXiyfaZsDiuG+4rcjoEON3SmSPe3O5aHSKwp/XrSVcLmsonP9eQGDjjzP0aX9SIOsAbC/Dti4JVjLEqHDmG/AQUJ2u8YV9c8R2iWgWkneT6m+H79TYef2wCZPzo0OmDO88KngRlLjGYH6vTlEAtWHlOGHQM1a0SSIX1j/cL1CJatDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/GgqtZFtjFtGHLnwFuWGue0lIOgtEZiSbGRSjzb7b8=;
 b=k6y/2g6HHE3kRoOsoK5XDRNtfN2Rsis8Uc7AVB3xUIoNpuly3cr55gqj8Om9/6bi6fkMmwk3DNWr9PRjamgPGy1ffRM0RkVZT1AReiuChN6/ghskvE33TQPpGS/F0wGaI8fcVAC4D07NQrTQj6xLdy6Ne4lDcgPJUrwv/chzqvihDxtrhCoGOjEzXOISMpJfdvSMQwyL5FEVXWrfzyMPYvSXSSPBkke1XAZ//xLefsrV2iSeGIYF81rEkJHWe8dg36F6uk0UulihoD0WSxcDW6vy4sPzy1ZM7M5hhCE+GqFlbILOBjZ+tV7O9dlWNFLAt1UXMsX3S8KojmG3EBU0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 20:29:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 20:29:21 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "arnd@kernel.org" <arnd@kernel.org>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Topic: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Index: AQHaLUNkbx3M70MeHUWOqNlrwdFerLCmLZaAgADwT4CAAIicgIAAAJUAgAAEeYA=
Date:   Wed, 13 Dec 2023 20:29:21 +0000
Message-ID: <bd82d390b22e9c10dfdffefa49e44d2cc9a6a2ef.camel@intel.com>
References: <20231212213701.4174806-1-arnd@kernel.org>
         <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
         <20231213120215.64wcryk5k75cymop@box>
         <044e2990b5ca28d04c7305de3d2d412071975ec1.camel@intel.com>
         <de67b856-369c-41a2-8835-d25641eaeab6@intel.com>
In-Reply-To: <de67b856-369c-41a2-8835-d25641eaeab6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4738:EE_
x-ms-office365-filtering-correlation-id: 199785c7-7640-48e5-d110-08dbfc1a3078
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGo4kc+tyqHebdHn+VD0hfIRnOlLCp3RMVOOn3KtNuk50OGZNs8VWybA3q9uBGZqNZOzRn+kbog3/YG3VwJiilnoAZCvDNM9n9qZ5gaRx+lEp2iBTGd0Mpz7oFXv++Ut95n5IPJfrnXDqRrXRSyzN9KkRnMWneg9rp1j9OVtLt7kvYkhVgy04mpTCxb19I7rZwmfU4IhIb/Swyfa4Z9garkYwb9RfkH58mqbIDuibiUH+5RVsjZI+8R0DzgPPCxIp2WtciZ8Mhnrjv2endPAnnsIrZPjCp371CUSIwSzjz9qbp0BUinhHt1+capPaZ0ecJqt7hmlfzRwAWp/B1HUYp/OAb8+/QzrtdeN9JJhmTPcK+92bfb7M18aAMA6/JtUBQlndSyBDbG4G0EbaA3UOfZwJOSyMySweql8sIa2Cr1WRXBw0/lbIvcDqh0lbhVXMwGjm+VUk9jfWb92pLnilkwXwJcPNHCMyyYYBUrrRYtlaayfiDErYrGWd/JQ90vc7Ja3PIDI9EvB2r0qYyYDV7B0A6sGsLtBVf/ZI32mlyVe5j9Q4vzHj3tmxPCP1Qg80O5F4P7znzXKHBBDYId9htpih9mT2inD8gyy9Vx3ULa6km5DBrihabiG5P6pOM+5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(7416002)(5660300002)(66446008)(66476007)(66556008)(66946007)(54906003)(64756008)(91956017)(110136005)(76116006)(6636002)(316002)(4326008)(8676002)(8936002)(478600001)(82960400001)(2906002)(4744005)(122000001)(2616005)(6486002)(36756003)(38100700002)(4001150100001)(6506007)(53546011)(41300700001)(86362001)(6512007)(71200400001)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlIeGdhUVdFUVFWZTcwV0p6MUtPYUZwajNyeDkzdk9JeFMyVFhITTdXbURC?=
 =?utf-8?B?empqVndCcTd4RFhXdDF6WTFrZGIyR1NPNkdrZHF3eWtBQVhONEhxUmgrVCth?=
 =?utf-8?B?TmlTbGNLRUsrbC9YOVNGaWdZeDhHbzkxUmdmdmFTNXVLaElrRDgvSHRmbDFS?=
 =?utf-8?B?Q1pCOVQwQ1BzQm15QVlic3g1TDdEajZaYVVvaFBDck95UTBoLy9CeUFGa0M3?=
 =?utf-8?B?ZzZUb083eFhqclJZVTB4UGlNZGNmNFpSU1cxWnJvcWRZRUp0dk96SXJZWkZV?=
 =?utf-8?B?L1NldDJGSzg4dFpqVi84SzZqeUlMNnJQTTFBcUJPK0w5emlkNVcyWkV4YmdK?=
 =?utf-8?B?V1J2aGJTSG84eDdFVWZjL09ZZDdCQUR5YXQwdW1XRzhNYm5LdjRYUUU2Yldk?=
 =?utf-8?B?WDZiNW9hempnQ2h5M3dRKzNJbEFGTklaSDhrMXdOMDFvbUE0RWtxM0xtd1do?=
 =?utf-8?B?QWNaZkIybnl6dFFKM2pmUU1mZ29CODBmb3A0OHFudU1qRHJUZTdPUHRJYzl5?=
 =?utf-8?B?TnpXcHpLTFEvTytjVEZiMDB4ZEFyUHVJUUduSlVjVDRyWDB1NHczVU4wZXVE?=
 =?utf-8?B?anpGZ0R2cXBGckRhTmN1NjlHdVlZQWZFcWF4RXlOSnE2OTZtWmMxTXdscEFZ?=
 =?utf-8?B?VS9MWnVJcjVUQWIxRHIwU05VMFEyZnY4a3NzVmI0YUx0TWZMeHBLSi9nQjk5?=
 =?utf-8?B?Ujh3Qm9OVEgwOHVWTUwvKzBVM2FnNTQ5NUJTZ29MRUMwQTBCRVpNck5ienI1?=
 =?utf-8?B?NnU0b0RrTHNBNHh6VU9aQkM0Zno2b2tPb3FNZnhRY3FXRm1nbzVvaVJpN3JK?=
 =?utf-8?B?WlYxVEhjYUkxdEpiQWNwNEpHRGhRYnNzTmdLYW95VEJSdlR0MVZSZk5vME9n?=
 =?utf-8?B?UXlabE1JMWNDZ1JVb2VQV1hETU5BZ1l4dGRDdFJQRVdkMWpBcWV3VEoyb24r?=
 =?utf-8?B?bFk1Y1o3Y3JMSnNVSUx5QndDWVhVeTM1aUVIV09Zem4xQVNRK3NlZDVjT08v?=
 =?utf-8?B?WEVMajg5Vmt5aHNvMXZLTVZib1llUllTOGNjYjRDbThkbVppMUh3UVRKS0NQ?=
 =?utf-8?B?Z1VYdG1sQlhQQ25iQ3IvOHBtcm1sVmxwbExrNkZwYmQyTXkyTzB6WHJkZ2JU?=
 =?utf-8?B?THZZUDU3b1pTWlBMRE0wd0I2ZGZLTDZpQVNBT2tINzNxbll4WEp2SGhpUkxo?=
 =?utf-8?B?L0xVSVQycUtydm4rUVRuS2NTQmhTRVBlNVBCQ0x1eXBHZ2ZJZFd1QXZQUldq?=
 =?utf-8?B?dUV1aXR5aFdRbDhSaXVnZ2Vqd3VpMVJIanhQYlZIbmx0UXE0ZU5mWWJhcGxp?=
 =?utf-8?B?Vm1CR05BejVMVW9lWlBlVHdxRXpWKzFUa0VKcjhDNTRTbjlFUmh4Sms1VTRE?=
 =?utf-8?B?eC9vTXRodDlEby9pTlkvSDhzUFZYcGZVT0pmVkVGcjZ4S3FLSVRHQ2dWOHNq?=
 =?utf-8?B?ckZOaGVmQjJVRXQwZklxcWJWdzRiLzRzUkxUYm5neGFPTmQ3bVRJc0VVb2x3?=
 =?utf-8?B?YXlsUXZ4Y1REd3JBSTNaQzJLRU9EcXhHbnM5RGd6anBmRGRWbndjVFBONTRC?=
 =?utf-8?B?Ukk4MFhkOE53aWl0OXZXSFNLamRId251dU8xSWR0THM1Rm5kdVZQeU9GYTk0?=
 =?utf-8?B?S1kxcVh3MnB5akp1YVJPMTVOeTYxQjEyelJwYndPcDVGMDhWOWlXelZmZE5w?=
 =?utf-8?B?L0RZcElkWlp4SmNlazRYdXlCckJxVnZ0blo1VFVSYkU4ejZUNmJlMERJZm12?=
 =?utf-8?B?SEhyWXp3M2ZvaEk5SkowNzJkVXd0emFTSFhyVUtOaTVieDY1RnkrcExOYmxs?=
 =?utf-8?B?UU4wSEwvZnRTRnhlTlBxeTNLd1lKTDloa2x0cHJHMzloRHB3WlIxNERLVDBH?=
 =?utf-8?B?T3R6MmV1dHZTMGRTTElSTTZtSS9CVEwrb0JTcmxWOGttRHMrZkR2ZHVmWDJ5?=
 =?utf-8?B?NXNKUm1ZRFFoMStPTFNxa0dLZ214NlBwU01rR0RsdmQ1TWRUMXgwTHRsb1Ry?=
 =?utf-8?B?OXFNTzZneUl4ZXJYYzFVN1dZSFpvbmc2aGZvNUI0RVVwSlMwU2xWaFdnN2xM?=
 =?utf-8?B?aHdzSENqQisxTWdUWWpxMSs5b2Uwa2NqRnpDbUp6ZXhQb0JEWWpqSlhBNkRL?=
 =?utf-8?B?bG1YamordTlnVGNpYk5laXJiYXVXSjZPNWszS2VMcm96cWhoWmxtMndUbnQy?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B94F61923E8594BA933A336F91B2855@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199785c7-7640-48e5-d110-08dbfc1a3078
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 20:29:21.5269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPmkpaYUDPv+qp+D+VcWLiCmhv2z8LfMCGk9Z1JGAUm7ZBdYsLT1iRZqVkrRrcxPmsOAJxfwRADS6CinMaOypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
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

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDEyOjEzIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvMTMvMjMgMTI6MTEsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiAiVGhlIG1hY2hpbmUt
Y2hlY2sgZXhjZXB0aW9uIGhhbmRsZXIgaXMgZXhwZWN0ZWQgdG8gYmUgaW1wbGVtZW50ZWQgaW4g
dGhlDQo+ID4gPiBWTU0uIg0KPiA+IEkgYWxzbyBhZ3JlZS4gIFRoYW5rcy4NCj4gDQo+IEthaSwg
Y291bGQgeW91IHBsZWFzZSBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoaXMgYnVpbGQgcHJvYmxlbSB0
aGF0IEFybmQNCj4gcmVwb3J0ZWQ/DQoNClllYWggd2lsbCBkbyBhc2FwLg0K
