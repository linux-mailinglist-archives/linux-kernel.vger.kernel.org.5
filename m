Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85E77A4D0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHMDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjHMDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 23:12:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99183172D;
        Sat, 12 Aug 2023 20:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691896329; x=1723432329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rArIJ0hJo5tE42xVl+eMDG60VebHqdv3akIQ2w3u6R4=;
  b=m81SGL2yrXazcqwKLrJvXtFPyhVmHoU6m2Ja39mOUbbgU2RGJ+wYmDcB
   VnWSDEM1nln+ucNtfGgojQmIcXtKz1HrxvtER+zmvEycmITf6YfVCJSsv
   ly/b/FDpyxFxPGhc2a8BVClCIxhRmS8+v0+KMvGMdWQqzSb/YBBL9rVM8
   az+LG4+UYH21ekU/xywDACEK2/MVUFnlCm5eKJRB7EA38jYi0pd9gLxPx
   kRRzhmYcvc4hpIOfqFMJcR1Px+Q4O2N4+SQxxT21piDE3V1HDdoBSBMZi
   i6laaIaoqOFN+H2xcxOwHqwKvNAa77VxMZEVJmOQF/U6XCCdV3pycUlso
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="352190190"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="352190190"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 20:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="682926293"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="682926293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2023 20:12:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 20:12:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 12 Aug 2023 20:12:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 12 Aug 2023 20:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASwIq/P7XTqtZ/53ZrIrQVGZmAqgN+liQicHkpBs+a4ryu8FULiyh1MaaJ8PbwvvcnNYDlHptl4MEBecRB29afFxe/BJ7vHyh9pXBJCJA8o1EJhqCQeL7UCKcnMRi++lDHP+QsqQDDPILHmztJRNZHX0Ok1JwnLVkaDluUFZj7zfLZ0STNR9PouvD4do8hvGndNW6SIzBZSkMhZLGm1gY1Ujpqkwy7HkHTVWQZQXTjvNyUvxdwgRrx+EDGF2Qdf1GxtfbGrW3UQl8k7Htn2HhJnt4+yKzWvOaH1H0hiv67HLuq24YA+1lf09FOlHL6Z5gpcPwxBkT1No2bNP4zQQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rArIJ0hJo5tE42xVl+eMDG60VebHqdv3akIQ2w3u6R4=;
 b=Tday1sJhKWFHC6RpPffv5thn5M+OcrJGu2NN2dahQFgUib2X8BOcl5Z4jtR9tz47k+W7dzjEFny06Q/KO52XrGi2kfM/IrWmjEsOFlXPbyXdi+Px5pCcL/m5ptR0rn9HRrcJRp8CuuBEkMxbAWtKTJRlxLcm/SWilM6i+rk8cm/fCf+nF9D2uV4Ef2+ds//AkmPrwQeVWwIjswvqKM6jvHHOBcPfUfePmWyMP8WxKCau+DBbDo0cfdswES3SqsoQPAqgM1++OCAjdd6ThC4IUTQRKZwroNQD8+S4zET1T+Xd9vtX3gFspe0P0YPYmOBezkcbdiHrjIoeQlQCqOZvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 03:11:39 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 03:11:39 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: intel: intel_soc_dts_iosf: Fix thermal_zone
 removal
Thread-Topic: [PATCH] thermal: intel: intel_soc_dts_iosf: Fix thermal_zone
 removal
