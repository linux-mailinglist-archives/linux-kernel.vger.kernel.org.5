Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A477F1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348655AbjHQIFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbjHQIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:05:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B0E48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692259514; x=1723795514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NVl2F+CnPztI3Yc13MrBrf0avEgyZMCrf+JLWUPj6D0=;
  b=QfoFSHaGbYjyKABk4k7Lxm/Kp9rAF+GAMOacP5RecbBmFUvShIBWpRmH
   3FfSZsBBBGFZ4BWrK2FaqWHqMatP1gv599OKMehAWB4TiL1vyLQqkF8De
   w3FmrzaM89VvR4eA5ApItWt+mT/Hb2FhRK0cLuKA79WIS7wOZu7o/sQyB
   9WJXH2B678nosaPNadp9g2UIvWPgAG26PdwwrTr7+TzY/nYCPe4z/z7k2
   9ledAtorgJnvqr3ZO4sPKg2beW/mDzhH0OInxpRVsco6iuRNlDCnWcLWb
   7kN3XvrFLxtSdyWXK5y/wLko3MuJWpGGWjaUX96+q2FlDudoAjSVq3v63
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370212540"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="370212540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878127133"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 01:05:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 01:05:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 01:05:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 01:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTvZGYpgXNtCKTm1+iWJgLMUokpeLweZsgmG/kfME8I+Q7XOclpOzExUdTpuIixh5xkMOAqDbgEWigBUzA/kWLM2mUE+4F8e1X3eEI7p7oORKU6I+0MM1BF1p1FqFgutbYhudC6yJrGaeVQ+X0c9PbsAc7PWOB8pJe6NwcMr9Aa7VZzTPEUcgxwQOiegqeL6Lob2BS5CgavXUJaLWi1Wz/u3LSs3pja0cr+HN94kYOCbgbOM7VixgtJEpHR2KwpTPEiZ0hEyA42MDbdeh+Ct0Q3sFnjOLlBuJ3Vn2DG+xt3yjvFHsy8BMH+zX+PfhRc9UrU7VYGbwW3UXfkyOn3d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVl2F+CnPztI3Yc13MrBrf0avEgyZMCrf+JLWUPj6D0=;
 b=PRHwX9zXp7UD5Ckm7Oc50X8BSA1Sh3HacNi82mpURaAqHUgkk/MtyRE8i+ewAz/g8Ib1/GCkKoNS+a+K7LVkJ++xlK+c1kCdlaslvD30H8jOmrLExy1gqjg+LSF/6rkjqBVoryjdGdQ7yrVXSBNhDxgMCjmar1Eu+1kbIEd26+kkQF9Bj9P25l19mmtyKYk2tv5Q0MiSLVSl7yHN5g3kZfNNolWZbvaK+5D2/dOi/UXKoZBo5di9yA8H0xXYWv40JDDrA4QL6wtRmqzqM9YlLoREIxvqGi7GiC/0+ewCk+ixkxwJU9c2Ey9PUhUxlzQtMUD4l2ujscp8/nUaj9Podg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 08:05:11 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%6]) with mapi id 15.20.6678.025; Thu, 17 Aug 2023
 08:05:10 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [paulmck-rcu:dev.2023.08.14a 49/51]
 kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such
 file or directory
Thread-Topic: [paulmck-rcu:dev.2023.08.14a 49/51]
 kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such
 file or directory
Thread-Index: AQHZz+To6ZH2dmJ5tU69kGIoLGp+Yq/sMGwAgAHxigA=
Date:   Thu, 17 Aug 2023 08:05:10 +0000
Message-ID: <63593d36f4bfb665fb7e62733114d2c5e3d3f873.camel@intel.com>
References: <202308160930.YEekR3Wf-lkp@intel.com>
         <a5fa35dc-6244-41ef-9f5b-08aa497d9a74@paulmck-laptop>
