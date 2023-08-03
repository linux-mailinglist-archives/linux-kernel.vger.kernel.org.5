Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2E76E889
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjHCMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:41:30 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249332D42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691066489; x=1722602489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uCkkLF/UB9VeRy1U1vJsfw0X8Wx6zso7cKe9aUASuUY=;
  b=KrrKs1E7IkjYk6iVzOXDlKTmTOC7lttCdLXhMAB5FTs+rx+b/CStDA9o
   pPKZzoy5wXaN0mHmbRDsXd5NAuiTw5PbLpOkVbJz300VWZQWBDQGDrb1i
   gLe0z4k97hKFIsCwgXJtVRz7t3RWhqG8S6J0mnOLWY0NLS4HsZT1zyMM+
   O38Uyi3ckkFLqjMvFDZNgdfBKB2lsNCKy5mkuowbTdxlmL9Zik5L3je0G
   pbNMyX85pfWhsQ5RBj/0kVbb+tD3Di8Jk1+X+URRTrJyATHgTAS+KD5fI
   uS6G6ZapyqivTy8i1aaJikN4TM9lWZUMJq7rC7mNc3NMKt7lR99FlNe5O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="359900755"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="359900755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819634727"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="819634727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2023 05:41:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 05:41:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 05:41:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 05:41:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 05:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki43DIqT1hMTmhxIVyiakCIV0DHDLQGdbBrDSr99m13eG5TbFe+06gx/YJ/pYa3zbgrDeF8KVbkoqh8qs/m2G37REnrWcQjNuvBW8EVdT+U6bYN8r4+xn6a3zK3VRxRgyT2PV0rkFMTsD/TbGiM89CRlhZuTeLKBhMzp4PzCJu7uTbTHk76d14fYnXLTgIGryorY36sxxpyr1huRcoSYrURc3SPpxwjx79MJMOTHxjDQs/5OUkk2N2jP1uWiUi3hnpM5+h48/15iw0Z1Nmvg61iuwBTriBlF2TICnvd8xKgYv5KX224YWIDvnl7oEp45ZEuVlDdeNoh+86bnhWHMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCkkLF/UB9VeRy1U1vJsfw0X8Wx6zso7cKe9aUASuUY=;
 b=lXWg4/wjsHexImLzq/7dwKauwv68jWWtcKJNv7wEMpbAyEnvgh6LgCNNze1vXZzEkmjYtZqJ5WDWZhiieFAkRs+L5Fg+Ft5MAvwmGROWaivO91dnKUqGZvacmXJ/So6jPWtaIaFvMNWPGtTMFOQbfdt3oX39K0RyaRiC0mqTh942yC5jCqo3tDGRK3byQ+LlT5pR/UkxkSH/w7rhvdVAnJc/SUr/3iX1bM2FGrmoMYHeRsAoxlW4vOyyv39e4aloDjoJi7pQY8u0VPcMgB3cgE/josMDzPVhQlRl7fb3bc0PCC/0iNC0O6jCfmbA7KVSmpZf5G2xxp3Ve1HrOx9Buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 12:41:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 12:41:25 +0000
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
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZv7Ew9wXfCjaIFkeFM7YTTvK7Ya/N2wEAgABjTACACkJlAIAAAwkAgAAEVICAAAgsAA==
Date:   Thu, 3 Aug 2023 12:41:25 +0000
Message-ID: <ce045f6ccf9451d177581280c35092de7bd71488.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
         <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
         <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
         <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
         <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
         <20230803121207.krvcuj22mdxhugog@box.shutemov.name>
