Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275217CE1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjJRPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjJRPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:55:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379B116;
        Wed, 18 Oct 2023 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697644538; x=1729180538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/3MEm1UmT7FuUDUOyt4ugjQXNzGRbUzRAB4m4o2Nqao=;
  b=S5KjFlyE8QbT90udysHksNmMdfYS7kwXhXowj5toWzEF3BNC/Gb5zY4l
   U0UOlrnD2xZRn3+VTgJ6RJ5DVPaLK3rSDLeZNrswr34XWi1+qaCLcjFs0
   RdCKAJIuu9EzbDp0sj/TLhrzF461/cO/T6WT/eyMH7o8Ih4b8WNA0AXR9
   k39JefQYNktSz3p/m37lTU+DteqHRJh7qBAZLFqIOs/1QUYm1IFM2eocd
   JPGh9zGBt32KAYiyxj4BYB1r5Y1sud7eN+zjINVFJ8d1ghS6KWhev6zDd
   lNA920QpypCWsCngh/q0j1H1RpThUmnnKq/1zKp//LxDxdx5dkkVtwNk8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7594325"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="7594325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791666725"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="791666725"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 08:55:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 08:55:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 08:55:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 08:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE9+7WAVRTfPA0EYX0gp6D4ou7PY+fTeQn4HCWqv+Og5VJV3eFqJa3++KXbWOl0PF7MMgawy8MqXLjrFO1n6X2q1tVBqvUNUTVlLEAa9jC2XY575ZPlsBMLvVR1wXYhQFhX+lmJUzDyYL0Pt4Dz0lhS9PJICfTwpdgtA3LuBjOp1Bnv/osV/Ot+E8UYzYAaxwmodu5i/WYC4QdtBSJriJcFJKQQOqzEMdv2MH8PcAJy4hlMHnE9HYvcjhNauPA8LUtk43KqdajTNUusWS82ejRPz1bUPUgoQsuAreQ72tSBGkizkBDdk/VB6246xKflWgb/snjZf79bYxpXZhTNAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3MEm1UmT7FuUDUOyt4ugjQXNzGRbUzRAB4m4o2Nqao=;
 b=MmiuvDnrGgVM6iyV52itpOUEJZUJBFEpYypIjcQHKfLgiMFizkGIkiOFoFSD5Aa+2MAOqMQh+VFB2bjxyPe8nAq9l3SVdbDbW4ggpR8A/uDLjEutqmCQUULzk6Pdy4sus72LlkNywkKRUBqefEvLceyTiBSB++25cLxCuomCPYWzFZTmaXG2PeaT7MjFFupom6LdsVESdGxUWyWe9lgk9DpAUUXvzX8ydGGMVgBdvq1mhU+3me+JlJSg1tlKlIQ1l8U73Sd+KLH3weXGWYqQVempNafY5/et6KyAig8n1PWQo/sEeixVEZAg1gipLqgeHU0f8zw2Uj/pDqeXbu+Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:55:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 15:55:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Topic: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Index: AQHaATgY0RLsz+xoMkWnZqzcXks5J7BO+NyAgAC7vQA=
Date:   Wed, 18 Oct 2023 15:55:30 +0000
Message-ID: <f72be1e99a6a350f4fcf4902d69a03087d2bef24.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-5-rick.p.edgecombe@intel.com>
         <20231018044333.GA15759@lst.de>
