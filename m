Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BA77B5EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbjJCCHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJCCHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:07:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF4BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696298821; x=1727834821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Tpco322RamNf+2ujRhuQQJ84SWUcDBa1dnST45G4sM=;
  b=ChWzQRHL89WGH0cPNHwjEJkLy3rEXff8pHhQ+aP7N8bnsePCJmaNW3C/
   TyZ8g4VYKn7zuhDw1x3jTDTfCoI9AfMXX7i+F3Q4mp8Viva/sm/9Lw9rM
   9BT9axUalWRP7HaKi6uvN6zQ/kaAHGEIxE58+6998vl6Fuw6taqPyUch0
   oM8eb561wP2GCzhiX18TghUE/8XNqvZriRGEg+fPzxZrdl1bwNoeS6OSH
   PSiQDCRH8i2Byr2enrXyPtKquihuYSuNUPJnyp8pzXBTGMkxyf9T0hJy3
   nncBU9w4qK3fyEm029FVMo3kmdAaxMjQQGyi9vDIfABy/AI+ymdrEeQV6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373121048"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373121048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 19:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997831622"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997831622"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 19:07:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 19:07:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 19:07:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 19:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx4X/S81zc0w/LAdC4f7V3YsSvB+mdM8IiCnLR6h9GkhXFyhlNin5MUfX8ssrCRPHNFTvi3S908eniKAj6wMYlGE3mn8wdCeu7m8i2aKigEgWOsyhwtBik9xap6sqYVvVAne3P8wAG48R4bTrRUOPWTPUW2tbnXTuiHoYb8nfF/0+0atwBFlDbA/p3XAibPeFy7aFwsI694mUmmvroC2V8pVwAR3Wp+pHvgBBH9Wj6bbrwiy9OqyNuEyzKytvV+KDcasIIRKUHYubhQMX/PI8r5072KRxvi/kKnUHjX82Lboq6BzAe2Y2zpnh3hEalQtm5SVlwH1m0oMO06QXtXk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tpco322RamNf+2ujRhuQQJ84SWUcDBa1dnST45G4sM=;
 b=XMTq43s1nd1O8UW5NQlwtHfYTmOXR4RnY18U6u+eyjuSKg6dwgv1ca4B5Wrwy3IsOhcDsYLF+UUYoFKwICNmAJZFO0B3sIGPg7kV2ADQa5Gyt42N/E6fpBZ9MTjpvv/sQ/Yu3S8NfgArBJ3sCgZNK+NmZKH0zeqTzFzd9FzSIjx+L+du7EbesAmT/rbpzOTQKTx2ertovjxVq8/BSGEeSUzHjww0nyoli8UsApD9GpNoagl+zQzmDhdPd1zP329rLzZYCB6Iw8dcAe1plQ23lxjCFgdD+5ZuafsmixD5mD8/vdD+abywWya57Rz3jnm4mP4NDU0p7PDZRhjS3tG0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Tue, 3 Oct 2023 02:06:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 02:06:53 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Thread-Topic: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Thread-Index: AQHZ8lt1lNiOeHZND0aep32XrBS2Q7AxhdQAgAWaaACAADeXAA==
Date:   Tue, 3 Oct 2023 02:06:52 +0000
Message-ID: <65d26d679843e26fd5e6252a08391f87243a49c9.camel@intel.com>
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
         <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
         <20231002224752.33qa2lq7q2w4nqws@box>
