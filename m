Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43A07D3CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjJWQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJWQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:37:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E298E;
        Mon, 23 Oct 2023 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698079064; x=1729615064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lmeqS5wLcC43j7Ik2jvykvBPKDpuA4kG5Pd0J4I7mcU=;
  b=nHSuko4fSoZImLgPP0v+6SbJZe3bqTV0Q87xtjztfy3303FhQ+Ufxk5j
   VP7nvANQClAEtJnZKkbxCvQo0zGS2rFwNP+2fbslPg0S7DElufVYnzNlr
   mtBYdHIy2MhDNjGpxhNNYhfLl1u9z4/lk+0ENx0NS95ql2gVviduZXNKl
   x8AHkobwATC3fQKtWglpC0rg8r1JTaiP2eJg378I0biNzC+1rsFktVe1W
   FJ//HTSHillkQXaBm5A7inIH9YIOzEpkZFr6rIWFAHMTlIsFOC/8y9vyx
   eDNqFsaQUgGKzHPc8gWMld2ZnuTQDi6ZzkHLRr8Uu3f7i84OQfDxLCstQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="371948174"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="371948174"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="824005389"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="824005389"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 09:36:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 09:36:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 09:36:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 09:36:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 09:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdVMvQiz0OIj/4wR7MdP5ldAEJfCPzSpDMXe8XjcwvWxMj9ZLF1UQkWDAvD9vk7UA/F67qKzK5op4PlVx9vgWPqLUvlN5Dmc4gVnY8qO8T3bVestL7RVJY+jFKd9yL6KjHiA6Sli3KInzQyDyzv7oVz9LfBOLK6vK9tnmhGYL99UZx1gHBK22lblCmG4/SlliJZg2kJMA9glNfPJsW6pb2sxBblP/DPolsn1X0DOW/ZLqlT3iaLyOtkXs+LbDjFKXEjt1DFEhrVifTlFOs5S8PvdPAhzgJEI33GSWkr/SQuNuMU6QsEE0TR44fAZ0ehrO7HZ3CJUXzUNM55/Jf/DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmeqS5wLcC43j7Ik2jvykvBPKDpuA4kG5Pd0J4I7mcU=;
 b=SPv5RsdLJeaiFDF51mYu0ZP9Wfrrb7rYvMCMLOhblrxvAZWYY6VP5/ZntVUerY0WfbPI7ALQTkKTTDsVs/cRZL4pC6GvveszaH4Q7ClB3nnMP96Bn2+WkgqouWvBhx66DFrLFxCxnTeoTyt7Y06sfyzvnAfb9/bsfwm1WYL36MMvW8C/xeM7k/fy54oTigvyornKOHBdrY2IYUsVZHF2jiP8YKU9BIF2bIh2uNs7jf07VTzcjavVSkwoKvOiUovj3BEpxo5yBj0HasZdLy4TQUG/9zcSWL6EqPK+owY/P081p5aS+RXgqXwiarxge3oIUpm7E9S+/l06T8iJqRkAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 16:36:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 16:36:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "ldv@strace.io" <ldv@strace.io>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH] x86/uapi: fix SHADOW_STACK_SET_TOKEN type