In-Reply-To: <20231018044333.GA15759@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: 0e3a165f-8c56-42cf-5b62-08dbcff2a7d6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYWGYgEykmSvl4g7LGbJtiveHOadMBhzWN5ryfbCazhyXD9H/PcCXn87WoUhHIvpo8tOER0dUoxG9nym/V/auhRVopXi07UmXJwnjPweKIe6GRKPddFg5woOGImY6iDxYT6VuiAqKxlMLyLRPJpFF/y1VAe1SuuZz+mpcJNfnG50eFddsjJt3U+BUuRctW7nzegPuakwqiltB4wW7TcAGDFebQgvu7GblxrjABiWBIGa+HxzxpZ4uPHnXrc/UtRRmCYOTEkS3npuOiyZdhRrIiLAN4A6lfkEe7S3sPgqwmBg9X6w7dT4a/CXsoTGWcNXiHM74b2Uuky20zmBEmFce8g7N2YcZnau+/+yxRFnDojAbzH9OzF7VGtWyyyCqATqPOjq7rkohv/CElOrZneIasIq7qYGlYHKnZ9Q8Adl/vTB/y1E7jAhM20/dIBrd2bmy+R7MlKdDzA4H6Sbmz4bRNnndyHcWV7tcNLWiHaRDSbJzjGXPWFFHhwY56kA+Uc3zARdPfOD5w5VM4b4Lc9qhSBg+g7Szt1+g9AlKTuwPCovKuixicfxtkOjRnFQmhtbfmwBNnXnqLSo1cosC1ufmGRxGIPl0ac+gB2Cvfckym0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(26005)(6506007)(71200400001)(6512007)(83380400001)(4326008)(8676002)(5660300002)(8936002)(7416002)(4001150100001)(2906002)(478600001)(6486002)(966005)(41300700001)(122000001)(76116006)(316002)(91956017)(6916009)(64756008)(66446008)(66946007)(66476007)(54906003)(66556008)(38100700002)(82960400001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVVRQUJNZTNmRVMwMk82YTMyQ3N5amZHSmpaUTF0RDFKTGlINm9YdCtGL2p3?=
 =?utf-8?B?UytJSnA4ZE0yRTRxTVRGaVZOYjEzbGUySE9yTXkrVFlYVnoxMTllS1AwZmRw?=
 =?utf-8?B?OWFkL3o3a1FJaXA4aTdOWkpYSm5tb1ZDdmtKcEZNdGxuTkhrTFB6U2lWbFVD?=
 =?utf-8?B?TDRSWk1oZmQyRk5iTVd6c3kzVEt4blU0MmZQWGpkUXJ0byt1VWdzckEvNXRM?=
 =?utf-8?B?dlNhSWQ5SkNwMjlMUjZGbk9VWkZYcjhQWjAzOTR6R3F1UWViNmlXRWdUSllZ?=
 =?utf-8?B?V2J0dm5hV3hzekxxWnhkRjMwWTNpcEljRm5lS1BzbndDZFg4OG51V1cyVlQv?=
 =?utf-8?B?SDY2eGFsMXEwTHp0WnA5SDZxVTVCRTd3ZiszK2xuMHlPNlJUbngvaEQ0M2w3?=
 =?utf-8?B?REh3MUNpUHRNTml1bXRYMlZqek5MK2E0T1FseHpMYjBIa3dkc1NoQ2VmZE91?=
 =?utf-8?B?ZnFieUxrZTdFZGxxbFhiQU9xN0pEQTVJcHlqTHdHdFplMkk2MXY3MEQzenZV?=
 =?utf-8?B?bTlHcnUzWUZsT3ZXc1UxVWVYK1RCa3BPOGoyZUtQTVcva2UzRU5IeFlNZCs1?=
 =?utf-8?B?NFQxdGF2Ti9DMGYyMjFyQWNOZEIzaSszd003NzV1VmZZcElHR0VRc3hVN2dS?=
 =?utf-8?B?ZzRKbHhIOEhMU2tyeTlvb1VqeTJISGlwZ3o4dXFHaHdvdmFIWXV4U0d5L2Yy?=
 =?utf-8?B?LzNlRURkTExEWlZLTXlzbS9wYmdWL1hUeE9YdEY0ZVZIMU5XSWMwUGVWb0R2?=
 =?utf-8?B?cmpYR3o2T2tZbEtIS2NCcHlYbEVvUlpMWS9jWUo5Y1hXVjlmeHd6Q1pvTVQ5?=
 =?utf-8?B?cGVNMFpXY0Z3NE1Qamh1KzRweS9uQms5R1JHaUpFM1hOd2thZU1EUnRrUXhv?=
 =?utf-8?B?YUl3RkkwcjUzUk9xeHZPc09lK0lnanR0OU5uREZUeVFxNmgybWhBcEVRUjhS?=
 =?utf-8?B?aDJvRk81aFR0bklpeFBVM084YnFVUVFteXNWTU1LUWJVNVFMb20wR0hVN0Y5?=
 =?utf-8?B?S09NQ0JxN1AvaVJHL3JuVkdIbWZQTTJuc0lkb0IxRHNNQ3g4SWxBUDRhanZo?=
 =?utf-8?B?K21IejNsUEFqbUhFOXQxeEZZN0NCUldNbkVYRUVKemczZXhtU1ZMcG50S2lW?=
 =?utf-8?B?OUVYZEZVMnBBSEcwTE9QbnRrZjNhQmd1ZFRDN0hXWXMwcnQyZ2IwZENCb1Za?=
 =?utf-8?B?VzNuQVlUaHo1T2s0ZEZjcExaUFl5R2tqbFpjSWEvRDVNWDlCQ1EyempNWXFL?=
 =?utf-8?B?MENCS2dBWnNXVlY3ci9GYTRKYTJhcGFGdytsdVVDRWlVSG1JVHA1OUFEaWdr?=
 =?utf-8?B?ajFmQStKY0JGMXM4RWY3bHRBVUNSMW5Db3pyUzU2UkY3NmxXY0V5cDU5SWxz?=
 =?utf-8?B?VklkRjJBY2tBdzNjdFFoKzlGMXRaRTZzbmIvREsrc0UycHU0MVBLTjE2Yk13?=
 =?utf-8?B?ck9VZ3BaWDkrQ1JoYytUNTBtREtKVjJTS0prVFdLVGd0MlByeS9YYXNUZjlY?=
 =?utf-8?B?MHBYTXpQU0JOMVNLOGtWRDVieitwaVRsVEcrVVZFZFl5bGdLeDZ3bnovRmZ4?=
 =?utf-8?B?VUtXRmpoWGI5ZmZPU0FIZXZOc0VwZ2xXbW9DQjJ6Ui9tYjFkVktkRU1xdk9H?=
 =?utf-8?B?NE5qRm11d1FOWEppNnVyeU5LUlBabmxYK083UW9QNjZpSVk1eFpDY0xEdnFD?=
 =?utf-8?B?MEkxbzRtQnlmWTBmekh0dTJqU1pJenNtb3crQStLU3NZc1RoT011SXJzQnBV?=
 =?utf-8?B?MnphdDVRVjRHbDBwWkZicDhKczNFYjI1Y1hCVnptcHFEYjRucDlMUjFuYTJT?=
 =?utf-8?B?TVpjeHRlMGlLWENuTy8yNEpUbGkvdUsrc2djdEdkWnVoei9iZGVvRFg5dEpP?=
 =?utf-8?B?STl2dHZ5ZERzN1g3dXNRYS9zQTYrdFZBd0FodjB0eWRIcWdhQmxwYS8xaFlJ?=
 =?utf-8?B?S2M0RDZORlM2Ulh5MUZDM21tMGxRK0EvZVJBMHdMaFZwcUZEWWxBbXRpT1BS?=
 =?utf-8?B?UlZxMnZQL1RBUFVRR3VDVGd4YUJTbTJ6SXlJSVQ0TGI1L21hZm1NMjF1Q2Q1?=
 =?utf-8?B?UmJoMFF0WTZLSC9oOTlRZkY5YVhvSW16aURmZUl5czAyNHJUY0hxN210akls?=
 =?utf-8?B?WkhOVkRNN0ZlTzR1MHVuY1FYcUhwdHlpVy9BNWVoZFM2Q0tCaGp0OWY0UlFL?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F28A5EDBA3FD134A927107FD52D8975D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3a165f-8c56-42cf-5b62-08dbcff2a7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 15:55:30.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1UNaxgZHcOcwcstj900O/zaS0Dm4evsxbkS+pxh14TpbIm+2j4dV2TZ0NoMKdZ3OdEXodPPDzn+7aKnQZWWQ1AjBg1gCmZydMp06lXY1Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTE4IGF0IDA2OjQzICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMDE6MjQ6NTlQTSAtMDcwMCwgUmljayBFZGdl
Y29tYmUgd3JvdGU6DQo+ID4gT24gVERYIGl0IGlzIHBvc3NpYmxlIGZvciB0aGUgdW50cnVzdGVk
IGhvc3QgdG8gY2F1c2UNCj4gPiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpIG9yIHNldF9tZW1vcnlf
ZGVjcnlwdGVkKCkgdG8gZmFpbCBzdWNoIHRoYXQNCj4gPiBhbg0KPiA+IGVycm9yIGlzIHJldHVy
bmVkIGFuZCB0aGUgcmVzdWx0aW5nIG1lbW9yeSBpcyBzaGFyZWQuIENhbGxlcnMgbmVlZA0KPiA+
IHRvIHRha2UNCj4gPiBjYXJlIHRvIGhhbmRsZSB0aGVzZSBlcnJvcnMgdG8gYXZvaWQgcmV0dXJu
aW5nIGRlY3J5cHRlZCAoc2hhcmVkKQ0KPiA+IG1lbW9yeSB0bw0KPiA+IHRoZSBwYWdlIGFsbG9j
YXRvciwgd2hpY2ggY291bGQgbGVhZCB0byBmdW5jdGlvbmFsIG9yIHNlY3VyaXR5DQo+ID4gaXNz
dWVzLg0KPiA+IA0KPiA+IFN3aW90bGIgY291bGQgZnJlZSBkZWNyeXB0ZWQvc2hhcmVkIHBhZ2Vz
IGlmIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkNCj4gPiBmYWlscy4NCj4gPiBVc2UgdGhlIHJlY2Vu
dGx5IGFkZGVkIGZyZWVfZGVjcnlwdGVkX3BhZ2VzKCkgdG8gYXZvaWQgdGhpcy4NCj4gPiANCj4g
PiBJbiBzd2lvdGxiX2V4aXQoKSwgY2hlY2sgZm9yIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgZXJy
b3JzDQo+ID4gbWFudWFsbHksDQo+ID4gYmVjYXVzZSB0aGUgcGFnZXMgYXJlIG5vdCBuZXNzYXJp
bHkgZ29pbmcgdG8gdGhlIHBhZ2UgYWxsb2NhdG9yLg0KPiANCj4gV2hhdGV2ZXIgcmVjZW50bHkg
aW50cm9kdWNlZCBpdCBkaWRuJ3QgbWFrZSBpdCB0byBteSBtYWlsYm94LsKgIFBsZWFzZQ0KPiBh
bHdheXMgQ0MgZXZlcnlvbmUgb24gZXZlcnkgcGF0Y2ggaW4gYSBzZXJpZXMsIGV2ZXJ5dGhpbmcg
ZWxzZSBpcw0KPiBpbXBvc3NpYmxlIHRvIHJldmlldy4NCg0KT2suIFRoZSBzZXJpZXMgdG91Y2hl
cyBhIGJ1bmNoIG9mIHNldF9tZW1vcnkoKSBjYWxsZXJzIGFsbCBvdmVyLCBzbyBJDQp3YXMgdHJ5
aW5nIHRvIG1hbmFnZSB0aGUgQ0MgbGlzdCB0byBzb21ldGhpbmcgcmVhc29uYWJsZS4gSSB0cmll
ZCB0bw0KZ2l2ZSBhIHN1bW1hcnkgaW4gZWFjaCBjb21taXQsIGJ1dCBJIGd1ZXNzIGl0IHdhc24n
dCBpbiBkZXB0aCBlbm91Z2guDQpIZXJlIGlzIHRoZSBsb3JlIGxpbmssIGlmIHlvdSBoYXZlbid0
IGFscmVhZHkgZm91bmQgaXQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMDE3
MjAyNTA1LjM0MDkwNi0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0K
