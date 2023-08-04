Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6187706F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHDRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjHDRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:19:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58814698
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691169590; x=1722705590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xVasWhZGvr4Oc2XQI54Al45p83D2/CvBY9/HLZe60Pk=;
  b=VtJmWgvY3ed388Iw/we4+821ktW1lhOJu/58QZ0pQMhTLHQVStFHUdd+
   Q+ycU2LF/douC6mPgMBZXdNA99NAIjSovkY9Ju5Y/ScwnPhjornLi3DbO
   6KPN8h/VLCzFxuWE+bUhdFBVSAKLhg0ZgSm5Xj84F1RLsqmhC8/8Yeh9s
   l7cwInJvKupIuYmphPU8fE3hiaG1UN/2GaYjG18JL0fekE8dKbLM/T/q/
   NGIfH5DHjEW0vSTpSNEXrsdofQK/uo5+MpDW0cADllhdR5m7YMF4D+AEs
   vSaWB96/Bc/FJrG8eoIT1R3MJRICX8cqQV87/qwidrXAownULr3DKuMF7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456580998"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="456580998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 10:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844155984"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="844155984"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 10:19:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:19:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 10:19:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 10:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLB4ig2KOeJefJjIFM+ZP8qbBZS6EWDgS9l3x6fCtCkVLaq91kJmtiQh0/Syl3x2Ob5KfMaIGCMve5aWjQwmZRX3eGB62IXPGcGFYShl1rE5cXQyg2s9d0OhCnNKcgMilY7uMSRqqUHUxXmLkwcQAg1YNTjax49fNEQd+5P+RfW+Wxj3yGZBYp3v9OrZws23eGn0FUWEmwwtLUlyFiWm8FRfruPy7Tvee5l7/EhjPAv+94HsxNM9oqUG70JRrrxFk/DFImcmNibRai8haLLxNsmRogus765JDUOnbbJjDUoXLg7n/oTMGHadafIEJYUrqqoIrjxZsw2y0suVWVFxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVasWhZGvr4Oc2XQI54Al45p83D2/CvBY9/HLZe60Pk=;
 b=D++4ErjwSBUiVYNTy8BDsH37IOlzPsqdOZgxnLyUJ0B3o3LEKi6pyk/o42qReCd9eXhtzM6bsPVziqFWaRde5kiDdUO7IINpSwgOo7NIO27GnQmrF83hg4VMJoCOjE48WjtBwUAW2dQFHl6nQqjMlknRB3gXgOPCA6kitceCoAw3/OUbLpqjfPu54tvhndwc6Ku4cXDPcdc2oKj2SOCCp4TNfrkB38GkyYPVEu/7J4BmCtWzgPbOszOhqyL6ixN7FqiDJ4oN2hSxvZgS858muPxUJtRnCr/N8zVignc6Pal4dLVjaI+bX4as7JRk72jKGEz/iU49yaoOs3ljbYbeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:19:45 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:19:45 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>
Subject: RE: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Topic: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Index: AQHZxq1luoPee3LE20qWOZPEmJublq/Z7qYAgABzAbA=
Date:   Fri, 4 Aug 2023 17:19:45 +0000
Message-ID: <SA1PR11MB6734A92B97F4A4A51AE3CCCEA809A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230804075734.8372-1-xin3.li@intel.com>
 <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
