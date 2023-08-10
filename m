Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13CD776E82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjHJD2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:28:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38DD1B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691638092; x=1723174092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DlR7lKb5Crnn0wBABXryyE1xqG0jdK3E9rFf8X4csB0=;
  b=WdIfCBOyog/RH3SNLppFtH8b4h5epgDyjjNlti4E8ZmzS+gpwWMDnSPw
   qdsLjrGQqwop1xi2FH1chUvsV74hKAKG3GZ+siTTJmmjq3v39L2hR8Asu
   6/nwLhVNhebQ333nQoIOuILKsckmP1qEWq3wEqbY5hMr4NvZZ7GJ4Rt8V
   i6PFLNBnWtvYzhsri+FriQ4e9TX8bkJaIVQourIDpazazlEtPOvWDqczr
   29oyrIeCVd2QEbGDO5pCTHB0lw4K5DqB6ldXDjiSJl4vKjylbjj1BCbOB
   z6vu5Db6vXG6WiRTWB8c7yj3dR6Uxi2oGuxwAQqXktHO24KuYCM6x13FA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370188003"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="370188003"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="761646705"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="761646705"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2023 20:28:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:28:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:28:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 20:28:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 20:28:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFr8/S9nB6hAZtwOARtbXVxOtiQvuCDbJdyFmzlUiCHItrnH9MnFIoX8vnEgyy+gz89in+puCOL9bzXD8WLXhiBCY8SlWvvA/+Fp8RC6RiZrPikyroo+Oe745laXI4VEycRo3WRANbjpnTpYv1rtlJelAOHouEdXO2jXjM/+1IgVPST/IKdD+hhbcbJ+cmTO7hFAJbbKIsM2Zo3Qp3raBXVVBIsg8rIadfuai3p28U/cvLndEIFctHnZIbP8nMEDF09hIgGCKUOAuPanHreJmFXK4dK6JTTA748lWkBZ/wwOQFLHSZiAR6T1zVBjEozhLzdkjWWJ+i8N9U6XICadFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlR7lKb5Crnn0wBABXryyE1xqG0jdK3E9rFf8X4csB0=;
 b=lcxLmR3v1pfoJuwiGnkIV9FwLBL+40CtePn/QPdYSrnyDgQme6nZ7wgwBIbevs7UWUfC11/uLhoeG9OlhWcPWlcQa0aqHUhzlbjokxGS9PAFQ/4pfZ/NK7tqouiT0dU1nbkLe8VlIVfxCAif/IkeblOspNf46w0XO+HVnPbvlcObGWdeCg+GAxnTYgW76Dm6SbyhbGmvx5sJtYyxyNnxYMznPijtpe2iKfpHmcqHvY0fPhS5hhflv8ZD72eUn3KSz8RmzRTcKd1eI+1EGuGkAfyLxfxcPdiq7ey9a2jxMGqmcTAy8/YAkwkcpBxEhEErqzJkxttBZ+z/aa7EpHrfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:28:03 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 03:28:03 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [patch 00/53] x86/topology: The final installment
Thread-Topic: [patch 00/53] x86/topology: The final installment
Thread-Index: AQHZyTZxHw+YEDK4oEuym4xKn95VaK/guj+AgAALX4CAABZWgIAAAyOAgAAY0ICAAA17AIAABfCAgAHXlAA=
Date:   Thu, 10 Aug 2023 03:28:03 +0000
Message-ID: <28ea3d469ba8e017e60908ec26624c80cbf8a3ce.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
         <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
         <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com> <87edkdl10w.ffs@tglx>
         <20230808221039.GH212435@hirez.programming.kicks-ass.net>
         <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com> <87350tktp2.ffs@tglx>
