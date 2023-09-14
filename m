Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF079FFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjINJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjINJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:23:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE61BEF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694683406; x=1726219406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7fBC5TYh8bdJl4CzsDIHKmJiC3GTpgZ2ccJ1kbUwXf0=;
  b=GmlLr5U3jAVIbeSzP8/ej9zh6RPCOpsYAH/Lz5eIzZeeqC8jJwX2vlS5
   q1GhPpnC8BmuFbHXObulNgGtxw4sjIsJQW+Y/5bkfHM/GK3tdo7LFkzSL
   AO972ADPaZlrxM4oboFy1qKvtvs2VcT+SXEuE5OGS7tiZSlBphP4G/8o5
   C8JQO2OcuC/gy3RU44YNG5Cg29LnGNbY2+Vz+rxGxt7ykWEJwcZ1pkv4l
   uHiQrLLzkiBhFk9ieDthz0PHrfmaChudRgyxH0wWdozkf1i+efPuCoQSq
   hR7k7yzT2z9ucrF+YyEcnOqw6pqubFAsnzzZa81w6eO10hhOOZXTe5y+C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359163183"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="359163183"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="834687474"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="834687474"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 02:23:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 02:23:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 02:23:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 02:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY4ML1QxLRw+Rk7Jy86If50P0lLsyc+VcZpHuWuertTB/cMoYC0Fs7YGOAAjMINhKMPuIdB0kYqBOuf+uBgLX36g7gjGlfyLoZ/f6veFThnePSUvxmo3P1nvdcyLHsubvjQ1URuUt+VecHQxD9G6Mf5KCuD7MkYlim3NVcHMkk9fv+vHx8GLjzuEAomQk+jGx+V9W55pHGNSpbij/Q/vuaBjpN4hfzvCraxLl6J+MgXMIM1X1Jvp18LKDorZhfybmj0yxSnPqxFyfA3cxHgpZidwaNWVu97db+v6/euS5IL6b7D/9XT46c+Pb3NNP31TUmOwmOeSWNNrikOJ1G6CGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fBC5TYh8bdJl4CzsDIHKmJiC3GTpgZ2ccJ1kbUwXf0=;
 b=PznQ2++lzqWXtjDC/oxzKn1ff/v3K30a1LG++NSwQV3vWqpiQ0zDSis2bBBeANf7Ta99p6OnIKpO6dH/Q35xypnoOxrBPVnFKMD6SWWBjNqQ+B/L0+GsVLcgeHFVYCzLuYUvRz/ptve6H9o/gYTB2KoX3nZAxEBx9wdX9ue8ni4yJqHQOWlISCcdVsaZR50/vqwoqcdTjm0etZsMjRvC6y4kXh9x7Y4SBhoDN33RcpgAU/c3TLfq6iLrhly9IYj9jR8+yTogKMT2DxpQZJDJ+QZ6Nh7sLrqDD4VYwMFmCPY1AJ+n2e3WqQwV7xKAuxuVHkSz4EQtWSgEKir2K80wEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 09:23:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d477:e13a:d148:b849]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d477:e13a:d148:b849%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 09:23:18 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Topic: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Thread-Index: AQHZxrPwkdv1IzdOfEyKSBa04QYHK6/pLXsAgABYUICAJ16+AIAE2BgAgABOrQCAAXNYgIACziKA
Date:   Thu, 14 Sep 2023 09:23:18 +0000
Message-ID: <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
         <20230814031432.GA574314@ziqianlu-dell>
         <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
         <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
         <20230911114218.GA334545@ziqianlu-dell>
         <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
         <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