Thread-Index: AQHZzDA8wc1tzFyPyEebgzX0X6xIQq/lUNeAgAI+hoA=
Date:   Sun, 13 Aug 2023 03:11:39 +0000
Message-ID: <04981c3253f462fbb092128aaed372708a16906e.camel@intel.com>
References: <20230811084523.1689671-1-rui.zhang@intel.com>
         <CAJZ5v0jgvfzN+Ug9G_gLV=NXLvfmuC98XzjLes709g2uypQ5nA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jgvfzN+Ug9G_gLV=NXLvfmuC98XzjLes709g2uypQ5nA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: c7ab2bca-5121-4a61-b7e6-08db9bab0325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +sAR6UCQ6yNSXOlSe4CxkhgtAjhu2TryP3dneBdS+zLVtl4+GS0goeXI1oy5lFPjQ98+UwjU1KfP6hSjdcHzWZn6+bnjr0EQO28VKxxXqpqBd1L9KpFMJ94MGPiCUAaMxAyqXw5vxlDq/TlFy6hs+pXkzjkIOJnlp8cel/CdBJBVotMp6PY+QOQJo2UfOF8QqfVs6P5zU/td4jySfgavo2VF76cAI7edHN3cPRAtE6wRGzngZtVjaZeWSvRBdgAzzgzXONqFuuMpjFJzHu4eExYepkpsZ3MduYdetvM6sLGIwsGoOjoXZzOHseEjl9/LH209y5HPkar25vS7xnsIZBK5Lqlxy30oCsXsMJRBTKMUsP4+2YtV8dyX8uEUOw1EBUpAWsbTPgEzdCP44BX34h/MiF/gLzZ9CvcT/crnhVk2XbKJ2Xjo8HXmcAeoc4sTbc51hvrkDEyIB0UNnSxz+3nLCtz4D7/ODA9p5rQr+IRsvQ5MAhln1yDk+RlE9grxFKgTzBnfYzUjCerHcqAzNYO11mxyYnUt0CXw4SFPAEgr91AMRijJGerUdhav4XHpomTtYcv5i/K4RutnuoO4gulQt2ja//MMguDziGzvKcYxSVfvM7RpfJQGRTWNMeU1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(186006)(451199021)(1800799006)(4326008)(8936002)(8676002)(6512007)(86362001)(478600001)(6486002)(6506007)(76116006)(66946007)(66476007)(54906003)(66446008)(64756008)(91956017)(66556008)(6916009)(316002)(71200400001)(41300700001)(53546011)(26005)(5660300002)(2616005)(36756003)(83380400001)(2906002)(122000001)(38070700005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHR5dXE5MzNld3hWT2xJVjJ6bzFTcHdTQkxPVm1zZm9rSG9PQk1KZjJYSDg0?=
 =?utf-8?B?K0NxUnJHOVlTTmN5OXJQUnhxaDI0QisyUHN1d0dHNk5zVXNxcC85TXpYSURD?=
 =?utf-8?B?cFFlNkwwbFBnUm44ZXVVQjE2bkF0QmJubEdBWk5OdGZTTG90ZlVWVFlDcC9u?=
 =?utf-8?B?YUUwa2E0MlNqcjlReHBnanVKZnp4dWtHc1VqbTExR1FYZnJkRVlucXRJUW5U?=
 =?utf-8?B?STBTQVdXM2NzZGlmM1ZhSlZhSXA5TTBFNUFGNzlOM2NmZHBJdTdub0o0bUIy?=
 =?utf-8?B?aXdKOWFsc2hEZ3JUdGpSc0gyQ25FdER3ZFVmQ0tBMXB4Mk1HRkYzN1FqMkJu?=
 =?utf-8?B?Vm16b2xUUlZLaExjVUpNUVJ3R2RWL2dhaGk4MU5GL1VZSk5GV3VUNVRlYWpX?=
 =?utf-8?B?d3NNeGZ6eVhiTFpWcGtvVlg1dzloWHRIVHVnQUtrMmtmSGRBVFh0STFMalUy?=
 =?utf-8?B?UWNjZnZZdWxrcWh2L1lId2RzOG93aElqRWllUGhQVk9sVjdNTnRyUkVXcW80?=
 =?utf-8?B?UmJQeTF3Um80MkFpOTltaFM3OHJhdG1ydmU1ejJGcVdWQlRvVDZQM0hsanNh?=
 =?utf-8?B?blV3bnRtS3k5Zm9tenlQSkJCVDZDS2czc1k1VzFLOFFzelozNFlKenRzMS9M?=
 =?utf-8?B?aG0rdFYvUWJZWkp1Q1NHU0VJcjZXRzRURDMzRXMxcW5wa0xQcHhFQ1ZLS3ZW?=
 =?utf-8?B?VWpEa1pIbE10VGF1aXJIeXZWN1J1aFYwNk5PcEx5V2gvL09IU29ORHUxWmhu?=
 =?utf-8?B?Yjd2SkJLNktNbWRuS3JQZVBDYm1jYnpBd0hQSDVMcGFPc0p1aDRGdjBqbHZC?=
 =?utf-8?B?R1FFaWlvOHVlUW1JcnJGdCtUZ1A5aTNhMEk5YjdZZTBQVzVQTTlCVHZvKytZ?=
 =?utf-8?B?Q2V0QUYydGRTUUtLaFBzT0VlaFBhRTNrYWQvNzJvTDA4c1RyUTVZR3h1cWJm?=
 =?utf-8?B?TGh3Tm9VS3AweG1mZFRHODdkTGErZFl6dUFMR2xqa0VWUW02YTNVNE9IMFds?=
 =?utf-8?B?TDRPRjMzWVRZVHVBMm5HeURwUFRPR0MrSWRzZEpGTDE1WjA0WkNaaXFDQ0lz?=
 =?utf-8?B?VkN5S3JtdkVKeGloL2RPMkp3RG5YMlFPTWRIQ29EbkhSQmwvRG01czJBV0RZ?=
 =?utf-8?B?MlBteVR5TG5IdUFRT00xNlNYSWFMbmZ6eGdtalRXOEJ6UE9LSnA0RDZXOU54?=
 =?utf-8?B?V0wya2lHakRFRDZkSnBCOHUxajhCbis5VnBxY0hhTGpSRjRUS0pabU44ZE5y?=
 =?utf-8?B?b1RZSnNiVUxMZHh2bVJxcm40MlQ3ZHpwQm5xODJzL0JXUlRvVWJFMHBoY2dY?=
 =?utf-8?B?dzEwczJNYXhsZXZWQlFWSC96QzZRdlFuTDh6RkN0Z1BsT2UxajE2ZTkraWc1?=
 =?utf-8?B?TWRVUFNWZFNUZ1JyL08zS3Vjc0Z1cDZxSG5tZEJSdjl2YkpRZWxCMktzNUls?=
 =?utf-8?B?YjBPQUZJOU5yV0tET0ZQVjhaNzBJTHBVUmw0aDcxbjNyTlppS1hpQzZ5UzFT?=
 =?utf-8?B?WG9FaHoxRElyNE1hYWE0MVExb3EyUEw5YVUyUXpDUDArOG94SjVOYVdxSCtm?=
 =?utf-8?B?L3l3a2V0N1kwc29kbHh6d0xqRCtoYytBTHVKMlNkdTdmeUNLTzViUUZVMmRH?=
 =?utf-8?B?ZllpZnFZOGFPZFl0ekZyUzFXKytjSEo1K0NhNlYyOVBIeXpxWGdOb0pNYVFF?=
 =?utf-8?B?bC9wTGdCV3JPZFJPaUZpallHbDFLcEh4TERTUkhhNXp4UGs4OHhiTHRQbjJG?=
 =?utf-8?B?bG1JZU9pcEJyWU1IdFQ4NFg5Z1dJTFZYVjN3WXliLzcyZ2tlaFNOaDVTTFZH?=
 =?utf-8?B?QUwzUDhqT0tpMmhTL3hGVmdVTG9sdzY2eTBSOWVrbUk1WlpXanc5b0ZEQ3pp?=
 =?utf-8?B?RkFCL0JUVWEyeGNRZitvdC90NkJVOVdNcWc5TmJaelNrT2lUVkdIS2NLcXhz?=
 =?utf-8?B?NmQ5VVdaNUhYd1l3WkhwekliUTkvd3poTzh4SXhYTWlTU3JiVytSRmtqamEv?=
 =?utf-8?B?VlduTi9CNjYzNnhiWmFGNVVJK1dNM3pvZ2FSVHdza2tOK05uN2RwNldvS3cv?=
 =?utf-8?B?ZTZFT1RDYVlNc2ErWkpLMnZtL2lSWEtFVnVyK2xYcFZ2bGExdTZYYUNpM0wr?=
 =?utf-8?Q?7uCY84qLT3YLphwetmUrAfnIq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E67A9E65B34C046A6E4F7F8F7A2A0C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ab2bca-5121-4a61-b7e6-08db9bab0325
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 03:11:39.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1/I4ZlyPMB01C0JhsIIFL6jAeUhChwakdsy9FmbswwoB5VbKUN17w0lYN0C9f7B9QjtArA2kC8LEkn9PZt5LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
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

