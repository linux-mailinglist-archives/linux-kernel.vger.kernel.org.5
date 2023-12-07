Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF0807EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443076AbjLGCld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjLGClc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:41:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085AD51;
        Wed,  6 Dec 2023 18:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701916897; x=1733452897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v2voJUNXMYu9uM4jxWofpO2GfkxtHFaNA7c/GZRg6uU=;
  b=hQWjMqV3VXzI1c4/j+ioZaSQ1H+E9Qukkc/uSjREmRgPM52itcCxFS2p
   rIfoQyUW2G2s5AUYsNf6n4uCHvnx9VuzLrpX6wcALh1SjeCw5ayBCKGEB
   nEY2Az9iZQvd85vB1Rd6P7eicIZm+xd6Fx/p5Elz2ZnPwyulupz1XJ7Ql
   Z58C/JLYiVk50W4IlrlBXCLToRo+NGF/pIKLJeF3TlOmJlzo/30MMgzYO
   0w3zEU3xc76yJJvc16co57QFPq2BsW5H7maDDnkDEEokBAZk20q0AQ46i
   GIRFSX+UhF9RFLQxs0JEqgV0i9ll5Yl6NHS3nBsuLaWAJ5RZ9uCQc0kjo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393033179"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393033179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="862314325"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="862314325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 18:41:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 18:41:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 18:41:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 18:41:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7BScYA1byyQy/Wk1BDAXGKIxqp0HYMhZ1iR1AQfqKVTZebz+lB7vQv8jg+idCMNCM9Sse6iPWcT4pOQJWht0c1F0sZC5pINFy99qyMdGvtgoD4Nn2qAO2083pW0ej22LzPxIVIFZqkZh9UPmx3IUsJhMbtpX3RYP6JLQOG33CpmYU5m3cQvg94va8Tbm/cyK+RS1VGn6r/6ZyF/Ugh7CQ0Uuyql+YlpAuKi19h4lQ6QljFJajybOZ4o4VdR+gPWKHEGBQpURQ9X15RZwdCLtsvj/AE3igESiwcLrDIBGOhGOWzYlB2j5l17dKXlVtRJQsCqqfOdooQqKizW2FaSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2voJUNXMYu9uM4jxWofpO2GfkxtHFaNA7c/GZRg6uU=;
 b=AdDY4CoYbPA9sdKUOWoIDJ7gZRG6+vz7CeFGojkJsWRKrQJrECP1T/Y0e/wG4zdzEzErgGkSrm3EK2EE0Drsb+WMCzknEWDuCVju/dyuAkDuXDOXZjkKEZyMtG0wApdRzC+Wpt4jHDJi8CAFH/GKaSg1STwxwDB/LeKslGd31YcY1xCNURBRPsmwbencSlZ9ngu+SVQoDtUycf0voIieT96OVpw6jFyJsU21LjlbhhEzL4VfcAU5E2lSHJJ52XHYulAIyDaGApfQ0ii/TB5+P+h4Dnqngqtun/M9cOIFH2V98XuB2n9oTMbhtYcDB3Y7nzKHQSdLMRPrdzfg3suwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 02:41:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Thu, 7 Dec 2023
 02:41:34 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "andres@anarazel.de" <andres@anarazel.de>
CC:     "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCADEpKAIAHwbEAgAFKcgA=
Date:   Thu, 7 Dec 2023 02:41:34 +0000
Message-ID: <c3b064004a1748c68829f804b3da56a610fbfc8e.camel@intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
         <20231122221947.781812-1-jsperbeck@google.com>
         <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
         <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
         <20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de>
