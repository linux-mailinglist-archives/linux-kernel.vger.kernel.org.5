Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7EF76F5CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjHCWlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:41:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77F1722
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691102501; x=1722638501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+/myChg0G/Ngn9VKCrMTNcq1bCGSl54PnDNdYJWVBKU=;
  b=C+ouNjy7XeML4I35BOq7kr0Dqg5BhyuEc9Oj8RO8DufnJC5cAdaJGRYn
   R/flz4oI5pV8huJkeB7rVxC64ZtMZFuUKhm/NRTrAojSuZTqeB6axinJz
   vFtXZroDzNWf4F9NCG78bXg4q9Ckr9kqBo3ErEoFr4ZyVBfI/6zs4C7nm
   I44vksuqJVNVgIb0awcESw5Yef9fZdTXSDNkyAjbHX1pp2vU/9Q24cI6f
   SZK42L40E9ZknlBoLPP/Lfc9DMtnF78GxkhGwTvFCRA6L/kuevkU7DFfO
   LxZ0GOuDExERidjskmJwxNQE9AenEloiKE4zCHTV02xeQifVZwBnlFtr/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349603886"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="349603886"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764857189"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="764857189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 15:41:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 15:41:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 15:41:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 15:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISXStttWv3Yxb3dUQTG4dMAibtTrxpLklHGmoV6urJuU6PyTTyNxy6D8WqT/rlzBF3/NwA0Pa8GX+0dVDud4Szw+bKC8BbrEd2eDdSu6qy9rivgUcDbFPidAwtJnp4NhmEhJeiXRpT9lpEpf6iO8uAPFMykYu4kO8hg4m2OiBXHfPdWoQAENT4MRJCW6MmRMhjIQ70NzNJNYMJMkrcCIjcAadZnDMqNCFAOY7U6PS1eRxr39sFftGoghvsBWT3sTHhgzhR26oP9Sb3VkQS1OHyY2TWP4uYk5H7Q6zuyufzD/CafB2AIQNzyMhPUCIIFvZbLTLF7lf/WrOUpwZhhrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/myChg0G/Ngn9VKCrMTNcq1bCGSl54PnDNdYJWVBKU=;
 b=oKKVc6EvQB8KvkulopCuJCJkVZiB2OSkHEFdpJ8lz88d/T3JdwX2yovZ2znJnKyA7yviv3Lnwh/f0UQH34ZKN/P2HFwCz6H1lvAmPOK1iAXV2spWkmKpQoW1KXDgCELHCZGkR/UwNzM9qhO+sACXTf66hXb1JPQi5J5Po8bb4DsfaFq/NosFTrAkQO8qUTnoG2hEg+YVMh52a61aj7ehzXwc2XjopYWRe5T3Mr761tGrCVWU8mt489GAFwO+08sXAtL3cPpeKuis0+m0seJuiW4webUY3IFaNV2ht+MbDdJ7+VCILNnVSTltNTyDsJUi4aBER0peecUbRdr1O2wavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 22:41:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 22:41:37 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZv7Ew9wXfCjaIFkeFM7YTTvK7Ya/N2wEAgABjTACACkJlAIAAAwkAgAAEVICAAAgsAIAAEnSAgACVPQA=
Date:   Thu, 3 Aug 2023 22:41:37 +0000
Message-ID: <876132ef9ab580a30b6799841f4606098eda92a0.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
         <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
         <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
         <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
         <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
         <20230803121207.krvcuj22mdxhugog@box.shutemov.name>
         <ce045f6ccf9451d177581280c35092de7bd71488.camel@intel.com>
         <20230803134725.eq4uliddd7rlu3ac@box>
