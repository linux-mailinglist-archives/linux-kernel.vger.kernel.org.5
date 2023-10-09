Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E07BD206
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbjJICjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJICja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:39:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB6A4;
        Sun,  8 Oct 2023 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696819169; x=1728355169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/rn2KmPwrJmBtOaXV4OYdpMwa+y6naRL590m7m3gwgQ=;
  b=KNgrBhHGRbeYYoPpX4zdVM7mXWxJbo9G/X0EGp8AjOTiL5bPqJbXvyxg
   JoSbYGt81g+ZMW1wOw2nh5/wILwLAilaq0axbj2GhlhI3ImBLQ07MCqEJ
   nkBL1IQRP+tezNB/9n6ww7rRp6z7tYLe4sE5Yl7UQCMkI8FqOzi+MR6cm
   omj+x1TJiUwLrSc6U3BHG9qXH/qp++PMf2lFVI8VRTM6kdZUOtROgulpb
   pp/E238altJONtWk5E4BdoKiHIdHINnUlhGfbn45c69UkvMBAvAZM0Swz
   JUCyV7JqRGixCwp4oz1N7V5OaFmIsKKD3u/1j42JVwFx73b9rvt/y2peE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387918406"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="387918406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 19:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752863308"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="752863308"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 19:39:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 19:39:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 19:39:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 19:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0Otoy/GgTax0Xo9ELuJoP4qJ78S3BL9ZH4VGDNTn2TEEOnLYd9weXNTgrylqtTkFf521zr/9JRSKVIhI90CEnrsmFETQWeL6Sw5VLa4XRvE8B5rzOWGsR1M07pZf+MYOa+WINd6rA1ZYr1VT4jTxqgaJhftNSH3QMwbAT6qqgWJq3wo7h41JWmqp5xWQCVWkMWoiFx+fNgYcfTcH4fUBtd8TUnAGpYY/mQJozfeX4liZdP5snsk+obs+yBKZmkqp70jQvQ70J1M2x6T+0JY4fHrkLeWJhyvKsD6EULKSmUhfq9vkmu6B4fb1o17QhMU43f/SczyY2AV5+ysNm3Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rn2KmPwrJmBtOaXV4OYdpMwa+y6naRL590m7m3gwgQ=;
 b=LpiziSZ8WScKFTsm/i7xIHMAC682eHmvDtmsZ5dk8A08Ov/0Xlu/ccHSD++VUDa91fQ+p6bHD13DjN4AWqBbXWSiuzdxbj8XOgamjsl2NyTRennre6G/sp8NAN4cioV3mEwjsw4HKfyYv+XGogyexYUZqO16JNWXu8fJf42oOLXAajk93XkL12RZ0nbjxDvaXCGHYswPF2eQ6riHyKXAsygnG+/kgexOh1LOTWie2ybCUj13+C5Fk8pbp4KQpYfXZU6w+/bfeWckMGwfUbkI1N1AZr/2ocVV3qwwmz+9uWjru06gpotDXLOCICiZ/tIYSYk9Z6qWWn1rls9/qZZEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 02:39:25 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 02:39:25 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>, "Li, Lili" <lili.li@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] EDAC/igen6: Fix slab-use-after-free in
 igen6_unregister_mci()
Thread-Topic: [PATCH 1/3] EDAC/igen6: Fix slab-use-after-free in
 igen6_unregister_mci()
Thread-Index: AQHZ+b399klK8f9JNEWJHlp6WrDYsbA/uQYAgADvl7A=
Date:   Mon, 9 Oct 2023 02:39:25 +0000
Message-ID: <CY8PR11MB713434F22846F9002DB6238C89CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
 <20231008105740.GAZSKLJMLfbiDbZlm8@fat_crate.local>
