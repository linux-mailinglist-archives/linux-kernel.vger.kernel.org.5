Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCD775251
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHIFos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHIFor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:44:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC71BF0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691559886; x=1723095886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxVqR5JzBclnhNtvrXZDUDwfvW2Hl6BqKNhArJH2UN8=;
  b=oFsffLcAwzJomf1RrAGqeGKVA9fZFSXuJpw6NYSDOLDns0BiRaxAtPkT
   49sxxNBf786xukPPBSdTk2dLK/cPB1MKnfdkNmTXki8tUY7Ok9sbxAlTa
   9PY36PYyilfRH8rvVt2icZD8lI7boe+EdD+GGVULS+fL/8IZv5qzIe4J2
   mSLEOqCR0MfbbuCq4o1v3UNKk0SMEy7Ju3KDkeB3baS+JWjD/rhDSemGK
   KHf0m+KiwmQedI0ODqJ4SeNOP7Yvgrdngi7aN7EYqmiMEAgRoSyE/jDIt
   hidB1zdeKZ7ksmpIpQ/j1RDo9fYeLx9MUNRXwYUWKr0Fe9h4rWLo4EC/p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351336076"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="351336076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 22:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845797617"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="845797617"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 22:44:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:44:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 22:44:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 22:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX4s2oDgG2mQYut6TJ1r6T33bXVdQtiuhPkZODVihZPMCwKsG9cIUxfKeP5AGLydzdR7cSnzsqWgHWD90MOZKCaJKUwcql/rEtZ6sED7zTpbL/nfCnvdnT5I23LGQftiNVwboxBuWIE0wTSsS6Cr/wYVWvh9VVgLIlor7Ea9l+XEmTQGeia9Efij33B/E/bXLDxEfjZ2pVUnWli2SRVGJmpS/PzTqWBnnhNKSWst/bXqmRZ4W6nL1tXKZpLWPDV89pWEKP1agdp30ILzR6UYnbys+SNhvG4+1AOWsL6ZhF/TOZcEsrL5uYv8YHmYdISeQ74b+00Pxcp/TkcuWJ+d6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxVqR5JzBclnhNtvrXZDUDwfvW2Hl6BqKNhArJH2UN8=;
 b=Mx+N4rLBdN1gt1z/fQjuLaC8NGtInjmsngYOzZD+T7LrGSA9/ecIrtPgqdNEMusHpTO/M+aCgRqg71PZTnqnDVHg5TNIgP49/Twc9tmTlgMFKNwKAfNlpnhxLb4M23+9QcYF9EWNIQszFI200rvgCuB75JmVn/RSPN0ayZlr3my5VSaM4QkWzjLLWxUAK1uCwATYqLpJJ06uW8gfpeUpXIk8KM1ijluXSZyxMbVjikihjaGepwIapIwZVYIiPf0VDcDB+3h6IEdZ6J86bARBJpItx9fqSCQ6gsJHM4fg5quzTgmFawSmRpwB4bEU4mUhsUzT1179jixdKdCvw3nAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 05:44:38 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::462e:943:c60a:1fe]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::462e:943:c60a:1fe%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 05:44:37 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Mark TSC reliable
