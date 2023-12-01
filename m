Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DD8011E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378903AbjLARlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjLARlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:41:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901EF3;
        Fri,  1 Dec 2023 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701452486; x=1732988486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LiVjQxqZo7tGxscBk0Cj6GkUslHh0InBu0uJRTsGNHo=;
  b=K37mStWlj7VEhuG74T5/RRmITxubK/ywLISfOymHTYZTkuAGET9AqRvq
   HCE+XaPgowXAOAx2pMOC0wfE2avrCKHWxqGcNIjUBjBCghqIb8OAnQUYI
   1UoZA6O5tXNv+S0/OxmRvCJNsHtbhBfXXXVjjpG+pWEmulLVKD0k5l/ad
   xW+8l0fjR4lrCXu0kILizxWnk5flnDRr++A+AHHRTyN/UO9Qbi7Vo1Q2Z
   B08q19F/vUT+o4JsH3f7LOUpVFscgtvTNelcc5cJZ/EEMXjs6YNjFJJBF
   91pcItLmtSJZHezW3yJOFkhjikME6fIqWCBOT4yh8QNMp+Jr+fRIAZ7CQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="538988"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="538988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="746086754"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="746086754"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 09:41:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 09:41:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGycaccYc5JGTuUHvARW/v6W2/aYTdYWnpew8btIx4ZwSvLOt6e3lw5e/FJv9CTrI097mOKmwq2z0sxKTduxz/sk4/c8+39AGlvcmuZImKjppxFZDZiq3OJYcxhS41ar+vdOcvcZnwHEh+rUs+1iiA0ExcsRTfIOTl8iqn3U2IeuQmJysJp4tuAuniWZdCtwBfV7TQeTBrSF/FhNUnMXTylWK5wE9Q6N+LD8pq+kGvAk0lm3WWLWAcfiP5+E24vsa5GNHxNu1fzXTblJIhI8cf/96rxT8FPI87skUBEeLZ/txZxPV7Mo0MbHYY6dd/Fd6VN9nbA/BWfZD1upPqt50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiVjQxqZo7tGxscBk0Cj6GkUslHh0InBu0uJRTsGNHo=;
 b=XjONzKjV9w7j1OhE9xB8Bv+QokYQGgCIB32bUSc8t+eksY01QmB38W4pnTPJJcArZ0xCnXboz1TMYuMdo9+somYxDGOhsPKbA7iIUSamS1KNYBW97BbDW62JxkjcUFgRHu5fB8ukpHcjuYXMAcK4DyRvszFmvKctzW8tOkiu9YxbkJeYt+88si2K7fzdwc6V5flsTChFgnZhV67eoKSPuBvpDZccrrv+gWj7XiYFUGxi/AKX8ObEDzyFOKUubPwSo6d1HXvDp+s++CbN4PuWccHV27gmR31uF7q/T8HKqdKX52lURnk38AZC3fisWZsi9rf5XcsYESuPv+UnmQBoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.28; Fri, 1 Dec
 2023 17:41:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 17:41:19 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Thread-Topic: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Thread-Index: AQHaITQZBbXp8QjFIU2kvTj7Yr0p3rCTxEoAgAD0ewA=
Date:   Fri, 1 Dec 2023 17:41:19 +0000
Message-ID: <f9e69ebafe7e767eeb1fba250af9c9f7629bae5e.camel@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
         <20231127131651.476795-4-rui.zhang@intel.com>
         <91a3f785-8d69-4425-ad23-a6ac0ebddb07@roeck-us.net>
