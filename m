Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7F2807798
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378712AbjLFScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378806AbjLFScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:32:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFFD18D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701887543; x=1733423543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PHrreIl0E+hBHtkIGrQoQ5kcFXnTnY97YuamR1PmptM=;
  b=O0+R+5OrzWpov3kl9Gt0lEf+Q1smuRsPUewEQg3Pp1mrv4lWLwqIF0XG
   pLuprQl+B/yZpgtC/jdsWGe36Ea0ib2SiSMdyx7MswBEvysq8l2OpuK2X
   2XUPzhg4MN4agsmvePtdhyrc6dixzPRuSlUojeKl/gpkoy1lUFkSKnmgC
   m9AO1u2x/woPfq/94FRO89yCrT2OtycmLnBMwDpP11DQhcD1rOhjA9v2p
   iIJd8UCDg5VJKmyhDsLL+PG6LkVMggS1LPFAzVdzotPHZXfBvkUnaLedm
   lCSgJ7RpvdFECTeKGHWq6+CRQhHpxDeDsu9Z+Ij/rV7zE74wTr4LvJYYb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391274864"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391274864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19407263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 10:32:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:32:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:32:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 10:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3ZJPO8IiI0rZPv0an/6Soj8EJKAqj6xEcfPNRNBU4yshBlssEjP2SbiZ2j22CvRdnwFagVaIpn/4gLXpPpp45p+sR0xI3qlP7S8BzLRITCVLyVlSRnlbqRtEpRonWp0WjBxHQPe00yapZNYstbnPYh/wrINw7dNhBlRvlmtymMP+TClcmCrlaZNZoh+NyTedmqvsa2K6elc4YuQbIVRD6xAnnhOyBlZ5nLvucXBYeMveHXwSIUSu93bxZOwNer3i9EY2LpHV9pECMiN+RibZ333HsB4Z7n14k4Moz1/gC6t+Wivi4AOjcupZ9+Sv+TjArw2H6emx0N3nqQiDeDNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHrreIl0E+hBHtkIGrQoQ5kcFXnTnY97YuamR1PmptM=;
 b=EheJ6HzridjQWkbzgAFOTscc+EI3ZRUpZeNjl97ZqcEcpMicPrK10P4vUBgcEwelQqtFrPH6bWNWqv8hL5l+6xtNQyErHGntApD6KnUfUvEgV7iiyhiFn4h1IABwujBWaOezPvguPgyt6w/Y3tBY/zdI/w/AouV7SAvGhlneTlsYDT0S2VzWibyc40Z7Hpo0FpbVTlr7swDJtLP1MD/EcySnscFae4M3xithvvMJIQC3N5EfCPFTFYuhQeQhW/3RLg29YXsCQK6B3qFLZGQ7w7mIcW6tqO0hQlTTcUFgBFUyhVTxnsxaX7CSohnEsg14viwuPN2Z/k0q0tiEKrGXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 18:32:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:32:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Huang, Kai" <kai.huang@intel.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv4 10/14] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv4 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaJxRg6aYbhJu/jEihwtrgSIlA/bCbeMWAgADk/oCAADkgAA==
Date:   Wed, 6 Dec 2023 18:32:11 +0000
Message-ID: <33d90a6374cd0bab358725a0ba1b52fbe99f5170.camel@intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
         <20231205004510.27164-11-kirill.shutemov@linux.intel.com>
         <3cf8b953c449320cc4c085924ef0e2eed5eadcf7.camel@intel.com>
         <20231206150743.ylgdh2b3qjnacws3@box.shutemov.name>
