Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB47F5B26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjKWJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:38:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D04DBA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700732313; x=1732268313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c1iwYwwGNZBLJTRtyXhS3pSs1tEa/6Bjnoqun+Xo2ks=;
  b=T6xpPzFPHpsgEC5XdOHrADXmtCjznw3j/kBO7cFMQJ/l0ar+j9mskA/r
   MEx6bzI8iH3SHeE5jht38BvH6FN/O1YEDKIF5qc/60eZVKRiQWlDG7I/j
   S50ApC48YrC4zXV1x7e2Hp4Ny/6MLF3WIu4AuqFHXMxdFJZX8WrSzy1yT
   euNDgCyHnVhQhQ5DxEGK5KNezoY9fLqPm2ECaibflKusEGMhFO+pfCbvl
   mbUf8SN+aoWP9D2h8FabhNUb8n31RDDLskYt0SeB70B25xWdlKG6xMPBx
   qXJXQORO3mH5RTtT7DbVj+WOmRvBOJy7qUKNETWfDqJ924EaY32UDbvMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5423015"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="5423015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743560659"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="743560659"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 01:38:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 01:38:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 01:38:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 01:38:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 01:38:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDDBDBMGfqV2q1C0sg9psdVCJAjn71ZbnMyNjSvcm30IpCrFdw36argAYXS7qF36gyEzhdgdWjPAc23r8FmAPx/iCnWd7gt39Gbwym2TDzIgNkLw/J/XKESr3vHmBmwv/wvnMqiNGpNnf2geBMjp4rVh70tXlg2sSgrHyO/HnrkcuzzrWwR/GiAEOUgjR8MUKPD0f4n+IxGQRz4Suo0fZXin5UE6yqso1+KhFx3eMDcvYVWKVB2E44sxgoOxcCmC9TC3vVj1psFeRNRRh8Y9biA8BLatetr8v8luCA2y7v4+j61uWr83o/Dm59qDrNMCcl48+Ul+nNJIPVTqALxrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1iwYwwGNZBLJTRtyXhS3pSs1tEa/6Bjnoqun+Xo2ks=;
 b=WYeFfGl9HosS5Jxha+AvMdWllnDpj77x8rgphEu2Mda4TyusseqcGDUZbSb2P2Q0mGtRjDOB3GZBCzYsozPIeL/blgtCft+SQ/6b0PdlbNZYniHF58kH5XTXIYNerveJmWSf5oVELHBmaTqKP+7DdX5vKPbCIqa9IOEi65TMAruGoBs4hvn1K6lgXWVZ/GWMOwHWQwFHxrgH3zaLcppFFMySMnOwXo/LNziLtFfUKKfnqGPUwsui8Z2y41RZie9dpE/OZuci1K6Fl/72nPP22DQGySYw3AbKtd96sC84hHrzEah3PltoTgXPUZUIGkanPY2dzgdK6GQYLAFifS5DXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 09:38:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 09:38:14 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaF7uAoLPWjNmQzEmSsNIC3961FrCHshEA
