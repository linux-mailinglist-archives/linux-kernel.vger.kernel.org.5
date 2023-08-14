Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33177B42D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjHNIbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjHNIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:30:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB1DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692001842; x=1723537842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ERC/qfKkiJXvClF3SETTnblaG0pfJinsBAvQOE+Fbvg=;
  b=BxKz5Tvy89E7ogUWC10yG2Pc8CXDKLBTUdi5G/84jBPr06RQqhB3Zwv4
   k5oE1ca5zWzrwYjehqXOZzpnY9qCEbTGanAJ36G6yi1e4CyL6lUH8OZlT
   veMQXFeYrds28Cx0DHmCn79E6c2v7Paapq2VuOOBs7t+LRTlxtzWnli7k
   rH6UJKp8pAUGhcudO20pFV++4DncspfqIaaYPb33WD64NqZiFvpW4uijO
   AfdURIuTXFy10Jxo0ZvDHgYtUqq4hqAiWtdsQqy6NNtXx4jsT9FmGCxWY
   h18ZyQeH6G/ScOh+h8798AXarjKiw3TSGM8j+CNIW9gNE7dKe6Eh7M+OD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371992540"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="371992540"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 01:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="726942734"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="726942734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2023 01:30:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 01:30:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhIxg4K88cP4Wep3aakw54jMsJbD271u2rwv6XkplY6bhaX7ixyU2pELv3Ofh50V0dn6X/47JC/lmqiwYao2oruS56I9YP9qTEiUOpuK3z6CCEMMkd7yoJ/nckZQ/ILzxN1f3n/jMBb+DufOxRyheQTjBoWMmBpipfOSItRWfKErH3KW9YAl1i+iWrtXO7bzOJjBZbrDT0ZBLBv73go+f9k6iQWQeaWKHK3FcWCQorsGvYhJIu2dZhGqt+78Hhen1mZEEpwFNJxllZEvD6zINFXht+PrkX9Renoj2nxC1n+kVAyKPto9vN9fr1w5rPuke9k06steBjB0g18aTxsW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERC/qfKkiJXvClF3SETTnblaG0pfJinsBAvQOE+Fbvg=;
 b=aM8Rif0bERILuWWXC9qKcTFURduRn0N6LFW3gBlUkFykYZu3cNepQIcsH2R713oCKG3yCc9axHKbQtROcjeW911MH/1KycAvrbNlXj93aTm8OlWaMZkSIWV/ewQ/SziJYnu1Q8IxSJs+diKByp5ONxP7HOAx2X2HiTVgC1SSsiTDuB4MJH0Ie7j75mEjuiyCK+WYlhAc72ydUADyUAdlV4gqvlAt0Eu0TR7cvb5a+eUARN3uTRoib3hjLuMMvGMNxdIXq+FRGuXORq/P5X0vntTXB29xBEJ5YIxsJftZGcaKd/rxxdSzYANbzJBF/jqSQpPQidxudesSsHQsRXgv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:30:39 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:30:39 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>
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
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/pLXsAgABYUIA=
Date:   Mon, 14 Aug 2023 08:30:39 +0000
Message-ID: <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <20230814031432.GA574314@ziqianlu-dell>
In-Reply-To: <20230814031432.GA574314@ziqianlu-dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7765:EE_
x-ms-office365-filtering-correlation-id: 23ee36f1-308a-4eee-a37d-08db9ca0bd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElrCPQVU4jkXZ9Ydj/31ogNXv6mFwOZegvw4/W5jcfWDJ4uEyNLmAkF9oTBiNL7MZOybqxSKh3avPt6zQ6KaBUGcqg2SSvi9JShgane5HB6BmW3rApZVOUrNdopVPUjTfLK1Kt7QLkeLzfa5aoPaz4pBE9zZ56dLm3EUskOZIeXoTnyxQwI2+H90O7XFuqgOuTL2JpRaxYG3uq7m897DmxW2fgZxyzEnPSpX6hmU4kRPV27SgIyfwVdSx8fakgFT2eoAPKlWqFOtwHg31GXd3lAoyPNeXvrrOX+yXykk3xMfsxdo53jbAT6iFXpnjaYwJu1BoXgcl0eTqcb2z8Ak0116kJxnc2TrPoWePFesPs+P6qm+NBfSASsSxbuxcREQqFlZgqAXr29UCLnGyQSYcNO4KjnGZnvOPVkF6F7j5S1cj/fYjCkyDjEwTCv10pLmv8xYi3leztPNG3Y9jhxzW+Yv/pMywSNg6A2hmiUCPudRKIlglEw6N4n9eLxo+7v625XfIlL0Zqava9nvHeTkFPkoXwVHQGWXfWlkm3stuZ6Vyz/siH4jHGzznfw66I7H+Va/FktunB0HMpcot0/6f/D8IUcoJFrqf1JOu9WwV7oSryggx4aemaZUiY07z5pI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(186006)(1800799006)(71200400001)(6486002)(6506007)(478600001)(76116006)(91956017)(83380400001)(36756003)(86362001)(2906002)(6512007)(26005)(66946007)(2616005)(38100700002)(38070700005)(82960400001)(122000001)(6636002)(4326008)(6862004)(8936002)(8676002)(37006003)(64756008)(66476007)(54906003)(66446008)(66556008)(316002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTdObDF5S2pDUitXS3hvam9rYkNibTF0dnMxTlBqQmZlK1AxN21LaktWTW5k?=
 =?utf-8?B?RGVzajdXMmJFQklZQ3dWWlplcnEvZmdEOTZzaDEwZFg0Ym15T0daSGF0S3Fa?=
 =?utf-8?B?enB3bFFUYmZyeXZhaThTWFBVeENpY2cxcGZZT3hIa2ZTQTg3Yk9oWjJ1WEwx?=
 =?utf-8?B?bVRUY0t5eCtWUGdYeGR1blMxek9ZYndsSDVRMFpoT0p2N3d6QTF0TUp4S1Q0?=
 =?utf-8?B?Y2ExaXBwMU53YWpvRGVmUFBoVUFtaG52RFJGdEMwQ2xxa1llZmFEUGMrQytw?=
 =?utf-8?B?b3VLdmZ5c0kzR2hEWXdyRWZqU1FqVU50cWJOQkxnVUhhUWVrdWZyQ210b0p1?=
 =?utf-8?B?dkJXMmVTTk5na3lONjlGOTVES1VGL3BSODBKSG9iQjJHTjJlRUtueFhiTEc0?=
 =?utf-8?B?Y2IwQlJ1andEY2hpeFNKOXFWZWhKeGkyK1NPTHJRdFl0UzFRdFJmSmdJdnVO?=
 =?utf-8?B?R0VibW5yLys2NDhpR294UUhRN0VOdUhPYjB0aTRqSEdyTndvdERwSkRBN1Vo?=
 =?utf-8?B?TUc5RXJZQ3Mra2poejFxVTVDVXpaL2VHQThmQVVYL3BIQnhIQUtRaDAxVDdi?=
 =?utf-8?B?ZGxHWUpXckR6dHBBVXUrVkQzZFR3N0tsYzU3cVZ3YU1aczRCV2VidDBGaTgw?=
 =?utf-8?B?SXRrWDB0TlJzUFd5bkozd0FwU1dBa3l5T1BVMG8zc0JxVnNtdHRLU2dOaHl3?=
 =?utf-8?B?NUY5QTEwdFNPWU9JSlFFSVhRQlAxMlB0bFRrOVBEdUkyb25UUlVzamh0bHpQ?=
 =?utf-8?B?VE9FeXBqQ3k3K3lVZEVYM3RuWkppYTZjWS85dzNNaldxb0F0a051NTV0dTlY?=
 =?utf-8?B?TDdjR0w4WFk2MG1LNnpXR01lR1hjeEtwVExyQmZCNndwZkJKUW1uU01hTnh4?=
 =?utf-8?B?QWUwQkRaYmZzem51K2JqcXovam13dnZDMEhXeTZnK2NBMlJWUjViU3FFZ1Ir?=
 =?utf-8?B?elBKVGlrei93OXQ2SkNGdEl4Uklwd091Kyt3T0JkaHJFa2Z6aUZFTUl2ZzMx?=
 =?utf-8?B?RytoWHB0SENuK0tMN21xZDdlRWJxWkxkNi9ETFdaOUdxZWl6cUQvZ2JUWEQx?=
 =?utf-8?B?NnhVMk8yeUNhamJqTmMwYlRMSTVZZ2kvbXU0Wk9wT2NIdXVTcEk1ZkVleHFR?=
 =?utf-8?B?aVV5NDI4OVlIZVVJR0N4TDhhY1VDYnpOS0JjSzIwbHZqNVFIZlRxTzRBNDJ6?=
 =?utf-8?B?Zy8zaDFhWkM4S1hLbExaUTlMNWtZN0JUYVl1aDQrY3c2bGVuc3QvaW9KVGU5?=
 =?utf-8?B?SDNHUFhpL294b2ZIdXlNTUQwOWFMcXFmU2UvTjNpR2VDNXpvbzRFYmNKOGFI?=
 =?utf-8?B?a040NHBGSDV5QmdQQzc3N2xFUEZYLzk0R0VDd2lZU0sxdmtwalM3TitDUmFJ?=
 =?utf-8?B?bEtYUExWQTdRNXI4L1BRS2NQR29jNE5EdHBZdlJjeVZiQ0g1MUJMMkVWVjRT?=
 =?utf-8?B?bEoyMVc4Ynk2V25CZVlNbmhxczhhODdYUFQwdjBHTW1uZTZDQVd0dEdFTnZh?=
 =?utf-8?B?OTdVWkRFVHZ3YktZSnJJZE1XZG5UcjRhTUNFd2VrZE45ZlBNRy9LK0UxZCtm?=
 =?utf-8?B?cUtkb1g5SFBtSlN4Q1QrTmN1M0JkSmZZNnRGUTVqZ2hERGs5K3M4eUE0M1ph?=
 =?utf-8?B?bkcyR3ROSEl0T1d4N3ZIUVhXRUlvS1NGV2ZMWDNwM2NFWlhwaHNxQnlhZnBq?=
 =?utf-8?B?N2haNlpRY1BiZjk5aXJ2cHh0U1FmZ0NkS3IzemozU083dFdEKzVuMEM2RVpE?=
 =?utf-8?B?WWxYd1FWQkxGczF1b0R3MW5Ydm05YXJXdWxrSm9DM3BkNE1rNEwxMHlhOVBj?=
 =?utf-8?B?WkNxQlRvN1hoa3NScnF4bnRkTXk3MWVYNlhBTGhpVFBNQjE0Z2NpQ1FTU09Q?=
 =?utf-8?B?UHJKcXFCQnZhVHArUEdQS3g0UmFUdnJnR1RjUDhDKzZPOXAxVHhmOHpmWFkr?=
 =?utf-8?B?L05DUVgzcVZpYmkySWFOQ0JxNzNIQUZYQk45b2o4ckZpTjI1UmhVUEp6UG11?=
 =?utf-8?B?WGhyUkpwU2h6S1VnSjEybnJOQmhrbEc1Y2JhWkJpaEQ5a2N0c1FBQjhKOGE3?=
 =?utf-8?B?QThXcWtIMGtUM2J5UU5lMmZIVlV1ZUJPS2tlRmt1aVBwbGFtUlNySkZodnVF?=
 =?utf-8?Q?hiRUiWyDP4ePJgcvghRPidLug?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D9DCAA918E35B4B96C7717D129B083D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee36f1-308a-4eee-a37d-08db9ca0bd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:30:39.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4hO0q5ux5QrS+1lOuk+EcM7rCA/9c1gdmeN6iJzWZmMcwKV8u/8LZSFY9nudAPcpoh9Y8TmWJ5fU2r9c9ZEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDExOjE0ICswODAwLCBBYXJvbiBMdSB3cm90ZToNCj4gSGkg
UnVpLA0KPiANCj4gT24gRnJpLCBBdWcgMDQsIDIwMjMgYXQgMDU6MDg6NThQTSArMDgwMCwgWmhh
bmcgUnVpIHdyb3RlOg0KPiA+IFByb2JsZW0gc3RhdGVtZW50DQo+ID4gLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiBXaGVuIHVzaW5nIGNncm91cCBpc29sYXRlZCBwYXJ0aXRpb24gdG8gaXNvbGF0ZSBj
cHVzIGluY2x1ZGluZw0KPiA+IGNwdTAsIGl0DQo+ID4gaXMgb2JzZXJ2ZWQgdGhhdCBjcHUwIGlz
IHdva2VuIHVwIGZyZXF1ZW5jdGx5IGJ1dCBkb2luZyBub3RoaW5nLg0KPiA+IFRoaXMgaXMNCj4g
PiBub3QgZ29vZCBmb3IgcG93ZXIgZWZmaWNpZW5jeS4NCj4gPiANCj4gPiA8aWRsZT4tMMKgwqDC
oMKgIFswMDBdwqDCoCA2MTYuNDkxNjAyOiBocnRpbWVyX2NhbmNlbDrCoMKgwqDCoMKgwqANCj4g
PiBocnRpbWVyPTB4ZmZmZjhlOGZkZjYyM2MxMA0KPiA+IDxpZGxlPi0wwqDCoMKgwqAgWzAwMF3C
oMKgIDYxNi40OTE2MDg6IGhydGltZXJfc3RhcnQ6wqDCoMKgwqDCoMKgwqANCj4gPiBocnRpbWVy
PTB4ZmZmZjhlOGZkZjYyM2MxMCBmdW5jdGlvbj10aWNrX3NjaGVkX3RpbWVyLzB4MA0KPiA+IGV4
cGlyZXM9NjE1OTk2MDAwMDAwIHNvZnRleHBpcmVzPTYxNTk5NjAwMDAwMA0KPiA+IDxpZGxlPi0w
wqDCoMKgwqAgWzAwMF3CoMKgIDYxNi40OTE2MTY6IHJjdV91dGlsaXphdGlvbjrCoMKgwqDCoMKg
IFN0YXJ0DQo+ID4gY29udGV4dCBzd2l0Y2gNCj4gPiA8aWRsZT4tMMKgwqDCoMKgIFswMDBdwqDC
oCA2MTYuNDkxNjE4OiByY3VfdXRpbGl6YXRpb246wqDCoMKgwqDCoCBFbmQgY29udGV4dA0KPiA+
IHN3aXRjaA0KPiA+IDxpZGxlPi0wwqDCoMKgwqAgWzAwMF3CoMKgIDYxNi40OTE2Mzc6IHRpY2tf
c3RvcDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN1Y2Nlc3M9MQ0KPiA+IGRlcGVuZGVuY3k9Tk9O
RQ0KPiA+IDxpZGxlPi0wwqDCoMKgwqAgWzAwMF3CoMKgIDYxNi40OTE2Mzc6IGhydGltZXJfY2Fu
Y2VsOsKgwqDCoMKgwqDCoA0KPiA+IGhydGltZXI9MHhmZmZmOGU4ZmRmNjIzYzEwDQo+ID4gPGlk
bGU+LTDCoMKgwqDCoCBbMDAwXcKgwqAgNjE2LjQ5MTYzODogaHJ0aW1lcl9zdGFydDrCoMKgwqDC
oMKgwqDCoA0KPiA+IGhydGltZXI9MHhmZmZmOGU4ZmRmNjIzYzEwIGZ1bmN0aW9uPXRpY2tfc2No
ZWRfdGltZXIvMHgwDQo+ID4gZXhwaXJlcz02MTY0MjAwMDAwMDAgc29mdGV4cGlyZXM9NjE2NDIw
MDAwMDAwDQo+ID4gDQo+ID4gVGhlIGFib3ZlIHBhdHRlcm4gcmVwZWF0cyBldmVyeSBvbmUgb3Ig
bXVsdGlwbGUgdGlja3MsIHJlc3VsdHMgaW4NCj4gPiB0b3RhbA0KPiA+IDIwMDArIHdha2V1cHMg
b24gY3B1MCBpbiA2MCBzZWNvbmRzLCB3aGVuIHJ1bm5pbmcgd29ya2xvYWQgb24gdGhlDQo+ID4g
Y3B1cyB0aGF0IGFyZSBub3QgaW4gdGhlIGlzb2xhdGVkIHBhcnRpdGlvbi4NCj4gPiANCj4gPiBS
b290Y2F1c2UNCj4gPiAtLS0tLS0tLS0NCj4gPiBJbiBOT0haIG1vZGUsIGFuIGFjdGl2ZSBjcHUg
ZWl0aGVyIHNlbmRzIGFuIElQSSBvciB0b3VjaGVzIHRoZSBpZGxlDQo+ID4gY3B1J3MgcG9sbGlu
ZyBmbGFnIHRvIHdha2UgaXQgdXAsIHNvIHRoYXQgdGhlIGlkbGUgY3B1IGNhbiBwdWxsDQo+ID4g
dGFza3MNCj4gPiBmcm9tIHRoZSBidXN5IGNwdS4gVGhlIGxvZ2ljIGZvciBzZWxlY3RpbmcgdGhl
IHRhcmdldCBjcHUgaXMgdG8gdXNlDQo+ID4gdGhlDQo+ID4gZmlyc3QgaWRsZSBjcHUgdGhhdCBw
cmVzZW50cyBpbiBib3RoIG5vaHouaWRsZV9jcHVzX21hc2sgYW5kDQo+ID4gaG91c2VrZWVwaW5n
X2NwdW1hc2suDQo+ID4gDQo+ID4gSW4gdGhlIGFib3ZlIHNjZW5hcmlvLCB3aGVuIGNwdTAgaXMg
aW4gdGhlIGNncm91cCBpc29sYXRlZA0KPiA+IHBhcnRpdGlvbiwNCj4gPiBpdHMgc2NoZWQgZG9t
YWluIGlzIGRldGVjaGVkLCBidXQgaXQgaXMgc3RpbGwgYXZhaWxhYmxlIGluIGJvdGggb2YNCj4g
PiB0aGUNCj4gPiBhYm92ZSBjcHVtYXNrcy4gQXMgYSByZXN1bHQsIGNwdTANCj4gDQo+IEkgc2F3
IGluIG5vaHpfYmFsYW5jZV9lbnRlcl9pZGxlKCksIGlmIGEgY3B1IGlzIGlzb2xhdGVkLCBpdCB3
aWxsIG5vdA0KPiBzZXQgaXRzZWxmIGluIG5vaHouaWRsZV9jcHVzX21hc2sgYW5kIHRodXMgc2hv
dWxkIG5vdCBiZSBjaG9zZW4gYXMNCj4gaWxiX2NwdS4gSSB3b25kZXIgd2hhdCdzIHN0b3BwaW5n
IHRoaXMgZnJvbSB3b3JraW5nPw0KDQpPbmUgdGhpbmcgSSBmb3Jnb3QgdG8gbWVudGlvbiBpcyB0
aGF0IHRoZSBwcm9ibGVtIGlzIGdvbmUgaWYgd2Ugb2ZmbGluZQ0KYW5kIHJlLW9ubGluZSB0aG9z
ZSBjcHVzLiBJbiB0aGF0IGNhc2UsIHRoZSBpc29sYXRlZCBjcHVzIGFyZcKgcmVtb3ZlZA0KZnJv
bSB0aGUgbm9oei5pZGxlX2NwdXNfbWFzayBpbiBzY2hlZF9jcHVfZGVhY3RpdmF0ZSgpIGFuZCBh
cmUgbmV2ZXINCmFkZGVkIGJhY2suDQoNCkF0IHJ1bnRpbWUsIHRoZSBjcHVzIGNhbiBiZSByZW1v
dmVkIGZyb20gdGhlIG5vaHouaWRsZV9jcHVzX21hc2sgaW4NCmJlbG93IGNhc2Ugb25seQ0KCXRy
aWdnZXJfbG9hZF9iYWxhbmNlKCkNCgkgICAgICAgIGlmICh1bmxpa2VseShvbl9udWxsX2RvbWFp
bihycSkgfHwgIWNwdV9hY3RpdmUoY3B1X29mKHJxKSkpKQ0KCSAgICAgICAgICAgICAgICByZXR1
cm47DQoJICAgICAgICBub2h6X2JhbGFuY2VyX2tpY2socnEpOw0KCQkJbm9oel9iYWxhbmNlX2V4
aXRfaWRsZSgpDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpZiBhIGNwdSBpcyBpbiBub2h6
LmlkbGVfY3B1c19tYXNrIHdoZW4gaXQgaXMNCmlzb2xhdGVkLCB0aGVyZSBpcyBubyBjaGFuY2Ug
dG8gcmVtb3ZlIGl0IGZyb20gdGhhdCBtYXNrIGxhdGVyLCBzbyB0aGUNCmNoZWNrIGluIG5vaHpf
YmFsYW5jZV9lbnRlcl9pZGxlKCkgZG9lcyBub3QgaGVscC4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K
PiANCj4gPiAxLiBpcyBhbHdheXMgc2VsZWN0ZWQgd2hlbiBraWNraW5nIGlkbGUgbG9hZCBiYWxh
bmNlDQo+ID4gMi4gaXMgd29rZW4gdXAgZnJvbSB0aGUgaWRsZSBsb29wDQo+ID4gMy4gY2FsbHMg
X19zY2hlZHVsZSgpIGJ1dCBjYW5ub3QgZmluZCBhbnkgdGFzayB0byBwdWxsIGJlY2F1c2UgaXQN
Cj4gPiBpcyBub3QNCj4gPiDCoMKgIGluIGFueSBzY2hlZF9kb21haW4sIHRodXMgaXQgZG9lcyBu
b3RoaW5nIGFuZCByZWVudGVycyBpZGxlLg0KPiA+IA0KPiA+IFNvbHV0aW9uDQo+ID4gLS0tLS0t
LS0NCj4gPiBGaXggdGhlIHByb2JsZW0gYnkgc2tpcHBpbmcgY3B1cyB3aXRoIG5vIHNjaGVkIGRv
bWFpbiBhdHRhY2hlZA0KPiA+IGR1cmluZw0KPiA+IE5PSFogaWRsZSBiYWxhbmNlLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiDCoGtlcm5lbC9zY2hlZC9mYWlyLmMgfCAzICsrKw0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQv
ZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+IGluZGV4IGIzZTI1YmU1OGUyYi4uZWEz
MTg1YTQ2OTYyIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiArKysg
Yi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gQEAgLTExMzQwLDYgKzExMzQwLDkgQEAgc3RhdGlj
IGlubGluZSBpbnQgZmluZF9uZXdfaWxiKHZvaWQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAoaWxiID09IHNtcF9wcm9jZXNzb3JfaWQoKSkNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsNCj4gPiDCoA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHkob25fbnVsbF9k
b21haW4oY3B1X3JxKGlsYikpKSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOw0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChpZGxlX2NwdShpbGIpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBpbGI7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoH0NCj4gPiAtLSANCj4gPiAyLjM0LjENCj4gPiANCg0K
