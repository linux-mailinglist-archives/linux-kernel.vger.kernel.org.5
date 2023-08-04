Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EA76F753
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjHDB6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHDB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:58:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC54482
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691114312; x=1722650312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XVswu+t4n623HE5zSRMZyqbJ4IiNUE7oa9WrC/u8MJ0=;
  b=A+pswP2/WEpw9ZwDPs0z885IlMfmnWnQh5PYxWaG+SWSPY9tyeeCYnEl
   K+OSwxnwwZpuDqK6rLWDS9zzDLshKNc/kdsvaaCAiFdpkFkyht30n21/c
   mj2gXqsG5IRbjgAWExgt4asmhblHs/+3fj7MaHU/X87SH8j3lQimNpYmV
   NLDzxiIJ1I6i+eGNfiCAh8MVJqa4rJMoQKBVfOmtXK/90HE+TEo0Ce10f
   Y7JUro4LLRyssrzUVYw4yLgEH+pWrQP7adjL2+DtxeCIL3dBqvU2phPzk
   RkWfU66wmQWYq9+dW2pBNJPRx7G540Dn1jzwg0pdsn9u0knHNM8upHjFI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="354976965"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="354976965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 18:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060528822"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="1060528822"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 18:58:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 18:58:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 18:58:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 18:58:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2tOzKMvOTuKWros5AbpriO0mf/iho3ebqK1H/ZEmN9U3DH6TGtxY3q2QnlTVmdmfNYas7YEAhZAjNLTD7+AqTgsnnol2xU0HOiOAabyDDAQarXBSVnbtwHEKhkbstLIz3fqOKMqt4M9uoJipqACSAhFTfPMqbYhcaYibt+mt1izbCxIBN7jsAu9rLfiwIz0Fkcpk41lcTrVdA2AM5I95YVkQ/1snBx2OXmHJcPVaW4Ay6brIJG1eI/GP+J4XQ+I97Eu1DHXXoDq1L44Qd+EI97QdNaZly3ig2QKE8MYlLx5s21w0osy3QzIMRr0za0df2o1vmL1KYc4e/wZzLbS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVswu+t4n623HE5zSRMZyqbJ4IiNUE7oa9WrC/u8MJ0=;
 b=IuMXS9nT6V7fmDOPeNsNWqwfVY5xYE8Lh4Gu15l9sqFBY1qFN9sf0aBHvd4USKhTrNSJZN01bZyXjAbhmm5YY6YcVXdIARdeQ2NIWG8fHOchTByAH8t2HyZ5TZMHgsFSBhBJ9iOTNEG0zXglzUE9q/+ePZxjJN/6gBPUS8x6e0ujSJgY5s6Q+HTFtNehjnP6Nw+3XlBfsiq52sA/bIigZ/+gGLn+J7Tw0G4D9F9QuTP6gGYffEyJjv5S0Mqb3Xn5GQIIzvJlsdzUYM/mbTVzCjpzRnTJTTyH8w5CslId9Mu4IxZSgk871Bdt5XPQe9e+X8CBvNOCe6bftxcXdhgQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 01:58:29 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:58:29 +0000
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>
CC:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Thread-Topic: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Thread-Index: AQHZxUCPIDcUjSfzW0StyuzL/eD3iq/YFtwAgAB+8ACAABc/AIAAtr8A
Date:   Fri, 4 Aug 2023 01:58:28 +0000
Message-ID: <20c96ae6e914cc8a2a0a1608889e5666804ded16.camel@intel.com>
References: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
         <20230803060646.GA87850@ziqianlu-dell>
         <20230803134106.GA130558@ziqianlu-dell>
         <526b8b11-9d7e-0980-f7c8-6ad4222e2f92@huawei.com>