In-Reply-To: <91a3f785-8d69-4425-ad23-a6ac0ebddb07@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN2PR11MB4629:EE_
x-ms-office365-filtering-correlation-id: 66ca851c-a67a-49a5-e5a1-08dbf294ba1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odrrs3KqJAJ4zzlLSKsP4YOWuOt7rDZ8GXiO5PgqdHk23PCe0t2c4hqzMVWcI267h1Z8Q5QzZT8QaPXzBI3Lc0wu3JslOAuhTNYpSsqZ895i9cK5J7Lp9j+zfmnyGcoxQLx4lMKZAH1UrXOdAh9MQgaXVOekawMOPjqIMexj+NMweFLtj+eXQOpSzMpxpMr1Clgy4kTa43GgbfeZzf4wvDDQlfJd3lCYcnur0XgqsFdw1A7lhejmVK8sBiJX9kcqHfdEuDNkWftHte4t4nH+xU6Y7/1vC1vvBE0H6V8ZEV/cps8Gqd67pPcDcA195xk6I9ZPckoqstZJ7EfClfxRbVkEVPXuRN35mlDQ2asEB8qrw0la7RR1kym39xBEI9GE9I4RyizzwfSjnX/CNaxmqG1qUzo+Ob6MBR7r7axW99U4DdwmWs7o0CNH5C2txTEQ7AzVyOO9DW3pdtwd2Lj6IXn2anRFfZ8L0yXJ5n9hwMAWhVeG03ewRG+YoEY2xEQ8tZkmssx4D9Wj8VUqDSlk9zCiBkoglC6gcFje3gohsfa2d2faIunwZv01n3MhDOKCzwgkSDXOyNW1N0dxWOwWvkauBXyE5yJBUxfIF+leHsHNs3ie524ALLrdFSW3iczT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(66476007)(76116006)(66556008)(66446008)(66946007)(54906003)(64756008)(91956017)(110136005)(6486002)(478600001)(71200400001)(5660300002)(38070700009)(41300700001)(36756003)(38100700002)(2906002)(4001150100001)(8936002)(86362001)(2616005)(4326008)(8676002)(26005)(6506007)(122000001)(53546011)(6512007)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3dxQWVUU0hxb3BTWnZNMFVjWWgwZWhhNjZKSVBIS3RxL2VlZUloNXpqQ0JQ?=
 =?utf-8?B?YURCNTNXeGxhSnpnVEoycDdWbXpnVjZCbm9scURFY3pVYzJXSkV1Z0FrYnlr?=
 =?utf-8?B?YlRyU2trTk9Wb1poVk94c3VuQ2lvT3gzQ0syYW5SVTlUNzV5bUdYcU4xQ3hI?=
 =?utf-8?B?L2RaNXdYTnJsbzhJcFEvOEx2YzJGUEtWMmFRL0JYelhZRk9CcFJHMFhVK2Jt?=
 =?utf-8?B?R2F2QURERlRYOERYei92a3AyZHdVMmNxeG5NTXJ4eTJIbnh4cERrTmx5d2VY?=
 =?utf-8?B?TE93Z1NXMmVZRUl3eE5tSkx0UW4rTWFHOFNXWmQwOTkrL1pqdCtvQkkxSFY1?=
 =?utf-8?B?bWNYTm1RSzVBMWR0YXZDWWJ6MEpqaWlGTjl2L3p4cXd4OU5yR2ZGVk8yMk93?=
 =?utf-8?B?OVpnUnhqN0VCcnduTERQTDNyQVFIOWY2aFR2Q3ZSWDR4U2JybThjbzAwSjhD?=
 =?utf-8?B?LzdCS2RsSkwrSVpGYk5UZ2Z2amJqRUJYdFZRYUhob1Y2aFcvQ0c5S3VwazNr?=
 =?utf-8?B?VHFHQit2YkNiSVFnVzF2dy9LbW5GS28yeGtJeGVhZW9WMnNZclNHOFdHWXgy?=
 =?utf-8?B?ZkxwemxoL21qbWY0ZXRSL2lKYlIvaWhtR1JjS3hYdmtrZHY4aHMyTXJVRUxz?=
 =?utf-8?B?SktaVWJMUlMwaTN1NzlyQ2xIZEV6K1AzSU5xdGdZR0VML2ZlY2U2YXlxd2xS?=
 =?utf-8?B?VndrNm5qdlBVRG9WK2tlSzZCNWxSWEQvZHJGVG9DdHZLbEl1bitDNEEramdU?=
 =?utf-8?B?Umsvc0ZMMTRhUStNNEQ4R0wwaDVXWVNRWk1tbmh6aENEWmMwOFNTa1RQQ0ZV?=
 =?utf-8?B?dXJscjNpeUxPbXZZV3dTTERCTzBJMFJ2amYyeWlUdnBRd1RHTlg4R1VlUkRq?=
 =?utf-8?B?Ukd0UFBORmt6NWEwTC9UeGtGWnJ5NWVwY3hGM2RNK0RpZ3YyaHB2ajUvblY2?=
 =?utf-8?B?L0pMTnpEYm8xWHFlMTZybmJwaUFaN3FudUhPMUkvdm01TVc5emsxTW1HS3RH?=
 =?utf-8?B?VENGaW5LOFpIaWVadjEwRml5eW1Kc21yUmZDL04wOVNPOEtFYlZ3NWlzVEQx?=
 =?utf-8?B?b0pQQUwzcTJZTDJ4WWc0UFdGS2MrSmpUVGJsa2Z3bXRkcE1nUU5XM2NEckZD?=
 =?utf-8?B?NUNmUDliRWJEaTdYbFloU1FoTXhqNURMSEtjWHB5Sjdab2M0VDJsNXpoQ3NP?=
 =?utf-8?B?T2t1bXZKQjZjejF3Z1BScFY1ZDY3KzM4c1ArMEpYRDNkVkhxK0NWNTBOcTFF?=
 =?utf-8?B?cTYrNmkwYVRlMWpkbU9YeTdSVVZzM1BKaDFIM0lxU0hFb1RwZDY0aFk5ZjNk?=
 =?utf-8?B?VHU3M1JmSm9LZFhLQ2JXNVJoT0J6L0oyWHVGRmh4dE1NR09FR2k1VEFGLzl1?=
 =?utf-8?B?aUtHclBlSmNNZVlZM3JQVStweVE0TEl1VWhiRUxCdXVEUjNWN0k1aE9mazVX?=
 =?utf-8?B?YWdnM0hMTFNCdHU1TWNwM3ZKc1NqQTFHNFN3ckdQaHdEaWZSQi85TzZUWkp4?=
 =?utf-8?B?ME8xRHVCbFNCKzk0SUNWbjA3alR2NzM5QTZGbFhsM0xnQVNqaC9BcTlCeGlD?=
 =?utf-8?B?SU1SMVlNN2g5b2lMTXU3bGtndngwNzg3ZnoweWdvcmxkTDY5ajZhUUNVSVA3?=
 =?utf-8?B?RDk1QzdBclNYWTFWcnB2R1hLRGJZWU9GV2ljZCtjbkQyRGgzREdrcVhxa0Fh?=
 =?utf-8?B?R21wVXRFTGVWNkFlS0toNHp1M2xxcnlIUzFJNTRFeEtxelFuSjZ2UXd2eVV2?=
 =?utf-8?B?T24zM0YyVEtFcjU4bHAwMUZRTW5ZdmE2T2dmei91Z3NYN3p0RzY0N2NDU1RX?=
 =?utf-8?B?eXZndEN4OXR5VUFBc05iK1pTTzJvNUhaVmEwdEtEQ0RDRjlNWEJBdXA3aWhJ?=
 =?utf-8?B?SGxWMmVXNE5wbkZoTk44c2ZHallsNDZxRlhmcmF6ckVyUG05SjliZlRYUTJn?=
 =?utf-8?B?cDdidmJPUnEzZ0ZpckdVaEpBRGZsMFoyR3JSR1N6S2dhQ1VWWXZsQXR5S08w?=
 =?utf-8?B?ZHFSQ0x5cUJKSnpUUTBsdnc5MmJXWVlhTXdaV3pqRE1xaDIzZUpuMCtXL3Qr?=
 =?utf-8?B?eGxoTy9NNHFhbXNpQWU5c1g2ZmdEU0V3N1dibE1xMFhnaURRaUhWUWR1R21T?=
 =?utf-8?Q?fwGJnkoBl4W7fkoAslYO85f7q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15524D7C4C204949AFF5C6236E672039@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ca851c-a67a-49a5-e5a1-08dbf294ba1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 17:41:19.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6hxmzwOWXvYT7C95hp8rb0u/ZQSdiHl7EdzMHrFiNRls165RTbfekRHtbMWf0OtAnD8lImhrdQ/SfQJZgb8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTMwIGF0IDE5OjA2IC0wODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
