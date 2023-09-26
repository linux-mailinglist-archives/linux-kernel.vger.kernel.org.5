Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7317AF58C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjIZUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjIZUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:51:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F39F;
        Tue, 26 Sep 2023 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695761474; x=1727297474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yEGCnjkVxdjj3oQMjhd8+QTD52R8a2M3UHaz5Kn/tnc=;
  b=lhVMeEv3kMWJE1De6mZy7Z+FJ1tjwsC8+FhskmKT3qyF8RCalzsycGFd
   i5FcIMZph/2GG4xaAIvmCRFiwoN5pkaZvdcrHQlEv5maBhS20fAWLP0KM
   N3RE/MXCk1ewdS1N1/1Dx47lPwYq8SkJkvdfKJ1P0XJJJvMZxZvrPYUu2
   SqfX8wF+slHHPdT6NlLF0+SxnzrpXkYzVuX6vpBw1tftkWKiJFH/WMazv
   7R9c0h3Lvba3H+/DaJY79IukmjlaCDWMmgj1KFkUmoETA+TSVb23GLuDH
   emXYMiQ2qgqo0rSsU7/FCsHVxjA12brGD5BcX9/cp7o7AQvDRxZIfAEsh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448160171"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="448160171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864536320"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864536320"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 13:51:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 13:51:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 13:51:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 13:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqKRjrJDoj1l1XPfjNvQiICxAue/oPbUgxae+/OmvqidE/SNMlSpqE8R5c29ed8cv1oCdLYIU8srLUvOh7X/zz8LAQ37WALVN7N+BKHnwcOWg8sCsU7oqgJKr8HNuBhW3GM1S3XPiGD0V3bjk50jOpBjQruEj/KJiz4iecznBQWdFnNFjm01I1Syg/ZHQwJL24JS32AwXNh8RzNA0nIGP1pw/K7MsQFG7TATzjXmKpmsIUZxOcTy5vNd+rQJieEZ7yrW/t9RrI82GRQZHJIF1V7aaqdgIeoe/+Z6UrRAwICdYP14WmU+UrOc6z2J3yFDIETG5+oqbN43pk6Bxbw2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEGCnjkVxdjj3oQMjhd8+QTD52R8a2M3UHaz5Kn/tnc=;
 b=RwzEPLy5Bg1AZr83ku5RmgzIvREsaWkfJUU5bVga1hDnjshYwBO96tegnp4O1oVR+6BUZvjFf69VX0iY39qcznynAE5OUTyEvQd4Z5P7vBpB3fZbVprbOXBprolcgAUa3KvTmNEFu39UNb/xKhObE7In/BDljIt+ccv+HAOSdX+mIrOVeE850j4Sg24ex8J0gCmIBZ6NQDGCWsV4YkzlYoMkPOnSpj7vCqZHgFtSL5XKfStz1NdAFD+Ca5LjswMvn3kWS+yb2KtjOBYzUKiRSz8VDs8mOw2Ww4caRYU2WcVhYJemjFNtuGffQsGGxG+3FR+mKRh8EN1RW4nCyZhSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 20:51:09 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a798:2371:34c5:4648]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a798:2371:34c5:4648%7]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 20:51:09 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     Yang Jihong <yangjihong1@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Kan Liang" <kan.liang@linux.intel.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [RFC PATCH 09/25] perf stat: Add helper functions for
 hardware-grouping method
Thread-Topic: [RFC PATCH 09/25] perf stat: Add helper functions for
 hardware-grouping method
Thread-Index: AQHZ73g5Z2n2T2alikCYYFGdQlWbVrAsdpoAgAEezBA=
Date:   Tue, 26 Sep 2023 20:51:09 +0000
Message-ID: <CO6PR11MB5635456DB6A4CDED3697E3A0EEC3A@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-10-weilin.wang@intel.com>
 <c57ca700-887b-c445-55c3-a3e34745f210@huawei.com>
