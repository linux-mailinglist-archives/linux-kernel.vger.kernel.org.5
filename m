Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA65780C55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377048AbjHRNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377035AbjHRNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:10:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D41273C;
        Fri, 18 Aug 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692364230; x=1723900230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FzKsjU9Wng96DmybAh4t765fpbm8Z4eZK88TPaIO2sE=;
  b=cfkvDyr/CK25oxR2GQ7Ilk8uo+SYr8uzGlZtpsW7LWBqTfPZl6uFcOB3
   pYKU7XRKgA/tkrYprLon1VDqGdLE2B5U2qtaqQBaAA4nUTbDt8CJBuz2u
   leMmR0k26rry8I9STJBHdmHm4uUV3O9M7us7v8pqTBg6SoEDF+LOs7cD2
   5AjAwCgX9PcEXywEuYs7qU2DMDooRxyeE5X94DGMzOSWUYlBKGZMbEOaB
   wuxzvdMdBlD74M/o8PKXvU8KRFZVEjP/dmuwgsLkuytbJ6FhnIvlj3SMZ
   qN/lFJij2sRHnJXSJTuJ3qJP+7ct2nMGo1WRH9VGWIf+EzIhEjQwMgVFq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363254916"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363254916"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764563739"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="764563739"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 06:10:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 06:10:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 06:10:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 06:10:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 06:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyXfpoILrAw8SuKRcpZCP0Uvg/g05IxFZNZ/kDx2K/b3b8FHFJsz6nCQXqslchuSyBTNCypeAUWYnFz7R2YE+AGEF7maOzhNYQR3S+cmS3yEw7yRbSRy7g2FtL9GjTBWZ348XnH41g4zY8hsB7A701eE734JRZJcGmvb3niW1CCMvqzSF6bYkoAvoK/NL+tE1vG6gjvDLNL5KCBV2xFmjuOjHAVdc+5KfKrWaYO6VYzK5A3IhvR5HuBB+82KPEd8x79QDUkgreDA9z5Fs0kRfBW5SoNA59DHQcW5dsERQkwhYUfFoo/m+Rq8EqHExlnxTDbQVrT6zppqfMh4NSVlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzKsjU9Wng96DmybAh4t765fpbm8Z4eZK88TPaIO2sE=;
 b=BX2QLMZpOF3J/xtrN+PKmbZNZC6u+KUuPT0c14TgLFcGBPZYv1piS9Obci/Od2MlqVoiOMxakn8cw7l9eUbu4L6rhttjQYTRXqokU2Mg8lQADZ3En5Y9Uk7rLLtQ+yeujaEiXE2unXqVZxsi7AxUK/Ah0zngTDsj+FcA+HHjsCa3n8IPzTNXee9pQ2nlzM3QOgpeW9A0IAiYiF30SwG9j+1la9NJv/SpVZmkI7xpc3ySknphnMZochUD8ogrBVJ+XEmq0AA5TSUApdcBkPpnd2P4FtmrE8H2IwdYcSA0X2sJZDAvHPZYrReC5CVMvuZ+VbyBgOXjb4yQGbL+LhpoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:10:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:10:06 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6/8] selftests/sgx: Ensure expected enclave data buffer
 size and placement
Thread-Topic: [PATCH 6/8] selftests/sgx: Ensure expected enclave data buffer
 size and placement
Thread-Index: AQHZyi8cLf4tLyn+l0SnSKbuHr/oXa/wFjuA
Date:   Fri, 18 Aug 2023 13:10:05 +0000
Message-ID: <0885be8149082c17fc56261231c5210d693789af.camel@intel.com>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
         <20230808193145.8860-7-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-7-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4532:EE_