In-Reply-To: <20230803134725.eq4uliddd7rlu3ac@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB8168:EE_
x-ms-office365-filtering-correlation-id: 1974e2c5-4e20-4776-48f1-08db9472cbe2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNEJZF1sC61g5AxXl+vB2ZYRp48JJQ6LQHh61rvngLOYjQgqVM2iUs06QFFoTisNYJzWM4CTGXwL+ChD8v5he6VVIngv4Io7rwtdRD6yR2sVHiVeAKGRQWR7bypGFvxTcbPXzoj58bvD+eRexl18lqAWrRoPAoE2rhJFSIJXWngzgjT26QWZrPcVyIfO0+lFXbxnKpvvJwr1xhuYs346uxSdttRIbIWhIsoaeOzTh64+SIrgsV8+z/my8GuSaLRZQfoGahp40B91l5RIoWdUZV9Tnh+klzBuhswFBNP0BYq9hWvo3ekQ2KfgSJe7/EXN9cTH6xHijzLmob7KSPv5IYRBCdM4yo/w4xix8td59bMlxdUh1ZLvRB76s8XM093yeTcGUlZhU29orbRbCEWuN5eppmlLiuVOoVzE3UjV09ktSG35Vw828FJuKyAaFe+ULg4Xnq7poOrVqKRxYYP0Oz0vVYFy0cQPZfTlvolS+9cu43oqcuygpAFhm1dgAS8MbtbnT54E8ZxUPZXJtlUqx/jBZfVshm/Otszu3YHxW5zFFszi4sMagU5pB+kB5P5uCS2I0/y01ksg7Mj/X+idl8/ROGvLz5kakOGRh2n+Tcn0wDtb2kE8oDPA7ZriHhpP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(186006)(2616005)(8676002)(26005)(6506007)(66556008)(2906002)(91956017)(76116006)(4326008)(66946007)(5660300002)(64756008)(6916009)(316002)(66476007)(66446008)(7416002)(6486002)(71200400001)(6512007)(478600001)(54906003)(38100700002)(82960400001)(122000001)(8936002)(86362001)(36756003)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZS9FWW5RdjljWnZ1eXVObFlrdmgrK2dxZjBwcUxidkV1RjZEbkhOT0MvT011?=
 =?utf-8?B?ZGxxTTN0U1FNK0NmWVJ5bEREbkQ0TktFQWRaVlJKN1dWMXVlNEZrN0xSMXdZ?=
 =?utf-8?B?SDlXelFCZmFwdEhVZEhqTUVJMm5scmgwV2t4bVA4ejgwYTFiQ1J2Vm9jdm8z?=
 =?utf-8?B?OFFvMlFLNUlVQkRGdlJBSkVDWmxNbHNFb3o5VS81Zi8xbkczM3hRRnBQVmlJ?=
 =?utf-8?B?L1NTMmY3TFMzOVVBNFI3aWJpeVhoN3R2VTBweUdDRExIUFV2RkNWajhYU2hM?=
 =?utf-8?B?UE40cmllZG8vT2FGQ3hkQldMU0FTTkc4QUhsd1lidDQ4MXAxOWZYeHhmcUJt?=
 =?utf-8?B?bWVKTEVoWFJ1QXFZSE5maEMxVlhaOVBxN3VpMENFN3BUc1ppVzhJdm1CaWw1?=
 =?utf-8?B?bFkzc0FrUFV1b2RzNzJtUjZuZ0NtNlFVL1dDZGQrMXNOeHhPdFFRUDJvNHZk?=
 =?utf-8?B?eHIraWFaUkpTN0dBYU9JdzVRS053c21qNS85aU1mdExJc05GRUdOdWVrRzkx?=
 =?utf-8?B?a3hSUzd5ZndNVUgvbUEyc0JXQ0JEZEsvRGNOLzZwNDd5bmI3clJzUUcrWDBm?=
 =?utf-8?B?dklMVVRBOWhRNmV2dTl1dUFpdnJjVjkwcVFIS3oza2ZwMndvWHZMMUE3VEJN?=
 =?utf-8?B?YkVXcTNoMW5VaFFFVTlzRWE1WDBoaUhZUjNqN1IrQVdyb3ZvRXNpZXJzL3Iy?=
 =?utf-8?B?WlVmeS9Ja0k0RVB6KzBFUmtRalhaMmtRaktYd2FtamsvN1p6ajQzQXhWMzY5?=
 =?utf-8?B?dmNORDhma2VITkN3cFdUOWRiZVRLK1pWREJ5YnR5ZlRKNit2cFhYMGVhM1Zi?=
 =?utf-8?B?ek43eGRheEF2TEk1MmVKNE9GSEY1M1NoSzROUC9BSWVlV3htbHJoR0o2TWYy?=
 =?utf-8?B?SGNqelBHaEtLSmZKeVlEaGVyeldxRFZ5WlZhVUQ0QzhZclJhVFJSQzBrOHFp?=
 =?utf-8?B?RVV3RHJjZGFoSEp6a1lEMHB2cndVUCt6dHpHaEJBeWpTZnNGZDZZcUkxU2ZV?=
 =?utf-8?B?Nmc4VU9MUnhXbksvdEZacm82ejY5TXVXTnhZSnlGNU1vMTlyaDZGWkJ1aWky?=
 =?utf-8?B?YVduc01TVXdqVFZnaUlpODlyZlZnanpVTHRmdHhRT090RFhNa1B0aFdObE90?=
 =?utf-8?B?OE5MaXlET0dMbFJHZDRMQVErUHYrc2tPQ3BpZzVyb2VpZkk3K3JrdGZGODhV?=
 =?utf-8?B?aTdDd1J4YTJHdUNCdWpuSjhIK2FQd24wOE8zaWhlNElTeVdBRWdhOWU0SGs3?=
 =?utf-8?B?T0tzcWpBR3RNSzE1d0pESHZIcU5Ba0JOWEhyVU5BNURoQUo1dWJJMW84T09t?=
 =?utf-8?B?SGRYWTZRbTVXT0NaV2hXeWFXYkI2RWdKdmxrN3d5NGxXN3k0dlFXUmUzamJQ?=
 =?utf-8?B?UFZSWCtBbUd6MmRSK0VvQ1RWR3k1eER5eG9nSzJmUXVJeml4R0JRN2RKaFFH?=
 =?utf-8?B?aWxRd0NFaStMdGtnS1dVd1ZiN3hSVjVRbTZ1UlZhS0xySGtGRUdxNW5FV2NV?=
 =?utf-8?B?YkFUWG9DaS9ORzRKRDc3Y2ZBdUpqUno3SHVMRGV1c0p1ZWxXdFRhUGZaQ3hZ?=
 =?utf-8?B?cmR1ajBYVWhRUTVmUjdweGRLMU9VME8xdGJadytodHFrSnBoeHhBdVlxb1lk?=
 =?utf-8?B?dmFoeGMzT2czZjZvYURxWmdsblMzZE1ueTZ3N3VjaDI2M1lIN1hkdkVEKzJw?=
 =?utf-8?B?ZUZCYWhFYTVsa29UOFVEUkIyN1V0ZlZVeXp2UG5CcWVmSkYrempyMlh1WVpo?=
 =?utf-8?B?cXdzS3huRFRZUldMei8ybENhampkYzJ6cTZxWVhaL1JVV0g4R1RWSGVvWVl4?=
 =?utf-8?B?UHRKSnpXeWtvb3NYVXJhSEI2ZGdtMnc1Y0VoMUZ0cm5idDhWRWdkeXJEV3c5?=
 =?utf-8?B?aUZLd1hUYVdhNUNpdno3anZiVXpUWGFwai9OSUpJNStseHg5SE16WThIN0x4?=
 =?utf-8?B?R1plRjQyR2lmNkE3cEZyMkJsZlhGK2RnZjl2ZjRkMXZNeExCbXhVcmJ3L3BR?=
 =?utf-8?B?amhyUkdrNFlpdnNnUFJSaEdVZ0RVV1ZWNStBVE8zYnpyWmRPdFNRRFFBZjVv?=
 =?utf-8?B?ZlRkWEZKOEFKak1qNU9IMitIZmpWemorWlBKY1h4cG9kUWN4NGJLMHR1cGRi?=
 =?utf-8?B?aUNDS08yTCtiQnlpWkNtNWo5S2pDRllwUnZWdC9QNUplQzNCM2UvN3p0ZDBi?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D06A379802D53343959AEA2165843C2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1974e2c5-4e20-4776-48f1-08db9472cbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 22:41:37.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ePR9Nc7TQJJubUX8gdm8NGRA4+9mSbSIYYYCzvjvFxabWAR8YTA6OMym0fuIRYu9KI+5YNhAOCEZWTmoxeM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDE2OjQ3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAwMywgMjAyMyBhdCAxMjo0MToyNVBNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wOC0wMyBhdCAxNToxMiAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+IE9uIFRo
