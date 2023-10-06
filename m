Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C27BC080
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjJFUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:40:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69357CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624822; x=1728160822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gTyoyLYH8LmIkM73ExgVawQxCiRM3kDzNGZrE/ZkvHE=;
  b=cd/Aknh5pz49FMPh9SO5arMQnZXz93Y3fecs2pnpxAIPQ1sF3VhhYvz6
   uPydvE7GpaC2fQ9kY8cRKCod1Xn3VxU8RM6UuehhIt0u4sel21MKuAMOf
   4kif9tWMvuEOkgJr4n5Z8ITRdo9yyv5Yuy/pcMRwNGVZrvhjS06IzqBdl
   dsWh9VFgiDSb5Hb5a2UKAt0y2+JJHKAUfVFejLQ08GJAfpHAfCaJOyXYD
   XAJxPRBxM3+V2J0F2M7fO3lOKzDVvPH8ljxSiXJA6e9pCy319VdKI7FJe
   xMw0nfMbdJbMd7jqPV+70BBmmqlHNPioG5VZFU64Kj8kVOua6qJ2W3HJ3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5387102"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5387102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752299855"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752299855"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 13:40:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:40:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:40:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 13:40:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 13:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVQnMsRnbJtJpZVVjWINrvrmKFRycPUrBtf6MXhhqQPNDz1ZxewkXyLrFbkFB3nQDo2+H7os+phDD7W89yDnex8ZpP97qyLq/hh/tZOj6oax2QL72cvr41abl827yeANLm7Zw1KWnK7h86pyhna6V3WU9lkVe/d/9i/qak839umToORbCtONG0HsdyBe1yQjr2KI4QgGGuwlWd1yz7q9iNj6QKDSPQ7IfZMe7jSclKMYCqjoqmLbRFtsiN2umBUjuxLyNTPaViOfzUhZFvuQKnlm7HZKKLybJHEIFOkwtCyM1LddjyWX3ZTX9nbxPZdQbyiRVhQrznzpngMwuoCIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTyoyLYH8LmIkM73ExgVawQxCiRM3kDzNGZrE/ZkvHE=;
 b=CnBk8N1PtDL4w+NakwqsaeaRDFlWi3Q9+Oz2XOna2KjpRYhHKzWRbBAUobHtV5ob9HGl28I7vEmLTuVmYKJBLyYdrQMr7n5thB686gVi/U0qwzni6CgxAG+EhVaXzHzuh8T43M7XPWe8FONyVnPgy6K/iHjcxtdqwird3+lOBrxsZIiXb/ZUQ0PK7IAa0vastJ4ATjKDzJZDyt1JFVSugLvPtvWIaRWbLj178AehOA6Xkvwkt69HQpsDrqFufjer6CsQj5WhiMRZO964mGBjp/phP5yy+eA+QbwmmwBopJ7S1uOChVKT6aIu3MyxSW6H4etcXZiuxKTmQwdQ6TZkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 20:40:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 20:40:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Sun, Yi" <yi.sun@intel.com>
CC:     "Yan, Dongcheng" <dongcheng.yan@intel.com>,
        "Su, Heng" <heng.su@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "yi.sun@linux.intel.com" <yi.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Thread-Topic: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Thread-Index: AQHZ+B6dKnLc5bB7/U+LmK8j/rA7EbA8hGSAgAAWnICAAJ9fgA==
Date:   Fri, 6 Oct 2023 20:40:18 +0000
Message-ID: <4c8d4075a43e7000e6724e38fe1fa93df10c6109.camel@intel.com>
References: <20231006062855.875631-1-yi.sun@intel.com>
         <9db9a874e5b7ff62e9cb419f51279047438c30ec.camel@intel.com>
         <ZR/q/VaR8gF1CdOg@ysun46-mobl.ccr.corp.intel.com>
