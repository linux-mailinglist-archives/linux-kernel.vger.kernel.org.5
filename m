Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC275C608
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGULox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGULou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:44:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CC2D4D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689939889; x=1721475889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+b59I1OZM4cv1FpN+V9Q4QUTcvu3QOMYeYXvZ8bWxmk=;
  b=BxRBn0x6oCrWD+bgk17HuHg3txovDk66hf946Jspn4hlLqngEd34dlgE
   xVWLHqPM1L9j68g/hwxT3NB6RExWEEYE946CZHjYSdt3uL56RpOSyw5KE
   2iRyl7ZwbYsPvPHZ4t/lOtFXL8GqUAOuvrVF0UK105ARPiS0JaSJ70emO
   8XL4b0E6mvx78sYrs3wM+aHEU/ob3gy/yWmhs7nmrjUloaJtgnCzQGcs1
   DDdoOcXiS29ujFBcbf27MH56FDfGDNnihkqc9q1MOXAIAe/pBkXiFBGRc
   Tr1BURFEcKD+W/NH8uEygB/YZyedAH+rIhvuNeg+7y+CVzr/NhVybIT9q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351882513"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351882513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759928612"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759928612"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 04:44:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:44:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 04:44:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 04:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqbnQg/e3PBygKtFGnVz1nBwlUoXCaL+N606xF5nYDeNTh7SXpG4r1/lAPAyLZJav6QC3sFACfwFkTNbPzcFMlIuYYPhnc2GlH4P75jWeV44L6aapdsNw6DsnoaQWSxzXGelXg4TIVrWooRU9WDa0Pasl4bytKnVCH6Pqamrd/+7T0aPRXxl/6hJG1bm2R0ULstQPj/dUAQccdZ2OPDFtOVlHTCdMqp6U8S9HsuTEWNM7QSsZu1ag7Y8Zh/16Z8h5FnjOVTYgUJNI3G1lV2fmm9zKCJvSlkqtSVBhJQU6kCx7V3ZN/ZBKPbH6JrAJDSfJQbkrO0o/gKXKQA7tiFr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b59I1OZM4cv1FpN+V9Q4QUTcvu3QOMYeYXvZ8bWxmk=;
 b=RHUX9bObobShud8zcmSbg7msTfVkdaQBF4XjexiT4d7AqkPFm/syE3v7DoftKrPPAyf3QggLd0MRY9Hnrfi1j6u96VFQBoyMaPKLHMLWXPOy/VsQzfYjz8Pq4MlFEd3gGdBzmr8TPpsIFkrIY2gZzIAgPL5nVAPSJ+jxJiwhrjUuOLgBtPOYtcY5aUpFxhdBQRb1zI9lMDMn1jh/nYQTE2JCDOAry8i29b/7Rv1+8ItrO51PnUgmJkF82hBNhOz7ykm9tanPhWCbCH5CZe9B2gw9JpaNpJZPR3/LzMXPAHuAGKBe7f5MHZFNZebS/kdww2GybPz4O+oI50cyvbF7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 11:44:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 11:44:42 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZuwSXJzY29NdU9UyvS7MM7BQC1a/CoqcAgAC5BYCAAIK/AIAAMU+AgAALsoA=
Date:   Fri, 21 Jul 2023 11:44:42 +0000
Message-ID: <80f0cd42c033daf1da0096de860d64c19b4f2742.camel@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
         <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
         <a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com>
         <20230721080618.GC3630545@hirez.programming.kicks-ass.net>
         <2c1fba82f9425fa569cdf5c2aa22a7b1159cdafb.camel@intel.com>
