Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0D77CFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbjHOPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbjHOPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:54:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B09A6;
        Tue, 15 Aug 2023 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114882; x=1723650882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UW+qfgLpAeNqc3S00MV3slfW4KTsazDQNUgsw0ea7Wo=;
  b=KtHQVvNLi/0vBr0Xysu5Hxd/+5J35XcpNil45T9Q5R+suopts06ImFUP
   2MVnJfTnzyL7BoqLjCeE3CSbacPwemA3K9ZVHRAX/0NyywalPIm6IQlue
   GlCXloRzjNkZAihd92JO1VF91ktb6z8I757CN+MExt3sJgtOaiH62pUgH
   I1scAvnoeN7g2BPHMXZ4EaGq2qcTZXaUf1XHkYJmxHoj2NkjLd/3/6elP
   8uhjr0QpLxb7Op2kHKrfhf2rit0yOXkZt+o6JJPQva+byB6Z5cEZgjpHs
   rmj/bnhd5Dg5qxq7hh3do9QtIOE9RLhTqlgrjJJlER1njtborxWnVV0OT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436203288"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436203288"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763303569"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763303569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2023 08:54:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:54:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:54:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:54:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef+HnSf2QzUs1vgxe1Y6hiLHWhnbN0PHqjExfO2rDNrrmRUGbS1gmMS688MBd15+vMkAzJABOSofyqu+4mqT/HSrocWi2XGvpRDVVLR/ICX2PQld+zCVhvlKYj8BshY3T2HzLDZ+BL5XbBqvNBO13xwH/VUwSYoX1FhLh3CwEamcv4iJFPxUF5XXyGF8pgGSSRRGka8whKnmCxUlw62Nt41FKVCHcgOPijvhSCtMDxRadM+fAQxsQIaCRKJI/L3zvFsMbfAWkX6g+ZEv2lq/klmBTHwsM7Ovt2BRMQdKcbUTm4y9L9ESwYgu2K40Duz1BDw0C2tRHuUCANNvor3wLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW+qfgLpAeNqc3S00MV3slfW4KTsazDQNUgsw0ea7Wo=;
 b=kfxG8jnv6e+zG4l8NCn11LN6qLF45aN7wQ/sOfFJH5gImIV+zbrkQtfx+jJnA8p/AxnMvy48VMIZLUUerXkO/Ku9SfaGsCeAbFathicl3NtmuR1eY6vsKdenuNuZW6ECw+9MlT7hX7KtYWPzWtLgPM/wKWnsn3sDeiT3MPxy0qcjxtEXdBS6Mw4BS3mxr4SkjM0Y7bGK54E8RHP0LFgkld1JKoVvmw3/uHwfRiVorZx0d1tuZo2LvljRTbUfTkJ1jD+zLZ7IjQqvp440bmM80swiJ7YFMQdwNjB/RPtqz+a/24jmtobsV6HFV+AKs2PPMZkkD5H8D3dS8V8B3TzqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:54:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6652.029; Tue, 15 Aug 2023
 15:54:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Thread-Topic: linux-next: build failure after merge of the tip tree
