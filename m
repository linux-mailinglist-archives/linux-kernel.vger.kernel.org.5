Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6258011AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjLAR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLAR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:29:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A185131;
        Fri,  1 Dec 2023 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701451789; x=1732987789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LqA778H1rljPa7dY+Ur9h4+xDa0nJVCA/NK4PwTUIIY=;
  b=kCubMgvtIFarMaRnC/ECKdpwuVoO7ctQ5S/YmVNTWYoqAYMQ+2oGUoxS
   tzKgt55dap95bIU1yeVVwygfjGsPXGInQ/zxpu+AXYAVBy5KFF9I8R0Bs
   7VeyOSUUpiJQInCLxjzDojM2ce45FYg7y/U3Jmwbqgc1O1+LtGuC3bG1A
   5asG0R7gGm9C3ipPbghpwWT1cmvIoXzhzRaoLBi0Wofu3L5JSnHpKbb0X
   9grUb8psOjwxQ+U3TO4+i0ys3L7Wa6QybsbABmjIC7Yah5pUD9Y9tuUzU
   VKPFtHvkJnioVJTKsPDziWq18TzB6oj1/ACz95Aq9FUfcNAGzCrqS3qVb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="383922252"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="383922252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1101373878"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1101373878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 09:29:37 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:29:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:29:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 09:29:36 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 09:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP4AMpyWeEYWJBMSBq/v5fA9zyhYXUzBETewTLxBiBTWnEScc/Cz7M1KGfHJi74BaR1rhSdkh2dfaEfiI+ghd4zFN4yFFSgv1GRBzdqIQfKUQLbsN2Gw8DQBGMuRtmy8e3asQp9sU+DjEyB/h9cmaMAXQkxQqYFvbp5iwEHsW0C3eW160ce3lhOv3LJGRUTlRDxf9wFKbgy2yv101LyRobbCRGFRp+nU9WEyhZ91eASbfea8K+pkAh2RklLc9DVJ2C8jRIQ3jrB3N8SycA5howlaqFEvJy8JmKWnAnAcmrTDDWbxvieHKgXxJi8I6VckRZ048PhvSYFPyjCFDhEOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqA778H1rljPa7dY+Ur9h4+xDa0nJVCA/NK4PwTUIIY=;
 b=CDigSsh3KUiUe+jhBfQ0Mg0U4F7hptn+7n48SiKYjAcqb2l9cYy9cIf9X/8aIW+kuyuik3h0mHKfMOFJIV3rOR08ILTo4e6YgYAre9Oyjz06zFeHMTnRSsp0+r/FNo26XwHnp4oZUXt3vff4chLdeGJODEu9UJIIlzlTmR3kHkXTIpfdK4QuRdlayNfjQb1BYLvXLfT/Rd4aZk1CDeKcI1mrZkLKmUtp9pBt7ZprIreaWPJJLhtSWDoZYEcKo7cVpwVwrd5sroWugzCnLK5hNawQuuwOVEUQeTRN3+Y26nBXgV4NXt/jrOaKmu1IseNftDc0JYJT5uHfVR9FjmSBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 17:29:25 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 17:29:25 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Thread-Topic: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Thread-Index: AQHaITQX9s4TOW+IWUa/tFSLx25jurCTbFSAgABrHACAAAkGAIAA1PuA
Date:   Fri, 1 Dec 2023 17:29:24 +0000
Message-ID: <a67fdc5ff2401519b99479c1b487b16c707ce0da.camel@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
         <20231127131651.476795-2-rui.zhang@intel.com>
         <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
         <0646bcf5-fd41-41e5-b7b1-06b425973c86@roeck-us.net>
         <ZWllSmdI5pVGc0+3@a4bf019067fa.jf.intel.com>
