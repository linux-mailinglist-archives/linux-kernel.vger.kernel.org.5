Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6A784FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjHWErg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHWEre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:47:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B225CF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692766053; x=1724302053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GFdHbJBFDSNucIwCG7C9kPgJT9rgOGpyEOu5BQXGnUQ=;
  b=hNUX1vaeZ08lzUsn0tGb1UEJ8RTgfB9Aps0ytKNrnAJr3MSpzx9JbIyn
   pAz12M6bO4In47YFX8ln+5Jz4RWl6q7q7sdfGM/3B2tnWVZWOsQsFwnKA
   PD9zETb6FoWfzWam6xFK1F5WThsWeGkLdAhnAQSoJZ7eVYNv4GTJW7rmE
   sLn8yEajpodXLlq7nn4NDB0rXIXysZGQwRLQRZX+cx7U4tdDmhLWZrR1y
   MBbxRpIMz2GD8E9p5H9Z6sUAwUukt6+rpJbpt/ms828diWmACVQln1aQ/
   SYolHa0qrIvKfow3s8/kaxKbSziyxWtkAkToRzu70Nor1OPUaG1SPf4e1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="354396035"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354396035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 21:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="801961003"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801961003"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 21:47:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 21:47:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 21:47:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 21:47:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 21:47:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrG7DqceQw5hxVbYiBzjN8d4twpFR/DrfCgQcu2itYeTI9DknLSgtKP7VigSmejrP06kZlfIanL2reKXeTSrQhqL/CGRUFJDz8iPPlifmD4VElnFm5RYkcN8ciDQergKFZvtNjpcOTNJLfz/MlpjCqGbFNIhzdNiPkkkzRBU6Y0x8XDBRNqGoHnVSAmE51jDJ02Sw9wDkRu9uWYzUi0RuwRXc55/Ny/eXj6A2zpBIurkfssuQKW8UV3JIFxDiOC7y4S03RzXPOZ01ECvexoTSkR1c2fXyUjhkyUMNa70Vr6Idznvpd23sM4VWRnkNUIKEEbShGE7D3Xht8bBB1x8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFdHbJBFDSNucIwCG7C9kPgJT9rgOGpyEOu5BQXGnUQ=;
 b=HIoG5cK9RjAlvvKqkCoz4lXwwwM3TGrGmtqR03mrwpiOwdWyDqlQ3e5GlfiZConkkSHTBqEln0uQNkyqQith/6hBYTQa9J7+yTx/LhRiPIovWWjjY6Xm0IDuwP63d+TE243iJmqcPwQGPjw+Bed2pm+ntTbeL8RLqx42h169XO6A5b4sIRSXMZ0e60LfSUEeL8tjRzgdO/679FIsyoi3ABDKIjpC/dAUmMM/k+PstiF9w/apSPJGdypxQXC1v272qc1DKqlWt0+OAuTPs2lH2gQxr94qE3KsL1wObcdfL7xoC/+r13o06r1kbaSRBUrKNheYbEG5+4EM+qatY06zzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 04:47:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 04:47:30 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/tdx: Mark TSC reliable