dSwgQXVnIDAzLCAyMDIzIGF0IDExOjU2OjQwQU0gKzAwMDAsIEh1YW5nLCBLYWkgd3JvdGU6DQo+
ID4gPiA+IE9uIFRodSwgMjAyMy0wOC0wMyBhdCAxNDo0NSArMDMwMCwga2lyaWxsLnNodXRlbW92
QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSSB3b3VsZCByYXRoZXIga2Vl
cCB0aGUgc3RydWN0DQo+ID4gPiA+ID4gPiA+IHJlYWQtb25seSB3aGVyZSBwb3NzaWJsZS4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdlIGNhbiBhY2hpZXZlIHRo
aXMgaWYgdGhlcmUncyBhIGNsZWFuIHdheSB0byBkbywgYnV0IEkgZG9uJ3Qgc2VlIHRoYXQuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gS2VlcCBfcmV0KCkgYW5kIG5vbi1fcmV0KCkgdmVyc2lvbnM/
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyB0aGUgYXNzZW1ibHkgbmVlZHMgdG8g
YWx3YXlzIHR1cm4gb24gdGhlICJccmV0IiBzbyB0aGF0IHRoZSBSMTANCj4gPiA+ID4gKHVzZWQg
YXMgVlAuVk1DQUxMIGxlYWYgcmV0dXJuIGNvZGUpIGNhbiBiZSBzYXZlZCB0byB0aGUgc3RydWN0
dXJlLiAgT3RoZXJ3aXNlDQo+ID4gPiA+IHdlIGFyZSBub3QgYWJsZSB0byByZXR1cm4gVlAuVk1D
QUxMIGxlYWYgcmV0dXJuIGNvZGUuDQo+ID4gPiANCj4gPiA+IFllYWguIFRoaXMgaXMgZG93bnNp
ZGUgb2Ygc2luZ2xlIGFzc2VtYmx5IG1hY3JvIGZvciBhbGwgY2FsbHMuDQo+ID4gPiANCj4gPiA+
IE9uZSBwb3NzaWJsZSB3YXkgaXMgdG8gbWFrZSBpdCBpbiBDOiBub24tX3JldCgpIHZlcnNpb24g
cGFzcyB0byB0aGUNCj4gPiA+IGFzc2VtYmx5IGhlbHBlciBjb3B5IG9mIHRoZSBjYWxsZXIncyBz
dHJ1Y3QsIGtlZXBpbmcgb3JpZ2luYWwgaW50YWN0Lg0KPiA+ID4gQnV0LCB5ZWFoLCBpdCBpcyB1
Z2x5Lg0KPiA+ID4gDQo+ID4gDQo+ID4gWW91IHN1cmUgeW91IHdhbnQgdG8gZG8gdGhpcz8gOi0p
DQo+IA0KPiBObywgSSBhbSBub3QuDQo+IA0KPiBNYXliZSBzb21lYm9keSBlbHNlIGhhcyBiZXR0
ZXIgaWRlYXMuDQo+IA0KDQpBbnl3YXkgdGhhbmtzIGZvciBmZWVkYmFjay4gIFNvIEkgZG9uJ3Qg
c2VlIHRoZXJlJ3MgYW55IHJlYWwgcHJvYmxlbSB3aXRoIHRoaXMNCnBhdGNoLCB0aHVzIEkgd2ls
bCBqdXN0IGtlZXAgdGhlIGN1cnJlbnQgd2F5Lg0K
