Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DA7EDC01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjKPHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjKPHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:32:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CADD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700119918; x=1731655918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6BK04c7BtkhHJlazE5MVp5NA/kuo/drMCwFN9NIwpyM=;
  b=cOb7pradW82AcLGyDkNihDcV2UK+dqR+6+hoLFOOblq6YGzyYyQkmrOC
   SdCyn8HhwmmpTf0Yl4o1OKXa3o+MBbkx/jSVElgP/UJKKDbDDpwpy52Eu
   ImUPYTwU29i5pObgPMiUH+GNdoiiAxrSdPap6s4ZrJZVq4tApHRXrA9k9
   1KiCuebjTB2NTHeFmfStv94BTnzCyVFiTd1zXTBMqrnURjSBPSh9ND9V6
   B/cc0DYf1oOxTwzLY375xkxlExCQvTMmh+2NlOVI2CY/zXOz0fUxmUPL/
   30Rrsurruz9BsZulYyUDnZdTOyC4QxHOXlw3/anAN2GFuSYDGJEwJoNZv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371216190"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="371216190"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="835661466"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="835661466"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 23:31:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:31:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:31:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:31:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:31:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaSlHeYuuJyF5S+Ad1mbAWLSmtjIxGfd4IzJ/DinJCsRcy7Gnq4O8TOFAt5zI1s/mMMUpOTskAjSSMxKR9Rxs37IJWXQDudV9Zi8YaGpo7iQZEAMVrR36zyk1KM+4Y/hAt1x8oIfyxrzb8gNUj4Cq11st3XZgIU7j5zhRZYDPAIu70NvChlpzlwLoY8vi653Z3f6ig5Y2pQsih4rP+Hju/blOimwDp+vkk+LaFzTX9Zt/thQy4hVYNFhB+tS9VRjvlrfJ61REvpKui3Dv8HsotlzzdwNLl7ytW7xhaAbru7cvZQ6vEq8pwWcGYRxyz2G4JUZLKrM5BOi9PyKBiGWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BK04c7BtkhHJlazE5MVp5NA/kuo/drMCwFN9NIwpyM=;
 b=RBiIZIi76ybjcrkDf8pdtGIRFkj5YULnSHY18VZNnzP9I7mBtCdpn8hQwH+50lAv8R2PLfJ7WCSg+lQ+lDfs8gI61CzEEvVBn6rgt+eoYaSgM/EyXp/8bLZOiNoTrbU9fsRg3Rhz3TljEuxuuRPfziiAJxLuWgZoIkup5adcqM4ZtkuClvMjXSNVSNCNGC3y/URDe3hKtsjINAhoe9YeW+Xby9Ljxtl0fCaeiA/wLWeF8M+23iU3aiTJH60g9jhMkxBXclhr6JJMWAa2n0/toRkIcoTStAK+86F+de6y0XW3/DJL+T3hyMzoA7mCoYw7hgqUgnaoBqu46KVceOcMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 07:31:42 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 07:31:42 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
CC:     "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "Lu, Aaron" <aaron.lu@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Topic: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/pLXsAgABYUICAJ16+AIAE2BgAgABOrQCAAXNYgIACziKAgABcLQCACPCKAIBY1keAgADAigA=
Date:   Thu, 16 Nov 2023 07:31:41 +0000
Message-ID: <ee5213de2f1f8e5071201b7030b262163c15d095.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <20230814031432.GA574314@ziqianlu-dell>
         <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
         <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
         <20230911114218.GA334545@ziqianlu-dell>
         <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
         <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
         <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
         <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com>
         <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
         <CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com>
