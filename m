Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9170179FD89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjINHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjINHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:54:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72041BF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694678056; x=1726214056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FQLF9hwt81w1BhOsj4JKalkiFq8sW5PIz/DbjQLMP3g=;
  b=eTIA+iAEp6RBgx9U8FbpaMNydmwwht7+w1dP78A9vqKg40WdO6sC3H6z
   828WNeqbKn3b6m/03y+kF6t/+FX8a2gdDgpfUl0KyW62a2UEJveYlwkNC
   NUqxrTtgCgCNbJuJS642ZFOWPhFXnmBABsPKXHclw1Ar3Qq+ulRI9apO1
   xqTqE3/ArCc78sMQxo9O3+29CMlEw/0IzgIFRCYgrPsxC1aTK1mkkjPec
   tDWUrfHM6RLwFy0Mn6lCB0fazm0bNcS3NHdR8JoN87Ee74MZfkfhhKmXj
   LMC3di1gTJOPVweP5b+mPkoLDskCkaB1qB5QyilbuuJ2hAhA3s6pB8VlX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359144560"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="359144560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 00:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737825588"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="737825588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 00:54:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:54:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:54:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 00:54:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 00:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iarxc2dZgQ4Rm4NR90BzaJebxTte1CWK8f241LB1BSwGByk75VLOnO8LmQx/ERsPtHTEqfw1GG//xvA1FYlOA4ohEbGwoALLfAVrlDCS40kxhpMK1TSYEykOOKv8BcWE7couTI8NmrlqObFsNUiZX/JJ9vOzO6rMCsEsmwwYH0/tXVz8f0yysHfcEX45mTce9wqNh3BUBA5zpbJ62BQdXZckf88PdJa64stNbSpdiMjj6F6wbC3cWckMQY7Rb1C7pX4OSZ4Wq7ziwYZ3CpqS79erTwpIrABn/id1+ciAbH7Y0NTus519uosWVV2FTlrRh/vLyZCJaGshm2+F5Q+c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQLF9hwt81w1BhOsj4JKalkiFq8sW5PIz/DbjQLMP3g=;
 b=QgAPD7ZSnVmRoNyjSOBoXSQQoj3zOIIjUgJs5RZ3KbK/E09/RFcaxS3/fH6j6XIZxfTDqSOuoyPsnu+4lKoUN6/WMwroNo5RymljMu5nKSPGOvAzfknQDqpHkn0fqy7RrGnDrcCqlGfihGvKQLT+St5vghQM/SwWpcLImHUV6T8H9lLcExLU2mr7fALvujKsyLuUWFk3M4aNumo9HNao50seHtMgBB9sumhdVxTjjORDVnjAClf+QKxVpOStYeaumvGQ+5BzZgkHP054arGMR8MEFahwKgY9ZbuvRjaco4lnCuYlQA0Y0HAwCocJlTarh+uvyCpaaXTHOYiuZY6Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 07:54:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 07:54:11 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Topic: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Index: AQHZ5qem7IU2VPrp+E+UjIKvurp2uLAZhucAgAAgzICAAEWGgIAABr8A
Date:   Thu, 14 Sep 2023 07:54:10 +0000
Message-ID: <9eb77be3a64c25b3264d5011a93242d006b88627.camel@intel.com>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
         <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
         <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
         <20230914072959.GC16631@noisy.programming.kicks-ass.net>