Date:   Thu, 23 Nov 2023 09:38:13 +0000
Message-ID: <7012ba92206efaa6f0a0a2e1a28355d67d55265a.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-15-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-15-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV2PR11MB5975:EE_
x-ms-office365-filtering-correlation-id: 817766ae-b769-4ee3-984f-08dbec07ea04
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +f/8Xjs0PUGiUjEb0w+QR8qJ88sYCpbMLZB0lt1j4P5ISbYm8vTz91xrJfFAxhlxRhYY4BScuPEltxaJV2nqvVjPalzcoY8ipjZvOdjOJ+8cUCLOO7TGpIC1CGZNtT4ZO/CTXZJOgcR9P+UwdHdUCqBXJVtbGdJ+uDs6UormWrizJJJcJzCwo2JIh2X49tfd/r0/PXXYOGUu3VVXMWVU/r5V3QBo44m6wCi72OwiuTVUhKmOU+vihF6rM+WXN+M9okL27kNYjnr2ZE+kYja3JEVQM2MRasVWnT+NMtF/6H98vIBMKccu+jbEn8/nuyvgjiJh55IbFoexA3jv5nW5qRXT6PRNEKw1ss4aZzNP6k9G9rdql7+Ra1yefYYvrKLZNaRylYnzK8wRwbSFOgfd/pq+9tcu6p/p2ngDwsJXzk9iso1JX6P1v/BxDfUIOHvPZul4tT//s9Jm98eHgB3nB8UcKJM7BpTU6USchdJqETd/2BBfllVVxd8HeKjPCjuXPQZNf6agc3clOSDvnSAYey2dCqj3e1JTr9gEUmtFmdUxj+sjwJ3nmM/ZRHUqLiiOG43zd5l86IiGxNvaEep+JvibfxLYD8ZGtSHFYJGveUyjwb4GCM3UopbmbzlR3HzR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2616005)(6486002)(83380400001)(6512007)(6506007)(478600001)(5660300002)(4326008)(8676002)(41300700001)(71200400001)(8936002)(7416002)(2906002)(26005)(316002)(66946007)(110136005)(64756008)(66446008)(66476007)(66556008)(91956017)(54906003)(76116006)(86362001)(36756003)(38100700002)(122000001)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWoxRUZLblc5QXRFY1p4bU9UM2NwL2ZwNGFrTGZkNW1zT0hwSG1HUmx2a1dt?=
 =?utf-8?B?bm4rWGlWNmhnTWdEeXRaRHZHSUJUd3V4STEvQzQyK3E5QXFzT0FudHh0dlJw?=
 =?utf-8?B?Sy91THNSVkhMTjJTZGJqN3UzMTJmTWZRazRzV1VKWlA0UFFVOHpFVkpYY09o?=
 =?utf-8?B?ei9MWFlLT290aHgrUHpXNUFQczhEeFRMd2JTNGFDcFRHZ0FvQ0d3bVNUWllM?=
 =?utf-8?B?VzBBNVNDcnBzdTc3QWJZNzFhcC80R3ZqU0dFdkRnbEZ4VjI5c3o5anBxVEFx?=
 =?utf-8?B?UER1eTd6YkxwZHBEQksySUtra1FtR2F1SExWYm8xU1c1S0N4bEZERFgxTHA1?=
 =?utf-8?B?Q2pTV0k4NkJQbHBZTkJiV2s4VlFPaUhXVm9HNTJhWlZmZHhWSnlNY1hETGtn?=
 =?utf-8?B?bW5rSVRkc3lGdkpsblJORks5RXY4VjJPWHFHVkZrOUhIUWxUdTVETGdCbjFv?=
 =?utf-8?B?S0hzWjZMSjAwcGZjemZwSGxlNEx2Mm5xRWFVSU1sUVlyK1RQVzVhRVNVeUxl?=
 =?utf-8?B?V2FKa01YQWdlSEp4ZGtxZDR0VFBPaGtCU2MybXBFZXhkMkVCaXliNC9JZ1p1?=
 =?utf-8?B?Snd0YWxTeE1CUGI5MUNCZ3JpZmNNNE5xcnhZd3hVS1dqSDBock5SL3Q3ZWtm?=
 =?utf-8?B?bjVmMTVBeTVhZXNxbUN0dkd4T2ttbjhXWGRLd0ltWmhSRGRyUFBaZUkwOEN6?=
 =?utf-8?B?RlRUbDF1ekw4N3JTVy82bWN3K05BWmpZSW1qc2dFL3YvcWZlNkw1UkFhckJp?=
 =?utf-8?B?c1JHTUZDU0czVmZQdUI4UGpENG9oMGZ2UnBObG1NK0xES042VVV4QURuZGo3?=
 =?utf-8?B?YW45VFhQTGYvbDNxNG04SS9XWXV6QTE1bHpZUFJLcEpzR2xWZFRmZDNKaVFE?=
 =?utf-8?B?Nk1ZOXNJRUZkRklxdEwrNW5PZ1BjOVl5M2pQRlI3UzE2SUMyNkRiVEN1cWs5?=
 =?utf-8?B?TldDckQxQmg3Wk1aLzZPY3lJcWNHUFpZRHkyemhlV0tPN3VmOTA5R1hBTEE2?=
 =?utf-8?B?M3ZEL0pLL1ZkVU5YT0s4d1ZnS2N4T2RxZXJNRlNOM2tzSnB2Ynppc0FxWnhV?=
 =?utf-8?B?VWtYeDNlQ3pLVWlMVVJ4a0FEc1REVUc4S1NiZytCK2MySU9XVkllMlF3TktR?=
 =?utf-8?B?VmJCRHg3d3Y2UzZJa3ByM1BxekZwNTlOV3RVVVlHRG9KU0FIV0E4K0tBSlZa?=
 =?utf-8?B?Q2E5UzZsdHpyM0c2YUlQMlNZSFhjbncyVnNCbzFKeVdFVVcreTZ0YmtVWStD?=
 =?utf-8?B?VGpOZEdOUDg4TW1CT3lqaFk3NEZXOWxJaG03R1FiRmRIeUdzZkhqSmZjblVV?=
 =?utf-8?B?R05hbXNnMUNNR3ZtMkh2U2wvdHFsKzZBNU53Mll0N0xvUTY4cnBESjgxcmxa?=
 =?utf-8?B?Z0sxV201eEw0czdoSFFFNG8yRGdoTFIrcnROZnZVR0E0cHU3dnlUV3BuaXdY?=
 =?utf-8?B?VFVvempwT1ZsZ2FSdkhPNWNOTnYyVVl1UEZadUpWLzdhS0JjSkcvbzBnNGY1?=
 =?utf-8?B?RUVnVkxBZ1pIaEJudGowZUorS21nMkV5YmVqSHQ1QjMrNExTdUo1MThmcXUx?=
 =?utf-8?B?Uk1uVkdPbjVWT2hoajNWMVRnTEgrQit5THkyM3V1c1ZNMmN0YXdQcHpmRDdq?=
 =?utf-8?B?ZzBRcjBLR1BiTm9GKzBDRjQ0d1ZJQlFkUk9jVUdHUjI2VjdCeHArV2ZQT3RQ?=
 =?utf-8?B?NEsrcjlrVXhKK25BVmpNTHdQUHZGTjNTOXo3YXI4aElqODk5a0t6dVVQellL?=
 =?utf-8?B?bWk3WXJJWFBpWXArZ1JNZ2JCK3BJd3EyMUp5eWp0MDFkeWJ0ckIrRXFETUhq?=
 =?utf-8?B?dzZxRTFFQS9yY3J6U3h3bDAyMmFTZWtlTjFUcEozL0E3T0czdGcxNU51dXVx?=
 =?utf-8?B?UkYrOGp5K2ZKOEVXaEZOZTMvMTVoQWZhcHRpQVNmUk5HcHZTZjJxL0ZDbU4y?=
 =?utf-8?B?azIwaURwelhrQVlIM0o0SU1LaGI0b3FBVTZnRlpXYk9HUEtHMmExZ1dVRjhP?=
 =?utf-8?B?NWk3Q1BzUVhnbzdJcnVyNm1HU01jMThIQzZJWTV1ZXRtOVRVTTJxNUpJdGUw?=
 =?utf-8?B?U1VwcUpHQlpGaExuMmRTL0pPU3VLY1hQQ2lJZCsyRzdBVVlhWHBWRUVpeE16?=
 =?utf-8?B?Z3lvcVRZLzNOUWRWZmNGNjd2ZHo1WnlaTS9kVHd6Qm5RMXl0K2lHeDNIcE1a?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99F49C7CFCEA24EB6FA98B5FE9134FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817766ae-b769-4ee3-984f-08dbec07ea04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 09:38:13.7954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdRtXZwDH7r9SE0unvgzn5L3ogS8lNzkhTzKOf/m2jq+0AVRPP4iIJNUerrKfaDE1pY+0EvA90fyt00T3wKlsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvYWNwaS9ib290LmMNCj4gaW5kZXggMTcxZDg2ZmU3MWVmLi42MDJiNWQzOTgyZmYgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0KPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvYWNwaS9ib290LmMNCj4gQEAgLTIyLDYgKzIyLDcgQEANCj4gICNpbmNsdWRlIDxs
