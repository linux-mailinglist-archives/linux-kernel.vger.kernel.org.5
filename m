Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC479C1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjILB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjILB1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:27:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4361B880A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481138; x=1726017138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dk2Rl1BEUChhta0VTIXu8SeFdt4K0fVhLR51ULaN6ao=;
  b=lwzF9dizh/mCRAprvKIoMH+Uez6Dg8T8Dr1W67cP96o4uXWz85P2E5sK
   sqKKDNgO7byhNW6jheT2uPV985iEMeErJdu3j11Oqz2hgyTPeb5e6Udxr
   gB86iT0Qh1kQinCf+HqZxrLvxKuBXmtr7S/PNiT3UJiyfIrSAaSBKaFs9
   ck5prlVKkDGCNniZfrkZ/f/K/VGg8Gaqk2LxvlCQ9aOLCqpnSu/oNq7RG
   a9xUqRCmdDWzaKrfXTFH2iyMKNSm1j4sUaI8t7BN8/zXym3aPCJk2nIHJ
   9UoI8jaD0J50U4Jc2Yy/b1TQl4FSTXkQCKEe3cPJRDyeu5D4a3KtL/eC3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464614304"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="464614304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867157016"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="867157016"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 17:57:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 17:57:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 17:57:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 17:57:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvPs0lyi1kQlsvY3nBvCbwwq5BmarnbZ3Ur+nyvnB4A/mkFh/okmLwCbIAoC3DPzKmBy1uGq8aZiaaeRe7nZsL2HB/Ox5ujgN4+/YQG8qJc7TxziVE75sFr+odPtFpwXVYu1aicpVUzDT3g0/zgxtRYPXuUv9ojZG3ozFDJziO3fGC9h9nszmqZOBTinro/iJZC8UQzlDIYy1Pczqy8WfMG7jwSugSwm/cpNfCatuebN27PNQYwj5QxO6zJfYntu1z2G2Mv829GlwmXLoEz4y+BAWKa/Y1zNhxis7RzyPyBfDHyFkW3tw5sDYy9Lfwa5StSGGLwXYr66vIqbIxxz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk2Rl1BEUChhta0VTIXu8SeFdt4K0fVhLR51ULaN6ao=;
 b=QIQG0RcGF1dUlPBtaIpu5lWOOrWt9It09wmJkT8oshwKkW+bPR0Q4Oy24mRjIXTn83u10k0bnNy/kzJfsc8JgjYRJzU2z4ujD+5VSUbRz7ndl9xTa3+9gWEYt05pOd65QeYzDFP1nVFgVcrGT01QsFwbfox4pVZ078XdKkqsbRKaUqeRyeRG0L8oOcLDS0AYB8lfZAGQ48grwXtMkyP2h7GIYrzCjhILbk6GVj0fvBIYWD7Keyb+RTtTKGyZs5h6UpTlPPEotVKlVe0uJnJYbni/8NIIT3juS0kVkZrTU/yscxEbH2Z8Ho/oxtv6i6uZRuNtoZ7D7PiN2Fs6e3nMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 00:57:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:57:01 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: RE: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZz2d2h64fZccrFk6GvcmTUnLRhLAWBmaAgABZxgCAACcRkA==
Date:   Tue, 12 Sep 2023 00:57:01 +0000
Message-ID: <BL1PR11MB5978F08618A3E2389618F33CF7F1A@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
 <f94aa81502421f169806c1349efb28c74878ea46.camel@intel.com>
