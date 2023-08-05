Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA34770C97
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHEAN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHEANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59A4ED3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691194403; x=1722730403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tKHhXjUs8aCc8JIJ1HOgOfgRkykZmsba6sRwy/m9I7s=;
  b=DDGR6QYRCRyooqGe+wZxxRIj13K3FzdRaAu3WD32+jpTG6owQf7IjS9p
   bW6qZcRLfe4gg3ymIMaSaOpq2JZG5/ERGlBNUeimoZKkwnQwvtKLD5n2S
   /drGGpEVUpHPyhUvaW/WlBq4T1kehOmSFWPwuxnc0BSzPgVsCYFTpe01s
   fdYSa3Ey+sF7mQPi92gANyJB9/E+vPVHoly3cxRMd/OEw10vJz7a0Lez8
   n2BOwY3xfwfsR0Jo/6gPtJAGRTRvmMQB8XokWRCtgO/1FK5BldZbtinha
   DJn0jas7gC6dOunnKQ4/UXXZvHfotCq6I0YKyzsXlHYjpC4DpZZzgf//8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="349866446"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="349866446"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800284204"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="800284204"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 17:13:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 17:13:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 17:13:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 17:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga6Z99TGCC+JmAmfPEW+sSWAY6vutSoG2tmh5wze0cNIU7ujYiwCZjnz9b4BRUWiXosrDdQcTpcyjptcI2Q7biwxcZlN3tngQZzAEUCYykB4gm4mvOY135BkM4biTZftZ3fwbumtPf3fu7IytcjhM+BnefMGo3qPaVagrRy0VO4a1Sc9UnXtIog69qjO6KZA5T7p1oFeskGCnbZH4w0mnWM3thtRTqpSPtGXOtsoTNu/X2gYGpx59CoCUA8+8xq8izRvN/7yQqksGSckhmG5B+2wg2tt+hKM/NfkfeRSd2+Nm7MgoAM5xX8DL2zxDV3SI/M80AXUOjd++f+C+y2pQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKHhXjUs8aCc8JIJ1HOgOfgRkykZmsba6sRwy/m9I7s=;
 b=eRyz36RDe12cvy2V8y2seRPVa8qmB5Q0ZG+AooHCX1cn2yFVvhKXEwkTpzFoZp/P8QxHWhuMAX6m4rFgG1yHjyrw/blEqb76S9540nGELuYh893WxMCo8ByhBhKi2rGC2xAW2Jx75jRXYmFclcGpj4VnNlIgqTqvDYmMlTg4hptk6Kt7LPICJoYHxZOQwzso9n2ypL0dOGsroeM8ssA9J3X03JY5VgVYbAZS0OJJeUtu9uQSO0rsTFS2e1wFBfJEs5cFhaozdg85wvzEyyaRr2Ti/cOhxk7uJITNbSWaOluzoiTk1eZyR6StpjJLnhbMPjBXjerFdShpDy1nj8uhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 00:13:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 00:13:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "Wu, Yingcong" <yingcong.wu@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/mm: Fix VDSO and VVAR placement on 5-level paging
 machines
Thread-Topic: [PATCHv2] x86/mm: Fix VDSO and VVAR placement on 5-level paging
 machines