In-Reply-To: <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA2PR11MB4986:EE_
x-ms-office365-filtering-correlation-id: 64911bf5-23cf-4ebb-63ae-08db950eff77
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oo0yUJGDlLh4fxAzBSVmUJTL58GOLjzLxXz2xgkpEZ2VFkVbqWpSLQzjCpk31Ynsne8C1EGuqKYE62aY4eZ7vEOieyKtQQTEQBqLHjJYN8RJQYH9rOQO690MPq4bTk46m7Xz6gjaGFZakfLnym8gW8+ybQZeHJbYV1LKwVq2ysfkR7Q+ag+QlNZvvdFixr92HIvrjLUL/IXblBiRH29FwHs7MMa4g1GnJV3H8xBKoF/iGniRBuV8zX/gblbGvBnm3cK4deMHJJBWbmcv4W0d19e8QnC70CCpxCvKW88Q2EpZ3V3Kq4BD+UYf/Y4QIkE0pYBgC+P9wW13eIGDNb5eqQCZV4+gjBdg9e72xGKvTMsvbuV69xJvQVlJyscXMZIntgyVwPx6emPGbbKXhk5NBj4NWRITyNRuTedtNQTCEcSmk22i3meGxNT6padlY8MJHxBmfAfCDtwRcN59zfAbfUOwO83bsUwD2XSoh6Q92X9jTGlX/xCQaWwFuWU7Z4QFpo/TIMdeyMgJnF7SsCVcae0ATChpU57oPc2qE6oJopZ7+PIiM2yMeMip7aBHHvfEJBFvwksdjNUR6PcYyJGoLwHkchQ0bG37G5vtCK5aQK5oYvSXb48M24zjru5EjKehtrK98yccsPXFr4CIRrdJMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(52536014)(66476007)(66946007)(66446008)(66556008)(64756008)(4326008)(76116006)(2906002)(38100700002)(122000001)(53546011)(82960400001)(38070700005)(6506007)(7416002)(83380400001)(54906003)(110136005)(55016003)(86362001)(9686003)(26005)(478600001)(7696005)(71200400001)(33656002)(4744005)(8936002)(8676002)(5660300002)(41300700001)(316002)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHcwYWhnMWZKRUdBT2F5MnMyalBBQk1ZZjRRVno3M2JGWFJ3M3h1dlBOMVZl?=
 =?utf-8?B?QTZCUHlTUmZJSjdMTGZHZXVobXZyRGsrSjd3cDhQVGh4L0JzSTdTMzFnSmVE?=
 =?utf-8?B?VnNLN2xBeFRORlBDZHNvTGxLbHRwdUxmK2dTMkVERFNIUFJJZEVjQ2tva0F6?=
 =?utf-8?B?Tk9sdHJ4NkEzT3JPOE01d0sxYjFaZG5PdGFLT1hPdE56YzIySWhYVDh5WmVn?=
 =?utf-8?B?SVBtNm1JNmI4U1p3MnhWTzlidHF2ditMN3k3bGMxV2UrSmNtUTdDbG0xaklP?=
 =?utf-8?B?SndOVzFKSUxQeXNEeU1DVjBlMlpzZk1jOVdXVTZPTTZuQnpxTlFaSG9kRTFw?=
 =?utf-8?B?UmdSbUlEaDZrdzZRTHdESVZNOUdWQU5WNlluc3FIVTM1TFNHVGxicW1pRVZI?=
 =?utf-8?B?NStmVUYzN1d4ZXpJa1pWT0loRU91SHlmOXphTUF4Wm1OS2NmNGdrZnRZVlJ3?=
 =?utf-8?B?OEtLK21Oc29mb2drVDZTeEV1SU90OTY4dVhPSDhXajZWZFR5M2k4clRNM3h1?=
 =?utf-8?B?OUl4NjN2bStIQmRQenE1ZkgzZXVpUC9UMmNwdlBvb3hpRWVkSHFXblVKc2J0?=
 =?utf-8?B?bk41RkZHVVp3ZVlBZ1pMSDVwcHMvbDNMY3lJd3ExUVJuM2JveGszVG1hb0h1?=
 =?utf-8?B?N0ZzNVdwMnlrTmlzaEdhWUNPaCtFOUxhVWU5QmJFbURYQWtYbU03bHpzRTJn?=
 =?utf-8?B?V0QrbzcyUEZFMG5kT2dXNWNXdEt6MlFzV0c2ekVhTTExNTRRSktRUStlanBa?=
 =?utf-8?B?L2JwOTJRc3UzNWR5clhmdzJUR3VvVlU4SjFRRFMyQ0NiNXY5ekFnaGpGSFox?=
 =?utf-8?B?YnVsek5McFlURzc4YmhERGJWdWZIZlNVU2pDNndYeHZhODRtaVRYRmRyaU1k?=
 =?utf-8?B?ZjNiSVEweEJzNlpDZU5DTU04M3JYYnVTSCsrNlRXbW1wZzVUc1hoWXQ1aU1C?=
 =?utf-8?B?Z25aU3ZHdUFISmtrejFiSmNXVkZoU0xsbElSeWtmRGlrWk5PR01pWnNTcWRG?=
 =?utf-8?B?QmE3bmJIZVQ2cjUycjc4bGZPa3NlbG4rK3ptUUU2OEJCNzdqMHBTbEwyR1Mr?=
 =?utf-8?B?T0hXODVOSDhLaG1BRDZsUHhORmhCMXl2THVmS0huTGQybEhuSXJkM0N1ME9h?=
 =?utf-8?B?VkV6WGJ4dUl5c29YdGh0eHg5Q3A2cko0YmtiMEhIeVYwWGtwWFlNQTYreHVH?=
 =?utf-8?B?RXEwSHpZRzNIRUFYMVIxZ2Zja3ZNaGFPRUc4MEsyTzVDK3QxQ1c2VERNenFu?=
 =?utf-8?B?Wlc0MzJkQmpYczV0Rklndm82anptT2lOTW5YTHVqUlpHcEtWTHB2cHlldTFx?=
 =?utf-8?B?VU03c2ZKOUMzdkNDRUhDWjRSWGRlaVE4Si91VWRvaDI3Yks3SFpHbCswTXEx?=
 =?utf-8?B?SEhCUVZRNzZabFVTRkc2M04xdmcvbVJQWTRJcXJjT2ZtOUNjbXIxS0FTeWNM?=
 =?utf-8?B?QTJsZkdJTnVtb3NRZVJNODEwQ1U5UjB4TzVGMHFOQ0x4TVNHYVVXeGJSVUtX?=
 =?utf-8?B?MHM4R3pTVWFTeXFNQ1QzLzBuWTBZSy9UamRQV2VXWlNUYU1lM3JHRXFDNEZQ?=
 =?utf-8?B?bTZlU2lrTUhETXlMZGdJWjRnVy9DS0IwOTZPek1YNlV6VkdWWEZyeTlPaDd1?=
 =?utf-8?B?K2NrY0NYZjA2eEhQelpGYm1nQ0tiaUN0U1ptZUV3Qkp0NVA3cWF5Y0d5ZXd0?=
 =?utf-8?B?OFJPeS81Zy9iY09RdmFEdlFaYWpFeGtVTWlDU245S1JicmVMdGFOUXREQ2RL?=
 =?utf-8?B?WXlyNllZMVJSVWc4SFBIc09uRDJrSllvVWl5K1JKbUIvajcrUXdDcUR1Z1VJ?=
 =?utf-8?B?ak5WS0VaNE1CRGdQSmFUbDVzZ3AyTWZHYm9jdVVSaS9xY1VJTURQSXB0NmFN?=
 =?utf-8?B?ZlV0NjhjY1IzVTYyeTlOR1YwWnFvZ3dKS3ZwdkJMdlVzQStBOTRIdHU1c216?=
 =?utf-8?B?T0VrdG1Oa1VybVNhUmtjMmU2cjd0bmdERmIxbnViV3pmM01sQmExb0hVeE5K?=
 =?utf-8?B?ZkgzWmRTdGlnc3o0MGd3RVkvSUMvTzJkeG0vREYwZ1Q3aFpNREpSenlaSGtv?=
 =?utf-8?B?SjMxOXozM3pyQWlNMTl6aldHcG1OZDZRWDQxMDg1YmVDNzQ3bDNsM0VuR1lR?=
 =?utf-8?Q?/XTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64911bf5-23cf-4ebb-63ae-08db950eff77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:19:45.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3D7n1YypSfNH8m9F3m0E0GqZfuWymLo7JF8dB25I8WyvbIJkeke9qabmwLuM+FNG6cVzoPI/E0sYVhViLCmMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
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

