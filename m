Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E62778933
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjHKItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjHKIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:49:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213E2738
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691743769; x=1723279769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D6H/VkFs4Md99+agqIA3nv7p5zQdq8tfnmBQaRZCskA=;
  b=B/jLyd/0YnWBLcpYQSsbKlzgLsmap2CVqsmiVlJSRp4PL5/2XGMdGcVe
   sk2XHeba0Yg5G3fwhKU418c5Iu14/NvTXUEfZp/IhXqSQYqr9SvpRdpDJ
   9PEmymiFKJPrD5jzwbUnAfgB9vbltW5NlMYSvzdI6vloXS1aw+Pr3OWg9
   DMFDS2vvM62zwYlNX+P2+inqqRkSvIhgR+7jCKl2iOu45Ut2ln6XNsxNF
   gjlao4YxNTDQgYvKC2g8QmKbxf7O2udY4cPwFW6MZuALSHTlYYj4OqHDA
   Ri6ojfhIO4kt+HxBa7v6RG0YQWeivmpOWdAcx9I6Mg8zZdMlvrDGbCtOw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435526667"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="435526667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726190178"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="726190178"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 01:49:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 01:49:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 01:49:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 01:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB5TZwVIz1Za5GTXawDS6AuwIj2658EktmX/ogOIlFShbj4zCY749FbZisIH3qfdsOd+hC9keCVNakHTf4FOPI6rMYkSM67ldrNrsHGQhm1qqcXVQer4/y5C1i5kQIMdsMPtCu/vy+Pz/zSWqWd8T+HTMA4kLLyF47Of6AsaDqv5g5XxwauoAgPhul646J+FFCs1MIk0uaMfT4EPCFXb8+usNJpSw+YUB6IaG+DHDkxa4noIL6FWQ89LWpNCYek4jtE9VH5Ad52CgwZQvgM19eIbzQsRAkHsVc+YUsR6Vy7dvj3CMgmf8K2w22rmgKsdTTg35Wz2RbcAV70e5DI3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6H/VkFs4Md99+agqIA3nv7p5zQdq8tfnmBQaRZCskA=;
 b=HpP1kv9qO2hRl0b9SjfffSEpUTMkUZsZ9yHSrMzI4RL2gFrSSZVigG8TcnP5fnqylos5vbjWN01Z+1tAKexzeJ/1ALNGKvUOoGCMdgheosw6NXl6s6EQvkqdOSpxX5UgSGE7Og3fZ5WLwlw7tNOAXWdAx8W6dBGe1AlGRA6XhUHT6U1bRarJdImyVVa1gRiy3zZn0GOgwPFPeDhKMNiF/pSuZtW/FJzBTYADc2p2waqK9FuG7UoZtifClwUtnDnTtsHAszBK+pp+nh+LSOdGz/SlR/qJGrX8lhrHKmtBnB41BjQ0QaZy/bVJPqNsAFhK2QHH8Gp8cNHCRPoEcD2Mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 08:49:25 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 08:49:25 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Topic: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/hkRcAgANC9IA=
