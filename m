Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB14E787C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjHYACf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjHYACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:02:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA119B4;
        Thu, 24 Aug 2023 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692921736; x=1724457736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V22gGqbR8kaiknRcOPOdSDDGoSYzwH3G9NrayUzZJEE=;
  b=Dtf3DpYMkLVQQXZeeHNfwqal1t+Ve+jmQiN3FCACIh51KbLUkuXSe3QW
   bGT7NUfsHoDRCJBLaupqD/Uh5h23hms/f9nTHh9Y8TJXBGt780FcEcFgE
   FPdWDzxmFwYtBOSIgynAEcb2BPWsU/0zCspPlphSqit3diRPJDNb29g27
   W34dOzvSem1/Y+plPxQz9m2AimvuPLFuDRxPJjwgmzaD3trgalne8qenI
   HLXELZqw7HXvZUACx2gvQQXtNvpH0MxBTLNFL//rYhmiZg54CWwXI00LZ
   +s30h52llkDXdh2ZfwU/fzow47JpfVOSGxDVFtrkdka7beb1sNnV2a4Lr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405591142"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405591142"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 17:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="911096348"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="911096348"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2023 17:02:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 17:02:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 17:02:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 17:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6KlUy1Uw+vF/p0LheCqstZJ64sk4r8Jq6Mys0Z0TF/UPMxFWNTUBE3TVlkQPYKzuHg7FQklFzMDlUA+yWCpRLYxd8Fy0iK/+V/xHcJv4fRj/BBdaANlLoWulyhvp8bTUnaOnivJSVPPITxSOZR6EL1hfh4G2F85JgxifiaaA3YuVdS3vv2lETy7vQm3TaBowsuBrb1KT/yOTF5Jvf+BAw2/H4cFlWQXhLk1loMQ3rDrCGy/AUu/zggJTFH9WltxCNRkraZh6wyo6xi/j78dfq17JgiD713hhnk4Vk0Y3Lj9+/YPKZ+TqzzUWYjfxZu5gRF7kpLRt5fealTKzQNV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V22gGqbR8kaiknRcOPOdSDDGoSYzwH3G9NrayUzZJEE=;
 b=elD6gn1LSEGwO5DsTz0kYBwMUlbUBZp5nsvD3kvVHKZvhxkEfriDI64cNEA3c/gIFHkQAWbilVw8Ak5OjTanJps3KjCwqWRXs1D2Lc94mBUiCxnMQ5+SNhBdPC4C0Nqhi0dxoWWpfQaLouklXBPxxySGcZ7Ki7X9rdMND8WC6LIpiK2/9bdhEo6IxfnvDDHKvQ2U7+6Z8PfENPe30WjS/MXsBpfE4rXJDXjKNmxHtrZtTu9aJXz7NVQDU7EwNKRX0ADysUGDlxeM93EP7ESQyhg0zgFanRrDYJxKUVYCPlnTaxxDiFBEhJVOA/5oTf1k7SgBRFn1JJwroH2okfmdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 00:02:04 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 00:02:04 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZzJW4ijJBPwTw+EyuNab2Xuk8e6/wVjQAgAS3/8CAAGp6gIAEvFUA
Date:   Fri, 25 Aug 2023 00:02:04 +0000
Message-ID: <MWHPR11MB0048EA29C4D2654BF176FAF3A9E3A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-4-utkarsh.h.patel@intel.com>
 <ZN+nXGr3S0OL3Edn@chromium.org>
 <MWHPR11MB0048AF9CAA00D2A57C8CC533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKaeEggChrqkN=izTySLRb75w0qkM1Xbnkyo3ZKVkGnZRTw@mail.gmail.com>