Thread-Topic: [PATCH] x86/uapi: fix SHADOW_STACK_SET_TOKEN type
Thread-Index: AQHaBTYlci++uGYmdEmPCIcmkdBXMrBXk86A
Date:   Mon, 23 Oct 2023 16:36:48 +0000
Message-ID: <006699efc5ccdce1bd62f45ef2852ab0233e295c.camel@intel.com>
References: <20231022222134.GA5334@altlinux.org>
In-Reply-To: <20231022222134.GA5334@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8434:EE_
x-ms-office365-filtering-correlation-id: a1e44778-46fc-4117-2b62-08dbd3e640eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2zpl1GWvxfXtsBbO9H6msq61EBr6IgqINwtwFR46pZFqLVo9CxHwk46lYPPECA70gSxrehIZbmd/Yie16ug4Y+yQZDMQXjODTkuZblDloOU7uOojcdnkZGkL3EWBULsl0gDshr69yuqwQBZT8iiP5Nv7TmqzgRcnd50Z6+tl3vlWAwGw2dVZH1sPpJL+sVme0wqExQPwuZGquX63n82DAY7D9rutCtSKNLGAGNj5wObkCZiooYQ4GI9wCOvXIXwd0m2HjutwSNuP2YHpEuxgbAaTtUnKDe6wDOOC/rHs6O91j/gA4TNX7uwh7BMJjQB3ibdpbYO02bcf0OoGaCc03AO0ZFYT3ReXQZq45fTlT6h9X1LPjhjoP/vaKwGXLwZD5xSJ6G4Yw6hjSC//D+Yv0kYUscpVKxNLDwef/62g/JztnWfQdxOBHckG2MG2FsiJ3rP+5JxWWaF1Z5a6M+vg5rYnfR4suP3+27d7kKzlLAJOMDfr9vQ4kjmfiesQBJtCE+C0ySjj0rzyoQ0cD2SR68DZpBYOitN0eNO/7iOVoVIkCjK4YtomhQQDSM/MAy//uPAiWhPqVPmXu23RmUirIEzn6/doM2x6gvwskswhRws+ZMs/P46i6aQ3BM7AfvO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(76116006)(86362001)(110136005)(64756008)(54906003)(66946007)(66556008)(66446008)(66476007)(41300700001)(6506007)(316002)(6512007)(91956017)(5660300002)(6486002)(478600001)(4326008)(36756003)(8936002)(8676002)(4001150100001)(2906002)(71200400001)(122000001)(38100700002)(2616005)(26005)(82960400001)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHFGR005dzhzKzdWWVpNRk9PZnloYUdVUUVsZW5QbnFIZ0NUT2Y0eEVsSVdm?=
 =?utf-8?B?RXMxVGMrcnF0bzRTeHYyNk1ER1NJdnBxK2Z3b0lteVdIZkU1bDl5OGxOVzlO?=
 =?utf-8?B?K2ViSFM0OHNJdEZBS0h3Zi9mMXlDRkNZYk1qbS9tMEEyYjU1S2NVM2R6YVNU?=
 =?utf-8?B?UWNWQlVZbkdGY2VmZFJtRm90bmptOXI3L3lSemdnaFNQRTVyTVdOSldVcXVY?=
 =?utf-8?B?YlF0emN3Y2lGNWtjNVRKUlRCM2Iva2dacnJxanhVUmdTelZPbm5MMG5ZTWFP?=
 =?utf-8?B?eGVkeFJ5b244U2RBRXplRXZMWU9aSVRoR2oyRFFOczVTNjBGOE9yK1cyd2hx?=
 =?utf-8?B?TkltUk9nMnI5VFg2THBDdGlobUJaS0cycTkvT0V4OFArZExMZUpNVGg1SDFU?=
 =?utf-8?B?ZjVDUmVwcGlLVk5nTnVSeU5HRU1BNVNDbG4vTUppQXpWY2htbW44UFRuclNT?=
 =?utf-8?B?aGNLTHY4c2orempSajRHdHdudmQyWlRvcG5ITGoxNnRxNFBXMEF6TlhlNUhO?=
 =?utf-8?B?WTFnb2NRNXMvelZVam5MSUdVK0N1VVZuYS90ay8vazAvS0xwMnRPNVQ5RmFX?=
 =?utf-8?B?cnVYdUdKeVJuL2cySnNMRFErTmV6YWtNY1Z6RDdvWEhnRDdPRXJDUkdQMXFo?=
 =?utf-8?B?WGZkWDNOMzNYTEh5U2M3eW5lb09jVDdncHlKSUNWa0tjQ0M3TnM5QWtDeFFV?=
 =?utf-8?B?SzM3V3kxbTJIMjJxQW43eTB3MmRpbDNvRXo4bllHcDFKY1NtdGR0REhiOEVR?=
 =?utf-8?B?K3NBSG1SSWZ2WWUycDlGb2JUWGlocHg3ZUR1akprOVNtMm9XZEtpMEJ2YUdG?=
 =?utf-8?B?anM1K3crZFdpbm95eHA5emNzRlhZTTN2TVV6QkhjTFFwVUU4Y3paYWQyd3hQ?=
 =?utf-8?B?MEs5WFp4TEhscjlJM2VrcXJZNnhCa1owdFdwN0dEWW1zNVJuRmJyWUxGRVBN?=
 =?utf-8?B?cUpFSFhRMUtCeTVjdjc4Z0hNZVdYQ3U1eTBIWUJoWURNelh5RXllR200VnJa?=
 =?utf-8?B?WW54NGZnM296MVhxSTdyUWJ6RE1kaVZ4d29QaElteGliWUJnMG5RNXprdFY1?=
 =?utf-8?B?ZGRWa3N6QW80bDJra3FwTXVEN3ZEVzJ4V1g4c3d3OGtmeVB3OGRnRGJObVU3?=
 =?utf-8?B?R2VhQlh2TmNFM3lCU0tqM0tkZGQ3UG1jUUF3ajdhRzZURUlxbVNHSnVxQjgr?=
 =?utf-8?B?ZE5YWFZQamE2OUsvNHc0b1l0S3NNWWx0dG9hUHJsQW1BMlpjTTBqbXpCak9X?=
 =?utf-8?B?SDFRSXNxcDYralhZVWRJc3Q1T0Z3NmNuZmJlL3B6QXU3bDFoNGFYOE5ScUJB?=
 =?utf-8?B?aC82ZUhnRkRrSXF5bjRrUXRUOEJPbWxzVHNDR05PajBIbDZkOGluTm0zT3FK?=
 =?utf-8?B?dVV1cXJGckhwdkYwaFRXeTF5Y21LMitTeEc3NFQxTUF3TWNnRC9IaU44L3dt?=
 =?utf-8?B?QTdRNFRvcDRWb0xreTZwUUhFM2VESzVXTEIwTEtyeFRISGZweXJyUVY5YTNN?=
 =?utf-8?B?bmNBQUtIMlllbGwrUFJuNnAvUWFJNGtoL3hYSHNlOGNsK1lJUVU3eTI0QlZF?=
 =?utf-8?B?bk1URWptZmxPOGJ2UHUzVGhzRmpIaHM0YStNNnBSMHZzOGpQZEFGUTVvT2hY?=
 =?utf-8?B?RGtoQ1pOQmlNWlpNd1JVWHZ2ajJyVTJNaitFeXFpS3I1cS9GeSsySmZmNjFk?=
 =?utf-8?B?bm95RnRHUmtyMHc1NkxlRVJITUNIdnczc1NVcUxYbkkrdU9LUU93YXE5d05i?=
 =?utf-8?B?VWswc29HZVZtcjEybldLVy9jNnZ3Sy82T0xPWFNUYWxtM2w4L1hHZ212TUti?=
 =?utf-8?B?UzAybUhzZmxIUE9lNFdMdVo1VWg1ZkRxcGtSeURtWnBDQ0lWMjNXQ3QzSC9H?=
 =?utf-8?B?U0c0YzZTQ09tYkt1cHQzMk03WFkvZTgxYnFQcGs5Z2dBUHI5bkZpTU5KT0ox?=
 =?utf-8?B?TkQxV2Qrd2gxWllyTVhMNFh3RzBUUTEwcnNDY3IyNm5tWTlSU1RzNkhFcVRk?=
 =?utf-8?B?elhHd0ZFSnlKVW91amFEMmlkbEZzRDJpQmZRRlN1aWp2Q3RyVm1tR2JlTXdy?=
 =?utf-8?B?MTVobUlqeEZpd1VQVUR1bWZPaGFscGNtUGlkZ01GbVUrYkpEY0hXWXpDTmU3?=
 =?utf-8?B?T1Z4RzlaNEgvTXdyYnpidEtNcGtIV2NTUUM0d3ZOcG5uUTNqU0srbXNnVC9Z?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CE5CF77C3765F4A9B3D551EF3E5015B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e44778-46fc-4117-2b62-08dbd3e640eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:36:48.7670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcCuwLNk9Eduucd61w0BQ0IPkguc4V/0IHqD4LS9lMLPOPR7iwYi93qAC+LKiOGyV5rhdwesrkgX8V/GFAH6sQUGUSrZL4BYxQFW5PSTwDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDAxOjIxICswMzAwLCBEbWl0cnkgVi4gTGV2aW4gd3JvdGU6
