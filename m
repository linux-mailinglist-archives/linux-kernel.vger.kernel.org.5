Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953EE810BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjLMHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjLMHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:38:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72819B7;
        Tue, 12 Dec 2023 23:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702453145; x=1733989145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m6k7CLqDfW5GlxEhJIcbmCZpnHo/zNj+/NxKQZYQXjU=;
  b=oJV+cHNWEW954dMmv8ZgfzE0PJn1/RsK4znF3VnS4eB7rMRMgkNw6otK
   xClZkpfs7HUizj0yZzRBnbnrqymDo9dgT5b7uaQd/VzFyi++wSRLACCf9
   NNAxMdmgFQO+HjOhRudjiNj7Y5iL5QhlGfBpQEjM1uLIvtpj+AgGmLeQ5
   6VY9OoDaIzVd6kLuoYJPE/LFDxAmSd9/hfkxuX6KaE9PifFqZPn6zztma
   21n900dm4DQm1h0ZhIoe64jTtDRCPXg57VSVfNYcx9+l9PhSmXPvT8ECJ
   TpkJPnNlwJTsJmsk0s3iPQacBwxsYLKZR2sAHbWP9IYO9Bj0QBzEixxKM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="393799572"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="393799572"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="21852395"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 23:39:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 23:39:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 23:39:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 23:39:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 23:39:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efagSRKI3juBfd9PZHrO2WyzerTGO8uW4vgoSy2Y1WSuIe8oMjgzWAkzY5H+7Elp067zTjUz7ftqqVmjnP+ugKZEaXT/TKLFREecmo+dKN4bK1cFRy7zC3y5WGh5D1NViqIOMy5qJujtDijrXj9lIB1wRBmW3+W/HssehlkFBieDD5/betq2OfHu462gLCA5kWP4iaG4Ql1lxz3mvqT/6wGYeITAokg1v725jcI+Z0aeUXu2AJFrYVwXs+IXvaJDhOUd/ejVrCAsE19/T8NgohWZaxmbemrgzSHt0Dl9qkEZzuX+YFUMj4EVOj8ConueTJdxjFQ6e/VioqKCouzpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6k7CLqDfW5GlxEhJIcbmCZpnHo/zNj+/NxKQZYQXjU=;
 b=YR8fr7ZDPa+IUM1H7xAR7Drs/qR06ML2waencHmbawd8oMmv263MvaBX4n8QD0ODF2fZec8kHXIGm6Qvt9h8EuQ270U0cs37lzaQxIV1KH58ujuGMB7nFdnIyTfnDU8l34CnlS+CJPsOmH181I8u0nZGsperJkUXTHfvt6cby+2rVuGm1pkujJFCNWrHqM1oHMoRyaxuC0qe8cqlUpN7En3HB730J61sEuANjyM0AAtTUlxBWvRASU8YfPpG/kJAx84vdNYHBAZIWR1/m+P96f7qATS30WE//rOfw+cKmfduh8251oV6KVM5+laD5xfU3NC97SgfH9B3DsqHH2PVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:39:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 07:39:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