In-Reply-To: <CACeCKaeEggChrqkN=izTySLRb75w0qkM1Xbnkyo3ZKVkGnZRTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|CY8PR11MB6865:EE_
x-ms-office365-filtering-correlation-id: ae25bafb-4481-4d2b-3b55-08dba4fe840c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79/dRpU+KXB6efZoR+AnI7L/6hJ1bzGwdcG1gbSII5IJo04+xQbiT00dALHltjW6EfIsrDpUdK74Y0nZ7qYdVjhqdkHtxFYEQ3DluRCYP208fg8+uqY8tSx30EgGI9kxX8vnpv5ZTsYkYdDeS5vx0Wd5uFb5w7U0rsTEhN1Hqr4CTbeEAn7EAZNsDcqpyN/XRcCiZ2j9Gt1W5KvTB/f9gkf5n1Ib533CUxAHS3rj93clegTVNPtEWhbwtF68vruWGzMD5Y3WWeQhuAJ5iQKYyTSmVVxEHQPh1KnlEd5+loWJjti1eP2P+DDoeXENvoAf4eCSODMaQsgtYp91UXLVGi5jKJwgBX9D9R8ViGTQopQCUvNSVkGfCYnfeTUCE1lMEp80an8jLHrZ7ZMk+tPVKxrA+mM9RRQ+rbZsGpO40tD72zXynzRLjyqxCS/QCF5LQJaBHb0yWnOqS63IsNsR02f1ii6wMF2OhsiletCfmbTZemMwC/WyTGpEc4/XfK2hMltD6DQKYvQjO5++jo3qX1S9Yji2XZQnuV6+MSB6vBvyVnndVHFeizJE2K7uJqzBmMt4e9W19mSK9toP/qoepRJF4QIwYH7D3i+jYhCuO0lg8Bz+6PR6OyAIyyYRrp9ZwRSZwyDHFTSjFvd7EKMW9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(66899024)(64756008)(26005)(83380400001)(9686003)(41300700001)(66946007)(66446008)(66476007)(66556008)(54906003)(2906002)(6916009)(316002)(52536014)(5660300002)(4326008)(8936002)(8676002)(478600001)(71200400001)(6506007)(7696005)(55016003)(76116006)(82960400001)(86362001)(33656002)(122000001)(38100700002)(38070700005)(87944015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXVOc2J0eDBURDNJdGJZbVRjWDJ6N1pnVFFCNkN4Y1ZLQU9oekw0S0JUUlZl?=
 =?utf-8?B?eEV1MVNkTUoyZVp3U2dJOEIxQjNZUXJNQW5Wd29lcnNkdXdsejRYd0h4OEVz?=
 =?utf-8?B?amdvRUp2K2tNdU9maWpmNk94MUFCVy9qV0V6VXA2OU50Y041akhQNzFtUTNq?=
 =?utf-8?B?ZXJKRDR5bWR5V0hSUVVLOWRaWWtXNkx0eWRESWI2L3BjSUtGekEvc25qMjBx?=
 =?utf-8?B?Mmx1TUhkdUZpNlZmV2Y1amNIOXI3VkZ5bUhsRXRuM2huU2N3bGd6YXZDM1g2?=
 =?utf-8?B?UEdIcldDc2c2UnBack5QV0VnK0tkNG9lR3RlSjRaK1prbDlqcWFFU2RSbDdI?=
 =?utf-8?B?a1plck9ES1ZJcGdVTDFoUzhuTlhsV0J0MVdPQjl6VmlxS0hyTEJYeUpsdlA1?=
 =?utf-8?B?RjlZQlBtZ1paZk9LcHd2NDBmZXFmdm5sVDhXVERqRllWT2hrWkQ2RTMvSzlP?=
 =?utf-8?B?T2RlOFNDSjN6V0I5OUhKa3M1bW9xTWRCVzhxMDZCZUdxMExnTkd1MUUvK0gx?=
 =?utf-8?B?T1RvM3dqZkZzZ3Y5ZGIvcUh1dmsrMlE3dDBBM28rczRMeWlkSWVIa3JhSW9I?=
 =?utf-8?B?NzJMaTlEMlVmMTZiVmNCalJiOGt2dzhKUTZFbkJURFZwSEZCZHlwaFBVdjhF?=
 =?utf-8?B?SDhjS0hhaWxLMzNIelNXUnkxbDNZa3paMmEwaXFHOFh5cC9mMUIrdEN3dzdH?=
 =?utf-8?B?WXJjaDVVRlYxRDM5Z1l5T1VGdG9FOVIvUDlWclVISW01Y3F6eUh0cGlSOXpr?=
 =?utf-8?B?aDFKa1o2WWRIdjd3cjcweDZBL0RhYTVXSnZqQzZORnJieVcrTVNxRHVRcEpQ?=
 =?utf-8?B?T2JhQldISUQrandwWTkvM1d0ektDdHVMcGNLSjl5Tjg4empvUlhiTmNiRHkr?=
 =?utf-8?B?RnJIY1FLSW1tR2l3RFY1QVE0OEJ5dmxRQUk2R09GNW4vZGE4MlB6LytadDJZ?=
 =?utf-8?B?bHZBRGpoZ0l0dWlwVVhzekUweWV2U0RkUjZMWlM0QzJRYVVmdHdSQ3REZXRn?=
 =?utf-8?B?QWVwTGdPUjFoMWJpMWl1dkI4K3c2VU9wbi84aFpJWFk4dy9taitmZ2RXTXUr?=
 =?utf-8?B?QktXQ01VR0wvQnpVSVc2SUx4dVZuWjFrc0JZVlVQZU05ZlBzVGIxQXhVMEhP?=
 =?utf-8?B?Z1BMNmlWMUYyWGtUMVlrdlZKM3BCM0ZYU0lHQ0dNdERjOU5lUEp5ZWk4cFJS?=
 =?utf-8?B?cEZpMUtLdWJGemNZa0F5ZmFKNHNFT0NkYnZRSjRnM0t0djhicUI2QWc0QS93?=
 =?utf-8?B?eEZFWWlicXYvYVBFNDAyaWliWEZHcG1jYVUwakxXWCtScXVlbkRXSTZaV2hK?=
 =?utf-8?B?a3ZpMkpJU1RRSnJrOGlEK3Q2QTRXNkNVdHJHVW5BOHlMZTM4ckdwc1d2eHFk?=
 =?utf-8?B?V0d3ZU84UTRxVCs4Sm9oZWRyYnQ4YisvVEROWUJQNENWOFcvN3lGYWVVY2lP?=
 =?utf-8?B?cGdPT243aGgwR20xUjdKbWpTU1I4RUN2YW5qazlNQ0E4L3lzV3hqaFBJZ1JR?=
 =?utf-8?B?R2hNUXNFK0hkamErNUQ5bEROMTcvZVRTRVdZZU1hQWFobnRlcWh2VFk3RURq?=
 =?utf-8?B?bG4xcWZxS2lQMjUrNGY5KzFQVXdJT3FZTm8xSHpodmZ2d1VvR0xyYUg4MU42?=
 =?utf-8?B?c0x5ZnY1LzIxR292SWI5RGZuUC9MWnJ2cEJLVjEyUTJUZHNjeVZndkc1WkhB?=
 =?utf-8?B?N0Jscm9kTlRadkcxZ3pkZHZBYW5XUWhWSWhyUCtrcUFZSkZId2psSm1CVXMy?=
 =?utf-8?B?YXdOa3Nva01pMW1qL1ViWk94a0dMaVFjNjN2RlZSU2hyTnhMMWFpVGVxb0V1?=
 =?utf-8?B?Vkp5U2pmdVdoNXQ4SkhwRWIrTG8waW1rV0dqa1dIRTF0K3lPN3FQNDBJRUxo?=
 =?utf-8?B?Z3d4MW5PY0FRMVBVbncvSGQzWGVqQ0plZ2ZBbk5qV2VJdFVGOVptdCtEbGkw?=
 =?utf-8?B?S094Sm5kY09wUmJiYlRtcGhZbExoaTh1dlVHNm9uOHp3UUVTZG9VTngxc0Nm?=
 =?utf-8?B?b0ZUejNxRU1uMjNGWkVZTzcyRHV2RUhlSmVpdjBGdGFEL3pwdHgzZ1ZMSkMy?=
 =?utf-8?B?RHpGVmthMEw2YTl5SEV5cGpsT0crR0lWdXF6TEJCNzB6cHNXVnpxcGZ5d0JO?=
 =?utf-8?B?dmdvOWk0Nno3OG9WV2I3T2VYd082a21SQS9FNVN5SUVSRG4wMkYvNU1hRVlL?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25bafb-4481-4d2b-3b55-08dba4fe840c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 00:02:04.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIJrQOJEzknfn9T1utv7AZt26QMIrlxF+pQpsEYoOhm5FF33ktP0kF0/1om5qOo8O77VZXmZFrLA+cqXMUU8VBPK5JKLKKr1amwVnNxUhT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNCj4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhlIGNvbmYgVkRP
IGlzIGJlaW5nIHJlY3JlYXRlZCBoZXJlLg0KPiA+ID4gY2FibGVfdmRvIHNob3VsZCBhbHJlYWR5
IGNvbnRhaW4gdGhlIG5lY2Vzc2FyeSBiaXRzLiBKdXN0IHVzZSB0aGUNCj4gPiA+IGNhYmxlX3Zk
byB0aGF0IHlvdSBnZXQgZnJvbSBjcm9zX3R5cGVjX2dldF9jYWJsZV92ZG8oKTsgaXQgd2lsbCBo
YXZlDQo+ID4gPiBhbGwgdGhlIGJpdHMgc2V0IGNvcnJlY3RseSBhbHJlYWR5ICh0aGUgRUMgc2hv
dWxkIGJlIGRvaW5nIHRoYXQpLg0KPiA+ID4NCj4gPiA+IFRoZSAiaWYiIGNvbmRpdGlvbiBzaG91
bGQgYWxzbyBiZSB1bm5lY2Vzc2FyeS4NCj4gPiA+DQo+ID4gPiBZb3UgYXJlIGFscmVhZHkgZG9p
bmcgc29tZXRoaW5nIHNpbWlsYXIgaW4gdGhlIG90aGVyIHBhdGNoIGZvcg0KPiA+ID4gImFjdGl2
ZSByZXRpbWVyIGNhYmxlIHN1cHBvcnQiIFsxXQ0KPiA+DQo+ID4gImlmIiBjb25kaXRpb24gaXMg
bmVjZXNzYXJ5IGJlY2F1c2UgdGhlcmUgYXJlIGNhYmxlcyAoTFJEIEdlbjMpIHdpdGggRFBTSUQN
Cj4gYnV0IGRvZXMgbm90IHN1cHBvcnQgRFBBTSAyLjEgYW5kIGluIHRoYXQgY2FzZSB3ZSBuZWVk
IHRvIGNoZWNrIFRCVFNJRCBvZg0KPiB0aGUgY2FibGUgYW5kIHVzZSB0aGUgY2FibGUgcHJvcGVy
dGllcyBlLmcuIFNQRUVEIGFuZCBUeXBlLg0KPiANCj4gT2ssIHRoZW4gZ3JhYiB0aGUgdHdvIFZE
T3MgZGlzdGluY3RseSAoY2FibGVfZHBfdmRvIGFuZCBjYWJsZV90YnRfdmRvKS4NCj4gQWxzbywg
dGhlIGV4cGxhbmF0aW9uIHlvdSBnYXZlIGFib3ZlIHNlZW1zIGxpa2UgYSBnb29kIGNhbmRpZGF0
ZSBmb3IgYQ0KPiBjb21tZW50IGFib3ZlIHRoZSAiaWYiIGJsb2NrLg0KPiANCj4gPiBTaW5jZSB0
aGF0IGluZm9ybWF0aW9uIGlzIGFscmVhZHkgYXZhaWxhYmxlIGluIHBkX2N0cmwsIHdlIGFyZSBs
ZXZlcmFnaW5nIGl0LiAgSQ0KPiB3aWxsIHJlbW92ZSB0aGUgcGFydCB3aGVyZSBpdCdzIGNoZWNr
aW5nIHJldGltZXIgY2FibGUgYXMgRFAyLjEgaXMgYW55d2F5IG5vdA0KPiBzdXBwb3J0ZWQuDQo+
IA0KPiBBcyBtZW50aW9uZWQgaW4gZWFybGllciBwYXRjaGVzIHJlbGF0ZWQgdG8gdGhpcywgd2Ug
d2FudCB0byBhdm9pZCB1c2luZyBFQy0NCj4gc3BlY2lmaWMgZGF0YSBzdHJ1Y3R1cmVzIGFzIG11
Y2ggYXMgcG9zc2libGUgbW92aW5nIGZvcndhcmQsIGVzcGVjaWFsbHkgaWYgdGhlDQo+IGluZm9y
bWF0aW9uIGNhbiBiZSBnbGVhbmVkIGZyb20gdGhlIGF2YWlsYWJsZSBEaXNjU1ZJRCBWRE9zLiBT
bywgcGxlYXNlIHVzZQ0KPiB0aGUgcmVxdWlyZWQgY2FibGUgVkRPICh3aGV0aGVyIGl0IGlzIERQ
IG9yIFRCVCBTSUQpLg0KDQpBY2suDQoNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgIHBvcnQtPnN0YXRlLmRhdGEgPSAmZHAyMV9kYXRhOw0KPiA+ID4gPiArDQo+ID4gPiA+
ICsgICByZXR1cm4gdHlwZWNfbXV4X3NldChwb3J0LT5tdXgsICZwb3J0LT5zdGF0ZSk7DQo+ID4g
Pg0KPiA+ID4gTm90ZSB0aGF0IG5vdyB5b3UgaGF2ZSByZXZlcnNlZCB0aGUgb3JkZXIgaW4gd2hp
Y2ggdGhlIG11eGVzIGFyZSBzZXQNCj4gPiA+ICh3aGljaCBsZWFkcyB0byBzdWJ0bGUgdGltaW5n
IGlzc3VlcyB3aXRoIEJ1cm5zaWRlIEJyaWRnZSBhbmQgb3RoZXIgc2ltaWxhcg0KPiByZXRpbWVy
cykuDQo+ID4gPiBTbyBwbGVhc2UgZG9uJ3QgZG8gdGhpcy4NCj4gPg0KPiA+IEFyZSB5b3Ugc3Vn
Z2VzdGluZyB0byBhZGQgc2FtZSBvcmRlciBoZXJlPw0KPiANCj4gU3BlY2lmaWNhbGx5LCBicmVh
a2luZyBvdXQgYSBzZXBhcmF0ZSBmdW5jdGlvbiBmb3IgRFAgMi4xIGFuZCB0aGVuIGVtYmVkZGlu
Zw0KPiB0aGF0IGluIHRoZSBvdmVyYWxsIGVuYWJsZV9kcCgpIGZ1bmN0aW9uIG1ha2VzIHRoaW5n
cyB1bm5lY2Vzc2FyaWx5IGNvbXBsZXguDQo+IA0KPiBKdXN0IGNyYWZ0IHRoZSBWRE9zIG9uZXcg
dGltZSwgd2l0aGluIGVuYWJsZV9kcCgpLCBhbmQgdGhlbiB1c2UgdGhlIGV4aXN0aW5nDQo+IGxv
Y2F0aW9ucyB3aGVyZSBjcm9zX3JldGltZXJfc2V0IGFuZCB0eXBlY19tdXhfc2V0KCkgYXJlIGNh
bGxlZC4NCj4gDQo+IFRoaXMgd2lsbCBiZWNvbWUgbW9yZSBjbGVhciBvbmNlIHlvdSByZWJhc2Ug
dGhpcyBjb21taXQgb24gdG9wIG9mIHRoZQ0KPiBjaGFuZ2VzIGluIFsxXQ0KPiANCj4gRWZmZWN0
aXZlbHkgY3Jvc190eXBlY19lbmFibGVfZHAoKSBzaG91bGQgaGFuZGxlIGFsbCBEUCBjYXNlcywg
d2l0aG91dA0KPiBuZWVkaW5nIGEgc3BlY2lhbCBmdW5jdGlvbiBicm9rZW4gb3V0IGZvciBEUCAy
LjENCg0KQWNrLg0KDQo+IA0KPiA+ID4gVGhpcyBlbnRpcmUgZmVhdHVyZSBpc24ndCBuZWNlc3Nh
cnkuIFJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBkcDIuMSBpcw0KPiA+ID4gc3VwcG9ydGVkIG9yIG5v
dCwgdGhlIHBvcnQgZHJpdmVyIGp1c3QgbmVlZHMgdG8gZm9yd2FyZCB0aGUNCj4gPiA+IGNhYmxl
X3ZkbyBpdCByZWNlaXZlcyBmYWl0aGZ1bGx5IHRvIHRoZSBtdXggZHJpdmVyLCB3aGljaCBjYW4g
ZGVhbA0KPiA+ID4gd2l0aCBpbnRlcm5hbCBkZXRhaWxzIChiYXNlZCBvbiB3aGV0aGVyICppdCog
c3VwcG9ydHMgRFAgMi4xIG9yIG5vdCkuDQo+ID4NCj4gPiBJIGFtIE9rYXkgd2l0aCB0aGF0Lg0K
PiA+IFdlIHRob3VnaHQgd2UgY2FuIGF2b2lkIHVubmVjZXNzYXJ5IGNoZWNrIGZvciB0aGUgY2Fi
bGVfdmRvIGZvciBEUA0KPiBhbHRlcm5hdGUgbW9kZSBvbiBwbGF0Zm9ybSB3aGVyZSBEUDIuMSBp
cyBub3Qgc3VwcG9ydGVkLg0KPiBUaGUgb3B0aW1pemF0aW9uIGlzIG1pbmlzY3VsZSBlbm91Z2gg
dG8gbm90IGJlIHdvcnRoIGl0IHRoZSBhZGRlZCBjb2RlDQo+IHZlcmJvc2l0eS4NCg0KQWNrLiBJ
IHdpbGwgcmVtb3ZlIGl0Lg0KDQpTaW5jZXJlbHksDQpVdGthcnNoIFBhdGVsLg0K