In-Reply-To: <CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5644:EE_
x-ms-office365-filtering-correlation-id: 541909a5-126d-4507-8113-08dbe676140f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W9W1Utwi2cTnrDHDuqtDxF69yISeNCO9+rdN4IZp3I3kiUN+ohsLPL3Gu7ULKw0kpqUoLRt0sDDG2aTsXCTGgtY3aXlv++aPUlk3iHhMqLcB++aH5ayleuB8kRlYyMVBR33vkEd5rEDemFBR4ZEtuV4VuvofwbLe+HrldnWBS5fhJGIK2ySrmE8oxP+4LedS+b78lPqGvRsYDZ3IHQzTdvbcKmJ/XGBnFI90h9XifIqUKzdg7rShlGFSerCiWbsJQyByEuJ1Nl++++aR7bFKjoitz7sU6NhCU946/TQOKTCOuxXl3Rr9lcWPLr1VJ8LAp70dsvQXhQe5JlO7xM2U7A3a68qHgARiO6z24rDHdxaefAozye1NLKxqVU8xfD3GdmFD7eaLo0ezutee/5lLYazeQG/OuqMRlBar9xXR1/ZBfDVPWpCG3Y2UrI5UZIiKVT9hHGNz48Yxl8xhQJjEFLv4WTJujPy6/li3NaCbVTUJcIKm/9dBbUQ4Nm2j2GA9+IzKt4Uw332Y1T0Me6Ujq94yr4MWksAUU+/BW2JBcLQPxj6kheuv4tvS5Oq0iAemk87DUEfrf+6s52DZemp52xfoLymmhw+6SrE02GaZJaKkmRnGvp6gmMozI30YbXtP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(66899024)(6512007)(82960400001)(76116006)(26005)(6486002)(478600001)(64756008)(36756003)(8936002)(86362001)(4326008)(5660300002)(8676002)(4001150100001)(2906002)(41300700001)(38070700009)(6916009)(54906003)(66946007)(66476007)(66556008)(66446008)(316002)(91956017)(6506007)(71200400001)(53546011)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlEwSk8zV0lWTGpzcWoydWo2d1NmSDUwYnM1UjVtSnVDZngxV2xOamt5NmxK?=
 =?utf-8?B?SXVvbkttNEw1Ry9sRVpiTVFkSFZSYnpjTVMxcmVBb1NzMENRdWlUQ0tDWERq?=
 =?utf-8?B?Slc0TUlETGZYT2RNTWszV3o4WnI1VXhZWVBVK3lzdlZTSFQ0K0lnNlcwdWJa?=
 =?utf-8?B?by9XakJyenlCdzJwWXJJcHJQbVdPSWdIN2FHWU1QTEczWlV5Z0dTYWlYM1Ni?=
 =?utf-8?B?N00zVUJOallXMSt5ajYzdFp4S2FySEJoNEJoZzkvMm1HMGN5TDA0UXdVYms5?=
 =?utf-8?B?N1l4eVdtWU5hd05kUXRXYnN0c0ZLMGhrQmFRN0dlTUpSQjRrQk5rRlZ1VmJr?=
 =?utf-8?B?WmhrZUk5ZCtKd2xtTWtmRUs5KzY2ek81dkp5VSt6b1k3b0FnOHNVRWsxK0pQ?=
 =?utf-8?B?ZDBnQStBM3JrNmRBYUNjRGJ6KzJDOUkwUkJSZVUvc0N6Z1pCa3V0dCtqeTZu?=
 =?utf-8?B?ZWRxS3RETlQ4V1BMdm1teEJzdVI5d0Z1dlRWeFlxNGo3QjNwbnpISjlSUzk0?=
 =?utf-8?B?S2VWVzA2YURGM3FIVmZwU2lQK1ZFSXB6a2R1OXZML0h0Zk5iR0d0cS9YT1hw?=
 =?utf-8?B?YUxsRTE4bWxDdzErTlJMQ3Y5cVRobHdYRjZpbzVCdjBIWW0yK0hXQ3IzaGRR?=
 =?utf-8?B?TG14UEorN003RFZ2ZmdLeVRBQ3BCRkNTY2lMVFRVemRSSy9tQmJzNlFvbHZs?=
 =?utf-8?B?M3lWTys3Vnd3UitmZU9aWjQ5RTVNayt0VVprK3EyaFFBRW9VVERGWktMMEU0?=
 =?utf-8?B?SEwyWTRkV1ZYeGdqY2djVGNVQ0ZtTkZNS0dZR2ZqZVN4ZndETGZFT0lUMlRH?=
 =?utf-8?B?eUxKanFHa2ttSmpYRW85b1NNYnVKUVBOQU9nckU1bkJkQ09TRFRrbVdlQ2pD?=
 =?utf-8?B?aDNmQktMa0N5eEIreTk1SmY3d0FXUjRiNFF6eXUxYmg2Sk9lOG9RdE5SSTlD?=
 =?utf-8?B?VWhTWS95cmZvd3Y2dFcraGhZTGhKc0JIemt3Ym9FenZLRUV5UzRpekVnTFZX?=
 =?utf-8?B?U1czMGpWZk16MlYxbjFJWnFpVm1mQWVSeCtwbUFjaTZNNTdwSmFjZjVPTEhj?=
 =?utf-8?B?TnROeExBSnVzdE1MSHJmT21sMnRRMEdhV1hYdXNNL3BQMSsxSm1MYW1SUndi?=
 =?utf-8?B?L3c1TVp2Q3VQMmtQRUxjRllGODVySHhmMGZ1bGdkVnFUa0NKQUJBc1JUZStC?=
 =?utf-8?B?WjFoU1hpTEhkNU5PUkJNWkR2OUdOaTJ6WXlLTXZLYVlRWkExSFY0dENPWGUw?=
 =?utf-8?B?dmJWdzYyUXIzSUlDd0R0OENsRXJEbE9BUlF0NUMrWlBlM0VzR0w4UXlqY2d6?=
 =?utf-8?B?aVBQQ1Z5ZjhwSDJHMFc4aXNkenJLWXNha1RYOXJydnBYVDZpM2NieitXOGhD?=
 =?utf-8?B?bzJZaE96L2tCaERGQUFsMVk2d2ZCRGx6M29xN1J6T3hOV0NQZXR3VUxsckln?=
 =?utf-8?B?UEVPcjQyNVM0UnkxMXFqUVJ6TVIxUWY3TXVoc2k4Q0QxQStGck1pMEVWbU15?=
 =?utf-8?B?OWloQUt5SVk0NTVUbk9uL0p0NDFGSkx6YkVsK1dkWVMxMDRqY2JQMjFsNUxj?=
 =?utf-8?B?NVNhenFSQ3orNEVjcGROc3NkNVNxS0lSSlFyYTJtWjRjaDJaZ3JjVjc2UURU?=
 =?utf-8?B?MjZzQ1g0N0dqSEtWVndkT25EQ04ydFVzTS9tTnQyNTJzbDVERmF3OGtBQWg2?=
 =?utf-8?B?NzY3SnRQN2tnVlh5TEtwdWJidkMzQUpHZU5sUEJkSktoaDhOOFUzWDVVZ1g1?=
 =?utf-8?B?aHhyTDJLU05tNGpjZmI4Rk1YdmJ4UnNQQktjc0RKbDgxYTErVXRhV0hLckdF?=
 =?utf-8?B?T1NoV2l4MnpSUXdSNWozWGExMlRJK2FiK1pMcjFvOFN6ckhiSGRVY0pseVY4?=
 =?utf-8?B?azMrY3lXUm0rbmRtOFdNcHJsZVdBck8rSm1wKzkxTHdHb1hXMzBER3JIWFE5?=
 =?utf-8?B?Zko0UVdRZHNiMnpYVE5raGxtOFlkcXpTMTI3cTdzNTlDRVNMM2ZkQVZoekdU?=
 =?utf-8?B?bXpGem5yN3FxZGgvR25jeDd1bUdzRmtXRWpQckFyUzBzRm1hTWFhRU9qQXN5?=
 =?utf-8?B?WWhBWHRjVStVU24rbm1WeGVDYUtvWWtsTkp3a3BqN3pVaWlVRW00bTZEWTNG?=
 =?utf-8?B?RGRhNzZMYlBMUDFVU3owYWhaVU1qR1crd2ZMQnBqWUdLK082dTFNZU1zaGc0?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9C44FC4404CD546A7730B01079F67A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541909a5-126d-4507-8113-08dbe676140f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:31:41.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHmKZ4gIoAau4CjCGFUchuyfhv1sGNAtm2FE03maRPWqCkkkIaoeN8AQlbGhJqUeVxPTH9CYIksoahy2+EAttA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpbmNlbnQsDQoNClJlYWxseSBhcHByZWNpYXRlIHlvdXIgY29tbWVudHMgb24gdGhpcy4N
