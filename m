Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0377ABBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjIVWXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjIVWXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:23:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD01A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695421397; x=1726957397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zha2bdFpkZMzwu0QsqbKqUdxNPUoQQ0Vy7V7txjAbrg=;
  b=mO06FPBBte0sJe7BML33sUryvprRPMiAF1xCskm3k3B+9Zm6BAWpXbC8
   BkKkyjZte2YeQ7SfkS9OUnMHEBuU3q6MvaVLh9k8F8jNQY0Hmp+s7B1vV
   t8GzUDYvVydVMtjHWZ3Aeim87BKCm6v58su6+szzPNWyYxPKtRlqHrzWY
   qlyCICzu5PhJKi0gwr9Xte/yPYn433KkvwBOIYO4XRwS9DSdA3EdwThYy
   CaQi5gtCAVfWJcPLKXaaI/DGtlOXUNedH0rQpU574ZvItZbh16ayr9UoE
   s/Sq3NV0nERFu6pjOCzyJiZdgbRAXKeMLBmDXg9MbBAD9CXVtfpBv93lu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447438242"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447438242"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 15:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="890978396"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="890978396"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 15:22:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 15:23:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 15:23:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 15:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvBZ59DoJiEHuVaCvfhMf9HjtjA1xOSAFZ/OpV0s2/otNCaAibBvjX9gjL2ZOxtDDznA3UFnBLGAZLlQs/AjYxMfV/BIecbM4pt88MaVneh+VXaSEo6KVZfbQCSFl1JSVJn6nXuLLL+X8XTBb/HUyUfslpBDE+N4EtIZ623Q71MTzzNO3x4cfEj79VxHVV3zg2PrLbGruQg+SQ9aFgYwmdAsvJAJYM6pitcTQVv4nRoVhWznqGmRXTcMUahB/07aIuiXNfcDFXAWDW/okscL80pqW/8UnNp+HcsYQgKQvcgWSokqcKB+/ZWqoQo8KAqy7Bagz3to0Yd2xMr6Bme8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zha2bdFpkZMzwu0QsqbKqUdxNPUoQQ0Vy7V7txjAbrg=;
 b=SOb3TWE6aJh4V68IZqwPWsyx3wXYk0FjuX8iquhGDPACkRVTNSVvDPoXZGfDSuSnD6HBIw3URKHloJImWf0TLCjb9gdw9r5fB5CchuqqCmbhhLVtv6EsYi1spK5hRrY2FXyekx4QzzSLFrVnGqn1ozIXpPU7FhxU5jMcsK+DCf/WMp/RoYl771qwJDj/kgI7GjQI//H+WTRxlDyRiDsPQlu5v0Bn0cH6HLw4pq16GImmRAeIX2TJ8BqTwBEdWlCZio5rsfO50+u6InCSP27ZbZspVbvRU8Mm4Bfiyne4heci/BA2J0ZbHbRW7zrBzJ5SEjzwedGHrsZEC6fyD3p1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Fri, 22 Sep 2023 22:22:58 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 22:22:58 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "tglozar@redhat.com" <tglozar@redhat.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nd_btt: Make BTT lanes preemptible