aW51eC9lZmktYmdydC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NlcmlhbF9jb3JlLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvcGd0YWJsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2hvdHBs
dWcuaD4NCj4gIA0KPiAgI2luY2x1ZGUgPGFzbS9lODIwL2FwaS5oPg0KPiAgI2luY2x1ZGUgPGFz
bS9pcnFkb21haW4uaD4NCj4gQEAgLTMzLDYgKzM0LDcgQEANCj4gICNpbmNsdWRlIDxhc20vc21w
Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL2k4MjU5Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL3NldHVwLmg+
DQo+ICsjaW5jbHVkZSA8YXNtL2luaXQuaD4NCg0KVGhlIGFib3ZlIHR3byBhcmUgbGVmdG92ZXJz
IEkgYmVsaWV2ZT8NCg0KWy4uLl0NCg0KDQo+ICsNCj4gK3N0YXRpYyBhdG9taWNfdCB3YWl0aW5n
X2Zvcl9jcmFzaF9pcGk7DQo+ICsNCj4gK3ZvaWQgYXNtX2FjcGlfbXBfcGxheV9kZWFkKHU2NCBy
ZXNldF92ZWN0b3IsIHU2NCBwZ2RfcGEpOw0KPiArDQo+ICtzdGF0aWMgdm9pZCBhY3BpX21wX3Bs
YXlfZGVhZCh2b2lkKQ0KPiArew0KPiArCXBsYXlfZGVhZF9jb21tb24oKTsNCj4gKwlhc21fYWNw
aV9tcF9wbGF5X2RlYWQoYWNwaV9tcF9yZXNldF92ZWN0b3JfcGFkZHIsDQo+ICsJCQkgICAgICBh
Y3BpX21wX3BnZCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGFjcGlfbXBfY3B1X2RpZSh1
bnNpZ25lZCBpbnQgY3B1KQ0KPiArew0KPiArCXUzMiBhcGljaWQgPSBwZXJfY3B1KHg4Nl9jcHVf
dG9fYXBpY2lkLCBjcHUpOw0KPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dDsNCj4gKw0KPiArCS8q
DQo+ICsJICogVXNlIFRFU1QgbWFpbGJveCBjb21tYW5kIHRvIHByb3ZlIHRoYXQgQklPUyBnb3Qg
Y29udHJvbCBvdmVyDQo+ICsJICogdGhlIENQVSBiZWZvcmUgZGVjbGFyaW5nIGl0IGRlYWQuDQo+
ICsJICoNCj4gKwkgKiBCSU9TIGhhcyB0byBjbGVhciAnY29tbWFuZCcgZmllbGQgb2YgdGhlIG1h
aWxib3guDQo+ICsJICovDQo+ICsJYWNwaV9tcF93YWtlX21haWxib3gtPmFwaWNfaWQgPSBhcGlj
aWQ7DQo+ICsJc21wX3N0b3JlX3JlbGVhc2UoJmFjcGlfbXBfd2FrZV9tYWlsYm94LT5jb21tYW5k
LA0KPiArCQkJICBBQ1BJX01QX1dBS0VfQ09NTUFORF9URVNUKTsNCj4gKw0KPiArCS8qIERvbid0
IHdhaXQgbG9uZ2VyIHRoYW4gYSBzZWNvbmQuICovDQo+ICsJdGltZW91dCA9IFVTRUNfUEVSX1NF
QzsNCj4gKwl3aGlsZSAoUkVBRF9PTkNFKGFjcGlfbXBfd2FrZV9tYWlsYm94LT5jb21tYW5kKSAm
JiB0aW1lb3V0LS0pDQo+ICsJCXVkZWxheSgxKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQg
YWNwaV9tcF9zdG9wX290aGVyX2NwdXMoaW50IHdhaXQpDQo+ICt7DQo+ICsJc21wX3NodXRkb3du
X25vbmJvb3RfY3B1cyhzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
aW50IGNyYXNoX25taV9jYWxsYmFjayh1bnNpZ25lZCBpbnQgdmFsLCBzdHJ1Y3QgcHRfcmVncyAq
cmVncykNCj4gK3sNCj4gKwlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiArDQo+ICsJY3Jhc2hfc2F2
ZV9jcHUocmVncywgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7DQo+ICsNCj4gKwljcHVfZW1lcmdl
bmN5X3N0b3BfcHQoKTsNCj4gKw0KPiArCWRpc2FibGVfbG9jYWxfQVBJQygpOw0KPiArDQo+ICsJ
LyoNCj4gKwkgKiBQcmVwYXJlIHRoZSBDUFUgZm9yIHJlYm9vdCBfYWZ0ZXJfIGludm9raW5nIHRo
ZSBjYWxsYmFjayBzbyB0aGF0IHRoZQ0KPiArCSAqIGNhbGxiYWNrIGNhbiBzYWZlbHkgdXNlIHZp
cnR1YWxpemF0aW9uIGluc3RydWN0aW9ucywgZS5nLiBWTUNMRUFSLg0KPiArCSAqLw0KPiArCWNw
dV9lbWVyZ2VuY3lfZGlzYWJsZV92aXJ0dWFsaXphdGlvbigpOw0KPiArDQo+ICsJYXRvbWljX2Rl
Yygmd2FpdGluZ19mb3JfY3Jhc2hfaXBpKTsNCj4gKw0KPiArCWFzbV9hY3BpX21wX3BsYXlfZGVh
ZChhY3BpX21wX3Jlc2V0X3ZlY3Rvcl9wYWRkciwNCj4gKwkJCSAgICAgIGFjcGlfbXBfcGdkKTsN
Cj4gKw0KPiArCXJldHVybiBOTUlfSEFORExFRDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQg
YWNwaV9tcF9jcmFzaF9zdG9wX290aGVyX2NwdXModm9pZCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBs
b25nIHRpbWVvdXQ7DQo+ICsNCj4gKwkvKiBUaGUga2VybmVsIGlzIGJyb2tlbiBzbyBkaXNhYmxl
IGludGVycnVwdHMgKi8NCj4gKwlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiArDQo+ICsNCj4gKwlh
dG9taWNfc2V0KCZ3YWl0aW5nX2Zvcl9jcmFzaF9pcGksIG51bV9vbmxpbmVfY3B1cygpIC0gMSk7
DQo+ICsNCj4gKwkvKiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmVwbGFjZSB0aGUgdHJhcCB2ZWN0
b3IgaGVyZT8gKi8NCj4gKwlpZiAocmVnaXN0ZXJfbm1pX2hhbmRsZXIoTk1JX0xPQ0FMLCBjcmFz
aF9ubWlfY2FsbGJhY2ssDQo+ICsJCQkJIE5NSV9GTEFHX0ZJUlNULCAiY3Jhc2giKSkNCj4gKwkJ
cmV0dXJuOwkJLyogUmV0dXJuIHdoYXQ/ICovDQo+ICsNCj4gKwlhcGljX3NlbmRfSVBJX2FsbGJ1
dHNlbGYoTk1JX1ZFQ1RPUik7DQo+ICsNCj4gKwkvKiBEb24ndCB3YWl0IGxvbmdlciB0aGFuIGEg
c2Vjb25kLiAqLw0KPiArCXRpbWVvdXQgPSBVU0VDX1BFUl9TRUM7DQo+ICsJd2hpbGUgKGF0b21p
Y19yZWFkKCZ3YWl0aW5nX2Zvcl9jcmFzaF9pcGkpICYmIHRpbWVvdXQtLSkNCj4gKwkJdWRlbGF5
KDEpOw0KPiArfQ0KPiArDQo+IA0KDQpbLi4uXQ0KDQo+ICsJc21wX29wcy5zdG9wX290aGVyX2Nw
dXMgPSBhY3BpX21wX3N0b3Bfb3RoZXJfY3B1czsNCj4gKwlzbXBfb3BzLmNyYXNoX3N0b3Bfb3Ro
ZXJfY3B1cyA9IGFjcGlfbXBfY3Jhc2hfc3RvcF9vdGhlcl9jcHVzOw0KPiArDQo+IA0KDQpUaGUg
YWJvdmUgYWNwaV9tcF9jcmFzaF9zdG9wX290aGVyX2NwdXMoKSBhbmQgY3Jhc2hfbm1pX2NhbGxi
YWNrKCkgZXRjIGFyZSBraW5kYQ0KZHVwbGljYXRlZCBjb2RlIHdpdGggdGhlIG5vcm1hbCBjcmFz
aCBrZXhlYygpIGluIHJlYm9vdC5jLg0KDQpJIGFtIG5vdCBleHBlcnQgaGVyZSBidXQgc3BlbnQg
c29tZSB0aW1lIGxvb2tpbmcgaW50byB0aGUgY29kZSwgYW5kIGl0IGFwcGVhcnMNCnRoZSBtYWlu
IHJlYXNvbiBwcmV2ZW50aW5nIHVzIGZyb20gcmV1c2luZyB0aGF0IGNvZGUgc2hvdWxkIGJlIFRE
WCBndWVzdCBkb2Vzbid0DQpwbGF5IG5pY2VseSB3aXRoIG13YWl0L2hhbHQgc3RhZmYgd2hlbiBw
dXR0aW5nIHRoZSBjcHUgdG8gb2ZmbGluZS4gwqANCg0KSSBhbSB0aGlua2luZyBpZiB3ZSBza2lw
L3JlcGxhY2UgdGhlbSB3aXRoIHRoZSBhc21fYWNwaV9tcF9wbGF5X2RlYWQoKSwgd2UNCnNob3Vs
ZCBiZSBhYmxlIHRvIGp1c3QgcmV1c2UgdGhlIGV4aXN0aW5nIHNtcF9vcHMuc3RvcF9vdGhlcl9j
cHVzKCkgYW5kDQpzbXBfb3BzLmNyYXNoX3N0b3Bfb3RoZXJfY3B1cygpPw0KDQpJZGVhIG9ubHk6
DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC94ODYva2Vy
bmVsL3Byb2Nlc3MuYw0KaW5kZXggYjZmNGU4Mzk5ZmNhLi45YWVlNmYyOWEyMWMgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJv
Y2Vzcy5jDQpAQCAtODQxLDcgKzg0MSwxMCBAQCB2b2lkIF9fbm9yZXR1cm4gc3RvcF90aGlzX2Nw
dSh2b2lkICpkdW1teSkNCiAgICAgICAgICAgICAgICAgKiAoc3RhY2sgdXNhZ2UgYW5kIHZhcmlh
YmxlcykgYWZ0ZXIgcG9zc2libHkgaXNzdWluZyB0aGUNCiAgICAgICAgICAgICAgICAgKiBuYXRp
dmVfd2JpbnZkKCkgYWJvdmUuDQogICAgICAgICAgICAgICAgICovDQotICAgICAgICAgICAgICAg
bmF0aXZlX2hhbHQoKTsNCisgICAgICAgICAgICAgICBpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgYXNtX2FjcGlf
bXBfcGxheV9kZWFkKCk7DQorICAgICAgICAgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgbmF0aXZlX2hhbHQoKTsNCiAgICAgICAgfQ0KIH0NCiANCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvcmVib290LmMgYi9hcmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCmluZGV4IDgz
MDQyNWU2ZDM4ZS4uODM1OGIyOTJiZDQyIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3Jl
Ym9vdC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCkBAIC04NjgsOCArODY4LDEz
IEBAIHN0YXRpYyBpbnQgY3Jhc2hfbm1pX2NhbGxiYWNrKHVuc2lnbmVkIGludCB2YWwsIHN0cnVj
dA0KcHRfcmVncyAqcmVncykNCiAgICAgICAgY3B1X2VtZXJnZW5jeV9kaXNhYmxlX3ZpcnR1YWxp
emF0aW9uKCk7DQogDQogICAgICAgIGF0b21pY19kZWMoJndhaXRpbmdfZm9yX2NyYXNoX2lwaSk7
DQotICAgICAgIC8qIEFzc3VtZSBobHQgd29ya3MgKi8NCi0gICAgICAgaGFsdCgpOw0KKw0KKyAg
ICAgICBpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KKyAg
ICAgICAgICAgICAgIGFzbV9hY3BpX21wX3BsYXlfZGVhZCgpOw0KKyAgICAgICBlbHNlDQorICAg
ICAgICAgICAgICAgLyogQXNzdW1lIGhsdCB3b3JrcyAqLw0KKyAgICAgICAgICAgICAgIGhhbHQo
KTsNCisNCiAgICAgICAgZm9yICg7OykNCiAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsNCiAN
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc21wLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc21w
LmMNCmluZGV4IDk2YTc3MWY5ZjkzMC4uZjg2Y2IxMDYwMmFhIDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYva2VybmVsL3NtcC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvc21wLmMNCkBAIC0xNTksNyAr
MTU5LDcgQEAgc3RhdGljIHZvaWQgbmF0aXZlX3N0b3Bfb3RoZXJfY3B1cyhpbnQgd2FpdCkNCiAg
ICAgICAgICAgICAgICByZXR1cm47DQogDQogICAgICAgIC8qIEZvciBrZXhlYywgZW5zdXJlIHRo
YXQgb2ZmbGluZSBDUFVzIGFyZSBvdXQgb2YgTVdBSVQgYW5kIGluIEhMVCAqLw0KLSAgICAgICBp
ZiAoa2V4ZWNfaW5fcHJvZ3Jlc3MpDQorICAgICAgIGlmIChrZXhlY19pbl9wcm9ncmVzcyAmJiAh
Y3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KICAgICAgICAgICAg
ICAgIHNtcF9raWNrX213YWl0X3BsYXlfZGVhZCgpOw0KIA0KICAgICAgICAvKg0KDQoNClsuLi5d
DQoNCj4gKw0KPiAgaW50IF9faW5pdCBhY3BpX3BhcnNlX21wX3dha2UodW5pb24gYWNwaV9zdWJ0
YWJsZV9oZWFkZXJzICpoZWFkZXIsDQo+ICAJCQkgICAgICBjb25zdCB1bnNpZ25lZCBsb25nIGVu
ZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXAgKm1wX3dha2U7
DQo+ICANCj4gIAltcF93YWtlID0gKHN0cnVjdCBhY3BpX21hZHRfbXVsdGlwcm9jX3dha2V1cCAq
KWhlYWRlcjsNCj4gLQlpZiAoQkFEX01BRFRfRU5UUlkobXBfd2FrZSwgZW5kKSkNCj4gKwlpZiAo
IW1wX3dha2UpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KDQpJIHRoaW5rIHlvdSBjYW4ga2VlcCB0
aGUgQkFEX01BRFRfRU5UUlkoKSBjaGVjayBhcyBhIHN0YW5kYXJkIGNoZWNrLCBhbmQgLi4uDQoN
Cj4gKw0KPiArCWlmIChlbmQgLSAodW5zaWduZWQgbG9uZyltcF93YWtlIDwgQUNQSV9NQURUX01Q
X1dBS0VVUF9TSVpFX1YwKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlpZiAobXBfd2FrZS0+
aGVhZGVyLmxlbmd0aCA8IEFDUElfTUFEVF9NUF9XQUtFVVBfU0laRV9WMCkNCj4gIAkJcmV0dXJu
IC1FSU5WQUw7DQoNCi4uLiB0aGVzZSBjYW4gYmUgYWRkaXRpb25hbCBzYW5pdHkgY2hlY2suDQoN
Cg==