Thread-Topic: [PATCH] x86/tdx: Mark TSC reliable
Thread-Index: AQHZyhS1dQ2+iv/kcUeYZ/+geo5J8a/gowaAgAAu+ICAAJ0YcA==
Date:   Wed, 9 Aug 2023 05:44:37 +0000
Message-ID: <DM8PR11MB5750DEFF988068EFAFE28667E712A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box>
In-Reply-To: <20230808200111.nz74tmschph435ri@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA0PR11MB7210:EE_
x-ms-office365-filtering-correlation-id: 0866f032-cbb6-4680-f178-08db989bb812
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAzI+rmUlJ/TqlTm2w4uM0oTM855UHIROPaE3+itgimozi4JFvYHGjIIQhwgZF5ZEVvRe6KLZk0Vl+W2AQmTf2mUrZSq78s07xaN4oKR6Mu0OcgoUxyGcaO2QaLxmTyAqzWCNk99pcSXFybl5SRANKI1ybZE1MikNnR4jhHtlSdZRUPkffgLrAqEI4RlzRUWnlATH6Kz4J8Eho6qMTTOHqLZ4FqQczAiZG2/rKbfcrYphHRPLOS4MTD2QvBT4a2yoP5BGt7km111zDGXntuSAX/LgDbt0QP2X9v7nTNKbwyO6muOyDkrXMb7hlCjoUZBiQK6KhC4ibhVZY+hqi/xiugc4QI244jqmJC8ccaStPwJI4t9dbSORc4DywSNHzUVUazdNSNoEAeFWXhSdWPeystZ6EMJAmC6ZA98JTojNa3xMU76AwzRQaUW3mBfVxDx7PBGznyo9H8abte001b+cTpwVKoFm+wlEauem3l5IsB02jgTbNjFHBOX7Cjn4Wb6WjmQHLxmJwqpZL2f1sW4AB9DxprY98RuOkSGGbS6lYXCYNewKuHeu8I6xL3iL6YjHEuG+AYm/VrElSEMY9JK7rsM2LayC0Dxd2Yqr/5qR3Ab3ljWYqfkiQd/SNuPUCGlN6a5ncT2M2shnwJfIqhHlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(1800799006)(186006)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(6636002)(4326008)(86362001)(478600001)(8936002)(8676002)(5660300002)(52536014)(41300700001)(55016003)(316002)(110136005)(54906003)(38070700005)(33656002)(2906002)(71200400001)(82960400001)(7696005)(9686003)(966005)(6506007)(26005)(53546011)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZoMDRzM2Y4T3VLM25HekF3QUU5M1RlMDNCdUdZb0t1RE95eGZYbmM5RFhI?=
 =?utf-8?B?RG9IYXhvSGVmdXJ2SlIwMUxvbWtZazhDUnM1ZGs4SUpoVG1LZ1J1TW9tamJP?=
 =?utf-8?B?V296Y3RsZ1l6dC9CVWhpQ0JxR0poTVZVVjIweHFUZ3dUN3lLOWt3RjlNclM3?=
 =?utf-8?B?QVRpcGM3c283ZlpDSG1OajNqVk0xQ1NYNjhTQjJZQU1sN0JWcDlBNjY1WTRZ?=
 =?utf-8?B?OGZ2d3JhMG9FdjNtcUhBRnlkR2FmRk1tT0tYMzZRSVhLUDNReUV2bGlIZGx2?=
 =?utf-8?B?SDk0VndQMjRxK3R3R0tFS1phK2dwZjV0SmQzMVZvSTFjQ0Z3OGg4bHFISjBz?=
 =?utf-8?B?QWN0eVc4NmxMTDZpZjRQM2RDN0gvWURNQTYvL0wvWXU4ZVVETlRGYWZaaDdH?=
 =?utf-8?B?MFV1a211SGh3MUZrZVBsdEUzZDY3bm1UNVlKRHdOUElwczd3bjRmZjdkVzkw?=
 =?utf-8?B?cTJVV1FKWmgydHZoWUVWY3FYNmZjQnlEMlUzS1lRTlJObnJPckJVekhVNzFs?=
 =?utf-8?B?OTVleEZ4NXI2NmxTQmpUb1FFT0V6cXBJdGpodXBxVWZyVEIxdG1EZ1B3L0d0?=
 =?utf-8?B?Vm03TkNRUkVsQmg2emlZdE0rMXRBYStFTFBsQjdyTjhUWFFoT3RPaW1uOW1l?=
 =?utf-8?B?MFQzZkxWeXkrZlY5U21wSldWMG53bjE2QjVTbG9PR2xxMlZrWm12S3ZsOURl?=
 =?utf-8?B?Qmd0MWFuc0phQnFiMlVZU2dncTZ6cmk5WThoVEVVTi8vZnUrUmlUd1h4S2x5?=
 =?utf-8?B?ZjZmUWgrSVBxc3B0NFMwbHR0WTdlSXRaZ3crVGZEYzVNWm80NEdML2tTN0RC?=
 =?utf-8?B?VmxKZExZbVNBTjRDQ0xCRXU3TWNFV1dlODRBNHU2NGk1U0FtY3VieERaT25h?=
 =?utf-8?B?RC9DY0YxOGtRMThnc2FYbnoxVTE0YWg4YTczMVhiSjd5dmJlWEJMenJINmhz?=
 =?utf-8?B?eUhxYWF5MWdJUWpvdzJTOEVwb2hkb2dpdnlTQVBCeTZGa2x5c0F2K3U0NTlq?=
 =?utf-8?B?ekZRR1hjSDhyeHFsQ1cvWUJQemkzYTE4MHFHd09POXdZOHlyUkpzbG9Hc0No?=
 =?utf-8?B?RkpQODAzbS9OWWVuYlhQT1ltZ2svUGdKbXl4SWI1MGpYNk44eGsyUDhtQ1Ev?=
 =?utf-8?B?STdBUFRMNXZsaEVRQVZiZXR0NlFEbEc0aUZjRkRmSFl3TXNPaUZuNjFDYktr?=
 =?utf-8?B?eFFyaG51NzlBckx3OE5NRXh5SUJZcjNiZ3IzU2t4c3pSWjNqcnBtaHJvWlFv?=
 =?utf-8?B?RzFieG5WUms1STFSTFNvN3ovTlBPbVN3M1BnTXpxVXZFaTE1OENtejdlNWFu?=
 =?utf-8?B?WE9LcGdaTFBucE53QktmdlhhQzF0ZS9EeFZEZjdRVTI3S21rMTVVYitvenhU?=
 =?utf-8?B?ZGwza0RmYlhPZ0h0NG1sOWJad3c4dFR6M3JnUTN2MFUwWllJcW9Bd1BoOFcy?=
 =?utf-8?B?WE9wZDZraERMSEIyTTlab3hJSXU0ai9YSElLV2Q1WGJlMEJINzlqcnFSOG1S?=
 =?utf-8?B?Q0VlQWxEVnJpWHR5dHpuVXhMT3BuSjlRWGNHeTNDVm5xd1VTTlpVUUtnN0Rt?=
 =?utf-8?B?cmF0ZFZ6Tmx2WFhCRC84MzhhcGpXSXNEdTEzOUdWdnlrRCt2dXg1V21zZWJB?=
 =?utf-8?B?ZFBJY05VTHdWSlRoNVdCT3NHbm9EVFRjNTdWTGNaSVVhZ0JsbmVxVnIvazdh?=
 =?utf-8?B?TjFOTlB0UTdtL3dyb1BTc0R4RkVlbHFRTTc3OGNMek1sQWlwMWFPRmJvWGRo?=
 =?utf-8?B?UUpGM1V1TElzU3RadnVsbEd3ZTF2TUJMNEV2bUQ4TUtpbnNzM3A1ZXdjb2NJ?=
 =?utf-8?B?ZlV1MFIwMkkrMFU1UFg2L2xWSDdIcTJMaGtNVXpTNWpENUFjQ0tvak9yRFlR?=
 =?utf-8?B?ZGllbFA0d3IvaFc1S1ZmQjJSajlXdElSb3lZbCtUckloRUlDM2NLNkl1MHNY?=
 =?utf-8?B?cGhhdmgyTkZyaXhnTTg2Vi8rR2hObU5lVlRpNmFhdGpSYUtvZVRiaURKZTc1?=
 =?utf-8?B?UDFYaGhoNHozRGRMU0M2dFp0RTg3ZHJ2ZkhQQVdqSE80VGVGQS9SSWVZblhw?=
 =?utf-8?B?aW56OE9HRlo1RGhiSHBzdkZ3SUxqKzE1bjAwRGNrVXVuWEx2ZmI4TVRQb3R1?=
 =?utf-8?Q?nwCDk9NC3clyf8a2xd6Uiu7Wc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0866f032-cbb6-4680-f178-08db989bb812
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 05:44:37.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgzd3RSdA2YyYZXfQd4kVxKBJSJC0XlvXVjk6fcqx91SG4gQgH6uvNcj+r4JXLTszMw0Sq4+slUlR4hy9yZnz4dbZS69XFbX9U0z495DRi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFR1ZSwgQXVnIDA4LCAyMDIzIGF0IDEwOjEzOjA1QU0gLTA3MDAsIERhdmUgSGFuc2Vu
IHdyb3RlOg0KPiA+IE9uIDgvOC8yMyAwOToyMywgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0K
PiA+IC4uLg0KPiA+ID4gT24gdGhlIG90aGVyIGhhbmQsIG90aGVyIGNsb2NrIHNvdXJjZXMgKHN1
Y2ggYXMgSFBFVCwgQUNQSSB0aW1lciwNCj4gPiA+IEFQSUMsIGV0Yy4pIG5lY2Vzc2l0YXRlIFZN
IGV4aXRzIHRvIGltcGxlbWVudCwgcmVzdWx0aW5nIGluIG1vcmUNCj4gPiA+IGZsdWN0dWF0aW5n
IG1lYXN1cmVtZW50cyBjb21wYXJlZCB0byBUU0MuIFRodXMsIHRob3NlIGNsb2NrIHNvdXJjZXMN
Cj4gPiA+IGFyZSBub3QgZWZmZWN0aXZlIGZvciBjYWxpYnJhdGluZyBUU0MuDQo+ID4NCj4gPiBE
byB3ZSBuZWVkIHRvIGRvIGFueXRoaW5nIHRvIF90aG9zZV8gdG8gbWFyayB0aGVtIGFzIHNsaWdo
dGx5IHN0aW5reT8NCg0KSU1PIGZyb20gcHVyZSBzZWN1cml0eSBwb3YgeWVzLiBJdCB3b3VsZCBi
ZSBnb29kIHNlY3VyZSBkZWZhdWx0IHRoYXQgDQpURFggZ3Vlc3RzIChhbmQgb3RoZXIgQ29DbyBn
dWVzdHMgYWxzbykgYXJlIHVzaW5nIG9ubHkgdHJ1c3RlZCBzb3VyY2UgdGltZS4gDQpUaGVyZSBh
cmUgaXNzdWVzIHdpdGggdGhpcyB0aG91Z2ggYW5kIHdvdWxkIG5lZWQgdG8gdW5kZXJzdGFuZCB3
aGVyZQ0KdG8gZHJhdyB0aGUgbGluZS4gVGhpbmdzIGxpa2UgaHBldCBhbmQgc3VjaCB3ZSBob3Bl
ZCB0byBkaXNhYmxlIHZpYQ0KZGV2aWNlIGZpbHRlcmluZy4gRm9yIHNvbWUgb3RoZXIgdGltZSBz
b3VyY2VzIHdlDQpoYXZlIHVzZWQgcGF0Y2hlcyBiZWxvdy4gQnV0IHRoZW4gdGhlcmUgYXJlIHRo
aW5ncyBsaWtlIFJUQyB0aGF0IHdvdWxkDQpiZSBncmVhdCB0byBkaXNhYmxlIGFsc28sIGJ1dCB3
aXRob3V0IGEgcHJvcGVyIHJlbW90ZSB0aW1lIHNlcnZlcg0KdGhhdCBicmVha3MgYW55IGRhdGUv
dGltaW5nIGZvciB0aGUgZ3Vlc3QsIHNvIHdlIGhhdmUgbm90IGRvbmUgaXQNCmFuZCBwcm9iYWJs
eSBzaG91bGQgbm90IGJ5IGRlZmF1bHQsIGJ1dCB3ZSByZWNvbW1lbmQgbm90IHVzaW5nIGl0DQpp
biBkb2NzIHdlIGhhdmU6DQpodHRwczovL2ludGVsLmdpdGh1Yi5pby9jY2MtbGludXgtZ3Vlc3Qt
aGFyZGVuaW5nLWRvY3Mvc2VjdXJpdHktc3BlYy5odG1sI3RzYy1hbmQtb3RoZXItdGltZXJzDQoN
Cj4gDQo+IEkgZG9uJ3Qga25vdyB3aGF0IHRoZSBydWxlcyBoZXJlLiBBcyBmYXIgYXMgSSBjYW4g
c2VlLCBhbGwgb3RoZXIgY2xvY2sNCj4gc291cmNlcyByZWxldmFudCBmb3IgVERYIGd1ZXN0IGhh
dmUgbG93ZXIgcmF0aW5nLiBJIGd1ZXNzIHdlIGFyZSBmaW5lPw0KDQpXaGF0IGFib3V0IGFjcGlf
cG0/IA0KU2VlIHRoaXM6DQpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvdGR4L2NvbW1pdC8wNDU2
OTI3NzJhYjRlZjc1MDYyYTgzY2M2ZTRmZmEyMmNhYjQwMjI2DQoNCj4gDQo+IFRoZXJlJ3Mgbm90
YWJsZSBleGNlcHRpb24gdG8gdGhlIHJhdGluZyBvcmRlciBpcyBrdm1jbG9jayB3aGljaCBpcyBo
aWdoZXINCj4gdGhhbiB0c2MuIEl0IGhhcyB0byBiZSBkaXNhYmxlZCwgYnV0IGl0IGlzIG5vdCBj
bGVhciB0byBtZSBob3cuIFRoaXMgdG9waWMNCj4gaXMgcmVsYXRlZCB0byBob3cgd2UgYXJlIGdv
aW5nIHRvIGZpbHRlciBhbGxvd2VkIGRldmljZXMvZHJpdmVycywgc28gSQ0KPiB3b3VsZCBwb3N0
cG9uZSB0aGUgZGVjaXNpb24gdW50aWwgd2Ugc2V0dGxlIG9uIHdpZGVyIGZpbHRlcmluZyBzY2hl
bWEuDQoNCk9uZSBvcHRpb24gaXMgdG8gaW5jbHVkZSAibm8ta3ZtY2xvY2siIGludG8ga2VybmVs
IGNvbW1hbmQgbGluZSwgd2hpY2gNCmlzIGF0dGVzdGVkLiBBbm90aGVyIG9wdGlvbiBpcyB0byB0
cnkgdG8gZGlzYWJsZSBpdCBleHBsaWNpdGx5LCBsaWtlIHdlIGhhZA0KaW4gcGFzdDogDQpodHRw
czovL2dpdGh1Yi5jb20vaW50ZWwvdGR4L2NvbW1pdC82YjAzNTdmMjExNWMxYmRkMTU4YzBjODgz
NmY0ZjU0MTUxN2JmMzc1DQoNClRoZSBvYnZpb3VzIGlzc3VlcyB3aXRoIGNvbW1hbmQgbGluZSBp
cyB0aGF0IGl0IGlzIGdvaW5nIHRvIDEpIGdyb3cgDQpjb25zaWRlcmFibHkgaWYgd2UgdHJ5IHRv
IGRpc2FibGUgZXZlcnl0aGluZyB3ZSBjYW4gdmlhIGNvbW1hbmQgbGluZQ0KYW5kIDIpIHRoZXJl
IGlzIGEgaGlnaCBjaGFuY2UgdGhhdCBpbiBwcmFjdGljZSBwZW9wbGUgd2lsbCBub3QgdXNlIHNl
Y3VyZSBkZWZhdWx0DQphbmQvb3IgZm9yZ2V0IHRvIHZlcmlmeSB0aGUgY29ycmVjdCBzdGF0dXMg
b2YgY21kIGxpbmUuIEJ1dCB0aGlzIGlzIHRvIGJlDQpleHBlY3RlZCBJIGd1ZXNzIGZvciBhbnkg
c2VjdXJpdHkgbWV0aG9kIHRoYXQgaW52b2x2ZXMgYXR0ZXN0YXRpb24gdW5mb3J0dW5hdGVseS4N
Cg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=