Thread-Topic: [PATCHv2] x86/tdx: Mark TSC reliable
Thread-Index: AQHZ1U8L6q1hsFVfY02LD3GAzcIUN6/3TzUA
Date:   Wed, 23 Aug 2023 04:47:29 +0000
Message-ID: <f5dc2de9d3997c3a89bdedee6cb0bf554f400ccc.camel@intel.com>
References: <20230822231823.3205-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230822231823.3205-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4970:EE_
x-ms-office365-filtering-correlation-id: eb28aaa2-43cd-44e9-3bcd-08dba3940e98
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UxJDXUlT8vVAZ5hh6SYfdMoqZFcqwJZn8CxOfv/DHNGIptLM54e+X4WQOlc0Pw6HkaasMnHHGA5I1vlYDEZkIqpzQm9phTif9x+oOztcN01498wtYC5O3N6uTuRdLxSDDrAOd67ICOGsOvjEX3I/tIKqJrabxt8JLhWPhT53fqlBvjtmHjBVAhmqSnwtIBFpZYp5DQU6XLTSe3Z80R/nf70MlEoRGrb5kHteg2WXkiieUjQuI7sbEfRnMU6oRmMB8uGDnx7qrHPtGVPzSIByzuOSo5UeZxovYk9H+PPi/AaNMS+rgA0SG+LLdF6Z7WQLrXmNh9GIJNl7AF2tu70pW3phRyvYC14t+421xtCL+b2nkeymUm6EXJIL8euD102HgWXr8cCGxK6CRPjahLdiXUS6m/6uM1weMPLbGE3yCWczTAHaZ4kpF/fJawGci57V1S7AdGMz+IRJG4Ky9/1/G37UxD773tMH6K8eEgMmTF5b8VuiZ5Myd79TjwO/cxTRKf8truRms1JsYIC1NZawFlth99HCvzCKIaF3VFqJTbJb41KQTiv4ZRJta02bU5AESFGIyaLR8/1js6Kwzrjy9epCkBa5oakp+3jKDqiir6YD+auxvQJ5zQBejbc3h4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(2906002)(83380400001)(122000001)(38100700002)(82960400001)(38070700005)(86362001)(36756003)(4326008)(8676002)(8936002)(6486002)(71200400001)(6506007)(66476007)(66946007)(66446008)(64756008)(66556008)(91956017)(54906003)(76116006)(316002)(6512007)(41300700001)(5660300002)(26005)(2616005)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWlUUnJFeTZTSXoyVzAra1M2bUlGb3VDL1ZVOUdOWlo5VHdpbmNjU3MrbFVy?=
 =?utf-8?B?SkN4bWdrU05GVFA0VllWb3huUU9wVC9FZVAvdzdtM0NITUdiRmJ0UmhXSk05?=
 =?utf-8?B?VTBNb2dSTm1VWWtudFM2anRMMm5QMGVGbUZpV2o2QnkyY2hsVTdManF2cTIr?=
 =?utf-8?B?cTZtV2U0aFd4R3pLdGwvYjVVWndndnBWRXlZdUE1ZGZIY2JBdFlwNGNKSDBW?=
 =?utf-8?B?U1ZlWEhaWkNseFBnbFU2dWlqNWxUcGVueTFQVWhuL1Q3Wlg3SlNZMEdyRFl1?=
 =?utf-8?B?bkNPNmFWbGRvN2dRWlp0VzZUSHFGOUFVMVBPM3V0bFpiNHFDdDcyYU9UNjFk?=
 =?utf-8?B?WFVOc3dOQlhPWi81eStYTHh5NFJSZUl1ekNqekZydmxLUnBKeUloVjA2a1Zi?=
 =?utf-8?B?bHZHYy8zMnEzWlVBS0tJcUZWakVhRlhtcGQrbTY5THBrTXBXV1hpRllBSUN6?=
 =?utf-8?B?OElVR1pRUlpTNnZtalJoQXBWYVI1U291SE5sQm9sTkR2clFJYUVVR0hkV3FQ?=
 =?utf-8?B?S0Z2cmdQM1o5VUFyR3hoalpoNW5PQlo5NFhPSXlObFFkOThqckdla3FsSEtt?=
 =?utf-8?B?Mi9zRDdkNFFoTkdPcDg5SDdDVWJqUnFuOUdsdStqOElkeGhUYk9RbGZLWFlV?=
 =?utf-8?B?MzUwaE94YURkeG5FSDYxUXE0M3QyRXlYT2VDbEZXaFQ2UU91NHZkTUpkSnVU?=
 =?utf-8?B?cmh5QVR0MHlTV1N6MmVFNDdFVTlEK3FTQWFkWTRVRWh0R1ZUUW01azNaTEpl?=
 =?utf-8?B?NHpZVFVPUkN2M1FXL28zWGxTRjVhUkVHMWxLTU5vSjhXamZsaGNpL3VPek5J?=
 =?utf-8?B?U2hrUkRjNWk0aWNZd3FzKzNyS0FXWXJRWUdtWkpFTldlN0NVTVR5YmR1elJB?=
 =?utf-8?B?UXNqUDdqTlpsWTFqOHQ5MnI3R2M3SFBRMnFRc0ZSTG1WREJpeUJZLy9tak5a?=
 =?utf-8?B?UU8wcSs0NDdWMnJVREhScFdoS0x5U1Fvd0xVZ2krVE9RZGYzbm1Hcjd2ZEdh?=
 =?utf-8?B?STNLY2lUZUtCS1V1MlNmNVBySTRwNTFWQzdoN01tdFRYek1Id1k4SWZLVEo2?=
 =?utf-8?B?RSs4OUlpR2FYK3JoRUlnUG9UY3hFTWhsUC9lZS8yRFJGTUw4eVBTRzdLemJa?=
 =?utf-8?B?QVdWYUpoSm4xS2VpZEE5M0JWN3hOQkJEbTN0OFFjTkU2SHJiSnBZZXRuZWpF?=
 =?utf-8?B?TmpVMllQTzVDWlpscDFXa3ZveDEwQXFEYVdKTFZuQnJzZ0RBaWMwOWlKd1Ft?=
 =?utf-8?B?VmUxbEF0Q1lZR2t6dG1PeWx3NjBteWZMMXA4K2crTk5iQ01FcHZnS09NeWFY?=
 =?utf-8?B?enVOUmsvNVpOZFVncUNHdEpyaUU4QjYrdko2SXhnL0k5QWJWU3FtdmwrUi8v?=
 =?utf-8?B?WitRbWJmNjNWZGJwK1k4RTFkeTlTMUNzTDJ5NmRqRVY0MUpyaXlQRnlIYkZE?=
 =?utf-8?B?ZFZPemVrU1hwbE9IUnR2a3NnN3RwL3NaVXN3WTNJUWg1bnUyYlRTcWJhYnh1?=
 =?utf-8?B?WURMeGgveWhRUTlqQlpaYlo0Um5yWEROMEs0aXB1M0RUTVBSY3phR3cxbVhm?=
 =?utf-8?B?aG9QWmZjTTJVRUNjQnRjUC9na3A4U3UvbkhnUGd2amU5azU4OHBvTEtSVzN2?=
 =?utf-8?B?ZU9NSEtiL1liVVZsYmppQSs0MkZKZnZ3NUpKUTNJUEVISUdPT1RETVhJVGZY?=
 =?utf-8?B?VEtmOElsR1J0NlA3ekI4M0VwMUdRYndoTTZZbEw4QVZsbURCNHFyYXFjRE02?=
 =?utf-8?B?TzNzRXJnNFNoRXNPNGUrV3dCbFdoZU1qK0I4T0o3ZEVYYzBqUHZ3d1pJZjJi?=
 =?utf-8?B?T1c1WkhTV0VFUkd4RDBqT29vWk56bkFYRmFOWHp1eTIvdEZNUVg2MGVkZXJi?=
 =?utf-8?B?d1RmbEZQZ0lma2hid21QVm0zQXA3b2JJU3pJVDVjZnVGWTdxamtyQXNONFc0?=
 =?utf-8?B?T2NES0tLcE9hM2tuWVYweGQ1K2NNQW52WkJwNThaRFVCSjJkRW1naGloOFNw?=
 =?utf-8?B?T0I1V3dMWXJ0eGdqckhYbjh6VGV1REdpYjh0V1ZFWjRnRUNTQmdQYUNQaHdp?=
 =?utf-8?B?blVpU3ZhNGpZVHZjUkRpNXhNYWJnNjVFOHA3ZDRkN1dVVHEwcmM4MWVyeVl0?=
 =?utf-8?Q?AJ8LzbXnH35OEGZ87YJVrWZm1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADEC40FC04324E46A3D625C1BFD3EE98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb28aaa2-43cd-44e9-3bcd-08dba3940e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 04:47:29.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/TFt3MYQ9kqBGNTBhrRelQYg8AQh3f3jSPK20iFY2w/yLbvXjX7sl2AHBmAkX+CYDJX+CmQZHqVKF9/TY2ByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDAyOjE4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEluIHg4NiB2aXJ0dWFsaXphdGlvbiBlbnZpcm9ubWVudHMsIGluY2x1ZGluZyBURFgs