x-ms-office365-filtering-correlation-id: 6e57127b-009f-4de3-4ac0-08db9fec7109
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrzJVbKdbRg6cgh4MyI7LXgbbn6SqbbSYj46CNJ5mkhZFqhI5yMmo3TV2G0OcjcC9IyZVoEkBJZQ4WQLn4nb5SjWG9+MrH7qev8qYNiXOn8FPVgdfnhaJoGyI8DkpGT3sbkGR7OnzKeNgQV7Xdekvi7A7relNx6xTTSKQ0FC/KULe6yNjMhi7i5qZknK55lvmdRMok29PCnMKc47tARWJ8lsfNZlxQQOlKi1uB0gzaz8AkVG/net2RK/wm5X7+fsMJodf8aM3/J/oZegs9iqPyK3uTzSz8wD37OpZz+jTPSNkT2Q7wTDbpa2V41rIxgpQG1yzwq9hXh0JRjljIVAaFo8+ZKeLs1bdh1C3SE8+6I5rnnaoyTG1fhcVDLipyf0gheR2K4GYTtoKtdHeZLHFIEbXVzPUlBh85kD9nM7VuF7R4T3iBRdsq7Fv6FYSU/T6Pv3w4l2k9erDgDYIikayHOWY1umhLm1dPyJG8YF+8Eic+lkS9ETK3omSGaeE0wy+hcfeVpzumSJVNhUGLLYUBYFgqEWZLNm1ZHd9GqXDVt3FQIfva8zHVO4XRmQptDbi9rRkBagIoh/QfY/QnLTN8FOet1IMwxuJjJLFJ842y8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199024)(186009)(1800799009)(2616005)(26005)(71200400001)(6486002)(6512007)(6506007)(83380400001)(5660300002)(8936002)(8676002)(4326008)(2906002)(478600001)(966005)(41300700001)(76116006)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(91956017)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01oajdwQmxNMnlHaDdHRFU5QTVpMHJjNVRnM0plS0NXczJGL3lDd1NPSExO?=
 =?utf-8?B?ZVBzVnhMRjU1WHhVL3lxTElDS1cwRkxUSmNXTGRQMGs1b1RuTllSdGhNWkJQ?=
 =?utf-8?B?SlZXV2gxSm56c1l3MGhOTkVEZFRSbWg4NTdJL0t2blJuV3pTNXVkbm55cFRz?=
 =?utf-8?B?T0R5Tzh5UHA4cUJlQVRPRkFiR2JkM1Vla29vU0h0VkpDbzVxcUtXK0xnV05a?=
 =?utf-8?B?NlFuTjNycGdyVnl3OWdzSDhUczJER2ZIdFZzbHZPTXNpeXIwZ2hnRjd4U2Y0?=
 =?utf-8?B?WGQrQnNWWHRqK3JGSEJ1ZGVLM01zL0toSXlXR2IwTzJlOXhBL0ZVc2k2b3ph?=
 =?utf-8?B?VWxUQzduY2hKYVd2V1loNWJlbmNITmhTaHRLTDBVU1RxZ1JGaElIblpnUUoy?=
 =?utf-8?B?UllBZDB4MFk5VXFNU3kxV0JPaFE4OHEyQS9qY29xWkJYVlhITFlzODdqcnU3?=
 =?utf-8?B?RjgxVm9vOGZmS3JsVGdlWnArNmRSSUozcWZWVUtIOFAwZVdUSUNpRXRzZ2ll?=
 =?utf-8?B?Q0ZoZnpISXZsQzNTUitTQ2JJOHVFN0tUWHNOZHU3Y0EwcC8vbElPVTRVNWdL?=
 =?utf-8?B?YUhnUEpNRmcrWHNhUEpiUVdpK1dNU2E4dG1jY1RVc1Raa3U1dy82RnF1Z285?=
 =?utf-8?B?bXdHWTNGMUFIRlRkcERqQjFadGZnYTYxclU0SFBHc2ZZYnFQTTN5Q3QrSHo3?=
 =?utf-8?B?akJ2cFVieG1VY0hLUC9NVTNMSk9qcGZ3ZXlJK2JrWk1FNmNXMXBDSU15dWZa?=
 =?utf-8?B?Vm1vMTFCc2xMSjlOcVJGLzJYbVRORWdtNzhzcERqZGhkRnRnTldQZ0N0NE9R?=
 =?utf-8?B?V2RGV0h3SHg0UHd2eHo4djZETnp5MzkxWUJuRWZwUXBFOXpYSHV2L0UvVS9x?=
 =?utf-8?B?alZ1alVWUVZ2c05hSERWWHVJSVJpYUVnM3lNckVtNzhLbklTSmM1R1RIK3lu?=
 =?utf-8?B?YmQ3cWg1R0NIcXB3U011Sm9jUUxCcDVWeFIzaFdnME56RFQzOHhtUEpnMzY5?=
 =?utf-8?B?cWovTEZxbXZNV3RwQmhWOVgyemNLZTd1Ti8wakdISE1rWTl2WTVydm5yU1BT?=
 =?utf-8?B?L1FXT1pUQVkweGw2UXVseGdSNVBOUFRncTVxYjY4eGl0d0FFZ0JuT2pOTW9a?=
 =?utf-8?B?cU1jYTVqcjJvWFNZN1VzMHU3WG00cjBjRUZscmVrenc1RkM3NG12VDJwOVc0?=
 =?utf-8?B?L0ttRkovUk5BSmh0VDNXSk5wYUlucXFUSEYyYzg2S1p0WVA2WmtWQ2Frbjhx?=
 =?utf-8?B?eFNnQm5xYUp6WUE1N1RPY2ZwMnN3UldHTEY3M3RHenk2VTlTRlg2b3IwdWJF?=
 =?utf-8?B?bStjVDUyeFFIaWN2SEltVHB2bU1YYjErM0ZyZVZGd1ZPQlZpaGNwa0t4N1ZH?=
 =?utf-8?B?ZkFkYUhLdHFxS0RmTkhoWnFHNHZHMnk3SjJUc0RPcXFicERNQWFhYTRnK2Ro?=
 =?utf-8?B?Y2p0VTJmUXdlM09LTmFzY0lCUjNDL1lWaGRadFJoa21ReS9zRjlXaThZQ3Zq?=
 =?utf-8?B?a0I0K0NVQXhXT3lNek1qd3AzU3BVSGRIMVNoY0lmU2NYbWFmSVFlUDQwdXFa?=
 =?utf-8?B?bTIvZnJWUjErZDRtL3JCK2xqbjdvUEhDLzFkMlJMM1EyMzcvSkkweG5BdUpn?=
 =?utf-8?B?cW1IeXUyOGh1MmNDWHBTTlRyL1ZhMHZhdVJnMU1hL0YrdzhJUWRTMUpkVUs0?=
 =?utf-8?B?MDd3Vi9MSkZ3bDhpbFFZblo4Y0l4cmdXcExtblhjWkFUZVdLRmxBZUxTTkdr?=
 =?utf-8?B?WnAwTXNPTkVyQmVwdUsxS2dwUEVka0NIYURYODJiWS9iMTJNckdvWk9RaTRo?=
 =?utf-8?B?T3puaUU0VjZ4T3hUR01HSDlWTyszelNwR1pzYWQ1eVpOR3JPRkdzQVM5VzFs?=
 =?utf-8?B?QTdXL2wwVFIzNU1iQkp2cGprNmNQaW1RQ29HTlR4QVlTQ3BLK3hHdFNMREdK?=
 =?utf-8?B?MzZKUlVGY0hZVGRCYWNvTEtBWS93d0VvbHpaRjkxd3AyZHlGTmJicS92OWJy?=
 =?utf-8?B?elFYbzN5YXAra3lZNmtZMXUxQ1pkM2FmRUdGRCt1UU9Ncmk4ZjNSY0tIWXE0?=
 =?utf-8?B?Z2hQenVaQUJXZ3BKOTI3c1U5QnVGUFBWbGsrMmR6NkhTbEpoZkJEMzZxVXNM?=
 =?utf-8?Q?2coRVeQNY4NpTBnxvgGgV8zQw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF3EDC4D7FF2044E821CC2672AEA36D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e57127b-009f-4de3-4ac0-08db9fec7109
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:10:06.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBPx/UeVSDLqI7ABkVCUqoT2CUCQ0BwX/uZ9G/fI58iWtG5USi5dD1U1q15Efj1Fz1F62npdFLS0q8/+m3ReMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDEyOjMxIC0wNzAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEVuc3VyZSB0aGUgY29tcGlsZXIgcmVzcGVjdHMgdGhlIHNpemUgYW5kIHBsYWNlbWVudCBvZiBl
bmNsX2J1ZmZlciBhcw0KPiBleHBlY3RlZCBieSB0aGUgZXh0ZXJuYWwgdGVzdHMgbWFuaXB1bGF0
aW5nIHBhZ2UgcGVybWlzc2lvbnM6DQo+IA0KPiAxLiBEZWNsYXJlIGVuY2xfYnVmZmVyIGFzIGds
b2JhbCwgaW4gb3JkZXIgdG8gZW5zdXJlIHRoYXQgaXQgaXMgbm90DQo+ICAgIG9wdGltaXplZCBh
d2F5IGJ5IHRoZSBjb21waWxlciwgZXZlbiB3aGVuIG5vdCB1c2VkIGVudGlyZWx5IGJ5IHRoZSB0
ZXN0DQo+ICAgIGVuY2xhdmUgY29kZS4NCj4gDQo+IDIuIFBsYWNlIGVuY2xfYnVmZmVyIGluIGEg
c2VwYXJhdGUgc2VjdGlvbiB0aGF0IGlzIGV4cGxpY2l0bHkgcGxhY2VkDQo+ICAgIGF0IHRoZSBz
dGFydCBvZiB0aGUgLmRhdGEgc2VnbWVudCBpbiB0aGUgbGlua2VyIHNjcmlwdCB0byBhdm9pZCB0
aGUNCj4gICAgY29tcGlsZXIgcGxhY2luZyBpdCBzb21ld2hlcmUgZWxzZSBpbiAuZGF0YS4NCg0K
Rmlyc3RseSwgdGhlc2UgdHdvIHByb2JsZW1zIGFyZSBpbmRlcGVuZGVudC4gQ291bGQgeW91IHNw
bGl0IHRoaXMgaW50byB0d28NCnBhdGNoZXM/ICBPbmUgdG8gcHJlc2VydmUgdGhlIGVudGlyZSBi
dWZmZXIsIHRoZSBvdGhlciB0byBhbHdheXMgcGxhY2UgdGhlDQpidWZmZXIgYXQgdGhlIGJlZ2lu
bmluZy4NCg0KU2Vjb25kbHksIGFzIHJlcGxpZWQgdG8gdjEsIEkgdGhpbmsgd2UgY2FuIHVzZSAi
dXNlZCIgZ2NjIGF0dHJpYnV0ZSB0byBhbHdheXMNCnByZXNlcnZlIHRoZSBidWZmZXI/DQoNCj4g
DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hMjczMjkzOC1mM2RiLWEwYWYt
M2Q2OC1hMTgwNjBmNjZlNzlAY3Mua3VsZXV2ZW4uYmUvDQo+IFNpZ25lZC1vZmYtYnk6IEpvIFZh
biBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+IC0tLQ0KPiAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jICAgfCA5ICsrKysrLS0tLQ0KPiAgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMgfCAxICsNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiBpbmRleCA1Yjc1OGVhZjgwOGMuLjAyYTllOGM1
NWU4MiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5j
bC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiBA
QCAtNSwxMSArNSwxMiBAQA0KPiAgI2luY2x1ZGUgImRlZmluZXMuaCINCj4gIA0KPiAgLyoNCj4g
LSAqIERhdGEgYnVmZmVyIHNwYW5uaW5nIHR3byBwYWdlcyB0aGF0IHdpbGwgYmUgcGxhY2VkIGZp
cnN0IGluIC5kYXRhDQo+IC0gKiBzZWdtZW50LiBFdmVuIGlmIG5vdCB1c2VkIGludGVybmFsbHkg
dGhlIHNlY29uZCBwYWdlIGlzIG5lZWRlZCBieQ0KPiAtICogZXh0ZXJuYWwgdGVzdCBtYW5pcHVs
YXRpbmcgcGFnZSBwZXJtaXNzaW9ucy4NCj4gKyAqIERhdGEgYnVmZmVyIHNwYW5uaW5nIHR3byBw
YWdlcyB0aGF0IHdpbGwgYmUgcGxhY2VkIGZpcnN0IGluIHRoZSAuZGF0YQ0KPiArICogc2VnbWVu
dCB2aWEgdGhlIGxpbmtlciBzY3JpcHQuIEV2ZW4gaWYgbm90IHVzZWQgaW50ZXJuYWxseSB0aGUg
c2Vjb25kIHBhZ2UNCj4gKyAqIGlzIG5lZWRlZCBieSBleHRlcm5hbCB0ZXN0IG1hbmlwdWxhdGlu
ZyBwYWdlIHBlcm1pc3Npb25zLCBzbyBkbyBub3QgZGVjbGFyZQ0KPiArICogZW5jbF9idWZmZXIg
YXMgc3RhdGljIHRvIG1ha2Ugc3VyZSBpdCBpcyBlbnRpcmVseSBwcmVzZXJ2ZWQgYnkgdGhlIGNv
bXBpbGVyLg0KPiAgICovDQo+IC1zdGF0aWMgdWludDhfdCBlbmNsX2J1ZmZlcls4MTkyXSA9IHsg
MSB9Ow0KPiArdWludDhfdCBfX2F0dHJpYnV0ZV9fKChzZWN0aW9uKCIuZGF0YS5lbmNsX2J1ZmZl
ciIpKSkgZW5jbF9idWZmZXJbODE5Ml07DQo+ICANCj4gIGVudW0gc2d4X2VuY2x1X2Z1bmN0aW9u
IHsNCj4gIAlFQUNDRVBUID0gMHg1LA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVz
dF9lbmNsLmxkcw0KPiBpbmRleCAyN2MyNTI3ZWNiYzQuLjJlYzI5MzQwYmE5NCAxMDA2NDQNCj4g
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gQEAgLTI0LDYgKzI0
LDcgQEAgU0VDVElPTlMNCj4gIAl9IDogdGV4dA0KPiAgDQo+ICAJLmRhdGEgOiB7DQo+ICsJCSoo
LmRhdGEuZW5jbF9idWZmZXIpDQo+ICAJCSooLmRhdGEqKQ0KPiAgCX0gOiBkYXRhDQo+ICANCg0K