In-Reply-To: <20230803121207.krvcuj22mdxhugog@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5285:EE_
x-ms-office365-filtering-correlation-id: c4c434b4-4d72-43fd-e132-08db941ef34d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEi07hl4hiVvuFostU3PjbA+wAFEoelzLmhBT/Fb9ByxO/CH6HD/1UfWqzHgG6bizqAmFd0hSv3saRvULe44PlF+9jqGUogml0ww/tg8UaihjZ8hNjapxrW3eZ5X6IHRkLa/9EuEJGnN8v9PsZEX5D1ReJwglDDwYGQs+9FDSsJEoRX24GWlDwRCpRDG5/OF7wt/MYMftSayMvzd5GtRA+L36w7SWXcHrsCTBg2QTeJFHMnPtVGDcQ97SEhafwPuukGLoST7JNHY9WFeJ5uGVLUYQgwmRiH5J1rEMgu0lr3/pGBFPR+aVNaikdpA0MF9dbfdwHdu1hoKkxnQ8xLwGMjjW9y/7FHs+0N/8/uq6JCqWtY+8EQS0yuQuILuX35swAyHYP8QZsucTgQEhD89Do1zoO3uzVwD4gQYFvUwJ2wszASvcM3kVOOqUB9CgdSSPDOp6WNNeLinE5GRQdio/8iqnkhZd36DAGHGM0W3B9lmitcMTYqo7NVHwey/Uv1sQeyo5YQgksSdzfxKG2Jm/U/uX9PLKarJqOBkM9Esi1Q1JTw1m/rBZ1Frs7+WlE+kh9TVKNQgZaBVnxL74ISbY98UG0ov1Wfw0Xwg1nmIRrieiwO6pRzoKPUKfoOEAyKI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(36756003)(38070700005)(86362001)(54906003)(478600001)(38100700002)(82960400001)(122000001)(2616005)(6506007)(186003)(26005)(8676002)(8936002)(41300700001)(6512007)(6486002)(71200400001)(6916009)(316002)(4744005)(66446008)(66476007)(66556008)(5660300002)(4326008)(7416002)(64756008)(66946007)(2906002)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cStGdVZ2S2NubnVCcWtFWDVUNDJwUWsyRlo0alZzdTVBcEcrSXVzZEw1c3NH?=
 =?utf-8?B?WThJcXNzNEZ3b3BZSEYzVms2NytvMzBBYUdFbG1hekVTVEw3L3FEYVZnTVBy?=
 =?utf-8?B?UnBnZUFZbHlLMExvRDl6anJ5TDl1UGZJUE40SUJ4cDRyOGV3VjlQU01SdWhW?=
 =?utf-8?B?VGUxajhyRzJZak1LNGI1bDNNUmo5MTA4bzd2SU5xVTdDY05XRjEvRHk0VHha?=
 =?utf-8?B?cjRYTExEZkRTUDRPT3UwMDYwTVZqMDRIY3RqUzczSjladEZKbVNFRjkxRDJn?=
 =?utf-8?B?M2RTNEhTYTI2d0t4VXhveUcza3BaYXRnTWhqNGRFM1dmOU9FdVVwSi9OVmtP?=
 =?utf-8?B?eEU4ekZFR2xFcmVsY1BhcWFSUU95bEk0a2RyckRJa2FicFVqdFFRdzlBdHkz?=
 =?utf-8?B?bVRrR1Rmc2RxMDYvVG5RTStNN0xtTnk1eUdZTytQVHpiOTBLUkpsNjJzazBm?=
 =?utf-8?B?US9KcTJaRmREeEpEZHNjVmVhMWo0WnQzeW1xYnExT2RXdjVobzJVVGNlREdi?=
 =?utf-8?B?TWxEYlQwYXZEbjV4MTlNa0JTSEJIcDR3TmlxRWdEVDdrd2NqOHhUcVlRK0xZ?=
 =?utf-8?B?ZHdlNThxU1JGUTB0VUhJRWx5TFNmQTVORDdra0tuZWJIRU1pRWgyaHFETWJX?=
 =?utf-8?B?WmxVRVUxaGdoMXErWXVFazhOVkRPUDFpeWJ2RDZBMjVSL2ZoQ0xQUUVlaFNs?=
 =?utf-8?B?Sk5lZHlVWHVaTlkrZkF1eFJQN1RKL0xNWGRGZVVLT1NwZ05nS1R5WjZxYmt0?=
 =?utf-8?B?TTFZTldjU1lvVlRaK3owT0Y2djRsMDNoUk1GaHVrYWZ2d244OXE3TVNiZkVw?=
 =?utf-8?B?KzF1U2VjUEVrV3pTdEJKczdJT0UwYVFPWWU3eW1KQzgzWW9DMEQ4S2lyNEUy?=
 =?utf-8?B?cG9qazAvaGVIM3l2K2hpZDRGVVRtWXpBSWxRYXBiSGdXQVpLV1FWODYzb1Uv?=
 =?utf-8?B?dU5OWHNuaWpySzU3aVlmbmwwZVE5L0JQTE1ybGdRZ1kwT3RHZ1lGWEorcTdM?=
 =?utf-8?B?WmJjejVsM25sWXptTENSWlZuTkxLRDFEY25kY3crTDdEa0NMVjloTUdvLzVq?=
 =?utf-8?B?S1ltZmVWUCtlWGIwM1F6bVo3VTNYUXhPWUhxSUJ1WGN3MHhGeGIzSysvRjhR?=
 =?utf-8?B?NG1vNk00K0ZDUkthTnA0TzRaMWZQa1pwbjlvaG52NFdRS2Y3bmdidHVFdWxk?=
 =?utf-8?B?Y2xjRklOdElPMmtXbWhmVXVOTm5wcGM1VXNVekd0U2NvRXNBZGZHcEUyZEQx?=
 =?utf-8?B?SVdEd0ZLQVNxQ1FNNWlLclI5VWtuQ1FoNFFtZ0NjTURoZVNVL2MvV21xUWNP?=
 =?utf-8?B?WkRjK0c3MHJNbmFGcVMyd1d4UHNBalRoU3Q5Smtna1ZuaExHa2VQOTEwVVJG?=
 =?utf-8?B?RmFkSGpPa0REdG1jV3VJSFAxekdJRWkwM0E1WWFQNU5YWDR5S29LajA0T2gx?=
 =?utf-8?B?Z1hJZnVKeFBRemI3NHJTY3h6Smp5ODN0VzRnWnlOc3hoVi9tY0dOWmd4LzZF?=
 =?utf-8?B?VzdIZk5qNlBITWg0V0ROMGdlQlNGUis3QnpsOUJXaThDR2pDVEFSclhhS3J0?=
 =?utf-8?B?ZzFqcWtYUzlzVVVuWTg5ZGZ2QVlvbWxEa2FmbTNhQkJGMFJCZDNxbEF3aWNr?=
 =?utf-8?B?amFJODNMYkVlK0hERVVxQ21YY0RxUU9xVjN6dCtzaWIxeWVsblVJNVIyZmlh?=
 =?utf-8?B?TVhGdFR2VVR1OVdGMEN5VWVveGVMWTZLYnIyUlNSUmdLU1FGYkFNMmVtdlF6?=
 =?utf-8?B?Rm5CelFtc0F3ZlNsUm1wcm56dlR6WkdYUTFDR1NzWUtZQjRjUTAzTHJzSnZv?=
 =?utf-8?B?MGlvcVVaeDVCUkkwQWppK2p1NW9zMzl5ckVQd041NU93NklwUUJYK0NyVTFH?=
 =?utf-8?B?SklJUkt1dWFXckZKU1RpbklyWE1oQy9VWFplUXVJNmYzMVFKeERhd0JFSGE3?=
 =?utf-8?B?UWpoMmRmckIvZnZ6MnZWSy9OT1YwVTgzMUgzd2xrK1VTTkhtMnJSTVJxdEJ0?=
 =?utf-8?B?WVF3RVZ4TUxDL1kwWUx6V0NhNGo1NVcyVmpwa3dFT3FoL2JpcnZmSHVVZlVT?=
 =?utf-8?B?R2tYZnJFVktZNWwyWGtTWm9adElkVWsvT2RmRjJIVzJ0bDJQMW9RNzVMeDBH?=
 =?utf-8?Q?BrGai5h8oPg2K4jnMDjtwWmCl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43352B7E8E2E84F8B9D2CBC43632C04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c434b4-4d72-43fd-e132-08db941ef34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 12:41:25.4659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BffVAJ0zYwaQSvVv4Ecxfj1QZxcMR6elnpYI7gwZSSoNfGL1W3u0ZdsL8uIIXk6NdJdnsp6ex7qyTUprtYpRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDE1OjEyICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAwMywgMjAyMyBhdCAxMTo1Njo0MEFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wOC0wMyBhdCAxNDo0NSAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+ID4gPiBJ