In-Reply-To: <87350tktp2.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: 386288b2-8396-4f66-f858-08db9951ce70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cq+Yk9yfTN4tB2N9EpSB6xyebNvirm/tuNQLKHNI+fpCwRVbjYfUtzdQZKL+81rAWQju71KUaCOc+EIcl1MLHO5AsrBtQbhBwkAtDQQIeMHcoJffGhL4YxAMmBJFT44N101r9+J2j/wai5b0nMrgbEMAUFY/VxtbmCpwZd6lA5JDHnzT3jtl6H7cY5pmW+nQZ5vCiS6j8Clunr6HmUe0rILjiW10JFk+MR7OoLWii6GNHPubL3FINA3bOGM/ncfVrE8b94pdtNGuQfJFpK/ZkYdngD91I92c8Qymw8vfRqLraIHo6tShcepnuSc2IetLa3yN4ViWQMRtSBOdtfUXspLkxCNhwZkgVS8OZXjfi9eKQhBZTsV9t972JWIUAh6eU4scJg7xaFPs60XRPHrx4S7TqmIe2bHeXGGV+p2ZhBqPFsxfwKsBPVQSfxk9p/GmIeruxTJRtvD23jpBsBerMT80dPuCvmnbuLCpnAQHIywxXcMhs59lfo8BYIdvnSPCVAvIhnVS+vCBH//QAyzHGlnOzm/U+9sKh1e4fm8AJpucWH0R2WZCKvzqlRVVvEY+k2Uj4gZXPSEmoKgkPBQt8iQjCdMBcaTdlorTFH8uZh/SBr+pFRiHXRDL8RTc1X6ctFupf84Y4cgdhZm+it8yLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799006)(451199021)(186006)(36756003)(122000001)(82960400001)(38100700002)(38070700005)(86362001)(966005)(8936002)(8676002)(6486002)(5660300002)(6512007)(71200400001)(83380400001)(6506007)(2616005)(7416002)(76116006)(110136005)(91956017)(4326008)(478600001)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(26005)(2906002)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU5tS2NPSHhOS21jWE4ra3ZKUElUYlpaZzBoajRYeFc0SG4wZ1dDOW9OTllz?=
 =?utf-8?B?d0M0Q2tNd05KSEFlUjVjdDZtZ00rRHEwNjhCTDdZTW5wM0d4QVdaTmJRaTBD?=
 =?utf-8?B?RmRidHArYTlqSjNVMVRtcTlCSHNENzVQSloxcGVIejVEcDBFeXFKa05vSEpY?=
 =?utf-8?B?bFZPSVhwdytsWkRQNUdpM0R1R0dSMFVKZFV6Rjh1WVZDa1NYSlk3MXZyS2cw?=
 =?utf-8?B?NyttMnl2RnVCQ3Q1alJ0RTFSZXVKVnZ5aEFhU04xK25wTG5qRXc3UHY0a09M?=
 =?utf-8?B?UjFweVl6TXhFU1djbjRQdFdvdFV4ZDJ2SXpyakpwUi9wZGJXN2tPWFVrQ092?=
 =?utf-8?B?b3pHRU9xV3lyS1B1bFVXQ0o3RXlsbk14VTVjQWQ4bUVoU05ocTBRN0Q3Uitu?=
 =?utf-8?B?bVhWdjNUYUZIYStqeUZFOEY0MW41cjQzdHVQZndGc0tyL3ZpUTV1ODkwei85?=
 =?utf-8?B?M3RGOWlCY0xoOHBDdnhuU3VpYlhCNjRERzBWSDQzL1NWWUdOWTFKRDI3RzhB?=
 =?utf-8?B?VVZqYVdMZEZFZEczRDYzN3NpYkV3RkFlZUVYeXlsenNvSEhsdGlQNVhobXJ4?=
 =?utf-8?B?dHoybjMxNXh2VjdYbHRTeDN4WHUzNjVIckFrZWRIR0FNS251RkJqVCthSTJa?=
 =?utf-8?B?a0s3RnlFdXRldlJqUDI2elJTWHB1R0F0YVZsbkxMVUdLVm5LdkdrY1ZDdHFV?=
 =?utf-8?B?bkN1bU5GVlJRNjRJUEFNcXk0ZjdkTHZaZDJaRmVxMWJXaXJHZjJnL2haQnhR?=
 =?utf-8?B?VnhNSW1Id3Z3dTNCM3lhRWVKOGJNamYxczhFNUdGUHpIYkJsUXFaUHRCSGJk?=
 =?utf-8?B?VVpNT041SUxBRm5iRHdxSEJDK3BOalN1OXU4c0RseE52emkxS2F5dlNzcnAy?=
 =?utf-8?B?L1pyMEtZS2V1S1JZalJoVDV6cmdldnNYdnpMenMycXNUSlpTQktSSGI0NVg2?=
 =?utf-8?B?c3I3a2xSRFRweGpxeWFYajJGNHRrRTd4T2p0dUNqcGlyU2xOYXAxWnpTdzhn?=
 =?utf-8?B?NkRKOW9kTnA0QWtGYk9tbHQ4UGxQem1xZGFOVkNhSENRZHh4d1VlanlPb0x1?=
 =?utf-8?B?MktVRFpEcmxGUlU4V21nSjIzNUc0WUpVNm5mSjVvTHNvN3ZPSVU0ZUJ2SHJi?=
 =?utf-8?B?ZEtkUGswK242NzQ0RVFIZ013aHhzUFg1NEgwL3Mvc3h1bkFPM0ZiZlhuRTFr?=
 =?utf-8?B?UVF2TXJlc2tsSXc0QnlGL0hzcXV2cUpuTThHbDJPTXpUZDlDZ1BFeHUxazNP?=
 =?utf-8?B?Mjcwa3U2TVVQdmFvU1JLS3lGb2d2SWE2cU5BM2srQXpsdFN5L3hJV3cvTlZu?=
 =?utf-8?B?TFpmY1JLNHRKZlZPclUvTTFRcVRqZW9oWm1EUHV1M0cxdHRZYWRIeVB5YzJ4?=
 =?utf-8?B?eXB4MDlFR0hRVWVQWGJmWFZXQ3NSMWQrZ01adkhKSHo1UGxjZUJmNGcrcjRn?=
 =?utf-8?B?M3NoN3lWNXpmcTBGUmN0cjA0cmlZekRpTzk3QjdoeWcyUi9XV3JiYzNXc1cw?=
 =?utf-8?B?SGVwSmhPUHRBOEgrSVFYdnFQVC9XREU5aXNKQTI0Ui90VmVpdnEvYWRKRHo0?=
 =?utf-8?B?djgrb3lYY2xvZVgxcWVDaXM0akt3Z1FyWDJzT0FlN3pxWXlnYTRGbWpXekY1?=
 =?utf-8?B?VHdBaWZEUlhNYk1OY2diN3NCM1JCcGlxbjJkZ0VWM2JubERZb3dpcUVlTm1z?=
 =?utf-8?B?V0NrV0RCNmhEUGgxV09QVmVlU3FHaXM5STc4ZXJpUjAyRzhmRjNZUkErYTJT?=
 =?utf-8?B?WERYd3NWSFBVejB2dzZsK29xdUV3c1F3NGx0VU83bGE0T2JJYjJPeTl1K1lS?=
 =?utf-8?B?WnFZVFI4d2gva2Y4TmZhSmQyTDFpcVU3TS80b2czR0pZRVJ4K0p3TkVlL2k5?=
 =?utf-8?B?dWFyeUtPN2k3MnY4VVM1czNUd0dYLzd2WERRMm9HMXZRSkgrS3A3SHhCNWlu?=
 =?utf-8?B?ZTRnTTJ2RWs2cVNoZXlKdTFxNk5DQk5xR1UwN251MlBnY1ZCOThoLzR5NGR1?=
 =?utf-8?B?VUtzL2N2WEZFa1V0REQyZ2RrOHJwdEpFWHZQa2lheFRZRGZYQzBvUWkxVGZS?=
 =?utf-8?B?K0NIZXdZQmJFN1Q1cE1mTlJSd09hczhKZTd1YUpwNXFqK3JEVFBkdisyUFg4?=
 =?utf-8?B?dnN5RlNjaWpZeWlvdlllQ0dLVC9OV3JKbXRCWFNuWWc4RmdmQ3lpU1YyREht?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF4278B7791CBD4799EE480F16B116C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386288b2-8396-4f66-f858-08db9951ce70
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 03:28:03.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YIcEwMnB+574XCcamiQRPgUCZqJl/yIpMGksEW+2g/iCSZjYNLhLrPebGUyvZoaqVGfJjdOJkenLQSCqlTMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcywKCj4gPiBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIHBhY2thZ2VzOsKgwqAgMgo+
ID4gQ1BVIHRvcG86IE1heC4gbG9naWNhbCBkaWVzOsKgwqDCoMKgwqDCoCAyCj4gPiBDUFUgdG9w
bzogTWF4LiBkaWVzIHBlciBwYWNrYWdlOsKgwqAgMQo+ID4gQ1BVIHRvcG86IE1heC4gdGhyZWFk
cyBwZXIgY29yZTrCoMKgIDIKPiA+IENQVSB0b3BvOiBOdW0uIGNvcmVzIHBlciBwYWNrYWdlOsKg
wqDCoCAxMAo+ID4gQ1BVIHRvcG86IE51bS4gdGhyZWFkcyBwZXIgcGFja2FnZTrCoCAyMAo+ID4g
Q1BVIHRvcG86IEFsbG93aW5nIDQwIHByZXNlbnQgQ1BVcyBwbHVzIDAgaG90cGx1ZyBDUFVzCj4g
PiBDUFUgdG9wbzogVGhyZWFkwqDCoMKgIDrCoMKgwqAgNDAKPiA+IENQVSB0b3BvOiBDb3JlwqDC
oMKgwqDCoCA6wqDCoMKgIDIwCj4gPiBDUFUgdG9wbzogTW9kdWxlwqDCoMKgIDrCoMKgwqDCoCAy
Cj4gPiBDUFUgdG9wbzogVGlsZcKgwqDCoMKgwqAgOsKgwqDCoMKgIDIKPiA+IENQVSB0b3BvOiBE
aWXCoMKgwqDCoMKgwqAgOsKgwqDCoMKgIDIKPiA+IENQVSB0b3BvOiBQYWNrYWdlwqDCoCA6wqDC
oMKgwqAgMgo+ID4gCj4gPiBkb21haW46IFRocmVhZMKgwqDCoMKgIHNoaWZ0OiAxIGRvbV9zaXpl
OsKgwqDCoMKgIDIgbWF4X3RocmVhZHM6wqDCoMKgwqAgMgo+ID4gZG9tYWluOiBDb3JlwqDCoMKg
wqDCoMKgIHNoaWZ0OiA1IGRvbV9zaXplOsKgwqDCoCAxNiBtYXhfdGhyZWFkczrCoMKgwqAgMzIK
PiA+IGRvbWFpbjogTW9kdWxlwqDCoMKgwqAgc2hpZnQ6IDUgZG9tX3NpemU6wqDCoMKgwqAgMSBt
YXhfdGhyZWFkczrCoMKgwqAgMzIKPiA+IGRvbWFpbjogVGlsZcKgwqDCoMKgwqDCoCBzaGlmdDog
NSBkb21fc2l6ZTrCoMKgwqDCoCAxIG1heF90aHJlYWRzOsKgwqDCoCAzMgo+ID4gZG9tYWluOiBE
aWXCoMKgwqDCoMKgwqDCoCBzaGlmdDogNSBkb21fc2l6ZTrCoMKgwqDCoCAxIG1heF90aHJlYWRz
OsKgwqDCoCAzMgo+ID4gZG9tYWluOiBQYWNrYWdlwqDCoMKgIHNoaWZ0OiA1IGRvbV9zaXplOsKg
wqDCoMKgIDEgbWF4X3RocmVhZHM6wqDCoMKgIDMyCj4gPiAKPiA+IC9zeXMva2VybmVsL2RlYnVn
L3g4Ni90b3BvL2NwdXMvMzkKPiA+IG9ubGluZTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAx
Cj4gPiBpbml0aWFsX2FwaWNpZDrCoMKgwqDCoMKgIDM5Cj4gPiBhcGljaWQ6wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMzkKPiA+IHBrZ19pZDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAx
Cj4gPiBkaWVfaWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMQo+ID4gY3VfaWQ6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNTUKPiA+IGNvcmVfaWQ6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDEyCj4gPiBsb2dpY2FsX3BrZ19pZDrCoMKgwqDCoMKgIDEKPiA+IGxvZ2ljYWxfZGll
X2lkOsKgwqDCoMKgwqAgMQo+ID4gbGxjX2lkOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDMy
Cj4gPiBsMmNfaWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNTYKPiA+IGFtZF9ub2RlX2lk
OsKgwqDCoMKgwqDCoMKgwqAgMAo+ID4gYW1kX25vZGVzX3Blcl9wa2c6wqDCoCAwCj4gPiBudW1f
dGhyZWFkczrCoMKgwqDCoMKgwqDCoMKgIDIwCj4gPiBudW1fY29yZXM6wqDCoMKgwqDCoMKgwqDC
oMKgwqAgMTAKPiA+IG1heF9kaWVzX3Blcl9wa2c6wqDCoMKgIDEKPiA+IG1heF90aHJlYWRzX3Bl
cl9jb3JlOjIKPiAKPiBUaGF0IG1ha2VzIG11Y2ggbW9yZSBzZW5zZSBub3cuCj4gCj4gWmhhbmcs
IGNhbiB5b3UgcGxlYXNlIGZvbGxvdyB1cCBvbjoKPiAKPiDCoAo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC82MTNkZjI4MDExNjM3ODExNTU4NWQwYzQ4M2Y3ZTE4NmNmZmFlYjU4LmNhbWVs
QGludGVsLmNvbS8KPiAKPiBvciBvdGhlcndpc2UgSSBqdXN0IHBvbGlzaCB1cCBQZXRlcloncyB2
YXJpYW50IG9mIGl0IHRvbW9ycm93Lgo+IApTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuIEkg
d2FzIGluIHRoZSByZXZpZXdpbmcgb2YgdGhlIHByZXZpb3VzCnBhdGNoIHNlcmllcyBhbmQgbWlz
c2VkIHRoaXMgb25lLgoKSU1PLCBQZXRlclonIHBhdGNoIGFscmVhZHkgZm9sbG93cyB0aGUgc3Vn
Z2VzdGlvbiBhdApodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvODdwbTRicDU0ei5mZnNAdGds
eC8KQW5kIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84N2p6dWtxanZmLmZmc0B0Z2x4LyBp
cyBub3QgbmVlZGVkCmJlY2F1c2UgdGhlcmUgYXJlIG5vIGR1cGxpY2F0ZSBBUElDIElEcyBmcm9t
IExBUElDIGFuZCB4MkFQSUMgYW55bW9yZQp3aXRoIHRoZSBhYm92ZSBwYXRjaC4KClNvIEkgdGhp
bmsgd2UgY2FuIGdvIHdpdGggUGV0ZXJaJyBwYXRjaC4KCnRoYW5rcywKcnVpCgo=