PiBPbiAwNC8wOC8yMDIzIDg6NTcgYW0sIFhpbiBMaSB3cm90ZToNCj4gPiBJIGhhdmVuJ3QgY2hl
Y2tlZCBYZW4gaW1wbGljYXRpb25zIHdpdGggdGhpcyBjaGFuZ2UsIGkuZS4sIGRvZXMgWGVuDQo+
ID4gaHlwZXJ2aXNvciBuZWVkIHRvIGFkanVzdCBob3cgaXQgcGFzc2VzIGFyZ3VtZW50cyB0byBQ
ViBndWVzdHM/DQo+IA0KPiBUaGlzIGlzIGFuIGludGVybmFsIGRldGFpbCBvZiBob3cgTGludXgg
aGFuZGxlcyBkYXRhIG9uIGl0J3Mgc3RhY2tzLCBpc24ndCBpdD8NCg0KWWVzLCBpdCBpcyBjb21w
bGV0ZWx5IGludGVybmFsIHRvIExpbnV4Lg0KDQo+IFRoZSBYZW4gY29kZSBpbiBMaW51eCB3aWxs
IG5lZWQgYWRqdXN0bWVudCB0byBtYXRjaCwgYnV0IHRoaXMgaXMgbm90IGEgaHlwZXJ2aXNvcg0K
PiBBQkkgKHdoaWNoIG9idmlvdXNseSBjYW4ndCBhbmQgd29uJ3QgY2hhbmdlKS4NCg0KWW91J3Jl
IHJpZ2h0ISBUaGFua3MgZm9yIGNvbmZpcm1pbmchDQo=