In-Reply-To: <20231206150743.ylgdh2b3qjnacws3@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5071:EE_
x-ms-office365-filtering-correlation-id: 7ba909b9-2185-4f83-ce7e-08dbf689a937
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEtb20sRj9jAtIGFZ5/ONngu4Kk5NIzjHgrub2nNKV0+IuYe9skWmyGKhe8Ze/hjfe/iM2IINWawR6ABZmPXGLxJ6/l/jSb57IrM8tDpzVMNyM3hySD3gsD1545MxSIeRX+U7/tXYAG/HVi7Vc1C3WskxIcAGn3MN+0RslFGZoNBkxB6OzyPH6uwJsrnL9UsLurEB5wvQZte7oaf4OvwtA0fv+dgAwAoKe4dAjWdUOR+a1v+ppM9g3BmLy1RwYmIeBvRiiR1J6gUNlkxEtfUIKPElQRjI8EnQy745qr80OBib6Gb9XN3VeB89ghDWyZ+iCZ/9s7dD6K8HomnkBKkesZ3lei1vqo8A8rYJmYT0OZxSdhJgnz7v1QUDiblNTw/7uvingzOSGYLcoAcJYc9JLcFKeUsvLoeM5BCq3N/Ts3J7XV7IdPUFgXMPo6l9dfIrgIhmg0K9wM9+34t+05VdMwHPKjyReHGuMqXCSUZxdraHfXIi/ktUKA0WjdSWG/e13b0auZl9yAyORgMKB7dSiAKtZL3qxPw8N3LoNsehc9xg4rD8L5OUYkkLAfIxy2SdjF0sGh7AMgxBkoX00BBL2j6Ywbh1ugxd2KWIdpYYgsMwlOnDajxCkAi1hPWXoT5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(478600001)(82960400001)(71200400001)(6506007)(2616005)(38070700009)(41300700001)(6512007)(36756003)(26005)(83380400001)(76116006)(38100700002)(4326008)(122000001)(66946007)(66556008)(7416002)(2906002)(316002)(5660300002)(54906003)(64756008)(8936002)(6916009)(66446008)(66476007)(8676002)(91956017)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eitlS0JZWXFpR0JSRjBHd3A4NzlNK2JuZlREdU5OZVlYWklRb2FZQjZFNUp3?=
 =?utf-8?B?UHAwL3JmcGdRWU02dWJxbWk0YWEySTI1WUR4MjdTL2FabmJLRzR4ZFJ1VTl6?=
 =?utf-8?B?VE0yRXlBZndKRjRVa2ZobFRjRnJXRE9XV2FlWngzU0VwZno0NVVxMVJISGl0?=
 =?utf-8?B?TWE1RitCYXZ2U2h6MXVtOWdrV2xERVpGeVpNbmJoL29MTnJVRlFwM2JtaGRV?=
 =?utf-8?B?NXZxV1ZseGV1djJHbU1lQUJaU2ZQTWpsSkhnelpDTjdyZklEa24wU2JCeEIr?=
 =?utf-8?B?aGVOK0NIVUJ3VGxsTVhEUTV1MHBQd3MxK1hCUmVFdkZEMGszc2dwU2MxN0VZ?=
 =?utf-8?B?emRLWmF6K2s4TEl0YzJOR2g1MXFyUk52cytXbURUZUtNTlZKVTgxUUlVdVdI?=
 =?utf-8?B?cFd0c2d4NmJ0S3hhMEV0cERucjdFS28zUzdpczcyUTZXN1V4a1FwNXJQUjdI?=
 =?utf-8?B?TUhoWGRGQjJ5RElLR3JPUElrQklKRm9waG04UDY1TE9TWHc0cDZYNUd6ajJl?=
 =?utf-8?B?WmN5MXkvclJabDI2WFYwRDJKUlo5Sm00MS9iTGNlQ1c1RmVPeEJ2S0hqWEFT?=
 =?utf-8?B?cloycllUYXBnOXFLd2RGTEZIZEMxY2JBdkxnd1l6dmc0SFNBc2RVYitJaEl2?=
 =?utf-8?B?cEFOR256d29CVm5ETVJXc0JmNlZLeDhoUjRJRlBOMFNvWUpkcXJuUDI2V0hD?=
 =?utf-8?B?N3dxSTlDV1NFcE5EZ3R1NzA4S0FmTVF0V1NUV0ZHckt2WXVJb3V2YTZ2YjlG?=
 =?utf-8?B?UGtBYkV2M0pQdWFRU3NmQktIOUh6RFR6VlRuM29SNU02Z3Q0d2NZb01YSWNj?=
 =?utf-8?B?Zld0c3lBbk84UklQZkl0Sk1GK1hjNitIWjdENytTb1FqQUoxd1prRTZBdTRz?=
 =?utf-8?B?amNzckhvUFdWbmdPdmFBVTkyQThVZVNXc0lqNUR1S2NIaG5STDRlV3VvNGNQ?=
 =?utf-8?B?UWorSnNNUnZSOGRBeVlkb3VJbE5tZS80TjRhTFIyV2h1NFNERHdkdmtDSkl5?=
 =?utf-8?B?QXBFSWhFQzIyRVNUR05kQ3pWQnV6SWljSUJMR2pXeWZpMXpSeEF6SDlVN05O?=
 =?utf-8?B?ZW5oOEFzUGVoTTFqYUQzeWs3eFE5ZmFoMzdLZWxmYkdjbGMzSHpEdVQyYW0v?=
 =?utf-8?B?Z1F2d3FVaUgrTllYYStCZHBJSmdRdm5VSy8yUnNNc2FTakZjc1pya3pydVhU?=
 =?utf-8?B?d01GdlNIVGgxdDI0bm1HUzM1WEZpOUMxMEFCb1d3Ymp2WUwvVXB2QktZQlJh?=
 =?utf-8?B?R2s4dFNSa3pFbithY0lRZEt5dmRqRGF6UW1BVmpvY1k1SnA4RjRVYW1wZHp4?=
 =?utf-8?B?UVU0N1Jlb0poa25LR1ROb3ZHMG9QYm9wREpNV29HM3FLbEF2RWFpM09IVkpL?=
 =?utf-8?B?ZzRGQVhuVHZBdDhHZnpZY2tIRFpvdnpLbTNSR1duK09mZ3pHdWo1dnQwc0Rs?=
 =?utf-8?B?VWdDMkhzUjJVT2ZSTExaODdmZ1ZBY1VsRHBQbmkvQXhvMlY0Nm5jOTFpZlIr?=
 =?utf-8?B?MWs4Rll0UUVnL1lSYU1jYldBTjIyL1hhZkdtVDV2MSthS2RXZXhzL0g0QjAv?=
 =?utf-8?B?elE1KzMyZzVkNWtqT1pWbVAvdnNLTzJnVW16dlJEZm5CUElWdkNqOWkweDFs?=
 =?utf-8?B?T1B1L1VGakx5ME5FSmtpSzJGV1pRbXhtclM5TzJFTGtQRkNTdzRsdkpFYVhM?=
 =?utf-8?B?K3h4RWpST3RQYzZYS3RPM1REVHQ1UERjRE85bExTMjFlL3RveU1xYTNBVE5F?=
 =?utf-8?B?UHNsRlJ2S3NJZHdwL1BRSkNLL0k2WlJWNU4vVWNpeHVWbHlJMDJlM0tZeVlP?=
 =?utf-8?B?Y1RTRU14T2JYbGlINUlRcHpsYXVzaGF6c3QvUW14dTVFekpwZ3N6RW14SGdN?=
 =?utf-8?B?YmpmcUhMUkhvR084am9kcDNPSkU3SGlKeU1SSGkwV1JvVnVlaTBBT01QaVRB?=
 =?utf-8?B?cTErSUdvSmVQUS9taElGYzZXSVJLRitpcUphd1RYS2NHVGlZNkpiNkR5dWxW?=
 =?utf-8?B?QVdqdVJ2TnMyTkZ5UzRZU1BtWXErL2g3QTI2OXhuUjhRUG02bWh6ZUxJR1BK?=
 =?utf-8?B?Q1B4QzV6emJtMFcrR3JUblp5Zm41OHhqNFZUL3pWNGVVRUtwYUduVUdNNXBC?=
 =?utf-8?B?NlB0NkorWlExTFcrV0YzYUdFSFFIVzNlRVFtakRGVkVwOUZDZW8wcmdnY0J6?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A027DA36780E7242B6D5F7BD6851A7EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba909b9-2185-4f83-ce7e-08dbf689a937
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 18:32:11.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vm4NSg6Ftlnc+LxvaqfIuoM2dvtSgjdBk5m2TD8mgqQY621oRIn9rMytQnda/65ZLHXE13fc+iOr03lh+EYpNBBAcglpfAvNjqxg1gffi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
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

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDE4OjA3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tDQp3cm90ZToNCj4gwqBJIGNhbid0IHRoaW5rIG9mIGFueSBub24tcmlkaWN1bG91
cyB3YXkgdG8gaGFuZGxlIHRoaXMgY2FzZS4gTWF5YmUNCj4gd2UNCj4gPiBuZWVkIFZNTSBoZWxw
Lg0KPiANCj4gRG8geW91IHNlZSBhIHNwZWNpZmljIHdheSBob3cgVk1NIGNhbiBoZWxwIGhlcmU/
DQoNCkkgZGlkbid0IGhhdmUgYSBzcGVjaWZpYyBpZGVhLiBJIHdhcyBqdXN0IHRoaW5raW5nIHRo
YXQgdGhlIHByb2JsZW0gaXMNCnRoYXQgZ3Vlc3QgZG9lc24ndCBrbm93IHRoZSBleGFjdCBwcml2
YXRlL3NoYXJlZCBzdGF0ZSBvZiB0aGUgR0ZOcw0KYmVjYXVzZSBvZiB0aGUgcG90ZW50aWFsbHkg
aW50ZXJydXB0ZWQgY29udmVyc2lvbiBwcm9jZXNzZXMuIEJ1dCB0aGUNClZNTSBkb2VzIGhhdmUg
dGhpcyBpbmZvcm1hdGlvbi4gDQoNCldoYXQgYWJvdXQgc29tZXRoaW5nIGxpa2U6IFRoZSBWTU0g
Y291bGQgZXhwb3NlIHNvbWV0aGluZyBsaWtlIE1hcEdQQQ0KdGhhdCBzZWFyY2hlcyBmb3IgYSBz
aGFyZWQgR1BBIGFuZCByZXR1cm4gaXQuIFNvIHlvdSBhc2sgaXQgdG8gY29udmVydA0KdGhlIG5l
eHQgc2hhcmVkIEdQQSBpdCBjYW4gZmluZCB0byBwcml2YXRlIGFuZCBpdCBzZWFyY2hlcyAoaW4g
dGhlDQpob3N0KSB0aGUgeGFycmF5IHN0dWZmIHRvIGZpbmQgYSBHUEEgdGhhdCBpcyBzaGFyZWQu
IFRoZW4gaW4gdGhlIGd1ZXN0LA0KaXQgaGFzIGEgc2hhcmVkIEdQQSBhbmQgY2hlY2sgdGhlIGRp
cmVjdCBtYXAgUFRFIHRvIHJlc2V0LCBhbmQgYWNjZXB0Lg0KDQpUaGUgZ3Vlc3QgY291bGQgY2Fs
bCB0aGUgbmV3IE1hcEdQQS1saWtlIGh5cGVyY2FsbCBpbiBhIGxvb3AgdW50aWwgYWxsDQpHUEFz
IGFyZSByZXNldC4NCg0KPiA+IEknZCBzdGlsbCB3b25kZXIgYWJvdXQgaWYgYW55dGhpbmcgbWln
aHQgdHJ5IHRvDQo+ID4gYWNjZXNzIGEgc2hhcmVkIHBhZ2UgdHJpZ2dlcmVkIGJ5IHRoZSBjb25z
b2xlIG91dHB1dC4NCj4gDQo+IHNldF9tZW1vcnlfbnAoKSB3b3VsZCBtYWtlIGl0IG9idmlvdXMg
aWYgaXQgZXZlciBoYXBwZW5zLg0KDQpJIHRoaW5rIHRoaXMgaXMgYSB3b3J0aHdoaWxlIGltcHJv
dmVtZW50IG92ZXIgdGhlIGV4aXN0aW5nIGNvbXBsZXRlDQpsYWNrIG9mIHN1cHBvcnQsIGJ1dMKg
aXQncyBub3QgcmFjZSBmcmVlLiBXaXRoIHRoZSBiYXJyaWVyIGNvbW1lbnRzLCBhbmQNCmdpdmVu
IHRoZSBsYWNrIG9mIGdvb2QgYWx0ZXJuYXRpdmVzOg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdl
Y29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQo=
