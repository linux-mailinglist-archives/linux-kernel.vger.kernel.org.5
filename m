Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7C767266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjG1Quh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjG1QuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:50:14 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76255B6;
        Fri, 28 Jul 2023 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690562930; x=1722098930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qbsJ+9mAwHKlnMEP3GWJsJcv7mUxu7jT/JKI0zuMWac=;
  b=js4imtfs0ffoSLtZHQBwNkjq0DP3qTN1r6HYXSexQm4HlsUoKnKdAEBF
   qGipXv3hEV2uk2WkQNKNGA5j0C3aJZokXJBcij2+PjoJPlNi6NBuxrSVw
   k7T9rtnSmykdWxvwW0AXQ/TZzATq4+xd/NCt6QmPdzEkbzrFo1f5Z2VLH
   LDtVprFQtzvajjLjmBQyxn20xem0wMtI05xhL0vdepDdMfQJxykSpkjMo
   OAqSXdmQyv5uJgyxBt/KljqKby2/5zdH6aUaVV5VwjMb89p89FIB5e1O1
   r3EBqZyeuJq6GfEvUcqOxiet3YXA00ug1OfrE+BDSYQN32RJg6d66NLdQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432448995"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432448995"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704631440"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="704631440"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2023 09:47:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 09:47:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 09:47:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 09:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcUXSl+e2QevxnqY3Rx9RHNrXxwj4KIMc1RYGhxDBEE7XqKQGfTLVRkVMXg7aYHuZL9ewFMJdUd/rNlAFGBCIeh5ZHsDly6V5l9Lhf9gCjH5NYN2psmM1USPeLzFwHlZUI8n+IQxJX0q51LkCq+JwBiiLyr6BBZXgR9wbiH8s6VzrLxIIxwFDhwsRyRMf8vAWLO1eHpB19ZoIJYXsLSgg+pJ41l35uFm/zyF/BikYDXlJ3VlTzG4A7I9T/CK+lztR1UNLezWyxRPeFLgIRSQoGPjq9jIS279NjIqsKhYUvGL0k9p+kIYvxy8jv6NvOVSe+L711d85lktvJxyL406Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbsJ+9mAwHKlnMEP3GWJsJcv7mUxu7jT/JKI0zuMWac=;
 b=jHyGEtolV8dlcDDub2CZwg1QDiq31B387mvk+bihbmm+t6n16j49KdbC8mFZ6kxdUWJY/FuUZd6Ec39aQfrjpoocaIEV0UotMCNK62cdguEuo3X+ZUYUYOH+yhaUWtvf2XjKsp/3MfyYkCRKZjiljK5lLGwyUqDTYAOxkpBf7Ormlbki30mcwDlMZm+ThPpZzpVCEkZmWuxHQ8eX7kcc1oCOorWo7Jt2lQkgZTgtjKvl8/v+8UwX65jtKNj1a7V+lsrknHF3dPfvEhpCheBjbUwPRZpDKOdjzK0AJksv+QqA2f6jNoqsnE8OTfzC7dCtXr0m41BEsw7XEzwT++I/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:47:41 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:47:41 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHZrQJTJL9E7mymmECwrZIZTwsK5K/PSoYAgABB5AA=
Date:   Fri, 28 Jul 2023 16:47:40 +0000
Message-ID: <84216c743c6368691bc3fae924c6cbd33805ca9b.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
         <87jzukqjvf.ffs@tglx>