In-Reply-To: <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 3a81d819-43cd-49ad-2990-08dbb5043b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFlobfIo+tlXx1do2UW8mPmqzL9xVx5GLoFBFEKfrQ7hMyFJZ43uRHoCtq4MHR368qbw4eC7AbB0AYOuGgFRdCKWAe4hdMIlc0Dmhcf61G/2XyaEZi2hVZp8dbw6Ujsi5GM9I7bljVZsrCELfxINHQRm9TBaJ4gyIf1p3HtzVA1YTAHMaz5IFCuKE2pHOkfnUh5D4nRKrBUYLr/Z2D5lqrU5sHKdQLEFZV56yKJ+pYoOd4ZUrBTCCmpKJwptN0PtOk79Stkxv0yko3ZS1qgOL4P7YuMQ+CiJoAaaqp43Zlurn4HX0EXPLfXKykpYfemZiYrGc/s9VZIlWUCHono/9Tsi1bjwbbU2YgDFCpYvrUmJQjDwFoFdsNtHBfSNyO8gLXXQw6toe9KRHjYG0eHLVc+YYss6EERREC2QEAqhclF+05h+INTsY7PwHWxBqt4sZ17bRP5nA+dNKZnxoE0MN/7P3HGOPDjqqnrGYhbENMtYLTUnqeKFA118uhmVZl/vrKpdXXl9h4t7FpJOzD5Z6ISgwKtcceItjQ4P7Bx7Vaf/PpOQjfS6oDdNjpQBiK/ElaLZpBe0O7DUzd89p0+E/frAsw3G4V12W81Cwr+QEG4xADNNThxJsCF7Sm+J3TYY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2616005)(2906002)(66899024)(83380400001)(41300700001)(26005)(6506007)(478600001)(6512007)(82960400001)(38070700005)(122000001)(38100700002)(8936002)(4326008)(8676002)(54906003)(91956017)(316002)(76116006)(36756003)(64756008)(66446008)(5660300002)(66946007)(66556008)(66476007)(110136005)(6486002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5wRVoyNEQ5dkJKZlJ0a2cxNzdTMzhsa3p3T0pDblVtaVB3NjB5S3ZkMEJz?=
 =?utf-8?B?WVgvck9EbSsxc3MyaXA0L2JTTkdqM0RkMmhseFBkLy82NVp3ZmVsZFc4a2Rh?=
 =?utf-8?B?cEFCQjBVd1JTOTJMVitxS0tLOWZIbCsyTnkrazJ2R0gzZndnMlBvb3ZYUTFF?=
 =?utf-8?B?ckR6TkdIVVdwbG9relY0UHhVdGd1KzNtcXRjNDZMbmdTVVlLd3VoeVRPbEhU?=
 =?utf-8?B?c0V0QnNzKzFCbmN2SUc0Y201bzczVjRYbmI3bzBFUHJ0S2VRYkxGb1lBTlN1?=
 =?utf-8?B?VmNLcllteXZOL3dGU0VoUXdVOGhUV0kzTTJzK3RkbE81V244QVFza29EYUhW?=
 =?utf-8?B?MnFjUS8vWnFqMUFkcEhmdEpvQ1NZRERYMU1Zazc3ZWQyalFJaU9ibkZDdFdt?=
 =?utf-8?B?cFp2QXY2aGhYSW5SZ1JwSlNudUxvUk9ueUxnZDVmcWpMWFJUVlJFNEUvNzFi?=
 =?utf-8?B?NWh5M1VVMnI2WjZ6eVoyalpSVWlxS2gxZE9wdUxhNXl6djNjUWtRc1doNVFw?=
 =?utf-8?B?SFpCaXZGelozRm5GL2ZYY3l3TjkvVXkyanVuaEU4VWxCWlgyVkhXZ1RvUkRp?=
 =?utf-8?B?MkIybjlEd0pwajBTeml6MGZZUkFUTzVmRTVSc3JLL3RwVUc2UjNLTTIrNTla?=
 =?utf-8?B?OCtLdzJKc1Y5NFE0NllqOUJNNlVVcHNtRjJJUjk3ZGdmYlpWYXhHOUVLUWRs?=
 =?utf-8?B?UUN5SGJVREV0MXhFeldNSDczUUlQcU9LVWFWQTlhVTFqaEhTdFZYTWxlbzhE?=
 =?utf-8?B?Y2VwQ3BtQmlnVFFIdTU5ZXBpbU1YZENnaGdoOFl6ZWN4RCt3TmNKNGxTSURC?=
 =?utf-8?B?aUVCWWFFZXlIWWdPa2VoRXgzZGo0ait3MEorZ1RWd2R2Sml5K0hlL2I5UEN0?=
 =?utf-8?B?S2w3ZGhMcU9hRkZvWGtRbVB4VGZrTjVMWThqRllOblVvMW80MHkxb00yVVhP?=
 =?utf-8?B?RmpCdXVLcHFnRSs5OHd3REVBclM4TmxoSTJyTHoxNzI0cWxkOTgzWDgyOUYx?=
 =?utf-8?B?a3JETXcybnVXT2t2VUNMbjRncmp3QWw0MEV5MTNKS0lNY1pzdzhKTWdhTkM5?=
 =?utf-8?B?VWNLYXlsbkJCQlp2WGNZZXovVXF3MUFWa3FLUWI0TXZwSVdxL2pIcmJUc2Fz?=
 =?utf-8?B?UU9kaEpjbWtEUGJicnFQRGlIQkhNbVVpajFXRnVvTXJjS1crZUVmaWFEbWNt?=
 =?utf-8?B?aHA5MzZ5MW5KUlFpVHNYMXRJNDhGN2o0YkcwMkk2c3VxVFUySnY5dXBKSmkw?=
 =?utf-8?B?ZGRzdTU4cjNXSUtFSm9pYjJ6dnJzYm5Qc1JzM2xSMzBySm9kaFY4MDlLNjFz?=
 =?utf-8?B?bnp2c253WHJpSW9lTDNNVTNrZXcwZnpld3hWL3JlTnFsNzlPamNsbjVkQmJ0?=
 =?utf-8?B?VElpZWxhVkRmRldZaE9ZQ3Z0NVVKSWNBbXhRWlZleUUzazlSSlZkdVVXRWZL?=
 =?utf-8?B?eFB4K2F0a3hmV3dLN3ZtVzVZclA1UnZYV1lHRnFuNSt1OTBMZU0xbng4aFF0?=
 =?utf-8?B?SVhuRlNUNUJGZnBmbVJJRWUzTWUwbVlZazVVLzdXN1REVlczZjZGVkZBV1dz?=
 =?utf-8?B?eE9uWk9vSWh2K01QdW1hQ0cyZFZrb3M4WVRXTisxeENId1N3TUJRYlZMV25p?=
 =?utf-8?B?a2JNQjdRVEU4eVpMRUcwWWJMODAxRGFsa0gvTmVKNy9iRFQ2NEpUT25uQ1F4?=
 =?utf-8?B?UStyckl0RUdONUI5aVRLNTZ0cmVlLzJtYzZEaVdmcnhFR3BlRnR4YWFxaURR?=
 =?utf-8?B?TGF6cGpFRzVUZDNkcklHR3hvejU5RkNIOEF3V21HbFIxOTQwVC9TMTIrVjBN?=
 =?utf-8?B?NFNwMll5YURZY3lrcVd3cHhzWCtPemRsY1ZJKzlFdm80ZWRueDNiV0F5VDZa?=
 =?utf-8?B?K2VzbDczUHBWYUhTdUVkVG44YnRSWmZ5QTN5SUJQU1pPM0lmdGlabHd5Uks1?=
 =?utf-8?B?bXQvOG1nRURrSGdpUnJkdVdsTmNjVS9yVzdxbGw2NDVWN2ZvS0wzNVdsc0FE?=
 =?utf-8?B?VUxrdEd2NjdBdnJ1MnVXWXZwVUZaZXRXR09GWjJZcXZuMXk0WXJTVTMrTGpK?=
 =?utf-8?B?aS9oRVFtR3Y0OGJ6bzY3eERza2pPV3R5LzBMMkhnTWJ1QnZDak5Pd0dkR2Ex?=
 =?utf-8?Q?trGOw5xouVKXxukp8DjsLK1uT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB9213B4C36FB41862BE6551B0885AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a81d819-43cd-49ad-2990-08dbb5043b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:23:18.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXHYL8yRKiYIiuBJfrklkMn8MgXLGbB3759Elk+Yzb4atoErUn1zqGiGGNoCjvifahD2QOK4YsN40BUOEfrI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBpZXJyZSwNCg0KPiANCj4gWWVzIHJpZ2h0IGluZGVlZCwNCj4gVGhpcyBoYXBwZW5zIHdo
ZW4gcHV0dGluZyBhIENQVSBvZmZsaW5lIChhcyB5b3UgbWVudGlvbmVkIGVhcmxpZXIsDQo+IHB1
dHRpbmcgYSBDUFUgb2ZmbGluZSBjbGVhcnMgdGhlIENQVSBpbiB0aGUgaWRsZV9jcHVzX21hc2sp
Lg0KPiANCj4gVGhlIGxvYWQgYmFsYW5jaW5nIHJlbGF0ZWQgdmFyaWFibGVzDQoNCmluY2x1ZGlu
Zz8NCg0KPiAgYXJlIHVudXNlZCBpZiBhIENQVSBoYXMgYSBOVUxMDQo+IHJxIGFzIGl0IGNhbm5v
dCBwdWxsIGFueSB0YXNrLiBJZGVhbGx5IHdlIHNob3VsZCBjbGVhciB0aGVtIG9uY2UsDQo+IHdo
ZW4gYXR0YWNoaW5nIGEgTlVMTCBzZCB0byB0aGUgQ1BVLg0KDQpUaGlzIHNvdW5kcyBnb29kIHRv
IG1lLiBCdXQgVEJILCBJIGRvbid0IGhhdmUgZW5vdWdoIGNvbmZpZGVuY2UgdG8gZG8NCnNvIGJl
Y2F1c2UgSSdtIG5vdCBjcnlzdGFsIGNsZWFyIGFib3V0IGhvdyB0aGVzZSB2YXJpYWJsZXMgYXJl
IHVzZWQuDQoNClNvbWUgcXVlc3Rpb25zIGFib3V0IHRoZSBjb2RlIGJlbG93Lg0KPiANCj4gVGhl
IGZvbGxvd2luZyBzbmlwcGVkIHNob3VsZCBkbyB0aGF0IGFuZCBzb2x2ZSB0aGUgaXNzdWUgeW91
DQo+IG1lbnRpb25lZDoNCj4gLS0tIHNuaXAgLS0tDQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc2No
ZWQvbm9oei5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQvbm9oei5oDQo+IEBAIC05LDgg
KzksMTAgQEANCj4gwqAgI2lmIGRlZmluZWQoQ09ORklHX1NNUCkgJiYgZGVmaW5lZChDT05GSUdf
Tk9fSFpfQ09NTU9OKQ0KPiDCoCBleHRlcm4gdm9pZCBub2h6X2JhbGFuY2VfZW50ZXJfaWRsZShp
bnQgY3B1KTsNCj4gwqAgZXh0ZXJuIGludCBnZXRfbm9oel90aW1lcl90YXJnZXQodm9pZCk7DQo+
ICtleHRlcm4gdm9pZCBub2h6X2NsZWFuX3NkX3N0YXRlKGludCBjcHUpOw0KPiDCoCAjZWxzZQ0K
PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgbm9oel9iYWxhbmNlX2VudGVyX2lkbGUoaW50IGNwdSkg
eyB9DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbm9oel9jbGVhbl9zZF9zdGF0ZShpbnQgY3B1KSB7
IH0NCj4gwqAgI2VuZGlmDQo+IMKgIA0KPiDCoCAjaWZkZWYgQ09ORklHX05PX0haX0NPTU1PTg0K
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4gaW5kZXggYjNlMjViZTU4ZTJiLi42ZmNhYmU1ZDA4ZjUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5l
bC9zY2hlZC9mYWlyLmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiBAQCAtMTE1MjUs
NiArMTE1MjUsOSBAQCB2b2lkIG5vaHpfYmFsYW5jZV9leGl0X2lkbGUoc3RydWN0IHJxICpycSkN
Cj4gwqAgew0KPiDCoMKgwqDCoMKgwqDCoMKgIFNDSEVEX1dBUk5fT04ocnEgIT0gdGhpc19ycSgp
KTsNCj4gwqAgDQo+ICvCoMKgwqDCoMKgwqAgaWYgKG9uX251bGxfZG9tYWluKHJxKSkNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGxpa2VseSghcnEtPm5vaHpfdGlja19zdG9wcGVkKSkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiANCmlmIHdlIGZvcmNlIGNsZWFyaW5nIHJxLT5u
b2h6X3RpY2tfc3RvcHBlZCB3aGVuIGRldGFjaGluZyBkb21haW4sIHdoeQ0KYm90aGVyIGFkZGlu
ZyB0aGUgZmlyc3QgY2hlY2s/DQoNCj4gwqAgDQo+IEBAIC0xMTU1MSw2ICsxMTU1NCwxNyBAQCBz
dGF0aWMgdm9pZCBzZXRfY3B1X3NkX3N0YXRlX2lkbGUoaW50IGNwdSkNCj4gwqDCoMKgwqDCoMKg
wqDCoCByY3VfcmVhZF91bmxvY2soKTsNCj4gwqAgfQ0KPiDCoCANCj4gK3ZvaWQgbm9oel9jbGVh
bl9zZF9zdGF0ZShpbnQgY3B1KSB7DQo+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHJxICpycSA9IGNw
dV9ycShjcHUpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgcnEtPm5vaHpfdGlja19zdG9wcGVkID0g
MDsNCj4gK8KgwqDCoMKgwqDCoCBpZiAoY3B1bWFza190ZXN0X2NwdShjcHUsIG5vaHouaWRsZV9j
cHVzX21hc2spKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdW1hc2tfY2xl
YXJfY3B1KGNwdSwgbm9oei5pZGxlX2NwdXNfbWFzayk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGF0b21pY19kZWMoJm5vaHoubnJfY3B1cyk7DQo+ICvCoMKgwqDCoMKgwqAgfQ0K
PiArwqDCoMKgwqDCoMKgIHNldF9jcHVfc2Rfc3RhdGVfaWRsZShjcHUpOw0KPiArfQ0KPiArDQoN
CmRldGFjaF9kZXN0cm95X2RvbWFpbnMNCgljcHVfYXR0YWNoX2RvbWFpbg0KCQl1cGRhdGVfdG9w
X2NhY2hlX2RvbWFpbg0KDQphcyB3ZSBjbGVhcnMgcGVyX2NwdShzZF9sbGMsIGNwdSkgZm9yIHRo
ZSBpc29sYXRlZCBjcHUgaW4NCmNwdV9hdHRhY2hfZG9tYWluKCksIHNldF9jcHVfc2Rfc3RhdGVf
aWRsZSgpIHNlZW1zIHRvIGJlIGEgbm8tb3AgaGVyZSwNCm5vPw0KDQp0aGFua3MsDQpydWkNCj4g
wqAgLyoNCj4gwqDCoCAqIFRoaXMgcm91dGluZSB3aWxsIHJlY29yZCB0aGF0IHRoZSBDUFUgaXMg
Z29pbmcgaWRsZSB3aXRoIHRpY2sNCj4gc3RvcHBlZC4NCj4gwqDCoCAqIFRoaXMgaW5mbyB3aWxs
IGJlIHVzZWQgaW4gcGVyZm9ybWluZyBpZGxlIGxvYWQgYmFsYW5jaW5nIGluIHRoZQ0KPiBmdXR1
cmUuDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYyBiL2tlcm5lbC9zY2hl
ZC90b3BvbG9neS5jDQo+IGluZGV4IGQzYTNiMjY0NmVjNC4uZDMxMTM3YjVmMGNlIDEwMDY0NA0K
PiAtLS0gYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvdG9w
b2xvZ3kuYw0KPiBAQCAtMjU4NCw4ICsyNTg0LDEwIEBAIHN0YXRpYyB2b2lkIGRldGFjaF9kZXN0
cm95X2RvbWFpbnMoY29uc3QNCj4gc3RydWN0IGNwdW1hc2sgKmNwdV9tYXApDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IHN0YXRpY19icmFuY2hfZGVjX2NwdXNsb2NrZWQo
JnNjaGVkX2FzeW1fY3B1Y2FwYWNpdHkpOw0KPiDCoCANCj4gwqDCoMKgwqDCoMKgwqDCoCByY3Vf
cmVhZF9sb2NrKCk7DQo+IC3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfY3B1KGksIGNwdV9tYXApDQo+
ICvCoMKgwqDCoMKgwqAgZm9yX2VhY2hfY3B1KGksIGNwdV9tYXApIHsNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X2F0dGFjaF9kb21haW4oTlVMTCwgJmRlZl9yb290X2Rv
bWFpbiwgaSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5vaHpfY2xlYW5fc2Rf
c3RhdGUoaSk7DQo+ICvCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgIHJjdV9yZWFk
X3VubG9jaygpOw0KPiDCoCB9DQo+IA0KPiAtLS0gc25pcCAtLS0NCj4gDQo+IFJlZ2FyZHMsDQo+
IFBpZXJyZQ0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIH0NCj4gPiA+
ID4gKw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiBUaGUgdGljayBpcyBzdGlsbCBzdG9wcGVkIGJ1dCBsb2FkIGNvdWxkIGhhdmUg
YmVlbg0KPiA+ID4gPiBhZGRlZCBpbiB0aGUNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBtZWFudGltZS4gV2Ugc2V0IHRoZSBub2h6Lmhhc19ibG9ja2VkIGZsYWcgdG8gdHJpZw0KPiA+
ID4gPiBhDQo+ID4gPiA+IGNoZWNrIG9mIHRoZQ0KPiA+ID4gPiBAQCAtMTE1ODUsMTAgKzExNjA5
LDYgQEAgdm9pZCBub2h6X2JhbGFuY2VfZW50ZXJfaWRsZShpbnQgY3B1KQ0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJxLT5ub2h6X3RpY2tfc3RvcHBlZCkNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPiA+ID4gLcKgwqDCoMKg
wqDCoCAvKiBJZiB3ZSdyZSBhIGNvbXBsZXRlbHkgaXNvbGF0ZWQgQ1BVLCB3ZSBkb24ndCBwbGF5
Og0KPiA+ID4gPiAqLw0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgIGlmIChvbl9udWxsX2RvbWFpbihy
cSkpDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiA+
ID4gLQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcnEtPm5vaHpfdGlja19zdG9wcGVkID0g
MTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGNwdW1hc2tfc2V0X2NwdShjcHUsIG5vaHou
aWRsZV9jcHVzX21hc2spOw0KPiA+ID4gPiANCj4gPiA+ID4gT3RoZXJ3aXNlIEkgY291bGQgcmVw
cm9kdWNlIHRoZSBpc3N1ZSBhbmQgdGhlIHBhdGNoIHdhcyBzb2x2aW5nDQo+ID4gPiA+IGl0LA0K
PiA+ID4gPiBzbzoNCj4gPiA+ID4gVGVzdGVkLWJ5OiBQaWVycmUgR29uZG9pcyA8cGllcnJlLmdv
bmRvaXNAYXJtLmNvbT4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHRlc3RpbmcsIHJlYWxseSBhcHBy
ZWNpYXRlZCENCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBBbHNvLCB5b3VyIHBhdGNoIGRvZXNuJ3QgYWltIHRvIHNvbHZlIHRoYXQsIGJ1
dCBJIHRoaW5rIHRoZXJlDQo+ID4gPiA+IGlzIGFuDQo+ID4gPiA+IGlzc3VlDQo+ID4gPiA+IHdo
ZW4gdXBkYXRpbmcgY3B1c2V0LmNwdXMgd2hlbiBhbiBpc29sYXRlZCBwYXJ0aXRpb24gd2FzDQo+
ID4gPiA+IGFscmVhZHkNCj4gPiA+ID4gY3JlYXRlZDoNCj4gPiA+ID4gDQo+ID4gPiA+IC8vIENy
ZWF0ZSBhbiBpc29sYXRlZCBwYXJ0aXRpb24gY29udGFpbmluZyBDUFUwDQo+ID4gPiA+ICMgbWtk
aXIgY2dyb3VwDQo+ID4gPiA+ICMgbW91bnQgLXQgY2dyb3VwMiBub25lIGNncm91cC8NCj4gPiA+
ID4gIyBta2RpciBjZ3JvdXAvVGVzdGluZw0KPiA+ID4gPiAjIGVjaG8gIitjcHVzZXQiID4gY2dy
b3VwL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wNCj4gPiA+ID4gIyBlY2hvICIrY3B1c2V0IiA+IGNn
cm91cC9UZXN0aW5nL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wNCj4gPiA+ID4gIyBlY2hvIDAgPiBj
Z3JvdXAvVGVzdGluZy9jcHVzZXQuY3B1cw0KPiA+ID4gPiAjIGVjaG8gaXNvbGF0ZWQgPiBjZ3Jv
dXAvVGVzdGluZy9jcHVzZXQuY3B1cy5wYXJ0aXRpb24NCj4gPiA+ID4gDQo+ID4gPiA+IC8vIENQ
VTAncyBzY2hlZCBkb21haW4gaXMgZGV0YWNoZWQ6DQo+ID4gPiA+ICMgbHMgL3N5cy9rZXJuZWwv
ZGVidWcvc2NoZWQvZG9tYWlucy9jcHUwLw0KPiA+ID4gPiAjIGxzIC9zeXMva2VybmVsL2RlYnVn
L3NjaGVkL2RvbWFpbnMvY3B1MS8NCj4gPiA+ID4gZG9tYWluMMKgIGRvbWFpbjENCj4gPiA+ID4g
DQo+ID4gPiA+IC8vIENoYW5nZSB0aGUgaXNvbGF0ZWQgcGFydGl0aW9uIHRvIGJlIENQVTENCj4g
PiA+ID4gIyBlY2hvIDEgPiBjZ3JvdXAvVGVzdGluZy9jcHVzZXQuY3B1cw0KPiA+ID4gPiANCj4g
PiA+ID4gLy8gQ1BVWzAtMV0gc2NoZWQgZG9tYWlucyBhcmUgbm90IHVwZGF0ZWQ6DQo+ID4gPiA+
ICMgbHMgL3N5cy9rZXJuZWwvZGVidWcvc2NoZWQvZG9tYWlucy9jcHUwLw0KPiA+ID4gPiAjIGxz
IC9zeXMva2VybmVsL2RlYnVnL3NjaGVkL2RvbWFpbnMvY3B1MS8NCj4gPiA+ID4gZG9tYWluMMKg
IGRvbWFpbjENCj4gPiA+ID4gDQo+ID4gSW50ZXJlc3RpbmcuIExldCBtZSBjaGVjayBhbmQgZ2V0
IGJhY2sgdG8geW91IGxhdGVyIG9uIHRoaXMuIDopDQo+ID4gDQo+ID4gdGhhbmtzLA0KPiA+IHJ1
aQ0KDQo=