In-Reply-To: <ZR/q/VaR8gF1CdOg@ysun46-mobl.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: 7fb7bda8-f831-4719-f076-08dbc6ac7440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGty0LaUYSxRCTA5qSIA71RFv+CHil43UWnNIkTZN9Qi7aTpfMYQFCdXcrGYHZ3aOa00uT2IjsFcDo/u9/ASwpaFTXOucjE9a9b4Ufak23KNBQXkIB/zQJyerkCpTeP9MpA0taJOKTVjOq2QAZOe/Q28ZiNUfKQI0lth3el9kPemip2Ii42TImtlgXQoiv6WSblN5avloRIHS4nAQATesc3ODiNZauihcfWjJ1wOqIV7pDklr8ujrnFfT115mVqgPTS2SQtzc8jvqqklRZSzS6l34EV+w8PT+16/8N4Qu2jWgTKDie4dRLsUyYsXPlWnjzKivl6fYJPpBm1LIhnIMnz7uk3fytT+cX/RjEb3Z4PGrjfZuLUzFaVol0K4tTbPk0kk4huKwc7ULph4ov3Nww7whrzkvvJmV8EfViEZLUlXp2OFBl4Q1SC6fGHY9JOaKaHtA7qMfosEn5xo61rtn6h3onA9bVn2jpmF13DaE+y6oQWfmvvQ11q+7uEsMuEa/Od+SytktKWvJ1AmaZgBBdEXLib+9Z2Xj4KbmAFYkWuzQf5vjARusp0rnBBKmrte1RbH/gn6hYBZPSRP9IBXLQ6tDaUZ93RXiapOY6lsfyNZlPnGiOPtQz+fLXtAbJSR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(71200400001)(478600001)(6486002)(6512007)(2616005)(26005)(2906002)(7416002)(4744005)(41300700001)(37006003)(6862004)(76116006)(91956017)(6636002)(66446008)(66476007)(66556008)(66946007)(64756008)(5660300002)(4326008)(8936002)(8676002)(54906003)(36756003)(38100700002)(38070700005)(86362001)(122000001)(316002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENmejRNSEg4QTZOWWxmZGc5c2t5WW9FdGRVcmVNYWVCdVNhTjBXUkgzbjZi?=
 =?utf-8?B?WWlvVFd6YWhYODFZNVVWbldYY3FCOU1HVlZLbEU4OWV2MHhpK3lGYWVidXhR?=
 =?utf-8?B?ZVNkNjNYWEdKR3h0akFybWs5N0l1ZTRlVkx3dG9EWi92TmU0NDZZdEoydHNU?=
 =?utf-8?B?YkltMm9CY2JINHMxMmlsYkFlWlJ6ZW1TQldqaVpLbTdaTnIwWnRMZC9pZFhu?=
 =?utf-8?B?RVQwTzJNcXZQOFlzV2RXV0ZWQVpqNDI0TFd6S213d2xtNFEyZXhzR1VYWnFj?=
 =?utf-8?B?bnF1QXI5TEVlNUhCYnlxcW9QVklBdkJZanZ6S3ZFckFFOGM3Y2hjdTFrdTVH?=
 =?utf-8?B?c05PVGRyV2VucHExWkFPbW5lVkRRQUI3eXZZOGxuMGVxSHUrc1Y0MG5CQ3JL?=
 =?utf-8?B?dHpGZTFzaWYzdXNBT2c0ZmgyMnM0d3B0VVV2dm9Ub2RoZG1laytlWXdjSkhZ?=
 =?utf-8?B?eG85MnNVck1iK3pjb3JPS1RLNzg1Umt5M2MxVzlmNG1pR1RvUEtlOHpXam9k?=
 =?utf-8?B?N0tBTVN4Q1g2bmVxRXc3Tm15VVE5ckREbHFwemJNcFJwayttR3JkeHNaT0Fm?=
 =?utf-8?B?ZHVOZWFzdXdiSUErSURqVkNjc1ptRUxtMEFNQVp0YlpDRFcyckJVV2lWdnZa?=
 =?utf-8?B?dUFkSlk3UWJTVkhrcHFvZnZ1REIyd2hBUWxEcWRUV0JyUzBYVjF2Y2YwalIx?=
 =?utf-8?B?eWtnSXBRWGQ5WTZtL2x3dDVYS1pSUUkrWHh0S05xZFl4c09Id0VSK3NnUzBi?=
 =?utf-8?B?TE5kU3B0QXNkNWV2TW91UVNQZldzejBTWWZTUFE3Vmx4UHBacTdybzd4MXR3?=
 =?utf-8?B?NXE5aTl2Z0hrYTRjcVBJb0NDb3RXdmM0VFlmUEhCZ1V0VmdpdHFXd2pCR3Ra?=
 =?utf-8?B?b2ZKS1FoeUpJOUk2bDVuckI3eG9nZ0RJTFA0VFNhUnFpMnhnSzBtdHl5L0Rp?=
 =?utf-8?B?TmRObzBLWmZ2cGg5TlJiUjZvQzU2NFlmOFFUTEU2TFlSamtwNGQ2anRNNlc1?=
 =?utf-8?B?WTJZTU00aG15czlGZXVBeE5NQUdVT3c1cllaUHNqUG1abXZlUldMNklQZGU5?=
 =?utf-8?B?eUc5RTh4THAzaXp2Vnl3YTVKanM4VnlnVTFZbDZKcWxsdzVwWkpjanJWV3JL?=
 =?utf-8?B?YU5LYitGUVY3aERjZXZ2TlJvSktSNWhud2NhTmdpNkFzckFUMHh4Z0xwazh0?=
 =?utf-8?B?eDJwZUNiamxVNG1GS1VtczU4Z2dZNDhURDllQmFZWHRNT0RiazJhUnU4SGEz?=
 =?utf-8?B?eW8wTzdleXJEMVAydUI2TVQ0aWlma2kzY0NqRCsyYmR0S2NVdmZRSDNyWVhK?=
 =?utf-8?B?cnhydEZWSkNJbkE3Y2NrQ1oxeGNGRWYzSFVlaWVIeUUyalp4YnhYTFg3ZklW?=
 =?utf-8?B?QWhnakxiUTF6RTJoaW14MmlLaFowd3BFTTlqMkZ3TWFVRnUxcmROMWJnLzVh?=
 =?utf-8?B?Wjk3ZWh6QklEMzcvdFlDeFArWGYxRFo2d0hYQTR6UWRMSEJtaUtaeVhiaTZm?=
 =?utf-8?B?YXRWOWpFemVVQlZwZ08zT25MSmJRTncyTUxBaGJKTml0K3RLN3VjMzZwTEta?=
 =?utf-8?B?QlNuUWZqd3lSSlFJaW5lOC9lYno2UTlyMkR3OG9OVDVqV2EvME9PajBzZkQ1?=
 =?utf-8?B?NnZaUVZBcnM1K0FHQjB2NnI5YnYraytpZ3dESTd1RFVmT05JUndCQldCV29w?=
 =?utf-8?B?U2hTTHRjRnFhSXBFVlRzNWZZbENNdGtURzdpYlB3aE0vMnJPS3ZWM1plRXo3?=
 =?utf-8?B?b01oUkl6MzV3dEhwMUNUUmc3TXhDazlqd3pkWFh6bWJuQmU4MTYzZzBjdHNU?=
 =?utf-8?B?K2dkaWljcHdPdE5UcTJWdVZicjFNcy95MUtQeE5GcXViZUZTMkkzZzJpSnFn?=
 =?utf-8?B?aDB3WHJPRE96QUU4TTRtYkhOSlc5K1dTV1VtcTdKK09ZbzdKWHJVVFY0ZElk?=
 =?utf-8?B?UVgwSGJjcHRqdEdRSVVPV3JEci93KzFiY3hINkd6TFEzMjJucm9WbEIwNHZI?=
 =?utf-8?B?WXN5NC82RmEyd3V1bjlTNzE2RldKdkx6UFZVNVV6YjEwYTZZaUtVQ2ozaTl4?=
 =?utf-8?B?bVJrOFdNTk9EbVlFSXJJc1NKVUhtLzZBNGJISGpNNzlzV2pTYWZ6VHlMNnlw?=
 =?utf-8?B?RUU4VE51VFBDQnpvN3Q4WUpNblBnSGx4TkNqaWluRmk0REN3TkFXejFpZjRG?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6418AB67F205DF48A5E01D95C8F191FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb7bda8-f831-4719-f076-08dbc6ac7440
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 20:40:18.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJVPaOcKN7vKcuIl8m0okSShBbipDEOhdHilG4FMps3+yK4xpxr881kvXwHX+pwl2FS3xEHT8AX1LMD7lxE4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE5OjA5ICswODAwLCBTdW4sIFlpIHdyb3RlOg0KPiA+ID4g
Kw0KPiA+ID4gKwkvKiBURFggMS4wIGRvZXMgbm90IGhhdmUgdGhlIFREQ0FMTCBUREcuU1lTLlJE
ICovDQo+ID4gPiArdmVyc2lvbl8xXzA6DQo+ID4gPiArCXRkX3N5cy0+dmVuZG9yX2lkID0gVERY
X1ZFTkRPUl9JTlRFTDsNCj4gPiA+ICsJdGRfc3lzLT5tYWpvcl92ZXJzaW9uID0gMTsNCj4gPiA+
ICsJdGRfc3lzLT5taW5vcl92ZXJzaW9uID0gMDsNCj4gPiANCj4gPiBTbyB0aGUgbWFpbiByZWFz
b24gdGhhdCBJIHRoaW5rIHlvdSBjYW4ganVzdCBwcmludCBtb2R1bGUgdmVyc2lvbiBpbiB0aGlz
DQo+ID4gZnVuY3Rpb24gaW5zdGVhZCBvZiB0ZHhfZWFybHlfaW5pdCgpIGlzIGJlY2F1c2UgSUlV
QyB5b3UgYXJlIHNldHRpbmcgdXAgc29tZQ0KPiA+IHJhbmRvbSB2YWx1ZSBmb3IgVERYIG1vZHVs
ZSAxLjAuwqAgUHJvYmFibHkgaXQncyBiZXR0ZXIgdG8ganVzdCBwcmludCBpdCdzIG1vZHVsZQ0K
PiA+IDEuMCB3L28gbWVudGlvbmluZyBtYWpvci9taW5vci4NCj4gDQo+IEFjdHVhbGx5LCBpdCBp
cyBub3QgYSByYW5kb20gdmFsdWUgaGVyZTsgaXQgaXMgdGhlIGZpeGVkIHZhbHVlIGZvciBURFgg
MS4wDQo+IGJlY2FzdWUgdGhlcmUgaXMgbm90IHN1Y2ggdmVyc2lvbiBpbmZvIGluIFREWCAxLjAu
DQo+IEkgYXNzdW1lIHdlIGNhbiBzdGF0ZSBtYWpvcj0xIGFuZCBtaW5vcj0wIHdoZW4gVERYIDEu
MCBpcyBkZXRlY3RlZC4NCj4gVGhpcyB3aWxsIHByZXZlbnQgY29uZnVzaW9uIGZvciB0aGUgdXNl
cnMuDQoNCkkgbWVhbiB3ZSBjYW5ub3QgYXNzdW1lIG1pbm9yIGFsd2F5cyBiZWluZyAwLCBJSVVD
LiAgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHdlDQpzaG91bGQgcmVwb3J0IGl0IGp1c3QgYXMgMC4N
Cg==