In-Reply-To: <f94aa81502421f169806c1349efb28c74878ea46.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6262:EE_
x-ms-office365-filtering-correlation-id: 0c8250da-e1dd-4878-eb74-08dbb32b2c82
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J61qeaTaFnT8bfB+9I/CJzHXeWlishkHCEQjByoWHyu2SGN6ptR/ZgIdVRuzASIqnx8XqVt5R6z/RGNMOfdLXEj/TawbACflhPWKLjQKF1iPnUMJxqQorEEjG/OS26WwIphZBTINEttmg76zKC6qWeQTTXrZB8LfgL/yVT8H/sjC7qtt5t458fvdM3ctvAm0/S1HTGCE/y+sS7S9ErIykO75wwrPi+1ORUbP6osR/lb0dqfRowh6dLne/IblK9fY38aqtydzHjl/rfoPDr8bid6MGg+jOQ5CVUBEO8MmtmpH+w+IhD/2FUcyOYAVMwC+QPgYsyPvoNO5RAhtb0q84eK/IhoFv5hELNreGHpwkAkvzEYTND51B58jbGhT7+/y89hoYQBBcawpSVOtYT5ASnofpX/R2cVlNzttrxq8EOpezq2BpTjTOHwOlM310wUBApsidthpQhE0f1UI5XfBQvlHQWVFzBnGyPx+37NrsPaJ5UHwWGaW/RCsEE+rrBs6mj026Q3uVYHfY8oimvC5+fzPKgc/+E4Xt+QOqh5/pjX8gW/012OtBOcI1iCUnHa7zfLFzk7+D5IJFXOhhY8jtfCn9bOoyshIAzWqo3kYn3htfQukh+UTEt5h3+6Tf1eN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(64756008)(76116006)(66446008)(66476007)(66556008)(110136005)(6506007)(7696005)(53546011)(478600001)(9686003)(316002)(71200400001)(45080400002)(41300700001)(4326008)(8936002)(8676002)(26005)(86362001)(52536014)(5660300002)(122000001)(82960400001)(38070700005)(38100700002)(55016003)(33656002)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkZJK1RSTDBSZ21MZityTTNycDl5TytPWUs0NmtjaEg4eG9sak9zbldXRUxV?=
 =?utf-8?B?VlF0Z0tTc1RKcXpzQytvSG9vUnNNTkI3cW1aSE1IVmVpUXdwM2pyVzZOeGh2?=
 =?utf-8?B?VzlsRmJ3MlZYa0xZL29qS0ZqckdLQ0JMZks0aWhGK2RKNXJPc3ZXUGZmOURx?=
 =?utf-8?B?NzNNTGRmQjNIczRBczZpc2xDV2xoVGRXWUNVYktaaXlqbFU1bGxRMWI1REFK?=
 =?utf-8?B?T21YdjJZNXM4YUpQa2F6MUhQZk5reGIvWEdkQTNtc0NHNGZWU2M1NmVUcmZ5?=
 =?utf-8?B?SCtURmsvNVhKQTN2Q255blorYjZFT054ZkhVQTVzTU84TUxXSE1WaGtOVkhr?=
 =?utf-8?B?RjFJQkxNb2lpWWg0KzUyUHRYRWxkWlM5YXJOS3Y4WXM2ek9lbmN0NjYrVklV?=
 =?utf-8?B?Ymkvd0J3UGdCYlFlYTdoNTR6NHNLajkvbjNvQWNydCt2R3ZVVXpqUjgrZWRU?=
 =?utf-8?B?dEcybFNqbWtoTFdPY2VBYWxtR1kyVWxyeTg1NldIOUF2anpyMThkZ0k2bTYz?=
 =?utf-8?B?OE5iRzB5Vk1CVjQ2cFJuV00xdFdZV2xpejIrdkVtNXkxeGwySHJvS1paYWJp?=
 =?utf-8?B?UDBHUDl1OGM1ckdBcjN1c2tNMjhiYjkySEd6VG8vUTFMa2lRS1ArSnFXa0dy?=
 =?utf-8?B?V1IwWHFFL2QyRlJkOTJuYUJnZER5K1BHcUhWYlBPM1ZWQjEvSzRYTXIyK2tX?=
 =?utf-8?B?V0JnWFNHeXo1UGJZOERUSHdFMkJUU0Q1MVQyWVlleGVPSTdmMDVQdEJ3TTMw?=
 =?utf-8?B?SmZuQUc1bDFGVXp6NWw0bWdySmlaRm5UWTZ5OUpmeEJ6dHIyWWhFT05obUt6?=
 =?utf-8?B?ak4vSGlWekRlNENveU5YSDhGbXBYYkpJY0pKL0hFbnFFTWdrTFI5eDhXSGxI?=
 =?utf-8?B?VTJENFk1U0FSaDV1SXAwVTRFSXY2eUFkeTkwaUhiUG5ZQmpsTXFBbmFDTHFX?=
 =?utf-8?B?ZVdCV2pXT3daMlZNV2dDR2RGclo4UXNnVjZ6YUJ5MVA2UENEb2ppUlBqMlBS?=
 =?utf-8?B?WGo2NlFUZ1gvdC9CWGc3dWticWdsUklsT1JiVWtVaTZ5RmRMc0d2RHNXU2o1?=
 =?utf-8?B?L0ZNWWh4Z3lqMVV3eUJNV1IyQVF4MXdONjBvWllQa0FmNmMvY0JRSU5jdDFC?=
 =?utf-8?B?SFlpVk55RXlTU2NmVU80SEkyYXV1VGRHMVlQZmhFUVVCT1ZDQmhSdmtXODBj?=
 =?utf-8?B?Umh3VThPb2x6UkJ6VmFtTmRWM2lZcjhUU0czOHBDajRnTWxNaFVYbmdsNDFN?=
 =?utf-8?B?NVpnV0hKQUdyNkVxYzNQeWtUQVJTbW5PMTV6S3RnV2xxWVJkaE5mS2FkSjR4?=
 =?utf-8?B?UXBWblQvSGNuMW1lRUJieXU4aDBkMyt3dWxORHg0eVg4bUtkQVY4NnlTZmNH?=
 =?utf-8?B?cGlPa1hhZ1BHM29zd0RxNjBEUzhSbVArK1FMS1VOS1ZySHM3aHozUmFsODBQ?=
 =?utf-8?B?aTRMb0FXN3dnZUdFUkZzZXJCQUFNcFl1QUQ0azhwdmg4Mm5FWWhDTm44TkVJ?=
 =?utf-8?B?bGp1M2Fvb0gxVXBnN1FmYURqMlBBZWF0Y0hodytEQ0dTQkIwazFkQnRvc3BZ?=
 =?utf-8?B?VTFYblBLdUtlelg3aWdzUHc2YW9iRjFveVVjWHFYU1hDQVVrQ1hONmJEMG5Q?=
 =?utf-8?B?dmszbEg0emlHSmhKaVdTVXpieWFRQkNVNGloQkJBQkFTRDZhdm9icHJXZkNP?=
 =?utf-8?B?OHJvR2pWMldPZHE5ejJOTjBwamlqNkFFaU01eDBxVWRhakxmNzNuLzdaK0hB?=
 =?utf-8?B?a0Z0dXRKSmx5VkZkWjVyL09RWS9POC9SelNUZkJvcjg0Q2p6MlFTV1diWlpk?=
 =?utf-8?B?eHAxRFoxRUtmMTNteXFhak1CeVhDY3N5RGdKMTgxM1h1Z1hIN0hOR2dPZjdY?=
 =?utf-8?B?ajIrT2xxK25UTDA3anNpZjFlSkRibEpyM0NtMEVMVVljc21GYjU2V3hkaS95?=
 =?utf-8?B?RFVjSHNaTDIyNzd6MWRLNmJLc0RUOTZNV2RqV0RWMzVoc0ltOVdING1DY0gx?=
 =?utf-8?B?TGxGU0FrOXJ0a1NaYmc3NG9zZzlzczBrN3E5ZitSaGFSR09MMnp6MnhyOUNN?=
 =?utf-8?B?RlEyQVVwSFlZc0NENHQxWENMS3ZBUC96VnVIck51enRmTTBWSWp1MG5oUHZJ?=
 =?utf-8?Q?wMi61LNmQ0kJZBRKjyPoQVvv9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8250da-e1dd-4878-eb74-08dbb32b2c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 00:57:01.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QENd8BGMbkEL10d7gwBYYAqrf8hsyDW6FErZ1lJ7UEa7/JFwtUHqVDCO7Zx2AS6WTxIs5S5dP60///qH/A8VEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSHVhbmcsIEthaSA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDIzIDEw
OjMwIEFNDQo+IFRvOiBraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tOyBwZXRlcnpAaW5m
cmFkZWFkLm9yZzsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBDaHJp
c3RvcGhlcnNvbiwsIFNlYW4NCj4gPHNlYW5qY0Bnb29nbGUuY29tPjsgYnBAYWxpZW44LmRlOyB4
ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsNCj4gbWluZ29AcmVkaGF0LmNvbTsgdGdseEBs
aW51dHJvbml4LmRlOw0KPiBzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5j
b207IFlhbWFoYXRhLCBJc2FrdQ0KPiA8aXNha3UueWFtYWhhdGFAaW50ZWwuY29tPjsgbi5ib3Jp
c292LmxrbWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvMTJdIFVuaWZ5
IFREQ0FMTC9TRUFNQ0FMTCBhbmQgVERWTUNBTEwNCj4gYXNzZW1ibHkNCj4gDQo+IE9uIE1vbiwg
MjAyMy0wOS0xMSBhdCAxOTowOCArMDIwMCwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gPiBPbiA4
LzE1LzIzIDEzOjAxLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiBIaSBQZXRlciwgS2lyaWxsLA0K
PiA+ID4NCj4gPiA+IFRoaXMgc2VyaWVzIHVuaWZpZXMgdGhlIGFzc2VtYmx5IGNvZGUgZm9yIFRE
Q0FMTC9TRUFNQ0FMTCBhbmQgVERWTUNBTEwuDQo+ID4gPiBOb3cgYWxsIG9mIHRoZW0gdXNlIG9u
ZSBzaW5nZSBURFhfTU9EVUxFX0NBTEwgYXNtIG1hY3JvLiAgTW9yZQ0KPiA+ID4gaW5mb3JtYXRp
b24gcGxlYXNlIHNlZSBjb3ZlciBsZXR0ZXIgb2YgdjIgKHNlZSBsaW5rIGJlbG93KS4NCj4gPiA+
DQo+ID4gPiBUZXN0ZWQgYnkgYm9vdGluZyBURFggZ3Vlc3QsIGluaXRpYWxpemluZyBURFggbW9k
dWxlLCBhbmQgcnVubmluZw0KPiA+ID4gVERYIGd1ZXN0IHN1Y2Nlc3NmdWxseSwgYWxsIHdpdGgg
dGhpcyBzZXJpZXMgYXBwbGllZC4NCj4gPg0KPiA+IE5vdCBzdXJlIGl0IGlmJ3MgbmV3IGluIHRo
aXMgdmVyc2lvbiBidXQgSSdtIHNlZWluZw0KPiA+DQo+ID4gICAgICBXQVJOSU5HOiBtb2Rwb3N0
OiBFWFBPUlQgc3ltYm9sICJfX3NlYW1jYWxsX3JldCIgW3ZtbGludXhdIHZlcnNpb24gLi4uDQo+
ID4gICAgICBJcyAiX19zZWFtY2FsbF9yZXQiIHByb3RvdHlwZWQgaW4gPGFzbS9hc20tcHJvdG90
eXBlcy5oPj8NCj4gPiAgICAgIFdBUk5JTkc6IG1vZHBvc3Q6IEVYUE9SVCBzeW1ib2wgIl9fc2Vh
bWNhbGwiIFt2bWxpbnV4XSB2ZXJzaW9uIC4uLg0KPiA+ICAgICAgSXMgIl9fc2VhbWNhbGwiIHBy
b3RvdHlwZWQgaW4gPGFzbS9hc20tcHJvdG90eXBlcy5oPj8NCj4gPiAgICAgIFdBUk5JTkc6IG1v
ZHBvc3Q6IEVYUE9SVCBzeW1ib2wgIl9fc2VhbWNhbGxfc2F2ZWRfcmV0IiBbdm1saW51eF0NCj4g
dmVyc2lvbiAuLi4NCj4gPiAgICAgIElzICJfX3NlYW1jYWxsX3NhdmVkX3JldCIgcHJvdG90eXBl
ZCBpbiA8YXNtL2FzbS1wcm90b3R5cGVzLmg+Pw0KPiA+DQo+ID4gd2hpY2ggaXMgZml4ZWQgYnkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBl
cy5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20tcHJvdG90eXBlcy5oDQo+ID4gaW5k
ZXggOGY4MGRlNjI3YzYwLi5lZmY1MjUyZTljODYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vYXNtLXByb3RvdHlwZXMuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2FzbS1wcm90b3R5cGVzLmgNCj4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiAgICNpbmNsdWRl
IDxhc20vcGFnZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGFzbS9jaGVja3N1bS5oPg0KPiA+ICAgI2lu
Y2x1ZGUgPGFzbS9tY2UuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS90ZHguaD4NCj4gPg0KPiA+ICAg
I2luY2x1ZGUgPGFzbS1nZW5lcmljL2FzbS1wcm90b3R5cGVzLmg+DQo+ID4NCj4gDQo+IFRoYW5r
cyBQYW9sbyENCj4gDQo+IEkgbmV2ZXIgbWV0IHRoaXMgaXNzdWUsIG5vdCBldmVuIGZyb20gTEtQ
LiAgRG8geW91IGhhcHBlbiB0byBrbm93IHdoaWNoIEtjb25maWcNCj4gb3B0aW9uIGNhbiB0cmln
Z2VyIHRoaXM/ICBPciB3b3VsZCB5b3UgbWluZCBzaGFyaW5nIHlvdXIgLmNvbmZpZz8NCg0KKHJl
cGx5aW5nIHZpYSBvdXRsb29rIGR1ZSB0byBzb21lIG5ldHdvcmtpbmcgaXNzdWUgb2YgbXkgaG9t
ZSBuZXR3b3JrKQ0KDQpBZnRlciBkaWdnaW5nLCB0aGlzIGlzIGR1ZSB0byBleHBvcnRpbmcgX19z
ZWFtY2FsbCooKSBhc3NlbWJseSBmdW5jdGlvbnMgd2hpbGUgTU9EVkVSU0lPTlMgaXMgZW5hYmxl
ZC4gIA0KDQpUaGlzIHNlcmllcyBpdHNlbGYgZG9lc24ndCBjYXVzZSB0aGlzIHdhcm5pbmcuDQoN
CkkgZGlkbid0IGV4cG9ydCB0aGVtIGluIHRoaXMgc2VyaWVzIGJlY2F1c2UgSSB3b3VsZCBsaWtl
IHRvIGxlYXZlIHRvIEtWTSBwYXRjaGVzIHdoZW4gd2UgYXJlIHN1cmUgd2UgbmVlZCB0byBleHBv
cnQgdGhlbS4gIA0KDQpFLmcuLCBJIGhhdmUgc2VhbWNhbGwqKCkgd3JhcHBlcnMgdG8gcmV0cnkg
cnVubmluZyBvdXQgb2YgZW50cm9weSwgYW5kIHdlIG1heSBoYXZlIGNvbmNlcm4gZXhwb3J0aW5n
IF9fc2VhbWNhbGwqKCkgbG93IGxldmVsIGZ1bmN0aW9ucyBkaXJlY3RseSBhbmQgbWF5IHdpc2gg
dG8gZXhwb3J0IGhpZ2hlciBsZXZlbCB3cmFwcGVycy4NCg0KU28gSSB0aGluayB0aGUgZml4IHNo
b3VsZCBiZSB3aXRoIHRoZSBwYXRjaCB0aGF0IHRydWx5IGV4cG9ydHMgdGhvc2UgX19zZWFtY2Fs
bCooKS4gIEknbGwgdGFsayB0byBJc2FrdSBvbiB0aGlzIHRvIGdldCBoaXMgaWRlYS4NCg0KVGhh
bmtzIQ0K
