Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252F76E704
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjHCLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjHCLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:36:12 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE61982
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691062572; x=1722598572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f/VkIPEFau/jO0UCgyiZNBU6X8RkclJEsco1Jaik37c=;
  b=ZFwcDvfZwp2zwurq7c7OcaSeOfFZ0VuAyJgMH1ggyHUJgYYPd7GitJvI
   YbaO9UT7OT2EiiiMj54Fm4J3f4XNDFDNdy39yLH1ekw2oZ/zhxQa4djyf
   hNODg8GCyFRj2aFdLxNyWkztBjZmh4hl4JFJaxTx1B3FobJibxyR/1lOR
   Yg5CkmSPwEEx3i0+fnQGaeLEp3BLAeKGmFvks1LavVXmqEqKJ4fqKK/co
   UAVPmlCYSV/LZeZF3akwsCjetGJGaHNItvAi8HN6TE4k5mnGPjLSzvTIp
   qSSwpjZi80y1PqfiClz7YFLAfA9TvE7uetCSerJtfYgAPsrT5o993bet/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="367302675"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="367302675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764563653"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="764563653"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 04:35:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 04:35:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 04:35:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 04:35:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 04:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXh7gvLU7qs+4vzeVue9VKyMXu8u0Zryq0C7PL/MPNJIyaZqt5y7XfJDBqwqo+iQvjH2LppJPGavi6FGSpajmRXhcuzC+qFDyWSZGp6+uhwAYQACYcQc7ezqoN6YqlbwfMngYU6N5zNdICszDP9tnFW4ntHHLQVS4I9WrxmmjD9HONRrrh9wDf9tEVy8odCXvGmrvPqWrueMm8E90Znh5tYqmCAH4AtfNRPV0rDIZGKoOPfeRrc05161aM7fg0CjTiBVP2nRAJbQc1av+I8Sf2me9goVnzfvNEQ4XsksxfrrKZamfdNivxksjHUfJTY9VbIW05EygRpgyh4D78dSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/VkIPEFau/jO0UCgyiZNBU6X8RkclJEsco1Jaik37c=;
 b=I7dsW0pYXFeOU1kOqCtw/fwUJCOy6wy8E46oS13kBorPBome9O+uGTwtU6847VNiTRCAlXXG4CzZVJGTojXp4m39Bc69FyBmd3Riu9rY4n25kRCdW0V4uz2+Fzs4KqRArD/EQY2Yh7P7MrlSMhynlRVar1DFDQNWLHqzgQ9VlDmP/QwzEFBPFRuhKtb3xnwL+GL/0NZ/+uS2dJKKH2S/kb3bBqrzDvYMFVeKLMTWkgnDLSTYPowOqIxrQFBijF7pwOMeun5nkv8lRYuVRnmiaJJunuSufOYeKyJGvS6DAGJGyCqyYI/l4/TdurQIWGna2Tn7+m6bAmkjMhMSXYOsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5367.namprd11.prod.outlook.com (2603:10b6:208:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 11:35:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 11:35:49 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Thread-Topic: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Thread-Index: AQHZv7EqgHMyN5+0wkOBrwJbR0AS5K/N0ZsAgABpmACACjgyAIAACoCA
Date:   Thu, 3 Aug 2023 11:35:48 +0000
Message-ID: <1d402ce98cdcf71098783e7fe584bbf477e47eb9.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
         <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
         <6374fd1aa1e2ff4777eab2421cfc439d259cc603.camel@intel.com>
         <20230803105810.xljd2sjqittqey2w@box.shutemov.name>
In-Reply-To: <20230803105810.xljd2sjqittqey2w@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5367:EE_
x-ms-office365-filtering-correlation-id: 8543b011-2fa9-4f29-8415-08db9415c8fd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXlDKktXEzYb5a8MzMhBROvW6ritUVEcztB5LEGALKtbNy7nX2Exxhl11o/TxMn7oGOeMSWrosNx8WhD+6YLnyVwsZNzZjJ5/wEQoyqRwBt86chDqKabM0s2J5mevNYkUW1swZAuk7/9aIv5VBVV+OBQ78TUxEJoQQAR+i8gNuCPqw60ldHJ1x9LKlR6YE30HFGmD5aGoIo1Le32hBW3rtnDPCtA5GJt/f/zCeNh+QMzrZcbMn27iREVSSmOaWSNsNCuptis9jBoUq+zZ/mXJlrIwOyuQnYaYJgS2cLmvBKD8FAN2+++03hxnmkPURxAI/KI+OLit3ITSrBnYcpKSZnSh9Pq4ox1UAKvtOV5dO1AyT9F1/v1JGDG0XBDdWy7jdeDH0ota6cTx1KCFHoJfs+atw7mlnvUn+5FTePCDFHERhG8KKnXjhcCWtuSClvCRcZFEVTmlpURnjrwRiDDLiZ0uBEA9IqA0FrCtrreE+5It2RI1wNO4lg4jC9vuZrZ9Mv/DIxZjMYsA/NPXqdCnK7vK+uNYkabnedp2VZVJqxS4Ezk6QrVT+4fVYt0qIxXwX3Bp2f8DDegF/pI41fsgjAeabUZv7QPdqJx2Hi526HAc4SmAz06Gc0yhBiDCp2U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(6506007)(26005)(86362001)(2616005)(122000001)(38100700002)(82960400001)(38070700005)(316002)(6486002)(71200400001)(478600001)(6512007)(54906003)(36756003)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(66946007)(91956017)(76116006)(2906002)(5660300002)(7416002)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdWQWJlNmRoVDcrZlFPRkYrTDZzaitXZk8xMVA1ZkZ4dFlkQXpubXB5NlNC?=
 =?utf-8?B?eHFqYTUzcUMyeFFNQWlVdk0wSDc4Wlh4UndZR2FwYUpOSGY5dXR2V2ZGZ0VW?=
 =?utf-8?B?eGliWDRjN3dZMmdIS1RhSHZ5WnpGU0FLMEtjeXh6UU5NcVNCcmlOM1l6ZHhS?=
 =?utf-8?B?N2FyLzZCVkNiZjVtZXoxVXRJMWVDWGdHSkxVUU1DZjFQdVYzeHhaZ1Z4TjJ1?=
 =?utf-8?B?cURGVWxITFpocjN5U2RMbXNoTkNEVWZTMTlGLzRqMGJtK09JZlB0ZHpEc3Ez?=
 =?utf-8?B?d1Ryd2hiTlJLUmZKK2lSc296WlVYRVlLVmpVeDRHMk83d1RjaFkxWEIrbmdO?=
 =?utf-8?B?dzNTekdKbitLWEp6S2UxazkwRHM3dVdZbmE0bXF4bHNoUFFPeTRWQmNSS2h6?=
 =?utf-8?B?dmkwWEJCSmM5THZKWUlkLzkxSUhFSFVjbzNKSk5LRmpobkk3ZWhIbXFHb21H?=
 =?utf-8?B?bk1OUEtwYlFhZ1lBVTdhQmFHT1dTQlMraC96S0xqTHBYK2w5MlRRNXhKcEtO?=
 =?utf-8?B?aG9uVFJxVDNTMUlBRHFKRk1ibm4rYWR2OVU5d1IyNHBuekFkZnR0SExLVnAz?=
 =?utf-8?B?dDNIcitNaTVDY0FBN0xpQjFrd0kxZDBidzNjc1lUWEpsazdwcnRzWUJZaDBS?=
 =?utf-8?B?VmFwUHU2c01SY05WWEwvUVB6YzZYbVk0VEFUajduYnV4RkpjamRNNUhwT2lC?=
 =?utf-8?B?bFJHeWdXM0tWbmN0WDNDeVFxc0tDSnZneUZVeDAyamg3RE5MVDhtVyt0U2tF?=
 =?utf-8?B?MTQvQU9PTGJsYTRVZjA1MDZkS2VaTDVaQ1lXYm8vZjA1VDdubURDN0IrMWc5?=
 =?utf-8?B?cU4wTDFYcFFMekg0ZE1Sa1Vua2xLME5IckFPN2hPMTFMOTE2dXNDLzBoUVZn?=
 =?utf-8?B?THBFQjU4OWdJdTZJRlR2OEVRbTk3WlMvOHNKTHRMR0VNc09mUTdxRVdYSUFl?=
 =?utf-8?B?amFPUEkrVjhET0hvV0tmNCt5bXhpb2VwVk5qTERIbFMvUmZ6UWJRdFlaRUc4?=
 =?utf-8?B?Y09CVTlrSjE1OUtLckIzOENpS0RhVy9FQ1BuL2J6amNLQk82S01VQ0IzdjBs?=
 =?utf-8?B?dWgvUGxFcDI0b1duVE9zelUvOHFrdnBNRTJJN2VnNDlpRG9PM2dpVXpxN1JU?=
 =?utf-8?B?OXJwVm1CRkg3TEpkd0pDamxmYldYODluMSs2WG9yQlltRTBLMlB3QkplMGVW?=
 =?utf-8?B?ZUorRXZzYVFncytjNE8xRzhOd2Z1Qjk1eUpEVXZzU3c3RDlnczh5MnYxODRM?=
 =?utf-8?B?RGZnRkJoTHRsbHMwSWxKcjkvLzIyTEFXNnJlWEFDbGdJVEFxL3JBQ09HSml5?=
 =?utf-8?B?Qlh3TFU0a1F5a1NUTUFPOHY1YmdZSDkyNXJzc1ozYXM2aG4xdHJqWDBkb00v?=
 =?utf-8?B?RndRSHZuVVNINVI0ZzlhTTgvSE93bWhoQ1NzTWRkR1BWMndtZGtLS0pPMFhM?=
 =?utf-8?B?T1NNRGdJSFY3SjBTelJKSUVTeWliRHVBUmNvcmdrWXlDcnBuekZoV1oxckJQ?=
 =?utf-8?B?R2YzelZLaW1YTG5UMXNSUmExa0o4cDYvTW9FZlpmaW5HQi9VQkZCb0hEOUpP?=
 =?utf-8?B?QnFpdDFtOUhjSG04REJXMTRTR0lyVWVzT2JWQlVNWUdrZjVaNkF6Z0xBcFRD?=
 =?utf-8?B?Y2wrd0Z4NFFMRVpENzcvNDdhWVhJMXhtNTQxWjhueGNwL1dlMVdweUZSUFRh?=
 =?utf-8?B?SEFPMmduZHg4bHVGdGM0R041YkZoSmJ6NjIzNVJ6bVJ1WktzMXNXcXNVakd4?=
 =?utf-8?B?N1ZCVXlMREJTNXlZb0wzQ1pkTnhTRkZzbEsydDcvSkNXMm1Ya3FaNXlBaDB5?=
 =?utf-8?B?SlFQZjhJVHk2S0doREcrNy9NSU1vMDhHeTNGdDZBWGpHN3B6dFhKMVdrQWRH?=
 =?utf-8?B?WTRrLzlpRG9rVmg3bitzbUhzc2tGZExua2Q2VmVJRXVENW9KVWJzMUk2N3NY?=
 =?utf-8?B?ZXlqa045bVJUeXN4N01vY3RGdmVKMGlHU0xJS3NYQXNBRzk1TzZVYVVWTlhu?=
 =?utf-8?B?NHdNd1UwNHRGTUdyY1FiRk9Ybzk5M0JDQjg0RHhBWVY4bVlOdHFLcHNYOHhB?=
 =?utf-8?B?ejZWS0s1a3FmMWZ0akNwbHd2Q1dUNXkzRkhUS21JUy93Qm1rQmVKd0EvaEMy?=
 =?utf-8?Q?BwAulHHx5dqg1UCxa7Dts+btA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BDB680D71BE444C9EDF0CBDA11099D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8543b011-2fa9-4f29-8415-08db9415c8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:35:48.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAW2fYoYKpdxT9oCEWW1qpSfhowBE7Wm1ugsb5/jCUcxvUhLyNUBW43p8z5LUY0Uyr7weJEN9GpEnoFUBjCyRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5367
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

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDEzOjU4ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAxMDo1NDoyOFBNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wNy0yNyBhdCAxOTozNiAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+IE9uIFdl
ZCwgSnVsIDI2LCAyMDIzIGF0IDExOjI1OjA3UE0gKzEyMDAsIEthaSBIdWFuZyB3cm90ZToNCj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhjYWxsLlMgYi9hcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4Y2FsbC5TDQo+ID4gPiA+IGluZGV4IDZiZGY2ZTEzNzk1My4u
YTBlN2ZlODFiZjYzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgv
dGR4Y2FsbC5TDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhjYWxsLlMN
Cj4gPiA+ID4gQEAgLTE3LDM0ICsxNywzMyBAQA0KPiA+ID4gPiAgICogICAgICAgICAgICBURFgg
bW9kdWxlIGFuZCBoeXBlcmNhbGxzIHRvIHRoZSBWTU0uDQo+ID4gPiA+ICAgKiBTRUFNQ0FMTCAt
IHVzZWQgYnkgVERYIGhvc3RzIHRvIG1ha2UgcmVxdWVzdHMgdG8gdGhlDQo+ID4gPiA+ICAgKiAg
ICAgICAgICAgIFREWCBtb2R1bGUuDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+ICsgKiBURENBTEwvU0VBTUNBTEwgQUJJOg0KPiA+ID4gPiArICotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gPiA+ICsgKiBJbnB1dCBSZWdpc3RlcnM6DQo+ID4gPiA+ICsgKg0K
PiA+ID4gPiArICogUkFYICAgICAgICAgICAgICAgICAtIFREQ0FMTC9TRUFNQ0FMTCBMZWFmIG51
bWJlci4NCj4gPiA+ID4gKyAqIFJDWCxSRFgsUjgtUjkgICAgICAgLSBURENBTEwvU0VBTUNBTEwg
TGVhZiBzcGVjaWZpYyBpbnB1dCByZWdpc3RlcnMuDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICog
T3V0cHV0IFJlZ2lzdGVyczoNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSQVggICAgICAgICAg
ICAgICAgIC0gVERDQUxML1NFQU1DQUxMIGluc3RydWN0aW9uIGVycm9yIGNvZGUuDQo+ID4gPiA+
ICsgKiBSQ1gsUkRYLFI4LVIxMSAgICAgIC0gVERDQUxML1NFQU1DQUxMIExlYWYgc3BlY2lmaWMg
b3V0cHV0IHJlZ2lzdGVycy4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiA+IA0KPiA+ID4gU28sIHlvdSBrZWVwIHRoZSBleGlzdGluZyBhc3ltZXRyeSBpbiBJ
TiBhbmQgT1VUIHJlZ2lzdGVycy4gUjEwIGFuZCBSMTENCj4gPiA+IGFyZSBPVVQtb25seSByZWdp
c3RlcnMuIEl0IGNhbiBiZSBjb25mdXNpbmcgZm9yIHVzZXIgc2luY2UgaXQgaXMgdGhlIHNhbWUN
Cj4gPiA+IHN0cnVjdHVyZSBub3cuIEkgZ3Vlc3MgaXQgY2hhbmdlcyBpbiB0aGUgZm9sbG93aW5n
IHBhdGNoZXMsIGJ1dCBJIHdvdWxkDQo+ID4gPiBwcmVmZXIgdG8gbWFrZSB0aGVtIGV2ZW4gaGVy
ZSBpZiB0aGVyZSdzIG5vIGdvb2QgcmVhc29uIG5vdCB0by4NCj4gPiA+IA0KPiA+IA0KPiA+IA0K
PiA+IERvIHlvdSBtZWFuIHlvdSBwcmVmZXIgdG8gdXNlIFIxMC9SMTEgYXMgaW5wdXQgdG9vIGV2
ZW4gaW4gdGhpcyBwYXRjaD8NCj4gDQo+IFllcy4NCj4gDQo+ID4gSSB0aGluayBfbG9naWNhbGx5
XyBpdCBzaG91bGQgYmUgcGFydCBvZiB0aGUgbmV4dCBwYXRjaCwgYmVjYXVzZSB3L28gZXh0ZW5k
aW5nDQo+ID4gVERYX01PRFVMRV9DQUxMIHRvIHN1cHBvcnQgYWRkaXRpb25hbCBURENBTExzL1NF
QU1DQUxMcywgd2UgZG9uJ3QgbmVlZCBSMTAvUjExDQo+ID4gYXMgaW5wdXQuICBUaGlzIHBhdGNo
IG9ubHkgY2hhbmdlcyB0byB0YWtlIGEgc3RydWN0dXJlIGFzIGZ1bmN0aW9uIGFyZ3VtZW50LA0K
PiA+IHJhdGhlciB0aGFuIHRha2luZyBpbmRpdmlkdWFsIHJlZ2lzdGVycyBhcyBhcmd1bWVudC4N
Cj4gDQo+IEFzIGEgdXNlciwgaWYgSSBzZWUgYSBzdHJ1Y3QgdXNlZCBmb3IgaW4gYW5kIG91dCwg
SSB3b3VsZCBleHBlY3QgdGhhdCBhbGwNCj4gZmllbGRzIGhhdmUgdGhlIHNhbWUgcnVsZXMuDQo+
IA0KPiA+IEFsc28sIHdlIGhhdmUgYSBjb21tZW50IHRvIHNheSB0aGlzIGFyb3VuZCB0aGUgc3Ry
dWN0dXJlIHRvbzoNCj4gPiANCj4gPiAgLyoNCj4gPiAtICogVXNlZCBpbiBfX3RkeF9tb2R1bGVf
Y2FsbCgpIHRvIGdhdGhlciB0aGUgb3V0cHV0IHJlZ2lzdGVycycgdmFsdWVzIG9mIHRoZQ0KPiA+
ICsgKiBVc2VkIGluIF9fdGRjYWxsKigpIHRvIGdhdGhlciB0aGUgaW5wdXQvb3V0cHV0IHJlZ2lz
dGVycycgdmFsdWVzIG9mIHRoZQ0KPiA+ICAgKiBURENBTEwgaW5zdHJ1Y3Rpb24gd2hlbiByZXF1
ZXN0aW5nIHNlcnZpY2VzIGZyb20gdGhlIFREWCBtb2R1bGUuIFRoaXMgaXMgYQ0KPiA+ICAgKiBz
b2Z0d2FyZSBvbmx5IHN0cnVjdHVyZSBhbmQgbm90IHBhcnQgb2YgdGhlIFREWCBtb2R1bGUvVk1N
IEFCSQ0KPiA+ICAgKi8NCj4gPiAtc3RydWN0IHRkeF9tb2R1bGVfb3V0cHV0IHsNCj4gPiArc3Ry
dWN0IHRkeF9tb2R1bGVfYXJncyB7DQo+ID4gKwkvKiBpbnB1dC9vdXRwdXQgKi8NCj4gPiAgCXU2
NCByY3g7DQo+ID4gIAl1NjQgcmR4Ow0KPiA+ICAJdTY0IHI4Ow0KPiA+ICAJdTY0IHI5Ow0KPiA+
ICsJLyogYWRkaXRpb25hbCBvdXRwdXQgKi8NCj4gPiAgCXU2NCByMTA7DQo+ID4gIAl1NjQgcjEx
Ow0KPiA+ICB9Ow0KPiA+IA0KPiA+IFNvIHRvIG1lIHRoZXJlIHNob3VsZCBiZSBubyBjb25mdXNp
b24uDQo+IA0KPiBEbyB5b3UgYWx3YXlzIHJlYWQgZG9jdW1lbnRhdGlvbj8gOlAgTWF5YmUgaXQg
aXMgb25seSBtZS4uLg0KPiANCj4gPiBFdmVuIGNvbnNpZGVyIGEgdGhlb3JldGljYWwgY2FzZTog
c29tZW9uZSB3YW50cyB0byBiYWNrcG9ydCB0aGlzIHBhdGNoIHRvIGFuIG9sZA0KPiA+IGtlcm5l
bCB3L28gZnVydGhlciBwYXRjaGVzLCB0aGVuIGl0IG1ha2VzIGxpdHRsZSBzZW5zZSB0byBkbyBS
MTAvUjExIGluDQo+ID4gVERYX01PRFVMRV9DQUxMIGhlcmUgaW4gdGhpcyBwYXRjaA0KPiA+IA0K
PiA+IDotKQ0KPiANCj4gQ29uc2lkZXIgdGhlIGNhc2Ugd2hlIHRoZSBwYXRjaCB3YXMgKHdyb25n
bHkpIGJhY2twb3J0ZWQgdG8gdXNlIG5ldyBjYWxsDQo+IHRoYXQgdXNlcyBSMTAgYXMgaW5wdXQu
DQo+IA0KPiBJIHJlYWxpemUgdGhhdCBhbGwgbXkgb2JqZWN0aW9ucyBhcmUgcmF0aGVyIGhhbmQt
d2F2eS4gSSB3b3VsZCBsaWtlIHRvDQo+IGhhdmUgaW4vb3V0IHN5bW1ldHJ5IGhlcmUuIEJ1dCBJ
IHdvdWxkIG5vdCBOQUsgcGF0Y2ggb3ZlciB0aGlzLg0KPiANCg0KVGhlIG9ubHkgY29uY2VybiBp
cyBJIGRvbid0IHBhcnRpY3VsYXJseSBsaWtlIHRvIGFkZCBhZGRpdGlvbmFsIGxvZ2ljIHRvIHRo
aXMNCnBhdGNoLiAgQW55d2F5IG5vdCBiaWcgZGVhbCB0byBtZS4gIEkgY2FuIGRvIHdoYXQgeW91
IHNhaWQgaWYgSSBkb24ndCBzZWUNClBldGVyJ3MgKG9yIG90aGVyIG1haW50YWluZXJzJykgY29t
bWVudCBvbiB0aGlzLg0KDQpCdHcsIHNob3VsZCBJIHNheSBzb21ldGhpbmcgbGlrZSBiZWxvdyBp
biB0aGUgY2hhbmdlbG9nIHRvIGp1c3RpZnkgdGhpcw0KYWRkaXRpb25hbCBsb2dpYzoNCg0KCUFs
c28gdXNlIFIxMC9SMTEgYXMgaW5wdXQgcmVnaXN0ZXJzIHRvbyB0byBtYWtlIHRoZSBpbnB1dC9v
dXRwdXTCoA0KCXJlZ2lzdGVycyBzeW1tZXRyaWMsIGFsdGhvdWdoIGN1cnJlbnRseSBubyBURENB
TEwvU0VBTUNBTEwgdXNlDQoJdGhlbSBhcyBpbnB1dCByZWdpc3RlcnMuDQoNCj8NCg==