IHdvdWxkIHJhdGhlciBrZWVwIHRoZSBzdHJ1Y3QNCj4gPiA+ID4gPiByZWFkLW9ubHkgd2hlcmUg
cG9zc2libGUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBXZSBjYW4gYWNoaWV2ZSB0
aGlzIGlmIHRoZXJlJ3MgYSBjbGVhbiB3YXkgdG8gZG8sIGJ1dCBJIGRvbid0IHNlZSB0aGF0Lg0K
PiA+ID4gDQo+ID4gPiBLZWVwIF9yZXQoKSBhbmQgbm9uLV9yZXQoKSB2ZXJzaW9ucz8NCj4gPiAN
Cj4gPiBUaGUgcHJvYmxlbSBpcyB0aGUgYXNzZW1ibHkgbmVlZHMgdG8gYWx3YXlzIHR1cm4gb24g
dGhlICJccmV0IiBzbyB0aGF0IHRoZSBSMTANCj4gPiAodXNlZCBhcyBWUC5WTUNBTEwgbGVhZiBy
ZXR1cm4gY29kZSkgY2FuIGJlIHNhdmVkIHRvIHRoZSBzdHJ1Y3R1cmUuICBPdGhlcndpc2UNCj4g
PiB3ZSBhcmUgbm90IGFibGUgdG8gcmV0dXJuIFZQLlZNQ0FMTCBsZWFmIHJldHVybiBjb2RlLg0K
PiANCj4gWWVhaC4gVGhpcyBpcyBkb3duc2lkZSBvZiBzaW5nbGUgYXNzZW1ibHkgbWFjcm8gZm9y
IGFsbCBjYWxscy4NCj4gDQo+IE9uZSBwb3NzaWJsZSB3YXkgaXMgdG8gbWFrZSBpdCBpbiBDOiBu
b24tX3JldCgpIHZlcnNpb24gcGFzcyB0byB0aGUNCj4gYXNzZW1ibHkgaGVscGVyIGNvcHkgb2Yg
dGhlIGNhbGxlcidzIHN0cnVjdCwga2VlcGluZyBvcmlnaW5hbCBpbnRhY3QuDQo+IEJ1dCwgeWVh
aCwgaXQgaXMgdWdseS4NCj4gDQoNCllvdSBzdXJlIHlvdSB3YW50IHRvIGRvIHRoaXM/IDotKQ0K
