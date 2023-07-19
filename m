Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2147589F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGSAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGSAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:12:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151B121;
        Tue, 18 Jul 2023 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689725525; x=1721261525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x85A4IVhvxutMPESG5bbtPNOJ/18BBoMq9Ehwvsc4G4=;
  b=QDEfPqHMKFWp+BGBbJhqjIKO6gExtLGpIrRVOxdI1BhsmGBzx+jxGJIT
   LhamblNz8UnGi3yfgcD+j10UJ4A8vkR0DFa/c1L5krWdqNpTpHxR3DRNr
   A94KXWY7gBNKYcL1NllxG0Gs1ePRLip9ys7TDoNafm8XOWX5imWzo7h14
   xieHoLxEwccdsCCwcjwJZcnBtqCMJIfhiDRukPZCNoTr64PM45k9VYo/5
   XKhSXc8y2e7SIl5su+daAfb1EeoVtVt2R2eRwD8E4bFoiRHPcboeTvxp6
   VohrIu3gL6FoCHGFQoxSjOPCs/2FO+batxOVfi0POn1JaYldEzcdHrqED
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366383191"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="366383191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897726544"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="897726544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2023 17:12:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 17:12:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 17:12:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 17:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WesFBpLWNj31rBDB8jbn8zPv3MOePkQ3ldbp+8Ye3nj2fHS6QffcEa8RwIvnnQkRrAQsJTTJgSTSPygeqlT8nGFTn1a+TaOzLgLsjlGmaHNBgexFNby1X1/uHm+QZDmLaYHmN0ZClnxb8IZuWFjOr02hrpSWbnaQtaE6RCpVufAJ/Nk3u2Prku9VS7OVuK0VJHPVZEVq+7FGUiy/OM0R543mllmC2ol092sgIzr9mDwI39X6sIcA0wJdFmbA1qAmHTWr5KtymgthhAUCIAYmE9uJKg57muuLT0ujlR2oPS3E+q9d+AfzoO/bdhjYOrIv6aWcEzuwRn2029sYZx7x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x85A4IVhvxutMPESG5bbtPNOJ/18BBoMq9Ehwvsc4G4=;
 b=CEliWc6hktJe+2mkuxS4ziujstd9RTsHmpXPDaYNSgoIfxxsQiaZdnovkfRakciKvQux1+7/7F3XcDe62PJ08GKQ1UFM23ynIcE72xnvn4hNtJ3apTHY9nzyYzTvy0Fm6mMze6KoyLIkUAS7KeYs9kO42WQuowV/zMeZPU9YFbnXQZ7rBZ/pXldGfiyFzww3PaiZ7HvXlz5eQOEcLXBA95SxMu0xY9MR7YF80HAig1gvXDo/ptJ+M5zR2XHXfkVyhmMhhgYumPEFiYSH2uEJBygYNu+NY+uUHu44NKj8ghu3vBmYeuPZFbZAK7ziYmI/uU2qXURjNH6ZMf/18wGVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 00:12:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 00:11:59 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZtaekZVdqWpMt9kG5/7FX5qK7u6/ABOEAgAAzyECAAAJr4A==