In-Reply-To: <20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB6765:EE_
x-ms-office365-filtering-correlation-id: d41849ac-8a0a-47a0-5eb4-08dbf6ce06ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVRNKeXp0FPWKGgs01Mj47UQdmmoQQuqfS8xzOfSY4lz+nTjdwUNSkgFU+eEd2Z6yzerBXK62vfiAgWyvVih+ZQcIqJB4eUf+7ILkB0dsROMQqzcRvxla2h+ZZKZ87Ge2J4UqFZp6PAzHqxCho2YDce3XQROzlw/Ia7qqNvjdlCatyGSu0enD/t2ankigCV+RhbEfL3FFS1MMdCiiXDfZmSLZCB703doq1NdyNp+zCdH4Wz0u5RTiYqSpV7i09hPCPBRPxpk+cHVETfNS/k08gKMAsCvrsmT7gWY8dXd29tJml9eGGuTA9jRUF2awAYS8icDCqqv0n+dTQDSS3W1fWLhJ/R7tG33Ux04IhhyuzgUoD91Rx+XqwdLlClHDLXdLS7huQSkQZlhp+4Dtu4pb9rFVWq5h2iF0gl/om2lNPHf6jHjzuagPQOW9qrbp6aDWFSZcYg2H0PRB52z04jG5WlyxbXfnTgIDwQBMY4Hy6iM62xlxIydv/dTwAI3ojTNxWcEhl7ph17rsUHfeh6AGE4ky0qvpazcqan6Rqr6kPv3pIgizUpEr+Inea2l+sqrfauIy9jnTxBV/7SP1W9i9OVbhFvCqNZRLcbPvC6VRR3i8Zp6YYG42sA5/GoDyt8hvKrUV3KQH635hPdeZeexsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(122000001)(36756003)(41300700001)(38100700002)(82960400001)(38070700009)(2906002)(6512007)(2616005)(26005)(7416002)(71200400001)(53546011)(478600001)(6486002)(5660300002)(966005)(86362001)(91956017)(76116006)(6506007)(54906003)(66476007)(66946007)(6916009)(8936002)(64756008)(66446008)(316002)(66556008)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0tCUGduZkxGNlRaYXViT0E1eEtxcGxiOGFVNjVlcXIvK0tpaGJQSWkxS0da?=
 =?utf-8?B?ZGFNUlQ3b0cyYVNaeHlWWE4weGtlWnlMZTRndGhRNTkva0RpdFA0Y1dTN2M4?=
 =?utf-8?B?cFN6THNjN2NlMk40RmhkY0ZFOXUyRzdBSFNyVXNxTXlFSmtJY3JhMEtsMlBU?=
 =?utf-8?B?L0o4aEZZemlwS3NyK3hqVEM3N1Z4QVdiNk02RkR4ZlBra0hBNzBzNHZkWmp6?=
 =?utf-8?B?dlROaldPN0MxTlhHRlZUdTlGUmFjd1E5VkFoTVlicXlQNDl5bFc1cmpPM01I?=
 =?utf-8?B?aDdzWlYyNUZsbW45cXhsd00rYnRwTTdpdmFDMFdBcVIwKzNVbU5UYjI1Q1Yv?=
 =?utf-8?B?bUVIb25FWHVLWDZvWGI0V21wUVBLM2NTZUhTOG0zcm9tRFFva0RMa0JoVkJJ?=
 =?utf-8?B?bEg4WXQ0NVIyMmJPay8yT0hDeFRWT2JQdHF6dmUycUd5YWhDMWdpclB5c2pS?=
 =?utf-8?B?YTdHaGZjclRyelJUTEk4MFlrK2w4WFY1UnppQzQvRlcrWmxPSnlhV0JRZU1D?=
 =?utf-8?B?SUREM2NRTXZZbDB3MHVuem9QajQ4VnhKM3ZsN2FXUmNFUDFUUC8wbWIrajU0?=
 =?utf-8?B?R3VwNHE1Z2t5bDhXUzlwTmFPc2t6VjhRb1Q5WXNRWkZ1Mm1VM3hvUDhVenpa?=
 =?utf-8?B?dU5aVGtGMmVtclVkTGhyblFpNzMrdEprc1ZkYldWWlJOUy9CSW81Rlljemxm?=
 =?utf-8?B?Nmo4RmNtVmdtZ0MzVFpsZlRONytZZ2dHb2YvKzBZaVU3Q0VGbjhNNVRkODcx?=
 =?utf-8?B?c25GRTk1d3Mrd0ZSTXpkNmpaekt6SFlpNElHWnIrZFdjM0JzenhDeGx6Vndz?=
 =?utf-8?B?SWozcWhBQld2UHhDY2FmNGZEYWswQVhYM2NRb2dSQ01zRkFMVlFZUjljUGRF?=
 =?utf-8?B?YldWZ2FFSDVTSFkrR2hYSThES2VCcGJ5bmRMelZYRDBlakhOV2Q4c09DeHVl?=
 =?utf-8?B?VittUHN1MmlRU2FXK3dDbS93ZlFzUnBtVmk2NTN3SjBxUE1YTUxyOHQ5dDBQ?=
 =?utf-8?B?bEczMVc3N05GV0QzSm9qYlhrK054UmZUREZ3K1NCbHFySndCV0NyK0RKVzhv?=
 =?utf-8?B?Qktnditka1haajBDb0phTUpuS3pENWMycHR2SW5JaUhnZE9HSUMrWlVOalZD?=
 =?utf-8?B?VkZINkt2eWtJWGlucHowTk1PZVhwQWFpaG5ON0hKYXdQa00rSmUrNU1jdnFU?=
 =?utf-8?B?bS9Lb3hrc05oYllTVUh4M2I4WTlGOHJhNTE0MVFhUWsxT2J4OE04ZHR4aVB1?=
 =?utf-8?B?b0FCYXhlaXVMZmlTMkFmczBGR1dNQUxmcEE0TzBjWjJIMHQ3aS9zVW5mODhZ?=
 =?utf-8?B?cjdaclEzYjJMUitlcmJoelpDblNYQVE2UmhVMmFCb1NXa0o5bFFlMUNpajBL?=
 =?utf-8?B?ak1RTnlxWlU2c2hFZitkQTdOUitNWnNvWlFHZ3ZwU0xWSDJGaDFwbldVQlo2?=
 =?utf-8?B?TWtna3dVNGVINmNxZFR6SVpjeXVsa1FXVUsrSk1lMkRoNE50ekFyQktmOGl5?=
 =?utf-8?B?OXJSa0Z5MnVTQ3ZVYUJoNVVpZUNIVEVhcVVLTGJ6dzZ3bVBwWHlpTFpyTy9W?=
 =?utf-8?B?d2pKSUZaU1BIbkJzTnI3d3Fxdmd0akJoVCsra1poTFhHcjJRcjVOUi9sM1pa?=
 =?utf-8?B?YkZwRTM4NHlIdXRpeWQzOUcxOEhhRWRhL1VYempDY2VXRk0wNEp6RWN3Y3lX?=
 =?utf-8?B?OGpkM0l0RkFFaHpnTkRFNEsvNTJsQUpTYjczbnpnYlBUOWVYMW5SVzB0eGRI?=
 =?utf-8?B?SDRXaTJGZU5WUFNFcGNhbHkrTTIydmdWT1I1OHlwdG5XcXQvRFNvMlpuUUlC?=
 =?utf-8?B?KzFIdElsVitGZUlmaVhxVnJtc01DVkZrSCtzTVRZdHRnZzh1SFN4NWl0cito?=
 =?utf-8?B?aDNOSTF1b1lKbkJhQVVXZjJMU25GQlpxUE5MY3U0TmJkWm1CeDNYcmJra3Ra?=
 =?utf-8?B?R25IUWxUZVRON2R3QUJCSHdNY2Y4U1lNMW05SnNnOVZqTDBBanZjbHh6TkxF?=
 =?utf-8?B?VG1ldjh1S1llVHpDbTliWnMra203R2xpRlR0YXhZQXVHRFlxbGpHYmc3ajBK?=
 =?utf-8?B?elNISlFhN3lvVVcvNFZUbUNncW9IcU9DSW5vaW1SQ1FGS2I3ajlDSXh4UStO?=
 =?utf-8?B?OVRQbENnL050eEhmVmpOUm43S1JQbzZOVkpxQklZVEQ2dnU3dml5L1dDcFI3?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <548819115805F845B3A67F4F3B00832B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41849ac-8a0a-47a0-5eb4-08dbf6ce06ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 02:41:34.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUImrP3u38ilx1b8ClbShl4thqdf30TDl+EuEz/kQ4132ygecaaRJwv+RnODb20otc4xvvC5uAHNyjZeQSoYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZHJlcywNCg0KT24gVHVlLCAyMDIzLTEyLTA1IGF0IDIyOjU4IC0wODAwLCBBbmRyZXMg