In-Reply-To: <c57ca700-887b-c445-55c3-a3e34745f210@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB6244:EE_
x-ms-office365-filtering-correlation-id: 913c6dd9-3092-4945-4374-08dbbed24fd8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/IYYUQo78qFypF2240a1BmELbS2F0x8qe6M/WqfACPG5l3CW1n4YibdwK2CBybFPMpDAYIiS794RCZ0d3oZWvHgwVFEl1r1XdrEd6l931D+dlk0zj3T+Q5xZcJ/M8c7ZT6IyHkGNTrc+Dr3LHZm5qCK1XLX7JZLM9YiXyJQuGj1OAgETnuxgf7Fqb6E12LT8746B/v7P3NVXLtqgR5VFsUxxUL4AjILF5Vl73xhw+R+6VFt4+iRMSHkvwOk/UMr1OlFEfKyyd7vcz+fyfQoczNSZcu24ZnpgMOc2u9i37bCkQ6mAIAXcH0aKdWI+k/oqVapdW8d0J2tEDuGUUglj6z5Yp/SNz5/se4fGAHScBCP4eanLTlLTf+CWCbMZ0hN7y0xDebN7zBk/PTX6pOUw5tJfRpiImIDaAaFvCTbK9EzSSK/NWLM+4V5g0/1ahBNUX7W5dxHHGLdHHD/gbyaV/15B6AEgF+l7kz3fDjXZp0rhi/NMFdNtq0K6f0IOtDBsikFkQph4e08EdVilgux5MN+20g2qLkM80hfvFrzeJYUKMRbGSmBkmsNieneQbba4KXtBMTOJZboY9KcI0eEXF7367gGP0jQ8rx5lkrhog153kGLOjw31zHUrtkHEc9oN+BaM8/iqJkMcygMCLXYVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(52536014)(6506007)(53546011)(7696005)(33656002)(4326008)(9686003)(478600001)(83380400001)(5660300002)(26005)(110136005)(316002)(76116006)(64756008)(66446008)(2906002)(66946007)(66556008)(66476007)(71200400001)(8676002)(7416002)(8936002)(54906003)(41300700001)(122000001)(921005)(82960400001)(86362001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3RVVHIxY3lLRGdodWJkcitKZ3I3cVR5OU1pTUJrcE1xV1VsL2QwSGQ0Z1VI?=
 =?utf-8?B?UDhKeVdUajYrMW0vWmdMN00zYlpFTjFadVFTWUtkYW9HM3ZqUzBXMGh4VGR3?=
 =?utf-8?B?UVhsU0JpenJNRno0V0hkWGgrN0lzZFRSS1RVMk5UcU1HZy9kTnpJV3lITHpN?=
 =?utf-8?B?TEphZ3VSWk5DT0paeGpKcVF2dmloMFJTWVd5RllQMlF3T3o3eU9HNEk5dE94?=
 =?utf-8?B?cjJkR0tvQ1kwNUtod1BZZkYzemRWVXNFc01uVVFTQWtaTEkxcTdmMmh5TlNW?=
 =?utf-8?B?VHZSR0lINlVhVEdYbXlkZXFvREpvUzk3UVFGK1Z3ellhcUZORmNwdGNKQlhQ?=
 =?utf-8?B?Wk1SZGRxN2plYnVYK0JZUUptaFY4a3dValVubXA5dTV4NFJLNXZaK3dCQXY5?=
 =?utf-8?B?R0pMSHE3a0ZkKzB4cDZYSlNZMHZ0M3hJais4UXFNajFlSjZXNWdpR2Nsc0VV?=
 =?utf-8?B?dklZemtralZYMDMxTkxaTjV2WDh2c1NKUHh6MGt1QlFFMnZrc2gvbUF6aldZ?=
 =?utf-8?B?amlENW1Ia0t3ODFtMnd6MzNpWUJDN2JqTG9RaGFCUlVUTDN2clgvdHdtUmQ1?=
 =?utf-8?B?dDJFclR0ekdjcU52dk0rVU0xZ1JiRzY1U3V5ODhvK1BuaytxN0VrZFdVWnlB?=
 =?utf-8?B?VU9ENUhKd0JqYTVZeTMvYVFUVHdadTcwRUdvbE1jaDNoMVZlRnk1aHZUbkI4?=
 =?utf-8?B?US9TMnVqVzlBOGZMNlgzQmNNWSszdDU0aDFPclZSaXR3VW0vV1V3aFlpeWtK?=
 =?utf-8?B?VWkwT2Zlc0VVdkNXQXVEcExEMDJWamF0bUJCT1A0aDBTYTVtMm0xaDQwdnF2?=
 =?utf-8?B?Y0M1TlVCWG9EWk1rTlFnK3QyR1B2eUFiYk1XUUJQMlJxVHR5U2NHcmxOVG5u?=
 =?utf-8?B?OHgxekUwSnpSY3pZb001VWxGUGJ3Q1BtcW5sa3FRQzU2K211M3JDL0tKQisv?=
 =?utf-8?B?RUtzSlE2ZWZ0MExQOFVWbmNYZzVDVUZHY2VmVmJROFQ0Q0dIeGx4eHAycXBB?=
 =?utf-8?B?U1BVYVpBR2o4TVpLTVUvbDljdnBpUmlvZFUvUjVZSVFtcnZSRzZzUmNvN0Fi?=
 =?utf-8?B?akVrdjRhZVFkL1ViK3MvMnVDSEZOWWV5WmduZk8vOVdxZHczeFNrTEVXNm1B?=
 =?utf-8?B?NlFYNnlCbVM0ZWRXbXJLMUJEc3g4R0hCRHdyeGN1alMzV2tESU5PYUI5TkR0?=
 =?utf-8?B?YW9UUXQwQ2s0MFE4ZklseVg5V3piWk9lS3Q2TGwrK3Y0MHZveHZZL2ZRZWt1?=
 =?utf-8?B?cjRpeUdrZmlQM0dEbTFpRXBVNjJOdTl1N0ZuSTZpZGdVVE5tZVlvMzFhVXFx?=
 =?utf-8?B?bW9DTWkwSEdmdW96dW01djBGcHpyVm9Nc3dyMXVZbXdaQ1JOZDFtdVRvWkUw?=
 =?utf-8?B?RWpPTXF4eXFBdXB0Q0l4REdkVUZhQlVZSGc1Vkt5MTZpTzVqd1k2MGc5c2Qz?=
 =?utf-8?B?OUwwaHJ1Tk9TbGZKSG8xdXVIS3VrUVBaKzdhWXAvY0lKclVrcE9XWXpWMW5U?=
 =?utf-8?B?bXJwem9HNkx2MGZ2OGtJWCtwTnU5aW5BcXhtdlpOVTB1QlFOVXJ5Nkppbis5?=
 =?utf-8?B?UjNURkZpK0NEcVJGckwrZ0ZYU01WZmRHV2JZV2syQ1N2NU1KV1c4d01SeU1B?=
 =?utf-8?B?TC96aVVMNzRSYXJSd1RaVXovb00vaHdOQ3V0VUZkUTJQdnViQ0s3cWp4WUV6?=
 =?utf-8?B?WmhhNVZMaWdPYXFEZHBmWmFBSjZOVTFtNGRlcU5OZDRqbkN0Z2xsSjR3cEpQ?=
 =?utf-8?B?bkN0aS9OM0F2QlZvamZNdC81NCtmMW10ZmV1NFg4cFFib2NTYkFQNFR1TTNh?=
 =?utf-8?B?TmlvQzYzV29wSEpLQ3F2SnNpVHNHb09wU0tUS0lGRDY0TjR4aTMyZkx4QkRm?=
 =?utf-8?B?aGcxRlh2eTZZVWc3TENISGNLY2hKYWl2bUVFRm5xRkEvSWlHZkluQm1wZURu?=
 =?utf-8?B?RzFQSGhxSksyN0JsSWJPbERUWGdwRUFJa2N1VzJiZmVBeEFBMjZTRnRjU2I1?=
 =?utf-8?B?QngwdWhkM1dwVHc0emMvOHl3YUJpT3lpdzh6cjdoWXlBbjV1Y0ZqRnBkNkw2?=
 =?utf-8?B?eTdOVWhZdG80NHVBbGJ2YXQ5N3NVT215ZlhwRXZDTldEVXExWVFNVFNvSzcx?=
 =?utf-8?Q?u1kkLzXx0K5XB03Zn+72BrmJs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913c6dd9-3092-4945-4374-08dbbed24fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 20:51:09.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmRAA9pJ7JoZZEI8Ikd0y7KstsfNZ3teNf7q6q+hW+fe0S0+0+cLEoWdTYBIpHt43KCUQiG5kAgFtvz+AlIwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFuZyBKaWhvbmcgPHlh
bmdqaWhvbmcxQGh1YXdlaS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI1LCAyMDIz
IDg6MzcgUE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPjsgSWFu
IFJvZ2Vycw0KPiA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz47DQo+IEFsZXhhbmRlciBTaGlzaGtp
biA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYQ0KPiA8am9s
c2FAa2VybmVsLm9yZz47IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz47IEh1bnRl
ciwgQWRyaWFuDQo+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxp
YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3IsDQo+IFBlcnJ5IDxwZXJy
eS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50aGEuYWx0QGludGVsLmNv
bT47DQo+IEJpZ2dlcnMsIENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT47IE1hcmsgUnV0
bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDA5LzI1XSBwZXJmIHN0YXQ6IEFkZCBoZWxwZXIgZnVuY3Rpb25zIGZvciBoYXJkd2FyZS0NCj4g
Z3JvdXBpbmcgbWV0aG9kDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIDIwMjMvOS8yNSAxNDoxOCwg
d2VpbGluLndhbmdAaW50ZWwuY29tIHdyb3RlOg0KPiA+IEZyb206IFdlaWxpbiBXYW5nIDx3ZWls
aW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBBZGQgZnVuY3Rpb25zIHRvIGZyZWUgcG11X2lu
Zm9fbGlzdCBhbmQgZXZlbnRfaW5mb19saXN0IGJlZm9yZSBleGl0DQo+ID4gZ3JvdXBpbmcNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gICB0b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyB8IDMyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9w
ZXJmL3V0aWwvbWV0cmljZ3JvdXAuYw0KPiA+IGIvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3Vw
LmMgaW5kZXggZmViNWRhYjI2Li4wY2E4ODVhNDIgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVy
Zi91dGlsL21ldHJpY2dyb3VwLmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvbWV0cmljZ3Jv
dXAuYw0KPiA+IEBAIC0xNTA3LDYgKzE1MDcsMjcgQEAgc3RhdGljIGludCBwYXJzZV9jb3VudGVy
KGNvbnN0IGNoYXIgKmNvdW50ZXIsDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4g
PiArc3RhdGljIHZvaWQgbWV0cmljZ3JvdXBfX2ZyZWVfZXZlbnRfaW5mbyhzdHJ1Y3QgbGlzdF9o
ZWFkDQo+ID4gKwkJCQkJKmV2ZW50X2luZm9fbGlzdCkNCj4gPiArew0KPiA+ICsJc3RydWN0IG1l
dHJpY2dyb3VwX19ldmVudF9pbmZvICplLCAqdG1wOw0KPiA+ICsNCj4gPiArCWxpc3RfZm9yX2Vh
Y2hfZW50cnlfc2FmZShlLCB0bXAsIGV2ZW50X2luZm9fbGlzdCwgbmQpIHsNCj4gPiArCQlsaXN0
X2RlbF9pbml0KCZlLT5uZCk7DQo+ID4gKwkJZnJlZShlKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgbWV0cmljZ3JvdXBfX2ZyZWVfcG11X2luZm8oc3RydWN0IGxp
c3RfaGVhZA0KPiA+ICsqcG11X2luZm9fbGlzdCkgew0KPiA+ICsJc3RydWN0IG1ldHJpY2dyb3Vw
X19wbXVfY291bnRlcnMgKnAsICp0bXA7DQo+ID4gKw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRy
eV9zYWZlKHAsIHRtcCwgcG11X2luZm9fbGlzdCwgbmQpIHsNCj4gPiArCQlsaXN0X2RlbF9pbml0
KCZwLT5uZCk7DQo+ID4gKwkJZnJlZShwKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgbWV0cmljZ3JvdXBfX2V2ZW50X2luZm8gKmV2ZW50X2luZm9fX25ldyhj
b25zdCBjaGFyICpuYW1lLA0KPiA+ICAgCQkJCQkJICAgICAgY29uc3QgY2hhciAqcG11X25hbWUs
DQo+ID4gICAJCQkJCQkgICAgICBjb25zdCBjaGFyICpjb3VudGVyLA0KPiA+IEBAIC0xNTI0LDcg
KzE1NDUsOCBAQCBzdGF0aWMgc3RydWN0IG1ldHJpY2dyb3VwX19ldmVudF9pbmZvDQo+ICpldmVu
dF9pbmZvX19uZXcoY29uc3QgY2hhciAqbmFtZSwNCj4gPiAgIAl9DQo+ID4gICAJZS0+bmFtZSA9
IG5hbWU7DQo+ID4gICAJZS0+ZnJlZV9jb3VudGVyID0gZnJlZV9jb3VudGVyOw0KPiA+IC0JZS0+
cG11X25hbWUgPSBzdHJkdXAocG11X25hbWUpOw0KPiA+ICsJLy9lLT5wbXVfbmFtZSA9IHN0cmR1
cChwbXVfbmFtZSk7DQo+IENhbiB0aGUgY29tbWVudGVkLW91dCBjb2RlIGJlIGRlbGV0ZWQ/DQo+
IA0KPiA+ICsJZS0+cG11X25hbWUgPSBwbXVfbmFtZTsNCj4gPiAgIAlpZiAoZnJlZV9jb3VudGVy
KSB7DQo+ID4gICAJCXJldCA9IHNldF9jb3VudGVyX2JpdG1hcCgwLCBlLT5jb3VudGVycyk7DQo+
ID4gICAJCWlmIChyZXQpDQo+ID4gQEAgLTE2ODcsMTMgKzE3MDksMTUgQEAgc3RhdGljIGludCBo
d19hd2FyZV9idWlsZF9ncm91cGluZyhzdHJ1Y3QNCj4gPiBleHByX3BhcnNlX2N0eCAqY3R4IF9f
bWF5YmVfdW51c2VkLA0KPiA+DQo+ID4gICAJCXJldCA9IGdldF9tZXRyaWNncm91cF9ldmVudHMo
aWQsIGV0YWJsZSwgJmV2ZW50X2luZm9fbGlzdCk7DQo+ID4gICAJCWlmIChyZXQpDQo+ID4gLQkJ
CXJldHVybiByZXQ7DQo+ID4gKwkJCWdvdG8gZXJyX291dDsNCj4gPiAgIAl9DQo+ID4gICAJcmV0
ID0gZ2V0X3BtdV9jb3VudGVyX2xheW91dHMoJnBtdV9pbmZvX2xpc3QsIGx0YWJsZSk7DQo+ID4g
ICAJaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+IC0NCj4gPiArCQlnb3RvIGVycl9v
dXQ7DQo+IFRoZXJlIHNlZW1zIHRvIGJlIG5vIG5lZWQgZm9yICJnb3RvIGVycl9vdXQiIGhlcmUu
DQoNCkhpLCBZYW5nLiBUaGFua3MgZm9yIGJlaW5nIGludGVyZXN0ZWQhIEkgd2lsbCB1cGRhdGUg
dGhlIGNvZGUgYmFzZWQgb24gYWxsIHRoZSBjb21tZW50cyBJIHJlY2VpdmVkIHNvIGZhci4gDQpQ
bGVhc2UgYWxzbyBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgb3IgY29t
bWVudHMgb24gdGhlIGdyb3VwaW5nIG1ldGhvZC4gDQoNClRoYW5rcywNCldlaWxpbg0KDQo+IA0K
PiA+DQo+ID4gK2Vycl9vdXQ6DQo+ID4gKwltZXRyaWNncm91cF9fZnJlZV9ldmVudF9pbmZvKCZl
dmVudF9pbmZvX2xpc3QpOw0KPiA+ICsJbWV0cmljZ3JvdXBfX2ZyZWVfcG11X2luZm8oJnBtdV9p
bmZvX2xpc3QpOw0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICAjdW5kZWYgUkVUVVJOX0lGX05P
Tl9aRVJPDQo+ID4gICB9DQo+ID4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IFlhbmcNCg==