In-Reply-To: <2c1fba82f9425fa569cdf5c2aa22a7b1159cdafb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4959:EE_
x-ms-office365-filtering-correlation-id: ddd22bc5-7d9e-485a-2727-08db89dfdf5b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xdz8LGuhyP6IMlUFSzppZ/K+5B+FYs9L9H6+otELRr+Hcwo13MWz4tIe4V1K/d/WQ41tp/4sRzyfgDT5OdLR5+4jvkl3uL5OHWBWI38YDydoGnHQAUGoczbE615FG7dTNre3lDliyeDkjorNv2oaaHs4YEhxZ9mc1rn5/mHJdVex78MNQSXyzu43YUglOyy454WhUCV04O/5CZAVMaoeYxf+0JsgtrTBDoRhAjL683yjN7TjRvLNAh+M7twaUKMGqSEL0vSBbWgdeoK8Rkqy8POrlmt+IXI+hWFO6xzVjhgXasmO2yUZWO7u1i171j41QriTU0IXfyEHGmM/jtcETUvZCLuO2KttQT/5qz7ezIb6zvnTWdVN6ntRTjr6oPTKVSAyaVl0UdxSqeHBQfjW7qG3dS05MNEvHSITKwjSSwUxqvKXux6KpHEboESeDUYP8ufYzDBU3LXWxNoM4apsSN6HsEEGGNfhZ/EqweTGFKRmvI0AAwzhBMoQUJ97VrUcvoTHdmo5ILIEmGIq1jx3UaYNtKQ6O7aDRkqogkaKAa0jrtCIz8bTdTygujlXYXa2AJnKvbRPNAe6ygwSoP8rA9/kdqCMwh/lS8LhcpOz/6WVrAtfTNoXnS6O2yv8ZFW5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6512007)(6486002)(478600001)(54906003)(2616005)(71200400001)(26005)(64756008)(186003)(6506007)(66446008)(66476007)(66946007)(2906002)(4326008)(316002)(66556008)(53546011)(6916009)(91956017)(7416002)(8936002)(5660300002)(8676002)(41300700001)(76116006)(82960400001)(38100700002)(122000001)(36756003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2hiYkhpazV0c3o1VXhsRjBSeW1ZNHNQWjdFS295UVFiRVl6d2kzbXE3K04z?=
 =?utf-8?B?UzZBRGJjT1hSN0pWbmRnL0I5WjZQTVJpbXQ2S2s4Qml3RHd6QW1wcDNudjNr?=
 =?utf-8?B?S0xNd2E0UHhYOEljMWcvY01TZGEzWkhZa2dWSFJmWjRyMFRmQko5WVY2UHIz?=
 =?utf-8?B?REdFSDg0NlFPQkJvL0hSMHZwbTNLSmhkeXJaWFQrYnA0YkZVOUJNMmNybGFO?=
 =?utf-8?B?ckZwNmVsV0I1STBGYWNYZm9EeVJyMHB0US8vNnk1enFPdDhSNnhKdiswZ2Ri?=
 =?utf-8?B?VUIvYlJVS3FyK241WCtjZmlXZTYvNXllN2RxVHIwbUxaOTJZTXJraWRLTm1h?=
 =?utf-8?B?K1RUaE80MnNteHZPQnJLbmFlbnJYNTlPdnJzUmZXQnhjU0l4NnczQndyOE9T?=
 =?utf-8?B?YTgwaEVXTmhMcW83b0lXMkd1ZnBlNUYwYzdhbCsxYUxwb1l4QUgzajJlOVRN?=
 =?utf-8?B?blBuWVZKZm84YnJsV1E1anV4V1kzQ2pBVi85aXptOURWcXdOMG1RYm1ZMm9P?=
 =?utf-8?B?T0lRSC9SeThNamVTY1RrRmwrTHRRMWw2YlBWV3MzcXk0ZVVrUW5NNUFRVmNL?=
 =?utf-8?B?UCtNSlF0a3VzWks5Nkx6Ym9sR1cwcDFLc3ZkNVpiOEpCKzgzS1QvUnU0RHlN?=
 =?utf-8?B?R2pFb1l3TDlmMDVqRVE1N0E1ZlBhb20vYkEyZXlmM2svNkxHSXlGaitkcXQw?=
 =?utf-8?B?N01YcDBtNjQvQVdlU3oyL2lNMEJXRHNsMUhOYmRKVkFNVGFpOHRqYVNiMXkx?=
 =?utf-8?B?Slo0TmM1aGdBVWc4NVBZcVE3TWF2eTNCV0hlZ0lUQlhnSVgrdWFkQzNZTDE1?=
 =?utf-8?B?cG11dmF2REM3RkxZdWRyejVJMWY5TjM1R0pVMEhpRkJkMGNITlk3Zm9WQ3Nm?=
 =?utf-8?B?TUpNc1JLckkyditWd2s4dkd5Q2lCT0R4K1BKL01kMzNYMzdKMmo2SDh6TUpO?=
 =?utf-8?B?V2FCN3l0b2dJeFFXMmdVRGNLeStYTFFjUmVWSTU1NXUwZUgwZ3JGYW9YVitx?=
 =?utf-8?B?NFk4Rmd5Ykd2T3FOcHVDSHVDQXpTeUdvWng1MU1mR0phcmhtWWJaWVRZZUJC?=
 =?utf-8?B?LzlpQ2ppR1dJbkZReCtzUHE1ODd5d2ppbFJvdDFCaWVuZGl5WHlKWHZxSnpT?=
 =?utf-8?B?RzErT2ZwRXBOVUJNMks5cW1qR0JJRGJ0SVR4NW5tZ3NjUkx2QzBCWlQyVXVK?=
 =?utf-8?B?R3A0bm5GNEZLOHhBODY5RjJ6V2N6NlVjbzBtUWl5cWRkb3ZwaFNTRHhTNzZv?=
 =?utf-8?B?MlJESHd0eUlQY3hnVnFQN256ZzB1L21ISC9oS3J5OExCWE1EMFpleFh4bjY4?=
 =?utf-8?B?QSt3bnkzaHo1Q3prVHkxNHMwZzY1cE5OYmo0S2xJZnZZNXlJUnNUNDZxSWhn?=
 =?utf-8?B?K1psYW1kODBnaFZycklBUFJQQmhPbkZPeE9mcXVabkM2eTNsNWEwbnBqeC9T?=
 =?utf-8?B?OWlGUGRUNEVWeE1uMnFmV05WbW1meXVXUHpGSkYvRkhPY0ZaSlFjRmFOSXUr?=
 =?utf-8?B?cTV2a2o3WjhpZlVGODA3QnlLc0ZBNy9NSmk4ZGJWY3dxY0VvQlF6TUZEZ3J5?=
 =?utf-8?B?NWljZXFGanFWUXE4cy9odE90MTVRMjZ6WGxGdTBTVlc5SmxFWHpNN3lLd2tR?=
 =?utf-8?B?RFRmbTU2NGJRUEJDbnp4blZVaFo5YkM2dU9lSGlrV0VhQ1REdklZS1p0b0tV?=
 =?utf-8?B?TVdXcGpPMWpPY2FEMHM2eDd0ZjVZUFZFa0dObkg3em53TzZNK0djVnB1cmZ1?=
 =?utf-8?B?SXg4QWc1dDBsUWsyQnVqZ05pRWJFZmg0aUNuaWRKMHlqeDRLdE1JMy9Ma0xU?=
 =?utf-8?B?UTIxMkNYWTgvN0xva2J4QVdhMmFKK1FxMEd6bG8wWFZNOGFGbWdLM2pMYlR0?=
 =?utf-8?B?UWVsZGZ4NFAyY2dTNGFwc0NSMDIyZGVIYjVHOXpmK1d5TXVSSHAyWTlWSysv?=
 =?utf-8?B?K0NVU0lrQU9sY0pBa3ZQNzFvZnNWL0h3NXY1WXJFaHVrcTVtOXVpa0tnWDJF?=
 =?utf-8?B?UDZMNk1JNjBuNGtMYzdGanZUVktlbkpuSFlIQlcrbUc1dHRjM1VrK08yVnpN?=
 =?utf-8?B?NDhRcWFiLzV0VjBMTTBBVkk4bFllbDNQd0x5T3ZVVThveGdIMWxMN2JFVGNC?=
 =?utf-8?Q?eCffVQIwV617lt0SKtjDsq0c3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5CBB18C215C45448EC77C68F1518527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd22bc5-7d9e-485a-2727-08db89dfdf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 11:44:42.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByJ3KMiGvBr0jLoopdRW95e4Xg5EEDgkZWDoEZGlgsGyqBlma9vCrLI1mVa7n75LkBxGnKAk9PAUu8v6uArneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDExOjAyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBGcmksIDIwMjMtMDctMjEgYXQgMTA6MDYgKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0K
PiA+IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDEyOjE4OjIzQU0gKzAwMDAsIEh1YW5nLCBLYWkg
d3JvdGU6DQo+ID4gDQo+ID4gPiBVbmZvcnR1bmF0ZWx5IEkgZG9uJ3QgdGhpbmsgaXQncyBmZWFz
aWJsZS4gIFNlYW4gcG9pbnRlZCBvdXQgdGhhdA0KPiA+ID4ga3ZtX3ZjcHVfYXJjaDo6cmVnc1td
IGRvIGZvbGxvdyB0aGUgInJlZ2lzdGVyIGluZGV4IiBoYXJkd2FyZSBsYXlvdXQgaW4geDg2IChm
b3INCj4gPiA+IHdoaWNoIEkgbWlzc2VkIHNvcnJ5KSwgc28gd2UgY2Fubm90IHJlLW9yZGVyIEtW
TSBwYXJ0LiDCoA0KPiA+ID4gDQo+ID4gPiBBbmQgdW5mb3J0dW5hdGVseSBSQlAgKDUpIGlzIGlu
IG1pZGRsZSBvZiB0aG9zZSByZWdpc3RlcnM6DQo+ID4gPiANCj4gPiA+IAkwID0gUkFYDQo+ID4g
PiAJMSA9IFJDWA0KPiA+ID4gCTIgPSBSRFgNCj4gPiA+IAkzID0gUkJYDQo+ID4gPiAJNCA9IFJT
UA0KPiA+ID4gCTUgPSBSQlANCj4gPiA+IAk2ID0gUlNJDQo+ID4gPiAJNyA9IFJESQ0KPiA+ID4g
CTjigJMxNSByZXByZXNlbnQgUjjigJNSMTUsIHJlc3BlY3RpdmVseS4uLg0KPiA+ID4gDQo+ID4g
PiBUaHVzIHVubGVzcyB3ZSBhZGQgUkJQIHRvICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzJywgaXQn
cyBpbXBvc3NpYmxlIHRvIHJlLW9yZGVyDQo+ID4gPiB0aGUgc3RydWN0dXJlIHRvIG1hdGNoIEtW
TSdzIGxheW91dC4NCj4gPiANCj4gPiBBZGRpbmcgUkJQIHRvIHRoZSBzdHJ1Y3Qgc2hvdWxkbid0
IGJlIGEgcHJvYmxlbSwgd2UnbGwganVzdCBub3QgdXNlIGl0Lg0KPiA+IFNhbWUgYXMgUlNQLCBu
b2JvZHkgc2FuZSB3b3VsZCBleHBlY3QgdGhhdCB0byBiZSB1c2VkLiBJZiB5b3Ugd29ycnkNCj4g
PiBhYm91dCBpdCB5b3UgY2FuIGdpdmUgdGhlbSBmdW5ueSBuYW1lcyBsaWtlOg0KPiA+IA0KPiA+
IHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3Mgew0KPiA+IAl1bnNpZ25lZCBsb25nIGF4Ow0KPiA+IAl1
bnNpZ25lZCBsb25nIGN4Ow0KPiA+IAl1bnNpZ25lZCBsb25nIGR4Ow0KPiA+IAl1bnNpZ25lZCBs
b25nIGJ4Ow0KPiA+IAl1bnNpZ25lZCBsb25nIF9fc3BfdW51c2VkOw0KPiA+IAl1bnNpZ25lZCBs
b25nIF9fYnBfdW51c2VkOw0KPiA+IAl1bnNpZ25lZCBsb25nIHNpOw0KPiA+IAl1bnNpZ25lZCBs
b25nIGRpOw0KPiA+IAkuLi4NCj4gPiB9Ow0KPiA+IA0KPiA+IEkgbWVhbiwgYXQgdGhpcyBwb2lu
dCB0aGUgd2hvbGUgdGhpbmcgaXMganVzdCAxMjggYnl0ZXMgb2YgZGF0YSBhbnl3YXkuDQo+IA0K
PiBTdXJlIEkgY2FuIGRvLg0KPiANCj4gSG93IGFib3V0IGFkZGluZyBhbiBhZGRpdGlvbmFsIHBh
dGNoIG9uIHRvcCBvZiB0aGlzIHNlcmllcz8gwqANCj4gDQo+IEZvciBpbnN0YW5jZSwgYmVsb3cg
cGF0Y2ggKGNvbXBpbGUgb25seSk6DQo+IA0KPiBGcm9tIGM2M2QwMWJmOTFmZTIzZjFlMmQyZTA4
NTY0NDMyNmJkZWUxMTRkNDkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZyb206IEthaSBI
dWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gRGF0ZTogRnJpLCAyMSBKdWwgMjAyMyAyMjow
NjozMSArMTIwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIHg4Ni90ZHg6IEFkZCBfX3NlYW1jYWxsX3Nh
dmVkX3JldCgpIGZvciBUREguVlAuRU5URVINCj4gDQo+IEZvciBURFggZ3Vlc3QsIEtWTSB1c2Vz
IFRESC5WUC5FTlRFUiBTRUFNQ0FMTCBsZWFmIHRvIGVudGVyIHRoZSBndWVzdC4NCj4gV2hlbiBU
REguVlAuRU5URVIgcmV0dXJucyB0byBLVk0gZHVlIHRvIFRERy5WUC5WTUNBTEwgZnJvbSB0aGUg
VERYDQo+IGd1ZXN0LCBhbGwgUkNYL1JEWC9SQlgvUkRJL1JTSS9SOC1SMTUgYXJlIHZhbGlkIG91
dHB1dCByZWdpc3RlcnMsIGFuZA0KPiB0aGUgZm9sbG93aW5nIFRESC5WUC5FTlRFUiBhbHNvIHVz
ZXMgYWxsIHRob3NlIHJlZ2lzdGVycyBhcyBpbnB1dC4NCj4gDQo+IEludHJvZHVjZSBfX3NlYW1j
YWxsX3NhdmVkX3JldCgpLCB3aGljaCB1c2VzIGFsbCBhYm92ZSByZWdpc3RlcnMgYXMNCj4gYm90
aCBpbnB1dC9vdXRwdXQsIGZvciBLVk0gdG8gc3VwcG9ydCBUREguVlAuRU5URVIuDQo+IA0KPiBB
bHNvLCBLVk0gY2FjaGVzIGd1ZXN0J3MgR1BScyBpbiAna3ZtX3ZjcHVfYXJjaDo6cmVnc1tdJywg
d2hpY2ggZm9sbG93cw0KPiBmb2xsb3dzIHRoZSAicmVnaXN0ZXIgaW5kZXgiIGhhcmR3YXJlIGxh
eW91dCBvZiB4ODYgR1BScy4gIEhvd2V2ZXIgdGhlDQo+IF9fc2VhbWNhbGxfc2F2ZWRfcmV0KCkg
dGFrZXMgdGhlIHBvaW50ZXIgb2YgJ3N0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MnIGFzDQo+IGFyZ3Vt
ZW50LCB0aHVzIHRoZXJlJ3MgYSBtaXNtYXRjaCBoZXJlLg0KPiANCj4gT25lIG9wdGlvbiBpcyBL
Vk0gdG8gY29weSBpbnB1dCByZWdpc3RlcnMgZnJvbSAndmNwdTo6cmVnc1tdJyB0byBhDQo+ICdz
dHJ1Y3QgdGR4X21vZHVsZV9hcmdzJyBvbiB0aGUgc3RhY2sgYW5kIHVzZSB0aGF0IHRvIG1ha2Ug
dGhlIFNFQU1DQUxMLA0KPiBidXQgc3VjaCBtZW1vcnkgY29weSBpc24ndCBkZXNpcmVkIGFuZCBz
aG91bGQgYmUgYXZvaWRlZCBpZiBwb3NzaWJsZS4NCj4gSXQncyBub3QgZmVhc2libGUgdG8gY2hh
bmdlIEtWTSdzICd2Y3B1OjpyZWdzW10nIGxheW91dCBkdWUgdG8gdmFyaW91cw0KPiByZWFzb25z
IChlLmcuLCBlbXVsYXRpb24gY29kZSB1c2VzIGRlY29kZWQgcmVnaXN0ZXIgaW5kZXggYXMgYXJy
YXkgaW5kZXgNCj4gdG8gYWNjZXNzIHRoZSByZWdpc3RlcikuICBUaGVyZWZvcmUsIGFkanVzdCAn
c3RydWN0IHRkeF9tb2R1bGVfYXJncycgdG8NCj4gbWF0Y2ggS1ZNJ3MgJ3ZjcHU6OnJlZ3NbXScg
c28gdGhhdCBLVk0gY2FuIHNpbXBseSBkbyBiZWxvdzoNCj4gDQo+ICAgICAgICAgc2VhbWNhbGxf
c2F2ZWRfcmV0KFRESC5WUC5FTlRFUiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVj
dCB0ZHhfbW9kdWxlX2FyZ3MgKil2Y3B1LT5hcmNoLT5yZWdzKTsNCj4gDQo+IE5vdGUgUkFYL1JT
UC9SQlAgYXJlIG5vdCB1c2VkIGJ5IHRoZSBURFhfTU9EVUxFX0NBTEwgYXNzZW1ibHksIGJ1dCB0
aGV5DQo+IGFyZSBuZWNlc3NhcnkgaW4gb3JkZXIgbWF0Y2ggdGhlIGxheW91dCBvZiAnc3RydWN0
IHRkeF9tb2R1bGVfYXJncycgdG8NCj4gS1ZNJ3MgJ3ZjcHU6OnJlZ3NbXScuICBUaHVzIGFkZCB0
aGVtIHRvIHRoZSBzdHJ1Y3R1cmUsIGJ1dCBuYW1lIHRoZW0gYXMNCj4gKl91bnVzZWQuICBBbHNv
IGRvbid0IGluY2x1ZGUgdGhlbSB0byBhc20tb2Zmc2V0LmMgc28gdGhhdCBhbnkgbWlzdXNlIG9m
DQo+IHRoZW0gaW4gdGhlIGFzc2VtYmx5IHdvdWxkIHJlc3VsdCBpbiBidWlsZCBlcnJvci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gLS0t
DQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmggfCAxOSArKysrKysrKysrKysr
LS0tLS0tDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwuUyAgfCAxOSArKysrKysr
KysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVk
L3RkeC5oDQo+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oDQo+IGluZGV4IDc0
ZmM0NjZkZmRjZC4uOGQxNDI3NTYyYzYzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zaGFyZWQvdGR4LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3Rk
eC5oDQo+IEBAIC01OCwyNCArNTgsMzEgQEANCj4gICAqIFVzZWQgaW4gX190ZGNhbGwqKCkgdG8g
Z2F0aGVyIHRoZSBpbnB1dC9vdXRwdXQgcmVnaXN0ZXJzJyB2YWx1ZXMgb2YgdGhlDQo+ICAgKiBU
RENBTEwgaW5zdHJ1Y3Rpb24gd2hlbiByZXF1ZXN0aW5nIHNlcnZpY2VzIGZyb20gdGhlIFREWCBt
b2R1bGUuIFRoaXMgaXMgYQ0KPiAgICogc29mdHdhcmUgb25seSBzdHJ1Y3R1cmUgYW5kIG5vdCBw
YXJ0IG9mIHRoZSBURFggbW9kdWxlL1ZNTSBBQkkNCj4gKyAqDQo+ICsgKiBOb3RlIHRob3NlICpf
dW51c2VkIGFyZSBub3QgdXNlZCBieSB0aGUgVERYX01PRFVMRV9DQUxMIGFzc2VtYmx5Lg0KPiAr
ICogVGhlIGxheW91dCBvZiB0aGlzIHN0cnVjdHVyZSBhbHNvIG1hdGNoZXMgS1ZNJ3Mga3ZtX3Zj
cHVfYXJjaDo6cmVnc1tdDQo+ICsgKiBsYXlvdXQsIHdoaWNoIGZvbGxvd3MgdGhlICJyZWdpc3Rl
ciBpbmRleCIgb3JkZXIgb2YgeDg2IEdQUnMuICBLVk0NCj4gKyAqIHRoZW4gY2FuIHNpbXBseSB0
eXBlIGNhc3Qga3ZtX3ZjcHVfYXJjaDo6cmVnc1tdIHRvIHRoaXMgc3RydWN0dXJlIHRvDQo+ICsg
KiBhdm9pZCB0aGUgZXh0cmEgbWVtb3J5IGNvcHkgYmV0d2VlbiB0d28gc3RydWN0dXJlcyB3aGVu
IG1ha2luZw0KPiArICogVERILlZQLkVOVEVSIFNFQU1DQUxMLg0KPiAgICovDQo+ICBzdHJ1Y3Qg
dGR4X21vZHVsZV9hcmdzIHsNCj4gLSAgICAgICAvKiBjYWxsZWUtY2xvYmJlcmVkICovDQo+ICsg
ICAgICAgdTY0IHJheF91bnVzZWQ7DQo+ICAgICAgICAgdTY0IHJjeDsNCj4gICAgICAgICB1NjQg
cmR4Ow0KPiArICAgICAgIHU2NCByYng7DQo+ICsgICAgICAgdTY0IHJzcF91bnVzZWQ7DQo+ICsg
ICAgICAgdTY0IHJicF91bnVzZWQ7DQo+ICsgICAgICAgdTY0IHJzaTsNCj4gKyAgICAgICB1NjQg
cmRpOw0KPiAgICAgICAgIHU2NCByODsNCj4gICAgICAgICB1NjQgcjk7DQo+IC0gICAgICAgLyog
ZXh0cmEgY2FsbGVlLWNsb2JiZXJlZCAqLw0KPiAgICAgICAgIHU2NCByMTA7DQo+ICAgICAgICAg
dTY0IHIxMTsNCj4gLSAgICAgICAvKiBjYWxsZWUtc2F2ZWQgKyByZGkvcnNpICovDQo+ICAgICAg
ICAgdTY0IHIxMjsNCj4gICAgICAgICB1NjQgcjEzOw0KPiAgICAgICAgIHU2NCByMTQ7DQo+ICAg
ICAgICAgdTY0IHIxNTsNCj4gLSAgICAgICB1NjQgcmJ4Ow0KPiAtICAgICAgIHU2NCByZGk7DQo+
IC0gICAgICAgdTY0IHJzaTsNCj4gIH07wqANCj4gDQo+IC8qIFVzZWQgdG8gY29tbXVuaWNhdGUg
d2l0aCB0aGUgVERYIG1vZHVsZSAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgv
dGR4L3NlYW1jYWxsLlMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwuUw0KPiBpbmRl
eCBiMzI5MzQ4MzdmMTYuLmYyNTFlYmFkYjAxNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmly
dC92bXgvdGR4L3NlYW1jYWxsLlMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1j
YWxsLlMNCj4gQEAgLTQwLDMgKzQwLDIyIEBAIFNZTV9GVU5DX0VORChfX3NlYW1jYWxsKQ0KPiAg
U1lNX0ZVTkNfU1RBUlQoX19zZWFtY2FsbF9yZXQpDQo+ICAgICAgICAgVERYX01PRFVMRV9DQUxM
IGhvc3Q9MSByZXQ9MQ0KPiAgU1lNX0ZVTkNfRU5EKF9fc2VhbWNhbGxfcmV0KQ0KPiArDQo+ICsv
Kg0KPiArICogX19zZWFtY2FsbF9zYXZlZF9yZXQoKSAtIEhvc3Qtc2lkZSBpbnRlcmZhY2UgZnVu
Y3Rpb25zIHRvIFNFQU0gc29mdHdhcmUNCj4gKyAqICh0aGUgUC1TRUFNTERSIG9yIHRoZSBURFgg
bW9kdWxlKSwgd2l0aCBzYXZpbmcgb3V0cHV0IHJlZ2lzdGVycyB0byB0aGUNCj4gKyAqICdzdHJ1
Y3QgdGR4X21vZHVsZV9hcmdzJyB1c2VkIGFzIGlucHV0Lg0KPiArICoNCj4gKyAqIF9fc2VhbWNh
bGxfc2F2ZWRfcmV0KCkgZnVuY3Rpb24gQUJJOg0KPiArICoNCj4gKyAqIEBmbiAgIChSREkpICAt
IFNFQU1DQUxMIExlYWYgbnVtYmVyLCBtb3ZlZCB0byBSQVgNCj4gKyAqIEBhcmdzIChSU0kpICAt
IHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgZm9yIGlucHV0IGFuZCBvdXRwdXQNCj4gKyAqDQo+ICsg
KiBBbGwgcmVnaXN0ZXJzIGluIEBhcmdzIGFyZSB1c2VkIGFzIGlucHV0L291dHB1dCByZWdpc3Rl
cnMuDQo+ICsgKg0KPiArICogUmV0dXJuICh2aWEgUkFYKSBURFhfU0VBTUNBTExfVk1GQUlMSU5W
QUxJRCBpZiB0aGUgU0VBTUNBTEwgaXRzZWxmDQo+ICsgKiBmYWlscywgb3IgdGhlIGNvbXBsZXRp
b24gc3RhdHVzIG9mIHRoZSBTRUFNQ0FMTCBsZWFmIGZ1bmN0aW9uLg0KPiArICovDQo+ICtTWU1f
RlVOQ19TVEFSVChfX3NlYW1jYWxsX3JldCkNCj4gKyAgICAgICBURFhfTU9EVUxFX0NBTEwgaG9z
dD0xIHJldD0xIHNhdmVkPTENCj4gK1NZTV9GVU5DX0VORChfX3NlYW1jYWxsX3JldCkNCg0KU29y
cnkgc2hvdWxkIGJlIF9fc2VhbWNhbGxfc2F2ZWRfcmV0Lg0KDQo+IC0tIA0KPiAyLjQxLjANCj4g
DQo+IA0KDQpTb3JyeSBtaXNzaW5nIHRoZSBkZWNsYXJhdGlvbiBvZiBfX3NlYW1jYWxsX3NhdmVk
X3JldCgpOg0KDQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vdGR4LmgNCkBAIC04MCw2ICs4MCw3IEBAIHN0YXRpYyBpbmxpbmUgbG9u
ZyB0ZHhfa3ZtX2h5cGVyY2FsbCh1bnNpZ25lZCBpbnQgbnIsIHVuc2lnbmVkDQpsb25nIHAxLA0K
ICNpZmRlZiBDT05GSUdfSU5URUxfVERYX0hPU1QNCiB1NjQgX19zZWFtY2FsbCh1NjQgZm4sIHN0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgKmFyZ3MpOw0KIHU2NCBfX3NlYW1jYWxsX3JldCh1NjQgZm4s
IHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgKmFyZ3MpOw0KK3U2NCBfX3NlYW1jYWxsX3NhdmVkX3Jl
dCh1NjQgZm4sIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgKmFyZ3MpOw0KDQpBbmQgcGVyaGFwcyB3
ZSBzaG91bGQgYWRqdXN0IHRoZSBvcmRlciBvZiByZWdpc3RlcnMgaW4gYXNtLW9mZnNldC5jIHRv
IG1hdGNoIHRoZQ0KY2hhbmdlIHRvIHRoZSAnc3RydWN0IHRkeF9tb2R1bGVfYXJncyc/DQoNCi0t
LSBhL2FyY2gveDg2L2tlcm5lbC9hc20tb2Zmc2V0cy5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwv
YXNtLW9mZnNldHMuYw0KQEAgLTcwLDYgKzcwLDkgQEAgc3RhdGljIHZvaWQgX191c2VkIGNvbW1v
bih2b2lkKQ0KICAgICAgICBCTEFOSygpOw0KICAgICAgICBPRkZTRVQoVERYX01PRFVMRV9yY3gs
IHRkeF9tb2R1bGVfYXJncywgcmN4KTsNCiAgICAgICAgT0ZGU0VUKFREWF9NT0RVTEVfcmR4LCB0
ZHhfbW9kdWxlX2FyZ3MsIHJkeCk7DQorICAgICAgIE9GRlNFVChURFhfTU9EVUxFX3JieCwgdGR4
X21vZHVsZV9hcmdzLCByYngpOw0KKyAgICAgICBPRkZTRVQoVERYX01PRFVMRV9yc2ksIHRkeF9t
b2R1bGVfYXJncywgcnNpKTsNCisgICAgICAgT0ZGU0VUKFREWF9NT0RVTEVfcmRpLCB0ZHhfbW9k
dWxlX2FyZ3MsIHJkaSk7DQogICAgICAgIE9GRlNFVChURFhfTU9EVUxFX3I4LCAgdGR4X21vZHVs
ZV9hcmdzLCByOCk7DQogICAgICAgIE9GRlNFVChURFhfTU9EVUxFX3I5LCAgdGR4X21vZHVsZV9h
cmdzLCByOSk7DQogICAgICAgIE9GRlNFVChURFhfTU9EVUxFX3IxMCwgdGR4X21vZHVsZV9hcmdz
LCByMTApOw0KQEAgLTc4LDkgKzgxLDYgQEAgc3RhdGljIHZvaWQgX191c2VkIGNvbW1vbih2b2lk
KQ0KICAgICAgICBPRkZTRVQoVERYX01PRFVMRV9yMTMsIHRkeF9tb2R1bGVfYXJncywgcjEzKTsN
CiAgICAgICAgT0ZGU0VUKFREWF9NT0RVTEVfcjE0LCB0ZHhfbW9kdWxlX2FyZ3MsIHIxNCk7DQog
ICAgICAgIE9GRlNFVChURFhfTU9EVUxFX3IxNSwgdGR4X21vZHVsZV9hcmdzLCByMTUpOw0KLSAg
ICAgICBPRkZTRVQoVERYX01PRFVMRV9yYngsIHRkeF9tb2R1bGVfYXJncywgcmJ4KTsNCi0gICAg
ICAgT0ZGU0VUKFREWF9NT0RVTEVfcmRpLCB0ZHhfbW9kdWxlX2FyZ3MsIHJkaSk7DQotICAgICAg
IE9GRlNFVChURFhfTU9EVUxFX3JzaSwgdGR4X21vZHVsZV9hcmdzLCByc2kpOw0KDQo=