In-Reply-To: <87jzukqjvf.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BL1PR11MB5317:EE_
x-ms-office365-filtering-correlation-id: 7284b3ba-ce30-41f0-7da2-08db8f8a5b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIsxVyBuz870obb8OO+ZL/IGEbRdWt2aWz2wgX0hCdCkghLPJyxR2S1224VXzQFz6sVhdanDlLNLgT9MUBX7BuISGb13c74HngV028CBARKj9tP73Ws3kEJvK7oheG+LyUgvTRSyxTGnPL3Yyy6s+VqWHBsqvzNzkmKGT3ZbfWfo00eG6vvkWRhEfrOAelZTQEiNWpiOvaTHnazApLSu147y6BGeV4ApKjd94/phNgFMBTHky3tSb/kbUktE45afB1gkaPbQ7juqiHKamOTwhr/GlxUr0p1FGXl1q7Gbt6FygwaCgo3Nju6VX2xNKaGVlkKgfbTZj1TE4Wlz95YlIjoW4VhUctYQcDWtK0flcmAK8SYR9Y88zINpNt3jZW/BHjJ8zpF1XR3EvWxCuttjOFnTcLKxgxFunnVUPlHFVtDnpy1rhJqx6k8zLVUI542g3x2LqEcTmg03r5oH5WPHaGTZxVoHYUtlJeaECL369Z9/biw60OouZpShLFxg4zLO/lHF/Zl+Zk7KUkS57fUrlp/rxsZpzfuy0CZzEFYk+NXP3xImRIhIU6BMAi5olOpaWSBODhyjcoSu30N9Rs5UMOu/mg82OcR5qvFe15Kl2D4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(5660300002)(478600001)(110136005)(54906003)(66446008)(66946007)(71200400001)(38100700002)(122000001)(6506007)(316002)(66556008)(4326008)(66476007)(91956017)(82960400001)(76116006)(64756008)(38070700005)(26005)(966005)(186003)(6486002)(6512007)(8936002)(8676002)(2906002)(41300700001)(2616005)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z09qL3ZwTVFKSEtHYlU0R0hlYkx4cHNhckV2MUlzTjVxbGVXYmRyTkUxMGZH?=
 =?utf-8?B?VGlWVjZIUjlTVEs1MDEyZ1JzZUVHQTkwckN2NGIzN0VWbHNEanFQM085ZEVa?=
 =?utf-8?B?eHhsZ2h6YVNtQThOZi9vL2JjaHRTRnF0azR5am5mbWcwLzluU0w4OEgvd2lB?=
 =?utf-8?B?QzRFL3FzRlFEeTgweGkveHVZcjZQNnpuYU40cWFZaWlMaVVKTzB2d3RhWWNw?=
 =?utf-8?B?a3VWbEpvditQM1kwcy9BcjNuMlNVYWk5VEtPNGI1SlQ3Q2EzOExXSXk0eGxE?=
 =?utf-8?B?NkhnVEk0bEUzVGYyRHNCMEVuK1hBZklCRzY2aVRsSGV4TGhwWmErTnQ5T25x?=
 =?utf-8?B?WEhHam1QdVE5OE5jOFlnNlBQcTdrV25tUEgxREFRdWs1eWZyYUNnUG1QWE83?=
 =?utf-8?B?Q0NhL2ZlNUcrclBnYitieHZQSVdOU0JhQ1prd1djeGU5RnNQb0hGeSszRU9Z?=
 =?utf-8?B?UklnWnJaMmtMMmFjWWdGWkZtMHVtVFRQd1VPalZWNm1rcjlDTmpEdldkdlQx?=
 =?utf-8?B?VXdaeHFlL0F3M1FEd2pRVm5QUmQySzMreFdFMllTbFpldVozamFDVHJYN2lQ?=
 =?utf-8?B?NGRsbFVMcXUzbk0yU0tJcktqUHZZWHRjeUtCNy9yMlN0NG5DNmpEbjFTTlhP?=
 =?utf-8?B?UmxONEJRaE9WVUxWSy80cStOSlgwWm9NMEVuMlpZWVFqaitnZUZ3OTJJa0pI?=
 =?utf-8?B?VWVKSlEwdEdITlBobE1xUGM3VThMTFF3cTQ1LzFjTUZmS0pGN1llN051UVVn?=
 =?utf-8?B?MlM4eHd0V1JFbUlvbEorOVlOU2M2ZFZkaDhzRHVVbUF6TWFBWVptbjZQRDc2?=
 =?utf-8?B?a0xnQ21oZCtURmxSWFBGaDZnUm1Sd0pyY2w2SmJrMTNoRXlGbU9kZkYrZFB4?=
 =?utf-8?B?dHdacGkwWlZnaHZPbVloaWt5elNxNy93ei9reDBTSmpyYVhla09uaTE3LzRk?=
 =?utf-8?B?YVhRMzZxZjRsUGNCQ2wwNWp3QVVLTFJTSkROQ2FSQjdDc25WcG9UUkdMeDI2?=
 =?utf-8?B?bDBPaVltVk9WZkw3c1pSb25hOXIzcUdzWFc3OGhScXBZQW5BZkxielhWbjJz?=
 =?utf-8?B?eVkvVXo3Y3B5TEUweUlRS1FDYSt1NmhuRWdZTnFmZnNWdkwycFgyOVlzUldK?=
 =?utf-8?B?L2QyZUNkMS9DUjFLT0xJemovL0Fic2lrcTBZN0d0c0Q1ZGVRdExJeXZTZ0k4?=
 =?utf-8?B?a0ExaUdIZE1oNXE1YlROQVNDM3hBVTkwRDR0cFNrWnNpOXBHUzc5dFhZL1Nr?=
 =?utf-8?B?RXB5c2w3WTVHcDBYbTdhdjdzc1JoTURTVEZaZVJmQ2VWT2ZMcGxpa1Q1eXhS?=
 =?utf-8?B?MU5sa0ZBcVYyNHptZkszTTgyWTVjU01SQWJjRktrenlLODh1dytpYXU1ZXdJ?=
 =?utf-8?B?VWpycGtDZ1BMd3FaN1FueWdkb1ZPa2VLd1o2T3hZWXVOYUNOeWMraTVWektG?=
 =?utf-8?B?bm9iaHR5ZlQ5VXdYVHVOK2ZEcGNJUVNDeGJTT04zbW9yalB4MjdvL2hkWEZ1?=
 =?utf-8?B?K1E1VXBHNnJZNkRaS3lodnhuQlJzTGVKTEZBU0UvR045N3RXUENwSlRjZlc3?=
 =?utf-8?B?Q3Y0cXR5b3ZPK0JzTWo5UE43QUxYWFJhQmdYdXdIQ28yTi9VekdyYU16Vnow?=
 =?utf-8?B?MktxaEUwSURGNEhWVVlMKzFzOExDNU1RTU9YRzdINkZjc015aXZTU0lJZ29p?=
 =?utf-8?B?Mk55OWtQSFgwaTVVamIzUXRRV2x6QjRHeldkdGlNdFdUL2JCSVRDdnBQVW5w?=
 =?utf-8?B?V0grSlRYbFZmTzNyTlFnb2JSdXRHM1c4YS9Gdk55bXRlbThnTE9ZK044RGdp?=
 =?utf-8?B?OWRycmwwdUxyMFpFbTJ6T0NGd2tXZkd6YWVFOHFNQnh5RHp0Y1dpQXNUR0VQ?=
 =?utf-8?B?QW1pcmVzYUR4ck15Sk1vK3B0d25LSnlpTGJHczZiVHJBb21ybWhvejJzS0Yr?=
 =?utf-8?B?T0V4Z2hDdlRxRld0SFV1TlBMencwWFJGVkNIVFdGSDlvMU1TaldWMTRXcDcy?=
 =?utf-8?B?S2VNNlRhZU9QQ0xwbFdNVGN0dlhMb0NEbC9nUC9BZGlFdFlZb0wrTWJZdVN0?=
 =?utf-8?B?cXFJcHQwTXVSeXlGUWtPb3BORlQ3Y1h6L1lGVG9aL0E1Tm5jMU5GUXFCMUxq?=
 =?utf-8?B?TFYyTVFmWUt1eFlUN0h4ZUtoZW4zS015QnFTKzltK2xUb0JneE5pV3BIdkgy?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BB23D1B6BA79A4A8F16FDA3756A56B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7284b3ba-ce30-41f0-7da2-08db8f8a5b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 16:47:40.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVOJFguz4rN2c5w5KdrxiTG9lFuXdfl8ZJdkLhgctUfGSAA/T8z6DOWEjqn49Le5jCqWhLX2t0l3ErQDIA7cgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
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

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDE0OjUxICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIE1vbiwgSnVsIDAzIDIwMjMgYXQgMDA6MjgsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiDC
oA0KPiA+ICtzdGF0aWMgYm9vbCBoYXNfbGFwaWNfY3B1czsNCj4gDQo+IFlldCBhbm90aGVyIHJh
bmRvbSBmbGFnLiBTaWdoLg0KPiANCj4gSSByZWFsbHkgaGF0ZSB0aGlzLiBXaHkgbm90IGRvaW5n
IHRoZSBvYnZpb3VzPw0KPiANCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jDQo+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYw0KPiBAQCAtMjQ1Miw2ICsyNDUyLDkg
QEAgaW50IGdlbmVyaWNfcHJvY2Vzc29yX2luZm8oaW50IGFwaWNpZCwgaQ0KPiDCoMKgwqDCoMKg
wqDCoMKgYm9vbCBib290X2NwdV9kZXRlY3RlZCA9DQo+IHBoeXNpZF9pc3NldChib290X2NwdV9w
aHlzaWNhbF9hcGljaWQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaHlzX2NwdV9wcmVzZW50X21hcCk7DQo+IMKgDQo+
ICvCoMKgwqDCoMKgwqDCoGlmIChwaHlzaWRfaXNzZXQoYXBpY2lkLCBwaHlzX2NwdV9wcmVzZW50
X21hcCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVCVVNZOw0K
PiArDQo+IMKgwqDCoMKgwqDCoMKgwqAvKg0KPiDCoMKgwqDCoMKgwqDCoMKgICogYm9vdF9jcHVf
cGh5c2ljYWxfYXBpY2lkIGlzIGRlc2lnbmVkIHRvIGhhdmUgdGhlIGFwaWNpZA0KPiDCoMKgwqDC
oMKgwqDCoMKgICogcmV0dXJuZWQgYnkgcmVhZF9hcGljX2lkKCksIGkuZSwgdGhlIGFwaWNpZCBv
ZiB0aGUNCj4gDQo+IEFzIHRoZSBjYWxsIHNpdGVzIGR1cmluZyBNQURUIHBhcnNpbmcgaWdub3Jl
IHRoZSByZXR1cm4gdmFsdWUgYW55d2F5LA0KPiB0aGVyZSBpcyBubyBoYXJtIGFuZCB0aGlzIGlz
IGEgcHJvcGVyIGRlZmVuc2UgYWdhaW5zdCBicm9rZW4gdGFibGVzDQo+IHdoaWNoIGVudW1lcmF0
ZSBhbiBBUElDIHR3aWNlLg0KDQpZZWFoLCB0aGlzIGNhbiBmaXggdGhlIGR1cGxpY2F0ZSBBUElD
IElEIGlzc3VlLg0KDQpCdXQgZm9yIHgyQVBJQyBDUFVzIHdpdGggdW5pcXVlIEFQSUMgSUQsIGJ1
dCBzbWFsbGVyIHRoYW4gMjU1LCBzaG91bGQNCndlIHN0aWxsIGVudW1lcmF0ZSB0aGVtIHdoZW4g
d2UgYWxyZWFkeSBoYXZlIHZhbGlkIExBUElDIGVudHJpZXM/DQoNCkZvciB0aGUgSXZlYnJpZGdl
LUVQIDItc29ja2V0IHN5c3RlbSwNCg0KTEFQSUM6IEFQSUMgSUQgZnJvbSAweDAgLSAweEIsIDB4
MTAgLSAweDFCLCAweDIwIC0gMHgyQiwgMHgzMCAtIDB4M0INCngyQVBJQzogQVBJQyBJRCBmcm9t
IDB4MCAtIDB4NzcNCg0KIyBjcHVpZCAtMSAtbCAweGIgLXMgMQ0KQ1BVOg0KICAgICAgLS0tIGxl
dmVsIDEgKGNvcmUpIC0tLQ0KICAgICAgYml0cyB0byBzaGlmdCBBUElDIElEIHRvIGdldCBuZXh0
ID0gMHg1ICg1KQ0KICAgICAgbG9naWNhbCBwcm9jZXNzb3JzIGF0IHRoaXMgbGV2ZWwgID0gMHgx
OCAoMjQpDQogICAgICBsZXZlbCBudW1iZXIgICAgICAgICAgICAgICAgICAgICAgPSAweDEgKDEp
DQogICAgICBsZXZlbCB0eXBlICAgICAgICAgICAgICAgICAgICAgICAgPSBjb3JlICgyKQ0KICAg
ICAgZXh0ZW5kZWQgQVBJQyBJRCAgICAgICAgICAgICAgICAgID0gMA0KDQpJZiB3ZSBzdGlsbCBl
bnVtZXJhdGVzIGFsbCB0aGUgeDJBUElDIGVudHJpZXMsDQoxLiB3ZSBnb3QgNzIgZXh0cmEgcG9z
c2libGUgQ1BVcyBmcm9tIHgyQVBJQw0KMi7CoHdpdGggdGhlIHBhdGNoIGF0IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC84N2VkbTM2cXFiLmZmc0B0Z2x4LyAsDQpfbWF4X2xvZ2ljYWxfcGFj
a2FnZXMgaXMgc2V0IHRvIDQgaW5zdGVhZCBvZiAyLg0KDQp0aGlzIGlzIHN0aWxsIGEgcHJvYmxl
bSwgcmlnaHQ/DQoNCnRoYW5rcywNCnJ1aQ0K