Date:   Fri, 11 Aug 2023 08:49:25 +0000
Message-ID: <ca8805c9368f0b9f7459b7ecadd963e95fb32d98.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <ZNM5qoUSCdBwNTuH@chenyu5-mobl2>
In-Reply-To: <ZNM5qoUSCdBwNTuH@chenyu5-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA0PR11MB4733:EE_
x-ms-office365-filtering-correlation-id: e91f41cb-48dc-4f42-47a7-08db9a47dd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: at1iparSDG48qTUYCDR6on8JBKPi86u1PWmmMxz0h+9+6w5zdD0g+JpvZmqhTC28450o2qbzUwB2hcXrxf8OLikM+fPIHtBe1cR0JPDRMp/Pz820t5Asq+wut2d6CvgcEg4aCsVNaWjgVDpTo0qQjChXOYnTg5gXZYRHXMFKcWs0lMGHejfslLglaS8Agi8/ovYcMQ5r+w69Vn3Y/L/xB4QLVtLtUpiBD4RHUfBqw2fqe9DlH6W3Px4eDwYoYnpoL6NCqKn1MLLzzisiqML822PmIsqnVEML7MqN311Bwd1Okl5I4qC/bQ4rUZL5S2ErnRSCzpQ7ZREJ+qJ8IgdqmA0tCwgcjt/WWnLP0pSUxi1BAw0aNAvdTB602XZpos6geaVOre/Jc6gRZ5xI6GOZ5At3fW5oIEfsqqce8rPeoOHV6xsCAwLNIYL4nUzsvXuElSifjTbzCWH19+6j0Qno+FlnVvXmUFV4ZSMGhryOLw4roNjmfzPQCCnjbh7x/LsMIsYfbtGAOH7TW+ZfwbVhfTFegU6yPwJWO3r2DAGvu7W8iSelPLGpcJgIvrCz3ZGiu8IfmzeifFozxhuvrT2LCXqyg0rNTCKj5PMie6EiRWX6i7zQbFGwk7s7P74lbC2T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799006)(451199021)(186006)(54906003)(37006003)(478600001)(86362001)(6506007)(2616005)(26005)(36756003)(38070700005)(71200400001)(122000001)(53546011)(82960400001)(83380400001)(38100700002)(6486002)(2906002)(6512007)(64756008)(76116006)(66556008)(5660300002)(66476007)(66446008)(66946007)(41300700001)(91956017)(8676002)(316002)(6862004)(4326008)(8936002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXJGU1luRGsrT211c1k0ZHljb3Rac2RqQ2crOFRKRTNObmR6MDl6Y3Z2VjVE?=
 =?utf-8?B?clZINk85dkRFSHc5N08vMnZmWjlKL285RytVeGkvNnZGcCtkVmNnblR6ODRt?=
 =?utf-8?B?cjkyZWR2NWIrQjA0eVlJSjhxS2VvbkxCcFFKZmJablRjSFZTeUhmTHlTd1J5?=
 =?utf-8?B?cjlYLzIzNmR6RTdLSXQwazNaWjVBYTNheDR2YTAvbGVyNTgvZXdZZ05NZWFy?=
 =?utf-8?B?RUlKUXVvSGpydXVUYXVQbmd0eXBtWEc0VU1jOTRrcWg4b0JoQTJJcjMzdExT?=
 =?utf-8?B?OGRIRFBBOGpTYjBLTEJtWkMvcmhyZkZFWXNHZ1JXRG1PV21IZVdPaWdyVGVw?=
 =?utf-8?B?UTNjaURLQ1JMWE9PSlYrNGY3SlZvWVNOUU1BR1FWQk15aDhaZzRDVGphZ1Mv?=
 =?utf-8?B?NEozMXFVQ2F1YmNSV2RaNzdGMXVnYkdCL2xhYXJIMjJybEhpVWNqelhRZHRs?=
 =?utf-8?B?SHFQZHA1ajBpaXErd1NMb1dWMGxXYXlQSUlzTmZzcDZvK2hmZzYrV0F3S0Fs?=
 =?utf-8?B?OXk4Vk1RdERBTTRHVFFtWHB5TW1HRXR6eWl0WWFwbHgvWFFra3BnYnV2Mkwv?=
 =?utf-8?B?M3kxdGRPVnl2V2hhOFVNbDV5Q21wMnRGb1A5aUVQaERMbitOZmJKL2hzeXIv?=
 =?utf-8?B?eVcwMTRVS3lhb29HOVFVTUlXeDVJTWNXcU5wY2lPdmZ5clJDcHJQcHpPSE1Q?=
 =?utf-8?B?eS9DZTZaQmRNTkdIM3RidFRocWg1S0JFTThzbXVLWmRKWWpnQ1dVUDQySGpB?=
 =?utf-8?B?by9id2RRNWxSdkw0S2V0Wi9xdFAyc1NiQnVvcm1RdkgwU25ncVQvZnYrNGd4?=
 =?utf-8?B?VFJSaHlRU01aeXB5Y2Y5TDRkeUZjU1A5eXhvb0RvdGFITGIzcWdRbUpqOWZR?=
 =?utf-8?B?TnlHQTdObmx4Yit1OXVrVG4zdS92K2YxWlZINS9UL0NRV3V1dm5FOCtJWUdi?=
 =?utf-8?B?VFhQOGZmVXl1NVZGOSsvRmdRR1g1bVM5ejJIMVdsQmp4M2pkWjQ0cmtFMXJN?=
 =?utf-8?B?ZzAxVlNneDFkRUJReDUrWUtpZGNjSXlaNTl2bEVxbS9KbWhPak1ha2QraWhO?=
 =?utf-8?B?SEttamxuM3VnM2ZTMnVTdkpWN3F3ci9jVS9PRHc5Z1dHVjd4RGI4Qk9WVzlu?=
 =?utf-8?B?eW9tYjZpeEZtajRLQmlCL2hBVkVFMlZUVHZYc2hraGZaTklUVHRjcWEyRWNS?=
 =?utf-8?B?bkxtdXNpNkdqNVJiUjlHSmNabUxFMXJsTWRMTU9YcXFPb1JydVZZSERIcjJM?=
 =?utf-8?B?Q1lPdFBPTHhhRzhQYUxVR3U3RzJVSWVFZGJLeVNqU0xhY3RpdGJhdUNmVkxZ?=
 =?utf-8?B?dkhWYTEzbTNWV0RHVTMrekFsQSsvaDVZZFdEV0wzd1p6cDZvZjR6cFhlc2Yy?=
 =?utf-8?B?cHl5MHpSSnYyQkQ2Q0xvYTY1Rk9MSVJCaGpSYXRIMkt6MGVRRjdHTHg2M255?=
 =?utf-8?B?dW1FQ2hNZVd0UERjR2JCK004RXZwSlIzVXk0UTRrWGxaOGorVjh5NXk0Ukdz?=
 =?utf-8?B?VEZ1YTdDMVg1VjZudE5zNzZXZHRQSEkxMVBjMFhrVUZ4aWRBczVkSjdyWG1v?=
 =?utf-8?B?MFNCQVJoR2FoUEwwY2pGa0VpSU82bXNDQ0ZGNmVQL1lXUS9SQng1TXh1L25v?=
 =?utf-8?B?d0tvV01pUy9tOE1MSm0yRXkxZjVmSWtYWmFGeWVhUmxzSEVBczZLMGlSN3cv?=
 =?utf-8?B?eDVvRnBHTG41cElzOW1pVVhsUzJ0eUF1UUNxeTlJQ25SK0gzd0VkRUJvMzAw?=
 =?utf-8?B?eHVFYkZnS2lzdjBZRGFYUndtUzFXNzZrNG1Wczc1UUlQVzZJdXN6VTBTRGpX?=
 =?utf-8?B?TWc4L0UzZFpMVDNqMzZPRmorb3VCNlR4L3hFVjV6dS9QTFZaaThhZmpVT2c1?=
 =?utf-8?B?MHBDZEZKdHBxTnBUcEtBeHhmVCsxM1JzejFBb0RNZmFKdEpxRGk0U2lVem1i?=
 =?utf-8?B?YzFvcjVnU0xXejd3Q05IbjhwbTdScmFUbkNLalB3Z3VKbzJpd2R3U3pqWFp0?=
 =?utf-8?B?NDBJQU03cVVPbEt2R0RaOFp3V29Ua1kvOCtQYUVNYUM4L0VQTVhaRU15U1Z5?=
 =?utf-8?B?L3VDeEcwWlltRm5qYUZJR2JDL3VvUUNUWmc3Y0JYZ0cvSzR0ckVrYnoyL3NJ?=
 =?utf-8?B?OG8rQzZLakx5U1kzeWpTdjJ6VFdNWmlPSWtPVDk2QjJlMm5uWlYrTkd1d3d5?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F94D18CF447A4CBE90348994B8757D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91f41cb-48dc-4f42-47a7-08db9a47dd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 08:49:25.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kRv0aI7tDmyR/2bbQLhxObeCchNSfOQx4juE+MyTdnUSioonYqewPbC6j4Qkf1hvc0rFxixw4Qy7emnUPdusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
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

SGksIFl1LA0KDQpPbiBXZWQsIDIwMjMtMDgtMDkgYXQgMTU6MDAgKzA4MDAsIENoZW4gWXUgd3Jv
dGU6DQo+IE9uIDIwMjMtMDgtMDQgYXQgMTc6MDg6NTggKzA4MDAsIFpoYW5nIFJ1aSB3cm90ZToN
Cj4gPiBQcm9ibGVtIHN0YXRlbWVudA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gV2hlbiB1
c2luZyBjZ3JvdXAgaXNvbGF0ZWQgcGFydGl0aW9uIHRvIGlzb2xhdGUgY3B1cyBpbmNsdWRpbmcN
Cj4gPiBjcHUwLCBpdA0KPiA+IGlzIG9ic2VydmVkIHRoYXQgY3B1MCBpcyB3b2tlbiB1cCBmcmVx
dWVuY3RseSBidXQgZG9pbmcgbm90aGluZy4NCj4gPiBUaGlzIGlzDQo+ID4gbm90IGdvb2QgZm9y
IHBvd2VyIGVmZmljaWVuY3kuDQo+ID4gDQo+ID4gPGlkbGU+LTDCoMKgwqDCoCBbMDAwXcKgwqAg
NjE2LjQ5MTYwMjogaHJ0aW1lcl9jYW5jZWw6wqDCoMKgwqDCoMKgDQo+ID4gaHJ0aW1lcj0weGZm
ZmY4ZThmZGY2MjNjMTANCj4gPiA8aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjA4
OiBocnRpbWVyX3N0YXJ0OsKgwqDCoMKgwqDCoMKgDQo+ID4gaHJ0aW1lcj0weGZmZmY4ZThmZGY2
MjNjMTAgZnVuY3Rpb249dGlja19zY2hlZF90aW1lci8weDANCj4gPiBleHBpcmVzPTYxNTk5NjAw
MDAwMCBzb2Z0ZXhwaXJlcz02MTU5OTYwMDAwMDANCj4gPiA8aWRsZT4tMMKgwqDCoMKgIFswMDBd
wqDCoCA2MTYuNDkxNjE2OiByY3VfdXRpbGl6YXRpb246wqDCoMKgwqDCoCBTdGFydA0KPiA+IGNv
bnRleHQgc3dpdGNoDQo+ID4gPGlkbGU+LTDCoMKgwqDCoCBbMDAwXcKgwqAgNjE2LjQ5MTYxODog
cmN1X3V0aWxpemF0aW9uOsKgwqDCoMKgwqAgRW5kIGNvbnRleHQNCj4gPiBzd2l0Y2gNCj4gPiA8
aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjM3OiB0aWNrX3N0b3A6wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdWNjZXNzPTENCj4gPiBkZXBlbmRlbmN5PU5PTkUNCj4gPiA8aWRsZT4t
MMKgwqDCoMKgIFswMDBdwqDCoCA2MTYuNDkxNjM3OiBocnRpbWVyX2NhbmNlbDrCoMKgwqDCoMKg
wqANCj4gPiBocnRpbWVyPTB4ZmZmZjhlOGZkZjYyM2MxMA0KPiA+IDxpZGxlPi0wwqDCoMKgwqAg
WzAwMF3CoMKgIDYxNi40OTE2Mzg6IGhydGltZXJfc3RhcnQ6wqDCoMKgwqDCoMKgwqANCj4gPiBo
cnRpbWVyPTB4ZmZmZjhlOGZkZjYyM2MxMCBmdW5jdGlvbj10aWNrX3NjaGVkX3RpbWVyLzB4MA0K
PiA+IGV4cGlyZXM9NjE2NDIwMDAwMDAwIHNvZnRleHBpcmVzPTYxNjQyMDAwMDAwMA0KPiA+IA0K
PiA+IFRoZSBhYm92ZSBwYXR0ZXJuIHJlcGVhdHMgZXZlcnkgb25lIG9yIG11bHRpcGxlIHRpY2tz
LCByZXN1bHRzIGluDQo+ID4gdG90YWwNCj4gPiAyMDAwKyB3YWtldXBzIG9uIGNwdTAgaW4gNjAg
c2Vjb25kcywgd2hlbiBydW5uaW5nIHdvcmtsb2FkIG9uIHRoZQ0KPiA+IGNwdXMgdGhhdCBhcmUg
bm90IGluIHRoZSBpc29sYXRlZCBwYXJ0aXRpb24uDQo+ID4gDQo+ID4gUm9vdGNhdXNlDQo+ID4g
LS0tLS0tLS0tDQo+ID4gSW4gTk9IWiBtb2RlLCBhbiBhY3RpdmUgY3B1IGVpdGhlciBzZW5kcyBh
biBJUEkgb3IgdG91Y2hlcyB0aGUgaWRsZQ0KPiA+IGNwdSdzIHBvbGxpbmcgZmxhZyB0byB3YWtl
IGl0IHVwLCBzbyB0aGF0IHRoZSBpZGxlIGNwdSBjYW4gcHVsbA0KPiA+IHRhc2tzDQo+ID4gZnJv
bSB0aGUgYnVzeSBjcHUuIFRoZSBsb2dpYyBmb3Igc2VsZWN0aW5nIHRoZSB0YXJnZXQgY3B1IGlz
IHRvIHVzZQ0KPiA+IHRoZQ0KPiA+IGZpcnN0IGlkbGUgY3B1IHRoYXQgcHJlc2VudHMgaW4gYm90
aCBub2h6LmlkbGVfY3B1c19tYXNrIGFuZA0KPiA+IGhvdXNla2VlcGluZ19jcHVtYXNrLg0KPiA+
IA0KPiA+IEluIHRoZSBhYm92ZSBzY2VuYXJpbywgd2hlbiBjcHUwIGlzIGluIHRoZSBjZ3JvdXAg
aXNvbGF0ZWQNCj4gPiBwYXJ0aXRpb24sDQo+ID4gaXRzIHNjaGVkIGRvbWFpbiBpcyBkZXRlY2hl
ZCwgYnV0IGl0IGlzIHN0aWxsIGF2YWlsYWJsZSBpbiBib3RoIG9mDQo+ID4gdGhlDQo+ID4gYWJv
dmUgY3B1bWFza3MuIEFzIGEgcmVzdWx0LCBjcHUwDQo+ID4gMS4gaXMgYWx3YXlzIHNlbGVjdGVk
IHdoZW4ga2lja2luZyBpZGxlIGxvYWQgYmFsYW5jZQ0KPiA+IDIuIGlzIHdva2VuIHVwIGZyb20g
dGhlIGlkbGUgbG9vcA0KPiA+IDMuIGNhbGxzIF9fc2NoZWR1bGUoKSBidXQgY2Fubm90IGZpbmQg
YW55IHRhc2sgdG8gcHVsbCBiZWNhdXNlIGl0DQo+ID4gaXMgbm90DQo+ID4gwqDCoCBpbiBhbnkg
c2NoZWRfZG9tYWluLCB0aHVzIGl0IGRvZXMgbm90aGluZyBhbmQgcmVlbnRlcnMgaWRsZS4NCj4g
PiANCj4gPiBTb2x1dGlvbg0KPiA+IC0tLS0tLS0tDQo+ID4gRml4IHRoZSBwcm9ibGVtIGJ5IHNr
aXBwaW5nIGNwdXMgd2l0aCBubyBzY2hlZCBkb21haW4gYXR0YWNoZWQNCj4gPiBkdXJpbmcNCj4g
PiBOT0haIGlkbGUgYmFsYW5jZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkg
PHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBrZXJuZWwvc2NoZWQvZmFpci5j
IHwgMyArKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4gPiBpbmRleCBiM2UyNWJlNThlMmIuLmVhMzE4NWE0Njk2MiAxMDA2NDQNCj4gPiAtLS0gYS9r
ZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+IEBA
IC0xMTM0MCw2ICsxMTM0MCw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGZpbmRfbmV3X2lsYih2b2lk
KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlsYiA9PSBzbXBfcHJv
Y2Vzc29yX2lkKCkpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY29udGludWU7DQo+ID4gwqANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKHVubGlrZWx5KG9uX251bGxfZG9tYWluKGNwdV9ycShpbGIpKSkpDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsNCj4g
PiArDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaWRsZV9jcHUoaWxi
KSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gaWxiOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0
byBwYXNzIGEgdmFsaWQgY3B1bWFzayB0byBraWNrX2lsYigpIHZpYQ0KPiBub2h6X2JhbGFuY2Vy
X2tpY2soKQ0KPiBhbmQgbGV0IGZpbmRfbmV3X2lsYigpIHNjYW4gaW4gdGhhdCBtYXNrPyBTbyB3
ZSBjb3VsZCBzaHJpbmsgdGhlIHNjYW4NCj4gcmFuZ2UNCj4gYW5kIGFsc28gcmVkdWNlIHRoZSBu
dWxsIGRvbWFpbiBjaGVjayBpbiBlYWNoIGxvb3AuIENQVXMgaW4gZGlmZmVyZW50DQo+IGNwdXNl
dCBhcmUgaW4gZGlmZmVyZW50IHJvb3QgZG9tYWlucywgdGhlIGJ1c3kgQ1BVKGluIGNwdXNldDAp
IHdpbGwNCj4gbm90IGFzaw0KPiBub2h6IGlkbGUgQ1BVMChpbiBpc29sYXRlZCBjcHVzZXQxKSB0
byBsYXVuY2ggaWRsZSBsb2FkIGJhbGFuY2UuDQo+IA0KPiBzdHJ1Y3Qgcm9vdF9kb21haW4gKnJk
ID0gcnEtPnJkOw0KPiAuLi4NCj4ga2lja19pbGIoZmxhZ3MsIHJkLT5zcGFuKQ0KPiDCoMKgwqDC
oMKgwqDCoMKgIA0KDQpZZWFoLiBUaGlzIGFsc28gc291bmRzIGxpa2UgYSByZWFzb25hYmxlIGFw
cHJvYWNoLiBJIGNhbiBtYWtlIGEgcGF0Y2gNCnRvIGNvbmZpcm0gaXQgd29ya3MgYXMgZXhwZWN0
ZWQuDQoNCnRoYW5rcywNCnJ1aQ0K
