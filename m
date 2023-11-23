Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5838D7F5F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbjKWMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:50:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A0189;
        Thu, 23 Nov 2023 04:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700743858; x=1732279858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jH6M9jw+JvcBQGIEgOl2wcWkD21o5BVUCbVd0JiiLUs=;
  b=dN2UWU4EFDNbDhc4u2wkk6R9V0d465nFIcDJGJPoXbGVR7KTvLubpPbA
   8mSPN8EQ8MyrA41N3jBVvb+RiJmSurTH5oIIBPbQyjHdrbXAXLTHsIgh3
   P8YvYSEPDnLRZ1KuzbrEPDNwzvHu28rPyxNInUvZOt0cV0UlT1Sd68qw3
   H/1p9D5eMVyo2rv6BYRz/mLc6ASoG9i08NObHNZgpgxKU9j/SclLagp8W
   PXeMrlQETx0DbBaDHywltnFuzlBaQ5r57MJm0dPVPKAyIT2MkoMf0tVX6
   ao3vKHZh/6Ckr8evaY6mxSW88XYD3gIhM3i3crLKMX7KOMHu9o4prQAMK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396166921"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396166921"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="15650289"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 04:50:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 04:50:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 04:50:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 04:50:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCe0T4zbkRzry7mXaJ08N1hxZPa9YwCPBT2mAAuKs89jD6/M2UPpBwqRsgmPthdCp17S40inIGgV/YZze/gFLfqCNGy0H5dtkBhv4juAtMIaDez3IJlHyv0FpX7PLYUhoHbv1R+MvmNAW9XRFCzfB1P2Zl1N2tXlpP6uK1BVNH3JM9niLJs0vtdKpicLyIWYqTPDDfGsEK6AI0WmkkqHGn6WRFhNKdBtDL5qBnjmcycXftxr0jcqJ82w5kS608zNdPJxaGwjQFQ4bSzOwadOnmvRlqiez1A+3mT8Q/XEC07b2BA/YgkGi0xj1QYBSJi0z+Ea8/d6+AxHfVz9REadgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH6M9jw+JvcBQGIEgOl2wcWkD21o5BVUCbVd0JiiLUs=;
 b=EJNLyK6wuGcBVT7tcF1By1Id2Pg9HanruKTTUV8JN6QOpXk5S4eVszYee+InXt/2COmm94xApPp3EZPpkR+GrOI2ya27MHhb4tuGu/SH0rJTBtWnUlFqQFc11W/QkhCzNE5/H7YzLaNnyDdZv9MjYqssn9wNiyb/wNKE8nwoaMHr9+a8vr15laKSWDUJuq8y0Yh9HJh6Xa2d6aASEex5gz9F5JF6tNjP8aNNi/5/abDrBoWiTrck3YZtP8IPx7gbsmpkz404TO0we3UcIFMCd2yP7u7OtkqhzWHIF84Z+fZCVZGzMPqGSsmceYO6BMbyW6Lm7bss3G/u2jOn8wZnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Thu, 23 Nov
 2023 12:50:48 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:50:48 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYA=
Date:   Thu, 23 Nov 2023 12:50:47 +0000
Message-ID: <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
         <20231122221947.781812-1-jsperbeck@google.com>
