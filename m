Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306E7BDC16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbjJIMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376508AbjJIMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:32:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F5270F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696854660; x=1728390660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=34DkuhxnJI++Ab/EZpc4Lsrjmp5BtQNlhH6JNDDaVU8=;
  b=n5W1DMzfkDnmLLm61FZEKOj4Bh4V6eg3bRKmbgXAuthV+KBO/fyF43FN
   5J1tFTDl8ZMVKFQmh4aqSN/rbj90RDY2BBDwyIJEjTNOdaQP31z4DaB3T
   M3DF9Lc+x8yDinoXyWCVqn7DAfK1xJgr1kT66IMaO8m9seDWHW5dP3h3e
   ityCeLzYncLx7V7QZgtd77JRxDeA3eDvRmsoi5bvLhPRuzO0zlvosZErq
   uZAQ6pVu2cjSYVN1W1ffOq2FvFncxXpfw92zuF1+2Vtozy2xLqAyyHyyi
   PgJRhMS0Y6NHagCrisTL2MGu7f8tpqSdRAPuRkgRPwmlgUUVtSFQzHgeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374458215"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374458215"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 05:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="702889557"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="702889557"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 05:30:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 05:30:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 05:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/FG01MKG+dTnnhSwyo5Ye7tN1zwjgW35V1FYn3sWi+qq5v5soml6D4J/iVC824fuGFhh7O/9YUjaAyx9ckLlsAcEK+zQIXUhvWRJfLASPkKrVg2TowsU4QQM+KYWgfLPFwEgHUgFZei+hfvw3KWuyncGCXBjp5EaFXxkaTWAouRPNrh8ip6WEJhcivElvgb50ZqmpMBA45MzjXhm3SOiQwZhpLQcsnFDcfcRuvqd0MiR+Bf1S3eabjMBMl+Re95nq7fnZxBwR4dyP3R0CWGQ0uk5a3JGwhHF9pcgPCN+W5CNJK4s4ghGruD8cApglYd00WCmmKXXw2ttIpBImFmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34DkuhxnJI++Ab/EZpc4Lsrjmp5BtQNlhH6JNDDaVU8=;
 b=U+nv7HgUAGFOYegVMiuWHofyQWXqkK5D1G1e+bBfJEm4Tlc9sCy0u/xft2DSN+ZPLuva9SQHAh6WjIsDjW/5pU6dhsDxJECUDM8ZXOgMzGUUYk01hqhl439E2KXPvYBNtSj+I4T4+80y+aSDAPAdMOHyLkmfNKJLa0kD64U+8XkGYj03dCu5z7jwIATlexQ+xGDTsm6nmdEsd+bVptoKRYWxG0VULEiizMB13AiWyKnrwLVa/iN0dt4yx97cM8/+sVfGcj7E8JiOEJlnADfvL6384WNLqNC4RYV8PJpU2/nA+IsWrB3pri2eIgn6n0TT+Ngh8PVAofBykUF8WxZ+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 12:30:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 12:30:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Topic: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Index: AQHZ948nj/zMOYVRoEiJKhSTORDfuLBBacSA
Date:   Mon, 9 Oct 2023 12:30:55 +0000
Message-ID: <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
         <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB7054:EE_