Thread-Topic: [PATCH v2] nd_btt: Make BTT lanes preemptible
Thread-Index: AQHZ64UT6df2/GQ5sEOvyImbuXEt1rAnb6EA
Date:   Fri, 22 Sep 2023 22:22:58 +0000
Message-ID: <74efb332edd8012f772fa05ed385f8a9df70b57d.camel@intel.com>
References: <20230920053712.499439-1-tglozar@redhat.com>
In-Reply-To: <20230920053712.499439-1-tglozar@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DS0PR11MB6328:EE_
x-ms-office365-filtering-correlation-id: c8ef6ac6-43d5-429e-a880-08dbbbba79ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxAOaXN9DZyF7nBCkroPNP5bS51G6cm6SKpbot8kBicCfGtVZkTJvABl8CCsg/qYKxheP0XkNGsEJ4A0cg5lbqDFo+49EgxVQ9sq9kUPR4btNVU38EgrgLipLaJSmgiIG9fcD1tyD+FjOchjaWiEn3bHrpsPlQCWaPewxakpAqUkyXxGqYTo5mTp4aZInWU0xhTUm3+6RC+eAdNgC+iV7YM1bp6tWN1829tEmrlsLkN+M7h4jA+VQ4Nfa1simrlr3HiFPN2cy1SHQf3nJ38KukTNBdYMMJd8oUjMtAr03oIhMPNM5jYM4dkfHuBtQisduqiIUtBlsknJw4drcB2ufonnrZRaiJXMCcYPrBggzuJNIdMlJ0FnM5quqUSoyW1lcNoPgA2pQcr1CG+ut71njPge+igcgQ7VmC2dvo9X8UykQiC5wE4yNaQpEi1+TaHhwEYmaPduXz+pMDyY+PgVsGlLprz2FnXPtQyobLcpYnr4wZnRy9A3ILmLrYC4si2ilJVVdG7SnfY9AFybWsSiXAUOHtPIhhGSLajBDlXLZAxbgxS5M+2Jy/jDCb3NmkYA+JxkIcVeDpciXXPoX9LLyhY24cMtKtShW5d0VFDECIv32bD0rb5Z8u8UnIXoOlgb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199024)(186009)(1800799009)(6512007)(6486002)(6506007)(122000001)(71200400001)(86362001)(38070700005)(36756003)(82960400001)(26005)(83380400001)(41300700001)(478600001)(8936002)(5660300002)(38100700002)(2906002)(107886003)(54906003)(64756008)(66446008)(4326008)(110136005)(66476007)(66946007)(316002)(76116006)(8676002)(2616005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDdGU1FNbkRLSzJwWnFIRDJOSXBPMWJJZmRSUlFFb1ladC9rdnlOSVgzd3Rq?=
 =?utf-8?B?K0ljakVGSlBnaFpZS1dqaXowNVR3bE1OcHlLKzVUbFJFZmlzSEpiNlV5M3Q0?=
 =?utf-8?B?UStvMldMSENaM1N6bzhRcW9xMVc2dlR0clpnN3JtL1ppNkFTaXpIbUJ6MnFw?=
 =?utf-8?B?cnBMbVZRdmZVeFV4S2ZRVFdZZXJaaEhFWEdGdUJKNzBrSDQ2cCt0NVQrU2Zl?=
 =?utf-8?B?WS9FSGpTaldmajZXdFQrWXZEakVzcExYUThsYnZkY1RjSHRPTDZFNDR0L3FZ?=
 =?utf-8?B?Y1phUlFVOXhXWi8zeWxnaitWTkI0SEQwV1dHVjBzQ0NreUsrbkFtUUZ5SXpV?=
 =?utf-8?B?M2F4NC85bXExMFdVVFlsYzB3RVZScitrOUtzK0tqZUhwTjhqU1lLRmFuUUVw?=
 =?utf-8?B?NThoR1FvU284aVRRSlJ6OUppMm5tRFAxZExZdmdxeTA5RWJxNGErSzJLMjZQ?=
 =?utf-8?B?U2VtcU1NZi9ubW9Oa2tLdXpybkUraDMxcHJhMnpjNk93OXkwTi9nNCtrL05p?=
 =?utf-8?B?cWJIZnU0QmcxOUY5NmhXUUVvYWtBQ1ZIbnd6NEcweWZvTm5YOWRPQ1Q5U01X?=
 =?utf-8?B?b1RHV1krbys2dys1ejVNWENndGJacW9PWCtJOTNONHR4Q1NtMTF1S1Y4V3FH?=
 =?utf-8?B?ZGhZbFFzRnE3MXgxTlBPZEMrWmhxVlV2WTloVFF3WmllelBTQjRldUtoYy9E?=
 =?utf-8?B?T0lVbXk1NnVRcWJXdUFNdzNPY1hOSkowL2ZGVjEvQUgxbTBaZUZqbGRaWU04?=
 =?utf-8?B?eTJBL2JWSUNtT2o5dkZGVHBITndMR1Y5T0RuOWE3bEFtRXNDMkdCV2hWMmVj?=
 =?utf-8?B?Zm5nWFNZYXE2SGVFbE9rT3BvZmV0NUdHVWo0M0prdlpReXNWTmkyTFQrcng2?=
 =?utf-8?B?UGQvWjVlVGJxeVY3OUNYNWozajFyemd1NmE2cGJ2TWU1bzdYMWVhV01GOGFI?=
 =?utf-8?B?SUZaWFRReUpKZkE5QzRaUkxnZkd0OXdVdlFGSE0rVHRkZmJNTlMxS0JLNVEw?=
 =?utf-8?B?N0w1YzM3ZzRwbzJiRk8ySVUybExBcXFDdzRZM3hDeUl1cC9xYXVYN3RSTEdF?=
 =?utf-8?B?SjJucTBQcjVaK1lxZGd2V0w4TGV4MmlWQmV5L3BVcnpPdDBMaHlBRXlGR1Fh?=
 =?utf-8?B?WVZ6Y0xLaW1mSmJIdnZLZnhtUWYwQjl0bGlqL1YzcmxObk1mL0JNdklVbndv?=
 =?utf-8?B?ZG1MQUZpbFRreVFFLy9PQWZBRmhhTDBnd05pMHIrbEowTk9FWGdTbEdNRW9J?=
 =?utf-8?B?WkNTRHBsMWpXT0I1Tk1jMVlWWmZudG44UDVHL1FLVjRyVEJyZHc5My9UYldE?=
 =?utf-8?B?bHdhWG5jbExxKzBpWmViWDBEQ1NjRkRhYkRGTC8vTlE5NEZUTjNYb2gyQ0pp?=
 =?utf-8?B?amJiZXB3QTVGVityamdPVWRoMHgxdmU2QTZ0WHdjWFE0M2dLZ0lUem9adm5t?=
 =?utf-8?B?aUZOb0drS0o3NjY2MnJlaGUxelpsRlNGZ1lPdGRTWW04N1NCNFJrdWRQeGpO?=
 =?utf-8?B?c1ByZXlIVzNHZGVRVHZsaWl2VmJLYTVqc2tTdW43SGlDQ2QrZGgrenBjellB?=
 =?utf-8?B?WVlLQ0VCZmx5MWxUSFIxb3ljZDArb1N6dGZqVkFFQ2VPV0ZjV3J4d2RydjBN?=
 =?utf-8?B?THUyQWluQTVrUjJSemQ1Z1RkVFhsbFIzNlpKR1NnL3k5MWFSU1lOUWJwb1dF?=
 =?utf-8?B?VVg2T2dhWWMyVXo1NmNXZFdoK1Y4UEQyYW92Y2pvM0c3cGNQQ3VzWHIya0dx?=
 =?utf-8?B?RUdXYlNKSXU5SkZYVUtRMm55NDR0cEtzNHhFMXBmNENrb2xQcnBYV1FLZCtn?=
 =?utf-8?B?YkNySFc4a3BGNjAvbkZlVlJzTFJWTUNrQ0VpUlJTSERqYjFDWnFpWUQ2cWN5?=
 =?utf-8?B?b3RYdnlmeHJTYTh3bnlJSk95SFlvamw1aU1zMmNZMEs3SzZFdXdQNzNIeXRC?=
 =?utf-8?B?QXh2TzJNOThGaUl5bjNkR3QwazNSM3luNWdmZ1A3WTEwVm1WcnBQSjhkaUIz?=
 =?utf-8?B?QzJORU42SzRHYnl1QTZlNkp6MW40R1JJeFRUZFlCYXpqazJYWkZtb2dCY0pB?=
 =?utf-8?B?OEFSbzRlcVNVeXJHMm5nMTVPN3I1UFRSSEV3Q2ZLMXIzRlNaakVnajNxeWY1?=
 =?utf-8?B?b2QzQTdQbUlKTEtnS20rRFlBdzd3VkdMNEtvQ1JnQ0JKVTVSc2REcm1VY2Ix?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9381B85F21D3134F8D6B2530DFB8CEDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ef6ac6-43d5-429e-a880-08dbbbba79ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 22:22:58.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGLbAWCOu0EUbxk+TDGXfRERwiIB2FzLtN7R83JysQXWB//SI7Q7CBOXj5UYjRhhXUaTVpgvTXQdRw+STgd6ZUnaOLydQ+30+qt1uvr6bo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
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

T24gV2VkLCAyMDIzLTA5LTIwIGF0IDA3OjM3ICswMjAwLCBUb21hcyBHbG96YXIgd3JvdGU6DQo+
IG5kX3JlZ2lvbl9hY3F1aXJlX2xhbmUgdXNlcyBnZXRfY3B1LCB3aGljaCBkaXNhYmxlcyBwcmVl
bXB0aW9uLiBUaGlzIGlzDQo+IGFuIGlzc3VlIG9uIFBSRUVNUFRfUlQga2VybmVscywgc2luY2Ug
YnR0X3dyaXRlX3BnIGFuZCBhbHNvDQo+IG5kX3JlZ2lvbl9hY3F1aXJlX2xhbmUgaXRzZWxmIHRh
a2UgYSBzcGluIGxvY2ssIHJlc3VsdGluZyBpbiBCVUc6DQo+IHNsZWVwaW5nIGZ1bmN0aW9uIGNh
bGxlZCBmcm9tIGludmFsaWQgY29udGV4dC4NCj4gDQo+IEZpeCB0aGUgaXNzdWUgYnkgcmVwbGFj
aW5nIGdldF9jcHUgd2l0aCBzbXBfcHJvY2Vzc19pZCBhbmQNCj4gbWlncmF0ZV9kaXNhYmxlIHdo
ZW4gbmVlZGVkLiBUaGlzIG1ha2VzIEJUVCBvcGVyYXRpb25zIHByZWVtcHRpYmxlLCB0aHVzDQo+
IHBlcm1pdHRpbmcgdGhlIHVzZSBvZiBzcGluX2xvY2suDQo+IA0KPiBCVUcgZXhhbXBsZSBvY2N1
cnJpbmcgd2hlbiBydW5uaW5nIG5kY3RsIHRlc3RzIG9uIFBSRUVNUFRfUlQga2VybmVsOg0KPiAN
Cj4gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQN
Cj4ga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfcnQuYzo0OA0KPiBpbl9hdG9taWMoKTogMSwgaXJx
c19kaXNhYmxlZCgpOiAwLCBub25fYmxvY2s6IDAsIHBpZDogNDkwMywgbmFtZToNCj4gbGlibmRj
dGwNCj4gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDANCj4gUkNVIG5lc3QgZGVwdGg6IDAs
IGV4cGVjdGVkOiAwDQo+IFByZWVtcHRpb24gZGlzYWJsZWQgYXQ6DQo+IFs8ZmZmZmZmZmZjMTMx
M2RiNT5dIG5kX3JlZ2lvbl9hY3F1aXJlX2xhbmUrMHgxNS8weDkwIFtsaWJudmRpbW1dDQo+IENh
bGwgVHJhY2U6DQo+IMKgPFRBU0s+DQo+IMKgZHVtcF9zdGFja19sdmwrMHg4ZS8weGIwDQo+IMKg
X19taWdodF9yZXNjaGVkKzB4MTliLzB4MjUwDQo+IMKgcnRfc3Bpbl9sb2NrKzB4NGMvMHgxMDAN
Cj4gwqA/IGJ0dF93cml0ZV9wZysweDJkNy8weDUwMCBbbmRfYnR0XQ0KPiDCoGJ0dF93cml0ZV9w
ZysweDJkNy8weDUwMCBbbmRfYnR0XQ0KPiDCoD8gbG9jYWxfY2xvY2tfbm9pbnN0cisweDkvMHhj
MA0KPiDCoGJ0dF9zdWJtaXRfYmlvKzB4MTZkLzB4MjcwIFtuZF9idHRdDQo+IMKgX19zdWJtaXRf
YmlvKzB4NDgvMHg4MA0KPiDCoF9fc3VibWl0X2Jpb19ub2FjY3QrMHg3ZS8weDFlMA0KPiDCoHN1
Ym1pdF9iaW9fd2FpdCsweDU4LzB4YjANCj4gwqBfX2Jsa2Rldl9kaXJlY3RfSU9fc2ltcGxlKzB4
MTA3LzB4MjQwDQo+IMKgPyBpbm9kZV9zZXRfY3RpbWVfY3VycmVudCsweDUxLzB4MTEwDQo+IMKg
PyBfX3BmeF9zdWJtaXRfYmlvX3dhaXRfZW5kaW8rMHgxMC8weDEwDQo+IMKgYmxrZGV2X3dyaXRl
X2l0ZXIrMHgxZDgvMHgyOTANCj4gwqB2ZnNfd3JpdGUrMHgyMzcvMHgzMzANCj4gwqAuLi4NCj4g
wqA8L1RBU0s+DQo+IA0KPiBGaXhlczogNTIxMmUxMWZkZTRkICgibmRfYnR0OiBhdG9taWMgc2Vj
dG9yIHVwZGF0ZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBHbG96YXIgPHRnbG96YXJAcmVk
aGF0LmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgdXBkYXRlIHRvIGluY2x1ZGUgdGhlIGZhaWx1cmUg
c2lnbmF0dXJlLg0KSSByZWFkIHRoZSBjb21tZW50YXJ5IGFyb3VuZCBtaWdyYXRlX2Rpc2FibGUo
KSwgYW5kIGl0IG1ha2VzIHNlbnNlIHRvDQp1c2UgaXQgYXMgYSByZXBsYWNlbWVudCBmb3IgZGlz
YWJsaW5nIHByZWVtcHRpb24gaGVyZS4gSSBzdXBwb3NlIGF0DQpzb21lIHBvaW50IHRoZXJlIHdp
bGwgYmUgYSBtb3ZlIHRvIHJlbW92ZSBtaWdyYXRlX2Rpc2FibGUoKSwgYW5kIGF0DQp0aGF0IHBv
aW50IHdlJ2QgaGF2ZSB0byByZXdvcmsgdGhpcyBjb2RlIHRvIHJlbW92ZSB0aGUgaW1wbGljaXQN
CmxvY2tsZXNzIG1vZGUgd2hlbiBvcGVyYXRpbmcgdW5kZXIgcGVyLWNwdSBhc3N1bXB0aW9ucy4g
VW50aWwgdGhlbiwNCg0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFA
aW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMgfCA4
ICsrKystLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jIGIv
ZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiBpbmRleCAwYTgxZjg3ZjZmNmMuLmUyZjFm
Yjk5NzA3ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiAr
KysgYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+IEBAIC05MzksNyArOTM5LDggQEAg
dW5zaWduZWQgaW50IG5kX3JlZ2lvbl9hY3F1aXJlX2xhbmUoc3RydWN0IG5kX3JlZ2lvbiAqbmRf
cmVnaW9uKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBjcHUsIGxhbmU7
DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoGNwdSA9IGdldF9jcHUoKTsNCj4gK8KgwqDCoMKgwqDC
oMKgbWlncmF0ZV9kaXNhYmxlKCk7DQo+ICvCoMKgwqDCoMKgwqDCoGNwdSA9IHNtcF9wcm9jZXNz
b3JfaWQoKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChuZF9yZWdpb24tPm51bV9sYW5lcyA8IG5y
X2NwdV9pZHMpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmRf
cGVyY3B1X2xhbmUgKm5kbF9sb2NrLCAqbmRsX2NvdW50Ow0KPiDCoA0KPiBAQCAtOTU4LDE2ICs5
NTksMTUgQEAgRVhQT1JUX1NZTUJPTChuZF9yZWdpb25fYWNxdWlyZV9sYW5lKTsNCj4gwqB2b2lk
IG5kX3JlZ2lvbl9yZWxlYXNlX2xhbmUoc3RydWN0IG5kX3JlZ2lvbiAqbmRfcmVnaW9uLCB1bnNp
Z25lZCBpbnQgbGFuZSkNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobmRfcmVnaW9uLT5u
dW1fbGFuZXMgPCBucl9jcHVfaWRzKSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnQgY3B1ID0gZ2V0X2NwdSgpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdW5zaWduZWQgaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmRfcGVyY3B1X2xhbmUgKm5kbF9sb2Nr
LCAqbmRsX2NvdW50Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5k
bF9jb3VudCA9IHBlcl9jcHVfcHRyKG5kX3JlZ2lvbi0+bGFuZSwgY3B1KTsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZGxfbG9jayA9IHBlcl9jcHVfcHRyKG5kX3JlZ2lvbi0+
bGFuZSwgbGFuZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKC0tbmRs
X2NvdW50LT5jb3VudCA9PSAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmbmRsX2xvY2stPmxvY2spOw0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcHV0X2NwdSgpOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiAt
wqDCoMKgwqDCoMKgwqBwdXRfY3B1KCk7DQo+ICvCoMKgwqDCoMKgwqDCoG1pZ3JhdGVfZW5hYmxl
KCk7DQo+IMKgfQ0KPiDCoEVYUE9SVF9TWU1CT0wobmRfcmVnaW9uX3JlbGVhc2VfbGFuZSk7DQo+
IMKgDQoNCg==
