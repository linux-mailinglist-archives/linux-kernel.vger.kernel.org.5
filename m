Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A684C7DD100
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjJaPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbjJaPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:55:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D30E6;
        Tue, 31 Oct 2023 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698767700; x=1730303700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W57YT8FxzFjmFKLlE68QZnD7sbFD4El3ldtHwBwS+aI=;
  b=d0uXVbyEryVFxhb/FKYgfwNiWY7iYfTdD1Pn97cNxCJZZW4onNu5yXMX
   mnA/FIJKeSozPbn019x66Whd/gdUI21/KkKnhjhXdYvZl+STuEx04udmJ
   cNrvvlAXK5d+yD+Z6lSzyv3SaVlKY3/dqEe9edrRGGpkltePUbcHBuiDg
   LfbV1IAtkXDQfQTYes1Zby4JNcdIoFDTingE2bv9JxDvxFjFi61rGyF1l
   Q5Af1a9hD8IwtO1jlrT891kbxTj1IlRhsC8RExo0YX0ehuorCAu0IGqHq
   lgFUWynKLj2gC8iceU51fWbyD+SPd9PA14tfR2vd2/2pmSDNDQfH4Tw5P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1204758"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1204758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 08:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8372278"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 08:54:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 08:54:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 08:54:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 08:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9E979riiIKt/J2CZLDASU22giXSxXkkh/mK01uXNDHw7XqdBgio9l4Y08RawSyXDqTjNHxrWUC50/lVfoA52XJODaFWH/lTx/zBoYYNOpiZp98Yf1itNRN5qR1MS06Q5dxxsTX3pyofDXD9ifWetKsv6WHoP8+Xc0ntrHzKbLMf2fOE+QOSQo54rMeL+P1JXtR5XUtQ8/Ee/hQjsU2DZIBYGZ8xrP3DshFlZO/F8AY6jSJvnuFNry8f4cdZatJvqDhiEOJml/GfV57j8WoeE4qY4XBe3etNZnO8zpxWD2lGDcoXTdMxucDhRYceGDmzL1s54Vb6hjjufbbx7+r4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W57YT8FxzFjmFKLlE68QZnD7sbFD4El3ldtHwBwS+aI=;
 b=PlYKE6CJNvPVlIJyEaNWF4YY8GwLO6h0maycfveBBf5ewnBbHSRid7snTFimdRU2O0pVlUUUZvh8CIBDhSNk1Bat87KvGb9HL0BGPhM37CHPjb5jjwlQ+KoKmxJqTbUKNIicuseC7Ld/Pll7txPIb2NPLX2lxMEGk4EW/vv/5vQ/Zq5WgM+tuOwqDUIXzcMlDKK0lDXivs6X1E68LNa1PIoOflYsfDsS+m6k4gt96kgbtZm4TSIaqxdsnLYfHQurQqoNGOGGMsxiFrXBUN99lOSg2r8Po166jcmpwqWoZv8C47DL+jphECmwDU56jJ3zeYNlWXK5OWzkB4f+Pet3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 15:54:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%5]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 15:54:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "petr@tesarici.cz" <petr@tesarici.cz>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "hch@lst.de" <hch@lst.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Topic: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Index: AQHaATgY0RLsz+xoMkWnZqzcXks5J7Bjy6sAgABXDoA=
Date:   Tue, 31 Oct 2023 15:54:52 +0000
Message-ID: <c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-5-rick.p.edgecombe@intel.com>
         <20231031114316.0bfa8d91@meshulam.tesarici.cz>