In-Reply-To: <20230914072959.GC16631@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB7496:EE_
x-ms-office365-filtering-correlation-id: 7df6434d-7f19-48f9-c2c0-08dbb4f7c81a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQOeVWdEtnVNkgNCVJVtYzWU/aUQ1w1ADrG35H7+l5m3NphPiDxBGEXYEivu3fMhjDsep/RbvsoW/pO2DIxjE1XFJC8942QgnMxALtOcuG0jK+a+ulcj60q56E/MxR59Y2GcB5wDYzv8fYDiLcAJ3rsQl+xu6v/Lg6pwE9pD/PqwGVGXtOgZbW+8KDG4egftiqrp4zc05x12TYbyH2KlqwTl5+hURcg8zy+H2BDGHmWPYnqPcWgOTJUDhpl7fPtw6fXXQtCDIqZmU0zDjQbEmzzVk/VCl59kso1C/xRfOm6pc3uyBN4q8uYM+G++/Fc0aT5UslLdsVg10KLUP1RVnuKUS9rNIe/Cow6bF/kUuiPw0VkjwF5qz7UkDOgummWxMPa2H+iripfUWD66G485HViQGKfzWqPaBwrhl2pDuRG8Kgxpn4VVfG64ZxBXUfSXMpQDLodglbTMtvqU9/cZ3ZKri2TrkE2RZhmFr8QRVNfd+pmrAG0VxemSAQ8jLQtzJ6/JLQ0n3k0VPJC3Ej4WyBw0T77kdVFCvAGlCSuUzFyPze+8DfFO/7h33gn8Qk+FHxsRoVJ6wg62dBmmAIbZwrnDdY3rSh0vg3QL9a5PWvPxuRPjcNmQ7gcGbX+4JWTLfwkSUoTlfht9LKyUxHw9Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(1800799009)(186009)(451199024)(38100700002)(122000001)(82960400001)(36756003)(86362001)(38070700005)(76116006)(966005)(91956017)(478600001)(2906002)(6512007)(6506007)(71200400001)(8936002)(8676002)(6486002)(5660300002)(66446008)(66476007)(41300700001)(54906003)(6916009)(66946007)(66556008)(316002)(64756008)(83380400001)(2616005)(4326008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q01rWjlDOCtaeFdFT1lpc3JTZEw3azcwaWxjN1RwV1lkRjJJeWNTSXNJd3pm?=
 =?utf-8?B?OEJmck5GTWdpWXUzQmFpN3VlODAveE92TWlJbk1LaFpFbjhtSWdJRkJjRkZY?=
 =?utf-8?B?YnJkdnplRlNIU2pQWEZBVDJaVnNxWUVMY010dTZhSUJ0eEJDSVFIdlRoUEJU?=
 =?utf-8?B?bk13R1Bmb25Yd2FBSWpDN0xNcTFoQUNqUnpId0U4Q3RPcHZKRW9jd3JhTnd0?=
 =?utf-8?B?L250UGlSWG1wcERHYnJFWGFEUW5ycnNTbWRjTVV4L0ZBTkNqUE9La3I5TTZk?=
 =?utf-8?B?Zk8rYmNBOVJlTDE5TjNDeFQxY2NLUXNpTkFzRDk0clBEaXZDZDdGeG9MMDU4?=
 =?utf-8?B?ZHU4VXZmQkJQRWN5Rk1jSlZqdklHaitMb0h1RGM3VlRHaUExbHpzZTZtZFd4?=
 =?utf-8?B?Z2hNRVpNdUovRkdaeklQdklJOWkrbVp0bTdrcFpNQjduVTlKSnBmSkoveWlC?=
 =?utf-8?B?MEx4eU9pQWhiQXFRQ0dzUEFJakVNTVlrQmdJc3RaUjlrZUxvSWhtaXhFd2xX?=
 =?utf-8?B?SWRBdkF2YmVMWGUzM21TTGNUUVlKVHgxcmV4d1ZFOHBsRHN4TVg1VlRFZ2Z6?=
 =?utf-8?B?aHVuUFRqNml3dkFONm1vRU5Ib0FleWtCL25NM01ma0U1R0VPTzRrTXhzK3d4?=
 =?utf-8?B?NzFZRm9MSndDOFdZTVc5QVEzOENjV2l2SzBMMCtYeXZ5OTNPalE4Z0xiTld1?=
 =?utf-8?B?dkpSL3NiTURNZkw1SWU0bWxVaXphYzVjc0RQQWwralhQck51d0FhZEI1bTNU?=
 =?utf-8?B?MkR5dnQ3MGYydDhxcWdsa2hNUm13WG5zMVZkY2tUSEJNK2NTekxFczFtVVZv?=
 =?utf-8?B?RHRidm93QTdzaE9tZXV4NFRzNDFCeUZpMjVDVjVRaVR2QmQ5Z1pKTFZwL0JV?=
 =?utf-8?B?cTJGUWI2MFpHdTYwWm5pVFlGcUdiL1VMTjczNGpzNWJZTDBoTG5iNWRrekt3?=
 =?utf-8?B?aW9zUnMrSnA0N2FPRytaUGl0a0xVM3ZQdmtWL3pmMHBaYm9kVFgxR01ISFB2?=
 =?utf-8?B?VEN6cmEzWnorb3VDcWtlTlNIUzhNREpWYmpTZWpqQ2hZR1ZkTnl3bEg2VjJo?=
 =?utf-8?B?VzRYeU1teUk5KzRSTWRMOFZzWXFvSm16MFZwcnhYWmVyVGZhR0FlNWxPWHhH?=
 =?utf-8?B?ckhscW5OU3luWUpqNGdQWUZQUEdWYlI2YVZ4N1dYQjI5dE5aTXN2WWlzRHdU?=
 =?utf-8?B?cUdrSWY4UnlDR0xIZUxPVENIN0UwSEZBeWxGQlFPeUhvWFFOSVRqYWFzNlhy?=
 =?utf-8?B?ckJRMklVM1NDZWhZblNUcTE3b2dKMHJhL3VWcEk4QWtheDlmTUU1YWJSRXdC?=
 =?utf-8?B?VjBTbUJHRkZQVTJGSDZ5enNaRjR3TW83Z0ZKaHRQZVYveFd6bS96RDdCVDVZ?=
 =?utf-8?B?T0cxbWJOMUF1dkVNY0JKT2pPMm8za1VsUDFpVlVzOHpBVEpFbnllOVBheGF6?=
 =?utf-8?B?YnpTYzVsM3ZwbDNZaHo2TEZkbGdIdUZvekY3ZFlWR0VhZTkrSnJiQ3ltWTM0?=
 =?utf-8?B?aG1KcnF4ZDYwbldrMzhUVW1ydWxVZmNwQkk0VjRicjZzK3NsQVdOcDl3TmJU?=
 =?utf-8?B?UEdmU1pESVZCMkUxcEJXbjJtWVp1Z0M5RGNyWTlIYmFYeWVHTXdxcDdDMktr?=
 =?utf-8?B?OWlYNjRIb3ZqaEtOQ0JaWStkRDNtMEFnTEtjRUYrL3ZySWgraldxeEtuamFL?=
 =?utf-8?B?NE5NUS9uUEg3NkFnT2owNGVUUjBtc25IRUtPQzhvblppOTh1ZGdoeUloMThQ?=
 =?utf-8?B?aUpIN2h2Sm5jZTdoT1dPaC9COG5vTEVNTmdkTzBqc0t3WUtpVjN1Z3ludzJI?=
 =?utf-8?B?dlN4QTF0Wm5heVBqLzZaQzhqUUhGRXA3MkMwRitOVDM2MzFVcFU0Z2g5VmJQ?=
 =?utf-8?B?M1YxbUNXWUg0RUNnZHBCZjYxU0JmMnhwUnVyTkR4N1ZRbXpUWFZDTDlDMTl5?=
 =?utf-8?B?QlB0S0hBcDI0Z1ZLUVlzS1B6V0g2Wmk2TTUzbFhEalZaT0NGL1o5eEV0N2JW?=
 =?utf-8?B?cTFlZUwxZGlOTSs1R0ZyeXp4TG1BaTBvNFAyR2dNY0dENUIwVzFmdmpFVHBX?=
 =?utf-8?B?R1dOTjhCUmg5b1RkVUJ4NFpwZWpsSjdRMDFJc2c0aDYzOTVUY2xVb25VcjVD?=
 =?utf-8?B?aDhEZVIwTTY4VnNhWUN1Rzh1b1F5M0luRGNGLzNmZ3h3RExYUy9tekpyaVhH?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C5019C14C14448A05127BDA0DEB3D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df6434d-7f19-48f9-c2c0-08dbb4f7c81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 07:54:10.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmgfMFrA/Tto6J8l9DXPXvtF+28tND5YqwBoO3U3/kvw3dxIk09sh05rqq7RjrDP1OqrbBEKQIE5hqxdeszrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDA5OjI5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMDM6MjE6MjlBTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gPiBPbiBUaHUsIDIwMjMtMDktMTQgYXQgMDE6MjMgKzAwMDAsIEh1YW5nLCBLYWkg
d3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjMtMDktMTQgYXQgMDk6MDUgKzA4MDAsIGtlcm5lbCB0
ZXN0IHJvYm90IHdyb3RlOg0KPiA+ID4gPiB0cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni90ZHgNCj4gPiA+ID4gaGVh
ZDogICA3YjgwNDEzNWQ0ZDFmMGEyYjlkZGE2OWM2MzAzZDNmMmRjYmU5ZDM3DQo+ID4gPiA+IGNv
bW1pdDogYzY0MWNmYjVjMTU3YjZjMzA2MmE4MjRmZDhiYTE5MGJmMDZmYjk1MiBbOC8xMl0geDg2
L3RkeDogTWFrZSBURFhfSFlQRVJDQUxMIGFzbSBzaW1pbGFyIHRvIFREWF9NT0RVTEVfQ0FMTA0K
PiA+ID4gPiBjb25maWc6IHg4Nl82NC1yaGVsLTguMy1icGYgKGh0dHBzOi8vZG93bmxvYWQuMDEu
b3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDkxNC8yMDIzMDkxNDA4MjguOVJkbWxIMlotbGtwQGlu
dGVsLmNvbS9jb25maWcpDQo+ID4gPiA+IGNvbXBpbGVyOiBnY2MtMTIgKERlYmlhbiAxMi4yLjAt
MTQpIDEyLjIuMA0KPiA+ID4gPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOiAoaHR0
cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwOTE0LzIwMjMwOTE0MDgy
OC45UmRtbEgyWi1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4gPiA+ID4gDQo+ID4gPiA+IElm
IHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBq
dXN0IGEgbmV3IHZlcnNpb24gb2YNCj4gPiA+ID4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2lu
ZGx5IGFkZCBmb2xsb3dpbmcgdGFncw0KPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiA+ID4gPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzA5MTQwODI4LjlSZG1sSDJaLWxrcEBpbnRlbC5j
b20vDQo+ID4gPiA+IA0KPiA+ID4gPiBBbGwgd2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5
ID4+KToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6
IF9fdGR4X2h5cGVyY2FsbCsweDEyODogX190ZHhfaHlwZXJjYWxsX2ZhaWxlZCgpIGlzIG1pc3Np
bmcgYSBfX25vcmV0dXJuIGFubm90YXRpb24NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhtbS4u
IFRoZSBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKCkgaXMgYWxyZWFkeSBhbm5vdGF0ZWQgd2l0aCBf
X25vcmV0dXJuIChJDQo+ID4gPiBleHBsaWNpdGx5IGFkZGVkIGl0IHRvIHNpbGVudCBzdWNoIHdh
cm5pbmcpOg0KPiA+ID4gDQo+ID4gPiAvKiBDYWxsZWQgZnJvbSBfX3RkeF9oeXBlcmNhbGwoKSBm
b3IgdW5yZWNvdmVyYWJsZSBmYWlsdXJlICovDQo+ID4gPiBub2luc3RyIHZvaWQgX19ub3JldHVy
biBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKHZvaWQpDQo+ID4gPiB7DQo+ID4gPiAgICAgICAgIGlu
c3RydW1lbnRhdGlvbl9iZWdpbigpOw0KPiA+ID4gICAgICAgICBwYW5pYygiVERWTUNBTEwgZmFp
bGVkLiBURFggbW9kdWxlIGJ1Zz8iKTsNCj4gPiA+IH0NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUg
d2h5IHRoZSBvYmp0b29sIGlzIHN0aWxsIGNvbXBsYWluaW5nIHRoaXM/DQo+ID4gPiANCj4gPiAN
Cj4gPiBJdCBhcHBlYXJzIHRoZSBfX25vcmV0dXJuIG11c3QgYmUgYW5ub3RhdGVkIHRvIHRoZSBm
dW5jdGlvbiBkZWNsYXJhdGlvbiBidXQgbm90DQo+ID4gdGhlIGZ1bmN0aW9uIGJvZHkuICBJJ2xs
IHNlbmQgb3V0IHRoZSBmaXggYXMgc29vbiBhcyBJIGNvbmZpcm0gdGhlIGZpeCB3aXRoIExLUC4N
Cj4gDQo+IEZXSVcsIHRoZSByZWFzb24gYmVpbmcgdGhhdC4uLg0KPiANCj4gVGhlIHBvaW50IG9m
IG5vcmV0dXJuIGlzIHRoYXQgdGhlIGNhbGxlciBzaG91bGQga25vdyB0byBzdG9wIGdlbmVyYXRp
bmcNCj4gY29kZS4gRm9yIHRoYXQgdGhlIGRlY2xhcmF0aW9uIG5lZWRzIHRoZSBhdHRyaWJ1dGUs
IGJlY2F1c2UgY2FsbCBzaXRlcw0KPiB0eXBpY2FsbHkgZG8gbm90IGhhdmUgYWNjZXNzIHRvIHRo
ZSBmdW5jdGlvbiBkZWZpbml0aW9uIGluIEMuDQoNCkFoIHRoYXQgbWFrZXMgcGVyZmVjdCBzZW5z
ZS4gIFRoYW5rcyENCg0KVGhlbiBJIGFzc3VtZSB3ZSBkb24ndCBuZWVkIHRvIGFubm90YXRlIF9f
bm9yZXR1cm4gaW4gdGhlIGZ1bmN0aW9uIGJvZHksIGJ1dA0Kb25seSBpbiB0aGUgZGVjbGFyYXRp
b24/ICBCZWNhdXNlIHRoZSBjb21waWxlciBtdXN0IGFscmVhZHkgaGF2ZSBzZWVuIHRoZQ0KZGVj
bGFyYXRpb24gd2hlbiBpdCBnZW5lcmF0ZXMgdGhlIGNvZGUgZm9yIHRoZSBmdW5jdGlvbiBib2R5
Lg0KDQpCdHcsIEkgaGFwcGVuZWQgdG8gbm90aWNlIHRoYXQgdGhlIG9ianRvb2wgZG9jdW1lbnRh
dGlvbiBzdWdnZXN0cyB0aGF0IHdlIHNob3VsZA0KYWxzbyBhZGQgdGhlIHRoZSBmdW5jdGlvbiB0
byB0b29scy9vYmp0b29sL25vcmV0dXJucy5oOg0KDQozLiBmaWxlLm86IHdhcm5pbmc6IG9ianRv
b2w6IGZvbysweDQ4YzogYmFyKCkgaXMgbWlzc2luZyBhIF9fbm9yZXR1cm4gYW5ub3RhdGlvbg0K
DQogICBUaGUgY2FsbCBmcm9tIGZvbygpIHRvIGJhcigpIGRvZXNuJ3QgcmV0dXJuLCBidXQgYmFy
KCkgaXMgbWlzc2luZyB0aGUNCiAgIF9fbm9yZXR1cm4gYW5ub3RhdGlvbi4gIE5PVEU6IEluIGFk
ZGl0aW9uIHRvIGFubm90YXRpbmcgdGhlIGZ1bmN0aW9uDQogICB3aXRoIF9fbm9yZXR1cm4sIHBs
ZWFzZSBhbHNvIGFkZCBpdCB0byB0b29scy9vYmp0b29sL25vcmV0dXJucy5oLg0KDQpJcyBpdCBh
IGJlaGF2aW91ciB0aGF0IHdlIHN0aWxsIG5lZWQgdG8gZm9sbG93Pw0KDQpJIGFtIGFza2luZyBi
ZWNhdXNlIHRoZSBvbGQga2VybmVsIGNvZGUgZG9lc24ndCBoYXZlIGl0IHNvIHBlcmhhcHMgSSBh
bSBtaXNzaW5nDQpzb21ldGhpbmcgaGVyZS4NCg==
