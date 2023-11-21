Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459187F23A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKUCIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:08:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57680C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532489; x=1732068489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E3NfkS+K7A3L/1pWIOLgL7fdAq96sR95H71EF+jnj3Q=;
  b=jrbyUjHVXrnwT+EYIL/PzWEPremAW4MeglE+x8/l4vmZfjBrJhOjaaFH
   ygkRram522/Gkqw/5FIkHNruIyno4eJ4OrVLkUsBuL2HVf7HCnjjz8Pby
   9Ai0a4deBm4Wr2m8q9ZUw46Od49dR/hWxnwG6XmhMhcapGiZExGWqK9uH
   uTzqvmzC04pPBNotjR+YhtzP8hE92E2cZr9tWLTustskK0DHR7GdpEaCG
   evFtu9UUtYKeSpWe+nMNQBoLyrncIwoR+ox93FIO2VynJ/XWm9NDIUJ4o
   L+n7qSBpSr/UBjYzNSpjPhi4mI/v/JGmuYlrcbXDRGsBol68kBb9suWbk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13294324"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13294324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097903380"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097903380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:08:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:08:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOidlB85GuSOwDUni3SkDQVEL0bKIuvdneZk4hYDAC+V4TcioYdm3PeuoX9SaF8w1RGEH6r1abHNK6aKcWYf/2q9VGcJ+Fp/23bNwUBvSE06FApG3wwgejc5ATYeCXjq9O3r4Ag1K+URepl16C6wt9L4A9TALBvYsjWmJJ/uQIF6NqEZAD4yeSpfrtR1g7G86q0Bw961lTjdgWYE2yDduVkQc2CBNi8MgPc0upqK8ANZktil+jnOvCEcqSTS3ECrEyj4XAzbUh1CQgIGLYASw229cg7txR/8iVu5lHYlatjxoNGpl1wuZdvNQxegDeC6638VFKkx39aklVptRbwg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3NfkS+K7A3L/1pWIOLgL7fdAq96sR95H71EF+jnj3Q=;
 b=Lt9rMd0Z/3Z0fzoQOAaSrWR0dQttECKN0UGVTfN8ULnesnygd70JDJTE+NjW/iD3Ye8h3G4vhQzVWUMOHZJJSRRmeoxbrq7iaCjJC7OPwVSyzYd9drxPgISJp9GHbR2BSi36QHe9gHwlODlpOFxwu8lkGWhN2IWnkMqc+uV1OYOgzv/DjzPkqqBtYXBOSohNJtNVpYYYLshTwvPxrBKKlrn4aorT16ar1UUPIAObeo4v3q3xGhLtshuAkkiOZLC+s1VoOtrwVKVbYuqgL3Lec1BwQrX1eqkCnct5paPkeMB36313boWgiXW0KETlAdvAh7P0/0b6TY7rHzlqr153KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:08:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:08:05 +0000
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
Subject: Re: [PATCHv3 01/14] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Topic: [PATCHv3 01/14] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Thread-Index: AQHaF7t2S8M+YAtB4EyYvs4vOfgvD7CED6SA
Date:   Tue, 21 Nov 2023 02:08:05 +0000
Message-ID: <593f33e7888e92f1a24c6b21e3f53a6a13d991f1.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5016:EE_
x-ms-office365-filtering-correlation-id: cbe2e22e-761f-4be7-e604-08dbea36b316
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qSibf7hhVp8Qm3z75NRdwfxJQnpH5hGfaEcqWmKX8N81kPc0pU6ra4KNfLtvlmPH4Yxc8WaNsjgNOht2E8ZMwr6Z6pgzuy504eRsDkZ6GPeGgmHT/D6jiP0vfuEzpZdHP6IGKDEg9CP9ybFof7u6nNMFR5PfOv8eSWcrfBsJ61GvqK6vYlTN6vnHA0Ixb0chqPZcjTULDGjdET43ujFUWcnlzwTMZfhboonh8gZo+1SZltc5ZTwWnhAMrEq26n2Jutejy9TD0f/bwwvtbi9ZCCK5q2hkmujGmmqO1bpVlj2Dn88Num/plU4mIqBRZgZo8fgIuvuMCqDAowtbd+CszfLzIuesiJyREvnTZg1h5uAMkI8fHItDo5sCxhxgpkJ4cLwOM+eEV3ZVT8M+WusXJISV2FuPo8xLj6hwWlyGjGjhH9lAFpr65iQpAuvrpdIYGRY9c3sLroAM+pXn60d5yuqQunTRg6ZxM352X15EV5DEu7lkcW9YmW+8mSDiS9/nmz59CGO1KJD6eUY5NGxHiSXsLvWOYk2hs1hI+nteGy0Hd04bsMAo6/pDiLH5aVBkrUwM4UjP2RZjlgmKCSv9pnyy3mC0ac4a5JcXQgAy8tptmJwwKWwIehTBVr2WP6h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(86362001)(5660300002)(4744005)(7416002)(4001150100001)(2906002)(38070700009)(6512007)(26005)(82960400001)(2616005)(478600001)(71200400001)(83380400001)(122000001)(6486002)(6506007)(38100700002)(76116006)(91956017)(316002)(4326008)(110136005)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWlMV2NZTmZzUjFCR1RTb2pxSWs2aXVlQy9QUnZDRVdEWmxTUGVidzBMaW5j?=
 =?utf-8?B?NmdTUU9KR0ltd3EvZ3ArS3lyY0l2MUorcmtrOGZpNFljbmorYkxoeitVb2Jm?=
 =?utf-8?B?WTVyNU5CR1QvWDM0VkdvdzNmc3U0dlVQeUh0M0l1czIyWWk5MmROVXgrZ25J?=
 =?utf-8?B?UUNpditxNjRwaFhienpKRUxDUitULzh1QjBUYnpCOENmek5OYWtvU3pXdWQz?=
 =?utf-8?B?TktMYWVVMnJ3OGdycXZOTDFDdVlza2dMRzRSUmdtZ0FNMzZSQ1hNWEViYVBy?=
 =?utf-8?B?S0NoOVhFL2dvUGhWU0tOVE93Tkh4VHVGNTJManR5b1dJbnRiRFJta3dRY3dW?=
 =?utf-8?B?bGxwajl4Z0UwdXVnQ3ZreXBnYjFIYTVRMmJYbzJMejd6YnBYTmJIdUFLb1Fr?=
 =?utf-8?B?N3pRblpRK3hPZzZIZzRWS1MweE9jL2dUc3BndmRNQWpoQ2lsckRxK05PN29X?=
 =?utf-8?B?VGc2endvS2xwN3V0eVhKMHAvZlZBN3I4VzdhWXNNa08wMStuNmpOdm02cEdp?=
 =?utf-8?B?STk2cHVleE9TbWR0a0YrMFA5MnZIM3JnREcxL2FnRzU2Z3h0QjdnbUF1NGxw?=
 =?utf-8?B?Y0ZDNnRxQlVyWU54KzNzNVh1Tkp6U01KcVliNDlZVUZGQ0hWc2U2a3NFcCtZ?=
 =?utf-8?B?S1ltODNvUThMM2NKRCtINmRjKy9aUnYxUWl6Slp2Z1BXNmFMSTQ1UGdHVVl5?=
 =?utf-8?B?dXcyODdpb203bGlLTHBHRmZuNHRjQ2FZR0ROaUY1RnRFSTQ5WnYvRjJJQUIz?=
 =?utf-8?B?WVgzc2Y1aVpCVk9Dc2lxY251RTFmOTFIU0lya01GZVNWZDk3TFIrem1WTzlT?=
 =?utf-8?B?eFc5RnY0eGZxbzN3UzBJTVpkRXVmb1dObDJhUWF0NkUrZGZUYlVneWN2K2Zq?=
 =?utf-8?B?UHdib0JWVnBKSHRIT3VEcE1DTXBFdHZWVTFMaUphVTV2QTJPcVlaWGpQRU9v?=
 =?utf-8?B?aVM0QW9RSXpscjkvbjZhQ0RCZmh3dnBRN1hOSFlsUXdOYWY2clpLYzRBOXZV?=
 =?utf-8?B?K0hMR1JQTkl3bjg3RGljbnVoRkJZejlUT1pFWTNLRlhWSzZDSzB0ZERGVi9a?=
 =?utf-8?B?c0xyY2drWmtyaGowUHJuREJ6bTMyeWhOZUtubkZzTjBpdmYxSDVrZ09PSlZX?=
 =?utf-8?B?eklEK0pVUFQxTVpVaFlFNnlLaENGa1VuaitEWWVtR2R3UWlMS0FUWWcrcnNZ?=
 =?utf-8?B?cThZbW4xSHAyd3V5SjlLL2hWeWcxeG1nSkRuQ1Q3eVg3UzlUbDVKVDgzbGI0?=
 =?utf-8?B?YmF6dExKY291aHVkNmxQRlZwb0dBNWFwNGNBU2toUWNCTjZvZVhVSWd3QkdG?=
 =?utf-8?B?MitnTHNycFBQb01HZ2lhYjJGUFZyNFlwbkhBOE93ZjJFc2RISldxR1pjNnE3?=
 =?utf-8?B?Q0p6dGVXNmtVMjJ5VklNcWFveW5wNlNxME9UZVdNeXdJc3Z1QjlkV2laWTVS?=
 =?utf-8?B?ZGpqc1gwMGU4UG8zanFGRFB4UjQwTVp0UWgzdDB3TmNiSWFPcGdydFZvb3Y2?=
 =?utf-8?B?UG01dExDK0hZakJJb0ZQMU9kSENYajM4eEcxWkN1bWdRY2FyOWdpWmtqRTBy?=
 =?utf-8?B?TnpJS1dmaCtoeGsrSXJQZ01GRU80MkhNMVVFUmhPWkowM2tTL0NRQXNBNnND?=
 =?utf-8?B?Wi82am5Ed0U5cnBnM01GRDlqZ0dBdllhM1I0eDVEdmM5SURKaGZSdzEvbjVu?=
 =?utf-8?B?M3h3eHUxSk9YbmdNQmg4UThNNmMzOWV3VFJhUUF0UmNpTVYzSVdNSDJrWk1a?=
 =?utf-8?B?QmpiMC9CTDRlRzE4SStvNHNWMDNXeW9teUxGa1p2VndTaGlmU1E0dkM4aXlo?=
 =?utf-8?B?NWt1azZ1bG5USzQ3NlJicjM5U09NMVI1emxheERQaitZYlBPd3FwcEtEWGx1?=
 =?utf-8?B?cEpKZDMxaEhKWjhxYW1tNDJvMW0yNVZEUmF5NDZKTDhMWDlWZUIyd0VQOUhp?=
 =?utf-8?B?VEtiRlZXYUZLMTRqYWJMTE5xZW83T0p4VnJuZ1JnQWdBUjJzTlpEQ1h6WWY2?=
 =?utf-8?B?VnMwdkNSbWh3QmZyOUxqcm04T3VvcE02ekY5ZlVoYzZpTDB3Rm9pOXpFQURY?=
 =?utf-8?B?SzF6QW9EUEZmMnZ5aHRGeU5TZUxBTUlySUppYTh5M1pEOEZBQkhhQXptVTZo?=
 =?utf-8?B?MWFiRDJ0MllYVFJuZ3YrbXFSTFp3czNkQzd0ak4yZXg3RDFhSDJPRnhsdG95?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AFD9CCCFDF1724F8B2443974966CF85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe2e22e-761f-4be7-e604-08dbea36b316
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:08:05.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao7btIXxhN7w+BT5DM/BBjGido7pHU3VYl3LtlWPozxR+lBm8DwEgjNgzHHUg4ivyej98ljhgqJSmMNyluRY3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTE1IGF0IDE1OjAwICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEluIG9yZGVyIHRvIHByZXBhcmUgZm9yIHRoZSBleHBhbnNpb24gb2Ygc3VwcG9ydCBm
b3IgdGhlIEFDUEkgTUFEVA0KPiB3YWtldXAgbWV0aG9kLCBtb3ZlIHRoZSByZWxldmFudCBjb2Rl
IGludG8gYSBzZXBhcmF0ZSBmaWxlLg0KPiANCj4gSW50cm9kdWNlIGEgbmV3IGNvbmZpZ3VyYXRp
b24gb3B0aW9uIHRvIGNsZWFybHkgaW5kaWNhdGUgZGVwZW5kZW5jaWVzDQo+IHdpdGhvdXQgdGhl
IHVzZSBvZiBpZmRlZnMuDQo+IA0KPiBUaGVyZSBoYXZlIGJlZW4gbm8gZnVuY3Rpb25hbCBjaGFu
Z2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1
dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS3VwcHVzd2FteSBTYXRoeWFu
YXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCg0K
QWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0K