In-Reply-To: <20231122221947.781812-1-jsperbeck@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: f9402a87-3fbe-4314-643e-08dbec22d0b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uX/ZR3vT95RgkTqdbn6TeLUWAEHC0KKLo3O9CuQQDxsicK1a+TBBvoTJnbqeexrNAf83kXPmAWwwuv65+5lkPMiasScgxDuYLHSHJoKGbLQpNjzJt7PBRSsbPdMhFGTxIoZ6v8FwHG64TlelYHqNityT3vEvClmvbOSWyPiSwdhDrijKV59MiMXOZ+65f0g3cnSYDOYo8jr9tEs/EUF8gkhLC991L2MID+kH9SK3+WHWqUTXxRBawNpADk2icwwgcymseGnudsTq/1HlIbGeP87jcYVVxUfXN/GdF1vS2rs/5k417pYt9ZDnX9Ge3qkefKuKJJIAopLUjK2MfYSthDF0mt2jkaapBSVHdPQpsn8oyTwqBeZtva/KhaoeTpdz8EQbzK6gRLwOdJcE3wBt31LgwS0FCHSGo79cpNe21CPeyJB9BN51svkodH/tRg8fBJsJ5zWEO0FM8bG/kNoajeYaA5ErheAER7CjYLGoTI15KEK2P15WT9WBFusAfrZRtfaTOC7cq/CmdCChp8pNUe2avB7btXAPQc9XMuFowE9tIiGSbQHsNZLipioSkNqr1cYhEFfKTc6RPbi08I+iCSNlQLdrjboblrlu42mh1DY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(4001150100001)(5660300002)(8676002)(4326008)(8936002)(2906002)(41300700001)(316002)(66476007)(66556008)(66446008)(54906003)(64756008)(66946007)(76116006)(91956017)(110136005)(86362001)(966005)(38070700009)(2616005)(478600001)(6506007)(71200400001)(36756003)(6512007)(26005)(122000001)(83380400001)(38100700002)(6486002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNNZU5UTHB0TXZlak9kK0VManpFQTd0RC9RQkpmVVVMd3I1WUV5ck05L1NU?=
 =?utf-8?B?cFJHRlFBMXVhTXhmUi9KamErSTdxd0dMSEJDVDhDY0hwQkxrMS9hM0c4RUpE?=
 =?utf-8?B?Vnd6bjVnNzRBaWlaT0EwWkY5WTE5MTJZVW5VRml1RWd3L0UrMmFMeGc1OHZR?=
 =?utf-8?B?MTRzZ0d5MUhEbkttNWJqV0l4WGVsMU1vbVlVY2VPbVhtTmxrY0lSQ1JPNUwy?=
 =?utf-8?B?WGdVL2NxclJ1Y1ZGblJsVkg1T1p1WHpvNXNqNDZtYnlPdEtlWDhxVDVQNTZX?=
 =?utf-8?B?c0wxOEFGcXFwYkhFOFlnYnFoVWkyZlVYeVFpVlN5dlNIVWdzY3BUN0NqdFQ3?=
 =?utf-8?B?cVRVRWQ5ejd0bS96QVJOY1lHaFRzenlyUHpTT0xUOWJseEQ3dENuQ0lWWEx4?=
 =?utf-8?B?TmFmUzZLSTl6U3pnZWtCVm9LUytNaElDa3ZwWk9BWW9Qbjdab2hhbjdHck1k?=
 =?utf-8?B?UnFyTzd5K2JLSTVPNUYydmRDeGEyNURYMFFNMU9RWHE0YTcvejVoOUJteGJM?=
 =?utf-8?B?cnl5bGlWT2Nac0FuVTlWRXljMjRvVHNPeHkvOEZ1V3c5MVdIbFo2STluMmtj?=
 =?utf-8?B?bGtCM211YzBiRWJWM2YyaXpMR2xDNmJ0RE5NdjlVczNwanVUQTExNXJsdjlQ?=
 =?utf-8?B?SExKNkFPR1dnM0MzbGl4MWhheDd6RTFnS2lMcnhBWEJBekUwOVEyV1p6WFJJ?=
 =?utf-8?B?N3l6NlRCNzJiN0FVRWlwR2J5MElFMW5iQmJ4SENLZEpsc3hnQUVwUXlaL3lJ?=
 =?utf-8?B?L2FDd29ndW9ydmUwUUlJNmZlNnJ3SllMU3JJVVZBYnhnRU1POWVBbGE2bnlI?=
 =?utf-8?B?cFhTZU9IZjFyN004YnNEZms4RTRVcHVLS29hNGxtZkE4MGV3UkxYL0lWZGlS?=
 =?utf-8?B?a3JlMXVFOXBld0IzZkkwa291eEZBbmFGRXN0VzFNWDlmU3JkZE5sRjVNaDFp?=
 =?utf-8?B?U0txcFBSekVWRkhaZEY3WitUZ2ttRGF3NUdPcFZSVVhkNzFmTlV0S0U3OFBL?=
 =?utf-8?B?RXJwQTI4RVNuTDAray9yelliT0M2MHNMSjJYRFRwd1VBV0ROTnVBbEQzWVl5?=
 =?utf-8?B?cWNFVEF1Zkh1ODB4MmtYWjNsZmxySzV1UHlRS3d3TTBkVXd4QW5hZUhUTlI3?=
 =?utf-8?B?T20yREJMZ0NGaFhydnZoYTFGSWJGRXRGNWhlMFpycVZwMFRNT2M3cm9yUXZa?=
 =?utf-8?B?cnNpbER6OThwcHU0ek44Zi9EODFjTzlvbXU1eDRZU2wrOHBuU1d1aE1pNmpk?=
 =?utf-8?B?bHVpcHpoU3JaNDZMYlY5RitMWmJNOWU2MFUvZE84bUsvakJ6NXhnZ1d0eGF6?=
 =?utf-8?B?UmF4bUlqczd5bjF6V1VOQ0Y2Qm9XN2RrT09Md0ExOExMK2ZMaXhUNTJLdVN6?=
 =?utf-8?B?RXVDeXNtVjdGT1VsZmN0M0l1TzgzREQvYXZnMzYzdk8yeDZZRUFjbGY3OGpp?=
 =?utf-8?B?NGt3VjJZUWRDTHovb1c0RGlXNWo2Q0dhQThHeENXMXV2eHZyMEZaRXNMKzdq?=
 =?utf-8?B?ejQxOXRSV0dvREQxQ1BiamE1OExMZnc4Q1YyL0VoVHQ5eXNicGxGdUo2MkxW?=
 =?utf-8?B?RzUwQ1UrM2wyZUFyQ1JNM2p1VFVJSUtveHJwUno0UzhLaElyN3RVdFN4MURY?=
 =?utf-8?B?WFV1QjFlSHlFbXNKcHBVUWJRZ0ZMRXlEcVpadUo4Nkowamdsb1FvVXhvT1Vj?=
 =?utf-8?B?YnNPdllSVUFLSk9FRlh1eXgzd1NkVkZjQzFTdi9rajcySjhvUm52WUtRMkxB?=
 =?utf-8?B?VGlpRjdWOE9kVFdWaGtiYk5LQkJTS2dtN3crdm5zaEd5Y1F1Wkd6ZkdRZG9S?=
 =?utf-8?B?Q1haZDJLQnB1OS9iOTBPRkZMNnBQZG1qUlcyYXUvYVFCSVZpRDZ2UVVqaXM3?=
 =?utf-8?B?ZnEyZ3JBOGh2a0VKdXFjQ3FlNVh6R2VUbGtKTUJPTjJ4QjkvU1ltaGN1Skw5?=
 =?utf-8?B?QjFyNWpQWUZacUxzU0JMbGxsZTM1NXc3bzRvMUFmS1NqZnk4NW9YTEdyelpq?=
 =?utf-8?B?L2pBRWtlZEQrcTY3ZW1ITW5LbnZHTjlUUXUrRUNGQ3A0dFBSU2JHa0N4NFNN?=
 =?utf-8?B?aHhUMFM4Z3l5N1grcHdpNmVmOXVjZTFXdHlTNHpCM3Y4TWVIdmNac2gyWUF3?=
 =?utf-8?B?dmNDTTF3SDlDWGk3RFJJbHVnYUhGZi9Xb21CTm5oTVZLY292YnVudTZ6R3V1?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53ECFBDF4847064DB7113A2EA19658FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9402a87-3fbe-4314-643e-08dbec22d0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 12:50:47.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imgOYVo5DuQ+oCmBfYPquJb4O+tD8TrV1+H5IFMO7Z78vXhB5u26xm8mv988kLdCJ1Y+URIO4BTvIZq8Ymh1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
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

SGksIEpvaG4sDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyBpc3N1ZS4NCg0KT24gV2VkLCAy
MDIzLTExLTIyIGF0IDIyOjE5ICswMDAwLCBKb2huIFNwZXJiZWNrIHdyb3RlOg0KPiBJIGhhdmUg
YSBwbGF0Zm9ybSB3aXRoIGJvdGggTE9DQUxfQVBJQyBhbmQgTE9DQUxfWDJBUElDIGVudHJpZXMg
Zm9yDQo+IGVhY2ggQ1BVLsKgIEhvd2V2ZXIsIHRoZSBpZHMgZm9yIHRoZSBMT0NBTF9BUElDIGVu
dHJpZXMgYXJlIGFsbA0KPiBpbnZhbGlkIGlkcyBvZiAyNTUsIHNvIHRoZXkgaGF2ZSBhbHdheXMg
YmVlbiBza2lwcGVkIGluDQo+IGFjcGlfcGFyc2VfbGFwaWMoKQ0KPiBieSB0aGlzIGNvZGUgZnJv
bSBmM2JmMWRiZTY0YjYgKCJ4ODYvYWNwaTogUHJldmVudCBMQVBJQyBpZCAweGZmIGZyb20NCj4g
YmVpbmcNCj4gYWNjb3VudGVkIik6DQo+IA0KPiDCoMKgwqAgLyogSWdub3JlIGludmFsaWQgSUQg
Ki8NCj4gwqDCoMKgIGlmIChwcm9jZXNzb3ItPmlkID09IDB4ZmYpDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2UgaW4gdGhpcyB0aHJlYWQs
IHRoZSByZXR1cm4gdmFsdWUgb2YgMCBtZWFucyB0aGF0IHRoZQ0KPiAnY291bnQnIHZhcmlhYmxl
IGluIGFjcGlfcGFyc2VfZW50cmllc19hcnJheSgpIGlzIGluY3JlbWVudGVkLsKgIFRoZQ0KPiBw
b3NpdGl2ZSByZXR1cm4gdmFsdWUgbWVhbnMgdGhhdCAnaGFzX2xhcGljX2NwdXMnIGlzIHNldCwg
ZXZlbiB0aG91Z2gNCj4gbm8gZW50cmllcyB3ZXJlIGFjdHVhbGx5IG1hdGNoZWQuDQoNClNvIGlu
IGFjcGlfcGFyc2VfbWFkdF9sYXBpY19lbnRyaWVzLCB3aXRob3V0IHRoaXMgcGF0Y2gsDQptYWR0
X3Byb2NbMF0uY291bnQgaXMgYSBwb3NpdGl2ZSB2YWx1ZSBvbiB0aGlzIHBsYXRmb3JtLCByaWdo
dD8NCg0KVGhpcyBzb3VuZHMgbGlrZSBhIHBvdGVudGlhbCBpc3N1ZSBiZWNhdXNlIHRoZSBmb2xs
b3dpbmcgY2hlY2tzIHRvIGZhbGwNCmJhY2sgdG8gTVBTIG1vZGUgY2FuIGFsc28gYnJlYWsuIChJ
ZiBhbGwgTE9DQUxfQVBJQyBlbnRyaWVzIGhhdmUNCmFwaWNfaWQgMHhmZiBhbmQgYWxsIExPQ0FM
X1gyQVBJQyBlbnRyaWVzIGhhdmUgYXBpY19pZCAweGZmZmZmZmZmKQ0KDQo+IMKgIFRoZW4sIHdo
ZW4gdGhlIE1BRFQgaXMgaXRlcmF0ZWQNCj4gd2l0aCBhY3BpX3BhcnNlX3gyYXBpYygpLCB0aGUg
eDJhcGljIGVudHJpZXMgd2l0aCBpZHMgbGVzcyB0aGFuIDI1NQ0KPiBhcmUgc2tpcHBlZCBhbmQg
bW9zdCBvZiBteSBDUFVzIGFyZW4ndCByZWNvZ25pemVkLg0KPiANCj4gSSB0aGluayB0aGUgb3Jp
Z2luYWwgdmVyc2lvbiBvZiB0aGlzIGNoYW5nZSB3YXMgb2theSBmb3IgdGhpcyBjYXNlIGluDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvODdwbTRicDU0ei5mZnNAdGdseC9ULw0KDQpZ
ZWFoLg0KDQpCdXQgaWYgd2Ugd2FudCB0byBmaXggdGhlIHBvdGVudGlhbCBpc3N1ZSBhYm92ZSwg
d2UgbmVlZCB0byBkbw0Kc29tZXRoaW5nIG1vcmUuDQoNClNheSB3ZSBjYW4gc3RpbGwgdXNlIGFj
cGlfdGFibGVfcGFyc2VfZW50cmllc19hcnJheSgpIGFuZCBjb252ZXJ0DQphY3BpX3BhcnNlX2xh
cGljKCkvYWNwaV9wYXJzZV94MmFwaWMoKSB0bw0KYWNwaV9zdWJ0YWJsZV9wcm9jLmhhbmRsZXJf
YXJnIGFuZCBzYXZlIHRoZSByZWFsIHZhbGlkIGVudHJpZXMgdmlhIHRoZQ0KcGFyYW1ldGVyLg0K
DQpvciBjYW4gd2UganVzdCB1c2UgbnVtX3Byb2Nlc3NvcnMgJiBkaXNhYmxlZF9jcHVzIHRvIGNo
ZWNrIGlmIHRoZXJlIGlzDQphbnkgQ1BVIHByb2JlZCB3aGVuIHBhcnNpbmcgTE9DQUxfQVBJQy9M
T0NBTF9YMkFQSUMgZW50aXJlcz8NCg0KdGhhbmtzLA0KcnVpDQo+IA0KPiBQLlMuIEkgY291bGQg
YmUgY29udmluY2VkIHRoYXQgdGhlIE1BRFQgZm9yIG15IHBsYXRmb3JtIGlzIHNvbWV3aGF0DQo+
IGlsbC1mb3JtZWQgYW5kIHRoYXQgSSdtIHJlbHlpbmcgb24gcHJlLWV4aXN0aW5nIGJlaGF2aW9y
LsKgIEknbSBub3QNCj4gd2VsbC12ZXJzZWQgZW5vdWdoIGluIHRoZSB0b3BpYyB0byBrbm93IGZv
ciBzdXJlLg0KDQo=
