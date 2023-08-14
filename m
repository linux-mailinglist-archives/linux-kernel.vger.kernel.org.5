Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6077B418
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjHNI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjHNI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:26:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B510B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692001597; x=1723537597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aPWZ4xe5dJ6V286EGphzZa8E77XgsnlWJvM4WKslqg4=;
  b=QP52y8F9G0ZIxJyHCKv9yGLRwxIrXXV74J5O5xzYdkeKSrlzb0aLYech
   4k7MPKXWdgqZrxCfhA5AXzw2w175CQbyfE+okBx/LgIDIm8zxPakEsWjG
   9xI7XTys1ixD1HG2KXGDS7gy/2/zoOsrGisi/q/U/eMUnuQi684xkTK0U
   HGT6zdSR6e2722KiXicJVquH7l5ePThQ8pvEqj8bmbuR0bM/u0CxLnZu7
   S8mHdvIk0KdX92tTa4kOr6RwXumch/lJD1Km+mDRLxWiF8JS1NTv4T99P
   UWY2BxzwgqW7tCj7wuUL2GUwz3uwrY9jxEWteduxEc/MZzbTgRlnjuQ0s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="402975422"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="402975422"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 01:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="710245358"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="710245358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 01:25:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:25:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:25:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 01:25:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 01:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNjHt1RXlrzwYQKpH7CGs+A3WaY019iblQ3hJ3poL7aWtxjjgxUSmWG+q/hWqvqdhBI3UlhKcExX4sN1sw1IHR61y5TXk0bbmmNaXDguDUkQBFAYUhc0f5/IX8C0HBO1v4ahw+yT+hOFm3tMjvvHyiYwR7YCpSfOjHKx/p+P6V3Dyc02wEy+1s1RwcHyBzyB5v95okrbMFwkdV66fbuWy4ibqHyZ8GQkKZJUX5nnJJatK3e2c5Cl6OImYtLAvsBhP4mpYZBi4PTJ5DfFD4h3P/lwN//txSUHyYzhJ8dIYmttS38ir8knUdpHCLcSFKt7UxOoDZxFrj5eGuGkvwFyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPWZ4xe5dJ6V286EGphzZa8E77XgsnlWJvM4WKslqg4=;
 b=D/lrikBD2Sj047XYSA4BLG9aQ0NmyHlHn4PRia79zhQsRBnBhEfeRjZgf887X6fwD1yWie8AlnqMXigBTmwPoJRqU95N6nSpWdmS3ANGvIQDWRYvr/iItp4GL9TWN54VLT1CTkkBt/FS/RPr1W0SFDwocCbTAx+FW2Se7ARZvwtQEwfwuG8qrDWIg2bFM8bNw+nbwa53PWeQ4yjKBDLIdkaKOfFy4eRqSWF6TmlpWfzlp4LLaHHFSAjzxVknNo4iNBAi0wSEybMpsTPvyzO9nTiu50HkXSJ7HSFuuSoDzhtxEqCo/tzD/qZ1tZ4XYyLDA60hy3rSbt6rEIr7/t4pgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:25:31 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:25:31 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGA
Date:   Mon, 14 Aug 2023 08:25:31 +0000
Message-ID: <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.258937135@linutronix.de>
         <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
         <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