IFJEVFNDIGluc3RydWN0aW9uIGlzDQo+IGhhbmRsZWQgd2l0aG91dCBjYXVzaW5nIGEgVk0gZXhp
dCwgcmVzdWx0aW5nIGluIG1pbmltYWwgb3ZlcmhlYWQgYW5kDQo+IGppdHRlcnMuIE9uIHRoZSBv
dGhlciBoYW5kLCBvdGhlciBjbG9jayBzb3VyY2VzIChzdWNoIGFzIEhQRVQsIEFDUEkNCj4gdGlt
ZXIsIEFQSUMsIGV0Yy4pIG5lY2Vzc2l0YXRlIFZNIGV4aXRzIHRvIGltcGxlbWVudCwgcmVzdWx0
aW5nIGluIG1vcmUNCj4gZmx1Y3R1YXRpbmcgbWVhc3VyZW1lbnRzIGNvbXBhcmVkIHRvIFRTQy4g
VGh1cywgdGhvc2UgY2xvY2sgc291cmNlcyBhcmUNCj4gbm90IGVmZmVjdGl2ZSBmb3IgY2FsaWJy
YXRpbmcgVFNDLg0KPiANCj4gSW4gVEQgZ3Vlc3RzLCBUU0MgaXMgdmlydHVhbGl6ZWQgYnkgdGhl
IFREWCBtb2R1bGUsIHdoaWNoIGVuc3VyZXM6DQo+IA0KPiAgIC0gVmlydHVhbCBUU0MgdmFsdWVz
IGFyZSBjb25zaXN0ZW50IGFtb25nIGFsbCB0aGUgVETigJlzIFZDUFVzOw0KPiAgIC0gTW9ub3Rv
bm91c2x5IGluY3JlbWVudGluZyBmb3IgYW55IHNpbmdsZSBWQ1BVOw0KDQpOaXQ6DQoNCiAgICAt
IFZpcnR1YWwgVFNDIGlzIG1vbm90b25vdXNseSBpbmNyZW1lbnRpbmcgLi4uDQoNCk90aGVyd2lz
ZSBoZXJlICJpbmNyZW1lbnRpbmciIGxvb2tzIGxpa2UgYSBub3VuLCB3aGljaCBtZWFucyB5b3Ug
bmVlZCB0byB1c2UNCiJtb25vdG9ub3VzIiByYXRoZXIgdGhhbiAibW9ub3Rvbm91c2x5Ii4NCg0K
DQo+ICAgLSBUaGUgZnJlcXVlbmN5IGlzIGRldGVybWluZWQgYnkgVEQgY29uZmlndXJhdGlvbi4g
VGhlIGhvc3QgVFNDIGlzDQo+ICAgICBpbnZhcmlhbnQgb24gcGxhdGZvcm1zIHdoZXJlIFREWCBp
cyBhdmFpbGFibGUuDQo+IA0KPiBSZWxpYWJsZSBUU0MgaXMgYXJjaGl0ZWN0dXJhbCBndWFyYW50
ZWUgZm9yIHRoZSBURFggcGxhdGZvcm0gYW5kIGl0IG11c3QNCj4gd29yayBmb3IgYW55IHNhbmUg
VERYIGltcGxlbWVudGF0aW9uLg0KPiANCj4gVXNlIFRTQyBhcyB0aGUgb25seSByZWxpYWJsZSBj
bG9jayBzb3VyY2UgaW4gVEQgZ3Vlc3RzLCBieXBhc3NpbmcNCj4gdW5zdGFibGUgY2FsaWJyYXRp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0
ZW1vdkBsaW51eC5pbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0Bp
bnRlbC5jb20+DQo=