In-Reply-To: <20231031114316.0bfa8d91@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6005:EE_
x-ms-office365-filtering-correlation-id: 221bb2e9-6433-4a7d-01f4-08dbda29b88e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j21wQrGECbqboKPMl8xTnCmRaC6RADYOOM2sYGcZES0xBe1MRN0Mq060+QFTFR4Um1MPoCET295v7tu/r4xzx5HaNBKyd3nJGmmXqycDO7n7+GBDCvTtsSvWURkfonZYhJD01hSoac2bkL2cdK53QbyhF8NVQFMxWtgaA31h6kNZNmD/1+ydnjhP+01cuizuReXaen6eeluSR0nwwZSeEu51wG/MkBle8MrEn84/7ooDRluyWuUtMOhWZRiy4sizEvMH9/4MTvDolV+5y6xdOg8+eFgeAwsFaXukUO+qpOdNFQn0+VV1dzZ4OWLaFdpufK6ph6z/oBc7ik+rd7xRw1objXZEZnToFQhH2caHVq7y9UcBwIoDvl/mKlPrf4BXrsBLvele0NH5r8KmZId1EHE1mzwxaZKihg0Wrtfo5VZbLg+zxc3ZVxTSXz9yup/RQDqueMukEP5Nm5hRn2/8deVsu0ZYMniI8kphaxmAjB8U9uqN6YjDCnc/KxgyBey2cOZWxB9EzeQd6oBTPv7xShTqE3xWpvJnVzQ9qp/73eZKaC6Sk4zrkuQ1RXbTyRE5r0NFJHM8gvO3I7kWEI3tR/NaDNfehtr/4wpRUNZLy8yL5PO/Yjq4BrcTf23mDnXeLR3UYLJuhYKQo5kOy5Gidg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66446008)(76116006)(38070700009)(2906002)(6916009)(7416002)(38100700002)(86362001)(82960400001)(5660300002)(41300700001)(6512007)(4001150100001)(122000001)(6506007)(2616005)(36756003)(83380400001)(26005)(66556008)(66476007)(316002)(71200400001)(966005)(54906003)(478600001)(91956017)(4326008)(66946007)(8936002)(64756008)(6486002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDFxYkR5MGZvYW04UVdyRVVJMzZQaFlrcWZ1RXZyRjN6dlc4NlFsTnNCVEdz?=
 =?utf-8?B?WFZwdHU4OCtKRlJERG9vVE4rRkNyWVYyZWlUUUFWY3YwYnVqcjV6ZG9yTWN2?=
 =?utf-8?B?SmhXNjAzWHBRTldVQlZmMXRteFZNdWFKOW96WmUwU1pwUmxraVU1Rkx4Mitk?=
 =?utf-8?B?dEFBT0NuaXRFd0IxaHdXZGhBTVdGSHZ0aU9GelFQSmo0Zmp4NlMzVGJTU3FK?=
 =?utf-8?B?MlJpeEFubzdUMW51eVBMT2dGOVpiZkZxbDRGZVJBWG5IOEMvZDRpWVBQbVBw?=
 =?utf-8?B?SUZ2WVIvazdxRTRzaXJERHIraGZlMEFqWXFKYmM0clFKUzlnVndTUG5DOW0r?=
 =?utf-8?B?WmRNODk0aGRDYk5yTm1BL3RjZU82ams5WDIzQ2lMcE5JbzVJcjdFNmlyMXlN?=
 =?utf-8?B?ZTVhNGpvSGZrQ0VzWjJ0UXRGdm1kQWRTYWNmZlRWVnZTYWlpTGoxVUVqMWFx?=
 =?utf-8?B?S3d5SS94Z0Z3T1JibHFNZXUvZU9NcWMxd3d6V2NlYmNvaXI1Q2RRYm5VQk9j?=
 =?utf-8?B?Ylg1NkNRTFY5elNIUXZlLzRiQTB3T3JsTGxWVFM2YmRNQ25yQVNvRy9nc1ZZ?=
 =?utf-8?B?dGlDSFFBdXpjVzkwdHA5L0hqNmJVb0dBTTkxUThiRnVWSzBKdThZYkFMVXFH?=
 =?utf-8?B?VEhZSGMxWU1pRll0MG9KRnJvYjhqaDZMbThqQlQrUERFajM4L3Z1L0FCN3RQ?=
 =?utf-8?B?bDFwQVY5MndKTFpUWnZ5aHdlWEVVdHFaZXlPblY4emMrRkExNE9yd0RMWWxY?=
 =?utf-8?B?TjhtRHpJcGlXOGxGT081dGpvY3g4RnZTTlVrRkMrelpOV0ZBMDYvdnowZTMx?=
 =?utf-8?B?QTJyaXVUTm5iNVpCcUlXZjZJcWZSeWFVeFJ3Vmk4QUk0aDdHT1J0Q0hsOFFz?=
 =?utf-8?B?TkR6Slptc0JEQUxhd3RYeEUzVjJtT2V4VnVFVXVLVWlwZnpEUnJCckhTeXE0?=
 =?utf-8?B?NnZ0S092d3VhWjJtS0NkVGs0OEJWTFlBMkJiSGI0L29pRU5Pa25TQ3R6OE1j?=
 =?utf-8?B?TE13dE14YlBRc28vMlZEMVd1ZHVTekhoOVcySkQrY3VGNzNSTDNqb0ZFZ2hn?=
 =?utf-8?B?VGVHb0NuRHJyZ2traEoyUGZpOUVRUTFnZ3ZkeEZWVVBXZy9zTml3bHlkZWp1?=
 =?utf-8?B?VU1XRTA3eGhKdTYzUFA3MFE3VlE1NGs1RXhMYUZzeVZkSzlzUDk5UmtQL2JR?=
 =?utf-8?B?VFBGWGplU08rVmhRZXdIUWhNUERzazlod3ZDdjZyRTBJQnFWYW1ydU4wREs3?=
 =?utf-8?B?Y2tLQ0FKSWdpUFE0ZWloUWkwWkQ5UG9yemxRc0ovck1BY3V5T05naWNVakU3?=
 =?utf-8?B?Z1VrbkU3QU5vV2hZTEljN1NFUmRjM0VBMXl4TUlIb0REV0lUa1NrS3UzcXB6?=
 =?utf-8?B?TjRJK2E5a3NtZGtUN05iZklCSHgrenE2YmtFaE9kdW10M2I0ZFUxY0VseS83?=
 =?utf-8?B?SDhRTFZZc1ljNDdBMGxoQ2FwZDFTR1VQK1lFUHdNZmQvY052MjRzZ1ZYaGhq?=
 =?utf-8?B?ZGRLVHZNTXpPbUMrWDRYMEVTR2JsZTZKY2JjRlM2K28rMXgzYjFwWFM2bkIy?=
 =?utf-8?B?d01jd2huQVhLQ3RiUHRXUk9nS2pxMEJFdFI4bzZtb0RyR3JCUWtES2ZNaVlZ?=
 =?utf-8?B?QXBTWGJqQVBHaExCOVpkWVlIRVIwSTJhRnh2bkZleGZPRWs5WHprTUVPVjRS?=
 =?utf-8?B?N2QvRTZXdkU0QW56NzFaMHY0QnhJTHlKeHpJRXlKL2t3aXN6Nk9MN0h6V0dH?=
 =?utf-8?B?RUZiK2UxZ0VTdFVZTDdOdzdqM05SMWs2ZThBdHhNcm00TGhON3pHM2p5TjMr?=
 =?utf-8?B?RXJ2eU90ZFVyY0xreW8rSlVtazIvaTJKZFZtRWhJZTBrbElLUlA2OG9SSW5m?=
 =?utf-8?B?dnQvL3lPazZ5eFVvVmZNbmxrQWMxQk5xZkZtNzlvcjhrc3k2ZkVlNFhJY3A0?=
 =?utf-8?B?K0RqUzk1VHZzU3FRSzdITjdJVVljbUdER2JPcC94a3djUkszaG5BUEl5emM5?=
 =?utf-8?B?cGRWVGlxZlZyeWhlaHZvdEFyRmFzMTF5TCttTTFPcmtCMTNScnlVaURWUmN0?=
 =?utf-8?B?c2U4RURNM0dWRE4vRnJ3R3F0TmdLNTB0VGovZVczZVhZSzdXRjNRQlBlK3BB?=
 =?utf-8?B?Z2h2VkhzRkRwT3lxOER5emJLRjFqbmQ0bDV6Y2xUS3dXWTNESzRUZitqdUxJ?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7EDC34A21AAD24E994EEFE84EC84EDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221bb2e9-6433-4a7d-01f4-08dbda29b88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 15:54:52.7456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YycO64+4129uGWLlV8a6jf9BCZI/dbyvI15ca9pdj5liUtCVCLswWImmAbqj2sGx90Zv/Sqa3vG79pSRpk9zaq2wyhliz+LuH1rw1rWHcoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTMxIGF0IDExOjQzICswMTAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToN
Cj4gDQo+IEkgYWRtaXQgSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBlbmNyeXB0aW9uL2RlY3J5
cHRpb24gQVBJLCBidXQgaWYgYQ0KPiBfX2ZyZWVfcGFnZXMoKSBpcyBub3Qgc3VmZmljaWVudCBo
ZXJlLCB0aGVuIGl0IGlzIHF1aXRlIGNvbmZ1c2luZy4NCj4gVGhlIGVycm9yIGxhYmVsIGlzIHJl
YWNoZWQgb25seSBpZiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHJldHVybnMNCj4gbm9uLXplcm8u
IE15IG5haXZlIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhlIG1lbW9yeSBpcyAqbm90KiBkZWNyeXB0
ZWQNCj4gaW4NCj4gdGhhdCBjYXNlIGFuZCBkb2VzIG5vdCByZXF1aXJlIHNwZWNpYWwgdHJlYXRt
ZW50LiBJcyB0aGlzIGFzc3VtcHRpb24NCj4gd3Jvbmc/DQoNClllYSwgdGhlIG1lbW9yeSBjYW4g
c3RpbGwgYmUgZGVjcnlwdGVkLCBvciBwYXJ0aWFsbHkgZGVjcnlwdGVkLsKgT24geDg2LA0KYWxs
IHRoZSBzZXRfbWVtb3J5KCkgY2FsbHMgY2FuIGZhaWwgcGFydCB3YXkgdGhyb3VnaCB0aGUgd29y
aywgYW5kIHRoZXkNCmRvbid0IHJvbGxiYWNrIHRoZSBjaGFuZ2VzIHRoZXkgaGFkIG1hZGUgdXAg
dG8gdGhhdCBwb2ludC4gSSB3YXMNCnRoaW5raW5nIGFib3V0IHRyeWluZyB0byBjaGFuZ2VzIHRo
aXMsIGJ1dCB0aGF0IGlzIHRoZSBjdXJyZW50DQpiZWhhdmlvci4NCg0KQnV0IGluIFREWCdzIGNh
c2Ugc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSBjYW4gYmUgZnVsbHkgc3VjY2Vzc2Z1bCBhbmQNCmp1
c3QgcmV0dXJuIGFuIGVycm9yLiBBbmQgdGhlcmUgYXJlbid0IGFueSBwbGFucyB0byBmaXggdGhl
IFREWCBjYXNlDQood2hpY2ggaGFzIHNwZWNpYWwgVk1NIHdvcmsgdGhhdCB0aGUga2VybmVsIGRv
ZXNuJ3QgaGF2ZSBjb250cm9sIG92ZXIpLg0KU28gaW5zdGVhZCwgdGhlIHBsYW4gaXMgdG8gV0FS
TiBhYm91dCBpdCBhbmQgY291bnQgb24gdGhlIGNhbGxlciB0bw0KaGFuZGxlIHRoZSBlcnJvciBw
cm9wZXJseToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEwMjcyMTQ3NDQuMTc0
MjA1Ni0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KDQo+IA0KPiBPVE9IIEkgYmVsaWV2
ZSB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGUgbG9naWMuIFRoZSBzdWJzZXF1ZW50DQo+IF9fZnJlZV9w
YWdlcygpIGluIHN3aW90bGJfYWxsb2NfdGxiKCkgd291bGQgaGF2ZSB0byBiZSBjaGFuZ2VkIHRv
IGENCj4gZnJlZV9kZWNyeXB0ZWRfcGFnZXMoKS4gSG93ZXZlciwgSSdtIHByb3Bvc2luZyBhIGRp
ZmZlcmVudCBhcHByb2FjaA0KPiB0bw0KPiBhZGRyZXNzIHRoZSBsYXR0ZXIgaXNzdWUgaGVyZToN
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjMxMDI2MDk1MTIz
LjIyMi0xLXBldHJ0ZXNhcmlrQGh1YXdlaWNsb3VkLmNvbS9ULw0KDQpPaCwgeWVzLCB0aGF0IG1h
a2VzIHNlbnNlLiBJIHdhcyBwbGFubmluZyB0byBzZW5kIGEgcGF0Y2ggdG8ganVzdCBsZWFrDQp0
aGUgcGFnZXMgaWYgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSBmYWlscywgYWZ0ZXIgbXkgdjIgbGlu
a2VkIGFib3ZlIGlzDQphY2NlcHRlZC4gSXQgY291bGQgaGF2ZSBhIGRpZmZlcmVudCBsYWJlbCB0
aGFuIHRoZSBwaHlzX2xpbWl0IGNoZWNrDQplcnJvciBwYXRoIGFkZGVkIGluIHlvdXIgbGlua2Vk
IHBhdGNoLCBzbyB0aGF0IGNhc2Ugd291bGQgc3RpbGwgZnJlZQ0KdGhlIHBlcmZlY3RseSBmaW5l
IGVuY3J5cHRlZCBwYWdlcy4NCg==