x-ms-office365-filtering-correlation-id: 8697b6c2-91e2-4d65-ebaf-08dbc8c395aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkIzXEpuzm7ObaDyILVWFho8xHPelgdLeyDErHnD0ygwAlAgdNLtXPF3h3HWZ9m/inwJdcQcpkKfMTFyElZbVh5TFeh0fIdEQmwgkHjXGPkgtDG9+KrcS0RlLfsuZC0Zt64GNksxKVN5TAEYby1Xji4QPFSd3IF3gX8UvPrNQoaEtQgUAp5JowRCqYg1+s1h5yRvUh3xgmdaHcvJBt3qGno+/V9PwNx3Q4PI5xpAycf+fC3uAzqMrRYgyKMBQw4m9tYPjWG36AmlXvN2Q8chdk3mMcsHIMrD0un5euYY1xH7Z5xluhhKMZt/glzp+kSBaBKwx9/rXKEEcvraJQer4foMgX7k2+yWU9U0hqiaqI7wf0OV+XPS657Vh3Aw9OSh/IoY4u5RCjNX+Hv5rAKPUi4TswhQlLnO5VkQjstqS63a1uta88vFE20Jqg6FakAlVL6A22wrklYq8ECPOG37pAveU6rpE1Tan1+AozDz99IsZfb5il96CDgYRjAkcNH6oTzzey7Oc5oQaqOt/ey7DiQcB34VzboFWnDNruBtx/6WlMZ5UQDVOaqeNOoXm/pDJYOf728tyeyMq/3V2x0xVawJfMttNRCkva77xCzNMr3QaMHBlgjc+L0us6ekctUS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(36756003)(2906002)(6512007)(478600001)(6486002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(71200400001)(6506007)(2616005)(66946007)(66556008)(66476007)(316002)(91956017)(7416002)(64756008)(76116006)(54906003)(66446008)(110136005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTUwOHlYcnNjTlVZMXBYa2ptZXIrY2ZydVRydTZwZ0s3WVVOcWtxV0d0R0NV?=
 =?utf-8?B?RDBoK2NFRE1GWUJHYkswdWljdmY4S2QvN0VSV2RNaElZbWNZbW1ubmZ2d21K?=
 =?utf-8?B?aG9PamdvZnNXcVBYU3FCTHRBaVVnWEU5Wm03RSs5SHBEclFtM3BseTA3Q2d1?=
 =?utf-8?B?cVh2R2hwdUUwUFNwQmVaaVlMbGlhNFdZT3A5V0FTYW5VMkZ0Wi9GRWJYTHdj?=
 =?utf-8?B?V2JycUpoTzZBcTk4R08rT2NDakMralNKOVowYXRsQ1doWkF3U1dFTFRXNk9m?=
 =?utf-8?B?RjYyWHBoSndqWFN4NW9BY2xRK1dyUFVpdkoxcDFSeklMN1lzTGMwVy9ZL0JM?=
 =?utf-8?B?ZGtWampJOXV4MnE0TDVtL0NMeGVuNzZUNkhIdEhrbVN6NkFxay9hVzYwazM0?=
 =?utf-8?B?SU8xM3J5Q3h4NElsdENBYmRiZmpMQ1ZVbnZnZGtFaDAxNEEyV2dTQjB6NVkv?=
 =?utf-8?B?ZUw0SzNJdmR4R2VIcDBVUTlkOWRndFNGL3FLakVheHRyMWJycHVtc21nUGRs?=
 =?utf-8?B?M1YzQ3hZbFpack42cWovTG1vT3FRM3dzS0VrZ1JmVExFYk5rZzZ2SldCNklR?=
 =?utf-8?B?MlFWUytHVGZqM05EaVZReElDTWQ0Z3NFQTdMdEU1djl1RDZ3MEtIUXJlTHll?=
 =?utf-8?B?cGV0RnZONWcrYkVwV2hUTGpXazdWZktBQ0cyVGQxa3BiTXMrRWo4RTRrMGlH?=
 =?utf-8?B?MkxPekR0bUZvTVlNVjdQTmRaVHovKzlUM1loRmRMMjlWV1ZCYmRGbW55U01I?=
 =?utf-8?B?WU53R0NsbTN4ZkZmR0NBWVY1c3FLSGt3ZjNDSi9Mam1sd2lvVlRpNHNNY0pv?=
 =?utf-8?B?YVBvbE5yYi91dHlFdjU2bWJEWmZDZ1lseFhaY2tWMXUwUzhmUGt5OUVZTDA3?=
 =?utf-8?B?OFpVd3FZSnRlaTV1QS9ma3Jsa2xTcEhkTzZjTWRZdG9Sd0dwcWZaRURmZFRG?=
 =?utf-8?B?YmgzaDdsTjkyK0MwV0k3WS8rTW0wMDRJcDNxd0VkNHZURjdxajVIQm5Iaklk?=
 =?utf-8?B?VVhXY3NvWHdkRHpkRkFYSW5hS2lsU0h1K0NuZG1Oa2Jvei9qMEY3NVZhQVlt?=
 =?utf-8?B?eXV5WGlOSkNpaEFucGNnL0RKbklQK3ZQSGR6S3FJVVJhcXg3Nlo2eWVIUXo0?=
 =?utf-8?B?TTdVb3NQK0pMVWxiL1J2NkFBaUxsaURHL2xuVDhmd3g3ZHJCVEVac1E3YVVU?=
 =?utf-8?B?MENSVVM0ZTFRRXF5TFdmcFBIdHBhelJMelJKUFlFM1J5cUdyRkZTVE1CVlJJ?=
 =?utf-8?B?VXZwOVQzODlOZjd5UWE1NU9Lc21hOG1oMERWUXY4RmV2L3JUQUY1bkJEc0ZK?=
 =?utf-8?B?ek1XeWFGcjV2SzRVTWo3cDErMGZNMmpSZEZURERJQzlVY2t2dDVaNk5RQ1ZD?=
 =?utf-8?B?RUJ2d3BraWN0eThOUjN3TVNkL3FzMmNXZTh0czlSb3c5WU9YeW5pY0NjamhW?=
 =?utf-8?B?NmtmOHZsd2gzVWFwOEhqSE1PNExkNWRiL0tOR0RFaGIxSEQ3cDU1bWZKdC9K?=
 =?utf-8?B?dTRHdkZGejVTMVNycEpIZXVPUVNzcWdBS3FzVEc4NE9peGZ6OXdGUnZJNW5B?=
 =?utf-8?B?czdzL3JPb1lJcTJTUTc0YWc1K2FFVmo5eWY2QnF2YWxGTEFmL25rTkc5UTI4?=
 =?utf-8?B?VStaZi9RaWdBV09wNDNOQndiNWdRK05GZkl0WHB5L1BSSjVuUUJjWUFRemZK?=
 =?utf-8?B?NG5VRVNMTzNyWC9WTnpFbXd1WWFMajRpOSt6SXFQQk9KNFQ5Mkx1Wkh2N3N2?=
 =?utf-8?B?VGZmUzlyVnJZaHFPMmNEaVhRMlMxRGtUUk90OXlmSjUzV2V6OGR0aWhOanlP?=
 =?utf-8?B?UTdhdWZLdkpndnNvUVJnVEJrTjAvcWloT3E2emk4d1FXa2lVZTBuY0t2MmFz?=
 =?utf-8?B?ZTFYa2tFMHFLRzhJWWJIZWdTTUFBSUF2bThrVWtBcXlXeGFWdlF3aHNrRnJu?=
 =?utf-8?B?enFISFJ6ZVcwNmN6bHpxWmRBajFtYktPQm83cytFQ0NUb3dQeEtINnk1aXQx?=
 =?utf-8?B?M1RXZGZNaEFDL3VHNmRNSU5hM1dlcjJnNHFZeUZIZTFEMjZGc1lPdTA0cFJ6?=
 =?utf-8?B?bWh3S2Z2Mk1LcEFsdi92UEttQVZYSUtqUkhPcWdJcjJyWWRDNEVFby9Cbk15?=
 =?utf-8?B?RE9nQTArSWJLRk55cGxpWDRDOW5Ta2NSUE9INmVBTkFJdGxGdGFKOC9Ga3FI?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDAE0833FEC3DC4AAF98E69EF2EA620E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8697b6c2-91e2-4d65-ebaf-08dbc8c395aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 12:30:55.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmboMmBJR80OOz0nRYG4W4eN6gPoJmvk6F9HvgGv6Dt0Uxf2rfWgi6DOSy2uyhY6d3fBZv+TX8T5ErEu+Tj3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE2OjEzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBndWVzdHMgYXJlIG5vdCBhbGxvd2VkIHRvIGNsZWFyIENSNC5NQ0UuIEF0dGVt
cHQgdG8gY2xlYXIgaXQgbGVhZHMNCj4gdG8gI1ZFLg0KPiANCj4gVXNlIGFsdGVybmF0aXZlcyB0
byBrZWVwIHRoZSBmbGFnIGR1cmluZyBrZXhlYyBmb3IgVERYIGd1ZXN0cy4NCj4gDQo+IFRoZSBj
aGFuZ2UgZG9lc24ndCBhZmZlY3Qgbm9uLVREWCBlbnZpcm9ubWVudHMuDQoNCk5pdDogbm9uLVRE
WC1ndWVzdCBlbnZpcm9ubWVudHMuID8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYv
a2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWxv
Y2F0ZV9rZXJuZWxfNjQuUyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUw0K
PiBpbmRleCA1NmNhYjFiYjI1ZjUuLmJlYTg5ODE0YjQ4ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9y
ZWxvY2F0ZV9rZXJuZWxfNjQuUw0KPiBAQCAtMTQ1LDExICsxNDUsMTYgQEAgU1lNX0NPREVfU1RB
UlRfTE9DQUxfTk9BTElHTihpZGVudGl0eV9tYXBwZWQpDQo+ICAJICogU2V0IGNyNCB0byBhIGtu
b3duIHN0YXRlOg0KPiAgCSAqICAtIHBoeXNpY2FsIGFkZHJlc3MgZXh0ZW5zaW9uIGVuYWJsZWQN
Cj4gIAkgKiAgLSA1LWxldmVsIHBhZ2luZywgaWYgaXQgd2FzIGVuYWJsZWQgYmVmb3JlDQo+ICsJ
ICogIC0gTWFjaGluZSBjaGVjayBleGNlcHRpb24gb24gVERYIGd1ZXN0LiBDbGVhcmluZyBNQ0Ug
aXMgbm90IGFsbG93ZWQNCj4gKwkgKiAgICBpbiBURFggZ3Vlc3RzLg0KPiAgCSAqLw0KPiAgCW1v
dmwJJFg4Nl9DUjRfUEFFLCAlZWF4DQo+ICAJdGVzdHEJJFg4Nl9DUjRfTEE1NywgJXIxMw0KPiAg
CWp6CTFmDQo+ICAJb3JsCSRYODZfQ1I0X0xBNTcsICVlYXgNCj4gKzE6DQo+ICsJQUxURVJOQVRJ
VkUgImptcCAxZiIsICIiLCBYODZfRkVBVFVSRV9URFhfR1VFU1QNCj4gKwlvcmwJJFg4Nl9DUjRf
TUNFLCAlZWF4DQo+ICAxOg0KPiAgCW1vdnEJJXJheCwgJWNyNA0KPiAgDQoNCg==