In-Reply-To: <20231008105740.GAZSKLJMLfbiDbZlm8@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: 95be58bf-c24a-4e56-2a9e-08dbc870f3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtJbRvnFTfDEmfNLHFqbtrT/Jn5stSCc97zByk/Yz76lDnWCdWKOq2CziPMDh2tkcJUcf9W52gHPx9ve7qdPKfq7/T+VBICiuOFfWzaoaEJOUhcDqQPcXDSzKxCEbeZ3NQ6CzfGtUYJNR2RQlI1AhrjlnuUFPZB9rPhtMkTB+yKAnAfwSVlpg9GG4+yK0r6yeXz/eZdXGd5mKAc1lPRXlOjtuabHM4unh8cziZt+DgJRrU0LU4OAs9HjJ28XHiqoTtRKqSbFCufxX9jVJvnX08T9AzuLCYbruopu9PvvwYBWv0xzu3I0/F51kDHiRGGeWP+uIrm1KyW/gmjxUUbbybwOOq1IbAKe4Rv0o1tDq+HXJdjXrB0AGGq7LpDe6quAFCMsep47CU+UlQZDH3sndu2aVISwmM49R/i5xmn3yGWSUV2gju2NQa4wvR787xqy0REFElEMANMVEHEHWZjvEUul23XSTPTt6FHHspHPHNYz96SERqG+c9bQAv44pEPYP0ig5qDFWDofEwjv1qbE+s5G2qWHN0LSmtD8cvDx3PLZfdvGmfsU+G4NgefCQZvyJjJLWPtMmOMYjG0bGBUM3EjZdU+DFWUCYwLIZlmpWbXr6nzbYLk5YR3VGYfxBi+2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(9686003)(38070700005)(26005)(71200400001)(122000001)(6506007)(7696005)(82960400001)(41300700001)(76116006)(478600001)(66556008)(66476007)(316002)(66446008)(66946007)(64756008)(6916009)(54906003)(8676002)(8936002)(52536014)(5660300002)(86362001)(4326008)(33656002)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkpocDdMa3hUWDI1RTV2TXVMV1FUMllqQ0dqcVNlOEJnWjR5cnZrN3dZb0ow?=
 =?utf-8?B?V3FTcHZqKzBNUnBDMXRDNEhlZGJUV1RrcEkwdkxsL3c4dlFoRXpYbmRLaE1O?=
 =?utf-8?B?T0pNU3VxRkNQcURPRE00YXhJUW5GMjJIRE1GUDJOS21RaC9GdXA2UVpGaTda?=
 =?utf-8?B?dmtRRzVpUGV1VTQ1c3VlYmlwY0dFTHlXTEJISllGdXhJOWFlRExqLzlRU3NK?=
 =?utf-8?B?T1cxSVk5NS96QWRkbzBGR25wTkRFQlBrSUk4dzVndmVJU0ZiZXVPVHdwbU12?=
 =?utf-8?B?cFhDOGdleSsvSkEreUlJOTJaTWJ3cVpsM2wyZThUS2o4a0ppTzJQd0lFY1A2?=
 =?utf-8?B?eWdGb1ZvQ1N2Zzk2WEJKTmN5eDlsUk5vRzYxdzZtN1Q5NW1ETkdHT3pXQWJ0?=
 =?utf-8?B?OTFpUEliWEYwZnJwaHE5a0FhWnljcWZyalB6U2JaTllxZDNlR2Jnc01jMVJG?=
 =?utf-8?B?ZG9HS1ZmVGw1eHdNZjdvYUU3enM0NFhGTTA0TGtoWU5WNkdyY3N0dkpkWWJL?=
 =?utf-8?B?Q2l5bHZHOEVRVkpCRHE2dlFpV2ZsTDFMdFpyRmpDMkc4RXYydWZ4V2JnVGQ4?=
 =?utf-8?B?aldVZVBDcTNveFlMOXAyTjdsNlZBR1ZYNEdhcCs4bmpPZ1VFUEdTYlZXL1J2?=
 =?utf-8?B?eDB4ZU5Wd1VKejM0aW1VKyt4ZUN1U1ZQRzBkTUNNMlRwRTg0eHB2MExzYjdO?=
 =?utf-8?B?dDZ6Rk5jVU1LZGhBUzJZS3hsYUNqRkxsTkFxR2UvS3VsS3hxOHpXakdoZTJX?=
 =?utf-8?B?Q3FJQUh3ZVJ6V3ZnRTUzTGZjNmc3SFEyZWpKZ1QyS1ZRTDdKN2R6eTNXVTc4?=
 =?utf-8?B?NkUyYkt4ZlVxdW9veWlzMmFwQUdwSG9NWlFsYVlIaVdBTmxHV1MzLzhXazJY?=
 =?utf-8?B?QzNiRWh4b2dIQnNnek5RMDRuUGFXSE9ZWndZdDNWSnhRYnJQV1Q2cmJDazN1?=
 =?utf-8?B?Vi9ualNsSERzMEJnNC94Yk9qcjN0UGFSbVBWUUU0ZERENVlxZjRYanhDc2tq?=
 =?utf-8?B?b25mbTJoNUc3YUloUHp1R1pzN0FBS2xUenlhQktCWFdRRjdoQzYyT0l6Wk4v?=
 =?utf-8?B?cTl5aXZoQ3dYSTM4UlRRQlREUW9CekdUaVNKWmhUTGNOb1diY3hpbFVFMFhD?=
 =?utf-8?B?QXY0VlJoUGdML2kxMmUvbFBvc0lsVW8zREpQblFsTlpaUmdzbllaTHRIcDZt?=
 =?utf-8?B?LzcyK0xRcTRjQnFWY3RLY1NTMkFKYTBCRjkwK0tRRGRtemZpVDd0RUFDUlRI?=
 =?utf-8?B?SlhqNVB3UHFjT0l0RXR4cXE3Q0ZZeDNjZjIrMEV3RmJBVlZmYzhwMnZWWUxu?=
 =?utf-8?B?MzNoY1RqcDgxc3JkL1N5K0h3aUtVYW9uckhydkJCbXZvSjNVd2RjMjA1Q09y?=
 =?utf-8?B?M3dlVHJ0SHRrR1p4U0F1dk44MVlmZlVOVldqUzRjWGhOdlBLU3VEM055Nkdt?=
 =?utf-8?B?Q3UxcGdZS2tpZmF4WWVpb2h1WUNSellrUk1ScHFaR3F4U0VaMjFvbG9VMlgw?=
 =?utf-8?B?K1V3ZndHS1JLRW1wbXRQU3hJM29XYkZFa2xBOUZldFR2U3pya1JuZnlHUE8x?=
 =?utf-8?B?MGNxYjk1bXVmdEVyV2pnRkpuNkR5cDR5VTBOVnlNMUpXSCsrL1hkVmF1Slgv?=
 =?utf-8?B?aUR4RFhBM1hTQWNrS09ZdXdBMEFibDZINmJ3U0Y5eXVyTW1oaVgvTmRFRjJl?=
 =?utf-8?B?OU9laEd5UHJuWHhWSkZCeWdNTUo0d3VGZXNwNXpQZGpHZEtVWFVWNFpDTzFZ?=
 =?utf-8?B?dTdLT3g1MUNJcG1vZGlCdHFZK1BJbE1BbWJmckZFWTZ6U3YzYXFIdkZOMExx?=
 =?utf-8?B?SWNVdkxHby9PNzhQYXdGRjlVTUE5TnhZcXJTbXpUVGtrMy93Z1VWOW50V094?=
 =?utf-8?B?VzNWdFJLVG5HQ2xCWkNjM1FYMk1WY1owZE9CdTkvMzhkQjl6cUlWeWNoR1o2?=
 =?utf-8?B?RzNOS0JNNnlGOXdMQS9TTUVFZjBlaXhESkpVNFhSQWQ1eVlWVERBV3NyakR0?=
 =?utf-8?B?ZndvMnJyZUQyb1FzMVFWcjNlUUtwTXZuRHhqUDMwOGdTYWVDNjlRa0hEWTJV?=
 =?utf-8?B?cHBYalBHeXhRdDg3aDNzckNBamFKOVBnK0dFdlB4QzBvSFlUMGdYN3djbW82?=
 =?utf-8?Q?EXRAhmrm/ig6v7ankuU07Pl03?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95be58bf-c24a-4e56-2a9e-08dbc870f3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 02:39:25.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+9B+1ZlSiIM1bORpctkY0OIYHcYQ4p6vkMaq64JqijwA2iDuzID5irAdAH9ItGb02tuRwOP73CZhYgUXRb3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
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

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IC4u
Lg0KPiBPbiBTdW4sIE9jdCAwOCwgMjAyMyBhdCAwNDowMjoyOVBNICswODAwLCBRaXV4dSBaaHVv
IHdyb3RlOg0KPiA+IFdoZW4gdW5sb2FkaW5nIHRoZSBpZ2VuNl9lZGFjIGRyaXZlciwgdGhlIEVE
QUMgY29yZSB3cm9uZ2x5IGtmcmVlZA0KPiA+ICdwdnRfaW5mbywnIHdoaWNoIHdhcyBwcml2YXRl
IGRhdGEgYW5kIG1hbmFnZWQgYnkgdGhlIGlnZW42X2VkYWMNCj4gPiBkcml2ZXIuIFRoaXMgcmVz
dWx0ZWQgaW4gYSBzbGFiLXVzZS1hZnRlci1mcmVlIGJ1Zy4gRml4IGl0IGJ5IGFkZGluZyBhDQo+
ID4gZmxhZyB0byBpbmRpY2F0ZSB3aGV0aGVyICdwdnRfaW5mbycgaXMgbWFuYWdlZCBieSB0aGUg
RURBQyBjb3JlLg0KPiA+IFRoZSBFREFDIGNvcmUgd2lsbCBvbmx5IGtmcmVlICdwdnRfaW5mbycg
d2hlbiB0aGUgZmxhZyBpcyBzZXQgdG8gdHJ1ZS4NCj4gDQo+IFRoYXQncyBiZWNhdXNlIHlvdXIg
c2lsbHkgZHJpdmVyIGlzIHdyb25nbHkgYWxsb2NhdGluZyBzdHVmZjoNCj4gDQo+IGlnZW42X3By
b2JlKCkgYWxsb2NhdGVzIHRoZSB3aG9sZSBwdnQgc3RydWN0IGFuZCB0aGVuDQo+IGlnZW42X3Jl
Z2lzdGVyX21jaSgpIGFzc2lnbnMgaXQgcGllY2UtbWVhbC13aXNlIHRvIGVhY2ggTUMncyAtPnB2
dF9pbmZvLg0KPiANCj4gT24gdGhlIHVucmVnIHBhdGgsIHlvdSB0aGVuIGNhbGwgZWRhY19tY19m
cmVlKCksIGl0IGZyZWVzIC0+bWN0X2luZm8gYW5kIHRoZW4NCj4geW91IGRvIHdvbmRlciB3aHkg
aXQgY29tcGxhaW5zIHdoZW4geW91IGNhbGwga2ZyZWUoaWdlbjZfcHZ0KSBpbg0KPiBpZ2VuNl9y
ZW1vdmUoKS4NCj4gDQo+IFlvdSBzaG91bGQgZG8gdGhlIGV4YWN0IG9wcG9zaXRlIG9mIHRoZSBh
bGxvY2F0aW9uIHN0ZXBzIG9uIHRoZSB1bnJlZyBwYXRoDQo+IGFuZCBpdCdsbCBhbGwgd29yayBm
aW5lLiBEZWZpbml0ZWx5IG5vdCBhZGQgdWdseSBoYWNrcyB0byB0aGUgRURBQyBjb3JlLg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClJlY2hlY2tlZCB0aGUgaWdlbjZfZWRhYyBjb2RlLCBp
dCBoYXMgYWxyZWFkeSBkb25lIHRoZSBleGFjdCBvcHBvc2l0ZSBvZiB0aGUgYWxsb2NhdGlvbiAN
CnN0ZXBzIG9uIHRoZSB1bnJlZyBwYXRjaCBiZWxvdzoNCg0KSW4gdGhlIHJlZyBwYXRoOg0KICBp
Z2VuNl9wcm9iZSgpDQogICAgICBpZ2VuNl9wdnQgPSBremFsbG9jKCkgICAgLy8gU3RlcCBhDQog
ICAgICBpZ2VuNl9yZWdpc3Rlcl9tY2koKQ0KICAgICAgICAgIG1jaSA9IGVkYWNfbWNfYWxsb2Mo
bWMsIEFSUkFZX1NJWkUobGF5ZXJzKSwgbGF5ZXJzLCAwKSAvLyAwIG1lYW5zIGlnZW42IGl0c2Vs
ZiBtYW5hZ2VzICdwdnRfaW5mbycuDQogICAgICAgICAgbWNpLT5wdnRfaW5mbyA9ICZpZ2VuNl9w
dnQtPmltY1ttY107ICANCiAgICAgICAgICBlZGFjX21jX2FkZF9tYyhtY2kpICAgIC8vIFN0ZXAg
Yg0KDQpJbiB0aGUgdW5yZWcgcGF0aDoNCiAgaWdlbjZfcmVtb3ZlKCkNCiAgICAgIGlnZW42X3Vu
cmVnaXN0ZXJfbWNpcygpDQogICAgICAgICAgICBlZGFjX21jX2ZyZWUobWNpKSAgICAgLy8gU3Rl
cCBCDQogICAgICBrZnJlZShpZ2VuNl9wdnQpICAgICAgICAvLyBTdGVwIEENCg0KSSBhc3N1bWUg
dGhhdCB3aGVuIGNhbGxpbmcgZWRhY19tY19hbGxvYygpIHdpdGggc3pfcHZ0PTAsICdwdnRfaW5m
bycgaXMgbWFuYWdlZCANCmJ5IHRoZSBFREFDIGRyaXZlciwgbm90IHRoZSBFREFDIGNvcmUuIFRo
ZXJlZm9yZSwgdGhlIEVEQUMgY29yZSBzaG91bGQgbm90IGtmcmVlIA0KJ3B2dF9pbmZvJyB1bmNv
bmRpdGlvbmFsbHkgaW4gdGhpcyBzY2VuYXJpby4NCg0KU28gdGhlIHByb2JsZW0gb2NjdXJyZWQg
aW4gU3RlcCBCIHdoZW4gdGhlIEVEQUMgY29yZSBtaXN0YWtlbmx5IGtmcmVlZCAncHZ0X2luZm8s
JyANCndoaWNoIHNob3VsZCBoYXZlIGJlZW4ga2ZyZWVkIGluIFN0ZXAgQS4gJ3B2dF9pbmZvJyBp
cyBtYW5hZ2VkIGJ5IHRoZSBpZ2VuNl9lZGFjIA0KZHJpdmVyLCBub3QgdGhlIEVEQUMgY29yZS4N
Cg0KQSBzaW1wbGUgZml4IGlzIHRvIHNldCBtY2ktPnB2dF9pbmZvID0gTlVMTCBqdXN0IGJlZm9y
ZSBTdGVwIEIsIGJ1dCBpdCBtYXkgc2VlbSBhIGJpdCBtYWdpY2FsLg0KDQpTaW1pbGFyIGlzc3Vl
cyBjb3VsZCBhbHNvIG9jY3VyIGluIHRoZSBmb2xsb3dpbmcgZHJpdmVycyB3aGVyZSB0aGUgRURB
QyBjb3JlIHNob3VsZCBOT1Qga2ZyZWVkIHRoZSBwdnRfaW5mbyBhcw0KdGhlc2UgJ3B2dF9pbmZv
JyBhcmUgbWFuYWdlZCBieSB0aGUgc3BlY2lmaWMgRURBQyBkcml2ZXJzIHRoZW1zZWx2ZXMgKHN6
X3B2dCA9IDApLg0KDQogIGRyaXZlcnMvZWRhYy9hbWQ4MTExX2VkYWMuYw0KICAgIGRldl9pbmZv
LT5lZGFjX2Rldi0+cHZ0X2luZm8gPSBkZXZfaW5mbzsNCg0KICBkcml2ZXJzL2VkYWMvY3BjOTI1
X2VkYWMuYw0KICAgIGRldl9pbmZvLT5lZGFjX2Rldi0+cHZ0X2luZm8gPSBkZXZfaW5mbzsNCg0K
ICBkcml2ZXJzL2VkYWMveDM4X2VkYWMuYw0KICAgIG1jaS0+cHZ0X2luZm8gPSB3aW5kb3c7IC8v
IFRoaXMgaXMgZXZlbiBhbiBpb3JlbWFwKCkgbWVtb3J5IGFuZCByZXF1aXJlcyBpb3VubWFwKCkg
dG8gcmVsZWFzZSBpdC4NCg0KLVFpdXh1DQo=