In-Reply-To: <87ttt3f0fu.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7765:EE_
x-ms-office365-filtering-correlation-id: 1a36ffd1-f826-4704-f38c-08db9ca00616
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAvBYsTygAwltljMFwHbY/ormNBbm2OhHhQC/UY92Xlgn43n6m3I78WB2XlGEMyUQ85HVu5HXsfmrdkZW5PHkprhzJ20zIdmOJZMg9/33y/F7nVWiY1tB12R4LBPwMAUM8SODz0GbwlLP64NgVEfAYwFGdDI9ulNFznrJyyx1/QKLmA94ELLBcVS6o2FrVw+hUsdciWW7wblzaldSt8AwlnGYlf5a1UbyHh77dhTAezc5seNS/3dLJ6hi/Dy3LSdmfCWYGfm6EtG4wwmcLhthtEtiaHWDhP01ZfWTNU9/Sje8CTL++gRl5acKaRAlvTSWSvQ2a4BiZGh1URQK9PMgdDqjgDYyCDxBdMDIgEIezr+3i2CmoqheixOOEWymd+7M/k5SLHoC/fJiHdlJrhG0Dtsn1YjHABOpCdblKjz690luz1PbXMJv8CLtWpu5k2hxCkecrbmK9+L4EuD66KDsJvAumz/YqHwiswAW92lceSZWBGI+ZYNA/JnrDXxEkrcMXp981xAiu2fdjNQDDJCgicx1V9A1gxcGXVJP6YKzwUUYTWcsYLgSYKquefYKpSGzaJDzP0LGh0z2rm0mR/2KKm0G1AEnmt4ak/Mwb5IolvaSZxcl2hTOIih6USh/iWo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799006)(186006)(451199021)(71200400001)(478600001)(6486002)(110136005)(91956017)(76116006)(6506007)(26005)(6512007)(2616005)(66946007)(2906002)(7416002)(8936002)(8676002)(64756008)(66556008)(66446008)(54906003)(66476007)(316002)(4326008)(41300700001)(5660300002)(38100700002)(38070700005)(82960400001)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzJvSTcreTdyWGwwVnhRVzJTVXIyNFVQV01VUjUrY2g0eEJ5dzh4MWZJSHZh?=
 =?utf-8?B?SmtPZmRiVDFNNlpMbkpPRXNUdmRKb0ZzS2pCMmVpQ1lYdVJpTFdNY25Hd1A4?=
 =?utf-8?B?MDJVNHNrN1FoTHM1enlUbVB6UGtMcmhTbGI0emFEUkx6VndBMnZzRlpYTkhV?=
 =?utf-8?B?UjZ5SVJNZ01uY3dKeWwrUm1QWUI3UTYvMjBPNys2WlErbjBwd0VnR2lVSEhy?=
 =?utf-8?B?Y3Y5K2NZZnQ3NjkxR0ZreEo1dC9WUHAwSDVtaVAxSEl4ZzdCVWljc1B2NkZh?=
 =?utf-8?B?cnE2V21SRVpiMUEvdThzQXlSQ3B1OUtXcWFvVHVoTThmdXNhOTBDd3VwZzIv?=
 =?utf-8?B?ZytGUGdqQ3lTcUNxWFp5WnB6aWY0RXQ1MVhXaytIRmJrSGc4U1A4ZW40aDVy?=
 =?utf-8?B?b3d0NU5Sekh1ZllhR3JaTXBCSUVNSTNhYTNQTEVFaFBtWHRjd1oxd2U4Mmkr?=
 =?utf-8?B?MUkwRU43cXYyWUYva1hYVUVmZ3hvbkV5eDdPdDFnZnByRVFPSGxHc0RDSXcx?=
 =?utf-8?B?UnoxalBQcERMZVZKbTFhWitWOGl0T29LbzFuRkIyVWw0bTJqYzhoSURkemRU?=
 =?utf-8?B?MG5MS0p2bm9yc05QRWM3RWt5Y1BVbFNDbDEwOVlabFM4WGVZTk1rNDdTU3Vz?=
 =?utf-8?B?WFRtT1hsUEFObHB6dXh1c3FsTTI0MzJ4UnAwWFZvZFRxdmpteE1SS0xwRVhq?=
 =?utf-8?B?YlVWSE9YRElHd244S3M4bThieW84SWxBYmE1Q3pNM2R5UmhmaWNOS0NWNXQ3?=
 =?utf-8?B?eWNJaDBaVTJQWFlzUXpHeTJmK0dKdE1sQy9KRGxwUmVpRjRLLzlpVUNLN1Ar?=
 =?utf-8?B?bXpYVDdqaW1nYWIvbFFyVzhSTWJyZ0IvclVKamlMNTdiMXR1MmtkSEdZM0lL?=
 =?utf-8?B?QnBwK2ZlRHMwMkoyZkhSM2JWVjBMVUZlL1NpNXB4OXJtVEM3YnNsQ0l3Uzhk?=
 =?utf-8?B?Z0xQa01JOWloZlpXNFJXSXorTU5PR1FCKy9jR1lFMkhDeG5mQVJsSW5xcFgw?=
 =?utf-8?B?Ymo4U0t6RkgvQm5yaVg5OVdKRis5Wk92T2dYSG44RFdSaWlFTFNqZVExcUFM?=
 =?utf-8?B?NXBqOHR3RjdKT0xCeHIwSXZMQVJYL1dKZkVjTE1oa0R3d2tBMG9xOVFzUUFj?=
 =?utf-8?B?THk0RnpYQ3pTd29tZnI0NjlCZ3pWaDA0UW9vVm1SbEQwMHdqalZWNWYvbUt1?=
 =?utf-8?B?Y0hydmVaVXNCTmNiNi9laUw1cUVBazRNaGsrMGRVVVcyUWtmQWx6dVhIdVVE?=
 =?utf-8?B?RHBOaDl0T3ExdXB6S1dhMVMyOGdwaEgzZE9jOVBDMWJwU24vUG1WSkY2VUdR?=
 =?utf-8?B?OHZ2alA3VEE3WGlUYjVIREpUdHlsTmUyY25hZUZRSkdjbEczTDVoYzY0cDg0?=
 =?utf-8?B?bUNpSTZFeTJDWnZ6VHlUakpyUUVUWko3cFlVYzRYR2JPb2NaaW4zNTJRVld5?=
 =?utf-8?B?dmZ0K21GajdYY2VUMzIwM2wzd2Rtc3VpTzZaWTZuZUo1bWRVdVVTcXVqMUNq?=
 =?utf-8?B?cUxDeVk5ZTNsZUUzeHMwQXkzMHMwbkUxV1BOY2VLQnJYbzN3QjdpbWpJSS9s?=
 =?utf-8?B?NU96SjlwTHhIRkJhdjYyUjRFSTZQLzU5UGlwRFhDRE9VSGFFZzZFNlAzd2J3?=
 =?utf-8?B?NjMvOXc5aWVGR1ZjamZFVU83U2llVW5pUXVIOUhPTTdjSk44SFZ5RUJFRmMv?=
 =?utf-8?B?TGhLblEyQzJHSS9kdXJ6YzA4UzlMSXdtT0F6dWErc2xTQ1BGdFRMV1BySExp?=
 =?utf-8?B?Z3hyOVFuaGVmb05sY1l2SHVIQUxmOG9KRDdXUkdsdzhQMGd1bkZaVU8yUFAy?=
 =?utf-8?B?MStwcXc3TXBzSmlPUTdzN2l3NjA1NmNuSm1CTkRsUlUwNWI4dUU0TGxpSCtX?=
 =?utf-8?B?clBmUkdQWmJoWXBBWFhNdXVVWWNTNFNSaHgyRVBLQ2JQSE1jVW5lQ3MwR1ZU?=
 =?utf-8?B?bk5IZDhHcFN0c0M2SW1VVDc5MDh4OTdtYzJEalgrRXZwbndBcURGV2NqV2h0?=
 =?utf-8?B?Y3BMNHJCOU93eEZMa0VPcEUvRWVsMWUrVzdRT3ZwMjdrNzU1VDR3bmMyQk1t?=
 =?utf-8?B?eDlsWVgyRWNiVFBSUDBVSTdXR0lFdDh5UzdMZVNHc2pKSmJKcTMrU1RGSzRY?=
 =?utf-8?Q?A+WYUKlaCBDMHfVel0g7wCaSA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1A08894EFB3EC41BFC2FCAECF33BCDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a36ffd1-f826-4704-f38c-08db9ca00616
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:25:31.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPymTPJGso5N/RoShx0B+Ou2RlphxJE/LYdl1yNXIXtFiMDj/U94Vxe5fvLk9f7SUVulPmxCOfYY37h8Kbjr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA4LTEzIGF0IDE3OjA0ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFNhdCwgQXVnIDEyIDIwMjMgYXQgMjI6MDQsIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4gPiBPbiBTYXQsIEF1ZyAxMiAyMDIzIGF0IDA4OjIxLCBSdWkgWmhhbmcgd3JvdGU6DQo+ID4g
PiBXaXRoIHRoaXMsIHdlIGNhbiBndWFyYW50ZWUgdGhhdCBhbGwgdGhlIGF2YWlsYWJsZSB0b3Bv
bG9neQ0KPiA+ID4gaW5mb3JtYXRpb24NCj4gPiA+IGFyZSBhbHdheXMgdmFsaWQsIGV2ZW4gd2hl
biBydW5uaW5nIG9uIGZ1dHVyZSBwbGF0Zm9ybXMuDQo+ID4gDQo+ID4gSSBrbm93IHRoYXQgaXQg
Y2FuIGJlIG1hZGUgd29yaywgYnV0IGlzIGl0IHdvcnRoIHRoZSBleHRyYSBlZmZvcnQ/DQo+ID4g
SQ0KPiA+IGRvbid0IHRoaW5rIHNvLg0KPiANCj4gU28gSSB0aG91Z2h0IG1vcmUgYWJvdXQgaXQu
IEZvciBpbnRlcm1lZGlhdGUgbGV2ZWxzLCBpLmUuIHNvbWV0aGluZw0KPiB3aGljaCBpcyBzcXVl
ZXplZCBiZXR3ZWVuIHR3byBleGlzdGluZyBsZXZlbHMsIHRoaXMgd29ya3MgYnkgc29tZQ0KPiBk
ZWZpbml0aW9uIG9mIHdvcmtzLg0KDQp0aGlzICJzb21lIGRlZmluaXRpb24gb2Ygd29ya3MiIGlu
Y2x1ZGVzIHBhcnNpbmcgdGhlIHVua25vd24gbGV2ZWxzLA0KcmlnaHQ/DQoNCj4gDQo+IEkuZS4g
dGhlIGV4YW1wbGUgd2hlcmUgd2UgaGF2ZSBVQkVSX1RJTEUgYmV0d2VlbiBUSUxFIGFuZCBESUUs
IHRoZW4NCj4gd2UnZA0KPiBzZXQgYW5kIHByb3BhZ2F0ZSB0aGUgVUJFUl9USUxFIGVudHJ5IGlu
dG8gdGhlIERJRSBzbG90IGFuZCB0aGVuDQo+IG92ZXJ3cml0ZSBpdCBhZ2FpbiwgaWYgdGhlcmUg
aXMgYSBESUUgZW50cnkgdG9vLg0KDQpXZWxsLCBub3QgcmVhbGx5Lg0KDQpJZiB3ZSBoYXZlIFRJ
TEUvVUJFUl9USUxFL0RJRSBpbiBDUFVJRCBidXQgb25seSBzdXBwb3J0IFRJTEUvRElFIGluDQpr
ZXJuZWwsIHRoZSBVQkVSX1RJTEUgaW5mb3JtYXRpb24gaXMgb3ZlcndyaXR0ZW4uDQoNCkJ1dCwg
VUJFUl9USUxFIHRlbGxzIHVzIHRoZSBzdGFydGluZyBiaXQgaW4gQVBJQyBJRCBmb3IgZGllX2lk
Lg0KDQpTYXksDQpsZXZlbAl0eXBlCQllYXguc2hpZnRzDQowCVNNVAkJMQ0KMQlDT1JFCQk1DQoy
CVRJTEUJCTcNCjMJVUJFUl9USUxFCTgNCjQJRElFCQk5DQoNClRoaXMgaXMgYSAxIHBhY2thZ2Ug
c3lzdGVtIHdpdGggMiBkaWVzLCBlYWNoIGRpZSBoYXMgMiB1YmVyX3RpbGVzIGFuZA0KZWFjaCB1
YmVyX3RpbGUgaGFzIDIgdGlsZXMuDQoNCklmIHdlIGRvbid0IHN1cHBvcnQgdWJlcl90aWxlLCB3
aGF0IHdlIHdhbnQgdG8gc2VlIGlzIGEgcGxhdGZvcm0gd2l0aCAyDQpkaWVzIGFuZCBlYWNoIGRp
ZSBoYXMgNCB0aWxlcy4NCg0KQnV0IHRvcG9fc2hpZnRfYXBpY2lkKCkgdXNlcyB4ODZfdG9wb19z
eXN0ZW0uZG9tX3NoaWZ0c1tUSUxFXSwgc28gd2hhdA0Kd2Ugc2VlIGlzIGEgcGxhdGZvcm0gd2l0
aCA0IGRpZXMsIGFuZCBlYWNoIGRpZSBoYXMgMiB0aWxlcy4gQW5kIHRoaXMgaXMNCmJyb2tlbi4N
Cg0KSU1PLCB3aGF0IHdlIHJlYWxseSBuZWVkIGZvciBlYWNoIGRvbWFpbiBpbiB4ODZfdG9wb19z
eXN0ZW0gaXMgZG9tX3NpemUNCmFuZCBkb21fb2Zmc2V0IChpZCBiaXQgb2Zmc2V0IGluIEFQSUMg
SUQpLiBhbmQgd2hlbiBwYXJzaW5nIGRvbWFpbiBBLA0Kd2UgY2FuIHByb3BhZ2F0ZSBpdHMgZWF4
LnNoaWZ0cyB0byB0aGUgZG9tX29mZnNldCBvZiBpdHMgdXBwZXIgbGV2ZWwNCmRvbWFpbnMuDQoN
CldpdGggdGhpcywgd2Ugc2V0IGRvbV9vZmZzZXRbRElFXSB0byA3IGZpcnN0IHdoZW4gcGFyc2lu
ZyBUSUxFLCBhbmQNCnRoZW4gb3ZlcndyaXRlIGl0IHRvIDggd2hlbiBwYXJzaW5nIFVCRVJfVElM
RSwgYW5kIHNldA0KZG9tX29mZnNldFtQQUNLQUdFXSB0byA5IHdoZW4gcGFyc2luaWcgRElFLg0K
DQpsb3NzaW5nIFRJTEUuZWF4LnNoaWZ0cyBpcyBva2F5LCBiZWNhdXNlIGl0IGlzIGZvciBVQkVS
X1RJTEUgaWQuDQoNCj4gDQo+IFdoZXJlIGl0IGJlY29tZXMgaW50ZXJlc3RpbmcgaXMgd2hlbiB0
aGUgdW5rbm93biBsZXZlbCBpcyBwYXN0DQo+IERJRUdSUCwNCj4gZS5nLiBESUVHUlBfQ09OR0xP
TU9SQVRFIHRoZW4gd2UnZCBuZWVkIHRvIG92ZXJ3cml0ZSB0aGUgRElFR1JQDQo+IGxldmVsLA0K
PiByaWdodD8NCj4gDQo+IEl0IGNhbiBiZSBkb25lLCBidXQgSSBkb24ndCBrbm93IHdoZXRoZXIg
aXQgYnV5cyB1cyBtdWNoIGZvciB0aGUNCj4gcHVyZWx5DQo+IHRoZW9yZXRpY2FsIGNhc2Ugb2Yg
bmV3IGxldmVscyBhZGRlZC4NCj4gDQo+IA0KU2ltaWxhciB0byBwcmV2aW91cyBjYXNlLCBESUVH
UlBfQ09OR0xPTU9SQVRFIGVheC5zaGlmdHMgY2FuIGJlDQpwcm9wYWdhdGVkIHRvIGRvbV9vZmZz
ZXRbUEFDS0FHRV0uDQoNCkJ1dCwgc3RpbGwsIHRoZXJlIGlzIG9uZSBjYXNlIHRoYXQgd2UgY2Fu
IG5vdCBoYW5kbGUsICh0aGUgcmVhc29uIEknbQ0KcHJvcG9zaW5nIG9wdGlvbmFsIGRpZSBzdXBw
b3J0IGluIExpbnV4KQ0KDQpTYXksIHdlIGhhdmUgbmV3IGxldmVsIEZPTywgYW5kIHRoZSBDUFVJ
RCBpcyBsaWtlIHRoaXMNCmxldmVsCXR5cGUJCWVheC5zaGlmdHMNCjAJU01UCQkxDQoxCUNPUkUJ
CTUNCjIJRk9PCQk4DQoNClRoaXMgY2FuIGJlIGEgc3lzdGVtIHdpdGgNCjEuIDEgZGllIGFuZCA4
IEZPT3MgaWYgRElFIGlzIHRoZSB1cHBlciBsZXZlbCBvZiBGT08NCm9yDQoyLiA4IEZPT3Mgd2l0
aCAxIGRpZSBpbiBlYWNoIEZPTyBpZiBESUUgaXMgdGhlIGxvd2VyIGxldmVsIG9mIEZPTw0KDQpD
dXJyZW50bHksIGRpZSB0b3BvbG9neSBpbmZvcm1hdGlvbiBpcyBtYW5kYXRvcnkgaW4gTGludXgs
IHdlIGNhbm5vdA0KbWFrZSBpdCByaWdodCB3aXRob3V0IHBhdGNoaW5nIGVudW0gdG9wb190eXBl
cy9lbnVtDQp4ODZfdG9wb2xvZ3lfZG9tYWlucy90b3BvX2RvbWFpbl9tYXAgKHdoaWNoIGluIGZh
Y3QgdGVsbHMgdGhlDQpyZWxhdGlvbnNoaXAgYmV0d2VlbiBESUUgYW5kIEZPTykuDQoNCnRoYW5r
cywNCnJ1aQ0K