In-Reply-To: <a5fa35dc-6244-41ef-9f5b-08aa497d9a74@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|BL1PR11MB5301:EE_
x-ms-office365-filtering-correlation-id: bf2c2f33-d5e4-43c0-8c4f-08db9ef8ade2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+Y4ruG9+HdpS7ANJrbzNPrZIMvrWQgdP0+YRa/8dZaeGXDBix9m8LvAY3X/lSzaOPyOuP8zsdkW3K5eLF/jGV8K6ZCPrkLw/Ehbg8O4/ht/FAw5wU2/4LYdsLOmg7CIQ763QZNAeuPaMlSC/x5oAat+sYj+46vG/wTMwKYgGbFxcGN/mfRBy0eU1zFVzHpZuypwsoIJA6UhsY8R3A1sEiWYuGZ0lCcjRvMRIVpZGIPnXyhAdLUxZqbgT0gITsxajH5N8rcuNftl+FB3U/Lfb6J2Fm/14jzuosBohoaNGnlSP3bCwiGlAegeDH5jDXUiWABJUZNuombYccr3WrjboKC1gUYlqct8okt2NxFRwGQYT5ozj7qoX9OrxNMURPBDW9vl8wIrDFKC+tqHt1ZJ8dSoPVdbrhL/bcmu2KbbtPRiG2KHfQiyc1jNz5B5f7DNuAnbbiRw9f5fN+SgNFBIqXDTr9b5o3sovh6dDETGkeecg9aZByW7XAWEKLba871ucV+3F2at4XsocJrwdLsfPomrYD+Rft3WICaVk8mfnDTtivF5sEzKgI78zB5yWf2YL/DQDr3RvpnuJB9PJgquAQZbUhHaAkj3omthGwsn7fP9Eeq/ChXfCVCRcrdHcUmMXt2W3pvS3Hn6XPR+lEgUzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(1800799009)(186009)(451199024)(2906002)(83380400001)(91956017)(66946007)(76116006)(478600001)(66556008)(66476007)(66446008)(6506007)(54906003)(71200400001)(6486002)(64756008)(6916009)(316002)(966005)(5660300002)(2616005)(26005)(6512007)(4326008)(8936002)(8676002)(41300700001)(36756003)(86362001)(38070700005)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG12OXUydy8xZTdvQ1Nza01WeFBVQkZ1bjJYdEZFbkp2STJTTFVHenR2S2Zq?=
 =?utf-8?B?RUJxdDlJYXpTTmpUVHYxM2lVUzk4d1FCT2NzMjNoSUZLd3dpSVNiVFRuNGlO?=
 =?utf-8?B?a3ptL21QenRld1NSallDMjJWMFZ6d245S29sVWhKTW42a1JNMzhrb1V0aEJr?=
 =?utf-8?B?eUszZUZnMGhZQWdBUjN3YUVHZUFFTko0WERLWGwxZEJtdy9TUFlSWElKM2dy?=
 =?utf-8?B?UkZmU0xURlRQOHBxbHhwMTIrVnowZlkwZ3pxOWpDSHRzSW9obFY0bGNXaDNn?=
 =?utf-8?B?Z2JtbERGL1AzdzFKNVpTczdzMko2anV0blN4ZU1YMmtOblQrNWp5OE9nSGJn?=
 =?utf-8?B?N3ZWbUUrc2R2RmIydG5IaXVqMGhSR3k3dXFzU1ZlWFFxc3dYVlVyVlhXNUxD?=
 =?utf-8?B?UUl1T2hCcHl3MVd0UjQvelJzYldTbzdWY2pOWndZV3kwUzVmU1B6NEJxenI5?=
 =?utf-8?B?TEJwQWNPL2Vxb0lVdkV1RDlib080UnNIMVVNM1dFNUluWHBBWk52OGJhczFz?=
 =?utf-8?B?K3ZpRUxGUm5sS3B4VVAwTHYySGc4UmozTU52WUFwSU5UYVl3SldKMUQvVDUy?=
 =?utf-8?B?eC9hN3FaK0ZtQXZsZFludXVuSGxQMmZrSjgvM3c4bElQcG04NlR3Y1EvZEFx?=
 =?utf-8?B?eVRScTQxSTJtVHpRZkhvaTNMTHAvYmhjYzlnclVHNzFidUtsZmZmdmprQmZv?=
 =?utf-8?B?Lzl5UzVtdnR0cUNoa2Q2TzllZkV2N3BYbmtDYkVvM1gzR3dJNXBrd2V1Rkdo?=
 =?utf-8?B?aDVKWk5LK1hValJmSHBIZkpGU0lKV0t3MkJ1RU5kekJScDBoN01NK1dSOXNi?=
 =?utf-8?B?cWluTTdKUXdxMEw5dmlhOVV2dTVWQjJkNU43aWY1aE5uUUR0R2ZBVUtlMFFW?=
 =?utf-8?B?TEpJUmNvMWdSNGF4aElKYjB5MlduNnpsR1VjSlVXYmVaa0l5SmdYUG4xb3c0?=
 =?utf-8?B?MEUxd1RvZEt1akxEWkFIRlVYSm5vb0FXeFYzWEpDbmpXbHFac2x5SDU1ZjhP?=
 =?utf-8?B?ZmlicWpxdTVTY25kMGpWN016S0duSlRUZkE1OGEyUGNDZTlydW12N2t5MXFP?=
 =?utf-8?B?OWlYRFROS1VlM2lScHpwUFN2dGxET1FPRVNrd0hJYjl5bkw4WjEwcVZYWEsx?=
 =?utf-8?B?aE5nY3IzYWlJdzZSZ3NteHErQmZLd1pWekFWeXBlMVZmQlZmQjBLMkM0UStr?=
 =?utf-8?B?YjEwY3RiSmh6SVpiT1k2MDB2T1JRa3N2ZUZXRWNtc2E1aHQ2ZTcrRFlkY3h1?=
 =?utf-8?B?T2QvQVVCdDB2ZmN0ZG40SkpoRG5uU2tMRFdwNnp4WGE5dmVyTlNTaHZ4OEVj?=
 =?utf-8?B?V1VUb0tMVmM1TDBnSGp0MDFheGpyb1UzclpLeStBbVRLREdMWS9ERnVZcGwv?=
 =?utf-8?B?WGNpSlUzYnJ5TG1YSjQ0YktZMTF6cU41UUt5M3pSVk01d29mTEM5VTBjY3JM?=
 =?utf-8?B?blUzU3YvbVlvSHdxQS93dVhmaXVmVXdUK3VFTE50OXlPdG4yZ1ByRjYyVHRC?=
 =?utf-8?B?MW42NllTZjJ5Y3VZdC9wQXI2UzdscXRVWUZGNnozTWdkbVhJb25WNTVyVnRQ?=
 =?utf-8?B?YklDaHZVN0RmcnRUSFVWZVJxTEJ4aGFsVEh2MnpPT3QzUlZLaVpWNkVhYzRr?=
 =?utf-8?B?RUJsU0tVNnRNSjdlbUtVSzJOM0FIVVdyaHB2QlUvYVNTdzlUVVUwb0pZWW5D?=
 =?utf-8?B?L0c3NklrTWV3emU5RFRpQndrQXE3U1hxUjZPRnR5ZHNMK1A0a041Z0hYVDls?=
 =?utf-8?B?UGxVU2U0Ull0c1d4Uml6RnlCYWNVRkNwRGxoNURiYUxFM3U2NURuTWpQeXU5?=
 =?utf-8?B?Qm11MzlaejB0cTVNRHB2a3BXQkgvVmhMc2U5TzFmRUlNNkQ5aVpzVzFqSlhQ?=
 =?utf-8?B?cjByWGt3d2h3MXlRd2hYY1czRDBsU3U2YktUYTI5d3hCWjdna0p5SGVLTzdj?=
 =?utf-8?B?bGpNVW9tNkZYaU8vc1JBQm5HdHFZbVZrcXdSRHVsY1UxV25GN3JoOGQ2T1Na?=
 =?utf-8?B?Rkl5TGFxVkZObCtpM05MNkhzOUJSWmRTditFYWNHRGtwL0ErS0xYaTZqVWg5?=
 =?utf-8?B?cURkNjFCUGk3MEZqVm5CZWluYTl5KzBaSndMLzgyQnZjenZPcEdwYkxad2JO?=
 =?utf-8?B?Q21nTFZreTBONXNuSVZJL0hZUW40d0pkR1hwcmZlRExqT1o1eTdNTHdGNGdX?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D71B53E4A1B9AF4BBA0B7F0865610407@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2c2f33-d5e4-43c0-8c4f-08db9ef8ade2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 08:05:10.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw/mL3h5CY2r02Merb/px+qR90gHPDUsP0wA4nLwnz+iarbsDtIykP9Zc/zTF8b0IkKupy49sK8VYbLf4ubFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTE1IGF0IDE5OjE5IC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBPbiBXZWQsIEF1ZyAxNiwgMjAyMyBhdCAwOTo1NTozMEFNICswODAwLCBrZXJuZWwgdGVz