Cg0KT24gV2VkLCAyMDIzLTExLTE1IGF0IDIxOjAxICswMTAwLCBWaW5jZW50IEd1aXR0b3Qgd3Jv
dGU6DQo+IEhpIFJ1aSwNCj4gDQo+IE9uIFdlZCwgMjAgU2VwdCAyMDIzIGF0IDA5OjI0LCBaaGFu
ZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBIaSwgUGll
cnJlLA0KPiA+IA0KPiA+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZS4gSSdtIHN0aWxsIHJh
bXBpbmcgdXAgb24gdGhlIHJlbGF0ZWQNCj4gPiBjb2RlLg0KPiA+IA0KPiA+IE9uIFRodSwgMjAy
My0wOS0xNCBhdCAxNjo1MyArMDIwMCwgUGllcnJlIEdvbmRvaXMgd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gT24gOS8xNC8yMyAxMToyMywgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiA+ID4g
SGksIFBpZXJyZSwNCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWWVzIHJpZ2h0IGlu
ZGVlZCwNCj4gPiA+ID4gPiBUaGlzIGhhcHBlbnMgd2hlbiBwdXR0aW5nIGEgQ1BVIG9mZmxpbmUg
KGFzIHlvdSBtZW50aW9uZWQNCj4gPiA+ID4gPiBlYXJsaWVyLA0KPiA+ID4gPiA+IHB1dHRpbmcg
YSBDUFUgb2ZmbGluZSBjbGVhcnMgdGhlIENQVSBpbiB0aGUgaWRsZV9jcHVzX21hc2spLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBsb2FkIGJhbGFuY2luZyByZWxhdGVkIHZhcmlhYmxlcw0K
PiA+ID4gPiANCj4gPiA+ID4gaW5jbHVkaW5nPw0KPiA+ID4gDQo+ID4gPiBJIG1lYW50IHRoZSBu
b2h6IGlkbGUgdmFyaWFibGVzIGluIHRoZSBsb2FkIGJhbGFuY2luZywgc28gSSB3YXMNCj4gPiA+
IHJlZmVycmluZyB0bzoNCj4gPiA+IChzdHJ1Y3Qgc2NoZWRfZG9tYWluX3NoYXJlZCkubnJfYnVz
eV9jcHVzDQo+ID4gPiAoc3RydWN0IHNjaGVkX2RvbWFpbikubm9oel9pZGxlDQo+ID4gPiBub2h6
LmlkbGVfY3B1c19tYXNrDQo+ID4gPiBub2h6Lm5yX2NwdXMNCj4gPiA+IChzdHJ1Y3QgcnEpLm5v
aHpfdGlja19zdG9wcGVkDQo+ID4gDQo+ID4gSU1PLCB0aGUgcHJvYmxlbSBpcyB0aGF0LCBmb3Ig
YW4gaXNvbGF0ZWQgQ1BVLA0KPiA+IDEuIGl0IGlzIG5vdCBhbiBpZGxlIGNwdSAobm9oei5pZGxl
X2NwdXNfbWFzayBzaG91bGQgYmUgY2xlYXJlZCkNCj4gPiAyLiBpdCBpcyBub3QgYSBidXN5IGNw
dSAoc2RzLT5ucl9idXN5X2NwdXMgc2hvdWxkIGJlIGRlY3JlYXNlZCkNCj4gPiANCj4gPiBCdXQg
Y3VycmVudCBjb2RlIGRvZXMgbm90IGhhdmUgYSB0aGlyZCBzdGF0ZSB0byBkZXNjcmliZSB0aGlz
LCBzbw0KPiA+IHdlDQo+ID4gbmVlZCB0byBlaXRoZXINCj4gPiAxLiBhZGQgZXh0cmEgbG9naWMs
IGxpa2Ugb25fbnVsbF9kb21haW4oKSBjaGVja3MNCj4gPiBvcg0KPiA+IDIuIHJlbHkgb24gY3Vy
cmVudCBsb2dpYywgYnV0IHVwZGF0ZSBhbGwgcmVsYXRlZCB2YXJpYWJsZXMNCj4gPiBjb3JyZWN0
bHksDQo+ID4gbGlrZSB5b3UgcHJvcG9zZWQuDQo+IA0KPiBJc24ndCB0aGUgaG91c2VrZWVwaW5n
IGNwdSBtYXNrIHRoZXJlIHRvIG1hbmFnZSBzdWNoIGEgY2FzZSA/DQoNClRoaXMgaXMgdHJ1ZSBm
b3IgaXNvbGF0ZWQgQ1BVcyB1c2luZyBib290IG9wdGlvbiAibm9oel9mdWxsPSIuDQoNCkJ1dCBm
b3IgQ1BVcyBpbiB0aGUgY2dyb3VwIGlzb2xhdGVkIHBhcnRpdGlvbiwgdGhlIGhvdXNla2VlcGlu
ZyBjcHVtYXNrDQppcyBub3QgdXBkYXRlZC4NCg0KSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgaW50
ZW5kZWQgb3Igbm90Lg0KDQo+ICBJIHdhcw0KPiBleHBlY3RpbmcgdGhhdCB5b3VyIGlzb2xhdGVk
IGNwdSBzaG91bGQgYmUgY2xlYXJlZCBmcm9tIHRoZQ0KPiBob3VzZWtlZXBpbmcgY3B1bWFzayB1
c2VkIGJ5IHNjaGVkdWxlciBhbmQgSUxCDQoNClRoaXMgcGF0Y2ggaXMgYSBkaXJlY3QgZml4IHdo
ZW4gSSBmb3VuZCB0aGUgaXNvbGF0ZWQgQ1BVcyBhcmUgd29rZSB1cA0KYnkgdGhpcyBwaWVjZSBv
ZiBjb2RlLg0KDQo+IA0KPiBJIHRoaW5rIHRoYXQgeW91ciBzb2x1dGlvbiBpcyB0aGUgY29tbWVu
dCBvZiB0aGUgZmZpbmRfbmV3X2lsYigpDQo+IHVuY3Rpb246DQo+ICINCj4gwqAqIC0gSEtfVFlQ
RV9NSVNDIENQVXMgYXJlIHVzZWQgZm9yIHRoaXMgdGFzaywgYmVjYXVzZSBIS19UWVBFX1NDSEVE
DQo+IGlzIG5vdCBzZXQNCj4gwqAqwqDCoCBhbnl3aGVyZSB5ZXQuDQo+ICINCj4gDQo+IElNTywg
eW91IHNob3VsZCBsb29rIGF0IGVuYWJsaW5nIGFuZCB1c2luZyB0aGUgSEtfVFlQRV9TQ0hFRCBm
b3INCj4gaXNvbGF0ZWQgQ1BVDQoNCnllYWgsIHRoaXMgc2VlbXMgcmVhc29uYWJsZS4NCg0KSSdt
IG5ldyB0byBjZ3JvdXAgYW5kIEknbSBub3Qgc3VyZSB3aGF0IHNob3VsZCBiZSB0aGUgcHJvcGVy
IGJlaGF2aW9yDQpmb3IgQ1BVcyBpbiBpc29sYXRlZCBwYXJ0aXRpb24uDQoNCj4gDQo+IENDZWQg
RnJlZGVyaWMgdG8gZ2V0IGhpcyBvcGluaW9uDQoNClRoYW5rcy4NCg0KLXJ1aQ0KDQoNCj4gDQo+
ID4gQnV0IGluIGFueSBjYXNlLCB3ZSBzaG91bGQgc3RpY2sgd2l0aCBvbmUgZGlyZWN0aW9uLg0K
PiA+IA0KPiA+IElmIHdlIGZvbGxvdyB0aGUgZmlyc3Qgb25lLCB0aGUgb3JpZ2luYWwgcGF0Y2gg
c2hvdWxkIGJlIHVzZWQsDQo+ID4gd2hpY2gNCj4gPiBJTU8gaXMgc2ltcGxlIGFuZCBzdHJhaWdo
dCBmb3J3YXJkLg0KPiA+IElmIHdlIGZvbGxvdyB0aGUgbGF0ZXIgb25lLCB3ZSdkIGJldHRlciBh
dWRpdCBhbmQgcmVtb3ZlIHRoZQ0KPiA+IGN1cnJlbnQNCj4gPiBvbl9udWxsX2RvbWFpbigpIHVz
YWdlIGF0IHRoZSBzYW1lIHRpbWUuIFRCSCwgSSdtIG5vdCBjb25maWRlbnQNCj4gPiBlbm91Z2gN
Cj4gPiB0byBtYWtlIHN1Y2ggYSBjaGFuZ2UuIEJ1dCBpZiB5b3Ugd2FudCB0byBwcm9wb3NlIHNv
bWV0aGluZywgSSdkDQo+ID4gZ2xhZA0KPiA+IHRvIHRlc3QgaXQuDQo+ID4gDQo+ID4gdGhhbmtz
LA0KPiA+IHJ1aQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IMKgIGFyZSB1bnVz
ZWQgaWYgYSBDUFUgaGFzIGEgTlVMTA0KPiA+ID4gPiA+IHJxIGFzIGl0IGNhbm5vdCBwdWxsIGFu
eSB0YXNrLiBJZGVhbGx5IHdlIHNob3VsZCBjbGVhciB0aGVtDQo+ID4gPiA+ID4gb25jZSwNCj4g
PiA+ID4gPiB3aGVuIGF0dGFjaGluZyBhIE5VTEwgc2QgdG8gdGhlIENQVS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoaXMgc291bmRzIGdvb2QgdG8gbWUuIEJ1dCBUQkgsIEkgZG9uJ3QgaGF2ZSBlbm91
Z2ggY29uZmlkZW5jZQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiBkbw0KPiA+ID4gPiBzbyBiZWNhdXNl
IEknbSBub3QgY3J5c3RhbCBjbGVhciBhYm91dCBob3cgdGhlc2UgdmFyaWFibGVzIGFyZQ0KPiA+
ID4gPiB1c2VkLg0KPiA+ID4gPiANCj4gPiA+ID4gU29tZSBxdWVzdGlvbnMgYWJvdXQgdGhlIGNv
ZGUgYmVsb3cuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIGZvbGxvd2luZyBzbmlwcGVkIHNo
b3VsZCBkbyB0aGF0IGFuZCBzb2x2ZSB0aGUgaXNzdWUgeW91DQo+ID4gPiA+ID4gbWVudGlvbmVk
Og0KPiA+ID4gPiA+IC0tLSBzbmlwIC0tLQ0KPiA+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
c2NoZWQvbm9oei5oDQo+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC9ub2h6LmgN
Cj4gPiA+ID4gPiBAQCAtOSw4ICs5LDEwIEBADQo+ID4gPiA+ID4gwqDCoCAjaWYgZGVmaW5lZChD
T05GSUdfU01QKSAmJiBkZWZpbmVkKENPTkZJR19OT19IWl9DT01NT04pDQo+ID4gPiA+ID4gwqDC
oCBleHRlcm4gdm9pZCBub2h6X2JhbGFuY2VfZW50ZXJfaWRsZShpbnQgY3B1KTsNCj4gPiA+ID4g
PiDCoMKgIGV4dGVybiBpbnQgZ2V0X25vaHpfdGltZXJfdGFyZ2V0KHZvaWQpOw0KPiA+ID4gPiA+
ICtleHRlcm4gdm9pZCBub2h6X2NsZWFuX3NkX3N0YXRlKGludCBjcHUpOw0KPiA+ID4gPiA+IMKg
wqAgI2Vsc2UNCj4gPiA+ID4gPiDCoMKgIHN0YXRpYyBpbmxpbmUgdm9pZCBub2h6X2JhbGFuY2Vf
ZW50ZXJfaWRsZShpbnQgY3B1KSB7IH0NCj4gPiA+ID4gPiArc3RhdGljIGlubGluZSB2b2lkIG5v
aHpfY2xlYW5fc2Rfc3RhdGUoaW50IGNwdSkgeyB9DQo+ID4gPiA+ID4gwqDCoCAjZW5kaWYNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiDCoMKgICNpZmRlZiBDT05GSUdfTk9fSFpfQ09NTU9ODQo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFp
ci5jDQo+ID4gPiA+ID4gaW5kZXggYjNlMjViZTU4ZTJiLi42ZmNhYmU1ZDA4ZjUgMTAwNjQ0DQo+
ID4gPiA+ID4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+ID4gPiA+ICsrKyBiL2tlcm5l
bC9zY2hlZC9mYWlyLmMNCj4gPiA+ID4gPiBAQCAtMTE1MjUsNiArMTE1MjUsOSBAQCB2b2lkIG5v
aHpfYmFsYW5jZV9leGl0X2lkbGUoc3RydWN0IHJxDQo+ID4gPiA+ID4gKnJxKQ0KPiA+ID4gPiA+
IMKgwqAgew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBTQ0hFRF9XQVJOX09OKHJxICE9
IHRoaXNfcnEoKSk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAob25f
bnVsbF9kb21haW4ocnEpKQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChs
aWtlbHkoIXJxLT5ub2h6X3RpY2tfc3RvcHBlZCkpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gDQo+ID4gPiA+IGlmIHdlIGZv
cmNlIGNsZWFyaW5nIHJxLT5ub2h6X3RpY2tfc3RvcHBlZCB3aGVuIGRldGFjaGluZw0KPiA+ID4g
PiBkb21haW4sDQo+ID4gPiA+IHdoeQ0KPiA+ID4gPiBib3RoZXIgYWRkaW5nIHRoZSBmaXJzdCBj
aGVjaz8NCj4gPiA+IA0KPiA+ID4gWWVzIHlvdSdyZSByaWdodC4gSSBhZGRlZCB0aGlzIGNoZWNr
IGZvciBzYWZldHksIGJ1dCB0aGlzIGlzIG5vdA0KPiA+ID4gbWFuZGF0b3J5Lg0KPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEBAIC0xMTU1MSw2ICsxMTU1NCwxNyBAQCBz
dGF0aWMgdm9pZA0KPiA+ID4gPiA+IHNldF9jcHVfc2Rfc3RhdGVfaWRsZShpbnQNCj4gPiA+ID4g
PiBjcHUpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHJjdV9yZWFkX3VubG9jaygpOw0K
PiA+ID4gPiA+IMKgwqAgfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICt2b2lkIG5vaHpfY2xlYW5f
c2Rfc3RhdGUoaW50IGNwdSkgew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHJxICpy
cSA9IGNwdV9ycShjcHUpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHJx
LT5ub2h6X3RpY2tfc3RvcHBlZCA9IDA7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoY3B1
bWFza190ZXN0X2NwdShjcHUsIG5vaHouaWRsZV9jcHVzX21hc2spKSB7DQo+ID4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1bWFza19jbGVhcl9jcHUoY3B1LCBub2h6Lmlk
bGVfY3B1c19tYXNrKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
dG9taWNfZGVjKCZub2h6Lm5yX2NwdXMpOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+
ID4gPiA+ICvCoMKgwqDCoMKgwqAgc2V0X2NwdV9zZF9zdGF0ZV9pZGxlKGNwdSk7DQo+ID4gPiA+
ID4gK30NCj4gPiA+ID4gPiArDQo+ID4gPiA+IA0KPiA+ID4gPiBkZXRhY2hfZGVzdHJveV9kb21h
aW5zDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGNwdV9hdHRhY2hfZG9tYWluDQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cGRhdGVfdG9wX2NhY2hlX2RvbWFpbg0KPiA+
ID4gPiANCj4gPiA+ID4gYXMgd2UgY2xlYXJzIHBlcl9jcHUoc2RfbGxjLCBjcHUpIGZvciB0aGUg
aXNvbGF0ZWQgY3B1IGluDQo+ID4gPiA+IGNwdV9hdHRhY2hfZG9tYWluKCksIHNldF9jcHVfc2Rf
c3RhdGVfaWRsZSgpIHNlZW1zIHRvIGJlIGEgbm8tDQo+ID4gPiA+IG9wDQo+ID4gPiA+IGhlcmUs
DQo+ID4gPiA+IG5vPw0KPiA+ID4gDQo+ID4gPiBZZXMgeW91J3JlIHJpZ2h0LCBjcHVfYXR0YWNo
X2RvbWFpbigpIGFuZCBub2h6X2NsZWFuX3NkX3N0YXRlKCkNCj4gPiA+IGNhbGxzDQo+ID4gPiBo
YXZlIHRvIGJlIGludmVydGVkIHRvIGF2b2lkIHdoYXQgeW91IGp1c3QgZGVzY3JpYmVkLg0KPiA+
ID4gDQo+ID4gPiBJdCBhbHNvIHNlZW1zIHRoYXQgdGhlIGN1cnJlbnQga2VybmVsIGRvZXNuJ3Qg
ZGVjcmVhc2UNCj4gPiA+IG5yX2J1c3lfY3B1cw0KPiA+ID4gd2hlbiBwdXR0aW5nIENQVXMgaW4g
YW4gaXNvbGF0ZWQgcGFydGl0aW9uLiBJbmRlZWQgaWYgYSBDUFUgaXMNCj4gPiA+IGNvdW50ZWQN
Cj4gPiA+IGluIG5yX2J1c3lfY3B1cywgcHV0dGluZyB0aGUgQ1BVIGluIGFuIGlzb2xhdGVkIHBh
cnRpdGlvbiBkb2Vzbid0DQo+ID4gPiB0cmlnZ2VyDQo+ID4gPiBhbnkgY2FsbCB0byBzZXRfY3B1
X3NkX3N0YXRlX2lkbGUoKS4NCj4gPiA+IFNvIGl0IG1pZ2h0IGFuIGFkZGl0aW9uYWwgYXJndW1l
bnQuDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBmb3IgcmVhZGluZyB0aGUgcGF0Y2gsDQo+ID4gPiBS
ZWdhcmRzLA0KPiA+ID4gUGllcnJlDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IHRoYW5rcywN
Cj4gPiA+ID4gcnVpDQo+ID4gPiA+ID4gwqDCoCAvKg0KPiA+ID4gPiA+IMKgwqDCoCAqIFRoaXMg
cm91dGluZSB3aWxsIHJlY29yZCB0aGF0IHRoZSBDUFUgaXMgZ29pbmcgaWRsZQ0KPiA+ID4gPiA+
IHdpdGgNCj4gPiA+ID4gPiB0aWNrDQo+ID4gPiA+ID4gc3RvcHBlZC4NCj4gPiA+ID4gPiDCoMKg
wqAgKiBUaGlzIGluZm8gd2lsbCBiZSB1c2VkIGluIHBlcmZvcm1pbmcgaWRsZSBsb2FkDQo+ID4g
PiA+ID4gYmFsYW5jaW5nIGluDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gZnV0dXJlLg0KPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiA+ID4gPiA+IGIv
a2VybmVsL3NjaGVkL3RvcG9sb2d5LmMNCj4gPiA+ID4gPiBpbmRleCBkM2EzYjI2NDZlYzQuLmQz
MTEzN2I1ZjBjZSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3ku
Yw0KPiA+ID4gPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC90b3BvbG9neS5jDQo+ID4gPiA+ID4gQEAg
LTI1ODQsOCArMjU4NCwxMCBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gPiA+IGRldGFjaF9kZXN0cm95
X2RvbWFpbnMoY29uc3QNCj4gPiA+ID4gPiBzdHJ1Y3QgY3B1bWFzayAqY3B1X21hcCkNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBzdGF0aWNfYnJhbmNoX2RlY19jcHVzbG9ja2VkKCZzY2hlZF9hc3lt
X2NwdWNhcGFjaXR5KTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmN1X3JlYWRfbG9jaygpOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfY3B1KGks
IGNwdV9tYXApDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBmb3JfZWFjaF9jcHUoaSwgY3B1X21h
cCkgew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X2F0
dGFjaF9kb21haW4oTlVMTCwgJmRlZl9yb290X2RvbWFpbiwNCj4gPiA+ID4gPiBpKTsNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub2h6X2NsZWFuX3NkX3N0YXRlKGkp
Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCByY3VfcmVhZF91bmxvY2soKTsNCj4gPiA+ID4gPiDCoMKgIH0NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiAtLS0gc25pcCAtLS0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4g
PiA+IFBpZXJyZQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBUaGUgdGljayBpcyBzdGlsbCBzdG9wcGVkIGJ1dCBsb2FkIGNvdWxk
DQo+ID4gPiA+ID4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiA+ID4gPiA+IGJlZW4NCj4gPiA+ID4gPiA+
ID4gPiBhZGRlZCBpbiB0aGUNCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogbWVhbnRpbWUuIFdlIHNldCB0aGUgbm9oei5oYXNfYmxvY2tlZA0KPiA+ID4gPiA+ID4gPiA+
IGZsYWcgdG8NCj4gPiA+ID4gPiA+ID4gPiB0cmlnDQo+ID4gPiA+ID4gPiA+ID4gYQ0KPiA+ID4g
PiA+ID4gPiA+IGNoZWNrIG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IEBAIC0xMTU4NSwxMCArMTE2
MDksNiBAQCB2b2lkDQo+ID4gPiA+ID4gPiA+ID4gbm9oel9iYWxhbmNlX2VudGVyX2lkbGUoaW50
DQo+ID4gPiA+ID4gPiA+ID4gY3B1KQ0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChycS0+bm9oel90aWNrX3N0b3BwZWQpDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiA+ID4gPiA+ID4gPiA+IC3C
oMKgwqDCoMKgwqAgLyogSWYgd2UncmUgYSBjb21wbGV0ZWx5IGlzb2xhdGVkIENQVSwgd2UgZG9u
J3QNCj4gPiA+ID4gPiA+ID4gPiBwbGF5Og0KPiA+ID4gPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4g
PiA+ID4gLcKgwqDCoMKgwqDCoCBpZiAob25fbnVsbF9kb21haW4ocnEpKQ0KPiA+ID4gPiA+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiA+ID4gPiA+ID4g
PiAtDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnEtPm5vaHpfdGlja19z
dG9wcGVkID0gMTsNCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVtYXNr
X3NldF9jcHUoY3B1LCBub2h6LmlkbGVfY3B1c19tYXNrKTsNCj4gPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gPiBPdGhlcndpc2UgSSBjb3VsZCByZXByb2R1Y2UgdGhlIGlzc3VlIGFuZCB0
aGUgcGF0Y2ggd2FzDQo+ID4gPiA+ID4gPiA+ID4gc29sdmluZw0KPiA+ID4gPiA+ID4gPiA+IGl0
LA0KPiA+ID4gPiA+ID4gPiA+IHNvOg0KPiA+ID4gPiA+ID4gPiA+IFRlc3RlZC1ieTogUGllcnJl
IEdvbmRvaXMgPHBpZXJyZS5nb25kb2lzQGFybS5jb20+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFRoYW5rcyBmb3IgdGVzdGluZywgcmVhbGx5IGFwcHJlY2lhdGVkIQ0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEFsc28sIHlvdXIgcGF0Y2ggZG9l
c24ndCBhaW0gdG8gc29sdmUgdGhhdCwgYnV0IEkgdGhpbmsNCj4gPiA+ID4gPiA+ID4gPiB0aGVy
ZQ0KPiA+ID4gPiA+ID4gPiA+IGlzIGFuDQo+ID4gPiA+ID4gPiA+ID4gaXNzdWUNCj4gPiA+ID4g
PiA+ID4gPiB3aGVuIHVwZGF0aW5nIGNwdXNldC5jcHVzIHdoZW4gYW4gaXNvbGF0ZWQgcGFydGl0
aW9uDQo+ID4gPiA+ID4gPiA+ID4gd2FzDQo+ID4gPiA+ID4gPiA+ID4gYWxyZWFkeQ0KPiA+ID4g
PiA+ID4gPiA+IGNyZWF0ZWQ6DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gLy8g
Q3JlYXRlIGFuIGlzb2xhdGVkIHBhcnRpdGlvbiBjb250YWluaW5nIENQVTANCj4gPiA+ID4gPiA+
ID4gPiAjIG1rZGlyIGNncm91cA0KPiA+ID4gPiA+ID4gPiA+ICMgbW91bnQgLXQgY2dyb3VwMiBu
b25lIGNncm91cC8NCj4gPiA+ID4gPiA+ID4gPiAjIG1rZGlyIGNncm91cC9UZXN0aW5nDQo+ID4g
PiA+ID4gPiA+ID4gIyBlY2hvICIrY3B1c2V0IiA+IGNncm91cC9jZ3JvdXAuc3VidHJlZV9jb250
cm9sDQo+ID4gPiA+ID4gPiA+ID4gIyBlY2hvICIrY3B1c2V0IiA+DQo+ID4gPiA+ID4gPiA+ID4g
Y2dyb3VwL1Rlc3RpbmcvY2dyb3VwLnN1YnRyZWVfY29udHJvbA0KPiA+ID4gPiA+ID4gPiA+ICMg
ZWNobyAwID4gY2dyb3VwL1Rlc3RpbmcvY3B1c2V0LmNwdXMNCj4gPiA+ID4gPiA+ID4gPiAjIGVj
aG8gaXNvbGF0ZWQgPiBjZ3JvdXAvVGVzdGluZy9jcHVzZXQuY3B1cy5wYXJ0aXRpb24NCj4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiAvLyBDUFUwJ3Mgc2NoZWQgZG9tYWluIGlzIGRl
dGFjaGVkOg0KPiA+ID4gPiA+ID4gPiA+ICMgbHMgL3N5cy9rZXJuZWwvZGVidWcvc2NoZWQvZG9t
YWlucy9jcHUwLw0KPiA+ID4gPiA+ID4gPiA+ICMgbHMgL3N5cy9rZXJuZWwvZGVidWcvc2NoZWQv
ZG9tYWlucy9jcHUxLw0KPiA+ID4gPiA+ID4gPiA+IGRvbWFpbjDCoCBkb21haW4xDQo+ID4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gLy8gQ2hhbmdlIHRoZSBpc29sYXRlZCBwYXJ0aXRp
b24gdG8gYmUgQ1BVMQ0KPiA+ID4gPiA+ID4gPiA+ICMgZWNobyAxID4gY2dyb3VwL1Rlc3Rpbmcv
Y3B1c2V0LmNwdXMNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiAvLyBDUFVbMC0x
XSBzY2hlZCBkb21haW5zIGFyZSBub3QgdXBkYXRlZDoNCj4gPiA+ID4gPiA+ID4gPiAjIGxzIC9z
eXMva2VybmVsL2RlYnVnL3NjaGVkL2RvbWFpbnMvY3B1MC8NCj4gPiA+ID4gPiA+ID4gPiAjIGxz
IC9zeXMva2VybmVsL2RlYnVnL3NjaGVkL2RvbWFpbnMvY3B1MS8NCj4gPiA+ID4gPiA+ID4gPiBk
b21haW4wwqAgZG9tYWluMQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSW50ZXJlc3Rp
bmcuIExldCBtZSBjaGVjayBhbmQgZ2V0IGJhY2sgdG8geW91IGxhdGVyIG9uDQo+ID4gPiA+ID4g
PiB0aGlzLiA6KQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiB0aGFua3MsDQo+ID4gPiA+ID4g
PiBydWkNCj4gPiA+ID4gDQo+ID4gDQoNCg==