In-Reply-To: <526b8b11-9d7e-0980-f7c8-6ad4222e2f92@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3060:EE_|BL1PR11MB6001:EE_
x-ms-office365-filtering-correlation-id: 18479adb-c69d-4bd8-272a-08db948e4bfb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FRH5E3U++OzYiRUq8Nf0uGeidn1A36lqPxWDBdP84BCnRICHhxAxPQq7WxvwvUk+ozk4x+JJ6BLYC67ULPagSdar7aLXI5bWUcYlQR0TIL7TC6RQrTuvVk86oJh7/+Hfa43VBwPeI0JdPgVzJfXu3t3AmUZHTsdILaYikAil1D8X5GA1JYS2uHAfPWO1bcbQ2HgNRp3m5s5veq8+TpH5RZprv6VkhuqoL/h8JTWcOvxFoCftV3i7Q6PF6a84EWxY9V0h11wanCHs5JWro+Ja9wCumh1UcdLKveMDnr5IUWrXmb8VvD4xcvUJ32Xy2vV86miNMz8cKkY2ylzim7LaZw9LIpG0ITlW1qtoRJILFICb8GQsLpgJr6+IqnkeHEupD4w46CO8S3ktaos3VBKsaAPYWc4RyPMx5OP889fB8WuKpe50AGSk0pI0929nTHfY8s0mLriK5p+c+9/KmRybmC66Nz6I7R9WZAVN63iS6eujBpX97t3xfz96NHyfDIRFL0d5vi+AHCdmhYoluNSbdWy6Fz+0o8SMNZS3yR2cbMco6ISgFlNgLnMWUEI0SLhBL5IfhRMcrppIWEjSaUK6/o2cejQkVH2QRTI5uxUmQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(1800799003)(186006)(2616005)(53546011)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(91956017)(76116006)(4326008)(66946007)(5660300002)(66446008)(64756008)(66556008)(8936002)(41300700001)(966005)(71200400001)(6486002)(6512007)(110136005)(478600001)(54906003)(38100700002)(82960400001)(122000001)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9MSElTVzUxOUNWYnRVNFNXejExMHBtaGQ3b1Y4T3VOcFNYWjl1QThXQVFw?=
 =?utf-8?B?NnB2QmtKeW1WR2hwVDVkMWlHUG5uQVNaMTB2WHVydk5Sbk5SSHNwWFFyVUhW?=
 =?utf-8?B?QkJ6TUpHQW5NclQwb3ZCWUp6TUJSeVlvbUgyaTZ3UWEyRUFtanJQNkNBMlBh?=
 =?utf-8?B?R1NkRStwWk96MWJqMGF0OE1lWERoRXk0UC9EYUYyaElYRkFXQ0thRmlBMnBo?=
 =?utf-8?B?a2w2dWJvNUFLUk51VC9PRDBZaWo1MlFId0hybjNyWmtZY24wWUp0aXdjV2xV?=
 =?utf-8?B?WWtZVnVRWFU5Q1loQzY5NEhOU3B1RVkrTzh5anUwUGZmQjZlU0tkTUtqYWJP?=
 =?utf-8?B?STJROXRnUVNGeFA5SHpZNGpLWUJKRDF3TEVoNjI4bG0rS1RhcndZMG5UeDRl?=
 =?utf-8?B?NGF4WS9ZWmNwQTF5emZoTDRaMFVORWdxSU1JS1VVRHlzOGFKSlJBVXdUQ1or?=
 =?utf-8?B?Nk52SEJsWGY1aTJpZXhpaE1zZGRDZ015cnVNV05HZHRWeVBIbVp6YmxMSHRh?=
 =?utf-8?B?emE1WGxRSzlsRmFaWTAxMG14RzJrZHZCTzY1L1RMdzl2TFNZc09MTUxOc3lB?=
 =?utf-8?B?SEN6VlN4Y1dlQ2cvRDZOTC83QncwUkYwaDA0c3pVc29EMHFaY1NtRUtoQTkw?=
 =?utf-8?B?TkxjRStXeVBVZURvRzlYRGtuelE1aVFlV3FtVmd0YTFwSktRMXhFd0o2NXdN?=
 =?utf-8?B?R0VjQ2RUQUZrWG4rZTJYczJXczc1RUV4NDlzdWYrSFpTaTFRMUxRNlBuU2ZO?=
 =?utf-8?B?TEwwVVBlWUltVnJVWXhxMTZ1cmQ3ajRleVhxZXNvWnkyN0JoTmptdzFsbkNh?=
 =?utf-8?B?c1dBdDVvMEhTd2w5anZka3JEcUxNT3Z2czlLK3Jpc0dJZjExV1RQUWhLVEdW?=
 =?utf-8?B?R2FPdTFCVmNXVmtUT3UxeElqY01HTWJ2U1FQTEd0VDdmMXB0MHJBaSt5bW0x?=
 =?utf-8?B?ZzZuTEN1dnFlWWlCK2dzVjhaMnc5djdzUmdKTEhGci9vUWRiQnNOMUdGNGlq?=
 =?utf-8?B?S0lRaHBzWER2Rm5Td01jV29qTVNSLzdGbis3VFRrQWdHTysxU0pNV1NRK3RZ?=
 =?utf-8?B?Q2M0MDAxMklhT0o3cGFGRkw3QTdrdC9iRm9qbTNwa00yanFwUVIxMWxEWUhW?=
 =?utf-8?B?eFV4blp2VWc5S3lJSVhuS3JaY3JlYzNNL3dQOXVOazRjbXl0TDlzZUhCek1G?=
 =?utf-8?B?U1ZpWVc0YTdySnBzSzl1KzhyT2QwQ0ExeXdaM2tQZXJYR2NwektjcGhZbklE?=
 =?utf-8?B?QWRQYkViMENNK0JXMlFyNVJRMVdvRjNZbUNoNkUycjVIZitRdHRYUzB0TE5o?=
 =?utf-8?B?eklOM1JSUmViM09DNlVMM2FSYklheDBrbzJBeEhUSUhCN3YxTUpna0NGWmFl?=
 =?utf-8?B?TVBVWittZTl4MFltZGthUXhWeGJQQ0Z4UitUN3BCeXdidVZrbUQ5MTFFc1lN?=
 =?utf-8?B?aFlFbW9vWUxtU2ZGWEhUOHg3K2V4cmxMZkhTSURORCswZjdLTG5ITVZ1UW9r?=
 =?utf-8?B?NkY5WHRrdXNocFV2VVUvOEVFRnJRZmthOEZvbWpZK09TMXhtTkx2bW5xZ2lR?=
 =?utf-8?B?T0IwdGc2My9WTlZlQmN5S1p4ZXdHZHRBVHQwMDQrK3J6cVlWVUpDYWxZQ01p?=
 =?utf-8?B?bEsvSEVZWFlUR2hVK3JPNkk4OFdqUWNMM3JQalZEWHhES09XdmtlVVNDK202?=
 =?utf-8?B?UWphME9JcnB6ZG1ZeldkeXI4c2NST0xHc25oSDh0RXptbHZFcjV3M1lpZE5S?=
 =?utf-8?B?YW8rMW03OXEwMUVYR29oczk1SDVVNWhIZks3eGc1WkJPeFNkbTJ1UWpjQWtj?=
 =?utf-8?B?Sy9GTG5TenRyTkVJZXBqRE1Nc0JVZGFKYnJMM3FDUGNiMW9PN1dZQUsxa1V0?=
 =?utf-8?B?L2hvWWFvMlN3MFNDSFVvRWJlRFNFVFdqZ0w5cU1WSWNnOHpNUlNyTVlnWVkx?=
 =?utf-8?B?UW5SOTRub3hGZWZpQ1dZN3dWb0preXgxck0xL3p6NHMvdXl2OGttU1dKalIw?=
 =?utf-8?B?WVBONjYwRVpPbmtvOElpdkMxbkNPWmhTQTZUeUxWVjNEaGk5VFlzY3hiRVdo?=
 =?utf-8?B?NWNyUHBRTk16SnVlV3JsRUVveG9SeXpIZ0lTZkhRY0dwRHBJVFhpdTI5L3pN?=
 =?utf-8?Q?458xgIsS+Altb8nyQZqj4K0bV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D86187CF240194796B60556E2422F3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18479adb-c69d-4bd8-272a-08db948e4bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 01:58:28.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OELNW0jTnWGfBe7BS9puHXxEgrMMnZPLa2O321lXM/mcU++ipwMD/+91YfnEnmmGl0fRKmW6qG+21dziwL8PbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDIzOjA0ICswODAwLCBLZWZlbmcgV2FuZyB3cm90ZToNCj4g