T24gRnJpLCAyMDIzLTA4LTExIGF0IDE4OjU1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6NDXigK9BTSBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEFsbCBvZiB0aGUgZXhpc3Rpbmcg
Y2FsbGVycyBvZiByZW1vdmVfZHRzX3RoZXJtYWxfem9uZSgpIHBhc3MgYQ0KPiA+IHZhbGlkDQo+
ID4gcG9pbnRlciBhcyB0aGUgYXJndW1lbnQsIHNvIGNoZWNraW5nIGZvciB0aGUgTlVMTCBwb2lu
dGVyIGlzDQo+ID4gcmVkdW5kYW50Lg0KPiANCj4gVHJ1ZS4NCj4gDQo+ID4gUGx1cywgd2hlbiBj
YWxsaW5nIHJlbW92ZV9kdHNfdGhlcm1hbF96b25lKCkgZnJvbQ0KPiA+IGludGVsX3NvY19kdHNf
aW9zZl9pbml0KCksIGl0IGlzIHBvc3NpYmxlIHRoYXQNCj4gPiAxLiBkdHMtPnR6b25lIGlzIGFu
IGVycm9yIHBvaW50ZXIsIHdoZW4gdGhlIHNlbnNvciBmYWlscyB0byBiZQ0KPiA+IMKgwqAgcmVn
aXN0ZXJlZCBhcyBhIHZhbGlkIHRoZXJtYWwgem9uZQ0KPiA+IDIuIGR0cy0+dHpvbmUgaXMgdW5y
ZWdpc3RlcmVkIGluIGFkZF9kdHNfdGhlcm1hbF96b25lKCksIHdoZW4gc29tZQ0KPiA+IMKgwqAg
ZmFpbHVyZSBvY2N1cnMgYWZ0ZXIgdGhlcm1hbCB6b25lIHJlZ2lzdGVyZWQNCj4gPiBJbiBib3Ro
IGNhc2VzLCB0aGVyZSBpcyBubyBuZWVkIHRvIHVucmVnaXN0ZXIgZHRzLT50em9uZSBpbg0KPiA+
IHJlbW92ZV9kdHNfdGhlcm1hbF96b25lKCkuDQo+ID4gDQo+ID4gQ2xlYXIgZHN0LT50em9uZSB3
aGVuIGFkZF9kdHNfdGhlcm1hbF96b25lKCkgZmFpbHMuIEFuZCBkbyB0aGVybWFsDQo+ID4gem9u
ZQ0KPiA+IHJlbW92YWwgaW4gcmVtb3ZlX2R0c190aGVybWFsX3pvbmUoKSBvbmx5IHdoZW4gZHRz
LT50em9uZSBpcyBzZXQuDQo+IA0KPiBXZWxsLCBJJ20gbm90IHN1cmUuDQo+IA0KPiB0aGVybWFs
X3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIoKSB3aWxsIGRvIG5vdGhpbmcgaWYgdGhlIHRoZXJtYWwg
em9uZQ0KPiBpcyBub3QgcmVhbGx5IHJlZ2lzdGVyZWQgQUZBSUNTDQoNCnllcy4NCg0KPiAgYW5k
IGl0IGlzIHBydWRlbnQgdG8gcmVzdG9yZQ0KPiBTT0NfRFRTX09GRlNFVF9FTkFCTEUgb24gZmFp
bHVyZSBJTU8uDQoNCmFncmVlZC4gUmVmcmVzaGVkIHBhdGNoIHNlbnQuDQoNCkFzIHRoaXMgYmVj
b21lcyByZWFsbHkgdHJpdmlhbCwgZmVlbCBmcmVlIHRvIGFwcGx5IGl0IG9yIGRyb3AgaXQuDQoN
CnRoYW5rcywNCnJ1aQ0K