dCByb2JvdCB3cm90ZToNCj4gPiB0cmVlOsKgwqANCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wYXVsbWNrL2xpbnV4LXJjdS5naXQNCj4gPiDCoGRl
di4yMDIzLjA4LjE0YQ0KPiA+IGhlYWQ6wqDCoCBhOTBjNGNiYzkxNDc1YmQ1ZGYzNWY3MTJhOTU0
OTcyZmJmZmY0MGExDQo+ID4gY29tbWl0OiAzNzczMGE5YmExMTYyN2I2M2Q4MTA4ZGQ4YjMwNjFl
YTJlZTA0ZGY5IFs0OS81MV0NCj4gPiByY3V0b3J0dXJlOiBBZGQgdGVzdCBvZiBSQ1UgQ1BVIHN0
YWxsIG5vdGlmaWVycw0KPiA+IGNvbmZpZzogc2gtYWxsbW9kY29uZmlnDQo+ID4gKGh0dHBzOi8v
ZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDgxNi8yMDIzMDgxNjA5MzAuWUVl
aw0KPiA+IFIzV2YtbGtwQGludGVsLmNvbS9jb25maWcpDQo+ID4gY29tcGlsZXI6IHNoNC1saW51
eC1nY2MgKEdDQykgMTIuMy4wDQo+ID4gcmVwcm9kdWNlOg0KPiA+IChodHRwczovL2Rvd25sb2Fk
LjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMzA4MTYvMjAyMzA4MTYwOTMwLllFZWsNCj4gPiBS
M1dmLWxrcEBpbnRlbC5jb20vcmVwcm9kdWNlKQ0KPiA+IA0KPiA+IElmIHlvdSBmaXggdGhlIGlz
c3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGENCj4gPiBuZXcg
dmVyc2lvbiBvZg0KPiA+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93
aW5nIHRhZ3MNCj4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4gPiA+IENsb3NlczoNCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWti
dWlsZC1hbGwvMjAyMzA4MTYwOTMwLllFZWtSM1dmLWxrcEBpbnRlbC5jb20vDQo+ID4gDQo+ID4g
QWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+IA0KPiA+ID4gPiBrZXJu
ZWwvcmN1L3JjdXRvcnR1cmUuYzoyNDoxMDogZmF0YWwgZXJyb3I6DQo+ID4gPiA+IGxpbnV4L3Jj
dV9ub3RpZmllci5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4gwqDCoMKgwqDCoCAy
NCB8ICNpbmNsdWRlIDxsaW51eC9yY3Vfbm90aWZpZXIuaD4NCj4gPiDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IMKgwqAgY29t
cGlsYXRpb24gdGVybWluYXRlZC4NCj4gDQo+IFlvdSB3b3VsZCB0aGluayB0aGF0IEkgd291bGQg
cmVtZW1iZXIgImdpdCBhZGQiLsKgIDstKQ0KPiANCj4gRG9lcyB0aGUgcGF0Y2ggYmVsb3cgZml4
IHRoaW5ncyB1cD8NCg0KWWVzLCB0aGUgYnVpbGQgZXJyb3IgaXMgZ29uZSBhZnRlciBhZGRpbmcg
dGhlIG5ldyBoZWFkZXIgZmlsZS4gU2VlbXMNCnRoaXMgZml4dXAgcGF0Y2ggaXMgYWxyZWFkeSBp
bmNsdWRlZCBpbiBkZXYuMjAyMy4wOC4xNWEgYnJhbmNoIDopDQoNClRoYW5rcywNCll1amllDQoN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFRoYW54LCBQYXVsDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tDQo+IA0KPiBjb21taXQgMmI3
ZTQ2MjY5NWVlZTIxMmY4MWY3MDAwYWY0ZjRhZjI1MjNlY2UzNQ0KPiBBdXRob3I6IFBhdWwgRS4g
TWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gRGF0ZTrCoMKgIFR1ZSBBdWcgMTUgMTk6
MTc6NTAgMjAyMyAtMDcwMA0KPiANCj4gwqDCoMKgIGZpeHVwISByY3U6IEFkZCBSQ1UgQ1BVIHN0
YWxsIG5vdGlmaWVyDQo+IMKgwqDCoCANCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4g
TWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3JjdV9ub3RpZmllci5oDQo+IGIvaW5jbHVkZS9saW51eC9yY3Vfbm90aWZpZXIuaA0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmViZjM3MTM2NDU4
MQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcmN1X25vdGlmaWVyLmgN
Cj4gQEAgLTAsMCArMSwzMiBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArICovDQo+ICsvKg0KPiArICogUmVhZC1Db3B5IFVwZGF0ZSBub3RpZmllcnMsIGluaXRpYWxs
eSBSQ1UgQ1BVIHN0YWxsIG5vdGlmaWVyLg0KPiArICogU2VwYXJhdGUgZnJvbSByY3VwZGF0ZS5o
IHRvIGF2b2lkICNpbmNsdWRlIGxvb3BzLg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAy
MyBQYXVsIEUuIE1jS2VubmV5Lg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX19MSU5VWF9SQ1Vf
Tk9USUZJRVJfSA0KPiArI2RlZmluZSBfX0xJTlVYX1JDVV9OT1RJRklFUl9IDQo+ICsNCj4gKy8v
IEFjdGlvbnMgZm9yIFJDVSBDUFUgc3RhbGwgbm90aWZpZXIgY2FsbHMuDQo+ICsjZGVmaW5lIFJD
VV9TVEFMTF9OT1RJRllfTk9STcKgwqAxDQo+ICsjZGVmaW5lIFJDVV9TVEFMTF9OT1RJRllfRVhQ
wqDCoMKgMg0KPiArDQo+ICsjaWZkZWYgQ09ORklHX1JDVV9TVEFMTF9DT01NT04NCj4gKw0KPiAr
I2luY2x1ZGUgPGxpbnV4L25vdGlmaWVyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4N
Cj4gKw0KPiAraW50IHJjdV9zdGFsbF9jaGFpbl9ub3RpZmllcl9yZWdpc3RlcihzdHJ1Y3Qgbm90
aWZpZXJfYmxvY2sgKm4pOw0KPiAraW50IHJjdV9zdGFsbF9jaGFpbl9ub3RpZmllcl91bnJlZ2lz
dGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbik7DQo+ICsNCj4gKyNlbHNlIC8vICNpZmRlZiBD
T05GSUdfUkNVX1NUQUxMX0NPTU1PTg0KPiArDQo+ICsvLyBObyBSQ1UgQ1BVIHN0YWxsIHdhcm5p
bmdzIGluIFRpbnkgUkNVLg0KPiArc3RhdGljIGlubGluZSBpbnQgcmN1X3N0YWxsX2NoYWluX25v
dGlmaWVyX3JlZ2lzdGVyKHN0cnVjdA0KPiBub3RpZmllcl9ibG9jayAqbikgeyByZXR1cm4gLUVF
WElTVDsgfQ0KPiArc3RhdGljIGlubGluZSBpbnQgcmN1X3N0YWxsX2NoYWluX25vdGlmaWVyX3Vu
cmVnaXN0ZXIoc3RydWN0DQo+IG5vdGlmaWVyX2Jsb2NrICpuKSB7IHJldHVybiAtRU5PRU5UOyB9
DQo+ICsNCj4gKyNlbmRpZiAvLyAjZWxzZSAvLyAjaWZkZWYgQ09ORklHX1JDVV9TVEFMTF9DT01N
T04NCj4gKw0KPiArI2VuZGlmIC8qIF9fTElOVVhfUkNVX05PVElGSUVSX0ggKi8NCj4gDQoNCg==