RnJldW5kIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIDIwMjMtMTItMDEgMDg6MzE6NDggKzAwMDAs
IFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gQXMgYSBxdWljayBmaXgsIEknbSBub3QgZ29pbmcgdG8g
Zml4IHRoZSAicG90ZW50aWFsIGlzc3VlIg0KPiA+IGRlc2NyaWJlcw0KPiA+IGFib3ZlIGJlY2F1
c2Ugd2UgaGF2ZSBub3Qgc2VlbiBhIHJlYWwgcHJvYmxlbSBjYXVzZWQgYnkgdGhpcyB5ZXQuDQo+
ID4gDQo+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoZSBiZWxvdyBwYXRjaCB0byBjb25maXJtIGlm
IHRoZSBwcm9ibGVtIGlzDQo+ID4gZ29uZSBvbg0KPiA+IHlvdXIgc3lzdGVtPw0KPiA+IFRoaXMg
cGF0Y2ggZmFsbHMgYmFjayB0byB0aGUgcHJldmlvdXMgd2F5IGFzIHNlbnQgYXQNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3cG00YnA1NHouZmZzQHRnbHgvVC8NCj4gDQo+IA0K
PiBJJ3ZlIGp1c3Qgc3BlbnQgYSBjb3VwbGUgaG91cnMgYmlzZWN0aW5nIHdoeSB1cGdyYWRpbmcg
dG8gNi43LXJjNA0KPiBsZWZ0IG1lIHdpdGgNCj4ganVzdCBhIHNpbmdsZSBDUFUgY29yZSBvbiBt
eSBkdWFsIHNvY2tldCB3b3Jrc3RhdGlvbi4NCj4gDQo+IA0KPiBiZWZvcmU6DQo+IFvCoMKgwqAg
MC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi42LjAtYW5kcmVzLTAwMDAzLWczMTI1NWUwNzJiMmUg
Li4uDQo+IC4uLg0KPiBbwqDCoMKgIDAuMDIyOTYwXSBBQ1BJOiBVc2luZyBBQ1BJIChNQURUKSBm
b3IgU01QIGNvbmZpZ3VyYXRpb24NCj4gaW5mb3JtYXRpb24NCj4gLi4uDQo+IFvCoMKgwqAgMC4w
MjI5NjhdIHNtcGJvb3Q6IEFsbG93aW5nIDQwIENQVXMsIDAgaG90cGx1ZyBDUFVzDQo+IC4uLg0K
PiBbwqDCoMKgIDAuMzQ1OTIxXSBzbXBib290OiBDUFUwOiBJbnRlbChSKSBYZW9uKFIpIEdvbGQg
NTIxNSBDUFUgQA0KPiAyLjUwR0h6IChmYW1pbHk6IDB4NiwgbW9kZWw6IDB4NTUsIHN0ZXBwaW5n
OiAweDcpDQo+IC4uLg0KPiBbwqDCoMKgIDAuMzQ3MjI5XSAuLi4uIG5vZGXCoCAjMCwgQ1BVczrC
oMKgwqDCoMKgwqDCoCAjMcKgICMywqAgIzPCoCAjNMKgICM1wqAgIzbCoA0KPiAjN8KgICM4wqAg
IzkNCj4gW8KgwqDCoCAwLjM0OTA4Ml0gLi4uLiBub2RlwqAgIzEsIENQVXM6wqDCoCAjMTAgIzEx
ICMxMiAjMTMgIzE0ICMxNSAjMTYgIzE3DQo+ICMxOCAjMTkNCj4gW8KgwqDCoCAwLjAwMzE5MF0g
c21wYm9vdDogQ1BVIDEwIENvbnZlcnRpbmcgcGh5c2ljYWwgMCB0byBsb2dpY2FsIGRpZSAxDQo+
IA0KPiBbwqDCoMKgIDAuMzYxMDUzXSAuLi4uIG5vZGXCoCAjMCwgQ1BVczrCoMKgICMyMCAjMjEg
IzIyICMyMyAjMjQgIzI1ICMyNiAjMjcNCj4gIzI4ICMyOQ0KPiBbwqDCoMKgIDAuMzYzOTkwXSAu
Li4uIG5vZGXCoCAjMSwgQ1BVczrCoMKgICMzMCAjMzEgIzMyICMzMyAjMzQgIzM1ICMzNiAjMzcN
Cj4gIzM4ICMzOQ0KPiAuLi4NCj4gW8KgwqDCoCAwLjM3MDg4Nl0gc21wOiBCcm91Z2h0IHVwIDIg
bm9kZXMsIDQwIENQVXMNCj4gW8KgwqDCoCAwLjM3MDg5MV0gc21wYm9vdDogTWF4IGxvZ2ljYWwg
cGFja2FnZXM6IDINCj4gW8KgwqDCoCAwLjM3MDg5Nl0gc21wYm9vdDogVG90YWwgb2YgNDAgcHJv
Y2Vzc29ycyBhY3RpdmF0ZWQgKDIwMDAwMC4wMA0KPiBCb2dvTUlQUykNCj4gW8KgwqDCoCAwLjQw
MzkwNV0gbm9kZSAwIGRlZmVycmVkIHBhZ2VzIGluaXRpYWxpc2VkIGluIDMybXMNCj4gW8KgwqDC
oCAwLjQwODg2NV0gbm9kZSAxIGRlZmVycmVkIHBhZ2VzIGluaXRpYWxpc2VkIGluIDM3bXMNCj4g
DQo+IA0KPiBhZnRlcjoNCj4gW8KgwqDCoCAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjYuMC1h
bmRyZXMtMDAwMDQtZ2VjOWFlZGIyYWExYSAuLi4NCj4gLi4uDQo+IFvCoMKgwqAgMC4wMjI5MzVd
IEFDUEk6IFVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbg0KPiBpbmZvcm1h
dGlvbg0KPiAuLi4NCj4gW8KgwqDCoCAwLjAyMjk0Ml0gc21wYm9vdDogQWxsb3dpbmcgMSBDUFVz
LCAwIGhvdHBsdWcgQ1BVcw0KPiAuLi4NCj4gW8KgwqDCoCAwLjM1NjQyNF0gc21wYm9vdDogQ1BV
MDogSW50ZWwoUikgWGVvbihSKSBHb2xkIDUyMTUgQ1BVIEANCj4gMi41MEdIeiAoZmFtaWx5OiAw
eDYsIG1vZGVsOiAweDU1LCBzdGVwcGluZzogMHg3KQ0KPiAuLi4NCj4gW8KgwqDCoCAwLjM1NzA5
OF0gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NCj4gW8KgwqDCoCAwLjM1NzEw
N10gc21wOiBCcm91Z2h0IHVwIDIgbm9kZXMsIDEgQ1BVDQo+IFvCoMKgwqAgMC4zNTcxMDhdIHNt
cGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxDQo+IFvCoMKgwqAgMC4zNTcxMTBdIHNtcGJv
b3Q6IFRvdGFsIG9mIDEgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDUwMDAuMDANCj4gQm9nb01JUFMp
DQo+IFvCoMKgwqAgMC43MjYyODNdIG5vZGUgMCBkZWZlcnJlZCBwYWdlcyBpbml0aWFsaXNlZCBp
biAzNjhtcw0KPiBbwqDCoMKgIDAuNzc0NzA0XSBub2RlIDEgZGVmZXJyZWQgcGFnZXMgaW5pdGlh
bGlzZWQgaW4gNDE4bXMNCj4gDQo+IA0KPiBUaGVyZSBkb2VzIHNlZW0gdG8gYmUgc29tZXRoaW5n
IG9mZiB3aXRoIHRoZSBBQ1BJIGRhdGEsIHdoZW4gYm9vdGluZw0KPiB3aXRob3V0DQo+IHRoZSBw
YXRjaCwNCg0Kd2hpY2ggcGF0Y2ggYXJlIHlvdSByZWZlcnJpbmcgdG8/IHRoZSBvcmlnaW5hbCBw
YXRjaCBpbiB0aGlzIHRocmVhZD8NCg0KRG9lcyB0aGUgc2Vjb25kIHBhdGNoIGZpeGVzIHRoZSBw
cm9ibGVtPyBJIG1lYW4gdGhlIHBhdGNoIGF0DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
OTA0Y2UyYjg3MGI4YTdmMzQxMTRmOTNhZGM3YzgxNzA0MjA4NjlkMS5jYW1lbEBpbnRlbC5jb20v
DQoNCnRoYW5rcywNCnJ1aQ0KDQoNCj4gIEkgZG8gc2VlIG1lc3NhZ2VzIGxpa2U6DQo+IFvCoMKg
wqAgMC43MTUyMjhdIEFQSUM6IE5SX0NQVVMvcG9zc2libGVfY3B1cyBsaW1pdCBvZiA0MCByZWFj
aGVkLg0KPiBQcm9jZXNzb3IgNDAvMHg3ZjAwIGlnbm9yZWQuDQo+IFvCoMKgwqAgMC43MTUyMzFd
IEFDUEk6IFVuYWJsZSB0byBtYXAgbGFwaWMgdG8gbG9naWNhbCBjcHUgbnVtYmVyDQo+IA0KPiBC
dXQgb3RoZXIgdGhhbiB0aGF0LCB0aGUgc3lzdGVtIGhhcyB3b3JrZWQgZm9yIGEgY291cGxlIHll
YXJzLg0KPiANCj4gDQo+IEl0J3Mgb2J2aW91c2x5IG5vdCBnb29kIHRvIHJlZ3Jlc3MgZnJvbSAy
eDEwLzIwIGNvcmVzL3RocmVhZHMgdG8gYQ0KPiBzaW5nbGUNCj4gY29yZS7CoMKgIEkgZ3Vlc3Mg
aXQncyBhdCBsZWFzdCBzb21ld2hhdCBmdW5ueSB0byBpbWFnaW5lIGEgMiBzb2NrZXQNCj4gc3lz
dGVtIHdpdGgNCj4gYSBzaW5nbGUgY29yZS4uLg0KPiANCj4gDQo+IEl0IHNlZW1zIHBhcnRpY3Vs
YXJseSB3b3JyeWluZyB0aGF0IHRoaXMgcGF0Y2ggaGFzIGFwcGFyZW50bHkgYmVlbg0KPiBzZWxl
Y3RlZA0KPiBmb3IgLXN0YWJsZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMx
MTIyMTUzMjEyLjg1MjA0MC0yLXNhc2hhbEBrZXJuZWwub3JnLw0KPiANCj4gRXZlbiBpZiBpdCBk
aWRuJ3QgaGF2ZSB0aGVzZSB1bmludGVuZGVkIGNvbnNlcXVlbmNlcywgaXQgc2VlbXMgbGlrZSBh
DQo+IGNvbW1pdA0KPiBsaWtlIHRoaXMgaGFyZGx5IGlzIC1zdGFibGUgbWF0ZXJpYWw/DQo+IA0K
PiANCj4gSSd2ZSBhdHRhY2hlZCAuY29uZmlnLCBkbWVzZyBvZiBhIGJvb3Qgd2l0aCBnZWM5YWVk
YjJhYTFhIGFuZCBvbmUNCj4gd2l0aA0KPiBnZWM5YWVkYjJhYTFhXi4NCj4gDQo+IEdyZWV0aW5n
cywNCj4gDQo+IEFuZHJlcyBGcmV1bmQNCg0K