In-Reply-To: <20231002224752.33qa2lq7q2w4nqws@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: 98861811-2c91-48eb-76b5-08dbc3b56982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ps5XOi/+kRvhp0bMvrq+TQ85qmiN72qvnyQIyLXyiAToOGEiKZwLqRUjKCkJIuvq3hhdVKH6C1PfGbJHrwwtnB5HZv7NigJ9Pi+QlQt1WuvoKLkyDe4/wX4Ty1vhHgei65MokGbQ5spkBEdA3Ti/63z3M5HLISxvoUlVqETTvhzyiF6pJAvMaoUyHcRZejAtic78QEfTjDkznCgEJ8tSvlPdZHjMGX4+HAN3AAlXxgKDjIVb7eXsE2ymljfPzwXd0BRKkJrUtZVO7KxGXDjBif//C9G4tebi7kq6K2HEOr423ntw60htqLTHiEK8iC5RBtL6x9e7R0bsBx10Ee1FTgMwAPIGBM+lmbAZxWKegP9CzSWepbfat4sLj/uwcA4kyl2Iko1WezYGF35PD2AzO79Z7GO63tdvqZjk9pEr87Sn+triMloSW7dCTDuEhK1Zoyu+lsfx4kmYeDERqgtg9dQL2QTJCpaTKS6IcEhquK3si1li+3wsiIsBUi9sDnDwJsPoZaDoFHAJHKR3BnUcZfNmV9I68UGA+Xn+g3/2vB+SKQeQLSRNvPcKg7NtDfjaMf9EBmjLYDpr/1mmo4EnAj2dWRCqx5Lk9kzQoWLXaONoAzv59ccC12oB7iWMYIwxQ3zidhgRJlKgwGCiZUJjNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(83380400001)(15650500001)(86362001)(36756003)(38070700005)(38100700002)(122000001)(82960400001)(71200400001)(26005)(91956017)(64756008)(66446008)(66476007)(66946007)(76116006)(6512007)(66556008)(6916009)(54906003)(41300700001)(2616005)(6486002)(6506007)(5660300002)(4326008)(8936002)(8676002)(478600001)(316002)(3714002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWhwdmYreVlOMlNmb00ra0d6U3RKelNBcjlHRE81UjdtVmtQYTF3VkU5TU1Z?=
 =?utf-8?B?RmlOUzcyeGw4VGVUd1M4R1BYU3g3WnVPMjlTdTY4L01UK0Y5MzBWWTVDUlNV?=
 =?utf-8?B?TFJYMzRoWVFkTEpwVTBZdVZibVZseTcrQVl5bXVDZ2FWZi90Y1lNamVvYlNG?=
 =?utf-8?B?YkFUYURiRjVEakpzdHZmeG1sZml0Wk9tYmRFeWM0eTNxR1VJWEJ5OWRvSVp3?=
 =?utf-8?B?S3JPVEsxQUMxcE9jWWJ5cmRNKzk4OVhHck05akNqc09ZQ2tOMnYzaWVqTHQ1?=
 =?utf-8?B?aWRraEZ4QVY3K3dBQ0Q1YVk3KzdRbUVVc1VTVitIZkNSZUcxaHJISGs1OU5p?=
 =?utf-8?B?d0VQamE1d0NWWVBLVmRqMEcxTThWR3FmZi9JcjVOTFpvbytuL2k3THRJbURn?=
 =?utf-8?B?REMvTVNydmFQQUxOdlpqcDNqNDVTWlYzbW4vSGp0RG11R3VncFpDUGgrdFp6?=
 =?utf-8?B?ZkxXMFFkSkE0cSs2Z3JVVFZIdlZGaXhaY2NkdW5xbGxtcVRJV0pkU3QwT0tu?=
 =?utf-8?B?S3djL0N2OWhPZ1BrcTNKeHFJZ3k4bWpBenRVSDlJRSsxVzQ2d1JBL3FYZnlW?=
 =?utf-8?B?RXFLQTR2S1RDQ2VHTG5sRGY4M3JnSDdld05teGx0ZzZnSUN3bVFPcXlvN2wr?=
 =?utf-8?B?dW1yUHUyRXhxS2xweGE1azhrWUJBNG9sUW95WjVXQnZMMDBPbWtCaHRxQ2dk?=
 =?utf-8?B?cEMrTEFwWW8xUGo3cTBVRFpvY2NkbldkSjV6ZG10WkZBcGczdlRuYWdWZlRz?=
 =?utf-8?B?QlVFQUJOQVoxbzdjcUUwNjBOVEVicld0NTliY2Y3Y1prbHNMMUNXV2pxb0J3?=
 =?utf-8?B?ZWZEdkRqMm5ROGlBd0NhS3dITS9BdVRlbVVIcTFkWG9TUVJOcVFOcHVyYUN0?=
 =?utf-8?B?d0xtdStzMWVSK1VPY3lrTk4rTm5mV0xtSGVLc3BWYlpndWswSzJheUZsUXhq?=
 =?utf-8?B?WU5xRlgrd0VPMWRRQjFqUzNBL3pDdHZTVzBZb0p1QjVKLzlrM1ZTS1NueFVR?=
 =?utf-8?B?Z0JyWWFnY25ydHYyaGdVSHY0Y0NHTUJvS2NjaHdidkJzY0VoTTlCWnhqRmR4?=
 =?utf-8?B?K2ovUzNKTEkrK2I4SXlhSnNNcjNFS2pJUEJKeFljd1I1SFVxSzRQMDAvd3Ja?=
 =?utf-8?B?bFRzcWJGYmhueW1KQWNVUEdTcTlYQTFyc3Zlc3lXZUgwMXJlcm1mYXFieUt3?=
 =?utf-8?B?eWJoZDB1MWhyR2RxYmdjTkxhcGFwRzZGS20zOXpZTGw4MWcydllFYUNuYlhr?=
 =?utf-8?B?aXlGd1RROWZ0dGwzQXZiSjNhWWkranJzSTkwZFpabXlUREZzQS9VQ2RvQldX?=
 =?utf-8?B?aGlKK3F4dlZiSkl3c1pMTnI3dGVwbFg3bERmWmRoVjh6TmNMd3lrc0Q5RDU0?=
 =?utf-8?B?dlpKUEZUNmpjRTlWbGtyMXVqRWtBUHo2aG5zQW1obDdwWjBXUFZqblQwc1VG?=
 =?utf-8?B?Z1pyRzJYelYwbmRJUWJRRVpSS0psdk1OcHJZTmQ3TC9renhiMm5ZVkI4Z2NN?=
 =?utf-8?B?dnRBSE5kQTg4dm5OcWFiY0xIQ3h0VHVUVU91Ujhodm9YUzZBQThoUXRuNWxN?=
 =?utf-8?B?eG9YcmVGa1FYWDlQWU16RloreWtDT29CR1pDd2J2UmpsSFFlSkk2V0pYWlIv?=
 =?utf-8?B?cnJzR0x0ZDdwMHlGQnlCaVlQNGQ5M0FXZkIvaVd4czBVRUFycHZ4UStZdTcx?=
 =?utf-8?B?OE4vbkFpbnpOYUNEZ2hTcjFER1JzbHdicGJhcTZHQzNYOERiUDkxUXJ3TFhE?=
 =?utf-8?B?dTZOUWNMM1o4bEtkbVBKTjZpdDdxR2F5V0xpMHFia3ZiQTVDOVNxcnZSZUdB?=
 =?utf-8?B?a0FCazdtTDliSzAwajhEc1QzejVBT1JNbWM1QjhPMlJROFFqaENlTVBiRUhV?=
 =?utf-8?B?blhhMWNsZWdSVHVMVGwrdHVQaDF0Qk5MdHVwY05mT2xCQ24vekVaKzFmc05E?=
 =?utf-8?B?NWFsOTV3T05hY3l0UFF4cUdHVjk4djkyd0FuWnpNd0VqeTdwVDV0ZG5mbXcx?=
 =?utf-8?B?ZUZyUXRKMmRnNzJSdGYvMzNBUFlDaHZDR3JiQUFzTnMyUE5Tb2k3SUlQS2Qw?=
 =?utf-8?B?TVNtQkt5TE9vMFdRMjdVZHJFVTFGeGVkQ0dYcXVvUXRDTnp5T0hIUUdnQkdY?=
 =?utf-8?B?VVVkbXZmNzByVi9Td0NYZFlleVRKTmlJeFgwYlJQdW9IY1ZjZm9WbXVtLzlk?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47A09D8A3890544F945A5B557138922E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98861811-2c91-48eb-76b5-08dbc3b56982
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 02:06:52.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmKdo4+ncA1SoUI0vqPoAXJRbrQ6GsuwX2qpWPB+eQ9zdajoFsMZQ2OnZmWlimquoxZzWqcf+/R/zyFESLVWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDAxOjQ3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBGcmksIFNlcCAyOSwgMjAyMyBhdCAwOToxNDowMEFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wOS0yOCBhdCAxNTozMCAt
MDcwMCwgQ29tcG9zdGVsbGEsIEplcmVteSB3cm90ZToNCj4gPiA+IE9uIFRNRSBlbmFibGVkIHBs
YXRmb3JtLCBCSU9TIHB1Ymxpc2hlcyBNVFJSIHRha2luZyBpbnRvIGFjY291bnQgVG90YWwNCj4g
PiA+IE1lbW9yeSBFbmNyeXB0aW9uIChUTUUpIHJlc2VydmVkIGJpdHMuDQo+ID4gPiANCj4gPiA+
IGdlbmVyaWNfZ2V0X210cnIoKSBwZXJmb3JtcyBhIHNhbml0eSBjaGVjayBvZiB0aGUgTVRSUnMg
cmVseWluZyBvbiB0aGUNCj4gPiA+IGBwaHlzX2hpX3JzdmQnIHZhcmlhYmxlIHdoaWNoIGlzIHNl
dCB1c2luZyB0aGUgY3B1aW5mb194ODYgc3RydWN0dXJlDQo+ID4gPiBgeDg2X3BoeXNfYml0cycg
ZmllbGQuICBCdXQgYXQgdGhlIHRpbWUgdGhlIGdlbmVyaWNfZ2V0X210cnIoKQ0KPiA+ID4gZnVu
Y3Rpb24gaXMgcmFuIHRoZSBgeDg2X3BoeXNfYml0cycgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYnkN
Cj4gPiA+IGRldGVjdF90bWUoKSB3aGVuIFRNRSBpcyBlbmFibGVkLg0KPiA+ID4gDQo+ID4gPiBT
aW5jZSB0aGUgeDg2X3BoeXNfYml0cyBkb2VzIG5vdCByZWZsZWN0IHlldCB0aGUgcmVhbCBtYXhp
bWFsIHBoeXNpY2FsDQo+ID4gPiBhZGRyZXNzIHNpemUgeWV0IGdlbmVyaWNfZ2V0X210cnIoKSBj
b21wbGFpbnMgYnkgbG9nZ2luZyB0aGUgZm9sbG93aW5nDQo+ID4gPiBtZXNzYWdlcy4NCj4gPiA+
IA0KPiA+ID4gICAgIG10cnI6IHlvdXIgQklPUyBoYXMgY29uZmlndXJlZCBhbiBpbmNvcnJlY3Qg
bWFzaywgZml4aW5nIGl0Lg0KPiA+ID4gICAgIG10cnI6IHlvdXIgQklPUyBoYXMgY29uZmlndXJl
ZCBhbiBpbmNvcnJlY3QgbWFzaywgZml4aW5nIGl0Lg0KPiA+ID4gICAgIFsuLi5dDQo+ID4gPiAN
Cj4gPiA+IEluIHN1Y2ggYSBzaXR1YXRpb24sIGdlbmVyaWNfZ2V0X210cnIoKSByZXR1cm5zIGFu
IGluY29ycmVjdCBzaXplIGJ1dA0KPiA+ID4gbm8gc2lkZSBlZmZlY3Qgd2VyZSBvYnNlcnZlZCBk
dXJpbmcgb3VyIHRlc3RpbmcuDQo+ID4gPiANCj4gPiA+IEZvciBgeDg2X3BoeXNfYml0cycgdG8g
YmUgdXBkYXRlZCBiZWZvcmUgZ2VuZXJpY19nZXRfbXRycigpIHJ1bnMsDQo+ID4gPiBtb3ZlIHRo
ZSBkZXRlY3RfdG1lKCkgY2FsbCBmcm9tIGluaXRfaW50ZWwoKSB0byBlYXJseV9pbml0X2ludGVs
KCkuDQo+ID4gDQo+ID4gSGksDQo+ID4gDQo+ID4gVGhpcyBtb3ZlIGxvb2tzIGdvb2QgdG8gbWUs
IGJ1dCArS2lyaWxsIHdobyBpcyB0aGUgYXV0aG9yIG9mIGRldGVjdF90bWUoKSBmb3INCj4gPiBm
dXJ0aGVyIGNvbW1lbnRzLg0KPiA+IA0KPiA+IEFsc28gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIGl0
J3Mgd29ydGggdG8gY29uc2lkZXIgdG8gbW92ZSB0aGlzIHRvDQo+ID4gZ2V0X2NwdV9hZGRyZXNz
X3NpemVzKCksIHdoaWNoIGNhbGN1bGF0ZXMgdGhlIHZpcnR1YWwvcGh5c2ljYWwgYWRkcmVzcyBz
aXplcy4gDQo+ID4gVGh1cyBpdCBzZWVtcyBhbnl0aGluZyB0aGF0IGNhbiBpbXBhY3QgcGh5c2lj
YWwgYWRkcmVzcyBzaXplIGNvdWxkIGJlIHB1dCB0aGVyZS4NCj4gDQo+IEFjdHVhbGx5LCBJIGFt
IG5vdCBzdXJlIGhvdyB0aGlzIHBhdGNoIHdvcmtzLiBBRkFJQ1MgYWZ0ZXIgdGhlIHBhdGNoIHdl
DQo+IGhhdmUgdGhlIGZvbGxvd2luZyBjYWxsY2hhaW46DQo+IA0KPiBlYXJseV9pZGVudGlmeV9j
cHUoKQ0KPiAgIHRoaXNfY3B1LT5jX2Vhcmx5X2luaXQoKSAod2hpY2ggaXMgZWFybHlfaW5pdF9p
bml0KCkpDQo+ICAgICBkZXRlY3RfdG1lKCkNCj4gICAgICAgYy0+eDg2X3BoeXNfYml0cyAtPSBr
ZXlpZF9iaXRzOw0KPiAgIGdldF9jcHVfYWRkcmVzc19zaXplcyhjKTsNCj4gICAgIGMtPng4Nl9w
aHlzX2JpdHMgPSBlYXggJiAweGZmOw0KPiANCj4gTG9va3MgbGlrZSBnZXRfY3B1X2FkZHJlc3Nf
c2l6ZXMoKSB3b3VsZCBvdmVycmlkZSB3aGF0IGRldGVjdF90bWUoKSBkb2VzLg0KDQpBZnRlciB0
aGlzIHBhdGNoLCBlYXJseV9pZGVudGlmeV9jcHUoKSBjYWxscyBnZXRfY3B1X2FkZHJlc3Nfc2l6
ZXMoKSBmaXJzdCBhbmQNCnRoZW4gY2FsbHMgY19lYXJseV9pbml0KCksIHdoaWNoIGNhbGxzIGRl
dGVjdF90bWUoKS4NCg0KU28gbG9va3Mgbm8gb3ZlcnJpZGUuICBObz8NCg0KPiANCj4gSSBndWVz
cyB3ZSByZWFjaCB0aGUgc2FtZSBkZXRlY3RfdG1lKCkgYWdhaW4gdmlhIGMtPmNfaW5pdCgpIChh
a2ENCj4gaW5pdF9pbnRlbCgpKSBjb2RlcGF0aCBhbmQgZ2V0IHRoZSB2YWx1ZSByaWdodCBhZ2Fp
bi4NCj4gDQo+IEJ1dCBpdCBzZWVtcyBhY2NpZGVudGFsLg0KPiANCg0KQWZ0ZXIgdGhpcyBwYXRj
aDoNCg0KaWRlbnRpZnlfY3B1KCkJLT4NCglnZW5lcmljX2lkZW50aWZ5KCkgLT4NCgkJZ2V0X2Nw
dV9hZGRyZXNzX3NpemVzKCkJCTwtLS0tLSAoMSkNCgl0aGlzX2NwdS0+Y19pbml0KCkgLT4NCgkJ
ZWFybHlfaW5pdF9pbnRlbCgpIC0+DQoJCQlkZXRlY3RfdG1lKCkJCTwtLS0tLSAoMikNCg0KKDEp
IHJlc2V0cyB4ODZfcGh5c19iaXRzIFsqXSwgYnV0ICgyKSBpcyBjYWxsZWQgcmF0aGVyIHNvb24g
c28gbm90aGluZyB3cm9uZyBpcw0KZG9uZSBiZXR3ZWVuIHRoZW0gZm9yIG5vdy4NCg0KQnV0IHRo
ZXJlJ3MgYSB3aW5kb3cgYmV0d2VlbiAoMSkgYW5kICgyKSAoYW5kIHNpbWlsYXJseSBpbiBlYXJs
eV9pZGVudGlmeV9jcHUoKQ0KdG9vKS4gIFRoaW5ncyBjYW4gZ2V0IHdyb25nIGlmIHBlb3BsZSBh
cmUgY2FyZWxlc3MsIHRodXMgSSBzYWlkIF9wZXJoYXBzXyBpdCdzDQp3b3J0aCB0byBjb25zaWRl
ciB0byBtb3ZlIGRldGVjdF90bWUoKSB0byBnZXRfY3B1X2FkZHJlc3Nfc2l6ZXMoKS4gIEJ1dCBJ
IGRvbid0DQprbm93Lg0KDQpbKl06IG9uIHRoZSBvdGhlciBoYW5kLCAoMSkgaXMgbmVjZXNzYXJ5
IHRvIG1ha2UgKDIpIHJpZ2h0Lg0KDQo=
