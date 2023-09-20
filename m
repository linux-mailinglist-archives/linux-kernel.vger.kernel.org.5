Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312E7A73F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjITHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjITHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:24:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F7D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695194665; x=1726730665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t+g3w5Z/valVchiD57S3FMrTWwrsi0SPXSVGlxhVrFw=;
  b=OxKh0VRDB331fOXByT+3fpP9K0x/SNobpt3HgJpSwuTQguhGtiomRDuh
   fyUX2xB3Sgd2lJSwUpXGMJdVbELr07/PmZNNvfG/wx0vSC8JfFP7tB/B2
   zg2I6E0wBarM8kMX1QBigsSSy4lfbupY00X2N0e0lzHnFieWj+2oqn1XH
   lct7gYXTZX0h3U91gn0yu/FFwBjJq6Q3vpw9IUXewC/HunOifsLrXaYPS
   paC1r2ALddpOskV2aF4u34fkdewRr+wUUGnfZPoI1/7/28ZXeReOHMuii
   NK642bxjOLkkTmnJr452NZBND7rtn0cNL7humA0rY5suzGXkiGXQ4BwaN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411087583"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411087583"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781592382"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="781592382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 00:24:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 00:24:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 00:24:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 00:24:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 00:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D96JbWNtonUgH2j3NGhU/FNpCLjq+f9aHJrzJgfqhZ5zttBVkeFRzKIiqwo2SUVawMvRxOId0sppulJDMUfnHr+KEgzSGh7mMcWslwA6NTtXWYZuQp/sXaPm5QhD1hV5SQYAbNDk4ZLNJ6OP6YuIyZYoRoM2VKm/f+ijDdIRhSn9/KkBDaRmjavuvoneTkPNd3oZDmT8LdG347IAXK6B1B3vCqufjACoV49/h427e8k+9W4tCw/IRV3JT00YBs3FdRFzK2AFL61REoDcKEQQuSiZWIdOqx40FYlHEr/9tIMq0OBS9DkUBxgu6xdu7uPxAS9iP7fzgsH3p5/hHQjeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+g3w5Z/valVchiD57S3FMrTWwrsi0SPXSVGlxhVrFw=;
 b=k+NOgvada0kxLdiYUjJyPyIWQlVObfYIGy8ABYeG8UF72fL8AVFzRs1KzaN3bjoqfiszd7vko2/DO/iBqKUGcoqgCjY2rV19QEnrj683ftTzBYIlN7//XTxQ5iZMWY8VxDTl2bkIDgEO37JxCPWw18S+s3PzH23xdo4RE0BNyt53vAs/JUCfyRVWAuV549VzvDFIqAnWgUeKCEGf9ND4H/2Nlf4uGkpczs48ikq7eR6H8kBlkMxnvkDoOBcoIJByYedcw1mFctu0+FbN0crq+MafVsd55UlF3oMhWbd/x/ONJX1zHvfqzXxa2iEzywqpHHo4txXAgJ3DdcVuKXFEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7830.namprd11.prod.outlook.com (2603:10b6:8:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 07:24:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::c869:bfc3:8472:8049]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::c869:bfc3:8472:8049%4]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 07:24:14 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Topic: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/pLXsAgABYUICAJ16+AIAE2BgAgABOrQCAAXNYgIACziKAgABcLQCACPCKAA==
Date:   Wed, 20 Sep 2023 07:24:13 +0000
Message-ID: <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <20230814031432.GA574314@ziqianlu-dell>
         <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
         <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
         <20230911114218.GA334545@ziqianlu-dell>
         <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
         <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
         <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
         <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com>