CC:     "andres@anarazel.de" <andres@anarazel.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCAHiuoAIAA69wA
Date:   Wed, 13 Dec 2023 07:39:00 +0000
Message-ID: <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
References: <87ttonpbnr.ffs@tglx>
In-Reply-To: <87ttonpbnr.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|LV3PR11MB8530:EE_
x-ms-office365-filtering-correlation-id: 9640d9ce-7b09-436f-38c9-08dbfbae9253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m0v0VgY79VfYgXtclUzWkWsOsVf+ktU5tR0PnKtx7nTRksW/qWNyrQYOBs2aXsory5cpSrwz4y+BbZ0+NWc5dMCp2NavJfaLY1YTJ6PPcX2a9cE7HXqTk81WxqxSFVoUn/xdzugRIFK/VHIFN4xj2jBDSGWojbN9/8afSS79F9KR7IHk5LOQdQEPOP0k/Yo9famdKwOlb4QMb+m2LN6wJXARZIsRMifXcfyNXhU2gb7z1gOR6wT+ApkJhW9GF8RBb2chYZQdWmKxS/ka5fTnV8BsQHYBFo0C8DJ0X+xe2ZzFUVrURhEGY0DFH7PNe1zFpHfDFFgvv5iNnsiE4ovOXpfTdl1yOig/RIFV0VbsUt0hMy3tSWyLH8j5a7rq8bTrh7s10hbYyPE7bD0nYXntVHkxIWr7J5Ez2KxQpbkr3cFEz2WwqvalHgOYcgG1o7s9+PQqAyy4LEOo+KYD5wodhxhIUalKi4kapSrWoOMT8nuqmG3uoUQ7IepS7q5UEwZ0UgnYn889249luqGBKAhGraU6oVFSZV1OyXiog4qg3eSbruQ8K/+yZ4siLah9GH7VUF0DWqlfcdb0nq/3RKLlMj15BeVzZ2FcxL7lfvrMw0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6512007)(6506007)(2616005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(966005)(6486002)(71200400001)(478600001)(316002)(54906003)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(91956017)(110136005)(36756003)(86362001)(122000001)(38100700002)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGg4K1NxeWdzMktVR1pDOGhXQVl2Tk5zNjRrRW9PZktHbWtTMGljbjVyUWhj?=
 =?utf-8?B?NDNRTkVHMEx6UjJXZnNXN3p1enFKQllMSzZOVXBKSEc2TEd0VDFhaittbU9P?=
 =?utf-8?B?NXgvNERGUkFwVHltK2VUT3dzeEZ2ZzV3Witzczkra1ZESytmNTRuR0FHZ0Iv?=
 =?utf-8?B?WGNLVkorNmZXelZlK1dJM2xLc0ROSisvOVpQSVFLb2NJMTF5Q25SMSsxS0U2?=
 =?utf-8?B?elh1SnF5REN6VHVhVk1NTDkvb09haERzMTJTSTRFRnAxZTBtQWkxcDQrTnIv?=
 =?utf-8?B?cmE3MjNpYTZGeURUa0I3MnJCSzAycG12NmZXR2lpRnpjQUFPekRRRXFPRmVV?=
 =?utf-8?B?R3NvVWdvWGhQdXA1WHBtTkdodWFreFV1MzRmUGlsOFFCaUNrYlErUlR0Q2ht?=
 =?utf-8?B?Q1FMK2JlMW1lQ2w5L2pOMHc0S0t5cXJZQi9VT1BWSmI1R0tqVktjc1V6NUNR?=
 =?utf-8?B?YW52UVdHWGd1T00zbFF0MkE5UUxldWZTNzYwbExiZjNISUpQUFVCR2plYXBi?=
 =?utf-8?B?SW9Pdmc5aFJmeVlOQVNuRXJnWWFSbkZnaFhMQmRaYXVMVzBxQU9sL3hJZDRh?=
 =?utf-8?B?aldkNnJuL1gwSWdTOFZyTVJCZlhHNmVBYkpKT0R2a0c1N0hUVXlTUCtmQWhV?=
 =?utf-8?B?bHNsSEZpUkc3OGZBcVhWOHpLRkloMVF2aVBjaXA0dTFCbm01Zmx5MFFGR3Vp?=
 =?utf-8?B?WXM1Q25yS2s5TVhiWnZKQTZKSzUxS055K20rQXdyMnhyaWE1UXVadzcyU2NV?=
 =?utf-8?B?VU45cGRmWEgvQmR4N0t0eDl1dS9kc1c5NE1TclBHaC9QWmwwZHFyaWR3UWYx?=
 =?utf-8?B?eGVqelFNaFRDVXo5Z1llUzIwTncrQ1pZZ2hMYVFnYk5WcklGbDdib0owQVRE?=
 =?utf-8?B?dmFTWktlNThJYTFXd0V0OGY5UStFdll1Q2lRKzNuK2p4QUgxWG1GaUw4SjIz?=
 =?utf-8?B?WlN6ejIyeEhEWUxuZ2N2cTh4NWtSUjQrbmtRSzR5RTVtSVZOM0FJMjBMS1k2?=
 =?utf-8?B?c2djNDJxaWpNaGk5R0hlMktlVy9aTmc4WmFMbG5PemtlUXN4M0s0WkJGWjBq?=
 =?utf-8?B?VEhwcm0wNjZKUVRWVENnV1hlYy9EVlVSM2lnYzZldU9SbUdsdXFVQXVXNDlr?=
 =?utf-8?B?Um95OUl4b08zTm1uSGRJZ0dQRks5eVJmQ0xCMVNvMnMrRVpyWFBaWTdjeGRi?=
 =?utf-8?B?a2t4UGVNbDBjbHF0QUtpa1hjQmlkd3IybnIvK3dtZVNXbEJCTmJiRkxCM2RP?=
 =?utf-8?B?ZVdqOFNmRlNaQ3VuTVNFVVZjQjlEQm1sZzg2VzNXL05pdjJ1bkZMdG5JWDQw?=
 =?utf-8?B?MEF0aVplWVFSMXVmaUFoYTRyNFZwT3Q2OXV4Ti9tOFc5TGFLOVpGNnJuQTNG?=
 =?utf-8?B?WjBJbkdFQXVTZ2hqZmo2TGxEajBBSHJLRlNNR2UrM3dWQW1KSU1vTzF3SEpU?=
 =?utf-8?B?UlBaNkkxMTMxS2ljMlZoYitqRFJtMGxHMTFIU1Vrb0Y5R2doYkJlamdYaFV0?=
 =?utf-8?B?U1REem9HS0xmM0RTUjFFaFJYNTdVU2IyVERrdCtlSzUyMjJ4OWZzUVJ1S2lH?=
 =?utf-8?B?KzBmYWFOS0xvakhxeGg5SWFUU0pZaUdYNlRVM0VuSWVZL2lpaGIrTmYrbWVE?=
 =?utf-8?B?MjBUWnVjWWtoYkl0WmtQT0loeExJLytDeE5CUHFXRFY2TTFMc2w5aFFYS2pO?=
 =?utf-8?B?TXFzb3ZlMTIwWWl5SnVNSDg0bjVDMkUzQ2lzSkdRTG5FUTUza3FmMzM1U0ly?=
 =?utf-8?B?ai9WNXJVdlllVlZKVUgzWi9KV3hYd0w0NkhqNXJjM1h2dTlGYWFlY1kxV0pM?=
 =?utf-8?B?VWhzeGtVNzRHeW9NV1YybkVDRDMzNHdUS1ZTSTdjaE10MnRjaGJCdm5NYk04?=
 =?utf-8?B?SDBTcnlOLzFjZGpkVy94K0g5eUlLeWoybEpBaUNlYzYzaWptdkl2WXJmYm9a?=
 =?utf-8?B?SU5rZkM4aVAzZWJPQ0V3UHY1QTN2R0V4OWE3T3JRVVlSVjYwQ01jTjFHUmNy?=
 =?utf-8?B?eGdYWkN0bFRrMmhSSUdKMXNzRW5TazgrNmVqd2tIWlYyREJHeUhZTnZHMW9M?=
 =?utf-8?B?QkM4L1MyZGxvdldXRHRONER2NWdmZlJidTNMQkcrdEdYR282cFpWb1RjY0x6?=
 =?utf-8?B?ZGVYWXU3TktpaVBHdmtSSGRVMEVYMEkwaktFMWoybldjZm1OSlBXcHprTkNB?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F7A5D572ACD6747B4E3B1E9DC3B26EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9640d9ce-7b09-436f-38c9-08dbfbae9253
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 07:39:00.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgwHozKIyalaVGGeZRhhiUkhJaWDYH2Pw1wtGGnLbFe8Am6K7sCMS0ClL8TDiHHDeoHW/74bvG0PjYKBKwZJ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiBUaGUgc2ltcGxlIGNoYW5nZSBiZWxvdyBzaG91bGQgZG8gdGhlIHRyaWNrLgo+IApZZWFo
LCBJIGFncmVlLgoKSSBoYXZlIHBvc3RlZCBhIHBhdGNoIHRvIGRvIG1vcmUgc3RyaWN0IGNoZWNr
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTIxMDE0MzkyNS4zODcyMi0xLXJ1aS56
aGFuZ0BpbnRlbC5jb20vCmluIGNhc2UgdGhlcmUgYXJlIHNvbWUgd2VpcmQgY2FzZXMgdGhhdCBM
QVBJQyBmYWlscyB0byBwcm9iZSBhbnkKZW5hYmxlZCBDUFUgYW5kIHdlIGFsc28gbG9zZSB0aGUg
WDJBUElDIGNwdXMuCgpFaXRoZXIgb2YgdGhlIHBhdGNoZXMgc2hvdWxkIGZpeCB0aGVzZSB0d28g
cmVncmVzc2lvbnMgcmVwb3J0ZWQuCgp0aGFua3MsCnJ1aQoKPiBUaGFua3MsCj4gCj4gwqDCoMKg
wqDCoMKgwqAgdGdseAo+IC0tLQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9i
b290LmMKPiBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYwo+IGluZGV4IDFhMGRkODBkODFh
Yy4uODVhM2NlMmEzNjY2IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3Qu
Ywo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYwo+IEBAIC0yOTMsNiArMjkzLDcg
QEAgYWNwaV9wYXJzZV9sYXBpYyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKgo+IGhlYWRl
ciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByb2Nlc3Nvci0+cHJvY2Vzc29yX2lkLCAvKiBB
Q1BJIElEICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByb2Nlc3Nvci0+bGFwaWNfZmxhZ3MgJgo+IEFDUElfTUFEVF9FTkFCTEVEKTsK
PiDCoAo+ICvCoMKgwqDCoMKgwqDCoGhhc19sYXBpY19jcHVzID0gdHJ1ZTsKPiDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiBAQCAtMTEzNCw3ICsxMTM1LDYgQEAgc3RhdGlj
IGludCBfX2luaXQKPiBhY3BpX3BhcnNlX21hZHRfbGFwaWNfZW50cmllcyh2b2lkKQo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIWNvdW50KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb3VudCA9Cj4gYWNwaV90YWJsZV9wYXJzZV9tYWR0KEFDUElfTUFEVF9UWVBFX0xPQ0FMX0FQ
SUMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhY3BpX3BhcnNlX2xhcGljLAo+IE1BWF9MT0NB
TF9BUElDKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGFzX2xhcGljX2NwdXMg
PSBjb3VudCA+IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4MmNvdW50ID0K
PiBhY3BpX3RhYmxlX3BhcnNlX21hZHQoQUNQSV9NQURUX1RZUEVfTE9DQUxfWDJBUElDLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9wYXJzZV94MmFwaWMsCj4gTUFYX0xPQ0FMX0FQSUMp
Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gCgo=
