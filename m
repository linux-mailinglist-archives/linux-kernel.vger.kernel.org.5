Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF9770C84
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHDXxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHDXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:53:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DCB468C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691193182; x=1722729182;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=c91+sS3C1o9BQFD63dhHP5i5dNvMOUnCJNmT8jbJ6B8=;
  b=OeqGoCWSwQifqbxqFCcXDYTKBTQAUWEh7rcZCwA6p58JXe5701UPb2rA
   yCq7hkcQGq+8X02bkmDKZ0WDN2i9EZAWAr0qavwDMT1MASEJ52m1qYun/
   0jNYOycYhWzu+g7m7I/wX7Ku3PTyd7/D+XYbifLVtmOw/XubcikBVAl8d
   5b+umuoWvQYg2EzTTk7ThcvbgBIpYKQ46hMVWi4fAn4J+X5CVwuBoWtD3
   4QAinz6aIHbz87SkDOKg4XBy8hG1euKno6QVJzEyCPXTw3i5JIJnRLP7i
   B6k+pijS9EOvoPRmoGNxUFU/wVHNvv87VcxXda8gtXlZZ2VA7Qwmmutbu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360335103"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="360335103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 16:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="680149314"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="680149314"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2023 16:53:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 16:53:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 16:53:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 16:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpyY11KaXGKY7LS/jw/8Gf0CpPoCQuRgSbV21XTkEeMM0CIEDDiWuuw25DtLxVEbtoxeYxnIi7JVCFzzXrhPFPtm/ZGDC3oOLiGJJMipI0BebGYYadds9FQTEoj/Ch7adwvvsQaCR3qCEGqkrxrOL3H8lu6/fxTMGJJT5xBqBVvFd6lwhUFlgGMNHTJKrkeRa2qIcggNohd/INHA0FRi7Dtn/kHUysGHvzvSV9W6CaeoEfB71ig2mUBnHPIJSmIcNUBTn5xhmvmnp+Kq5hAElWQFc2uSA7GeLol3G473xLs0o7bPfih+5I9tTLf8wCaKl8SzuqTyWewn3Lmi8G2twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c91+sS3C1o9BQFD63dhHP5i5dNvMOUnCJNmT8jbJ6B8=;
 b=YPUmvB52L+XAUqsTaZLj38XI5ZxG1dl8RlgsrtGYJLNZltW5MlvOQop+DYXJQg4RtRetZR56969p+RrsfrpQI0maJMb5LqCgXtMjpdb5+CWMEZJRtcaQV5ApX3lF8QrEUIsZN63iag4qEM3B7kRrNb5tVtZ0WRSiz2fhjQdufrJJpauW0nxM46h+ky5VkR4e8OjP4yuyAGM4RvJEcDklvun4SG/iMuHGRNA5MhYMQf2qekSt2xjsfM6F5SKZtjm4f49nVeXbFIoikRJw2KgJy5PyrBC+r9mwutKatEqYGUg6vmATlMNpFZZa6kiFfDofKUbbj0GgNtoF2yDXvEJ1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 23:52:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 23:52:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v3 00/12] Enable Linear Address Space Separation support
Thread-Topic: [PATCH v3 00/12] Enable Linear Address Space Separation support
Thread-Index: AQHZw/+CpLA4Kkbz00+t3asZ4sM386/a1ZaA
Date:   Fri, 4 Aug 2023 23:52:58 +0000
Message-ID: <4f6fb42fe5099f650c5595d05a54e9b421456d80.camel@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
         <d6b79dd5d85a30baf2eb138036910890fb060e52.camel@intel.com>