In-Reply-To: <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7830:EE_
x-ms-office365-filtering-correlation-id: 0fa172ea-5e36-49ad-16b9-08dbb9aa9785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LdyGjrRYQQRfmUFJLu0UNemUvflPG88DrK4tdxFzuZsXZPOVwDV2+oZbbIwGNE5svnxvrY5eRARJmxWiwKMkBCqG3o2kpGfR9x//d+A8EyaxRKezNepS5cznnJBNk31Zfw3TVOhtjir4zFBocOSEh1MEupxdcWnRckjuUBNNzNop/FOD43BrPOUQIVsmLxhCM2sG7xD8OR1/RxbLPb/ZgpczAKHrGf97fkYcMctcAahch+vfgB0RXnnQezXq0607cMp/r2sHsA6pDf8grbCwbqNVzbModwGPbfcW1/yDW4XsFT1kVyNKjgng0SKCul2YOgiMa9Pk400vjS5Q/8+0df/eG258ZiUM4U8A8dYDYm3iWlBWlHWH1eIMP2druDT8EaQF5UN9XBew5wuoL7Omz8T50rZuNDSBlq+kLq8I6FrEcOlXEcB3F1NLNif5EXdQIeID1MFHXF9QHGxF00PKHhL4/Yk3YJSDnW8ZycaC9cgg2DbtmQksNDDKW9OJHq7pyrIRIb54hQguQUnulyF+22ECceTj8B+YRjgh+LtSzUFXlonl3qufSYeB7Vq93xwBM7gq9MhhIDbpv1AnfNz314zht/jTlhuhso4rXBbLwZduN/0X4Mqp01WLdZ7Zo2cH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(110136005)(316002)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(86362001)(91956017)(2906002)(82960400001)(122000001)(38070700005)(38100700002)(36756003)(41300700001)(5660300002)(478600001)(71200400001)(6486002)(53546011)(6506007)(6512007)(4326008)(66899024)(26005)(107886003)(83380400001)(8936002)(8676002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnZ0MXpZS2lJZTRyM3RwWjJDSWVBMmtJVTdGVFQvUFdNcW9XU0t3dW9QQTN3?=
 =?utf-8?B?aHhqRGFrTVU0ZEhIcytxU2VRWDN5ODZUOUxUaU1RdTdYYUxxVDNNNzliR1lW?=
 =?utf-8?B?RFpQN00wUGZHcDVaenpYZEdYaXdOLzZ6cHh1MWZyQkVZbEJwRzhkd1dRSWtZ?=
 =?utf-8?B?L08zSmJZU1JCMlBtTVJMRW9uY200dFUwUjNleU1ZRnpRLzVnakVNRlJveE9J?=
 =?utf-8?B?MlJTUm42bnNMR2ZodGs1Mk9hRUh6NjQxTmYvRHRobjJBUEFSMm1nc3ZaMEho?=
 =?utf-8?B?WjB2S3N4dmVEWExEeGZFV1Q1OWFnWTcwV0xpb2hkbkJmV0Q2N2o1TDI1LzVR?=
 =?utf-8?B?emhXTFVCWkFxVEk0T1dlSlhZRVkxM3Q1OHplSjQ5a2R6QUE4ampvM2dUdGho?=
 =?utf-8?B?NDBxdFd1a3BXd1NxTUN5azh3K3pZNVA2NzRQdEQrSk1md2xxTHVLb0RHalNm?=
 =?utf-8?B?Z3BQNEtCQlV6cDFKT2dvM2cyN1lQL1p1cTQrc01yVUJnVlNpMmpMUUJickc0?=
 =?utf-8?B?S29RV0lDU0hlREd5NjV5SlRJdmkyUEMrdCt0N2lCeDBqRFhSc0Q2L3F5RDlw?=
 =?utf-8?B?REptWFVCd2tnelNrNE1PbnV0NG5ITWNpdTdyc2lLZ01IN0hzTDNSRjZ3dytS?=
 =?utf-8?B?YndjOFBQeXljTmdQTW9QSVVKbUJtTTFydkVuZy9nVGx4OUg5djRuVTdIcjAw?=
 =?utf-8?B?UVJoQmtiYldEeDRNVzB5QXlHc2hYK2pXOFZVRXNYZVhXNkdyZHowMmtqYm5j?=
 =?utf-8?B?NlJKb3c2SFNwTnZQZE5FRHJwbEtQM2JudGxuREI0ei9hVUhvUmJxWG8rSk1i?=
 =?utf-8?B?NlJtdUlDTmdsZUtlc0FZVkRoRndGOGR6NmdYdEYwbHg0eUQ4VkVRUW1NdGtI?=
 =?utf-8?B?cXFrT3NHSDVOZzBoTVV5aE9PSkZsL2tCZFNWMWJPT0JoZzhOU3NXbHVVZmNQ?=
 =?utf-8?B?aGZOYkNRQUZ2WkV6bUxaZCtIbkZUWkw4OGh4TWc5aWJhUHMxK0dUdXhXMzBp?=
 =?utf-8?B?ODZTY1NaSmVhQzNTVXU4RDJQUUwyYmNxMnBPZTl2aEx1T0JHY0xhL0ZIdlov?=
 =?utf-8?B?d3Q5SHVtTTBRYWpIU01SbXZrWEN5UDdNTnI1YURvUmlQUWJYWkwwQVIrMWNW?=
 =?utf-8?B?VndWYmxoRFZnblVqNXBGSHJ5bHNPRm5MelRWNXBvbWxVNXR5YkY2QmlEOUlI?=
 =?utf-8?B?dk45NW0wS3hGOTIyQjg3S2dXc25HY25EclRkU1Zrb0x2UEFzaDZVTHRSZ1Nx?=
 =?utf-8?B?RHZGRk9wQ25ZQ1VJOXFCTSs0cWtibDdjZElOZ2FCVkd5ZFNJODFSeUV4RDVO?=
 =?utf-8?B?MHdIQ1hCQ1FsczRid3VoUit3TWNleWw2b3E0c0E1V0hkQkFUdGtQeUhrYUZu?=
 =?utf-8?B?VnlVQm1VdGxSTmI1UDFyMlZvSXptZnI5SnM2NE9CWXh5c0pzclRjK0JGZVhZ?=
 =?utf-8?B?cGJEcUh2L0JpMk1CVHM4RGV1YnZLMkxaSmR2S0IwWlQyVEZ5Vy9WbTFlRXkx?=
 =?utf-8?B?SDdpN1JlRUFPVFhLdCswL2haTnlyTTRaMis3aXp6N09aRWJOM1lQUFNBdkFH?=
 =?utf-8?B?aCtNMzZTNTRFK0hHS0lqRWk1ZnIzTjV2YVNiemJpNGNMb1RXb0ZHM2d3bDg2?=
 =?utf-8?B?M2dLUjltaU9oQ2ZrRVVQNHZNYm41LzBhcjlISGpMRnM4STIzUnptYVBZUjhy?=
 =?utf-8?B?MVQyZHo1Q3MrdzMzdEplY0pXMlphMXl5ZWhGaWFsZ1R5N0Qyb1ZMbzdsamRR?=
 =?utf-8?B?dGgvRGpCUHBJdVhMZUNvL1I1c3VFcW8rRnRSK0ZoN1dKbDNySHY3eUE4THNE?=
 =?utf-8?B?aXlpWlkyUHh6WjBxb0RYenNLSmVKcVh2eEMrRitYWDhVK0I2blhyeHZ2VFdD?=
 =?utf-8?B?Sk5MRGUybms3Z3lvQktidTljdHhuRE0rT3hMVEM4Yk85UnQ0TkxaSnc3K3NE?=
 =?utf-8?B?eHRTL3hSYmlJWVQvWmpMUFM5MWJiQ2hZMFNRSEtiWHlLWnptSG1OVWFYYzA2?=
 =?utf-8?B?em0vTHNHclhBQ3FoLzRRcktKL3dsZ1cwWFF5c0poSTBZZ0lPbWtjQmdQVEFU?=
 =?utf-8?B?L3o1MTF5Slk0ak9DSVFuRzZydGJuT25zNFNDVlhGVWdia2MyQnoxSzZETGxO?=
 =?utf-8?B?STlOa0RNVmV6NzV1TTYzV0VSdnJNNXRRMTNML0trOUVNZDVYNitoZlR6dHJu?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <633A5F00CBEF774D80DA195A828A316F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa172ea-5e36-49ad-16b9-08dbb9aa9785
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:24:14.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/LJ+dhsEmB8WtRZvAzPZ6juMbwl9rYkAIHX9XssRliELAy2xrWBBXNCw209IVthPUtP5JWjCvh2XTnDgNgutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBpZXJyZSwNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLiBJJ20gc3RpbGwgcmFt
cGluZyB1cCBvbiB0aGUgcmVsYXRlZCBjb2RlLg0KDQpPbiBUaHUsIDIwMjMtMDktMTQgYXQgMTY6
NTMgKzAyMDAsIFBpZXJyZSBHb25kb2lzIHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTQvMjMgMTE6
MjMsIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gSGksIFBpZXJyZSwNCj4gPiANCj4gPiA+IA0KPiA+
ID4gWWVzIHJpZ2h0IGluZGVlZCwNCj4gPiA+IFRoaXMgaGFwcGVucyB3aGVuIHB1dHRpbmcgYSBD
UFUgb2ZmbGluZSAoYXMgeW91IG1lbnRpb25lZA0KPiA+ID4gZWFybGllciwNCj4gPiA+IHB1dHRp
bmcgYSBDUFUgb2ZmbGluZSBjbGVhcnMgdGhlIENQVSBpbiB0aGUgaWRsZV9jcHVzX21hc2spLg0K
PiA+ID4gDQo+ID4gPiBUaGUgbG9hZCBiYWxhbmNpbmcgcmVsYXRlZCB2YXJpYWJsZXMNCj4gPiAN
Cj4gPiBpbmNsdWRpbmc/DQo+IA0KPiBJIG1lYW50IHRoZSBub2h6IGlkbGUgdmFyaWFibGVzIGlu
IHRoZSBsb2FkIGJhbGFuY2luZywgc28gSSB3YXMNCj4gcmVmZXJyaW5nIHRvOg0KPiAoc3RydWN0
IHNjaGVkX2RvbWFpbl9zaGFyZWQpLm5yX2J1c3lfY3B1cw0KPiAoc3RydWN0IHNjaGVkX2RvbWFp
bikubm9oel9pZGxlDQo+IG5vaHouaWRsZV9jcHVzX21hc2sNCj4gbm9oei5ucl9jcHVzDQo+IChz
dHJ1Y3QgcnEpLm5vaHpfdGlja19zdG9wcGVkDQoNCklNTywgdGhlIHByb2JsZW0gaXMgdGhhdCwg
Zm9yIGFuIGlzb2xhdGVkIENQVSwNCjEuIGl0IGlzIG5vdCBhbiBpZGxlIGNwdSAobm9oei5pZGxl
X2NwdXNfbWFzayBzaG91bGQgYmUgY2xlYXJlZCkNCjIuIGl0IGlzIG5vdCBhIGJ1c3kgY3B1IChz
ZHMtPm5yX2J1c3lfY3B1cyBzaG91bGQgYmUgZGVjcmVhc2VkKQ0KDQpCdXQgY3VycmVudCBjb2Rl
IGRvZXMgbm90IGhhdmUgYSB0aGlyZCBzdGF0ZSB0byBkZXNjcmliZSB0aGlzLCBzbyB3ZSANCm5l
ZWQgdG8gZWl0aGVyDQoxLiBhZGQgZXh0cmEgbG9naWMsIGxpa2Ugb25fbnVsbF9kb21haW4oKSBj
aGVja3MNCm9yDQoyLiByZWx5IG9uIGN1cnJlbnQgbG9naWMsIGJ1dCB1cGRhdGUgYWxsIHJlbGF0
ZWQgdmFyaWFibGVzIGNvcnJlY3RseSwNCmxpa2UgeW91IHByb3Bvc2VkLg0KDQpCdXQgaW4gYW55
IGNhc2UsIHdlIHNob3VsZCBzdGljayB3aXRoIG9uZSBkaXJlY3Rpb24uDQoNCklmIHdlIGZvbGxv
dyB0aGUgZmlyc3Qgb25lLCB0aGUgb3JpZ2luYWwgcGF0Y2ggc2hvdWxkIGJlIHVzZWQsIHdoaWNo
DQpJTU8gaXMgc2ltcGxlIGFuZCBzdHJhaWdodCBmb3J3YXJkLg0KSWYgd2UgZm9sbG93IHRoZSBs
YXRlciBvbmUsIHdlJ2QgYmV0dGVyIGF1ZGl0IGFuZCByZW1vdmUgdGhlIGN1cnJlbnQNCm9uX251
bGxfZG9tYWluKCkgdXNhZ2UgYXQgdGhlIHNhbWUgdGltZS4gVEJILCBJJ20gbm90IGNvbmZpZGVu
dCBlbm91Z2gNCnRvIG1ha2Ugc3VjaCBhIGNoYW5nZS4gQnV0IGlmIHlvdSB3YW50IHRvIHByb3Bv
c2Ugc29tZXRoaW5nLCBJJ2QgZ2xhZA0KdG8gdGVzdCBpdC4NCg0KdGhhbmtzLA0KcnVpDQoNCj4g
DQo+ID4gDQo+ID4gPiDCoCBhcmUgdW51c2VkIGlmIGEgQ1BVIGhhcyBhIE5VTEwNCj4gPiA+IHJx
IGFzIGl0IGNhbm5vdCBwdWxsIGFueSB0YXNrLiBJZGVhbGx5IHdlIHNob3VsZCBjbGVhciB0aGVt
IG9uY2UsDQo+ID4gPiB3aGVuIGF0dGFjaGluZyBhIE5VTEwgc2QgdG8gdGhlIENQVS4NCj4gPiAN
Cj4gPiBUaGlzIHNvdW5kcyBnb29kIHRvIG1lLiBCdXQgVEJILCBJIGRvbid0IGhhdmUgZW5vdWdo
IGNvbmZpZGVuY2UgdG8NCj4gPiBkbw0KPiA+IHNvIGJlY2F1c2UgSSdtIG5vdCBjcnlzdGFsIGNs
ZWFyIGFib3V0IGhvdyB0aGVzZSB2YXJpYWJsZXMgYXJlDQo+ID4gdXNlZC4NCj4gPiANCj4gPiBT
b21lIHF1ZXN0aW9ucyBhYm91dCB0aGUgY29kZSBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gVGhlIGZv
bGxvd2luZyBzbmlwcGVkIHNob3VsZCBkbyB0aGF0IGFuZCBzb2x2ZSB0aGUgaXNzdWUgeW91DQo+
ID4gPiBtZW50aW9uZWQ6DQo+ID4gPiAtLS0gc25pcCAtLS0NCj4gPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvc2NoZWQvbm9oei5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkL25vaHou
aA0KPiA+ID4gQEAgLTksOCArOSwxMCBAQA0KPiA+ID4gwqDCoCAjaWYgZGVmaW5lZChDT05GSUdf
U01QKSAmJiBkZWZpbmVkKENPTkZJR19OT19IWl9DT01NT04pDQo+ID4gPiDCoMKgIGV4dGVybiB2
b2lkIG5vaHpfYmFsYW5jZV9lbnRlcl9pZGxlKGludCBjcHUpOw0KPiA+ID4gwqDCoCBleHRlcm4g
aW50IGdldF9ub2h6X3RpbWVyX3RhcmdldCh2b2lkKTsNCj4gPiA+ICtleHRlcm4gdm9pZCBub2h6
X2NsZWFuX3NkX3N0YXRlKGludCBjcHUpOw0KPiA+ID4gwqDCoCAjZWxzZQ0KPiA+ID4gwqDCoCBz
dGF0aWMgaW5saW5lIHZvaWQgbm9oel9iYWxhbmNlX2VudGVyX2lkbGUoaW50IGNwdSkgeyB9DQo+
ID4gPiArc3RhdGljIGlubGluZSB2b2lkIG5vaHpfY2xlYW5fc2Rfc3RhdGUoaW50IGNwdSkgeyB9
DQo+ID4gPiDCoMKgICNlbmRpZg0KPiA+ID4gwqDCoCANCj4gPiA+IMKgwqAgI2lmZGVmIENPTkZJ
R19OT19IWl9DT01NT04NCj4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIv
a2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+ID4gaW5kZXggYjNlMjViZTU4ZTJiLi42ZmNhYmU1ZDA4
ZjUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gPiArKysgYi9r
ZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gPiBAQCAtMTE1MjUsNiArMTE1MjUsOSBAQCB2b2lkIG5v
aHpfYmFsYW5jZV9leGl0X2lkbGUoc3RydWN0IHJxDQo+ID4gPiAqcnEpDQo+ID4gPiDCoMKgIHsN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBTQ0hFRF9XQVJOX09OKHJxICE9IHRoaXNfcnEoKSk7
DQo+ID4gPiDCoMKgIA0KPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAob25fbnVsbF9kb21haW4ocnEp
KQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4gKw0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaWtlbHkoIXJxLT5ub2h6X3RpY2tfc3RvcHBl
ZCkpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4g
PiA+IA0KPiA+IGlmIHdlIGZvcmNlIGNsZWFyaW5nIHJxLT5ub2h6X3RpY2tfc3RvcHBlZCB3aGVu
IGRldGFjaGluZyBkb21haW4sDQo+ID4gd2h5DQo+ID4gYm90aGVyIGFkZGluZyB0aGUgZmlyc3Qg
Y2hlY2s/DQo+IA0KPiBZZXMgeW91J3JlIHJpZ2h0LiBJIGFkZGVkIHRoaXMgY2hlY2sgZm9yIHNh
ZmV0eSwgYnV0IHRoaXMgaXMgbm90DQo+IG1hbmRhdG9yeS4NCj4gDQo+ID4gDQo+ID4gPiDCoMKg
IA0KPiA+ID4gQEAgLTExNTUxLDYgKzExNTU0LDE3IEBAIHN0YXRpYyB2b2lkIHNldF9jcHVfc2Rf
c3RhdGVfaWRsZShpbnQNCj4gPiA+IGNwdSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCByY3Vf
cmVhZF91bmxvY2soKTsNCj4gPiA+IMKgwqAgfQ0KPiA+ID4gwqDCoCANCj4gPiA+ICt2b2lkIG5v
aHpfY2xlYW5fc2Rfc3RhdGUoaW50IGNwdSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qg
cnEgKnJxID0gY3B1X3JxKGNwdSk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgIHJxLT5u
b2h6X3RpY2tfc3RvcHBlZCA9IDA7DQo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChjcHVtYXNrX3Rl
c3RfY3B1KGNwdSwgbm9oei5pZGxlX2NwdXNfbWFzaykpIHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNwdW1hc2tfY2xlYXJfY3B1KGNwdSwgbm9oei5pZGxlX2NwdXNfbWFz
ayk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfZGVjKCZub2h6
Lm5yX2NwdXMpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCB9DQo+ID4gPiArwqDCoMKgwqDCoMKgIHNl
dF9jcHVfc2Rfc3RhdGVfaWRsZShjcHUpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiANCj4gPiBk
ZXRhY2hfZGVzdHJveV9kb21haW5zDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGNwdV9hdHRhY2hfZG9t
YWluDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1cGRhdGVfdG9wX2NhY2hl
X2RvbWFpbg0KPiA+IA0KPiA+IGFzIHdlIGNsZWFycyBwZXJfY3B1KHNkX2xsYywgY3B1KSBmb3Ig
dGhlIGlzb2xhdGVkIGNwdSBpbg0KPiA+IGNwdV9hdHRhY2hfZG9tYWluKCksIHNldF9jcHVfc2Rf
c3RhdGVfaWRsZSgpIHNlZW1zIHRvIGJlIGEgbm8tb3ANCj4gPiBoZXJlLA0KPiA+IG5vPw0KPiAN
Cj4gWWVzIHlvdSdyZSByaWdodCwgY3B1X2F0dGFjaF9kb21haW4oKSBhbmQgbm9oel9jbGVhbl9z
ZF9zdGF0ZSgpIGNhbGxzDQo+IGhhdmUgdG8gYmUgaW52ZXJ0ZWQgdG8gYXZvaWQgd2hhdCB5b3Ug
anVzdCBkZXNjcmliZWQuDQo+IA0KPiBJdCBhbHNvIHNlZW1zIHRoYXQgdGhlIGN1cnJlbnQga2Vy
bmVsIGRvZXNuJ3QgZGVjcmVhc2UgbnJfYnVzeV9jcHVzDQo+IHdoZW4gcHV0dGluZyBDUFVzIGlu
IGFuIGlzb2xhdGVkIHBhcnRpdGlvbi4gSW5kZWVkIGlmIGEgQ1BVIGlzDQo+IGNvdW50ZWQNCj4g
aW4gbnJfYnVzeV9jcHVzLCBwdXR0aW5nIHRoZSBDUFUgaW4gYW4gaXNvbGF0ZWQgcGFydGl0aW9u
IGRvZXNuJ3QNCj4gdHJpZ2dlcg0KPiBhbnkgY2FsbCB0byBzZXRfY3B1X3NkX3N0YXRlX2lkbGUo
KS4NCj4gU28gaXQgbWlnaHQgYW4gYWRkaXRpb25hbCBhcmd1bWVudC4NCj4gDQo+IFRoYW5rcyBm
b3IgcmVhZGluZyB0aGUgcGF0Y2gsDQo+IFJlZ2FyZHMsDQo+IFBpZXJyZQ0KPiANCj4gPiANCj4g
PiB0aGFua3MsDQo+ID4gcnVpDQo+ID4gPiDCoMKgIC8qDQo+ID4gPiDCoMKgwqAgKiBUaGlzIHJv
dXRpbmUgd2lsbCByZWNvcmQgdGhhdCB0aGUgQ1BVIGlzIGdvaW5nIGlkbGUgd2l0aA0KPiA+ID4g
dGljaw0KPiA+ID4gc3RvcHBlZC4NCj4gPiA+IMKgwqDCoCAqIFRoaXMgaW5mbyB3aWxsIGJlIHVz
ZWQgaW4gcGVyZm9ybWluZyBpZGxlIGxvYWQgYmFsYW5jaW5nIGluDQo+ID4gPiB0aGUNCj4gPiA+
IGZ1dHVyZS4NCj4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYyBiL2tl
cm5lbC9zY2hlZC90b3BvbG9neS5jDQo+ID4gPiBpbmRleCBkM2EzYjI2NDZlYzQuLmQzMTEzN2I1
ZjBjZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC90b3BvbG9neS5jDQo+ID4gPiAr
KysgYi9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiA+ID4gQEAgLTI1ODQsOCArMjU4NCwxMCBA
QCBzdGF0aWMgdm9pZCBkZXRhY2hfZGVzdHJveV9kb21haW5zKGNvbnN0DQo+ID4gPiBzdHJ1Y3Qg
Y3B1bWFzayAqY3B1X21hcCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IA0KPiA+ID4gc3RhdGljX2JyYW5jaF9kZWNfY3B1c2xvY2tlZCgmc2NoZWRfYXN5bV9jcHVjYXBh
Y2l0eSk7DQo+ID4gPiDCoMKgIA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHJjdV9yZWFkX2xv
Y2soKTsNCj4gPiA+IC3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfY3B1KGksIGNwdV9tYXApDQo+ID4g
PiArwqDCoMKgwqDCoMKgIGZvcl9lYWNoX2NwdShpLCBjcHVfbWFwKSB7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdV9hdHRhY2hfZG9tYWluKE5VTEwsICZkZWZf
cm9vdF9kb21haW4sIGkpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9o
el9jbGVhbl9zZF9zdGF0ZShpKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJjdV9yZWFkX3VubG9jaygpOw0KPiA+ID4gwqDCoCB9DQo+ID4gPiANCj4g
PiA+IC0tLSBzbmlwIC0tLQ0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gUGllcnJlDQo+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIH0N
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIHRpY2sgaXMgc3RpbGwgc3RvcHBl
ZCBidXQgbG9hZCBjb3VsZCBoYXZlDQo+ID4gPiA+ID4gPiBiZWVuDQo+ID4gPiA+ID4gPiBhZGRl
ZCBpbiB0aGUNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtZWFudGltZS4g
V2Ugc2V0IHRoZSBub2h6Lmhhc19ibG9ja2VkIGZsYWcgdG8NCj4gPiA+ID4gPiA+IHRyaWcNCj4g
PiA+ID4gPiA+IGENCj4gPiA+ID4gPiA+IGNoZWNrIG9mIHRoZQ0KPiA+ID4gPiA+ID4gQEAgLTEx
NTg1LDEwICsxMTYwOSw2IEBAIHZvaWQgbm9oel9iYWxhbmNlX2VudGVyX2lkbGUoaW50DQo+ID4g
PiA+ID4gPiBjcHUpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocnEtPm5v
aHpfdGlja19zdG9wcGVkKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoCAvKiBJZiB3ZSdy
ZSBhIGNvbXBsZXRlbHkgaXNvbGF0ZWQgQ1BVLCB3ZSBkb24ndA0KPiA+ID4gPiA+ID4gcGxheToN
Cj4gPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgIGlmIChvbl9udWxsX2Rv
bWFpbihycSkpDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47DQo+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycS0+
bm9oel90aWNrX3N0b3BwZWQgPSAxOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3B1bWFza19zZXRfY3B1KGNwdSwgbm9oei5pZGxlX2NwdXNfbWFzayk7DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IE90aGVyd2lzZSBJIGNvdWxkIHJlcHJvZHVjZSB0aGUgaXNzdWUgYW5kIHRo
ZSBwYXRjaCB3YXMNCj4gPiA+ID4gPiA+IHNvbHZpbmcNCj4gPiA+ID4gPiA+IGl0LA0KPiA+ID4g
PiA+ID4gc286DQo+ID4gPiA+ID4gPiBUZXN0ZWQtYnk6IFBpZXJyZSBHb25kb2lzIDxwaWVycmUu
Z29uZG9pc0Bhcm0uY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB0ZXN0aW5nLCBy
ZWFsbHkgYXBwcmVjaWF0ZWQhDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQWxzbywgeW91ciBw
YXRjaCBkb2Vzbid0IGFpbSB0byBzb2x2ZSB0aGF0LCBidXQgSSB0aGluaw0KPiA+ID4gPiA+ID4g
dGhlcmUNCj4gPiA+ID4gPiA+IGlzIGFuDQo+ID4gPiA+ID4gPiBpc3N1ZQ0KPiA+ID4gPiA+ID4g
d2hlbiB1cGRhdGluZyBjcHVzZXQuY3B1cyB3aGVuIGFuIGlzb2xhdGVkIHBhcnRpdGlvbiB3YXMN
Cj4gPiA+ID4gPiA+IGFscmVhZHkNCj4gPiA+ID4gPiA+IGNyZWF0ZWQ6DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IC8vIENyZWF0ZSBhbiBpc29sYXRlZCBwYXJ0aXRpb24gY29udGFpbmluZyBD
UFUwDQo+ID4gPiA+ID4gPiAjIG1rZGlyIGNncm91cA0KPiA+ID4gPiA+ID4gIyBtb3VudCAtdCBj
Z3JvdXAyIG5vbmUgY2dyb3VwLw0KPiA+ID4gPiA+ID4gIyBta2RpciBjZ3JvdXAvVGVzdGluZw0K
PiA+ID4gPiA+ID4gIyBlY2hvICIrY3B1c2V0IiA+IGNncm91cC9jZ3JvdXAuc3VidHJlZV9jb250
cm9sDQo+ID4gPiA+ID4gPiAjIGVjaG8gIitjcHVzZXQiID4gY2dyb3VwL1Rlc3RpbmcvY2dyb3Vw
LnN1YnRyZWVfY29udHJvbA0KPiA+ID4gPiA+ID4gIyBlY2hvIDAgPiBjZ3JvdXAvVGVzdGluZy9j
cHVzZXQuY3B1cw0KPiA+ID4gPiA+ID4gIyBlY2hvIGlzb2xhdGVkID4gY2dyb3VwL1Rlc3Rpbmcv
Y3B1c2V0LmNwdXMucGFydGl0aW9uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC8vIENQVTAn
cyBzY2hlZCBkb21haW4gaXMgZGV0YWNoZWQ6DQo+ID4gPiA+ID4gPiAjIGxzIC9zeXMva2VybmVs
L2RlYnVnL3NjaGVkL2RvbWFpbnMvY3B1MC8NCj4gPiA+ID4gPiA+ICMgbHMgL3N5cy9rZXJuZWwv
ZGVidWcvc2NoZWQvZG9tYWlucy9jcHUxLw0KPiA+ID4gPiA+ID4gZG9tYWluMMKgIGRvbWFpbjEN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLy8gQ2hhbmdlIHRoZSBpc29sYXRlZCBwYXJ0aXRp
b24gdG8gYmUgQ1BVMQ0KPiA+ID4gPiA+ID4gIyBlY2hvIDEgPiBjZ3JvdXAvVGVzdGluZy9jcHVz
ZXQuY3B1cw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAvLyBDUFVbMC0xXSBzY2hlZCBkb21h
aW5zIGFyZSBub3QgdXBkYXRlZDoNCj4gPiA+ID4gPiA+ICMgbHMgL3N5cy9rZXJuZWwvZGVidWcv
c2NoZWQvZG9tYWlucy9jcHUwLw0KPiA+ID4gPiA+ID4gIyBscyAvc3lzL2tlcm5lbC9kZWJ1Zy9z
Y2hlZC9kb21haW5zL2NwdTEvDQo+ID4gPiA+ID4gPiBkb21haW4wwqAgZG9tYWluMQ0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+IEludGVyZXN0aW5nLiBMZXQgbWUgY2hlY2sgYW5kIGdldCBiYWNrIHRv
IHlvdSBsYXRlciBvbiB0aGlzLiA6KQ0KPiA+ID4gPiANCj4gPiA+ID4gdGhhbmtzLA0KPiA+ID4g
PiBydWkNCj4gPiANCg0K