IE9uIDExLzI3LzIzIDA1OjE2LCBaaGFuZyBSdWkgd3JvdGU6Cj4gPiBDdXJyZW50bHksIGNvcmV0
ZW1wIGRyaXZlciBvbmx5IHN1cHBvcnRzIDEyOCBjb3JlcyBwZXIgcGFja2FnZS4KPiA+IFRoaXMg
bG9zZXMgc29tZSBjb3JlIHRlbXBlcmF0aW9uIGluZm9ybWF0aW9uIG9uIHN5c3RlbXMgdGhhdCBo
YXZlCj4gPiBtb3JlCj4gPiB0aGFuIDEyOCBjb3JlcyBwZXIgcGFja2FnZS4KPiA+IMKgIFvCoMKg
IDU4LjY4NTAzM10gY29yZXRlbXAgY29yZXRlbXAuMDogQWRkaW5nIENvcmUgMTI4IGZhaWxlZAo+
ID4gwqAgW8KgwqAgNTguNjkyMDA5XSBjb3JldGVtcCBjb3JldGVtcC4wOiBBZGRpbmcgQ29yZSAx
MjkgZmFpbGVkCj4gPiAKPiA+IEZpeCB0aGUgcHJvYmxlbSBieSB1c2luZyBhIHBlciBwYWNrYWdl
IGxpc3QgdG8gbWFpbnRhaW4gdGhlIHBlcgo+ID4gY29yZQo+ID4gdGVtcF9kYXRhIGluc3RlYWQg
b2YgdGhlIGZpeGVkIGxlbmd0aCBwZGF0YS0+Y29yZV9kYXRhW10gYXJyYXkuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KPiA+IC0tLQo+ID4g
wqAgZHJpdmVycy9od21vbi9jb3JldGVtcC5jIHwgMTEwICsrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0KPiA+IC0tLS0tCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9u
cygrKSwgNTggZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9u
L2NvcmV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKPiA+IGluZGV4IGNlZjQzZmVk
YmQ1OC4uMWJiMWE2ZTRiMDdiIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9od21vbi9jb3JldGVt
cC5jCj4gPiArKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKPiA+IEBAIC0zOSwxMSArMzks
NyBAQCBzdGF0aWMgaW50IGZvcmNlX3RqbWF4Owo+ID4gwqAgbW9kdWxlX3BhcmFtX25hbWVkKHRq
bWF4LCBmb3JjZV90am1heCwgaW50LCAwNDQ0KTsKPiA+IMKgIE1PRFVMRV9QQVJNX0RFU0ModGpt
YXgsICJUak1heCB2YWx1ZSBpbiBkZWdyZWVzIENlbHNpdXMiKTsKPiA+IMKgIAo+ID4gLSNkZWZp
bmUgUEtHX1NZU0ZTX0FUVFJfTk/CoMKgwqDCoMKgwqAxwqDCoMKgwqDCoMKgwqAvKiBTeXNmcyBh
dHRyaWJ1dGUgZm9yCj4gPiBwYWNrYWdlIHRlbXAgKi8KPiA+IC0jZGVmaW5lIEJBU0VfU1lTRlNf
QVRUUl9OT8KgwqDCoMKgwqAywqDCoMKgwqDCoMKgwqAvKiBTeXNmcyBCYXNlIGF0dHIgbm8gZm9y
Cj4gPiBjb3JldGVtcCAqLwo+ID4gLSNkZWZpbmUgTlVNX1JFQUxfQ09SRVPCoMKgwqDCoMKgwqDC
oMKgwqAxMjjCoMKgwqDCoMKgLyogTnVtYmVyIG9mIFJlYWwgY29yZXMgcGVyCj4gPiBjcHUgKi8K
PiA+IMKgICNkZWZpbmUgQ09SRVRFTVBfTkFNRV9MRU5HVEjCoMKgMjjCoMKgwqDCoMKgwqAvKiBT
dHJpbmcgTGVuZ3RoIG9mIGF0dHJzCj4gPiAqLwo+ID4gLSNkZWZpbmUgTUFYX0NPUkVfREFUQcKg
wqDCoMKgwqDCoMKgwqDCoMKgKE5VTV9SRUFMX0NPUkVTICsKPiA+IEJBU0VfU1lTRlNfQVRUUl9O
TykKPiA+IMKgIAo+ID4gwqAgZW51bSBjb3JldGVtcF9hdHRyX2luZGV4IHsKPiA+IMKgwqDCoMKg
wqDCoMKgwqBBVFRSX0xBQkVMLAo+ID4gQEAgLTkwLDE3ICs4NiwxNyBAQCBzdHJ1Y3QgdGVtcF9k
YXRhIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYXR0cmlidXRlICphdHRyc1tUT1RBTF9B
VFRSUyArIDFdOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgYXR0
cl9ncm91cDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbXV0ZXggdXBkYXRlX2xvY2s7Cj4g
PiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7Cj4gPiDCoCB9Owo+ID4gwqAg
Cj4gPiDCoCAvKiBQbGF0Zm9ybSBEYXRhIHBlciBQaHlzaWNhbCBDUFUgKi8KPiA+IMKgIHN0cnVj
dCBwbGF0Zm9ybV9kYXRhIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCpod21vbl9kZXY7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTE2wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGtnX2lkOwo+ID4gLcKgwqDCoMKg
wqDCoMKgdTE2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3B1X21h
cFtOVU1fUkVBTF9DT1JFU107Cj4gPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWRhwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlkYTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3B1bWFz
a8KgwqDCoMKgwqDCoMKgwqDCoMKgY3B1bWFzazsKPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCB0
ZW1wX2RhdGHCoMKgwqDCoMKgwqDCoMKgKmNvcmVfZGF0YVtNQVhfQ09SRV9EQVRBXTsKPiA+IMKg
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBuYW1lX2F0dHI7Cj4gPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgbXV0ZXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb3JlX2RhdGFf
bG9jazsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBsaXN0X2hlYWTCoMKgwqDCoMKgwqDCoMKg
Y29yZV9kYXRhX2xpc3Q7Cj4gPiDCoCB9Owo+ID4gwqAgCj4gPiDCoCBzdHJ1Y3QgdGptYXhfcGNp
IHsKPiA+IEBAIC00OTEsNiArNDg3LDIzIEBAIHN0YXRpYyBzdHJ1Y3QgdGVtcF9kYXRhCj4gPiAq
aW5pdF90ZW1wX2RhdGEodW5zaWduZWQgaW50IGNwdSwgaW50IHBrZ19mbGFnKQo+ID4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiB0ZGF0YTsKPiA+IMKgIH0KPiA+IMKgIAo+ID4gK3N0YXRpYyBzdHJ1
Y3QgdGVtcF9kYXRhICpnZXRfdGRhdGEoc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhLAo+ID4g
aW50IGNwdSkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0
YTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJnBkYXRhLT5jb3JlX2RhdGFf
bG9jayk7Cj4gPiArwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRkYXRhLCAmcGRh
dGEtPmNvcmVfZGF0YV9saXN0LCBub2RlKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKGNwdSA+PSAwICYmICF0ZGF0YS0+aXNfcGtnX2RhdGEgJiYgdGRhdGEtCj4gPiA+
Y3B1X2NvcmVfaWQgPT0gdG9wb2xvZ3lfY29yZV9pZChjcHUpKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGZvdW5kOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjcHUgPCAwICYmIHRkYXRhLT5pc19wa2dfZGF0YSkK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBm
b3VuZDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiAKPiBJIHJlYWxseSBkb24ndCBsaWtlIHRoaXMu
IFdpdGggMTI4KyBjb3JlcywgaXQgZ2V0cyB0ZXJyaWJseQo+IGV4cGVuc2l2ZS4KCkkgdGhpbmsg
dGhpcyBpcyBvbmx5IGludm9rZWQgaW4gdGhlIGNwdSBvbmxpbmUvb2ZmbGluZSBjb2RlLCB3aGlj
aCBpcwpub3QgdGhlIGhvdCBwYXRoLgoKPiAKPiBIb3cgYWJvdXQgY2FsY3VsYXRpbmcgdGhlIG51
bWJlciBvZiBjb3JlcyBpbiB0aGUgcHJvYmUgZnVuY3Rpb24gYW5kCj4gYWxsb2NhdGluZyBjcHVf
bWFwW10gYW5kIGNvcmVfZGF0YVtdIGluc3RlYWQgPwoKUHJvYmxlbSBpcyB0aGF0IHRoZSBudW1i
ZXIgb2YgY29yZXMgaXMgbm90IGF2YWlsYWJsZSBkdWUgdG8gc29tZQpsaW1pdGF0aW9ucyBpbiBj
dXJyZW50IENQVSB0b3BvbG9neSBjb2RlLgoKVGhvbWFzIGhhcyBzb21lIHBhdGNoIHNlcmllcyB0
byBmaXggdGhpcyBidXQgdGhhdCBoYXMgbm90IGJlZW4gbWVyZ2VkCnlldCBhbmQgd2UgZG9uJ3Qg
a25vdyB3aGVuLgoKQSBzaW1wbGVyIHdvcmthcm91bmQgZm9yIHRoaXMgaXNzdWUgaXMgdG8gY2hh
bmdlIE5VTV9SRUFMX0NPUkVTIHRvIGEKYmlnZ2VyIHZhbHVlLCBhbmQgZG8gZHluYW1pYyBtZW1v
cnkgYWxsb2NhdGlvbiBmaXJzdC4gQW5kIHdlIGNhbiBjaGFuZ2UKdGhlIGNvZGUgdG8gdXNlIHRo
ZSByZWFsIG51bWJlciBvZiBjb3JlcyBsYXRlciBpZiB0aGF0IGluZm9ybWF0aW9uCmJlY29tZXMg
YXZhaWxhYmxlLgoKdGhhbmtzLApydWkK