In-Reply-To: <d6b79dd5d85a30baf2eb138036910890fb060e52.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 256bfee0-c548-475b-9f74-08db9545ee5b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9ajT0wjwI7FBp66HAZmUPPMLk7vt2iOdxw4Pn/wyQdoSXxizvgLF4siFhF/JT2IY/80Vp5XKJn+rHia1v0r+1Ct9Sw1CTxmj3+Rx/mNmr3IE9Ka0MhvDB2Lj/z8VfjAWj3Iu1Ptz+jc/i9j1k51kp1ao6MzloxWE4//LrkWznI3mD/Kf/CCXW4xX/QbVQE3fJSThEcQuYKGQ5DNIDW8XKUDnYj32nCz7ozI8D7gnYYp+wHuT3zjAHmEcecRfAgzwUvfoEO4JgYPwFi44bED4ztHkiMRDr9ZGN+RdjqO8W4Qmo+Uw8AGcSjTx20UMKADevlQIFbYrpJ/HFPh0+1y6iFim5PuPIlytH4OrNHTK/qckGolVgML/sA9JEFgCQJfPAg01aXkyAJs5fl6v8dEWZ76QIR3C1PdEq+qB5GAUckKlBT73YSJ9v0jlrEcRkTQ3cK8Cy//bd+Dfr03wJCWvnNsuLrlMHn5KY0HejaWLunFkSiJa5SzLsYdOQiSKXQeSUBhVlLHbLIJnAfITD9gcQOFXgc2vkYyctgDk4LgYJeM7J7mIur6sj+xH4+S4Ph8IW0GFM2hyCUbnqj24wfUD+On7jVw93Cadj8h8K8uTJoOcm39pnAtWRsqt9mtupzrfM6xJ4yZUsAnsCqaAeO7wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(376002)(136003)(186006)(1800799003)(451199021)(91956017)(71200400001)(6512007)(6486002)(66946007)(64756008)(66476007)(66446008)(82960400001)(76116006)(38100700002)(66556008)(5660300002)(41300700001)(316002)(38070700005)(478600001)(110136005)(83380400001)(6506007)(921005)(2616005)(122000001)(26005)(36756003)(8936002)(2906002)(86362001)(8676002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2tOb0VVSVdQdGZKUHV4ZURNRmdIdi9YN2tmd0R4UG0yT2VyQlk0R25jOXNR?=
 =?utf-8?B?VHNIeWk3VHc1N0pYby9HOEJTTlRHSDg5OVRaVzhwUi9FSFdMZnJ1WU5vUmZt?=
 =?utf-8?B?SFNTbjFwdFJ3QlRoaTFLZTQ3S1lmU25lQTZRdFYvdEtEcFUva3MrM2xZVzBD?=
 =?utf-8?B?WnZDUjFGTkxXbXUwQzNHNGZtQURHeVZibS9XeHdOdktwZGExbWxjejlSeXIr?=
 =?utf-8?B?UGFuemxVT3VlVXhVcWhUTFphRXgxZmwxSXM0N2hTNi9qN2dFNVg4eFJSK1Vj?=
 =?utf-8?B?d1NnSGhuOSt1SGdmYTcrUkxTb2FLU0tOcUJ1b1d6Wkl4cTkxdmllQW5qeXNu?=
 =?utf-8?B?UTVjeW1wL0N1L1o5R09KTFpzUzE1SG9jazJ3QVo2a1FpdVFEMDd4RElaZ2NG?=
 =?utf-8?B?OEFrbm02S1pua3Z2QWdJbGpmZXkrcktHdFovcjVORmRhWHZZTmtLNlFBbjk5?=
 =?utf-8?B?QU1lc0xuNkdZZmpxMFhLMEVFNDBXaXY0SU04OGR3SUNSeUZoM053UDNQL3BR?=
 =?utf-8?B?MWdFRWM2aXN1TmR0cFBOVms1L24wQ1hTRlBSWmxjNWxCc3RKZU9hNG9YZ1pz?=
 =?utf-8?B?RnhhdXpMYnFSREg1bVdMK25LY0Q2cmwvYkNhOVR4WE8yY1lob01PL3k1dEEv?=
 =?utf-8?B?eWNpaEs1OE4ralk3MlhrbHZuMmZmY2ozaERGMzhvV0VWczZGWXNzN1VKVWRJ?=
 =?utf-8?B?OXpYcFJUWGQyVWhtWVpmRE1nc1NsMEpPU2RPWHN4Y2JBaVhzSXFja1FRMFBq?=
 =?utf-8?B?YnlFbTdvZ0RZdFdpOUgrUHZPZkhUeElCZVpCVnRxRjEwTkF3VkM3YTZrcTNi?=
 =?utf-8?B?cnZNN3YzanJja09QSG4yVk5jRUpxem1HTTJBWHIydkhiWmMyeXJxekdsRE96?=
 =?utf-8?B?ZHFZaVR1TzdpbGFpRU1hWG1YUTE1Uy9DQ0ZJR2ZaR3c4RlhVM28yZDNBQUJi?=
 =?utf-8?B?MExmRHlHN0ZLd1UyeGxsQ2YxS3Q1aEx2VnJ4TkdLSkl3KytWRzN5aE5LVjhw?=
 =?utf-8?B?b0VjZ3FDTXJnSkhWL1VmU21XakhENnZ0V3dicXlXWEFUYzlBOTc3L0IwUFZW?=
 =?utf-8?B?YnhzS0ROTFRrQlBqcGxqQTAxY09oUnpoWlN0UTFBSGdmZjNybG1wMjlOYTZU?=
 =?utf-8?B?RnpJanJTY3lsSThDVGdseWVaOU9GMG15T2RNWTBzZnI1SUpvZm55K0pUVVJz?=
 =?utf-8?B?TmV2R1ZTTFNhYnQ0andHeFhld2JOWk9KRUdmWmRJMVR4aWdQTDVERW1RbUJU?=
 =?utf-8?B?Q1JGeDhCN1pPOVc5ZVhoay9BaElxdklNQUNWdGFRNFdPUTlScDBwKzJSa3BG?=
 =?utf-8?B?b0hnbWZnUzBYSTlXMTAxbzNodm56dlh4WEQyZEtUQ3FOR2tPeEsyc3pZZFAz?=
 =?utf-8?B?SWVJN3plOGVWemtZSk9XZVZ2TnZyQ05nazNjSS8wQ1hRaU5yME1McUpldWdB?=
 =?utf-8?B?UGt2Q1huWjdKbFdWeGZGczF4N0VGNU9ISEhEUUt5K3AvT1J4a0ZXblcycmM1?=
 =?utf-8?B?QURDbEgvVmZWaHArN3BpdFdIRno5YzBuakpBYStWT2RtSFBXTUFvd0w3MThH?=
 =?utf-8?B?ZG5sWXZDd3dka1NmTUUzR0g5eFJHU2NucUhoUjkzVEloUnl5bDNjWklEUWpK?=
 =?utf-8?B?cEphRHVYRnA0KytNSmswSHM5dmR3SlNPTTZyalVCWGdDYmZqekcxTnMvN1Zq?=
 =?utf-8?B?RDZRbi85d0xmOVAxTEtvbmlhb1VMRGFKVEp3c09zVCtQcHRKQ0lsekZhVDFJ?=
 =?utf-8?B?SlQzMDVXdU1KMGo4TmE4ZDFLRzBpbnNsRGFHUkhXRHcrS0ZQdWdKVGNYdEN3?=
 =?utf-8?B?ZTN2bXdFY3VzRkhLYVdIK3ZPdGZiSkJ0NUVXN280dXhYWnMzc2UzL0hFd2xq?=
 =?utf-8?B?b3lhSXVyajRoU09oUUgxSFk3NnJROVVIa2NpUjJ2cWw3bWlEZlJIUnJxb1Vv?=
 =?utf-8?B?cUJTMGJiVkNGZVgrUUVlOUlBV2dqMUdPanljeUN0dk9VR0FadHNNV25NVXlS?=
 =?utf-8?B?a3dXVnNXWnlRenM0NVB6Wk5zTkdBQlVOMFZyRW03Ky9hYTZLTmpTK3o4YWNy?=
 =?utf-8?B?RHdrTXFNbGU5dEZwUTlYR2lLbit2K25HZlN3TlBXdGJ1aDJseVdkZkkyYlJZ?=
 =?utf-8?B?ZFFZcVd6Y25CZEtraFpLdnpvR2pBR1I4dXFKbThOWmYvMGVBd1oxencwOVVh?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3457AE6ECB347049AC861B367682CE92@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256bfee0-c548-475b-9f74-08db9545ee5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 23:52:58.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJFeQPJdwLLCoBSQ5p0cLjYXSKrN9fGTbAVdc4KkMx0GxbKz+mnFTl284vmvMIJCfsIxYMa+0jospI7jD9475e6APe0kbMzQod9g+LZgao0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDE1OjM2IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDIzLTA2LTA5IGF0IDIxOjM2ICswMzAwLCBBbGV4YW5kZXIgU2hpc2hraW4g