Thread-Index: AQHZzzmXXVGpyjhF0k2s9JdIuv0aMK/rgwOA
Date:   Tue, 15 Aug 2023 15:54:12 +0000
Message-ID: <1fdfa18ae40175ad2fec1f1b6d8b0c9e2ecd1350.camel@intel.com>
References: <20230815152951.4516ec0a@canb.auug.org.au>
In-Reply-To: <20230815152951.4516ec0a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: 40ad27e7-8b95-4d25-c087-08db9da7ded3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLRrhHar1F59HROJuX8juW+XESL2KzMTwx5JXMoggg5ZnNVdJnvGrIv9LwBZHYEvxoV6ZjVCtG+TbrmmHJDKB2LiWVE5dAXg3ZaoRCdY/v/pax9RZkcLWJPj7lI3Cb3BigRMVNIrG86BzXzWrPiyOwPS2Zvl2Bx/QUQL5Q3jx0XPAr5aDRreyVfKh/dHFIJoLTbBkg4LHnFUJJjrtEwdbhIooL8SqLz3C6e3h2XnNpdk4oI3veqGPW0zJYM6USmKi9B0NE70/qHvhdOFhrIZcOn45+pem5Aor6bMJV3XmgxM5wX+eBFlJlDrp5z2JOBJ5281M4Q6K0L2jQa+qgE6q1T0c2+AvzEuPghqyasPpB1SAmyWLdFdlEGl6IDOVCVBRblRgsfxUGhib+V5LNv2NSWtgJ3zEjt/rgL6ulFlt9hbHah6yOmDPiVt2gG8NshoqT2A5gLzvapTAF8/7BhRRTloWjtIqwHTce3/1QNf1NCeeE0K0suBb722MMNM+Xx6xTud9Hm90VbsVmWUsc8BF9RGeZ21mIlXW74elXGiaZkMJnearv/tTVo/RwlM0CNfB+WsdJU8QrKrf5YiVoIflJMHF9uq0AyXjgs4BdxCW4bQLOf77QieHk5idU4crHir
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(64756008)(38070700005)(2906002)(316002)(478600001)(71200400001)(5660300002)(2616005)(7416002)(38100700002)(82960400001)(122000001)(66556008)(8936002)(26005)(6506007)(8676002)(6512007)(6486002)(54906003)(76116006)(4744005)(36756003)(110136005)(66946007)(66446008)(66476007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdCcFJxaGVEQjRqeXlBZHZZK1lhcjRvUHI0bDNyTU9nSVMwODBFd05IckZm?=
 =?utf-8?B?V1R4WXVJY1E4emtsemFzUzFOZThmdUZVT0N2LytEVjZTaUtwMkpGTUFCMlNs?=
 =?utf-8?B?YWw5SUN2RHFxcXo2Q2pScFRmcGlsSVQvMHpXM0dJcmpWNmNJbmZ3UWV0Zng0?=
 =?utf-8?B?akZ3ZVVXRlk0UDVpZFRlRlRyWEgzVkRSWVZkWC9aQXp0dU9Fa3R1YXVoUnhJ?=
 =?utf-8?B?NjZqZ0RaSnpyQjlsbTBOQnVqOFZ3QTJPRlp6K3dUTU03RzVmSzBiK2tmNUdv?=
 =?utf-8?B?YWRFODhmUDB4NmdkS25FYlpWZGo2VGx1c2g2clZRRFdaV2p6amVacEs2SEVl?=
 =?utf-8?B?UlZZNG1qWlJSR1Y1bFNsTy85ODdHNFI4WGs4LzIrLzVRdSt4YXpNZ1N2WER5?=
 =?utf-8?B?ODRDVmhsOVlHK2FPbWppZmUwUlpIeHNpdGJXdWpmRmRGS1ozVHZNVk5wNG9L?=
 =?utf-8?B?UXlKZVdTTUZRYmoxb2dSWVd6V21rcDhLWHBJVlJYRGV5VXVvclFRT2h6VTRQ?=
 =?utf-8?B?L2lwcUYyc1FNZWhGd1RmalpTRGI1cDhHdDFpV2JtcXBQYThneE9qUEtwNVhJ?=
 =?utf-8?B?MWZmWGtocXJYMzNwSFBNVC84V3JVYXEzR3FKTnk0Z0pNYjRaZ1VvL2YrbDV1?=
 =?utf-8?B?Nk8rREF0QWc5VlNUUDR2UFlnUEhaVHA3TGlhVldYMW9NS3NaMEJjS1g0QzVQ?=
 =?utf-8?B?WXZCclZ3dnBISVhUdGdTM05NaTZLRE1lcThkdHB1cldxSjlRelJ2NVAxazRF?=
 =?utf-8?B?NGw2dkpWOUIvVDMrL3UwdmRPYTJXRWN6ekJ3MTdMQnUrdGdDMEhNQXJYRXh0?=
 =?utf-8?B?dHNnbDNRWWFNRGVROTFHcHBkMXFYQ3pPNWRJYkJkM2NyVHBpbEFUMTZJczFI?=
 =?utf-8?B?eW04SStPZU1oVXpuamxKWm9pcUVsQS9CbkNlMTJEaUY5YWFtbVltaGxpSENw?=
 =?utf-8?B?VUZmV0pGMll5U3ZDWVhzNDBiTmJvWksrQ0kzRmw3cWxkSWs0YTkrR0dHSXpE?=
 =?utf-8?B?N21ReEtNOXFXNDAyMHR4WEVOTUsvYk5ESS93RWR0Y2hEWW9uUjhtbjhmNkxm?=
 =?utf-8?B?NmswaWk2UEpmYlhEUDlIWnlnc29iY1BHQzRnWWdVN2cwZWd0cE8wM3FCR0Fm?=
 =?utf-8?B?enQ5WDk1d0RFZ05qdk96V3NDWGVEUmdnN0tFaGZocExCT1hJbWlQSERVOFQz?=
 =?utf-8?B?aUFRU3duLzZwdnN2N2pjUjNCdXQ5dVpFRnBra0ZjYXIrU1llNVBYSXNEK0Yy?=
 =?utf-8?B?R2tuWUNzYnNqWk9vY0NLMGQwY25pV2h2cEVxbTExcm10ZlJOd3ovREJxM0ZO?=
 =?utf-8?B?RHVmL0hIYTdjWGpPNDNLZ0JLTU5SL3o3dnJWcllTQVpSbWdOTW5uMlpQTi9J?=
 =?utf-8?B?eURUOUpKWktUdS9WblZjdGZqbkJVa3dxL1Z2T1EzT3RYUEhJV1g3bWtnZkNY?=
 =?utf-8?B?RDhYUUMweS9uNjBoeTJIcFFlajB0a3IvK0ZVTTJzanZuMitPdzh6OWg2OWJD?=
 =?utf-8?B?RmZDNW1WeW55ODczU0c2TGRMTUtZdTlKMFV6aENXWUNBTGFEalppcTh2RTFl?=
 =?utf-8?B?a2thbllxYWFTdWR6d1B6WE1vL1hPMnVQSFdRSEZWZGRIWllESnBDRWpYSGw3?=
 =?utf-8?B?MlhoRTNZcFNvOUlEdUFsQ0Iwc0h2T2lFZjRRR24rMjZScUZraTZhTXBuRU8z?=
 =?utf-8?B?SnRUdm9mZ2FWOU4rSDdTendSWjdVNnBmeTJxQnYyM0Rja0ZZY1Jlb2pDcTZa?=
 =?utf-8?B?bHdRUk51OERSYVBFZUtIbmIwSk5Rc3lOclo0MDNXQk1ndEEyNGgzeVdQK1F6?=
 =?utf-8?B?U1A1aURxZ0NEOXJ4K0VSSGJwSzdNUlR3alN5d3RxRDlBUzl5aGRvYkxNaXo0?=
 =?utf-8?B?eDBxZno3L29lVFlzaE9MdHI3S2hScUhQWEUyb1diSFdabTNiSm1PLzRvYWx2?=
 =?utf-8?B?NFJ0bURMOXlXUW9EQ3Q3M0pvcWJxazl6Z1FsWUlIU0wrdGx1YXJhbE13RE5v?=
 =?utf-8?B?ay9aa0VSWEhzTFZSUTVsOS9IYmZEbWY5QnNCNUVYL3hvbmV6YndGdldaZmp3?=
 =?utf-8?B?cnJhVlduQ3JOcjJMeE80Uy9ZdHJ0VE1BaGJjOCtScmkzeWhvbU1ZOExIUkxm?=
 =?utf-8?B?d2xaR3grdEpod3RXOWI1UjRuek13eTVwYUNKa2ZLemJJeEx6OGVFelJ2cHo1?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EF29BE2D6449408B6D680BDF5634A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad27e7-8b95-4d25-c087-08db9da7ded3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 15:54:12.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzMRol1pB3gR0WgVVrO6R2KHgE9bp2VF9BpCMDT3dx82P1e+j9phdDEaGMIJGJcdYoxYQgEk7jnKOSc98yAxXMnlJRJTa9WazFOi4C2rs9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
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

T24gVHVlLCAyMDIzLTA4LTE1IGF0IDE1OjI5ICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBDYXVzZWQgYnkgY29tbWl0DQo+IA0KPiDCoCAxNjFlMzkzYzBmNjMgKCJtbTogTWFrZSBw
dGVfbWt3cml0ZSgpIHRha2UgYSBWTUEiKQ0KPiANCj4gaW50ZXJhY3Rpbmcgd2l0aCBjb21taXQN
Cj4gDQo+IMKgIDY0NDBjN2IwNjdlZiAoInBvd2VycGMvYm9vazNzNjQvbW06IGVuYWJsZSB0cmFu
c3BhcmVudCBwdWQNCj4gaHVnZXBhZ2UiKQ0KPiANCj4gZnJvbSB0aGUgbW0tc3RhYmxlIHRyZWUu
DQo+IA0KPiBJIGhhdmUgYXBwbGllZCB0aGUgZm9sbG93aW5nIHBhdGNoIGZvciB0b2RheSAoaG9w
ZWZ1bGx5IGl0IG1ha2VzDQo+IHNlbnNlKToNCg0KVGhhbmtzLiBTZWVtcyByZWFzb25hYmxlIHRv
IG1lLg0K