Thread-Index: AQHZxzGjnLNamWuW7keQWvJ4CiCAEQ==
Date:   Sat, 5 Aug 2023 00:13:19 +0000
Message-ID: <1b847f492924a4ae3172fe83c1e259e6a2869149.camel@intel.com>
References: <20230803151609.22141-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230803151609.22141-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5596:EE_
x-ms-office365-filtering-correlation-id: ff23589f-df39-4c0c-feb8-08db9548c629
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56sFol1XHL5AkqmivsA9cMJLrW+rlDmkuB/lukzdRLrZ/B1HiJUUbB+rnvW1wmztDYsuR53zlvcp9XMlwfKfwDfpvj3Dq+Qy2LN1U83hjq6XVb9TJFKXPL9JfguWfZpqbUOTMqZn8gdxnV96cZ6Hu1oAYLTb5kfbGWWabzo1cyQCRjHDlU4Kl3E5RTUBuJ1+h2+Vuz5Badr7PdY2Bq2vET07nEPXkPem5mA++OPfcYFGEToIb0hFw12ABi1k589aykpWN0bu5v4+8m8koZR0E56WgpaC6bmgnAtTTpiZg9baRZEEgtX0i5zKO43WUy0+I8O5upPXyY9tYm7W2zDzl0flKqXbPOWR3JFgF77wloQKEtOiz7n9G4JrngihdM6JB3zdZgETmFPQvcKo2pseKwE51H75fKhbNQUMId+PtU/mc7AgdxHQwlALJdBv5+hIOwYE4K8e7zBjviZC7hmEzzHZZq6eDforuwqLX2fJrA47/Xx7NlIxfm6yIG+PGh0vKNe6anw79YzdWSXa2W1gGIVsYCjOFcMB1qyUh6ziSvZx9s+s9DFD0OvP3oMSgmxZTvB9UJqGmG1Pki2x1Bw0LG1LTKChbhHSsLlIW0xPKDAOpF60acEGD1z78eRqD4Jh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(1800799003)(186006)(66946007)(66556008)(66476007)(64756008)(76116006)(4326008)(36756003)(66446008)(91956017)(478600001)(110136005)(86362001)(8676002)(8936002)(5660300002)(41300700001)(316002)(54906003)(38070700005)(2906002)(71200400001)(82960400001)(122000001)(6486002)(6512007)(38100700002)(2616005)(26005)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDl3Rk1vdnMwWmQwMExOd2o1dVJrMUdMWWpzeTBMZjVReThZdVNEV2R1eExO?=
 =?utf-8?B?ZUhtS3JmYis4NUJIdW5LTEJFeTBseW1Za1NQWGpGdUpiYWlERUFkcTh5VDA1?=
 =?utf-8?B?SlBkSklzd0FITlVZSGV1elNXcWxxUHpJdnJBMWxmdlJBWlRCTHdWZTBmNFov?=
 =?utf-8?B?SDJVSENUUW9XMlpGMkpsY1U5dFdvOFc1a0trbUJIUStRRWFaRVBWQnh4aHhJ?=
 =?utf-8?B?VXd4V25JdkVUbEhSUGRnMWFCdWFWcXpGZzlvc2M3clN6TzVOb1o1S3AyYVpr?=
 =?utf-8?B?ajQvU0k1ZkgwTXhjbTV6RXJBRFlMbGowSXY5aUZZTXJBUXNCU05XSmpZRExx?=
 =?utf-8?B?Z0pKNWN6VUxrSHpqdVRUengxOEZLVVl3RllDQkRZeUxPaGdSMGFnNUNJSm1O?=
 =?utf-8?B?Y2UxQVBkeVBpRnZydHFhdXArNTVJSTZja0VkYkR1VWZxTjJHSzhWRndRc3Yr?=
 =?utf-8?B?OE9CVm1KVVhWbnJlNGxZYkoxWWJxSE94cDJqNzhQZVBTZzFHdjUrOUdxeGVV?=
 =?utf-8?B?d0kvME15T1pnZFo2NTYzV2x1UVlsV1RTNlg4Y0JBeFM4UkVaczY3MTBVSnB5?=
 =?utf-8?B?OWpBeGxIbGpaMTBnQTZraWhGSng4UWU4eENxWU5BdlNWYnlCWVVBT29SanBl?=
 =?utf-8?B?OHJIUDNwbFFlU09PZDllWDB0OHR4bTgvaUpwTE1FZUhhS0llcEprNHhJWno1?=
 =?utf-8?B?a1NHTVZtUkpyRU1XS0sxQlVVa2Z4RDFMSWlIc3Y5RktoWndpTnUzdTFlTjhY?=
 =?utf-8?B?bmZWeCtJY3BUUDI3ZVZQcjhLQ1FYeXl4Z2FPQzFLdHkrZ3hXckw1c2JqNGJU?=
 =?utf-8?B?RlZVVDByYW40VFUyVlBMYWZHdlVYbWJ1LzdiM0JkbzBkSVpRUFFIMDk2YVN3?=
 =?utf-8?B?bUFFQUl1WjJQOEFzbFZTcmFFV0U2OXU3NTg2VE9VY09jQUNNQ240bzlxRytx?=
 =?utf-8?B?WHdRekNLcE9aUXRkdm9OVzJtQjdwNlp0eWtYeWVwZW9XdTd5V2pnZEowZXBF?=
 =?utf-8?B?N2g2WlJXRnBrNCtJZDQzM1J0d1ZlNmN4bXNOZ0RXTndrOHBwYXc0R1VwaTd6?=
 =?utf-8?B?Z2p2d1dPU013NkZCcTcrWk9OcEh3OVB6WGc1SUJwVkRPOHdjSmFySGdGNUx4?=
 =?utf-8?B?YStOdzduWjQ3dDRSYk1kSWEyRld6Z2tQUTdZOHJqT0h2czFkelNBMzM5VnZE?=
 =?utf-8?B?d08rRTVpQjFUTkM3MzEyVDBFUjgvQXFhM0QrY0xYazNvUWhvK0lYSHZOb0JW?=
 =?utf-8?B?NTZpMjNEcFpJOFJYbXNIOUFXZ1RFdmYzdXFFOXBXUVdUKzkxLy9PeVpuMTFU?=
 =?utf-8?B?bW9RaWpvR2JoUWt4cG9HY09HQnBhZ3hHMkNWZEVjbFdCcnlrTmtTQndZMkN5?=
 =?utf-8?B?cVpJYkN0SEprVDk4b0VCZGpsN2Ftc1Z6a2syb291eGFQbTJOSi9Kdm9MMGVr?=
 =?utf-8?B?RU5kZjhCaHRzaVNUSVdoMlJuRmhzNGJlYy92WUtqRFd2RFNWUGd0cGRxZHFv?=
 =?utf-8?B?OTBwQ0RhNHNZMDZ4ektuYzl3TXVLNWxRNHpJbXJvTDdHdVpwTUtoTmt0S3pK?=
 =?utf-8?B?aTJ4NmI3OFZFcTJUOFo0K1A3MmhnMkFjTEpvUEtqWmNUa0laclYrdUwvUzZG?=
 =?utf-8?B?SXowQ3o3WVdmcGc1eDlOemUzUEU5dU5LK3dXajZTbG5MVkd6TkRvK3p3MVpS?=
 =?utf-8?B?RUFmTitPcEV1dWFPOElmR2ZJK0ozYUZTd25nWS9vN2NxVUYrRDN6ejVOcHF1?=
 =?utf-8?B?OG01M2Vsd0hUd0VKejR3Z3R4Lzg5WGtac0tzcEFSUHBlSmRkS0pYUnpsRkY1?=
 =?utf-8?B?d0FteWdrNHc0eEQySkluMFJUVTduTFRzM3lENU0xQTY2dGUvVURpTWYzV0dQ?=
 =?utf-8?B?UWt2K05TR2pmUmRVMitHbVU5SWhmaUZEbjM2Y3JxY056OTlqbEpodlUrdUtV?=
 =?utf-8?B?YjBLMGZjUHJzQTkzSmpGRkx6SVBWNXpHWjFPajMzcDRrUlZNd2hpSnRCbXps?=
 =?utf-8?B?MjQ3Q25UVlR3cGxQK3ZxUi9YeWtWblE4LzBsZTZhQjQ2eWZ2K1JKU0orY1VW?=
 =?utf-8?B?TkJHbndTZDdMVVlReXFuaHRjQWRTSjlqRlVJUkg5T25ac2Z4ZUVhVFVtUEVC?=
 =?utf-8?B?ZHNHUGxWV2kvWEFEZlhWSlJkNzRveXBqWnlMRXJ5anBaVGRyenhod0QrWFhT?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F09F859E46A94CA13671906A96693B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff23589f-df39-4c0c-feb8-08db9548c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 00:13:19.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKsr2U1C/Joc2lSytAR0XeFXuaPpjArh4GvnYFX+Er0h54j8idRakGAHJqwUXVKgP7hdDFaXTsSrsHgDVBJp9LS8ICZpIaxoN3gyq7sht54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5596
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

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDE4OjE2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFlpbmdjb25nIGhhcyBub3RpY2VkIHRoYXQgb24gdGhlIDUtbGV2ZWwgcGFnaW5nIG1h
Y2hpbmUsIFZEU08gYW5kDQo+IFZWQVINCj4gVk1BcyBhcmUgcGxhY2VkIGFib3ZlIHRoZSA0Ny1i
aXQgYm9yZGVyOg0KPiANCj4gODAwMDAwMWE5MDAwLTgwMDAwMDFhZDAwMCByLS1wIDAwMDAwMDAw
IDAwOjAwDQo+IDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBbdnZhcl0NCj4gODAwMDAwMWFkMDAwLTgwMDAwMDFhZjAwMCByLXhwIDAwMDAwMDAwIDAw
OjAwDQo+IDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBbdmRzb10NCj4gDQo+IFRoaXMgbWlnaHQgY29uZnVzZSB1c2VycyB3aG8gYXJlIG5vdCBhd2Fy
ZSBvZiA1LWxldmVsIHBhZ2luZyBhbmQNCj4gZXhwZWN0DQo+IGFsbCB1c2Vyc3BhY2UgYWRkcmVz
c2VzIHRvIGJlIHVuZGVyIHRoZSA0Ny1iaXQgYm9yZGVyLg0KPiANCj4gU28gZmFyIHByb2JsZW0g
aGFzIG9ubHkgYmVlbiB0cmlnZ2VyZWQgd2l0aCBBU0xSIGRpc2FibGVkLCBhbHRob3VnaA0KPiBp
dA0KPiBtYXkgYWxzbyBvY2N1ciB3aXRoIEFTTFIgZW5hYmxlZCBpZiB0aGUgbGF5b3V0IGlzIHJh
bmRvbWl6ZWQgaW4gYQ0KPiBqdXN0DQo+IHJpZ2h0IHdheS4NCj4gDQo+IFRoZSBwcm9ibGVtIGhh
cHBlbnMgZHVlIHRvIGN1c3RvbSBwbGFjZW1lbnQgZm9yIHRoZSBWTUFzIGluIHRoZSBWRFNPDQo+
IGNvZGU6IHZkc29fYWRkcigpIHRyaWVzIHRvIHBsYWNlIHRoZW0gYWJvdmUgdGhlIHN0YWNrIGFu
ZCBjaGVja3MgdGhlDQo+IHJlc3VsdCBhZ2FpbnN0IFRBU0tfU0laRV9NQVgsIHdoaWNoIGlzIHdy
b25nLiBUQVNLX1NJWkVfTUFYIGlzIHNldCB0bw0KPiB0aGUgNTYtYml0IGJvcmRlciBvbiA1LWxl
dmVsIHBhZ2luZyBtYWNoaW5lcy4gVXNlIERFRkFVTFRfTUFQX1dJTkRPVw0KPiBpbnN0ZWFkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZA
bGludXguaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogWWluZ2NvbmcgV3UgPHlpbmdjb25nLnd1
QGludGVsLmNvbT4NCj4gRml4ZXM6IGI1NjliYWI3OGQ4ZCAoIng4Ni9tbTogUHJlcGFyZSB0byBl
eHBvc2UgbGFyZ2VyIGFkZHJlc3Mgc3BhY2UNCj4gdG8gdXNlcnNwYWNlIikNCg0KUmV2aWV3ZWQt
Ynk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