DQo+IEZpeCB0aGUgdHlwZSBvZiBTSEFET1dfU1RBQ0tfU0VUX1RPS0VOIHRvIG1hdGNoIHRoZSB0
eXBlIG9mIHRoZQ0KPiBjb3JyZXNwb25kaW5nICJmbGFncyIgYXJndW1lbnQgb2YgbWFwX3NoYWRv
d19zdGFjayBzeXNjYWxsIHdoaWNoDQo+IGlzIG9mIHR5cGUgInVuc2lnbmVkIGludCIuDQo+IA0K
PiBGaXhlczogYzM1NTU5Zjk0ZWJjMyAoIng4Ni9zaHN0azogSW50cm9kdWNlIG1hcF9zaGFkb3df
c3RhY2sNCj4gc3lzY2FsbCIpDQo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBWLiBMZXZpbiA8bGR2
QHN0cmFjZS5pbz4NCj4gLS0tDQo+IMKgYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgg
fCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgNCj4g
Yi9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaA0KPiBpbmRleCA0NmNkYzk0MWY5NTgu
Ljg0MTllMjViYjYxNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9t
bWFuLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgNCj4gQEAgLTYs
NyArNiw3IEBADQo+IMKgI2RlZmluZSBNQVBfQUJPVkU0R8KgwqDCoMKgMHg4MMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC8qIG9ubHkgbWFwIGFib3ZlIDRHQiAqLw0KPiDCoA0KPiDCoC8qIEZsYWdz
IGZvciBtYXBfc2hhZG93X3N0YWNrKDIpICovDQo+IC0jZGVmaW5lIFNIQURPV19TVEFDS19TRVRf
VE9LRU7CoCgxVUxMIDw8IDApwqDCoMKgwqDCoC8qIFNldCB1cCBhIHJlc3RvcmUNCj4gdG9rZW4g
aW4gdGhlIHNoYWRvdyBzdGFjayAqLw0KPiArI2RlZmluZSBTSEFET1dfU1RBQ0tfU0VUX1RPS0VO
wqAoMVUgPDwgMCnCoMKgwqDCoMKgwqDCoC8qIFNldCB1cCBhIHJlc3RvcmUNCj4gdG9rZW4gaW4g
dGhlIHNoYWRvdyBzdGFjayAqLw0KPiDCoA0KPiDCoCNpbmNsdWRlIDxhc20tZ2VuZXJpYy9tbWFu
Lmg+DQoNCkdvb2QgcG9pbnQgdGhhdCB0aGV5IGFyZSBtaXNtYXRjaGVkLiBJIGRvbid0IHJlbWVt
YmVyIHdoeSBmbGFncyBpcyBub3QNCmFuIHVuc2lnbmVkIGxvbmcgdGhvdWdoLiBJIHdvbmRlciBp
ZiB3ZSBzaG91bGQgcXVpY2sgY2hhbmdlIGl0IHRvIGFuDQp1bnNpZ25lZCBsb25nLCBpZiBpdCdz
IG5vdCB0b28gbGF0ZS4gV2UgcHJvYmFibHkgd29uJ3QgcnVuIG91dCBvZg0KZmxhZ3MsIGJ1dCBt
YXliZSBzb21lIHZhbHVlIGNvdWxkIGdldCBzdHVmZmVkIGluIHRoZSB1cHBlciBiaXRzIG9yDQpz
b21ldGhpbmcgc29tZWRheS4NCg==