d3JvdGU6DQo+IA0KPiANCj4gV2hhdCBkbyBOVUxMIHBvaW50ZXIgZGUtcmVmZXJlbmNlcyBsb29r
IGxpa2Ugd2l0aCBMQVNTIGVuYWJsZWQ/IFRoZXkNCj4gd2lsbCBiZSBhICNHUCBpbnN0ZWFkIG9m
IGEgI1BGLCByaWdodD8gQ3VycmVudGx5IHRoZSBrZXJuZWwgcHJpbnRzDQo+IG91dA0KPiBzZXZl
cmFsIHR5cGVzIG9mIGhlbHBmdWwgbWVzc2FnZXM6DQo+IMKgLSAiQlVHOiBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAlbHgiDQo+IMKgLcKgIkJVRzogdW5hYmxlIHRv
IGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiAlcHgNCj4gwqAtICJ1bmFibGUgdG8gZXhl
Y3V0ZSB1c2Vyc3BhY2UgY29kZSAoU01FUD8pICh1aWQ6ICVkKSINCj4gwqAtIGV0Yw0KPiANCj4g
VGhlc2Ugd2lsbCBnbyBhd2F5IEkgZ3Vlc3MsIGFuZCB5b3Ugd2lsbCBnZXQgYSBtb3JlIG9wYXF1
ZSAiZ2VuZXJhbA0KPiBwcm90ZWN0aW9uIGZhdWx0IiBtZXNzYWdlPw0KPiANCj4gQXNzdW1pbmcg
dGhhdCBpcyBhbGwgcmlnaHQsIEkgZG9uJ3Qga25vdyBpZiBpdCBtaWdodCBiZSB3b3J0aA0KPiB0
d2Vha2luZw0KPiB0aGF0ICNHUCBtZXNzYWdlLCBzbyBwZW9wbGUgYXJlbid0IGNvbmZ1c2VkIHdo
ZW4gZGVidWdnaW5nLiBTb21ldGhpbmcNCj4gdGhhdCBleHBsYWlucyB0byB0dXJuIG9mZiBMQVNT
IHRvIGdldCBtb3JlIGRlYnVnZ2luZyBpbmZvLg0KDQpNYXliZSBnZXRfa2VybmVsX2dwX2FkZHJl
c3MoKSBjb3VsZCBiZSBlbmhhbmNlZCB0byBnaXZlIGhpbnRzIGZvciBzb21lDQpvZiB0aG9zZSBj
YXNlcyBsaWtlIGl0IGRvZXMgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzc2VzPw0KDQoNClNlcGFy
YXRlbHksIEkgdGhpbmsgdGhlcmUgaXMgYSB0aW55IHVzZXJzcGFjZSB2aXNpYmxlIGNoYW5nZSB3
aXRoIHRoaXMuDQpJZiB1c2Vyc3BhY2UgdHJpZXMgdG8gYWNjZXNzIHRoZSBrZXJuZWwgaGFsZiBv
ZiB0aGUgY2Fubm9uaWNhbCBhZGRyZXNzDQpzcGFjZSB0aGV5IHdpbGwgZ2V0IGEgc2VnZmF1bHQu
IEl0IHNlZW1zIHByZXZpb3VzbHkgdGhlIHNpZ25hbCB3b3VsZA0KaGF2ZSBSRUdfVFJBUE5PIGFz
IDE0IChYODZfVFJBUF9QRikgaW4gdGhpcyBjYXNlLCBidXQgd2l0aCBMQVNTIGl0IHdpbGwNCmJl
IDEzIChYODZfVFJBUF9HUCkuDQoNCkkgZGlkIGEgcXVpY2sgc2VhcmNoIGFuZCBjb3VsZG4ndCBm
aW5kIGFueSBhcHBsaWNhdGlvbnMgdGhhdCBzZWVtZWQgdG8NCmJlIHJlbHlpbmcgb24gdGhpcyBi
ZWhhdmlvciAobm90IHN1cnByaXNpbmcpLiBTb21lIGFyZSBsb29raW5nIGZvcg0KUkVHX1RSQVBO
TyBhcyAxNCwgYnV0IG5vbmUgYXBwZWFyZWQgdG8gYmUgcmVseWluZyBvbiBhY2Nlc3NlcyB0byBr
ZXJuZWwNCm1lbW9yeSBzbyBJIGd1ZXNzIHRoaXMgc2hvdWxkIGJlIG9rLiBTdGlsbCwgaXQgaXMg
cHJvYmFibHkgYXBwcm9wcmlhdGUNCnRvIGNhbGwgb3V0IHRoZSBjaGFuZ2UgYW5kIENDIGxpbnV4
LWFwaS4NCg0KSXQgbWFrZXMgbWUgd29uZGVyIGlmIGl0IHNob3VsZCBtYXRjaCBmb3IgTEFTUyBh
bmQgbm90IExBU1MgZ29pbmcNCmZvcndhcmQgdGhvdWdoLiBMaWtlIG1heWJlIGFsd2F5cyBkbyBY
ODZfVFJBUF9HUCBmb3IgdXNlci0+a2VybmVsDQphY2Nlc3NlcyBpbnN0ZWFkIG9mIGhhdmluZyBp
dCB2YXJ5IGJ5IHdoZXRoZXIgTEFTUyBpcyB1c2VkPyBTaW5jZSB0aGVyZQ0KaXNuJ3QgZW5vdWdo
IGluZm9ybWF0aW9uIHRvIGRvIFJFR19UUkFQTk8gWDg2X1RSQVBfUEYgd2hlbiBMQVNTIGlzDQp1
c2VkLg0K