DQo+IE9uIDIwMjMvOC8zIDIxOjQxLCBBYXJvbiBMdSB3cm90ZToNCj4gPiBPbiBUaHUsIEF1ZyAw
MywgMjAyMyBhdCAwMjowNjo0NlBNICswODAwLCBBYXJvbiBMdSB3cm90ZToNCj4gPiA+IE9uIFdl
ZCwgQXVnIDAyLCAyMDIzIGF0IDA3OjU0OjM4UE0gKzA3MDAsIEJhZ2FzIFNhbmpheWEgd3JvdGU6
DQo+ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gSSBub3RpY2UgYSBidWcgcmVwb3J0IG9u
IEJ1Z3ppbGxhIFsxXS4gUXVvdGluZyBmcm9tIGl0Og0KPiA+ID4gPiANCj4gPiA+ID4gPiBIb3cg
dG8gcmVwcm9kdWNlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhhZCAyNCBDUFUgQWxkZXJsYWtl
IDE2R0IgZGViaWFuMTIgc3lzdGVtIHJ1bm5pbmcgd2l0aCBkZWZhdWx0IGtlcm5lbCAoZnJvbSBt
YWtlY29uZGlnKSBvbiA2LjUtcmM0LCBleGVyY2lzZWQgd2l0aCBubyBzd2FwIHRvIHN0YXJ0IHdp
dGguDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gdXNpbmcgc3RyZXNzLW5nIHRpcCBjb21taXQgMGYy
ZWYwMmU5YmM1YWJiMzQxOWM0NGJlMDU2ZDVmYTNjOTdlMDEzNw0KPiA+ID4gPiA+IChzZWUgaHR0
cHM6Ly9naXRodWIuY29tL0NvbGluSWFuS2luZy9zdHJlc3MtbmcgKQ0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IGJ1aWxkIGFuZCBydW4gc3RyZXNzLW5nIGZvciBzYXkgNjAgbWludXRlczoNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiAuL3N0cmVzcy1uZyAtLWNwdS1vbmxpbmUgNTAgLS1icmsgNTAgLS1z
d2FwIDUwIC0tdm1zdGF0IDEgLXQgNjBtDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2lsbCBoYW5n
IGluIG1tL3N3YXBmaWxlLmM6NzE4IGFkZF90b19hdmFpbF9saXN0KzB4OTMvMHhhMA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFNlZSBhdHRhY2hlZCBmaWxlIGZvciBhbiBpbWFnZSBvZiB0aGUgY29u
c29sZSBvbiB0aGUgaGFuZyAoSSdtIHRyeWluZyB0byBnZXQgdGhlIGZ1bGwgc3RhY2sgZHVtcCku
DQo+ID4gPiA+IA0KPiA+ID4gPiBTZWUgQnVnemlsbGEgZm9yIHRoZSBmdWxsIHRocmVhZCBhbmQg
YXR0YWNoZWQgY29uc29sZSBpbWFnZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZXSVcsIEkgaGF2ZSB0
byBmb3J3YXJkIHRoaXMgYnVnIHJlcG9ydCB0byB0aGUgbWFpbGluZyBsaXN0cyBiZWNhdXNlDQo+
ID4gPiA+IFRob3JzdGVuIG5vdGVkIHRoYXQgbWFueSBkZXZlbG9wZXJzIGRvbid0IHRha2UgYSBs
b29rIG9uIEJ1Z3ppbGxhDQo+ID4gPiA+IChzZWUgdGhlIEJaIHRocmVhZCkuDQo+ID4gPiANCj4g
PiA+IFRoYW5rcy4NCj4gPiA+IA0KPiA+ID4gSSBjYW4gcmVwcm9kdWNlIHRoaXMgaXNzdWUgdXNp
bmcgYmVsb3cgY21kbGluZToNCj4gPiA+ICQgc3VkbyAuL3N0cmVzcy1uZyAtLWJyayA1MCAtLXN3
YXAgNSAtLXZtc3RhdCAxIC10IDYwbQ0KPiA+ID4gDQo+ID4gPiBJJ2xsIGludmVzdGlnYXRlIHdo
YXQgaXMgaGFwcGVuaW5nLg0KPiA+IA0KPiA+IEhpIENvbGluLA0KPiA+IA0KPiA+IENhbiB5b3Ug
dHJ5IHRoZSBiZWxvdyBkaWZmIG9uIHRvcCBvZiB2Ni41LXJjND8gSXQgd29ya3MgZm9yIG1lIGhl
cmUNCj4gPiBhbHRob3VnaCBJIGdvdCB0aGUgd2FybiBpbiBhIGRpZmZlcmVudCBwbGFjZSBpbiBn
ZXRfc3dhcF9wYWdlcygpOg0KPiA+IA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBXQVJO
KCFzaS0+aGlnaGVzdF9iaXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInN3
YXBfaW5mbyAlZCBpbiBsaXN0IGJ1dCAhaGlnaGVzdF9iaXRcbiIsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2ktPnR5cGUpOw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHdhcm4g
eW91IGdvdCBpbiBhZGRfdG9fYXZhaWxfbGlzdCgpIGR1ZSB0byB0aGUgc3dhcCBkZXZpY2UNCj4g
PiBpcyBhbHJlYWR5IGluIHRoZSBsaXN0IGlzIHNpbWlsYXIsIHNlZSBiZWxvdyBleHBsYW5hdGlv
bi4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMN
Cj4gPiBpbmRleCA4ZTZkZGU2OGIzODkuLmNiN2U5M2VjMTkzMyAxMDA2NDQNCj4gPiAtLS0gYS9t
bS9zd2FwZmlsZS5jDQo+ID4gKysrIGIvbW0vc3dhcGZpbGUuYw0KPiA+IEBAIC0yMzMwLDcgKzIz
MzAsOCBAQCBzdGF0aWMgdm9pZCBfZW5hYmxlX3N3YXBfaW5mbyhzdHJ1Y3Qgc3dhcF9pbmZvX3N0
cnVjdCAqcCkNCj4gPiAgIAkgKiBzd2FwX2luZm9fc3RydWN0Lg0KPiA+ICAgCSAqLw0KPiA+ICAg
CXBsaXN0X2FkZCgmcC0+bGlzdCwgJnN3YXBfYWN0aXZlX2hlYWQpOw0KPiA+IC0JYWRkX3RvX2F2
YWlsX2xpc3QocCk7DQo+ID4gKwlpZiAocC0+aGlnaGVzdF9iaXQpDQo+ID4gKwkJYWRkX3RvX2F2
YWlsX2xpc3QocCk7DQo+ID4gICB9DQo+IA0KPiBUaGVyZSBpcyBhIHBhdGNoIGluIG5leHQsDQo+
IA0KPiBjb21taXQgYmRmYzcwMjg2ODFkZGJjZTVhYjA4ZjQ4ODhkMTU3YTk4MTA2MDU0NA0KPiBB
dXRob3I6IE1hIFd1cGVuZyA8bWF3dXBlbmcxQGh1YXdlaS5jb20+DQo+IERhdGU6ICAgVHVlIEp1
biAyNyAyMDowODozMyAyMDIzICswODAwDQo+IA0KPiAgICAgIHN3YXA6IHN0b3AgYWRkIHRvIGF2
YWlsIGxpc3QgaWYgc3dhcCBpcyBmdWxsDQo+IA0KDQpBaCwgc2hvdWxkIGhhdmUgdHJpZWQgbW0t
dW5zdGFibGUgZmlyc3QuDQoNCkkgdG9vayBhIGxvb2sgYXQgdGhhdCBjb21taXQgYW5kIGl0J3Mg
ZXhhY3QgdGhlIHNhbWUgaXNzdWUgYW5kIHNhbWUgZml4DQpzbyB3aXRoIHRoYXQgZml4LCB3ZSBh
cmUgZ29vZCBub3cuDQoNCj4gDQo+IA0KPiA+ICAgDQo+ID4gICBzdGF0aWMgdm9pZCBlbmFibGVf
c3dhcF9pbmZvKHN0cnVjdCBzd2FwX2luZm9fc3RydWN0ICpwLCBpbnQgcHJpbywNCj4gPiANCj4g
PiBUaGUgZmluZGluZyBpcywgaWYgYSBzd2FwIGRldmljZSBmYWlsZWQgdG8gYmUgc3dhcG9mZiwg
dGhlbiBpdCB3aWxsIGJlDQo+ID4gcmVpbnNlcnRfc3dhcF9pbmZvKCkgLT4gX2VuYWJsZV9zd2Fw
X2luZm8oKSAtPiBhZGRfdG9fYXZhaWxfbGlzdCgpLiBUaGUNCj4gPiBwcm9ibGVtIGlzLCB0aGlz
IHN3YXAgZGV2aWNlIG1heSBydW4gb3V0IG9mIHNwYWNlIHdpdGggaXRzIGhpZ2hlc3RfYml0DQo+
ID4gYmVpbmcgMCBhbmQgc2hvdWxkbid0IGJlIGFkZGVkIHRvIGF2YWlsIGxpc3QuIEluIHlvdXIg
Y2FzZSwgb25jZSBpdHMNCj4gPiBoaWdoZXN0X2JpdCBiZWNvbWVzIG5vbi16ZXJvLCBpdCB3aWxs
IGdvIHRocm91Z2ggYWRkX3RvX2F2YWlsX2xpc3QoKQ0KPiA+IGFuZCBzaW5jZSBpdCdzIGFscmVh
ZHkgaW4gdGhlIGxpc3QsIHRodXMgdGhlIHdhcm4uDQo+ID4gDQo+ID4gSWYgaXQgd29ya3MgZm9y
IHlvdSwgSSdsbCBwcmVwYXJlIGEgcGF0Y2guIFRoYW5rcy4NCj4gPiANCg0K