Date:   Wed, 19 Jul 2023 00:11:59 +0000
Message-ID: <SJ1PR11MB60834DE7D5F7728BF45953F7FC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
In-Reply-To: <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8056:EE_
x-ms-office365-filtering-correlation-id: 36ebf4b1-eef8-4f90-b168-08db87ecc550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ht6/wmkvn4JL4IlmkjTGcnXVECRrbWBD9kyGWqMS9hJehzL54ccf/btu7pCx2CI1pDIGl8DELMn3zNdwWqu9Dwzzt8sDBhQBRPloRgohl9hnnBh14wQC9WO3hbZohznBYOl9KLDyauJAhv4NFHuAHvbXPy27aYtlgXkrbw3pILxrFOq/o/lDf8ClfDHmjy2UTP2LYdB8RoLHZdouLQi8QwJ4aGxW4vGZfJY05j2RJ2clrE4WobT0ldHNTSkc5T6ZJfCfAVBlCaWnRBBPUyEi8o3h8PQmj9bJdlvP+F6BzKqZJ2IqRrlHA/agcKci+ceVAr3OITVBbWxXyNK4T70lmEFJ0Tm3DWi4ZW8vZx2C7QiyT3mo0mtWzSz6Rxirugp9RY2E+ZGmw3wu0R6mdQ1b+UG4KpuEeSRfjOm9Si3LJKez85QpYH2/X6mfe9t4R0lgT6g/k0rCj0XY1bgk1QYAV1waB1y9i7zdFvB8je6yIYtU4p5hpRwnHsmRlbRl0txzjubAq9zc/WBhlGTaRguSYZGyN2oqE2AHrMRm3W0Gbabvj/zDoTM5V3j8ITYSFJQ5mrGQEvPtAZ2xuRMndRe4qCqbd1k4j8S7nMI9RICMpBoQmTrL4QWm4WNHLSmQBOV1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(82960400001)(478600001)(83380400001)(186003)(26005)(6506007)(9686003)(55016003)(8936002)(6862004)(33656002)(8676002)(41300700001)(4326008)(2906002)(5660300002)(316002)(86362001)(7696005)(71200400001)(6636002)(76116006)(122000001)(66556008)(54906003)(38100700002)(66946007)(66476007)(7416002)(66446008)(52536014)(38070700005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkNKWXBrZEtBNFZBMmRwL1V5ZU1aaGtsR3Y1QjBzU2hMT25Mak9WMWpCQjdn?=
 =?utf-8?B?b2piUjNhVisyc1Z3NkxYbWh3Rm9mRi8yT1ZhQXdhcmxxZ2U1U0ZrZTFyMWor?=
 =?utf-8?B?bi9aQ2NHUmp1NmVRMDV5MmIwbWVqV0o3VEZBV01nOGVxcW50TGZtRXQveEhT?=
 =?utf-8?B?U3BhMlh4MERvN3U5UERsa2tvRitxTlA1dm11SFVsMitlS0t5emdRT1BmSGRy?=
 =?utf-8?B?aWFwb1RuVyszUVppenZ5VU8rSmpadHNrdU1MK1dtN1pOQXdKbjhCRmdiZmI5?=
 =?utf-8?B?NGhmQXE0cFFTcXlQZGIrSmpmUlErcHg4MTBVYWFnclNBcUZZU251U3hQUSt0?=
 =?utf-8?B?RHdqamRnNllYeDlyRFphdkpaT3p2enJlbUVNNzZqUUQzK2taT05BUmUyQWNY?=
 =?utf-8?B?NWJPd3RScWRGc2I2VFAyRkVHbDVUUkpFU2VqMm1lTzU4dytSY3k0bFY5K3c0?=
 =?utf-8?B?cFpiaitqVVA1L3pDb0grNERPZG5JWEgzV2RieWlYdVZtcWx5WDFlZW1WTVZK?=
 =?utf-8?B?T1FDc3BYTFh4QTFjNHBvL1VWRkh5OXJjWW50cE9KQ2RZZlIxa25LTjg2UFhR?=
 =?utf-8?B?Vm5KU290Q0ZWdnBiUEF0Z2VlMks4WDRaWXR5dCtFbUZ0SjlpUWxybnlIWU1E?=
 =?utf-8?B?c2U4Z254UGp4WTEzV1FUUnZoempaSCtIbVRHbUk0OEVWd3JIVVJ2MHE3eFV1?=
 =?utf-8?B?cXk2UmZ0UllxbTdrOGNLYUlNU0pNbTk1bmlBdTVHa01oMERTN0NrWHM2L1B6?=
 =?utf-8?B?K3A4NXg0emxkQmY1NVBHTVlEQ3N4RFBkQlFLMnlQWFFoSWphUEs4aFZ5KzVY?=
 =?utf-8?B?THIyNjFwcUpwU2UyMzZIWDhpemZUc1VuTU5zQzNORzg5VkN1b1B1MGJwS0Mr?=
 =?utf-8?B?a1N5RE9NKzFsbW85cTR5dzZPVjRRS0twOGtlTkx6MHh5NjZZMEk3bTZlRGdu?=
 =?utf-8?B?YXNReHFXbUZ2RUVjdXN0SndPWkgvQjAzWTE4a1JnQWJHYjlxb1QrTGJBUXpM?=
 =?utf-8?B?aGdnUFhidGphS0c1MGlHTXBLSTNMa1piZmJ4UGxsZ3MrbmY3Q2lNS3BYRlUv?=
 =?utf-8?B?ODhRZTI5Vk9kY1hUYS9ORksyclUxNzdwZUtidTBsUTFZRU5NakJleXlLZGxC?=
 =?utf-8?B?TVppWUtqZkVCNVJVdmYrZS9yc1RhVlJwRUFxaWhqWDFOWFo0ZXBWN2tKVVRG?=
 =?utf-8?B?RU43NWhlc2JjWTA4K3lnZ3ZmMGF4ZzByRnN2TncvYnBhYm0ya1dvWmQ3M3Fq?=
 =?utf-8?B?WHVHTDlaWWN6RDNtNWJaK0g0YmdnRkFPdVpHL0d1R0puL1hsVkJpOVFvVHVY?=
 =?utf-8?B?eUZURDU3UHRTZEVFOG9HNVJPZnFJZnR6U1c3L01TYWVFY0FnQ29HU2UyZk9w?=
 =?utf-8?B?VUR4WFdoTXBBT2UwN1FoVS9WM2NJb1ZqWEFpSDlWd2oyZGVZYS9kbHY0Y3A4?=
 =?utf-8?B?TlF4azFlT3hSNW9rS3ZvaUJOcCtQQzJKazRzTm8xQ3R5TmFhUXE0dWozZ2ZM?=
 =?utf-8?B?RUNPSFN2VHdJdUluTXJwWFhUSE5hOTg0Rk9xTi8zdlFNSlJ1SHR1UFBwTEI2?=
 =?utf-8?B?SHdWWlFqSXBlbTRKdVllem0xRm4vajdoVFdNemhPRVUxRWZFaXV1K3IxVUhB?=
 =?utf-8?B?cjVzQTJxWkQ5UlVqMWZsc3IvMXlJcUh1WTMwT0w3TmFVUlIxenIrS29oZy9p?=
 =?utf-8?B?M0pWQjNkbDZFTG44MnJPN1lCWG40elFQWWp6aE9QblpzM0lCMFFodVdPeVFh?=
 =?utf-8?B?SDBOQU44VUhPc1M1cE9YdmRwK2tCYzBVbDdWSUhtY1FMWFRaeWxnTnY5WnJH?=
 =?utf-8?B?dytGdnphQmZ4K2FpY3E5WWNVQWFvM21MSXVyQ0ZrMk8zVlM4NHFkckdBdVU1?=
 =?utf-8?B?T2lTdk1iYUtBemUrZjlHM25qVXZVOU83ZXY3VGVjS2FnZmlCNEl5aUNBUUls?=
 =?utf-8?B?dVVFTmRMdTZPTzI1NUlzTEU5STRWUzJpUXlvZXNzeG1BY0VRTUJrY0JjV2J2?=
 =?utf-8?B?UmEzNEZWbVN6UXJtSmhzYlJ4b2pYaEhXR1NhWTQxTVdXRFdSa1NOL2pVZjVH?=
 =?utf-8?B?dW84c3p0VjFmdEtvckxPbGlUeSt6ZTJ0azE0OXJOanpzTFdTZlh0cElqbE5B?=
 =?utf-8?Q?V4zo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ebf4b1-eef8-4f90-b168-08db87ecc550
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 00:11:59.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JVYlxZeerNgtgWSs61qLzHcXojjpdqRwsF/aLL3l2QjmOHzM2CcvigxoGgsrrw2vXt4BHyxYhI69zyVzoGc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZXMsIHRoaXMgaXMgdGhlIGlkZWEuIFRoYW5rIHlvdSBmb3IgY29uc2lkZXJpbmcgaXQuIFNv
bWV0aGluZyBlbHNlDQo+IHRvIGNvbnNpZGVyIHRoYXQgbWF5IG1ha2UgdGhpcyBldmVuIGNsZWFu
ZXIvc2ltcGxlciB3b3VsZCBiZSB0byByZXZpZXcNCj4gc3RydWN0IHJkdF9kb21haW4gYW5kIHN0
cnVjdCByZHRfaHdfZG9tYWluIG1lbWJlcnMgZm9yICJtb25pdG9yIiB2cyAiY29udHJvbCINCj4g
dXNhZ2UuIFRoZXNlIHN0cnVjdHMgY291bGQgcG90ZW50aWFsbHkgYmUgc3BsaXQgZnVydGhlciBp
bnRvIHNlcGFyYXRlDQo+ICJjb250cm9sIiBhbmQgIm1vbml0b3IiIHZhcmlhbnRzLiBGb3IgZXhh
bXBsZSwgInN0cnVjdCByZHRfZG9tYWluIiBzcGxpdCBpbnRvDQo+ICJzdHJ1Y3QgcmR0X2N0cmxf
ZG9tYWluIiBhbmQgInN0cnVjdCByZHRfbW9uX2RvbWFpbiIuIElmIHRoZXJlIGlzIGEgY2xlYW4N
Cj4gc3BsaXQgdGhlbiByZXNjdHJsIGNhbiBhbHdheXMgY3JlYXRlIHR3byBsaXN0cyB3aXRoIHRo
ZSB1bm5lY2Vzc2FyeSBkdXBsaWNhdGlvbg0KPiBlbGltaW5hdGVkIHdoZW4gdHdvIGRvbWFpbiBs
aXN0cyBhcmUgY3JlYXRlZC4gVGhpcyB3b3VsZCBhbHNvDQo+IGVsaW1pbmF0ZSB0aGUgbmVlZCB0
byBzY2F0dGVyIGN0cmxfc2NvcGUgPT0gbW9uX3Njb3BlIGNoZWNrcyB0aHJvdWdob3V0Lg0KDQpZ
b3UgbWlnaHQgbGlrZSB3aGF0IEknbSBkb2luZyBpbiB0aGUgInJlc2N0cmwyIiByZS13cml0ZVsx
XS4gQXJjaCBpbmRlcGVuZGVudCBjb2RlDQp0aGF0IG1haW50YWlucyB0aGUgZG9tYWluIGxpc3Rz
IGZvciBhIHJlc291cmNlIHZpYSBhIGNwdWhwIG5vdGlmaWVyIGp1c3QgaGFzIHRoaXMNCmZvciB0
aGUgZG9tYWluIHN0cnVjdHVyZToNCg0Kc3RydWN0IHJlc2N0cmxfZG9tYWluIHsNCiAgICAgICAg
c3RydWN0IGxpc3RfaGVhZCAgICAgICAgbGlzdDsNCiAgICAgICAgc3RydWN0IGNwdW1hc2sgICAg
ICAgICAgY3B1X21hc2s7DQogICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIGlkOw0KICAg
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBjYWNoZV9zaXplOw0KfTsNCg0KRWFjaCBtb2R1
bGUgbWFuYWdpbmcgYSByZXNvdXJjZSBkZWNpZGVzIHdoYXQgZXh0cmEgaW5mb3JtYXRpb24gaXQg
d2FudHMgdG8NCmNhcnJ5IGluIHRoZSBkb21haW4uIFNvIHRoZSBhYm92ZSBzdHJ1Y3R1cmUgaXMg
Y29tbW9uIHRvIGFsbCwgYnV0IGl0IGlzIGZvbGxvd2VkDQpieSB3aGF0ZXZlciB0aGUgcmVzb3Vy
Y2UgbW9kdWxlIHdhbnRzLiBFLmcuIHRoZSBDQk0gbWFza3MgZm9yIGVhY2ggQ0xPU2lkDQpmb3Ig
dGhlIENBVCBtb2R1bGUuIFRoZSBtb2R1bGUgdGVsbHMgY29yZSBjb2RlIHRoZSBzaXplIHRvIGFs
bG9jYXRlLg0KDQoiY2FjaGVfc2l6ZSIgaXMgb25seSB0aGVyZSBiZWNhdXNlIHRoZSBjYWNoZSB0
b3BvbG9neSBiaXRzIG5lZWRlZCB0byBkaXNjb3Zlcg0Kc2l6ZXMgb2YgY2FjaGVzIGFyZW4ndCBl
eHBvcnRlZC4gQm90aCB0aGUgInNpemUiIGZpbGUgYW5kIHBzZXVkby1sb2NraW5nIG5lZWQNCnRv
IGtub3cgdGhlIHNpemUuDQoNCkl0J3MgYWxzbyBwb3NzaWJsZSB0aGF0IHlvdSBtYXkgaGF0ZSBp
dC4gVGhlcmUgaXMgemVybyBzaGFyaW5nIG9mIHJlc291cmNlIHN0cnVjdHVyZXMNCmV2ZW4gaWYg
dGhleSBoYXZlIHRoZSBzYW1lIHNjb3BlLiBUaGlzIGlzIGJlY2F1c2UgYWxsIG1vZHVsZXMgYXJl
IGluZGVwZW5kZW50bHkNCmxvYWRhYmxlLg0KDQotVG9ueQ0KDQpbMV0gV0lQIHNuYXBzaG90IGF0
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hZWdsL2xpbnV4
LmdpdA0KYnJhbmNoIHJlc2N0cmwyX3Y2NXJjMS4gVGhhdCBkb2Vzbid0IGhhdmUgcHNldWRvLWxv
Y2tpbmcsIGJ1dCBtb3N0IG9mIHRoZSByZXN0DQpvZiBleGlzdGluZyByZXNjdHJsIGZ1bmN0aW9u
YWxpdHkgaXMgdGhlcmUuDQo=