In-Reply-To: <ZWllSmdI5pVGc0+3@a4bf019067fa.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY5PR11MB6257:EE_
x-ms-office365-filtering-correlation-id: 0e6475c9-e6fa-4368-f8b3-08dbf2931040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfGKGrTzVscVW7yq8eTMAzVI6QpI+vQMMRQEJCGNKWhMCfwRxzYY6gCeWzvBKK/y9UEmfKH1cHnbQEVS1pXdw585nZRkDJ9RckaGoIaxJsYFmkstOsSaFZfLQC/iYJ1SFuzYeQ84g4wu6A/OWAtTJ+haR5aCjzV31dI6budPkmp/o+l5k6RWSsWUMshkd2+YP+3PH4b/V3HvScTxFntK/hw29alVK2jfd5DOJ+PDW0NcpZ1vFo9LXCvmpKTlmkAvbD7n87Gwo1Vi+ieX+Q6OFrZWEHpRytBvaMoYGI5YQSxXOG9zk89O4TLXHvAIWi+EnfuSiZ4jUk9DluPR7jgNCuHMC3LNEIv/WMBiGJq+pvP04Sc8vn3DeR5FZEVb72xh6df8KDTTVFbY6gXji9AjDag4UuypbwxGpGC8ZbAlw6rjN0GK5GAvf9ySDJrQAU1DRSjyJBDaeOq9+NKzrCe6YIuVpdZHLlZYEqC2L22B3rsTUTx50AE595zLMOv69oBRuMjILoikk6FOyA8D8Nqu1czrCeCaIgr/W2ZWrxAIyx/Xwgd2e4GP6pzoO9xmKqu6dTM1nm5iVGO73+eoZQM98KTqf8mrd+yltNvEKn5nkC/aJuZ/eLiSgX3qLLjQWR+a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6486002)(4326008)(2906002)(4001150100001)(8676002)(8936002)(41300700001)(26005)(91956017)(76116006)(110136005)(316002)(54906003)(66446008)(64756008)(66476007)(6636002)(66556008)(66946007)(5660300002)(6512007)(2616005)(53546011)(6506007)(83380400001)(122000001)(86362001)(82960400001)(38100700002)(71200400001)(478600001)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2Fwa0JRM3dTTVA2RFk0RFpGdXJHYVhqZDRYeFJYQWVZZUVETDVCcXVJZXNJ?=
 =?utf-8?B?a0xtbEVsRnp2UDdyZjBOZ0RZOUlEeFdYM1RmeGV6L2htUktsaEk5eUNNQnYy?=
 =?utf-8?B?NTNGMVhaSXdmQm5PV3RmanFSdGZJUEM2MHI1d2syekM5VG9pSjdibHFUbDlZ?=
 =?utf-8?B?ZnU3eFZXc1JEWkJnRnA4WXErN3I3WXE2b3FDMUFhZDExY2drTmxTOTJtcWFs?=
 =?utf-8?B?Z09Zb2M3aytUUTRiSTNtUGhQS1ZEL0EzWTNVV3NUSktBOU40NVZYWEVYNUxE?=
 =?utf-8?B?SVpJRk5DcXZqdkJjSUhRQklFcW9teStjQmtQTWQ1dEFhQ2RBQVovSG5WYXlS?=
 =?utf-8?B?VGNJZVYvcjlRdERrZTA2bE0rSmdGVzBCWVI1dk9ZVjVDSHRoWERCMVBGeDNP?=
 =?utf-8?B?SUN6YXBPdHZVVDZINEc4NEgrZTNLRUFKTTNpTDdjMGNnUzEzb1FWakprdW9r?=
 =?utf-8?B?Q3dRRzluZUZLSGU1VVV1TlBrdnp2T0FmWHZMd2UrcDRQZ0pRYzUrUkk4dXJy?=
 =?utf-8?B?OUVTTDRzbTVGTDhFOUxtN2JXMFpmMWh3cHhqd1hwVHJycnN1V1BIcEoyMlZ1?=
 =?utf-8?B?UUtVMDM5L214OFk4UkdYRWk2cVZDSWN6RDQvNEJWUlpJQ3dsT0o2LzQ3M0Vn?=
 =?utf-8?B?NU0zZkdnOGJ6T3pXY0tKazVqMnZuZEpqWkhtamNjZFp1ZUNuZHpObk03ODJn?=
 =?utf-8?B?SXRweUs3TnhlQXJ0Y1VXWVhzWXg0amlqek9nQ0RabS9saXM0MVBRTWpPL2cr?=
 =?utf-8?B?TWJBV0I3eGszRUZhRDlIb2VqYkN0L2dodDdacjg0TEZRcWM0b0cvV0VsUlZK?=
 =?utf-8?B?QXBrOFp3cHRaWmNoQ0R4RnBJbCtsNmtOM0p4eW96V3NhWGtNQ1lnbndiZzRy?=
 =?utf-8?B?TzFUaklrdnd1R1F5Ylh5VEdicUJqbFdMUUdRT1Q3VnF4eTdyWk44bEd0R01z?=
 =?utf-8?B?VFVDVFlMN0ZoVGowZ2dCLzhnYVRpMStnYmZYT3l6MVRyNG90eC80OVp0TEZV?=
 =?utf-8?B?Z2hMSVh0RjFHQmhCTEYyVVFyS2kvT1BSMFZaZ0NibUlObUFnQ2N5dGRnRFk0?=
 =?utf-8?B?MkFQV2tLSC9lV2o0SnFnUktuUkJEOUhsQTBON3hZZGNuZDZwM2NSTUNNNzha?=
 =?utf-8?B?dlZISyt0Z3dSWG5yTkR4M0hNNkJpSHptamlMTDNUMDZiM3N1QmpzbEMwdTVF?=
 =?utf-8?B?bUNuTzRmajkzOHJHYWZFMDRVZlpjcUlVZHMwSklaOHhVdVNCN3JPWm1FNDRT?=
 =?utf-8?B?OFROckFYQlRyK1VJdm81SVpDdjVBUXdVUWtLY0pHSEh4UGczNTNERXZKeGU2?=
 =?utf-8?B?cmtjNXROb0FMcEE3YUpXMGpNdHlJcjQ4bjVKSTgyMlV0SXozVEh4c3E1dUdh?=
 =?utf-8?B?QnFkeDBaZ2NSMkYyMEVVaTNROVR4cjZEb0szQm82WU15YzlYdVBoMDZ6a3pz?=
 =?utf-8?B?cjViWHlhamxVakpBNFc4UkxJZ3BvQ1JKVGdjaUFFWXFzL096V3NwWk8vWHZ2?=
 =?utf-8?B?MjBTeGtPV2FDVVZsd3gxOHkrc1U3SFVnZHc5YnNGSmJLWTVRU1l0OXdRb2Ni?=
 =?utf-8?B?V3ZrVDBvRFBxOVNUS2h4Y1N6ZU9yYWVlL2dGdi90ckNzeFFBcHBCUWx0N2VB?=
 =?utf-8?B?TTAwdlJuKzVuTTBra1RwZlk1RTI2T2QvUmxjV0ZOb2tiZnNkb0pmeG9qd2dh?=
 =?utf-8?B?cS9VeTYvampkaXpyODRwY1o0UDI2cnRDZ3pNNVMwYlBaWE0vMHF1QmZndjc0?=
 =?utf-8?B?aHhmU2hyUUpkdVJNQ1hNSmp5VEcyTjl4czhkVDUzVWhqeVhQUmt5alVBQ0Fi?=
 =?utf-8?B?bUVNdE5kWGtGWnRjcjdjMHRiR25iOTNGc0RPbUowbzJ6akhBT0pLY0RqNzNX?=
 =?utf-8?B?aiszWTk4Vnd2TXl1RVpiWFFqbVVYcmJZRWpXc2JudFF2UlF5OURaZVJ4NkZZ?=
 =?utf-8?B?RFlsd3JpRk5Ld01ZS2VxSFByWjl3eUlUZXhiYnJEUTdSRlVaM2F1dGxtNENM?=
 =?utf-8?B?aFJYVEpndjFLMWZrc2VJQ25KQ2x4MkY2WHdpQUx0Y3RMN0pwSXpjSVlHV0cw?=
 =?utf-8?B?TFFza1Btb3o3K0Q1bkRDMUZmUUdzRk9BM3o1OTA5RmlWdnQ4WE1QTlpUcmlF?=
 =?utf-8?Q?lhCjKlrqjsvRVK/vGIjj4qQXz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E407D3233C30C840BD9B57D3D8D734E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6475c9-e6fa-4368-f8b3-08dbf2931040
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 17:29:24.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jeis9HSaHIs38UPH3rv3cPwxVulTXgPJK9tgVF8+GyNJO6B58zyUKORgV4iecE7k8trfKzwBRAEgnU53Q/YvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTMwIGF0IDIwOjQ3IC0wODAwLCBBc2hvayBSYWogd3JvdGU6DQo+IE9u
IFRodSwgTm92IDMwLCAyMDIzIGF0IDA4OjE0OjQ4UE0gLTA4MDAsIEd1ZW50ZXIgUm9lY2sgd3Jv
dGU6DQo+ID4gT24gMTEvMzAvMjMgMTM6NTEsIEFzaG9rIFJhaiB3cm90ZToNCj4gPiA+IE9uIE1v
biwgTm92IDI3LCAyMDIzIGF0IDA5OjE2OjQ5UE0gKzA4MDAsIFpoYW5nIFJ1aSB3cm90ZToNCj4g
PiA+ID4gSW50cm9kdWNlIGVudW0gY29yZXRlbXBfYXR0cl9pbmRleCB0byBiZXR0ZXIgZGVzY3Jp
YmUgdGhlIGluZGV4DQo+ID4gPiA+IG9mIGVhY2gNCj4gPiA+ID4gc2Vuc29yIGF0dHJpYnV0ZSBh
bmQgdGhlIG1heGltdW0gbnVtYmVyIG9mIGJhc2ljL3Bvc3NpYmxlDQo+ID4gPiA+IGF0dHJpYnV0
ZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4g
PiA+ID4gLS0tDQo+ID4gPiA+IMKgIGRyaXZlcnMvaHdtb24vY29yZXRlbXAuYyB8IDEyICsrKysr
KysrKystLQ0KPiA+ID4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9u
L2NvcmV0ZW1wLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMNCj4gPiA+ID4g
aW5kZXggYmE4MmQxZTc5YzEzLi42MDUzZWQzNzYxYzIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvaHdtb24vY29yZXRlbXAuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0
ZW1wLmMNCj4gPiA+ID4gQEAgLTQzLDEwICs0MywxOCBAQCBNT0RVTEVfUEFSTV9ERVNDKHRqbWF4
LCAiVGpNYXggdmFsdWUgaW4NCj4gPiA+ID4gZGVncmVlcyBDZWxzaXVzIik7DQo+ID4gPiA+IMKg
ICNkZWZpbmUgQkFTRV9TWVNGU19BVFRSX05PwqDCoMKgwqAywqDCoMKgwqDCoMKgwqAvKiBTeXNm
cyBCYXNlIGF0dHIgbm8NCj4gPiA+ID4gZm9yIGNvcmV0ZW1wICovDQo+ID4gPiA+IMKgICNkZWZp
bmUgTlVNX1JFQUxfQ09SRVPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDEyOMKgwqDC
oMKgwqAvKiBOdW1iZXIgb2YNCj4gPiA+ID4gUmVhbCBjb3JlcyBwZXIgY3B1ICovDQo+ID4gPiA+
IMKgICNkZWZpbmUgQ09SRVRFTVBfTkFNRV9MRU5HVEjCoMKgMjjCoMKgwqDCoMKgwqAvKiBTdHJp
bmcgTGVuZ3RoIG9mDQo+ID4gPiA+IGF0dHJzICovDQo+ID4gPiA+IC0jZGVmaW5lIE1BWF9DT1JF
X0FUVFJTwqDCoMKgwqDCoMKgwqDCoMKgNMKgwqDCoMKgwqDCoMKgLyogTWF4aW11bSBubyBvZiBi
YXNpYw0KPiA+ID4gPiBhdHRycyAqLw0KPiA+ID4gPiAtI2RlZmluZSBUT1RBTF9BVFRSU8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoChNQVhfQ09SRV9BVFRSUyArIDEpDQo+ID4gPiA+IMKgICNkZWZp
bmUgTUFYX0NPUkVfREFUQcKgwqDCoMKgwqDCoMKgwqDCoChOVU1fUkVBTF9DT1JFUyArDQo+ID4g
PiA+IEJBU0VfU1lTRlNfQVRUUl9OTykNCj4gPiA+ID4gK2VudW0gY29yZXRlbXBfYXR0cl9pbmRl
eCB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoEFUVFJfTEFCRUwsDQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoEFUVFJfQ1JJVF9BTEFSTSwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgQVRUUl9URU1Q
LA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBBVFRSX1RKTUFYLA0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqBBVFRSX1RUQVJHRVQsDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoFRPVEFMX0FUVFJTLMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBNYXhpbXVtIG5vIG9mDQo+
ID4gPiA+IHBvc3NpYmxlIGF0dHJzICovDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoE1BWF9DT1JF
X0FUVFJTID0gQVRUUl9USk1BWCArIDHCoC8qIE1heGltdW0gbm8gb2YgYmFzaWMNCj4gPiA+ID4g
YXR0cnMgKi8NCj4gPiA+IA0KPiA+ID4gVGhpcyBzZWVtcyBvZGQuIFRPVEFMX0FUVFJTIGJlaW5n
IHRoZSBsYXN0IGVudHJ5IHNlZW1zIGZpbmUsIGJ1dA0KPiA+ID4gZGVmaW5pbmcgYQ0KPiA+ID4g
TUFYX0NPUkVfQVRUUiB0aGUgd2F5IGFib3ZlIHNvdW5kcyBhIGJpdCBoYWNreS4NCj4gPiA+IA0K
PiA+IA0KPiA+IENvbXBsYWluaW5nIGlzIGVhc3kuIFdoYXQgZG8geW91IHN1Z2dlc3QgdGhhdCB3
b3VsZCBiZSBiZXR0ZXIgPw0KPiA+IA0KPiBGYWlyIGVub3VnaC4NCj4gDQo+IEhvdyBhYm91dCAN
Cj4gDQo+IEFUVFJfTEFCRUwsDQo+IEFUVFJfQ1JJVF9BTEFSTSwNCj4gQVRUUl9URU1QLA0KPiBB
VFRSX1RKTUFYLA0KPiBNQVhfQ09SRV9BVFRSUyzCoMKgwqDCoMKgwqDCoMKgwqAvKiBPbmUgbW9y
ZSB0aGFuIFRKTUFYICovDQo+IEFUVFJfVFRBUkdFVCA9IE1BWF9DT1JFX0FUVFJTLA0KPiBUT1RB
TF9BVFRSUw0KPiANCj4gRWFjaCBlbnVtIGNhbiBiZSBhc3NpZ25lZCBhbnkgdmFsdWUsIGJ1dCB0
aGlzIHdheSB0aGV5IGFyZSBqdXN0DQo+IGluY3JlYXNpbmcNCj4gb3JkZXIuIA0KDQpBVFRSX1RU
QVJHRVQgaXMgdGhlIG5leHQgYXR0cmlidXRlIGFmdGVyIEFUVFJfVEpNQVggc28gaXQgc2hvdWxk
IGJlDQpyaWdodCBhZnRlciBBVFRSX1RKTUFYLg0KTUFYX0NPUkVfQVRUUlMgaXMgdGhlIG51bWJl
ciBvZiBiYXNpYyBhdHRyaWJ1dGVzIHNvIGl0IHNob3VsZCBiZQ0KQVRUUl9USk1BWCArIDEuDQpU
T1RBTF9BVFRSUyBpcyB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIGF0dHJpYnV0ZXMgc28gaXQgc2hv
dWxkIGJlDQpBVFRSX1RUQVJHRVQgKyAxDQoNCkFUVFJfTEFCRUwsCQkJCS8vIDANCkFUVFJfQ1JJ
VF9BTEFSTSwJCQkvLyAxDQpBVFRSX1RFTVAsCQkJCS8vIDINCkFUVFJfVEpNQVgsCQkJCS8vIDMN
CkFUVFJfVFRBUkdFVCwJCQkJLy8gNA0KTUFYX0NPUkVfQVRUUlMgPSBBVFRSX1RKTUFYICsgMSwJ
Ly8gNA0KVE9UQUxfQVRUUlMgPSBBVFRSX1RUQVJHRVQgKyAxLAkJLy8gNQ0KDQpIb3cgYWJvdXQg
dGhpcyBvbmU/DQoNCnRoYW5rcywNCnJ1aQ0KDQo=
